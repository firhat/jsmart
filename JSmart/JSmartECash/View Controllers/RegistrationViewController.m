//
//  RegistrationViewController.m
//  JSmartECash
//
//  Created by whcl on 04/09/18.
//  Copyright © 2018 JSmart. All rights reserved.
//

#import "RegistrationViewController.h"

@interface RegistrationViewController ()

@end

@implementation RegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addKeyboardButton];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardAppear:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDisappear:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

#pragma Keyboard

- (void)addKeyboardButton {
    CGRect keyboardToolbarFrame = CGRectMake(0, 0, self.view.bounds.size.width, 40);
    UIToolbar* keyboardToolbar = [[UIToolbar alloc] initWithFrame:keyboardToolbarFrame];
    UIBarButtonItem* buttonDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(resignKeyboard)];
    [keyboardToolbar setItems:[[NSArray alloc] initWithObjects:buttonDone, nil]];
    
    self.containerName.inputAccessoryView = keyboardToolbar;
    self.containerDate.inputAccessoryView = keyboardToolbar;
    self.containerMonth.inputAccessoryView = keyboardToolbar;
    self.containerYear.inputAccessoryView = keyboardToolbar;
    self.containerEmail.inputAccessoryView = keyboardToolbar;
    self.containerPin.inputAccessoryView = keyboardToolbar;
    self.containerQuestion.inputAccessoryView = keyboardToolbar;
    self.containerAnswer.inputAccessoryView = keyboardToolbar;
    self.containerOtp.inputAccessoryView = keyboardToolbar;
}

- (void)resignKeyboard {
    [self.containerName resignFirstResponder];
    [self.containerDate resignFirstResponder];
    [self.containerMonth resignFirstResponder];
    [self.containerYear resignFirstResponder];
    [self.containerEmail resignFirstResponder];
    [self.containerPin resignFirstResponder];
    [self.containerQuestion resignFirstResponder];
    [self.containerAnswer resignFirstResponder];
    [self.containerOtp resignFirstResponder];
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

#pragma TextField Delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == self.containerQuestion) {
        return false;
    }
    return true;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == self.containerDate) {
        if ([self.containerDate.text integerValue] > 31) {
            [self.containerDate setText:@"31"];
        }
    } else if (textField == self.containerMonth) {
        if ([self.containerMonth.text integerValue] > 12) {
            [self.containerMonth setText:@"12"];
        }
        
    } else if (textField == self.containerYear) {
        if ([self.containerYear.text integerValue] > 2018) {
            [self.containerYear setText:@"2018"];
        } else if ([self.containerYear.text integerValue] < 1900) {
            [self.containerYear setText:@"1900"];
        }
    }
}

#

#pragma IBActions

- (IBAction)optionAgreementChanged:(UISwitch *)sender {
    if (sender == self.optionAgreementAll) {
        if ([self.optionAgreementAll isOn]) {
            [self.optionAgreement1 setOn:true animated:true];
            [self.optionAgreement2 setOn:true animated:true];
            [self.optionAgreement3 setOn:true animated:true];
            [self.optionAgreement4 setOn:true animated:true];
        } else {
            [self.optionAgreement1 setOn:false animated:true];
            [self.optionAgreement2 setOn:false animated:true];
            [self.optionAgreement3 setOn:false animated:true];
            [self.optionAgreement4 setOn:false animated:true];
            
        }
    } else {
        if ([self.optionAgreement1 isOn] && [self.optionAgreement2 isOn] && [self.optionAgreement3 isOn] && [self.optionAgreement4 isOn]) {
            [self.optionAgreementAll setOn:true animated:true];
        } else {
            [self.optionAgreementAll setOn:false animated:true];
        }
    }
}

- (IBAction)requestOtp:(UIButton *)sender {
    
}

- (IBAction)submit:(UIButton *)sender {
    [self performSegueWithIdentifier:@"MainMenuTabBarController" sender:self];
}

#
@end
