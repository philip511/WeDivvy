//
//  ChatFileCell.h
//  WeDivvy
//
//  Created by Philip Nagel on 10/13/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChatFileCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *chatImageView;
@property (weak, nonatomic) IBOutlet UIImageView *userProfileImage;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *userProfileImage1;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel1;

@property (weak, nonatomic) IBOutlet UIView *greyView;
@property (weak, nonatomic) IBOutlet UIImageView *imageInGreyView;
@property (weak, nonatomic) IBOutlet UIImageView *premiumImage;

@end

NS_ASSUME_NONNULL_END
