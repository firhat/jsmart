//
//  CellAvatarCollectionViewCell.h
//  JSmart
//
//  Created by whcl on 17/07/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CellAvatarDelegate <NSObject>

- (void)selectCell:(NSInteger)cellNumber;

@end

@interface CellAvatarCollectionViewCell : UICollectionViewCell

@property NSInteger cellNumber;
@property id<CellAvatarDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *containerImage;

- (IBAction)selectCell:(UIButton *)sender;

@end
