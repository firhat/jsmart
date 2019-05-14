//
//  VisaDebitCardSuccessViewController.h
//  JSmart
//
//  Created by whcl on 16/09/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetorTunaiViewController.h"

@interface VisaDebitCardSuccessViewController : UIViewController

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
