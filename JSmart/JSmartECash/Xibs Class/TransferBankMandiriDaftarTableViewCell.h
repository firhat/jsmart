//
//  TransferBankMandiriDaftarTableViewCell.h
//  JSmart
//
//  Created by whcl on 17/09/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TransferBankMandiriDaftarTableViewCellDelegate
- (void)selectCell:(NSInteger)cellNumber;
@end

@interface TransferBankMandiriDaftarTableViewCell : UITableViewCell

@property NSInteger cellNumber;
@property id<TransferBankMandiriDaftarTableViewCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *containerNumber;
@property (weak, nonatomic) IBOutlet UIButton *containerButton;

- (IBAction)selectCell:(UIButton *)sender;

@end
