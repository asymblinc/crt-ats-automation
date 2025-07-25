*** Settings ***
Documentation                   Example resource file with custom keywords. NOTE: Some keywords below may need
...                             minor changes to work in different instances.
Library                         QForce
Library                         QVision
Library                         String
Library                         QWeb
Library                         QImage
Library                         BuiltIn                     # Importing the BuiltIn library
Suite Setup                     OpenBrowser                 about:blank                 chrome



*** Variables ***
# IMPORTANT: Please read the readme.txt to understand needed variables and how to handle them!!
${BROWSER}                      chrome
${username}                     jkukreja+asymbltesting@asymbl.com
${login_url}                    https://login.salesforce.com                            # Salesforce instance. NOTE: Should be overwritten in CRT variables
${home_url}                     ${login_url}/lightning/setup/SetupOneHome/home
${NUMBER_OF_CONTACTS}           3



*** Keywords ***
Setup Browser
    # Setting search order is not really needed here, but given as an example
    # if you need to use multiple libraries containing keywords with duplicate names
    Set Library Search Order    QForce                      QWeb
    Open Browser                about:blank                 ${BROWSER}
    SetConfig                   LineBreak                   ${EMPTY}                    #\ue000
    Evaluate                    random.seed()               random                      # initialize random generator
    SetConfig                   DefaultTimeout              45s                         #sometimes salesforce is slow
    # adds a delay of 0.3 between keywords. This is helpful in cloud with limited resources.
    SetConfig                   Delay                       0.3


End suite
    Close All Browsers


Login
    [Documentation]             Login to Salesforce instance. Takes instance_url, username and password as
    ...                         arguments. Uses values given in Copado Robotic Testing's variables section by default.
    [Arguments]                 ${sf_instance_url}=${login_url}                         ${sf_username}=${username}                              ${sf_password}=${password}
    GoTo                        ${sf_instance_url}
    TypeText                    Username                    ${sf_username}              delay=1
    TypeSecret                  Password                    ${sf_password}
    ClickText                   Log In

    # We'll check if variable ${secret} is given. If yes, fill the MFA dialog.
    # If not, MFA is not expected.
    # ${secret} is ${None} unless specifically given.
    ${MFA_needed}=              Run Keyword And Return Status                           Should Not Be Equal         ${None}                     ${secret}
    Run Keyword If              ${MFA_needed}               Fill MFA                    ${sf_username}              ${secret}                   ${sf_instance_url}


Login As
    [Documentation]             Login As different persona. User needs to be logged into Salesforce with Admin rights
    ...                         before calling this keyword to change persona.
    ...                         Example:
    ...                         LoginAs                     Chatter Expert
    [Arguments]                 ${persona}
    ClickText                   Setup
    ClickItem                   Setup                       delay=1
    SwitchWindow                NEW
    TypeText                    Search Setup                ${persona}                  delay=2
    ClickElement                //*[@title\="${persona}"]                               delay=2                     # wait for list to populate, then click
    VerifyText                  Freeze                      timeout=45                  # this is slow, needs longer timeout
    ClickText                   Login                       anchor=Freeze               partial_match=False         delay=1


Fill MFA
    [Documentation]             Gets the MFA OTP code and fills the verification dialog (if needed)
    [Arguments]                 ${sf_username}=${username}                              ${mfa_secret}=${secret}     ${sf_instance_url}=${login_url}
    ${mfa_code}=                GetOTP                      ${sf_username}              ${mfa_secret}               ${login_url}
    TypeSecret                  Verification Code           ${mfa_code}
    ClickText                   Verify


Refresh
    Execute Javascript          window.location.reload(true);


Home
    [Documentation]             Example appstarte: Navigate to homepage, login if needed
    GoTo                        ${home_url}
    ${login_status} =           IsText                      To access this page, you have to log in to Salesforce.                              2
    Run Keyword If              ${login_status}             Login
    Sleep                       3
    ${session_end}=             Is Text                     Your session has ended
    Run Keyword If              ${session_end}              Refresh
    Sleep                       3
    ${session_end}=             Is Text                     Your session has ended
    Run Keyword If              ${session_end}              Refresh
    #ClickText                  Home
    #VerifyTitle                Home | Salesforce


    # Example of custom keyword with robot fw syntax. NOTE: These keywords may need to be adjusted
    # to work in your environment
VerifyStage
    [Documentation]             Verifies that stage given in ${text} is at ${selected} state; either selected (true) or not selected (false)
    [Arguments]                 ${text}                     ${selected}=true
    VerifyElement               //a[@title\="${text}" and (@aria-checked\="${selected}" or @aria-selected\="${selected}")]


VerifyStageColor
    [Documentation]             Example keyword on how to verify background color of element.
    ...                         Note that this keyword might need adjusting in your instance (colors and locators can be different)
    [Arguments]                 ${stage_text}               ${color}=navy
    &{COLORS}=                  Create Dictionary           navy=rgba(1, 68, 134, 1)    green=rgba(59, 167, 85, 1)

    ${elem}=                    GetWebElement               ${stage_text}               element_type=item
    ${background_color}=        Evaluate                    $elem.value_of_css_property("background-color")
    Should Be Equal             ${COLORS.${color}}          ${background_color}         msg=Error: Background color ( ${background_color}) differs from ${color} (${COLORS.${color}})


NoData
    VerifyNoText                ${data}                     timeout=3                   delay=2


DeleteAccounts
    [Documentation]             RunBlock to remove all data until it doesn't exist anymore
    ClickText                   ${data}
    ClickText                   Delete
    VerifyText                  Are you sure you want to delete this account?
    ClickText                   Delete                      2
    VerifyText                  Undo
    VerifyNoText                Undo
    ClickText                   Accounts                    partial_match=False


