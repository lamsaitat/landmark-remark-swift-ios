# Landmark Remark
### Written by Sai Tat Lam (Kelvin)
---
This project is developed for Tigerspike's evaluation.

## Building the Project
1. This project makes use of Cocoapods, if you haven't installed Cocoapods on the build machine, please follow the instructions on https://cocoapods.org/
2. Install the latest [Xcode developer tools](https://developer.apple.com/xcode/downloads/) from Apple, this project is built using Xcode 10.2.1(10E1001), MacOS Mojave, using Swift 5.
3. Pull in the project dependencies:
```
# Open Terminal
# cd <project_root>
pod install
```
4. Open `LandmarkRemark.xcworkspace` in Xcode.
5. Build the `LandmarkRemark` scheme in Xcode.


## Architecture
The project is written with MVVM, with the exception of the LandmarkViewController which serves as a container controller with observer that orders the map view and list view to reload data during a data source update.

The application contains 2 entry points based on the login state:
1. LoginViewController - The application starts via this screen when there is no current session of a logged in user.  A user can perform log in on this screen or signs up by tapping the "New user? Sign up here" button.  When a user successfully signs up, the application will automatically perform a login and enters the logged in flow.
1. LandmarkViewController - This screen becomes the root view controller when there is a logged in user, either from a persisted session at launch or after a successful login.  The LandmarkViewController features a segmented controller where the user can view a collection of crowd saved notes via map view or list view.  
1.1 The map view displays saved notes as a pin annotation with callout upon tapping on it, as well as the device's current location.  (Spec requirement #1, #3, #4)  
1.2 The list view displays the geo-coordinates of the notes, the message and the author as a table view, with a search bar that allows user to search note by message or username. (Spec requirement #4 #5)
1. ComposeNewNoteViewController - When a user taps the compose button on the right of the navigation bar while in LandmarkViewController screen, the ComposeNewNoteViewController screen presents to allow user to compose a new note on the device's current location.  (Spec requirement #2)

### Time spent on components
1. Login / Signup - 3 Hours
2. LandmarkViewController - 2 Hours
3. LandmarkMapViewController - 3 Hours
4. LandmarkListViewController - 1.5 Hour
5. LandmarkListViewController (Search bar) 1 Hour
6. Composing new note - 2 Hours
Total: 12.5 man-Hours

## Implicit Requirements
Backend component - As the spec identifies, the app needs to sync with notes published by multiple users who use the same app / service.  I have set up a Firebase Realtime Database to drive the backend aspect of the app.

## Third-party libraries
While the spec did specify to use no third party libraries except those explicitly called out, I have included a small amount of libraries, with reasons detailed below.
1. **Cocoapods** - Libraries and packages management
1. **SwiftLint** - I've included SwiftLint into the Podfile as a dependency.  The advantage is that it is directly integrated into the codebase to enforce a style-guide is in place.  This ensures consistent readability.
1. **Firebase** - Since I have chosen to use Firebase as a BaaS for the backend component for the app, it makes sense to use the official Firebase iOS SDK instead of reinventing the wheel to write my own API adapter.


## Limitations
Network request mocking (Firebase) - With this project, given the time constraint I was unable to set up a reliable way to to stub out Firebase's network request to provide an isolated controlled environment to run certain unit tests.  Ideally, and in the past, I have used libraries such as OHHTTPStubs and Swifter to mock the API in order to perform unit tests using TDD approach, as such it introduces inconsistency into UI Testing, therefore I have decided against writing UI test cases until I'm able to figure out how to mock the Firebase environment.
