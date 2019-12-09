//
//  SignInViewController.h
//  JSmart
//
//  Created by whcl on 27/06/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Connection.h"
#import "Helpers.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
@import GoogleSignIn;
#import "Strings.h"

@interface SignInViewController : UIViewController<GIDSignInDelegate, GIDSignInUIDelegate>

@property FBSDKLoginButton* facebookLoginButton;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *containerEmail;
@property (weak, nonatomic) IBOutlet UITextField *containerPassword;
@property (weak, nonatomic) IBOutlet UIButton *buttonSignIn;
@property (weak, nonatomic) IBOutlet UILabel *versionText;


- (IBAction)forgotPassword:(UIButton *)sender;
- (IBAction)signIn:(UIButton *)sender;
- (IBAction)signInWithFacebook:(UIButton *)sender;
- (IBAction)signInWithGoogle:(UIButton *)sender;
- (IBAction)signUp:(UIButton *)sender;

@end
