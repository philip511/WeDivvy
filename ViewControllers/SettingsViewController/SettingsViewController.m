//
//  SettingsViewController.m
//  RoommateApp
//
//  Created by Philip Nagel on 5/18/21.
//

#import "SettingsViewController.h"
#import "AppDelegate.h"
#import "SceneDelegate.h"
#import "InitialNavigationViewController.h"

#import "GeneralObject.h"
#import "GetDataObject.h"
#import "SetDataObject.h"
#import "DeleteDataObject.h"
#import "PushObject.h"
#import "NotificationsObject.h"
#import "SettingsObject.h"
#import "HomesViewControllerObject.h"
#import "BoolDataObject.h"
#import "LightDarkModeObject.h"

#import "AlertView.h"

@interface SettingsViewController () {
    
    AlertView *alertView;
    
    MRProgressOverlayView *progressView;
    
    int totalQueries;
    int completedQueries;
    
    NSMutableArray *homeMembersArray;
    
    NSMutableDictionary *topicDict;
    NSMutableDictionary *folderDict;
    NSMutableDictionary *taskListDict;
    NSMutableDictionary *sectionDict;
    NSMutableDictionary *templateDict;
    NSMutableDictionary *homeMembersDict;
    NSMutableDictionary *notificationSettingsDict;
    
    
    
    
    UILabel *notificationTaskTypesTopLabel;
    
    UIView *changePlanOrPurchaseSubscriptionView;
    UIView *changePlanOrPurchaseSubscriptionOverlayView;
    UILabel *changePlanOrPurchaseSubscriptionSubLabel;
    
    UIView *premiumAccountsView;
    UIView *premiumAccountsOverlayView;
    UILabel *premiumAccountSubLabel;
    UIView *appIconView;
    UIView *appThemeView;
    UIView *autoDarkModeView;
    UIView *launchPageView;
    UIView *shortcutItemsView;
    
    UIView *premiumFAQView;
    
    UIView *submitPremiumFeedbackView;
    UIView *submitPremiumFeedbackOverlayView;
    UILabel *submitPremiumFeedbackSubLabel;
    
    UIImageView *appIconChosenImageView;
    UIView *appThemeChosenView;
    UILabel *autoDarkModeChosenLabel;
    UILabel *launchPageChosenLabel;
    
    UIView *premiumSettingsView;
    UIView *premiumSettingsOverlayView;
    UILabel *premiumSettingsSubLabel;
    
    UIView *donateView;
    UIView *donateOverlayView;
    UILabel *donateSubLabel;
    
    UIView *importFromRemindersView;
    UIView *tabBarRemindersView;
    
    UIView *accountInfoView;
    UIView *changeEmailView;
    UIView *changePasswordView;
    UIView *forgotPasswordView;
    UIView *notificationSettingsView;
    UIView *darkModeView;
    UIView *billingView;
    UIView *legalDocumentsView;
    
    UIView *requestFeatureView;
    UIView *reportBugView;
    UIView *liveSupportView;
    UIView *contactUsView;
    
    UIView *tellAFriendView;
    UIView *rateUsOnAppStoreView;
    UIView *socialMediaLinksView;
    UIView *playStoreView;
    UIView *receiveEmailsView;
    
    UIView *signOutView;
    UIView *deleteAccountView;
    
    
    
    
    UIButton *changePlanOrPurchaseSubscriptionButton;
    UIButton *premiumAccountsButton;
    UIButton *appIconButton;
    UIButton *appThemeButton;
    UIButton *autoDarkModeButton;
    UIButton *launchPageButton;
    UIButton *shortcutItemsButton;
    
    UIButton *premiumFAQButton;
    
    UIButton *submitPremiumFeedbackButton;
    
    UIButton *premiumSettingsButton;
    
    UIButton *donateButton;
    
    UIButton *importFromRemindersButton;
    UIButton *tabBarRemindersButton;
    
    UIButton *accountInfoButton;
    UIButton *changeEmailButton;
    UIButton *changePasswordButton;
    UIButton *forgotPasswordButton;
    UIButton *notificationSettingsButton;
    UIButton *darkModeButton;
    UIButton *billingButton;
    UIButton *legalDocumentsButton;
    
    UIButton *requestFeatureButton;
    UIButton *reportBugButton;
    UIButton *liveSupportButton;
    UIButton *contactUsButton;
    
    UIButton *tellAFriendButton;
    UIButton *rateUsOnAppStoreButton;
    UIButton *socialMediaLinksButton;
    UIButton *playStoreButton;
    UIButton *receiveEmailsButton;
    
    UIButton *signOutButton;
    UIButton *deleteAccountButton;
    
    
    
    
    UIImageView *changePlanOrPurchaseSubscriptionImage;
    UIImageView *premiumAccountsImage;
    UIImageView *appIconImage;
    UIImageView *appThemeImage;
    UIImageView *autoDarkModeImage;
    UIImageView *launchPageImage;
    UIImageView *shortcutItemImage;
    
    UIImageView *premiumFAQImage;
    
    UIImageView *submitPremiumFeedbackImage;
    
    UIImageView *premiumSettingsImage;
    
    UIImageView *donateImage;
    
    UIImageView *importFromRemindersImage;
    UIImageView *tabBarRemindersImage;
    
    UIImageView *accountInfoImage;
    UIImageView *changeEmailImage;
    UIImageView *changePasswordImage;
    UIImageView *forgotPasswordImage;
    UIImageView *notificationSettingsImage;
    UIImageView *darkModeImage;
    UIImageView *billingImage;
    UIImageView *legalDocumentsImage;
    
    UIImageView *requestFeatureImage;
    UIImageView *reportBugImage;
    UIImageView *liveSupportImage;
    UIImageView *contactUsImage;
    
    UIImageView *tellAFriendImage;
    UIImageView *rateUsOnAppStoreImage;
    UIImageView *socialMediaLinksImage;
    UIImageView *playStoreImage;
    UIImageView *receiveEmailsImage;
    
    UIImageView *signOutImage;
    UIImageView *deleteAccountImage;
    
    UISwitch *darkModeSwitch;
    UISwitch *receiveEmailsSwitch;
    
    NSMutableDictionary *premiumPlanPricesDict;
    NSMutableDictionary *premiumPlanExpensivePricesDict;
    NSMutableDictionary *premiumPlanPricesDiscountDict;
    NSMutableDictionary *premiumPlanPricesNoFreeTrialDict;
    NSMutableArray *premiumPlanProductsArray;
    
}

@end

@implementation SettingsViewController

#pragma mark - System Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self FetchAvailableProducts];
        
    });
    
    [self InitMethod];
    
    [self BarButtonItem];
    
    [self TapGesture];
    
    [self NSNotificatinObservers];
    
    [self SetUpKeyboardNSNotifications];
    
    if (_viewingPremiumSettings) {
        
        if (appIconView == nil || appIconView == NULL) {
            
            [self SetUpViewPremium];
            
        }
        
    } else {
        
        if (accountInfoView == nil || accountInfoView == NULL) {
            
            [self SetUpView];
            
        }
        
    }
    
    self.navigationController.navigationBar.backgroundColor = self.view.backgroundColor;
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        return UIStatusBarStyleLightContent;
        
    } else {
        
        return UIStatusBarStyleDefault;
        
    }
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    darkModeSwitch.onTintColor = [[[GeneralObject alloc] init] GenerateAppColor:1.0f];
    receiveEmailsSwitch.onTintColor = [[[GeneralObject alloc] init] GenerateAppColor:1.0f];
    
    [self ViewColors];
    
    _requestFeedbackAlertViewSubmitButtonLabel1.backgroundColor = [[[GeneralObject alloc] init] GenerateAppColor:1.0f];
    _requestFeedbackAlertViewSubmitButtonLabel2.backgroundColor = [[[GeneralObject alloc] init] GenerateAppColor:1.0f];
    _requestFeedbackAlertViewRateOurAppButtonLabel.backgroundColor = [[[GeneralObject alloc] init] GenerateAppColor:1.0f];
    
    
    
    
    
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    CGFloat bottomPadding = [[[GeneralObject alloc] init] GetBottomPaddingHeight];
    
    
    
    _requestFeedbackAlertViewScrollView.frame = CGRectMake(0, 0, width, height);
    _requestFeedbackAlertViewScrollView.contentSize = CGSizeMake(width*3, height);
    _requestFeedbackAlertViewScrollView.delegate = self;
    
    
    
    _requestFeedbackBackdropView.frame = CGRectMake(0, 0, width, height);
    _requestFeedbackBackdropView.alpha = 0.0;
    
    
    
    CGFloat convertedAlertViewHeight = height*0.37771739;
    
    CGFloat questionLabelHeight = (convertedAlertViewHeight*0.1294964);
    CGFloat spacing = (width*0.06038647);
    CGFloat spacingNo1 = convertedAlertViewHeight*0.03597122;
    CGFloat nextButtonHeight = ((convertedAlertViewHeight*0.1618705) > 45?(45):(convertedAlertViewHeight*0.1618705));
    CGFloat circleButtonHeight = ((convertedAlertViewHeight*0.17985612) > 50?(50):(convertedAlertViewHeight*0.17985612));
    CGFloat alertViewHeight = (((((height*0.1) > 20?(20):(height*0.1))*0.1)*2) + questionLabelHeight + spacing + circleButtonHeight + spacingNo1 + circleButtonHeight + spacing + nextButtonHeight);
    
    
    
    _requestFeedbackAlertView.frame = CGRectMake(0, height, width, alertViewHeight + bottomPadding);
    
    
    
    UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:self.requestFeedbackAlertView.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight) cornerRadii:CGSizeMake(_requestFeedbackAlertView.frame.size.height*0.15, _requestFeedbackAlertView.frame.size.height*0.15)];
    
    CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
    maskLayer1.frame = self.requestFeedbackAlertView.bounds;
    maskLayer1.path  = maskPath1.CGPath;
    self.requestFeedbackAlertView.layer.mask = maskLayer1;
    
    
    
    
    
    
    width = CGRectGetWidth(self.requestFeedbackAlertView.bounds);
    height = CGRectGetHeight(self.requestFeedbackAlertView.bounds);
    
    
    
    _requestFeedbackAlertViewXIcon1.frame = CGRectMake(width - ((height*0.1) > 20?(20):(height*0.1)) - height*0.1, height*0.1, ((height*0.1) > 20?(20):(height*0.1)), ((height*0.1) > 20?(20):(height*0.1)));
    _requestFeedbackAlertViewXIcon2.frame = CGRectMake(width + (width - ((height*0.1) > 20?(20):(height*0.1)) - height*0.1), height*0.1, ((height*0.1) > 20?(20):(height*0.1)), ((height*0.1) > 20?(20):(height*0.1)));
    _requestFeedbackAlertViewXIcon3.frame = CGRectMake(width*2 + (width - ((height*0.1) > 20?(20):(height*0.1)) - height*0.1), height*0.1, ((height*0.1) > 20?(20):(height*0.1)), ((height*0.1) > 20?(20):(height*0.1)));
    
    
    
    
    _requestFeedbackAlertViewXIcon1Cover.frame = CGRectMake(_requestFeedbackAlertViewXIcon1.frame.origin.x - height*0.1, _requestFeedbackAlertViewXIcon1.frame.origin.y - height*0.1, _requestFeedbackAlertViewXIcon1.frame.size.width + ((height*0.1)*2), _requestFeedbackAlertViewXIcon1.frame.size.height + ((height*0.1)*2));
    _requestFeedbackAlertViewXIcon2Cover.frame = CGRectMake(_requestFeedbackAlertViewXIcon2.frame.origin.x - height*0.1, _requestFeedbackAlertViewXIcon2.frame.origin.y - height*0.1, _requestFeedbackAlertViewXIcon2.frame.size.width + ((height*0.1)*2), _requestFeedbackAlertViewXIcon1.frame.size.height + ((height*0.1)*2));
    _requestFeedbackAlertViewXIcon3Cover.frame = CGRectMake(_requestFeedbackAlertViewXIcon3.frame.origin.x - height*0.1, _requestFeedbackAlertViewXIcon3.frame.origin.y - height*0.1, _requestFeedbackAlertViewXIcon3.frame.size.width + ((height*0.1)*2), _requestFeedbackAlertViewXIcon1.frame.size.height + ((height*0.1)*2));
    
    
    
    
    _requestFeedbackAlertViewQuestionLabel1.frame = CGRectMake(width*0.5 - (width*0.06038647), _requestFeedbackAlertViewXIcon1.frame.origin.y, width - ((_requestFeedbackAlertViewXIcon1.frame.size.width + height*0.1 + height*0.1)*2), questionLabelHeight);
    _requestFeedbackAlertViewQuestionLabel1.font = [UIFont systemFontOfSize:(_requestFeedbackAlertViewQuestionLabel1.frame.size.height*0.72219547) > 15?(15):(_requestFeedbackAlertViewQuestionLabel1.frame.size.height*0.72219547) weight:UIFontWeightHeavy];
    _requestFeedbackAlertViewQuestionLabel1.textColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTextPrimary] : [[[LightDarkModeObject alloc] init] LightModeTexCompletedLabel];
    
    
    
    _requestFeedbackAlertViewQuestionLabel2.frame = CGRectMake(width + (width*0.06038647), _requestFeedbackAlertViewXIcon1.frame.origin.y, width - ((width*0.09661836)*2), questionLabelHeight);
    _requestFeedbackAlertViewQuestionLabel2.font = [UIFont systemFontOfSize:_requestFeedbackAlertViewQuestionLabel1.font.pointSize weight:UIFontWeightHeavy];
    _requestFeedbackAlertViewQuestionLabel2.textColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTextPrimary] : [[[LightDarkModeObject alloc] init] LightModeTexCompletedLabel];
    
    
    
    _requestFeedbackAlertViewCheckmarkImage.frame = CGRectMake(width*2 + width*0.5 - ((((convertedAlertViewHeight*0.26978417) > 75?(75):(convertedAlertViewHeight*0.26978417)))*0.5), _requestFeedbackAlertViewXIcon1.frame.origin.y, ((convertedAlertViewHeight*0.26978417) > 75?(75):(convertedAlertViewHeight*0.26978417)), ((convertedAlertViewHeight*0.26978417) > 75?(75):(convertedAlertViewHeight*0.26978417)));
    
    
    
    _requestFeedbackAlertViewThankYouLabel.frame = CGRectMake(width*2, _requestFeedbackAlertViewCheckmarkImage.frame.origin.y + _requestFeedbackAlertViewCheckmarkImage.frame.size.height + (convertedAlertViewHeight*0.04316547), width, (convertedAlertViewHeight*0.10791367));
    _requestFeedbackAlertViewThankYouLabel.font = [UIFont systemFontOfSize:_requestFeedbackAlertViewThankYouLabel.frame.size.height*0.8333 weight:UIFontWeightMedium];
    
    
    
    _requestFeedbackAlertViewQuestionLabel3.frame = CGRectMake(width*2 + (width*0.06038647), _requestFeedbackAlertViewThankYouLabel.frame.origin.y + _requestFeedbackAlertViewThankYouLabel.frame.size.height + (convertedAlertViewHeight*0.04316547), width - ((width*0.09661836)*2), questionLabelHeight);
    _requestFeedbackAlertViewQuestionLabel3.font = [UIFont systemFontOfSize:_requestFeedbackAlertViewQuestionLabel1.font.pointSize weight:UIFontWeightBold];
    _requestFeedbackAlertViewQuestionLabel3.textColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTextPrimary] : [[[LightDarkModeObject alloc] init] LightModeTexCompletedLabel];
    
    
    
    _requestFeedbackAlertViewOption3.frame = CGRectMake(width*0.5 - (width*0.06038647), _requestFeedbackAlertViewQuestionLabel1.frame.origin.y + _requestFeedbackAlertViewQuestionLabel1.frame.size.height + spacing, circleButtonHeight, circleButtonHeight);
    _requestFeedbackAlertViewOption2.frame = CGRectMake(_requestFeedbackAlertViewOption3.frame.origin.x - _requestFeedbackAlertViewOption3.frame.size.width - (height*0.0531401), _requestFeedbackAlertViewOption3.frame.origin.y, _requestFeedbackAlertViewOption3.frame.size.width, _requestFeedbackAlertViewOption3.frame.size.width);
    _requestFeedbackAlertViewOption1.frame = CGRectMake(_requestFeedbackAlertViewOption2.frame.origin.x - _requestFeedbackAlertViewOption3.frame.size.width - (height*0.0531401), _requestFeedbackAlertViewOption3.frame.origin.y, _requestFeedbackAlertViewOption3.frame.size.width, _requestFeedbackAlertViewOption3.frame.size.width);
    _requestFeedbackAlertViewOption4.frame = CGRectMake(_requestFeedbackAlertViewOption3.frame.origin.x + _requestFeedbackAlertViewOption3.frame.size.width + (height*0.0531401), _requestFeedbackAlertViewOption3.frame.origin.y, _requestFeedbackAlertViewOption3.frame.size.width, _requestFeedbackAlertViewOption3.frame.size.width);
    _requestFeedbackAlertViewOption5.frame = CGRectMake(_requestFeedbackAlertViewOption4.frame.origin.x + _requestFeedbackAlertViewOption4.frame.size.width + (height*0.0531401), _requestFeedbackAlertViewOption3.frame.origin.y, _requestFeedbackAlertViewOption3.frame.size.width, _requestFeedbackAlertViewOption3.frame.size.width);
    
    _requestFeedbackAlertViewOption6.frame = CGRectMake(_requestFeedbackAlertViewOption1.frame.origin.x, _requestFeedbackAlertViewOption1.frame.origin.y + _requestFeedbackAlertViewOption1.frame.size.height + spacingNo1, _requestFeedbackAlertViewOption1.frame.size.width, _requestFeedbackAlertViewOption1.frame.size.width);
    _requestFeedbackAlertViewOption7.frame = CGRectMake(_requestFeedbackAlertViewOption2.frame.origin.x, _requestFeedbackAlertViewOption6.frame.origin.y, _requestFeedbackAlertViewOption1.frame.size.width, _requestFeedbackAlertViewOption1.frame.size.width);
    _requestFeedbackAlertViewOption8.frame = CGRectMake(_requestFeedbackAlertViewOption3.frame.origin.x, _requestFeedbackAlertViewOption6.frame.origin.y, _requestFeedbackAlertViewOption1.frame.size.width, _requestFeedbackAlertViewOption1.frame.size.width);
    _requestFeedbackAlertViewOption9.frame = CGRectMake(_requestFeedbackAlertViewOption4.frame.origin.x, _requestFeedbackAlertViewOption6.frame.origin.y, _requestFeedbackAlertViewOption1.frame.size.width, _requestFeedbackAlertViewOption1.frame.size.width);
    _requestFeedbackAlertViewOption10.frame = CGRectMake(_requestFeedbackAlertViewOption5.frame.origin.x, _requestFeedbackAlertViewOption6.frame.origin.y, _requestFeedbackAlertViewOption1.frame.size.width, _requestFeedbackAlertViewOption1.frame.size.width);
    
    
    
    _requestFeedbackAlertViewOption1.layer.cornerRadius = _requestFeedbackAlertViewOption1.frame.size.height/2;
    _requestFeedbackAlertViewOption2.layer.cornerRadius = _requestFeedbackAlertViewOption1.layer.cornerRadius;
    _requestFeedbackAlertViewOption3.layer.cornerRadius = _requestFeedbackAlertViewOption1.layer.cornerRadius;
    _requestFeedbackAlertViewOption4.layer.cornerRadius = _requestFeedbackAlertViewOption1.layer.cornerRadius;
    _requestFeedbackAlertViewOption5.layer.cornerRadius = _requestFeedbackAlertViewOption1.layer.cornerRadius;
    _requestFeedbackAlertViewOption6.layer.cornerRadius = _requestFeedbackAlertViewOption1.layer.cornerRadius;
    _requestFeedbackAlertViewOption7.layer.cornerRadius = _requestFeedbackAlertViewOption1.layer.cornerRadius;
    _requestFeedbackAlertViewOption8.layer.cornerRadius = _requestFeedbackAlertViewOption1.layer.cornerRadius;
    _requestFeedbackAlertViewOption9.layer.cornerRadius = _requestFeedbackAlertViewOption1.layer.cornerRadius;
    _requestFeedbackAlertViewOption10.layer.cornerRadius = _requestFeedbackAlertViewOption1.layer.cornerRadius;
    
    
    
    CGRect newRect = _requestFeedbackAlertViewQuestionLabel1.frame;
    newRect.origin.x = _requestFeedbackAlertViewOption1.frame.origin.x;
    newRect.size.width = width - _requestFeedbackAlertViewOption1.frame.origin.x - height*0.1 - height*0.1 - _requestFeedbackAlertViewXIcon1.frame.size.width;
    _requestFeedbackAlertViewQuestionLabel1.frame = newRect;
    
    newRect = _requestFeedbackAlertViewQuestionLabel2.frame;
    newRect.origin.x = width + _requestFeedbackAlertViewQuestionLabel1.frame.origin.x;
    newRect.size.width = width - (_requestFeedbackAlertViewQuestionLabel1.frame.origin.x*2);
    _requestFeedbackAlertViewQuestionLabel2.frame = newRect;
    
    newRect = _requestFeedbackAlertViewQuestionLabel3.frame;
    newRect.origin.x = width*2 + _requestFeedbackAlertViewQuestionLabel1.frame.origin.x;
    newRect.size.width = width - (_requestFeedbackAlertViewQuestionLabel1.frame.origin.x*2);
    _requestFeedbackAlertViewQuestionLabel3.frame = newRect;
    
    
    
    _requestFeedbackAlertViewNotesView.frame = CGRectMake(_requestFeedbackAlertViewQuestionLabel2.frame.origin.x, _requestFeedbackAlertViewOption3.frame.origin.y, _requestFeedbackAlertViewQuestionLabel2.frame.size.width, _requestFeedbackAlertViewOption3.frame.size.height*2 + (convertedAlertViewHeight*0.02877698));
    _requestFeedbackAlertViewNotesView.layer.cornerRadius = 7;
    
    
    
    _requestFeedbackAlertViewSubmitButtonLabel1.frame = CGRectMake((width*0.09661836), _requestFeedbackAlertViewOption6.frame.origin.y + _requestFeedbackAlertViewOption6.frame.size.height + (width*0.06038647), width - ((width*0.09661836)*2), nextButtonHeight);
    _requestFeedbackAlertViewSubmitButtonLabel1.clipsToBounds = YES;
    _requestFeedbackAlertViewSubmitButtonLabel1.layer.cornerRadius = 7;
    
    _requestFeedbackAlertViewSubmitButtonLabel2.frame = CGRectMake(width + (width*0.09661836), _requestFeedbackAlertViewOption6.frame.origin.y + _requestFeedbackAlertViewOption6.frame.size.height + (width*0.06038647), width - ((width*0.09661836)*2), nextButtonHeight);
    _requestFeedbackAlertViewSubmitButtonLabel2.clipsToBounds = YES;
    _requestFeedbackAlertViewSubmitButtonLabel2.layer.cornerRadius = 7;
    
    _requestFeedbackAlertViewRateOurAppButtonLabel.frame = CGRectMake(width*2 + (width*0.09661836), _requestFeedbackAlertViewOption6.frame.origin.y + _requestFeedbackAlertViewOption6.frame.size.height + (width*0.06038647), width - ((width*0.09661836)*2), nextButtonHeight);
    _requestFeedbackAlertViewRateOurAppButtonLabel.clipsToBounds = YES;
    _requestFeedbackAlertViewRateOurAppButtonLabel.layer.cornerRadius = 7;
    
    
    
    
    
    
    width = CGRectGetWidth(self.requestFeedbackAlertViewNotesView.bounds);
    height = CGRectGetHeight(self.requestFeedbackAlertViewNotesView.bounds);
    
    
    
    _requestFeedbackAlertViewNotesTextView.frame = CGRectMake((convertedAlertViewHeight*0.02877698), (convertedAlertViewHeight*0.02877698), width-((convertedAlertViewHeight*0.02877698)*2), height-((convertedAlertViewHeight*0.02877698)*2));
    
    _requestFeedbackAlertViewNotesTextView.delegate = self;
    [self textViewDidChange:_requestFeedbackAlertViewNotesTextView];
    
    [self->_requestFeedbackAlertViewScrollView setContentOffset:CGPointMake(self.view.frame.size.width, 0) animated:YES];
    
}

