*** Settings ***
Documentation    Test Case 4: Add Candidate - Tag: regression
Resource    ../../config/config.robot
Resource    ../../resources/keywords/common_keywords.robot
Resource    ../../resources/pages/login_page.robot
Resource    ../../resources/pages/recruitment_page.robot
Resource    ../../test_data/test_data.robot
Library    SeleniumLibrary
Library    Collections

*** Test Cases ***
Test Case 4: Add Candidate
    [Documentation]    Test Case 4: Add Candidate - Tag: regression
    [Tags]    regression    recruitment    candidate    fast
    [Setup]    Setup Browser
    [Teardown]    Run Keywords    Take Screenshot On Failure    AND    Teardown Browser
    
    # Generate unique vacancy and candidate data
    ${vacancy_data}=    Generate Unique Vacancy Data
    ${candidate_data}=    Generate Unique Candidate Data
    
    # Add vacancy name to candidate data for reference
    Set To Dictionary    ${candidate_data}    vacancy_name=${vacancy_data}[name]
    Set To Dictionary    ${candidate_data}    keywords=Python Selenium Robot Framework
    Set To Dictionary    ${candidate_data}    comment=This is a test candidate for automation testing
    
    # Create test resume file
    Create Test Resume File
    
    # Login to application
    Login With Valid Credentials
    
    # Create new vacancy first
    Create New Vacancy    ${vacancy_data}
    
    # Add new candidate
    Add New Candidate    ${candidate_data}
    
    # Verify candidate addition success
    Verify Candidate Addition Success    ${candidate_data}
    
    # Search for the added candidate
    Search Candidate    ${candidate_data}[first_name] ${candidate_data}[last_name]
    
    # Verify candidate appears in search results
    Verify Candidate In Search Results    ${candidate_data}[first_name] ${candidate_data}[last_name] 