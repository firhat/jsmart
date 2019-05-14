//
//  LocationManager.m
//  JSmart
//
//  Created by whcl on 02/07/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import "LocationManager.h"

@implementation LocationManager

- (instancetype)init {
    self.locationManager = [[CLLocationManager alloc] init];
    self.geocoder = [[CLGeocoder alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    [self.locationManager requestWhenInUseAuthorization];
    return self;
}

- (void)getCurrentLocation {
    [self.locationManager startUpdatingLocation];
}

#pragma Delegates

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    [self.locationManager stopUpdatingLocation];
    [self.delegate locationReceived:newLocation];
    [self.geocoder
     reverseGeocodeLocation:newLocation
     completionHandler:^(NSArray *placemarks, NSError *error) {
         if (error == nil && [placemarks count] > 0) {
             [self.delegate placemarkReceived:[placemarks lastObject]];
        } else {
            NSLog(@"%@", error.debugDescription);
        }
    }];
}

@end
