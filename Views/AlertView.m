//
//  AlertView.m
//  WeDivvy
//
//  Created by Philip Nagel on 5/18/23.
//

#import "AlertView.h"

#import "TasksViewController.h"

#import "GeneralObject.h"
#import "BoolDataObject.h"
#import "LightDarkModeObject.h"

@implementation AlertView {
    
    UIView *alertView;
    UIImageView *alertViewIconImage;
    UILabel *alertViewLabel;
    UIButton *alertViewAcceptButton;
    UIButton *alertViewDeclineButton;
    
}

- (instancetype)initWithFrame:(CGRect)frame viewControllerWidth:(CGFloat)viewControllerWidth viewControllerHeight:(CGFloat)viewControllerHeight text:(NSString *)text acceptButtonSelector:(SEL)acceptButtonSelector declineButtonSelector:(SEL)declineButtonSelector viewControllerObject:(id)viewControllerObject {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self = [[AlertView alloc] initWithFrame:frame];
        self.backgroundColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:0.1f] : [[[LightDarkModeObject alloc] init] LightModeBackDrop];
        
        UIView *alertView = [self GenerateAlertView:viewControllerWidth viewControllerHeight:viewControllerHeight];
        [self addSubview:alertView];
        
        UIImageView *alertViewIconImage = [self GenerateAlertViewIconImage:alertView];
        [alertView addSubview:alertViewIconImage];
        
        UILabel *alertViewLabel = [self GenerateAlertViewLabel:alertView text:text];
        [alertView addSubview:alertViewLabel];
        
        UIButton *alertViewAcceptButton = [self GenerateAlertViewAcceptButton:alertView acceptButtonSelector:acceptButtonSelector viewControllerObject:viewControllerObject];
        [alertView addSubview:alertViewAcceptButton];
        
        UIButton *alertViewDeclineButton = [self GenerateAlertDeclineButton:alertView declineButtonSelector:declineButtonSelector viewControllerObject:viewControllerObject];
        [alertView addSubview:alertViewDeclineButton];
        
        [self TapGestures];
        
    }
    
    return self;
}

#pragma mark - SetUp Views

-(UIView *)GenerateAlertView:(CGFloat)viewControllerWidth viewControllerHeight:(CGFloat)viewControllerHeight {
    
    CGFloat width = viewControllerWidth;
    CGFloat height = viewControllerHeight;
    
    UIView *alertView = [[UIView alloc] initWithFrame:CGRectMake(width*0.125, height*0.5 - (((height*0.30 > 220?(220):height*0.30))*0.5), width*0.75, (height*0.30 > 220?(220):height*0.30))];
    alertView.layer.cornerRadius = 7;
    alertView.backgroundColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModePrimary] : [[[LightDarkModeObject alloc] init] LightModeSecondary];

 
        

    return alertView;
}

-(UIImageView *)GenerateAlertViewIconImage:(UIView *)superView {

    CGFloat width = CGRectGetWidth(superView.bounds);
    CGFloat height = CGRectGetHeight(superView.bounds);
    
    UIImageView *alertViewIconImage = [[UIImageView alloc] initWithFrame:CGRectMake(width*0.5 - ((height*0.3)*0.5), 0, height*0.3, height*0.3)];
    alertViewIconImage.image = [UIImage imageNamed:@"WeDivvyMiddleLogo.png"];
    
    return alertViewIconImage;
}

-(UILabel *)GenerateAlertViewLabel:(UIView *)superView text:(NSString *)text {
  
    CGFloat width = CGRectGetWidth(superView.bounds);
    CGFloat height = CGRectGetHeight(superView.bounds);
    
    UILabel *alertViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*0.125, height*0.5 - (((height*0.42 > 92?(92):height*0.42))*0.5), width*0.75, (height*0.42 > 92?(92):height*0.42))];
    alertViewLabel.font = [UIFont systemFontOfSize:alertViewLabel.frame.size.height*0.15 weight:UIFontWeightSemibold];
    alertViewLabel.text = text;
    alertViewLabel.textColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTextPrimary] : [[[LightDarkModeObject alloc] init] LightModeTextPrimary];
    alertViewLabel.textAlignment = NSTextAlignmentCenter;
    alertViewLabel.numberOfLines = 0;
    
    return alertViewLabel;
}

