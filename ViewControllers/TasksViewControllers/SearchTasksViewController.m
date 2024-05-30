//
//  SearchTasksViewController.m
//  WeDivvy
//
//  Created by Philip Nagel on 11/6/22.
//

#import "SearchTasksViewController.h"

#import "MultiAddTaskCell.h"

#import "GeneralObject.h"
#import "SetDataObject.h"
#import "PushObject.h"
#import "NotificationsObject.h"
#import "BoolDataObject.h"
#import "LightDarkModeObject.h"

#import <MRProgressOverlayView.h>

@interface SearchTasksViewController () {
    
    MRProgressOverlayView *progressView;
    
    NSString *currentItemType;
    NSString *itemType;
    NSString *chosenItemUniqueID;
    NSString *chosenItemID;
    NSString *chosenItemOccurrenceID;
    NSString *chosenItemDatePosted;
    
    NSString *hourComp;
    NSString *minuteComp;
    NSString *AMPMComp;
    
    NSMutableArray *assignedToUsernameArray;
    
    int cellHeight;
    int totalQueries;
    int completedQueries;
    
    double totalTasksAdded;
    double completedTasksAdded;
    
    NSMutableDictionary *searchResults;
    BOOL Searching;
    
}

@end

@import InstantSearch;
@import InstantSearchClient;

@implementation SearchTasksViewController

#pragma mark - System Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self InitMethods];
    
    [self BarButtonItems];
    
    [self TapGestures];
    
    [self KeyBoardToolBar];
    
    [self KeyboardNSNotifications];
    
    [self NSNotificationObservers];
    
    [self AdjustTableViewHeight];
    
}

