//
//  ECashHistoryViewController.m
//  JSmart
//
//  Created by whcl on 11/09/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import "ECashHistoryViewController.h"

@interface ECashHistoryViewController ()

@end

@implementation ECashHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.histories = [[NSMutableArray alloc] init];
    self.times = [[NSMutableArray alloc] initWithObjects:
                  @"1 Bulan Terakhir",
                  @"3 Bulan Terakhir",
                  @"Pilih Manual", nil];
    
    [self getTransactionHistory];
}

#pragma UITableView Delegate and Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.histories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HistoryTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"HistoryTableViewCell"];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"HistoryTableViewCell" bundle:nil] forCellReuseIdentifier:@"HistoryTableViewCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"HistoryTableViewCell"];
    }
    NSInteger index = [indexPath row];
    NSDictionary* history = [self.histories objectAtIndex:index];
    [cell.containerDate setText:[history objectForKey:@"transactionDate"]];
    [cell.containerType setText:[history objectForKey:@"description"]];
    [cell.containerTitle setText:@"Setor Tunai"];
    [cell.containerAmount setText:[history objectForKey:@"amount"]];
    cell.cellNumber = index;
    cell.delegate = self;
    return cell;
}

#

#pragma History Table View Cell Delegate

- (void)selectCell:(NSInteger)cellNumber {
    [self performSegueWithIdentifier:@"ECashHistoryDetailViewController" sender:@[@(cellNumber)]];
}

#

#pragma Time Picker Delegate and Data Source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.times count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.times objectAtIndex:row];
}

#

- (IBAction)selectFilter:(UIButton *)sender {
    [self.timePicker setHidden:false];
}

- (IBAction)selectDate:(UIButton *)sender {
    
}

- (IBAction)selectTime:(UIButton *)sender {
//    NSInteger selectedRow = [self.timePicker selectedRowInComponent:0];
//    if (selectedRow == 0 || selectedRow == 1) {
//        NSString* selectedTime = [self.times objectAtIndex:selectedRow];
//        [self.containerFilter setText:selectedTime];
//    } else if (selectedRow == 2) {
//        [self.datePicker setHidden:false];
//    }
//    [self.timePicker setHidden:true];
}

#pragma Connection

- (void)getTransactionHistory {
    UIActivityIndicatorView* activityIndicator = [Helpers getActivityIndicator:self];
    void (^success)(NSURLSessionTask *task, id responseObject) = ^void(NSURLSessionTask *task, id responseObject) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        if (![[responseObject objectForKey:@"status"] boolValue]) {
            [Helpers alertFailure:[responseObject objectForKey:@"message"] viewController:self];
            return;
        }
        self.histories = [[responseObject objectForKey:@"data"] objectForKey:@"accountHistoryDetails"];
        [self.tableView reloadData];
    };
    void (^failure)(NSURLSessionTask *operation, NSError *error) = ^void(NSURLSessionTask *operation, NSError *error) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        [Helpers alertFailure:[error localizedDescription] viewController:self];
    };
    NSString* msisdn = @"081222441086";
    NSString* token = @"111977DC72BAFB172EA58DBD587A34DF";
    NSString* currentPage = @"1";
    NSString* pageSize = @"5";
    NSString* startDate = @"2018-01-01";
    NSString* endDate = @"2018-09-28";
    NSString* email_jsmart = @"rhmtsaepuloh@gmail.com";
    NSString* token_jsmart = @"bc6ff909eed72dcd12a8e003c3c529b9";
    [activityIndicator startAnimating];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [ECashConnection getTransactionHistory:msisdn token:token currentPage:currentPage pageSize:pageSize startDate:startDate endDate:endDate email_jsmart:email_jsmart token_jsmart:token_jsmart success:success failure:failure];
}

#

#pragma Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSString* identifier = [segue identifier];
    if ([identifier isEqualToString:@"ECashHistoryDetailViewController"]) {
        ECashHistoryDetailViewController* vc = [segue destinationViewController];
        vc.history = [self.histories objectAtIndex:[[sender objectAtIndex:0] integerValue]];
    }
}

#

@end
