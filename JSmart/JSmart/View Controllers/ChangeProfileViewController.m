//
//  ChangeProfileViewController.m
//  JSmart
//
//  Created by whcl on 01/07/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import "ChangeProfileViewController.h"

@interface ChangeProfileViewController ()

@end

@implementation ChangeProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addKeyboardButton];
    self.IS_IMAGE_CHANGED = false;
    self.IS_USER_INFO_CHANGED = false;
    [self.containerUserPicture sd_setImageWithURL:[self.user objectForKey:@"foto"] placeholderImage:[UIImage imageNamed:@"ico_person_rounded_grey"]];
    [self.containerName setText:[self.user objectForKey:@"nama"]];
    [self.containerEmail setText:[self.user objectForKey:@"email"]];
    [self.containerPhone setText:[self.user objectForKey:@"telp"]];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardAppear:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDisappear:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma Keyboard

- (void)addKeyboardButton {
    CGRect keyboardToolbarFrame = CGRectMake(0, 0, self.view.bounds.size.width, 40);
    UIToolbar* keyboardToolbar = [[UIToolbar alloc] initWithFrame:keyboardToolbarFrame];
    UIBarButtonItem* buttonDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(resignKeyboard)];
    [keyboardToolbar setItems:[[NSArray alloc] initWithObjects:buttonDone, nil]];
    
    self.containerName.inputAccessoryView = keyboardToolbar;
    self.containerEmail.inputAccessoryView = keyboardToolbar;
    self.containerPhone.inputAccessoryView = keyboardToolbar;
    self.containerOldPassword.inputAccessoryView = keyboardToolbar;
    self.containerNewPassword.inputAccessoryView = keyboardToolbar;
    self.containerConfirmationNewPassword.inputAccessoryView = keyboardToolbar;
}

