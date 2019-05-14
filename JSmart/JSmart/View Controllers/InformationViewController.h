//
//  InformationViewController.h
//  JSmart
//
//  Created by whcl on 10/07/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellInformationTableViewCell.h"
#import "CellInformationImageTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface InformationViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property id information;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)back:(UIButton *)sender;

@end
