//
//  ViewTaskCell.h
//  WeDivvy
//
//  Created by Philip Nagel on 5/21/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ViewTaskCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *mainView;

@property (weak, nonatomic) IBOutlet UIButton *checkmarkView;
@property (weak, nonatomic) IBOutlet UIButton *checkmarkViewCover;

@property (weak, nonatomic) IBOutlet UIButton *alternateCheckmarkView;
@property (weak, nonatomic) IBOutlet UIImageView *photoConfirmationImage;

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UIImageView *premiumImage;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subLabel;

@property (weak, nonatomic) IBOutlet UILabel *userAlertLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userAlertImage;

@property (weak, nonatomic) IBOutlet UIImageView *itemPriorityImage;
@property (weak, nonatomic) IBOutlet UIImageView *itemRepeatsImage;
@property (weak, nonatomic) IBOutlet UIImageView *itemPastDueImage;

@property (weak, nonatomic) IBOutlet UIView *progressBarOne;
@property (weak, nonatomic) IBOutlet UIView *progressBarTwo;
@property (weak, nonatomic) IBOutlet UILabel *percentageLabel;

@property (weak, nonatomic) IBOutlet UIImageView *ellipsisImage;
@property (weak, nonatomic) IBOutlet UIButton *ellipsisImageOverlay;

@property (weak, nonatomic) IBOutlet UIButton *mainViewOverlay;

@end

NS_ASSUME_NONNULL_END
