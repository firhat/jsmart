//
//  SetorTunaiViewController.m
//  JSmart
//
//  Created by whcl on 11/09/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import "SetorTunaiViewController.h"

@interface SetorTunaiViewController ()

@end

@implementation SetorTunaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)close:(UIButton *)sender {
    
}

- (IBAction)selectDebitCard:(UIButton *)sender {
    [self performSegueWithIdentifier:@"VisaDebitCard" sender:self];
}

- (IBAction)selectMinimarket:(UIButton *)sender {
    [self performSegueWithIdentifier:@"Minimarket" sender:self];
}

- (IBAction)selectBankMandiri:(UIButton *)sender {
    [self performSegueWithIdentifier:@"BankMandiri" sender:self];
}
    

- (IBAction)selectBankLain:(UIButton *)sender {
    [self performSegueWithIdentifier:@"BankLain" sender:self];
}

@end
