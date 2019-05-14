//
//  BeliPulsaDaftarNomorTeleponTableViewCell.m
//  JSmart
//
//  Created by whcl on 30/09/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import "BeliPulsaDaftarNomorTeleponTableViewCell.h"

@implementation BeliPulsaDaftarNomorTeleponTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)tapButtonFavorite:(UIButton *)sender {
    [self.delegate tapButtonFavorite:self.cellNumber];
}

- (IBAction)selectCell:(UIButton *)sender {
    [self.delegate selectCell:self.cellNumber];
}

@end
