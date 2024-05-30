//
//  NotificationsViewController.m
//  WeDivvy
//
//  Created by Philip Nagel on 10/11/21.
//

#import "NotificationsViewController.h"
#import "WideCell.h"

#import <MRProgress/MRProgressOverlayView.h>

#import "GetDataObject.h"
#import "SetDataObject.h"
#import "GeneralObject.h"
#import "NotificationsObject.h"
#import "PushObject.h"
#import "BoolDataObject.h"
#import "LightDarkModeObject.h"

@interface NotificationsViewController () {
    
    MRProgressOverlayView *progressView;
    
    NSMutableDictionary *notificationsDict;
    NSMutableDictionary *userDict;
    NSArray *keyArray;
    UIRefreshControl *refreshControl;
    
}

@end

@implementation NotificationsViewController

#pragma mark - System Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self StartProgressView];
    
    [self InitMethod];
    
    [self BarButtonItems];
    
    [self NSNotificatinObservers];
    
    [self QueryInitialData:^(BOOL finished) {
        
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
    
    UIWindow *currentwindow = [UIApplication sharedApplication].windows.firstObject;
    UIView *statusBar = [[UIView alloc]initWithFrame:currentwindow.windowScene.statusBarManager.statusBarFrame] ;
    statusBar.backgroundColor = [UIColor whiteColor];
    [currentwindow addSubview:statusBar];
    
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    CGFloat bottomPadding = [[[GeneralObject alloc] init] GetBottomPaddingHeight];
    CGFloat statusBarSizeHeight = [[[GeneralObject alloc] init] GetStatusBarHeight];
    
    _customTableView.frame = CGRectMake(0, statusBarSizeHeight + 8, width, height - statusBarSizeHeight - bottomPadding - 8);
    _emptyTableViewView.frame = CGRectMake(0, 0, width, height*0.5);
    
    width = CGRectGetWidth(_emptyTableViewView.bounds);
    height = CGRectGetHeight(_emptyTableViewView.bounds);
    
    _emptyTableViewImage.frame = CGRectMake(0, 0, width, (self.view.frame.size.height*0.07472826 > 55?(55):self.view.frame.size.height*0.07472826));
    _emptyTableViewTitleLabel.frame = CGRectMake(0, _emptyTableViewImage.frame.origin.y + _emptyTableViewImage.frame.size.height + (self.view.frame.size.height*0.02038043 > 15?(15):self.view.frame.size.height*0.02038043), width, (self.view.frame.size.height*0.03804348 > 28?(28):self.view.frame.size.height*0.03804348));
    _emptyTableViewBodyLabel.frame = CGRectMake(0, _emptyTableViewTitleLabel.frame.origin.y + _emptyTableViewTitleLabel.frame.size.height, width, (self.view.frame.size.height*0.06929348 > 51?(51):self.view.frame.size.height*0.06929348));
    
    _emptyTableViewTitleLabel.font = [UIFont systemFontOfSize:_emptyTableViewTitleLabel.frame.size.height*0.78571429 weight:UIFontWeightBold];
    _emptyTableViewBodyLabel.font = [UIFont systemFontOfSize:_emptyTableViewBodyLabel.frame.size.height*0.29411765 weight:UIFontWeightRegular];
    
    CGRect newRect = _emptyTableViewView.frame;
    newRect.size.height = _emptyTableViewImage.frame.size.height + (self.view.frame.size.height*0.02038043 > 15?(15):self.view.frame.size.height*0.02038043) + _emptyTableViewTitleLabel.frame.size.height + _emptyTableViewBodyLabel.frame.size.height;
    newRect.origin.y = self.view.frame.size.height*0.5 - newRect.size.height*0.5;
    _emptyTableViewView.frame = newRect;
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [[NSUserDefaults standardUserDefaults] setObject:[[[GeneralObject alloc] init] GenerateItemType] forKey:@"TempItemType"];
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        self.view.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        self.navigationController.navigationBar.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        
        [self preferredStatusBarStyle];
        
        UIWindow *currentwindow = [UIApplication sharedApplication].windows.firstObject;
        UIView *statusBar = [[UIView alloc]initWithFrame:currentwindow.windowScene.statusBarManager.statusBarFrame] ;
        statusBar.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        [currentwindow addSubview:statusBar];
        
    } else {
        
        self.navigationController.navigationBar.backgroundColor = [[[LightDarkModeObject alloc] init] LightModeSecondary];
        
        UIWindow *currentwindow = [UIApplication sharedApplication].windows.firstObject;
        UIView *statusBar = [[UIView alloc]initWithFrame:currentwindow.windowScene.statusBarManager.statusBarFrame] ;
        statusBar.backgroundColor = self.view.backgroundColor;
        [currentwindow addSubview:statusBar];
        
    }
    
}

