//
//  Connection.m
//  JSmart
//
//  Created by whcl on 30/06/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import "Connection.h"

@implementation Connection

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
    
+ (void)signIn_:(NSDictionary*)parameters
       success:(void (^)(NSURLSessionTask *task, id responseObject))success
       failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure {
    NSString* url = [NSString stringWithFormat:@"%@%@", BASE_URL, URL_SIGN_IN];
    [Connection connect:url parameters:parameters success:success failure:failure];
}

+ (void)signIn:(NSString *)email
      password:(NSString *)password
       success:(void (^)(NSURLSessionTask *, id))success
       failure:(void (^)(NSURLSessionTask *, NSError *))failure {
    NSDictionary* parameters = @{@"email" : email,
                                 @"password" : password};
    [Connection signIn_:parameters success:success failure:failure];
}

+ (void)signInWithSocialMedia_:(NSDictionary *)parameters success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure {
    NSString* url = [NSString stringWithFormat:@"%@%@", BASE_URL, URL_SIGN_IN_WITH_SOCIAL_MEDIA];
    [Connection connect:url parameters:parameters success:success failure:failure];
}

+ (void)signInWithSocialMedia:(NSString *)email name:(NSString *)name success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure {
    NSDictionary* parameters = @{@"email" : email,
                                 @"nama" : name};
    [Connection signInWithSocialMedia_:parameters success:success failure:failure];
}

+ (void)signUp_:(NSDictionary*)parameters
       success:(void (^)(NSURLSessionTask *task, id responseObject))success
       failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure {
    NSString* url = [NSString stringWithFormat:@"%@%@", BASE_URL, URL_SIGN_UP];
    [Connection connect:url parameters:parameters success:success failure:failure];
}

+ (void)signUp:(NSString *)name
         email:(NSString *)email
      password:(NSString *)password
confirmationPassword:(NSString *)confirmationPassword
       success:(void (^)(NSURLSessionTask *, id))success
       failure:(void (^)(NSURLSessionTask *, NSError *))failure {
    NSDictionary* parameters = @{@"nama" : name,
                                 @"email" : email,
                                 @"password" : password,
                                 @"ulangi_password" : confirmationPassword};
    [Connection signUp_:parameters success:success failure:failure];
}

+ (void)getCategory_:(NSDictionary*)parameters
            success:(void (^)(NSURLSessionTask *task, id responseObject))success
            failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure {
    NSString* url = [NSString stringWithFormat:@"%@%@", BASE_URL, URL_GET_CATEGORY];
    [Connection connect:url parameters:parameters success:success failure:failure];
}

+ (void)getCategory:(NSString*)email
              token:(NSString*)token
            success:(void (^)(NSURLSessionTask *, id))success
            failure:(void (^)(NSURLSessionTask *, NSError *))failure {
    NSDictionary* parameters = @{@"email" : email,
                                 @"token" : token};
    [Connection getCategory_:parameters success:success failure:failure];
}

+ (void)getUser_:(NSDictionary *)parameters success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure {
    NSString* url = [NSString stringWithFormat:@"%@%@", BASE_URL, URL_GET_USER];
    [Connection connect:url parameters:parameters success:success failure:failure];
}

+ (void)getUser:(NSString *)email token:(NSString *)token success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure {
    NSDictionary* parameters = @{@"email" : email,
                                 @"token" : token};
    [Connection getUser_:parameters success:success failure:failure];
}

+ (void)getPoint_:(NSDictionary *)parameters success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure {
    NSString* url = [NSString stringWithFormat:@"%@%@", BASE_URL, URL_GET_POINT];
    [Connection connect:url parameters:parameters success:success failure:failure];
}

+ (void)getPoint:(NSString *)email token:(NSString *)token success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure {
    NSDictionary* parameters = @{@"email" : email,
                                 @"token" : token};
    [Connection getPoint_:parameters success:success failure:failure];
}

+ (void)getRank_:(NSDictionary *)parameters success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure {
    NSString* url = [NSString stringWithFormat:@"%@%@", BASE_URL, URL_GET_RANK];
    [Connection connect:url parameters:parameters success:success failure:failure];
}

+ (void)getRank:(NSString *)email token:(NSString *)token success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure {
    NSDictionary* parameters = @{@"email" : email,
                                 @"token" : token};
    [Connection getRank_:parameters success:success failure:failure];
}

