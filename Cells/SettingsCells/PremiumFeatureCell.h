//
//  PremiumFeatureCell.h
//  WeDivvy
//
//  Created by Philip Nagel on 5/21/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PremiumFeatureCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *homeMembersMainView;
@property (weak, nonatomic) IBOutlet UIImageView *leftIconImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subLabel;
@property (weak, nonatomic) IBOutlet UIImageView *rightArrowImage;
@property (weak, nonatomic) IBOutlet UIView *homeMembersMainViewLine;

@end

NS_ASSUME_NONNULL_END
