//
//  BillingViewController.m
//  WeDivvy
//
//  Created by Philip Nagel on 3/11/22.
//

#import "BillingViewController.h"

#import <MRProgressOverlayView.h>

#import "GeneralObject.h"
#import "GetDataObject.h"
#import "SetDataObject.h"
#import "BoolDataObject.h"
#import "NotificationsObject.h"
#import "PushObject.h"
#import "LightDarkModeObject.h"

@interface BillingViewController () {
    
    MRProgressOverlayView *progressView;
    
    NSMutableDictionary *homeMembersDict;
    
}

@end

@implementation BillingViewController

#pragma mark - System Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self InitMethod];
    
}

-(void)viewDidLayoutSubviews {
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    CGFloat navigationBarHeight = self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.frame.size.height;
    
    self->_subscriptionTypeTopLabel.frame = CGRectMake(15, navigationBarHeight + 8, width*1 - 30, 15);
    self->_subscriptionTypeView.frame = CGRectMake(0, _subscriptionTypeTopLabel.frame.origin.y + _subscriptionTypeTopLabel.frame.size.height + 8, width*1, 44);
    self->_subscriptionStartDateTopLabel.frame = CGRectMake(15, _subscriptionTypeView.frame.origin.y + _subscriptionTypeView.frame.size.height + 8, width*1 - 30, 15);
    self->_subscriptionStartDateView.frame = CGRectMake(0, _subscriptionStartDateTopLabel.frame.origin.y + _subscriptionStartDateTopLabel.frame.size.height + 8, width*1, 44);
    
    _subscriptionTypeLabel.frame = CGRectMake(20, 0, width*1 - 40, 45);
    _subscriptionStartDateLabel.frame = CGRectMake(20, 0, width*1 - 40, 45);
    
    CGFloat textFieldSpacing = (height*0.024456);
    
    self->_cancelSubscriptionButton.frame = CGRectMake(0, _subscriptionStartDateView.frame.origin.y + _subscriptionStartDateView.frame.size.height + textFieldSpacing, width, (self.view.frame.size.height*0.06793478 > 50?50:(self.view.frame.size.height*0.06793478)));
    
    UIFont *fontSize = [UIFont systemFontOfSize:(self.view.frame.size.height*0.02173813 > 16?16:(self.view.frame.size.height*0.02173813)) weight:UIFontWeightRegular];
    _cancelSubscriptionButton.titleLabel.font = fontSize;
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        self.view.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        self.subscriptionStartDateView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeTertiary];
        self.emailTextField.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        self.subscriptionStartDateLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        self.subscriptionTypeView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeTertiary];
        self.subscriptionTypeLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        self.subscriptionTypeTopLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        self.subscriptionStartDateTopLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        self.cancelSubscriptionButton.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeTertiary];
        
        [self preferredStatusBarStyle];
        
        UIWindow *currentwindow = [UIApplication sharedApplication].windows.firstObject;
        UIView *statusBar = [[UIView alloc]initWithFrame:currentwindow.windowScene.statusBarManager.statusBarFrame] ;
        statusBar.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        [currentwindow addSubview:statusBar];
        
    }
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        return UIStatusBarStyleLightContent;
        
    } else {
        
        return UIStatusBarStyleDefault;
        
    }
 
}

#pragma mark - Init Methods

-(void)InitMethod {
    
    [self SetUpSendMessageContextMenu];
    
    [self SetUpTextFieldData];
    
}

#pragma mark - SetUp Methods

-(void)SetUpSendMessageContextMenu {
    
    NSMutableArray* actions = [[NSMutableArray alloc] init];
  
    NSMutableArray* otherOptionsMenuActions = [[NSMutableArray alloc] init];
    
    [otherOptionsMenuActions addObject:[UIAction actionWithTitle:@"Live Chat" image:[UIImage systemImageNamed:@"ellipsis.bubble"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Live Chat Clicked"] completionHandler:^(BOOL finished) {
            
        }];
        
        [self SendChat];
        
    }]];
    
    [otherOptionsMenuActions addObject:[UIAction actionWithTitle:@"Email" image:[UIImage systemImageNamed:@"envelope"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Email Clicked"] completionHandler:^(BOOL finished) {
            
        }];
        
        [self SendEmail];
        
    }]];
    
    UIMenu *otherOptionsMenu = [UIMenu menuWithTitle:@"Let us know why you'd like to cancel" image:nil identifier:@"" options:UIMenuOptionsDisplayInline children:otherOptionsMenuActions];
    [actions addObject:otherOptionsMenu];
    
    NSMutableArray *cancelSubscriptionMenuActions = [NSMutableArray array];
    
    UIAction *cancelSubscriptionAction = [UIAction actionWithTitle:@"Cancel Subscription" image:[UIImage systemImageNamed:@"trash"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Email Clicked"] completionHandler:^(BOOL finished) {
            
        }];
        
        [self CancelSubscription:self];
        
    }];
    
    [cancelSubscriptionAction setAttributes:UIMenuElementAttributesDestructive];
    [cancelSubscriptionMenuActions addObject:cancelSubscriptionAction];
    
    UIMenu *cancelSubscriptionMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"" options:UIMenuOptionsDisplayInline children:cancelSubscriptionMenuActions];
    [actions addObject:cancelSubscriptionMenu];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self->_cancelSubscriptionButton.menu = [UIMenu menuWithTitle:@"" children:actions];
        self->_cancelSubscriptionButton.showsMenuAsPrimaryAction = true;
        
    });
    
}