- (void)resignKeyboard {
    [self.containerName resignFirstResponder];
    [self.containerEmail resignFirstResponder];
    [self.containerPhone resignFirstResponder];
    [self.containerOldPassword resignFirstResponder];
    [self.containerNewPassword resignFirstResponder];
    [self.containerConfirmationNewPassword resignFirstResponder];
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

- (IBAction)back:(UIButton *)sender {
    [self resignKeyboard];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(UIButton *)sender {
    [self resignKeyboard];
    if (![self validateFormCompleteness]) {
        if ([Helpers isAppInEnglish]) {
            [Helpers alertFailure:@"Name, email, and phone cannot be blank." viewController:self];
        } else {
            [Helpers alertFailure:@"Nama, email, dan telepon tidak boleh kosong." viewController:self];
        }
        return;
    }
    if (![self validateFormChangePassword]) {
        if ([Helpers isAppInEnglish]) {
            [Helpers alertFailure:@"If you want to change password, all password field cannot be blank." viewController:self];
        } else {
            [Helpers alertFailure:@"Jika Anda ingin mengganti katasandi, seluruh kolom katasandi tidak boleh kosong." viewController:self];
        }
        return;
    }
    if (![self validateFormPasswordMatch]) {
        if ([Helpers isAppInEnglish]) {
            [Helpers alertFailure:@"Your new password do not match the confirmation password." viewController:self];
        } else {
            [Helpers alertFailure:@"Katasandi baru dan katasandi konfirmasinya tidak cocok." viewController:self];
        }
        return;
    }
    [self checkIfUserInfoChanged];
    if (self.IS_IMAGE_CHANGED) {
        [self uploadImage:self.USER_PICTURE];
    } else if (self.IS_USER_INFO_CHANGED){
        [self saveProfile];
    } else {
        if ([Helpers isAppInEnglish]) {
            [Helpers alertFailure:@"There is no change to be saved." viewController:self];
        } else {
            [Helpers alertFailure:@"Tidak ada perubahan yang perlu disimpan." viewController:self];
        }
    }
}

- (IBAction)changeUserPicture:(UIButton *)sender {
    [self resignKeyboard];
    [self displayPictureActionSheet:sender];
}

#pragma Validation

- (void)checkIfUserInfoChanged {
    NSString* oldPassword = [self.containerOldPassword text];
    NSString* newPassword = [self.containerNewPassword text];
    NSString* confirmationNewPassword = [self.containerConfirmationNewPassword text];
    if (![oldPassword isEqualToString:@""] && ![newPassword isEqualToString:@""] && ![confirmationNewPassword isEqualToString:@""]) {
        self.IS_USER_INFO_CHANGED = true;
        return;
    }
    NSString* name = [self.containerName text];
    NSString* phone = [self.containerPhone text];
    self.IS_USER_INFO_CHANGED = (![name isEqualToString:[self.user objectForKey:@"nama"]] || ![phone isEqualToString:[self.user objectForKey:@"telp"]]);
}

- (BOOL)validateFormCompleteness {
    if ([[self.containerName text] isEqualToString:@""]) {
        return false;
    }
    if ([[self.containerEmail text] isEqualToString:@""]) {
        return false;
    }
    if ([[self.containerPhone text] isEqualToString:@""]) {
        return false;
    }
    return true;
}

- (BOOL)validateFormChangePassword {
    NSString* oldPassword = [self.containerOldPassword text];
    NSString* newPassword = [self.containerNewPassword text];
    NSString* confirmationNewPassword = [self.containerConfirmationNewPassword text];
    if (![oldPassword isEqualToString:@""]) {
        return(![newPassword isEqualToString:@""] && ![confirmationNewPassword isEqualToString:@""]);
    }
    if (![newPassword isEqualToString:@""]) {
        return(![oldPassword isEqualToString:@""] && ![confirmationNewPassword isEqualToString:@""]);
    }
    if (![confirmationNewPassword isEqualToString:@""]) {
        return(![newPassword isEqualToString:@""] && ![oldPassword isEqualToString:@""]);
    }
    return true;
}

- (BOOL)validateFormPasswordMatch {
    return ([[self.containerNewPassword text] isEqualToString:[self.containerConfirmationNewPassword text]]);
}

#pragma Choosing Picture

- (void)takeImageFromCamera {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)takeImageFromGallery {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)takeAvatars {
    [self performSegueWithIdentifier:@"ChangeAvatar" sender:nil];
}

#pragma Delegates

- (void)selectAvatar:(UIImage *)image {
    self.USER_PICTURE = image;
    self.IS_IMAGE_CHANGED = true;
    [self.containerUserPicture setImage:self.USER_PICTURE];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage* chosenImage = info[UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    self.USER_PICTURE = [Helpers reduceImageSizeByPercentage:0.05 image:chosenImage];
    self.IS_IMAGE_CHANGED = true;
    [self.containerUserPicture setImage:self.USER_PICTURE];
}

#pragma Interaction

- (void)displayPictureActionSheet:(UIButton*)button {
    NSString* title = @"Change Picture";
    NSString* description = @"Please choose between these sources.";
    NSString* option1 = @"Camera";
    NSString* option2 = @"Gallery";
    NSString* option3 = @"Avatar";
    NSString* option4 = @"Cancel";
    if (![Helpers isAppInEnglish]) {
        title = @"Ganti gambar";
        description = @"Mohon pilih sumber gambar.";
        option1 = @"Kamera";
        option2 = @"Galeri";
        option3 = @"Avatar";
        option4 = @"Batalkan";
    }
    void (^option1Choosen)(UIAlertAction*) = ^void(UIAlertAction* action) {
        [self takeImageFromCamera];
    };
    void (^option2Choosen)(UIAlertAction*) = ^void(UIAlertAction* action) {
        [self takeImageFromGallery];
    };
    void (^option3Choosen)(UIAlertAction*) = ^void(UIAlertAction* action) {
        [self takeAvatars];
    };
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:description
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:option1
                                                      style:UIAlertActionStyleDefault
                                                    handler:option1Choosen];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:option2
                                                      style:UIAlertActionStyleDefault
                                                    handler:option2Choosen];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:option3
                                                      style:UIAlertActionStyleDefault
                                                    handler:option3Choosen];
    UIAlertAction *action4 = [UIAlertAction actionWithTitle:option4
                                                      style:UIAlertActionStyleCancel
                                                    handler:nil];
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:action3];
    [alert addAction:action4];
    [alert setModalPresentationStyle:UIModalPresentationPopover];
    UIPopoverPresentationController *popPresenter = [alert popoverPresentationController];
    popPresenter.sourceView = button;
    popPresenter.sourceRect = button.bounds;
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma Connection

