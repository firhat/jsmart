//
//  TarikTunaiViewController.m
//  JSmart
//
//  Created by whcl on 30/09/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import "TarikTunaiViewController.h"

@interface TarikTunaiViewController ()

@end

@implementation TarikTunaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)selectMinimarket:(UIButton *)sender {
    [self performSegueWithIdentifier:@"TarikTunaiMinimarketViewController" sender:self];
}

- (IBAction)selectAgen:(UIButton *)sender {
    [self performSegueWithIdentifier:@"TarikTunaiAgenViewController" sender:self];
}

- (IBAction)selectAtmMandiri:(UIButton *)sender {
//    [self performSegueWithIdentifier:@"TarikTunaiAtmMandiriViewController" sender:self];
}

- (IBAction)back:(UIButton *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
