//
//  HomeMembersViewController.m
//  RoommateApp
//
//  Created by Philip Nagel on 5/27/21.
//

#import "UIImageView+Letters.h"

#import "HomeMembersViewController.h"
#import "AppDelegate.h"

#import "HomeMemberCell.h"

#import <SDWebImage/SDWebImage.h>
#import <MRProgressOverlayView.h>
#import <Mixpanel/Mixpanel.h>

#import "GeneralObject.h"
#import "GetDataObject.h"
#import "SetDataObject.h"
#import "DeleteDataObject.h"
#import "PushObject.h"
#import "NotificationsObject.h"
#import "HomesViewControllerObject.h"
#import "BoolDataObject.h"
#import "LightDarkModeObject.h"
#import "SettingsObject.h"

#import "AlertView.h"

@interface HomeMembersViewController () {
    
    AlertView *alertView;
    
    MRProgressOverlayView *progressView;
    UIActivityIndicatorView *activityControl;
    UIRefreshControl *refreshControl;
    
    NSMutableDictionary *homeDict;
    NSMutableDictionary *homeMembersDict;
    NSMutableDictionary *unclaimedHomeMembersUserDict;
    NSMutableArray *sectionsArray;
    NSMutableDictionary *lastHomeMemberAddedUserDict;
    
    NSMutableDictionary *folderDict;
    NSMutableDictionary *taskListDict;
    NSMutableDictionary *sectionDict;
    NSMutableDictionary *templateDict;
    
    NSMutableArray *premiumPlanProductsArray;
    NSMutableDictionary *premiumPlanPricesDict;
    NSMutableDictionary *premiumPlanExpensivePricesDict;
    NSMutableDictionary *premiumPlanPricesDiscountDict;
    NSMutableDictionary *premiumPlanPricesNoFreeTrialDict;
    
    int cellHeight;
    int unclaimedCellHeight;
    
    NSManagedObjectContext *managedObjectContext;
    
}

@end

@implementation HomeMembersViewController

#pragma mark - System Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    managedObjectContext = [[[AppDelegate alloc] init] managedObjectContext];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self FetchAvailableProducts];
        
    });
    
    [self InitMethod];
    
    [self BarButtonItems];
    
    [self TapGestures];
    
    [self QueryInitialData];
    
    //Post-Spike
    _hasAndroidButton.hidden = NO;
   
}

-(void)viewDidLayoutSubviews {
    
    cellHeight = (self.view.frame.size.height*0.07744565 > 57?(57):self.view.frame.size.height*0.07744565);
    unclaimedCellHeight = (self.view.frame.size.height*0.10326087 > 76?(76):self.view.frame.size.height*0.10326087);
    
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    CGFloat bottomPadding = [[[GeneralObject alloc] init] GetBottomPaddingHeight];
    
    _multipleHomesImage.frame = CGRectMake(width - width*0.05434783 - width*0.04830918, 0, width*0.05434783, self.navigationController.navigationBar.frame.size.height);
    _moveOutImage.frame = CGRectMake(_multipleHomesImage.frame.origin.x - (width*0.05434783)*0.75 - (width*0.03), 0, (width*0.05434783)*0.75, self.navigationController.navigationBar.frame.size.height);
    _homeKeyImage.frame = CGRectMake(_moveOutImage.frame.origin.x - (width*0.05434783)*0.8 - (width*0.03), 0, (width*0.05434783)*0.8, self.navigationController.navigationBar.frame.size.height);
    
    UIWindow *currentwindow = [UIApplication sharedApplication].windows.firstObject;
    
    [currentwindow addSubview:_multipleHomesImage];
    [currentwindow addSubview:_moveOutImage];
    [currentwindow addSubview:_homeKeyImage];
    
    [self.navigationController.navigationBar addSubview:_multipleHomesImage];
    [self.navigationController.navigationBar addSubview:_moveOutImage];
    [self.navigationController.navigationBar addSubview:_homeKeyImage];
    
    _homeKeyImage.hidden = YES;
    _homeKeyImage.userInteractionEnabled = NO;
    
    self->_addHomeMemberButton.frame = CGRectMake(width*0.5 - (width*0.90338164)*0.5, _customTableView.frame.origin.y + _customTableView.frame.size.height, width*0.90338164, self.view.frame.size.height*0.067934 > 50?(50):self.view.frame.size.height*0.067934);
    self->_addHomeMemberButton.titleLabel.font = [UIFont systemFontOfSize:((_addHomeMemberButton.frame.size.height*0.34) > 17?(17):(_addHomeMemberButton.frame.size.height*0.34)) weight:UIFontWeightMedium];
    
    CGFloat cornerRadius = (self.view.frame.size.height*0.2181818182 > 12?12:(self.view.frame.size.height*0.2181818182));
    [[[GeneralObject alloc] init] RoundingCorners:_customTableView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
    [[[GeneralObject alloc] init] RoundingCorners:self->_addHomeMemberButton topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
    
    _tellAFriendButton.frame = CGRectMake(0, height - 16 - 20 - bottomPadding*0.5, width, 16);
    _tellAFriendButton.titleLabel.font = [UIFont systemFontOfSize:(self.view.frame.size.height*0.01902174 > 14?(14):self.view.frame.size.height*0.01902174) weight:UIFontWeightSemibold];
    _tellAFriendButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    _hasAndroidButton.frame = CGRectMake(0, self->_addHomeMemberButton.frame.origin.y + self->_addHomeMemberButton.frame.size.height + 20, width, 32);
    _hasAndroidButton.titleLabel.numberOfLines = 0;
    _hasAndroidButton.titleLabel.font = [UIFont systemFontOfSize:(self.view.frame.size.height*0.01902174 > 14?(14):self.view.frame.size.height*0.01902174) weight:UIFontWeightSemibold];
    _hasAndroidButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [_hasAndroidButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    activityControl.frame = CGRectMake((self.view.frame.size.width*0.5)-(12.5), (self.view.frame.size.height*0.5) - (12.5), 25, 25);
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    _addHomeMemberButton.backgroundColor = [[[GeneralObject alloc] init] GenerateAppColor:1.0f];
    _inviteReminderAlertViewSubmitButton.backgroundColor = [[[GeneralObject alloc] init] GenerateAppColor:1.0f];
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    _inviteReminderBackDropView.frame = CGRectMake(0, 0, width, height);
    _inviteReminderBackDropView.alpha = 0.0;
    
    _inviteHomeMemberBackDropView.frame = CGRectMake(0, 0, width, height);
    _inviteHomeMemberBackDropView.alpha = 0.0;
    
    _inviteReminderAlertView.frame = CGRectMake(0, height, width, ((height*0.271739123) > 200?(200):(height*0.271739123)));
    _inviteHomeMemberAlertView.frame = CGRectMake(0, height, width, ((height*0.33967391) > 250?(250):(height*0.33967391)));
    //278
    
    UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:self.inviteReminderAlertView.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight) cornerRadii:CGSizeMake(_inviteReminderAlertView.frame.size.height*0.15, _inviteReminderAlertView.frame.size.height*0.15)];
    
    CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
    maskLayer1.frame = self.inviteReminderAlertView.bounds;
    maskLayer1.path  = maskPath1.CGPath;
    self.inviteReminderAlertView.layer.mask = maskLayer1;
    
    maskPath1 = [UIBezierPath bezierPathWithRoundedRect:self.inviteHomeMemberAlertView.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight) cornerRadii:CGSizeMake(_inviteHomeMemberAlertView.frame.size.height*0.15, _inviteHomeMemberAlertView.frame.size.height*0.15)];
    
    maskLayer1 = [[CAShapeLayer alloc] init];
    maskLayer1.frame = self.inviteHomeMemberAlertView.bounds;
    maskLayer1.path  = maskPath1.CGPath;
    self.inviteHomeMemberAlertView.layer.mask = maskLayer1;
    
    
    
    width = CGRectGetWidth(self.inviteReminderAlertView.bounds);
    height = CGRectGetHeight(self.inviteReminderAlertView.bounds);
    
    _inviteReminderAlertViewXIcon.frame = CGRectMake(width - ((height*0.1) > 20?(20):(height*0.1)) - height*0.1, height*0.1, ((height*0.1) > 20?(20):(height*0.1)), ((height*0.1) > 20?(20):(height*0.1)));
    
    _inviteReminderAlertViewXIconCover.frame = CGRectMake(_inviteReminderAlertViewXIcon.frame.origin.x - height*0.1, _inviteReminderAlertViewXIcon.frame.origin.y - height*0.1, _inviteReminderAlertViewXIcon.frame.size.width + ((height*0.1)*2), _inviteReminderAlertViewXIcon.frame.size.height + ((height*0.1)*2));
    
    _inviteReminderAlertViewTitleLabel.frame = CGRectMake((width - _inviteReminderAlertViewXIcon.frame.origin.x) + height*0.05, height*0.1, width - (((width -_inviteReminderAlertViewXIcon.frame.origin.x))*2) - height*0.1, ((height*0.1) > 20?(20):(height*0.1)));
    _inviteReminderAlertViewTitleLabel.font = [UIFont systemFontOfSize:_inviteReminderAlertViewTitleLabel.frame.size.height*0.9 weight:UIFontWeightHeavy];
    
    _inviteReminderAlertViewSubTitleLabel.frame = CGRectMake(height*0.1, height*0.385, width - ((height*0.1)*2), ((height*0.1) > 20?(20):(height*0.1)));
    _inviteReminderAlertViewSubTitleLabel.font = [UIFont systemFontOfSize:_inviteReminderAlertViewSubTitleLabel.frame.size.height*0.71 weight:UIFontWeightHeavy];
    
    _inviteReminderAlertViewSubmitButton.frame = CGRectMake(width*0.5 - ((width - ((width*0.09661836)*2))*0.5), height - ((height*0.2375) > 47.5?(47.5):(height*0.2375)) - height*0.1, width - ((width*0.09661836)*2), ((height*0.2375) > 47.5?(47.5):(height*0.2375)));
    _inviteReminderAlertViewSubmitButton.titleLabel.font = [UIFont systemFontOfSize:((_inviteReminderAlertViewSubmitButton.frame.size.height*0.31578947) > 15?(15):(_inviteReminderAlertViewSubmitButton.frame.size.height*0.31578947)) weight:UIFontWeightSemibold];
    _inviteReminderAlertViewSubmitButton.clipsToBounds = YES;
    _inviteReminderAlertViewSubmitButton.layer.cornerRadius = 7;
    
    width = CGRectGetWidth(self.inviteHomeMemberAlertView.bounds);
    height = CGRectGetHeight(self.inviteHomeMemberAlertView.bounds);
    
    _inviteHomeMemberAlertViewXIcon.frame = CGRectMake(width - ((height*0.1) > 20?(20):(height*0.1)) - height*0.1, height*0.1, ((height*0.1) > 20?(20):(height*0.1)), ((height*0.1) > 20?(20):(height*0.1)));
    
    _inviteHomeMemberAlertViewXIconCover.frame = CGRectMake(_inviteHomeMemberAlertViewXIcon.frame.origin.x - height*0.1, _inviteHomeMemberAlertViewXIcon.frame.origin.y - height*0.1, _inviteHomeMemberAlertViewXIcon.frame.size.width + ((height*0.1)*2), _inviteHomeMemberAlertViewXIcon.frame.size.height + ((height*0.1)*2));
    
    _inviteHomeMemberAlertViewTitleLabel.frame = CGRectMake((width - _inviteHomeMemberAlertViewXIcon.frame.origin.x) + height*0.05, height*0.1, width - (((width -_inviteHomeMemberAlertViewXIcon.frame.origin.x))*2) - height*0.1, ((height*0.1) > 20?(20):(height*0.1)));
    _inviteHomeMemberAlertViewTitleLabel.font = [UIFont systemFontOfSize:_inviteHomeMemberAlertViewTitleLabel.frame.size.height*0.9 weight:UIFontWeightHeavy];
    
    _inviteHomeMemberAlertViewSubTitleLabel.frame = CGRectMake(height*0.1, _inviteHomeMemberAlertViewTitleLabel.frame.origin.y + _inviteHomeMemberAlertViewTitleLabel.frame.size.height + height*0.125, width - ((height*0.1)*2), ((height*0.2) > 40?(40):(height*0.2)));
    _inviteHomeMemberAlertViewSubTitleLabel.font = [UIFont systemFontOfSize:_inviteHomeMemberAlertViewSubTitleLabel.frame.size.height*0.375 weight:UIFontWeightHeavy];
    
    _inviteHomeMemberAlertViewSubmitButton.frame = CGRectMake(width*0.5 - ((width - ((width*0.09661836)*2))*0.5), height - ((height*0.2375) > 47.5?(47.5):(height*0.2375)) - height*0.1 - height*0.1, width - ((width*0.09661836)*2), ((height*0.2375) > 47.5?(47.5):(height*0.2375)));
    _inviteHomeMemberAlertViewSubmitButton.titleLabel.font = [UIFont systemFontOfSize:((_inviteHomeMemberAlertViewSubmitButton.frame.size.height*0.31578947) > 15?(15):(_inviteHomeMemberAlertViewSubmitButton.frame.size.height*0.31578947)) weight:UIFontWeightSemibold];
    _inviteHomeMemberAlertViewSubmitButton.clipsToBounds = YES;
    _inviteHomeMemberAlertViewSubmitButton.layer.cornerRadius = 7;
    
    _inviteHomeMemberAlertViewLaterButton.frame = CGRectMake(width*0.5 - ((width - ((width*0.09661836)*2))*0.5), height - ((height*0.1) > 20?(20):(height*0.1)) - ((height*0.1) > 20?(20):(height*0.1)), width - ((width*0.09661836)*2), ((height*0.1) > 20?(20):(height*0.1)));
    _inviteHomeMemberAlertViewLaterButton.titleLabel.font = [UIFont systemFontOfSize:_inviteHomeMemberAlertViewLaterButton.frame.size.height*0.7 weight:UIFontWeightSemibold];
    _inviteHomeMemberAlertViewLaterButton.clipsToBounds = YES;
    _inviteHomeMemberAlertViewLaterButton.layer.cornerRadius = 7;
    
    _inviteHomeMemberAlertViewTitleLabel.text = @"Invite your home member. 💌";
    _inviteHomeMemberAlertViewSubTitleLabel.text = [NSString stringWithFormat:@"Send an invitation code so\nthey can join your home."];
    [_inviteHomeMemberAlertViewSubmitButton setTitle:@"Send Invitation" forState:UIControlStateNormal];
    
}

