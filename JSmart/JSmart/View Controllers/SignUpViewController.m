//
//  SignUpViewController.m
//  JSmart
//
//  Created by whcl on 27/06/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addKeyboardButton];
    [self getAppVersion];
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

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self resignKeyboard];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)getAppVersion{
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    self.versionText.text = [NSString stringWithFormat: @"Version %@", version];
}

#pragma Keyboard

- (void)addKeyboardButton {
    CGRect keyboardToolbarFrame = CGRectMake(0, 0, self.view.bounds.size.width, 40);
    UIToolbar* keyboardToolbar = [[UIToolbar alloc] initWithFrame:keyboardToolbarFrame];
    UIBarButtonItem* buttonDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(resignKeyboard)];
    [keyboardToolbar setItems:[[NSArray alloc] initWithObjects:buttonDone, nil]];
    
    self.containerName.inputAccessoryView = keyboardToolbar;
    self.containerEmail.inputAccessoryView = keyboardToolbar;
    self.containerPassword.inputAccessoryView = keyboardToolbar;
    self.containerConfirmationPassword.inputAccessoryView = keyboardToolbar;
    self.containerPhone.inputAccessoryView = keyboardToolbar;
}

- (void)resignKeyboard {
    [self.containerName resignFirstResponder];
    [self.containerEmail resignFirstResponder];
    [self.containerPassword resignFirstResponder];
    [self.containerConfirmationPassword resignFirstResponder];
    [self.containerPhone resignFirstResponder];
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

#pragma Validation

- (BOOL)validateSignUpFormCompleteness {
    if ([[self.containerName text] isEqualToString:@""]) {
        return false;
    }
    if ([[self.containerEmail text] isEqualToString:@""]) {
        return false;
    }
    if ([[self.containerPassword text] isEqualToString:@""]) {
        return false;
    }
    if ([[self.containerConfirmationPassword text] isEqualToString:@""]) {
        return false;
    }
    if ([[self.containerPhone text] isEqualToString:@""]) {
        return false;
    }
    return true;
}

- (BOOL)validateSignUpFormPasswordMatch {
    if (![[self.containerPassword text] isEqualToString:[self.containerConfirmationPassword text]]) {
        return false;
    }
    return true;
}

#pragma IBAction

- (IBAction)signUp:(UIButton *)sender {
    [self resignKeyboard];
    UIActivityIndicatorView* activityIndicator = [Helpers getActivityIndicator:self];
    void (^returnToSignIn)(UIAlertAction*) = ^void(UIAlertAction* alert) {
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    void (^success)(NSURLSessionTask *task, id responseObject) = ^void(NSURLSessionTask *task, id responseObject) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        if (![[responseObject objectForKey:@"status"] boolValue]) {
            [Helpers alertFailure:[responseObject objectForKey:@"message"] viewController:self];
            return;
        }
        [Helpers alertSuccessWithCompletion:[responseObject objectForKey:@"message"] viewController:self completion:returnToSignIn];
    };
    void (^failure)(NSURLSessionTask *operation, NSError *error) = ^void(NSURLSessionTask *operation, NSError *error) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        [Helpers alertFailure:[error localizedDescription] viewController:self];
    };
    if (![self validateSignUpFormCompleteness]) {
        if ([Helpers isAppInEnglish]) {
            [Helpers alertFailure:[Strings EN_ALERT_INCOMPLETE_FIELDS] viewController:self];
        } else {
            [Helpers alertFailure:[Strings ID_ALERT_INCOMPLETE_FIELDS] viewController:self];
        }
        return;
    }
    if (![self validateSignUpFormPasswordMatch]) {
        if ([Helpers isAppInEnglish]) {
            [Helpers alertFailure:[Strings EN_ALERT_PASSWORD_DOES_NOT_MATCH] viewController:self];
        } else {
            [Helpers alertFailure:[Strings ID_ALERT_PASSWORD_DOES_NOT_MATCH] viewController:self];
        }
        return;
    }
    NSString* name = [self.containerName text];
    NSString* email = [self.containerEmail text];
    NSString* password = [self.containerPassword text];
    NSString* confirmationPassword = [self.containerConfirmationPassword text];
//    NSString* phone = [self.containerPhone text];
    [activityIndicator startAnimating];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [Connection signUp:name email:email password:password confirmationPassword:confirmationPassword success:success failure:failure];
}

- (IBAction)signIn:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
