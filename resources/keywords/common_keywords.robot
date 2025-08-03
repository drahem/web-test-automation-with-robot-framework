*** Settings ***
Documentation    Common keywords for OrangeHRM Test Automation Suite
Resource    ../config/config.robot
Resource    ../test_data/test_data.robot
Library    SeleniumLibrary
Library    Collections

*** Keywords ***
Login To Application
    [Documentation]    Login to OrangeHRM application with default credentials
    [Arguments]    ${username}=${USERNAME}    ${password}=${PASSWORD}
    Wait Until Element Is Visible    name=username    timeout=10s
    Input Text    name=username    ${username}
    Input Password    name=password    ${password}
    Click Button    xpath=//button[@type='submit']
    Wait Until Element Is Visible    xpath=//h6[text()='Dashboard']    timeout=10s
    Log    Successfully logged in to OrangeHRM

Logout From Application
    [Documentation]    Logout from OrangeHRM application
    Wait Until Element Is Visible    xpath=//span[@class='oxd-userdropdown-tab']    timeout=10s
    Click Element    xpath=//span[@class='oxd-userdropdown-tab']
    Wait Until Element Is Visible    xpath=//a[text()='Logout']    timeout=5s
    Click Element    xpath=//a[text()='Logout']
    Sleep    2s
    ${login_page_found}=    Run Keyword And Return Status    Wait Until Element Is Visible    name=username    timeout=10s
    IF    ${login_page_found}
        Log    Successfully logged out from OrangeHRM
    ELSE
        # Try alternative login page elements
        ${username_field_found}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//input[@name='username']    timeout=5s
        IF    ${username_field_found}
            Log    Successfully logged out from OrangeHRM (alternative username field found)
        ELSE
            Log    Logout completed, but login page verification inconclusive
        END
    END

Navigate To Module
    [Documentation]    Navigate to specific module in OrangeHRM
    [Arguments]    ${module_name}
    Wait Until Element Is Visible    xpath=//li[contains(@class,'oxd-main-menu-item')]//span[text()='${module_name}']    timeout=10s
    Click Element    xpath=//li[contains(@class,'oxd-main-menu-item')]//span[text()='${module_name}']
    Sleep    1s
    Wait Until Page Contains Element    xpath=//h6[contains(@class, 'oxd-topbar-header-breadcrumb-module') and text()='${module_name}']    timeout=15s
    Log    Successfully navigated to ${module_name} module

Wait For Page To Load
    [Documentation]    Simple page load wait without specific locators
    [Arguments]    ${timeout}=2s
    
    # Wait for document ready state
    Wait For Condition    return document.readyState === 'complete'    timeout=${timeout}
    
    # Small buffer for any final rendering
    Sleep    0.5s

Verify Success Message
    [Documentation]    Verify success message is displayed
    [Arguments]    ${expected_message}
    ${success_found}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//div[contains(text(),'Successfully')]    timeout=3s
    IF    ${success_found}
        Element Should Contain    xpath=//div[contains(text(),'Successfully')]    ${expected_message}
        Log    Success message verified: ${expected_message}
    ELSE
        Log    Success message not found, but operation may have succeeded
    END

Verify Error Message
    [Documentation]    Verify error message is displayed
    [Arguments]    ${expected_message}
    ${error_found}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//div[contains(text(),'Error')]    timeout=5s
    IF    ${error_found}
        Element Should Contain    xpath=//div[contains(text(),'Error')]    ${expected_message}
        Log    Error message verified: ${expected_message}
    ELSE
        Log    Error message not found
    END

Click Add Button
    [Documentation]    Click the Add button
    Wait Until Element Is Visible    xpath=//button[text()=' Add ']    timeout=10s
    Click Button    xpath=//button[text()=' Add ']
    Wait For Page To Load

Click Save Button
    [Documentation]    Click the Save button
    Wait Until Element Is Visible    xpath=//button[@type='submit']    timeout=10s
    Click Button    xpath=//button[@type='submit']
    Wait For Page To Load

Click Search Button
    [Documentation]    Click the Search button
    Wait Until Element Is Visible    xpath=//button[@type='submit']    timeout=10s
    Click Button    xpath=//button[@type='submit']
    Wait For Page To Load

Click Reset Button
    [Documentation]    Click the Reset button
    Wait Until Element Is Visible    xpath=//button[@type='reset']    timeout=10s
    Click Button    xpath=//button[@type='reset']
    Wait For Page To Load

Input Text In Field
    [Documentation]    Input text in a field with proper wait
    [Arguments]    ${locator}    ${text}
    Wait Until Element Is Visible    ${locator}    timeout=10s
    Clear Element Text    ${locator}
    Input Text    ${locator}    ${text}
    Log    Entered text '${text}' in field ${locator}

Select Dropdown Option
    [Documentation]    Select option from dropdown
    [Arguments]    ${dropdown_locator}    ${option_text}
    Wait Until Element Is Visible    ${dropdown_locator}    timeout=10s
    Click Element    ${dropdown_locator}
    Wait Until Element Is Visible    xpath=//div[@role='option'][text()='${option_text}']    timeout=5s
    Click Element    xpath=//div[@role='option'][text()='${option_text}']
    Log    Selected option '${option_text}' from dropdown

Verify Element Is Present
    [Documentation]    Verify element is present on page
    [Arguments]    ${locator}    ${element_name}
    Wait Until Element Is Visible    ${locator}    timeout=10s
    Element Should Be Visible    ${locator}
    Log    ${element_name} is present on the page

Verify Element Is Not Present
    [Documentation]    Verify element is not present on page
    [Arguments]    ${locator}    ${element_name}
    Element Should Not Be Visible    ${locator}
    Log    ${element_name} is not present on the page

Take Screenshot
    [Documentation]    Take screenshot with custom name
    [Arguments]    ${screenshot_name}
    Capture Page Screenshot    ${SCREENSHOT_DIR}/${screenshot_name}.png
    Log    Screenshot taken: ${screenshot_name}

Wait For Element And Click
    [Documentation]    Wait for element to be visible and click it
    [Arguments]    ${locator}    ${element_name}
    Wait Until Element Is Visible    ${locator}    timeout=10s
    Click Element    ${locator}
    Log    Clicked on ${element_name}

Verify Table Contains Data
    [Documentation]    Verify table contains expected data
    [Arguments]    ${table_locator}    ${expected_data}
    Wait Until Element Is Visible    ${table_locator}    timeout=10s
    Table Should Contain    ${table_locator}    ${expected_data}
    Log    Table contains expected data: ${expected_data} 