-(void)viewDidAppear:(BOOL)animated {
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"SeenNoInvitationsPopup"]) {
        
        [UIView animateWithDuration:0.25 animations:^{
            
            CGFloat width = CGRectGetWidth(self.view.bounds);
            CGFloat height = CGRectGetHeight(self.view.bounds);
            
            self->_inviteReminderBackDropView.frame = CGRectMake(0, 0, width, height);
            self->_inviteReminderBackDropView.alpha = 1.0;
            
            self->_inviteReminderAlertView.frame = CGRectMake(0, height - ((height*0.271739123) > 200?(200):(height*0.271739123)), width, ((height*0.271739123) > 200?(200):(height*0.271739123)));
            
        } completion:^(BOOL finished) {
            
            [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"SeenNoInvitationsPopup"];
            
            [[[GeneralObject alloc] init] CallNSNotificationMethods:@"UnusedInvitations" userInfo:nil locations:@[@"Tasks", @"Chats"]];
            
        }];
        
    }
    
}

-(void)viewWillDisappear:(BOOL)animated {
    _homeKeyImage.hidden = YES;
    _moveOutImage.hidden = YES;
    _multipleHomesImage.hidden = YES;
}

-(void)viewDidDisappear:(BOOL)animated {
    _homeKeyImage.hidden = YES;
    _moveOutImage.hidden = YES;
    _multipleHomesImage.hidden = YES;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Home Members View Controller Scrolling"] completionHandler:^(BOOL finished) {
        
    }];
    
}

#pragma mark - Mail Methods

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    switch (result)
    {
        case MFMailComposeResultCancelled:
            
            NSLog(@"Mail cancelled");
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Invite Cancelled"] completionHandler:^(BOOL finished) {
                
            }];
            
            break;
            
        case MFMailComposeResultSaved:
            
            NSLog(@"Mail saved");
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Invite Contact"] completionHandler:^(BOOL finished) {
                
            }];
            
            break;
            
        case MFMailComposeResultSent:
            
            NSLog(@"Mail sent");
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Invite Contact Sent"] completionHandler:^(BOOL finished) {
                
            }];
            
            break;
            
        case MFMailComposeResultFailed:
            
            NSLog(@"Mail sent failure");
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Invite Failure"] completionHandler:^(BOOL finished) {
                
            }];
            
            break;
            
        default:
            
            break;
            
    }
    
    [controller dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - Init Methods

-(void)InitMethod {
    
    [self SetUpAnalytics];
    
    [self SetUpDicts];
    
    [self SetUpTitle];
    
    [self SetUpNavigationBarImages];
    
    [self SetUpTableView];
    
    [self SetUpActivityControl];
    
    [self SetUpRefreshControl];
    
    [self SetUpTellAFriendButtonText];
    
    [self SetUpHasAnAndroidButtonText];
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        self.view.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [[[LightDarkModeObject alloc] init] DarkModeTextPrimary]};
        self.inviteReminderBackDropView.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:0.1f];
        self.inviteReminderAlertView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModePrimary];
        self.inviteReminderAlertViewTitleLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        self.inviteReminderAlertViewSubTitleLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        self.inviteHomeMemberBackDropView.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:0.1f];
        self.inviteHomeMemberAlertView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModePrimary];
        self.inviteHomeMemberAlertViewTitleLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        self.inviteHomeMemberAlertViewSubTitleLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        
        [self preferredStatusBarStyle];
        
        self.navigationController.navigationBar.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        
    } else {
        
        self.navigationController.navigationBar.backgroundColor = self.view.backgroundColor;
        
    }
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        return UIStatusBarStyleLightContent;
        
    } else {
        
        return UIStatusBarStyleDefault;
        
    }
    
}

-(void)BarButtonItems {
    
    self.navigationItem.hidesBackButton = YES;
    
    UIBarButtonItem *barButtonitem;
    
    barButtonitem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(NavigationBackButtonAction:)];
    
    self.navigationItem.leftBarButtonItem = barButtonitem;
    
}

-(void)TapGestures {
    
    UITapGestureRecognizer *tapGesture;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(HomeKeyAction:)];
    [_homeKeyImage addGestureRecognizer:tapGesture];
    _homeKeyImage.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(MoveOutAction:)];
    [_moveOutImage addGestureRecognizer:tapGesture];
    _moveOutImage.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(MultipleHomesAction:)];
    [_multipleHomesImage addGestureRecognizer:tapGesture];
    _multipleHomesImage.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(AddHomeMember:)];
    [_inviteReminderAlertViewSubmitButton addGestureRecognizer:tapGesture];
    _inviteReminderAlertViewSubmitButton.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGestureFeedbackClose:)];
    [_inviteReminderAlertViewXIconCover addGestureRecognizer:tapGesture];
    _inviteReminderAlertViewXIconCover.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(InviteHomeMemberSubmitButtonAction:)];
    [_inviteHomeMemberAlertViewSubmitButton addGestureRecognizer:tapGesture];
    _inviteHomeMemberAlertViewSubmitButton.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGestureInviteHomeMemberClose:)];
    [_inviteHomeMemberAlertViewLaterButton addGestureRecognizer:tapGesture];
    _inviteHomeMemberAlertViewLaterButton.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGestureInviteHomeMemberClose:)];
    [_inviteHomeMemberAlertViewXIconCover addGestureRecognizer:tapGesture];
    _inviteHomeMemberAlertViewXIconCover.userInteractionEnabled = YES;
    
}

#pragma mark - Setup Methods

-(void)SetUpAnalytics {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewViewController:@"HomeMembersViewController" completionHandler:^(BOOL finished) {
        
    }];
    
    [[[GeneralObject alloc] init] TrackInMixPanel:@"HomeMembersViewController"];
    
}

-(void)SetUpDicts {
    
    folderDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"FolderDict"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"FolderDict"] mutableCopy] : [NSMutableDictionary dictionary];
    taskListDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskListDict"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"TaskListDict"] mutableCopy] : [NSMutableDictionary dictionary];
    sectionDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"SectionDict"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"SectionDict"] mutableCopy] : [NSMutableDictionary dictionary];
    templateDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"TemplateDict"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"TemplateDict"] mutableCopy] : [NSMutableDictionary dictionary];
    
}

-(void)SetUpTitle {
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeName"]) {
        self.title = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeName"];
    } else {
        self.title = @"Members";
    }
    
}

-(void)SetUpNavigationBarImages {
    
    if (_viewingHomeMembersFromHomesViewController == YES) {
        
        _homeKeyImage.hidden = YES;
        _moveOutImage.hidden = YES;
        _multipleHomesImage.hidden = YES;
        
    }
    
}

-(void)SetUpSectionsArray {
    
    self->sectionsArray = [@[@"Home Members"] mutableCopy];
    
}

-(void)SetUpTableView {
    
    self->_customTableView.delegate = self;
    self->_customTableView.dataSource = self;
    
}

-(void)SetUpActivityControl {
    
    activityControl = [[UIActivityIndicatorView alloc] init];
    activityControl.color = [UIColor lightGrayColor];
    [activityControl setHidden:NO];
    [activityControl startAnimating];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [activityControl startAnimating];
        
    });
    
    [self.view addSubview:activityControl];
    
}

-(void)SetUpRefreshControl {
    
    if (refreshControl == nil){
        refreshControl = [[UIRefreshControl alloc] init];
    }
    
    refreshControl.tintColor = [UIColor lightGrayColor];
    [refreshControl addTarget:self action:@selector(RefreshPageAction:) forControlEvents:UIControlEventValueChanged];
    [_customTableView addSubview:refreshControl];
    
}

-(void)SetUpItemViewContextMenu:(HomeMemberCell *)cell indexPath:(NSIndexPath *)indexPath {
    
    NSMutableArray *actions = [[NSMutableArray alloc] init];
    NSMutableArray *bottomMenuActions = [[NSMutableArray alloc] init];
    
    
    
    UIAction *sendInvitationAction = [self SendInvitationContextMenuAction:indexPath];
    UIAction *resendInvitationAction = [self ResendInvitationContextMenuAction:indexPath];
    UIAction *copyKeyAction = [self CopyKeyContextMenuAction:indexPath];
    UIAction *editMemberNameAction = [self EditMemberNameContextMenuAction:indexPath];
    UIAction *deleteMemberAction = [self DeleteMemberContextMenuAction:indexPath];
    
    [deleteMemberAction setAttributes:UIMenuElementAttributesDestructive];
    
    
    
    NSMutableDictionary *tempHomeMembersUnclaimedDictLocal = self->homeDict[@"HomeMembersUnclaimed"] ? [self->homeDict[@"HomeMembersUnclaimed"] mutableCopy] : [NSMutableDictionary dictionary];
    
    NSString *userIDToEdit = self->homeMembersDict[@"UserID"] && [(NSArray *)self->homeMembersDict[@"UserID"] count] > indexPath.row ? self->homeMembersDict[@"UserID"][indexPath.row] : @"";
    NSUInteger index = [[tempHomeMembersUnclaimedDictLocal allKeys] containsObject:userIDToEdit] ? [[tempHomeMembersUnclaimedDictLocal allKeys] indexOfObject:userIDToEdit] : -1;
    NSString *keyToUse = [[tempHomeMembersUnclaimedDictLocal allKeys] count] > index ? [tempHomeMembersUnclaimedDictLocal allKeys][index] : @"";
    NSMutableDictionary *tempHomeMembersUnclaimedDictLocalInnerDict = tempHomeMembersUnclaimedDictLocal[keyToUse] ? [tempHomeMembersUnclaimedDictLocal[keyToUse] mutableCopy] : [NSMutableDictionary dictionary];
    
    NSString *invitationKeyToEdit = tempHomeMembersUnclaimedDictLocalInnerDict[@"InvitationSent"] ? tempHomeMembersUnclaimedDictLocalInnerDict[@"InvitationSent"] : @"";
    
    
    
    if ([invitationKeyToEdit isEqualToString:@"No"]) {
        [actions addObject:sendInvitationAction];
    } else {
        [actions addObject:resendInvitationAction];
        [actions addObject:copyKeyAction];
    }
    
    
    
    [bottomMenuActions addObject:editMemberNameAction];
    [bottomMenuActions addObject:deleteMemberAction];
    
    UIMenu *bottomActionsMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"1" options:UIMenuOptionsDisplayInline children:bottomMenuActions];
    
    [actions addObject:bottomActionsMenu];
    
    
    
    cell.ellipsisImageOverlay.menu = [UIMenu menuWithTitle:@"" children:actions];
    cell.ellipsisImageOverlay.showsMenuAsPrimaryAction = true;
    
}

-(void)SetUpTellAFriendButtonText {
    
    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:_tellAFriendButton.currentTitleColor, NSForegroundColorAttributeName, nil];
    
    NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:@"Enjoying WeDivvy? Tell a friend" attributes:attrsDictionary];
    
    NSRange range0 = [[NSString stringWithFormat:@"%@", str] rangeOfString:@"Tell a friend"];
    
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.0f/255.0f green:122.0f/255.0f blue:255.0f/255.0f alpha:1.0f] range: NSMakeRange(range0.location, range0.length)];
    
    [_tellAFriendButton setAttributedTitle:str forState:UIControlStateNormal];
    
}

-(void)SetUpHasAnAndroidButtonText {
    
    [_hasAndroidButton setTitle:[NSString stringWithFormat:@"Does one of your home members\nhave an Android? Click here"] forState:UIControlStateNormal];
    
    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:_hasAndroidButton.currentTitleColor, NSForegroundColorAttributeName, nil];
    
    NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Does one of your home members\nhave an Android? Click here"] attributes:attrsDictionary];
    
    NSRange range0 = [[NSString stringWithFormat:@"%@", str] rangeOfString:@"Click here"];
    
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.0f/255.0f green:122.0f/255.0f blue:255.0f/255.0f alpha:1.0f] range: NSMakeRange(range0.location, range0.length)];
    
    [_hasAndroidButton setAttributedTitle:str forState:UIControlStateNormal];
    
}

#pragma mark - UI Methods

-(void)StartProgressView {
    
    self->progressView = [MRProgressOverlayView showOverlayAddedTo:self.navigationController.view animated:YES];
    self->progressView.mode = MRProgressOverlayViewModeIndeterminateSmall;
    
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

-(void)AdjustTableViewFrames {
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat navigationBarHeight = [[[GeneralObject alloc] init] GetNavigationBarHeight:self];
    _customTableView.backgroundColor = [UIColor redColor];
    [UIView animateWithDuration:0.25 animations:^{
        
        CGFloat tableViewHeight = 0;
        
        for (NSString *selectedUserID in self->homeMembersDict[@"UserID"]) {
            
            if ([self->unclaimedHomeMembersUserDict[@"UserID"] containsObject:selectedUserID]) {
                
                tableViewHeight += self->unclaimedCellHeight;
                
            } else {
                
                tableViewHeight += self->cellHeight;
                
            }
            
        }
        
        CGFloat inviteFriendsButton = (self.view.frame.size.height*0.067934 > 50?(50):self.view.frame.size.height*0.067934);
        
        CGFloat cornerRadius = (self.view.frame.size.height*0.2181818182 > 12?12:(self.view.frame.size.height*0.2181818182));
        [[[GeneralObject alloc] init] RoundingCorners:self->_customTableView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
        self->_customTableView.frame = CGRectMake(width*0.5 - (width*0.90338164)*0.5, navigationBarHeight + 12, width*0.90338164, tableViewHeight);
        self->_addHomeMemberButton.frame = CGRectMake(width*0.5 - (width*0.90338164)*0.5, self->_customTableView.frame.origin.y + self->_customTableView.frame.size.height, width*0.90338164, inviteFriendsButton);
        self->_hasAndroidButton.frame = CGRectMake(0, self->_addHomeMemberButton.frame.origin.y + self->_addHomeMemberButton.frame.size.height + 20, width, 32);
        
    }];
    
}

-(void)DisplayInviteHomeMembersPopup:(BOOL)Display {
    
    [UIView animateWithDuration:0.25 animations:^{
        
        CGFloat width = CGRectGetWidth(self.view.bounds);
        CGFloat height = CGRectGetHeight(self.view.bounds);
        
        self->_inviteHomeMemberBackDropView.frame = CGRectMake(0, 0, width, height);
        self->_inviteHomeMemberBackDropView.alpha = Display ? 1.0 : 0.0;
        
        self->_inviteHomeMemberAlertView.frame = Display ? CGRectMake(0, height - ((height*0.33967391) > 250?(250):(height*0.33967391)), width, ((height*0.33967391) > 250?(250):(height*0.33967391))) : CGRectMake(0, height, width, ((height*0.33967391) > 250?(250):(height*0.33967391)));
        
    } completion:^(BOOL finished) {
        
    }];
    
}

#pragma mark - UX Methods

-(void)QueryInitialData {
    
    NSArray *keyArray = [[[GeneralObject alloc] init] GenerateKeyArrayManually:NO Expense:NO List:NO Home:YES];
    
    [[[GetDataObject alloc] init] GetDataSpecificHomeData:_homeID keyArray:keyArray completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningHomeToJoinDict, NSMutableArray * _Nonnull queriedHomeMemberArray, NSString * _Nonnull queriedHomeID) {
        
        self->homeDict = [returningHomeToJoinDict mutableCopy];
       
        [[[GetDataObject alloc] init] GetDataUserDataArray:[self->homeDict[@"HomeMembers"] mutableCopy] completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningUserDict) {
            
            self->homeMembersDict = [self MoveHomeCreatorToTopOfDict:returningUserDict];
           
            [[[GeneralObject alloc] init] CheckPremiumSubscriptionStatus:self->homeMembersDict completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningHomeMembersDict) {
                
            }];
            
            [self SetUpSectionsArray];
            [self FillDictWithUnclaimedUsers];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self->activityControl stopAnimating];
                [self->refreshControl endRefreshing];
                [self.customTableView reloadData];
                
                [self AdjustTableViewFrames];
                
            });
            
        }];
        
    }];
    
}

