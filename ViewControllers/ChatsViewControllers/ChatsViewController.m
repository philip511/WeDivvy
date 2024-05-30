//
//  ChatViewController.m
//  WeDivvy
//
//  Created by Philip Nagel on 8/11/21.
//

#import "ChatsViewController.h"
#import "WideCell.h"
#import "AppDelegate.h"

#import <MRProgress/MRProgressOverlayView.h>
#import <SDWebImage/SDWebImage.h>

#import "GeneralObject.h"
#import "GetDataObject.h"
#import "SetDataObject.h"
#import "DeleteDataObject.h"
#import "PushObject.h"
#import "ChatObject.h"
#import "NotificationsObject.h"
#import "BoolDataObject.h"
#import "LightDarkModeObject.h"

@interface ChatsViewController () {
    
    MRProgressOverlayView *progressView;
    
    UIActivityIndicatorView *activityControl;
    UIRefreshControl *refreshControl;
    
    NSMutableDictionary *liveSupportDict;
    NSMutableDictionary *chatDict;
    NSMutableDictionary *lastMessageDict;
    
    NSMutableArray *homeMembersArray;
    NSMutableDictionary *homeDict;
    NSMutableDictionary *homeKeysDict;
    NSMutableDictionary *homeMembersUnclaimedDict;
    NSMutableDictionary *homeMembersDict;
    NSMutableDictionary *notificationSettingsDict;
    NSMutableDictionary *topicDict;
    NSMutableDictionary *taskListDict;
    NSMutableDictionary *calendarSettingsDict;
    NSMutableDictionary *templateDict;
    
    NSString *homeID;
    NSString *unreadNotificationsCount;
    
    NSArray *chatKeyArray;
    NSArray *messageKeyArray;
    
    UIView *settingsOverlayView;
    UIView *homeMembersOverlayView;
    UIView *notificationsOverlayView;
    
    BOOL EverythingIsThere;
    BOOL CachedDictExists;
    
}

@end

@implementation ChatsViewController

