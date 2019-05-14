//
//  CommentViewController.m
//  JSmart
//
//  Created by whcl on 04/07/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import "CommentViewController.h"

@interface CommentViewController ()

@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.IS_COMMENT_WITH_ATTACHMENT = false;
    [self getComments];
    [self addKeyboardButton];
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
    [self.containerComment setInputAccessoryView:keyboardToolbar];
}

- (void)resignKeyboard {
    [self.containerComment resignFirstResponder];
}

- (void)clearForm {
    [self.containerComment setText:@""];
}

- (void)keyboardAppear:(NSNotification*)notification {
    NSDictionary* info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    [self.tableView setScrollEnabled:false];
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

- (void)keyboardDisappear:(NSNotification*)notification {
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    [self.tableView setScrollEnabled:true];
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

#pragma Validation

- (BOOL)validateCommentCompleteness {
    return (![[self.containerComment text] isEqualToString:@""]);
}

#pragma Delegates

- (void)selectCell:(UIImage *)image {
    BFRImageViewController *imageVC = [[BFRImageViewController alloc] initWithImageSource:@[image]];
    [self presentViewController:imageVC animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath row] % 2 == 0) {
        return UITableViewAutomaticDimension;
    }
    id comment = [self.comments objectAtIndex:[indexPath row] / 2];
    id image = [[comment objectForKey:@"foto_komentar"] isKindOfClass:[NSNull class]] ? @"" : [comment objectForKey:@"foto_komentar"];
    if ([image isEqualToString:@""]) {
        return 0;
    }
    return 200;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.comments count] * 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = [indexPath row] / 2;
    id comment = [self.comments objectAtIndex:row];
    if ([indexPath row] % 2 == 0) {
        CellCommentTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CellComment"];
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:@"CellComment" bundle:nil] forCellReuseIdentifier:@"CellComment"];
            cell = [tableView dequeueReusableCellWithIdentifier:@"CellComment"];
        }
        [cell.containerUserName setText:[comment objectForKey:@"komentator"]];
        [cell.containerUserPicture sd_setImageWithURL:[comment objectForKey:@"foto_komentator"] placeholderImage:[UIImage imageNamed:@"ico_person_rounded_grey"]];
        [cell.containerUserComment setText:[comment objectForKey:@"isi_komentar"]];
        return cell;
    }
    CellCommentAttachmentTableViewCell* cellAttachment = [tableView dequeueReusableCellWithIdentifier:@"CellCommentAttachment"];
    if (!cellAttachment) {
        [tableView registerNib:[UINib nibWithNibName:@"CellCommentAttachment" bundle:nil] forCellReuseIdentifier:@"CellCommentAttachment"];
        cellAttachment = [tableView dequeueReusableCellWithIdentifier:@"CellCommentAttachment"];
    }
    cellAttachment.delegate = self;
    id image = [[comment objectForKey:@"foto_komentar"] isKindOfClass:[NSNull class]] ? @"" : [comment objectForKey:@"foto_komentar"];
    if ([image isEqualToString:@""]) {
        [cellAttachment.containerImage setHidden:true];
    } else {
        [cellAttachment.containerImage setHidden:false];
        [cellAttachment.containerImage sd_setImageWithURL:image];
    }
    return cellAttachment;
}

#pragma Connection

- (void)getComments {
    UIActivityIndicatorView* activityIndicator = [Helpers getActivityIndicator:self];
    void (^success)(NSURLSessionTask *task, id responseObject) = ^void(NSURLSessionTask *task, id responseObject) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        if (![[responseObject objectForKey:@"status"] boolValue]) {
            [Helpers alertFailure:[responseObject objectForKey:@"message"] viewController:self];
            return;
        }
        self.comments = [[NSMutableArray alloc] initWithArray:[[responseObject objectForKey:@"data"] objectForKey:@"komentar"]];
        if ([self.comments count] > 0) {
            [self.containerNoComment setHidden:true];
        } else {
            [self.containerNoComment setHidden:false];
        }
        [self.tableView reloadData];
    };
    void (^failure)(NSURLSessionTask *operation, NSError *error) = ^void(NSURLSessionTask *operation, NSError *error) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        [Helpers alertFailure:[error localizedDescription] viewController:self];
    };
    NSString* email = [[NSUserDefaults standardUserDefaults] stringForKey:@"email"];
    NSString* token = [[NSUserDefaults standardUserDefaults] stringForKey:@"token"];
    NSNumber* idLaporan = [[NSNumber alloc] initWithInteger:self.idLaporan];
    NSLog(@"%@", email);
    NSLog(@"%@", token);
    NSLog(@"%@", idLaporan);
    [activityIndicator startAnimating];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [Connection getComment:email token:token idLaporan:idLaporan success:success failure:failure];
}

