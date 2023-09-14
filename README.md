# PARKZ - Find Parking App (Flutter)


## Table of Contents
- [Introduction](#introduction)
- [Features](#features)
- [Getting Started](#getting-started)
- [Application preview](#application-preview)
- [Contributing](#contributing)
- [For More Information](#for-more-information)


## Introduction

The "Find Parking" app - **PARKZ**, built with Flutter, is a convenient solution for drivers who often face the challenge of finding available parking spaces, especially in busy urban areas. This repository contains the source code for the Flutter-based app, allowing you to deploy and customize it according to your specific needs.

**Graduation Project:** This app is the result of a graduation project that was conceptualized and completed in 14 weeks. The project was a collaborative effort by a team of four individuals, with Tran Ngoc Thang playing the main role in coding this mobile app.

![alt text](https://github.com/ParkZ-CapstoneProject/parkz-mobile-app/blob/main/screenshot/mockup.png?raw=true)


## Features

- **Find Parking Based on Destination:** Our app simplifies the parking process by suggesting nearby parking options based on the user's specified destination. Say goodbye to endless searching for a parking spot!

- **Real-Time Parking Information:** Access up-to-date information on parking availability, pricing, and the precise location of parking facilities. No more guessing games.

- **Reservation and Booking:** Reserve parking spots in advance to ensure a hassle-free parking experience. Enjoy peace of mind knowing you have a guaranteed spot waiting for you.

- **QR Code Integration:** Seamlessly check in and check out of parking locations using QR codes. It's quick, secure, and efficient.

- **User Profile Management:** Create and manage user profiles with ease. Store your preferences and payment methods for a smoother user experience.

- **Notification System:** Stay informed with timely notifications about your reservations, bookings, and important updates. We keep you in the loop.

- **User Ratings:** Share your parking experiences by rating and reviewing parking spots. Help fellow drivers make informed decisions.

## Getting Started

### Prerequisites

Before you begin, make sure you have the following prerequisites installed:

- [Flutter](https://docs.flutter.dev/get-started/install/windows)
- [Git](https://github.com/git-guides/install-git)

### Installation

1. Clone the repository:

   ```shell
   git clone https://github.com/ParkZ-CapstoneProject/parkz-mobile-app.git
   ```
1. Navigate to the project directory:

   ```shell
   cd parkz-mobile-app
   ```
1. Install dependencies:

   ```shell
    flutter pub get
   ```
1. Connect to a real or emulated mobile device then:
    ```shell
    flutter run
   ```
### Configuration

To run the app and make use of Firebase services, follow these steps:

1. **Create a Firebase Project:**
    - Go to the [Firebase Console](https://console.firebase.google.com/).
    - Click on "Add project" and follow the setup instructions to create a new Firebase project.

2. **Add Your App to Firebase:**
    - In the Firebase project dashboard, click on "Add app" and select the appropriate platform (iOS/Android).
    - Follow the on-screen instructions to register your app. This will provide you with configuration files.

3. **Integrate Firebase Configuration Files:**
    - For Android:
        - Download the `google-services.json` file from Firebase and place it in the `android/app` directory of your Flutter project.
    - For iOS:
        - Download the `GoogleService-Info.plist` file from Firebase and place it in the `ios/Runner` directory of your Flutter project.

## Application preview

<div align="center">
  <img src="https://github.com/ParkZ-CapstoneProject/parkz-mobile-app/blob/main/screenshot/home.jpg?raw=true" alt="Customer Mobile Login" width="25%"> &nbsp;&nbsp; <img src="https://github.com/ParkZ-CapstoneProject/parkz-mobile-app/blob/main/screenshot/map.jpg?raw=true" alt="Customer Mobile Map" width="25%"> &nbsp;&nbsp; <img src="https://github.com/ParkZ-CapstoneProject/parkz-mobile-app/blob/main/screenshot/qr.jpg?raw=true" alt="Customer Mobile QR" width="25%"> &nbsp;&nbsp; 
</div>


## Contributing
- **Trần Ngọc Thắng** - Leader
    - Role: Business Analyst, Mobile Developer, Database Designer, App Designer, Scrum Master

- **Trần Thành Đạt**
    - Role: Scrum Master, Backend Developer

- **Trương Công Chính**
    - Role: Backend Developer

- **Đỗ Anh Linh**
    - Role: Frontend Developer, Web Designer

- **Ms. Nguyễn Thị Cẩm Hương**
    - Role: Supervisor

## For More Information

For detailed information about the "PARKZ - Find Parking" app, its development process, please refer to the [project documentation](https://docs.google.com/document/d/1pGVQFGTXT_5H8IZ2BTEgM5QbLJEohTK1xgvoX5d4AFg/edit?usp=sharing).



