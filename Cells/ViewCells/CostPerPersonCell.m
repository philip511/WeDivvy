//
//  CostPerPersonCell.m
//  WeDivvy
//
//  Created by Philip Nagel on 7/19/21.
//

#import "CostPerPersonCell.h"

#import "GeneralObject.h"
#import "BoolDataObject.h"
#import "LightDarkModeObject.h"

@implementation CostPerPersonCell

-(void)layoutSubviews {
    
    _userProfileImage.clipsToBounds = YES;
    _userProfileImage.contentMode = UIViewContentModeScaleAspectFill;
    
    _costPerPersonTextFieldView.layer.cornerRadius = 7;
    _costPerPersonTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    CGFloat width = CGRectGetWidth(self.contentView.bounds);
    CGFloat height = CGRectGetHeight(self.contentView.bounds);
  
    _userProfileImage.frame = CGRectMake(width*0.04830918, (height*0.07476636), height*0.28037383, height*0.28037383);
    _usernameLabel.frame = CGRectMake(_userProfileImage.frame.origin.x + _userProfileImage.frame.size.width + (width*0.01932367), _userProfileImage.frame.origin.y, width - (_userProfileImage.frame.origin.x + _userProfileImage.frame.size.width + (width*0.01932367)), _userProfileImage.frame.size.height);
    _costPerPersonTextFieldView.frame = CGRectMake(_userProfileImage.frame.origin.x, _userProfileImage.frame.origin.y + _userProfileImage.frame.size.height + (height*0.07476636), width - (_userProfileImage.frame.origin.x*2), (height*0.42990654 > 46?46:(height*0.42990654)));

    _usernameLabel.font = [UIFont systemFontOfSize:height*0.13084112 weight:UIFontWeightBold];
    
    width = CGRectGetWidth(_costPerPersonTextFieldView.bounds);
    height = CGRectGetHeight(_costPerPersonTextFieldView.bounds);
    
    _costPerPersonTextField.frame = CGRectMake(8, 8, width*1 - 16, height*1 - 16);
    _costPerPersonTextField.font = [UIFont systemFontOfSize:_costPerPersonTextFieldView.frame.size.height*0.3 weight:UIFontWeightSemibold];
    
    _usernameLabel.adjustsFontSizeToFitWidth = YES;
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        self.contentView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModePrimary];
        self.usernameLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        self.costPerPersonTextFieldView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeTertiary];
        self.costPerPersonTextField.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeTertiary];
        self.costPerPersonTextField.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        
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
