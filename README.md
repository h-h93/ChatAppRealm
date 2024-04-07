Description

This project is an instant messaging app designed as a take-home test for Muzz. The app allows users to send and receive messages in real-time, providing a seamless communication experience.

Assumptions

User Authentication: It's assumed that the app includes a user authentication system, allowing users to log in, and securely authenticate their identities. It can be easily extended to allow users to register.

Real-Time Messaging: The messaging functionality is assumed to be real-time, meaning that messages are delivered instantly to the recipient without delay.

Database: The app is assumed to utilise a Realm database system to store user data, including messages, user profiles, and authentication information.

User Interface: The user interface is assumed to be intuitive and user-friendly, providing a seamless messaging experience. It's designed to be visually appealing and easy to navigate. Much like the iMessage app.

Security: Security measures are assumed to be implemented to protect user data, including encryption of messages during transmission and secure storage of user credentials.

Implementation Decisions

Technology Stack: The app is implemented using Swift with UIKit, chosen for its robustness, scalability, and suitability for real-time applications.

Database Choice: Realm is chosen as the database system for its reliability, performance, and compatibility with the chosen technology stack.

User Interface Design: The user interface is designed to follow Apples interface guidlines, ensuring consistency and a modern look and feel. The App works in both light and dark mode.

Authentication Mechanism: Realms default authentication is implemented to securely manage user authentication, protecting user accounts from unauthorized access.

Error Handling: Robust error handling mechanisms are implemented throughout the app to handle unexpected situations gracefully and provide meaningful feedback to users.

Getting Started

To run the app locally, follow these steps:

Clone the repository to your local machine.
Install:
Input Accessory View - https://github.com/nathantannar4/InputBarAccessoryView
Realm - https://github.com/realm/realm-swift

Configure:
Clone and run no need to configure

Run the app using:
Device or simulator(requires Xcode)

Contributing

Contributions are welcome! If you'd like to contribute to the project, please follow these guidelines:

Fork the repository
Create a new branch
Make your changes
Submit a pull request
License

This project is licensed under the unlicense - see the LICENSE file for details.
