//
//  ViewTaskCell.m
//  WeDivvy
//
//  Created by Philip Nagel on 5/21/23.
//

#import "ViewTaskCell.h"

#import "BoolDataObject.h"
#import "LightDarkModeObject.h"

@implementation ViewTaskCell

-(void)layoutSubviews {
    
    _profileImage.layer.cornerRadius = _profileImage.frame.size.height/2;
    _profileImage.contentMode = UIViewContentModeScaleAspectFill;
    
    _alternateCheckmarkView.layer.cornerRadius = _alternateCheckmarkView.frame.size.height/3;
    _mainView.layer.cornerRadius = 19;
   
    _progressBarOne.layer.cornerRadius = _progressBarOne.frame.size.height/2;
    _progressBarTwo.layer.cornerRadius = _progressBarTwo.frame.size.height/2;
    
    _itemPastDueImage.layer.cornerRadius = _itemPastDueImage.frame.size.height/2;
    
    _mainView.layer.shadowRadius = 5;
    _mainView.layer.shadowOpacity = 1.0;
    _mainView.layer.shadowOffset = CGSizeMake(0, 0);
    
    CAGradientLayer *viewLayer = [CAGradientLayer layer];
    viewLayer = [CAGradientLayer layer];
    [viewLayer setFrame:_mainView.bounds];
    [_mainView.layer insertSublayer:viewLayer atIndex:0];
    [_mainView.layer addSublayer:viewLayer];
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        _mainView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeTertiary];
        _mainView.layer.shadowColor = [[[LightDarkModeObject alloc] init] DarkModeShadow].CGColor;
        _titleLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        
    } else {
        
        _mainView.backgroundColor = [[[LightDarkModeObject alloc] init] LightModeSecondary];
        _mainView.layer.shadowColor = [[[LightDarkModeObject alloc] init] LightModeShadow].CGColor;
        _titleLabel.textColor = [[[LightDarkModeObject alloc] init] LightModeTextPrimary];
        
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
