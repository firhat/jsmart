//
//  SignInViewController.m
//  JSmart
//
//  Created by whcl on 27/06/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import "SignInViewController.h"

@interface SignInViewController ()

@end

@implementation SignInViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardAppear:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDisappear:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    if ([[[NSUserDefaults standardUserDefaults] stringForKey:@"validity"] isEqualToString:@"VALID"]) {
        [self performSegueWithIdentifier:@"Home" sender:nil];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.facebookLoginButton = [[FBSDKLoginButton alloc] init];
    self.facebookLoginButton.readPermissions = @[@"public_profile", @"email"];
    [GIDSignIn sharedInstance].uiDelegate = self;
    [GIDSignIn sharedInstance].delegate = self;
    [self addKeyboardButton];
    [self getAppVersion];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self resignKeyboard];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)getAppVersion{
   NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    self.versionText.text = [NSString stringWithFormat: @"Version %@", version];
}

#pragma Keyboard

- (void)addKeyboardButton {
    CGRect keyboardToolbarFrame = CGRectMake(0, 0, self.view.bounds.size.width, 40);
    UIToolbar* keyboardToolbar = [[UIToolbar alloc] initWithFrame:keyboardToolbarFrame];
    UIBarButtonItem* buttonDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(resignKeyboard)];
    [keyboardToolbar setItems:[[NSArray alloc] initWithObjects:buttonDone, nil]];
    
    self.containerEmail.inputAccessoryView = keyboardToolbar;
    self.containerPassword.inputAccessoryView = keyboardToolbar;
}

- (void)resignKeyboard {
    [self.containerEmail resignFirstResponder];
    [self.containerPassword resignFirstResponder];
}

- (void)keyboardAppear:(NSNotification*)notification {
    NSDictionary* info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

- (void)keyboardDisappear:(NSNotification*)notification {
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

#pragma Validation

- (BOOL)validateSignInForm {
    if ([[self.containerEmail text] isEqualToString:@""]) {
        return false;
    }
    if ([[self.containerPassword text] isEqualToString:@""]) {
        return false;
    }
    return true;
}

#pragma IBActions

- (IBAction)forgotPassword:(UIButton *)sender {
    
}

- (IBAction)signIn:(UIButton *)sender {
    [self resignKeyboard];
    UIActivityIndicatorView* activityIndicator = [Helpers getActivityIndicator:self];
    void (^success)(NSURLSessionTask *task, id responseObject) = ^void(NSURLSessionTask *task, id responseObject) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        if (![[responseObject objectForKey:@"status"] boolValue]) {
            [Helpers alertFailure:[responseObject objectForKey:@"message"] viewController:self];
            return;
        }
        [self.containerEmail setText:@""];
        [self.containerPassword setText:@""];
        NSString* email = [[responseObject objectForKey:@"data"] objectForKey:@"email"];
        NSString* token = [[responseObject objectForKey:@"data"] objectForKey:@"token"];
        [Helpers saveLoginInformation:email token:token];
        [self performSegueWithIdentifier:@"Home" sender:nil];
    };
    void (^failure)(NSURLSessionTask *operation, NSError *error) = ^void(NSURLSessionTask *operation, NSError *error) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        [Helpers alertFailure:[error localizedDescription] viewController:self];
    };
    if (![self validateSignInForm]) {
        if ([Helpers isAppInEnglish]) {
            [Helpers alertFailure:[Strings EN_ALERT_INCOMPLETE_FIELDS] viewController:self];
        } else {
            [Helpers alertFailure:[Strings ID_ALERT_INCOMPLETE_FIELDS] viewController:self];
        }
        return;
    }
    NSString* email = [self.containerEmail text];
    NSString* password = [self.containerPassword text];
    [activityIndicator startAnimating];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [Connection signIn:email password:password success:success failure:failure];
}

