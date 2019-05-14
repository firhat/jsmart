//
//  HomeViewController.h
//  JSmart
//
//  Created by whcl on 29/06/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import "Connection.h"
#import "Helpers.h"
#import "CellInformationCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "InformationViewController.h"

@interface HomeViewController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CellInformationDelegate>

@property NSMutableArray* informations;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

- (IBAction)lapor:(UIButton *)sender;
- (IBAction)seeLocation:(UIButton *)sender;
- (IBAction)seeTimeline:(UIButton *)sender;

@end
