//
//  CellLaporanAttachmentTableViewCell.h
//  JSmart
//
//  Created by whcl on 05/07/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>

@protocol CellLaporanAttachmentDelegate <NSObject>

- (void)selectCell:(NSInteger)cellNumber image:(UIImage*)image;

@end

@interface CellLaporanAttachmentTableViewCell : UITableViewCell

@property NSInteger cellNumber;
@property id<CellLaporanAttachmentDelegate> delegate;
@property BOOL hasAttachment;
@property AVPlayerViewController* avPlayerViewController;
@property AVPlayer* avPlayer;

@property (weak, nonatomic) IBOutlet UIImageView *containerImage;
@property (weak, nonatomic) IBOutlet UIView *containerVideo;
@property (weak, nonatomic) IBOutlet UIButton *containerButton;

- (IBAction)selectCell:(UIButton *)sender;

@end
