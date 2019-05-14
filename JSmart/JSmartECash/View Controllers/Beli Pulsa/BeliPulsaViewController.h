//
//  BeliPulsaViewController.h
//  JSmart
//
//  Created by whcl on 30/09/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Helpers.h"
#import "ECashConnection.h"
#import "BeliPulsaInputNomorTeleponViewController.h"
#import "BeliPulsaDaftarNomorTeleponViewController.h"
#import "BeliPulsaKonfirmasiViewController.h"

@interface BeliPulsaViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, BeliPulsaInputNomorTeleponViewControllerDelegate, BeliPulsaDaftarNomorTeleponViewControllerDelegate>

@property NSMutableArray* jumlah;
@property NSString* transferTypeId;
@property NSString* nameOperator;
@property NSString* nomorTujuan;
@property NSString* jumlahDipilih;
@property NSString* fee;
@property NSString* total;

@property (weak, nonatomic) IBOutlet UITextField *containerNomorTelepon;
@property (weak, nonatomic) IBOutlet UILabel *containerSaldoEcash;
@property (weak, nonatomic) IBOutlet UIView *containerInputJumlah;
@property (weak, nonatomic) IBOutlet UITextField *containerJumlah;
@property (weak, nonatomic) IBOutlet UIView *containerPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

- (IBAction)back:(UIButton *)sender;
- (IBAction)selectNomorTelepon:(UIButton *)sender;
- (IBAction)selectJumlah:(UIButton *)sender;
- (IBAction)submit:(UIButton *)sender;
- (IBAction)donePickerView:(UIButton *)sender;

@end
