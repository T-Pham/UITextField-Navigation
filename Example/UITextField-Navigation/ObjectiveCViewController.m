//
//  ObjectiveCViewController.m
//  UITextField-Navigation
//
//  Created by Thanh Pham on 6/26/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

#import <UITextField_Navigation/UITextField_Navigation-Swift.h>
#import "ObjectiveCViewController.h"

@interface ObjectiveCViewController () {
    UITextField *textField1;
    UITextField *textField2;
    UITextField *textField3;
}

@end

@implementation ObjectiveCViewController

- (void)loadView {
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    textField1 = [[UITextField alloc] init];
    textField1.borderStyle = UITextBorderStyleRoundedRect;
    textField1.placeholder = @"UITextField 1";
    [self.view addSubview:textField1];
    textField1.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:@[[NSLayoutConstraint constraintWithItem:textField1 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topLayoutGuide attribute:NSLayoutAttributeBottom multiplier:1 constant:15], [NSLayoutConstraint constraintWithItem:textField1 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:15], [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:textField1 attribute:NSLayoutAttributeRight multiplier:1 constant:15]]];

    textField2 = [[UITextField alloc] init];
    textField2.borderStyle = UITextBorderStyleRoundedRect;
    textField2.placeholder = @"UITextField 2";
    [self.view addSubview:textField2];
    textField2.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:@[[NSLayoutConstraint constraintWithItem:textField2 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:textField1 attribute:NSLayoutAttributeBottom multiplier:1 constant:15], [NSLayoutConstraint constraintWithItem:textField2 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:textField1 attribute:NSLayoutAttributeLeft multiplier:1 constant:0], [NSLayoutConstraint constraintWithItem:textField2 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:textField1 attribute:NSLayoutAttributeRight multiplier:1 constant:0]]];

    textField3 = [[UITextField alloc] init];
    textField3.borderStyle = UITextBorderStyleRoundedRect;
    textField3.placeholder = @"UITextField 3";
    [self.view addSubview:textField3];
    textField3.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:@[[NSLayoutConstraint constraintWithItem:textField3 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:textField2 attribute:NSLayoutAttributeBottom multiplier:1 constant:15], [NSLayoutConstraint constraintWithItem:textField3 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:textField2 attribute:NSLayoutAttributeLeft multiplier:1 constant:0], [NSLayoutConstraint constraintWithItem:textField3 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:textField2 attribute:NSLayoutAttributeRight multiplier:1 constant:0]]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Objective-C";
    textField1.nextTextField = textField2;
    textField2.nextTextField = textField3;
}

@end