- (void)uploadImage:(UIImage*)image {
    UIActivityIndicatorView* activityIndicator = [Helpers getActivityIndicator:self];
    void (^returnToProfile)(UIAlertAction*) = ^void(UIAlertAction* alert) {
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    void (^handler)(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) = ^void(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        NSString *responseString=[NSString stringWithUTF8String:[responseObject bytes]];
        NSError *e;
        NSDictionary *parsedResponse = [NSJSONSerialization JSONObjectWithData: [responseString dataUsingEncoding:NSUTF8StringEncoding] options: NSJSONReadingMutableContainers error: &e];
        if (![[parsedResponse objectForKey:@"status"] boolValue]) {
            [Helpers alertFailure:[parsedResponse objectForKey:@"message"] viewController:self];
            return;
        }
        if (self.IS_USER_INFO_CHANGED) {
            [self saveProfile];
        } else {
            ((ProfileViewController*)self.profileViewController).IS_PROFILE_UPDATED = true;
            if ([Helpers isAppInEnglish]) {
                [Helpers alertSuccessWithCompletion:@"Profile successfully updated." viewController:self completion:returnToProfile];
            } else {
                [Helpers alertSuccessWithCompletion:@"Profile berhasil disimpan." viewController:self completion:returnToProfile];
            }
        }
    };
    NSString* email = [[NSUserDefaults standardUserDefaults] stringForKey:@"email"];
    NSString* token = [[NSUserDefaults standardUserDefaults] stringForKey:@"token"];
    [activityIndicator startAnimating];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [Connection uploadPicture:email token:token image:image handler:handler];
}

- (void)saveProfile {
    UIActivityIndicatorView* activityIndicator = [Helpers getActivityIndicator:self];
    void (^returnToSignIn)(UIAlertAction*) = ^void(UIAlertAction* alert) {
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    void (^success)(NSURLSessionTask *task, id responseObject) = ^void(NSURLSessionTask *task, id responseObject) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        if (![[responseObject objectForKey:@"status"] boolValue]) {
            [Helpers alertFailure:[responseObject objectForKey:@"message"] viewController:self];
            return;
        }
        ((ProfileViewController*)self.profileViewController).IS_PROFILE_UPDATED = true;
        if ([Helpers isAppInEnglish]) {
            [Helpers alertSuccessWithCompletion:@"Profile successfully updated." viewController:self completion:returnToSignIn];
        } else {
            [Helpers alertSuccessWithCompletion:@"Profile berhasil disimpan." viewController:self completion:returnToSignIn];
        }
    };
    void (^failure)(NSURLSessionTask *operation, NSError *error) = ^void(NSURLSessionTask *operation, NSError *error) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        [Helpers alertFailure:[error localizedDescription] viewController:self];
    };
    NSString* email = [[NSUserDefaults standardUserDefaults] stringForKey:@"email"];
    NSString* token = [[NSUserDefaults standardUserDefaults] stringForKey:@"token"];
    NSString* name = [self.containerName text];
    NSString* phone = [self.containerPhone text];
    NSString* oldPassword = [self.containerOldPassword text];
    NSString* newPassword = [self.containerNewPassword text];
    NSString* confirmationNewPassword = [self.containerConfirmationNewPassword text];
    [activityIndicator startAnimating];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [Connection saveProfile:email token:token name:name phone:phone oldPassword:oldPassword newPassword:newPassword newConfirmationPassword:confirmationNewPassword success:success failure:failure];
}

#pragma Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSString* identifier = [segue identifier];
    if ([identifier isEqualToString:@"ChangeAvatar"]) {
        ChangeAvatarViewController* vc = [segue destinationViewController];
        vc.delegate = self;
    }
}

@end