-(void)viewDidLayoutSubviews {
    
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    
    self.navigationController.navigationBar.backgroundColor = self.view.backgroundColor;
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
    } else {
        
    }
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Settings View Controller Scrolling"] completionHandler:^(BOOL finished) {
        
    }];
    
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(nullable NSError *)error {
    
    switch (result) {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            
            break;
            
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            
            break;
            
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            
            break;
            
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@",error.description);
            
            break;
    }
    
    // Dismiss the mail compose view controller.
    [controller dismissViewControllerAnimated:true completion:nil];
    
}

#pragma mark - Text View Methods

-(void)textViewDidChange:(UITextView *)textView
{
    if(_requestFeedbackAlertViewNotesTextView.text.length == 0) {
        
        _requestFeedbackAlertViewNotesTextView.textColor = [UIColor colorWithRed:181.0f/255.0f green:188.0f/255.0f blue:193.0f/255.0f alpha:1.0f];
        _requestFeedbackAlertViewNotesTextView.text = @"Leave your feedback here";
        
    }
    
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if (_requestFeedbackAlertViewNotesTextView.text.length == 0 || [_requestFeedbackAlertViewNotesTextView.text isEqualToString:@"Leave your feedback here"] == YES) {
        
        _requestFeedbackAlertViewNotesTextView.text = @"";
        _requestFeedbackAlertViewNotesTextView.textColor = [UIColor colorWithRed:138.0f/255.0f green:137.0f/255.0f blue:142.0f/255.0f alpha:1.0f];
        
    }
    
    return YES;
}

- (BOOL) textViewShouldEndEditing:(UITextView *)textView
{
    if(_requestFeedbackAlertViewNotesTextView.text.length == 0) {
        
        _requestFeedbackAlertViewNotesTextView.textColor = [UIColor colorWithRed:181.0f/255.0f green:188.0f/255.0f blue:193.0f/255.0f alpha:1.0f];
        _requestFeedbackAlertViewNotesTextView.text = @"Leave your feedback here";
        
    }
    
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if (self->_requestFeedbackAlertViewNotesTextView.text.length > 0 && [_requestFeedbackAlertViewNotesTextView.text isEqualToString:@"Leave your feedback here"] == NO) {
        
        _requestFeedbackAlertViewNotesTextView.textColor = [UIColor colorWithRed:138.0f/255.0f green:137.0f/255.0f blue:142.0f/255.0f alpha:1.0f];
        
    } else {
        
        _requestFeedbackAlertViewNotesTextView.textColor = [UIColor colorWithRed:181.0f/255.0f green:188.0f/255.0f blue:193.0f/255.0f alpha:1.0f];
        
    }
    
    if([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        
        if (_requestFeedbackAlertViewNotesTextView.text.length == 0){
            
            _requestFeedbackAlertViewNotesTextView.textColor = [UIColor colorWithRed:181.0f/255.0f green:188.0f/255.0f blue:193.0f/255.0f alpha:1.0f];
            _requestFeedbackAlertViewNotesTextView.text = @"Leave your feedback here";
            [_requestFeedbackAlertViewNotesTextView resignFirstResponder];
            
        }
        
        return NO;
        
    } else if ([textView.text isEqualToString:@"Leave your feedback here"]) {
        
        NSString *str = [NSString stringWithFormat:@"%@%@", textView.text, text];
        str = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:str arrayOfSymbols:@[@"Leave your feedback here"]];
        textView.text = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:textView.text arrayOfSymbols:@[@"Leave your feedback here"]];
        _requestFeedbackAlertViewNotesTextView.textColor = [UIColor colorWithRed:138.0f/255.0f green:137.0f/255.0f blue:142.0f/255.0f alpha:1.0f];
        
    }
    
    return YES;
}

#pragma mark - Keyboard Methods

- (void)keyboardWillShow: (NSNotification *) notification{
    
    [UIView animateWithDuration:0.25 animations:^{
        
        NSDictionary* keyboardInfo = [notification userInfo];
        NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
        CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
        
        CGRect sendCoinsButton = self->_requestFeedbackAlertView.frame;
        
        sendCoinsButton.origin.y = CGRectGetHeight(self.view.bounds)-keyboardFrameBeginRect.size.height-self->_requestFeedbackAlertView.frame.size.height;
        
        self->_requestFeedbackAlertView.frame = sendCoinsButton;
        
    }];
    
}

- (void)keyboardWillHide: (NSNotification *) notification{
    
    [UIView animateWithDuration:0.25 animations:^{
        
        CGFloat width = CGRectGetWidth(self.view.bounds);
        CGFloat height = CGRectGetHeight(self.view.bounds);
        CGFloat bottomPadding = [[[GeneralObject alloc] init] GetBottomPaddingHeight];
        
        CGFloat convertedAlertViewHeight = height*0.37771739;
        
        CGFloat questionLabelHeight = (convertedAlertViewHeight*0.1294964);
        CGFloat spacing = (width*0.06038647);
        CGFloat spacingNo1 = convertedAlertViewHeight*0.03597122;
        CGFloat nextButtonHeight = ((convertedAlertViewHeight*0.1618705) > 45?(45):(convertedAlertViewHeight*0.1618705));
        CGFloat circleButtonHeight = ((convertedAlertViewHeight*0.17985612) > 50?(50):(convertedAlertViewHeight*0.17985612));
        CGFloat alertViewHeight = (((((height*0.1) > 20?(20):(height*0.1))*0.1)*2) + questionLabelHeight + spacing + circleButtonHeight + spacingNo1 + circleButtonHeight + spacing + nextButtonHeight);
        
        self->_requestFeedbackAlertView.frame = CGRectMake(0, height - alertViewHeight - bottomPadding, width, alertViewHeight + bottomPadding);
        
    }];
    
}

#pragma mark - Init Methods

-(void)InitMethod {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewViewController:@"SettingsViewController" completionHandler:^(BOOL finished) {
        
    }];
    
    folderDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"FolderDict"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"FolderDict"] mutableCopy] : [NSMutableDictionary dictionary];
    taskListDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskListDict"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"TaskListDict"] mutableCopy] : [NSMutableDictionary dictionary];
    sectionDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"SectionDict"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"SectionDict"] mutableCopy] : [NSMutableDictionary dictionary];
    templateDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"TemplateDict"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"TemplateDict"] mutableCopy] : [NSMutableDictionary dictionary];
    homeMembersDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeMembersDict"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"HomeMembersDict"] mutableCopy] : [NSMutableDictionary dictionary];
    homeMembersArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeMembersArray"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"HomeMembersArray"] mutableCopy] : [NSMutableArray array];
    notificationSettingsDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"NotificationSettingsDict"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"NotificationSettingsDict"] mutableCopy] : [NSMutableDictionary dictionary];
    topicDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"TopicDict"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"TopicDict"] mutableCopy] : [NSMutableDictionary dictionary];
    
    _customScrollView.delegate = self;
    
    [receiveEmailsSwitch setOn:
     [[[NSUserDefaults standardUserDefaults] objectForKey:@"UserReceiveUpdateEmails"] isEqualToString:@"Yes"] ? YES : NO];

}

-(void)BarButtonItem {
    
    self.navigationItem.hidesBackButton = YES;
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(NavigationBackButtonAction:)];
    
    self.navigationItem.leftBarButtonItem = barButtonItem;
    
}

-(void)TapGesture {
    
    UITapGestureRecognizer *tapGesture;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGestureFeedbackNextButton:)];
    [_requestFeedbackAlertViewSubmitButtonLabel1 addGestureRecognizer:tapGesture];
    _requestFeedbackAlertViewSubmitButtonLabel1.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGestureFeedbackNextButton:)];
    [_requestFeedbackAlertViewSubmitButtonLabel2 addGestureRecognizer:tapGesture];
    _requestFeedbackAlertViewSubmitButtonLabel2.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGestureFeedbackNextButton:)];
    [_requestFeedbackAlertViewRateOurAppButtonLabel addGestureRecognizer:tapGesture];
    _requestFeedbackAlertViewRateOurAppButtonLabel.userInteractionEnabled = YES;

    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGestureFeedbackClose:)];
    [_requestFeedbackAlertViewXIcon1Cover addGestureRecognizer:tapGesture];
    _requestFeedbackAlertViewXIcon1Cover.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGestureFeedbackClose:)];
    [_requestFeedbackAlertViewXIcon2Cover addGestureRecognizer:tapGesture];
    _requestFeedbackAlertViewXIcon2Cover.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGestureFeedbackClose:)];
    [_requestFeedbackAlertViewXIcon3Cover addGestureRecognizer:tapGesture];
    _requestFeedbackAlertViewXIcon3Cover.userInteractionEnabled = YES;
    
}

-(void)NSNotificatinObservers {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_Settings_AppIcon" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_Settings_AppIcon:) name:@"NSNotification_Settings_AppIcon" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_Settings_AppTheme" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_Settings_AppTheme:) name:@"NSNotification_Settings_AppTheme" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_Settings_LaunchPage" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_Settings_LaunchPage:) name:@"NSNotification_Settings_LaunchPage" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_Settings_AutoDarkMode" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_Settings_AutoDarkMode:) name:@"NSNotification_Settings_AutoDarkMode" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_Settings_NotificationSettings" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_Settings_NotificationSettings:) name:@"NSNotification_Settings_NotificationSettings" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_Settings_ItemWeDivvyPremiumAccounts" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_Settings_ItemWeDivvyPremiumAccounts:) name:@"NSNotification_Settings_ItemWeDivvyPremiumAccounts" object:nil];
    
}

-(void)SetUpKeyboardNSNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}

#pragma mark - UI Methods

-(void)ViewColors {
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        self.view.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        
        [self preferredStatusBarStyle];
        
        self.navigationController.navigationBar.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        
    } else {
        
        self.view.backgroundColor = [[[LightDarkModeObject alloc] init] LightModePrimary];
        
        [self preferredStatusBarStyle];
        
        self.navigationController.navigationBar.backgroundColor = [[[LightDarkModeObject alloc] init] LightModePrimary];
        
    }
    
}

