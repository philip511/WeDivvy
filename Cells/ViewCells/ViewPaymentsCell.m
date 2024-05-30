//
//  ViewPaymentsCell.m
//  WeDivvy
//
//  Created by Philip Nagel on 2/2/23.
//

#import "ViewPaymentsCell.h"

#import "BoolDataObject.h"
#import "LightDarkModeObject.h"

@implementation ViewPaymentsCell

-(void)layoutSubviews {
 
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        self.contentView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeTertiary];
        self.paymentNameLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        self.paymentDescriptionLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        self.paymentAmountLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        
    }
    
    [super layoutSubviews];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
