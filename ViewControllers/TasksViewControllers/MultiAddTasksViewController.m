//
//  MultiAddTasksViewController.m
//  WeDivvy
//
//  Created by Philip Nagel on 9/7/22.
//

#import "MultiAddTasksViewController.h"

#import "MultiAddTaskCell.h"

#import "GeneralObject.h"
#import "SetDataObject.h"
#import "PushObject.h"
#import "NotificationsObject.h"
#import "BoolDataObject.h"
#import "LightDarkModeObject.h"

#import "TutorialView.h"

#import <MRProgressOverlayView.h>

@interface MultiAddTasksViewController () {
    
    NSMutableArray *selectedCellsArray;
    
    MRProgressOverlayView *progressView;
    
    NSString *localCurrencySymbol;
    NSString *localCurrencyDecimalSeparatorSymbol;
    NSString *localCurrencyNumberSeparatorSymbol;
    
    NSString *currentItemType;
    NSString *currentItemTypeCollection;
    NSMutableDictionary *itemDict;
    NSMutableDictionary *itemDictKeys;
    NSMutableDictionary *itemSelectedDictLocal;
    
    NSString *hourComp;
    NSString *minuteComp;
    NSString *AMPMComp;
    
    NSMutableArray *assignedToUsernameArray;
    NSMutableArray *expandedCells;
    NSArray *keyArray;
    
    int totalQueries;
    int completedQueries;
    
    double totalTasksAdded;
    double completedTasksAdded;
    
    NSMutableDictionary *searchResults;
    BOOL Searching;
    BOOL AddingFromSearchBar;
    
    UIView *numberOfTasksSuperView;
    UIView *numberOfTasksView;
    UILabel *numberOfTasksLabel;
    UIImageView *numberOfTasksImageView;
    
    UIView *topView;
    UIButton *topViewCover;
    UILabel *topViewLabel;
    UIImageView *topViewImageView;
    
    NSIndexPath *chosenIndexPath;
    
    UIView *backDropView;
    
}

@end

@import InstantSearch;
@import InstantSearchClient;

@implementation MultiAddTasksViewController

#pragma mark - System Methods

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self InitMethods];
    
    [self BarButtonItems];
    
    [self TapGestures];
    
    [self KeyBoardToolBar];
    
    [self KeyboardNSNotifications];
    
    [self NSNotificationObservers:NO];
    
    [self AdjustTableViewHeight];

}

-(void)viewDidAppear:(BOOL)animated {
   
    [self DisplayAddMultipleTasksTutorialView];
    
}

-(void)viewWillAppear:(BOOL)animated {
   
    NSMutableDictionary *tutorialViewDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"TutorialViewDisplayed"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"TutorialViewDisplayed"] mutableCopy] : [NSMutableDictionary dictionary];
    
    if (!tutorialViewDict[@"MultiAddTaskDisplayed"] || [tutorialViewDict[@"MultiAddTaskDisplayed"] isEqualToString:@"Yes"] == NO) {
        
        [self tableView:_customTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
        
    }
    
    topView.hidden = _viewingAddedTasks ? NO : YES;
    topViewCover.hidden = _viewingAddedTasks ? NO : YES;
    numberOfTasksSuperView.hidden = NO;
    
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [self->topView removeFromSuperview];
    [self->topViewCover removeFromSuperview];
    numberOfTasksSuperView.hidden = YES;
    
}

-(void)viewWillLayoutSubviews {
    
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    self.navigationController.navigationBar.backgroundColor = _customScrollView.backgroundColor;
    
    CGFloat height = CGRectGetHeight(self.view.bounds);
    CGFloat width = CGRectGetWidth(self.view.bounds);
    
    CGFloat textFieldSpacing = (height*0.024456);
    CGFloat bottomPadding = [[[GeneralObject alloc] init] GetBottomPaddingHeight];
    
    
    
    
    
    CGFloat cornerRadius = (self.view.frame.size.height*0.2181818182 > 12?12:(self.view.frame.size.height*0.2181818182));
    
    [[[GeneralObject alloc] init] RoundingCorners:_searchBarView topCorners:YES bottomCorners:YES cornerRadius:cornerRadius];
    [[[GeneralObject alloc] init] RoundingCorners:_searchBar topCorners:YES bottomCorners:YES cornerRadius:cornerRadius];
    
    _searchBarView.layer.borderWidth = 1.5f;
    _searchBarView.layer.borderColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [UIColor clearColor].CGColor : [UIColor colorWithRed:236.0f/255.0f green:237.0f/255.0f blue:240.0f/255.0f alpha:1.0f].CGColor;
    _searchBarView.layer.cornerRadius = 10;
    
    UIFont *fontSize = [UIFont systemFontOfSize:(self.view.frame.size.height*0.02173813 > 16?16:(self.view.frame.size.height*0.02173813)) weight:UIFontWeightRegular];
    UIColor *textColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTextSecondary] : [[[LightDarkModeObject alloc] init] LightModeTexAddTaskTextField];
    UIColor *backgroundColor = [UIColor clearColor];
    
    NSString *anString = [[[currentItemTypeCollection lowercaseString] substringToIndex:[[currentItemTypeCollection lowercaseString] length] - 1] isEqualToString:@"expense"] ? @"an" : @"a";
    
    _searchBar.placeholder = [NSString stringWithFormat:@"Search for %@ %@ (or add a custom one)", anString, [[currentItemTypeCollection lowercaseString] substringToIndex:[[currentItemTypeCollection lowercaseString] length] - 1]];
    _searchBar.font = fontSize;
    _searchBar.minimumFontSize = (height*0.25454545 > 14?14:(height*0.25454545));
    _searchBar.adjustsFontSizeToFitWidth = YES;
    _searchBar.textColor = textColor;
    _searchBar.backgroundColor = backgroundColor;
    
    CGRect newRect = _searchBarView.frame;
    newRect.origin.y = 0;
    newRect.size.width = width*1 - (textFieldSpacing*2);
    newRect.size.height = (self.view.frame.size.height*0.07472826 > 55?55:(self.view.frame.size.height*0.07472826));
    _searchBarView.frame = newRect;
    
    _searchBar.frame = CGRectMake((self.view.frame.size.height*0.02717 > 20?20:(self.view.frame.size.height*0.02717)),
                                  _searchBarView.frame.size.height*0.5 - (_searchBarView.frame.size.height*0.75)*0.5,
                                  _searchBarView.frame.size.width - (self.view.frame.size.height*0.02717 > 20?20:(self.view.frame.size.height*0.02717)) - _clearSearchBarView.frame.size.width - (self.view.frame.size.height*0.02717 > 20?20:(self.view.frame.size.height*0.02717)),
                                  _searchBarView.frame.size.height*0.75);
    
    
    
    
    _clearSearchBarView.frame = CGRectMake(_searchBarView.frame.size.width - (self.view.frame.size.height*0.0407 > 30?30:(self.view.frame.size.height*0.0407)) - (self.view.frame.size.height*0.02717 > 20?20:(self.view.frame.size.height*0.02717)),
                                           _searchBarView.frame.size.height*0.5 - ((self.view.frame.size.height*0.0407 > 30?30:(self.view.frame.size.height*0.0407))*0.5),
                                           (self.view.frame.size.height*0.0407 > 30?30:(self.view.frame.size.height*0.0407)),
                                           (self.view.frame.size.height*0.0407 > 30?30:(self.view.frame.size.height*0.0407)));
    _clearSearchBarView.layer.cornerRadius = _clearSearchBarView.frame.size.height/2;
    
    _clearSearchBarImageView.frame = CGRectMake(_clearSearchBarView.frame.size.width*0.5 - ((_clearSearchBarView.frame.size.width*0.35 > 12?12:(_clearSearchBarView.frame.size.width*0.35))*0.5),
                                                _clearSearchBarView.frame.size.height*0.5 - ((_clearSearchBarView.frame.size.height*0.35 > 12?12:(_clearSearchBarView.frame.size.height*0.35))*0.5),
                                                (_clearSearchBarView.frame.size.height*0.35 > 12?12:(_clearSearchBarView.frame.size.height*0.35)),
                                                (_clearSearchBarView.frame.size.height*0.35 > 12?12:(_clearSearchBarView.frame.size.height*0.35)));
    
    _clearSearchBarView.hidden = YES;
    
    
    
    
    
    numberOfTasksSuperView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, self.navigationController.navigationBar.frame.size.height)];
    numberOfTasksImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,  numberOfTasksSuperView.frame.size.height*0.5 - ((height*0.03396739 > 25?25:(height*0.03396739))*0.5), (height*0.03396739 > 25?25:(height*0.03396739)), (height*0.03396739 > 25?25:(height*0.03396739)))];
    numberOfTasksView = [[UIView alloc] initWithFrame:CGRectMake(numberOfTasksImageView.frame.origin.x + (numberOfTasksImageView.frame.size.width*0.5), numberOfTasksImageView.frame.origin.y - (numberOfTasksImageView.frame.size.height*0.5), numberOfTasksImageView.frame.size.width*0.8, numberOfTasksImageView.frame.size.height*0.8)];
    numberOfTasksLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, numberOfTasksView.frame.size.width, numberOfTasksView.frame.size.width)];
    
    
    
    newRect = numberOfTasksSuperView.frame;
    newRect.size.width = numberOfTasksImageView.frame.size.width;
    newRect.origin.x = self.view.frame.size.width - newRect.size.width - textFieldSpacing;
    numberOfTasksSuperView.frame = newRect;
    
    [numberOfTasksView addSubview:numberOfTasksLabel];
    
    [numberOfTasksSuperView addSubview:numberOfTasksImageView];
    [numberOfTasksSuperView addSubview:numberOfTasksView];
    
    [self.view addSubview:numberOfTasksSuperView];
    
    
    
    UIWindow *currentwindow = [UIApplication sharedApplication].windows.firstObject;
    [currentwindow addSubview:numberOfTasksSuperView];
    [self.navigationController.navigationBar addSubview:numberOfTasksSuperView];
    
    numberOfTasksSuperView.hidden = _viewingAddedTasks ? YES : NO;
    
    numberOfTasksLabel.text = [NSString stringWithFormat:@"%d", [self TotalNumberOfTasksAdded]];
    numberOfTasksLabel.hidden = !_viewingAddedTasks && [self TotalNumberOfTasksAdded] == 0 ? YES : NO;
    numberOfTasksView.hidden = !_viewingAddedTasks && [self TotalNumberOfTasksAdded] == 0 ? YES : NO;
    
    
    
    numberOfTasksImageView.image = [UIImage imageNamed:@"MultiAddIcons.Stack.png"];
    
    numberOfTasksView.backgroundColor = [UIColor systemPinkColor];
    numberOfTasksView.layer.cornerRadius = numberOfTasksView.frame.size.height/2;
    
    numberOfTasksLabel.textColor = [UIColor whiteColor];
    numberOfTasksLabel.textAlignment = NSTextAlignmentCenter;
    numberOfTasksLabel.font = [UIFont systemFontOfSize:(numberOfTasksView.frame.size.height*0.6 > 12?(12):numberOfTasksView.frame.size.height*0.6) weight:UIFontWeightBold];
    
    
    
    numberOfTasksSuperView.userInteractionEnabled = YES;
    [numberOfTasksSuperView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ViewAllAddedTasks:)]];
    
    numberOfTasksImageView.userInteractionEnabled = YES;
    [numberOfTasksImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ViewAllAddedTasks:)]];
    
    numberOfTasksView.userInteractionEnabled = YES;
    [numberOfTasksView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ViewAllAddedTasks:)]];
    
    
    
    
    
    newRect = _customTableView.frame;
    newRect.origin.y = _viewingAddedTasks ?
    _searchBarView.frame.origin.y + 12 : _searchBarView.frame.origin.y + _searchBarView.frame.size.height;
    _customTableView.frame = newRect;
    
    newRect = _customScrollView.frame;
    newRect.origin.y = 0;
    newRect.size.height = self.view.frame.size.height - bottomPadding;
    _customScrollView.frame = newRect;
    
    
    
    
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        self.view.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [[[LightDarkModeObject alloc] init] DarkModeTextPrimary]};
        
        [self preferredStatusBarStyle];
        
        UIWindow *currentwindow = [UIApplication sharedApplication].windows.firstObject;
        UIView *statusBar = [[UIView alloc]initWithFrame:currentwindow.windowScene.statusBarManager.statusBarFrame] ;
        statusBar.backgroundColor = [UIColor clearColor];
        [currentwindow addSubview:statusBar];
        
        self.navigationController.navigationBar.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        
    } else {
        
        UIWindow *currentwindow = [UIApplication sharedApplication].windows.firstObject;
        UIView *statusBar = [[UIView alloc]initWithFrame:currentwindow.windowScene.statusBarManager.statusBarFrame] ;
        statusBar.backgroundColor = [UIColor clearColor];
        [currentwindow addSubview:statusBar];
        
        self.navigationController.navigationBar.backgroundColor =_customScrollView.backgroundColor;
        
    }
    
    _searchBarView.backgroundColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ?
    [[[LightDarkModeObject alloc] init] DarkModeTertiary] :
    [[[LightDarkModeObject alloc] init] LightModeSecondary];
    
}

-(BOOL)prefersStatusBarHidden {
    
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    
    [self.customTableView reloadData];
    
}

- (void)textFieldDidChange:(NSNotification *)notification {
    
    if (_searchBar.text.length == 0) {
        
        Searching = NO;
        
        self.customTableView.layer.zPosition = 0;
        
        [searchResults removeAllObjects];
        
        [self.customTableView reloadData];
        
        _clearSearchBarView.hidden = YES;
        
        [self AdjustTableViewHeight];
        
    } else {
        
        Searching = YES;
        
        self.customTableView.layer.zPosition = 5;
        
        [self SearchAlgolia:_searchBar];
        
        [self.customTableView reloadData];
        
        _clearSearchBarView.hidden = NO;
        
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [_searchBar resignFirstResponder];
    
    return true;
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField.tag == 999) {
        
        char lastChar = [textField.text characterAtIndex:textField.text.length-2];
        
        [self FormatAmountTextField:textField shouldChangeCharactersInRange:range replacementString:string];
        
        if (string.length > 0) {
            
            NSString *textFieldText = textField.text;
            
            textFieldText = [textFieldText substringToIndex:[textFieldText length] - 1];
            
            textField.text = textFieldText;
            
        } else if (string.length == 0) {
            
            NSString *textFieldText = textField.text;
            
            textFieldText = [NSString stringWithFormat:@"%@%c", textFieldText, lastChar];
            
            textField.text = textFieldText;
            
        }
        
    }
    
    return YES;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [_searchBar resignFirstResponder];
    
}

#pragma mark - Keyboard Methods

- (void)keyboardWillShow: (NSNotification *) notification{
    
    //    CGFloat height = CGRectGetHeight(self.view.bounds);
    //    CGFloat width = CGRectGetWidth(self.view.bounds);
    //    CGFloat textFieldSpacing = (height*0.024456);
    
    [UIView animateWithDuration:0.25 animations:^{
        
        [self AdjustTableViewHeight];
        
        //        NSDictionary* keyboardInfo = [notification userInfo];
        //        NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
        //        CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
        
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)keyboardWillHide: (NSNotification *) notification{
    
    //    CGFloat height = CGRectGetHeight(self.view.bounds);
    //    CGFloat width = CGRectGetWidth(self.view.bounds);
    
    [UIView animateWithDuration:0.25 animations:^{
        
        [self AdjustTableViewHeight];
        
    } completion:^(BOOL finished) {
        
    }];
    
}

#pragma mark - Init Methods

-(void)InitMethods {
    
    [self SetUpAnalytics];
    
    [self SetUpInitData];
    
    [self SetUpTableViewAndSearchBar];
    
    [self SetUpViewingAddTasks];
    
}

-(void)BarButtonItems {
    
    self.navigationItem.hidesBackButton = YES;
    
    UIBarButtonItem *barButtonItem;
    
    barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(NavigationBackButtonAction:)];
    
    self.navigationItem.leftBarButtonItem = barButtonItem;
    
    if (_viewingAddedTasks) {
        
        NSString *title = [NSString stringWithFormat:@"Add (%d)", [self TotalNumberOfTasksAdded]];
        
        if ([title containsString:@"(0)"]) {
            title = @"Add";
        }
        
        barButtonItem = [[UIBarButtonItem alloc] initWithTitle:_viewingAddedTasks ? title : @"Add"
                                                         style:UIBarButtonItemStyleDone
                                                        target:self
                                                        action:@selector(MultiAddItems:)];
        
        self.navigationItem.rightBarButtonItem = barButtonItem;
        
    }
    
}

-(void)TapGestures {
    
    _clearSearchBarView.userInteractionEnabled = YES;
    [_clearSearchBarView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ClearSearchBar:)]];
    
}

-(void)KeyBoardToolBar {
    
    UIToolbar* keyboardToolbar = [[UIToolbar alloc] init];
    
    [keyboardToolbar sizeToFit];
    
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                      target:nil action:nil];
    UIBarButtonItem *addBarButton = [[UIBarButtonItem alloc]
                                     initWithTitle:[NSString stringWithFormat:@"Add %@", [[[GeneralObject alloc] init] GenerateItemType]] style:UIBarButtonItemStyleDone target:self action:@selector(AddSearchBarTask:)];
    
    keyboardToolbar.items = @[flexBarButton, addBarButton];
    
    _searchBar.inputAccessoryView = keyboardToolbar;
    
}

-(void)KeyboardNSNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}


-(void)NSNotificationObservers:(BOOL)RemoveOnly {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:_searchBar];
    
    //    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_MultiAddTasks_ItemAssignedTo" object:nil];
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_MultiAddTasks_ItemAssignedTo:) name:@"NSNotification_MultiAddTasks_ItemAssignedTo" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_MultiAddTasks_ItemRepeats" object:nil];
    if (RemoveOnly == NO) { [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_MultiAddTasks_ItemRepeats:) name:@"NSNotification_MultiAddTasks_ItemRepeats" object:nil]; }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_MultiAddTasks_ItemListItems" object:nil];
    if (RemoveOnly == NO) { [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_MultiAddTasks_ItemListItems:) name:@"NSNotification_MultiAddTasks_ItemListItems" object:nil]; }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_MultiAddTasks_AddHomeMember" object:nil];
    if (RemoveOnly == NO) {  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_MultiAddTasks_AddHomeMember:) name:@"NSNotification_MultiAddTasks_AddHomeMember" object:nil]; }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_MultiAddTasks_AddTask" object:nil];
    if (RemoveOnly == NO) { [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_MultiAddTasks_AddTask:) name:@"NSNotification_MultiAddTasks_AddTask" object:nil]; }
    
    if (_viewingAddedTasks == NO) {
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_MultiAddTasks_RemoveNotificationObservers" object:nil];
        if (RemoveOnly == NO) { [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_MultiAddTasks_RemoveNotificationObservers:) name:@"NSNotification_MultiAddTasks_RemoveNotificationObservers" object:nil]; }
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_MultiAddTasks_UpdateItemDictLocal" object:nil];
        if (RemoveOnly == NO) { [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_MultiAddTasks_UpdateItemDictLocal:) name:@"NSNotification_MultiAddTasks_UpdateItemDictLocal" object:nil]; }
    
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_MultiAddTasks_AddOrEditTaskList" object:nil];
    if (RemoveOnly == NO) { [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_MultiAddTasks_AddOrEditTaskList:) name:@"NSNotification_MultiAddTasks_AddOrEditTaskList" object:nil]; }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_MultiAddTasks_AddOrEditItemTemplate" object:nil];
    if (RemoveOnly == NO) {  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_MultiAddTasks_AddOrEditItemTemplate:) name:@"NSNotification_MultiAddTasks_AddOrEditItemTemplate" object:nil]; }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_MultiAddTasks_DeleteItemTemplate" object:nil];
        if (RemoveOnly == NO) { [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_MultiAddTasks_DeleteItemTemplate:) name:@"NSNotification_MultiAddTasks_DeleteItemTemplate" object:nil]; }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_MultiAddTasks_ItemWeDivvyPremiumAccounts" object:nil];
            if (RemoveOnly == NO) { [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_MultiAddTasks_ItemWeDivvyPremiumAccounts:) name:@"NSNotification_MultiAddTasks_ItemWeDivvyPremiumAccounts" object:nil]; }
    
}

#pragma mark - Setup Methods

-(void)SetUpAnalytics {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewViewController:@"MultiAddTasksViewController" completionHandler:^(BOOL finished) {
        
    }];
    
    [[[GeneralObject alloc] init] TrackInMixPanel:@"MultiAddTasksViewController"];
    
}

