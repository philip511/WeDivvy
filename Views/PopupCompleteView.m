//
//  PopupCompleteView.m
//  WeDivvy
//
//  Created by Philip Nagel on 5/18/23.
//

#import "PopupCompleteView.h"

#import "BoolDataObject.h"
#import "LightDarkModeObject.h"

@implementation PopupCompleteView {
    
    UIView *completeAlertView;
    
    UIImageView *completeCloseImage;
    UIView *completeCloseImageCover;
    
    UILabel *completeTitleLabel;
    UILabel *completeBodyLabel;
    
    UILabel *completeAcceptLabel;
    UILabel *completeDeclineLabel;
    
}

- (instancetype)initWithFrame:(CGRect)frame viewControllerWidth:(CGFloat)viewControllerWidth viewControllerHeight:(CGFloat)viewControllerHeight title:(NSString *)title body:(NSString *)body acceptLabelText:(NSString *)acceptLabelText declineLabelText:(NSString *)declineLabelText acceptLabelColor:(UIColor *)acceptLabelColor declineLabelColor:(UIColor *)declineLabelColor acceptLabelSelector:(SEL)acceptLabelSelector declineLabelSelector:(SEL)declineLabelSelector viewControllerObject:(id)viewControllerObject {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self = [[PopupCompleteView alloc] initWithFrame:frame];
        self.backgroundColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.1f] : [[[LightDarkModeObject alloc] init] LightModeBackDrop];
        
        
        
        completeAlertView = [self GenerateCompleteAlertView:viewControllerWidth viewControllerHeight:viewControllerHeight];
        [self addSubview:completeAlertView];
        
        
        
        completeCloseImage = [self GenerateCompleteCloseImage:completeAlertView];
        [completeAlertView addSubview:completeCloseImage];
        
        completeCloseImageCover = [self GenerateCompleteCloseImageCover:completeAlertView completeCloseImage:completeCloseImage];
        [completeAlertView addSubview:completeCloseImageCover];
        
        
        
        completeTitleLabel = [self GenerateCompleteTitleLabel:completeAlertView completeCloseImage:completeCloseImage title:title];
        [completeAlertView addSubview:completeTitleLabel];
        
        completeBodyLabel = [self GenerateCompleteBodyLabel:completeAlertView body:body];
        [completeAlertView addSubview:completeBodyLabel];
        
        
        
        completeAcceptLabel = [self GenerateCompleteAcceptLabel:completeAlertView acceptLabelText:acceptLabelText acceptLabelColor:acceptLabelColor];
        [completeAlertView addSubview:completeAcceptLabel];
        
        completeDeclineLabel = [self GenerateCompleteDeclineLabel:completeAlertView declineLabelText:declineLabelText declineLabelColor:declineLabelColor];
        [completeAlertView addSubview:completeDeclineLabel];
        
        
        
        [self GenerateCompleteAlertViewWithUpdatedFrames:completeAlertView];
        
        
        
        [self TapGestures:acceptLabelSelector declineLabelSelector:declineLabelSelector viewControllerObject:viewControllerObject];

    }
    
    return self;
}

#pragma mark - SetUp Views

-(UIView *)GenerateCompleteAlertView:(CGFloat)viewControllerWidth viewControllerHeight:(CGFloat)viewControllerHeight {
    
    CGFloat width = viewControllerWidth;
    CGFloat height = viewControllerHeight;
    
    UIView *completeAlertView = [[UIView alloc] initWithFrame:CGRectMake(0, height, width, ((height*0.271739123) > 200?(200):(height*0.271739123)))];
    completeAlertView.clipsToBounds = true;
    completeAlertView.backgroundColor = [UIColor whiteColor];
    
    UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:completeAlertView.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight) cornerRadii:CGSizeMake(completeAlertView.frame.size.height*0.15, completeAlertView.frame.size.height*0.15)];
    
    CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
    maskLayer1.frame = completeAlertView.bounds;
    maskLayer1.path  = maskPath1.CGPath;
    completeAlertView.layer.mask = maskLayer1;
    
    return completeAlertView;
}

