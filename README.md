# UITextField-Navigation

[![GitHub issues](https://img.shields.io/github/issues/T-Pham/UITextField-Navigation.svg?maxAge=2592000&style=flat-square)](https://github.com/T-Pham/UITextField-Navigation/issues)
[![Code Health](https://landscape.io/github/T-Pham/UITextField-Navigation/master/landscape.svg?style=flat-square)](https://landscape.io/github/T-Pham/UITextField-Navigation/master)
[![Version](https://img.shields.io/cocoapods/v/UITextField-Navigation.svg?style=flat)](http://cocoapods.org/pods/UITextField-Navigation)
[![CocoaPods](https://img.shields.io/cocoapods/dt/UITextField-Navigation.svg?maxAge=2592000&style=flat-square)](http://cocoapods.org/pods/UITextField-Navigation)
[![Platform](https://img.shields.io/cocoapods/p/UITextField-Navigation.svg?style=flat)](http://cocoapods.org/pods/UITextField-Navigation)
[![License](https://img.shields.io/cocoapods/l/UITextField-Navigation.svg?style=flat)](http://cocoapods.org/pods/UITextField-Navigation)

## Description

UITextField-Navigation adds next, previous and done buttons to the keyboard for your `UITextField`s. It allows you to specify a next text field either on the Interface Builder or programmatically. Then, you can access next and previous text fields of each `UITextField` easily.

To run the example project, run `pod try UITextField-Navigation`.

![Alt text](/Screenshots/screenshot1.png?raw=true "Screenshot 1")
![Alt text](/Screenshots/screenshot2.gif?raw=true "Screenshot 2")

## Usage

Use can set the `nextTextField` property for each `UITextField` either on the Interface Builder or programmatically. The `previousTextField` property will be set on the other `UITextField` automatically for you.

Example:

```swift
import UITextField_Navigation

let textField1 = UITextField()
let textField2 = UITextField()
textField1.nextTextField = textField2

assert(textField2 == textField1.nextTextField)
assert(textField1 == textField2.previousTextField)
```

## Installation

UITextField-Navigation is available through [CocoaPods](http://cocoapods.org/pods/UITextField-Navigation). To install
it, simply add the following line to your Podfile:

```ruby
pod "UITextField-Navigation"
```

## License

UITextField-Navigation is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
