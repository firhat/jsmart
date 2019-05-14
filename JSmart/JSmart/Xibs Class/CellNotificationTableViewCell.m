//
//  CellNotificationTableViewCell.m
//  JSmart
//
//  Created by whcl on 02/07/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import "CellNotificationTableViewCell.h"

@implementation CellNotificationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)selectCell:(UIButton *)sender {
    [self.delegate selectCell:self.cellNumber];
}
@end
