//
//  NotificationViewController.h
//  JSmart
//
//  Created by whcl on 29/06/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import "CellNotificationTableViewCell.h"
#import "Connection.h"
#import "Helpers.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "LaporanViewController.h"

@interface NotificationViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, CellNotificationDelegate>

@property id post;
@property BOOL UNREAD_NOTIFICATION_IS_READ;
@property id selectedNotification;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
