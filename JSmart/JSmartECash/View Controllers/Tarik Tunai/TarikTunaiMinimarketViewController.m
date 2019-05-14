//
//  TarikTunaiMinimarketViewController.m
//  JSmart
//
//  Created by whcl on 30/09/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import "TarikTunaiMinimarketViewController.h"

@interface TarikTunaiMinimarketViewController ()

@end

@implementation TarikTunaiMinimarketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.jumlah = 0;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardAppear:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDisappear:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    [self.containerJumlah addTarget:self
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
    
    self.containerJumlah.inputAccessoryView = keyboardToolbar;
}

- (void)resignKeyboard {
    [self.containerJumlah resignFirstResponder];
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
    NSString* jumlahString = [self.containerJumlah text];
    if ([jumlahString isEqualToString:@""]) {
        self.jumlah = 0;
    } else {
        self.jumlah = [jumlahString floatValue];
    }
}

#

#pragma Helpers

- (void)displayJumlah {
    [self.containerJumlah setText:[NSString stringWithFormat:@"%0.f", self.jumlah]];
}

#

- (IBAction)add50:(UIButton *)sender {
    self.jumlah = self.jumlah + 50000;
    [self displayJumlah];
}

- (IBAction)add100:(UIButton *)sender {
    self.jumlah = self.jumlah + 100000;
    [self displayJumlah];
}

- (IBAction)add300:(UIButton *)sender {
    self.jumlah = self.jumlah + 300000;
    [self displayJumlah];
}

- (IBAction)back:(UIButton *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)submit:(UIButton *)sender {
    [self performSegueWithIdentifier:@"TarikTunaiMinimarketPin" sender:self];
}

@end
