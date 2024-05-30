//
//  FAQCell.h
//  WeDivvy
//
//  Created by Philip Nagel on 11/19/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FAQCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *faqTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *faqBodyLabel;
@property (weak, nonatomic) IBOutlet UIImageView *rightArrowImage;

@end

NS_ASSUME_NONNULL_END