#pragma mark - IBAction Methods

-(IBAction)AddHomeMember:(id)sender {
    
    if ([[[GeneralObject alloc] init] ConnectedToInternet] == NO) {
        [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You need to be connected to the internet to do that." currentViewController:self];
        return;
    }
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Invite Roommates Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"New Home Member" message:@"Enter your new home members name"
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Add"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * _Nonnull action) {
        
        NSString *newName = controller.textFields[0].text;
        
        NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
        NSString *trimmedStringItemName = [newName stringByTrimmingCharactersInSet:charSet];
        
        if (trimmedStringItemName.length > 0) {
            
            if ([self->homeMembersDict[@"Username"] containsObject:controller.textFields[0].text] == NO) {
                
                //                [self StartProgressView];
                
                
                
                NSString *inviteKey = [[[GeneralObject alloc] init] GenerateRandomSmallNumberIntoString:100000 upperBound:999999];
                __block NSString *inviteKeyExtraWithNumber = inviteKeyExtraWithNumber = [NSString stringWithFormat:@"%@•••%@•••", inviteKey, [[[GeneralObject alloc] init] GenerateRandomSmallNumberIntoString:100 upperBound:999]];
                
                
                
                NSMutableDictionary *userDictLocal = [self AddHomeMember_GenerateUserDict:newName];
                self->lastHomeMemberAddedUserDict = [self AddHomeMember_GenerateLastHomeMemberAddedUserDict:[userDictLocal mutableCopy] inviteKey:inviteKey inviteKeyExtraWithNumber:inviteKeyExtraWithNumber];
                
                NSString *newUserID = userDictLocal[@"UserID"] ? userDictLocal[@"UserID"] : @"";
                NSString *newUsername = userDictLocal[@"Username"] ? userDictLocal[@"Username"] : @"";
                
                
                
                [self AddHomeMember_UpdateHomeMembersDict:userDictLocal];
                
                [self AddHomeMember_UpdateHomeDict:userDictLocal inviteKey:inviteKey inviteKeyExtraWithNumber:inviteKeyExtraWithNumber];
                
                [self AddHomeMember_LocalNotifications];
                
                
                
                __block int totalQueries = 4;
                __block int completedQueries = 0;
                
                
                
                /*
                 //
                 //
                 //Update Home Data
                 //
                 //
                 */
                [self AddHomeMember_UpdateHomeData:^(BOOL finished) {
                    
                    [self AddHomeMember_FinishBlock:totalQueries completedQueries:(completedQueries+=1) completionHandler:^(BOOL finished) {
                        
                        [self AddHomeMember_UpdateAppDataWithNewHomeMember:newUserID];
                        
                        [self AddHomeMember_CompletionBlock:userDictLocal];
                        
                    }];
                    
                }];
                
                
                /*
                 //
                 //
                 //Set User Data
                 //
                 //
                 */
                [self AddHomeMember_SetUserData:userDictLocal selectedUserID:newUserID completionHandler:^(BOOL finished) {
                    
                    [self AddHomeMember_FinishBlock:totalQueries completedQueries:(completedQueries+=1) completionHandler:^(BOOL finished) {
                        
                        [self AddHomeMember_UpdateAppDataWithNewHomeMember:newUserID];
                        
                        [self AddHomeMember_CompletionBlock:userDictLocal];
                        
                    }];
                    
                }];
                
                
                /*
                 //
                 //
                 //Update Data For New Home Member
                 //
                 //
                 */
                [self AddHomeMember_UpdateDataForNewHomeMember:newUserID completionHandler:^(BOOL finished) {
                    
                    [self AddHomeMember_FinishBlock:totalQueries completedQueries:(completedQueries+=1) completionHandler:^(BOOL finished) {
                        
                        [self AddHomeMember_UpdateAppDataWithNewHomeMember:newUserID];
                        
                        [self AddHomeMember_CompletionBlock:userDictLocal];
                        
                    }];
                    
                }];
                
                
                /*
                 //
                 //
                 //Send Push Notifications To Existing Home Members
                 //
                 //
                 */
                [self AddHomeMember_SendPushNotificationsToExistingHomeMembers:newUsername completionHandler:^(BOOL finished) {
                    
                    [self AddHomeMember_FinishBlock:totalQueries completedQueries:(completedQueries+=1) completionHandler:^(BOOL finished) {
                        
                        [self AddHomeMember_UpdateAppDataWithNewHomeMember:newUserID];
                        
                        [self AddHomeMember_CompletionBlock:userDictLocal];
                        
                    }];
                    
                }];
                
                
                
            } else {
                
                [[[GeneralObject alloc] init] CreateAlert:@"Oops!" message:[NSString stringWithFormat:@"A home member with the name, %@, already exists", controller.textFields[0].text] currentViewController:self];
                
            }
            
        } else {
            
            [[[GeneralObject alloc] init] CreateAlert:@"Oops!" message:@"Looks like you forgot to enter a name." currentViewController:self];
            
        }
        
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction * _Nonnull action) {}];
    
    
    
    [controller addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        
        textField.delegate = self;
        textField.placeholder = @"New Member Name";
        textField.text = @"";
        textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
        
    }];
    
    [controller addAction:action1];
    [controller addAction:cancel];
    [self presentViewController:controller animated:YES completion:nil];
    
}

#pragma mark

- (IBAction)TellAFriend:(id)sender {
    
    if ([[[GeneralObject alloc] init] ConnectedToInternet] == NO) {
        [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You need to be connected to the internet to do that." currentViewController:self];
        return;
    }
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Tell A Friend Clicked"] completionHandler:^(BOOL finished) {
        
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


-(IBAction)AndroidButtonAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Android Button Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://forms.gle/rMsGtgYN1URpmVxe9"] options:@{} completionHandler:^(BOOL success) {
        
    }];
    
    [[[SetDataObject alloc] init] SetDataAndroid:^(BOOL finished) {
        
    }];
    
}

#pragma mark

-(IBAction)NavigationBackButtonAction:(UIBarButtonItem *)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Navigation Back Button Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"ViewingFromHomesViewController"]) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"HomeChosen"];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(IBAction)HomeKeyAction:(id)sender {
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Home Key"
                                                                        message:[NSString stringWithFormat:@"Your home key is %@", homeDict[@"HomeKey"]]
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *copyHomeKey = [UIAlertAction actionWithTitle:@"Copy Home Key"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * _Nonnull action) {
        
        UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
        [pasteBoard setString:self->homeDict && self->homeDict[@"HomeKey"] ? self->homeDict[@"HomeKey"] : @""];
        
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Copied!"
                                                                            message:@"Your home key was copied!"
                                                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Got it!"
                                                         style:UIAlertActionStyleCancel
                                                       handler:^(UIAlertAction * _Nonnull action) {
            
            
            
        }];
        
        [controller addAction:cancel];
        [self presentViewController:controller animated:YES completion:nil];
        
        
        
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction * _Nonnull action) {
        
        
        
    }];
    
    [controller addAction:copyHomeKey];
    [controller addAction:cancel];
    [self presentViewController:controller animated:YES completion:nil];
    
}

-(IBAction)MoveOutAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Move Out Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Once you leave you can't come back without an invitation" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    NSString *actionTitle = @"Leave Home";
    
    UIAlertAction *completeUncompleteAction = [UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Moving Out"] completionHandler:^(BOOL finished) {
            
        }];
        
        [self StartProgressView];
        
        if ([self->homeMembersDict[@"UserID"] containsObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]]) {
            
            NSUInteger index = [self->homeMembersDict[@"UserID"] indexOfObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
            NSString *selectedUserID = [(NSArray *)self->homeMembersDict[@"UserID"] count] > indexPath.row ? self->homeMembersDict[@"UserID"][indexPath.row] : @"";
            NSString *selectedUsername = [(NSArray *)self->homeMembersDict[@"Username"] count] > indexPath.row ? self->homeMembersDict[@"Username"][indexPath.row] : @"";
            
            
            
            
            [self DeleteHomeMember_UpdateHomeMembersDict:selectedUserID];
            
            [self DeleteHomeMember_UpdateHomeDict:selectedUserID];
            
            [self AddHomeMember_LocalNotifications];
            
            [[[GeneralObject alloc] init] CheckPremiumSubscriptionStatus:self->homeMembersDict completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningHomeMembersDict) {
                
            }];
            
            
            
            __block int totalQueries = 2;
            __block int completedQueries = 0;
            
            
            
            /*
             //
             //
             //Update Home Data
             //
             //
             */
            [self AddHomeMember_UpdateHomeData:^(BOOL finished) {
                
                [self AddHomeMember_UpdateAppDataWithNewHomeMember:@""];
                
                [self MoveOut_CompletionBlock:totalQueries completedQueries:(completedQueries+=1)];
                
            }];
            
            
            /*
             //
             //
             //Send Push Notifications To Existing Home Members
             //
             //
             */
            [self MoveOut_SendPushNotificationToExistingHomeMembers:selectedUserID selectedUsername:selectedUsername completionHandler:^(BOOL finished) {
                
                [self AddHomeMember_UpdateAppDataWithNewHomeMember:@""];
                
                [self MoveOut_CompletionBlock:totalQueries completedQueries:(completedQueries+=1)];
                
            }];
            
            
        }
        
    }];
    
    [completeUncompleteAction setValue:[UIColor systemRedColor] forKey:@"titleTextColor"];
    
    [actionSheet addAction:completeUncompleteAction];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Move Out Cancelled"] completionHandler:^(BOOL finished) {
            
        }];
        
    }]];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
    
}

-(IBAction)MultipleHomesAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Leave Home Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    [[[GeneralObject alloc] init] RemoveCachedInitialDataNSUserDefaults:YES];
    [[[GeneralObject alloc] init] RemoveHomeDataNSUserDefaults];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"HomeChosen"];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TempItemDict"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TempDisplaySectionsArray"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TempDisplayDict"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TempDisplayAmountDict"];
    
    [[[PushObject alloc] init] PushToHomesViewController:NO currentViewController:self];
    
}

#pragma mark

-(IBAction)TapGestureFeedbackClose:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Invite Others Reminder Popup Closed"] completionHandler:^(BOOL finished) {
        
    }];
    
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    [UIView animateWithDuration:0.25 animations:^{
        
        CGRect newRect = self->_inviteReminderAlertView.frame;
        newRect.origin.y = height;
        self->_inviteReminderAlertView.frame = newRect;
        
    } completion:^(BOOL finished) {
        
        [self DisplayAlertView:NO backDropView:self->_inviteReminderBackDropView alertViewNoButton:nil alertViewYesButton:nil];
        
    }];
    
}

-(IBAction)TapGestureInviteHomeMemberClose:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Invite Others Reminder Popup Closed"] completionHandler:^(BOOL finished) {
        
    }];
    
    [self->progressView setHidden:YES];
    [self->progressView setHidden:YES];
    [self DisplayInviteHomeMembersPopup:NO];
    [self AddHomeMember_UpdateAppDataWithNewHomeMember:lastHomeMemberAddedUserDict[@"UserID"]];
    //    [[[GeneralObject alloc] init] CreateAlert:@"❗️Important Reminder❗️" message:@"Don't forget to send your home member their invitation code or they won't be able to join your home." currentViewController:self];
    
}

-(IBAction)RefreshPageAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Refresh Page"] completionHandler:^(BOOL finished) {
        
    }];
    
    if (refreshControl == nil){
        
        [activityControl setHidden:NO];
        CGFloat height = CGRectGetHeight(self.view.bounds);
        CGFloat width = CGRectGetWidth(self.view.bounds);
        
        activityControl.frame = CGRectMake((width*0.5)-(12), (height*0.5)-(12), 25, 25);
        activityControl.color = [UIColor grayColor];
        [activityControl startAnimating];
        
        [self.view addSubview:activityControl];
        [self.view bringSubviewToFront:activityControl];
        
    }
    
    [self QueryInitialData];
    
}

#pragma mark - Tap Gesture IBAction Methods

-(IBAction)InviteHomeMemberSubmitButtonAction:(id)sender {
    
    [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"InviteHomeMemberAccepted"];
    
    [[[GeneralObject alloc] init] InvitingHomeMembersAcceptedPopup:^(BOOL finished) {
        
    }];
    
    [self StartProgressView];
    [self DisplayInviteHomeMembersPopup:NO];
    [self AddHomeMember_InviteHomeMember:lastHomeMemberAddedUserDict];
    
}

