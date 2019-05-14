//
//  ECashConnection.m
//  JSmart
//
//  Created by whcl on 11/09/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import "ECashConnection.h"

@implementation ECashConnection

+ (void)connect:(NSString*)url
     parameters:(NSDictionary*)parameters
        success:(void (^)(NSURLSessionTask *task, id responseObject))success
        failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableSet *contentTypes = [[NSMutableSet alloc] initWithSet:manager.responseSerializer.acceptableContentTypes];
    [contentTypes addObject:@"text/html"];
    manager.responseSerializer.acceptableContentTypes = contentTypes;
    [manager POST:url
       parameters:parameters
         progress:nil
          success:success
          failure:failure];
}

//// Login

+ (void)login_:(NSDictionary*)parameters
       success:(void (^)(NSURLSessionTask *task, id responseObject))success
       failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure {
    NSString* url = [NSString stringWithFormat:@"%@%@", ECASH_BASE_URL, ECASH_URL_LOGIN];
    [ECashConnection connect:url parameters:parameters success:success failure:failure];
}

+ (void)login:(NSString *)email
     password:(NSString *)password
      success:(void (^)(NSURLSessionTask *, id))success
      failure:(void (^)(NSURLSessionTask *, NSError *))failure {
    NSDictionary* parameters = @{@"email" : email,
                                 @"password" : password};
    [ECashConnection login_:parameters success:success failure:failure];
}

//// Get Denomination

+ (void)getDenomination_:(NSDictionary*)parameters
                 success:(void (^)(NSURLSessionTask *task, id responseObject))success
                 failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure {
    NSString* url = [NSString stringWithFormat:@"%@%@", ECASH_BASE_URL, ECASH_URL_GET_TOPUP_DENOM_VISA_DEBIT_CARD];
    [ECashConnection connect:url parameters:parameters success:success failure:failure];
}

+ (void)getDenomination:(NSString*)msisdn
                  token:(NSString*)token
                    ver:(NSString*)ver
           email_jsmart:(NSString*)email_jsmart
           token_jsmart:(NSString*)token_jsmart
                success:(void (^)(NSURLSessionTask *task, id responseObject))success
                failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure {
    NSDictionary* parameters = @{@"msisdn" : msisdn,
                                 @"token" : token,
                                 @"ver" : ver,
                                 @"email_jsmart" : email_jsmart,
                                 @"token_jsmart" : token_jsmart};
    [ECashConnection getDenomination_:parameters success:success failure:failure];
}

//// Inquire Topup

+ (void)inquireTopup_:(NSDictionary*)parameters
              success:(void (^)(NSURLSessionTask *task, id responseObject))success
              failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure {
    NSString* url = [NSString stringWithFormat:@"%@%@", ECASH_BASE_URL, ECASH_URL_INQUIRY_TOPUP_VISA_DEBIT_CARD];
    [ECashConnection connect:url parameters:parameters success:success failure:failure];
}

+ (void)inquireTopup:(NSString*)msisdn
               token:(NSString*)token
                 bin:(NSString*)bin
              amount:(NSString*)amount
        email_jsmart:(NSString*)email_jsmart
        token_jsmart:(NSString*)token_jsmart
             success:(void (^)(NSURLSessionTask *task, id responseObject))success
             failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure {
    NSDictionary* parameters = @{@"msisdn" : msisdn,
                                 @"token" : token,
                                 @"bin" : bin,
                                 @"amount" : amount,
                                 @"email_jsmart" : email_jsmart,
                                 @"token_jsmart" : token_jsmart};
    [ECashConnection inquireTopup_:parameters success:success failure:failure];
}

//// Get Register Ticket

+ (void)getRegisterTicket_:(NSDictionary*)parameters
                   success:(void (^)(NSURLSessionTask *task, id responseObject))success
                   failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure {
    NSString* url = [NSString stringWithFormat:@"%@%@", ECASH_BASE_URL, ECASH_URL_GET_REGISTER_TICKET];
    [ECashConnection connect:url parameters:parameters success:success failure:failure];
}

+ (void)getRegisterTicket:(NSString*)mobileno
                    token:(NSString*)token
             email_jsmart:(NSString*)email_jsmart
             token_jsmart:(NSString*)token_jsmart
                  success:(void (^)(NSURLSessionTask *task, id responseObject))success
                  failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure {
    NSDictionary* parameters = @{@"mobileno" : mobileno,
                                 @"token" : token,
                                 @"email_jsmart" : email_jsmart,
                                 @"token_jsmart" : token_jsmart};
    [ECashConnection getRegisterTicket_:parameters success:success failure:failure];
}

