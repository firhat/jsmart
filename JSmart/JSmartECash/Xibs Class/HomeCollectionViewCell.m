//
//  HomeCollectionViewCell.m
//  JSmartECash
//
//  Created by whcl on 28/08/18.
//  Copyright © 2018 JSmart. All rights reserved.
//

#import "HomeCollectionViewCell.h"

@implementation HomeCollectionViewCell

- (IBAction)selectCell:(UIButton *)sender {
    [self.delegate selectCell:self.cellNumber];
}
@end
