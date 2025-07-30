*** Settings ***
Resource                        ../resources/common.robot
Resource                        ../tests/adminTabTest.robot                             # Admin Tab
Resource                        ../tests/atsActionsTest.robot                           # ATS Actions
Resource                        ../tests/contactListTest.robot                          # Contact List
Resource                        ../tests/deleteLogsTest.robot                           # Delete Logs
Resource                        ../tests/dragDropTest.robot                             # Drag and Drop
Resource                        ../tests/dummyJobTest.robot                             # Dummy Job
Resource                        ../tests/jobBoardApplicationTest.robot                  # Job Board Application
Resource                        ../tests/jobPortalTest.robot                            # Job Portal
Resource                        ../tests/jobTest.robot      # Job
Resource                        ../tests/placementCreditTest.robot                      # Placement Credit
Resource                        ../tests/resumeParsingTest.robot                        # Resume Parsing
Resource                        ../tests/salesforceTests.robot                          # Salesforce
Resource                        ../tests/shareInterviewsTest.robot                      # Share Interviews
Resource                        ../tests/smsTest.robot      # SMS
Resource                        ../tests/whiteboardTest.robot                           # Whiteboard
Suite Setup                     Setup Browser
Suite Teardown                  End suite



*** Test Cases ***
Run Full Test
    # Execute all test cases

    Home

    # Admin Tab: Test Case 1
    ${status}                   ${value}=                   Run Keyword And Ignore Error                            Admin Tab: Test Case 1
    Run Keyword If              '${status}' == 'PASS'       Log                         Text 'Admin Tab: Test Case 1' was found successfully
    

    # Admin Tab: Test Case 2
    ${status}                   ${value}=                   Run Keyword And Ignore Error                            Admin Tab: Test Case 2
    Run Keyword If              '${status}' == 'PASS'       Log                         Text 'Admin Tab: Test Case 2' was found successfully
    

    # ATS Actions: Test Case 1
    ${status}                   ${value}=                   Run Keyword And Ignore Error                            ATS Actions: Test Case 1
    Run Keyword If              '${status}' == 'PASS'       Log                         Text 'ATS Actions: Test Case 1' was found successfully
    
    
    # ATS Actions: Test Case 2
    ${status}                   ${value}=                   Run Keyword And Ignore Error                            ATS Actions: Test Case 2
    Run Keyword If              '${status}' == 'PASS'       Log                         Text 'ATS Actions: Test Case 2' was found successfully

    # ATS Actions: Test Case 3
    ${status}                   ${value}=                   Run Keyword And Ignore Error                            ATS Actions: Test Case 3
    Run Keyword If              '${status}' == 'PASS'       Log                         Text 'ATS Actions: Test Case 3' was found successfully

    # ATS Actions: Test Case 4
    ${status}                   ${value}=                   Run Keyword And Ignore Error                            ATS Actions: Test Case 4
    Run Keyword If              '${status}' == 'PASS'       Log                         Text 'ATS Actions: Test Case 4' was found successfully
    
    # Contact List: Test Case 1
    ${status}                   ${value}=                   Run Keyword And Ignore Error                            Contact List: Test Case 1
    Run Keyword If              '${status}' == 'PASS'       Log                         Text 'Contact List: Test Case 1' was found successfully
    
    # Contact List: Test Case 2
    ${status}                   ${value}=                   Run Keyword And Ignore Error                            Contact List: Test Case 2
    Run Keyword If              '${status}' == 'PASS'       Log                         Text 'Contact List: Test Case 2' was found successfully

    # Delete Logs: Test Case 1
    ${status}                   ${value}=                   Run Keyword And Ignore Error                            Delete Logs: Test Case 1
    Run Keyword If              '${status}' == 'PASS'       Log                         Text 'Delete Logs: Test Case 1' was found successfully
    
    # Delete Logs: Test Case 2
    ${status}                   ${value}=                   Run Keyword And Ignore Error                            Delete Logs: Test Case 2
    Run Keyword If              '${status}' == 'PASS'       Log                         Text 'Delete Logs: Test Case 2' was found successfully

    # Delete Logs: Test Case 3
    ${status}                   ${value}=                   Run Keyword And Ignore Error                            Delete Logs: Test Case 3
    Run Keyword If              '${status}' == 'PASS'       Log                         Text 'Delete Logs: Test Case 3' was found successfully

    # Drag and Drop: Test Case 1
    ${status}                   ${value}=                   Run Keyword And Ignore Error                            Drag and Drop: Test Case 1
    Run Keyword If              '${status}' == 'PASS'       Log                         Text 'Drag and Drop: Test Case 1' was found successfully

    # Dummy Job: Test Case 1
    ${status}                   ${value}=                   Run Keyword And Ignore Error                            Dummy Job: Test Case 1
    Run Keyword If              '${status}' == 'PASS'       Log                         Text 'Dummy Job: Test Case 1' was found successfully
    
    # Job Board Application: Test Case 1
    ${status}                   ${value}=                   Run Keyword And Ignore Error                            Job Board Application: Test Case 1
    Run Keyword If              '${status}' == 'PASS'       Log                         Text 'Job Board Application: Test Case 1' was found successfully
    
    # Job Portal: Test Case 1
    ${status}                   ${value}=                   Run Keyword And Ignore Error                            Job Portal: Test Case 1
    Run Keyword If              '${status}' == 'PASS'       Log                         Text 'Job Portal: Test Case 1' was found successfully
    
    # Job Portal: Test Case 2
    ${status}                   ${value}=                   Run Keyword And Ignore Error                            Job Portal: Test Case 2
    Run Keyword If              '${status}' == 'PASS'       Log                         Text 'Job Portal: Test Case 2' was found successfully
    
    # Job Portal: Test Case 3
    ${status}                   ${value}=                   Run Keyword And Ignore Error                            Job Portal: Test Case 3
    Run Keyword If              '${status}' == 'PASS'       Log                         Text 'Job Portal: Test Case 3' was found successfully
    
    # Job: Test Case 1
    ${status}                   ${value}=                   Run Keyword And Ignore Error                            Job: Test Case 1
    Run Keyword If              '${status}' == 'PASS'       Log                         Text 'Job: Test Case 1' was found successfully

    # Job: Test Case 2
    ${status}                   ${value}=                   Run Keyword And Ignore Error                            Job: Test Case 2
    Run Keyword If              '${status}' == 'PASS'       Log                         Text 'Job: Test Case 2' was found successfully

    # Job: Test Case 3
    ${status}                   ${value}=                   Run Keyword And Ignore Error                            Job: Test Case 3
    Run Keyword If              '${status}' == 'PASS'       Log                         Text 'Job: Test Case 3' was found successfully

    # Placement Credit: Test Case 1
    ${status}                   ${value}=                   Run Keyword And Ignore Error                            Placement Credit: Test Case 1
    Run Keyword If              '${status}' == 'PASS'       Log                         Text 'Placement Credit: Test Case 1' was found successfully

    # Resume Parsing: Test Case 1   
    ${status}                   ${value}=                   Run Keyword And Ignore Error                            Resume Parsing: Test Case 1
    Run Keyword If              '${status}' == 'PASS'       Log                         Text 'Resume Parsing: Test Case 1' was found successfully
    
    # Resume Parsing: Test Case 2 
    ${status}                   ${value}=                   Run Keyword And Ignore Error                            Resume Parsing: Test Case 2 
    Run Keyword If              '${status}' == 'PASS'       Log                         Text 'Resume Parsing: Test Case 2 ' was found successfully
    
    # Salesforce: Test Case 1
    ${status}                   ${value}=                   Run Keyword And Ignore Error                            Salesforce: Test Case 1
    Run Keyword If              '${status}' == 'PASS'       Log                         Text 'Salesforce: Test Case 1' was found successfully

    # Salesforce: Test Case 2
    ${status}                   ${value}=                   Run Keyword And Ignore Error                            Salesforce: Test Case 2
    Run Keyword If              '${status}' == 'PASS'       Log                         Text 'Salesforce: Test Case 2' was found successfully

    # Salesforce: Test Case 3
    ${status}                   ${value}=                   Run Keyword And Ignore Error                            Salesforce: Test Case 3
    Run Keyword If              '${status}' == 'PASS'       Log                         Text 'Salesforce: Test Case 3' was found successfully

    # Salesforce: Test Case 4
    ${status}                   ${value}=                   Run Keyword And Ignore Error                            Salesforce: Test Case 4
    Run Keyword If              '${status}' == 'PASS'       Log                         Text 'Salesforce: Test Case 4' was found successfully

    # Salesforce: Test Case 5
    ${status}                   ${value}=                   Run Keyword And Ignore Error                            Salesforce: Test Case 5
    Run Keyword If              '${status}' == 'PASS'       Log                         Text 'Salesforce: Test Case 5' was found successfully

    # Salesforce: Test Case 6
    ${status}                   ${value}=                   Run Keyword And Ignore Error                            Salesforce: Test Case 6
    Run Keyword If              '${status}' == 'PASS'       Log                         Text 'Salesforce: Test Case 6' was found successfully

    # Salesforce: Test Case 7
    ${status}                   ${value}=                   Run Keyword And Ignore Error                            Salesforce: Test Case 7
    Run Keyword If              '${status}' == 'PASS'       Log                         Text 'Salesforce: Test Case 7' was found successfully

    # Salesforce: Test Case 8
    ${status}                   ${value}=                   Run Keyword And Ignore Error                            Salesforce: Test Case 8
    Run Keyword If              '${status}' == 'PASS'       Log                         Text 'Salesforce: Test Case 8' was found successfully
    
    # Salesforce: Test Case 9
    ${status}                   ${value}=                   Run Keyword And Ignore Error                            Salesforce: Test Case 9
    Run Keyword If              '${status}' == 'PASS'       Log                         Text 'Salesforce: Test Case 9' was found successfully
    
    # Salesforce: Test Case 10
    ${status}                   ${value}=                   Run Keyword And Ignore Error                            Salesforce: Test Case 10
    Run Keyword If              '${status}' == 'PASS'       Log                         Text 'Salesforce: Test Case 10' was found successfully
    
    # Salesforce: Test Case 11
    ${status}                   ${value}=                   Run Keyword And Ignore Error                            Salesforce: Test Case 11
    Run Keyword If              '${status}' == 'PASS'       Log                         Text 'Salesforce: Test Case 11' was found successfully

    # Salesforce: Test Case 12
    ${status}                   ${value}=                   Run Keyword And Ignore Error                            Salesforce: Test Case 12
    Run Keyword If              '${status}' == 'PASS'       Log                         Text 'Salesforce: Test Case 12' was found successfully

    # Salesforce: Test Case 13
    ${status}                   ${value}=                   Run Keyword And Ignore Error                            Salesforce: Test Case 13
    Run Keyword If              '${status}' == 'PASS'       Log                         Text 'Salesforce: Test Case 13' was found successfully

    # Salesforce: Test Case 14
    ${status}                   ${value}=                   Run Keyword And Ignore Error                            Salesforce: Test Case 14
    Run Keyword If              '${status}' == 'PASS'       Log                         Text 'Salesforce: Test Case 14' was found successfully

    # Share Interviews: Test Case 1
    ${status}                   ${value}=                   Run Keyword And Ignore Error                            Share Interviews: Test Case 1
    Run Keyword If              '${status}' == 'PASS'       Log                         Text 'Share Interviews: Test Case 1' was found successfully

    # Share Interviews: Test Case 2
    ${status}                   ${value}=                   Run Keyword And Ignore Error                            Share Interviews: Test Case 2
    Run Keyword If              '${status}' == 'PASS'       Log                         Text 'Share Interviews: Test Case 2' was found successfully

    # SMS: Test Case 1
    ${status}                   ${value}=                   Run Keyword And Ignore Error                            SMS: Test Case 1
    Run Keyword If              '${status}' == 'PASS'       Log                         Text 'SMS: Test Case 1' was found successfully

    # Whiteboard: Test Case 1
    ${status}                   ${value}=                   Run Keyword And Ignore Error                            Whiteboard: Test Case 1
    Run Keyword If              '${status}' == 'PASS'       Log                         Text 'Whiteboard: Test Case 1' was found successfully
    
    ...                         ELSE                        Log                         Failed to find all test cases.



    # Admin Tab: Test Case 1      # Admin Tab
    # Admin Tab: Test Case 2      # Admin Tab

    # ATS Actions: Test Case 1    # ATS Actions
    # ATS Actions: Test Case 2    # ATS Actions
    # ATS Actions: Test Case 3    # ATS Actions
    # ATS Actions: Test Case 4    # ATS Actions

    # Contact List: Test Case 1                               # Contact List
    # Contact List: Test Case 2                               # Contact List

    # Delete Logs: Test Case 1    # Delete Logs
    # Delete Logs: Test Case 2    # Delete Logs
    # Delete Logs: Test Case 3    # Delete Logs

    # Drag and Drop: Test Case 1                              # Drag and Drop

    # Dummy Job: Test Case 1      # Dummy Job

    # Job Board Application: Test Case 1                      # Job Board Application

    # Job Portal: Test Case 1     # Job Portal
    # Job Portal: Test Case 2     # Job Portal
    # Job Portal: Test Case 3     # Job Portal

    # Job: Test Case 1            # Job
    # Job: Test Case 2            # Job
    # Job: Test Case 3            # Job

    # Placement Credit: Test Case 1                           # Placement Credit

    # Resume Parsing: Test Case 1                             # Resume Parsing
    # Resume Parsing: Test Case 2                             # Resume Parsing

    # Salesforce: Test Case 1     # Salesforce
    # Salesforce: Test Case 2     # Salesforce
    # Salesforce: Test Case 3     # Salesforce
    # Salesforce: Test Case 4     # Salesforce
    # Salesforce: Test Case 5     # Salesforce
    # Salesforce: Test Case 6     # Salesforce
    # Salesforce: Test Case 7     # Salesforce
    # Salesforce: Test Case 8     # Salesforce
    # Salesforce: Test Case 9     # Salesforce
    # Salesforce: Test Case 10    # Salesforce
    # Salesforce: Test Case 11    # Salesforce
    # Salesforce: Test Case 12    # Salesforce
    # Salesforce: Test Case 13    # Salesforce
    # Salesforce: Test Case 14    # Salesforce

    # Share Interviews: Test Case 1                           # Share Interviews
    # Share Interviews: Test Case 2                           # Share Interviews

    # SMS: Test Case 1            # SMS

    # Whiteboard: Test Case 1     # Whiteboard




#     *** Keywords ***

# Handle Login Failure
#     Capture Page Screenshot
#     Log                         Login failed, screenshot captured.                      WARN
#     # Optional: you can raise an error to fail the test
#     Fail                        Login attempt failed.


    # Execute all test cases

    # TRY
    #                           Log                         Trying risky operation
    #                           Admin Tab: Test Case 1
    # EXCEPT                    Exception as e
    #                           # Handle the exception
    #                           Log                         Error occurred
    #                           Capture Page Screenshot
    # FINALLY
    #                           Close Browser
    # END

    # ${status}=                Run Keyword And Return Status                           Admin Tab: Test Case 1
    # Run Keyword If            not ${status}               Handle Login Failure

    # ${result}=                Run Keyword And Ignore Error                            Do Something Risky
    # Run Keyword If            '${result[0]}' != 'PASS'    Handle Error

    #                           try {
    #                           // Perform operations that might throw errors
    #                           let result = someRiskyOperation();
    #                           return result;
    #                           } catch (error) {
    #                           // Handle and log the error
    #                           console.error('An error occurred: ' + error.message);

    #                           // You can also use Copado's result object for structured error reporting
    #                           result.error = error.message;
    #                           result.success = false;
    #                           return result;
    # }
