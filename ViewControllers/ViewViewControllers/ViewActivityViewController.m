//
//  ViewActivityViewController.m
//  WeDivvy
//
//  Created by Philip Nagel on 12/13/22.
//

#import "UIImageView+Letters.h"

#import "ViewActivityViewController.h"

#import "GeneralObject.h"
#import "GetDataObject.h"
#import "SetDataObject.h"
#import "PushObject.h"
#import "BoolDataObject.h"
#import "LightDarkModeObject.h"

#import "ActivityCell.h"

@interface ViewActivityViewController () {
    
    MRProgressOverlayView *progressView;
    
    NSMutableArray *arrayOfReadActivityID;
    
    NSMutableDictionary *itemActivityDict;
    
}

@end

@implementation ViewActivityViewController

#pragma mark - System Methods

- (void)viewDidLoad {
    [super viewDidLoad];

    [self InitMethod];
    
    [self BarButtonItems];

    if (_ViewingItem) {
        
        [self QueryItemActivity];
        
    } else if (_ViewingHome) {
        
        [self QueryHomeActivity];
        
    }
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    CGFloat navigationBarHeight = [[[GeneralObject alloc] init] GetNavigationBarHeight:self];
    
    CGFloat textFieldSpacing = (height*0.024456);
    
    _customTableView.frame = CGRectMake(width*0.5 - ((width*0.90338164)*0.5), navigationBarHeight + textFieldSpacing, width - ((width*0.5 - ((width*0.90338164)*0.5))*2), 0);
    _customTableView.layer.cornerRadius = 12;
    
    CGRect newRect = self->_customTableView.frame;
    newRect.size.height = [self AdjustTableViewHeight:[[self->itemActivityDict allKeys] mutableCopy] tableView:self->_customTableView];
    self->_customTableView.frame = newRect;
    
}

-(void)viewDidLayoutSubviews {
 
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    CGFloat navigationBarHeight = [[[GeneralObject alloc] init] GetNavigationBarHeight:self];
    
    CGFloat textFieldSpacing = (height*0.024456);
    
    _customTableView.frame = CGRectMake(width*0.5 - ((width*0.90338164)*0.5), navigationBarHeight + textFieldSpacing, width - ((width*0.5 - ((width*0.90338164)*0.5))*2), 0);
    _customTableView.layer.cornerRadius = 12;
    
    CGRect newRect = self->_customTableView.frame;
    newRect.size.height = [self AdjustTableViewHeight:[[self->itemActivityDict allKeys] mutableCopy] tableView:self->_customTableView];
    self->_customTableView.frame = newRect;
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [[[LightDarkModeObject alloc] init] DarkModeTextPrimary]};
        self.view.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        self.customTableView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModePrimary];
        
        [self preferredStatusBarStyle];
        
    }
    
}

#pragma mark - Init Method

-(void)InitMethod {
    
    [self SetUpTitle];
    
    [self SetUpDelegates];
    
    [self SetUpDicts];
    
}

-(void)BarButtonItems {
    
    self.navigationItem.hidesBackButton = YES;
    
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(NavigationBackButtonAction:)];
    self.navigationItem.leftBarButtonItem = newBackButton;
   
//    newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"Read All" style:UIBarButtonItemStyleDone target:self action:@selector(ReadAllAction:)];
//    self.navigationItem.rightBarButtonItem = newBackButton;
    
}

-(IBAction)ReadAllAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Read All Activity Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Would you like mark all acitvity as read?"] message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *completeUncompleteAction = [UIAlertAction actionWithTitle:@"Read All" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Reading All Activity"] completionHandler:^(BOOL finished) {
            
        }];
        
        [self StartProgressView];
        
        [self QueryHomeReadArray:[self->itemActivityDict mutableCopy] completionHandler:^(BOOL finished, NSMutableDictionary *returningItemActivityDict) {
            
            self->itemActivityDict = [returningItemActivityDict mutableCopy];
            
            if (self->_ViewingHome) {
                
                [[[GeneralObject alloc] init] CallNSNotificationMethods:@"UnreadHomeActivity" userInfo:nil locations:@[@"Tasks"]];
                
            }
            
            CGRect newRect = self->_customTableView.frame;
            newRect.size.height = [self AdjustTableViewHeight:[[self->itemActivityDict allKeys] mutableCopy] tableView:self->_customTableView];
            self->_customTableView.frame = newRect;
            
            [self->progressView setHidden:YES];
            [self->_customTableView reloadData];
            
        }];
        
    }];
    
    [actionSheet addAction:completeUncompleteAction];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Real All Cancelled"] completionHandler:^(BOOL finished) {
            
        }];
        
    }]];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
    
}

