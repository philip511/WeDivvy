//
//  ViewPaymentsViewController.m
//  WeDivvy
//
//  Created by Philip Nagel on 6/28/21.
//

#import "UIImageView+Letters.h"

#import "ViewPaymentsViewController.h"
#import "SceneDelegate.h"
#import "AssignedToCell.h"
#import "ViewPaymentsCell.h"

#import <SDWebImage/SDWebImage.h>

#import "GeneralObject.h"
#import "GetDataObject.h"
#import "SetDataObject.h"
#import "PushObject.h"
#import "BoolDataObject.h"
#import "LightDarkModeObject.h"

@interface ViewPaymentsViewController () {
    
    NSString *localCurrencySymbol;
    NSString *localCurrencyDecimalSeparatorSymbol;
    NSString *localCurrencyNumberSeparatorSymbol;
    
    NSMutableArray *paymentsDict;
    NSMutableDictionary *paymentsDictNo1;
    NSMutableArray *sectionsArray;
    NSMutableDictionary *owedDict;
    NSMutableDictionary *earnedDict;
    
    int descriptionLabelLineHeight;
    int internalVerticalCellSpacing;
    
    NSMutableArray *specificUserDict;
    
    NSString *selectedRange;
    
}

@end

@implementation ViewPaymentsViewController

#pragma mark - System Methods

- (void)viewDidLoad {
    [super viewDidLoad];
  
    specificUserDict = [NSMutableArray array];
    
    [self InitMethod];
    
    [self BarButtonItems];

    if (_viewingOwed) {
        
        NSMutableDictionary *owedDictLocal = [self GenerateStartingDict];
        [self GenerateOwedDictForSpecificUser:owedDictLocal];
        
    } else {

        [self GenerateOwedDict];
        
    }
    
    if (_viewingEarned) {
        
        NSMutableDictionary *earnedDictLocal = [self GenerateStartingEarnedDict];
        [self GenerateEarnedDictForSpecificUser:earnedDictLocal];
  
    } else {
        
        [self GenerateEarnedDict];
   
    }
    
    [self GeneratePaidDict];
    
    _owedTableView.hidden = NO;
    _paymentsTableView.hidden = YES;

    [self.owedTableView reloadData];
    [self.paymentsTableView reloadData];

}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        return UIStatusBarStyleLightContent;
        
    } else {
        
        return UIStatusBarStyleDefault;
        
    }
    
}

-(void)viewWillLayoutSubviews {
    
    if (_viewingOwed == YES) {
        
        NSString *userIDWhoIsOwed = _viewingUserIDWhoIsOwedMoney;
        NSString *userIDWhoOwes = _viewingUserIDWhoOwesMoney;
        
        NSUInteger indexWhoIsOwed = [_homeMembersDict[@"UserID"] indexOfObject:userIDWhoIsOwed];
        NSUInteger indexWhoOwes = [_homeMembersDict[@"UserID"] indexOfObject:userIDWhoOwes];
        
        NSString *usernameWhoIsOwed = _homeMembersDict && _homeMembersDict[@"Username"] && [(NSArray *)_homeMembersDict[@"Username"] count] > indexWhoIsOwed ? _homeMembersDict[@"Username"][indexWhoIsOwed] : @"";
        NSString *usernameWhoOwes = _homeMembersDict && _homeMembersDict[@"Username"] && [(NSArray *)_homeMembersDict[@"Username"] count] > indexWhoOwes ? _homeMembersDict[@"Username"][indexWhoOwes] : @"";
        
        self.title = [NSString stringWithFormat:@"%@ owes %@", usernameWhoOwes, usernameWhoIsOwed];
        
    } else if (_viewingEarned == YES) {
        
        NSString *userIDWhoIsOwed = _viewingUserIDWhoIsOwedMoney;
//        NSString *userIDWhoOwes = _viewingUserIDWhoOwesMoney;
        
        NSUInteger indexWhoIsOwed = [_homeMembersDict[@"UserID"] indexOfObject:userIDWhoIsOwed];
//        NSUInteger indexWhoOwes = [_homeMembersDict[@"UserID"] indexOfObject:userIDWhoOwes];
        
        NSString *usernameWhoIsOwed = _homeMembersDict && _homeMembersDict[@"Username"] && [(NSArray *)_homeMembersDict[@"Username"] count] > indexWhoIsOwed ? _homeMembersDict[@"Username"][indexWhoIsOwed] : @"";
//        NSString *usernameWhoOwes = _homeMembersDict && _homeMembersDict[@"Username"] && [(NSArray *)_homeMembersDict[@"Username"] count] > indexWhoOwes ? _homeMembersDict[@"Username"][indexWhoOwes] : @"";
        
        self.title = [NSString stringWithFormat:@"%@ earned", usernameWhoIsOwed];
        
    } else {
        
        self.title = @"Expenses";
        
    }
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    CGFloat navigationBarHeight = [[[GeneralObject alloc] init] GetNavigationBarHeight:self];
    CGFloat bottomPadding = [[[GeneralObject alloc] init] GetBottomPaddingHeight];
    CGFloat textFieldSpacing = (height*0.024456);
    
    descriptionLabelLineHeight = (self.view.frame.size.height*0.02698651 > 18?(18):self.view.frame.size.height*0.02698651);
    internalVerticalCellSpacing = (self.view.frame.size.height*0.02398801 > 16?(16):self.view.frame.size.height*0.02398801);
    
    _paymentsTableView.layer.cornerRadius = 12;
    
    _customSegmentControl.frame = CGRectMake(width*0.5 - 200*0.5, navigationBarHeight + textFieldSpacing, 200, _customSegmentControl.frame.size.height);
    _customSegmentControl.hidden = _viewingOwed || _viewingEarned;
    _owedTableView.frame = CGRectMake(width*0.5 - ((width*0.90338164)*0.5), _customSegmentControl.hidden ? navigationBarHeight : _customSegmentControl.frame.origin.y + _customSegmentControl.frame.size.height, width - ((width*0.5 - ((width*0.90338164)*0.5))*2), height - (_customSegmentControl.frame.origin.y + _customSegmentControl.frame.size.height) - textFieldSpacing - bottomPadding);
    _paymentsTableView.frame = CGRectMake(width*0.5 - ((width*0.90338164)*0.5), _customSegmentControl.frame.origin.y + _customSegmentControl.frame.size.height, width - ((width*0.5 - ((width*0.90338164)*0.5))*2), height - (_customSegmentControl.frame.origin.y + _customSegmentControl.frame.size.height) - textFieldSpacing - bottomPadding);
    _emptyTableViewView.frame = CGRectMake(0, 0, width, height*0.5);
    
    _owedTableView.layer.cornerRadius = 12;
    _paymentsTableView.layer.cornerRadius = 12;
    
    
    
    
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
    
    
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        self.view.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        self.navigationController.navigationBar.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [[[LightDarkModeObject alloc] init] DarkModeTextPrimary]};
        self.emptyTableViewBodyLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        self.emptyTableViewTitleLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextSecondary];
        
        [self preferredStatusBarStyle];
        
    } else {
        
        self.navigationController.navigationBar.backgroundColor = self.view.backgroundColor;
        
    }
    
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    
}

#pragma mark - Init Methods

-(void)InitMethod {
    
    [self SetUpAnalytics];
    
    [self SetUpLocalCurrencySymbol];
    
    [self SetUpTableView];
    
    [self SetUpEmptyTableViewView];
    
    [self SetUpDicts];
    
}

-(void)BarButtonItems {
    
    self.navigationItem.hidesBackButton = YES;
    
    UIBarButtonItem *barButtonItem;
    
    barButtonItem = [[UIBarButtonItem alloc]
                     initWithTitle:@"Back"
                     style:UIBarButtonItemStylePlain
                     target:self
                     action:@selector(NavigationBackButtonAction:)];
    
    self.navigationItem.leftBarButtonItem = barButtonItem;
    
    UIMenu *ellipsisMenu = [self GenerateItemContextMenu];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"ellipsis"] menu:ellipsisMenu];//[[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"ellipsis"] style:UIBarButtonItemStylePlain target:self action:@selector(CalendarSettingsTapGesture:)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
}

#pragma mark - Setup Methods

-(void)SetUpAnalytics {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewViewController:@"ViewPaymentsViewController" completionHandler:^(BOOL finished) {
        
    }];
    
}

-(void)SetUpLocalCurrencySymbol {
    
    localCurrencySymbol = [[[GeneralObject alloc] init] GenerateLocalCurrencySymbol];
    localCurrencyDecimalSeparatorSymbol = [[[GeneralObject alloc] init] GenerateLocalCurrencyDecimalSeparatorSymbol];
    localCurrencyNumberSeparatorSymbol = [[[GeneralObject alloc] init] GenerateLocalCurrencyNumberSeparatorSymbol];
    
}

-(void)SetUpTableView {
    
    _owedTableView.hidden = YES;
    _paymentsTableView.hidden = YES;
    
    _owedTableView.delegate = self;
    _owedTableView.dataSource = self;
    
    _paymentsTableView.delegate = self;
    _paymentsTableView.dataSource = self;
    
}

-(void)SetUpEmptyTableViewView {
    
    _emptyTableViewView.hidden = YES;
    
    _emptyTableViewImage.image = [UIImage imageNamed:@"EmptyViewIcons.NoPayments.png"];
    
    if ([_customSegmentControl selectedSegmentIndex] == 0) {
        
        _emptyTableViewTitleLabel.text = @"Expenses Owed";
        _emptyTableViewBodyLabel.text = @"What your home members owe will show up here.";
        
    } else if ([_customSegmentControl selectedSegmentIndex] == 1) {
        
        _emptyTableViewTitleLabel.text = @"Expenses Paid";
        _emptyTableViewBodyLabel.text = @"What your home members paid will show up here.";
        
    } else if ([_customSegmentControl selectedSegmentIndex] == 2) {
        
        _emptyTableViewTitleLabel.text = @"Expenses Earned";
        _emptyTableViewBodyLabel.text = @"What your home members earned will show up here.";
        
    }
    
}

-(void)SetUpDicts {
    
    sectionsArray = [NSMutableArray array];
    owedDict = [NSMutableDictionary dictionary];
    paymentsDict = [NSMutableArray array];
    paymentsDictNo1 = [NSMutableDictionary dictionary];
    
}

#pragma mark - UI Methods

-(CGFloat)GenerateCellHeight:(NSString *)activityDescriptionFull tableView:(UITableView *)tableView {
    
    ViewPaymentsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ViewPaymentsCell"];
    
    CGFloat width = self.view.frame.size.width - ((self.view.frame.size.width*0.5 - ((self.view.frame.size.width*0.90338164)*0.5))*2);
    
    CGFloat descriptionLabelWidth = width - cell.paymentDescriptionLabel.frame.origin.x - (width*0.03092784);
    
    CGRect newRect = cell.paymentDescriptionLabel.frame;
    newRect.size.width = descriptionLabelWidth;
    cell.paymentDescriptionLabel.frame = newRect;
    
    int lineCount = [[[GeneralObject alloc] init] LineCountForText:activityDescriptionFull label:cell.paymentDescriptionLabel];
    
    float cellHeight = (descriptionLabelLineHeight * lineCount) + (internalVerticalCellSpacing * 2);
    
    if (tableView == _paymentsTableView) {
        
        cellHeight = (descriptionLabelLineHeight * lineCount) + (internalVerticalCellSpacing * 2) + descriptionLabelLineHeight;
        
    }
   
    return cellHeight;
}

-(void)EmptyTableViewHiddenStatus {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        BOOL ItemFound = NO;
        
        ItemFound = self->_viewingOwed == NO && self->_viewingEarned == NO ? self->paymentsDict.count > 0 || [[self->owedDict allKeys] count] > 0 : [self->specificUserDict count];
        
        self->_emptyTableViewView.hidden = ItemFound;
        
    });
    
}

#pragma mark - UX Methods

-(UIMenu *)GenerateItemContextMenu {
    
    NSMutableArray* ellipsisActions = [[NSMutableArray alloc] init];
    
    
    
    
    UIMenu *allTimeMenu = [self GenerateTopContextMenuAllTimeMenu];
    [ellipsisActions addObject:allTimeMenu];
    
    UIMenu *assignedToMenu = [self GenerateTopContextMenuAssignedToMenu];
    [ellipsisActions addObject:assignedToMenu];
    
    
    
    
    UIMenu *ellipsisMenu = [UIMenu menuWithTitle:@"Select a date range" children:ellipsisActions];
    
    return ellipsisMenu;
}

-(UIMenu *)GenerateTopContextMenuAssignedToMenu {
    
    NSMutableArray *actions1 = [NSMutableArray array];
    
    NSArray *arr = @[@"This Week", @"Last Week", @"This Month", @"Last Month"];
    
    for (NSString *string in arr) {
        
        UIImage *image = [string isEqualToString:selectedRange] ? [UIImage systemImageNamed:@"checkmark"] : nil;
        
        [actions1 addObject:[UIAction actionWithTitle:string image:image identifier:string handler:^(__kindof UIAction * _Nonnull action) {
            
            self->selectedRange = string;
            
            [self BarButtonItems];
            
            if (self->_viewingOwed) {
                
                NSMutableDictionary *owedDictLocal = [self GenerateStartingDict];
                [self GenerateOwedDictForSpecificUser:owedDictLocal];
                
            } else {
                
                [self GenerateOwedDict];
                
            }
            
            if (self->_viewingEarned) {
                
                NSMutableDictionary *earnedDictLocal = [self GenerateStartingEarnedDict];
                [self GenerateEarnedDictForSpecificUser:earnedDictLocal];
                
            } else {
                
                [self GenerateEarnedDict];
                
            }
            
            [self GeneratePaidDict];
            
            [self.owedTableView reloadData];
            [self.paymentsTableView reloadData];
            
        }]];
        
    }
    
    UIMenu *menu = [UIMenu menuWithTitle:@"" image:nil identifier:@"" options:UIMenuOptionsDisplayInline children:actions1];
    
    return menu;
}

-(UIMenu *)GenerateTopContextMenuAllTimeMenu {
    
    NSMutableArray *actions1 = [NSMutableArray array];
    
    NSArray *arr = @[@"All Time"];
   
    for (NSString *string in arr) {
        
        UIImage *image = [string isEqualToString:selectedRange] || [selectedRange isEqualToString:@""] || selectedRange == NULL ? [UIImage systemImageNamed:@"checkmark"] : nil;
        
        [actions1 addObject:[UIAction actionWithTitle:string image:image identifier:string handler:^(__kindof UIAction * _Nonnull action) {
            
            self->selectedRange = @"";
            
            [self BarButtonItems];
            
            if (self->_viewingOwed) {
                
                NSMutableDictionary *owedDictLocal = [self GenerateStartingDict];
                [self GenerateOwedDictForSpecificUser:owedDictLocal];
                
            } else {
                
                [self GenerateOwedDict];
                
            }
            
            if (self->_viewingEarned) {
                
                NSMutableDictionary *earnedDictLocal = [self GenerateStartingEarnedDict];
                [self GenerateEarnedDictForSpecificUser:earnedDictLocal];
                
            } else {
                
                [self GenerateEarnedDict];
                
            }
            
            [self GeneratePaidDict];
            
            [self.owedTableView reloadData];
            [self.paymentsTableView reloadData];
            
        }]];
        
    }
    
    UIMenu *menu = [UIMenu menuWithTitle:@"" image:nil identifier:@"All Time" options:UIMenuOptionsDisplayInline children:actions1];
    
    return menu;
}