#pragma mark - System Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[SetDataObject alloc] init] SetDataCrash:^(BOOL finished) {
            
        }];
        
    });
    
    CachedDictExists = ([[NSUserDefaults standardUserDefaults] objectForKey:@"HomeMembersDict"] &&
                        [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeMembersArray"] &&
                        [[NSUserDefaults standardUserDefaults] objectForKey:@"TopicDict"] &&
                        [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskListDict"] &&
                        [[NSUserDefaults standardUserDefaults] objectForKey:@"NotificationSettingsDict"] &&
                        [[NSUserDefaults standardUserDefaults] objectForKey:@"ChatDict"] &&
                        [[NSUserDefaults standardUserDefaults] objectForKey:@"UnreadNotificationsCount"] &&
                        [[NSUserDefaults standardUserDefaults] objectForKey:@"LastMessageDict"] &&
                        [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeKeysDict"]);
    
    [self InitMethod];
    
    [self TapGestures];
    
    [self NSNotificationObservers];
    
    if (CachedDictExists) {
        
        [self CachedInitialData];
        
    } else {
        
        [self QueryInitialData];
        
    }
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        return UIStatusBarStyleLightContent;
        
    } else {
        
        return UIStatusBarStyleDefault;
        
    }
    
}

-(void)viewDidLayoutSubviews {
    
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    CGFloat bottomPadding = [[[GeneralObject alloc] init] GetBottomPaddingHeight];
    CGFloat statusBarSizeHeight = [[[GeneralObject alloc] init] GetStatusBarHeight];
    
    _topView.frame = CGRectMake(0, 0, width, height*0.15);
    
    
    
    
    
    
    width = CGRectGetWidth(self.topView.bounds);
    height = CGRectGetHeight(self.topView.bounds);
    
    
    
    
    _settingsImage.frame = CGRectMake(width*1 - (width*0.05434783) - (width*0.035), statusBarSizeHeight + self.view.frame.size.height*0.01630435, width*0.05434783, width*0.05434783);
    
    _homeMemberImage.frame = CGRectMake((width*0.035), _settingsImage.frame.origin.y, _settingsImage.frame.size.width, _settingsImage.frame.size.height);
    _notificationImage.frame = CGRectMake(_homeMemberImage.frame.origin.x + _homeMemberImage.frame.size.width + (width*0.03), _settingsImage.frame.origin.y, _settingsImage.frame.size.width, _settingsImage.frame.size.height);
    
    settingsOverlayView = [[UIView alloc] initWithFrame:CGRectMake(_settingsImage.frame.origin.x - 10, _settingsImage.frame.origin.y - 10, _settingsImage.frame.size.width + 20, _settingsImage.frame.size.height + 20)];
    [_topView addSubview:settingsOverlayView];
    
    homeMembersOverlayView = [[UIView alloc] initWithFrame:CGRectMake(_homeMemberImage.frame.origin.x - 10, _homeMemberImage.frame.origin.y - 10, _homeMemberImage.frame.size.width + 20, _homeMemberImage.frame.size.height + 20)];
    [_topView addSubview:homeMembersOverlayView];
    
    notificationsOverlayView = [[UIView alloc] initWithFrame:CGRectMake(_notificationImage.frame.origin.x - 10, _notificationImage.frame.origin.y - 10, _notificationImage.frame.size.width + 20, _notificationImage.frame.size.height + 20)];
    [_topView addSubview:notificationsOverlayView];
    
    UITapGestureRecognizer *tapGesture;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGesturePushToHomeMembersViewController:)];
    [homeMembersOverlayView addGestureRecognizer:tapGesture];
    homeMembersOverlayView.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGesturePushToSettingsViewController:)];
    [settingsOverlayView addGestureRecognizer:tapGesture];
    settingsOverlayView.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGesturePushToNotificationsViewController:)];
    [notificationsOverlayView addGestureRecognizer:tapGesture];
    notificationsOverlayView.userInteractionEnabled = YES;
    
    _separatorView.frame = CGRectMake(0, _settingsImage.frame.origin.y + _settingsImage.frame.size.height + self.view.frame.size.height*0.0190217, width, 1);
    
    CGRect newRect = self.topView.frame;
    newRect.size.height = _separatorView.frame.origin.y + _separatorView.frame.size.height;
    self.topView.frame = newRect;
    
    
    
    
    
    
    width = CGRectGetWidth(self.view.bounds);
    height = CGRectGetHeight(self.view.bounds);
    
    
    
    
    _customTableView.frame = CGRectMake(0, _topView.frame.origin.y + _topView.frame.size.height, width,
                                        height - _tabBarView.frame.size.height - (_topView.frame.origin.y + _topView.frame.size.height));
    
    _emptyTableViewView.frame = CGRectMake(0, 0, width, height*0.5);
    activityControl.frame = CGRectMake((self.customTableView.frame.size.width*0.5)-(12.5), (self.customTableView.frame.size.height*0.5) - (12.5) + _customTableView.frame.origin.y, 25, 25);
    
    _tabBarView.frame = CGRectMake(0, height - (bottomPadding*0.5) - height*0.06657609, width, height*0.06657609 + (bottomPadding*0.5));
    
    
    
    
    
    
    width = CGRectGetWidth(_emptyTableViewView.bounds);
    height = CGRectGetHeight(_emptyTableViewView.bounds);
    
    
    
    
    _emptyTableViewImage.frame = CGRectMake(0, 0, width, (self.view.frame.size.height*0.07472826 > 55?(55):self.view.frame.size.height*0.07472826));
    _emptyTableViewTitleLabel.frame = CGRectMake(0, _emptyTableViewImage.frame.origin.y + _emptyTableViewImage.frame.size.height + (self.view.frame.size.height*0.02038043 > 15?(15):self.view.frame.size.height*0.02038043), width, (self.view.frame.size.height*0.03804348 > 28?(28):self.view.frame.size.height*0.03804348));
    _emptyTableViewBodyLabel.frame = CGRectMake(0, _emptyTableViewTitleLabel.frame.origin.y + _emptyTableViewTitleLabel.frame.size.height, width, (self.view.frame.size.height*0.06929348 > 51?(51):self.view.frame.size.height*0.06929348));
    _emptyTableViewArrowImage.frame = CGRectMake(0, _emptyTableViewBodyLabel.frame.origin.y + _emptyTableViewBodyLabel.frame.size.height + (self.view.frame.size.height*0.13586957 > 100?(100):self.view.frame.size.height*0.13586957), width, (self.view.frame.size.height*0.07472826 > 55?(55):self.view.frame.size.height*0.07472826)*1.25);
    _emptyTableViewArrowImage.alpha = 0.75;
    
    _emptyTableViewTitleLabel.font = [UIFont systemFontOfSize:_emptyTableViewTitleLabel.frame.size.height*0.78571429 weight:UIFontWeightBold];
    _emptyTableViewBodyLabel.font = [UIFont systemFontOfSize:_emptyTableViewBodyLabel.frame.size.height*0.29411765 weight:UIFontWeightRegular];
    
    newRect = _emptyTableViewView.frame;
    newRect.size.height = _emptyTableViewImage.frame.size.height + (self.view.frame.size.height*0.02038043 > 15?(15):self.view.frame.size.height*0.02038043) + _emptyTableViewTitleLabel.frame.size.height + _emptyTableViewBodyLabel.frame.size.height;
    newRect.origin.y = self.view.frame.size.height*0.5 - newRect.size.height*0.5 + _topView.frame.size.height - _tabBarView.frame.size.height;
    _emptyTableViewView.frame = newRect;
    
    
    
    
    
    
    width = CGRectGetWidth(_tabBarView.bounds);
    height = CGRectGetHeight(_tabBarView.bounds);
    
    
    
    
    _addTaskButton.frame = CGRectMake(width*0.5 - ((width*0.133)*0.5), 0 - ((width*0.133)*0.25), (width*0.133), (width*0.133));
    _addTaskButtonImage.frame = CGRectMake(_addTaskButton.frame.origin.x + (_addTaskButton.frame.size.width*0.5 - ((_addTaskButton.frame.size.width*0.412)*0.5)), _addTaskButton.frame.origin.y + (_addTaskButton.frame.size.height*0.5 - ((_addTaskButton.frame.size.width*0.412)*0.5)), (_addTaskButton.frame.size.width*0.412), (_addTaskButton.frame.size.width*0.412));
    
    _choreIconImage.frame = CGRectMake(_addTaskButton.frame.origin.x*0.3 - ((width*0.09661836)*0.5), height*0.142857, width*0.09661836, ((width*0.09661836)*0.5625));
    _choreIconLabel.frame = CGRectMake(_choreIconImage.frame.origin.x - 50 + ((_choreIconImage.frame.size.width)*0.5), _choreIconImage.frame.origin.y + _choreIconImage.frame.size.height + 2.33, 100, ((_choreIconImage.frame.size.width)*0.325));
    
    _choreIconTapView.frame = CGRectMake(_choreIconImage.frame.origin.x - (((width*0.09661836))*0.5), _choreIconImage.frame.origin.y - (((width*0.09661836))*0.5), _choreIconImage.frame.size.width + (width*0.09661836), _choreIconImage.frame.size.height + (width*0.09661836));
    
    _expenseIconImage.frame = CGRectMake(_addTaskButton.frame.origin.x*0.7 - ((width*0.09661836)*0.5), height*0.142857, width*0.09661836, ((width*0.09661836)*0.5625));
    _expenseLabelImage.frame = CGRectMake(_expenseIconImage.frame.origin.x - 50 + ((_expenseIconImage.frame.size.width)*0.5), _expenseIconImage.frame.origin.y + _expenseIconImage.frame.size.height + 2.33, 100, ((width*0.09661836)*0.325));
    
    _expenseIconTapView.frame = CGRectMake(_expenseIconImage.frame.origin.x - (((width*0.09661836))*0.5), _expenseIconImage.frame.origin.y - (((width*0.09661836))*0.5), _expenseIconImage.frame.size.width + (width*0.09661836), _expenseIconImage.frame.size.height + (width*0.09661836));
    
    _listsIconImage.frame = CGRectMake(width - _addTaskButton.frame.origin.x*0.7 - ((width*0.09661836)*0.5), height*0.142857, width*0.09661836, ((width*0.09661836)*0.5625));
    _listsLabelImage.frame = CGRectMake(_listsIconImage.frame.origin.x - 50 + ((_listsIconImage.frame.size.width)*0.5), _listsIconImage.frame.origin.y + _listsIconImage.frame.size.height + 2.33, 100, ((width*0.09661836)*0.325));
    
    _listsIconTapView.frame = CGRectMake(_listsIconImage.frame.origin.x - (((width*0.09661836))*0.5), _listsIconImage.frame.origin.y - (((width*0.09661836))*0.5), _listsIconImage.frame.size.width + (width*0.09661836), _listsIconImage.frame.size.height + (width*0.09661836));
    
    _chatsIconImage.frame = CGRectMake(width - _addTaskButton.frame.origin.x*0.3 - ((width*0.09661836)*0.5), height*0.142857, width*0.09661836, ((width*0.09661836)*0.5625));
    _chatsLabelImage.frame = CGRectMake(_chatsIconImage.frame.origin.x - 50 + ((_chatsIconImage.frame.size.width)*0.5), _chatsIconImage.frame.origin.y + _chatsIconImage.frame.size.height + 2.33, 100, ((width*0.09661836)*0.325));
    
    _chatsIconTapView.frame = CGRectMake(_chatsIconImage.frame.origin.x - (((width*0.09661836))*0.5), _chatsIconImage.frame.origin.y - (((width*0.09661836))*0.5), _chatsIconImage.frame.size.width + (width*0.09661836), _chatsIconImage.frame.size.height + (width*0.09661836));
    
    _addTaskButton.layer.borderWidth = 0.0;
    _addTaskButton.layer.shadowColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeShadow].CGColor : [[[LightDarkModeObject alloc] init] LightModeShadow].CGColor;
    _addTaskButton.layer.shadowRadius = 3;
    _addTaskButton.layer.shadowOpacity = 1.0;
    _addTaskButton.layer.shadowOffset = CGSizeMake(0, 0);
    _addTaskButton.layer.cornerRadius = _addTaskButton.frame.size.height/2;
    
    
    
    _tabBarView.layer.borderWidth = 0.0;
    _tabBarView.layer.shadowColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeShadow].CGColor : [[[LightDarkModeObject alloc] init] LightModeShadow].CGColor;
    _tabBarView.layer.shadowRadius = 10;
    _tabBarView.layer.shadowOpacity = 1.0;
    _tabBarView.layer.shadowOffset = CGSizeMake(0, 0);
    
    
    
    CAGradientLayer *viewLayer = [CAGradientLayer layer];
    viewLayer = [CAGradientLayer layer];
    [viewLayer setFrame:_addTaskButton.bounds];
    [_addTaskButton.layer insertSublayer:viewLayer atIndex:0];
    [_addTaskButton.layer addSublayer:viewLayer];
    
    
    
    
    
    
    [self AdjustTabBarFrame];
    
    
    
    
    
    
    width = CGRectGetWidth(self.view.bounds);
    height = CGRectGetHeight(self.view.bounds);
    
    
    
    
    int customCount = 0;
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"InvitiationViewCount"]) {
        customCount = [[[NSUserDefaults standardUserDefaults] objectForKey:@"InvitiationViewCount"] intValue];
    }
    
    float multiple = 1.00;
    
    if ([[NSString stringWithFormat:@"%d", customCount] length] > 1.00) {
        multiple += (0.33 * ([[NSString stringWithFormat:@"%d", customCount] length] - 1));
    }
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"SeenNoInvitationsPopup"] isEqualToString:@"Yes"] == NO) {
        
        _pendingInvitesView.frame = CGRectMake(_homeMemberImage.frame.origin.x + _homeMemberImage.frame.size.width - ((self.view.frame.size.width*0.02717391)*0.75), _homeMemberImage.frame.origin.y - ((self.view.frame.size.width*0.02717391)*0.25), self.view.frame.size.width*0.02717391, self.view.frame.size.width*0.02717391);
        _pendingInvitesLabel.hidden = YES;
        _pendingInvitesView.layer.cornerRadius = _pendingInvitesView.frame.size.height/2;
        
    } else {
        
        if (customCount > 0) {
            self->_pendingInvitesView.hidden = NO;
            self->_pendingInvitesLabel.hidden = NO;
        } else {
            self->_pendingInvitesView.hidden = YES;
            self->_pendingInvitesLabel.hidden = YES;
        }
        
        _pendingInvitesView.frame = CGRectMake(_homeMemberImage.frame.origin.x + _homeMemberImage.frame.size.width - ((width*0.04227053)*0.67), _homeMemberImage.frame.origin.y - ((width*0.04227053)*0.33), (self.view.frame.size.width*0.04227053)*multiple, width*0.04227053);
        _pendingInvitesLabel.hidden = NO;
        _pendingInvitesView.layer.cornerRadius = _pendingInvitesView.frame.size.height/2;
        
    }
    
    
    
    
    customCount = 0;
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"NotificationViewCount"]) {
        customCount = [[[NSUserDefaults standardUserDefaults] objectForKey:@"NotificationViewCount"] intValue];
    }
    
    multiple = 1.00;
    
    if ([[NSString stringWithFormat:@"%d", customCount] length] > 1.00) {
        multiple += (0.33 * ([[NSString stringWithFormat:@"%d", customCount] length] - 1));
    }
    
    if (customCount > 0) {
        self->_notificationsView.hidden = NO;
        self->_notificationsViewLabel.hidden = NO;
    } else {
        self->_notificationsView.hidden = YES;
        self->_notificationsViewLabel.hidden = YES;
    }
    
    _notificationsView.frame = CGRectMake(_notificationImage.frame.origin.x + _notificationImage.frame.size.width - ((width*0.04227053)*0.67), _notificationImage.frame.origin.y - ((width*0.04227053)*0.33), (self.view.frame.size.width*0.04227053)*multiple, width*0.04227053);
    _notificationsView.layer.cornerRadius = _notificationsView.frame.size.height/2;
    
    
    
    
    
    
    width = CGRectGetWidth(self.pendingInvitesView.bounds);
    height = CGRectGetHeight(self.pendingInvitesView.bounds);
    
    
    
    
    _pendingInvitesLabel.frame = CGRectMake(0, 0, width, height);
    _pendingInvitesLabel.font = [UIFont systemFontOfSize:width*0.62857143 weight:UIFontWeightSemibold];
    _pendingInvitesLabel.adjustsFontSizeToFitWidth = YES;
    
    
    
    
    
    
    width = CGRectGetWidth(self.notificationsView.bounds);
    height = CGRectGetHeight(self.notificationsView.bounds);
    
    _notificationsViewLabel.frame = CGRectMake(0, 0, width, height);
    _notificationsViewLabel.font = [UIFont systemFontOfSize:height*0.62857143 weight:UIFontWeightSemibold];
    _notificationsViewLabel.adjustsFontSizeToFitWidth = YES;
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"ViewingChats"];
    [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"ViewingExpenses"];
    [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"ViewingLists"];
    
    _addTaskButton.backgroundColor = [[[GeneralObject alloc] init] GenerateAppColor:1.0f];
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        self.view.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        self.topView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeTertiary];
        self.tabBarView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeTertiary];
        self.separatorView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeTextSecondary];
        self.emptyTableViewTitleLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        self.emptyTableViewBodyLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextSecondary];
        
        [self preferredStatusBarStyle];
        
    } else {
        
        self.view.backgroundColor = [[[LightDarkModeObject alloc] init] LightModePrimary];
        self.topView.backgroundColor = [[[LightDarkModeObject alloc] init] LightModeSecondary];
        self.tabBarView.backgroundColor = [[[LightDarkModeObject alloc] init] LightModeSecondary];
        self.separatorView.backgroundColor = [[[LightDarkModeObject alloc] init] LightModePrimary];
        self.emptyTableViewTitleLabel.textColor = [[[LightDarkModeObject alloc] init] LightModeTextMainImage];
        self.emptyTableViewBodyLabel.textColor = [[[LightDarkModeObject alloc] init] LightModeTextHiddenLabel];
        
        [self preferredStatusBarStyle];
        
    }
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Chats View Controller Scrolling"] completionHandler:^(BOOL finished) {
        
    }];
    
}

#pragma mark - Init Methods

-(void)InitMethod {
    
    [self SetUpAnalytics];
    
    [self SetUpTabBarView];
    
    [self SetUpInvitationView];
    
    [self SetUpNotificationViewView];
    
    [self SetUpTitle];
    
    [self SetUpHomeID];
    
    [self SetUpKeyArray];
    
    [self SetUpTableView];
    
    [self SetUpRefreshControl];
    
    [self SetUpActivityControl];
    
    [self SetUpEmptyTableViewView];
    
}