- (void)sendComment {
    [self resignKeyboard];
    if (![self validateCommentCompleteness]) {
        if ([Helpers isAppInEnglish]) {
            [Helpers alertFailure:@"Please complete your comment." viewController:self];
        } else {
            [Helpers alertFailure:@"Mohon lengkapi komentar Anda." viewController:self];
        }
        return;
    }
    UIActivityIndicatorView* activityIndicator = [Helpers getActivityIndicator:self];
    void (^success)(NSURLSessionTask *task, id responseObject) = ^void(NSURLSessionTask *task, id responseObject) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        if (![[responseObject objectForKey:@"status"] boolValue]) {
            [Helpers alertFailure:[responseObject objectForKey:@"message"] viewController:self];
            return;
        }
        [self clearForm];
        [self getComments];
    };
    void (^failure)(NSURLSessionTask *operation, NSError *error) = ^void(NSURLSessionTask *operation, NSError *error) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        [Helpers alertFailure:[error localizedDescription] viewController:self];
    };
    NSString* email = [[NSUserDefaults standardUserDefaults] stringForKey:@"email"];
    NSString* token = [[NSUserDefaults standardUserDefaults] stringForKey:@"token"];
    NSString* comment = [self.containerComment text];
    NSNumber* idLaporan = [[NSNumber alloc] initWithInteger:self.idLaporan];
    [activityIndicator startAnimating];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [Connection submitCommentWithAttachmentNone:email token:token idLaporan:idLaporan comment:comment success:success failure:failure];
}

- (void)sendCommentWithAttachment:(UIImage*)image {
    UIActivityIndicatorView* activityIndicator = [Helpers getActivityIndicator:self];
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
        [self clearForm];
        self.IS_COMMENT_WITH_ATTACHMENT = false;
        self.containerAttachment.hidden = true;
        self.containerIconAttachment.hidden = false;
        self.containerIconDeleteAttachment.hidden = true;
        [self getComments];
    };
    NSString* email = [[NSUserDefaults standardUserDefaults] stringForKey:@"email"];
    NSString* token = [[NSUserDefaults standardUserDefaults] stringForKey:@"token"];
    NSString* comment = [self.containerComment text];
    NSNumber* idLaporan = [[NSNumber alloc] initWithInteger:self.idLaporan];
    [activityIndicator startAnimating];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [Connection submitCommentWithAttachmentImage:email token:token idLaporan:idLaporan comment:comment image:image handler:handler];
}

#pragma

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
        [self takeImageFromCamera];
    };
    void (^option2Choosen)(UIAlertAction*) = ^void(UIAlertAction* action) {
        [self takeImageFromGallery];
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

#pragma Taking Images

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

#pragma Delegates

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    self.attachedImage = [Helpers reduceImageSizeByPercentage:0.2 image:chosenImage];
    self.containerAttachment.hidden = false;
    [self.containerAttachedImage setImage:self.attachedImage];
    self.containerIconDeleteAttachment.hidden = false;
    self.containerIconAttachment.hidden = true;
    self.IS_COMMENT_WITH_ATTACHMENT = true;
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma IBActions

- (IBAction)comment:(UIButton *)sender {
    [self resignKeyboard];
    if (self.IS_COMMENT_WITH_ATTACHMENT) {
        [self sendCommentWithAttachment:self.attachedImage];
    } else {
        [self sendComment];
    }
}

- (IBAction)back:(UIButton *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)commentWithAttachment:(UIButton *)sender {
    [self resignKeyboard];
    [self displayAttachmentActionSheet:sender];
}

- (IBAction)deleteAttachment:(UIButton *)sender {
    [self resignKeyboard];
    self.IS_COMMENT_WITH_ATTACHMENT = false;
    self.containerIconAttachment.hidden = false;
    self.containerIconDeleteAttachment.hidden = true;
    self.containerAttachment.hidden = true;
}

@end
