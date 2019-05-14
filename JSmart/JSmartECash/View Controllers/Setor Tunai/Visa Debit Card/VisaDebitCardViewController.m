//
//  VisaDebitCardViewController.m
//  JSmart
//
//  Created by whcl on 11/09/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import "VisaDebitCardViewController.h"

@interface VisaDebitCardViewController ()

@end

@implementation VisaDebitCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //// Data Sources
    self.denominations = [[NSMutableArray alloc] init];
    self.months = [[NSMutableArray alloc] initWithObjects:
                   @"Januari", @"Februari", @"Maret", @"April", @"Mei", @"Juni",
                   @"Juli", @"Agustus", @"September", @"Oktober", @"November", @"Desember", nil];
    self.years = [[NSMutableArray alloc] initWithObjects:
                  @"2018", @"2019", @"2020", @"2021", @"2022",
                  @"2023", @"2024", @"2026", @"2027", @"2028", @"2029", @"2030", nil];
    
    //// Picker View
    self.PICKER_VIEW_DENOMINATIONS = @"PICKER_VIEW_DENOMINATIONS";
    self.PICKER_VIEW_EXPIRING_DATE = @"PICKER_VIEW_EXPIRING_DATE";
    
    [self addKeyboardButton];
    [self getDenomination];
}

#pragma PickerView Delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (self.PICKER_VIEW_TYPE == self.PICKER_VIEW_DENOMINATIONS) {
        return 1;
    } else if (self.PICKER_VIEW_TYPE == self.PICKER_VIEW_EXPIRING_DATE) {
        return 2;
    }
    return 0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (self.PICKER_VIEW_TYPE == self.PICKER_VIEW_DENOMINATIONS) {
        return [self.denominations count];
    } else if (self.PICKER_VIEW_TYPE == self.PICKER_VIEW_EXPIRING_DATE) {
        if (component == 0) {
            return [self.months count];
        } else if (component == 1) {
            return [self.years count];
        }
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (self.PICKER_VIEW_TYPE == self.PICKER_VIEW_DENOMINATIONS) {
        return [self.denominations objectAtIndex:row];
    } else if (self.PICKER_VIEW_TYPE == self.PICKER_VIEW_EXPIRING_DATE) {
        if (component == 0) {
            return [self.months objectAtIndex:row];
        } else if (component == 1) {
            return [self.years objectAtIndex:row];
        }
    }
    return @"";
}

#

#pragma UITextField Delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == self.containerAmount) {
        self.PICKER_VIEW_TYPE = self.PICKER_VIEW_DENOMINATIONS;
        [self.pickerView reloadAllComponents];
        [self.containerPickerView setHidden:false];
        [self resignKeyboard];
        return false;
    } else if (textField == self.containerExpiryDate) {
        self.PICKER_VIEW_TYPE = self.PICKER_VIEW_EXPIRING_DATE;
        [self.pickerView reloadAllComponents];
        [self.containerPickerView setHidden:false];
        [self resignKeyboard];
        return false;
    }
    [self.containerPickerView setHidden:true];
    return true;
}

#

#pragma Keyboard

- (void)addKeyboardButton {
    CGRect keyboardToolbarFrame = CGRectMake(0, 0, self.view.bounds.size.width, 40);
    UIToolbar* keyboardToolbar = [[UIToolbar alloc] initWithFrame:keyboardToolbarFrame];
    UIBarButtonItem* buttonDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(resignKeyboard)];
    [keyboardToolbar setItems:[[NSArray alloc] initWithObjects:buttonDone, nil]];
    
    self.containerAmount.inputAccessoryView = keyboardToolbar;
    self.containerCardNumber.inputAccessoryView = keyboardToolbar;
    self.containerExpiryDate.inputAccessoryView = keyboardToolbar;
    self.containerCvc.inputAccessoryView = keyboardToolbar;
    self.containerName.inputAccessoryView = keyboardToolbar;
    self.containerEmail.inputAccessoryView = keyboardToolbar;
}