-(void)SetUpInitData {
    
    localCurrencySymbol = [[[GeneralObject alloc] init] GenerateLocalCurrencySymbol];
    localCurrencyDecimalSeparatorSymbol = [[[GeneralObject alloc] init] GenerateLocalCurrencyDecimalSeparatorSymbol];
    localCurrencyNumberSeparatorSymbol = [[[GeneralObject alloc] init] GenerateLocalCurrencyNumberSeparatorSymbol];
    
    currentItemType = [[[GeneralObject alloc] init] GenerateItemType];
    currentItemTypeCollection = [NSString stringWithFormat:@"%@s", [[[GeneralObject alloc] init] GenerateItemType]];
    
    keyArray = [[[GeneralObject alloc] init] GenerateKeyArrayManually:[currentItemType containsString:@"Chore"] Expense:[currentItemType containsString:@"Expense"] List:[currentItemType containsString:@"List"] Home:NO];
    
    selectedCellsArray = [NSMutableArray array];
    
    itemSelectedDictLocal = [_itemSelectedDict mutableCopy];
    
    numberOfTasksLabel.text = [NSString stringWithFormat:@"%d", [self TotalNumberOfTasksAdded]];
    
    if (_viewingAddedTasks == NO) {
        
        itemDict = [NSMutableDictionary dictionary];
        itemDictKeys = [NSMutableDictionary dictionary];
        
        [itemDict setObject:
         @{@"Custom" : @[],
           
           @"General" :
               @[ @{@"ItemName" : @"🗑️ Take out the trash", @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Weekly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"General", @"ItemSuggestedID" : @"101"},
                  @{@"ItemName" : @"🪟 Clean the windows", @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Daily", @"ItemDays" : @"", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"General", @"ItemSuggestedID" : @"102"},
                  @{@"ItemName" : @"🧹 Sweep the floor", @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Weekly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"General", @"ItemSuggestedID" : @"103"},
                  @{@"ItemName" : @"🫧 Mop the floor", @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Weekly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"General", @"ItemSuggestedID" : @"104"},
                  @{@"ItemName" : @"👕 Organize Closet", @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Weekly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"General", @"ItemSuggestedID" : @"105"},
                  @{@"ItemName" : @"🧹 Vacuum the floor", @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Weekly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"General", @"ItemSuggestedID" : @"106"},
                  @{@"ItemName" : @"🧹 Vacuum Rug", @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Weekly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"General", @"ItemSuggestedID" : @"107"},
                  @{@"ItemName" : @"👕 Do the laundry", @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Every Other Week", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"General", @"ItemSuggestedID" : @"108"},
                  @{@"ItemName" : @"🧺 Fold the clothes", @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Every Other Week", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"General", @"ItemSuggestedID" : @"109"},
                  @{@"ItemName" : @"🪞 Clean Mirrors", @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Weekly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"General", @"ItemSuggestedID" : @"110"},
                  @{@"ItemName" : @"📺 Dust T.V.", @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Weekly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"General", @"ItemSuggestedID" : @"111"},
                  @{@"ItemName" : @"🏡 Mow the lawn", @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Monthly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"General", @"ItemSuggestedID" : @"112"},
                  @{@"ItemName" : @"🐶 Feed the pets", @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Weekly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"General", @"ItemSuggestedID" : @"113"},
                  @{@"ItemName" : @"💡 Clean the lights", @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Weekly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"General", @"ItemSuggestedID" : @"114"},
                  @{@"ItemName" : @"📫 Get the mail", @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Daily", @"ItemDays" : @"", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"General", @"ItemSuggestedID" : @"115"},
                  @{@"ItemName" : @"🪴 Water the plants", @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Daily", @"ItemDays" : @"", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"General", @"ItemSuggestedID" : @"116"},
                  @{@"ItemName" : @"🚗 Wash the car", @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Monthly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"General", @"ItemSuggestedID" : @"117"}],
           
           @"Kitchen" :
               @[@{@"ItemName" : @"🍽️ Clean the dishes", @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Weekly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Kitchen", @"ItemSuggestedID" : @"118"},
                 @{@"ItemName" : @"🗑️ Replace Trash Bag", @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Weekly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Kitchen", @"ItemSuggestedID" : @"119"},
                 @{@"ItemName" : @"🫧 Mop the floor", @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Weekly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Kitchen", @"ItemSuggestedID" : @"120"},
                 @{@"ItemName" : @"♨️ Clean the oven", @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Weekly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Kitchen", @"ItemSuggestedID" : @"121"},
                 @{@"ItemName" : @"🔥 Clean stove top", @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Weekly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Kitchen", @"ItemSuggestedID" : @"122"},
                 @{@"ItemName" : @"🍏 Stock Pantry", @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Weekly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Kitchen", @"ItemSuggestedID" : @"123"},
                 @{@"ItemName" : @"🫙 Organize the pantry", @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Weekly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Kitchen", @"ItemSuggestedID" : @"124"},
                 @{@"ItemName" : @"🥛 Organize cupboard", @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Weekly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Kitchen", @"ItemSuggestedID" : @"125"},
                 @{@"ItemName" : @"🍴 Unload Dishwasher", @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Weekly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Kitchen", @"ItemSuggestedID" : @"126"},
                 @{@"ItemName" : @"🍴 Load Dishwasher", @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Weekly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Kitchen", @"ItemSuggestedID" : @"127"},
                 @{@"ItemName" : @"🚰 Clean the kitchen sink", @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Weekly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Kitchen", @"ItemSuggestedID" : @"128"},
                 @{@"ItemName" : @"🧼 Disinfect counters", @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Weekly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Kitchen", @"ItemSuggestedID" : @"129"},
                 @{@"ItemName" : @"🍴 Set the table", @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Weekly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Kitchen", @"ItemSuggestedID" : @"130"}],
           
           @"Bathroom" :
               @[ @{@"ItemName" : @"🚽 Clean the toilet", @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Weekly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Bathroom", @"ItemSuggestedID" : @"131"},
                  @{@"ItemName" : @"🚿 Clean the shower", @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Weekly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Bathroom", @"ItemSuggestedID" : @"132"},
                  @{@"ItemName" : @"🚰 Clean bathroom sink", @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Weekly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Bathroom", @"ItemSuggestedID" : @"133"},
                  @{@"ItemName" : @"🪞 Clean the bathroom mirror", @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Weekly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Bathroom", @"ItemSuggestedID" : @"134"}],
           
           @"Living Room" :
               @[@{@"ItemName" : @"🗄️ Organize living room", @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Weekly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Living Room", @"ItemSuggestedID" : @"135"},
                 @{@"ItemName" : @"🛋️ Clean the couch", @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Weekly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Living Room", @"ItemSuggestedID" : @"136"},
                 @{@"ItemName" : @"☕️ Clean the coffee table", @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Weekly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Living Room", @"ItemSuggestedID" : @"137"},
                 @{@"ItemName" : @"📺 Clean the T.V. stand", @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Weekly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Living Room", @"ItemSuggestedID" : @"138"}],
           
           @"Bedroom" :
               @[@{@"ItemName" : @"🛌 Make the bed", @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Daily", @"ItemDays" : @"", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Bedroom", @"ItemSuggestedID" : @"139"},
                 @{@"ItemName" : @"🛏️ Change bed sheets", @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Weekly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Bedroom", @"ItemSuggestedID" : @"140"},
                 @{@"ItemName" : @"🛏️ Change Pillow Casings", @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Weekly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Bedroom", @"ItemSuggestedID" : @"141"},
                 @{@"ItemName" : @"🗄️ Organize bedroom", @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Weekly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Bedroom", @"ItemSuggestedID" : @"142"},
                 @{@"ItemName" : @"🌘 Clean the nightstand", @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Weekly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Bedroom", @"ItemSuggestedID" : @"143"}],
         } forKey:@"Chores"];
        
        [itemDictKeys setObject:@[@"Custom",
                                  @"General",
                                  @"Kitchen",
                                  @"Bathroom",
                                  @"Living Room",
                                  @"Bedroom"] forKey:@"Chores"];
        
        [itemDict setObject:@{@"Custom" : @[],
                              
                              @"Bills" :
                                  @[@{@"ItemName" : @"🏬 Rent", @"ItemAmount" : [NSString stringWithFormat:@"%@1%@000%@00", localCurrencySymbol, localCurrencyNumberSeparatorSymbol, localCurrencyDecimalSeparatorSymbol], @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Monthly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Bills", @"ItemSuggestedID" : @"144"},
                                    @{@"ItemName" : @"🏠 Mortgage", @"ItemAmount" : [NSString stringWithFormat:@"%@1%@000%@00", localCurrencySymbol, localCurrencyNumberSeparatorSymbol, localCurrencyDecimalSeparatorSymbol], @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Monthly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Bills", @"ItemSuggestedID" : @"145"},
                                    @{@"ItemName" : @"⚡️ Electric Bill", @"ItemAmount" : [NSString stringWithFormat:@"%@225%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol], @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Monthly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Bills", @"ItemSuggestedID" : @"146"},
                                    @{@"ItemName" : @"💧 Water Bill", @"ItemAmount" : [NSString stringWithFormat:@"%@100%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol], @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Monthly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Bills", @"ItemSuggestedID" : @"147"},
                                    @{@"ItemName" : @"⛽️ Gas Bill", @"ItemAmount" : [NSString stringWithFormat:@"%@150%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol], @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Monthly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Bills", @"ItemSuggestedID" : @"148"},
                                    @{@"ItemName" : @"💻 Wi-fi Bill", @"ItemAmount" : [NSString stringWithFormat:@"%@75%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol], @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Monthly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Bills", @"ItemSuggestedID" : @"149"},
                                    @{@"ItemName" : @"☎️ Phone Bill", @"ItemAmount" : [NSString stringWithFormat:@"%@150%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol], @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Monthly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Bills", @"ItemSuggestedID" : @"150"},
                                    @{@"ItemName" : @"🎓 Tuition", @"ItemAmount" : [NSString stringWithFormat:@"%@2000%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol], @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Monthly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Bills", @"ItemSuggestedID" : @"151"},],
                              @"Insurance" :
                                  @[@{@"ItemName" : @"🚗 Car Insurance", @"ItemAmount" : [NSString stringWithFormat:@"%@250%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol], @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Monthly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Insurance", @"ItemSuggestedID" : @"152"},
                                    @{@"ItemName" : @"🏬 Renters Insurance", @"ItemAmount" : [NSString stringWithFormat:@"%@25%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol], @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Monthly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Insurance", @"ItemSuggestedID" : @"153"},
                                    @{@"ItemName" : @"🏠 Homeowners Insurance", @"ItemAmount" : [NSString stringWithFormat:@"%@200%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol], @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Monthly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Insurance", @"ItemSuggestedID" : @"154"},
                                    @{@"ItemName" : @"🏥 Health Insurance", @"ItemAmount" : [NSString stringWithFormat:@"%@150%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol], @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Monthly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Insurance", @"ItemSuggestedID" : @"155"},
                                    @{@"ItemName" : @"👼 Life Insurance", @"ItemAmount" : [NSString stringWithFormat:@"%@75%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol], @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Monthly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Insurance", @"ItemSuggestedID" : @"156"},
                                    @{@"ItemName" : @"🔥 Fire Insurance", @"ItemAmount" : [NSString stringWithFormat:@"%@50%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol], @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Monthly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Insurance", @"ItemSuggestedID" : @"157"},
                                    @{@"ItemName" : @"🌊 Flood Insurance", @"ItemAmount" : [NSString stringWithFormat:@"%@100%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol], @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Monthly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Insurance", @"ItemSuggestedID" : @"158"},
                                    @{@"ItemName" : @"🌋 Volcano Insurance", @"ItemAmount" : [NSString stringWithFormat:@"%@50%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol], @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Monthly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Insurance", @"ItemSuggestedID" : @"159"},
                                    @{@"ItemName" : @"⛵️ Boat Insurance", @"ItemAmount" : [NSString stringWithFormat:@"%@250%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol], @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Monthly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Insurance", @"ItemSuggestedID" : @"160"},
                                  ],
                              @"Goods" :
                                  @[@{@"ItemName" : @"🍔 Food", @"ItemAmount" : [NSString stringWithFormat:@"%@300%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol], @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Monthly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Goods", @"ItemSuggestedID" : @"161"},
                                    @{@"ItemName" : @"🧻 Household Supplies", @"ItemAmount" : [NSString stringWithFormat:@"%@100%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol], @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Monthly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Goods", @"ItemSuggestedID" : @"162"},
                                    @{@"ItemName" : @"📓 School Supplies", @"ItemAmount" : [NSString stringWithFormat:@"%@100%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol], @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Monthly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Goods", @"ItemSuggestedID" : @"163"},
                                    @{@"ItemName" : @"👕 Clothes", @"ItemAmount" : [NSString stringWithFormat:@"%@250%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol], @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Monthly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Goods", @"ItemSuggestedID" : @"164"},
                                    @{@"ItemName" : @"🔧 Car Parts", @"ItemAmount" : [NSString stringWithFormat:@"%@500%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol], @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Monthly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Goods", @"ItemSuggestedID" : @"165"},
                                    @{@"ItemName" : @"🛠️ Tools", @"ItemAmount" : [NSString stringWithFormat:@"%@150%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol], @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Monthly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Goods", @"ItemSuggestedID" : @"166"},],
                              @"Miscellaneous" :
                                  @[ @{@"ItemName" : @"👨‍🍳 Restaurants", @"ItemAmount" : [NSString stringWithFormat:@"%@125%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol], @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Monthly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Miscellaneous", @"ItemSuggestedID" : @"167"},
                                     @{@"ItemName" : @"🍿 Movies", @"ItemAmount" : [NSString stringWithFormat:@"%@50%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol], @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Monthly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Miscellaneous", @"ItemSuggestedID" : @"168"},
                                     @{@"ItemName" : @"🚙 Road Trips", @"ItemAmount" : [NSString stringWithFormat:@"%@250%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol], @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Monthly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Miscellaneous", @"ItemSuggestedID" : @"169"},
                                     @{@"ItemName" : @"🥳 Parties", @"ItemAmount" : [NSString stringWithFormat:@"%@200%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol], @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Monthly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Miscellaneous", @"ItemSuggestedID" : @"170"},
                                     @{@"ItemName" : @"🎉 Events", @"ItemAmount" : [NSString stringWithFormat:@"%@100%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol], @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Monthly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Miscellaneous", @"ItemSuggestedID" : @"171"},
                                     @{@"ItemName" : @"🦖 Museums", @"ItemAmount" : [NSString stringWithFormat:@"%@150%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol], @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Monthly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Miscellaneous", @"ItemSuggestedID" : @"172"},
                                     @{@"ItemName" : @"🥾 Recreational Activities", @"ItemAmount" : [NSString stringWithFormat:@"%@75%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol], @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Monthly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Miscellaneous", @"ItemSuggestedID" : @"173"},
                                     @{@"ItemName" : @"🏔️ Outdoor Activities", @"ItemAmount" : [NSString stringWithFormat:@"%@100%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol], @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Monthly", @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Miscellaneous", @"ItemSuggestedID" : @"174"}],
                            } forKey:@"Expenses"];
        
        [itemDictKeys setObject:@[@"Custom",
                                  @"Bills",
                                  @"Insurance",
                                  @"Goods",
                                  @"Miscellaneous"] forKey:@"Expenses"];
        
        [itemDict setObject:@{@"Custom" : @[],
                              
                              @"Lists" :
                                  @[@{@"ItemName" : @"🛒 Shopping", @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Monthly", @"ItemListItems" : @{}, @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Groceries", @"ItemSuggestedID" : @"175"},
                                    @{@"ItemName" : @"🏡 Household Supplies", @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Monthly", @"ItemListItems" : @{}, @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Household Supplies", @"ItemSuggestedID" : @"176"},
                                    @{@"ItemName" : @"👕 Clothes", @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Monthly", @"ItemListItems" : @{}, @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"Clothes", @"ItemSuggestedID" : @"177"},
                                    @{@"ItemName" : @"📝 To-Do", @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Monthly", @"ItemListItems" : @{}, @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"To-Do", @"ItemSuggestedID" : @"178"},
                                    
                                    @{@"ItemName" : @"📖 School Supplies", @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemRepeats" : @"Monthly", @"ItemListItems" : @{}, @"ItemDays" : @"Any Day", @"ItemTime" : @"Any Time", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority", @"ItemTaskList" : @"School Supplies", @"ItemSuggestedID" : @"179"}],
                            } forKey:@"Lists"];
        
        [itemDictKeys setObject:@[@"Custom", @"Lists"] forKey:@"Lists"];
        
    } else {
        
        if ([[_itemDictFromPreviousPage allKeys] count] > 0) {
            itemDict = [_itemDictFromPreviousPage mutableCopy];
        }
        
        if ([[_itemDictKeysFromPreviousPage allKeys] count] > 0) {
            itemDictKeys = [_itemDictKeysFromPreviousPage mutableCopy];
        }
        
    }
    
}

-(void)SetUpViewingAddTasks {
    
    numberOfTasksView.hidden = YES;
    numberOfTasksLabel.hidden = YES;
    
    if (_viewingAddedTasks) {
        
        Searching = NO;
        
        numberOfTasksImageView.hidden = YES;
        _searchBarView.hidden = YES;
        
    }
    
}

-(void)SetUpTableViewAndSearchBar {
    
    _searchBar.delegate = self;
    
    self.customScrollView.delegate = self;
    
    self.customTableView.delegate = self;
    self.customTableView.dataSource = self;
    
    [self.customTableView reloadData];
    
}

-(void)SetUpTopView {
    
    NSString *listName = _defaultTaskListName != NULL && _defaultTaskListName != nil ? _defaultTaskListName : @"No List";
    
    topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, self.navigationController.navigationBar.frame.size.height)];
    topViewCover = [[UIButton alloc] initWithFrame:topView.frame];
    
    topViewImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 8.5, self.navigationController.navigationBar.frame.size.height)];
    topViewImageView.image = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [UIImage imageNamed:@"down.white.arrow"] : [UIImage imageNamed:@"GeneralIcons.TopLabelArrow"];
    topViewImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    topViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [[[GeneralObject alloc] init] WidthOfString:listName withFont:[UIFont systemFontOfSize:15 weight:UIFontWeightSemibold]], topView.frame.size.height)];
    topViewLabel.text = listName;
    topViewLabel.textColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTextPrimary] : [[[LightDarkModeObject alloc] init] LightModeTextPrimary];
    topViewLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightSemibold];
    topViewLabel.textAlignment = NSTextAlignmentCenter;
    topViewLabel.adjustsFontSizeToFitWidth = YES;
    
    CGRect newRect = topView.frame;
    newRect.size.width = topViewLabel.frame.size.width;
    newRect.origin.x = self.view.frame.size.width*0.5 - newRect.size.width*0.5;
    topView.frame = newRect;
    
    newRect = topViewImageView.frame;
    newRect.origin.x = topView.frame.size.width + 4;
    topViewImageView.frame = newRect;
    
    UIWindow *currentwindow = [UIApplication sharedApplication].windows.firstObject;
    [topView addSubview:topViewLabel];
    [topView addSubview:topViewImageView];
    [currentwindow addSubview:topView];
    [currentwindow addSubview:topViewCover];
    
    [self.navigationController.navigationBar addSubview:topView];
    [self.navigationController.navigationBar addSubview:topViewCover];
    
    [self UpdateTopViewLabel:listName];
    
}

#pragma mark - UI Methods

-(void)StartProgressView {
    
    self->progressView = [MRProgressOverlayView showOverlayAddedTo:self.navigationController.view animated:YES];
    self->progressView.mode = MRProgressOverlayViewModeDeterminateHorizontalBar;
    
}

-(void)AdjustTableViewHeight {
  
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    int totalCount = 0;
    
    if (_viewingAddedTasks) {
        
        for (NSString *itemType in [itemSelectedDictLocal allKeys]) {
            
            NSMutableDictionary *specificItemTypeDictOfSelectedTasks = itemSelectedDictLocal && itemSelectedDictLocal[itemType] ? itemSelectedDictLocal[itemType] : [NSMutableDictionary dictionary];
            NSArray *specificItemTypeArrayOfSelectedTaskNames = [specificItemTypeDictOfSelectedTasks allKeys] ? [specificItemTypeDictOfSelectedTasks allKeys] : @[];
            
            for (int i=0 ; i<specificItemTypeArrayOfSelectedTaskNames.count ; i++) {
                
                totalCount += 1;
                
            }
            
        }
        
    } else {
        
        if (Searching == NO) {
            
            NSMutableDictionary *specificItemTypeDictOfAllTasks = itemDict && itemDict[currentItemTypeCollection] ? itemDict[currentItemTypeCollection] : [NSMutableDictionary dictionary];
            
            if (itemDictKeys && itemDictKeys[currentItemTypeCollection]) {
                
                for (NSString *specificItemTypeDictOfAllTasksSpecificSection in itemDictKeys[currentItemTypeCollection]) {
                    
                    NSMutableArray *specificItemTypeArrayOfAllTaskNamesInSpecificSection = specificItemTypeDictOfAllTasks[specificItemTypeDictOfAllTasksSpecificSection] ? specificItemTypeDictOfAllTasks[specificItemTypeDictOfAllTasksSpecificSection] : [NSMutableArray array];
                    
                    for (int i=0 ; i<specificItemTypeArrayOfAllTaskNamesInSpecificSection.count ; i++) {
                        
                        totalCount += 1;
                        
                    }
                    
                }
                
            }
            
        } else {
            
            if (searchResults && [(NSArray *)searchResults[@"ItemName"] count] > 0) {
                
                for (int i=0 ; i<[(NSArray *)searchResults[@"ItemName"] count] ; i++) {
                    
                    totalCount += 1;
                    
                }
                
            } else {
                
                totalCount += 1;
                
            }
            
        }
        
    }
    
    NSDictionary *dictToUse = [NSDictionary dictionary];
    
    if (Searching == NO) {
        
        if (_viewingAddedTasks) {
            
            dictToUse = itemSelectedDictLocal ? [itemSelectedDictLocal mutableCopy] : [NSMutableDictionary dictionary];
            
        } else {
            
            NSMutableDictionary *choreDict = itemDict && itemDict[currentItemTypeCollection] ? [itemDict[currentItemTypeCollection] mutableCopy] : [NSMutableDictionary dictionary];
            
            dictToUse = choreDict;
            
        }
        
    }
    
    int sectionCount = 0;
    
    sectionCount = dictToUse ? (int)[[dictToUse allKeys] count] : 0;
    sectionCount = sectionCount == 0 ? 1 : sectionCount;
    
    CGFloat tableViewHeight = 0;
    tableViewHeight += totalCount * (self.view.frame.size.height*0.11005435 > 81?(81):self.view.frame.size.height*0.11005435);
    tableViewHeight += sectionCount * (_viewingAddedTasks ? 0.1 : (height*0.0824587 > 55?(55):height*0.0824587));
    tableViewHeight += [selectedCellsArray count] * (self.view.frame.size.height*0.08245877 > 55?(55):self.view.frame.size.height*0.08245877);
    
    CGRect newRect = self->_customTableView.frame;
    newRect.size.height = tableViewHeight;
    self->_customTableView.frame = newRect;
    
    CGFloat scrollViewHeight = _customTableView.frame.origin.y + self->_customTableView.frame.size.height;
    
    if (scrollViewHeight < height+1) {
        scrollViewHeight = height+1;
    }
    
    self->_customScrollView.contentSize = CGSizeMake(0, scrollViewHeight);
    
}

-(void)DisplayAddMultipleTasksTutorialView {
    
    NSMutableDictionary *tutorialViewDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"TutorialViewDisplayed"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"TutorialViewDisplayed"] mutableCopy] : [NSMutableDictionary dictionary];
    
    if (!tutorialViewDict[@"MultiAddTaskDisplayed"] || [tutorialViewDict[@"MultiAddTaskDisplayed"] isEqualToString:@"Yes"] == NO) {
        
        
        [tutorialViewDict setObject:@"Yes" forKey:@"MultiAddTaskDisplayed"];
        [[NSUserDefaults standardUserDefaults] setObject:tutorialViewDict forKey:@"TutorialViewDisplayed"];
        
        CGFloat myViewHeight = (self.view.frame.size.height);
        
        TutorialView *myView = [[TutorialView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, myViewHeight)
                                                 helpViewFrameYPos:(self.view.frame.size.height*0.65067466 > 660?(660):self.view.frame.size.height*0.65067466)
                                               viewControllerWidth:self.view.frame.size.width
                                              viewControllerHeight:self.view.frame.size.height
                                                             title:[NSString stringWithFormat:@"Quickly add your tasks! 😀"]
                                                              body:[NSString stringWithFormat:@"Click on a task to customize it. When you're finished press the 'plus' button to add it."]];
        
        myView.alpha = 0.0f;
        [self.view addSubview:myView];
        
        [UIView animateWithDuration:0.25 animations:^{
            myView.alpha = 1.0f;
        }];
        
    }
    
}

-(void)UpdateAddTasksUI:(BOOL)ShowTinyView {
    
    numberOfTasksLabel.hidden = !_viewingAddedTasks && [self TotalNumberOfTasksAdded] == 0 ? YES : NO;
    numberOfTasksView.hidden = !_viewingAddedTasks && [self TotalNumberOfTasksAdded] == 0 ? YES : NO;
    numberOfTasksView.layer.cornerRadius = numberOfTasksView.frame.size.height/2;
    
    CGRect newRect = numberOfTasksView.frame;
    newRect.origin.x = numberOfTasksImageView.frame.origin.x + (numberOfTasksImageView.frame.size.width*0.5);
    newRect.origin.y = numberOfTasksImageView.frame.origin.y - (numberOfTasksImageView.frame.size.height*0.5);
    numberOfTasksView.frame = newRect;
    
    UIView *tinyView = [[UIView alloc] initWithFrame:
                        CGRectMake(_searchBarView.frame.origin.x + (self.view.frame.size.height*0.02717 > 20?20:(self.view.frame.size.height*0.02717)),
                                   _searchBarView.frame.origin.y + (_searchBarView.frame.size.height*0.5 - numberOfTasksView.frame.size.height*0.25),
                                   numberOfTasksView.frame.size.width*0.5,
                                   numberOfTasksView.frame.size.height*0.5)];
    tinyView.layer.cornerRadius = tinyView.frame.size.height/2;
    tinyView.backgroundColor = [UIColor systemPinkColor];
    
    
    
    //    [_searchBar resignFirstResponder];
    //
    if (_searchBar.text.length > 0 && ShowTinyView == YES) {
        //
        [self.customScrollView addSubview:tinyView];
        //        _searchBar.text = @"";
        //        Searching = NO;
        //        _clearSearchBarView.hidden = YES;
        //
    }
    
    
    
    [UIView animateWithDuration:0.25 delay:0 options:0 animations:^{
        
        CGRect newRect = tinyView.frame;
        newRect.origin.x = self->numberOfTasksSuperView.frame.origin.x - newRect.size.width;
        newRect.origin.y = (self.navigationController.navigationBar.frame.size.height*-1) + (self.navigationController.navigationBar.frame.size.height*0.5 - tinyView.frame.size.height*0.25);
        tinyView.frame = newRect;
        
    } completion:^(BOOL finished) {
        
        [tinyView removeFromSuperview];
        
        [UIView animateWithDuration:0.25 delay:0 options:0 animations:^{
            
            self->numberOfTasksView.transform = CGAffineTransformMakeScale(1.35, 1.35);
            
            self->numberOfTasksLabel.text = [NSString stringWithFormat:@"%d", [self TotalNumberOfTasksAdded]];
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.25 animations:^{
                
                self->numberOfTasksView.transform = CGAffineTransformIdentity;
                
            }];
            
        }];
        
    }];
    
    
    
    [self BarButtonItems];
    
    [self AdjustTableViewHeight];
    
    [self.customTableView reloadData];
    
}

-(void)UpdateTopViewLabel:(NSString *)topViewLabelString {
    
    topViewLabel.text = topViewLabelString;
    
    CGRect newRect;
    
    newRect = topViewLabel.frame;
    newRect.size.width = [[[GeneralObject alloc] init] WidthOfString:topViewLabelString withFont:topViewLabel.font];
    topViewLabel.frame = newRect;
    
    newRect = topView.frame;
    newRect.size.width = topViewLabel.frame.size.width;
    newRect.origin.x = self.view.frame.size.width*0.5 - newRect.size.width*0.5;
    topView.frame = newRect;
    
    newRect = topViewImageView.frame;
    newRect.origin.x = topView.frame.size.width + 4;
    topViewImageView.frame = newRect;
    
    newRect = topViewCover.frame;
    newRect = topView.frame;
    newRect.size.width = topViewLabel.frame.size.width + topViewImageView.frame.size.width;
    topViewCover.frame = newRect;
    
}

#pragma mark

-(void)GenerateSelectedUnselectedView:(BOOL)ShowSelected previousView:(UIView * _Nullable)previousView addTaskScrollViewIcon:(UIView *)addTaskScrollViewIcon addTaskSelectedView:(UIView *)addTaskSelectedView addTaskSelectedViewImageView:(UIImageView *)addTaskSelectedViewImageView addTaskSelectedViewLabel:(UILabel *)addTaskSelectedViewLabel addTaskSelectedViewXView:(UIView *)addTaskSelectedViewXView addTaskSelectedViewXImageView:(UIImageView *)addTaskSelectedViewXImageView labelText:(NSString *)labelText key:(NSString *)key cell:(MultiAddTaskCell *)cell {
    
    CGFloat iconHeight = (self.view.frame.size.height*0.02998501 > 20?20:(self.view.frame.size.height*0.02998501));
    CGFloat spacingNo1 = (self.view.frame.size.height*0.02317497 > 20?20:(self.view.frame.size.height*0.02317497));
    CGFloat spacingNo2 = 8;
    
    if (addTaskScrollViewIcon == cell.addTaskScrollViewPriorityIcon) {
        iconHeight = iconHeight*0.75;
    }
    
    CGFloat spacingToUse = spacingNo1;
    
    if ((previousView == cell.addTaskSelectedViewAmount || previousView == cell.addTaskSelectedViewListItems || previousView == cell.addTaskSelectedViewTaskList || previousView == cell.addTaskSelectedViewRepeats || previousView == cell.addTaskSelectedViewPriority || previousView == cell.addTaskSelectedViewTakeTurns) && ShowSelected == YES) {
        spacingToUse = spacingNo2;
    }
    
    CGFloat xPos = previousView != nil ? previousView.frame.origin.x + previousView.frame.size.width + spacingToUse : 0;
    
    if (ShowSelected == YES) {
        
        addTaskSelectedView.hidden = NO;
        addTaskScrollViewIcon.hidden = YES;
        addTaskSelectedView.frame = CGRectMake(xPos, 0, 0, cell.addTaskOptionsScrollView.frame.size.height);
        
        [self GenerateSelectedViewFrame:addTaskSelectedView addTaskSelectedViewImageView:addTaskSelectedViewImageView addTaskSelectedViewLabel:addTaskSelectedViewLabel addTaskSelectedViewXView:addTaskSelectedViewXView addTaskSelectedViewXImageView:addTaskSelectedViewXImageView labelText:labelText key:key cell:cell];
        
    } else {
        
        addTaskSelectedView.hidden = YES;
        addTaskScrollViewIcon.hidden = NO;
        
        addTaskScrollViewIcon.frame = CGRectMake(xPos, 0, iconHeight, cell.addTaskOptionsScrollView.frame.size.height);
        
    }
    
    CGFloat maxWidth = self.view.frame.size.width+1;
    CGFloat floatToUse = 0;
    
    if (cell.addTaskSelectedViewPriority.hidden == NO) {
        
        floatToUse = cell.addTaskSelectedViewPriority.frame.origin.x + cell.addTaskSelectedViewPriority.frame.size.width;
        
    } else {
        
        floatToUse = cell.addTaskScrollViewPriorityIcon.frame.origin.x + cell.addTaskScrollViewPriorityIcon.frame.size.width;
        
    }
    
    if (floatToUse < maxWidth) {
        floatToUse = maxWidth;
    }
    
    cell.addTaskOptionsScrollView.contentSize = CGSizeMake(floatToUse, 0);
    
    if (floatToUse < maxWidth) {
        floatToUse = maxWidth;
    }
    
    //    cell.addTaskOptionsScrollViewNo1.contentSize = CGSizeMake(floatToUse, 0);
    
}

-(void)GenerateSelectedViewFrame:(UIView *)addTaskSelectedView addTaskSelectedViewImageView:(UIImageView *)addTaskSelectedViewImageView addTaskSelectedViewLabel:(UILabel *)addTaskSelectedViewLabel addTaskSelectedViewXView:(UIView *)addTaskSelectedViewXView addTaskSelectedViewXImageView:(UIImageView *)addTaskSelectedViewXImageView labelText:(NSString *)labelText key:(NSString *)key cell:(MultiAddTaskCell *)cell {
    
    CGFloat firstWidth = (self.view.frame.size.height*0.01860465 > 8?8:(self.view.frame.size.height*0.01860465));
    CGFloat secondWidth = (self.view.frame.size.height*0.02325581 > 10?10:(self.view.frame.size.height*0.02325581));
    
    addTaskSelectedView.layer.cornerRadius = addTaskSelectedView.frame.size.height/2;
    
    CGFloat width = CGRectGetWidth(addTaskSelectedView.bounds);
    CGFloat height = CGRectGetHeight(addTaskSelectedView.bounds);
    
    CGFloat iconHeight = height;
    
    if (addTaskSelectedViewImageView == cell.addTaskSelectedViewImageViewPriority) {
        iconHeight = iconHeight*0.45;
    }
    
    addTaskSelectedViewImageView.frame = CGRectMake(secondWidth, height*0.5 - iconHeight*0.5, (firstWidth*2), iconHeight);
    addTaskSelectedViewLabel.frame = CGRectMake(addTaskSelectedViewImageView.frame.origin.x + addTaskSelectedViewImageView.frame.size.width + firstWidth, 0, 0, height);
    
    addTaskSelectedViewLabel.adjustsFontSizeToFitWidth = YES;
    addTaskSelectedViewLabel.textColor = [UIColor whiteColor];
    addTaskSelectedViewLabel.text = labelText;
    
    CGRect newRect = addTaskSelectedViewLabel.frame;
    newRect.size.width = [key isEqualToString:@"ItemTakeTurns"] || [key isEqualToString:@"ItemNotes"] || [key isEqualToString:@"ItemCostPerPerson"] || addTaskSelectedViewLabel.text == nil ? 0 : [[[GeneralObject alloc] init] WidthOfString:addTaskSelectedViewLabel.text withFont:addTaskSelectedViewLabel.font];
    addTaskSelectedViewLabel.frame = newRect;
    
    addTaskSelectedViewXView.frame = CGRectMake(addTaskSelectedViewLabel.frame.origin.x + addTaskSelectedViewLabel.frame.size.width + firstWidth, height*0.5 - (firstWidth*2)*0.5, (firstWidth*2), (firstWidth*2));
    addTaskSelectedViewXView.layer.cornerRadius = addTaskSelectedViewXView.frame.size.height/2;
    
    newRect = addTaskSelectedView.frame;
    newRect.size.width = addTaskSelectedViewXView.frame.origin.x + addTaskSelectedViewXView.frame.size.width + secondWidth;
    addTaskSelectedView.frame = newRect;
    
    width = CGRectGetWidth(addTaskSelectedViewXView.bounds);
    height = CGRectGetHeight(addTaskSelectedViewXView.bounds);
    
    addTaskSelectedViewXImageView.frame = CGRectMake(width*0.5 - width*0.5*0.5, height*0.5 - height*0.5*0.5, width*0.5, height*0.5);
    
}


#pragma mark - UX Methods

-(void)SearchAlgolia:(UITextField *)textField {
    
    if ((![textField.text isEqualToString:@""]) && (![textField.text isEqualToString:@" "])){
        
        NSString* ALGOLIA_APP_ID = @"3VZ11H3TM1";
        NSString* ALGOLIA_USER_INDEX_NAME = [NSString stringWithFormat:@"System_%@", currentItemTypeCollection];
        NSString* ALGOLIA_ADMIN_API_KEY = @"37558fa21fb4266d0f5213af41a23a7a";
        
        
        Client *apiClient = [[Client alloc] initWithAppID:ALGOLIA_APP_ID apiKey:ALGOLIA_ADMIN_API_KEY];
        
        Index *movieIndex;
        NSString *queryAttribute;
        
        movieIndex = [apiClient indexWithName:ALGOLIA_USER_INDEX_NAME];
        queryAttribute = @"ItemName";
        
        
        
        Query *query = [[Query alloc] init];
        query.query = textField.text;
        query.attributesToRetrieve = keyArray;
        query.attributesToHighlight = @[queryAttribute];
        
        [movieIndex search:query completionHandler:^(NSDictionary<NSString *,id> * string, NSError * error) {
            
            NSArray *keyArray = [[[GeneralObject alloc] init] GenerateKeyArrayManually:YES Expense:NO List:NO Home:NO];
            NSArray *keyArrayNo1 = [[[GeneralObject alloc] init] GenerateKeyArrayManually:NO Expense:YES List:NO Home:NO];
            NSArray *keyArrayNo2 = [[[GeneralObject alloc] init] GenerateKeyArrayManually:NO Expense:NO List:YES Home:NO];
            
            NSMutableArray *keyArrayCopy = [keyArray mutableCopy];
            
            for (NSString *key in keyArrayNo1) {
                if ([keyArrayCopy containsObject:key] == NO) {
                    [keyArrayCopy addObject:key];
                }
            }
            for (NSString *key in keyArrayNo2) {
                if ([keyArrayCopy containsObject:key] == NO) {
                    [keyArrayCopy addObject:key];
                }
            }
            
            keyArray = [keyArrayCopy copy];
            
            NSMutableDictionary *tempSearchResults = [self FillDictWithSearchResults:string keyArray:keyArray];
            
            tempSearchResults = [self ReplaceNullData:tempSearchResults keyArray:keyArray];
            
            tempSearchResults = [self ReplaceSearchingDataWithItemDictData:tempSearchResults];
            
            self->selectedCellsArray = [NSMutableArray array];
            self->searchResults = [tempSearchResults mutableCopy];
            
            [self AdjustTableViewHeight];
            
            [self.customTableView reloadData];
            
        }];
        
        [self AdjustTableViewHeight];
        
        [self.customTableView reloadData];
        
    }
    
}

-(int)TotalNumberOfTasksAdded {
    
    NSArray *arr = @[@"Chores", @"Expenses", @"Lists"];
    int total = 0;
    
    for (NSString *itemType in arr) {
        
        if (itemSelectedDictLocal && itemSelectedDictLocal[itemType]) {
            
            total += [[itemSelectedDictLocal[itemType] allKeys] count];
            
        }
        
    }
    
    return total;
}

-(BOOL)TaskHasBeenSelected:(NSIndexPath *)indexPath {
    
    BOOL TaskHasBeenSelected = NO;
    
    if (_viewingAddedTasks) {
        
        NSString *itemType = itemSelectedDictLocal && [[itemSelectedDictLocal allKeys] count] > indexPath.section ? [itemSelectedDictLocal allKeys][indexPath.section] : @"";
        NSMutableDictionary *specificItemTypeDictOfSelectedTasks = itemSelectedDictLocal && itemSelectedDictLocal[itemType] ? itemSelectedDictLocal[itemType] : [NSMutableDictionary dictionary];
        NSArray *specificItemTypeArrayOfSelectedTaskNames = [specificItemTypeDictOfSelectedTasks allKeys];
        NSString *objectToUse = [specificItemTypeArrayOfSelectedTaskNames count] > indexPath.row ? specificItemTypeArrayOfSelectedTaskNames[indexPath.row] : @"";
        
        if ([[specificItemTypeDictOfSelectedTasks allKeys] containsObject:objectToUse]) {
            return YES;
        }
        
    } else {
        
        NSMutableDictionary *specificItemTypeDictOfAllTasks = itemDict && itemDict[currentItemTypeCollection] ? itemDict[currentItemTypeCollection] : [NSMutableDictionary dictionary];
        
        NSString *specificItemTypeDictOfAllTasksSpecificSection = itemDictKeys && itemDictKeys[currentItemTypeCollection] && [(NSArray *)itemDictKeys[currentItemTypeCollection] count] > indexPath.section ? itemDictKeys[currentItemTypeCollection][indexPath.section] : @"";
        NSMutableArray *specificItemTypeDictOfAllTasksNamesInSpecificSection = specificItemTypeDictOfAllTasks[specificItemTypeDictOfAllTasksSpecificSection] ? specificItemTypeDictOfAllTasks[specificItemTypeDictOfAllTasksSpecificSection] : [NSMutableArray array];
        
        NSMutableDictionary *dict = itemSelectedDictLocal && itemSelectedDictLocal[currentItemTypeCollection] ? [itemSelectedDictLocal[currentItemTypeCollection] mutableCopy] : [NSMutableDictionary dictionary];
        
        NSString *objectToUse = Searching ? searchResults && searchResults[@"ItemSuggestedID"] && [(NSArray *)searchResults[@"ItemSuggestedID"] count] > indexPath.row ? searchResults[@"ItemSuggestedID"][indexPath.row] : @"" : [specificItemTypeDictOfAllTasksNamesInSpecificSection count] > indexPath.row ? specificItemTypeDictOfAllTasksNamesInSpecificSection[indexPath.row][@"ItemSuggestedID"] : @"";
        
        if ([[dict allKeys] containsObject:objectToUse]) {
            return YES;
        }
        
    }
    
    return TaskHasBeenSelected;
}

-(BOOL)FormatAmountTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    textField.text = [[[GeneralObject alloc] init] FormatAmountTextField:textField.text replacementString:string];
    
    return NO;
    
}

-(void)GenerateItemDictSearchingDictAndSelectedDictWithUpdatedData:(NSIndexPath *)indexPath key:(NSString *)key object:(id)object {
    
    [self GenerateItemDictWithUpdatedData:indexPath key:key object:object];
    
    if (Searching == YES) {
        searchResults = [self ReplaceSearchingDataWithItemDictData:[searchResults mutableCopy]];
    }
    
    [self GenerateItemSelectedDictWithUpdatedData:indexPath key:key object:object];
    
    [self.customTableView reloadData];
    
}

#pragma mark

-(void)GenerateItemDictWithUpdatedData:(NSIndexPath *)indexPath key:(NSString *)key object:(id)object {
    
    NSIndexPath *indexPathForItemWithNameInItemDict = [self GenerateIndexPathForItemWithName:indexPath];
    
    if (indexPathForItemWithNameInItemDict.row != 1000) {
        
        NSMutableDictionary *itemDictCopy = itemDict ? [itemDict mutableCopy] : [NSMutableDictionary dictionary];
        NSMutableDictionary *specificItemTypeDict = itemDictCopy[currentItemTypeCollection] ? [itemDictCopy[currentItemTypeCollection] mutableCopy] : [NSMutableDictionary dictionary];
        
        NSMutableArray *specificItemTypeDictOfAllTasks = itemDictKeys && itemDictKeys[currentItemTypeCollection] ? [itemDictKeys[currentItemTypeCollection] mutableCopy] : [NSMutableArray array];
        NSString *specificItemTypeDictSpecificSection = specificItemTypeDictOfAllTasks && [specificItemTypeDictOfAllTasks count] > indexPathForItemWithNameInItemDict.section ? specificItemTypeDictOfAllTasks[indexPathForItemWithNameInItemDict.section] : @"";
        
        NSMutableArray *specificSectionArray = specificItemTypeDict[specificItemTypeDictSpecificSection] ? [specificItemTypeDict[specificItemTypeDictSpecificSection] mutableCopy] : [NSMutableArray array];
        NSMutableDictionary *specificItemDict = [specificSectionArray count] > indexPathForItemWithNameInItemDict.row ? [specificSectionArray[indexPathForItemWithNameInItemDict.row] mutableCopy] : [NSMutableDictionary dictionary];
        
        [specificItemDict setObject:object forKey:key];
        if ([specificSectionArray count] > indexPathForItemWithNameInItemDict.row) { [specificSectionArray replaceObjectAtIndex:indexPathForItemWithNameInItemDict.row withObject:specificItemDict]; }
        [specificItemTypeDict setObject:specificSectionArray forKey:specificItemTypeDictSpecificSection];
        [itemDictCopy setObject:specificItemTypeDict forKey:currentItemTypeCollection];
        
        itemDict = [itemDictCopy mutableCopy];

        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"UpdateItemDictLocal" userInfo:@{@"ItemDictLocal" : self->itemDict} locations:@[@"MultiAddTasks"]];
        
    }
    
}

-(void)GenerateItemSelectedDictWithUpdatedData:(NSIndexPath *)indexPath key:(NSString *)key object:(id)object {
    
    NSMutableDictionary *specificItemDict = [self GenerateSpecificItemDictForItemAtIndexPath:indexPath];
    [specificItemDict setObject:object forKey:key];
    
    
    NSMutableDictionary *specificItemTypeDictOfSelectedTasks = itemSelectedDictLocal[currentItemTypeCollection] ? [itemSelectedDictLocal[currentItemTypeCollection] mutableCopy] : [NSMutableDictionary dictionary];
    
    NSString *itemSuggestedID = [self GenerateObjectAtIndexPathForKey:@"ItemSuggestedID" defaultKey:@"" indexPath:indexPath];
    
    if ([[specificItemTypeDictOfSelectedTasks allKeys] containsObject:itemSuggestedID]) {
        
        NSMutableDictionary *specificItemDictSelected = [specificItemTypeDictOfSelectedTasks[itemSuggestedID] mutableCopy];
        
        for (NSString *key in [specificItemDict allKeys]) {
            [specificItemDictSelected setObject:specificItemDict[key] forKey:key];
        }
        
        [specificItemTypeDictOfSelectedTasks setObject:specificItemDictSelected forKey:itemSuggestedID];
        
        [itemSelectedDictLocal setObject:specificItemTypeDictOfSelectedTasks forKey:currentItemTypeCollection];
        

        
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"UpdateItemDictLocal" userInfo:@{@"ItemSelectedDictLocal" : self->itemSelectedDictLocal} locations:@[@"MultiAddTasks"]];
        
    }
    
}

#pragma mark

-(NSMutableDictionary *)GenerateSpecificItemDictForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSIndexPath *indexPathForItemWithNameInItemDict = [self GenerateIndexPathForItemWithName:indexPath];
    
    NSMutableDictionary *specificItemDict = [NSMutableDictionary dictionary];
    
    if (indexPathForItemWithNameInItemDict.row != 1000) {
        
        NSMutableArray *specificItemTypeDictOfAllTasks = itemDictKeys && itemDictKeys[currentItemTypeCollection] ? itemDictKeys[currentItemTypeCollection] : [NSMutableArray array];
        
        NSMutableDictionary *itemDictCopy = itemDict ? [itemDict mutableCopy] : [NSMutableDictionary dictionary];
        NSMutableDictionary *specificItemTypeDict = itemDictCopy[currentItemTypeCollection] ? [itemDictCopy[currentItemTypeCollection] mutableCopy] : [NSMutableDictionary dictionary];
        NSString *specificItemTypeDictSpecificSection = specificItemTypeDictOfAllTasks && [specificItemTypeDictOfAllTasks count] > indexPathForItemWithNameInItemDict.section ? specificItemTypeDictOfAllTasks[indexPathForItemWithNameInItemDict.section] : @"";
        NSMutableArray *specificSectionArray = specificItemTypeDict[specificItemTypeDictSpecificSection] ? [specificItemTypeDict[specificItemTypeDictSpecificSection] mutableCopy] : [NSMutableArray array];
        
        specificItemDict = [specificSectionArray count] > indexPathForItemWithNameInItemDict.row ? [specificSectionArray[indexPathForItemWithNameInItemDict.row] mutableCopy] : [NSMutableDictionary dictionary];
        
    } else {
        
        NSMutableDictionary *itemSelectedDictCopy = itemSelectedDictLocal ? [itemSelectedDictLocal mutableCopy] : [NSMutableDictionary dictionary];
        NSMutableDictionary *specificItemTypeDict = itemSelectedDictCopy[currentItemTypeCollection] ? [itemSelectedDictCopy[currentItemTypeCollection] mutableCopy] : [NSMutableDictionary dictionary];
        NSString *specificItemName = [[specificItemTypeDict allKeys] count] > indexPath.row ? [specificItemTypeDict allKeys][indexPath.row] : @"";
        
        specificItemDict = specificItemTypeDict[specificItemName] ? [specificItemTypeDict[specificItemName] mutableCopy] : [NSMutableDictionary dictionary];
        
    }
    
    return specificItemDict;
}

#pragma mark

-(NSIndexPath *)GenerateIndexPathForItemWithName:(NSIndexPath *)indexPath {
    
    NSMutableArray *specificItemTypeDictOfAllTasks = itemDictKeys && itemDictKeys[currentItemTypeCollection] ? itemDictKeys[currentItemTypeCollection] : [NSMutableArray array];
    
    NSMutableDictionary *itemDictCopy = itemDict ? [itemDict mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *specificItemTypeDict = itemDictCopy[currentItemTypeCollection] ? [itemDictCopy[currentItemTypeCollection] mutableCopy] : [NSMutableDictionary dictionary];
    
    NSUInteger indexOfRow = 1000;
    NSUInteger indexOfSection = 1000;
    
    for (NSString *specificItemTypeDictSpecificSection in specificItemTypeDictOfAllTasks) {
        
        NSMutableArray *specificSectionArray = specificItemTypeDict[specificItemTypeDictSpecificSection] ? [specificItemTypeDict[specificItemTypeDictSpecificSection] mutableCopy] : [NSMutableArray array];
        
        for (NSMutableDictionary *specificItemDict in specificSectionArray) {
            
            NSDictionary *specificItemTypeDictOfSelectedTasks = [self GenerateObjectToUse:indexPath];
            
            if ([specificItemDict[@"ItemSuggestedID"] isEqualToString:specificItemTypeDictOfSelectedTasks[@"ItemSuggestedID"]]) {
                
                indexOfRow = [specificSectionArray indexOfObject:specificItemDict];
                
                break;
                
            }
            
        }
        
        if (indexOfRow != 1000) {
            
            indexOfSection = [specificItemTypeDictOfAllTasks indexOfObject:specificItemTypeDictSpecificSection];
            
            break;
            
        }
        
    }
    
    NSIndexPath *indexPathUpdated = [NSIndexPath indexPathForRow:indexOfRow inSection:indexOfSection];
    
    return indexPathUpdated;
}

-(NSIndexPath *)GenerateIndexPathForItemWithSuggestedID:(NSString *)itemSuggestedID {
    
    NSMutableArray *specificItemTypeDictOfAllTasks = itemDictKeys && itemDictKeys[currentItemTypeCollection] ? itemDictKeys[currentItemTypeCollection] : [NSMutableArray array];
    
    NSMutableDictionary *itemDictCopy = itemDict ? [itemDict mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *specificItemTypeDict = itemDictCopy[currentItemTypeCollection] ? [itemDictCopy[currentItemTypeCollection] mutableCopy] : [NSMutableDictionary dictionary];
    
    NSUInteger indexOfRow = 1000;
    NSUInteger indexOfSection = 1000;
    
    for (NSString *specificItemTypeDictSpecificSection in specificItemTypeDictOfAllTasks) {
        
        NSMutableArray *specificSectionArray = specificItemTypeDict[specificItemTypeDictSpecificSection] ? [specificItemTypeDict[specificItemTypeDictSpecificSection] mutableCopy] : [NSMutableArray array];
        
        for (NSMutableDictionary *specificItemDict in specificSectionArray) {
            
            if ([specificItemDict[@"ItemSuggestedID"] isEqualToString:itemSuggestedID]) {
                
                indexOfRow = [specificSectionArray indexOfObject:specificItemDict];
                
                break;
                
            }
            
        }
        
        if (indexOfRow != 1000) {
            
            indexOfSection = [specificItemTypeDictOfAllTasks indexOfObject:specificItemTypeDictSpecificSection];
            
            break;
            
        }
        
    }
    
    NSIndexPath *indexPathUpdated = [NSIndexPath indexPathForRow:indexOfRow inSection:indexOfSection];
    
    return indexPathUpdated;
}

-(id)GenerateObjectAtIndexPathForKey:(NSString *)key defaultKey:(id)defaultKey indexPath:(NSIndexPath *)indexPath {
    
    id object = [self GenerateObjectToUse:indexPath] != nil && [self GenerateObjectToUse:indexPath] != NULL && [self GenerateObjectToUse:indexPath][key] ? [self GenerateObjectToUse:indexPath][key] : defaultKey;
    
    BOOL ObjectIsKindOfNSStringClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:object classArr:@[[NSString class]]];
    
    if (ObjectIsKindOfNSStringClass == YES) {
        object = [[self GenerateObjectToUse:indexPath][key] length] > 0 ? object : defaultKey;
    }
    
    return object;
}

#pragma mark

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

#pragma mark

-(void)SetUpRepeatsContextMenu:(MultiAddTaskCell *)cell {
    
    NSIndexPath *indexPath = [selectedCellsArray count] > 0 ? selectedCellsArray[0] : nil;
    
    NSMutableArray* actions = [[NSMutableArray alloc] init];
    NSMutableArray* neverMenuActions = [[NSMutableArray alloc] init];
    NSMutableArray* oneTimeMenuActions = [[NSMutableArray alloc] init];
    NSMutableArray* asNeededMenuActions = [[NSMutableArray alloc] init];
    NSMutableArray* whenCompletedMenuActions = [[NSMutableArray alloc] init];
    NSMutableArray* repeatingMenuActions = [[NSMutableArray alloc] init];
    NSMutableArray* customMenuActions = [[NSMutableArray alloc] init];
    
    NSString *itemRepeats = [self GenerateObjectAtIndexPathForKey:@"ItemRepeats" defaultKey:@"Never" indexPath:indexPath];
    
    NSString *imageString = [itemRepeats isEqualToString:@"Never"] ? @"checkmark" : @"";
    
    [neverMenuActions addObject:[UIAction actionWithTitle:@"Never" image:[UIImage systemImageNamed:imageString] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Never Repeats Clicked For %@", self->currentItemType] completionHandler:^(BOOL finished) {
            
        }];
        
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemRepeats" userInfo:@{@"Repeats" : @"Never"} locations:@[@"MultiAddTasks"]];
        
        [self GenerateItemDictSearchingDictAndSelectedDictWithUpdatedData:indexPath key:@"ItemTakeTurns" object:@"No"];
        
    }]];
    
    imageString = [itemRepeats isEqualToString:@"One-Time"] ? @"checkmark" : @"";
    
    [oneTimeMenuActions addObject:[UIAction actionWithTitle:@"One-Time" image:[UIImage systemImageNamed:imageString] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"One-Time Clicked For %@", self->currentItemType] completionHandler:^(BOOL finished) {
            
        }];
        
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemRepeats" userInfo:@{@"Repeats" : @"One-Time"} locations:@[@"MultiAddTasks"]];
        
    }]];
    
    
    
    imageString = [itemRepeats isEqualToString:@"As Needed"] ? @"checkmark" : @"";
    
    
    
    NSMutableArray *selectActions = [NSMutableArray array];
    NSMutableArray *selectMenuActions = [NSMutableArray array];
    
    UIAction *selectAction = [UIAction actionWithTitle:@"Select" image:nil identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"As Needed For %@", self->currentItemType] completionHandler:^(BOOL finished) {
            
        }];
        
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemRepeats" userInfo:@{@"Repeats" : @"As Needed"} locations:@[@"MultiAddTasks"]];
        
    }];
    
    [selectActions addObject:selectAction];
    
    UIMenu *selectMenu = [UIMenu menuWithTitle:[NSString stringWithFormat:@"Create a %@ with no due due. Complete it as often as is needed.", [currentItemType lowercaseString]] image:nil identifier:@"Select" options:UIMenuOptionsDisplayInline children:selectActions];
    [selectMenuActions addObject:selectMenu];
    
    UIMenu *asNeededMenu = [UIMenu menuWithTitle:@"As Needed" image:[UIImage systemImageNamed:imageString] identifier:@"As Needed" options:0 children:selectMenuActions];
    [asNeededMenuActions addObject:asNeededMenu];
    
    
    
    //Post-Spike
    imageString = [itemRepeats isEqualToString:@"When Completed"] ? @"checkmark" : @"";
    
    selectActions = [NSMutableArray array];
    selectMenuActions = [NSMutableArray array];
    
    selectAction = [UIAction actionWithTitle:@"Select" image:nil identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"When Completed For %@", self->currentItemType] completionHandler:^(BOOL finished) {
            
        }];
        
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemRepeats" userInfo:@{@"Repeats" : @"When Completed"} locations:@[@"MultiAddTasks"]];
        
    }];
    
    [selectActions addObject:selectAction];
    
    
    
    
    selectMenu = [UIMenu menuWithTitle:[NSString stringWithFormat:@"Create a %@ with no due due. It repeats only when it is fully completed.", [self->currentItemType lowercaseString]] image:nil identifier:@"Select" options:UIMenuOptionsDisplayInline children:selectActions];
    [selectMenuActions addObject:selectMenu];
    
    UIMenu *whenCompletedMenu = [UIMenu menuWithTitle:@"When Completed" image:[UIImage systemImageNamed:imageString] identifier:@"When Completed" options:0 children:selectMenuActions];
    [whenCompletedMenuActions addObject:whenCompletedMenu];
    
    
    
    NSArray *repeatingArray = @[@"Hourly", @"Daily", @"Weekly", @"Bi-Weekly", @"Semi-Monthly", @"Monthly"];
    
    for (NSString *repeats in repeatingArray) {
        
        imageString = [itemRepeats isEqualToString:repeats] || [itemRepeats isEqualToString:[NSString stringWithFormat:@"%@ or When Completed", repeats]] ? @"checkmark" : @"";
        
        [repeatingMenuActions addObject:[UIAction actionWithTitle:repeats image:[UIImage systemImageNamed:imageString] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"%@ For %@", repeats, self->currentItemType] completionHandler:^(BOOL finished) {
                
            }];
            
            [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemRepeats" userInfo:@{@"Repeats" : repeats} locations:@[@"MultiAddTasks"]];
            
        }]];
        
    }
    
    NSString *repeatsWithoutOrWhenCompleted = itemRepeats;
    
    if ([repeatsWithoutOrWhenCompleted containsString:@" or When Completed"]) {
        repeatsWithoutOrWhenCompleted =
        [repeatsWithoutOrWhenCompleted componentsSeparatedByString:@" or When Completed"] && [[repeatsWithoutOrWhenCompleted componentsSeparatedByString:@" or When Completed"] count] > 0 ?
        [repeatsWithoutOrWhenCompleted componentsSeparatedByString:@" or When Completed"][0] : itemRepeats;
    }
    
    imageString = [repeatingArray containsObject:itemRepeats] == NO && [repeatingArray containsObject:repeatsWithoutOrWhenCompleted] == NO && [itemRepeats isEqualToString:@"Never"] == NO && [itemRepeats isEqualToString:@"As Needed"] == NO && [itemRepeats isEqualToString:@"When Completed"] == NO && [itemRepeats isEqualToString:@"When Completed"] == NO ? @"checkmark" : @"";
    
    [customMenuActions addObject:[UIAction actionWithTitle:@"More Options" image:[UIImage systemImageNamed:imageString] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Custom For %@", self->currentItemType] completionHandler:^(BOOL finished) {
            
        }];
        
        [self TapGestureMoreOptionsItemRepeats:indexPath];
        
    }]];
    
    UIMenu *neverInlineMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"1" options:UIMenuOptionsDisplayInline children:neverMenuActions];
    //UIMenu *oneTimeInlineMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"2" options:UIMenuOptionsDisplayInline children:oneTimeMenuActions];
    UIMenu *nasNeededInlineMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"3" options:UIMenuOptionsDisplayInline children:asNeededMenuActions];
    UIMenu *whenCompletedInlineMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"3" options:UIMenuOptionsDisplayInline children:whenCompletedMenuActions];
    UIMenu *repeatingInlineMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"4" options:UIMenuOptionsDisplayInline children:repeatingMenuActions];
    UIMenu *customInlineMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"5" options:UIMenuOptionsDisplayInline children:customMenuActions];
    
    [actions addObject:neverInlineMenu];
    //[actions addObject:oneTimeInlineMenu];
    [actions addObject:nasNeededInlineMenu];
    [actions addObject:whenCompletedInlineMenu];
    [actions addObject:repeatingInlineMenu];
    [actions addObject:customInlineMenu];
    
    cell.addTaskScrollViewRepeatsIconButton.menu = [UIMenu menuWithTitle:@"Repeats" children:actions];
    cell.addTaskScrollViewRepeatsIconButton.showsMenuAsPrimaryAction = true;
    
    cell.addTaskSelectedViewButtonRepeats.menu = [UIMenu menuWithTitle:@"Repeats" children:actions];
    cell.addTaskSelectedViewButtonRepeats.showsMenuAsPrimaryAction = true;
}

-(void)SetUpTakeTurnsContextMenu:(MultiAddTaskCell *)cell {
    
    NSIndexPath *indexPath = [selectedCellsArray count] > 0 ? selectedCellsArray[0] : nil;
    
    __block NSString *itemTakeTurns = [self GenerateObjectAtIndexPathForKey:@"ItemTakeTurns" defaultKey:@"No" indexPath:indexPath];
    
    NSMutableArray* actions = [[NSMutableArray alloc] init];
    
    NSArray *takeTurnsArray = @[@"Yes", @"No"];
    
    for (NSString *takeTurns in takeTurnsArray) {
        
        NSString *imageString = [itemTakeTurns isEqualToString:takeTurns] ? @"checkmark" : @"";
        
        [actions addObject:[UIAction actionWithTitle:takeTurns image:[UIImage systemImageNamed:imageString] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"%@ For %@", takeTurns, self->currentItemType] completionHandler:^(BOOL finished) {
                
            }];
            
            NSString *itemRepeats = [self GenerateObjectAtIndexPathForKey:@"ItemRepeats" defaultKey:@"Never" indexPath:indexPath];
            
            if ([takeTurns isEqualToString:@"Yes"] && [itemRepeats isEqualToString:@"Never"]) {
                
                [[[GeneralObject alloc] init] CreateAlert:@"Oops!" message:[NSString stringWithFormat:@"A %@ needs to be repeating for it to take turns", [self->currentItemType lowercaseString]] currentViewController:self];
                
            } else {
                
                itemTakeTurns = takeTurns;
                
                [self GenerateItemDictSearchingDictAndSelectedDictWithUpdatedData:indexPath key:@"ItemTakeTurns" object:itemTakeTurns];
                
            }
            
        }]];
        
    }
    
    cell.addTaskScrollViewTakeTurnsIconButton.menu = [UIMenu menuWithTitle:@"Take Turns" children:actions];
    cell.addTaskScrollViewTakeTurnsIconButton.showsMenuAsPrimaryAction = true;
    
    cell.addTaskSelectedViewButtonTakeTurns.menu = [UIMenu menuWithTitle:@"Take Turns" children:actions];
    cell.addTaskSelectedViewButtonTakeTurns.showsMenuAsPrimaryAction = true;
}

-(void)SetUpPriorityContextMenu:(MultiAddTaskCell *)cell {
    
    NSIndexPath *indexPath = [selectedCellsArray count] > 0 ? selectedCellsArray[0] : nil;
    
    __block NSString *itemPriority = [self GenerateObjectAtIndexPathForKey:@"ItemPriority" defaultKey:@"None" indexPath:indexPath];
    
    NSMutableArray* actions = [[NSMutableArray alloc] init];
    NSMutableArray* neverMenuActions = [[NSMutableArray alloc] init];
    NSMutableArray* priorityMenuActions = [[NSMutableArray alloc] init];
    
    NSString *imageString = [itemPriority isEqualToString:@"No Priority"] ? @"checkmark" : @"";
    
    [neverMenuActions addObject:[UIAction actionWithTitle:@"No Priority" image:[UIImage systemImageNamed:imageString] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"No Priority Clicked For %@", self->currentItemType] completionHandler:^(BOOL finished) {
            
        }];
        
        itemPriority = @"No Priority";
        
        [self GenerateItemDictSearchingDictAndSelectedDictWithUpdatedData:indexPath key:@"ItemPriority" object:itemPriority];
        
    }]];
    
    NSArray *priorityArray = @[@"Low", @"Medium", @"High"];
    
    for (NSString *priorityLevel in priorityArray) {
        
        imageString = [itemPriority isEqualToString:priorityLevel] ? @"checkmark" : @"";
        
        [priorityMenuActions addObject:[UIAction actionWithTitle:priorityLevel image:[UIImage systemImageNamed:imageString] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"%@ Priority Clicked For %@", priorityLevel, self->currentItemType] completionHandler:^(BOOL finished) {
                
            }];
            
            itemPriority = priorityLevel;
            
            [self GenerateItemDictSearchingDictAndSelectedDictWithUpdatedData:indexPath key:@"ItemPriority" object:itemPriority];
            
        }]];
        
    }
    
    UIMenu *neverInlineMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"1" options:UIMenuOptionsDisplayInline children:neverMenuActions];
    UIMenu *priorityInlineMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"4" options:UIMenuOptionsDisplayInline children:priorityMenuActions];
    
    [actions addObject:neverInlineMenu];
    [actions addObject:priorityInlineMenu];
    
    cell.addTaskScrollViewPriorityIconButton.menu = [UIMenu menuWithTitle:@"Priority" children:actions];
    cell.addTaskScrollViewPriorityIconButton.showsMenuAsPrimaryAction = true;
    
    cell.addTaskSelectedViewButtonPriority.menu = [UIMenu menuWithTitle:@"Priority" children:actions];
    cell.addTaskSelectedViewButtonPriority.showsMenuAsPrimaryAction = true;
    
}

-(void)SetUpTaskListContextMenu:(MultiAddTaskCell *)cell {
    
    NSIndexPath *indexPath = [selectedCellsArray count] > 0 ? selectedCellsArray[0] : nil;
   
    __block NSString *itemTaskList = [self GenerateObjectAtIndexPathForKey:@"ItemTaskList" defaultKey:@"No List" indexPath:indexPath];
    
    NSMutableArray *actions = [NSMutableArray array];
    
    
    
    NSMutableArray *taskListActions = [NSMutableArray array];
    
    for (NSString *taskListName in _taskListDict[@"TaskListName"]) {
        
        UIAction *taskListAction = [self TaskListItemContextMenuTaskListAction:taskListName itemTaskList:itemTaskList indexPath:indexPath cell:cell];
        
        [taskListActions addObject:taskListAction];
        
    }
    
    UIMenu *staskListActionsMenu = [self TaskListItemContextMenuSTaskListActionsMenu:taskListActions];
    
    [actions addObject:staskListActionsMenu];
    
    
    
    NSMutableArray *suggestedTaskListActions = [NSMutableArray array];
    
    NSArray *arrayToUse = [[[GeneralObject alloc] init] GenerateSuggestedTaskListArray:currentItemType];
    
    for (NSString *taskListName in arrayToUse) {
        
        UIAction *taskListAction = [self TaskListItemContextMenuSuggestedTaskListAction:taskListName itemTaskList:itemTaskList indexPath:indexPath cell:cell];
        
        [suggestedTaskListActions addObject:taskListAction];
        
    }
    
    UIMenu *suggestedTaskListActionsMenu = [self TaskListItemContextMenuSuggestedTaskListActionsMenu:suggestedTaskListActions arrayToUse:arrayToUse itemTaskList:itemTaskList];
    
    [actions addObject:suggestedTaskListActionsMenu];
    
    
    
    
    NSMutableArray *newTaskListMenuActions = [NSMutableArray array];
    
    UIAction *newTaskListAction = [self TaskListItemContextMenuNewTaskListAction:indexPath];
    [newTaskListMenuActions addObject:newTaskListAction];
    
    UIMenu *newTaskListActionsMenu = [self TaskListItemContextMenuNewTaskListActionsMenu:newTaskListMenuActions];
    
    [actions addObject:newTaskListActionsMenu];
    
    
    
    
    NSMutableArray *deleteListMenuActions = [NSMutableArray array];
    
    UIAction *noTaskListAction = [self TaskListItemContextMenuNoTaskListAction:indexPath cell:cell];
    [deleteListMenuActions addObject:noTaskListAction];
    
    UIMenu *noTaskListActionsMenu = [self TaskListItemContextMenuNoTaskListActionsMenu:deleteListMenuActions];
    
    [actions addObject:noTaskListActionsMenu];
    
    
    
    
    NSString *menuTitle = @"";
    
    if (actions.count - 2 == 0) {
        menuTitle = [NSString stringWithFormat:@"Create a list to organize your %@s", [currentItemType lowercaseString]];
    }
    
    cell.addTaskScrollViewTaskListIconButton.menu = [UIMenu menuWithTitle:@"Task List" children:actions];
    cell.addTaskScrollViewTaskListIconButton.showsMenuAsPrimaryAction = true;
    
    cell.addTaskSelectedViewButtonTaskList.menu = [UIMenu menuWithTitle:@"Task List" children:actions];
    cell.addTaskSelectedViewButtonTaskList.showsMenuAsPrimaryAction = true;
}

#pragma mark - Task List Context Menus

-(UIAction *)TaskListItemContextMenuTaskListAction:(NSString *)taskListName itemTaskList:(NSString *)itemTaskList indexPath:(NSIndexPath *)indexPath cell:(MultiAddTaskCell *)cell {
    
    NSString *imageString = [itemTaskList isEqualToString:taskListName] && [_taskListDict[@"TaskListName"] containsObject:itemTaskList] == NO ? @"checkmark" : @"list.bullet.rectangle.portrait";
    
    UIAction *taskListAction = [UIAction actionWithTitle:taskListName image:[UIImage systemImageNamed:imageString] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Specific List Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
            
        }];
        
        [self GenerateItemDictSearchingDictAndSelectedDictWithUpdatedData:indexPath key:@"ItemTaskList" object:taskListName];
        
        [self SetUpTaskListContextMenu:cell];
        
    }];
    
    return taskListAction;
}

-(UIAction *)TaskListItemContextMenuSuggestedTaskListAction:(NSString *)taskListName itemTaskList:(NSString *)itemTaskList indexPath:(NSIndexPath *)indexPath cell:(MultiAddTaskCell *)cell {
    
    NSString *imageString = [itemTaskList isEqualToString:taskListName] ? @"checkmark" : @"list.bullet.rectangle.portrait";
    
    UIAction *taskListAction = [UIAction actionWithTitle:taskListName image:[UIImage systemImageNamed:imageString] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Specific List Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
            
        }];
        
        [self GenerateItemDictSearchingDictAndSelectedDictWithUpdatedData:indexPath key:@"ItemTaskList" object:taskListName];
        
        [self SetUpTaskListContextMenu:cell];
        
    }];
    
    return taskListAction;
}

-(UIMenu *)TaskListItemContextMenuSTaskListActionsMenu:(NSMutableArray *)taskListActions {
    
    UIMenu *taskListMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"" options:UIMenuOptionsDisplayInline children:taskListActions];
    
    return taskListMenu;
}

-(UIMenu *)TaskListItemContextMenuSuggestedTaskListActionsMenu:(NSMutableArray *)suggestedTaskListActions arrayToUse:(NSArray *)arrayToUse itemTaskList:(NSString *)itemTaskList {
    
    NSString *imageString = [arrayToUse containsObject:itemTaskList] && [_taskListDict[@"TaskListName"] containsObject:itemTaskList] == NO ? @"checkmark" : @"list.bullet.rectangle.portrait";
    
    UIMenu *suggestedTaskListMenu = [UIMenu menuWithTitle:@"Suggested Lists" image:[UIImage systemImageNamed:imageString] identifier:@"" options:0 children:suggestedTaskListActions];
    
    return suggestedTaskListMenu;
}

-(UIMenu *)TaskListItemContextMenuNewTaskListActionsMenu:(NSMutableArray *)newTaskListActions {
    
    UIMenu *newTaskListMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"" options:UIMenuOptionsDisplayInline children:newTaskListActions];
    
    return newTaskListMenu;
}

-(UIMenu *)TaskListItemContextMenuNoTaskListActionsMenu:(NSMutableArray *)noTaskListActions {
    
    UIMenu *noTaskListMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"" options:UIMenuOptionsDisplayInline children:noTaskListActions];
    
    return noTaskListMenu;
}

-(void)SetUpAddedTaskContextMenu:(MultiAddTaskCell *)cell {
    
    NSIndexPath *indexPath = [selectedCellsArray count] > 0 ? selectedCellsArray[0] : nil;
    
    BOOL TaskHasBeenSelected = [self TaskHasBeenSelected:indexPath];
    
    NSMutableArray* actions = [[NSMutableArray alloc] init];
    
    
    
    UIAction *editAction = [self AddedTaskContextMenuEditAction:indexPath];
    [actions addObject:editAction];
    
    UIAction *duplicateAction = [self AddedTaskContextMenuDuplicateAction:indexPath];
    [actions addObject:duplicateAction];
    
    
    
    NSMutableArray *removeAction = [NSMutableArray array];
    
    UIAction *deleteAction = [self AddedTaskContextMenuRemoveAction:indexPath];
    [removeAction addObject:deleteAction];
    
    UIMenu *removeActionMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"" options:UIMenuOptionsDisplayInline children:removeAction];
    [actions addObject:removeActionMenu];
    
    
    
    cell.mainViewOverlayView.menu = [UIMenu menuWithTitle:@"" children:actions];
    cell.mainViewOverlayView.showsMenuAsPrimaryAction = TaskHasBeenSelected ? true : false;
    
}

#pragma mark - IBAction Methods

-(IBAction)MultiAddItems:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Multi-Add Clicked For %@", currentItemTypeCollection] completionHandler:^(BOOL finished) {
        
    }];
    
    for (NSString *itemType in [itemSelectedDictLocal allKeys]) {
        
        self->totalTasksAdded += [[itemSelectedDictLocal[itemType] allKeys] count];
        
    }
    
    self->totalQueries = 6;
    self->completedQueries = 0;
    
    if ([[itemSelectedDictLocal allKeys] count] == 0) {
        
        [self DismissViewController:self];
        
    } else {
        
        [self StartProgressView];
        
        NSTimeInterval delayInSeconds = 0.1;
        
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            
            NSMutableDictionary *setTaskListData_NewTaskListDict = [NSMutableDictionary dictionary];
            NSMutableDictionary *updateTaskListData_OldTaskListDict = [NSMutableDictionary dictionary];
            
            NSMutableDictionary *allSetDataDict = [NSMutableDictionary dictionary];
            
            NSMutableArray *arrayToUse = [[self->itemSelectedDictLocal[self->currentItemTypeCollection] allKeys] mutableCopy];
            
            
            
            for (NSString *itemSuggestedID in arrayToUse) {
                
                __block NSDictionary *setDataDict =  [self->itemSelectedDictLocal[self->currentItemTypeCollection][itemSuggestedID] mutableCopy];
                [allSetDataDict setObject:setDataDict forKey:setDataDict[@"ItemUniqueID"]];
                
                NSDictionary *dict = [self MultiAddItems_SetLocalTaskListData:setDataDict setTaskListData_NewTaskListDict:setTaskListData_NewTaskListDict updateTaskListData_OldTaskListDict:updateTaskListData_OldTaskListDict];
                setTaskListData_NewTaskListDict = dict[@"setTaskListData_NewTaskListDict"] ? [dict[@"setTaskListData_NewTaskListDict"] mutableCopy] : [NSMutableDictionary dictionary];
                updateTaskListData_OldTaskListDict = dict[@"updateTaskListData_OldTaskListDict"] ? [dict[@"updateTaskListData_OldTaskListDict"] mutableCopy] : [NSMutableDictionary dictionary];
                
             }
            
            
            
            for (NSString *itemSuggestedID in arrayToUse) {
             
                __block NSDictionary *setDataDict =  [self->itemSelectedDictLocal[self->currentItemTypeCollection][itemSuggestedID] mutableCopy];
                
                [self MultiAddItems_GenerateGeneralData:[setDataDict mutableCopy] itemType:self->currentItemType];
            
                
                
                /*
                 //
                 //
                 //Push Notifications
                 //
                 //
                 */
                [self MultiAddItems_PushNotificationOrScheduledStartNotifications:setDataDict completionHandler:^(BOOL finished) {
                  
                    [self MultiAddItems_CompletionBlock:self->totalQueries completedQueries:(self->completedQueries+=1) setTaskListData_NewTaskListDict:setTaskListData_NewTaskListDict updateTaskListData_OldTaskListDict:updateTaskListData_OldTaskListDict allSetDataDict:allSetDataDict];
                    
                }];
                
                
                /*
                 //
                 //
                 //Item Silent Notification
                 //
                 //
                 */
                [self MultiAddItems_ResetItemNotifications:setDataDict completionHandler:^(BOOL finished) {
                
                    [self MultiAddItems_CompletionBlock:self->totalQueries completedQueries:(self->completedQueries+=1) setTaskListData_NewTaskListDict:setTaskListData_NewTaskListDict updateTaskListData_OldTaskListDict:updateTaskListData_OldTaskListDict allSetDataDict:allSetDataDict];
                    
                }];
                
                
                /*
                 //
                 //
                 //Set Topic Data
                 //
                 //
                 */
                [self MultiAddItems_SetTopicData:setDataDict completionHandler:^(BOOL finished) {
                 
                    [self MultiAddItems_CompletionBlock:self->totalQueries completedQueries:(self->completedQueries+=1) setTaskListData_NewTaskListDict:setTaskListData_NewTaskListDict updateTaskListData_OldTaskListDict:updateTaskListData_OldTaskListDict allSetDataDict:allSetDataDict];
                    
                }];
                
                
                /*
                 //
                 //
                 //Set Item Data
                 //
                 //
                 */
                [self MultiAddItems_SetItemData:setDataDict completionHandler:^(BOOL finished) {
                
                    [self MultiAddItems_CompletionBlock:self->totalQueries completedQueries:(self->completedQueries+=1) setTaskListData_NewTaskListDict:setTaskListData_NewTaskListDict updateTaskListData_OldTaskListDict:updateTaskListData_OldTaskListDict allSetDataDict:allSetDataDict];
                    
                }];
                
                
                /*
                 //
                 //
                 //Set Image Data
                 //
                 //
                 */
                [self MultiAddItems_SetImageData:setDataDict completionHandler:^(BOOL finished) {
                 
                    [self MultiAddItems_CompletionBlock:self->totalQueries completedQueries:(self->completedQueries+=1) setTaskListData_NewTaskListDict:setTaskListData_NewTaskListDict updateTaskListData_OldTaskListDict:updateTaskListData_OldTaskListDict allSetDataDict:allSetDataDict];
                    
                }];
                
                
                /*
                 //
                 //
                 //Set Item And Home Activity
                 //
                 //
                 */
                [self MultiAddItems_SetItemAndHomeActivity:setDataDict completionHandler:^(BOOL finished) {
                 
                    [self MultiAddItems_CompletionBlock:self->totalQueries completedQueries:(self->completedQueries+=1) setTaskListData_NewTaskListDict:setTaskListData_NewTaskListDict updateTaskListData_OldTaskListDict:updateTaskListData_OldTaskListDict allSetDataDict:allSetDataDict];
                    
                }];
                
            }
            
        });
        
    }
    
}

-(IBAction)ClearSearchBar:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Search Bar Cleared For %@", currentItemTypeCollection] completionHandler:^(BOOL finished) {
        
    }];
    
    Searching = NO;
    
    self->selectedCellsArray = [NSMutableArray array];
    
    _searchBar.text = @"";
    
    self.customTableView.layer.zPosition = 0;
    
    [searchResults removeAllObjects];
    
    [self.customTableView reloadData];
    
    _clearSearchBarView.hidden = YES;
    
    [self AdjustTableViewHeight];
    
}

-(IBAction)QuickAddAction:(id)sender {
    
    UIImpactFeedbackGenerator *myGen = [[UIImpactFeedbackGenerator alloc] initWithStyle:(UIImpactFeedbackStyleMedium)];
    [myGen impactOccurred];
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:_customTableView];
    NSIndexPath *indexPath = [_customTableView indexPathForRowAtPoint:buttonPosition];
    
    NSString *itemUniqueID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    NSString *itemID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    NSString *itemOccurrenceID = @"";
    NSString *itemDatePosted = [[[GeneralObject alloc] init] GenerateCurrentDateString];
    
    NSString *itemName = [self GenerateObjectAtIndexPathForKey:@"ItemName" defaultKey:@"" indexPath:indexPath];
    NSString *itemAmount = [self GenerateObjectAtIndexPathForKey:@"ItemAmount" defaultKey:[NSString stringWithFormat:@"%@0%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol] indexPath:indexPath];
    NSMutableDictionary *itemListItems = [self GenerateObjectAtIndexPathForKey:@"ItemListItems" defaultKey:[NSMutableDictionary dictionary] indexPath:indexPath];
    NSMutableArray *itemAssignedTo = _homeMembersDict[@"UserID"] ? [_homeMembersDict[@"UserID"] mutableCopy] : [NSMutableArray array];
    
    NSString *itemAssignedToNewHomeMembers = @"Yes";//[self GenerateItemAssignedToNewHomeMembers:indexPath];
    NSString *itemAssignedToAnybody = @"No";//[self GenerateItemAssignedToAnybody:indexPath];
    NSString *itemDueDate = @"";
    NSString *itemRepeats = [self GenerateObjectAtIndexPathForKey:@"ItemRepeats" defaultKey:@"Never" indexPath:indexPath];
    NSString *itemRepeatIfCompletedEarly = [itemRepeats containsString:@"When Completed"] ? @"Yes" : @"No";
    NSString *itemCompleteAsNeeded = [itemRepeats containsString:@"As Needed"] ? @"Yes" : @"No";
    NSString *itemTakeTurns = [self GenerateObjectAtIndexPathForKey:@"ItemTakeTurns" defaultKey:@"No" indexPath:indexPath];
    NSString *itemDays = [self GenerateObjectAtIndexPathForKey:@"ItemDays" defaultKey:@"Any Day" indexPath:indexPath];
    NSString *itemTime = [self GenerateObjectAtIndexPathForKey:@"ItemTime" defaultKey:@"Any Time" indexPath:indexPath];
    
    NSMutableDictionary *itemRemindersDict = [[[[GeneralObject alloc] init] GenerateDefaultRemindersDict:currentItemType itemAssignedTo:[NSMutableArray array] itemRepeats:itemRepeats homeMembersDict:_homeMembersDict AnyTime:[itemTime isEqualToString:@"Any Time"]] mutableCopy];
    
    NSString *itemNotes = @"";
    
    NSString *itemPriority = [self GenerateObjectAtIndexPathForKey:@"ItemPriority" defaultKey:@"None" indexPath:indexPath];
    NSString *itemSuggestedID = [self GenerateObjectAtIndexPathForKey:@"ItemSuggestedID" defaultKey:@"" indexPath:indexPath];
    
    if ([itemName isEqualToString:@"Name"]) {
        itemName = @"";
    }
    if ([itemNotes isEqualToString:@"Notes"]) {
        itemNotes = @"";
    }
    
    NSString *itemTaskList = [self GenerateObjectAtIndexPathForKey:@"ItemTaskList" defaultKey:@"No List" indexPath:indexPath];
    
    NSDictionary *setDataDict = [self GenerateSetDataDict:itemName
                                          itemAmountLocal:itemAmount
                                       itemListItemsLocal:itemListItems
                                      itemAssignedToLocal:itemAssignedTo
                        itemAssignedToNewHomeMembersLocal:itemAssignedToNewHomeMembers
                               itemAssignedToAnybodyLocal:itemAssignedToAnybody
                                         itemDueDateLocal:itemDueDate
                                         itemRepeatsLocal:itemRepeats
                             itemRepeatIfCompletedEarlyLocal:itemRepeatIfCompletedEarly
                               itemCompleteAsNeededLocal:itemCompleteAsNeeded
                                       itemTakeTurnsLocal:itemTakeTurns
                                            itemDaysLocal:itemDays
                                   itemRemindersDictLocal:itemRemindersDict
                                           itemNotesLocal:itemNotes
                                        itemPriorityLocal:itemPriority
                                     itemSuggestedIDLocal:itemSuggestedID
                                        itemUniqueIDLocal:itemUniqueID
                                              itemIDLocal:itemID
                                    itemOccurrenceIDLocal:itemOccurrenceID
                                      itemDatePostedLocal:itemDatePosted
                                        itemTaskListLocal:itemTaskList];
    
    NSMutableDictionary *specificItemTypeDictOfSelectedTasks = itemSelectedDictLocal[currentItemTypeCollection] ? [itemSelectedDictLocal[currentItemTypeCollection] mutableCopy] : [NSMutableDictionary dictionary];
    
    if ([[specificItemTypeDictOfSelectedTasks allKeys] containsObject:itemSuggestedID]) {
        [specificItemTypeDictOfSelectedTasks removeObjectForKey:itemSuggestedID];
    } else {
        [specificItemTypeDictOfSelectedTasks setObject:setDataDict forKey:itemSuggestedID];
    }
    
    [itemSelectedDictLocal setObject:specificItemTypeDictOfSelectedTasks forKey:currentItemTypeCollection];
    
    [[[GeneralObject alloc] init] CallNSNotificationMethods:@"UpdateItemDictLocal" userInfo:@{@"ItemSelectedDictLocal" : self->itemSelectedDictLocal} locations:@[@"MultiAddTasks"]];
    
    [self UpdateAddTasksUI:NO];
    
}

-(IBAction)ViewAllAddedTasks:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"View Selected Tasks Clicked For %@", currentItemTypeCollection] completionHandler:^(BOOL finished) {
        
    }];
    
    BOOL FoundTask = NO;
    
    if (itemSelectedDictLocal) {
        
        for (NSString *itemType in [itemSelectedDictLocal allKeys]) {
            
            if (itemSelectedDictLocal && itemSelectedDictLocal[itemType]) {
                
                for (int i=0 ; i<[[itemSelectedDictLocal[itemType] allKeys] count] ; i++) {
                    
                    FoundTask = YES;
                    
                }
                
            }
            
        }
        
    }
    
    if (FoundTask) {
        
        [[[PushObject alloc] init] PushToMultiAddTasksViewController:YES itemDictFromPreviousPage:[itemDict mutableCopy] itemDictKeysFromPreviousPage:[itemDictKeys mutableCopy] itemSelectedDict:[itemSelectedDictLocal mutableCopy] homeMembersDict:_homeMembersDict notificationSettingsDict:_notificationSettingsDict topicDict:_topicDict folderDict:_folderDict taskListDict:_taskListDict templateDict:_templateDict draftDict:_draftDict homeMembersArray:_homeMembersArray itemNamesAlreadyUsed:_itemNamesAlreadyUsed allItemAssignedToArrays:_allItemAssignedToArrays allItemTagsArrays:_allItemTagsArrays defaultTaskListName:_defaultTaskListName currentViewController:self Superficial:NO];
        
    } else {
        
        [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You must add at least one task first" currentViewController:self];
        
    }
    
}

-(IBAction)DismissViewController:(id)sender {
    
    [self NSNotificationObservers:YES];
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"ComingFromShortcut"] isEqualToString:@"Yes"]) {
        [self.navigationController popViewControllerAnimated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

-(IBAction)NavigationBackButtonAction:(UIBarButtonItem *)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Navigation Back Button Clicked For %@", currentItemTypeCollection] completionHandler:^(BOOL finished) {
        
    }];
    
    if (itemSelectedDictLocal && itemSelectedDictLocal[currentItemTypeCollection] && [itemSelectedDictLocal[currentItemTypeCollection] allKeys] > 0 && !_viewingAddedTasks) {
        
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Are you sure you would like to clear all of your %@?", [currentItemTypeCollection lowercaseString]] message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"Clear All" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Clear All %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
                
            }];
            
            [self DismissViewController:self];
            
        }];
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"RemoveItem Cancelled For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
                
            }];
            
        }]];
        
        [deleteAction setValue:[UIColor systemRedColor] forKey:@"titleTextColor"];
        
        [actionSheet addAction:deleteAction];
        
        [self presentViewController:actionSheet animated:YES completion:nil];
        
    } else {
        
        [self DismissViewController:self];
        
    }
    
}

