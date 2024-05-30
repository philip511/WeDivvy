//
//  InitialViewController.m
//  RoommateApp
//
//  Created by Philip Nagel on 5/17/21.
//

#import "InitialViewController.h"
#import "AppDelegate.h"

#import <Mixpanel/Mixpanel.h>
#import <MRProgress/MRProgress.h>

#import "GeneralObject.h"
#import "GetDataObject.h"
#import "SetDataObject.h"
#import "DeleteDataObject.h"
#import "PushObject.h"
#import "BoolDataObject.h"
#import "LightDarkModeObject.h"
#import "InitialViewControllerObject.h"

@interface InitialViewController () {

    MRProgressOverlayView *progressView;
    
    UIView *introViewOne;
    UIView *introViewTwo;
    UIView *introViewThree;
    UIView *introViewFour;
    UIView *introViewFive;
    
    UIImageView *introImageOne;
    UIImageView *introImageTwo;
    UIImageView *introImageThree;
    UIImageView *introImageFour;
    UIImageView *introImageFive;
    
    UILabel *introHeadLabelOne;
    UILabel *introHeadLabelTwo;
    UILabel *introHeadLabelThree;
    UILabel *introHeadLabelFour;
    UILabel *introHeadLabelFive;
    
    UILabel *subLabelOne;
    UILabel *subLabelTwo;
    UILabel *subLabelThree;
    UILabel *subLabelFour;
    UILabel *subLabelFive;
    
    NSArray *imageArr;
    NSArray *titleArr;
    NSArray *subtitleArr;
 
    BOOL CallToActionUI;
    
}

@end

@implementation InitialViewController


#pragma mark - System Methods

- (void)viewDidLoad {
    [super viewDidLoad];

    imageArr = @[
        @"Illustrations.ScheduleChores",
        @"Illustrations.KeepTrackOfProgress",
        @"Illustrations.HoldEveryoneAccountable",
        @"Illustrations.MakeSureNoOneForgets",
        @"Illustrations.CommunicateWithEveryone"];

    titleArr = @[
        @"Schedule and organize chores and expenses",
        @"Sort and priortize what's important",
        @"Keep track of everyones progress",
        @"Make sure nothing gets forgotten",
        @"Keep everyone on\nthe same page"];

    subtitleArr = @[@"Create a wide range of tasks\nand keep everything neat and tidy",
                    @"Make sure that the things\nthat matter are never out of mind",
                    @"Always be up to date on\nwhat's been done and what's being done",
                    @"Send manual or automatic reminders\nso nothing slips through the cracks",
                    @"Leave comments and create\ngroup chats to avoid confusion"];
//
//    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]) {
//
//        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
//
//    }
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//
//        [[[SetDataObject alloc] init] SetDataCrash:^(BOOL finished) {
//
//        }];
//
//    });
//
//    [self InitMethod];
//
//    [self BarButtonItems];
//
//    //CallToActionUI = YES;
//
//    if (CallToActionUI) {
//
//        [_continueButton setTitle:@"Get Started" forState:UIControlStateNormal];
//
//        _appleSignInButton.hidden = YES;
//        _appleLogo.hidden = YES;
//        _googleSignInButton.hidden = YES;
//        _googleLogo.hidden = YES;
//        _googleLogoView.hidden = YES;
//        _orLabel.hidden = YES;
//        _leftLineLabel.hidden = YES;
//        _rightLineLabel.hidden = YES;
//
//    }
 
}

-(void)viewDidAppear:(BOOL)animated {
    
    [self InitMethod];
    
}

