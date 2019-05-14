//
//  LaporanViewController.m
//  JSmart
//
//  Created by whcl on 30/06/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import "LaporanViewController.h"

@interface LaporanViewController ()

@end

@implementation LaporanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([self.FROM_TIMELINE_TO_COMMENT isEqualToString:@"YES"]) {
        self.FROM_TIMELINE_TO_COMMENT = @"";
        [self performSegueWithIdentifier:@"Comment" sender:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma Delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath row] % 3 == 0) {
        return UITableViewAutomaticDimension;
    }
    else if ([indexPath row] % 3 == 2) {
        return 60;
    }
    id postImage = [[self.post objectForKey:@"images"] isKindOfClass:[NSNull class]] ? [[NSArray alloc] init] : [self.post objectForKey:@"images"];
    id postVideo = [[self.post objectForKey:@"videos"] isKindOfClass:[NSNull class]] ? [[NSArray alloc] init] : [self.post objectForKey:@"videos"];
    if ([postImage count] > 0 || [postVideo count] > 0) {
        return 200;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath row] % 3 == 0) {
        CellLaporanTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CellLaporan"];
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:@"CellLaporan" bundle:nil] forCellReuseIdentifier:@"CellLaporan"];
            cell = [tableView dequeueReusableCellWithIdentifier:@"CellLaporan"];
        }
        cell.delegate = self;
        [cell.containerUserPicture sd_setImageWithURL:[self.post objectForKey:@"foto_pelapor"] placeholderImage:[UIImage imageNamed:@"ico_person_rounded"]];
        [cell.containerUserName setText:[self.post objectForKey:@"pelapor"]];
        [cell.containerDate setText:[self.post objectForKey:@"tanggal"]];
        [cell.containerCategoryIcon sd_setImageWithURL:[self.post objectForKey:@"icon_kategori"]];
        [cell.containerCategoryName setText:[self.post objectForKey:@"kategori"]];
        [cell.containerTitle setText:[self.post objectForKey:@"judul_laporan"]];
        [cell.containerContent setText:[self.post objectForKey:@"isi_laporan"]];
        if ([[self.post objectForKey:@"status"] isEqualToString:@"belum diproses"]) {
            [cell.containerStatus setImage:[UIImage imageNamed:@"ico_x_red"]];
        }
        else if ([[self.post objectForKey:@"status"] isEqualToString:@"terselesaikan"]) {
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
        cellAttachment.delegate = self;
        id postImage = [[self.post objectForKey:@"images"] isKindOfClass:[NSNull class]] ? [[NSArray alloc] init] : [self.post objectForKey:@"images"];
        id postVideo = [[self.post objectForKey:@"videos"] isKindOfClass:[NSNull class]] ? [[NSArray alloc] init] : [self.post objectForKey:@"videos"];
        if ([postImage count] > 0) {
            cellAttachment.hasAttachment = true;
            [cellAttachment.containerImage setHidden:false];
            [cellAttachment.containerVideo setHidden:true];
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
            [cellAttachment.containerImage setHidden:true];
            [cellAttachment.containerVideo setHidden:true];
            [cellAttachment.containerButton setHidden:true];
        }
        return cellAttachment;
    }
    CellLaporanFooterTableViewCell* cellFooter = [tableView dequeueReusableCellWithIdentifier:@"CellLaporanFooter"];
    if (!cellFooter) {
        [tableView registerNib:[UINib nibWithNibName:@"CellLaporanFooter" bundle:nil] forCellReuseIdentifier:@"CellLaporanFooter"];
        cellFooter = [tableView dequeueReusableCellWithIdentifier:@"CellLaporanFooter"];
    }
    cellFooter.delegate = self;
    [cellFooter.containerBorder setHidden:true];
    return cellFooter;
}

#pragma Delegates

- (void)comment:(NSInteger)cellNumber {
    [self performSegueWithIdentifier:@"Comment" sender:nil];
}

- (void)seeLocation:(NSInteger)cellNumber {
    [self performSegueWithIdentifier:@"Location" sender:nil];
}

- (void)share:(NSInteger)cellNumber {
    NSString* name = [self.post objectForKey:@"pelapor"];
    NSString* date = [self.post objectForKey:@"tanggal"];
    NSString* title = [self.post objectForKey:@"judul_laporan"];
    NSString* content = [self.post objectForKey:@"isi_laporan"];
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
    
}

- (void)selectCell:(NSInteger)cellNumber image:(UIImage *)image {
    BFRImageViewController *imageVC = [[BFRImageViewController alloc] initWithImageSource:@[image]];
    [self presentViewController:imageVC animated:YES completion:nil];
}

#pragma Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSString* identifier = [segue identifier];
    if ([identifier isEqualToString:@"Location"]) {
        LocationViewController* vc = [segue destinationViewController];
        vc.post = self.post;
    }
    else if ([identifier isEqualToString:@"Comment"]) {
        CommentViewController* vc = [segue destinationViewController];
        vc.idLaporan = [[self.post objectForKey:@"id_laporan"] integerValue];
    }
}

#pragma IBActions

- (IBAction)back:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
