//
//  ECashEndpoints.m
//  JSmart
//
//  Created by whcl on 11/09/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import "ECashEndpoints.h"

@implementation ECashEndpoints

NSString* ECASH_BASE_URL                                 = @"http://jsmart.id/api/yes/";
NSString* ECASH_URL_LOGIN                                = @"auth/login";
NSString* ECASH_URL_LOGOUT                               = @"auth/logout";
NSString* ECASH_URL_GET_REGISTER_TICKET                  = @"auth/getRegisterTicket";
NSString* ECASH_URL_BALANCE_INQUIRY                      = @"auth/balanceInquiry";
NSString* ECASH_URL_TRANSACTION_HISTORY                  = @"auth/TransactionHistory";
NSString* ECASH_URL_TRANSFER_INQUIRY                     = @"auth/TransferInquiry";
NSString* ECASH_URL_TRANSFER                             = @"auth/transfer";
NSString* ECASH_URL_OTP_CASHOUT                          = @"auth/otpCashout";
NSString* ECASH_URL_OTP_PURCHASE                         = @"auth/otpPurchase";
NSString* ECASH_URL_STATUS_INQUIRY                       = @"auth/statusInquiry";
NSString* ECASH_URL_CHANGE_PIN                           = @"auth/changePIN";
NSString* ECASH_URL_PROFILE_INQUIRY                      = @"auth/profileInquiry";
NSString* ECASH_URL_TELCO_DENOM                          = @"auth/telcoDenom";
NSString* ECASH_URL_TELCO_INQUIRY                        = @"auth/telcoInquiry";
NSString* ECASH_URL_TELCO_PAYMENT                        = @"auth/telcoPayment";
NSString* ECASH_URL_PLN_INQUIRY                          = @"auth/plnInquiry";
NSString* ECASH_URL_PLN_PAYMENT                          = @"auth/plnPayment";
NSString* ECASH_URL_PLN_ADVICE                           = @"auth/plnAdvice";
NSString* ECASH_URL_TRANSFER_BANK_INQUIRY                = @"auth/transferBankInquiry";
NSString* ECASH_URL_TRANSFER_BANK_PAYMENT                = @"auth/transferBankPayment";
NSString* ECASH_URL_OTP_TOPUP                            = @"auth/otpTopup";
NSString* ECASH_RL_GET_SECRET_QUESTION                  = @"auth/getSecretQuestion";
NSString* ECASH_URL_RESET_CREDENTIALS                    = @"auth/resetCredentials";
NSString* ECASH_URL_GET_TOPUP_DENOM_VISA_DEBIT_CARD      = @"auth/ccTopupDenom";
NSString* ECASH_URL_INQUIRY_TOPUP_VISA_DEBIT_CARD        = @"auth/CCTopupInquiry";
NSString* ECASH_URL_GET_VISA_DEBIT_CARD_TOKEN            = @"auth/ccToken";
NSString* ECASH_URL_PAYMENT_TOPUP_VISA_DEBIT_CARD        = @"auth/ccPaymentTopup";
NSString* ECASH_URL_CEK_USER                             = @"user";
NSString* ECASH_URL_SET_USER                             = @"user/setUser";
NSString* ECASH_URL_SET_FAVORITE                         = @"auth/setFavorite";
NSString* ECASH_URL_FAVORITE                             = @"auth/favorite";

@end