DeleteLeads
    [Documentation]             RunBlock to remove all data until it doesn't exist anymore
    ClickText                   ${data}
    ClickText                   Delete
    VerifyText                  Are you sure you want to delete this lead?
    ClickText                   Delete                      2
    VerifyText                  Undo
    VerifyNoText                Undo
    ClickText                   Leads                       partial_match=False


CustomLogin    #Created as an alternate to Home function
    Open Browser                about:blank                 ${BROWSER}
    GoTo                        https://login.salesforce.com/
    TypeText                    Username                    jkukreja+asymbltesting@asymbl.com
    TypeSecret                  Password                    123@Asymbl
    ClickText                   Log In


    Home
    LaunchApp                   Jobs
    ClickText                   MeghaSharma_23/04/2025_001
    DragDrop                    locator=(//li[@class="slds-item cardBackgroundColor applicantActive"])[1]           target_locator=Interview Round 2 (0/0)



    ClickText                   Cancel                      anchor=Skip Email
    ClickText                   Confirm


#==========================================================================================================================

# ASYMBL ATS BASE FUNCTIONS

CreateContact Goya Killa

    ${random_suffix}=           Generate Random String      5
    ${random_2}=                Generate Random String      4                           [NUMBERS]

    Launch Contacts
    Button New
    PickList                    Salutation                  Mr.
    TypeText                    First Name                  Goya
    TypeText                    Last Name                   Killa ${random_suffix}
    TypeText                    Mobile                      777777${random_2}
    TypeText                    Email                       Killa_${random_suffix}@mailinator.com
    ComboBox                    Search Accounts...          Account                     index=2
    Button Save


CreateContact
    Home
    Launch Contacts
FOR    ${index}    IN RANGE    1    ${NUMBER_OF_CONTACTS}+1
    ${random_suffix}=           Generate Random String      5                           [LETTERS]                   # Generates a random string of 5 letters

    Button New
    UseModal                    On
    PickList                    Salutation                  Mr.
    TypeText                    First Name                  Contact
    TypeText                    Last Name                   ${random_suffix}
    TypeText                    Email                       test_${random_suffix}@mailinator.com
    UseModal                    On
    Sleep                       1
    ClickText                   Account Name
    ClickText                   New Account                 anchor=Recent Accounts
    VerifyText                  Account Information
    TypeText                    Account Name*               Account_${random_suffix}
    ClickText                   Save                        anchor=Account Information
    #UseModal                   off
    VerifyText                  New Contact
    Sleep                       1
    Button Save
    UseModal                    off
    VerifyText                  Related
    ClickText                   Details
    VerifyField                 Name                        Contact ${random_suffix}    partial_match=True
    ClickText                   Contacts                    # Navigate back to Contacts to start the next iteration
END


CreateAccount
    ${random_suffix}=           Generate Random String      5                           [LETTERS]                   # Generates a random string of 5 letters

    Launch Accounts
    Button New
    ClickText                   Next
    TypeText                    *Account Name               Test Account_${random_suffix} CRT
    Button Save
    ClickText                   Details
    VerifyField                 Account Name                Test Account_${random_suffix} CRT                       partial_match=True


Template Assignment Criteria

    ClickText                   Select a field.             anchor=Job Object
    ClickText                   Job Name                    anchor=Filter Criteria
    ClickText                   Select an Option            anchor=Operator
    ClickText                   Contains                    anchor=Job Object
    TypeText                    Value                       test
    Button Save
    VerifyCheckboxValue         Active                      on


CreateATStemplate
    Home
    ${random_suffix}=           Generate Random String      5                           [LETTERS]                   # Generates a random string of 5 letters

    Launch ATS Templates
    Button New
    UseModal                    On
    TypeText                    *ATS Template Name          ATS template_${random_suffix}
    TypeText                    Priority                    0
    Button Save
    UseModal                    Off
    ClickText                   New Stage
    TypeText                    *ATS Template Stage Name    S1
    TypeText                    *Sequence                   1
    ClickCheckbox               Interview Stage             on
    ClickText                   Select Stage Type           anchor=Stage Type
    ClickText                   Application                 anchor=*Sequence
    ClickText                   Save & New
    TypeText                    *ATS Template Stage Name    S2
    TypeText                    *Sequence                   2
    ClickText                   Select Stage Type           anchor=Stage Type
    ClickText                   Internal Review             anchor=*Sequence
    ClickCheckbox               Block Multiple Candidates                               on
    ClickText                   Save & New
    TypeText                    *ATS Template Stage Name    S3
    TypeText                    *Sequence                   3
    ClickText                   Select Stage Type           anchor=Stage Type
    ClickText                   Offer                       anchor=*Sequence
    Button Save
    Template Assignment Criteria


Create ATS Template with Multiple actions
    Home
    ${random_suffix}=           Generate Random String      5
    Launch ATS Templates
    Button New
    UseModal                    On
    TypeText                    *ATS Template Name          ATS template_${random_suffix}
    TypeText                    Priority                    0
    Button Save
    UseModal                    Off
    ClickText                   New Stage
    TypeText                    *ATS Template Stage Name    S1
    TypeText                    *Sequence                   1
    ClickCheckbox               Interview Stage             on
    ClickText                   Select Stage Type           anchor=Stage Type
    ClickText                   Application                 anchor=*Sequence
    ClickText                   Save & New
    TypeText                    *ATS Template Stage Name    S2
    TypeText                    *Sequence                   2
    ClickText                   Select Stage Type           anchor=Stage Type
    ClickText                   Internal Review             anchor=*Sequence
    ClickCheckbox               Block Multiple Candidates                               on
    ClickText                   Save & New
    TypeText                    *ATS Template Stage Name    S3
    TypeText                    *Sequence                   3
    ClickText                   Select Stage Type           anchor=Stage Type
    ClickText                   Offer                       anchor=*Sequence
    Button Save

    ClickElement                xpath=(//*[@data-key="chevronright"])[1]
    ClickElement                xpath=(//*[@icon-name="utility:new"])[1]
    ClickElement                xpath=//*[@placeholder="Select Action..."]
    ClickText                   Flow
    ClickElement                xpath=//*[@data-key="save"]

    ClickElement                xpath=(//*[@icon-name="utility:new"])[1]
    ClickElement                xpath=//*[@placeholder="Select Action..."]
    ClickText                   Create a Record
    ClickElement                xpath=//*[@data-key="save"]

    Template Assignment Criteria


Create a Job

    Home
    ${random_suffix}=           Generate Random String      5                           [LETTERS]                   # Generates a random string of 5 letters

    Launch Jobs
    Button New
    UseModal                    On
    TypeText                    *Job Name                   Uni_${random_suffix}        timeout=30
    PickList                    Status                      Open
    PickList                    Type                        Permanent
    TypeText                    Job Title                   Title_test_${random_suffix}
    ComboBox                    Search Accounts...          Account                     index=2
    TypeText                    Start Date                  10/15/2024
    TypeText                    Fixed Fee                   105

    TypeText                    Number of Openings          5
    TypeText                    Openings Filled             1
    Button Save


Create a Job, check for template assigned, add candidate to job.
    Home
    ${random_suffix}=           Generate Random String      5                           [LETTERS]                   # Generates a random string of 5 letters

    Launch Jobs
    Button New
    UseModal                    On
    TypeText                    *Job Name                   Job_test_${random_suffix}                               timeout=30
    PickList                    Status                      Open
    PickList                    Type                        Permanent
    TypeText                    Job Title                   Title_test_${random_suffix}
    ComboBox                    Search Accounts...          Account                     index=2
    TypeText                    Start Date                  10/15/2024
    TypeText                    Fixed Fee                   105

    TypeText                    Number of Openings          5
    TypeText                    Openings Filled             1
    Button Save
    VerifyText                  Select All

    Launch Contacts
    UseTable                    Name
    ClickCell                   r2/c2
    ClickCell                   r3/c2
    ClickText                   Show more actions
    ClickText                   Add to ATS
    #TypeText                   Select a Job                Job_test_${random_suffix}
    #ClickText                  Job_test_${random_suffix}
    VerifyText                  Create Applicants           timeout=30

    #Typing in Select a Job field, then clicking on Job
    Sleep                       2
    TypeText                    Select a Job                Job_test_${random_suffix}
    # ClickText                 Job_test_${random_suffix}
    # TypeText                  Select a Job                Job_test_${random_suffix} ${SPACE}
    # Sleep                     2
    # ClickText                 Job_test_${random_suffix}                               anchor=Permanent

    # #Not using below combobox keyword anymore due to change in field functionality. Results from searching for Job includes a number in parenthesis after, therefore original job text cannot be found
    # ComboBox                  Select a Job                Job_test_${random_suffix}                               partial_match=true
    # ClickText                 Job_test_${random_suffix}

    # ClickText                 Create Applicants
    # VerifyText                2 applicant(s) have been successfully added to this job.
    # Sleep                     3
    Launch Jobs
    ClickText                   Job_test_${random_suffix}


Create a multiple (50) contacts, add candidate to job
    Home
    ${NUMBER_OF_RECORDS}        Set Variable                10                          # Define the number of records to create
    Launch Contacts

    FOR                         ${index}                    IN RANGE                    1                           ${NUMBER_OF_RECORDS}+1
        ${random_suffix}=       Generate Random String      5                           [LETTERS]                   # Generate a unique identifier
        ${contact_name}=        Set Variable                Contact_${index}_${random_suffix}

        # Click 'New' button to create a new Contact
        Button New
        UseModal                On

        # Fill in Contact Details
        PickList                Salutation                  Mr.
        TypeText                First Name                  Contact_${index}
        TypeText                Last Name                   ${random_suffix}
        TypeText                Email                       test_${index}_${random_suffix}@mailinator.com

        # # Create a New Account if needed
        # UseModal              On
        # Sleep                 1
        # ClickText             Account Name
        # ClickText             New Account                 anchor=Recent Accounts
        # VerifyText            Account Information
        # TypeText              Account Name*               Account_${index}_${random_suffix}
        # ClickText             Save                        anchor=Account Information
        # ClickText             Save
        # Button Save

        # Save Contact
        Button Save
        Sleep                   1                           # Wait for contact to be saved
        UseModal                Off                         # Close modal

        # Verify Contact was created
        VerifyText              Contact_${index}            partial_match=True

        # Navigate back to Contacts list (if required)
        ClickText               Contacts

    END

    ${random_suffix}=           Generate Random String      5                           [LETTERS]                   # Generate a unique identifier
    Launch Contacts
    UseTable                    Name
    ClickText                   Recently Viewed
    ClickText                   All Contacts
    # Sleep                     3
    # ClickElement              xpath=//div[@class="uiScroller scroller-wrapper scroll-bidirectional native"]
    # Sleep                     1
    # Press Key                 //body                      PAGE_UP
    ClickCheckbox               Name                        On
    ClickText                   Show more actions
    ClickText                   Add to ATS

    TypeText                    Select a Job                Test Job
    ClickText                   3 Jan Test Job (07022)
    # #TypeText                 Select a Job                Job_test_${random_suffix}
    # #ClickText                Job_test_${random_suffix}
    # VerifyText                Create Applicants           timeout=30

    # #Typing in Select a Job field, then clicking on Job
    # Sleep                     2
    # TypeText                  Select a Job                Job_test_${random_suffix}
    # # TypeText                Select a Job                Job_test_${random_suffix} ${SPACE}
    # Sleep                     2
    # ClickText                 Job_test_${random_suffix}                               anchor=Permanent

    #Not using below combobox keyword anymore due to change in field functionality. Results from searching for Job includes a number in parenthesis after, therefore original job text cannot be found
    # ComboBox                  Select a Job                Job_test_${random_suffix}                               partial_match=true
    # ClickText                 Job_test_${random_suffix}

    ClickText                   Create Applicants
    # VerifyText                2 applicant(s) have been successfully added to this job.
    Sleep                       3
    Launch Jobs

    ClickText                   Jobs
    # TypeText                  Search this list...         3 Jan Test Job
    TypeText                    Search this list...         3 Jan Test Job\n
    ClickText                   3 Jan Test Job
    # ClickText                 Job_test_${random_suffix}


Create Contact list Candidate
    Home
    CreateContact Goya Killa
    ${random_suffix}=           Generate Random String      5
    Launch Contactlist
    Button New
    TypeText                    *Name                       Contactlist Candidate_${random_suffix}
    ClickText                   Select an Option            anchor=*Type
    ClickText                   Candidate                   anchor=*Name
    ClickText                   Created Date
    ClickText                   Move to Selected Fields     anchor=Move selection to Selected Fields
    Button Save
    VerifyText                  Candidate
    ClickText                   Add Contacts                timeout=30
    UseModal                    On
    Sleep                       2
    TypeText                    Select a Contact            Goya Kill
    PressKey                    Select a Contact            a
    Sleep                       1
    ClickText                   Goya Killa
    Button Save
    UseModal                    Off


Create Contact list Client
    Home
    CreateContact Goya Killa
    ${random_suffix}=           Generate Random String      5
    Launch Contactlist
    Button New
    TypeText                    *Name                       Contactlist Client_${random_suffix}
    ClickText                   Select an Option            anchor=*Type
    ClickText                   Client                      anchor=*Name
    ClickText                   Created Date
    ClickText                   Move to Selected Fields     anchor=Move selection to Selected Fields
    Button Save
    VerifyText                  Client
    ClickText                   Add Contacts                timeout=30
    UseModal                    On
    Sleep                       2
    TypeText                    Select a Contact            Goya Kill
    PressKey                    Select a Contact            a
    Sleep                       1
    ClickText                   Goya Killa
    Button Save
    UseModal                    Off


Create Interview Template
    Home
    ${random_suffix}=           Generate Random String      5
    Launch Interview Templates

    Button New
    TypeText                    *Template Name              Interview template$_${random_suffix}
    TypeText                    *Priority                   1
    TypeText                    Number of Stages            2
    ClickText                   Created Date
    ClickText                   Move to Visible Fields      anchor=Move selection to Visible Fields

    TypeText                    Type topic here...          test topic 1
    # ClickElement              xpath= //body/div[@class='desktop container forceStyle oneOne navexDesktopLayoutContainer lafAppLayoutHost forceAccess']/div[@class='viewport']/section[@class='layoutContent stage panelSlide']/div[@class='none navexStandardManager']/div[@class='fullheight center oneCenterStage mainContentMark']/div[@role='main']/div[@class='contentArea fullheight']/div[@id='brandBand_2']/div[@class='slds-template__container']/div[@class='center oneCenterStage lafSinglePaneWindowManager']/div[@class='windowViewMode-normal oneContent active lafPageHost']/div[@class='overridePresent inlinePanel oneRecordActionWrapper']/div[@class='actionBody']/section[@role='dialog']/div[@class='slds-modal__container']/div[@id='modal-content-id-1']/bpats-ats-new-interview-template/div[@class='slds-is-relative slds-card']/div/div[@class='create-topics-custom-css slds-p-left_xx-large slds-m-top_small']/lightning-icon[@title='save']/span[@part='boundary']/lightning-primitive-icon[1]//*[name()='svg']
    ClickElement                xpath=(//lightning-icon[contains(@title,"save")]/span[contains(@part,"boundary")]/lightning-primitive-icon[1]//*[name()="svg"])[1]
    TypeText                    Type topic here...          test topic 2
    # ClickElement              xpath= //body/div[@class='desktop container forceStyle oneOne navexDesktopLayoutContainer lafAppLayoutHost forceAccess']/div[@class='viewport']/section[@class='layoutContent stage panelSlide']/div[@class='none navexStandardManager']/div[@class='fullheight center oneCenterStage mainContentMark']/div[@role='main']/div[@class='contentArea fullheight']/div[@id='brandBand_2']/div[@class='slds-template__container']/div[@class='center oneCenterStage lafSinglePaneWindowManager']/div[@class='windowViewMode-normal oneContent active lafPageHost']/div[@class='overridePresent inlinePanel oneRecordActionWrapper']/div[@class='actionBody']/section[@role='dialog']/div[@class='slds-modal__container']/div[@id='modal-content-id-1']/bpats-ats-new-interview-template/div[@class='slds-is-relative slds-card']/div/div[@class='create-topics-custom-css slds-p-left_xx-large slds-m-top_small']/lightning-icon[@title='save']/span[@part='boundary']/lightning-primitive-icon[1]//*[name()='svg']
    ClickElement                xpath=(//lightning-icon[contains(@title,"save")]/span[contains(@part,"boundary")]/lightning-primitive-icon[1]//*[name()="svg"])[1]
    TypeText                    Type option here...         feedback 1
    ClickElement                xpath= //div[@class='slds-is-relative slds-card']//div//div//div[@class='create-topics-custom-css slds-p-left_xx-large slds-m-top_small']//lightning-primitive-icon[@exportparts='icon']//*[name()='svg']
    TypeText                    Type option here...         feedback 2
    ClickElement                xpath= //div[@class='slds-is-relative slds-card']//div//div//div[@class='create-topics-custom-css slds-p-left_xx-large slds-m-top_small']//lightning-primitive-icon[@exportparts='icon']//*[name()='svg']

    Button Save
    VerifyText                  Interview Template has been created.
    Template Assignment Criteria


Create Placement Credit Templates
    Home
    Launch Placement Credit Templates
    Button New
    UseModal                    On
    TypeText                    *Placement Credit Template Name                         Test Placement Credit Template CRT
    TypeText                    Priority                    1
    Button Save
    UseModal                    Off
    VerifyText                  Placement Credit Template "Test Placement Credit Template CRT" was created.

    ClickText                   Select a Name               anchor=*
    ClickText                   Sales Credit                anchor=Skip to Navigation
    ClickText                   User Field                  anchor=*
    ClickElement                xpath=(//*[@placeholder="Select a field"])[1]
    ClickText                   ATS_Job__c
    ClickElement                xpath=(//*[@placeholder="Select a field"])[1]
    ClickText                   Created By ID
    TypeText                    *                           11
    ClickElement                xpath=//lightning-icon[@title="new"]//*[name()="svg"]
    ClickText                   Select a Name               anchor=*
    ClickText                   Recruiter Credit            anchor=Skip to Navigation
    ClickElement                xpath=(//*[@data-value="User Field"])[2]
    ClickText                   Branch                      anchor=Skip to Navigation
    ClickElement                xpath=(//*[@placeholder="Select a field"])[1]
    ClickText                   Branch__c
    ClickElement                xpath=(//*[@placeholder="Select a field"])[1]
    ClickText                   Branch Name
    TypeText                    *                           12
    ClickElement                xpath=//lightning-icon[@title="new"]//*[name()="svg"]
    ClickText                   Select a Name               anchor=*
    ClickText                   Account Manager             anchor=Skip to Navigation
    ClickElement                xpath=(//*[@data-value="User Field"])[2]
    ClickText                   House                       anchor=Skip to Navigation
    TypeText                    *                           13
    # ClickElement              xpath=//lightning-icon[@title="new"]//*[name()="svg"]
    # ClickText                 Select a Name               anchor=*
    # ClickText                 Branch Credit               anchor=Skip to Navigation
    # ClickElement              xpath=(//*[@data-value="User Field"])[2]
    # ClickText                 User Lookup                 anchor=Skip to Navigation
    # TypeText                  Select a User               admin
    # ClickElement              xpath=//div[contains(@data-name,"Release Admin")]
    # TypeText                  *                           14
    Button Save
    VerifyText                  Placement Credit Entries has been saved successfully.

    ClickText                   Select a field.             anchor=Job Object
    ClickText                   Job Name                    anchor=Skip to Navigation
    ClickText                   Select an Option            anchor=Operator
    ClickText                   Contains                    anchor=Skip to Navigation
    TypeText                    Enter a value               test
    ClickText                   Save                        anchor=Template Assignment Criteria


Create Placement both Conversion and Permanent Amount
    Home
    ${random_suffix}=           Generate Random String      5
    Launch Placements
    Button New
    TypeText                    *Placement Name             Test Placement CRT Both
    ComboBox                    Search Jobs...              Job_test
    ComboBox                    Search Contacts...          Goya Killa
    ClickText                   Conversion Profit Amount
    TypeText                    Conversion Profit Amount    1120
    ClickText                   Permanent Profit Amount
    TypeText                    Permanent Profit Amount     1000
    # ClickElement              xpath=//*[@placeholder="Search Branches..."]
    # ClickText                 New Branch                  anchor=Recent Branches
    # TypeText                  Branch Name*                Test Branch ${random_suffix}
    # Button Save
    # UseModal                  Off
    Button Save
    UseModal                    Off
    VerifyText                  Placement "Test Placement CRT Both" was created.
    VerifyText                  Both fields which are mapped to Permanent Profit Amount and Conversion Profit Amount are populated. In this case Conversion Profit Amount will be considered for the Placement Credit Calculation


Create Placement Conversion Amount
    Home
    ${random_suffix}=           Generate Random String      5
    Launch Placements
    Button New
    TypeText                    *Placement Name             Test Placement CRT Conversion
    ComboBox                    Search Jobs...              Job_test
    ComboBox                    Search Contacts...          Goya Killa
    ClickText                   Conversion Profit Amount
    TypeText                    Conversion Profit Amount    1120
    # ClickElement              xpath=//*[@placeholder="Search Branches..."]
    # ClickText                 New Branch                  anchor=Recent Branches
    # TypeText                  Branch Name*                Test Branch ${random_suffix}
    # Button Save
    # UseModal                  Off
    Button Save
    UseModal                    Off
    VerifyText                  Placement "Test Placement CRT Conversion" was created.


Create Placement Permanent Amount
    Home
    ${random_suffix}=           Generate Random String      5
    Launch Placements
    Button New
    TypeText                    *Placement Name             Test Placement CRT Permanent
    ComboBox                    Search Jobs...              Job_test
    ComboBox                    Search Contacts...          Goya Killa
    ClickText                   Permanent Profit Amount
    TypeText                    Permanent Profit Amount     1000
    # ClickElement              xpath=//*[@placeholder="Search Branches..."]
    # ClickText                 New Branch                  anchor=Recent Branches
    # TypeText                  Branch Name*                Test Branch ${random_suffix}
    # Button Save
    # UseModal                  Off
    Button Save
    UseModal                    Off
    VerifyText                  Placement "Test Placement CRT Permanent" was created.


Generate Permission Sets
    Home
    ClickText                   Generate Permission Sets
    ClickText                   Update Permissions
    VerifyText                  The Permission Set has been updated successfully.
    ClickText                   Update Permissions
    VerifyText                  The Permission Set has been updated successfully.


Dummy Job Mapping
    Home
    Tab ATS Admin Tab
    ClickText                   Job Object Mapping
    ClickText                   Job                         anchor=*
    ClickText                   Dummy Job                   anchor=Skip to Navigation
    ClickElement                xpath=(//span[@class="slds-truncate"][normalize-space()="Select an existing custom field"])[1]
    ClickElement                xpath=(//*[@data-value="bpats_testing__ATS_Template__c"])[2]
    ClickElement                xpath=(//span[@class="slds-truncate"][normalize-space()="Select an existing custom field"])[1]
    ClickElement                xpath=//*[@data-value="bpats_testing__Is_Closed__c"]
    ClickElement                xpath=(//span[@class="slds-truncate"][normalize-space()="Select an existing custom field"])[1]
    ClickElement                xpath=(//*[@data-value="bpats_testing__Dummy_Job__c"])[2]
    ClickElement                xpath=(//span[@class="slds-truncate"][normalize-space()="Select an existing custom field"])[1]
    ClickElement                xpath=(//*[@data-value="bpats_testing__Dummy_Job__c"])[3]
    ClickCheckbox               Show API Names              on
    ClickCheckbox               Show API Names              off
    ClickText                   Save
    VerifyText                  Mapping Saved Successfully


Dummy Job Mapping Release
    Home
    Tab ATS Admin Tab
    ClickText                   Job Object Mapping
    ClickText                   Job                         anchor=*
    ClickText                   Custom Job                  anchor=Skip to Navigation
    ClickElement                xpath=(//span[@class="slds-truncate"][normalize-space()="Select an existing custom field"])[1]
    ClickElement                xpath=//*[@data-value="ATS_Template__c"]
    ClickElement                xpath=(//span[@class="slds-truncate"][normalize-space()="Select an existing custom field"])[1]
    ClickElement                xpath=//*[@data-value="Is_Closed__c"]
    ClickElement                xpath=(//span[@class="slds-truncate"][normalize-space()="Select an existing custom field"])[1]
    ClickElement                xpath=(//*[@data-value="Custom_Job__c"])[2]
    ClickElement                xpath=(//span[@class="slds-truncate"][normalize-space()="Select an existing custom field"])[1]
    ClickElement                xpath=(//*[@data-value="Custom_Job__c"])[3]
    ClickCheckbox               Show API Names              on
    ClickCheckbox               Show API Names              off
    ClickText                   Save
    VerifyText                  Mapping Saved Successfully


Placement Credit Mapping
    Home
    Tab ATS Admin Tab
    ClickText                   Placement Credit            partial_match=False
    # ClickText                 Select an existing custom field                         anchor=*
    # ClickElement              xpath=//*[@data-value="Permanent_Profit_Amount__c"]
    # VerifyText                Mapping Saved Successfully
    # ClickText                 Select an existing custom field                         anchor=*
    # ClickElement              xpath=(//*[@data-value="Conversion_Profit_Amount__c"])[2]
    # VerifyText                Mapping Saved Successfully


Contact List Mass Action Setup
    Home
    Tab ATS Admin Tab
    ClickText                   Contact List Setup
    ClickText                   Mass Action
    # ClickText                 close icon
    VerifyText                  Candidate
    ClickElement                xpath=(//*[@data-key="new"])[1]
    TypeText                    Select an action            BG Flow CRT
    ClickText                   Flow

    ClickText                   Copy Actions to Client
    ClickText                   Proceed
    VerifyText                  All ATS Actions from Candidate have been loaded to Client Successfully


    # VerifyText                Client
    # ClickElement              xpath=(//*[@data-key="new"])[2]
    # TypeText                  Select an action            BG Flow CRT
    # ClickText                 Flow
    ClickText                   Save
    VerifyText                  Mass Action Saved Successfully


Custom Job Template Assignment Criteria

    ClickText                   Select a field.             anchor=Job Object
    ClickText                   Job Name                    anchor=Filter Criteria
    ClickText                   Select an Option            anchor=Operator
    ClickText                   Contains                    anchor=Job Object
    TypeText                    Value                       test
    Button Save
    VerifyCheckboxValue         Active                      on


Textkenel Parsing Mapping
    Home
    Tab Resume Mapping
    ClickElement                xpath=//span[@class="slds-checkbox_faux"]
    VerifyText                  TK Integration is turned ON/OFF successfully
    VerifyText                  Show API Name

    VerifyText                  *Account Name
    TypeText                    *Account Name               tksf_blueprintpro_demo_cv

    VerifyText                  *End Point URL
    TypeText                    *End Point URL              https://ushome.textkernel.com/match/soap/extract?wsdl

    VerifyText                  *Username
    TypeText                    *Username                   extract_json

    VerifyText                  *Password
    TypeText                    *Password                   3+jwJ|[!)U:T

    Button Save
    VerifyText                  Resume Mapping Saved Successfully

    Press Key                   //body                      PAGE_UP
    ClickElement                xpath=(//span[@class="slds-truncate"][normalize-space()="Select an Option"])[1]
    ClickElement                xpath=(//*[@title="Education History"])[2]
    ClickText                   Select a Field              anchor=*
    ClickElement                xpath=(//*[@title="Contact"])[2]
    ClickText                   Select a Field              anchor=*
    ClickElement                xpath=//*[@title="Type"]

    ClickElement                xpath=(//span[@class="slds-truncate"][normalize-space()="Select an Option"])[1]
    ClickElement                xpath=(//*[@title="Skill"])[2]
    ClickText                   Select a Field              anchor=*
    ClickElement                xpath=(//*[@title="Contact"])[4]
    ClickText                   Select a Field              anchor=*
    ClickElement                xpath=//*[@title="Skill Type"]

    ClickElement                xpath=(//span[@class="slds-truncate"][normalize-space()="Select an Option"])[1]
    ClickElement                xpath=(//*[@title="Work History"])[4]
    ClickText                   Select a Field              anchor=*
    ClickElement                xpath=(//*[@title="Contact"])[6]
    Press Key                   //body                      PAGE_UP
    ClickElement                xpath=(//span[@class="slds-checkbox_faux"])[2]
    Press Key                   //body                      PAGE_DOWN
    Button Save
    VerifyText                  Resume Mapping Saved Successfully


Textkenel Parsing Mapping Incorrect Credentials
    Home
    Tab Resume Mapping
    ClickElement                xpath=//span[@class="slds-checkbox_faux"]
    VerifyText                  TK Integration is turned ON/OFF successfully
    VerifyText                  Show API Name

    VerifyText                  *Account Name
    TypeText                    *Account Name               tksf_blueprintpro_demo_cv_incorrect

    VerifyText                  *End Point URL
    TypeText                    *End Point URL              https://ushome.textkernel.com/match/soap/extract?wsdl

    VerifyText                  *Username
    TypeText                    *Username                   extract_json_incorrect

    VerifyText                  *Password
    TypeText                    *Password                   3+jwJ|[!)U:Tincorrect

    Button Save
    VerifyText                  Resume Mapping Saved Successfully


Job Board New
    Home
    ${random_suffix}=           Generate Random String      5
    LaunchApp                   Job Board Applications
    ClickText                   New
    UseModal                    On
    TypeText                    First Name                  Test
    TypeText                    Last Name                   JBA CRT${random_suffix}
    TypeText                    Mobile Phone                1234567890
    TypeText                    Email                       testjobanew$+{random_suffix}@gmail.com
    ComboBox                    Search Jobs...              Associate Test Engg
    ClickText                   Save                        partial_match=False
    UseModal                    Off
    ClickFieldValue             Job
    ClickText                   Job Board Applicants
    ClickText                   Other Applied Jobs
    ClickText                   Identified Contacts
    ClickText                   Applicant Detail
    ClickText                   Resume
    ClickElement                xpath=//div[@class="content-grid record-details slds-p-vertical_small slds-p-horizontal_medium select-record"]//button[@type="button"]
    ClickText                   Discard
    ClickText                   Confirm
    ClickElement                xpath=//button[normalize-space()="Confirm"]
    VerifyText                  The Applicant has been discarded successfully


ATS Generic Settings Sub Tab on Admin Tab
    Home
    Tab ATS Admin Tab
    ClickText                   ATS Generic Setting
    VerifyText                  10
    ClickElement                xpath=(//*[@class="slds-checkbox_faux"])[1]
    Sleep                       1
    ClickElement                xpath=(//*[@class="slds-checkbox_faux"])[1]
    VerifyText                  Candidate Pool
    ClickText                   close icon
    TypeText                    Select an Account           Test Account CRT
    ClickText                   Test Account CRT
    ClickElement                xpath=//button[text()[contains(.,"Schedule")]]
    ClickText                   Save                        anchor=Cancel
    VerifyText                  Metadata updated successfully! Scheduling has been completed.
    ClickElement                xpath=(//*[@class="slds-checkbox_faux"])[2]
    Sleep                       1
    ClickElement                xpath=(//*[@class="slds-checkbox_faux"])[3]
    Sleep                       1
    ClickElement                xpath=(//*[@class="slds-checkbox_faux"])[4]
    Sleep                       1
    ClickElement                xpath=(//*[@class="slds-checkbox_faux"])[4]
    # VerifyText                  https://bpats-staging-dev-ed.my.site.com/asymbljobportal/s/externalinterviewfeedback
    ClickElement                xpath=//*[@name="InterviewScheduleFilter"]
    ClickText                   As soon as the record gets created    anchor=Skip to Navigation
    ClickElement                xpath=//*[@name="InterviewScheduleFilter"]
    ClickText                   As the interview gets done    anchor=Skip to Navigation
    ClickElement                xpath=//*[@name="InterviewScheduleFilter"]
    ClickText                   Custom    anchor=Skip to Navigation
    ClickElement                xpath=//*[@name="InterviewScheduleFilter"]
    ClickText                   As soon as the record gets created    anchor=Skip to Navigation
    ClickText                   Save
    VerifyText                  Metadata record updated successfully.


Contact List Setup Sub Tab on Admin Tab
    Home
    Tab ATS Admin Tab
    ClickText                   Contact List Setup
    ClickElement                xpath=//*[@name="contactListTab"]
    ClickText                   Details                     anchor=Skip to Navigation
    ClickElement                xpath=//*[@name="contactListTab"]
    ClickText                   Resume                      anchor=Skip to Navigation
    ClickElement                xpath=//*[@name="contactListTab"]
    ClickText                   Related                     anchor=Skip to Navigation
    ClickElement                xpath=//*[@name="contactListTab"]
    ClickText                   Details                     anchor=Skip to Navigation
    ClickText                   Load Default Configuration
    ClickText                   Save
    VerifyText                  Configurations saved successfully


Template Setup Sub Tab on Admin Tab
    Home
    Tab ATS Admin Tab
    ClickText                   Template Setup
    ClickText                   Export / Import ATS Data
    VerifyText                  Export / Import ATS Data
    ClickText                   Back to ATS Admin Tab
    ClickText                   Sync Templates with Jobs
    VerifyText                  Batch job started with Id
    ClickText                   Show menu
    ClickText                   Load Default Configuration
    ClickText                   Save
    VerifyText                  Configurations saved successfully


Job Board Application Mapping Sub Tab on Admin Tab
    Home
    Tab ATS Admin Tab
    ClickText                   Job Board Application Mapping
    ClickText                   Contact Mapping
    VerifyText                  First Name
    VerifyText                  Last Name
    VerifyText                  Email
    VerifyText                  Mobile Phone
    ClickElement                xpath=//lightning-combobox[@class="mapping-input-section slds-form-element"]//div[@class="slds-combobox_container"]
    ClickText                   Candidate                   anchor=Skip to Navigation
    ClickText                   Save
    VerifyText                  Mapping saved successfully.
    ClickElement                xpath=//lightning-combobox[@class="mapping-input-section slds-form-element"]//div[@class="slds-combobox_container"]
    ClickText                   Client                      anchor=Skip to Navigation
    ClickText                   Save
    VerifyText                  Mapping saved successfully.
    ClickText                   ATS Applicant Mapping
    ClickText                   Save


#==========================================================================================================================

# ASYMBL ATS BUTTONS

Button Save
    ClickText                   Save                        partial_match=False

Button New
    ClickText                   New                         partial_match=False

Button Cancel
    ClickText                   Cancel                      partial_match=False

Button ManageApplicants
    ClickText                   Manage Applicants

ManageApplicants split view
    Button ManageApplicants
    ClickElement                xpath= //div[contains(@class,'windowViewMode-normal oneContent active lafPageHost')]//button[contains(@value,'Kanban View')]
    ClickText                   Split View

ManageApplicants list view
    Button ManageApplicants
    ClickElement                xpath= //div[contains(@class,'windowViewMode-normal oneContent active lafPageHost')]//button[contains(@value,'Kanban View')]
    ClickText                   List View

ManageApplicants kanban view
    Button ManageApplicants
    ClickElement                xpath= //div[contains(@class,'windowViewMode-normal oneContent active lafPageHost')]//button[contains(@value,'Kanban View')]
    ClickText                   Kanban View


#==========================================================================================================================

# ASYMBL ATS Apps

Launch Home
    LaunchApp                   Home

Launch Contactlist
    LaunchApp                   Contact Lists

Launch Contacts
    LaunchApp                   Contacts

Launch Jobs
    LaunchApp                   Jobs

Launch ATS templates
    LaunchApp                   ATS Templates

Launch Accounts
    LaunchApp                   Accounts

Launch ATS Logs
    LaunchApp                   ATS Logs

Launch Interview Templates
    LaunchApp                   Interview Templates

Launch Whiteboard
    Launch Jobs
    ClickText                   Whiteboard

Launch Placement Credit Templates
    LaunchApp                   Placement Credit Templates

Launch Placements
    LaunchApp                   Placements

Launch ATS Actions
    LaunchApp                   ATS Actions

Launch ATS Applicants
    LaunchApp                   ATS Applicants


#==========================================================================================================================

# ASYMBL ATS tabs

Tab ATS Admin Tab
    LaunchApp                   Asymbl ATS Setup
    ClickText                   Asymbl ATS Admin Tab        timeout=20

Tab Log Service Setup   
    Tab ATS Admin Tab
    ClickText                   Log Service Setup           timeout=20

Tab ATS Generic Setting
    Tab ATS Admin Tab
    ClickText                   ATS Generic Setting         timeout=20

Tab Contact List Setup
    Tab ATS Admin Tab
    ClickText                   Contact List Setup          timeout=20

Tab Mass Action
    Tab Contact List Setup
    ClickText                   Mass Action                 timeout=20

Tab Job & Contact Filters
    Tab ATS Admin Tab
    ClickText                   Job & Contact Filters       timeout=20

Tab Job Board Application Mapping
    Tab ATS Admin Tab
    ClickText                   Job Board Application Mapping                           timeout=20

Tab Resume Mapping
    Tab Job Board Application Mapping
    ClickText                   Resume Mapping

Tab Job Board Filters
    Tab ATS Admin Tab
    ClickText                   Job Board Filters           timeout=20

Tab Message Stats
    Tab ATS Admin Tab
    LaunchApp                   Message Stats               timeout=20

Tab Integration Setup
    Tab ATS Admin Tab
    LaunchApp                   Integration Setup           timeout=20


#==========================================================================================================================

# ASYMBL List View

View All Logs
    ClickText                   Select a List View: ATS Logs
    ClickText                   All
View All Jobs
    ClickText                   Select a List View: Jobs
    ClickText                   All
