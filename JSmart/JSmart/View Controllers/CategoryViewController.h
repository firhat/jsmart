//
//  CategoryViewController.h
//  JSmart
//
//  Created by whcl on 29/06/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Connection.h"
#import "Helpers.h"
#import "CellCategoryCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "LaporViewController.h"

@interface CategoryViewController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

- (IBAction)back:(UIButton *)sender;

@end
