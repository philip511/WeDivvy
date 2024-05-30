//
//  ViewPaymentsCell.h
//  WeDivvy
//
//  Created by Philip Nagel on 2/2/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ViewPaymentsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *firstUserImageView;
@property (weak, nonatomic) IBOutlet UIImageView *secondUserImageView;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;

@property (weak, nonatomic) IBOutlet UILabel *paymentNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *paymentAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *paymentDescriptionLabel;

@end

NS_ASSUME_NONNULL_END