-(void)SetUpViewPremium {
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    self->_customScrollView.frame = CGRectMake(0, 0, width*1, height*1);
    
    CGFloat spacing = width * 0.04831;
    
    changePlanOrPurchaseSubscriptionView = [[UIView alloc] init];
    changePlanOrPurchaseSubscriptionButton = [[UIButton alloc] init];
    changePlanOrPurchaseSubscriptionImage = [[UIImageView alloc] init];
    changePlanOrPurchaseSubscriptionSubLabel = [[UILabel alloc] init];
    changePlanOrPurchaseSubscriptionOverlayView = [[UIView alloc] init];
    
    premiumAccountsView = [[UIView alloc] init];
    premiumAccountsButton = [[UIButton alloc] init];
    premiumAccountsImage = [[UIImageView alloc] init];
    premiumAccountSubLabel = [[UILabel alloc] init];
    premiumAccountsOverlayView = [[UIView alloc] init];
    
    appIconView = [[UIView alloc] init];
    appIconButton = [[UIButton alloc] init];
    appIconImage = [[UIImageView alloc] init];
    
    appThemeView = [[UIView alloc] init];
    appThemeButton = [[UIButton alloc] init];
    appThemeImage = [[UIImageView alloc] init];
    
    autoDarkModeView = [[UIView alloc] init];
    autoDarkModeButton = [[UIButton alloc] init];
    autoDarkModeImage = [[UIImageView alloc] init];
    
    launchPageView = [[UIView alloc] init];
    launchPageButton = [[UIButton alloc] init];
    launchPageImage = [[UIImageView alloc] init];
    
    shortcutItemsView = [[UIView alloc] init];
    shortcutItemsButton = [[UIButton alloc] init];
    shortcutItemImage = [[UIImageView alloc] init];
    
    premiumFAQView = [[UIView alloc] init];
    premiumFAQButton = [[UIButton alloc] init];
    premiumFAQImage = [[UIImageView alloc] init];
    
    submitPremiumFeedbackView = [[UIView alloc] init];
    submitPremiumFeedbackButton = [[UIButton alloc] init];
    submitPremiumFeedbackImage = [[UIImageView alloc] init];
    submitPremiumFeedbackSubLabel = [[UILabel alloc] init];
    submitPremiumFeedbackOverlayView = [[UIView alloc] init];
    
    NSUInteger index = [homeMembersDict[@"UserID"] containsObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] ? [homeMembersDict[@"UserID"] indexOfObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] : 0;
    
    BOOL SubscriptionGivenBySomeoneElse = YES;
    BOOL SubscriptionPlanIsIndividual = NO;
    NSString *subscriptionFrequency = @"";
    
    if (homeMembersDict &&
        homeMembersDict[@"WeDivvyPremium"] &&
        [(NSArray *)homeMembersDict[@"WeDivvyPremium"] count] > index &&
        homeMembersDict[@"WeDivvyPremium"][index][@"SubscriptionDatePurchased"] &&
        [homeMembersDict[@"WeDivvyPremium"][index][@"SubscriptionDatePurchased"] length] > 0) {
        
        SubscriptionGivenBySomeoneElse = NO;
        
    }
    
    if (homeMembersDict &&
        homeMembersDict[@"WeDivvyPremium"] &&
        [(NSArray *)homeMembersDict[@"WeDivvyPremium"] count] > index &&
        homeMembersDict[@"WeDivvyPremium"][index][@"SubscriptionPlan"] &&
        [homeMembersDict[@"WeDivvyPremium"][index][@"SubscriptionPlan"] length] > 0) {
        
        SubscriptionPlanIsIndividual = [homeMembersDict[@"WeDivvyPremium"][index][@"SubscriptionPlan"] isEqualToString:@"Individual Plan"] ? YES : NO;
        
    }
    
    if (homeMembersDict &&
        homeMembersDict[@"WeDivvyPremium"] &&
        [(NSArray *)homeMembersDict[@"WeDivvyPremium"] count] > index &&
        homeMembersDict[@"WeDivvyPremium"][index][@"SubscriptionFrequency"] &&
        [homeMembersDict[@"WeDivvyPremium"][index][@"SubscriptionFrequency"] length] > 0) {
        
        subscriptionFrequency = homeMembersDict[@"WeDivvyPremium"][index][@"SubscriptionFrequency"];
        
    }
    
    if (SubscriptionGivenBySomeoneElse == YES) {
        
        //Purchase Own Subscription
        
        //AppIcon
        
        premiumAccountsView.hidden = YES;
        changePlanOrPurchaseSubscriptionView.frame = CGRectMake(spacing, spacing, width - (spacing*2), (height*0.07472826 > 55?(55):height*0.07472826));
        appIconView.frame = CGRectMake(spacing, changePlanOrPurchaseSubscriptionView.frame.origin.y + changePlanOrPurchaseSubscriptionView.frame.size.height + spacing, width - (spacing*2), (height*0.0679 > 50?(50):height*0.0679));
        
    } else if (SubscriptionGivenBySomeoneElse == NO && SubscriptionPlanIsIndividual == YES) {
        
        //Change Plan
        
        //AppIcon
        
        premiumAccountsView.hidden = YES;
        changePlanOrPurchaseSubscriptionView.frame = CGRectMake(spacing, spacing, width - (spacing*2), (height*0.07472826 > 55?(55):height*0.07472826));
        appIconView.frame = CGRectMake(spacing, changePlanOrPurchaseSubscriptionView.frame.origin.y + changePlanOrPurchaseSubscriptionView.frame.size.height + spacing, width - (spacing*2), (height*0.0679 > 50?(50):height*0.0679));
        
    } else if (SubscriptionGivenBySomeoneElse == NO && SubscriptionPlanIsIndividual == NO) {
        
        //Change Plan
        //Change Accounts
        
        //AppIcon
        
        premiumAccountsView.frame = CGRectMake(spacing, spacing, width - (spacing*2), (height*0.07472826 > 55?(55):height*0.07472826));
        changePlanOrPurchaseSubscriptionView.frame = CGRectMake(spacing, premiumAccountsView.frame.origin.y + premiumAccountsView.frame.size.height, width - (spacing*2), (height*0.07472826 > 55?(55):height*0.07472826));
        
        appIconView.frame = CGRectMake(spacing, changePlanOrPurchaseSubscriptionView.frame.origin.y + changePlanOrPurchaseSubscriptionView.frame.size.height + spacing, width - (spacing*2), (height*0.0679 > 50?(50):height*0.0679));
        
    }
    
    premiumAccountsOverlayView.frame = CGRectMake(0, 0, premiumAccountsView.frame.size.width, premiumAccountsView.frame.size.height);
    changePlanOrPurchaseSubscriptionOverlayView.frame = CGRectMake(0, 0, changePlanOrPurchaseSubscriptionView.frame.size.width, changePlanOrPurchaseSubscriptionView.frame.size.height);
    
    appThemeView.frame = CGRectMake(spacing, appIconView.frame.origin.y + appIconView.frame.size.height, width - (spacing*2), (height*0.0679 > 50?(50):height*0.0679));
    autoDarkModeView.frame = CGRectMake(spacing, appThemeView.frame.origin.y + appThemeView.frame.size.height, width - (spacing*2), (height*0.0679 > 50?(50):height*0.0679));
    launchPageView.frame = CGRectMake(spacing, autoDarkModeView.frame.origin.y + autoDarkModeView.frame.size.height, width - (spacing*2), (height*0.0679 > 50?(50):height*0.0679));
    shortcutItemsView.frame = CGRectMake(spacing, launchPageView.frame.origin.y + launchPageView.frame.size.height, width - (spacing*2), (height*0.0679 > 50?(50):height*0.0679));
    
    premiumFAQView.frame = CGRectMake(spacing, shortcutItemsView.frame.origin.y + shortcutItemsView.frame.size.height + spacing, width - (spacing*2), (height*0.0679 > 50?(50):height*0.0679));
    
    submitPremiumFeedbackView.frame = CGRectMake(spacing, premiumFAQView.frame.origin.y + premiumFAQView.frame.size.height + spacing, width - (spacing*2), (height*0.0679 > 50?(50):height*0.0679));
    submitPremiumFeedbackOverlayView.frame = CGRectMake(0, 0, submitPremiumFeedbackView.frame.size.width, submitPremiumFeedbackView.frame.size.height);
    
    _customScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height + 20);
    
    CGFloat cornerRadius = (self.view.frame.size.height*0.2181818182 > 12?12:(self.view.frame.size.height*0.2181818182));
    
    NSString *changePlanOrPurchaseSubscriptionTitle = @"Update WeDivvy Premium Plan";
    
    if (SubscriptionGivenBySomeoneElse == YES) {
        
        //Purchase Own Subscription
        
        //AppIcon
        
        changePlanOrPurchaseSubscriptionTitle = @"WeDivvy Premium";
        
        [[[GeneralObject alloc] init] RoundingCorners:changePlanOrPurchaseSubscriptionView topCorners:YES bottomCorners:YES cornerRadius:cornerRadius];
        
    } else if (SubscriptionGivenBySomeoneElse == NO && SubscriptionPlanIsIndividual == YES) {
        
        //Change Plan
        
        //AppIcon
        
        changePlanOrPurchaseSubscriptionTitle = @"Update WeDivvy Premium Plan";
        
        [[[GeneralObject alloc] init] RoundingCorners:changePlanOrPurchaseSubscriptionView topCorners:YES bottomCorners:YES cornerRadius:cornerRadius];
        
    } else if (SubscriptionGivenBySomeoneElse == NO && SubscriptionPlanIsIndividual == NO) {
        
        //Change Accounts
        //Change Plan
        
        //AppIcon
        
        changePlanOrPurchaseSubscriptionTitle = @"Update WeDivvy Premium Plan";
        
        [[[GeneralObject alloc] init] RoundingCorners:premiumAccountsView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
        [[[GeneralObject alloc] init] RoundingCorners:changePlanOrPurchaseSubscriptionView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
        
    }
    
    NSString *changePlanOrPurchaseSubscriptionSubTitle = @"Update and save on WeDivvy Premium ⬆️";
    
    if (SubscriptionGivenBySomeoneElse == YES) {
        
        changePlanOrPurchaseSubscriptionSubTitle = @"Purchase your own WeDivvy Premium plan 😎";
        
    } else if (SubscriptionGivenBySomeoneElse == NO) {
        
        if ([subscriptionFrequency containsString:@" / month"]) {
            
            changePlanOrPurchaseSubscriptionSubTitle = @"Upgrade to 3 months, save 1 month 💰";
            
        } else if ([subscriptionFrequency containsString:@" / 3 month"]) {
            
            changePlanOrPurchaseSubscriptionSubTitle = @"Upgrade to 1 year, save 3 months 💰";
            
        } else {
            
            changePlanOrPurchaseSubscriptionSubTitle = @"Update and save on WeDivvy Premium ⬆️";
            
        }
        
    }
    
    [[[GeneralObject alloc] init] RoundingCorners:appIconView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
    [[[GeneralObject alloc] init] RoundingCorners:shortcutItemsView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
    
    [[[GeneralObject alloc] init] RoundingCorners:premiumFAQView topCorners:YES bottomCorners:YES cornerRadius:cornerRadius];
    
    [[[GeneralObject alloc] init] RoundingCorners:submitPremiumFeedbackView topCorners:YES bottomCorners:YES cornerRadius:cornerRadius];
    
    [self SetUpView:@[
        @{@"View" : changePlanOrPurchaseSubscriptionView, @"Button" : changePlanOrPurchaseSubscriptionButton, @"ImageView" : changePlanOrPurchaseSubscriptionImage, @"Title" : changePlanOrPurchaseSubscriptionTitle, @"Image" : [changePlanOrPurchaseSubscriptionTitle isEqualToString:@"WeDivvy Premium"] ? @"MainCellIcons.PremiumStar" :  @"MainCellIcons.PremiumStar"},
        @{@"View" : premiumAccountsView, @"Button" : premiumAccountsButton, @"ImageView" : premiumAccountsImage, @"Title" : @"WeDivvy Premium Accounts", @"Image" : @"SettingsIcons.PremiumAccounts"},
        
        @{@"View" : appIconView, @"Button" : appIconButton, @"ImageView" : appIconImage, @"Title" : @"App Icon", @"Image" : @"SettingsIcons.AppIcon"},
        @{@"View" : appThemeView, @"Button" : appThemeButton, @"ImageView" : appThemeImage, @"Title" : @"App Theme", @"Image" : @"SettingsIcons.AppTheme"},
        @{@"View" : autoDarkModeView, @"Button" : autoDarkModeButton, @"ImageView" : autoDarkModeImage, @"Title" : @"Auto Dark Mode", @"Image" : @"SettingsIcons.AutoDarkMode"},
        @{@"View" : launchPageView, @"Button" : launchPageButton, @"ImageView" : launchPageImage, @"Title" : @"Launch Page", @"Image" : @"SettingsIcons.LaunchPage"},
        @{@"View" : shortcutItemsView, @"Button" : shortcutItemsButton, @"ImageView" : shortcutItemImage, @"Title" : @"App Shortcuts", @"Image" : @"SettingsIcons.Shortcut"},
        
        @{@"View" : premiumFAQView, @"Button" : premiumFAQButton, @"ImageView" : premiumFAQImage, @"Title" : @"Premium FAQ", @"Image" : @"SettingsIcons.FAQ"},
        
        @{@"View" : submitPremiumFeedbackView, @"Button" : submitPremiumFeedbackButton, @"ImageView" : submitPremiumFeedbackImage, @"Title" : @"Submit Feedback", @"Image" : @"SettingsIcons.PremiumFeedback"},
    ]];
    
    
    
    CGRect newRect = changePlanOrPurchaseSubscriptionButton.frame;
    newRect.size.height = changePlanOrPurchaseSubscriptionView.frame.size.height*0.3273737;
    newRect.origin.y = changePlanOrPurchaseSubscriptionView.frame.size.height*0.5 - changePlanOrPurchaseSubscriptionView.frame.size.height*0.3273737;
    changePlanOrPurchaseSubscriptionButton.frame = newRect;
    
    newRect = changePlanOrPurchaseSubscriptionImage.frame;
    newRect.size.height = changePlanOrPurchaseSubscriptionView.frame.size.height*0.5;
    newRect.size.width = changePlanOrPurchaseSubscriptionView.frame.size.height*0.5;
    newRect.origin.y = changePlanOrPurchaseSubscriptionView.frame.size.height*0.5 - newRect.size.height*0.5;
    changePlanOrPurchaseSubscriptionImage.frame = newRect;
    
    newRect = premiumAccountsButton.frame;
    newRect.size.height = premiumAccountsView.frame.size.height*0.3273737;
    newRect.origin.y = premiumAccountsView.frame.size.height*0.5 - premiumAccountsView.frame.size.height*0.3273737;
    premiumAccountsButton.frame = newRect;
    
    newRect = premiumAccountsImage.frame;
    newRect.size.height = premiumAccountsView.frame.size.height*0.5;
    newRect.size.width = premiumAccountsView.frame.size.height*0.5;
    newRect.origin.y = premiumAccountsView.frame.size.height*0.5 - newRect.size.height*0.5;
    premiumAccountsImage.frame = newRect;
    
    newRect = submitPremiumFeedbackButton.frame;
    newRect.size.height = submitPremiumFeedbackView.frame.size.height*0.3273737;
    newRect.origin.y = submitPremiumFeedbackView.frame.size.height*0.5 - submitPremiumFeedbackView.frame.size.height*0.3273737;
    submitPremiumFeedbackButton.frame = newRect;
    
    //    newRect = submitPremiumFeedbackImage.frame;
    //    newRect.size.height = submitPremiumFeedbackView.frame.size.height*0.5;
    //    newRect.size.width = submitPremiumFeedbackView.frame.size.height*0.5;
    //    newRect.origin.y = submitPremiumFeedbackView.frame.size.height*0.5 - newRect.size.height*0.5;
    //    submitPremiumFeedbackImage.frame = newRect;
    
    
    
    changePlanOrPurchaseSubscriptionSubLabel.frame = CGRectMake(changePlanOrPurchaseSubscriptionButton.frame.origin.x, changePlanOrPurchaseSubscriptionView.frame.size.height*0.5, changePlanOrPurchaseSubscriptionView.frame.size.width, changePlanOrPurchaseSubscriptionView.frame.size.height*0.4);
    changePlanOrPurchaseSubscriptionSubLabel.text = changePlanOrPurchaseSubscriptionSubTitle;
    changePlanOrPurchaseSubscriptionSubLabel.textAlignment = NSTextAlignmentLeft;
    changePlanOrPurchaseSubscriptionSubLabel.font = [UIFont systemFontOfSize:premiumSettingsView.frame.size.height*0.21818 weight:UIFontWeightSemibold];
    changePlanOrPurchaseSubscriptionSubLabel.textColor = [UIColor lightGrayColor];
    
    premiumAccountSubLabel.frame = CGRectMake(premiumAccountsButton.frame.origin.x, premiumAccountsView.frame.size.height*0.5, premiumAccountsView.frame.size.width, premiumAccountsView.frame.size.height*0.4);
    premiumAccountSubLabel.text = @"Accounts with WeDivvy Premium ⭐️👤";
    premiumAccountSubLabel.textAlignment = NSTextAlignmentLeft;
    premiumAccountSubLabel.font = [UIFont systemFontOfSize:premiumSettingsView.frame.size.height*0.21818 weight:UIFontWeightSemibold];
    premiumAccountSubLabel.textColor = [UIColor lightGrayColor];
    
    submitPremiumFeedbackSubLabel.frame = CGRectMake(submitPremiumFeedbackButton.frame.origin.x, submitPremiumFeedbackView.frame.size.height*0.5, submitPremiumFeedbackView.frame.size.width, submitPremiumFeedbackView.frame.size.height*0.4);
    submitPremiumFeedbackSubLabel.text = @"How is WeDivvy Premium going? ⭐️🤔";
    submitPremiumFeedbackSubLabel.textAlignment = NSTextAlignmentLeft;
    submitPremiumFeedbackSubLabel.font = [UIFont systemFontOfSize:premiumSettingsView.frame.size.height*0.21818 weight:UIFontWeightSemibold];
    submitPremiumFeedbackSubLabel.textColor = [UIColor lightGrayColor];
    
    
    
    [changePlanOrPurchaseSubscriptionButton addTarget:self action:@selector(ChangePlanOrPurchaseSubscriptionAction:) forControlEvents:UIControlEventTouchUpInside];
    [premiumAccountsButton addTarget:self action:@selector(PremiumAccountsAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ChangePlanOrPurchaseSubscriptionAction:)];
    [changePlanOrPurchaseSubscriptionOverlayView addGestureRecognizer:tapGesture];
    changePlanOrPurchaseSubscriptionOverlayView.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(PremiumAccountsAction:)];
    [premiumAccountsOverlayView addGestureRecognizer:tapGesture];
    premiumAccountsOverlayView.userInteractionEnabled = YES;
    
    [appIconButton addTarget:self action:@selector(AppIconAction:) forControlEvents:UIControlEventTouchUpInside];
    [appThemeButton addTarget:self action:@selector(AppThemeAction:) forControlEvents:UIControlEventTouchUpInside];
    [autoDarkModeButton addTarget:self action:@selector(AutoDarkModeAction:) forControlEvents:UIControlEventTouchUpInside];
    [launchPageButton addTarget:self action:@selector(LaunchPageAction:) forControlEvents:UIControlEventTouchUpInside];
    [shortcutItemsButton addTarget:self action:@selector(ShortcutItemsAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [premiumFAQButton addTarget:self action:@selector(FAQAction:) forControlEvents:UIControlEventTouchUpInside];
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SubmitPremiumFeedback:)];
    [submitPremiumFeedbackOverlayView addGestureRecognizer:tapGesture];
    submitPremiumFeedbackOverlayView.userInteractionEnabled = YES;
    
    
    
    [self.customScrollView addSubview:premiumAccountsView];
    [premiumAccountsView addSubview:premiumAccountsButton];
    [premiumAccountsView addSubview:premiumAccountsImage];
    [premiumAccountsView addSubview:premiumAccountSubLabel];
    [premiumAccountsView addSubview:premiumAccountsOverlayView];
    
    [self.customScrollView addSubview:changePlanOrPurchaseSubscriptionView];
    [changePlanOrPurchaseSubscriptionView addSubview:changePlanOrPurchaseSubscriptionButton];
    [changePlanOrPurchaseSubscriptionView addSubview:changePlanOrPurchaseSubscriptionImage];
    [changePlanOrPurchaseSubscriptionView addSubview:changePlanOrPurchaseSubscriptionSubLabel];
    [changePlanOrPurchaseSubscriptionView addSubview:changePlanOrPurchaseSubscriptionOverlayView];
    
    [self.customScrollView addSubview:appIconView];
    [appIconView addSubview:appIconButton];
    [appIconView addSubview:appIconImage];
    
    [self.customScrollView addSubview:appThemeView];
    [appThemeView addSubview:appThemeButton];
    [appThemeView addSubview:appThemeImage];
    
    [self.customScrollView addSubview:autoDarkModeView];
    [autoDarkModeView addSubview:autoDarkModeButton];
    [autoDarkModeView addSubview:autoDarkModeImage];
    
    [self.customScrollView addSubview:launchPageView];
    [launchPageView addSubview:launchPageButton];
    [launchPageView addSubview:launchPageImage];
    
    [self.customScrollView addSubview:shortcutItemsView];
    [shortcutItemsView addSubview:shortcutItemsButton];
    [shortcutItemsView addSubview:shortcutItemImage];
    
    [self.customScrollView addSubview:premiumFAQView];
    [premiumFAQView addSubview:premiumFAQButton];
    [premiumFAQView addSubview:premiumFAQImage];
    
    [self.customScrollView addSubview:submitPremiumFeedbackView];
    [submitPremiumFeedbackView addSubview:submitPremiumFeedbackButton];
    [submitPremiumFeedbackView addSubview:submitPremiumFeedbackImage];
    [submitPremiumFeedbackView addSubview:submitPremiumFeedbackSubLabel];
    [submitPremiumFeedbackView addSubview:submitPremiumFeedbackOverlayView];
    
    [self AddRightArrowImageView:@[
        
        @{@"View" : premiumAccountsView},
        @{@"View" : changePlanOrPurchaseSubscriptionView},
        
        @{@"View" : appIconView},
        @{@"View" : appThemeView},
        @{@"View" : autoDarkModeView},
        @{@"View" : launchPageView},
        @{@"View" : shortcutItemsView},
        
        @{@"View" : premiumFAQView},
        
        @{@"View" : submitPremiumFeedbackView},
        
    ]];
    
    [self AddLineViewsPremium];
    
    
    
    
    
    
    appIconChosenImageView = [[UIImageView alloc] init];
    appThemeChosenView = [[UIView alloc] init];
    autoDarkModeChosenLabel = [[UILabel alloc] init];
    launchPageChosenLabel = [[UILabel alloc] init];
    
    autoDarkModeChosenLabel.textAlignment = NSTextAlignmentRight;
    launchPageChosenLabel.textAlignment = NSTextAlignmentRight;
    
    UIFont *fontSize = [UIFont systemFontOfSize:(self.view.frame.size.height*0.02173813 > 16?16:(self.view.frame.size.height*0.02173813)) weight:UIFontWeightRegular];
    UIColor *textColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTextSecondary] : [[[LightDarkModeObject alloc] init] LightModeTexAddTaskTextField];
    UIColor *backgroundColor = [UIColor clearColor];
    
    NSArray *viewArray = @[autoDarkModeChosenLabel, launchPageChosenLabel];
    
    for (UITextField *textField in viewArray) {
        
        textField.font = fontSize;
        textField.minimumFontSize = (appIconView.frame.size.height*0.25454545 > 14?14:(appIconView.frame.size.height*0.25454545));
        textField.adjustsFontSizeToFitWidth = YES;
        textField.textColor = textColor;
        textField.backgroundColor = backgroundColor;
        
    }
    
    NSString *str = @"Default";
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"AppIconSelected"]) {
        str = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppIconSelected"];
    }
    
    NSArray *appIconStringNameArray = [[[GeneralObject alloc] init] GenerateAppIconColorNameOptionsArray];
    index = [appIconStringNameArray containsObject:str] ? [appIconStringNameArray indexOfObject:str] : 0;
    NSArray *appIconStringImageArray = [[[GeneralObject alloc] init] GenerateAppIconImageNameOptionsArray];
    NSString *imageString = [appIconStringImageArray count] > index ? appIconStringImageArray[index] : appIconStringImageArray[0];
    UIImage *image = [UIImage imageNamed:imageString];
    appIconChosenImageView.image = image;
    [appIconView addSubview:appIconChosenImageView];
    
    str = @"Default";
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"AppThemeSelected"]) {
        str = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppThemeSelected"];
    }
    
    appThemeChosenView.backgroundColor = [[[GeneralObject alloc] init] GenerateColorOptionFromColorString:str];
    [appThemeView addSubview:appThemeChosenView];
    
    str = @"Never";
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"AutoDarkModeSelected"]) {
        str = [[NSUserDefaults standardUserDefaults] objectForKey:@"AutoDarkModeSelected"];
    }
    
    autoDarkModeChosenLabel.text = str;
    [autoDarkModeView addSubview:autoDarkModeChosenLabel];
    
    str = @"Chores";
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"LaunchPageSelected"]) {
        str = [[NSUserDefaults standardUserDefaults] objectForKey:@"LaunchPageSelected"];
    }
    
    launchPageChosenLabel.text = str;
    [launchPageView addSubview:launchPageChosenLabel];
    
    appIconChosenImageView.frame = CGRectMake(appIconView.frame.size.width - appIconView.frame.size.height*0.5 - (self.view.frame.size.width*0.0205314 > 8.5?(8.5):self.view.frame.size.width*0.0205314) - (self.view.frame.size.width*0.02898551 > 12?(12):self.view.frame.size.width*0.02898551) - (self.view.frame.size.width*0.02898551 > 12?(12):self.view.frame.size.width*0.02898551), appIconView.frame.size.height*0.5 - ((appIconView.frame.size.height*0.5)*0.5), appIconView.frame.size.height*0.5, appIconView.frame.size.height*0.5);
    appThemeChosenView.frame = CGRectMake(appThemeView.frame.size.width - appThemeView.frame.size.height*0.5 - (self.view.frame.size.width*0.0205314 > 8.5?(8.5):self.view.frame.size.width*0.0205314) - (self.view.frame.size.width*0.02898551 > 12?(12):self.view.frame.size.width*0.02898551) - (self.view.frame.size.width*0.02898551 > 12?(12):self.view.frame.size.width*0.02898551), appThemeView.frame.size.height*0.5 - ((appThemeView.frame.size.height*0.5)*0.5), appThemeView.frame.size.height*0.5, appThemeView.frame.size.height*0.5);
    appThemeChosenView.layer.cornerRadius = appThemeChosenView.frame.size.height/3;
    appThemeChosenView.clipsToBounds = YES;
    autoDarkModeChosenLabel.frame = CGRectMake(autoDarkModeView.frame.size.width - autoDarkModeView.frame.size.width*0.5 - (self.view.frame.size.width*0.0205314 > 8.5?(8.5):self.view.frame.size.width*0.0205314) - (self.view.frame.size.width*0.02898551 > 12?(12):self.view.frame.size.width*0.02898551) - (self.view.frame.size.width*0.02898551 > 12?(12):self.view.frame.size.width*0.02898551), 0, autoDarkModeView.frame.size.width*0.5, autoDarkModeView.frame.size.height);
    launchPageChosenLabel.frame = CGRectMake(launchPageView.frame.size.width - launchPageView.frame.size.width*0.5 - (self.view.frame.size.width*0.0205314 > 8.5?(8.5):self.view.frame.size.width*0.0205314) - (self.view.frame.size.width*0.02898551 > 12?(12):self.view.frame.size.width*0.02898551) - (self.view.frame.size.width*0.02898551 > 12?(12):self.view.frame.size.width*0.02898551), 0, launchPageView.frame.size.width*0.5, launchPageView.frame.size.height);
    
    appIconChosenImageView.layer.masksToBounds = YES;
    appIconChosenImageView.layer.cornerRadius = 7;
    
    
    //if (SubscriptionGivenBySomeoneElse == YES) {
    
    NSString *givenByUsername = @"";
    NSString *subscriptionPlan = @"";
    
    index = [homeMembersDict[@"UserID"] containsObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] ? [homeMembersDict[@"UserID"] indexOfObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] : 0;
    
    if (homeMembersDict &&
        homeMembersDict[@"WeDivvyPremium"] &&
        [(NSArray *)homeMembersDict[@"WeDivvyPremium"] count] > index &&
        homeMembersDict[@"WeDivvyPremium"][index][@"SubscriptionGivenBy"] &&
        [homeMembersDict[@"WeDivvyPremium"][index][@"SubscriptionGivenBy"] length] > 0) {
        
        NSString *givenByUserID = homeMembersDict[@"WeDivvyPremium"][index][@"SubscriptionGivenBy"];
        
        NSUInteger index = [homeMembersDict[@"UserID"] indexOfObject:givenByUserID];
        givenByUsername = homeMembersDict[@"Username"][index];
        
    }
    
    if (homeMembersDict &&
        homeMembersDict[@"WeDivvyPremium"] &&
        [(NSArray *)homeMembersDict[@"WeDivvyPremium"] count] > index &&
        homeMembersDict[@"WeDivvyPremium"][index][@"SubscriptionPlan"] &&
        [homeMembersDict[@"WeDivvyPremium"][index][@"SubscriptionPlan"] length] > 0) {
        
        subscriptionPlan = homeMembersDict[@"WeDivvyPremium"][index][@"SubscriptionPlan"];
        
    }
    
    CGFloat textFieldSpacing = (height*0.024456);
    
    notificationTaskTypesTopLabel = [[UILabel alloc] init];
    
    notificationTaskTypesTopLabel.frame = CGRectMake(textFieldSpacing + (self.view.frame.size.width*0.02415 > 10?(10):self.view.frame.size.width*0.02415), submitPremiumFeedbackView.frame.origin.y + submitPremiumFeedbackView.frame.size.height + spacing, width - (textFieldSpacing+10)*2, (self.view.frame.size.height*0.08152174 > 60?(60):self.view.frame.size.height*0.08152174));
    notificationTaskTypesTopLabel.textColor = [UIColor colorWithRed:115.0f/255.0f green:126.0f/255.0f blue:143.0f/255.0f alpha:1.0f];
    notificationTaskTypesTopLabel.font = [UIFont systemFontOfSize:(self.view.frame.size.height*0.02038043 > 15?(15):self.view.frame.size.height*0.02038043) weight:UIFontWeightMedium];
    notificationTaskTypesTopLabel.numberOfLines = 0;
    notificationTaskTypesTopLabel.adjustsFontSizeToFitWidth = YES;
    notificationTaskTypesTopLabel.text = SubscriptionGivenBySomeoneElse && [givenByUsername length] > 0 ?
    [NSString stringWithFormat:@"Your free WeDivvy Premium subscription was purchased and given to you by %@ and can be revoked by them at any time.", givenByUsername] : [NSString stringWithFormat:@""];
    
    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:notificationTaskTypesTopLabel.textColor, NSForegroundColorAttributeName, nil];
    
    NSMutableAttributedString *strAttributed = [[NSMutableAttributedString alloc] initWithString:notificationTaskTypesTopLabel.text attributes:attrsDictionary];
    
    NSArray *arr = SubscriptionGivenBySomeoneElse ? homeMembersDict[@"Username"] : @[@"Individual Plan", @"Housemate Plan", @"Family Plan"];
    
    NSRange range0 = [[NSString stringWithFormat:@"%@", strAttributed] rangeOfString:@""];
    
    for (NSString *innerStr in arr) {
        if ([notificationTaskTypesTopLabel.text containsString:[NSString stringWithFormat:@"%@", innerStr]]) {
            range0 = [[NSString stringWithFormat:@"%@", strAttributed] rangeOfString:innerStr];
            break;
        }
    }
    
    [strAttributed addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:(self.view.frame.size.height*0.02038043 > 15?(15):self.view.frame.size.height*0.02038043) weight:UIFontWeightSemibold] range: NSMakeRange(range0.location, range0.length)];
    [strAttributed addAttribute:NSUnderlineStyleAttributeName
                          value:[NSNumber numberWithInt:1]
                          range: NSMakeRange(range0.location, range0.length)];
    
    notificationTaskTypesTopLabel.attributedText = strAttributed;
    
    [self.customScrollView addSubview:notificationTaskTypesTopLabel];
    
    BOOL PremiumUserHasAccountsToGiveAndNotAllUsersHavePremium = [[[BoolDataObject alloc] init] PremiumUserHasAccountsToGiveAndNotAllUsersHavePremium:homeMembersDict purchasingUserID:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
    
    UIView *unusedPremiumAccountsView = [[UIView alloc] init];
    unusedPremiumAccountsView.frame = CGRectMake(premiumAccountsView.frame.origin.x - (((self.view.frame.size.height*0.0149925 > 10?(10):self.view.frame.size.height*0.0149925))*0.25), premiumAccountsView.frame.origin.y - (((self.view.frame.size.height*0.0149925 > 10?(10):self.view.frame.size.height*0.0149925))*0.25), (self.view.frame.size.height*0.0149925 > 10?(10):self.view.frame.size.height*0.0149925), (self.view.frame.size.height*0.0149925 > 10?(10):self.view.frame.size.height*0.0149925));
    unusedPremiumAccountsView.layer.cornerRadius = unusedPremiumAccountsView.frame.size.height/2;
    unusedPremiumAccountsView.backgroundColor = [UIColor systemPinkColor];
    unusedPremiumAccountsView.hidden = PremiumUserHasAccountsToGiveAndNotAllUsersHavePremium ? NO : YES;
    [self.customScrollView addSubview:unusedPremiumAccountsView];
    
    //}
    
}

