//
//  HomesViewController.m
//  RoommateApp
//
//  Created by Philip Nagel on 5/23/21.
//

#import "UIImageView+Letters.h"

#import "HomesViewController.h"
#import "AppDelegate.h"

#import "HomeCell.h"

#import <SDWebImage/SDWebImage.h>
#import <Mixpanel/Mixpanel.h>
#import <MRProgress/MRProgress.h>

#import "GeneralObject.h"
#import "GetDataObject.h"
#import "SetDataObject.h"
#import "DeleteDataObject.h"
#import "PushObject.h"
#import "NotificationsObject.h"
#import "BoolDataObject.h"
#import "LightDarkModeObject.h"

@interface HomesViewController () {
    
    MRProgressOverlayView *progressView;
    UIActivityIndicatorView *activityControl;
    UIRefreshControl *refreshControl;
    
    NSMutableDictionary *homeDict;
    NSArray *keyArray;
    
    UIView *profileOverlayView;
    UIView *addOverlayView;
    
    NSMutableDictionary *premiumPlanPricesDict;
    NSMutableDictionary *premiumPlanExpensivePricesDict;
    NSMutableDictionary *premiumPlanPricesDiscountDict;
    NSMutableDictionary *premiumPlanPricesNoFreeTrialDict;
    NSMutableArray *premiumPlanProductsArray;
    
}

@end

@implementation HomesViewController


#pragma mark - System Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self FetchAvailableProducts];
        
        [[[SetDataObject alloc] init] SetDataCrash:^(BOOL finished) {
            
        }];
        
    });
    
    [self InitMethod];
    
    [self TapGestures];
    
    [self BarButtonItems];
    
    [self NSNotificationObservers];
    
    [[[GetDataObject alloc] init] GetDataHomesUserIsMemberOf:keyArray userID:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningHomeDict) {
        
        self->homeDict = [returningHomeDict mutableCopy];
        [self->activityControl stopAnimating];
        [self.customTableView reloadData];
        [self EmptyTableViewHiddenStatus];
        
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
    
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    CGFloat statusBarSizeHeight = [[[GeneralObject alloc] init] GetStatusBarHeight];
    
    _userImage.frame = CGRectMake(20, statusBarSizeHeight + 12, width*0.060386, width*0.060386);
    _addImage.frame = CGRectMake(width*1 - _userImage.frame.size.width - _userImage.frame.origin.x, _userImage.frame.origin.y, _userImage.frame.size.width, _userImage.frame.size.height);
    activityControl.frame = CGRectMake((self.view.frame.size.width*0.5)-(12.5), _customTableView.frame.origin.y + (self.view.frame.size.height*0.5) - (12.5), 25, 25);
    
    _customTableView.frame = CGRectMake(0, _userImage.frame.origin.y + _userImage.frame.size.height, width, height - (_userImage.frame.origin.y + _userImage.frame.size.height + 8));
    _customTableView.contentInset = UIEdgeInsetsMake(_userImage.frame.size.height * -1, 0, 0, 0);
    _emptyTableViewView.frame = CGRectMake(0, 0, width, height*0.5);
    
    width = CGRectGetWidth(_emptyTableViewView.bounds);
    height = CGRectGetHeight(_emptyTableViewView.bounds);
    
    _emptyTableViewImage.frame = CGRectMake(0, 0, width, (self.view.frame.size.height*0.07472826 > 55?(55):self.view.frame.size.height*0.07472826));
    _emptyTableViewTitleLabel.frame = CGRectMake(0, _emptyTableViewImage.frame.origin.y + _emptyTableViewImage.frame.size.height + (self.view.frame.size.height*0.02038043 > 15?(15):self.view.frame.size.height*0.02038043), width, (self.view.frame.size.height*0.03804348 > 28?(28):self.view.frame.size.height*0.03804348));
    _emptyTableViewBodyLabel.frame = CGRectMake(0, _emptyTableViewTitleLabel.frame.origin.y + _emptyTableViewTitleLabel.frame.size.height, width, (self.view.frame.size.height*0.06929348 > 51?(51):self.view.frame.size.height*0.06929348));
    _createOrFindHomeButton.frame = CGRectMake(width*0.5 - (self.view.frame.size.width*0.84883721 > 365?(365):self.view.frame.size.width*0.84883721)*0.5, _emptyTableViewBodyLabel.frame.origin.y + _emptyTableViewBodyLabel.frame.size.height + 12, (self.view.frame.size.width*0.84883721 > 365?(365):self.view.frame.size.width*0.84883721), (self.view.frame.size.height*0.05214368 > 45?(45):self.view.frame.size.height*0.05214368));
    
    _emptyTableViewTitleLabel.font = [UIFont systemFontOfSize:_emptyTableViewTitleLabel.frame.size.height*0.78571429 weight:UIFontWeightBold];
    _emptyTableViewBodyLabel.font = [UIFont systemFontOfSize:_emptyTableViewBodyLabel.frame.size.height*0.29411765 weight:UIFontWeightRegular];
    
    _createOrFindHomeButton.layer.cornerRadius = 7;
    _createOrFindHomeButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    CGRect newRect = _emptyTableViewView.frame;
    newRect.size.height = _emptyTableViewImage.frame.size.height + (self.view.frame.size.height*0.02038043 > 15?(15):self.view.frame.size.height*0.02038043) + _emptyTableViewTitleLabel.frame.size.height + _emptyTableViewBodyLabel.frame.size.height + _createOrFindHomeButton.frame.size.height;
    newRect.origin.y = self.view.frame.size.height*0.5 - newRect.size.height*0.5;
    _emptyTableViewView.frame = newRect;
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        self.view.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        self.emptyTableViewTitleLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        self.emptyTableViewBodyLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextSecondary];
        self.customTableView.backgroundColor = [UIColor clearColor];
        
        [self preferredStatusBarStyle];
        
    } else {
        
        self.view.backgroundColor = [[[LightDarkModeObject alloc] init] LightModePrimary];
        self.emptyTableViewTitleLabel.textColor = [[[LightDarkModeObject alloc] init] LightModeTextMainImage];
        self.emptyTableViewBodyLabel.textColor = [[[LightDarkModeObject alloc] init] LightModeTextHiddenLabel];
        self.customTableView.backgroundColor = [UIColor clearColor];
        
        [self preferredStatusBarStyle];
        
    }
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Home View Controller Scrolling"] completionHandler:^(BOOL finished) {
        
    }];
    
}

