//
//  BeliPulsaDaftarNomorTeleponTableViewCell.h
//  JSmart
//
//  Created by whcl on 30/09/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BeliPulsaDaftarNomorTeleponTableViewCellDelegate <NSObject>

- (void)tapButtonFavorite:(NSInteger)cellNumber;
- (void)selectCell:(NSInteger)cellNumber;

@end

@interface BeliPulsaDaftarNomorTeleponTableViewCell : UITableViewCell

@property NSInteger cellNumber;
@property id<BeliPulsaDaftarNomorTeleponTableViewCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *containerNomorTelepon;
@property (weak, nonatomic) IBOutlet UIButton *buttonFavorite;

- (IBAction)tapButtonFavorite:(UIButton *)sender;
- (IBAction)selectCell:(UIButton *)sender;

@end
