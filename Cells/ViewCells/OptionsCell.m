//
//  OptionsCell.m
//  WeDivvy
//
//  Created by Philip Nagel on 6/28/21.
//

#import "OptionsCell.h"

#import "GeneralObject.h"
#import "BoolDataObject.h"
#import "LightDarkModeObject.h"

@implementation OptionsCell

-(void)layoutSubviews {
    
    _itemOptionLeftLabel.adjustsFontSizeToFitWidth = YES;

    _itemOptionColorView.layer.cornerRadius = _itemOptionColorView.frame.size.height/3;
    _itemOptionColorView.clipsToBounds = YES;

    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {

        self.contentView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeTertiary];
        self.itemOptionLeftLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
     
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
