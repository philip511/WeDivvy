//
//  WeDivvyPremiumViewController.m
//  WeDivvy
//
//  Created by Philip Nagel on 3/11/22.
//

#import "WeDivvyPremiumViewController.h"

#import "GeneralObject.h"
#import "GetDataObject.h"
#import "SetDataObject.h"
#import "NotificationsObject.h"
#import "PushObject.h"
#import "BoolDataObject.h"
#import "LightDarkModeObject.h"

#import <MRProgressOverlayView.h>

#import "PremiumFeatureCell.h"
#import "PremiumPlanCell.h"

@interface WeDivvyPremiumViewController () {
    
    MRProgressOverlayView *progressView;
    
    NSMutableArray *premiumFeatureNameArray;
    NSMutableArray *premiumFeatureDetailsArray;
    NSMutableArray *premiumFeatureAppIcon;
    NSMutableArray *premiumFeatureImage;
    
    NSMutableArray *localPremiumPlanProductsArray;
    NSMutableDictionary *localPremiumPlanPricesDict;
    NSMutableDictionary *localPremiumPlanExpensivePricesDict;
    NSMutableDictionary *localPremiumPlanPricesDiscountDict;
    NSMutableDictionary *localPremiumPlanPricesNoFreeTrialDict;
    
    NSDictionary *premiumPlanPricesSavingsDict;
    NSDictionary *premiumPlanDescriptionDict;
    NSMutableArray *premiumPlanImagesArray;
    
    NSString *defaultPremiumPlanName;
    NSString *defaultPremiumPlanPrice;
    
    NSIndexPath *selectedIndex;
    
    BOOL moreOptionsClicked;
    BOOL JustOpenned;
    
    NSMutableArray *homeMembersArray;
    
    NSMutableDictionary *folderDict;
    NSMutableDictionary *taskListDict;
    NSMutableDictionary *sectionDict;
    NSMutableDictionary *templateDict;
    NSMutableDictionary *homeMembersDict;
    NSMutableDictionary *notificationSettingsDict;
    NSMutableDictionary *topicDict;
    NSMutableDictionary *promoCodeDict;
    
    UIView *dotOne;
    UIView *dotTwo;
    UIView *dotThree;
    UIView *dotFour;
    UIView *dotFive;
    
    UILabel *scrollingLabelView;
    
    UIView *introViewOne;
    UIView *introViewTwo;
    UIView *introViewThree;
    UIView *introViewFour;
    UIView *introViewFive;
    UIView *introViewSix;
    UIView *introViewSeven;
    UIView *introViewEight;
    UIView *introViewNine;
    UIView *introViewTen;
    UIView *introViewEleven;
    UIView *introViewTwelve;
    UIView *introViewThirteen;
    UIView *introViewFourteen;
    UIView *introViewFifteen;
    UIView *introViewSixteen;
    UIView *introViewSeventeen;
    UIView *introViewEightteen;
    UIView *introViewNineteen;
    UIView *introViewTwenty;
    UIView *introViewTwentyOne;
    
    UIImageView *introImageOne;
    UIImageView *introImageTwo;
    UIImageView *introImageThree;
    UIImageView *introImageFour;
    UIImageView *introImageFive;
    UIImageView *introImageSix;
    UIImageView *introImageSeven;
    UIImageView *introImageEight;
    UIImageView *introImageNine;
    UIImageView *introImageTen;
    UIImageView *introImageEleven;
    UIImageView *introImageTwelve;
    UIImageView *introImageThirteen;
    UIImageView *introImageFourteen;
    UIImageView *introImageFifteen;
    UIImageView *introImageSixteen;
    UIImageView *introImageSeventeen;
    UIImageView *introImageEightteen;
    UIImageView *introImageNineteen;
    UIImageView *introImageTwenty;
    UIImageView *introImageTwentyOne;
    
    UILabel *introHeadLabelOne;
    UILabel *introHeadLabelTwo;
    UILabel *introHeadLabelThree;
    UILabel *introHeadLabelFour;
    UILabel *introHeadLabelFive;
    UILabel *introHeadLabelSix;
    UILabel *introHeadLabelSeven;
    UILabel *introHeadLabelEight;
    UILabel *introHeadLabelNine;
    UILabel *introHeadLabelTen;
    UILabel *introHeadLabelEleven;
    UILabel *introHeadLabelTwelve;
    UILabel *introHeadLabelThirteen;
    UILabel *introHeadLabelFourteen;
    UILabel *introHeadLabelFifteen;
    UILabel *introHeadLabelSixteen;
    UILabel *introHeadLabelSeventeen;
    UILabel *introHeadLabelEightteen;
    UILabel *introHeadLabelNineteen;
    UILabel *introHeadLabelTwenty;
    UILabel *introHeadLabelTwentyOne;
    
    UILabel *subLabelOne;
    UILabel *subLabelTwo;
    UILabel *subLabelThree;
    UILabel *subLabelFour;
    UILabel *subLabelFive;
    UILabel *subLabelSix;
    UILabel *subLabelSeven;
    UILabel *subLabelEight;
    UILabel *subLabelNine;
    UILabel *subLabelTen;
    UILabel *subLabelEleven;
    UILabel *subLabelTwelve;
    UILabel *subLabelThirteen;
    UILabel *subLabelFourteen;
    UILabel *subLabelFifteen;
    UILabel *subLabelSixteen;
    UILabel *subLabelSeventeen;
    UILabel *subLabelEightteen;
    UILabel *subLabelNineteen;
    UILabel *subLabelTwenty;
    UILabel *subLabelTwentyOne;
    
}

@end

@implementation WeDivvyPremiumViewController

#pragma mark - System Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([[[GeneralObject alloc] init] ConnectedToInternet] == NO) {
        [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You need to be connected to the internet to do that." currentViewController:self];
        
        [self DismissViewController:self];
        
    }
    
    
    
    
    [[[GeneralObject alloc] init] CheckPremiumSubscriptionStatus:homeMembersDict completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningHomeMembersDict) {
        
    }];
    
    
    
    
    [self InitMethod];

    [self BarButtonItem];

    [self TapGestures];

    [self KeyboardNSNotifications];
    
    [self FetchAvailableProducts];




    NSString *defaultPremiumPlanLocal = defaultPremiumPlanName ? defaultPremiumPlanName : @"";
    NSString *premiumPlanDetailsLocal = premiumPlanDescriptionDict[defaultPremiumPlanName] ? premiumPlanDescriptionDict[defaultPremiumPlanName] : @"";

    [self AdjustPurchaseView:defaultPremiumPlanLocal premiumPlanDetails:premiumPlanDetailsLocal];
    [self AdjustPricesOfCurrentPlan];




    [self.premiumPlanTableView reloadData];
    [self.premiumFeaturesTableView reloadData];
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    _displayDiscount = @"Half-Off Yearly Discount";
    
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    
    _requestFeedbackAlertViewSubmitButtonLabel.backgroundColor = [[[GeneralObject alloc] init] GenerateAppColor:1.0f];
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    _requestFeedbackBackDropView.frame = CGRectMake(0, 0, width, height);
    _requestFeedbackBackDropView.alpha = 0.0;
    
    _requestFeedbackAlertView.frame = CGRectMake(0, height, width, ((height*0.53668478) > 395?(395):(height*0.53668478)));
    
    _enterPromoCodeBackdropView.frame = CGRectMake(0, 0, width, height);
    _enterPromoCodeBackdropView.alpha = 0.0;
    
    _enterPromoCodeAlertView.frame = CGRectMake(0, height, width, 200);
    
    UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:self.requestFeedbackAlertView.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight) cornerRadii:CGSizeMake(_requestFeedbackAlertView.frame.size.height*0.15, _requestFeedbackAlertView.frame.size.height*0.15)];
    
    CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
    maskLayer1.frame = self.requestFeedbackAlertView.bounds;
    maskLayer1.path  = maskPath1.CGPath;
    self.requestFeedbackAlertView.layer.mask = maskLayer1;
    
    
    
    width = CGRectGetWidth(self.requestFeedbackAlertView.bounds);
    height = CGRectGetHeight(self.requestFeedbackAlertView.bounds);
    
    _requestFeedbackAlertViewXIcon.frame = CGRectMake(width - ((height*0.1) > 20?(20):(height*0.1)) - height*0.1, height*0.1, ((height*0.1) > 20?(20):(height*0.1)), ((height*0.1) > 20?(20):(height*0.1)));
    
    _requestFeedbackAlertViewXIconCover.frame = CGRectMake(_requestFeedbackAlertViewXIcon.frame.origin.x - height*0.1, _requestFeedbackAlertViewXIcon.frame.origin.y - height*0.1, _requestFeedbackAlertViewXIcon.frame.size.width + ((height*0.1)*2), _requestFeedbackAlertViewXIcon.frame.size.height + ((height*0.1)*2));
    
    _requestFeedbackAlertViewQuestionLabel.frame = CGRectMake((width - _requestFeedbackAlertViewXIcon.frame.origin.x) + height*0.05, height*0.1, width - (((width -_requestFeedbackAlertViewXIcon.frame.origin.x))*2) - height*0.1, ((height*0.1) > 20?(20):(height*0.1)));
    _requestFeedbackAlertViewQuestionLabel.font = [UIFont systemFontOfSize:_requestFeedbackAlertViewQuestionLabel.frame.size.height*0.9 weight:UIFontWeightHeavy];
    
    _buttonQuestionSubLabel.frame = CGRectMake(height*0.1, height*0.19783198, width - ((height*0.1)*2), ((height*0.53164557) > 210?(210):(height*0.53164557)));
    _buttonQuestionSubLabel.font = [UIFont systemFontOfSize:((_buttonQuestionSubLabel.frame.size.height*0.07142857) > 14?(14):(_buttonQuestionSubLabel.frame.size.height*0.07142857)) weight:UIFontWeightHeavy];
    
    _requestFeedbackAlertViewSubmitButtonLabel.frame = CGRectMake(width*0.5 - ((width - ((width*0.09661836)*2))*0.5), height - ((height*0.2375) > 47.5?(47.5):(height*0.2375)) - height*0.1, width - ((width*0.09661836)*2), ((height*0.2375) > 47.5?(47.5):(height*0.2375)));
    _requestFeedbackAlertViewSubmitButtonLabel.titleLabel.font = [UIFont systemFontOfSize:((_requestFeedbackAlertViewSubmitButtonLabel.frame.size.height*0.31578947) > 15?(15):(_requestFeedbackAlertViewSubmitButtonLabel.frame.size.height*0.31578947)) weight:UIFontWeightSemibold];
    _requestFeedbackAlertViewSubmitButtonLabel.clipsToBounds = YES;
    _requestFeedbackAlertViewSubmitButtonLabel.layer.cornerRadius = 7;
    
    
    
    
    
    maskPath1 = [UIBezierPath bezierPathWithRoundedRect:self.enterPromoCodeAlertView.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight) cornerRadii:CGSizeMake(_enterPromoCodeAlertView.frame.size.height*0.15, _enterPromoCodeAlertView.frame.size.height*0.15)];
    
    maskLayer1 = [[CAShapeLayer alloc] init];
    maskLayer1.frame = self.enterPromoCodeAlertView.bounds;
    maskLayer1.path  = maskPath1.CGPath;
    self.enterPromoCodeAlertView.layer.mask = maskLayer1;
    
    
    
    width = CGRectGetWidth(self.enterPromoCodeAlertView.bounds);
    height = CGRectGetHeight(self.enterPromoCodeAlertView.bounds);
    
    _enterPromoCodeCloseImage.frame = CGRectMake(width - ((height*0.1) > 20?(20):(height*0.1)) - height*0.1, height*0.1, ((height*0.1) > 20?(20):(height*0.1)), ((height*0.1) > 20?(20):(height*0.1)));
    
    _enterPromoCodeCloseImageCover.frame = CGRectMake(_enterPromoCodeCloseImage.frame.origin.x - height*0.1, _enterPromoCodeCloseImage.frame.origin.y - height*0.1, _enterPromoCodeCloseImage.frame.size.width + ((height*0.1)*2), _enterPromoCodeCloseImage.frame.size.height + ((height*0.1)*2));
    
    _enterPromoCodeTitleLabel.frame = CGRectMake((width - _enterPromoCodeCloseImage.frame.origin.x) + height*0.05, height*0.1, width - (((width -_enterPromoCodeCloseImage.frame.origin.x))*2) - height*0.1, ((height*0.1) > 20?(20):(height*0.1)));
    _enterPromoCodeTitleLabel.font = [UIFont systemFontOfSize:_enterPromoCodeTitleLabel.frame.size.height*0.9 weight:UIFontWeightHeavy];
    
    _enterPromoCodeTextFieldView.frame = CGRectMake(width*0.5 - (width*0.5)*0.5, height*0.5 - 44*0.5, width*0.5, 44);
    _enterPromoCodeTextFieldView.layer.cornerRadius = _enterPromoCodeTextFieldView.frame.size.height/5;
    
    _enterPromoCodeRulesAndRegulationsLabel.frame = CGRectMake(0, height - 20 - 20, width, 20);
    
    width = CGRectGetWidth(self.enterPromoCodeTextFieldView.bounds);
    height = CGRectGetHeight(self.enterPromoCodeTextFieldView.bounds);
    
    _enterPromoCodeTextField.frame = CGRectMake(width*0.05, 0, width - width*0.10, height);
    _enterPromoCodeTextField.delegate = self;
    
    
    
    
    
    //_buttonQuestionSubLabel1.adjustsFontSizeToFitWidth = YES;
    
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        self.view.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
        self.mainLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        self.requestFeedbackBackDropView.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:0.1f];
        self.requestFeedbackAlertView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModePrimary];
        self.requestFeedbackAlertViewQuestionLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        self.requestFeedbackAlertViewQuestionLabel.backgroundColor = [UIColor clearColor];
        self.buttonQuestionSubLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        self.purchaseSubscriptionView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeTertiary];
        self.simpleOptionLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        self.premiumPlanLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        
    }
    
    
    
    _buttonQuestionSubLabel.scrollEnabled = NO;
    _buttonQuestionSubLabel.editable = NO;
    _buttonQuestionSubLabel.textContainer.lineFragmentPadding = 0;
    _buttonQuestionSubLabel.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _buttonQuestionSubLabel.delegate = self;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    height = CGRectGetHeight(self.view.bounds);
    width = CGRectGetWidth(self.view.bounds);
    
    _premiumFeaturesScrollView.frame = CGRectMake(0, 0, width, height);
    
    
    
    
    height = CGRectGetHeight(self.premiumFeaturesScrollView.bounds);
    width = CGRectGetWidth(self.premiumFeaturesScrollView.bounds);
    
    //_mainImage.frame = CGRectMake(0, 0, width, height*0.20380435);
    _mainImage.hidden = YES;
    
    _mainLabel.frame = CGRectMake(0, /*_mainImage.frame.origin.y + _mainImage.frame.size.height + (height*0.01086957)*/0, 0, height*0.03533569);
    _subTitleLabel.frame = CGRectMake(width*0.5 - ((width*0.9)*0.5), _mainLabel.frame.origin.y + _mainLabel.frame.size.height, width*0.9, height*0.0625);
    
    _mainLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(self.view.frame.size.height*0.03396739 > 25?(25):self.view.frame.size.height*0.03396739)];
    _mainLabel.adjustsFontSizeToFitWidth = YES;
    
    CGFloat widthOfString = [[[GeneralObject alloc] init] WidthOfString:_mainLabel.text withFont:_mainLabel.font];
    
    CGRect newRect = _mainLabel.frame;
    newRect.origin.x = self.view.frame.size.width*0.5 - widthOfString*0.5;
    newRect.size.width = widthOfString;
    _mainLabel.frame = newRect;
    
    _saleImage.frame = CGRectMake(_mainLabel.frame.origin.x + _mainLabel.frame.size.width - ((height*0.05033557)*0.14), _mainLabel.frame.origin.y - ((height*0.05033557)*0.56), height*0.05033557, height*0.05033557);
    _saleImage.hidden = [_displayDiscount length] > 0 && _viewingSlideShow == NO ? NO : YES;
    
    _subTitleLabel.font = [UIFont systemFontOfSize:(_subTitleLabel.frame.size.height*0.26 > 14?(14):_subTitleLabel.frame.size.height*0.26) weight:UIFontWeightMedium];
    
    _mainLabel.adjustsFontSizeToFitWidth = YES;
    _subTitleLabel.adjustsFontSizeToFitWidth = YES;
    
    CGFloat tableViewHeight = (self.view.frame.size.height*0.10461957 > 77?(77):self.view.frame.size.height*0.10461957)*[premiumFeatureNameArray count];
    
    _premiumFeaturesTableView.frame = CGRectMake(0, _subTitleLabel.frame.origin.y + _subTitleLabel.frame.size.height + (height*0.01086957)*2, self.view.frame.size.width, tableViewHeight);
    
    [self AdjustPurchaseView:_premiumPlanLabel.text premiumPlanDetails:premiumPlanDescriptionDict[_premiumPlanLabel.text]];
    
}

-(BOOL)prefersStatusBarHidden {
    return YES;
}

-(void)viewWillDisappear:(BOOL)animated {
    
    if (scrollingLabelView != nil && scrollingLabelView != NULL && _viewingSlideShow == NO) {
        
        scrollingLabelView.hidden = YES;
        
    }
   
    // Check the current authorization status for notifications
    [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        
        NSMutableArray *homeMembersArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeMembers"];
        BOOL ThisIsANewHomeWithNoChores = [homeMembersArray count] == 1;
        
        if (settings.authorizationStatus == UNAuthorizationStatusAuthorized || ThisIsANewHomeWithNoChores == YES) {
            [[[GeneralObject alloc] init] CallNSNotificationMethods:@"DisplayAddTaskTutorialView" userInfo:nil locations:@[@"Tasks"]];
        }
        
    }];
    
}

-(void)viewDidDisappear:(BOOL)animated {
    
    if (scrollingLabelView != nil && scrollingLabelView != NULL && _viewingSlideShow == NO) {
        
        scrollingLabelView.hidden = YES;
        
    }
    
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction;
{
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == _enterPromoCodeTextField) {
        
        [self GetPromoCode:textField];
        
    }
    
    return YES;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"WeDivvy Premium View Controller Scrolling"] completionHandler:^(BOOL finished) {
        
    }];
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (scrollView == _premiumFeatureSlidesScrollViewNo1) {
        
        int totalNumberOfFeatures = 19;
        
        double page = scrollView.contentOffset.x / self.view.frame.size.width;
        int pageNo1 = ceil(page) + 1;
        
        if (pageNo1 > totalNumberOfFeatures) {
            pageNo1 = pageNo1 % totalNumberOfFeatures;
        }
        if (pageNo1 == 0) {
            pageNo1 = totalNumberOfFeatures;
        }
        
        scrollingLabelView.text = [NSString stringWithFormat:@"%.0d/%d", pageNo1, totalNumberOfFeatures];
        
        NSArray *arr = @[introViewOne, introViewTwo, introViewThree, introViewFour, introViewFive, introViewSix, introViewSeven, introViewEight, introViewNine, introViewTen, introViewEleven, introViewTwelve, introViewThirteen, introViewFourteen, introViewFifteen, introViewSixteen, introViewSeventeen, introViewEightteen, introViewNineteen, introViewTwenty];
        
        if (page == 1) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 2) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 3) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 4) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 5) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 6) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 7) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 8) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 9) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 10) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 11) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 12) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 13) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 14) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 15) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 16) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 17) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 18) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 19) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 20) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 21) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 22) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 23) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 24) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 25) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 26) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 27) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 28) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 29) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 30) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 31) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 32) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 33) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 34) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 35) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 36) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 37) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 38) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 39) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 40) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 41) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 42) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 43) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 44) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 45) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 46) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 47) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 48) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
        } else if (page == 49) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 50) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 51) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 52) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 53) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 54) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 55) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 56) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 57) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 58) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 59) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 60) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 61) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 62) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 63) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 64) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 65) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 66) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 67) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 68) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 69) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 70) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 71) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 72) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 73) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 74) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 75) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 76) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 77) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 78) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 79) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        } else if (page == 80) {
            UIView *view = [arr count] > [self GeneratePageNum:page arr:arr Up:YES Down:NO] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:YES Down:NO]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];;
            CGRect newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page+1);
            view.frame = newRect;
            view = [arr count] > [self GeneratePageNum:page arr:arr Up:NO Down:YES] ? (UIView *)arr[[self GeneratePageNum:page arr:arr Up:NO Down:YES]] : [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            newRect = view.frame;
            newRect.origin.x = self.view.frame.size.width*((int)page-1);
            view.frame = newRect;
        }
        
    }
    
}

#pragma mark - Keyboard Methods

