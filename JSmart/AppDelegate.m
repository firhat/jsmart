//
//  AppDelegate.m
//  JSmart
//
//  Created by whcl on 27/06/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    [GIDSignIn sharedInstance].clientID = @"784625136854-22rfoh1lbvrdm3errcf2mtb258hqkq9v.apps.googleusercontent.com";
    // Override point for customization after application launch.
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    BOOL handled = [[FBSDKApplicationDelegate sharedInstance]
                    application:app
                    openURL:url
                    sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                    annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
//    BOOL handled = [[GIDSignIn sharedInstance] handleURL:url
//                                       sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
//                                              annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
    return handled;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
