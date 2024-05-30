//
//  HomeOptionsCell.h
//  WeDivvy
//
//  Created by Philip Nagel on 6/9/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeOptionsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UISwitch *customSwitch;

@end

NS_ASSUME_NONNULL_END