-(void)viewWillLayoutSubviews {
   
    [[self navigationController] setNavigationBarHidden:[[[BoolDataObject alloc] init] NoSignUp] ? NO : YES animated:NO];
    
    
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    CGFloat statusBarSizeHeight = [[[GeneralObject alloc] init] GetStatusBarHeight];
    CGFloat bottomPadding = [[[GeneralObject alloc] init] GetBottomPaddingHeight];

    CGFloat dotSpacing = 10;
    
    
    
    _dotThree.frame = CGRectMake(width*0.5 - ((7.5)*0.5), statusBarSizeHeight + 12, 7.5, 7.5);
    _dotTwo.frame = CGRectMake(_dotThree.frame.origin.x - _dotThree.frame.size.width - dotSpacing, _dotThree.frame.origin.y, _dotThree.frame.size.width, _dotThree.frame.size.height);
    _dotFour.frame = CGRectMake(_dotThree.frame.origin.x + _dotThree.frame.size.width + dotSpacing, _dotThree.frame.origin.y, _dotThree.frame.size.width, _dotThree.frame.size.height);
    _dotOne.frame = CGRectMake(_dotTwo.frame.origin.x - _dotThree.frame.size.width - dotSpacing, _dotThree.frame.origin.y, _dotThree.frame.size.width, _dotThree.frame.size.width);
    _dotFive.frame = CGRectMake(_dotFour.frame.origin.x + _dotThree.frame.size.width + dotSpacing, _dotThree.frame.origin.y, _dotThree.frame.size.width, _dotThree.frame.size.height);
    
    
    
    [self SetUpUI];

    

    _loginButton.frame = CGRectMake(0, height - (self.view.frame.size.height*0.01716738 > 16?(16):self.view.frame.size.height*0.01716738) - (self.view.frame.size.height*0.02145923 > 18?(18):self.view.frame.size.height*0.02145923) - bottomPadding*0.5, width, (self.view.frame.size.height*0.01716738 > 16?(16):self.view.frame.size.height*0.01716738));
  
    
    
    _continueButton.frame = CGRectMake(width*0.5 - ((width*0.90338)*0.5), _loginButton.frame.origin.y - (self.view.frame.size.height*0.067934 > 50?(50):self.view.frame.size.height*0.067934) - 20, (width*0.90338), (self.view.frame.size.height*0.067934 > 50?(50):self.view.frame.size.height*0.067934));
    
    
    
    _orLabel.frame = CGRectMake(width*0.5 - ((self.view.frame.size.height*0.0193133 > 18?(18):self.view.frame.size.height*0.0193133)*0.5), _continueButton.frame.origin.y - (self.view.frame.size.height*0.0193133 > 18?(18):self.view.frame.size.height*0.0193133) - (self.view.frame.size.height*0.00858 > 8?(8):self.view.frame.size.height*0.00858), (self.view.frame.size.height*0.0193133 > 18?(18):self.view.frame.size.height*0.0193133), (self.view.frame.size.height*0.0193133 > 18?(18):self.view.frame.size.height*0.0193133));
    _leftLineLabel.frame = CGRectMake(_continueButton.frame.origin.x, _orLabel.frame.origin.y + ((self.view.frame.size.height*0.01609442 > 15?(15):self.view.frame.size.height*0.01609442)*0.5) + 0.5, width*0.41787, 1);
    _rightLineLabel.frame = CGRectMake(width - width*0.41787 - _continueButton.frame.origin.x, _leftLineLabel.frame.origin.y, _leftLineLabel.frame.size.width, 1);
    
    
    
    _googleSignInButton.frame = CGRectMake(_continueButton.frame.origin.x, _orLabel.frame.origin.y - _continueButton.frame.size.height - (self.view.frame.size.height*0.00858 > 8?(8):self.view.frame.size.height*0.00858), _continueButton.frame.size.width, _continueButton.frame.size.height);
    _appleSignInButton.frame = CGRectMake(_continueButton.frame.origin.x, _googleSignInButton.frame.origin.y - _continueButton.frame.size.height - (self.view.frame.size.height*0.00858 > 8?(8):self.view.frame.size.height*0.00858), _continueButton.frame.size.width, _continueButton.frame.size.height);
    
    
    
    _googleLogoView.frame = CGRectMake(_googleSignInButton.frame.origin.x + width*0.01207729, _googleSignInButton.frame.origin.y + width*0.01207729, _googleSignInButton.frame.size.height - ((width*0.01207729)*2), _googleSignInButton.frame.size.height - ((width*0.01207729)*2));
    _googleLogo.frame = CGRectMake(_googleLogoView.frame.origin.x + ((_googleLogoView.frame.size.width*0.5) - ((_appleSignInButton.frame.size.height * 0.66666667)*0.5)), _googleLogoView.frame.origin.y + ((_googleLogoView.frame.size.height*0.5) - ((_appleSignInButton.frame.size.height * 0.66666667)*0.5)), _appleSignInButton.frame.size.height * 0.66666667, _appleSignInButton.frame.size.height * 0.66666667);
    _appleLogo.frame = CGRectMake(_googleLogoView.frame.origin.x + ((_googleLogoView.frame.size.width*0.5) - ((_appleSignInButton.frame.size.height * 0.66666667)*0.5)), _appleSignInButton.frame.origin.y + ((_appleSignInButton.frame.size.height*0.5) - ((_appleSignInButton.frame.size.height * 0.66666667)*0.5)), _appleSignInButton.frame.size.height * 0.66666667, _appleSignInButton.frame.size.height * 0.66666667);
    
    
    
    _loginButton.titleLabel.font = [UIFont systemFontOfSize:_continueButton.frame.size.height*0.28 weight:UIFontWeightMedium];
    _appleSignInButton.titleLabel.font = [UIFont systemFontOfSize:_continueButton.frame.size.height*0.36 weight:UIFontWeightSemibold];
    _googleSignInButton.titleLabel.font = _appleSignInButton.titleLabel.font;
    _continueButton.titleLabel.font = _appleSignInButton.titleLabel.font;
    
    
    
    float sysVerFloat = [[[GeneralObject alloc] init] GetSystemVersion];

    CGFloat scrollViewHeight = 0.0;

    if (sysVerFloat < 13.00) {
        _appleSignInButton.hidden = YES;
        _appleLogo.hidden = YES;
        _appleSignInButton.userInteractionEnabled = NO;
        scrollViewHeight = _appleSignInButton.frame.origin.y - (_dotOne.frame.origin.y + _dotOne.frame.size.height + height*0.03) - height*0.03;
    } else {
        _appleSignInButton.hidden = CallToActionUI ? YES : NO;
        _appleLogo.hidden = CallToActionUI ? YES : NO;
        _appleSignInButton.userInteractionEnabled = YES;
        scrollViewHeight = _appleSignInButton.frame.origin.y - (_dotOne.frame.origin.y + _dotOne.frame.size.height + height*0.03) - height*0.03;
    }

    _customScrollView.frame = CGRectMake(0, _dotOne.frame.origin.y + _dotOne.frame.size.height + height*0.03, width, scrollViewHeight);
    [_customScrollView setContentSize:CGSizeMake(width*5, scrollViewHeight)];
    
    
    
    _continueButton.layer.cornerRadius = 7;
    _googleSignInButton.layer.cornerRadius = 7;
    _appleSignInButton.layer.cornerRadius = 7;
    _googleLogoView.layer.cornerRadius = 7;

    _dotOne.layer.cornerRadius = _dotOne.frame.size.height/2;
    _dotTwo.layer.cornerRadius = _dotTwo.frame.size.height/2;
    _dotThree.layer.cornerRadius = _dotThree.frame.size.height/2;
    _dotFour.layer.cornerRadius = _dotFour.frame.size.height/2;
    _dotFive.layer.cornerRadius = _dotFive.frame.size.height/2;
    
    
    
    _orLabel.adjustsFontSizeToFitWidth = YES;
    
    _continueButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    _loginButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    
    
    CGRect newRect = introViewOne.frame;
    newRect.size.height = introImageOne.frame.size.height + (self.view.frame.size.height*0.01390498 > 12?(12):self.view.frame.size.height*0.01390498) + introHeadLabelOne.frame.size.height + (self.view.frame.size.height*0.01390498 > 12?(12):self.view.frame.size.height*0.01390498) + subLabelOne.frame.size.height;
    newRect.origin.y = _customScrollView.frame.size.height*0.5 - newRect.size.height*0.5;
    introViewOne.frame = newRect;
    
    introViewTwo.frame = CGRectMake(width*1, introViewOne.frame.origin.y, width, introViewOne.frame.size.height);
    introViewThree.frame = CGRectMake(width*2, introViewOne.frame.origin.y, width, introViewOne.frame.size.height);
    introViewFour.frame = CGRectMake(width*3, introViewOne.frame.origin.y, width, introViewOne.frame.size.height);
    introViewFive.frame = CGRectMake(width*4, introViewOne.frame.origin.y, width, introViewOne.frame.size.height);
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGFloat width = CGRectGetWidth(self.view.bounds);
    
    UIColor *selectedColor = [UIColor colorWithRed:16.0f/255.0f green:156.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
    UIColor *unSelectedColor = [UIColor colorWithRed:126.0f/255.0f green:134.0f/255.0f blue:156.0f/255.0f alpha:1.0f];
    
    if (scrollView.contentOffset.x == 0) {

        self->_dotOne.backgroundColor = selectedColor;
        self->_dotTwo.backgroundColor = unSelectedColor;
        self->_dotThree.backgroundColor = unSelectedColor;
        self->_dotFour.backgroundColor = unSelectedColor;
        self->_dotFive.backgroundColor = unSelectedColor;

    } else if (scrollView.contentOffset.x == width) {

        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Image2"] completionHandler:^(BOOL finished) {
            
        }];
        
        self->_dotTwo.backgroundColor = selectedColor;
        self->_dotOne.backgroundColor = unSelectedColor;
        self->_dotThree.backgroundColor = unSelectedColor;
        self->_dotFour.backgroundColor = unSelectedColor;
        self->_dotFive.backgroundColor = unSelectedColor;

    } else if (scrollView.contentOffset.x == width*2) {
 
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Image3"] completionHandler:^(BOOL finished) {
            
        }];
        
        self->_dotThree.backgroundColor = selectedColor;
        self->_dotOne.backgroundColor = unSelectedColor;
        self->_dotTwo.backgroundColor = unSelectedColor;
        self->_dotFour.backgroundColor = unSelectedColor;
        self->_dotFive.backgroundColor = unSelectedColor;

    } else if (scrollView.contentOffset.x == width*3) {

        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Image4"] completionHandler:^(BOOL finished) {
            
        }];
        
        self->_dotFour.backgroundColor = selectedColor;
        self->_dotTwo.backgroundColor = unSelectedColor;
        self->_dotOne.backgroundColor = unSelectedColor;
        self->_dotThree.backgroundColor = unSelectedColor;
        self->_dotFive.backgroundColor = unSelectedColor;

    } else if (scrollView.contentOffset.x == width*4) {

        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Image5"] completionHandler:^(BOOL finished) {
            
        }];
        
        self->_dotFive.backgroundColor = selectedColor;
        self->_dotTwo.backgroundColor = unSelectedColor;
        self->_dotThree.backgroundColor = unSelectedColor;
        self->_dotOne.backgroundColor = unSelectedColor;
        self->_dotFour.backgroundColor = unSelectedColor;
 
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
}