-(void)SetUpView {
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    self->_customScrollView.frame = CGRectMake(0, 0, width*1, height*1);
    
    CGFloat spacing = width * 0.04831;
    
    
    
    
    premiumSettingsView = [[UIView alloc] init];
    premiumSettingsOverlayView = [[UIView alloc] init];
    premiumSettingsButton = [[UIButton alloc] init];
    premiumSettingsImage = [[UIImageView alloc] init];
    premiumSettingsSubLabel = [[UILabel alloc] init];
    
    donateView = [[UIView alloc] init];
    donateOverlayView = [[UIView alloc] init];
    donateButton = [[UIButton alloc] init];
    donateImage = [[UIImageView alloc] init];
    donateSubLabel = [[UILabel alloc] init];
    
    importFromRemindersView = [[UIView alloc] init];
    importFromRemindersButton = [[UIButton alloc] init];
    importFromRemindersImage = [[UIImageView alloc] init];
    
    tabBarRemindersView = [[UIView alloc] init];
    tabBarRemindersButton = [[UIButton alloc] init];
    tabBarRemindersImage = [[UIImageView alloc] init];
    
    accountInfoView = [[UIView alloc] init];
    accountInfoButton = [[UIButton alloc] init];
    accountInfoImage = [[UIImageView alloc] init];
    
    changeEmailView = [[UIView alloc] init];
    changeEmailButton = [[UIButton alloc] init];
    changeEmailImage = [[UIImageView alloc] init];
    
    changePasswordView = [[UIView alloc] init];
    changePasswordButton = [[UIButton alloc] init];
    changePasswordImage = [[UIImageView alloc] init];
    
    forgotPasswordView = [[UIView alloc] init];
    forgotPasswordButton = [[UIButton alloc] init];
    forgotPasswordImage = [[UIImageView alloc] init];
    
    notificationSettingsView = [[UIView alloc] init];
    notificationSettingsButton = [[UIButton alloc] init];
    notificationSettingsImage = [[UIImageView alloc] init];
    
    darkModeView = [[UIView alloc] init];
    darkModeButton = [[UIButton alloc] init];
    darkModeImage = [[UIImageView alloc] init];
    
    billingView = [[UIView alloc] init];
    billingButton = [[UIButton alloc] init];
    billingImage = [[UIImageView alloc] init];
    
    legalDocumentsView = [[UIView alloc] init];
    legalDocumentsButton = [[UIButton alloc] init];
    legalDocumentsImage = [[UIImageView alloc] init];
    
    
    
    
    requestFeatureView = [[UIView alloc] init];
    requestFeatureButton = [[UIButton alloc] init];
    requestFeatureImage = [[UIImageView alloc] init];
    
    reportBugView = [[UIView alloc] init];
    reportBugButton = [[UIButton alloc] init];
    reportBugImage = [[UIImageView alloc] init];
    
    liveSupportView = [[UIView alloc] init];
    liveSupportButton = [[UIButton alloc] init];
    liveSupportImage = [[UIImageView alloc] init];
    
    contactUsView = [[UIView alloc] init];
    contactUsButton = [[UIButton alloc] init];
    contactUsImage = [[UIImageView alloc] init];
    
    
    
    
    tellAFriendView = [[UIView alloc] init];
    tellAFriendButton = [[UIButton alloc] init];
    tellAFriendImage = [[UIImageView alloc] init];
    
    rateUsOnAppStoreView = [[UIView alloc] init];
    rateUsOnAppStoreButton = [[UIButton alloc] init];
    rateUsOnAppStoreImage = [[UIImageView alloc] init];
    
    socialMediaLinksView = [[UIView alloc] init];
    socialMediaLinksButton = [[UIButton alloc] init];
    socialMediaLinksImage = [[UIImageView alloc] init];
    
    playStoreView = [[UIView alloc] init];
    playStoreButton = [[UIButton alloc] init];
    playStoreImage = [[UIImageView alloc] init];
    
    receiveEmailsView = [[UIView alloc] init];
    receiveEmailsButton = [[UIButton alloc] init];
    receiveEmailsImage = [[UIImageView alloc] init];
    
    
    
    
    signOutView = [[UIView alloc] init];
    signOutButton = [[UIButton alloc] init];
    signOutImage = [[UIImageView alloc] init];
    
    deleteAccountView = [[UIView alloc] init];
    deleteAccountButton = [[UIButton alloc] init];
    deleteAccountImage = [[UIImageView alloc] init];
    
    
    
    
    darkModeSwitch = [[UISwitch alloc] init];
    receiveEmailsSwitch = [[UISwitch alloc] init];
    
    
    
    
    
    
    
    
    
    
    premiumSettingsView.frame = CGRectMake(spacing, spacing, width - (spacing*2), (height*0.07472826 > 55?(55):height*0.07472826));
    premiumSettingsOverlayView.frame = CGRectMake(0, 0, premiumSettingsView.frame.size.width, premiumSettingsView.frame.size.height);
    
    //    donateView.frame = CGRectMake(spacing, premiumSettingsView.frame.origin.y + premiumSettingsView.frame.size.height + spacing, width - (spacing*2), (height*0.07472826 > 55?(55):height*0.07472826));
    //    donateOverlayView.frame = CGRectMake(0, 0, donateView.frame.size.width, donateView.frame.size.height);
    //Post-Spike
//    importFromRemindersView.frame = CGRectMake(spacing, premiumSettingsView.frame.origin.y + premiumSettingsView.frame.size.height + spacing, width - (spacing*2), (height*0.0679 > 50?(50):height*0.0679));
    tabBarRemindersView.frame = CGRectMake(spacing, premiumSettingsView.frame.origin.y + premiumSettingsView.frame.size.height + spacing, width - (spacing*2), (height*0.0679 > 50?(50):height*0.0679));
    
    accountInfoView.frame = CGRectMake(spacing, tabBarRemindersView.frame.origin.y + tabBarRemindersView.frame.size.height + spacing, width - (spacing*2), (height*0.0679 > 50?(50):height*0.0679));
    changeEmailView.frame = CGRectMake(spacing, accountInfoView.frame.origin.y + accountInfoView.frame.size.height, width - (spacing*2), (height*0.0679 > 50?(50):height*0.0679));
    changePasswordView.frame = CGRectMake(spacing, changeEmailView.frame.origin.y + changeEmailView.frame.size.height, width - (spacing*2), (height*0.0679 > 50?(50):height*0.0679));
    forgotPasswordView.frame = CGRectMake(spacing, changePasswordView.frame.origin.y + changePasswordView.frame.size.height, width - (spacing*2), (height*0.0679 > 50?(50):height*0.0679));
    notificationSettingsView.frame = CGRectMake(spacing, forgotPasswordView.frame.origin.y + forgotPasswordView.frame.size.height, width - (spacing*2), (height*0.0679 > 50?(50):height*0.0679));
    darkModeView.frame = CGRectMake(spacing, notificationSettingsView.frame.origin.y + notificationSettingsView.frame.size.height, width - (spacing*2), (height*0.0679 > 50?(50):height*0.0679));
    billingView.frame = CGRectMake(spacing, darkModeView.frame.origin.y + darkModeView.frame.size.height, width - (spacing*2), (height*0.0679 > 50?(50):height*0.0679));
    legalDocumentsView.frame = CGRectMake(spacing, billingView.frame.origin.y + billingView.frame.size.height, width - (spacing*2), (height*0.0679 > 50?(50):height*0.0679));
    
    requestFeatureView.frame = CGRectMake(spacing, legalDocumentsView.frame.origin.y + legalDocumentsView.frame.size.height + spacing, width - (spacing*2), (height*0.0679 > 50?(50):height*0.0679));
    reportBugView.frame = CGRectMake(spacing, requestFeatureView.frame.origin.y + requestFeatureView.frame.size.height, width - (spacing*2), (height*0.0679 > 50?(50):height*0.0679));
    liveSupportView.frame = CGRectMake(spacing, reportBugView.frame.origin.y + reportBugView.frame.size.height, width - (spacing*2), (height*0.0679 > 50?(50):height*0.0679));
    contactUsView.frame = CGRectMake(spacing, liveSupportView.frame.origin.y + liveSupportView.frame.size.height, width - (spacing*2), (height*0.0679 > 50?(50):height*0.0679));
    
    tellAFriendView.frame = CGRectMake(spacing, contactUsView.frame.origin.y + contactUsView.frame.size.height + spacing, width - (spacing*2), (height*0.0679 > 50?(50):height*0.0679));
    rateUsOnAppStoreView.frame = CGRectMake(spacing, tellAFriendView.frame.origin.y + tellAFriendView.frame.size.height, width - (spacing*2), (height*0.0679 > 50?(50):height*0.0679));
    socialMediaLinksView.frame = CGRectMake(spacing, rateUsOnAppStoreView.frame.origin.y + rateUsOnAppStoreView.frame.size.height, width - (spacing*2), (height*0.0679 > 50?(50):height*0.0679));
    playStoreView.frame = CGRectMake(spacing, socialMediaLinksView.frame.origin.y + socialMediaLinksView.frame.size.height, width - (spacing*2), (height*0.0679 > 50?(50):height*0.0679));
    receiveEmailsView.frame = CGRectMake(spacing, playStoreView.frame.origin.y + playStoreView.frame.size.height, width - (spacing*2), (height*0.0679 > 50?(50):height*0.0679));
    
    signOutView.frame = CGRectMake(spacing, receiveEmailsView.frame.origin.y + receiveEmailsView.frame.size.height + spacing, width - (spacing*2), (height*0.0679 > 50?(50):height*0.0679));
    deleteAccountView.frame = CGRectMake(spacing, signOutView.frame.origin.y + signOutView.frame.size.height, width - (spacing*2), (height*0.0679 > 50?(50):height*0.0679));
    
    _customScrollView.contentSize = CGSizeMake(self.view.frame.size.width, deleteAccountView.frame.origin.y + deleteAccountView.frame.size.height + spacing);
    
    CGFloat cornerRadius = (self.view.frame.size.height*0.2181818182 > 12?12:(self.view.frame.size.height*0.2181818182));
    
    [[[GeneralObject alloc] init] RoundingCorners:premiumSettingsView topCorners:YES bottomCorners:YES cornerRadius:cornerRadius];
    
    [[[GeneralObject alloc] init] RoundingCorners:donateView topCorners:YES bottomCorners:YES cornerRadius:cornerRadius];
    
    //Post-Spike
//    [[[GeneralObject alloc] init] RoundingCorners:importFromRemindersView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
    [[[GeneralObject alloc] init] RoundingCorners:tabBarRemindersView topCorners:YES bottomCorners:YES cornerRadius:cornerRadius];
    
    [[[GeneralObject alloc] init] RoundingCorners:accountInfoView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
    [[[GeneralObject alloc] init] RoundingCorners:legalDocumentsView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
    
    [[[GeneralObject alloc] init] RoundingCorners:requestFeatureView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
    [[[GeneralObject alloc] init] RoundingCorners:contactUsView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
    
    [[[GeneralObject alloc] init] RoundingCorners:tellAFriendView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
    [[[GeneralObject alloc] init] RoundingCorners:receiveEmailsView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
    
    [[[GeneralObject alloc] init] RoundingCorners:signOutView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
    [[[GeneralObject alloc] init] RoundingCorners:deleteAccountView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
    
    
    
    
    [self SetUpView:@[
        @{@"View" : premiumSettingsView, @"Button" : premiumSettingsButton, @"ImageView" : premiumSettingsImage, @"Title" : [[[BoolDataObject alloc] init] PremiumSubscriptionIsOn] ? @"WeDivvy Premium Settings" : @"WeDivvy Premium", @"Image" : @"MainCellIcons.PremiumStar"},
        
        @{@"View" : donateView, @"Button" : donateButton, @"ImageView" : donateImage, @"Title" : @"Donate", @"Image" : @"MainCellIcons.PremiumStar"},
        //Post-Spike
//        @{@"View" : importFromRemindersView, @"Button" : importFromRemindersButton, @"ImageView" : importFromRemindersImage, @"Title" : @"Import Reminders", @"Image" : @"SettingsIcons.ImportReminders"},
        @{@"View" : tabBarRemindersView, @"Button" : tabBarRemindersButton, @"ImageView" : tabBarRemindersImage, @"Title" : @"Home Features", @"Image" : @"SettingsIcons.TabBar"},
        
        @{@"View" : accountInfoView, @"Button" : accountInfoButton, @"ImageView" : accountInfoImage, @"Title" : @"Account Info", @"Image" : @"SettingsIcons.AccountInfo"},
        @{@"View" : changeEmailView, @"Button" : changeEmailButton, @"ImageView" : changeEmailImage, @"Title" : @"Change Email", @"Image" : @"SettingsIcons.ChangeEmail"},
        @{@"View" : changePasswordView, @"Button" : changePasswordButton, @"ImageView" : changePasswordImage, @"Title" : @"Change Password", @"Image" : @"SettingsIcons.ChangePassword"},
        @{@"View" : forgotPasswordView, @"Button" : forgotPasswordButton, @"ImageView" : forgotPasswordImage, @"Title" : @"Forgot Password", @"Image" : @"SettingsIcons.ForgotPassword"},
        @{@"View" : notificationSettingsView, @"Button" : notificationSettingsButton, @"ImageView" : notificationSettingsImage, @"Title" : @"Notifications", @"Image" : @"SettingsIcons.NotificationSettings"},
        @{@"View" : darkModeView, @"Button" : darkModeButton, @"ImageView" : darkModeImage, @"Title" : @"Dark Mode", @"Image" : @"SettingsIcons.DarkMode"},
        @{@"View" : billingView, @"Button" : billingButton, @"ImageView" : billingImage, @"Title" : @"Billing", @"Image" : @"SettingsIcons.Billing"},
        @{@"View" : legalDocumentsView, @"Button" : legalDocumentsButton, @"ImageView" : legalDocumentsImage, @"Title" : @"Legal Documents", @"Image" : @"SettingsIcons.LegalDocuments"},
        
        @{@"View" : requestFeatureView, @"Button" : requestFeatureButton, @"ImageView" : requestFeatureImage, @"Title" : @"Request Feature", @"Image" : @"SettingsIcons.RequestFeature"},
        @{@"View" : reportBugView, @"Button" : reportBugButton, @"ImageView" : reportBugImage, @"Title" : @"Report Bug", @"Image" : @"SettingsIcons.ReportBug"},
        @{@"View" : liveSupportView, @"Button" : liveSupportButton, @"ImageView" : liveSupportImage, @"Title" : @"Live Support", @"Image" : @"SettingsIcons.LiveSupport"},
        @{@"View" : contactUsView, @"Button" : contactUsButton, @"ImageView" : contactUsImage, @"Title" : @"Contact Us", @"Image" : @"SettingsIcons.ContactUs"},
        
        @{@"View" : tellAFriendView, @"Button" : tellAFriendButton, @"ImageView" : tellAFriendImage, @"Title" : @"Tell A Friend", @"Image" : @"SettingsIcons.TellAFriend"},
        @{@"View" : rateUsOnAppStoreView, @"Button" : rateUsOnAppStoreButton, @"ImageView" : rateUsOnAppStoreImage, @"Title" : @"Rate Us On The App Store", @"Image" : @"SettingsIcons.RateUs"},
        @{@"View" : socialMediaLinksView, @"Button" : socialMediaLinksButton, @"ImageView" : socialMediaLinksImage, @"Title" : @"Social Media Links", @"Image" : @"SettingsIcons.SocialMediaLinks"},
        @{@"View" : playStoreView, @"Button" : playStoreButton, @"ImageView" : playStoreImage, @"Title" : @"Join the Google Play Store Waitlist", @"Image" : @"SettingsIcons.PlayStore"},
        @{@"View" : receiveEmailsView, @"Button" : receiveEmailsButton, @"ImageView" : receiveEmailsImage, @"Title" : @"Receive Emails About WeDivvy", @"Image" : @"SettingsIcons.ReceiveEmails"},
        
        @{@"View" : signOutView, @"Button" : signOutButton, @"ImageView" : signOutImage, @"Title" : @"Log Out", @"Image" : @"SettingsIcons.LogOut"},
        @{@"View" : deleteAccountView, @"Button" : deleteAccountButton, @"ImageView" : deleteAccountImage, @"Title" : @"Delete Account", @"Image" : @"SettingsIcons.DeleteAccount"},
    ]];
    
    
    
    
    CGRect newRect = premiumSettingsButton.frame;
    newRect.size.height = premiumSettingsView.frame.size.height*0.3273737;
    newRect.origin.y = premiumSettingsView.frame.size.height*0.5 - premiumSettingsView.frame.size.height*0.3273737;
    premiumSettingsButton.frame = newRect;
    
    newRect = premiumSettingsImage.frame;
    newRect.size.height = premiumSettingsView.frame.size.height*0.5;
    newRect.size.width = premiumSettingsView.frame.size.height*0.5;
    newRect.origin.y = premiumSettingsView.frame.size.height*0.5 - newRect.size.height*0.5;
    premiumSettingsImage.frame = newRect;
    
    premiumSettingsSubLabel.frame = CGRectMake(premiumSettingsButton.frame.origin.x, premiumSettingsView.frame.size.height*0.5, premiumSettingsButton.frame.size.width, premiumSettingsView.frame.size.height*0.4);
    premiumSettingsSubLabel.text = [[[BoolDataObject alloc] init] PremiumSubscriptionIsOn] ? @"Access your WeDivvy Premium settings ⭐️⚙️" : @"Unlock exclusive features for your home ⭐️🔓";
    premiumSettingsSubLabel.textAlignment = NSTextAlignmentLeft;
    premiumSettingsSubLabel.font = [UIFont systemFontOfSize:premiumSettingsView.frame.size.height*0.21818 weight:UIFontWeightSemibold];
    premiumSettingsSubLabel.textColor = [UIColor lightGrayColor];
    
    
    
    
    newRect = donateButton.frame;
    newRect.size.height = donateView.frame.size.height*0.3273737;
    newRect.origin.y = donateView.frame.size.height*0.5 - donateView.frame.size.height*0.3273737;
    donateButton.frame = newRect;
    
    newRect = donateImage.frame;
    newRect.size.height = donateView.frame.size.height*0.5;
    newRect.size.width = donateView.frame.size.height*0.5;
    newRect.origin.y = donateView.frame.size.height*0.5 - newRect.size.height*0.5;
    donateImage.frame = newRect;
    
    donateSubLabel.frame = CGRectMake(donateButton.frame.origin.x, donateView.frame.size.height*0.5, donateButton.frame.size.width, donateView.frame.size.height*0.4);
    donateSubLabel.text = [[[BoolDataObject alloc] init] PremiumSubscriptionIsOn] ? @"Access your WeDivvy Premium settings ⭐️⚙️" : @"Unlock exclusive features for your home ⭐️🔓";
    donateSubLabel.textAlignment = NSTextAlignmentLeft;
    donateSubLabel.font = [UIFont systemFontOfSize:donateView.frame.size.height*0.21818 weight:UIFontWeightSemibold];
    donateSubLabel.textColor = [UIColor lightGrayColor];
    
    
    
    
    CGFloat rightArrowX = (self.view.frame.size.width*0.02898551 > 12?(12):self.view.frame.size.width*0.02898551);
    
    [darkModeSwitch setOn:
     [[NSUserDefaults standardUserDefaults] objectForKey:@"DarkModeSelected"] && [[[NSUserDefaults standardUserDefaults] objectForKey:@"DarkModeSelected"] isEqualToString:@"Yes"] ?
                     YES : NO];
    
    darkModeSwitch.onTintColor = [[[GeneralObject alloc] init] GenerateAppColor:1.0f];
    receiveEmailsSwitch.onTintColor = [[[GeneralObject alloc] init] GenerateAppColor:1.0f];
    
    CGFloat switchTransform = darkModeView.frame.size.height*0.5/31;
    
    darkModeSwitch.transform = CGAffineTransformMakeScale(switchTransform, switchTransform);
    darkModeSwitch.frame = CGRectMake(darkModeView.frame.size.width - receiveEmailsSwitch.frame.size.width - rightArrowX, darkModeView.frame.size.height*0.5 - darkModeSwitch.frame.size.height*0.5, darkModeSwitch.frame.size.width, darkModeSwitch.frame.size.height);
    
    receiveEmailsSwitch.transform = CGAffineTransformMakeScale(switchTransform, switchTransform);
    receiveEmailsSwitch.frame = CGRectMake(receiveEmailsView.frame.size.width - receiveEmailsSwitch.frame.size.width - rightArrowX, receiveEmailsView.frame.size.height*0.5 - receiveEmailsSwitch.frame.size.height*0.5, receiveEmailsSwitch.frame.size.width, receiveEmailsSwitch.frame.size.height);
    
    
    
    
    
    
    
    [premiumSettingsButton addTarget:self action:@selector(PremiumSettingsAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(PremiumSettingsAction:)];
    [premiumSettingsOverlayView addGestureRecognizer:tapGesture];
    premiumSettingsOverlayView.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(PremiumSettingsAction:)];
    [donateOverlayView addGestureRecognizer:tapGesture];
    donateOverlayView.userInteractionEnabled = YES;
    
    [importFromRemindersButton addTarget:self action:@selector(ImportRemindersAction:) forControlEvents:UIControlEventTouchUpInside];
    [tabBarRemindersButton addTarget:self action:@selector(TabBarAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [accountInfoButton addTarget:self action:@selector(UpdateUsernameAction:) forControlEvents:UIControlEventTouchUpInside];
    [changeEmailButton addTarget:self action:@selector(UpdateEmailAction:) forControlEvents:UIControlEventTouchUpInside];
    [changePasswordButton addTarget:self action:@selector(UpdatePasswordAction:) forControlEvents:UIControlEventTouchUpInside];
    [forgotPasswordButton addTarget:self action:@selector(ForgotPasswordAction:) forControlEvents:UIControlEventTouchUpInside];
    [notificationSettingsButton addTarget:self action:@selector(NotificationsAction:) forControlEvents:UIControlEventTouchUpInside];
    [darkModeSwitch addTarget:self action:@selector(DarkModeAction:) forControlEvents:UIControlEventTouchUpInside];
    [billingButton addTarget:self action:@selector(BillingAction:) forControlEvents:UIControlEventTouchUpInside];
    [legalDocumentsButton addTarget:self action:@selector(TOSAndPPAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [requestFeatureButton addTarget:self action:@selector(RequestFeatureAction:) forControlEvents:UIControlEventTouchUpInside];
    [reportBugButton addTarget:self action:@selector(RequestBugAction:) forControlEvents:UIControlEventTouchUpInside];
    [liveSupportButton addTarget:self action:@selector(LiveSupportAction:) forControlEvents:UIControlEventTouchUpInside];
    [contactUsButton addTarget:self action:@selector(ContactUsButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [tellAFriendButton addTarget:self action:@selector(TellAFriend:) forControlEvents:UIControlEventTouchUpInside];
    [rateUsOnAppStoreButton addTarget:self action:@selector(AppStoreRating:) forControlEvents:UIControlEventTouchUpInside];
    [socialMediaLinksButton addTarget:self action:@selector(SocialMediaLinksAction:) forControlEvents:UIControlEventTouchUpInside];
    [playStoreButton addTarget:self action:@selector(PlayStoreAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [signOutButton addTarget:self action:@selector(LogoutAction:) forControlEvents:UIControlEventTouchUpInside];
    [deleteAccountButton addTarget:self action:@selector(DeleteAccountAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    [self.customScrollView addSubview:premiumSettingsView];
    [premiumSettingsView addSubview:premiumSettingsButton];
    [premiumSettingsView addSubview:premiumSettingsImage];
    [premiumSettingsView addSubview:premiumSettingsSubLabel];
    [premiumSettingsView addSubview:premiumSettingsOverlayView];
    
    //    [self.customScrollView addSubview:donateView];
    //    [donateView addSubview:donateButton];
    //    [donateView addSubview:donateImage];
    //    [donateView addSubview:donateSubLabel];
    //    [donateView addSubview:donateOverlayView];
    
    //Post-Spike
//    [self.customScrollView addSubview:importFromRemindersView];
//    [importFromRemindersView addSubview:importFromRemindersButton];
//    [importFromRemindersView addSubview:importFromRemindersImage];
    
    [self.customScrollView addSubview:tabBarRemindersView];
    [tabBarRemindersView addSubview:tabBarRemindersButton];
    [tabBarRemindersView addSubview:tabBarRemindersImage];
    
    [self.customScrollView addSubview:accountInfoView];
    [accountInfoView addSubview:accountInfoButton];
    [accountInfoView addSubview:accountInfoImage];
    
    [self.customScrollView addSubview:changeEmailView];
    [changeEmailView addSubview:changeEmailButton];
    [changeEmailView addSubview:changeEmailImage];
    
    [self.customScrollView addSubview:changePasswordView];
    [changePasswordView addSubview:changePasswordButton];
    [changePasswordView addSubview:changePasswordImage];
    
    [self.customScrollView addSubview:forgotPasswordView];
    [forgotPasswordView addSubview:forgotPasswordButton];
    [forgotPasswordView addSubview:forgotPasswordImage];
    
    [self.customScrollView addSubview:notificationSettingsView];
    [notificationSettingsView addSubview:notificationSettingsButton];
    [notificationSettingsView addSubview:notificationSettingsImage];
    
    [self.customScrollView addSubview:darkModeView];
    [darkModeView addSubview:darkModeButton];
    [darkModeView addSubview:darkModeImage];
    [darkModeView addSubview:darkModeSwitch];
    
    [self.customScrollView addSubview:billingView];
    [billingView addSubview:billingButton];
    [billingView addSubview:billingImage];
    
    [self.customScrollView addSubview:legalDocumentsView];
    [legalDocumentsView addSubview:legalDocumentsButton];
    [legalDocumentsView addSubview:legalDocumentsImage];
    
    
    
    
    [self.customScrollView addSubview:requestFeatureView];
    [requestFeatureView addSubview:requestFeatureButton];
    [requestFeatureView addSubview:requestFeatureImage];
    
    [self.customScrollView addSubview:reportBugView];
    [reportBugView addSubview:reportBugButton];
    [reportBugView addSubview:reportBugImage];
    
    [self.customScrollView addSubview:liveSupportView];
    [liveSupportView addSubview:liveSupportButton];
    [liveSupportView addSubview:liveSupportImage];
    
    [self.customScrollView addSubview:contactUsView];
    [contactUsView addSubview:contactUsButton];
    [contactUsView addSubview:contactUsImage];
    
    
    
    
    [self.customScrollView addSubview:tellAFriendView];
    [tellAFriendView addSubview:tellAFriendButton];
    [tellAFriendView addSubview:tellAFriendImage];
    
    [self.customScrollView addSubview:rateUsOnAppStoreView];
    [rateUsOnAppStoreView addSubview:rateUsOnAppStoreButton];
    [rateUsOnAppStoreView addSubview:rateUsOnAppStoreImage];
    
    [self.customScrollView addSubview:socialMediaLinksView];
    [socialMediaLinksView addSubview:socialMediaLinksButton];
    [socialMediaLinksView addSubview:socialMediaLinksImage];
    
    [self.customScrollView addSubview:playStoreView];
    [playStoreView addSubview:playStoreButton];
    [playStoreView addSubview:playStoreImage];
    
    [self.customScrollView addSubview:receiveEmailsView];
    [receiveEmailsView addSubview:receiveEmailsButton];
    [receiveEmailsView addSubview:receiveEmailsImage];
    [receiveEmailsView addSubview:receiveEmailsSwitch];
    
    
    
    
    [self.customScrollView addSubview:signOutView];
    [signOutView addSubview:signOutButton];
    [signOutView addSubview:signOutImage];
    
    [self.customScrollView addSubview:deleteAccountView];
    [deleteAccountView addSubview:deleteAccountButton];
    [deleteAccountView addSubview:deleteAccountImage];
    
    
    
    
    [self AddRightArrowImageView:@[
        
        @{@"View" : premiumSettingsView},
        
        @{@"View" : donateView},
        
        @{@"View" : importFromRemindersView},
        @{@"View" : tabBarRemindersView},
        
        @{@"View" : accountInfoView},
        @{@"View" : changeEmailView},
        @{@"View" : changePasswordView},
        @{@"View" : forgotPasswordView},
        @{@"View" : notificationSettingsView},
        //@{@"View" : darkModeView},
        @{@"View" : billingView},
        @{@"View" : legalDocumentsView},
        
        @{@"View" : requestFeatureView},
        @{@"View" : reportBugView},
        @{@"View" : liveSupportView},
        @{@"View" : contactUsView},
        
        @{@"View" : tellAFriendView},
        @{@"View" : rateUsOnAppStoreView},
        @{@"View" : socialMediaLinksView},
        @{@"View" : playStoreView},
        //@{@"View" : receiveEmailsView},
        
        @{@"View" : signOutView},
        @{@"View" : deleteAccountView},
    ]];
    
    
    
    
    [self AddLineViews];
    
    BOOL PremiumUserHasAccountsToGiveAndNotAllUsersHavePremium = [[[BoolDataObject alloc] init] PremiumUserHasAccountsToGiveAndNotAllUsersHavePremium:homeMembersDict purchasingUserID:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
    
    UIView *unusedPremiumAccountsView = [[UIView alloc] init];
    unusedPremiumAccountsView.frame = CGRectMake(premiumSettingsView.frame.origin.x - (((self.view.frame.size.height*0.0149925 > 10?(10):self.view.frame.size.height*0.0149925))*0.25), premiumSettingsView.frame.origin.y - (((self.view.frame.size.height*0.0149925 > 10?(10):self.view.frame.size.height*0.0149925))*0.25), (self.view.frame.size.height*0.0149925 > 10?(10):self.view.frame.size.height*0.0149925), (self.view.frame.size.height*0.0149925 > 10?(10):self.view.frame.size.height*0.0149925));
    unusedPremiumAccountsView.layer.cornerRadius = unusedPremiumAccountsView.frame.size.height/2;
    unusedPremiumAccountsView.backgroundColor = [UIColor systemPinkColor];
    unusedPremiumAccountsView.hidden = PremiumUserHasAccountsToGiveAndNotAllUsersHavePremium ? NO : YES;
    [self.customScrollView addSubview:unusedPremiumAccountsView];
    
}

-(void)SetUpView:(NSArray *)arrayToUse {
    
    for (NSDictionary *dict in arrayToUse) {
        
        UIView *viewToUse = dict[@"View"];
        UIButton *buttonToUse = dict[@"Button"];
        UIImageView *imageViewToUse = dict[@"ImageView"];
        NSString *title = dict[@"Title"];
        NSString *image = dict[@"Image"];
        
        CGFloat imageWidth = viewToUse.frame.size.height*0.6;
        
        CGFloat heightToUse = (self.view.frame.size.height*0.0679 > 50?(50):self.view.frame.size.height*0.0679);
        
        imageViewToUse.frame = CGRectMake((self.view.frame.size.width*0.02898551 > 12?(12):self.view.frame.size.width*0.02898551), viewToUse.frame.size.height*0.5 - imageWidth*0.5, imageWidth, imageWidth);
        buttonToUse.frame = CGRectMake(imageViewToUse.frame.origin.x + imageViewToUse.frame.size.width + (self.view.frame.size.width*0.018604 > 8?(8):self.view.frame.size.width*0.018604), 0, viewToUse.frame.size.width - (imageViewToUse.frame.origin.x + imageViewToUse.frame.size.width + (self.view.frame.size.width*0.02898551 > 12?(12):self.view.frame.size.width*0.02898551)), heightToUse);
        imageViewToUse.image = [UIImage imageNamed:image];
        
        viewToUse.backgroundColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTertiary] : [[[LightDarkModeObject alloc] init] LightModeSecondary];
        buttonToUse.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        buttonToUse.backgroundColor = [UIColor clearColor];
        [buttonToUse setTitle:title forState:UIControlStateNormal];
        [buttonToUse setTitleColor:[[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTextPrimary] : [[[LightDarkModeObject alloc] init] LightModeTextPrimary] forState:UIControlStateNormal];
        [buttonToUse.titleLabel setFont:[UIFont systemFontOfSize:buttonToUse.frame.size.height*0.32 weight:UIFontWeightRegular]];
        
    }
    
}

-(void)AddRightArrowImageView:(NSArray *)arrayToUse {
    
    for (NSDictionary *dict in arrayToUse) {
        
        UIView *viewToUse = dict[@"View"];
        
        UIImageView *rightArrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(viewToUse.frame.size.width - (self.view.frame.size.width*0.0205314 > 8.5?(8.5):self.view.frame.size.width*0.0205314) - (self.view.frame.size.width*0.02898551 > 12?(12):self.view.frame.size.width*0.02898551), 0, (self.view.frame.size.width*0.0205314 > 8.5?(8.5):self.view.frame.size.width*0.0205314), viewToUse.frame.size.height)];
        rightArrowImageView.image = [UIImage imageNamed:@"AddItemIcon.TextFieldRightArrow"];
        rightArrowImageView.contentMode = UIViewContentModeScaleAspectFit;
        [viewToUse addSubview:rightArrowImageView];
        
    }
    
}

-(void)AddLineViewsPremium {
    
    NSArray *arrView = @[
        
        premiumAccountsView, changePlanOrPurchaseSubscriptionView,
        
        appIconView, appThemeView, autoDarkModeView, launchPageView, shortcutItemsView,
        
        premiumFAQView,
        
        submitPremiumFeedbackView];
    
    for (UIView *viewNo1 in arrView) {
        
        for (UIView *subViewNo1 in [viewNo1 subviews]) {
            
            if (subViewNo1.tag == 1111) {
                
                [subViewNo1 removeFromSuperview];
                
            }
            
        }
        
    }
    
    for (UIView *viewNo1 in arrView) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(viewNo1.frame.size.width*0.04830918, viewNo1.frame.size.height-1, viewNo1.frame.size.width - (viewNo1.frame.size.width*0.04830918), 1)];
        view.backgroundColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTextSecondary] : [UIColor colorWithRed:231.0f/255.0f green:231.0f/255.0f blue:232.0f/255.0f alpha:1.0f];
        view.tag = 1111;
        [viewNo1 addSubview:view];
        
    }
    
}

-(void)AddLineViews {
    
    NSArray *arrView = @[
        
        premiumSettingsView,
        
        donateView,
        
        importFromRemindersView, tabBarRemindersView,
        
        accountInfoView, changeEmailView, changePasswordView, forgotPasswordView, notificationSettingsView, darkModeView, billingView, legalDocumentsView,
        
        requestFeatureView, reportBugView, liveSupportView, contactUsView,
        
        tellAFriendView, rateUsOnAppStoreView, socialMediaLinksView, playStoreView, receiveEmailsView,
        
        signOutView, deleteAccountView];
    
    for (UIView *viewNo1 in arrView) {
        
        for (UIView *subViewNo1 in [viewNo1 subviews]) {
            
            if (subViewNo1.tag == 1111) {
                
                [subViewNo1 removeFromSuperview];
                
            }
            
        }
        
    }
    
    for (UIView *viewNo1 in arrView) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(viewNo1.frame.size.width*0.04830918, viewNo1.frame.size.height-1, viewNo1.frame.size.width - (viewNo1.frame.size.width*0.04830918), 1)];
        view.backgroundColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTextSecondary] : [UIColor colorWithRed:231.0f/255.0f green:231.0f/255.0f blue:232.0f/255.0f alpha:1.0f];
        view.tag = 1111;
        [viewNo1 addSubview:view];
        
    }
    
}

#pragma mark - IBAction Methods

-(IBAction)NavigationBackButtonAction:(UIBarButtonItem *)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Navigation Back Button Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark

-(IBAction)PremiumSettingsAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"WeDivvy Premium Settings"] completionHandler:^(BOOL finished) {
        
    }];
    
    if ([[[BoolDataObject alloc] init] PremiumSubscriptionIsOn] == YES) {
        
        [[[PushObject alloc] init] PushToSettingsViewController:YES allItemAssignedToArrays:self->_allItemAssignedToArrays currentViewController:self];
        
    } else {
        
        [[[PushObject alloc] init] PushToWeDivvyPremiumViewController:NO comingFromSignUp:NO defaultPlan:@"" displayDiscount:@"Half-Off Yearly Discount No Sale Sticker" selectedSlide:@"" promoCodeID:@"" premiumPlanProductsArray:premiumPlanProductsArray premiumPlanPricesDict:premiumPlanPricesDict premiumPlanExpensivePricesDict:premiumPlanExpensivePricesDict premiumPlanPricesDiscountDict:premiumPlanPricesDiscountDict premiumPlanPricesNoFreeTrialDict:premiumPlanPricesNoFreeTrialDict currentViewController:self Superficial:NO];
        
    }
    
}

#pragma mark

-(IBAction)ImportRemindersAction:(id)sender {
    
    if ([[[GeneralObject alloc] init] ConnectedToInternet] == NO) {
        [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You need to be connected to the internet to do that." currentViewController:self];
        return;
    }
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Import Reminders"] completionHandler:^(BOOL finished) {
        
    }];
    
    [self GenerateReminderAccess:^(BOOL AccessGranted) {
        
        if (AccessGranted) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
                
                [actionSheet addAction:[UIAlertAction actionWithTitle:@"Import local reminders" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    
                    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Import my reminders"] completionHandler:^(BOOL finished) {
                        
                    }];
                    
                    [self GenerateLocalReminders:^(NSArray *localRemindersArray) {
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            [self StartProgressView];
                            
                        });
                        
                        NSMutableArray *objectArr = [NSMutableArray array];
                        
                        for (EKReminder *reminder in localRemindersArray) {
                            
                            NSString *itemDueDateConverted = @"No Due Date";
                            
                            if (reminder.dueDateComponents.date != NULL) {
                                
                                NSDate *itemDueDateOriginal = reminder.dueDateComponents.date;
                                
                                itemDueDateConverted = [[[GeneralObject alloc] init] GenerateDateWithConvertedFormatWithFormat:@"yyyy-MM-dd HH:mm:ss Z" dateToConvert:itemDueDateOriginal newFormat:@"yyyy-MM-dd HH:mm:ss" returnAs:[NSString class]];
                            
                            }
                            
                            NSString *itemCompletedDateConverted = @"";
                            
                            if (reminder.completionDate !=  NULL) {
                                
                                NSDate *itemCompletedDateOriginal = reminder.completionDate;
                             
                                itemDueDateConverted = [[[GeneralObject alloc] init] GenerateDateWithConvertedFormatWithFormat:@"yyyy-MM-dd HH:mm:ss Z" dateToConvert:itemCompletedDateOriginal newFormat:@"yyyy-MM-dd HH:mm:ss" returnAs:[NSString class]];
                                
                            }
                            
                            NSString *itemName = reminder.title;
                            NSString *itemPriority = reminder.priority == 1 ? @"High" : @"No Priority";
                            NSDictionary *itemReminderDict = @{};
                            
                            NSDictionary *itemCompletedDict =
                            [itemCompletedDateConverted length] == 0 ?
                            @{} :
                            @{@"DateMarked" : itemCompletedDateConverted,
                              @"MarkedBy" : [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"],
                              @"MarkedFor" : [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]};
                            
                            
                            
                            
                            
                            NSDictionary *setDataDict = [self GenerateSetDataDict:itemName itemDueDateLocal:itemDueDateConverted itemCompletedLocal:itemCompletedDict itemPriorityLocal:itemPriority itemReminderLocal:itemReminderDict];
                            
                            
                            
                            
                            
                            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"itemUniqueID == %@", setDataDict[@"ItemUniqueID"]];
                            [[[SetDataObject alloc] init] SetDataAddCoreData:@"Chores" predicate:predicate setDataObject:setDataDict];
                            
                            
                            
                            
                            
                            NSString *activityAction = @"Adding Task";
                            NSString *userTitle = [NSString stringWithFormat:@"%@ created a %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"], [@"Chore" lowercaseString]];
                            NSString *itemTitle = [NSString stringWithFormat:@"%@ created this %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"], [@"Chore" lowercaseString]];
                            NSString *itemDescription = [NSString stringWithFormat:@"\"%@\" was created", setDataDict[@"ItemName"]];
                            
                            NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
                            
                            NSMutableDictionary *itemActivityDict = [[[SetDataObject alloc] init] GenerateItemActivityDict:setDataDict[@"ItemID"] itemOccurrenceID:setDataDict[@"ItemOccurrenceID"] activityUserIDNo1:@"" homeID:homeID activityAction:activityAction userTitle:userTitle userDescription:itemDescription itemType:@"Chore"];
                            NSMutableDictionary *homeActivityDict = [[[SetDataObject alloc] init] GenerateHomeActivityDict:@"" homeID:homeID activityAction:activityAction itemTitle:itemTitle itemDescription:itemDescription itemType:@"Chore"];
                            
                            predicate = [NSPredicate predicateWithFormat:@"activityID == %@", itemActivityDict[@"ActivityID"]];
                            [[[SetDataObject alloc] init] SetDataAddCoreData:@"Activity" predicate:predicate setDataObject:itemActivityDict];
                            
                            predicate = [NSPredicate predicateWithFormat:@"activityID == %@", homeActivityDict[@"ActivityID"]];
                            [[[SetDataObject alloc] init] SetDataAddCoreData:@"Activity" predicate:predicate setDataObject:homeActivityDict];
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                
                                [self AddItem:setDataDict itemActivityDict:itemActivityDict homeActivityDict:homeActivityDict completionHandler:^(BOOL finished) {
                                    
                                    if ([[[GeneralObject alloc] init] AddToObjectArrAndCheckIfQueryHasEnded:[localRemindersArray mutableCopy] objectArr:objectArr]) {
                                        
                                        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ReloadPage" userInfo:nil locations:@[@"Tasks"]];
                                        
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                            
                                            [self->progressView setHidden:YES];
                                            
                                        });
                                        
                                    }
                                    
                                }];
                                
                            });
                            
                        }
                        
                    }];
                    
                }]];
                
                [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                    
                    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Cancel"] completionHandler:^(BOOL finished) {
                        
                    }];
                    
                }]];
                
                [self presentViewController:actionSheet animated:YES completion:nil];
                
            });
            
        } else {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"You'll need to grant access to your reminders first." message:nil
                                                                             preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Got it"
                                                                  style:UIAlertActionStyleDefault
                                                                handler:^(UIAlertAction * _Nonnull action) {
                    
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
                    
                    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Grant Reminder Access"] completionHandler:^(BOOL finished) {
                        
                    }];
                    
                }];
                
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                                 style:UIAlertActionStyleCancel
                                                               handler:^(UIAlertAction * _Nonnull action) {
                    
                    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Cancel"] completionHandler:^(BOOL finished) {
                        
                    }];
                    
                }];
                
                [controller addAction:action1];
                [controller addAction:cancel];
                [self presentViewController:controller animated:YES completion:nil];
                
            });
            
        }
        
    }];
    
}

