//
//  ViewCalendarViewController.m
//  WeDivvy
//
//  Created by Philip Nagel on 9/25/22.
//

#import "UIImageView+Letters.h"

#import "ViewCalendarViewController.h"
#import "CalendarCell.h"
#import "MainCell.h"

#import "GeneralObject.h"
#import "GetDataObject.h"
#import "SetDataObject.h"
#import "PushObject.h"
#import "NotificationsObject.h"
#import "BoolDataObject.h"
#import "CompleteUncompleteObject.h"
#import "LightDarkModeObject.h"

@interface ViewCalendarViewController () {
    
    MRProgressOverlayView *progressView;
    
    UIView *monthAndYearView;
    
    UIView *monthView;
    UILabel *monthViewLabel;
    UIImageView *monthViewLeftImageView;
    UIImageView *monthViewRightImageView;
    
    UIButton *monthViewLeftImageViewCover;
    UIButton *monthViewRightImageViewCover;
    UIButton *calendarSettingsCover;
    
    NSArray *daysArray;
    NSMutableArray *colorsArray;
    NSMutableDictionary *eventDict;
    
    NSDictionary *selectedDay;
    NSString *startingDay;
    
    int firstRowCellHeight;
    int cellWidth;
    int cellHeight;
    int cellSpacing;
    
    NSMutableDictionary *premiumPlanPricesDict;
    NSMutableDictionary *premiumPlanExpensivePricesDict;
    NSMutableDictionary *premiumPlanPricesDiscountDict;
    NSMutableDictionary *premiumPlanPricesNoFreeTrialDict;
    NSMutableArray *premiumPlanProductsArray;
    
}

@end

@implementation ViewCalendarViewController

#pragma mark - System Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self FetchAvailableProducts];
        
    });
    
    [self GenerateUpdatedItemDicts];
    
    [self InitMethod];

    [self BarButtonItems];

    [self TapGestures];

    [self NSNotificatinObservers];

}

-(void)viewWillAppear:(BOOL)animated {
    
    monthView.hidden = NO;
    
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        self.view.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [[[LightDarkModeObject alloc] init] DarkModeTextPrimary]};
        
        [self preferredStatusBarStyle];
        
        self.navigationController.navigationBar.backgroundColor = self.view.backgroundColor;
        
        self.lineView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        self.customTableView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModePrimary];
        self.customCollectionView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        self.coverView.backgroundColor = self.customTableView.backgroundColor;
        self.emptyTableViewBodyLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        self.emptyTableViewTitleLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextSecondary];
        
    } else {
        
        self.navigationController.navigationBar.backgroundColor = self.view.backgroundColor;
        self.customTableView.backgroundColor = [[[LightDarkModeObject alloc] init] LightModePrimary];
        self.coverView.backgroundColor = self.customTableView.backgroundColor;
        self.view.backgroundColor = self.customTableView.backgroundColor;
        
    }
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    CGFloat navigationBarHeight = [[[GeneralObject alloc] init] GetNavigationBarHeight:self];
    CGFloat bottomPadding = [[[GeneralObject alloc] init] GetBottomPaddingHeight];
    
    _notificationReminderView.frame = CGRectMake(0, 0, width, navigationBarHeight);
    
    _addTaskButton.frame = CGRectMake(width*0.5 - ((width*0.133)*0.5), height - (width*0.133) - bottomPadding - 8, (width*0.133), (width*0.133));
    _addTaskButtonImage.frame = CGRectMake(_addTaskButton.frame.origin.x + (_addTaskButton.frame.size.width*0.5 - ((_addTaskButton.frame.size.width*0.412)*0.5)), _addTaskButton.frame.origin.y + (_addTaskButton.frame.size.height*0.5 - ((_addTaskButton.frame.size.width*0.412)*0.5)), (_addTaskButton.frame.size.width*0.412), (_addTaskButton.frame.size.width*0.412));
    
    _addTaskButton.layer.borderWidth = 0.0;
    _addTaskButton.layer.shadowColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeShadow].CGColor : [[[LightDarkModeObject alloc] init] LightModeShadow].CGColor;
    _addTaskButton.layer.shadowRadius = 3;
    _addTaskButton.layer.shadowOpacity = 1.0;
    _addTaskButton.layer.shadowOffset = CGSizeMake(0, 0);
    _addTaskButton.layer.cornerRadius = _addTaskButton.frame.size.height/2;
    
    CAGradientLayer *viewLayer = [CAGradientLayer layer];
    viewLayer = [CAGradientLayer layer];
    [viewLayer setFrame:_addTaskButton.bounds];
    [_addTaskButton.layer insertSublayer:viewLayer atIndex:0];
    [_addTaskButton.layer addSublayer:viewLayer];
    
    _addTaskButton.backgroundColor = [[[GeneralObject alloc] init] GenerateAppColor:1.0f];
    
    
    
    NSDictionary *dict = [self GenerateCurrentLabelMonthAndYearDict];
    NSString *currentMonth = dict[@"Month"];
    NSString *numberOfDaysInCurrentMonth = [[[GeneralObject alloc] init] GetMonthNumberInYear:currentMonth];
    float amountOfDaysInCollectionView = [[[NotificationsObject alloc] init] GetMonthDayAmountFromMonthNumber:[numberOfDaysInCurrentMonth intValue]] + 7 + [[self GenerateStringToDay:startingDay] intValue];
    
    int numberOfRows = ceil((amountOfDaysInCollectionView/7));
    
    cellSpacing = 0;
    firstRowCellHeight = (width*0.06038647 > 25?(25):width*0.06038647);
    cellWidth = (width*0.1401 > 58?(58):width*0.1401);
    cellHeight = (height - navigationBarHeight - (height - _addTaskButton.frame.origin.y) - firstRowCellHeight - cellSpacing) / (numberOfRows-1);
   
    CGRect newRect = _customCollectionView.frame;
    newRect.size.width = self.view.frame.size.width - 5;
    newRect.origin.x = self.view.frame.size.width*0.5 - newRect.size.width*0.5;
    newRect.origin.y = navigationBarHeight;
    newRect.size.height = 10000;
    _customCollectionView.frame = newRect;
    
    newRect = _lineView.frame;
    newRect.origin.x = 0;
    newRect.origin.y = 10000;
    newRect.size.width = width;
    newRect.size.height = 1;
    _lineView.frame = newRect;
    
    newRect = _customTableView.frame;
    newRect.origin.y = _lineView.frame.origin.y + _lineView.frame.size.height;
    newRect.size.height = (height - newRect.origin.y);
    newRect.size.width = width;
    _customTableView.frame = newRect;
  
    _emptyTableViewView.alpha = 0.0f;
    _customTableView.alpha = 0.0f;
    
    newRect = _coverView.frame;
    newRect.origin.x = 0;
    newRect.origin.y = _customTableView.frame.origin.y + _customTableView.frame.size.height;
    newRect.size.height = 1000;
    newRect.size.width = width;
    _coverView.frame = newRect;
    
    
    
    _emptyTableViewView.frame = CGRectMake(0, 0, width, height*0.5);
    
    
    
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
    newRect.origin.y = self.view.frame.size.height*0.5 - newRect.size.height*0.5;
    _emptyTableViewView.frame = newRect;
    
    
}

-(void)viewWillDisappear:(BOOL)animated {
    
    monthView.hidden = YES;
    
}

-(BOOL)prefersStatusBarHidden {
    
    return YES;
}

#pragma mark - Init Methods

-(void)InitMethod {
    
    [self SetUpAnalytics];
    
    [self SetUpArrays];
    
    [self SetUpMonthViewLabel];
    
    [self SetUpSelectedDay];
    
    [self SetUpDelegates];
    
    [self SetUpEmptyTableViewView];
    
    [self SetUpAddTaskEllipsisContextMenu];
    
}

-(void)BarButtonItems {
    
    self.navigationItem.hidesBackButton = YES;
    
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(NavigationBackButtonAction:)];
    self.navigationItem.leftBarButtonItem = newBackButton;
    
    UIMenu *ellipsisMenu = [self GenerateItemContextMenu];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"ellipsis"] menu:ellipsisMenu];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
}

-(void)TapGestures {
    
    monthViewLeftImageViewCover.tag = 1;
    [monthViewLeftImageViewCover addTarget:self action:@selector(ArrowTapGesture:) forControlEvents:UIControlEventTouchUpInside];
    
    monthViewRightImageViewCover.tag = 2;
    [monthViewRightImageViewCover addTarget:self action:@selector(ArrowTapGesture:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)NSNotificatinObservers {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_Calendar_MultiAddTask" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_Calendar_MultiAddTask:) name:@"NSNotification_Calendar_MultiAddTask" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_Calendar_AddTask" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_Calendar_AddTask:) name:@"NSNotification_Calendar_AddTask" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_Calendar_EditTask" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_Calendar_EditTask:) name:@"NSNotification_Calendar_EditTask" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_Calendar_DeleteTask" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_Calendar_DeleteTask:) name:@"NSNotification_Calendar_DeleteTask" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_Calendar_AddHomeMember" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_Calendar_AddHomeMember:) name:@"NSNotification_Calendar_AddHomeMember" object:nil];
    
}

#pragma mark - SetUp Methods

-(void)SetUpAnalytics {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewViewController:@"ViewCalendarViewController" completionHandler:^(BOOL finished) {
        
    }];
    
    [[[GeneralObject alloc] init] TrackInMixPanel:@"ViewCalendarViewController"];
    
}

-(void)SetUpArrays {
    
    daysArray = @[@"Sun", @"Mon", @"Tue", @"Wed", @"Thu", @"Fri", @"Sat"];
    colorsArray = [NSMutableArray array];
    eventDict = [NSMutableDictionary dictionary];
    selectedDay = [NSDictionary dictionary];
    
}

-(void)SetUpDelegates {
    
    _customCollectionView.delegate = self;
    _customCollectionView.dataSource = self;
    
    _customTableView.delegate = self;
    _customTableView.dataSource = self;
    
}

-(void)SetUpEmptyTableViewView {
    
    _emptyTableViewView.hidden = YES;
    
    _emptyTableViewImage.image = [UIImage imageNamed:@"EmptyViewIcons.NoChores.png"];
    _emptyTableViewTitleLabel.text = @"Your Chores";
    _emptyTableViewBodyLabel.text = @"Tap the 'plus' button below to\nquickly add some chores to your home.";
    
}

-(void)SetUpMonthViewLabel {
    
    monthView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, self.navigationController.navigationBar.frame.size.height)];
    
    monthViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [[[GeneralObject alloc] init] WidthOfString:@"" withFont:[UIFont systemFontOfSize:(self.view.frame.size.height*0.02173913 > 16?(16):self.view.frame.size.height*0.02173913) weight:UIFontWeightSemibold]], monthView.frame.size.height)];
    monthViewLabel.text = @"";
    monthViewLabel.textColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTextPrimary] : [UIColor colorWithRed:40.0f/255.0f green:48.0f/255.0f blue:58.0f/255.0f alpha:1.0f];
    monthViewLabel.font = [UIFont systemFontOfSize:(self.view.frame.size.height*0.02173913 > 16?(16):self.view.frame.size.height*0.02173913) weight:UIFontWeightSemibold];
    monthViewLabel.textAlignment = NSTextAlignmentCenter;
    monthViewLabel.adjustsFontSizeToFitWidth = YES;
    
    monthViewLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (self.view.frame.size.width*0.02415459 > 10?(10):self.view.frame.size.width*0.02415459), self.navigationController.navigationBar.frame.size.height)];
    monthViewLeftImageView.image = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [UIImage imageNamed:@"AddItemIcon.TextFieldLeftArrow"] : [UIImage imageNamed:@"MultiAddIcons.ChevronLeft"];
    monthViewLeftImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    monthViewRightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, monthViewLeftImageView.frame.size.width, self.navigationController.navigationBar.frame.size.height)];
    monthViewRightImageView.image = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [UIImage imageNamed:@"AddItemIcon.TextFieldRightArrow"] : [UIImage imageNamed:@"MultiAddIcons.ChevronRight"];
    monthViewRightImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    monthViewLeftImageViewCover = [[UIButton alloc] initWithFrame:monthViewLeftImageView.frame];
    monthViewRightImageViewCover = [[UIButton alloc] initWithFrame:monthViewRightImageView.frame];
    
    monthViewLabel.alpha = 0.9;
    monthViewRightImageView.alpha = 0.8;
    monthViewLeftImageView.alpha = 0.8;
    
    UIWindow *currentwindow = [UIApplication sharedApplication].windows.firstObject;
    [monthView addSubview:monthViewLabel];
    [monthView addSubview:monthViewRightImageView];
    [monthView addSubview:monthViewLeftImageView];
    [monthView addSubview:monthViewRightImageViewCover];
    [monthView addSubview:monthViewLeftImageViewCover];
    
    [currentwindow addSubview:monthView];
    
    [self.navigationController.navigationBar addSubview:monthView];
    
    NSDictionary *dict = [self GenerateCurrentDayMonthAndYearDict];
    NSString *monthAndYear = [NSString stringWithFormat:@"%@, %@", dict[@"Month"], dict[@"Year"]];
    
    [self UpdateMonthViewLabel:monthAndYear];
    
}

-(void)SetUpSelectedDay {
    
    NSDictionary *dict = [self GenerateCurrentDayMonthAndYearDict];
    NSString *currentDay = [NSString stringWithFormat:@"%d", [dict[@"Day"] intValue]];
    NSString *currentMonth = dict[@"Month"];
    NSString *currentYear = dict[@"Year"];
    
    selectedDay = @{@"Day" : currentDay, @"Month" : currentMonth, @"Year" : currentYear, @"indexPathItem" : [NSString stringWithFormat:@"%d", 1000]};
    
    startingDay = [self GenerateStartingDay:YES];
    
}

-(void)SetUpAddTaskEllipsisContextMenu {
    
    NSMutableArray* actions = [[NSMutableArray alloc] init];
    
    [actions addObject:[UIAction actionWithTitle:@"Add One Task" image:[UIImage systemImageNamed:@"rectangle"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Single Tasks Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
            
        }];
        
        [self TapGestureAddTask:self];
        
    }]];
    
    [actions addObject:[UIAction actionWithTitle:@"Add Multiple Tasks" image:[UIImage systemImageNamed:@"rectangle.stack"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Multiple Tasks Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
            
        }];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"ShowedMultiAddForTheFirstTime"];
        
        NSMutableArray *itemNamesAlreadyUsed = self->_itemsDict && self->_itemsDict[@"ItemName"] && self->_itemsDict[@"ItemName"] ? [self->_itemsDict[@"ItemName"] mutableCopy] : [NSMutableArray array];
        NSMutableArray *allItemAssignedToArrays = [self GenerateAllItemAssignedToArrays:self->_itemsDict homeMembersDict:self->_homeMembersDict];
        NSMutableArray *allItemTagsArrays = [self GenerateAllItemTagsArrays:self->_itemsDict];
        NSMutableArray *allItemIDsArrays = [self GenerateNumberOfValidTasksInArrayForm];
        
        allItemIDsArrays = [[[GeneralObject alloc] init] RemoveDupliatesFromArray:allItemIDsArrays];
        
        NSString *sectionSelected = [[NSUserDefaults standardUserDefaults] objectForKey:@"CategorySelected"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"CategorySelected"] : @"All";
        BOOL ListSelected = [self->_taskListDict[@"TaskListName"] containsObject:sectionSelected];
        NSString *defaultTaskListName = ListSelected == YES ? sectionSelected : @"No List";
        
        [[[PushObject alloc] init] PushToMultiAddTasksViewController:NO itemDictFromPreviousPage:[NSMutableDictionary dictionary] itemDictKeysFromPreviousPage:[NSMutableDictionary dictionary] itemSelectedDict:[NSMutableDictionary dictionary] homeMembersDict:self->_homeMembersDict notificationSettingsDict:self->_notificationSettingsDict topicDict:self->_topicDict folderDict:self->_folderDict taskListDict:self->_taskListDict templateDict:self->_templateDict draftDict:self->_draftDict homeMembersArray:self->_homeMembersArray itemNamesAlreadyUsed:itemNamesAlreadyUsed allItemAssignedToArrays:allItemAssignedToArrays allItemTagsArrays:allItemTagsArrays defaultTaskListName:defaultTaskListName currentViewController:self Superficial:NO];
        
    }]];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        //Post-Spike
        self->_addTaskButton.menu = [UIMenu menuWithTitle:@"" children:actions];
        self->_addTaskButton.showsMenuAsPrimaryAction = true;
        
        self->_addTaskButtonCover.menu = [UIMenu menuWithTitle:@"" children:actions];
        self->_addTaskButtonCover.showsMenuAsPrimaryAction = true;
        
        self->_addTaskButtonCover.hidden = YES;
        
    });
    
}

#pragma mark - UI Methods

-(void)StartProgressView {
    
    self->progressView = [MRProgressOverlayView showOverlayAddedTo:self.navigationController.view animated:YES];
    self->progressView.mode = MRProgressOverlayViewModeIndeterminateSmall;
    
}

-(void)UpdateMonthViewLabel:(NSString *)monthViewLabelString {
    
    monthViewLabel.text = monthViewLabelString;
    
    CGFloat monthViewWidth = self.view.frame.size.width*0.6;
    
    CGRect newRect;
    
    newRect = monthViewLabel.frame;
    newRect.size.width = [[[GeneralObject alloc] init] WidthOfString:monthViewLabelString withFont:monthViewLabel.font];
    newRect.origin.x = (monthViewWidth)*0.5 - newRect.size.width*0.5;
    monthViewLabel.frame = newRect;
    
    newRect = monthView.frame;
    newRect.size.width = monthViewWidth;
    newRect.origin.x = self.view.frame.size.width*0.5 - (monthViewWidth)*0.5;
    monthView.frame = newRect;
    
    newRect = monthViewRightImageView.frame;
    newRect.origin.x = monthView.frame.size.width - newRect.size.width - (newRect.size.width*5)*0.5;
    monthViewRightImageView.frame = newRect;
    
    newRect = monthViewLeftImageView.frame;
    newRect.origin.x = 0 + (newRect.size.width*5)*0.5;
    monthViewLeftImageView.frame = newRect;
    
    monthViewLeftImageViewCover.frame = monthViewLeftImageView.frame;
    monthViewRightImageViewCover.frame = monthViewRightImageView.frame;
    
    newRect = monthViewLeftImageViewCover.frame;
    newRect.size.width = newRect.size.width*5;
    newRect.origin.x = monthViewLeftImageView.frame.origin.x + (monthViewLeftImageViewCover.frame.size.width*0.5 - newRect.size.width*0.5);
    monthViewLeftImageViewCover.frame = newRect;
    
    newRect = monthViewRightImageViewCover.frame;
    newRect.size.width = newRect.size.width*5;
    newRect.origin.x = monthViewRightImageView.frame.origin.x + (monthViewRightImageViewCover.frame.size.width*0.5 - newRect.size.width*0.5);
    
    monthViewRightImageViewCover.frame = newRect;
}

