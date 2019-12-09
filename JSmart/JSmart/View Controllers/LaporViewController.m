//
//  LaporViewController.m
//  JSmart
//
//  Created by whcl on 29/06/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import "LaporViewController.h"

@interface LaporViewController ()

@property NSInteger HEIGHT_CONTAINER_ATTACHMENT_RESULT;

@end

@implementation LaporViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ATTACHMENT_NONE = 0;
    self.ATTACHMENT_IMAGE = 1;
    self.ATTACHMENT_VIDEO = 2;
    self.ATTACHMENT_TYPE = self.ATTACHMENT_NONE;
    self.locationManager = [[LocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager getCurrentLocation];
    [self addKeyboardButton];
    self.HEIGHT_CONTAINER_ATTACHMENT_RESULT = self.containerAttachmentResult.frame.size.height;
    [self.containerIcon sd_setImageWithURL:[self.category objectForKey:@"icon_kategori"]];
    [self.containerCategory setText:[self.category objectForKey:@"nama_kategori"]];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma Keyboard

- (void)addKeyboardButton {
    CGRect keyboardToolbarFrame = CGRectMake(0, 0, self.view.bounds.size.width, 40);
    UIToolbar* keyboardToolbar = [[UIToolbar alloc] initWithFrame:keyboardToolbarFrame];
    UIBarButtonItem* buttonDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(resignKeyboard)];
    [keyboardToolbar setItems:[[NSArray alloc] initWithObjects:buttonDone, nil]];
    
    self.containerTitle.inputAccessoryView = keyboardToolbar;
    self.containerContent.inputAccessoryView = keyboardToolbar;
}

- (void)resignKeyboard {
    [self.containerTitle resignFirstResponder];
    [self.containerContent resignFirstResponder];
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

#pragma Interaction

- (void)displayAttachmentActionSheet:(UIButton*)button {
    NSString* title = @"Attachment Options";
    NSString* description = @"Please choose between these sources.";
    NSString* option1 = @"Camera";
    NSString* option2 = @"Gallery";
    NSString* option3 = @"Cancel";
    if (![Helpers isAppInEnglish]) {
        title = @"Pilihan lampiran";
        description = @"Mohon pilih salah satu sumber lampiran.";
        option1 = @"Kamera";
        option2 = @"Galeri";
        option3 = @"Batalkan";
    }
    void (^option1Choosen)(UIAlertAction*) = ^void(UIAlertAction* action) {
        if (self.ATTACHMENT_TYPE == self.ATTACHMENT_IMAGE) {
            [self takeImageFromCamera];
        } else {
            [self takeVideoFromCamera];
        }
    };
    void (^option2Choosen)(UIAlertAction*) = ^void(UIAlertAction* action) {
        if (self.ATTACHMENT_TYPE == self.ATTACHMENT_IMAGE) {
            [self takeImageFromGallery];
        } else {
            [self takeVideoFromGallery];
        }
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
                                                      style:UIAlertActionStyleCancel
                                                    handler:nil];
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:action3];
    [alert setModalPresentationStyle:UIModalPresentationPopover];
    UIPopoverPresentationController *popPresenter = [alert popoverPresentationController];
    popPresenter.sourceView = button;
    popPresenter.sourceRect = button.bounds;
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)resizeContainerAttachmentResultAfterAttachmentImageGiven:(UIImage*)image {
    CGFloat imageHeight = image.size.height;
    CGFloat imageWidth = image.size.width;
    NSArray* constraints = [self.containerAttachmentResult constraints];
    CGFloat containerAttachmentResultWidth = self.containerAttachmentResult.frame.size.width;
    CGFloat imageFinalHeight = imageHeight * (containerAttachmentResultWidth / imageWidth);
    for (NSLayoutConstraint* constraint in constraints) {
        if ([constraint firstAttribute] == NSLayoutAttributeHeight) {
            [self.containerAttachmentResult removeConstraint:constraint];
        }
    }
    NSLayoutConstraint* heightConstraint = [NSLayoutConstraint
                                            constraintWithItem:self.containerAttachmentResult
                                            attribute:NSLayoutAttributeHeight
                                            relatedBy:NSLayoutRelationEqual
                                            toItem:nil
                                            attribute:NSLayoutAttributeNotAnAttribute
                                            multiplier:1
                                            constant:round(imageFinalHeight)];
    [self.containerAttachmentResult addConstraint:heightConstraint];
    [self.containerAttachmentResult updateConstraints];
}