-(NSMutableDictionary *)GenerateOwedDictForSpecificUser:(NSMutableDictionary *)owedDictLocal {
    
    for (NSString *userIDs in [owedDictLocal allKeys]) {
        
        NSArray *arr = [userIDs componentsSeparatedByString:@" •• "];
        NSString *userIDWhoIsOwedMoney = arr[0];
        NSString *userIDWhoOwesMoney = arr[1];
        
        if ([userIDWhoOwesMoney isEqualToString:_viewingUserIDWhoOwesMoney] && [userIDWhoIsOwedMoney isEqualToString:_viewingUserIDWhoIsOwedMoney]) {
            
            for (NSString *itemUniqueID in _dataDisplayDict[@"ItemUniqueID"]) {
                
                NSUInteger index = [_dataDisplayDict[@"ItemUniqueID"] indexOfObject:itemUniqueID];
                
                NSString *itemAmount = _dataDisplayDict[@"ItemAmount"] && [(NSArray *)_dataDisplayDict[@"ItemAmount"] count] > index ? _dataDisplayDict[@"ItemAmount"][index] : [NSString stringWithFormat:@"0%@00", localCurrencyDecimalSeparatorSymbol];
                NSString *itemName = _dataDisplayDict[@"ItemName"] && [(NSArray *)_dataDisplayDict[@"ItemName"] count] > index ? _dataDisplayDict[@"ItemName"][index] : @"";
                NSString *itemCreatedBy = _dataDisplayDict[@"ItemCreatedBy"] && [(NSArray *)_dataDisplayDict[@"ItemCreatedBy"] count] > index ? _dataDisplayDict[@"ItemCreatedBy"][index] : @"";
                NSMutableDictionary *itemCompletedDict = _dataDisplayDict[@"ItemCompletedDict"] && [(NSArray *)_dataDisplayDict[@"ItemCompletedDict"] count] > index ? _dataDisplayDict[@"ItemCompletedDict"][index] : [NSMutableDictionary dictionary];
                NSMutableDictionary *itemCostPerPerson = _dataDisplayDict[@"ItemCostPerPerson"] && [(NSArray *)_dataDisplayDict[@"ItemCostPerPerson"] count] > index ? _dataDisplayDict[@"ItemCostPerPerson"][index] : [NSMutableDictionary dictionary];
                NSMutableArray *itemAssignedTo = _dataDisplayDict[@"ItemAssignedTo"] && [(NSArray *)_dataDisplayDict[@"ItemAssignedTo"] count] > index ? _dataDisplayDict[@"ItemAssignedTo"][index] : [NSMutableArray array];
                
                BOOL TaskWasCreatedByFirstUserAndWasNotCompletedBySecondUser = ([itemCreatedBy isEqualToString:userIDWhoIsOwedMoney] && [[itemCompletedDict allKeys] containsObject:userIDWhoOwesMoney] == NO && [itemAssignedTo containsObject:userIDWhoOwesMoney] == YES);
                
                if (TaskWasCreatedByFirstUserAndWasNotCompletedBySecondUser == YES) {
                   
                    NSString *itemAmountString = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:itemAmount arrayOfSymbols:@[localCurrencyNumberSeparatorSymbol, localCurrencySymbol]];
                    itemAmountString = [[[GeneralObject alloc] init] GenerateLocalCurrencyStringWithReverseSeparatorsForeign:itemAmountString];
                    
                    NSString *costPerPerson = itemCostPerPerson[userIDWhoOwesMoney];
                    costPerPerson = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:costPerPerson arrayOfSymbols:@[localCurrencyNumberSeparatorSymbol, localCurrencySymbol]];
                    costPerPerson = [[[GeneralObject alloc] init] GenerateLocalCurrencyStringWithReverseSeparatorsForeign:costPerPerson];
                    
                    float itemAmountFloat =
                    costPerPerson &&
                    [costPerPerson isEqualToString:[NSString stringWithFormat:@"%@0%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol]] == NO ?
                    [costPerPerson floatValue] :
                    [itemAmountString floatValue]/[itemAssignedTo count];
                   
                    NSString *itemAmountFloatString = [NSString stringWithFormat:@"%.2f", itemAmountFloat];
                   
                    itemAmountFloatString = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:itemAmountFloatString arrayOfSymbols:@[localCurrencyDecimalSeparatorSymbol, localCurrencyNumberSeparatorSymbol, localCurrencySymbol]];
                    itemAmountFloatString = [[[GeneralObject alloc] init] GenerateAmountInTextFieldInProperFormat:NSRangeFromString(itemAmountFloatString) replacementString:itemAmountFloatString];
                   
                    [specificUserDict addObject:@{@"ItemAmount" : itemAmountFloatString, @"ItemName" : itemName, @"UserIDNo1" : userIDWhoIsOwedMoney, @"UserIDNo2" : userIDWhoOwesMoney}];
                
                }
                
            }
                
        }
        
    }
    
    return owedDictLocal;
}

-(NSMutableDictionary *)GenerateEarnedDictForSpecificUser:(NSMutableDictionary *)earnedDictLocal {
    
    for (NSString *userIDs in [earnedDictLocal allKeys]) {
        
        NSString *userIDWhoIsOwedMoney = userIDs;
       
        if ([userIDWhoIsOwedMoney isEqualToString:_viewingUserIDWhoIsOwedMoney]) {
            
            for (NSString *itemUniqueID in _itemDict[@"ItemUniqueID"]) {
                
                NSUInteger index = [_itemDict[@"ItemUniqueID"] indexOfObject:itemUniqueID];
                
                NSString *itemAmount = _itemDict[@"ItemAmount"] && [(NSArray *)_itemDict[@"ItemAmount"] count] > index ? _itemDict[@"ItemAmount"][index] : [NSString stringWithFormat:@"0%@00", localCurrencyDecimalSeparatorSymbol];
                NSString *itemName = _itemDict[@"ItemName"] && [(NSArray *)_itemDict[@"ItemName"] count] > index ? _itemDict[@"ItemName"][index] : @"";
                NSString *itemCreatedBy = _itemDict[@"ItemCreatedBy"] && [(NSArray *)_itemDict[@"ItemCreatedBy"] count] > index ? _itemDict[@"ItemCreatedBy"][index] : @"";
                NSMutableDictionary *itemCompletedDict = _itemDict[@"ItemCompletedDict"] && [(NSArray *)_itemDict[@"ItemCompletedDict"] count] > index ? _itemDict[@"ItemCompletedDict"][index] : [NSMutableDictionary dictionary];
                NSMutableDictionary *itemCostPerPerson = _itemDict[@"ItemCostPerPerson"] && [(NSArray *)_itemDict[@"ItemCostPerPerson"] count] > index ? _itemDict[@"ItemCostPerPerson"][index] : [NSMutableDictionary dictionary];
                NSMutableArray *itemAssignedTo = _itemDict[@"ItemAssignedTo"] && [(NSArray *)_itemDict[@"ItemAssignedTo"] count] > index ? _itemDict[@"ItemAssignedTo"][index] : [NSMutableArray array];
               
                BOOL TaskWasCreatedByFirstUserAndWasCompletedBySecondUser = ([itemCreatedBy isEqualToString:userIDWhoIsOwedMoney] == YES);
              
                if (TaskWasCreatedByFirstUserAndWasCompletedBySecondUser == YES) {
                   
                    NSString *itemAmountString = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:itemAmount arrayOfSymbols:@[localCurrencyNumberSeparatorSymbol, localCurrencySymbol]];
                    itemAmountString = [[[GeneralObject alloc] init] GenerateLocalCurrencyStringWithReverseSeparatorsForeign:itemAmountString];
                    
                    for (NSString *userIDWhoOwesMoney in [itemCompletedDict allKeys]) {
                       
                        NSString *costPerPerson = itemCostPerPerson[userIDWhoOwesMoney];
                        costPerPerson = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:costPerPerson arrayOfSymbols:@[localCurrencyNumberSeparatorSymbol, localCurrencySymbol]];
                        costPerPerson = [[[GeneralObject alloc] init] GenerateLocalCurrencyStringWithReverseSeparatorsForeign:costPerPerson];
                        
                        float itemAmountFloat =
                        costPerPerson &&
                        [costPerPerson isEqualToString:[NSString stringWithFormat:@"%@0%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol]] == NO ?
                        [costPerPerson floatValue] :
                        [itemAmountString floatValue]/[itemAssignedTo count];
                        
                        NSString *itemAmountFloatString = [NSString stringWithFormat:@"%.2f", itemAmountFloat];
                        
                        itemAmountFloatString = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:itemAmountFloatString arrayOfSymbols:@[localCurrencyDecimalSeparatorSymbol, localCurrencyNumberSeparatorSymbol, localCurrencySymbol]];
                        itemAmountFloatString = [[[GeneralObject alloc] init] GenerateAmountInTextFieldInProperFormat:NSRangeFromString(itemAmountFloatString) replacementString:itemAmountFloatString];
                       
                        [specificUserDict addObject:@{@"ItemAmount" : itemAmountFloatString, @"ItemName" : itemName, @"UserIDNo1" : userIDWhoIsOwedMoney, @"UserIDNo2" : userIDWhoOwesMoney}];
                   
                    }
                 
                }
                
            }
            
        }
   
    }
    
    return earnedDictLocal;
}

#pragma mark Owed Dict

-(void)GenerateOwedDict {
   
    NSMutableDictionary *owedDictLocal = [self GenerateStartingDict];
   
    owedDictLocal = [self GenerateOwedDict:owedDictLocal];
    
    owedDict = [self GenerateOwedDictWithoutUsersWhoArentOwed:owedDictLocal];
    owedDict = [[self GenerateOwedDictWithKeys] mutableCopy];
   
    for (NSString *key in [[owedDict allKeys] mutableCopy]) {
        if ([[owedDict[key] allKeys] count] == 0) {
            [owedDict removeObjectForKey:key];
        }
    }
    
    [self EmptyTableViewHiddenStatus];

    [self.owedTableView reloadData];
    
}

#pragma mark

-(NSMutableDictionary *)GenerateStartingDict {
    
    NSMutableDictionary *startingDict = [NSMutableDictionary dictionary];
    
    for (NSString *userID in _homeMembersDict[@"UserID"]) {
        for (NSString *userIDNo1 in _homeMembersDict[@"UserID"]) {
            [startingDict setObject:[NSString stringWithFormat:@"0%@00", localCurrencyDecimalSeparatorSymbol] forKey:[NSString stringWithFormat:@"%@ •• %@", userID, userIDNo1]];
        }
    }
    
    return startingDict;
}

-(NSMutableDictionary *)GenerateStartingEarnedDict {
    
    NSMutableDictionary *startingDict = [NSMutableDictionary dictionary];
    
    for (NSString *userID in _homeMembersDict[@"UserID"]) {
        [startingDict setObject:[NSString stringWithFormat:@"0%@00", localCurrencyDecimalSeparatorSymbol] forKey:[NSString stringWithFormat:@"%@", userID]];
    }
    
    return startingDict;
}

-(NSMutableDictionary *)GenerateOwedDict:(NSMutableDictionary *)owedDictLocal {
  
    for (NSString *userIDs in [owedDictLocal allKeys]) {
       
        NSArray *arr = [userIDs componentsSeparatedByString:@" •• "];
        NSString *userIDWhoIsOwedMoney = arr[0];
        NSString *userIDWhoOwesMoney = arr[1];
        
        float totalOwedToUserWhoIsOwedMoney = 0.0;
      
        for (NSString *itemUniqueID in _dataDisplayDict[@"ItemUniqueID"]) {
            
            NSUInteger index = [_dataDisplayDict[@"ItemUniqueID"] indexOfObject:itemUniqueID];
            
            NSString *itemAmount = _dataDisplayDict[@"ItemAmount"] && [(NSArray *)_dataDisplayDict[@"ItemAmount"] count] > index ? _dataDisplayDict[@"ItemAmount"][index] : [NSString stringWithFormat:@"0%@00", localCurrencyDecimalSeparatorSymbol];
            NSString *itemCreatedBy = _dataDisplayDict[@"ItemCreatedBy"] && [(NSArray *)_dataDisplayDict[@"ItemCreatedBy"] count] > index ? _dataDisplayDict[@"ItemCreatedBy"][index] : @"";
            NSString *itemUniqueID = _dataDisplayDict[@"ItemUniqueID"] && [(NSArray *)_dataDisplayDict[@"ItemUniqueID"] count] > index ? _dataDisplayDict[@"ItemUniqueID"][index] : @"";
            NSMutableDictionary *itemCompletedDict = _dataDisplayDict[@"ItemCompletedDict"] && [(NSArray *)_dataDisplayDict[@"ItemCompletedDict"] count] > index ? _dataDisplayDict[@"ItemCompletedDict"][index] : [NSMutableDictionary dictionary];
            NSMutableDictionary *itemCostPerPerson = _dataDisplayDict[@"ItemCostPerPerson"] && [(NSArray *)_dataDisplayDict[@"ItemCostPerPerson"] count] > index ? _dataDisplayDict[@"ItemCostPerPerson"][index] : [NSMutableDictionary dictionary];
            NSMutableArray *itemAssignedTo = _dataDisplayDict[@"ItemAssignedTo"] && [(NSArray *)_dataDisplayDict[@"ItemAssignedTo"] count] > index ? _dataDisplayDict[@"ItemAssignedTo"][index] : [NSMutableArray array];
          
            BOOL TaskWasCreatedByFirstUserAndWasNotCompletedBySecondUser = ([itemCreatedBy isEqualToString:userIDWhoIsOwedMoney] && [[itemCompletedDict allKeys] containsObject:userIDWhoOwesMoney] == NO && [itemAssignedTo containsObject:userIDWhoOwesMoney] == YES);
           
            NSArray *arr = [itemUniqueID componentsSeparatedByString:@" "];
            NSDate *itemUniqueIDInDateForm = [[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:@"yyyy-MM-dd" dateToConvert:arr[0] returnAs:[NSDate class]];
            
            if (TaskWasCreatedByFirstUserAndWasNotCompletedBySecondUser == YES &&
                [self isDateInCurrentYear:itemUniqueIDInDateForm] &&
                [self isDateInLastYear:itemUniqueIDInDateForm] &&
                [self isDateInCurrentMonth:itemUniqueIDInDateForm] &&
                [self isDateInLastMonth:itemUniqueIDInDateForm] &&
                [self isDateInCurrentWeek:itemUniqueIDInDateForm] &&
                [self isDateInLastWeek:itemUniqueIDInDateForm]) {
               
                NSString *itemAmountString = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:itemAmount arrayOfSymbols:@[localCurrencyNumberSeparatorSymbol, localCurrencySymbol]];
                itemAmountString = [[[GeneralObject alloc] init] GenerateLocalCurrencyStringWithReverseSeparatorsForeign:itemAmountString];
               
                NSString *costPerPerson = itemCostPerPerson[userIDWhoOwesMoney];
               
                costPerPerson = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:costPerPerson arrayOfSymbols:@[localCurrencyNumberSeparatorSymbol, localCurrencySymbol]];
                costPerPerson = [[[GeneralObject alloc] init] GenerateLocalCurrencyStringWithReverseSeparatorsForeign:costPerPerson];
                
                float itemAmountFloat =
                costPerPerson &&
                [costPerPerson isEqualToString:[NSString stringWithFormat:@"%@0%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol]] == NO ?
                [costPerPerson floatValue] :
                [itemAmountString floatValue]/[itemAssignedTo count];
               
                totalOwedToUserWhoIsOwedMoney += itemAmountFloat;
           
            }
            
        }
        
        NSString *totalOwedToUserWhoIsOwedMoneyString = [NSString stringWithFormat:@"%.2f", totalOwedToUserWhoIsOwedMoney];
       
        totalOwedToUserWhoIsOwedMoneyString = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:totalOwedToUserWhoIsOwedMoneyString arrayOfSymbols:@[localCurrencyDecimalSeparatorSymbol, localCurrencyNumberSeparatorSymbol, localCurrencySymbol]];
        totalOwedToUserWhoIsOwedMoneyString = [[[GeneralObject alloc] init] GenerateAmountInTextFieldInProperFormat:NSRangeFromString(totalOwedToUserWhoIsOwedMoneyString) replacementString:totalOwedToUserWhoIsOwedMoneyString];
       
        [owedDictLocal setObject:totalOwedToUserWhoIsOwedMoneyString forKey:[NSString stringWithFormat:@"%@ •• %@", userIDWhoIsOwedMoney, userIDWhoOwesMoney]];
        
    }
    
    return owedDictLocal;
}

- (BOOL)isDateInCurrentYear:(NSDate *)date {
    
    if ([selectedRange isEqualToString:@"Current Year"]) {
        
        // Create an instance of NSCalendar
        NSCalendar *calendar = [NSCalendar currentCalendar];
        
        // Extract the year component from the current date
        NSDateComponents *currentDateComponents = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
        
        // Extract the year component from the provided date
        NSDateComponents *dateComponents = [calendar components:NSCalendarUnitYear fromDate:date];
        
        // Compare the year components to check if the date is in the current year
        return currentDateComponents.year == dateComponents.year;
        
    }
    
    return YES;
}