#pragma mark - Tap Gesture IBAction Methods

-(IBAction)TapGestureAddTaskViewAmountView:(id)sender {
    
    UITapGestureRecognizer *tapRecognizer = (UITapGestureRecognizer *)sender;
    CGPoint tapLocation = [tapRecognizer locationInView:_customTableView];
    NSIndexPath *indexPath = [_customTableView indexPathForRowAtPoint:tapLocation];
    
    __block NSString *itemAmount = [self GenerateObjectAtIndexPathForKey:@"ItemAmount" defaultKey:[NSString stringWithFormat:@"%@0%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol] indexPath:indexPath];
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Enter an amount" message:nil
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Add"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * _Nonnull action) {
        
        NSString *userEmail = [controller.textFields[0].text lowercaseString];
        
        itemAmount = userEmail;
        
        [self GenerateItemDictSearchingDictAndSelectedDictWithUpdatedData:indexPath key:@"ItemAmount" object:itemAmount];
        
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction * _Nonnull action) {}];
    
    
    
    [controller addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        
        NSString *localCurrencySymbol = [[[GeneralObject alloc] init] GenerateLocalCurrencySymbol];
        
        textField.delegate = self;
        textField.placeholder = @"Amount";
        textField.text = [NSString stringWithFormat:@"%@0%@00", localCurrencySymbol, self->localCurrencyDecimalSeparatorSymbol];
        textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
        textField.tag = 999;
        textField.keyboardType = UIKeyboardTypeNumberPad;
        
    }];
    
    [controller addAction:action1];
    [controller addAction:cancel];
    [self presentViewController:controller animated:YES completion:nil];
    
}