-(void)TapGestures {
    
    UITapGestureRecognizer *tapGesture;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGesturePushToHomeMembersViewController:)];
    [homeMembersOverlayView addGestureRecognizer:tapGesture];
    homeMembersOverlayView.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGesturePushToSettingsViewController:)];
    [settingsOverlayView addGestureRecognizer:tapGesture];
    settingsOverlayView.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGesturePushToNotificationsViewController:)];
    [notificationsOverlayView addGestureRecognizer:tapGesture];
    notificationsOverlayView.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGestureAddTask:)];
    [_addTaskButton addGestureRecognizer:tapGesture];
    _addTaskButton.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGestureAddTask:)];
    [_addTaskButtonImage addGestureRecognizer:tapGesture];
    _addTaskButtonImage.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGesturePushToChoreViewController:)];
    [_choreIconTapView addGestureRecognizer:tapGesture];
    _choreIconTapView.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGesturePushToExpenseViewController:)];
    [_expenseIconTapView addGestureRecognizer:tapGesture];
    _expenseIconTapView.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGesturePushToListsViewController:)];
    [_listsIconTapView addGestureRecognizer:tapGesture];
    _listsIconTapView.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGesturePushToGroupChatViewController:)];
    [_chatsIconTapView addGestureRecognizer:tapGesture];
    _chatsIconTapView.userInteractionEnabled = YES;
    
}

-(void)NSNotificationObservers {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_Chats_ItemTabBar" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_Chats_ItemTabBar:) name:@"NSNotification_Chats_ItemTabBar" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_Chats_AddHomeMember" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_Chats_AddHomeMember:) name:@"NSNotification_Chats_AddHomeMember" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_Chats_AddChat" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_Chats_AddChat:) name:@"NSNotification_Chats_AddChat" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_Chats_EditChat" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_Chats_EditChat:) name:@"NSNotification_Chats_EditChat" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_Chats_DeleteChat" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_Chats_DeleteChat:) name:@"NSNotification_Chats_DeleteChat" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_Chats_EditLastMessage" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_Chats_EditLastMessage:) name:@"NSNotification_Chats_EditLastMessage" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_Chats_ReloadView" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_Chats_ReloadView:) name:@"NSNotification_Chats_ReloadView" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_Chats_UnreadNotifications" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_Chats_UnreadNotifications:) name:@"NSNotification_Chats_UnreadNotifications" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_Chats_UnusedInvitations" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_Chats_UnusedInvitations:) name:@"NSNotification_Chats_UnusedInvitations" object:nil];
    
}

#pragma mark - Setup Methods

-(void)SetUpAnalytics {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewViewController:@"ChatsViewController" completionHandler:^(BOOL finished) {
        
    }];
    
}

-(void)SetUpInvitationView {
    
    int count = 0;
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"InvitiationViewCount"]) {
        count = [[[NSUserDefaults standardUserDefaults] objectForKey:@"InvitiationViewCount"] intValue];
    }
    
    float multiple = 1.00;
    
    if ([[NSString stringWithFormat:@"%d", count] length] > 1.00) {
        multiple += (0.33 * ([[NSString stringWithFormat:@"%d", count] length] - 1));
    }
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"SeenNoInvitationsPopup"] isEqualToString:@"Yes"] == NO) {
        
        _pendingInvitesView.frame = CGRectMake(_homeMemberImage.frame.origin.x + _homeMemberImage.frame.size.width - ((self.view.frame.size.width*0.02717391)*0.75), _homeMemberImage.frame.origin.y - ((self.view.frame.size.width*0.02717391)*0.25), self.view.frame.size.width*0.02717391, self.view.frame.size.width*0.02717391);
        _pendingInvitesLabel.hidden = YES;
        _pendingInvitesView.layer.cornerRadius = _pendingInvitesView.frame.size.height/2;
        
    } else {
        
        _pendingInvitesView.frame = CGRectMake(_homeMemberImage.frame.origin.x + _homeMemberImage.frame.size.width - ((width*0.04227053)*0.67), _homeMemberImage.frame.origin.y - ((width*0.04227053)*0.33), (self.view.frame.size.width*0.04227053)*multiple, width*0.04227053);
        _pendingInvitesLabel.hidden = NO;
        _pendingInvitesView.layer.cornerRadius = _pendingInvitesView.frame.size.height/2;
        
    }
    
    
    width = CGRectGetWidth(self.pendingInvitesView.bounds);
    height = CGRectGetHeight(self.pendingInvitesView.bounds);
    
    self->_pendingInvitesLabel.frame = CGRectMake(0, 0, width, height);
    self->_pendingInvitesLabel.font = [UIFont systemFontOfSize:height*0.62857143 weight:UIFontWeightSemibold];
    self->_pendingInvitesLabel.adjustsFontSizeToFitWidth = YES;
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"SeenNoInvitationsPopup"] isEqualToString:@"Yes"] == NO) {
        _pendingInvitesLabel.hidden = YES;
    } else {
        if (count == 0) {
            _pendingInvitesView.hidden = YES;
            _pendingInvitesLabel.hidden = YES;
        } else {
            _pendingInvitesView.hidden = NO;
            _pendingInvitesLabel.hidden = NO;
            _pendingInvitesLabel.text = [NSString stringWithFormat:@"%d", count];
        }
        _pendingInvitesLabel.hidden = NO;
    }
    
}

-(void)SetUpNotificationViewView {
    
    int count = 0;
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"NotificationViewCount"]) {
        count = [[[NSUserDefaults standardUserDefaults] objectForKey:@"NotificationViewCount"] intValue];
    }
    
    float multiple = 1.00;
    
    if ([[NSString stringWithFormat:@"%d", count] length] > 1.00) {
        multiple += (0.33 * ([[NSString stringWithFormat:@"%d", count] length] - 1));
    }
    
    CGRect newRect = self->_notificationsView.frame;
    newRect.size.width = (self.view.frame.size.width*0.04227053)*multiple;
    self->_notificationsView.frame = newRect;
    
    CGFloat width = CGRectGetWidth(self.notificationsView.bounds);
    CGFloat height = CGRectGetHeight(self.notificationsView.bounds);
    
    self->_notificationsViewLabel.frame = CGRectMake(0, 0, width, height);
    self->_notificationsViewLabel.font = [UIFont systemFontOfSize:height*0.62857143 weight:UIFontWeightSemibold];
    self->_notificationsViewLabel.adjustsFontSizeToFitWidth = YES;
    
    if (count == 0) {
        _notificationsView.hidden = YES;
        _notificationsViewLabel.hidden = YES;
    } else {
        _notificationsView.hidden = NO;
        _notificationsViewLabel.hidden = NO;
        _notificationsViewLabel.text = [NSString stringWithFormat:@"%d", count];
    }
    
}
-(void)SetUpTabBarView {
    
    UIColor *selectedColor = [UIColor colorWithRed:3.0f/255.0f green:122.0f/255.0f blue:252.0f/255.0f alpha:1.0f];
    UIColor *unSelectedColor = [[[LightDarkModeObject alloc] init] LightModeTextSecondary];
    
    _expenseIconTapView.userInteractionEnabled = YES;
    _expenseIconTapView.hidden = NO;
    
    _chatsIconTapView.userInteractionEnabled = NO;
    _chatsIconTapView.hidden = YES;
    
    _listsIconTapView.userInteractionEnabled = YES;
    _listsIconTapView.hidden = NO;
    
    _choreIconTapView.userInteractionEnabled = YES;
    _choreIconTapView.hidden = NO;
    
    _expenseIconImage.image = [UIImage imageNamed:@"TabBarIcons.ExpenseTabNotClicked.png"];
    _listsIconImage.image = [UIImage imageNamed:@"TabBarIcons.ListTabNotClicked.png"];
    _chatsIconImage.image = [UIImage imageNamed:@"TabBarIcons.GroupChatTabClicked.png"];
    _choreIconImage.image = [UIImage imageNamed:@"TabBarIcons.ChoreTabNotClicked.png"];
    
    _choreIconLabel.textColor = unSelectedColor;
    _expenseLabelImage.textColor = unSelectedColor;
    _chatsLabelImage.textColor = selectedColor;
    _listsLabelImage.textColor = unSelectedColor;
    
}

-(void)SetUpTitle {
    
    self.title = @"Group Chats";
    
}

-(void)SetUpHomeID {
    
    homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
    
}

-(void)SetUpKeyArray {
    
    chatKeyArray = [[[GeneralObject alloc] init] GenerateChatKeyArray];
    messageKeyArray = [[[GeneralObject alloc] init] GenerateMessageKeyArray];
    
}

-(void)SetUpTableView {
    
    _customTableView.delegate = self;
    _customTableView.dataSource = self;
    
}

-(void)SetUpRefreshControl {
    
    if (refreshControl == nil){
        refreshControl = [[UIRefreshControl alloc] init];
    }
    
    refreshControl.tintColor = [UIColor lightGrayColor];
    [refreshControl addTarget:self action:@selector(RefreshPageAction:) forControlEvents:UIControlEventValueChanged];
    [_customTableView addSubview:refreshControl];
    
}

