//
//  OptionsCell.h
//  WeDivvy
//
//  Created by Philip Nagel on 6/28/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OptionsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;

@property (weak, nonatomic) IBOutlet UILabel *itemOptionLeftLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemOptionRightLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemOptionSubLabel;

@property (weak, nonatomic) IBOutlet UIView *itemOptionColorView;

@property (weak, nonatomic) IBOutlet UIImageView *checkMarkImage;

@property (weak, nonatomic) IBOutlet UIImageView *ellipsisImage;
@property (weak, nonatomic) IBOutlet UIButton *ellipsisImageOverlay;

@end

NS_ASSUME_NONNULL_END