-(void)viewWillLayoutSubviews {
    
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    self.navigationController.navigationBar.backgroundColor = _customScrollView.backgroundColor;
    
    CGFloat height = CGRectGetHeight(self.view.bounds);
    CGFloat width = CGRectGetWidth(self.view.bounds);
    
    CGFloat textFieldSpacing = (height*0.024456);
    CGFloat bottomPadding = [[[GeneralObject alloc] init] GetBottomPaddingHeight];
    //    CGFloat navigationBarHeight = [[[GeneralObject alloc] init] GetNavigationBarHeight:self];
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        self.view.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [[[LightDarkModeObject alloc] init] DarkModeTextPrimary]};
        
        [self preferredStatusBarStyle];
        
        self.navigationController.navigationBar.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        
    } else {
        
        self.navigationController.navigationBar.backgroundColor =_customScrollView.backgroundColor;
        
    }
    
    _searchBarView.backgroundColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ?
    [[[LightDarkModeObject alloc] init] DarkModeTertiary] :
    [[[LightDarkModeObject alloc] init] LightModeSecondary];
    
    UIFont *fontSize = [UIFont systemFontOfSize:(self.view.frame.size.height*0.02173813 > 16?16:(self.view.frame.size.height*0.02173813)) weight:UIFontWeightRegular];
    UIColor *textColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTextSecondary] : [[[LightDarkModeObject alloc] init] LightModeTexAddTaskTextField];
    UIColor *backgroundColor = [UIColor clearColor];
    
    _searchBar.placeholder = [NSString stringWithFormat:@"Search for a task"];
    _searchBar.font = fontSize;
    _searchBar.minimumFontSize = (height*0.25454545 > 14?14:(height*0.25454545));
    _searchBar.adjustsFontSizeToFitWidth = YES;
    _searchBar.textColor = textColor;
    _searchBar.backgroundColor = backgroundColor;
    
    CGRect newRect = _customScrollView.frame;
    newRect.origin.y = 0;
    newRect.size.height = self.view.frame.size.height - bottomPadding;
    _customScrollView.frame = newRect;
    
    newRect = _searchBarView.frame;
    newRect.origin.y = 0;
    newRect.size.width = width*1 - (textFieldSpacing*2);
    newRect.size.height = (self.view.frame.size.height*0.07472826 > 55?55:(self.view.frame.size.height*0.07472826));
    _searchBarView.frame = newRect;
    
    newRect = _customTableView.frame;
    newRect.origin.y = _searchBarView.frame.origin.y + _searchBarView.frame.size.height + (self.view.frame.size.height*0.016304 > 12?12:(self.view.frame.size.height*0.016304));
    _customTableView.frame = newRect;
    
    _selectView.layer.cornerRadius = _selectView.frame.size.height/2;
    
    _selectView.frame = CGRectMake(_searchBarView.frame.size.width - (self.view.frame.size.height*0.0407 > 30?30:(self.view.frame.size.height*0.0407)) - (self.view.frame.size.height*0.02717 > 20?20:(self.view.frame.size.height*0.02717)),
                                   _searchBarView.frame.size.height*0.5 - ((self.view.frame.size.height*0.0407 > 30?30:(self.view.frame.size.height*0.0407))*0.5),
                                   (self.view.frame.size.height*0.0407 > 30?30:(self.view.frame.size.height*0.0407)),
                                   (self.view.frame.size.height*0.0407 > 30?30:(self.view.frame.size.height*0.0407)));
    
    _selectImageView.frame = CGRectMake(_selectView.frame.size.width*0.5 - ((_selectView.frame.size.width*0.35 > 12?12:(_selectView.frame.size.width*0.35))*0.5),
                                        _selectView.frame.size.height*0.5 - ((_selectView.frame.size.height*0.35 > 12?12:(_selectView.frame.size.height*0.35))*0.5),
                                        (_selectView.frame.size.height*0.35 > 12?12:(_selectView.frame.size.height*0.35)),
                                        (_selectView.frame.size.height*0.35 > 12?12:(_selectView.frame.size.height*0.35)));
    
    _selectView.hidden = YES;
    
    _searchBar.frame = CGRectMake((self.view.frame.size.height*0.02717 > 20?20:(self.view.frame.size.height*0.02717)),
                                  _searchBarView.frame.size.height*0.5 - (_searchBarView.frame.size.height*0.75)*0.5,
                                  _searchBarView.frame.size.width - (self.view.frame.size.height*0.02717 > 20?20:(self.view.frame.size.height*0.02717)) - _selectView.frame.size.width - (self.view.frame.size.height*0.02717 > 20?20:(self.view.frame.size.height*0.02717)),
                                  _searchBarView.frame.size.height*0.75);
    
    CGFloat cornerRadius = (self.view.frame.size.height*0.2181818182 > 12?12:(self.view.frame.size.height*0.2181818182));
    
    [[[GeneralObject alloc] init] RoundingCorners:_searchBarView topCorners:YES bottomCorners:YES cornerRadius:cornerRadius];
    [[[GeneralObject alloc] init] RoundingCorners:_searchBar topCorners:YES bottomCorners:YES cornerRadius:cornerRadius];
    
    _searchBarView.layer.borderWidth = 1.5f;
    _searchBarView.layer.borderColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [UIColor clearColor].CGColor : [UIColor colorWithRed:236.0f/255.0f green:237.0f/255.0f blue:240.0f/255.0f alpha:1.0f].CGColor;
    _searchBarView.layer.cornerRadius = _searchBarView.frame.size.height*0.181818;
    
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
        
        _selectView.hidden = YES;
        
        [self AdjustTableViewHeight];
        
    } else {
        
        Searching = YES;
        
        self.customTableView.layer.zPosition = 5;
        
        [self SearchAlgolia:_searchBar];
        
        [self.customTableView reloadData];
        
        _selectView.hidden = NO;
        
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [_searchBar resignFirstResponder];
    
    return true;
    
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
    
    [self SetUpItemType];
    
    [self SetUpCellHeight];
    
    [self SetUpAnalytics];
    
    [self SetUpTableViewAndSearchBar];
    
}

-(void)BarButtonItems {
    
    self.navigationItem.hidesBackButton = YES;
    
    UIBarButtonItem *barButtonItem;
    
    barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(NavigationBackButtonAction:)];
    
    self.navigationItem.leftBarButtonItem = barButtonItem;
    
}

-(void)TapGestures {
    
    _selectView.userInteractionEnabled = YES;
    [_selectView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ClearSearchBar:)]];
    
}

-(void)KeyBoardToolBar {
    
    UIToolbar* keyboardToolbar = [[UIToolbar alloc] init];
    
    [keyboardToolbar sizeToFit];
    
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                      target:nil action:nil];
    
    keyboardToolbar.items = @[flexBarButton];
    
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


-(void)NSNotificationObservers {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:_searchBar];
    
}

#pragma mark - Setup Methods

-(void)SetUpItemType {
    
    currentItemType = [[[GeneralObject alloc] init] GenerateItemType];
    
}

-(void)SetUpCellHeight {
    
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    cellHeight = (height*0.0923913 > 68?(68):height*0.0923913);
    
}

