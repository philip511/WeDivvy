//
//  AssignedToCell.h
//  RoommateApp
//
//  Created by Philip Nagel on 5/21/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AssignedToCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subLabel;

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UIImageView *checkmarkImage;
@property (weak, nonatomic) IBOutlet UIImageView *cautionImage;
@property (weak, nonatomic) IBOutlet UIImageView *premiumImage;
@property (weak, nonatomic) IBOutlet UIImageView *lockImage;

@property (weak, nonatomic) IBOutlet UIImageView *ellipsisImage;
@property (weak, nonatomic) IBOutlet UIButton *ellipsisImageOverlay;

@end

NS_ASSUME_NONNULL_END