-(IBAction)TapGestureAddTaskViewListItemsView:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"List Items Field Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    NSMutableDictionary *currentlyAssignedUserDict = [NSMutableDictionary dictionary];
    [currentlyAssignedUserDict setObject:[NSMutableArray array] forKey:@"UserID"];
    [currentlyAssignedUserDict setObject:[NSMutableArray array] forKey:@"Username"];
    [currentlyAssignedUserDict setObject:[NSMutableArray array] forKey:@"ProfileImageURL"];
    
    NSMutableArray *userIDArray = [_homeMembersDict[@"UserID"] mutableCopy];;
    
    for (NSString *userID in userIDArray) {
        
        NSDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:userID homeMembersDict:_homeMembersDict];
        [currentlyAssignedUserDict[@"UserID"] addObject:dataDict[@"UserID"]];
        [currentlyAssignedUserDict[@"Username"] addObject:dataDict[@"Username"]];
        [currentlyAssignedUserDict[@"ProfileImageURL"] addObject:dataDict[@"ProfileImageURL"]];
        
    }
    
    UITapGestureRecognizer *tapRecognizer = (UITapGestureRecognizer *)sender;
    CGPoint tapLocation = [tapRecognizer locationInView:_customTableView];
    NSIndexPath *indexPath = [_customTableView indexPathForRowAtPoint:tapLocation];
    
    NSMutableDictionary *itemListItems = [self GenerateObjectAtIndexPathForKey:@"ItemListItems" defaultKey:[NSMutableDictionary dictionary] indexPath:indexPath];
    NSString *itemRepeats = [self GenerateObjectAtIndexPathForKey:@"ItemRepeats" defaultKey:@"Never" indexPath:indexPath];
    
    [[[PushObject alloc] init] PushToViewAddItemsViewController:nil itemsAlreadyChosenDict:itemListItems userDict:currentlyAssignedUserDict optionSelectedString:@"ListItems" itemRepeats:itemRepeats viewingItemDetails:NO currentViewController:self];
    
}

//-(IBAction)TapGestureAddTaskViewAssignedToView:(id)sender {
//
//    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Assigned To Field Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
//
//    }];
//
//    NSIndexPath *indexPath = chosenIndexPath;
//
//    NSString *itemAssignedTo = [self GenerateObjectAtIndexPathForKey:@"ItemAssignedTo" defaultKey:@"Nobody" indexPath:indexPath];
//    NSString *itemAssignedToNewHomeMembers = [self GenerateObjectAtIndexPathForKey:@"ItemAssignedToNewHomeMembers" defaultKey:@"Yes" indexPath:indexPath];
//
//    NSMutableArray *selectedArray = [NSMutableArray array];
//
//    BOOL ObjectIsKindOfNSStringClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:itemAssignedTo classArr:@[[NSString class]]];
//
//    if (ObjectIsKindOfNSStringClass == YES) {
//
//        if ([itemAssignedTo isEqualToString:@"Myself"]) {
//            [selectedArray addObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"]];
//        } else if ([itemAssignedTo isEqualToString:@"Everybody"]) {
//            selectedArray = [_homeMembersDict[@"Username"] mutableCopy];
//        } else if ([itemAssignedTo isEqualToString:@"Nobody"] == NO) {
//            selectedArray = [[itemAssignedTo componentsSeparatedByString:@", "] mutableCopy];
//        }
//
//    }
//
//    if ([selectedArray containsObject:@""]) {
//        [selectedArray removeObject:@""];
//    }
//
//    NSString *itemAssignedToAnybody = [itemAssignedTo isEqualToString:@"Anybody"] ? @"Yes" : @"No";
//    NSString *itemAssignedToNewHomeMembersNo1 = [itemAssignedTo isEqualToString:@"Everybody"] || [itemAssignedToNewHomeMembers isEqualToString:@"Yes"] ? @"Yes" : @"No";
//
//    NSMutableDictionary *homeMembersUnclaimedDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeMembersUnclaimedDict"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeMembersUnclaimedDict"] : [NSMutableDictionary dictionary];
//    NSMutableDictionary *homeKeysDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeKeysDict"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeKeysDict"] : [NSMutableDictionary dictionary];
//    NSMutableArray *homeKeysArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeKeysArray"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeKeysArray"] : [NSMutableArray array];
//
//    [[[PushObject alloc] init] PushToViewAssignedViewController:selectedArray itemAssignedToNewHomeMembers:itemAssignedToNewHomeMembersNo1 itemAssignedToAnybody:itemAssignedToAnybody itemUniqueID:@"" homeMembersArray:self->_homeMembersArray homeMembersDict:self->_homeMembersDict homeMembersUnclaimedDict:homeMembersUnclaimedDict homeKeysDict:homeKeysDict homeKeysArray:homeKeysArray folderDict:self->_folderDict taskListDict:self->_taskListDict sectionDict:self->_sectionDict templateDict:self->_templateDict notificationSettingsDict:self->_notificationSettingsDict viewingItemDetails:NO viewingExpense:[currentItemType isEqualToString:@"Expense"] viewingChatMembers:NO viewingWeDivvyPremiumAddingAccounts:NO viewingWeDivvyPremiumEditingAccounts:NO currentViewController:self];
//
//}

-(IBAction)TapGestureMoreOptionsItemRepeats:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Repeats Field Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    NSIndexPath *indexPath = (NSIndexPath *)sender;
    
    NSString *itemRepeats = [self GenerateObjectAtIndexPathForKey:@"ItemRepeats" defaultKey:@"Never" indexPath:indexPath];
    
    NSMutableArray *itemsSelectedArray = [NSMutableArray array];
    
    if (itemRepeats.length > 0) {
        
        itemsSelectedArray = [[itemRepeats componentsSeparatedByString:@""] mutableCopy];
        
    }
    
    [[[PushObject alloc] init] PushToViewOptionsViewController:itemsSelectedArray customOptionsArray:nil specificDatesArray:nil viewingItemDetails:NO optionSelectedString:@"Repeats" itemRepeatsFrequency:nil homeMembersDict:nil currentViewController:self];
    
}

-(IBAction)TapGestureAddTaskViewXMark:(id)sender {
    
    UITapGestureRecognizer *tapRecognizer = (UITapGestureRecognizer *)sender;
    UIView *the_view = tapRecognizer.view;
    
    CGPoint tapLocation = [tapRecognizer locationInView:_customTableView];
    NSIndexPath *indexPath = [_customTableView indexPathForRowAtPoint:tapLocation];
    
    NSString *itemTaskList = @"No List";//[self GenerateObjectAtIndexPathForKey:@"ItemAssignedTo" defaultKey:@"Nobody" indexPath:indexPath];
    NSString *itemRepeats = [self GenerateObjectAtIndexPathForKey:@"ItemRepeats" defaultKey:@"Never" indexPath:indexPath];
    NSString *itemTakeTurns = [self GenerateObjectAtIndexPathForKey:@"ItemTakeTurns" defaultKey:@"No" indexPath:indexPath];
    NSString *itemPriority = [self GenerateObjectAtIndexPathForKey:@"ItemPriority" defaultKey:@"None" indexPath:indexPath];
    NSString *itemAmount = [self GenerateObjectAtIndexPathForKey:@"ItemAmount" defaultKey:[NSString stringWithFormat:@"%@0%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol] indexPath:indexPath];
    NSMutableDictionary *itemListItems = [self GenerateObjectAtIndexPathForKey:@"ItemListItems" defaultKey:[NSMutableDictionary dictionary] indexPath:indexPath];
    
    if (the_view.tag == [[NSString stringWithFormat:@"5%lu", indexPath.row] intValue]) {
        
        itemTaskList = @"No List";
        
        [self GenerateItemDictSearchingDictAndSelectedDictWithUpdatedData:indexPath key:@"ItemTaskList" object:itemTaskList];
        
    } else if (the_view.tag == [[NSString stringWithFormat:@"0%lu", indexPath.row] intValue]) {
        
        itemRepeats = @"Never";
        
        [self GenerateItemDictSearchingDictAndSelectedDictWithUpdatedData:indexPath key:@"ItemRepeats" object:itemRepeats];
        
    } else if (the_view.tag == [[NSString stringWithFormat:@"2%lu", indexPath.row] intValue]) {
        
        itemTakeTurns = @"No";
        
        [self GenerateItemDictSearchingDictAndSelectedDictWithUpdatedData:indexPath key:@"ItemTakeTurns" object:itemTakeTurns];
        
    } else if (the_view.tag == [[NSString stringWithFormat:@"1%lu", indexPath.row] intValue]) {
        
        itemPriority = @"No Priority";
        
        [self GenerateItemDictSearchingDictAndSelectedDictWithUpdatedData:indexPath key:@"ItemPriority" object:itemPriority];
        
    } else if (the_view.tag == [[NSString stringWithFormat:@"3%lu", indexPath.row] intValue]) {
        
        itemAmount = [NSString stringWithFormat:@"%@0%@00", [[[GeneralObject alloc] init] GenerateLocalCurrencySymbol], localCurrencyDecimalSeparatorSymbol];
        
        [self GenerateItemDictSearchingDictAndSelectedDictWithUpdatedData:indexPath key:@"ItemAmount" object:itemAmount];
        
    } else if (the_view.tag == [[NSString stringWithFormat:@"4%lu", indexPath.row] intValue]) {
        
        itemListItems = [NSMutableDictionary dictionary];
        
        [self GenerateItemDictSearchingDictAndSelectedDictWithUpdatedData:indexPath key:@"ItemListItems" object:itemListItems];
        
    }
    
}

-(IBAction)TapGestureExpandTaskAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Edit Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    NSIndexPath *indexPath = chosenIndexPath;
    
    NSString *taskName = [self GenerateObjectAtIndexPathForKey:@"ItemName" defaultKey:@"" indexPath:indexPath];
    NSString *itemTaskList = [self GenerateObjectAtIndexPathForKey:@"ItemTaskList" defaultKey:@"No List" indexPath:indexPath];
    NSString *itemSuggestedID = [self GenerateObjectAtIndexPathForKey:@"ItemSuggestedID" defaultKey:@"" indexPath:indexPath];
    NSString *itemRepeats = [self GenerateObjectAtIndexPathForKey:@"ItemRepeats" defaultKey:@"Never" indexPath:indexPath];
    NSString *itemTakeTurns = [self GenerateObjectAtIndexPathForKey:@"ItemTakeTurns" defaultKey:@"No" indexPath:indexPath];
    NSString *itemPriority = [self GenerateObjectAtIndexPathForKey:@"ItemPriority" defaultKey:@"No Priority" indexPath:indexPath];
    NSString *itemAmount = [self GenerateObjectAtIndexPathForKey:@"ItemAmount" defaultKey:[NSString stringWithFormat:@"%@0%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol] indexPath:indexPath];
    NSMutableDictionary *itemListItems = [self GenerateObjectAtIndexPathForKey:@"ItemListItems" defaultKey:[NSMutableDictionary dictionary] indexPath:indexPath];
    NSMutableArray *itemAssignedTo = [self GenerateObjectAtIndexPathForKey:@"ItemAssignedTo" defaultKey:[_homeMembersDict[@"UserID"] mutableCopy] indexPath:indexPath];
    NSString *itemAssignedToNewHomeMembers = [self GenerateObjectAtIndexPathForKey:@"ItemAssignedToNewHomeMembers" defaultKey:@"No" indexPath:indexPath];
    
    NSDictionary *specificItemTypeDictOfSelectedTasks = [self GenerateObjectToUse:indexPath];
    
    if (taskName == nil) {
        taskName = @"";
    }
    if (itemRepeats == nil) {
        itemRepeats = @"";
    }
    if (itemTakeTurns == nil) {
        itemTakeTurns = @"";
    }
    if (itemPriority == nil) {
        itemPriority = @"";
    }
    if (itemAmount == nil) {
        itemAmount = @"";
    }
    if (itemListItems == nil) {
        itemListItems = [NSMutableDictionary dictionary];
    }
    if (itemAssignedTo == nil) {
        itemAssignedTo = [NSMutableArray array];;
    }
    if (itemAssignedToNewHomeMembers == nil) {
        itemAssignedToNewHomeMembers = @"";
    }
    if (itemSuggestedID == nil) {
        itemSuggestedID = @"";
    }
    if (itemTaskList == nil) {
        itemTaskList = @"";
    }
    
    NSMutableDictionary *multiAddDict = specificItemTypeDictOfSelectedTasks && specificItemTypeDictOfSelectedTasks[@"ItemID"] ?
    [specificItemTypeDictOfSelectedTasks mutableCopy] : [@{@"ItemName" : taskName, @"ItemRepeats" : itemRepeats, @"ItemTakeTurns" : itemTakeTurns, @"ItemPriority" : itemPriority, @"ItemAmount" : itemAmount, @"ItemListItems" : itemListItems, @"ItemAssignedTo" : itemAssignedTo, @"ItemAssignedToNewHomeMembers" : itemAssignedToNewHomeMembers, @"ItemSuggestedID" : itemSuggestedID, @"ItemTaskList" : itemTaskList} mutableCopy];
    
    [multiAddDict setObject:itemAssignedTo forKey:@"ItemAssignedTo"];
    
    NSMutableArray *allItemAssignedToArrays = _allItemAssignedToArrays;
    
    NSString *sectionSelected = [[NSUserDefaults standardUserDefaults] objectForKey:@"CategorySelected"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"CategorySelected"] : @"All";
    BOOL ListSelected = [_taskListDict[@"TaskListName"] containsObject:sectionSelected];
    NSString *defaultTaskListName = ListSelected == YES ? sectionSelected : @"No List";
    
    AddingFromSearchBar = NO;
    
    [[[PushObject alloc] init] PushToAddTaskViewController:multiAddDict partiallyAddedDict:nil suggestedItemToAddDict:nil templateToEditDict:nil draftToEditDict:nil moreOptionsDict:nil multiAddDict:nil notificationSettingsDict:_notificationSettingsDict topicDict:_topicDict homeID:[[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] homeMembersArray:_homeMembersArray homeMembersDict:_homeMembersDict itemOccurrencesDict:[NSMutableDictionary dictionary] folderDict:_folderDict taskListDict:_taskListDict templateDict:_templateDict draftDict:_draftDict allItemAssignedToArrays:allItemAssignedToArrays allItemTagsArrays:_allItemTagsArrays allItemIDsArrays:[NSMutableArray array] defaultTaskListName:defaultTaskListName partiallyAddedTask:NO addingTask:NO addingMultipleTasks:YES addingSuggestedTask:NO editingTask:NO viewingTask:NO viewingMoreOptions:NO duplicatingTask:NO editingTemplate:NO viewingTemplate:NO editingDraft:NO viewingDraft:NO currentViewController:self Superficial:NO];
    
}

#pragma mark - NSNotification Methods

-(void)NSNotification_MultiAddTasks_RemoveNotificationObservers:(NSNotification *)notification {
    
    [self NSNotificationObservers:YES];
    
}

-(void)NSNotification_MultiAddTasks_UpdateItemDictLocal:(NSNotification *)notification {
    
    NSDictionary *userInfo = notification.userInfo;
    
    if (userInfo[@"ItemDictLocal"]) {
        itemDict = [userInfo[@"ItemDictLocal"] mutableCopy];
    }
    
    if (userInfo[@"ItemSelectedDictLocal"]) {
        itemSelectedDictLocal = [userInfo[@"ItemSelectedDictLocal"] mutableCopy];
    }
    
    [self.customTableView reloadData];
    
}

#pragma mark

-(void)NSNotification_MultiAddTasks_AddHomeMember:(NSNotification *)notification {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSDictionary *dict = [notification.userInfo mutableCopy];
        
        self->_homeMembersArray = dict[@"HomeMembersArray"] ? dict[@"HomeMembersArray"] : [NSMutableArray array];
        self->_homeMembersDict = dict[@"HomeMembersDict"] ? dict[@"HomeMembersDict"] : [NSMutableDictionary dictionary];
        self->_notificationSettingsDict = dict[@"NotificationSettingsDict"] ? dict[@"NotificationSettingsDict"] : [NSMutableDictionary dictionary];
        
        [[NSUserDefaults standardUserDefaults] setObject:self->_homeMembersArray forKey:@"HomeMembersArray"];
        [[NSUserDefaults standardUserDefaults] setObject:self->_homeMembersDict forKey:@"HomeMembersDict"];
        [[NSUserDefaults standardUserDefaults] setObject:dict[@"HomeKeysDict"] ? dict[@"HomeKeysDict"] : [NSMutableDictionary dictionary] forKey:@"HomeKeysDict"];
        [[NSUserDefaults standardUserDefaults] setObject:dict[@"HomeKeysArray"] ? dict[@"HomeKeysArray"] : [NSMutableArray array] forKey:@"HomeKeysArray"];
        [[NSUserDefaults standardUserDefaults] setObject:self->_notificationSettingsDict forKey:@"NotificationSettingsDict"];
        
    });
    
}

#pragma mark

//-(void)NSNotification_MultiAddTasks_ItemAssignedTo:(NSNotification *)notification {
//
//    NSIndexPath *indexPath = chosenIndexPath;
//
//    NSDictionary *userInfo = notification.userInfo;
//
//    NSMutableArray *assignedToUsernameLocalArray = userInfo[@"AssignedToUsername"] ? userInfo[@"AssignedToUsername"] : [NSMutableArray array];
//    NSString *chosenItemAssignedToAnybody = userInfo[@"AssignedToAnybody"] ? userInfo[@"AssignedToAnybody"] : @"";
//    NSString *itemAssignedToNewHomeMembers = userInfo[@"AssignedToNewHomeMembers"] ? userInfo[@"AssignedToNewHomeMembers"] : @"";
//
//    NSString *itemAssignedTo = [self GenerateItemAssignedToString:assignedToUsernameLocalArray itemAssignedToNewHomeMembers:itemAssignedToNewHomeMembers chosenItemAssignedToAnybody:chosenItemAssignedToAnybody];
//
//    [self GenerateItemDictSearchingDictAndSelectedDictWithUpdatedData:indexPath key:@"ItemAssignedTo" object:itemAssignedTo];
//
//    [self GenerateItemDictSearchingDictAndSelectedDictWithUpdatedData:indexPath key:@"ItemAssignedToNewHomeMembers" object:itemAssignedToNewHomeMembers];
//
//}

//-(NSString *)GenerateItemAssignedToString:(NSMutableArray *)assignedToUsernameLocalArray itemAssignedToNewHomeMembers:(NSString *)itemAssignedToNewHomeMembers chosenItemAssignedToAnybody:(NSString *)chosenItemAssignedToAnybody {
//
//    NSString *itemAssignedTo = @"";
//
//    if ([itemAssignedToNewHomeMembers isEqualToString:@"Yes"] && [assignedToUsernameLocalArray isEqualToArray:_homeMembersDict[@"Username"]]) {
//
//        itemAssignedTo = @"Everybody";
//
//    } else if ([chosenItemAssignedToAnybody isEqualToString:@"Yes"]) {
//
//        itemAssignedTo = @"Anybody";
//
//    } else if ([assignedToUsernameLocalArray count] > 1) {
//
//        for (NSString *assignedToUsernameString in assignedToUsernameLocalArray) {
//
//            BOOL AssignedToStringIsEmpty = itemAssignedTo.length == 0;
//
//            itemAssignedTo = AssignedToStringIsEmpty == YES ?
//            [NSString stringWithFormat:@"%@", assignedToUsernameString] :
//            [NSString stringWithFormat:@"%@, %@", itemAssignedTo, assignedToUsernameString];
//
//        }
//
//    } else if ([assignedToUsernameLocalArray count] == 1) {
//
//        for (NSString *assignedToUsernameString in assignedToUsernameLocalArray) {
//
//            BOOL UsernameIsMine = [assignedToUsernameString isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"]];
//            itemAssignedTo = UsernameIsMine == YES ? @"Myself" : assignedToUsernameString;
//
//        }
//
//    } else if ([assignedToUsernameLocalArray count] == 0) {
//
//        itemAssignedTo = @"Nobody";
//
//    }
//
//    return itemAssignedTo;
//}

-(void)NSNotification_MultiAddTasks_AddTask:(NSNotification *)notification {
    
    NSDictionary *userInfo = notification.userInfo ? [notification.userInfo mutableCopy] : [NSDictionary dictionary];
    
    NSIndexPath *indexPath = chosenIndexPath;
    
    if (AddingFromSearchBar == NO) {
        
        NSMutableArray *itemAssignedToArray = userInfo[@"ItemAssignedTo"] ? [userInfo[@"ItemAssignedTo"] mutableCopy] : [NSMutableArray array];
        //        NSString *itemAssignedToNewHomeMembers = userInfo[@"ItemAssignedToNewHomeMembers"] ? userInfo[@"ItemAssignedToNewHomeMembers"] : @"";
        //        NSString *itemAssignedToAnybody = userInfo[@"ItemAssignedToAnybody"] ? userInfo[@"ItemAssignedToAnybody"] : @"";
        
        
        
        //        NSMutableArray *itemAssignedToUsernameArray = [NSMutableArray array];
        //
        //        for (NSString *userID in itemAssignedToArray) {
        //
        //            NSDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:userID homeMembersDict:_homeMembersDict];
        //            NSString *username = dataDict[@"Username"];
        //
        //            if ([username length] > 0) {
        //                [itemAssignedToUsernameArray addObject:username];
        //            }
        //
        //        }
        
        
        
        //        NSString *itemAssignedTo = [self GenerateItemAssignedToString:itemAssignedToUsernameArray itemAssignedToNewHomeMembers:itemAssignedToNewHomeMembers chosenItemAssignedToAnybody:itemAssignedToAnybody];
        
        NSMutableDictionary *tempDict = [userInfo mutableCopy];
        [tempDict setObject:itemAssignedToArray forKey:@"ItemAssignedTo"];
        userInfo = [tempDict mutableCopy];
        
        
        
        for (NSString *key in [userInfo allKeys]) {
            
            id object = userInfo[key] ? [userInfo[key] mutableCopy] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
            
            [self GenerateItemDictSearchingDictAndSelectedDictWithUpdatedData:indexPath key:key object:object];
            
        }
        
    } else {
        
        NSMutableDictionary *itemDictCopy = itemDict ? [itemDict mutableCopy] : [NSMutableDictionary dictionary];
        NSMutableDictionary *specificItemTypeDict = itemDictCopy[currentItemTypeCollection] ? [itemDictCopy[currentItemTypeCollection] mutableCopy] : [NSMutableDictionary dictionary];
        NSString *specificItemTypeDictSpecificSection = @"Custom";
        NSMutableArray *specificSectionArray = specificItemTypeDict[specificItemTypeDictSpecificSection] ? [specificItemTypeDict[specificItemTypeDictSpecificSection] mutableCopy] : [NSMutableArray array];
        NSMutableDictionary *specificItemDict = [userInfo mutableCopy];
        
        [specificSectionArray addObject:specificItemDict];
        [specificItemTypeDict setObject:specificSectionArray forKey:@"Custom"];
        [itemDictCopy setObject:specificItemTypeDict forKey:currentItemTypeCollection];
        
        itemDict = [itemDictCopy mutableCopy];
        
        AddingFromSearchBar = NO;
        
    }
    
    
    NSString *itemSuggestedID = userInfo[@"ItemSuggestedID"] ? userInfo[@"ItemSuggestedID"] : @"";
    
    NSMutableDictionary *specificItemTypeDictOfSelectedTasks = itemSelectedDictLocal[currentItemTypeCollection] ? [itemSelectedDictLocal[currentItemTypeCollection] mutableCopy] : [NSMutableDictionary dictionary];
    [specificItemTypeDictOfSelectedTasks setObject:userInfo forKey:itemSuggestedID];
    [itemSelectedDictLocal setObject:[specificItemTypeDictOfSelectedTasks mutableCopy] forKey:currentItemTypeCollection];
    
    [[[GeneralObject alloc] init] CallNSNotificationMethods:@"UpdateItemDictLocal" userInfo:@{@"ItemSelectedDictLocal" : self->itemSelectedDictLocal} locations:@[@"MultiAddTasks"]];
    
    [self UpdateAddTasksUI:NO];
    
}

-(void)NSNotification_MultiAddTasks_ItemRepeats:(NSNotification *)notification {
    
    NSIndexPath *indexPath = chosenIndexPath;
    
    NSString *itemRepeats = [self GenerateObjectAtIndexPathForKey:@"ItemRepeats" defaultKey:@"Never" indexPath:indexPath];
    NSString *itemRepeatIfCompletedEarly = [self GenerateObjectAtIndexPathForKey:@"ItemRepeatIfCompletedEarly" defaultKey:@"No" indexPath:indexPath];
    NSString *itemDays = [self GenerateObjectAtIndexPathForKey:@"ItemDays" defaultKey:@"Any Day" indexPath:indexPath];
    NSString *itemTime = [self GenerateObjectAtIndexPathForKey:@"ItemTime" defaultKey:@"Any Time" indexPath:indexPath];
    
    NSDictionary *userInfo = notification.userInfo;
    
    itemRepeats = userInfo[@"Repeats"];
    
    
    
    
    if ([itemRepeats isEqualToString:@"Never"] || [itemRepeats isEqualToString:@"As Needed"] || [itemRepeats isEqualToString:@"When Needed"]) {
        
        itemRepeatIfCompletedEarly = @"No";
        
    }
    
    
    
    
    if ([itemRepeats isEqualToString:@"Semi-Monthly"] && [itemDays isEqualToString:@"15th, Last Day"] == NO) {
        
        itemRepeats = @"Monthly";
        itemDays = @"15th, Last Day";
        
    } else if ([itemRepeats isEqualToString:@"Semi-Monthly"] == NO && [itemDays isEqualToString:@"15th, Last Day"] == YES) {
        
        itemDays = @"";
        
    }
    
    
    
    
    if (itemDays.length == 0) {
        itemDays = @"Any Day";
    }
    if (itemTime.length == 0) {
        itemTime = @"Any Time";
    }
    
    
    
    
    if ([itemRepeats containsString:@"Week"] == NO && [itemRepeats containsString:@"Month"] == NO) {
        itemDays = @"";
    }
    
    
    
    
    if ([itemRepeats isEqualToString:@"Never"]) {
        itemDays = @"";
        itemTime = @"";
    }
    
    
    
    
    [self GenerateItemDictSearchingDictAndSelectedDictWithUpdatedData:indexPath key:@"ItemRepeats" object:itemRepeats];
    [self GenerateItemDictSearchingDictAndSelectedDictWithUpdatedData:indexPath key:@"ItemRepeatIfCompletedEarly" object:itemRepeatIfCompletedEarly];
    [self GenerateItemDictSearchingDictAndSelectedDictWithUpdatedData:indexPath key:@"ItemDays" object:itemDays];
    [self GenerateItemDictSearchingDictAndSelectedDictWithUpdatedData:indexPath key:@"ItemTime" object:itemTime];
    
}

-(void)NSNotification_MultiAddTasks_ItemListItems:(NSNotification *)notification {
    
    NSIndexPath *indexPath = chosenIndexPath;
    
    NSMutableDictionary *itemListItems = [self GenerateObjectAtIndexPathForKey:@"ItemListItems" defaultKey:[NSMutableDictionary dictionary] indexPath:indexPath];
    
    NSDictionary *userInfo = notification.userInfo;
    
    NSMutableDictionary *dict = userInfo[@"ItemsDict"];
    
    BOOL ItemListItemsDictHasKeys = ([[dict allKeys] count] > 0);
    
    itemListItems = ItemListItemsDictHasKeys == YES ? dict : [NSMutableDictionary dictionary];
    
    [self GenerateItemDictSearchingDictAndSelectedDictWithUpdatedData:indexPath key:@"ItemListItems" object:itemListItems];
    
}

#pragma mark

-(void)NSNotification_MultiAddTasks_AddOrEditTaskList:(NSNotification *)notification {
    
    NSDictionary *userInfo = notification.userInfo;
    
    NSString *taskListID = userInfo[@"TaskListID"] ? userInfo[@"TaskListID"] : @"";
    NSString *taskListName = userInfo[@"TaskListName"] ? userInfo[@"TaskListName"] : @"";
    
    BOOL Editing = [_taskListDict[@"TaskListID"] containsObject:taskListID];
    
    for (NSString *key in [userInfo allKeys]) {
        
        NSMutableArray *arr = _taskListDict[key] ? [_taskListDict[key] mutableCopy] : [NSMutableArray array];
        
        if (Editing) {
            
            NSUInteger index = [_taskListDict[@"TaskListID"] indexOfObject:taskListID];
            if (arr.count > index) { [arr replaceObjectAtIndex:index withObject:userInfo[key]]; }
            
        } else {
            
            id object = userInfo[key] ? userInfo[key] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
            [arr addObject:object];
            
        }
        
        [_taskListDict setObject:arr forKey:key];
        
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"MultiAddNewListIndexPath"] &&
        [[NSUserDefaults standardUserDefaults] objectForKey:@"MultiAddNewListIndexPath"][@"indexPathRow"] &&
        [[NSUserDefaults standardUserDefaults] objectForKey:@"MultiAddNewListIndexPath"][@"indexPathSection"] &&
        _viewingAddedTasks == NO) {
        
        NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"MultiAddNewListIndexPath"];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[(NSString *)dict[@"indexPathRow"] intValue] inSection:[(NSString *)dict[@"indexPathSection"] intValue]];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"MultiAddNewListIndexPath"];
        
        [self GenerateItemDictSearchingDictAndSelectedDictWithUpdatedData:indexPath key:@"ItemTaskList" object:taskListName];
        
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"MultiAddNewListIndexPath_ViewingAddedTasks"] &&
        [[NSUserDefaults standardUserDefaults] objectForKey:@"MultiAddNewListIndexPath_ViewingAddedTasks"][@"indexPathRow"] &&
        [[NSUserDefaults standardUserDefaults] objectForKey:@"MultiAddNewListIndexPath_ViewingAddedTasks"][@"indexPathSection"] &&
        _viewingAddedTasks == YES) {
        
        NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"MultiAddNewListIndexPath_ViewingAddedTasks"];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[(NSString *)dict[@"indexPathRow"] intValue] inSection:[(NSString *)dict[@"indexPathSection"] intValue]];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"MultiAddNewListIndexPath_ViewingAddedTasks"];
        
        [self GenerateItemDictSearchingDictAndSelectedDictWithUpdatedData:indexPath key:@"ItemTaskList" object:taskListName];
        
    }
    
    [self.customTableView reloadData];
    
}

