*** Settings ***
Documentation    Test Case 5: Create System User and Login - Tag: smoke
Resource    ../../config/config.robot
Resource    ../../resources/keywords/common_keywords.robot
Resource    ../../resources/pages/login_page.robot
Resource    ../../resources/pages/admin_page.robot
Resource    ../../test_data/test_data.robot
Library    SeleniumLibrary
Library    Collections

*** Test Cases ***
Test Case 5: Create System User and Login
    [Documentation]    Test Case 5: Create System User and Login - Tag: smoke
    [Tags]    smoke    admin    user    fast
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