#pragma mark - Table View Methods

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    HomeMemberCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeMemberCell"];
    
    NSMutableDictionary *dictToUse = homeMembersDict;
    
    cell.titleLabel.text = dictToUse && dictToUse[@"Username"] && [(NSArray *)dictToUse[@"Username"] count] > indexPath.row ? dictToUse[@"Username"][indexPath.row] : @"";
    
    NSString *selectedUserID = dictToUse && dictToUse[@"UserID"] && [(NSArray *)dictToUse[@"UserID"] count] > indexPath.row ? dictToUse[@"UserID"][indexPath.row] : @"";
    NSString *homeOwnerUserID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeOwnerUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeOwnerUserID"] : @"";
    
    if ([selectedUserID isEqualToString:homeOwnerUserID]) {
        
        cell.subLabel.text = @"Home Creator";
        
    } else if ([unclaimedHomeMembersUserDict[@"UserID"] containsObject:selectedUserID]) {
        
        NSMutableDictionary *tempHomeMembersUnclaimedDictLocalInnerDict = [self GenerateHomeMembersUnclaimedDictForSpecificUser:indexPath selectedUserID:selectedUserID];
        NSString *unclaimedInvitation = tempHomeMembersUnclaimedDictLocalInnerDict && tempHomeMembersUnclaimedDictLocalInnerDict[@"InvitationSent"] ? tempHomeMembersUnclaimedDictLocalInnerDict[@"InvitationSent"] : @"";
        NSString *createdUserID = tempHomeMembersUnclaimedDictLocalInnerDict && tempHomeMembersUnclaimedDictLocalInnerDict[@"UserID"] ? tempHomeMembersUnclaimedDictLocalInnerDict[@"UserID"] : @"";
        
        
        
        NSArray *arr = [createdUserID containsString:@":"] ? [createdUserID componentsSeparatedByString:@":"] : @[];
        NSString *lastComp = [arr count] > 2 ? arr[2] : @"";
        NSString *lastCompNo1 = [lastComp length] > 2 ? [NSString stringWithFormat:@"%@", [lastComp substringToIndex:2]] : @"";
        NSString *createdUserIDDWithLastComp = [arr count] > 1 ? [NSString stringWithFormat:@"%@:%@:%@", arr[0], arr[1], lastCompNo1] : @"";
        
        
        
        NSMutableDictionary *tempHomeKeysDictLocal = self->homeDict[@"HomeKeys"] ? [self->homeDict[@"HomeKeys"] mutableCopy] : [NSMutableDictionary dictionary];
        
        NSString *dateSent = @"";
        NSString *sentBy = @"";
        
        if (tempHomeKeysDictLocal[unclaimedInvitation]) {
            
            dateSent = tempHomeKeysDictLocal[unclaimedInvitation] && tempHomeKeysDictLocal[unclaimedInvitation][@"DateSent"] ? tempHomeKeysDictLocal[unclaimedInvitation][@"DateSent"] : @"";
            sentBy = tempHomeKeysDictLocal[unclaimedInvitation] && tempHomeKeysDictLocal[unclaimedInvitation][@"SentBy"] ? tempHomeKeysDictLocal[unclaimedInvitation][@"SentBy"] : @"";
            
        }
        
        
        
        if ([unclaimedInvitation isEqualToString:@"No"]) {
            
            cell.subLabel.text = [NSString stringWithFormat:@"Invitation Code Not Sent • Home Member Added %@", [[[[GeneralObject alloc] init] GetDisplayTimeSinceDate:createdUserIDDWithLastComp shortStyle:NO reallyShortStyle:NO] lowercaseString]];
            
        } else {
            
            cell.subLabel.text = [NSString stringWithFormat:@"Has Not Joined Yet • Invitation Code Created %@", [[[[GeneralObject alloc] init] GetDisplayTimeSinceDate:dateSent shortStyle:NO reallyShortStyle:NO] lowercaseString]];
            
        }
        
        
        
    } else {
        
        cell.subLabel.text = @"Member";
        
    }
    
    
    
    NSString *username = dictToUse && dictToUse[@"Username"] && [(NSArray *)dictToUse[@"Username"] count] > indexPath.row ? dictToUse[@"Username"][indexPath.row] : @"";
    NSString *profileImageURL = dictToUse && dictToUse[@"ProfileImageURL"] && [(NSArray *)dictToUse[@"ProfileImageURL"] count] > indexPath.row ? dictToUse[@"ProfileImageURL"][indexPath.row] : @"";
    
    UIColor *backgroundColor = [[[GeneralObject alloc] init] GenerateAppColor:0.15f];
    UIColor *textColor = [[[GeneralObject alloc] init] GenerateAppColor:1.0f];
    
    if (profileImageURL == nil || profileImageURL.length == 0 || [profileImageURL containsString:@"(null)"] || [profileImageURL isEqualToString:@"xxx"] || [profileImageURL isEqualToString:@"XXX"] || [profileImageURL isEqualToString:@"https://firebasestorage.googleapis.com/v0/b/wedivvy-afe04.appspot.com/o/DefaultImages%2FdefaultProfileImage.png?alt=media&token=6892f430-8337-4327-89a4-53a403d1186c"] || [profileImageURL containsString:@"DefaultImage"]) {
        
        [cell.profileImage setImageWithString:username color:backgroundColor circular:YES textAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Futura-Medium" size:cell.profileImage.frame.size.height*0.45], NSForegroundColorAttributeName:textColor}];
        
    } else {
        
        [cell.profileImage sd_setImageWithURL:[NSURL URLWithString:profileImageURL]];
        
    }
    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        NSMutableDictionary *dictToUse = homeMembersDict;
        
        return [(NSArray *)dictToUse[@"Username"] count];
        
    }
    
    return 0;
    
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(HomeMemberCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat width = CGRectGetWidth(cell.contentView.bounds);
    CGFloat height = (self.view.frame.size.height*0.11005435 > 81?(81):self.view.frame.size.height*0.11005435)*0.7037037;//CGRectGetHeight(cell.contentView.bounds);
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        cell.contentView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModePrimary];
    }
    
    if (indexPath.section == 0) {
        
        NSMutableDictionary *dictToUse = homeMembersDict;
        
        
        
        width = CGRectGetWidth(cell.contentView.bounds);
        height = (self.view.frame.size.height*0.11005435 > 81?(81):self.view.frame.size.height*0.11005435)*0.7037037;//CGRectGetHeight(cell.homeMembersMainView.bounds);
        
        NSString *selectedUserID = dictToUse && dictToUse[@"UserID"] && [(NSArray *)dictToUse[@"UserID"] count] > indexPath.row ? dictToUse[@"UserID"][indexPath.row] : @"";
        
        CGFloat xPos = width*0.04278075;
        CGFloat xPosNo2 = width*0.04278075 + (height*0.5)*0.5 - (height*0.4)*0.5;
        CGFloat yPos = height*0.5 - ((height*0.5)*0.5);
        CGFloat yPosNo3 = height*0.14035;
        CGFloat yPosNo4 = height - cell.titleLabel.frame.size.height - height*0.14035;
        
        if ([unclaimedHomeMembersUserDict[@"UserID"] containsObject:selectedUserID]) {
            
            xPos = xPosNo2 + height*0.4 + ((width*0.04278075)*0.5);
            
        }
        
        cell.profileImage.frame = CGRectMake(xPos, yPos, height*0.5, height*0.5);
        cell.cautionImage.frame = CGRectMake(xPosNo2, cell.profileImage.frame.origin.y + (cell.profileImage.frame.size.height)*0.5 - (height*0.4)*0.5, height*0.4, height*0.4);
        
        cell.titleLabel.frame = CGRectMake(cell.profileImage.frame.origin.x + cell.profileImage.frame.size.width + ((width*0.04278075)*0.5), yPosNo3, width, height*0.350878);
        cell.subLabel.frame = CGRectMake(cell.titleLabel.frame.origin.x, yPosNo4, width, cell.titleLabel.frame.size.height);
        
        cell.titleLabel.font = [UIFont systemFontOfSize:cell.titleLabel.frame.size.height*0.85 weight:UIFontWeightSemibold];
        cell.titleLabel.font = [UIFont systemFontOfSize:cell.subLabel.frame.size.height*0.75 weight:UIFontWeightSemibold];
        
        cell.premiumImage.frame = CGRectMake(cell.titleLabel.frame.origin.x + cell.titleLabel.frame.size.width + 6, cell.titleLabel.frame.origin.y, cell.titleLabel.frame.size.height*0.7, cell.titleLabel.frame.size.height);
        NSString *userID = homeMembersDict && homeMembersDict[@"UserID"] && [(NSArray *)homeMembersDict[@"UserID"] count] > indexPath.row ? homeMembersDict[@"UserID"][indexPath.row] : @"";
        BOOL PremiumSubscriptionIsActiveForSpecificUserAtIndex = [[[BoolDataObject alloc] init] PremiumSubscriptionIsActiveForSpecificUserAtIndex:homeMembersDict userID:userID];
        cell.premiumImage.hidden = PremiumSubscriptionIsActiveForSpecificUserAtIndex ? NO : YES;
        
        cell.separatorLineView.frame = CGRectMake(width*0.04278075, cell.contentView.frame.size.height - 1, width*1 - width*0.04278075, 1);
        
        CGFloat bellHeight = height*0.35;
     
        cell.ellipsisImage.frame = CGRectMake(width - bellHeight - (width*0.04278075) + (bellHeight*0.5) - (((height*0.4385965)*0.24)*0.5), cell.contentView.frame.size.height*0.5 - ((height*0.4385965)*0.5), ((height*0.4385965)*0.24), height*0.4385965);
        cell.ellipsisImageOverlay.frame = CGRectMake(cell.ellipsisImage.frame.origin.x - (width*0.026738), cell.ellipsisImage.frame.origin.y - (width*0.026738), cell.ellipsisImage.frame.size.width + ((width*0.026738)*2), cell.ellipsisImage.frame.size.height + ((width*0.026738)*2));
        cell.ellipsisImage.image = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [UIImage imageNamed:@"GeneralIcons.Ellipsis.White"] : [UIImage imageNamed:@"GeneralIcons.Ellipsis"];
        
        CGFloat widthOfItemLabel = [[[GeneralObject alloc] init] WidthOfString:cell.titleLabel.text withFont:cell.titleLabel.font];
        CGFloat widthOfCompletedLabel = [[[GeneralObject alloc] init] WidthOfString:cell.subLabel.text withFont:cell.subLabel.font];
        
        CGRect newRect = cell.titleLabel.frame;
        newRect.size.width = widthOfItemLabel;
        cell.titleLabel.frame = newRect;
        
        CGFloat maxHeight = cell.contentView.frame.size.width - (cell.subLabel.frame.origin.x + ((width*0.04278075)*2) + cell.ellipsisImage.frame.size.width);
        
        newRect = cell.subLabel.frame;
        newRect.size.width = widthOfCompletedLabel > maxHeight ? maxHeight : widthOfCompletedLabel;
        newRect.size.height = widthOfCompletedLabel > maxHeight ? newRect.size.height*2 : newRect.size.height;
        cell.subLabel.frame = newRect;
        
        if ([unclaimedHomeMembersUserDict[@"UserID"] containsObject:selectedUserID]) {
            
            cell.ellipsisImage.hidden = NO;
            cell.ellipsisImageOverlay.hidden = NO;
            cell.ellipsisImage.userInteractionEnabled = YES;
            cell.ellipsisImageOverlay.userInteractionEnabled = YES;
            
            cell.cautionImage.hidden = NO;
            
            NSMutableDictionary *tempHomeMembersUnclaimedDictLocalInnerDict = [self GenerateHomeMembersUnclaimedDictForSpecificUser:indexPath selectedUserID:selectedUserID];
            NSString *unclaimedInvitation = tempHomeMembersUnclaimedDictLocalInnerDict && tempHomeMembersUnclaimedDictLocalInnerDict[@"InvitationSent"] ? tempHomeMembersUnclaimedDictLocalInnerDict[@"InvitationSent"] : @"";
            
            cell.cautionImage.tintColor = [unclaimedInvitation isEqualToString:@"No"] ? [UIColor systemPinkColor] : [UIColor systemYellowColor];
            
        } else {
         
            cell.ellipsisImage.hidden = YES;
            cell.ellipsisImageOverlay.hidden = YES;
            cell.ellipsisImage.userInteractionEnabled = NO;
            cell.ellipsisImageOverlay.userInteractionEnabled = NO;
            
            cell.cautionImage.hidden = YES;
            
        }
        
        cell.profileImage.hidden = NO;
        
    }
    
    [self SetUpItemViewContextMenu:cell indexPath:indexPath];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeMemberCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeMemberCell"];
    
    if ((indexPath.section == 0) && [cell.titleLabel.text isEqualToString:@"User Doesn Not Exist"] == NO) {
        
        NSMutableDictionary *dictToUse = homeMembersDict;
        
        NSString *userID = dictToUse && dictToUse[@"UserID"] && [(NSArray *)dictToUse[@"UserID"] count] > indexPath.row ? dictToUse[@"UserID"][indexPath.row] : @"";
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Did Select %@", userID] completionHandler:^(BOOL finished) {
            
        }];
        
        [[[PushObject alloc] init] PushToProfileViewController:userID currentViewController:self];
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableDictionary *dictToUse = homeMembersDict;
    NSString *selectedUserID = dictToUse && dictToUse[@"UserID"] && [(NSArray *)dictToUse[@"UserID"] count] > indexPath.row ? dictToUse[@"UserID"][indexPath.row] : @"";
    
    if ([unclaimedHomeMembersUserDict[@"UserID"] containsObject:selectedUserID]) {
        
        return unclaimedCellHeight;
        
    }
    
    return cellHeight;
    
}

#pragma mark - TableView Sections

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 0)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(((width*1 - width*0.9034)*0.5), 0, width*0.9034, width*0.060386)];
    UIView *squareView = [[UIView alloc] initWithFrame:CGRectMake(((width*1 - width*0.9034)*0.5), label.frame.origin.y + (label.frame.size.height*0.5 - ((width*0.04831)*0.5)), width*0.04831, width*0.04831)];
    
    squareView.layer.cornerRadius = squareView.frame.size.width*0.25;
    
    [label setFont:[UIFont systemFontOfSize:label.frame.size.height*0.56 weight:UIFontWeightBold]];
    [label setTextAlignment:NSTextAlignmentLeft];
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        [label setTextColor:[[[LightDarkModeObject alloc] init] DarkModeTextPrimary]];
    } else {
        [label setTextColor:[[[LightDarkModeObject alloc] init] LightModeTextPrimary]];
    }
    
    NSString *string = [self->sectionsArray objectAtIndex:section];
    
    [label setText:string];
    [view setBackgroundColor:self.view.backgroundColor];
    [label setBackgroundColor:[UIColor clearColor]];
    //[view addSubview:squareView];
    [view addSubview:label];
    
    return [[UIView alloc] init];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger )section {
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    //CGFloat height = CGRectGetHeight(self.view.bounds);
    return 0.1;//(height*0.033967 > 25?(25):height*0.033967);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger )section {
    return 1.0;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"";
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

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Internal Methods
#pragma mark
#pragma mark
#pragma mark -

#pragma mark SetUp Methods

-(UIAction *)SendInvitationContextMenuAction:(NSIndexPath *)indexPath {
    
    UIAction *action = [UIAction actionWithTitle:@"Send Invitation" image:[UIImage systemImageNamed:@"paperplane"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        if ([[[GeneralObject alloc] init] ConnectedToInternet] == NO) {
            [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You need to be connected to the internet to do that." currentViewController:self];
            return;
        }
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Send Invitation Clicked"] completionHandler:^(BOOL finished) {
            
        }];
        
        
        
        NSString *inviteKey = [[[GeneralObject alloc] init] GenerateRandomSmallNumberIntoString:100000 upperBound:999999];
        __block NSString *inviteKeyExtraWithNumber = inviteKeyExtraWithNumber = [NSString stringWithFormat:@"%@•••%@•••", inviteKey, [[[GeneralObject alloc] init] GenerateRandomSmallNumberIntoString:100 upperBound:999]];
        
        
        
        NSString *body = [NSString stringWithFormat:@"Hey %@, here's an invitation code to join my home - %@ 🏠🔐", self->homeMembersDict[@"Username"][indexPath.row], inviteKey];
        
        NSArray* dataToShare = @[body, [NSURL URLWithString:@"https://apps.apple.com/us/app/wedivvy/id1570700094"]];
        UIActivityViewController* activityViewController =[[UIActivityViewController alloc] initWithActivityItems:dataToShare applicationActivities:nil];
        [activityViewController setValue:@"Invitation From a Friend" forKey:@"subject"];
        activityViewController.excludedActivityTypes = @[UIActivityTypeAirDrop];
        
        
        
        [activityViewController setCompletionWithItemsHandler:^(NSString * __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError) {
            
            NSArray *dontAccept = @[@"com.apple.UIKit.activity.CopyToPasteboard", @"com.apple.DocumentManagerUICore.SaveToFiles"];
            
            if (completed && [dontAccept containsObject:activityType] == NO) {
                
            }
            
        }];
        
        [self presentViewController:activityViewController animated:YES completion:^{}];
        
    }];
    
    return action;
}