-(void)NSNotification_MultiAddTasks_AddOrEditItemTemplate:(NSNotification *)notification {
    
    NSDictionary *userInfo = notification.userInfo;
    
    NSString *templateID = userInfo[@"TemplateID"] ? userInfo[@"TemplateID"] : @"";
    
    BOOL Editing = NO;
    
    if (_templateDict[@"TemplateID"] && [_templateDict[@"TemplateID"] containsObject:templateID]) {
        Editing = YES;
    }
    
    for (NSString *key in [userInfo allKeys]) {
        
        NSMutableArray *arr = _templateDict[key] ? [_templateDict[key] mutableCopy] : [NSMutableArray array];
        
        if (Editing) {
            
            NSUInteger index = [_templateDict[@"TemplateID"] indexOfObject:templateID];
            if (arr.count > index) { [arr replaceObjectAtIndex:index withObject:userInfo[key]]; }
            
        } else {
            
            id object = userInfo[key] ? userInfo[key] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
            [arr addObject:object];
            
        }
        
        [_templateDict setObject:arr forKey:key];
        
    }
    
}

-(void)NSNotification_MultiAddTasks_DeleteItemTemplate:(NSNotification *)notification {
    
    NSDictionary *userInfo = notification.userInfo;
    
    NSString *templateID = userInfo[@"TemplateID"] ? userInfo[@"TemplateID"] : @"";
    
    for (NSString *key in [userInfo allKeys]) {
        
        NSMutableArray *arr = _templateDict[key] ? [_templateDict[key] mutableCopy] : [NSMutableArray array];
        
        if (_templateDict[@"TemplateID"] && [_templateDict[@"TemplateID"] containsObject:templateID]) {
            
            NSUInteger index = [_templateDict[@"TemplateID"] indexOfObject:templateID];
            if (arr.count > index) { [arr removeObjectAtIndex:index]; }
            
        }
        
        [_templateDict setObject:arr forKey:key];
        
    }
    
}

#pragma mark

-(void)NSNotification_MultiAddTasks_ItemWeDivvyPremiumAccounts:(NSNotification *)notification {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSDictionary *userInfo = notification.userInfo;
        
        NSDictionary *userDict = userInfo[@"UserDict"] ? userInfo[@"UserDict"] : @{};
        NSMutableArray *weDivvyPremiumArray = userDict[@"WeDivvyPremium"] ? userDict[@"WeDivvyPremium"] : @[];
        
        NSMutableDictionary *tempDict = self->_homeMembersDict ? [self->_homeMembersDict mutableCopy] : [NSMutableDictionary dictionary];
        NSMutableArray *tempArr = tempDict[@"WeDivvyPremium"] ? [tempDict[@"WeDivvyPremium"] mutableCopy] : [NSMutableArray array];
        tempArr = [weDivvyPremiumArray mutableCopy];
        [tempDict setObject:tempArr forKey:@"WeDivvyPremium"];
        self->_homeMembersDict = [tempDict mutableCopy];
        
        [[NSUserDefaults standardUserDefaults] setObject:self->_homeMembersDict forKey:@"HomeMembersDict"];
        
    });
    
}

#pragma mark - Table View Methods

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    MultiAddTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MultiAddTaskCell"];
    
    NSString *taskName =[self GenerateObjectAtIndexPathForKey:@"ItemName" defaultKey:@"" indexPath:indexPath];
    NSString *itemAmount = [self GenerateObjectAtIndexPathForKey:@"ItemAmount" defaultKey:[NSString stringWithFormat:@"%@0%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol] indexPath:indexPath];
    NSMutableDictionary *itemListItems = [self GenerateObjectAtIndexPathForKey:@"ItemListItems" defaultKey:[NSMutableDictionary dictionary] indexPath:indexPath];
    NSString *itemRepeats = [self GenerateObjectAtIndexPathForKey:@"ItemRepeats" defaultKey:@"Never" indexPath:indexPath];
    NSString *itemPriority = [self GenerateObjectAtIndexPathForKey:@"ItemPriority" defaultKey:@"None" indexPath:indexPath];
    NSString *itemTakeTurns = [self GenerateObjectAtIndexPathForKey:@"ItemTakeTurns" defaultKey:@"No" indexPath:indexPath];
    
    BOOL ObjectIsKindOfNSStringClass = [currentItemType isEqualToString:@"List"] ? [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:itemListItems classArr:@[[NSDictionary class], [NSMutableDictionary class]]] : NO;
    
    NSString *itemListItemsString = [currentItemType isEqualToString:@"List"] && ObjectIsKindOfNSStringClass == YES ? [NSString stringWithFormat:@"%lu items", [[itemListItems allKeys] count]] : @"";
    itemAmount = [currentItemType isEqualToString:@"Expense"] ? itemAmount : @"";
    
    NSString *itemRepeatsSpaceString = [itemAmount length] > 0 || [itemListItemsString length] > 0 ? @", " : @"";
    
    itemRepeats = [itemRepeats isEqualToString:@""] == NO ? [NSString stringWithFormat:@"%@%@", itemRepeatsSpaceString, itemRepeats] : @"";
    itemTakeTurns = [itemTakeTurns isEqualToString:@"No"] == NO ? @", Take Turns" : @"";
    itemPriority = [itemPriority isEqualToString:@"None"] == NO && [itemPriority isEqualToString:@"No Priority"] == NO ? [NSString stringWithFormat:@", %@ Priority", itemPriority] : @"";
    
    cell.titleLabel.text = taskName;
    cell.subLabel.text = [NSString stringWithFormat:@"%@%@%@%@%@", itemAmount, itemListItemsString, itemRepeats, itemTakeTurns, itemPriority];
    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self GenerateNumberOfRowsInTableView:section];
    
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(MultiAddTaskCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BOOL TaskHasBeenSelected = [self TaskHasBeenSelected:indexPath];
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = (self.view.frame.size.height*0.11005435 > 81?(81):self.view.frame.size.height*0.11005435);
    
    CGFloat Imageheight = 94;
    
    CGFloat mainViewHeight = [selectedCellsArray containsObject:indexPath] ? height*0.7037037+ 55 : height*0.7037037;
    
    cell.mainView.frame = CGRectMake(width*0.5 - ((width*0.90338164)*0.5), 0/*height*0.5 - ((mainViewHeight)*0.5)*/, width*0.90338164, mainViewHeight);
    cell.mainViewOverlayView.frame = cell.mainView.frame;
    
    
    
    
    width = CGRectGetWidth(cell.mainView.bounds);
    height = height*0.7037037;
    
    cell.checkmarkView.frame = CGRectMake(width*0.04278075, height*0.5 - ((height*0.43859)*0.5), height*0.43859, height*0.43859);
    cell.checkmarkViewCover.frame = CGRectMake(0, 0, cell.checkmarkView.frame.origin.x + cell.checkmarkView.frame.size.width + width*0.04278075, height);
    
    
    
    
    UIFont *fontSize = [UIFont systemFontOfSize:(self.view.frame.size.height*0.02038043 > 15?15:(self.view.frame.size.height*0.02038043)) weight:UIFontWeightSemibold];
    
    cell.titleLabel.font = fontSize;
    cell.titleLabel.textColor = [UIColor blackColor];
    cell.titleLabel.frame = CGRectMake(cell.checkmarkView.frame.origin.x + cell.checkmarkView.frame.size.width + width*0.04278075, height*0.14035, width*0.725, height*0.350878);
    cell.titleLabel.adjustsFontSizeToFitWidth = NO;
    
    
    
    
    cell.itemRepeatsImage.frame = CGRectMake(cell.titleLabel.frame.origin.x, height - cell.titleLabel.frame.size.height - height*0.14035, (Imageheight*0.15957447 > 15?(15):Imageheight*0.15957447), cell.titleLabel.frame.size.height);
    
    cell.subLabel.frame = CGRectMake(cell.itemRepeatsImage.frame.origin.x + cell.itemRepeatsImage.frame.size.width + ((width*0.04278075)*0.25), height - cell.titleLabel.frame.size.height - height*0.14035, cell.titleLabel.frame.size.width - cell.itemRepeatsImage.frame.size.width - ((width*0.04278075)*0.25), cell.titleLabel.frame.size.height);
    
    
    
    
    cell.selectedSuggestedView.frame = CGRectMake(width - height*0.43859 - width*0.04278075, height*0.5 - ((height*0.43859)*0.5), height*0.43859, height*0.43859);
    cell.selectedSuggestedView.layer.cornerRadius = cell.selectedSuggestedView.frame.size.height/2;
    cell.selectedSuggestedViewImage.frame = CGRectMake(cell.selectedSuggestedView.frame.size.width*0.5 - ((cell.selectedSuggestedView.frame.size.width*0.5 > 20?20:(cell.selectedSuggestedView.frame.size.width*0.5))*0.5),
                                                       cell.selectedSuggestedView.frame.size.height*0.5 - ((cell.selectedSuggestedView.frame.size.height*0.5 > 20?20:(cell.selectedSuggestedView.frame.size.height*0.5))*0.5),
                                                       (cell.selectedSuggestedView.frame.size.height*0.5 > 20?20:(cell.selectedSuggestedView.frame.size.height*0.5)),
                                                       (cell.selectedSuggestedView.frame.size.height*0.5 > 20?20:(cell.selectedSuggestedView.frame.size.height*0.5)));
    cell.selectedSuggestedViewButton.frame = CGRectMake(cell.selectedSuggestedView.frame.origin.x - 10, 0, cell.selectedSuggestedView.frame.size.width + 20, height);
    
    
    
    
    cell.addTaskScrollViewExpandIcon.frame = CGRectMake(cell.selectedSuggestedView.frame.origin.x + (cell.selectedSuggestedView.frame.size.width*0.5 - 20*0.5), cell.subLabel.frame.origin.y + cell.subLabel.frame.size.height + 12, height*0.350877, height*0.350877);
    cell.addTaskScrollViewExpandIcon.hidden = [selectedCellsArray containsObject:indexPath] ? NO : YES;
    cell.addTaskScrollViewExpandIcon.tag = indexPath.row;
    
    cell.addTaskScrollViewExpandIconCover.frame = CGRectMake(cell.addTaskScrollViewExpandIcon.frame.origin.x - 10, cell.addTaskScrollViewExpandIcon.frame.origin.y - 10, cell.addTaskScrollViewExpandIconCover.frame.size.width + 20, cell.addTaskScrollViewExpandIconCover.frame.size.height + 20);
    cell.addTaskScrollViewExpandIconCover.hidden = [selectedCellsArray containsObject:indexPath] ? NO : YES;
    cell.addTaskScrollViewExpandIconCover.tag = indexPath.row;
    
    cell.addTaskOptionsScrollViewView.frame = CGRectMake(0, cell.subLabel.frame.origin.y + cell.subLabel.frame.size.height + 12, width - (width - cell.addTaskScrollViewExpandIcon.frame.origin.x), height*0.701754);
    cell.addTaskOptionsScrollViewView.hidden = [selectedCellsArray containsObject:indexPath] ? NO : YES;
    
    CGRect newRect = cell.addTaskScrollViewExpandIcon.frame;
    newRect.origin.y = cell.addTaskOptionsScrollViewView.frame.origin.y + (cell.addTaskOptionsScrollViewView.frame.size.height*0.5 - newRect.size.height*0.5);
    cell.addTaskScrollViewExpandIcon.frame = newRect;
    
    
    
    
    width = CGRectGetWidth(cell.addTaskOptionsScrollViewView.bounds);
    height = CGRectGetHeight(cell.addTaskOptionsScrollViewView.bounds);
    
    CGFloat spacing = (self.view.frame.size.height*0.01390498 > 12?12:(self.view.frame.size.height*0.01390498));
    CGFloat scrollViewHeight = (self.view.frame.size.height*0.07196402 > 48?48:(self.view.frame.size.height*0.07196402))*0.75;
    
    cell.addTaskOptionsScrollView.frame = CGRectMake(spacing + (self.view.frame.size.height*0.01860465 > 8?8:(self.view.frame.size.height*0.01860465)), height*0.5 - scrollViewHeight*0.5, width-(spacing*2), scrollViewHeight);
    cell.addTaskOptionsScrollView.contentSize = CGSizeMake(self.view.frame.size.width+10, 0);
    
    
    NSString *itemTaskList = [self GenerateObjectAtIndexPathForKey:@"ItemTaskList" defaultKey:@"No List" indexPath:indexPath];
    NSString *itemRepeats = [self GenerateObjectAtIndexPathForKey:@"ItemRepeats" defaultKey:@"Never" indexPath:indexPath];
    NSString *itemTakeTurns = [self GenerateObjectAtIndexPathForKey:@"ItemTakeTurns" defaultKey:@"No" indexPath:indexPath];
    NSString *itemPriority = [self GenerateObjectAtIndexPathForKey:@"ItemPriority" defaultKey:@"None" indexPath:indexPath];
    NSString *itemAmount = [self GenerateObjectAtIndexPathForKey:@"ItemAmount" defaultKey:[NSString stringWithFormat:@"%@0%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol] indexPath:indexPath];
    NSMutableDictionary *itemListItems = [self GenerateObjectAtIndexPathForKey:@"ItemListItems" defaultKey:[NSMutableDictionary dictionary] indexPath:indexPath];
    
    BOOL ShowSelected = NO;
    UIView *previousView = nil;
    NSString *labelText = @"";
    
    
    
    
    if ([currentItemType isEqualToString:@"Expense"]) {
        
        ShowSelected = [itemAmount length] > 0 && [itemAmount isEqualToString:[NSString stringWithFormat:@"%@0%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol]] == NO && [itemAmount isEqualToString:[NSString stringWithFormat:@"%@0%@00", [[[GeneralObject alloc] init] GenerateLocalCurrencySymbol], localCurrencyDecimalSeparatorSymbol]] == NO;
        
        labelText = itemAmount;
        
        [self GenerateSelectedUnselectedView:ShowSelected previousView:previousView addTaskScrollViewIcon:cell.addTaskScrollViewAmountIcon addTaskSelectedView:cell.addTaskSelectedViewAmount addTaskSelectedViewImageView:cell.addTaskSelectedViewImageViewAmount addTaskSelectedViewLabel:cell.addTaskSelectedViewLabelAmount addTaskSelectedViewXView:cell.addTaskSelectedViewXViewAmount addTaskSelectedViewXImageView:cell.addTaskSelectedViewXImageViewAmount labelText:labelText key:@"ItemAmount" cell:cell];
        
        previousView = ShowSelected ? cell.addTaskSelectedViewAmount : cell.addTaskScrollViewAmountIcon;
        
        
        cell.addTaskScrollViewAmountIconButton.frame = cell.addTaskScrollViewAmountIcon.frame;
        cell.addTaskSelectedViewButtonAmount.frame = CGRectMake(cell.addTaskSelectedViewAmount.frame.origin.x, cell.addTaskSelectedViewAmount.frame.origin.y, cell.addTaskSelectedViewAmount.frame.size.width - (cell.addTaskSelectedViewAmount.frame.size.width - cell.addTaskSelectedViewXViewAmount.frame.origin.x + 8), cell.addTaskSelectedViewAmount.frame.size.height);
        
        cell.addTaskScrollViewAmountIconButton.hidden = cell.addTaskScrollViewAmountIcon.hidden;
        cell.addTaskSelectedViewButtonAmount.hidden = cell.addTaskSelectedViewAmount.hidden;
        
    } else {
        
        cell.addTaskSelectedViewAmount.hidden = YES;
        cell.addTaskScrollViewAmountIcon.hidden = YES;
        cell.addTaskScrollViewAmountIconButton.hidden = YES;
        
    }
    
    
    
    
    if ([currentItemType isEqualToString:@"List"]) {
        
        ShowSelected = [[itemListItems allKeys] count] == 0 == NO;
        
        labelText = [NSString stringWithFormat:@"%lu item%@", [[itemListItems allKeys] count], [[itemListItems allKeys] count] == 1 ? @"" : @"s"];
        
        [self GenerateSelectedUnselectedView:ShowSelected previousView:previousView addTaskScrollViewIcon:cell.addTaskScrollViewListItemsIcon addTaskSelectedView:cell.addTaskSelectedViewListItems addTaskSelectedViewImageView:cell.addTaskSelectedViewImageViewListItems addTaskSelectedViewLabel:cell.addTaskSelectedViewLabelListItems addTaskSelectedViewXView:cell.addTaskSelectedViewXViewListItems addTaskSelectedViewXImageView:cell.addTaskSelectedViewXImageViewListItems labelText:labelText key:@"ItemListItems" cell:cell];
        
        previousView = ShowSelected ? cell.addTaskSelectedViewListItems : cell.addTaskScrollViewListItemsIcon;
        
        cell.addTaskScrollViewListItemsIconButton.frame = cell.addTaskScrollViewListItemsIcon.frame;
        cell.addTaskSelectedViewButtonListItems.frame = CGRectMake(cell.addTaskSelectedViewListItems.frame.origin.x, cell.addTaskSelectedViewListItems.frame.origin.y, cell.addTaskSelectedViewListItems.frame.size.width - (cell.addTaskSelectedViewListItems.frame.size.width - cell.addTaskSelectedViewXViewListItems.frame.origin.x + 8), cell.addTaskSelectedViewListItems.frame.size.height);
        
        cell.addTaskScrollViewListItemsIconButton.hidden = cell.addTaskScrollViewListItemsIcon.hidden;
        cell.addTaskSelectedViewButtonListItems.hidden = cell.addTaskSelectedViewListItems.hidden;
        
    } else {
        
        cell.addTaskSelectedViewListItems.hidden = YES;
        cell.addTaskScrollViewListItemsIcon.hidden = YES;
        cell.addTaskScrollViewListItemsIconButton.hidden = YES;
        
    }
    
    
    
    
    //    BOOL ObjectIsKindOfNSStringClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:itemAssignedTo classArr:@[[NSString class]]];
    //
    //    ShowSelected = ObjectIsKindOfNSStringClass == YES && [itemAssignedTo length] > 0 && [itemAssignedTo isEqualToString:@"Nobody"] == NO;
    //
    //    labelText = itemAssignedTo;
    //
    //    [self GenerateSelectedUnselectedView:ShowSelected previousView:previousView addTaskScrollViewIcon:cell.addTaskScrollViewAssignedToIcon addTaskSelectedView:cell.addTaskSelectedViewAssignedTo addTaskSelectedViewImageView:cell.addTaskSelectedViewImageViewAssignedTo addTaskSelectedViewLabel:cell.addTaskSelectedViewLabelAssignedTo addTaskSelectedViewXView:cell.addTaskSelectedViewXViewAssignedTo addTaskSelectedViewXImageView:cell.addTaskSelectedViewXImageViewAssignedTo labelText:labelText key:@"ItemAssignedTo" cell:cell];
    //
    //    previousView = ShowSelected ? cell.addTaskSelectedViewAssignedTo : cell.addTaskScrollViewAssignedToIcon;
    //
    //    cell.addTaskScrollViewAssignedToIconButton.frame = cell.addTaskScrollViewAssignedToIcon.frame;
    //    cell.addTaskSelectedViewButtonAssignedTo.frame = CGRectMake(cell.addTaskSelectedViewAssignedTo.frame.origin.x, cell.addTaskSelectedViewAssignedTo.frame.origin.y, cell.addTaskSelectedViewAssignedTo.frame.size.width - (cell.addTaskSelectedViewAssignedTo.frame.size.width - cell.addTaskSelectedViewXViewAssignedTo.frame.origin.x + 8), cell.addTaskSelectedViewAssignedTo.frame.size.height);
    //
    //    cell.addTaskScrollViewAssignedToIconButton.hidden = cell.addTaskScrollViewAssignedToIcon.hidden;
    //    cell.addTaskSelectedViewButtonAssignedTo.hidden = cell.addTaskSelectedViewAssignedTo.hidden;
    
    
    
    
    ShowSelected = [itemRepeats length] > 0 && [itemRepeats isEqualToString:@"Never"] == NO;
    
    labelText = itemRepeats;
    
    [self GenerateSelectedUnselectedView:ShowSelected previousView:previousView addTaskScrollViewIcon:cell.addTaskScrollViewRepeatsIcon addTaskSelectedView:cell.addTaskSelectedViewRepeats addTaskSelectedViewImageView:cell.addTaskSelectedViewImageViewRepeats addTaskSelectedViewLabel:cell.addTaskSelectedViewLabelRepeats addTaskSelectedViewXView:cell.addTaskSelectedViewXViewRepeats addTaskSelectedViewXImageView:cell.addTaskSelectedViewXImageViewRepeats labelText:labelText key:@"ItemRepeats" cell:cell];
    
    previousView = ShowSelected ? cell.addTaskSelectedViewRepeats : cell.addTaskScrollViewRepeatsIcon;
    
    cell.addTaskScrollViewRepeatsIconButton.frame = cell.addTaskScrollViewRepeatsIcon.frame;
    cell.addTaskSelectedViewButtonRepeats.frame = CGRectMake(cell.addTaskSelectedViewRepeats.frame.origin.x, cell.addTaskSelectedViewRepeats.frame.origin.y, cell.addTaskSelectedViewRepeats.frame.size.width - (cell.addTaskSelectedViewRepeats.frame.size.width - cell.addTaskSelectedViewXViewRepeats.frame.origin.x + 8), cell.addTaskSelectedViewRepeats.frame.size.height);
    
    cell.addTaskScrollViewRepeatsIconButton.hidden = cell.addTaskScrollViewRepeatsIcon.hidden;
    cell.addTaskSelectedViewButtonRepeats.hidden = cell.addTaskSelectedViewRepeats.hidden;
    
    
    
    
    ShowSelected = [itemTakeTurns length] > 0 && [itemTakeTurns isEqualToString:@"No"] == NO;
    
    labelText = itemTakeTurns;
    
    [self GenerateSelectedUnselectedView:ShowSelected previousView:previousView addTaskScrollViewIcon:cell.addTaskScrollViewTakeTurnsIcon addTaskSelectedView:cell.addTaskSelectedViewTakeTurns addTaskSelectedViewImageView:cell.addTaskSelectedViewImageViewTakeTurns addTaskSelectedViewLabel:cell.addTaskSelectedViewLabelTakeTurns addTaskSelectedViewXView:cell.addTaskSelectedViewXViewTakeTurns addTaskSelectedViewXImageView:cell.addTaskSelectedViewXImageViewTakeTurns labelText:labelText key:@"ItemTakeTurns" cell:cell];
    
    previousView = ShowSelected ? cell.addTaskSelectedViewTakeTurns : cell.addTaskScrollViewTakeTurnsIcon;
    
    cell.addTaskScrollViewTakeTurnsIconButton.frame = cell.addTaskScrollViewTakeTurnsIcon.frame;
    cell.addTaskSelectedViewButtonTakeTurns.frame = CGRectMake(cell.addTaskSelectedViewTakeTurns.frame.origin.x, cell.addTaskSelectedViewTakeTurns.frame.origin.y, cell.addTaskSelectedViewTakeTurns.frame.size.width - (cell.addTaskSelectedViewTakeTurns.frame.size.width - cell.addTaskSelectedViewXViewTakeTurns.frame.origin.x + 8), cell.addTaskSelectedViewTakeTurns.frame.size.height);
    
    cell.addTaskScrollViewTakeTurnsIconButton.hidden = cell.addTaskScrollViewTakeTurnsIcon.hidden;
    cell.addTaskSelectedViewButtonTakeTurns.hidden = cell.addTaskSelectedViewTakeTurns.hidden;
    
    
    
    
    ShowSelected = [itemPriority isEqualToString:@"No Priority"] == NO && [itemPriority isEqualToString:@"None"] == NO && [itemPriority isEqualToString:@""] == NO && itemPriority == NULL == NO;
    
    labelText = itemPriority;
    
    [self GenerateSelectedUnselectedView:ShowSelected previousView:previousView addTaskScrollViewIcon:cell.addTaskScrollViewPriorityIcon addTaskSelectedView:cell.addTaskSelectedViewPriority addTaskSelectedViewImageView:cell.addTaskSelectedViewImageViewPriority addTaskSelectedViewLabel:cell.addTaskSelectedViewLabelPriority addTaskSelectedViewXView:cell.addTaskSelectedViewXViewPriority addTaskSelectedViewXImageView:cell.addTaskSelectedViewXImageViewPriority labelText:labelText key:@"ItemPriority" cell:cell];
    
    previousView = ShowSelected ? cell.addTaskSelectedViewPriority : cell.addTaskScrollViewPriorityIcon;
    
    cell.addTaskScrollViewPriorityIconButton.frame = cell.addTaskScrollViewPriorityIcon.frame;
    cell.addTaskSelectedViewButtonPriority.frame = CGRectMake(cell.addTaskSelectedViewPriority.frame.origin.x, cell.addTaskSelectedViewPriority.frame.origin.y, cell.addTaskSelectedViewPriority.frame.size.width - (cell.addTaskSelectedViewPriority.frame.size.width - cell.addTaskSelectedViewXViewPriority.frame.origin.x + 8), cell.addTaskSelectedViewPriority.frame.size.height);
    
    cell.addTaskScrollViewPriorityIconButton.hidden = cell.addTaskScrollViewPriorityIcon.hidden;
    cell.addTaskSelectedViewButtonPriority.hidden = cell.addTaskSelectedViewPriority.hidden;
    
    
    
    
    ShowSelected = [itemTaskList isEqualToString:@"No List"] == NO && [itemTaskList isEqualToString:@"None"] == NO && [itemTaskList isEqualToString:@""] == NO && itemTaskList == NULL == NO;
    
    labelText = itemTaskList;
    
    [self GenerateSelectedUnselectedView:ShowSelected previousView:previousView addTaskScrollViewIcon:cell.addTaskScrollViewTaskListIcon addTaskSelectedView:cell.addTaskSelectedViewTaskList addTaskSelectedViewImageView:cell.addTaskSelectedViewImageViewTaskList addTaskSelectedViewLabel:cell.addTaskSelectedViewLabelTaskList addTaskSelectedViewXView:cell.addTaskSelectedViewXViewTaskList addTaskSelectedViewXImageView:cell.addTaskSelectedViewXImageViewTaskList labelText:labelText key:@"ItemTaskList" cell:cell];
    
    previousView = ShowSelected ? cell.addTaskSelectedViewTaskList : cell.addTaskScrollViewTaskListIcon;
    
    cell.addTaskScrollViewTaskListIconButton.frame = cell.addTaskScrollViewTaskListIcon.frame;
    cell.addTaskSelectedViewButtonTaskList.frame = CGRectMake(cell.addTaskSelectedViewTaskList.frame.origin.x, cell.addTaskSelectedViewTaskList.frame.origin.y, cell.addTaskSelectedViewTaskList.frame.size.width - (cell.addTaskSelectedViewTaskList.frame.size.width - cell.addTaskSelectedViewXViewTaskList.frame.origin.x + 8), cell.addTaskSelectedViewTaskList.frame.size.height);
    
    cell.addTaskScrollViewTaskListIconButton.hidden = cell.addTaskScrollViewTaskListIcon.hidden;
    cell.addTaskSelectedViewButtonTaskList.hidden = cell.addTaskSelectedViewTaskList.hidden;
    
    
    
    
    cell.itemPriorityImage.frame = CGRectMake(width - ((Imageheight*0.15957447 > 15?(15):Imageheight*0.15957447)*0.9) - cell.checkmarkView.frame.origin.x,  cell.titleLabel.frame.origin.y, ((Imageheight*0.15957447 > 15?(15):Imageheight*0.15957447)*0.9), ((Imageheight*0.15957447 > 15?(15):Imageheight*0.15957447)*0.9));
    
    cell.mutedImage.frame = CGRectMake(width - ((Imageheight*0.15957447 > 15?(15):Imageheight*0.15957447)*1.0) - cell.checkmarkView.frame.origin.x,  cell.titleLabel.frame.origin.y, ((Imageheight*0.15957447 > 15?(15):Imageheight*0.15957447)*1.0), ((Imageheight*0.15957447 > 15?(15):Imageheight*0.15957447)*1.0));
    cell.reminderImage.frame = CGRectMake(width - ((Imageheight*0.15957447 > 15?(15):Imageheight*0.15957447)*1.0) - cell.checkmarkView.frame.origin.x,  cell.titleLabel.frame.origin.y, ((Imageheight*0.15957447 > 15?(15):Imageheight*0.15957447)*1.0), ((Imageheight*0.15957447 > 15?(15):Imageheight*0.15957447)*1.0));
    cell.privateImage.frame = CGRectMake(width - ((Imageheight*0.15957447 > 15?(15):Imageheight*0.15957447)*1.25) - cell.checkmarkView.frame.origin.x,  cell.mutedImage.frame.origin.y + cell.mutedImage.frame.size.height*0.5 - (((Imageheight*0.15957447 > 15?(15):Imageheight*0.15957447)*1.25))*0.5, ((Imageheight*0.15957447 > 15?(15):Imageheight*0.15957447)*1.25), ((Imageheight*0.15957447 > 15?(15):Imageheight*0.15957447)*1.25));
    
    
    CGFloat cornerRadius = (self.view.frame.size.height*0.2181818182 > 12?12:(self.view.frame.size.height*0.2181818182));
    
    [[[GeneralObject alloc] init] RoundingCorners:_searchBarView topCorners:YES bottomCorners:YES cornerRadius:cornerRadius];
    [[[GeneralObject alloc] init] RoundingCorners:_searchBar topCorners:YES bottomCorners:YES cornerRadius:cornerRadius];
    
    if (TaskHasBeenSelected) {
        
        cell.selectedSuggestedView.backgroundColor = [[[GeneralObject alloc] init] GenerateAppColor:1.0f];
        cell.selectedSuggestedViewImage.image = [UIImage imageNamed:@"MultiAddCellIcons.SelectedCheckmark"];
        
    } else {
        
        cell.selectedSuggestedView.backgroundColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeSecondary] : [UIColor colorWithRed:238.0f/255.0f green:240.0f/255.0f blue:243.0f/255.0f alpha:1.0f];
        cell.selectedSuggestedViewImage.image = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [UIImage imageNamed:@"MultiAddCellIcons.SelectedCheckmark"] : [UIImage imageNamed:@"MultiAddCellIcons.UnselectedPlus.png"];
        
    }
    
    cell.mainViewOverlayView.frame = cell.mainView.frame;
    [cell.mainViewOverlayView setTitle:@"" forState:UIControlStateNormal];
    
    [self SetUpAddedTaskContextMenu:cell];
    
    [self SetUpRepeatsContextMenu:cell];
    
    [self SetUpTakeTurnsContextMenu:cell];
    
    [self SetUpPriorityContextMenu:cell];
    
    [self SetUpTaskListContextMenu:cell];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGestureExpandTaskAction:)];
    cell.addTaskScrollViewExpandIconCover.userInteractionEnabled = YES;
    [cell.addTaskScrollViewExpandIconCover addGestureRecognizer:tapGesture];
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGestureAddTaskViewAmountView:)];
    cell.addTaskScrollViewAmountIconButton.userInteractionEnabled = YES;
    [cell.addTaskScrollViewAmountIconButton addGestureRecognizer:tapGesture];
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGestureAddTaskViewAmountView:)];
    cell.addTaskSelectedViewButtonAmount.userInteractionEnabled = YES;
    [cell.addTaskSelectedViewButtonAmount addGestureRecognizer:tapGesture];
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGestureAddTaskViewListItemsView:)];
    cell.addTaskScrollViewListItemsIconButton.userInteractionEnabled = YES;
    [cell.addTaskScrollViewListItemsIconButton addGestureRecognizer:tapGesture];
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGestureAddTaskViewListItemsView:)];
    cell.addTaskSelectedViewButtonListItems.userInteractionEnabled = YES;
    [cell.addTaskSelectedViewButtonListItems addGestureRecognizer:tapGesture];
    
    //    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGestureAddTaskViewAssignedToView:)];
    //    cell.addTaskScrollViewAssignedToIconButton.userInteractionEnabled = YES;
    //    [cell.addTaskScrollViewAssignedToIconButton addGestureRecognizer:tapGesture];
    //
    //    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGestureAddTaskViewAssignedToView:)];
    //    cell.addTaskSelectedViewButtonAssignedTo.userInteractionEnabled = YES;
    //    [cell.addTaskSelectedViewButtonAssignedTo addGestureRecognizer:tapGesture];
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGestureAddTaskViewXMark:)];
    cell.addTaskSelectedViewXViewTaskList.userInteractionEnabled = YES;
    [cell.addTaskSelectedViewXViewTaskList addGestureRecognizer:tapGesture];
    cell.addTaskSelectedViewXViewTaskList.tag = [[NSString stringWithFormat:@"5%lu", indexPath.row] intValue];
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGestureAddTaskViewXMark:)];
    cell.addTaskSelectedViewXViewRepeats.userInteractionEnabled = YES;
    [cell.addTaskSelectedViewXViewRepeats addGestureRecognizer:tapGesture];
    cell.addTaskSelectedViewXViewRepeats.tag = [[NSString stringWithFormat:@"0%lu", indexPath.row] intValue];
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGestureAddTaskViewXMark:)];
    cell.addTaskSelectedViewXViewPriority.userInteractionEnabled = YES;
    [cell.addTaskSelectedViewXViewPriority addGestureRecognizer:tapGesture];
    cell.addTaskSelectedViewXViewPriority.tag = [[NSString stringWithFormat:@"1%lu", indexPath.row] intValue];
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGestureAddTaskViewXMark:)];
    cell.addTaskSelectedViewXViewTakeTurns.userInteractionEnabled = YES;
    [cell.addTaskSelectedViewXViewTakeTurns addGestureRecognizer:tapGesture];
    cell.addTaskSelectedViewXViewTakeTurns.tag = [[NSString stringWithFormat:@"2%lu", indexPath.row] intValue];
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGestureAddTaskViewXMark:)];
    cell.addTaskSelectedViewXViewAmount.userInteractionEnabled = YES;
    [cell.addTaskSelectedViewXViewAmount addGestureRecognizer:tapGesture];
    cell.addTaskSelectedViewXViewAmount.tag = [[NSString stringWithFormat:@"3%lu", indexPath.row] intValue];
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGestureAddTaskViewXMark:)];
    cell.addTaskSelectedViewXViewListItems.userInteractionEnabled = YES;
    [cell.addTaskSelectedViewXViewListItems addGestureRecognizer:tapGesture];
    cell.addTaskSelectedViewXViewListItems.tag = [[NSString stringWithFormat:@"4%lu", indexPath.row] intValue];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"DidSelect Clicked For %@", currentItemTypeCollection] completionHandler:^(BOOL finished) {
        
    }];
    
    [_searchBar resignFirstResponder];
    
    NSMutableArray *rowsToReload = [NSMutableArray array];
    rowsToReload = [selectedCellsArray mutableCopy];
    [rowsToReload addObject:indexPath];
    
    if ([selectedCellsArray containsObject:indexPath]) {
        [selectedCellsArray removeObject:indexPath];
    } else {
        selectedCellsArray = [NSMutableArray array];
        [selectedCellsArray addObject:indexPath];
    }
    
    [self.customTableView beginUpdates];
    [self.customTableView reloadRowsAtIndexPaths:rowsToReload withRowAnimation:UITableViewRowAnimationFade];
    [self.customTableView endUpdates];
    
    [self AdjustTableViewHeight];
    
    chosenIndexPath = [selectedCellsArray count] > 0 ? selectedCellsArray[0] : nil;
    
    MultiAddTaskCell *cell = [tableView cellForRowAtIndexPath:chosenIndexPath];
    
    [self SetUpAddedTaskContextMenu:cell];
    
    [self SetUpRepeatsContextMenu:cell];
    
    [self SetUpTakeTurnsContextMenu:cell];
    
    [self SetUpPriorityContextMenu:cell];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([selectedCellsArray containsObject:indexPath]) {
        return (self.view.frame.size.height*0.11005435 > 81?(81):self.view.frame.size.height*0.11005435) + (self.view.frame.size.height*0.08245877 > 55?(55):self.view.frame.size.height*0.08245877);
    }
    
    return (self.view.frame.size.height*0.11005435 > 81?(81):self.view.frame.size.height*0.11005435);
}

