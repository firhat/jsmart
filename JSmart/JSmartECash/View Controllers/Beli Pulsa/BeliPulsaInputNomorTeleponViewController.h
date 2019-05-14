//
//  BeliPulsaInputNomorTeleponViewController.h
//  JSmart
//
//  Created by whcl on 30/09/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Helpers.h"
#import "ECashConnection.h"
#import "BeliPulsaDaftarNomorTeleponViewController.h"

@protocol BeliPulsaInputNomorTeleponViewControllerDelegate <NSObject>

- (void)selectNomorTeleponFromInput:(NSString*)nomorTelepon;

@end

@interface BeliPulsaInputNomorTeleponViewController : UIViewController

@property id<BeliPulsaInputNomorTeleponViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UIView *containerInputNomorTelepon;
@property (weak, nonatomic) IBOutlet UIView *containerDaftarNomorTelepon;
@property (weak, nonatomic) IBOutlet UITextField *containerNomorTelepon;
@property (weak, nonatomic) IBOutlet UISwitch *optionSimpanNomorTelepon;
@property (weak, nonatomic) IBOutlet UIView *containerInputNamaKontak;
@property (weak, nonatomic) IBOutlet UITextField *containerNamaKontak;

- (IBAction)back:(UIButton *)sender;
- (IBAction)openContact:(UIButton *)sender;
- (IBAction)submit:(UIButton *)sender;
- (IBAction)segmentedControlChangeValue:(UISegmentedControl *)sender;
- (IBAction)optionSimpanNomorTeleponChangeValue:(UISwitch *)sender;

@end
