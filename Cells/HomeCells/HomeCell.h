//
//  HomeCell.h
//  WeDivvy
//
//  Created by Philip Nagel on 5/21/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *mainView;

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subLabel;

@property (weak, nonatomic) IBOutlet UIImageView *ellipsisImage;
@property (weak, nonatomic) IBOutlet UIButton *ellipsisImageOverlay;

@end

NS_ASSUME_NONNULL_END
