# UITextField-Navigation

[![CI Status](http://img.shields.io/travis/T-Pham/UITextField-Navigation.svg?style=flat-square)](https://travis-ci.org/T-Pham/UITextField-Navigation)
[![GitHub issues](https://img.shields.io/github/issues/T-Pham/UITextField-Navigation.svg?style=flat-square)](https://github.com/T-Pham/UITextField-Navigation/issues)
[![Version](https://img.shields.io/cocoapods/v/UITextField-Navigation.svg?style=flat-square)](http://cocoapods.org/pods/UITextField-Navigation)
[![CocoaPods](https://img.shields.io/cocoapods/dt/UITextField-Navigation.svg?style=flat-square)](http://cocoapods.org/pods/UITextField-Navigation)
[![Platform](https://img.shields.io/cocoapods/p/UITextField-Navigation.svg?style=flat-square)](http://cocoapods.org/pods/UITextField-Navigation)
[![License](https://img.shields.io/cocoapods/l/UITextField-Navigation.svg?style=flat-square)](LICENSE)

## Description

UITextField-Navigation adds next, previous and done buttons to the keyboard for your `UITextField`s. It allows you to specify a next text field either on the Interface Builder or programmatically. Then, you can access next and previous text fields of each `UITextField` easily.

To run the example project, run `pod try UITextField-Navigation`.

![Alt text](https://github.com/T-Pham/UITextField-Navigation/blob/master/Screenshots/screenshot1.png?raw=true "Screenshot 1")
![Alt text](https://github.com/T-Pham/UITextField-Navigation/blob/master/Screenshots/screenshot2.gif?raw=true "Screenshot 2")

## Usage

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
#import <UITextField_Navigation/UITextField_Navigation-Swift.h>
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

## Installation

UITextField-Navigation is available through [CocoaPods](http://cocoapods.org/pods/UITextField-Navigation). To install
it, simply add the following line to your Podfile:

```ruby
pod "UITextField-Navigation"
```

## License

UITextField-Navigation is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
