//
//  VisaDebitCardViewController.h
//  JSmart
//
//  Created by whcl on 11/09/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Helpers.h"
#import "ECashConnection.h"

@interface VisaDebitCardViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>

//// Data Sources
@property NSMutableArray* denominations;
@property NSMutableArray* months;
@property NSMutableArray* years;

//// Picker View
@property NSString* PICKER_VIEW_DENOMINATIONS;
@property NSString* PICKER_VIEW_EXPIRING_DATE;
@property NSString* PICKER_VIEW_TYPE;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *containerAmount;
@property (weak, nonatomic) IBOutlet UITextField *containerCardNumber;
@property (weak, nonatomic) IBOutlet UITextField *containerExpiryDate;
@property (weak, nonatomic) IBOutlet UITextField *containerCvc;
@property (weak, nonatomic) IBOutlet UITextField *containerName;
@property (weak, nonatomic) IBOutlet UITextField *containerEmail;
@property (weak, nonatomic) IBOutlet UIView *containerPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

- (IBAction)back:(UIButton *)sender;
- (IBAction)submit:(UIButton *)sender;
- (IBAction)donePickerView:(UIButton *)sender;

@end
