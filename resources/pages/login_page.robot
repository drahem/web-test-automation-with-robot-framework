*** Settings ***
Documentation    Login page object for OrangeHRM Test Automation Suite
Resource    ../../config/config.robot
Resource    ../keywords/common_keywords.robot
Resource    ../locators.robot
Library    SeleniumLibrary

*** Variables ***
# Login Page Specific Locators
${LOGIN_ERROR_MESSAGE}    xpath=//p[@class='oxd-text oxd-text--p oxd-alert-content-text']

*** Keywords ***
Login With Valid Credentials
    [Documentation]    Login to application with valid credentials
    [Arguments]    ${username}=${USERNAME}    ${password}=${PASSWORD}
    ${username_field_found}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${USERNAME_FIELD}    timeout=10s
    IF    ${username_field_found}
        Input Text    ${USERNAME_FIELD}    ${username}
        Input Password    ${PASSWORD_FIELD}    ${password}
        Click Button    xpath=//button[@type='submit']
        Wait Until Element Is Visible    ${DASHBOARD_HEADER}    timeout=10s
        Log    Successfully logged in with username: ${username}
    ELSE
        # Try alternative login page elements
        ${alt_username_field}=    Run Keyword And Return Status    Wait Until Element Is Visible    name=username    timeout=5s
        IF    ${alt_username_field}
            Input Text    name=username    ${username}
            Input Password    name=password    ${password}
            Click Button    xpath=//button[@type='submit']
            Wait Until Element Is Visible    xpath=//h6[text()='Dashboard']    timeout=10s
            Log    Successfully logged in with username: ${username} (alternative fields)
        ELSE
            Fail    Login page not accessible
        END
    END

Login With Invalid Credentials
    [Documentation]    Login to application with invalid credentials
    [Arguments]    ${username}    ${password}
    Wait Until Element Is Visible    ${USERNAME_FIELD}    timeout=10s
    Input Text    ${USERNAME_FIELD}    ${username}
    Input Password    ${PASSWORD_FIELD}    ${password}
    Click Button    xpath=//button[@type='submit']
    Wait Until Element Is Visible    ${LOGIN_ERROR_MESSAGE}    timeout=10s
    Log    Login failed as expected with invalid credentials

Verify Login Error Message
    [Documentation]    Verify login error message is displayed
    [Arguments]    ${expected_message}
    Element Should Contain    ${LOGIN_ERROR_MESSAGE}    ${expected_message}
    Log    Login error message verified: ${expected_message}

Verify Login Success
    [Documentation]    Verify successful login by checking dashboard
    Wait Until Element Is Visible    ${DASHBOARD_HEADER}    timeout=10s
    Element Should Be Visible    ${DASHBOARD_HEADER}
    Log    Login success verified - Dashboard is displayed

Verify Login Page Elements
    [Documentation]    Verify all login page elements are present
    Wait Until Element Is Visible    ${USERNAME_FIELD}    timeout=10s
    Element Should Be Visible    ${USERNAME_FIELD}
    Element Should Be Visible    ${PASSWORD_FIELD}
    Element Should Be Visible    xpath=//button[@type='submit']
    Log    All login page elements are present

Clear Login Fields
    [Documentation]    Clear username and password fields
    Clear Element Text    ${USERNAME_FIELD}
    Clear Element Text    ${PASSWORD_FIELD}
    Log    Login fields cleared

Logout From Application
    [Documentation]    Logout from the application
    Wait Until Element Is Visible    ${USER_MENU}    timeout=10s
    Click Element    ${USER_MENU}
    Wait Until Element Is Visible    ${LOGOUT_LINK}    timeout=5s
    Click Element    ${LOGOUT_LINK}
    Wait Until Element Is Visible    ${USERNAME_FIELD}    timeout=10s
    Log    Successfully logged out from application

Verify Logout Success
    [Documentation]    Verify successful logout by checking login page
    Wait Until Element Is Visible    ${USERNAME_FIELD}    timeout=10s
    Element Should Be Visible    ${USERNAME_FIELD}
    Log    Logout success verified - Login page is displayed 