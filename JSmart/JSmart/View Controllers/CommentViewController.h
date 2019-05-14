//
//  CommentViewController.h
//  JSmart
//
//  Created by whcl on 04/07/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import "CellCommentTableViewCell.h"
#import "CellCommentAttachmentTableViewCell.h"
#import "Connection.h"
#import "Helpers.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <BFRImageViewer/BFRImageViewController.h>

@interface CommentViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate, CellCommentAttachmentDelegate>

@property NSMutableArray* comments;
@property NSInteger idLaporan;
@property UIImage* attachedImage;
@property BOOL IS_COMMENT_WITH_ATTACHMENT;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextView *containerComment;
@property (weak, nonatomic) IBOutlet UILabel *containerNoComment;
@property (weak, nonatomic) IBOutlet UIView *containerAttachment;
@property (weak, nonatomic) IBOutlet UIImageView *containerAttachedImage;
@property (weak, nonatomic) IBOutlet UIButton *containerIconAttachment;
@property (weak, nonatomic) IBOutlet UIButton *containerIconDeleteAttachment;



- (IBAction)comment:(UIButton *)sender;
- (IBAction)back:(UIButton *)sender;
- (IBAction)commentWithAttachment:(UIButton *)sender;
- (IBAction)deleteAttachment:(UIButton *)sender;

@end
