//
//  FavoriteTransferViewController.h
//  JSmart
//
//  Created by whcl on 11/09/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECashConnection.h"
#import "Helpers.h"
#import "FavoriteTableViewCell.h"

@interface FavoriteTransferViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, FavoriteTableViewCellDelegate>

@property NSMutableArray* favorites;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
