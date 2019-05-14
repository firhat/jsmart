//
//  CellInformationCollectionViewCell.h
//  JSmart
//
//  Created by whcl on 04/07/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CellInformationDelegate <NSObject>

- (void)selectCell:(NSInteger)cellNumber;

@end

@interface CellInformationCollectionViewCell : UICollectionViewCell

@property NSInteger cellNumber;
@property id<CellInformationDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *containerImage;
@property (weak, nonatomic) IBOutlet UILabel *containerTitle;

- (IBAction)selectCell:(UIButton *)sender;

@end