-(IBAction)TabBarAction:(id)sender {
    
    if ([[[GeneralObject alloc] init] ConnectedToInternet] == NO) {
        [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You need to be connected to the internet to do that." currentViewController:self];
        return;
    }
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Tab Bar"] completionHandler:^(BOOL finished) {
        
    }];
    
//    NSMutableArray *itemsSelectedArray = [NSMutableArray array];
    
//    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"VisibleTabBarOptions"]) {
//        itemsSelectedArray = [[[NSUserDefaults standardUserDefaults] objectForKey:@"VisibleTabBarOptions"] mutableCopy];
//    } else {
//        itemsSelectedArray = [@[@"Chores", @"Expenses", @"Lists", @"Chats"] mutableCopy];
//    }
//
//    [[[PushObject alloc] init] PushToViewOptionsViewController:itemsSelectedArray customOptionsArray:nil specificDatesArray:nil viewingItemDetails:NO optionSelectedString:@"TabBar" itemRepeatsFrequency:nil homeMembersDict:nil currentViewController:self];
    
    [[[PushObject alloc] init] PushToHomeFeaturesViewController:self comingFromSettings:YES];
    
}

#pragma mark

-(IBAction)UpdateUsernameAction:(id)sender {
    
    if ([[[GeneralObject alloc] init] ConnectedToInternet] == NO) {
        [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You need to be connected to the internet to do that." currentViewController:self];
        return;
    }
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Update Username"] completionHandler:^(BOOL finished) {
        
    }];
    
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"];
    NSString *imageURL = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersProfileImage"];
    
    [[[PushObject alloc] init] PushToEditProfileViewController:nil name:username imageURL:imageURL editingHome:NO currentViewController:self];
    
}

-(IBAction)UpdateEmailAction:(id)sender {
    
    if ([[[GeneralObject alloc] init] ConnectedToInternet] == NO) {
        [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You need to be connected to the internet to do that." currentViewController:self];
        return;
    }
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Update Email"] completionHandler:^(BOOL finished) {
        
    }];
    
    [[[PushObject alloc] init] PushToUpdateEmailViewController:self];
    
}

-(IBAction)UpdatePasswordAction:(id)sender {
    
    if ([[[GeneralObject alloc] init] ConnectedToInternet] == NO) {
        [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You need to be connected to the internet to do that." currentViewController:self];
        return;
    }
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Update Password"] completionHandler:^(BOOL finished) {
        
    }];
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Enter your credentials to update your password" message:nil
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Update"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * _Nonnull action) {
        
        [self StartProgressView];
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Update"] completionHandler:^(BOOL finished) {
            
        }];
        
        NSString *lowerCaseEmail = controller.textFields[0].text;
        
        [[FIRAuth auth] signInWithEmail:lowerCaseEmail password:controller.textFields[1].text completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
            
            if (error == nil) {
                
                [self->progressView setHidden:YES];
                [self EnterNewPassword];
                
            } else if ([error.description containsString:@"There is no user record corresponding to this identifier. The user may have been deleted."]) {
                
                [self->progressView setHidden:YES];
                [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"A user with that email doesn't exist" currentViewController:self];
                
            } else if ([error.description containsString:@"The email address is badly formatted"]) {
                
                [self->progressView setHidden:YES];
                [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"That email is incorrectly formatted" currentViewController:self];
                
            } else if ([error.description containsString:@"The password is invalid or the user does not have a password"]) {
                
                [self->progressView setHidden:YES];
                [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"That email/password combination doesn't exist" currentViewController:self];
                
            } else {
                
                [self->progressView setHidden:YES];
                [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"An error has occurred please try again" currentViewController:self];
                
            }
            
        }];
        
    }];
    
    [action1 setValue:[[[GeneralObject alloc] init] GenerateAppColor:1.0f] forKey:@"titleTextColor"];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction * _Nonnull action) {
        
        [self->progressView setHidden:YES];
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Cancel"] completionHandler:^(BOOL finished) {
            
        }];
        
    }];
    
    [cancel setValue:[[[GeneralObject alloc] init] GenerateAppColor:1.0f] forKey:@"titleTextColor"];
    
    [controller addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        
        textField.delegate = self;
        textField.placeholder = @"Email";
        textField.text = @"";
        textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
        
    }];
    
    [controller addTextFieldWithConfigurationHandler:^(UITextField *textField1) {
        
        textField1.delegate = self;
        textField1.placeholder = @"Password";
        textField1.text = @"";
        textField1.autocapitalizationType = UITextAutocapitalizationTypeWords;
        textField1.secureTextEntry = YES;
        
    }];
    
    [controller addAction:action1];
    [controller addAction:cancel];
    [self presentViewController:controller animated:YES completion:nil];
    
}