#pragma mark - Init Methods

-(void)InitMethod {
    
    [self SetUpAnalytics];
    
    [self SetUpUI];
    
    [self SetUpTableView];
    
    [self SetUpEmptyTableViewView];
    
}

-(void)BarButtonItems {
    
    self.navigationItem.hidesBackButton = YES;
    
    UIBarButtonItem *barButtonItem;
    
    barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(NavigationBackButtonAction:)];
    
    self.navigationItem.leftBarButtonItem = barButtonItem;
    
    barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Read All" style:UIBarButtonItemStyleDone target:self action:@selector(ReadAllAction:)];
    
    self.navigationItem.rightBarButtonItem = barButtonItem;
    
}

-(void)NSNotificatinObservers {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_Notifications_AddHomeMember" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_Notifications_AddHomeMember:) name:@"NSNotification_Notifications_AddHomeMember" object:nil];
    
}

-(void)QueryInitialData:(void (^)(BOOL finished))finishBlock {
    
    NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
    keyArray = [[[GeneralObject alloc] init] GenerateNotificationsKeyArray];
  
    [[[GetDataObject alloc] init] GetDataNotificationsNotCreatedBySpecificUser:homeID userID:userID keyArray:keyArray completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningDataDict) {
    
        [self SortNotificationDictByDate];
        
        self->userDict = self->_homeMembersDict ? [self->_homeMembersDict mutableCopy] : [NSMutableDictionary dictionary];
        
        self->notificationsDict = [[[GeneralObject alloc] init] GenerateDictOfArraysInReverse:[returningDataDict mutableCopy]];
        
        [self EmptyTableViewHiddenStatus];
        [self UpdateBadgeNumber];
        
        [self->_customTableView reloadData];
        [self->progressView setHidden:YES];
        
        finishBlock(YES);
        
    }];
    
}

#pragma mark - SetUp Methods

-(void)SetUpAnalytics {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewViewController:@"NotificationsViewController" completionHandler:^(BOOL finished) {
        
    }];
    
    [[[GeneralObject alloc] init] TrackInMixPanel:@"NotificationsViewController"];
    
}

-(void)SetUpUI {
    
    if (refreshControl == nil){
        refreshControl = [[UIRefreshControl alloc] init];
    }
    
    refreshControl.tintColor = [UIColor lightGrayColor];
    [refreshControl addTarget:self action:@selector(RefreshPageAction:) forControlEvents:UIControlEventValueChanged];
    [_customTableView addSubview:refreshControl];
    
}

-(void)SetUpTableView {
    
    _customTableView.delegate = self;
    _customTableView.dataSource = self;
    _customTableView.estimatedRowHeight = 89;
    _customTableView.rowHeight = UITableViewAutomaticDimension;
    
}

-(void)SetUpEmptyTableViewView {
    
    _emptyTableViewView.hidden = YES;
    
    _emptyTableViewImage.image = [UIImage imageNamed:@"EmptyViewIcons.NoNotifications.png"];
    _emptyTableViewTitleLabel.text = @"Your Notifications";
    _emptyTableViewBodyLabel.text = @"Your home's notifications will show up here.";
    
}

#pragma mark - Custom Methods

-(void)StartProgressView {
    
    self->progressView = [MRProgressOverlayView showOverlayAddedTo:self.navigationController.view animated:YES];
    self->progressView.mode = MRProgressOverlayViewModeIndeterminateSmall;
    
}

-(void)EmptyTableViewHiddenStatus {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        BOOL ItemFound = NO;
        
        ItemFound = [(NSArray *)self->notificationsDict[@"NotificationID"] count] > 0;
        
        self->_emptyTableViewView.hidden = ItemFound;
        
    });
    
}

