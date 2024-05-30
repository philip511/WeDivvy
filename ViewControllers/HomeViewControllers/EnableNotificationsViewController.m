//
//  EnableNotificationsViewController.m
//  WeDivvy
//
//  Created by Philip Nagel on 11/10/21.
//

#import "EnableNotificationsViewController.h"

#import "GeneralObject.h"
#import "GetDataObject.h"
#import "SetDataObject.h"
#import "PushObject.h"
#import "HomesViewControllerObject.h"
#import "NotificationsObject.h"
#import "BoolDataObject.h"
#import "LightDarkModeObject.h"

#import <MRProgress/MRProgress.h>
    
@interface EnableNotificationsViewController () {
    
    MRProgressOverlayView *progressView;
    
    NSMutableDictionary *topicDict;
    
    NSMutableDictionary *premiumPlanPricesDict;
    NSMutableDictionary *premiumPlanExpensivePricesDict;
    NSMutableDictionary *premiumPlanPricesDiscountDict;
    NSMutableDictionary *premiumPlanPricesNoFreeTrialDict;
    NSMutableArray *premiumPlanProductsArray;
    
}

@end

@implementation EnableNotificationsViewController

#pragma mark - System Methods

- (void)viewDidLoad {
    [super viewDidLoad];

    [self InitMethod];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        return UIStatusBarStyleLightContent;
        
    } else {
        
        return UIStatusBarStyleDefault;
        
    }
 
}

-(void)viewWillAppear:(BOOL)animated {
    
    _enableNotificationsButton.backgroundColor = [[[GeneralObject alloc] init] GenerateAppColor:1.0f];
    
}

-(void)viewWillLayoutSubviews {
    
    CGFloat bottomPadding = [[[GeneralObject alloc] init] GetBottomPaddingHeight];
    
    CGFloat height = CGRectGetHeight(self.view.bounds);
    CGFloat width = CGRectGetWidth(self.view.bounds);
    
    _mainImage.frame = CGRectMake(0, height*0.32608696, width, height*0.20380435);
    
    _titleLabel.frame = CGRectMake(width*0.5 -((width*0.5821256)*0.5), _mainImage.frame.origin.y + _mainImage.frame.size.height + (height*0.02717391), width*0.5821256, height*0.05298913);
    _subTitleLabel.frame = CGRectMake(width*0.5 - ((width*0.69565217)*0.5), _titleLabel.frame.origin.y + _titleLabel.frame.size.height + (height*0.01630435), width*0.69565217, height*0.05027174);

    _titleLabel.font = [UIFont systemFontOfSize:(_titleLabel.frame.size.height*0.4 > 16?(16):_titleLabel.frame.size.height*0.4) weight:UIFontWeightSemibold];
    _subTitleLabel.font = [UIFont systemFontOfSize:(_subTitleLabel.frame.size.height*0.4 > 15?(15):_subTitleLabel.frame.size.height*0.4) weight:UIFontWeightMedium];
    
    _maybeLabelButton.frame = CGRectMake(0, height - (self.view.frame.size.height*0.03532609 > 26?(26):self.view.frame.size.height*0.03532609) - (height*0.02717391) - bottomPadding, width, (self.view.frame.size.height*0.03532609 > 26?(26):self.view.frame.size.height*0.03532609));
    _maybeLabelButton.titleLabel.font = [UIFont systemFontOfSize:_maybeLabelButton.frame.size.height*0.53846 weight:UIFontWeightMedium];
    _enableNotificationsButton.frame = CGRectMake(width*0.5 - (width*0.90)*0.5, height - (height - _maybeLabelButton.frame.origin.y) - (self.view.frame.size.height*0.067934 > 50?(50):self.view.frame.size.height*0.067934) - (height*0.02309783), width*0.90, (self.view.frame.size.height*0.067934 > 50?(50):self.view.frame.size.height*0.067934));
    _enableNotificationsButton.titleLabel.font = [UIFont systemFontOfSize:_enableNotificationsButton.frame.size.height*0.32 weight:UIFontWeightSemibold];
    _enableNotificationsButton.layer.cornerRadius = 7;
 
    _subTitleLabel.textColor = _maybeLabelButton.titleLabel.textColor;
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        self.view.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        self.titleLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        self.subTitleLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextSecondary];
        self.maybeLabelButton.titleLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextSecondary];
        
        [self preferredStatusBarStyle];
        
    }
    
}

#pragma mark - Init Methods

-(void)InitMethod {
    
    [self SetUpAnalytics];
    
    [self SetUpIAPProducts];
    
    [self SetUpDicts];
  
}

#pragma mark - SetUp Methods

-(void)SetUpAnalytics {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewViewController:@"EnableNotificationsViewController" completionHandler:^(BOOL finished) {
        
    }];
    
}

-(void)SetUpIAPProducts {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self FetchAvailableProducts];
        
    });
    
}

-(void)SetUpDicts {
    
    topicDict = [NSMutableDictionary dictionary];
 
}

#pragma mark - UI Methods

-(void)StartProgressView {
    
    self->progressView = [MRProgressOverlayView showOverlayAddedTo:self.navigationController.view animated:YES];
    self->progressView.mode = MRProgressOverlayViewModeIndeterminateSmall;
    
}

#pragma mark - IBAction Methods

-(IBAction)NavigationBackButtonAction:(UIBarButtonItem *)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Navigation Back Button Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(IBAction)EnableNotifications:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Enable Notifications Clicked"] completionHandler:^(BOOL finished) {
        
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
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [[UIApplication sharedApplication] registerForRemoteNotifications];
                
            });
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Granted Notifications"] completionHandler:^(BOOL finished) {
                
            }];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [[FIRCrashlytics crashlytics] logWithFormat:@"GenerateTwoWeekReminderNotification EnableNotifications"];
                
                [[[NotificationsObject alloc] init] RemoveLocalInactiveNotification];
                [[[NotificationsObject alloc] init] GenerateTwoWeekReminderNotification];
                
                [self EnableNotifications_CompletionBlock:YES];
                
            });
            
        } else {

            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Not Granted Notifications"] completionHandler:^(BOOL finished) {
                
            }];
            
            [self EnableNotifications_CompletionBlock:NO];
            
        }

    }];
    
}

-(IBAction)MaybeLabel:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Maybe Later Clicked"] completionHandler:^(BOOL finished) {
        
    }];

    [self EnableNotifications_CompletionBlock:NO];
    
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Internal Methods
#pragma mark
#pragma mark
#pragma mark -

-(void)EnableNotifications_CompletionBlock:(BOOL)enabledNotifications {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (self->_comingFromCreateHome == YES) {
            
            [[[PushObject alloc] init] PushToHomeFeaturesViewController:self comingFromSettings:NO];
            
        } else {
            
            [self StartProgressView];
            
            [[[HomesViewControllerObject alloc] init] JoinHome:self->_homeIDLinkedToKey homeKey:self->_homeKey topicDict:self->topicDict clickedUnclaimedUser:self->_clickedUnclaimedUser enabledNotifications:enabledNotifications currentViewController:self completionHandler:^(BOOL finished) {
                
                [self->progressView setHidden:YES];
                
            }];
            
        }
        
    });
    
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