-(IBAction)ForgotPasswordAction:(id)sender {
    
    if ([[[GeneralObject alloc] init] ConnectedToInternet] == NO) {
        [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You need to be connected to the internet to do that." currentViewController:self];
        return;
    }
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Forgot Password"] completionHandler:^(BOOL finished) {
        
    }];
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Enter your email" message:nil
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Reset"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * _Nonnull action) {
        
        [self StartProgressView];
        
        [[FIRAuth auth] sendPasswordResetWithEmail:[controller.textFields[0].text lowercaseString] completion:^(NSError * _Nullable error) {
            
            if ([[controller.textFields[0].text lowercaseString] isEqualToString:@""]) {
                
                [self->progressView setHidden:YES];
                [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"Email field is empty" currentViewController:self];
                
            } else if (error) {
                
                [self->progressView setHidden:YES];
                [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"That email doesn't exist" currentViewController:self];
                
            } else if (error == nil) {
                
                [self->progressView setHidden:YES];
                [[[GeneralObject alloc] init] CreateAlert:@"Yay!" message:@"Your reset email has been sent" currentViewController:self];
                
            }
            
        }];
        
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction * _Nonnull action) { [self->progressView setHidden:YES]; }];
    
    
    
    [controller addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        
        textField.delegate = self;
        textField.placeholder = @"Email";
        textField.text = @"";
        textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
        
    }];
    
    [controller addAction:action1];
    [controller addAction:cancel];
    [self presentViewController:controller animated:YES completion:nil];
    
}

- (IBAction)NotificationsAction:(id)sender {
    
    if ([[[GeneralObject alloc] init] ConnectedToInternet] == NO) {
        [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You need to be connected to the internet to do that." currentViewController:self];
        return;
    }
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Notification Action"] completionHandler:^(BOOL finished) {
        
    }];
    
    if (([[NSUserDefaults standardUserDefaults] objectForKey:@"NotificationsHaveBeenAccepted"]) &&
        ([[[NSUserDefaults standardUserDefaults] objectForKey:@"NotificationsHaveBeenAccepted"] isEqualToString:@"Yes"])) {
        
        NSMutableDictionary *notificationSettingsDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"NotificationSettingsDict"];
        NSMutableArray *sideBarCategorySectionArrayAltered = [[NSUserDefaults standardUserDefaults] objectForKey:@"SideBarCategorySectionArrayAltered"];
        
        NSMutableArray *userIDArray = [sideBarCategorySectionArrayAltered count] > 1 && sideBarCategorySectionArrayAltered[1][@"IDs"] ? sideBarCategorySectionArrayAltered[1][@"IDs"] : [NSMutableArray array];
        NSMutableArray *userNameArray = [sideBarCategorySectionArrayAltered count] > 1 && sideBarCategorySectionArrayAltered[1][@"Names"] ? sideBarCategorySectionArrayAltered[1][@"Names"] : [NSMutableArray array];
        NSMutableArray *tagNameArray = [sideBarCategorySectionArrayAltered count] > 2 && sideBarCategorySectionArrayAltered[2][@"Names"] ? sideBarCategorySectionArrayAltered[2][@"Names"] : [NSMutableArray array];
        NSMutableArray *allColorsArray = [sideBarCategorySectionArrayAltered count] > 3 && sideBarCategorySectionArrayAltered[3][@"Names"] ? sideBarCategorySectionArrayAltered[3][@"Names"] : [NSMutableArray array];
        
        [[NSUserDefaults standardUserDefaults] setObject:@{@"Users" : @{@"Username" : userNameArray, @"UserID" : userIDArray}, @"Tags" : tagNameArray, @"Colors" : allColorsArray} forKey:@"Stuff"];
        
        NSMutableDictionary *myNotificationSettingsDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] && notificationSettingsDict[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] ? notificationSettingsDict[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] : [NSMutableDictionary dictionary];
        [[[PushObject alloc] init] PushToNotificationSettingsViewController:self notificationSettings:myNotificationSettingsDict viewingChores:NO viewingExpenses:NO viewingLists:NO viewingGroupChats:NO viewingHomeMembers:NO viewingForum:NO viewingScheduledSummary:NO viewingScheduledSummaryTaskTypes:NO Superficial:NO];
        
    } else {
        
        [[[NotificationsObject alloc] init] UserHasAcceptedNotifications:^(BOOL isActive) {
            
            [[NSUserDefaults standardUserDefaults] setObject:isActive == YES ? @"Yes" : @"No" forKey:@"NotificationsHaveBeenAccepted"];
            
            if (([[NSUserDefaults standardUserDefaults] objectForKey:@"NotificationsHaveBeenAccepted"]) &&
                ([[[NSUserDefaults standardUserDefaults] objectForKey:@"NotificationsHaveBeenAccepted"] isEqualToString:@"Yes"])) {
                
                NSMutableDictionary *notificationSettingsDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"NotificationSettingsDict"];
                NSMutableArray *sideBarCategorySectionArrayAltered = [[NSUserDefaults standardUserDefaults] objectForKey:@"SideBarCategorySectionArrayAltered"];
                
                NSMutableArray *userIDArray = [sideBarCategorySectionArrayAltered count] > 1 && sideBarCategorySectionArrayAltered[1][@"IDs"] ? sideBarCategorySectionArrayAltered[1][@"IDs"] : [NSMutableArray array];
                NSMutableArray *userNameArray = [sideBarCategorySectionArrayAltered count] > 1 && sideBarCategorySectionArrayAltered[1][@"Names"] ? sideBarCategorySectionArrayAltered[1][@"Names"] : [NSMutableArray array];
                NSMutableArray *tagNameArray = [sideBarCategorySectionArrayAltered count] > 2 && sideBarCategorySectionArrayAltered[2][@"Names"] ? sideBarCategorySectionArrayAltered[2][@"Names"] : [NSMutableArray array];
                NSMutableArray *allColorsArray = [sideBarCategorySectionArrayAltered count] > 3 && sideBarCategorySectionArrayAltered[3][@"Names"] ? sideBarCategorySectionArrayAltered[3][@"Names"] : [NSMutableArray array];
                
                [[NSUserDefaults standardUserDefaults] setObject:@{@"Users" : @{@"Username" : userNameArray, @"UserID" : userIDArray}, @"Tags" : tagNameArray, @"Colors" : allColorsArray} forKey:@"Stuff"];
                
//                NSMutableDictionary *myNotificationSettingsDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] && notificationSettingsDict[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] ? notificationSettingsDict[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] : [NSMutableDictionary dictionary];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [[[PushObject alloc] init] PushToNotificationSettingsViewController:self notificationSettings:notificationSettingsDict viewingChores:NO viewingExpenses:NO viewingLists:NO viewingGroupChats:NO viewingHomeMembers:NO viewingForum:NO viewingScheduledSummary:NO viewingScheduledSummaryTaskTypes:NO Superficial:NO];
                    
                });
                
            } else if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"HasTheUserBeenAskedToReceiveNotifications"] isEqualToString:@"Yes"]) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    self->alertView = [[AlertView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) viewControllerWidth:self.view.frame.size.width viewControllerHeight:self.view.frame.size.height text:[NSString stringWithFormat:@"Turn on Notifications\n\nFind out when you're assigned to tasks, when their due, and when their completed"] acceptButtonSelector:@selector(EnableNotificationsRequestAccepted:) declineButtonSelector:@selector(RequestRejected:) viewControllerObject:[[SettingsViewController alloc] init]];
                    self->alertView.alpha = 0.0f;
                    [self.view addSubview:self->alertView];
                    
                    [UIView animateWithDuration:0.25 animations:^{
                        self->alertView.alpha = 1.0f;
                    }];
                    
                });
                
            } else {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
                    
                });
                
            }
            
        }];
        
    }
    
}

-(IBAction)RequestRejected:(id)sender {
    
    [UIView animateWithDuration:0.25 animations:^{
        self->alertView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self->alertView removeFromSuperview];
    }];
    
}

-(IBAction)DarkModeAction:(id)sender {
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"DarkModeSelected"] isEqualToString:@"Yes"]) {
        
        [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"DarkModeSelected"];
        [darkModeSwitch setOn:NO];
        
    } else {
        
        [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"DarkModeSelected"];
        [[NSUserDefaults standardUserDefaults] setObject:@"Manual" forKey:@"AutoDarkModeSelected"];
        [darkModeSwitch setOn:YES];
        
    }
    
    if (_viewingPremiumSettings) {
        
        [self SetUpViewPremium];
        
    } else {
        
        [self SetUpView];
        
    }
    
    [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ReloadView" userInfo:nil locations:@[@"Tasks", @"Chats", @"Homes", @"Profile"]];

    [UIView animateWithDuration:0.25 animations:^{
        
        [self ViewColors];
        
    }];
    
}

-(IBAction)BillingAction:(id)sender {
    
    if ([[[GeneralObject alloc] init] ConnectedToInternet] == NO) {
        [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You need to be connected to the internet to do that." currentViewController:self];
        return;
    }
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Billing"] completionHandler:^(BOOL finished) {
        
    }];
    
    NSUInteger index = [homeMembersDict[@"UserID"] indexOfObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
    
    if (homeMembersDict &&
        homeMembersDict[@"WeDivvyPremium"] &&
        [(NSArray *)homeMembersDict[@"WeDivvyPremium"] count] > index &&
        homeMembersDict[@"WeDivvyPremium"][index][@"SubscriptionDatePurchased"] &&
        [homeMembersDict[@"WeDivvyPremium"][index][@"SubscriptionDatePurchased"] length] > 0) {
        
        [[[PushObject alloc] init] PushToBillingViewController:self];
        
    } else {
        
        [[[PushObject alloc] init] PushToWeDivvyPremiumViewController:NO comingFromSignUp:NO defaultPlan:@"" displayDiscount:@"Half-Off Yearly Discount No Sale Sticker" selectedSlide:@"" promoCodeID:@"" premiumPlanProductsArray:premiumPlanProductsArray premiumPlanPricesDict:premiumPlanPricesDict premiumPlanExpensivePricesDict:premiumPlanExpensivePricesDict premiumPlanPricesDiscountDict:premiumPlanPricesDiscountDict premiumPlanPricesNoFreeTrialDict:premiumPlanPricesNoFreeTrialDict currentViewController:self Superficial:NO];
        
    }
    
}

-(IBAction)TOSAndPPAction:(id)sender {
    
    if ([[[GeneralObject alloc] init] ConnectedToInternet] == NO) {
        [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You need to be connected to the internet to do that." currentViewController:self];
        return;
    }
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"TOS and PP"] completionHandler:^(BOOL finished) {
        
    }];
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Terms of Service" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Terms of Service"] completionHandler:^(BOOL finished) {
            
        }];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.wedivvyapp.com/terms-of-service"] options:@{} completionHandler:^(BOOL success) {
            
        }];
        
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Privacy Policy" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Privacy Policy"] completionHandler:^(BOOL finished) {
            
        }];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.wedivvyapp.com/privacy-policy"] options:@{} completionHandler:^(BOOL success) {
            
        }];
        
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"EULA Policy" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Privacy Policy"] completionHandler:^(BOOL finished) {
            
        }];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.apple.com/legal/internet-services/itunes/dev/stdeula/"] options:@{} completionHandler:^(BOOL success) {
            
        }];
        
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Cancel"] completionHandler:^(BOOL finished) {
            
        }];
        
    }]];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
    
}


#pragma mark

- (IBAction)RequestFeatureAction:(id)sender {
    
    if ([[[GeneralObject alloc] init] ConnectedToInternet] == NO) {
        [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You need to be connected to the internet to do that." currentViewController:self];
        return;
    }
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Request Feature"] completionHandler:^(BOOL finished) {
        
    }];
    
    [[[PushObject alloc] init] PushToForumViewController:YES currentViewController:self];
    
}

- (IBAction)RequestBugAction:(id)sender {
    
    if ([[[GeneralObject alloc] init] ConnectedToInternet] == NO) {
        [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You need to be connected to the internet to do that." currentViewController:self];
        return;
    }
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Request Bug"] completionHandler:^(BOOL finished) {
        
    }];
    
    [[[PushObject alloc] init] PushToForumViewController:NO currentViewController:self];
    
}

- (IBAction)LiveSupportAction:(id)sender {
    
    if ([[[GeneralObject alloc] init] ConnectedToInternet] == NO) {
        [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You need to be connected to the internet to do that." currentViewController:self];
        return;
    }
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Live Support"] completionHandler:^(BOOL finished) {
        
    }];
    
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] isEqualToString:@"2021-08-24 23:51:563280984"]) {
        
        [self StartProgressView];
        
        if (![[NSUserDefaults standardUserDefaults] objectForKey:@"StartedLiveChat"]) {
            
            [[[NotificationsObject alloc] init] SendPushNotificationToCreator:[NSString stringWithFormat:@"%@ - New Support Chat", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] notificationBody:@"" badgeNumber:(NSInteger *)1 completionHandler:^(BOOL finished) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"StartedLiveChat"];
                    
                    [self->progressView setHidden:YES];
                    
                    [[[PushObject alloc] init] PushToLiveChatViewControllerFromSettingsPage:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] viewingLiveSupport:YES currentViewController:self Superficial:NO];
                    
                });
                
            }];
            
        } else {
            
            [[[NotificationsObject alloc] init] SendPushNotificationToCreator:[NSString stringWithFormat:@"%@ - Existing Support Chat", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] notificationBody:@"" badgeNumber:(NSInteger *)1 completionHandler:^(BOOL finished) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self->progressView setHidden:YES];
                    
                    [[[PushObject alloc] init] PushToLiveChatViewControllerFromSettingsPage:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] viewingLiveSupport:YES currentViewController:self Superficial:NO];
                    
                });
                
            }];
            
        }
        
    } else {
        
        [self->progressView setHidden:YES];
        
        [[[PushObject alloc] init] PushToMasterLiveChatViewController:self];
        
    }
    
}

-(IBAction)ContactUsButtonAction:(id)sender {
    
    if ([[[GeneralObject alloc] init] ConnectedToInternet] == NO) {
        [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You need to be connected to the internet to do that." currentViewController:self];
        return;
    }
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Contact Us"] completionHandler:^(BOOL finished) {
        
    }];
    
    if([MFMailComposeViewController canSendMail]) {
        
        MFMailComposeViewController *mailCont = [[MFMailComposeViewController alloc] init];
        mailCont.mailComposeDelegate = self;
        
        [mailCont setSubject:[NSString stringWithFormat:@"WeDivvy Customer Service: %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"]]];
        [mailCont setToRecipients:[NSArray arrayWithObjects:@"wedivvy@wedivvyapp.com", nil]];
        [mailCont setMessageBody:@"" isHTML:NO];
        mailCont.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:mailCont animated:YES completion:nil];
        
    } else {
        
        [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"This iPhone is not capable of sending emails" currentViewController:self];
        
    }
    
}

#pragma mark

- (IBAction)TellAFriend:(id)sender {
    
    if ([[[GeneralObject alloc] init] ConnectedToInternet] == NO) {
        [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You need to be connected to the internet to do that." currentViewController:self];
        return;
    }
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"TellAFriend"] completionHandler:^(BOOL finished) {
        
    }];
    
    NSString *body = [NSString stringWithFormat:@"Hey, check out this cool app. It helps you split chores and expenses with people you live with. 😊"];
    
    NSArray* dataToShare = @[body, [NSURL URLWithString:@"https://apps.apple.com/us/app/wedivvy/id1570700094"]];
    
    UIActivityViewController* activityViewController = [[UIActivityViewController alloc] initWithActivityItems:dataToShare applicationActivities:nil];
    [activityViewController setValue:@"Invitation From a Friend" forKey:@"subject"];
    activityViewController.excludedActivityTypes = @[UIActivityTypeAirDrop];
    
    [activityViewController setCompletionWithItemsHandler:^(NSString * __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError) {
        
    }];
    
    [self presentViewController:activityViewController animated:YES completion:^{}];
    
}

- (IBAction)AppStoreRating:(id)sender {
    
    if ([[[GeneralObject alloc] init] ConnectedToInternet] == NO) {
        [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You need to be connected to the internet to do that." currentViewController:self];
        return;
    }
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Review"] completionHandler:^(BOOL finished) {
        
    }];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if ([SKStoreReviewController class]){
            
            int numberOfTimes = 0;
            
            if (![[NSUserDefaults standardUserDefaults] objectForKey:@"TimesAskedForReview"]) {
                [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"TimesAskedForReview"];
            } else {
                numberOfTimes = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TimesAskedForReview"] intValue];
                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d", numberOfTimes+1] forKey:@"TimesAskedForReview"];
            }
            
            if (numberOfTimes < 3) {
                [SKStoreReviewController requestReviewInScene:self.view.window.windowScene];
            } else {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://apps.apple.com/us/app/wedivvy/id1570700094"] options:@{} completionHandler:^(BOOL success) {
                    
                }];
            }
            
        }
        
    });
    
}

- (IBAction)SocialMediaLinksAction:(id)sender {
    
    if ([[[GeneralObject alloc] init] ConnectedToInternet] == NO) {
        [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You need to be connected to the internet to do that." currentViewController:self];
        return;
    }
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Social Media Links"] completionHandler:^(BOOL finished) {
        
    }];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://linktr.ee/thewedivvyapp"] options:@{} completionHandler:^(BOOL success) {
        
    }];
    
}

- (IBAction)PlayStoreAction:(id)sender {
    
    if ([[[GeneralObject alloc] init] ConnectedToInternet] == NO) {
        [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You need to be connected to the internet to do that." currentViewController:self];
        return;
    }
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Play Store"] completionHandler:^(BOOL finished) {
        
    }];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://forms.gle/1SNQLNoWUQzcdPFt6"] options:@{} completionHandler:^(BOOL success) {
        
    }];
    
}

-(IBAction)ReceiveUpdateEmails:(id)sender {
    
    if ([[[GeneralObject alloc] init] ConnectedToInternet] == NO) {
        [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You need to be connected to the internet to do that." currentViewController:self];
        return;
    }
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Receive Update Emails"] completionHandler:^(BOOL finished) {
        
    }];
    
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userID == %@", userID];
    [[[SetDataObject alloc] init] SetDataEditCoreData:@"Users" predicate:predicate setDataObject:@{@"ReceiveUpdateEmails" : [receiveEmailsSwitch isOn] ? @"Yes" : @"No"}];
    
    [[[SetDataObject alloc] init] UpdateDataUserData:userID userDict:@{@"ReceiveUpdateEmails" : [receiveEmailsSwitch isOn] ? @"Yes" : @"No"} completionHandler:^(BOOL finished, NSError * _Nonnull error) {
        
        [[NSUserDefaults standardUserDefaults] setObject:[self->receiveEmailsSwitch isOn] ? @"Yes" : @"No" forKey:@"UserReceive Update Emails"];
        
    }];
    
}

#pragma mark

-(IBAction)LogoutAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Logout"] completionHandler:^(BOOL finished) {
        
    }];
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *completeUncompleteAction = [UIAlertAction actionWithTitle:@"Log Out" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
            
        });
        
        InitialNavigationViewController* viewControllerObject = [self.storyboard instantiateViewControllerWithIdentifier:@"InitialNavigationViewController"];
        
        NSError *signOutError;
        BOOL status = [[FIRAuth auth] signOut:&signOutError];
        
        if (!status) {
            
            NSLog(@"Error signing out: %@", signOutError);
            return;
            
        } else {
            
            if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] isEqualToString:@"2021-08-24 23:51:563280984"]) {
                
                NSString *topic = [[[GeneralObject alloc] init] GetTopicFromUserID:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
                
                [[[GeneralObject alloc] init] AllGenerateTokenMethod:topic Subscribe:NO GrantedNotifications:NO];
                
                    [[[SceneDelegate alloc] init] SetUpShortcutIcons];
                    
                    [[[SettingsObject alloc] init] ResetDefaultsSettings];
                    
                    [[FIRAuth auth] signOut:nil];
                    [[GIDSignIn sharedInstance] signOut];
                    
                    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
                    
                    viewControllerObject.modalPresentationStyle = UIModalPresentationFullScreen;
                    
                    [self presentViewController:viewControllerObject animated:YES completion:nil];
             
            } else {
                
                [[[SettingsObject alloc] init] ResetDefaultsSettings];
                
                [[FIRAuth auth] signOut:nil];
                [[GIDSignIn sharedInstance] signOut];
                
                [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
                
                viewControllerObject.modalPresentationStyle = UIModalPresentationFullScreen;
                
                [self presentViewController:viewControllerObject animated:YES completion:nil];
                
            }
            
        }
        
    }];
    
    [completeUncompleteAction setValue:[UIColor systemRedColor] forKey:@"titleTextColor"];
    
    [actionSheet addAction:completeUncompleteAction];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Cancel Logout"] completionHandler:^(BOOL finished) {
            
        }];
        
    }]];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
    
}

-(IBAction)DeleteAccountAction:(id)sender {
    
    if ([[[GeneralObject alloc] init] ConnectedToInternet] == NO) {
        [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You need to be connected to the internet to do that." currentViewController:self];
        return;
    }
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Delete Account"] completionHandler:^(BOOL finished) {
        
    }];
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil
                                                                        message:@"Enter your credentials to delete your account"
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Delete Account"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * _Nonnull action) {
        
        [self StartProgressView];
        
        NSString *email = controller.textFields[0].text;
        NSString *password = controller.textFields[1].text;
        
        [[FIRAuth auth] signInWithEmail:email password:password completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
            
            if (error == nil) {
                
                [self->progressView setHidden:YES];
                
                [self DeleteAccount_ActionSheet];
                
            } else {
                
                [self DeleteAccount_SignInError:error];
                
            }
            
        }];
        
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction * _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Delete Account Cancel"] completionHandler:^(BOOL finished) {
            
        }];
        
    }];
    
    
    
    [controller addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        
        textField.delegate = self;
        textField.placeholder = NSLocalizedString(@"Email", @"Email");
        textField.text = @"";
        
    }];
    
    [controller addTextFieldWithConfigurationHandler:^(UITextField *textField1) {
        
        textField1.delegate = self;
        textField1.placeholder = NSLocalizedString(@"Password", @"Password");
        textField1.secureTextEntry = YES;
        textField1.text = @"";
        
        
    }];
    
    
    [controller addAction:action];
    [controller addAction:cancel];
    [self presentViewController:controller animated:YES completion:nil];
    
}

