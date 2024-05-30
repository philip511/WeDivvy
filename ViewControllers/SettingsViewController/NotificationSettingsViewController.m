//
//  NotificationSettingsViewController.m
//  WeDivvy
//
//  Created by Philip Nagel on 8/3/22.
//

#import "NotificationSettingsViewController.h"

#import <MRProgressOverlayView.h>

#import "GeneralObject.h"
#import "SetDataObject.h"
#import "BoolDataObject.h"
#import "LightDarkModeObject.h"
#import "PushObject.h"

#import "ScheduledSummaryCell.h"
#import "OptionsCell.h"

@interface NotificationSettingsViewController () {
    
    MRProgressOverlayView *progressView;
    
    UITextField *customTextField;
    
    NSMutableDictionary *itemSelectedDict;
    NSMutableArray *taskTypesArray;
    NSMutableArray *dueDatesArray;
    NSMutableArray *priorityArray;
    NSMutableArray *colorArray;
    NSMutableArray *tagsArray;
    NSMutableArray *assignedToArray;
    NSMutableArray *assignedToIDArray;
    
    NSMutableArray *frequencyHourArray;
    NSMutableArray *frequencyMinuteArray;
    NSMutableArray *frequencyAMPMArray;
    
    NSString *hourComp;
    NSString *minuteComp;
    NSString *AMPMComp;
    
    UILabel *daysOfTheWeekTopLabel;
    UILabel *mainNotificationsTopLabel;
    UILabel *otherNotificationsTopLabel;
    UILabel *itemTypeTopLabel;
    UILabel *markingTopLabel;
    UILabel *usersTopLabel;
    UILabel *remindersTopLabel;
    UILabel *subtasksTopLabel;
    UILabel *markingSubtasksTopLabel;
    UILabel *itemizedItemsTopLabel;
    UILabel *listItemsTopLabel;
    UILabel *messagesTopLabel;
    UILabel *invitationsTopLabel;
    UILabel *homeMembersTopLabel;
    UILabel *upvotesTopLabel;
    UILabel *scheduleTopLabel;
    UILabel *taskTypesTopLabel;
    UILabel *dueDatesTopLabel;
    UILabel *priorityTopLabel;
    UILabel *colorTopLabel;
    UILabel *tagsTopLabel;
    UILabel *assignedToTopLabel;
    UILabel *notificationTaskTypesTopLabel;
    
    UIView *allowNotificationsView;
    UILabel *allowNotificationsLabel;
    UISwitch *allowNotificationsSwitch;
    
    UIView *daysOfTheWeekView;
    UIView *daysOfTheWeekMondayView;
    UILabel *daysOfTheWeekMondayLabel;
    UIView *daysOfTheWeekTuesdayView;
    UILabel *daysOfTheWeekTuesdayLabel;
    UIView *daysOfTheWeekWednesdayView;
    UILabel *daysOfTheWeekWednesdayLabel;
    UIView *daysOfTheWeekThursdayView;
    UILabel *daysOfTheWeekThursdayLabel;
    UIView *daysOfTheWeekFridayView;
    UILabel *daysOfTheWeekFridayLabel;
    UIView *daysOfTheWeekSaturdayView;
    UILabel *daysOfTheWeekSaturdayLabel;
    UIView *daysOfTheWeekSundayView;
    UILabel *daysOfTheWeekSundayLabel;
    
    UIView *soundsView;
    UILabel *soundsLabel;
    UISwitch *soundsSwitch;
    
    UIView *soundsSubView;
    UILabel *soundsSubLabel;
    UILabel *soundsSubLabelNo2;
    UIImageView *soundsSubArrowImage;
    
    UIView *badgeIconView;
    UILabel *badgeIconLabel;
    UISwitch *badgeIconSwitch;
    
    UIView *notificationSummaryView;
    UILabel *notificationSummaryLabel;
    UIImageView *notificationSummaryArrowImage;
    
    UIView *choresView;
    UILabel *choresLabel;
    UIImageView *choresArrowImage;
    
    UIView *expensesView;
    UILabel *expensesLabel;
    UIImageView *expensesArrowImage;
    
    UIView *listsView;
    UILabel *listsLabel;
    UIImageView *listsArrowImage;
    
    UIView *groupChatsView;
    UILabel *groupChatsLabel;
    UIImageView *groupChatsArrowImage;
    
    UIView *homeMembersView;
    UILabel *homeMembersLabel;
    UIImageView *homeMembersArrowImage;
    
    UIView *forumView;
    UILabel *forumLabel;
    UIImageView *forumArrowImage;
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    UIView *addingView;
    UILabel *addingLabel;
    UISwitch *addingSwitch;
    
    UIView *editingView;
    UILabel *editingLabel;
    UISwitch *editingSwitch;
    
    UIView *deletingView;
    UILabel *deletingLabel;
    UISwitch *deletingSwitch;
    
    UIView *duplicatingView;
    UILabel *duplicatingLabel;
    UISwitch *duplicatingSwitch;
    
    UIView *waivingsView;
    UILabel *waivingLabel;
    UISwitch *waivingSwitch;
    
    UIView *skippingsView;
    UILabel *skippingLabel;
    UISwitch *skippingSwitch;
    
    UIView *pauseUnpauseView;
    UILabel *pauseUnpauseLabel;
    UISwitch *pauseUnpauseSwitch;
    
    UIView *commentsView;
    UILabel *commentsLabel;
    UISwitch *commentsSwitch;
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    UIView *skippingTurnView;
    UILabel *skippingTurnLabel;
    UISwitch *skippingTurnSwitch;
    
    UIView *removingUserView;
    UILabel *removingUserLabel;
    UISwitch *removingUserSwitch;
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    UIView *fullyCompletedView;
    UILabel *fullyCompletedLabel;
    UISwitch *fullyCompletedSwitch;
    
    UIView *completedView;
    UILabel *subLabel;
    UISwitch *completedSwitch;
    
    UIView *inProgressView;
    UILabel *inProgressLabel;
    UISwitch *inProgressSwitch;
    
    UIView *wontDoView;
    UILabel *wontDoLabel;
    UISwitch *wontDoSwitch;
    
    UIView *acceptView;
    UILabel *acceptLabel;
    UISwitch *acceptSwitch;
    
    UIView *declineView;
    UILabel *declineLabel;
    UISwitch *declineSwitch;
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    UIView *dueDateView;
    UILabel *dueDateLabel;
    UISwitch *dueDateSwitch;
    
    UIView *reminderView;
    UILabel *reminderLabel;
    UISwitch *reminderSwitch;
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    UIView *subtaskEditView;
    UILabel *subtaskEditLabel;
    UISwitch *subtaskEditSwitch;
    
    UIView *subtaskDeleteView;
    UILabel *subtaskDeleteLabel;
    UISwitch *subtaskDeleteSwitch;
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    UIView *subtaskCompletedView;
    UILabel *subtaskCompletedLabel;
    UISwitch *subtaskCompletedSwitch;
    
    UIView *subtaskInProgressView;
    UILabel *subtaskInProgressLabel;
    UISwitch *subtaskInProgressSwitch;
    
    UIView *subtaskWontDoView;
    UILabel *subtaskWontDoLabel;
    UISwitch *subtaskWontDoSwitch;
    
    UIView *subtaskAcceptView;
    UILabel *subtaskAcceptLabel;
    UISwitch *subtaskAcceptSwitch;
    
    UIView *subtaskDeclineView;
    UILabel *subtaskDeclineLabel;
    UISwitch *subtaskDeclineSwitch;
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    UIView *addListItemView;
    UILabel *addListItemLabel;
    UISwitch *addListItemSwitch;
    
    UIView *editListItemView;
    UILabel *editListItemLabel;
    UISwitch *editListItemSwitch;
    
    UIView *deleteListItemView;
    UILabel *deleteListItemLabel;
    UISwitch *deleteListItemSwitch;
    
    UIView *resetListItemView;
    UILabel *resetListItemLabel;
    UISwitch *resetListItemSwitch;
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    UIView *editItemizedItemView;
    UILabel *editItemizedItemLabel;
    UISwitch *editItemizedItemSwitch;
    
    UIView *deleteItemizedItemView;
    UILabel *deleteItemizedItemLabel;
    UISwitch *deleteItemizedItemSwitch;
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    UIView *groupChatMessagesView;
    UILabel *groupChatMessagesLabel;
    UISwitch *groupChatMessagesSwitch;
    
    UIView *liveSupportMessagesView;
    UILabel *liveSupportMessagesLabel;
    UISwitch *liveSupportMessagesSwitch;
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    UIView *sendingInvitationsView;
    UILabel *sendingInvitationsLabel;
    UISwitch *sendingInvitationsSwitch;
    
    UIView *deletingInvitationsView;
    UILabel *deletingInvitationsLabel;
    UISwitch *deletingInvitationsSwitch;
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    UIView *newHomeMembersView;
    UILabel *newHomeMembersLabel;
    UISwitch *newHomeMembersSwitch;
    
    UIView *movedOutHomeMembersView;
    UILabel *movedOutHomeMembersLabel;
    UISwitch *movedOutHomeMembersSwitch;
    
    UIView *kickingOutHomeMembersView;
    UILabel *kickingOutHomeMembersLabel;
    UISwitch *kickingOutHomeMembersSwitch;
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    UIView *bugForumUpvoteView;
    UILabel *bugForumUpvoteLabel;
    UISwitch *bugForumUpvoteSwitch;
    
    UIView *featureForumUpvoteView;
    UILabel *featureForumUpvoteLabel;
    UISwitch *featureForumUpvoteSwitch;
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    UIView *scheduledSummaryView;
    UILabel *scheduledSummaryLabel;
    UISwitch *scheduledSummarySwitch;
    
    UIButton *scheduledSummaryAddSummaryButton;
    
    UIView *scheduledSummaryTaskTypesView;
    UILabel *scheduledSummaryTaskTypesLabel;
    UIImageView *scheduledSummaryTaskTypesArrowImage;
    
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    dispatch_once_t onceToken;
 
    NSMutableDictionary *premiumPlanPricesDict;
    NSMutableDictionary *premiumPlanExpensivePricesDict;
    NSMutableDictionary *premiumPlanPricesDiscountDict;
    NSMutableDictionary *premiumPlanPricesNoFreeTrialDict;
    NSMutableArray *premiumPlanProductsArray;
    
}

@end

@implementation NotificationSettingsViewController

#pragma mark - System Methods

- (void)viewDidLoad {
    [super viewDidLoad];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self FetchAvailableProducts];
        
    });
    
    [self InitMethod];
    
    [self BarButtonItems];
    
    [self NotificationObservers];
    
}

-(void)viewWillLayoutSubviews {
    
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        self.view.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [[[LightDarkModeObject alloc] init] DarkModeTextPrimary]};
        
        [self preferredStatusBarStyle];
        
        UIWindow *currentwindow = [UIApplication sharedApplication].windows.firstObject;
        UIView *statusBar = [[UIView alloc]initWithFrame:currentwindow.windowScene.statusBarManager.statusBarFrame] ;
        statusBar.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        [currentwindow addSubview:statusBar];
        
        self.navigationController.navigationBar.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        
    } else {
        
        UIWindow *currentwindow = [UIApplication sharedApplication].windows.firstObject;
        UIView *statusBar = [[UIView alloc]initWithFrame:currentwindow.windowScene.statusBarManager.statusBarFrame] ;
        statusBar.backgroundColor = [UIColor clearColor];
        [currentwindow addSubview:statusBar];
        
        self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
        
    }
    
    
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    CGFloat navigationBarHeight = [[[GeneralObject alloc] init] GetNavigationBarHeight:self];
    CGFloat bottomPadding = [[[GeneralObject alloc] init] GetBottomPaddingHeight];
    
    self.customScrollView.frame = CGRectMake(0, navigationBarHeight, width, height - navigationBarHeight - bottomPadding);
    
    if (_ViewingChores) {
        
        [self ChoresSetup];
        
    } else if (_ViewingExpenses) {
        
        [self ExpensesSetup];
        
    } else if (_ViewingLists) {
        
        [self ListsSetup];
        
    } else if (_ViewingGroupChats) {
        
        [self GroupChatsSetup];
        
    } else if (_ViewingHomeMembers) {
        
        [self HomeMembersSetup];
        
    } else if (_ViewingForum) {
        
        [self ForumSetup];
        
    } else if (_ViewingScheduledSummary) {
        
        [self ScheduleSummarySetUp:YES];
        
    } else if (_ViewingScheduledSummaryTaskTypes) {
        
        [self ScheduleSummaryTaskTypesSetUp];
        
    } else {
        
        [self MainViewSetup:YES];
        
    }
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [customTextField resignFirstResponder];
    [customTextField removeFromSuperview];
    
}

#pragma mark - Picker View Methods

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (component == 0) {
        
        return [frequencyHourArray count];
        
    } else if (component == 1) {
        
        return [frequencyMinuteArray count];
        
    } else if (component == 2) {
        
        return [frequencyAMPMArray count];
        
    }
    
    return 0;
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (component == 0) {
        
        return [frequencyHourArray objectAtIndex:row];
        
    } else if (component == 1) {
        
        return [frequencyMinuteArray objectAtIndex:row];
        
    } else if (component == 2) {
        
        return [frequencyAMPMArray objectAtIndex:row];
        
    }
    
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    NSInteger the_tag = [pickerView tag];
    
    if (component == 0) {
        
        hourComp = [frequencyHourArray objectAtIndex:row];
        
    } else if (component == 1) {
        
        minuteComp = [frequencyMinuteArray objectAtIndex:row];
        
    } else if (component == 2) {
        
        AMPMComp = [frequencyAMPMArray objectAtIndex:row];
        
    }
    
    if (hourComp == nil || hourComp == NULL || hourComp.length == 0) {
        hourComp = @"12";
    }
    if (minuteComp == nil || minuteComp == NULL || minuteComp.length == 0) {
        minuteComp = @"00";
    }
    if (AMPMComp == nil || AMPMComp == NULL || AMPMComp.length == 0) {
        AMPMComp = @"PM";
    }
    
    NSString *key =
    _notificationSettings &&
    _notificationSettings[@"ScheduledSummary"] &&
    _notificationSettings[@"ScheduledSummary"][@"Summaries"] &&
    [[_notificationSettings[@"ScheduledSummary"][@"Summaries"] allKeys] count] > the_tag ?
    [_notificationSettings[@"ScheduledSummary"][@"Summaries"] allKeys][the_tag] : @"";
    
    if (_notificationSettings[@"ScheduledSummary"] &&
        _notificationSettings[@"ScheduledSummary"][@"Summaries"] &&
        _notificationSettings[@"ScheduledSummary"][@"Summaries"][key] &&
        _notificationSettings[@"ScheduledSummary"][@"Summaries"][key][@"Time"]) {
        
        NSMutableDictionary *notificationSettingsCopy = self->_notificationSettings ? [self->_notificationSettings mutableCopy] : [NSMutableDictionary dictionary];
        NSMutableDictionary *scheduledSummaryDict = notificationSettingsCopy && notificationSettingsCopy[@"ScheduledSummary"] ? [notificationSettingsCopy[@"ScheduledSummary"] mutableCopy] : [NSMutableDictionary dictionary];
        NSMutableDictionary *summariesDict = scheduledSummaryDict && scheduledSummaryDict[@"Summaries"] ? [scheduledSummaryDict[@"Summaries"] mutableCopy] : [NSMutableDictionary dictionary];
        NSMutableDictionary *specificScheduledSummaryDict = summariesDict && summariesDict[key] ? [summariesDict[key] mutableCopy] : [NSMutableDictionary dictionary];
        
        [specificScheduledSummaryDict setObject:[NSString stringWithFormat:@"%@:%@ %@", hourComp, minuteComp, AMPMComp] forKey:@"Time"];
        
        [summariesDict setObject:specificScheduledSummaryDict forKey:key];
        [scheduledSummaryDict setObject:summariesDict forKey:@"Summaries"];
        [notificationSettingsCopy setObject:scheduledSummaryDict forKey:@"ScheduledSummary"];
        
        self->_notificationSettings = [notificationSettingsCopy mutableCopy];
        
        [self.scheduledSummaryTableView reloadData];
        
    }
    
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    
    if (component == 0) {
        return width*0.145;
    } else if (component == 1) {
        return width*0.145;
    } else if (component == 2) {
        return width*0.145;
    }
    
    return 0;
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 3;
    
}

#pragma mark - Init Methods

-(void)InitMethod {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewViewController:@"NotificationSettingsViewController" completionHandler:^(BOOL finished) {
        
    }];
    
    [[[GeneralObject alloc] init] TrackInMixPanel:@"NotificationSettingsViewController"];
    
    onceToken = 0;
    
    _customScrollView.delegate = self;
    _customScrollView.userInteractionEnabled = YES;
    
    NSString *navigationTitle = @"Notification Settings";
    
    if (_ViewingChores) {
        navigationTitle = @"Chore Notifications";
    } else if (_ViewingExpenses) {
        navigationTitle = @"Expense Notifications";
    } else if (_ViewingLists) {
        navigationTitle = @"Lists Notifications";
    } else if (_ViewingGroupChats) {
        navigationTitle = @"Group Chats Notifications";
    } else if (_ViewingHomeMembers) {
        navigationTitle = @"Home Member Notifications";
    } else if (_ViewingForum) {
        navigationTitle = @"Forum Notifications";
    } else if (_ViewingScheduledSummary) {
        navigationTitle = @"Summary Notification";
    } else if (_ViewingScheduledSummaryTaskTypes) {
        navigationTitle = @"Summary Notification Tasks";
    }
    
    self.title = navigationTitle;
    
    _scheduledSummaryTableView.hidden = YES;
    _taskTypesTableView.hidden = YES;
    _dueDatesTableView.hidden = YES;
    _priorityTableView.hidden = YES;
    _colorTableView.hidden = YES;
    _tagsTableView.hidden = YES;
    _assignedToTableView.hidden = YES;
    
    itemSelectedDict = [NSMutableDictionary dictionary];
    taskTypesArray = [@[@"Chores", @"Expenses", @"Lists"] mutableCopy];
    dueDatesArray = [@[@"Past Due", @"Due Today", @"Due Tomorrow", @"Due Next 7 Days", @"Due This Month"] mutableCopy];
    priorityArray = [@[@"High", @"Medium", @"Low", @"No Priortiy"] mutableCopy];
    colorArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"Stuff"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"Stuff"][@"Colors"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"Stuff"][@"Colors"] mutableCopy] : [NSMutableArray array];
    tagsArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"Stuff"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"Stuff"][@"Tags"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"Stuff"][@"Tags"] mutableCopy] : [NSMutableArray array];
    assignedToArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"Stuff"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"Stuff"][@"Users"][@"Username"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"Stuff"][@"Users"][@"Username"] mutableCopy] : [NSMutableArray array];
    assignedToIDArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"Stuff"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"Stuff"][@"Users"][@"UserID"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"Stuff"][@"Users"][@"UserID"] mutableCopy] : [NSMutableArray array];
    
    if (_notificationSettings[@"ScheduledSummary"] && _notificationSettings[@"ScheduledSummary"][@"TaskTypes"] && _notificationSettings[@"ScheduledSummary"][@"TaskTypes"][@"ItemTaskTypes"]) {
        [itemSelectedDict setObject:_notificationSettings[@"ScheduledSummary"][@"TaskTypes"][@"ItemTaskTypes"] forKey:@"ItemTaskTypes"];
    } else {
        [itemSelectedDict setObject:[NSMutableArray array] forKey:@"DueDates"];
    }
    if (_notificationSettings[@"ScheduledSummary"] && _notificationSettings[@"ScheduledSummary"][@"TaskTypes"] && _notificationSettings[@"ScheduledSummary"][@"TaskTypes"][@"DueDates"]) {
        [itemSelectedDict setObject:_notificationSettings[@"ScheduledSummary"][@"TaskTypes"][@"DueDates"] forKey:@"DueDates"];
    } else {
        [itemSelectedDict setObject:[NSMutableArray array] forKey:@"DueDates"];
    }
    if (_notificationSettings[@"ScheduledSummary"] && _notificationSettings[@"ScheduledSummary"][@"TaskTypes"] && _notificationSettings[@"ScheduledSummary"][@"TaskTypes"][@"Priority"]) {
        [itemSelectedDict setObject:_notificationSettings[@"ScheduledSummary"][@"TaskTypes"][@"Priority"] forKey:@"Priority"];
    } else {
        [itemSelectedDict setObject:[NSMutableArray array] forKey:@"Priority"];
    }
    if (_notificationSettings[@"ScheduledSummary"] && _notificationSettings[@"ScheduledSummary"][@"TaskTypes"] && _notificationSettings[@"ScheduledSummary"][@"TaskTypes"][@"Color"]) {
        [itemSelectedDict setObject:_notificationSettings[@"ScheduledSummary"][@"TaskTypes"][@"Color"] forKey:@"Color"];
    } else {
        [itemSelectedDict setObject:[NSMutableArray array] forKey:@"Color"];
    }
    if (_notificationSettings[@"ScheduledSummary"] && _notificationSettings[@"ScheduledSummary"][@"TaskTypes"] && _notificationSettings[@"ScheduledSummary"][@"TaskTypes"][@"Tags"]) {
        [itemSelectedDict setObject:_notificationSettings[@"ScheduledSummary"][@"TaskTypes"][@"Tags"] forKey:@"Tags"];
    } else {
        [itemSelectedDict setObject:[NSMutableArray array] forKey:@"Tags"];
    }
    if (_notificationSettings[@"ScheduledSummary"] && _notificationSettings[@"ScheduledSummary"][@"TaskTypes"] && _notificationSettings[@"ScheduledSummary"][@"TaskTypes"][@"AssignedTo"]) {
        [itemSelectedDict setObject:_notificationSettings[@"ScheduledSummary"][@"TaskTypes"][@"AssignedTo"] forKey:@"AssignedTo"];
    } else {
        [itemSelectedDict setObject:[NSMutableArray array] forKey:@"AssignedTo"];
    }
    
    
    
    frequencyHourArray = [[NSMutableArray alloc] init];
    for (int i=1;i<13;i++) {
        [frequencyHourArray addObject:[NSString stringWithFormat:@"%d", i]];
    }
    
    frequencyMinuteArray = [[NSMutableArray alloc] init];
    [frequencyMinuteArray addObject:@"00"];
    [frequencyMinuteArray addObject:@"01"];
    [frequencyMinuteArray addObject:@"02"];
    [frequencyMinuteArray addObject:@"03"];
    [frequencyMinuteArray addObject:@"04"];
    [frequencyMinuteArray addObject:@"05"];
    [frequencyMinuteArray addObject:@"06"];
    [frequencyMinuteArray addObject:@"07"];
    [frequencyMinuteArray addObject:@"08"];
    [frequencyMinuteArray addObject:@"09"];
    for (int i=10;i<60;i++) {
        [frequencyMinuteArray addObject:[NSString stringWithFormat:@"%d", i]];
    }
    
    frequencyAMPMArray = [[NSMutableArray alloc] init];
    [frequencyAMPMArray addObject:@"AM"];
    [frequencyAMPMArray addObject:@"PM"];
    
}

-(void)BarButtonItems {
    
    self.navigationItem.hidesBackButton = YES;
    
    UIBarButtonItem *barButtonItem;
    
    barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(NavigationBackButtonAction:)];
    
    self.navigationItem.leftBarButtonItem = barButtonItem;
    
    barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save"
                                                     style:UIBarButtonItemStyleDone
                                                    target:self
                                                    action:@selector(SaveAction:)];
    
    self.navigationItem.rightBarButtonItem = barButtonItem;
    
}

-(void)NotificationObservers {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_NotificationSettings_Sound" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_NotificationSettings_Sound:) name:@"NSNotification_NotificationSettings_Sound" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_NotificationSettings_ScheduledSummaryFrequency" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_NotificationSettings_ScheduledSummaryFrequency:) name:@"NSNotification_NotificationSettings_ScheduledSummaryFrequency" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_NotificationSettings_ScheduledSummaryDays" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_NotificationSettings_ScheduledSummaryDays:) name:@"NSNotification_NotificationSettings_ScheduledSummaryDays" object:nil];
   
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_NotificationSettings_NotificationSettings" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_NotificationSettings_NotificationSettings:) name:@"NSNotification_NotificationSettings_NotificationSettings" object:nil];
    
}

#pragma mark - UI Setup
#pragma mark
#pragma mark