+ (void)uploadVideo_:(NSDictionary *)parameters endpoint:(NSString *)endpoint name:(NSString *)name urlVideo:(NSURL *)urlVideo handler:(void (^)(NSURLResponse * _Nonnull, id _Nullable, NSError * _Nullable))handler {
    NSString* fileName = [[urlVideo absoluteString] lastPathComponent];
    NSURL* url = [[NSURL fileURLWithPath:NSTemporaryDirectory()] URLByAppendingPathComponent:fileName];
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer]
                                    multipartFormRequestWithMethod:@"POST"
                                    URLString:endpoint
                                    parameters:parameters
                                    constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                        [formData
                                         appendPartWithFileURL:url
                                         name:name
                                         fileName:fileName
                                         mimeType:@"video/quicktime"
                                         error:nil];
                                    }
                                    error:nil];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:nil
                  completionHandler:handler];
    [uploadTask resume];

}

+ (void)uploadPicture_:(NSDictionary *)parameters endpoint:(NSString *)endpoint name:(NSString *)name image:(UIImage *)image handler:(void (^)(NSURLResponse * _Nonnull, id _Nullable, NSError * _Nullable))handler {
    NSString* fileName = [NSString stringWithFormat:@"%@.png", [Helpers getRandomString:20]];
    NSURL* url = [[NSURL fileURLWithPath:NSTemporaryDirectory()] URLByAppendingPathComponent:fileName];
    [UIImagePNGRepresentation(image) writeToURL:url atomically:YES];
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer]
                                    multipartFormRequestWithMethod:@"POST"
                                    URLString:endpoint
                                    parameters:parameters
                                    constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                        [formData
                                         appendPartWithFileURL:url
                                         name:name
                                         fileName:fileName
                                         mimeType:@"image/png"
                                         error:nil];
                                    }
                                    error:nil];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:nil
                  completionHandler:handler];
    [uploadTask resume];
}

+ (void)uploadPicture:(NSString *)email token:(NSString *)token image:(UIImage *)image handler:(void (^)(NSURLResponse * _Nonnull, id _Nullable, NSError * _Nullable))handler {
    NSDictionary* parameters = @{@"email" : email,
                                 @"token" : token};
    NSString* endpoint = [NSString stringWithFormat:@"%@%@", BASE_URL, URL_CHANGE_PROFILE];
    NSString* name = @"userfile";
    [Connection uploadPicture_:parameters endpoint:endpoint name:name image:image handler:handler];
}

+ (void)saveProfile_:(NSDictionary *)parameters success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure {
    NSString* url = [NSString stringWithFormat:@"%@%@", BASE_URL, URL_CHANGE_PROFILE];
    [Connection connect:url parameters:parameters success:success failure:failure];
}

+ (void)saveProfile:(NSString *)email token:(NSString *)token name:(NSString *)name phone:(NSString *)phone oldPassword:(NSString *)oldPassword newPassword:(NSString *)newPassword newConfirmationPassword:(NSString *)newConfirmationPassword success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure {
    NSDictionary* parameters = @{@"email"           : email,
                                 @"token"           : token,
                                 @"nama"            : name,
                                 @"telp"            : phone,
                                 @"password_lama"   : oldPassword,
                                 @"password"        : newPassword,
                                 @"ulangi_password" : newConfirmationPassword};
    [Connection saveProfile_:parameters success:success failure:failure];
}

+ (void)getNotification_:(NSDictionary *)parameters success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure {
    NSString* url = [NSString stringWithFormat:@"%@%@", BASE_URL, URL_GET_NOTIFICATIONS];
    [Connection connect:url parameters:parameters success:success failure:failure];
}

+ (void)getNotification:(NSString *)email token:(NSString *)token page:(NSNumber*)page success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure {
    NSDictionary* parameters = @{@"email" : email,
                                 @"token" : token,
                                 @"page" : page};
    [Connection getNotification_:parameters success:success failure:failure];
}

+ (void)submitLaporanWithAttachmentNone_:(NSDictionary *)parameters success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure {
    NSString* url = [NSString stringWithFormat:@"%@%@", BASE_URL, URL_LAPOR];
    [Connection connect:url parameters:parameters success:success failure:failure];
}