#pragma mark

-(IBAction)ChangePlanOrPurchaseSubscriptionAction:(id)sender {
    
    if ([[[GeneralObject alloc] init] ConnectedToInternet] == NO) {
        [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You need to be connected to the internet to do that." currentViewController:self];
        return;
    }
    
    [[[PushObject alloc] init] PushToWeDivvyPremiumViewController:NO comingFromSignUp:NO defaultPlan:@"" displayDiscount:@"Half-Off Yearly Discount No Sale Sticker" selectedSlide:@"" promoCodeID:@"" premiumPlanProductsArray:premiumPlanProductsArray premiumPlanPricesDict:premiumPlanPricesDict premiumPlanExpensivePricesDict:premiumPlanExpensivePricesDict premiumPlanPricesDiscountDict:premiumPlanPricesDiscountDict premiumPlanPricesNoFreeTrialDict:premiumPlanPricesNoFreeTrialDict currentViewController:self Superficial:NO];
    
}

#pragma mark

-(IBAction)PremiumAccountsAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Assigned To Field Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    NSMutableArray *selectedArray = [NSMutableArray array];
    
    NSMutableDictionary *homeMembersUnclaimedDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeMembersUnclaimedDict"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeMembersUnclaimedDict"] : [NSMutableDictionary dictionary];
    NSMutableDictionary *homeKeysDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeKeysDict"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeKeysDict"] : [NSMutableDictionary dictionary];
    NSMutableArray *homeKeysArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeKeysArray"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeKeysArray"] : [NSMutableArray array];
    
    homeMembersDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeMembersDict"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"HomeMembersDict"] mutableCopy] : [NSMutableDictionary dictionary];
    
    
    [[[PushObject alloc] init] PushToViewAssignedViewController:selectedArray itemAssignedToNewHomeMembers:@"No" itemAssignedToAnybody:@"No" itemUniqueID:@"" homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict homeMembersUnclaimedDict:homeMembersUnclaimedDict homeKeysDict:homeKeysDict homeKeysArray:homeKeysArray notificationSettingsDict:notificationSettingsDict topicDict:topicDict viewingItemDetails:NO viewingExpense:NO viewingChatMembers:NO viewingWeDivvyPremiumAddingAccounts:NO viewingWeDivvyPremiumEditingAccounts:YES currentViewController:self];
    
}

#pragma mark

-(IBAction)AppIconAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"App Icon"] completionHandler:^(BOOL finished) {
        
    }];
    
    NSMutableArray *itemsSelectedArray = [NSMutableArray array];
    
    NSString *appIcon = @"WeDivvyOriginal.png";
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"AppIconSelectedReadableName"]) {
        appIcon = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppIconSelectedReadableName"];
    }
    
    [itemsSelectedArray addObject:appIcon];

    [[[PushObject alloc] init] PushToViewOptionsViewController:itemsSelectedArray customOptionsArray:nil specificDatesArray:nil viewingItemDetails:NO optionSelectedString:@"AppIcon" itemRepeatsFrequency:nil homeMembersDict:nil currentViewController:self];
    
}

-(IBAction)AppThemeAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"App Theme"] completionHandler:^(BOOL finished) {
        
    }];
    
    NSMutableArray *itemsSelectedArray = [NSMutableArray array];
    
    NSString *appTheme = @"Default";
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"AppThemeSelected"]) {
        appTheme = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppThemeSelected"];
    }
    
    [itemsSelectedArray addObject:appTheme];
    
    [[[PushObject alloc] init] PushToViewOptionsViewController:itemsSelectedArray customOptionsArray:nil specificDatesArray:nil viewingItemDetails:NO optionSelectedString:@"AppTheme" itemRepeatsFrequency:nil homeMembersDict:nil currentViewController:self];
    
}

-(IBAction)AutoDarkModeAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Auto Dark Mode Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    NSMutableArray *itemsArray = [NSMutableArray array];
    [itemsArray addObject:@""];
    [itemsArray addObject:@""];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"AutoDarkModeSelected"]) {
        
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"AutoDarkModeSelected"] isEqualToString:@"Manual"] == NO) {
            
            NSString *darkModeTime = [[NSUserDefaults standardUserDefaults] objectForKey:@"AutoDarkModeSelected"];
            
            if ([darkModeTime containsString:@" to "]) {
                
                if ([itemsArray count] > 0) { [itemsArray replaceObjectAtIndex:0 withObject:[darkModeTime componentsSeparatedByString:@" to "][0]]; }
                if ([itemsArray count] > 1) { [itemsArray replaceObjectAtIndex:1 withObject:[darkModeTime componentsSeparatedByString:@" to "][1]]; }
                
            }
            
        }
        
    }
    
    [[[PushObject alloc] init] PushToViewAddItemsViewController:itemsArray itemsAlreadyChosenDict:nil userDict:nil optionSelectedString:@"AutoDarkMode" itemRepeats:@"Never" viewingItemDetails:NO currentViewController:self];
    
    
}

-(IBAction)LaunchPageAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Launch Page Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    NSMutableArray *itemsSelectedArray = [NSMutableArray array];
    
    NSString *appIcon = @"Chores";
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"LaunchPageSelected"]) {
        appIcon = [[NSUserDefaults standardUserDefaults] objectForKey:@"LaunchPageSelected"];
    }
    
    [itemsSelectedArray addObject:appIcon];
    
    [[[PushObject alloc] init] PushToViewOptionsViewController:itemsSelectedArray customOptionsArray:nil specificDatesArray:nil viewingItemDetails:NO optionSelectedString:@"LaunchPage" itemRepeatsFrequency:nil homeMembersDict:nil currentViewController:self];
    
}

-(IBAction)ShortcutItemsAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Launch Page Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    NSMutableArray *customOptionsArray = [NSMutableArray array];
    
    [customOptionsArray addObject:@"🔍 Search Tasks"];
    [customOptionsArray addObject:@"🧹 Add Chore"];
    [customOptionsArray addObject:@"💵 Add Expense"];
    [customOptionsArray addObject:@"📋 Add List"];
    //    [customOptionsArray addObject:@"💬 Add Group Chat"];
    //    [customOptionsArray addObject:@"🧹 Add Multiple Chores"];
    //    [customOptionsArray addObject:@"💵 Add Multiple Expenses"];
    //    [customOptionsArray addObject:@"📋 Add Multiple Lists"];
    //    [customOptionsArray addObject:@"💬 Multi-Add Group Chats"];
    
    NSMutableArray *sideBarCategorySectionArrayAltered = [[NSUserDefaults standardUserDefaults] objectForKey:@"SideBarCategorySectionArrayAltered"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"SideBarCategorySectionArrayAltered"] mutableCopy] : [NSMutableArray array];
    
    NSMutableArray *defaultSidebarCategories = sideBarCategorySectionArrayAltered && [sideBarCategorySectionArrayAltered count] > 1 && sideBarCategorySectionArrayAltered[1][@"Names"] ? sideBarCategorySectionArrayAltered[1][@"Names"] : [NSMutableArray array];
    NSMutableArray *usernameSidebarCategories = sideBarCategorySectionArrayAltered && [sideBarCategorySectionArrayAltered count] > 2 && sideBarCategorySectionArrayAltered[2][@"Names"] ? sideBarCategorySectionArrayAltered[2][@"Names"] : [NSMutableArray array];
    NSMutableArray *tagSidebarCategories = sideBarCategorySectionArrayAltered && [sideBarCategorySectionArrayAltered count] > 3 && sideBarCategorySectionArrayAltered[3][@"Names"] ? sideBarCategorySectionArrayAltered[3][@"Names"] : [NSMutableArray array];
    NSMutableArray *colorSidebarCategories = sideBarCategorySectionArrayAltered && [sideBarCategorySectionArrayAltered count] > 4 && sideBarCategorySectionArrayAltered[4][@"Names"] ? sideBarCategorySectionArrayAltered[4][@"Names"] : [NSMutableArray array];
    NSMutableArray *taskListsSidebarCategories = sideBarCategorySectionArrayAltered && [sideBarCategorySectionArrayAltered count] > 5 && sideBarCategorySectionArrayAltered[5][@"Names"] ? sideBarCategorySectionArrayAltered[5][@"Names"] : [NSMutableArray array];
    
    for (NSString *defaultSection in defaultSidebarCategories) {
        
        [customOptionsArray addObject:[NSString stringWithFormat:@"📁 %@", defaultSection]];
        
    }
    
    for (NSString *username in usernameSidebarCategories) {
        
        [customOptionsArray addObject:[NSString stringWithFormat:@"👤 %@", username]];
        
    }
    
    for (NSString *tagName in tagSidebarCategories) {
        
        [customOptionsArray addObject:[NSString stringWithFormat:@"🏷️ #%@", tagName]];
        
    }
    
    for (NSString *colorName in colorSidebarCategories) {
        
        [customOptionsArray addObject:[NSString stringWithFormat:@"🖍️ %@", colorName]];
        
    }
    
    for (NSString *listName in taskListsSidebarCategories) {
        
        [customOptionsArray addObject:[NSString stringWithFormat:@"🗄️ %@", listName]];
        
    }
    
    NSMutableArray *selectedArray = [[[NSUserDefaults standardUserDefaults] objectForKey:@"ShortcutItems"] mutableCopy];
    
    [[[PushObject alloc] init] PushToViewOptionsViewController:selectedArray customOptionsArray:customOptionsArray specificDatesArray:nil viewingItemDetails:NO optionSelectedString:@"ShortcutItems" itemRepeatsFrequency:nil homeMembersDict:nil currentViewController:self];
    
}

#pragma mark

- (IBAction)FAQAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"FAQ"] completionHandler:^(BOOL finished) {
        
    }];
    
    [[[PushObject alloc] init] PushToFAQViewController:self];
    
}

#pragma mark

-(IBAction)SubmitPremiumFeedback:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Premium Feedback"] completionHandler:^(BOOL finished) {
        
    }];
    
    _requestFeedbackBackdropView.alpha = 1.0;
    
    [self->_requestFeedbackAlertViewScrollView setContentOffset:CGPointMake(self.view.frame.size.width, 0) animated:NO];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        CGRect newRect = self->_requestFeedbackAlertView.frame;
        newRect.origin.y = self.view.frame.size.height - newRect.size.height;
        self->_requestFeedbackAlertView.frame = newRect;
        
    } completion:^(BOOL finished) {
        
        [self.requestFeedbackAlertViewNotesTextView becomeFirstResponder];
        
    }];
    
}

#pragma mark

-(IBAction)EnableNotificationsRequestAccepted:(id)sender {

    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"TurnOnNotifications - %@", @"SettingsViewController"] completionHandler:^(BOOL finished) {
        
    }];
    
    UNAuthorizationOptions authOptions = UNAuthorizationOptionAlert | UNAuthorizationOptionSound | UNAuthorizationOptionBadge;
    
    [[UNUserNotificationCenter currentNotificationCenter]
     requestAuthorizationWithOptions:authOptions
     completionHandler:^(BOOL granted, NSError * _Nullable error) {
        
        NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userID == %@", userID];
        [[[SetDataObject alloc] init] SetDataEditCoreData:@"Users" predicate:predicate setDataObject:@{@"Notifications" : granted ? @"Yes" : @"No"}];
        
        [[[SetDataObject alloc] init] UpdateDataUserData:userID userDict:@{@"Notifications" : granted ? @"Yes" : @"No"} completionHandler:^(BOOL finished, NSError * _Nonnull error) {
            
        }];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"HasTheUserBeenAskedToReceiveNotifications"];
        
        if (granted) {
            
            [[[GeneralObject alloc] init] AllGenerateTokenMethod:@"AllHomeTopics" Subscribe:YES GrantedNotifications:granted];
            
            NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
            
                    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Granted Notifications"] completionHandler:^(BOOL finished) {
                        
                    }];
                    
                    [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"NotificationsHaveBeenAccepted"];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [self StartProgressView];
                       
                        [[FIRCrashlytics crashlytics] logWithFormat:@"GenerateTwoWeekReminderNotification Settings"];
                        
                        [[[NotificationsObject alloc] init] RemoveLocalInactiveNotification];
                        [[[NotificationsObject alloc] init] GenerateTwoWeekReminderNotification];
                        
                        NSArray *keyArray = [[[GeneralObject alloc] init] GenerateKeyArrayManually:NO Expense:NO List:NO Home:YES];
                   
                        [[[GetDataObject alloc] init] GetDataSpecificHomeData:homeID keyArray:keyArray completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningHomeToJoinDict, NSMutableArray * _Nonnull queriedHomeMemberArray, NSString * _Nonnull queriedHomeID) {
                            
                            __block int totalQueries = 2;
                            __block int completedQueries = 0;
                            
                            NSMutableArray *homeMembersArray = returningHomeToJoinDict && returningHomeToJoinDict[@"HomeMembers"] ? [returningHomeToJoinDict[@"HomeMembers"] mutableCopy] : [NSMutableArray array];
                            
                            __block NSMutableDictionary *homeMembersDictLocal = self->homeMembersDict;
                            __block NSMutableDictionary *notificationSettingsDictLocal = self->notificationSettingsDict;
                            
                            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                
                                [[[GetDataObject alloc] init] GetDataUserDataArray:homeMembersArray completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningUserDict) {
                                    
                                    homeMembersDictLocal = [returningUserDict mutableCopy];
                                    
                                    if (totalQueries == (completedQueries += 1)) {
                                        
                                        NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
                                        
                                        [[[HomesViewControllerObject alloc] init] UserJoiningHome_UpdateDataForNewHomeMemberLocal:homeID userToAdd:userID homeMembersDict:homeMembersDictLocal notificationSettingsDict:notificationSettingsDictLocal topicDict:self->topicDict clickedUnclaimedUser:NO QueryAssignedToNewHomeMember:YES QueryAssignedTo:NO queryAssignedToUserID:@"" ResetNotifications:NO completionHandler:^(BOOL finished) {
                                            
                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                
                                                [self->progressView setHidden:YES];
                                                [self RequestRejected:self];
                                                
                                            });
                                            
                                        }];
                                        
                                    }
                                    
                                }];
                                
                            });
                            
                            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                
                                [[[GetDataObject alloc] init] GetDataUserNotificationSettingsData:homeMembersArray completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningNotificationSettingsDict) {
                                    
                                    notificationSettingsDictLocal = [returningNotificationSettingsDict mutableCopy];
                                    
                                    if (totalQueries == (completedQueries += 1)) {
                                        
                                        NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
                                        
                                        [[[HomesViewControllerObject alloc] init] UserJoiningHome_UpdateDataForNewHomeMemberLocal:homeID userToAdd:userID homeMembersDict:homeMembersDictLocal notificationSettingsDict:notificationSettingsDictLocal topicDict:self->topicDict clickedUnclaimedUser:NO QueryAssignedToNewHomeMember:YES QueryAssignedTo:NO queryAssignedToUserID:@"" ResetNotifications:NO completionHandler:^(BOOL finished) {
                                            
                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                
                                                [self->progressView setHidden:YES];
                                                [self RequestRejected:self];
                                                
                                            });
                                            
                                        }];
                                        
                                    }
                                    
                                }];
                                
                            });
                            
                        }];
                        
                    });
                   
        } else {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Not Granted Notifications"] completionHandler:^(BOOL finished) {
                
            }];
            
            [self RequestRejected:self];
            
        }
        
    }];
    
}

#pragma mark

- (IBAction)JoinCommunityAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Join Community"] completionHandler:^(BOOL finished) {
        
    }];
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Discord" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Discord"] completionHandler:^(BOOL finished) {
            
        }];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://discord.com/invite/ZGxvapMf"] options:@{} completionHandler:^(BOOL success) {
            
        }];
        
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Reddit" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Reddit"] completionHandler:^(BOOL finished) {
            
        }];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.reddit.com/r/WeDivvy/"] options:@{} completionHandler:^(BOOL success) {
            
        }];
        
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Cancel"] completionHandler:^(BOOL finished) {
            
        }];
        
    }]];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
    
}

#pragma mark

-(IBAction)TapGestureFeedbackNextButton:(id)sender {
    
    UITapGestureRecognizer *tapRecognizer = (UITapGestureRecognizer *)sender;
    NSInteger the_tag = [tapRecognizer.view tag];
    
    NSString *str = @"Nonce";
    
    if (the_tag == 1) {
        str = @"Once";
    } else if (the_tag == 2) {
        str = @"Twice";
    } else if (the_tag == 3) {
        str = @"Thrice";
    }
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Feedback Submit Button Clicked %@ For %@", str, [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    [UIView animateWithDuration:0.25 animations:^{
        
        if (the_tag == 1) {
            
            [self->_requestFeedbackAlertViewScrollView setContentOffset:CGPointMake(width, 0) animated:YES];
            
            [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"CompletedSurvey"];
            
        } else if (the_tag == 2) {
            
            [self->_requestFeedbackAlertViewScrollView setContentOffset:CGPointMake(width*2, 0) animated:YES];
            
        } else if (the_tag == 3) {
            
            CGRect newRect = self->_requestFeedbackAlertView.frame;
            newRect.origin.y = height;
            self->_requestFeedbackAlertView.frame = newRect;
            
        }
        
    } completion:^(BOOL finished) {
        
        if (the_tag == 1) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self->_requestFeedbackAlertViewNotesTextView becomeFirstResponder];
                
            });
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
                
                if ([[NSUserDefaults standardUserDefaults] objectForKey:@"CurrentFeedbackID"]) {
                    [dataDict setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"CurrentFeedbackID"] forKey:@"FeedbackID"];
                } else {
                    NSString *randomID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
                    [[NSUserDefaults standardUserDefaults] setObject:randomID forKey:@"CurrentFeedbackID"];
                    [dataDict setObject:randomID forKey:@"FeedbackID"];
                }
                
                [dataDict setObject:@"(Submitted Score)" forKey:@"FeedbackNotes"];
                
                [[[SetDataObject alloc] init] SetDataFeedback:dataDict completionHandler:^(BOOL finished) {
                    
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        
                        NSString *notificationTitle = [NSString stringWithFormat:@"%@ - %@", @"Feedback", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
                        NSString *notificationBody = [NSString stringWithFormat:@"Rating: %@, Notes: %@", dataDict[@"FeedbackRating"], dataDict[@"FeedbackNotes"]];
                        
                        [[[NotificationsObject alloc] init] SendPushNotificationToCreator:notificationTitle notificationBody:notificationBody badgeNumber:(NSInteger *)1 completionHandler:^(BOOL finished) {
                            
                        }];
                        
                    });
                    
                }];
                
            });
            
        } else if (the_tag == 2) {
            
            [self->_requestFeedbackAlertViewNotesTextView resignFirstResponder];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [UIView animateWithDuration:0.25 animations:^{
                    
                    CGRect newRect = self->_requestFeedbackAlertView.frame;
                    newRect.origin.y = height;
                    self->_requestFeedbackAlertView.frame = newRect;
                    
                } completion:^(BOOL finished) {
                    
                    [self DisplayAlertView:NO backDropView:self->_requestFeedbackBackdropView alertViewNoButton:nil alertViewYesButton:nil];
                    
                    [[[GeneralObject alloc] init] CreateAlert:@"Feedback Submitted!" message:@"Thanks! We'll use your feedback to help us improve WeDivvy! 😎" currentViewController:self];
                    
                }];
                
            });
            
            NSString *notes = self->_requestFeedbackAlertViewNotesTextView.text;
            notes = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:notes arrayOfSymbols:@[@"Leave your feedback here"]];
 
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
                
                [dataDict setObject: [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString] forKey:@"FeedbackID"];
                [dataDict setObject:[[[GeneralObject alloc] init] GenerateCurrentDateString] forKey:@"FeedbackDatePosted"];
                [dataDict setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] forKey:@"FeedbackSubmittedBy"];
                [dataDict setObject:notes forKey:@"FeedbackNotes"];
                
                [[[SetDataObject alloc] init] SetDataPremiumFeedback:dataDict completionHandler:^(BOOL finished) {
                    
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"CurrentFeedbackID"];
                    
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        
                        NSString *notificationTitle = [NSString stringWithFormat:@"%@ - %@", @"Premium Feedback", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
                        NSString *notificationBody = [NSString stringWithFormat:@"Notes: %@", dataDict[@"FeedbackNotes"]];
                        
                        [[[NotificationsObject alloc] init] SendPushNotificationToCreator:notificationTitle notificationBody:notificationBody badgeNumber:(NSInteger *)1 completionHandler:^(BOOL finished) {
                            
                        }];
                        
                    });
                    
                }];
                
            });
            
        } else if (the_tag == 3) {
            
            [self DisplayAlertView:NO backDropView:self->_requestFeedbackBackdropView alertViewNoButton:nil alertViewYesButton:nil];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                NSString *notificationTitle = [NSString stringWithFormat:@"%@ - %@", @"Premium Feedback", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
                NSString *notificationBody = @"Rate Our App Clicked";
                
                [[[NotificationsObject alloc] init] SendPushNotificationToCreator:notificationTitle notificationBody:notificationBody badgeNumber:(NSInteger *)1 completionHandler:^(BOOL finished) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        if ([SKStoreReviewController class]){
                            
                            int numberOfTimes = 0;
                            
                            if (![[NSUserDefaults standardUserDefaults] objectForKey:@"TimesAskedForReview"]) {
                                [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"TimesAskedForReview"];
                            } else {
                                numberOfTimes = [[NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"TimesAskedForReview"]] intValue];
                                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d", numberOfTimes+1] forKey:@"TimesAskedForReview"];
                            }
                            
                            if (numberOfTimes < 3) {
                                [SKStoreReviewController requestReviewInScene:self.view.window.windowScene];
                            } else {
                                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://apps.apple.com/us/app/wedivvy/id1570700094"] options:@{} completionHandler:^(BOOL success) {
                                    
                                }];
                            }
                            
                        }
                        
                    });
                    
                }];
                
            });
            
        }
        
    }];
    
}

-(IBAction)TapGestureFeedbackClose:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Close Feedback Popup Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    [UIView animateWithDuration:0.25 animations:^{
        
        CGRect newRect = self->_requestFeedbackAlertView.frame;
        newRect.origin.y = height;
        self->_requestFeedbackAlertView.frame = newRect;
        
    } completion:^(BOOL finished) {
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"CurrentFeedbackID"];
        
        [self DisplayAlertView:NO backDropView:self->_requestFeedbackBackdropView alertViewNoButton:nil alertViewYesButton:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self->_requestFeedbackAlertViewNotesTextView resignFirstResponder];
            
        });
        
    }];
    
}

#pragma mark - NSNotificationObservers

