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

[![CI Status](http://img.shields.io/travis/T-Pham/UITextField-Navigation.svg?style=flat-square)](https://travis-ci.org/T-Pham/UITextField-Navigation)
[![GitHub issues](https://img.shields.io/github/issues/T-Pham/UITextField-Navigation.svg?style=flat-square)](https://github.com/T-Pham/UITextField-Navigation/issues)
[![Codecov](https://img.shields.io/codecov/c/github/T-Pham/UITextField-Navigation.svg?style=flat-square)](https://codecov.io/gh/T-Pham/UITextField-Navigation)
[![Version](https://img.shields.io/cocoapods/v/UITextField-Navigation.svg?style=flat-square)](http://cocoapods.org/pods/UITextField-Navigation)
[![CocoaPods](https://img.shields.io/cocoapods/dt/UITextField-Navigation.svg?style=flat-square)](http://cocoapods.org/pods/UITextField-Navigation)
[![Platform](https://img.shields.io/cocoapods/p/UITextField-Navigation.svg?style=flat-square)](http://cocoapods.org/pods/UITextField-Navigation)
[![License](https://img.shields.io/cocoapods/l/UITextField-Navigation.svg?style=flat-square)](LICENSE)

## Description

UITextField-Navigation adds next, previous and done buttons to the keyboard for your `UITextField`s. It allows you to specify a next text field either on the Interface Builder or programmatically. Then, you can access next and previous text fields of each `UITextField` easily.

The UI is [**highly customizable**](#ui-customization).

To run the example project, run `pod try UITextField-Navigation`.

![Screenshot 1](https://github.com/T-Pham/UITextField-Navigation/blob/master/Screenshots/screenshot1.png?raw=true)
![Screenshot 2](https://github.com/T-Pham/UITextField-Navigation/blob/master/Screenshots/screenshot2.gif?raw=true)

## Usage

### Basic

You can set the `nextTextField` property for each `UITextField` either on the Interface Builder or programmatically. The `previousTextField` property will be set on the other `UITextField` automatically for you.

Example:

```swift
import UITextField_Navigation

...
let textField1 = UITextField()
let textField2 = UITextField()
textField1.nextTextField = textField2

assert(textField2 == textField1.nextTextField)
assert(textField1 == textField2.previousTextField)
```

Please note that the `nextTextField` and `previousTextField` properties are not retained.

### Capturing taps

To capture taps on the next, previous and done buttons, assign a `delegate` for your `UITextField` also either on the Interface Builder or programmatically. Then implement the `UITextFieldNavigationDelegate` protocol for the `delegate`.
Please note that you have to explicitly declare that the `delegate` conforms to the protocol to make it work.

Swift:

```swift
import UIKit
import UITextField_Navigation

...
extension ViewController: UITextFieldNavigationDelegate { // explicitly protocol conforming declaration

    func textFieldNavigationDidTapPreviousButton(textField: UITextField) {
        textField.previousTextField?.becomeFirstResponder()
        // your custom work
    }

    func textFieldNavigationDidTapNextButton(textField: UITextField) {
        textField.nextTextField?.becomeFirstResponder()
        // your custom work
    }

    func textFieldNavigationDidTapDoneButton(textField: UITextField) {
        textField.resignFirstResponder()
        // your custom work
    }
}
```

Objective-C:

```objective-c
@import UITextField_Navigation;
#import "ViewController.h"

@interface ViewController () <UITextFieldNavigationDelegate> // explicitly protocol conforming declaration

...
#pragma mark - UITextFieldNavigationDelegate

- (void)textFieldNavigationDidTapPreviousButton:(UITextField *)textField {
    [textField.previousTextField becomeFirstResponder];
    // your custom work
}

- (void)textFieldNavigationDidTapNextButton:(UITextField *)textField {
    [textField.nextTextField becomeFirstResponder];
    // your custom work
}

- (void)textFieldNavigationDidTapDoneButton:(UITextField *)textField {
    [textField resignFirstResponder];
    // your custom work
}
```

### UI Customization

#### Using UIAppearance

Modify the appearance proxy of the `UITextFieldNavigationToolbar` and `UITextFieldNavigationToolbarButtonItem` classes to customize the navigation view's UI for all text fields.

```swift
UITextFieldNavigationToolbar.appearance().barStyle = .Black
UITextFieldNavigationToolbar.appearance().backgroundColor = UIColor.purpleColor()
UITextFieldNavigationToolbarButtonItem.appearance().tintColor = UIColor.whiteColor()
```

![Screenshot 3](https://github.com/T-Pham/UITextField-Navigation/blob/master/Screenshots/screenshot3.png?raw=true)

#### Directly and adding more buttons

Alternatively, you can modify the UI directly on each navigation view by accessing the `textFieldNavigationToolbar` property of a text field.

```swift
...
textField.textFieldNavigationToolbar?.barStyle = .Default
textField.textFieldNavigationToolbar?.backgroundColor = UIColor.redColor()
textField.textFieldNavigationToolbar?.previousButton.title = "Previous"
textField.textFieldNavigationToolbar?.nextButton.title = "Next"
textField.textFieldNavigationToolbar?.doneButton.title = "Dismiss"

// Add a custom button
let customButton = UIBarButtonItem(title: "Custom", style: .Plain, target: nil, action: nil)
let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
textField.textFieldNavigationToolbar?.items = [textField.textFieldNavigationToolbar!.previousButton, textField.textFieldNavigationToolbar!.nextButton, customButton, flexibleSpace, textField.textFieldNavigationToolbar!.doneButton]
```

![Screenshot 4](https://github.com/T-Pham/UITextField-Navigation/blob/master/Screenshots/screenshot4.png?raw=true)

## Installation

UITextField-Navigation is available through [CocoaPods](http://cocoapods.org/pods/UITextField-Navigation). To install
it, simply add the following line to your Podfile:

```ruby
pod "UITextField-Navigation"
```

## License

UITextField-Navigation is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
