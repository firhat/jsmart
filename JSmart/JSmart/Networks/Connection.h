//
//  Connection.h
//  JSmart
//
//  Created by whcl on 30/06/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "Endpoints.h"
#import "Helpers.h"

@interface Connection : NSObject

+ (void)connect:(NSString*)url
     parameters:(NSDictionary*)parameters
        success:(void (^)(NSURLSessionTask *task, id responseObject))success
        failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

+ (void)signIn_:(NSDictionary*)parameters
       success:(void (^)(NSURLSessionTask *task, id responseObject))success
       failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

+ (void)signIn:(NSString*)email
      password:(NSString*)password
       success:(void (^)(NSURLSessionTask *task, id responseObject))success
       failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

+ (void)signInWithSocialMedia_:(NSDictionary*)parameters
                       success:(void (^)(NSURLSessionTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

+ (void)signInWithSocialMedia:(NSString*)email
                         name:(NSString*)name
                      success:(void (^)(NSURLSessionTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

+ (void)signUp_:(NSDictionary*)parameters
       success:(void (^)(NSURLSessionTask *task, id responseObject))success
       failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

+ (void)signUp:(NSString*)name
         email:(NSString*)email
      password:(NSString*)password
confirmationPassword:(NSString*)confirmationPassword
       success:(void (^)(NSURLSessionTask *task, id responseObject))success
       failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

+ (void)getCategory_:(NSDictionary*)parameters
       success:(void (^)(NSURLSessionTask *task, id responseObject))success
       failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

+ (void)getCategory:(NSString*)email
              token:(NSString*)token
            success:(void (^)(NSURLSessionTask *, id))success
            failure:(void (^)(NSURLSessionTask *, NSError *))failure;

+ (void)getUser_:(NSDictionary*)parameters
         success:(void (^)(NSURLSessionTask *task, id responseObject))success
         failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

+ (void)getUser:(NSString*)email
          token:(NSString*)token
        success:(void (^)(NSURLSessionTask *task, id responseObject))success
        failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

+ (void)getPoint_:(NSDictionary*)parameters
         success:(void (^)(NSURLSessionTask *task, id responseObject))success
         failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

+ (void)getPoint:(NSString*)email
          token:(NSString*)token
        success:(void (^)(NSURLSessionTask *task, id responseObject))success
        failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

+ (void)getRank_:(NSDictionary*)parameters
         success:(void (^)(NSURLSessionTask *task, id responseObject))success
         failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

+ (void)getRank:(NSString*)email
          token:(NSString*)token
        success:(void (^)(NSURLSessionTask *task, id responseObject))success
        failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

+ (void)uploadVideo_:(NSDictionary*)parameters
            endpoint:(NSString*)endpoint
                name:(NSString*)name
            urlVideo:(NSURL*)urlVideo
             handler:(void (^)(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error))handler;

+ (void)uploadPicture_:(NSDictionary*)parameters
              endpoint:(NSString*)endpoint
                  name:(NSString*)name
                 image:(UIImage*)image
               handler:(void (^)(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error))handler;

+ (void)uploadPicture:(NSString*)email
                token:(NSString*)token
                image:(UIImage*)image
              handler:(void (^)(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error))handler;

+ (void)saveProfile_:(NSDictionary*)parameters
         success:(void (^)(NSURLSessionTask *task, id responseObject))success
         failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

+ (void)saveProfile:(NSString*)email
              token:(NSString*)token
               name:(NSString*)name
              phone:(NSString*)phone
        oldPassword:(NSString*)oldPassword
        newPassword:(NSString*)newPassword
newConfirmationPassword:(NSString*)newConfirmationPassword
            success:(void (^)(NSURLSessionTask *task, id responseObject))success
            failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

+ (void)getNotification_:(NSDictionary*)parameters
                 success:(void (^)(NSURLSessionTask *task, id responseObject))success
                 failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

+ (void)getNotification:(NSString*)email
                  token:(NSString*)token
                   page:(NSNumber*)page
                success:(void (^)(NSURLSessionTask *task, id responseObject))success
                failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

+ (void)submitLaporanWithAttachmentNone_:(NSDictionary*)parameters
                                 success:(void (^)(NSURLSessionTask *task, id responseObject))success
                                 failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

+ (void)submitLaporanWithAttachmentNone:(NSString*)email
                                  token:(NSString*)token
                             idCategory:(NSNumber*)idCategory
                                  title:(NSString*)title
                                content:(NSString*)content
                               latitude:(NSNumber*)latitude
                              longitude:(NSNumber*)longitude
                                address:(NSString*)address
                              kelurahan:(NSString*)kelurahan
                              kecamatan:(NSString*)kecamatan
                                   kota:(NSString*)kota
                                success:(void (^)(NSURLSessionTask *task, id responseObject))success
                                failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

+ (void)submitLaporanWithAttachmentImage:(NSString*)email
                                   token:(NSString*)token
                              idCategory:(NSNumber*)idCategory
                                   title:(NSString*)title
                                 content:(NSString*)content
                                latitude:(NSNumber*)latitude
                               longitude:(NSNumber*)longitude
                                 address:(NSString*)address
                               kelurahan:(NSString*)kelurahan
                               kecamatan:(NSString*)kecamatan
                                    kota:(NSString*)kota
                                   image:(UIImage*)image
                                 handler:(void (^)(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error))handler;

+ (void)submitLaporanWithAttachmentVideo:(NSString*)email
                                   token:(NSString*)token
                              idCategory:(NSNumber*)idCategory
                                   title:(NSString*)title
                                 content:(NSString*)content
                                latitude:(NSNumber*)latitude
                               longitude:(NSNumber*)longitude
                                 address:(NSString*)address
                               kelurahan:(NSString*)kelurahan
                               kecamatan:(NSString*)kecamatan
                                    kota:(NSString*)kota
                                urlVideo:(NSURL*)urlVideo
                                 handler:(void (^)(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error))handler;

+ (void)getTimelinePost_:(NSDictionary*)parameters
                 success:(void (^)(NSURLSessionTask *task, id responseObject))success
                 failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

+ (void)getTimelinePost:(NSString*)email
                  token:(NSString*)token
                   page:(NSNumber*)page
                success:(void (^)(NSURLSessionTask *task, id responseObject))success
                failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

+ (void)getMapPost_:(NSDictionary*)parameters
            success:(void (^)(NSURLSessionTask *task, id responseObject))success
            failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

+ (void)getMapPost:(NSString*)email
             token:(NSString*)token
              page:(NSNumber*)page
           success:(void (^)(NSURLSessionTask *task, id responseObject))success
           failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

+ (void)getComment_:(NSDictionary*)parameters
            success:(void (^)(NSURLSessionTask *task, id responseObject))success
            failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

+ (void)getComment:(NSString*)email
             token:(NSString*)token
         idLaporan:(NSNumber*)idLaporan
           success:(void (^)(NSURLSessionTask *task, id responseObject))success
           failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

+ (void)getInformation_:(NSDictionary*)parameters
                success:(void (^)(NSURLSessionTask *task, id responseObject))success
                failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

+ (void)getInformation:(NSString*)email
                 token:(NSString*)token
                  page:(NSNumber*)page
               success:(void (^)(NSURLSessionTask *task, id responseObject))success
               failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

+ (void)getPost_:(NSDictionary*)parameters
         success:(void (^)(NSURLSessionTask *task, id responseObject))success
         failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

+ (void)getPost:(NSString*)email
          token:(NSString*)token
      idLaporan:(NSNumber*)idLaporan
        success:(void (^)(NSURLSessionTask *task, id responseObject))success
        failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

+ (void)submitCommentWithAttachmentNone_:(NSDictionary*)parameters
                                 success:(void (^)(NSURLSessionTask *task, id responseObject))success
                                 failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

+ (void)submitCommentWithAttachmentNone:(NSString*)email
                                  token:(NSString*)token
                              idLaporan:(NSNumber*)idLaporan
                                comment:(NSString*)comment
                                success:(void (^)(NSURLSessionTask *task, id responseObject))success
                                failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

+ (void)submitCommentWithAttachmentImage:(NSString*)email
                                   token:(NSString*)token
                               idLaporan:(NSNumber*)idLaporan
                                 comment:(NSString*)comment
                                   image:(UIImage*)image
                                 handler:(void (^)(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error))handler;

+ (void)markNotificationAsRead_:(NSDictionary*)parameters
                        success:(void (^)(NSURLSessionTask *task, id responseObject))success
                        failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

+ (void)markNotificationAsRead:(NSString*)email
                         token:(NSString*)token
                idNotification:(NSNumber*)idNotification
                       success:(void (^)(NSURLSessionTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

@end