-(void)SetUpActivityControl {
    
    if (CachedDictExists == NO) {
        
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
    
}

-(void)SetUpEmptyTableViewView {
    
    _emptyTableViewView.hidden = YES;
    
    _emptyTableViewImage.image = [UIImage imageNamed:@"EmptyViewIcons.NoChats.png"];
    _emptyTableViewTitleLabel.text = @"Your Chats";
    _emptyTableViewBodyLabel.text = @"Tap the 'plus' button below to\nquickly add some chats to your home.";
    
}

#pragma mark - Custom Methods

-(void)StartProgressView {
    
    self->progressView = [MRProgressOverlayView showOverlayAddedTo:self.navigationController.view animated:YES];
    self->progressView.mode = MRProgressOverlayViewModeIndeterminateSmall;
    
}

-(void)AdjustTabBarFrame {
    
    NSArray *arr = [[NSUserDefaults standardUserDefaults] objectForKey:@"VisibleTabBarOptions"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"VisibleTabBarOptions"] : @[@"🧹 Chores", @"💵 Expenses", @"📝 Lists", @"💬 Group Chats"];
    
    UIImageView *imageView1 = nil;
    UIImageView *imageView2 = nil;
    UIImageView *imageView3 = nil;
    UIImageView *imageView4 = nil;
    
    UILabel *label1 = nil;
    UILabel *label2 = nil;
    UILabel *label3 = nil;
    UILabel *label4 = nil;
    
    UIView *view1 = nil;
    UIView *view2 = nil;
    UIView *view3 = nil;
    UIView *view4 = nil;
    
    //    _choreIconImage.image = [UIImage imageNamed:@"TabBarIcons.ListTabNotClicked"];
    //    _expenseIconImage.image = [UIImage imageNamed:@"TabBarIcons.ListTabNotClicked"];
    //    _listsIconImage.image = [UIImage imageNamed:@"TabBarIcons.ListTabNotClicked"];
    //    _chatsIconImage.image = [UIImage imageNamed:@"TabBarIcons.ListTabNotClicked"];
    //
    //    _choreIconLabel.text = @"Lists";
    //    _expenseLabelImage.text = @"Lists";
    //    _listsLabelImage.text = @"Lists";
    //    _chatsLabelImage.text = @"Lists";
    
    for (int i=0 ; i<arr.count ; i++) {
        
        if (i == 0) {
            
            if ([arr[i] containsString:@"Chores"]) {
                
                imageView1 = _choreIconImage;
                label1 = _choreIconLabel;
                view1 = _choreIconTapView;
                
            } else if ([arr[i] containsString:@"Expenses"]) {
                
                imageView1 = _expenseIconImage;
                label1 = _expenseLabelImage;
                view1 = _expenseIconTapView;
                
            } else if ([arr[i] containsString:@"Lists"]) {
                
                imageView1 = _listsIconImage;
                label1 = _listsLabelImage;
                view1 = _listsIconTapView;
                
            } else if ([arr[i] containsString:@"Chats"]) {
                
                imageView1 = _chatsIconImage;
                label1 = _chatsLabelImage;
                view1 = _chatsIconTapView;
                
            }
            
        } else if (i == 1) {
            
            if ([arr[i] containsString:@"Chores"]) {
                
                imageView2 = _choreIconImage;
                label2 = _choreIconLabel;
                view2 = _choreIconTapView;
                
            } else if ([arr[i] containsString:@"Expenses"]) {
                
                imageView2 = _expenseIconImage;
                label2 = _expenseLabelImage;
                view2 = _expenseIconTapView;
                
            } else if ([arr[i] containsString:@"Lists"]) {
                
                imageView2 = _listsIconImage;
                label2 = _listsLabelImage;
                view2 = _listsIconTapView;
                
            } else if ([arr[i] containsString:@"Chats"]) {
                
                imageView2 = _chatsIconImage;
                label2 = _chatsLabelImage;
                view2 = _chatsIconTapView;
                
            }
            
        } else if (i == 2) {
            
            if ([arr[i] containsString:@"Chores"]) {
                
                imageView3 = _choreIconImage;
                label3 = _choreIconLabel;
                view3 = _choreIconTapView;
                
            } else if ([arr[i] containsString:@"Expenses"]) {
                
                imageView3 = _expenseIconImage;
                label3 = _expenseLabelImage;
                view3 = _expenseIconTapView;
                
            } else if ([arr[i] containsString:@"Lists"]) {
                
                imageView3 = _listsIconImage;
                label3 = _listsLabelImage;
                view3 = _listsIconTapView;
                
            } else if ([arr[i] containsString:@"Chats"]) {
                
                imageView3 = _chatsIconImage;
                label3 = _chatsLabelImage;
                view3 = _chatsIconTapView;
                
            }
            
        } else if (i == 3) {
            
            if ([arr[i] containsString:@"Chores"]) {
                
                imageView4 = _choreIconImage;
                label4 = _choreIconLabel;
                view4 = _choreIconTapView;
                
            } else if ([arr[i] containsString:@"Expenses"]) {
                
                imageView4 = _expenseIconImage;
                label4 = _expenseLabelImage;
                view4 = _expenseIconTapView;
                
            } else if ([arr[i] containsString:@"Lists"]) {
                
                imageView4 = _listsIconImage;
                label4 = _listsLabelImage;
                view4 = _listsIconTapView;
                
            } else if ([arr[i] containsString:@"Chats"]) {
                
                imageView4 = _chatsIconImage;
                label4 = _chatsLabelImage;
                view4 = _chatsIconTapView;
                
            }
            
        }
        
    }
    
    if ([arr containsObject:@"🧹 Chores"] == NO) {
        
        _choreIconImage.hidden = YES;
        _choreIconLabel.hidden = YES;
        _choreIconTapView.hidden = YES;
        
    } else {
        
        _choreIconImage.hidden = NO;
        _choreIconLabel.hidden = NO;
        _choreIconTapView.hidden = NO;
        
    }
    
    if ([arr containsObject:@"💵 Expenses"] == NO) {
        
        _expenseIconImage.hidden = YES;
        _expenseLabelImage.hidden = YES;
        _expenseIconTapView.hidden = YES;
        
    } else {
        
        _expenseIconImage.hidden = NO;
        _expenseLabelImage.hidden = NO;
        _expenseIconTapView.hidden = NO;
        
    }
    
    if ([arr containsObject:@"📝 Lists"] == NO) {
        
        _listsIconImage.hidden = YES;
        _listsLabelImage.hidden = YES;
        _listsIconTapView.hidden = YES;
        
    } else {
        
        _listsIconImage.hidden = NO;
        _listsLabelImage.hidden = NO;
        _listsIconTapView.hidden = NO;
        
    }
    
    if ([arr containsObject:@"💬 Group Chats"] == NO) {
        
        _chatsIconImage.hidden = YES;
        _chatsLabelImage.hidden = YES;
        _chatsIconTapView.hidden = YES;
        
    } else {
        
        _chatsIconImage.hidden = NO;
        _chatsLabelImage.hidden = NO;
        _chatsIconTapView.hidden = NO;
        
    }
    
    CGFloat width = CGRectGetWidth(_tabBarView.bounds);
    CGFloat height = CGRectGetHeight(_tabBarView.bounds);
    
    //    CGFloat xView1 = 0;
    //    CGFloat xView2 = 0;
    //    CGFloat xView3 = 0;
    //    CGFloat xView4 = 0;
    
    if (arr.count == 1) {
        
        imageView1.frame = CGRectMake(self.view.frame.size.width*0.25 - ((width*0.09661836)*0.5), height*0.142857, width*0.09661836, ((width*0.09661836)*0.5625));
        label1.frame = CGRectMake(imageView1.frame.origin.x - 50 + ((imageView1.frame.size.width)*0.5), imageView1.frame.origin.y + imageView1.frame.size.height + 2.33, 100, ((imageView1.frame.size.width)*0.325));
        
        view1.frame = CGRectMake(imageView1.frame.origin.x - (((width*0.09661836))*0.5), imageView1.frame.origin.y - (((width*0.09661836))*0.5), imageView1.frame.size.width + (width*0.09661836), imageView1.frame.size.height + (width*0.09661836));
        
        
        
        _addTaskButton.frame = CGRectMake(self.view.frame.size.width*0.75 - ((width*0.133)*0.5), 0 - ((width*0.133)*0.25), (width*0.133), (width*0.133));
        _addTaskButtonImage.frame = CGRectMake(_addTaskButton.frame.origin.x + (_addTaskButton.frame.size.width*0.5 - ((_addTaskButton.frame.size.width*0.412)*0.5)), _addTaskButton.frame.origin.y + (_addTaskButton.frame.size.height*0.5 - ((_addTaskButton.frame.size.width*0.412)*0.5)), (_addTaskButton.frame.size.width*0.412), (_addTaskButton.frame.size.width*0.412));
        
    } else if (arr.count == 2) {
        
        imageView1.frame = CGRectMake(self.view.frame.size.width*0.225 - ((width*0.09661836)*0.5), height*0.142857, width*0.09661836, ((width*0.09661836)*0.5625));
        label1.frame = CGRectMake(imageView1.frame.origin.x - 50 + ((imageView1.frame.size.width)*0.5), imageView1.frame.origin.y + imageView1.frame.size.height + 2.33, 100, ((imageView1.frame.size.width)*0.325));
        
        view1.frame = CGRectMake(imageView1.frame.origin.x - (((width*0.09661836))*0.5), imageView1.frame.origin.y - (((width*0.09661836))*0.5), imageView1.frame.size.width + (width*0.09661836), imageView1.frame.size.height + (width*0.09661836));
        
        
        
        _addTaskButton.frame = CGRectMake(self.view.frame.size.width*0.5 - ((width*0.133)*0.5), 0 - ((width*0.133)*0.25), (width*0.133), (width*0.133));
        _addTaskButtonImage.frame = CGRectMake(_addTaskButton.frame.origin.x + (_addTaskButton.frame.size.width*0.5 - ((_addTaskButton.frame.size.width*0.412)*0.5)), _addTaskButton.frame.origin.y + (_addTaskButton.frame.size.height*0.5 - ((_addTaskButton.frame.size.width*0.412)*0.5)), (_addTaskButton.frame.size.width*0.412), (_addTaskButton.frame.size.width*0.412));
        
        
        
        imageView2.frame = CGRectMake(self.view.frame.size.width*0.775 - ((width*0.09661836)*0.5), height*0.142857, width*0.09661836, ((width*0.09661836)*0.5625));
        label2.frame = CGRectMake(imageView2.frame.origin.x - 50 + ((imageView2.frame.size.width)*0.5), imageView2.frame.origin.y + imageView2.frame.size.height + 2.33, 100, ((width*0.09661836)*0.325));
        
        view2.frame = CGRectMake(imageView2.frame.origin.x - (((width*0.09661836))*0.5), imageView2.frame.origin.y - (((width*0.09661836))*0.5), imageView2.frame.size.width + (width*0.09661836), imageView2.frame.size.height + (width*0.09661836));
        
    } else if (arr.count == 3) {
        
        imageView1.frame = CGRectMake(self.view.frame.size.width*0.185 - ((width*0.09661836)*0.5), height*0.142857, width*0.09661836, ((width*0.09661836)*0.5625));
        label1.frame = CGRectMake(imageView1.frame.origin.x - 50 + ((imageView1.frame.size.width)*0.5), imageView1.frame.origin.y + imageView1.frame.size.height + 2.33, 100, ((imageView1.frame.size.width)*0.325));
        
        view1.frame = CGRectMake(imageView1.frame.origin.x - (((width*0.09661836))*0.5), imageView1.frame.origin.y - (((width*0.09661836))*0.5), imageView1.frame.size.width + (width*0.09661836), imageView1.frame.size.height + (width*0.09661836));
        
        
        
        imageView2.frame = CGRectMake(self.view.frame.size.width*0.395 - ((width*0.09661836)*0.5), height*0.142857, width*0.09661836, ((width*0.09661836)*0.5625));
        label2.frame = CGRectMake(imageView2.frame.origin.x - 50 + ((imageView2.frame.size.width)*0.5), imageView2.frame.origin.y + imageView2.frame.size.height + 2.33, 100, ((width*0.09661836)*0.325));
        
        view2.frame = CGRectMake(imageView2.frame.origin.x - (((width*0.09661836))*0.5), imageView2.frame.origin.y - (((width*0.09661836))*0.5), imageView2.frame.size.width + (width*0.09661836), imageView2.frame.size.height + (width*0.09661836));
        
        
        
        imageView3.frame = CGRectMake(self.view.frame.size.width*0.605 - ((width*0.09661836)*0.5), height*0.142857, width*0.09661836, ((width*0.09661836)*0.5625));
        label3.frame = CGRectMake(imageView3.frame.origin.x - 50 + ((imageView3.frame.size.width)*0.5), imageView3.frame.origin.y + imageView3.frame.size.height + 2.33, 100, ((width*0.09661836)*0.325));
        
        view3.frame = CGRectMake(imageView3.frame.origin.x - (((width*0.09661836))*0.5), imageView3.frame.origin.y - (((width*0.09661836))*0.5), imageView3.frame.size.width + (width*0.09661836), imageView3.frame.size.height + (width*0.09661836));
        
        
        
        _addTaskButton.frame = CGRectMake(self.view.frame.size.width*0.815 - ((width*0.133)*0.5), 0 - ((width*0.133)*0.25), (width*0.133), (width*0.133));
        _addTaskButtonImage.frame = CGRectMake(_addTaskButton.frame.origin.x + (_addTaskButton.frame.size.width*0.5 - ((_addTaskButton.frame.size.width*0.412)*0.5)), _addTaskButton.frame.origin.y + (_addTaskButton.frame.size.height*0.5 - ((_addTaskButton.frame.size.width*0.412)*0.5)), (_addTaskButton.frame.size.width*0.412), (_addTaskButton.frame.size.width*0.412));
        
        
    } else if (arr.count == 4) {
        
        imageView1.frame = CGRectMake(self.view.frame.size.width*0.5 - ((width*0.09661836)*0.5) - width*0.09661836 - self.view.frame.size.width*0.2675, height*0.142857, width*0.09661836, ((width*0.09661836)*0.5625));
        label1.frame = CGRectMake(imageView1.frame.origin.x - 50 + ((imageView1.frame.size.width)*0.5), imageView1.frame.origin.y + imageView1.frame.size.height + 2.33, 100, ((imageView1.frame.size.width)*0.325));
        
        view1.frame = CGRectMake(imageView1.frame.origin.x - (((width*0.09661836))*0.5), imageView1.frame.origin.y - (((width*0.09661836))*0.5), imageView1.frame.size.width + (width*0.09661836), imageView1.frame.size.height + (width*0.09661836));
        
        
        
        imageView2.frame = CGRectMake(self.view.frame.size.width*0.5 - ((width*0.09661836)*0.5) - self.view.frame.size.width*0.195, height*0.142857, width*0.09661836, ((width*0.09661836)*0.5625));
        label2.frame = CGRectMake(imageView2.frame.origin.x - 50 + ((imageView2.frame.size.width)*0.5), imageView2.frame.origin.y + imageView2.frame.size.height + 2.33, 100, ((width*0.09661836)*0.325));
        
        view2.frame = CGRectMake(imageView2.frame.origin.x - (((width*0.09661836))*0.5), imageView2.frame.origin.y - (((width*0.09661836))*0.5), imageView2.frame.size.width + (width*0.09661836), imageView2.frame.size.height + (width*0.09661836));
        
        
        
        _addTaskButton.frame = CGRectMake(width*0.5 - ((width*0.133)*0.5), 0 - ((width*0.133)*0.25), (width*0.133), (width*0.133));
        _addTaskButtonImage.frame = CGRectMake(_addTaskButton.frame.origin.x + (_addTaskButton.frame.size.width*0.5 - ((_addTaskButton.frame.size.width*0.412)*0.5)), _addTaskButton.frame.origin.y + (_addTaskButton.frame.size.height*0.5 - ((_addTaskButton.frame.size.width*0.412)*0.5)), (_addTaskButton.frame.size.width*0.412), (_addTaskButton.frame.size.width*0.412));
        
        
        
        imageView3.frame = CGRectMake(self.view.frame.size.width*0.5 - ((width*0.09661836)*0.5) + self.view.frame.size.width*0.195, height*0.142857, width*0.09661836, ((width*0.09661836)*0.5625));
        label3.frame = CGRectMake(imageView3.frame.origin.x - 50 + ((imageView3.frame.size.width)*0.5), imageView3.frame.origin.y + imageView3.frame.size.height + 2.33, 100, ((width*0.09661836)*0.325));
        
        view3.frame = CGRectMake(imageView3.frame.origin.x - (((width*0.09661836))*0.5), imageView3.frame.origin.y - (((width*0.09661836))*0.5), imageView3.frame.size.width + (width*0.09661836), imageView3.frame.size.height + (width*0.09661836));
        
        
        
        imageView4.frame = CGRectMake(self.view.frame.size.width*0.5 - ((width*0.09661836)*0.5) + width*0.09661836 + self.view.frame.size.width*0.2675, height*0.142857, width*0.09661836, ((width*0.09661836)*0.5625));
        label4.frame = CGRectMake(imageView4.frame.origin.x - 50 + ((imageView4.frame.size.width)*0.5), imageView4.frame.origin.y + imageView4.frame.size.height + 2.33, 100, ((width*0.09661836)*0.325));
        
        view4.frame = CGRectMake(imageView4.frame.origin.x - (((width*0.09661836))*0.5), imageView4.frame.origin.y - (((width*0.09661836))*0.5), imageView4.frame.size.width + (width*0.09661836), imageView4.frame.size.height + (width*0.09661836));
        
    }
    
}

-(void)MainImageHiddenStatus {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if ([(NSArray *)self->chatDict[@"ChatID"] count] == 0) {
            
            self->_emptyTableViewView.hidden = NO;
            
        } else {
            
            self->_emptyTableViewView.hidden = YES;
            
        }
        
    });
    
}

