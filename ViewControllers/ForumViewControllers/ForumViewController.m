//
//  ForumViewController.m
//  WeDivvy
//
//  Created by Philip Nagel on 8/11/21.
//

#import "ForumViewController.h"
#import "WideCell.h"
#import "AppDelegate.h"

#import <MRProgress/MRProgressOverlayView.h>

#import "GeneralObject.h"
#import "GetDataObject.h"
#import "SetDataObject.h"
#import "DeleteDataObject.h"
#import "NotificationsObject.h"
#import "PushObject.h"
#import "BoolDataObject.h"
#import "LightDarkModeObject.h"

@interface ForumViewController () {
    
    MRProgressOverlayView *progressView;
    
    NSString *collectionKey;
    
    NSArray *keyArray;
    
    NSMutableDictionary *forumPostsDict;
    NSMutableDictionary *notificationSettingsDict;
   
    UIActivityIndicatorView *activityControl;
    UIRefreshControl *refreshControl;
    
}

@end

@implementation ForumViewController

#pragma mark - System Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self InitMethod];
    
    [self BarButtonItem];
    
    [self NSNotificationObservers];
    
    [self QueryInitialData];
    
}

-(void)viewDidLayoutSubviews {
    
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    
    UIWindow *currentwindow = [UIApplication sharedApplication].windows.firstObject;
    UIView *statusBar = [[UIView alloc]initWithFrame:currentwindow.windowScene.statusBarManager.statusBarFrame] ;
    statusBar.frame = statusBar.frame;
    statusBar.backgroundColor = [UIColor whiteColor];
    [currentwindow addSubview:statusBar];
    
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    CGFloat bottomPadding = [[[GeneralObject alloc] init] GetBottomPaddingHeight];
    CGFloat navigationBarHeight = [[[GeneralObject alloc] init] GetNavigationBarHeight:self];
    
    _customTableView.frame = CGRectMake(0, navigationBarHeight, width, height - navigationBarHeight - bottomPadding);
    activityControl.frame = CGRectMake((self.view.frame.size.width*0.5)-(12.5), (self.view.frame.size.height*0.5) - (12.5), 25, 25);
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        self.view.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        self.navigationController.navigationBar.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [[[LightDarkModeObject alloc] init] DarkModeTextPrimary]};
        self.customTableView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        
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
    
    [self SetUpAnalytics];
    
    [self SetUpActivityControl];
    
    [self SetUpTitle];
    
    [self SetUpCollection];
    
    [self SetUpKeyArray];
    
    [self SetUpTableView];
    
    [self SetUpRefreshControl];
    
}

-(void)BarButtonItem {
    
    self.navigationItem.hidesBackButton = YES;
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(NavigationBackButtonAction:)];
    
    self.navigationItem.leftBarButtonItem = newBackButton;
    
    UIBarButtonItem *button1 = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"plus"] style:UIBarButtonItemStylePlain target:self action:@selector(AddForumPost:)];
    self.navigationItem.rightBarButtonItem = button1;
    
    
}

-(void)NSNotificationObservers {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_Forum_AddForum" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_Forum_AddForum:) name:@"NSNotification_Forum_AddForum" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_Forum_EditForum" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_Forum_EditForum:) name:@"NSNotification_Forum_EditForum" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_Forum_DeleteForum" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_Forum_DeleteForum:) name:@"NSNotification_Forum_DeleteForum" object:nil];
    
    
}

-(void)QueryInitialData {
    
    [[[GetDataObject alloc] init] GetDataForumItems:collectionKey keyArray:keyArray completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningDataDict) {
        
        self->forumPostsDict = [returningDataDict mutableCopy];
        
        [[[GetDataObject alloc] init] GetDataUserNotificationSettingsData:self->forumPostsDict[@"ForumCreatedBy"] completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningNotificationSettingsDict) {
            
            self->notificationSettingsDict = [returningNotificationSettingsDict mutableCopy];
            
            [self.customTableView reloadData];
            [self->activityControl stopAnimating];
            [self->refreshControl endRefreshing];
            
        }];
        
    }];
    
}

