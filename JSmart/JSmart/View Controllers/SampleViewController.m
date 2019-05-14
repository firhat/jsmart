//
//  SampleViewController.m
//  JSmart
//
//  Created by whcl on 02/07/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import "SampleViewController.h"

@interface SampleViewController ()

@property BOOL hasTaken;

@end

@implementation SampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    AVPlayerViewController* avPlayerViewController = [[AVPlayerViewController alloc] init];
    NSURL* url = [NSURL URLWithString:@"http://techslides.com/demos/sample-videos/small.mp4"];
    AVPlayer* avPlayer = [[AVPlayer alloc] initWithURL:url];
    avPlayerViewController.player = avPlayer;
    [self presentViewController:avPlayerViewController animated:true completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
