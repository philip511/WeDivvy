//
//  MultiAddTaskCell.m
//  WeDivvy
//
//  Created by Philip Nagel on 9/7/22.
//

#import "MultiAddTaskCell.h"

#import "BoolDataObject.h"
#import "LightDarkModeObject.h"

@implementation MultiAddTaskCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews {
    
    _mainView.layer.cornerRadius = 19;
    _slideView.layer.cornerRadius = _mainView.layer.cornerRadius;
    
    _checkmarkView.layer.cornerRadius = _checkmarkView.frame.size.height/3;
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

@end