-(void)CompleteQueryData:(NSMutableDictionary *)homeMembersDictLocal homeKeysDictLocal:(NSMutableDictionary *)homeKeysDictLocal homeMembersUnclaimedDictLocal:(NSMutableDictionary *)homeMembersUnclaimedDictLocal itemDictLocal:(NSMutableDictionary *)itemDictLocal lastMessageDictLocal:(NSMutableDictionary *)lastMessageDictLocal unreadNotificationsCountLocal:(NSString *)unreadNotificationsCountLocal notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDictLocal topicDict:(NSMutableDictionary *)topicDictLocal {
    
    self->homeMembersDict = [homeMembersDictLocal mutableCopy];
    self->homeKeysDict = [homeKeysDictLocal mutableCopy];
    self->homeMembersUnclaimedDict = [homeMembersUnclaimedDictLocal mutableCopy];
    self->homeMembersArray = [self->homeMembersDict[@"UserID"] mutableCopy];
    
    self->chatDict = [itemDictLocal mutableCopy];
    self->lastMessageDict = [lastMessageDictLocal mutableCopy];
    self->unreadNotificationsCount = unreadNotificationsCountLocal;
    
    self->notificationSettingsDict = [notificationSettingsDictLocal mutableCopy];
    self->topicDict = [topicDictLocal mutableCopy];
    
    [[NSUserDefaults standardUserDefaults] setObject:self->homeMembersDict forKey:@"HomeMembersDict"];
    [[NSUserDefaults standardUserDefaults] setObject:self->homeKeysDict forKey:@"HomeKeysDict"];
    [[NSUserDefaults standardUserDefaults] setObject:self->homeMembersUnclaimedDict forKey:@"HomeMembersUnclaimedDict"];
    [[NSUserDefaults standardUserDefaults] setObject:self->homeMembersArray forKey:@"HomeMembersArray"];
    
    [[NSUserDefaults standardUserDefaults] setObject:self->chatDict forKey:@"ChatDict"];
    [[NSUserDefaults standardUserDefaults] setObject:self->lastMessageDict forKey:@"LastMessageDict"];
    [[NSUserDefaults standardUserDefaults] setObject:self->unreadNotificationsCount forKey:@"UnreadNotificationsCount"];
    
    [[NSUserDefaults standardUserDefaults] setObject:self->notificationSettingsDict forKey:@"NotificationSettingsDict"];
    [[NSUserDefaults standardUserDefaults] setObject:self->topicDict forKey:@"TopicDict"];
    
    
    
    [self MainImageHiddenStatus];
    [self UpdateNotificationViews];
    [self.customTableView reloadData];
    
    self->EverythingIsThere = YES;
    
}

-(void)CachedInitialData {
    
    if (CachedDictExists) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            self->homeMembersDict = [[[NSUserDefaults standardUserDefaults] objectForKey:@"HomeMembersDict"] mutableCopy];
            self->notificationSettingsDict = [[[NSUserDefaults standardUserDefaults] objectForKey:@"NotificationSettingsDict"] mutableCopy];
            self->topicDict = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TopicDict"] mutableCopy];
            self->taskListDict = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TaskListDict"] mutableCopy];
            self->calendarSettingsDict = [[[NSUserDefaults standardUserDefaults] objectForKey:@"CalendarSettingsDict"] mutableCopy];
            self->chatDict = [[[NSUserDefaults standardUserDefaults] objectForKey:@"ChatDict"] mutableCopy];
            self->lastMessageDict = [[[NSUserDefaults standardUserDefaults] objectForKey:@"LastMessageDict"] mutableCopy];
            self->homeMembersArray = [[[NSUserDefaults standardUserDefaults] objectForKey:@"HomeMembersArray"] mutableCopy];
            self->homeKeysDict = [[[NSUserDefaults standardUserDefaults] objectForKey:@"HomeKeysDict"] mutableCopy];
            self->homeDict = [[[NSUserDefaults standardUserDefaults] objectForKey:@"HomeDict"] mutableCopy];
            self->homeMembersUnclaimedDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeMembersUnclaimedDict"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"HomeMembersUnclaimedDict"] mutableCopy] : [NSMutableDictionary dictionary];
            
            self->EverythingIsThere = YES;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self MainImageHiddenStatus];
                [self->activityControl stopAnimating];
                [self->refreshControl endRefreshing];
                [self.customTableView reloadData];
                
            });
            
        });
        
    }
    
}

