//
//  HistoryTableViewCell.m
//  JSmart
//
//  Created by whcl on 28/09/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import "HistoryTableViewCell.h"

@implementation HistoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)selectCell:(UIButton *)sender {
    [self.delegate selectCell:self.cellNumber];
}

@end
