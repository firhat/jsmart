//
//  ECashHistoryViewController.h
//  JSmart
//
//  Created by whcl on 11/09/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECashConnection.h"
#import "Helpers.h"
#import "HistoryTableViewCell.h"
#import "ECashHistoryDetailViewController.h"

@interface ECashHistoryViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource, HistoryTableViewCellDelegate>

@property NSMutableArray* histories;
@property NSMutableArray* times;

@property (weak, nonatomic) IBOutlet UILabel *containerFilter;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *containerDatePicker;
@property (weak, nonatomic) IBOutlet UIView *containerTimePicker;
@property (weak, nonatomic) IBOutlet UILabel *containerStartDate;
@property (weak, nonatomic) IBOutlet UILabel *containerEndDate;
@property (weak, nonatomic) IBOutlet UIDatePicker *startDatePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *endDatePicker;
@property (weak, nonatomic) IBOutlet UIPickerView *timePicker;

- (IBAction)selectFilter:(UIButton *)sender;
- (IBAction)selectDate:(UIButton *)sender;
- (IBAction)selectTime:(UIButton *)sender;

@end
