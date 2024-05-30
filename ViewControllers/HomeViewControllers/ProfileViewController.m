//
//  ProfileViewController.m
//  RoommateApp
//
//  Created by Philip Nagel on 5/20/21.
//

#import "UIImageView+Letters.h"

#import "ProfileViewController.h"
#import "AppDelegate.h"

#import <SDWebImage/SDWebImage.h>
#import <MRProgress/MRProgress.h>

#import "GeneralObject.h"
#import "GetDataObject.h"
#import "SetDataObject.h"
#import "DeleteDataObject.h"
#import "PushObject.h"
#import "HomesViewControllerObject.h"
#import "BoolDataObject.h"
#import "LightDarkModeObject.h"

@interface ProfileViewController () {
    
    MRProgressOverlayView *progressView;

    BOOL userIsBlocked;
    
}

@end

@implementation ProfileViewController

#pragma mark - System Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self InitMethod];
    
    [self BarButtonItems];
    
    [self NSNotificationObservers];
  
    [[[GetDataObject alloc] init] GetDataProfileUser:_otherUsersUserID completionHandler:^(BOOL finished, NSString * _Nonnull username, NSString * _Nonnull userProfileImageURL) {
        
        [self Profile_CompletionBlock:username userProfileImageURL:userProfileImageURL];
        
    }];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        return UIStatusBarStyleLightContent;
        
    } else {
        
        return UIStatusBarStyleDefault;
        
    }
 
}

-(void)viewDidLayoutSubviews {
 
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    
    CGFloat width = CGRectGetWidth(self.view.bounds);

    CGFloat navigationBarHeight = [[[GeneralObject alloc] init] GetNavigationBarHeight:self];
    
    _profileImage.frame = CGRectMake((width*0.5) - 50, navigationBarHeight + 30, 100, 100);
    _usernameLabel.frame =  CGRectMake(0, _profileImage.frame.origin.y + _profileImage.frame.size.height + 15, width*1, 45);

    _profileImage.layer.cornerRadius = _profileImage.frame.size.height/2;
    _profileImage.clipsToBounds = YES;
    _profileImage.contentMode = UIViewContentModeScaleAspectFill;
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        self.view.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        //self.usernameLabel.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModePrimary];
        self.usernameLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        
        [self preferredStatusBarStyle];
        
    } else {
        
        self.view.backgroundColor = [[[LightDarkModeObject alloc] init] LightModePrimary];
        //self.usernameLabel.backgroundColor = [[[LightDarkModeObject alloc] init] LightModeSecondary];
        self.usernameLabel.textColor = [[[LightDarkModeObject alloc] init] LightModeTextPrimary];
        
        [self preferredStatusBarStyle];
        
    }
    
}

#pragma mark - Init Methods

-(void)InitMethod {

    [self SetUpAnalytics];

    [self SetUpLabel];
    
}

-(void)BarButtonItems {
    
    UIBarButtonItem *barButtonItem;
    
    barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close"
                                  style:UIBarButtonItemStyleDone
                                 target:self
                                 action:@selector(CloseButtonAction:)];
   
    self.navigationItem.leftBarButtonItem = barButtonItem;
    
    if ([_otherUsersUserID isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]]) {
    
        barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings"
                                      style:UIBarButtonItemStyleDone
                                     target:self
                                     action:@selector(SettingsPageAction:)];
       
        self.navigationItem.rightBarButtonItem = barButtonItem;
    
    }
    
}

-(void)NSNotificationObservers {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_Profile_ReloadView" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_Profile_ReloadView:) name:@"NSNotification_Profile_ReloadView" object:nil];
    
}

#pragma mark - Setup Methods

-(void)SetUpAnalytics {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewViewController:@"ProfileViewController" completionHandler:^(BOOL finished) {
        
    }];
    
}

-(void)SetUpLabel {
    
    _usernameLabel.backgroundColor = [UIColor clearColor];
    _usernameLabel.font = [UIFont systemFontOfSize:(self.view.frame.size.height*0.02853261 > 21?21:(self.view.frame.size.height*0.02853261)) weight:UIFontWeightMedium];
    
}

#pragma mark - UI Methods

-(void)StartProgressView {
    
    self->progressView = [MRProgressOverlayView showOverlayAddedTo:self.navigationController.view animated:YES];
    self->progressView.mode = MRProgressOverlayViewModeIndeterminateSmall;
    
}

#pragma mark - UX Methods

-(void)Profile_CompletionBlock:(NSString *)username userProfileImageURL:(NSString *)userProfileImageURL {
    
    self->_usernameLabel.text = username;
    
    NSString *profileImageURL = userProfileImageURL;
    
    UIColor *backgroundColor = [[[GeneralObject alloc] init] GenerateAppColor:0.15f];
    UIColor *textColor = [[[GeneralObject alloc] init] GenerateAppColor:1.0f];
    
    if (profileImageURL == nil || profileImageURL.length == 0 || [profileImageURL containsString:@"(null)"] || [profileImageURL isEqualToString:@"xxx"] || [profileImageURL isEqualToString:@"XXX"] || [profileImageURL isEqualToString:@"https://firebasestorage.googleapis.com/v0/b/wedivvy-afe04.appspot.com/o/DefaultImages%2FdefaultProfileImage.png?alt=media&token=6892f430-8337-4327-89a4-53a403d1186c"] || [profileImageURL containsString:@"DefaultImage"]) {
        
        [self->_profileImage setImageWithString:username color:backgroundColor circular:YES textAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Futura-Medium" size:self->_profileImage.frame.size.height*0.45], NSForegroundColorAttributeName:textColor}];
        
    } else {
        
        [self->_profileImage sd_setImageWithURL:[NSURL URLWithString:profileImageURL]];
        
    }
    
    [self->progressView setHidden:YES];
    
}

#pragma mark - IBAction Methods

-(IBAction)CloseButtonAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Close Button Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(IBAction)SettingsPageAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Settings Page Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    [[[PushObject alloc] init] PushToSettingsViewController:NO allItemAssignedToArrays:nil currentViewController:self];
    
}

#pragma mark - NSNotification Methods

-(void)NSNotification_Profile_ReloadView:(NSNotification *)notification {
  
    NSDictionary *userInfo = notification.userInfo;
    
    NSString *username = userInfo[@"Username"];
    NSString *userProfileImageURL = userInfo[@"ProfileImageURL"];
    
    [self Profile_CompletionBlock:username userProfileImageURL:userProfileImageURL];
    
}

@end