- (void)resizeContainerAttachmentResultAfterAttachmentVideoGiven {
    NSArray* constraints = [self.containerAttachmentResult constraints];
    for (NSLayoutConstraint* constraint in constraints) {
        if ([constraint firstAttribute] == NSLayoutAttributeHeight) {
            [self.containerAttachmentResult removeConstraint:constraint];
        }
    }
    NSLayoutConstraint* heightConstraint = [NSLayoutConstraint
                                            constraintWithItem:self.containerAttachmentResult
                                            attribute:NSLayoutAttributeHeight
                                            relatedBy:NSLayoutRelationEqual
                                            toItem:nil
                                            attribute:NSLayoutAttributeNotAnAttribute
                                            multiplier:1
                                            constant:round(300)];
    [self.containerAttachmentResult addConstraint:heightConstraint];
    [self.containerAttachmentResult updateConstraints];
}

- (void)resizeContainerAttachmentResultAfterAttachmentDeleted {
    NSArray* constraints = [self.containerAttachmentResult constraints];
    for (NSLayoutConstraint* constraint in constraints) {
        if ([constraint firstAttribute] == NSLayoutAttributeHeight) {
            [self.containerAttachmentResult removeConstraint:constraint];
        }
    }
    NSLayoutConstraint* heightConstraint = [NSLayoutConstraint
                                            constraintWithItem:self.containerAttachmentResult
                                            attribute:NSLayoutAttributeHeight
                                            relatedBy:NSLayoutRelationEqual
                                            toItem:nil
                                            attribute:NSLayoutAttributeNotAnAttribute
                                            multiplier:1
                                            constant:self.HEIGHT_CONTAINER_ATTACHMENT_RESULT];
    [self.containerAttachmentResult addConstraint:heightConstraint];
    [self.containerAttachmentResult layoutIfNeeded];
}

- (void)resizeContentViewAfterAttachmentImageGiven:(UIImage*)image {
    CGFloat imageHeight = image.size.height;
    CGFloat imageWidth = image.size.width;
    CGFloat containerAttachmentResultWidth = self.containerAttachmentResult.frame.size.width;
    CGFloat attachmentResultHeight = imageHeight * (containerAttachmentResultWidth / imageWidth);
    CGFloat attachmentResultY = self.containerAttachmentResult.frame.origin.y;
    CGFloat contentViewHeight = self.contentView.frame.size.height;
    CGFloat newContentViewHeight = attachmentResultY + attachmentResultHeight + 40;
    if (contentViewHeight <= newContentViewHeight) {
        contentViewHeight = newContentViewHeight;
    }
    NSArray* constraints = [self.contentView constraints];
    for (NSLayoutConstraint* constraint in constraints) {
        if ([constraint firstAttribute] == NSLayoutAttributeHeight) {
            [self.contentView removeConstraint:constraint];
        }
    }
    NSLayoutConstraint* heightConstraint = [NSLayoutConstraint
                                            constraintWithItem:self.contentView
                                            attribute:NSLayoutAttributeHeight
                                            relatedBy:NSLayoutRelationEqual
                                            toItem:nil
                                            attribute:NSLayoutAttributeNotAnAttribute
                                            multiplier:1
                                            constant:contentViewHeight];
    [self.contentView addConstraint:heightConstraint];
    [self.contentView updateConstraints];
}

- (void)resizeContentViewAfterAttachmentVideoGiven {
    CGFloat attachmentResultHeight = 300;
    CGFloat attachmentResultY = self.containerAttachmentResult.frame.origin.y;
    CGFloat contentViewHeight = self.contentView.frame.size.height;
    CGFloat newContentViewHeight = attachmentResultY + attachmentResultHeight + 40;
    if (contentViewHeight <= newContentViewHeight) {
        contentViewHeight = newContentViewHeight;
    }
    NSArray* constraints = [self.contentView constraints];
    for (NSLayoutConstraint* constraint in constraints) {
        if ([constraint firstAttribute] == NSLayoutAttributeHeight) {
            [self.contentView removeConstraint:constraint];
        }
    }
    NSLayoutConstraint* heightConstraint = [NSLayoutConstraint
                                            constraintWithItem:self.contentView
                                            attribute:NSLayoutAttributeHeight
                                            relatedBy:NSLayoutRelationEqual
                                            toItem:nil
                                            attribute:NSLayoutAttributeNotAnAttribute
                                            multiplier:1
                                            constant:contentViewHeight];
    [self.contentView addConstraint:heightConstraint];
    [self.contentView updateConstraints];
}

