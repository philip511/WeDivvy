//
//  GreyTextCell.h
//  WeDivvy
//
//  Created by Philip Nagel on 6/19/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GreyTextCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *messageBubble;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userProfileImage;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *premiumImage;

@end

NS_ASSUME_NONNULL_END
