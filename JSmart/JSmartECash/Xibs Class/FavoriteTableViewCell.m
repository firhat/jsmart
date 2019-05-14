//
//  FavoriteTableViewCell.m
//  JSmart
//
//  Created by whcl on 11/09/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import "FavoriteTableViewCell.h"

@implementation FavoriteTableViewCell

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