#pragma mark - Init Methods

-(void)InitMethod {
    
    [self SetUpAnalytics];
    
    [self SetUpScrollView];
   
    [self SetUpLoginButtonText];
    
}

-(void)BarButtonItems {
    
    self.navigationItem.hidesBackButton = YES;
    
    UIBarButtonItem *barButtonItem;
    
    barButtonItem = [[UIBarButtonItem alloc]
                     initWithTitle:@"Back"
                     style:UIBarButtonItemStylePlain
                     target:self
                     action:@selector(NavigationBackButtonAction:)];
    
    if ([[[BoolDataObject alloc] init] NoSignUp]) {
        
        self.navigationItem.leftBarButtonItem = barButtonItem;
        
    }
    
}

#pragma mark - Setup Methods

-(void)SetUpAnalytics {

    [[[GeneralObject alloc] init] TrackInMixPanel:@"InitialViewController"];
    
}

-(void)SetUpScrollView {
    
    _customScrollView.delegate = self;
    _customScrollView.clipsToBounds = NO;
    _customScrollView.contentInset = UIEdgeInsetsZero;
    _customScrollView.pagingEnabled = YES;
    
}

//-(void)SetUpSubLabelText {
//
//    _subLabelOne.text = [NSString stringWithFormat:@"Create one-time, repeating,\nand alternating tasks"];
//    _subLabelTwo.text = [NSString stringWithFormat:@"View which tasks are\ncompleted, upcoming, or past due"];
//    _subLabelThree.text = [NSString stringWithFormat:@"Keep in touch using\nthe built-in group chat"];
//    _subLabelFour.text = [NSString stringWithFormat:@"Send manual or automatic\nreminders to complete tasks"];
//    _subLabelFive.text = [NSString stringWithFormat:@"Keep track of who has and\nhasn't been doing their fair share"];
//
//}