#pragma mark - Init Methods

-(void)InitMethod {
    
    [self SetUpAnalytics];
    
    [self SetUpKeyArray];
    
    [self SetUpTableView];
    
    [self SetUpRefreshControl];
    
    [self SetUpActivityControl];
    
    [self SetUpEmptyTableViewView];
    
}

-(void)TapGestures {
    
    UITapGestureRecognizer *tapGesture;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ProfilePageAction:)];
    _userImage.userInteractionEnabled = YES;
    [_userImage addGestureRecognizer:tapGesture];
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(CreateOrFindHouse:)];
    _addImage.userInteractionEnabled = YES;
    [_addImage addGestureRecognizer:tapGesture];
    
}

-(void)BarButtonItems {
    
    UIBarButtonItem *barButtonItem;
    
    barButtonItem = [[UIBarButtonItem alloc]
                     initWithImage:[UIImage imageNamed:@"person.crop.circle"]
                     style:UIBarButtonItemStylePlain
                     target:self
                     action:@selector(ProfilePageAction:)];
    
    self.navigationItem.leftBarButtonItem = barButtonItem;
    
    barButtonItem = [[UIBarButtonItem alloc]
                     initWithImage:[UIImage imageNamed:@"plus"]
                     style:UIBarButtonItemStylePlain
                     target:self
                     action:@selector(CreateOrFindHouse:)];
    
    self.navigationItem.rightBarButtonItem = barButtonItem;
    
}

-(void)NSNotificationObservers {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_Homes_AddHome" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_Homes_AddHome:) name:@"NSNotification_Homes_AddHome" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_Homes_EditHome" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_Homes_EditHome:) name:@"NSNotification_Homes_EditHome" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_Homes_AddMembers" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_Homes_AddMembers:) name:@"NSNotification_Homes_AddMembers" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_Homes_ReloadView" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_Homes_ReloadView:) name:@"NSNotification_Homes_ReloadView" object:nil];
    
}

