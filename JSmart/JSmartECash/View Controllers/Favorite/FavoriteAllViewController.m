//
//  FavoriteAllViewController.m
//  JSmart
//
//  Created by whcl on 11/09/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import "FavoriteAllViewController.h"

@interface FavoriteAllViewController ()

@end

@implementation FavoriteAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getFavorite];
}

#pragma TableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.favorites count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FavoriteTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"FavoriteTableViewCell"];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"FavoriteTableViewCell" bundle:nil] forCellReuseIdentifier:@"FavoriteTableViewCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"FavoriteTableViewCell"];
    }
    NSInteger index = [indexPath row];
    NSString* date = [[self.favorites objectAtIndex:index] objectForKey:@"created_favorite"];
    NSString* name = [[self.favorites objectAtIndex:index] objectForKey:@"nama_kontak"];
    NSString* number = [[self.favorites objectAtIndex:index] objectForKey:@"nomor_favorite"];
    NSString* title = [NSString stringWithFormat:@"%@ - %@", name, number];
    NSString* type = [ [self.favorites objectAtIndex:index] objectForKey:@"type_favorite"];
    NSString* parsedType = [self parseFavoriteType:type];
    cell.cellNumber = index;
    cell.delegate = self;
    [cell.containerDate setText:date];
    [cell.containerTitle setText:title];
    [cell.containerType setText:parsedType];
    return cell;
}

#

#pragma FavoriteTableViewCell Delegate

- (void)selectCell:(NSInteger)cellNumber {
    
}

#

#pragma Helpers

- (NSString*)parseFavoriteType:(NSString*)type {
    if ([type isEqualToString:@"pulsa"]) {
        return @"Beli Pulsa";
    } else if ([type isEqualToString:@"transfer_bank"]) {
        return @"Transfer Bank";
    } else if ([type isEqualToString:@"pln"]) {
        return @"PLN";
    } else if ([type isEqualToString:@"transfer_telepon"]) {
        return @"Telepon";
    }
    return @"";
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
    NSString* email = @"rhmtsaepuloh@gmail.com";
    NSString* token = @"45dfe81cfa1abb851c6adfc86c0cc6e4";
    NSString* type = @"all";
    [activityIndicator startAnimating];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
//    [ECashConnection getFavorite:email token:token type:type success:success failure:failure];
}

#

@end
