//
//  BlueTextCell.m
//  WeDivvy
//
//  Created by Philip Nagel on 6/19/21.
//

#import "BlueTextCell.h"

#import "GeneralObject.h"
#import "BoolDataObject.h"
#import "LightDarkModeObject.h"

@implementation BlueTextCell

-(void)layoutSubviews {
    
    _userProfileImage.layer.cornerRadius = _userProfileImage.frame.size.height/2;
    _userProfileImage.clipsToBounds = YES;
    _userProfileImage.contentMode = UIViewContentModeScaleAspectFill;
    
    _messageLabel.adjustsFontSizeToFitWidth = YES;
    _userNameLabel.adjustsFontSizeToFitWidth = YES;
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        self.contentView.backgroundColor = [UIColor clearColor];
        self.userNameLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextSecondary];
        
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