-(void)SetUpTextFieldData {
    
    homeMembersDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeMembersDict"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"HomeMembersDict"] mutableCopy] : [NSMutableDictionary dictionary];
    
    NSUInteger index = [homeMembersDict[@"UserID"] indexOfObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
    
    NSString *subscriptionFrequency =
    homeMembersDict[@"WeDivvyPremium"] &&
    [(NSArray *)homeMembersDict[@"WeDivvyPremium"] count] > index &&
    homeMembersDict[@"WeDivvyPremium"][index][@"SubscriptionFrequency"] ?
    homeMembersDict[@"WeDivvyPremium"][index][@"SubscriptionFrequency"] : @"";
    
    self->_subscriptionTypeLabel.text = subscriptionFrequency;
    
    NSString *subscriptionStartDate =
    homeMembersDict[@"WeDivvyPremium"] &&
    [(NSArray *)homeMembersDict[@"WeDivvyPremium"] count] > index &&
    homeMembersDict[@"WeDivvyPremium"][index][@"SubscriptionDatePurchased"] ?
    homeMembersDict[@"WeDivvyPremium"][index][@"SubscriptionDatePurchased"] : @"";
    
    subscriptionStartDate = [[[GeneralObject alloc] init] GenerateDateWithConvertedFormatWithFormat:@"yyyy-MM-dd HH:mm:ss" dateToConvert:subscriptionStartDate newFormat:@"MMMM dd, yyyy hh:mm a" returnAs:[NSString class]];
    
    self->_subscriptionStartDateLabel.text = subscriptionStartDate;
    
}

#pragma mark - Custom Menu Actions

-(void)SendChat {
    
    BOOL UserIsAppCreator = [[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] isEqualToString:@"2021-08-24 23:51:563280984"];
    
    if (UserIsAppCreator == NO) {
        
        [self StartProgressView];
        
        BOOL UserNeverStartedLiveChat = [[NSUserDefaults standardUserDefaults] objectForKey:@"StartedLiveChat"];
        
        if (UserNeverStartedLiveChat == YES) {
            
            [self UserStartedLiveSupportChat];
            
        } else {
            
            [self UserOpennedExistingLiveSupportChat];
            
        }
        
    } else {
        
        [self UserOpennedMasterLiveChat];
        
    }
    
}

-(void)SendEmail {
    
    if([MFMailComposeViewController canSendMail]) {
        
        MFMailComposeViewController *mailCont = [[MFMailComposeViewController alloc] init];
        mailCont.mailComposeDelegate = self;
        
        [mailCont setSubject:[NSString stringWithFormat:@"WeDivvy Premium Cancel Subscription: %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"]]];
        [mailCont setToRecipients:[NSArray arrayWithObjects:@"wedivvy@wedivvyapp.com", nil]];
        [mailCont setMessageBody:@"" isHTML:NO];
        mailCont.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:mailCont animated:YES completion:nil];
        
    } else {
        
        [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"This iPhone is not capable of sending emails" currentViewController:self];
        
    }
    
}

#pragma mark - Custom Methods

-(void)StartProgressView {
    
    self->progressView = [MRProgressOverlayView showOverlayAddedTo:self.navigationController.view animated:YES];
    self->progressView.mode = MRProgressOverlayViewModeIndeterminateSmall;
    
}

#pragma mark - IBAction Methods

-(IBAction)CancelSubscription:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://apps.apple.com/account/subscriptions"] options:@{} completionHandler:nil];
    
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Internal Methods
#pragma mark
#pragma mark
#pragma mark -

-(void)UserStartedLiveSupportChat {
    
    [[[NotificationsObject alloc] init] SendPushNotificationToCreator:[NSString stringWithFormat:@"%@ - New Support Chat", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] notificationBody:@"" badgeNumber:(NSInteger *)1 completionHandler:^(BOOL finished) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"StartedLiveChat"];
            
            [self->progressView setHidden:YES];
            
            [[[PushObject alloc] init] PushToLiveChatViewControllerFromSettingsPage:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] viewingLiveSupport:YES currentViewController:self Superficial:NO];
            
        });
        
    }];
    
}

-(void)UserOpennedExistingLiveSupportChat {
    
    [[[NotificationsObject alloc] init] SendPushNotificationToCreator:[NSString stringWithFormat:@"%@ - Existing Support Chat", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] notificationBody:@"" badgeNumber:(NSInteger *)1 completionHandler:^(BOOL finished) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self->progressView setHidden:YES];
            
            [[[PushObject alloc] init] PushToLiveChatViewControllerFromSettingsPage:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] viewingLiveSupport:YES currentViewController:self Superficial:NO];
            
        });
        
    }];
    
}

-(void)UserOpennedMasterLiveChat {
    
    [self->progressView setHidden:YES];
    
    [[[PushObject alloc] init] PushToMasterLiveChatViewController:self];
    
}

@end
