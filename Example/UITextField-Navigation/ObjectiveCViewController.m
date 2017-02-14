//
//  ObjectiveCViewController.m
//  UITextField-Navigation
//
//  Created by Thanh Pham on 6/26/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

@import UITextField_Navigation;
#import "ObjectiveCViewController.h"

@interface ObjectiveCViewController () <UITextFieldDelegate, NavigationFieldDelegate>

@property (nonatomic) IBOutlet UITextField *textFieldIB1;
@property (nonatomic) IBOutlet UITextView *textView;
@property (nonatomic) IBOutlet UITextField *textFieldIB3;
@property (nonatomic) UITextField *textFieldCode1;
@property (nonatomic) UITextField *textFieldCode2;
@property (nonatomic) UITextField *textFieldCode3;

@end

@implementation ObjectiveCViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _textFieldCode1 = [self createRightTextFieldWithPlaceholder:@"UITextField Code 1" leftTextField:_textFieldIB1];
    _textFieldCode2 = [self createRightTextFieldWithPlaceholder:@"UITextField Code 2" leftTextField:_textView];
    _textFieldCode3 = [self createRightTextFieldWithPlaceholder:@"UITextField Code 3" leftTextField:_textFieldIB3];

    _textFieldIB3.nextNavigationField = _textFieldCode1;
    _textFieldCode1.nextNavigationField = _textFieldCode2;
    _textFieldCode2.nextNavigationField = _textFieldCode3;

    _textFieldCode2.delegate = self;
    _textFieldCode2.navigationFieldToolbar.barStyle = UIBarStyleDefault;
    _textFieldCode2.navigationFieldToolbar.backgroundColor = [UIColor redColor];
    _textFieldCode2.navigationFieldToolbar.previousButton.title = @"Previous";
    _textFieldCode2.navigationFieldToolbar.nextButton.title = @"Next";
    _textFieldCode2.navigationFieldToolbar.doneButton.title = @"Dismiss";

    UIBarButtonItem *customButton = [[UIBarButtonItem alloc] initWithTitle:@"Custom" style:UIBarButtonItemStylePlain target:nil action:nil];
    customButton.tintColor = [UIColor whiteColor];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    _textFieldCode2.navigationFieldToolbar.items = @[_textFieldCode2.navigationFieldToolbar.previousButton, _textFieldCode2.navigationFieldToolbar.nextButton, customButton, flexibleSpace, _textFieldCode2.navigationFieldToolbar.doneButton];
}

- (UITextField *)createRightTextFieldWithPlaceholder:(NSString *)placeholder leftTextField:(UIView *)leftField {
    UITextField *textField = [[UITextField alloc] init];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.font = [UIFont systemFontOfSize:14];
    textField.placeholder = placeholder;
    textField.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:textField];
    [self.view addConstraints:@[[NSLayoutConstraint constraintWithItem:textField attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:leftField attribute:NSLayoutAttributeWidth multiplier:1 constant:0], [NSLayoutConstraint constraintWithItem:textField attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:leftField attribute:NSLayoutAttributeCenterY multiplier:1 constant:0], [NSLayoutConstraint constraintWithItem:textField attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:leftField attribute:NSLayoutAttributeRight multiplier:1 constant:15]]];
    return textField;
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    NSLog(@"textFieldDidBeginEditing: %@", textField.placeholder);
}

#pragma mark - NavigationFieldDelegate

- (void)navigationFieldDidTapPreviousButton:(id<NavigationField>)navigationField {
    NSLog(@"navigationFieldDidTapPreviousButton: %@", navigationField);
    [navigationField.previousNavigationField becomeFirstResponder];
}

- (void)navigationFieldDidTapNextButton:(id<NavigationField>)navigationField {
    NSLog(@"navigationFieldDidTapNextButton: %@", navigationField);
    [navigationField.nextNavigationField becomeFirstResponder];
}

- (void)navigationFieldDidTapDoneButton:(id<NavigationField>)navigationField {
    NSLog(@"navigationFieldDidTapDoneButton: %@", navigationField);
    [navigationField resignFirstResponder];
}

@end