- (void)keyboardWillShow: (NSNotification *) notification{
    
    [UIView animateWithDuration:0.25 animations:^{
        
        NSDictionary* keyboardInfo = [notification userInfo];
        NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
        CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
        
        CGFloat width = CGRectGetWidth(self.view.bounds);
        CGFloat height = CGRectGetHeight(self.view.bounds);
        
        self->_enterPromoCodeBackdropView.frame = CGRectMake(0, 0, width, height);
        self->_enterPromoCodeBackdropView.alpha = 1.0;
        
        CGRect newRect = self->_enterPromoCodeAlertView.frame;
        newRect.origin.y = CGRectGetHeight(self.view.bounds)-keyboardFrameBeginRect.size.height-newRect.size.height;
        self->_enterPromoCodeAlertView.frame = newRect;
        
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)keyboardWillHide: (NSNotification *) notification{
    
    [UIView animateWithDuration:0.25 animations:^{
        
        CGFloat width = CGRectGetWidth(self.view.bounds);
        CGFloat height = CGRectGetHeight(self.view.bounds);
        
        self->_enterPromoCodeBackdropView.alpha = 0.0;
        
        self->_enterPromoCodeAlertView.frame = CGRectMake(0, height, width, (self.view.frame.size.height*0.29985) > 200?(200):(self.view.frame.size.height*0.29985));
        
    } completion:^(BOOL finished) {
        
        self->_enterPromoCodeTextField.text = @"";
        
    }];
    
}


#pragma mark - Init Methods

-(void)InitMethod {
    
    [self SetMoreOptionsOnByDefault:YES];
    
    [self SetUpAnalytics];
    
    [self SetUpDelegates];
    
    [self SetUpSubtitle];
    
    [self SetUpWeDivvyPremiumOpenningDateAndTime];
    
    [self SetUpInitData];

    [self SetUpDictsAndArrays];

    [self SetUpPlanContextMenu];

    [self SetUpDefaultPlan];

    [self SetUpAttributedString];

    [self SetUpViews];

    [self SetUpUI];
    
}

-(void)BarButtonItem {
    
    self.navigationItem.hidesBackButton = YES;
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"xmark.circle.fill"] style:UIBarButtonItemStylePlain target:self action:@selector(NavigationBackButtonAction:)];
    leftBarButton.tintColor = [UIColor colorWithRed:55.0f/255.0f green:81.0f/255.0f blue:101.0f/255.0f alpha:0.85];
    
    BOOL PremiumSubscriptionIsOn = [[[BoolDataObject alloc] init] PremiumSubscriptionIsOn];
    BOOL SideBarPopupAlreadyClicked = [[NSUserDefaults standardUserDefaults] objectForKey:@"SideBarPopupClicked"];
    
    if (PremiumSubscriptionIsOn == YES || [[[NSUserDefaults standardUserDefaults] objectForKey:@"JoinedHome"] isEqualToString:@"Yes"] == YES) {
        
        self.navigationItem.leftBarButtonItem = leftBarButton;
        
    }
    
    if (_viewingSlideShow == NO) {
        
        UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"questionmark.circle"] style:UIBarButtonItemStylePlain target:self action:@selector(FAQButton:)];
        rightBarButton.tintColor = [UIColor linkColor];
        self.navigationItem.rightBarButtonItem = rightBarButton;
        
    }
    
}

-(void)TapGestures {
    
    UITapGestureRecognizer *tapGesture;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ResignPromoCodeTextField:)];
    [_enterPromoCodeBackdropView addGestureRecognizer:tapGesture];
    _enterPromoCodeBackdropView.userInteractionEnabled = YES;
    
//    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(EnterPromoCodeAction:)];
//    [_promotionalCodeButton addGestureRecognizer:tapGesture];
//    _promotionalCodeButton.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ResignPromoCodeTextField:)];
    [_enterPromoCodeCloseImageCover addGestureRecognizer:tapGesture];
    _enterPromoCodeCloseImageCover.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(DisplayTOS:)];
    [_TOSLabel addGestureRecognizer:tapGesture];
    _TOSLabel.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(MoreOptions:)];
    [_moreOptionsLabel addGestureRecognizer:tapGesture];
    _moreOptionsLabel.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(RestorePurchases:)];
    [_restorePurchasesLabel addGestureRecognizer:tapGesture];
    _restorePurchasesLabel.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(DisplayRulesAndRestrictionsAction:)];
    [_enterPromoCodeRulesAndRegulationsLabel addGestureRecognizer:tapGesture];
    _enterPromoCodeRulesAndRegulationsLabel.userInteractionEnabled = YES;
   
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(CloseTOSPopupAction:)];
    [_requestFeedbackAlertViewXIconCover addGestureRecognizer:tapGesture];
    _requestFeedbackAlertViewXIconCover.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(CloseTOSPopupAction:)];
    [_requestFeedbackAlertViewSubmitButtonLabel addGestureRecognizer:tapGesture];
    _requestFeedbackAlertViewSubmitButtonLabel.userInteractionEnabled = YES;
    
}

-(void)KeyboardNSNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}

#pragma mark - Set Up Methods

-(void)SetMoreOptionsOnByDefault:(BOOL)Yes {
    
    if (Yes) {
        
        JustOpenned = YES;
        moreOptionsClicked = YES;
        self->_moreOptionsLabel.text = @"Simple Option";
        
        
    } else {
        
        JustOpenned = YES;
        moreOptionsClicked = NO;
        self->_moreOptionsLabel.text = @"More Options";
        
    }
    
}

-(void)SetUpAnalytics {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewViewController:@"WeDivvyPremiumViewController" completionHandler:^(BOOL finished) {
        
    }];
    
    [[[GeneralObject alloc] init] TrackInMixPanel:@"WeDivvyPremiumViewController"];
    
}

-(void)SetUpDelegates {
    
    _premiumFeaturesTableView.delegate = self;
    _premiumFeaturesTableView.dataSource = self;
    
    _premiumPlanTableView.delegate = self;
    _premiumPlanTableView.dataSource = self;
    
    _premiumFeaturesScrollView.delegate = self;
    _premiumFeatureSlidesScrollViewNo1.delegate = self;
    
}

-(void)SetUpSubtitle {
    
    _subTitleLabel.text = [NSString stringWithFormat:@"\nGet the best of WeDivvy by unlocking task searching, swipe to complete, offline usage, and so much more! ⭐️"];
    
}

-(void)SetUpWeDivvyPremiumOpenningDateAndTime {
    
    if (_comingFromSignUp || ![[NSUserDefaults standardUserDefaults] objectForKey:@"DisplayWeDivvyPremiumPage"]) {
        
        NSString *dateStringCurrent = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:@"MMMM dd, yyyy hh:mm:ss a" returnAs:[NSString class]];
        
        [[NSUserDefaults standardUserDefaults] setObject:dateStringCurrent forKey:@"DisplayWeDivvyPremiumPage"];
        
    }
    
}

-(void)SetUpInitData {
    
    folderDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"FolderDict"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"FolderDict"] mutableCopy] : [NSMutableDictionary dictionary];
    taskListDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskListDict"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"TaskListDict"] mutableCopy] : [NSMutableDictionary dictionary];
    sectionDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"SectionDict"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"SectionDict"] mutableCopy] : [NSMutableDictionary dictionary];
    templateDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"TemplateDict"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"TemplateDict"] mutableCopy] : [NSMutableDictionary dictionary];
    notificationSettingsDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"NotificationSettingsDict"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"NotificationSettingsDict"] mutableCopy] : [NSMutableDictionary dictionary];
    topicDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"TopicDict"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"TopicDict"] mutableCopy] : [NSMutableDictionary dictionary];
    
    homeMembersDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeMembersDict"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"HomeMembersDict"] mutableCopy] : [NSMutableDictionary dictionary];
    homeMembersArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeMembersArray"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"HomeMembersArray"] mutableCopy] : [NSMutableArray array];
    
}

-(void)SetUpDictsAndArrays {
    
    premiumFeatureNameArray = [NSMutableArray array];
    
    //    [premiumFeatureNameArray addObject:@"Advanced Analytics"];
//    [premiumFeatureNameArray addObject:@"Unlimited Tasks"];
    [premiumFeatureNameArray addObject:@"Search Tasks"];
    [premiumFeatureNameArray addObject:@"Swipe Actions"];
    [premiumFeatureNameArray addObject:@"WeDivvy Offline"];
    [premiumFeatureNameArray addObject:@"24/7 Support"];
    //    [premiumFeatureNameArray addObject:@"View Home Activity"];
    //    [premiumFeatureNameArray addObject:@"View Task Activity"];
    [premiumFeatureNameArray addObject:@"Custom Shortcuts"];
    //    [premiumFeatureNameArray addObject:@"Advanced Text Options"];
    [premiumFeatureNameArray addObject:@"Third Reminder"];
    [premiumFeatureNameArray addObject:@"Private Tasks"];
    [premiumFeatureNameArray addObject:@"Mute Tasks"];
    [premiumFeatureNameArray addObject:@"Unlimited Homes"];
    [premiumFeatureNameArray addObject:@"Premium Badge"];
    [premiumFeatureNameArray addObject:@"Unlimited Templates"];
    [premiumFeatureNameArray addObject:@"Scheduled Start"];
    //    [premiumFeatureNameArray addObject:@"Photo Confirmation"];
    [premiumFeatureNameArray addObject:@"Require Approval"];
    [premiumFeatureNameArray addObject:@"Unlimited Summary Notifications"];
    [premiumFeatureNameArray addObject:@"Auto Dark Mode"];
    [premiumFeatureNameArray addObject:@"Default Launch Page"];
    [premiumFeatureNameArray addObject:@"Custom App Icons"];
    [premiumFeatureNameArray addObject:@"Custom App Themes"];
    [premiumFeatureNameArray addObject:@"Additional Task Colors"];
    
    premiumFeatureDetailsArray = [NSMutableArray array];
    
    //    [premiumFeatureDetailsArray addObject:@"View simple and informative statistics on each home members performance"];
//    [premiumFeatureDetailsArray addObject:@"Create an unlimited amount of\nchores, expenses, and lists"];
    [premiumFeatureDetailsArray addObject:@"Easily search through and find\nany of your tasks with ease"];
    [premiumFeatureDetailsArray addObject:@"Quickly swipe to mark a task completed, in progress, to pin it, or to mute it"];
    [premiumFeatureDetailsArray addObject:@"Check on your tasks whether your in a tunnel,\non the ocean, or on the move"];
    [premiumFeatureDetailsArray addObject:@"Always have a dedicated WeDivvy representative\nready to help you whenever you need"];
    //    [premiumFeatureDetailsArray addObject:@"See what you and your home members\nhave been up to in the app"];
    //    [premiumFeatureDetailsArray addObject:@"See the history of any task, including\ncompletions, editing, comments, etc."];
    [premiumFeatureDetailsArray addObject:@"Customize the shortcut actions you see\nwhen you hold down the WeDivvy app icon"];
    //    [premiumFeatureDetailsArray addObject:@"Make your task notes and your chat messages more captivating and organized"];
    [premiumFeatureDetailsArray addObject:@"On top of the 2 reminders you automatically get,\nunlock an optional 3rd reminder just in case"];
    [premiumFeatureDetailsArray addObject:@"Create tasks that only you and the\nhome members that are assigned can see"];
    [premiumFeatureDetailsArray addObject:@"Have the option of receiving or not\nreceiving notifications from any task"];
    [premiumFeatureDetailsArray addObject:@"You can create and join an\nunlimited number of homes"];
    [premiumFeatureDetailsArray addObject:@"You'll have a cool badge next to your\nname which everyone will be jealous of"];
    [premiumFeatureDetailsArray addObject:@"Reduce your time creating tasks with unlimited custom task templates"];
    [premiumFeatureDetailsArray addObject:@"Schedule tasks to begin in advance. They'll be hidden from others until their start time"];
    //    [premiumFeatureDetailsArray addObject:@"Require assignees of tasks to submit a photo to prove they completed a task"];
    [premiumFeatureDetailsArray addObject:@"Require the approval of the task creator before a task is officially marked completed"];
    [premiumFeatureDetailsArray addObject:@"Create unlimited summary notifications to notify you of your tasks for the day, week, or month"];
    [premiumFeatureDetailsArray addObject:@"Set a time when you'd like dark mode to automatically be turned on and turned off"];
    [premiumFeatureDetailsArray addObject:@"Choose the first page you see\nwhen you open the app"];
    [premiumFeatureDetailsArray addObject:@"Unlock 25 \"super fresh\" WeDivvy app icons to show off to your home members"];
    [premiumFeatureDetailsArray addObject:@"Choose WeDivvy's color theme\nfrom 30 color schemes"];
    [premiumFeatureDetailsArray addObject:@"Unlock an additional 24 \"fancy pants\"\ncolors to organize your tasks with"];
    
    premiumFeatureAppIcon = [NSMutableArray array];
    
    //    [premiumFeatureAppIcon addObject:@"PremiumCellIcons.AdvancedAnalytics"];
//    [premiumFeatureAppIcon addObject:@"PremiumCellIcons.UnlimitedTasks"];
    [premiumFeatureAppIcon addObject:@"PremiumCellIcons.SearchTasks"];
    [premiumFeatureAppIcon addObject:@"PremiumCellIcons.SwipeTasks"];
    [premiumFeatureAppIcon addObject:@"PremiumCellIcons.Offline"];
    [premiumFeatureAppIcon addObject:@"PremiumCellIcons.CustomService"];
    //    [premiumFeatureAppIcon addObject:@"PremiumCellIcons.UserActivity"];
    //    [premiumFeatureAppIcon addObject:@"PremiumCellIcons.TaskActivity"];
    [premiumFeatureAppIcon addObject:@"SettingsIcons.Shortcut"];
    //    [premiumFeatureAppIcon addObject:@"PremiumCellIcons.AdvancedTextOptions"];
    [premiumFeatureAppIcon addObject:@"PremiumCellIcons.AdditionalReminders"];
    [premiumFeatureAppIcon addObject:@"PremiumCellIcons.PrivateTask"];
    [premiumFeatureAppIcon addObject:@"PremiumCellIcons.MuteTask"];
    [premiumFeatureAppIcon addObject:@"PremiumCellIcons.UnlimitedHomes"];
    [premiumFeatureAppIcon addObject:@"PremiumCellIcons.PremiumBadge"];
    [premiumFeatureAppIcon addObject:@"PremiumCellIcons.UnlimitedTemplates"];
    [premiumFeatureAppIcon addObject:@"PremiumCellIcons.ScheduledStart"];
    //    [premiumFeatureAppIcon addObject:@"PremiumCellIcons.PhotoConfirmation"];
    [premiumFeatureAppIcon addObject:@"PremiumCellIcons.RequestApproval"];
    [premiumFeatureAppIcon addObject:@"PremiumCellIcons.UnlimitedSummaryNotifications"];
    [premiumFeatureAppIcon addObject:@"PremiumCellIcons.AutoDark"];
    [premiumFeatureAppIcon addObject:@"PremiumCellIcons.DefaultLaunchPage"];
    [premiumFeatureAppIcon addObject:@"PremiumCellIcons.AppIcon"];
    [premiumFeatureAppIcon addObject:@"PremiumCellIcons.AppTheme"];
    [premiumFeatureAppIcon addObject:@"PremiumCellIcons.AppColors"];
    
    premiumFeatureImage = [NSMutableArray array];
    
    //    [premiumFeatureImage addObject:@"PremiumCellIcons.AdvancedAnalytics"];
//    [premiumFeatureImage addObject:@"UnlimitedTasks"];
    [premiumFeatureImage addObject:@"SearchTasks"];
    [premiumFeatureImage addObject:@"SwipeActions"];
    [premiumFeatureImage addObject:@"Offline"];
    [premiumFeatureImage addObject:@"Offline"];
    //    [premiumFeatureImage addObject:@"HomeActivities"];
    //    [premiumFeatureImage addObject:@"TaskActivities"];
    [premiumFeatureImage addObject:@"CustomShortcuts"];
    //    [premiumFeatureImage addObject:@"PremiumCellIcons.AdvancedTextOptions"];
    [premiumFeatureImage addObject:@"UnlimitedAdditionalReminders"];
    [premiumFeatureImage addObject:@"PrivateTasks"];
    [premiumFeatureImage addObject:@"MuteTasks"];
    [premiumFeatureImage addObject:@"UnlimitedHomes"];
    [premiumFeatureImage addObject:@"PremiumBadge"];
    [premiumFeatureImage addObject:@"UnlimitedTemplates"];
    [premiumFeatureImage addObject:@"ScheduledStart"];
    //    [premiumFeatureImage addObject:@"PremiumCellIcons.PhotoConfirmation"];
    [premiumFeatureImage addObject:@"RequireApproval"];
    [premiumFeatureImage addObject:@"UnlimitedSummaryNotifications"];
    [premiumFeatureImage addObject:@"AutoDarkMode"];
    [premiumFeatureImage addObject:@"DefaultLaunchPage"];
    [premiumFeatureImage addObject:@"CustomAppIcons"];
    [premiumFeatureImage addObject:@"CustomAppThemes"];
    [premiumFeatureImage addObject:@"AdditionalTaskColors"];
    
    localPremiumPlanPricesDict = [@{
        @"Individual Plan" : @[@"$x.99", @"$x.99", @"$x.99"],
        @"Housemate Plan" : @[@"$x.99", @"$x.99", @"$x.99"],
        @"Family Plan" : @[@"$x.99", @"$x.99", @"$x.99"]
    } mutableCopy];
    
    localPremiumPlanExpensivePricesDict = [@{
        @"Individual Plan" : @[@"", @"", @"$x.99"],
        @"Housemate Plan" : @[@"", @"", @"$x.99"],
        @"Family Plan" : @[@"", @"", @"$x.99"]
    } mutableCopy];
    
    localPremiumPlanPricesDiscountDict = [@{
        @"Individual Plan" : @[@"$x.99", @"$x.99", @"$x.99"],
        @"Housemate Plan" : @[@"$x.99", @"$x.99", @"$x.99"],
        @"Family Plan" : @[@"$x.99", @"$x.99", @"$x.99"]
    } mutableCopy];
    
    localPremiumPlanPricesNoFreeTrialDict = [@{
        @"Individual Plan" : @[@"$x.99", @"$x.99", @"$x.99"],
        @"Housemate Plan" : @[@"$x.99", @"$x.99", @"$x.99"],
        @"Family Plan" : @[@"$x.99", @"$x.99", @"$x.99"]
    } mutableCopy];
    
    premiumPlanPricesSavingsDict = @{
        @"Individual Plan" : @[@"", @"", @"BEST VALUE!"],
        @"Housemate Plan" : @[@"", @"", @"BEST VALUE!"],
        @"Family Plan" : @[@"", @"", @"BEST VALUE!"]
    };
    
    
    premiumPlanDescriptionDict = @{
        @"Individual Plan" : @"For your account and your account only",
        @"Housemate Plan" : @"For your account plus 2 other accounts",
        @"Family Plan" : @"For your account plus 5 other accounts"
    };
    
    premiumPlanImagesArray = [NSMutableArray array];
    
    [premiumPlanImagesArray addObject:@"PremiumCellIcons.OpenCircle.png"];
    [premiumPlanImagesArray addObject:@"PremiumCellIcons.OpenCircle.png"];
    [premiumPlanImagesArray addObject:@"PremiumCellIcons.ClosedCircle.png"];
    
}

-(void)SetUpPlanContextMenu {
    
    NSMutableArray* actions = [[NSMutableArray alloc] init];
    
    NSDictionary *dictOfPlans = @{@"Individual Plan" : @{@"SelectedImage" : @"person.fill", @"UnselectedImage" : @"person", @"MenuTitle" : @"Premium for your account"},
                                  @"Housemate Plan" : @{@"SelectedImage" : @"person.3.fill", @"UnselectedImage" : @"person.3", @"MenuTitle" : @"Premium for 2-3 accounts"},
                                  @"Family Plan" : @{@"SelectedImage" : @"house.fill", @"UnselectedImage" : @"house", @"MenuTitle" : @"Premium for 4-6 accounts"},};
    
    for (NSString *planType in [dictOfPlans allKeys]) {
        
        NSMutableArray *menuActions = [NSMutableArray array];
        
        NSString *selectedImage = dictOfPlans[planType][@"SelectedImage"];
        NSString *unselectedImage = dictOfPlans[planType][@"UnselectedImage"];
        NSString *menuTitle = dictOfPlans[planType][@"MenuTitle"];
        
        UIImage *imageString =
        [_premiumPlanLabel.text isEqualToString:planType] ?
        [[UIImage systemImageNamed:selectedImage] imageWithTintColor:[UIColor colorWithRed:16.0f/255.0f green:156.0f/255.0f blue:220.0f/255.0f alpha:1.0f] renderingMode:UIImageRenderingModeAlwaysOriginal] :
        [UIImage systemImageNamed:unselectedImage];
        
        [menuActions addObject:[UIAction actionWithTitle:planType image:imageString identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:planType completionHandler:^(BOOL finished) {
                
            }];
            
            [UIView animateWithDuration:0.25 animations:^{
                
                NSString *preimumPlanName = planType;
                
                [self AdjustPlanView:preimumPlanName premiumPlanDetails:self->premiumPlanDescriptionDict[preimumPlanName]];
                [self AdjustPricesOfCurrentPlan];
                [self AdjustSelectedPlanOption];
                
            }];
            
        }]];
        
        UIMenu *planMenu = [UIMenu menuWithTitle:menuTitle image:nil identifier:@"" options:UIMenuOptionsDisplayInline children:menuActions];
        
        [actions addObject:planMenu];
        
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self->_premiumPlanBackViewOverlay.menu = [UIMenu menuWithTitle:@"Select a plan" children:actions];
        self->_premiumPlanBackViewOverlay.showsMenuAsPrimaryAction = false;
        
    });
    
}

-(void)SetUpDefaultPlan {
    
    NSString *defaultPlanLocal = _defaultPlan && [_defaultPlan length] > 0 ? _defaultPlan : @"Individual";
    
    defaultPremiumPlanName = [NSString stringWithFormat:@"%@ Plan", defaultPlanLocal];
    defaultPremiumPlanPrice = @"$4.99 / month";
    
}