- (BOOL)isDateInLastYear:(NSDate *)date {
    
    if ([selectedRange isEqualToString:@"Last Year"]) {
        
        // Create an instance of NSCalendar
        NSCalendar *calendar = [NSCalendar currentCalendar];
        
        // Extract the year component from the current date
        NSDateComponents *currentDateComponents = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
        
        // Extract the year component from the provided date
        NSDateComponents *dateComponents = [calendar components:NSCalendarUnitYear fromDate:date];
        
        // Compare the year components to check if the date is in the current year
        return currentDateComponents.year-1 == dateComponents.year;
        
    }
    
    return YES;
}

- (BOOL)isDateInCurrentMonth:(NSDate *)date {
    
    if ([selectedRange isEqualToString:@"Current Month"]) {
        
        // Create an instance of NSCalendar
        NSCalendar *calendar = [NSCalendar currentCalendar];
        
        // Extract the month and year components from the current date
        NSDateComponents *currentDateComponents = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:[NSDate date]];
        
        // Extract the month and year components from the provided date
        NSDateComponents *dateComponents = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:date];
        
        // Compare the month and year components to check if the date is in the current month
        return (currentDateComponents.year == dateComponents.year) && (currentDateComponents.month == dateComponents.month);
        
    }
    
    return YES;
}

- (BOOL)isDateInLastMonth:(NSDate *)date {
    
    if ([selectedRange isEqualToString:@"Last Month"]) {
        
        // Create an instance of NSCalendar
        NSCalendar *calendar = [NSCalendar currentCalendar];
        
        // Extract the month and year components from the current date
        NSDateComponents *currentDateComponents = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:[NSDate date]];
        
        // Extract the month and year components from the provided date
        NSDateComponents *dateComponents = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:date];
        
        NSInteger monthToCheck = currentDateComponents.month;
        
        if (monthToCheck == 1) {
            return (currentDateComponents.year-1 == dateComponents.year) && (12 == dateComponents.month);
        }
        
        // Compare the month and year components to check if the date is in the current month
        return (currentDateComponents.year == dateComponents.year) && (currentDateComponents.month-1 == dateComponents.month);
        
    }
    
    return YES;
}

- (BOOL)isDateInCurrentWeek:(NSDate *)date {
    
    if ([selectedRange isEqualToString:@"Current Week"]) {
        
        // Create an instance of NSCalendar
        NSCalendar *calendar = [NSCalendar currentCalendar];
        
        // Extract the week and year components from the current date
        NSDateComponents *currentDateComponents = [calendar components:NSCalendarUnitYearForWeekOfYear | NSCalendarUnitWeekOfYear fromDate:[NSDate date]];
        
        // Extract the week and year components from the provided date
        NSDateComponents *dateComponents = [calendar components:NSCalendarUnitYearForWeekOfYear | NSCalendarUnitWeekOfYear fromDate:date];
        
        // Compare the week and year components to check if the date is in the current week
        return (currentDateComponents.yearForWeekOfYear == dateComponents.yearForWeekOfYear) && (currentDateComponents.weekOfYear == dateComponents.weekOfYear);
        
    }
    
    return YES;
}

- (BOOL)isDateInLastWeek:(NSDate *)date {
    
    if ([selectedRange isEqualToString:@"Last Week"]) {
        
        // Create an instance of NSCalendar
        NSCalendar *calendar = [NSCalendar currentCalendar];
        
        // Extract the week and year components from the current date
        NSDateComponents *currentDateComponents = [calendar components:NSCalendarUnitYearForWeekOfYear | NSCalendarUnitWeekOfYear fromDate:[NSDate date]];
        
        // Extract the week and year components from the provided date
        NSDateComponents *dateComponents = [calendar components:NSCalendarUnitYearForWeekOfYear | NSCalendarUnitWeekOfYear fromDate:date];
        
        NSInteger weekToCheck = currentDateComponents.weekOfYear;
        
        if (weekToCheck == 1) {
            return (currentDateComponents.yearForWeekOfYear-1 == dateComponents.yearForWeekOfYear) && (52 == dateComponents.weekOfYear);
        }
        
        // Compare the week and year components to check if the date is in the current week
        return (currentDateComponents.yearForWeekOfYear == dateComponents.yearForWeekOfYear) && (currentDateComponents.weekOfYear-1 == dateComponents.weekOfYear);
        
    }
    
    return YES;
}

