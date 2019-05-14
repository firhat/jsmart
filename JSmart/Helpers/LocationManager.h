//
//  LocationManager.h
//  JSmart
//
//  Created by whcl on 02/07/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol LocationManagerDelegate <NSObject>

- (void)locationReceived:(CLLocation*)location;
- (void)placemarkReceived:(CLPlacemark*)placemark;

@end

@interface LocationManager : NSObject <CLLocationManagerDelegate>

@property id<LocationManagerDelegate> delegate;
@property CLLocationManager* locationManager;
@property CLGeocoder* geocoder;

- (void)getCurrentLocation;

@end