#pragma mark - SetUp Methods

-(void)SetUpTitle {
    
    self.title = _ViewingHome ? @"Home Activity" : @"Task Activity";
    
}

-(void)SetUpDelegates {
    
    _customTableView.delegate = self;
    _customTableView.dataSource = self;
    
}

-(void)SetUpDicts {
    
    itemActivityDict = [NSMutableDictionary dictionary];
    arrayOfReadActivityID = [NSMutableArray array];
    
}

#pragma mark - UI Methods

-(void)StartProgressView {
    
    self->progressView = [MRProgressOverlayView showOverlayAddedTo:self.navigationController.view animated:YES];
    self->progressView.mode = MRProgressOverlayViewModeIndeterminateSmall;
    
}

-(CGFloat)GenerateCellHeight:(NSString *)activityDescriptionFull {
    
    ActivityCell *cell = [_customTableView dequeueReusableCellWithIdentifier:@"ActivityCell"];
    
    CGFloat width = self.view.frame.size.width - ((self.view.frame.size.width*0.5 - ((self.view.frame.size.width*0.90338164)*0.5))*2);
   
    CGFloat cellSpacing = (self.view.frame.size.height*0.02398801 > 16?(16):self.view.frame.size.height*0.02398801);
    
    CGFloat activityBodyLabelXPos = cell.activityUserImageView.frame.origin.x + cell.activityUserImageView.frame.size.width + width*0.03092784;
    
    CGFloat bodyLabelWidth = width - activityBodyLabelXPos - cell.activityUserImageView.frame.origin.x- cell.activityUserImageView.frame.origin.x - (width - cell.activityReadView.frame.origin.x);
    
    CGRect newRect = cell.activityDescriptionLabel.frame;
    newRect.size.width = bodyLabelWidth;
    cell.activityDescriptionLabel.frame = newRect;
    
    int lineCount = [[[GeneralObject alloc] init] LineCountForText:activityDescriptionFull label:cell.activityDescriptionLabel];
    
    float cellHeightFloat = (self.view.frame.size.height*0.02698651 > 18?(18):self.view.frame.size.height*0.02698651) * lineCount;
   
    cellHeightFloat += (cellSpacing * 2);
   
    return cellHeightFloat;
}

-(NSMutableAttributedString *)GenerateAttributedDescription:(NSString *)activityDescriptionFull username:(NSString *)username usernameNo1:(NSString *)usernameNo1 indexPath:(NSIndexPath *)indexPath cell:(ActivityCell *)cell {
    
    cell.activityDescriptionLabel.font = [UIFont systemFontOfSize:(self.view.frame.size.height*0.02248876 > 15?(15):self.view.frame.size.height*0.02248876)];
    
    UIColor *textColor = cell.activityDescriptionLabel.textColor;
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
    }
    
    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:textColor, NSForegroundColorAttributeName, nil];
    
    NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:activityDescriptionFull attributes:attrsDictionary];
    
    NSArray *itemNameArray = [itemActivityDict[@"ActivityDescription"][indexPath.row] componentsSeparatedByString:@"\""];
    NSString *itemName = [itemNameArray count] > 1 ? [NSString stringWithFormat:@"\"%@\"", itemNameArray[1]] : @"";
    
    NSRange range0 = [[NSString stringWithFormat:@"%@", str] rangeOfString:itemName];
    NSRange range1 = [[NSString stringWithFormat:@"%@", str] rangeOfString:username];
    NSRange range2 = [[NSString stringWithFormat:@"%@", str] rangeOfString:usernameNo1];
    
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:cell.activityDescriptionLabel.font.pointSize weight:UIFontWeightSemibold] range: NSMakeRange(range0.location, range0.length)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:cell.activityDescriptionLabel.font.pointSize weight:UIFontWeightSemibold] range: NSMakeRange(range1.location, range1.length)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:cell.activityDescriptionLabel.font.pointSize weight:UIFontWeightSemibold] range: NSMakeRange(range2.location, range2.length)];
    
    UIColor *color = [UIColor colorWithRed:77.0f/225.0f green:76.0f/225.0f blue:77.0f/225.0f alpha:1.0f];
    
    [str addAttribute:NSForegroundColorAttributeName value:color range: NSMakeRange(range0.location, range0.length)];
    [str addAttribute:NSForegroundColorAttributeName value:color range: NSMakeRange(range1.location, range1.length)];
    [str addAttribute:NSForegroundColorAttributeName value:color range: NSMakeRange(range2.location, range2.length)];
    
    return str;
}

