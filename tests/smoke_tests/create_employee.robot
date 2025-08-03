*** Settings ***
Documentation    Test Case 1: Create Employee (PIM Module) - Tag: smoke
Resource    ../../config/config.robot
Resource    ../../resources/keywords/common_keywords.robot
Resource    ../../resources/pages/login_page.robot
Resource    ../../resources/pages/pim_page.robot
Resource    ../../test_data/test_data.robot
Library    SeleniumLibrary
Library    Collections

*** Test Cases ***
Test Case 1: Create Employee (PIM Module)
    [Documentation]    Test Case 1: Create Employee (PIM Module) - Tag: smoke
    [Tags]    smoke    pim    employee    fast
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