#pragma mark - Setup Methods

-(void)SetUpAnalytics {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewViewController:@"ForumViewController" completionHandler:^(BOOL finished) {
        
    }];
    
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
    
    [self.customTableView addSubview:activityControl];
    
}

-(void)SetUpTitle {
    
    self.title = _viewingFeatureForum == YES ? @"Feature Forum" : @"Bug Forum";
    
}

-(void)SetUpCollection {
    
    collectionKey = _viewingFeatureForum == YES ? @"FeatureForum" : @"BugForum";
    
}

-(void)SetUpKeyArray {
    
    keyArray = [[[GeneralObject alloc] init] GenerateForumKeyArray];
    
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

#pragma mark - IBAction Methods

-(IBAction)AddForumPost:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"AddForum - %@", @"ForumViewController"] completionHandler:^(BOOL finished) {
        
    }];
    
    [[[PushObject alloc] init] PushToAddForumViewController:nil viewingFeatureForum:_viewingFeatureForum editingSpecificForumPost:NO viewingSpecificForumPost:NO currentViewController:self Superficial:NO];
    
}

-(IBAction)NavigationBackButtonAction:(UIBarButtonItem *)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"BackButton - %@", @"ForumViewController"] completionHandler:^(BOOL finished) {
        
    }];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(IBAction)RefreshPageAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"RefreshPage - %@", @"ForumViewController"] completionHandler:^(BOOL finished) {
        
    }];
    
    if (refreshControl == nil){
        
        [activityControl setHidden:NO];
        CGFloat height = CGRectGetHeight(self.view.bounds);
        CGFloat width = CGRectGetWidth(self.view.bounds);
        
        activityControl.frame = CGRectMake((width*0.5)-(12), (height*0.5)-(12), 25, 25);
        activityControl.color = [UIColor grayColor];
        [activityControl startAnimating];
        
        [self.customTableView addSubview:activityControl];
        
    }
    
    [[[GetDataObject alloc] init] GetDataForumItems:collectionKey keyArray:keyArray completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningDataDict) {
        
        self->forumPostsDict = [returningDataDict mutableCopy];
        [self->activityControl stopAnimating];
        [self->refreshControl endRefreshing];
        [self.customTableView reloadData];
        
    }];
    
}

- (IBAction)ForumUpVoteAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"ForumLike - %@", @"ForumViewController"] completionHandler:^(BOOL finished) {
        
    }];
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:_customTableView];
    NSIndexPath *indexPath = [_customTableView indexPathForRowAtPoint:buttonPosition];
    
    
    
    
    NSMutableDictionary *specificForumPostData = [[[[GeneralObject alloc] init] GenerateSingleObjectDictionary:forumPostsDict keyArray:keyArray indexPath:indexPath] mutableCopy];
    
    NSMutableArray *specficPostForumLikes =
    specificForumPostData[@"ForumLikes"] ?
    specificForumPostData[@"ForumLikes"] : [NSMutableArray array];
    
    
    
    
    BOOL ForumPostAlreadyLikedByMe = [specficPostForumLikes containsObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
    
    if (ForumPostAlreadyLikedByMe == YES) {
        [specficPostForumLikes removeObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
    } else {
        [specficPostForumLikes addObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
    }
    
    [specificForumPostData setObject:specficPostForumLikes forKey:@"ForumLikes"];
    
    
    
    
    [self UpdateForumLikes:specificForumPostData];

    [self.customTableView reloadData];
    
}

#pragma mark - NSNotification Methods

-(void)NSNotification_Forum_AddForum:(NSNotification *)notification {
    
    [self SetUpKeyArray];
    
    [[[GetDataObject alloc] init] GetDataForumItems:collectionKey keyArray:keyArray completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningDataDict) {
        
        self->forumPostsDict = [returningDataDict mutableCopy];
        [self.customTableView reloadData];
        
    }];
    
}

-(void)NSNotification_Forum_EditForum:(NSNotification *)notification {
    
    [self SetUpKeyArray];
    
    [[[GetDataObject alloc] init] GetDataForumItems:collectionKey keyArray:keyArray completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningDataDict) {
        
        self->forumPostsDict = [returningDataDict mutableCopy];
        [self.customTableView reloadData];
        
    }];
    
}

