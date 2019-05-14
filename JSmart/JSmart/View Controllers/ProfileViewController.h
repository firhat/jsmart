//
//  ProfileViewController.h
//  JSmart
//
//  Created by whcl on 29/06/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import "Connection.h"
#import "Helpers.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ChangeProfileViewController.h"
#import <BFRImageViewer/BFRImageViewController.h>

@interface ProfileViewController : UIViewController

@property BOOL IS_PROFILE_UPDATED;
@property NSMutableDictionary* user;

@property (weak, nonatomic) IBOutlet UIImageView *containerUserPicture;
@property (weak, nonatomic) IBOutlet UILabel *containerUserName;
@property (weak, nonatomic) IBOutlet UILabel *containerUserName2;
@property (weak, nonatomic) IBOutlet UILabel *containerEmail;
@property (weak, nonatomic) IBOutlet UILabel *containerPhone;
@property (weak, nonatomic) IBOutlet UIButton *containerPoint;
@property (weak, nonatomic) IBOutlet UIButton *containerRank;

- (IBAction)clickUserPicture:(UIButton *)sender;
- (IBAction)change:(UIButton *)sender;
- (IBAction)checkPoint:(UIButton *)sender;
- (IBAction)checkRank:(UIButton *)sender;
- (IBAction)signOut:(UIButton *)sender;

@end
