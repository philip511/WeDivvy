//
//  CostPerPersonCell.h
//  WeDivvy
//
//  Created by Philip Nagel on 7/19/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CostPerPersonCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userProfileImage;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIView *costPerPersonTextFieldView;
@property (weak, nonatomic) IBOutlet UITextField *costPerPersonTextField;
@property (weak, nonatomic) IBOutlet UIButton *costPerPersonTextFieldViewOverlayView;

@end

NS_ASSUME_NONNULL_END
