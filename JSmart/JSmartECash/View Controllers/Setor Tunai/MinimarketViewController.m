//
//  MinimarketViewController.m
//  JSmart
//
//  Created by whcl on 11/09/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import "MinimarketViewController.h"

@interface MinimarketViewController ()

@end

@implementation MinimarketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)back:(UIButton *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)submit:(UIButton *)sender {
    [self.containerSuccessMessage setHidden:false];
}

- (IBAction)ok:(UIButton *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
