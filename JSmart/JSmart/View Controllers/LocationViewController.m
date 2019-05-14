//
//  LocationViewController.m
//  JSmart
//
//  Created by whcl on 29/06/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import "LocationViewController.h"

@interface LocationViewController ()

@property NSMutableArray* posts;
@property NSInteger page;

@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.posts = [[NSMutableArray alloc] init];
    self.page = 1;
    if (self.post) {
        [self displayAnnotationForPost:self.post];
    } else {
        [self getMapPost];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma Delegates

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    if (!self.post) {
        for (id post in self.posts) {
            if (view.tag == [[post objectForKey:@"id_laporan"] integerValue]) {
                [self performSegueWithIdentifier:@"Detail" sender:@[post]];
                return;
            }
        }
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKPinAnnotationView *pinView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"myPin"];
    if (!pinView) {
        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myPin"];
        pinView.canShowCallout = false;
    } else {
        pinView.annotation = annotation;
    }
    if ([[annotation title] isEqualToString:@"belum diproses"]) {
        pinView.pinTintColor = UIColor.redColor;
    }
    else if ([[annotation title] isEqualToString:@"terselesaikan"]) {
        pinView.pinTintColor = UIColor.greenColor;
    }
    else {
        pinView.pinTintColor = UIColor.orangeColor;
    }
    pinView.tag = [[annotation subtitle] integerValue];
    return pinView;
}

#pragma

- (void)displayAnnotationForPost:(id)post {
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    CGFloat latitude = [[post objectForKey:@"latitude"] floatValue];
    CGFloat longitude = [[post objectForKey:@"longitude"] floatValue];
    point.coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    point.title = [post objectForKey:@"status"];
    [self.mapView addAnnotation:point];
}

- (void)displayAnnotation {
    for (id post in self.posts) {
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        CGFloat latitude = [[post objectForKey:@"latitude"] floatValue];
        CGFloat longitude = [[post objectForKey:@"longitude"] floatValue];
        point.coordinate = CLLocationCoordinate2DMake(latitude, longitude);
        point.title = [post objectForKey:@"status"];
        point.subtitle = [post objectForKey:@"id_laporan"];
        [self.mapView addAnnotation:point];
    }
}

#pragma Connection

- (void)getMapPost {
    UIActivityIndicatorView* activityIndicator = [Helpers getActivityIndicator:self];
    void (^success)(NSURLSessionTask *task, id responseObject) = ^void(NSURLSessionTask *task, id responseObject) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        if (![[responseObject objectForKey:@"status"] boolValue]) {
            [Helpers alertFailure:[responseObject objectForKey:@"message"] viewController:self];
            return;
        }
        NSInteger totalUserPost = [[[responseObject objectForKey:@"data"] objectForKey:@"total"] integerValue];
        [self.posts addObjectsFromArray:[[responseObject objectForKey:@"data"] objectForKey:@"timeline"]];
        if ([self.posts count] < totalUserPost) {
            self.page = self.page + 1;
            [self getMapPost];
        } else {
            [self displayAnnotation];
        }
    };
    void (^failure)(NSURLSessionTask *operation, NSError *error) = ^void(NSURLSessionTask *operation, NSError *error) {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        [Helpers alertFailure:[error localizedDescription] viewController:self];
    };
    NSString* email = [[NSUserDefaults standardUserDefaults] stringForKey:@"email"];
    NSString* token = [[NSUserDefaults standardUserDefaults] stringForKey:@"token"];
    NSNumber* page = [[NSNumber alloc] initWithInteger:self.page];
    [activityIndicator startAnimating];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [Connection getMapPost:email token:token page:page success:success failure:failure];
}

#pragma IBActions

- (IBAction)back:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSString* identifier = [segue identifier];
    if ([identifier isEqualToString:@"Detail"]) {
        LaporanViewController* vc = [segue destinationViewController];
        vc.post = [sender objectAtIndex:0];
    }
}

@end
