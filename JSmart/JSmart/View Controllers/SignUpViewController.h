//
//  SignUpViewController.h
//  JSmart
//
//  Created by whcl on 27/06/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Connection.h"
#import "Helpers.h"
#import "Strings.h"

@interface SignUpViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *containerName;
@property (weak, nonatomic) IBOutlet UITextField *containerEmail;
@property (weak, nonatomic) IBOutlet UITextField *containerPassword;
@property (weak, nonatomic) IBOutlet UITextField *containerConfirmationPassword;
@property (weak, nonatomic) IBOutlet UITextField *containerPhone;
@property (weak, nonatomic) IBOutlet UILabel *versionText;

- (IBAction)signUp:(UIButton *)sender;
- (IBAction)signIn:(UIButton *)sender;


@end
