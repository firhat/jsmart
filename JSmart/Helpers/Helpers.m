//
//  Helpers.m
//  JSmart
//
//  Created by whcl on 30/06/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import "Helpers.h"

@implementation Helpers

+ (void)alertFailure:(NSString*)message viewController:(UIViewController*)viewController {
    NSString* failed = @"Failed";
    if (![Helpers isAppInEnglish]) {
        failed = @"Gagal";
    }
    UIAlertController* alert = [UIAlertController
                                 alertControllerWithTitle:failed
                                 message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* okButton = [UIAlertAction
                                actionWithTitle:@"OK"
                                style:UIAlertActionStyleDestructive
                                handler:nil];
    [alert addAction:okButton];
    [viewController presentViewController:alert animated:YES completion:nil];
}

+ (void)alertFailureWithCompletion:(NSString*)message viewController:(UIViewController*)viewController completion:(void(^)(UIAlertAction*))completion {
    NSString* failed = @"Failed";
    if (![Helpers isAppInEnglish]) {
        failed = @"Gagal";
    }

    UIAlertController* alert = [UIAlertController
                                alertControllerWithTitle:failed
                                message:message
                                preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDestructive
                               handler:completion];
    [alert addAction:okButton];
    [viewController presentViewController:alert animated:YES completion:nil];
}

+ (void)alertSuccess:(NSString*)message viewController:(UIViewController*)viewController {
    NSString* success = @"Success";
    if (![Helpers isAppInEnglish]) {
        success = @"Sukses";
    }
    UIAlertController* alert = [UIAlertController
                                alertControllerWithTitle:success
                                message:message
                                preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:nil];
    [alert addAction:okButton];
    [viewController presentViewController:alert animated:YES completion:nil];
}

+ (void)alertSuccessWithCompletion:(NSString*)message viewController:(UIViewController*)viewController completion:(void(^)(UIAlertAction*))completion {
    NSString* success = @"Success";
    if (![Helpers isAppInEnglish]) {
        success = @"Sukses";
    }
    UIAlertController* alert = [UIAlertController
                                alertControllerWithTitle:success
                                message:message
                                preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:completion];
    [alert addAction:okButton];
    [viewController presentViewController:alert animated:YES completion:nil];
}

+ (UIActivityIndicatorView*)getActivityIndicator:(UIViewController*)viewController {
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.center = CGPointMake(viewController.view.frame.size.width / 2.0, viewController.view.frame.size.height / 2.0);
    CGAffineTransform transform = CGAffineTransformMakeScale(3, 3);
    [activityIndicator setTransform:transform];
    [viewController.view addSubview: activityIndicator];
    return activityIndicator;
}

+ (NSMutableString *)getRandomString:(NSInteger)length {
    NSString *alphabet  = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXZY0123456789";
    NSMutableString *s = [NSMutableString stringWithCapacity:length];
    for (NSUInteger i = 0U; i < length; i++) {
        u_int32_t r = arc4random() % [alphabet length];
        unichar c = [alphabet characterAtIndex:r];
        [s appendFormat:@"%C", c];
    }
    return s;
}

+ (UIImage *)reduceImageSizeByPercentage:(CGFloat)percentage image:(UIImage *)image {
    CGFloat reducedWidth = image.size.width * percentage;
    CGFloat reducedHeight = image.size.height * percentage;
    CGSize size = CGSizeMake(reducedWidth, reducedHeight);
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (BOOL)doesPostContainAttachment:(id)post {
    id postImage = [[post objectForKey:@"images"] isKindOfClass:[NSNull class]] ? [[NSArray alloc] init] : [post objectForKey:@"images"];
    id postVideo = [[post objectForKey:@"videos"] isKindOfClass:[NSNull class]] ? [[NSArray alloc] init] : [post objectForKey:@"videos"];
    return ([postImage count] > 0 || [postVideo count] > 0);
}

//+ (UIImage *)reduceImageSizeUntilMaxSizeInKB:(CGFloat)maxSize image:(UIImage *)image {
//    CGFloat percentage = 0.5;
//    CGFloat maxSizeInBytes = maxSize * 1000;
//    UIImage* newImage;
//    do {
//        NSLog(@"Loop");
//        newImage = [Helpers reduceImageSizeByPercentage:percentage image:image];
//    } while ([UIImagePNGRepresentation(newImage) length] > maxSizeInBytes);
//    return newImage;
//}

+ (void)saveLoginInformation:(NSString *)email token:(NSString *)token {
    [[NSUserDefaults standardUserDefaults] setObject:email forKey:@"email"];
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"token"];
    [[NSUserDefaults standardUserDefaults] setObject:@"VALID" forKey:@"validity"];
}

+ (void)removeLoginInformation {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"email"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
    [[NSUserDefaults standardUserDefaults] setObject:@"INVALID" forKey:@"validity"];
}

+ (BOOL)isAppInEnglish {
    return [[[NSLocale currentLocale] localeIdentifier] containsString:@"en"];
}

+ (double)getSizeInMB:(NSURL *)url {
    double length = (double)[[[NSData alloc] initWithContentsOfURL:url] length];
    return length / 1048576;
}

+ (Float64)getDurationOfVideoInSeconds:(NSURL *)url {
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:url options:nil];
    return CMTimeGetSeconds(asset.duration);
}

@end