- (void)resizeContentViewAfterAttachmentDeleted {
    NSArray* constraints = [self.contentView constraints];
    for (NSLayoutConstraint* constraint in constraints) {
        if ([constraint firstAttribute] == NSLayoutAttributeHeight) {
            [self.contentView removeConstraint:constraint];
        }
    }
    NSLayoutConstraint* heightConstraint = [NSLayoutConstraint
                                            constraintWithItem:self.contentView
                                            attribute:NSLayoutAttributeHeight
                                            relatedBy:NSLayoutRelationEqual
                                            toItem:nil
                                            attribute:NSLayoutAttributeNotAnAttribute
                                            multiplier:1
                                            constant:self.scrollView.frame.size.height];
    [self.contentView addConstraint:heightConstraint];
    [self.contentView layoutIfNeeded];
}

#pragma IBAction

- (IBAction)addImage:(UIButton *)sender {
    self.ATTACHMENT_TYPE = self.ATTACHMENT_IMAGE;
    [self displayAttachmentActionSheet:sender];
}

- (IBAction)addVideo:(UIButton *)sender {
    self.ATTACHMENT_TYPE = self.ATTACHMENT_VIDEO;
    [self displayAttachmentActionSheet:sender];
}

- (IBAction)clearAttachment:(UIButton *)sender {
    [self.buttonClearAttachment setHidden:YES];
    [self.containerAttachmentResult setHidden:YES];
    [self.containerAttachmentButtons setHidden:NO];
    self.ATTACHMENT_TYPE = self.ATTACHMENT_NONE;
    [self resizeContainerAttachmentResultAfterAttachmentDeleted];
    [self resizeContentViewAfterAttachmentDeleted];
}

- (IBAction)back:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)lapor:(UIButton *)sender {
    if (![self validateFormCompleteness]) {
        if ([Helpers isAppInEnglish]) {
            [Helpers alertFailure:[Strings EN_ALERT_INCOMPLETE_FIELDS] viewController:self];
        } else {
            [Helpers alertFailure:[Strings ID_ALERT_INCOMPLETE_FIELDS] viewController:self];
        }
        return;
    }
    if (![self validateLocationCompleteness]) {
        if ([Helpers isAppInEnglish]) {
            [Helpers alertFailure:[Strings EN_ALERT_LOCATION_CANNOT_BE_DETERMINED] viewController:self];
        } else {
             [Helpers alertFailure:[Strings ID_ALERT_LOCATION_CANNOT_BE_DETERMINED] viewController:self];
        }
        return;
    }
    if (self.ATTACHMENT_TYPE == self.ATTACHMENT_NONE) {
        [self laporWithAttachmentNone];
    }
    else if (self.ATTACHMENT_TYPE == self.ATTACHMENT_IMAGE) {
        [self laporWithAttachmentImage:self.attachedImage];
    }
    else if (self.ATTACHMENT_TYPE == self.ATTACHMENT_VIDEO) {
        if ([Helpers getDurationOfVideoInSeconds:self.attachedVideo] > 5) {
            if ([Helpers isAppInEnglish]) {
                [Helpers alertFailure:@"The duration of video must not exceed 5 seconds." viewController:self];
            } else {
                [Helpers alertFailure:@"Durasi video harus tidak melebihi 5 detik." viewController:self];
            }
            return;
        }
        [self laporWithAttachmentVideo:self.attachedVideo];
    }
}

#pragma Choosing Attachment