-(void)SetUpLoginButtonText {
    
    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:_loginButton.currentTitleColor, NSForegroundColorAttributeName, nil];
    
    NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:@"Already have an account? Log In" attributes:attrsDictionary];
    
    NSRange range0 = [[NSString stringWithFormat:@"%@", str] rangeOfString:@" Log In"];

    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.0f/255.0f green:122.0f/255.0f blue:255.0f/255.0f alpha:1.0f] range: NSMakeRange(range0.location, range0.length)];

    _loginButton.titleLabel.attributedText = str;
    
}

-(void)SetUpUI {
    
    if (introImageOne == nil || introImageOne == NULL) {
       
        CGFloat width = CGRectGetWidth(self.view.bounds);
        CGFloat height = CGRectGetHeight(self.view.bounds);
       
        CGFloat navigationBarHeight = [[[GeneralObject alloc] init] GetNavigationBarHeight:self];

        introViewOne = [[UIView alloc] init];
        introViewTwo = [[UIView alloc] init];
        introViewThree = [[UIView alloc] init];
        introViewFour = [[UIView alloc] init];
        introViewFive = [[UIView alloc] init];
        
        introImageOne = [[UIImageView alloc] init];
        introImageTwo = [[UIImageView alloc] init];
        introImageThree = [[UIImageView alloc] init];
        introImageFour = [[UIImageView alloc] init];
        introImageFive = [[UIImageView alloc] init];
        
        introHeadLabelOne = [[UILabel alloc] init];
        introHeadLabelTwo = [[UILabel alloc] init];
        introHeadLabelThree = [[UILabel alloc] init];
        introHeadLabelFour = [[UILabel alloc] init];
        introHeadLabelFive = [[UILabel alloc] init];
        
        subLabelOne = [[UILabel alloc] init];
        subLabelTwo = [[UILabel alloc] init];
        subLabelThree = [[UILabel alloc] init];
        subLabelFour = [[UILabel alloc] init];
        subLabelFive = [[UILabel alloc] init];
        
        [self SetUpView:@[
            @{@"ImageView" : introImageOne, @"Head" : introHeadLabelOne, @"Bottom" : subLabelOne, @"ImageViewText" : imageArr[0], @"HeadText" : titleArr[0], @"BottomText" : subtitleArr[0]},
            @{@"ImageView" : introImageTwo, @"Head" : introHeadLabelTwo, @"Bottom" : subLabelTwo, @"ImageViewText" : imageArr[1], @"HeadText" : titleArr[1], @"BottomText" : subtitleArr[1]},
            @{@"ImageView" : introImageThree, @"Head" : introHeadLabelThree, @"Bottom" : subLabelThree, @"ImageViewText" : imageArr[2], @"HeadText" : titleArr[2], @"BottomText" : subtitleArr[2]},
            @{@"ImageView" : introImageFour, @"Head" : introHeadLabelFour, @"Bottom" : subLabelFour, @"ImageViewText" : imageArr[3], @"HeadText" : titleArr[3], @"BottomText" : subtitleArr[3]},
            @{@"ImageView" : introImageFive, @"Head" : introHeadLabelFive, @"Bottom" : subLabelFive, @"ImageViewText" : imageArr[4], @"HeadText" : titleArr[4], @"BottomText" : subtitleArr[4]}
        ]];
    
        _customScrollView.delegate = self;
        _customScrollView.frame = CGRectMake(0, navigationBarHeight, width, 0);
        [_customScrollView setContentSize:CGSizeMake(width*5, 0)];
        
        
        
        
        float sysVerFloat = [[[GeneralObject alloc] init] GetSystemVersion];
        
        CGFloat scrollViewHeight = 0.0;
        
        if (sysVerFloat < 13.00) {
            _appleSignInButton.hidden = YES;
            _appleLogo.hidden = YES;
            _appleSignInButton.userInteractionEnabled = NO;
            scrollViewHeight = _appleSignInButton.frame.origin.y - (_dotOne.frame.origin.y + _dotOne.frame.size.height + height*0.03) - height*0.03;
        } else {
            _appleSignInButton.hidden = CallToActionUI ? YES : NO;
            _appleLogo.hidden = CallToActionUI ? YES : NO;
            _appleSignInButton.userInteractionEnabled = YES;
            scrollViewHeight = _appleSignInButton.frame.origin.y - (_dotOne.frame.origin.y + _dotOne.frame.size.height + height*0.03) - height*0.03;
        }
        
        _customScrollView.frame = CGRectMake(0, _dotOne.frame.origin.y + _dotOne.frame.size.height + height*0.03, width, scrollViewHeight);
        [_customScrollView setContentSize:CGSizeMake(width*5, scrollViewHeight)];
        
                                             
                                             
                                             
        width = CGRectGetWidth(_customScrollView.bounds);
        height = CGRectGetHeight(_customScrollView.bounds);
        
        introViewOne.frame = CGRectMake(0, 0, width, height);
        introViewTwo.frame = CGRectMake(width*1, introViewOne.frame.origin.y, width, introViewOne.frame.size.height);
        introViewThree.frame = CGRectMake(width*2, introViewOne.frame.origin.y, width, introViewOne.frame.size.height);
        introViewFour.frame = CGRectMake(width*3, introViewOne.frame.origin.y, width, introViewOne.frame.size.height);
        introViewFive.frame = CGRectMake(width*4, introViewOne.frame.origin.y, width, introViewOne.frame.size.height);
       
        introImageOne.frame = CGRectMake(width*0.5 - ((width*0.8)*0.5), 0, width*0.8, (self.view.frame.size.height*0.29130901 > 272?(272):self.view.frame.size.height*0.29130901));
        introHeadLabelOne.frame = CGRectMake(width*0.5 - ((width*0.71497)*0.5), introImageOne.frame.origin.y + introImageOne.frame.size.height + (self.view.frame.size.height*0.01390498 > 12?(12):self.view.frame.size.height*0.01390498), width*0.71497, (self.view.frame.size.height*0.06437768 > 60?(60):self.view.frame.size.height*0.06437768));
        subLabelOne.frame = CGRectMake(introHeadLabelOne.frame.origin.x, introHeadLabelOne.frame.origin.y + introHeadLabelOne.frame.size.height + (self.view.frame.size.height*0.01390498 > 12?(12):self.view.frame.size.height*0.01390498), introHeadLabelOne.frame.size.width, (self.view.frame.size.height*0.05364807 > 50?(50):self.view.frame.size.height*0.05364807));
        
        CGRect newRect = introViewOne.frame;
        newRect.size.height = introImageOne.frame.size.height + (self.view.frame.size.height*0.01390498 > 12?(12):self.view.frame.size.height*0.01390498) + introHeadLabelOne.frame.size.height + (self.view.frame.size.height*0.01390498 > 12?(12):self.view.frame.size.height*0.01390498) + subLabelOne.frame.size.height;
        newRect.origin.y = _customScrollView.frame.size.height*0.5 - newRect.size.height*0.5;
        introViewOne.frame = newRect;

        introHeadLabelOne.font = [UIFont systemFontOfSize:introHeadLabelOne.frame.size.height*0.4 weight:UIFontWeightSemibold];
        introHeadLabelOne.adjustsFontSizeToFitWidth = NO;
        
        subLabelOne.font = [UIFont systemFontOfSize:(subLabelOne.frame.size.height*0.375 > 16?(16):subLabelOne.frame.size.height*0.375) weight:UIFontWeightMedium];
        subLabelOne.adjustsFontSizeToFitWidth = NO;

        introImageTwo.frame = introImageOne.frame;
        introImageThree.frame = introImageOne.frame;
        introImageFour.frame = introImageOne.frame;
        introImageFive.frame = introImageOne.frame;
        
        introHeadLabelTwo.frame = introHeadLabelOne.frame;
        introHeadLabelThree.frame = introHeadLabelOne.frame;
        introHeadLabelFour.frame = introHeadLabelOne.frame;
        introHeadLabelFive.frame = introHeadLabelOne.frame;
        
        subLabelTwo.frame = subLabelOne.frame;
        subLabelThree.frame = subLabelOne.frame;
        subLabelFour.frame = subLabelOne.frame;
        subLabelFive.frame = subLabelOne.frame;
  
        introHeadLabelTwo.adjustsFontSizeToFitWidth = YES;
        introHeadLabelThree.adjustsFontSizeToFitWidth = YES;
        introHeadLabelFour.adjustsFontSizeToFitWidth = YES;
        introHeadLabelFive.adjustsFontSizeToFitWidth = YES;
        
        introHeadLabelTwo.font = introHeadLabelOne.font;
        introHeadLabelThree.font = introHeadLabelOne.font;
        introHeadLabelFour.font = introHeadLabelOne.font;
        introHeadLabelFive.font = introHeadLabelOne.font;
        
        subLabelTwo.frame = subLabelOne.frame;
        subLabelThree.frame = subLabelOne.frame;
        subLabelFour.frame = subLabelOne.frame;
        subLabelFive.frame = subLabelOne.frame;
        
        subLabelTwo.font = subLabelOne.font;
        subLabelThree.font = subLabelOne.font;
        subLabelFour.font = subLabelOne.font;
        subLabelFive.font = subLabelOne.font;
        
        subLabelTwo.adjustsFontSizeToFitWidth = YES;
        subLabelThree.adjustsFontSizeToFitWidth = YES;
        subLabelFour.adjustsFontSizeToFitWidth = YES;
        subLabelFive.adjustsFontSizeToFitWidth = YES;
        
        [_customScrollView addSubview:introViewOne];
        [_customScrollView addSubview:introViewTwo];
        [_customScrollView addSubview:introViewThree];
        [_customScrollView addSubview:introViewFour];
        [_customScrollView addSubview:introViewFive];
        
        [introViewOne addSubview:introImageOne];
        [introViewTwo addSubview:introImageTwo];
        [introViewThree addSubview:introImageThree];
        [introViewFour addSubview:introImageFour];
        [introViewFive addSubview:introImageFive];
        
        [introViewOne addSubview:introHeadLabelOne];
        [introViewTwo addSubview:introHeadLabelTwo];
        [introViewThree addSubview:introHeadLabelThree];
        [introViewFour addSubview:introHeadLabelFour];
        [introViewFive addSubview:introHeadLabelFive];
        
        [introViewOne addSubview:subLabelOne];
        [introViewTwo addSubview:subLabelTwo];
        [introViewThree addSubview:subLabelThree];
        [introViewFour addSubview:subLabelFour];
        [introViewFive addSubview:subLabelFive];

    }
    
}

