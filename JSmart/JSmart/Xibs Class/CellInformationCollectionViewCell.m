//
//  CellInformationCollectionViewCell.m
//  JSmart
//
//  Created by whcl on 04/07/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import "CellInformationCollectionViewCell.h"

@implementation CellInformationCollectionViewCell

#pragma IBActions

- (IBAction)selectCell:(UIButton *)sender {
    [self.delegate selectCell:self.cellNumber];
}
@end
