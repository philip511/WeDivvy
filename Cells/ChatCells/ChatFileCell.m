//
//  ChatFileCell.m
//  WeDivvy
//
//  Created by Philip Nagel on 10/13/21.
//

#import "ChatFileCell.h"

@implementation ChatFileCell

-(void)layoutSubviews {
    
    CGFloat width = CGRectGetWidth(self.contentView.bounds);
    CGFloat height = CGRectGetHeight(self.contentView.bounds);
    
    _chatImageView.frame = CGRectMake(width*0.5 - ((width*0.326)*0.5), height*0.5 - ((height*0.92307)*0.5), (height*0.92307)*0.5, height*0.92307);
    _chatImageView.clipsToBounds = YES;
    _chatImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    _userProfileImage.layer.cornerRadius = _userProfileImage.frame.size.height/2;
    _userProfileImage.clipsToBounds = YES;
    _userProfileImage.contentMode = UIViewContentModeScaleAspectFill;
    
    _userProfileImage1.layer.cornerRadius = _userProfileImage1.frame.size.height/2;
    _userProfileImage1.clipsToBounds = YES;
    _userProfileImage1.contentMode = UIViewContentModeScaleAspectFill;
    
    _userNameLabel.adjustsFontSizeToFitWidth = YES;
    _userNameLabel1.adjustsFontSizeToFitWidth = YES;
    
    _greyView.layer.cornerRadius = 7;
    
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
