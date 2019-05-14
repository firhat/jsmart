//
//  InformationViewController.m
//  JSmart
//
//  Created by whcl on 10/07/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import "InformationViewController.h"

@interface InformationViewController ()

@end

@implementation InformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma Delegates

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath row] != 1) {
        return UITableViewAutomaticDimension;
    }
    return 200;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = [indexPath row];
    if (row == 0) {
        CellInformationTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CellInformation"];
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:@"CellInformation" bundle:nil] forCellReuseIdentifier:@"CellInformation"];
            cell = [tableView dequeueReusableCellWithIdentifier:@"CellInformation"];
        }
        cell.containerText.text = [self.information objectForKey:@"judul_informasi"];
        [cell.containerText setFont:[UIFont boldSystemFontOfSize:15]];
        return cell;
    }
    else if (row == 1) {
        CellInformationImageTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CellInformationImage"];
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:@"CellInformationImage" bundle:nil] forCellReuseIdentifier:@"CellInformationImage"];
            cell = [tableView dequeueReusableCellWithIdentifier:@"CellInformationImage"];
        }
        [cell.containerImage sd_setImageWithURL:[self.information objectForKey:@"foto_informasi"]];
        return cell;
    }
    CellInformationTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CellInformation"];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"CellInformation" bundle:nil] forCellReuseIdentifier:@"CellInformation"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"CellInformation"];
    }
    cell.containerText.text = [self.information objectForKey:@"isi_informasi"];
    return cell;
}

#pragma IBActions

- (IBAction)back:(UIButton *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}
@end
