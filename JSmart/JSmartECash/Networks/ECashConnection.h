//
//  ECashConnection.h
//  JSmart
//
//  Created by whcl on 11/09/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "ECashEndpoints.h"

@interface ECashConnection : NSObject

+ (void)connect:(NSString*)url
     parameters:(NSDictionary*)parameters
        success:(void (^)(NSURLSessionTask *task, id responseObject))success
        failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

////    Login

+ (void)login_:(NSDictionary*)parameters
       success:(void (^)(NSURLSessionTask *task, id responseObject))success
       failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

+ (void)login:(NSString*)email
     password:(NSString*)password
      success:(void (^)(NSURLSessionTask *task, id responseObject))success
      failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

//// Get Denomination

+ (void)getDenomination_:(NSDictionary*)parameters
                 success:(void (^)(NSURLSessionTask *task, id responseObject))success
                 failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

+ (void)getDenomination:(NSString*)msisdn
                  token:(NSString*)token
                    ver:(NSString*)ver
           email_jsmart:(NSString*)email_jsmart
           token_jsmart:(NSString*)token_jsmart
                success:(void (^)(NSURLSessionTask *task, id responseObject))success
                failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

//// Inquire Topup

+ (void)inquireTopup_:(NSDictionary*)parameters
              success:(void (^)(NSURLSessionTask *task, id responseObject))success
              failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

+ (void)inquireTopup:(NSString*)msisdn
               token:(NSString*)token
                 bin:(NSString*)bin
              amount:(NSString*)amount
        email_jsmart:(NSString*)email_jsmart
        token_jsmart:(NSString*)token_jsmart
             success:(void (^)(NSURLSessionTask *task, id responseObject))success
             failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

//// Get Register Ticket

+ (void)getRegisterTicket_:(NSDictionary*)parameters
                   success:(void (^)(NSURLSessionTask *task, id responseObject))success
                   failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

+ (void)getRegisterTicket:(NSString*)mobileno
                    token:(NSString*)token
             email_jsmart:(NSString*)email_jsmart
             token_jsmart:(NSString*)token_jsmart
             success:(void (^)(NSURLSessionTask *task, id responseObject))success
             failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

//// Profile Inquiry

+ (void)inquireProfile_:(NSDictionary*)parameters
                success:(void (^)(NSURLSessionTask *task, id responseObject))success
                failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

+ (void)inquireProfile:(NSString*)msisdn
                 token:(NSString*)token
          email_jsmart:(NSString*)email_jsmart
          token_jsmart:(NSString*)token_jsmart
               success:(void (^)(NSURLSessionTask *task, id responseObject))success
               failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

//// Balance Inquiry

+ (void)inquireBalance_:(NSDictionary*)parameters
                success:(void (^)(NSURLSessionTask *task, id responseObject))success
                failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

+ (void)inquireBalance:(NSString*)msisdn
                 token:(NSString*)token
          email_jsmart:(NSString*)email_jsmart
          token_jsmart:(NSString*)token_jsmart
               success:(void (^)(NSURLSessionTask *task, id responseObject))success
               failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

//// Get Transaction History

+ (void)getTransactionHistory_:(NSDictionary*)parameters
                       success:(void (^)(NSURLSessionTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

+ (void)getTransactionHistory:(NSString*)msisdn
                        token:(NSString*)token
                  currentPage:(NSString*)currentPage
                     pageSize:(NSString*)pageSize
                    startDate:(NSString*)startDate
                      endDate:(NSString*)endDate
                 email_jsmart:(NSString*)email_jsmart
                 token_jsmart:(NSString*)token_jsmart
               success:(void (^)(NSURLSessionTask *task, id responseObject))success
               failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

//// Get Beli Pulsa Denomination

+ (void)getBeliPulsaDenomination_:(NSDictionary*)parameters
                          success:(void (^)(NSURLSessionTask *task, id responseObject))success
                          failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

+ (void)getBeliPulsaDenomination:(NSString*)msisdn
                           token:(NSString*)token
                        toMember:(NSString*)toMember
                    email_jsmart:(NSString*)email_jsmart
                    token_jsmart:(NSString*)token_jsmart
                         success:(void (^)(NSURLSessionTask *task, id responseObject))success
                         failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

//// Set Favorite

+ (void)setFavorite_:(NSDictionary*)parameters
             success:(void (^)(NSURLSessionTask *task, id responseObject))success
             failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

+ (void)setFavorite:(NSString*)nomor_favorite
        nama_kontak:(NSString*)nama_kontak
               type:(NSString*)type
       email_jsmart:(NSString*)email_jsmart
       token_jsmart:(NSString*)token_jsmart
            success:(void (^)(NSURLSessionTask *task, id responseObject))success
            failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

//// Get Favorite

+ (void)getFavorite_:(NSDictionary*)parameters
             success:(void (^)(NSURLSessionTask *task, id responseObject))success
             failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

+ (void)getFavorite:(NSString*)type
       email_jsmart:(NSString*)email_jsmart
       token_jsmart:(NSString*)token_jsmart
            success:(void (^)(NSURLSessionTask *task, id responseObject))success
            failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

//// Inquiry Beli Pulsa

+ (void)inquireBeliPulsa_:(NSDictionary*)parameters
                  success:(void (^)(NSURLSessionTask *task, id responseObject))success
                  failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

+ (void)inquireBeliPulsa:(NSString*)msisdn
                   token:(NSString*)token
                toMember:(NSString*)toMember
                  amount:(NSString*)amount
          transferTypeID:(NSString*)transferTypeID
            email_jsmart:(NSString*)email_jsmart
            token_jsmart:(NSString*)token_jsmart
                 success:(void (^)(NSURLSessionTask *task, id responseObject))success
                 failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

//// Payment Beli Pulsa

+ (void)payBeliPulsa_:(NSDictionary*)parameters
              success:(void (^)(NSURLSessionTask *task, id responseObject))success
              failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

+ (void)payBeliPulsa:(NSString*)msisdn
               token:(NSString*)token
            toMember:(NSString*)toMember
              amount:(NSString*)amount
      transferTypeID:(NSString*)transferTypeID
        email_jsmart:(NSString*)email_jsmart
        token_jsmart:(NSString*)token_jsmart
                 otp:(NSString*)otp
                 pin:(NSString*)pin
             success:(void (^)(NSURLSessionTask *task, id responseObject))success
             failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

@end
