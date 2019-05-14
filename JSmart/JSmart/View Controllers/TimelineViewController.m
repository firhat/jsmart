//
//  TimelineViewController.m
//  JSmart
//
//  Created by whcl on 29/06/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import "TimelineViewController.h"

@interface TimelineViewController ()

@property NSInteger page;
@property NSMutableArray* posts;
@property NSMutableDictionary* avPlayers;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    self.posts = [[NSMutableArray alloc] init];
    self.avPlayers = [[NSMutableDictionary alloc] init];
    [self getTimelinePost];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma Delegates

- (void)comment:(NSInteger)cellNumber {
    [self performSegueWithIdentifier:@"Detail" sender:@[[[NSNumber alloc] initWithInteger:cellNumber], @"YES"]];
}

- (void)seeLocation:(NSInteger)cellNumber {
    [self performSegueWithIdentifier:@"Location" sender:@[[[NSNumber alloc] initWithInteger:cellNumber]]];
}

- (void)share:(NSInteger)cellNumber {
    id post = [self.posts objectAtIndex:cellNumber];
    NSString* name = [post objectForKey:@"pelapor"];
    NSString* date = [post objectForKey:@"tanggal"];
    NSString* title = [post objectForKey:@"judul_laporan"];
    NSString* content = [post objectForKey:@"isi_laporan"];
    NSArray* sharedObjects = @[name, date, title, content];
    UIActivityViewController *vc = [[UIActivityViewController alloc] initWithActivityItems:sharedObjects applicationActivities:nil];
    NSArray *activities = @[UIActivityTypeAirDrop,
                            UIActivityTypePrint,
                            UIActivityTypeAssignToContact,
                            UIActivityTypeSaveToCameraRoll,
                            UIActivityTypeAddToReadingList,
                            UIActivityTypePostToFlickr,
                            UIActivityTypePostToVimeo];
    vc.excludedActivityTypes = activities;
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)selectCell:(NSInteger)cellNumber {
    [self performSegueWithIdentifier:@"Detail" sender:@[[[NSNumber alloc] initWithInteger:cellNumber]]];
}

- (void)selectCell:(NSInteger)cellNumber image:(UIImage *)image {
    BFRImageViewController *imageVC = [[BFRImageViewController alloc] initWithImageSource:@[image]];
    [self presentViewController:imageVC animated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.posts count] * 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath row] % 3 == 0) {
        return UITableViewAutomaticDimension;
    }
    else if ([indexPath row] % 3 == 2) {
        return 60;
    }
    id post = [self.posts objectAtIndex:([indexPath row] / 3)];
    id postImage = [[post objectForKey:@"images"] isKindOfClass:[NSNull class]] ? [[NSArray alloc] init] : [post objectForKey:@"images"];
    id postVideo = [[post objectForKey:@"videos"] isKindOfClass:[NSNull class]] ? [[NSArray alloc] init] : [post objectForKey:@"videos"];
    if ([postImage count] > 0 || [postVideo count] > 0) {
        return 200;
    }
    return 0;
