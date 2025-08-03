*** Settings ***
Documentation    Test Case 2: Search Employee - Tag: regression
Resource    ../../config/config.robot
Resource    ../../resources/keywords/common_keywords.robot
Resource    ../../resources/pages/login_page.robot
Resource    ../../resources/pages/pim_page.robot
Resource    ../../test_data/test_data.robot
Library    SeleniumLibrary
Library    Collections

*** Test Cases ***
Test Case 2: Search Employee
    [Documentation]    Test Case 2: Search Employee - Tag: regression
    [Tags]    regression    pim    search    fast
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