#pragma mark - Setup Methods

-(void)SetUpAnalytics {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewViewController:@"HomesViewController" completionHandler:^(BOOL finished) {
        
    }];
    
    [[[GeneralObject alloc] init] TrackInMixPanel:@"HomesViewController"];
    
}

-(void)SetUpRefreshControl {
    
    if (refreshControl == nil){
        refreshControl = [[UIRefreshControl alloc] init];
    }
    
    refreshControl.tintColor = [UIColor lightGrayColor];
    [refreshControl addTarget:self action:@selector(RefreshPageAction:) forControlEvents:UIControlEventValueChanged];
    [self.customTableView addSubview:refreshControl];
    
}

-(void)SetUpActivityControl {
    
    activityControl = [[UIActivityIndicatorView alloc] init];
    [activityControl setHidden:NO];
    [activityControl startAnimating];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [activityControl startAnimating];
        
    });
    
    activityControl.color = [UIColor lightGrayColor];
    
    [self.view addSubview:activityControl];
    
}

-(void)SetUpTableView {
    
    self->_customTableView.delegate = self;
    self->_customTableView.dataSource = self;
    
}

-(void)SetUpKeyArray {
    
    keyArray = [[[GeneralObject alloc] init] GenerateKeyArrayManually:NO Expense:NO List:NO Home:YES];
    
}

-(void)SetUpEllipsisContextMenu:(HomeCell *)cell indexPath:(NSIndexPath *)indexPath {
    
    BOOL IAmTheHomeOwner = [self->homeDict[@"HomeOwnerUserID"][indexPath.row] isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
    BOOL TheHomeOwnerLeft = [self->homeDict[@"HomeMembers"][indexPath.row] containsObject:self->homeDict[@"HomeOwnerUserID"][indexPath.row]] == NO;
    
    NSMutableArray* actions = [NSMutableArray array];
    NSMutableArray* bottomMenuActions = [NSMutableArray array];
    
    
    UIAction *viewMembersAction = [self ViewMembersContextMenuAction:indexPath];
    UIAction *leaveHomeAction = [self LeaveHomeContextMenuAction:indexPath];
    
    UIAction *editAction = [self EditContextMenuAction:indexPath];
    UIAction *deleteAction = [self DeleteContextMenuAction:indexPath];
    
    [actions addObject:viewMembersAction];
    [actions addObject:leaveHomeAction];
    
    if (IAmTheHomeOwner == YES || TheHomeOwnerLeft == YES) {
        
        [bottomMenuActions addObject:editAction];
        [bottomMenuActions addObject:deleteAction];
        
        UIMenu *bottomMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"" options:UIMenuOptionsDisplayInline children:bottomMenuActions];
        
        [actions addObject:bottomMenu];
        
    }
    
    cell.ellipsisImageOverlay.menu = [UIMenu menuWithTitle:@"" children:actions];
    cell.ellipsisImageOverlay.showsMenuAsPrimaryAction = true;
    
}

-(void)SetUpEmptyTableViewView {
    
    _emptyTableViewView.hidden = YES;
    
    _emptyTableViewImage.image = [UIImage imageNamed:@"EmptyViewIcons.NoHomes.png"];
    _emptyTableViewTitleLabel.text = @"Your Homes";
    _emptyTableViewBodyLabel.text = @"Your homes' will show up here.";
    
}

#pragma mark - UI Methods

-(void)StartProgressView {
    
    self->progressView = [MRProgressOverlayView showOverlayAddedTo:self.navigationController.view animated:YES];
    self->progressView.mode = MRProgressOverlayViewModeIndeterminateSmall;
    
}

-(void)EmptyTableViewHiddenStatus {
    
    BOOL ItemFound = NO;
    
    ItemFound = [(NSArray *)self->homeDict[@"HomeID"] count] > 0;
    
    self->_emptyTableViewView.hidden = ItemFound;
    
}

#pragma mark - IBAction Methods

