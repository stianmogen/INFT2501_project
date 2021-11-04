# inft_2501_project

Hangman Flutter project for the course INFT2501

## Development information

The project was developed using an emulator of the Google Pixel 2 running on Android 12.0 (S).
The project does support Android versions as low as 7.0 (Nougat).

### Clone project

HTTPS:
```
git clone https://github.com/stianmogen/INFT2501_project.git
```
SSH:
```
git@github.com:stianmogen/INFT2501_project.git
```

### Getting started with Flutter

You have to have Flutter installed on your computer, detailed documentation:

- Windows: https://flutter.dev/docs/get-started/install/windows

- macOS: https://flutter.dev/docs/get-started/install/macos


### Install Flutter SDK
```
git clone https://github.com/flutter/flutter.git -b stable
```
The sdk can also be manually installed from the provided references. 


### Update your path
If you wish to run Flutter commands outside of Flutter terminal, add Flutter to PATH environment variables.

- From the Start search bar, enter ‘env’ and select Edit environment variables for your account.
- Under User variables check if there is an entry called Path:
- If the entry exists, append the full path to flutter\bin using ; as a separator from existing values.
- If the entry doesn’t exist, create a new user variable named Path with the full path to flutter\bin as its value.

Run: 
```
flutter doctor
```
to check if there are any missing dependencies


### Set up Android Studio for Flutter with Emulator

Android Studio is mandatory in this course. Make sure it is install with the Android SDK to run in Android Studio. 

- Install Flutter plugin. (File -> Settings -> Plugins --> FLutter --> Install).
- Install Dart plugin. (File -> Settings -> Plugins --> Dart --> Install).

Restart your IDE after this is done.

Be aware that the SDK path for Flutter and Dart may not be configuered automatically in Andriod Studio by default.

If you encounter the issue where devices are stuck on "loading", these can be configured from (File -> Settings -> Languages and Frameworks).

This issue is descriped and solved in this forum post: https://stackoverflow.com/questions/48650831/dart-sdk-is-not-configured


### Run Program

You may now run the Hangman application from Android Studio with your preffered emulator.
Run main.dart, make sure your device is selected.