- (void)resignKeyboard {
    [self.containerAmount resignFirstResponder];
    [self.containerCardNumber resignFirstResponder];
    [self.containerExpiryDate resignFirstResponder];
    [self.containerCvc resignFirstResponder];
    [self.containerName resignFirstResponder];
    [self.containerEmail resignFirstResponder];
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

#pragma Helpers

- (BOOL)validateForm {
    NSString* amount = [self.containerAmount text];
    NSString* cardNumber = [self.containerCardNumber text];
    NSString* expiryDate = [self.containerExpiryDate text];
    NSString* cvc = [self.containerCvc text];
    NSString* name = [self.containerName text];
    NSString* email = [self.containerEmail text];
    
    if ([amount isEqualToString:@""] || [cardNumber isEqualToString:@""] || [expiryDate isEqualToString:@""] ||
        [cvc isEqualToString:@""] || [name isEqualToString:@""] || [email isEqualToString:@""]) {
        return false;
    }
    
    return true;
}

#

#pragma Network

- (void)getDenomination {
    UIActivityIndicatorView* activityIndicator = [Helpers getActivityIndicator:self];
    void (^success)(NSURLSessionTask *task, id responseObject) = ^void(NSURLSessionTask *task, id responseObject) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        if (![[responseObject objectForKey:@"status"] boolValue]) {
            [Helpers alertFailure:[responseObject objectForKey:@"message"] viewController:self];
            return;
        }
        self.denominations = [[NSMutableArray alloc] initWithArray:[[responseObject objectForKey:@"data"] objectForKey:@"denom"]];
        [self.pickerView reloadAllComponents];
    };
    void (^failure)(NSURLSessionTask *operation, NSError *error) = ^void(NSURLSessionTask *operation, NSError *error) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        [Helpers alertFailure:[error localizedDescription] viewController:self];
    };
    NSString* msisdn = @"081222441086";
    NSString* token = @"111977DC72BAFB172EA58DBD587A34DF";
    NSString* ver = @"1";
    NSString* email_jsmart = @"rhmtsaepuloh@gmail.com";
    NSString* token_jsmart = @"56a79beeba6d56678a5eece4f60672e3";
    [activityIndicator startAnimating];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [ECashConnection getDenomination:msisdn token:token ver:ver email_jsmart:email_jsmart token_jsmart:token_jsmart success:success failure:failure];
}

- (void)inquireTopup {
    UIActivityIndicatorView* activityIndicator = [Helpers getActivityIndicator:self];
    void (^success)(NSURLSessionTask *task, id responseObject) = ^void(NSURLSessionTask *task, id responseObject) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        if (![[responseObject objectForKey:@"status"] boolValue]) {
            [Helpers alertFailure:[responseObject objectForKey:@"message"] viewController:self];
            return;
        }
    };
    void (^failure)(NSURLSessionTask *operation, NSError *error) = ^void(NSURLSessionTask *operation, NSError *error) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        [Helpers alertFailure:[error localizedDescription] viewController:self];
    };
    NSString* msisdn = @"081222441086";
    NSString* token = @"111977DC72BAFB172EA58DBD587A34DF";
    NSString* bin = @"1";
    NSString* amount = @"100000";
    NSString* email_jsmart = @"rhmtsaepuloh@gmail.com";
    NSString* token_jsmart = @"56a79beeba6d56678a5eece4f60672e3";
    [activityIndicator startAnimating];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [ECashConnection inquireTopup:msisdn token:token bin:bin amount:amount email_jsmart:email_jsmart token_jsmart:token_jsmart success:success failure:failure];
}

#

- (IBAction)back:(UIButton *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)submit:(UIButton *)sender {
    if (![self validateForm]) {
        NSString* message = @"Mohon untuk melengkapi setiap informasi yang dibutuhkan dengan benar.";
        [Helpers alertFailure:message viewController:self];
    }
    [self performSegueWithIdentifier:@"VisaDebitCardPIN" sender:self];
}

- (IBAction)donePickerView:(UIButton *)sender {
    [self.containerPickerView setHidden:true];
    
    if (self.PICKER_VIEW_TYPE == self.PICKER_VIEW_DENOMINATIONS) {
        NSInteger index = [self.pickerView selectedRowInComponent:0];
        [self.containerAmount setText:[self.denominations objectAtIndex:index]];
    } else if (self.PICKER_VIEW_TYPE == self.PICKER_VIEW_EXPIRING_DATE) {
        NSInteger monthIndex = [self.pickerView selectedRowInComponent:0];
        NSInteger yearIndex= [self.pickerView selectedRowInComponent:1];
        NSString* monthYear = [NSString stringWithFormat:@"%@ %@", [self.months objectAtIndex:monthIndex], [self.years objectAtIndex:yearIndex]];
        [self.containerExpiryDate setText:monthYear];
    }
}

@end