-(UIAction *)ResendInvitationContextMenuAction:(NSIndexPath *)indexPath {
    
    UIAction *action = [UIAction actionWithTitle:@"Send Invitation" image:[UIImage systemImageNamed:@"paperplane"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        if ([[[GeneralObject alloc] init] ConnectedToInternet] == NO) {
            [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You need to be connected to the internet to do that." currentViewController:self];
            return;
        }
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Resend Invitation Clicked"] completionHandler:^(BOOL finished) {
            
        }];
        
        NSString *selectedUserID = self->homeMembersDict && self->homeMembersDict[@"UserID"] && [(NSArray *)self->homeMembersDict[@"UserID"] count] > indexPath.row ? self->homeMembersDict[@"UserID"][indexPath.row] : @"";
        NSMutableDictionary *tempHomeMembersUnclaimedDictLocalInnerDict = [self GenerateHomeMembersUnclaimedDictForSpecificUser:indexPath selectedUserID:selectedUserID];
        NSString *unclaimedInvitation = tempHomeMembersUnclaimedDictLocalInnerDict && tempHomeMembersUnclaimedDictLocalInnerDict[@"InvitationSent"] ? tempHomeMembersUnclaimedDictLocalInnerDict[@"InvitationSent"] : @"";
        NSString *unclaimedInvitationWithDotsRemoved = [self GenerateInviteKeyWithDotsRemoved:unclaimedInvitation];
        
        NSString *body = [NSString stringWithFormat:@"Hey %@, here's an invitation code to join my home - %@ 🏠🔐", self->homeMembersDict[@"Username"][indexPath.row], unclaimedInvitationWithDotsRemoved];
        
        NSArray* dataToShare = @[body, [NSURL URLWithString:@"https://apps.apple.com/us/app/wedivvy/id1570700094"]];
        UIActivityViewController* activityViewController =[[UIActivityViewController alloc] initWithActivityItems:dataToShare applicationActivities:nil];
        [activityViewController setValue:@"Invitation From a Friend" forKey:@"subject"];
        activityViewController.excludedActivityTypes = @[UIActivityTypeAirDrop];
        
        [activityViewController setCompletionWithItemsHandler:^(NSString * __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError) {
            
            NSArray *dontAccept = @[@"com.apple.UIKit.activity.CopyToPasteboard", @"com.apple.DocumentManagerUICore.SaveToFiles"];
            
            if (completed && [dontAccept containsObject:activityType] == NO) {
                
                [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Resend Invite Roommates Completed"] completionHandler:^(BOOL finished) {
                    
                }];
                
            }
            
        }];
        
        [self presentViewController:activityViewController animated:YES completion:^{}];
        
    }];
    
    return action;
}

-(UIAction *)CopyKeyContextMenuAction:(NSIndexPath *)indexPath {
    
    UIAction *action = [UIAction actionWithTitle:@"Copy Invitation Code" image:[UIImage systemImageNamed:@"key"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Copy Invitation Clicked"] completionHandler:^(BOOL finished) {
            
        }];
        
        NSString *selectedUserID = self->homeMembersDict && self->homeMembersDict[@"UserID"] && [(NSArray *)self->homeMembersDict[@"UserID"] count] > indexPath.row ? self->homeMembersDict[@"UserID"][indexPath.row] : @"";
        NSMutableDictionary *tempHomeMembersUnclaimedDictLocalInnerDict = [self GenerateHomeMembersUnclaimedDictForSpecificUser:indexPath selectedUserID:selectedUserID];
        NSString *unclaimedInvitationKey = tempHomeMembersUnclaimedDictLocalInnerDict && tempHomeMembersUnclaimedDictLocalInnerDict[@"InvitationSent"] ? tempHomeMembersUnclaimedDictLocalInnerDict[@"InvitationSent"] : @"";
        NSString *unclaimedUsername = tempHomeMembersUnclaimedDictLocalInnerDict && tempHomeMembersUnclaimedDictLocalInnerDict[@"Username"] ? tempHomeMembersUnclaimedDictLocalInnerDict[@"Username"] : @"";
        NSString *unclaimedInvitationWithDotsRemoved = [self GenerateInviteKeyWithDotsRemoved:unclaimedInvitationKey];
        
        UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
        [pasteBoard setString:unclaimedInvitationWithDotsRemoved];
        
        NSString *message = [NSString stringWithFormat:@"%@'s invitation code, %@, was copied!", unclaimedUsername, unclaimedInvitationWithDotsRemoved];
        
        [[[GeneralObject alloc] init] CreateAlert:@"Copied!" message:message currentViewController:self];
        
    }];
    
    return action;
}

-(UIAction *)EditMemberNameContextMenuAction:(NSIndexPath *)indexPath {
    
    UIAction *action = [UIAction actionWithTitle:@"Edit" image:[UIImage systemImageNamed:@"pencil"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        if ([[[GeneralObject alloc] init] ConnectedToInternet] == NO) {
            [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You need to be connected to the internet to do that." currentViewController:self];
            return;
        }
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Edit Invitation Clicked"] completionHandler:^(BOOL finished) {
            
        }];
        
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Update Name" message:@"Enter your new home members name"
                                                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Update"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * _Nonnull action) {
            
            NSString *newName = controller.textFields[0].text;
            
            NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
            NSString *trimmedStringItemName = [newName stringByTrimmingCharactersInSet:charSet];
            
            if (trimmedStringItemName.length > 0) {
                
                NSString *selectedUserID =
                self->homeMembersDict &&
                self->homeMembersDict[@"UserID"] &&
                [(NSArray *)self->homeMembersDict[@"UserID"] count] > indexPath.row ?
                self->homeMembersDict[@"UserID"][indexPath.row] : @"";
                
                NSString *selectedUsername = controller.textFields[0].text;
                
                
                
                [self EditHomeMember_UpdateHomeMembersDict:selectedUsername selectedUserID:selectedUserID];
                
                [self EditHomeMember_UpdateHomeDict:selectedUsername selectedUserID:selectedUserID];
                
                [self AddHomeMember_UpdateAppDataWithNewHomeMember:@""];
                
                [[[GeneralObject alloc] init] CheckPremiumSubscriptionStatus:self->homeMembersDict completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningHomeMembersDict) {
                    
                }];
                
                
                
                __block int totalQueries = 2;
                __block int completedQueries = 0;
                
                
                
                /*
                 //
                 //
                 //Update Home Data
                 //
                 //
                 */
                [self AddHomeMember_UpdateHomeData:^(BOOL finished) {
                    
                    [self AddHomeMember_FinishBlock:totalQueries completedQueries:(completedQueries+=1) completionHandler:^(BOOL finished) {
                        
                    }];
                    
                }];
                
                
                /*
                 //
                 //
                 //Set User Data
                 //
                 //
                 */
                [self EditHomeMember_UpdateUserData:@{@"Username" : controller.textFields[0].text} selectedUserID:selectedUserID completionHandler:^(BOOL finished) {
                    
                    [self AddHomeMember_FinishBlock:totalQueries completedQueries:(completedQueries+=1) completionHandler:^(BOOL finished) {
                        
                    }];
                    
                }];
                
                
            } else {
                
                [[[GeneralObject alloc] init] CreateAlert:@"Oops!" message:@"Looks like you forgot to enter a name." currentViewController:self];
                
            }
            
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                         style:UIAlertActionStyleCancel
                                                       handler:^(UIAlertAction * _Nonnull action) {}];
        
        
        
        [controller addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            
            textField.delegate = self;
            textField.placeholder = @"New Member Name";
            textField.text = @"";
            textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
            
        }];
        
        [controller addAction:action1];
        [controller addAction:cancel];
        [self presentViewController:controller animated:YES completion:nil];
        
    }];
    
    return action;
}

-(UIAction *)DeleteMemberContextMenuAction:(NSIndexPath *)indexPath {
    
    UIAction *action = [UIAction actionWithTitle:@"Delete" image:[UIImage systemImageNamed:@"trash"] identifier:nil handler:^(__kindof UIAction * _Nonnull action) {
        
        if ([[[GeneralObject alloc] init] ConnectedToInternet] == NO) {
            [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You need to be connected to the internet to do that." currentViewController:self];
            return;
        }
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Delete Invitation Clicked"] completionHandler:^(BOOL finished) {
            
        }];
        
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Deleting this home member will remove them from all chores, expenses, lists, and group chats" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *completeUncompleteAction = [UIAlertAction actionWithTitle:@"Delete Home Member" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Deleting Invitation"] completionHandler:^(BOOL finished) {
                
            }];
            
            
            
            NSString *selectedUserID = self->homeMembersDict[@"UserID"] && [(NSArray *)self->homeMembersDict[@"UserID"] count] > indexPath.row ? self->homeMembersDict[@"UserID"][indexPath.row] : @"";
            NSString *selectedUsername = self->homeMembersDict[@"Username"] && [(NSArray *)self->homeMembersDict[@"Username"] count] > indexPath.row ? self->homeMembersDict[@"Username"][indexPath.row] : @"";
            
            
            
            [self DeleteHomeMember_UpdateHomeMembersDict:selectedUserID];
            
            [self DeleteHomeMember_UpdateHomeDict:selectedUserID];
            
            [self AddHomeMember_LocalNotifications];
            
            
            
            [[[GeneralObject alloc] init] CheckPremiumSubscriptionStatus:self->homeMembersDict completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningHomeMembersDict) {
                
            }];
            
            
            
            __block int totalQueries = 3;
            __block int completedQueries = 0;
            
            
            /*
             //
             //
             //Update Home Data
             //
             //
             */
            [self AddHomeMember_UpdateHomeData:^(BOOL finished) {
                
                [self AddHomeMember_FinishBlock:totalQueries completedQueries:(completedQueries+=1) completionHandler:^(BOOL finished) {
                    
                    [self AddHomeMember_UpdateAppDataWithNewHomeMember:@""];
                    
                }];
                
            }];
            
            
            /*
             //
             //
             //Delete User Data
             //
             //
             */
            [self DeleteHomeMember_DeleteUserData:selectedUserID completionHandler:^(BOOL finished) {
                
                [self AddHomeMember_FinishBlock:totalQueries completedQueries:(completedQueries+=1) completionHandler:^(BOOL finished) {
                    
                    [self AddHomeMember_UpdateAppDataWithNewHomeMember:@""];
                    
                }];
                
            }];
            
            
            /*
             //
             //
             //Update Item Data (ItemTurnUserID)
             //
             //
             */
            [self DeleteHomeMember_UpdateItemData_ItemTurnUserID:selectedUserID completionHandler:^(BOOL finished) {
                
                [self AddHomeMember_FinishBlock:totalQueries completedQueries:(completedQueries+=1) completionHandler:^(BOOL finished) {
                    
                    [self AddHomeMember_UpdateAppDataWithNewHomeMember:@""];
                    
                }];
                
            }];
            
            
            /*
             //
             //
             //Send Push Notifications To Existing Home Members
             //
             //
             */
            [self DeleteHomeMember_SendPushNotificationsToExistingHomeMembers:selectedUsername completionHandler:^(BOOL finished) {
                
                [self AddHomeMember_FinishBlock:totalQueries completedQueries:(completedQueries+=1) completionHandler:^(BOOL finished) {
                    
                    [self AddHomeMember_UpdateAppDataWithNewHomeMember:@""];
                    
                }];
                
            }];
            
        }];
        
        [completeUncompleteAction setValue:[UIColor systemRedColor] forKey:@"titleTextColor"];
        
        [actionSheet addAction:completeUncompleteAction];
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Move Out Cancelled"] completionHandler:^(BOOL finished) {
                
            }];
            
        }]];
        
        [self presentViewController:actionSheet animated:YES completion:nil];
        
    }];
    
    return action;
}

#pragma mark - UX Method
#pragma mark QueryInitialData