-(void)MainViewSetup:(BOOL)First {
    
    if (First) {
        
        allowNotificationsView = [[UIView alloc] init];
        allowNotificationsLabel = [[UILabel alloc] init];
        allowNotificationsSwitch = [[UISwitch alloc] init];
        
        daysOfTheWeekTopLabel = [[UILabel alloc] init];
        
        daysOfTheWeekView = [[UIView alloc] init];
        daysOfTheWeekMondayView = [[UIView alloc] init];
        daysOfTheWeekMondayLabel = [[UILabel alloc] init];
        daysOfTheWeekTuesdayView = [[UIView alloc] init];
        daysOfTheWeekTuesdayLabel = [[UILabel alloc] init];
        daysOfTheWeekWednesdayView = [[UIView alloc] init];
        daysOfTheWeekWednesdayLabel = [[UILabel alloc] init];
        daysOfTheWeekThursdayView = [[UIView alloc] init];
        daysOfTheWeekThursdayLabel = [[UILabel alloc] init];
        daysOfTheWeekFridayView = [[UIView alloc] init];
        daysOfTheWeekFridayLabel = [[UILabel alloc] init];
        daysOfTheWeekSaturdayView = [[UIView alloc] init];
        daysOfTheWeekSaturdayLabel = [[UILabel alloc] init];
        daysOfTheWeekSundayView = [[UIView alloc] init];
        daysOfTheWeekSundayLabel = [[UILabel alloc] init];
        
        soundsView = [[UIView alloc] init];
        soundsLabel = [[UILabel alloc] init];
        soundsSwitch = [[UISwitch alloc] init];
        
        soundsSubView = [[UIView alloc] init];
        soundsSubLabel = [[UILabel alloc] init];
        soundsSubLabelNo2 = [[UILabel alloc] init];
        soundsSubArrowImage = [[UIImageView alloc] init];
        
        badgeIconView = [[UIView alloc] init];
        badgeIconLabel = [[UILabel alloc] init];
        badgeIconSwitch = [[UISwitch alloc] init];
        
        notificationSummaryView = [[UIView alloc] init];
        notificationSummaryLabel = [[UILabel alloc] init];
        notificationSummaryArrowImage = [[UIImageView alloc] init];
        
        mainNotificationsTopLabel = [[UILabel alloc] init];
        
        choresView = [[UIView alloc] init];
        choresLabel = [[UILabel alloc] init];
        choresArrowImage = [[UIImageView alloc] init];
        
        expensesView = [[UIView alloc] init];
        expensesLabel = [[UILabel alloc] init];
        expensesArrowImage = [[UIImageView alloc] init];
        
        listsView = [[UIView alloc] init];
        listsLabel = [[UILabel alloc] init];
        listsArrowImage = [[UIImageView alloc] init];
        
        groupChatsView = [[UIView alloc] init];
        groupChatsLabel = [[UILabel alloc] init];
        groupChatsArrowImage = [[UIImageView alloc] init];
        
        otherNotificationsTopLabel = [[UILabel alloc] init];
        
        homeMembersView = [[UIView alloc] init];
        homeMembersLabel = [[UILabel alloc] init];
        homeMembersArrowImage = [[UIImageView alloc] init];
        
        forumView = [[UIView alloc] init];
        forumLabel = [[UILabel alloc] init];
        forumArrowImage = [[UIImageView alloc] init];
        
        /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
        
        allowNotificationsLabel.text = @"Allow Notifications";
        
        daysOfTheWeekMondayLabel.text = @"M";
        daysOfTheWeekTuesdayLabel.text = @"T";
        daysOfTheWeekWednesdayLabel.text = @"W";
        daysOfTheWeekThursdayLabel.text = @"T";
        daysOfTheWeekFridayLabel.text = @"F";
        daysOfTheWeekSaturdayLabel.text = @"S";
        daysOfTheWeekSundayLabel.text = @"S";
        
        soundsLabel.text = @"Sound";
        soundsSubLabel.text = @"Sound Name";
        soundsSubLabelNo2.text = @"Default";
        badgeIconLabel.text = @"Badge Icon";
        
        notificationSummaryLabel.text = @"Task Overview";
        
        choresLabel.text = @"Chores";
        expensesLabel.text = @"Expenses";
        listsLabel.text = @"Lists";
        groupChatsLabel.text = @"Group Chats";
        
        homeMembersLabel.text = @"Home Members";
        forumLabel.text = @"Forum";
        
        /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
        
    }
   
    [allowNotificationsSwitch setOn:_notificationSettings[@"AllowNotifications"] && [_notificationSettings[@"AllowNotifications"] isEqualToString:@"Yes"] ? YES : NO];
    [soundsSwitch setOn:_notificationSettings[@"Sound"] && [_notificationSettings[@"Sound"] isEqualToString:@"None"] ? NO : YES];
    [badgeIconSwitch setOn:_notificationSettings[@"BadgeIcon"] && [_notificationSettings[@"BadgeIcon"] isEqualToString:@"Yes"] ? YES : NO];
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    CGFloat textFieldSpacing = (height*0.024456);
    
    allowNotificationsView.frame = CGRectMake(textFieldSpacing, (self.view.frame.size.height*0.0407 > 30?(30):self.view.frame.size.height*0.0407), (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    
    daysOfTheWeekTopLabel.frame = [allowNotificationsSwitch isOn] ? CGRectMake(textFieldSpacing + (self.view.frame.size.width*0.02415 > 10?(10):self.view.frame.size.width*0.02415), allowNotificationsView.frame.origin.y + allowNotificationsView.frame.size.height + (self.view.frame.size.height*0.0407 > 30?(30):self.view.frame.size.height*0.0407), width, (self.view.frame.size.height*0.01902174 > 14?(14):self.view.frame.size.height*0.01902174)) : allowNotificationsView.frame;
    daysOfTheWeekView.frame = [allowNotificationsSwitch isOn] ? CGRectMake(textFieldSpacing, daysOfTheWeekTopLabel.frame.origin.y + daysOfTheWeekTopLabel.frame.size.height + (self.view.frame.size.height*0.0108695 > 8?(8):self.view.frame.size.height*0.0108695), allowNotificationsView.frame.size.width, allowNotificationsView.frame.size.height) : allowNotificationsView.frame;
    soundsView.frame = [allowNotificationsSwitch isOn] ? CGRectMake(textFieldSpacing, daysOfTheWeekView.frame.origin.y + daysOfTheWeekView.frame.size.height + (self.view.frame.size.height*0.0407 > 30?(30):self.view.frame.size.height*0.0407), (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679)) : allowNotificationsView.frame;
    
    CGFloat yPos = [soundsSwitch isOn] ? soundsView.frame.origin.y + soundsView.frame.size.height : soundsView.frame.origin.y;
    
    soundsSubView.frame = [allowNotificationsSwitch isOn] ? CGRectMake(textFieldSpacing, yPos, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679)) : allowNotificationsView.frame;
    badgeIconView.frame = [allowNotificationsSwitch isOn] ? CGRectMake(textFieldSpacing, soundsView.frame.origin.y + soundsView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679)) : allowNotificationsView.frame;
    
    notificationSummaryView.frame = [allowNotificationsSwitch isOn] ? CGRectMake(textFieldSpacing, badgeIconView.frame.origin.y + badgeIconView.frame.size.height + (self.view.frame.size.height*0.0407 > 30?(30):self.view.frame.size.height*0.0407), (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679)) : allowNotificationsView.frame;
    
    mainNotificationsTopLabel.frame = [allowNotificationsSwitch isOn] ? CGRectMake(textFieldSpacing + (self.view.frame.size.width*0.02415 > 10?(10):self.view.frame.size.width*0.02415), notificationSummaryView.frame.origin.y + notificationSummaryView.frame.size.height + (self.view.frame.size.height*0.0407 > 30?(30):self.view.frame.size.height*0.0407), width, (self.view.frame.size.height*0.01902174 > 14?(14):self.view.frame.size.height*0.01902174)) : allowNotificationsView.frame;
    
    choresView.frame = [allowNotificationsSwitch isOn] ? CGRectMake(textFieldSpacing, mainNotificationsTopLabel.frame.origin.y + mainNotificationsTopLabel.frame.size.height + (self.view.frame.size.height*0.0108695 > 8?(8):self.view.frame.size.height*0.0108695), (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679)) : allowNotificationsView.frame;
    expensesView.frame = [allowNotificationsSwitch isOn] ? CGRectMake(textFieldSpacing, choresView.frame.origin.y + choresView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679)) : allowNotificationsView.frame;
    listsView.frame = [allowNotificationsSwitch isOn] ? CGRectMake(textFieldSpacing, expensesView.frame.origin.y + expensesView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679)) : allowNotificationsView.frame;
    groupChatsView.frame = [allowNotificationsSwitch isOn] ? CGRectMake(textFieldSpacing, listsView.frame.origin.y + listsView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679)) : allowNotificationsView.frame;
    
    otherNotificationsTopLabel.frame = [allowNotificationsSwitch isOn] ? CGRectMake(textFieldSpacing + (self.view.frame.size.width*0.02415 > 10?(10):self.view.frame.size.width*0.02415), groupChatsView.frame.origin.y + groupChatsView.frame.size.height + (self.view.frame.size.height*0.0407 > 30?(30):self.view.frame.size.height*0.0407), width, (self.view.frame.size.height*0.01902174 > 14?(14):self.view.frame.size.height*0.01902174)) : allowNotificationsView.frame;
    
    homeMembersView.frame = [allowNotificationsSwitch isOn] ? CGRectMake(textFieldSpacing, otherNotificationsTopLabel.frame.origin.y + otherNotificationsTopLabel.frame.size.height + (self.view.frame.size.height*0.0108695 > 8?(8):self.view.frame.size.height*0.0108695), (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679)) : allowNotificationsView.frame;
    forumView.frame = [allowNotificationsSwitch isOn] ? CGRectMake(textFieldSpacing, homeMembersView.frame.origin.y + homeMembersView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679)) : allowNotificationsView.frame;
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    if (First) {
        
        [self.customScrollView addSubview:allowNotificationsView];
        [allowNotificationsView addSubview:allowNotificationsLabel];
        [allowNotificationsView addSubview:allowNotificationsSwitch];
        
        /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
        
        [self.customScrollView addSubview:daysOfTheWeekTopLabel];
        
        [self.customScrollView addSubview:daysOfTheWeekView];
        [daysOfTheWeekView addSubview:daysOfTheWeekMondayView];
        [daysOfTheWeekMondayView addSubview:daysOfTheWeekMondayLabel];
        [daysOfTheWeekView addSubview:daysOfTheWeekTuesdayView];
        [daysOfTheWeekTuesdayView addSubview:daysOfTheWeekTuesdayLabel];
        [daysOfTheWeekView addSubview:daysOfTheWeekWednesdayView];
        [daysOfTheWeekWednesdayView addSubview:daysOfTheWeekWednesdayLabel];
        [daysOfTheWeekView addSubview:daysOfTheWeekThursdayView];
        [daysOfTheWeekThursdayView addSubview:daysOfTheWeekThursdayLabel];
        [daysOfTheWeekView addSubview:daysOfTheWeekFridayView];
        [daysOfTheWeekFridayView addSubview:daysOfTheWeekFridayLabel];
        [daysOfTheWeekView addSubview:daysOfTheWeekSaturdayView];
        [daysOfTheWeekSaturdayView addSubview:daysOfTheWeekSaturdayLabel];
        [daysOfTheWeekView addSubview:daysOfTheWeekSundayView];
        [daysOfTheWeekSundayView addSubview:daysOfTheWeekSundayLabel];
        
        /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
        
//        [self.customScrollView addSubview:soundsSubView];
//        [soundsSubView addSubview:soundsSubLabel];
//        [soundsSubView addSubview:soundsSubLabelNo2];
//        [soundsSubView addSubview:soundsSubArrowImage];
        
        [self.customScrollView addSubview:soundsView];
        [soundsView addSubview:soundsLabel];
        [soundsView addSubview:soundsSwitch];
        
        [self.customScrollView addSubview:badgeIconView];
        [badgeIconView addSubview:badgeIconLabel];
        [badgeIconView addSubview:badgeIconSwitch];
        
        /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
        
        [self.customScrollView addSubview:notificationSummaryView];
        [notificationSummaryView addSubview:notificationSummaryLabel];
        [notificationSummaryView addSubview:notificationSummaryArrowImage];
        
        /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
        
        [self.customScrollView addSubview:mainNotificationsTopLabel];
        
        [self.customScrollView addSubview:choresView];
        [choresView addSubview:choresLabel];
        [choresView addSubview:choresArrowImage];
        
        [self.customScrollView addSubview:expensesView];
        [expensesView addSubview:expensesLabel];
        [expensesView addSubview:expensesArrowImage];
        
        [self.customScrollView addSubview:listsView];
        [listsView addSubview:listsLabel];
        [listsView addSubview:listsArrowImage];
        
        [self.customScrollView addSubview:groupChatsView];
        [groupChatsView addSubview:groupChatsLabel];
        [groupChatsView addSubview:groupChatsArrowImage];
        
        /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
        
        [self.customScrollView addSubview:otherNotificationsTopLabel];
        
        [self.customScrollView addSubview:homeMembersView];
        [homeMembersView addSubview:homeMembersLabel];
        [homeMembersView addSubview:homeMembersArrowImage];
        
        [self.customScrollView addSubview:forumView];
        [forumView addSubview:forumLabel];
        [forumView addSubview:forumArrowImage];
        
        /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
        
        CGFloat maxHeight = self.view.frame.size.height + 1;
        
        CGFloat heightToUse = forumView.frame.origin.y + forumView.frame.size.height + (height*0.01086957) < maxHeight ? maxHeight : forumView.frame.origin.y + forumView.frame.size.height + (height*0.01086957);
        
        _customScrollView.contentSize = CGSizeMake(0, heightToUse);
        
        /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
        
        width = CGRectGetWidth(daysOfTheWeekView.bounds);
        height = CGRectGetHeight(daysOfTheWeekView.bounds);
        
        daysOfTheWeekThursdayView.frame = CGRectMake(width*0.5 - ((height*0.6 > 30?(30):height*0.6)*0.5), height*0.5 - ((height*0.6 > 30?(30):height*0.6)*0.5), (height*0.6 > 30?(30):height*0.6), (height*0.6 > 30?(30):height*0.6));
        
        daysOfTheWeekWednesdayView.frame = CGRectMake(daysOfTheWeekThursdayView.frame.origin.x - daysOfTheWeekThursdayView.frame.size.height - (self.view.frame.size.width*0.04830918 > 20?(20):self.view.frame.size.width*0.04830918), daysOfTheWeekThursdayView.frame.origin.y, daysOfTheWeekThursdayView.frame.size.width, daysOfTheWeekThursdayView.frame.size.height);
        daysOfTheWeekTuesdayView.frame = CGRectMake(daysOfTheWeekWednesdayView.frame.origin.x - daysOfTheWeekWednesdayView.frame.size.height - (self.view.frame.size.width*0.04830918 > 20?(20):self.view.frame.size.width*0.04830918), daysOfTheWeekThursdayView.frame.origin.y, daysOfTheWeekThursdayView.frame.size.width, daysOfTheWeekThursdayView.frame.size.height);
        daysOfTheWeekMondayView.frame = CGRectMake(daysOfTheWeekTuesdayView.frame.origin.x - daysOfTheWeekTuesdayView.frame.size.height - (self.view.frame.size.width*0.04830918 > 20?(20):self.view.frame.size.width*0.04830918), daysOfTheWeekThursdayView.frame.origin.y, daysOfTheWeekThursdayView.frame.size.width, daysOfTheWeekThursdayView.frame.size.height);
        
        daysOfTheWeekFridayView.frame = CGRectMake(daysOfTheWeekThursdayView.frame.origin.x + daysOfTheWeekThursdayView.frame.size.height + (self.view.frame.size.width*0.04830918 > 20?(20):self.view.frame.size.width*0.04830918), daysOfTheWeekThursdayView.frame.origin.y, daysOfTheWeekThursdayView.frame.size.width, daysOfTheWeekThursdayView.frame.size.height);
        daysOfTheWeekSaturdayView.frame = CGRectMake(daysOfTheWeekFridayView.frame.origin.x + daysOfTheWeekFridayView.frame.size.height + (self.view.frame.size.width*0.04830918 > 20?(20):self.view.frame.size.width*0.04830918), daysOfTheWeekThursdayView.frame.origin.y, daysOfTheWeekThursdayView.frame.size.width, daysOfTheWeekThursdayView.frame.size.height);
        daysOfTheWeekSundayView.frame = CGRectMake(daysOfTheWeekSaturdayView.frame.origin.x + daysOfTheWeekSaturdayView.frame.size.height + (self.view.frame.size.width*0.04830918 > 20?(20):self.view.frame.size.width*0.04830918), daysOfTheWeekThursdayView.frame.origin.y, daysOfTheWeekThursdayView.frame.size.width, daysOfTheWeekThursdayView.frame.size.height);
        
    }
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    [self SetUpAlpha:@[
        
        @{@"View" : daysOfTheWeekTopLabel},
        @{@"View" : mainNotificationsTopLabel},
        @{@"View" : otherNotificationsTopLabel},
        
        @{@"View" : daysOfTheWeekView},
        
        @{@"View" : soundsView},
        @{@"View" : soundsSubView},
        @{@"View" : badgeIconView},
        
        @{@"View" : notificationSummaryView},
        
        @{@"View" : choresView},
        @{@"View" : expensesView},
        @{@"View" : listsView},
        @{@"View" : groupChatsView},
        
        @{@"View" : homeMembersView},
        @{@"View" : forumView},
        
    ] switchControl:allowNotificationsSwitch];
    
    [self SetUpDaysOfTheWeekTags:@[
        
        @{@"View" : daysOfTheWeekMondayView, @"Label" : daysOfTheWeekMondayLabel, @"Day" : @"Monday"},
        @{@"View" : daysOfTheWeekTuesdayView, @"Label" : daysOfTheWeekTuesdayLabel, @"Day" : @"Tuesday"},
        @{@"View" : daysOfTheWeekWednesdayView, @"Label" : daysOfTheWeekWednesdayLabel, @"Day" : @"Wednesday"},
        @{@"View" : daysOfTheWeekThursdayView, @"Label" : daysOfTheWeekThursdayLabel, @"Day" : @"Thursday"},
        @{@"View" : daysOfTheWeekFridayView, @"Label" : daysOfTheWeekFridayLabel, @"Day" : @"Friday"},
        @{@"View" : daysOfTheWeekSaturdayView, @"Label" : daysOfTheWeekSaturdayLabel, @"Day" : @"Saturday"},
        @{@"View" : daysOfTheWeekSundayView, @"Label" : daysOfTheWeekSundayLabel, @"Day" : @"Sunday"},
        
    ]];
    
    [self SetUpDaysOfTheWeekUI:@[
        
        @{@"View" : daysOfTheWeekMondayView, @"Label" : daysOfTheWeekMondayLabel, @"Day" : @"Monday"},
        @{@"View" : daysOfTheWeekTuesdayView, @"Label" : daysOfTheWeekTuesdayLabel, @"Day" : @"Tuesday"},
        @{@"View" : daysOfTheWeekWednesdayView, @"Label" : daysOfTheWeekWednesdayLabel, @"Day" : @"Wednesday"},
        @{@"View" : daysOfTheWeekThursdayView, @"Label" : daysOfTheWeekThursdayLabel, @"Day" : @"Thursday"},
        @{@"View" : daysOfTheWeekFridayView, @"Label" : daysOfTheWeekFridayLabel, @"Day" : @"Friday"},
        @{@"View" : daysOfTheWeekSaturdayView, @"Label" : daysOfTheWeekSaturdayLabel, @"Day" : @"Saturday"},
        @{@"View" : daysOfTheWeekSundayView, @"Label" : daysOfTheWeekSundayLabel, @"Day" : @"Sunday"},
        
    ]];
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    [self SetUpCorners:@[
        
        @{@"TopView" : allowNotificationsView, @"BottomView" : allowNotificationsView},
        @{@"TopView" : daysOfTheWeekView, @"BottomView" : daysOfTheWeekView},
        @{@"TopView" : soundsView, @"BottomView" : badgeIconView},
        @{@"TopView" : notificationSummaryView, @"BottomView" : notificationSummaryView},
        @{@"TopView" : choresView, @"BottomView" : groupChatsView},
        @{@"TopView" : homeMembersView, @"BottomView" : forumView},
        
    ]];
    
    [self SetUpViewBackgroundColor:@[
        
        @{@"View" : allowNotificationsView},
        
        @{@"View" : daysOfTheWeekView},
        
        @{@"View" : soundsView},
        @{@"View" : soundsSubView},
        @{@"View" : badgeIconView},
        
        @{@"View" : notificationSummaryView},
        
        @{@"View" : choresView},
        @{@"View" : expensesView},
        @{@"View" : listsView},
        @{@"View" : groupChatsView},
        
        @{@"View" : homeMembersView},
        @{@"View" : forumView},
        
    ]];
    
    [self SetUpBottomLineViews:@[
        
        @{@"View" : allowNotificationsView},
        
        @{@"View" : daysOfTheWeekView},
        
        @{@"View" : soundsView},
        @{@"View" : soundsSubView},
        @{@"View" : badgeIconView},
        
        @{@"View" : notificationSummaryView},
        
        @{@"View" : choresView},
        @{@"View" : expensesView},
        @{@"View" : listsView},
        @{@"View" : groupChatsView},
        
        @{@"View" : homeMembersView},
        @{@"View" : forumView},
        
    ]];
    
    [self SetUpTopLabelUI:@[
        
        @{@"Label" : daysOfTheWeekTopLabel, @"Text" : @"DAYS OF THE WEEK"},
        @{@"Label" : mainNotificationsTopLabel, @"Text" : @"MAIN NOTIFICATIONS"},
        @{@"Label" : otherNotificationsTopLabel, @"Text" : @"OTHER NOTIFICATIONS"},
        
    ]];
    
    [self SetUpLabelFontSize:@[
        
        @{@"Label" : allowNotificationsLabel},
        
        @{@"Label" : soundsLabel},
        @{@"Label" : soundsSubLabel},
        @{@"Label" : badgeIconLabel},
        
        @{@"Label" : notificationSummaryLabel},
        
        @{@"Label" : choresLabel},
        @{@"Label" : expensesLabel},
        @{@"Label" : listsLabel},
        @{@"Label" : groupChatsLabel},
        
        @{@"Label" : homeMembersLabel},
        @{@"Label" : forumLabel},
        
    ]];
    
    [self SetUpLabelWithoutImage:@[
        
        @{@"Label" : allowNotificationsLabel, @"Width" : @"0.75"},
        
        @{@"Label" : soundsLabel, @"Width" : @"0.75"},
        @{@"Label" : soundsSubLabel, @"Width" : @"0.75"},
        @{@"Label" : badgeIconLabel, @"Width" : @"0.75"},
        
        @{@"Label" : notificationSummaryLabel, @"Width" : @"0.75"},
        
        @{@"Label" : choresLabel, @"Width" : @"0.75"},
        @{@"Label" : expensesLabel, @"Width" : @"0.75"},
        @{@"Label" : listsLabel, @"Width" : @"0.75"},
        @{@"Label" : groupChatsLabel, @"Width" : @"0.75"},
        
        @{@"Label" : homeMembersLabel, @"Width" : @"0.75"},
        @{@"Label" : forumLabel, @"Width" : @"0.75"},
        
    ]];
    
    dispatch_once(&onceToken, ^{
        
        [self SetUpControlSwitchFrame:@[
            
            @{@"Switch" : allowNotificationsSwitch},
            @{@"Switch" : soundsSwitch},
            @{@"Switch" : badgeIconSwitch},
            
        ]];
        
    });
    
    [self SetUpRightArrowFrame:@[
        
        @{@"ImageView" : soundsSubArrowImage},
        
        @{@"ImageView" : notificationSummaryArrowImage},
        
        @{@"ImageView" : choresArrowImage},
        @{@"ImageView" : expensesArrowImage},
        @{@"ImageView" : listsArrowImage},
        @{@"ImageView" : groupChatsArrowImage},
        
        @{@"ImageView" : homeMembersArrowImage},
        @{@"ImageView" : forumArrowImage},
        
    ]];
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    [self SetUpViewTapGestures:@[
        
        @{@"View" : daysOfTheWeekMondayView},
        @{@"View" : daysOfTheWeekMondayLabel},
        @{@"View" : daysOfTheWeekTuesdayView},
        @{@"View" : daysOfTheWeekTuesdayLabel},
        @{@"View" : daysOfTheWeekWednesdayView},
        @{@"View" : daysOfTheWeekWednesdayLabel},
        @{@"View" : daysOfTheWeekThursdayView},
        @{@"View" : daysOfTheWeekThursdayLabel},
        @{@"View" : daysOfTheWeekFridayView},
        @{@"View" : daysOfTheWeekFridayLabel},
        @{@"View" : daysOfTheWeekSaturdayView},
        @{@"View" : daysOfTheWeekSaturdayLabel},
        @{@"View" : daysOfTheWeekSundayView},
        @{@"View" : daysOfTheWeekSundayLabel},
        
    ] selector:@selector(DayOfTheWeekTapGesture:)];
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    [self SetUpViewTapGestures:@[
        
        @{@"View" : soundsSubView},
        @{@"View" : soundsSubLabel},
        @{@"View" : soundsSubLabelNo2},
        @{@"View" : soundsSubArrowImage},
        
    ] selector:@selector(SoundSubviewTapGesture:)];
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    [self SetUpViewTapGestures:@[
        
        @{@"View" : notificationSummaryView},
        @{@"View" : notificationSummaryLabel},
        @{@"View" : notificationSummaryArrowImage},
        
    ] selector:@selector(ScheduledSummaryTapGesture:)];
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    [self SetUpViewTapGestures:@[
        
        @{@"View" : choresView},
        @{@"View" : choresLabel},
        @{@"View" : choresArrowImage},
        
    ] selector:@selector(ChoresTapGesture:)];
    
    [self SetUpViewTapGestures:@[
        
        @{@"View" : expensesView},
        @{@"View" : expensesLabel},
        @{@"View" : expensesArrowImage},
        
    ] selector:@selector(ExpensesTapGesture:)];
    
    [self SetUpViewTapGestures:@[
        
        @{@"View" : listsView},
        @{@"View" : listsLabel},
        @{@"View" : listsArrowImage},
        
    ] selector:@selector(ListsTapGesture:)];
    
    [self SetUpViewTapGestures:@[
        
        @{@"View" : groupChatsView},
        @{@"View" : groupChatsLabel},
        @{@"View" : groupChatsArrowImage},
        
    ] selector:@selector(GroupChatsTapGesture:)];
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    [self SetUpViewTapGestures:@[
        
        @{@"View" : homeMembersView},
        @{@"View" : homeMembersLabel},
        @{@"View" : homeMembersLabel},
        
    ] selector:@selector(HomeMembersTapGesture:)];
    
    [self SetUpViewTapGestures:@[
        
        @{@"View" : forumView},
        @{@"View" : forumLabel},
        @{@"View" : forumArrowImage},
        
    ] selector:@selector(ForumsTapGesture:)];
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    [allowNotificationsSwitch addTarget:self action:@selector(AllowNotificationSwitchAction:) forControlEvents:UIControlEventTouchUpInside];
    [soundsSwitch addTarget:self action:@selector(SoundSwitchAction:) forControlEvents:UIControlEventTouchUpInside];
    [badgeIconSwitch addTarget:self action:@selector(BadgeIconSwitchAction:) forControlEvents:UIControlEventTouchUpInside];
    
    soundsSubView.alpha = [soundsSwitch isOn] ? 1.0f : 0.0f;
    
    UIView *viewToUse = soundsSubLabelNo2;
    UIFont *fontSize = [UIFont systemFontOfSize:(self.view.frame.size.height*0.02173813 > 16?16:(self.view.frame.size.height*0.02173813)) weight:UIFontWeightRegular];
    UIColor *textColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTextSecondary] : [[[LightDarkModeObject alloc] init] LightModeTexAddTaskTextField];
    UIColor *backgroundColor = [UIColor clearColor];
    soundsSubLabelNo2.textAlignment = NSTextAlignmentRight;
    soundsSubLabelNo2.font = fontSize;
    soundsSubLabelNo2.adjustsFontSizeToFitWidth = YES;
    soundsSubLabelNo2.textColor = textColor;
    soundsSubLabelNo2.backgroundColor = backgroundColor;
    textFieldSpacing = (self.view.frame.size.height*0.024456);
    width = (self.view.frame.size.width*1 - (textFieldSpacing*2));
    
    viewToUse.frame = CGRectMake(soundsSubArrowImage.frame.origin.x - soundsSubView.frame.size.width*0.5 - width*0.04830918, 0, soundsSubView.frame.size.width*0.5, soundsSubView.frame.size.height);
    
}

#pragma mark

-(void)ScheduleSummarySetUp:(BOOL)First {
    
    if (First) {
        
        scheduledSummaryView = [[UIView alloc] init];
        scheduledSummaryLabel = [[UILabel alloc] init];
        scheduledSummarySwitch = [[UISwitch alloc] init];
        
        scheduleTopLabel = [[UILabel alloc] init];
        
        scheduledSummaryAddSummaryButton = [[UIButton alloc] init];
        
        scheduledSummaryTaskTypesView = [[UIView alloc] init];
        scheduledSummaryTaskTypesLabel = [[UILabel alloc] init];
        scheduledSummaryTaskTypesArrowImage = [[UIImageView alloc] init];
        
        /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
        
        scheduledSummaryLabel.text = @"Scheduled Summary";
        
        [scheduledSummaryAddSummaryButton setTitle:@"Add Summary" forState:UIControlStateNormal];
        [scheduledSummaryAddSummaryButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
        
        scheduledSummaryTaskTypesLabel.text = @"Tasks In Summary";
        
    }
    
    [scheduledSummarySwitch setOn:_notificationSettings[@"ScheduledSummary"] && _notificationSettings[@"ScheduledSummary"][@"Activated"] && [_notificationSettings[@"ScheduledSummary"][@"Activated"] isEqualToString:@"Yes"] ? YES : NO];
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    CGFloat textFieldSpacing = (height*0.024456);
    
    scheduledSummaryView.frame = CGRectMake(textFieldSpacing, (self.view.frame.size.height*0.0407 > 30?(30):self.view.frame.size.height*0.0407), (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    
    scheduleTopLabel.frame = [scheduledSummarySwitch isOn] ? CGRectMake(textFieldSpacing, scheduledSummaryView.frame.origin.y + scheduledSummaryView.frame.size.height + (self.view.frame.size.height*0.0407 > 30?(30):self.view.frame.size.height*0.0407), (width*1 - (textFieldSpacing*2)), (self.view.frame.size.height*0.01902174 > 14?(14):self.view.frame.size.height*0.01902174)) : scheduledSummaryView.frame;
    
    [UIView animateWithDuration:0.0 animations:^{
        
        CGFloat tableViewHeight = 0;
        CGFloat addY = 0;
        CGFloat addYNo2 = 0;
        
        if (self->_notificationSettings[@"ScheduledSummary"] && self->_notificationSettings[@"ScheduledSummary"][@"Summaries"] && [[self->_notificationSettings[@"ScheduledSummary"][@"Summaries"] allKeys] count]) {
            
            tableViewHeight = (self.view.frame.size.height*0.11956522 > 88?(88):self.view.frame.size.height*0.11956522)*[[self->_notificationSettings[@"ScheduledSummary"][@"Summaries"] allKeys] count];
            
            if ([[self->_notificationSettings[@"ScheduledSummary"][@"Summaries"] allKeys] count] > 0) {
                
                addY = (self.view.frame.size.height*0.0108695 > 8?(8):self.view.frame.size.height*0.0108695);
                
            }
            
            if ([[self->_notificationSettings[@"ScheduledSummary"][@"Summaries"] allKeys] count] == 0) {
                
                addYNo2 = (self.view.frame.size.height*0.0108695 > 8?(8):self.view.frame.size.height*0.0108695);
                
            }
            
        } else {
            
            addYNo2 = (self.view.frame.size.height*0.0108695 > 8?(8):self.view.frame.size.height*0.0108695);
            
        }
        
        self->_scheduledSummaryTableView.frame = [self->scheduledSummarySwitch isOn] ? CGRectMake(textFieldSpacing, self->scheduleTopLabel.frame.origin.y + self->scheduleTopLabel.frame.size.height + addY, (width*1 - (textFieldSpacing*2)), tableViewHeight) : self->scheduledSummaryView.frame;
        self->scheduledSummaryAddSummaryButton.frame = [self->scheduledSummarySwitch isOn] ? CGRectMake(textFieldSpacing, self->_scheduledSummaryTableView.frame.origin.y + self->_scheduledSummaryTableView.frame.size.height + addYNo2, self->scheduledSummaryView.frame.size.width, self->scheduledSummaryView.frame.size.height) : self->scheduledSummaryView.frame;
        
        self->scheduledSummaryTaskTypesView.frame = [self->scheduledSummarySwitch isOn] ? CGRectMake(textFieldSpacing, self->scheduledSummaryAddSummaryButton.frame.origin.y + self->scheduledSummaryAddSummaryButton.frame.size.height + (self.view.frame.size.height*0.0407 > 30?(30):self.view.frame.size.height*0.0407), (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679)) : self->scheduledSummaryView.frame;
        
        
//        if (self->_notificationSettings[@"ScheduledSummary"] && self->_notificationSettings[@"ScheduledSummary"][@"Summaries"] && [[self->_notificationSettings[@"ScheduledSummary"][@"Summaries"] allKeys] count] >= 1) {
//
//            [self->scheduledSummaryAddSummaryButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//            self->scheduledSummaryAddSummaryButton.userInteractionEnabled = NO;
//
//        } else {
//
//            [self->scheduledSummaryAddSummaryButton setTitleColor:[UIColor linkColor] forState:UIControlStateNormal];
//            self->scheduledSummaryAddSummaryButton.userInteractionEnabled = YES;
//
//        }
        
        if (self->_notificationSettings[@"ScheduledSummary"] && self->_notificationSettings[@"ScheduledSummary"][@"Summaries"] && [[self->_notificationSettings[@"ScheduledSummary"][@"Summaries"] allKeys] count] > 0) {
            
            [self SetUpCorners:@[
                
                @{@"TopView" : self->scheduledSummaryView, @"BottomView" : self->scheduledSummaryView},
                @{@"TopView" : self->_scheduledSummaryTableView, @"BottomView" : self->scheduledSummaryAddSummaryButton},
                @{@"TopView" : self->scheduledSummaryTaskTypesView, @"BottomView" : self->scheduledSummaryTaskTypesView},
                
            ]];
            
        } else {
            
            [self SetUpCorners:@[
                
                @{@"TopView" : self->scheduledSummaryView, @"BottomView" : self->scheduledSummaryView},
                @{@"TopView" : self->scheduledSummaryAddSummaryButton, @"BottomView" : self->scheduledSummaryAddSummaryButton},
                @{@"TopView" : self->scheduledSummaryTaskTypesView, @"BottomView" : self->scheduledSummaryTaskTypesView},
                
            ]];
            
        }
        
    } completion:^(BOOL finished) {
        
        [self.scheduledSummaryTableView reloadData];
        
    }];
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    if (First) {
        
        [self.customScrollView addSubview:scheduledSummaryView];
        [scheduledSummaryView addSubview:scheduledSummaryLabel];
        [scheduledSummaryView addSubview:scheduledSummarySwitch];
        
        [self.customScrollView addSubview:scheduleTopLabel];
        
        [self.customScrollView addSubview:_scheduledSummaryTableView];
        [self.customScrollView addSubview:scheduledSummaryAddSummaryButton];
        
        [self.customScrollView addSubview:scheduledSummaryTaskTypesView];
        [scheduledSummaryTaskTypesView addSubview:scheduledSummaryTaskTypesLabel];
        [scheduledSummaryTaskTypesView addSubview:scheduledSummaryTaskTypesArrowImage];
        
        CGFloat maxHeight = self.view.frame.size.height + 1;
        
        CGFloat heightToUse = scheduledSummaryTaskTypesView.frame.origin.y + scheduledSummaryTaskTypesView.frame.size.height + (height*0.01086957) < maxHeight ? maxHeight : scheduledSummaryTaskTypesView.frame.origin.y + scheduledSummaryTaskTypesView.frame.size.height + (height*0.01086957);
        
        _customScrollView.contentSize = CGSizeMake(0, heightToUse);
        
    }
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    NSArray *arrView = @[scheduledSummaryAddSummaryButton];
    
    for (UIView *viewNo1 in arrView) {
        
        for (UIView *subViewNo1 in [viewNo1 subviews]) {
            
            if (subViewNo1.tag == 1111) {
                
                [subViewNo1 removeFromSuperview];
                
            }
            
        }
        
    }
    
    for (UIView *viewNo1 in arrView) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewNo1.frame.size.width, 1)];
        view.backgroundColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTextSecondary] : [[[LightDarkModeObject alloc] init] LightModeSubviewLine];
        view.tag = 1111;
        [viewNo1 addSubview:view];
        
    }
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    [self SetUpAlpha:@[
        
        @{@"View" : scheduleTopLabel},
        
        @{@"View" : _scheduledSummaryTableView},
        @{@"View" : scheduledSummaryAddSummaryButton},
        
        @{@"View" : scheduledSummaryTaskTypesView},
        
    ] switchControl:scheduledSummarySwitch];
    
    [self SetUpViewBackgroundColor:@[
        
        @{@"View" : scheduledSummaryView},
        @{@"View" : scheduledSummaryTaskTypesView},
        
        @{@"View" : scheduledSummaryAddSummaryButton},
        
    ]];
    
    [self SetUpTopLabelUI:@[
        
        @{@"Label" : scheduleTopLabel, @"Text" : @"SUMMARY NOTIFICATIONS"},
        
    ]];
    
    [self SetUpLabelFontSize:@[
        
        @{@"Label" : scheduledSummaryLabel},
        @{@"Label" : scheduledSummaryTaskTypesLabel},
        
    ]];
    
    [self SetUpLabelWithoutImage:@[
        
        @{@"Label" : scheduledSummaryLabel, @"Width" : @"0.75"},
        @{@"Label" : scheduledSummaryTaskTypesLabel, @"Width" : @"0.75"},
        
    ]];
    
    dispatch_once(&onceToken, ^{
        
        [self SetUpControlSwitchFrame:@[
            
            @{@"Switch" : scheduledSummarySwitch},
            
        ]];
        
    });
    
    [self SetUpRightArrowFrame:@[
        
        @{@"ImageView" : scheduledSummaryTaskTypesArrowImage},
        
    ]];
    
    [self SetUpViewTapGestures:@[
        
        @{@"View" : scheduledSummaryTaskTypesView},
        @{@"View" : scheduledSummaryTaskTypesLabel},
        @{@"View" : scheduledSummaryTaskTypesArrowImage},
        
    ] selector:@selector(ScheduledSummaryTaskTypesTapGesture:)];
    
    [self SetUpTableViews:@[
        
        @{@"TableView" : _scheduledSummaryTableView},
        
    ]];
    
    scheduledSummaryAddSummaryButton.titleLabel.font = [UIFont systemFontOfSize:(self.view.frame.size.height*0.02309783 > 17?(17):self.view.frame.size.height*0.02309783) weight:UIFontWeightRegular];
    [scheduledSummaryAddSummaryButton setTitleColor:[UIColor linkColor] forState:UIControlStateNormal];
    [scheduledSummaryAddSummaryButton addTarget:self action:@selector(AddScheduledSummary:) forControlEvents:UIControlEventTouchUpInside];
    
