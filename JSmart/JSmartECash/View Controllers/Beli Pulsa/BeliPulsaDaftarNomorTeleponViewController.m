//
//  BeliPulsaDaftarNomorTeleponViewController.m
//  JSmart
//
//  Created by whcl on 30/09/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import "BeliPulsaDaftarNomorTeleponViewController.h"

@interface BeliPulsaDaftarNomorTeleponViewController ()

@end

@implementation BeliPulsaDaftarNomorTeleponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.favorites = [[NSMutableArray alloc] init];
    
    [self getFavorite];
}

#pragma UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.favorites count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BeliPulsaDaftarNomorTeleponTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"BeliPulsaDaftarNomorTeleponTableViewCell"];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"BeliPulsaDaftarNomorTeleponTableViewCell" bundle:nil] forCellReuseIdentifier:@"BeliPulsaDaftarNomorTeleponTableViewCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"BeliPulsaDaftarNomorTeleponTableViewCell"];
    }
    cell.cellNumber = [indexPath row];
    cell.delegate = self;
    NSDictionary* favorite = [self.favorites objectAtIndex:cell.cellNumber];
    NSString* nomorTelepon = [NSString stringWithFormat:@"%@ - %@", [favorite objectForKey:@"nama_kontak"], [favorite objectForKey:@"nomor_favorite"]];
    [cell.containerNomorTelepon setText:nomorTelepon];
    return cell;
}

#

#pragma BeliPulsaDaftarNomorTeleponTableViewCellDelegate

- (void)tapButtonFavorite:(NSInteger)cellNumber {
    NSLog(@"tapButtonFavorite");
}

- (void)selectCell:(NSInteger)cellNumber {
    NSString* nomorTelepon = [[self.favorites objectAtIndex:cellNumber] objectForKey:@"nomor_favorite"];
    [self.delegate selectNomorTeleponFromDaftar:nomorTelepon];
    [self dismissViewControllerAnimated:true completion:nil];
}

#

#pragma Connection

- (void)getFavorite {
    UIActivityIndicatorView* activityIndicator = [Helpers getActivityIndicator:self];
    void (^success)(NSURLSessionTask *task, id responseObject) = ^void(NSURLSessionTask *task, id responseObject) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        if (![[responseObject objectForKey:@"status"] boolValue]) {
            [Helpers alertFailure:[responseObject objectForKey:@"message"] viewController:self];
            return;
        }
        self.favorites = [responseObject objectForKey:@"data"];
        [self.tableView reloadData];
    };
    void (^failure)(NSURLSessionTask *operation, NSError *error) = ^void(NSURLSessionTask *operation, NSError *error) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        [Helpers alertFailure:[error localizedDescription] viewController:self];
    };
    NSString* type = @"pulsa";
    NSString* email_jsmart = @"rhmtsaepuloh@gmail.com";
    NSString* token_jsmart = @"5ebbcd022eb510f595f7402e269d3a46";
    [activityIndicator startAnimating];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [ECashConnection getFavorite:type email_jsmart:email_jsmart token_jsmart:token_jsmart success:success failure:failure];
}

#

@end
