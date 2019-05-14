//
//  NotificationViewController.m
//  JSmart
//
//  Created by whcl on 29/06/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import "NotificationViewController.h"

@interface NotificationViewController ()

@property NSMutableArray* notifications;

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.UNREAD_NOTIFICATION_IS_READ = false;
    [self getNotifications];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.UNREAD_NOTIFICATION_IS_READ) {
        self.UNREAD_NOTIFICATION_IS_READ = false;
        [self getNotifications];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma Delegates

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.notifications count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CellNotificationTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CellNotification"];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"CellNotification" bundle:nil] forCellReuseIdentifier:@"CellNotification"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"CellNotification"];
    }
    id notification = [self.notifications objectAtIndex:[indexPath row]];
    cell.cellNumber = [indexPath row];
    cell.delegate = self;
    [cell.containerSenderPicture sd_setImageWithURL:[notification objectForKey:@"foto_pengirim"]];
    [cell.containerName setText:[notification objectForKey:@"nama_pengirim"]];
    [cell.containerTime setText:[notification objectForKey:@"tanggal"]];
    if ([[notification objectForKey:@"dibaca"] boolValue]) {
        [cell.unreadSign setHidden:YES];
    } else {
        [cell.unreadSign setHidden:NO];
    }
    return cell;
}

- (void)selectCell:(NSInteger)cellNumber {
    self.selectedNotification = [self.notifications objectAtIndex:cellNumber];
    NSInteger idLaporan = [[self.selectedNotification objectForKey:@"id_laporan"] integerValue];
    [self getPost:[[NSNumber alloc] initWithInteger:idLaporan]];
}

#pragma Connection

- (void)getPost:(NSNumber*)idLaporan {
    UIActivityIndicatorView* activityIndicator = [Helpers getActivityIndicator:self];
    void (^success)(NSURLSessionTask *task, id responseObject) = ^void(NSURLSessionTask *task, id responseObject) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        if (![[responseObject objectForKey:@"status"] boolValue]) {
            [Helpers alertFailure:[responseObject objectForKey:@"message"] viewController:self];
            return;
        }
        self.post = [[responseObject objectForKey:@"data"] objectForKey:@"laporan"];
        BOOL read = [[self.selectedNotification objectForKey:@"dibaca"] boolValue];
        if (!read) {
            NSInteger idNotification = [[self.selectedNotification objectForKey:@"id_notifikasi"] integerValue];
            [self markNotificationAsRead:[[NSNumber alloc] initWithInteger:idNotification]];
        } else {
            [self performSegueWithIdentifier:@"Detail" sender:nil];
        }
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
    [Connection getPost:email token:token idLaporan:idLaporan success:success failure:failure];
}

- (void)getNotifications {
    UIActivityIndicatorView* activityIndicator = [Helpers getActivityIndicator:self];
    void (^success)(NSURLSessionTask *task, id responseObject) = ^void(NSURLSessionTask *task, id responseObject) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        if (![[responseObject objectForKey:@"status"] boolValue]) {
            [Helpers alertFailure:[responseObject objectForKey:@"message"] viewController:self];
            return;
        }
        self.notifications = [[responseObject objectForKey:@"data"] objectForKey:@"notifikasi"];
        [self.tableView reloadData];
    };
    void (^failure)(NSURLSessionTask *operation, NSError *error) = ^void(NSURLSessionTask *operation, NSError *error) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        [Helpers alertFailure:[error localizedDescription] viewController:self];
    };
    NSString* email = [[NSUserDefaults standardUserDefaults] stringForKey:@"email"];
    NSString* token = [[NSUserDefaults standardUserDefaults] stringForKey:@"token"];
    NSNumber* page = [[NSNumber alloc] initWithInt:1];
    [activityIndicator startAnimating];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [Connection getNotification:email token:token page:page success:success failure:failure];
}

- (void)markNotificationAsRead:(NSNumber*)idNotification {
    UIActivityIndicatorView* activityIndicator = [Helpers getActivityIndicator:self];
    void (^success)(NSURLSessionTask *task, id responseObject) = ^void(NSURLSessionTask *task, id responseObject) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        if (![[responseObject objectForKey:@"status"] boolValue]) {
            [Helpers alertFailure:[responseObject objectForKey:@"message"] viewController:self];
            return;
        }
        self.UNREAD_NOTIFICATION_IS_READ = true;
        [self performSegueWithIdentifier:@"Detail" sender:nil];
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
    [Connection markNotificationAsRead:email token:token idNotification:idNotification success:success failure:failure];
}

#pragma Delegates

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSString* identifier = [segue identifier];
    if ([identifier isEqualToString:@"Detail"]) {
        LaporanViewController* vc = [segue destinationViewController];
        vc.post = self.post;
    }
}

@end
