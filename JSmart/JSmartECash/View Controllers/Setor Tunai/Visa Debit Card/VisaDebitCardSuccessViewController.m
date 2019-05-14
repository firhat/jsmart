//
//  VisaDebitCardSuccessViewController.m
//  JSmart
//
//  Created by whcl on 16/09/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import "VisaDebitCardSuccessViewController.h"

@interface VisaDebitCardSuccessViewController ()

@end

@implementation VisaDebitCardSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)back:(UIButton *)sender {
    [[[self.presentingViewController presentingViewController] presentingViewController] dismissViewControllerAnimated:true completion:nil];
}

@end
