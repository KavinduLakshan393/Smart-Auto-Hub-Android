# Smart Auto Hub Mobile App

This is the native Flutter mobile application for the Smart Auto Hub platform.

## Features
- Vehicle Catalog and Browsing
- Consultation Booking
- AI Chatbot via Python RAG backend
- Authentication & Onboarding

## Getting Started

1. Install [Flutter](https://docs.flutter.dev/get-started/install).
2. Clone the repository.
3. Run `flutter pub get` to install dependencies.
4. Update `lib/core/constants/api_endpoints.dart` with your local Next.js and Python RAG backend URLs if testing locally.
5. Run `flutter run` to launch the application.

## Project Structure
We follow a feature-driven folder architecture as outlined in the `lib/` directory. Core styling and network are centralized under `lib/core/`.
