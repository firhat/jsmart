//
//  BankMandiriViewController.m
//  JSmart
//
//  Created by whcl on 16/09/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import "BankMandiriViewController.h"

@interface BankMandiriViewController ()

@end

@implementation BankMandiriViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)selectMandiriAtm:(UIButton *)sender {
    [self performSegueWithIdentifier:@"MandiriAtm" sender:self];
}

- (IBAction)selectMandiriSms:(UIButton *)sender {
    [self performSegueWithIdentifier:@"MandiriInternetSms" sender:self];
}

- (IBAction)selectMandiriAgen:(UIButton *)sender {
    [self performSegueWithIdentifier:@"MandiriAgen" sender:self];
}

- (IBAction)back:(UIButton *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