- (void)takeImageFromCamera {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.editing = false;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.mediaTypes = @[@"public.image"];
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)takeImageFromGallery {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.editing = false;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.mediaTypes = @[@"public.image"];
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)takeVideoFromCamera {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.editing = false;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.mediaTypes = @[@"public.movie"];
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)takeVideoFromGallery {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.editing = false;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.mediaTypes = @[@"public.movie"];
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma Delegates

- (void)locationReceived:(CLLocation *)location {
    self.latitude = location.coordinate.latitude;
    self.longitude = location.coordinate.longitude;
}

- (void)placemarkReceived:(CLPlacemark *)placemark {
    self.address = placemark.thoroughfare;
    self.kelurahan = placemark.thoroughfare;
    self.kecamatan = placemark.locality;
    self.kota = placemark.administrativeArea;
    
    self.addressContent.text = [NSString stringWithFormat: @"%@, %@, %@, %@", self.address, self.kota, self.kelurahan, self.kecamatan];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    if (self.ATTACHMENT_TYPE == self.ATTACHMENT_IMAGE) {
        UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
        self.attachedImage = [Helpers reduceImageSizeByPercentage:0.2 image:chosenImage];
        [self resizeContainerAttachmentResultAfterAttachmentImageGiven:self.attachedImage];
        [self resizeContentViewAfterAttachmentImageGiven:self.attachedImage];
        [self.containerAttachedImage setImage:self.attachedImage];
        [self.containerAttachedImage setHidden:false];
        [self.containerAttachedVideo setHidden:true];
    }
    else if (self.ATTACHMENT_TYPE == self.ATTACHMENT_VIDEO) {
        self.attachedVideo = (NSURL*)[info objectForKey:UIImagePickerControllerMediaURL];
        [self resizeContainerAttachmentResultAfterAttachmentVideoGiven];
        [self resizeContentViewAfterAttachmentVideoGiven];
        AVPlayerViewController* avPlayerViewController = [[AVPlayerViewController alloc] init];
        AVPlayer* avPlayer = [[AVPlayer alloc] initWithURL:self.attachedVideo];
        avPlayerViewController.player = avPlayer;
        [self addChildViewController:avPlayerViewController];
        avPlayerViewController.view.frame = self.containerAttachedVideo.frame;
        [self.containerAttachedVideo addSubview:avPlayerViewController.view];
        [avPlayerViewController didMoveToParentViewController:self];
        [self.containerAttachedImage setHidden:true];
        [self.containerAttachedVideo setHidden:false];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self.buttonClearAttachment setHidden:NO];
    [self.containerAttachmentResult setHidden:NO];
    [self.containerAttachmentButtons setHidden:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    self.ATTACHMENT_TYPE = self.ATTACHMENT_NONE;
    [picker dismissViewControllerAnimated:true completion:nil];
}

#pragma Validation

- (BOOL)validateFormCompleteness {
    return (![[self.containerTitle text] isEqualToString:@""] && ![[self.containerContent text] isEqualToString:@""]);
}

- (BOOL)validateLocationCompleteness {
    return ([self.kota length] > 0 && [self.kecamatan length] > 0);
}

#pragma Connection

- (void)laporWithAttachmentNone {
    UIActivityIndicatorView* activityIndicator = [Helpers getActivityIndicator:self];
    void (^returnToHome)(UIAlertAction*) = ^void(UIAlertAction* alert) {
        [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    };
    void (^success)(NSURLSessionTask *task, id responseObject) = ^void(NSURLSessionTask *task, id responseObject) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        if (![[responseObject objectForKey:@"status"] boolValue]) {
            [Helpers alertFailure:[responseObject objectForKey:@"message"] viewController:self];
            return;
        }
        if ([Helpers isAppInEnglish]) {
            [Helpers alertSuccessWithCompletion:[Strings EN_ALERT_REPORT_SUBMITTED] viewController:self completion:returnToHome];
        } else {
            [Helpers alertSuccessWithCompletion:[Strings ID_ALERT_REPORT_SUBMITTED] viewController:self completion:returnToHome];
        }
    };
    void (^failure)(NSURLSessionTask *operation, NSError *error) = ^void(NSURLSessionTask *operation, NSError *error) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        [Helpers alertFailure:[error localizedDescription] viewController:self];
    };
    NSString* email = [[NSUserDefaults standardUserDefaults] stringForKey:@"email"];
    NSString* token = [[NSUserDefaults standardUserDefaults] stringForKey:@"token"];
    NSNumber* idCategory = [[NSNumber alloc] initWithInt:[[self.category objectForKey:@"id_kategori"] intValue]];
    NSString* title = [self.containerTitle text];
    NSString* content = [self.containerContent text];
//    NSNumber* latitude = [[NSNumber alloc] initWithFloat:-6.296733];
//    NSNumber* longitude = [[NSNumber alloc] initWithFloat:107.168445];
    NSNumber* latitude = [[NSNumber alloc] initWithFloat:self.latitude];
    NSNumber* longitude = [[NSNumber alloc] initWithFloat:self.longitude];
    NSString* address = self.address;
    NSString* kelurahan = self.kelurahan;
    NSString* kecamatan = self.kecamatan;
    NSString* kota = self.kota;
    [activityIndicator startAnimating];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [Connection submitLaporanWithAttachmentNone:email token:token idCategory:idCategory title:title content:content latitude:latitude longitude:longitude address:address kelurahan:kelurahan kecamatan:kecamatan kota:kota success:success failure:failure];
}

- (void)laporWithAttachmentImage:(UIImage*)image {
    UIActivityIndicatorView* activityIndicator = [Helpers getActivityIndicator:self];
    void (^returnToHome)(UIAlertAction*) = ^void(UIAlertAction* alert) {
        [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
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
        if ([Helpers isAppInEnglish]) {
            [Helpers alertSuccessWithCompletion:[Strings EN_ALERT_REPORT_SUBMITTED] viewController:self completion:returnToHome];
        } else {
            [Helpers alertSuccessWithCompletion:[Strings ID_ALERT_REPORT_SUBMITTED] viewController:self completion:returnToHome];
        }
    };
    NSString* email = [[NSUserDefaults standardUserDefaults] stringForKey:@"email"];
    NSString* token = [[NSUserDefaults standardUserDefaults] stringForKey:@"token"];
    NSNumber* idCategory = [[NSNumber alloc] initWithInt:[[self.category objectForKey:@"id_kategori"] intValue]];
    NSString* title = [self.containerTitle text];
    NSString* content = [self.containerContent text];
//    NSNumber* latitude = [[NSNumber alloc] initWithFloat:-6.296733];
//    NSNumber* longitude = [[NSNumber alloc] initWithFloat:107.168445];
    NSNumber* latitude = [[NSNumber alloc] initWithFloat:self.latitude];
    NSNumber* longitude = [[NSNumber alloc] initWithFloat:self.longitude];
    NSString* address = self.address;
    NSString* kelurahan = self.kelurahan;
    NSString* kecamatan = self.kecamatan;
    NSString* kota = self.kota;
    [activityIndicator startAnimating];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [Connection submitLaporanWithAttachmentImage:email token:token idCategory:idCategory title:title content:content latitude:latitude longitude:longitude address:address kelurahan:kelurahan kecamatan:kecamatan kota:kota image:image handler:handler];
}

- (void)laporWithAttachmentVideo:(NSURL*)urlVideo {
    UIActivityIndicatorView* activityIndicator = [Helpers getActivityIndicator:self];
    void (^returnToHome)(UIAlertAction*) = ^void(UIAlertAction* alert) {
        [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
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
        if ([Helpers isAppInEnglish]) {
            [Helpers alertSuccessWithCompletion:[Strings EN_ALERT_REPORT_SUBMITTED] viewController:self completion:returnToHome];
        } else {
            [Helpers alertSuccessWithCompletion:[Strings ID_ALERT_REPORT_SUBMITTED] viewController:self completion:returnToHome];
        }
    };
    NSString* email = [[NSUserDefaults standardUserDefaults] stringForKey:@"email"];
    NSString* token = [[NSUserDefaults standardUserDefaults] stringForKey:@"token"];
    NSNumber* idCategory = [[NSNumber alloc] initWithInt:[[self.category objectForKey:@"id_kategori"] intValue]];
    NSString* title = [self.containerTitle text];
    NSString* content = [self.containerContent text];
//    NSNumber* latitude = [[NSNumber alloc] initWithFloat:-6.296733];
//    NSNumber* longitude = [[NSNumber alloc] initWithFloat:107.168445];
    NSNumber* latitude = [[NSNumber alloc] initWithFloat:self.latitude];
    NSNumber* longitude = [[NSNumber alloc] initWithFloat:self.longitude];
    NSString* address = self.address;
    NSString* kelurahan = self.kelurahan;
    NSString* kecamatan = self.kecamatan;
    NSString* kota = self.kota;
    [activityIndicator startAnimating];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [Connection submitLaporanWithAttachmentVideo:email token:token idCategory:idCategory title:title content:content latitude:latitude longitude:longitude address:address kelurahan:kelurahan kecamatan:kecamatan kota:kota urlVideo:urlVideo handler:handler];
}

@end
