//
//  WideCell.m
//  WeDivvy
//
//  Created by Philip Nagel on 8/11/21.
//

#import "WideCell.h"

#import "GeneralObject.h"
#import "BoolDataObject.h"
#import "LightDarkModeObject.h"

@implementation WideCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)layoutSubviews {
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
    
        self.contentView.layer.shadowColor = [[[LightDarkModeObject alloc] init] DarkModeShadow].CGColor;
        self.contentView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModePrimary];
        
        self.upvoteViewAmountLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        self.titleLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        self.subLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextSecondary];
        
        self.titleLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        self.subLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextSecondary];
     
        self.titleLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        self.subLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextSecondary];
        self.timeLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextSecondary];
        
    } else {
        
        self.contentView.layer.shadowColor = [[[LightDarkModeObject alloc] init] LightModeShadow].CGColor;
        self.contentView.backgroundColor = [[[LightDarkModeObject alloc] init] LightModeSecondary];
        
        self.titleLabel.textColor = [[[LightDarkModeObject alloc] init] LightModeTextPrimary];
        self.subLabel.textColor = [[[LightDarkModeObject alloc] init] LightModeTextSecondary];
  
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
