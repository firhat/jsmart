//
//  ChangeAvatarViewController.h
//  JSmart
//
//  Created by whcl on 17/07/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import "CellAvatarCollectionViewCell.h"

@protocol ChangeAvatarDelegate <NSObject>
- (void)selectAvatar:(UIImage*)image;
@end

@interface ChangeAvatarViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CellAvatarDelegate>

@property NSMutableArray* avatars;
@property id<ChangeAvatarDelegate> delegate;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

- (IBAction)back:(UIButton *)sender;

@end