-(void)SetUpAttributedString {
    
    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:_requestFeedbackAlertViewQuestionLabel.textColor, NSForegroundColorAttributeName, nil];
    
    NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:@"You can cancel at anytime by going to the \"Settings\" page and clicking \"Billing\", or by contacting us at wedivvy@wedivvyapp.com. To avoid any charges you can cancel your subscription within 30 days and contacting wedivvy@wedivvyapp.com for a refund. More information can be found in our Terms of Service, Privacy Policy, EULA Policy. By beginning your subscription, you acknowledge that you understand and agree to these terms." attributes:attrsDictionary];
    
    NSRange range0 = [[NSString stringWithFormat:@"%@", str] rangeOfString:@"wedivvy@wedivvyapp.com"];
    NSRange range = [[NSString stringWithFormat:@"%@", str] rangeOfString:@"Terms of Service"];
    NSRange range1 = [[NSString stringWithFormat:@"%@", str] rangeOfString:@"Privacy Policy"];
    NSRange range2 = [[NSString stringWithFormat:@"%@", str] rangeOfString:@"EULA Policy"];
    
    NSString *recipients = @"mailto:wedivvy@wedivvyapp.com?subject=Customer Support";
    NSString *body = @"&body=";
    
    NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
    NSString * encodedString = [email stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    
    [str addAttribute: NSLinkAttributeName value: [NSURL URLWithString: encodedString] range: NSMakeRange(range0.location, range0.length)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.0f/255.0f green:122.0f/255.0f blue:255.0f/255.0f alpha:1.0f] range: NSMakeRange(range0.location, range0.length)];
    [str addAttribute: NSLinkAttributeName value: [NSURL URLWithString:@"https://www.wedivvyapp.com/terms-of-service"] range: NSMakeRange(range.location, range.length)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.0f/255.0f green:122.0f/255.0f blue:255.0f/255.0f alpha:1.0f] range: NSMakeRange(range.location, range.length)];
    [str addAttribute: NSLinkAttributeName value: [NSURL URLWithString:@"https://www.wedivvyapp.com/privacy-policy"] range: NSMakeRange(range1.location, range1.length)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.0f/255.0f green:122.0f/255.0f blue:255.0f/255.0f alpha:1.0f] range: NSMakeRange(range1.location, range1.length)];
    [str addAttribute: NSLinkAttributeName value: [NSURL URLWithString:@"https://www.apple.com/legal/internet-services/itunes/dev/stdeula/"] range: NSMakeRange(range2.location, range2.length)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.0f/255.0f green:122.0f/255.0f blue:255.0f/255.0f alpha:1.0f] range: NSMakeRange(range2.location, range2.length)];
    
    _buttonQuestionSubLabel.attributedText = str;
    
    
    attrsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:_TOSLabel.textColor, NSForegroundColorAttributeName, nil];
    
    str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"30-day money-back guarantee.\nBy continuing you are agreeing to our Terms of Service."] attributes:attrsDictionary];
    
    range0 = [[NSString stringWithFormat:@"%@", str] rangeOfString:@"Terms of Service"];
    range1 = [[NSString stringWithFormat:@"%@", str] rangeOfString:@"30-day money-back guarantee"];
    
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor linkColor] range: NSMakeRange(range0.location, range0.length)];
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:1] range:NSMakeRange(range1.location, range1.length)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:_TOSLabel.font.pointSize weight:UIFontWeightSemibold] range:NSMakeRange(range1.location, range1.length)];
    
    _TOSLabel.attributedText = str;
    //_TOSLabel.hidden = YES;
}

-(void)SetUpViews {
 
    _premiumPlanTableView.hidden = NO;
    _simpleOptionLabel.hidden = YES;
    
    if (_viewingSlideShow == YES) {
        
        _mainImage.hidden = YES;
        _mainLabel.hidden = YES;
        _subTitleLabel.hidden = YES;
        _saleImage.hidden = YES;
        _premiumFeaturesTableView.hidden = YES;
        
    } else {
        
        _premiumFeatureSlidesScrollViewNo1.hidden = YES;
        dotOne.hidden = YES;
        dotTwo.hidden = YES;
        dotThree.hidden = YES;
        dotFour.hidden = YES;
        dotFive.hidden = YES;
        
    }
    
}

