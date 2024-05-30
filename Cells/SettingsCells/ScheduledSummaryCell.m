//
//  ScheduledSummaryCell.m
//  WeDivvy
//
//  Created by Philip Nagel on 9/9/22.
//

#import "ScheduledSummaryCell.h"

#import "BoolDataObject.h"
#import "LightDarkModeObject.h"

@implementation ScheduledSummaryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews {
    
    _scheduledSummaryLabel.clipsToBounds = YES;
    _scheduledSummaryFrequencyLabel.clipsToBounds = YES;
    _scheduledSummaryDayLabel.clipsToBounds = YES;
    _scheduledSummaryTimeLabel.clipsToBounds = YES;
    
    _scheduledSummaryLabel.layer.cornerRadius = 7;
    _scheduledSummaryFrequencyLabel.layer.cornerRadius = 7;
    _scheduledSummaryDayLabel.layer.cornerRadius = 7;
    _scheduledSummaryTimeLabel.layer.cornerRadius = 7;
    
    _mainView.backgroundColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ?
    [[[LightDarkModeObject alloc] init] DarkModeTertiary] :
    [[[LightDarkModeObject alloc] init] LightModeSecondary];
    
    _scheduledSummaryLabel.textColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ?
    [[[LightDarkModeObject alloc] init] DarkModeTextPrimary] :
    [[[LightDarkModeObject alloc] init] LightModeTextPrimary];
    
    _scheduledSummaryDayLabel.backgroundColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ?
    [[[LightDarkModeObject alloc] init] DarkModeSecondary] :
    [[[LightDarkModeObject alloc] init] LightModePrimary];
    
    _scheduledSummaryTimeLabel.backgroundColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ?
    [[[LightDarkModeObject alloc] init] DarkModeSecondary] :
    [[[LightDarkModeObject alloc] init] LightModePrimary];
    
    _scheduledSummaryFrequencyLabel.backgroundColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ?
    [[[LightDarkModeObject alloc] init] DarkModeSecondary] :
    [[[LightDarkModeObject alloc] init] LightModePrimary];
    
    _scheduledSummaryDayLabel.textColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ?
    [[[LightDarkModeObject alloc] init] DarkModeTextPrimary] :
    [[[LightDarkModeObject alloc] init] LightModeTextPrimary];
    
    _scheduledSummaryTimeLabel.textColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ?
    [[[LightDarkModeObject alloc] init] DarkModeTextPrimary] :
    [[[LightDarkModeObject alloc] init] LightModeTextPrimary];
    
    _scheduledSummaryFrequencyLabel.textColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ?
    [[[LightDarkModeObject alloc] init] DarkModeTextPrimary] :
    [[[LightDarkModeObject alloc] init] LightModeTextPrimary];
    
}

@end