-(NSMutableDictionary *)GenerateOwedDictWithoutUsersWhoArentOwed:(NSMutableDictionary *)owedDictLocal {
    
    NSMutableDictionary *owedDict = [NSMutableDictionary dictionary];
    
    for (NSString *key in [owedDictLocal allKeys]) {
       
        if ([owedDictLocal[key] isEqualToString:[NSString stringWithFormat:@"0%@00", localCurrencyDecimalSeparatorSymbol]] == NO && [owedDictLocal[key] isEqualToString:[NSString stringWithFormat:@"%@0%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol]] == NO) {
            
            [owedDict setObject:owedDictLocal[key] forKey:key];
            
        }
        
    }
  
    return owedDict;
}

-(NSMutableDictionary *)GenerateOwedDictWithKeys {
    
    NSMutableDictionary *newOwedDict = [NSMutableDictionary dictionary];
    
    for (NSString *userID in _homeMembersDict[@"UserID"]) {
        
        NSMutableDictionary *tempDict = [NSMutableDictionary dictionary];
        
        for (NSString *userIDs in [owedDict allKeys]) {
            
            NSArray *arr = [userIDs componentsSeparatedByString:@" •• "];
            NSString *userIDNo2 = arr[1];
            
            if ([userID isEqualToString:userIDNo2]) {
                [tempDict setObject:owedDict[userIDs] forKey:userIDs];
            }
            
            if ([[[owedDict allKeys] lastObject] isEqualToString:userIDs]) {
                
                [newOwedDict setObject:tempDict forKey:userID];
                
            }
            
        }
        
    }
    
    return newOwedDict;
}

#pragma mark Earned Dict

-(void)GenerateEarnedDict {
    
    NSMutableDictionary *earnedDictLocal = [self GenerateStartingEarnedDict];
    
    earnedDictLocal = [self GenerateEarnedDict:earnedDictLocal];
   
    earnedDict = [self GenerateEarnedDictWithoutUsersWhoDidntEarnAnything:earnedDictLocal];
   
    earnedDict = [[self GenerateEarnedDictWithKeys] mutableCopy];
   
    [self EmptyTableViewHiddenStatus];
    
    [self.owedTableView reloadData];
    
}

#pragma mark

-(NSMutableDictionary *)GenerateEarnedDict:(NSMutableDictionary *)earnedDictLocal {
    
    for (NSString *userIDs in [earnedDictLocal allKeys]) {
        
        NSString *userIDWhoIsOwedMoney = userIDs;
        
        float totalOwedToUserWhoIsOwedMoney = 0.0;
        
        for (NSString *itemUniqueID in _itemDict[@"ItemUniqueID"]) {
            
            NSUInteger index = [_itemDict[@"ItemUniqueID"] indexOfObject:itemUniqueID];
            
            NSString *itemAmount = _itemDict[@"ItemAmount"] && [(NSArray *)_itemDict[@"ItemAmount"] count] > index ? _itemDict[@"ItemAmount"][index] : [NSString stringWithFormat:@"0%@00", localCurrencyDecimalSeparatorSymbol];
            NSString *itemCreatedBy = _itemDict[@"ItemCreatedBy"] && [(NSArray *)_itemDict[@"ItemCreatedBy"] count] > index ? _itemDict[@"ItemCreatedBy"][index] : @"";
            NSMutableDictionary *itemCompletedDict = _itemDict[@"ItemCompletedDict"] && [(NSArray *)_itemDict[@"ItemCompletedDict"] count] > index ? _itemDict[@"ItemCompletedDict"][index] : [NSMutableDictionary dictionary];
            NSMutableDictionary *itemCostPerPerson = _itemDict[@"ItemCostPerPerson"] && [(NSArray *)_itemDict[@"ItemCostPerPerson"] count] > index ? _itemDict[@"ItemCostPerPerson"][index] : [NSMutableDictionary dictionary];
            NSMutableArray *itemAssignedTo = _itemDict[@"ItemAssignedTo"] && [(NSArray *)_itemDict[@"ItemAssignedTo"] count] > index ? _itemDict[@"ItemAssignedTo"][index] : [NSMutableArray array];
            
            BOOL TaskWasCreatedByFirstUserAndWasCompletedBySecondUser = ([itemCreatedBy isEqualToString:userIDWhoIsOwedMoney] == YES);
           
            NSArray *arr = [itemUniqueID componentsSeparatedByString:@" "];
            NSDate *itemUniqueIDInDateForm = [[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:@"yyyy-MM-dd" dateToConvert:arr[0] returnAs:[NSDate class]];
            
            if (TaskWasCreatedByFirstUserAndWasCompletedBySecondUser == YES &&
                [self isDateInCurrentYear:itemUniqueIDInDateForm] &&
                [self isDateInLastYear:itemUniqueIDInDateForm] &&
                [self isDateInCurrentMonth:itemUniqueIDInDateForm] &&
                [self isDateInLastMonth:itemUniqueIDInDateForm] &&
                [self isDateInCurrentWeek:itemUniqueIDInDateForm] &&
                [self isDateInLastWeek:itemUniqueIDInDateForm]) {
               
                NSString *itemAmountString = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:itemAmount arrayOfSymbols:@[localCurrencyNumberSeparatorSymbol, localCurrencySymbol]];
                itemAmountString = [[[GeneralObject alloc] init] GenerateLocalCurrencyStringWithReverseSeparatorsForeign:itemAmountString];
                
                float itemAmountFloat = 0;
                
                for (NSString *userIDWhoOwesMoney in [itemCompletedDict allKeys]) {
                    
                    NSString *costPerPerson = itemCostPerPerson[userIDWhoOwesMoney];
                    costPerPerson = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:costPerPerson arrayOfSymbols:@[localCurrencyNumberSeparatorSymbol, localCurrencySymbol]];
                    costPerPerson = [[[GeneralObject alloc] init] GenerateLocalCurrencyStringWithReverseSeparatorsForeign:costPerPerson];
                    
                    itemAmountFloat +=
                    costPerPerson &&
                    [costPerPerson isEqualToString:[NSString stringWithFormat:@"%@0%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol]] == NO ?
                    [costPerPerson floatValue] :
                    [itemAmountString floatValue]/[itemAssignedTo count];
                    
                }
               
                totalOwedToUserWhoIsOwedMoney += itemAmountFloat;
                
            }
            
        }
       
        NSString *totalOwedToUserWhoIsOwedMoneyString = [NSString stringWithFormat:@"%.2f", totalOwedToUserWhoIsOwedMoney];
        
        totalOwedToUserWhoIsOwedMoneyString = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:totalOwedToUserWhoIsOwedMoneyString arrayOfSymbols:@[localCurrencyDecimalSeparatorSymbol, localCurrencyNumberSeparatorSymbol, localCurrencySymbol]];
        totalOwedToUserWhoIsOwedMoneyString = [[[GeneralObject alloc] init] GenerateAmountInTextFieldInProperFormat:NSRangeFromString(totalOwedToUserWhoIsOwedMoneyString) replacementString:totalOwedToUserWhoIsOwedMoneyString];
        
        [earnedDictLocal setObject:totalOwedToUserWhoIsOwedMoneyString forKey:[NSString stringWithFormat:@"%@", userIDWhoIsOwedMoney]];
        
    }
    
    return earnedDictLocal;
}

-(NSMutableDictionary *)GenerateEarnedDictWithoutUsersWhoDidntEarnAnything:(NSMutableDictionary *)earnedDictLocal {
    
    NSMutableDictionary *earnedDict = [NSMutableDictionary dictionary];
    
    for (NSString *key in [earnedDictLocal allKeys]) {
        
        if ([earnedDictLocal[key] isEqualToString:[NSString stringWithFormat:@"0%@00", localCurrencyDecimalSeparatorSymbol]] == NO && [earnedDictLocal[key] isEqualToString:[NSString stringWithFormat:@"%@0%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol]] == NO) {
            
            [earnedDict setObject:earnedDictLocal[key] forKey:key];
            
        }
        
    }
    
    return earnedDict;
}

-(NSMutableDictionary *)GenerateEarnedDictWithKeys {
    
    NSMutableDictionary *newEarnedDict = [NSMutableDictionary dictionary];
    
    for (NSString *userID in [earnedDict allKeys]) {
        
        [newEarnedDict setObject:earnedDict[userID] forKey:userID];
        
    }
    
    return newEarnedDict;
}

#pragma mark Payments Dict

-(void)GeneratePaidDict {
    
    NSMutableDictionary *dictOfTasksThatHaveBeenMarkedCompleted = [self GenerateDictOfTasksThatHaveBeenMarkedCompleted];
   
    NSDictionary *dict = [self GenerateOfArrayCompletedData:dictOfTasksThatHaveBeenMarkedCompleted];
   
    NSMutableArray *arrayOfDateCompleted = dict[@"ArrayOfDateCompleted"];
    NSMutableArray *arrayOfDateCompletedWithItemUniqueID = dict[@"ArrayOfDateCompletedWithItemUniqueID"];
   
    NSMutableArray *arrayOfSortedCompletedDates = [[[GeneralObject alloc] init] SortArrayOfDates:arrayOfDateCompleted dateFormatString:@"yyyy-MM-dd HH:mm:ss"];
    NSMutableArray *arrayOfSortedCompletedDatesWithItemUniqueID = [self GenerateArrayOfDateCompletedWithItemUniqueID:arrayOfSortedCompletedDates arrayOfDateCompletedWithItemUniqueID:arrayOfDateCompletedWithItemUniqueID];
    
    paymentsDict = [self GeneratePaymentsDict:dictOfTasksThatHaveBeenMarkedCompleted sortedArrayOfDateCompletedWithItemUniqueID:arrayOfSortedCompletedDatesWithItemUniqueID];
    paymentsDict = [[[GeneralObject alloc] init] GenerateArrayInReverse:[paymentsDict mutableCopy]];
    
    paymentsDictNo1 = [[self GeneratePaymentsDictWithKeys] mutableCopy];
   
    [self EmptyTableViewHiddenStatus];
    
    [self.paymentsTableView reloadData];
    
}

#pragma mark

-(NSMutableDictionary *)GenerateDictOfTasksThatHaveBeenMarkedCompleted {
    
    NSMutableDictionary *dictOfTasksThatHaveBeenMarkedCompleted = [NSMutableDictionary dictionary];
    
    for (NSString *itemUniqueID in _itemDict[@"ItemUniqueID"]) {
        
        NSUInteger index = [_itemDict[@"ItemUniqueID"] indexOfObject:itemUniqueID];
        
        BOOL TaskHasBeenCompletedByAtLeastOnePersonAndTaskHasAmount =
        ([[_itemDict[@"ItemCompletedDict"][index] allKeys] count] > 0 &&
         _itemDict[@"ItemAmount"] &&
         [(NSArray *)_itemDict[@"ItemAmount"] count] > index);
        
        if (TaskHasBeenCompletedByAtLeastOnePersonAndTaskHasAmount == YES) {
            
            NSMutableDictionary *itemDictLocal = [NSMutableDictionary dictionary];
            
            for (NSString *key in [_itemDict allKeys]) {
                
                id object = self->_itemDict[key] && [(NSArray *)self->_itemDict[key] count] > index ? self->_itemDict[key][index] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                [itemDictLocal setObject:object forKey:key];
                
            }
            
            [dictOfTasksThatHaveBeenMarkedCompleted setObject:itemDictLocal forKey:itemUniqueID];
            
        }
        
    }
    
    return dictOfTasksThatHaveBeenMarkedCompleted;
}

-(NSDictionary *)GenerateOfArrayCompletedData:(NSMutableDictionary *)dictOfTasksThatHaveBeenMarkedCompleted {
    
    NSMutableArray *arrayOfDateCompleted = [NSMutableArray array];
    NSMutableArray *arrayOfDateCompletedWithItemUniqueID = [NSMutableArray array];
    
    for (NSString *itemUniqueIDKey in [dictOfTasksThatHaveBeenMarkedCompleted allKeys]) {
        
        NSMutableDictionary *itemDictLocal = [dictOfTasksThatHaveBeenMarkedCompleted[itemUniqueIDKey] mutableCopy];
        
        NSDictionary *itemCompletedDict = itemDictLocal[@"ItemCompletedDict"];
        NSString *itemUniqueID = itemDictLocal[@"ItemUniqueID"];
        
        for (NSString *key in [itemCompletedDict allKeys]) {
            
            NSString *dateCompleted = itemCompletedDict[key][@"Date Marked"];
            NSString *markedBy = itemCompletedDict[key][@"Marked By"];
            NSString *markedFor = itemCompletedDict[key][@"Marked For"];
            
            if (markedFor.length == 0) { markedFor = [markedBy mutableCopy]; }
            
            NSDate *dateCompletedInDateForm = [[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:@"" dateToConvert:dateCompleted returnAs:[NSDate class]];
            
            if ([self isDateInCurrentYear:dateCompletedInDateForm] &&
                [self isDateInLastYear:dateCompletedInDateForm] &&
                [self isDateInCurrentMonth:dateCompletedInDateForm] &&
                [self isDateInLastMonth:dateCompletedInDateForm] &&
                [self isDateInCurrentWeek:dateCompletedInDateForm] &&
                [self isDateInLastWeek:dateCompletedInDateForm]) {
                
                [arrayOfDateCompleted addObject:dateCompleted];
                [arrayOfDateCompletedWithItemUniqueID addObject:[NSString stringWithFormat:@"%@ -- %@ -- %@ -- %@", dateCompleted, markedFor, markedBy, itemUniqueID]];
                
            }
            
        }
        
    }
    
    return @{@"ArrayOfDateCompleted" : arrayOfDateCompleted, @"ArrayOfDateCompletedWithItemUniqueID" : arrayOfDateCompletedWithItemUniqueID};
}

-(NSMutableArray *)GenerateArrayOfDateCompletedWithItemUniqueID:(NSMutableArray *)sortedArray arrayOfDateCompletedWithItemUniqueID:(NSMutableArray *)arrayOfDateCompletedWithItemUniqueID {
    
    NSMutableArray *sortedArrayOfDateCompletedWithItemUniqueID = [NSMutableArray array];
    
    //Generate Sorted Array of Date Marked With UniqueID Attached
    for (NSString *sortedDateCompleted in sortedArray) {
        
        for (NSString *dateCompletedWithItemUniqueID in arrayOfDateCompletedWithItemUniqueID) {
            
            if ([dateCompletedWithItemUniqueID containsString:[NSString stringWithFormat:@"%@ -- ", sortedDateCompleted]]) {
                
                [sortedArrayOfDateCompletedWithItemUniqueID addObject:dateCompletedWithItemUniqueID];
                break;
                
            }
            
        }
        
    }
    
    return sortedArrayOfDateCompletedWithItemUniqueID;
}

-(NSMutableArray *)GeneratePaymentsDict:(NSMutableDictionary *)dictOfTasksThatHaveBeenMarkedCompleted sortedArrayOfDateCompletedWithItemUniqueID:(NSMutableArray *)sortedArrayOfDateCompletedWithItemUniqueID {
    
    NSMutableArray *sortedDict = [NSMutableArray array];
    
    NSMutableArray *arrayOfItemUniqueIDKeys = [[dictOfTasksThatHaveBeenMarkedCompleted allKeys] mutableCopy];
    
    for (NSString *dateCompletedWithItemUniqueID in sortedArrayOfDateCompletedWithItemUniqueID) {
        
        for (NSString *itemUniqueIDKey in [dictOfTasksThatHaveBeenMarkedCompleted allKeys]) {
          
            NSUInteger index = [[dictOfTasksThatHaveBeenMarkedCompleted allKeys] indexOfObject:itemUniqueIDKey];
           
            if ([dateCompletedWithItemUniqueID containsString:[NSString stringWithFormat:@" -- %@", itemUniqueIDKey]] && [arrayOfItemUniqueIDKeys[index] isEqualToString:@"xxx"] == NO) {
                
                NSMutableDictionary *itemDictLocal = [NSMutableDictionary dictionary];
                
                for (NSString *key in [dictOfTasksThatHaveBeenMarkedCompleted[itemUniqueIDKey] allKeys]) {
                    
                    id object = dictOfTasksThatHaveBeenMarkedCompleted[itemUniqueIDKey] && dictOfTasksThatHaveBeenMarkedCompleted[itemUniqueIDKey][key] ? dictOfTasksThatHaveBeenMarkedCompleted[itemUniqueIDKey][key] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                    [itemDictLocal setObject:object forKey:key];
                    
                }
                
                NSArray *arr = [dateCompletedWithItemUniqueID containsString:@" -- "] ? [dateCompletedWithItemUniqueID componentsSeparatedByString:@" -- "] : @[];
               
                NSString *dateMarked = [arr count] > 0 ? arr[0] : @"";
                NSString *markedFor = [arr count] > 1 ? arr[1] : @"";
                NSString *markedBy = [arr count] > 2 ? arr[2] : @"";
                [itemDictLocal setObject:dateMarked forKey:@"Date Marked"];
                [itemDictLocal setObject:markedFor forKey:@"Marked For"];
                [itemDictLocal setObject:markedBy forKey:@"Marked By"];
                
//                [arrayOfItemUniqueIDKeys replaceObjectAtIndex:index withObject:@"xxx"];
                [sortedDict addObject:itemDictLocal];
           
            }
            
        }
        
    }
   
    return sortedDict;
}

-(NSMutableDictionary *)GeneratePaymentsDictWithKeys {
    
    NSMutableDictionary *newPaymentDict = [NSMutableDictionary dictionary];
    
    for (int i=0 ; i<[(NSArray *)_homeMembersDict[@"UserID"] count] ; i++) {
        
        NSMutableDictionary *tempDict = [NSMutableDictionary dictionary];
        
        for (NSDictionary *dict in paymentsDict) {
           
            NSString *markedFor = dict[@"Marked For"];
            NSMutableArray *arrayToUse = tempDict[markedFor] ? [tempDict[markedFor] mutableCopy] : [NSMutableArray array];
            [arrayToUse addObject:dict];
            [tempDict setObject:arrayToUse forKey:markedFor];
            
        }
        
        newPaymentDict = [tempDict mutableCopy];
        
    }
    
    return newPaymentDict;
}

#pragma mark - IBAction Methods

-(IBAction)NavigationBackButtonAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Navigation Back Button Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)SegmentControlAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"SegmentControlAction %lu Clicked For %@", [_customSegmentControl selectedSegmentIndex], [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    if ([_customSegmentControl selectedSegmentIndex] == 0) {
        
        _owedTableView.hidden = NO;
        _paymentsTableView.hidden = YES;
        _emptyTableViewTitleLabel.text = @"Expenses Owed";
        _emptyTableViewBodyLabel.text = @"What your home members owe will show up here.";
        
    } else if ([_customSegmentControl selectedSegmentIndex] == 1) {
        
        _owedTableView.hidden = YES;
        _paymentsTableView.hidden = NO;
        _emptyTableViewTitleLabel.text = @"Expenses Paid";
        _emptyTableViewBodyLabel.text = @"What your home members paid will show up here.";
        
    } else if ([_customSegmentControl selectedSegmentIndex] == 2) {
        
        _owedTableView.hidden = NO;
        _paymentsTableView.hidden = YES;
        _emptyTableViewTitleLabel.text = @"Expenses Earned";
        _emptyTableViewBodyLabel.text = @"What your home members earned will show up here.";
        
    }

    [self.owedTableView reloadData];
    [self.paymentsTableView reloadData];
    
}

-(NSString *)GeneratePaymentDescription:(NSIndexPath *)indexPath {
    
    NSString *currentSection = [[paymentsDictNo1 allKeys] count] > indexPath.section ? [paymentsDictNo1 allKeys][indexPath.section] : @"";
    NSMutableArray *paymentsDict = paymentsDictNo1[currentSection] ? paymentsDictNo1[currentSection] : [NSMutableArray array];
    
    NSString *dateMarked = [paymentsDict count] > indexPath.row ? paymentsDict[indexPath.row][@"Date Marked"] : @"";
    NSString *itemCreatedBy = [paymentsDict count] > indexPath.row ? paymentsDict[indexPath.row][@"ItemCreatedBy"] : @"";
    NSString *markedBy = [paymentsDict count] > indexPath.row ? paymentsDict[indexPath.row][@"Marked By"] : @"";
    NSString *markedFor = [paymentsDict count] > indexPath.row ? paymentsDict[indexPath.row][@"Marked For"] : @"";
   
    if (markedFor.length == 0 && markedBy.length > 0) { markedFor = [markedBy mutableCopy]; }
    
    if (markedFor.length > 0 && itemCreatedBy.length > 0) {
        
        NSUInteger index = [_homeMembersDict[@"UserID"] indexOfObject:markedFor];
        NSUInteger indexNo1 = [_homeMembersDict[@"UserID"] indexOfObject:itemCreatedBy];
        
        NSString *username = _homeMembersDict && _homeMembersDict[@"Username"] && [(NSArray *)_homeMembersDict[@"Username"] count] > index ? _homeMembersDict[@"Username"][index] : @"";
        NSString *itemCreatedByUsername = _homeMembersDict && _homeMembersDict[@"Username"] && [(NSArray *)_homeMembersDict[@"Username"] count] > indexNo1 ? _homeMembersDict[@"Username"][indexNo1] : @"";
        
        NSString *convertedDateString = [[[GeneralObject alloc] init] GenerateDateWithConvertedFormatWithFormat:@"yyyy-MM-dd HH:mm:ss" dateToConvert:dateMarked newFormat:@"MMM d" returnAs:[NSString class]];
        NSString *convertedTimeString = [[[GeneralObject alloc] init] GenerateDateWithConvertedFormatWithFormat:@"yyyy-MM-dd HH:mm:ss" dateToConvert:dateMarked newFormat:@"h:mm a" returnAs:[NSString class]];
        NSString *convertedWeekdayString = [[[GeneralObject alloc] init] GenerateDateWithConvertedFormatWithFormat:@"yyyy-MM-dd HH:mm:ss" dateToConvert:dateMarked newFormat:@"EEE" returnAs:[NSString class]];
        
        NSString *paymentDescription = [NSString stringWithFormat:@"%@ paid %@ on %@., %@ at %@", username, itemCreatedByUsername, convertedWeekdayString, convertedDateString, convertedTimeString];
        
        return paymentDescription;
    }
    
    return @"";
}

-(NSString *)GenerateOwedDescription:(NSIndexPath *)indexPath {
    
    NSString *currentSection = [owedDict allKeys][indexPath.section];
    NSString *userIDs = [owedDict[currentSection] allKeys][indexPath.row];
    
    NSArray *arr = [userIDs componentsSeparatedByString:@" •• "];
    NSString *userIDNo1 = arr[0];
    NSString *userIDNo2 = arr[1];
    
    NSUInteger indexNo1 = [_homeMembersDict[@"UserID"] indexOfObject:userIDNo1];
    NSUInteger indexNo2 = [_homeMembersDict[@"UserID"] indexOfObject:userIDNo2];
    
    NSString *usernameNo1 = _homeMembersDict && _homeMembersDict[@"Username"] && [(NSArray *)_homeMembersDict[@"Username"] count] > indexNo1 ? _homeMembersDict[@"Username"][indexNo1] : @"";
    NSString *usernameNo2 = _homeMembersDict && _homeMembersDict[@"Username"] && [(NSArray *)_homeMembersDict[@"Username"] count] > indexNo2 ? _homeMembersDict[@"Username"][indexNo2] : @"";
    
    NSString *paymentDescription = [NSString stringWithFormat:@"%@ owes %@ to %@", usernameNo2, owedDict[userIDs], usernameNo1];
    
    return paymentDescription;
}

-(NSString *)GenerateOwedDescriptionNo1:(NSIndexPath *)indexPath {
    
    NSString *userIDWhoIsOwed = specificUserDict[indexPath.row][@"UserIDNo1"];
    NSString *userIDWhoOwes = specificUserDict[indexPath.row][@"UserIDNo2"];
    
    NSUInteger indexWhoIsOwed = [_homeMembersDict[@"UserID"] indexOfObject:userIDWhoIsOwed];
    NSUInteger indexWhoOwes = [_homeMembersDict[@"UserID"] indexOfObject:userIDWhoOwes];
    
    NSString *usernameWhoIsOwed = _homeMembersDict && _homeMembersDict[@"Username"] && [(NSArray *)_homeMembersDict[@"Username"] count] > indexWhoIsOwed ? _homeMembersDict[@"Username"][indexWhoIsOwed] : @"";
    NSString *usernameWhoOwes = _homeMembersDict && _homeMembersDict[@"Username"] && [(NSArray *)_homeMembersDict[@"Username"] count] > indexWhoOwes ? _homeMembersDict[@"Username"][indexWhoOwes] : @"";
    
    NSString *itemName = specificUserDict[indexPath.row][@"ItemName"];
    NSString *itemAmount = specificUserDict[indexPath.row][@"ItemAmount"];
    
    NSString *paymentDescription = [NSString stringWithFormat:@"%@ owes %@ to %@ for %@", usernameWhoOwes, itemAmount, usernameWhoIsOwed, itemName];
    
    return paymentDescription;
}

-(NSString *)GenerateEarnedDescription:(NSIndexPath *)indexPath {
    
    NSString *userIDs = [earnedDict allKeys][indexPath.row];
    
    NSString *userIDNo1 = userIDs;
    
    NSUInteger indexNo1 = [_homeMembersDict[@"UserID"] indexOfObject:userIDNo1];
    
    NSString *usernameNo1 = _homeMembersDict && _homeMembersDict[@"Username"] && [(NSArray *)_homeMembersDict[@"Username"] count] > indexNo1 ? _homeMembersDict[@"Username"][indexNo1] : @"";
    
    NSString *paymentDescription = [NSString stringWithFormat:@"%@ has earned %@", usernameNo1, earnedDict[userIDs]];
    
    return paymentDescription;
}

-(NSString *)GenerateEarnedDescriptionNo1:(NSIndexPath *)indexPath {
    
    NSString *userIDWhoEarned = specificUserDict[indexPath.row][@"UserIDNo1"];
    NSString *userIDWhoGave = specificUserDict[indexPath.row][@"UserIDNo2"];
    
    NSUInteger indexWhoEarned = [_homeMembersDict[@"UserID"] indexOfObject:userIDWhoEarned];
    NSUInteger indexWhoGave = [_homeMembersDict[@"UserID"] indexOfObject:userIDWhoGave];
    
    NSString *usernameWhoEarned = _homeMembersDict && _homeMembersDict[@"Username"] && [(NSArray *)_homeMembersDict[@"Username"] count] > indexWhoEarned ? _homeMembersDict[@"Username"][indexWhoEarned] : @"";
    NSString *usernameWhoGave = _homeMembersDict && _homeMembersDict[@"Username"] && [(NSArray *)_homeMembersDict[@"Username"] count] > indexWhoGave ? _homeMembersDict[@"Username"][indexWhoGave] : @"";
  
    NSString *itemName = specificUserDict[indexPath.row][@"ItemName"];
    NSString *itemAmount = specificUserDict[indexPath.row][@"ItemAmount"];
    
    NSString *paymentDescription = [NSString stringWithFormat:@"%@ earned %@ from %@ for %@", usernameWhoEarned, itemAmount, usernameWhoGave, itemName];
    
    return paymentDescription;
}

#pragma mark - Table View Methods

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    ViewPaymentsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ViewPaymentsCell"];
    
    if (_viewingOwed == NO && _viewingEarned == NO) {
        
        if (tableView == _owedTableView && [_customSegmentControl selectedSegmentIndex] == 0) {
            
            NSString *currentSection = [owedDict allKeys][indexPath.section];
            
            NSArray *keysArray = [owedDict[currentSection] allKeys];
            NSArray *sortedKeysArray = [keysArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
            NSString *userIDs = [sortedKeysArray count] > indexPath.row ? sortedKeysArray[indexPath.row] : @"";
            
            NSArray *arr = [userIDs componentsSeparatedByString:@" •• "];
            
            NSString *userIDWhoIsOwed = arr[0];
            NSString *userIDWhoOwes = arr[1];
            
            NSUInteger indexWhoIsOwed = [_homeMembersDict[@"UserID"] indexOfObject:userIDWhoIsOwed];
            NSUInteger indexWhoOwes = [_homeMembersDict[@"UserID"] indexOfObject:userIDWhoOwes];
            
            NSString *usernameWhoIsOwed = _homeMembersDict && _homeMembersDict[@"Username"] && [(NSArray *)_homeMembersDict[@"Username"] count] > indexWhoIsOwed ? _homeMembersDict[@"Username"][indexWhoIsOwed] : @"";
            NSString *usernameWhoOwes = _homeMembersDict && _homeMembersDict[@"Username"] && [(NSArray *)_homeMembersDict[@"Username"] count] > indexWhoOwes ? _homeMembersDict[@"Username"][indexWhoOwes] : @"";
            
            [self GenerateOwedProfileImageViews:userIDWhoOwes userIDWhoOwes:userIDWhoIsOwed cell:cell];
            
            NSAttributedString *owedDescriptionLabel = [self GenerateOwedDescriptionString:userIDs usernameWhoIsOwed:usernameWhoIsOwed usernameWhoOwes:usernameWhoOwes currentSection:currentSection cell:cell];
            
            [cell.paymentDescriptionLabel setAttributedText:owedDescriptionLabel];
            
        } else if (tableView == _owedTableView && [_customSegmentControl selectedSegmentIndex] == 2) {
            
            NSString *currentSection = [earnedDict allKeys][indexPath.section];
            NSString *userIDWhoOwes = currentSection;
            
            NSUInteger indexWhoOwes = [_homeMembersDict[@"UserID"] indexOfObject:userIDWhoOwes];
            
            NSString *usernameWhoOwes = _homeMembersDict && _homeMembersDict[@"Username"] && [(NSArray *)_homeMembersDict[@"Username"] count] > indexWhoOwes ? _homeMembersDict[@"Username"][indexWhoOwes] : @"";
            
            [self GenerateOwedProfileImageViews:userIDWhoOwes userIDWhoOwes:@"" cell:cell];
            
            NSAttributedString *owedDescriptionLabel = [self GenerateEarnedDescriptionString:usernameWhoOwes currentSection:currentSection cell:cell];
            
            [cell.paymentDescriptionLabel setAttributedText:owedDescriptionLabel];
            
        } else {
            
            NSString *currentSection = [[paymentsDictNo1 allKeys] count] > indexPath.section ? [paymentsDictNo1 allKeys][indexPath.section] : @"";
            NSMutableArray *paymentsDict = paymentsDictNo1[currentSection] ? paymentsDictNo1[currentSection] : [NSMutableArray array];
            
            NSString *dateMarked = paymentsDict[indexPath.row][@"Date Marked"];
            NSString *markedBy = paymentsDict[indexPath.row][@"Marked By"];
            NSString *markedFor = paymentsDict[indexPath.row][@"Marked For"];
            NSString *itemName = paymentsDict[indexPath.row][@"ItemName"];
            NSString *itemCreatedBy = paymentsDict[indexPath.row][@"ItemCreatedBy"];
            NSString *itemAmount = paymentsDict[indexPath.row][@"ItemAmount"];
            NSMutableArray *itemAssignedTo = paymentsDict[indexPath.row][@"ItemAssignedTo"];
            NSDictionary *itemCostPerPerson = paymentsDict[indexPath.row][@"ItemCostPerPerson"];
            
            if (markedFor.length == 0 && markedBy.length > 0) { markedFor = [markedBy mutableCopy]; }
            
            NSUInteger index = [_homeMembersDict[@"UserID"] indexOfObject:markedFor];
            NSUInteger indexNo1 = [_homeMembersDict[@"UserID"] indexOfObject:itemCreatedBy];
            
            NSString *username = _homeMembersDict && _homeMembersDict[@"Username"] && [(NSArray *)_homeMembersDict[@"Username"] count] > index ? _homeMembersDict[@"Username"][index] : @"";
            NSString *itemCreatedByUsername = _homeMembersDict && _homeMembersDict[@"Username"] && [(NSArray *)_homeMembersDict[@"Username"] count] > indexNo1 ? _homeMembersDict[@"Username"][indexNo1] : @"";
            
            [self GeneratePaidProfileImageViews:markedFor itemCreatedBy:itemCreatedBy cell:cell];
            
            cell.paymentNameLabel.text = itemName;
            
            NSString *itemAmountString = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:itemAmount arrayOfSymbols:@[localCurrencyNumberSeparatorSymbol, localCurrencySymbol]];
            itemAmountString = [[[GeneralObject alloc] init] GenerateLocalCurrencyStringWithReverseSeparatorsForeign:itemAmountString];
            
            NSString *costPerPerson = itemCostPerPerson[paymentsDict[indexPath.row][@"Marked For"]];
            costPerPerson = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:costPerPerson arrayOfSymbols:@[localCurrencyNumberSeparatorSymbol, localCurrencySymbol]];
            costPerPerson = [[[GeneralObject alloc] init] GenerateLocalCurrencyStringWithReverseSeparatorsForeign:costPerPerson];
            
            float itemAmountFloat =
            costPerPerson &&
            [costPerPerson isEqualToString:[NSString stringWithFormat:@"%@0%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol]] == NO ?
            [costPerPerson floatValue] :
            [itemAmountString floatValue]/[itemAssignedTo count];
           
            NSString *itemAmountFloatString = [NSString stringWithFormat:@"%.2f", itemAmountFloat];
            
            itemAmountFloatString = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:itemAmountFloatString arrayOfSymbols:@[localCurrencyDecimalSeparatorSymbol, localCurrencyNumberSeparatorSymbol, localCurrencySymbol]];
            itemAmountFloatString = [[[GeneralObject alloc] init] GenerateAmountInTextFieldInProperFormat:NSRangeFromString(itemAmountFloatString) replacementString:itemAmountFloatString];
            
            cell.paymentAmountLabel.text = itemAmountFloatString;
            
            NSAttributedString *paymentDescriptionLabel = [self GeneratePaymentDescriptionString:dateMarked usernameWhoPaid:username itemCreatedByUsername:itemCreatedByUsername cell:cell];
            [cell.paymentDescriptionLabel setAttributedText:paymentDescriptionLabel];
            
        }
        
    } else if (tableView == _owedTableView && _viewingOwed == YES) {
        
        NSString *userIDWhoIsOwed = specificUserDict[indexPath.row][@"UserIDNo1"];
        NSString *userIDWhoOwes = specificUserDict[indexPath.row][@"UserIDNo2"];
        
        NSUInteger indexWhoIsOwed = [_homeMembersDict[@"UserID"] indexOfObject:userIDWhoIsOwed];
        NSUInteger indexWhoOwes = [_homeMembersDict[@"UserID"] indexOfObject:userIDWhoOwes];
        
        NSString *usernameWhoIsOwed = _homeMembersDict && _homeMembersDict[@"Username"] && [(NSArray *)_homeMembersDict[@"Username"] count] > indexWhoIsOwed ? _homeMembersDict[@"Username"][indexWhoIsOwed] : @"";
        NSString *usernameWhoOwes = _homeMembersDict && _homeMembersDict[@"Username"] && [(NSArray *)_homeMembersDict[@"Username"] count] > indexWhoOwes ? _homeMembersDict[@"Username"][indexWhoOwes] : @"";
        
        NSString *itemName = specificUserDict[indexPath.row][@"ItemName"];
        NSString *itemAmount = specificUserDict[indexPath.row][@"ItemAmount"];
        
        [self GenerateOwedProfileImageViews:userIDWhoOwes userIDWhoOwes:userIDWhoIsOwed cell:cell];
        
        NSAttributedString *owedDescriptionLabel = [self GenerateOwedDescriptionStringNo1:usernameWhoOwes usernameWhoIsOwed:usernameWhoIsOwed itemAmount:itemAmount itemName:itemName cell:cell];
        [cell.paymentDescriptionLabel setAttributedText:owedDescriptionLabel];
        
    } else if (tableView == _owedTableView && _viewingEarned == YES) {
        
        NSString *userIDWhoEarned = specificUserDict[indexPath.row][@"UserIDNo1"];
        NSString *userIDWhoGave = specificUserDict[indexPath.row][@"UserIDNo2"];
        
        NSUInteger indexWhoEarned = [_homeMembersDict[@"UserID"] indexOfObject:userIDWhoEarned];
        NSUInteger indexWhoGave = [_homeMembersDict[@"UserID"] indexOfObject:userIDWhoGave];
        
        NSString *usernameWhoEarned = _homeMembersDict && _homeMembersDict[@"Username"] && [(NSArray *)_homeMembersDict[@"Username"] count] > indexWhoEarned ? _homeMembersDict[@"Username"][indexWhoEarned] : @"";
        NSString *usernameWhoGave = _homeMembersDict && _homeMembersDict[@"Username"] && [(NSArray *)_homeMembersDict[@"Username"] count] > indexWhoGave ? _homeMembersDict[@"Username"][indexWhoGave] : @"";
        
        [self GenerateOwedProfileImageViews:userIDWhoEarned userIDWhoOwes:userIDWhoGave cell:cell];
        
        NSString *itemAmount = specificUserDict[indexPath.row][@"ItemAmount"];
        NSString *itemName = specificUserDict[indexPath.row][@"ItemName"];
        
        NSAttributedString *owedDescriptionLabel = [self GenerateEarnedDescriptionStringNo1:usernameWhoEarned usernameWhoGave:usernameWhoGave itemAmount:itemAmount itemName:itemName cell:cell];
       
        [cell.paymentDescriptionLabel setAttributedText:owedDescriptionLabel];

    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (_viewingOwed == NO && _viewingEarned == NO) {
        
        if (tableView == _owedTableView && [_customSegmentControl selectedSegmentIndex] == 0) {
            
            NSString *currentSection = [owedDict allKeys][section];
            return [[owedDict[currentSection] allKeys] count];
            
        } else if (tableView == _owedTableView && [_customSegmentControl selectedSegmentIndex] == 2) {
            
            return 1;
            
        }
        
        NSString *currentSection = [[paymentsDictNo1 allKeys] count] > section ? [paymentsDictNo1 allKeys][section] : @"";
        NSMutableArray *paymentsDict = paymentsDictNo1[currentSection] ? paymentsDictNo1[currentSection] : [NSMutableArray array];
        
        return [paymentsDict count];
        
    } else if (_viewingOwed == YES || _viewingEarned == YES) {
        
        return [specificUserDict count];
        
    }
    
    return 1;
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(ViewPaymentsCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    int numOfRows = 0;
    
    if (_viewingOwed == NO && _viewingEarned == NO) {
        
        if (tableView == _owedTableView && [_customSegmentControl selectedSegmentIndex] == 0) {
            
            NSString *currentSection = [owedDict allKeys][indexPath.section];
            numOfRows = (int)[[owedDict[currentSection] allKeys] count];
            
            if (indexPath.row == numOfRows-1 && numOfRows-1 == 0) {
                [[[GeneralObject alloc] init] RoundingCorners:cell.contentView topCorners:YES bottomCorners:YES cornerRadius:12];
            } else if (indexPath.row == 0) {
                [[[GeneralObject alloc] init] RoundingCorners:cell.contentView topCorners:YES bottomCorners:NO cornerRadius:12];
            } else if (indexPath.row == numOfRows-1) {
                [[[GeneralObject alloc] init] RoundingCorners:cell.contentView topCorners:NO bottomCorners:YES cornerRadius:12];
            }
            
        } else if (tableView == _owedTableView && [_customSegmentControl selectedSegmentIndex] == 2) {
            
            numOfRows = 1;
            
            if (indexPath.row == numOfRows-1 && numOfRows-1 == 0) {
                [[[GeneralObject alloc] init] RoundingCorners:cell.contentView topCorners:YES bottomCorners:YES cornerRadius:12];
            } else if (indexPath.row == 0) {
                [[[GeneralObject alloc] init] RoundingCorners:cell.contentView topCorners:YES bottomCorners:NO cornerRadius:12];
            } else if (indexPath.row == numOfRows-1) {
                [[[GeneralObject alloc] init] RoundingCorners:cell.contentView topCorners:NO bottomCorners:YES cornerRadius:12];
            }
            
        } else {
            
            NSString *currentSection = [[paymentsDictNo1 allKeys] count] > indexPath.section ? [paymentsDictNo1 allKeys][indexPath.section] : @"";
            NSMutableArray *paymentsDict = paymentsDictNo1[currentSection] ? paymentsDictNo1[currentSection] : [NSMutableArray array];
            
            numOfRows = (int)[paymentsDict count];
            
            if (indexPath.row == numOfRows-1 && numOfRows-1 == 0) {
                [[[GeneralObject alloc] init] RoundingCorners:cell.contentView topCorners:YES bottomCorners:YES cornerRadius:12];
            } else if (indexPath.row == 0) {
                [[[GeneralObject alloc] init] RoundingCorners:cell.contentView topCorners:YES bottomCorners:NO cornerRadius:12];
            } else if (indexPath.row == numOfRows-1) {
                [[[GeneralObject alloc] init] RoundingCorners:cell.contentView topCorners:NO bottomCorners:YES cornerRadius:12];
            }
            
        }
        
    } else {
        
        numOfRows = (int)[specificUserDict count];
        
        if (indexPath.row == numOfRows-1 && numOfRows-1 == 0) {
            [[[GeneralObject alloc] init] RoundingCorners:cell.contentView topCorners:YES bottomCorners:YES cornerRadius:12];
        } else if (indexPath.row == 0) {
            [[[GeneralObject alloc] init] RoundingCorners:cell.contentView topCorners:YES bottomCorners:NO cornerRadius:12];
        } else if (indexPath.row == numOfRows-1) {
            [[[GeneralObject alloc] init] RoundingCorners:cell.contentView topCorners:NO bottomCorners:YES cornerRadius:12];
        }
        
    }
   
    CGFloat width = CGRectGetWidth(cell.contentView.bounds);
    CGFloat height = CGRectGetHeight(cell.contentView.bounds);

    if (_viewingOwed == NO && _viewingEarned == NO) {
        
        cell.arrowImageView.hidden = NO;
        
        if (tableView == _owedTableView && [_customSegmentControl selectedSegmentIndex] == 0) {
            
            NSString *paymentDescription = [self GenerateOwedDescription:indexPath];
            CGFloat cellHeightNo1 = [self GenerateCellHeight:paymentDescription tableView:tableView];
            
            height = (self.view.frame.size.height*0.12143928 > 81?(81):self.view.frame.size.height*0.12143928)*0.7037037;
            
            cell.firstUserImageView.frame = CGRectMake(width*0.03092784, cellHeightNo1*0.5 - (height*0.5)*0.5, height*0.5, height*0.5);
            cell.secondUserImageView.frame = CGRectMake(cell.firstUserImageView.frame.origin.x + cell.firstUserImageView.frame.size.width*0.8, cell.firstUserImageView.frame.origin.y, cell.firstUserImageView.frame.size.width, cell.firstUserImageView.frame.size.height);
            
            cell.firstUserImageView.layer.borderWidth = 2.0f;
            cell.firstUserImageView.layer.borderColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTertiary].CGColor : [[[LightDarkModeObject alloc] init] LightModeSecondary].CGColor;
            cell.firstUserImageView.layer.cornerRadius = cell.firstUserImageView.frame.size.height/2;
            cell.firstUserImageView.contentMode = UIViewContentModeScaleAspectFill;
            
            cell.secondUserImageView.layer.borderWidth = 2.0f;
            cell.secondUserImageView.layer.borderColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTertiary].CGColor : [[[LightDarkModeObject alloc] init] LightModeSecondary].CGColor;
            cell.secondUserImageView.layer.cornerRadius = cell.secondUserImageView.frame.size.height/2;
            cell.secondUserImageView.contentMode = UIViewContentModeScaleAspectFill;
            
            cell.paymentDescriptionLabel.frame = CGRectMake(cell.secondUserImageView.frame.origin.x + cell.secondUserImageView.frame.size.width + (width*0.02061856), height*0.5 - ((height*0.44444)*0.5), 0, (height*0.44444));
            
            cell.arrowImageView.frame = CGRectMake(width - width*0.03092784 - width*0.0225, cellHeightNo1*0.5 - height*0.5, width*0.0225, height);
            
            CGRect newRect = cell.paymentDescriptionLabel.frame;
            newRect.size.width = width - newRect.origin.x - (width*0.03092784) - cell.arrowImageView.frame.size.width - (width*0.03092784);
            cell.paymentDescriptionLabel.frame = newRect;
            
            int lineCount = [[[GeneralObject alloc] init] LineCountForText:paymentDescription label:cell.paymentDescriptionLabel];
            
            newRect = cell.paymentDescriptionLabel.frame;
            newRect.size.height = descriptionLabelLineHeight * lineCount;
            newRect.origin.y = cellHeightNo1*0.5 - (newRect.size.height)*0.5;
            cell.paymentDescriptionLabel.frame = newRect;
            
        } else if (tableView == _owedTableView && [_customSegmentControl selectedSegmentIndex] == 2) {
            
            NSString *paymentDescription = [self GenerateEarnedDescription:indexPath];
            CGFloat cellHeightNo1 = [self GenerateCellHeight:paymentDescription tableView:tableView];
            
            height = (self.view.frame.size.height*0.12143928 > 81?(81):self.view.frame.size.height*0.12143928)*0.7037037;
            
            cell.firstUserImageView.frame = CGRectMake(width*0.03092784, cellHeightNo1*0.5 - (height*0.5)*0.5, height*0.5, height*0.5);
            cell.secondUserImageView.frame = CGRectMake(cell.firstUserImageView.frame.origin.x + cell.firstUserImageView.frame.size.width*0.8, cell.firstUserImageView.frame.origin.y, cell.firstUserImageView.frame.size.width, cell.firstUserImageView.frame.size.height);
            
            cell.secondUserImageView.hidden = YES;
            
            cell.firstUserImageView.layer.borderWidth = 2.0f;
            cell.firstUserImageView.layer.borderColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTertiary].CGColor : [[[LightDarkModeObject alloc] init] LightModeSecondary].CGColor;
            cell.firstUserImageView.layer.cornerRadius = cell.firstUserImageView.frame.size.height/2;
            cell.firstUserImageView.contentMode = UIViewContentModeScaleAspectFill;
            
            cell.secondUserImageView.layer.borderWidth = 2.0f;
            cell.secondUserImageView.layer.borderColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTertiary].CGColor : [[[LightDarkModeObject alloc] init] LightModeSecondary].CGColor;
            cell.secondUserImageView.layer.cornerRadius = cell.secondUserImageView.frame.size.height/2;
            cell.secondUserImageView.contentMode = UIViewContentModeScaleAspectFill;
            
            cell.paymentDescriptionLabel.frame = CGRectMake(cell.firstUserImageView.frame.origin.x + cell.firstUserImageView.frame.size.width + (width*0.02061856), cellHeightNo1*0.5 - (height*0.44444)*0.5, 0, (height*0.44444));
            
            cell.arrowImageView.frame = CGRectMake(width - width*0.03092784 - width*0.0225, cellHeightNo1*0.5 - height*0.5, width*0.0225, height);
            
            CGRect newRect = cell.paymentDescriptionLabel.frame;
            newRect.size.width = width - newRect.origin.x - (width*0.03092784) - cell.arrowImageView.frame.size.width - (width*0.03092784);
            cell.paymentDescriptionLabel.frame = newRect;
            
            int lineCount = [[[GeneralObject alloc] init] LineCountForText:paymentDescription label:cell.paymentDescriptionLabel];

            newRect = cell.paymentDescriptionLabel.frame;
            newRect.size.height = descriptionLabelLineHeight * lineCount;
            newRect.origin.y = cellHeightNo1*0.5 - (newRect.size.height)*0.5;
            cell.paymentDescriptionLabel.frame = newRect;
            
        } else if (tableView == _paymentsTableView) {
            
            NSString *paymentDescription = [self GeneratePaymentDescription:indexPath];
            CGFloat cellHeightNo1 = [self GenerateCellHeight:paymentDescription tableView:tableView];
          
            height = (self.view.frame.size.height*0.13493253 > 90?(90):self.view.frame.size.height*0.13493253);
            
            cell.firstUserImageView.frame = CGRectMake(width*0.03092784, cellHeightNo1*0.5 - (height*0.3888889)*0.5, height*0.3888889, height*0.3888889);
            cell.secondUserImageView.frame = CGRectMake(cell.firstUserImageView.frame.origin.x + cell.firstUserImageView.frame.size.width*0.8, cell.firstUserImageView.frame.origin.y, cell.firstUserImageView.frame.size.width, cell.firstUserImageView.frame.size.height);
            
            cell.firstUserImageView.layer.borderWidth = 2.0f;
            cell.firstUserImageView.layer.borderColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTertiary].CGColor : [[[LightDarkModeObject alloc] init] LightModeSecondary].CGColor;
            cell.firstUserImageView.layer.cornerRadius = cell.firstUserImageView.frame.size.height/2;
            cell.firstUserImageView.contentMode = UIViewContentModeScaleAspectFill;
            
            cell.secondUserImageView.layer.borderWidth = 2.0f;
            cell.secondUserImageView.layer.borderColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTertiary].CGColor : [[[LightDarkModeObject alloc] init] LightModeSecondary].CGColor;
            cell.secondUserImageView.layer.cornerRadius = cell.secondUserImageView.frame.size.height/2;
            cell.secondUserImageView.contentMode = UIViewContentModeScaleAspectFill;
            
            cell.paymentNameLabel.frame = CGRectMake(cell.secondUserImageView.frame.origin.x + cell.secondUserImageView.frame.size.width + (width*0.02061856), height*0.133333, 0, height*0.2);
            cell.paymentAmountLabel.frame = CGRectMake(0, cell.paymentNameLabel.frame.origin.y, 0, height*0.2);
            cell.paymentDescriptionLabel.frame = CGRectMake(cell.paymentNameLabel.frame.origin.x, height - (height*0.44444) - (height*0.133333), 0, (height*0.44444));
            
            cell.paymentNameLabel.font = [UIFont systemFontOfSize:(self.view.frame.size.height*0.02548726 > 17?(17):self.view.frame.size.height*0.02548726) weight:UIFontWeightRegular];
            cell.paymentAmountLabel.font = [UIFont systemFontOfSize:(self.view.frame.size.height*0.02548726 > 17?(17):self.view.frame.size.height*0.02548726) weight:UIFontWeightRegular];
            cell.paymentDescriptionLabel.font = [UIFont systemFontOfSize:(self.view.frame.size.height*0.02248876 > 15?(15):self.view.frame.size.height*0.02248876) weight:UIFontWeightMedium];
            
            CGFloat widthOfString = [[[GeneralObject alloc] init] WidthOfString:cell.paymentAmountLabel.text withFont:cell.paymentAmountLabel.font];
            CGRect newRect = cell.paymentAmountLabel.frame;
            newRect.size.width = widthOfString;
            newRect.origin.x = width - widthOfString - (width*0.03092784);
            cell.paymentAmountLabel.frame = newRect;
            
            newRect = cell.paymentNameLabel.frame;
            newRect.size.width = width - newRect.origin.x - cell.paymentAmountLabel.frame.size.width - (width*0.03092784) - (width*0.02061856);
            cell.paymentNameLabel.frame = newRect;
            
            newRect = cell.paymentDescriptionLabel.frame;
            newRect.size.width = width - newRect.origin.x - (width*0.03092784);
            cell.paymentDescriptionLabel.frame = newRect;
            
            int lineCount = [[[GeneralObject alloc] init] LineCountForText:paymentDescription label:cell.paymentDescriptionLabel];
            
            newRect = cell.paymentDescriptionLabel.frame;
            newRect.size.height = descriptionLabelLineHeight * lineCount;
            newRect.origin.y = height - (height*0.44444) - (height*0.133333);
            cell.paymentDescriptionLabel.frame = newRect;
            
        }
        
    } else {
        
        cell.arrowImageView.hidden = YES;
        
        NSString *paymentDescription = _viewingEarned == YES ? [self GenerateEarnedDescriptionNo1:indexPath] : [self GenerateOwedDescriptionNo1:indexPath];
        CGFloat cellHeightNo1 = [self GenerateCellHeight:paymentDescription tableView:tableView];
        
        height = (self.view.frame.size.height*0.12143928 > 81?(81):self.view.frame.size.height*0.12143928)*0.7037037;
        
        cell.firstUserImageView.frame = CGRectMake(width*0.03092784, cellHeightNo1*0.5 - (height*0.5)*0.5, height*0.5, height*0.5);
        cell.secondUserImageView.frame = CGRectMake(cell.firstUserImageView.frame.origin.x + cell.firstUserImageView.frame.size.width*0.8, cell.firstUserImageView.frame.origin.y, cell.firstUserImageView.frame.size.width, cell.firstUserImageView.frame.size.height);
        
        cell.firstUserImageView.layer.borderWidth = 2.0f;
        cell.firstUserImageView.layer.borderColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTertiary].CGColor : [[[LightDarkModeObject alloc] init] LightModeSecondary].CGColor;
        cell.firstUserImageView.layer.cornerRadius = cell.firstUserImageView.frame.size.height/2;
        cell.firstUserImageView.contentMode = UIViewContentModeScaleAspectFill;
        
        cell.secondUserImageView.layer.borderWidth = 2.0f;
        cell.secondUserImageView.layer.borderColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTertiary].CGColor : [[[LightDarkModeObject alloc] init] LightModeSecondary].CGColor;
        cell.secondUserImageView.layer.cornerRadius = cell.secondUserImageView.frame.size.height/2;
        cell.secondUserImageView.contentMode = UIViewContentModeScaleAspectFill;
        
        cell.paymentDescriptionLabel.frame = CGRectMake(cell.secondUserImageView.frame.origin.x + cell.secondUserImageView.frame.size.width + (width*0.02061856), height*0.5 - ((height*0.44444)*0.5), 0, (height*0.44444));
        
        CGRect newRect = cell.paymentDescriptionLabel.frame;
        newRect.size.width = width - newRect.origin.x - (width*0.03092784);
        cell.paymentDescriptionLabel.frame = newRect;
        
        int lineCount = [[[GeneralObject alloc] init] LineCountForText:paymentDescription label:cell.paymentDescriptionLabel];
      
        newRect = cell.paymentDescriptionLabel.frame;
        newRect.size.height = descriptionLabelLineHeight * lineCount;
        newRect.origin.y = cellHeightNo1*0.5 - (newRect.size.height)*0.5;
        cell.paymentDescriptionLabel.frame = newRect;
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_viewingOwed == NO && _viewingEarned == NO) {
        
        if (tableView == _owedTableView && [_customSegmentControl selectedSegmentIndex] == 0) {
            
            NSString *currentSection = [owedDict allKeys][indexPath.section];
            
            NSArray *keysArray = [owedDict[currentSection] allKeys];
            NSArray *sortedKeysArray = [keysArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
            NSString *userIDs = [sortedKeysArray count] > indexPath.row ? sortedKeysArray[indexPath.row] : @"";
            
            NSArray *arr = [userIDs componentsSeparatedByString:@" •• "];
            
            NSString *userIDWhoIsOwed = arr[0];
            NSString *userIDWhoOwes = arr[1];
            
            [[[PushObject alloc] init] PushToViewPaymentsViewController:_homeMembersDict itemDict:_itemDict dataDisplayDict:_dataDisplayDict folderDict:_folderDict taskListDict:_taskListDict templateDict:_templateDict draftDict:_draftDict topicDict:_topicDict notificationSettingsDict:_notificationSettingsDict homeMembersArray:_homeMembersArray itemNamesAlreadyUsed:_itemNamesAlreadyUsed allItemAssignedToArrays:_allItemAssignedToArrays allItemTagsArrays:_allItemTagsArrays allItemIDsArrays:_allItemIDsArrays viewingOwed:YES viewingEarned:NO viewingUserIDWhoOwesMoney:userIDWhoOwes viewingUserIDWhoIsOwedMoney:userIDWhoIsOwed currentViewController:self];
            
        } else if (tableView == _owedTableView && [_customSegmentControl selectedSegmentIndex] == 2) {
            
            NSString *currentSection = [earnedDict allKeys][indexPath.section];
            NSString *userIDWhoOwes = currentSection;
           
            [[[PushObject alloc] init] PushToViewPaymentsViewController:_homeMembersDict itemDict:_itemDict dataDisplayDict:_dataDisplayDict folderDict:_folderDict taskListDict:_taskListDict templateDict:_templateDict draftDict:_draftDict topicDict:_topicDict notificationSettingsDict:_notificationSettingsDict homeMembersArray:_homeMembersArray itemNamesAlreadyUsed:_itemNamesAlreadyUsed allItemAssignedToArrays:_allItemAssignedToArrays allItemTagsArrays:_allItemTagsArrays allItemIDsArrays:_allItemIDsArrays viewingOwed:NO viewingEarned:YES viewingUserIDWhoOwesMoney:@"" viewingUserIDWhoIsOwedMoney:userIDWhoOwes currentViewController:self];
            
        } else if (tableView == _paymentsTableView) {
            
            NSString *currentSection = [paymentsDictNo1 allKeys][indexPath.section];
            NSMutableArray *paymentsDict = paymentsDictNo1[currentSection];
            
            NSString *itemID = paymentsDict[indexPath.row][@"ItemID"];
            NSString *itemOccurrenceID = paymentsDict[indexPath.row][@"ItemOccurrenceID"];
            
            [[[PushObject alloc] init] PushToViewTaskViewController:itemID itemOccurrenceID:itemOccurrenceID itemDictFromPreviousPage:[NSMutableDictionary dictionary] homeMembersArray:_homeMembersArray homeMembersDict:_homeMembersDict itemOccurrencesDict:[NSMutableDictionary dictionary] folderDict:_folderDict taskListDict:_taskListDict templateDict:_templateDict draftDict:_draftDict notificationSettingsDict:_notificationSettingsDict topicDict:_topicDict itemNamesAlreadyUsed:_itemNamesAlreadyUsed allItemAssignedToArrays:_allItemAssignedToArrays allItemTagsArrays:_allItemTagsArrays allItemIDsArrays:_allItemIDsArrays currentViewController:self Superficial:NO];
            
        }
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_viewingOwed == NO && _viewingEarned == NO) {

        if (tableView == _owedTableView && [_customSegmentControl selectedSegmentIndex] == 0) {

            NSString *owedDescription = [self GenerateOwedDescription:indexPath];
            CGFloat cellHeight = [self GenerateCellHeight:owedDescription tableView:tableView];

            return cellHeight; //81*0.7037037

        } else if (tableView == _owedTableView && [_customSegmentControl selectedSegmentIndex] == 2) {

            NSString *earnedDescription = [self GenerateEarnedDescription:indexPath];
            CGFloat cellHeight = [self GenerateCellHeight:earnedDescription tableView:tableView];

            return cellHeight; //81*0.7037037

        } else if (tableView == _paymentsTableView) {

            NSString *paymentDescription = [self GeneratePaymentDescription:indexPath];
            CGFloat cellHeight = [self GenerateCellHeight:paymentDescription tableView:tableView];
          
            return cellHeight; //90

        }

    } else if (_viewingOwed == YES) {
        
        NSString *paymentDescription = [self GenerateOwedDescriptionNo1:indexPath];
        CGFloat cellHeight = [self GenerateCellHeight:paymentDescription tableView:tableView];
        
        return cellHeight; //90
        
    } else if (_viewingEarned == YES) {
        
        NSString *paymentDescription = [self GenerateEarnedDescriptionNo1:indexPath];
        CGFloat cellHeight = [self GenerateCellHeight:paymentDescription tableView:tableView];
        
        return cellHeight; //90
        
    }
    
    return 81;
}

