//
//  TimelineViewController.h
//  JSmart
//
//  Created by whcl on 29/06/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellLaporanTableViewCell.h"
#import "CellLaporanFooterTableViewCell.h"
#import "CellLaporanAttachmentTableViewCell.h"
#import "Connection.h"
#import "Helpers.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "LocationViewController.h"
#import "LaporanViewController.h"
#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>
#import <BFRImageViewer/BFRImageViewController.h>

@interface TimelineViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, CellLaporanDelegate, CellLaporanFooterDelegate, CellLaporanAttachmentDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)back:(UIButton *)sender;

@end
