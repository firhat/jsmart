//
//  MinimarketViewController.h
//  JSmart
//
//  Created by whcl on 11/09/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MinimarketViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *containerEcashNumber;
@property (weak, nonatomic) IBOutlet UIView *containerSuccessMessage;


- (IBAction)back:(UIButton *)sender;
- (IBAction)submit:(UIButton *)sender;
- (IBAction)ok:(UIButton *)sender;

@end
