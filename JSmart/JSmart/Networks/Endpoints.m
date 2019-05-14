//
//  Endpoints.m
//  JSmart
//
//  Created by whcl on 30/06/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import "Endpoints.h"

@implementation Endpoints

NSString* BASE_URL                                = @"https://jsmart.id/api/";
NSString* URL_SIGN_UP                             = @"auth/registration";
NSString* URL_SIGN_IN                             = @"auth/login";
NSString* URL_SIGN_IN_WITH_SOCIAL_MEDIA           = @"auth/login_by";
NSString* URL_GET_CATEGORY                        = @"kategori";
NSString* URL_GET_USER                            = @"user/detail";
NSString* URL_GET_POINT                           = @"gamification/user_point";
NSString* URL_GET_RANK                            = @"gamification/user_ranking";
NSString* URL_CHANGE_PROFILE                      = @"user/update_profile";
NSString* URL_GET_NOTIFICATIONS                   = @"notifikasi/get";
NSString* URL_LAPOR                               = @"laporan/insert";
NSString* URL_GET_TIMELINE_POST                   = @"laporan/user_timeline";
NSString* URL_GET_MAP_POST                        = @"laporan/map";
NSString* URL_GET_POST                            = @"laporan/detail";
NSString* URL_GET_COMMENT                         = @"laporan/komentar";
NSString* URL_SEND_COMMENT                        = @"laporan/insert_komentar";
NSString* URL_GET_INFORMATION                     = @"informasi";
NSString* URL_READ_NOTIFICATION                   = @"notifikasi/read";

@end