-(NSMutableDictionary *)MoveHomeCreatorToTopOfDict:(NSMutableDictionary *)homeMembersDict {
    
    NSMutableDictionary *homeMembersDictCopy = [homeMembersDict mutableCopy];
    
    for (NSString *userID in homeMembersDictCopy[@"UserID"]) {
        
        NSString *homeOwnerUserID =
        [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] &&
        [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeOwnerUserID"] ?
        [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeOwnerUserID"] : @"";
        
        if ([userID isEqualToString:homeOwnerUserID]) {
            
            NSUInteger index = [homeMembersDictCopy[@"UserID"] indexOfObject:userID];
            
            for (NSString *key in [homeMembersDictCopy allKeys]) {
                
                NSMutableArray *tempArr = homeMembersDict[key] ? [homeMembersDict[key] mutableCopy] : [NSMutableArray array];
                id object = tempArr && [tempArr count] > index ? tempArr[index] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                if ([tempArr count] > index) { [tempArr removeObjectAtIndex:index]; }
                [tempArr insertObject:object atIndex:0];
                [homeMembersDict setObject:tempArr forKey:key];
                
            }
            
        }
        
    }
    
    return homeMembersDictCopy;
}

-(NSMutableDictionary *)FillDictWithUnclaimedUsers {
    
    self->unclaimedHomeMembersUserDict = [NSMutableDictionary dictionary];
    
    NSMutableDictionary *userDictCopy = [self->homeMembersDict mutableCopy];
    
    for (NSString *userID in userDictCopy[@"UserID"]) {
        
        if ([[self->homeDict[@"HomeMembersUnclaimed"] allKeys] containsObject:userID]) {
            
            NSUInteger index = [self->homeMembersDict[@"UserID"] indexOfObject:userID];
            
            for (NSString *key in [userDictCopy allKeys]) {
                
                NSMutableArray *tempArr = self->homeMembersDict[key] ? [self->homeMembersDict[key] mutableCopy] : [NSMutableArray array];
                id object = tempArr && [tempArr count] > index ? [tempArr[index] mutableCopy] : @"";
                
                
                NSMutableArray *tempArrNo2 = self->unclaimedHomeMembersUserDict[key] ? [self->unclaimedHomeMembersUserDict[key] mutableCopy] : [NSMutableArray array];
                [tempArrNo2 addObject:object];
                [self->unclaimedHomeMembersUserDict setObject:tempArrNo2 forKey:key];
                
            }
            
        }
        
    }
    
    return unclaimedHomeMembersUserDict;
    
}

#pragma mark General

-(NSMutableDictionary *)GenerateHomeMembersUnclaimedDictForSpecificUser:(NSIndexPath *)indexPath selectedUserID:(NSString *)selectedUserID {
    
    NSMutableDictionary *tempHomeMembersUnclaimedDictLocal = self->homeDict[@"HomeMembersUnclaimed"] ? [self->homeDict[@"HomeMembersUnclaimed"] mutableCopy] : [NSMutableDictionary dictionary];
    
    NSUInteger index = [[tempHomeMembersUnclaimedDictLocal allKeys] containsObject:selectedUserID] ? [[tempHomeMembersUnclaimedDictLocal allKeys] indexOfObject:selectedUserID] : -1;
    NSString *keyToUse = [[tempHomeMembersUnclaimedDictLocal allKeys] count] > index ? [tempHomeMembersUnclaimedDictLocal allKeys][index] : @"";
    NSMutableDictionary *tempHomeMembersUnclaimedDictLocalInnerDict = tempHomeMembersUnclaimedDictLocal[keyToUse] ? [tempHomeMembersUnclaimedDictLocal[keyToUse] mutableCopy] : [NSMutableDictionary dictionary];
    
    return tempHomeMembersUnclaimedDictLocalInnerDict;
}

-(NSString *)GenerateInviteKeyWithDotsRemoved:(NSString *)invitationCode {
    
    NSString *homeKeyWithDotsRemoved = invitationCode;
    
    if ([homeKeyWithDotsRemoved containsString:@"•••"]) {
        homeKeyWithDotsRemoved = [homeKeyWithDotsRemoved componentsSeparatedByString:@"•••"][0];
    }
    
    return homeKeyWithDotsRemoved;
}

#pragma mark - IBAction Methods

#pragma mark Add Home Member

-(NSMutableDictionary *)AddHomeMember_GenerateUserDict:(NSString *)newName {
    
    NSString *mixPanelID = @""; //[[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString]
    NSString *userID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    NSString *userEmail = @"";
    NSString *username = newName;
    NSString *receiveEmails = @"Yes";
    
    NSMutableDictionary *userDictLocal = [@{
        
        @"UserID": userID ? userID : @"",
        @"Email": userEmail ? userEmail : @"",
        @"Username": username ? username : @"",
        @"ProfileImageURL" : @"https://firebasestorage.googleapis.com/v0/b/wedivvy-afe04.appspot.com/o/DefaultImages%2FdefaultProfileImage.png?alt=media&token=6892f430-8337-4327-89a4-53a403d1186c",
        @"MixPanelID" : mixPanelID ? mixPanelID : @"",
        @"HeardAboutUs" : @"Invite",
        @"Notifications" : @"No",
        @"ReceiveUpdateEmails" : receiveEmails ? receiveEmails : @"Yes",
        @"WeDivvyPremium" : [[[GeneralObject alloc] init] GenerateDefaultWeDivvyPremiumPlan]
        
    } mutableCopy];
    
    return userDictLocal;
}

-(NSMutableDictionary *)AddHomeMember_GenerateLastHomeMemberAddedUserDict:(NSMutableDictionary *)userDictLocal inviteKey:(NSString *)inviteKey inviteKeyExtraWithNumber:(NSString *)inviteKeyExtraWithNumber {
    
    NSMutableDictionary *lastHomeMemberAddedUserDict = userDictLocal;
    
    [lastHomeMemberAddedUserDict setObject:inviteKey forKey:@"InviteKey"];
    [lastHomeMemberAddedUserDict setObject:inviteKeyExtraWithNumber forKey:@"InviteKeyWithExtraNumbers"];
    
    return lastHomeMemberAddedUserDict;
}

-(void)AddHomeMember_UpdateHomeMembersDict:(NSMutableDictionary *)userDictLocal {
    
    NSArray *keyArray = [[[GeneralObject alloc] init] GenerateUserKeyArray];
    
    //Set Home Members Dict With New UserDict
    for (NSString *key in keyArray) {
        
        NSMutableArray *updatedArray = self->homeMembersDict[key] ? [self->homeMembersDict[key] mutableCopy] : [NSMutableArray array];
        id object = userDictLocal[key] ? userDictLocal[key] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
        [updatedArray addObject:object];
        [self->homeMembersDict setObject:updatedArray forKey:key];
        
    }
    
}

-(void)AddHomeMember_UpdateHomeDict:(NSMutableDictionary *)userDictLocal inviteKey:(NSString *)inviteKey inviteKeyExtraWithNumber:(NSString *)inviteKeyExtraWithNumber {
    
    NSMutableArray *homeMembersArray = self->homeDict[@"HomeMembers"] ? [self->homeDict[@"HomeMembers"] mutableCopy] : [NSMutableArray array];
    NSMutableDictionary *homeMembersUnclaimedDict = self->homeDict[@"HomeMembersUnclaimed"] ? [self->homeDict[@"HomeMembersUnclaimed"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *tempHomeKeysDictLocal =  self->homeDict && self->homeDict[@"HomeKeys"] ? [self->homeDict[@"HomeKeys"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableArray *tempHomeKeysArrayLocal =  self->homeDict && self->homeDict[@"HomeKeysArray"] ? [self->homeDict[@"HomeKeysArray"] mutableCopy] : [NSMutableArray array];
    
    NSString *selectedUserID = userDictLocal[@"UserID"];
    
    //Set Home Members Array With New UsersDict UserID
    [homeMembersArray addObject:userDictLocal[@"UserID"]];
    [self->homeDict setObject:homeMembersArray forKey:@"HomeMembers"];
    
    //Set Home Members Unclaimed With New UsersDict Data
    [homeMembersUnclaimedDict setObject:@{@"UserID" : userDictLocal[@"UserID"], @"Username" : userDictLocal[@"Username"], @"CreatedBy" : [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"], @"InvitationSent" : @"No", @"ViewController" : @"HomeMembers"} forKey:userDictLocal[@"UserID"]];
    [self->homeDict setObject:homeMembersUnclaimedDict forKey:@"HomeMembersUnclaimed"];
    
    //Get Home Members Unclaimed
    homeMembersUnclaimedDict = [self UpdateHomeMembersUnclaimedWithNewInvitationCode:homeMembersUnclaimedDict inviteKeyExtraWithNumber:inviteKeyExtraWithNumber selectedUserID:selectedUserID];
    [self->homeDict setObject:homeMembersUnclaimedDict forKey:@"HomeMembersUnclaimed"];
    
    //Get Home Keys Dict
    tempHomeKeysDictLocal = [self UpdateHomeKeysWithNewInvitationCode:tempHomeKeysDictLocal tempHomeMembersUnclaimedDictLocal:homeMembersUnclaimedDict inviteKeyExtraWithNumber:inviteKeyExtraWithNumber selectedUserID:selectedUserID];
    [self->homeDict setObject:tempHomeKeysDictLocal forKey:@"HomeKeys"];
    
    //Get Home Keys Array
    [tempHomeKeysArrayLocal addObject:inviteKey];
    [self->homeDict setObject:tempHomeKeysArrayLocal forKey:@"HomeKeysArray"];
    
}

-(void)AddHomeMember_LocalNotifications {
    
    [[[NotificationsObject alloc] init] SendLocalNotificationHomeMemberNoInvitationNotification_LocalOnly:self->homeDict[@"HomeKeys"] homeMembersUnclaimedDict:self->homeDict[@"HomeMembersUnclaimed"] completionHandler:^(BOOL finished) {
        
    }];
    
    [[[NotificationsObject alloc] init] SendLocalNotificationHomeMemberHasNotJoinedNotification_LocalOnly:self->homeDict[@"HomeKeys"] homeMembersUnclaimedDict:self->homeDict[@"HomeMembersUnclaimed"] completionHandler:^(BOOL finished) {
        
    }];
    
}

-(void)AddHomeMember_CompletionBlock:(NSDictionary *)userDictLocal {
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"InviteHomeMemberAccepted"] &&
        [[[NSUserDefaults standardUserDefaults] objectForKey:@"InviteHomeMemberAccepted"] isEqualToString:@"Yes"]) {
        
        [self AddHomeMember_InviteHomeMember:userDictLocal];
        
    } else {
    
        [self->progressView setHidden:YES];
        
        [[[GeneralObject alloc] init] InvitingHomeMembersPopup:^(BOOL finished) {
            
            [self DisplayInviteHomeMembersPopup:YES];
            
        }];
        
    }
    
    NSMutableDictionary *singleObjectItemDict = [[[GeneralObject alloc] init] GenerateSingleObjectDictionary:self->homeDict keyArray:[self->homeDict allKeys] indexPath:nil];
    
    [[[GeneralObject alloc] init] CallNSNotificationMethods:@"EditHome" userInfo:singleObjectItemDict locations:@[@"Homes"]];
    
}

#pragma mark

-(void)AddHomeMember_UpdateHomeData:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSMutableArray *homeMembersArray = self->homeDict[@"HomeMembers"] ? [self->homeDict[@"HomeMembers"] mutableCopy] : [NSMutableArray array];
        NSMutableDictionary *tempHomeMembersUnclaimedDictLocal = self->homeDict && self->homeDict[@"HomeMembersUnclaimed"] ? [self->homeDict[@"HomeMembersUnclaimed"] mutableCopy] : [NSMutableDictionary dictionary];
        NSMutableDictionary *tempHomeKeysDictLocal =  self->homeDict && self->homeDict[@"HomeKeys"] ? [self->homeDict[@"HomeKeys"] mutableCopy] : [NSMutableDictionary dictionary];
        NSMutableArray *tempHomeKeysArrayLocal =  self->homeDict && self->homeDict[@"HomeKeysArray"] ? [self->homeDict[@"HomeKeysArray"] mutableCopy] : [NSMutableArray array];
        
        NSDictionary *dataDict = @{@"HomeKeys" : tempHomeKeysDictLocal,
                                   @"HomeKeysArray" : tempHomeKeysArrayLocal,
                                   @"HomeMembersUnclaimed" : tempHomeMembersUnclaimedDictLocal,
                                   @"HomeMembers" : homeMembersArray};
        
        [[[SetDataObject alloc] init] UpdateDataHome:self->_homeID homeDict:dataDict completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)AddHomeMember_SetUserData:(NSDictionary *)userDictLocal selectedUserID:(NSString *)selectedUserID completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[SetDataObject alloc] init] SetDataUserData:selectedUserID userDict:userDictLocal completionHandler:^(BOOL finished, NSError * _Nonnull error) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)AddHomeMember_UpdateDataForNewHomeMember:(NSString *)selectedUserID completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[HomesViewControllerObject alloc] init] UserJoiningHome_UpdateDataForNewHomeMemberLocal:self->_homeID userToAdd:selectedUserID homeMembersDict:self->homeMembersDict notificationSettingsDict:self->_notificationSettingsDict topicDict:self->_topicDict clickedUnclaimedUser:NO QueryAssignedToNewHomeMember:YES QueryAssignedTo:NO queryAssignedToUserID:@"" ResetNotifications:NO completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)AddHomeMember_SendPushNotificationsToExistingHomeMembers:(NSString *)selectedUsername completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        
        NSString *notificationType = [[[NotificationsObject alloc] init] NotificationSettingsUnknownItemType_Adding:NO Editing:NO Deleting:NO Duplicating:NO Waiving:NO Skipping:NO Pausing:NO Comments:NO
                                                                                                       SkippingTurn:NO RemovingUser:NO
                                                                                                     FullyCompleted:NO Completed:NO InProgress:NO WontDo:NO Accept:NO Decline:NO
                                                                                                            DueDate:NO Reminder:NO
                                                                                                     SubtaskEditing:NO SubtaskDeleting:NO
                                                                                                   SubtaskCompleted:NO SubtaskInProgress:NO SubtaskWontDo:NO SubtaskAccept:NO SubtaskDecline:NO
                                                                                                     AddingListItem:NO EditingListItem:NO DeletingListItem:NO ResetingListItem:NO
                                                                                                EditingItemizedItem:NO DeletingItemizedItem:NO
                                                                                                  GroupChatMessages:NO LiveSupportMessages:NO
                                                                                                 SendingInvitations:YES DeletingInvitations:NO NewHomeMembers:NO HomeMembersMovedOut:NO HomeMembersKickedOut:NO
                                                                                                FeatureForumUpvotes:NO BugForumUpvotes:NO
                                                                                                           itemType:@"HomeMembers"];
        
        
        
        NSString *someoneString = [selectedUsername length] > 0 && selectedUsername != nil && [selectedUsername containsString:@"(null)"] == NO ? selectedUsername : @"someone";
        
        NSString *notificationTitle = [NSString stringWithFormat:@"Home Member Added 🏠"];
        NSString *notificationBody = [NSString stringWithFormat:@"%@ added %@ to your home! 🏠", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"], someoneString];
        
        
        
        NSString *homeName = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeName"] : @"xxx";
        NSMutableArray *userIDArray = self->homeDict[@"HomeMembers"] ? [self->homeDict[@"HomeMembers"] mutableCopy] : [NSMutableArray array];
        
        
        
        [[[NotificationsObject alloc] init] SendPushNotificationToArrayOfUsers_Homes:userIDArray
                                           viewingHomeMembersFromHomesViewController:NO homeID:self->_homeID homeName:homeName homeMembersDict:nil notificationSettingsDict:self->_notificationSettingsDict notificationItemType:@"HomeMembers" notificationType:notificationType
                                                                           topicDict:self->_topicDict
                                                               pushNotificationTitle:notificationTitle pushNotificationBody:notificationBody
                                                                   notificationTitle:notificationTitle notificationBody:notificationBody
                                                             SetDataHomeNotification:YES
                                                                RemoveUsersNotInHome:YES
                                                                   completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)AddHomeMember_FinishBlock:(int)totalQueries completedQueries:(int)completedQueries completionHandler:(void (^)(BOOL finished))finishBlock {
    
    if (totalQueries == completedQueries) {
      
        finishBlock(YES);
        
    }
    
}

#pragma mark

-(void)AddHomeMember_InviteHomeMember:(NSDictionary *)userDictLocal {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSString *inviteKey = userDictLocal[@"InviteKey"];
        
        NSString *body = [NSString stringWithFormat:@"Hey %@, here's an invitation code to join my home - %@ 🏠🔐", userDictLocal[@"Username"], inviteKey];
        
        NSArray* dataToShare = @[body, [NSURL URLWithString:@"https://apps.apple.com/us/app/wedivvy/id1570700094"]];
        
        UIActivityViewController* activityViewController = [[UIActivityViewController alloc] initWithActivityItems:dataToShare applicationActivities:nil];
        [activityViewController setValue:@"Invitation From a Friend" forKey:@"subject"];
        activityViewController.excludedActivityTypes = @[UIActivityTypeAirDrop];
        
        [activityViewController setCompletionWithItemsHandler:^(NSString * __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError) {
            
            [self->progressView setHidden:YES];
            
            
            
            
            
            
            
            NSArray *dontAccept = @[@"com.apple.UIKit.activity.CopyToPasteboard", @"com.apple.DocumentManagerUICore.SaveToFiles"];
            
            if (completed && [dontAccept containsObject:activityType] == NO) {
                
            } else {
                
                [[[GeneralObject alloc] init] AddingHomeMembersMessage:^(BOOL finished) {
                    
                    [self DisplayAlertView:NO backDropView:self->_inviteHomeMemberBackDropView alertViewNoButton:nil alertViewYesButton:nil];
                    
                    [[[GeneralObject alloc] init] CreateAlert:@"❗️Important Reminder❗️" message:@"Don't forget to send your home member their invitation code or they won't be able to join your home." currentViewController:self];
                    
                }];
                
            }
            
        }];
        
        [self presentViewController:activityViewController animated:YES completion:^{}];
        
    });
    
}

-(void)AddHomeMember_UpdateAppDataWithNewHomeMember:(NSString *)newUserID {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        
        
        NSMutableDictionary *tempHomeMembersDictLocal = self->homeMembersDict ? [self->homeMembersDict mutableCopy] : [NSMutableDictionary dictionary];
        NSMutableDictionary *tempHomeMembersUnclaimedDictLocal = self->homeDict && self->homeDict[@"HomeMembersUnclaimed"] ? [self->homeDict[@"HomeMembersUnclaimed"] mutableCopy] : [NSMutableDictionary dictionary];
        NSMutableDictionary *tempHomeKeysDictLocal = self->homeDict && self->homeDict[@"HomeKeys"] ? [self->homeDict[@"HomeKeys"] mutableCopy] : [NSMutableDictionary dictionary];
        
        NSMutableArray *tempHomeMembersArrayLocal = self->homeDict && self->homeDict[@"HomeMembers"] ? [self->homeDict[@"HomeMembers"] mutableCopy] : [NSMutableArray array];
        NSMutableArray *tempHomeKeysArrayLocal = self->homeDict && self->homeDict[@"HomeKeysArray"] ? [self->homeDict[@"HomeKeysArray"] mutableCopy] : [NSMutableArray array];
        
        
        
        [[NSUserDefaults standardUserDefaults] setObject:tempHomeMembersDictLocal forKey:@"HomeMembersDict"];
        [[NSUserDefaults standardUserDefaults] setObject:tempHomeMembersUnclaimedDictLocal forKey:@"HomeMembersUnclaimedDict"];
        [[NSUserDefaults standardUserDefaults] setObject:tempHomeKeysDictLocal forKey:@"HomeKeysDict"];
        
        [[NSUserDefaults standardUserDefaults] setObject:tempHomeMembersArrayLocal forKey:@"HomeMembersArray"];
        [[NSUserDefaults standardUserDefaults] setObject:tempHomeKeysArrayLocal forKey:@"HomeKeysArray"];
        
        
        
        [self FillDictWithUnclaimedUsers];
        
        
        
        NSMutableDictionary *notificationSettingsDictCopy = self->_notificationSettingsDict ? [self->_notificationSettingsDict mutableCopy] : [NSMutableDictionary dictionary];
        
        
        
        NSDictionary *dataDict = @{@"HomeMembersArray" : tempHomeMembersArrayLocal,
                                   @"HomeMembersDict" : tempHomeMembersDictLocal,
                                   @"HomeMembersUnclaimedDict" : tempHomeMembersUnclaimedDictLocal,
                                   @"HomeKeysDict" : tempHomeKeysDictLocal,
                                   @"HomeKeysArray" : tempHomeKeysArrayLocal,
                                   @"NotificationSettingsDict" : notificationSettingsDictCopy,
                                   @"NewUserID" : newUserID};
        
        
        
        [[NSUserDefaults standardUserDefaults] setObject:dataDict forKey:@"HomeDict"];
        
        
        
        
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"AddHomeMember" userInfo:[dataDict mutableCopy] locations:@[@"Tasks", @"AddTask", @"MultiAddTasks", @"ViewTask", @"Chats", @"Notifications"]];
        
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"UnusedInvitations" userInfo:nil locations:@[@"Tasks", @"Chats"]];
        
        
        
        
        [[FIRCrashlytics crashlytics] logWithFormat:@"GenerateTwoWeekReminderNotification HomeMembers1"];
        
        [[[NotificationsObject alloc] init] RemoveLocalInactiveNotification];
        [[[NotificationsObject alloc] init] GenerateTwoWeekReminderNotification];
        
        
        
        
        [self->progressView setHidden:YES];
        [self.customTableView reloadData];
        
        [self AdjustTableViewFrames];
        
    });
    
}

