User Fetching App

A Flutter application demonstrating Domain-Driven Design (DDD) architecture, Riverpod state management, API integration, and responsive UI design. This app fetches a list of users, displays them on a home screen, and shows detailed user information including location links to Google Maps.

Packages Used

flutter_riverpod – State management

go_router – Navigation & routing

url_launcher – Open external URLs (Google Maps)

flutter_screenutil – Responsive UI scaling (optional)

Screenshots
![user details](https://github.com/user-attachments/assets/2bdf8696-132e-4f7e-8ef7-995fe913c4c4)
![splash screen](https://github.com/user-attachments/assets/d0a5e195-c3da-4dde-bcf9-d3f711b9d747)
![search list](https://github.com/user-attachments/assets/156d1b7c-6e98-4b64-a78c-eef703cbe7e2)
![home with search](https://github.com/user-attachments/assets/ecc324d7-c707-4960-8684-5750197c6ec5)
![home screen](https://github.com/user-attachments/assets/ece0c604-627f-4506-b11f-b48bbe9f618a)

Project Structure

lib/
│   main.dart
│
├───application
│       search_query_provider.dart     # Riverpod provider for search queries
│       show_search_provider.dart      # Riverpod provider to toggle search bar visibility
│       users_provider.dart            # Riverpod provider for fetching user list
│
├───core
│   ├───config
│   │   ├───api_config
│   │   │       api_config.dart        # Base API configurations
│   │   │       api_endpoints.dart     # API endpoint definitions
│   │   │
│   │   └───routes_onfig
│   │           app_routes.dart        # GoRouter route definitions
│   │           app_screens.dart       # Named route constants
│   │           router.dart            # App router initialization
│   │
│   ├───constants
│   │   ├───app_colors
│   │   │       app_colors.dart        # Application color palette
│   │   │
│   │   ├───app_strings
│   │   └───asset_paths
│   │           app_assets.dart        # Asset path constants
│   │
│   └───util
│           responsive_util.dart       # Utility for scaling UI elements responsively
│
├───domain
│   ├───failures
│   │       api_failures.dart          # Custom API failure classes
│   │       api_failures.freezed.dart  # Generated code for failures
│   │
│   └───models
│           user_model.dart            # User model class
│
├───infrastructure
│   ├───helpers
│   │       # Helper utilities (empty / extendable)
│   └───services
│       └───api_services
│               api_response_handler.dart   # Handles API responses and errors
│               fetch_users.dart            # Fetch users from API
│
└───presentation
    ├───home_screen
    │       home_screen.dart               # Home screen UI
    │   └───widgets
    │           home_shimmer.dart          # Shimmer effect while loading
    │
    ├───splash_screen
    │       splash_screen.dart             # Splash screen UI
    │
    ├───user_details_screen
    │       user_details_screen.dart       # User details UI
    │
    └───widgets
            # Common reusable widgets (if any)


  Notes

Project follows DDD architecture, separating domain, application, infrastructure, and presentation layers.

Centralized constants: AppColors, AppAssets, AppStrings.

Pull-to-refresh implemented via Riverpod’s provider refresh.

UI is consistent and fully responsive with ResponsiveHelper.