+ (void)submitLaporanWithAttachmentNone:(NSString *)email token:(NSString *)token idCategory:(NSNumber *)idCategory title:(NSString *)title content:(NSString *)content latitude:(NSNumber *)latitude longitude:(NSNumber *)longitude address:(NSString *)address kelurahan:(NSString *)kelurahan kecamatan:(NSString *)kecamatan kota:(NSString *)kota success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure {
    NSDictionary* parameters = @{@"email"           : email,
                                 @"token"           : token,
                                 @"id_kategori"     : idCategory,
                                 @"judul_laporan"   : title,
                                 @"isi_laporan"     : content,
                                 @"latitude"        : latitude,
                                 @"longitude"       : longitude,
                                 @"alamat"          : address,
                                 @"kelurahan"       : kelurahan,
                                 @"kecamatan"       : kecamatan,
                                 @"kota"            : kota};
    [Connection submitLaporanWithAttachmentNone_:parameters success:success failure:failure];
}

+ (void)submitLaporanWithAttachmentImage:(NSString *)email token:(NSString *)token idCategory:(NSNumber *)idCategory title:(NSString *)title content:(NSString *)content latitude:(NSNumber *)latitude longitude:(NSNumber *)longitude address:(NSString *)address kelurahan:(NSString *)kelurahan kecamatan:(NSString *)kecamatan kota:(NSString *)kota image:(UIImage *)image handler:(void (^)(NSURLResponse * _Nonnull, id _Nullable, NSError * _Nullable))handler {
    NSDictionary* parameters = @{@"email"           : email,
                                 @"token"           : token,
                                 @"id_kategori"     : idCategory,
                                 @"judul_laporan"   : title,
                                 @"isi_laporan"     : content,
                                 @"latitude"        : latitude,
                                 @"longitude"       : longitude,
                                 @"alamat"          : address,
                                 @"kelurahan"       : kelurahan,
                                 @"kecamatan"       : kecamatan,
                                 @"kota"            : kota};
    NSString* endpoint = [NSString stringWithFormat:@"%@%@", BASE_URL, URL_LAPOR];
    NSString* name = @"userfile";
    [Connection uploadPicture_:parameters endpoint:endpoint name:name image:image handler:handler];
}

+ (void)submitLaporanWithAttachmentVideo:(NSString *)email token:(NSString *)token idCategory:(NSNumber *)idCategory title:(NSString *)title content:(NSString *)content latitude:(NSNumber *)latitude longitude:(NSNumber *)longitude address:(NSString *)address kelurahan:(NSString *)kelurahan kecamatan:(NSString *)kecamatan kota:(NSString *)kota urlVideo:(NSURL *)urlVideo handler:(void (^)(NSURLResponse * _Nonnull, id _Nullable, NSError * _Nullable))handler {
    NSDictionary* parameters = @{@"email"           : email,
                                 @"token"           : token,
                                 @"id_kategori"     : idCategory,
                                 @"judul_laporan"   : title,
                                 @"isi_laporan"     : content,
                                 @"latitude"        : latitude,
                                 @"longitude"       : longitude,
                                 @"alamat"          : address,
                                 @"kelurahan"       : kelurahan,
                                 @"kecamatan"       : kecamatan,
                                 @"kota"            : kota};
    NSString* endpoint = [NSString stringWithFormat:@"%@%@", BASE_URL, URL_LAPOR];
    NSString* name = @"userfile";
    [Connection uploadVideo_:parameters endpoint:endpoint name:name urlVideo:urlVideo handler:handler];
}

+ (void)getTimelinePost_:(NSDictionary *)parameters success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure {
    NSString* url = [NSString stringWithFormat:@"%@%@", BASE_URL, URL_GET_TIMELINE_POST];
    [Connection connect:url parameters:parameters success:success failure:failure];
}

+ (void)getTimelinePost:(NSString *)email token:(NSString *)token page:(NSNumber *)page success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure {
    NSDictionary* parameters = @{@"email"   : email,
                                 @"token"   : token,
                                 @"page"    : page};
    [Connection getTimelinePost_:parameters success:success failure:failure];
}

+ (void)getMapPost_:(NSDictionary *)parameters success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure {
    NSString* url = [NSString stringWithFormat:@"%@%@", BASE_URL, URL_GET_MAP_POST];
    [Connection connect:url parameters:parameters success:success failure:failure];
}