//// Profile Inquiry

+ (void)inquireProfile_:(NSDictionary*)parameters
                success:(void (^)(NSURLSessionTask *task, id responseObject))success
                failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure {
    NSString* url = [NSString stringWithFormat:@"%@%@", ECASH_BASE_URL, ECASH_URL_PROFILE_INQUIRY];
    [ECashConnection connect:url parameters:parameters success:success failure:failure];
}

+ (void)inquireProfile:(NSString*)msisdn
                 token:(NSString*)token
          email_jsmart:(NSString*)email_jsmart
          token_jsmart:(NSString*)token_jsmart
               success:(void (^)(NSURLSessionTask *task, id responseObject))success
               failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure {
    NSDictionary* parameters = @{@"msisdn" : msisdn,
                                 @"token" : token,
                                 @"email_jsmart" : email_jsmart,
                                 @"token_jsmart" : token_jsmart};
    [ECashConnection inquireProfile_:parameters success:success failure:failure];
}

//// Balance Inquiry

+ (void)inquireBalance_:(NSDictionary*)parameters
                success:(void (^)(NSURLSessionTask *task, id responseObject))success
                failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure {
    NSString* url = [NSString stringWithFormat:@"%@%@", ECASH_BASE_URL, ECASH_URL_BALANCE_INQUIRY];
    [ECashConnection connect:url parameters:parameters success:success failure:failure];
}

+ (void)inquireBalance:(NSString*)msisdn
                 token:(NSString*)token
          email_jsmart:(NSString*)email_jsmart
          token_jsmart:(NSString*)token_jsmart
               success:(void (^)(NSURLSessionTask *task, id responseObject))success
               failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure {
    NSDictionary* parameters = @{@"msisdn" : msisdn,
                                 @"token" : token,
                                 @"email_jsmart" : email_jsmart,
                                 @"token_jsmart" : token_jsmart};
    [ECashConnection inquireBalance_:parameters success:success failure:failure];
}

//// Get Transaction History

