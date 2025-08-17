# JavaScript Developer Environment Setup for Windows

[![Version](https://img.shields.io/badge/version-1.0.0-blue)](https://github.com/JoshNuku/javascript-developer-environment-setup/releases)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE.txt)
[![Build Status](https://img.shields.io/badge/build-passing-brightgreen)](https://github.com/JoshNuku/javascript-developer-environment-setup)

A simple, one-click installer to set up a complete JavaScript development environment on a fresh Windows machine.

This tool uses a friendly Inno Setup wizard to guide the user and a powerful PowerShell script on the backend to automate the installation of essential tools and packages using the Chocolatey package manager. It is designed for new developers, students, or anyone looking to quickly provision a new Windows PC for modern web development.

![Installer Screenshot](https://raw.githubusercontent.com/JoshNuku/javascript-developer-environment-setup/main/assets/installer-screenshot.png)

## Features

This installer is configurable, allowing you to choose exactly which components you want to install.

**Core Tools:**

- [ ] **Git:** The essential version control system.
- [ ] **Node.js LTS:** The latest Long-Term Support version of Node.js.
- [ ] **Google Chrome:** The world's most popular browser for development and testing.

**Development Environment:**

- [ ] **Visual Studio Code:** The leading code editor for web development.

**Database:**

- [ ] **MongoDB:** The full MongoDB Community Edition server.
- [ ] **Mongo Shell (mongosh):** The modern, feature-rich command-line shell for MongoDB.

**Global NPM Packages:**

- [ ] **Core Dev Tools:** `eslint`, `prettier`, `typescript`, `nodemon`.
- [ ] **JS Frameworks:** `create-react-app`, `next`, `express`.

**VSCode Extensions:**

- [ ] **ESLint:** Integrates ESLint into VSCode.
- [ ] **Prettier - Code formatter:** The opinionated code formatter.
- [ ] **npm Intellisense:** Autocompletes npm modules in import statements.

## Getting Started (For Users)

No technical knowledge is required. Just download and run the installer.

1.  **Download the Installer**

    - Go to the [**Releases Page**](https://github.com/JoshNuku/javascript-developer-environment-setup/releases).
    - Download the latest `js-dev-env-setup.exe` file.

2.  **Run the Installer**

    - Double-click the downloaded `.exe` file.
    - **Note:** The installer requires administrator privileges to run. Windows Defender SmartScreen may show a warning because this is a new application. If it does, click **"More info"** and then **"Run anyway"**.

3.  **Select Components**

    - An installation wizard will appear. Check the boxes for the software you wish to install.
    - Follow the on-screen instructions. The PowerShell script will run in the background and install everything you selected.

4.  **Check the Log File**
    - Upon completion, a detailed log file named `js-dev-env-setup-log-....txt` will be saved to your **Public Documents** (`C:\Users\Public\Documents`). You can review this file to confirm what was installed or to troubleshoot any issues.

## Building from Source (For Developers)

If you want to modify or compile the installer yourself, follow these steps.

**Prerequisites:**

- [Git](https://git-scm.com/downloads)
- [Inno Setup](https://jrsoftware.org/isinfo.php) (the compiler for the installer)

**Steps:**

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/JoshNuku/javascript-developer-environment-setup.git
    cd javascript-developer-environment-setup
    ```
2.  **Open the Inno Setup script:**
    - Open the Inno Setup Compiler application.
    - Go to `File -> Open` and select the `setup-compiler.iss` file from the repository.
3.  **Compile the project:**
    - In the Inno Setup Compiler, click the **"Compile"** button (or press F9).
    - If successful, a new `js-dev-env-setup.exe` installer will be created.

## Contributing

Contributions are welcome! If you have ideas for new features, bug fixes, or improvements, please follow these steps:

1.  Open an [issue](https://github.com/JoshNuku/javascript-developer-environment-setup/issues) to discuss the proposed change.
2.  Fork the repository.
3.  Create a new branch (`git checkout -b feature/AmazingFeature`).
4.  Commit your changes (`git commit -m 'Add some AmazingFeature'`).
5.  Push to the branch (`git push origin feature/AmazingFeature`).
6.  Open a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE.txt](LICENSE.txt) file for details.
