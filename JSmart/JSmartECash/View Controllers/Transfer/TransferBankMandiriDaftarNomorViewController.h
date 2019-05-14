//
//  TransferBankMandiriDaftarNomorViewController.h
//  JSmart
//
//  Created by whcl on 17/09/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransferBankMandiriDaftarTableViewCell.h"

@interface TransferBankMandiriDaftarNomorViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, TransferBankMandiriDaftarTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
