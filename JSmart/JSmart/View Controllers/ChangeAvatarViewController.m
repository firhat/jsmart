//
//  ChangeAvatarViewController.m
//  JSmart
//
//  Created by whcl on 17/07/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import "ChangeAvatarViewController.h"

@interface ChangeAvatarViewController ()

@end

@implementation ChangeAvatarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.avatars = [[NSMutableArray alloc] initWithObjects:
               [UIImage imageNamed:@"ico_avatar_1"],
               [UIImage imageNamed:@"ico_avatar_2"],
               [UIImage imageNamed:@"ico_avatar_3"],
               [UIImage imageNamed:@"ico_avatar_4"],
               [UIImage imageNamed:@"ico_avatar_5"],
               nil];
}

#pragma Delegates

-(void)selectCell:(NSInteger)cellNumber {
    [self.delegate selectAvatar:[self.avatars objectAtIndex:cellNumber]];
    [self dismissViewControllerAnimated:true completion:nil];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat collectionViewWidth = [UIScreen mainScreen].bounds.size.width;
    return CGSizeMake(collectionViewWidth / 3.5, collectionViewWidth / 3.5);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.avatars count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CellAvatarCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellAvatar" forIndexPath:indexPath];
    cell.delegate = self;
    cell.cellNumber = [indexPath row];
    [cell.containerImage setImage:[self.avatars objectAtIndex:[indexPath row]]];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)back:(UIButton *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
