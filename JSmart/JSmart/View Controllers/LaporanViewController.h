//
//  LaporanViewController.h
//  JSmart
//
//  Created by whcl on 30/06/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellLaporanTableViewCell.h"
#import "CellLaporanFooterTableViewCell.h"
#import "CellLaporanAttachmentTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Helpers.h"
#import "LocationViewController.h"
#import "CommentViewController.h"

@interface LaporanViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, CellLaporanDelegate, CellLaporanFooterDelegate, CellLaporanAttachmentDelegate>

@property id post;

@property NSString* FROM_TIMELINE_TO_COMMENT;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)back:(UIButton *)sender;

@end