#pragma mark

#pragma mark

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (_viewingOwed == NO && _viewingEarned == NO) {

        CGFloat width = CGRectGetWidth(self.view.bounds);
        CGFloat height = CGRectGetHeight(self.view.bounds);





        UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(((width*(1-0.9034))/2), (height*0.02377717 > 17.5?(17.5):height*0.02377717), width*0.9034, (height*0.03736413 > 27.5?(27.5):height*0.03736413))];
        mainView.layer.cornerRadius = 5;
        mainView.backgroundColor = [UIColor clearColor];





        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 0)];
        [view setBackgroundColor:self.view.backgroundColor];
        view.tag = section;





        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width*0.9034, (height*0.04076087 > 30?(30):height*0.04076087))];
        [label setFont:[UIFont systemFontOfSize:(height*0.02173913 > 16?(16):height*0.02173913) weight:UIFontWeightSemibold]];
        [label setTextAlignment:NSTextAlignmentLeft];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setTextColor:[[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTextPrimary] : [[[LightDarkModeObject alloc] init] LightModeTextPrimary]];

        NSString *userID = @"";

        if (tableView == _owedTableView && [_customSegmentControl selectedSegmentIndex] == 0) {
            userID = [owedDict allKeys][section];
        } else if (tableView == _owedTableView && [_customSegmentControl selectedSegmentIndex] == 2) {
            userID = [earnedDict allKeys][section];
        } else {
            userID = [paymentsDictNo1 allKeys][section];
        }

        NSUInteger indexWhoIsOwed = [_homeMembersDict[@"UserID"] indexOfObject:userID];
        NSString *usernameWhoIsOwed = _homeMembersDict && _homeMembersDict[@"Username"] && [(NSArray *)_homeMembersDict[@"Username"] count] > indexWhoIsOwed ? _homeMembersDict[@"Username"][indexWhoIsOwed] : @"";

        [label setText:usernameWhoIsOwed];






        [view addSubview:mainView];
        [mainView addSubview:label];





        return view;

    }
    
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger )section {
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    CGFloat heightToUse = (height*0.0824587 > 55?(55):height*0.0824587);

    return heightToUse;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger )section {
    
    return 0.1;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (_viewingOwed == NO && _viewingEarned == NO) {

        if (tableView == _owedTableView && [_customSegmentControl selectedSegmentIndex] == 0) {
            return [[owedDict allKeys] count];
        } else if (tableView == _owedTableView && [_customSegmentControl selectedSegmentIndex] == 2) {
            return [[earnedDict allKeys] count];
        } else {
            return [[paymentsDictNo1 allKeys] count];
        }

    }
    
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

#pragma mark TableView Methods

-(NSAttributedString *)GenerateOwedDescriptionString:(NSString *)userIDs usernameWhoIsOwed:(NSString *)usernameWhoIsOwed usernameWhoOwes:(NSString *)usernameWhoOwes currentSection:(NSString *)currentSection cell:(ViewPaymentsCell *)cell {
    
    NSString *owedDescription = [NSString stringWithFormat:@"%@ owes %@ to %@", usernameWhoOwes, owedDict[currentSection][userIDs], usernameWhoIsOwed];
    
    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:157.0f/255.0f green:156.0f/255.0f blue:165.0f/255.0f alpha:1.0f], NSForegroundColorAttributeName, nil];
    
    NSMutableAttributedString *owedDescriptionAttributedString = [[NSMutableAttributedString alloc] initWithString:owedDescription attributes:attrsDictionary];
    
    NSRange rangeOfUsernameWhoOwes = [[NSString stringWithFormat:@"%@", owedDescriptionAttributedString] rangeOfString:usernameWhoIsOwed];
    NSRange rangeOfUsernameWhoIsOwed = [usernameWhoIsOwed isEqualToString:usernameWhoOwes] ? [[NSString stringWithFormat:@"%@", owedDescriptionAttributedString] rangeOfString:[NSString stringWithFormat:@"owes %@ to %@", owedDict[currentSection][userIDs], usernameWhoOwes]] : [[NSString stringWithFormat:@"%@", owedDescriptionAttributedString] rangeOfString:usernameWhoOwes];
    NSRange rangeOfItemAmount = [[NSString stringWithFormat:@"%@", owedDescriptionAttributedString] rangeOfString:owedDict[currentSection][userIDs]];
    
    UIFont *font = [UIFont systemFontOfSize:cell.paymentDescriptionLabel.font.pointSize weight:UIFontWeightSemibold];
    UIColor *color = [UIColor colorWithRed:77.0f/225.0f green:76.0f/225.0f blue:77.0f/225.0f alpha:1.0f];
    
    NSUInteger lengthOfStringBetweenUsernames = [[NSString stringWithFormat:@"owes %@ to ", owedDict[currentSection][userIDs]] length];
    
    if ([usernameWhoIsOwed isEqualToString:usernameWhoOwes]) {
        
        [owedDescriptionAttributedString addAttribute:NSFontAttributeName value:font range:
         NSMakeRange(rangeOfUsernameWhoIsOwed.location+lengthOfStringBetweenUsernames, rangeOfUsernameWhoIsOwed.length-lengthOfStringBetweenUsernames)];
        [owedDescriptionAttributedString addAttribute:NSForegroundColorAttributeName value:color range:
         NSMakeRange(rangeOfUsernameWhoIsOwed.location+lengthOfStringBetweenUsernames, rangeOfUsernameWhoIsOwed.length-lengthOfStringBetweenUsernames)];
        
        [owedDescriptionAttributedString addAttribute:NSFontAttributeName value:font range: NSMakeRange(rangeOfUsernameWhoOwes.location, rangeOfUsernameWhoOwes.length)];
        [owedDescriptionAttributedString addAttribute:NSForegroundColorAttributeName value:color range: NSMakeRange(rangeOfUsernameWhoOwes.location, rangeOfUsernameWhoOwes.length)];
        
        [owedDescriptionAttributedString addAttribute:NSFontAttributeName value:font range: NSMakeRange(rangeOfItemAmount.location, rangeOfItemAmount.length)];
        [owedDescriptionAttributedString addAttribute:NSForegroundColorAttributeName value:color range: NSMakeRange(rangeOfItemAmount.location, rangeOfItemAmount.length)];
        
    } else {
        
        [owedDescriptionAttributedString addAttribute:NSFontAttributeName value:font range: NSMakeRange(rangeOfUsernameWhoIsOwed.location, rangeOfUsernameWhoIsOwed.length)];
        [owedDescriptionAttributedString addAttribute:NSForegroundColorAttributeName value:color range: NSMakeRange(rangeOfUsernameWhoIsOwed.location, rangeOfUsernameWhoIsOwed.length)];
        
        [owedDescriptionAttributedString addAttribute:NSFontAttributeName value:font range: NSMakeRange(rangeOfUsernameWhoOwes.location, rangeOfUsernameWhoOwes.length)];
        [owedDescriptionAttributedString addAttribute:NSForegroundColorAttributeName value:color range: NSMakeRange(rangeOfUsernameWhoOwes.location, rangeOfUsernameWhoOwes.length)];
        
        [owedDescriptionAttributedString addAttribute:NSFontAttributeName value:font range: NSMakeRange(rangeOfItemAmount.location, rangeOfItemAmount.length)];
        [owedDescriptionAttributedString addAttribute:NSForegroundColorAttributeName value:color range: NSMakeRange(rangeOfItemAmount.location, rangeOfItemAmount.length)];
        
    }
    
    return owedDescriptionAttributedString;
}

