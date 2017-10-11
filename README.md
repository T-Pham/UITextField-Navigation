```
'           __________________ _______          _________ _______ _________ _______  _        ______  
'  |\     /|\__   __/\__   __/(  ____ \|\     /|\__   __/(  ____ \\__   __/(  ____ \( \      (  __  \ 
'  | )   ( |   ) (      ) (   | (    \/( \   / )   ) (   | (    \/   ) (   | (    \/| (      | (  \  )
'  | |   | |   | |      | |   | (__     \ (_) /    | |   | (__       | |   | (__    | |      | |   ) |
'  | |   | |   | |      | |   |  __)     ) _ (     | |   |  __)      | |   |  __)   | |      | |   | |
'  | |   | |   | |      | |   | (       / ( ) \    | |   | (         | |   | (      | |      | |   ) |
'  | (___) |___) (___   | |   | (____/\( /   \ )   | |   | )      ___) (___| (____/\| (____/\| (__/  )
'  (_______)\_______/   )_(   (_______/|/     \|   )_(   |/       \_______/(_______/(_______/(______/ 
'                                                                                                     
'   _        _______          _________ _______  _______ __________________ _______  _                
'  ( (    /|(  ___  )|\     /|\__   __/(  ____ \(  ___  )\__   __/\__   __/(  ___  )( (    /|         
'  |  \  ( || (   ) || )   ( |   ) (   | (    \/| (   ) |   ) (      ) (   | (   ) ||  \  ( |         
'  |   \ | || (___) || |   | |   | |   | |      | (___) |   | |      | |   | |   | ||   \ | |         
'  | (\ \) ||  ___  |( (   ) )   | |   | | ____ |  ___  |   | |      | |   | |   | || (\ \) |         
'  | | \   || (   ) | \ \_/ /    | |   | | \_  )| (   ) |   | |      | |   | |   | || | \   |         
'  | )  \  || )   ( |  \   /  ___) (___| (___) || )   ( |   | |   ___) (___| (___) || )  \  |         
'  |/    )_)|/     \|   \_/   \_______/(_______)|/     \|   )_(   \_______/(_______)|/    )_)         
'                                                                                                     
```

# UITextField-Navigation

