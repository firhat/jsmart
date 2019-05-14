//
//  ECashHistoryDetailViewController.m
//  JSmart
//
//  Created by whcl on 28/09/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import "ECashHistoryDetailViewController.h"

@interface ECashHistoryDetailViewController ()

@end

@implementation ECashHistoryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self displayHistory];
}

- (void)displayHistory {
    [self.containerStatus setText:@"BERHASIL"];
    [self.containerTime setText:[self.history objectForKey:@"transactionDate"]];
    [self.containerAccountNumber setText:@"081222441086"];
    [self.containerChannel setText:@"-"];
    [self.containerAmount setText:[self.history objectForKey:@"amount"]];
    [self.containerAdminFee setText:@"-"];
    [self.containerTotal setText:[self.history objectForKey:@"amount"]];
    [self.containerRef setText:[self.history objectForKey:@"transactionNumber"]];
}

- (IBAction)back:(UIButton *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