-(void)UpdateCollectionViewFrame {
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    CGFloat navigationBarHeight = [[[GeneralObject alloc] init] GetNavigationBarHeight:self];
   
    NSDictionary *dict = [self GenerateCurrentLabelMonthAndYearDict];
    NSString *currentMonth = dict[@"Month"];
    NSString *numberOfDaysInCurrentMonth = [[[GeneralObject alloc] init] GetMonthNumberInYear:currentMonth];
    float amountOfDaysInCollectionView = [[[NotificationsObject alloc] init] GetMonthDayAmountFromMonthNumber:[numberOfDaysInCurrentMonth intValue]] + 7 + [[self GenerateStringToDay:startingDay] intValue];
    
    int numberOfRows = ceil((amountOfDaysInCollectionView/7));

    cellSpacing = 0;
    firstRowCellHeight = (width*0.06038647 > 25?(25):width*0.06038647);
    cellWidth = (width*0.1401 > 58?(58):width*0.1401);
    cellHeight = (height - navigationBarHeight - (height - _addTaskButton.frame.origin.y) - firstRowCellHeight - cellSpacing) / (numberOfRows-1);

    CGRect newRect = _customCollectionView.frame;
    newRect.size.height = 1000;
    _customCollectionView.frame = newRect;

    newRect = _lineView.frame;
    newRect.origin.x = 0;
    newRect.origin.y = 10000;
    newRect.size.width = self.view.frame.size.width;
    newRect.size.height = 1;
    _lineView.frame = newRect;

    newRect = _customTableView.frame;
    newRect.origin.y = _lineView.frame.origin.y + _lineView.frame.size.height;
    newRect.size.height = (self.view.frame.size.height - newRect.origin.y) - (height - _addTaskButton.frame.origin.y) - 12;
    _customTableView.frame = newRect;

    newRect = _coverView.frame;
    newRect.origin.x = 0;
    newRect.origin.y = _customTableView.frame.origin.y + _customTableView.frame.size.height;
    newRect.size.height = 1000;
    newRect.size.width = width;
    _coverView.frame = newRect;

    NSString *monthAndYear = [NSString stringWithFormat:@"%@, %@", dict[@"Month"], dict[@"Year"]];

    [self UpdateMonthViewLabel:monthAndYear];
    
}

-(void)AdjustExpandedTableViewFrames:(BOOL)ExpandCollectionView indexPath:(NSIndexPath *)indexPath timeInterval:(NSTimeInterval)timeInterval {
    
    [UIView animateWithDuration:timeInterval animations:^{
        
        CGFloat navigationBarHeight = [[[GeneralObject alloc] init] GetNavigationBarHeight:self];
        
        int numOfRows = (int)(indexPath.item-7)/7;
        
        CGRect newRect = self->_customCollectionView.frame;
        newRect.origin.y = ExpandCollectionView == NO ? navigationBarHeight : navigationBarHeight - self->firstRowCellHeight - self->firstRowCellHeight - self->firstRowCellHeight - (self->cellSpacing*numOfRows) - (self->cellHeight*numOfRows-1);
        self->_customCollectionView.frame = newRect;
        
        newRect = self->_lineView.frame;
        newRect.origin.x = 0;
        newRect.origin.y = ExpandCollectionView == NO ? 10000 : navigationBarHeight + self->cellHeight;
        newRect.size.width = self.view.frame.size.width;
        newRect.size.height = 1;
        self->_lineView.frame = newRect;
        
        newRect = self->_customTableView.frame;
        newRect.origin.y = self->_lineView.frame.origin.y + self->_lineView.frame.size.height;
        newRect.size.height = (self.view.frame.size.height - newRect.origin.y) - (self.view.frame.size.height - self->_addTaskButton.frame.origin.y) - 12;
        newRect.size.width = self.view.frame.size.width;
        self->_customTableView.frame = newRect;
        
        self->_emptyTableViewView.alpha = ExpandCollectionView == NO ? 0.0f : 1.0f;
        self->_customTableView.alpha = ExpandCollectionView == NO ? 0.0f : 1.0f;
        
        newRect = self->_coverView.frame;
        newRect.origin.x = 0;
        newRect.origin.y = self->_customTableView.frame.origin.y + self->_customTableView.frame.size.height;
        newRect.size.height = 1000;
        newRect.size.width = self.view.frame.size.width;
        self->_coverView.frame = newRect;
        
    }];
    
}

#pragma mark - UX Methods

-(UIMenu *)GenerateItemContextMenu {
    
    NSMutableArray* ellipsisActions = [[NSMutableArray alloc] init];
    
    
    
    
    UIMenu *assignedToMenu = [self GenerateTopContextMenuAssignedToMenu];
    
    NSString *key = @"SortSelectedDefaultUserCalendar";
    NSMutableArray *arr = [[NSUserDefaults standardUserDefaults] objectForKey:key] ? [[[NSUserDefaults standardUserDefaults] objectForKey:key] mutableCopy] : [NSMutableArray array];
    NSString *subtitle = @"";
    
    for (NSString *username in arr) {
        
        if ([username containsString:@"Assigned To"] == NO) {
            
            if (subtitle.length == 0) {
                subtitle = username;
            } else {
                subtitle = [NSString stringWithFormat:@"%@, %@", subtitle, username];
            }
            
        }
        
    }
    
    if (@available(iOS 15.0, *)) {
        assignedToMenu.subtitle = subtitle;
    } else {
        // Fallback on earlier versions
    }
    
    [ellipsisActions addObject:assignedToMenu];
    
    
    
    
    UIMenu *ellipsisMenu = [UIMenu menuWithTitle:@"" children:ellipsisActions];
    
    return ellipsisMenu;
}

-(UIMenu *)GenerateTopContextMenuAssignedToMenu {
    
    NSMutableArray *sortSelectedDefaultUser = [[[NSUserDefaults standardUserDefaults] objectForKey:@"SortSelectedDefaultUserCalendar"] mutableCopy];
    NSMutableArray *actions1 = [NSMutableArray array];
    NSMutableArray *actions2 = [NSMutableArray array];
    
    if (_homeMembersDict && _homeMembersDict[@"Username"]) {
        
        for (NSString *username in _homeMembersDict[@"Username"]) {
            
            NSString *usernameSelected = @"";
            
            if ([sortSelectedDefaultUser containsObject:username]) {
                
                usernameSelected = username;
                
            }
            
            //usernameSelected = [[sortSelectedDefaultUser componentsSeparatedByString:@"Assigned To ••• "] count] > 1 ? [sortSelectedDefaultUser componentsSeparatedByString:@"Assigned To ••• "][1] : @"";
            //}
            
            UIImage *imageString = [usernameSelected isEqualToString:username] ? [[UIImage systemImageNamed:@"checkmark.circle.fill"] imageWithTintColor:[UIColor systemGreenColor] renderingMode:UIImageRenderingModeAlwaysOriginal] : nil;
            
            [actions2 addObject:[UIAction actionWithTitle:username image:imageString identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
                
                [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"View Assigned To - %@", username] completionHandler:^(BOOL finished) {
                    
                }];
                
                NSString *key = @"SortSelectedDefaultUserCalendar";
                NSMutableArray *arr = [[NSUserDefaults standardUserDefaults] objectForKey:key] ? [[[NSUserDefaults standardUserDefaults] objectForKey:key] mutableCopy] : [NSMutableArray array];
                if ([arr containsObject:@"Assigned To"] == NO) { [arr addObject:@"Assigned To"]; }
                if ([arr containsObject:username] == NO) { [arr addObject:username]; } else { [arr removeObject:username]; }
                [[NSUserDefaults standardUserDefaults] setObject:arr forKey:key];
                
                [self BarButtonItems];
                [self.customCollectionView reloadData];
                
            }]];
            
        }
        
        UIAction *clearAction = [UIAction actionWithTitle:@"Clear" image:[UIImage systemImageNamed:@"clear.fill"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"View Assigned To - %@", @"Nobody"] completionHandler:^(BOOL finished) {
                
            }];
            
            NSString *key = @"SortSelectedDefaultUserCalendar";
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
            
            [self BarButtonItems];
            [self.customCollectionView reloadData];
            
        }];
        
        [clearAction setAttributes:UIMenuElementAttributesDestructive];
        
        [actions1 addObject:clearAction];
        
        UIMenu *clearMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"" options:UIMenuOptionsDisplayInline children:actions1];
        [actions2 addObject:clearMenu];
        
    }
    
    
    
    UIMenu *menu = [UIMenu menuWithTitle:@"View Users" image:[UIImage systemImageNamed:@"person"] identifier:@"View" options:0 children:actions2];
    
    
    
    NSString *key = @"SortSelectedDefaultUser";
    NSMutableArray *arr = [[NSUserDefaults standardUserDefaults] objectForKey:key] ? [[[NSUserDefaults standardUserDefaults] objectForKey:key] mutableCopy] : [NSMutableArray array];
    NSString *subtitle = @"";
    
    for (NSString *username in arr) {
        
        if ([username containsString:@"Assigned To"] == NO) {
            
            if (subtitle.length == 0) {
                subtitle = username;
            } else {
                subtitle = [NSString stringWithFormat:@"%@, %@", subtitle, username];
            }
            
        }
        
    }
    
    if (@available(iOS 15.0, *)) {
        menu.subtitle = subtitle;
    } else {
        // Fallback on earlier versions
    }
    
    
    
    return menu;
}

-(void)GenerateUpdatedItemDicts {
    
    [self UpdateCalendarItemDict:self->_itemsDict itemType:@"Chore"];
    [self UpdateCalendarItemDict:self->_itemsDictNo2 itemType:@"Expense"];
    [self UpdateCalendarItemDict:self->_itemsDictNo3 itemType:@"List"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.customCollectionView reloadData];
        [self.customTableView reloadData];
        
    });
    
}

#pragma mark - IBAction Methods

-(IBAction)ArrowTapGesture:(id)sender {
    
    //    if ([[[BoolDataObject alloc] init] PremiumSubscriptionIsOn] == NO) {
    
    //[[[PushObject alloc] init] PushToWeDivvyPremiumViewController:NO comingFromSignUp:NO defaultPlan:@"" displayDiscount:@"Half-Off Yearly Discount No Sale Sticker" selectedSlide:@"" promoCodeID:@"" premiumPlanProductsArray:premiumPlanProductsArray premiumPlanPricesDict:premiumPlanPricesDict premiumPlanExpensivePricesDict:premiumPlanExpensivePricesDict premiumPlanPricesDiscountDict:premiumPlanPricesDiscountDict premiumPlanPricesNoFreeTrialDict:premiumPlanPricesNoFreeTrialDict currentViewController:self Superficial:NO];
    
    //    } else {
    
    NSInteger the_tag = [sender tag];
    
    NSDictionary *dict = [self GenerateCurrentLabelMonthAndYearDict];
    NSString *currentMonth = dict[@"Month"];
    NSString *currentYear = dict[@"Year"];
    
    if (the_tag == 1) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Left Arrow Clicked"] completionHandler:^(BOOL finished) {
            
        }];
        
        if ([currentMonth isEqualToString:@"January"]) {
            
            currentMonth = @"December";
            currentYear = [NSString stringWithFormat:@"%d", [currentYear intValue] - 1];
            
        } else if ([currentMonth isEqualToString:@"February"]) {
            
            currentMonth = @"January";
            
        } else if ([currentMonth isEqualToString:@"March"]) {
            
            currentMonth = @"February";
            
        } else if ([currentMonth isEqualToString:@"April"]) {
            
            currentMonth = @"March";
            
        } else if ([currentMonth isEqualToString:@"May"]) {
            
            currentMonth = @"April";
            
        } else if ([currentMonth isEqualToString:@"June"]) {
            
            currentMonth = @"May";
            
        } else if ([currentMonth isEqualToString:@"July"]) {
            
            currentMonth = @"June";
            
        } else if ([currentMonth isEqualToString:@"August"]) {
            
            currentMonth = @"July";
            
        } else if ([currentMonth isEqualToString:@"September"]) {
            
            currentMonth = @"August";
            
        } else if ([currentMonth isEqualToString:@"October"]) {
            
            currentMonth = @"September";
            
        } else if ([currentMonth isEqualToString:@"November"]) {
            
            currentMonth = @"October";
            
        } else if ([currentMonth isEqualToString:@"December"]) {
            
            currentMonth = @"November";
            
        }
        
    } else if (the_tag == 2) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Right Arrow Clicked"] completionHandler:^(BOOL finished) {
            
        }];
        
        if ([currentMonth isEqualToString:@"January"]) {
            
            currentMonth = @"February";
            
        } else if ([currentMonth isEqualToString:@"February"]) {
            
            currentMonth = @"March";
            
        } else if ([currentMonth isEqualToString:@"March"]) {
            
            currentMonth = @"April";
            
        } else if ([currentMonth isEqualToString:@"April"]) {
            
            currentMonth = @"May";
            
        } else if ([currentMonth isEqualToString:@"May"]) {
            
            currentMonth = @"June";
            
        } else if ([currentMonth isEqualToString:@"June"]) {
            
            currentMonth = @"July";
            
        } else if ([currentMonth isEqualToString:@"July"]) {
            
            currentMonth = @"August";
            
        } else if ([currentMonth isEqualToString:@"August"]) {
            
            currentMonth = @"September";
            
        } else if ([currentMonth isEqualToString:@"September"]) {
            
            currentMonth = @"October";
            
        } else if ([currentMonth isEqualToString:@"October"]) {
            
            currentMonth = @"November";
            
        } else if ([currentMonth isEqualToString:@"November"]) {
            
            currentMonth = @"December";
            
        } else if ([currentMonth isEqualToString:@"December"]) {
            
            currentMonth = @"January";
            currentYear = [NSString stringWithFormat:@"%d", [currentYear intValue] + 1];
            
        }
        
    }
    
    monthViewLabel.text = [NSString stringWithFormat:@"%@, %@", currentMonth, currentYear];
    
    startingDay = [self GenerateStartingDay:NO];
    
    [self UpdateCollectionViewFrame];
    
    [self AdjustExpandedTableViewFrames:NO indexPath:[NSIndexPath indexPathForItem:0 inSection:0] timeInterval:0];
    
    [self.customCollectionView reloadData];
    [self.customTableView reloadData];
    
    //    }
    
}

-(IBAction)NavigationBackButtonAction:(UIBarButtonItem *)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Navigation Back Button Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
       
}

-(IBAction)CompleteUncompleteTaskAction:(id)sender {
    
    UIImpactFeedbackGenerator *myGen = [[UIImpactFeedbackGenerator alloc] initWithStyle:(UIImpactFeedbackStyleMedium)];
    [myGen impactOccurred];
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:_customTableView];
    NSIndexPath *indexPath = [_customTableView indexPathForRowAtPoint:buttonPosition];
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld", (long)indexPath.row] forKey:@"TempIndexPathRow"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld", (long)indexPath.section] forKey:@"TempIndexPathSection"];
    
    
    
    NSString *selectedDayString = selectedDay[@"Day"] ? selectedDay[@"Day"] : @"";
    NSString *selectedDayInCollectionView = selectedDayString ? [NSString stringWithFormat:@"%d", [selectedDayString intValue]] : @"0";
    
    NSDictionary *dict = eventDict && eventDict[selectedDayInCollectionView] && [(NSArray *)eventDict[selectedDayInCollectionView] count] > indexPath.row ? eventDict[selectedDayInCollectionView][indexPath.row] : @{};
    NSMutableDictionary *singleObjectItemDict = dict[@"DictToUse"] ? [dict[@"DictToUse"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *singleObjectItemDictLocal = [singleObjectItemDict mutableCopy];
    
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
    
    NSString *itemType = @"Chore";
    
    if (singleObjectItemDict && singleObjectItemDict[@"ItemAmount"]) {
        itemType = @"Expense";
    } else if (singleObjectItemDict && singleObjectItemDict[@"ItemListItems"]) {
        itemType = @"List";
    }
    
    NSArray *keyArray = [[[GeneralObject alloc] init] GenerateKeyArrayManually:[itemType containsString:@"Chore"] Expense:[itemType containsString:@"Expense"] List:[itemType containsString:@"List"] Home:NO];
    
    BOOL TaskCanBeCompletedInTaskBySpecificUser = [[[BoolDataObject alloc] init] TaskCanBeCompletedInTaskBySpecificUser:singleObjectItemDict itemType:itemType userID:userID homeMembersDict:_homeMembersDict];
    
    if (TaskCanBeCompletedInTaskBySpecificUser == YES) {
  
        
        
//        [self StartProgressView];
        
        NSIndexPath *indexPath = [[[CompleteUncompleteObject alloc] init] GenerateTempIndexPath];
        NSIndexPath *indexPathCollection = [NSIndexPath indexPathForItem:[selectedDay[@"indexPathItem"] integerValue] inSection:0];
       
        NSMutableDictionary *homeMembersDictLocal = [_homeMembersDict mutableCopy];
        NSMutableArray *allItemAssignedToArrays = [self GenerateAllItemAssignedToArrays:self->_itemsDict homeMembersDict:self->_homeMembersDict];
        NSMutableArray *allItemTagsArrays = [self GenerateAllItemTagsArrays:self->_itemsDict];
        NSString *userWhoIsBeingMarkedUserID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"];
        
        NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"";
        NSMutableDictionary *itemCompletedDict = singleObjectItemDict[@"ItemCompletedDict"] ? [singleObjectItemDict[@"ItemCompletedDict"] mutableCopy] : [NSMutableDictionary dictionary];
        
        BOOL TaskAlreadyCompleted = [[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemCompletedDict userIDToFind:userID];
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"%@ Clicked %@ For %@", TaskAlreadyCompleted == YES ? @"Uncomplete" : @"Complete", singleObjectItemDict[@"ItemID"], itemType] completionHandler:^(BOOL finished) {
            
        }];
        
        NSString *notificationType = [[[NotificationsObject alloc] init] NotificationSettingsUnknownItemType_Adding:NO Editing:NO Deleting:NO Duplicating:NO Waiving:NO Skipping:NO Pausing:NO Comments:NO
                                                                                                       SkippingTurn:NO RemovingUser:NO
                                                                                                     FullyCompleted:NO Completed:YES InProgress:NO WontDo:NO Accept:NO Decline:NO
                                                                                                            DueDate:NO Reminder:NO
                                                                                                     SubtaskEditing:NO SubtaskDeleting:NO
                                                                                                   SubtaskCompleted:NO SubtaskInProgress:NO SubtaskWontDo:NO SubtaskAccept:NO SubtaskDecline:NO
                                                                                                     AddingListItem:NO EditingListItem:NO DeletingListItem:NO ResetingListItem:NO
                                                                                                EditingItemizedItem:NO DeletingItemizedItem:NO
                                                                                                  GroupChatMessages:NO LiveSupportMessages:NO
                                                                                                 SendingInvitations:NO DeletingInvitations:NO NewHomeMembers:NO HomeMembersMovedOut:NO HomeMembersKickedOut:NO
                                                                                                FeatureForumUpvotes:NO BugForumUpvotes:NO
                                                                                                           itemType:itemType];
        
        NSString *notificationItemType = itemType;
        
        BOOL markingForSomeoneElse = NO;
 
        
        
        //Remove Loading
       
        singleObjectItemDictLocal = [[[CompleteUncompleteObject alloc] init] GenerateUpdatedTaskCompleteUncompleteDict:singleObjectItemDictLocal itemOccurrencesDict:_itemsOccurrencesDict homeMembersDict:_homeMembersDict userWhoIsBeingMarkedUserID:userWhoIsBeingMarkedUserID markingForSomeoneElse:markingForSomeoneElse];
  
        [self CompleteUncomplete_GenerateUpdatedData:singleObjectItemDictLocal returningOccurrencesDictToUse:_itemsOccurrencesDict returningUpdatedTaskListDictToUse:[NSMutableDictionary dictionary] selectedDayInCollectionView:selectedDayInCollectionView indexPath:indexPath keyArray:keyArray singleObjectItemDict:singleObjectItemDictLocal];
        
        //
        
       
        
        [[[CompleteUncompleteObject alloc] init] TaskCompleteUncomplete:singleObjectItemDict itemOccurrencesDict:_itemsOccurrencesDict keyArray:keyArray homeMembersArray:self->_homeMembersArray homeMembersDict:homeMembersDictLocal notificationSettingsDict:self->_notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType topicDict:self->_topicDict taskListDict:self->_taskListDict allItemAssignedToArrays:allItemAssignedToArrays allItemTagsArrays:allItemTagsArrays userWhoIsBeingMarkedUserID:userWhoIsBeingMarkedUserID markingForSomeoneElse:markingForSomeoneElse currentViewController:self completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningDictToUse, NSMutableDictionary * _Nonnull returningOccurrencesDictToUse, NSMutableDictionary * _Nonnull returningUpdatedTaskListDictToUse, BOOL TaskIsFullyCompleted) {
            
            [self CompleteUncomplete_GenerateUpdatedData:returningDictToUse returningOccurrencesDictToUse:returningOccurrencesDictToUse returningUpdatedTaskListDictToUse:returningUpdatedTaskListDictToUse selectedDayInCollectionView:selectedDayInCollectionView indexPath:indexPath keyArray:keyArray singleObjectItemDict:singleObjectItemDict];

            TaskIsFullyCompleted = [[[BoolDataObject alloc] init] TaskIsFullyCompleted:singleObjectItemDictLocal itemType:itemType homeMembersDict:_homeMembersDict];
            
            [self CompleteUncompleteTaskAction_DisplayRepeatIfCompletedEarlyResetDropDown:singleObjectItemDictLocal TaskIsFullyCompleted:TaskIsFullyCompleted indexPath:indexPathCollection];
            
        }];
        
    } else {
        
        [self CompleteUncompleteTaskAction_DisplayUnclickableError:singleObjectItemDict itemType:itemType];
        
    }

}

