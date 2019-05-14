//
//  FavoriteTableViewCell.h
//  JSmart
//
//  Created by whcl on 11/09/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FavoriteTableViewCellDelegate <NSObject>

- (void) selectCell:(NSInteger)cellNumber;

@end

@interface FavoriteTableViewCell : UITableViewCell

@property NSInteger cellNumber;
@property id<FavoriteTableViewCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *containerDate;
@property (weak, nonatomic) IBOutlet UILabel *containerTitle;
@property (weak, nonatomic) IBOutlet UILabel *containerType;

- (IBAction)selectCell:(UIButton *)sender;

@end