#pragma mark - UI Methods

-(void)StartProgressView {
    
    self->progressView = [MRProgressOverlayView showOverlayAddedTo:self.navigationController.view animated:YES];
    self->progressView.mode = MRProgressOverlayViewModeIndeterminateSmall;
    
}

-(void)SetUpView:(NSArray *)array {
    
    for (NSDictionary *dictToUse in array) {
        
        UIImageView *imageToUse = dictToUse[@"ImageView"];
        UILabel *headLabel = dictToUse[@"Head"];
        UILabel *bottomLabel = dictToUse[@"Bottom"];
        
        NSString *imageViewText = dictToUse[@"ImageViewText"];
        NSString *headText = dictToUse[@"HeadText"];
        NSString *bottomText = dictToUse[@"BottomText"];
        
        imageToUse.image = [UIImage imageNamed:imageViewText];
        imageToUse.contentMode = UIViewContentModeScaleAspectFit;
        
        headLabel.text = headText;
        headLabel.textAlignment = NSTextAlignmentCenter;
        headLabel.numberOfLines = 0;
        
        bottomLabel.text = bottomText;
        bottomLabel.textColor = [UIColor colorWithRed:162.0f/255.0f green:167.0f/255.0f blue:183.0f/255.0f alpha:1.0f];
        bottomLabel.textAlignment = NSTextAlignmentCenter;
        bottomLabel.numberOfLines = 0;
        
    }
    
}