-(CGFloat)AdjustTableViewHeight:(NSMutableArray *)arrayToUse tableView:(UITableView *)tableView {
    
    CGFloat tableViewHeight = 0;
   
    if (arrayToUse.count > 0) {
       
        for (NSString *activityID in itemActivityDict[@"ActivityID"]) {

            NSUInteger activityIndex = [itemActivityDict[@"ActivityID"] indexOfObject:activityID];
            
            NSString *activityDescriptionFull = [self GenerateActivityDescriptionFull:activityIndex];
          
            CGFloat cellHeight = [self GenerateCellHeight:activityDescriptionFull];
          
            tableViewHeight += cellHeight;
            
        }
        
        CGFloat height = CGRectGetHeight(self.view.bounds);
        
        CGFloat bottomPadding = [[[GeneralObject alloc] init] GetBottomPaddingHeight];
        
        CGFloat maxiumHeightToCheck = (tableViewHeight > (height - tableView.frame.origin.y - 12 - bottomPadding));
        
        CGFloat mexiumHeight = (height - tableView.frame.origin.y - 12 - bottomPadding);
      
        if (maxiumHeightToCheck) {
            tableViewHeight = mexiumHeight;
        }
        
    }
  
    return tableViewHeight;
    
}

#pragma mark - UX Methods

-(NSString *)GenerateUsernameForActivity:(NSString *)activityTitle {
    
    for (NSString *userID in _homeMembersDict[@"UserID"]) {
        
        NSUInteger index = [_homeMembersDict[@"UserID"] indexOfObject:userID];
        
        if ([activityTitle containsString:[NSString stringWithFormat:@"%@ ", userID]]) {
            
            NSString *username = _homeMembersDict[@"Username"][index];
            
            activityTitle = [[[GeneralObject alloc] init] GenerateStringWithReplacementString:activityTitle stringToReplace:[NSString stringWithFormat:@"%@ ", userID] replacementString:[NSString stringWithFormat:@"%@ ", username]];
            
            break;
            
        }
        
    }
    
    return activityTitle;
}