-(void)QueryInitialData {
    
    [[[ChatObject alloc] init] QueryDataChatsViewController:homeID keyArray:chatKeyArray messageKeyArray:messageKeyArray completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningHomeMembersDict, NSMutableDictionary * _Nonnull returningHomeKeysDict, NSMutableDictionary * _Nonnull returningHomeMembersUnclaimedDictLocal, NSMutableDictionary * _Nonnull returningItemDict, NSMutableDictionary * _Nonnull returningLastMessageDict, NSString * _Nonnull returningUnreadNotificationsCount, NSMutableDictionary * _Nonnull returningNotificationSettingsDict, NSMutableDictionary * _Nonnull returningTopicDict) {
        
        [self CompleteQueryData:returningHomeMembersDict homeKeysDictLocal:returningHomeKeysDict homeMembersUnclaimedDictLocal:returningHomeMembersUnclaimedDictLocal itemDictLocal:returningItemDict lastMessageDictLocal:returningLastMessageDict unreadNotificationsCountLocal:returningUnreadNotificationsCount notificationSettingsDict:returningNotificationSettingsDict topicDict:returningTopicDict];
        
    }];
    
}

-(void)UpdateNotificationViews {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        CGFloat width = CGRectGetWidth(self.view.bounds);
        CGFloat height = CGRectGetHeight(self.view.bounds);
        
        int totalKeysNotUsed = 0;
        
        if ([[self->homeKeysDict allKeys] count] > 0 || self->homeMembersArray.count > 1) {
            [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"SeenNoInvitationsPopup"];
        }
        
        totalKeysNotUsed = (int)[[self->homeMembersUnclaimedDict allKeys] count];
        
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d", totalKeysNotUsed] forKey:@"InvitiationViewCount"];
        
        float multiple = 1.00;
        
        if ([[NSString stringWithFormat:@"%d", totalKeysNotUsed] length] > 1.00) {
            multiple += (0.33 * ([[NSString stringWithFormat:@"%d", totalKeysNotUsed] length] - 1));
        }
        
        width = CGRectGetWidth(self.view.bounds);
        height = self.view.frame.size.height*0.07201 > 53?(53):self.view.frame.size.height*0.07201;
        
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"SeenNoInvitationsPopup"] isEqualToString:@"Yes"] == NO) {
            
            self->_pendingInvitesView.frame = CGRectMake(self->_homeMemberImage.frame.origin.x + self->_homeMemberImage.frame.size.width - ((self.view.frame.size.width*0.02717391)*0.75), self->_homeMemberImage.frame.origin.y - ((self.view.frame.size.width*0.02717391)*0.25), self.view.frame.size.width*0.02717391, self.view.frame.size.width*0.02717391);
            self->_pendingInvitesLabel.hidden = YES;
            self->_pendingInvitesView.layer.cornerRadius = self->_pendingInvitesView.frame.size.height/2;
            
        } else {
            
            self->_pendingInvitesView.frame = CGRectMake(self->_homeMemberImage.frame.origin.x + self->_homeMemberImage.frame.size.width - ((width*0.04227053)*0.67), self->_homeMemberImage.frame.origin.y - ((width*0.04227053)*0.33), (self.view.frame.size.width*0.04227053)*multiple, width*0.04227053);
            self->_pendingInvitesLabel.hidden = NO;
            self->_pendingInvitesView.layer.cornerRadius = self->_pendingInvitesView.frame.size.height/2;
            
        }
        
        width = CGRectGetWidth(self.pendingInvitesView.bounds);
        height = CGRectGetHeight(self.pendingInvitesView.bounds);
        
        self->_pendingInvitesLabel.frame = CGRectMake(0, 0, width, height);
        self->_pendingInvitesLabel.font = [UIFont systemFontOfSize:height*0.62857143 weight:UIFontWeightSemibold];
        self->_pendingInvitesLabel.adjustsFontSizeToFitWidth = YES;
        
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"SeenNoInvitationsPopup"] isEqualToString:@"Yes"] == NO) {
            totalKeysNotUsed += 1;
        }
        
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"SeenNoInvitationsPopup"] isEqualToString:@"Yes"] == NO) {
            self->_pendingInvitesLabel.hidden = YES;
        } else {
            if (totalKeysNotUsed > 0) {
                self->_pendingInvitesView.hidden = NO;
                self->_pendingInvitesLabel.hidden = NO;
            } else {
                self->_pendingInvitesView.hidden = YES;
                self->_pendingInvitesLabel.hidden = YES;
            }
            self->_pendingInvitesLabel.hidden = NO;
        }
        
        self->_pendingInvitesLabel.text = [NSString stringWithFormat:@"%d", totalKeysNotUsed];
        
        
        
        
        
        NSString *unreadNotificationCount = self->unreadNotificationsCount;
        
        [[NSUserDefaults standardUserDefaults] setObject:unreadNotificationCount forKey:@"NotificationViewCount"];
        
        multiple = 1.00;
        
        if (unreadNotificationCount.length > 1.00) {
            multiple += (0.33 * (unreadNotificationCount.length - 1));
        }
        
        CGRect newRect = self->_notificationsView.frame;
        newRect.size.width = (self.view.frame.size.width*0.04227053)*multiple;
        self->_notificationsView.frame = newRect;
        
        width = CGRectGetWidth(self.notificationsView.bounds);
        height = CGRectGetHeight(self.notificationsView.bounds);
        
        self->_notificationsViewLabel.frame = CGRectMake(0, 0, width, height);
        self->_notificationsViewLabel.font = [UIFont systemFontOfSize:height*0.62857143 weight:UIFontWeightSemibold];
        self->_notificationsViewLabel.adjustsFontSizeToFitWidth = YES;
        
        if ([unreadNotificationCount intValue] > 0) {
            self->_notificationsView.hidden = NO;
            self->_notificationsViewLabel.hidden = NO;
        } else {
            self->_notificationsView.hidden = YES;
            self->_notificationsViewLabel.hidden = YES;
        }
        
        self->_notificationsViewLabel.text = [NSString stringWithFormat:@"%@", unreadNotificationCount];
        
        [self->activityControl stopAnimating];
        [self->refreshControl endRefreshing];
        
        int totalNotifications = totalKeysNotUsed + [unreadNotificationCount intValue];
        
        NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
        BOOL UserCanReceiveBagdeIconNotification = [[[BoolDataObject alloc] init] UserCanReceiveBagdeIconNotification:self->notificationSettingsDict userID:userID];
        
        totalNotifications = UserCanReceiveBagdeIconNotification ? totalNotifications : 0;
        
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:(NSInteger)totalNotifications];
        
    });
    
}

#pragma mark - IBAction Methods

-(IBAction)RefreshPageAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Refresh Page"] completionHandler:^(BOOL finished) {
        
    }];
    
    if (refreshControl == nil){
        
        [activityControl setHidden:NO];
        CGFloat height = CGRectGetHeight(self.view.bounds);
        CGFloat width = CGRectGetWidth(self.view.bounds);
        
        activityControl.frame = CGRectMake((width*0.5)-(12), (height*0.5)-(12)+_customTableView.frame.origin.y, 25, 25);
        activityControl.color = [UIColor grayColor];
        [activityControl startAnimating];
        
        [self.view addSubview:activityControl];
        [self.view bringSubviewToFront:activityControl];
        
    }
    
    [[[ChatObject alloc] init] QueryDataChatsViewController:homeID keyArray:chatKeyArray messageKeyArray:messageKeyArray completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningHomeMembersDict, NSMutableDictionary * _Nonnull returningHomeKeysDict, NSMutableDictionary * _Nonnull returningHomeMembersUnclaimedDictLocal, NSMutableDictionary * _Nonnull returningItemDict, NSMutableDictionary * _Nonnull returningLastMessageDict, NSString * _Nonnull returningUnreadNotificationsCount, NSMutableDictionary * _Nonnull returningNotificationSettingsDict, NSMutableDictionary * _Nonnull returningTopicDict) {
        
        [self CompleteQueryData:returningHomeMembersDict
              homeKeysDictLocal:returningHomeKeysDict
  homeMembersUnclaimedDictLocal:returningHomeMembersUnclaimedDictLocal
         
                  itemDictLocal:returningItemDict
           lastMessageDictLocal:returningLastMessageDict
  unreadNotificationsCountLocal:returningUnreadNotificationsCount
         
       notificationSettingsDict:returningNotificationSettingsDict
                     topicDict : returningTopicDict];
        
    }];
    
}

#pragma mark - Tap Gesture Methods

- (IBAction)TapGestureAddTask:(id)sender {
    
    if ([[[GeneralObject alloc] init] ConnectedToInternet] == NO) {
        [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You need to be connected to the internet to do that." currentViewController:self];
        return;
    }
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Add Chat"] completionHandler:^(BOOL finished) {
        
    }];
    
    if (EverythingIsThere) {
        
        [[[PushObject alloc] init] PushToAddChatViewController:nil homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict topicDict:topicDict currentViewController:self Superficial:NO];
        
    } else {
        
        [[[GeneralObject alloc] init] CreateAlert:@"Oops!" message:@"We're still processing some data, please wait until WeDivvy has fully loaded. 😄" currentViewController:self];
        
    }
    
}

-(IBAction)TapGesturePushToHomeMembersViewController:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Home Members Button Clicked For %@", @"GroupChats"] completionHandler:^(BOOL finished) {
        
    }];
    
    NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
    NSString *homeName = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeName"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeName"] : @"xxx";
    
    [[[PushObject alloc] init] PushToHomeMembersViewController:homeID homeName:homeName notificationSettingsDict:notificationSettingsDict topicDict:topicDict viewingHomeMembersFromHomesViewController:NO currentViewController:self Superficial:NO];
    
}

-(IBAction)TapGesturePushToSettingsViewController:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Settings Icon Clicked For %@", @"GroupChats"] completionHandler:^(BOOL finished) {
        
    }];
    
    [[[PushObject alloc] init] PushToSettingsViewController:NO allItemAssignedToArrays:nil currentViewController:self];
    
}