-(void)FoundUnreadNotification {
    
    BOOL unreadNotificationFound = false;
    
    if (self->notificationsDict[@"NotificationID"]) {
        
        for (NSMutableArray *notificationID in self->notificationsDict[@"NotificationID"]) {
            
            NSUInteger index = [self->notificationsDict[@"NotificationID"] indexOfObject:notificationID];
            NSMutableArray *notificationRead = [(NSArray *)self->notificationsDict[@"NotificationRead"] count] > index ? [self->notificationsDict[@"NotificationRead"][index] mutableCopy] : [NSMutableArray array];
            NSString *notificationCreated = [(NSArray *)self->notificationsDict[@"NotificationDateCreated"] count] > index ? self->notificationsDict[@"NotificationDateCreated"][index] : @"";
            
            BOOL UserSignedUpAfterNotificationWasCreated = [[[NotificationsObject alloc] init] UserSignedUpAfterNotificationWasCreated:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] notificationDatePosted:notificationCreated];
            
            if ([notificationRead containsObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] == NO && UserSignedUpAfterNotificationWasCreated == NO) {
                
                unreadNotificationFound = true;
                
            }
            
        }
        
    }
    
    if (unreadNotificationFound == true) {
        
        [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"DisplayUnreadView"];
        
    } else {
        
        [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"DisplayUnreadView"];
        
    }
    
}

-(void)UpdateBadgeNumber {
    
    int totalUnreadNotifications = 0;
    
    if (self->notificationsDict[@"NotificationRead"]) {
        
        for (NSMutableArray *notificationRead in self->notificationsDict[@"NotificationRead"]) {
            
            if ([notificationRead containsObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] == NO) {
                
                totalUnreadNotifications += 1;
                
            }
            
        }
        
    }
    
    int customCount = 0;
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"InvitiationViewCount"]) {
        customCount = [[[NSUserDefaults standardUserDefaults] objectForKey:@"InvitiationViewCount"] intValue];
    }
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"SeenNoInvitationsPopup"] isEqualToString:@"Yes"] == NO) {
        customCount += 1;
    }
    
    customCount += totalUnreadNotifications;
    
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
    BOOL UserCanReceiveBagdeIconNotification = [[[BoolDataObject alloc] init] UserCanReceiveBagdeIconNotification:_notificationSettingsDict userID:userID];
    
    customCount = UserCanReceiveBagdeIconNotification ? customCount : 0;
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:customCount];
    
    [[[GeneralObject alloc] init] CallNSNotificationMethods:@"UnreadNotifications" userInfo:nil locations:@[@"Tasks", @"Chats"]];
    
}

#pragma mark - IBAction Methods

-(IBAction)ReadAllAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Read All Notifications Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Would you like mark all notifications as read?"] message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *completeUncompleteAction = [UIAlertAction actionWithTitle:@"Read All" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Reading All Notifications"] completionHandler:^(BOOL finished) {
            
        }];
        
