//
//  TutorialView.m
//  WeDivvy
//
//  Created by Philip Nagel on 5/14/23.
//

#import "TutorialView.h"
#import "GeneralObject.h"

@implementation TutorialView {
    
    UIView *helpView;
    UILabel *helpViewTitleLabel;
    UILabel *helpViewBodyLabel;
    UIButton *helpViewDoneButton;
    
}

- (instancetype)initWithFrame:(CGRect)frame helpViewFrameYPos:(CGFloat)helpViewFrameYPos viewControllerWidth:(CGFloat)viewControllerWidth viewControllerHeight:(CGFloat)viewControllerHeight title:(NSString *)title body:(NSString *)body {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self = [[TutorialView alloc] initWithFrame:frame];
        
        [self GenerateHelpSuperView];
        
        helpView = [self GenerateHelpView:viewControllerWidth viewControllerHeight:viewControllerHeight];
        [self addSubview:helpView];
        
        helpViewTitleLabel = [self GenerateHelpViewTitleLabel:helpView title:title];
        [helpView addSubview:helpViewTitleLabel];
        
        helpViewBodyLabel = [self GenerateHelpViewBodyLabel:helpView helpViewTitleLabel:helpViewTitleLabel body:body];
        [helpView addSubview:helpViewBodyLabel];
        
        helpViewDoneButton = [self GenerateHelpViewDoneButton:helpView helpViewBodyLabel:helpViewBodyLabel];
        [helpView addSubview:helpViewDoneButton];
        
        helpView = [self GenerateHelpViewWithUpdatedFrames:helpView helpViewFrameYPos:helpViewFrameYPos];
        
        [self TapGestures];
        
    }
    
    return self;
}

#pragma mark - SetUp Views

-(void)GenerateHelpSuperView {
    
    self.backgroundColor = [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.25f];
    
}

-(UIView *)GenerateHelpView:(CGFloat)viewControllerWidth viewControllerHeight:(CGFloat)viewControllerHeight {
    
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    
    UIView *helpView = [[UIView alloc] initWithFrame:CGRectMake(width*0.05, height - (viewControllerHeight*0.449775 > 300?(300):viewControllerHeight*0.449775) - width*0.05, width*0.9, (viewControllerHeight*0.449775 > 300?(300):viewControllerHeight*0.449775))];
    helpView.backgroundColor = [UIColor whiteColor];
    helpView.layer.cornerRadius = helpView.frame.size.height*0.0333;
    
    return helpView;
}

-(UILabel *)GenerateHelpViewTitleLabel:(UIView *)helpView title:(NSString *)title {
    
    CGFloat width = CGRectGetWidth(helpView.bounds);
    CGFloat height = CGRectGetHeight(helpView.bounds);
    
    UILabel *helpViewTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, width*0.05, width*0.9, height*0.06)];
    helpViewTitleLabel.textColor = [UIColor blackColor];
    helpViewTitleLabel.text = title;
    helpViewTitleLabel.numberOfLines = 0;
    helpViewTitleLabel.font = [UIFont systemFontOfSize:(helpViewTitleLabel.frame.size.height*0.89 > 16?(16):helpViewTitleLabel.frame.size.height*0.89) weight:UIFontWeightSemibold];
    
    NSInteger numberOfLines = [[[GeneralObject alloc] init] LineCountForText:helpViewTitleLabel.text label:helpViewTitleLabel];
    CGRect newRect = helpViewTitleLabel.frame;
    newRect.size.height = numberOfLines*(height*0.065);
    helpViewTitleLabel.frame = newRect;
    
    return helpViewTitleLabel;
}

-(UILabel *)GenerateHelpViewBodyLabel:(UIView *)helpView helpViewTitleLabel:(UILabel *)helpViewTitleLabel body:(NSString *)body {
    
    CGFloat width = CGRectGetWidth(helpView.bounds);
    CGFloat height = CGRectGetHeight(helpView.bounds);
    
    UILabel *helpViewBodyLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*0.05, helpViewTitleLabel.frame.origin.y + helpViewTitleLabel.frame.size.height + height*0.0267, width*0.9, height*0.0533)];
    helpViewBodyLabel.textColor = [UIColor colorWithRed:137.0f/255.0f green:146.0f/255.0f blue:155.0f/255.0f alpha:1.0f];
    helpViewBodyLabel.text = body;
    helpViewBodyLabel.numberOfLines = 0;
    helpViewBodyLabel.font = [UIFont systemFontOfSize:(helpViewBodyLabel.frame.size.height*0.9375 > 15?(15):helpViewBodyLabel.frame.size.height*0.9375) weight:UIFontWeightMedium];
    //    helpViewBodyLabel.backgroundColor = [UIColor blueColor];
    
    NSInteger  numberOfLines = [[[GeneralObject alloc] init] LineCountForText:helpViewBodyLabel.text label:helpViewBodyLabel];
    CGRect newRect = helpViewBodyLabel.frame;
    newRect.size.height = numberOfLines*(height*0.06);
    helpViewBodyLabel.frame = newRect;
    
    return helpViewBodyLabel;
}

-(UIButton *)GenerateHelpViewDoneButton:(UIView *)helpView helpViewBodyLabel:(UILabel *)helpViewBodyLabel {
    
    CGFloat width = CGRectGetWidth(helpView.bounds);
    CGFloat height = CGRectGetHeight(helpView.bounds);
    
    UIButton *helpViewDoneButton = [[UIButton alloc] initWithFrame:CGRectMake(width*0.05, helpViewBodyLabel.frame.origin.y + helpViewBodyLabel.frame.size.height + height*0.04, width*0.9, height*0.16)];
    [helpViewDoneButton setTitle:@"Got it 👍" forState:UIControlStateNormal];
    [helpViewDoneButton.titleLabel setFont:[UIFont systemFontOfSize:16 weight:UIFontWeightSemibold]];
    helpViewDoneButton.backgroundColor = [UIColor colorWithRed:14.0f/255.0f green:154.0f/255.0f blue:218.0f/255.0f alpha:1.0f];
    helpViewDoneButton.layer.cornerRadius = helpViewDoneButton.frame.size.height*0.167;
    
    return helpViewDoneButton;
}

-(UIView *)GenerateHelpViewWithUpdatedFrames:(UIView *)helpView helpViewFrameYPos:(CGFloat)helpViewFrameYPos {
    
    CGRect newRect = helpView.frame;
    newRect.size.height = helpViewDoneButton.frame.origin.y + helpViewDoneButton.frame.size.height + self.frame.size.width*0.05;
    newRect.origin.y = helpViewFrameYPos;
    helpView.frame = newRect;
    
    return helpView;
}

#pragma mark - Tap Gesture Methods

-(void)TapGestures {
    
    UITapGestureRecognizer *tapGesture = nil;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    
    [self addGestureRecognizer:tapGesture];
    self.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    
    [helpViewDoneButton addGestureRecognizer:tapGesture];
    helpViewDoneButton.userInteractionEnabled = YES;
    
}

#pragma mark

- (void)handleTap:(UITapGestureRecognizer *)gestureRecognizer {

    [UIView animateWithDuration:0.25 animations:^{
        
        self.alpha = 0.0;
        
    }];
    
}

@end
