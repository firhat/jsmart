//
//  BeliPulsaSuksesViewController.m
//  JSmart
//
//  Created by whcl on 30/09/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import "BeliPulsaSuksesViewController.h"

@interface BeliPulsaSuksesViewController ()

@end

@implementation BeliPulsaSuksesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)displayInformation {
    [self.containerStatus setText:self.status];
    [self.containerWaktu setText:self.waktu];
    [self.containerNomorAkun setText:self.nomorAkun];
    [self.containerNominal setText:self.nominal];
    [self.containerJumlahBayar setText:self.jumlahBayar];
    [self.containerNoTransaksi setText:self.nomorTransaksi];
}

- (IBAction)back:(UIButton *)sender {
    [[[[self.presentingViewController presentingViewController] presentingViewController] presentingViewController] dismissViewControllerAnimated:true completion:nil];
}

@end
