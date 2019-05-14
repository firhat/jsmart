//
//  CellLaporanFooterTableViewCell.h
//  JSmart
//
//  Created by whcl on 05/07/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Helpers.h"

@protocol CellLaporanFooterDelegate <NSObject>

- (void)comment:(NSInteger) cellNumber;
- (void)seeLocation:(NSInteger) cellNumber;
- (void)share:(NSInteger) cellNumber;
- (void)selectCell:(NSInteger) cellNumber;

@end

@interface CellLaporanFooterTableViewCell : UITableViewCell

@property id<CellLaporanFooterDelegate> delegate;
@property NSInteger cellNumber;

@property (weak, nonatomic) IBOutlet UIView *containerBorder;
@property (weak, nonatomic) IBOutlet UIButton *containerButtonComment;
@property (weak, nonatomic) IBOutlet UIButton *containerButtonLocation;
@property (weak, nonatomic) IBOutlet UIButton *containerButtonShare;


- (IBAction)comment:(UIButton *)sender;
- (IBAction)seeLocation:(UIButton *)sender;
- (IBAction)share:(UIButton *)sender;

@end