+ (void)getTransactionHistory_:(NSDictionary*)parameters
                       success:(void (^)(NSURLSessionTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure {
    NSString* url = [NSString stringWithFormat:@"%@%@", ECASH_BASE_URL, ECASH_URL_TRANSACTION_HISTORY];
    [ECashConnection connect:url parameters:parameters success:success failure:failure];
}

+ (void)getTransactionHistory:(NSString*)msisdn
                        token:(NSString*)token
                  currentPage:(NSString*)currentPage
                     pageSize:(NSString*)pageSize
                    startDate:(NSString*)startDate
                      endDate:(NSString*)endDate
                 email_jsmart:(NSString*)email_jsmart
                 token_jsmart:(NSString*)token_jsmart
                      success:(void (^)(NSURLSessionTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure {
    NSDictionary* parameters = @{@"msisdn" : msisdn,
                                 @"token" : token,
                                 @"currentPage" : currentPage,
                                 @"pageSize" : pageSize,
                                 @"startDate" : startDate,
                                 @"endDate" : endDate,
                                 @"email_jsmart" : email_jsmart,
                                 @"token_jsmart" : token_jsmart};
    [ECashConnection getTransactionHistory_:parameters success:success failure:failure];
}

//// Get Beli Pulsa Denomination

+ (void)getBeliPulsaDenomination_:(NSDictionary*)parameters
                          success:(void (^)(NSURLSessionTask *task, id responseObject))success
                          failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure {
    NSString* url = [NSString stringWithFormat:@"%@%@", ECASH_BASE_URL, ECASH_URL_TELCO_DENOM];
    [ECashConnection connect:url parameters:parameters success:success failure:failure];
}

+ (void)getBeliPulsaDenomination:(NSString*)msisdn
                           token:(NSString*)token
                        toMember:(NSString*)toMember
                    email_jsmart:(NSString*)email_jsmart
                    token_jsmart:(NSString*)token_jsmart
                         success:(void (^)(NSURLSessionTask *task, id responseObject))success
                         failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure {
    NSDictionary* parameters = @{@"msisdn" : msisdn,
                                 @"token" : token,
                                 @"toMember" : toMember,
                                 @"email_jsmart" : email_jsmart,
                                 @"token_jsmart" : token_jsmart};
    [ECashConnection getBeliPulsaDenomination_:parameters success:success failure:failure];
}

//// Set Favorite

+ (void)setFavorite_:(NSDictionary*)parameters
             success:(void (^)(NSURLSessionTask *task, id responseObject))success
             failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure {
    NSString* url = [NSString stringWithFormat:@"%@%@", ECASH_BASE_URL, ECASH_URL_SET_FAVORITE];
    [ECashConnection connect:url parameters:parameters success:success failure:failure];
}

+ (void)setFavorite:(NSString*)nomor_favorite
        nama_kontak:(NSString*)nama_kontak
               type:(NSString*)type
       email_jsmart:(NSString*)email_jsmart
       token_jsmart:(NSString*)token_jsmart
            success:(void (^)(NSURLSessionTask *task, id responseObject))success
            failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure {
    NSDictionary* parameters = @{@"nomor_favorite" : nomor_favorite,
                                 @"nama_kontak" : nama_kontak,
                                 @"type" : type,
                                 @"email_jsmart" : email_jsmart,
                                 @"token_jsmart" : token_jsmart};
    [ECashConnection setFavorite_:parameters success:success failure:failure];
}

//// Get Favorite

+ (void)getFavorite_:(NSDictionary*)parameters
             success:(void (^)(NSURLSessionTask *task, id responseObject))success
             failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure {
    NSString* url = [NSString stringWithFormat:@"%@%@", ECASH_BASE_URL, ECASH_URL_FAVORITE];
    [ECashConnection connect:url parameters:parameters success:success failure:failure];
}

+ (void)getFavorite:(NSString*)type
       email_jsmart:(NSString*)email_jsmart
       token_jsmart:(NSString*)token_jsmart
            success:(void (^)(NSURLSessionTask *task, id responseObject))success
            failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure {
    NSDictionary* parameters = @{@"type" : type,
                                 @"email_jsmart" : email_jsmart,
                                 @"token_jsmart" : token_jsmart};
    [ECashConnection getFavorite_:parameters success:success failure:failure];
}

//// Inquiry Beli Pulsa

+ (void)inquireBeliPulsa_:(NSDictionary*)parameters
                  success:(void (^)(NSURLSessionTask *task, id responseObject))success
                  failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure {
    NSString* url = [NSString stringWithFormat:@"%@%@", ECASH_BASE_URL, ECASH_URL_TELCO_INQUIRY];
    [ECashConnection connect:url parameters:parameters success:success failure:failure];
}

+ (void)inquireBeliPulsa:(NSString*)msisdn
                   token:(NSString*)token
                toMember:(NSString*)toMember
                  amount:(NSString*)amount
          transferTypeID:(NSString*)transferTypeID
            email_jsmart:(NSString*)email_jsmart
            token_jsmart:(NSString*)token_jsmart
                 success:(void (^)(NSURLSessionTask *task, id responseObject))success
                 failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure {
    NSDictionary* parameters = @{@"msisdn" : msisdn,
                                 @"token" : token,
                                 @"toMember" : toMember,
                                 @"amount" : amount,
                                 @"transferTypeID" : transferTypeID,
                                 @"email_jsmart" : email_jsmart,
                                 @"token_jsmart" : token_jsmart};
    [ECashConnection inquireBeliPulsa_:parameters success:success failure:failure];
}

//// Payment Beli Pulsa

+ (void)payBeliPulsa_:(NSDictionary*)parameters
              success:(void (^)(NSURLSessionTask *task, id responseObject))success
              failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure {
    NSString* url = [NSString stringWithFormat:@"%@%@", ECASH_BASE_URL, ECASH_URL_TELCO_PAYMENT];
    [ECashConnection connect:url parameters:parameters success:success failure:failure];
}

+ (void)payBeliPulsa:(NSString*)msisdn
               token:(NSString*)token
            toMember:(NSString*)toMember
              amount:(NSString*)amount
      transferTypeID:(NSString*)transferTypeID
                 otp:(NSString*)otp
                 pin:(NSString*)pin
        email_jsmart:(NSString*)email_jsmart
        token_jsmart:(NSString*)token_jsmart
             success:(void (^)(NSURLSessionTask *task, id responseObject))success
             failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure {
    NSDictionary* parameters = @{@"msisdn" : msisdn,
                                 @"token" : token,
                                 @"toMember" : toMember,
                                 @"amount" : amount,
                                 @"transferTypeID" : transferTypeID,
                                 @"otp" : otp,
                                 @"pin" : pin,
                                 @"email_jsmart" : email_jsmart,
                                 @"token_jsmart" : token_jsmart};
    [ECashConnection payBeliPulsa_:parameters success:success failure:failure];

}

@end