-(void)SetUpUI {

    if ((introImageOne == nil || introImageOne == NULL) && _viewingSlideShow) {
        
        self.title = @"WeDivvy Premium";
        
        CGFloat width = CGRectGetWidth(self.view.bounds);
        CGFloat height = CGRectGetHeight(self.view.bounds);
        
        CGFloat dotSpacing = 10;
        
        CGFloat navigationBarHeight = [[[GeneralObject alloc] init] GetNavigationBarHeight:self];
        
        dotOne = [[UIView alloc] init];
        dotTwo = [[UIView alloc] init];
        dotThree = [[UIView alloc] init];
        dotFour = [[UIView alloc] init];
        dotFive = [[UIView alloc] init];
        
        scrollingLabelView = [[UILabel alloc] init];
        
        introViewOne = [[UIView alloc] init];
        introViewTwo = [[UIView alloc] init];
        introViewThree = [[UIView alloc] init];
        introViewFour = [[UIView alloc] init];
        introViewFive = [[UIView alloc] init];
        introViewSix = [[UIView alloc] init];
        introViewSeven = [[UIView alloc] init];
        introViewEight = [[UIView alloc] init];
        introViewNine = [[UIView alloc] init];
        introViewTen = [[UIView alloc] init];
        introViewEleven = [[UIView alloc] init];
        introViewTwelve = [[UIView alloc] init];
        introViewThirteen = [[UIView alloc] init];
        introViewFourteen = [[UIView alloc] init];
        introViewFifteen = [[UIView alloc] init];
        introViewSixteen = [[UIView alloc] init];
        introViewSeventeen = [[UIView alloc] init];
        introViewEightteen = [[UIView alloc] init];
        introViewNineteen = [[UIView alloc] init];
        introViewTwenty = [[UIView alloc] init];
        introViewTwentyOne = [[UIView alloc] init];
        
        introImageOne = [[UIImageView alloc] init];
        introImageTwo = [[UIImageView alloc] init];
        introImageThree = [[UIImageView alloc] init];
        introImageFour = [[UIImageView alloc] init];
        introImageFive = [[UIImageView alloc] init];
        introImageSix = [[UIImageView alloc] init];
        introImageSeven = [[UIImageView alloc] init];
        introImageEight = [[UIImageView alloc] init];
        introImageNine = [[UIImageView alloc] init];
        introImageTen = [[UIImageView alloc] init];
        introImageEleven = [[UIImageView alloc] init];
        introImageTwelve = [[UIImageView alloc] init];
        introImageThirteen = [[UIImageView alloc] init];
        introImageFourteen = [[UIImageView alloc] init];
        introImageFifteen = [[UIImageView alloc] init];
        introImageSixteen = [[UIImageView alloc] init];
        introImageSeventeen = [[UIImageView alloc] init];
        introImageEightteen = [[UIImageView alloc] init];
        introImageNineteen = [[UIImageView alloc] init];
        introImageTwenty = [[UIImageView alloc] init];
        introImageTwentyOne = [[UIImageView alloc] init];
        
        introHeadLabelOne = [[UILabel alloc] init];
        introHeadLabelTwo = [[UILabel alloc] init];
        introHeadLabelThree = [[UILabel alloc] init];
        introHeadLabelFour = [[UILabel alloc] init];
        introHeadLabelFive = [[UILabel alloc] init];
        introHeadLabelSix = [[UILabel alloc] init];
        introHeadLabelSeven = [[UILabel alloc] init];
        introHeadLabelEight = [[UILabel alloc] init];
        introHeadLabelNine = [[UILabel alloc] init];
        introHeadLabelTen = [[UILabel alloc] init];
        introHeadLabelEleven = [[UILabel alloc] init];
        introHeadLabelTwelve = [[UILabel alloc] init];
        introHeadLabelThirteen = [[UILabel alloc] init];
        introHeadLabelFourteen = [[UILabel alloc] init];
        introHeadLabelFifteen = [[UILabel alloc] init];
        introHeadLabelSixteen = [[UILabel alloc] init];
        introHeadLabelSeventeen = [[UILabel alloc] init];
        introHeadLabelEightteen = [[UILabel alloc] init];
        introHeadLabelNineteen = [[UILabel alloc] init];
        introHeadLabelTwenty = [[UILabel alloc] init];
        introHeadLabelTwentyOne = [[UILabel alloc] init];
        
        subLabelOne = [[UILabel alloc] init];
        subLabelTwo = [[UILabel alloc] init];
        subLabelThree = [[UILabel alloc] init];
        subLabelFour = [[UILabel alloc] init];
        subLabelFive = [[UILabel alloc] init];
        subLabelSix = [[UILabel alloc] init];
        subLabelSeven = [[UILabel alloc] init];
        subLabelEight = [[UILabel alloc] init];
        subLabelNine = [[UILabel alloc] init];
        subLabelTen = [[UILabel alloc] init];
        subLabelEleven = [[UILabel alloc] init];
        subLabelTwelve = [[UILabel alloc] init];
        subLabelThirteen = [[UILabel alloc] init];
        subLabelFourteen = [[UILabel alloc] init];
        subLabelFifteen = [[UILabel alloc] init];
        subLabelSixteen = [[UILabel alloc] init];
        subLabelSeventeen = [[UILabel alloc] init];
        subLabelEightteen = [[UILabel alloc] init];
        subLabelNineteen = [[UILabel alloc] init];
        subLabelTwenty = [[UILabel alloc] init];
        subLabelTwentyOne = [[UILabel alloc] init];
        
        NSString *premiumFeatureImage0 = premiumFeatureImage && [premiumFeatureImage count] > 0 ? premiumFeatureImage[0] : @"";
        NSString *premiumFeatureName0 = premiumFeatureNameArray && [premiumFeatureNameArray count] > 0 ? premiumFeatureNameArray[0] : @"";
        NSString *premiumFeatureDetails0 = premiumFeatureDetailsArray && [premiumFeatureDetailsArray count] > 0 ? premiumFeatureDetailsArray[0] : @"";
        
        NSString *premiumFeatureImage1 = premiumFeatureImage && [premiumFeatureImage count] > 1 ? premiumFeatureImage[1] : @"";
        NSString *premiumFeatureName1 = premiumFeatureNameArray && [premiumFeatureNameArray count] > 1 ? premiumFeatureNameArray[1] : @"";
        NSString *premiumFeatureDetails1 = premiumFeatureDetailsArray && [premiumFeatureDetailsArray count] > 1 ? premiumFeatureDetailsArray[1] : @"";
        
        NSString *premiumFeatureImage2 = premiumFeatureImage && [premiumFeatureImage count] > 2 ? premiumFeatureImage[2] : @"";
        NSString *premiumFeatureName2 = premiumFeatureNameArray && [premiumFeatureNameArray count] > 2 ? premiumFeatureNameArray[2] : @"";
        NSString *premiumFeatureDetails2 = premiumFeatureDetailsArray && [premiumFeatureDetailsArray count] > 2 ? premiumFeatureDetailsArray[2] : @"";
        
        NSString *premiumFeatureImage3 = premiumFeatureImage && [premiumFeatureImage count] > 3 ? premiumFeatureImage[3] : @"";
        NSString *premiumFeatureName3 = premiumFeatureNameArray && [premiumFeatureNameArray count] > 3 ? premiumFeatureNameArray[3] : @"";
        NSString *premiumFeatureDetails3 = premiumFeatureDetailsArray && [premiumFeatureDetailsArray count] > 3 ? premiumFeatureDetailsArray[3] : @"";
        
        NSString *premiumFeatureImage4 = premiumFeatureImage && [premiumFeatureImage count] > 4 ? premiumFeatureImage[4] : @"";
        NSString *premiumFeatureName4 = premiumFeatureNameArray && [premiumFeatureNameArray count] > 4 ? premiumFeatureNameArray[4] : @"";
        NSString *premiumFeatureDetails4 = premiumFeatureDetailsArray && [premiumFeatureDetailsArray count] > 4 ? premiumFeatureDetailsArray[4] : @"";
        
        NSString *premiumFeatureImage5 = premiumFeatureImage && [premiumFeatureImage count] > 5 ? premiumFeatureImage[5] : @"";
        NSString *premiumFeatureName5 = premiumFeatureNameArray && [premiumFeatureNameArray count] > 5 ? premiumFeatureNameArray[5] : @"";
        NSString *premiumFeatureDetails5 = premiumFeatureDetailsArray && [premiumFeatureDetailsArray count] > 5 ? premiumFeatureDetailsArray[5] : @"";
        
        NSString *premiumFeatureImage6 = premiumFeatureImage && [premiumFeatureImage count] > 6 ? premiumFeatureImage[6] : @"";
        NSString *premiumFeatureName6 = premiumFeatureNameArray && [premiumFeatureNameArray count] > 6 ? premiumFeatureNameArray[6] : @"";
        NSString *premiumFeatureDetails6 = premiumFeatureDetailsArray && [premiumFeatureDetailsArray count] > 6 ? premiumFeatureDetailsArray[6] : @"";
        
        NSString *premiumFeatureImage7 = premiumFeatureImage && [premiumFeatureImage count] > 7 ? premiumFeatureImage[7] : @"";
        NSString *premiumFeatureName7 = premiumFeatureNameArray && [premiumFeatureNameArray count] > 7 ? premiumFeatureNameArray[7] : @"";
        NSString *premiumFeatureDetails7 = premiumFeatureDetailsArray && [premiumFeatureDetailsArray count] > 7 ? premiumFeatureDetailsArray[7] : @"";
        
        NSString *premiumFeatureImage8 = premiumFeatureImage && [premiumFeatureImage count] > 8 ? premiumFeatureImage[8] : @"";
        NSString *premiumFeatureName8 = premiumFeatureNameArray && [premiumFeatureNameArray count] > 8 ? premiumFeatureNameArray[8] : @"";
        NSString *premiumFeatureDetails8 = premiumFeatureDetailsArray && [premiumFeatureDetailsArray count] > 8 ? premiumFeatureDetailsArray[8] : @"";
        
        NSString *premiumFeatureImage9 = premiumFeatureImage && [premiumFeatureImage count] > 9 ? premiumFeatureImage[9] : @"";
        NSString *premiumFeatureName9 = premiumFeatureNameArray && [premiumFeatureNameArray count] > 9 ? premiumFeatureNameArray[9] : @"";
        NSString *premiumFeatureDetails9 = premiumFeatureDetailsArray && [premiumFeatureDetailsArray count] > 9 ? premiumFeatureDetailsArray[9] : @"";
        
        NSString *premiumFeatureImage10 = premiumFeatureImage && [premiumFeatureImage count] > 10 ? premiumFeatureImage[10] : @"";
        NSString *premiumFeatureName10 = premiumFeatureNameArray && [premiumFeatureNameArray count] > 10 ? premiumFeatureNameArray[10] : @"";
        NSString *premiumFeatureDetails10 = premiumFeatureDetailsArray && [premiumFeatureDetailsArray count] > 10 ? premiumFeatureDetailsArray[10] : @"";
        
        NSString *premiumFeatureImage11 = premiumFeatureImage && [premiumFeatureImage count] > 11 ? premiumFeatureImage[11] : @"";
        NSString *premiumFeatureName11 = premiumFeatureNameArray && [premiumFeatureNameArray count] > 11 ? premiumFeatureNameArray[11] : @"";
        NSString *premiumFeatureDetails11 = premiumFeatureDetailsArray && [premiumFeatureDetailsArray count] > 11 ? premiumFeatureDetailsArray[11] : @"";
        
        NSString *premiumFeatureImage12 = premiumFeatureImage && [premiumFeatureImage count] > 12 ? premiumFeatureImage[12] : @"";
        NSString *premiumFeatureName12 = premiumFeatureNameArray && [premiumFeatureNameArray count] > 12 ? premiumFeatureNameArray[12] : @"";
        NSString *premiumFeatureDetails12 = premiumFeatureDetailsArray && [premiumFeatureDetailsArray count] > 12 ? premiumFeatureDetailsArray[12] : @"";
        
        NSString *premiumFeatureImage13 = premiumFeatureImage && [premiumFeatureImage count] > 13 ? premiumFeatureImage[13] : @"";
        NSString *premiumFeatureName13 = premiumFeatureNameArray && [premiumFeatureNameArray count] > 13 ? premiumFeatureNameArray[13] : @"";
        NSString *premiumFeatureDetails13 = premiumFeatureDetailsArray && [premiumFeatureDetailsArray count] > 13 ? premiumFeatureDetailsArray[13] : @"";
        
        NSString *premiumFeatureImage14 = premiumFeatureImage && [premiumFeatureImage count] > 14 ? premiumFeatureImage[14] : @"";
        NSString *premiumFeatureName14 = premiumFeatureNameArray && [premiumFeatureNameArray count] > 14 ? premiumFeatureNameArray[14] : @"";
        NSString *premiumFeatureDetails14 = premiumFeatureDetailsArray && [premiumFeatureDetailsArray count] > 14 ? premiumFeatureDetailsArray[14] : @"";
        
        NSString *premiumFeatureImage15 = premiumFeatureImage && [premiumFeatureImage count] > 15 ? premiumFeatureImage[15] : @"";
        NSString *premiumFeatureName15 = premiumFeatureNameArray && [premiumFeatureNameArray count] > 15 ? premiumFeatureNameArray[15] : @"";
        NSString *premiumFeatureDetails15 = premiumFeatureDetailsArray && [premiumFeatureDetailsArray count] > 15 ? premiumFeatureDetailsArray[15] : @"";
        
        NSString *premiumFeatureImage16 = premiumFeatureImage && [premiumFeatureImage count] > 16 ? premiumFeatureImage[16] : @"";
        NSString *premiumFeatureName16 = premiumFeatureNameArray && [premiumFeatureNameArray count] > 16 ? premiumFeatureNameArray[16] : @"";
        NSString *premiumFeatureDetails16 = premiumFeatureDetailsArray && [premiumFeatureDetailsArray count] > 16 ? premiumFeatureDetailsArray[16] : @"";
        
        NSString *premiumFeatureImage17 = premiumFeatureImage && [premiumFeatureImage count] > 17 ? premiumFeatureImage[17] : @"";
        NSString *premiumFeatureName17 = premiumFeatureNameArray && [premiumFeatureNameArray count] > 17 ? premiumFeatureNameArray[17] : @"";
        NSString *premiumFeatureDetails17 = premiumFeatureDetailsArray && [premiumFeatureDetailsArray count] > 17 ? premiumFeatureDetailsArray[17] : @"";
        
        NSString *premiumFeatureImage18 = premiumFeatureImage && [premiumFeatureImage count] > 18 ? premiumFeatureImage[18] : @"";
        NSString *premiumFeatureName18 = premiumFeatureNameArray && [premiumFeatureNameArray count] > 18 ? premiumFeatureNameArray[18] : @"";
        NSString *premiumFeatureDetails18 = premiumFeatureDetailsArray && [premiumFeatureDetailsArray count] > 18 ? premiumFeatureDetailsArray[18] : @"";
        
        NSString *premiumFeatureImage19 = premiumFeatureImage && [premiumFeatureImage count] > 19 ? premiumFeatureImage[19] : @"";
        NSString *premiumFeatureName19 = premiumFeatureNameArray && [premiumFeatureNameArray count] > 19 ? premiumFeatureNameArray[19] : @"";
        NSString *premiumFeatureDetails19 = premiumFeatureDetailsArray && [premiumFeatureDetailsArray count] > 19 ? premiumFeatureDetailsArray[19] : @"";
        
        [self SetUpView:@[
            @{@"ImageView" : introImageOne, @"Head" : introHeadLabelOne, @"Bottom" : subLabelOne, @"ImageViewText" : premiumFeatureImage0, @"HeadText" : premiumFeatureName0, @"BottomText" : premiumFeatureDetails0},
            @{@"ImageView" : introImageTwo, @"Head" : introHeadLabelTwo, @"Bottom" : subLabelTwo, @"ImageViewText" : premiumFeatureImage1, @"HeadText" : premiumFeatureName1, @"BottomText" : premiumFeatureDetails1},
            @{@"ImageView" : introImageThree, @"Head" : introHeadLabelThree, @"Bottom" : subLabelThree, @"ImageViewText" : premiumFeatureImage2, @"HeadText" : premiumFeatureName2, @"BottomText" : premiumFeatureDetails2},
            @{@"ImageView" : introImageFour, @"Head" : introHeadLabelFour, @"Bottom" : subLabelFour, @"ImageViewText" : premiumFeatureImage3, @"HeadText" : premiumFeatureName3, @"BottomText" : premiumFeatureDetails3},
            @{@"ImageView" : introImageFive, @"Head" : introHeadLabelFive, @"Bottom" : subLabelFive, @"ImageViewText" : premiumFeatureImage4, @"HeadText" : premiumFeatureName4, @"BottomText" : premiumFeatureDetails4},
            @{@"ImageView" : introImageSix, @"Head" : introHeadLabelSix, @"Bottom" : subLabelSix, @"ImageViewText" : premiumFeatureImage5, @"HeadText" : premiumFeatureName5, @"BottomText" : premiumFeatureDetails5},
            @{@"ImageView" : introImageSeven, @"Head" : introHeadLabelSeven, @"Bottom" : subLabelSeven, @"ImageViewText" : premiumFeatureImage6, @"HeadText" : premiumFeatureName6, @"BottomText" : premiumFeatureDetails6},
            @{@"ImageView" : introImageEight, @"Head" : introHeadLabelEight, @"Bottom" : subLabelEight, @"ImageViewText" : premiumFeatureImage7, @"HeadText" : premiumFeatureName7, @"BottomText" : premiumFeatureDetails7},
            @{@"ImageView" : introImageNine, @"Head" : introHeadLabelNine, @"Bottom" : subLabelNine, @"ImageViewText" : premiumFeatureImage8, @"HeadText" : premiumFeatureName8, @"BottomText" : premiumFeatureDetails8},
            @{@"ImageView" : introImageTen, @"Head" : introHeadLabelTen, @"Bottom" : subLabelTen, @"ImageViewText" : premiumFeatureImage9, @"HeadText" : premiumFeatureName9, @"BottomText" : premiumFeatureDetails9},
            @{@"ImageView" : introImageEleven, @"Head" : introHeadLabelEleven, @"Bottom" : subLabelEleven, @"ImageViewText" : premiumFeatureImage10, @"HeadText" : premiumFeatureName10, @"BottomText" : premiumFeatureDetails10},
            @{@"ImageView" : introImageTwelve, @"Head" : introHeadLabelTwelve, @"Bottom" : subLabelTwelve, @"ImageViewText" : premiumFeatureImage11, @"HeadText" : premiumFeatureName11, @"BottomText" : premiumFeatureDetails11},
            @{@"ImageView" : introImageThirteen, @"Head" : introHeadLabelThirteen, @"Bottom" : subLabelThirteen, @"ImageViewText" : premiumFeatureImage12, @"HeadText" : premiumFeatureName12, @"BottomText" : premiumFeatureDetails12},
            @{@"ImageView" : introImageFourteen, @"Head" : introHeadLabelFourteen, @"Bottom" : subLabelFourteen, @"ImageViewText" : premiumFeatureImage13, @"HeadText" : premiumFeatureName13, @"BottomText" : premiumFeatureDetails13},
            @{@"ImageView" : introImageFifteen, @"Head" : introHeadLabelFifteen, @"Bottom" : subLabelFifteen, @"ImageViewText" : premiumFeatureImage14, @"HeadText" : premiumFeatureName14, @"BottomText" : premiumFeatureDetails14},
            @{@"ImageView" : introImageSixteen, @"Head" : introHeadLabelSixteen, @"Bottom" : subLabelSixteen, @"ImageViewText" : premiumFeatureImage15, @"HeadText" : premiumFeatureName15, @"BottomText" : premiumFeatureDetails15},
            @{@"ImageView" : introImageSeventeen, @"Head" : introHeadLabelSeventeen, @"Bottom" : subLabelSeventeen, @"ImageViewText" : premiumFeatureImage16, @"HeadText" : premiumFeatureName16, @"BottomText" : premiumFeatureDetails16},
            @{@"ImageView" : introImageEightteen, @"Head" : introHeadLabelEightteen, @"Bottom" : subLabelEightteen, @"ImageViewText" : premiumFeatureImage17, @"HeadText" : premiumFeatureName17, @"BottomText" : premiumFeatureDetails17},
            @{@"ImageView" : introImageNineteen, @"Head" : introHeadLabelNineteen, @"Bottom" : subLabelNineteen, @"ImageViewText" : premiumFeatureImage18, @"HeadText" : premiumFeatureName18, @"BottomText" : premiumFeatureDetails18},
            @{@"ImageView" : introImageTwenty, @"Head" : introHeadLabelTwenty, @"Bottom" : subLabelTwenty, @"ImageViewText" : premiumFeatureImage19, @"HeadText" : premiumFeatureName19, @"BottomText" : premiumFeatureDetails19},
        ]];
        
        scrollingLabelView.frame = CGRectMake(self.view.frame.size.width - self.view.frame.size.width*0.12077295 - self.view.frame.size.width*0.04830918, 0, self.view.frame.size.width*0.12077295, self.navigationController.navigationBar.frame.size.height);
        scrollingLabelView.text = @"1/20";
        scrollingLabelView.textColor = [UIColor lightGrayColor];
        scrollingLabelView.font = [UIFont systemFontOfSize:(self.view.frame.size.height*0.02398801) > 16?(16):(self.view.frame.size.height*0.02398801) weight:UIFontWeightRegular];
        scrollingLabelView.textAlignment = NSTextAlignmentCenter;
        scrollingLabelView.hidden = NO;
        
        dotThree.frame = CGRectMake(width*0.5 - ((7.5)*0.5), navigationBarHeight + 20, 7.5, 7.5);
        dotTwo.frame = CGRectMake(dotThree.frame.origin.x - dotThree.frame.size.width - dotSpacing, dotThree.frame.origin.y, dotThree.frame.size.width, dotThree.frame.size.height);
        dotFour.frame = CGRectMake(dotThree.frame.origin.x + dotThree.frame.size.width + dotSpacing, dotThree.frame.origin.y, dotThree.frame.size.width, dotThree.frame.size.height);
        dotOne.frame = CGRectMake(dotTwo.frame.origin.x - dotThree.frame.size.width - dotSpacing, dotThree.frame.origin.y, dotThree.frame.size.width, dotThree.frame.size.width);
        dotFive.frame = CGRectMake(dotFour.frame.origin.x + dotThree.frame.size.width + dotSpacing, dotThree.frame.origin.y, dotThree.frame.size.width, dotThree.frame.size.height);
        
        _premiumFeatureSlidesScrollViewNo1.delegate = self;
       
        _premiumFeatureSlidesScrollViewNo1.frame = CGRectMake(0, 0, width, self.view.frame.size.height - navigationBarHeight - (self.view.frame.size.height - _purchaseSubscriptionView.frame.origin.y));
        [_premiumFeatureSlidesScrollViewNo1 setContentSize:CGSizeMake(width*45, 0)];
        
        width = CGRectGetWidth(_premiumFeatureSlidesScrollViewNo1.bounds);
        height = CGRectGetHeight(_premiumFeatureSlidesScrollViewNo1.bounds);
        
        introViewOne.frame = CGRectMake(0, 0, width, height);
        introViewTwo.frame = CGRectMake(width*1, introViewOne.frame.origin.y, width, introViewOne.frame.size.height);
        introViewThree.frame = CGRectMake(width*2, introViewOne.frame.origin.y, width, introViewOne.frame.size.height);
        introViewFour.frame = CGRectMake(width*3, introViewOne.frame.origin.y, width, introViewOne.frame.size.height);
        introViewFive.frame = CGRectMake(width*4, introViewOne.frame.origin.y, width, introViewOne.frame.size.height);
        introViewSix.frame = CGRectMake(width*5, introViewOne.frame.origin.y, width, introViewOne.frame.size.height);
        introViewSeven.frame = CGRectMake(width*6, introViewOne.frame.origin.y, width, introViewOne.frame.size.height);
        introViewEight.frame = CGRectMake(width*7, introViewOne.frame.origin.y, width, introViewOne.frame.size.height);
        introViewNine.frame = CGRectMake(width*8, introViewOne.frame.origin.y, width, introViewOne.frame.size.height);
        introViewTen.frame = CGRectMake(width*9, introViewOne.frame.origin.y, width, introViewOne.frame.size.height);
        introViewEleven.frame = CGRectMake(width*10, introViewOne.frame.origin.y, width, introViewOne.frame.size.height);
        introViewTwelve.frame = CGRectMake(width*11, introViewOne.frame.origin.y, width, introViewOne.frame.size.height);
        introViewThirteen.frame = CGRectMake(width*12, introViewOne.frame.origin.y, width, introViewOne.frame.size.height);
        introViewFourteen.frame = CGRectMake(width*13, introViewOne.frame.origin.y, width, introViewOne.frame.size.height);
        introViewFifteen.frame = CGRectMake(width*14, introViewOne.frame.origin.y, width, introViewOne.frame.size.height);
        introViewSixteen.frame = CGRectMake(width*14, introViewOne.frame.origin.y, width, introViewOne.frame.size.height);
        introViewSeventeen.frame = CGRectMake(width*14, introViewOne.frame.origin.y, width, introViewOne.frame.size.height);
        introViewEightteen.frame = CGRectMake(width*14, introViewOne.frame.origin.y, width, introViewOne.frame.size.height);
        introViewNineteen.frame = CGRectMake(width*14, introViewOne.frame.origin.y, width, introViewOne.frame.size.height);
        introViewTwenty.frame = CGRectMake(width*14, introViewOne.frame.origin.y, width, introViewOne.frame.size.height);
        introViewTwentyOne.frame = CGRectMake(width*14, introViewOne.frame.origin.y, width, introViewOne.frame.size.height);
        
        introImageOne.frame = CGRectMake(width*0.5 - ((width*0.8)*0.5), 0, width*0.8, _premiumFeatureSlidesScrollViewNo1.frame.size.height*0.75);
        introHeadLabelOne.frame = CGRectMake(width*0.5 - ((width*0.71497)*0.5), introImageOne.frame.origin.y + introImageOne.frame.size.height + (self.view.frame.size.height*0.01390498 > 12?(12):self.view.frame.size.height*0.01390498), width*0.71497, (self.view.frame.size.height*0.02717391) > 20?(20):(self.view.frame.size.height*0.02717391));
        subLabelOne.frame = CGRectMake(introHeadLabelOne.frame.origin.x, introHeadLabelOne.frame.origin.y + introHeadLabelOne.frame.size.height + (self.view.frame.size.height*0.01390498 > 12?(12):self.view.frame.size.height*0.01390498), introHeadLabelOne.frame.size.width, ((self.view.frame.size.height*0.02717391) > 20?(20):(self.view.frame.size.height*0.02717391))*2);
        
        CGRect newRect = introViewOne.frame;
        newRect.size.height = introImageOne.frame.size.height + (self.view.frame.size.height*0.01390498 > 12?(12):self.view.frame.size.height*0.01390498) + introHeadLabelOne.frame.size.height + (self.view.frame.size.height*0.01390498 > 12?(12):self.view.frame.size.height*0.01390498) + subLabelOne.frame.size.height;
        newRect.origin.y = _premiumFeatureSlidesScrollViewNo1.frame.size.height*0.5 - newRect.size.height*0.5;
        introViewOne.frame = newRect;
        
        introImageTwo.frame = introImageOne.frame;
        introImageThree.frame = introImageOne.frame;
        introImageFour.frame = introImageOne.frame;
        introImageFive.frame = introImageOne.frame;
        introImageSix.frame = introImageOne.frame;
        introImageSeven.frame = introImageOne.frame;
        introImageEight.frame = introImageOne.frame;
        introImageNine.frame = introImageOne.frame;
        introImageTen.frame = introImageOne.frame;
        introImageEleven.frame = introImageOne.frame;
        introImageTwelve.frame = introImageOne.frame;
        introImageThirteen.frame = introImageOne.frame;
        introImageFourteen.frame = introImageOne.frame;
        introImageFifteen.frame = introImageOne.frame;
        introImageSixteen.frame = introImageOne.frame;
        introImageSeventeen.frame = introImageOne.frame;
        introImageEightteen.frame = introImageOne.frame;
        introImageNineteen.frame = introImageOne.frame;
        introImageTwenty.frame = introImageOne.frame;
        introImageTwentyOne.frame = introImageOne.frame;
        
        introHeadLabelTwo.frame = introHeadLabelOne.frame;
        introHeadLabelThree.frame = introHeadLabelOne.frame;
        introHeadLabelFour.frame = introHeadLabelOne.frame;
        introHeadLabelFive.frame = introHeadLabelOne.frame;
        introHeadLabelSix.frame = introHeadLabelOne.frame;
        introHeadLabelSeven.frame = introHeadLabelOne.frame;
        introHeadLabelEight.frame = introHeadLabelOne.frame;
        introHeadLabelNine.frame = introHeadLabelOne.frame;
        introHeadLabelTen.frame = introHeadLabelOne.frame;
        introHeadLabelEleven.frame = introHeadLabelOne.frame;
        introHeadLabelTwelve.frame = introHeadLabelOne.frame;
        introHeadLabelThirteen.frame = introHeadLabelOne.frame;
        introHeadLabelFourteen.frame = introHeadLabelOne.frame;
        introHeadLabelFifteen.frame = introHeadLabelOne.frame;
        introHeadLabelSixteen.frame = introHeadLabelOne.frame;
        introHeadLabelSeventeen.frame = introHeadLabelOne.frame;
        introHeadLabelEightteen.frame = introHeadLabelOne.frame;
        introHeadLabelNineteen.frame = introHeadLabelOne.frame;
        introHeadLabelTwenty.frame = introHeadLabelOne.frame;
        introHeadLabelTwentyOne.frame = introHeadLabelOne.frame;
        
        subLabelTwo.frame = subLabelOne.frame;
        subLabelThree.frame = subLabelOne.frame;
        subLabelFour.frame = subLabelOne.frame;
        subLabelFive.frame = subLabelOne.frame;
        subLabelSix.frame = subLabelOne.frame;
        subLabelSeven.frame = subLabelOne.frame;
        subLabelEight.frame = subLabelOne.frame;
        subLabelNine.frame = subLabelOne.frame;
        subLabelTen.frame = subLabelOne.frame;
        subLabelEleven.frame = subLabelOne.frame;
        subLabelTwelve.frame = subLabelOne.frame;
        subLabelThirteen.frame = subLabelOne.frame;
        subLabelFourteen.frame = subLabelOne.frame;
        subLabelFifteen.frame = subLabelOne.frame;
        subLabelSixteen.frame = subLabelOne.frame;
        subLabelSeventeen.frame = subLabelOne.frame;
        subLabelEightteen.frame = subLabelOne.frame;
        subLabelNineteen.frame = subLabelOne.frame;
        subLabelTwenty.frame = subLabelOne.frame;
        subLabelTwentyOne.frame = subLabelOne.frame;
        
        dotOne.layer.cornerRadius = dotOne.frame.size.height/2;
        dotTwo.layer.cornerRadius = dotTwo.frame.size.height/2;
        dotThree.layer.cornerRadius = dotThree.frame.size.height/2;
        dotFour.layer.cornerRadius = dotFour.frame.size.height/2;
        dotFive.layer.cornerRadius = dotFive.frame.size.height/2;
        
        UIWindow *currentwindow = [UIApplication sharedApplication].windows.firstObject;
        
        [currentwindow addSubview:scrollingLabelView];
        
        [self.navigationController.navigationBar addSubview:scrollingLabelView];
        
        [self.view addSubview:dotOne];
        [self.view addSubview:dotTwo];
        [self.view addSubview:dotThree];
        [self.view addSubview:dotFour];
        [self.view addSubview:dotFive];
        
        [_premiumFeatureSlidesScrollViewNo1 addSubview:introViewOne];
        [_premiumFeatureSlidesScrollViewNo1 addSubview:introViewTwo];
        [_premiumFeatureSlidesScrollViewNo1 addSubview:introViewThree];
        [_premiumFeatureSlidesScrollViewNo1 addSubview:introViewFour];
        [_premiumFeatureSlidesScrollViewNo1 addSubview:introViewFive];
        [_premiumFeatureSlidesScrollViewNo1 addSubview:introViewSix];
        [_premiumFeatureSlidesScrollViewNo1 addSubview:introViewSeven];
        [_premiumFeatureSlidesScrollViewNo1 addSubview:introViewEight];
        [_premiumFeatureSlidesScrollViewNo1 addSubview:introViewNine];
        [_premiumFeatureSlidesScrollViewNo1 addSubview:introViewTen];
        [_premiumFeatureSlidesScrollViewNo1 addSubview:introViewEleven];
        [_premiumFeatureSlidesScrollViewNo1 addSubview:introViewTwelve];
        [_premiumFeatureSlidesScrollViewNo1 addSubview:introViewThirteen];
        [_premiumFeatureSlidesScrollViewNo1 addSubview:introViewFourteen];
        [_premiumFeatureSlidesScrollViewNo1 addSubview:introViewFifteen];
        [_premiumFeatureSlidesScrollViewNo1 addSubview:introViewSixteen];
        [_premiumFeatureSlidesScrollViewNo1 addSubview:introViewSeventeen];
        [_premiumFeatureSlidesScrollViewNo1 addSubview:introViewEightteen];
        [_premiumFeatureSlidesScrollViewNo1 addSubview:introViewNineteen];
        [_premiumFeatureSlidesScrollViewNo1 addSubview:introViewTwenty];
        [_premiumFeatureSlidesScrollViewNo1 addSubview:introViewTwentyOne];
        
        [introViewOne addSubview:introImageOne];
        [introViewTwo addSubview:introImageTwo];
        [introViewThree addSubview:introImageThree];
        [introViewFour addSubview:introImageFour];
        [introViewFive addSubview:introImageFive];
        [introViewSix addSubview:introImageSix];
        [introViewSeven addSubview:introImageSeven];
        [introViewEight addSubview:introImageEight];
        [introViewNine addSubview:introImageNine];
        [introViewTen addSubview:introImageTen];
        [introViewEleven addSubview:introImageEleven];
        [introViewTwelve addSubview:introImageTwelve];
        [introViewThirteen addSubview:introImageThirteen];
        [introViewFourteen addSubview:introImageFourteen];
        [introViewFifteen addSubview:introImageFifteen];
        [introViewSixteen addSubview:introImageSixteen];
        [introViewSeventeen addSubview:introImageSeventeen];
        [introViewEightteen addSubview:introImageEightteen];
        [introViewNineteen addSubview:introImageNineteen];
        [introViewTwenty addSubview:introImageTwenty];
        [introViewTwentyOne addSubview:introImageTwentyOne];
        
        [introViewOne addSubview:introHeadLabelOne];
        [introViewTwo addSubview:introHeadLabelTwo];
        [introViewThree addSubview:introHeadLabelThree];
        [introViewFour addSubview:introHeadLabelFour];
        [introViewFive addSubview:introHeadLabelFive];
        [introViewSix addSubview:introHeadLabelSix];
        [introViewSeven addSubview:introHeadLabelSeven];
        [introViewEight addSubview:introHeadLabelEight];
        [introViewNine addSubview:introHeadLabelNine];
        [introViewTen addSubview:introHeadLabelTen];
        [introViewEleven addSubview:introHeadLabelEleven];
        [introViewTwelve addSubview:introHeadLabelTwelve];
        [introViewThirteen addSubview:introHeadLabelThirteen];
        [introViewFourteen addSubview:introHeadLabelFourteen];
        [introViewFifteen addSubview:introHeadLabelFifteen];
        [introViewSixteen addSubview:introHeadLabelSixteen];
        [introViewSeventeen addSubview:introHeadLabelSeventeen];
        [introViewEightteen addSubview:introHeadLabelEightteen];
        [introViewNineteen addSubview:introHeadLabelNineteen];
        [introViewTwenty addSubview:introHeadLabelTwenty];
        [introViewTwentyOne addSubview:introHeadLabelTwentyOne];
        
        [introViewOne addSubview:subLabelOne];
        [introViewTwo addSubview:subLabelTwo];
        [introViewThree addSubview:subLabelThree];
        [introViewFour addSubview:subLabelFour];
        [introViewFive addSubview:subLabelFive];
        [introViewSix addSubview:subLabelSix];
        [introViewSeven addSubview:subLabelSeven];
        [introViewEight addSubview:subLabelEight];
        [introViewNine addSubview:subLabelNine];
        [introViewTen addSubview:subLabelTen];
        [introViewEleven addSubview:subLabelEleven];
        [introViewTwelve addSubview:subLabelTwelve];
        [introViewThirteen addSubview:subLabelThirteen];
        [introViewFourteen addSubview:subLabelFourteen];
        [introViewFifteen addSubview:subLabelFifteen];
        [introViewSixteen addSubview:subLabelSixteen];
        [introViewSeventeen addSubview:subLabelSeventeen];
        [introViewEightteen addSubview:subLabelEightteen];
        [introViewNineteen addSubview:subLabelNineteen];
        [introViewTwenty addSubview:subLabelTwenty];
        [introViewTwentyOne addSubview:subLabelTwentyOne];
        
        NSUInteger index = [premiumFeatureNameArray indexOfObject:_selectedSlide];
        int totalNumberOfFeatures = 18;
        
        scrollingLabelView.text = [NSString stringWithFormat:@"%lu/%d", index+1, totalNumberOfFeatures];
        
        CGFloat scrollTo = (self.view.frame.size.width*index);
        
        if (scrollTo < 0) {
            scrollTo = 0;
        }
        
        [UIView animateWithDuration:0.5 animations:^{
            self->_premiumFeatureSlidesScrollViewNo1.contentOffset = CGPointMake(scrollTo, 0);
        } completion:nil];
        
    } else {
        
        self.title = @"";
        
    }
    
}

#pragma mark - IBAction Methods

-(IBAction)PuchaseSubscription:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Purchase"] completionHandler:^(BOOL finished) {
        
    }];
  
    SKProduct *productToUse = [self GenerateProductToUse];
  
    if (productToUse != nil) {
       
        [self purchaseMyProduct:productToUse];
        
    } else {
        
        [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"An unknown error has occured, please try again." currentViewController:self];
    }
    
}

- (IBAction)DisplayTOS:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Display TOS"] completionHandler:^(BOOL finished) {
        
    }];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        CGFloat width = CGRectGetWidth(self.view.bounds);
        CGFloat height = CGRectGetHeight(self.view.bounds);
        
        self->_requestFeedbackBackDropView.frame = CGRectMake(0, 0, width, height);
        self->_requestFeedbackBackDropView.alpha = 1.0;
        
        self->_requestFeedbackAlertView.frame = CGRectMake(0, height - ((height*0.53668478) > 395?(395):(height*0.53668478)), width, ((height*0.53668478) > 395?(395):(height*0.53668478)));
        
    } completion:^(BOOL finished) {
        
    }];
    
}

-(IBAction)MoreOptions:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"%@ Clicked", self->moreOptionsClicked ? @"Simple Option" : @"More Options"] completionHandler:^(BOOL finished) {
        
    }];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self->moreOptionsClicked = self->moreOptionsClicked ? NO : YES;
        self->_moreOptionsLabel.text = self->moreOptionsClicked ? @"More Options" : @"Simple Option";
        self->_premiumPlanTableView.hidden = self->moreOptionsClicked ? NO : YES;
        self->_simpleOptionLabel.hidden = self->moreOptionsClicked ? NO : YES;
        
        [self AdjustPurchaseView:self->_premiumPlanLabel.text premiumPlanDetails:self->premiumPlanDescriptionDict[self->_premiumPlanLabel.text]];
        
    } completion:^(BOOL finished) {
        
        self->_simpleOptionLabel.hidden = self->moreOptionsClicked ? YES : NO;
        self->_premiumPlanTableView.hidden = self->moreOptionsClicked ? NO : YES;
        
        [self AdjustPricesOfCurrentPlan];
        
    }];
    
}


