//
//  PhoneRegistrationViewController.m
//  JSmartECash
//
//  Created by whcl on 04/09/18.
//  Copyright © 2018 JSmart. All rights reserved.
//

#import "PhoneRegistrationViewController.h"

@interface PhoneRegistrationViewController ()

@end

@implementation PhoneRegistrationViewController

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma Keyboard

- (void)addKeyboardButton {
    CGRect keyboardToolbarFrame = CGRectMake(0, 0, self.view.bounds.size.width, 40);
    UIToolbar* keyboardToolbar = [[UIToolbar alloc] initWithFrame:keyboardToolbarFrame];
    UIBarButtonItem* buttonDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(resignKeyboard)];
    [keyboardToolbar setItems:[[NSArray alloc] initWithObjects:buttonDone, nil]];
    
    self.containerPhone.inputAccessoryView = keyboardToolbar;
}

- (void)resignKeyboard {
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

- (BOOL)validateForm {
    self.phone = self.containerPhone.text;
    return ![self.phone isEqualToString:@""];
}

- (IBAction)submit:(UIButton *)sender {
    if (![self validateForm]) {
        return;
    }
    [self getRegisterTicket];
}

#pragma Connection

- (void)getRegisterTicket {
    UIActivityIndicatorView* activityIndicator = [Helpers getActivityIndicator:self];
    void (^success)(NSURLSessionTask *task, id responseObject) = ^void(NSURLSessionTask *task, id responseObject) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        if (![[responseObject objectForKey:@"status"] boolValue]) {
            [Helpers alertFailure:[responseObject objectForKey:@"message"] viewController:self];
            return;
        }
        self.ticket = [[responseObject objectForKey:@"data"] objectForKey:@"ticket"];
        [self performSegueWithIdentifier:@"RegistrationViewController" sender:self];
    };
    void (^failure)(NSURLSessionTask *operation, NSError *error) = ^void(NSURLSessionTask *operation, NSError *error) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        [Helpers alertFailure:[error localizedDescription] viewController:self];
    };
    NSString* mobileno = [self.containerPhone text];
    NSString* token = @"111977DC72BAFB172EA58DBD587A34DF";
    NSString* email_jsmart = @"rhmtsaepuloh@gmail.com";
    NSString* token_jsmart = @"bc6ff909eed72dcd12a8e003c3c529b9";
    [activityIndicator startAnimating];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [ECashConnection getRegisterTicket:mobileno token:token email_jsmart:email_jsmart token_jsmart:token_jsmart success:success failure:failure];
}

#

@end