#pragma mark - IBAction Methods

- (IBAction)LogInAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Log In Clicked"] completionHandler:^(BOOL finished) {

    }];

    [[[PushObject alloc] init] PushToLoginViewController:self];
  
}

-(IBAction)SignUpButtonAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Sign Up Clicked"] completionHandler:^(BOOL finished) {

    }];

    [[[PushObject alloc] init] PushToSignUpViewController:NO currentViewController:self];
    
}

-(IBAction)NavigationBackButtonAction:(UIBarButtonItem *)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Navigation Back Button Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - Google System Methods
#pragma mark
#pragma mark
#pragma mark
#pragma mark

- (IBAction)GoogleSignInAction:(id)sender {

    [[GIDSignIn sharedInstance] signInWithPresentingViewController:self completion:^(GIDSignInResult * _Nullable signInResult, NSError * _Nullable error) {
        
        [self StartProgressView];
        
        if (error == nil) {
            
            GIDGoogleUser * _Nullable user = signInResult.user;
            
            NSLog(@"User signed in! %@", user);
            
            FIRAuthCredential *credential = [FIRGoogleAuthProvider credentialWithIDToken:user.idToken.tokenString
                                                                             accessToken:user.accessToken.tokenString];
            
            [[FIRAuth auth] signInWithCredential:credential completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
                
                if (error == nil && authResult != nil)  {
                    
                    FIRUser *user = authResult.user;
                    
                    if (user.email != NULL) {
                      
                        [[[GetDataObject alloc] init] GetDataUserWithEmail:user.email completionHandler:^(BOOL finished, FIRQuerySnapshot * _Nullable snapshot) {
                           
                            if (snapshot.documents.count > 0) {
                              
                                [[[InitialViewControllerObject alloc] init] LogInUser_ThirdPartyLogIn:user.email GoogleLogIn:YES AppleLogIn:NO currentViewController:self completionHandler:^(BOOL finished, NSString * _Nonnull errorString) {
                                   
                                    [[[PushObject alloc] init] PushToHomesViewController:YES currentViewController:self];
                                    
                                    [self->progressView setHidden:YES];
                                    
                                    if (errorString.length > 0) {
                                        [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:errorString currentViewController:self];
                                    }
                                    
                                }];
                                
                            } else {
                                
                                [[[InitialViewControllerObject alloc] init] SignUpUser_ThirdPartySignUp:user.email howYouHeardAboutUs:@"yyy" whoIsThisFor:@"yyy" thirdPartySignUp:YES currentViewController:self completionHandler:^(BOOL finished) {
                                    
                                    [[[PushObject alloc] init] PushToSignUpViewController:YES currentViewController:self];
                                    
                                    [self->progressView setHidden:YES];
                                    
                                }];
                                
                            }
                            
                        }];
                        
                    } else {
                        
                        [self->progressView setHidden:YES]; return;
                        
                    }
                    
                } else {
                    
                    [[[GeneralObject alloc] init] CreateAlert:@"Oops!" message:@"This email doesn't seem to be working, please try another one." currentViewController:self];
                    [self->progressView setHidden:YES]; return;
                    
                }
                
            }];
            
        } else if ([error.description containsString:@"The user canceled the sign-in flow"] == NO) {
            
            [[[GeneralObject alloc] init] CreateAlert:@"Oops!" message:@"This email doesn't seem to be working, please try another one." currentViewController:self];
            [self->progressView setHidden:YES]; return;
            
        } else {
            
            [self->progressView setHidden:YES]; return;
            
        }
        
    }];
    
}

