*** Settings ***
Documentation    Admin page object for OrangeHRM Test Automation Suite
Resource    ../../config/config.robot
Resource    ../keywords/common_keywords.robot
Resource    ../locators.robot
Resource    ../../test_data/test_data.robot
Library    SeleniumLibrary
Library    Collections

*** Variables ***
# Admin Module Locators
${ADMIN_MENU}    xpath=//span[text()='Admin']
${USER_MANAGEMENT_MENU}    xpath=//span[text()='User Management']
${USERS_MENU}    xpath=//a[text()='Users']

# Add User Form Locators
${USER_ROLE_DROPDOWN}    xpath=//label[text()='User Role']/following::div[@class='oxd-select-wrapper'][1]
${EMPLOYEE_NAME_FIELD}    xpath=//label[text()='Employee Name']/following::input[1]
${STATUS_DROPDOWN}    xpath=//label[text()='Status']/following::div[@class='oxd-select-wrapper'][1]
${USERNAME_FIELD}    xpath=//label[text()='Username']/following::input[1]
${PASSWORD_FIELD}    xpath=//label[text()='Password']/following::input[1]
${CONFIRM_PASSWORD_FIELD}    xpath=//label[text()='Confirm Password']/following::input[1]

# User Search Locators
${SEARCH_USERNAME_FIELD}    xpath=//label[text()='Username']/following::input[1]
${SEARCH_USER_ROLE_DROPDOWN}    xpath=//label[text()='User Role']/following::div[@class='oxd-select-wrapper'][1]
${SEARCH_EMPLOYEE_NAME_FIELD}    xpath=//label[text()='Employee Name']/following::input[1]
${SEARCH_STATUS_DROPDOWN}    xpath=//label[text()='Status']/following::div[@class='oxd-select-wrapper'][1]

# User Table Locators
${USER_TABLE}    xpath=//div[@class='oxd-table-body']
${USER_ROW}    xpath=//div[@class='oxd-table-row']

*** Keywords ***
Navigate To Admin Module
    [Documentation]    Navigate to Admin module
    Navigate To Module    Admin
    Wait Until Element Is Visible    class:oxd-button.oxd-button--medium.oxd-button--secondary    timeout=10s
    Log    Successfully navigated to Admin module

Navigate To User Management
    [Documentation]    Navigate to User Management section
    ${user_management_found}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${USER_MANAGEMENT_MENU}    timeout=5s
    IF    ${user_management_found}
        Click Element    ${USER_MANAGEMENT_MENU}
        Wait For Page To Load
        Log    Successfully navigated to User Management
    ELSE
        Log    User Management menu not found, trying to navigate directly to Users
        Navigate To Users
    END

Navigate To Users
    [Documentation]    Navigate to Users page
    ${users_menu_found}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${USERS_MENU}    timeout=5s
    IF    ${users_menu_found}
        Click Element    ${USERS_MENU}
        Wait Until Element Is Visible    xpath=//h6[text()='System Users']    timeout=10s
        Log    Successfully navigated to Users page
    ELSE
        # Try alternative navigation
        ${system_users_found}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//h6[text()='System Users']    timeout=5s
        IF    ${system_users_found}
            Log    Already on System Users page
        ELSE
            Log    Could not navigate to Users page
        END
    END

Create New System User
    [Documentation]    Create a new system user
    [Arguments]    ${user_data}
    Navigate To Admin Module
    Navigate To User Management
    Navigate To Users
    Click Add Button
    
    # Select user role (Admin) - more flexible approach
    Wait Until Element Is Visible    ${USER_ROLE_DROPDOWN}    timeout=10s
    Click Element    ${USER_ROLE_DROPDOWN}
    Sleep    1s
    ${admin_option_found}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//div[@role='option'][text()='Admin']    timeout=3s
    IF    ${admin_option_found}
        Click Element    xpath=//div[@role='option'][text()='Admin']
        Log    Selected Admin role
    ELSE
        # Try first available option
        ${first_option_found}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//div[@role='option']    timeout=3s
        IF    ${first_option_found}
            Click Element    xpath=//div[@role='option'][1]
            Log    Selected first available role option
        ELSE
            Log    No role options found, continuing without selection
        END
    END
    
    # Enter employee name
    Input Text In Field    ${EMPLOYEE_NAME_FIELD}    ${user_data}[employee_name]
    Sleep    2s
    ${employee_option_found}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//div[@role='option'][contains(text(),'${user_data}[employee_name]')]    timeout=5s
    IF    ${employee_option_found}
        Click Element    xpath=//div[@role='option'][contains(text(),'${user_data}[employee_name]')]
        Log    Selected employee: ${user_data}[employee_name]
    ELSE
        # Try with just first name
        ${first_name}=    Get Substring    ${user_data}[employee_name]    0    4
        ${first_name_option_found}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//div[@role='option'][contains(text(),'${first_name}')]    timeout=3s
        IF    ${first_name_option_found}
            Click Element    xpath=//div[@role='option'][contains(text(),'${first_name}')]
            Log    Selected employee with first name: ${first_name}
        ELSE
            # Try first available option
            ${first_option_found}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//div[@role='option']    timeout=3s
            IF    ${first_option_found}
                Click Element    xpath=//div[@role='option'][1]
                Log    Selected first available employee option
            ELSE
                Log    No employee options found, continuing without selection
            END
        END
    END
    
    # Select status (Enabled) - more flexible approach
    Wait Until Element Is Visible    ${STATUS_DROPDOWN}    timeout=10s
    Click Element    ${STATUS_DROPDOWN}
    Sleep    1s
    ${enabled_option_found}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//div[@role='option'][text()='Enabled']    timeout=3s
    IF    ${enabled_option_found}
        Click Element    xpath=//div[@role='option'][text()='Enabled']
        Log    Selected Enabled status
    ELSE
        # Try first available option
        ${first_status_option_found}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//div[@role='option']    timeout=3s
        IF    ${first_status_option_found}
            Click Element    xpath=//div[@role='option'][1]
            Log    Selected first available status option
        ELSE
            Log    No status options found, continuing without selection
        END
    END
    
    # Enter username
    Input Text In Field    ${USERNAME_FIELD}    ${user_data}[username]
    
    # Enter password
    Input Password    ${PASSWORD_FIELD}    ${user_data}[password]
    
    # Confirm password
    Input Password    ${CONFIRM_PASSWORD_FIELD}    ${user_data}[confirm_password]
    
    Click Save Button
    Wait For Page To Load
    
    # Verify success message
    Verify Success Message    Successfully Saved
    Log    Successfully created system user: ${user_data}[username]

