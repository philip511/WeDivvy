//
//  SideBarCell.h
//  WeDivvy
//
//  Created by Philip Nagel on 5/14/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SideBarCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *sideBarMainView;
@property (weak, nonatomic) IBOutlet UIImageView *sideBarImage;
@property (weak, nonatomic) IBOutlet UILabel *sideBarLabel;
@property (weak, nonatomic) IBOutlet UILabel *sideBarAmountLabel;

@property (weak, nonatomic) IBOutlet UIView *unusedPremiumAccountsView;
@property (weak, nonatomic) IBOutlet UIView *upgradePremiumReminderView;

@property (weak, nonatomic) IBOutlet UILabel *upgradePremiumReminderViewLabel;
@property (weak, nonatomic) IBOutlet UIImageView *upgradePremiumReminderViewImageView;
@property (weak, nonatomic) IBOutlet UIView *upgradePremiumReminderViewImageViewCover;

@end

NS_ASSUME_NONNULL_END