//        [self StartProgressView];
        
        NSMutableArray *arrayOfUnreadNotificationIDs = [NSMutableArray array];
        
        if (self->notificationsDict[@"NotificationID"]) {
            
            for (NSString *notificationID in self->notificationsDict[@"NotificationID"]) {
                
                NSUInteger index = [self->notificationsDict[@"NotificationID"] indexOfObject:notificationID];
                
                NSMutableArray *notificationReadArray = [(NSArray *)self->notificationsDict[@"NotificationRead"] count] > index ? [self->notificationsDict[@"NotificationRead"][index] mutableCopy] : [NSMutableArray array];
                
                if ([notificationReadArray containsObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] == NO) {
                    
                    [arrayOfUnreadNotificationIDs addObject:notificationID];
                    
                }
                
            }
            
        }
        
        if (arrayOfUnreadNotificationIDs.count > 0) {
            
            NSMutableArray *objectArr = [NSMutableArray array];
            
            for (NSString *notificationID in arrayOfUnreadNotificationIDs) {
                
                if ([self->notificationsDict[@"NotificationID"] containsObject:notificationID]) {
                    
                    NSUInteger index = [self->notificationsDict[@"NotificationID"] indexOfObject:notificationID];
                    
                    NSMutableArray *notificationReadArray = [(NSArray *)self->notificationsDict[@"NotificationRead"] count] > index ? [self->notificationsDict[@"NotificationRead"][index] mutableCopy] : [NSMutableArray array];
                    [notificationReadArray addObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx"];
                    
                    NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
                    
                    if ([[[GeneralObject alloc] init] AddToObjectArrAndCheckIfQueryHasEnded:arrayOfUnreadNotificationIDs objectArr:objectArr]) {
                        
                        for (NSString *notificationID in arrayOfUnreadNotificationIDs) {
                            
                            if ([self->notificationsDict[@"NotificationID"] containsObject:notificationID]) {
                                
                                NSUInteger index = [self->notificationsDict[@"NotificationID"] indexOfObject:notificationID];
                                
                                NSMutableArray *notificationReadArray = [self->notificationsDict[@"NotificationRead"][index] mutableCopy];
                                
                                if ([notificationReadArray containsObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] == NO) {
                                    [notificationReadArray addObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
                                }
                                
                                [self->notificationsDict[@"NotificationRead"] setObject:notificationReadArray atIndex:index];
                                
                                [self UpdateBadgeNumber];
                                [self FoundUnreadNotification];
                                
                                [self.customTableView reloadData];
                                [self->progressView setHidden:YES];
                                
                                [[[GeneralObject alloc] init] CallNSNotificationMethods:@"UnreadNotifications" userInfo:nil locations:@[@"Tasks", @"Chats"]];
                                
                            }
                            
                        }
                        
                    }
                    
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        
                        [[[SetDataObject alloc] init] UpdateDataNotification:homeID notificationID:notificationID notificationReadArray:notificationReadArray completionHandler:^(BOOL finished) {
                            
                        }];
                        
                    });
                    
                }
                
            }
            
        } else {
            
            [self.customTableView reloadData];
            [self->progressView setHidden:YES];
            
        }
        
    }];
    
    [actionSheet addAction:completeUncompleteAction];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Real All Cancelled"] completionHandler:^(BOOL finished) {
            
        }];
        
    }]];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
    
}

-(IBAction)RefreshPageAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Refresh Page"] completionHandler:^(BOOL finished) {
        
    }];
    
    if (refreshControl == nil){
        
        //        [self StartProgressView];
        
    }
    
    [self QueryInitialData:^(BOOL finished) {
        
        [self->refreshControl endRefreshing];
        
        [self.customTableView reloadData];
        
    }];
    
}