#pragma mark

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    
    
    
    
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(((width*(1-0.9034))/2), (height*0.02377717 > 17.5?(17.5):height*0.02377717), width*0.9034, (height*0.03736413 > 27.5?(27.5):height*0.03736413))];
    mainView.layer.cornerRadius = 5;
    mainView.backgroundColor = [UIColor clearColor];
    
    
    
    
    
    CGFloat yPos = 0;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, yPos, tableView.frame.size.width, 0)];
    [view setBackgroundColor:self.view.backgroundColor];
    view.tag = section;
    
    
    
    
    
    CGFloat xPos = (width*0.02899 > 12?(12):width*0.02899);
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(xPos, 0, width*0.9034, (height*0.04076087 > 30?(30):height*0.04076087))];
    [label setFont:[UIFont systemFontOfSize:(height*0.02173913 > 16?(16):height*0.02173913) weight:UIFontWeightSemibold]];
    [label setTextAlignment:NSTextAlignmentLeft];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTextPrimary] : [[[LightDarkModeObject alloc] init] LightModeTextPrimary]];
    
    if (Searching == NO) {
        
        if (_viewingAddedTasks) {
            
            [label setText:@""];
            
        } else {
            
            NSMutableArray *specificItemTypeDictOfAllTasks = itemDictKeys && itemDictKeys[currentItemTypeCollection] ? itemDictKeys[currentItemTypeCollection] : [NSMutableArray array];
            NSString *specificItemTypeDictOfAllTasksSpecificSection = specificItemTypeDictOfAllTasks ? specificItemTypeDictOfAllTasks[section] : @"";
            
            if ([(NSArray *)itemDict[currentItemTypeCollection][specificItemTypeDictOfAllTasksSpecificSection] count] > 0) {
                
                [label setText:[NSString stringWithFormat:@"%@", specificItemTypeDictOfAllTasksSpecificSection]];
                
            }
            
        }
        
    } else {
        
        [label setText:[NSString stringWithFormat:@"Search results for \"%@\"", _searchBar.text]];
        
    }
    
    
    
    
    
    
    [view addSubview:mainView];
    [mainView addSubview:label];
    
    
    
    
    
    return view;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger )section {
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    NSMutableArray *specificItemTypeDictOfAllTasks = itemDictKeys && itemDictKeys[currentItemTypeCollection] ? itemDictKeys[currentItemTypeCollection] : [NSMutableArray array];
    NSString *specificItemTypeDictOfAllTasksSpecificSection = specificItemTypeDictOfAllTasks ? specificItemTypeDictOfAllTasks[section] : @"";
    
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    CGFloat heightToUse = 0.1;
    
    if (_viewingAddedTasks) {
        heightToUse = 0.1;
    } else if (Searching == YES) {
        heightToUse = (height*0.0824587 > 55?(55):height*0.0824587);
    } else if ([(NSArray *)itemDict[currentItemTypeCollection][specificItemTypeDictOfAllTasksSpecificSection] count] > 0) {
        heightToUse = (height*0.0824587 > 55?(55):height*0.0824587);
    } else if ([(NSArray *)itemDict[currentItemTypeCollection][specificItemTypeDictOfAllTasksSpecificSection] count] == 0) {
        heightToUse = 0.1;
    }
    
    return heightToUse;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger )section {
    
    return 1.0;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (Searching == NO) {
        
        if (_viewingAddedTasks) {
            
            return itemSelectedDictLocal ? [[itemSelectedDictLocal allKeys] count] : 0;
            
        } else {
            
            return itemDict && itemDict[currentItemTypeCollection] ? [(NSArray *)itemDict[currentItemTypeCollection] count] : 0;
            
        }
        
    }
    
    return 1;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (Searching == NO) {
        
        if (_viewingAddedTasks) {
            
            return @"";
            
        } else {
            
            NSString *key = itemDictKeys && itemDictKeys[currentItemTypeCollection] && [(NSArray *)itemDictKeys[currentItemTypeCollection] count] > section ? itemDictKeys[currentItemTypeCollection][section] : @"";
            
            return key;
            
        }
        
    }
    
    return @"";
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Internal Methods
#pragma mark
#pragma mark
#pragma mark -

#pragma mark SearchAlgolia

-(NSMutableDictionary *)FillDictWithSearchResults:(NSDictionary *)string keyArray:(NSArray *)keyArray {
    
    NSMutableDictionary *tempSearchResults = [NSMutableDictionary dictionary];
    
    for (NSString *key in keyArray) {
        
        NSString *hits = [NSString stringWithFormat:@"hits.%@", key];
        
        if ([string valueForKeyPath:hits] && (NSArray *)[string valueForKeyPath:hits]) {
            
            NSMutableDictionary *tempDict = tempSearchResults ? [tempSearchResults mutableCopy] : [NSMutableDictionary dictionary];
            NSArray *tempArr = (NSArray *)[string valueForKeyPath:hits] ? [(NSArray *)[string valueForKeyPath:hits] mutableCopy] : [NSArray array];
            [tempDict setObject:tempArr forKey:key];
            
            tempSearchResults = [tempDict mutableCopy];
            
        }
        
    }
    
    return tempSearchResults;
}

-(NSMutableDictionary *)ReplaceNullData:(NSMutableDictionary *)tempSearchResults keyArray:(NSArray *)keyArray {
    
    NSMutableDictionary *tempSearchResultsCopy = [tempSearchResults mutableCopy];
    
    for (NSString *key in keyArray) {
        
        NSMutableArray *arr = tempSearchResultsCopy[key] ? [tempSearchResultsCopy[key] mutableCopy] : [NSMutableArray array];
        
        for (int i=0 ; i<[arr count] ; i++) {
            
            id object = arr[i];
            
            if (object == NULL || [[NSString stringWithFormat:@"%@", object] isEqualToString:@"<null>"]) {
                
                if ([arr count] > i) { [arr replaceObjectAtIndex:i withObject:[[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key]]; }
                
            } else if ([key isEqualToString:@"ItemAmount"] && [object containsString:@","]) {
                object = [[[GeneralObject alloc] init] GenerateStringWithReplacementString:object stringToReplace:@"," replacementString:localCurrencyNumberSeparatorSymbol];
            } else if ([key isEqualToString:@"ItemAmount"] && [object containsString:@"."]) {
                object = [[[GeneralObject alloc] init] GenerateStringWithReplacementString:object stringToReplace:@"." replacementString:localCurrencyDecimalSeparatorSymbol];
            }
            
        }
        
        [tempSearchResultsCopy setObject:arr forKey:key];
        
    }
    
    return tempSearchResultsCopy;
}

-(NSMutableDictionary *)ReplaceSearchingDataWithItemDictData:(NSMutableDictionary *)tempSearchResults {
    
    for (NSString *section in self->itemDict[self->currentItemTypeCollection]) {
        
        for (NSDictionary *itemDict in self->itemDict[self->currentItemTypeCollection][section]) {
            
            if ([tempSearchResults[@"ItemSuggestedID"] containsObject:itemDict[@"ItemSuggestedID"]]) {
                
                NSUInteger index = [tempSearchResults[@"ItemSuggestedID"] indexOfObject:itemDict[@"ItemSuggestedID"]];
                
                for (NSString *key in [itemDict allKeys]) {
                    
                    NSMutableArray *arr = tempSearchResults[key] ? [tempSearchResults[key] mutableCopy] : [NSMutableArray array];
                    id object = itemDict[key] ? itemDict[key] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                    if ([arr count] > index) { [arr replaceObjectAtIndex:index withObject:object]; }
                    [tempSearchResults setObject:arr forKey:key];
                    
                }
                
            }
            
        }
        
    }
    
    return tempSearchResults;
}

#pragma mark - Task List Context Menu Actions

-(UIAction *)TaskListItemContextMenuNewTaskListAction:(NSIndexPath *)indexPath {
    
    UIAction *newTaskListAction = [UIAction actionWithTitle:@"New List" image:[UIImage systemImageNamed:@"plus"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"New List Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
            
        }];
        
        [[NSUserDefaults standardUserDefaults] setObject:@{@"indexPathRow" : [NSString stringWithFormat:@"%lu", indexPath.row], @"indexPathSection" : [NSString stringWithFormat:@"%lu", indexPath.section]} forKey:@"MultiAddNewListIndexPath"];
        [[NSUserDefaults standardUserDefaults] setObject:@{@"indexPathRow" : [NSString stringWithFormat:@"%lu", indexPath.row], @"indexPathSection" : [NSString stringWithFormat:@"%lu", indexPath.section]} forKey:@"MultiAddNewListIndexPath_ViewingAddedTasks"];
        
        [[[PushObject alloc] init] PushToViewTaskListsViewController:[self->_folderDict mutableCopy] taskListDict:[self->_taskListDict mutableCopy] itemToEditDict:nil itemUniqueID:@"" comingFromTasksViewController:NO comingFromViewTaskViewController:NO currentViewController:self];
        
    }];
    
    return newTaskListAction;
}

-(UIAction *)TaskListItemContextMenuNoTaskListAction:(NSIndexPath *)indexPath cell:(MultiAddTaskCell *)cell {
    
    UIAction *noTaskListAction = [UIAction actionWithTitle:@"No List" image:[UIImage systemImageNamed:@"nosign"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"No List Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
            
        }];
        
        [self GenerateItemDictSearchingDictAndSelectedDictWithUpdatedData:indexPath key:@"ItemTaskList" object:@"No List"];
        
        [self SetUpTaskListContextMenu:cell];
        
    }];
    
    [noTaskListAction setAttributes:UIMenuElementAttributesDestructive];
    
    return noTaskListAction;
}

#pragma mark - Added Task Context Menu Actions

-(UIAction *)AddedTaskContextMenuEditAction:(NSIndexPath *)indexPath {
    
    UIAction *editAction = [UIAction actionWithTitle:@"Edit" image:[UIImage systemImageNamed:@"pencil"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Edit Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
            
        }];
        
        NSString *taskName =
        [self GenerateObjectToUse:indexPath] != nil &&
        [self GenerateObjectToUse:indexPath] != NULL ?
        [self GenerateObjectToUse:indexPath][@"ItemName"] : @"";
        
        [self AddSearchBarTask:@{@"IndexPath" : indexPath, @"TaskName" : taskName}];
        
    }];
    
    return editAction;
}

-(UIAction *)AddedTaskContextMenuDuplicateAction:(NSIndexPath *)indexPath {
    
    UIAction *duplicateAction = [UIAction actionWithTitle:@"Duplicate" image:[UIImage systemImageNamed:@"doc.on.doc"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Duplicate Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
            
        }];
        
        self->keyArray = [[[GeneralObject alloc] init] GenerateKeyArrayManually:[[[[GeneralObject alloc] init] GenerateItemType] containsString:@"Chore"] Expense:[[[[GeneralObject alloc] init] GenerateItemType] containsString:@"Expense"] List:[[[[GeneralObject alloc] init] GenerateItemType] containsString:@"List"] Home:NO];
        
        NSMutableDictionary *newItemDict = [NSMutableDictionary dictionary];
        NSString *taskName = [self GenerateObjectAtIndexPathForKey:@"ItemName" defaultKey:@"" indexPath:indexPath];
        NSUInteger indexTouse = [self->itemSelectedDictLocal[@"ItemName"] indexOfObject:taskName];
        
        NSString *chosenItemUniqueID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
        NSString *chosenItemID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
        NSString *chosenItemOccurrenceID = @"";
        NSString *chosenItemDatePosted = [[[GeneralObject alloc] init] GenerateCurrentDateString];
        
        for (NSString *key in self->keyArray) {
            
            if ([key isEqualToString:@"ItemName"]) {
                
                NSMutableDictionary *specificItemDictDict = self->itemSelectedDictLocal && self->itemSelectedDictLocal[self->currentItemTypeCollection] ? self->itemSelectedDictLocal[self->currentItemTypeCollection] : [NSMutableDictionary dictionary];
                NSString *taskName = specificItemDictDict && [[specificItemDictDict allKeys] count] > indexTouse ? [specificItemDictDict allKeys][indexTouse] : @"";
                
                id object = specificItemDictDict[taskName][key] ? specificItemDictDict[taskName][key] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                
                NSString *newItemName = [NSString stringWithFormat:@"%@", object];
                
                for (int i=1 ; i<100 ; i++) {
                    
                    if ([self->_itemNamesAlreadyUsed containsObject:newItemName] || [[specificItemDictDict allKeys] containsObject:newItemName]) {
                        
                        for (int k=1 ; k<100 ; k++) {
                            
                            if ([newItemName containsString:[NSString stringWithFormat:@" (%d)", k]]) {
                                
                                newItemName = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:newItemName arrayOfSymbols:@[[NSString stringWithFormat:@" (%d)", k]]];
                                
                                break;
                                
                            }
                        }
                        
                        newItemName = [NSString stringWithFormat:@"%@ (%d)", newItemName, i];
                        
                    } else {
                        
                        break;
                        
                    }
                    
                }
                
                [newItemDict setObject:newItemName forKey:key];
                
            } else if ([key isEqualToString:@"ItemDatePosted"]) {
                
                [newItemDict setObject:chosenItemDatePosted forKey:key];
                
            } else if ([key isEqualToString:@"ItemUniqueID"]) {
                
                [newItemDict setObject:chosenItemUniqueID forKey:key];
                
            } else if ([key isEqualToString:@"ItemID"]) {
                
                [newItemDict setObject:chosenItemID forKey:key];
                
            } else if ([key isEqualToString:@"ItemOccurrenceID"]) {
                
                [newItemDict setObject:chosenItemOccurrenceID forKey:key];
                
            } else if ([key isEqualToString:@"ItemOccurrenceStatus"]) {
                
                [newItemDict setObject:@"None" forKey:key];
                
            } else if ([key isEqualToString:@"ItemStatus"]) {
                
                [newItemDict setObject:@"None" forKey:key];
                
            } else if ([key isEqualToString:@"ItemCompletedDict"]) {
                
                [newItemDict setObject:[NSMutableDictionary dictionary] forKey:key];
                
            } else if ([key isEqualToString:@"ItemInProgressDict"]) {
                
                [newItemDict setObject:[NSMutableDictionary dictionary] forKey:key];
                
            } else {
                
                NSMutableDictionary *specificItemDictDict = self->itemSelectedDictLocal && self->itemSelectedDictLocal[self->currentItemTypeCollection] ? self->itemSelectedDictLocal[self->currentItemTypeCollection] : [NSMutableDictionary dictionary];
                NSString *taskName = specificItemDictDict && [[specificItemDictDict allKeys] count] > indexTouse ? [specificItemDictDict allKeys][indexTouse] : @"";
                
                id object = specificItemDictDict[taskName][key] ? specificItemDictDict[taskName][key] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                
                [newItemDict setObject:object forKey:key];
                
            }
            
        }
        
        NSMutableDictionary *specificItemDictDict = self->itemSelectedDictLocal && self->itemSelectedDictLocal[self->currentItemTypeCollection] ? self->itemSelectedDictLocal[self->currentItemTypeCollection] : [NSMutableDictionary dictionary];
        [specificItemDictDict setObject:newItemDict forKey:newItemDict[@"ItemName"] ? newItemDict[@"ItemName"] : @""];
        [self->itemSelectedDictLocal setObject:specificItemDictDict forKey:self->currentItemTypeCollection];
        
        [self UpdateAddTasksUI:NO];
        
    }];
    
    return duplicateAction;
}

-(UIAction *)AddedTaskContextMenuRemoveAction:(NSIndexPath *)indexPath {
    
    UIAction *deleteAction = [UIAction actionWithTitle:@"Remove" image:[UIImage systemImageNamed:@"minus.circle"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Remove Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
            
        }];
        
        //        NSMutableDictionary *specificItemTypeDictOfSelectedTasks = self->itemSelectedDictLocal[self->currentItemTypeCollection] ? [self->itemSelectedDictLocal[self->currentItemTypeCollection] mutableCopy] : [NSMutableDictionary dictionary];
        
        NSString *taskName = [self GenerateObjectAtIndexPathForKey:@"ItemName" defaultKey:@"" indexPath:indexPath];
        
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Are you sure you would like to remove \"%@\"?", taskName] message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"Remove" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Removing %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
                
            }];
            
        }];
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"RemoveItem Cancelled For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
                
            }];
            
        }]];
        
        [deleteAction setValue:[UIColor systemRedColor] forKey:@"titleTextColor"];
        
        [actionSheet addAction:deleteAction];
        
        [self presentViewController:actionSheet animated:YES completion:nil];
        
    }];
    
    [deleteAction setAttributes:UIMenuElementAttributesDestructive];
    
    return deleteAction;
}


#pragma mark - AddItem

-(void)AddSearchBarTask:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Add Search Bar Task Clicked For %@", currentItemTypeCollection] completionHandler:^(BOOL finished) {
        
    }];
    
    NSMutableDictionary *multiAddDict = [@{@"ItemName" : _searchBar.text, @"ItemAssignedTo" : _homeMembersDict[@"UserID"], @"ItemAssignedToNewHomeMembers" : @"Yes", @"ItemSuggestedID" : [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString], @"ItemRepeats" : @"Never", @"ItemDate" : @"No Due Date", @"ItemTakeTurns" : @"No", @"ItemPriority" : @"No Priority"} mutableCopy];
    
    NSMutableArray *allItemAssignedToArrays = _allItemAssignedToArrays;
    
    NSString *sectionSelected = [[NSUserDefaults standardUserDefaults] objectForKey:@"CategorySelected"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"CategorySelected"] : @"All";
    BOOL ListSelected = [_taskListDict[@"TaskListName"] containsObject:sectionSelected];
    NSString *defaultTaskListName = ListSelected == YES ? sectionSelected : @"No List";
    
    AddingFromSearchBar = YES;
    
    [[[PushObject alloc] init] PushToAddTaskViewController:multiAddDict partiallyAddedDict:nil suggestedItemToAddDict:nil templateToEditDict:nil draftToEditDict:nil moreOptionsDict:nil multiAddDict:nil notificationSettingsDict:_notificationSettingsDict topicDict:_topicDict homeID:[[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] homeMembersArray:_homeMembersArray homeMembersDict:_homeMembersDict itemOccurrencesDict:[NSMutableDictionary dictionary] folderDict:_folderDict taskListDict:_taskListDict templateDict:_templateDict draftDict:_draftDict allItemAssignedToArrays:allItemAssignedToArrays allItemTagsArrays:_allItemTagsArrays allItemIDsArrays:[NSMutableArray array] defaultTaskListName:defaultTaskListName partiallyAddedTask:NO addingTask:NO addingMultipleTasks:YES addingSuggestedTask:NO editingTask:NO viewingTask:NO viewingMoreOptions:NO duplicatingTask:NO editingTemplate:NO viewingTemplate:NO editingDraft:NO viewingDraft:NO currentViewController:self Superficial:NO];
    
}

#pragma mark - MultiAddItems

-(void)MultiAddItems_GenerateGeneralData:(NSDictionary *)setDataDict itemType:(NSString *)itemType {
    
    self->assignedToUsernameArray = [NSMutableArray array];
    
    for (NSString *userID in setDataDict[@"ItemAssignedTo"]) {
        
        if ([_homeMembersDict[@"UserID"] containsObject:userID]) {
            
            NSUInteger index = [_homeMembersDict[@"UserID"] indexOfObject:userID];
            [assignedToUsernameArray addObject:[(NSArray *)_homeMembersDict[@"Username"] count] > index ? _homeMembersDict[@"Username"][index] : @""];
            
        }
        
    }
    
    BOOL TaskHasAnyTime = [[[BoolDataObject alloc] init] TaskHasAnyTime:[setDataDict mutableCopy] itemType:itemType];
    BOOL TaskHasTime = [[[BoolDataObject alloc] init] TaskHasTime:[setDataDict mutableCopy] itemType:itemType];
    
    if (TaskHasTime == YES && TaskHasAnyTime == YES) {
        
        self->AMPMComp = @"PM";
        self->hourComp = @"11";
        self->minuteComp = @"59";
        
    } else if (TaskHasTime == YES && TaskHasAnyTime == NO) {
        
        NSDictionary *timeDict = [[[GeneralObject alloc] init] GenerateItemTime12HourDict:setDataDict[@"ItemTime"]];
        
        self->AMPMComp = timeDict[@"AMPM"];
        self->hourComp = timeDict[@"Hour"];
        self->minuteComp = timeDict[@"Minute"];
        
    }
    
    currentItemType = itemType;
    
}

-(void)MultiAddItems_SetLocalItemData:(NSMutableDictionary *)allSetDataDict setTaskListData_NewTaskListDict:(NSMutableDictionary *)setTaskListData_NewTaskListDict updateTaskListData_OldTaskListDict:(NSMutableDictionary *)updateTaskListData_OldTaskListDict {
    
    [[[GeneralObject alloc] init] CallNSNotificationMethods:@"MultiAddTask" userInfo:@{@"allSetDataDict" : [allSetDataDict mutableCopy], @"setTaskListData_NewTaskListDict" : setTaskListData_NewTaskListDict, @"updateTaskListData_OldTaskListDict" : updateTaskListData_OldTaskListDict} locations:@[@"Tasks", @"Calendar"]];
    
}

-(NSDictionary *)MultiAddItems_SetLocalTaskListData:(NSDictionary *)setDataDict setTaskListData_NewTaskListDict:(NSMutableDictionary *)setTaskListData_NewTaskListDict updateTaskListData_OldTaskListDict:(NSMutableDictionary *)updateTaskListData_OldTaskListDict {
    
    NSString *taskListName = setDataDict[@"ItemTaskList"] ? setDataDict[@"ItemTaskList"] : @"No List";
    
    BOOL TaskListSelected = [taskListName isEqualToString:@"No List"] == NO;
    BOOL TaskListExists =  [_taskListDict[@"TaskListName"] containsObject:taskListName];
    BOOL TaskListExistsInOldTaskListDict =  [updateTaskListData_OldTaskListDict[@"TaskListName"] containsObject:taskListName];
    BOOL TaskListExistsInNewTaskListDict =  [setTaskListData_NewTaskListDict[@"TaskListName"] containsObject:taskListName];
    
    if (TaskListSelected == YES && TaskListExists == YES && TaskListExistsInNewTaskListDict == NO && TaskListExistsInOldTaskListDict == NO) {
       
        return [self MultiAddItems_SetLocalTaskListData_AddTaskToExistingTaskList:taskListName setDataDict:setDataDict setTaskListData_NewTaskListDict:setTaskListData_NewTaskListDict updateTaskListData_OldTaskListDict:updateTaskListData_OldTaskListDict];
        
    } else if (TaskListSelected == YES && (TaskListExistsInNewTaskListDict == YES || TaskListExistsInOldTaskListDict == YES)) {
       
        return [self MultiAddItems_SetLocalTaskListData_AddTaskToExistingTaskListInLocalTaskListDict:taskListName setDataDict:setDataDict setTaskListData_NewTaskListDict:setTaskListData_NewTaskListDict updateTaskListData_OldTaskListDict:updateTaskListData_OldTaskListDict AddToNewTaskListDict:TaskListExistsInNewTaskListDict AddToOldTaskListDict:TaskListExistsInOldTaskListDict];
        
    } else if (TaskListSelected == YES && TaskListExists == NO && TaskListExistsInNewTaskListDict == NO) {
       
        return [self MultiAddItems_SetLocalTaskListData_AddTaskToNewTaskList:taskListName setDataDict:setDataDict setTaskListData_NewTaskListDict:setTaskListData_NewTaskListDict updateTaskListData_OldTaskListDict:updateTaskListData_OldTaskListDict];
        
    } else {
       
        return @{@"setTaskListData_NewTaskListDict" : setTaskListData_NewTaskListDict, @"updateTaskListData_OldTaskListDict" : updateTaskListData_OldTaskListDict};
        
    }
    
}

