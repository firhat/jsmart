//
//  BeliPulsaPinViewController.m
//  JSmart
//
//  Created by whcl on 30/09/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import "BeliPulsaPinViewController.h"

@interface BeliPulsaPinViewController ()

@end

@implementation BeliPulsaPinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardAppear:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDisappear:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    [self.containerPinDigit1 addTarget:self
                                action:@selector(textFieldDidChange:)
                      forControlEvents:UIControlEventEditingChanged];
    [self.containerPinDigit2 addTarget:self
                                action:@selector(textFieldDidChange:)
                      forControlEvents:UIControlEventEditingChanged];
    [self.containerPinDigit3 addTarget:self
                                action:@selector(textFieldDidChange:)
                      forControlEvents:UIControlEventEditingChanged];
    [self.containerPinDigit4 addTarget:self
                                action:@selector(textFieldDidChange:)
                      forControlEvents:UIControlEventEditingChanged];
    [self.containerPinDigit5 addTarget:self
                                action:@selector(textFieldDidChange:)
                      forControlEvents:UIControlEventEditingChanged];
    [self.containerPinDigit6 addTarget:self
                                action:@selector(textFieldDidChange:)
                      forControlEvents:UIControlEventEditingChanged];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma Keyboard

- (void)addKeyboardButton {
    CGRect keyboardToolbarFrame = CGRectMake(0, 0, self.view.bounds.size.width, 40);
    UIToolbar* keyboardToolbar = [[UIToolbar alloc] initWithFrame:keyboardToolbarFrame];
    UIBarButtonItem* buttonDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(resignKeyboard)];
    [keyboardToolbar setItems:[[NSArray alloc] initWithObjects:buttonDone, nil]];
    
    self.containerPinDigit1.inputAccessoryView = keyboardToolbar;
    self.containerPinDigit2.inputAccessoryView = keyboardToolbar;
    self.containerPinDigit3.inputAccessoryView = keyboardToolbar;
    self.containerPinDigit4.inputAccessoryView = keyboardToolbar;
    self.containerPinDigit5.inputAccessoryView = keyboardToolbar;
    self.containerPinDigit6.inputAccessoryView = keyboardToolbar;
}

- (void)resignKeyboard {
    [self.containerPinDigit1 resignFirstResponder];
    [self.containerPinDigit2 resignFirstResponder];
    [self.containerPinDigit3 resignFirstResponder];
    [self.containerPinDigit4 resignFirstResponder];
    [self.containerPinDigit5 resignFirstResponder];
    [self.containerPinDigit6 resignFirstResponder];
}

- (void)keyboardAppear:(NSNotification*)notification {
    NSDictionary* info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

- (void)keyboardDisappear:(NSNotification*)notification {
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

#

#pragma UITextField Delegate

- (void)textFieldDidChange:(UITextField*)textField {
    NSInteger length = [[textField text] length];
    if (textField == self.containerPinDigit1) {
        if (length == 1) {
            [textField resignFirstResponder];
            [self.containerPinDigit2 becomeFirstResponder];
        }
    } else if (textField == self.containerPinDigit2) {
        if (length == 1) {
            [textField resignFirstResponder];
            [self.containerPinDigit3 becomeFirstResponder];
        } else if (length == 0) {
            [textField resignFirstResponder];
            [self.containerPinDigit1 becomeFirstResponder];
        }
    } else if (textField == self.containerPinDigit3) {
        if (length == 1) {
            [textField resignFirstResponder];
            [self.containerPinDigit4 becomeFirstResponder];
        } else if (length == 0) {
            [textField resignFirstResponder];
            [self.containerPinDigit2 becomeFirstResponder];
        }
    } else if (textField == self.containerPinDigit4) {
        if (length == 1) {
            [textField resignFirstResponder];
            [self.containerPinDigit5 becomeFirstResponder];
        } else if (length == 0) {
            [textField resignFirstResponder];
            [self.containerPinDigit3 becomeFirstResponder];
        }
    } else if (textField == self.containerPinDigit5) {
        if (length == 1) {
            [textField resignFirstResponder];
            [self.containerPinDigit6 becomeFirstResponder];
        } else if (length == 0) {
            [textField resignFirstResponder];
            [self.containerPinDigit4 becomeFirstResponder];
        }
    } else if (textField == self.containerPinDigit6) {
        if (length == 0) {
            [textField resignFirstResponder];
            [self.containerPinDigit5 becomeFirstResponder];
        } else if (length == 1) {
            [textField resignFirstResponder];
        }
    }
}

#

#pragma Helpers

-(BOOL)validateForm {
    NSString* pinDigit1 = [self.containerPinDigit1 text];
    NSString* pinDigit2 = [self.containerPinDigit2 text];
    NSString* pinDigit3 = [self.containerPinDigit3 text];
    NSString* pinDigit4 = [self.containerPinDigit4 text];
    NSString* pinDigit5 = [self.containerPinDigit5 text];
    NSString* pinDigit6 = [self.containerPinDigit6 text];
    
    if ([pinDigit1 isEqualToString:@""] ||
        [pinDigit2 isEqualToString:@""] ||
        [pinDigit3 isEqualToString:@""] ||
        [pinDigit4 isEqualToString:@""] ||
        [pinDigit5 isEqualToString:@""] ||
        [pinDigit6 isEqualToString:@""]) {
        return false;
    }
    self.pin = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                pinDigit1,
                pinDigit2,
                pinDigit3,
                pinDigit4,
                pinDigit5,
                pinDigit6];
    return true;
}

#


- (IBAction)back:(UIButton *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)submit:(UIButton *)sender {
    
}

@end
