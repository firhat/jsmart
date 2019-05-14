//
//  TarikTunaiMinimarketViewController.h
//  JSmart
//
//  Created by whcl on 30/09/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TarikTunaiMinimarketViewController : UIViewController

@property CGFloat jumlah;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *containerSaldoEcash;
@property (weak, nonatomic) IBOutlet UITextField *containerJumlah;

- (IBAction)add50:(UIButton *)sender;
- (IBAction)add100:(UIButton *)sender;
- (IBAction)add300:(UIButton *)sender;
- (IBAction)back:(UIButton *)sender;
- (IBAction)submit:(UIButton *)sender;

@end