#pragma mark

-(void)MultiAddItems_PushNotificationOrScheduledStartNotifications:(NSDictionary *)setDataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *itemType = currentItemType;
    NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
    NSString *notificationTitle = [NSString stringWithFormat:@"\"%@\"", setDataDict[@"ItemName"]];
    NSString *pushNotificationBody = [[[NotificationsObject alloc] init] GeneratePushNotificationAddItemBody:YES EditItem:NO DeleteItem:NO NotificationItem:NO NobodyAssigned:NO userIDArray:setDataDict[@"ItemAssignedTo"]];
    NSString *notificationBody = [[[NotificationsObject alloc] init] GeneratePushNotificationAddItemBody:YES EditItem:NO DeleteItem:NO NotificationItem:YES NobodyAssigned:NO userIDArray:setDataDict[@"ItemAssignedTo"]];
    
    if ([setDataDict[@"ItemTakeTurns"] isEqualToString:@"Yes"] && [setDataDict[@"ItemTurnUserID"] length] > 0) {
        NSDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:setDataDict[@"ItemTurnUserID"] homeMembersDict:_homeMembersDict];
        NSString *itemTurnUsername = dataDict[@"Username"];
        pushNotificationBody = [NSString stringWithFormat:@"%@ It's %@'s turn to complete this %@.", pushNotificationBody, itemTurnUsername, [itemType lowercaseString]];
    }
    
    NSString *notificationType = [[[NotificationsObject alloc] init] NotificationSettingsUnknownItemType_Adding:YES Editing:NO Deleting:NO Duplicating:NO Waiving:NO Skipping:NO Pausing:NO Comments:NO
                                                                                                   SkippingTurn:NO RemovingUser:NO
                                                                                                 FullyCompleted:NO Completed:NO InProgress:NO WontDo:NO Accept:NO Decline:NO
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
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        BOOL TaskIsScheduledStart = [[[BoolDataObject alloc] init] TaskIsScheduledStart:[setDataDict mutableCopy] itemType:itemType];
        
        if (TaskIsScheduledStart == NO) {
            
            NSMutableArray *usersToSendNotificationTo = [setDataDict[@"ItemAssignedTo"] mutableCopy];
            
            NSArray *addTheseUsers = @[setDataDict[@"ItemCreatedBy"]];
            NSArray *removeTheseUsers = @[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx"];
            
            usersToSendNotificationTo = [[[[NotificationsObject alloc] init] AddAndRemoveSpecificUsersFromArray:usersToSendNotificationTo addTheseUsers:addTheseUsers removeTheseUsers:removeTheseUsers] mutableCopy];
            
            [[[NotificationsObject alloc] init] SendPushNotificationToArrayOfUsers_Items:usersToSendNotificationTo
                                                                               dictToUse:[setDataDict mutableCopy]
                                                                                  homeID:homeID homeMembersArray:self->_homeMembersArray homeMembersDict:self->_homeMembersDict
                                                                notificationSettingsDict:self->_notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType
                                                                               topicDict:self->_topicDict
                                                                       allItemTagsArrays:self->_allItemTagsArrays
                                                                   pushNotificationTitle:notificationTitle pushNotificationBody:pushNotificationBody
                                                                       notificationTitle:notificationTitle notificationBody:notificationBody
                                                                 SetDataHomeNotification:YES
                                                                    RemoveUsersNotInHome:YES
                                                                       completionHandler:^(BOOL finished) {
                
                finishBlock(YES);
                
            }];
            
        } else {
            
            NSString *itemCreatedBy = setDataDict[@"ItemCreatedBy"] ? setDataDict[@"ItemCreatedBy"] : @"";
            NSMutableArray *itemAssignedTo = setDataDict[@"ItemAssignedTo"] ? setDataDict[@"ItemAssignedTo"] : [NSMutableArray array];
            
            NSMutableArray *userIDArray = [itemAssignedTo mutableCopy];
            NSMutableArray *userIDToRemoveArray = [NSMutableArray array];
            
            [userIDArray addObject:itemCreatedBy];
            
            [[[NotificationsObject alloc] init] ResetLocalNotificationScheduledStartNotifications:[setDataDict mutableCopy] itemType:itemType userIDArray:userIDArray userIDToRemoveArray:userIDToRemoveArray  allItemTagsArrays:self->_allItemTagsArrays homeMembersArray:self->_homeMembersArray homeMembersDict:self->_homeMembersDict notificationSettingsDict:self->_notificationSettingsDict topicDict:self->_topicDict completionHandler:^(BOOL finished) {
                
                finishBlock(YES);
                
            }];
            
        }
        
    });
    
}

-(void)MultiAddItems_ResetItemNotifications:(NSDictionary *)setDataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *itemCreatedBy = setDataDict[@"ItemCreatedBy"] ? setDataDict[@"ItemCreatedBy"] : @"";
    NSMutableArray *itemAssignedTo = setDataDict[@"ItemAssignedTo"] ? [setDataDict[@"ItemAssignedTo"] mutableCopy] : [NSMutableArray array];
    
    NSString *notificationType = [[[NotificationsObject alloc] init] NotificationSettingsUnknownItemType_Adding:YES Editing:NO Deleting:NO Duplicating:NO Waiving:NO Skipping:NO Pausing:NO Comments:NO
                                                                                                   SkippingTurn:NO RemovingUser:NO
                                                                                                 FullyCompleted:NO Completed:NO InProgress:NO WontDo:NO Accept:NO Decline:NO
                                                                                                        DueDate:NO Reminder:NO
                                                                                                 SubtaskEditing:NO SubtaskDeleting:NO
                                                                                               SubtaskCompleted:NO SubtaskInProgress:NO SubtaskWontDo:NO SubtaskAccept:NO SubtaskDecline:NO
                                                                                                 AddingListItem:NO EditingListItem:NO DeletingListItem:NO ResetingListItem:NO
                                                                                            EditingItemizedItem:NO DeletingItemizedItem:NO
                                                                                              GroupChatMessages:NO LiveSupportMessages:NO
                                                                                             SendingInvitations:NO DeletingInvitations:NO NewHomeMembers:NO HomeMembersMovedOut:NO HomeMembersKickedOut:NO
                                                                                            FeatureForumUpvotes:NO BugForumUpvotes:NO
                                                                                                       itemType:self->currentItemType];
    
    NSMutableArray *userIDArray = [itemAssignedTo mutableCopy];
    NSMutableArray *userIDToRemoveArray = [NSMutableArray array];
    
    [userIDArray addObject:itemCreatedBy];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[NotificationsObject alloc] init] ResetLocalNotificationReminderNotification:[setDataDict mutableCopy] homeMembersDict:self->_homeMembersDict userIDArray:userIDArray userIDToRemoveArray:userIDToRemoveArray notificationSettingsDict:self->_notificationSettingsDict allItemTagsArrays:self->_allItemTagsArrays itemType:self->currentItemType notificationType:notificationType topicDict:self->_topicDict completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)MultiAddItems_SetTopicData:(NSDictionary *)setDataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
        NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"";
        
        NSDictionary *dataDict = @{@"TopicID" : setDataDict[@"ItemID"], @"TopicCreatedBy" : userID, @"TopicSubscribedTo" : @[userID], @"TopicAssignedTo" : setDataDict[@"ItemAssignedTo"], @"TopicDateCreated" : setDataDict[@"ItemDatePosted"], @"TopicDeleted" : @"No"};
      
        [[[SetDataObject alloc] init] SubscribeAndSetDataTopic:homeID topicID:setDataDict[@"ItemID"] dataDict:dataDict completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)MultiAddItems_SetItemData:(NSDictionary *)setDataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *collection = self->currentItemTypeCollection;
        NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"];
        
        [[[SetDataObject alloc] init] SetDataAddItem:setDataDict collection:collection homeID:homeID completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)MultiAddItems_SetImageData:(NSDictionary *)setDataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        UIImage *itemImageImage = [UIImage imageWithData:setDataDict[@"ItemImageData"]];
        NSData *imgData = UIImageJPEGRepresentation(itemImageImage, 0.15);
        
        if (imgData != nil) {
            
            [[[SetDataObject alloc] init] SetDataItemImage:setDataDict[@"ItemUniqueID"] itemType:self->currentItemType imgData:imgData completionHandler:^(BOOL finished) {
                
                finishBlock(YES);
                
            }];
            
        } else {
            
            finishBlock(YES);
            
        }
        
    });
    
}

-(void)MultiAddItems_SetTaskListData:(NSMutableDictionary *)setTaskListData_NewTaskListDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    if ([(NSArray *)setTaskListData_NewTaskListDict[@"TaskListID"] count] == 0) {
        
        finishBlock(YES);
        
    }
    
    for (NSString *taskListID in setTaskListData_NewTaskListDict[@"TaskListID"]) {
        
        NSUInteger index = [setTaskListData_NewTaskListDict[@"TaskListID"] indexOfObject:taskListID];
        
        NSMutableDictionary *setDataDict = [[[GeneralObject alloc] init] GenerateSingleObjectDictionary:setTaskListData_NewTaskListDict keyArray:[setTaskListData_NewTaskListDict allKeys] indexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        
        NSString *itemTaskList = setDataDict[@"TaskListName"] ? setDataDict[@"TaskListName"] : @"No List";
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            BOOL TaskListSeleted = [itemTaskList isEqualToString:@"No List"] == NO;
            
            if (TaskListSeleted == YES) {
                
                [[[SetDataObject alloc] init] SetDataAddTaskList:setDataDict[@"TaskListCreatedBy"] taskListID:setDataDict[@"TaskListID"] dataDict:setDataDict completionHandler:^(BOOL finished) {
                    
                    finishBlock(YES);
                    
                }];
                
            } else {
                
                finishBlock(YES);
                
            }
            
        });
        
    }
    
}

-(void)MultiAddItems_UpdateTaskListData:(NSMutableDictionary *)updateTaskListData_OldTaskListDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    if ([[updateTaskListData_OldTaskListDict allKeys] count] == 0) {
        
        finishBlock(YES);
        
    }
    
    for (NSString *taskListID in updateTaskListData_OldTaskListDict[@"TaskListID"]) {
        
        NSUInteger index = [updateTaskListData_OldTaskListDict[@"TaskListID"] indexOfObject:taskListID];
        
        NSMutableDictionary *setDataDict = [[[GeneralObject alloc] init] GenerateSingleObjectDictionary:updateTaskListData_OldTaskListDict keyArray:[updateTaskListData_OldTaskListDict allKeys] indexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        
        NSString *itemTaskList = setDataDict[@"TaskListName"] ? setDataDict[@"TaskListName"] : @"No List";
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            BOOL TaskListSeleted = [itemTaskList isEqualToString:@"No List"] == NO;
            
            if (TaskListSeleted == YES) {
                
                [[[SetDataObject alloc] init] UpdateDataTaskList:setDataDict[@"TaskListCreatedBy"] taskListID:setDataDict[@"TaskListID"] dataDict:setDataDict completionHandler:^(BOOL finished) {
                    
                    finishBlock(YES);
                    
                }];
                
            } else {
                
                finishBlock(YES);
                
            }
            
        });
        
    }
    
}

-(void)MultiAddItems_SetItemAndHomeActivity:(NSDictionary *)setDataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *itemType = self->currentItemType;
        NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"";
        
        NSString *activityAction = @"Adding Task";
        NSString *userTitle = [NSString stringWithFormat:@"%@ created a %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"], [itemType lowercaseString]];
        NSString *itemTitle = [NSString stringWithFormat:@"%@ created this %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"], [itemType lowercaseString]];
        NSString *itemDescription = [NSString stringWithFormat:@"\"%@\" was created", setDataDict[@"ItemName"]];
        
        NSMutableDictionary *itemActivityDict = [[[SetDataObject alloc] init] GenerateItemActivityDict:setDataDict[@"ItemID"] itemOccurrenceID:setDataDict[@"ItemOccurrenceID"] activityUserIDNo1:@"" homeID:homeID activityAction:activityAction userTitle:userTitle userDescription:itemDescription itemType:itemType];
        NSMutableDictionary *homeActivityDict = [[[SetDataObject alloc] init] GenerateHomeActivityDict:@"" homeID:homeID activityAction:activityAction itemTitle:itemTitle itemDescription:itemDescription itemType:itemType];
        
        [[[SetDataObject alloc] init] SetDataHomeAndItemActivity:itemActivityDict homeActivityDict:homeActivityDict completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

#pragma mark

-(void)MultiAddItems_CompletionBlock:(int)totalQueries completedQueries:(int)completedQueries setTaskListData_NewTaskListDict:(NSMutableDictionary *)setTaskListData_NewTaskListDict updateTaskListData_OldTaskListDict:(NSMutableDictionary *)updateTaskListData_OldTaskListDict allSetDataDict:(NSMutableDictionary *)allSetDataDict {
   
    if (totalQueries == completedQueries) {
       
        self->completedQueries = 0;
        self->completedTasksAdded += 1;
        
        [self MultiAddItems_UpdateProgressView];
       
        if (self->totalTasksAdded == self->completedTasksAdded) {
            
            [self MultiAddItems_UpdateProgressView];
          
            [self MultiAddItems_SetLocalItemData:allSetDataDict setTaskListData_NewTaskListDict:setTaskListData_NewTaskListDict updateTaskListData_OldTaskListDict:updateTaskListData_OldTaskListDict];
           
            __block int totalQueries = 2;
            __block int completedQueries = 0;
            
            
            
            /*
             //
             //
             //Set Task List Data
             //
             //
             */
            [self MultiAddItems_SetTaskListData:setTaskListData_NewTaskListDict completionHandler:^(BOOL finished) {
                
                [self MultiAddItems_CompletionBlockNo1:totalQueries completedQueries:(completedQueries+=1)];
                
            }];
            
            
            /*
             //
             //
             //Update Task List Data
             //
             //
             */
            [self MultiAddItems_UpdateTaskListData:updateTaskListData_OldTaskListDict completionHandler:^(BOOL finished) {
                
                [self MultiAddItems_CompletionBlockNo1:totalQueries completedQueries:(completedQueries+=1)];
                
            }];
            
        }
        
    }
    
}

-(void)MultiAddItems_CompletionBlockNo1:(int)totalQueries completedQueries:(int)completedQueries {
    
    if (totalQueries == (completedQueries+=1)) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self NSNotificationObservers:YES];
            
            [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"ViewDidLoadShouldStart"];
            [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"RegisterForNotifications"];
            
            [self MultiAddItems_IncreaseCountForAlertViewPopup];
            
            [self->progressView setHidden:YES];
            
            [[[GeneralObject alloc] init] CallNSNotificationMethods:@"RemoveNotificationObservers" userInfo:@{} locations:@[@"MultiAddTasks"]];
            
            [[[PushObject alloc] init] PushToTasksNavigationController:[self->currentItemType isEqualToString:@"Chore"] Expenses:[self->currentItemType isEqualToString:@"Expense"] Lists:[self->currentItemType isEqualToString:@"List"] Animated:YES currentViewController:self];
            
        });
        
    }
    
}

#pragma mark

//-(NSMutableArray *)GenerateItemAssignedTo:(NSString *)itemRandomizeTurnOrder itemAssignedTo:(NSString *)itemAssignedTo {
//
//    NSMutableArray *userIDArray = [NSMutableArray array];
//    NSString *itemAssignedToTextFieldText = itemAssignedTo ? itemAssignedTo : @"";
//    BOOL IsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:itemAssignedToTextFieldText classArr:@[[NSString class]]];
//
//
//
//    NSArray *assignedToArray = IsKindOfClass == YES && [itemAssignedToTextFieldText containsString:@", "] ? [[itemAssignedToTextFieldText mutableCopy] componentsSeparatedByString:@", "] : [NSMutableArray array];
//
//    for (NSString *username in assignedToArray) {
//
//        NSDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"Username" object:username homeMembersDict:_homeMembersDict];
//        NSString *userID = dataDict[@"UserID"];
//
//        if ([userID length] > 0) {
//            [userIDArray addObject:userID];
//        }
//
//    }
//
//
//
//    BOOL TaskIsAssignedToEverybody = IsKindOfClass == YES && [itemAssignedToTextFieldText isEqualToString:@"Everybody"];
//
//    if (TaskIsAssignedToEverybody == YES) {
//        userIDArray = _homeMembersDict && _homeMembersDict[@"UserID"] ? [_homeMembersDict[@"UserID"] mutableCopy] : [NSMutableArray array];
//    }
//
//
//
//    BOOL TaskIsAssignedToMyself = ((userIDArray.count == 0 || userIDArray.count == 1) && IsKindOfClass == YES && [itemAssignedToTextFieldText isEqualToString:@"Myself"]);
//
//    if (TaskIsAssignedToMyself == YES) {
//        userIDArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [@[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] mutableCopy] : [NSMutableArray array];
//    }
//
//
//
//    BOOL TaskIsAssignedToAnybody = (IsKindOfClass == YES && [itemAssignedToTextFieldText isEqualToString:@"Anybody"] == YES);
//
//    if (TaskIsAssignedToAnybody == YES) {
//        userIDArray = _homeMembersDict && _homeMembersDict[@"UserID"] ? [_homeMembersDict[@"UserID"] mutableCopy] : [NSMutableArray array];
//    }
//
//
//
//    BOOL TaskIsAssignedToNobody = IsKindOfClass == YES && ([itemAssignedToTextFieldText isEqualToString:@"Nobody"] == YES || [itemAssignedToTextFieldText isEqualToString:@""] == YES);
//
//    if (TaskIsAssignedToNobody == YES) {
//        userIDArray = [NSMutableArray array];
//    }
//
//
//
//    NSMutableArray *arrayWithoutDuplicates = [[[GeneralObject alloc] init] RemoveDupliatesFromArray:userIDArray];
//
//    if ([itemRandomizeTurnOrder isEqualToString:@"Yes"] && arrayWithoutDuplicates.count > 1) {
//
//        NSDictionary *dict = [[[SetDataObject alloc] init] GenerateComplicatedRandomArray:arrayWithoutDuplicates homeMembersDict:_homeMembersDict allItemAssignedToArrays:_allItemAssignedToArrays];
//        arrayWithoutDuplicates = dict[@"UserIDArray"] ? [dict[@"UserIDArray"] mutableCopy] : [NSMutableArray array];
//
//    }
//
//    return arrayWithoutDuplicates;
//
//}
//
//-(NSString *)GenerateItemAssignedToNewHomeMembers:(NSIndexPath *)indexPath {
//
//    NSString *itemAssignedToNewHomeMembers = [self GenerateObjectAtIndexPathForKey:@"ItemAssigedToNewHomeMembers" defaultKey:@"Yes" indexPath:indexPath];
//
//    return itemAssignedToNewHomeMembers;
//
//}
//
//-(NSString *)GenerateItemAssignedToAnybody:(NSIndexPath *)indexPath {
//
//    NSString *itemAssignedTo = [self GenerateObjectAtIndexPathForKey:@"ItemAssignedTo" defaultKey:@"Everybody" indexPath:indexPath];
//
//    BOOL IsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:itemAssignedTo classArr:@[[NSString class]]];
//
//    return IsKindOfClass == YES && [itemAssignedTo isEqualToString:@"Anybody"] ? @"Yes" : @"No";
//
//}

