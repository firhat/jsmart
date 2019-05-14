//
//  HomeViewController.h
//  JSmartECash
//
//  Created by whcl on 18/08/18.
//  Copyright © 2018 JSmart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ECashConnection.h"
#import "Helpers.h"

@interface ECashHomeViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, HomeCollectionViewCellDelegate>

@property NSMutableArray* menusIcon;
@property NSMutableArray* menusTitle;
@property NSString* name;
@property NSString* balance;

@property (weak, nonatomic) IBOutlet UIImageView *containerProfilePicture;
@property (weak, nonatomic) IBOutlet UILabel *containerName;
@property (weak, nonatomic) IBOutlet UILabel *containerTotalDeposit;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
