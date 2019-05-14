//
//  RegistrationViewController.h
//  JSmartECash
//
//  Created by whcl on 04/09/18.
//  Copyright © 2018 JSmart. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistrationViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *containerName;
@property (weak, nonatomic) IBOutlet UITextField *containerDate;
@property (weak, nonatomic) IBOutlet UITextField *containerMonth;
@property (weak, nonatomic) IBOutlet UITextField *containerYear;
@property (weak, nonatomic) IBOutlet UITextField *containerEmail;
@property (weak, nonatomic) IBOutlet UITextField *containerPin;
@property (weak, nonatomic) IBOutlet UITextField *containerQuestion;
@property (weak, nonatomic) IBOutlet UITextField *containerAnswer;
@property (weak, nonatomic) IBOutlet UITextField *containerOtp;
@property (weak, nonatomic) IBOutlet UISwitch *optionAgreement1;
@property (weak, nonatomic) IBOutlet UISwitch *optionAgreement2;
@property (weak, nonatomic) IBOutlet UISwitch *optionAgreement3;
@property (weak, nonatomic) IBOutlet UISwitch *optionAgreement4;
@property (weak, nonatomic) IBOutlet UISwitch *optionAgreementAll;

- (IBAction)optionAgreementChanged:(UISwitch *)sender;
- (IBAction)requestOtp:(UIButton *)sender;
- (IBAction)submit:(UIButton *)sender;

@end
