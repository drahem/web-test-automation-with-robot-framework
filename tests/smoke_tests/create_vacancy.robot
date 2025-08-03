*** Settings ***
Documentation    Test Case 3: Create Vacancy (Recruitment Module) - Tag: smoke
Resource    ../../config/config.robot
Resource    ../../resources/keywords/common_keywords.robot
Resource    ../../resources/pages/login_page.robot
Resource    ../../resources/pages/recruitment_page.robot
Resource    ../../test_data/test_data.robot
Library    SeleniumLibrary
Library    Collections

*** Test Cases ***
Test Case 3: Create Vacancy (Recruitment Module)
    [Documentation]    Test Case 3: Create Vacancy (Recruitment Module) - Tag: smoke
    [Tags]    smoke    recruitment    vacancy    fast
    [Setup]    Setup Browser
    [Teardown]    Run Keywords    Take Screenshot On Failure    AND    Teardown Browser
    
    # Generate unique vacancy data
    ${vacancy_data}=    Generate Unique Vacancy Data
    
    # Login to application
    Login With Valid Credentials
    
    # Create new vacancy
    Create New Vacancy    ${vacancy_data}
    
    # Verify vacancy creation success
    Verify Vacancy Creation Success    ${vacancy_data} 