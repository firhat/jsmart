//
//  BeliPulsaDaftarNomorTeleponViewController.h
//  JSmart
//
//  Created by whcl on 30/09/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BeliPulsaDaftarNomorTeleponTableViewCell.h"
#import "Helpers.h"
#import "ECashConnection.h"

@protocol BeliPulsaDaftarNomorTeleponViewControllerDelegate <NSObject>

- (void)selectNomorTeleponFromDaftar:(NSString*)nomorTelepon;

@end

@interface BeliPulsaDaftarNomorTeleponViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, BeliPulsaDaftarNomorTeleponTableViewCellDelegate>

@property NSMutableArray* favorites;
@property id<BeliPulsaDaftarNomorTeleponViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