-(void)SetUpAnalytics {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewViewController:@"MultiAddTasksViewController" completionHandler:^(BOOL finished) {
        
    }];
    
    [[[GeneralObject alloc] init] TrackInMixPanel:@"MultiAddTasksViewController"];
    
}

-(void)SetUpTableViewAndSearchBar {
    
    _searchBar.delegate = self;
    
    self.customScrollView.delegate = self;
    
    self.customTableView.delegate = self;
    self.customTableView.dataSource = self;
    
    [self.customTableView reloadData];
    
}

#pragma mark - UI Methods

-(void)StartProgressView {
    
    self->progressView = [MRProgressOverlayView showOverlayAddedTo:self.navigationController.view animated:YES];
    self->progressView.mode = MRProgressOverlayViewModeDeterminateCircular;
    
}

-(void)AdjustTableViewHeight {
    
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    int totalCount = 0;
    
    
    if (searchResults && searchResults[@"ItemID"] && [(NSArray *)searchResults[@"ItemID"] count] > 0) {
        
        for (int i=0 ; i<[(NSArray *)searchResults[@"ItemID"] count] ; i++) {
            
            totalCount += 1;
            
        }
        
    } else {
        
        totalCount += 1;
        
    }
    
    int totalCellHeight = 0;
    
    if (totalCellHeight < ((cellHeight+2)*totalCount)) {
        totalCellHeight = ((cellHeight+2)*totalCount);
    }
    
    
    CGFloat tableViewHeight = totalCellHeight;
    tableViewHeight += totalCount * (height*0.04076087 > 30?(30):height*0.04076087) + 8;
    
    CGRect newRect = self->_customTableView.frame;
    newRect.size.height = tableViewHeight;
    self->_customTableView.frame = newRect;
    
    CGFloat scrollViewHeight = _customTableView.frame.origin.y + self->_customTableView.frame.size.height;
    
    if (scrollViewHeight < height+1) {
        scrollViewHeight = height+1;
    }
    
    self->_customScrollView.contentSize = CGSizeMake(0, scrollViewHeight);
    
}

#pragma mark - IBAction Methods

-(IBAction)ClearSearchBar:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Search Bar Cleared For %@", currentItemType] completionHandler:^(BOOL finished) {
        
    }];
    
    Searching = NO;
    
    _searchBar.text = @"";
    
    self.customTableView.layer.zPosition = 0;
    
    [searchResults removeAllObjects];
    
    [self.customTableView reloadData];
    
    _selectView.hidden = YES;
    
    [self AdjustTableViewHeight];
    
}

-(IBAction)NavigationBackButtonAction:(UIBarButtonItem *)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Navigation Back Button Clicked For %@", currentItemType] completionHandler:^(BOOL finished) {
        
    }];
    
    [self DismissViewController:self];
    
}

