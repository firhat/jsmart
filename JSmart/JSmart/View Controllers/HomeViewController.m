//
//  HomeViewController.m
//  JSmart
//
//  Created by whcl on 29/06/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getInformation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma Delegates

- (void)selectCell:(NSInteger)cellNumber {
    [self performSegueWithIdentifier:@"Information" sender:@[[self.informations objectAtIndex:cellNumber]]];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat constantHeight = 200;
    return CGSizeMake(screenWidth, constantHeight);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.informations count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CellInformationCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellInformation" forIndexPath:indexPath];
    id information = [self.informations objectAtIndex:[indexPath row]];
    cell.cellNumber = [indexPath row];
    cell.delegate = self;
    [cell.containerTitle setText:[information objectForKey:@"judul_informasi"]];
    [cell.containerImage sd_setImageWithURL:[information objectForKey:@"foto_informasi"]];
    return cell;
}

#pragma Connection

- (void)getInformation {
    UIActivityIndicatorView* activityIndicator = [Helpers getActivityIndicator:self];
    void (^success)(NSURLSessionTask *task, id responseObject) = ^void(NSURLSessionTask *task, id responseObject) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        if (![[responseObject objectForKey:@"status"] boolValue]) {
            [Helpers alertFailure:[responseObject objectForKey:@"message"] viewController:self];
            return;
        }
        self.informations = [[NSMutableArray alloc] initWithArray:[[responseObject objectForKey:@"data"] objectForKey:@"informasi"]];
        [self.collectionView reloadData];
    };
    void (^failure)(NSURLSessionTask *operation, NSError *error) = ^void(NSURLSessionTask *operation, NSError *error) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        [Helpers alertFailure:[error localizedDescription] viewController:self];
    };
    NSString* email = [[NSUserDefaults standardUserDefaults] stringForKey:@"email"];
    NSString* token = [[NSUserDefaults standardUserDefaults] stringForKey:@"token"];
    NSNumber* page = [[NSNumber alloc] initWithInt:1];
    [activityIndicator startAnimating];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [Connection getInformation:email token:token page:page success:success failure:failure];
}

#pragma Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSString* identifier = [segue identifier];
    if ([identifier isEqualToString:@"Information"]) {
        InformationViewController* vc = [segue destinationViewController];
        vc.information = [sender objectAtIndex:0];
    }
}

#pragma IBActions

- (IBAction)lapor:(UIButton *)sender {
    [self performSegueWithIdentifier:@"Category" sender:nil];
}

- (IBAction)seeLocation:(UIButton *)sender {
    [self performSegueWithIdentifier:@"Location" sender:nil];
}

- (IBAction)seeTimeline:(UIButton *)sender {
    [self performSegueWithIdentifier:@"Timeline" sender:nil];
}
@end
