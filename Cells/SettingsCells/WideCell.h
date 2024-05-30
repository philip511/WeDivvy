//
//  WideCell.h
//  WeDivvy
//
//  Created by Philip Nagel on 8/11/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WideCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *upvoteView;
@property (weak, nonatomic) IBOutlet UILabel *upvoteViewAmountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *upvoteViewArrowImageView;
@property (weak, nonatomic) IBOutlet UIButton *upvoteOverlayView;

@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIView *unreadView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

NS_ASSUME_NONNULL_END
