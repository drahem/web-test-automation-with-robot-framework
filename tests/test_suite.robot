*** Settings ***
Documentation    Main Test Suite for OrangeHRM Test Automation
Resource    ../config/config.robot
Resource    ../resources/keywords/common_keywords.robot
Resource    ../resources/pages/login_page.robot
Resource    ../resources/pages/pim_page.robot
Resource    ../resources/pages/recruitment_page.robot
Resource    ../resources/pages/admin_page.robot
Resource    ../test_data/test_data.robot
Library    SeleniumLibrary
Library    Collections

*** Test Cases ***
# Smoke Tests
Test Case 1: Create Employee (PIM Module)
    [Documentation]    Test Case 1: Create Employee (PIM Module) - Tag: smoke
    [Tags]    smoke    pim    employee
    [Setup]    Setup Browser
    [Teardown]    Run Keywords    Take Screenshot On Failure    AND    Teardown Browser
    
    # Generate unique employee data
    ${employee_data}=    Generate Unique Employee Data
    
    # Login to application
    Login With Valid Credentials
    
    # Create new employee
    Create New Employee    ${employee_data}
    
    # Verify employee creation success
    Verify Employee Creation Success    ${employee_data}

Test Case 3: Create Vacancy (Recruitment Module)
    [Documentation]    Test Case 3: Create Vacancy (Recruitment Module) - Tag: smoke
    [Tags]    smoke    recruitment    vacancy
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

Test Case 5: Create System User and Login
    [Documentation]    Test Case 5: Create System User and Login - Tag: smoke
    [Tags]    smoke    admin    user
    [Setup]    Setup Browser
    [Teardown]    Run Keywords    Take Screenshot On Failure    AND    Teardown Browser
    
    # Generate unique user data
    ${user_data}=    Generate Unique User Data
    
    # Login to application with admin credentials
    Login With Valid Credentials
    
    # Create new system user
    Create New System User    ${user_data}
    
    # Verify user creation success
    Verify User Creation Success    ${user_data}
    
    # Logout and login with new user credentials
    Login With New User    ${user_data}[username]    ${user_data}[password]

# Regression Tests
Test Case 2: Search Employee
    [Documentation]    Test Case 2: Search Employee - Tag: regression
    [Tags]    regression    pim    search
    [Setup]    Setup Browser
    [Teardown]    Run Keywords    Take Screenshot On Failure    AND    Teardown Browser
    
    # Generate unique employee data
    ${employee_data}=    Generate Unique Employee Data
    
    # Login to application
    Login With Valid Credentials
    
    # Create new employee first
    Create New Employee    ${employee_data}
    
    # Search for the created employee by name
    Search Employee By Name    ${employee_data}[first_name]    ${employee_data}[last_name]
    
    # Verify employee appears in search results
    Verify Employee In Search Results    ${employee_data}[first_name] ${employee_data}[last_name]    ${employee_data}[employee_id]
    
    # Search for the created employee by ID
    Search Employee By ID    ${employee_data}[employee_id]
    
    # Verify employee appears in search results
    Verify Employee In Search Results    ${employee_data}[first_name] ${employee_data}[last_name]    ${employee_data}[employee_id]
    
    # Verify all employee data is saved correctly
    Verify Employee Details    ${employee_data}

Test Case 4: Add Candidate
    [Documentation]    Test Case 4: Add Candidate - Tag: regression
    [Tags]    regression    recruitment    candidate
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