//    if ([[[BoolDataObject alloc] init] PremiumSubscriptionIsOn] == NO &&
//        _notificationSettings[@"ScheduledSummary"] &&
//        _notificationSettings[@"ScheduledSummary"][@"Summaries"] &&
//        [[_notificationSettings[@"ScheduledSummary"][@"Summaries"] allKeys] count] >= 1) {
//
//        [scheduledSummaryAddSummaryButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//        scheduledSummaryAddSummaryButton.userInteractionEnabled = NO;
//
//    } else {
//
//        [scheduledSummaryAddSummaryButton setTitleColor:[UIColor linkColor] forState:UIControlStateNormal];
//        scheduledSummaryAddSummaryButton.userInteractionEnabled = YES;
//
//    }
    
    [scheduledSummarySwitch addTarget:self action:@selector(ScheduledSummarySwitchAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)ScheduleSummaryTaskTypesSetUp {
    
    taskTypesTopLabel = [[UILabel alloc] init];
    dueDatesTopLabel = [[UILabel alloc] init];
    priorityTopLabel = [[UILabel alloc] init];
    colorTopLabel = [[UILabel alloc] init];
    tagsTopLabel = [[UILabel alloc] init];
    assignedToTopLabel = [[UILabel alloc] init];
    notificationTaskTypesTopLabel = [[UILabel alloc] init];
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    CGFloat textFieldSpacing = (height*0.024456);
    
    notificationTaskTypesTopLabel.frame = CGRectMake(textFieldSpacing + (self.view.frame.size.width*0.02415 > 10?(10):self.view.frame.size.width*0.02415), (self.view.frame.size.height*0.01630 > 12?(12):self.view.frame.size.height*0.01630), width - (textFieldSpacing+10)*2, 40);
    
    taskTypesTopLabel.frame = CGRectMake(textFieldSpacing + (self.view.frame.size.width*0.02415 > 10?(10):self.view.frame.size.width*0.02415), notificationTaskTypesTopLabel.frame.origin.y + notificationTaskTypesTopLabel.frame.size.height + (self.view.frame.size.height*0.0407 > 30?(30):self.view.frame.size.height*0.0407), width, (self.view.frame.size.height*0.01902174 > 14?(14):self.view.frame.size.height*0.01902174));
    _taskTypesTableView.frame = CGRectMake(textFieldSpacing, taskTypesTopLabel.frame.origin.y + taskTypesTopLabel.frame.size.height + (self.view.frame.size.height*0.0108695 > 8?(8):self.view.frame.size.height*0.0108695), (width*1 - (textFieldSpacing*2)), ((height*0.0679 > 50?(50):height*0.0679)*[taskTypesArray count]));
    
    dueDatesTopLabel.frame = CGRectMake(textFieldSpacing + (self.view.frame.size.width*0.02415 > 10?(10):self.view.frame.size.width*0.02415), _taskTypesTableView.frame.origin.y + _taskTypesTableView.frame.size.height + (self.view.frame.size.height*0.0407 > 30?(30):self.view.frame.size.height*0.0407), width, (self.view.frame.size.height*0.01902174 > 14?(14):self.view.frame.size.height*0.01902174));
    _dueDatesTableView.frame = CGRectMake(textFieldSpacing, dueDatesTopLabel.frame.origin.y + dueDatesTopLabel.frame.size.height + (self.view.frame.size.height*0.0108695 > 8?(8):self.view.frame.size.height*0.0108695), (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679)*[dueDatesArray count]);
    
    priorityTopLabel.frame = CGRectMake(textFieldSpacing + (self.view.frame.size.width*0.02415 > 10?(10):self.view.frame.size.width*0.02415), _dueDatesTableView.frame.origin.y + _dueDatesTableView.frame.size.height + (self.view.frame.size.height*0.0407 > 30?(30):self.view.frame.size.height*0.0407), width, (self.view.frame.size.height*0.01902174 > 14?(14):self.view.frame.size.height*0.01902174));
    _priorityTableView.frame = CGRectMake(textFieldSpacing, priorityTopLabel.frame.origin.y + priorityTopLabel.frame.size.height + (self.view.frame.size.height*0.0108695 > 8?(8):self.view.frame.size.height*0.0108695), (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679)*[priorityArray count]);
    
    UIView *viewToRepel = _priorityTableView;
    
    NSMutableArray *colorsArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"Stuff"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"Stuff"][@"Colors"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"Stuff"][@"Colors"] mutableCopy] : [NSMutableArray array];
    
    colorTopLabel.frame = CGRectMake(textFieldSpacing, viewToRepel.frame.origin.y + viewToRepel.frame.size.height + (self.view.frame.size.height*0.0407 > 30?(30):self.view.frame.size.height*0.0407), (width*1 - (textFieldSpacing*2)), (self.view.frame.size.height*0.01902174 > 14?(14):self.view.frame.size.height*0.01902174));
    _colorTableView.frame = CGRectMake(textFieldSpacing, colorTopLabel.frame.origin.y + colorTopLabel.frame.size.height + (self.view.frame.size.height*0.0108695 > 8?(8):self.view.frame.size.height*0.0108695), (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679)*[colorsArray count]);
    
    if (colorsArray.count == 0) {
        
        viewToRepel = _priorityTableView;
        
        colorTopLabel.hidden = YES;
        _colorTableView.hidden = YES;
        
    } else {
        
        viewToRepel = _colorTableView;
        
    }
    
    NSMutableArray *tagsArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"Stuff"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"Stuff"][@"Tags"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"Stuff"][@"Tags"] mutableCopy] : [NSMutableArray array];
    
    tagsTopLabel.frame = CGRectMake(textFieldSpacing, viewToRepel.frame.origin.y + viewToRepel.frame.size.height + (self.view.frame.size.height*0.0407 > 30?(30):self.view.frame.size.height*0.0407), (width*1 - (textFieldSpacing*2)), (self.view.frame.size.height*0.01902174 > 14?(14):self.view.frame.size.height*0.01902174));
    _tagsTableView.frame = CGRectMake(textFieldSpacing, tagsTopLabel.frame.origin.y + tagsTopLabel.frame.size.height + (self.view.frame.size.height*0.0108695 > 8?(8):self.view.frame.size.height*0.0108695), (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679)*[tagsArray count]);
    
    if (tagsArray.count == 0) {
        
        viewToRepel = _colorTableView;
        
        tagsTopLabel.hidden = YES;
        _tagsTableView.hidden = YES;
        
        if (colorsArray.count == 0) {
            
            viewToRepel = _priorityTableView;
            
            colorTopLabel.hidden = YES;
            _colorTableView.hidden = YES;
            
        } else {
            
            viewToRepel = _colorTableView;
            
        }
        
    } else {
        
        viewToRepel = _tagsTableView;
        
    }
    
    NSMutableArray *usernameArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"Stuff"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"Stuff"][@"Users"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"Stuff"][@"Users"][@"Username"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"Stuff"][@"Users"][@"Username"] mutableCopy] : [NSMutableArray array];
    
    assignedToTopLabel.frame = CGRectMake(textFieldSpacing, viewToRepel.frame.origin.y + viewToRepel.frame.size.height + (self.view.frame.size.height*0.0407 > 30?(30):self.view.frame.size.height*0.0407), (width*1 - (textFieldSpacing*2)), (self.view.frame.size.height*0.01902174 > 14?(14):self.view.frame.size.height*0.01902174));
    _assignedToTableView.frame = CGRectMake(textFieldSpacing, assignedToTopLabel.frame.origin.y + assignedToTopLabel.frame.size.height + (self.view.frame.size.height*0.0108695 > 8?(8):self.view.frame.size.height*0.0108695), (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679)*[usernameArray count]);
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    CGFloat maxHeight = self.view.frame.size.height + 1;
    
    CGFloat heightToUse = _assignedToTableView.frame.origin.y + _assignedToTableView.frame.size.height + (height*0.01086957) < maxHeight ? maxHeight : _assignedToTableView.frame.origin.y + _assignedToTableView.frame.size.height + (height*0.01086957);
    
    _customScrollView.contentSize = CGSizeMake(0, heightToUse);
    
    [self.customScrollView addSubview:taskTypesTopLabel];
    [self.customScrollView addSubview:dueDatesTopLabel];
    [self.customScrollView addSubview:priorityTopLabel];
    [self.customScrollView addSubview:colorTopLabel];
    [self.customScrollView addSubview:tagsTopLabel];
    [self.customScrollView addSubview:assignedToTopLabel];
    [self.customScrollView addSubview:notificationTaskTypesTopLabel];
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    [self SetUpCorners:@[
        
        @{@"TopView" : _taskTypesTableView, @"BottomView" : _taskTypesTableView},
        @{@"TopView" : _dueDatesTableView, @"BottomView" : _dueDatesTableView},
        @{@"TopView" : _priorityTableView, @"BottomView" : _priorityTableView},
        @{@"TopView" : _colorTableView, @"BottomView" : _colorTableView},
        @{@"TopView" : _tagsTableView, @"BottomView" : _tagsTableView},
        @{@"TopView" : _assignedToTableView, @"BottomView" : _assignedToTableView},
        
    ]];
    
    [self SetUpTopLabelUI:@[
        
        @{@"Label" : taskTypesTopLabel, @"Text" : @"DISPLAY THE FOLLOWING TASKS"},
        @{@"Label" : dueDatesTopLabel, @"Text" : @"DISPLAY TASKS THAT ARE"},
        @{@"Label" : priorityTopLabel, @"Text" : @"DISPLAY TASKS WITH A PRIORITY OF"},
        @{@"Label" : colorTopLabel, @"Text" : @"DISPLAY TASKS THAT HAVE THE COLOR"},
        @{@"Label" : tagsTopLabel, @"Text" : @"DISPLAY TASKS WITH THE TAG"},
        @{@"Label" : assignedToTopLabel, @"Text" : @"DISPLAY TASKS THAT ARE ASSIGNED TO"},
        
    ]];
    
    [self SetUpTableViews:@[
        
        @{@"TableView" : _taskTypesTableView},
        @{@"TableView" : _dueDatesTableView},
        @{@"TableView" : _priorityTableView},
        @{@"TableView" : _colorTableView},
        @{@"TableView" : _tagsTableView},
        @{@"TableView" : _assignedToTableView},
        
    ]];
    
    notificationTaskTypesTopLabel.text = @"Select the tasks you would like displayed in your summary notification";
    notificationTaskTypesTopLabel.textColor = [UIColor colorWithRed:115.0f/255.0f green:126.0f/255.0f blue:143.0f/255.0f alpha:1.0f];
    notificationTaskTypesTopLabel.font = [UIFont systemFontOfSize:(self.view.frame.size.height*0.02038043 > 15?(15):self.view.frame.size.height*0.02038043) weight:UIFontWeightMedium];
    notificationTaskTypesTopLabel.numberOfLines = 2;
    
}

#pragma mark

