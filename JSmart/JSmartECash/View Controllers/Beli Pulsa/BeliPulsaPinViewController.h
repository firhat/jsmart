//
//  BeliPulsaPinViewController.h
//  JSmart
//
//  Created by whcl on 30/09/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BeliPulsaPinViewController : UIViewController <UITextFieldDelegate>

@property NSString* pin;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *containerPinDigit1;
@property (weak, nonatomic) IBOutlet UITextField *containerPinDigit2;
@property (weak, nonatomic) IBOutlet UITextField *containerPinDigit3;
@property (weak, nonatomic) IBOutlet UITextField *containerPinDigit4;
@property (weak, nonatomic) IBOutlet UITextField *containerPinDigit5;
@property (weak, nonatomic) IBOutlet UITextField *containerPinDigit6;

- (IBAction)back:(UIButton *)sender;
- (IBAction)submit:(UIButton *)sender;

@end