-(IBAction)TapGesturePushToNotificationsViewController:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Notifications Icon Clicked For %@", @"GroupChats"] completionHandler:^(BOOL finished) {
        
    }];
    
    NSMutableArray *homeMembersArrayLocal = homeMembersArray ? homeMembersArray : [NSMutableArray array];
    NSMutableDictionary *homeMembersDictLocal = homeMembersDict ? homeMembersDict : [NSMutableDictionary dictionary];
    NSMutableDictionary *notificationSettingsDictLocal = notificationSettingsDict ? notificationSettingsDict : [NSMutableDictionary dictionary];
    
    [[[PushObject alloc] init] PushToNotificationsViewController:self homeMembersArray:homeMembersArrayLocal homeMembersDict:homeMembersDictLocal notificationSettingsDict:notificationSettingsDictLocal topicDict:topicDict folderDict:[NSMutableDictionary dictionary] taskListDict:taskListDict templateDict:[NSMutableDictionary dictionary] draftDict:[NSMutableDictionary dictionary] allItemTagsArrays:[NSMutableArray array] allItemIDsArrays:[NSMutableArray array]];
    
}

-(IBAction)TapGesturePushToChoreViewController:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Chores Tab Clicked For %@", @"GroupChats"] completionHandler:^(BOOL finished) {
        
    }];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"ViewDidLoadShouldStart"];
    
    [[[PushObject alloc] init] PushToTasksNavigationController:YES Expenses:NO Lists:NO Animated:NO currentViewController:self];
    
}

-(IBAction)TapGesturePushToExpenseViewController:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Expenses Tab Clicked For %@", @"GroupChats"] completionHandler:^(BOOL finished) {
        
    }];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"ViewDidLoadShouldStart"];
    
    [[[PushObject alloc] init] PushToTasksNavigationController:NO Expenses:YES Lists:NO Animated:NO currentViewController:self];
    
}

-(IBAction)TapGesturePushToListsViewController:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Lists Tab Clicked For %@", @"GroupChats"] completionHandler:^(BOOL finished) {
        
    }];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"ViewDidLoadShouldStart"];
    
    [[[PushObject alloc] init] PushToTasksNavigationController:NO Expenses:NO Lists:YES Animated:NO currentViewController:self];
    
}

-(IBAction)TapGesturePushToGroupChatViewController:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Group Chats Tab Clicked For %@", @"GroupChats"] completionHandler:^(BOOL finished) {
        
    }];
    
    [[[PushObject alloc] init] PushToChatsViewController:self];
    
}

#pragma mark - NSNotification Methods

-(void)NSNotification_Chats_ItemTabBar:(NSNotification *)notification {
    
    NSDictionary *userInfo = notification.userInfo;
    NSMutableArray *tabBarArray = [userInfo[@"TabBar"] mutableCopy];
    
    [[NSUserDefaults standardUserDefaults] setObject:tabBarArray forKey:@"VisibleTabBarOptions"];
    
    [self AdjustTabBarFrame];
    
}

-(void)NSNotification_Chats_AddHomeMember:(NSNotification *)notification {
    
    NSDictionary *dict = [notification.userInfo mutableCopy];
    
    homeMembersArray = dict[@"HomeMembersArray"] ? dict[@"HomeMembersArray"] : [NSMutableArray array];
    homeMembersDict = dict[@"HomeMembersDict"] ? dict[@"HomeMembersDict"] : [NSMutableDictionary dictionary];
    notificationSettingsDict = dict[@"NotificationSettingsDict"] ? dict[@"NotificationSettingsDict"] : [NSMutableDictionary dictionary];
    topicDict = dict[@"TopicDict"] ? dict[@"TopicDict"] : [NSMutableDictionary dictionary];
    
    [[NSUserDefaults standardUserDefaults] setObject:self->homeMembersArray forKey:@"HomeMembersArray"];
    [[NSUserDefaults standardUserDefaults] setObject:self->homeMembersDict forKey:@"HomeMembersDict"];
    [[NSUserDefaults standardUserDefaults] setObject:dict[@"HomeKeysDict"] ? dict[@"HomeKeysDict"] : [NSMutableDictionary dictionary] forKey:@"HomeKeysDict"];
    [[NSUserDefaults standardUserDefaults] setObject:dict[@"HomeKeysArray"] ? dict[@"HomeKeysArray"] : [NSMutableArray array] forKey:@"HomeKeysArray"];
    [[NSUserDefaults standardUserDefaults] setObject:self->notificationSettingsDict forKey:@"NotificationSettingsDict"];
    
}


-(void)NSNotification_Chats_AddChat:(NSNotification *)notification {
    
    NSDictionary *userInfo = notification.userInfo;
    
    if (self->chatDict == nil) {
        
        self->chatDict = [NSMutableDictionary dictionary];
    }
    
    for (NSString *key in chatKeyArray) {
        
        NSMutableArray *arr = self->chatDict[key] ? [self->chatDict[key] mutableCopy] : [NSMutableArray array];
        id object = userInfo[key] ? userInfo[key] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
        [arr addObject:object];
        [self->chatDict setObject:arr forKey:key];
        
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [[NSUserDefaults standardUserDefaults] setObject:self->chatDict forKey:@"ChatDict"];
        [self MainImageHiddenStatus];
        [self.customTableView reloadData];
        
    });
    
}

-(void)NSNotification_Chats_EditChat:(NSNotification *)notification {
    
    NSDictionary *userInfo = notification.userInfo;
    
    if ([chatDict[@"ChatID"] containsObject:userInfo[@"ChatID"]]) {
        
        NSUInteger indexOfObject = [chatDict[@"ChatID"] indexOfObject:userInfo[@"ChatID"]];
        
        for (NSString *key in chatKeyArray) {
            
            NSMutableArray *arr = [self->chatDict[key] mutableCopy];
            if ([arr count] > indexOfObject) { [arr replaceObjectAtIndex:indexOfObject withObject:userInfo[key]]; }
            [self->chatDict setObject:arr forKey:key];
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [[NSUserDefaults standardUserDefaults] setObject:self->chatDict forKey:@"ChatDict"];
            [self.customTableView reloadData];
            
        });
        
    }
    
}

-(void)NSNotification_Chats_DeleteChat:(NSNotification *)notification {
    
    NSDictionary *userInfo = notification.userInfo;
    
    if ([chatDict[@"ChatID"] containsObject:userInfo[@"ChatID"]]) {
        
        NSUInteger indexOfObject = [chatDict[@"ChatID"] indexOfObject:userInfo[@"ChatID"]];
        
        for (NSString *key in chatKeyArray) {
            
            NSMutableArray *arr = [self->chatDict[key] mutableCopy];
            [arr removeObjectAtIndex:indexOfObject];
            [self->chatDict setObject:arr forKey:key];
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [[NSUserDefaults standardUserDefaults] setObject:self->chatDict forKey:@"ChatDict"];
            [self MainImageHiddenStatus];
            [self.customTableView reloadData];
            
        });
        
    }
    
}

-(void)NSNotification_Chats_EditLastMessage:(NSNotification *)notification {
    
    NSDictionary *userInfo = notification.userInfo;
    
    NSString *chatID = userInfo[@"ChatID"] ? userInfo[@"ChatID"] : @"xxx";
    
    NSMutableDictionary *lastMessageDictCopy = lastMessageDict ? [lastMessageDict mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *lastMessageInnerDict = lastMessageDictCopy[chatID] ? [lastMessageDictCopy[chatID] mutableCopy] : [NSMutableDictionary dictionary];
    
    NSString *messageText = userInfo[@"MessageText"] ? userInfo[@"MessageText"] : @"xxx";
    [lastMessageInnerDict setObject:messageText forKey:@"MessageText"];
    
    [lastMessageDictCopy setObject:lastMessageInnerDict forKey:chatID];
    lastMessageDict = [lastMessageDictCopy mutableCopy];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [[NSUserDefaults standardUserDefaults] setObject:self->lastMessageDict forKey:@"LastMessageDict"];
        [self MainImageHiddenStatus];
        [self.customTableView reloadData];
        
    });
    
}

-(void)NSNotification_Chats_ReloadView:(NSNotification *)notification {
    
    [self viewDidLoad];
    [self viewDidAppear:self];
    
}

-(void)NSNotification_Chats_UnusedInvitations:(NSNotification *)userInfo {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSArray *keyArray = [[[GeneralObject alloc] init] GenerateKeyArrayManually:NO Expense:NO List:NO Home:YES];
        NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
        
        [[[GetDataObject alloc] init] GetDataSpecificHomeData:homeID keyArray:keyArray completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningHomeToJoinDict, NSMutableArray * _Nonnull queriedHomeMemberArray, NSString * _Nonnull queriedHomeID) {
            
            self->homeMembersUnclaimedDict = returningHomeToJoinDict[@"HomeMembersUnclaimed"] ? [returningHomeToJoinDict[@"HomeMembersUnclaimed"] mutableCopy] : [NSMutableDictionary dictionary];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                int totalKeysNotUsed = 0;
                
                totalKeysNotUsed = (int)[[self->homeMembersUnclaimedDict allKeys] count];
                
                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d", totalKeysNotUsed] forKey:@"InvitiationViewCount"];
                
                [self SetUpInvitationView];
                [self UpdateNotificationViews];
                
            });
            
        }];
        
    });
    
}

-(void)NSNotification_Chats_UnreadNotifications:(NSNotification *)userInfo {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
        NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
        
        [[[GetDataObject alloc] init] GetDataUnreadNotificationsCountNotCreatedBySpecificUser:homeID userID:userID completionHandler:^(BOOL finished, NSString * _Nonnull unreadNotificationCount) {
            
            self->unreadNotificationsCount = unreadNotificationCount;
            
            [[NSUserDefaults standardUserDefaults] setObject:self->unreadNotificationsCount forKey:@"NotificationViewCount"];
            
            [self SetUpNotificationViewView];
            [self UpdateNotificationViews];
            
        }];
        
    });
    
}

