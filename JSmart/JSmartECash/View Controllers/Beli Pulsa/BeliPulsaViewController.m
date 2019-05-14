//
//  BeliPulsaViewController.m
//  JSmart
//
//  Created by whcl on 30/09/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import "BeliPulsaViewController.h"

@interface BeliPulsaViewController ()

@end

@implementation BeliPulsaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.jumlah = [[NSMutableArray alloc] init];
    
    [self inquireBalance];
}

#pragma UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.jumlah count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.jumlah objectAtIndex:row];
}

#

#pragma BeliPulsaInputNomorTeleponViewControllerDelegate && BeliPulsaDaftarNomorTeleponViewControllerDelegate

- (void)selectNomorTeleponFromInput:(NSString *)nomorTelepon {
    [self.containerNomorTelepon setText:nomorTelepon];
    [self getBeliPulsaDenomination];
    [self.containerInputJumlah setHidden:false];
}

- (void)selectNomorTeleponFromDaftar:(NSString *)nomorTelepon {
    [self.containerNomorTelepon setText:nomorTelepon];
    [self getBeliPulsaDenomination];
    [self.containerInputJumlah setHidden:false];
}

#pragma Connection

- (void)getBeliPulsaDenomination {
    UIActivityIndicatorView* activityIndicator = [Helpers getActivityIndicator:self];
    void (^success)(NSURLSessionTask *task, id responseObject) = ^void(NSURLSessionTask *task, id responseObject) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        if (![[responseObject objectForKey:@"status"] boolValue]) {
            [Helpers alertFailure:[responseObject objectForKey:@"message"] viewController:self];
            return;
        }
        self.jumlah = [[responseObject objectForKey:@"data"] objectForKey:@"denom"];
        self.transferTypeId = [[responseObject objectForKey:@"data"] objectForKey:@"transferTypeID"];
        NSArray* strings = [self.transferTypeId componentsSeparatedByString:@"."];
        self.nameOperator = [[strings objectAtIndex:1] uppercaseString];
        [self.pickerView reloadAllComponents];
    };
    void (^failure)(NSURLSessionTask *operation, NSError *error) = ^void(NSURLSessionTask *operation, NSError *error) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        [Helpers alertFailure:[error localizedDescription] viewController:self];
    };
    NSString* msisdn = @"081222441086";
    NSString* token = @"111977DC72BAFB172EA58DBD587A34DF";
    NSString* toMember = @"081222441086";
    NSString* email_jsmart = @"rhmtsaepuloh@gmail.com";
    NSString* token_jsmart = @"5ebbcd022eb510f595f7402e269d3a46";
    [activityIndicator startAnimating];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [ECashConnection getBeliPulsaDenomination:msisdn token:token toMember:toMember email_jsmart:email_jsmart token_jsmart:token_jsmart success:success failure:failure];
}

- (void)inquireBalance {
    UIActivityIndicatorView* activityIndicator = [Helpers getActivityIndicator:self];
    void (^success)(NSURLSessionTask *task, id responseObject) = ^void(NSURLSessionTask *task, id responseObject) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        if (![[responseObject objectForKey:@"status"] boolValue]) {
            [Helpers alertFailure:[responseObject objectForKey:@"message"] viewController:self];
            return;
        }
        CGFloat balance = [[[responseObject objectForKey:@"data"] objectForKey:@"accountBalance"] floatValue];
        NSString* balanceString = [NSString stringWithFormat:@"%.2f", balance];
        [self.containerSaldoEcash setText:balanceString];
    };
    void (^failure)(NSURLSessionTask *operation, NSError *error) = ^void(NSURLSessionTask *operation, NSError *error) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        [Helpers alertFailure:[error localizedDescription] viewController:self];
    };
    NSString* msisdn = @"081222441086";
    NSString* token = @"111977DC72BAFB172EA58DBD587A34DF";
    NSString* email_jsmart = @"rhmtsaepuloh@gmail.com";
    NSString* token_jsmart = @"5ebbcd022eb510f595f7402e269d3a46";
    [activityIndicator startAnimating];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [ECashConnection inquireBalance:msisdn token:token email_jsmart:email_jsmart token_jsmart:token_jsmart success:success failure:failure];
}

