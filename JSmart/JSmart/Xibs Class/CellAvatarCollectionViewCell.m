//
//  CellAvatarCollectionViewCell.m
//  JSmart
//
//  Created by whcl on 17/07/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import "CellAvatarCollectionViewCell.h"

@implementation CellAvatarCollectionViewCell

- (IBAction)selectCell:(UIButton *)sender {
    [self.delegate selectCell:self.cellNumber];
}

@end