-(UIButton *)GenerateAlertViewAcceptButton:(UIView *)superView acceptButtonSelector:(SEL)acceptButtonSelector viewControllerObject:(id)viewControllerObject {
  
    CGFloat width = CGRectGetWidth(superView.bounds);
    CGFloat height = CGRectGetHeight(superView.bounds);
    
     UIButton *alertViewAcceptButton = [[UIButton alloc] initWithFrame:CGRectMake(width*1-width*0.5, height*1-(height*0.2 > 44?(44):height*0.2), width*0.5, (height*0.2 > 44?(44):height*0.2))];
    alertViewAcceptButton.titleLabel.font = [UIFont systemFontOfSize:alertViewAcceptButton.frame.size.height*0.31818 weight:UIFontWeightSemibold];
    [alertViewAcceptButton setTitle:@"Sure thing!" forState:UIControlStateNormal];
    alertViewAcceptButton.backgroundColor = [[[GeneralObject alloc] init] GenerateAppColor:1.0f];
    [alertViewAcceptButton addTarget:viewControllerObject action:acceptButtonSelector forControlEvents:UIControlEventTouchUpInside];

    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:alertViewAcceptButton.bounds byRoundingCorners:(UIRectCornerBottomRight) cornerRadii:CGSizeMake(7,7)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = alertViewAcceptButton.bounds;
    maskLayer.path  = maskPath.CGPath;
    alertViewAcceptButton.layer.mask = maskLayer;
 
    return alertViewAcceptButton;
}

-(UIButton *)GenerateAlertDeclineButton:(UIView *)superView declineButtonSelector:(SEL)declineButtonSelector viewControllerObject:(id)viewControllerObject {
 
    CGFloat width = CGRectGetWidth(superView.bounds);
    CGFloat height = CGRectGetHeight(superView.bounds);
    
    UIButton *alertViewDeclineButton = [[UIButton alloc] initWithFrame:CGRectMake(0, height*1-(height*0.2 > 44?(44):height*0.2), width*0.5, (height*0.2 > 44?(44):height*0.2))];
    alertViewDeclineButton.titleLabel.font = [UIFont systemFontOfSize:alertViewDeclineButton.frame.size.height*0.31818 weight:UIFontWeightSemibold];
    [alertViewDeclineButton setTitle:@"No thanks" forState:UIControlStateNormal];
    [alertViewDeclineButton setTitleColor:[[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTextSecondary] : [[[LightDarkModeObject alloc] init] LightModeTextSecondary] forState:UIControlStateNormal];
    [alertViewDeclineButton addTarget:viewControllerObject action:declineButtonSelector forControlEvents:UIControlEventTouchUpInside];

    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:alertViewDeclineButton.bounds byRoundingCorners:(UIRectCornerBottomLeft) cornerRadii:CGSizeMake(7,7)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = alertViewDeclineButton.bounds;
    maskLayer.path  = maskPath.CGPath;
    alertViewDeclineButton.layer.mask = maskLayer;
    
    return alertViewDeclineButton;
}

#pragma mark - Tap Gesture Methods

-(void)TapGestures {
    
    UITapGestureRecognizer *tapGesture = nil;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    
//    [self addGestureRecognizer:tapGesture];
    self.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    
    [alertViewAcceptButton addGestureRecognizer:tapGesture];
    alertViewAcceptButton.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    
    [alertViewDeclineButton addGestureRecognizer:tapGesture];
    alertViewDeclineButton.userInteractionEnabled = YES;
    
}

#pragma mark

- (void)handleTap:(UITapGestureRecognizer *)gestureRecognizer {
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.alpha = 0.0;
        
    } completion:^(BOOL finished) {
       
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"DisplayAddTaskTutorialView" userInfo:nil locations:@[@"Tasks"]];
        
    }];
    
}

@end