-(NSAttributedString *)GenerateOwedDescriptionStringNo1:(NSString *)usernameWhoOwes usernameWhoIsOwed:(NSString *)usernameWhoIsOwed itemAmount:(NSString *)itemAmount itemName:(NSString *)itemName cell:(ViewPaymentsCell *)cell {

    NSString *owedDescription = [NSString stringWithFormat:@"%@ owes %@ to %@ for %@", usernameWhoOwes, itemAmount, usernameWhoIsOwed, itemName];
    
    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:157.0f/255.0f green:156.0f/255.0f blue:165.0f/255.0f alpha:1.0f], NSForegroundColorAttributeName, nil];
    
    NSMutableAttributedString *owedDescriptionAttributedString = [[NSMutableAttributedString alloc] initWithString:owedDescription attributes:attrsDictionary];
    
    NSRange rangeOfUsernameWhoOwes = [[NSString stringWithFormat:@"%@", owedDescriptionAttributedString] rangeOfString:usernameWhoIsOwed];
    NSRange rangeOfUsernameWhoIsOwed = [usernameWhoIsOwed isEqualToString:usernameWhoOwes] ? [[NSString stringWithFormat:@"%@", owedDescriptionAttributedString] rangeOfString:[NSString stringWithFormat:@"owes %@ to %@", itemAmount, usernameWhoIsOwed]] : [[NSString stringWithFormat:@"%@", owedDescriptionAttributedString] rangeOfString:usernameWhoOwes];
    NSRange rangeOfItemName = [[NSString stringWithFormat:@"%@", owedDescriptionAttributedString] rangeOfString:itemName];
    NSRange rangeOfItemAmount = [[NSString stringWithFormat:@"%@", owedDescriptionAttributedString] rangeOfString:itemAmount];
   
    UIFont *font = [UIFont systemFontOfSize:cell.paymentDescriptionLabel.font.pointSize weight:UIFontWeightSemibold];
    UIColor *color = [UIColor colorWithRed:77.0f/225.0f green:76.0f/225.0f blue:77.0f/225.0f alpha:1.0f];
    
    NSUInteger lengthOfStringBetweenUsernames = [[NSString stringWithFormat:@"owes %@ to ", itemAmount] length];
    
    if ([usernameWhoIsOwed isEqualToString:usernameWhoOwes]) {
        
        [owedDescriptionAttributedString addAttribute:NSFontAttributeName value:font range:
         NSMakeRange(rangeOfUsernameWhoIsOwed.location+lengthOfStringBetweenUsernames, rangeOfUsernameWhoIsOwed.length-lengthOfStringBetweenUsernames)];
        [owedDescriptionAttributedString addAttribute:NSForegroundColorAttributeName value:color range:
         NSMakeRange(rangeOfUsernameWhoIsOwed.location+lengthOfStringBetweenUsernames, rangeOfUsernameWhoIsOwed.length-lengthOfStringBetweenUsernames)];
        
        [owedDescriptionAttributedString addAttribute:NSFontAttributeName value:font range: NSMakeRange(rangeOfUsernameWhoOwes.location, rangeOfUsernameWhoOwes.length)];
        [owedDescriptionAttributedString addAttribute:NSForegroundColorAttributeName value:color range: NSMakeRange(rangeOfUsernameWhoOwes.location, rangeOfUsernameWhoOwes.length)];
   
        [owedDescriptionAttributedString addAttribute:NSFontAttributeName value:font range: NSMakeRange(rangeOfItemName.location, rangeOfItemName.length)];
        [owedDescriptionAttributedString addAttribute:NSForegroundColorAttributeName value:color range: NSMakeRange(rangeOfItemName.location, rangeOfItemName.length)];
        
        [owedDescriptionAttributedString addAttribute:NSFontAttributeName value:font range: NSMakeRange(rangeOfItemAmount.location, rangeOfItemAmount.length)];
        [owedDescriptionAttributedString addAttribute:NSForegroundColorAttributeName value:color range: NSMakeRange(rangeOfItemAmount.location, rangeOfItemAmount.length)];
        
    } else {
        
        [owedDescriptionAttributedString addAttribute:NSFontAttributeName value:font range: NSMakeRange(rangeOfUsernameWhoOwes.location, rangeOfUsernameWhoOwes.length)];
        [owedDescriptionAttributedString addAttribute:NSForegroundColorAttributeName value:color range: NSMakeRange(rangeOfUsernameWhoOwes.location, rangeOfUsernameWhoOwes.length)];
        
        [owedDescriptionAttributedString addAttribute:NSFontAttributeName value:font range: NSMakeRange(rangeOfUsernameWhoIsOwed.location, rangeOfUsernameWhoIsOwed.length)];
        [owedDescriptionAttributedString addAttribute:NSForegroundColorAttributeName value:color range: NSMakeRange(rangeOfUsernameWhoIsOwed.location, rangeOfUsernameWhoIsOwed.length)];
    
        [owedDescriptionAttributedString addAttribute:NSFontAttributeName value:font range: NSMakeRange(rangeOfItemName.location, rangeOfItemName.length)];
        [owedDescriptionAttributedString addAttribute:NSForegroundColorAttributeName value:color range: NSMakeRange(rangeOfItemName.location, rangeOfItemName.length)];
        
        [owedDescriptionAttributedString addAttribute:NSFontAttributeName value:font range: NSMakeRange(rangeOfItemAmount.location, rangeOfItemAmount.length)];
        [owedDescriptionAttributedString addAttribute:NSForegroundColorAttributeName value:color range: NSMakeRange(rangeOfItemAmount.location, rangeOfItemAmount.length)];
        
    }
    
    return owedDescriptionAttributedString;
}

