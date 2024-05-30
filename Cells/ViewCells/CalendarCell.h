//
//  CalendarCell.h
//  WeDivvy
//
//  Created by Philip Nagel on 9/25/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CalendarCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIView *mainView;

@property (weak, nonatomic) IBOutlet UILabel *calendarDayNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *calendarWeekDayLabel;

@end

NS_ASSUME_NONNULL_END