#pragma mark - Tap Gesture IBAction Methods

- (IBAction)TapGestureAddTask:(id)sender {
    
    if ([[[GeneralObject alloc] init] ConnectedToInternet] == NO) {
        [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You need to be connected to the internet to do that." currentViewController:self];
        return;
    }
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"AddTask Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    //Post-Spike
    //    BOOL ExpandedAddingViewSelected = [[NSUserDefaults standardUserDefaults] objectForKey:@"AddingViewDefault"] && [[[NSUserDefaults standardUserDefaults] objectForKey:@"AddingViewDefault"] isEqualToString:@"Yes"];
    //
    //    if (ExpandedAddingViewSelected) {
    
    NSMutableArray *allItemTagsArrays = [self GenerateAllItemTagsArrays:self->_itemsDict];
    NSMutableArray *allItemIDsArrays = [self GenerateNumberOfValidTasksInArrayForm];
    
    allItemIDsArrays = [[[GeneralObject alloc] init] RemoveDupliatesFromArray:allItemIDsArrays];
    
    NSString *sectionSelected = [[NSUserDefaults standardUserDefaults] objectForKey:@"CategorySelected"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"CategorySelected"] : @"All";
    BOOL ListSelected = [_taskListDict[@"TaskListName"] containsObject:sectionSelected];
    NSString *defaultTaskListName = ListSelected == YES ? sectionSelected : @"No List";
    
    NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
    
    NSString *selectedDayString = selectedDay[@"Day"] ? selectedDay[@"Day"] : @"";
    NSString *selectedMonthString = selectedDay[@"Month"] ? selectedDay[@"Month"] : @"";
    NSString *selectedYearString = selectedDay[@"Year"] ? selectedDay[@"Year"] : @"";
    
    [[[PushObject alloc] init] PushToAddTaskViewController:nil partiallyAddedDict:[@{@"ItemDueDate" : [NSString stringWithFormat:@"%@ %@, %@", selectedMonthString, selectedDayString, selectedYearString], @"ItemAssignedTo" : @[userID]} mutableCopy] suggestedItemToAddDict:nil templateToEditDict:nil draftToEditDict:nil moreOptionsDict:nil multiAddDict:nil notificationSettingsDict:_notificationSettingsDict topicDict:self->_topicDict homeID:homeID homeMembersArray:_homeMembersArray homeMembersDict:_homeMembersDict itemOccurrencesDict:[NSMutableDictionary dictionary] folderDict:_folderDict taskListDict:_taskListDict templateDict:_templateDict draftDict:_draftDict allItemAssignedToArrays:_allItemAssignedToArrays allItemTagsArrays:allItemTagsArrays allItemIDsArrays:allItemIDsArrays defaultTaskListName:defaultTaskListName partiallyAddedTask:YES addingTask:NO addingMultipleTasks:NO addingSuggestedTask:NO editingTask:NO viewingTask:NO viewingMoreOptions:NO duplicatingTask:NO editingTemplate:NO viewingTemplate:NO editingDraft:NO viewingDraft:NO currentViewController:self Superficial:NO];

    //} else {
    //
    //    AddTaskShowing = YES;
    //
    //    [_addTaskItemNameTextView becomeFirstResponder];
    //
    //    [UIView animateWithDuration:0.25 animations:^{
    //
    //        self->_addTaskBackDropView.alpha = 1.0f;
    //
    //    }];
    //
    //}
    
}

#pragma mark - Collection View Methods
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    CalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CalendarCell" forIndexPath:indexPath];
    
    if (indexPath.item < 7) {
        
        cell.calendarWeekDayLabel.text = daysArray && [daysArray count] > indexPath.item ? daysArray[indexPath.item] : @"";
        cell.calendarDayNumberLabel.text = @"";
        
    } else if (indexPath.item >= 7 + [[self GenerateStringToDay:startingDay] intValue]) {
        
        colorsArray = [NSMutableArray array];
        NSMutableArray *eventInnerDict = [NSMutableArray array];
        
        NSString *itemInDayForm = [NSString stringWithFormat:@"%d", (int)indexPath.item+1-(7+[[self GenerateStringToDay:startingDay] intValue])];
        NSString *itemInDayFormMaximumDigits = [NSString stringWithFormat:@"%02d", (int)indexPath.item+1-(7+[[self GenerateStringToDay:startingDay] intValue])];
        
        cell.calendarWeekDayLabel.text = @"";
        cell.calendarDayNumberLabel.text = [NSString stringWithFormat:@"%@", itemInDayForm];
        
        NSArray *itemDictArr = @[_itemsDict, _itemsDictNo2, _itemsDictNo3];
        
        for (NSMutableDictionary *dictToUse in itemDictArr) {
            
            NSMutableArray *itemUniqueIDArray = dictToUse && dictToUse[@"ItemUniqueID"] ? dictToUse[@"ItemUniqueID"] : [NSMutableArray array];
            
            for (NSString *itemUniqueID in dictToUse[@"ItemUniqueID"]) {
                
                NSUInteger index = [itemUniqueIDArray indexOfObject:itemUniqueID];
                
                NSString *itemDueDate = dictToUse && dictToUse[@"ItemDueDate"] && [(NSArray *)dictToUse[@"ItemDueDate"] count] > index ? dictToUse[@"ItemDueDate"][index] : @"";
      
                NSString *itemType = @"Chores";
                
                if (dictToUse && dictToUse[@"ItemAmount"] && [(NSArray *)dictToUse[@"ItemAmount"] count] > index) {
                    itemType = @"Expenses";
                } else if (dictToUse && dictToUse[@"ItemListItems"] && [(NSArray *)dictToUse[@"ItemListItems"] count] > index) {
                    itemType = @"Lists";
                }
                
                NSMutableDictionary *singleObjectItemDict = [[[GeneralObject alloc] init] GenerateSingleObjectDictionary:dictToUse keyArray:[[[GeneralObject alloc] init] GenerateKeyArrayManually:[itemType isEqualToString:@"Chores"] ? YES : NO Expense:[itemType isEqualToString:@"Expenses"] ? YES : NO List:[itemType isEqualToString:@"Lists"] ? YES : NO Home:NO] indexPath:[NSIndexPath indexPathForRow:index inSection:0]];
                
                NSDictionary *dict = [self GenerateCurrentLabelMonthAndYearDict];
                NSString *currentMonth = dict[@"Month"];
                NSString *currentYear = dict[@"Year"];
                
                NSString *dueDateToCheck = [NSString stringWithFormat:@"%@ %@, %@", currentMonth, itemInDayFormMaximumDigits, currentYear];
                NSString *dueDateToCheckMaximumDigits = [NSString stringWithFormat:@"%@ %@, %@", currentMonth, itemInDayForm, currentYear];
               
                [self GenerateDictAndColorForDueDate:itemDueDate dueDateToCheck:dueDateToCheck dueDateToCheckMaximumDigits:dueDateToCheckMaximumDigits itemType:itemType singleObjectItemDict:singleObjectItemDict eventInnerDict:eventInnerDict];
                
            }
            
        }
        
        colorsArray = [[[GeneralObject alloc] init] RemoveDupliatesFromArray:colorsArray];
    
        eventInnerDict = [self GenerateSortedEventInnerDict:eventInnerDict];
        
        [eventDict setObject:eventInnerDict forKey:itemInDayForm];
      
        [self.customTableView reloadData];
      
    } else if (indexPath.item >= 7) {
        
        cell.calendarWeekDayLabel.text = @"";
        cell.calendarDayNumberLabel.text = @"";
        
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(CalendarCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat width = CGRectGetWidth(cell.contentView.bounds);
    CGFloat height = CGRectGetHeight(cell.contentView.bounds);
    
    cell.mainView.frame = CGRectMake(0, 0, width, height);

    width = CGRectGetWidth(cell.mainView.bounds);
    height = CGRectGetHeight(cell.mainView.bounds);
    
    cell.calendarDayNumberLabel.frame = CGRectMake(cell.mainView.frame.size.width*0.5 - (height*0.6 > 30?(30):height*0.6)*0.5, 0, (height*0.6 > 30?(30):height*0.6), (height*0.6 > 30?(30):height*0.6));
    cell.calendarWeekDayLabel.frame = CGRectMake(0, 0, width, height);
    
    CGFloat topFloat = cell.calendarDayNumberLabel.frame.origin.y + cell.calendarDayNumberLabel.frame.size.height;
    
    
    
    
    
    
    NSString *itemInDayForm = [NSString stringWithFormat:@"%d", (int)indexPath.item+1-(7+[[self GenerateStringToDay:startingDay] intValue])];
    
    for (UIButton *subView in cell.contentView.subviews) {
        
        if (subView.tag == 100) {
            [subView removeFromSuperview];
        } else if (subView.tag == 99) {
            [subView removeFromSuperview];
        }
        
    }
    
    if (indexPath.item >= 7 + [[self GenerateStringToDay:startingDay] intValue]) {
        
        CGFloat labelHeight = (self.view.frame.size.height*0.02445652 > 18?(18):self.view.frame.size.height*0.02445652);
        
        for (int i=0 ; i<[(NSArray *)eventDict[itemInDayForm] count] ; i++) {
            
            float yPos = topFloat + 4 + ((labelHeight + 1)*i);
            
            NSDictionary *dict = eventDict && eventDict[itemInDayForm] && [(NSArray *)eventDict[itemInDayForm] count] > i ? eventDict[itemInDayForm][i] : @{};
            NSMutableDictionary *singleObjectItemDict = dict[@"DictToUse"] ? [dict[@"DictToUse"] mutableCopy] : [NSMutableDictionary dictionary];
            
            NSString *itemType = @"Chores";
            
            if (singleObjectItemDict && singleObjectItemDict[@"ItemAmount"]) {
                itemType = @"Expenses";
            } else if (singleObjectItemDict && singleObjectItemDict[@"ItemListItems"]) {
                itemType = @"Lists";
            }
            
            BOOL TaskWasCompletedByMe = [[[BoolDataObject alloc] init] TaskCompletedBySpecificUser:singleObjectItemDict itemType:itemType userID:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
            
            UIColor *colorToUse = [UIColor colorWithRed:0.0f/255.0f green:123.0f/255.0f blue:254.0f/255.0f alpha:TaskWasCompletedByMe ? 0.325f : 0.65f];
           
            if (singleObjectItemDict && singleObjectItemDict[@"ItemAmount"]) {
                colorToUse = [UIColor colorWithRed:53.0f/255.0f green:198.0f/255.0f blue:89.0f/255.0f alpha:TaskWasCompletedByMe ? 0.325f : 0.85f];
            } else if (singleObjectItemDict && singleObjectItemDict[@"ItemListItems"]) {
                colorToUse = [UIColor colorWithRed:250.0f/255.0f green:200.0f/255.0f blue:20.0f/255.0f alpha:TaskWasCompletedByMe ? 0.325f : 0.85f];
            }
            
            if (yPos+((labelHeight+1)*2) <= cell.contentView.frame.size.height) {
                
                UIView *titleLabelBackground = [[UIView alloc] initWithFrame:CGRectMake(0, yPos, width, labelHeight)];
                titleLabelBackground.hidden = NO;
                titleLabelBackground.layer.cornerRadius = 3;
                titleLabelBackground.backgroundColor = colorToUse;
                titleLabelBackground.tag = 100;;
                
                UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 0, titleLabelBackground.frame.size.width + 20, titleLabelBackground.frame.size.height)];
                titleLabel.font = [UIFont systemFontOfSize:11];
                titleLabel.textAlignment = NSTextAlignmentLeft;
                titleLabel.text = eventDict[itemInDayForm][i][@"Title"];
                titleLabel.tag = 99;
                titleLabel.alpha = 0.75f;
                
                [titleLabelBackground addSubview:titleLabel];
                [cell.contentView addSubview:titleLabelBackground];
                
            } else if (yPos+labelHeight+1 <= cell.contentView.frame.size.height) {
                
                UIView *titleLabelBackground = [[UIView alloc] initWithFrame:CGRectMake(0, yPos, width, labelHeight)];
                titleLabelBackground.hidden = NO;
                titleLabelBackground.layer.cornerRadius = 3;
                titleLabelBackground.backgroundColor = [UIColor colorWithRed:0.0f/255.0f green:123.0f/255.0f blue:254.0f/255.0f alpha:0.65f];
                titleLabelBackground.tag = 100;
                
                UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, titleLabelBackground.frame.size.width, titleLabelBackground.frame.size.height)];
                titleLabel.font = [UIFont systemFontOfSize:11];
                titleLabel.textAlignment = NSTextAlignmentCenter;
                titleLabel.text = [NSString stringWithFormat:@"+%lu", [(NSArray *)eventDict[itemInDayForm] count]-i];
                titleLabel.tag = 99;
                titleLabel.alpha = 0.75f;
                
                [titleLabelBackground addSubview:titleLabel];
                [cell.contentView addSubview:titleLabelBackground];
                
            }
            
        }
        
    }
    
    
    
    
    
    
    
    NSDictionary *dict = [self GenerateCurrentDayMonthAndYearDict];
    NSString *monthAndYear = [NSString stringWithFormat:@"%@, %@", dict[@"Month"], dict[@"Year"]];
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitDay) fromDate:[NSDate date]];
    
    cell.calendarDayNumberLabel.clipsToBounds = YES;
    
    NSDictionary *dictNo1 = [self GenerateCurrentDayMonthAndYearDict];
    NSString *currentDay = [NSString stringWithFormat:@"%d", [dictNo1[@"Day"] intValue]];
    NSString *currentMonth = dictNo1[@"Month"];
    NSString *currentYear = dictNo1[@"Year"];
    
    NSDictionary *selectedDayCopy = @{@"Day" : currentDay, @"Month" : currentMonth, @"Year" : currentYear};
    
    if ((selectedDay && [[selectedDay allKeys] count] == 0 && [itemInDayForm intValue] == (components.day) && [monthViewLabel.text isEqualToString:monthAndYear]) ||
        (selectedDay && [[selectedDay allKeys] count] > 0 && [itemInDayForm intValue] == ([selectedDay[@"Day"] intValue]) && [monthViewLabel.text isEqualToString:[NSString stringWithFormat:@"%@, %@", selectedDay[@"Month"], selectedDay[@"Year"]]])) {
        
        cell.calendarDayNumberLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightSemibold];
        cell.calendarDayNumberLabel.textColor = [UIColor whiteColor];
        cell.calendarDayNumberLabel.backgroundColor = [UIColor colorWithRed:0.0f/255.0f green:122.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
        cell.calendarDayNumberLabel.layer.cornerRadius = cell.calendarDayNumberLabel.frame.size.height/2;
        
    } else if (selectedDayCopy && [[selectedDayCopy allKeys] count] > 0 && [itemInDayForm intValue] == ([selectedDayCopy[@"Day"] intValue]) && [monthViewLabel.text isEqualToString:[NSString stringWithFormat:@"%@, %@", selectedDayCopy[@"Month"], selectedDayCopy[@"Year"]]]) {
        
        cell.calendarDayNumberLabel.font = [UIFont systemFontOfSize:(self.view.frame.size.height*0.02173913 > 16?(16):self.view.frame.size.height*0.02173913) weight:UIFontWeightSemibold];
        cell.calendarDayNumberLabel.textColor = [UIColor whiteColor];
        cell.calendarDayNumberLabel.backgroundColor = [UIColor colorWithRed:0.0f/255.0f green:122.0f/255.0f blue:255.0f/255.0f alpha:0.30f];
        cell.calendarDayNumberLabel.layer.cornerRadius = cell.calendarDayNumberLabel.frame.size.height/2;
        
    } else {
        
        cell.calendarDayNumberLabel.font = [UIFont systemFontOfSize:(self.view.frame.size.height*0.02173913 > 16?(16):self.view.frame.size.height*0.02173913) weight:UIFontWeightRegular];
        cell.calendarDayNumberLabel.textColor = [UIColor colorWithRed:112.0f/255.0f green:119.0f/255.0f blue:127.0f/255.0f alpha:1.0f];
        cell.calendarDayNumberLabel.backgroundColor = [UIColor clearColor];
        cell.calendarDayNumberLabel.layer.cornerRadius = cell.calendarDayNumberLabel.frame.size.height/2;
        
    }
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Did Select Day"] completionHandler:^(BOOL finished) {
        
    }];
    
    if (indexPath.item >= 7 + [[self GenerateStringToDay:startingDay] intValue]) {
        
        CGFloat navigationBarHeight = [[[GeneralObject alloc] init] GetNavigationBarHeight:self];
        
        NSString *itemInDayForm = [NSString stringWithFormat:@"%d", (int)indexPath.item+1-(7+[[self GenerateStringToDay:self->startingDay] intValue])];
        
        BOOL ExpandCollectionView = YES;
        
        if ([self->selectedDay[@"Day"] isEqualToString:itemInDayForm] && self->_customCollectionView.frame.origin.y != navigationBarHeight) {
            ExpandCollectionView = NO;
        }
        
        [self AdjustExpandedTableViewFrames:ExpandCollectionView indexPath:indexPath timeInterval:0.25];
        
    }
    
    if (indexPath.item >= 7 + [[self GenerateStringToDay:startingDay] intValue]) {
        
        NSString *itemInDayForm = [NSString stringWithFormat:@"%d", (int)indexPath.item+1-(7+[[self GenerateStringToDay:startingDay] intValue])];
        
        NSDictionary *dict = [self GenerateCurrentLabelMonthAndYearDict];
        NSString *currentMonth = dict[@"Month"];
        NSString *currentYear = dict[@"Year"];
        
        int previousSelectedDay = [selectedDay[@"Day"] intValue] + ([[self GenerateStringToDay:startingDay] intValue]+7) - 1;
        
        selectedDay = @{@"Day" : itemInDayForm, @"Month" : currentMonth, @"Year" : currentYear, @"indexPathItem" : [NSString stringWithFormat:@"%lu", indexPath.item]};
        
        [_customCollectionView reloadItemsAtIndexPaths:@[indexPath, [NSIndexPath indexPathForItem:previousSelectedDay inSection:0]]];
        
        [self.customTableView reloadData];
        
    }
    
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSDictionary *dict = [self GenerateCurrentLabelMonthAndYearDict];
    NSString *currentMonth = dict[@"Month"];
    NSString *numberOfDaysInCurrentMonth = [[[GeneralObject alloc] init] GetMonthNumberInYear:currentMonth];
    float amountOfDaysInCollectionView = [[[NotificationsObject alloc] init] GetMonthDayAmountFromMonthNumber:[numberOfDaysInCurrentMonth intValue]] + 7;

    return amountOfDaysInCollectionView + [[self GenerateStringToDay:startingDay] intValue];
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.item < 7) {
        return CGSizeMake(cellWidth, firstRowCellHeight);
    }
    
    return CGSizeMake(cellWidth, cellHeight);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return cellSpacing;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return cellSpacing;
}

