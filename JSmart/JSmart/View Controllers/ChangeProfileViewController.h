//
//  ChangeProfileViewController.h
//  JSmart
//
//  Created by whcl on 01/07/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Connection.h"
#import "Helpers.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Globals.h"
#import "ProfileViewController.h"
#import "ChangeAvatarViewController.h"

@interface ChangeProfileViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate, ChangeAvatarDelegate>

@property BOOL IS_USER_INFO_CHANGED;
@property BOOL IS_IMAGE_CHANGED;
@property UIImage* USER_PICTURE;
@property NSMutableDictionary* user;
@property UIViewController* profileViewController;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *containerUserPicture;
@property (weak, nonatomic) IBOutlet UITextField *containerName;
@property (weak, nonatomic) IBOutlet UITextField *containerEmail;
@property (weak, nonatomic) IBOutlet UITextField *containerPhone;
@property (weak, nonatomic) IBOutlet UITextField *containerOldPassword;
@property (weak, nonatomic) IBOutlet UITextField *containerNewPassword;
@property (weak, nonatomic) IBOutlet UITextField *containerConfirmationNewPassword;

- (IBAction)back:(UIButton *)sender;
- (IBAction)save:(UIButton *)sender;
- (IBAction)changeUserPicture:(UIButton *)sender;

@end