-(IBAction)NavigationBackButtonAction:(UIBarButtonItem *)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Navigation Back Button Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"TempItemType"] isEqualToString:@"Expense"]) {
        
        [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"ViewingExpenses"];
        [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"ViewingLists"];
        [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"ViewingChats"];
        
    } else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"TempItemType"] isEqualToString:@"List"]) {
        
        [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"ViewingExpenses"];
        [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"ViewingLists"];
        [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"ViewingChats"];
        
    } else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"TempItemType"] isEqualToString:@"GroupChat"]) {
        
        [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"ViewingExpenses"];
        [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"ViewingLists"];
        [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"ViewingChats"];
        
    } else {
        
        [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"ViewingExpenses"];
        [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"ViewingLists"];
        [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"ViewingChats"];
        
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - Table View Methods

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    WideCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WideCell"];
    
    cell.titleLabel.text = notificationsDict[@"NotificationTitle"][indexPath.row];
    
    NSString *notificationBody = notificationsDict[@"NotificationBody"][indexPath.row];
    
    for (NSString *userID in userDict[@"UserID"]) {
        
        if ([notificationBody containsString:userID]) {
            
            if ([userDict[@"UserID"] containsObject:userID]) {
                
                NSUInteger index = [userDict[@"UserID"] indexOfObject:userID];
                
                notificationBody = [[[GeneralObject alloc] init] GenerateStringWithReplacementString:notificationBody stringToReplace:userID replacementString:[(NSArray *)userDict[@"Username"] count] > index ? userDict[@"Username"][index] : @""];
                
            }
            
        }
        
    }
    
    cell.timeLabel.text = [[[GeneralObject alloc] init] GetDisplayTimeSinceDate:notificationsDict[@"NotificationDateCreated"][indexPath.row] shortStyle:NO reallyShortStyle:YES];
    
    cell.subLabel.text = notificationBody;
    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [(NSArray *)notificationsDict[@"NotificationID"] count];
    
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(WideCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BOOL UserSignedUpAfterNotificationWasCreated = [[[NotificationsObject alloc] init] UserSignedUpAfterNotificationWasCreated:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] notificationDatePosted:notificationsDict[@"NotificationDateCreated"][indexPath.row]];
    
    if ([notificationsDict[@"NotificationRead"][indexPath.row] containsObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] == NO && UserSignedUpAfterNotificationWasCreated == NO) {
        
        cell.unreadView.hidden = NO;
        cell.titleLabel.textColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTextPrimary] : [[[LightDarkModeObject alloc] init] LightModeTextPrimary];
        cell.subLabel.alpha = 1;
        
    } else {
        
        cell.unreadView.hidden = YES;
        cell.titleLabel.textColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTextSecondary] : [UIColor colorWithRed:167.0f/255.0f green:176.0f/255.0f blue:185.0f/255.0f alpha:1.0];
        cell.subLabel.alpha = 0.75;
        
    }
    
    
    
    CGFloat width = CGRectGetWidth(cell.contentView.bounds);
    CGFloat height = CGRectGetHeight(cell.contentView.bounds);
    
    cell.titleLabel.frame = CGRectMake(width*0.04831, height*0.5 - (height*0.281) - 2, width*0.751, (height*0.281));
    cell.subLabel.frame = CGRectMake(cell.titleLabel.frame.origin.x, height*0.5 + 2, width*0.86, cell.titleLabel.frame.size.height);
    cell.unreadView.frame = CGRectMake(width - ((height*0.112359 > 10?(10):height*0.112359)) - cell.titleLabel.frame.origin.x, height*0.5 - (((height*0.112359 > 10?(10):height*0.112359))*0.5), (height*0.112359 > 10?(10):height*0.112359), (height*0.112359 > 10?(10):height*0.112359));
    cell.timeLabel.frame = CGRectMake(cell.unreadView.frame.origin.x - (width*0.08937198) - (width*0.01932367), cell.titleLabel.frame.origin.y, width*0.08937198, cell.titleLabel.frame.size.height);
    
    cell.titleLabel.font = [UIFont systemFontOfSize:(height*0.175 > 17?(17):height*0.175) weight:UIFontWeightBold];
    cell.subLabel.font = [UIFont systemFontOfSize:(height*0.56 > 14?(14):height*0.56) weight:UIFontWeightBold];
    cell.timeLabel.font = [UIFont systemFontOfSize:(height*0.52 > 13?(13):height*0.52) weight:UIFontWeightMedium];
    
    cell.unreadView.layer.cornerRadius = cell.unreadView.frame.size.height/2;
    cell.unreadView.clipsToBounds = YES;
    
    
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        cell.contentView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        
        [self preferredStatusBarStyle];
        
        UIWindow *currentwindow = [UIApplication sharedApplication].windows.firstObject;
        UIView *statusBar = [[UIView alloc]initWithFrame:currentwindow.windowScene.statusBarManager.statusBarFrame] ;
        statusBar.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        [currentwindow addSubview:statusBar];
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Did Select Notification %@", notificationsDict[@"NotificationTitle"][indexPath.row]] completionHandler:^(BOOL finished) {
        
    }];
    
    if ([notificationsDict[@"NotificationTitle"][indexPath.row] containsString:@"New Home Member"] == NO) {
        
//        [self StartProgressView];
        
    }
    
    NSMutableArray *notificationReadArray = [notificationsDict[@"NotificationRead"][indexPath.row] mutableCopy];
    
    if ([notificationReadArray containsObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] == NO) {
        [notificationReadArray addObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
    }
    
    NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"notificationID == %@", notificationsDict[@"NotificationID"][indexPath.row]];
    [[[SetDataObject alloc] init] SetDataEditCoreData:@"Notifications" predicate:predicate setDataObject:@{@"NotificationRead" : notificationReadArray}];
    
    [self->notificationsDict[@"NotificationRead"] setObject:notificationReadArray atIndex:indexPath.row];
    
    [self UpdateBadgeNumber];
    [self FoundUnreadNotification];
    
    NSString *notificationID = self->notificationsDict[@"NotificationItemID"] && [(NSArray *)self->notificationsDict[@"NotificationItemID"] count] > indexPath.row ? self->notificationsDict[@"NotificationItemID"][indexPath.row] : @"";
    NSString *notificationOccurrenceID = self->notificationsDict[@"NotificationItemOccurrenceID"] && [(NSArray *)self->notificationsDict[@"NotificationItemOccurrenceID"] count] > indexPath.row ? self->notificationsDict[@"NotificationItemOccurrenceID"][indexPath.row] : @"";
    NSString *notificationItemCollection = self->notificationsDict[@"NotificationItemCollection"] && [(NSArray *)self->notificationsDict[@"NotificationItemCollection"] count] > indexPath.row ? self->notificationsDict[@"NotificationItemCollection"][indexPath.row] : @"";
    
    if ([notificationID isEqualToString:@""] == NO) {
        
        if ([notificationItemCollection isEqualToString:@"Chores"] || [notificationItemCollection isEqualToString:@"Expenses"] || [notificationItemCollection isEqualToString:@"Lists"]) {
            
            BOOL CollectionIsExpense = [notificationItemCollection isEqualToString:@"Expenses"];
            BOOL CollectionIsList = [notificationItemCollection isEqualToString:@"Lists"];
            
            [[NSUserDefaults standardUserDefaults] setObject:CollectionIsExpense == YES ? @"Yes" : @"No" forKey:@"ViewingExpenses"];
            [[NSUserDefaults standardUserDefaults] setObject:CollectionIsList == YES ? @"Yes" : @"No" forKey:@"ViewingLists"];
            [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"ViewingChats"];
            
            [[[PushObject alloc] init] PushToViewTaskViewController:notificationID itemOccurrenceID:notificationOccurrenceID itemDictFromPreviousPage:[NSMutableDictionary dictionary] homeMembersArray:_homeMembersArray homeMembersDict:_homeMembersDict itemOccurrencesDict:[NSMutableDictionary dictionary] folderDict:_folderDict taskListDict:_taskListDict templateDict:_templateDict draftDict:_draftDict notificationSettingsDict:_notificationSettingsDict topicDict:_topicDict itemNamesAlreadyUsed:_itemNamesAlreadyUsed allItemAssignedToArrays:_allItemAssignedToArrays allItemTagsArrays:_allItemTagsArrays allItemIDsArrays:_allItemIDsArrays currentViewController:self Superficial:NO];
 
        } else if ([notificationItemCollection isEqualToString:@"GroupChats"]) {
            
            [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"ViewingExpenses"];
            [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"ViewingLists"];
            [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"ViewingChats"];
            
            NSString *userID = @"";
            NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
            NSString *chatID = notificationID;
            NSString *chatName = @"";
            NSMutableArray *chatAssignedTo = self->userDict[@"UserID"] ? [self->userDict[@"UserID"] mutableCopy] : [NSMutableArray array];
            
            [[[PushObject alloc] init] PushToLiveChatViewControllerFromGroupChatsTab:userID homeID:homeID chatID:chatID chatName:chatName chatAssignedTo:chatAssignedTo homeMembersDict:self->_homeMembersDict notificationSettingsDict:self->_notificationSettingsDict topicDict:self->_topicDict currentViewController:self Superficial:NO];
            
        }
        
    }
    
    [self.customTableView reloadData];
    [self->progressView setHidden:YES];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[SetDataObject alloc] init] UpdateDataNotification:homeID notificationID:self->notificationsDict[@"NotificationID"][indexPath.row] notificationReadArray:notificationReadArray completionHandler:^(BOOL finished) {
            
        }];
        
    });
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

