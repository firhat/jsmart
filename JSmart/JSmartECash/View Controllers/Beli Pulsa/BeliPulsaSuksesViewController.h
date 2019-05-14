//
//  BeliPulsaSuksesViewController.h
//  JSmart
//
//  Created by whcl on 30/09/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BeliPulsaSuksesViewController : UIViewController

@property NSString* status;
@property NSString* waktu;
@property NSString* nomorAkun;
@property NSString* nominal;
@property NSString* jumlahBayar;
@property NSString* nomorTransaksi;

@property (weak, nonatomic) IBOutlet UILabel *containerStatus;
@property (weak, nonatomic) IBOutlet UILabel *containerWaktu;
@property (weak, nonatomic) IBOutlet UILabel *containerNomorAkun;
@property (weak, nonatomic) IBOutlet UILabel *containerNominal;
@property (weak, nonatomic) IBOutlet UILabel *containerJumlahBayar;
@property (weak, nonatomic) IBOutlet UILabel *containerNoTransaksi;

- (IBAction)back:(UIButton *)sender;

@end