-(NSAttributedString *)GenerateEarnedDescriptionString:(NSString *)usernameWhoEarned currentSection:(NSString *)currentSection cell:(ViewPaymentsCell *)cell {
   
    NSString *earnedDescription = [NSString stringWithFormat:@"%@ has earned %@", usernameWhoEarned, earnedDict[currentSection]];
    
    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:157.0f/255.0f green:156.0f/255.0f blue:165.0f/255.0f alpha:1.0f], NSForegroundColorAttributeName, nil];
    
    NSMutableAttributedString *earnedDescriptionAttributedString = [[NSMutableAttributedString alloc] initWithString:earnedDescription attributes:attrsDictionary];
    
    NSRange rangeOfUsernameWhoEarned = [[NSString stringWithFormat:@"%@", earnedDescriptionAttributedString] rangeOfString:usernameWhoEarned];
    NSRange rangeOfItemAmount = [[NSString stringWithFormat:@"%@", earnedDescriptionAttributedString] rangeOfString:earnedDict[currentSection]];
    
    UIFont *font = [UIFont systemFontOfSize:cell.paymentDescriptionLabel.font.pointSize weight:UIFontWeightSemibold];
    UIColor *color = [UIColor colorWithRed:77.0f/225.0f green:76.0f/225.0f blue:77.0f/225.0f alpha:1.0f];
   
    [earnedDescriptionAttributedString addAttribute:NSFontAttributeName value:font range: NSMakeRange(rangeOfUsernameWhoEarned.location, rangeOfUsernameWhoEarned.length)];
    [earnedDescriptionAttributedString addAttribute:NSForegroundColorAttributeName value:color range: NSMakeRange(rangeOfUsernameWhoEarned.location, rangeOfUsernameWhoEarned.length)];
    
    [earnedDescriptionAttributedString addAttribute:NSFontAttributeName value:font range: NSMakeRange(rangeOfItemAmount.location, rangeOfItemAmount.length)];
    [earnedDescriptionAttributedString addAttribute:NSForegroundColorAttributeName value:color range: NSMakeRange(rangeOfItemAmount.location, rangeOfItemAmount.length)];
   
    return earnedDescriptionAttributedString;
}