#pragma mark - Table View Methods

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    MainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainCell"];
    
    NSString *selectedDayString = selectedDay[@"Day"] ? selectedDay[@"Day"] : @"";
    NSString *selectedDayInCollectionView = selectedDayString ? [NSString stringWithFormat:@"%d", [selectedDayString intValue]] : @"0";
    
    NSDictionary *dict = eventDict && eventDict[selectedDayInCollectionView] && [(NSArray *)eventDict[selectedDayInCollectionView] count] > indexPath.row ? eventDict[selectedDayInCollectionView][indexPath.row] : @{};
    
   
    
    cell.titleLabel.text = dict && dict[@"Title"] ? dict[@"Title"] : @"";
    cell.subLabel.text = dict && dict[@"Body"] ? dict[@"Body"] : @"";
    
    
    
    NSMutableDictionary *singleObjectItemDict = dict[@"DictToUse"] ? [dict[@"DictToUse"] mutableCopy] : [NSMutableDictionary dictionary];
    
    NSString *itemType = @"Chores";
    
    if (singleObjectItemDict && singleObjectItemDict[@"ItemAmount"]) {
        itemType = @"Expenses";
    } else if (singleObjectItemDict && singleObjectItemDict[@"ItemListItems"]) {
        itemType = @"Lists";
    }
    
    BOOL TaskIsTakingTurns = [[[BoolDataObject alloc] init] TaskIsTakingTurns:singleObjectItemDict itemType:itemType];
    
    if (TaskIsTakingTurns == YES) {
       
        NSString *itemTurnUserID = [[[GeneralObject alloc] init] GenerateCurrentUserTurnFromDict:singleObjectItemDict homeMembersDict:_homeMembersDict itemType:itemType];
        [self GenerateitemAssignedToImageSpecificUser:cell.assignedImage1 index:0 singleObjectItemDict:singleObjectItemDict itemType:itemType indexPath:indexPath specificUserID:itemTurnUserID];
        
        cell.assignedImage2.hidden = YES;
        cell.assignedImage3.hidden = YES;
        cell.assignedImage4.hidden = YES;
        cell.assignedImage5.hidden = YES;
        
    } else {
        
        [self GenerateitemAssignedToImage:cell.assignedImage1 index:0 singleObjectItemDict:singleObjectItemDict itemType:itemType indexPath:indexPath];
        [self GenerateitemAssignedToImage:cell.assignedImage2 index:1 singleObjectItemDict:singleObjectItemDict itemType:itemType indexPath:indexPath];
        [self GenerateitemAssignedToImage:cell.assignedImage3 index:2 singleObjectItemDict:singleObjectItemDict itemType:itemType indexPath:indexPath];
        [self GenerateitemAssignedToImage:cell.assignedImage4 index:3 singleObjectItemDict:singleObjectItemDict itemType:itemType indexPath:indexPath];
        [self GenerateitemAssignedToImage:cell.assignedImage5 index:4 singleObjectItemDict:singleObjectItemDict itemType:itemType indexPath:indexPath];
        
    }
    
    
    
    cell.itemPriorityImage.image = [self GenerateitemPriorityImage:singleObjectItemDict indexPath:indexPath];
    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSString *selectedDayString = selectedDay[@"Day"] ? selectedDay[@"Day"] : @"";
    NSString *selectedDayInCollectionView = selectedDayString ? [NSString stringWithFormat:@"%d", [selectedDayString intValue]] : @"0";
    
    _emptyTableViewView.hidden = [(NSArray *)eventDict[selectedDayInCollectionView] count] > 0 ? YES : NO;
//    _noEventsLabel.hidden = [(NSArray *)eventDict[selectedDayInCollectionView] count] > 0 ? YES : NO;
    
    return [(NSArray *)eventDict[selectedDayInCollectionView] count];
    
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(MainCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *selectedDayString = selectedDay[@"Day"] ? selectedDay[@"Day"] : @"";
    NSString *selectedDayInCollectionView = selectedDayString ? [NSString stringWithFormat:@"%d", [selectedDayString intValue]] : @"0";
    
    NSDictionary *dict = eventDict && eventDict[selectedDayInCollectionView] && [(NSArray *)eventDict[selectedDayInCollectionView] count] > indexPath.row ? eventDict[selectedDayInCollectionView][indexPath.row] : @{};
    NSMutableDictionary *singleObjectItemDict = dict[@"DictToUse"] ? [dict[@"DictToUse"] mutableCopy] : [NSMutableDictionary dictionary];
    
    NSString *itemType = @"Chores";
    
    if (singleObjectItemDict && singleObjectItemDict[@"ItemAmount"]) {
        itemType = @"Expenses";
    } else if (singleObjectItemDict && singleObjectItemDict[@"ItemListItems"]) {
        itemType = @"Lists";
    }
    
    NSDictionary *colorDict = [self GenerateCheckmarkColor:singleObjectItemDict indexPath:indexPath];
    
    
    UIColor *selectedColor = colorDict[@"SelectedColor"];
    UIColor *unselectedColor = colorDict[@"UnselectedColor"];
    
    BOOL TaskWasCompletedByMe = [[[BoolDataObject alloc] init] TaskCompletedBySpecificUser:singleObjectItemDict itemType:itemType userID:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
    BOOL TaskIsFullyCompleted = [[[BoolDataObject alloc] init] TaskIsFullyCompleted:singleObjectItemDict itemType:itemType homeMembersDict:_homeMembersDict];
    BOOL TaskIsCompleteAsNeeded = [[[BoolDataObject alloc] init] TaskIsCompleteAsNeeded:singleObjectItemDict itemType:itemType];
    BOOL TaskWontDoBySpecificUser = [[[BoolDataObject alloc] init] TaskWontDoBySpecificUser:singleObjectItemDict itemType:itemType userID:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
    
    BOOL TaskIsRepeating = [[[BoolDataObject alloc] init] TaskIsRepeating:singleObjectItemDict itemType:itemType];
    
    BOOL DisplayCompletedUI = ((TaskWasCompletedByMe == YES && TaskIsCompleteAsNeeded == NO) || TaskIsFullyCompleted == YES);
    BOOL TaskHasColor = [[[BoolDataObject alloc] init] TaskHasColor:singleObjectItemDict itemType:itemType];
    
    
    
    
    cell.checkmarkView.backgroundColor = DisplayCompletedUI == YES ? selectedColor : unselectedColor;
    if (TaskWontDoBySpecificUser == YES && TaskIsFullyCompleted == NO) { cell.checkmarkView.backgroundColor = DisplayCompletedUI == YES ? [UIColor colorWithRed:186.0f/255.0f green:188.0f/255.0f blue:190.0f/255.0f alpha:1.0f] : unselectedColor; }
    
    if (TaskHasColor == NO) { cell.checkmarkView.alpha = 1.0f;  } else {  cell.checkmarkView.alpha = DisplayCompletedUI == YES ? 0.85f : 0.25f; }
    
    
    
    
    
    
    //NSString *mainTableViewSectionName = [dataDisplaySectionsArray count] > indexPath.section ? [dataDisplaySectionsArray objectAtIndex:indexPath.section] : @"";
    
    
    
    
    
    
    
    
    
    CGFloat height = (self.view.frame.size.height*0.11005435 > 81?(81):self.view.frame.size.height*0.11005435);//CGRectGetHeight(cell.contentView.bounds);
    CGFloat width = CGRectGetWidth(cell.contentView.bounds);
    CGFloat Imageheight = 94;
    
    
    
    
    cell.mainView.frame = CGRectMake(width*0.5 - ((width*0.90338164)*0.5), height*0.5 - ((height*0.7037037)*0.5), width*0.90338164, height*0.7037037);
    cell.leftSlideCoverView.backgroundColor = self.view.backgroundColor;
    cell.rightSlideCoverView.backgroundColor = self.view.backgroundColor;
    //374, 31
    
    
    
    
    height = CGRectGetHeight(cell.mainView.bounds);
    width = CGRectGetWidth(cell.mainView.bounds);
    
    
    
    
    
    cell.checkmarkView.frame = CGRectMake(width*0.04278075, height*0.5 - ((height*0.43859)*0.5), height*0.43859, height*0.43859);
    cell.checkmarkViewCover.frame = CGRectMake(0, 0, cell.checkmarkView.frame.origin.x + cell.checkmarkView.frame.size.width + width*0.04278075, height);
    
    cell.titleLabel.frame = CGRectMake(cell.checkmarkView.frame.origin.x + cell.checkmarkView.frame.size.width + width*0.04278075, height*0.14035, width*0.75, height*0.350878);
    cell.titleLabel.adjustsFontSizeToFitWidth = NO;
    cell.titleLabel.textColor = DisplayCompletedUI == YES ? [UIColor colorWithRed:167.0f/255.0f green:176.0f/255.0f blue:185.0f/255.0f alpha:1.0] : [UIColor blackColor];
    cell.titleLabel.alpha = DisplayCompletedUI == YES ? 0.75 : 1;
    cell.titleLabel.font = [UIFont systemFontOfSize:cell.titleLabel.frame.size.height*0.75 weight:UIFontWeightSemibold];
    
    
    
    
    
    cell.itemPastDueImage.frame = CGRectMake(cell.titleLabel.frame.origin.x, height - cell.titleLabel.frame.size.height - height*0.14035, (Imageheight*0.15957447 > 15?(15):Imageheight*0.15957447), cell.titleLabel.frame.size.height);
    cell.itemPastDueImage.hidden = YES;//[mainTableViewSectionName isEqualToString:@"Past Due"] ? NO : YES;
    
    
    
    
    
    CGFloat itemRepeatsImageXPos =
    cell.itemPastDueImage.hidden == NO ?
    cell.itemPastDueImage.frame.origin.x + cell.itemPastDueImage.frame.size.width + ((width*0.04278075)*0.25) :
    cell.titleLabel.frame.origin.x;
    
    cell.itemRepeatsImage.frame = CGRectMake(itemRepeatsImageXPos, height - cell.titleLabel.frame.size.height - height*0.14035, (Imageheight*0.15957447 > 15?(15):Imageheight*0.15957447), cell.titleLabel.frame.size.height);
    cell.itemRepeatsImage.hidden = TaskIsRepeating == YES ? NO : YES;
    
    
    
    
    
    CGFloat subLabelXPos = 0;
    
    if (cell.itemRepeatsImage.hidden == NO) {
        
        subLabelXPos = cell.itemRepeatsImage.frame.origin.x + cell.itemRepeatsImage.frame.size.width + ((width*0.04278075)*0.25);
        
    } else if (cell.itemPastDueImage.hidden == NO) {
        
        subLabelXPos = cell.itemPastDueImage.frame.origin.x + cell.itemPastDueImage.frame.size.width + ((width*0.04278075)*0.25);
        
    } else {
        
        subLabelXPos = cell.titleLabel.frame.origin.x;
        
    }
    
    cell.subLabel.frame = CGRectMake(subLabelXPos, height - cell.titleLabel.frame.size.height - height*0.14035, cell.titleLabel.frame.size.width, cell.titleLabel.frame.size.height);
    cell.subLabel.font = [UIFont systemFontOfSize:cell.subLabel.frame.size.height*0.65 weight:UIFontWeightSemibold];
    
    
    
    
    
    cell.itemPriorityImage.frame = CGRectMake(width - ((Imageheight*0.15957447 > 15?(15):Imageheight*0.15957447)*0.9) - cell.checkmarkView.frame.origin.x,  cell.titleLabel.frame.origin.y, ((Imageheight*0.15957447 > 15?(15):Imageheight*0.15957447)*0.9), ((Imageheight*0.15957447 > 15?(15):Imageheight*0.15957447)*0.9));
    
    cell.mutedImage.frame = CGRectMake(width - ((Imageheight*0.15957447 > 15?(15):Imageheight*0.15957447)*1.0) - cell.checkmarkView.frame.origin.x,  cell.titleLabel.frame.origin.y, ((Imageheight*0.15957447 > 15?(15):Imageheight*0.15957447)*1.0), ((Imageheight*0.15957447 > 15?(15):Imageheight*0.15957447)*1.0));
    cell.reminderImage.frame = CGRectMake(width - ((Imageheight*0.15957447 > 15?(15):Imageheight*0.15957447)*1.0) - cell.checkmarkView.frame.origin.x,  cell.titleLabel.frame.origin.y, ((Imageheight*0.15957447 > 15?(15):Imageheight*0.15957447)*1.0), ((Imageheight*0.15957447 > 15?(15):Imageheight*0.15957447)*1.0));
    cell.privateImage.frame = CGRectMake(width - ((Imageheight*0.15957447 > 15?(15):Imageheight*0.15957447)*1.25) - cell.checkmarkView.frame.origin.x,  cell.mutedImage.frame.origin.y + cell.mutedImage.frame.size.height*0.5 - (((Imageheight*0.15957447 > 15?(15):Imageheight*0.15957447)*1.25))*0.5, ((Imageheight*0.15957447 > 15?(15):Imageheight*0.15957447)*1.25), ((Imageheight*0.15957447 > 15?(15):Imageheight*0.15957447)*1.25));
    
    BOOL UserShouldReceiveNotificationsForTask = [[[BoolDataObject alloc] init] UserShouldReceiveNotificationsForTask:singleObjectItemDict itemType:itemType userID:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] homeMembersDict:_homeMembersDict];
    BOOL TaskHasBeenMuted = [[[BoolDataObject alloc] init] TaskHasBeenMuted:singleObjectItemDict];
    BOOL TaskHasReminderNotification = [[[BoolDataObject alloc] init] TaskHasReminderNotification:singleObjectItemDict];
    
    cell.mutedImage.hidden = TaskHasBeenMuted == NO || UserShouldReceiveNotificationsForTask == NO || [[[BoolDataObject alloc] init] PremiumSubscriptionIsOn] == NO ? YES : NO;
    cell.reminderImage.hidden = TaskHasReminderNotification == YES ? NO : YES;
    cell.privateImage.hidden = [singleObjectItemDict[@"ItemPrivate"] isEqualToString:@"Yes"] ? NO : YES;
    
    if ([singleObjectItemDict[@"ItemPriority"] isEqualToString:@"No Priority"] == YES && (cell.mutedImage.hidden == NO || cell.reminderImage.hidden == NO) && cell.privateImage.hidden == NO) {
        
        UIImageView *viewToUse = cell.mutedImage.hidden == NO ? cell.mutedImage : cell.reminderImage;
        
        CGRect newRect = viewToUse.frame;
        newRect.origin.x = cell.privateImage.frame.origin.x - newRect.size.width - ((width*0.04278075)*0.25);
        viewToUse.frame = newRect;
        
    } else if ([singleObjectItemDict[@"ItemPriority"] isEqualToString:@"No Priority"] == NO && (cell.mutedImage.hidden == NO || cell.reminderImage.hidden == NO) && cell.privateImage.hidden == YES) {
        
        UIImageView *viewToUse = cell.mutedImage.hidden == NO ? cell.mutedImage : cell.reminderImage;
        
        CGRect newRect = viewToUse.frame;
        newRect.origin.x = cell.itemPriorityImage.frame.origin.x - newRect.size.width - ((width*0.04278075)*0.25);
        viewToUse.frame = newRect;
        
    } else if ([singleObjectItemDict[@"ItemPriority"] isEqualToString:@"No Priority"] == NO && (cell.mutedImage.hidden == YES && cell.reminderImage.hidden == YES) && cell.privateImage.hidden == NO) {
        
        CGRect newRect = cell.privateImage.frame;
        newRect.origin.x = cell.itemPriorityImage.frame.origin.x - newRect.size.width - ((width*0.04278075)*0.25);
        cell.privateImage.frame = newRect;
        
    } else if ([singleObjectItemDict[@"ItemPriority"] isEqualToString:@"No Priority"] == NO && (cell.mutedImage.hidden == NO || cell.reminderImage.hidden == NO) && cell.privateImage.hidden == NO) {
        
        UIImageView *viewToUse = cell.mutedImage.hidden == NO ? cell.mutedImage : cell.reminderImage;
        
        CGRect newRect = cell.privateImage.frame;
        newRect.origin.x = cell.itemPriorityImage.frame.origin.x - newRect.size.width - ((width*0.04278075)*0.25);
        cell.privateImage.frame = newRect;
        
        newRect = viewToUse.frame;
        newRect.origin.x = cell.privateImage.frame.origin.x - newRect.size.width - ((width*0.04278075)*0.25);
        viewToUse.frame = newRect;
        
    }
    
    
    
    
    
    cell.assignedImage1.frame = CGRectMake(width - (cell.titleLabel.frame.size.height*1.25) - cell.mainView.frame.size.width*0.04278075, cell.subLabel.frame.origin.y + (((cell.subLabel.frame.size.height)*0.5) - ((cell.titleLabel.frame.size.height*1.25)*0.5)), cell.titleLabel.frame.size.height*1.25, cell.titleLabel.frame.size.height*1.25);
    
    
    
    CGFloat xPos = cell.assignedImage1.hidden == NO ? cell.assignedImage1.frame.origin.x - (cell.assignedImage1.frame.size.width*0.8) : width - (cell.titleLabel.frame.size.height*1.25) - cell.mainView.frame.size.width*0.04278075;
    
    cell.assignedImage2.frame = CGRectMake(xPos, cell.assignedImage1.frame.origin.y, cell.assignedImage1.frame.size.width, cell.assignedImage1.frame.size.height);
    
    
    
    if (cell.assignedImage1.hidden == YES && cell.assignedImage2.hidden == YES) {
        xPos = width - (cell.titleLabel.frame.size.height*1.25) - cell.mainView.frame.size.width*0.04278075;
    } else if (cell.assignedImage1.hidden == NO && cell.assignedImage2.hidden == YES) {
        xPos = cell.assignedImage1.frame.origin.x - (cell.assignedImage1.frame.size.width*0.8);
    } else if (cell.assignedImage2.hidden == NO) {
        xPos = cell.assignedImage2.frame.origin.x - (cell.assignedImage1.frame.size.width*0.8);
    }
    
    cell.assignedImage3.frame = CGRectMake(xPos, cell.assignedImage1.frame.origin.y, cell.assignedImage1.frame.size.width, cell.assignedImage1.frame.size.height);
    
    
    
    if (cell.assignedImage1.hidden == YES && cell.assignedImage2.hidden == YES && cell.assignedImage3.hidden == YES) {
        xPos = width - (cell.titleLabel.frame.size.height*1.25) - cell.mainView.frame.size.width*0.04278075;
    } else if (cell.assignedImage2.hidden == NO && cell.assignedImage3.hidden == YES) {
        xPos = cell.assignedImage2.frame.origin.x - (cell.assignedImage1.frame.size.width*0.8);
    } else if (cell.assignedImage1.hidden == NO && cell.assignedImage2.hidden == YES && cell.assignedImage3.hidden == YES) {
        xPos = cell.assignedImage1.frame.origin.x - (cell.assignedImage1.frame.size.width*0.8);
    } else if (cell.assignedImage3.hidden == NO) {
        xPos = cell.assignedImage3.frame.origin.x - (cell.assignedImage1.frame.size.width*0.8);
    }
    
    cell.assignedImage4.frame = CGRectMake(xPos, cell.assignedImage1.frame.origin.y, cell.assignedImage1.frame.size.width, cell.assignedImage1.frame.size.height);
    
    
    
    if (cell.assignedImage1.hidden == YES && cell.assignedImage2.hidden == YES && cell.assignedImage3.hidden == YES && cell.assignedImage4.hidden == YES) {
        xPos = width - (cell.titleLabel.frame.size.height*1.25) - cell.mainView.frame.size.width*0.04278075;
    } else if (cell.assignedImage3.hidden == NO && cell.assignedImage4.hidden == YES) {
        xPos = cell.assignedImage3.frame.origin.x - (cell.assignedImage1.frame.size.width*0.8);
    } else if (cell.assignedImage2.hidden == NO && cell.assignedImage3.hidden == YES && cell.assignedImage4.hidden == YES) {
        xPos = cell.assignedImage2.frame.origin.x - (cell.assignedImage1.frame.size.width*0.8);
    } else if (cell.assignedImage1.hidden == NO && cell.assignedImage2.hidden == YES && cell.assignedImage3.hidden == YES && cell.assignedImage4.hidden == YES) {
        xPos = cell.assignedImage1.frame.origin.x - (cell.assignedImage1.frame.size.width*0.8);
    } else if (cell.assignedImage4.hidden == NO) {
        xPos = cell.assignedImage4.frame.origin.x - (cell.assignedImage1.frame.size.width*0.8);
    }
    
    cell.assignedImage5.frame = CGRectMake(cell.assignedImage4.frame.origin.x - (cell.assignedImage1.frame.size.width*0.8), cell.assignedImage1.frame.origin.y, cell.assignedImage1.frame.size.width, cell.assignedImage1.frame.size.height);
    
    
    
    cell.assignedImage1.layer.borderWidth = 2.0f;
    cell.assignedImage1.layer.borderColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTertiary].CGColor : [[[LightDarkModeObject alloc] init] LightModeSecondary].CGColor;
    cell.assignedImage1.layer.cornerRadius = cell.assignedImage1.frame.size.height/2;
    cell.assignedImage1.contentMode = UIViewContentModeScaleAspectFill;
    
    cell.assignedImage2.layer.borderWidth = cell.assignedImage1.layer.borderWidth;
    cell.assignedImage2.layer.borderColor = cell.assignedImage1.layer.borderColor;
    cell.assignedImage2.layer.cornerRadius = cell.assignedImage1.layer.cornerRadius;
    cell.assignedImage2.contentMode = cell.assignedImage1.contentMode;
    
    cell.assignedImage3.layer.borderWidth = cell.assignedImage1.layer.borderWidth;
    cell.assignedImage3.layer.borderColor = cell.assignedImage1.layer.borderColor;
    cell.assignedImage3.layer.cornerRadius = cell.assignedImage1.layer.cornerRadius;
    cell.assignedImage3.contentMode = cell.assignedImage1.contentMode;
    
    cell.assignedImage4.layer.borderWidth = cell.assignedImage1.layer.borderWidth;
    cell.assignedImage4.layer.borderColor = cell.assignedImage1.layer.borderColor;
    cell.assignedImage4.layer.cornerRadius = cell.assignedImage1.layer.cornerRadius;
    cell.assignedImage4.contentMode = cell.assignedImage1.contentMode;
    
    cell.assignedImage5.layer.borderWidth = cell.assignedImage1.layer.borderWidth;
    cell.assignedImage5.layer.borderColor = cell.assignedImage1.layer.borderColor;
    cell.assignedImage5.layer.cornerRadius = cell.assignedImage1.layer.cornerRadius;
    cell.assignedImage5.contentMode = cell.assignedImage1.contentMode;
    
    if (TaskIsFullyCompleted == NO && TaskIsCompleteAsNeeded == NO) {
        
        [self GenerateItemAssignedToImageBorderColor:cell.assignedImage1 index:0 singleObjectItemDict:singleObjectItemDict itemType:itemType indexPath:indexPath];
        [self GenerateItemAssignedToImageBorderColor:cell.assignedImage2 index:1 singleObjectItemDict:singleObjectItemDict itemType:itemType indexPath:indexPath];
        [self GenerateItemAssignedToImageBorderColor:cell.assignedImage3 index:2 singleObjectItemDict:singleObjectItemDict itemType:itemType indexPath:indexPath];
        [self GenerateItemAssignedToImageBorderColor:cell.assignedImage4 index:3 singleObjectItemDict:singleObjectItemDict itemType:itemType indexPath:indexPath];
        [self GenerateItemAssignedToImageBorderColor:cell.assignedImage5 index:4 singleObjectItemDict:singleObjectItemDict itemType:itemType indexPath:indexPath];
        
    }
    
    
    
    
    
    //    for (UIButton *subView in cell.mainView.subviews) {
    //
    //        if (subView.tag == 100) {
    //
    //            [subView removeFromSuperview];
    //
    //        }
    //
    //    }
    //
    //    NSArray *itemTags = dictToUse[@"ItemTags"] && [(NSArray *)dictToUse[@"ItemTags"] count] > indexPath.row ? dictToUse[@"ItemTags"][indexPath.row] : [NSMutableArray array];
    //
    //    NSMutableArray *tagSubViews = [NSMutableArray array];
    //    CGFloat tabSubViewHeight = (height*0.21052632 > 12?(12):height*0.21052632);
    //
    //    int cellHeight = mainTableViewCellHeight;
    //
    //    int totalLines = 1;
    //
    //    for (int i=0; i<itemTags.count; i++) {
    //
    //        NSString *tagText = [NSString stringWithFormat:@"#%@", itemTags[i]];
    //
    //        BOOL changeYPos = false;
    //
    //        BOOL TagAlreadyAdded = NO;
    //
    //        for (UIButton *subView in cell.mainView.subviews) {
    //
    //            if (subView.tag == 100) {
    //
    //                [tagSubViews addObject:subView];
    //
    //                if ([subView.titleLabel.text isEqualToString:tagText]) {
    //                    TagAlreadyAdded = YES;
    //                }
    //
    //            }
    //
    //        }
    //
    //        if (TagAlreadyAdded == NO) {
    //
    //            NSString *tagText = [NSString stringWithFormat:@"#%@", itemTags[i]];
    //            CGFloat gapBetweenStartAndEndHorizontalTags = cell.checkmarkView.frame.origin.x;
    //            CGFloat gapBetweenTagsToUse = (width*0.01604278 > 6?(6):width*0.01604278);
    //            CGFloat yGapToUse = (height*0.10526316 > 6?(6):height*0.10526316);
    //            UIButton *lastHorizontalSubView = [(UIButton *)[tagSubViews lastObject] tag] == 100 ? [tagSubViews lastObject] : nil;
    //            CGFloat xPos = lastHorizontalSubView != nil ? lastHorizontalSubView.frame.origin.x + lastHorizontalSubView.frame.size.width + gapBetweenTagsToUse : gapBetweenStartAndEndHorizontalTags;
    //
    //            CGFloat tagWidth = [[[GeneralObject alloc] init] WidthOfString:tagText withFont:[UIFont systemFontOfSize:tabSubViewHeight*1.083333 weight:UIFontWeightSemibold]];
    //
    //            if (xPos + tagWidth > (cell.mainView.frame.size.width-(gapBetweenStartAndEndHorizontalTags*2))) {
    //
    //                xPos = gapBetweenStartAndEndHorizontalTags;
    //                changeYPos = true;
    //                totalLines += 1;
    //
    //            }
    //
    //            yGapToUse = totalLines == 1 ? (height*0.10526316 > 6?(6):height*0.10526316) : (height*0.14035088 > 8?(8):height*0.14035088);
    //
    //            CGFloat yPos = changeYPos == true ?
    //            lastHorizontalSubView.frame.origin.y + lastHorizontalSubView.frame.size.height + yGapToUse :
    //            lastHorizontalSubView.frame.origin.y != 0 ?
    //            lastHorizontalSubView.frame.origin.y : cell.subLabel.frame.origin.y + cell.subLabel.frame.size.height + yGapToUse;
    //
    //            UIButton *tagLabelSubview = [[UIButton alloc] initWithFrame:CGRectMake(xPos, yPos, tagWidth, tabSubViewHeight)];
    //            [tagLabelSubview.titleLabel setFont:[UIFont systemFontOfSize:tabSubViewHeight*1.083333 weight:UIFontWeightSemibold]];
    //            [tagLabelSubview setTitleColor:[UIColor colorWithRed:90.0f/255.0f green:123.0f/255.0f blue:165.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    //            tagLabelSubview.tag = 100;
    //            [tagLabelSubview setTitle:tagText forState:UIControlStateNormal];
    //            [tagLabelSubview addTarget:self action:@selector(TapGestureSelectTag:) forControlEvents:UIControlEventTouchUpInside];
    //            [cell.mainView addSubview:tagLabelSubview];
    //
    //        }
    //
    //    }
    //
    //    if (itemTags.count > 0) {
    //
    //        CGRect rect = cell.mainView.frame;
    //        rect.size.height = cell.subLabel.frame.origin.y + cell.subLabel.frame.size.height + (((height*0.14035088 > 8?(8):height*0.14035088))*(totalLines+1)) + tabSubViewHeight*totalLines;
    //        cell.mainView.frame = rect;
    //
    //        cellHeight += ((((height*0.14035088 > 8?(8):height*0.14035088))*(totalLines)) + tabSubViewHeight*totalLines);
    //
    //    }
    
    
    
    
    
    //    NSMutableArray *arr = [dataDisplaySectionsArray count] > indexPath.section && cellHeightsDicts[dataDisplaySectionsArray[indexPath.section]] ? [cellHeightsDicts[dataDisplaySectionsArray[indexPath.section]] mutableCopy] : [NSMutableArray array];
    //
    //    [arr addObject:[NSString stringWithFormat:@"%d", cellHeight]];
    //
    //    [cellHeightsDicts setObject:arr forKey:[dataDisplaySectionsArray count] > indexPath.section ? dataDisplaySectionsArray[indexPath.section] : @""];
    
    
    
    
    
    cell.checkmarkView.layer.borderColor = [UIColor clearColor].CGColor;
    cell.checkmarkView.layer.cornerRadius = cell.checkmarkView.frame.size.width/3;
    cell.selectedCellView.hidden = YES;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"TableView Event Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    NSString *selectedDayString = @"";
    NSString *selectedDayInCollectionView = @"0";
    
    selectedDayString = selectedDay[@"Day"] ? [NSString stringWithFormat:@"%d", [selectedDay[@"Day"] intValue]] : @"";
    selectedDayInCollectionView = selectedDayString ? [NSString stringWithFormat:@"%d", [selectedDayString intValue]] : @"0";
    
    
    NSDictionary *dict = eventDict && eventDict[selectedDayInCollectionView] && [(NSArray *)eventDict[selectedDayInCollectionView] count] > indexPath.row ? eventDict[selectedDayInCollectionView][indexPath.row] : @{};
    dict = dict[@"DictToUse"] ? [dict[@"DictToUse"] mutableCopy] : [NSDictionary dictionary];
    
    NSString *itemID = @"";
    NSString *itemOccurrenceID =  @"";
    
    itemID = dict[@"ItemID"] ? dict[@"ItemID"] : @"";
    itemOccurrenceID = dict[@"ItemOccurrenceID"] ? dict[@"ItemOccurrenceID"] : @"";
    
    if (dict[@"ItemAmount"]) {
        
        [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"ViewingExpenses"];
        [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"ViewingLists"];
        [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"ViewingChats"];
        
    } else if (dict[@"ItemListItems"]) {
        
        [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"ViewingExpenses"];
        [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"ViewingLists"];
        [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"ViewingChats"];
        
    } else if (dict[@"ItemSubtasks"]) {
        
        [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"ViewingExpenses"];
        [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"ViewingLists"];
        [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"ViewingChats"];
        
    }
    
    [[[PushObject alloc] init] PushToViewTaskViewController:itemID itemOccurrenceID:itemOccurrenceID itemDictFromPreviousPage:[dict mutableCopy] homeMembersArray:_homeMembersArray homeMembersDict:_homeMembersDict itemOccurrencesDict:_itemsOccurrencesDict folderDict:_folderDict taskListDict:_taskListDict templateDict:_templateDict draftDict:_draftDict notificationSettingsDict:_notificationSettingsDict topicDict:_topicDict itemNamesAlreadyUsed:_itemNamesAlreadyUsed allItemAssignedToArrays:_allItemAssignedToArrays allItemTagsArrays:_allItemTagsArrays allItemIDsArrays:_allItemTagsArrays currentViewController:self Superficial:NO];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat height = CGRectGetHeight(self.view.bounds);
    return (height*0.11005435 > 81?(81):height*0.11005435);
    
}