- (IBAction)RestorePurchases:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Restore Purchase"] completionHandler:^(BOOL finished) {
        
    }];
    
    [self StartProgressView];
    
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
    
    [[[GeneralObject alloc] init] CheckPremiumSubscriptionStatus:homeMembersDict completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningHomeMembersDict) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self->progressView setHidden:YES];
            [[[GeneralObject alloc] init] CreateAlert:@"Purchases Restored" message:@"If you had any lost purchases they were restored." currentViewController:self];
            
        });
        
    }];
    
}

-(IBAction)NavigationBackButtonAction:(UIBarButtonItem *)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Navigation Back Button Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
    
    [self DismissViewController:self];
    
}

-(IBAction)DismissViewController:(id)sender {
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"ComingFromShortcut"] isEqualToString:@"Yes"]) {
        [self.navigationController popViewControllerAnimated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

-(IBAction)FAQButton:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"FAQ Button Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    [[[PushObject alloc] init] PushToFAQViewController:self];
    
}

-(IBAction)FreeTrialFAQButton:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Free Trial FAQ Button Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    [[[GeneralObject alloc] init] CreateAlert:@"Free Trial" message:@"You get 7 free days of WeDivvy Premium, Woohoo! 🎉\n\nCancel anytime before the end the last day to avoid being charged.\n\nIf you forget feel free to email us at wedivvy@wedivvyapp.com to get a refund." currentViewController:self];
    
}

-(IBAction)CloseTOSPopupAction:(id)sender {
    
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    [UIView animateWithDuration:0.25 animations:^{
        
        CGRect newRect = self->_requestFeedbackAlertView.frame;
        newRect.origin.y = height;
        self->_requestFeedbackAlertView.frame = newRect;
        
    } completion:^(BOOL finished) {
        
        [self DisplayAlertView:NO backDropView:self->_requestFeedbackBackDropView alertViewNoButton:nil alertViewYesButton:nil];
        
    }];
    
}

-(IBAction)PushToPremiumAccountsAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Assigned To Field Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    NSMutableArray *selectedArray = [NSMutableArray array];
    
    NSMutableDictionary *homeMembersUnclaimedDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeMembersUnclaimedDict"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeMembersUnclaimedDict"] : [NSMutableDictionary dictionary];
    NSMutableDictionary *homeKeysDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeKeysDict"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeKeysDict"] : [NSMutableDictionary dictionary];
    NSMutableArray *homeKeysArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeKeysArray"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeKeysArray"] : [NSMutableArray array];
    
    [[[PushObject alloc] init] PushToViewAssignedViewController:selectedArray itemAssignedToNewHomeMembers:@"No" itemAssignedToAnybody:@"No" itemUniqueID:@"" homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict homeMembersUnclaimedDict:homeMembersUnclaimedDict homeKeysDict:homeKeysDict homeKeysArray:homeKeysArray notificationSettingsDict:notificationSettingsDict topicDict:topicDict viewingItemDetails:NO viewingExpense:NO viewingChatMembers:NO viewingWeDivvyPremiumAddingAccounts:YES viewingWeDivvyPremiumEditingAccounts:NO currentViewController:self];
    
}

-(IBAction)EnterPromoCodeAction:(id)sender {
    
    [_enterPromoCodeTextField becomeFirstResponder];
    
}

-(IBAction)DisplayRulesAndRestrictionsAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Restrictions Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    [[[GeneralObject alloc] init] CreateAlert:@"Rules & Restrictions" message:[NSString stringWithFormat:@"You cannot join the home of promo code sender."] currentViewController:self];
    
}

-(IBAction)ResignPromoCodeTextField:(id)sender {
    
    [_enterPromoCodeTextField resignFirstResponder];
    
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
        headLabel.textColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTextPrimary] : [UIColor blackColor];
        
        bottomLabel.text = bottomText;
        bottomLabel.textColor = [UIColor colorWithRed:162.0f/255.0f green:167.0f/255.0f blue:183.0f/255.0f alpha:1.0f];
        bottomLabel.textAlignment = NSTextAlignmentCenter;
        bottomLabel.numberOfLines = 0;
        
    }
    
}

-(void)DisplayAlertView:(BOOL)display backDropView:(UIView *)backDropView alertViewNoButton:(UIButton * _Nullable)alertViewNoButton alertViewYesButton:(UIButton *)alertViewYesButton {
    
    if (display) {
        
        [UIView animateWithDuration:0.25 animations:^{
            
            backDropView.alpha = 1.0f;
            alertViewNoButton.userInteractionEnabled = YES;
            alertViewYesButton.userInteractionEnabled = YES;
            
        }];
        
    } else {
        
        [UIView animateWithDuration:0.25 animations:^{
            
            backDropView.alpha = 0.0;
            alertViewNoButton.userInteractionEnabled = NO;
            alertViewYesButton.userInteractionEnabled = NO;
            
        }];
        
    }
    
}

-(void)AdjustPurchaseView:(NSString *)premiumPlanName premiumPlanDetails:(NSString *)premiumPlanDetails {
   
    CGFloat height = CGRectGetHeight(self.view.bounds);
    CGFloat width = CGRectGetWidth(self.view.bounds);
    
    //Subscription View
    _purchaseSubscriptionView.frame = CGRectMake(0, 0, width, 0);
    _purchaseViewTopLineView.frame = CGRectMake(0, 0, width, 1);

    
    
    //Plan Label
    [self AdjustPlanView:premiumPlanName premiumPlanDetails:premiumPlanDetails];

    
    
    //Frames For Simple Option Or More Options
    UIView *viewToUse = nil;
    
    if (moreOptionsClicked == NO) {
        
        viewToUse = _simpleOptionLabel;
        
        _simpleOptionLabel.frame = CGRectMake(0, _premiumPlanLabelBackView.frame.origin.y + _premiumPlanLabelBackView.frame.size.height + (self.view.frame.size.height*0.01853998 > 16?(16):self.view.frame.size.height*0.01853998), self.view.frame.size.width, (self.view.frame.size.height*0.01853998 > 16?(16):self.view.frame.size.height*0.01853998));
    
    } else {
       
        CGFloat tableViewHeight = (self.view.frame.size.height*0.0767663 > 56.5?(56.5):self.view.frame.size.height*0.0767663)*[(NSArray *)localPremiumPlanPricesDict[defaultPremiumPlanName] count];
        
        viewToUse = _premiumPlanTableView;
       
        _premiumPlanTableView.frame = CGRectMake(0, _premiumPlanLabelBackView.frame.origin.y + _premiumPlanLabelBackView.frame.size.height + (self.view.frame.size.height*0.01853998 > 16?(16):self.view.frame.size.height*0.01853998), self.view.frame.size.width, tableViewHeight);
   
    }
    
   
    
    //Subscription Button
    BOOL PremiumUserHasSubscriptionHistory = [[[BoolDataObject alloc] init] PremiumUserHasSubscriptionHistory:homeMembersDict purchasingUserID:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
    
    NSString *subscriptionButtonTitle = PremiumUserHasSubscriptionHistory ? @"Continue" : @"Continue";
    
    [_purchaseSubscriptionButton setTitle:subscriptionButtonTitle forState:UIControlStateNormal];
    _purchaseSubscriptionButton.frame = CGRectMake(width*0.5 - (width*0.90)*0.5, viewToUse.frame.origin.y + viewToUse.frame.size.height + (self.view.frame.size.height*0.01853998 > 16?(16):self.view.frame.size.height*0.01853998), width*0.90, (self.view.frame.size.height*0.067934 > 50?(50):self.view.frame.size.height*0.067934));
    _purchaseSubscriptionButton.titleLabel.font = [UIFont systemFontOfSize:_purchaseSubscriptionButton.frame.size.height*0.32 weight:UIFontWeightSemibold];
    _purchaseSubscriptionButton.layer.cornerRadius = 14;
    
    
    
    //Bottom Labels
    CGFloat widthOfString = [[[GeneralObject alloc] init] WidthOfString:_moreOptionsLabel.text withFont:_moreOptionsLabel.font];
    _moreOptionsLabel.frame = CGRectMake(_purchaseSubscriptionButton.frame.origin.x + _purchaseSubscriptionButton.frame.size.width*0.25 - (widthOfString + (self.view.frame.size.width*0.03864734 > 16?(16):self.view.frame.size.width*0.03864734))*0.5, _purchaseSubscriptionButton.frame.origin.y + _purchaseSubscriptionButton.frame.size.height + (self.view.frame.size.height*0.01853998 > 16?(16):self.view.frame.size.height*0.01853998), widthOfString + (self.view.frame.size.width*0.03864734 > 16?(16):self.view.frame.size.width*0.03864734), (self.view.frame.size.height*0.03532609 > 26?(26):self.view.frame.size.height*0.03532609));
    
    widthOfString = [[[GeneralObject alloc] init] WidthOfString:@"  By continuing you are agreeing to our Terms of Service  " withFont:_TOSLabel.font];
    _TOSLabel.frame = CGRectMake(_purchaseSubscriptionButton.frame.origin.x + (_purchaseSubscriptionButton.frame.size.width*0.5 - widthOfString*0.5), _purchaseSubscriptionButton.frame.origin.y + _purchaseSubscriptionButton.frame.size.height + (self.view.frame.size.height*0.01086957 > 8?(8):self.view.frame.size.height*0.01086957), widthOfString, (self.view.frame.size.height*0.04347826 > 32?(32):self.view.frame.size.height*0.04347826));
    _TOSLabel.hidden = NO;
    
    widthOfString = [[[GeneralObject alloc] init] WidthOfString:_restorePurchasesLabel.text withFont:_restorePurchasesLabel.font];
    _restorePurchasesLabel.frame = CGRectMake(_purchaseSubscriptionButton.frame.origin.x + _purchaseSubscriptionButton.frame.size.width - (widthOfString+(self.view.frame.size.width*0.03864734 > 16?(16):self.view.frame.size.width*0.03864734)) - _purchaseSubscriptionButton.frame.size.width*0.25 + (widthOfString+(self.view.frame.size.width*0.03864734 > 16?(16):self.view.frame.size.width*0.03864734))*0.5, _moreOptionsLabel.frame.origin.y, widthOfString+(self.view.frame.size.width*0.03864734 > 16?(16):self.view.frame.size.width*0.03864734), (self.view.frame.size.height*0.03532609 > 26?(26):self.view.frame.size.height*0.03532609));
    
    _moreOptionsLabel.font = [UIFont systemFontOfSize:_moreOptionsLabel.frame.size.height*0.5 weight:UIFontWeightSemibold];
    _restorePurchasesLabel.font = [UIFont systemFontOfSize:_restorePurchasesLabel.frame.size.height*0.5 weight:UIFontWeightSemibold];
    _restorePurchasesLabel.hidden = YES;
    
    _moreOptionsLabel.backgroundColor = [UIColor clearColor];
    _moreOptionsLabel.clipsToBounds = YES;
    _moreOptionsLabel.layer.cornerRadius = 7;
    _moreOptionsLabel.hidden = YES;
    
    
    
    //Readjust Subscription View
    CGFloat bottomPadding = [[[GeneralObject alloc] init] GetBottomPaddingHeight];
    
    CGRect newRect = _purchaseSubscriptionView.frame;
    newRect.size.height = _TOSLabel.frame.origin.y + _TOSLabel.frame.size.height + bottomPadding;
    newRect.origin.y = self.view.frame.size.height - newRect.size.height;
    _purchaseSubscriptionView.frame = newRect;
    
    
    
    //Readjust Scroll View
    _premiumFeaturesScrollView.contentSize = CGSizeMake(width, _premiumFeaturesTableView.frame.origin.y + _premiumFeaturesTableView.frame.size.height + (self.premiumFeaturesScrollView.frame.size.height*0.01086957) + _purchaseSubscriptionView.frame.size.height);
    
    
    
    [self.view layoutIfNeeded];
    
    
    
    //Start Slide Scroll View From Beginning
    if ([_selectedSlide length] > 0 && [premiumFeatureNameArray containsObject:_selectedSlide] && _viewingSlideShow == NO) {
        
        NSUInteger index = [premiumFeatureNameArray indexOfObject:_selectedSlide];
        
        CGFloat scrollTo = (_premiumFeaturesTableView.frame.origin.y + ((self.view.frame.size.height*0.10461957 > 77?(77):self.view.frame.size.height*0.10461957)*index)) - (self.view.frame.size.height*0.5 - _purchaseSubscriptionView.frame.size.height);
        
        if (scrollTo < 0) {
            scrollTo = 0;
        }
        
        [UIView animateWithDuration:0.5 animations:^{
            self->_premiumFeaturesScrollView.contentOffset = CGPointMake(0, scrollTo);
        } completion:nil];
        
    }
    
    
    
    //Set Up Slide Scroll View
    CGFloat navigationBarHeight = [[[GeneralObject alloc] init] GetNavigationBarHeight:self];
    
    newRect = _premiumFeatureSlidesScrollViewNo1.frame;
    newRect.size.height = self.view.frame.size.height - navigationBarHeight - (self.view.frame.size.height - _purchaseSubscriptionView.frame.origin.y);
    _premiumFeatureSlidesScrollViewNo1.frame = newRect;
    
    
    
    //Set Up First Slide
    introImageOne.frame = CGRectMake(width*0.5 - ((width*0.8)*0.5), _premiumFeatureSlidesScrollViewNo1.frame.size.height*0.02154399, width*0.8, _premiumFeatureSlidesScrollViewNo1.frame.size.height*0.775);
    introHeadLabelOne.frame = CGRectMake(width*0.5 - ((width*0.71497)*0.5), introImageOne.frame.origin.y + introImageOne.frame.size.height, width*0.71497, _premiumFeatureSlidesScrollViewNo1.frame.size.height*0.08373206);
    subLabelOne.frame = CGRectMake(introHeadLabelOne.frame.origin.x, introHeadLabelOne.frame.origin.y + introHeadLabelOne.frame.size.height, introHeadLabelOne.frame.size.width, _premiumFeatureSlidesScrollViewNo1.frame.size.height*0.09569378);
    
    newRect = introViewOne.frame;
    newRect.size.height = _premiumFeatureSlidesScrollViewNo1.frame.size.height*0.02154399 + introImageOne.frame.size.height + introHeadLabelOne.frame.size.height + subLabelOne.frame.size.height + _premiumFeatureSlidesScrollViewNo1.frame.size.height*0.02154399;
    newRect.origin.y = _premiumFeatureSlidesScrollViewNo1.frame.size.height*0.5 - newRect.size.height*0.5;
    introViewOne.frame = newRect;
    
    introHeadLabelOne.font = [UIFont systemFontOfSize:(introHeadLabelOne.frame.size.width*0.45714286 > 16?(16):introHeadLabelOne.frame.size.width*0.45714286) weight:UIFontWeightSemibold];
    introHeadLabelOne.adjustsFontSizeToFitWidth = moreOptionsClicked ? YES : NO;
    
    subLabelOne.font = [UIFont systemFontOfSize:(subLabelOne.frame.size.width*0.35 > 14?(14):subLabelOne.frame.size.width*0.35) weight:UIFontWeightMedium];
    subLabelOne.adjustsFontSizeToFitWidth = moreOptionsClicked ? YES : NO;
    
    
    
    //Set Up All Other Slides
    width = CGRectGetWidth(_premiumFeatureSlidesScrollViewNo1.bounds);
    height = CGRectGetHeight(_premiumFeatureSlidesScrollViewNo1.bounds);
    
    introViewOne.frame = CGRectMake(0, 0, width, height);
    introViewTwo.frame = CGRectMake(width*1, introViewOne.frame.origin.y, width, introViewOne.frame.size.height);
    introViewThree.frame = CGRectMake(width*2, introViewOne.frame.origin.y, width, introViewOne.frame.size.height);
    introViewFour.frame = CGRectMake(width*3, introViewOne.frame.origin.y, width, introViewOne.frame.size.height);
    introViewFive.frame = CGRectMake(width*4, introViewOne.frame.origin.y, width, introViewOne.frame.size.height);
    introViewSix.frame = CGRectMake(width*5, introViewOne.frame.origin.y, width, introViewOne.frame.size.height);
    introViewSeven.frame = CGRectMake(width*6, introViewOne.frame.origin.y, width, introViewOne.frame.size.height);
    introViewEight.frame = CGRectMake(width*7, introViewOne.frame.origin.y, width, introViewOne.frame.size.height);
    introViewNine.frame = CGRectMake(width*8, introViewOne.frame.origin.y, width, introViewOne.frame.size.height);
    introViewTen.frame = CGRectMake(width*9, introViewOne.frame.origin.y, width, introViewOne.frame.size.height);
    introViewEleven.frame = CGRectMake(width*10, introViewOne.frame.origin.y, width, introViewOne.frame.size.height);
    introViewTwelve.frame = CGRectMake(width*11, introViewOne.frame.origin.y, width, introViewOne.frame.size.height);
    introViewThirteen.frame = CGRectMake(width*12, introViewOne.frame.origin.y, width, introViewOne.frame.size.height);
    introViewFourteen.frame = CGRectMake(width*13, introViewOne.frame.origin.y, width, introViewOne.frame.size.height);
    introViewFifteen.frame = CGRectMake(width*14, introViewOne.frame.origin.y, width, introViewOne.frame.size.height);
    introViewSixteen.frame = CGRectMake(width*15, introViewOne.frame.origin.y, width, introViewOne.frame.size.height);
    introViewSeventeen.frame = CGRectMake(width*16, introViewOne.frame.origin.y, width, introViewOne.frame.size.height);
    introViewEightteen.frame = CGRectMake(width*17, introViewOne.frame.origin.y, width, introViewOne.frame.size.height);
    introViewNineteen.frame = CGRectMake(width*18, introViewOne.frame.origin.y, width, introViewOne.frame.size.height);
    introViewTwenty.frame = CGRectMake(width*19, introViewOne.frame.origin.y, width, introViewOne.frame.size.height);
    introViewTwentyOne.frame = CGRectMake(width*20, introViewOne.frame.origin.y, width, introViewOne.frame.size.height);
    
    introImageTwo.frame = introImageOne.frame;
    introImageThree.frame = introImageOne.frame;
    introImageFour.frame = introImageOne.frame;
    introImageFive.frame = introImageOne.frame;
    introImageSix.frame = introImageOne.frame;
    introImageSeven.frame = introImageOne.frame;
    introImageEight.frame = introImageOne.frame;
    introImageNine.frame = introImageOne.frame;
    introImageTen.frame = introImageOne.frame;
    introImageEleven.frame = introImageOne.frame;
    introImageTwelve.frame = introImageOne.frame;
    introImageThirteen.frame = introImageOne.frame;
    introImageFourteen.frame = introImageOne.frame;
    introImageFifteen.frame = introImageOne.frame;
    introImageSixteen.frame = introImageOne.frame;
    introImageSeventeen.frame = introImageOne.frame;
    introImageEightteen.frame = introImageOne.frame;
    introImageNineteen.frame = introImageOne.frame;
    introImageTwenty.frame = introImageOne.frame;
    introImageTwentyOne.frame = introImageOne.frame;
    
    introHeadLabelTwo.frame = introHeadLabelOne.frame;
    introHeadLabelThree.frame = introHeadLabelOne.frame;
    introHeadLabelFour.frame = introHeadLabelOne.frame;
    introHeadLabelFive.frame = introHeadLabelOne.frame;
    introHeadLabelSix.frame = introHeadLabelOne.frame;
    introHeadLabelSeven.frame = introHeadLabelOne.frame;
    introHeadLabelEight.frame = introHeadLabelOne.frame;
    introHeadLabelNine.frame = introHeadLabelOne.frame;
    introHeadLabelTen.frame = introHeadLabelOne.frame;
    introHeadLabelEleven.frame = introHeadLabelOne.frame;
    introHeadLabelTwelve.frame = introHeadLabelOne.frame;
    introHeadLabelThirteen.frame = introHeadLabelOne.frame;
    introHeadLabelFourteen.frame = introHeadLabelOne.frame;
    introHeadLabelFifteen.frame = introHeadLabelOne.frame;
    introHeadLabelSixteen.frame = introHeadLabelOne.frame;
    introHeadLabelSeventeen.frame = introHeadLabelOne.frame;
    introHeadLabelEightteen.frame = introHeadLabelOne.frame;
    introHeadLabelNineteen.frame = introHeadLabelOne.frame;
    introHeadLabelTwenty.frame = introHeadLabelOne.frame;
    introHeadLabelTwentyOne.frame = introHeadLabelOne.frame;
    
    introHeadLabelTwo.adjustsFontSizeToFitWidth = YES;
    introHeadLabelThree.adjustsFontSizeToFitWidth = YES;
    introHeadLabelFour.adjustsFontSizeToFitWidth = YES;
    introHeadLabelFive.adjustsFontSizeToFitWidth = YES;
    introHeadLabelSix.adjustsFontSizeToFitWidth = YES;
    introHeadLabelSeven.adjustsFontSizeToFitWidth = YES;
    introHeadLabelEight.adjustsFontSizeToFitWidth = YES;
    introHeadLabelNine.adjustsFontSizeToFitWidth = YES;
    introHeadLabelTen.adjustsFontSizeToFitWidth = YES;
    introHeadLabelEleven.adjustsFontSizeToFitWidth = YES;
    introHeadLabelTwelve.adjustsFontSizeToFitWidth = YES;
    introHeadLabelThirteen.adjustsFontSizeToFitWidth = YES;
    introHeadLabelFourteen.adjustsFontSizeToFitWidth = YES;
    introHeadLabelFifteen.adjustsFontSizeToFitWidth = YES;
    introHeadLabelSixteen.adjustsFontSizeToFitWidth = YES;
    introHeadLabelSeventeen.adjustsFontSizeToFitWidth = YES;
    introHeadLabelEightteen.adjustsFontSizeToFitWidth = YES;
    introHeadLabelNineteen.adjustsFontSizeToFitWidth = YES;
    introHeadLabelTwenty.adjustsFontSizeToFitWidth = YES;
    introHeadLabelTwentyOne.adjustsFontSizeToFitWidth = YES;
    
    introHeadLabelTwo.font = introHeadLabelOne.font;
    introHeadLabelThree.font = introHeadLabelOne.font;
    introHeadLabelFour.font = introHeadLabelOne.font;
    introHeadLabelFive.font = introHeadLabelOne.font;
    introHeadLabelSix.font = introHeadLabelOne.font;
    introHeadLabelSeven.font = introHeadLabelOne.font;
    introHeadLabelEight.font = introHeadLabelOne.font;
    introHeadLabelNine.font = introHeadLabelOne.font;
    introHeadLabelTen.font = introHeadLabelOne.font;
    introHeadLabelEleven.font = introHeadLabelOne.font;
    introHeadLabelTwelve.font = introHeadLabelOne.font;
    introHeadLabelThirteen.font = introHeadLabelOne.font;
    introHeadLabelFourteen.font = introHeadLabelOne.font;
    introHeadLabelFifteen.font = introHeadLabelOne.font;
    introHeadLabelSixteen.font = introHeadLabelOne.font;
    introHeadLabelSeventeen.font = introHeadLabelOne.font;
    introHeadLabelEightteen.font = introHeadLabelOne.font;
    introHeadLabelNineteen.font = introHeadLabelOne.font;
    introHeadLabelTwenty.font = introHeadLabelOne.font;
    introHeadLabelTwentyOne.font = introHeadLabelOne.font;
    
    subLabelTwo.frame = subLabelOne.frame;
    subLabelThree.frame = subLabelOne.frame;
    subLabelFour.frame = subLabelOne.frame;
    subLabelFive.frame = subLabelOne.frame;
    subLabelSix.frame = subLabelOne.frame;
    subLabelSeven.frame = subLabelOne.frame;
    subLabelEight.frame = subLabelOne.frame;
    subLabelNine.frame = subLabelOne.frame;
    subLabelTen.frame = subLabelOne.frame;
    subLabelEleven.frame = subLabelOne.frame;
    subLabelTwelve.frame = subLabelOne.frame;
    subLabelThirteen.frame = subLabelOne.frame;
    subLabelFourteen.frame = subLabelOne.frame;
    subLabelFifteen.frame = subLabelOne.frame;
    subLabelSixteen.frame = subLabelOne.frame;
    subLabelSeventeen.frame = subLabelOne.frame;
    subLabelEightteen.frame = subLabelOne.frame;
    subLabelNineteen.frame = subLabelOne.frame;
    subLabelTwenty.frame = subLabelOne.frame;
    subLabelTwentyOne.frame = subLabelOne.frame;
    
    subLabelTwo.font = subLabelOne.font;
    subLabelThree.font = subLabelOne.font;
    subLabelFour.font = subLabelOne.font;
    subLabelFive.font = subLabelOne.font;
    subLabelSix.font = subLabelOne.font;
    subLabelSeven.font = subLabelOne.font;
    subLabelEight.font = subLabelOne.font;
    subLabelNine.font = subLabelOne.font;
    subLabelTen.font = subLabelOne.font;
    subLabelEleven.font = subLabelOne.font;
    subLabelTwelve.font = subLabelOne.font;
    subLabelThirteen.font = subLabelOne.font;
    subLabelFourteen.font = subLabelOne.font;
    subLabelFifteen.font = subLabelOne.font;
    subLabelSixteen.font = subLabelOne.font;
    subLabelSeventeen.font = subLabelOne.font;
    subLabelEightteen.font = subLabelOne.font;
    subLabelNineteen.font = subLabelOne.font;
    subLabelTwenty.font = subLabelOne.font;
    subLabelTwentyOne.font = subLabelOne.font;
    
    subLabelTwo.adjustsFontSizeToFitWidth = YES;
    subLabelThree.adjustsFontSizeToFitWidth = YES;
    subLabelFour.adjustsFontSizeToFitWidth = YES;
    subLabelFive.adjustsFontSizeToFitWidth = YES;
    subLabelSix.adjustsFontSizeToFitWidth = YES;
    subLabelSeven.adjustsFontSizeToFitWidth = YES;
    subLabelEight.adjustsFontSizeToFitWidth = YES;
    subLabelNine.adjustsFontSizeToFitWidth = YES;
    subLabelTen.adjustsFontSizeToFitWidth = YES;
    subLabelEleven.adjustsFontSizeToFitWidth = YES;
    subLabelTwelve.adjustsFontSizeToFitWidth = YES;
    subLabelThirteen.adjustsFontSizeToFitWidth = YES;
    subLabelFourteen.adjustsFontSizeToFitWidth = YES;
    subLabelFifteen.adjustsFontSizeToFitWidth = YES;
    subLabelSixteen.adjustsFontSizeToFitWidth = YES;
    subLabelSeventeen.adjustsFontSizeToFitWidth = YES;
    subLabelEightteen.adjustsFontSizeToFitWidth = YES;
    subLabelNineteen.adjustsFontSizeToFitWidth = YES;
    subLabelTwenty.adjustsFontSizeToFitWidth = YES;
    subLabelTwentyOne.adjustsFontSizeToFitWidth = YES;
    
}

-(void)AdjustPlanView:(NSString *)premiumPlanName premiumPlanDetails:(NSString *)premiumPlanDetails {
    
    _premiumPlanLabel.text = premiumPlanName;

    [self SetUpPlanContextMenu];
    
    
    
    CGFloat width = CGRectGetWidth(self.premiumFeaturesScrollView.bounds);
    CGFloat widthOfString = [[[GeneralObject alloc] init] WidthOfString:_premiumPlanLabel.text withFont:_premiumPlanLabel.font];
    
    _premiumPlanLabel.frame = CGRectMake(8, 0, widthOfString, (self.view.frame.size.width*0.03864734 > 16?(16):self.view.frame.size.width*0.03864734)+(self.view.frame.size.width*0.03864734 > 16?(16):self.view.frame.size.width*0.03864734));
    _premiumPlanLabel.clipsToBounds = YES;
    _premiumPlanLabel.layer.cornerRadius = 8;
    _premiumPlanLabel.textAlignment = NSTextAlignmentCenter;
    
    _downArrow.frame = CGRectMake(_premiumPlanLabel.frame.origin.x + _premiumPlanLabel.frame.size.width + 4, _premiumPlanLabel.frame.origin.y, 8.5, _premiumPlanLabel.frame.size.height);
    _downArrow.image = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [UIImage imageNamed:@"GeneralIcons.TopLabelArrow.White"] : [UIImage imageNamed:@"GeneralIcons.TopLabelArrow"];
    _downArrow.hidden = YES;
    
    _promotionalCodeButton.frame = CGRectMake(width - width*0.06038647 - width*0.04830918, width*0.04830918, width*0.06038647, width*0.06038647);
    
    _premiumPlanLabelBackView.frame = CGRectMake(width*0.5 - (_premiumPlanLabel.frame.size.width + 4 /*+ _downArrow.frame.size.width*/ + (self.view.frame.size.width*0.03864734 > 16?(16):self.view.frame.size.width*0.03864734))*0.5, (self.view.frame.size.height*0.01853998 > 16?(16):self.view.frame.size.height*0.01853998), _premiumPlanLabel.frame.size.width + 4 /*+ _downArrow.frame.size.width*/ + (self.view.frame.size.width*0.03864734 > 16?(16):self.view.frame.size.width*0.03864734), (self.view.frame.size.width*0.03864734 > 16?(16):self.view.frame.size.width*0.03864734) + (self.view.frame.size.width*0.03864734 > 16?(16):self.view.frame.size.width*0.03864734));
    _premiumPlanLabelBackView.layer.cornerRadius = 8;
    _premiumPlanLabelBackView.backgroundColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeSecondary] : [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.06];
    
    [_premiumPlanBackViewOverlay setTitle:@"" forState:UIControlStateNormal];
    _premiumPlanBackViewOverlay.frame = CGRectMake(0, 0, _premiumPlanLabelBackView.frame.size.width, _premiumPlanLabelBackView.frame.size.height);
    
    _promotionalCodeButton.hidden = YES;
    
}