-(UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UIContextualAction *ReadAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:nil handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Trailing Swipe Read Notification"] completionHandler:^(BOOL finished) {
            
        }];
        
//        [self StartProgressView];
        
        NSMutableArray *notificationReadArray = [self->notificationsDict[@"NotificationRead"][indexPath.row] mutableCopy];
        
        if ([notificationReadArray containsObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] == NO) {
            [notificationReadArray addObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
        }
       
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"notificationID == %@", self->notificationsDict[@"NotificationID"][indexPath.row]];
        [[[SetDataObject alloc] init] SetDataEditCoreData:@"Notifications" predicate:predicate setDataObject:@{@"NotificationRead" : notificationReadArray}];
        
        [self->notificationsDict[@"NotificationRead"] setObject:notificationReadArray atIndex:indexPath.row];
        
        [self UpdateBadgeNumber];
        [self FoundUnreadNotification];
        
        [self.customTableView reloadData];
        [self->progressView setHidden:YES];
        
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"UnreadNotifications" userInfo:nil locations:@[@"Tasks", @"Chats"]];
       
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
            
            [[[SetDataObject alloc] init] UpdateDataNotification:homeID notificationID:self->notificationsDict[@"NotificationID"][indexPath.row] notificationReadArray:notificationReadArray completionHandler:^(BOOL finished) {
                
            }];
            
        });
        
    }];
    
    ReadAction.image = [UIImage systemImageNamed:@"envelope.open.fill"];
    ReadAction.backgroundColor = [[[GeneralObject alloc] init] GenerateAppColor:1.0f];
    //ReadAction.backgroundColor = [UIColor colorWithRed:16.0f/255.0f green:156.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
    
    NSMutableArray *actionsArray = [NSMutableArray array];
    
    BOOL UserSignedUpAfterNotificationWasCreated = [[[NotificationsObject alloc] init] UserSignedUpAfterNotificationWasCreated:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] notificationDatePosted:notificationsDict[@"NotificationDateCreated"][indexPath.row]];
    
    if ([notificationsDict[@"NotificationRead"][indexPath.row] containsObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] == NO && UserSignedUpAfterNotificationWasCreated == NO) {
        
        [actionsArray addObject:ReadAction];
        
    }
    
    //right to left
    return [UISwipeActionsConfiguration configurationWithActions:actionsArray];
    
}