-(NSAttributedString *)GenerateEarnedDescriptionStringNo1:(NSString *)usernameWhoEarned usernameWhoGave:(NSString *)usernameWhoGave itemAmount:(NSString *)itemAmount itemName:(NSString *)itemName cell:(ViewPaymentsCell *)cell {
  
    NSString *earnedDescription = [NSString stringWithFormat:@"%@ earned %@ from %@ for %@", usernameWhoEarned, itemAmount, usernameWhoGave, itemName];
    
    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:157.0f/255.0f green:156.0f/255.0f blue:165.0f/255.0f alpha:1.0f], NSForegroundColorAttributeName, nil];
    
    NSMutableAttributedString *earnedDescriptionAttributedString = [[NSMutableAttributedString alloc] initWithString:earnedDescription attributes:attrsDictionary];
    
    NSRange rangeOfUsernameWhoEarned = [[NSString stringWithFormat:@"%@", earnedDescriptionAttributedString] rangeOfString:usernameWhoEarned];
    NSRange rangeOfUsernameWhoGave = [usernameWhoEarned isEqualToString:usernameWhoGave] ? [[NSString stringWithFormat:@"%@", earnedDescriptionAttributedString] rangeOfString:[NSString stringWithFormat:@"earned %@ from %@", itemAmount, usernameWhoGave]] : [[NSString stringWithFormat:@"%@", earnedDescriptionAttributedString] rangeOfString:usernameWhoGave];
    NSRange rangeOfItemAmount = [[NSString stringWithFormat:@"%@", earnedDescriptionAttributedString] rangeOfString:itemAmount];
    NSRange rangeOfItemName = [[NSString stringWithFormat:@"%@", earnedDescriptionAttributedString] rangeOfString:itemName];
    
    UIFont *font = [UIFont systemFontOfSize:cell.paymentDescriptionLabel.font.pointSize weight:UIFontWeightSemibold];
    UIColor *color = [UIColor colorWithRed:77.0f/225.0f green:76.0f/225.0f blue:77.0f/225.0f alpha:1.0f];
    
    NSUInteger lengthOfStringBetweenUsernames = [[NSString stringWithFormat:@"earned %@ from ", itemAmount] length];
    
    if ([usernameWhoEarned isEqualToString:usernameWhoGave]) {
        
        [earnedDescriptionAttributedString addAttribute:NSFontAttributeName value:font range:
         NSMakeRange(rangeOfUsernameWhoGave.location+lengthOfStringBetweenUsernames, rangeOfUsernameWhoGave.length-lengthOfStringBetweenUsernames)];
        [earnedDescriptionAttributedString addAttribute:NSForegroundColorAttributeName value:color range:
         NSMakeRange(rangeOfUsernameWhoGave.location+lengthOfStringBetweenUsernames, rangeOfUsernameWhoGave.length-lengthOfStringBetweenUsernames)];
        
        [earnedDescriptionAttributedString addAttribute:NSFontAttributeName value:font range: NSMakeRange(rangeOfUsernameWhoEarned.location, rangeOfUsernameWhoEarned.length)];
        [earnedDescriptionAttributedString addAttribute:NSForegroundColorAttributeName value:color range: NSMakeRange(rangeOfUsernameWhoEarned.location, rangeOfUsernameWhoEarned.length)];
        
        [earnedDescriptionAttributedString addAttribute:NSFontAttributeName value:font range: NSMakeRange(rangeOfItemAmount.location, rangeOfItemAmount.length)];
        [earnedDescriptionAttributedString addAttribute:NSForegroundColorAttributeName value:color range: NSMakeRange(rangeOfItemAmount.location, rangeOfItemAmount.length)];
        
        [earnedDescriptionAttributedString addAttribute:NSFontAttributeName value:font range: NSMakeRange(rangeOfItemName.location, rangeOfItemName.length)];
        [earnedDescriptionAttributedString addAttribute:NSForegroundColorAttributeName value:color range: NSMakeRange(rangeOfItemName.location, rangeOfItemName.length)];
        
    } else {
        
        [earnedDescriptionAttributedString addAttribute:NSFontAttributeName value:font range: NSMakeRange(rangeOfUsernameWhoEarned.location, rangeOfUsernameWhoEarned.length)];
        [earnedDescriptionAttributedString addAttribute:NSForegroundColorAttributeName value:color range: NSMakeRange(rangeOfUsernameWhoEarned.location, rangeOfUsernameWhoEarned.length)];
        
        [earnedDescriptionAttributedString addAttribute:NSFontAttributeName value:font range: NSMakeRange(rangeOfUsernameWhoGave.location, rangeOfUsernameWhoGave.length)];
        [earnedDescriptionAttributedString addAttribute:NSForegroundColorAttributeName value:color range: NSMakeRange(rangeOfUsernameWhoGave.location, rangeOfUsernameWhoGave.length)];
        
        [earnedDescriptionAttributedString addAttribute:NSFontAttributeName value:font range: NSMakeRange(rangeOfItemAmount.location, rangeOfItemAmount.length)];
        [earnedDescriptionAttributedString addAttribute:NSForegroundColorAttributeName value:color range: NSMakeRange(rangeOfItemAmount.location, rangeOfItemAmount.length)];
        
        [earnedDescriptionAttributedString addAttribute:NSFontAttributeName value:font range: NSMakeRange(rangeOfItemName.location, rangeOfItemName.length)];
        [earnedDescriptionAttributedString addAttribute:NSForegroundColorAttributeName value:color range: NSMakeRange(rangeOfItemName.location, rangeOfItemName.length)];
        
    }
    
    return earnedDescriptionAttributedString;
}

-(NSAttributedString *)GeneratePaymentDescriptionString:(NSString *)dateMarked usernameWhoPaid:(NSString *)usernameWhoPaid itemCreatedByUsername:(NSString *)itemCreatedByUsername cell:(ViewPaymentsCell *)cell{
   
    NSString *convertedDateString = [[[GeneralObject alloc] init] GenerateDateWithConvertedFormatWithFormat:@"yyyy-MM-dd HH:mm:ss" dateToConvert:dateMarked newFormat:@"MMM d" returnAs:[NSString class]];
    NSString *convertedTimeString = [[[GeneralObject alloc] init] GenerateDateWithConvertedFormatWithFormat:@"yyyy-MM-dd HH:mm:ss" dateToConvert:dateMarked newFormat:@"h:mm a" returnAs:[NSString class]];
    NSString *convertedWeekdayString = [[[GeneralObject alloc] init] GenerateDateWithConvertedFormatWithFormat:@"yyyy-MM-dd HH:mm:ss" dateToConvert:dateMarked newFormat:@"EEE" returnAs:[NSString class]];
    
    NSString *paymentDescription = [NSString stringWithFormat:@"%@ paid %@ on %@., %@ at %@", usernameWhoPaid, itemCreatedByUsername, convertedWeekdayString, convertedDateString, convertedTimeString];
    
    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:157.0f/255.0f green:156.0f/255.0f blue:165.0f/255.0f alpha:1.0f], NSForegroundColorAttributeName, nil];
    
    NSMutableAttributedString *paymentDescriptionAttributedString = [[NSMutableAttributedString alloc] initWithString:paymentDescription attributes:attrsDictionary];
    
    NSRange rangeOfUsernameWhoPays = [[NSString stringWithFormat:@"%@", paymentDescriptionAttributedString] rangeOfString:usernameWhoPaid];
    NSRange rangeOfUsernameIsPaid = [usernameWhoPaid isEqualToString:itemCreatedByUsername] ? [[NSString stringWithFormat:@"%@", paymentDescriptionAttributedString] rangeOfString:[NSString stringWithFormat:@"paid %@", itemCreatedByUsername]] : [[NSString stringWithFormat:@"%@", paymentDescriptionAttributedString] rangeOfString:itemCreatedByUsername];
    
    [paymentDescriptionAttributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:cell.paymentDescriptionLabel.font.pointSize weight:UIFontWeightBold] range: NSMakeRange(rangeOfUsernameWhoPays.location, rangeOfUsernameWhoPays.length)];
    
    UIFont *font = [UIFont systemFontOfSize:cell.paymentDescriptionLabel.font.pointSize weight:UIFontWeightBold];
    UIColor *color = [UIColor colorWithRed:77.0f/225.0f green:76.0f/225.0f blue:77.0f/225.0f alpha:1.0f];
    
    NSUInteger lengthOfStringBetweenUsernames = [@"paid " length];
    
    if ([usernameWhoPaid isEqualToString:itemCreatedByUsername]) {
        
        [paymentDescriptionAttributedString addAttribute:NSFontAttributeName value:font range:
         NSMakeRange(rangeOfUsernameIsPaid.location+lengthOfStringBetweenUsernames, rangeOfUsernameIsPaid.length-lengthOfStringBetweenUsernames)];
        
        [paymentDescriptionAttributedString addAttribute:NSForegroundColorAttributeName value:color range:
         NSMakeRange(rangeOfUsernameIsPaid.location+lengthOfStringBetweenUsernames, rangeOfUsernameIsPaid.length-lengthOfStringBetweenUsernames)];
        
        [paymentDescriptionAttributedString addAttribute:NSFontAttributeName value:font range: NSMakeRange(rangeOfUsernameWhoPays.location, rangeOfUsernameWhoPays.length)];
        [paymentDescriptionAttributedString addAttribute:NSForegroundColorAttributeName value:color range: NSMakeRange(rangeOfUsernameWhoPays.location, rangeOfUsernameWhoPays.length)];
        
    } else {
        
        [paymentDescriptionAttributedString addAttribute:NSFontAttributeName value:font range: NSMakeRange(rangeOfUsernameIsPaid.location, rangeOfUsernameIsPaid.length)];
        [paymentDescriptionAttributedString addAttribute:NSForegroundColorAttributeName value:color range: NSMakeRange(rangeOfUsernameIsPaid.location, rangeOfUsernameIsPaid.length)];
        
        [paymentDescriptionAttributedString addAttribute:NSFontAttributeName value:font range: NSMakeRange(rangeOfUsernameWhoPays.location, rangeOfUsernameWhoPays.length)];
        [paymentDescriptionAttributedString addAttribute:NSForegroundColorAttributeName value:color range: NSMakeRange(rangeOfUsernameWhoPays.location, rangeOfUsernameWhoPays.length)];
        
    }
    
    return paymentDescriptionAttributedString;
}

-(void)GenerateOwedProfileImageViews:(NSString *)userIDWhoIsOwed userIDWhoOwes:(NSString *)userIDWhoOwes cell:(ViewPaymentsCell *)cell {
    
    NSUInteger indexWhoIsOwed = [_homeMembersDict[@"UserID"] indexOfObject:userIDWhoIsOwed];
    NSUInteger indexWhoOwes = [_homeMembersDict[@"UserID"] indexOfObject:userIDWhoOwes];
    
    NSString *usernameWhoIsOwed = _homeMembersDict && _homeMembersDict[@"Username"] && [(NSArray *)_homeMembersDict[@"Username"] count] > indexWhoIsOwed ? _homeMembersDict[@"Username"][indexWhoIsOwed] : @"";
    NSString *usernameWhoOwes = _homeMembersDict && _homeMembersDict[@"Username"] && [(NSArray *)_homeMembersDict[@"Username"] count] > indexWhoOwes ? _homeMembersDict[@"Username"][indexWhoOwes] : @"";
    
    NSString *profileImageURLWhoIsOwed = _homeMembersDict && _homeMembersDict[@"ProfileImageURL"] && [(NSArray *)_homeMembersDict[@"ProfileImageURL"] count] > indexWhoIsOwed ? _homeMembersDict[@"ProfileImageURL"][indexWhoIsOwed] : @"";
    NSString *profileImageURLWhoOwes = _homeMembersDict && _homeMembersDict[@"ProfileImageURL"] && [(NSArray *)_homeMembersDict[@"ProfileImageURL"] count] > indexWhoOwes ? _homeMembersDict[@"ProfileImageURL"][indexWhoOwes] : @"";
    
    UIColor *backgroundColor = [[[GeneralObject alloc] init] GenerateAppColor:0.15f];
    UIColor *textColor = [[[GeneralObject alloc] init] GenerateAppColor:1.0f];
    
    BOOL CustomProfileImageDoesNotExist = (profileImageURLWhoIsOwed == nil || profileImageURLWhoIsOwed.length == 0 || [profileImageURLWhoIsOwed containsString:@"(null)"] || [profileImageURLWhoIsOwed isEqualToString:@"xxx"] || [profileImageURLWhoIsOwed isEqualToString:@"XXX"] || [profileImageURLWhoIsOwed isEqualToString:@"https://firebasestorage.googleapis.com/v0/b/wedivvy-afe04.appspot.com/o/DefaultImages%2FdefaultProfileImage.png?alt=media&token=6892f430-8337-4327-89a4-53a403d1186c"] || [profileImageURLWhoIsOwed containsString:@"DefaultImage"]);
    
    if (CustomProfileImageDoesNotExist == YES) {
        
        [cell.firstUserImageView setImageWithString:usernameWhoIsOwed color:backgroundColor circular:YES textAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Futura-Medium" size:cell.firstUserImageView.frame.size.height*0.45], NSForegroundColorAttributeName:textColor}];
        
    } else {
        
        [cell.firstUserImageView sd_setImageWithURL:[NSURL URLWithString:profileImageURLWhoIsOwed]];
        
    }
    
    CustomProfileImageDoesNotExist = (profileImageURLWhoOwes == nil || profileImageURLWhoOwes.length == 0 || [profileImageURLWhoOwes containsString:@"(null)"] || [profileImageURLWhoOwes isEqualToString:@"xxx"] || [profileImageURLWhoOwes isEqualToString:@"XXX"] || [profileImageURLWhoOwes isEqualToString:@"https://firebasestorage.googleapis.com/v0/b/wedivvy-afe04.appspot.com/o/DefaultImages%2FdefaultProfileImage.png?alt=media&token=6892f430-8337-4327-89a4-53a403d1186c"] || [profileImageURLWhoOwes containsString:@"DefaultImage"]);
    
    if (CustomProfileImageDoesNotExist == YES) {
        
        [cell.secondUserImageView setImageWithString:usernameWhoOwes color:backgroundColor circular:YES textAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Futura-Medium" size:cell.secondUserImageView.frame.size.height*0.45], NSForegroundColorAttributeName:textColor}];
        
    } else {
        
        [cell.secondUserImageView sd_setImageWithURL:[NSURL URLWithString:profileImageURLWhoOwes]];
        
    }
    
}

-(void)GeneratePaidProfileImageViews:(NSString *)markedFor itemCreatedBy:(NSString *)itemCreatedBy cell:(ViewPaymentsCell *)cell {
    
    NSUInteger index = [_homeMembersDict[@"UserID"] indexOfObject:markedFor];
    NSUInteger indexNo1 = [_homeMembersDict[@"UserID"] indexOfObject:itemCreatedBy];
    
    NSString *username = _homeMembersDict && _homeMembersDict[@"Username"] && [(NSArray *)_homeMembersDict[@"Username"] count] > index ? _homeMembersDict[@"Username"][index] : @"";
    NSString *itemCreatedByUsername = _homeMembersDict && _homeMembersDict[@"Username"] && [(NSArray *)_homeMembersDict[@"Username"] count] > indexNo1 ? _homeMembersDict[@"Username"][indexNo1] : @"";
    
    NSString *profileImageURL = _homeMembersDict && _homeMembersDict[@"ProfileImageURL"] && [(NSArray *)_homeMembersDict[@"ProfileImageURL"] count] > index ? _homeMembersDict[@"ProfileImageURL"][index] : @"";
    NSString *profileImageURLNo1 = _homeMembersDict && _homeMembersDict[@"ProfileImageURL"] && [(NSArray *)_homeMembersDict[@"ProfileImageURL"] count] > indexNo1 ? _homeMembersDict[@"ProfileImageURL"][indexNo1] : @"";
    
    UIColor *backgroundColor = [[[GeneralObject alloc] init] GenerateAppColor:0.15f];
    UIColor *textColor = [[[GeneralObject alloc] init] GenerateAppColor:1.0f];
    
    BOOL CustomProfileImageDoesNotExist = (profileImageURL == nil || profileImageURL.length == 0 || [profileImageURL containsString:@"(null)"] || [profileImageURL isEqualToString:@"xxx"] || [profileImageURL isEqualToString:@"XXX"] || [profileImageURL isEqualToString:@"https://firebasestorage.googleapis.com/v0/b/wedivvy-afe04.appspot.com/o/DefaultImages%2FdefaultProfileImage.png?alt=media&token=6892f430-8337-4327-89a4-53a403d1186c"] || [profileImageURL containsString:@"DefaultImage"]);
    
    if (CustomProfileImageDoesNotExist == YES) {
        
        [cell.firstUserImageView setImageWithString:username color:backgroundColor circular:YES textAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Futura-Medium" size:cell.firstUserImageView.frame.size.height*0.45], NSForegroundColorAttributeName:textColor}];
        
    } else {
        
        [cell.firstUserImageView sd_setImageWithURL:[NSURL URLWithString:profileImageURL]];
        
    }
    
    CustomProfileImageDoesNotExist = (profileImageURLNo1 == nil || profileImageURLNo1.length == 0 || [profileImageURLNo1 containsString:@"(null)"] || [profileImageURLNo1 isEqualToString:@"xxx"] || [profileImageURLNo1 isEqualToString:@"XXX"] || [profileImageURLNo1 isEqualToString:@"https://firebasestorage.googleapis.com/v0/b/wedivvy-afe04.appspot.com/o/DefaultImages%2FdefaultProfileImage.png?alt=media&token=6892f430-8337-4327-89a4-53a403d1186c"] || [profileImageURLNo1 containsString:@"DefaultImage"]);
    
    if (CustomProfileImageDoesNotExist == YES) {
        
        [cell.secondUserImageView setImageWithString:itemCreatedByUsername color:backgroundColor circular:YES textAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Futura-Medium" size:cell.secondUserImageView.frame.size.height*0.45], NSForegroundColorAttributeName:textColor}];
        
    } else {
        
        [cell.secondUserImageView sd_setImageWithURL:[NSURL URLWithString:profileImageURLNo1]];
        
    }
    
}

@end
