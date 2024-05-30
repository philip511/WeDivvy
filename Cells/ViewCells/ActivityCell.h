//
//  ActivityCell.h
//  WeDivvy
//
//  Created by Philip Nagel on 12/12/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ActivityCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *activityUserImageView;

@property (weak, nonatomic) IBOutlet UILabel *activityDescriptionLabel;

@property (weak, nonatomic) IBOutlet UIView *activityIconSuperView;
@property (weak, nonatomic) IBOutlet UIView *activityIconView;
@property (weak, nonatomic) IBOutlet UIImageView *activityIconImageView;

@property (weak, nonatomic) IBOutlet UIView *activityReadView;

@end

NS_ASSUME_NONNULL_END