-(IBAction)DismissViewController:(id)sender {
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"ComingFromShortcut"] isEqualToString:@"Yes"]) {
        [self.navigationController popViewControllerAnimated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    
}

#pragma mark - Algolia

-(void)SearchAlgolia:(UITextField *)textField {
    
    if ((![textField.text isEqualToString:@""]) && (![textField.text isEqualToString:@" "])){
        
        NSString* ALGOLIA_APP_ID = @"3VZ11H3TM1";
        NSString* ALGOLIA_USER_INDEX_NAME = @"Tasks";
        NSString* ALGOLIA_ADMIN_API_KEY = @"37558fa21fb4266d0f5213af41a23a7a";
        
        
        Client *apiClient = [[Client alloc] initWithAppID:ALGOLIA_APP_ID apiKey:ALGOLIA_ADMIN_API_KEY];
        
        Index *movieIndex;
        NSString *queryAttribute;
        
        movieIndex = [apiClient indexWithName:ALGOLIA_USER_INDEX_NAME];
        queryAttribute = @"ItemName";
        
        
        
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
        
        Query *query = [[Query alloc] init];
        query.query = textField.text;
        query.attributesToRetrieve = keyArray;
        query.attributesToHighlight = @[queryAttribute];
        
        NSString *currentHomeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
        
        [movieIndex search:query completionHandler:^(NSDictionary<NSString *,id> * string, NSError * error) {
            
            NSMutableDictionary *tempSearchResults = [self FillDictWithSearchResults:string keyArray:keyArray];
            
            tempSearchResults = [self ReplaceNullData:tempSearchResults keyArray:keyArray];
            
            tempSearchResults = [self ReplaceNonHomeData:tempSearchResults keyArray:keyArray currentHomeID:currentHomeID];
            
            tempSearchResults = [self RemoveNonHomeData:tempSearchResults keyArray:keyArray];
            
            tempSearchResults = [self RemoveNonValidData:tempSearchResults keyArray:keyArray currentHomeID:currentHomeID];
            
            self->searchResults = [tempSearchResults mutableCopy];
            
            [self AdjustTableViewHeight];
            
            [self.customTableView reloadData];
            
        }];
        
        [self AdjustTableViewHeight];
        
        [self.customTableView reloadData];
        
    }
    
}

#pragma mark - Table View Methods

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    MultiAddTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MultiAddTaskCell"];
    
    NSString *taskName = [self GenerateObjectToUse:indexPath];
    
    cell.titleLabel.text = taskName;
    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self GenerateNumberOfRowsInTableView:section];
    
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(MultiAddTaskCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    CGFloat textFieldSpacing = (height*0.024456);
    
    cell.mainView.frame = CGRectMake(textFieldSpacing, cell.contentView.frame.size.height*0.5 - ((height*0.08152174 > 60?(60):height*0.08152174))*0.5, width - (textFieldSpacing*2), (self.view.frame.size.height*0.07472826 > 55?55:(self.view.frame.size.height*0.07472826)));
    cell.mainViewOverlayView.frame = cell.mainView.frame;
    
    width = CGRectGetWidth(cell.mainView.bounds);
    height = CGRectGetHeight(cell.mainView.bounds);
    
    UIFont *fontSize = [UIFont systemFontOfSize:(self.view.frame.size.height*0.02038043 > 15?15:(self.view.frame.size.height*0.02038043)) weight:UIFontWeightSemibold];
    
    cell.selectView.frame = CGRectMake(width - (self.view.frame.size.height*0.0407 > 30?30:(self.view.frame.size.height*0.0407)) - (self.view.frame.size.height*0.02717 > 20?20:(self.view.frame.size.height*0.02717)),
                                       height*0.5 - ((self.view.frame.size.height*0.0407 > 30?30:(self.view.frame.size.height*0.0407))*0.5),
                                       (self.view.frame.size.height*0.0407 > 30?30:(self.view.frame.size.height*0.0407)),
                                       (self.view.frame.size.height*0.0407 > 30?30:(self.view.frame.size.height*0.0407)));
    
    cell.selectViewImageView.frame = CGRectMake(cell.selectView.frame.size.width*0.5 - ((cell.selectView.frame.size.width*0.35 > 12?12:(cell.selectView.frame.size.width*0.35))*0.5),
                                                cell.selectView.frame.size.height*0.5 - ((cell.selectView.frame.size.height*0.35 > 12?12:(cell.selectView.frame.size.height*0.35))*0.5),
                                                (cell.selectView.frame.size.height*0.35 > 12?12:(cell.selectView.frame.size.height*0.35)),
                                                (cell.selectView.frame.size.height*0.35 > 12?12:(cell.selectView.frame.size.height*0.35)));
    
    cell.titleLabel.font = fontSize;
    cell.titleLabel.textColor = [UIColor blackColor];
    cell.titleLabel.frame = CGRectMake(self.view.frame.size.height*0.02717 > 20?20:(self.view.frame.size.height*0.02717),
                                      height*0.5 - (height*0.75)*0.5,
                                      width - (self.view.frame.size.height*0.02717 > 20?20:(self.view.frame.size.height*0.02717)) - cell.selectView.frame.size.width - (self.view.frame.size.height*0.02717 > 20?20:(self.view.frame.size.height*0.02717)),
                                      height*0.75);
    
    CGFloat cornerRadius = (self.view.frame.size.height*0.2181818182 > 12?12:(self.view.frame.size.height*0.2181818182));
    
    [[[GeneralObject alloc] init] RoundingCorners:_searchBarView topCorners:YES bottomCorners:YES cornerRadius:cornerRadius];
    [[[GeneralObject alloc] init] RoundingCorners:_searchBar topCorners:YES bottomCorners:YES cornerRadius:cornerRadius];
    
    cell.mainViewOverlayView.frame = cell.mainView.frame;
    [cell.mainViewOverlayView setTitle:@"" forState:UIControlStateNormal];
    
    cell.rightArrowImage.contentMode = UIViewContentModeScaleAspectFit;
    cell.rightArrowImage.frame = CGRectMake(width*1 - width*0.02339181 - cell.titleLabel.frame.origin.x, height*0, width*0.02339181, height*1);
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"DidSelect Clicked For %@", currentItemType] completionHandler:^(BOOL finished) {
        
    }];
    
    [_searchBar resignFirstResponder];
    
    NSString *itemID = searchResults && searchResults[@"ItemID"] && [(NSArray *)searchResults[@"ItemID"] count] > indexPath.row ? searchResults[@"ItemID"][indexPath.row] : @"";
    NSString *itemOccurrenceID = searchResults && searchResults[@"ItemOccurrenceID"] && [(NSArray *)searchResults[@"ItemOccurrenceID"] count] > indexPath.row ? searchResults[@"ItemOccurrenceID"][indexPath.row] : @"";
    
    NSString *localCurrencyDecimalSeparatorSymbol = [[[GeneralObject alloc] init] GenerateLocalCurrencyDecimalSeparatorSymbol];
   
    if (searchResults && searchResults[@"ItemType"] && [(NSArray *)searchResults[@"ItemType"] count] > indexPath.row && searchResults[@"ItemType"][indexPath.row] && [[NSString stringWithFormat:@"%@", searchResults[@"ItemType"][indexPath.row]] isEqualToString:@"List"]) {
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ViewingExpenses"];
        [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"ViewingLists"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ViewingChats"];
        
    } else if (searchResults && searchResults[@"ItemAmount"] && [(NSArray *)searchResults[@"ItemAmount"] count] > indexPath.row && searchResults[@"ItemAmount"][indexPath.row] && [[NSString stringWithFormat:@"%@", searchResults[@"ItemAmount"][indexPath.row]] isEqualToString:[NSString stringWithFormat:@"0%@001", localCurrencyDecimalSeparatorSymbol]] == NO) {
        
        [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"ViewingExpenses"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ViewingLists"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ViewingChats"];
        
    } else {
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ViewingExpenses"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ViewingLists"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ViewingChats"];
        
    }
    
    [[[PushObject alloc] init] PushToViewTaskViewController:itemID itemOccurrenceID:itemOccurrenceID itemDictFromPreviousPage:[NSMutableDictionary dictionary] homeMembersArray:_homeMembersArray homeMembersDict:_homeMembersDict itemOccurrencesDict:[NSMutableDictionary dictionary] folderDict:_folderDict taskListDict:_taskListDict templateDict:_templateDict draftDict:_draftDict notificationSettingsDict:_notificationSettingsDict topicDict:_topicDict itemNamesAlreadyUsed:_itemNamesAlreadyUsed allItemAssignedToArrays:_allItemAssignedToArrays allItemTagsArrays:_allItemTagsArrays allItemIDsArrays:_allItemTagsArrays currentViewController:self Superficial:NO];
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return cellHeight;
    
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
    label.hidden = _searchBar.text.length == 0 ? YES : NO;
    [label setText:[NSString stringWithFormat:@"Search results for \"%@\"", _searchBar.text]];
    
    
    
    
    
    
    [view addSubview:mainView];
    [mainView addSubview:label];
    
    
    
    
    
    return view;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger )section {
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    CGFloat height = CGRectGetHeight(self.view.bounds);
    return (height*0.0611413 > 45?(45):height*0.0611413);
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger )section {
    
    return 1.0;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
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
                
            }
            
        }
        
        [tempSearchResultsCopy setObject:arr forKey:key];
        
    }
    
    return tempSearchResultsCopy;
}

