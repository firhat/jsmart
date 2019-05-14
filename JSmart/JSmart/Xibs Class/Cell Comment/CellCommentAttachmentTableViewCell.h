//
//  CellCommentAttachmentTableViewCell.h
//  JSmart
//
//  Created by whcl on 05/07/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CellCommentAttachmentDelegate <NSObject>
- (void)selectCell:(UIImage*)image;
@end

@interface CellCommentAttachmentTableViewCell : UITableViewCell

@property id<CellCommentAttachmentDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *containerImage;

- (IBAction)selectCell:(UIButton *)sender;

@end
