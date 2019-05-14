//
//  HistoryTableViewCell.h
//  JSmart
//
//  Created by whcl on 28/09/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HistoryTableViewCellDelegate <NSObject>

- (void)selectCell:(NSInteger)cellNumber;

@end

@interface HistoryTableViewCell : UITableViewCell

@property NSInteger cellNumber;
@property id<HistoryTableViewCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *containerDate;
@property (weak, nonatomic) IBOutlet UILabel *containerTitle;
@property (weak, nonatomic) IBOutlet UILabel *containerType;
@property (weak, nonatomic) IBOutlet UILabel *containerAmount;

- (IBAction)selectCell:(UIButton *)sender;

@end
