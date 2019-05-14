//
//  HomeViewController.m
//  JSmartECash
//
//  Created by whcl on 18/08/18.
//  Copyright © 2018 JSmart. All rights reserved.
//

#import "ECashHomeViewController.h"

@interface ECashHomeViewController ()

@end

@implementation ECashHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.menusIcon = [[NSMutableArray alloc] initWithObjects:
                      [UIImage imageNamed:@"ico_topup"],
                      [UIImage imageNamed:@"ico_transfer"],
                      [UIImage imageNamed:@"ico_tarik_tunai"],
                      [UIImage imageNamed:@"ico_beli_pulsa"],
                      [UIImage imageNamed:@"ico_bayar_listrik"],
                      nil];
    self.menusTitle = [[NSMutableArray alloc] initWithObjects:
                       @"Top-Up",
                       @"Transfer",
                       @"Tarik Tunai",
                       @"Beli Pulsa",
                       @"Bayar Listrik",
                       nil];
    [self.collectionView registerNib:[UINib nibWithNibName:@"HomeCollectionViewCell" bundle:nil]
          forCellWithReuseIdentifier:@"HomeCollectionViewCell"];
    
    [self inquireProfile];
    [self inquireBalance];
}

#pragma Delegates

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width - 60;
    CGFloat wantedWidth = screenWidth / 3;
    return CGSizeMake(wantedWidth, wantedWidth);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.menusTitle count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCollectionViewCell" forIndexPath:indexPath];
    NSInteger index = [indexPath row];
    cell.cellNumber = index;
    [cell.containerImage setImage:[self.menusIcon objectAtIndex:index]];
    [cell.containerTitle setText:[self.menusTitle objectAtIndex:index]];
    return cell;
}

- (void)selectCell:(NSInteger)cellNumber {
    switch (cellNumber) {
        case 0:
            //Move
            break;
        case 1:
            //Move
            break;
        case 2:
            //Move
            break;
        case 3:
            //Move
            break;
        case 4:
            //Move
            break;
        default:
            break;
    }
}

#

#pragma Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

#

#pragma Connection

- (void)inquireProfile {
    UIActivityIndicatorView* activityIndicator = [Helpers getActivityIndicator:self];
    void (^success)(NSURLSessionTask *task, id responseObject) = ^void(NSURLSessionTask *task, id responseObject) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        if (![[responseObject objectForKey:@"status"] boolValue]) {
            [Helpers alertFailure:[responseObject objectForKey:@"message"] viewController:self];
            return;
        }
        self.name = [[responseObject objectForKey:@"data"] objectForKey:@"name"];
        [self.containerName setText:self.name];
    };
    void (^failure)(NSURLSessionTask *operation, NSError *error) = ^void(NSURLSessionTask *operation, NSError *error) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        [Helpers alertFailure:[error localizedDescription] viewController:self];
    };
    NSString* msisdn = @"081222441086";
    NSString* token = @"111977DC72BAFB172EA58DBD587A34DF";
    NSString* email_jsmart = @"rhmtsaepuloh@gmail.com";
    NSString* token_jsmart = @"bc6ff909eed72dcd12a8e003c3c529b9";
    [activityIndicator startAnimating];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [ECashConnection inquireProfile:msisdn token:token email_jsmart:email_jsmart token_jsmart:token_jsmart success:success failure:failure];
}

- (void)inquireBalance {
    UIActivityIndicatorView* activityIndicator = [Helpers getActivityIndicator:self];
    void (^success)(NSURLSessionTask *task, id responseObject) = ^void(NSURLSessionTask *task, id responseObject) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        if (![[responseObject objectForKey:@"status"] boolValue]) {
            [Helpers alertFailure:[responseObject objectForKey:@"message"] viewController:self];
            return;
        }
        self.balance = [[responseObject objectForKey:@"data"] objectForKey:@"accountBalance"];
        self.balance = [NSString stringWithFormat:@"%.2f", [self.balance floatValue]];
        [self.containerTotalDeposit setText:self.balance];
    };
    void (^failure)(NSURLSessionTask *operation, NSError *error) = ^void(NSURLSessionTask *operation, NSError *error) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        [Helpers alertFailure:[error localizedDescription] viewController:self];
    };
    NSString* msisdn = @"081222441086";
    NSString* token = @"111977DC72BAFB172EA58DBD587A34DF";
    NSString* email_jsmart = @"rhmtsaepuloh@gmail.com";
    NSString* token_jsmart = @"bc6ff909eed72dcd12a8e003c3c529b9";
    [activityIndicator startAnimating];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [ECashConnection inquireBalance:msisdn token:token email_jsmart:email_jsmart token_jsmart:token_jsmart success:success failure:failure];
}

#


@end