#pragma mark

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

    NSString *string = @"";//[self->sectionsArray objectAtIndex:section];

    [label setText:string];
    [view setBackgroundColor:self.view.backgroundColor];
    [label setBackgroundColor:[UIColor clearColor]];
    //[view addSubview:squareView];
    [view addSubview:label];

    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger )section {
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
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

#pragma mark - Notification Observer Methods

-(void)NSNotification_Calendar_MultiAddTask:(NSNotification *)notification {
    
    NSString *itemType = @"Chores";
    
    if (notification.userInfo && notification.userInfo[@"ItemAmount"]) {
        itemType = @"Expenses";
    } else if (notification.userInfo && notification.userInfo[@"ItemListItems"]) {
        itemType = @"Lists";
    }
    
    itemType = [[[GeneralObject alloc] init] GenerateItemType];
    
    if ([itemType isEqualToString:@"Chore"]) {
        
        _itemsDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"TempItemDict"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"TempItemDict"] mutableCopy] : [NSMutableDictionary dictionary];
        
    } else if ([itemType isEqualToString:@"Expense"]) {
        
        _itemsDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"TempItemDictNo1"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"TempItemDictNo1"] mutableCopy] : [NSMutableDictionary dictionary];
        
    } else if ([itemType isEqualToString:@"List"]) {
        
        _itemsDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"TempItemDictNo2"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"TempItemDictNo2"] mutableCopy] : [NSMutableDictionary dictionary];
        
    }
    
    if (self->_itemsDict == nil) {
        
        self->_itemsDict = [NSMutableDictionary dictionary];
    }
    
    NSDictionary *userInfo = notification.userInfo;
    
    for (NSString *itemUniqueID in [userInfo allKeys]) {
        
        NSMutableDictionary *setDataDict = [userInfo[itemUniqueID] mutableCopy];
        
        if ([self->_itemsDict[@"ItemUniqueID"] containsObject:setDataDict[@"ItemUniqueID"]] == NO) {
            
            for (NSString *key in [setDataDict allKeys]) {
                
                NSMutableArray *arr = self->_itemsDict[key] ? [self->_itemsDict[key] mutableCopy] : [NSMutableArray array];
                id object = setDataDict[key] ? setDataDict[key] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                [arr addObject:object];
                [self->_itemsDict setObject:arr forKey:key];
                
            }
            
        }
        
    }
    
    NSLog(@"Calendar _MultiAddTask %@", self->_itemsDict[@"ItemName"]);
    
    [self GenerateUpdatedItemDicts];
    
}

-(void)NSNotification_Calendar_AddTask:(NSNotification *)notification {
    
    NSString *itemType = @"Chores";
    
    if (notification.userInfo && notification.userInfo[@"ItemAmount"]) {
        itemType = @"Expenses";
    } else if (notification.userInfo && notification.userInfo[@"ItemListItems"]) {
        itemType = @"Lists";
    }
    
    itemType = [[[GeneralObject alloc] init] GenerateItemType];
    
    if ([itemType isEqualToString:@"Chore"]) {
        
        _itemsDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"TempItemDict"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"TempItemDict"] mutableCopy] : [NSMutableDictionary dictionary];
        
    } else if ([itemType isEqualToString:@"Expense"]) {
        
        _itemsDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"TempItemDictNo1"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"TempItemDictNo1"] mutableCopy] : [NSMutableDictionary dictionary];
        
    } else if ([itemType isEqualToString:@"List"]) {
        
        _itemsDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"TempItemDictNo2"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"TempItemDictNo2"] mutableCopy] : [NSMutableDictionary dictionary];
        
    }
    
    if (self->_itemsDict == nil) {
        
        self->_itemsDict = [NSMutableDictionary dictionary];
    }
    
    NSDictionary *userInfo = notification.userInfo;
    
    if ([self->_itemsDict[@"ItemUniqueID"] containsObject:userInfo[@"ItemUniqueID"]] == NO) {
        
        for (NSString *key in [userInfo allKeys]) {
            
            NSMutableArray *arr = self->_itemsDict[key] ? [self->_itemsDict[key] mutableCopy] : [NSMutableArray array];
            id object = userInfo[key] ? userInfo[key] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
            [arr addObject:object];
            [self->_itemsDict setObject:arr forKey:key];
            
        }
        
    }
    
    [self GenerateUpdatedItemDicts];
    
}

-(void)NSNotification_Calendar_EditTask:(NSNotification *)notification {
    
    NSString *itemType = @"Chores";
    
    if (notification.userInfo && notification.userInfo[@"ItemAmount"]) {
        itemType = @"Expenses";
    } else if (notification.userInfo && notification.userInfo[@"ItemListItems"]) {
        itemType = @"Lists";
    }
    
    itemType = [[[GeneralObject alloc] init] GenerateItemType];
    
    if ([itemType isEqualToString:@"Chore"]) {
        
        _itemsDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"TempItemDict"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"TempItemDict"] mutableCopy] : [NSMutableDictionary dictionary];
        
    } else if ([itemType isEqualToString:@"Expense"]) {
        
        _itemsDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"TempItemDictNo1"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"TempItemDictNo1"] mutableCopy] : [NSMutableDictionary dictionary];
        
    } else if ([itemType isEqualToString:@"List"]) {
        
        _itemsDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"TempItemDictNo2"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"TempItemDictNo2"] mutableCopy] : [NSMutableDictionary dictionary];
        
    }
    
    if (self->_itemsDict == nil) {
        
        self->_itemsDict = [NSMutableDictionary dictionary];
        
    }
    
    NSDictionary *userInfo = notification.userInfo;
    
    if ([self->_itemsDict[@"ItemUniqueID"] containsObject:userInfo[@"ItemUniqueID"]]) {
        
        NSUInteger indexOfObject = [self->_itemsDict[@"ItemUniqueID"] indexOfObject:userInfo[@"ItemUniqueID"]];
        
        for (NSString *key in [userInfo allKeys]) {
            
            NSMutableArray *arr = self->_itemsDict[key] ? [self->_itemsDict[key] mutableCopy] : [NSMutableArray array];
            id object = userInfo[key] ? userInfo[key] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
            if (arr.count  > indexOfObject) { [arr replaceObjectAtIndex:indexOfObject withObject:object]; }
            [self->_itemsDict setObject:arr forKey:key];
            
        }
        
    }
  
    [self GenerateUpdatedItemDicts];
    
}