-(UIImageView *)GenerateCompleteCloseImage:(UIView *)completeAlertView {
    
    CGFloat width = CGRectGetWidth(completeAlertView.bounds);
    CGFloat height = CGRectGetHeight(completeAlertView.bounds);
    
    UIImageView *completeCloseImage = [[UIImageView alloc] initWithFrame:CGRectMake(width - ((height*0.1) > 20?(20):(height*0.1)) - height*0.1, height*0.1, ((height*0.1) > 20?(20):(height*0.1)), ((height*0.1) > 20?(20):(height*0.1)))];
    completeCloseImage.image = [UIImage imageNamed:@"GeneralIcons.X.png"];
    
    return completeCloseImage;
}

-(UIView *)GenerateCompleteCloseImageCover:(UIView *)completeAlertView completeCloseImage:(UIImageView *)completeCloseImage {
    
    CGFloat height = CGRectGetHeight(completeAlertView.bounds);
    
    UIView *completeCloseImageCover = [[UIView alloc] initWithFrame:CGRectMake(completeCloseImage.frame.origin.x - height*0.1, completeCloseImage.frame.origin.y - height*0.1, completeCloseImage.frame.size.width + ((height*0.1)*2), completeCloseImage.frame.size.height + ((height*0.1)*2))];
    
    return completeCloseImageCover;
}

-(UILabel *)GenerateCompleteTitleLabel:(UIView *)completeAlertView completeCloseImage:(UIImageView *)completeCloseImage title:(NSString *)title {
    
    CGFloat width = CGRectGetWidth(completeAlertView.bounds);
    CGFloat height = CGRectGetHeight(completeAlertView.bounds);
    
    UILabel *completeTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake((width - completeCloseImage.frame.origin.x) + height*0.05, height*0.1, width - (((width - completeCloseImage.frame.origin.x))*2) - height*0.1, ((height*0.1) > 20?(20):(height*0.1)))];
    completeTitleLabel.text = title;
    completeTitleLabel.font = [UIFont systemFontOfSize:completeTitleLabel.frame.size.height*0.9 weight:UIFontWeightHeavy];
    completeTitleLabel.adjustsFontSizeToFitWidth = YES;
    completeTitleLabel.textColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTextPrimary] : [[[LightDarkModeObject alloc] init] LightModeTexCompletedLabel];
    completeTitleLabel.textAlignment = NSTextAlignmentCenter;
    
    return completeTitleLabel;
}

-(UILabel *)GenerateCompleteBodyLabel:(UIView *)completeAlertView body:(NSString *)body {
    
    CGFloat width = CGRectGetWidth(completeAlertView.bounds);
    CGFloat height = CGRectGetHeight(completeAlertView.bounds);
    
    UILabel *completeBodyLabel = [[UILabel alloc] initWithFrame:CGRectMake(height*0.1, height*0.385, width - ((height*0.1)*2), ((height*0.1) > 20?(20):(height*0.1)))];
    completeBodyLabel.text = body;
    completeBodyLabel.font = [UIFont systemFontOfSize:completeBodyLabel.frame.size.height*0.7 weight:UIFontWeightHeavy];
    completeBodyLabel.adjustsFontSizeToFitWidth = YES;
    completeBodyLabel.textColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTextPrimary] : [[[LightDarkModeObject alloc] init] LightModeTexCompletedLabel];
    completeBodyLabel.textAlignment = NSTextAlignmentCenter;
    
    return completeBodyLabel;
}