-(void)AdjustPricesOfCurrentPlan {
    
    if (moreOptionsClicked == YES) {
        
        [self.premiumPlanTableView reloadData];
        
    } else {
        
        NSString *simpleOption =
        localPremiumPlanPricesDict &&
        localPremiumPlanPricesDict[_premiumPlanLabel.text] &&
        [(NSArray *)localPremiumPlanPricesDict[_premiumPlanLabel.text] count] > 2 ?
        localPremiumPlanPricesDict[_premiumPlanLabel.text][2] : @"";
        
        _simpleOptionLabel.text = simpleOption;
        
    }
    
}

-(void)AdjustSelectedPlanOption {
    
    premiumPlanImagesArray = [NSMutableArray array];
    [premiumPlanImagesArray addObject:@"PremiumCellIcons.OpenCircle.png"];
    [premiumPlanImagesArray addObject:@"PremiumCellIcons.OpenCircle.png"];
    [premiumPlanImagesArray addObject:@"PremiumCellIcons.ClosedCircle.png"];
    
    selectedIndex = NULL;
    
    [self.premiumPlanTableView reloadData];
    
}

#pragma mark - Table View Methods

//Half-Off Yearly Discount No Sale Sticker = Show Old More Expensive Yearly Price With New Cheaper Yearly Prices That Is Half Off Without Sale Sticker
//Half-Off Yearly Discount = Show Old More Expensive Yearly Price With New Cheaper Yearly Prices That Is Half Off
//Half-Off Discount = Show Old More Expensive Prices With New Cheaper Prices That Are Half Off
//Promo Code Discount = Show Old More Expensive Prices With New Cheaper Prices That Are Half Off

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    PremiumFeatureCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PremiumFeatureCell"];
    
    if (tableView == _premiumFeaturesTableView) {
        
        cell.titleLabel.text = premiumFeatureNameArray[indexPath.row];
        cell.subLabel.text = premiumFeatureDetailsArray[indexPath.row];
        cell.leftIconImage.image = [UIImage imageNamed:premiumFeatureAppIcon[indexPath.row]];
        
    } else if (tableView == _premiumPlanTableView) {
        
        PremiumPlanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PremiumPlanCell"];
        
        BOOL PremiumUserHasSubscriptionHistory = [[[BoolDataObject alloc] init] PremiumUserHasSubscriptionHistory:homeMembersDict purchasingUserID:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
        PremiumUserHasSubscriptionHistory = YES;
        
        if ([_displayDiscount isEqualToString:@"Half-Off Discount"]) {
            
            NSString *newPriceOldPrice = [self GenerateNewPriceWithOldPrice:indexPath newPricesDict:localPremiumPlanPricesDiscountDict oldPricesDict:localPremiumPlanPricesDict];
            NSString *oldPrice = localPremiumPlanPricesDict[_premiumPlanLabel.text][indexPath.row];

            cell.titleLabel.text = newPriceOldPrice;
            cell.leftIconImage.image = [UIImage imageNamed:premiumPlanImagesArray[indexPath.row]];
            cell.saveLabel.text = premiumPlanPricesSavingsDict[_premiumPlanLabel.text][indexPath.row];
            cell.oldPriceLabel.text = oldPrice;
 
        } else if ([_displayDiscount isEqualToString:@"Promo Code Discount"]) {
            
            NSString *newPriceOldPrice = [self GenerateNewPriceWithOldPrice:indexPath newPricesDict:localPremiumPlanPricesDiscountDict oldPricesDict:localPremiumPlanPricesDict];
            NSString *oldPrice = localPremiumPlanPricesDict[_premiumPlanLabel.text][indexPath.row];
            
            cell.titleLabel.text = newPriceOldPrice;
            cell.leftIconImage.image = [UIImage imageNamed:premiumPlanImagesArray[indexPath.row]];
            cell.saveLabel.text = indexPath.row == 2 ? @"75% Off" : @"";
            cell.oldPriceLabel.text = oldPrice;
            
        } else if ([_displayDiscount isEqualToString:@"Half-Off Yearly Discount"] || [_displayDiscount isEqualToString:@"Half-Off Yearly Discount No Sale Sticker"]) {
            
            NSString *newPriceOldPrice = [self GenerateNewPriceWithOldPrice:indexPath newPricesDict:localPremiumPlanPricesDict oldPricesDict:localPremiumPlanPricesDiscountDict];
            NSString *oldPrice = localPremiumPlanPricesDiscountDict[_premiumPlanLabel.text][indexPath.row];
            
            cell.titleLabel.text = newPriceOldPrice;
            cell.leftIconImage.image = [UIImage imageNamed:premiumPlanImagesArray[indexPath.row]];
            cell.saveLabel.text = indexPath.row == 2 ? @"50% Off" : @"";
            cell.oldPriceLabel.text = oldPrice;
            
        } else if (PremiumUserHasSubscriptionHistory == YES) {
           
            NSString *frequency = @"month";
            
            if (indexPath.row == 1) {
                
                frequency = @"3 months";
                
            } else if (indexPath.row == 2) {
                
                frequency = @"year";
                
            }
            
            cell.titleLabel.text = [NSString stringWithFormat:@"%@ / %@", localPremiumPlanPricesNoFreeTrialDict[_premiumPlanLabel.text][indexPath.row], frequency];
            cell.leftIconImage.image = [UIImage imageNamed:premiumPlanImagesArray[indexPath.row]];
            cell.saveLabel.text = premiumPlanPricesSavingsDict[_premiumPlanLabel.text][indexPath.row];

        } else {

            cell.titleLabel.text = localPremiumPlanPricesDict[_premiumPlanLabel.text][indexPath.row];
            cell.leftIconImage.image = [UIImage imageNamed:premiumPlanImagesArray[indexPath.row]];
            cell.saveLabel.text = premiumPlanPricesSavingsDict[_premiumPlanLabel.text][indexPath.row];

        }
     
        return cell;
        
    }
    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == _premiumFeaturesTableView) {
        
        return [premiumFeatureNameArray count];
        
    }
    
    return [(NSArray *)localPremiumPlanPricesDict[_premiumPlanLabel.text] count];
    
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(PremiumFeatureCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat height = CGRectGetHeight(cell.contentView.bounds);
    CGFloat width = CGRectGetWidth(cell.contentView.bounds);
    
    
    CGFloat cornerRadius = (self.view.frame.size.height*0.2181818182 > 12?12:(self.view.frame.size.height*0.2181818182));
    
    cell.homeMembersMainView.frame = CGRectMake(width*0.5 - ((width*0.90338164)*0.5), 0, width*0.90338164, height);
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) { cell.homeMembersMainView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeTertiary]; }
    
    
    
    if (tableView == _premiumFeaturesTableView) {
        
        if (indexPath.row == 0) {
            [[[GeneralObject alloc] init] RoundingCorners:cell.homeMembersMainView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
        } else if (indexPath.row == premiumFeatureNameArray.count - 1) {
            [[[GeneralObject alloc] init] RoundingCorners:cell.homeMembersMainView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
        }
        
    }
    
    
    
    height = CGRectGetHeight(cell.homeMembersMainView.bounds);
    width = CGRectGetWidth(cell.homeMembersMainView.bounds);
    
    CGFloat gap = (cell.contentView.frame.size.height*0.1558441 > 12?(12):cell.contentView.frame.size.height*0.1558441);
    
    cell.leftIconImage.frame = CGRectMake(gap, gap, (cell.contentView.frame.size.height*0.42207792 > 32.5?(32.5):cell.contentView.frame.size.height*0.42207792), (cell.contentView.frame.size.height*0.42207792 > 32.5?(32.5):cell.contentView.frame.size.height*0.42207792));
    
    
    
    cell.titleLabel.frame = CGRectMake(cell.leftIconImage.frame.origin.x + cell.leftIconImage.frame.size.width + gap, gap, width - (cell.leftIconImage.frame.origin.x + cell.leftIconImage.frame.size.width + gap) - gap - width*0.02339181 - gap, (cell.contentView.frame.size.height*0.194805 > 15?(15):cell.contentView.frame.size.height*0.194805));
    cell.titleLabel.adjustsFontSizeToFitWidth = NO;
    cell.titleLabel.font = [UIFont systemFontOfSize:cell.titleLabel.frame.size.height*1.067 weight:UIFontWeightMedium];
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) { cell.titleLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary]; }
    
    
    
    cell.subLabel.frame = CGRectMake(cell.titleLabel.frame.origin.x, cell.titleLabel.frame.origin.y + cell.titleLabel.frame.size.height + (gap)*0.5, cell.titleLabel.frame.size.width, (cell.contentView.frame.size.height*0.4155844 > 32?(32):cell.contentView.frame.size.height*0.4155844));
    cell.subLabel.font = [UIFont systemFontOfSize:cell.subLabel.frame.size.height*0.375 weight:UIFontWeightSemibold];
    
    
    
    cell.rightArrowImage.contentMode = UIViewContentModeScaleAspectFit;
    cell.rightArrowImage.frame = CGRectMake(width*1 - width*0.02339181 - gap, height*0, width*0.02339181, height*1);
    
    
    
    cell.homeMembersMainViewLine.frame = CGRectMake(cell.subLabel.frame.origin.x, height - 1, width*1 - (cell.subLabel.frame.origin.x), 1);
    
    
    
    if (tableView == _premiumPlanTableView) {
        
        PremiumPlanCell *cell1 = (PremiumPlanCell *)cell;
        
        cell1.leftIconImage.frame = CGRectMake(gap, height*0.5 - (cell1.contentView.frame.size.height*0.442477 > 25?(25):cell1.contentView.frame.size.height*0.442477)*0.5, (cell1.contentView.frame.size.height*0.442477 > 25?(25):cell1.contentView.frame.size.height*0.442477), (cell1.contentView.frame.size.height*0.442477 > 25?(25):cell1.contentView.frame.size.height*0.442477));
        
        
        
        BOOL DisplayOldPriceCrossedOut = /*NO;*/
        ([_displayDiscount isEqualToString:@"Promo Code Discount"] ||
         [_displayDiscount isEqualToString:@"Half-Off Discount"] ||
         (([_displayDiscount isEqualToString:@"Half-Off Yearly Discount"] || [_displayDiscount isEqualToString:@"Half-Off Yearly Discount No Sale Sticker"]) && indexPath.row == 2));
        
        cell1.saveLabel.hidden = YES;
        
        if (DisplayOldPriceCrossedOut == YES) {
            
            cell1.oldPriceLabel.frame = CGRectMake(cell1.leftIconImage.frame.origin.x + cell1.leftIconImage.frame.size.width + gap, height*0.5 - (cell1.contentView.frame.size.height*0.3539823 > 20?(20):cell1.contentView.frame.size.height*0.3539823)*0.5, 0, (cell1.contentView.frame.size.height*0.3539823 > 20?(20):cell1.contentView.frame.size.height*0.3539823));
            cell1.oldPriceLabel.font = [UIFont systemFontOfSize:cell1.oldPriceLabel.frame.size.height*0.8 weight:UIFontWeightSemibold];
            
            CGFloat widthOfString = [[[GeneralObject alloc] init] WidthOfString:cell1.oldPriceLabel.text withFont:cell1.oldPriceLabel.font];
            
            CGRect newRect = cell1.oldPriceLabel.frame;
            newRect.size.width = widthOfString;
            cell1.oldPriceLabel.frame = newRect;
            
            cell1.discountLineView.frame = CGRectMake(cell1.oldPriceLabel.frame.origin.x, cell1.oldPriceLabel.frame.origin.y + (cell1.oldPriceLabel.frame.size.height*0.5 - 1*0.5), cell1.oldPriceLabel.frame.size.width, 1);
            
            cell1.titleLabel.frame = CGRectMake(cell1.oldPriceLabel.frame.origin.x + cell1.oldPriceLabel.frame.size.width + gap, height*0.5 - (cell1.contentView.frame.size.height*0.3539823 > 20?(20):cell1.contentView.frame.size.height*0.3539823)*0.5, width - (cell1.oldPriceLabel.frame.origin.x + cell1.oldPriceLabel.frame.size.width + gap) - gap - width*0.02339181 - gap, (cell1.contentView.frame.size.height*0.3539823 > 20?(20):cell1.contentView.frame.size.height*0.3539823));
            
            cell1.oldPriceLabel.hidden = NO;
            cell1.discountLineView.hidden = NO;
            
        } else {
            
            cell1.titleLabel.frame = CGRectMake(cell1.leftIconImage.frame.origin.x + cell1.leftIconImage.frame.size.width + gap, height*0.5 - (cell1.contentView.frame.size.height*0.3539823 > 20?(20):cell1.contentView.frame.size.height*0.3539823)*0.5, width - (cell1.leftIconImage.frame.origin.x + cell1.leftIconImage.frame.size.width + gap) - gap - width*0.02339181 - gap, (cell1.contentView.frame.size.height*0.3539823 > 20?(20):cell1.contentView.frame.size.height*0.3539823));
            
            cell1.oldPriceLabel.hidden =  YES;
            cell1.discountLineView.hidden = YES;
            
        }
        
        
        
        cell1.titleLabel.font = [UIFont systemFontOfSize:cell1.titleLabel.frame.size.height*0.8 weight:UIFontWeightRegular];
        
        
        
        BOOL DisplaySelectedImage = ((selectedIndex != NULL && indexPath.row == selectedIndex.row) || (selectedIndex == NULL && indexPath.row == 2));
        
        cell1.selectedView.hidden = DisplaySelectedImage ? NO : YES;
        cell1.selectedView.frame = CGRectMake(0, 0, width, height);
        cell1.selectedView.backgroundColor = [UIColor blackColor];
        cell1.selectedView.alpha = [[[BoolDataObject alloc] init] DarkModeIsOn] ? 0.25 : 0.05;
        cell1.selectedView.layer.cornerRadius = 16;
        
        
        
        cell1.saveLabel.frame = CGRectMake(width - 0 - cell1.leftIconImage.frame.origin.x, 0, 0, height);
        cell1.saveLabel.font = [UIFont systemFontOfSize:cell1.titleLabel.frame.size.height*0.8 weight:UIFontWeightSemibold];
        
        CGFloat widthOfString = [[[GeneralObject alloc] init] WidthOfString:cell1.saveLabel.text withFont:cell1.saveLabel.font];
        
        CGRect newRect = cell1.saveLabel.frame;
        newRect.origin.x = width - widthOfString - cell1.leftIconImage.frame.origin.x;
        newRect.size.width = widthOfString;
        cell1.saveLabel.frame = newRect;
        
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == _premiumFeaturesTableView) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Premium Feature %@ Clicked", premiumFeatureNameArray[indexPath.row]] completionHandler:^(BOOL finished) {
            
        }];
        
        [[[PushObject alloc] init] PushToWeDivvyPremiumViewController:YES comingFromSignUp:_comingFromSignUp defaultPlan:@"" displayDiscount:_displayDiscount selectedSlide:premiumFeatureNameArray[indexPath.row] promoCodeID:_promoCodeID premiumPlanProductsArray:localPremiumPlanProductsArray premiumPlanPricesDict:localPremiumPlanPricesDict premiumPlanExpensivePricesDict:localPremiumPlanExpensivePricesDict premiumPlanPricesDiscountDict:localPremiumPlanPricesDiscountDict premiumPlanPricesNoFreeTrialDict:localPremiumPlanPricesNoFreeTrialDict currentViewController:self Superficial:NO];
        
    } else if (tableView == _premiumPlanTableView) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Premium Plan %@ Option %@ Clicked", _premiumPlanLabel.text, localPremiumPlanPricesDict[_premiumPlanLabel.text][indexPath.row]] completionHandler:^(BOOL finished) {
            
        }];
        
        premiumPlanImagesArray = [NSMutableArray array];
        [premiumPlanImagesArray addObject:@"PremiumCellIcons.OpenCircle.png"];
        [premiumPlanImagesArray addObject:@"PremiumCellIcons.OpenCircle.png"];
        [premiumPlanImagesArray addObject:@"PremiumCellIcons.OpenCircle.png"];
        
        [premiumPlanImagesArray replaceObjectAtIndex:indexPath.row withObject:@"PremiumCellIcons.ClosedCircle.png"];
        
        selectedIndex = indexPath;
        
        NSMutableArray *arr = [NSMutableArray array];
        
        for (int i=0 ; i<[premiumPlanImagesArray count] ; i++) {
            [arr addObject:[NSIndexPath indexPathForRow:i inSection:0]];
        }
        
        [self.premiumPlanTableView beginUpdates];
        [self.premiumPlanTableView reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationFade];
        [self.premiumPlanTableView endUpdates];
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == _premiumPlanTableView) {
        return (self.view.frame.size.height*0.0767663 > 56.5?(56.5):self.view.frame.size.height*0.0767663);
    }
    
    return (self.view.frame.size.height*0.10461957 > 77?(77):self.view.frame.size.height*0.10461957);
    
}

