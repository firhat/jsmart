//
//  CellCommentAttachmentTableViewCell.m
//  JSmart
//
//  Created by whcl on 05/07/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import "CellCommentAttachmentTableViewCell.h"

@implementation CellCommentAttachmentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)selectCell:(UIButton *)sender {
    [self.delegate selectCell:[self.containerImage image]];
}
@end
