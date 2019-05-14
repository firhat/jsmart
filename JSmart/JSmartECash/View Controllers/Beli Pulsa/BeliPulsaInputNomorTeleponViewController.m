//
//  BeliPulsaInputNomorTeleponViewController.m
//  JSmart
//
//  Created by whcl on 30/09/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import "BeliPulsaInputNomorTeleponViewController.h"

@interface BeliPulsaInputNomorTeleponViewController ()

@end

@implementation BeliPulsaInputNomorTeleponViewController

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
    
    self.containerNomorTelepon.inputAccessoryView = keyboardToolbar;
    self.containerNamaKontak.inputAccessoryView = keyboardToolbar;
}

- (void)resignKeyboard {
    [self.containerNomorTelepon resignFirstResponder];
    [self.containerNamaKontak resignFirstResponder];
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

#pragma Connection

- (void)setFavorite {
    UIActivityIndicatorView* activityIndicator = [Helpers getActivityIndicator:self];
    void (^success)(NSURLSessionTask *task, id responseObject) = ^void(NSURLSessionTask *task, id responseObject) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        if (![[responseObject objectForKey:@"status"] boolValue]) {
            [Helpers alertFailure:[responseObject objectForKey:@"message"] viewController:self];
            return;
        }
        NSString* message = @"Nomor berhasil disimpan sebagai favorit.";
        void (^dismiss)(UIAlertAction* completion) = ^void(UIAlertAction* completion) {
            [self dismissViewControllerAnimated:true completion:nil];
        };
        [Helpers alertSuccessWithCompletion:message viewController:self completion:dismiss];
    };
    void (^failure)(NSURLSessionTask *operation, NSError *error) = ^void(NSURLSessionTask *operation, NSError *error) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        [Helpers alertFailure:[error localizedDescription] viewController:self];
    };
    NSString* nomor_favorite = [self.containerNomorTelepon text];
    NSString* nama_kontak = [self.containerNamaKontak text];
    NSString* type = @"pulsa";
    NSString* email_jsmart = @"rhmtsaepuloh@gmail.com";
    NSString* token_jsmart = @"5ebbcd022eb510f595f7402e269d3a46";
    [activityIndicator startAnimating];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [ECashConnection setFavorite:nomor_favorite nama_kontak:nama_kontak type:type email_jsmart:email_jsmart token_jsmart:token_jsmart success:success failure:failure];
}

#

- (BOOL)validateForm {
    if ([[self.containerNomorTelepon text] isEqualToString:@""]) {
        NSString* message = @"Mohon untuk melengkapi data yang diperlukan.";
        [Helpers alertFailure:message viewController:self];
        return false;
    }
    
    if ([self.optionSimpanNomorTelepon isOn] && [[self.containerNamaKontak text] isEqualToString:@""]) {
        NSString* message = @"Mohon untuk melengkapi data yang diperlukan.";
        [Helpers alertFailure:message viewController:self];
        return false;
    }
    
    return true;
}

- (IBAction)back:(UIButton *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)openContact:(UIButton *)sender {
    NSLog(@"Open Contact");
}

- (IBAction)submit:(UIButton *)sender {
    if (![self validateForm]) {
        return;
    }

    NSString* nomorTelepon = [self.containerNomorTelepon text];
    [self.delegate selectNomorTeleponFromInput:nomorTelepon];
    
    if ([self.optionSimpanNomorTelepon isOn]) {
        [self setFavorite];
    } else {
        [self dismissViewControllerAnimated:true completion:nil];
    }
}

- (IBAction)segmentedControlChangeValue:(UISegmentedControl *)sender {
    if ([sender selectedSegmentIndex] == 0) {
        [self.containerInputNomorTelepon setHidden:false];
        [self.containerDaftarNomorTelepon setHidden:true];
    } else if ([sender selectedSegmentIndex] == 1) {
        [self.containerInputNomorTelepon setHidden:true];
        [self.containerDaftarNomorTelepon setHidden:false];
    }
}

- (IBAction)optionSimpanNomorTeleponChangeValue:(UISwitch *)sender {
    if ([sender isOn]) {
        [self.containerNamaKontak setHidden:false];
    } else {
        [self.containerNamaKontak setHidden:true];
    }
}

#pragma Nagivation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSString* identifier = [segue identifier];
    if ([identifier isEqualToString:@"BeliPulsaDaftarNomorTeleponViewController"]) {
        BeliPulsaDaftarNomorTeleponViewController* vc = [segue destinationViewController];
        vc.delegate = (id<BeliPulsaDaftarNomorTeleponViewControllerDelegate>)self.delegate;
    }
}

#

@end