//    UIImage* image =
//    CGFloat originalImageWidth = image.size.width;
//    CGFloat originalImageHeight = image.size.height;
//    CGFloat wantedImageWidth = [[UIScreen mainScreen] bounds].size.width - 20;
//    CGFloat wantedImageHeight = wantedImageWidth / originalImageWidth * originalImageHeight;
//    return wantedImageHeight + 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = [indexPath row] / 3;
    id post = [self.posts objectAtIndex:row];
    if ([indexPath row] % 3 == 0) {
        CellLaporanTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CellLaporan"];
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:@"CellLaporan" bundle:nil] forCellReuseIdentifier:@"CellLaporan"];
            cell = [tableView dequeueReusableCellWithIdentifier:@"CellLaporan"];
        }
        cell.cellNumber = row;
        cell.delegate = self;
        [cell.containerUserPicture sd_setImageWithURL:[post objectForKey:@"foto_pelapor"] placeholderImage:[UIImage imageNamed:@"ico_person_rounded"]];
        [cell.containerUserName setText:[post objectForKey:@"pelapor"]];
        [cell.containerDate setText:[post objectForKey:@"tanggal"]];
        [cell.containerCategoryIcon sd_setImageWithURL:[post objectForKey:@"icon_kategori"]];
        [cell.containerCategoryName setText:[post objectForKey:@"kategori"]];
        [cell.containerTitle setText:[post objectForKey:@"judul_laporan"]];
        [cell.containerContent setText:[post objectForKey:@"isi_laporan"]];
        if ([[post objectForKey:@"status"] isEqualToString:@"belum diproses"]) {
            [cell.containerStatus setImage:[UIImage imageNamed:@"ico_x_red"]];
        }
        else if ([[post objectForKey:@"status"] isEqualToString:@"terselesaikan"]) {
            [cell.containerStatus setImage:[UIImage imageNamed:@"ico_tick_green"]];
        }
        else {
            [cell.containerStatus setImage:[UIImage imageNamed:@"ico_clock_orange"]];
        }
        return cell;
    }
    else if ([indexPath row] % 3 == 1) {
        CellLaporanAttachmentTableViewCell* cellAttachment = [tableView dequeueReusableCellWithIdentifier:@"CellLaporanAttachment"];
        if (!cellAttachment) {
            [tableView registerNib:[UINib nibWithNibName:@"CellLaporanAttachment" bundle:nil] forCellReuseIdentifier:@"CellLaporanAttachment"];
            cellAttachment = [tableView dequeueReusableCellWithIdentifier:@"CellLaporanAttachment"];
        }
        cellAttachment.cellNumber = row;
        cellAttachment.delegate = self;
        id postImage = [[post objectForKey:@"images"] isKindOfClass:[NSNull class]] ? [[NSArray alloc] init] : [post objectForKey:@"images"];
        id postVideo = [[post objectForKey:@"videos"] isKindOfClass:[NSNull class]] ? [[NSArray alloc] init] : [post objectForKey:@"videos"];
        if ([postImage count] > 0) {
            cellAttachment.hasAttachment = true;
            [cellAttachment.containerVideo setHidden:true];
            [cellAttachment.containerImage setHidden:false];
            [cellAttachment.containerButton setHidden:false];
            [cellAttachment.containerImage sd_setImageWithURL:[postImage objectAtIndex:0]];
        }
        else if ([postVideo count] > 0) {
            cellAttachment.hasAttachment = true;
            [cellAttachment.containerVideo setHidden:false];
            [cellAttachment.containerImage setHidden:true];
            [cellAttachment.containerButton setHidden:true];
            if (!cellAttachment.avPlayerViewController && !cellAttachment.avPlayer) {
                NSURL* url = [NSURL URLWithString:[postVideo objectAtIndex:0]];
                cellAttachment.avPlayerViewController = [[AVPlayerViewController alloc] init];
                cellAttachment.avPlayer = [[AVPlayer alloc] initWithURL:url];
                cellAttachment.avPlayerViewController.player = cellAttachment.avPlayer;
                [self addChildViewController:cellAttachment.avPlayerViewController];
                cellAttachment.avPlayerViewController.view.frame = cellAttachment.containerVideo.frame;
                [cellAttachment.containerVideo addSubview:cellAttachment.avPlayerViewController.view];
                [cellAttachment.avPlayerViewController didMoveToParentViewController:self];
            }
        }
        else {
            cellAttachment.hasAttachment = false;
            [cellAttachment.containerVideo setHidden:true];
            [cellAttachment.containerImage setHidden:true];
            [cellAttachment.containerButton setHidden:true];
        }
        return cellAttachment;
    }
    CellLaporanFooterTableViewCell* cellFooter = [tableView dequeueReusableCellWithIdentifier:@"CellLaporanFooter"];
    if (!cellFooter) {
        [tableView registerNib:[UINib nibWithNibName:@"CellLaporanFooter" bundle:nil] forCellReuseIdentifier:@"CellLaporanFooter"];
        cellFooter = [tableView dequeueReusableCellWithIdentifier:@"CellLaporanFooter"];
    }
    cellFooter.cellNumber = row;
    cellFooter.delegate = self;
    return cellFooter;
}

#pragma IBActions

- (IBAction)back:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma Connection

- (void)getTimelinePost {
    UIActivityIndicatorView* activityIndicator = [Helpers getActivityIndicator:self];
    void (^success)(NSURLSessionTask *task, id responseObject) = ^void(NSURLSessionTask *task, id responseObject) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        if (![[responseObject objectForKey:@"status"] boolValue]) {
            [Helpers alertFailure:[responseObject objectForKey:@"message"] viewController:self];
            return;
        }
        NSInteger totalUserPost = [[[responseObject objectForKey:@"data"] objectForKey:@"total"] integerValue];
        [self.posts addObjectsFromArray:[[responseObject objectForKey:@"data"] objectForKey:@"timeline"]];
        if ([self.posts count] < totalUserPost) {
            self.page = self.page + 1;
            [self getTimelinePost];
        } else {
            [self.tableView reloadData];
        }
    };
    void (^failure)(NSURLSessionTask *operation, NSError *error) = ^void(NSURLSessionTask *operation, NSError *error) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        [Helpers alertFailure:[error localizedDescription] viewController:self];
    };
    NSString* email = [[NSUserDefaults standardUserDefaults] stringForKey:@"email"];
    NSString* token = [[NSUserDefaults standardUserDefaults] stringForKey:@"token"];
    NSNumber* page = [[NSNumber alloc] initWithInteger:self.page];
    [activityIndicator startAnimating];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [Connection getTimelinePost:email token:token page:page success:success failure:failure];
}

#pragma Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSString* identifier = [segue identifier];
    if ([identifier isEqualToString:@"Location"]) {
        LocationViewController* vc = [segue destinationViewController];
        NSInteger cellNumber = [[sender objectAtIndex:0] integerValue];
        vc.post = [self.posts objectAtIndex:cellNumber];
    }
    else if ([identifier isEqualToString:@"Detail"]) {
        LaporanViewController* vc = [segue destinationViewController];
        NSInteger index = [[sender objectAtIndex:0] integerValue];
        vc.post = [self.posts objectAtIndex:index];
        if ([sender count] > 1) {
            vc.FROM_TIMELINE_TO_COMMENT = [sender objectAtIndex:1];
        }
    }
}

@end
