Pod::Spec.new do |s|
s.name             = 'UITextField-Navigation'
s.version          = '4.1'
s.summary          = 'UITextField-Navigation makes it easier to navigate between UITextFields and UITextViews.'
s.description      = <<-DESC
UITextField-Navigation adds next, previous and done buttons to the keyboard for your UITextFields and UITextViews. It allows you to specify a next text field/view either on the Interface Builder or programmatically. Then, you can access next and previous text fields/views of each UITextField/UITextView easily.
DESC
s.homepage         = 'https://github.com/T-Pham/UITextField-Navigation'
s.screenshots      = 'https://github.com/T-Pham/UITextField-Navigation/blob/master/Screenshots/screenshot1.png?raw=true', 'https://github.com/T-Pham/UITextField-Navigation/blob/master/Screenshots/screenshot2.gif?raw=true'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'Thanh Pham' => 'minhthanh@me.com' }
s.source           = { :git => 'https://github.com/T-Pham/UITextField-Navigation.git', :tag => s.version.to_s }
s.ios.deployment_target = '9.0'
s.source_files = 'UITextField-Navigation/Classes/**/*'
s.frameworks = 'UIKit'
end