-(NSMutableDictionary *)ReplaceNonHomeData:(NSMutableDictionary *)tempSearchResults keyArray:(NSArray *)keyArray currentHomeID:(NSString *)currentHomeID {
    
    NSMutableDictionary *tempSearchResultsCopy = [tempSearchResults mutableCopy];
    
    NSMutableArray *tempArr = [tempSearchResultsCopy[@"ItemUniqueID"] mutableCopy];
    NSMutableArray *tempArrNo1 = [tempSearchResultsCopy[@"ItemHomeID"] mutableCopy];
    
    for (NSString *itemUniqueID in tempArr) {
        
        NSUInteger index = [tempArr indexOfObject:itemUniqueID];
        NSString *itemHomeID = tempArrNo1[index];
        
        if ([itemHomeID isEqualToString:currentHomeID] == NO) {
            
            for (NSString *key in keyArray) {
                
                NSMutableArray *tempArrNo2 = [tempSearchResultsCopy[key] mutableCopy];
                [tempArrNo2 replaceObjectAtIndex:index withObject:@"xxxxx"];
                [tempSearchResultsCopy setObject:tempArrNo2 forKey:key];
                
            }
            
        }
        
    }
    
    return tempSearchResultsCopy;
}

-(NSMutableDictionary *)RemoveNonHomeData:(NSMutableDictionary *)tempSearchResults keyArray:(NSArray *)keyArray {
    
    NSMutableDictionary *tempSearchResultsCopy = [tempSearchResults mutableCopy];
    
    NSMutableDictionary *newDict = [NSMutableDictionary dictionary];
    
    for (NSString *key in keyArray) {
        
        NSMutableArray *tempArr = [tempSearchResultsCopy[key] mutableCopy];
        NSMutableArray *newArr = [NSMutableArray array];
        
        for (id object in tempArr) {
            
            BOOL ObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:object classArr:@[[NSString class]]];
            
            if ((ObjectIsKindOfClass == YES && [object isEqualToString:@"xxxxx"]) == NO) {
                
                [newArr addObject:object];
                
            }
            
        }
        
        [newDict setObject:newArr forKey:key];
        
    }
    
    tempSearchResultsCopy = [newDict mutableCopy];
    
    return tempSearchResultsCopy;
}