#pragma mark - IAP Methods

-(void)FetchAvailableProducts {
   
    if (
        
        (_premiumPlanProductsArray && _premiumPlanPricesDict && /*_premiumPlanExpensivePricesDict &&*/ _premiumPlanPricesDiscountDict /*&& _premiumPlanPricesNoFreeTrialDict*/) &&
        
        (_premiumPlanProductsArray.count >= 24) &&
        
        (_premiumPlanPricesDict[@"Individual Plan"] &&
         _premiumPlanPricesDict[@"Housemate Plan"] &&
         _premiumPlanPricesDict[@"Family Plan"]) &&
        
        (_premiumPlanExpensivePricesDict[@"Individual Plan"] &&
         _premiumPlanExpensivePricesDict[@"Housemate Plan"] &&
         _premiumPlanExpensivePricesDict[@"Family Plan"]) &&
        
        (_premiumPlanPricesDiscountDict[@"Individual Plan"] &&
         _premiumPlanPricesDiscountDict[@"Housemate Plan"] &&
         _premiumPlanPricesDiscountDict[@"Family Plan"]) &&
        
        (localPremiumPlanPricesNoFreeTrialDict[@"Individual Plan"] &&
         localPremiumPlanPricesNoFreeTrialDict[@"Housemate Plan"] &&
         localPremiumPlanPricesNoFreeTrialDict[@"Family Plan"]) &&
        
        ([(NSArray *)_premiumPlanExpensivePricesDict[@"Individual Plan"] count] == 3 &&
         [(NSArray *)_premiumPlanExpensivePricesDict[@"Housemate Plan"] count] == 3 &&
         [(NSArray *)_premiumPlanExpensivePricesDict[@"Family Plan"] count] == 3) &
        
        ([(NSArray *)_premiumPlanPricesDict[@"Individual Plan"] count] == 3 &&
         [(NSArray *)_premiumPlanPricesDict[@"Housemate Plan"] count] == 3 &&
         [(NSArray *)_premiumPlanPricesDict[@"Family Plan"] count] == 3) &&
        
        ([(NSArray *)_premiumPlanPricesDiscountDict[@"Individual Plan"] count] == 3 &&
         [(NSArray *)_premiumPlanPricesDiscountDict[@"Housemate Plan"] count] == 3 &&
         [(NSArray *)_premiumPlanPricesDiscountDict[@"Family Plan"] count] == 3) &&
        
        ([(NSArray *)_premiumPlanPricesNoFreeTrialDict[@"Individual Plan"] count] == 3 &&
         [(NSArray *)_premiumPlanPricesNoFreeTrialDict[@"Housemate Plan"] count] == 3 &&
         [(NSArray *)_premiumPlanPricesNoFreeTrialDict[@"Family Plan"] count] == 3)
        
        ) {

            localPremiumPlanProductsArray = [_premiumPlanProductsArray mutableCopy];
            localPremiumPlanPricesDict = [_premiumPlanPricesDict mutableCopy];
            localPremiumPlanExpensivePricesDict = [_premiumPlanExpensivePricesDict mutableCopy];
            localPremiumPlanPricesDiscountDict = [_premiumPlanPricesDiscountDict mutableCopy];
            localPremiumPlanPricesNoFreeTrialDict = [_premiumPlanPricesNoFreeTrialDict mutableCopy];
           
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self GenerateJustOpennedData];
                
                [self.premiumPlanTableView reloadData];
                
            });
            
        } else {
            
            [self StartProgressView];
            
            if ([self CanMakePurchases]) {
                
                NSLog(@"Subscription - products fetchAvailableProducts");
                NSSet *productIdentifiers = [[[GeneralObject alloc] init] GenerateSubscriptionsKeyArray];
                SKProductsRequest *productsRequest = [[SKProductsRequest alloc]
                                                      initWithProductIdentifiers:productIdentifiers];
                productsRequest.delegate = self;
                [productsRequest start];
                
            }
            
        }
    
}

-(void)productsRequest:(SKProductsRequest *)request
    didReceiveResponse:(SKProductsResponse *)response {
  
    [[[GeneralObject alloc] init] GenerateProducts:response.products completionHandler:^(BOOL finished, NSString * _Nonnull errorString, NSMutableArray * _Nonnull returningPremiumPlanProductsArray, NSMutableDictionary * _Nonnull returningPremiumPlanPricesDict, NSMutableDictionary * _Nonnull returningPremiumPlanExpensivePricesDict, NSMutableDictionary * _Nonnull returningPremiumPlanPricesDiscountDict, NSMutableDictionary * _Nonnull returningPremiumPlanPricesNoFreeTrialDict) {
        
        if (errorString.length == 0) {
            
            self->localPremiumPlanProductsArray = [returningPremiumPlanProductsArray mutableCopy];
            self->localPremiumPlanPricesDict = [returningPremiumPlanPricesDict mutableCopy];
            self->localPremiumPlanExpensivePricesDict = [returningPremiumPlanExpensivePricesDict mutableCopy];
            self->localPremiumPlanPricesDiscountDict = [returningPremiumPlanPricesDiscountDict mutableCopy];
            self->localPremiumPlanPricesNoFreeTrialDict = [returningPremiumPlanPricesNoFreeTrialDict mutableCopy];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self GenerateJustOpennedData];
                
                [self.premiumPlanTableView reloadData];
                [self->progressView setHidden:YES];
                
            });
            
        } else {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self->progressView setHidden:YES];
                
                
                UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Oops!"
                                                                                    message:errorString
                                                                             preferredStyle:UIAlertControllerStyleAlert];
                
                
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Got it!"
                                                                 style:UIAlertActionStyleCancel
                                                               handler:^(UIAlertAction * _Nonnull action) {
                    
                    [self DismissViewController:self];
                    
                }];
                
                [controller addAction:cancel];
                [self presentViewController:controller animated:YES completion:nil];
               
            });
            
        }
        
    }];
    
}

- (void)purchaseMyProduct:(SKProduct*)product {
    
    [self StartProgressView];
    
    if (product) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"purchaseMyProduct"] completionHandler:^(BOOL finished) {
            
        }];
        
        NSLog(@"Subscription - Product Identifier: %@ and price: %@", product.productIdentifier, product.price);
        
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        SKPayment *payment = [SKPayment paymentWithProduct:product];
        [[SKPaymentQueue defaultQueue] addPayment:payment];
        
    } else {
        
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Oops 😪"
                                     message:@"An error occurred when trying to process your payment"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* noButton = [UIAlertAction
                                   actionWithTitle:@"Got it"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
            
            [self->progressView setHidden:YES];
            
        }];
        
        [alert addAction:noButton];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    
}

- (BOOL)CanMakePurchases {
    
    return [SKPaymentQueue canMakePayments];
    
}

-(void)paymentQueue:(SKPaymentQueue *)queue
updatedTransactions:(NSArray *)transactions {
    
    NSLog(@"Subscription - products paymentQueue %@ -- %@", queue, transactions);
    
    for (SKPaymentTransaction *transaction in transactions) {
        
        NSLog(@"Subscription - products paymentQueue1 %@", transaction.error.description);
        
        switch (transaction.transactionState) {
                
            case SKPaymentTransactionStatePurchasing: {
                
                [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"updatedTransactions - Purchasing"] completionHandler:^(BOOL finished) {
                    
                }];
                
                NSLog(@"Subscription - products SKPaymentTransactionStatePurchasing");
                
                break;
                
            }
                
            case SKPaymentTransactionStatePurchased: {
                
                [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"updatedTransactions - Purchased"] completionHandler:^(BOOL finished) {
                    
                }];
                
                NSLog(@"Subscription - products SKPaymentTransactionStatePurchased");
                
                __block int totalQueries = 4;
                __block int completedQueries = 0;
                
                
                
                
                NSString *subscriptionID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
                NSString *subscriptionDatePurchased = [[[GeneralObject alloc] init] GenerateCurrentDateString];
                NSString *subscriptionPlan = _premiumPlanLabel.text;
                NSString *subscriptionPromotionalCodeID = _promoCodeID ? _promoCodeID : @"";
                
                NSDictionary *subscriptionPriceAndFrequencyDict = [self GenerateSubscriptionPriceAndFrequency];
                
                NSString *subscriptionPrice =
                subscriptionPriceAndFrequencyDict &&
                subscriptionPriceAndFrequencyDict[@"SubscriptionPrice"] ?
                subscriptionPriceAndFrequencyDict[@"SubscriptionPrice"] : @"UnknownSubscriptionPrice";
                
                NSString *subscriptionFrequency =
                subscriptionPriceAndFrequencyDict &&
                subscriptionPriceAndFrequencyDict[@"SubscriptionFrequency"] ?
                subscriptionPriceAndFrequencyDict[@"SubscriptionFrequency"] : @"UnknownSubscriptionFrequency";
                
                NSString *subscriptionPurchasedBy =
                [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ?
                [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"UnknownSubscriptionPurchasedBy";
                
                NSString *subscriptionDiscount = @"0%";
                
                if ([_displayDiscount isEqualToString:@"Half-Off Discount"]) {
                    subscriptionDiscount = @"50%";
                } else if ([_displayDiscount isEqualToString:@"Promo Code Discount"]) {
                    subscriptionDiscount = @"75%";
                }
                
                
                
                
                __block NSMutableDictionary *oldHomeMembersDict = [self->homeMembersDict mutableCopy];
                __block NSMutableDictionary *newHomeMembersDict = [self->homeMembersDict mutableCopy];
                
                newHomeMembersDict = [[self GenerateUpdatedHomeMembersDictWeDivvyPremiumGivenByUsers:subscriptionPurchasedBy newHomeMembersDict:newHomeMembersDict] mutableCopy];
                newHomeMembersDict = [[self GenerateUpdatedHomeMembersDictWeDivvyPremiumPurchasingUser:subscriptionPurchasedBy newHomeMembersDict:newHomeMembersDict subscriptionID:subscriptionID subscriptionPlan:subscriptionPlan subscriptionFrequency:subscriptionFrequency subscriptionDatePurchased:subscriptionDatePurchased] mutableCopy];
                
                
                
                
                //Adding Subscription
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    
                    NSDictionary *dataDict = @{@"SubscriptionID" : subscriptionID,
                                               @"SubscriptionPlan" : subscriptionPlan,
                                               @"SubscriptionFrequency" : subscriptionFrequency,
                                               @"SubscriptionPrice" : subscriptionPrice,
                                               @"SubscriptionRefunded" : @"No",
                                               @"SubscriptionCancelled" : @"No",
                                               @"SubscriptionDateCancelled" : @"",
                                               @"SubscriptionDatePurchased" : subscriptionDatePurchased,
                                               @"SubscriptionPurchasedBy" : subscriptionPurchasedBy,
                                               @"SubscriptionAppVersion" : @"6.5.98",
                                               @"SubscriptionDiscountType" : subscriptionDiscount,
                                               @"SubscriptionPromotionalCodeID" : subscriptionPromotionalCodeID
                    };
                    
                    
                    [[[SetDataObject alloc] init] SetDataSubscription:dataDict completionHandler:^(BOOL finished, NSError * _Nonnull error) {
                        
                        NSLog(@"Subscription - SetDataSubscription Completed dataDict: %@", dataDict);
                        
                        if (totalQueries == (completedQueries += 1)) {
                            
                            NSLog(@"Subscription - All Queries Completed, Ended At SetDataSubscription subscriptionPlan: %@ newHomeMembersDict: %@ oldHomeMembersDict: %@ transaction : %@", subscriptionPlan, newHomeMembersDict, oldHomeMembersDict, transaction);
                            
                            [self CompleteTransaction:subscriptionPlan newHomeMembersDict:newHomeMembersDict oldHomeMembersDict:oldHomeMembersDict transaction:transaction];
                            
                        }
                        
                    }];
                    
                });
                
                
                
                
                //Updating WeDivvyPremium Dict and HomeMembersDict
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    
                    NSString *purchasingUserUserID = subscriptionPurchasedBy;
                    NSDictionary *newSubscriptionDataDict = [self GenerateNewSubscriptionDataDictForPurchasingUser:purchasingUserUserID newHomeMembersDict:newHomeMembersDict];
                    
                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userID == %@", purchasingUserUserID];
                    [[[SetDataObject alloc] init] SetDataEditCoreData:@"Users" predicate:predicate setDataObject:@{@"WeDivvyPremium" : newSubscriptionDataDict}];
                    
                    [[[SetDataObject alloc] init] UpdateDataUserData:purchasingUserUserID userDict:@{@"WeDivvyPremium" : newSubscriptionDataDict} completionHandler:^(BOOL finished, NSError * _Nonnull error) {
                        
                        NSLog(@"Subscription - SetDataUserWeDivvyPremium Completed purchasingUserUserID: %@ newSubscriptionDataDict: %@", purchasingUserUserID, newSubscriptionDataDict);
                        
                        if (totalQueries == (completedQueries += 1)) {
                            
                            NSLog(@"Subscription - All Queries Completed, Ended At SetDataUserWeDivvyPremium subscriptionPlan: %@ newHomeMembersDict: %@ oldHomeMembersDict: %@ transaction : %@", subscriptionPlan, newHomeMembersDict, oldHomeMembersDict, transaction);
                            
                            [self CompleteTransaction:subscriptionPlan newHomeMembersDict:newHomeMembersDict oldHomeMembersDict:oldHomeMembersDict transaction:transaction];
                            
                        }
                        
                    }];
                    
                });
                
                
                
                
                //Updating Promo Code If Used
                
                if ([_promoCodeID length] > 0) {
                    
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        
                        NSString *purchasingUserUserID = subscriptionPurchasedBy;
                        NSDictionary *newSubscriptionDataDict = [self GenerateNewSubscriptionDataDictForPurchasingUser:purchasingUserUserID newHomeMembersDict:newHomeMembersDict];
                        
                        [[[SetDataObject alloc] init] UpdateDataPromotionalCodeUsed:self->_promoCodeID dataDict:@{@"PromotionalCodeDateUsedByReceiver" : subscriptionDatePurchased} completionHandler:^(BOOL finished) {
                            
                            NSString *notificationType = @"";
                            NSString *notificationItemType = @"";
                            
                            NSString *promoCodeSentBy = self->promoCodeDict[@"PromotionalCodeSentBy"] && [(NSArray *)self->promoCodeDict[@"PromotionalCodeSentBy"] count] > 0 ? self->promoCodeDict[@"PromotionalCodeSentBy"][0] : @"";
                            NSString *promoCode = self->promoCodeDict[@"PromotionalCode"] && [(NSArray *)self->promoCodeDict[@"PromotionalCode"] count] > 0 ? self->promoCodeDict[@"PromotionalCode"][0] : @"";
                            
                            //Notify User Who Sent Promotional Code
                            NSString *pushNotificationTitle = @"Promo Code Redeemed 📱💰";
                            NSString *pushNotificationBody = [NSString stringWithFormat:@"%@ has been used. Go to your promo code page to redeem your discount.", promoCode];
                            
                            [[[NotificationsObject alloc] init] SendPushNotificationToArrayOfUsers_Other:[@[promoCodeSentBy] mutableCopy] dataDict:[@{} mutableCopy] homeMembersDict:self->homeMembersDict notificationSettingsDict:self->notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType pushNotificationTitle:pushNotificationTitle pushNotificationBody:pushNotificationBody RemoveUsersNotInHome:YES completionHandler:^(BOOL finished) {
                                
                                NSLog(@"Subscription - UpdateDataPromotionalCodeUsed Completed purchasingUserUserID: %@ newSubscriptionDataDict: %@", purchasingUserUserID, newSubscriptionDataDict);
                                
                                if (totalQueries == (completedQueries += 1)) {
                                    
                                    NSLog(@"Subscription - All Queries Completed, Ended At UpdateDataPromotionalCodeUsed subscriptionPlan: %@ newHomeMembersDict: %@ oldHomeMembersDict: %@ transaction : %@", subscriptionPlan, newHomeMembersDict, oldHomeMembersDict, transaction);
                                    
                                    [self CompleteTransaction:subscriptionPlan newHomeMembersDict:newHomeMembersDict oldHomeMembersDict:oldHomeMembersDict transaction:transaction];
                                    
                                }
                                
                            }];
                            
                        }];
                        
                    });
                    
                } else {
                    
                    if (totalQueries == (completedQueries += 1)) {
                        
                        NSLog(@"Subscription - All Queries Completed, Ended At UpdateDataPromotionalCodeUsed subscriptionPlan: %@ newHomeMembersDict: %@ oldHomeMembersDict: %@ transaction : %@", subscriptionPlan, newHomeMembersDict, oldHomeMembersDict, transaction);
                        
                        [self CompleteTransaction:subscriptionPlan newHomeMembersDict:newHomeMembersDict oldHomeMembersDict:oldHomeMembersDict transaction:transaction];
                        
                    }
                    
                }
                
                
                
                
                //Sending Push Notification To Creator
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    
                    NSString *notificationTitle = [NSString stringWithFormat:@"Subscription - %@", subscriptionPurchasedBy];
                    NSString *notificationBody = [NSString stringWithFormat:@"Plan: %@ Frequency: %@", subscriptionPlan, subscriptionFrequency];
                    
                    [[[NotificationsObject alloc] init] SendPushNotificationToCreator:notificationTitle notificationBody:notificationBody badgeNumber:(NSInteger *)1 completionHandler:^(BOOL finished) {
                        
                        NSLog(@"Subscription - SendPushNotificationToCreator Completed notificationTitle: %@ notificationBody: %@", notificationTitle, notificationBody);
                        
                        if (totalQueries == (completedQueries += 1)) {
                            
                            NSLog(@"Subscription - All Queries Completed, Ended At SendPushNotificationToCreator subscriptionPlan: %@ newHomeMembersDict: %@ oldHomeMembersDict: %@ transaction : %@", subscriptionPlan, newHomeMembersDict, oldHomeMembersDict, transaction);
                            
                            [self CompleteTransaction:subscriptionPlan newHomeMembersDict:newHomeMembersDict oldHomeMembersDict:oldHomeMembersDict transaction:transaction];
                            
                        }
                        
                    }];
                    
                });
                
                
                
                
                break;
                
            }
                
            case SKPaymentTransactionStateFailed: {
                
                NSLog(@"Subscription - products SKPaymentTransactionStateFailed");
                
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
                
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:@"Oops 😪"
                                             message:@"An error occurred when trying to process your payment"
                                             preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* noButton = [UIAlertAction
                                           actionWithTitle:@"Got it"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction * action) {
                    
                    [self->progressView setHidden:YES];
                    
                }];
                
                [alert addAction:noButton];
                
                [self presentViewController:alert animated:YES completion:nil];
                
                break;
                
            }
                
            case SKPaymentTransactionStateDeferred: {
                
                NSLog(@"Subscription - products SKPaymentTransactionStateDeferred");
                
                break;
                
            }
                
            default: {
                
                NSLog(@"Subscription - products default");
                
                [self->progressView setHidden:YES];
                
                break;
                
            }
                
        }
        
    }
    
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Internal Methods
#pragma mark
#pragma mark
#pragma mark -

