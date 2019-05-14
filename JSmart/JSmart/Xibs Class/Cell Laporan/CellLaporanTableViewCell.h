//
//  CellLaporanTableViewCell.h
//  JSmart
//
//  Created by whcl on 30/06/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CellLaporanDelegate <NSObject>

- (void)selectCell:(NSInteger) cellNumber;

@end

@interface CellLaporanTableViewCell : UITableViewCell

@property id<CellLaporanDelegate> delegate;
@property NSInteger cellNumber;

@property (weak, nonatomic) IBOutlet UIImageView *containerUserPicture;
@property (weak, nonatomic) IBOutlet UILabel *containerUserName;
@property (weak, nonatomic) IBOutlet UILabel *containerDate;
@property (weak, nonatomic) IBOutlet UIImageView *containerCategoryIcon;
@property (weak, nonatomic) IBOutlet UILabel *containerCategoryName;
@property (weak, nonatomic) IBOutlet UIImageView *containerStatus;
@property (weak, nonatomic) IBOutlet UILabel *containerTitle;
@property (weak, nonatomic) IBOutlet UILabel *containerContent;

- (IBAction)selectCell:(UIButton *)sender;




@end
