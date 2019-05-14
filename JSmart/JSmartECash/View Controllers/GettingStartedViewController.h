//
//  GettingStartedViewController.h
//  JSmartECash
//
//  Created by whcl on 04/09/18.
//  Copyright © 2018 JSmart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GettingStartedCollectionViewCell.h"

@interface GettingStartedViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property NSMutableArray* images;
@property NSMutableArray* titles;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

- (IBAction)start:(UIButton *)sender;

@end
