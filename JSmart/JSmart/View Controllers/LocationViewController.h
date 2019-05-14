//
//  LocationViewController.h
//  JSmart
//
//  Created by whcl on 29/06/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Helpers.h"
#import "Connection.h"
#import "TimelineViewController.h"
#import "LaporanViewController.h"

@interface LocationViewController : UIViewController<MKMapViewDelegate>

@property id post;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

- (IBAction)back:(UIButton *)sender;

@end
