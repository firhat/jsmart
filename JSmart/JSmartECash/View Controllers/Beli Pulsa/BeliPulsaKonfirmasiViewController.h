//
//  BeliPulsaKonfirmasiViewController.h
//  JSmart
//
//  Created by whcl on 30/09/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Helpers.h"
#import "ECashConnection.h"

@interface BeliPulsaKonfirmasiViewController : UIViewController

@property NSString* transferTypeId;
@property NSString* nameOperator;
@property NSString* nomor;
@property NSString* nominal;
@property NSString* total;

@property (weak, nonatomic) IBOutlet UILabel *containerOperator;
@property (weak, nonatomic) IBOutlet UILabel *containerNomor;
@property (weak, nonatomic) IBOutlet UILabel *containerNominal;
@property (weak, nonatomic) IBOutlet UILabel *containerTotal;

- (IBAction)back:(UIButton *)sender;
- (IBAction)continue:(UIButton *)sender;

@end