-(void)NSNotification_Forum_DeleteForum:(NSNotification *)notification {
    
    [self SetUpKeyArray];
    
    [[[GetDataObject alloc] init] GetDataForumItems:collectionKey keyArray:keyArray completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningDataDict) {
        
        self->forumPostsDict = [returningDataDict mutableCopy];
        [self.customTableView reloadData];
        
    }];
    
}

#pragma mark - Table View Methods

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    WideCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WideCell"];
    
    
    
    
    NSMutableDictionary *specificForumPostData = [[[[GeneralObject alloc] init] GenerateSingleObjectDictionary:forumPostsDict keyArray:keyArray indexPath:indexPath] mutableCopy];
    
    NSString *specficPostForumTitle =
    specificForumPostData[@"ForumTitle"] ?
    specificForumPostData[@"ForumTitle"] : @"";
    
    NSString *specficPostForumDetails =
    specificForumPostData[@"ForumDetails"] ?
    specificForumPostData[@"ForumDetails"] : @"";
    
    NSMutableArray *specficPostForumLikes =
    specificForumPostData[@"ForumLikes"] ?
    specificForumPostData[@"ForumLikes"] : [NSMutableArray array];

    NSString *specficPostForumCompleted =
    specificForumPostData[@"ForumCompleted"] ?
    specificForumPostData[@"ForumCompleted"] : @"";
    
    
    
    
    cell.titleLabel.text = specficPostForumTitle;
    cell.subLabel.text = specficPostForumDetails;
    cell.upvoteViewAmountLabel.text = [NSString stringWithFormat:@"%lu", [specficPostForumLikes count]];
    
    if ([specficPostForumCompleted isEqualToString:@"Yes"]) {
        cell.statusLabel.text = _viewingFeatureForum == NO ? @"RESOLVED" : @"COMPLETED";
    } else {
        cell.statusLabel.text = _viewingFeatureForum == NO ? @"UNRESOLVED" : @"UNCOMPLETED";
    }
    
    
    
    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [(NSArray *)forumPostsDict[@"ForumID"] count];
    
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(WideCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat width = CGRectGetWidth(cell.contentView.bounds);
    CGFloat height = CGRectGetHeight(cell.contentView.bounds);
    CGFloat widthToUse = 0;
    
    
    
    
    NSMutableDictionary *specificForumPostData = [[[[GeneralObject alloc] init] GenerateSingleObjectDictionary:forumPostsDict keyArray:keyArray indexPath:indexPath] mutableCopy];
    
    NSMutableArray *specficPostForumLikes =
    specificForumPostData[@"ForumLikes"] ?
    specificForumPostData[@"ForumLikes"] : [NSMutableArray array];
    
    NSString *specficPostForumCompleted =
    specificForumPostData[@"ForumCompleted"] ?
    specificForumPostData[@"ForumCompleted"] : @"";
    
    
    
    
    BOOL SpecificForumPostWasCompleted = [specficPostForumCompleted isEqualToString:@"Yes"];
    
    if (SpecificForumPostWasCompleted == YES && _viewingFeatureForum) {
        
        widthToUse = width*0.19565217;
        
    } else if (SpecificForumPostWasCompleted == YES && _viewingFeatureForum == NO) {
        
        widthToUse = width*0.16908213;
        
    } else if (SpecificForumPostWasCompleted == NO && _viewingFeatureForum) {
        
        widthToUse = width*0.23188406;
        
    } else if (SpecificForumPostWasCompleted == NO && _viewingFeatureForum == NO) {
        
        widthToUse = width*0.21256039;
        
    }
    
    
    
    
    cell.titleLabel.frame = CGRectMake(8 + width*0.116 + 8, 8, width*0.8, cell.subLabel.frame.size.height);
    cell.subLabel.frame = CGRectMake(cell.titleLabel.frame.origin.x, cell.titleLabel.frame.origin.y + cell.titleLabel.frame.size.height + 8, cell.titleLabel.frame.size.width, cell.subLabel.frame.size.height);
    cell.statusLabel.frame = CGRectMake(cell.titleLabel.frame.origin.x, cell.subLabel.frame.origin.y + cell.subLabel.frame.size.height + 8, widthToUse, cell.subLabel.frame.size.height);
    
    cell.statusLabel.layer.cornerRadius = cell.statusLabel.frame.size.height/5;
    cell.statusLabel.clipsToBounds = YES;
    
    cell.statusLabel.textColor = SpecificForumPostWasCompleted == YES ? [UIColor systemGreenColor] : [UIColor systemPinkColor];
    cell.statusLabel.backgroundColor = SpecificForumPostWasCompleted == YES ? [UIColor colorWithRed:52.0f/255.0f green:189.0f/255.0f blue:99.0f/255.0f alpha:0.10f] : [UIColor colorWithRed:255.0f/255.0f green:45.0f/255.0f blue:85.0f/255.0f alpha:0.10f];
    
    width = CGRectGetWidth(cell.contentView.bounds);
    height = CGRectGetHeight(cell.contentView.bounds);
    
    cell.upvoteView.frame = CGRectMake(8, height*0.5 - ((width*0.15)*0.5), width*0.116, width*0.15);
    cell.upvoteOverlayView.frame = CGRectMake(0, 0, cell.upvoteView.frame.size.width, cell.upvoteView.frame.size.height);
    
    width = CGRectGetWidth(cell.upvoteView.bounds);
    height = CGRectGetHeight(cell.upvoteView.bounds);
    
    cell.upvoteViewArrowImageView.frame = CGRectMake(0, 8, width, 11);
    cell.upvoteViewAmountLabel.frame = CGRectMake(0, cell.upvoteViewArrowImageView.frame.origin.y + cell.upvoteViewArrowImageView.frame.size.height, width, height*0.625);
    
    
    
    
    BOOL SpecificForumPostWasLikedByMe = [specficPostForumLikes containsObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
   
    cell.upvoteViewArrowImageView.image = SpecificForumPostWasLikedByMe ?
    [UIImage imageNamed:@"ForumCellIcons.ClickedUpvote.png"] : [UIImage imageNamed:@"ForumCellIcons.NotClickedUpvote.png"];

    
    
    
    for (UIView *subViewNo1 in [cell.contentView subviews]) {
        
        if (subViewNo1.tag == 1111) {
            
            [subViewNo1 removeFromSuperview];
            
        }
        
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(cell.contentView.frame.size.width*0.04830918, cell.contentView.frame.size.height-1, cell.contentView.frame.size.width - (cell.contentView.frame.size.width*0.04830918), 1)];
    view.backgroundColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTextSecondary] : [[[LightDarkModeObject alloc] init] LightModeSubviewLine];
    view.tag = 1111;
    [cell.contentView addSubview:view];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableDictionary *specificForumPostData = [[[[GeneralObject alloc] init] GenerateSingleObjectDictionary:forumPostsDict keyArray:keyArray indexPath:indexPath] mutableCopy];
   
    [[[PushObject alloc] init] PushToAddForumViewController:specificForumPostData viewingFeatureForum:_viewingFeatureForum editingSpecificForumPost:NO viewingSpecificForumPost:YES currentViewController:self Superficial:NO];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat height = CGRectGetHeight(self.view.bounds);
    return (height*0.13179348 > 97?(97):height*0.13179348);
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

-(UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {

    UIContextualAction *editSpecificForumPostAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:nil handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"EditForum - %@", @"ForumViewController"] completionHandler:^(BOOL finished) {
            
        }];
        
        [self EditSpecificForumPost:indexPath];
        
    }];
    
    
    
    
    UIContextualAction *deleteSpecificForumPostAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:nil handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *completeUncompleteAction = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"DeleteForum - %@", @"ForumViewController"] completionHandler:^(BOOL finished) {
                
            }];
            
            [self DeleteSpecificForumPost:indexPath];
       
        }];
        
        [completeUncompleteAction setValue:[UIColor systemRedColor] forKey:@"titleTextColor"];
        
        [actionSheet addAction:completeUncompleteAction];
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"CancelRemoveTableSwipe - %@", @"ForumViewController"] completionHandler:^(BOOL finished) {
                
            }];
            
        }]];
        
        [self presentViewController:actionSheet animated:YES completion:nil];
        
    }];
    
    
    
    
    editSpecificForumPostAction.image = [UIImage systemImageNamed:@"pencil"];
    deleteSpecificForumPostAction.image = [UIImage systemImageNamed:@"trash.fill"];
    
    editSpecificForumPostAction.backgroundColor = [UIColor systemBlueColor];
    deleteSpecificForumPostAction.backgroundColor = [UIColor systemPinkColor];
    
    NSArray *actionsArray = @[];

    
    
    
    NSDictionary *specificForumPostData = [[[GeneralObject alloc] init] GenerateSingleObjectDictionary:self->forumPostsDict keyArray:self->keyArray indexPath:indexPath];
    
    NSString *specficPostForumCreatedBy =
    specificForumPostData[@"ForumCreatedBy"] ?
    specificForumPostData[@"ForumCreatedBy"] : @"";

    BOOL SpecificForumPostWasCreatedByMe = [specficPostForumCreatedBy isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
 
    if (SpecificForumPostWasCreatedByMe == YES) {
        
        actionsArray = @[editSpecificForumPostAction, deleteSpecificForumPostAction];
        
    }
    
    
    
    
    //right to left
    return [UISwipeActionsConfiguration configurationWithActions:actionsArray];
    
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Internal Methods
#pragma mark
#pragma mark
#pragma mark -

#pragma mark IBAction Methods

-(void)UpdateForumLikes:(NSDictionary *)specificForumPostData {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *specficPostForumID =
        specificForumPostData[@"ForumID"] ?
        specificForumPostData[@"ForumID"] : @"";
        
        NSString *specficPostForumCreatedBy =
        specificForumPostData[@"ForumCreatedBy"] ?
        specificForumPostData[@"ForumCreatedBy"] : @"";
        
        NSMutableArray *specficPostForumLikes =
        specificForumPostData[@"ForumLikes"] ?
        specificForumPostData[@"ForumLikes"] : @"";
        
        [[[SetDataObject alloc] init] UpdateDataAddForum:self->collectionKey forumID:specficPostForumID dataDict:@{@"ForumLikes" : specficPostForumLikes}];
        
        BOOL SpecificForumPostWasCreatedByMe = [specficPostForumCreatedBy isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
        
        if (SpecificForumPostWasCreatedByMe == NO) {
            
            [self SendNotificationToForumPostCreator:specificForumPostData];
            
        }
        
    });
    
}

