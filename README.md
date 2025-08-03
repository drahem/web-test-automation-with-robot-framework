# OrangeHRM Test Automation Suite

A comprehensive web test automation suite for the OrangeHRM application covering Employee Management, Recruitment, and User Administration functionalities using Robot Framework with Selenium Library.

## 🎯 Project Overview

This project implements automated testing for the OrangeHRM demo application (https://opensource-demo.orangehrmlive.com/) with the following test scenarios:

### Test Cases Implemented

| Test Case | Module | Tag | Description |
|-----------|--------|-----|-------------|
| Test Case 1 | PIM (Employee Management) | `smoke` | Create Employee |
| Test Case 2 | PIM (Employee Management) | `regression` | Search Employee |
| Test Case 3 | Recruitment | `smoke` | Create Vacancy |
| Test Case 4 | Recruitment | `regression` | Add Candidate |
| Test Case 5 | Admin | `smoke` | Create System User and Login |

## 🏗️ Project Structure

```
orangehrm/
├── config/
│   └── config.robot              # Configuration and browser setup
├── resources/
│   ├── keywords/
│   │   └── common_keywords.robot # Common reusable keywords
│   ├── pages/
│   │   ├── login_page.robot      # Login page object
│   │   ├── pim_page.robot        # PIM module page object
│   │   ├── recruitment_page.robot # Recruitment module page object
│   │   └── admin_page.robot      # Admin module page object
│   └── locators.robot            # Centralized element locators
├── test_data/
│   └── test_data.robot           # Test data generation and management
├── tests/
│   ├── smoke_tests/
│   │   ├── create_employee.robot # Test Case 1
│   │   ├── create_vacancy.robot  # Test Case 3
│   │   └── create_user.robot     # Test Case 5
│   ├── regression_tests/
│   │   ├── search_employee.robot # Test Case 2
│   │   └── add_candidate.robot   # Test Case 4
│   └── test_suite.robot          # Main test suite runner
├── results/                      # Test execution results
├── requirements.txt              # Python dependencies
├── .gitignore                   # Git ignore rules
└── README.md                    # This file
```

## 🚀 Quick Start

### Prerequisites

- Python 3.8 or higher
- Chrome browser installed
- Git (for cloning the repository)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd orangehrm
   ```

2. **Create virtual environment**
   ```bash
   python -m venv venv
   ```

3. **Activate virtual environment**
   ```bash
   # Windows
   venv\Scripts\activate
   
   # Linux/macOS
   source venv/bin/activate
   ```

4. **Install dependencies**
   ```bash
   pip install -r requirements.txt
   ```

### Running Tests

#### Run All Tests
```bash
robot --outputdir results tests/
```

#### Run Smoke Tests Only
```bash
robot --include smoke --outputdir results tests/
```

#### Run Regression Tests Only
```bash
robot --include regression --outputdir results tests/
```

#### Run Fast Tests (Optimized)
```bash
robot --include fast --outputdir results tests/
```

#### Run with Minimal Logging
```bash
robot --loglevel WARN --outputdir results tests/
```

#### Run Specific Test File
```bash
robot --outputdir results tests/smoke_tests/create_employee.robot
```

## 📋 Test Details

### Test Case 1: Create Employee (PIM Module)
- **Tag**: `smoke`
- **Description**: Creates a new employee in the PIM module
- **Steps**:
  1. Login to application
  2. Navigate to PIM module
  3. Create new employee with required details
  4. Verify employee creation success

### Test Case 2: Search Employee
- **Tag**: `regression`
- **Description**: Searches for created employee and verifies data
- **Steps**:
  1. Login to application
  2. Create employee (if not exists)
  3. Search for employee by name and ID
  4. Verify employee data is saved correctly

### Test Case 3: Create Vacancy (Recruitment Module)
- **Tag**: `smoke`
- **Description**: Creates a new job vacancy in the Recruitment module
- **Steps**:
  1. Login to application
  2. Navigate to Recruitment module
  3. Create new job vacancy
  4. Verify vacancy creation success

### Test Case 4: Add Candidate
- **Tag**: `regression`
- **Description**: Adds a new candidate to the recruitment system
- **Steps**:
  1. Login to application
  2. Create vacancy (if not exists)
  3. Add new candidate with resume
  4. Verify candidate addition success

### Test Case 5: Create System User and Login
- **Tag**: `smoke`
- **Description**: Creates a new system user and tests login
- **Steps**:
  1. Login with admin credentials
  2. Navigate to Admin module
  3. Create new system user
  4. Logout and login with new user credentials
  5. Verify successful login

## 🔧 Configuration

### Application Configuration
- **Base URL**: https://opensource-demo.orangehrmlive.com/
- **Default Username**: Admin
- **Default Password**: admin123
- **Browser**: Chrome (default)

### Browser Configuration
- **Implicit Wait**: 5 seconds
- **Explicit Wait**: 10 seconds
- **Headless Mode**: Disabled (configurable)
- **Browser Options**: Optimized for performance

### Test Data
- **Dynamic Data**: Uses timestamps to generate unique test data
- **Employee IDs**: Less than 10 characters
- **Email Addresses**: Unique format with timestamps
- **Resume Files**: Automatically created test files

## 📊 Test Reports

After test execution, the following reports are generated in the `results/` directory:

- **report.html**: Detailed test execution report with statistics
- **log.html**: Detailed test execution log
- **output.xml**: Robot Framework output in XML format
- **screenshots/**: Screenshots taken on test failures

## 🏛️ Architecture

### Page Object Model (POM)
The project follows the Page Object Model design pattern:

- **Page Objects**: Each module has its own page object file
- **Locators**: Centralized in `resources/locators.robot`
- **Keywords**: Reusable keywords in `resources/keywords/common_keywords.robot`
- **Test Data**: Managed in `test_data/test_data.robot`

### Key Features

#### Robust Element Handling
- Flexible locators with fallback options
- Dynamic wait strategies
- Optional verification steps
- Error handling with `Run Keyword And Return Status`

#### Test Data Management
- Unique data generation using timestamps
- Dictionary-based test data structure
- Configurable test data parameters

#### Browser Optimization
- Performance-focused browser options
- Reduced wait times for faster execution
- Optimized for Chrome browser

## 🏷️ Test Tags

| Tag | Description | Usage |
|-----|-------------|-------|
| `smoke` | Critical functionality tests | `--include smoke` |
| `regression` | Comprehensive functionality tests | `--include regression` |
| `fast` | Optimized for quick execution | `--include fast` |
| `pim` | PIM module specific tests | `--include pim` |
| `recruitment` | Recruitment module specific tests | `--include recruitment` |
| `admin` | Admin module specific tests | `--include admin` |

## 🛠️ Troubleshooting

### Common Issues

1. **"robot is not recognized"**
   - Ensure virtual environment is activated
   - Verify Robot Framework is installed: `pip install robotframework`

2. **Browser Driver Issues**
   - Chrome browser should be installed
   - WebDriver Manager handles driver installation automatically

3. **Element Not Found Errors**
   - Tests include fallback mechanisms for UI changes
   - Check if OrangeHRM demo site is accessible
   - Verify network connectivity

4. **Test Failures**
   - Check screenshots in `results/` directory
   - Review detailed logs in `log.html`
   - OrangeHRM demo site may have UI changes

### Performance Optimization

- Use `--include fast` tag for optimized execution
- Use `--loglevel WARN` for minimal logging
- Tests are designed with reduced wait times
- Browser performance options are enabled

## 📝 Best Practices Implemented

### Code Quality
- Page Object Model implementation
- Reusable keywords and functions
- Clean, maintainable code structure
- Proper documentation and comments

### Test Design
- Independent test cases
- Proper test data management
- Meaningful test names and descriptions
- Appropriate test tags for categorization

### Error Handling
- Graceful failure handling
- Optional verification steps
- Screenshot capture on failures
- Detailed logging for debugging

## 🤝 Contributing

1. Follow the existing code structure
2. Add appropriate test tags
3. Include proper documentation
4. Ensure tests are independent
5. Use meaningful test data

## 📄 License

This project is created for educational and demonstration purposes.

## 📞 Support

For issues and questions:
1. Check the troubleshooting section
2. Review test logs and screenshots
3. Verify OrangeHRM demo site accessibility
4. Ensure all dependencies are installed

---

**Note**: This test suite is designed for the OrangeHRM demo site and may require adjustments for other environments or UI changes. 