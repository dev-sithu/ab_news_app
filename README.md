# AB NEWS

A simple **AB NEWS** flutter mobile application using the [HackerNews public API](https://github.com/HackerNews/API).

## User Stories

This application is developed based on the following user stories:

- As a User, I want to signup and signin to **AB NEWS** using a username and password (NOT HackerNews login).
- As a User, I want to see recent **AB NEWS** posts on the homepage.
- As a User, I want to save **AB NEWS** posts to my account.
- As a User, I want to see **AB NEWS** posts saved in my account

## Installation

Install Flutter in your local machine according to the doc https://docs.flutter.dev/get-started/install/windows/mobile?tab=virtual

Then clone the repo and setup,

    git clone https://github.com/dev-sithu/ab_news_app
    cd ab_news_app
    flutter pub get

In VS Code, press **F5** to run the app with web platform option.

## About Dependencies

- HTTP request: `dio`
- Open an external URL with a new tab: `url_launcher`
- Database: `drift`, `sqlite3`, `sqlite3_flutter_libs`, `path`, `path_provider`, `drift_dev`, `build_runner`
- Dependency injection: `get_it`
- Password hashing: `dbcrypt` (hashing is a bit slower in debug mode rather than release mode)
- Secure local storage: `flutter_secure_storage` (for user session)
- State management: `provider`
- Alert message: `toastification` (currently not using it because of AnimationController dispose more than once error; SnackBar is used instead)


## Improvements

- ~~User logout~~
- Add full name entry to user registration (users.fullname in db)
- ~~Faster password hashing in register/login form submit~~
- ~~Better form validation~~
- Better error handling
- ~~Prevent API recall on tab switch (add swipe down event to update data or add a refresh button)~~
- ~~Infinite scroll for news list in home page~~
- Internationalization
