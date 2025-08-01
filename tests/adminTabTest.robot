*** Settings ***
Resource                        ../resources/common.robot
Suite Setup                     Setup Browser
Suite Teardown                  End Suite



*** Keywords ***

Admin Tab: Test Case 1
# Verify that user is able to view the other sub tabs on admin tab after the permissions are generated at the "Generate permission set" tab.
# https://asymbl.testrail.io/index.php?/tests/view/69981

    Home
    Tab ATS Admin Tab
    Generate Permission Sets
    ClickText                   Job Object Mapping
    VerifyText                  Job Object Mapping
    ClickText                   Job Board Application Mapping
    VerifyText                  Job Board Application Mapping
    ClickText                   Placement Credit
    VerifyText                  Placement Credit
    ClickText                   Contact List Setup
    VerifyText                  Contact List Setup
    ClickText                   Template Setup
    VerifyText                  Template Setup
    ClickText                   Job & Contact Filters
    VerifyText                  Job & Contact Filters
    ClickText                   ATS Generic Setting
    VerifyText                  ATS Generic Setting
    ClickText                   Integration Setup
    VerifyText                  Integration Setup
    ClickText                   Job Board Filters
    VerifyText                  Job Board Filters


Admin Tab: Test Case 2
# Verify User is able to save changed value in fields of ATS Generic settings.
# https://asymbl.testrail.io/index.php?/tests/view/70022

    Home
    # CreateAccount
    # ATS Generic Settings Sub Tab on Admin Tab
    Contact List Setup Sub Tab on Admin Tab
    Template Setup Sub Tab on Admin Tab
    # Job Board Application Mapping Sub Tab on Admin Tab
    # Textkenel Parsing Mapping












    # ClickText                 ATS Generic Setting
    # ClickText                 Save
    # VerifyText                Successfully updated the value of the default burden %
    # Sleep                     2
    # ClickElement              xpath=(//*[@class="slds-checkbox_faux"])[1]
    # VerifyText                Candidate Pool Batch is turned ON/OFF successfully.
    # Sleep                     2
    # ClickElement              xpath=(//*[@class="slds-checkbox_faux"])[1]
    # VerifyText                Candidate Pool Batch is turned ON/OFF successfully.
    # Sleep                     2
    # ClickElement              xpath=//div[@class="slds-tabs_card slds-m-horizontal_medium slds-m-top_small"]//div[1]//lightning-layout-item[5]//button[1]
    # VerifyText                Successfully updated the Candidate Pool Account Name
    # # ClickText               close icon
    # TypeText                  Select an Account           tes
    # ClickText                 ans_test acc_1
    # ClickElement              xpath=//div[@class="slds-tabs_card slds-m-horizontal_medium slds-m-top_small"]//div[2]//lightning-layout-item[5]//button[1]
    # VerifyText                Successfully updated the Account Reference
    # ClickElement              xpath=//button[text()[contains(.,"Schedule")]]
    # ClickText                 Save                        anchor=Cancel
    # VerifyText                Apex Jobs Scheduled Successfully
    # ClickElement              xpath=//*[@name="contactListTab"]
    # ClickText                 Details                     anchor=Skip to Navigation
    # ClickElement              xpath=(//lightning-layout-item[4]//button[1])[2]
    # VerifyText                Successfully updated the Candidate Contact List Default Tab
    # Sleep                     2
    # ClickText                 Details                     anchor=3
    # ClickText                 Resume                      anchor=Skip to Navigation
    # ClickElement              xpath=(//lightning-layout-item[4]//button[1])[2]
    # VerifyText                Successfully updated the Candidate Contact List Default Tab
    # Sleep                     2
    # ClickText                 Resume                      anchor=3
    # ClickText                 Related                     anchor=Skip to Navigation
    # ClickElement              xpath=(//lightning-layout-item[4]//button[1])[2]
    # VerifyText                Successfully updated the Candidate Contact List Default Tab
    # VerifyText                Successfully updated the Candidate Contact List Default Tab
    # ClickElement              xpath=(//*[@class="slds-checkbox_faux"])[2]
    # VerifyText                JBA to Contact conversion status updated successfully.
    # ClickElement              xpath=(//*[@class="slds-checkbox_faux"])[2]
    # VerifyText                JBA to Contact conversion status updated successfully.
    # ClickElement              xpath=(//*[@class="slds-checkbox_faux"])[3]
    # VerifyText                Rejection reason field updated successfully.
    # ClickElement              xpath=(//*[@class="slds-checkbox_faux"])[3]
    # VerifyText                Rejection reason field updated successfully.
    # ClickElement              xpath=//div[6]//lightning-layout-item[5]//button[1]
    # VerifyText                URL saved successfully
