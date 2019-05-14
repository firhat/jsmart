//
//  HomeCollectionViewCell.h
//  JSmartECash
//
//  Created by whcl on 28/08/18.
//  Copyright © 2018 JSmart. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeCollectionViewCellDelegate <NSObject>

- (void)selectCell:(NSInteger)cellNumber;

@end

@interface HomeCollectionViewCell : UICollectionViewCell

@property NSInteger cellNumber;
@property id<HomeCollectionViewCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *containerImage;
@property (weak, nonatomic) IBOutlet UILabel *containerTitle;

- (IBAction)selectCell:(UIButton *)sender;

@end