-(NSString *)GenerateItemStartDate {
    
    NSString *startDate = @"Now";
    NSString *dateFormat = @"MMMM dd, yyyy";
    
    if ([[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:startDate returnAs:[NSDate class]] == nil && startDate.length != 0 && [startDate isEqualToString:@"Now"] == NO) {
        dateFormat = @"MMMM dd, yyyy";
    }
    
    if (startDate.length == 0 || [startDate isEqualToString:@"Now"] || [[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:startDate returnAs:[NSDate class]] == nil) {
        
        startDate = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:@"MMMM dd, yyyy" returnAs:[NSString class]];
        
    }
    
    NSArray *dateArr = [startDate componentsSeparatedByString:@" "];
    
    NSString *month = [dateArr count] > 0 ? dateArr[0] : @"";
    NSString *day = [dateArr count] > 1 ? dateArr[1] : @"";
    NSString *year = [dateArr count] > 2 ? dateArr[2] : @"";
    
    startDate = [NSString stringWithFormat:@"%@ %@ %@ 12:00 AM", month, day, year];
    
    return startDate;
    
}

-(NSString *)GenerateItemEndDate {
    
    NSString *endDate = @"Never";
    NSString *dateFormat = @"MMMM dd, yyyy";
    
    NSDate *endDateConvertedToDateFormat = [[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:endDate returnAs:[NSDate class]];
    
    if (endDateConvertedToDateFormat == nil &&
        endDate.length != 0 &&
        [endDate isEqualToString:@"Never"] == NO) {
        
        dateFormat = @"MMMM dd, yyyy";
        
    }
    
    endDateConvertedToDateFormat = [[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:endDate returnAs:[NSDate class]];
    
    if (endDate.length != 0 && [endDate isEqualToString:@"Never"] == NO && endDateConvertedToDateFormat != nil) {
        
        NSArray *dateArr = [endDate componentsSeparatedByString:@" "];
        
        NSString *month = [dateArr count] > 0 ? dateArr[0] : @"";
        NSString *day = [dateArr count] > 1 ? dateArr[1] : @"";
        NSString *year = [dateArr count] > 2 ? dateArr[2] : @"";
        
        endDate = [NSString stringWithFormat:@"%@ %@ %@ 11:59 PM", month, day, year];
        
    }
    
    return endDate;
    
}

-(NSString *)GenerateItemDueDate:(NSString *)itemRepeats itemTime:(NSString *)itemTime itemDays:(NSString *)itemDays itemDueDate:(NSString *)itemDueDate itemRepeatIfCompletedEarly:(NSString *)itemRepeatIfCompletedEarly itemCompleteAsNeeded:(NSString *)itemCompleteAsNeeded itemDueDatesSkipped:(NSMutableArray *)itemDueDatesSkipped itemDateLastReset:(NSString *)itemDateLastReset chosenItemDatePosted:(NSString *)chosenItemDatePosted {
    
    itemDueDate = [[[GeneralObject alloc] init] GenerateStringWithReplacementString:itemDueDate stringToReplace:@"Any Time" replacementString:@"11:59 PM"];
    
    BOOL TaskIsRepeating = [[[BoolDataObject alloc] init] TaskIsRepeating:[@{@"ItemRepeats" : itemRepeats, @"ItemRepeatIfCompletedEarly" : itemRepeatIfCompletedEarly} mutableCopy] itemType:currentItemType];
    
    if (TaskIsRepeating == YES) {
        
        NSString *itemDatePosted = chosenItemDatePosted;
        NSString *dateFormat = @"MMMM dd, yyyy hh:mm a";
        
        if ([[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:itemDatePosted returnAs:[NSDate class]] == nil) {
            itemDatePosted = [[[GeneralObject alloc] init] GenerateDateWithConvertedFormatWithFormat:@"yyyy-MM-dd HH:mm:ss" dateToConvert:itemDatePosted newFormat:dateFormat returnAs:[NSString class]];
        }
        
        NSString *itemStartDate = [self GenerateItemStartDate];
        NSString *itemEndDate = [self GenerateItemEndDate];
        
        BOOL EditingTaskWithoutAlteringDueDateData = NO;
        
        [[NSUserDefaults standardUserDefaults] setObject:EditingTaskWithoutAlteringDueDateData ? @"Yes" : @"No" forKey:@"EditingTaskWithoutAlteringDueDateData"];
        [[NSUserDefaults standardUserDefaults] setObject:EditingTaskWithoutAlteringDueDateData ? @"Yes" : @"No" forKey:@"EditingTaskWithoutAlteringDueDateData1"];
        [[NSUserDefaults standardUserDefaults] setObject:EditingTaskWithoutAlteringDueDateData == NO ? @"Yes" : @"No" forKey:@"AddingTaskForTheFirstTime1"];
        
        //First Iteration Should Always Be Equal To YES Here Because It Will Look For The First Future Due Date Even If The First Future Due Date Is The Current Item Due Date
        //If First Iteration Is Equal To NO It Will Ignore The First Future Due Date If It Happens To Be The Current Item Due Date
        NSLog(@"testing %@ing1 itemDatePosted:%@ itemDays:%@", @"Add", itemDatePosted, itemDays);
        NSString *newItemDueDate = [[[NotificationsObject alloc] init] GenerateArrayOfRepeatingDueDates:itemRepeats itemRepeatIfCompletedEarly:itemRepeatIfCompletedEarly itemCompleteAsNeeded:itemCompleteAsNeeded totalAmountOfFutureDates:2 maxAmountOfDueDatesToLoopThrough:1000 itemDatePosted:itemDatePosted itemDueDate:itemDueDate itemStartDate:itemStartDate itemEndDate:itemEndDate itemTime:itemTime itemDays:itemDays itemDueDatesSkipped:itemDueDatesSkipped itemDateLastReset:itemDateLastReset SkipStartDate:NO][0];
        NSLog(@"testing %@ing2 newItemDueDate:%@", @"Add", newItemDueDate);
        
        newItemDueDate = [[[GeneralObject alloc] init] GenerateStringWithReplacementString:newItemDueDate stringToReplace:@"Any Time" replacementString:@"11:59 PM"];
        
        if ([newItemDueDate isEqualToString:itemDatePosted] && itemDueDate.length > 0 && itemDueDate != nil && itemDueDate != NULL && [itemDueDate containsString:@"(null)"] == NO) {
            newItemDueDate = itemDueDate;
        }
        
        newItemDueDate = [[[GeneralObject alloc] init] GenerateStringWithReplacementString:newItemDueDate stringToReplace:@"Any Time" replacementString:@"11:59 PM"];
        
        return newItemDueDate;
        
    }
    //    else if ([chosenItemDueDate isEqualToString:@"Today"]) {
    //
    //        NSString *dateStringCurrent = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:@"MMMM dd, yyyy" returnAs:[NSString class]];
    //
    //        return [NSString stringWithFormat:@"%@ 11:59 PM", dateStringCurrent];
    //
    //    } else if ([chosenItemDueDate isEqualToString:@"Tomorrow"]) {
    //
    //        NSString *dateStringCurrentDate = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:@"MMMM dd, yyyy" returnAs:[NSDate class]];
    //        NSString *dateStringCurrentDateWeekBefore = [[[GeneralObject alloc] init] GenerateDateWithAddedTimeWithFormat:@"MMMM dd, yyyy" dateToAddTimeTo:dateStringCurrentDate timeToAdd:60*60*24 returnAs:[NSString class]];
    //
    //        return [NSString stringWithFormat:@"%@ 11:59 PM", dateStringCurrentDateWeekBefore];
    //
    //    } else if ([chosenItemDueDate isEqualToString:@"End of Week"]) {
    //
    //        NSDate *currentDate = [NSDate date];
    //        NSCalendar *calendar = [NSCalendar currentCalendar];
    //        NSDateComponents *components = [calendar components:(NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:currentDate];
    //        int daysRemainingUntilSunday = ((7 - (int)components.weekday) % 7) + 1;
    //
    //        if ((int)components.weekday == 1) {
    //            daysRemainingUntilSunday = 0;
    //        }
    //
    //        NSString *dateStringCurrentDate = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:@"MMMM dd, yyyy" returnAs:[NSDate class]];
    //        NSString *dateStringCurrentDateWeekBefore = [[[GeneralObject alloc] init] GenerateDateWithAddedTimeWithFormat:@"MMMM dd, yyyy" dateToAddTimeTo:dateStringCurrentDate timeToAdd:60*60*24*daysRemainingUntilSunday returnAs:[NSString class]];
    //
    //        return [NSString stringWithFormat:@"%@ 11:59 PM", dateStringCurrentDateWeekBefore];
    //
    //    } else if ([chosenItemDueDate isEqualToString:@"Next Week"]) {
    //
    //        NSDate *currentDate = [NSDate date];
    //        NSCalendar *calendar = [NSCalendar currentCalendar];
    //        NSDateComponents *components = [calendar components:(NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:currentDate];
    //        int daysRemainingUntilSunday = (((7 - (int)components.weekday) % 7) + 1) + 7;
    //
    //        if ((int)components.weekday == 1) {
    //            daysRemainingUntilSunday = 0+7;
    //        }
    //
    //        NSString *dateStringCurrentDate = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:@"MMMM dd, yyyy" returnAs:[NSDate class]];
    //        NSString *dateStringCurrentDateWeekBefore = [[[GeneralObject alloc] init] GenerateDateWithAddedTimeWithFormat:@"MMMM dd, yyyy" dateToAddTimeTo:dateStringCurrentDate timeToAdd:60*60*24*daysRemainingUntilSunday returnAs:[NSString class]];
    //
    //        return [NSString stringWithFormat:@"%@ 11:59 PM", dateStringCurrentDateWeekBefore];
    //
    //    } else if ([chosenItemDueDate isEqualToString:@"End of Month"]) {
    //
    //        NSDate *currentDate = [NSDate date];
    //        NSCalendar *calendar = [NSCalendar currentCalendar];
    //        NSDateComponents *components = [calendar components:(NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:currentDate];
    //        int numberOfDaysInMonth = [[[NotificationsObject alloc] init] GetMonthDayAmountFromMonthNumber:components.month];
    //
    //        int daysRemainingUntilSunday = ((numberOfDaysInMonth - (int)components.day) % numberOfDaysInMonth);
    //
    //        if ((int)components.day == numberOfDaysInMonth) {
    //            daysRemainingUntilSunday = 0;
    //        }
    //
    //        NSString *dateStringCurrentDate = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:@"MMMM dd, yyyy" returnAs:[NSDate class]];
    //        NSString *dateStringCurrentDateWeekBefore = [[[GeneralObject alloc] init] GenerateDateWithAddedTimeWithFormat:@"MMMM dd, yyyy" dateToAddTimeTo:dateStringCurrentDate timeToAdd:60*60*24*daysRemainingUntilSunday returnAs:[NSString class]];
    //
    //        return [NSString stringWithFormat:@"%@ 11:59 PM", dateStringCurrentDateWeekBefore];
    //
    //    } else if ([chosenItemDueDate isEqualToString:@"Next Month"]) {
    //
    //        NSDate *currentDate = [NSDate date];
    //        NSCalendar *calendar = [NSCalendar currentCalendar];
    //        NSDateComponents *components = [calendar components:(NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:currentDate];
    //        int numberOfDaysInMonth = [[[NotificationsObject alloc] init] GetMonthDayAmountFromMonthNumber:components.month];
    //
    //        int numberOfDaysInNextMonth = 0;
    //
    //        if (components.month == 12) {
    //            numberOfDaysInNextMonth = [[[NotificationsObject alloc] init] GetMonthDayAmountFromMonthNumber:1];
    //        } else {
    //            numberOfDaysInNextMonth = [[[NotificationsObject alloc] init] GetMonthDayAmountFromMonthNumber:components.month+1];
    //        }
    //
    //        int daysRemainingUntilSunday = (((numberOfDaysInMonth - (int)components.day) % numberOfDaysInMonth)) + numberOfDaysInNextMonth;
    //
    //        if ((int)components.day == numberOfDaysInMonth) {
    //            daysRemainingUntilSunday = 0+numberOfDaysInNextMonth;
    //        }
    //
    //        NSString *dateStringCurrentDate = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:@"MMMM dd, yyyy" returnAs:[NSDate class]];
    //        NSString *dateStringCurrentDateWeekBefore = [[[GeneralObject alloc] init] GenerateDateWithAddedTimeWithFormat:@"MMMM dd, yyyy" dateToAddTimeTo:dateStringCurrentDate timeToAdd:60*60*24*daysRemainingUntilSunday returnAs:[NSString class]];
    //
    //        return [NSString stringWithFormat:@"%@ 11:59 PM", dateStringCurrentDateWeekBefore];
    //
    //    } else if ([itemDueDate containsString:@"AM"] || [itemDueDate containsString:@"PM"]) {
    //
    //        return itemDueDate;
    //
    //    }
    
    
    
    return @"No Due Date";
    
}

-(NSDictionary *)GenerateItemCostPerPerson:(NSString *)itemAmountLocal itemAssignedToArrayLocal:(NSMutableArray *)itemAssignedToArrayLocal {
    
    NSMutableDictionary *itemCostPerPerson = [NSMutableDictionary dictionary];
    
    if ([currentItemType isEqualToString:@"Expense"] == NO) {
        return itemCostPerPerson;
    }
    
    for (NSString *userID in itemAssignedToArrayLocal) {
        
        NSString *itemAmountTextFieldText = itemAmountLocal;
        itemAmountTextFieldText = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:itemAmountTextFieldText arrayOfSymbols:@[localCurrencyNumberSeparatorSymbol, localCurrencySymbol]];
        
        float itemAmountDivided = [itemAmountTextFieldText floatValue]/itemAssignedToArrayLocal.count;
        NSString *itemAmountDividedString = [NSString stringWithFormat:@"%.2f", itemAmountDivided];
        
        itemAmountDividedString = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:itemAmountDividedString arrayOfSymbols:@[localCurrencyDecimalSeparatorSymbol, localCurrencyNumberSeparatorSymbol, localCurrencySymbol]];
        itemAmountDividedString = [[[GeneralObject alloc] init] GenerateAmountInTextFieldInProperFormat:NSRangeFromString(itemAmountDividedString) replacementString:itemAmountDividedString];
        
        [itemCostPerPerson setObject:itemAmountDividedString forKey:userID];
        
    }
    
    return itemCostPerPerson;
}

-(NSDictionary *)GenerateSetDataDict:(NSString *)itemNameLocal
                     itemAmountLocal:(NSString *)itemAmountLocal
                  itemListItemsLocal:(NSMutableDictionary *)itemListItemsLocal
                 itemAssignedToLocal:(NSMutableArray *)itemAssignedToLocal
   itemAssignedToNewHomeMembersLocal:(NSString *)itemAssignedToNewHomeMembersLocal
          itemAssignedToAnybodyLocal:(NSString *)itemAssignedToAnybodyLocal
                    itemDueDateLocal:(NSString *)itemDueDateLocal
                    itemRepeatsLocal:(NSString *)itemRepeatsLocal
        itemRepeatIfCompletedEarlyLocal:(NSString *)itemRepeatIfCompletedEarlyLocal
        itemCompleteAsNeededLocal:(NSString *)itemCompleteAsNeededLocal
                  itemTakeTurnsLocal:(NSString *)itemTakeTurnsLocal
                       itemDaysLocal:(NSString *)itemDaysLocal
              itemRemindersDictLocal:(NSMutableDictionary *)itemRemindersDictLocal
                      itemNotesLocal:(NSString *)itemNotesLocal
                   itemPriorityLocal:(NSString *)itemPriorityLocal
                itemSuggestedIDLocal:(NSString *)itemSuggestedIDLocal
                   itemUniqueIDLocal:(NSString *)itemUniqueIDLocal
                         itemIDLocal:(NSString *)itemIDLocal
               itemOccurrenceIDLocal:(NSString *)itemOccurrenceIDLocal
                 itemDatePostedLocal:(NSString *)itemDatePostedLocal
                   itemTaskListLocal:(NSString *)itemTaskListLocal {
    
    BOOL TaskIsRepeatingDaily = [[[BoolDataObject alloc] init] TaskIsRepeatingDaily:[@{@"ItemRepeats" : itemRepeatsLocal} mutableCopy] itemType:currentItemType];
    
    
    
    
    //Item Type Is Expense
    if ([itemAmountLocal containsString:localCurrencySymbol] == NO) {
        itemAmountLocal = [NSString stringWithFormat:@"%@%@", localCurrencySymbol, itemAmountLocal];
    }
    
    
    
    
    //Item Type Is Chore, Expense, List
    NSMutableArray *itemAssignedTo = itemAssignedToLocal;
    
    
    
    
    //Item Type Is Chore or Expense
    NSMutableArray *itemSpecificDueDates = [NSMutableArray array];
    NSString *itemApprovalNeeded = @"No";
    NSMutableDictionary *itemApprovalRequests = [NSMutableDictionary dictionary];
    
    
    
    
    //Item Type Is Chore
    NSString *itemCompletedBy = @"Everyone";
    NSMutableDictionary *itemSubTasks = [NSMutableDictionary dictionary];
    
    
    
    
    //Item Type Is Chore, Expense, List
    NSString *itemUniqueID = itemUniqueIDLocal;
    NSString *itemID = itemIDLocal;
    NSString *itemHomeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
    NSString *itemOccurrenceStatus = @"None";
    NSString *itemCreatedBy = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"];
    NSString *itemDatePosted = itemDatePostedLocal;
    NSString *itemName = itemNameLocal;
    NSString *itemAssignedToNewHomeMembers = itemAssignedToNewHomeMembersLocal;
    NSString *itemAssignedToAnybody = itemAssignedToAnybodyLocal;
    NSString *itemRepeatIfCompletedEarly = itemRepeatIfCompletedEarlyLocal;
    NSString *itemRepeats = itemRepeatsLocal;
    NSString *itemDays = TaskIsRepeatingDaily == NO ? itemDaysLocal : @"";
    NSMutableArray *itemDueDatesSkipped = [NSMutableArray array];
    NSString *itemDate = @"No Due Date";
    NSString *itemDueDate = [self GenerateItemDueDate:itemRepeatsLocal itemTime:@"Any Time" itemDays:@"Any Day" itemDueDate:itemDueDateLocal itemRepeatIfCompletedEarly:itemRepeatIfCompletedEarlyLocal itemCompleteAsNeeded:itemCompleteAsNeededLocal itemDueDatesSkipped:[NSMutableArray array] itemDateLastReset:@"" chosenItemDatePosted:itemDatePostedLocal];
    NSString *itemTime = @"Any Time";
    NSString *itemCompleteAsNeeded = @"No";
    NSMutableDictionary *itemAdditionalReminders = [NSMutableDictionary dictionary];
    NSMutableDictionary *itemReminderDict = [itemRemindersDictLocal mutableCopy];
    NSMutableDictionary *itemReward = [@{@"Reward" : @"None", @"RewardDescription" : @"", @"RewardNotes" : @""} mutableCopy];
    NSString *itemDifficulty = @"None";
    
    NSString *itemPriority = itemPriorityLocal;
    NSString *itemColor = @"None";
    NSString *itemPrivate = @"No";
    NSString *itemImageURL = [[[GeneralObject alloc] init] GenerateItemImageURL:currentItemType itemUniqueID:itemUniqueIDLocal];
    NSString *itemNotes = itemNotesLocal;
    NSString *itemStartDate = [self GenerateItemStartDate];
    NSString *itemEndDate = @"Never";
    NSString *itemEndNumberOfTimes = @"No";
    NSString *itemTakeTurns = itemTakeTurnsLocal;
    NSString *itemAlternateTurns = [itemTakeTurns isEqualToString:@"Yes"] == NO ? @"" : @"Every Occurrence";
    NSString *itemDateLastAlternatedTurns = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:@"MMMM dd, yyyy hh:mm a" returnAs:[NSString class]];
    NSString *itemGracePeriod = @"None";
    NSString *itemStatus = @"None";
    NSString *itemPastDue = @"2 Days";
    
    NSString *itemTurnUserID = [[[GeneralObject alloc] init] GenerateNextUsersTurn:itemAssignedTo itemAssignedToOriginal:itemAssignedTo homeMembersDict:_homeMembersDict itemTakeTurns:itemTakeTurns itemTurnUserID:@""];
    
    NSMutableDictionary *itemCompletedDictLocal = [NSMutableDictionary dictionary];
    NSMutableDictionary *itemInProgressDictLocal = [NSMutableDictionary dictionary];
    NSMutableDictionary *itemWontDoLocal = [NSMutableDictionary dictionary];
    
    NSMutableArray *itemTags = [NSMutableArray array];
    NSString *itemTrash = @"No";
    NSString *itemAddedLocation = @"MultiAddTasksViewController";
    
    NSString *itemTypeLocal = currentItemType;
    NSString *itemOccurrenceID = itemOccurrenceIDLocal;
    NSString *itemSuggestedID = itemSuggestedIDLocal;
    NSString *itemTutorial = @"No";
    NSMutableDictionary *itemOccurrencePastDue = [NSMutableDictionary dictionary];
    NSString *itemScheduledStart = @"Now";
    NSString *itemRandomizeTurnOrder = @"No";
    NSString *itemPhotoConfirmation = @"No";
    NSMutableDictionary *itemPhotoConfirmationDict = [NSMutableDictionary dictionary];
    NSString *itemPinned = @"No";
    NSString *itemDeleted = @"No";
    NSString *itemTaskList = itemTaskListLocal;
    NSString *itemSelfDestruct = @"Never";
    NSString *itemEstimatedTime = @"0 Minutes";
    NSString *itemAmount = itemAmountLocal;
    NSString *itemItemized = @"No";
    NSMutableDictionary *itemItemizedItems = [NSMutableDictionary dictionary];
    NSMutableDictionary *itemCostPerPerson = [[self GenerateItemCostPerPerson:itemAmountLocal itemAssignedToArrayLocal:itemAssignedTo] mutableCopy];
    NSMutableDictionary *itemPaymentMethod = [@{@"PaymentMethod" : @"None", @"PaymentMethodData" : @"", @"PaymentMethodNotes" : @""} mutableCopy];
    NSMutableDictionary *itemListItems = itemListItemsLocal ? itemListItemsLocal : [@{} mutableCopy];
    NSString *itemDateLastReset = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat: @"MMMM dd, yyyy hh:mm a" returnAs:[NSString class]];
    
    
    
    NSDictionary *setDataDict = [[[GeneralObject alloc] init] GenerateItemSetDataDict:itemTypeLocal
                                                                         itemUniqueID:itemUniqueID
                                                                               itemID:itemID
                                                                     itemOccurrenceID:itemOccurrenceID
                                                                           itemHomeID:itemHomeID
                                                                      itemSuggestedID:itemSuggestedID
                                 
                                                                         itemTutorial:itemTutorial
                                 
                                                                        itemCreatedBy:itemCreatedBy
                                                                       itemDatePosted:itemDatePosted
                                                                    itemDateLastReset:itemDateLastReset
                                 
                                                                    itemCompletedDict:itemCompletedDictLocal
                                                                   itemInProgressDict:itemInProgressDictLocal
                                                                           itemWontDo:itemWontDoLocal
                                 
                                                                 itemOccurrenceStatus:itemOccurrenceStatus
                                                                itemOccurrencePastDue:itemOccurrencePastDue
                                 
                                                                    itemAddedLocation:itemAddedLocation
                                                                   itemScheduledStart:itemScheduledStart
                                 
                                 
                                 
                                 //Main View
                                                                             itemName:itemName
                                                                         itemImageURL:itemImageURL
                                                                            itemNotes:itemNotes
                                 
                                                                       itemAssignedTo:itemAssignedTo
                                                         itemAssignedToNewHomeMembers:itemAssignedToNewHomeMembers
                                                                itemAssignedToAnybody:itemAssignedToAnybody
                                 
                                                                             itemDate:itemDate
                                                                          itemDueDate:itemDueDate
                                                                  itemDueDatesSkipped:itemDueDatesSkipped
                                                                          itemRepeats:itemRepeats
                                                              itemRepeatIfCompletedEarly:itemRepeatIfCompletedEarly
                                                                 itemCompleteAsNeeded:itemCompleteAsNeeded
                                 
                                                                        itemStartDate:itemStartDate
                                                                          itemEndDate:itemEndDate
                                                                 itemEndNumberOfTimes:itemEndNumberOfTimes
                                 
                                                                             itemDays:itemDays
                                                                             itemTime:itemTime
                                 
                                                                        itemTakeTurns:itemTakeTurns
                                                                   itemAlternateTurns:itemAlternateTurns
                                                          itemDateLastAlternatedTurns:itemDateLastAlternatedTurns
                                                                       itemTurnUserID:itemTurnUserID
                                                               itemRandomizeTurnOrder:itemRandomizeTurnOrder
                                 
                                                                     itemReminderDict:itemReminderDict
                                 
                                 
                                 
                                 //More Options
                                                                      itemGracePeriod:itemGracePeriod
                                                                          itemPastDue:itemPastDue
                                 
                                                                            itemColor:itemColor
                                                                             itemTags:itemTags
                                                                         itemPriority:itemPriority
                                                                       itemDifficulty:itemDifficulty
                                 
                                                                           itemReward:itemReward
                                                                          itemPrivate:itemPrivate
                                 
                                                              itemAdditionalReminders:itemAdditionalReminders
                                                                itemPhotoConfirmation:itemPhotoConfirmation
                                                            itemPhotoConfirmationDict:itemPhotoConfirmationDict
                                                                           itemStatus:itemStatus
                                                                            itemTrash:itemTrash
                                                                           itemPinned:itemPinned
                                                                          itemDeleted:itemDeleted
                                                                         itemTaskList:itemTaskList
                                 
                                                                     itemSelfDestruct:itemSelfDestruct
                                                                    itemEstimatedTime:itemEstimatedTime
                                 
                                 
                                 
                                 //if ([itemType containsString:@"Chore"] || [itemType containsString:@"Expense"]) {
                                 
                                                                 itemSpecificDueDates:itemSpecificDueDates
                                                                   itemApprovalNeeded:itemApprovalNeeded
                                                                 itemApprovalRequests:itemApprovalRequests
                                 
                                 //}
                                 
                                 //if ([itemType containsString:@"Chore"]) {
                                 
                                                                      itemCompletedBy:itemCompletedBy
                                                                         itemSubTasks:itemSubTasks
                                 
                                 //} else if ([itemType containsString:@"Expense"]) {
                                 
                                                                           itemAmount:itemAmount
                                                                         itemItemized:itemItemized
                                                                    itemItemizedItems:itemItemizedItems
                                                                    itemCostPerPerson:itemCostPerPerson
                                                                    itemPaymentMethod:itemPaymentMethod
                                 
                                 //} else if ([itemType containsString:@"List"]) {
                                 
                                                                        itemListItems:itemListItems];
    
    //}
    
    return [setDataDict copy];
}

#pragma mark - TableView Methods

-(NSDictionary *)GenerateObjectToUse:(NSIndexPath *)indexPath {
    
    NSDictionary *objectToUse = @{@"ItemName" : @""};
    
    if (indexPath == NULL) {
        return objectToUse;
    }
    
    if (_viewingAddedTasks) {
        
        NSString *itemType = itemSelectedDictLocal && [[itemSelectedDictLocal allKeys] count] > indexPath.section ? [itemSelectedDictLocal allKeys][indexPath.section] : @"";
        NSMutableDictionary *specificItemTypeDictOfSelectedTasks = itemSelectedDictLocal && itemSelectedDictLocal[itemType] ? [itemSelectedDictLocal[itemType] mutableCopy] : [NSMutableDictionary dictionary];
        NSArray *specificItemTypeArrayOfSelectedTaskNames = [specificItemTypeDictOfSelectedTasks allKeys] ? [[specificItemTypeDictOfSelectedTasks allKeys] mutableCopy] : @[];
        NSString *selectedSuggestedID = [specificItemTypeArrayOfSelectedTaskNames count] > indexPath.row ? specificItemTypeArrayOfSelectedTaskNames[indexPath.row] : @"";
        
        objectToUse = specificItemTypeDictOfSelectedTasks[selectedSuggestedID];
        
    } else {
        
        if (Searching == NO) {
            
            NSMutableDictionary *specificItemTypeDictOfAllTasks = itemDict && itemDict[currentItemTypeCollection] ? [itemDict[currentItemTypeCollection] mutableCopy] : [NSMutableDictionary dictionary];
            NSString *specificItemTypeDictOfAllTasksSpecificSection = itemDictKeys && itemDictKeys[currentItemTypeCollection] && [(NSArray *)itemDictKeys[currentItemTypeCollection] count] > indexPath.section ? [itemDictKeys[currentItemTypeCollection][indexPath.section] mutableCopy] : @"";
            NSMutableArray *specificItemTypeArrayOfAllTaskNamesInSpecificSection = specificItemTypeDictOfAllTasks[specificItemTypeDictOfAllTasksSpecificSection] ? [specificItemTypeDictOfAllTasks[specificItemTypeDictOfAllTasksSpecificSection] mutableCopy] : [NSMutableArray array];
            NSDictionary *taskDict = [specificItemTypeArrayOfAllTaskNamesInSpecificSection count] > indexPath.row ? [specificItemTypeArrayOfAllTaskNamesInSpecificSection[indexPath.row] mutableCopy] : [NSDictionary dictionary];
            
            objectToUse = taskDict;
            
        } else {
            
            if ([(NSArray *)searchResults[@"ItemName"] count] > 0) {
                
                NSString *searchedTaskName = searchResults && searchResults[@"ItemName"] && [(NSArray *)searchResults[@"ItemName"] count] > indexPath.row ? searchResults[@"ItemName"][indexPath.row] : @"";
                NSString *searchedTaskSuggestedID = searchResults && searchResults[@"ItemSuggestedID"] && [(NSArray *)searchResults[@"ItemSuggestedID"] count] > indexPath.row ? searchResults[@"ItemSuggestedID"][indexPath.row] : @"";
                //                NSString *searchedTaskAssignedTo = searchResults && searchResults[@"ItemAssignedTo"] && [(NSArray *)searchResults[@"ItemAssignedTo"] count] > indexPath.row ? searchResults[@"ItemAssignedTo"][indexPath.row] : @"";
                //                NSString *searchedTaskAssignedToNewHomeMembers = searchResults && searchResults[@"ItemAssignedToNewHomeMembers"] && [(NSArray *)searchResults[@"ItemAssignedToNewHomeMembers"] count] > indexPath.row ? searchResults[@"ItemAssignedToNewHomeMembers"][indexPath.row] : @"";
                NSString *searchedTaskRepeats = searchResults && searchResults[@"ItemRepeats"] && [(NSArray *)searchResults[@"ItemRepeats"] count] > indexPath.row ? searchResults[@"ItemRepeats"][indexPath.row] : @"Never";
                NSString *searchedTaskPriority = searchResults && searchResults[@"ItemPriority"] && [(NSArray *)searchResults[@"ItemPriority"] count] > indexPath.row ? searchResults[@"ItemPriority"][indexPath.row] : @"None";
                NSString *searchedTaskTakeTurns = searchResults && searchResults[@"ItemTakeTurns"] && [(NSArray *)searchResults[@"ItemTakeTurns"] count] > indexPath.row ? searchResults[@"ItemTakeTurns"][indexPath.row] : @"No";
                NSString *searchedTaskAmount = searchResults && searchResults[@"ItemAmount"] && [(NSArray *)searchResults[@"ItemAmount"] count] > indexPath.row ? searchResults[@"ItemAmount"][indexPath.row] : [NSString stringWithFormat:@"%@0%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol];
                NSMutableDictionary *searchedTaskListItems = searchResults && searchResults[@"ItemListItems"] && [(NSArray *)searchResults[@"ItemListItems"] count] > indexPath.row ? searchResults[@"ItemListItems"][indexPath.row] : [NSMutableDictionary dictionary];
                NSString *searchedTaskTaskList = searchResults && searchResults[@"ItemTaskList"] && [(NSArray *)searchResults[@"ItemTaskList"] count] > indexPath.row ? searchResults[@"ItemTaskList"][indexPath.row] : @"No List";
                
                objectToUse = @{@"ItemName" : searchedTaskName, /* @"ItemAssignedTo" : searchedTaskAssignedTo, @"ItemAssignedToNewHomeMembers" : searchedTaskAssignedToNewHomeMembers, */ @"ItemRepeats" : searchedTaskRepeats, @"ItemPriority" : searchedTaskPriority, @"ItemTakeTurns" : searchedTaskTakeTurns, @"ItemAmount" : searchedTaskAmount, @"ItemListItems" : searchedTaskListItems, @"ItemTaskList" : searchedTaskTaskList, @"ItemSuggestedID" : searchedTaskSuggestedID};
                
            } else {
                
                BOOL FirstRowIsDisplayedAndSearchBarHasText = (indexPath.row==0) && (_searchBar.text.length > 0);
                
                if (FirstRowIsDisplayedAndSearchBarHasText) {
                    
                    NSString *strP1 = NSLocalizedString(@"Search for", @"Search for");
                    NSString *strP2 = NSLocalizedString(@"in posts", @"in posts");
                    NSString *str = [NSString stringWithFormat:@"%@ \"%@\" %@", strP1, _searchBar.text, strP2];
                    
                    objectToUse = @{@"ItemName" : str};
                    
                }
                
            }
            
        }
        
    }
    
    return objectToUse;
}

-(NSUInteger)GenerateNumberOfRowsInTableView:(NSInteger)section {
    
    int numberOfRows = 0;
    
    if (Searching == NO) {
        
        if (_viewingAddedTasks) {
            
            NSString *itemType = itemSelectedDictLocal && [[itemSelectedDictLocal allKeys] count] > section ? [itemSelectedDictLocal allKeys][section] : @"";
            NSMutableDictionary *specificItemTypeDictOfSelectedTasks = itemSelectedDictLocal[itemType] ? itemSelectedDictLocal[itemType] : [NSMutableDictionary dictionary];
            NSArray *specificItemTypeArrayOfSelectedTaskNames = specificItemTypeDictOfSelectedTasks ? [specificItemTypeDictOfSelectedTasks allKeys] : @[];
            
            return [specificItemTypeArrayOfSelectedTaskNames count];
            
        } else {
            
            NSMutableDictionary *specificItemTypeDictOfAllTasks =  itemDict && itemDict[currentItemTypeCollection] ? itemDict[currentItemTypeCollection] : [NSMutableDictionary dictionary];
            NSString *specificItemTypeDictOfAllTasksSpecificSection = itemDictKeys && itemDictKeys[currentItemTypeCollection] && [(NSArray *)itemDictKeys[currentItemTypeCollection] count] > section ? itemDictKeys[currentItemTypeCollection][section] : @"";
            NSMutableArray *specificItemTypeArrayOfAllTaskNamesInSpecificSection = specificItemTypeDictOfAllTasks[specificItemTypeDictOfAllTasksSpecificSection] ? specificItemTypeDictOfAllTasks[specificItemTypeDictOfAllTasksSpecificSection] : [NSMutableArray array];
            
            return [specificItemTypeArrayOfAllTaskNamesInSpecificSection count];
            
        }
        
    } else {
        
        return [(NSArray *)searchResults[@"ItemSuggestedID"] count];
        
    }
    
    return numberOfRows;
}

-(NSString *)GenerateTaskNameOfSelectedRow:(NSIndexPath *)indexPath {
    
    NSString *taskName = @"";
    
    if (Searching == NO) {
        
        if (_viewingAddedTasks) {
            
            NSString *itemType = itemSelectedDictLocal && [[itemSelectedDictLocal allKeys] count] > indexPath.section ? [itemSelectedDictLocal allKeys][indexPath.section] : @"";
            NSMutableDictionary *specificItemTypeDictOfSelectedTasks = itemSelectedDictLocal[itemType] ? itemSelectedDictLocal[itemType] : [NSMutableDictionary dictionary];
            NSArray *specificItemTypeArrayOfSelectedTaskNames = specificItemTypeDictOfSelectedTasks ? [specificItemTypeDictOfSelectedTasks allKeys] : @[];
            
            taskName = [specificItemTypeArrayOfSelectedTaskNames count] > indexPath.row ? specificItemTypeArrayOfSelectedTaskNames[indexPath.row] : @"";
            
        } else {
            
            NSMutableDictionary *specificItemTypeDictOfAllTasks = itemDict && itemDict[currentItemTypeCollection] ? itemDict[currentItemTypeCollection] : [NSMutableDictionary dictionary];
            NSString *specificItemTypeDictOfAllTasksSpecificSection = itemDictKeys && itemDictKeys[currentItemTypeCollection] && [(NSArray *)itemDictKeys[currentItemTypeCollection] count] > indexPath.section ? itemDictKeys[currentItemTypeCollection][indexPath.section] : @"";
            NSMutableArray *specificItemTypeDictOfAllTaskNamesInSpecificSection = specificItemTypeDictOfAllTasks[specificItemTypeDictOfAllTasksSpecificSection] ? specificItemTypeDictOfAllTasks[specificItemTypeDictOfAllTasksSpecificSection] : [NSMutableArray array];
            
            taskName = [specificItemTypeDictOfAllTaskNamesInSpecificSection count] > indexPath.row ? specificItemTypeDictOfAllTaskNamesInSpecificSection[indexPath.row] : @"";
            
        }
        
    } else {
        
        if ([(NSArray *)searchResults[@"ItemSuggestedID"] count] > 0) {
            
            taskName = searchResults && searchResults[@"ItemName"] && [(NSArray *)searchResults[@"ItemName"] count] > indexPath.row ? searchResults[@"ItemName"][indexPath.row] : @"";
            
        }
        
    }
    
    return taskName;
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Sub-Internal Methods
#pragma mark
#pragma mark
#pragma mark -

#pragma mark MultiAddItems

-(NSDictionary *)MultiAddItems_SetLocalTaskListData_AddTaskToExistingTaskList:(NSString *)taskListName setDataDict:(NSDictionary *)setDataDict setTaskListData_NewTaskListDict:(NSMutableDictionary *)setTaskListData_NewTaskListDict updateTaskListData_OldTaskListDict:(NSMutableDictionary *)updateTaskListData_OldTaskListDict {
    
    NSUInteger index = [_taskListDict[@"TaskListName"] containsObject:taskListName] ? [_taskListDict[@"TaskListName"] indexOfObject:taskListName] : 1000;
    
    
    
    NSMutableDictionary *newTaskListDict = [[[GeneralObject alloc] init] GenerateSingleObjectDictionary:_taskListDict keyArray:[_taskListDict allKeys] indexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    
    NSArray *keyArray = [[[GeneralObject alloc] init] GenerateTaskListKeyArray];
    
    for (NSString *key in keyArray) {
        NSMutableArray *arr = updateTaskListData_OldTaskListDict[key] ? [updateTaskListData_OldTaskListDict[key] mutableCopy] : [NSMutableArray array];
        id object = newTaskListDict[key] ? newTaskListDict[key] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
        [arr addObject:object];
        [updateTaskListData_OldTaskListDict setObject:arr forKey:key];
    }
    
    updateTaskListData_OldTaskListDict = [self MultiAddItems_SetLocalTaskListData_GenerateLocalTaskListDictWithNewTaskListItems:taskListName dictToUse:updateTaskListData_OldTaskListDict setDataDict:setDataDict];
    
    
    
    return @{@"setTaskListData_NewTaskListDict" : setTaskListData_NewTaskListDict, @"updateTaskListData_OldTaskListDict" : updateTaskListData_OldTaskListDict};
}

-(NSDictionary *)MultiAddItems_SetLocalTaskListData_AddTaskToExistingTaskListInLocalTaskListDict:(NSString *)taskListName setDataDict:(NSDictionary *)setDataDict setTaskListData_NewTaskListDict:(NSMutableDictionary *)setTaskListData_NewTaskListDict updateTaskListData_OldTaskListDict:(NSMutableDictionary *)updateTaskListData_OldTaskListDict AddToNewTaskListDict:(BOOL)AddToNewTaskListDict AddToOldTaskListDict:(BOOL)AddToOldTaskListDict {
    
    NSMutableDictionary *dictToUse = [NSMutableDictionary dictionary];
    
    if (AddToNewTaskListDict == YES) { dictToUse = [setTaskListData_NewTaskListDict mutableCopy]; } else if (AddToOldTaskListDict == YES) { dictToUse = [updateTaskListData_OldTaskListDict mutableCopy]; }
    
    NSUInteger index = [dictToUse[@"TaskListName"] containsObject:taskListName] ? [dictToUse[@"TaskListName"] indexOfObject:taskListName] : 1000;
    
    NSMutableDictionary *taskListItems = [(NSArray *)dictToUse[@"TaskListItems"] count] > index ? [dictToUse[@"TaskListItems"][index] mutableCopy] : [NSMutableDictionary dictionary];;
    if ([[taskListItems allKeys] containsObject:setDataDict[@"ItemUniqueID"]] == NO) { [taskListItems setObject:@{@"ItemUniqueID" : setDataDict[@"ItemUniqueID"]} forKey:setDataDict[@"ItemUniqueID"]]; }
    
    NSMutableDictionary *dictToUseCopy = [dictToUse mutableCopy];
    NSMutableArray *tempArr = [dictToUseCopy[@"TaskListItems"] mutableCopy];
    [tempArr replaceObjectAtIndex:index withObject:taskListItems];
    [dictToUseCopy setObject:tempArr forKey:@"TaskListItems"];
    dictToUse = [dictToUseCopy mutableCopy];
    
    if (AddToNewTaskListDict == YES) { setTaskListData_NewTaskListDict = [dictToUse mutableCopy]; } else if (AddToOldTaskListDict == YES) { updateTaskListData_OldTaskListDict = [dictToUse mutableCopy]; }
    
    
    
    return @{@"setTaskListData_NewTaskListDict" : setTaskListData_NewTaskListDict, @"updateTaskListData_OldTaskListDict" : updateTaskListData_OldTaskListDict};
}

-(NSDictionary *)MultiAddItems_SetLocalTaskListData_AddTaskToNewTaskList:(NSString *)taskListName setDataDict:(NSDictionary *)setDataDict setTaskListData_NewTaskListDict:(NSMutableDictionary *)setTaskListData_NewTaskListDict updateTaskListData_OldTaskListDict:(NSMutableDictionary *)updateTaskListData_OldTaskListDict {
    
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
    NSString *randomID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    NSString *dateCreated = [[[GeneralObject alloc] init] GenerateCurrentDateString];
    NSString *newName = setDataDict[@"ItemTaskList"] ? setDataDict[@"ItemTaskList"] : @"No List";
    
    
    
    NSMutableDictionary *newTaskListDict = [@{
        @"TaskListID" : randomID,
        @"TaskListDateCreated" : dateCreated,
        @"TaskListCreatedBy" : userID,
        @"TaskListName" : newName,
        @"TaskListSections" : [NSMutableArray array],
        @"TaskListItems" : [NSMutableDictionary dictionary]
    } mutableCopy];
    
    NSArray *keyArray = [[[GeneralObject alloc] init] GenerateTaskListKeyArray];
    
    for (NSString *key in keyArray) {
        NSMutableArray *arr = setTaskListData_NewTaskListDict[key] ? [setTaskListData_NewTaskListDict[key] mutableCopy] : [NSMutableArray array];
        id object = newTaskListDict[key] ? newTaskListDict[key] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
        [arr addObject:object];
        [setTaskListData_NewTaskListDict setObject:arr forKey:key];
    }
    
    setTaskListData_NewTaskListDict = [self MultiAddItems_SetLocalTaskListData_GenerateLocalTaskListDictWithNewTaskListItems:taskListName dictToUse:setTaskListData_NewTaskListDict setDataDict:setDataDict];
    
    
    
    [[[GeneralObject alloc] init] CallNSNotificationMethods:@"AddOrEditTaskList" userInfo:newTaskListDict locations:@[@"MultiAddTasks"]];

    
    
    return @{@"setTaskListData_NewTaskListDict" : setTaskListData_NewTaskListDict, @"updateTaskListData_OldTaskListDict" : updateTaskListData_OldTaskListDict};
}

-(void)MultiAddItems_UpdateProgressView {
    
    double totalProgress = self->completedTasksAdded/self->totalTasksAdded;
    
    if (totalProgress < 0) {
        totalProgress = 0;
    }
    
    if (totalProgress >= 1) {
        totalProgress = 0.99;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self->progressView setProgress:totalProgress animated:YES];
    });
    
}

-(void)MultiAddItems_IncreaseCountForAlertViewPopup {
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"AddedItem"] || [[[NSUserDefaults standardUserDefaults] objectForKey:@"AddedItem"] isEqualToString:@"0"]) {
        
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"AddedItem"];
        
    } else {
        
        NSString *addeditem = [[NSUserDefaults standardUserDefaults] objectForKey:@"AddedItem"];
        int addedItemCount = [addeditem intValue];
        NSString *addedItemCountStr = [NSString stringWithFormat:@"%d", addedItemCount];
        [[NSUserDefaults standardUserDefaults] setObject:addedItemCountStr forKey:@"AddedItem"];
        
    }
    
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Sub-Sub-Internal Methods
#pragma mark
#pragma mark
#pragma mark -

#pragma mark MultiAddItems

-(NSMutableDictionary *)MultiAddItems_SetLocalTaskListData_GenerateLocalTaskListDictWithNewTaskListItems:(NSString *)taskListName dictToUse:(NSMutableDictionary *)dictToUse setDataDict:(NSDictionary *)setDataDict {
    
    NSUInteger index = [dictToUse[@"TaskListName"] containsObject:taskListName] ? [dictToUse[@"TaskListName"] indexOfObject:taskListName] : 1000;
    
    NSMutableDictionary *taskListItems = index != 1000 && dictToUse[@"TaskListItems"] && [(NSArray *)dictToUse[@"TaskListItems"] count] > index ? [dictToUse[@"TaskListItems"][index] mutableCopy] : [NSMutableDictionary dictionary];;
    if ([[taskListItems allKeys] containsObject:setDataDict[@"ItemUniqueID"]] == NO) { [taskListItems setObject:@{@"ItemUniqueID" : setDataDict[@"ItemUniqueID"]} forKey:setDataDict[@"ItemUniqueID"]]; }
    
    NSMutableDictionary *updateTaskListData_OldTaskListDictCopy = [dictToUse mutableCopy];
    NSMutableArray *tempArr = [updateTaskListData_OldTaskListDictCopy[@"TaskListItems"] mutableCopy];
    [tempArr replaceObjectAtIndex:index withObject:taskListItems];
    [updateTaskListData_OldTaskListDictCopy setObject:tempArr forKey:@"TaskListItems"];
    dictToUse = [updateTaskListData_OldTaskListDictCopy mutableCopy];
    
    return dictToUse;
}

@end
