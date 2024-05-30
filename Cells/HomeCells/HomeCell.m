//
//  HomeCell.m
//  WeDivvy
//
//  Created by Philip Nagel on 5/21/23.
//

#import "HomeCell.h"

#import "GeneralObject.h"
#import "BoolDataObject.h"
#import "LightDarkModeObject.h"

@implementation HomeCell

-(void)layoutSubviews {
    
    _mainView.layer.cornerRadius = 19;

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
     
    } else {
        
        _mainView.backgroundColor = [[[LightDarkModeObject alloc] init] LightModeSecondary];
        _mainView.layer.shadowColor = [[[LightDarkModeObject alloc] init] LightModeShadow].CGColor;
      
    }
    
}

@end