-(UILabel *)GenerateCompleteAcceptLabel:(UIView *)completeAlertView acceptLabelText:(NSString *)acceptLabelText acceptLabelColor:(UIColor *)acceptLabelColor {
    
    CGFloat width = CGRectGetWidth(completeAlertView.bounds);
    CGFloat height = CGRectGetHeight(completeAlertView.bounds);
    
    UILabel *completeAcceptLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*0.5 + (height*0.05), height - ((height*0.2375) > 47.5?(47.5):(height*0.2375)) - height*0.1, (width*0.39855072), ((height*0.2375) > 47.5?(47.5):(height*0.2375)))];
    completeAcceptLabel.font = [UIFont systemFontOfSize:((completeAcceptLabel.frame.size.height*0.31578947) > 15?(15):(completeAcceptLabel.frame.size.height*0.31578947)) weight:UIFontWeightSemibold];
    
    completeAcceptLabel.layer.masksToBounds = YES;
    completeAcceptLabel.layer.cornerRadius = completeAcceptLabel.frame.size.height/2;
    
    completeAcceptLabel.backgroundColor = acceptLabelColor;
    completeAcceptLabel.textAlignment = NSTextAlignmentCenter;
    completeAcceptLabel.text = acceptLabelText;
    completeAcceptLabel.textColor = [UIColor whiteColor];
    completeAcceptLabel.layer.borderWidth = 2.0f;
    completeAcceptLabel.layer.borderColor = completeAcceptLabel.backgroundColor.CGColor;
    
    return completeAcceptLabel;
}

-(UILabel *)GenerateCompleteDeclineLabel:(UIView *)completeAlertView declineLabelText:(NSString *)declineLabelText declineLabelColor:(UIColor *)declineLabelColor {
    
    CGFloat width = CGRectGetWidth(completeAlertView.bounds);
    CGFloat height = CGRectGetHeight(completeAlertView.bounds);
    
    UILabel *completeDeclineLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*0.5 - (width*0.39855072) - (height*0.05) , height - ((height*0.2375) > 47.5?(47.5):(height*0.2375)) - height*0.1, (width*0.39855072), ((height*0.2375) > 47.5?(47.5):(height*0.2375)))];
    completeDeclineLabel.font = [UIFont systemFontOfSize:((completeDeclineLabel.frame.size.height*0.31578947) > 15?(15):(completeDeclineLabel.frame.size.height*0.31578947)) weight:UIFontWeightSemibold];
    
    completeDeclineLabel.layer.masksToBounds = YES;
    completeDeclineLabel.layer.cornerRadius = completeDeclineLabel.frame.size.height/2;
    
    completeDeclineLabel.backgroundColor = declineLabelColor;
    completeDeclineLabel.textAlignment = NSTextAlignmentCenter;
    completeDeclineLabel.text = declineLabelText;
    completeDeclineLabel.textColor = [UIColor whiteColor];
    completeDeclineLabel.layer.borderWidth = 2.0f;
    completeDeclineLabel.layer.borderColor = completeDeclineLabel.backgroundColor.CGColor;
    
    return completeDeclineLabel;
}

-(void)GenerateCompleteAlertViewWithUpdatedFrames:(UIView *)completeAlertView {
    
    [UIView animateWithDuration:0.25 animations:^{
        
        CGRect newRect = completeAlertView.frame;
        newRect.origin.y = self.frame.size.height - newRect.size.height;
        completeAlertView.frame = newRect;
        
    }];
    
}

#pragma mark - Tap Gesture Methods

-(void)TapGestures:(SEL)acceptLabelSelector declineLabelSelector:(SEL)declineLabelSelector viewControllerObject:(id)viewControllerObject {
    
    UITapGestureRecognizer *tapGesture = nil;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self addGestureRecognizer:tapGesture];
    self.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [completeCloseImageCover addGestureRecognizer:tapGesture];
    completeCloseImageCover.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:viewControllerObject action:acceptLabelSelector];
    [completeAcceptLabel addGestureRecognizer:tapGesture];
    completeAcceptLabel.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:viewControllerObject action:declineLabelSelector];
    [completeDeclineLabel addGestureRecognizer:tapGesture];
    completeDeclineLabel.userInteractionEnabled = YES;

    
}

#pragma mark

- (void)handleTap:(UITapGestureRecognizer *)gestureRecognizer {
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.alpha = 0.0;
        
        CGRect newRect = self->completeAlertView.frame;
        newRect.origin.y = self.frame.size.height;
        self->completeAlertView.frame = newRect;
        
    }];
    
}

@end