-(void)NSNotification_Settings_AppIcon:(NSNotification *)notification {
    
    NSString *appIcon = @"Default";
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"AppIconSelectedReadableName"]) {
        appIcon = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppIconSelectedReadableName"];
    }
    
    NSArray *appIconStringNameArray = [[[GeneralObject alloc] init] GenerateAppIconColorNameOptionsArray];
    NSUInteger index = [appIconStringNameArray containsObject:appIcon] ? [appIconStringNameArray indexOfObject:appIcon] : 0;
    NSArray *appIconStringImageArray = [[[GeneralObject alloc] init] GenerateAppIconImageNameOptionsArray];
    NSString *imageString = [appIconStringImageArray count] > index ? appIconStringImageArray[index] : appIconStringImageArray[0];
    UIImage *image = [UIImage imageNamed:imageString];
    
    appIconChosenImageView.image = image;
    
}

-(void)NSNotification_Settings_AppTheme:(NSNotification *)notification {
    
    NSDictionary *userInfo = notification.userInfo;
    
    NSString *strColor = userInfo[@"AppTheme"];
    appThemeChosenView.backgroundColor = [[[GeneralObject alloc] init] GenerateColorOptionFromColorString:strColor];
    
}

-(void)NSNotification_Settings_LaunchPage:(NSNotification *)notification {
    
    NSDictionary *userInfo = notification.userInfo;
    
    NSString *strColor = userInfo[@"LaunchPage"];
    launchPageChosenLabel.text = strColor;
    
}

-(void)NSNotification_Settings_AutoDarkMode:(NSNotification *)notification {
    
    NSDictionary *userInfo = notification.userInfo;
    
    NSString *startTime = userInfo[@"StartTime"];
    NSString *endTime = userInfo[@"EndTime"];
    
    if ([startTime isEqualToString:@"Never"] || [endTime isEqualToString:@"Never"]) {
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"AutoDarkModeSelected"];
        autoDarkModeChosenLabel.text = @"Never";
        
    } else if ([startTime containsString:@"Manual"] || [endTime containsString:@"Manual"]) {
        
        autoDarkModeChosenLabel.text = @"Manual";
        [[NSUserDefaults standardUserDefaults] setObject:@"Manual" forKey:@"AutoDarkModeSelected"];
        
    } else {
        
        NSString *autoDarkMode = [NSString stringWithFormat:@"%@ to %@", startTime, endTime];
        autoDarkModeChosenLabel.text = autoDarkMode;
        
        [[NSUserDefaults standardUserDefaults] setObject:autoDarkMode forKey:@"AutoDarkModeSelected"];
        [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"DarkModeSelected"];
    }
    
}

-(void)NSNotification_Settings_NotificationSettings:(NSNotification *)notification {
    
    NSDictionary *userInfo = notification.userInfo;
    
    NSMutableDictionary *notificationSettingsDictLocal = [[NSUserDefaults standardUserDefaults] objectForKey:@"NotificationSettingsDict"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"NotificationSettingsDict"] mutableCopy] : [NSMutableDictionary dictionary];
    
    NSMutableDictionary *notificationSettingsLocal = userInfo[@"NotificationSettings"] ? userInfo[@"NotificationSettings"] : [NSMutableDictionary dictionary];
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
    [notificationSettingsDictLocal setObject:notificationSettingsLocal forKey:userID];
    
    notificationSettingsDict = [notificationSettingsDictLocal mutableCopy];
    
    [[NSUserDefaults standardUserDefaults] setObject:notificationSettingsDict forKey:@"NotificationSettingsDict"];
    
}

-(void)NSNotification_Settings_ItemWeDivvyPremiumAccounts:(NSNotification *)notification {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSDictionary *userInfo = notification.userInfo;
        
        NSDictionary *userDict = userInfo[@"UserDict"] ? userInfo[@"UserDict"] : @{};
        NSMutableArray *weDivvyPremiumArray = userDict[@"WeDivvyPremium"] ? userDict[@"WeDivvyPremium"] : @[];
        
        NSMutableDictionary *tempDict = self->homeMembersDict ? [self->homeMembersDict mutableCopy] : [NSMutableDictionary dictionary];
        NSMutableArray *tempArr = tempDict[@"WeDivvyPremium"] ? [tempDict[@"WeDivvyPremium"] mutableCopy] : [NSMutableArray array];
        tempArr = [weDivvyPremiumArray mutableCopy];
        [tempDict setObject:tempArr forKey:@"WeDivvyPremium"];
        self->homeMembersDict = [tempDict mutableCopy];
        
        [[NSUserDefaults standardUserDefaults] setObject:self->homeMembersDict forKey:@"HomeMembersDict"];
        
    });
    
    
}


#pragma mark -
#pragma mark
#pragma mark
#pragma mark Internal Methods
#pragma mark
#pragma mark
#pragma mark -

#pragma mark IBAction Methods

#pragma mark Import Reminder Methods

- (void)GenerateReminderAccess:(void (^)(BOOL AccessGranted))completion {
    
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    
    if ([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)]) {
        
        [eventStore requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted, NSError *error) {
            
            completion(granted);
            
        }];
        
    } else {
        
        completion(NO);
        
    }
    
}

-(void)GenerateLocalReminders:(void (^)(NSArray *localRemindersArray))completion {
    
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    
    NSPredicate *predicate = [eventStore predicateForRemindersInCalendars:nil];
    
    [eventStore fetchRemindersMatchingPredicate:predicate completion:^(NSArray *reminders) {
        
        completion(reminders);
        
    }];
    
}

#pragma mark Update Password Methods

-(void)EnterNewPassword {
    
    [self StartProgressView];
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Enter your new password" message:nil
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Update"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * _Nonnull action) {
        
        [[FIRAuth auth].currentUser updatePassword:controller.textFields[0].text completion:^(NSError * _Nullable error) {
            
            if (error == nil) {
                
                [self->progressView setHidden:YES];
                [[[GeneralObject alloc] init] CreateAlert:@"Yay!" message:@"Your password has been successfully updated!" currentViewController:self];
                
            } else if (controller.textFields[0].text.length < 6) {
                
                [self->progressView setHidden:YES];
                [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"Your password must be at least 6 characters" currentViewController:self];
                
            } else {
                
                [self->progressView setHidden:YES];
                [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"An error has occurred please try again" currentViewController:self];
                
            }
            
        }];
        
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction * _Nonnull action) {      [self->progressView setHidden:YES]; }];
    
    
    
    [controller addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        
        textField.delegate = self;
        textField.placeholder = @"New Password";
        textField.text = @"";
        textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
        textField.secureTextEntry = YES;
        
    }];
    
    [controller addAction:action1];
    [controller addAction:cancel];
    [self presentViewController:controller animated:YES completion:nil];
    
}

#pragma mark Delete Account Methods

-(void)DeleteAccount_ActionSheet {
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *completeUncompleteAction = [UIAlertAction actionWithTitle:@"Delete Account" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Delete Account Final"] completionHandler:^(BOOL finished) {
            
        }];
        
        [self StartProgressView];
        
        
        
        __block int totalQueries = 2;
        __block int completedQueries = 0;
        
        
        
        /*
         //
         //
         //Delete All User Data
         //
         //
         */
        [self DeleteAccount_DeleteAllUserData:^(BOOL finished) {
            
            [self DeleteAccount_CompletionBlock:totalQueries completedQueries:(completedQueries+=1)];
            
        }];
        
        
        /*
         //
         //
         //Update WeDivvy Premium Given By
         //
         //
         */
        [self DeleteAccount_UpdateWeDivvyPremiumGivenBy:^(BOOL finished) {
            
            [self DeleteAccount_CompletionBlock:totalQueries completedQueries:(completedQueries+=1)];
            
        }];
        
    }];
    
    [completeUncompleteAction setValue:[UIColor systemRedColor] forKey:@"titleTextColor"];
    
    [actionSheet addAction:completeUncompleteAction];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Delete Account Cancel"] completionHandler:^(BOOL finished) {
            
        }];
        
    }]];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
    
}

-(void)DeleteAccount_SignInError:(NSError *)error {
    
    if ([error.description containsString:@"There is no user record corresponding to this identifier. The user may have been deleted."]) {
        
        [self->progressView setHidden:YES];
        [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"A user with that email doesn't exist" currentViewController:self];
        
    } else if ([error.description containsString:@"The email address is badly formatted"]) {
        
        [self->progressView setHidden:YES];
        [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"That email is incorrectly formatted" currentViewController:self];
        
    } else if ([error.description containsString:@"The password is invalid or the user does not have a password"]) {
        
        [self->progressView setHidden:YES];
        [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"That email/password combination doesn't exist" currentViewController:self];
        
    } else {
        
        [self->progressView setHidden:YES];
        [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"An error has occurred please try again" currentViewController:self];
        
    }
    
}

#pragma mark UI Methods

-(void)StartProgressView {
    
    self->progressView = [MRProgressOverlayView showOverlayAddedTo:self.navigationController.view animated:YES];
    self->progressView.mode = MRProgressOverlayViewModeIndeterminateSmall;
    
}

-(void)DisplayAlertView:(BOOL)display backDropView:(UIView *)backDropView alertViewNoButton:(UIButton *)alertViewNoButton alertViewYesButton:(UIButton *)alertViewYesButton {
    
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

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Sub-Internal Methods
#pragma mark
#pragma mark
#pragma mark -

#pragma mark IBAction Methods

#pragma mark Import Reminder Methods

-(void)AddItem:(NSDictionary *)setDataDict itemActivityDict:(NSMutableDictionary *)itemActivityDict homeActivityDict:(NSMutableDictionary *)homeActivityDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *collection = [NSString stringWithFormat:@"%@s", @"Chore"];
    NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
    
    __block int totalQueries = 3;
    __block int completedQueries = 0;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[SetDataObject alloc] init] SetDataAddItem:setDataDict collection:collection homeID:homeID completionHandler:^(BOOL finished) {
            
            if (totalQueries == (completedQueries+=1)) {
                
                finishBlock(YES);
                
            }
            
        }];
        
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[SetDataObject alloc] init] SetDataHomeAndItemActivity:itemActivityDict homeActivityDict:homeActivityDict completionHandler:^(BOOL finished) {
            
            if (totalQueries == (completedQueries+=1)) {
                
                finishBlock(YES);
                
            }
            
        }];
        
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[SetDataObject alloc] init] SetDataAddAlgoliaObject:setDataDict[@"ItemUniqueID"] dictToUse:[setDataDict mutableCopy] completionHandler:^(BOOL finished) {
            
            if (totalQueries == (completedQueries+=1)) {
                
                finishBlock(YES);
                
            }
            
        }];
        
    });
    
}

-(NSString *)GenerateItemStartDate {
    
    NSString *startDate = @"Now";
    NSString *dateFormat = @"MMMM dd, yyyy";
    
    if (startDate.length == 0 || [startDate isEqualToString:@"Now"] || [[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:startDate returnAs:[NSDate class]] == nil) {
        
        startDate = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:dateFormat returnAs:[NSString class]];
        
    }
    
    NSArray *dateArr = [startDate componentsSeparatedByString:@" "];
    
    NSString *month = [dateArr count] > 0 ? dateArr[0] : @"";
    NSString *day = [dateArr count] > 1 ? dateArr[1] : @"";
    NSString *year = [dateArr count] > 2 ? dateArr[2] : @"";
    
    startDate = [NSString stringWithFormat:@"%@ %@ %@ 12:00 AM", month, day, year];
    
    return startDate;
    
}

-(NSDictionary *)GenerateSetDataDict:(NSString *)itemNameLocal itemDueDateLocal:(NSString *)itemDueDateLocal itemCompletedLocal:(NSDictionary *)itemCompletedLocal itemPriorityLocal:(NSString *)itemPriorityLocal itemReminderLocal:(NSDictionary *)itemReminderLocal {
    
    NSString *chosenItemUniqueID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    NSString *chosenItemID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    NSString *chosenItemOccurrenceID = @"";
    NSString *chosenItemDatePosted = [[[GeneralObject alloc] init] GenerateCurrentDateString];
    NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
    
    
    
    
    //Item Type Is Chore, Expense, List
    NSMutableArray *itemAssignedTo = [@[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] mutableCopy];
    
    
    
    
    //Item Type Is Chore or Expense
    NSMutableArray *itemSpecificDueDates = [NSMutableArray array];
    NSString *itemApprovalNeeded = @"No";
    NSMutableDictionary *itemApprovalRequests = [NSMutableDictionary dictionary];
    
    
    
    
    //Item Type Is Chore
    NSString *itemCompletedBy = @"Everyone";
    NSMutableDictionary *itemSubTasks = [NSMutableDictionary dictionary];
    
    
    
    
    //Item Type Is Chore, Expense, List
    NSString *itemUniqueID = chosenItemUniqueID;
    NSString *itemID = chosenItemID;
    NSString *itemHomeID = homeID;
    NSString *itemOccurrenceStatus = @"None";
    NSString *itemCreatedBy = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"];
    NSString *itemDatePosted = chosenItemDatePosted;
    NSString *itemName = itemNameLocal;
    NSString *itemAssignedToNewHomeMembers = @"No";
    NSString *itemAssignedToAnybody = @"No";
    NSString *itemRepeatIfCompletedEarly = @"No";
    NSString *itemRepeats = @"Never";
    NSString *itemDays = @"";
    NSString *itemTime = @"";
    NSMutableArray *itemDueDatesSkipped = [NSMutableArray array];
    NSString *itemDate = itemDueDateLocal;
    NSString *itemDueDate = itemDueDateLocal;
    NSString *itemCompleteAsNeeded = @"No";
    NSMutableDictionary *itemAdditionalReminders = [NSMutableDictionary dictionary];
    NSDictionary *itemReminderDict = [[[GeneralObject alloc] init] GenerateDefaultRemindersDict:@"Chore" itemAssignedTo:itemAssignedTo itemRepeats:itemRepeats homeMembersDict:homeMembersDict AnyTime:NO];
    NSMutableDictionary *itemReward = [@{@"Reward" : @"None", @"RewardDescription" : @"", @"RewardNotes" : @""} mutableCopy];
    NSString *itemDifficulty = @"None";
    NSString *itemPriority = itemPriorityLocal;
    NSString *itemColor = @"None";
    NSString *itemPrivate = @"No";
    NSString *itemImageURL = @"xxx";
    NSString *itemNotes = @"";
    NSString *itemStartDate = [self GenerateItemStartDate];
    NSString *itemEndDate = @"Never";
    NSString *itemEndNumberOfTimes = @"No";
    NSString *itemTakeTurns = @"No";
    NSString *itemGracePeriod = @"None";
    NSString *itemStatus = @"None";
    NSString *itemPastDue = @"2 Days";
    
    NSString *itemTurnUserID = @"";
    NSMutableDictionary *itemCompletedDictLocal = [NSMutableDictionary dictionary];
    
    NSMutableDictionary *itemInProgressDictLocal = [NSMutableDictionary dictionary];
    NSMutableDictionary *itemWontDoLocal = [NSMutableDictionary dictionary];
    NSMutableArray *itemTags = [NSMutableArray array];
    NSString *itemTrash = @"No";
    NSString *itemAddedLocation = @"SettingsViewController";
    
    NSMutableDictionary *setDataDict = [NSMutableDictionary dictionary];
    [setDataDict setObject:@"Chore" forKey:@"ItemType"];
    [setDataDict setObject:itemUniqueID forKey:@"ItemUniqueID"];
    [setDataDict setObject:itemID forKey:@"ItemID"];
    [setDataDict setObject:itemHomeID forKey:@"ItemHomeID"];
    [setDataDict setObject:itemCreatedBy forKey:@"ItemCreatedBy"];
    [setDataDict setObject:itemDatePosted forKey:@"ItemDatePosted"];
    [setDataDict setObject:itemName forKey:@"ItemName"];
    [setDataDict setObject:itemAssignedTo forKey:@"ItemAssignedTo"];
    [setDataDict setObject:itemAssignedToNewHomeMembers forKey:@"ItemAssignedToNewHomeMembers"];
    [setDataDict setObject:itemAssignedToAnybody forKey:@"ItemAssignedToAnybody"];
    [setDataDict setObject:itemDate forKey:@"ItemDate"];
    [setDataDict setObject:itemDueDate forKey:@"ItemDueDate"];
    [setDataDict setObject:itemCompleteAsNeeded forKey:@"ItemCompleteAsNeeded"];
    [setDataDict setObject:itemTime forKey:@"ItemTime"];
    [setDataDict setObject:itemAdditionalReminders forKey:@"ItemAdditionalReminders"];
    [setDataDict setObject:itemReminderDict forKey:@"ItemReminderDict"];
    [setDataDict setObject:itemReward forKey:@"ItemReward"];
    [setDataDict setObject:itemDifficulty forKey:@"ItemDifficulty"];
    [setDataDict setObject:itemPriority forKey:@"ItemPriority"];
    [setDataDict setObject:itemColor forKey:@"ItemColor"];
    [setDataDict setObject:itemPrivate forKey:@"ItemPrivate"];
    [setDataDict setObject:itemImageURL forKey:@"ItemImageURL"];
    [setDataDict setObject:itemNotes forKey:@"ItemNotes"];
    [setDataDict setObject:itemCompletedDictLocal forKey:@"ItemCompletedDict"];
    [setDataDict setObject:itemInProgressDictLocal forKey:@"ItemInProgressDict"];
    [setDataDict setObject:itemWontDoLocal forKey:@"ItemWontDo"];
    [setDataDict setObject:chosenItemOccurrenceID forKey:@"ItemOccurrenceID"];
    [setDataDict setObject:itemOccurrenceStatus forKey:@"ItemOccurrenceStatus"];
    [setDataDict setObject:@{} forKey:@"ItemOccurrencePastDue"];
    [setDataDict setObject:itemDays forKey:@"ItemDays"];
    [setDataDict setObject:itemStartDate forKey:@"ItemStartDate"];
    [setDataDict setObject:itemEndDate forKey:@"ItemEndDate"];
    [setDataDict setObject:itemEndNumberOfTimes forKey:@"ItemEndNumberOfTimes"];
    [setDataDict setObject:itemRepeats forKey:@"ItemRepeats"];
    [setDataDict setObject:itemRepeatIfCompletedEarly forKey:@"ItemRepeatIfCompletedEarly"];
    [setDataDict setObject:itemTakeTurns forKey:@"ItemTakeTurns"];
    [setDataDict setObject:itemGracePeriod forKey:@"ItemGracePeriod"];
    [setDataDict setObject:itemStatus forKey:@"ItemStatus"];
    [setDataDict setObject:itemDueDatesSkipped forKey:@"ItemDueDatesSkipped"];
    [setDataDict setObject:itemPastDue forKey:@"ItemPastDue"];
    [setDataDict setObject:itemTags forKey:@"ItemTags"];
    [setDataDict setObject:@"Never" forKey:@"ItemSelfDestruct"];
    [setDataDict setObject:@"0 Minutes" forKey:@"ItemEstimatedTime"];
    [setDataDict setObject:itemTrash forKey:@"ItemTrash"];
    [setDataDict setObject:itemTurnUserID forKey:@"ItemTurnUserID"];
    [setDataDict setObject:@"Never" forKey:@"ItemScheduledStart"];
    [setDataDict setObject:@"No" forKey:@"ItemPhotoConfirmation"];
    [setDataDict setObject:[NSMutableDictionary dictionary] forKey:@"ItemPhotoConfirmationDict"];
    [setDataDict setObject:itemAddedLocation forKey:@"ItemAddedLocation"];
    
    [setDataDict setObject:itemSpecificDueDates forKey:@"ItemSpecificDueDates"];
    [setDataDict setObject:itemApprovalNeeded forKey:@"ItemApprovalNeeded"];
    [setDataDict setObject:itemApprovalRequests forKey:@"ItemApprovalRequests"];
    
    [setDataDict setObject:itemCompletedBy forKey:@"ItemMustComplete"];
    [setDataDict setObject:itemSubTasks forKey:@"ItemSubTasks"];
    
    return [setDataDict copy];
}

#pragma mark Delete Account Methods

-(void)DeleteAccount_DeleteAllUserData:(void (^)(BOOL finished))finishBlock {
    
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
    NSString *userEmail = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersEmail"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersEmail"] : @"xxx";
    NSString *mixPanelID = [[NSUserDefaults standardUserDefaults] objectForKey:@"MixPanelID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"MixPanelID"] : @"xxx";
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[SettingsObject alloc] init] DeleteAllUserInfo:userID userEmail:userEmail mixPanelID:mixPanelID completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)DeleteAccount_UpdateWeDivvyPremiumGivenBy:(void (^)(BOOL finished))finishBlock {
    
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[SetDataObject alloc] init] UpdateDataWeDivvyPremiumRemoveSubscriptionForGivenByUsers:userID homeMembersDict:self->homeMembersDict completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull homeMembersDict) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)DeleteAccount_CompletionBlock:(int)totalQueries completedQueries:(int)completedQueries {
    
    if (totalQueries == completedQueries) {
        
        [[[GeneralObject alloc] init] AllGenerateTokenMethod:@"AllHomeTopics" Subscribe:NO GrantedNotifications:NO];
        
        [[[SceneDelegate alloc] init] SetUpShortcutIcons];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
            
        });
        
        [[[PushObject alloc] init] PushToInitialNavigationController:self];
        
    }
    
}

#pragma mark - IAP Methods

- (BOOL)CanMakePurchases {
    
    return [SKPaymentQueue canMakePayments];
    
}

-(void)FetchAvailableProducts {
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"PremiumPlanProductsArray"] || ![[NSUserDefaults standardUserDefaults] objectForKey:@"PremiumPlanPricesDict"]) {
        
        if ([self CanMakePurchases]) {
            
            //NSLog(@"Subscription - products fetchAvailableProducts");
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
  
    //NSLog(@"Subscription - How many products retrieved? %lu", (unsigned long)count);
    
    [[[GeneralObject alloc] init] GenerateProducts:response.products completionHandler:^(BOOL finished, NSString * _Nonnull errorString, NSMutableArray * _Nonnull returningPremiumPlanProductsArray, NSMutableDictionary * _Nonnull returningPremiumPlanPricesDict, NSMutableDictionary * _Nonnull returningPremiumPlanExpensivePricesDict, NSMutableDictionary * _Nonnull returningPremiumPlanPricesDiscountDict, NSMutableDictionary * _Nonnull returningPremiumPlanPricesNoFreeTrialDict) {
        
        self->premiumPlanProductsArray = [returningPremiumPlanProductsArray mutableCopy];
        self->premiumPlanPricesDict = [returningPremiumPlanPricesDict mutableCopy];
        self->premiumPlanExpensivePricesDict = [returningPremiumPlanExpensivePricesDict mutableCopy];
        self->premiumPlanPricesDiscountDict = [returningPremiumPlanPricesDiscountDict mutableCopy];
        self->premiumPlanPricesNoFreeTrialDict = [returningPremiumPlanPricesNoFreeTrialDict mutableCopy];
        
    }];
    
}

@end