- (IBAction)signInWithFacebook:(UIButton *)sender {
    UIActivityIndicatorView* activityIndicator = [Helpers getActivityIndicator:self];
    void (^success)(NSURLSessionTask *task, id responseObject) = ^void(NSURLSessionTask *task, id responseObject) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        if (![[responseObject objectForKey:@"status"] boolValue]) {
            [Helpers alertFailure:[responseObject objectForKey:@"message"] viewController:self];
            return;
        }
        NSString* email = [[responseObject objectForKey:@"data"] objectForKey:@"email"];
        NSString* token = [[responseObject objectForKey:@"data"] objectForKey:@"token"];
        [Helpers saveLoginInformation:email token:token];
        [self performSegueWithIdentifier:@"Home" sender:nil];
    };
    void (^failure)(NSURLSessionTask *operation, NSError *error) = ^void(NSURLSessionTask *operation, NSError *error) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        [Helpers alertFailure:[error localizedDescription] viewController:self];
    };
    void(^handler)(id) = ^(id result){
        if ([result objectForKey:@"email"] && [result objectForKey:@"name"]) {
            [activityIndicator startAnimating];
            [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
            [Connection signInWithSocialMedia:[result objectForKey:@"email"] name:[result objectForKey:@"name"] success:success failure:failure];
        } else {
            if ([Helpers isAppInEnglish]) {
                [Helpers alertFailure:[Strings EN_ALERT_FAILED_TO_LOGIN_WITH_SOCIAL_MEDIA] viewController:self];
            } else {
                [Helpers alertFailure:[Strings ID_ALERT_FAILED_TO_LOGIN_WITH_SOCIAL_MEDIA] viewController:self];
            }
        }
    };
    [self getFacebookUserData:handler];
}

- (IBAction)signInWithGoogle:(UIButton *)sender {
    [[GIDSignIn sharedInstance] signIn];
}

- (IBAction)signUp:(UIButton *)sender {
    [self performSegueWithIdentifier:@"SignUp" sender:nil];
}

#pragma Connection

- (void)getFacebookUserData:(void (^)(id))handler {
    void(^graphAPIhandler)(FBSDKGraphRequestConnection *connection, id result, NSError *error) = ^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
        if (error) {
            [Helpers alertFailure:[error localizedDescription] viewController:self];
        } else {
            handler(result);
        }
    };
    void(^loginHandler)(FBSDKLoginManagerLoginResult *result, NSError *error) = ^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error) {
            [Helpers alertFailure:[error localizedDescription] viewController:self];
        } else {
            if ([FBSDKAccessToken currentAccessToken]) {
                NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
                [parameters setValue:@"id,name,email" forKey:@"fields"];
                [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:parameters]
                 startWithCompletionHandler:graphAPIhandler];
            }
        }
    };
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    [loginManager logInWithReadPermissions:@[@"public_profile", @"email"]
                        fromViewController:self
                                   handler:loginHandler];
}

#pragma Delegates

- (void)signInWillDispatch:(GIDSignIn *)signIn error:(NSError *)error {
    
}

- (void)signIn:(GIDSignIn *)signIn presentViewController:(UIViewController *)viewController {
    [self presentViewController:viewController animated:YES completion:nil];
}

- (void)signIn:(GIDSignIn *)signIn dismissViewController:(UIViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error {
    UIActivityIndicatorView* activityIndicator = [Helpers getActivityIndicator:self];
    void (^success)(NSURLSessionTask *task, id responseObject) = ^void(NSURLSessionTask *task, id responseObject) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        if (![[responseObject objectForKey:@"status"] boolValue]) {
            [Helpers alertFailure:[responseObject objectForKey:@"message"] viewController:self];
            return;
        }
        NSString* email = [[responseObject objectForKey:@"data"] objectForKey:@"email"];
        NSString* token = [[responseObject objectForKey:@"data"] objectForKey:@"token"];
        [Helpers saveLoginInformation:email token:token];
        [self performSegueWithIdentifier:@"Home" sender:nil];
    };
    void (^failure)(NSURLSessionTask *operation, NSError *error) = ^void(NSURLSessionTask *operation, NSError *error) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        [Helpers alertFailure:[error localizedDescription] viewController:self];
    };
    NSString* email = user.profile.email;
    NSString* name = user.profile.name;
    if ([email isEqualToString:@""] || [name isEqualToString:@""]) {
        if ([Helpers isAppInEnglish]) {
            [Helpers alertFailure:[Strings EN_ALERT_FAILED_TO_LOGIN_WITH_SOCIAL_MEDIA] viewController:self];
        } else {
            [Helpers alertFailure:[Strings ID_ALERT_FAILED_TO_LOGIN_WITH_SOCIAL_MEDIA] viewController:self];
        }
        return;
    }
    [activityIndicator startAnimating];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [Connection signInWithSocialMedia:email name:name success:success failure:failure];
}

- (void)signIn:(GIDSignIn *)signIn didDisconnectWithUser:(GIDGoogleUser *)user withError:(NSError *)error {
    
}


@end