-(NSString *)GenerateActivityDescriptionFull:(NSUInteger)activityIndex {
    
    NSString *activityTitle = itemActivityDict[@"ActivityTitle"][activityIndex];
    NSString *activityDescription = itemActivityDict[@"ActivityDescription"][activityIndex];
    
    activityTitle = [self GenerateUsernameForActivity:activityTitle];
    activityDescription = [self GenerateUsernameForActivity:activityDescription];
    
    NSUInteger index = [_homeMembersDict[@"UserID"] containsObject:itemActivityDict[@"ActivityUserID"][activityIndex]] ? [_homeMembersDict[@"UserID"] indexOfObject:itemActivityDict[@"ActivityUserID"][activityIndex]] : -1;
    NSString *username = _homeMembersDict[@"Username"] && [(NSArray *)_homeMembersDict[@"Username"] count] > index && index != -1 ? _homeMembersDict[@"Username"][index] : @"";
    
    NSUInteger indexNo1 = [_homeMembersDict[@"UserID"] containsObject:itemActivityDict[@"ActivityUserIDNo1"][activityIndex]] ? [_homeMembersDict[@"UserID"] indexOfObject:itemActivityDict[@"ActivityUserIDNo1"][activityIndex]] : -1;
    NSString *usernameNo1 = _homeMembersDict[@"Username"] && [(NSArray *)_homeMembersDict[@"Username"] count] > indexNo1 && indexNo1 != -1 ? _homeMembersDict[@"Username"][indexNo1] : @"";
   
    NSString *convertedDateString = [[[GeneralObject alloc] init] GenerateDateWithConvertedFormatWithFormat:@"yyyy-MM-dd HH:mm:ss" dateToConvert:itemActivityDict[@"ActivityDatePosted"][activityIndex] newFormat:@"MMM d" returnAs:[NSString class]];
    NSString *convertedTimeString = [[[GeneralObject alloc] init] GenerateDateWithConvertedFormatWithFormat:@"yyyy-MM-dd HH:mm:ss" dateToConvert:itemActivityDict[@"ActivityDatePosted"][activityIndex] newFormat:@"h:mm a" returnAs:[NSString class]];
    NSString *convertedWeekdayString = [[[GeneralObject alloc] init] GenerateDateWithConvertedFormatWithFormat:@"yyyy-MM-dd HH:mm:ss" dateToConvert:itemActivityDict[@"ActivityDatePosted"][activityIndex] newFormat:@"EEE" returnAs:[NSString class]];
    
    NSString *byString = [itemActivityDict[@"ActivityDescription"][activityIndex] containsString:@"reset"] == NO ? [NSString stringWithFormat:@" by %@", username] : @"";
    NSString *forString = [usernameNo1 length] > 0 ? [NSString stringWithFormat:@" for %@", usernameNo1] : @"";
    NSString *convertedDateStringFinal = [NSString stringWithFormat:@"%@., %@ at %@", convertedWeekdayString, convertedDateString, convertedTimeString];
    
    NSString *activityDescriptionFull = [NSString stringWithFormat:@"%@%@%@ on %@", itemActivityDict[@"ActivityDescription"][activityIndex], byString, forString, convertedDateStringFinal];
    
    return activityDescriptionFull;
}

-(void)QueryHomeReadArray:(NSMutableDictionary *)itemActivityDict completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningItemActivityDict))finishBlock {
    
    NSMutableArray *objectArr = [NSMutableArray array];
    
    for (NSString *activityID in itemActivityDict[@"ActivityID"]) {
       
        NSUInteger index = [itemActivityDict[@"ActivityID"] indexOfObject:activityID];
        
        NSString *activityItemID = itemActivityDict[@"ActivityItemID"] && [(NSArray *)itemActivityDict[@"ActivityItemID"] count] > index ? itemActivityDict[@"ActivityItemID"][index] : @"";
        NSString *activityHomeID = itemActivityDict[@"ActivityHomeID"] && [(NSArray *)itemActivityDict[@"ActivityHomeID"] count] > index ? itemActivityDict[@"ActivityHomeID"][index] : @"";
        NSMutableArray *activityReadArray = itemActivityDict[@"ActivityRead"] && [(NSArray *)itemActivityDict[@"ActivityRead"] count] > index ? [itemActivityDict[@"ActivityRead"][index] mutableCopy] : [NSMutableArray array];
        
        BOOL ObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:activityReadArray classArr:@[[NSArray class], [NSMutableArray class]]];
        
        if (ObjectIsKindOfClass == NO) {
            activityReadArray = [NSMutableArray array];
        }
        
        NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"];
        
        if (ObjectIsKindOfClass == YES) {
            
            if ([activityReadArray containsObject:userID] == NO) {
                
                [activityReadArray addObject:userID];
                
                if (_ViewingHome) {
                    
                    [itemActivityDict setObject:activityReadArray forKey:@"ActivityRead"];
                    
//                    if ([self->arrayOfReadActivityID containsObject:activityID]) {
//                        [self->arrayOfReadActivityID removeObject:activityID];
//                    }
                    
                    if ([[[GeneralObject alloc] init] AddToObjectArrAndCheckIfQueryHasEnded:itemActivityDict[@"ActivityID"] objectArr:objectArr]) {
                        
                        finishBlock(YES, itemActivityDict);
                        
                    }
                    
                } else if (_ViewingItem) {
                    
                    NSString *itemType = [[[GeneralObject alloc] init] GenerateItemType];
                    NSString *collection = [NSString stringWithFormat:@"%@s", itemType];
                    NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
                    
                    [[[SetDataObject alloc] init] UpdateDataItemActivity:homeID collection:collection itemID:activityItemID activityID:activityID setDataDict:@{@"ActivityID" : activityID, @"ActivityItemID" : activityItemID, @"ActivityHomeID" : activityHomeID, @"ActivityRead" : activityReadArray} completionHandler:^(BOOL finished) {
                        
//                        [itemActivityDict setObject:activityReadArray forKey:@"ActivityRead"];
//
//                        if ([self->arrayOfReadActivityID containsObject:activityID]) {
//                            [self->arrayOfReadActivityID removeObject:activityID];
//                        }
                        
                        if ([[[GeneralObject alloc] init] AddToObjectArrAndCheckIfQueryHasEnded:itemActivityDict[@"ActivityID"] objectArr:objectArr]) {
                            
                            finishBlock(YES, itemActivityDict);
                            
                        }
                        
                    }];
                    
                }
                
            } else {
                
                if ([[[GeneralObject alloc] init] AddToObjectArrAndCheckIfQueryHasEnded:itemActivityDict[@"ActivityID"] objectArr:objectArr]) {
                    
                    finishBlock(YES, itemActivityDict);
                    
                }
                
            }
            
        } else {
            
            if ([[[GeneralObject alloc] init] AddToObjectArrAndCheckIfQueryHasEnded:itemActivityDict[@"ActivityID"] objectArr:objectArr]) {
                
                finishBlock(YES, itemActivityDict);
                
            }
            
        }
        
    }
    
}