-(IBAction)ProfilePageAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Profile Selected"] completionHandler:^(BOOL finished) {
        
    }];
    
    [[[PushObject alloc] init] PushToProfileViewController:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] currentViewController:self];
    
}

-(IBAction)CreateOrFindHouse:(id)sender {
    
    if ([[[GeneralObject alloc] init] ConnectedToInternet] == NO) {
        [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You need to be connected to the internet to do that." currentViewController:self];
        return;
    }
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Create Or Find Home Selected"] completionHandler:^(BOOL finished) {
        
    }];
    
    NSMutableArray *homeIDArray = homeDict && homeDict[@"HomeID"] ? [homeDict[@"HomeID"] mutableCopy] : [NSMutableArray array];
    
//    if ([[[BoolDataObject alloc] init] PremiumSubscriptionIsOn] == YES ||
//        ([[[BoolDataObject alloc] init] PremiumSubscriptionIsOn] == NO && [homeIDArray count] < 1)) {
        
        [[[PushObject alloc] init] PushToCreateHomeViewController:NO arrayOfHomeIDsYouAreAPartOf:[homeIDArray mutableCopy] currentViewController:self];
        
//    } else {
//        
//        [[[PushObject alloc] init] PushToWeDivvyPremiumViewController:YES comingFromSignUp:NO defaultPlan:@"" displayDiscount:@"Half-Off Yearly Discount No Sale Sticker" selectedSlide:@"Unlimited Homes" promoCodeID:@"" premiumPlanProductsArray:premiumPlanProductsArray premiumPlanPricesDict:premiumPlanPricesDict premiumPlanExpensivePricesDict:premiumPlanExpensivePricesDict premiumPlanPricesDiscountDict:premiumPlanPricesDiscountDict premiumPlanPricesNoFreeTrialDict:premiumPlanPricesNoFreeTrialDict currentViewController:self Superficial:NO];
//        
//    }
    
}


-(IBAction)CreateOrFindHouseSecondary:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Create Or Find Home Secondary Selected"] completionHandler:^(BOOL finished) {
        
    }];
    
    [[[PushObject alloc] init] PushToCreateHomeViewController:NO arrayOfHomeIDsYouAreAPartOf:[self->homeDict[@"HomeID"] mutableCopy] currentViewController:self];
    
}

-(IBAction)RefreshPageAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Refresh Page"] completionHandler:^(BOOL finished) {
        
    }];
    
    if (refreshControl == nil) {
        
        [activityControl setHidden:NO];
        
        CGFloat height = CGRectGetHeight(self.view.bounds);
        CGFloat width = CGRectGetWidth(self.view.bounds);
        
        activityControl.frame = CGRectMake((width*0.5)-(12), (height*0.5)-(12), 25, 25);
        activityControl.color = [UIColor grayColor];
        [activityControl startAnimating];
        [self.view addSubview:activityControl];
        [self.view bringSubviewToFront:activityControl];
        
    }
    
    [[[GetDataObject alloc] init] GetDataHomesUserIsMemberOf:keyArray userID:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningHomeDict) {
        
        self->homeDict = [returningHomeDict mutableCopy];
        [self->activityControl stopAnimating];
        [self->refreshControl endRefreshing];
        [self.customTableView reloadData];
        [self EmptyTableViewHiddenStatus];
        
    }];
    
}

#pragma mark - NSNotification Methods

-(void)NSNotification_Homes_AddHome:(NSNotification *)notification {
    
    NSDictionary *userInfo = notification.userInfo;
    
    NSString *homeID = userInfo[@"HomeID"] ? userInfo[@"HomeID"] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:@"HomeID"];
    BOOL ThisHomeAlreadyExists = [self->homeDict[@"HomeID"] containsObject:homeID];
    
    if (ThisHomeAlreadyExists == NO) {
        
        for (NSString *key in keyArray) {
            
            NSMutableArray *arr = self->homeDict[key] ? [self->homeDict[key] mutableCopy] : [NSMutableArray array];
            id object = userInfo[key] ? userInfo[key] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
            [arr addObject:object];
            [self->homeDict setObject:arr forKey:key];
            
        }
        
    }
    
    [self EmptyTableViewHiddenStatus];
    [self.customTableView reloadData];
    
}

