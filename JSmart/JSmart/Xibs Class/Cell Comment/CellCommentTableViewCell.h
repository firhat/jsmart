//
//  CommentTableViewCell.h
//  JSmart
//
//  Created by whcl on 04/07/18.
//  Copyright © 2018 Yesa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellCommentTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *containerUserPicture;
@property (weak, nonatomic) IBOutlet UILabel *containerUserComment;
@property (weak, nonatomic) IBOutlet UILabel *containerUserName;

@end
