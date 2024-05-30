//
//  HomeMemberCell.h
//  WeDivvy
//
//  Created by Philip Nagel on 5/21/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeMemberCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subLabel;

@property (weak, nonatomic) IBOutlet UIImageView *cautionImage;
@property (weak, nonatomic) IBOutlet UIImageView *premiumImage;

@property (weak, nonatomic) IBOutlet UIImageView *ellipsisImage;
@property (weak, nonatomic) IBOutlet UIButton *ellipsisImageOverlay;

@property (weak, nonatomic) IBOutlet UIView *separatorLineView;

@end

NS_ASSUME_NONNULL_END
