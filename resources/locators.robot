*** Settings ***
Documentation    Centralized locators for OrangeHRM application
Library    SeleniumLibrary

*** Variables ***
# Common Locators
${DASHBOARD_HEADER}    xpath=//h6[text()='Dashboard']
${SUCCESS_MESSAGE}    xpath=//div[@class='oxd-toast-content oxd-toast-content--success']//p[contains(text(),'Success')]
${ERROR_MESSAGE}    xpath=//div[@class='oxd-toast-content oxd-toast-content--error']//p
${LOADING_SPINNER}    xpath=//div[@class='oxd-loading-spinner']

# Navigation Locators
${PIM_MENU}    xpath=//span[@class='oxd-text oxd-text--span oxd-main-menu-item--name' and text()='PIM']
${RECRUITMENT_MENU}    xpath=//span[@class='oxd-text oxd-text--span oxd-main-menu-item--name' and text()='Recruitment']
${ADMIN_MENU}    xpath=//span[@class='oxd-text oxd-text--span oxd-main-menu-item--name' and text()='Admin']

# Common Button Locators
${ADD_BUTTON}    class:oxd-button.oxd-button--medium.oxd-button--secondary
${SAVE_BUTTON}    xpath=//button[contains(@class,'oxd-button') and contains(text(),'Save')]
${SEARCH_BUTTON}    xpath=//button[contains(@class,'oxd-button') and contains(text(),'Search')]
${RESET_BUTTON}    xpath=//button[contains(@class,'oxd-button') and contains(text(),'Reset')]

# Form Field Locators
${FIRST_NAME_FIELD}    name=firstName
${LAST_NAME_FIELD}    name=lastName
${MIDDLE_NAME_FIELD}    name=middleName
${EMPLOYEE_ID_FIELD}    xpath=//label[text()='Employee Id']/following::input[1]

# Search Field Locators
${SEARCH_EMPLOYEE_NAME}    xpath=//label[text()='Employee Name']/following::input[1]
${SEARCH_EMPLOYEE_ID}    xpath=//label[text()='Employee Id']/following::input[1]

# Table Locators
${EMPLOYEE_TABLE}    xpath=//div[@class='oxd-table-body']
${TABLE_ROW}    xpath=//div[@class='oxd-table-row']
${TABLE_CELL}    xpath=//div[@class='oxd-table-cell']

# User Management Locators
${USERNAME_FIELD}    name=username
${PASSWORD_FIELD}    name=password
${CONFIRM_PASSWORD_FIELD}    xpath=//label[text()='Confirm Password']/following::input[1]
${USER_ROLE_DROPDOWN}    xpath=//label[text()='User Role']/following::div[contains(@class,'oxd-select')]
${EMPLOYEE_NAME_DROPDOWN}    xpath=//label[text()='Employee Name']/following::div[contains(@class,'oxd-select')]
${STATUS_DROPDOWN}    xpath=//label[text()='Status']/following::div[contains(@class,'oxd-select')]

# Vacancy Locators
${VACANCY_NAME_FIELD}    xpath=//label[text()='Vacancy Name']/following::input[1]
${JOB_TITLE_DROPDOWN}    xpath=//label[text()='Job Title']/following::div[contains(@class,'oxd-select')]
${HIRING_MANAGER_DROPDOWN}    xpath=//label[text()='Hiring Manager']/following::div[contains(@class,'oxd-select')]

# Candidate Locators
${CANDIDATE_FIRST_NAME}    name=firstName
${CANDIDATE_LAST_NAME}    name=lastName
${VACANCY_DROPDOWN}    xpath=//label[text()='Vacancy']/following::div[contains(@class,'oxd-select')]
${RESUME_UPLOAD}    xpath=//input[@type='file']

# Dropdown Option Locators
${DROPDOWN_OPTION_TEMPLATE}    xpath=//div[@class='oxd-select-option']//span[contains(text(),'{}')]
${DROPDOWN_LOADING}    xpath=//div[@class='oxd-select-loading']

# Logout Locators
${USER_MENU}    xpath=//span[@class='oxd-userdropdown-tab']
${LOGOUT_LINK}    xpath=//a[text()='Logout'] 