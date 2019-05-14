//
//  TransferBankMandiriInputViewController.m
//  JSmart
//
//  Created by whcl on 17/09/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import "TransferBankMandiriInputViewController.h"

@interface TransferBankMandiriInputViewController ()

@end

@implementation TransferBankMandiriInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma Helpers

- (BOOL)validateForm {
    self.nomorRekening = [self.containerNumber text];
    return (![self.nomorRekening isEqualToString:@""]);
}

#

- (IBAction)back:(UIButton *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)changeSegment:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        [self.containerInput setHidden:false];
        [self.containerDaftar setHidden:true];
    } else if (sender.selectedSegmentIndex == 1) {
        [self.containerInput setHidden:true];
        [self.containerDaftar setHidden:false];
    }
}

- (IBAction)submit:(UIButton *)sender {
    if ([self validateForm]) {
        NSString* message = @"Mohon melengkapi data yang diperlukan.";
        [Helpers alertFailure:message viewController:self];
    }
}

@end