+ (void)getMapPost:(NSString *)email token:(NSString *)token page:(NSNumber *)page success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure {
    NSDictionary* parameters = @{@"email"   : email,
                                 @"token"   : token,
                                 @"page"    : page};
    [Connection getMapPost_:parameters success:success failure:failure];
}

+ (void)getComment_:(NSDictionary *)parameters success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure {
    NSString* url = [NSString stringWithFormat:@"%@%@", BASE_URL, URL_GET_COMMENT];
    [Connection connect:url parameters:parameters success:success failure:failure];
}

+ (void)getComment:(NSString *)email token:(NSString *)token idLaporan:(NSNumber *)idLaporan success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure {
    NSDictionary* parameters = @{@"email"       : email,
                                 @"token"       : token,
                                 @"id_laporan"  : idLaporan};
    [Connection getComment_:parameters success:success failure:failure];
}

+ (void)getInformation_:(NSDictionary *)parameters success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure {
    NSString* url = [NSString stringWithFormat:@"%@%@", BASE_URL, URL_GET_INFORMATION];
    [Connection connect:url parameters:parameters success:success failure:failure];
}

+ (void)getInformation:(NSString *)email token:(NSString *)token page:(NSNumber *)page success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure {
    NSDictionary* parameters = @{@"email"   : email,
                                 @"token"   : token,
                                 @"page"    : page};
    [Connection getInformation_:parameters success:success failure:failure];
}

+ (void)getPost_:(NSDictionary *)parameters success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure {
    NSString* url = [NSString stringWithFormat:@"%@%@", BASE_URL, URL_GET_POST];
    [Connection connect:url parameters:parameters success:success failure:failure];
}

+ (void)getPost:(NSString *)email token:(NSString *)token idLaporan:(NSNumber *)idLaporan success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure {
    NSDictionary* parameters = @{@"email"       : email,
                                 @"token"       : token,
                                 @"id_laporan"  : idLaporan};
    [Connection getPost_:parameters success:success failure:failure];
}

+ (void)submitCommentWithAttachmentNone_:(NSDictionary *)parameters success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure {
    NSString* url = [NSString stringWithFormat:@"%@%@", BASE_URL, URL_SEND_COMMENT];
    [Connection connect:url parameters:parameters success:success failure:failure];
}

+ (void)submitCommentWithAttachmentNone:(NSString *)email token:(NSString *)token idLaporan:(NSNumber *)idLaporan comment:(NSString *)comment success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure {
    NSDictionary* parameters = @{@"email"       : email,
                                 @"token"       : token,
                                 @"id_laporan"  : idLaporan,
                                 @"komentar"    : comment};
    [Connection submitCommentWithAttachmentNone_:parameters success:success failure:failure];
}

+ (void)submitCommentWithAttachmentImage:(NSString *)email token:(NSString *)token idLaporan:(NSNumber *)idLaporan comment:(NSString *)comment image:(UIImage *)image handler:(void (^)(NSURLResponse * _Nonnull, id _Nullable, NSError * _Nullable))handler {
    NSDictionary* parameters = @{@"email"       : email,
                                 @"token"       : token,
                                 @"id_laporan"  : idLaporan,
                                 @"komentar"    : comment};
    NSString* endpoint = [NSString stringWithFormat:@"%@%@", BASE_URL, URL_SEND_COMMENT];
    NSString* name = @"userfile";
    [Connection uploadPicture_:parameters endpoint:endpoint name:name image:image handler:handler];
}

+ (void)markNotificationAsRead_:(NSDictionary *)parameters success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure {
    NSString* url = [NSString stringWithFormat:@"%@%@", BASE_URL, URL_READ_NOTIFICATION];
    [Connection connect:url parameters:parameters success:success failure:failure];
}

+ (void)markNotificationAsRead:(NSString *)email token:(NSString *)token idNotification:(NSNumber *)idNotification success:(void (^)(NSURLSessionTask *, id))success failure:(void (^)(NSURLSessionTask *, NSError *))failure {
    NSDictionary* parameters = @{@"email"           : email,
                                 @"token"           : token,
                                 @"id_notifikasi"   : idNotification};
    [Connection markNotificationAsRead_:parameters success:success failure:failure];
}

@end