#pragma mark - TableView Methods

-(void)EditSpecificForumPost:(NSIndexPath *)indexPath {
    
    NSMutableDictionary *specificForumPostData = [[[[GeneralObject alloc] init] GenerateSingleObjectDictionary:self->forumPostsDict keyArray:self->keyArray indexPath:indexPath] mutableCopy];
    
    [[[PushObject alloc] init] PushToAddForumViewController:specificForumPostData viewingFeatureForum:_viewingFeatureForum editingSpecificForumPost:YES viewingSpecificForumPost:NO currentViewController:self Superficial:NO];
    
}

-(void)DeleteSpecificForumPost:(NSIndexPath *)indexPath {
    
    NSDictionary *specificForumPostData = [[[GeneralObject alloc] init] GenerateSingleObjectDictionary:self->forumPostsDict keyArray:self->keyArray indexPath:indexPath];
    
    NSString *forumID =
    specificForumPostData[@"ForumID"] ?
    specificForumPostData[@"ForumID"] : @"";
    
    [[[DeleteDataObject alloc] init] DeleteDataForum:self->collectionKey forumID:forumID completionHandler:^(BOOL finished, NSError * _Nonnull error) {
        
        if (error == nil) {
            
            for (NSString *key in self->keyArray) {
                
                if ([(NSArray *)self->forumPostsDict[key] count] > indexPath.row) { [self->forumPostsDict[key] removeObjectAtIndex:indexPath.row]; }
                
            }
            
        }
        
        [self.customTableView reloadData];
        
    }];
    
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Sub-Internal Methods
#pragma mark
#pragma mark
#pragma mark -

-(void)SendNotificationToForumPostCreator:(NSDictionary *)specificForumPostData {
    
    NSString *specficPostForumCreatedBy =
    specificForumPostData[@"ForumCreatedBy"] ?
    specificForumPostData[@"ForumCreatedBy"] : @"";
    
    NSString *specficPostForumTitle =
    specificForumPostData[@"ForumTitle"] ?
    specificForumPostData[@"ForumTitle"] : @"";
    
    NSMutableArray *sendNotificationToArray = [@[specficPostForumCreatedBy] mutableCopy];
    NSString *notificationTitle = [NSString stringWithFormat:@"\"%@\"", specficPostForumTitle];
    NSString *notificationBody = [NSString stringWithFormat:@"Your %@ forum post was upvoted", self->_viewingFeatureForum == YES ? @"feature" : @"bug"];
    
    NSDictionary *dataDict = [[[NotificationsObject alloc] init] GenerateNotificationDataDictForum:[specificForumPostData mutableCopy] viewingFeatureForum:self->_viewingFeatureForum];
    NSString *notificationType = [[[NotificationsObject alloc] init] NotificationSettingsUnknownItemType_Adding:NO Editing:NO Deleting:NO Duplicating:NO Waiving:NO Skipping:NO Pausing:NO Comments:NO
                                                                                                   SkippingTurn:NO RemovingUser:NO
                                                                                                 FullyCompleted:YES Completed:NO InProgress:NO WontDo:NO Accept:NO Decline:NO
                                                                                                        DueDate:NO Reminder:NO
                                                                                                 SubtaskEditing:NO SubtaskDeleting:NO
                                                                                               SubtaskCompleted:NO SubtaskInProgress:NO SubtaskWontDo:NO SubtaskAccept:NO SubtaskDecline:NO
                                                                                                 AddingListItem:NO EditingListItem:NO DeletingListItem:NO ResetingListItem:NO
                                                                                            EditingItemizedItem:NO DeletingItemizedItem:NO
                                                                                              GroupChatMessages:NO LiveSupportMessages:NO
                                                                                             SendingInvitations:NO DeletingInvitations:NO NewHomeMembers:NO HomeMembersMovedOut:NO HomeMembersKickedOut:NO
                                                                                            FeatureForumUpvotes:self->_viewingFeatureForum == YES BugForumUpvotes:self->_viewingFeatureForum == NO
                                                                                                       itemType:@"Forum"];
    
    NSString *notificationItemType = @"Forum";
    
    [[[NotificationsObject alloc] init] SendPushNotificationToArrayOfUsers_Other:sendNotificationToArray dataDict:[dataDict mutableCopy] homeMembersDict:nil notificationSettingsDict:self->notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType pushNotificationTitle:notificationTitle pushNotificationBody:notificationBody RemoveUsersNotInHome:NO completionHandler:^(BOOL finished) {
 
    }];
    
}

@end