-(void)NSNotification_Homes_EditHome:(NSNotification *)notification {
    
    NSDictionary *userInfo = notification.userInfo;
    
    for (NSString *key in [userInfo allKeys]) {
        
        if (self->homeDict[@"HomeID"] && userInfo[@"HomeID"]) {
            
            if ([self->homeDict[@"HomeID"] containsObject:userInfo[@"HomeID"]]) {
                
                NSUInteger index = [self->homeDict[@"HomeID"] indexOfObject:userInfo[@"HomeID"]];
                
                NSMutableArray *arr = self->homeDict[key] ? [self->homeDict[key] mutableCopy] : [NSMutableArray array];
                id object = userInfo[key] ? userInfo[key] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                if (arr.count > index) { [arr replaceObjectAtIndex:index withObject:object]; }
                [self->homeDict setObject:arr forKey:key];
                
            }
            
        }
        
    }
    
    [self.customTableView reloadData];
    [self EmptyTableViewHiddenStatus];
}


-(void)NSNotification_Homes_AddMembers:(NSNotification *)notification {
    
    NSDictionary *userInfo = notification.userInfo;
    
    if ([self->homeDict[@"HomeID"] containsObject:userInfo[@"HomeID"]]) {
        
        NSUInteger index = [self->homeDict[@"HomeID"] indexOfObject:userInfo[@"HomeID"]];
        if ([(NSArray *)self->homeDict[@"HomeMembers"] count] > index) { [self->homeDict[@"HomeMembers"] replaceObjectAtIndex:index withObject:userInfo[@"HomeMembers"]]; }
        
        if (![self->homeDict[@"HomeMembers"][index] containsObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]]) {
            
            for (NSString *key in [self->homeDict allKeys]) {
                
                [self->homeDict[key] removeObjectAtIndex:index];
                
            }
            
        }
        
    }
    
    [self EmptyTableViewHiddenStatus];
    [self.customTableView reloadData];
    
}

-(void)NSNotification_Homes_ReloadView:(NSNotification *)notification {
    
    [self viewDidLoad];
    [self viewDidAppear:self];
    
}


