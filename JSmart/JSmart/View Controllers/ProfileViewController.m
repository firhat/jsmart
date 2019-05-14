//
//  ProfileViewController.m
//  JSmart
//
//  Created by whcl on 29/06/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getUser];
    self.IS_PROFILE_UPDATED = false;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.IS_PROFILE_UPDATED) {
        [self getUser];
    }
    self.IS_PROFILE_UPDATED = false;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma Connection

- (void)getUser {
    UIActivityIndicatorView* activityIndicator = [Helpers getActivityIndicator:self];
    void (^success)(NSURLSessionTask *task, id responseObject) = ^void(NSURLSessionTask *task, id responseObject) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        if (![[responseObject objectForKey:@"status"] boolValue]) {
            [Helpers alertFailure:[responseObject objectForKey:@"message"] viewController:self];
            return;
        }
        [self parseUserInfo:responseObject];
        [self getPoint];
    };
    void (^failure)(NSURLSessionTask *operation, NSError *error) = ^void(NSURLSessionTask *operation, NSError *error) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        [Helpers alertFailure:[error localizedDescription] viewController:self];
    };
    NSString* email = [[NSUserDefaults standardUserDefaults] stringForKey:@"email"];
    NSString* token = [[NSUserDefaults standardUserDefaults] stringForKey:@"token"];
    [activityIndicator startAnimating];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [Connection getUser:email token:token success:success failure:failure];
}

- (void)getPoint {
    UIActivityIndicatorView* activityIndicator = [Helpers getActivityIndicator:self];
    void (^success)(NSURLSessionTask *task, id responseObject) = ^void(NSURLSessionTask *task, id responseObject) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        if (![[responseObject objectForKey:@"status"] boolValue]) {
            [Helpers alertFailure:[responseObject objectForKey:@"message"] viewController:self];
            return;
        }
        [self parsePoint:responseObject];
        [self getRank];
    };
    void (^failure)(NSURLSessionTask *operation, NSError *error) = ^void(NSURLSessionTask *operation, NSError *error) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        [Helpers alertFailure:[error localizedDescription] viewController:self];
    };
    NSString* email = [[NSUserDefaults standardUserDefaults] stringForKey:@"email"];
    NSString* token = [[NSUserDefaults standardUserDefaults] stringForKey:@"token"];
    [activityIndicator startAnimating];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [Connection getPoint:email token:token success:success failure:failure];
}

- (void)getRank {
    UIActivityIndicatorView* activityIndicator = [Helpers getActivityIndicator:self];
    void (^success)(NSURLSessionTask *task, id responseObject) = ^void(NSURLSessionTask *task, id responseObject) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        if (![[responseObject objectForKey:@"status"] boolValue]) {
            [Helpers alertFailure:[responseObject objectForKey:@"message"] viewController:self];
            return;
        }
        [self parseRanking:responseObject];
    };
    void (^failure)(NSURLSessionTask *operation, NSError *error) = ^void(NSURLSessionTask *operation, NSError *error) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        [Helpers alertFailure:[error localizedDescription] viewController:self];
    };
    NSString* email = [[NSUserDefaults standardUserDefaults] stringForKey:@"email"];
    NSString* token = [[NSUserDefaults standardUserDefaults] stringForKey:@"token"];
    [activityIndicator startAnimating];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [Connection getRank:email token:token success:success failure:failure];
}

#pragma

- (void)parseUserInfo:(id)responseObject {
    self.user = [[NSMutableDictionary alloc] initWithDictionary:(NSDictionary*)[[responseObject objectForKey:@"data"] objectForKey:@"user"]];
    for (NSString* key in [self.user allKeys]) {
        if ([[self.user objectForKey:key] isKindOfClass:[NSNull class]]) {
            [self.user removeObjectForKey:key];
            [self.user setValue:@"" forKey:key];
        }
    }
    [self.containerUserPicture sd_setImageWithURL:[self.user objectForKey:@"foto"] placeholderImage:[UIImage imageNamed:@"ico_person_rounded_grey"]];
    [self.containerUserName setText:[self.user objectForKey:@"nama"]];
    [self.containerUserName2 setText:[self.user objectForKey:@"nama"]];
    [self.containerEmail setText:[self.user objectForKey:@"email"]];
    [self.containerPhone setText:[self.user objectForKey:@"telp"]];
}

- (void)parsePoint:(id)responseObject {
    id point = [[responseObject objectForKey:@"data"] objectForKey:@"total_point"];
    NSString* finalPoint;
    if ([point isKindOfClass:[NSNumber class]]) {
        finalPoint = [point stringValue];
    } else if ([point isKindOfClass:[NSNull class]]) {
        finalPoint = @"0";
    } else {
        finalPoint = point;
    }
    [self.containerPoint setTitle:finalPoint forState:UIControlStateNormal];
}

- (void)parseRanking:(id)responseObject {
    id rank = [[responseObject objectForKey:@"data"] objectForKey:@"posisi"];
    NSString* finalRank;
    if ([rank isKindOfClass:[NSNumber class]]) {
        finalRank = [rank stringValue];
    } else {
        finalRank = rank;
    }
    [self.containerRank setTitle:finalRank forState:UIControlStateNormal];
}

#pragma IBActions

- (IBAction)clickUserPicture:(UIButton *)sender {
    BFRImageViewController *imageVC = [[BFRImageViewController alloc] initWithImageSource:@[[self.containerUserPicture image]]];
    [self presentViewController:imageVC animated:YES completion:nil];
}

- (IBAction)change:(UIButton *)sender {
    [self performSegueWithIdentifier:@"ChangeProfile" sender:nil];
}

- (IBAction)checkPoint:(UIButton *)sender {
    
}

- (IBAction)checkRank:(UIButton *)sender {
    
}

- (IBAction)signOut:(UIButton *)sender {
    [Helpers removeLoginInformation];
    [self.view.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSString* identifier = [segue identifier];
    if ([identifier isEqualToString:@"ChangeProfile"]) {
        ChangeProfileViewController* vc = [segue destinationViewController];
        vc.user = self.user;
        vc.profileViewController = self;
    }
}
@end