#pragma mark - Notification Methods

-(void)NSNotification_Notifications_AddHomeMember:(NSNotification *)notification {
    
    NSDictionary *dict = [notification.userInfo mutableCopy];
    
    _homeMembersArray = dict[@"HomeMembersArray"] ? dict[@"HomeMembersArray"] : [NSMutableArray array];
    _homeMembersDict = dict[@"HomeMembersDict"] ? dict[@"HomeMembersDict"] : [NSMutableDictionary dictionary];
    _notificationSettingsDict = dict[@"NotificationSettingsDict"] ? dict[@"NotificationSettingsDict"] : [NSMutableDictionary dictionary];
    
    [[NSUserDefaults standardUserDefaults] setObject:self->_homeMembersArray forKey:@"HomeMembersArray"];
    [[NSUserDefaults standardUserDefaults] setObject:self->_homeMembersDict forKey:@"HomeMembersDict"];
    [[NSUserDefaults standardUserDefaults] setObject:dict[@"HomeKeysDict"] ? dict[@"HomeKeysDict"] : [NSMutableDictionary dictionary] forKey:@"HomeKeysDict"];
    [[NSUserDefaults standardUserDefaults] setObject:dict[@"HomeKeysArray"] ? dict[@"HomeKeysArray"] : [NSMutableArray array] forKey:@"HomeKeysArray"];
    [[NSUserDefaults standardUserDefaults] setObject:self->_notificationSettingsDict forKey:@"NotificationSettingsDict"];
    
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Internal Methods
#pragma mark
#pragma mark
#pragma mark -

#pragma mark Query Methods

-(void)SortNotificationDictByDate {
    
    NSArray *keyArray = [[[GeneralObject alloc] init] GenerateNotificationsKeyArray];
    NSMutableArray *sortedArray = [[[GeneralObject alloc] init] SortArrayOfDates:[self->notificationsDict[@"NotificationDateCreated"] mutableCopy] dateFormatString:@"yyyy-MM-dd HH:mm:ss"];
    NSMutableDictionary *newNotificationsDict = [NSMutableDictionary dictionary];
    
    NSMutableArray *datedCreatedArrayTemp = [self->notificationsDict[@"NotificationDateCreated"] mutableCopy];
    
    for (int i=0;i<sortedArray.count;i++) {
        
        NSString *sortedDate = sortedArray[i];
        
        if ([datedCreatedArrayTemp containsObject:sortedDate]) {
            
            NSUInteger index = [datedCreatedArrayTemp indexOfObject:sortedDate];
            
            for (NSString *key in keyArray) {
                
                NSMutableArray *arr = newNotificationsDict[key] ? [newNotificationsDict[key] mutableCopy] : [NSMutableArray array];
                id object = self->notificationsDict[key] && [(NSArray *)self->notificationsDict[key] count] > index ? self->notificationsDict[key][index] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                [arr addObject:object];
                [newNotificationsDict setObject:arr forKey:key];
                
            }
            
            if ([datedCreatedArrayTemp count] > index) { [datedCreatedArrayTemp replaceObjectAtIndex:index withObject:@"xxx"]; }
            
        }
        
    }
    
    self->notificationsDict = [newNotificationsDict mutableCopy];
    
}

@end