#pragma mark - Move Out

-(void)MoveOut_SendPushNotificationToExistingHomeMembers:(NSString *)selectedUserID selectedUsername:(NSString *)selectedUsername completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        BOOL UserIsMovingOut = [[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] isEqualToString:selectedUserID];
        
        NSString *notificationType = [[[NotificationsObject alloc] init] NotificationSettingsUnknownItemType_Adding:NO Editing:NO Deleting:NO Duplicating:NO Waiving:NO Skipping:NO Pausing:NO Comments:NO
                                                                                                       SkippingTurn:NO RemovingUser:NO
                                                                                                     FullyCompleted:NO Completed:NO InProgress:NO WontDo:NO Accept:NO Decline:NO
                                                                                                            DueDate:NO Reminder:NO
                                                                                                     SubtaskEditing:NO SubtaskDeleting:NO
                                                                                                   SubtaskCompleted:NO SubtaskInProgress:NO SubtaskWontDo:NO SubtaskAccept:NO SubtaskDecline:NO
                                                                                                     AddingListItem:NO EditingListItem:NO DeletingListItem:NO ResetingListItem:NO
                                                                                                EditingItemizedItem:NO DeletingItemizedItem:NO
                                                                                                  GroupChatMessages:NO LiveSupportMessages:NO
                                                                                                 SendingInvitations:NO DeletingInvitations:NO NewHomeMembers:NO HomeMembersMovedOut:UserIsMovingOut == YES HomeMembersKickedOut:UserIsMovingOut == NO
                                                                                                FeatureForumUpvotes:NO BugForumUpvotes:NO
                                                                                                           itemType:@"HomeMembers"];
        
        
        
        NSString *notificationTitle = UserIsMovingOut == YES ? [NSString stringWithFormat:@"Home Member Moved Out 😢"] : [NSString stringWithFormat:@"Home Member Kicked Out 😢"];
        NSString *notificationBody = UserIsMovingOut == YES ? [NSString stringWithFormat:@"%@ has left your home.", selectedUsername] : [NSString stringWithFormat:@"%@ has been kicked out of your home.", selectedUsername];
        
        NSMutableArray *userIDArray = self->homeDict[@"HomeMembers"] ? [self->homeDict[@"HomeMembers"] mutableCopy] : [NSMutableArray array];
        NSString *homeName = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeName"] : @"xxx";
        
        
        
        [[[NotificationsObject alloc] init] SendPushNotificationToArrayOfUsers_Homes:userIDArray
                                           viewingHomeMembersFromHomesViewController:NO homeID:self->_homeID homeName:homeName homeMembersDict:nil notificationSettingsDict:self->_notificationSettingsDict notificationItemType:@"HomeMembers" notificationType:notificationType
                                                                           topicDict:self->_topicDict
                                                               pushNotificationTitle:notificationTitle pushNotificationBody:notificationBody
                                                                   notificationTitle:notificationTitle notificationBody:notificationBody
                                                             SetDataHomeNotification:YES
                                                                RemoveUsersNotInHome:YES
                                                                   completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)MoveOut_CompletionBlock:(int)totalQueried completedQueries:(int)completedQueries {
   
    if (totalQueried == completedQueries) {
       
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [[[GeneralObject alloc] init] AllGenerateTokenMethod:@"AllHomeTopics" Subscribe:NO GrantedNotifications:NO];
            
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TempItemDict"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TempDisplaySectionsArray"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TempDisplayDict"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TempDisplayAmountDict"];
            
            [[[GeneralObject alloc] init] RemoveCachedInitialDataNSUserDefaults:YES];
            [[[GeneralObject alloc] init] RemoveHomeDataNSUserDefaults];
            
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"HomeChosen"];
            
            [[[GeneralObject alloc] init] CheckPremiumSubscriptionStatus:self->homeMembersDict completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningHomeMembersDict) {
                
            }];
            
            [[[PushObject alloc] init] PushToHomesViewController:NO currentViewController:self];
            
            [self.customTableView reloadData];

        });
        
    }
    
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Sub-Internal Methods
#pragma mark
#pragma mark
#pragma mark -

#pragma mark Add Home Member

-(NSMutableDictionary *)UpdateHomeMembersUnclaimedWithNewInvitationCode:(NSMutableDictionary *)homeMembersUnclaimedDict inviteKeyExtraWithNumber:(NSString *)inviteKeyExtraWithNumber selectedUserID:(NSString *)selectedUserID {
    
    NSMutableDictionary *tempHomeMembersUnclaimedDictLocal = homeMembersUnclaimedDict ? [homeMembersUnclaimedDict mutableCopy] : [NSMutableDictionary dictionary];
    NSUInteger index = [[tempHomeMembersUnclaimedDictLocal allKeys] containsObject:selectedUserID] ? [[tempHomeMembersUnclaimedDictLocal allKeys] indexOfObject:selectedUserID] : -1;
    NSString *keyToUse = [[tempHomeMembersUnclaimedDictLocal allKeys] count] > index ? [tempHomeMembersUnclaimedDictLocal allKeys][index] : @"";
    NSMutableDictionary *tempHomeMembersUnclaimedDictLocalInnerDict = tempHomeMembersUnclaimedDictLocal[keyToUse] ? [tempHomeMembersUnclaimedDictLocal[keyToUse] mutableCopy] : [NSMutableDictionary dictionary];
    
    [tempHomeMembersUnclaimedDictLocalInnerDict setObject:inviteKeyExtraWithNumber forKey:@"InvitationSent"];
    [tempHomeMembersUnclaimedDictLocal setObject:tempHomeMembersUnclaimedDictLocalInnerDict forKey:keyToUse];
    
    return tempHomeMembersUnclaimedDictLocal;
}