#pragma mark - Table View Methods

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeCell"];
    
    
    
    NSMutableDictionary *singleObjectItemDict = [[[GeneralObject alloc] init] GenerateSingleObjectDictionary:self->homeDict keyArray:keyArray indexPath:indexPath];
    
    NSString *homeName = singleObjectItemDict[@"HomeName"] ? singleObjectItemDict[@"HomeName"] : @"";
    NSMutableArray *homeMembers = singleObjectItemDict[@"HomeMembers"] ? singleObjectItemDict[@"HomeMembers"] : [NSMutableArray array];
    NSString *homeImageURL = singleObjectItemDict[@"HomeImageURL"] ? singleObjectItemDict[@"HomeImageURL"] : @"xxx";
    
    NSString *sStr = ([(NSArray *)homeDict[@"HomeMembers"][indexPath.row] count] != 1) ? @"s" : @"";
    
    
    
    cell.titleLabel.text = homeName;
    cell.subLabel.text = [NSString stringWithFormat:@"%lu Member%@", (unsigned long)[homeMembers count], sStr];
    
    
    
    UIColor *backgroundColor = [[[GeneralObject alloc] init] GenerateAppColor:0.15f];
    UIColor *textColor = [[[GeneralObject alloc] init] GenerateAppColor:1.0f];
    
    NSString *username = homeName;
    NSString *profileImageURL = homeImageURL;
    
    if (profileImageURL == nil || profileImageURL.length == 0 || [profileImageURL containsString:@"(null)"] || [profileImageURL isEqualToString:@"xxx"] || [profileImageURL isEqualToString:@"XXX"] || [profileImageURL isEqualToString:@"https://firebasestorage.googleapis.com/v0/b/wedivvy-afe04.appspot.com/o/DefaultImages%2FdefaultProfileImage.png?alt=media&token=6892f430-8337-4327-89a4-53a403d1186c"] || [profileImageURL containsString:@"DefaultImage"]) {
        
        [cell.profileImage setImageWithString:username color:backgroundColor circular:YES textAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Futura-Medium" size:cell.profileImage.frame.size.height*0.45], NSForegroundColorAttributeName:textColor}];
        
    } else {
        
        [cell.profileImage sd_setImageWithURL:[NSURL URLWithString:profileImageURL]];
        
    }
    
    
    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [(NSArray *)homeDict[@"HomeID"] count];
    
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(HomeCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat width = CGRectGetWidth(cell.contentView.bounds);
    CGFloat height = CGRectGetHeight(cell.contentView.bounds);
    
    cell.mainView.frame = CGRectMake(width*0.5 - ((width*0.90338164)*0.5), height*0.5 - ((height*0.7037037)*0.5), width*0.90338164, height*0.7037037);
    
    height = CGRectGetHeight(cell.mainView.bounds);
    width = CGRectGetWidth(cell.mainView.bounds);
    
    cell.profileImage.frame = CGRectMake(width*0.04278075, height*0.5 - ((height*0.43859)*0.5), height*0.43859, height*0.43859);
    cell.profileImage.layer.cornerRadius = cell.profileImage.frame.size.height/2;
    cell.profileImage.clipsToBounds = YES;
    cell.profileImage.contentMode = UIViewContentModeScaleAspectFill;
    
    cell.titleLabel.textColor =  [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTextPrimary] : [[[LightDarkModeObject alloc] init] LightModeTextPrimary];
    cell.titleLabel.alpha = 1;
    
    cell.titleLabel.frame = CGRectMake(width*0.04278075 + height*0.43859 + height*0.24691358, height*0.14035, width*0.772727, height*0.350878);
    cell.subLabel.frame = CGRectMake(cell.titleLabel.frame.origin.x, height - cell.titleLabel.frame.size.height - height*0.14035, cell.titleLabel.frame.size.width, cell.titleLabel.frame.size.height);
    
    cell.titleLabel.font = [UIFont systemFontOfSize:cell.titleLabel.frame.size.height*0.75 weight:UIFontWeightSemibold];
    cell.subLabel.font = [UIFont systemFontOfSize:cell.subLabel.frame.size.height*0.65 weight:UIFontWeightSemibold];
    
    cell.ellipsisImage.frame = CGRectMake(width - ((height*0.4385965)*0.24) - (width*0.04278075), height*0.5 - ((height*0.4385965)*0.5), ((height*0.4385965)*0.24), height*0.4385965);
    cell.ellipsisImageOverlay.frame = CGRectMake(cell.ellipsisImage.frame.origin.x - (width*0.125), cell.ellipsisImage.frame.origin.y - (width*0.026738), cell.ellipsisImage.frame.size.width + ((width*0.075)*2), cell.ellipsisImage.frame.size.height + ((width*0.026738)*2));
    cell.ellipsisImage.image = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [UIImage imageNamed:@"GeneralIcons.Ellipsis.White"] : [UIImage imageNamed:@"GeneralIcons.Ellipsis"];
    
    [self SetUpEllipsisContextMenu:cell indexPath:indexPath];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableDictionary *homeChosenDict = [NSMutableDictionary dictionary];
    
    for (NSString *key in [self->homeDict allKeys]) {
        
        id object = self->homeDict[key] && [(NSArray *)self->homeDict[key] count] > indexPath.row ? self->homeDict[key][indexPath.row] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
        [homeChosenDict setObject:object forKey:key];
        
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:homeChosenDict forKey:@"HomeChosen"];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"QueryVeryFirstTime"];
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Did Select Home"] completionHandler:^(BOOL finished) {
        
    }];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"ViewDidLoadShouldStart"];
    [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"QueryFirstTime"];
    
    [[[PushObject alloc] init] PushToTasksNavigationController:YES Expenses:NO Lists:NO Animated:YES currentViewController:self];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat height = CGRectGetHeight(self.view.bounds);
    return (height*0.11141304 > 85?(85):height*0.11141304);
    
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

