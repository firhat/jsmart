//
//  Helpers.h
//  JSmart
//
//  Created by whcl on 30/06/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@interface Helpers : UIView

+ (void)alertFailure:(NSString*)message
      viewController:(UIViewController*)viewController;

+ (void)alertFailureWithCompletion:(NSString*)message
                    viewController:(UIViewController*)viewController
                        completion:(void(^)(UIAlertAction*))completion;

+ (void)alertSuccess:(NSString*)message
      viewController:(UIViewController*)viewController;

+ (void)alertSuccessWithCompletion:(NSString*)message
                    viewController:(UIViewController*)viewController
                        completion:(void(^)(UIAlertAction*))completion;

+ (UIActivityIndicatorView*)getActivityIndicator:(UIViewController*)viewController;

+ (NSMutableString*)getRandomString:(NSInteger)length;

+ (UIImage*)reduceImageSizeByPercentage:(CGFloat)percentage image:(UIImage*)image;

//+ (UIImage*)reduceImageSizeUntilMaxSizeInKB:(CGFloat)maxSize image:(UIImage*)image;

+ (BOOL)doesPostContainAttachment:(id)post;

+ (void)saveLoginInformation:(NSString*)email token:(NSString*)token;

+ (void)removeLoginInformation;

+ (BOOL)isAppInEnglish;

+ (double)getSizeInMB:(NSURL*)url;

+ (Float64)getDurationOfVideoInSeconds:(NSURL*)url;

@end
