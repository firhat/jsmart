//
//  CellLaporanFooterTableViewCell.m
//  JSmart
//
//  Created by whcl on 05/07/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import "CellLaporanFooterTableViewCell.h"

@implementation CellLaporanFooterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    if ([Helpers isAppInEnglish]) {
        [self.containerButtonComment setTitle:@"Comment" forState:UIControlStateNormal];
        [self.containerButtonLocation setTitle:@"Location" forState:UIControlStateNormal];
        [self.containerButtonShare setTitle:@"Share" forState:UIControlStateNormal];
    } else {
        [self.containerButtonComment setTitle:@"Komentar" forState:UIControlStateNormal];
        [self.containerButtonLocation setTitle:@"Lokasi" forState:UIControlStateNormal];
        [self.containerButtonShare setTitle:@"Bagikan" forState:UIControlStateNormal];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)comment:(UIButton *)sender {
    [self.delegate comment:self.cellNumber];
}

- (IBAction)seeLocation:(UIButton *)sender {
    [self.delegate seeLocation:self.cellNumber];
}

- (IBAction)share:(UIButton *)sender {
    [self.delegate share:self.cellNumber];
}
@end
