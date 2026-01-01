# HRMS - Human Resource Management System

A comprehensive Flutter-based mobile application for managing human resources within an organization. This application provides role-based access for HR personnel and employees, streamlining various HR processes.

## Features

### For HR:
- **Dashboard:** An overview of key metrics like total employees, pending leave requests, and daily attendance.
- **Employee Management:**
    - View a complete list of all employees.
    - Add, edit, or remove employee profiles.
    - Approve or reject update requests from employees.
- **Attendance Management:**
    - Generate QR codes for attendance marking.
    - View a real-time list of checked-in employees for the day.
- **Leave Management:**
    - Review and manage leave requests from employees (approve/reject).
    - View a history of all leave requests.
- **Project Management:**
    - Create and manage company projects.
    - Assign projects to clients and set deadlines.
    - Track project status (e.g., On Hold, In Progress, Pending).
- **Client Management:** Manage client information.
- **Department Management:** Organize employees into different departments.

### For Employees:
- **Profile:** View and request updates to their personal and professional information.
- **Attendance:** Mark attendance by scanning a QR code, with location verification.
- **Leave Application:** Submit leave requests with details like reason and duration.
- **View Projects:** See the projects they are assigned to.

### General Features:
- **Authentication:** Secure login for both HR and employees.
- **Role-Based Access Control:** The app's UI and features adapt based on whether the user is an HR admin or an employee.
- **Dark Mode:** A theme provider allows users to switch between light and dark themes.

## Technologies Used

- **Frontend:** Flutter
- **Backend & Database:** Firebase (Firestore, Firebase Authentication)
- **State Management:** Provider
- **Key Packages:**
    - `cloud_firestore`: For database interactions.
    - `firebase_auth`: For user authentication.
    - `provider`: For state management.
    - `qr_flutter` & `mobile_scanner`: For QR code generation and scanning.
    - `geolocator`: For location-based services.
    - `image_picker` & `file_picker`: For handling file and image uploads.
    - `intl`: For date formatting.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

### Prerequisites

- Flutter SDK
- A code editor like VS Code or Android Studio
- A Firebase project

### Installation

1.  **Clone the repository:**
    ```sh
    git clone https://github.com/Rajdip1/HRMS.git
    ```
2.  **Navigate to the project directory:**
    ```sh
    cd HRMS
    ```
3.  **Install dependencies:**
    ```sh
    flutter pub get
    ```
4.  **Set up Firebase:**
    - Create a new Firebase project.
    - Add an Android and/or iOS app to your Firebase project.
    - Follow the Firebase setup instructions to add the `google-services.json` file to the `android/app` directory and the `GoogleService-Info.plist` file to the `ios/Runner` directory.
    - Enable Firebase Authentication (Email/Password).
    - Set up Firestore and create the necessary collections (`users`, `leave_requests`, `requests`, etc.).

5.  **Run the application:**
    ```sh
    flutter run
    ```

## Project Structure

```
lib/
├── attendance/         # Attendance related screens and logic
├── authentication screens/ # Sign-in, sign-up screens
├── employee_management/  # Employee profile and management screens
├── leave_management/   # Leave request and approval screens
├── models/             # Data models for the application
├── providers/          # State management providers (e.g., ThemeProvider)
├── screens/            # Main screens like Dashboard, Settings, etc.
├── services/           # Backend services (e.g., Database, Auth)
├── main.dart           # Main entry point of the application
└── wrapper.dart        # Handles user authentication state
```

## Contributing

Contributions are welcome! Please feel free to submit a pull request or open an issue if you have any suggestions or find any bugs.

