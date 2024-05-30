//
//  ScheduledSummaryCell.h
//  WeDivvy
//
//  Created by Philip Nagel on 9/9/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScheduledSummaryCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UILabel *scheduledSummaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *scheduledSummaryFrequencyLabel;
@property (weak, nonatomic) IBOutlet UILabel *scheduledSummaryDayLabel;
@property (weak, nonatomic) IBOutlet UILabel *scheduledSummaryTimeLabel;

@end

NS_ASSUME_NONNULL_END