-(void)NSNotification_Calendar_DeleteTask:(NSNotification *)notification {
    
    NSString *itemType = @"Chores";
    
    if (notification.userInfo && notification.userInfo[@"ItemAmount"]) {
        itemType = @"Expenses";
    } else if (notification.userInfo && notification.userInfo[@"ItemListItems"]) {
        itemType = @"Lists";
    }
    
    itemType = [[[GeneralObject alloc] init] GenerateItemType];
    
    if ([itemType isEqualToString:@"Chore"]) {
        
        _itemsDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"TempItemDict"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"TempItemDict"] mutableCopy] : [NSMutableDictionary dictionary];
        
    } else if ([itemType isEqualToString:@"Expense"]) {
        
        _itemsDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"TempItemDictNo1"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"TempItemDictNo1"] mutableCopy] : [NSMutableDictionary dictionary];
        
    } else if ([itemType isEqualToString:@"List"]) {
        
        _itemsDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"TempItemDictNo2"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"TempItemDictNo2"] mutableCopy] : [NSMutableDictionary dictionary];
        
    }
    
    if (self->_itemsDict == nil) {
        
        self->_itemsDict = [NSMutableDictionary dictionary];
    }
    
    NSDictionary *userInfo = notification.userInfo;
    
    if ([self->_itemsDict[@"ItemUniqueID"] containsObject:userInfo[@"ItemUniqueID"]]) {
        
        NSUInteger indexOfObject = [self->_itemsDict[@"ItemUniqueID"] indexOfObject:userInfo[@"ItemUniqueID"]];
        
        for (NSString *key in [userInfo allKeys]) {
            
            NSMutableArray *arr = self->_itemsDict[key] ? [self->_itemsDict[key] mutableCopy] : [NSMutableArray array];
            if (arr.count  > indexOfObject) { [arr removeObjectAtIndex:indexOfObject]; }
            [self->_itemsDict setObject:arr forKey:key];
            
        }
        
    }
 
    [self GenerateUpdatedItemDicts];
    
}

-(void)NSNotification_Calendar_AddHomeMember:(NSNotification *)notification {
    
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

#pragma mark General Methods

-(void)UpdateCalendarItemDict:(NSMutableDictionary *)itemsDict itemType:(NSString *)itemType {
    
    for (NSString *itemUniqueID in [itemsDict[@"ItemUniqueID"] mutableCopy]) {
        
        NSUInteger index = [itemsDict[@"ItemUniqueID"] indexOfObject:itemUniqueID];
        
        BOOL TaskIsValid = [[[BoolDataObject alloc] init] TaskIsValidToBeDisplayed:itemsDict index:index itemType:itemType homeMembersDict:_homeMembersDict keyArray:[itemsDict allKeys]];
        
        if (TaskIsValid == NO && [itemsDict[@"ItemUniqueID"] containsObject:itemUniqueID]) {
            
            NSUInteger index = [itemsDict[@"ItemUniqueID"] indexOfObject:itemUniqueID];
            
            for (NSString *key in [itemsDict allKeys]) {
                
                NSMutableArray *arr = itemsDict[key] ? [itemsDict[key] mutableCopy] : [NSMutableArray array];
                if ([arr count] > index) { [arr removeObjectAtIndex:index]; }
                [itemsDict setObject:arr forKey:key];
                
            }
            
        }
        
    }
    
}

-(NSMutableArray *)GenerateNumberOfValidTasksInArrayForm {
    
    NSMutableArray *arr = [NSMutableArray array];
    
    int totalNum = 0;
    
    for (NSString *itemID in self->_itemsDict[@"ItemID"]) {
        
        NSUInteger index = [self->_itemsDict[@"ItemUniqueID"] indexOfObject:itemID];
        NSString *itemOccurrenceID = self->_itemsDict[@"ItemOccurrenceID"] && [(NSArray *)self->_itemsDict[@"ItemOccurrenceID"] count] > index ? self->_itemsDict[@"ItemOccurrenceID"][index] : @"";
        NSString *itemTutorial = self->_itemsDict[@"ItemTutorial"] && [(NSArray *)self->_itemsDict[@"ItemTutorial"] count] > index ? self->_itemsDict[@"ItemTutorial"][index] : @"No";
        
        if ([itemOccurrenceID length] > 0) {
            totalNum -= 1;
        }
        if ([itemTutorial isEqualToString:@"Yes"]) {
            totalNum -= 1;
        }
        
        totalNum += 1;
        
    }
    
    totalNum = totalNum < 0 ? 0 : totalNum;
    
    for (int i=0;i<totalNum;i++) {
        [arr addObject:[NSString stringWithFormat:@"%d", i]];
    }
    
    return arr;
}

-(NSMutableArray *)GenerateAllItemAssignedToArrays:(NSMutableDictionary *)itemDict homeMembersDict:(NSMutableDictionary *)homeMembersDict {
    
    NSMutableArray *allItemAssignedToArraysCopy = itemDict && itemDict[@"ItemAssignedTo"] ? [itemDict[@"ItemAssignedTo"] mutableCopy] : [NSMutableArray array];
    NSMutableArray *allItemAssignedToArrays = [NSMutableArray array];
    
    for (int i=0 ; i<allItemAssignedToArraysCopy.count ; i++) {
        
        NSMutableArray *itemAssignedToCopy = allItemAssignedToArraysCopy[i];
        
        NSMutableArray *tempArr = [NSMutableArray array];
        
        for (NSString *userID in itemAssignedToCopy) {
            
            if (homeMembersDict && homeMembersDict[@"UserID"] && [homeMembersDict[@"UserID"] containsObject:userID]) {
                
                if ([homeMembersDict[@"UserID"] containsObject:userID]) {
                    
                    NSUInteger index = [homeMembersDict[@"UserID"] indexOfObject:userID];
                    NSString *username = homeMembersDict[@"Username"] && [(NSArray *)homeMembersDict[@"Username"] count] > index ? homeMembersDict[@"Username"][index] : @"";
                    [tempArr addObject:username];
                    
                }
                
            }
            
        }
        
        [allItemAssignedToArrays addObject:tempArr];
        
    }
    
    return allItemAssignedToArrays;
}

-(NSMutableArray *)GenerateAllItemTagsArrays:(NSMutableDictionary *)itemDict {
    
    NSMutableArray *allItemTagsArrays = [NSMutableArray array];
    
    if (itemDict && itemDict[@"ItemTags"]) {
        
        for (NSMutableArray *itemTagsArray in itemDict[@"ItemTags"]) {
            
            for (NSString *itemTag in itemTagsArray) {
                
                if ([allItemTagsArrays containsObject:itemTag] == NO) {
                    
                    [allItemTagsArrays addObject:itemTag];
                    
                }
                
            }
            
        }
        
    }
    
    return allItemTagsArrays;
}

#pragma mark - IBAction Methods

-(void)CompleteUncompleteTaskAction_DisplayUnclickableError:(NSMutableDictionary *)singleObjectItemDict itemType:(NSString *)itemType {
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:singleObjectItemDict[@"ItemUniqueID"]]) {
        
        [[NSUserDefaults standardUserDefaults] setObject:@"Clicked" forKey:singleObjectItemDict[@"ItemUniqueID"]];
        
    } else if ([[NSUserDefaults standardUserDefaults] objectForKey:singleObjectItemDict[@"ItemUniqueID"]] &&
               [[[NSUserDefaults standardUserDefaults] objectForKey:singleObjectItemDict[@"ItemUniqueID"]] isEqualToString:@"Clicked"]) {
        
        if ([singleObjectItemDict[@"ItemItemized"] isEqualToString:@"Yes"]) {
            
            [[[GeneralObject alloc] init] CreateAlert:@"Oops!" message:[NSString stringWithFormat:@"You are unable to complete this %@ on this page because it is itemized.", [itemType lowercaseString]] currentViewController:self];
            
        } else if ([itemType isEqualToString:@"List"]) {
            
            [[[GeneralObject alloc] init] CreateAlert:@"Oops!" message:[NSString stringWithFormat:@"You are unable to complete a %@ on this page.", [itemType lowercaseString]] currentViewController:self];
            
        } else if ([singleObjectItemDict[@"ItemAssignedTo"] containsObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] == NO) {
            
            [[[GeneralObject alloc] init] CreateAlert:@"Oops!" message:[NSString stringWithFormat:@"You are unable to complete this %@ because you are not assigned to it.", [itemType lowercaseString]] currentViewController:self];
            
        } else if ([singleObjectItemDict[@"ItemTurnUserID"] isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] == NO) {
            
            [[[GeneralObject alloc] init] CreateAlert:@"Oops!" message:[NSString stringWithFormat:@"You are unable to complete this %@ because it is not your turn.", [itemType lowercaseString]] currentViewController:self];
            
        } else {
            
            [[[GeneralObject alloc] init] CreateAlert:@"Oops!" message:[NSString stringWithFormat:@"You are unable to complete this %@.", [itemType lowercaseString]] currentViewController:self];
            
        }
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:singleObjectItemDict[@"ItemUniqueID"]];
        
    }
    
}

-(void)CompleteUncomplete_GenerateUpdateDueDateAlertView:(NSMutableDictionary *)singleObjectItemDict itemType:(NSString *)itemType completionHandler:(void (^)(BOOL finished, NSMutableDictionary *singleObjectItemDict))finishBlock {
    
    BOOL TaskWasCreatedBySpecificUser = [[[BoolDataObject alloc] init] TaskWasCreatedBySpecificUser:singleObjectItemDict itemType:itemType userID:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
    BOOL TaskIsRepeating = [[[BoolDataObject alloc] init] TaskIsRepeating:singleObjectItemDict itemType:itemType];
    BOOL TaskIsRepeatingDaily = [[[BoolDataObject alloc] init] TaskIsRepeatingDaily:[@{@"ItemRepeats" : singleObjectItemDict[@"ItemRepeats"]} mutableCopy] itemType:itemType];
    
    BOOL DontShowAgainClicked =
    ([[NSUserDefaults standardUserDefaults] objectForKey:@"DontShowUpdatePopup"] &&
     [[NSUserDefaults standardUserDefaults] objectForKey:@"DontShowUpdatePopup"][@"DontShowAgain"] &&
     [[[NSUserDefaults standardUserDefaults] objectForKey:@"DontShowUpdatePopup"][@"DontShowAgain"] isEqualToString:@"Yes"]) ||
    
    ([[NSUserDefaults standardUserDefaults] objectForKey:@"DontShowUpdatePopup"] &&
     [[NSUserDefaults standardUserDefaults] objectForKey:@"DontShowUpdatePopup"][singleObjectItemDict[@"ItemID"]] &&
     [[[NSUserDefaults standardUserDefaults] objectForKey:@"DontShowUpdatePopup"][singleObjectItemDict[@"ItemID"]] isEqualToString:@"Yes"]);
    
    NSDate *currentDate = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:@"MMMM dd, yyyy hh:mm a" returnAs:[NSDate class]];
    NSDate *itemDueDate = [[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:@"MMMM dd, yyyy hh:mm a" dateToConvert:singleObjectItemDict[@"ItemDueDate"] returnAs:[NSDate class]];
    
    BOOL TaskIsPastDue = [currentDate timeIntervalSinceDate:itemDueDate] > 0;
    
    if (TaskWasCreatedBySpecificUser == YES && TaskIsPastDue == YES && TaskIsRepeating == YES && TaskIsRepeatingDaily == NO && DontShowAgainClicked == NO) {
        
        NSString *originalDate = [[[GeneralObject alloc] init] GenerateDateWithConvertedFormatWithFormat:@"MMMM dd, yyyy hh:mm a" dateToConvert:singleObjectItemDict[@"ItemDueDate"] newFormat:@"MMMM d, yyyy" returnAs:[NSString class]];
        NSString *currentDate = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:@"MMMM d, yyyy" returnAs:[NSString class]];
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDate *originalDateInDateForm = [[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:@"MMMM dd, yyyy" dateToConvert:originalDate returnAs:[NSDate class]];
        NSDate *currentDateInDateForm = [[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:@"MMMM d, yyyy" dateToConvert:currentDate returnAs:[NSDate class]];
        
        // Get the weekday
        NSDateComponents *weekdayComponentsOriginalDate = [calendar components:NSCalendarUnitWeekday fromDate:originalDateInDateForm];
        NSString *weekdayStrOriginalDate = [calendar weekdaySymbols][[weekdayComponentsOriginalDate weekday] - 1];
        
        NSDateComponents *weekdayComponentsCurrentDate = [calendar components:NSCalendarUnitWeekday fromDate:currentDateInDateForm];
        NSString *weekdayStrCurrentDate = [calendar weekdaySymbols][[weekdayComponentsCurrentDate weekday] - 1];
        
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Update Task?"
                                                                            message:[NSString stringWithFormat:@"This task was originally scheduled for %@, %@ but was completed on %@, %@. Would you like to reschedule this chore for %@'s instead?", weekdayStrOriginalDate, originalDate, weekdayStrCurrentDate, currentDate, weekdayStrCurrentDate]
                                                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *original = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"Original - %@", originalDate]
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
            
            finishBlock(YES, singleObjectItemDict);
            
        }];
        
        UIAlertAction *completed = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"Completed - %@", currentDate]
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * _Nonnull action) {
            
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSDate *currentDate = [NSDate date];
            
            // Get the weekday
            NSDateComponents *weekdayComponents = [calendar components:NSCalendarUnitWeekday fromDate:currentDate];
            NSInteger weekday = [weekdayComponents weekday]; // Sunday: 1, Monday: 2, ..., Saturday: 7
            NSString *weekdayStr = [calendar weekdaySymbols][[weekdayComponents weekday] - 1];
            
            // Get the day of the month
            NSDateComponents *dayComponents = [calendar components:NSCalendarUnitDay fromDate:currentDate];
            NSInteger day = [dayComponents day];
            
            NSString *ending;
            
            if (day >= 11 && day <= 13) {
                ending = @"th";
            } else {
                NSInteger lastDigit = day % 10;
                
                switch (lastDigit) {
                    case 1:
                        ending = @"st";
                        break;
                    case 2:
                        ending = @"nd";
                        break;
                    case 3:
                        ending = @"rd";
                        break;
                    default:
                        ending = @"th";
                        break;
                }
            }
            
            NSString *dayString = [NSString stringWithFormat:@"%ld%@", (long)day, ending];
            
            
            // Printing the weekday and day of the month
            NSLog(@"Current weekday: %ld", (long)weekday);
            NSLog(@"Current day of the month: %ld", (long)day);
            
            BOOL TaskIsRepeatingWeekly = [[[BoolDataObject alloc] init] TaskIsRepeatingWeekly:[@{@"ItemRepeats" : singleObjectItemDict[@"ItemRepeats"]} mutableCopy] itemType:itemType];
            BOOL TaskIsRepeatingMonthly = [[[BoolDataObject alloc] init] TaskIsRepeatingMonthly:[@{@"ItemRepeats" : singleObjectItemDict[@"ItemRepeats"]} mutableCopy] itemType:itemType];
            
            if (TaskIsRepeatingWeekly == YES) {
                [singleObjectItemDict setObject:weekdayStr forKey:@"ItemDays"];
            } else if (TaskIsRepeatingMonthly == YES) {
                [singleObjectItemDict setObject:dayString forKey:@"ItemDays"];
            }
            
            NSString *newItemDueDate = [[[NotificationsObject alloc] init] GenerateArrayOfRepeatingDueDates:singleObjectItemDict[@"ItemRepeats"] itemRepeatIfCompletedEarly:singleObjectItemDict[@"ItemRepeatIfCompletedEarly"] itemCompleteAsNeeded:singleObjectItemDict[@"ItemCompleteAsNeeded"] totalAmountOfFutureDates:2 maxAmountOfDueDatesToLoopThrough:1000 itemDatePosted:singleObjectItemDict[@"ItemDatePosted"] itemDueDate:singleObjectItemDict[@"ItemDueDate"] itemStartDate:singleObjectItemDict[@"ItemStartDate"] itemEndDate:singleObjectItemDict[@"ItemEndDate"] itemTime:singleObjectItemDict[@"ItemTime"] itemDays:singleObjectItemDict[@"ItemDays"] itemDueDatesSkipped:singleObjectItemDict[@"ItemDueDatesSkipped"] itemDateLastReset:singleObjectItemDict[@"ItemDateLastReset"] SkipStartDate:NO][0];
            
            [singleObjectItemDict setObject:newItemDueDate forKey:@"ItemDueDate"];
            
            NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
            
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"itemUniqueID == %@", singleObjectItemDict[@"ItemUniqueID"]];
            [[[SetDataObject alloc] init] SetDataEditCoreData:[NSString stringWithFormat:@"%@s", itemType] predicate:predicate setDataObject:@{@"ItemDays" : singleObjectItemDict[@"ItemDays"], @"ItemDueDate" : singleObjectItemDict[@"ItemDueDate"]}];
            
            [[[SetDataObject alloc] init] UpdateDataEditItem:@{@"ItemUniqueID" : singleObjectItemDict[@"ItemUniqueID"], @"ItemDays" : singleObjectItemDict[@"ItemDays"], @"ItemDueDate" : singleObjectItemDict[@"ItemDueDate"]} itemID:singleObjectItemDict[@"ItemID"] itemOccurrenceID:singleObjectItemDict[@"ItemOccurrenceID"] collection:[NSString stringWithFormat:@"%@s", itemType] homeID:homeID completionHandler:^(BOOL finished) {
                
                finishBlock(YES, singleObjectItemDict);
                
            }];
            
        }];
        
        UIAlertAction *dontShowAgainForThisTask = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"Don't Show Again For This %@", [[[GeneralObject alloc] init] GenerateItemType]]
                                                                           style:UIAlertActionStyleDefault
                                                                         handler:^(UIAlertAction * _Nonnull action) {
            
            NSMutableDictionary *dontShowUpdatePopup = [[NSUserDefaults standardUserDefaults] objectForKey:@"DontShowUpdatePopup"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"DontShowUpdatePopup"] mutableCopy] : [NSMutableDictionary dictionary];
            
            [dontShowUpdatePopup setObject:@"Yes" forKey:singleObjectItemDict[@"ItemID"]];
            
            [[NSUserDefaults standardUserDefaults] setObject:dontShowUpdatePopup forKey:@"DontShowUpdatePopup"];
            
            finishBlock(YES, singleObjectItemDict);
            
            
        }];
        
        UIAlertAction *dontShowAgain = [UIAlertAction actionWithTitle:@"Don't Show Again"
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * _Nonnull action) {
            
            NSMutableDictionary *dontShowUpdatePopup = [[NSUserDefaults standardUserDefaults] objectForKey:@"DontShowUpdatePopup"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"DontShowUpdatePopup"] mutableCopy] : [NSMutableDictionary dictionary];
            
            [dontShowUpdatePopup setObject:@"Yes" forKey:@"DontShowAgain"];
            
            [[NSUserDefaults standardUserDefaults] setObject:dontShowUpdatePopup forKey:@"DontShowUpdatePopup"];
            
            finishBlock(YES, singleObjectItemDict);
            
            
        }];
        
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                         style:UIAlertActionStyleCancel
                                                       handler:^(UIAlertAction * _Nonnull action) {
            
            finishBlock(YES, singleObjectItemDict);
            
        }];
        
        [controller addAction:original];
        [controller addAction:completed];
        [controller addAction:dontShowAgain];
        [controller addAction:dontShowAgainForThisTask];
        [controller addAction:cancel];
        [self presentViewController:controller animated:YES completion:nil];
        
    } else {
        
        finishBlock(YES, singleObjectItemDict);
        
    }
    
}

