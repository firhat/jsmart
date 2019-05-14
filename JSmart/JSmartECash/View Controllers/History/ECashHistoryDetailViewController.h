//
//  ECashHistoryDetailViewController.h
//  JSmart
//
//  Created by whcl on 28/09/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ECashHistoryDetailViewController : UIViewController

@property NSDictionary* history;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *containerStatus;
@property (weak, nonatomic) IBOutlet UILabel *containerTime;
@property (weak, nonatomic) IBOutlet UILabel *containerAccountNumber;
@property (weak, nonatomic) IBOutlet UILabel *containerChannel;
@property (weak, nonatomic) IBOutlet UILabel *containerAmount;
@property (weak, nonatomic) IBOutlet UILabel *containerAdminFee;
@property (weak, nonatomic) IBOutlet UILabel *containerTotal;
@property (weak, nonatomic) IBOutlet UILabel *containerRef;

- (IBAction)back:(UIButton *)sender;

@end