-(void)QueryItemActivity {
    
    [self StartProgressView];
    
    NSString *itemType = [[[GeneralObject alloc] init] GenerateItemType];
    NSString *collection = [NSString stringWithFormat:@"%@s", itemType];
    
    NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
    
    [[[GetDataObject alloc] init] GetDataItemActivity:collection itemID:_itemID homeID:homeID completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningActivityDict) {
       
        self->itemActivityDict = [[[GeneralObject alloc] init] GenerateDictOfArraysInReverse:[returningActivityDict mutableCopy]];
        
        for (NSString *activityID in self->itemActivityDict[@"ActivityID"]) {
            
            NSUInteger index = [self->itemActivityDict[@"ActivityID"] indexOfObject:activityID];
            NSMutableArray *activityReadArray = self->itemActivityDict[@"ActivityRead"] && [(NSArray *)self->itemActivityDict[@"ActivityRead"] count] > index ? self->itemActivityDict[@"ActivityRead"][index] : [NSMutableArray array];
            
            BOOL ObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:activityReadArray classArr:@[[NSArray class], [NSMutableArray class]]];
            
            if (ObjectIsKindOfClass == NO) {
                activityReadArray = [NSMutableArray array];
            }
            
            NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"];
            
            if (ObjectIsKindOfClass == YES) {
                if ([activityReadArray containsObject:userID]) {
                    [self->arrayOfReadActivityID addObject:activityID];
                }
            }
            
        }
        
        CGRect newRect = self->_customTableView.frame;
        newRect.size.height = [self AdjustTableViewHeight:[[self->itemActivityDict allKeys] mutableCopy] tableView:self->_customTableView];
        self->_customTableView.frame = newRect;
        
        [self->progressView setHidden:YES];
        [self->_customTableView reloadData];
        
    }];
    
}

-(void)QueryHomeActivity {
    
    [self StartProgressView];
    
    NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
    
    [[[GetDataObject alloc] init] GetDataHomeActivity:homeID completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningActivityDict) {
        
        self->itemActivityDict = [[[GeneralObject alloc] init] GenerateDictOfArraysInReverse:[returningActivityDict mutableCopy]];
        
        for (NSString *activityID in self->itemActivityDict[@"ActivityID"]) {
            
            NSUInteger index = [self->itemActivityDict[@"ActivityID"] indexOfObject:activityID];
            NSMutableArray *activityReadArray = self->itemActivityDict[@"ActivityRead"] && [(NSArray *)self->itemActivityDict[@"ActivityRead"] count] > index ? self->itemActivityDict[@"ActivityRead"][index] : [NSMutableArray array];
            
            NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"];
            
            if ([activityReadArray containsObject:userID]) {
                [self->arrayOfReadActivityID addObject:activityID];
            }
            
        }
        
        CGRect newRect = self->_customTableView.frame;
        newRect.size.height = [self AdjustTableViewHeight:[[self->itemActivityDict allKeys] mutableCopy] tableView:self->_customTableView];
        self->_customTableView.frame = newRect;
        
        [self->progressView setHidden:YES];
        [self->_customTableView reloadData];
        
    }];
    
}

