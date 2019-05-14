//
//  ECashEndpoints.h
//  JSmart
//
//  Created by whcl on 11/09/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ECashEndpoints : NSObject

extern const NSString* ECASH_BASE_URL;
extern const NSString* ECASH_URL_LOGIN;
extern const NSString* ECASH_URL_LOGOUT;
extern const NSString* ECASH_URL_GET_REGISTER_TICKET;
extern const NSString* ECASH_URL_BALANCE_INQUIRY;
extern const NSString* ECASH_URL_TRANSACTION_HISTORY;
extern const NSString* ECASH_URL_TRANSFER_INQUIRY;
extern const NSString* ECASH_URL_TRANSFER;
extern const NSString* ECASH_URL_OTP_CASHOUT;
extern const NSString* ECASH_URL_OTP_PURCHASE;
extern const NSString* ECASH_URL_STATUS_INQUIRY;
extern const NSString* ECASH_URL_CHANGE_PIN;
extern const NSString* ECASH_URL_PROFILE_INQUIRY;
extern const NSString* ECASH_URL_TELCO_DENOM;
extern const NSString* ECASH_URL_TELCO_INQUIRY;
extern const NSString* ECASH_URL_TELCO_PAYMENT;
extern const NSString* ECASH_URL_PLN_INQUIRY;
extern const NSString* ECASH_URL_PLN_PAYMENT;
extern const NSString* ECASH_URL_PLN_ADVICE;
extern const NSString* ECASH_URL_TRANSFER_BANK_INQUIRY;
extern const NSString* ECASH_URL_TRANSFER_BANK_PAYMENT;
extern const NSString* ECASH_URL_OTP_TOPUP;
extern const NSString* ECASH_URL_GET_SECRET_QUESTION;
extern const NSString* ECASH_URL_RESET_CREDENTIALS;
extern const NSString* ECASH_URL_GET_TOPUP_DENOM_VISA_DEBIT_CARD;
extern const NSString* ECASH_URL_INQUIRY_TOPUP_VISA_DEBIT_CARD;
extern const NSString* ECASH_URL_GET_VISA_DEBIT_CARD_TOKEN;
extern const NSString* ECASH_URL_PAYMENT_TOPUP_VISA_DEBIT_CARD;
extern const NSString* ECASH_URL_CEK_USER;
extern const NSString* ECASH_URL_SET_USER;
extern const NSString* ECASH_URL_SET_FAVORITE;
extern const NSString* ECASH_URL_FAVORITE;

@end
