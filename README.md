# RescueSync

RescueSync is an SOS application that allows users to quickly connect and coordinate in emergency situations. **Beta Version: v0.1.0**  
*Note: This is a beta release. There is still a long way to go, and many features are yet to be implemented.*

RescueSync is built with Flutter/Dart for the frontend and PHP for the backend, leveraging a MySQL database for data storage. Currently, the app is designed to work on Android devices only.

<!-- Insert application images/screenshots here -->
<p align="center">
  <img src="https://github.com/user-attachments/assets/d7dfc207-01b1-46d4-a0bf-3516400135a1" width="150" style="margin: 0 5px;" />
  <img src="https://github.com/user-attachments/assets/7fca7cea-5abf-462c-8992-f5b41e2dfc34" width="150" style="margin: 0 5px;" />
  <img src="https://github.com/user-attachments/assets/47a32429-2a52-4348-9c49-d9a9ee41ffcd" width="150" style="margin: 0 5px;" />
  <img src="https://github.com/user-attachments/assets/aedde814-977b-4ab0-822d-5df8f3657b88" width="150" style="margin: 0 5px;" />
  <img src="https://github.com/user-attachments/assets/4b1e7448-f614-4702-999c-43f9007eb7a5" width="150" style="margin: 0 5px;" />
</p>



---

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Technologies](#technologies)
- [Installation & Setup](#installation--setup)
- [Building the APK](#building-the-apk)
- [Code Overview](#code-overview)
- [Contributing](#contributing)
- [License](#license)

---

## Overview

RescueSync is designed to provide a seamless SOS experience. Users can log in or register and then either join an existing room or share an invite code with someone else. When an invite code is used (either by someone else or when you use someone else's code), a new room is automatically created with roles such as **member**, **owner**, and **moderator**. These roles manage room settings and control member permissions like removing users or modifying room configurations.

---

## Features

- **User Authentication**: Secure login and registration system.
- **Room Management**: 
  - Create or join rooms using invite codes.
  - Automatic room creation when an invite code is used.
- **Role-Based Permissions**: 
  - Assign roles (member, owner, moderator) to control room management.
  - Permissions to remove users and adjust room settings.
- **Customizable SOS Settings**: 
  - Fully customizable SOS parameters (even the background playback duration can be tailored).
- **Backend Integration**: 
  - PHP backend with MySQL database.
  - JSON-based configuration (e.g., sendAccount JSON data fetching).
- **Firebase Integration**: 
  - Firebase setup is required (for Android; iOS is available for Firebase but not implemented for this app).

---

## Technologies

- **Frontend**: Flutter/Dart
- **Backend**: PHP
- **Database**: MySQL
- **Additional Services**: Firebase (Android configuration required)

---

## Installation & Setup

### 1. Firebase Setup (Android)

- Create a Firebase project and configure it for Android.
- Download the ```google-services.json``` file and place it in the appropriate directory (usually in the `android/app` folder).
- Follow the [Firebase documentation](https://firebase.google.com/docs/android/setup) for any additional configuration.

### 2. Backend (PHP & MySQL)

- Set up a PHP environment on your server.
- Install MySQL and configure it via phpMyAdmin or your preferred method.
- Import the necessary database schema and data into MySQL.
- Adjust the PHP configuration files as needed (e.g., database connection settings).

### 3. JSON Data

- Fetch the `sendAccount` JSON data as required by the application. Ensure that the URL or file path is correctly referenced in your PHP or Flutter code.

### 4. Flutter Environment

- Ensure you have Flutter installed and set up on your machine.
- Clone the repository and navigate to the project directory.
- Run the command to install all dependencies: ```flutter pub get```.

---

## Building the APK

Since RescueSync is currently an Android-only application, you can build the APK by running the command:

```flutter build apk```

After building, the APK will be available in the `build/app/outputs/flutter-apk/` directory. For convenience, the APK will also be provided in the packages folder of this repository.

---

## Code Overview

Below is a brief overview of the code structure and important components:

- **Authentication**: Handles user login and registration.
- **Room Management**: 
  - **Invite Codes**: When a user enters an invite code, the app checks its validity. If the code has already been used by someone else or if you join another user's room, a new room is created.
  - **Role Assignment**: After room creation, roles (member, owner, moderator) are assigned based on the invite code usage.
- **Room Settings**: 
  - Fully customizable settings related to SOS parameters.
  - Settings include options such as the duration for background playback during an SOS.
- **Backend Integration**: 
  - PHP scripts interact with the MySQL database for user data and room management.
  - The app fetches configuration data (e.g., sendAccount JSON) during startup.

*Note: More detailed code explanations and inline comments can be found directly within the source files.*

---

## Contributing

We welcome contributions to RescueSync. If you would like to help improve the project, please follow these steps:

1. Fork the repository.
2. Create a new branch (e.g., ```git checkout -b feature/YourFeature```).
3. Make your changes and commit them (e.g., ```git commit -m 'Add some feature'```).
4. Push to the branch (e.g., ```git push origin feature/YourFeature```).
5. Open a pull request detailing your changes.

### Example Contributor

- **Nativez** - *Has Server*

The main developer of this project is Marijua and the sole supporter is Nativez. This is made by Schweis.

---

## License

This project is licensed under the [GPL-3.0 License](LICENSE).

---

*For any further questions or support, please open an issue in the repository.*