-(void)CompleteUncompleteTaskAction_DisplayRepeatIfCompletedEarlyResetDropDown:(NSMutableDictionary *)returningDictToUse TaskIsFullyCompleted:(BOOL)TaskIsFullyCompleted indexPath:(NSIndexPath *)indexPath {
    
    BOOL TaskIsOccurrence = [[[BoolDataObject alloc] init] TaskIsOccurrence:returningDictToUse itemType:returningDictToUse[@"ItemType"]];
    BOOL TaskIsRepeatingAndRepeatingIfCompletedEarly = [[[BoolDataObject alloc] init] TaskIsRepeatingAndRepeatingIfCompletedEarly:returningDictToUse itemType:returningDictToUse[@"ItemType"]];
    BOOL TaskIsRepeating = [[[BoolDataObject alloc] init] TaskIsRepeating:returningDictToUse itemType:returningDictToUse[@"ItemType"]];
    BOOL TaskIsRepeatingAsNeeded = [[[BoolDataObject alloc] init] TaskIsRepeatingAsNeeded:returningDictToUse itemType:returningDictToUse[@"ItemType"]];
    BOOL TaskIsRepeatingWhenCompleted = [[[BoolDataObject alloc] init] TaskIsRepeatingWhenCompleted:returningDictToUse itemType:returningDictToUse[@"ItemType"]];
    BOOL TaskIsRepeatingDaily = [[[BoolDataObject alloc] init] TaskIsRepeatingDaily:returningDictToUse itemType:returningDictToUse[@"ItemType"]];
    BOOL TaskIsRepeatingWeekly = [[[BoolDataObject alloc] init] TaskIsRepeatingWeekly:returningDictToUse itemType:returningDictToUse[@"ItemType"]];
    BOOL TaskIsRepeatingMonthly = [[[BoolDataObject alloc] init] TaskIsRepeatingMonthly:returningDictToUse itemType:returningDictToUse[@"ItemType"]];
    BOOL TaskHasAnyDay = [[[BoolDataObject alloc] init] TaskHasAnyDay:returningDictToUse itemType:returningDictToUse[@"ItemType"]];
    
    if (TaskIsFullyCompleted == YES && TaskIsOccurrence == NO && TaskIsRepeatingAndRepeatingIfCompletedEarly == YES && TaskIsRepeating == YES && TaskIsRepeatingAsNeeded == NO && TaskIsRepeatingWhenCompleted == NO &&
        
        ((TaskIsRepeatingDaily == YES) ||
         ((TaskIsRepeatingWeekly == YES || TaskIsRepeatingMonthly == YES) && TaskHasAnyDay == YES))) {
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSString *repeatIfCompletedEarlyDropDownText = [self CompleteUncompleteTaskAction_GenerateRepeatIfCompletedEarlyDrowDownText:returningDictToUse];
            self->_notificationitemReminderLabel.text = repeatIfCompletedEarlyDropDownText;
            
            
            
            CGFloat navigationBarHeight = [[[GeneralObject alloc] init] GetNavigationBarHeight:self];
            
            [UIView animateWithDuration:0.25 animations:^{
                
                self->_notificationReminderView.frame = CGRectMake(0, navigationBarHeight, self.view.frame.size.width, self.view.frame.size.height*0.07201 > 53?(53):self.view.frame.size.height*0.07201);
                
                CGFloat yToUse = self->_notificationReminderView.frame.origin.y + self->_notificationReminderView.frame.size.height + self.view.frame.size.height*0.01630435;
                
                CGRect newRect = self->_customCollectionView.frame;
                newRect.origin.y = (indexPath.item >= 7 && indexPath.item <= 13) ? self->_notificationReminderView.frame.origin.y + self->_notificationReminderView.frame.size.height : newRect.origin.y + self->_notificationReminderView.frame.size.height;
                self->_customCollectionView.frame = newRect;
                
                newRect = self->_lineView.frame;
                newRect.origin.y = self->_customCollectionView.frame.size.height;
                self->_lineView.frame = newRect;
                
                newRect = self->_customTableView.frame;
                newRect.origin.y = newRect.origin.y + (self.view.frame.size.height*0.07201 > 53?(53):self.view.frame.size.height*0.07201);
                newRect.size.height = newRect.size.height - (self.view.frame.size.height*0.07201 > 53?(53):self.view.frame.size.height*0.07201);
                self->_customTableView.frame = newRect;
                
                CGFloat width = CGRectGetWidth(self.notificationReminderView.bounds);
                CGFloat height = CGRectGetHeight(self.notificationReminderView.bounds);
                
                self->_notificationReminderSeparator.frame = CGRectMake(0, 0, width, 0);
                self->_notificationitemReminderLabel.frame = CGRectMake(width*0.028985, height*0.5 - (((height*0.5471698)*0.5)), width - (width*0.028985)*2, height*0.5471698);
                self->_notificationitemReminderImage.hidden = YES;
                
                self->_notificationitemReminderLabel.font = [UIFont systemFontOfSize:height*0.413793 weight:UIFontWeightBold];
                self->_notificationitemReminderLabel.adjustsFontSizeToFitWidth = YES;
                
            } completion:^(BOOL finished) {
                
                [UIView animateWithDuration:0.25 delay:7.5 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                    
                    self->_notificationReminderView.frame = CGRectMake(0, 0, self.view.frame.size.width, navigationBarHeight);
                    
                    CGRect newRect = self->_customCollectionView.frame;
                    newRect.origin.y = (indexPath.item >= 7 && indexPath.item <= 13) ? navigationBarHeight : newRect.origin.y - self->_notificationReminderView.frame.size.height;
                    self->_customCollectionView.frame = newRect;
                    
                    newRect = self->_lineView.frame;
                    newRect.origin.y = self->_customCollectionView.frame.size.height;
                    self->_lineView.frame = newRect;
                    
                    newRect = self->_customTableView.frame;
                    newRect.origin.y = newRect.origin.y - (self.view.frame.size.height*0.07201 > 53?(53):self.view.frame.size.height*0.07201);
                    newRect.size.height = newRect.size.height + (self.view.frame.size.height*0.07201 > 53?(53):self.view.frame.size.height*0.07201);
                    self->_customTableView.frame = newRect;
                    
                    CGFloat width = CGRectGetWidth(self.notificationReminderView.bounds);
                    CGFloat height = CGRectGetHeight(self.notificationReminderView.bounds);
                    
                    height = self.view.frame.size.height*0.07201 > 53?(53):self.view.frame.size.height*0.07201;
                    
                    self->_notificationReminderSeparator.frame = CGRectMake(0, 0, width, 0);
                    self->_notificationitemReminderLabel.frame = CGRectMake(width*0.028985, height*0.5 - (((height*0.5471698)*0.5)), width - (width*0.028985)*2, height*0.5471698);
                    self->_notificationitemReminderImage.hidden = YES;
                    
                    self->_notificationitemReminderLabel.font = [UIFont systemFontOfSize:height*0.413793 weight:UIFontWeightBold];
                    self->_notificationitemReminderLabel.adjustsFontSizeToFitWidth = YES;
                    
                } completion:nil];
                
            }];
            
        });
        
    }
    
}

-(void)CompleteUncomplete_GenerateUpdatedData:(NSMutableDictionary *)returningDictToUse returningOccurrencesDictToUse:(NSMutableDictionary *)returningOccurrencesDictToUse returningUpdatedTaskListDictToUse:(NSMutableDictionary *)returningUpdatedTaskListDictToUse selectedDayInCollectionView:(NSString *)selectedDayInCollectionView indexPath:(NSIndexPath *)indexPath keyArray:(NSArray *)keyArray singleObjectItemDict:(NSMutableDictionary *)singleObjectItemDict {
    
    for (NSString *key in keyArray) {
        id object = returningDictToUse[key] ? returningDictToUse[key] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
        [singleObjectItemDict setObject:object forKey:key];
    }
    
    self->_itemsOccurrencesDict = [returningOccurrencesDictToUse mutableCopy];
    self->_taskListDict = [[[GeneralObject alloc] init] GenerateUpdatedTaskListDict:@[returningUpdatedTaskListDictToUse] taskListDict:self->_taskListDict];
    
    [[[GeneralObject alloc] init] CallNSNotificationMethods:@"EditTask" userInfo:singleObjectItemDict locations:@[@"Tasks"]];
    
    NSMutableDictionary *tempEventDict = [self->eventDict mutableCopy];
    NSMutableArray *selectedDay = [self->eventDict[selectedDayInCollectionView] mutableCopy];
    NSMutableDictionary *tempDict = [self->eventDict[selectedDayInCollectionView][indexPath.row] mutableCopy];
    
    [tempDict setObject:singleObjectItemDict forKey:@"DictToUse"];
    [selectedDay replaceObjectAtIndex:indexPath.row withObject:tempDict];
    [tempEventDict setObject:selectedDay forKey:selectedDayInCollectionView];
    self->eventDict = [tempEventDict mutableCopy];
   
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.customTableView reloadData];
        [self.customCollectionView reloadData];
        
        [self->progressView setHidden:YES];
        
    });
    
}

#pragma mark - Collection View Methods

-(NSString *)GenerateStringToDay:(NSString *)weekday {
    
    if ([weekday isEqualToString:@"Sunday"]) {
        return @"0";
    } else if ([weekday isEqualToString:@"Monday"]) {
        return @"1";
    } else if ([weekday isEqualToString:@"Tuesday"]) {
        return @"2";
    } else if ([weekday isEqualToString:@"Wednesday"]) {
        return @"3";
    } else if ([weekday isEqualToString:@"Thursday"]) {
        return @"4";
    } else if ([weekday isEqualToString:@"Friday"]) {
        return @"5";
    } else if ([weekday isEqualToString:@"Saturday"]) {
        return @"6";
    }
    
    return @"";
}

-(void)GenerateDictAndColorForDueDate:(NSString *)itemDueDate dueDateToCheck:(NSString *)dueDateToCheck dueDateToCheckMaximumDigits:(NSString *)dueDateToCheckMaximumDigits itemType:(NSString *)itemType singleObjectItemDict:(NSMutableDictionary *)singleObjectItemDict eventInnerDict:(NSMutableArray *)eventInnerDict {
    
    NSArray *itemDueDateArray = [itemDueDate containsString:@" "] ? [itemDueDate componentsSeparatedByString:@" "] : @[];
    NSString *month = [itemDueDateArray count] > 0 ? itemDueDateArray[0] : @"";
    NSString *day = [itemDueDateArray count] > 1 ? itemDueDateArray[1] : @"";
    NSString *year = [itemDueDateArray count] > 2 ? itemDueDateArray[2] : @"";
    NSString *itemDueDateMonthDayYear = [NSString stringWithFormat:@"%@ %@ %@", month, day, year];
    
    NSMutableArray *sortSelectedDefaultUser = [[NSUserDefaults standardUserDefaults] objectForKey:@"SortSelectedDefaultUserCalendar"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"SortSelectedDefaultUserCalendar"] mutableCopy] : [NSMutableArray array];
    
    BOOL TaskCanBeCompletedInTaskBySpecificUser = NO;
    
    for (NSString *username in sortSelectedDefaultUser) {
        
        NSDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"Username" object:username homeMembersDict:_homeMembersDict];
        NSString *userID = dataDict[@"UserID"];
        
        TaskCanBeCompletedInTaskBySpecificUser = [[[BoolDataObject alloc] init] TaskCanBeCompletedInTaskBySpecificUser:singleObjectItemDict itemType:itemType userID:userID homeMembersDict:_homeMembersDict];
      
        if (TaskCanBeCompletedInTaskBySpecificUser == YES) {
            break;
        }
    }
    
    if (([itemDueDateMonthDayYear isEqualToString:dueDateToCheck] || [itemDueDateMonthDayYear isEqualToString:dueDateToCheckMaximumDigits]) &&
        ([sortSelectedDefaultUser count] == 0 || TaskCanBeCompletedInTaskBySpecificUser == YES) ) {
        
        NSString *colorToAdd = _calendarSettings && _calendarSettings[@"DueDates"] && _calendarSettings[@"DueDates"][itemType] ? _calendarSettings[@"DueDates"][itemType] : @"Red";
        [colorsArray addObject:colorToAdd];
        
        NSString *eventTitle = [self GenerateEventTitleForDueDate:singleObjectItemDict];
        NSString *eventBody = [self GenerateEventBodyForDueDate:singleObjectItemDict];
        
        NSDictionary *dict = @{@"Title" : eventTitle, @"Body" : eventBody, @"DictToUse" : singleObjectItemDict, @"Color" : colorToAdd};
        
        [eventInnerDict addObject:dict];
        
    }
    
}

-(void)GenerateDictAndColorForDatePosted:(NSString *)itemDatePosted datePostedToCheck:(NSString *)datePostedToCheck itemType:(NSString *)itemType singleObjectItemDict:(NSMutableDictionary *)singleObjectItemDict eventInnerDict:(NSMutableArray *)eventInnerDict {
    
    NSMutableArray *sortSelectedDefaultUser = [[NSUserDefaults standardUserDefaults] objectForKey:@"SortSelectedDefaultUserCalendar"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"SortSelectedDefaultUserCalendar"] mutableCopy] : [NSMutableArray array];
    
    BOOL TaskCanBeCompletedInTaskBySpecificUser = NO;
    
    for (NSString *userID in sortSelectedDefaultUser) {
        TaskCanBeCompletedInTaskBySpecificUser = [[[BoolDataObject alloc] init] TaskCanBeCompletedInTaskBySpecificUser:singleObjectItemDict itemType:itemType userID:userID homeMembersDict:_homeMembersDict];
    }
        
    if ([sortSelectedDefaultUser count] == 0 || TaskCanBeCompletedInTaskBySpecificUser == YES) {
        
        if ([itemDatePosted containsString:datePostedToCheck]) {
            
            NSString *colorToAdd = _calendarSettings && _calendarSettings[@"DatePosted"] && _calendarSettings[@"DatePosted"][itemType] ? _calendarSettings[@"DatePosted"][itemType] : @"Green";
            [colorsArray addObject:colorToAdd];
            
            NSString *eventTitle = [self GenerateEventTitleForDatePosted:singleObjectItemDict];
            NSString *eventBody = [self GenerateEventBodyForDatePosted:datePostedToCheck singleObjectItemDict:singleObjectItemDict];
            
            NSDictionary *dict = @{@"Title" : eventTitle, @"Body" : eventBody, @"DictToUse" : singleObjectItemDict, @"Color" : colorToAdd};
            
            [eventInnerDict addObject:dict];
            
        }
        
    }
    
}

#pragma mark

-(NSString *)GenerateStartingDay:(BOOL)CurrentMonth {
    
    NSDictionary *dict = CurrentMonth ? [self GenerateCurrentDayMonthAndYearDict] : [self GenerateCurrentLabelMonthAndYearDict];
    NSString *currentMonth = dict[@"Month"];
    NSString *currentYear = dict[@"Year"];
    
    NSDateFormatter *dateFormatter = [[[GeneralObject alloc] init] GenerateDateFormatWithString:@"MMMM yyyy"];
    NSDate *dueDateInDateForm = [dateFormatter dateFromString:[NSString stringWithFormat:@"%@ %@", currentMonth, currentYear]];
    NSDateComponents *componentsForDueDate = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitWeekOfYear|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:dueDateInDateForm];
    
    NSDate *dueDate = [[NSCalendar currentCalendar] dateFromComponents:componentsForDueDate];
    
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE"];
    
    NSString *startingDay = [dateFormatter stringFromDate:dueDate];
    
    return startingDay;
}

-(NSDictionary *)GenerateCurrentDayMonthAndYearDict {
    
    NSDate *date = [NSDate date];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MMMM"];
    NSString *currentMonth = [format stringFromDate:date] ? [format stringFromDate:date] : @"";
    
    [format setDateFormat:@"YYYY"];
    NSString *currentYear = [format stringFromDate:date] ? [format stringFromDate:date] : @"";
    
    [format setDateFormat:@"dd"];
    NSString *currentDay = [format stringFromDate:date] ? [format stringFromDate:date] : @"";
    
    return @{@"Day" : currentDay, @"Month" : currentMonth, @"Year" : currentYear};
}

-(NSDictionary *)GenerateCurrentLabelMonthAndYearDict {
    
    NSArray *monthLabelArr = [monthViewLabel.text containsString:@", "] ? [monthViewLabel.text componentsSeparatedByString:@", "] : @[];
    NSString *currentMonth = [monthLabelArr count] > 0 ? monthLabelArr[0] : @"";
    NSString *currentYear = [monthLabelArr count] > 1 ? monthLabelArr[1] : @"";
    
    return @{@"Month" : currentMonth, @"Year" : currentYear};
}