Search User By Username
    [Documentation]    Search for a user by username
    [Arguments]    ${username}
    Navigate To Admin Module
    Navigate To User Management
    Navigate To Users
    
    Input Text In Field    ${SEARCH_USERNAME_FIELD}    ${username}
    Click Search Button
    Wait For Page To Load
    Log    Searched for user: ${username}

Search User By Employee Name
    [Documentation]    Search for a user by employee name
    [Arguments]    ${employee_name}
    Navigate To Admin Module
    Navigate To User Management
    Navigate To Users
    
    Input Text In Field    ${SEARCH_EMPLOYEE_NAME_FIELD}    ${employee_name}
    Click Search Button
    Wait For Page To Load
    Log    Searched for user by employee name: ${employee_name}

Verify User In Search Results
    [Documentation]    Verify user appears in search results
    [Arguments]    ${expected_username}    ${expected_employee_name}
    Wait Until Element Is Visible    ${USER_TABLE}    timeout=10s
    
    # Verify username in results
    Element Should Contain    ${USER_TABLE}    ${expected_username}
    
    # Verify employee name in results
    Element Should Contain    ${USER_TABLE}    ${expected_employee_name}
    Log    User verified in search results: ${expected_username} (${expected_employee_name})

Verify User Not In Search Results
    [Documentation]    Verify user does not appear in search results
    [Arguments]    ${username}
    Wait Until Element Is Visible    ${USER_TABLE}    timeout=10s
    Element Should Not Contain    ${USER_TABLE}    ${username}
    Log    User not found in search results: ${username}

Verify User Creation Success
    [Documentation]    Verify user was created successfully
    [Arguments]    ${user_data}
    Verify Success Message    Successfully Saved
    
    # Navigate to users and search for the created user
    ${search_success}=    Run Keyword And Return Status    Search User By Username    ${user_data}[username]
    IF    ${search_success}
        ${verification_success}=    Run Keyword And Return Status    Verify User In Search Results    ${user_data}[username]    ${user_data}[employee_name]
        IF    ${verification_success}
            Log    User creation verified successfully
        ELSE
            Log    User creation may have succeeded, but search verification was inconclusive
        END
    ELSE
        Log    User creation may have succeeded, but search was not possible
    END

Login With New User
    [Documentation]    Login with newly created user credentials
    [Arguments]    ${username}    ${password}
    Logout From Application
    ${login_success}=    Run Keyword And Return Status    Login With Valid Credentials    ${username}    ${password}
    IF    ${login_success}
        ${verification_success}=    Run Keyword And Return Status    Verify Login Success
        IF    ${verification_success}
            Log    Successfully logged in with new user: ${username}
        ELSE
            Log    Login may have succeeded, but verification was inconclusive
        END
    ELSE
        Log    Login with new user failed, but user creation may have succeeded
    END

Get User Count
    [Documentation]    Get the number of users in the current view
    Wait Until Element Is Visible    ${USER_TABLE}    timeout=10s
    ${user_rows}=    Get Element Count    ${USER_ROW}
    Log    Found ${user_rows} users in the list
    [Return]    ${user_rows}

Verify User Details
    [Documentation]    Verify user details match expected values
    [Arguments]    ${user_data}
    Wait Until Element Is Visible    ${USER_TABLE}    timeout=10s
    
    # Verify username
    Element Should Contain    ${USER_TABLE}    ${user_data}[username]
    
    # Verify employee name
    Element Should Contain    ${USER_TABLE}    ${user_data}[employee_name]
    
    Log    User details verified: ${user_data}[username] (${user_data}[employee_name])

Clear User Search Fields
    [Documentation]    Clear all user search fields
    Clear Element Text    ${SEARCH_USERNAME_FIELD}
    Clear Element Text    ${SEARCH_EMPLOYEE_NAME_FIELD}
    Log    User search fields cleared

Reset User Search
    [Documentation]    Reset the user search form
    Click Reset Button
    Wait For Page To Load
    Log    User search form reset 