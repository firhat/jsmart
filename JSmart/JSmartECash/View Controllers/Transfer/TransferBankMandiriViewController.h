//
//  TransferBankMandiriViewController.h
//  JSmart
//
//  Created by whcl on 17/09/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransferBankMandiriViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *containerAccountNumber;
@property (weak, nonatomic) IBOutlet UITextField *containerAmount;
@property (weak, nonatomic) IBOutlet UITextField *containerMessage;

- (IBAction)back:(UIButton *)sender;
- (IBAction)submit:(UIButton *)sender;

@end