-(UIAction *)ViewMembersContextMenuAction:(NSIndexPath *)indexPath {
    
    UIAction *viewMembers = [UIAction actionWithTitle:@"View Members" image:[UIImage systemImageNamed:@"person.2"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"View Home Members Selected"] completionHandler:^(BOOL finished) {
            
        }];
        
        NSMutableDictionary *homeChosenDict = [NSMutableDictionary dictionary];
        
        for (NSString *key in [self->homeDict allKeys]) {
            
            id object = self->homeDict[key] && [(NSArray *)self->homeDict[key] count] > indexPath.row ? self->homeDict[key][indexPath.row] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
            [homeChosenDict setObject:object forKey:key];
            
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"ViewingFromHomesViewController"];
        [[NSUserDefaults standardUserDefaults] setObject:homeChosenDict forKey:@"HomeChosen"];
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:@"ViewMembersHome" completionHandler:^(BOOL finished) {
            
        }];
        
        NSString *homeID = self->homeDict && self->homeDict[@"HomeID"] && [(NSArray *)self->homeDict[@"HomeID"] count] > indexPath.row ? self->homeDict[@"HomeID"][indexPath.row] : @"";
        NSString *homeName = self->homeDict && self->homeDict[@"HomeName"] && [(NSArray *)self->homeDict[@"HomeName"] count] > indexPath.row ? self->homeDict[@"HomeName"][indexPath.row] : @"";
        
        [[[PushObject alloc] init] PushToHomeMembersViewController:homeID homeName:homeName notificationSettingsDict:[NSMutableDictionary dictionary] topicDict:[NSMutableDictionary dictionary] viewingHomeMembersFromHomesViewController:NO currentViewController:self Superficial:NO];
        
    }];
    
    return viewMembers;
}

-(UIAction *)LeaveHomeContextMenuAction:(NSIndexPath *)indexPath {
    
    UIAction *leaveHomeAction = [UIAction actionWithTitle:@"Leave Home" image:[UIImage systemImageNamed:@"rectangle.portrait.and.arrow.forward"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Once you leave you can't come back without an invitation" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        NSString *actionTitle = @"Leave Home";
        
        UIAlertAction *completeUncompleteAction = [UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Moving Out"] completionHandler:^(BOOL finished) {
                
            }];
            
            [self StartProgressView];
            
            NSMutableArray *homeMembers = self->homeDict[@"HomeMembers"] && [(NSArray *)self->homeDict[@"HomeMembers"] count] > indexPath.row ? self->homeDict[@"HomeMembers"][indexPath.row] : [NSMutableArray array];
            
            if ([homeMembers containsObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]]) {
                
                NSString *userIDMovingOut = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"];
                [homeMembers removeObject:userIDMovingOut];
                
                NSString *homeID = self->homeDict && self->homeDict[@"HomeID"] && [(NSArray *)self->homeDict[@"HomeID"] count] > indexPath.row ? self->homeDict[@"HomeID"][indexPath.row] : @"";
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    
                    [[[SetDataObject alloc] init] UpdateDataHome:homeID homeDict:@{@"HomeMembers" : homeMembers} completionHandler:^(BOOL finished) {
                        
                        [self DeleteHome_CompletionBlock:indexPath homeDict:self->homeDict keyArray:self->keyArray completionHandler:^(BOOL finished) {
                          
                            dispatch_async(dispatch_get_main_queue(), ^{
                                
                                [[[GeneralObject alloc] init] AllGenerateTokenMethod:@"AllHomeTopics" Subscribe:NO GrantedNotifications:NO];
                                
                                [[[GeneralObject alloc] init] RemoveCachedInitialDataNSUserDefaults:YES];
                                [[[GeneralObject alloc] init] RemoveHomeDataNSUserDefaults];
                                
                                [self EmptyTableViewHiddenStatus];
                                [self.customTableView reloadData];
                                [self->progressView setHidden:YES];
                                
                            });
                            
                        }];
                        
                    }];
                    
                });
                
            } else {
                
                [[[GeneralObject alloc] init] CreateAlert:@"Oops!" message:@"You are not a memeber of this home." currentViewController:self];
                
                [self DeleteHome_CompletionBlock:indexPath homeDict:self->homeDict keyArray:self->keyArray completionHandler:^(BOOL finished) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [self EmptyTableViewHiddenStatus];
                        [self.customTableView reloadData];
                        [self->progressView setHidden:YES];
                        
                    });
                    
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
        
    }];
    
    [leaveHomeAction setAttributes:UIMenuElementAttributesDestructive];
    
    return leaveHomeAction;
}