- (void)inquireBeliPulsa {
    UIActivityIndicatorView* activityIndicator = [Helpers getActivityIndicator:self];
    void (^success)(NSURLSessionTask *task, id responseObject) = ^void(NSURLSessionTask *task, id responseObject) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        if (![[responseObject objectForKey:@"status"] boolValue]) {
            [Helpers alertFailure:[responseObject objectForKey:@"message"] viewController:self];
            return;
        }
        self.fee = [[responseObject objectForKey:@"data"] objectForKey:@"totalFee"];
        [self performSegueWithIdentifier:@"BeliPulsaKonfirmasiViewController" sender:self];
    };
    void (^failure)(NSURLSessionTask *operation, NSError *error) = ^void(NSURLSessionTask *operation, NSError *error) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        [Helpers alertFailure:[error localizedDescription] viewController:self];
    };
    NSString* msisdn = @"081222441086";
    NSString* token = @"111977DC72BAFB172EA58DBD587A34DF";
    NSString* toMember = self.nomorTujuan;
    NSString* amount = self.jumlahDipilih;
    NSString* transferTypeID = self.transferTypeId;
    NSString* email_jsmart = @"rhmtsaepuloh@gmail.com";
    NSString* token_jsmart = @"5ebbcd022eb510f595f7402e269d3a46";
    [activityIndicator startAnimating];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [ECashConnection inquireBeliPulsa:msisdn token:token toMember:toMember amount:amount transferTypeID:transferTypeID email_jsmart:email_jsmart token_jsmart:token_jsmart success:success failure:failure];
}

#

#pragma Helpers

- (BOOL)validateForm {
    self.nomorTujuan = [self.containerNomorTelepon text];
    self.jumlahDipilih = [self.containerJumlah text];
    
    if ([self.nomorTujuan isEqualToString:@""] || [self.jumlahDipilih isEqualToString:@""]) {
        NSString* message = @"Mohon untuk melengkapi seluruh data yang diperlukan.";
        [Helpers alertFailure:message viewController:self];
        return false;
    }
    
    return true;
}

#

- (IBAction)back:(UIButton *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)selectNomorTelepon:(UIButton *)sender {
    [self performSegueWithIdentifier:@"BeliPulsaInputNomorTeleponViewController" sender:self];
}

- (IBAction)selectJumlah:(UIButton *)sender {
    [self.containerPickerView setHidden:false];
}

- (IBAction)submit:(UIButton *)sender {
    if (![self validateForm]) {
        return;
    }
    [self inquireBeliPulsa];
}

- (IBAction)donePickerView:(UIButton *)sender {
    [self.containerPickerView setHidden:true];
    NSInteger selectedRow = [self.pickerView selectedRowInComponent:0];
    NSString* jumlah = [self.jumlah objectAtIndex:selectedRow];
    [self.containerJumlah setText:jumlah];
}

#pragma Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSString* identifier = [segue identifier];
    if ([identifier isEqualToString:@"BeliPulsaInputNomorTeleponViewController"]) {
        BeliPulsaInputNomorTeleponViewController* vc = [segue destinationViewController];
        vc.delegate = self;
    }
    
    if ([identifier isEqualToString:@"BeliPulsaKonfirmasiViewController"]) {
        BeliPulsaKonfirmasiViewController* vc = [segue destinationViewController];
        vc.transferTypeId = self.transferTypeId;
        vc.nameOperator = self.nameOperator;
        vc.nomor = self.nomorTujuan;
        vc.nominal = self.jumlahDipilih;
        vc.total = self.jumlahDipilih;
    }
}

#

@end