-(void)ChoresSetup {
    
    itemTypeTopLabel = [[UILabel alloc] init];
    markingTopLabel = [[UILabel alloc] init];
    usersTopLabel = [[UILabel alloc] init];
    remindersTopLabel = [[UILabel alloc] init];
    subtasksTopLabel = [[UILabel alloc] init];
    markingSubtasksTopLabel = [[UILabel alloc] init];
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    addingView = [[UIView alloc] init];
    addingLabel = [[UILabel alloc] init];
    addingSwitch = [[UISwitch alloc] init];
    
    editingView = [[UIView alloc] init];
    editingLabel = [[UILabel alloc] init];
    editingSwitch = [[UISwitch alloc] init];
    
    deletingView = [[UIView alloc] init];
    deletingLabel = [[UILabel alloc] init];
    deletingSwitch = [[UISwitch alloc] init];
    
    duplicatingView = [[UIView alloc] init];
    duplicatingLabel = [[UILabel alloc] init];
    duplicatingSwitch = [[UISwitch alloc] init];
    
    waivingsView = [[UIView alloc] init];
    waivingLabel = [[UILabel alloc] init];
    waivingSwitch = [[UISwitch alloc] init];
    
    skippingsView = [[UIView alloc] init];
    skippingLabel = [[UILabel alloc] init];
    skippingSwitch = [[UISwitch alloc] init];
    
    pauseUnpauseView = [[UIView alloc] init];
    pauseUnpauseLabel = [[UILabel alloc] init];
    pauseUnpauseSwitch = [[UISwitch alloc] init];
    
    commentsView = [[UIView alloc] init];
    commentsLabel = [[UILabel alloc] init];
    commentsSwitch = [[UISwitch alloc] init];
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    skippingTurnView = [[UIView alloc] init];
    skippingTurnLabel = [[UILabel alloc] init];
    skippingTurnSwitch = [[UISwitch alloc] init];
    
    removingUserView = [[UIView alloc] init];
    removingUserLabel = [[UILabel alloc] init];
    removingUserSwitch = [[UISwitch alloc] init];
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    fullyCompletedView = [[UIView alloc] init];
    fullyCompletedLabel = [[UILabel alloc] init];
    fullyCompletedSwitch = [[UISwitch alloc] init];
    
    completedView = [[UIView alloc] init];
    subLabel = [[UILabel alloc] init];
    completedSwitch = [[UISwitch alloc] init];
    
    inProgressView = [[UIView alloc] init];
    inProgressLabel = [[UILabel alloc] init];
    inProgressSwitch = [[UISwitch alloc] init];
    
    wontDoView = [[UIView alloc] init];
    wontDoLabel = [[UILabel alloc] init];
    wontDoSwitch = [[UISwitch alloc] init];
    
    acceptView = [[UIView alloc] init];
    acceptLabel = [[UILabel alloc] init];
    acceptSwitch = [[UISwitch alloc] init];
    
    declineView = [[UIView alloc] init];
    declineLabel = [[UILabel alloc] init];
    declineSwitch = [[UISwitch alloc] init];
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    dueDateView = [[UIView alloc] init];
    dueDateLabel = [[UILabel alloc] init];
    dueDateSwitch = [[UISwitch alloc] init];
    
    reminderView = [[UIView alloc] init];
    reminderLabel = [[UILabel alloc] init];
    reminderSwitch = [[UISwitch alloc] init];
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    subtaskEditView = [[UIView alloc] init];
    subtaskEditLabel = [[UILabel alloc] init];
    subtaskEditSwitch = [[UISwitch alloc] init];
    
    subtaskDeleteView = [[UIView alloc] init];
    subtaskDeleteLabel = [[UILabel alloc] init];
    subtaskDeleteSwitch = [[UISwitch alloc] init];
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    subtaskCompletedView = [[UIView alloc] init];
    subtaskCompletedLabel = [[UILabel alloc] init];
    subtaskCompletedSwitch = [[UISwitch alloc] init];
    
    subtaskInProgressView = [[UIView alloc] init];
    subtaskInProgressLabel = [[UILabel alloc] init];
    subtaskInProgressSwitch = [[UISwitch alloc] init];
    
    subtaskWontDoView = [[UIView alloc] init];
    subtaskWontDoLabel = [[UILabel alloc] init];
    subtaskWontDoSwitch = [[UISwitch alloc] init];
    
    subtaskAcceptView = [[UIView alloc] init];
    subtaskAcceptLabel = [[UILabel alloc] init];
    subtaskAcceptSwitch = [[UISwitch alloc] init];
    
    subtaskDeclineView = [[UIView alloc] init];
    subtaskDeclineLabel = [[UILabel alloc] init];
    subtaskDeclineSwitch = [[UISwitch alloc] init];
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    addingLabel.text = @"Adding";
    editingLabel.text = @"Editing";
    deletingLabel.text = @"Deleting";
    duplicatingLabel.text = @"Duplicating";
    waivingLabel.text = @"Waiving";
    skippingLabel.text = @"Skipping";
    pauseUnpauseLabel.text = @"Pausing/Unpausing";
    commentsLabel.text = @"Comments";
    
    skippingTurnLabel.text = @"Skipping Turn";
    removingUserLabel.text = @"Removing User";
    
    fullyCompletedLabel.text = @"Fully Completed";
    subLabel.text = @"Completed";
    inProgressLabel.text = @"In Progress";
    wontDoLabel.text = @"Won't Do";
    acceptLabel.text = @"Accept";
    declineLabel.text = @"Decline";
    
    dueDateLabel.text = @"Due Date";
    reminderLabel.text = @"Reminder";
    
    subtaskCompletedLabel.text = @"Subtask Completed";
    subtaskInProgressLabel.text = @"Subtask In Progress";
    subtaskWontDoLabel.text = @"Subtask Won't Do";
    subtaskAcceptLabel.text = @"Subtask Accept";
    subtaskDeclineLabel.text = @"Subtask Decline";
    subtaskEditLabel.text = @"Subtask Editing";
    subtaskDeleteLabel.text = @"Subtask Deleting";
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    CGFloat textFieldSpacing = (height*0.024456);
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    itemTypeTopLabel.frame = CGRectMake(textFieldSpacing + (self.view.frame.size.width*0.02415 > 10?(10):self.view.frame.size.width*0.02415), (self.view.frame.size.height*0.0407 > 30?(30):self.view.frame.size.height*0.0407), width, (self.view.frame.size.height*0.01902174 > 14?(14):self.view.frame.size.height*0.01902174));
    
    addingView.frame = CGRectMake(textFieldSpacing, itemTypeTopLabel.frame.origin.y + itemTypeTopLabel.frame.size.height + (self.view.frame.size.height*0.0108695 > 8?(8):self.view.frame.size.height*0.0108695), (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    editingView.frame = CGRectMake(textFieldSpacing, addingView.frame.origin.y + addingView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    deletingView.frame = CGRectMake(textFieldSpacing, editingView.frame.origin.y + editingView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    duplicatingView.frame = CGRectMake(textFieldSpacing, deletingView.frame.origin.y + deletingView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    waivingsView.frame = CGRectMake(textFieldSpacing, duplicatingView.frame.origin.y + duplicatingView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    skippingsView.frame = CGRectMake(textFieldSpacing, waivingsView.frame.origin.y + waivingsView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    pauseUnpauseView.frame = CGRectMake(textFieldSpacing, skippingsView.frame.origin.y + skippingsView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    commentsView.frame = CGRectMake(textFieldSpacing, pauseUnpauseView.frame.origin.y + pauseUnpauseView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    usersTopLabel.frame = CGRectMake(textFieldSpacing + (self.view.frame.size.width*0.02415 > 10?(10):self.view.frame.size.width*0.02415), commentsView.frame.origin.y + commentsView.frame.size.height + (self.view.frame.size.height*0.0407 > 30?(30):self.view.frame.size.height*0.0407), width, (self.view.frame.size.height*0.01902174 > 14?(14):self.view.frame.size.height*0.01902174));
    
    skippingTurnView.frame = CGRectMake(textFieldSpacing, usersTopLabel.frame.origin.y + usersTopLabel.frame.size.height + (self.view.frame.size.height*0.0108695 > 8?(8):self.view.frame.size.height*0.0108695), (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    removingUserView.frame = CGRectMake(textFieldSpacing, skippingTurnView.frame.origin.y + skippingTurnView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    markingTopLabel.frame = CGRectMake(textFieldSpacing + (self.view.frame.size.width*0.02415 > 10?(10):self.view.frame.size.width*0.02415), removingUserView.frame.origin.y + removingUserView.frame.size.height + (self.view.frame.size.height*0.0407 > 30?(30):self.view.frame.size.height*0.0407), width, (self.view.frame.size.height*0.01902174 > 14?(14):self.view.frame.size.height*0.01902174));
    
    fullyCompletedView.frame = CGRectMake(textFieldSpacing, markingTopLabel.frame.origin.y + markingTopLabel.frame.size.height + (self.view.frame.size.height*0.0108695 > 8?(8):self.view.frame.size.height*0.0108695), (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    completedView.frame = CGRectMake(textFieldSpacing, fullyCompletedView.frame.origin.y + fullyCompletedView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    inProgressView.frame = CGRectMake(textFieldSpacing, completedView.frame.origin.y + completedView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    wontDoView.frame = CGRectMake(textFieldSpacing, inProgressView.frame.origin.y + inProgressView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    acceptView.frame = CGRectMake(textFieldSpacing, wontDoView.frame.origin.y + wontDoView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    declineView.frame = CGRectMake(textFieldSpacing, acceptView.frame.origin.y + acceptView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    
    remindersTopLabel.frame = CGRectMake(textFieldSpacing + (self.view.frame.size.width*0.02415 > 10?(10):self.view.frame.size.width*0.02415), declineView.frame.origin.y + declineView.frame.size.height + (self.view.frame.size.height*0.0407 > 30?(30):self.view.frame.size.height*0.0407), width, (self.view.frame.size.height*0.01902174 > 14?(14):self.view.frame.size.height*0.01902174));
    
    dueDateView.frame = CGRectMake(textFieldSpacing, remindersTopLabel.frame.origin.y + remindersTopLabel.frame.size.height + (self.view.frame.size.height*0.0108695 > 8?(8):self.view.frame.size.height*0.0108695), (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    reminderView.frame = CGRectMake(textFieldSpacing, dueDateView.frame.origin.y + dueDateView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    subtasksTopLabel.frame = CGRectMake(textFieldSpacing + (self.view.frame.size.width*0.02415 > 10?(10):self.view.frame.size.width*0.02415), reminderView.frame.origin.y + reminderView.frame.size.height + (self.view.frame.size.height*0.0407 > 30?(30):self.view.frame.size.height*0.0407), width, (self.view.frame.size.height*0.01902174 > 14?(14):self.view.frame.size.height*0.01902174));
    
    subtaskEditView.frame = CGRectMake(textFieldSpacing, subtasksTopLabel.frame.origin.y + subtasksTopLabel.frame.size.height + (self.view.frame.size.height*0.0108695 > 8?(8):self.view.frame.size.height*0.0108695), (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    subtaskDeleteView.frame = CGRectMake(textFieldSpacing, subtaskEditView.frame.origin.y + subtaskEditView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    markingSubtasksTopLabel.frame = CGRectMake(textFieldSpacing + (self.view.frame.size.width*0.02415 > 10?(10):self.view.frame.size.width*0.02415), subtaskDeleteView.frame.origin.y + subtaskDeleteView.frame.size.height + (self.view.frame.size.height*0.0407 > 30?(30):self.view.frame.size.height*0.0407), width, (self.view.frame.size.height*0.01902174 > 14?(14):self.view.frame.size.height*0.01902174));
    
    subtaskCompletedView.frame = CGRectMake(textFieldSpacing, markingSubtasksTopLabel.frame.origin.y + markingSubtasksTopLabel.frame.size.height + (self.view.frame.size.height*0.0108695 > 8?(8):self.view.frame.size.height*0.0108695), (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    subtaskInProgressView.frame = CGRectMake(textFieldSpacing, subtaskCompletedView.frame.origin.y + subtaskCompletedView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    subtaskWontDoView.frame = CGRectMake(textFieldSpacing, subtaskInProgressView.frame.origin.y + subtaskInProgressView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    subtaskAcceptView.frame = CGRectMake(textFieldSpacing, subtaskWontDoView.frame.origin.y + subtaskWontDoView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    subtaskDeclineView.frame = CGRectMake(textFieldSpacing, subtaskAcceptView.frame.origin.y + subtaskAcceptView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    CGFloat maxHeight = self.view.frame.size.height + 1;
    
    CGFloat heightToUse = subtaskDeclineView.frame.origin.y + subtaskDeclineView.frame.size.height + (height*0.01086957) < maxHeight ? maxHeight : subtaskDeclineView.frame.origin.y + subtaskDeclineView.frame.size.height + (height*0.01086957);
    
    _customScrollView.contentSize = CGSizeMake(0, heightToUse);
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    [self.customScrollView addSubview:itemTypeTopLabel];
    [self.customScrollView addSubview:markingTopLabel];
    [self.customScrollView addSubview:usersTopLabel];
    [self.customScrollView addSubview:remindersTopLabel];
    [self.customScrollView addSubview:subtasksTopLabel];
    [self.customScrollView addSubview:markingSubtasksTopLabel];
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    [self.customScrollView addSubview:addingView];
    [addingView addSubview:addingLabel];
    [addingView addSubview:addingSwitch];
    
    [self.customScrollView addSubview:editingView];
    [editingView addSubview:editingLabel];
    [editingView addSubview:editingSwitch];
    
    [self.customScrollView addSubview:deletingView];
    [deletingView addSubview:deletingLabel];
    [deletingView addSubview:deletingSwitch];
    
    [self.customScrollView addSubview:duplicatingView];
    [duplicatingView addSubview:duplicatingLabel];
    [duplicatingView addSubview:duplicatingSwitch];
    
    [self.customScrollView addSubview:waivingsView];
    [waivingsView addSubview:waivingLabel];
    [waivingsView addSubview:waivingSwitch];
    
    [self.customScrollView addSubview:skippingsView];
    [skippingsView addSubview:skippingLabel];
    [skippingsView addSubview:skippingSwitch];
    
    [self.customScrollView addSubview:pauseUnpauseView];
    [pauseUnpauseView addSubview:pauseUnpauseLabel];
    [pauseUnpauseView addSubview:pauseUnpauseSwitch];
    
    [self.customScrollView addSubview:commentsView];
    [commentsView addSubview:commentsLabel];
    [commentsView addSubview:commentsSwitch];
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    [self.customScrollView addSubview:skippingTurnView];
    [skippingTurnView addSubview:skippingTurnLabel];
    [skippingTurnView addSubview:skippingTurnSwitch];
    
    [self.customScrollView addSubview:removingUserView];
    [removingUserView addSubview:removingUserLabel];
    [removingUserView addSubview:removingUserSwitch];
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    [self.customScrollView addSubview:fullyCompletedView];
    [fullyCompletedView addSubview:fullyCompletedLabel];
    [fullyCompletedView addSubview:fullyCompletedSwitch];
    
    [self.customScrollView addSubview:completedView];
    [completedView addSubview:subLabel];
    [completedView addSubview:completedSwitch];
    
    [self.customScrollView addSubview:inProgressView];
    [inProgressView addSubview:inProgressLabel];
    [inProgressView addSubview:inProgressSwitch];
    
    [self.customScrollView addSubview:wontDoView];
    [wontDoView addSubview:wontDoLabel];
    [wontDoView addSubview:wontDoSwitch];
    
    [self.customScrollView addSubview:acceptView];
    [acceptView addSubview:acceptLabel];
    [acceptView addSubview:acceptSwitch];
    
    [self.customScrollView addSubview:declineView];
    [declineView addSubview:declineLabel];
    [declineView addSubview:declineSwitch];
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    [self.customScrollView addSubview:dueDateView];
    [dueDateView addSubview:dueDateLabel];
    [dueDateView addSubview:dueDateSwitch];
    
    [self.customScrollView addSubview:reminderView];
    [reminderView addSubview:reminderLabel];
    [reminderView addSubview:reminderSwitch];
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    [self.customScrollView addSubview:subtaskEditView];
    [subtaskEditView addSubview:subtaskEditLabel];
    [subtaskEditView addSubview:subtaskEditSwitch];
    
    [self.customScrollView addSubview:subtaskDeleteView];
    [subtaskDeleteView addSubview:subtaskDeleteLabel];
    [subtaskDeleteView addSubview:subtaskDeleteSwitch];
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    [self.customScrollView addSubview:subtaskCompletedView];
    [subtaskCompletedView addSubview:subtaskCompletedLabel];
    [subtaskCompletedView addSubview:subtaskCompletedSwitch];
    
    [self.customScrollView addSubview:subtaskInProgressView];
    [subtaskInProgressView addSubview:subtaskInProgressLabel];
    [subtaskInProgressView addSubview:subtaskInProgressSwitch];
    
    [self.customScrollView addSubview:subtaskWontDoView];
    [subtaskWontDoView addSubview:subtaskWontDoLabel];
    [subtaskWontDoView addSubview:subtaskWontDoSwitch];
    
    [self.customScrollView addSubview:subtaskAcceptView];
    [subtaskAcceptView addSubview:subtaskAcceptLabel];
    [subtaskAcceptView addSubview:subtaskAcceptSwitch];
    
    [self.customScrollView addSubview:subtaskDeclineView];
    [subtaskDeclineView addSubview:subtaskDeclineLabel];
    [subtaskDeclineView addSubview:subtaskDeclineSwitch];
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    [self SetUpCorners:@[
        
        @{@"TopView" : addingView, @"BottomView" : commentsView},
        @{@"TopView" : skippingTurnView, @"BottomView" : removingUserView},
        @{@"TopView" : fullyCompletedView, @"BottomView" : declineView},
        @{@"TopView" : dueDateView, @"BottomView" : reminderView},
        @{@"TopView" : subtaskEditView, @"BottomView" : subtaskDeleteView},
        @{@"TopView" : subtaskCompletedView, @"BottomView" : subtaskDeclineView},
        
    ]];
    
    [self SetUpViewBackgroundColor:@[
        
        @{@"View" : addingView},
        @{@"View" : editingView},
        @{@"View" : deletingView},
        @{@"View" : duplicatingView},
        @{@"View" : waivingsView},
        @{@"View" : skippingsView},
        @{@"View" : pauseUnpauseView},
        @{@"View" : commentsView},
        
        @{@"View" : skippingTurnView},
        @{@"View" : removingUserView},
        
        @{@"View" : fullyCompletedView},
        @{@"View" : completedView},
        @{@"View" : inProgressView},
        @{@"View" : wontDoView},
        @{@"View" : acceptView},
        @{@"View" : declineView},
        
        @{@"View" : dueDateView},
        @{@"View" : reminderView},
        
        @{@"View" : subtaskEditView},
        @{@"View" : subtaskDeleteView},
        
        @{@"View" : subtaskCompletedView},
        @{@"View" : subtaskInProgressView},
        @{@"View" : subtaskWontDoView},
        @{@"View" : subtaskAcceptView},
        @{@"View" : subtaskDeclineView},
        
    ]];
    
    [self SetUpBottomLineViews:@[
        
        @{@"View" : addingView},
        @{@"View" : editingView},
        @{@"View" : deletingView},
        @{@"View" : duplicatingView},
        @{@"View" : waivingsView},
        @{@"View" : skippingsView},
        @{@"View" : pauseUnpauseView},
        @{@"View" : commentsView},
        
        @{@"View" : skippingTurnView},
        @{@"View" : removingUserView},
        
        @{@"View" : fullyCompletedView},
        @{@"View" : completedView},
        @{@"View" : inProgressView},
        @{@"View" : wontDoView},
        @{@"View" : acceptView},
        @{@"View" : declineView},
        
        @{@"View" : dueDateView},
        @{@"View" : reminderView},
        
        @{@"View" : subtaskEditView},
        @{@"View" : subtaskDeleteView},
        
        @{@"View" : subtaskCompletedView},
        @{@"View" : subtaskInProgressView},
        @{@"View" : subtaskWontDoView},
        @{@"View" : subtaskAcceptView},
        @{@"View" : subtaskDeclineView},
        
    ]];
    
    [self SetUpTopLabelUI:@[
        
        @{@"Label" : itemTypeTopLabel, @"Text" : @"CHORES"},
        @{@"Label" : markingTopLabel, @"Text" : @"MARKING"},
        @{@"Label" : usersTopLabel, @"Text" : @"USERS"},
        @{@"Label" : remindersTopLabel, @"Text" : @"REMINDERS"},
        @{@"Label" : subtasksTopLabel, @"Text" : @"SUBTASKS"},
        @{@"Label" : markingSubtasksTopLabel, @"Text" : @"MARKING SUBTASKS"},
        
    ]];
    
    [self SetUpLabelFontSize:@[
        
        @{@"Label" : addingLabel},
        @{@"Label" : editingLabel},
        @{@"Label" : deletingLabel},
        @{@"Label" : duplicatingLabel},
        @{@"Label" : waivingLabel},
        @{@"Label" : skippingLabel},
        @{@"Label" : pauseUnpauseLabel},
        @{@"Label" : commentsLabel},
        
        @{@"Label" : skippingTurnLabel},
        @{@"Label" : removingUserLabel},
        
        @{@"Label" : fullyCompletedLabel},
        @{@"Label" : subLabel},
        @{@"Label" : inProgressLabel},
        @{@"Label" : wontDoLabel},
        @{@"Label" : acceptLabel},
        @{@"Label" : declineLabel},
        
        @{@"Label" : dueDateLabel},
        @{@"Label" : reminderLabel},
        
        @{@"Label" : subtaskEditLabel},
        @{@"Label" : subtaskDeleteLabel},
        
        @{@"Label" : subtaskCompletedLabel},
        @{@"Label" : subtaskInProgressLabel},
        @{@"Label" : subtaskWontDoLabel},
        @{@"Label" : subtaskAcceptLabel},
        @{@"Label" : subtaskDeclineLabel},
        
    ]];
    
    [self SetUpLabelWithoutImage:@[
        
        @{@"Label" : addingLabel, @"Width" : @"0.75"},
        @{@"Label" : editingLabel, @"Width" : @"0.75"},
        @{@"Label" : deletingLabel, @"Width" : @"0.75"},
        @{@"Label" : duplicatingLabel, @"Width" : @"0.75"},
        @{@"Label" : waivingLabel, @"Width" : @"0.75"},
        @{@"Label" : skippingLabel, @"Width" : @"0.75"},
        @{@"Label" : pauseUnpauseLabel, @"Width" : @"0.75"},
        @{@"Label" : commentsLabel, @"Width" : @"0.75"},
        
        @{@"Label" : skippingTurnLabel, @"Width" : @"0.75"},
        @{@"Label" : removingUserLabel, @"Width" : @"0.75"},
        
        @{@"Label" : fullyCompletedLabel, @"Width" : @"0.75"},
        @{@"Label" : subLabel, @"Width" : @"0.75"},
        @{@"Label" : inProgressLabel, @"Width" : @"0.75"},
        @{@"Label" : wontDoLabel, @"Width" : @"0.75"},
        @{@"Label" : acceptLabel, @"Width" : @"0.75"},
        @{@"Label" : declineLabel, @"Width" : @"0.75"},
        
        @{@"Label" : dueDateLabel, @"Width" : @"0.75"},
        @{@"Label" : reminderLabel, @"Width" : @"0.75"},
        
        @{@"Label" : subtaskEditLabel, @"Width" : @"0.75"},
        @{@"Label" : subtaskDeleteLabel, @"Width" : @"0.75"},
        
        @{@"Label" : subtaskCompletedLabel, @"Width" : @"0.75"},
        @{@"Label" : subtaskInProgressLabel, @"Width" : @"0.75"},
        @{@"Label" : subtaskWontDoLabel, @"Width" : @"0.75"},
        @{@"Label" : subtaskAcceptLabel, @"Width" : @"0.75"},
        @{@"Label" : subtaskDeclineLabel, @"Width" : @"0.75"},
        
    ]];
    
    dispatch_once(&onceToken, ^{
        
        [self SetUpControlSwitchFrame:@[
            
            @{@"Switch" : addingSwitch},
            @{@"Switch" : editingSwitch},
            @{@"Switch" : deletingSwitch},
            @{@"Switch" : duplicatingSwitch},
            @{@"Switch" : waivingSwitch},
            @{@"Switch" : skippingSwitch},
            @{@"Switch" : pauseUnpauseSwitch},
            @{@"Switch" : commentsSwitch},
            
            @{@"Switch" : skippingTurnSwitch},
            @{@"Switch" : removingUserSwitch},
            
            @{@"Switch" : fullyCompletedSwitch},
            @{@"Switch" : completedSwitch},
            @{@"Switch" : inProgressSwitch},
            @{@"Switch" : wontDoSwitch},
            @{@"Switch" : acceptSwitch},
            @{@"Switch" : declineSwitch},
            
            @{@"Switch" : dueDateSwitch},
            @{@"Switch" : reminderSwitch},
            
            @{@"Switch" : subtaskEditSwitch},
            @{@"Switch" : subtaskDeleteSwitch},
            
            @{@"Switch" : subtaskCompletedSwitch},
            @{@"Switch" : subtaskInProgressSwitch},
            @{@"Switch" : subtaskWontDoSwitch},
            @{@"Switch" : subtaskAcceptSwitch},
            @{@"Switch" : subtaskDeclineSwitch},
            
        ]];
        
    });
    
    [self SetUpSwitchTags:@[
        
        @{@"Switch" : addingSwitch},
        @{@"Switch" : editingSwitch},
        @{@"Switch" : deletingSwitch},
        @{@"Switch" : duplicatingSwitch},
        @{@"Switch" : waivingSwitch},
        @{@"Switch" : skippingSwitch},
        @{@"Switch" : pauseUnpauseSwitch},
        @{@"Switch" : commentsSwitch},
        
        @{@"Switch" : skippingTurnSwitch},
        @{@"Switch" : removingUserSwitch},
        
        @{@"Switch" : fullyCompletedSwitch},
        @{@"Switch" : completedSwitch},
        @{@"Switch" : inProgressSwitch},
        @{@"Switch" : wontDoSwitch},
        @{@"Switch" : acceptSwitch},
        @{@"Switch" : declineSwitch},
        
        @{@"Switch" : dueDateSwitch},
        @{@"Switch" : reminderSwitch},
        
        @{@"Switch" : subtaskEditSwitch},
        @{@"Switch" : subtaskDeleteSwitch},
        
        @{@"Switch" : subtaskCompletedSwitch},
        @{@"Switch" : subtaskInProgressSwitch},
        @{@"Switch" : subtaskWontDoSwitch},
        @{@"Switch" : subtaskAcceptSwitch},
        @{@"Switch" : subtaskDeclineSwitch},
        
    ]];
    
    [self SetUpSwitchStatus:@[
        
        @{@"Switch" : addingSwitch, @"Key" : @"Adding"},
        @{@"Switch" : editingSwitch, @"Key" : @"Editing"},
        @{@"Switch" : deletingSwitch, @"Key" : @"Deleting"},
        @{@"Switch" : duplicatingSwitch, @"Key" : @"Duplicating"},
        @{@"Switch" : waivingSwitch, @"Key" : @"Waiving"},
        @{@"Switch" : skippingSwitch, @"Key" : @"Skipping"},
        @{@"Switch" : pauseUnpauseSwitch, @"Key" : @"Pause/Unpause"},
        @{@"Switch" : commentsSwitch, @"Key" : @"Comments"},
        
        @{@"Switch" : skippingTurnSwitch, @"Key" : @"SkippingTurn"},
        @{@"Switch" : removingUserSwitch, @"Key" : @"RemovingUser"},
        
        @{@"Switch" : fullyCompletedSwitch, @"Key" : @"FullyCompleted"},
        @{@"Switch" : completedSwitch, @"Key" : @"Completed"},
        @{@"Switch" : inProgressSwitch, @"Key" : @"InProgress"},
        @{@"Switch" : wontDoSwitch, @"Key" : @"WontDo"},
        @{@"Switch" : acceptSwitch, @"Key" : @"Accept"},
        @{@"Switch" : declineSwitch, @"Key" : @"Decline"},
        
        @{@"Switch" : dueDateSwitch, @"Key" : @"DueDate"},
        @{@"Switch" : reminderSwitch, @"Key" : @"Reminder"},
        
        @{@"Switch" : subtaskEditSwitch, @"Key" : @"SubtaskEditing"},
        @{@"Switch" : subtaskDeleteSwitch, @"Key" : @"SubtaskDeleting"},
        
        @{@"Switch" : subtaskCompletedSwitch, @"Key" : @"SubtaskCompleted"},
        @{@"Switch" : subtaskInProgressSwitch, @"Key" : @"SubtaskInProgress"},
        @{@"Switch" : subtaskWontDoSwitch, @"Key" : @"SubtaskWontDo"},
        @{@"Switch" : subtaskAcceptSwitch, @"Key" : @"SubtaskAccept"},
        @{@"Switch" : subtaskDeclineSwitch, @"Key" : @"SubtaskDecline"},
        
    ] itemType:@"Chores" selector:@selector(ChoreOptionsSwitch:)];
    
}

-(void)ExpensesSetup {
    
    itemTypeTopLabel = [[UILabel alloc] init];
    markingTopLabel = [[UILabel alloc] init];
    usersTopLabel = [[UILabel alloc] init];
    remindersTopLabel = [[UILabel alloc] init];
    itemizedItemsTopLabel = [[UILabel alloc] init];
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    addingView = [[UIView alloc] init];
    addingLabel = [[UILabel alloc] init];
    addingSwitch = [[UISwitch alloc] init];
    
    editingView = [[UIView alloc] init];
    editingLabel = [[UILabel alloc] init];
    editingSwitch = [[UISwitch alloc] init];
    
    deletingView = [[UIView alloc] init];
    deletingLabel = [[UILabel alloc] init];
    deletingSwitch = [[UISwitch alloc] init];
    
    duplicatingView = [[UIView alloc] init];
    duplicatingLabel = [[UILabel alloc] init];
    duplicatingSwitch = [[UISwitch alloc] init];
    
    waivingsView = [[UIView alloc] init];
    waivingLabel = [[UILabel alloc] init];
    waivingSwitch = [[UISwitch alloc] init];
    
    skippingsView = [[UIView alloc] init];
    skippingLabel = [[UILabel alloc] init];
    skippingSwitch = [[UISwitch alloc] init];
    
    pauseUnpauseView = [[UIView alloc] init];
    pauseUnpauseLabel = [[UILabel alloc] init];
    pauseUnpauseSwitch = [[UISwitch alloc] init];
    
    commentsView = [[UIView alloc] init];
    commentsLabel = [[UILabel alloc] init];
    commentsSwitch = [[UISwitch alloc] init];
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    skippingTurnView = [[UIView alloc] init];
    skippingTurnLabel = [[UILabel alloc] init];
    skippingTurnSwitch = [[UISwitch alloc] init];
    
    removingUserView = [[UIView alloc] init];
    removingUserLabel = [[UILabel alloc] init];
    removingUserSwitch = [[UISwitch alloc] init];
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    fullyCompletedView = [[UIView alloc] init];
    fullyCompletedLabel = [[UILabel alloc] init];
    fullyCompletedSwitch = [[UISwitch alloc] init];
    
    completedView = [[UIView alloc] init];
    subLabel = [[UILabel alloc] init];
    completedSwitch = [[UISwitch alloc] init];
    
    inProgressView = [[UIView alloc] init];
    inProgressLabel = [[UILabel alloc] init];
    inProgressSwitch = [[UISwitch alloc] init];
    
    wontDoView = [[UIView alloc] init];
    wontDoLabel = [[UILabel alloc] init];
    wontDoSwitch = [[UISwitch alloc] init];
    
    acceptView = [[UIView alloc] init];
    acceptLabel = [[UILabel alloc] init];
    acceptSwitch = [[UISwitch alloc] init];
    
    declineView = [[UIView alloc] init];
    declineLabel = [[UILabel alloc] init];
    declineSwitch = [[UISwitch alloc] init];
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    dueDateView = [[UIView alloc] init];
    dueDateLabel = [[UILabel alloc] init];
    dueDateSwitch = [[UISwitch alloc] init];
    
    reminderView = [[UIView alloc] init];
    reminderLabel = [[UILabel alloc] init];
    reminderSwitch = [[UISwitch alloc] init];
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    editItemizedItemView = [[UIView alloc] init];
    editItemizedItemLabel = [[UILabel alloc] init];
    editItemizedItemSwitch = [[UISwitch alloc] init];
    
    deleteItemizedItemView = [[UIView alloc] init];
    deleteItemizedItemLabel = [[UILabel alloc] init];
    deleteItemizedItemSwitch = [[UISwitch alloc] init];
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    addingLabel.text = @"Adding";
    editingLabel.text = @"Editing";
    deletingLabel.text = @"Deleting";
    duplicatingLabel.text = @"Duplicating";
    waivingLabel.text = @"Waiving";
    skippingLabel.text = @"Skipping";
    pauseUnpauseLabel.text = @"Pausing/Unpausing";
    commentsLabel.text = @"Comments";
    
    skippingTurnLabel.text = @"Skipping Turn";
    removingUserLabel.text = @"Removing User";
    
    fullyCompletedLabel.text = @"Fully Completed";
    subLabel.text = @"Completed";
    inProgressLabel.text = @"In Progress";
    wontDoLabel.text = @"Won't Do";
    acceptLabel.text = @"Accept";
    declineLabel.text = @"Decline";
    
    dueDateLabel.text = @"Due Date";
    reminderLabel.text = @"Reminder";
    
    editItemizedItemLabel.text = @"Itemized Expense Editing";
    deleteItemizedItemLabel.text = @"Itemized Expense Deleting";
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    CGFloat textFieldSpacing = (height*0.024456);
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    itemTypeTopLabel.frame = CGRectMake(textFieldSpacing + (self.view.frame.size.width*0.02415 > 10?(10):self.view.frame.size.width*0.02415), (self.view.frame.size.height*0.0407 > 30?(30):self.view.frame.size.height*0.0407), width, (self.view.frame.size.height*0.01902174 > 14?(14):self.view.frame.size.height*0.01902174));
    
    addingView.frame = CGRectMake(textFieldSpacing, itemTypeTopLabel.frame.origin.y + itemTypeTopLabel.frame.size.height + (self.view.frame.size.height*0.0108695 > 8?(8):self.view.frame.size.height*0.0108695), (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    editingView.frame = CGRectMake(textFieldSpacing, addingView.frame.origin.y + addingView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    deletingView.frame = CGRectMake(textFieldSpacing, editingView.frame.origin.y + editingView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    duplicatingView.frame = CGRectMake(textFieldSpacing, deletingView.frame.origin.y + deletingView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    waivingsView.frame = CGRectMake(textFieldSpacing, duplicatingView.frame.origin.y + duplicatingView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    skippingsView.frame = CGRectMake(textFieldSpacing, waivingsView.frame.origin.y + waivingsView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    pauseUnpauseView.frame = CGRectMake(textFieldSpacing, skippingsView.frame.origin.y + skippingsView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    commentsView.frame = CGRectMake(textFieldSpacing, pauseUnpauseView.frame.origin.y + pauseUnpauseView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    usersTopLabel.frame = CGRectMake(textFieldSpacing + (self.view.frame.size.width*0.02415 > 10?(10):self.view.frame.size.width*0.02415), commentsView.frame.origin.y + commentsView.frame.size.height + (self.view.frame.size.height*0.0407 > 30?(30):self.view.frame.size.height*0.0407), width, (self.view.frame.size.height*0.01902174 > 14?(14):self.view.frame.size.height*0.01902174));
    
    skippingTurnView.frame = CGRectMake(textFieldSpacing, usersTopLabel.frame.origin.y + usersTopLabel.frame.size.height + (self.view.frame.size.height*0.0108695 > 8?(8):self.view.frame.size.height*0.0108695), (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    removingUserView.frame = CGRectMake(textFieldSpacing, skippingTurnView.frame.origin.y + skippingTurnView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    markingTopLabel.frame = CGRectMake(textFieldSpacing + (self.view.frame.size.width*0.02415 > 10?(10):self.view.frame.size.width*0.02415), removingUserView.frame.origin.y + removingUserView.frame.size.height + (self.view.frame.size.height*0.0407 > 30?(30):self.view.frame.size.height*0.0407), width, (self.view.frame.size.height*0.01902174 > 14?(14):self.view.frame.size.height*0.01902174));
    
    fullyCompletedView.frame = CGRectMake(textFieldSpacing, markingTopLabel.frame.origin.y + markingTopLabel.frame.size.height + (self.view.frame.size.height*0.0108695 > 8?(8):self.view.frame.size.height*0.0108695), (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    completedView.frame = CGRectMake(textFieldSpacing, fullyCompletedView.frame.origin.y + fullyCompletedView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    inProgressView.frame = CGRectMake(textFieldSpacing, completedView.frame.origin.y + completedView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    wontDoView.frame = CGRectMake(textFieldSpacing, inProgressView.frame.origin.y + inProgressView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    acceptView.frame = CGRectMake(textFieldSpacing, wontDoView.frame.origin.y + wontDoView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    declineView.frame = CGRectMake(textFieldSpacing, acceptView.frame.origin.y + acceptView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    
    remindersTopLabel.frame = CGRectMake(textFieldSpacing + (self.view.frame.size.width*0.02415 > 10?(10):self.view.frame.size.width*0.02415), declineView.frame.origin.y + declineView.frame.size.height + (self.view.frame.size.height*0.0407 > 30?(30):self.view.frame.size.height*0.0407), width, (self.view.frame.size.height*0.01902174 > 14?(14):self.view.frame.size.height*0.01902174));
    
    dueDateView.frame = CGRectMake(textFieldSpacing, remindersTopLabel.frame.origin.y + remindersTopLabel.frame.size.height + (self.view.frame.size.height*0.0108695 > 8?(8):self.view.frame.size.height*0.0108695), (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    reminderView.frame = CGRectMake(textFieldSpacing, dueDateView.frame.origin.y + dueDateView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    itemizedItemsTopLabel.frame = CGRectMake(textFieldSpacing + (self.view.frame.size.width*0.02415 > 10?(10):self.view.frame.size.width*0.02415), reminderView.frame.origin.y + reminderView.frame.size.height + (self.view.frame.size.height*0.0407 > 30?(30):self.view.frame.size.height*0.0407), width, (self.view.frame.size.height*0.01902174 > 14?(14):self.view.frame.size.height*0.01902174));
    
    editItemizedItemView.frame = CGRectMake(textFieldSpacing, itemizedItemsTopLabel.frame.origin.y + itemizedItemsTopLabel.frame.size.height + (self.view.frame.size.height*0.0108695 > 8?(8):self.view.frame.size.height*0.0108695), (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    deleteItemizedItemView.frame = CGRectMake(textFieldSpacing, editItemizedItemView.frame.origin.y + editItemizedItemView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    CGFloat maxHeight = self.view.frame.size.height + 1;
    
    CGFloat heightToUse = deleteItemizedItemView.frame.origin.y + deleteItemizedItemView.frame.size.height + (height*0.01086957) < maxHeight ? maxHeight : deleteItemizedItemView.frame.origin.y + deleteItemizedItemView.frame.size.height + (height*0.01086957);
    
    _customScrollView.contentSize = CGSizeMake(0, heightToUse);
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    [self.customScrollView addSubview:itemTypeTopLabel];
    [self.customScrollView addSubview:markingTopLabel];
    [self.customScrollView addSubview:usersTopLabel];
    [self.customScrollView addSubview:remindersTopLabel];
    [self.customScrollView addSubview:itemizedItemsTopLabel];
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    [self.customScrollView addSubview:addingView];
    [addingView addSubview:addingLabel];
    [addingView addSubview:addingSwitch];
    
    [self.customScrollView addSubview:editingView];
    [editingView addSubview:editingLabel];
    [editingView addSubview:editingSwitch];
    
    [self.customScrollView addSubview:deletingView];
    [deletingView addSubview:deletingLabel];
    [deletingView addSubview:deletingSwitch];
    
    [self.customScrollView addSubview:duplicatingView];
    [duplicatingView addSubview:duplicatingLabel];
    [duplicatingView addSubview:duplicatingSwitch];
    
    [self.customScrollView addSubview:waivingsView];
    [waivingsView addSubview:waivingLabel];
    [waivingsView addSubview:waivingSwitch];
    
    [self.customScrollView addSubview:skippingsView];
    [skippingsView addSubview:skippingLabel];
    [skippingsView addSubview:skippingSwitch];
    
    [self.customScrollView addSubview:pauseUnpauseView];
    [pauseUnpauseView addSubview:pauseUnpauseLabel];
    [pauseUnpauseView addSubview:pauseUnpauseSwitch];
    
    [self.customScrollView addSubview:commentsView];
    [commentsView addSubview:commentsLabel];
    [commentsView addSubview:commentsSwitch];
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    [self.customScrollView addSubview:skippingTurnView];
    [skippingTurnView addSubview:skippingTurnLabel];
    [skippingTurnView addSubview:skippingTurnSwitch];
    
    [self.customScrollView addSubview:removingUserView];
    [removingUserView addSubview:removingUserLabel];
    [removingUserView addSubview:removingUserSwitch];
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    [self.customScrollView addSubview:fullyCompletedView];
    [fullyCompletedView addSubview:fullyCompletedLabel];
    [fullyCompletedView addSubview:fullyCompletedSwitch];
    
    [self.customScrollView addSubview:completedView];
    [completedView addSubview:subLabel];
    [completedView addSubview:completedSwitch];
    
    [self.customScrollView addSubview:inProgressView];
    [inProgressView addSubview:inProgressLabel];
    [inProgressView addSubview:inProgressSwitch];
    
    [self.customScrollView addSubview:wontDoView];
    [wontDoView addSubview:wontDoLabel];
    [wontDoView addSubview:wontDoSwitch];
    
    [self.customScrollView addSubview:acceptView];
    [acceptView addSubview:acceptLabel];
    [acceptView addSubview:acceptSwitch];
    
    [self.customScrollView addSubview:declineView];
    [declineView addSubview:declineLabel];
    [declineView addSubview:declineSwitch];
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    [self.customScrollView addSubview:dueDateView];
    [dueDateView addSubview:dueDateLabel];
    [dueDateView addSubview:dueDateSwitch];
    
    [self.customScrollView addSubview:reminderView];
    [reminderView addSubview:reminderLabel];
    [reminderView addSubview:reminderSwitch];
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    [self.customScrollView addSubview:editItemizedItemView];
    [editItemizedItemView addSubview:editItemizedItemLabel];
    [editItemizedItemView addSubview:editItemizedItemSwitch];
    
    [self.customScrollView addSubview:deleteItemizedItemView];
    [deleteItemizedItemView addSubview:deleteItemizedItemLabel];
    [deleteItemizedItemView addSubview:deleteItemizedItemSwitch];
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    [self SetUpCorners:@[
        
        @{@"TopView" : addingView, @"BottomView" : commentsView},
        @{@"TopView" : skippingTurnView, @"BottomView" : removingUserView},
        @{@"TopView" : fullyCompletedView, @"BottomView" : declineView},
        @{@"TopView" : dueDateView, @"BottomView" : reminderView},
        @{@"TopView" : editItemizedItemView, @"BottomView" : deleteItemizedItemView},
        
    ]];
    
    [self SetUpViewBackgroundColor:@[
        
        @{@"View" : addingView},
        @{@"View" : editingView},
        @{@"View" : deletingView},
        @{@"View" : duplicatingView},
        @{@"View" : waivingsView},
        @{@"View" : skippingsView},
        @{@"View" : pauseUnpauseView},
        @{@"View" : commentsView},
        
        @{@"View" : skippingTurnView},
        @{@"View" : removingUserView},
        
        @{@"View" : fullyCompletedView},
        @{@"View" : completedView},
        @{@"View" : inProgressView},
        @{@"View" : wontDoView},
        @{@"View" : acceptView},
        @{@"View" : declineView},
        
        @{@"View" : dueDateView},
        @{@"View" : reminderView},
        
        @{@"View" : editItemizedItemView},
        @{@"View" : deleteItemizedItemView},
        
    ]];
    
    [self SetUpBottomLineViews:@[
        
        @{@"View" : addingView},
        @{@"View" : editingView},
        @{@"View" : deletingView},
        @{@"View" : duplicatingView},
        @{@"View" : waivingsView},
        @{@"View" : skippingsView},
        @{@"View" : pauseUnpauseView},
        @{@"View" : commentsView},
        
        @{@"View" : skippingTurnView},
        @{@"View" : removingUserView},
        
        @{@"View" : fullyCompletedView},
        @{@"View" : completedView},
        @{@"View" : inProgressView},
        @{@"View" : wontDoView},
        @{@"View" : acceptView},
        @{@"View" : declineView},
        
        @{@"View" : dueDateView},
        @{@"View" : reminderView},
        
        @{@"View" : editItemizedItemView},
        @{@"View" : deleteItemizedItemView},
        
    ]];
    
    [self SetUpTopLabelUI:@[
        
        @{@"Label" : itemTypeTopLabel, @"Text" : @"EXPENSES"},
        @{@"Label" : markingTopLabel, @"Text" : @"MARKING"},
        @{@"Label" : usersTopLabel, @"Text" : @"USERS"},
        @{@"Label" : remindersTopLabel, @"Text" : @"REMINDERS"},
        @{@"Label" : itemizedItemsTopLabel, @"Text" : @"ITEMIZED EXPENSES"},
        
    ]];
    
    [self SetUpLabelFontSize:@[
        
        @{@"Label" : addingLabel},
        @{@"Label" : editingLabel},
        @{@"Label" : deletingLabel},
        @{@"Label" : duplicatingLabel},
        @{@"Label" : waivingLabel},
        @{@"Label" : skippingLabel},
        @{@"Label" : pauseUnpauseLabel},
        @{@"Label" : commentsLabel},
        
        @{@"Label" : skippingTurnLabel},
        @{@"Label" : removingUserLabel},
        
        @{@"Label" : fullyCompletedLabel},
        @{@"Label" : subLabel},
        @{@"Label" : inProgressLabel},
        @{@"Label" : wontDoLabel},
        @{@"Label" : acceptLabel},
        @{@"Label" : declineLabel},
        
        @{@"Label" : dueDateLabel},
        @{@"Label" : reminderLabel},
        
        @{@"Label" : editItemizedItemLabel},
        @{@"Label" : deleteItemizedItemLabel},
        
    ]];
    
    [self SetUpLabelWithoutImage:@[
        
        @{@"Label" : addingLabel, @"Width" : @"0.75"},
        @{@"Label" : editingLabel, @"Width" : @"0.75"},
        @{@"Label" : deletingLabel, @"Width" : @"0.75"},
        @{@"Label" : duplicatingLabel, @"Width" : @"0.75"},
        @{@"Label" : waivingLabel, @"Width" : @"0.75"},
        @{@"Label" : skippingLabel, @"Width" : @"0.75"},
        @{@"Label" : pauseUnpauseLabel, @"Width" : @"0.75"},
        @{@"Label" : commentsLabel, @"Width" : @"0.75"},
        
        @{@"Label" : skippingTurnLabel, @"Width" : @"0.75"},
        @{@"Label" : removingUserLabel, @"Width" : @"0.75"},
        
        @{@"Label" : fullyCompletedLabel, @"Width" : @"0.75"},
        @{@"Label" : subLabel, @"Width" : @"0.75"},
        @{@"Label" : inProgressLabel, @"Width" : @"0.75"},
        @{@"Label" : wontDoLabel, @"Width" : @"0.75"},
        @{@"Label" : acceptLabel, @"Width" : @"0.75"},
        @{@"Label" : declineLabel, @"Width" : @"0.75"},
        
        @{@"Label" : dueDateLabel, @"Width" : @"0.75"},
        @{@"Label" : reminderLabel, @"Width" : @"0.75"},
        
        @{@"Label" : editItemizedItemLabel, @"Width" : @"0.75"},
        @{@"Label" : deleteItemizedItemLabel, @"Width" : @"0.75"},
        
    ]];
    
    dispatch_once(&onceToken, ^{
        
        [self SetUpControlSwitchFrame:@[
            
            @{@"Switch" : addingSwitch},
            @{@"Switch" : editingSwitch},
            @{@"Switch" : deletingSwitch},
            @{@"Switch" : duplicatingSwitch},
            @{@"Switch" : waivingSwitch},
            @{@"Switch" : skippingSwitch},
            @{@"Switch" : pauseUnpauseSwitch},
            @{@"Switch" : commentsSwitch},
            
            @{@"Switch" : skippingTurnSwitch},
            @{@"Switch" : removingUserSwitch},
            
            @{@"Switch" : fullyCompletedSwitch},
            @{@"Switch" : completedSwitch},
            @{@"Switch" : inProgressSwitch},
            @{@"Switch" : wontDoSwitch},
            @{@"Switch" : acceptSwitch},
            @{@"Switch" : declineSwitch},
            
            @{@"Switch" : dueDateSwitch},
            @{@"Switch" : reminderSwitch},
            
            @{@"Switch" : editItemizedItemSwitch},
            @{@"Switch" : deleteItemizedItemSwitch},
            
        ]];
        
    });
    
    [self SetUpSwitchTags:@[
        
        @{@"Switch" : addingSwitch},
        @{@"Switch" : editingSwitch},
        @{@"Switch" : deletingSwitch},
        @{@"Switch" : duplicatingSwitch},
        @{@"Switch" : waivingSwitch},
        @{@"Switch" : skippingSwitch},
        @{@"Switch" : pauseUnpauseSwitch},
        @{@"Switch" : commentsSwitch},
        
        @{@"Switch" : skippingTurnSwitch},
        @{@"Switch" : removingUserSwitch},
        
        @{@"Switch" : fullyCompletedSwitch},
        @{@"Switch" : completedSwitch},
        @{@"Switch" : inProgressSwitch},
        @{@"Switch" : wontDoSwitch},
        @{@"Switch" : acceptSwitch},
        @{@"Switch" : declineSwitch},
        
        @{@"Switch" : dueDateSwitch},
        @{@"Switch" : reminderSwitch},
        
        @{@"Switch" : editItemizedItemSwitch},
        @{@"Switch" : deleteItemizedItemSwitch},
        
    ]];
    
    [self SetUpSwitchStatus:@[
        
        @{@"Switch" : addingSwitch, @"Key" : @"Adding"},
        @{@"Switch" : editingSwitch, @"Key" : @"Editing"},
        @{@"Switch" : deletingSwitch, @"Key" : @"Deleting"},
        @{@"Switch" : duplicatingSwitch, @"Key" : @"Duplicating"},
        @{@"Switch" : waivingSwitch, @"Key" : @"Waiving"},
        @{@"Switch" : skippingSwitch, @"Key" : @"Skipping"},
        @{@"Switch" : pauseUnpauseSwitch, @"Key" : @"Pause/Unpause"},
        @{@"Switch" : commentsSwitch, @"Key" : @"Comments"},
        
        @{@"Switch" : skippingTurnSwitch, @"Key" : @"SkippingTurn"},
        @{@"Switch" : removingUserSwitch, @"Key" : @"RemovingUser"},
        
        @{@"Switch" : fullyCompletedSwitch, @"Key" : @"FullyCompleted"},
        @{@"Switch" : completedSwitch, @"Key" : @"Completed"},
        @{@"Switch" : inProgressSwitch, @"Key" : @"InProgress"},
        @{@"Switch" : wontDoSwitch, @"Key" : @"WontDo"},
        @{@"Switch" : acceptSwitch, @"Key" : @"Accept"},
        @{@"Switch" : declineSwitch, @"Key" : @"Decline"},
        
        @{@"Switch" : dueDateSwitch, @"Key" : @"DueDate"},
        @{@"Switch" : reminderSwitch, @"Key" : @"Reminder"},
        
        @{@"Switch" : editItemizedItemSwitch, @"Key" : @"EditingItemizedItem"},
        @{@"Switch" : deleteItemizedItemSwitch, @"Key" : @"DeletingItemizedItem"},
        
    ] itemType:@"Expenses" selector:@selector(ExpenseOptionsSwitch:)];
    
}

-(void)ListsSetup {
    
    itemTypeTopLabel = [[UILabel alloc] init];
    markingTopLabel = [[UILabel alloc] init];
    remindersTopLabel = [[UILabel alloc] init];
    listItemsTopLabel = [[UILabel alloc] init];
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    addingView = [[UIView alloc] init];
    addingLabel = [[UILabel alloc] init];
    addingSwitch = [[UISwitch alloc] init];
    
    editingView = [[UIView alloc] init];
    editingLabel = [[UILabel alloc] init];
    editingSwitch = [[UISwitch alloc] init];
    
    deletingView = [[UIView alloc] init];
    deletingLabel = [[UILabel alloc] init];
    deletingSwitch = [[UISwitch alloc] init];
    
    duplicatingView = [[UIView alloc] init];
    duplicatingLabel = [[UILabel alloc] init];
    duplicatingSwitch = [[UISwitch alloc] init];
    
    waivingsView = [[UIView alloc] init];
    waivingLabel = [[UILabel alloc] init];
    waivingSwitch = [[UISwitch alloc] init];
    
    skippingsView = [[UIView alloc] init];
    skippingLabel = [[UILabel alloc] init];
    skippingSwitch = [[UISwitch alloc] init];
    
    pauseUnpauseView = [[UIView alloc] init];
    pauseUnpauseLabel = [[UILabel alloc] init];
    pauseUnpauseSwitch = [[UISwitch alloc] init];
    
    commentsView = [[UIView alloc] init];
    commentsLabel = [[UILabel alloc] init];
    commentsSwitch = [[UISwitch alloc] init];
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    fullyCompletedView = [[UIView alloc] init];
    fullyCompletedLabel = [[UILabel alloc] init];
    fullyCompletedSwitch = [[UISwitch alloc] init];
    
    completedView = [[UIView alloc] init];
    subLabel = [[UILabel alloc] init];
    completedSwitch = [[UISwitch alloc] init];
    
    inProgressView = [[UIView alloc] init];
    inProgressLabel = [[UILabel alloc] init];
    inProgressSwitch = [[UISwitch alloc] init];
    
    wontDoView = [[UIView alloc] init];
    wontDoLabel = [[UILabel alloc] init];
    wontDoSwitch = [[UISwitch alloc] init];
    
    acceptView = [[UIView alloc] init];
    acceptLabel = [[UILabel alloc] init];
    acceptSwitch = [[UISwitch alloc] init];
    
    declineView = [[UIView alloc] init];
    declineLabel = [[UILabel alloc] init];
    declineSwitch = [[UISwitch alloc] init];
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    dueDateView = [[UIView alloc] init];
    dueDateLabel = [[UILabel alloc] init];
    dueDateSwitch = [[UISwitch alloc] init];
    
    reminderView = [[UIView alloc] init];
    reminderLabel = [[UILabel alloc] init];
    reminderSwitch = [[UISwitch alloc] init];
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    addListItemView = [[UIView alloc] init];
    addListItemLabel = [[UILabel alloc] init];
    addListItemSwitch = [[UISwitch alloc] init];
    
    editListItemView = [[UIView alloc] init];
    editListItemLabel = [[UILabel alloc] init];
    editListItemSwitch = [[UISwitch alloc] init];
    
    deleteListItemView = [[UIView alloc] init];
    deleteListItemLabel = [[UILabel alloc] init];
    deleteListItemSwitch = [[UISwitch alloc] init];
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    addingLabel.text = @"Adding";
    editingLabel.text = @"Editing";
    deletingLabel.text = @"Deleting";
    duplicatingLabel.text = @"Duplicating";
    waivingLabel.text = @"Waiving";
    skippingLabel.text = @"Skipping";
    pauseUnpauseLabel.text = @"Pausing/Unpausing";
    commentsLabel.text = @"Comments";
    
    fullyCompletedLabel.text = @"Fully Completed";
    subLabel.text = @"Completed";
    inProgressLabel.text = @"In Progress";
    wontDoLabel.text = @"Won't Do";
    acceptLabel.text = @"Accept";
    declineLabel.text = @"Decline";
    
    dueDateLabel.text = @"Due Date";
    reminderLabel.text = @"Reminder";
    
    addListItemLabel.text = @"List Item Adding";
    editListItemLabel.text = @"List Item Editing";
    deleteListItemLabel.text = @"List Item Deleting";
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    CGFloat textFieldSpacing = (height*0.024456);
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    itemTypeTopLabel.frame = CGRectMake(textFieldSpacing + (self.view.frame.size.width*0.02415 > 10?(10):self.view.frame.size.width*0.02415), (self.view.frame.size.height*0.0407 > 30?(30):self.view.frame.size.height*0.0407), width, (self.view.frame.size.height*0.01902174 > 14?(14):self.view.frame.size.height*0.01902174));
    
    addingView.frame = CGRectMake(textFieldSpacing, itemTypeTopLabel.frame.origin.y + itemTypeTopLabel.frame.size.height + (self.view.frame.size.height*0.0108695 > 8?(8):self.view.frame.size.height*0.0108695), (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    editingView.frame = CGRectMake(textFieldSpacing, addingView.frame.origin.y + addingView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    deletingView.frame = CGRectMake(textFieldSpacing, editingView.frame.origin.y + editingView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    duplicatingView.frame = CGRectMake(textFieldSpacing, deletingView.frame.origin.y + deletingView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    waivingsView.frame = CGRectMake(textFieldSpacing, duplicatingView.frame.origin.y + duplicatingView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    skippingsView.frame = CGRectMake(textFieldSpacing, waivingsView.frame.origin.y + waivingsView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    pauseUnpauseView.frame = CGRectMake(textFieldSpacing, skippingsView.frame.origin.y + skippingsView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    commentsView.frame = CGRectMake(textFieldSpacing, pauseUnpauseView.frame.origin.y + pauseUnpauseView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    markingTopLabel.frame = CGRectMake(textFieldSpacing + (self.view.frame.size.width*0.02415 > 10?(10):self.view.frame.size.width*0.02415), commentsView.frame.origin.y + commentsView.frame.size.height + (self.view.frame.size.height*0.0407 > 30?(30):self.view.frame.size.height*0.0407), width, (self.view.frame.size.height*0.01902174 > 14?(14):self.view.frame.size.height*0.01902174));
    
    fullyCompletedView.frame = CGRectMake(textFieldSpacing, markingTopLabel.frame.origin.y + markingTopLabel.frame.size.height + (self.view.frame.size.height*0.0108695 > 8?(8):self.view.frame.size.height*0.0108695), (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    completedView.frame = CGRectMake(textFieldSpacing, fullyCompletedView.frame.origin.y + fullyCompletedView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    inProgressView.frame = CGRectMake(textFieldSpacing, completedView.frame.origin.y + completedView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    wontDoView.frame = CGRectMake(textFieldSpacing, inProgressView.frame.origin.y + inProgressView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    acceptView.frame = CGRectMake(textFieldSpacing, wontDoView.frame.origin.y + wontDoView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    declineView.frame = CGRectMake(textFieldSpacing, acceptView.frame.origin.y + acceptView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    remindersTopLabel.frame = CGRectMake(textFieldSpacing + (self.view.frame.size.width*0.02415 > 10?(10):self.view.frame.size.width*0.02415), declineView.frame.origin.y + declineView.frame.size.height + (self.view.frame.size.height*0.0407 > 30?(30):self.view.frame.size.height*0.0407), width, (self.view.frame.size.height*0.01902174 > 14?(14):self.view.frame.size.height*0.01902174));
    
    dueDateView.frame = CGRectMake(textFieldSpacing, remindersTopLabel.frame.origin.y + remindersTopLabel.frame.size.height + (self.view.frame.size.height*0.0108695 > 8?(8):self.view.frame.size.height*0.0108695), (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    reminderView.frame = CGRectMake(textFieldSpacing, dueDateView.frame.origin.y + dueDateView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    listItemsTopLabel.frame = CGRectMake(textFieldSpacing + (self.view.frame.size.width*0.02415 > 10?(10):self.view.frame.size.width*0.02415), reminderView.frame.origin.y + reminderView.frame.size.height + (self.view.frame.size.height*0.0407 > 30?(30):self.view.frame.size.height*0.0407), width, (self.view.frame.size.height*0.01902174 > 14?(14):self.view.frame.size.height*0.01902174));
    
    addListItemView.frame = CGRectMake(textFieldSpacing, listItemsTopLabel.frame.origin.y + listItemsTopLabel.frame.size.height + (self.view.frame.size.height*0.0108695 > 8?(8):self.view.frame.size.height*0.0108695), (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    editListItemView.frame = CGRectMake(textFieldSpacing, addListItemView.frame.origin.y + addListItemView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    deleteListItemView.frame = CGRectMake(textFieldSpacing, editListItemView.frame.origin.y + editListItemView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    CGFloat maxHeight = self.view.frame.size.height + 1;
    
    CGFloat heightToUse = deleteListItemView.frame.origin.y + deleteListItemView.frame.size.height + (height*0.01086957) < maxHeight ? maxHeight : deleteListItemView.frame.origin.y + deleteListItemView.frame.size.height + (height*0.01086957);
    
    _customScrollView.contentSize = CGSizeMake(0, heightToUse);
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    [self.customScrollView addSubview:itemTypeTopLabel];
    [self.customScrollView addSubview:markingTopLabel];
    [self.customScrollView addSubview:remindersTopLabel];
    [self.customScrollView addSubview:listItemsTopLabel];
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    [self.customScrollView addSubview:addingView];
    [addingView addSubview:addingLabel];
    [addingView addSubview:addingSwitch];
    
    [self.customScrollView addSubview:editingView];
    [editingView addSubview:editingLabel];
    [editingView addSubview:editingSwitch];
    
    [self.customScrollView addSubview:deletingView];
    [deletingView addSubview:deletingLabel];
    [deletingView addSubview:deletingSwitch];
    
    [self.customScrollView addSubview:duplicatingView];
    [duplicatingView addSubview:duplicatingLabel];
    [duplicatingView addSubview:duplicatingSwitch];
    
    [self.customScrollView addSubview:waivingsView];
    [waivingsView addSubview:waivingLabel];
    [waivingsView addSubview:waivingSwitch];
    
    [self.customScrollView addSubview:skippingsView];
    [skippingsView addSubview:skippingLabel];
    [skippingsView addSubview:skippingSwitch];
    
    [self.customScrollView addSubview:pauseUnpauseView];
    [pauseUnpauseView addSubview:pauseUnpauseLabel];
    [pauseUnpauseView addSubview:pauseUnpauseSwitch];
    
    [self.customScrollView addSubview:commentsView];
    [commentsView addSubview:commentsLabel];
    [commentsView addSubview:commentsSwitch];
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    [self.customScrollView addSubview:fullyCompletedView];
    [fullyCompletedView addSubview:fullyCompletedLabel];
    [fullyCompletedView addSubview:fullyCompletedSwitch];
    
    [self.customScrollView addSubview:completedView];
    [completedView addSubview:subLabel];
    [completedView addSubview:completedSwitch];
    
    [self.customScrollView addSubview:inProgressView];
    [inProgressView addSubview:inProgressLabel];
    [inProgressView addSubview:inProgressSwitch];
    
    [self.customScrollView addSubview:wontDoView];
    [wontDoView addSubview:wontDoLabel];
    [wontDoView addSubview:wontDoSwitch];
    
    [self.customScrollView addSubview:acceptView];
    [acceptView addSubview:acceptLabel];
    [acceptView addSubview:acceptSwitch];
    
    [self.customScrollView addSubview:declineView];
    [declineView addSubview:declineLabel];
    [declineView addSubview:declineSwitch];
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    [self.customScrollView addSubview:dueDateView];
    [dueDateView addSubview:dueDateLabel];
    [dueDateView addSubview:dueDateSwitch];
    
    [self.customScrollView addSubview:reminderView];
    [reminderView addSubview:reminderLabel];
    [reminderView addSubview:reminderSwitch];
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    [self.customScrollView addSubview:addListItemView];
    [addListItemView addSubview:addListItemLabel];
    [addListItemView addSubview:addListItemSwitch];
    
    [self.customScrollView addSubview:editListItemView];
    [editListItemView addSubview:editListItemLabel];
    [editListItemView addSubview:editListItemSwitch];
    
    [self.customScrollView addSubview:deleteListItemView];
    [deleteListItemView addSubview:deleteListItemLabel];
    [deleteListItemView addSubview:deleteListItemSwitch];
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    [self SetUpCorners:@[
        
        @{@"TopView" : addingView, @"BottomView" : commentsView},
        @{@"TopView" : fullyCompletedView, @"BottomView" : declineView},
        @{@"TopView" : dueDateView, @"BottomView" : reminderView},
        @{@"TopView" : addListItemView, @"BottomView" : deleteListItemView},
        
    ]];
    
    [self SetUpViewBackgroundColor:@[
        
        @{@"View" : addingView},
        @{@"View" : editingView},
        @{@"View" : deletingView},
        @{@"View" : duplicatingView},
        @{@"View" : waivingsView},
        @{@"View" : skippingsView},
        @{@"View" : pauseUnpauseView},
        @{@"View" : commentsView},
        
        @{@"View" : fullyCompletedView},
        @{@"View" : completedView},
        @{@"View" : inProgressView},
        @{@"View" : wontDoView},
        @{@"View" : acceptView},
        @{@"View" : declineView},
        
        @{@"View" : dueDateView},
        @{@"View" : reminderView},
        
        @{@"View" : addListItemView},
        @{@"View" : editListItemView},
        @{@"View" : deleteListItemView},
        
    ]];
    
    [self SetUpBottomLineViews:@[
        
        @{@"View" : addingView},
        @{@"View" : editingView},
        @{@"View" : deletingView},
        @{@"View" : duplicatingView},
        @{@"View" : waivingsView},
        @{@"View" : skippingsView},
        @{@"View" : pauseUnpauseView},
        @{@"View" : commentsView},
        
        @{@"View" : fullyCompletedView},
        @{@"View" : completedView},
        @{@"View" : inProgressView},
        @{@"View" : wontDoView},
        @{@"View" : acceptView},
        @{@"View" : declineView},
        
        @{@"View" : dueDateView},
        @{@"View" : reminderView},
        
        @{@"View" : addListItemView},
        @{@"View" : editListItemView},
        @{@"View" : deleteListItemView},
        
    ]];
    
    [self SetUpTopLabelUI:@[
        
        @{@"Label" : itemTypeTopLabel, @"Text" : @"LISTS"},
        @{@"Label" : markingTopLabel, @"Text" : @"MARKING"},
        @{@"Label" : remindersTopLabel, @"Text" : @"REMINDERS"},
        @{@"Label" : listItemsTopLabel, @"Text" : @"LIST ITEM"},
        
    ]];
    
    [self SetUpLabelFontSize:@[
        
        @{@"Label" : addingLabel},
        @{@"Label" : editingLabel},
        @{@"Label" : deletingLabel},
        @{@"Label" : duplicatingLabel},
        @{@"Label" : waivingLabel},
        @{@"Label" : skippingLabel},
        @{@"Label" : pauseUnpauseLabel},
        @{@"Label" : commentsLabel},
        
        @{@"Label" : fullyCompletedLabel},
        @{@"Label" : subLabel},
        @{@"Label" : inProgressLabel},
        @{@"Label" : wontDoLabel},
        @{@"Label" : acceptLabel},
        @{@"Label" : declineLabel},
        
        @{@"Label" : dueDateLabel},
        @{@"Label" : reminderLabel},
        
        @{@"Label" : addListItemLabel},
        @{@"Label" : editListItemLabel},
        @{@"Label" : deleteListItemLabel},
        
    ]];
    
    [self SetUpLabelWithoutImage:@[
        
        @{@"Label" : addingLabel, @"Width" : @"0.75"},
        @{@"Label" : editingLabel, @"Width" : @"0.75"},
        @{@"Label" : deletingLabel, @"Width" : @"0.75"},
        @{@"Label" : duplicatingLabel, @"Width" : @"0.75"},
        @{@"Label" : waivingLabel, @"Width" : @"0.75"},
        @{@"Label" : skippingLabel, @"Width" : @"0.75"},
        @{@"Label" : pauseUnpauseLabel, @"Width" : @"0.75"},
        @{@"Label" : commentsLabel, @"Width" : @"0.75"},
        
        @{@"Label" : fullyCompletedLabel, @"Width" : @"0.75"},
        @{@"Label" : subLabel, @"Width" : @"0.75"},
        @{@"Label" : inProgressLabel, @"Width" : @"0.75"},
        @{@"Label" : wontDoLabel, @"Width" : @"0.75"},
        @{@"Label" : acceptLabel, @"Width" : @"0.75"},
        @{@"Label" : declineLabel, @"Width" : @"0.75"},
        
        @{@"Label" : dueDateLabel, @"Width" : @"0.75"},
        @{@"Label" : reminderLabel, @"Width" : @"0.75"},
        
        @{@"Label" : addListItemLabel, @"Width" : @"0.75"},
        @{@"Label" : editListItemLabel, @"Width" : @"0.75"},
        @{@"Label" : deleteListItemLabel, @"Width" : @"0.75"},
        
    ]];
    
    dispatch_once(&onceToken, ^{
        
        [self SetUpControlSwitchFrame:@[
            
            @{@"Switch" : addingSwitch},
            @{@"Switch" : editingSwitch},
            @{@"Switch" : deletingSwitch},
            @{@"Switch" : duplicatingSwitch},
            @{@"Switch" : waivingSwitch},
            @{@"Switch" : skippingSwitch},
            @{@"Switch" : pauseUnpauseSwitch},
            @{@"Switch" : commentsSwitch},
            
            @{@"Switch" : fullyCompletedSwitch},
            @{@"Switch" : completedSwitch},
            @{@"Switch" : inProgressSwitch},
            @{@"Switch" : wontDoSwitch},
            @{@"Switch" : acceptSwitch},
            @{@"Switch" : declineSwitch},
            
            @{@"Switch" : dueDateSwitch},
            @{@"Switch" : reminderSwitch},
            
            @{@"Switch" : addListItemSwitch},
            @{@"Switch" : editListItemSwitch},
            @{@"Switch" : deleteListItemSwitch},
            
        ]];
        
    });
    
    [self SetUpSwitchTags:@[
        
        @{@"Switch" : addingSwitch},
        @{@"Switch" : editingSwitch},
        @{@"Switch" : deletingSwitch},
        @{@"Switch" : duplicatingSwitch},
        @{@"Switch" : waivingSwitch},
        @{@"Switch" : skippingSwitch},
        @{@"Switch" : pauseUnpauseSwitch},
        @{@"Switch" : commentsSwitch},
        
        @{@"Switch" : fullyCompletedSwitch},
        @{@"Switch" : completedSwitch},
        @{@"Switch" : inProgressSwitch},
        @{@"Switch" : wontDoSwitch},
        @{@"Switch" : acceptSwitch},
        @{@"Switch" : declineSwitch},
        
        @{@"Switch" : dueDateSwitch},
        @{@"Switch" : reminderSwitch},
        
        @{@"Switch" : addListItemSwitch},
        @{@"Switch" : editListItemSwitch},
        @{@"Switch" : deleteListItemSwitch},
        
    ]];
    
    [self SetUpSwitchStatus:@[
        
        @{@"Switch" : addingSwitch, @"Key" : @"Adding"},
        @{@"Switch" : editingSwitch, @"Key" : @"Editing"},
        @{@"Switch" : deletingSwitch, @"Key" : @"Deleting"},
        @{@"Switch" : duplicatingSwitch, @"Key" : @"Duplicating"},
        @{@"Switch" : waivingSwitch, @"Key" : @"Waiving"},
        @{@"Switch" : skippingSwitch, @"Key" : @"Skipping"},
        @{@"Switch" : pauseUnpauseSwitch, @"Key" : @"Pause/Unpause"},
        @{@"Switch" : commentsSwitch, @"Key" : @"Comments"},
        
        @{@"Switch" : fullyCompletedSwitch, @"Key" : @"FullyCompleted"},
        @{@"Switch" : completedSwitch, @"Key" : @"Completed"},
        @{@"Switch" : inProgressSwitch, @"Key" : @"InProgress"},
        @{@"Switch" : wontDoSwitch, @"Key" : @"WontDo"},
        @{@"Switch" : acceptSwitch, @"Key" : @"Accept"},
        @{@"Switch" : declineSwitch, @"Key" : @"Decline"},
        
        @{@"Switch" : dueDateSwitch, @"Key" : @"DueDate"},
        @{@"Switch" : reminderSwitch, @"Key" : @"Reminder"},
        
        @{@"Switch" : addListItemSwitch, @"Key" : @"AddingListItem"},
        @{@"Switch" : editListItemSwitch, @"Key" : @"EditingListItem"},
        @{@"Switch" : deleteListItemSwitch, @"Key" : @"DeletingListItem"},
        
    ] itemType:@"Lists" selector:@selector(ListOptionsSwitch:)];
    
}

-(void)GroupChatsSetup {
    
    itemTypeTopLabel = [[UILabel alloc] init];
    messagesTopLabel = [[UILabel alloc] init];
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    addingView = [[UIView alloc] init];
    addingLabel = [[UILabel alloc] init];
    addingSwitch = [[UISwitch alloc] init];
    
    editingView = [[UIView alloc] init];
    editingLabel = [[UILabel alloc] init];
    editingSwitch = [[UISwitch alloc] init];
    
    deletingView = [[UIView alloc] init];
    deletingLabel = [[UILabel alloc] init];
    deletingSwitch = [[UISwitch alloc] init];
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    groupChatMessagesView = [[UIView alloc] init];
    groupChatMessagesLabel = [[UILabel alloc] init];
    groupChatMessagesSwitch = [[UISwitch alloc] init];
    
    liveSupportMessagesView = [[UIView alloc] init];
    liveSupportMessagesLabel = [[UILabel alloc] init];
    liveSupportMessagesSwitch = [[UISwitch alloc] init];
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    itemTypeTopLabel.text = @"GROUP CHATS";
    itemTypeTopLabel.textColor = [UIColor colorWithRed:168.0f/255.0f green:167.0f/255.0f blue:172.0f/255.0f alpha:1.0f];
    itemTypeTopLabel.font = [UIFont systemFontOfSize:(self.view.frame.size.height*0.017663 > 13?(13):self.view.frame.size.height*0.017663) weight:UIFontWeightMedium];
    
    messagesTopLabel.text = @"MESSAGES";
    messagesTopLabel.textColor = [UIColor colorWithRed:168.0f/255.0f green:167.0f/255.0f blue:172.0f/255.0f alpha:1.0f];
    messagesTopLabel.font = [UIFont systemFontOfSize:(self.view.frame.size.height*0.017663 > 13?(13):self.view.frame.size.height*0.017663) weight:UIFontWeightMedium];
    
    addingLabel.text = @"Adding";
    editingLabel.text = @"Editing";
    deletingLabel.text = @"Deleting";
    
    groupChatMessagesLabel.text = @"Group Chat Messages";
    liveSupportMessagesLabel.text = @"Live Support Messages";
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    CGFloat textFieldSpacing = (height*0.024456);
    
    itemTypeTopLabel.frame = CGRectMake(textFieldSpacing + (self.view.frame.size.width*0.02415 > 10?(10):self.view.frame.size.width*0.02415), (self.view.frame.size.height*0.0407 > 30?(30):self.view.frame.size.height*0.0407), width, (self.view.frame.size.height*0.01902174 > 14?(14):self.view.frame.size.height*0.01902174));
    
    addingView.frame = CGRectMake(textFieldSpacing, itemTypeTopLabel.frame.origin.y + itemTypeTopLabel.frame.size.height + (self.view.frame.size.height*0.0108695 > 8?(8):self.view.frame.size.height*0.0108695), (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    editingView.frame = CGRectMake(textFieldSpacing, addingView.frame.origin.y + addingView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    deletingView.frame = CGRectMake(textFieldSpacing, editingView.frame.origin.y + editingView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    
    messagesTopLabel.frame = CGRectMake(textFieldSpacing + (self.view.frame.size.width*0.02415 > 10?(10):self.view.frame.size.width*0.02415), deletingView.frame.origin.y + deletingView.frame.size.height + (self.view.frame.size.height*0.0407 > 30?(30):self.view.frame.size.height*0.0407), width, (self.view.frame.size.height*0.01902174 > 14?(14):self.view.frame.size.height*0.01902174));
    
    groupChatMessagesView.frame = CGRectMake(textFieldSpacing, messagesTopLabel.frame.origin.y + messagesTopLabel.frame.size.height + (self.view.frame.size.height*0.0108695 > 8?(8):self.view.frame.size.height*0.0108695), (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    liveSupportMessagesView.frame = CGRectMake(textFieldSpacing, groupChatMessagesView.frame.origin.y + groupChatMessagesView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    
    CGFloat maxHeight = self.view.frame.size.height + 1;
    
    CGFloat heightToUse = liveSupportMessagesView.frame.origin.y + liveSupportMessagesView.frame.size.height + (height*0.01086957) < maxHeight ? maxHeight : liveSupportMessagesView.frame.origin.y + liveSupportMessagesView.frame.size.height + (height*0.01086957);
    
    _customScrollView.contentSize = CGSizeMake(0, heightToUse);
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    [self.customScrollView addSubview:itemTypeTopLabel];
    [self.customScrollView addSubview:messagesTopLabel];
    
    [self.customScrollView addSubview:addingView];
    [addingView addSubview:addingLabel];
    [addingView addSubview:addingSwitch];
    
    [self.customScrollView addSubview:editingView];
    [editingView addSubview:editingLabel];
    [editingView addSubview:editingSwitch];
    
    [self.customScrollView addSubview:deletingView];
    [deletingView addSubview:deletingLabel];
    [deletingView addSubview:deletingSwitch];
    
    [self.customScrollView addSubview:groupChatMessagesView];
    [groupChatMessagesView addSubview:groupChatMessagesLabel];
    [groupChatMessagesView addSubview:groupChatMessagesSwitch];
    
    [self.customScrollView addSubview:liveSupportMessagesView];
    [liveSupportMessagesView addSubview:liveSupportMessagesLabel];
    [liveSupportMessagesView addSubview:liveSupportMessagesSwitch];
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    [self SetUpCorners:@[
        
        @{@"TopView" : addingView, @"BottomView" : deletingView},
        @{@"TopView" : groupChatMessagesView, @"BottomView" : liveSupportMessagesView},
        
    ]];
    
    [self SetUpViewBackgroundColor:@[
        
        @{@"View" : addingView},
        @{@"View" : editingView},
        @{@"View" : deletingView},
        
        @{@"View" : groupChatMessagesView},
        @{@"View" : liveSupportMessagesView},
        
    ]];
    
    [self SetUpBottomLineViews:@[
        
        @{@"View" : addingView},
        @{@"View" : editingView},
        @{@"View" : deletingView},
        
        @{@"View" : groupChatMessagesView},
        @{@"View" : liveSupportMessagesView},
        
    ]];
    
    [self SetUpTopLabelUI:@[
        
        @{@"Label" : itemTypeTopLabel, @"Text" : @"GROUP CHATS"},
        @{@"Label" : messagesTopLabel, @"Text" : @"MESSAGES"},
        
    ]];
    
    [self SetUpLabelFontSize:@[
        
        @{@"Label" : addingLabel},
        @{@"Label" : editingLabel},
        @{@"Label" : deletingLabel},
        
        @{@"Label" : groupChatMessagesLabel},
        @{@"Label" : liveSupportMessagesLabel},
        
    ]];
    
    [self SetUpLabelWithoutImage:@[
        
        @{@"Label" : addingLabel, @"Width" : @"0.75"},
        @{@"Label" : editingLabel, @"Width" : @"0.75"},
        @{@"Label" : deletingLabel, @"Width" : @"0.75"},
        
        @{@"Label" : groupChatMessagesLabel, @"Width" : @"0.75"},
        @{@"Label" : liveSupportMessagesLabel, @"Width" : @"0.75"},
        
    ]];
    
    dispatch_once(&onceToken, ^{
        
        [self SetUpControlSwitchFrame:@[
            
            @{@"Switch" : addingSwitch},
            @{@"Switch" : editingSwitch},
            @{@"Switch" : deletingSwitch},
            
            @{@"Switch" : groupChatMessagesSwitch},
            @{@"Switch" : liveSupportMessagesSwitch},
            
        ]];
        
    });
    
    [self SetUpSwitchTags:@[
        
        @{@"Switch" : addingSwitch},
        @{@"Switch" : editingSwitch},
        @{@"Switch" : deletingSwitch},
        
        @{@"Switch" : groupChatMessagesSwitch},
        @{@"Switch" : liveSupportMessagesSwitch},
        
    ]];
    
    [self SetUpSwitchStatus:@[
        
        @{@"Switch" : addingSwitch, @"Key" : @"Adding"},
        @{@"Switch" : editingSwitch, @"Key" : @"Editing"},
        @{@"Switch" : deletingSwitch, @"Key" : @"Deleting"},
        
        @{@"Switch" : groupChatMessagesSwitch, @"Key" : @"GroupChatMessages"},
        @{@"Switch" : liveSupportMessagesSwitch, @"Key" : @"LiveSupportMessages"},
        
    ] itemType:@"GroupChats" selector:@selector(GroupChatOptionsSwitch:)];
    
}

#pragma mark

-(void)HomeMembersSetup {
    
    invitationsTopLabel = [[UILabel alloc] init];
    homeMembersTopLabel = [[UILabel alloc] init];
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    sendingInvitationsView = [[UIView alloc] init];
    sendingInvitationsLabel = [[UILabel alloc] init];
    sendingInvitationsSwitch = [[UISwitch alloc] init];
    
    deletingInvitationsView = [[UIView alloc] init];
    deletingInvitationsLabel = [[UILabel alloc] init];
    deletingInvitationsSwitch = [[UISwitch alloc] init];
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    newHomeMembersView = [[UIView alloc] init];
    newHomeMembersLabel = [[UILabel alloc] init];
    newHomeMembersSwitch = [[UISwitch alloc] init];
    
    movedOutHomeMembersView = [[UIView alloc] init];
    movedOutHomeMembersLabel = [[UILabel alloc] init];
    movedOutHomeMembersSwitch = [[UISwitch alloc] init];
    
    kickingOutHomeMembersView = [[UIView alloc] init];
    kickingOutHomeMembersLabel = [[UILabel alloc] init];
    kickingOutHomeMembersSwitch = [[UISwitch alloc] init];
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    sendingInvitationsLabel.text = @"Sending Invitations";
    deletingInvitationsLabel.text = @"Deleting Invitations";
    
    newHomeMembersLabel.text = @"New Home Members";
    movedOutHomeMembersLabel.text = @"Home Members Moved Out";
    kickingOutHomeMembersLabel.text = @"Home Members Kicked Out";
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    CGFloat textFieldSpacing = (height*0.024456);
    
    invitationsTopLabel.frame = CGRectMake(textFieldSpacing + (self.view.frame.size.width*0.02415 > 10?(10):self.view.frame.size.width*0.02415), (self.view.frame.size.height*0.0407 > 30?(30):self.view.frame.size.height*0.0407), width, (self.view.frame.size.height*0.01902174 > 14?(14):self.view.frame.size.height*0.01902174));
    
    sendingInvitationsView.frame = CGRectMake(textFieldSpacing, invitationsTopLabel.frame.origin.y + invitationsTopLabel.frame.size.height + (self.view.frame.size.height*0.0108695 > 8?(8):self.view.frame.size.height*0.0108695), (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    deletingInvitationsView.frame = CGRectMake(textFieldSpacing, sendingInvitationsView.frame.origin.y + sendingInvitationsView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    
    homeMembersTopLabel.frame = CGRectMake(textFieldSpacing + (self.view.frame.size.width*0.02415 > 10?(10):self.view.frame.size.width*0.02415), deletingInvitationsView.frame.origin.y + deletingInvitationsView.frame.size.height + (self.view.frame.size.height*0.0407 > 30?(30):self.view.frame.size.height*0.0407), width, (self.view.frame.size.height*0.01902174 > 14?(14):self.view.frame.size.height*0.01902174));
    
    newHomeMembersView.frame = CGRectMake(textFieldSpacing, homeMembersTopLabel.frame.origin.y + homeMembersTopLabel.frame.size.height + (self.view.frame.size.height*0.0108695 > 8?(8):self.view.frame.size.height*0.0108695), (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    movedOutHomeMembersView.frame = CGRectMake(textFieldSpacing, newHomeMembersView.frame.origin.y + newHomeMembersView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    kickingOutHomeMembersView.frame = CGRectMake(textFieldSpacing, movedOutHomeMembersView.frame.origin.y + movedOutHomeMembersView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    
    CGFloat maxHeight = self.view.frame.size.height + 1;
    
    CGFloat heightToUse = kickingOutHomeMembersView.frame.origin.y + kickingOutHomeMembersView.frame.size.height + (height*0.01086957) < maxHeight ? maxHeight : kickingOutHomeMembersView.frame.origin.y + kickingOutHomeMembersView.frame.size.height + (height*0.01086957);
    
    _customScrollView.contentSize = CGSizeMake(0, heightToUse);
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    [self.customScrollView addSubview:invitationsTopLabel];
    [self.customScrollView addSubview:homeMembersTopLabel];
    
    [self.customScrollView addSubview:sendingInvitationsView];
    [sendingInvitationsView addSubview:sendingInvitationsLabel];
    [sendingInvitationsView addSubview:sendingInvitationsSwitch];
    
    [self.customScrollView addSubview:deletingInvitationsView];
    [deletingInvitationsView addSubview:deletingInvitationsLabel];
    [deletingInvitationsView addSubview:deletingInvitationsSwitch];
    
    [self.customScrollView addSubview:newHomeMembersView];
    [newHomeMembersView addSubview:newHomeMembersLabel];
    [newHomeMembersView addSubview:newHomeMembersSwitch];
    
    [self.customScrollView addSubview:movedOutHomeMembersView];
    [movedOutHomeMembersView addSubview:movedOutHomeMembersLabel];
    [movedOutHomeMembersView addSubview:movedOutHomeMembersSwitch];
    
    [self.customScrollView addSubview:kickingOutHomeMembersView];
    [kickingOutHomeMembersView addSubview:kickingOutHomeMembersLabel];
    [kickingOutHomeMembersView addSubview:kickingOutHomeMembersSwitch];
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    [self SetUpCorners:@[
        
        @{@"TopView" : sendingInvitationsView, @"BottomView" : deletingInvitationsView},
        @{@"TopView" : newHomeMembersView, @"BottomView" : kickingOutHomeMembersView},
        
    ]];
    
    [self SetUpViewBackgroundColor:@[
        
        @{@"View" : sendingInvitationsView},
        @{@"View" : deletingInvitationsView},
        
        @{@"View" : newHomeMembersView},
        @{@"View" : movedOutHomeMembersView},
        @{@"View" : kickingOutHomeMembersView},
        
    ]];
    
    [self SetUpBottomLineViews:@[
        
        @{@"View" : sendingInvitationsView},
        @{@"View" : deletingInvitationsView},
        
        @{@"View" : newHomeMembersView},
        @{@"View" : movedOutHomeMembersView},
        @{@"View" : kickingOutHomeMembersView},
        
    ]];
    
    [self SetUpTopLabelUI:@[
        
        @{@"Label" : invitationsTopLabel, @"Text" : @"INVITATIONS"},
        @{@"Label" : homeMembersTopLabel, @"Text" : @"HOME MEMBERS"}
        
    ]];
    
    [self SetUpLabelFontSize:@[
        
        @{@"Label" : sendingInvitationsLabel},
        @{@"Label" : deletingInvitationsLabel},
        
        @{@"Label" : newHomeMembersLabel},
        @{@"Label" : movedOutHomeMembersLabel},
        @{@"Label" : kickingOutHomeMembersLabel},
        
    ]];
    
    [self SetUpLabelWithoutImage:@[
        
        @{@"Label" : sendingInvitationsLabel, @"Width" : @"0.75"},
        @{@"Label" : deletingInvitationsLabel, @"Width" : @"0.75"},
        
        @{@"Label" : newHomeMembersLabel, @"Width" : @"0.75"},
        @{@"Label" : movedOutHomeMembersLabel, @"Width" : @"0.75"},
        @{@"Label" : kickingOutHomeMembersLabel, @"Width" : @"0.75"},
        
    ]];
    
    dispatch_once(&onceToken, ^{
        
        [self SetUpControlSwitchFrame:@[
            
            @{@"Switch" : sendingInvitationsSwitch},
            @{@"Switch" : deletingInvitationsSwitch},
            
            @{@"Switch" : newHomeMembersSwitch},
            @{@"Switch" : movedOutHomeMembersSwitch},
            @{@"Switch" : kickingOutHomeMembersSwitch},
            
        ]];
        
    });
    
    [self SetUpSwitchTags:@[
        
        @{@"Switch" : sendingInvitationsSwitch},
        @{@"Switch" : deletingInvitationsSwitch},
        
        @{@"Switch" : newHomeMembersSwitch},
        @{@"Switch" : movedOutHomeMembersSwitch},
        @{@"Switch" : kickingOutHomeMembersSwitch},
        
    ]];
    
    [self SetUpSwitchStatus:@[
        
        @{@"Switch" : sendingInvitationsSwitch, @"Key" : @"SendingInvitations"},
        @{@"Switch" : deletingInvitationsSwitch, @"Key" : @"DeletingInvitations"},
        
        @{@"Switch" : newHomeMembersSwitch, @"Key" : @"NewHomeMembers"},
        @{@"Switch" : movedOutHomeMembersSwitch, @"Key" : @"HomeMembersMovedOut"},
        @{@"Switch" : kickingOutHomeMembersSwitch, @"Key" : @"HomeMembersKickedOut"},
        
    ] itemType:@"HomeMembers" selector:@selector(HomeMembersOptionsSwitch:)];
    
}

-(void)ForumSetup {
    
    upvotesTopLabel = [[UILabel alloc] init];
    
    featureForumUpvoteView = [[UIView alloc] init];
    featureForumUpvoteLabel = [[UILabel alloc] init];
    featureForumUpvoteSwitch = [[UISwitch alloc] init];
    
    bugForumUpvoteView = [[UIView alloc] init];
    bugForumUpvoteLabel = [[UILabel alloc] init];
    bugForumUpvoteSwitch = [[UISwitch alloc] init];
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    featureForumUpvoteLabel.text = @"Feature Forum Post Upvotes";
    bugForumUpvoteLabel.text = @"Bug Forum Post Upvotes";
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    CGFloat textFieldSpacing = (height*0.024456);
    
    upvotesTopLabel.frame = CGRectMake(textFieldSpacing + (self.view.frame.size.width*0.02415 > 10?(10):self.view.frame.size.width*0.02415), (self.view.frame.size.height*0.0407 > 30?(30):self.view.frame.size.height*0.0407), width, (self.view.frame.size.height*0.01902174 > 14?(14):self.view.frame.size.height*0.01902174));
    
    bugForumUpvoteView.frame = CGRectMake(textFieldSpacing, upvotesTopLabel.frame.origin.y + upvotesTopLabel.frame.size.height + (self.view.frame.size.height*0.0108695 > 8?(8):self.view.frame.size.height*0.0108695), (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    featureForumUpvoteView.frame = CGRectMake(textFieldSpacing, bugForumUpvoteView.frame.origin.y + bugForumUpvoteView.frame.size.height, (width*1 - (textFieldSpacing*2)), (height*0.0679 > 50?(50):height*0.0679));
    
    CGFloat maxHeight = self.view.frame.size.height + 1;
    
    CGFloat heightToUse = bugForumUpvoteView.frame.origin.y + bugForumUpvoteView.frame.size.height + (height*0.01086957) < maxHeight ? maxHeight : bugForumUpvoteView.frame.origin.y + bugForumUpvoteView.frame.size.height + (height*0.01086957);
    
    _customScrollView.contentSize = CGSizeMake(0, heightToUse);
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    [self.customScrollView addSubview:upvotesTopLabel];
    
    [self.customScrollView addSubview:bugForumUpvoteView];
    [bugForumUpvoteView addSubview:bugForumUpvoteLabel];
    [bugForumUpvoteView addSubview:bugForumUpvoteSwitch];
    
    [self.customScrollView addSubview:featureForumUpvoteView];
    [featureForumUpvoteView addSubview:featureForumUpvoteLabel];
    [featureForumUpvoteView addSubview:featureForumUpvoteSwitch];
    
    /*\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\*/
    
    [self SetUpCorners:@[
        
        @{@"TopView" : bugForumUpvoteView, @"BottomView" : featureForumUpvoteView},
        
    ]];
    
    [self SetUpViewBackgroundColor:@[
        
        @{@"View" : bugForumUpvoteView},
        @{@"View" : featureForumUpvoteView},
        
    ]];
    
    [self SetUpBottomLineViews:@[
        
        @{@"View" : bugForumUpvoteView},
        @{@"View" : featureForumUpvoteView},
        
    ]];
    
    [self SetUpTopLabelUI:@[
        
        @{@"Label" : upvotesTopLabel, @"Text" : @"UPVOTES"},
        
    ]];
    
    [self SetUpLabelFontSize:@[
        
        @{@"Label" : bugForumUpvoteLabel},
        @{@"Label" : featureForumUpvoteLabel},
        
    ]];
    
    [self SetUpLabelWithoutImage:@[
        
        @{@"Label" : bugForumUpvoteLabel, @"Width" : @"0.75"},
        @{@"Label" : featureForumUpvoteLabel, @"Width" : @"0.75"},
        
    ]];
    
    dispatch_once(&onceToken, ^{
        
        [self SetUpControlSwitchFrame:@[
            
            @{@"Switch" : bugForumUpvoteSwitch},
            @{@"Switch" : featureForumUpvoteSwitch},
            
        ]];
        
    });
    
    [self SetUpSwitchTags:@[
        
        @{@"Switch" : bugForumUpvoteSwitch},
        @{@"Switch" : featureForumUpvoteSwitch},
        
    ]];
    
    [self SetUpSwitchStatus:@[
        
        @{@"Switch" : bugForumUpvoteSwitch, @"Key" : @"BugForumUpvotes"},
        @{@"Switch" : featureForumUpvoteSwitch, @"Key" : @"FeatureForumUpvotes"},
        
    ] itemType:@"Forum" selector:@selector(ForumOptionsSwitch:)];
    
}

#pragma mark
#pragma mark
#pragma mark

#pragma mark - IBAction Methods Navigation Bar
#pragma mark
#pragma mark

-(IBAction)SaveAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Save Button Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
//    [self StartProgressView];
    
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userID == %@", userID];
    [[[SetDataObject alloc] init] SetDataEditCoreData:@"NotificationSettings" predicate:predicate setDataObject:_notificationSettings];
    
    NSMutableDictionary *dict = self->_notificationSettings ? self->_notificationSettings : [NSMutableDictionary dictionary];
  
    [[[GeneralObject alloc] init] CallNSNotificationMethods:@"NotificationSettings" userInfo:@{@"NotificationSettings" : dict} locations:@[@"Tasks", @"Settings", @"NotificationSettings"]];
   
    [self dismissViewControllerAnimated:YES completion:nil];
    

    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
        [[[SetDataObject alloc] init] UpdateDataNotificationSettings:userID dataDict:self->_notificationSettings completionHandler:^(BOOL finished, NSError * _Nonnull error) {
            
        }];
        
    });
    
}

-(IBAction)NavigationBackButtonAction:(UIBarButtonItem *)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Navigation Back Button Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark
#pragma mark
#pragma mark

#pragma mark - IBAction Methods Main View
#pragma mark
#pragma mark

-(IBAction)AllowNotificationSwitchAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Allow Notifications Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    NSMutableDictionary *dict = _notificationSettings ? [_notificationSettings mutableCopy] : [NSMutableDictionary dictionary];
    [dict setObject:[allowNotificationsSwitch isOn] ? @"Yes" : @"No" forKey:@"AllowNotifications"];
    _notificationSettings = [dict mutableCopy];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        [self MainViewSetup:NO];
        
    }];
    
}

#pragma mark

-(IBAction)DayOfTheWeekTapGesture:(id)sender {
    
    UITapGestureRecognizer *tapRecognizer = (UITapGestureRecognizer *)sender;
    NSInteger tag = [tapRecognizer.view tag];
    
    NSMutableDictionary *dict = _notificationSettings ? [_notificationSettings mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableArray *daysOfTheWeekArray = dict[@"DaysOfTheWeek"] ? [dict[@"DaysOfTheWeek"] mutableCopy] : [NSMutableArray array];
    
    UIView *viewToUse;
    UILabel *labelToUse;
    NSString *dayToCheck;
    
    if (tag == 1) {
        
        viewToUse = self->daysOfTheWeekMondayView;
        labelToUse = self->daysOfTheWeekMondayLabel;
        dayToCheck = @"Monday";
        
    } else if (tag == 2) {
        
        viewToUse = self->daysOfTheWeekTuesdayView;
        labelToUse = self->daysOfTheWeekTuesdayLabel;
        dayToCheck = @"Tuesday";
        
    } else if (tag == 3) {
        
        viewToUse = self->daysOfTheWeekWednesdayView;
        labelToUse = self->daysOfTheWeekWednesdayLabel;
        dayToCheck = @"Wednesday";
        
    } else if (tag == 4) {
        
        viewToUse = self->daysOfTheWeekThursdayView;
        labelToUse = self->daysOfTheWeekThursdayLabel;
        dayToCheck = @"Thursday";
        
    } else if (tag == 5) {
        
        viewToUse = self->daysOfTheWeekFridayView;
        labelToUse = self->daysOfTheWeekFridayLabel;
        dayToCheck = @"Friday";
        
    } else if (tag == 6) {
        
        viewToUse = self->daysOfTheWeekSaturdayView;
        labelToUse = self->daysOfTheWeekSaturdayLabel;
        dayToCheck = @"Saturday";
        
    } else if (tag == 7) {
        
        viewToUse = self->daysOfTheWeekSundayView;
        labelToUse = self->daysOfTheWeekSundayLabel;
        dayToCheck = @"Sunday";
        
    }
    
    BOOL CheckIfDayIsSelected = (viewToUse.backgroundColor == [UIColor linkColor]);
    
    __block NSString *touchEvent = @"";
    
    [UIView animateWithDuration:0.25 animations:^{
        
        if (CheckIfDayIsSelected) {
            
            touchEvent = [NSString stringWithFormat:@"%@ Clicked Off", dayToCheck];
            
            viewToUse.backgroundColor = [UIColor clearColor];
            labelToUse.textColor = [UIColor colorWithRed:186.0f/255.0f green:186.0f/255.0f blue:186.0f/255.0f alpha:1.0f];
            
            viewToUse.layer.borderWidth = 1.5f;
            viewToUse.layer.borderColor = [UIColor colorWithRed:186.0f/255.0f green:186.0f/255.0f blue:186.0f/255.0f alpha:1.0f].CGColor;
            
            if ([daysOfTheWeekArray containsObject:dayToCheck]) {
                [daysOfTheWeekArray removeObject:dayToCheck];
            }
            
        } else {
            
            touchEvent = [NSString stringWithFormat:@"%@ Clicked On", dayToCheck];
            
            viewToUse.backgroundColor = [UIColor linkColor];
            labelToUse.textColor = [UIColor whiteColor];
            
            viewToUse.layer.borderWidth = 1.5f;
            viewToUse.layer.borderColor = [UIColor clearColor].CGColor;
            
            if ([daysOfTheWeekArray containsObject:dayToCheck] == NO) {
                [daysOfTheWeekArray addObject:dayToCheck];
            }
            
        }
        
    } completion:^(BOOL finished) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:touchEvent completionHandler:^(BOOL finished) {
            
        }];
        
        [dict setObject:daysOfTheWeekArray forKey:@"DaysOfTheWeek"];
        self->_notificationSettings = [dict mutableCopy];
        
    }];
    
}

#pragma mark

-(IBAction)SoundSwitchAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Sound Switch Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    NSMutableDictionary *dict = _notificationSettings ? [_notificationSettings mutableCopy] : [NSMutableDictionary dictionary];
    [dict setObject:[soundsSwitch isOn] ? @"Default" : @"None" forKey:@"Sound"];
    _notificationSettings = [dict mutableCopy];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        [self MainViewSetup:NO];
        
    }];
    
}

-(IBAction)SoundSubviewTapGesture:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Sound SubView Switch Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    NSMutableArray *itemsSelectedArray = [NSMutableArray array];
    
    if (soundsLabel.text.length > 0) {
        
        itemsSelectedArray = [[soundsSubLabelNo2.text componentsSeparatedByString:@""] mutableCopy];
        
    }
    
    [[[PushObject alloc] init] PushToViewOptionsViewController:itemsSelectedArray customOptionsArray:nil specificDatesArray:nil viewingItemDetails:NO optionSelectedString:@"Sounds" itemRepeatsFrequency:nil homeMembersDict:nil currentViewController:self];
    
}

-(IBAction)BadgeIconSwitchAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Badge Icon Switch Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    NSMutableDictionary *dict = _notificationSettings ? [_notificationSettings mutableCopy] : [NSMutableDictionary dictionary];
    [dict setObject:[badgeIconSwitch isOn] ? @"Yes" : @"No" forKey:@"BadgeIcon"];
    _notificationSettings = [dict mutableCopy];
    
}

#pragma mark

-(IBAction)ScheduledSummaryTapGesture:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Scheduled Summary Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    [[[PushObject alloc] init] PushToNotificationSettingsViewController:self notificationSettings:_notificationSettings viewingChores:NO viewingExpenses:NO viewingLists:NO viewingGroupChats:NO viewingHomeMembers:NO viewingForum:NO viewingScheduledSummary:YES viewingScheduledSummaryTaskTypes:NO Superficial:NO];
    
}

#pragma mark

#pragma mark Main Notifications

-(IBAction)ChoresTapGesture:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Chores Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    [[[PushObject alloc] init] PushToNotificationSettingsViewController:self notificationSettings:_notificationSettings viewingChores:YES viewingExpenses:NO viewingLists:NO viewingGroupChats:NO viewingHomeMembers:NO viewingForum:NO viewingScheduledSummary:NO viewingScheduledSummaryTaskTypes:NO Superficial:NO];
    
}

-(IBAction)ExpensesTapGesture:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Expenses Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    [[[PushObject alloc] init] PushToNotificationSettingsViewController:self notificationSettings:_notificationSettings viewingChores:NO viewingExpenses:YES viewingLists:NO viewingGroupChats:NO viewingHomeMembers:NO viewingForum:NO viewingScheduledSummary:NO viewingScheduledSummaryTaskTypes:NO Superficial:NO];
    
}

-(IBAction)ListsTapGesture:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Lists Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    [[[PushObject alloc] init] PushToNotificationSettingsViewController:self notificationSettings:_notificationSettings viewingChores:NO viewingExpenses:NO viewingLists:YES viewingGroupChats:NO viewingHomeMembers:NO viewingForum:NO viewingScheduledSummary:NO viewingScheduledSummaryTaskTypes:NO Superficial:NO];
    
}

-(IBAction)GroupChatsTapGesture:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Group Chats Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    [[[PushObject alloc] init] PushToNotificationSettingsViewController:self notificationSettings:_notificationSettings viewingChores:NO viewingExpenses:NO viewingLists:NO viewingGroupChats:YES viewingHomeMembers:NO viewingForum:NO viewingScheduledSummary:NO viewingScheduledSummaryTaskTypes:NO Superficial:NO];
    
}

#pragma mark

#pragma mark Other Notifications

-(IBAction)HomeMembersTapGesture:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Home Members Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    [[[PushObject alloc] init] PushToNotificationSettingsViewController:self notificationSettings:_notificationSettings viewingChores:NO viewingExpenses:NO viewingLists:NO viewingGroupChats:NO viewingHomeMembers:YES viewingForum:NO viewingScheduledSummary:NO viewingScheduledSummaryTaskTypes:NO Superficial:NO];
    
}

-(IBAction)ForumsTapGesture:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Forums Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    [[[PushObject alloc] init] PushToNotificationSettingsViewController:self notificationSettings:_notificationSettings viewingChores:NO viewingExpenses:NO viewingLists:NO viewingGroupChats:NO viewingHomeMembers:NO viewingForum:YES viewingScheduledSummary:NO viewingScheduledSummaryTaskTypes:NO Superficial:NO];
    
}

#pragma mark
#pragma mark
#pragma mark

#pragma mark - IBAction Methods Summary Notification
#pragma mark
#pragma mark

-(IBAction)ScheduledSummarySwitchAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Scheduled Summary Switch Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    NSMutableDictionary *notificationSettingsCopy = _notificationSettings ? [_notificationSettings mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *dict = notificationSettingsCopy && notificationSettingsCopy[@"ScheduledSummary"] ? [notificationSettingsCopy[@"ScheduledSummary"] mutableCopy] : [NSMutableDictionary dictionary];
    [dict setObject:[scheduledSummarySwitch isOn] ? @"Yes" : @"No" forKey:@"Activated"];
    [notificationSettingsCopy setObject:dict forKey:@"ScheduledSummary"];
    
    _notificationSettings = [notificationSettingsCopy mutableCopy];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        [self ScheduleSummarySetUp:NO];
        
    }];
    
}

#pragma mark

-(IBAction)AddScheduledSummary:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Add Scheduled Summary Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    [customTextField resignFirstResponder];
    [customTextField removeFromSuperview];
    
    if ([[[BoolDataObject alloc] init] PremiumSubscriptionIsOn] == NO && (self->_notificationSettings[@"ScheduledSummary"] && self->_notificationSettings[@"ScheduledSummary"][@"Summaries"] && [[self->_notificationSettings[@"ScheduledSummary"][@"Summaries"] allKeys] count] >= 1)) {
        
        [[[PushObject alloc] init] PushToWeDivvyPremiumViewController:NO comingFromSignUp:YES defaultPlan:@"" displayDiscount:@"Half-Off Yearly Discount No Sale Sticker" selectedSlide:@"Unlimited Summary Notifications" promoCodeID:@"" premiumPlanProductsArray:premiumPlanProductsArray premiumPlanPricesDict:premiumPlanPricesDict premiumPlanExpensivePricesDict:premiumPlanExpensivePricesDict premiumPlanPricesDiscountDict:premiumPlanPricesDiscountDict premiumPlanPricesNoFreeTrialDict:premiumPlanPricesNoFreeTrialDict currentViewController:self Superficial:NO];
        
    } else {
        
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Give your summary a name" message:nil
                                                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Add"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * _Nonnull action) {
            
            NSString *notificationSummaryName = controller.textFields[0].text;
            
            if ([notificationSummaryName isEqualToString:@""]) {
                
                [self->progressView setHidden:YES];
                [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You forgot to enter a name" currentViewController:self];
                
            } else if (self->_notificationSettings[@"ScheduledSummary"] && self->_notificationSettings[@"ScheduledSummary"][@"Summaries"] && [[self->_notificationSettings[@"ScheduledSummary"][@"Summaries"] allKeys] containsObject:notificationSummaryName]) {
                
                [self->progressView setHidden:YES];
                [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You already have a summary notification with this name" currentViewController:self];
                
            } else {
                
                NSMutableDictionary *dict01 = self->_notificationSettings ? [self->_notificationSettings mutableCopy] : [NSMutableDictionary dictionary];
                
                NSMutableDictionary *dict = dict01[@"ScheduledSummary"] ? [dict01[@"ScheduledSummary"] mutableCopy] : [NSMutableDictionary dictionary];
                
                NSMutableDictionary *summariesDict = dict[@"Summaries"] ? [dict[@"Summaries"] mutableCopy] : [NSMutableDictionary dictionary];
                
                [summariesDict setObject:@{@"Name" : notificationSummaryName, @"Frequency" : @"Weekly", @"Day" : @"Sunday", @"Time" : @"12:00 PM"} forKey:notificationSummaryName];
                
                [dict setObject:summariesDict forKey:@"Summaries"];
                
                [dict01 setObject:dict forKey:@"ScheduledSummary"];
                
                self->_notificationSettings = [dict01 mutableCopy];
                
                [self ScheduleSummarySetUp:NO];
                
            }
            
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                         style:UIAlertActionStyleCancel
                                                       handler:^(UIAlertAction * _Nonnull action) {}];
        
        
        
        [controller addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            
            textField.delegate = self;
            textField.placeholder = @"Notification Summary Name";
            textField.text = @"";
            textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
            
        }];
        
        [controller addAction:action1];
        [controller addAction:cancel];
        [self presentViewController:controller animated:YES completion:nil];
  
    }
    
}

#pragma mark

-(IBAction)ScheduledSummaryFrequencyTapGesture:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Repeats Field Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    UITapGestureRecognizer *tapRecognizer = (UITapGestureRecognizer *)sender;
    NSInteger the_tag = [tapRecognizer.view tag];
    
    NSMutableDictionary *dict = _notificationSettings && _notificationSettings[@"ScheduledSummary"] ? [_notificationSettings[@"ScheduledSummary"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *summariesDict = dict[@"Summaries"] ? [dict[@"Summaries"] mutableCopy] : [NSMutableDictionary dictionary];
    NSString *selectedSummary = [[summariesDict allKeys] count] > the_tag ? [summariesDict allKeys][the_tag] : @"";
    
    [[NSUserDefaults standardUserDefaults] setObject:selectedSummary forKey:@"SelectedSummary"];
    
    NSMutableArray *itemsSelectedArray = [NSMutableArray array];
    
    if (summariesDict && summariesDict[selectedSummary] && summariesDict[selectedSummary][@"Frequency"] && [summariesDict[selectedSummary][@"Frequency"] length] > 0) {
        
        itemsSelectedArray = [[summariesDict[selectedSummary][@"Frequency"] componentsSeparatedByString:@", "] mutableCopy];
        
    }
    
    [[[PushObject alloc] init] PushToViewOptionsViewController:itemsSelectedArray customOptionsArray:nil specificDatesArray:nil viewingItemDetails:NO optionSelectedString:@"ScheduledSummaryFrequency" itemRepeatsFrequency:nil homeMembersDict:nil currentViewController:self];
    
}

-(IBAction)ScheduledSummaryDaysTapGesture:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Days Field Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    UITapGestureRecognizer *tapRecognizer = (UITapGestureRecognizer *)sender;
    NSInteger the_tag = [tapRecognizer.view tag];
    
    NSMutableDictionary *dict = _notificationSettings && _notificationSettings[@"ScheduledSummary"] ? [_notificationSettings[@"ScheduledSummary"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *summariesDict = dict[@"Summaries"] ? [dict[@"Summaries"] mutableCopy] : [NSMutableDictionary dictionary];
    NSString *selectedSummary = [[summariesDict allKeys] count] > the_tag ? [summariesDict allKeys][the_tag] : @"";
    
    [[NSUserDefaults standardUserDefaults] setObject:selectedSummary forKey:@"SelectedSummary"];
    
    NSMutableArray *itemsSelectedArray = [NSMutableArray array];
    
    if (summariesDict && summariesDict[selectedSummary] && summariesDict[selectedSummary][@"Day"] && [summariesDict[selectedSummary][@"Day"] length] > 0) {
        
        itemsSelectedArray = [[summariesDict[selectedSummary][@"Day"] componentsSeparatedByString:@", "] mutableCopy];
        
    }
    
    NSString *frequency = summariesDict[selectedSummary][@"Frequency"];
    
    [[[PushObject alloc] init] PushToViewOptionsViewController:itemsSelectedArray customOptionsArray:nil specificDatesArray:nil viewingItemDetails:NO optionSelectedString:@"ScheduledSummaryDays" itemRepeatsFrequency:frequency homeMembersDict:nil currentViewController:self];
    
}

#pragma mark

-(IBAction)ScheduledSummaryTaskTypesTapGesture:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Scheduled Summary Task Types Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    [[[PushObject alloc] init] PushToNotificationSettingsViewController:self notificationSettings:_notificationSettings viewingChores:NO viewingExpenses:NO viewingLists:NO viewingGroupChats:NO viewingHomeMembers:NO viewingForum:NO viewingScheduledSummary:NO viewingScheduledSummaryTaskTypes:YES Superficial:NO];
    
}

#pragma mark
#pragma mark
#pragma mark

#pragma mark - IBAction Methods Main Notifications
#pragma mark
#pragma mark

-(IBAction)ChoreOptionsSwitch:(id)sender {
    
    UISwitch *tapRecognizer = (UISwitch *)sender;
    NSInteger tag = [tapRecognizer tag];
    
    UISwitch *switchToUse = [[UISwitch alloc] init];
    NSString *keyToUse = @"";
  
    if (tag == 1) {
        switchToUse = addingSwitch;
        keyToUse = @"Adding";
    } else if (tag == 2) {
        switchToUse = editingSwitch;
        keyToUse = @"Editing";
    } else if (tag == 3) {
        switchToUse = deletingSwitch;
        keyToUse = @"Deleting";
    } else if (tag == 4) {
        switchToUse = duplicatingSwitch;
        keyToUse = @"Duplicating";
    } else if (tag == 5) {
        switchToUse = waivingSwitch;
        keyToUse = @"Waiving";
    } else if (tag == 6) {
        switchToUse = skippingSwitch;
        keyToUse = @"Skipping";
    } else if (tag == 7) {
        switchToUse = pauseUnpauseSwitch;
        keyToUse = @"Pause/Unpause";
    } else if (tag == 8) {
        switchToUse = commentsSwitch;
        keyToUse = @"Comments";
    }
    
    else if (tag == 9) {
        switchToUse = skippingTurnSwitch;
        keyToUse = @"SkippingTurn";
    } else if (tag == 10) {
        switchToUse = removingUserSwitch;
        keyToUse = @"RemovingUser";
    }
    
    else if (tag == 11) {
        switchToUse = fullyCompletedSwitch;
        keyToUse = @"FullyCompleted";
    } else if (tag == 12) {
        switchToUse = completedSwitch;
        keyToUse = @"Completed";
    } else if (tag == 13) {
        switchToUse = inProgressSwitch;
        keyToUse = @"InProgress";
    } else if (tag == 14) {
        switchToUse = wontDoSwitch;
        keyToUse = @"WontDo";
    } else if (tag == 15) {
        switchToUse = acceptSwitch;
        keyToUse = @"Accept";
    } else if (tag == 16) {
        switchToUse = declineSwitch;
        keyToUse = @"Decline";
    }
    
    else if (tag == 17) {
        switchToUse = dueDateSwitch;
        keyToUse = @"DueDate";
    } else if (tag == 18) {
        switchToUse = reminderSwitch;
        keyToUse = @"Reminder";
    }
    
    else if (tag == 19) {
        switchToUse = subtaskEditSwitch;
        keyToUse = @"SubtaskEditing";
    } else if (tag == 20) {
        switchToUse = subtaskDeleteSwitch;
        keyToUse = @"SubtaskDeleting";
    }
    
    else if (tag == 21) {
        switchToUse = subtaskCompletedSwitch;
        keyToUse = @"SubtaskCompleted";
    } else if (tag == 22) {
        switchToUse = subtaskInProgressSwitch;
        keyToUse = @"SubtaskInProgress";
    } else if (tag == 23) {
        switchToUse = subtaskWontDoSwitch;
        keyToUse = @"SubtaskWontDo";
    } else if (tag == 24) {
        switchToUse = subtaskAcceptSwitch;
        keyToUse = @"SubtaskAccept";
    } else if (tag == 25) {
        switchToUse = subtaskDeclineSwitch;
        keyToUse = @"SubtaskDecline";
    }
    
    NSDictionary *dict = @{@"Switch" : switchToUse, @"Key" : keyToUse};
    NSString *itemType = @"Chores";
   
    [self GenerateUpdatedNotificationSettings:dict itemType:itemType];
    
}

-(IBAction)ExpenseOptionsSwitch:(id)sender {
    
    UISwitch *tapRecognizer = (UISwitch *)sender;
    NSInteger tag = [tapRecognizer tag];
    
    UISwitch *switchToUse = [[UISwitch alloc] init];
    NSString *keyToUse = @"";
    
    if (tag == 1) {
        switchToUse = addingSwitch;
        keyToUse = @"Adding";
    } else if (tag == 2) {
        switchToUse = editingSwitch;
        keyToUse = @"Editing";
    } else if (tag == 3) {
        switchToUse = deletingSwitch;
        keyToUse = @"Deleting";
    } else if (tag == 4) {
        switchToUse = duplicatingSwitch;
        keyToUse = @"Duplicating";
    } else if (tag == 5) {
        switchToUse = waivingSwitch;
        keyToUse = @"Waiving";
    } else if (tag == 6) {
        switchToUse = skippingSwitch;
        keyToUse = @"Skipping";
    } else if (tag == 7) {
        switchToUse = pauseUnpauseSwitch;
        keyToUse = @"Pause/Unpause";
    } else if (tag == 8) {
        switchToUse = commentsSwitch;
        keyToUse = @"Comments";
    }
    
    else if (tag == 9) {
        switchToUse = skippingTurnSwitch;
        keyToUse = @"SkippingTurn";
    } else if (tag == 10) {
        switchToUse = removingUserSwitch;
        keyToUse = @"RemovingUser";
    }
    
    else if (tag == 11) {
        switchToUse = fullyCompletedSwitch;
        keyToUse = @"FullyCompleted";
    } else if (tag == 12) {
        switchToUse = completedSwitch;
        keyToUse = @"Completed";
    } else if (tag == 13) {
        switchToUse = inProgressSwitch;
        keyToUse = @"InProgress";
    } else if (tag == 14) {
        switchToUse = wontDoSwitch;
        keyToUse = @"WontDo";
    } else if (tag == 15) {
        switchToUse = acceptSwitch;
        keyToUse = @"Accept";
    } else if (tag == 16) {
        switchToUse = declineSwitch;
        keyToUse = @"Decline";
    }
    
    else if (tag == 17) {
        switchToUse = dueDateSwitch;
        keyToUse = @"DueDate";
    } else if (tag == 18) {
        switchToUse = reminderSwitch;
        keyToUse = @"Reminder";
    }
    
    else if (tag == 19) {
        switchToUse = editItemizedItemSwitch;
        keyToUse = @"EditingItemizedItem";
    } else if (tag == 20) {
        switchToUse = deleteItemizedItemSwitch;
        keyToUse = @"DeletingItemizedItem";
    }
    
    NSDictionary *dict = @{@"Switch" : switchToUse, @"Key" : keyToUse};
    NSString *itemType = @"Expenses";
    
    [self GenerateUpdatedNotificationSettings:dict itemType:itemType];
    
}

-(IBAction)ListOptionsSwitch:(id)sender {
    
    UISwitch *tapRecognizer = (UISwitch *)sender;
    NSInteger tag = [tapRecognizer tag];
    
    UISwitch *switchToUse = [[UISwitch alloc] init];
    NSString *keyToUse = @"";
    
    if (tag == 1) {
        switchToUse = addingSwitch;
        keyToUse = @"Adding";
    } else if (tag == 2) {
        switchToUse = editingSwitch;
        keyToUse = @"Editing";
    } else if (tag == 3) {
        switchToUse = deletingSwitch;
        keyToUse = @"Deleting";
    } else if (tag == 4) {
        switchToUse = duplicatingSwitch;
        keyToUse = @"Duplicating";
    } else if (tag == 5) {
        switchToUse = waivingSwitch;
        keyToUse = @"Waiving";
    } else if (tag == 6) {
        switchToUse = skippingSwitch;
        keyToUse = @"Skipping";
    } else if (tag == 7) {
        switchToUse = pauseUnpauseSwitch;
        keyToUse = @"Pause/Unpause";
    } else if (tag == 8) {
        switchToUse = commentsSwitch;
        keyToUse = @"Comments";
    }
    
    else if (tag == 9) {
        switchToUse = fullyCompletedSwitch;
        keyToUse = @"FullyCompleted";
    } else if (tag == 10) {
        switchToUse = completedSwitch;
        keyToUse = @"Completed";
    } else if (tag == 11) {
        switchToUse = inProgressSwitch;
        keyToUse = @"InProgress";
    } else if (tag == 12) {
        switchToUse = wontDoSwitch;
        keyToUse = @"WontDo";
    } else if (tag == 13) {
        switchToUse = acceptSwitch;
        keyToUse = @"Accept";
    } else if (tag == 14) {
        switchToUse = declineSwitch;
        keyToUse = @"Decline";
    }
    
    else if (tag == 15) {
        switchToUse = dueDateSwitch;
        keyToUse = @"DueDate";
    } else if (tag == 16) {
        switchToUse = reminderSwitch;
        keyToUse = @"Reminder";
    }
    
    else if (tag == 17) {
        switchToUse = addListItemSwitch;
        keyToUse = @"AddingListItem";
    } else if (tag == 18) {
        switchToUse = editListItemSwitch;
        keyToUse = @"EditingListItem";
    } else if (tag == 19) {
        switchToUse = deleteListItemSwitch;
        keyToUse = @"DeletingListItem";
    }
    
    NSDictionary *dict = @{@"Switch" : switchToUse, @"Key" : keyToUse};
    NSString *itemType = @"Lists";
    
    [self GenerateUpdatedNotificationSettings:dict itemType:itemType];
    
}

-(IBAction)GroupChatOptionsSwitch:(id)sender {
    
    UISwitch *tapRecognizer = (UISwitch *)sender;
    NSInteger tag = [tapRecognizer tag];
    
    UISwitch *switchToUse = [[UISwitch alloc] init];
    NSString *keyToUse = @"";
    
    if (tag == 1) {
        switchToUse = addingSwitch;
        keyToUse = @"Adding";
    } else if (tag == 2) {
        switchToUse = editingSwitch;
        keyToUse = @"Editing";
    } else if (tag == 3) {
        switchToUse = deletingSwitch;
        keyToUse = @"Deleting";
    }
    
    else if (tag == 4) {
        switchToUse = groupChatMessagesSwitch;
        keyToUse = @"GroupChatMessages";
    } else if (tag == 5) {
        switchToUse = liveSupportMessagesSwitch;
        keyToUse = @"LiveSupportMessages";
    }
    
    NSDictionary *dict = @{@"Switch" : switchToUse, @"Key" : keyToUse};
    NSString *itemType = @"GroupChats";
    
    [self GenerateUpdatedNotificationSettings:dict itemType:itemType];
    
}

#pragma mark
#pragma mark
#pragma mark

#pragma mark - IBAction Methods Other Notifications
#pragma mark
#pragma mark

-(IBAction)HomeMembersOptionsSwitch:(id)sender {
    
    UISwitch *tapRecognizer = (UISwitch *)sender;
    NSInteger tag = [tapRecognizer tag];
    
    UISwitch *switchToUse = [[UISwitch alloc] init];
    NSString *keyToUse = @"";
    
    if (tag == 1) {
        switchToUse = sendingInvitationsSwitch;
        keyToUse = @"SendingInvitations";
    } else if (tag == 2) {
        switchToUse = deletingInvitationsSwitch;
        keyToUse = @"DeletingInvitations";
    }
    
    else if (tag == 3) {
        switchToUse = newHomeMembersSwitch;
        keyToUse = @"NewHomeMembers";
    } else if (tag == 4) {
        switchToUse = movedOutHomeMembersSwitch;
        keyToUse = @"HomeMembersMovedOut";
    } else if (tag == 5) {
        switchToUse = kickingOutHomeMembersSwitch;
        keyToUse = @"HomeMembersKickedOut";
    }
    
    NSDictionary *dict = @{@"Switch" : switchToUse, @"Key" : keyToUse};
    NSString *itemType = @"HomeMembers";
    
    [self GenerateUpdatedNotificationSettings:dict itemType:itemType];
    
}

-(IBAction)ForumOptionsSwitch:(id)sender {
    
    UISwitch *tapRecognizer = (UISwitch *)sender;
    NSInteger tag = [tapRecognizer tag];
    
    UISwitch *switchToUse = [[UISwitch alloc] init];
    NSString *keyToUse = @"";
    
    if (tag == 1) {
        switchToUse = bugForumUpvoteSwitch;
        keyToUse = @"BugForumUpvotes";
    } else if (tag == 2) {
        switchToUse = featureForumUpvoteSwitch;
        keyToUse = @"FeatureForumUpvotes";
    }
    
    else if (tag == 3) {
        switchToUse = newHomeMembersSwitch;
        keyToUse = @"NewHomeMembers";
    } else if (tag == 4) {
        switchToUse = movedOutHomeMembersSwitch;
        keyToUse = @"HomeMembersMovedOut";
    } else if (tag == 5) {
        switchToUse = kickingOutHomeMembersSwitch;
        keyToUse = @"HomeMembersKickedOut";
    }
    
    NSDictionary *dict = @{@"Switch" : switchToUse, @"Key" : keyToUse};
    NSString *itemType = @"Forum";
    
    [self GenerateUpdatedNotificationSettings:dict itemType:itemType];
    
}

#pragma mark
#pragma mark
#pragma mark

#pragma mark - Custom Methods

-(void)StartProgressView {
    
    self->progressView = [MRProgressOverlayView showOverlayAddedTo:self.navigationController.view animated:YES];
    self->progressView.mode = MRProgressOverlayViewModeIndeterminateSmall;
    
}

-(void)Done {
    
    [customTextField resignFirstResponder];
    [customTextField removeFromSuperview];
    
}

-(void)GenerateUpdatedNotificationSettings:(NSDictionary *)dict itemType:(NSString *)itemType {
    
    UISwitch *switchControl = dict[@"Switch"] ? dict[@"Switch"] : [[UISwitch alloc] init];
    NSString *key = dict[@"Key"] ? dict[@"Key"] : @"";
    NSString *touchEvent = @"";
    
    NSMutableDictionary *notificationSettingsDictCopy = _notificationSettings && _notificationSettings ? [_notificationSettings mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *notificationSettingsDict = notificationSettingsDictCopy && notificationSettingsDictCopy[itemType] ? [notificationSettingsDictCopy[itemType] mutableCopy] : [NSMutableDictionary dictionary];
    
    [notificationSettingsDict setObject:[switchControl isOn] ? @"Yes" : @"No" forKey:key];
    touchEvent = [NSString stringWithFormat:@"%@ %@ Clicked %@", itemType, key, [switchControl isOn] ? @"On" : @"Off"];
    [notificationSettingsDictCopy setObject:notificationSettingsDict forKey:itemType];
   
    _notificationSettings = [notificationSettingsDictCopy mutableCopy];
   
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:touchEvent completionHandler:^(BOOL finished) {
        
    }];
    
}

-(IBAction)TapGesturePickerView:(id)sender {
    
    UITapGestureRecognizer *tapRecognizer = (UITapGestureRecognizer *)sender;
    UILabel *label = (UILabel *)tapRecognizer.view;
    NSInteger tagToUse = [label tag];
    NSString *text = [label text];
    
    
    
    if ([text containsString:@":"]) {
        
        NSArray *arr = [text componentsSeparatedByString:@":"];
        self->hourComp = [arr count] > 0 ? arr[0] : @"12";
        
        if ([arr count] > 1 && [arr[1] containsString:@" "]) {
            
            arr = [arr[1] componentsSeparatedByString:@" "];
            
            self->minuteComp = [arr count] > 0 ? arr[0] : @"00";
            self->AMPMComp = [arr count] > 1 ? arr[1] : @"PM";
            
        }
        
    }
    
    
    
    [customTextField removeFromSuperview];
    customTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    
    UIToolbar* keyboardToolbar = [[UIToolbar alloc] init];
    [keyboardToolbar sizeToFit];
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                      target:nil action:nil];
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc]
                                      initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(Done)];
    keyboardToolbar.items = @[flexBarButton, doneBarButton];
    customTextField.inputAccessoryView = keyboardToolbar;
    
    [self.view addSubview:customTextField];
    
    
    
    UIPickerView *pickerView = [[UIPickerView alloc]init];
    pickerView.delegate = self;
    pickerView.tag = tagToUse;
    
    if ([self->frequencyHourArray containsObject:self->hourComp]) {
        [pickerView selectRow:[self->frequencyHourArray indexOfObject:self->hourComp] inComponent:0 animated:YES];
    }
    
    if ([self->frequencyMinuteArray containsObject:self->minuteComp]) {
        [pickerView selectRow:[self->frequencyMinuteArray indexOfObject:self->minuteComp] inComponent:1 animated:YES];
    }
    
    if ([self->frequencyAMPMArray containsObject:self->AMPMComp]) {
        [pickerView selectRow:[self->frequencyAMPMArray indexOfObject:self->AMPMComp] inComponent:2 animated:YES];
    }
    
    
    
    [customTextField setInputView:pickerView];
    [customTextField becomeFirstResponder];
    
}

#pragma mark - UI Setup - Internal Methods

-(void)SetUpAlpha:(NSArray *)viewArray switchControl:(UISwitch *)switchControl {
    
    for (NSDictionary *dictToUse in viewArray) {
        
        UIView *viewToUse = dictToUse[@"View"] ? dictToUse[@"View"] : [[UIView alloc] init];
        
        viewToUse.alpha = [switchControl isOn] ? 1.0f : 0.0f;
        
    }
    
}

-(void)SetUpSwitchStatus:(NSArray *)viewArray itemType:(NSString *)itemType selector:(nonnull SEL)selector {
    
    for (NSDictionary *dictToUse in viewArray) {
        
        UISwitch *switchToUse = dictToUse[@"Switch"] ? dictToUse[@"Switch"] : [[UISwitch alloc] init];
        NSString *key = dictToUse[@"Key"] ? dictToUse[@"Key"] : @"";
        
        [switchToUse setOn:_notificationSettings && _notificationSettings[itemType] && _notificationSettings[itemType][key] && [_notificationSettings[itemType][key] isEqualToString:@"Yes"] ? YES : NO];
        [switchToUse addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
        
    }
    
}

-(void)SetUpSwitchAction:(NSArray *)viewArray selector:(nonnull SEL)selector {
    
    for (NSDictionary *dictToUse in viewArray) {
        
        UISwitch *switchToUse = dictToUse[@"Switch"] ? dictToUse[@"Switch"] : [[UISwitch alloc] init];
        
        [switchToUse addTarget:self action:@selector(SoundSwitchAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
}

-(void)SetUpViewTapGestures:(NSArray *)viewArray selector:(nonnull SEL)selector {
    
    for (NSDictionary *dictToUse in viewArray) {
        
        UISwitch *viewToUse = dictToUse[@"View"] ? dictToUse[@"View"] : [[UIView alloc] init];
        
        UITapGestureRecognizer *tapGesture;
        
        tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:selector];
        [viewToUse addGestureRecognizer:tapGesture];
        viewToUse.userInteractionEnabled = YES;
        
    }
    
}

-(void)SetUpSwitchTags:(NSArray *)viewArray {
    
    int i = 0;
    
    for (NSDictionary *dictToUse in viewArray) {
        
        i += 1;
        
        UISwitch *switchToUse = dictToUse[@"Switch"] ? dictToUse[@"Switch"] : [[UISwitch alloc] init];
        switchToUse.tag = i;
        
    }
    
}

-(void)SetUpDaysOfTheWeekTags:(NSArray *)viewArray {
    
    int i = 0;
    
    for (NSDictionary *dictToUse in viewArray) {
        
        i += 1;
        
        UIView *viewTouse = dictToUse[@"View"] ? dictToUse[@"View"] : [[UIView alloc] init];
        UILabel *labelTouse = dictToUse[@"Label"] ? dictToUse[@"Label"] : [[UILabel alloc] init];
        
        viewTouse.tag = i;
        labelTouse.tag = i;
        
    }
    
}

-(void)SetUpDaysOfTheWeekUI:(NSArray *)viewArray {
    
    for (NSDictionary *dictToUse in viewArray) {
        
        UIView *viewTouse = dictToUse[@"View"] ? dictToUse[@"View"] : [[UIView alloc] init];
        UILabel *labelTouse = dictToUse[@"Label"] ? dictToUse[@"Label"] : [[UILabel alloc] init];
        NSString *day = dictToUse[@"Day"] ? dictToUse[@"Day"] : @"";
        
        if (_notificationSettings[@"DaysOfTheWeek"] && [_notificationSettings[@"DaysOfTheWeek"] containsObject:day]) {
            
            viewTouse.layer.cornerRadius = viewTouse.frame.size.height/2;
            viewTouse.backgroundColor = [UIColor linkColor];
            
            labelTouse.frame = CGRectMake(0, 0, viewTouse.frame.size.width, viewTouse.frame.size.height);
            labelTouse.textAlignment = NSTextAlignmentCenter;
            labelTouse.textColor = [UIColor whiteColor];
            labelTouse.adjustsFontSizeToFitWidth = YES;
            labelTouse.font = [UIFont systemFontOfSize:(self.view.frame.size.height*0.01902174 > 14?(14):self.view.frame.size.height*0.01902174) weight:UIFontWeightMedium];
            
        } else {
            
            viewTouse.layer.cornerRadius = viewTouse.frame.size.height/2;
            viewTouse.backgroundColor = [UIColor clearColor];
            viewTouse.layer.borderWidth = 1.5f;
            viewTouse.layer.borderColor = [UIColor colorWithRed:186.0f/255.0f green:186.0f/255.0f blue:186.0f/255.0f alpha:1.0f].CGColor;
            
            labelTouse.frame = CGRectMake(0, 0, viewTouse.frame.size.width, viewTouse.frame.size.height);
            labelTouse.textAlignment = NSTextAlignmentCenter;
            labelTouse.textColor = [UIColor colorWithRed:186.0f/255.0f green:186.0f/255.0f blue:186.0f/255.0f alpha:1.0f];
            labelTouse.adjustsFontSizeToFitWidth = YES;
            labelTouse.font = [UIFont systemFontOfSize:(self.view.frame.size.height*0.01902174 > 14?(14):self.view.frame.size.height*0.01902174) weight:UIFontWeightMedium];
            
        }
        
    }
    
}

-(void)SetUpTopLabelUI:(NSArray *)viewArray {
    
    for (NSDictionary *dictToUse in viewArray) {
        
        UILabel *labelToUse = dictToUse[@"Label"] ? dictToUse[@"Label"] : [[UILabel alloc] init];
        NSString *labelText = dictToUse[@"Text"] ? dictToUse[@"Text"] : @"";
        
        labelToUse.text = labelText;
        labelToUse.textColor = [UIColor colorWithRed:168.0f/255.0f green:167.0f/255.0f blue:172.0f/255.0f alpha:1.0f];
        labelToUse.font = [UIFont systemFontOfSize:(self.view.frame.size.height*0.017663 > 13?(13):self.view.frame.size.height*0.017663) weight:UIFontWeightMedium];
        
    }
    
}

-(void)SetUpCorners:(NSArray *)viewArray {
    
    for (NSDictionary *dictToUse in viewArray) {
        
        UIView *topView = dictToUse[@"TopView"] ? dictToUse[@"TopView"] : [[UIView alloc] init];
        UIView *bottomView = dictToUse[@"BottomView"] ? dictToUse[@"BottomView"] : [[UIView alloc] init];
        
        CGFloat cornerRadius = (self.view.frame.size.height*0.2181818182 > 12?12:(self.view.frame.size.height*0.2181818182));
        
        if (topView == bottomView) {
            
            [[[GeneralObject alloc] init] RoundingCorners:topView topCorners:YES bottomCorners:YES cornerRadius:cornerRadius];
            
        } else {
            
            [[[GeneralObject alloc] init] RoundingCorners:topView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
            [[[GeneralObject alloc] init] RoundingCorners:bottomView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
            
        }
        
    }
    
}

-(void)SetUpRightArrowFrame:(NSArray *)viewArray {
    
    CGFloat textFieldSpacing = (self.view.frame.size.height*0.024456);
    
    CGFloat width = (self.view.frame.size.width*1 - (textFieldSpacing*2));
    CGFloat height = (self.view.frame.size.height*0.0679 > 50?(50):self.view.frame.size.height*0.0679);
    
    for (NSDictionary *dictToUse in viewArray) {
        
        UIImageView *viewToUse = dictToUse[@"ImageView"] ? dictToUse[@"ImageView"] : [[UIImageView alloc] init];
        
        viewToUse.image = [UIImage imageNamed:@"AddItemIcon.TextFieldRightArrow.png"];
        viewToUse.contentMode = UIViewContentModeScaleAspectFit;
        viewToUse.frame = CGRectMake(width*1 - width*0.02339181 - width*0.04830918, height*0, width*0.02339181, height*1);
        
    }
    
}

-(void)SetUpBottomLineViews:(NSArray *)viewArray {
    
    for (NSDictionary *dictToUse in viewArray) {
        
        UIView *viewToUse = dictToUse[@"View"] ? dictToUse[@"View"] : [[UIView alloc] init];
        
        for (UIView *subViewNo1 in [viewToUse subviews]) {
            
            if (subViewNo1.tag == 1111) {
                
                [subViewNo1 removeFromSuperview];
                
            }
            
        }
        
    }
    
    for (NSDictionary *dictToUse in viewArray) {
        
        UIView *viewToUse = dictToUse[@"View"] ? dictToUse[@"View"] : [[UIView alloc] init];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(viewToUse.frame.size.width*0.04830918, viewToUse.frame.size.height-1, viewToUse.frame.size.width - (viewToUse.frame.size.width*0.04830918), 1)];
        view.backgroundColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTextSecondary] : [UIColor colorWithRed:231.0f/255.0f green:231.0f/255.0f blue:232.0f/255.0f alpha:view.alpha];
        view.tag = 1111;
        [viewToUse addSubview:view];
        
    }
    
}

-(void)SetUpLabelWithoutImage:(NSArray *)viewArray {
    
    CGFloat textFieldSpacing = (self.view.frame.size.height*0.024456);
    
    CGFloat width = (self.view.frame.size.width*1 - (textFieldSpacing*2));
    CGFloat height = (self.view.frame.size.height*0.0679 > 50?(50):self.view.frame.size.height*0.0679);
    
    for (NSDictionary *dictToUse in viewArray) {
        
        UIView *labelToUse = dictToUse[@"Label"] ? dictToUse[@"Label"] : [[UILabel alloc] init];
        float labelWidth = dictToUse[@"Width"] ? [dictToUse[@"Width"] floatValue] : 0.0;
        
        labelToUse.frame = CGRectMake(width*0.04830918, height*0, width*labelWidth, height);
        
    }
    
}

-(void)SetUpControlSwitchFrame:(NSArray *)viewArray {
    
    CGFloat textFieldSpacing = (self.view.frame.size.height*0.024456);
    
    CGFloat width = (self.view.frame.size.width*1 - (textFieldSpacing*2));
    CGFloat height = (self.view.frame.size.height*0.0679 > 50?(50):self.view.frame.size.height*0.0679);
    
    for (NSDictionary *dictToUse in viewArray) {
        
        UISwitch *viewToUse = dictToUse[@"Switch"] ? dictToUse[@"Switch"] : [[UISwitch alloc] init];
        
        CGFloat switchTransform = height*0.5/31;
        
        viewToUse.transform = CGAffineTransformMakeScale(switchTransform, switchTransform);
        viewToUse.frame = CGRectMake(width*1 - viewToUse.frame.size.width - width*0.04830918, height*0.5 - (viewToUse.frame.size.height*0.5), viewToUse.frame.size.width, viewToUse.frame.size.height);
        viewToUse.onTintColor = [[[GeneralObject alloc] init] GenerateAppColor:1.0f];
        
    }
    
}

-(void)SetUpLabelFontSize:(NSArray *)viewArray {
    
    UIFont *fontSize = [UIFont systemFontOfSize:(self.view.frame.size.height*0.02309783 > 17?(17):self.view.frame.size.height*0.02309783) weight:UIFontWeightRegular];
    
    for (NSDictionary *dictToUse in viewArray) {
        
        UILabel *labelTouse = dictToUse[@"Label"] ? dictToUse[@"Label"] : [[UILabel alloc] init];
        
        labelTouse.font = fontSize;
        labelTouse.adjustsFontSizeToFitWidth = YES;
        labelTouse.textColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTextPrimary] : [[[LightDarkModeObject alloc] init] LightModeTextPrimary];
        
        CGRect newRect = labelTouse.frame;
        newRect.size.width = [[[GeneralObject alloc] init] WidthOfString:labelTouse.text withFont:labelTouse.font];
        labelTouse.frame = newRect;
        
    }
    
}

-(void)SetUpViewBackgroundColor:(NSArray *)viewArray {
    
    for (NSDictionary *dictToUse in viewArray) {
        
        UISwitch *viewToUse = dictToUse[@"View"] ? dictToUse[@"View"] : [[UIView alloc] init];
        
        viewToUse.backgroundColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ?
        [[[LightDarkModeObject alloc] init] DarkModeTertiary] :
        [[[LightDarkModeObject alloc] init] LightModeSecondary];
        
    }
    
}

-(void)SetUpTableViews:(NSArray *)viewArray {
    
    for (NSDictionary *dictToUse in viewArray) {
        
        UITableView *tableViewToUse = dictToUse[@"TableView"] ? dictToUse[@"TableView"] : [[UITableView alloc] init];
        
        tableViewToUse.delegate = self;
        tableViewToUse.dataSource = self;
        tableViewToUse.hidden = NO;
        
    }
    
}

#pragma mark - Table View Methods

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    if (tableView == _scheduledSummaryTableView) {
        
        ScheduledSummaryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ScheduledSummaryCell"];
        
        NSString *key =
        _notificationSettings &&
        _notificationSettings[@"ScheduledSummary"] &&
        _notificationSettings[@"ScheduledSummary"][@"Summaries"] &&
        [[_notificationSettings[@"ScheduledSummary"][@"Summaries"] allKeys] count] > indexPath.row ?
        [_notificationSettings[@"ScheduledSummary"][@"Summaries"] allKeys][indexPath.row] : @"";
        
        cell.scheduledSummaryLabel.text = key;
        
        cell.scheduledSummaryFrequencyLabel.text =
        _notificationSettings &&
        _notificationSettings[@"ScheduledSummary"] &&
        _notificationSettings[@"ScheduledSummary"][@"Summaries"] &&
        _notificationSettings[@"ScheduledSummary"][@"Summaries"][key] &&
        _notificationSettings[@"ScheduledSummary"][@"Summaries"][key][@"Frequency"] ?
        _notificationSettings[@"ScheduledSummary"][@"Summaries"][key][@"Frequency"] : @"";
        
        cell.scheduledSummaryDayLabel.text =
        _notificationSettings &&
        _notificationSettings[@"ScheduledSummary"] &&
        _notificationSettings[@"ScheduledSummary"][@"Summaries"] &&
        _notificationSettings[@"ScheduledSummary"][@"Summaries"][key] &&
        _notificationSettings[@"ScheduledSummary"][@"Summaries"][key][@"Day"] ?
        _notificationSettings[@"ScheduledSummary"][@"Summaries"][key][@"Day"] : @"";
        
        cell.scheduledSummaryTimeLabel.text =
        _notificationSettings &&
        _notificationSettings[@"ScheduledSummary"] &&
        _notificationSettings[@"ScheduledSummary"][@"Summaries"] &&
        _notificationSettings[@"ScheduledSummary"][@"Summaries"][key] &&
        _notificationSettings[@"ScheduledSummary"][@"Summaries"][key][@"Time"] ?
        _notificationSettings[@"ScheduledSummary"][@"Summaries"][key][@"Time"] : @"";
        
        return cell;
        
    }
    
    OptionsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OptionsCell"];
    
    if (tableView == _taskTypesTableView) {
        
        cell.itemOptionLeftLabel.text = [taskTypesArray count] > indexPath.row ? taskTypesArray[indexPath.row] : @"";
        
        BOOL OptionIsSelected = itemSelectedDict && itemSelectedDict[@"ItemTaskTypes"] && taskTypesArray && [taskTypesArray count] > indexPath.row ? [itemSelectedDict[@"ItemTaskTypes"] containsObject:taskTypesArray[indexPath.row]] : NO;
        cell.checkMarkImage.image = OptionIsSelected == YES ? [UIImage systemImageNamed:@"checkmark"] : nil;
        
        return cell;
        
    } else if (tableView == _dueDatesTableView) {
        
        cell.itemOptionLeftLabel.text = [dueDatesArray count] > indexPath.row ? dueDatesArray[indexPath.row] : @"";
        
        BOOL OptionIsSelected = itemSelectedDict && itemSelectedDict[@"DueDates"] && dueDatesArray && [dueDatesArray count] > indexPath.row ? [itemSelectedDict[@"DueDates"] containsObject:dueDatesArray[indexPath.row]] : NO;
        cell.checkMarkImage.image = OptionIsSelected == YES ? [UIImage systemImageNamed:@"checkmark"] : nil;
        
        return cell;
        
    } else if (tableView == _priorityTableView) {
        
        cell.itemOptionLeftLabel.text = [priorityArray count] > indexPath.row ? priorityArray[indexPath.row] : @"";
        
        BOOL OptionIsSelected = itemSelectedDict && itemSelectedDict[@"Priority"] && priorityArray && [priorityArray count] > indexPath.row ? [itemSelectedDict[@"Priority"] containsObject:priorityArray[indexPath.row]] : NO;
        cell.checkMarkImage.image = OptionIsSelected == YES ? [UIImage systemImageNamed:@"checkmark"] : nil;
        
        return cell;
        
    } else if (tableView == _colorTableView) {
        
        cell.itemOptionLeftLabel.text = [colorArray count] > indexPath.row ? colorArray[indexPath.row] : @"";
        
        BOOL OptionIsSelected = itemSelectedDict && itemSelectedDict[@"Color"] && colorArray && [colorArray count] > indexPath.row ? [itemSelectedDict[@"Color"] containsObject:colorArray[indexPath.row]] : NO;
        cell.checkMarkImage.image = OptionIsSelected == YES ? [UIImage systemImageNamed:@"checkmark"] : nil;
        
        return cell;
        
    } else if (tableView == _tagsTableView) {
        
        cell.itemOptionLeftLabel.text = [tagsArray count] > indexPath.row ? tagsArray[indexPath.row] : @"";
        
        BOOL OptionIsSelected = itemSelectedDict && itemSelectedDict[@"Tags"] && tagsArray && [tagsArray count] > indexPath.row ? [itemSelectedDict[@"Tags"] containsObject:tagsArray[indexPath.row]] : NO;
        cell.checkMarkImage.image = OptionIsSelected == YES ? [UIImage systemImageNamed:@"checkmark"] : nil;
        
        return cell;
        
    } else if (tableView == _assignedToTableView) {
        
        cell.itemOptionLeftLabel.text = [assignedToArray count] > indexPath.row ? assignedToArray[indexPath.row] : @"";
        
        BOOL OptionIsSelected = itemSelectedDict && itemSelectedDict[@"AssignedTo"] && assignedToIDArray && [assignedToIDArray count] > indexPath.row ? [itemSelectedDict[@"AssignedTo"] containsObject:assignedToIDArray[indexPath.row]] : NO;
        cell.checkMarkImage.image = OptionIsSelected == YES ? [UIImage systemImageNamed:@"checkmark"] : nil;
       
        return cell;
        
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == _scheduledSummaryTableView) {
        
        if (_notificationSettings[@"ScheduledSummary"] && _notificationSettings[@"ScheduledSummary"][@"Summaries"] && [[_notificationSettings[@"ScheduledSummary"][@"Summaries"] allKeys] count]) {
            
            return [[_notificationSettings[@"ScheduledSummary"][@"Summaries"] allKeys] count];
            
        }
        
    } else if (tableView == _taskTypesTableView) {
        
        return taskTypesArray.count;
        
    } else if (tableView == _dueDatesTableView) {
        
        return dueDatesArray.count;
        
    } else if (tableView == _priorityTableView) {
        
        return priorityArray.count;
        
    } else if (tableView == _colorTableView) {
        
        return colorArray.count;
        
    } else if (tableView == _tagsTableView) {
        
        return tagsArray.count;
        
    } else if (tableView == _assignedToTableView) {
        
        return assignedToArray.count;
        
    }
    
    return 0;
    
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(OptionsCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == _scheduledSummaryTableView) {
        
        ScheduledSummaryCell *cell1 = (ScheduledSummaryCell *)cell;
        
        CGFloat height = CGRectGetHeight(cell1.contentView.bounds);
        CGFloat width = CGRectGetWidth(cell1.contentView.bounds);
        
        CGFloat cornerRadius = (self.view.frame.size.height*0.2181818182 > 12?12:(self.view.frame.size.height*0.2181818182));
        
        cell1.mainView.frame = CGRectMake(0, 0, width, height);
        
        if (indexPath.row == 0) {
            [[[GeneralObject alloc] init] RoundingCorners:cell1.mainView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
        }
        
        CGFloat sizeOfString = [[[GeneralObject alloc] init] WidthOfString:[NSString stringWithFormat:@"%@", cell1.scheduledSummaryLabel.text] withFont:cell1.scheduledSummaryLabel.font];
        
        cell1.scheduledSummaryLabel.frame = CGRectMake(self.view.frame.size.width*0.04830918, (self.view.frame.size.height*0.0108695 > 8?(8):self.view.frame.size.height*0.0108695), sizeOfString, (self.view.frame.size.height*0.04347826 > 32?(32):self.view.frame.size.height*0.04347826));
        
        sizeOfString = [[[GeneralObject alloc] init] WidthOfString:[NSString stringWithFormat:@"  %@  ", cell1.scheduledSummaryFrequencyLabel.text] withFont:cell1.scheduledSummaryFrequencyLabel.font];
        
        cell1.scheduledSummaryFrequencyLabel.frame = CGRectMake(self.view.frame.size.width*0.04830918, cell1.scheduledSummaryLabel.frame.origin.y + cell1.scheduledSummaryLabel.frame.size.height + (self.view.frame.size.height*0.0108695 > 8?(8):self.view.frame.size.height*0.0108695), sizeOfString, (self.view.frame.size.height*0.04347826 > 32?(32):self.view.frame.size.height*0.04347826));
        
        sizeOfString = [[[GeneralObject alloc] init] WidthOfString:[NSString stringWithFormat:@"  %@  ", cell1.scheduledSummaryDayLabel.text] withFont:cell1.scheduledSummaryDayLabel.font];
        
        cell1.scheduledSummaryDayLabel.frame = CGRectMake(cell1.scheduledSummaryFrequencyLabel.frame.origin.x + cell1.scheduledSummaryFrequencyLabel.frame.size.width + (self.view.frame.size.height*0.0108695 > 8?(8):self.view.frame.size.height*0.0108695), cell1.scheduledSummaryFrequencyLabel.frame.origin.y, sizeOfString, (self.view.frame.size.height*0.04347826 > 32?(32):self.view.frame.size.height*0.04347826));
        
        sizeOfString = [[[GeneralObject alloc] init] WidthOfString:[NSString stringWithFormat:@"  %@  ", cell1.scheduledSummaryTimeLabel.text] withFont:cell1.scheduledSummaryTimeLabel.font];
        
        UIView *viewToUse = cell1.scheduledSummaryDayLabel.text.length > 0 ? cell1.scheduledSummaryDayLabel : cell1.scheduledSummaryFrequencyLabel;
        cell1.scheduledSummaryTimeLabel.frame = CGRectMake(viewToUse.frame.origin.x + viewToUse.frame.size.width + (self.view.frame.size.height*0.0108695 > 8?(8):self.view.frame.size.height*0.0108695), cell1.scheduledSummaryFrequencyLabel.frame.origin.y, sizeOfString, (self.view.frame.size.height*0.04347826 > 32?(32):self.view.frame.size.height*0.04347826));
        
        cell1.scheduledSummaryFrequencyLabel.userInteractionEnabled = YES;
        cell1.scheduledSummaryFrequencyLabel.tag = indexPath.row;
        [cell1.scheduledSummaryFrequencyLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ScheduledSummaryFrequencyTapGesture:)]];
        
        cell1.scheduledSummaryDayLabel.userInteractionEnabled = YES;
        cell1.scheduledSummaryDayLabel.tag = indexPath.row;
        [cell1.scheduledSummaryDayLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ScheduledSummaryDaysTapGesture:)]];
        
        cell1.scheduledSummaryTimeLabel.userInteractionEnabled = YES;
        cell1.scheduledSummaryTimeLabel.tag = indexPath.row;
        
        if (cell1.scheduledSummaryDayLabel.text.length == 0) {
            cell1.scheduledSummaryDayLabel.hidden = YES;
        } else {
            cell1.scheduledSummaryDayLabel.hidden = NO;
        }
        
        viewToUse = cell1.scheduledSummaryTimeLabel;
        int tagToUse = (int)indexPath.row;
        cell1.scheduledSummaryTimeLabel.tag = tagToUse;
        [viewToUse addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGesturePickerView:)]];
        
    } else {
       
        CGFloat height = CGRectGetHeight(cell.contentView.bounds);
        CGFloat width = CGRectGetWidth(cell.contentView.bounds);
        
        cell.itemOptionLeftLabel.font = [UIFont systemFontOfSize:(self.view.frame.size.height*0.02173813 > 16?16:(self.view.frame.size.height*0.02173813)) weight:UIFontWeightRegular];
        cell.itemOptionLeftLabel.frame = CGRectMake(width*0.04830918, height*0, width*0.89304813, height);
        
        cell.checkMarkImage.frame = CGRectMake(width - (height*0.5) - width*0.04830918, height*0.5 - (((height*0.5)*0.5)), height*0.5, height*0.5);
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == _scheduledSummaryTableView) {
        
    } else {
        
        NSMutableDictionary *notificationSettingsCopy = self->_notificationSettings ? [self->_notificationSettings mutableCopy] : [NSMutableDictionary dictionary];
        NSMutableDictionary *scheduledSummaryDict = notificationSettingsCopy[@"ScheduledSummary"] ? [notificationSettingsCopy[@"ScheduledSummary"] mutableCopy] : [NSMutableDictionary dictionary];
        NSMutableDictionary *taskTypesDict = scheduledSummaryDict[@"TaskTypes"] ? [scheduledSummaryDict[@"TaskTypes"] mutableCopy] : [NSMutableDictionary dictionary];
        NSString *touchEvent = @"";
        
        if (tableView == _taskTypesTableView) {
            
            NSMutableArray *arr = taskTypesDict[@"ItemTaskTypes"] ? [taskTypesDict[@"ItemTaskTypes"] mutableCopy] : [NSMutableArray array];
            
            if ([taskTypesArray count] > indexPath.row) {
                
                if ([arr containsObject:taskTypesArray[indexPath.row]] == NO) {
                    touchEvent = [NSString stringWithFormat:@"%@ Task Type Selected", taskTypesArray[indexPath.row]];
                    [arr addObject:taskTypesArray[indexPath.row]];
                } else {
                    touchEvent = [NSString stringWithFormat:@"%@ Task Type Unselected", taskTypesArray[indexPath.row]];
                    [arr removeObject:taskTypesArray[indexPath.row]];
                }
                
            }
            
            [taskTypesDict setObject:arr forKey:@"ItemTaskTypes"];
            [scheduledSummaryDict setObject:taskTypesDict forKey:@"TaskTypes"];
        
        } else if (tableView == _dueDatesTableView) {
            
            NSMutableArray *arr = taskTypesDict[@"DueDates"] ? [taskTypesDict[@"DueDates"] mutableCopy] : [NSMutableArray array];
            
            if ([dueDatesArray count] > indexPath.row) {
                
                if ([arr containsObject:dueDatesArray[indexPath.row]] == NO) {
                    touchEvent = [NSString stringWithFormat:@"%@ Due Date Selected", dueDatesArray[indexPath.row]];
                    [arr addObject:dueDatesArray[indexPath.row]];
                } else {
                    touchEvent = [NSString stringWithFormat:@"%@ Due Date Unselected", dueDatesArray[indexPath.row]];
                    [arr removeObject:dueDatesArray[indexPath.row]];
                }
                
            }
            
            [taskTypesDict setObject:arr forKey:@"DueDates"];
            [scheduledSummaryDict setObject:taskTypesDict forKey:@"TaskTypes"];
        
        } else if (tableView == _priorityTableView) {
            
            NSMutableArray *arr = taskTypesDict[@"Priority"] ? [taskTypesDict[@"Priority"] mutableCopy] : [NSMutableArray array];
            
            if ([priorityArray count] > indexPath.row) {
                
                if ([arr containsObject:priorityArray[indexPath.row]] == NO) {
                    touchEvent = [NSString stringWithFormat:@"%@ Priority Selected", priorityArray[indexPath.row]];
                    [arr addObject:priorityArray[indexPath.row]];
                } else {
                    touchEvent = [NSString stringWithFormat:@"%@ Priority Unselected", priorityArray[indexPath.row]];
                    [arr removeObject:priorityArray[indexPath.row]];
                }
                
            }
            
            [taskTypesDict setObject:arr forKey:@"Priority"];
            [scheduledSummaryDict setObject:taskTypesDict forKey:@"TaskTypes"];
       
        } else if (tableView == _colorTableView) {
            
            NSMutableArray *arr = taskTypesDict[@"Color"] ? [taskTypesDict[@"Color"] mutableCopy] : [NSMutableArray array];
            
            if ([colorArray count] > indexPath.row) {
                
                if ([arr containsObject:colorArray[indexPath.row]] == NO) {
                    touchEvent = [NSString stringWithFormat:@"%@ Color Selected", colorArray[indexPath.row]];
                    [arr addObject:colorArray[indexPath.row]];
                } else {
                    touchEvent = [NSString stringWithFormat:@"%@ Color Unselected", colorArray[indexPath.row]];
                    [arr removeObject:colorArray[indexPath.row]];
                }
                
            }
            
            [taskTypesDict setObject:arr forKey:@"Color"];
            [scheduledSummaryDict setObject:taskTypesDict forKey:@"TaskTypes"];
       
        } else if (tableView == _tagsTableView) {
            
            NSMutableArray *arr = taskTypesDict[@"Tags"] ? [taskTypesDict[@"Tags"] mutableCopy] : [NSMutableArray array];
            
            if ([tagsArray count] > indexPath.row) {
                
                if ([arr containsObject:tagsArray[indexPath.row]] == NO) {
                    touchEvent = [NSString stringWithFormat:@"%@ Tag Selected", tagsArray[indexPath.row]];
                    [arr addObject:tagsArray[indexPath.row]];
                } else {
                    touchEvent = [NSString stringWithFormat:@"%@ Tag Unselected", tagsArray[indexPath.row]];
                    [arr removeObject:tagsArray[indexPath.row]];
                }
                
            }
            
            [taskTypesDict setObject:arr forKey:@"Tags"];
            [scheduledSummaryDict setObject:taskTypesDict forKey:@"TaskTypes"];
        
        } else if (tableView == _assignedToTableView) {
            
            NSMutableArray *arr = taskTypesDict[@"AssignedTo"] ? [taskTypesDict[@"AssignedTo"] mutableCopy] : [NSMutableArray array];
            
            if ([assignedToIDArray count] > indexPath.row) {
                
                if ([arr containsObject:assignedToIDArray[indexPath.row]] == NO) {
                    touchEvent = [NSString stringWithFormat:@"%@ Assigned To Selected", assignedToIDArray[indexPath.row]];
                    [arr addObject:assignedToIDArray[indexPath.row]];
                } else {
                    touchEvent = [NSString stringWithFormat:@"%@ Assigned To Unselected", assignedToIDArray[indexPath.row]];
                    [arr removeObject:assignedToIDArray[indexPath.row]];
                }
                
            }
            
            [taskTypesDict setObject:arr forKey:@"AssignedTo"];
            [scheduledSummaryDict setObject:taskTypesDict forKey:@"TaskTypes"];
        
        }
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:touchEvent completionHandler:^(BOOL finished) {
            
        }];
        
        [notificationSettingsCopy setObject:scheduledSummaryDict forKey:@"ScheduledSummary"];
        
        _notificationSettings = [notificationSettingsCopy mutableCopy];
        
        if (_notificationSettings[@"ScheduledSummary"] && _notificationSettings[@"ScheduledSummary"][@"TaskTypes"] && _notificationSettings[@"ScheduledSummary"][@"TaskTypes"][@"ItemTaskTypes"]) {
            [itemSelectedDict setObject:_notificationSettings[@"ScheduledSummary"][@"TaskTypes"][@"ItemTaskTypes"] forKey:@"ItemTaskTypes"];
        } else {
            [itemSelectedDict setObject:[NSMutableArray array] forKey:@"ItemTaskTypes"];
        }
        if (_notificationSettings[@"ScheduledSummary"] && _notificationSettings[@"ScheduledSummary"][@"TaskTypes"] && _notificationSettings[@"ScheduledSummary"][@"TaskTypes"][@"DueDates"]) {
            [itemSelectedDict setObject:_notificationSettings[@"ScheduledSummary"][@"TaskTypes"][@"DueDates"] forKey:@"DueDates"];
        } else {
            [itemSelectedDict setObject:[NSMutableArray array] forKey:@"DueDates"];
        }
        if (_notificationSettings[@"ScheduledSummary"] && _notificationSettings[@"ScheduledSummary"][@"TaskTypes"] && _notificationSettings[@"ScheduledSummary"][@"TaskTypes"][@"Priority"]) {
            [itemSelectedDict setObject:_notificationSettings[@"ScheduledSummary"][@"TaskTypes"][@"Priority"] forKey:@"Priority"];
        } else {
            [itemSelectedDict setObject:[NSMutableArray array] forKey:@"Priority"];
        }
        if (_notificationSettings[@"ScheduledSummary"] && _notificationSettings[@"ScheduledSummary"][@"TaskTypes"] && _notificationSettings[@"ScheduledSummary"][@"TaskTypes"][@"Color"]) {
            [itemSelectedDict setObject:_notificationSettings[@"ScheduledSummary"][@"TaskTypes"][@"Color"] forKey:@"Color"];
        } else {
            [itemSelectedDict setObject:[NSMutableArray array] forKey:@"Color"];
        }
        if (_notificationSettings[@"ScheduledSummary"] && _notificationSettings[@"ScheduledSummary"][@"TaskTypes"] && _notificationSettings[@"ScheduledSummary"][@"TaskTypes"][@"Tags"]) {
            [itemSelectedDict setObject:_notificationSettings[@"ScheduledSummary"][@"TaskTypes"][@"Tags"] forKey:@"Tags"];
        } else {
            [itemSelectedDict setObject:[NSMutableArray array] forKey:@"Tags"];
        }
        if (_notificationSettings[@"ScheduledSummary"] && _notificationSettings[@"ScheduledSummary"][@"TaskTypes"] && _notificationSettings[@"ScheduledSummary"][@"TaskTypes"][@"AssignedTo"]) {
            [itemSelectedDict setObject:_notificationSettings[@"ScheduledSummary"][@"TaskTypes"][@"AssignedTo"] forKey:@"AssignedTo"];
        } else {
            [itemSelectedDict setObject:[NSMutableArray array] forKey:@"AssignedTo"];
        }
     
        [tableView reloadData];
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == _scheduledSummaryTableView) {
        
        return (self.view.frame.size.height*0.11956522 > 88?(88):self.view.frame.size.height*0.11956522);
        
    }
    
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    return (height*0.0679 > 50?(50):height*0.0679);
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

-(UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UIContextualAction *RemoveAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:nil handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Remove Item"] completionHandler:^(BOOL finished) {
            
        }];
        
        NSMutableDictionary *notificationSettingsCopy = self->_notificationSettings ? [self->_notificationSettings mutableCopy] : [NSMutableDictionary dictionary];
        NSMutableDictionary *dict = notificationSettingsCopy[@"ScheduledSummary"] ? [notificationSettingsCopy[@"ScheduledSummary"] mutableCopy] : [NSMutableDictionary dictionary];
        NSMutableDictionary *summariesDict = dict[@"Summaries"] ? [dict[@"Summaries"] mutableCopy] : [NSMutableDictionary dictionary];
        NSString *key = [[summariesDict allKeys] count] > indexPath.row ? [summariesDict allKeys][indexPath.row] : @"";
        
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Are you sure you would like to delete \"%@\"?", key] message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Removing Item"] completionHandler:^(BOOL finished) {
                
            }];
            
            if ([[summariesDict allKeys] containsObject:key]) {
                [summariesDict removeObjectForKey:key];
            }
            [dict setObject:summariesDict forKey:@"Summaries"];
            [notificationSettingsCopy setObject:dict forKey:@"ScheduledSummary"];
            
            self->_notificationSettings = [notificationSettingsCopy mutableCopy];
            
            [self ScheduleSummarySetUp:NO];
            
        }]];
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Remove Item Cancelled"] completionHandler:^(BOOL finished) {
                
            }];
            
        }]];
        
        [self presentViewController:actionSheet animated:YES completion:nil];
        
    }];
    
    UIContextualAction *EditAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:nil handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Edit Item"] completionHandler:^(BOOL finished) {
            
        }];
        
        NSMutableDictionary *notificationSettingsCopy = self->_notificationSettings ? [self->_notificationSettings mutableCopy] : [NSMutableDictionary dictionary];
        NSMutableDictionary *dict = notificationSettingsCopy[@"ScheduledSummary"] ? [notificationSettingsCopy[@"ScheduledSummary"] mutableCopy] : [NSMutableDictionary dictionary];
        NSMutableDictionary *summariesDict = dict[@"Summaries"] ? [dict[@"Summaries"] mutableCopy] : [NSMutableDictionary dictionary];
        NSString *key = [[summariesDict allKeys] count] > indexPath.row ? [summariesDict allKeys][indexPath.row] : @"";
        NSDictionary *currentSummaryDict = summariesDict[key] ? [summariesDict[key] mutableCopy] : [NSDictionary dictionary];
        
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Give your summary a name" message:nil
                                                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Add"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * _Nonnull action) {
            
            NSString *userEmail = controller.textFields[0].text;
            
            if ([userEmail isEqualToString:@""]) {
                
                [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You forgot to enter a name" currentViewController:self];
                
            } else {
                
                if ([[summariesDict allKeys] containsObject:key]) {
                    [summariesDict removeObjectForKey:key];
                }
                
                [summariesDict setObject:@{@"Name" : userEmail, @"Frequency" : currentSummaryDict[@"Frequency"], @"Day" : currentSummaryDict[@"Day"], @"Time" : currentSummaryDict[@"Time"]} forKey:userEmail];
                [dict setObject:summariesDict forKey:@"Summaries"];
                [notificationSettingsCopy setObject:dict forKey:@"ScheduledSummary"];
                
                self->_notificationSettings = [notificationSettingsCopy mutableCopy];
                
                [self ScheduleSummarySetUp:NO];
                [self.scheduledSummaryTableView reloadData];
                
            }
            
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                         style:UIAlertActionStyleCancel
                                                       handler:^(UIAlertAction * _Nonnull action) {}];
        
        
        
        [controller addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            
            textField.delegate = self;
            textField.placeholder = @"Schedule Summary Name";
            textField.text = key;
            textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
            
        }];
        
        [controller addAction:action1];
        [controller addAction:cancel];
        [self presentViewController:controller animated:YES completion:nil];
        
    }];
    
    RemoveAction.image = [UIImage systemImageNamed:@"xmark"];
    RemoveAction.backgroundColor = [UIColor systemRedColor];
    
    EditAction.image = [UIImage systemImageNamed:@"pencil"];
    EditAction.backgroundColor = [UIColor systemBlueColor];
    
    NSArray *actionsArray = @[RemoveAction, EditAction];
    
    //right to left
    return [UISwipeActionsConfiguration configurationWithActions:actionsArray];
    
}

#pragma mark - NSNotifications

-(void)NSNotification_NotificationSettings_Sound:(NSNotification *)notification {
    
    NSDictionary *userInfo = notification.userInfo;
    NSString *sound = userInfo[@"Sound"] ? userInfo[@"Sound"] : @"Default";
    
    soundsSubLabelNo2.text = sound;
    
    NSMutableDictionary *dict = _notificationSettings ? [_notificationSettings mutableCopy] : [NSMutableDictionary dictionary];
    [dict setObject:sound forKey:@"Sound"];
    _notificationSettings = [dict mutableCopy];
    
}

-(void)NSNotification_NotificationSettings_ScheduledSummaryFrequency:(NSNotification *)notification {
    
    NSDictionary *userInfo = notification.userInfo;
    NSString *newFrequency = userInfo[@"Frequency"] ? [userInfo[@"Frequency"] mutableCopy] : @"Daily";
    
    NSString *selectedSummary = [[[NSUserDefaults standardUserDefaults] objectForKey:@"SelectedSummary"] mutableCopy];
    
    NSMutableDictionary *notificationDictCopy = _notificationSettings ? [_notificationSettings mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *dict = notificationDictCopy[@"ScheduledSummary"] ? [notificationDictCopy[@"ScheduledSummary"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *summariesDict = dict[@"Summaries"] ? [dict[@"Summaries"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *selectedSummaryDict = summariesDict[selectedSummary] ? [summariesDict[selectedSummary] mutableCopy] : [NSMutableDictionary dictionary];
    
    NSString *previousFrequency = selectedSummaryDict && selectedSummaryDict[@"Frequency"] ? [selectedSummaryDict[@"Frequency"] mutableCopy] : @"";
    
    [selectedSummaryDict setObject:newFrequency forKey:@"Frequency"];
    
    if ([newFrequency containsString:@"Day"] || [newFrequency containsString:@"Daily"]) {
        
        [selectedSummaryDict setObject:@"" forKey:@"Day"];
        
    } else if (
               (([previousFrequency containsString:@"Day"] || [previousFrequency containsString:@"Daily"]) && ([newFrequency containsString:@"Day"] || [newFrequency containsString:@"Daily"]) == NO) ||
               ([previousFrequency containsString:@"Week"] && [newFrequency containsString:@"Week"]) == NO ||
               ([previousFrequency containsString:@"Month"] && [newFrequency containsString:@"Month"]) == NO) {
                   
                   NSString *newDay = @"";
                   
                   if ([newFrequency containsString:@"Week"]) {
                       newDay = @"Sunday";
                   } else if ([newFrequency containsString:@"Month"]) {
                       newDay = @"1st";
                   }
                   
                   [selectedSummaryDict setObject:newDay forKey:@"Day"];
                   
               }
    
    [summariesDict setObject:selectedSummaryDict forKey:selectedSummary];
    [dict setObject:summariesDict forKey:@"Summaries"];
    [notificationDictCopy setObject:dict forKey:@"ScheduledSummary"];
    
    _notificationSettings = [notificationDictCopy mutableCopy];
    
    [self.scheduledSummaryTableView reloadData];
    
}

-(void)NSNotification_NotificationSettings_ScheduledSummaryDays:(NSNotification *)notification {
    
    NSDictionary *userInfo = notification.userInfo;
    NSString *newDay = userInfo[@"Days"] && [(NSArray *)userInfo[@"Days"] count] > 0 ? userInfo[@"Days"][0] : @"Sunday";
    
    NSString *selectedSummary = [[[NSUserDefaults standardUserDefaults] objectForKey:@"SelectedSummary"] mutableCopy];
    
    NSMutableDictionary *notificationDictCopy = _notificationSettings ? [_notificationSettings mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *dict = notificationDictCopy[@"ScheduledSummary"] ? [notificationDictCopy[@"ScheduledSummary"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *summariesDict = dict[@"Summaries"] ? [dict[@"Summaries"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *selectedSummaryDict = summariesDict[selectedSummary] ? [summariesDict[selectedSummary] mutableCopy] : [NSMutableDictionary dictionary];
    
    [selectedSummaryDict setObject:newDay forKey:@"Day"];
    [summariesDict setObject:selectedSummaryDict forKey:selectedSummary];
    [dict setObject:summariesDict forKey:@"Summaries"];
    [notificationDictCopy setObject:dict forKey:@"ScheduledSummary"];
    
    _notificationSettings = [notificationDictCopy mutableCopy];
    
    [self.scheduledSummaryTableView reloadData];
    
}

-(void)NSNotification_NotificationSettings_NotificationSettings:(NSNotification *)notification {
    
    NSDictionary *userInfo = notification.userInfo;
    
    NSMutableDictionary *notificationSettings = userInfo[@"NotificationSettings"] ? userInfo[@"NotificationSettings"] : [NSMutableDictionary dictionary];
  
    _notificationSettings = [notificationSettings mutableCopy];
    
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
