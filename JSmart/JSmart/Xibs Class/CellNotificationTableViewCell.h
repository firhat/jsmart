//
//  CellNotificationTableViewCell.h
//  JSmart
//
//  Created by whcl on 02/07/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CellNotificationDelegate<NSObject>

- (void)selectCell:(NSInteger)cellNumber;

@end

@interface CellNotificationTableViewCell : UITableViewCell

@property NSInteger cellNumber;
@property id<CellNotificationDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *containerSenderPicture;
@property (weak, nonatomic) IBOutlet UILabel *containerName;
@property (weak, nonatomic) IBOutlet UILabel *containerTime;
@property (weak, nonatomic) IBOutlet UIImageView *unreadSign;

- (IBAction)selectCell:(UIButton *)sender;

@end