-(NSMutableArray *)GenerateSortedEventInnerDict:(NSMutableArray *)eventInnerDict {
    
    NSMutableArray *timeArray = [NSMutableArray array];
    
    for (NSDictionary *dict in eventInnerDict) {
        
        NSMutableDictionary *singleObjectItemDict = dict[@"DictToUse"] ? [dict[@"DictToUse"] mutableCopy] : [NSMutableDictionary dictionary];
        [timeArray addObject:singleObjectItemDict[@"ItemTime"] ? singleObjectItemDict[@"ItemTime"] : @"11:59 PM"];
        
    }
   
    NSMutableArray *sortedArray = [[timeArray sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        NSDate *d1 = [[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:@"hh:mm a" dateToConvert:obj1 returnAs:[NSDate class]];
        NSDate *d2 = [[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:@"hh:mm a" dateToConvert:obj2 returnAs:[NSDate class]];
        
        return [d1 compare: d2];
    }] mutableCopy];
    
    NSMutableArray *tempArr = [sortedArray mutableCopy];
    
    for (int i=0 ; i<[tempArr count] ; i++) {
        NSString *itemTime = tempArr[i];
        if ([itemTime isEqualToString:@"Any Time"]) {
            [sortedArray removeObjectAtIndex:i];
            [sortedArray addObject:itemTime];
        }
    }
    
    NSMutableArray *sortedEventInnerDict = [NSMutableArray array];
    
    NSMutableArray *itemTimeArrayTemp = [timeArray mutableCopy];
    
    for (int i=0;i<sortedArray.count;i++) {
        
        NSString *sortedTime = [sortedArray[i] mutableCopy];
        
        if ([itemTimeArrayTemp containsObject:sortedTime] || [itemTimeArrayTemp containsObject:sortedTime]) {
            
            NSUInteger index = [itemTimeArrayTemp indexOfObject:sortedTime];
            
            NSDictionary *dictToFind = eventInnerDict && eventInnerDict[index] ? eventInnerDict[index] : @{};
            
            [sortedEventInnerDict addObject:dictToFind];
           
            if ([itemTimeArrayTemp count] > index) { [itemTimeArrayTemp replaceObjectAtIndex:index withObject:@"xxx"]; }
            
        }
        
    }
    
    eventInnerDict = [sortedEventInnerDict mutableCopy];
    
    return eventInnerDict;
}

#pragma mark - Table View CellForRow Methods

-(UIImage * _Nullable)GenerateitemPriorityImage:(NSMutableDictionary *)singleObjectItemDict indexPath:(NSIndexPath *)indexPath {
    
    NSString *itemPriority = singleObjectItemDict[@"ItemPriority"] ? singleObjectItemDict[@"ItemPriority"] : @"";
    
    UIImage *imageToReturn = nil;
    
    if ([itemPriority isEqualToString:@"High"]) {
        
        imageToReturn = [UIImage imageNamed:@"MainCellIcons.HighPriority"];
        
    } else if ([itemPriority isEqualToString:@"Medium"]) {
        
        imageToReturn = [UIImage imageNamed:@"MainCellIcons.MediumPriority"];
        
    } else if ([itemPriority isEqualToString:@"Low"]) {
        
        imageToReturn = [UIImage imageNamed:@"MainCellIcons.LowPriority"];
        
    }
    
    return imageToReturn;
    
}

-(void)GenerateitemAssignedToImage:(UIImageView *)imageViewToCheck index:(int)index singleObjectItemDict:(NSMutableDictionary *)singleObjectItemDict itemType:(NSString *)itemType indexPath:(NSIndexPath *)indexPath {
    
    NSMutableArray *itemAssignedTo = singleObjectItemDict[@"ItemAssignedTo"] ? [singleObjectItemDict[@"ItemAssignedTo"] mutableCopy] : [NSMutableArray array];
    
    UIColor *backgroundColor = [[[GeneralObject alloc] init] GenerateAppColor:0.15f];
    UIColor *textColor = [[[GeneralObject alloc] init] GenerateAppColor:1.0f];
    
    NSString *username = @"";
    NSString *profileImageURL = @"";
    
    int finalIndex = 4;
    
    BOOL TaskAssignedToContainsIndex = [itemAssignedTo count] > index;
    BOOL SpecificUserIsAHomeMember = TaskAssignedToContainsIndex == YES ? _homeMembersDict[@"UserID"] && [_homeMembersDict[@"UserID"] containsObject:itemAssignedTo[index]] : NO;
    
    
    
    if (TaskAssignedToContainsIndex == YES && SpecificUserIsAHomeMember == YES) {
        
        
        
        imageViewToCheck.hidden = NO;
        
        
        
        NSString *specificUserID = itemAssignedTo[index];
        NSDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:specificUserID homeMembersDict:_homeMembersDict];
        
        username = dataDict[@"Username"];
        profileImageURL = dataDict[@"ProfileImageURL"];
        
        
        
        BOOL CustomProfileImageDoesNotExist = (profileImageURL == nil || profileImageURL.length == 0 || [profileImageURL containsString:@"(null)"] || [profileImageURL isEqualToString:@"xxx"] || [profileImageURL isEqualToString:@"XXX"] || [profileImageURL isEqualToString:@"https://firebasestorage.googleapis.com/v0/b/wedivvy-afe04.appspot.com/o/DefaultImages%2FdefaultProfileImage.png?alt=media&token=6892f430-8337-4327-89a4-53a403d1186c"] || [profileImageURL containsString:@"DefaultImage"]) == YES;
        BOOL ThereAreAtLeastTwoUsersRemaining = [itemAssignedTo count] - index > 1;
        
        BOOL ThingToCheckForGeneratedImage =
        index == finalIndex ?
        (CustomProfileImageDoesNotExist == YES || ThereAreAtLeastTwoUsersRemaining == YES) :
        CustomProfileImageDoesNotExist == YES;
        
        
        
        if (ThingToCheckForGeneratedImage == YES) {
            
            if (index == finalIndex && ThereAreAtLeastTwoUsersRemaining == YES) {
                username = [NSString stringWithFormat:@"+%lu", [itemAssignedTo count] - index];
            }
            
            [imageViewToCheck setImageWithString:username color:backgroundColor circular:YES textAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Futura-Medium" size:imageViewToCheck.frame.size.height*0.45], NSForegroundColorAttributeName:textColor}];
            
        } else {
            
            [imageViewToCheck sd_setImageWithURL:[NSURL URLWithString:profileImageURL]];
            
        }
        
        
        
    } else {
        
        imageViewToCheck.hidden = YES;
        
    }
    
}

#pragma mark - Table View WillDisplay Methods

-(NSDictionary *)GenerateCheckmarkColor:(NSMutableDictionary *)singleObjectItemDict indexPath:(NSIndexPath *)indexPath {
    
    NSString *itemColor = singleObjectItemDict[@"ItemColor"] ? singleObjectItemDict[@"ItemColor"] : @"";
    
    UIColor *unselectedColor = [UIColor colorWithRed:236.0f/255.0f green:238.0f/255.0f blue:240.0f/255.0f alpha:1.0f];
    UIColor *selectedColor = [UIColor systemGreenColor];
    
    if ([[[GeneralObject alloc] init] GenerateColorOptionFromColorString:itemColor] != [UIColor clearColor]) {
        
        unselectedColor = [[[GeneralObject alloc] init] GenerateColorOptionFromColorString:itemColor];
        selectedColor =  [[[GeneralObject alloc] init] GenerateColorOptionFromColorString:itemColor];
        
    }
    
    return @{@"SelectedColor" : selectedColor, @"UnselectedColor" : unselectedColor};
    
}

-(void)GenerateitemAssignedToImageSpecificUser:(UIImageView *)imageViewToCheck index:(int)index singleObjectItemDict:(NSMutableDictionary *)singleObjectItemDict itemType:(NSString *)itemType indexPath:(NSIndexPath *)indexPath specificUserID:(NSString *)specificUserID {
    
    NSMutableArray *itemAssignedTo = singleObjectItemDict[@"ItemAssignedTo"] ? [singleObjectItemDict[@"ItemAssignedTo"] mutableCopy] : [NSMutableArray array];
    
    UIColor *backgroundColor = [[[GeneralObject alloc] init] GenerateAppColor:0.15f];
    UIColor *textColor = [[[GeneralObject alloc] init] GenerateAppColor:1.0f];
    
    NSString *username = @"";
    NSString *profileImageURL = @"";
    
    int finalIndex = 4;
    
    BOOL TaskAssignedToContainsIndex = [itemAssignedTo count] > index;
    BOOL SpecificUserIsAHomeMember = TaskAssignedToContainsIndex == YES ? _homeMembersDict[@"UserID"] && [_homeMembersDict[@"UserID"] containsObject:specificUserID] : NO;
    
    
    
    if (TaskAssignedToContainsIndex == YES && SpecificUserIsAHomeMember == YES) {
        
        
        
        imageViewToCheck.hidden = NO;
        
        
        
        NSDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:specificUserID homeMembersDict:_homeMembersDict];
        
        username = dataDict[@"Username"];
        profileImageURL = dataDict[@"ProfileImageURL"];
        
        
        
        BOOL CustomProfileImageDoesNotExist = (profileImageURL == nil || profileImageURL.length == 0 || [profileImageURL containsString:@"(null)"] || [profileImageURL isEqualToString:@"xxx"] || [profileImageURL isEqualToString:@"XXX"] || [profileImageURL isEqualToString:@"https://firebasestorage.googleapis.com/v0/b/wedivvy-afe04.appspot.com/o/DefaultImages%2FdefaultProfileImage.png?alt=media&token=6892f430-8337-4327-89a4-53a403d1186c"] || [profileImageURL containsString:@"DefaultImage"]) == YES;
        BOOL ThereAreAtLeastTwoUsersRemaining = [itemAssignedTo count] - index > 1;
        
        BOOL ThingToCheckForGeneratedImage =
        index == finalIndex ?
        (CustomProfileImageDoesNotExist == YES || ThereAreAtLeastTwoUsersRemaining == YES) :
        CustomProfileImageDoesNotExist == YES;
        
        
        
        if (ThingToCheckForGeneratedImage == YES) {
            
            if (index == finalIndex && ThereAreAtLeastTwoUsersRemaining == YES) {
                username = [NSString stringWithFormat:@"+%lu", [itemAssignedTo count] - index];
            }
            
            [imageViewToCheck setImageWithString:username color:backgroundColor circular:YES textAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Futura-Medium" size:imageViewToCheck.frame.size.height*0.45], NSForegroundColorAttributeName:textColor}];
            
        } else {
            
            [imageViewToCheck sd_setImageWithURL:[NSURL URLWithString:profileImageURL]];
            
        }
        
        
        
    } else {
        
        imageViewToCheck.hidden = YES;
        
    }
    
}

-(void)GenerateItemAssignedToImageBorderColor:(UIImageView *)imageViewToCheck index:(int)index singleObjectItemDict:(NSMutableDictionary *)singleObjectItemDict itemType:(NSString *)itemType indexPath:(NSIndexPath *)indexPath {
    
    NSMutableArray *itemAssignedTo = singleObjectItemDict[@"ItemAssignedTo"] ? [singleObjectItemDict[@"ItemAssignedTo"] mutableCopy] : [NSMutableArray array];
    
    BOOL TaskAssignedToContainsIndex = [itemAssignedTo count] > index;
    
    int finalIndex = 4;
    
    if (TaskAssignedToContainsIndex == YES) {
        
        BOOL SpecificUserIsAHomeMember = TaskAssignedToContainsIndex == YES && _homeMembersDict[@"UserID"] && [_homeMembersDict[@"UserID"] containsObject:itemAssignedTo[index]];
        BOOL ThereAreAtLeastTwoUsersRemaining = [itemAssignedTo count] - index > 1;
        
        BOOL ThingToCheckForColoredLayer = YES;
        
        if (index == finalIndex) {
            ThingToCheckForColoredLayer = (SpecificUserIsAHomeMember == YES && ThereAreAtLeastTwoUsersRemaining == NO);
        }
        
        if (ThingToCheckForColoredLayer == YES) {
            
            //            NSMutableDictionary *singleObjectItemDict = [[[GeneralObject alloc] init] GenerateSingleObjectDictionary:dictToUse keyArray:self->keyArray indexPath:indexPath];
            
            NSString *userID = TaskAssignedToContainsIndex == YES ? itemAssignedTo[index] : @"";
            
            BOOL TaskCompletedBySpecificUser = [[[BoolDataObject alloc] init] TaskCompletedBySpecificUser:singleObjectItemDict itemType:itemType userID:userID];
            BOOL TaskInProgressBySpecificUser = [[[BoolDataObject alloc] init] TaskInProgressBySpecificUser:singleObjectItemDict itemType:itemType userID:userID];
            BOOL TaskWontDoBySpecificUser = [[[BoolDataObject alloc] init] TaskWontDoBySpecificUser:singleObjectItemDict itemType:itemType userID:userID];
            BOOL TaskApprovalRequestPendingBySpecificUser = [[[BoolDataObject alloc] init] TaskApprovalRequestPendingBySpecificUser:singleObjectItemDict itemType:itemType userID:userID];
            
            if (TaskWontDoBySpecificUser == YES) {
                
                imageViewToCheck.layer.borderColor = [UIColor colorWithRed:186.0f/255.0f green:188.0f/255.0f blue:190.0f/255.0f alpha:1.0f].CGColor;
                
            } else if (TaskApprovalRequestPendingBySpecificUser == YES) {
                
                imageViewToCheck.layer.borderColor = [UIColor systemBlueColor].CGColor;
                
            } else if (TaskInProgressBySpecificUser == YES) {
                
                imageViewToCheck.layer.borderColor = [UIColor systemYellowColor].CGColor;
                
            } else if (TaskCompletedBySpecificUser == YES) {
                
                imageViewToCheck.layer.borderColor = [UIColor systemGreenColor].CGColor;
                
            }
            
        }
        
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

-(NSString *)CompleteUncompleteTaskAction_GenerateRepeatIfCompletedEarlyDrowDownText:(NSMutableDictionary *)returningDictToUse {
    
    NSString *itemRepeatsString = returningDictToUse[@"ItemRepeats"];
    
    NSArray *arr = [itemRepeatsString componentsSeparatedByString:@" "];
    
    if (arr.count == 3) {
        
        itemRepeatsString = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:itemRepeatsString arrayOfSymbols:@[@"Every"]];
        
        itemRepeatsString = [[[GeneralObject alloc] init] GenerateStringWithReplacementString:itemRepeatsString stringToReplace:@" Other " replacementString:@" 2 "];
        itemRepeatsString = [[[GeneralObject alloc] init] GenerateStringWithReplacementString:itemRepeatsString stringToReplace:@" 3rd " replacementString:@" 3 "];
        itemRepeatsString = [[[GeneralObject alloc] init] GenerateStringWithReplacementString:itemRepeatsString stringToReplace:@" 4th " replacementString:@" 4 "];
        itemRepeatsString = [[[GeneralObject alloc] init] GenerateStringWithReplacementString:itemRepeatsString stringToReplace:@" 5th " replacementString:@" 5 "];
        itemRepeatsString = [[[GeneralObject alloc] init] GenerateStringWithReplacementString:itemRepeatsString stringToReplace:@" 6th " replacementString:@" 6 "];
        itemRepeatsString = [[[GeneralObject alloc] init] GenerateStringWithReplacementString:itemRepeatsString stringToReplace:@" 7th " replacementString:@" 7 "];
        itemRepeatsString = [[[GeneralObject alloc] init] GenerateStringWithReplacementString:itemRepeatsString stringToReplace:@" 8th " replacementString:@" 8 "];
        itemRepeatsString = [[[GeneralObject alloc] init] GenerateStringWithReplacementString:itemRepeatsString stringToReplace:@" 9th " replacementString:@" 9 "];
        itemRepeatsString = [[[GeneralObject alloc] init] GenerateStringWithReplacementString:itemRepeatsString stringToReplace:@" 10th " replacementString:@" 10 "];
        itemRepeatsString = [[[GeneralObject alloc] init] GenerateStringWithReplacementString:itemRepeatsString stringToReplace:@" 11th " replacementString:@" 11 "];
        itemRepeatsString = [[[GeneralObject alloc] init] GenerateStringWithReplacementString:itemRepeatsString stringToReplace:@" 12th " replacementString:@" 12 "];
        
        itemRepeatsString = [NSString stringWithFormat:@"%@S", itemRepeatsString];
        
    } else {
        
        if ([itemRepeatsString containsString:@"Day"] || [itemRepeatsString containsString:@"Daily"]) {
            
            itemRepeatsString = @"1 DAY";
            
        } else if ([returningDictToUse[@"ItemRepeats"] containsString:@"Week"]) {
            
            itemRepeatsString = @"1 WEEK";
            
        } else if ([returningDictToUse[@"ItemRepeats"] containsString:@"Month"]) {
            
            itemRepeatsString = @"1 MONTH";
            
        }
        
    }
    
    NSString *itemDueDate = returningDictToUse[@"ItemDueDate"];
    NSString *itemTime = returningDictToUse[@"ItemTime"];
    
    if ([itemTime containsString:@"Any Time"]) {
        itemDueDate = [[[GeneralObject alloc] init] GenerateStringWithReplacementString:itemDueDate stringToReplace:@"11:59 PM" replacementString:@""];
    }
    
    NSString *repeatIfCompletedEarlyDropDownText = [NSString stringWithFormat:@"\"%@\" HAS BEEN COMPLETED EARLY. IT'S NEW DUE DATE IS %@.", returningDictToUse[@"ItemName"], [itemDueDate uppercaseString]];
    
    return repeatIfCompletedEarlyDropDownText;
}

#pragma mark - Collection View Methods

-(NSString *)GenerateEventTitleForDueDate:(NSMutableDictionary *)singleObjectItemDict {
    
    NSString *itemName = singleObjectItemDict[@"ItemName"] ? singleObjectItemDict[@"ItemName"] : @"";
    
    return itemName;
}

-(NSString *)GenerateEventTitleForDatePosted:(NSMutableDictionary *)singleObjectItemDict {
    
    NSString *itemName = singleObjectItemDict[@"ItemName"] ? singleObjectItemDict[@"ItemName"] : @"";
    
    return itemName;//[NSString stringWithFormat:@"%@ was created", itemName];
    
}

-(NSString *)GenerateEventTitleForMarked:(NSMutableDictionary *)singleObjectItemDict {
    
    NSString *itemName = singleObjectItemDict[@"ItemName"] ? singleObjectItemDict[@"ItemName"] : @"";
    
    return itemName;//[NSString stringWithFormat:@"%@ was created", itemName];
    
}

#pragma mark

-(NSString *)GenerateEventBodyForDueDate:(NSMutableDictionary *)singleObjectItemDict {
    
    NSString *itemTime = singleObjectItemDict[@"ItemTime"] ? singleObjectItemDict[@"ItemTime"] : @"";
    
    NSString *eventBody = [itemTime containsString:@"Any Time"] ? [NSString stringWithFormat:@"Due %@", itemTime] : [NSString stringWithFormat:@"Due at %@", itemTime];
    
    return eventBody;
}

-(NSString *)GenerateEventBodyForDatePosted:(NSString *)datePostedToCheck singleObjectItemDict:(NSMutableDictionary *)singleObjectItemDict {
    
    NSString *itemDatePosted = singleObjectItemDict[@"ItemDatePosted"] ? singleObjectItemDict[@"ItemDatePosted"] : @"";
    NSString *itemCreatedBy = singleObjectItemDict[@"ItemCreatedBy"] ? singleObjectItemDict[@"ItemCreatedBy"] : @"Unknown";
    
    NSString *itemTime = [self GenerateItemCreatedItemTime:itemDatePosted datePostedToCheck:datePostedToCheck];
    
    NSString *markedByUsername = @"";
    
    if (_homeMembersDict && _homeMembersDict[@"UserID"] && [_homeMembersDict[@"UserID"] containsObject:itemCreatedBy]) {
        
        NSUInteger index = [_homeMembersDict[@"UserID"] indexOfObject:itemCreatedBy];
        markedByUsername = _homeMembersDict && _homeMembersDict[@"Username"] && [(NSArray *)_homeMembersDict[@"Username"] count] > index ? _homeMembersDict[@"Username"][index] : @"";
        
    }
    
    NSString *markedByString = [markedByUsername length] > 0 ? [NSString stringWithFormat:@" by %@", markedByUsername] : @"";
    
    NSString *eventBody = [NSString stringWithFormat:@"Created%@ • %@", markedByString, itemTime];
    
    return eventBody;
}

-(NSString *)GenerateEventBodyForMarked:(NSMutableDictionary *)dictToUse key:(NSString *)key markedType:(NSString *)markedType datePostedToCheck:(NSString *)datePostedToCheck singleObjectItemDict:(NSMutableDictionary *)singleObjectItemDict {
    
    NSString *dateMarked = dictToUse[key][@"Date Marked"];
    NSString *markedBy = dictToUse[key][@"Marked By"];
    
    NSString *itemTime = [self GenerateItemCreatedItemTime:dateMarked datePostedToCheck:datePostedToCheck];
    
    NSString *markedByUsername = @"";
    
    if (_homeMembersDict && _homeMembersDict[@"UserID"] && [_homeMembersDict[@"UserID"] containsObject:markedBy]) {
        
        NSUInteger index = [_homeMembersDict[@"UserID"] indexOfObject:markedBy];
        markedByUsername = _homeMembersDict && _homeMembersDict[@"Username"] && [(NSArray *)_homeMembersDict[@"Username"] count] > index ? _homeMembersDict[@"Username"][index] : @"";
        
    }
    
    NSString *markedByString = [markedByUsername isEqualToString:@"Unknown"] == NO ? [NSString stringWithFormat:@" by %@", markedByUsername] : @"";
    
    NSString *eventBody = [NSString stringWithFormat:@"%@%@ • %@", markedType, markedByString, itemTime];
    
    return eventBody;
}


#pragma mark -
#pragma mark
#pragma mark
#pragma mark Sub-Sub-Internal Methods
#pragma mark
#pragma mark
#pragma mark-

-(NSString *)GenerateItemCreatedItemTime:(NSString *)itemDatePosted datePostedToCheck:(NSString *)datePostedToCheck {
    
    NSString *newTime = [itemDatePosted copy];
    
    if ([itemDatePosted containsString:datePostedToCheck]) {
        
        newTime = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:newTime arrayOfSymbols:@[datePostedToCheck]];
        
        if ([newTime containsString:@":"]) {
            
            NSArray *arr = [newTime componentsSeparatedByString:@":"];
            
            if ([arr count] > 1) {
                
                newTime = [NSString stringWithFormat:@"%@:%@", arr[0], arr[1]];
                NSDateFormatter *format = [[NSDateFormatter alloc] init];
                [format setDateFormat:@"H:mm"];
                NSDate *tempDate = [format dateFromString:newTime];
                [format setDateFormat:@"h:mm a"];
                newTime = [format stringFromDate:tempDate];
                
                return newTime;
            }
            
        }
        
    }
    
    return @"";
}

@end
