*** Settings ***
Documentation    Configuration file for OrangeHRM Test Automation Suite
Library    SeleniumLibrary
Library    Collections
Library    String
Library    DateTime

*** Variables ***
# Application Configuration
${BASE_URL}    https://opensource-demo.orangehrmlive.com/
${USERNAME}    Admin
${PASSWORD}    admin123

# Browser Configuration
${BROWSER}    chrome
${HEADLESS}    False
${IMPLICIT_WAIT}    5s
${EXPLICIT_WAIT}    10s

# Test Data
${EMPLOYEE_FIRST_NAME}    John
${EMPLOYEE_LAST_NAME}    Doe
${EMPLOYEE_ID}    12345
${EMPLOYEE_EMAIL}    john.doe@example.com

# Recruitment Test Data
${VACANCY_NAME}    Software Engineer
${VACANCY_DESCRIPTION}    We are looking for a skilled software engineer
${CANDIDATE_FIRST_NAME}    Jane
${CANDIDATE_LAST_NAME}    Smith
${CANDIDATE_EMAIL}    jane.smith@example.com

# Admin Test Data
${NEW_USER_USERNAME}    testuser
${NEW_USER_PASSWORD}    Test@123
${NEW_USER_EMPLOYEE_NAME}    John Doe

# File Paths
${SCREENSHOT_DIR}    results/screenshots
${REPORT_DIR}    results/reports

*** Keywords ***
Setup Browser
    [Documentation]    Setup browser with appropriate configuration
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${chrome_options}    add_argument    --no-sandbox
    Call Method    ${chrome_options}    add_argument    --disable-dev-shm-usage
    Call Method    ${chrome_options}    add_argument    --disable-gpu
    Call Method    ${chrome_options}    add_argument    --disable-extensions
    Call Method    ${chrome_options}    add_argument    --disable-plugins
    Call Method    ${chrome_options}    add_argument    --disable-background-timer-throttling
    Call Method    ${chrome_options}    add_argument    --disable-backgrounding-occluded-windows
    Call Method    ${chrome_options}    add_argument    --disable-renderer-backgrounding
    IF    ${HEADLESS}
        Call Method    ${chrome_options}    add_argument    --headless
    END
                    Open Browser    ${BASE_URL}    ${BROWSER}    options=${chrome_options}
                Maximize Browser Window
    Set Selenium Implicit Wait    ${IMPLICIT_WAIT}
    Set Selenium Timeout    ${EXPLICIT_WAIT}

Teardown Browser
    [Documentation]    Close browser and cleanup
    Close All Browsers

Create Screenshot Directory
    [Documentation]    Create screenshot directory if it doesn't exist
    Create Directory    ${SCREENSHOT_DIR}

Take Screenshot On Failure
    [Documentation]    Take screenshot when test fails
    Run Keyword If Test Failed    Capture Page Screenshot    ${SCREENSHOT_DIR}/failure_{index}.png 