#pragma mark - IBAction Methods

-(IBAction)NavigationBackButtonAction:(UIBarButtonItem *)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Navigation Back Button Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - Table View Methods

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    ActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActivityCell"];
   
    UIColor *backgroundColor = [[[GeneralObject alloc] init] GenerateAppColor:0.15f];
    UIColor *textColor = [[[GeneralObject alloc] init] GenerateAppColor:1.0f];
    
    NSUInteger index = [_homeMembersDict[@"UserID"] containsObject:itemActivityDict[@"ActivityUserID"][indexPath.row]] ? [_homeMembersDict[@"UserID"] indexOfObject:itemActivityDict[@"ActivityUserID"][indexPath.row]] : -1;
    NSString *username = _homeMembersDict[@"Username"] && [(NSArray *)_homeMembersDict[@"Username"] count] > index && index != -1 ? _homeMembersDict[@"Username"][index] : @"";
    
    NSUInteger indexNo1 = [_homeMembersDict[@"UserID"] containsObject:itemActivityDict[@"ActivityUserIDNo1"][indexPath.row]] ? [_homeMembersDict[@"UserID"] indexOfObject:itemActivityDict[@"ActivityUserIDNo1"][indexPath.row]] : -1;
    NSString *usernameNo1 = _homeMembersDict[@"Username"] && [(NSArray *)_homeMembersDict[@"Username"] count] > indexNo1 && indexNo1 != -1 ? _homeMembersDict[@"Username"][indexNo1] : @"";
    
    [cell.activityUserImageView setImageWithString:username color:backgroundColor circular:YES textAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Futura-Medium" size:cell.activityUserImageView.frame.size.height*0.45], NSForegroundColorAttributeName:textColor}];

    NSString *activityDescriptionFull = [self GenerateActivityDescriptionFull:indexPath.row];
    NSMutableAttributedString *attributedString = [self GenerateAttributedDescription:activityDescriptionFull username:username usernameNo1:usernameNo1 indexPath:indexPath cell:cell];
   
    [cell.activityDescriptionLabel setAttributedText:attributedString];
 
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [(NSArray *)itemActivityDict[@"ActivityID"] count];
    
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(ActivityCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {

    NSString *paymentDescription = [self GenerateActivityDescriptionFull:indexPath.row];
    CGFloat cellHeightNo1 = [self GenerateCellHeight:paymentDescription];
    
    CGFloat cellHeight = (self.view.frame.size.height*0.10194903 > 68?(68):self.view.frame.size.height*0.10194903);
    
    CGFloat height = cellHeight;
    CGFloat width = self.view.frame.size.width - ((self.view.frame.size.width*0.5 - ((self.view.frame.size.width*0.90338164)*0.5))*2);
    //388
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        cell.contentView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModePrimary];
    }
    
    cell.activityUserImageView.frame = CGRectMake(width*0.03092784, cellHeightNo1*0.5 - (height*0.51470588)*0.5, height*0.51470588, height*0.51470588);
 
    cell.activityUserImageView.layer.borderWidth = 2.0f;
    cell.activityUserImageView.layer.borderColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeSecondary].CGColor : [[[LightDarkModeObject alloc] init] LightModeSecondary].CGColor;
    cell.activityUserImageView.layer.cornerRadius = cell.activityUserImageView.frame.size.height/2;
    cell.activityUserImageView.contentMode = UIViewContentModeScaleAspectFill;

    cell.activityIconSuperView.frame = CGRectMake(cell.activityUserImageView.frame.origin.x + cell.activityUserImageView.frame.size.width - cell.activityUserImageView.frame.size.width*0.65*0.8, cell.activityUserImageView.frame.origin.y + cell.activityUserImageView.frame.size.height - cell.activityUserImageView.frame.size.width*0.65*0.8, cell.activityUserImageView.frame.size.width*0.65, cell.activityUserImageView.frame.size.width*0.65);
    cell.activityIconSuperView.layer.cornerRadius = cell.activityIconSuperView.frame.size.height/2;
    cell.activityIconSuperView.backgroundColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeSecondary] : [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
    
    cell.activityReadView.frame = CGRectMake(width - width*0.03092784 - 8, cellHeightNo1*0.5 - 8, 8, 8);
    cell.activityReadView.layer.cornerRadius = cell.activityReadView.frame.size.height/2;
    cell.activityReadView.hidden = YES;//[arrayOfReadActivityID containsObject:itemActivityDict[@"ActivityID"][indexPath.row]] ? YES : NO;

    
    
    
    CGFloat activityBodyLabelXPos = cell.activityUserImageView.frame.origin.x + cell.activityUserImageView.frame.size.width + width*0.03092784;
   
    cell.activityDescriptionLabel.frame = CGRectMake(activityBodyLabelXPos, height*0.5 - 0*0.5, width - activityBodyLabelXPos - cell.activityUserImageView.frame.origin.x - (width - cell.activityReadView.frame.origin.x), 0);
    
    CGRect newRect = cell.activityDescriptionLabel.frame;
    newRect.size.height = cellHeightNo1;
    newRect.origin.y = cellHeightNo1*0.5 - newRect.size.height*0.5;
    cell.activityDescriptionLabel.frame = newRect;
    
    
    
    
    height = CGRectGetHeight(cell.activityIconSuperView.bounds);
    width = CGRectGetWidth(cell.activityIconSuperView.bounds);
    
    cell.activityIconView.frame = CGRectMake(height*0.5 - height*0.8*0.5, width*0.5 - height*0.8*0.5, height*0.8, height*0.8);
    cell.activityIconView.layer.cornerRadius = cell.activityIconView.frame.size.height/2;
    
    
    
    
    height = CGRectGetHeight(cell.activityIconView.bounds);
    width = CGRectGetWidth(cell.activityIconView.bounds);

    cell.activityIconImageView.frame = CGRectMake(width*0.5 - width*0.55*0.5, height*0.5 - height*0.55*0.5, width*0.55, height*0.55);

    cell.activityIconView.backgroundColor = [UIColor blueColor];

    if ([self->itemActivityDict[@"ActivityAction"][indexPath.row] isEqualToString:@"Adding Task"]) {

        cell.activityIconView.backgroundColor = [UIColor colorWithRed:3.0f/255.0f green:122.0f/255.0f blue:252.0f/255.0f alpha:1.0f];
        cell.activityIconImageView.image = [UIImage imageNamed:@"ActivityCellIcons.Plus.png"];

    } else if ([self->itemActivityDict[@"ActivityAction"][indexPath.row] isEqualToString:@"Editing Task"]) {

        cell.activityIconView.backgroundColor = [UIColor colorWithRed:3.0f/255.0f green:122.0f/255.0f blue:252.0f/255.0f alpha:1.0f];
        cell.activityIconImageView.image = [UIImage imageNamed:@"ActivityCellIcons.Pencil.png"];

    } else if ([self->itemActivityDict[@"ActivityAction"][indexPath.row] isEqualToString:@"Completing Task"]) {

        cell.activityIconView.backgroundColor = [UIColor colorWithRed:54.0f/255.0f green:196.0f/255.0f blue:88.0f/255.0f alpha:1.0f];
        cell.activityIconImageView.image = [UIImage imageNamed:@"ActivityCellIcons.Checkmark.png"];

    } else if ([self->itemActivityDict[@"ActivityAction"][indexPath.row] isEqualToString:@"Uncompleting Task"]) {

        cell.activityIconView.backgroundColor = [UIColor colorWithRed:254.0f/255.0f green:61.0f/255.0f blue:48.0f/255.0f alpha:1.0f];
        cell.activityIconImageView.image = [UIImage imageNamed:@"ActivityCellIcons.XMark.png"];

        CGRect newRect = cell.activityIconImageView.frame;
        newRect.size.height = cell.activityIconView.frame.size.height*0.45;
        newRect.size.width = cell.activityIconView.frame.size.width*0.45;
        newRect.origin.y = cell.activityIconView.frame.size.height*0.5 - newRect.size.height*0.5;
        newRect.origin.x = cell.activityIconView.frame.size.width*0.5 - newRect.size.width*0.5;
        cell.activityIconImageView.frame = newRect;
        
    } else if ([self->itemActivityDict[@"ActivityAction"][indexPath.row] isEqualToString:@"In Progress Task"]) {

        cell.activityIconView.backgroundColor = [UIColor systemYellowColor];
        cell.activityIconImageView.image = [UIImage imageNamed:@"ActivityCellIcons.InProgress.png"];

    } else if ([self->itemActivityDict[@"ActivityAction"][indexPath.row] isEqualToString:@"Not In Progress Task"]) {

        cell.activityIconView.backgroundColor = [UIColor systemYellowColor];
        cell.activityIconImageView.image = [UIImage imageNamed:@"ActivityCellIcons.InProgress.png"];

    } else if ([self->itemActivityDict[@"ActivityAction"][indexPath.row] isEqualToString:@"Won't Do Task"]) {

        cell.activityIconView.backgroundColor = [UIColor colorWithRed:142.0f/255.0f green:140.0f/255.0f blue:147.0f/255.0f alpha:1.0f];
        cell.activityIconImageView.image = [UIImage imageNamed:@"ActivityCellIcons.WontDo.png"];

    } else if ([self->itemActivityDict[@"ActivityAction"][indexPath.row] isEqualToString:@"Will Do Task"]) {

        cell.activityIconView.backgroundColor = [UIColor colorWithRed:142.0f/255.0f green:140.0f/255.0f blue:147.0f/255.0f alpha:1.0f];
        cell.activityIconImageView.image = [UIImage imageNamed:@"ActivityCellIcons.WillDo.png"];

    } else if ([self->itemActivityDict[@"ActivityAction"][indexPath.row] isEqualToString:@"Commeting Task"]) {

        cell.activityIconView.backgroundColor = [UIColor colorWithRed:42.0f/255.0f green:171.0f/255.0f blue:250.0f/255.0f alpha:1.0f];
        cell.activityIconImageView.image = [UIImage imageNamed:@"ActivityCellIcons.Comment.png"];

    } else if ([self->itemActivityDict[@"ActivityAction"][indexPath.row] isEqualToString:@"Reseting Task"]) {

        cell.activityIconView.backgroundColor = [UIColor colorWithRed:60.0f/255.0f green:60.0f/255.0f blue:61.0f/255.0f alpha:1.0f];
        cell.activityIconImageView.image = [UIImage imageNamed:@"ActivityCellIcons.Reset.png"];

    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *itemID = itemActivityDict[@"ActivityItemID"][indexPath.row];
    NSString *itemOccurrenceID = itemActivityDict[@"ActivityItemOccurrenceID"][indexPath.row];
    
    if ([itemID length] > 0) {
        
        [[[PushObject alloc] init] PushToViewTaskViewController:itemID itemOccurrenceID:itemOccurrenceID itemDictFromPreviousPage:[NSMutableDictionary dictionary] homeMembersArray:_homeMembersArray homeMembersDict:_homeMembersDict itemOccurrencesDict:[NSMutableDictionary dictionary] folderDict:_folderDict taskListDict:_taskListDict templateDict:_templateDict draftDict:_draftDict notificationSettingsDict:_notificationSettingsDict topicDict:_topicDict itemNamesAlreadyUsed:_itemNamesAlreadyUsed allItemAssignedToArrays:_allItemAssignedToArrays allItemTagsArrays:_allItemTagsArrays allItemIDsArrays:_allItemTagsArrays currentViewController:self Superficial:NO];
      
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    NSString *paymentDescription = [self GenerateActivityDescriptionFull:indexPath.row];
   
    CGFloat cellHeight = [self GenerateCellHeight:paymentDescription];
   
    return cellHeight;
}

@end
