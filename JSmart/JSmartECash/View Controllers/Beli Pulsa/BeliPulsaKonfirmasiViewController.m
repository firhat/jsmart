//
//  BeliPulsaKonfirmasiViewController.m
//  JSmart
//
//  Created by whcl on 30/09/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import "BeliPulsaKonfirmasiViewController.h"

@interface BeliPulsaKonfirmasiViewController ()

@end

@implementation BeliPulsaKonfirmasiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self displayInformation];
}

#pragma Connection



#

#pragma Helpers

- (void)displayInformation {
    [self.containerOperator setText:self.nameOperator];
    [self.containerNomor setText:self.nomor];
    [self.containerNominal setText:self.nominal];
    [self.containerTotal setText:self.total];
}

#

- (IBAction)back:(UIButton *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)continue:(UIButton *)sender {
    
}

@end