#pragma mark Purchase Subscription Method

-(SKProduct *)GenerateProductToUse {
    
    NSString *premiumPlanLabel = _premiumPlanLabel.text;
    NSString *premiumPlan = @"Individual";
    
    if ([premiumPlanLabel containsString:@" Plan"]) {
        premiumPlan = [premiumPlanLabel componentsSeparatedByString:@" Plan"][0];
    }
   
    NSString *productGroupTypeAvailableForPurchase = [self GenerateAvailableProductGroupType];

    SKProduct *productToUse = [self FindProductWithCorrectIdentifier:productGroupTypeAvailableForPurchase premiumPlan:premiumPlan];
   
    return productToUse;
}

#pragma mark - IAP Methods

-(void)GenerateJustOpennedData {
    
    if (self->JustOpenned == YES) {
        
        self->selectedIndex = [NSIndexPath indexPathForRow:2 inSection:0];
        
        self->JustOpenned = NO;
        
        NSString *planPrice = @"";
        
        //Default Option
        planPrice =
        self->localPremiumPlanPricesDict &&
        self->localPremiumPlanPricesDict[@"Individual Plan"] &&
        [(NSArray *)self->localPremiumPlanPricesDict[@"Individual Plan"] count] > 2 ?
        self->localPremiumPlanPricesDict[@"Individual Plan"][2] : @"";
        
        self->defaultPremiumPlanPrice = planPrice;
        self.simpleOptionLabel.text = self->defaultPremiumPlanPrice;
        
    }
    
}

-(NSDictionary *)GenerateSubscriptionPriceAndFrequency {
    
    NSString *subscriptionPrice = @"";
    NSString *subscriptionFrequency = @"";
    
    NSString *defaultSubscriptionPrice =
    self->localPremiumPlanPricesDict &&
    self->localPremiumPlanPricesDict[self->_premiumPlanLabel.text] &&
    [(NSArray *)self->localPremiumPlanPricesDict[self->_premiumPlanLabel.text] count] > 2 ?
    self->localPremiumPlanPricesDict[self->_premiumPlanLabel.text][2] : @"";
    
    if (self->selectedIndex != NULL) {
        subscriptionPrice =
        self->localPremiumPlanPricesDict &&
        self->localPremiumPlanPricesDict[self->_premiumPlanLabel.text] &&
        [(NSArray *)self->localPremiumPlanPricesDict[self->_premiumPlanLabel.text] count] > self->selectedIndex.row ?
        self->localPremiumPlanPricesDict[self->_premiumPlanLabel.text][self->selectedIndex.row] : defaultSubscriptionPrice;
    } else {
        subscriptionPrice = defaultSubscriptionPrice;
    }
   
    subscriptionFrequency = @"year";
    
    if (self->selectedIndex.row == 0) {
        subscriptionFrequency = @"month";
    } else if (self->selectedIndex.row == 1) {
        subscriptionFrequency = @"3 months";
    }
    
    return @{@"SubscriptionPrice" : subscriptionPrice, @"SubscriptionFrequency" :  subscriptionFrequency};
}

-(NSMutableDictionary *)GenerateUpdatedHomeMembersDictWeDivvyPremiumGivenByUsers:(NSString *)purchasingUserUserID newHomeMembersDict:(NSMutableDictionary *)newHomeMembersDict {
    
    for (NSString *userID in newHomeMembersDict[@"UserID"]) {
        
        NSUInteger index = [newHomeMembersDict[@"UserID"] indexOfObject:userID];
        
        NSMutableDictionary *weDivvyPremiumDictOfSpecificUser =
        [(NSArray *)newHomeMembersDict[@"WeDivvyPremium"] count] > index ?
        [newHomeMembersDict[@"WeDivvyPremium"][index] mutableCopy] : [[[[GeneralObject alloc] init] GenerateDefaultWeDivvyPremiumPlan] mutableCopy];
        
        BOOL SubscriptionWasGivenByUserWhoIsNowPurchasingANewSubscription = (weDivvyPremiumDictOfSpecificUser[@"SubscriptionGivenBy"] && [weDivvyPremiumDictOfSpecificUser[@"SubscriptionGivenBy"] isEqualToString:purchasingUserUserID]);
        
        //If a previous subscription was give to a user by the user who is now buying a new subscription, remove their previous subscription
        //The current user can choose to give those same users this new subscription after purchasing
        if (SubscriptionWasGivenByUserWhoIsNowPurchasingANewSubscription == YES) {
            
            NSDictionary *dataDict = [[[GeneralObject alloc] init] GenerateDefaultWeDivvyPremiumPlan];
            
            NSMutableDictionary *newHomeMembersDict_Copy = [newHomeMembersDict mutableCopy];
            NSMutableArray *arrayOfHomeMemberWeDivvyPremiumDicts_Copy = newHomeMembersDict_Copy[@"WeDivvyPremium"] ? [newHomeMembersDict_Copy[@"WeDivvyPremium"] mutableCopy] : [NSMutableArray array];
            
            if ([arrayOfHomeMemberWeDivvyPremiumDicts_Copy count] > index) {
                [arrayOfHomeMemberWeDivvyPremiumDicts_Copy replaceObjectAtIndex:index withObject:dataDict];
            }
            [newHomeMembersDict_Copy setObject:arrayOfHomeMemberWeDivvyPremiumDicts_Copy forKey:@"WeDivvyPremium"];
            
            newHomeMembersDict = [newHomeMembersDict_Copy mutableCopy];
            
        }
        
    }
    
    return newHomeMembersDict;
}

-(NSMutableDictionary *)GenerateUpdatedHomeMembersDictWeDivvyPremiumPurchasingUser:(NSString *)purchasingUserUserID newHomeMembersDict:(NSMutableDictionary *)newHomeMembersDict subscriptionID:(NSString *)subscriptionID subscriptionPlan:(NSString *)subscriptionPlan subscriptionFrequency:(NSString *)subscriptionFrequency subscriptionDatePurchased:(NSString *)subscriptionDatePurchased {
    
    NSUInteger indexOfPurchasingUser = [newHomeMembersDict[@"UserID"] containsObject:purchasingUserUserID] ? [newHomeMembersDict[@"UserID"] indexOfObject:purchasingUserUserID] : -1;
    
    NSMutableDictionary *newSubscriptionDataDictForPurchasingUser = [[[[GeneralObject alloc] init] GenerateDefaultWeDivvyPremiumPlan] mutableCopy];
    
    [newSubscriptionDataDictForPurchasingUser setObject:subscriptionDatePurchased forKey:@"SubscriptionDatePurchased"];
    [newSubscriptionDataDictForPurchasingUser setObject:subscriptionFrequency forKey:@"SubscriptionFrequency"];
    [newSubscriptionDataDictForPurchasingUser setObject:@"" forKey:@"SubscriptionGivenBy"];
    [newSubscriptionDataDictForPurchasingUser setObject:subscriptionPlan forKey:@"SubscriptionPlan"];
    [newSubscriptionDataDictForPurchasingUser setObject:@{@"SubscriptionID" : subscriptionID} forKey:@"SubscriptionHistory"];
    
    
    
    
    NSMutableDictionary *newHomeMembersDict_Copy = [newHomeMembersDict mutableCopy];
    NSMutableArray *arrayOfHomeMemberWeDivvyPremiumDicts_Copy = newHomeMembersDict_Copy[@"WeDivvyPremium"] ? [newHomeMembersDict_Copy[@"WeDivvyPremium"] mutableCopy] : [NSMutableArray array];
    
    if ([arrayOfHomeMemberWeDivvyPremiumDicts_Copy count] > indexOfPurchasingUser) {
        [arrayOfHomeMemberWeDivvyPremiumDicts_Copy replaceObjectAtIndex:indexOfPurchasingUser withObject:newSubscriptionDataDictForPurchasingUser];
    }
    [newHomeMembersDict_Copy setObject:arrayOfHomeMemberWeDivvyPremiumDicts_Copy forKey:@"WeDivvyPremium"];
    
    newHomeMembersDict = [newHomeMembersDict_Copy mutableCopy];
    
    return newHomeMembersDict;
}

-(NSDictionary *)GenerateNewSubscriptionDataDictForPurchasingUser:(NSString *)purchasingUserUserID newHomeMembersDict:(NSMutableDictionary *)newHomeMembersDict {
    
    NSUInteger indexOfPurchasingUser = [newHomeMembersDict[@"UserID"] containsObject:purchasingUserUserID] ? [newHomeMembersDict[@"UserID"] indexOfObject:purchasingUserUserID] : -1;
    
    NSMutableDictionary *newHomeMembersDict_Copy = [newHomeMembersDict mutableCopy];
    NSMutableArray *arrayOfHomeMemberWeDivvyPremiumDicts_Copy = newHomeMembersDict_Copy[@"WeDivvyPremium"] ? [newHomeMembersDict_Copy[@"WeDivvyPremium"] mutableCopy] : [NSMutableArray array];
    
    NSDictionary *newSubscriptionDataDictForPurchasingUser =
    [arrayOfHomeMemberWeDivvyPremiumDicts_Copy count] > indexOfPurchasingUser ?
    arrayOfHomeMemberWeDivvyPremiumDicts_Copy[indexOfPurchasingUser] : [[[GeneralObject alloc] init] GenerateDefaultWeDivvyPremiumPlan];
    
    return newSubscriptionDataDictForPurchasingUser;
}

-(void)CompleteTransaction:(NSString *)subscriptionPlan newHomeMembersDict:(NSMutableDictionary *)newHomeMembersDict oldHomeMembersDict:(NSMutableDictionary *)oldHomeMembersDict transaction:(SKPaymentTransaction *)transaction {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"CompleteTransaction"] completionHandler:^(BOOL finished) {
        
    }];
    
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    
    NSLog(@"Subscription - finishedTransaction");
    
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
    
    NSLog(@"Subscription - removeTransactionObserver");
    
    [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"PremiumSubscription"];
    
    
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self->homeMembersDict = [newHomeMembersDict mutableCopy];
        
        
        
        
        //If Individual Plan, Push To Main Page
        if ([subscriptionPlan isEqualToString:@"Individual Plan"]) {
            
            NSLog(@"Subscription - Individual Plan");
            
            //Update Update Database Data For All Home Members Who Were Given Previous Subscription By Purchasing User
            //Send Notifications To Users Who Received Premium And Users Who Lost Premium
            [[[SetDataObject alloc] init] UpdateDataWeDivvyPremiumUsersSelected:self->homeMembersDict oldHomeMembersDict:oldHomeMembersDict completionHandler:^(BOOL finished) {
                
                NSLog(@"Subscription - UpdateDataWeDivvyPremiumUsersSelected, Pushing To TasksNavigationController");
                
                [[NSUserDefaults standardUserDefaults] setObject:self->homeMembersDict forKey:@"HomeMembersDict"];
                
                [self->progressView setHidden:YES];
               
                [[[PushObject alloc] init] PushToTasksNavigationController:YES Expenses:NO Lists:NO Animated:YES currentViewController:self];
               
            }];
            
            
            
            
            //If Housemate Plan Or Family Plan, Push To Add Premium Members
        } else {
            
            NSLog(@"Subscription - Housemate Plan or Family Plan, Pushing To ViewAssignedToViewController");
            
            [self->progressView setHidden:YES];
            
            [self PushToPremiumAccountsAction:self];
            
        }
        
    });
    
}

#pragma mark - Promo Code Methods

-(void)GetPromoCode:(UITextField *)textField {
    
    if ([textField.text length] > 0) {
        
        NSArray *keyArray = [[[GeneralObject alloc] init] GeneratePromotionalCodesKeyArray];
        NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
        
        [[[GetDataObject alloc] init] GetDataPromotionalCode:keyArray userID:userID promotionalCode:textField.text completionHandler:^(BOOL finished, NSDictionary * _Nonnull dataDict) {
            
            [self CheckIfPromoCodeIsValid:dataDict];
            
        }];
        
    } else {
        
        [[[GeneralObject alloc] init] CreateAlert:@"Oops!" message:@"You forgot to enter a promo code" currentViewController:self];
        
    }
    
}

-(void)CheckIfPromoCodeIsValid:(NSDictionary *)dataDict {
    
    NSString *promotionalCodeSentBy = dataDict[@"PromotionalCodeSentBy"] && [(NSArray *)dataDict[@"PromotionalCodeSentBy"] count] > 0 ? dataDict[@"PromotionalCodeSentBy"][0] : @"";
    
    BOOL PromoCodeExists = dataDict[@"PromotionalCodeID"] && [(NSArray *)dataDict[@"PromotionalCodeID"] count] > 0;
    BOOL PromoCodeHasNotBeenUsed = dataDict[@"PromotionalCodeDateUsedByReceiver"] && [(NSArray *)dataDict[@"PromotionalCodeDateUsedByReceiver"] count] > 0 && [dataDict[@"PromotionalCodeDateUsedByReceiver"][0] isEqualToString:@""];
    BOOL PromoCodeSenderIsInYourHome = self->homeMembersDict && self->homeMembersDict[@"UserID"] && [self->homeMembersDict[@"UserID"] containsObject:promotionalCodeSentBy];
    
    BOOL PromoCodeIsValid = (PromoCodeExists == YES && PromoCodeHasNotBeenUsed == YES && PromoCodeSenderIsInYourHome == NO);
    
    if (PromoCodeExists == NO) {
        
        self->promoCodeDict = [NSMutableDictionary dictionary];
        self->_promotionalCodeButton.image = [UIImage imageNamed:@"SettingsIcons.PromoCodeTag"];
        
        [[[GeneralObject alloc] init] CreateAlert:@"Oops!" message:@"This promotional code does not exist." currentViewController:self];
        
    } else if (PromoCodeHasNotBeenUsed == NO) {
        
        self->promoCodeDict = [NSMutableDictionary dictionary];
        self->_promotionalCodeButton.image = [UIImage imageNamed:@"SettingsIcons.PromoCodeTag"];
        
        [[[GeneralObject alloc] init] CreateAlert:@"Oops!" message:@"This promotional code has already been used." currentViewController:self];
        
    } else if (PromoCodeSenderIsInYourHome == YES) {
        
        self->promoCodeDict = [NSMutableDictionary dictionary];
        self->_promotionalCodeButton.image = [UIImage imageNamed:@"SettingsIcons.PromoCodeTag"];
        
        [[[GeneralObject alloc] init] CreateAlert:@"Oops!" message:@"To receive this discount you cannot be in the same home as the sender of the promotional code. Read our \"Rules and Restrictions\" for more information." currentViewController:self];
        
    } else if (PromoCodeIsValid == YES) {
        
        self->promoCodeDict = [dataDict mutableCopy];
        self->_promotionalCodeButton.image = [UIImage imageNamed:@"SettingsIcons.PromoCodeTag.Fill"];
        [self->_enterPromoCodeTextField resignFirstResponder];
        
        [[[GeneralObject alloc] init] CreateAlert:@"Promo Code Applied! ✅" message:@"Enjoy your discount, courtesy of a friend! 😄" currentViewController:self];
        
    }
    
}

#pragma mark - ScrollView Methods

-(int)GeneratePageNum:(double)page arr:(NSArray *)arr Up:(BOOL)Up Down:(BOOL)Down {
    
    int numToReturn = 0;
    
    if (Up) {
        
        if (page >= [arr count]-1) {
            numToReturn = 0 + (page - ([arr count]-1));
        } else {
            numToReturn = (int)page+1;
        }
        
    } else if (Down) {
        
        if (page >= [arr count]+1) {
            numToReturn = 0 + (page - ([arr count]+1));
        } else {
            numToReturn = (int)page-1;
        }
        
    }
    
    return numToReturn;
}

#pragma mark - TableView Methods

-(NSString *)GenerateNewPriceWithOldPrice:(NSIndexPath *)indexPath newPricesDict:(NSDictionary *)newPricesDict oldPricesDict:(NSDictionary *)oldPricesDict {
    
    NSString *newPrice = newPricesDict[_premiumPlanLabel.text][indexPath.row];
    
    NSString *frequency = @"month";
    
    if (indexPath.row == 1) {
        frequency = @"3 months";
    } else if (indexPath.row == 2) {
        frequency = @"year";
    }
    
    NSString *newPriceWithOldPriceFormat = [NSString stringWithFormat:@"%@ / %@", newPrice, frequency];
    
    return newPriceWithOldPriceFormat;
}

#pragma mark
#pragma mark
#pragma mark
#pragma mark - Sub-Internal Methods
#pragma mark
#pragma mark

-(NSString *)GenerateAvailableProductGroupType {
    
    NSString *productGroupType = @"";
    
    BOOL PremiumUserHasSubscriptionHistory = [[[BoolDataObject alloc] init] PremiumUserHasSubscriptionHistory:homeMembersDict purchasingUserID:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
    
    if ([_displayDiscount isEqualToString:@"Half-Off Discount"] || [_displayDiscount isEqualToString:@"Promo Code Discount"]) {
        
        productGroupType = @"Discount";
        
    } else if ([_displayDiscount isEqualToString:@"Half-Off Yearly Discount"] || [_displayDiscount isEqualToString:@"Half-Off Yearly Discount No Sale Sticker"]) {
        
        productGroupType = @"";
        
    } else if (PremiumUserHasSubscriptionHistory == YES) {
        
        productGroupType = @"NoFreeTrial";
        
    }
    
    return productGroupType;
}

-(SKProduct *)FindProductWithCorrectIdentifier:(NSString *)productGroupTypeAvailableForPurchase premiumPlan:(NSString *)premiumPlan {
    
    SKProduct *productToUse = nil;
    
    BOOL NoOptionHasBeenSelected = ((moreOptionsClicked == YES && selectedIndex == NULL) || (moreOptionsClicked == NO));
   
    for (SKProduct *product in localPremiumPlanProductsArray) {
        
        BOOL ProductHasDiscountGroupType = [product.productIdentifier containsString:@"Discount"];
        BOOL ProductHasNoFreeTrialGroupType = [product.productIdentifier containsString:@"NoFreeTrial"];
        BOOL ProductHasExpensiveGroupType = [product.productIdentifier containsString:@"Expensive"];
        BOOL ProductHasRegularGroupType =
        ProductHasDiscountGroupType == NO &&
        ProductHasNoFreeTrialGroupType == NO &&
        ProductHasExpensiveGroupType == NO;
        
        BOOL ProductGroupTypeAvailableToPurchaseIsDiscountGroup = [productGroupTypeAvailableForPurchase containsString:@"Discount"];
        BOOL ProductGroupTypeAvailableToPurchaseIsNoFreeTrialGroup = [productGroupTypeAvailableForPurchase containsString:@"NoFreeTrial"];
        BOOL ProductGroupTypeAvailableToPurchaseIsExpensiveGroup = [productGroupTypeAvailableForPurchase containsString:@"Expensive"];
        BOOL ProductGroupTypeAvailableToPurchaseIsRegularGroup =
        ProductGroupTypeAvailableToPurchaseIsDiscountGroup == NO &&
        ProductGroupTypeAvailableToPurchaseIsNoFreeTrialGroup == NO &&
        ProductGroupTypeAvailableToPurchaseIsExpensiveGroup == NO;
        
        BOOL ProductHasGroupTypeThatIsAvailableToPurchase =
        /*(ProductHasDiscountGroupType && ProductGroupTypeAvailableToPurchaseIsDiscountGroup) ||
        (ProductHasNoFreeTrialGroupType && ProductGroupTypeAvailableToPurchaseIsNoFreeTrialGroup) ||
        (ProductHasExpensiveGroupType && ProductGroupTypeAvailableToPurchaseIsExpensiveGroup) ||*/
        (ProductHasRegularGroupType && ProductGroupTypeAvailableToPurchaseIsRegularGroup);
        
        BOOL ProductHasCorrectPlan = [product.productIdentifier containsString:premiumPlan];
        
        if (ProductHasGroupTypeThatIsAvailableToPurchase == YES && ProductHasCorrectPlan == YES) {
           
            BOOL ProductWithYearlyPlanHasBeenSelected = selectedIndex.row == 2;
            BOOL ProductWithThreeMonthlyPlanHasBeenSelected = selectedIndex.row == 1;
            BOOL ProductWithMonthlyPlanHasBeenSelected = selectedIndex.row == 0;
            
            BOOL ProductHasPlanFrequencyIsYearly = [product.productIdentifier containsString:@"Yearly"];
            BOOL ProductHasPlanFrequencyIsThreeMonthly = [product.productIdentifier containsString:@"ThreeMonthly"];
            BOOL ProductHasPlanFrequencyIsMonthly = [product.productIdentifier containsString:@"Monthly"];
            
            if (NoOptionHasBeenSelected == YES) {
                
                if (ProductHasPlanFrequencyIsYearly == YES) {
                    
                    productToUse = product;
                    break;
                    
                }
                
            } else {
                
                if (ProductWithYearlyPlanHasBeenSelected == YES && ProductHasPlanFrequencyIsYearly == YES) {
                    
                    productToUse = product;
                    break;
                    
                } else if (ProductWithThreeMonthlyPlanHasBeenSelected == YES && ProductHasPlanFrequencyIsThreeMonthly == YES) {
                   
                    productToUse = product;
                    break;
                    
                } else if (ProductWithMonthlyPlanHasBeenSelected == YES && ProductHasPlanFrequencyIsMonthly == YES && ProductWithThreeMonthlyPlanHasBeenSelected == NO && ProductHasPlanFrequencyIsThreeMonthly == NO) {
                  
                    productToUse = product;
                    break;
                    
                }
                
            }
            
        }
        
    }
   
    return productToUse;
}

@end