#pragma mark - Table View Methods

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    WideCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WideCell"];
    
    NSString *chatImageURL = chatDict[@"ChatImageURL"][indexPath.row];
    
    if ([chatImageURL containsString:@"gs://"]) {
        
        [[[GetDataObject alloc] init] GetDataItemImage:chatImageURL completionHandler:^(BOOL finished, NSURL * _Nonnull itemImageURL) {
            
            NSData *data = [NSData dataWithContentsOfURL:itemImageURL];
            UIImage *image = [UIImage imageWithData:data];
            
            cell.mainImageView.image = image;
            
        }];
        
    } else {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            UIImage *itemImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:chatImageURL]]];
            cell.mainImageView.image = itemImage;
            
        });
        
    }
    
    cell.titleLabel.text = chatDict[@"ChatName"][indexPath.row];
    
    NSString *chatID = chatDict[@"ChatID"][indexPath.row];
    cell.subLabel.text = lastMessageDict[chatID][@"MessageText"];
    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [(NSArray *)chatDict[@"ChatID"] count];
    
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(WideCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *chatID = chatDict[@"ChatID"] && [(NSArray *)chatDict[@"ChatID"] count] > indexPath.row ? chatDict[@"ChatID"][indexPath.row] : @"";
    NSMutableDictionary *chatMessageDict = lastMessageDict[chatID] ? [lastMessageDict[chatID] mutableCopy] : [NSMutableDictionary dictionary];
    
    NSMutableArray *messageReadArray = chatMessageDict[@"MessageRead"];
    
    cell.unreadView.hidden = [messageReadArray count] == 0 || [messageReadArray containsObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] ? YES : NO;
    
    CGFloat width = CGRectGetWidth(cell.contentView.bounds);
    CGFloat height = CGRectGetHeight(cell.contentView.bounds);
    
    cell.mainImageView.frame = CGRectMake(width*0.04831, height*0.5 - ((height*0.5618)*0.5), height*0.5618, height*0.5618);
    
    cell.titleLabel.frame = CGRectMake(cell.mainImageView.frame.origin.x + cell.mainImageView.frame.size.width + ((width*0.04831)*0.5), cell.mainImageView.frame.origin.y, width*1 - (cell.mainImageView.frame.origin.x + cell.mainImageView.frame.size.width + ((width*0.04831)*0.5)) - width*0.04831, cell.mainImageView.frame.size.height*0.5);
    cell.subLabel.frame = CGRectMake(cell.titleLabel.frame.origin.x, cell.mainImageView.frame.origin.y + cell.mainImageView.frame.size.height - cell.titleLabel.frame.size.height, cell.titleLabel.frame.size.width, cell.titleLabel.frame.size.height);
    cell.unreadView.frame = CGRectMake(width - height*0.112359 - cell.mainImageView.frame.origin.x, height*0.5 - ((height*0.112359)*0.5), height*0.112359, height*0.112359);
    cell.subLabel.frame = CGRectMake(cell.titleLabel.frame.origin.x, cell.mainImageView.frame.origin.y + cell.mainImageView.frame.size.height - cell.titleLabel.frame.size.height, cell.titleLabel.frame.size.width, cell.titleLabel.frame.size.height);
    
    cell.unreadView.frame = CGRectMake(width - height*0.112359 - cell.mainImageView.frame.origin.x, height*0.5 - ((height*0.112359)*0.5), height*0.112359, height*0.112359);
    
    cell.titleLabel.font = [UIFont systemFontOfSize:height*0.175 weight:UIFontWeightBold];
    cell.subLabel.font = [UIFont systemFontOfSize:height*0.1475 weight:UIFontWeightBold];
    
    cell.unreadView.layer.cornerRadius = cell.unreadView.frame.size.height/2;
    cell.unreadView.clipsToBounds = YES;
    
    cell.mainImageView.layer.cornerRadius = cell.mainImageView.frame.size.height/2;
    cell.mainImageView.clipsToBounds = YES;
    cell.mainImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    cell.mainImageView.frame = CGRectMake(width*0.04831, height*0.5 - ((height*0.5618)*0.5), height*0.5618, height*0.5618);
    
    cell.titleLabel.frame = CGRectMake(cell.mainImageView.frame.origin.x + cell.mainImageView.frame.size.width + ((width*0.04831)*0.5), cell.mainImageView.frame.origin.y, width*1 - (cell.mainImageView.frame.origin.x + cell.mainImageView.frame.size.width + ((width*0.04831)*0.5)) - width*0.04831, cell.mainImageView.frame.size.height*0.5);
    
    
    
    cell.titleLabel.font = [UIFont systemFontOfSize:height*0.175 weight:UIFontWeightBold];
    cell.subLabel.font = [UIFont systemFontOfSize:height*0.1475 weight:UIFontWeightBold];
    
    cell.unreadView.layer.cornerRadius = cell.unreadView.frame.size.height/2;
    cell.unreadView.clipsToBounds = YES;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Did Select Group Chat"] completionHandler:^(BOOL finished) {
        
    }];
    
    NSMutableArray *homeMemberArrayToUse = [self->homeMembersDict[@"UserID"] mutableCopy];
    
    if ([self->chatDict[@"ChatAssignedToNewHomeMembers"][indexPath.row] isEqualToString:@"No"]) {
        
        homeMemberArrayToUse = [self->chatDict[@"ChatAssignedTo"][indexPath.row] mutableCopy];
        
        if ([homeMemberArrayToUse containsObject:self->chatDict[@"ChatCreatedBy"][indexPath.row]] == NO) {
            
            [homeMemberArrayToUse addObject:self->chatDict[@"ChatCreatedBy"][indexPath.row]];
            
        }
        
    }
    
    NSString *userID = @"";
    NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
    NSString *chatID = self->chatDict[@"ChatID"] && [(NSArray *)self->chatDict[@"ChatID"] count] > indexPath.row ? self->chatDict[@"ChatID"][indexPath.row] : @"";
    NSString *chatName = self->chatDict[@"ChatName"] && [(NSArray *)self->chatDict[@"ChatName"] count] > indexPath.row ? self->chatDict[@"ChatName"][indexPath.row] : @"";
    NSMutableArray *chatAssignedTo = homeMemberArrayToUse ? [homeMemberArrayToUse mutableCopy] : [NSMutableArray array];
    
    [[[PushObject alloc] init] PushToLiveChatViewControllerFromGroupChatsTab:userID homeID:homeID chatID:chatID chatName:chatName chatAssignedTo:chatAssignedTo homeMembersDict:self->homeMembersDict notificationSettingsDict:notificationSettingsDict topicDict:topicDict currentViewController:self Superficial:NO];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat height = CGRectGetHeight(self.view.bounds);
    return (height*0.12092391 > 89?(89):height*0.12092391);
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

-(UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UIContextualAction *editAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:nil handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        
        if ([[[GeneralObject alloc] init] ConnectedToInternet] == NO) {
            [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You need to be connected to the internet to do that." currentViewController:self];
            return;
        }
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Edit Group Chat"] completionHandler:^(BOOL finished) {
            
        }];
        
        NSMutableDictionary *itemToEditDict = [NSMutableDictionary dictionary];
        
        
        for (NSString *key in self->chatKeyArray) {
            
            id object = self->chatDict[key] && [(NSArray *)self->chatDict[key] count] > indexPath.row ? self->chatDict[key][indexPath.row] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
            [itemToEditDict setObject:object forKey:key];
            
        }
        
        [[[PushObject alloc] init] PushToAddChatViewController:itemToEditDict homeMembersArray:self->homeMembersArray homeMembersDict:self->homeMembersDict notificationSettingsDict:self->notificationSettingsDict topicDict:self->topicDict currentViewController:self Superficial:NO];
        
    }];
    
    UIContextualAction *removeAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:nil handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        
        if ([[[GeneralObject alloc] init] ConnectedToInternet] == NO) {
            [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You need to be connected to the internet to do that." currentViewController:self];
            return;
        }
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Delete Group Chat"] completionHandler:^(BOOL finished) {
            
        }];
        
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *completeUncompleteAction = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self StartProgressView];
            
            NSString *chatID = self->chatDict[@"ChatID"] && [(NSArray *)self->chatDict[@"ChatID"] count] > indexPath.row ? self->chatDict[@"ChatID"][indexPath.row] : @"xxx";
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                [[[DeleteDataObject alloc] init] DeleteAllMessagesInGroupChat:self->homeID chatID:chatID completionHandler:^(BOOL finished) {
                    
                    [[[DeleteDataObject alloc] init] DeleteDataGroupChat:self->homeID chatID:chatID completionHandler:^(BOOL finished, NSError * _Nonnull error) {
                        
                        for (NSString *key in self->chatKeyArray) {
                            
                            NSMutableArray *tempArr = self->chatDict[key] ? [self->chatDict[key] mutableCopy] : [NSMutableArray array];
                            if ([tempArr count] > indexPath.row) { [tempArr removeObjectAtIndex:indexPath.row]; }
                            [self->chatDict setObject:tempArr forKey:key];
                            
                        }
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            [[NSUserDefaults standardUserDefaults] setObject:self->chatDict forKey:@"ChatDict"];
                            [self MainImageHiddenStatus];
                            [self->progressView setHidden:YES];
                            [self.customTableView reloadData];
                            
                        });
                        
                    }];
                    
                }];
                
            });
            
        }];
        
        [completeUncompleteAction setValue:[UIColor systemRedColor] forKey:@"titleTextColor"];
        
        [actionSheet addAction:completeUncompleteAction];
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Delete Group Chat Cancelled"] completionHandler:^(BOOL finished) {
                
            }];
            
        }]];
        
        [self presentViewController:actionSheet animated:YES completion:nil];
        
    }];
    
    editAction.image = [UIImage systemImageNamed:@"pencil"];
    removeAction.image = [UIImage systemImageNamed:@"trash.fill"];
    
    editAction.backgroundColor = _addTaskButton.backgroundColor;
    removeAction.backgroundColor = [UIColor systemPinkColor];
    
    NSMutableArray *actionsArray = [NSMutableArray array];
    
    BOOL GroupChatHasExistingCreatedMember = [homeMembersDict[@"HomeMembers"] containsObject:chatDict[@"ChatCreatedBy"][indexPath.row]];
    
    if ([chatDict[@"ChatCreatedBy"][indexPath.row] isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]]) {
        
        [actionsArray addObject:editAction];
        [actionsArray addObject:removeAction];
        
    }
    
    if (GroupChatHasExistingCreatedMember == NO && [actionsArray containsObject:removeAction] == NO) {
        
        [actionsArray addObject:removeAction];
        
    }
    
    //right to left
    return [UISwipeActionsConfiguration configurationWithActions:actionsArray];
}

@end