#pragma mark - Apple System Methods
#pragma mark
#pragma mark
#pragma mark
#pragma mark

- (IBAction)AppleSignInAction:(id)sender {
    
    if (@available(iOS 13.0, *)) {
 
        // A mechanism for generating requests to authenticate users based on their Apple ID.
        ASAuthorizationAppleIDProvider *appleIDProvider = [ASAuthorizationAppleIDProvider new];

        // Creates a new Apple ID authorization request.
        ASAuthorizationAppleIDRequest *request = appleIDProvider.createRequest;
        // The contact information to be requested from the user during authentication.
        request.requestedScopes = @[ASAuthorizationScopeFullName, ASAuthorizationScopeEmail];

        // A controller that manages authorization requests created by a provider.
        ASAuthorizationController *controller = [[ASAuthorizationController alloc] initWithAuthorizationRequests:@[request]];

        // A delegate that the authorization controller informs about the success or failure of an authorization attempt.
        controller.delegate = self;

        // A delegate that provides a display context in which the system can present an authorization interface to the user.
        controller.presentationContextProvider = self;

        // starts the authorization flows named during controller initialization.
        [controller performRequests];

    }
    
}

- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithAuthorization:(ASAuthorization *)authorization  API_AVAILABLE(ios(13.0)){
   
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Apple Sign In"] completionHandler:^(BOOL finished) {
        
    }];
    
    [self StartProgressView];

    [self startSignInWithAppleFlow];

    NSLog(@"authorization.credential：%@", authorization.credential);

    BOOL ObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:authorization.credential classArr:@[[ASAuthorizationAppleIDCredential class]]];
    
    if (ObjectIsKindOfClass == YES) {

        ASAuthorizationAppleIDCredential *appleIDCredential = authorization.credential;
        NSString *rawNonce = self.currentNonce;
        NSAssert(rawNonce != nil, @"Invalid state: A login callback was received, but no login request was sent.");

        if (appleIDCredential.identityToken == nil) {
            NSLog(@"Unable to fetch identity token.");
            [self->progressView setHidden:YES]; return;
        }

        NSString *idToken = [[NSString alloc] initWithData:appleIDCredential.identityToken
        encoding:NSUTF8StringEncoding];
        if (idToken == nil) {
            NSLog(@"Unable to serialize id token from data: %@", appleIDCredential.identityToken);
        }

        FIROAuthCredential *credential = [FIROAuthProvider credentialWithProviderID:@"apple.com"
        IDToken:idToken
        rawNonce:rawNonce];
       
        [[FIRAuth auth] signInWithCredential:credential completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
            
            if (error == nil && authResult != nil)  {
                
                FIRUser *user = authResult.user;
                
                if (user.email != NULL) {
                    
                    [[[GetDataObject alloc] init] GetDataUserWithEmail:user.email completionHandler:^(BOOL finished, FIRQuerySnapshot * _Nullable snapshot) {
                       
                        if (snapshot.documents.count > 0) {
                            
                            [[[InitialViewControllerObject alloc] init] LogInUser_ThirdPartyLogIn:user.email GoogleLogIn:NO AppleLogIn:YES currentViewController:self completionHandler:^(BOOL finished, NSString * _Nonnull errorString) {
                                
                                [[[PushObject alloc] init] PushToHomesViewController:YES currentViewController:self];
                                
                                [self->progressView setHidden:YES];
                                
                                if (errorString.length > 0) {
                                    [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:errorString currentViewController:self];
                                }
                                
                            }];
                            
                        } else {
                            
                            [[[InitialViewControllerObject alloc] init] SignUpUser_ThirdPartySignUp:user.email howYouHeardAboutUs:@"zzz" whoIsThisFor:@"zzz" thirdPartySignUp:YES currentViewController:self completionHandler:^(BOOL finished) {
                                
                                [[[PushObject alloc] init] PushToSignUpViewController:YES currentViewController:self];
                                
                                [self->progressView setHidden:YES];
                                
                            }];
                            
                        }
                        
                    }];
                    
                } else {
                    
                    [[[GeneralObject alloc] init] CreateAlert:@"Oops!" message:@"This email doesn't seem to be working, please try another one." currentViewController:self];
                    [self->progressView setHidden:YES]; return;
                    
                }
                
            } else {
                
                [[[GeneralObject alloc] init] CreateAlert:@"Oops!" message:@"This email doesn't seem to be working, please try another one." currentViewController:self];
                [self->progressView setHidden:YES]; return;
                
            }
            
        }];
        
    } else {
        
        [self->progressView setHidden:YES]; return;
        
    }
    
}


- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithError:(NSError *)error  API_AVAILABLE(ios(13.0)){
    
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"error ：%@", error);
    NSString *errorMsg = nil;
    switch (error.code) {
        case ASAuthorizationErrorCanceled:
            errorMsg = @"ASAuthorizationErrorCanceled";
            break;
        case ASAuthorizationErrorFailed:
            errorMsg = @"ASAuthorizationErrorFailed";
            break;
        case ASAuthorizationErrorInvalidResponse:
            errorMsg = @"ASAuthorizationErrorInvalidResponse";
            break;
        case ASAuthorizationErrorNotHandled:
            errorMsg = @"ASAuthorizationErrorNotHandled";
            break;
        case ASAuthorizationErrorUnknown:
            errorMsg = @"ASAuthorizationErrorUnknown";
            break;
    }

    NSMutableString *mStr = [_appleIDLoginInfoTextView.text mutableCopy];
    [mStr appendString:errorMsg];
    [mStr appendString:@"\n"];
    _appleIDLoginInfoTextView.text = [mStr copy];

    if (errorMsg) {
        return;
    }

    if (error.localizedDescription) {
        NSMutableString *mStr = [_appleIDLoginInfoTextView.text mutableCopy];
        [mStr appendString:error.localizedDescription];
        [mStr appendString:@"\n"];
        _appleIDLoginInfoTextView.text = [mStr copy];
    }
    NSLog(@"controller requests：%@", controller.authorizationRequests);

}


- (void)handleSignInWithAppleStateChanged:(id)noti {
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"%@", noti);

}

 - (ASPresentationAnchor)presentationAnchorForAuthorizationController:(ASAuthorizationController *)controller  API_AVAILABLE(ios(13.0)){
  
    NSLog(@"window：%s", __FUNCTION__);
    return self.view.window;
}

- (void)dealloc {

    if (@available(iOS 13.0, *)) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:ASAuthorizationAppleIDProviderCredentialRevokedNotification object:nil];
    }
}

- (NSString *)randomNonce:(NSInteger)length {
  NSAssert(length > 0, @"Expected nonce to have positive length");
  NSString *characterSet = @"0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._";
  NSMutableString *result = [NSMutableString string];
  NSInteger remainingLength = length;

  while (remainingLength > 0) {
    NSMutableArray *randoms = [NSMutableArray arrayWithCapacity:16];
    for (NSInteger i = 0; i < 16; i++) {
      uint8_t random = 0;
      int errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random);
      NSAssert(errorCode == errSecSuccess, @"Unable to generate nonce: OSStatus %i", errorCode);

      [randoms addObject:@(random)];
    }

    for (NSNumber *random in randoms) {
      if (remainingLength == 0) {
        break;
      }

      if (random.unsignedIntValue < characterSet.length) {
        unichar character = [characterSet characterAtIndex:random.unsignedIntValue];
        [result appendFormat:@"%C", character];
        remainingLength--;
      }
    }
  }

  return result;
}

- (void)startSignInWithAppleFlow {
   
  NSString *nonce = [self randomNonce:32];
  self.currentNonce = nonce;
  self.currentSHANonce = [self stringBySha256HashingString:nonce];
    
}

- (NSString *)stringBySha256HashingString:(NSString *)input {
  const char *string = [input UTF8String];
  unsigned char result[CC_SHA256_DIGEST_LENGTH];
  CC_SHA256(string, (CC_LONG)strlen(string), result);

  NSMutableString *hashed = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
  for (NSInteger i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
    [hashed appendFormat:@"%02x", result[i]];
  }
  return hashed;
}


//[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"test"];
//
//[UIView animateWithDuration:0.25 delay:0 options:0 animations:^{
//
//    [self->_customScrollView setContentOffset:CGPointMake(self.view.frame.size.width, 0)];
//
//    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"test"] isEqualToString:@"Yes"]) {
//        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"test"];
//        return;
//    }
//
//} completion:^(BOOL finished) {
//
//    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"test"] isEqualToString:@"Yes"]) {
//        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"test"];
//        return;
//    }
//
//    [UIView animateWithDuration:0.25 delay:2 options:0 animations:^{
//
//        [self->_customScrollView setContentOffset:CGPointMake(self.view.frame.size.width*2, 0)];
//
//        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"test"] isEqualToString:@"Yes"]) {
//            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"test"];
//            return;
//        }
//
//    } completion:^(BOOL finished) {
//
//        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"test"] isEqualToString:@"Yes"]) {
//            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"test"];
//            return;
//        }
//
//        [UIView animateWithDuration:0.25 delay:2 options:0 animations:^{
//
//            [self->_customScrollView setContentOffset:CGPointMake(self.view.frame.size.width*3, 0)];
//
//            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"test"] isEqualToString:@"Yes"]) {
//                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"test"];
//                return;
//            }
//
//        } completion:^(BOOL finished) {
//
//            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"test"] isEqualToString:@"Yes"]) {
//                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"test"];
//                return;
//            }
//
//            [UIView animateWithDuration:0.25 delay:2 options:0 animations:^{
//
//                [self->_customScrollView setContentOffset:CGPointMake(self.view.frame.size.width*4, 0)];
//
//                if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"test"] isEqualToString:@"Yes"]) {
//                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"test"];
//                    return;
//                }
//
//            } completion:^(BOOL finished) {
//
//                if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"test"] isEqualToString:@"Yes"]) {
//                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"test"];
//                    return;
//                }
//
//                [UIView animateWithDuration:0.25 delay:2 options:0 animations:^{
//
//                    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"test"] isEqualToString:@"Yes"]) {
//                        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"test"];
//                        return;
//                    }
//
//                    [self->_customScrollView setContentOffset:CGPointMake(0, 0)];
//
//                } completion:^(BOOL finished) {
//
//                    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"test"] isEqualToString:@"Yes"]) {
//                        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"test"];
//                        return;
//                    }
//
//                }];
//
//            }];
//
//        }];
//
//    }];
//
//}];

@end
