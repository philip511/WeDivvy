//
//  EndTextCell.m
//  WeDivvy
//
//  Created by Philip Nagel on 6/19/21.
//

#import "EndTextCell.h"

#import "GeneralObject.h"
#import "BoolDataObject.h"
#import "LightDarkModeObject.h"

@implementation EndTextCell

-(void)layoutSubviews {
    
    _messageLabel.adjustsFontSizeToFitWidth = YES;
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        self.contentView.backgroundColor = [UIColor clearColor];
        self.messageLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextSecondary];
        
    }
    
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
