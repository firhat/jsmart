//
//  GettingStartedViewController.m
//  JSmartECash
//
//  Created by whcl on 04/09/18.
//  Copyright © 2018 JSmart. All rights reserved.
//

#import "GettingStartedViewController.h"

@interface GettingStartedViewController ()

@end

@implementation GettingStartedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.images = [[NSMutableArray alloc] initWithObjects:
                   [UIImage imageNamed:@"img_getting_started_1"],
                   [UIImage imageNamed:@"img_getting_started_2"],
                   nil];
    self.titles = [[NSMutableArray alloc] initWithObjects:
                   @"Nikmati Layanan E-Cash di YES",
                   @"Gunakan PIN Rekening Mandiri E-Cash",
                   nil];
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma Delegates

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.images count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GettingStartedCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GettingStartedCollectionViewCell" forIndexPath:indexPath];
    [cell.containerImage setImage:[self.images objectAtIndex:[indexPath row]]];
    [cell.containerTitle setText:[self.titles objectAtIndex:[indexPath row]]];
    return cell;
}


- (IBAction)start:(UIButton *)sender {
    [self performSegueWithIdentifier:@"PhoneRegistrationViewController" sender:self];
}

@end
