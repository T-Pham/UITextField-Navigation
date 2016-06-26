//
//  ObjectiveCViewController.m
//  UITextField-Navigation
//
//  Created by Thanh Pham on 6/26/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

#import <UITextField_Navigation/UITextField_Navigation-Swift.h>
#import "ObjectiveCViewController.h"

@interface ObjectiveCViewController () <UITextFieldNavigationDelegate>

@property (nonatomic) IBOutlet UITextField *textFieldIB1;
@property (nonatomic) IBOutlet UITextField *textFieldIB2;
@property (nonatomic) IBOutlet UITextField *textFieldIB3;
@property (nonatomic) UITextField *textFieldCode1;
@property (nonatomic) UITextField *textFieldCode2;
@property (nonatomic) UITextField *textFieldCode3;

@end

@implementation ObjectiveCViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _textFieldCode1 = [self createRightTextFieldWithPlaceholder:@"UITextField Code 1" leftTextField:_textFieldIB1];
    _textFieldCode2 = [self createRightTextFieldWithPlaceholder:@"UITextField Code 2" leftTextField:_textFieldIB2];
    _textFieldCode3 = [self createRightTextFieldWithPlaceholder:@"UITextField Code 3" leftTextField:_textFieldIB3];

    _textFieldIB3.nextTextField = _textFieldCode1;
    _textFieldCode1.nextTextField = _textFieldCode2;
    _textFieldCode2.nextTextField = _textFieldCode3;

    _textFieldCode2.delegate = self;
}

- (UITextField *)createRightTextFieldWithPlaceholder:(NSString *)placeholder leftTextField:(UITextField *)letTextField {
    UITextField *textField = [[UITextField alloc] init];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.font = letTextField.font;
    textField.placeholder = placeholder;
    textField.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:textField];
    [self.view addConstraints:@[[NSLayoutConstraint constraintWithItem:textField attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:letTextField attribute:NSLayoutAttributeWidth multiplier:1 constant:0], [NSLayoutConstraint constraintWithItem:textField attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:letTextField attribute:NSLayoutAttributeCenterY multiplier:1 constant:0], [NSLayoutConstraint constraintWithItem:textField attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:letTextField attribute:NSLayoutAttributeRight multiplier:1 constant:15]]];
    return textField;
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    NSLog(@"textFieldDidBeginEditing: %@", textField.placeholder);
}

#pragma mark - UITextFieldNavigationDelegate

- (void)textFieldNavigationDidTapPreviousButton:(UITextField *)textField {
    NSLog(@"textFieldNavigationDidTapPreviousButton: %@", textField.placeholder);
    [textField.previousTextField becomeFirstResponder];
}

- (void)textFieldNavigationDidTapNextButton:(UITextField *)textField {
    NSLog(@"textFieldNavigationDidTapNextButton: %@", textField.placeholder);
    [textField.nextTextField becomeFirstResponder];
}

- (void)textFieldNavigationDidTapDoneButton:(UITextField *)textField {
    NSLog(@"textFieldNavigationDidTapDoneButton: %@", textField.placeholder);
    [textField resignFirstResponder];
}

@end