-(NSMutableDictionary *)RemoveNonValidData:(NSMutableDictionary *)tempSearchResults keyArray:(NSArray *)keyArray currentHomeID:(NSString *)currentHomeID {
    
    NSMutableDictionary *tempSearchResultsDictCopy = [tempSearchResults mutableCopy];
    NSMutableArray *itemUniqueIDArray = [tempSearchResults[@"ItemUniqueID"] mutableCopy];
    
    for (NSString *itemUniqueID in itemUniqueIDArray) {
        
        NSUInteger index = [itemUniqueIDArray indexOfObject:itemUniqueID];
        
        BOOL TaskIsValidToBeDisplayed = [[[BoolDataObject alloc] init] TaskIsValidToBeDisplayed:tempSearchResultsDictCopy index:index itemType:itemType homeMembersDict:_homeMembersDict keyArray:keyArray];
        
        if (TaskIsValidToBeDisplayed == NO ||
            ([_itemDict[@"ItemUniqueID"] containsObject:itemUniqueID] == NO &&
             [_itemDictNo2[@"ItemUniqueID"] containsObject:itemUniqueID] == NO &&
             [_itemDictNo3[@"ItemUniqueID"] containsObject:itemUniqueID] == NO)) {
            
            if ([tempSearchResultsDictCopy[@"ItemUniqueID"] containsObject:itemUniqueID]) {
                
                NSUInteger index = [tempSearchResultsDictCopy[@"ItemUniqueID"] indexOfObject:itemUniqueID];
                
                for (NSString *key in keyArray) {
                    
                    NSMutableArray *arr = tempSearchResultsDictCopy[key] ? [tempSearchResultsDictCopy[key] mutableCopy] : [NSMutableArray array];
                    if ([arr count] > index) { [arr removeObjectAtIndex:index]; }
                    [tempSearchResultsDictCopy setObject:arr forKey:key];
                    
                }
                
            }
            
        }
        
    }
    
    return tempSearchResultsDictCopy;
}

#pragma mark - CellForRow

-(NSString *)GenerateObjectToUse:(NSIndexPath *)indexPath {
    
    NSString *objectToUse = @"";
    
    if (searchResults.count > 0) {
        
        NSString *searchedTaskName = searchResults && searchResults[@"ItemName"] && [(NSArray *)searchResults[@"ItemName"] count] > indexPath.row ? searchResults[@"ItemName"][indexPath.row] : @"";
        
        objectToUse = searchedTaskName;
        
    } else {
        
        BOOL FirstRowIsDisplayedAndSearchBarHasText = (indexPath.row==0) && (_searchBar.text.length > 0);
        
        if (FirstRowIsDisplayedAndSearchBarHasText) {
            
            NSString *strP1 = NSLocalizedString(@"Search for", @"Search for");
            NSString *strP2 = NSLocalizedString(@"in posts", @"in posts");
            NSString *str = [NSString stringWithFormat:@"%@ \"%@\" %@", strP1, _searchBar.text, strP2];
            
            objectToUse = str;
            
        }
        
    }
    
    return objectToUse;
}

#pragma mark - NumberOfRow

-(NSUInteger)GenerateNumberOfRowsInTableView:(NSInteger)section {
    
    int numberOfRows = 0;
    
    if (searchResults && searchResults[@"ItemID"]) {
        
        return [(NSArray *)searchResults[@"ItemID"] count];
        
    }
    
    return numberOfRows;
}

@end
