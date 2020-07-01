# puzzl-iOS
Puzzl iOS SDK for rendering Puzzl's Employee Onboarding flow

## Add Puzzl SDK to a project

### Using CocoaPods

1. You can use CocoaPods ("CocoaPods is an open source dependency manager for Swift and Objective-C Cocoa projects. CocoaPods makes it easy to install or update new SDKs when working with Xcode.") 

```bash
$ sudo gem install cocoapods
```

1. Create a Podfile in project directory (same directory as .xcodeproj file)
2. Open Podfile and include the PuzzlIOS dependency. **You have to also add other dependencies that Puzzl relies on.** An example is shown here: 

```bash
target "YourProjectNameHere" do
use_frameworks!
	pod 'PuzzlIOS'
	pod 'Alamofire', '4.9.0'
  pod 'VeriffSDK'
  pod 'Eureka'
  pod 'TTTAttributedLabel'
end
```

1. Run 'pod install' in directory of Podfile

```bash
$ pod install
```

1. To update the SDK at any time, run 'pod update' to get the most recent version of the Puzzl iOS SDK.
2. **After installation is done, use the newly created .xcworkspace file of your project.**

### **Manually**

If you prefer not to use any of the aforementioned dependency managers, you can integrate Puzzl into your project manually.

- Open up Terminal, `cd` into your top-level project directory, and run the following command "if" your project is not initialized as a git repository:

    ```bash
    $ git init
    ```

- Add Puzzl as a git [submodule](https://git-scm.com/docs/git-submodule) by running the following command:

    ```bash
    $ git submodule add https://gitlab.com/puzzl/puzzl-ios-mobile-onboarding.git
    ```

- Open the new Puzzl folder, and drag the `Puzzl-iOS.xcodeproj` into the Project Navigator of your application's Xcode project.

    > It should appear nested underneath your application's blue project icon. Whether it is above or below all the other Xcode groups does not matter.

- Select the `Puzzl-iOS.xcodeproj` in the Project Navigator and verify the deployment target matches that of your application target (under General > Deployment Info).
- Next, select your application project in the Project Navigator (blue project icon) to navigate to the target configuration window and select the application target under the "Targets" heading in the sidebar.
- In the tab bar at the top of that window, open the "General" panel.
- Click on the `+` button under the "Frameworks, Libraries, and Embedded Content" section.
- Select the 'Puzzl_iOS.framework' and click 'Add'.
- Once added, choose the 'Embed and Sign' option under the Embed column (still under the "Frameworks, Libraries, and Embedded Content" section).
- And that's it!

    > The Puzzl_iOS.framework is automatically added as a target dependency, linked framework and embedded framework in a copy files build phase which is all you need to build on the simulator and a device.

- **Note:** Puzzl requires other dependencies. Please integrate these other frameworks manually or use a dependency manager:
    - 'Alamofire', '4.9.0'
    - 'VeriffSDK'
    - 'Eureka'
    - 'TTTAttributedLabel'

## Using the Puzzl iOS SDK

1. **Add usage descriptions to application Info.plist**

> Not adding these usage descriptions causes system to kill application when it requests the permissions when needed.

Veriff iOS SDK requires camera and microphone permissions for capturing photos an video during identification. Your application is responsible to describe the reason why camera and microphone is used. You must add 2 descriptions listed below to `info.plist` of your application with the explanation of the usage.

- `NSCameraUsageDescription`
- `NSMicrophoneUsageDescription`

1. Import Puzzl into your code. In order to use the Puzzl SDK, import it in the class that will use the SDK (typically a View Controller).

    ```swift
    import Puzzl_iOS
    ```

2. In the place you want to trigger Puzzl's onboarding, set the delegate in order to follow the Puzzl Onboarding SDK status and allow Puzzl to show onboarding. Example:

    ```swift
    Puzzl.setDelegate(from: <YOUR VIEW CONTROLLER>)

    Example:

    Puzzl.setDelegate(from: self)
    ```

3. Call the 'showOnboardingWith' method from Puzzl. Example:

    ```swift
    Puzzl.setDelegate(from: <YOUR VIEW CONTROLLER>)
    Puzzl.showOnboardingWith(apiKey: <PUZZL LIVE KEY>,
                             companyID: <PUZZL COMPANY ID>,
                             workerID: <PUZZL EMPLOYEE ID>,
                             from: <YOUR VIEW CONTROLLER>)
    ```

4. To track the status of the Puzzl onboarding process, create a new method:

    ```swift
    extension ViewController: PuzzlDelegate {
        func getStatus(status: PuzzlStatus) {
            switch status {
            case .error:
                print("Error")
    						//handle error in onboarding
            case .success:						
                print("Success")
    						//handle successful onboarding
            }
        }
    }
    ```

    Once the worker onboards successfully, you can now run payroll for them!
