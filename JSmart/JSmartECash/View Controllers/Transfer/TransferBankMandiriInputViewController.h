//
//  TransferBankMandiriInputViewController.h
//  JSmart
//
//  Created by whcl on 17/09/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Helpers.h"

@interface TransferBankMandiriInputViewController : UIViewController

@property NSString* nomorRekening;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UIView *containerInput;
@property (weak, nonatomic) IBOutlet UIView *containerDaftar;
@property (weak, nonatomic) IBOutlet UITextField *containerNumber;
@property (weak, nonatomic) IBOutlet UISwitch *optionFavorite;

- (IBAction)back:(UIButton *)sender;
- (IBAction)changeSegment:(UISegmentedControl *)sender;
- (IBAction)submit:(UIButton *)sender;

@end