[![CI Status](https://img.shields.io/travis/T-Pham/UITextField-Navigation/master.svg?style=flat-square)](https://travis-ci.org/T-Pham/UITextField-Navigation)
[![GitHub issues](https://img.shields.io/github/issues/T-Pham/UITextField-Navigation.svg?style=flat-square)](https://github.com/T-Pham/UITextField-Navigation/issues)
[![Codecov](https://img.shields.io/codecov/c/github/T-Pham/UITextField-Navigation.svg?style=flat-square)](https://codecov.io/gh/T-Pham/UITextField-Navigation)
[![Documentation](https://img.shields.io/cocoapods/metrics/doc-percent/UITextField-Navigation.svg?style=flat-square)](http://cocoadocs.org/docsets/UITextField-Navigation)

[![GitHub release](https://img.shields.io/github/tag/T-Pham/UITextField-Navigation.svg?style=flat-square&label=release)](https://github.com/T-Pham/UITextField-Navigation/releases)
[![Platform](https://img.shields.io/cocoapods/p/UITextField-Navigation.svg?style=flat-square)](https://github.com/T-Pham/UITextField-Navigation)
[![License](https://img.shields.io/cocoapods/l/UITextField-Navigation.svg?style=flat-square)](LICENSE)

[![Carthage](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat-square)](https://github.com/Carthage/Carthage)

[![CocoaPods](https://img.shields.io/badge/CocoaPods-compatible-4BC51D.svg?style=flat-square)](https://cocoapods.org/pods/UITextField-Navigation)
[![CocoaPods downloads](https://img.shields.io/cocoapods/dt/UITextField-Navigation.svg?style=flat-square)](https://cocoapods.org/pods/UITextField-Navigation)

[![Say thanks!](https://img.shields.io/badge/Say%20Thanks!-🦉-1EAEDB.svg?style=flat-square)](https://saythanks.io/to/T-Pham)

## Description

UITextField-Navigation adds next, previous and done buttons to the keyboard for your `UITextField`s and `UITextView`s. It allows you to specify a next field either on the Interface Builder or programmatically. Then, you can access next and previous fields of each `UITextField` or `UITextView` easily.

The UI is [**highly customizable**](#ui-customization).

To run the example project:

`pod try UITextField-Navigation`

![Screenshot 0](https://github.com/T-Pham/UITextField-Navigation/blob/master/Screenshots/screenshot0.png?raw=true)
![Screenshot 1](https://github.com/T-Pham/UITextField-Navigation/blob/master/Screenshots/screenshot1.png?raw=true)
![Screenshot 2](https://github.com/T-Pham/UITextField-Navigation/blob/master/Screenshots/screenshot2.gif?raw=true)

## Usage

### Basic

You can set the `nextNavigationField` property for each `UITextField` and `UITextView` either on the Interface Builder or programmatically. The `previousNavigationField` property will be set on the other `UITextField` or `UITextView` automatically for you.

Example:

```swift
import UITextField_Navigation

...
let textField = UITextField()
let textView = UITextView()
textField.nextNavigationField = textView

assert(textView == textField.nextNavigationField)
assert(textField == textView.previousNavigationField)
```

Please note that the `nextNavigationField` and `previousNavigationField` properties are not retained.

### Capturing taps

To capture taps on the next, previous and done buttons, assign a `delegate` to your `NavigationField`, which is a `UITextField` or `UITextView`, also either on the Interface Builder or programmatically. Then implement the `NavigationFieldDelegate` protocol (in addition to the `UITextFieldDelegate` or `UITextViewDelegate` protocol) for the `delegate`.
Please note that you have to explicitly declare that the `delegate` conforms to the `NavigationFieldDelegate` protocol to make it work.

<details open>
<summary>Swift:</summary>

```swift
import UIKit
import UITextField_Navigation

...
extension ViewController: NavigationFieldDelegate { // explicitly protocol conforming declaration

    func navigationFieldDidTapPreviousButton(_ navigationField: NavigationField) {
        navigationField.previousNavigationField?.becomeFirstResponder()
        // your custom work
    }

    func navigationFieldDidTapNextButton(_ navigationField: NavigationField) {
        navigationField.nextNavigationField?.becomeFirstResponder()
        // your custom work
    }

    func navigationFieldDidTapDoneButton(_ navigationField: NavigationField) {
        navigationField.resignFirstResponder()
        // your custom work
    }
}
```

</details>

<details>
<summary>Objective-C:</summary>

```objective-c
@import UITextField_Navigation;
#import "ViewController.h"

@interface ViewController () <NavigationFieldDelegate> // explicitly protocol conforming declaration

...
#pragma mark - NavigationFieldDelegate

- (void)navigationFieldDidTapPreviousButton:(id<NavigationField>)navigationField {
    [navigationField.previousNavigationField becomeFirstResponder];
    // your custom work
}

- (void)navigationFieldDidTapNextButton:(id<NavigationField>)navigationField {
    [navigationField.nextNavigationField becomeFirstResponder];
    // your custom work
}

- (void)navigationFieldDidTapDoneButton:(id<NavigationField>)navigationField {
    [navigationField resignFirstResponder];
    // your custom work
}
```

</details>

### UI Customization

#### Using UIAppearance

Modify the appearance proxy of the `NavigationFieldToolbar` and `NavigationFieldToolbarButtonItem` classes to customize the navigation view's UI for all fields.

```swift
NavigationFieldToolbar.appearance().barStyle = .black
NavigationFieldToolbar.appearance().backgroundColor = .purple
NavigationFieldToolbarButtonItem.appearance().tintColor = .white
```

![Screenshot 3](https://github.com/T-Pham/UITextField-Navigation/blob/master/Screenshots/screenshot3.png?raw=true)

#### Directly and adding more buttons

Alternatively, you can directly modify the UI of each navigation view by accessing the `navigationFieldToolbar` property of a `UITextField` or `UITextView`.

```swift
...
navigationField.navigationFieldToolbar?.barStyle = .default
navigationField.navigationFieldToolbar?.backgroundColor = .red
navigationField.navigationFieldToolbar?.previousButton.title = "Previous"
navigationField.navigationFieldToolbar?.nextButton.title = "Next"
navigationField.navigationFieldToolbar?.doneButton.title = "Dismiss"

// Add a custom button
let customButton = UIBarButtonItem(title: "Custom", style: .plain, target: nil, action: nil)
let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
navigationField.navigationFieldToolbar?.items = [navigationField.navigationFieldToolbar!.previousButton, navigationField.navigationFieldToolbar!.nextButton, customButton, flexibleSpace, navigationField.navigationFieldToolbar!.doneButton]
```

![Screenshot 4](https://github.com/T-Pham/UITextField-Navigation/blob/master/Screenshots/screenshot4.png?raw=true)

## Installation

### [Carthage](https://github.com/Carthage/Carthage)

Add the line below to your Cartfile:

```ruby
github "T-Pham/UITextField-Navigation"
```

### [CocoaPods](https://cocoapods.org/pods/UITextField-Navigation)

Add the line below to your Podfile:

```ruby
pod 'UITextField-Navigation'
```

### Manually

1. Download and drop [`/UITextField-Navigation/Classes`](/UITextField-Navigation/Classes) folder in your project.
2. Congratulations!

## Compatibility
From version 2.0.0, Swift 3 syntax is used. If your project is still using Swift version 2, please use a UITextField-Navigation version prior to 2.0.0.

Podfile

```ruby
pod 'UITextField-Navigation', '~> 1.4.3'
```

or Cartfile

```ruby
github "T-Pham/UITextField-Navigation" ~> 1.4.3
```

## Apps that use UITextField-Navigation

Hello fellow developers. I can see that the library has been adopted in some apps. If your app also uses the library, it would be great if you can share it here. Please add it to the list below. Thanks!

1. [Catder - Random animated cat photos](https://itunes.apple.com/us/app/catder-random-animated-cat/id1123343798?ls=1&mt=8)
2. [Gradus - a Grade Calculator](https://itunes.apple.com/ca/app/gradus-a-grade-calculator/id1063184658?mt=8)

## License

UITextField-Navigation is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
