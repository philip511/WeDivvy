//
//  HomeMemberCell.m
//  WeDivvy
//
//  Created by Philip Nagel on 5/21/23.
//

#import "HomeMemberCell.h"

#import "BoolDataObject.h"
#import "LightDarkModeObject.h"

@implementation HomeMemberCell

- (void)awakeFromNib {
    [super awakeFromNib];
  
    _profileImage.layer.cornerRadius = _profileImage.frame.size.height/2;
    _profileImage.clipsToBounds = YES;
    _profileImage.contentMode = UIViewContentModeScaleAspectFill;

    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        _titleLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        
    } else {
        
        _titleLabel.textColor = [[[LightDarkModeObject alloc] init] LightModeTextPrimary];
        
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