-(UIAction *)EditContextMenuAction:(NSIndexPath *)indexPath {
    
    UIAction *editAction = [UIAction actionWithTitle:@"Edit" image:[UIImage systemImageNamed:@"pencil"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Edit Home Name Selected"] completionHandler:^(BOOL finished) {
            
        }];
        
        NSString *homeID = self->homeDict && self->homeDict[@"HomeID"] && [(NSArray *)self->homeDict[@"HomeID"] count] > indexPath.row ? self->homeDict[@"HomeID"][indexPath.row] : @"";
        NSString *homeName = self->homeDict && self->homeDict[@"HomeName"] && [(NSArray *)self->homeDict[@"HomeName"] count] > indexPath.row ? self->homeDict[@"HomeName"][indexPath.row] : @"";
        NSString *homeImageURL = self->homeDict && self->homeDict[@"HomeImageURL"] && [(NSArray *)self->homeDict[@"HomeImageURL"] count] > indexPath.row ? self->homeDict[@"HomeImageURL"][indexPath.row] : @"";
        
        [[[PushObject alloc] init] PushToEditProfileViewController:homeID name:homeName imageURL:homeImageURL editingHome:YES currentViewController:self];
        
    }];
    
    return editAction;
}

-(UIAction *)DeleteContextMenuAction:(NSIndexPath *)indexPath {
    
    UIAction *deleteAction = [UIAction actionWithTitle:@"Delete" image:[UIImage systemImageNamed:@"trash"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Delete Home Selected"] completionHandler:^(BOOL finished) {
            
        }];
        
        NSString *homeName = self->homeDict && self->homeDict[@"HomeName"] && [(NSArray *)self->homeDict[@"HomeName"] count] > indexPath.row ? self->homeDict[@"HomeName"][indexPath.row] : @"";
        
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Would you like to delete \"%@\"?", homeName] message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *completeUncompleteAction = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Deleting Home Selected"] completionHandler:^(BOOL finished) {
                
            }];
            
            [self StartProgressView];
            
            NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
            
            [[[DeleteDataObject alloc] init] DeleteHomeCompletely:indexPath homeDict:self->homeDict keyArray:self->keyArray userID:userID homeMembersDict:[NSMutableDictionary dictionary] topicDict:[NSMutableDictionary dictionary] QueryAssignedToNewHomeMember:NO QueryAssignedTo:NO queryAssignedToUserID:@"" completionHandler:^(BOOL finished) {
               
                [self DeleteHome_CompletionBlock:indexPath homeDict:self->homeDict keyArray:self->keyArray completionHandler:^(BOOL finished) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [self EmptyTableViewHiddenStatus];
                        [self.customTableView reloadData];
                        [self->progressView setHidden:YES];
                        
                    });
                    
                }];
                
            }];
            
        }];
        
        [completeUncompleteAction setValue:[UIColor systemRedColor] forKey:@"titleTextColor"];
        
        [actionSheet addAction:completeUncompleteAction];
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Delete Home Cancelled %@", self->homeDict[@"HomeName"][indexPath.row]] completionHandler:^(BOOL finished) {
                
            }];
            
        }]];
        
        [self presentViewController:actionSheet animated:YES completion:nil];
        
    }];
    
    [deleteAction setAttributes:UIMenuElementAttributesDestructive];
    
    return deleteAction;
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Sub-Internal Methods
#pragma mark
#pragma mark
#pragma mark -

#pragma mark SetUp Methods

-(void)DeleteHome_CompletionBlock:(NSIndexPath *)indexPath homeDict:(NSMutableDictionary *)homeDict keyArray:(NSArray *)keyArray completionHandler:(void (^)(BOOL finished))finishBlock {
    
    for (NSString *key in keyArray) {
        
        if (homeDict &&
            homeDict[key] &&
            [(NSArray *)homeDict[key] count] > indexPath.row) {
            
            [homeDict[key] removeObjectAtIndex:indexPath.row];
            
        }
        
    }
    
    finishBlock(YES);
    
}

@end