-(NSMutableDictionary *)UpdateHomeKeysWithNewInvitationCode:(NSMutableDictionary *)tempHomeKeysDictLocal tempHomeMembersUnclaimedDictLocal:(NSMutableDictionary *)tempHomeMembersUnclaimedDictLocal inviteKeyExtraWithNumber:(NSString *)inviteKeyExtraWithNumber selectedUserID:(NSString *)selectedUserID {
    
    NSString *currentDateString = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:@"MMMM dd, yyyy hh:mm a" returnAs:[NSString class]];
    
    NSUInteger indexOfSelectedUser = [[tempHomeMembersUnclaimedDictLocal allKeys] containsObject:selectedUserID] ? [[tempHomeMembersUnclaimedDictLocal allKeys] indexOfObject:selectedUserID] : -1;
    NSString *unclaimedUserID = [[tempHomeMembersUnclaimedDictLocal allKeys] count] > indexOfSelectedUser ? [tempHomeMembersUnclaimedDictLocal allKeys][indexOfSelectedUser] : @"";
    NSString *unclaimedUsername = tempHomeMembersUnclaimedDictLocal[unclaimedUserID] && tempHomeMembersUnclaimedDictLocal[unclaimedUserID][@"Username"] ? tempHomeMembersUnclaimedDictLocal[unclaimedUserID][@"Username"] : @"";
    
    [tempHomeKeysDictLocal setObject:@{@"DateSent" : currentDateString, @"DateUsed" : @"", @"MemberName" : unclaimedUsername, @"SentBy" : [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"], @"ViewController" : @"HomeMembers"} forKey:inviteKeyExtraWithNumber];
    
    return tempHomeKeysDictLocal;
}

#pragma mark Edit Home Member

-(void)EditHomeMember_UpdateHomeMembersDict:(NSString *)newUsername selectedUserID:(NSString *)selectedUserID {
    
    NSUInteger index = [homeMembersDict[@"UserID"] containsObject:selectedUserID] ? [homeMembersDict[@"UserID"] indexOfObject:selectedUserID] : 1000;
    
    NSMutableArray *updatedArray = self->homeMembersDict[@"Username"] ? [self->homeMembersDict[@"Username"] mutableCopy] : [NSMutableArray array];
    id object = newUsername ? newUsername : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:@"Username"];
    if ([updatedArray count] > index) { [updatedArray replaceObjectAtIndex:index withObject:object]; }
    [self->homeMembersDict setObject:updatedArray forKey:@"Username"];
    
}

-(void)EditHomeMember_UpdateHomeDict:(NSString *)newUsername selectedUserID:(NSString *)selectedUserID {
    
    NSMutableDictionary *tempHomeMembersUnclaimedDictLocal = self->homeDict && self->homeDict[@"HomeMembersUnclaimed"] ? [self->homeDict[@"HomeMembersUnclaimed"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *tempHomeKeysDictLocal =  self->homeDict && self->homeDict[@"HomeKeys"] ? [self->homeDict[@"HomeKeys"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *tempHomeMembersDictLocal = self->homeMembersDict ? [self->homeMembersDict mutableCopy] : [NSMutableDictionary dictionary];
    
    NSString *unclaimedInvitation =
    tempHomeMembersUnclaimedDictLocal &&
    tempHomeMembersUnclaimedDictLocal[selectedUserID] &&
    tempHomeMembersUnclaimedDictLocal[selectedUserID][@"InvitationSent"] ?
    tempHomeMembersUnclaimedDictLocal[selectedUserID][@"InvitationSent"] : @"";
    
    //Update HomeMembersUnclaimedDict
    tempHomeMembersUnclaimedDictLocal = [self UpdateHomeMembersUnclaimedWithNewUsername:tempHomeMembersUnclaimedDictLocal username:newUsername selectedUserID:selectedUserID];
    [self->homeDict setObject:tempHomeMembersUnclaimedDictLocal forKey:@"HomeMembersUnclaimed"];
    
    //Update HomeKeysDict
    tempHomeKeysDictLocal = [self UpdateHomeKeysWithNewUsername:tempHomeKeysDictLocal username:newUsername unclaimedInvitation:unclaimedInvitation];
    [self->homeDict setObject:tempHomeKeysDictLocal forKey:@"HomeKeys"];
    
    //Update HomeMembersDict
    tempHomeMembersDictLocal = [self UpdateHomeMembersDictWithNewUsername:tempHomeMembersDictLocal username:newUsername selectedUserID:selectedUserID];
    self->homeMembersDict = [tempHomeMembersDictLocal mutableCopy];
    
}

-(void)EditHomeMember_UpdateUserData:(NSDictionary *)userDictLocal selectedUserID:(NSString *)selectedUserID completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[SetDataObject alloc] init] UpdateDataUserData:selectedUserID userDict:userDictLocal completionHandler:^(BOOL finished, NSError * _Nonnull error) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

#pragma mark Delete Home Member

-(void)DeleteHomeMember_UpdateHomeMembersDict:(NSString *)selectedUserID {
    
    NSArray *keyArray = [[[GeneralObject alloc] init] GenerateUserKeyArray];
    
    NSUInteger index = [self->homeMembersDict[@"UserID"] containsObject:selectedUserID] ? [self->homeMembersDict[@"UserID"] indexOfObject:selectedUserID] : -1;
    
    if (index != -1) {
        
        for (NSString *key in keyArray) {
            
            NSMutableArray *updatedArray = self->homeMembersDict[key] ? [self->homeMembersDict[key] mutableCopy] : [NSMutableArray array];
            if ([updatedArray count] > index) { [updatedArray removeObjectAtIndex:index]; }
            [self->homeMembersDict setObject:updatedArray forKey:key];
            
        }
        
    }
    
}

-(void)DeleteHomeMember_UpdateHomeDict:(NSString *)selectedUserID {
    
    NSMutableDictionary *tempHomeMembersUnclaimedDictLocal = self->homeDict[@"HomeMembersUnclaimed"] ? [self->homeDict[@"HomeMembersUnclaimed"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *tempHomeKeysDictLocal =  self->homeDict && self->homeDict[@"HomeKeys"] ? [self->homeDict[@"HomeKeys"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableArray *tempHomeKeysArrayLocal =  self->homeDict && self->homeDict[@"HomeKeysArray"] ? [self->homeDict[@"HomeKeysArray"] mutableCopy] : [NSMutableArray array];
    
    NSString *unclaimedInvitation =
    tempHomeMembersUnclaimedDictLocal &&
    tempHomeMembersUnclaimedDictLocal[selectedUserID] &&
    tempHomeMembersUnclaimedDictLocal[selectedUserID][@"InvitationSent"] ?
    tempHomeMembersUnclaimedDictLocal[selectedUserID][@"InvitationSent"] : @"";
    
    //Update HomeMembersUnclaimedDict
    tempHomeMembersUnclaimedDictLocal = [self UpdateHomeMembersUnclaimedDeleteHomeMember:tempHomeMembersUnclaimedDictLocal selectedUserID:selectedUserID];
    [self->homeDict setObject:tempHomeMembersUnclaimedDictLocal forKey:@"HomeMembersUnclaimed"];
    
    //Update HomeKeysDict
    [tempHomeKeysDictLocal removeObjectForKey:unclaimedInvitation];
    [self->homeDict setObject:tempHomeKeysDictLocal forKey:@"HomeKeys"];
    
    //Update HomeKeysArray
    tempHomeKeysArrayLocal = [self UpdateHomeKeysArrayDeleteHomeMember:tempHomeKeysArrayLocal unclaimedInvitation:unclaimedInvitation];
    [self->homeDict setObject:tempHomeKeysArrayLocal forKey:@"HomeKeysArray"];
    
    //Update HomeMembersArray
    NSMutableArray *homeMembersArray = self->homeDict[@"HomeMembers"] ? [self->homeDict[@"HomeMembers"] mutableCopy] : [NSMutableArray array];
    if ([homeMembersArray containsObject:selectedUserID]) { [homeMembersArray removeObject:selectedUserID]; }
    [self->homeDict setObject:homeMembersArray forKey:@"HomeMembers"];
    
}

-(void)DeleteHomeMember_DeleteUserData:(NSString *)selectedUserID completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[DeleteDataObject alloc] init] DeleteDataUser:selectedUserID completionHandler:^(BOOL finished, NSError * _Nonnull error) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)DeleteHomeMember_UpdateItemData_ItemTurnUserID:(NSString *)selectedUserID completionHandler:(void (^)(BOOL finished))finishBlock {
   
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[SetDataObject alloc] init] UpdateDataNextUsersTurnForDeletedHomeMember:self->_homeID homeMembersDict:self->homeMembersDict notificationSettingsDict:self->_notificationSettingsDict topicDict:self->_topicDict allItemTagsArrays:[NSMutableArray array] homeMembersArray:self->homeMembersDict[@"UserID"] userID:selectedUserID completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)DeleteHomeMember_SendPushNotificationsToExistingHomeMembers:(NSString *)selectedUsername completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *notificationType = [[[NotificationsObject alloc] init] NotificationSettingsUnknownItemType_Adding:NO Editing:NO Deleting:NO Duplicating:NO Waiving:NO Skipping:NO Pausing:NO Comments:NO
                                                                                                       SkippingTurn:NO RemovingUser:NO
                                                                                                     FullyCompleted:NO Completed:NO InProgress:NO WontDo:NO Accept:NO Decline:NO
                                                                                                            DueDate:NO Reminder:NO
                                                                                                     SubtaskEditing:NO SubtaskDeleting:NO
                                                                                                   SubtaskCompleted:NO SubtaskInProgress:NO SubtaskWontDo:NO SubtaskAccept:NO SubtaskDecline:NO
                                                                                                     AddingListItem:NO EditingListItem:NO DeletingListItem:NO ResetingListItem:NO
                                                                                                EditingItemizedItem:NO DeletingItemizedItem:NO
                                                                                                  GroupChatMessages:NO LiveSupportMessages:NO
                                                                                                 SendingInvitations:YES DeletingInvitations:NO NewHomeMembers:NO HomeMembersMovedOut:NO HomeMembersKickedOut:NO
                                                                                                FeatureForumUpvotes:NO BugForumUpvotes:NO
                                                                                                           itemType:@"HomeMembers"];
        
        
        
        NSString *someoneString = [selectedUsername length] > 0 && selectedUsername != nil && [selectedUsername containsString:@"(null)"] == NO ? selectedUsername : @"someone";
        
        NSString *notificationTitle = [NSString stringWithFormat:@"Home Member Removed 🏠"];
        NSString *notificationBody = [NSString stringWithFormat:@"%@ removed %@ from your home! 🏠", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"], someoneString];
        
        
        
        NSString *homeName = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeName"] : @"xxx";
        NSMutableArray *userIDArray = self->homeDict[@"HomeMembers"] ? [self->homeDict[@"HomeMembers"] mutableCopy] : [NSMutableArray array];
        
        
        
        [[[NotificationsObject alloc] init] SendPushNotificationToArrayOfUsers_Homes:userIDArray
                                           viewingHomeMembersFromHomesViewController:NO homeID:self->_homeID homeName:homeName homeMembersDict:nil notificationSettingsDict:self->_notificationSettingsDict notificationItemType:@"HomeMembers" notificationType:notificationType
                                                                           topicDict:self->_topicDict
                                                               pushNotificationTitle:notificationTitle pushNotificationBody:notificationBody
                                                                   notificationTitle:notificationTitle notificationBody:notificationBody
                                                             SetDataHomeNotification:YES
                                                                RemoveUsersNotInHome:YES
                                                                   completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Sub-Sub-Internal Methods
#pragma mark
#pragma mark
#pragma mark -

#pragma mark Edit Home Member

-(NSMutableDictionary *)UpdateHomeMembersUnclaimedWithNewUsername:(NSMutableDictionary *)homeMembersUnclaimedDict username:(NSString *)username selectedUserID:(NSString *)selectedUserID {
    
    NSMutableDictionary *tempHomeMembersUnclaimedDictLocal = homeMembersUnclaimedDict ? [homeMembersUnclaimedDict mutableCopy] : [NSMutableDictionary dictionary];
    NSUInteger index = [[tempHomeMembersUnclaimedDictLocal allKeys] containsObject:selectedUserID] ? [[tempHomeMembersUnclaimedDictLocal allKeys] indexOfObject:selectedUserID] : -1;
    NSString *keyToUse = [[tempHomeMembersUnclaimedDictLocal allKeys] count] > index ? [tempHomeMembersUnclaimedDictLocal allKeys][index] : @"";
    NSMutableDictionary *tempHomeMembersUnclaimedDictLocalInnerDict = tempHomeMembersUnclaimedDictLocal[keyToUse] ? [tempHomeMembersUnclaimedDictLocal[keyToUse] mutableCopy] : [NSMutableDictionary dictionary];
    
    [tempHomeMembersUnclaimedDictLocalInnerDict setObject:username forKey:@"Username"];
    [tempHomeMembersUnclaimedDictLocal setObject:tempHomeMembersUnclaimedDictLocalInnerDict forKey:keyToUse];
    
    return tempHomeMembersUnclaimedDictLocal;
}

-(NSMutableDictionary *)UpdateHomeKeysWithNewUsername:(NSMutableDictionary *)tempHomeKeysDictLocal username:(NSString *)username unclaimedInvitation:(NSString *)unclaimedInvitation {
    
    NSMutableDictionary *tempHomeKeysDictLocalInnerDict = tempHomeKeysDictLocal[unclaimedInvitation] ? [tempHomeKeysDictLocal[unclaimedInvitation] mutableCopy] : [NSMutableDictionary dictionary];
    
    if (tempHomeKeysDictLocal[unclaimedInvitation]) {
        
        [tempHomeKeysDictLocalInnerDict setObject:username forKey:@"MemberName"];
        [tempHomeKeysDictLocal setObject:tempHomeKeysDictLocalInnerDict forKey:unclaimedInvitation];
        
    }
    
    return tempHomeKeysDictLocal;
}

-(NSMutableDictionary *)UpdateHomeMembersDictWithNewUsername:(NSMutableDictionary *)tempHomeMembersDictLocal username:(NSString *)username selectedUserID:(NSString *)selectedUserID {
    
    NSMutableArray *userIDArray = tempHomeMembersDictLocal[@"UserID"] ? [tempHomeMembersDictLocal[@"UserID"] mutableCopy] : [NSMutableArray array];
    NSUInteger index = [userIDArray containsObject:selectedUserID] ? [userIDArray indexOfObject:selectedUserID] : -1;
    
    NSMutableArray *usernameArray = tempHomeMembersDictLocal[@"Username"] ? [tempHomeMembersDictLocal[@"Username"] mutableCopy] : [NSMutableArray array];
    [usernameArray replaceObjectAtIndex:index withObject:username];
    
    NSMutableDictionary *homeMembersDictCopy = tempHomeMembersDictLocal ? [tempHomeMembersDictLocal mutableCopy] : [NSMutableDictionary dictionary];
    [homeMembersDictCopy setObject:usernameArray forKey:@"Username"];
    tempHomeMembersDictLocal = [homeMembersDictCopy mutableCopy];
    
    return tempHomeMembersDictLocal;
}

#pragma mark Delete Home Member

-(NSMutableDictionary *)UpdateHomeMembersUnclaimedDeleteHomeMember:(NSMutableDictionary *)homeMembersUnclaimedDict selectedUserID:(NSString *)selectedUserID {
    
    NSMutableDictionary *tempHomeMembersUnclaimedDictLocal = homeMembersUnclaimedDict ? [homeMembersUnclaimedDict mutableCopy] : [NSMutableDictionary dictionary];
    NSUInteger index = [[tempHomeMembersUnclaimedDictLocal allKeys] containsObject:selectedUserID] ? [[tempHomeMembersUnclaimedDictLocal allKeys] indexOfObject:selectedUserID] : -1;
    NSString *keyToUse = [[tempHomeMembersUnclaimedDictLocal allKeys] count] > index ? [tempHomeMembersUnclaimedDictLocal allKeys][index] : @"";
    
    [tempHomeMembersUnclaimedDictLocal removeObjectForKey:keyToUse];
    
    return tempHomeMembersUnclaimedDictLocal;
}

-(NSMutableArray *)UpdateHomeKeysArrayDeleteHomeMember:(NSMutableArray *)homeKeysArray unclaimedInvitation:(NSString *)unclaimedInvitation {
    
    NSString *inviteKeyWithDotsRemoved = [self GenerateInviteKeyWithDotsRemoved:unclaimedInvitation];
    
    NSMutableArray *tempHomeKeysArrayLocal = homeKeysArray ? [homeKeysArray mutableCopy] : [NSMutableArray array];
    
    int customCount = (int)tempHomeKeysArrayLocal.count;
    
    if ([tempHomeKeysArrayLocal containsObject:inviteKeyWithDotsRemoved]) { [tempHomeKeysArrayLocal removeObject:inviteKeyWithDotsRemoved]; }
    
    for (int i=0 ; (int)tempHomeKeysArrayLocal.count<customCount-1 ; i++) {
        [tempHomeKeysArrayLocal addObject:inviteKeyWithDotsRemoved];
    }
    
    [tempHomeKeysArrayLocal removeObject:inviteKeyWithDotsRemoved];
    
    return tempHomeKeysArrayLocal;
}

@end
