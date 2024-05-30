//
//  AssignedToCell.m
//  RoommateApp
//
//  Created by Philip Nagel on 5/21/21.
//

#import "AssignedToCell.h"

#import "GeneralObject.h"
#import "BoolDataObject.h"
#import "LightDarkModeObject.h"

@implementation AssignedToCell

-(void)layoutSubviews {

    _profileImage.layer.cornerRadius = _profileImage.frame.size.height/2;
    _profileImage.clipsToBounds = YES;
    _profileImage.contentMode = UIViewContentModeScaleAspectFill;
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        self.contentView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeTertiary];
        self.usernameLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];

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
