//
//  PhoneRegistrationViewController.h
//  JSmartECash
//
//  Created by whcl on 04/09/18.
//  Copyright © 2018 JSmart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECashConnection.h"
#import "Helpers.h"

@interface PhoneRegistrationViewController : UIViewController

@property NSString* phone;
@property NSString* ticket;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *containerPhone;

- (IBAction)submit:(UIButton *)sender;

@end
