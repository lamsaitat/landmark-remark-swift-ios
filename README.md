# Landmark Remark
### Written by Sai Tat Lam (Kelvin)
---
This project is developed for Tigerspike's evaluation.

## Building the Project
1. This project makes use of Cocoapods, if you haven't installed Cocoapods on the build machine, please follow the instructions on https://cocoapods.org/
2. Install the latest [Xcode developer tools](https://developer.apple.com/xcode/downloads/) from Apple, this project is built using Xcode 10.2.1 (MacOS Mojave), using Swift 5.
3. Pull in the project dependencies:
```
# Open Terminal
# cd <project_root>
pod install
```
4. Open `LandmarkRemark.xcworkspace` in Xcode.
5. Build the `LandmarkRemark` scheme in Xcode.


## Third-party libraries
1. **Cocoapods** - Libraries and packages management
1. **SwiftLint** - I've included SwiftLint into the Podfile as a dependency.  The advantage is that it is directly integrated into the codebase to enforce a style-guide is in place.  This ensures consistent readability.