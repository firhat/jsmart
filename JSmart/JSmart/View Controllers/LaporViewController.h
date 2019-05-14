//
//  LaporViewController.h
//  JSmart
//
//  Created by whcl on 29/06/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "Helpers.h"
#import "Connection.h"
#import <CoreLocation/CoreLocation.h>
#import "LocationManager.h"
#import "Strings.h"
#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>

@interface LaporViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate, LocationManagerDelegate>

@property NSInteger ATTACHMENT_NONE;
@property NSInteger ATTACHMENT_IMAGE;
@property NSInteger ATTACHMENT_VIDEO;
@property NSInteger ATTACHMENT_TYPE;
@property id category;
@property UIImage* attachedImage;
@property NSURL* attachedVideo;
@property LocationManager* locationManager;
@property NSString* address;
@property NSString* kelurahan;
@property NSString* kecamatan;
@property NSString* kota;
@property CGFloat latitude;
@property CGFloat longitude;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *containerIcon;
@property (weak, nonatomic) IBOutlet UILabel *containerCategory;
@property (weak, nonatomic) IBOutlet UITextView *containerTitle;
@property (weak, nonatomic) IBOutlet UITextView *containerContent;
@property (weak, nonatomic) IBOutlet UIImageView *containerAttachedImage;
@property (weak, nonatomic) IBOutlet UIView *containerAttachedVideo;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *containerAttachmentButtons;
@property (weak, nonatomic) IBOutlet UIView *containerAttachmentResult;
@property (weak, nonatomic) IBOutlet UIButton *buttonClearAttachment;

- (IBAction)addImage:(UIButton *)sender;
- (IBAction)addVideo:(UIButton *)sender;
- (IBAction)clearAttachment:(UIButton *)sender;
- (IBAction)back:(UIButton *)sender;
- (IBAction)lapor:(UIButton *)sender;


@end
