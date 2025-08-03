*** Settings ***
Documentation    Test data configuration for OrangeHRM Test Automation Suite
Library    DateTime
Library    String
Library    OperatingSystem

*** Variables ***
# Employee Test Data
${EMPLOYEE_DATA}    &{EMPTY}
...    first_name=John
...    last_name=Doe
...    employee_id=1234
...    email=john.doe@example.com
...    middle_name=Michael

# Recruitment Test Data
${VACANCY_DATA}    &{EMPTY}
...    name=Software Engineer
...    description=We are looking for a skilled software engineer
...    requirements=Python, Selenium, Robot Framework
...    number_of_positions=2

${CANDIDATE_DATA}    &{EMPTY}
...    first_name=Jane
...    last_name=Smith
...    email=jane.smith@example.com
...    contact_number=+1234567890
...    resume_path=test_data/resume.txt

# Admin Test Data
${USER_DATA}    &{EMPTY}
...    username=testuser
...    password=Test@123
...    confirm_password=Test@123
...    employee_name=John Doe

*** Keywords ***
Generate Unique Employee Data
    [Documentation]    Generate unique employee data with timestamp
    ${timestamp}=    Get Current Date    result_format=%Y%m%d%H%M%S
    ${unique_employee_data}=    Create Dictionary
    ...    first_name=John${timestamp}
    ...    last_name=Doe${timestamp}
    ...    employee_id=${timestamp[-2:]}
    ...    email=john.doe${timestamp}@example.com
    ...    middle_name=Michael
    [Return]    ${unique_employee_data}

Generate Unique Vacancy Data
    [Documentation]    Generate unique vacancy data with timestamp
    ${timestamp}=    Get Current Date    result_format=%Y%m%d%H%M%S
    ${unique_vacancy_data}=    Create Dictionary
    ...    name=Software Engineer${timestamp}
    ...    description=We are looking for a skilled software engineer${timestamp}
    ...    requirements=Python, Selenium, Robot Framework
    ...    number_of_positions=2
    [Return]    ${unique_vacancy_data}

Generate Unique Candidate Data
    [Documentation]    Generate unique candidate data with timestamp
    ${timestamp}=    Get Current Date    result_format=%Y%m%d%H%M%S
    ${unique_candidate_data}=    Create Dictionary
    ...    first_name=Jane${timestamp}
    ...    last_name=Smith${timestamp}
    ...    email=jane.smith${timestamp}@example.com
    ...    contact_number=+1234567890
    ...    resume_path=${EXECDIR}/test_data/resume.txt
    [Return]    ${unique_candidate_data}

Generate Unique User Data
    [Documentation]    Generate unique user data with timestamp
    ${timestamp}=    Get Current Date    result_format=%Y%m%d%H%M%S
    ${unique_user_data}=    Create Dictionary
    ...    username=testuser${timestamp}
    ...    password=Test@123
    ...    confirm_password=Test@123
    ...    employee_name=John Doe
    [Return]    ${unique_user_data}

Create Test Resume File
    [Documentation]    Create a test resume file for candidate upload
    ${resume_content}=    Set Variable    This is a test resume file for automation testing.
    Create File    ${EXECDIR}/test_data/resume.txt    ${resume_content}

Cleanup Test Files
    [Documentation]    Clean up test files after execution
    Remove File    ${EXECDIR}/test_data/resume.txt    missing_ok=True 