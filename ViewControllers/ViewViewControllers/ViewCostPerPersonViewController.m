//
//  ViewCostPerPersonViewController.m
//  WeDivvy
//
//  Created by Philip Nagel on 7/19/21.
//

#import "UIImageView+Letters.h"

#import "ViewCostPerPersonViewController.h"
#import "AppDelegate.h"
#import "CostPerPersonCell.h"

#import <SDWebImage/SDWebImage.h>
#import <MRProgress/MRProgressOverlayView.h>

#import "GeneralObject.h"
#import "GetDataObject.h"
#import "SetDataObject.h"
#import "BoolDataObject.h"
#import "LightDarkModeObject.h"

@interface ViewCostPerPersonViewController () {
    
    MRProgressOverlayView *progressView;
    
    NSMutableDictionary *userDict;
    NSMutableArray *costPerPersonArray;
   
    UIActivityIndicatorView *activityControl;
   
    NSString *localCurrencySymbol;
    NSString *localCurrencyDecimalSeparatorSymbol;
    NSString *localCurrencyNumberSeparatorSymbol;
    
    BOOL keyboardIsShown;
    BOOL PercentageShown;
    
}

@end

@implementation ViewCostPerPersonViewController

#pragma mark - System Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self InitMethod];
    
    [self BarButtonItems];
    
    [self SetUpKeyboardNSNotifications];
    
    [[[GetDataObject alloc] init] GetDataCostPerPersonUserData:_itemAssignedToArray costArray:costPerPersonArray costPerPersonDict:_costPerPersonDict completionHandler:^(BOOL finished, NSMutableDictionary *returningUserDict) {
        
        self->userDict = [[self GenerateStartingUserDictCostWithSymbols:returningUserDict] mutableCopy];
       
        [self.customTableView reloadData];
        [self AdjustTableViewHeight];
        [self->activityControl stopAnimating];
        [self->progressView setHidden:YES];
        
    }];
    
}

-(void)viewWillAppear:(BOOL)animated {

    _customSegmentControl.hidden = NO;

    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat navigationBarHeight = [[[GeneralObject alloc] init] GetNavigationBarHeight:self];
    
    self->_customTableView.frame = CGRectMake(width*0.5 - ((width*0.90338164)*0.5), navigationBarHeight + 8, width*0.90338164, 0);

}

-(void)viewWillDisappear:(BOOL)animated {
    
    _customSegmentControl.hidden = YES;
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    for (NSString *userID in self->_itemAssignedToArray) {
        
        NSUInteger index = [self->_itemAssignedToArray indexOfObject:userID];
        CostPerPersonCell *cell = [self->_customTableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
        [cell.costPerPersonTextField resignFirstResponder];
        
    }
    
}

-(void)viewDidLayoutSubviews {
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    CGFloat bottomPadding = [[[GeneralObject alloc] init] GetBottomPaddingHeight];
    
    UIWindow *currentwindow = [UIApplication sharedApplication].windows.firstObject;
    [currentwindow addSubview:_customSegmentControl];
    
    [self.navigationController.navigationBar addSubview:_customSegmentControl];
    
    _customSegmentControl.frame = CGRectMake(width*0.5 - (((self.view.frame.size.height*0.30193237 > 125?(125):self.view.frame.size.height*0.30193237))*0.5),
                                             self.navigationController.navigationBar.frame.size.height*0.5 - (self.view.frame.size.height*0.04347826 > 32?(32):self.view.frame.size.height*0.04347826)*0.5,
                                                                                                              (self.view.frame.size.height*0.30193237 > 125?(125):self.view.frame.size.height*0.30193237),
                                                                                                              (self.view.frame.size.height*0.04347826 > 32?(32):self.view.frame.size.height*0.04347826));
    _customTableView.layer.cornerRadius = 12;
    
    activityControl.frame = CGRectMake((self.view.frame.size.width*0.5)-(12.5), (self.view.frame.size.height*0.5) - (12.5), 25, 25);
    
    _amountView.frame = CGRectMake(0, height - (self.view.frame.size.height*0.09103261 > 67?(67):self.view.frame.size.height*0.09103261) - bottomPadding, width*1, (self.view.frame.size.height*0.09103261 > 67?(67):self.view.frame.size.height*0.09103261) + bottomPadding);
    
    
    
    
    
    width = CGRectGetWidth(_amountView.bounds);
    height = CGRectGetHeight(_amountView.bounds);
    
    _amountViewTotalAmountLabel.frame = CGRectMake(0, height*0.2537, width, height*0.298507);
    _amountViewAmountLeftLabel.frame = CGRectMake(0, height*0.56716, width, height*0.298507);

    _amountViewTotalAmountLabel.font = [UIFont systemFontOfSize:(_amountView.frame.size.height-bottomPadding)*0.208955 weight:UIFontWeightSemibold];
    _amountViewAmountLeftLabel.font = [UIFont systemFontOfSize:(_amountView.frame.size.height-bottomPadding)*0.17910448 weight:UIFontWeightMedium];
    
    _amountView.layer.borderWidth = 0.0;
    _amountView.layer.shadowColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ?
    [[[LightDarkModeObject alloc] init] DarkModeShadow].CGColor :
    [[[LightDarkModeObject alloc] init] LightModeShadow].CGColor;
    _amountView.layer.shadowRadius = 5;
    _amountView.layer.shadowOpacity = 1.0;
    _amountView.layer.shadowOffset = CGSizeMake(0, 0);
    
    
    
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        self.view.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        self.navigationController.navigationBar.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        self.amountView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeTertiary];
        self.amountViewTotalAmountLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        self.amountViewAmountLeftLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        self.customSegmentControl.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        
        NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [[[LightDarkModeObject alloc] init] DarkModeTextPrimary], NSForegroundColorAttributeName,
                                    nil];
        [_customSegmentControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
        NSDictionary *highlightedAttributes = [NSDictionary dictionaryWithObject:[UIColor blackColor] forKey:NSForegroundColorAttributeName];
        [_customSegmentControl setTitleTextAttributes:highlightedAttributes forState:UIControlStateSelected];
        
        [self preferredStatusBarStyle];
        
    } else {
        
        self.navigationController.navigationBar.backgroundColor = self.view.backgroundColor;
        
    }
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        return UIStatusBarStyleLightContent;
        
    } else {
        
        return UIStatusBarStyleDefault;
        
    }
    
}

#pragma mark - Textfield Methods

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (_viewingItemDetails == YES) {
        return NO;
    }

    if([textField.text length] < 1000000000000){
        
        BOOL Dollar = [_customSegmentControl selectedSegmentIndex] == 0;
        BOOL Percentage = [_customSegmentControl selectedSegmentIndex] == 1;
        
        [self GenerateTextFieldAmount:textField string:string dollar:Dollar percentage:Percentage];

        return NO;
        
    } else {
        
        NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
        [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        textField.text = [currencyFormatter stringFromNumber:@1];
        
        return NO;
        
    }
    
    return YES;
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - Keyboard Methods

- (void)keyboardWillShow: (NSNotification *) notification{
    
    keyboardIsShown = true;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        NSDictionary* keyboardInfo = [notification userInfo];
        NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
        CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
        
        CGRect sendCoinsButton = self->_amountView.frame;

        sendCoinsButton.origin.y = CGRectGetHeight(self.view.bounds)-keyboardFrameBeginRect.size.height-self->_amountView.frame.size.height;
        
        self->_amountView.frame = sendCoinsButton;

    }];
    
}

- (void)keyboardWillHide: (NSNotification *) notification{
    
    keyboardIsShown = false;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        CGFloat width = CGRectGetWidth(self.view.bounds);
        CGFloat height = CGRectGetHeight(self.view.bounds);
        
        CGFloat bottomPadding = [[[GeneralObject alloc] init] GetBottomPaddingHeight];
        
        self->_amountView.frame = CGRectMake(0, height - (self.view.frame.size.height*0.09103261 > 67?(67):self.view.frame.size.height*0.09103261) - bottomPadding, width*1, (self.view.frame.size.height*0.09103261 > 67?(67):self.view.frame.size.height*0.09103261) + bottomPadding);
        
    }];
    
}

#pragma mark - Init Methods

-(void)InitMethod {
    
    [self SetUpLocalCurrencySymbol];
    
    [self SetUpItemAmountView];
    
    [self SetUpItemAmountLabels];
    
    [self SetUpAnalytics];
    
    [self SetUpActivityControl];
    
    [self SetUpArrays];
    
    [self SetUpTotalAmount];
    
    [self SetUpTableView];
    
    [self SetUpCostArray];
    
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
    
    if (_viewingItemDetails == NO && _itemAssignedToArray.count > 0) {
        
        UIBarButtonItem *barButtonItem1 = [[UIBarButtonItem alloc]
                         initWithTitle:@"Reset"
                         style:UIBarButtonItemStyleDone
                         target:self
                         action:@selector(ResetButtonAction:)];
        
        barButtonItem = [[UIBarButtonItem alloc]
                         initWithTitle:@"Save"
                         style:UIBarButtonItemStyleDone
                         target:self
                         action:@selector(SaveButtonAction:)];
        
        if ([[_itemItemizedItemsDict allKeys] count] == 0) {
            
            self.navigationItem.rightBarButtonItems = @[barButtonItem, barButtonItem1];
            
        } else {
            
            self.navigationItem.rightBarButtonItems = @[barButtonItem];
            
        }
        
    }
    
}

-(void)SetUpKeyboardNSNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}

#pragma mark - Setup Methods

-(void)SetUpAnalytics {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewViewController:@"CostPerPersonViewController" completionHandler:^(BOOL finished) {
        
    }];
    
}

-(void)SetUpItemAmountView {
    
    _amountView.hidden = [[_itemItemizedItemsDict allKeys] count] > 0 ? YES : NO;
    
}

-(void)SetUpLocalCurrencySymbol {
    
    localCurrencySymbol = [[[GeneralObject alloc] init] GenerateLocalCurrencySymbol];
    localCurrencyDecimalSeparatorSymbol = [[[GeneralObject alloc] init] GenerateLocalCurrencyDecimalSeparatorSymbol];
    localCurrencyNumberSeparatorSymbol = [[[GeneralObject alloc] init] GenerateLocalCurrencyNumberSeparatorSymbol];
    
}

-(void)SetUpItemAmountLabels {
    
    NSString *itemAmountFromPreviousPageString = [_itemAmountFromPreviousPage mutableCopy];
    itemAmountFromPreviousPageString = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:itemAmountFromPreviousPageString arrayOfSymbols:@[localCurrencyNumberSeparatorSymbol, localCurrencySymbol]];
    
    float totalCostPerPersonAmount = [itemAmountFromPreviousPageString floatValue];
    
    [self GenerateAmountViewTotalAmountText:totalCostPerPersonAmount dollar:YES percentage:NO];

    if (_itemAmountFromPreviousPage == nil || [_itemAmountFromPreviousPage containsString:@"(null)"] || _itemAmountFromPreviousPage.length == 0) {
        _amountViewTotalAmountLabel.text = [NSString stringWithFormat:@"0%@00 of 0%@00", localCurrencyDecimalSeparatorSymbol, localCurrencyDecimalSeparatorSymbol];
    }
    
    _amountViewAmountLeftLabel.text = [NSString stringWithFormat:@"%@0%@00 left", PercentageShown ? @"" : localCurrencySymbol, localCurrencyDecimalSeparatorSymbol];
    
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
    
    [self.view addSubview:activityControl];
    
}

-(void)SetUpArrays {
    
    userDict = [NSMutableDictionary dictionary];
    costPerPersonArray = [NSMutableArray array];
    
}

-(void)SetUpTotalAmount {
    
    if (_itemAmountFromPreviousPage == nil || _itemAmountFromPreviousPage.length == 0) {
        _itemAmountFromPreviousPage = [NSString stringWithFormat:@"0%@00", localCurrencyDecimalSeparatorSymbol];
    }

}

-(void)SetUpTableView {
    
    _customTableView.delegate = self;
    _customTableView.dataSource = self;
    _customScrollView.delegate = self;
}

-(void)SetUpCostArray {
    
    if ([[_costPerPersonDict allKeys] count] == 0 && _itemAssignedToArray.count != 0 && _itemAmountFromPreviousPage != nil) {
        
        NSString *itemAmountFromPreviousPageString = [_itemAmountFromPreviousPage mutableCopy];
        itemAmountFromPreviousPageString = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:itemAmountFromPreviousPageString arrayOfSymbols:@[localCurrencyNumberSeparatorSymbol, localCurrencySymbol]];

        float equalAmountPerPerson = [itemAmountFromPreviousPageString floatValue]/_itemAssignedToArray.count;
        
        for (int i=0;i<_itemAssignedToArray.count;i++) {
            
            [costPerPersonArray addObject:[NSString stringWithFormat:@"%.02f", equalAmountPerPerson]];
            
        }
        
    } else if ([[_costPerPersonDict allKeys] count] != 0) {
        
        for (NSString *key in _costPerPersonDict) {
            
            [costPerPersonArray addObject:_costPerPersonDict[key]];
            
        }
        
    } else {
        
        for (int i=0;i<_itemAssignedToArray.count;i++) {
            
            [costPerPersonArray addObject:[NSString stringWithFormat:@"0%@00", localCurrencyDecimalSeparatorSymbol]];
            
        }
        
    }
    
}

#pragma mark - UI Methods

-(void)StartProgressView {
    
    self->progressView = [MRProgressOverlayView showOverlayAddedTo:self.navigationController.view animated:YES];
    self->progressView.mode = MRProgressOverlayViewModeIndeterminateSmall;
    
}

-(void)AdjustTableViewHeight {
    
    [UIView animateWithDuration:0.25 animations:^{
        
        CGFloat width = CGRectGetWidth(self.view.bounds);
        CGFloat height = CGRectGetHeight(self.view.bounds);
        
        CGFloat navigationBarHeight = [[[GeneralObject alloc] init] GetNavigationBarHeight:self];
        
        CGFloat tableViewHeight = (self.view.frame.size.height*0.14538043 > 115?(115):self.view.frame.size.height*0.14538043)*[(NSArray *)self->userDict[@"UserID"] count];
        
        if (tableViewHeight > height - (navigationBarHeight + 8 + self->_amountView.frame.size.height + 8)) {
            tableViewHeight = height - (navigationBarHeight + 8 + self->_amountView.frame.size.height + 8);
        }
        
        CGFloat scrollViewHeight = self->_customTableView.frame.size.height*2;
        
        if (scrollViewHeight < height + 1) {
            scrollViewHeight = height + 1;
        }
        
        self->_customTableView.frame = CGRectMake(width*0.5 - ((width*0.90338164)*0.5), 0, width*0.90338164, tableViewHeight);
        self->_customScrollView.frame = CGRectMake(0, navigationBarHeight + 8, width, height - navigationBarHeight + 8);
        self->_customScrollView.contentSize = CGSizeMake(width, scrollViewHeight);
        
    }];
    
}

-(NSString *)GenerateTextFieldFormattedText:(NSRange)range replacementString:(NSString *)string {
    
    NSString *textField =[NSString stringWithFormat:@"0%@00", localCurrencyDecimalSeparatorSymbol];
    
    NSString *cleanCentString = [[textField componentsSeparatedByCharactersInSet: [[NSCharacterSet decimalDigitCharacterSet] invertedSet]] componentsJoinedByString:@""];
    NSInteger centValue = [cleanCentString intValue];
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    NSNumber *myNumber = [f numberFromString:cleanCentString];
    NSNumber *result;
    
    if([textField length] < 1000000000000){
        
        if (string.length > 0) {
            
            centValue = centValue * 10 + [string intValue];
            double intermediate = [myNumber doubleValue] * 10 +  [[f numberFromString:string] doubleValue];
            result = [[NSNumber alloc] initWithDouble:intermediate];
            
        } else {
            
            centValue = centValue / 10;
            double intermediate = [myNumber doubleValue]/10;
            result = [[NSNumber alloc] initWithDouble:intermediate];
            
        }
        
        myNumber = result;
        
        NSNumber *formatedValue;
        formatedValue = [[NSNumber alloc] initWithDouble:[myNumber doubleValue]/ 100.0f];
        NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
        currencyFormatter.locale = [NSLocale currentLocale];
        [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        
        NSString *str = textField;
        str = [currencyFormatter stringFromNumber:formatedValue];
        
        str = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:str arrayOfSymbols:@[localCurrencySymbol]];
   
        if ([textField containsString:localCurrencySymbol] == NO) {
            
            textField = [NSString stringWithFormat:@"%@%@", localCurrencySymbol, str];
            
        }
        
        NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
        NSString *trimmedStringItemAmount = [textField stringByTrimmingCharactersInSet:charSet];
        
        return trimmedStringItemAmount;
        
    } else {
        
        NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
        [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        textField = [currencyFormatter stringFromNumber:@1];
        NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
        NSString *trimmedStringItemAmount = [textField stringByTrimmingCharactersInSet:charSet];
        
        return trimmedStringItemAmount;
        
    }
    
}

#pragma mark - UX Methods

-(void)GenerateItemItemizedItemsContextMenu:(NSIndexPath *)indexPath cell:(CostPerPersonCell *)cell {
    
    NSMutableArray* contextMenuItemizedItemsActions = [[NSMutableArray alloc] init];
    
    NSMutableArray* unselectedActions = [[NSMutableArray alloc] init];
    NSMutableArray* selectedActions = [[NSMutableArray alloc] init];
    
    
    
    
    NSMutableArray *unassignedArr = [self GenerateItemizedItemsThatAreUnassigned:indexPath];
    
    for (NSString *itemizedItemName in unassignedArr) {
        
        id amountString = _itemItemizedItemsDict[itemizedItemName][@"Amount"];
        
        BOOL ObjectIsKindOfArrayClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:amountString classArr:@[[NSArray class], [NSMutableArray class]]];
        BOOL ObjectIsKindOfStringClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:amountString classArr:@[[NSString class]]];
        
        if (ObjectIsKindOfArrayClass == YES) {
            amountString = amountString[0];
        } else if (ObjectIsKindOfStringClass == YES) {
            amountString = amountString;
        }
        
        NSString *title = [NSString stringWithFormat:@"%@ - %@", itemizedItemName, amountString];
        
        [unselectedActions addObject:[UIAction actionWithTitle:title image:[UIImage systemImageNamed:@"plus"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
           
            NSMutableDictionary *itemizedDict = [self->_itemItemizedItemsDict mutableCopy];
            NSMutableDictionary *specificItemizedItemDict = [itemizedDict[itemizedItemName] mutableCopy];
            NSMutableArray *assignedTo = [specificItemizedItemDict[@"Assigned To"] mutableCopy];
            
            NSString *userID = self->userDict && self->userDict[@"UserID"] && [(NSArray *)self->userDict[@"UserID"] count] > indexPath.row ? self->userDict[@"UserID"][indexPath.row] : @"";
            
            if ([assignedTo count] > 0) { [assignedTo replaceObjectAtIndex:0 withObject:userID]; }
            [specificItemizedItemDict setObject:assignedTo forKey:@"Assigned To"];
            [itemizedDict setObject:specificItemizedItemDict forKey:itemizedItemName];
           
            self->_itemItemizedItemsDict = [itemizedDict mutableCopy];
            
            [self GenerateItemItemizedItemsContextMenu:indexPath cell:cell];
            
            [self.customTableView reloadData];
            
        }]];
        
    }
    
    
    
    
    NSMutableArray *assignedArr = [self GenerateItemizedItemsThatAreAssigned:indexPath];
    
    for (NSString *itemizedItemName in assignedArr) {
        
        id amountString = _itemItemizedItemsDict[itemizedItemName][@"Amount"];
        
        BOOL ObjectIsKindOfArrayClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:amountString classArr:@[[NSArray class], [NSMutableArray class]]];
        BOOL ObjectIsKindOfStringClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:amountString classArr:@[[NSString class]]];
        
        if (ObjectIsKindOfArrayClass == YES) {
            amountString = amountString[0];
        } else if (ObjectIsKindOfStringClass == YES) {
            amountString = amountString;
        }
        
        NSString *title = [NSString stringWithFormat:@"%@ - %@", itemizedItemName, amountString];
        
        UIAction *unselectedAction = [UIAction actionWithTitle:title image:[[UIImage systemImageNamed:@"minus.circle"] imageWithTintColor:[UIColor systemRedColor] renderingMode:UIImageRenderingModeAlwaysOriginal] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Add Itemized Item %@", itemizedItemName] completionHandler:^(BOOL finished) {
                
            }];
            
            NSMutableDictionary *itemizedDict = [self->_itemItemizedItemsDict mutableCopy];
            NSMutableDictionary *specificItemizedItemDict = [itemizedDict[itemizedItemName] mutableCopy];
            NSMutableArray *assignedTo = [specificItemizedItemDict[@"Assigned To"] mutableCopy];
           
            if ([assignedTo count] > 0) { [assignedTo replaceObjectAtIndex:0 withObject:@"Anybody"]; }
            [specificItemizedItemDict setObject:assignedTo forKey:@"Assigned To"];
            [itemizedDict setObject:specificItemizedItemDict forKey:itemizedItemName];
           
            self->_itemItemizedItemsDict = [itemizedDict mutableCopy];
            
            [self GenerateItemItemizedItemsContextMenu:indexPath cell:cell];
            
            [self.customTableView reloadData];
            
        }];
        
        [unselectedAction setAttributes:UIMenuElementAttributesDestructive];
        
        [selectedActions addObject:unselectedAction];
        
    }
    
    
    
    
    UIMenu *unselectedActionsInlineMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"Unselected" options:UIMenuOptionsDisplayInline children:unselectedActions];
    [contextMenuItemizedItemsActions addObject:unselectedActionsInlineMenu];
    
    UIMenu *selectedActionsInlineMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"Selected" options:UIMenuOptionsDisplayInline children:selectedActions];
    [contextMenuItemizedItemsActions addObject:selectedActionsInlineMenu];
    
    
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        cell.costPerPersonTextFieldViewOverlayView.menu = [UIMenu menuWithTitle:@"" children:@[unselectedActionsInlineMenu, selectedActionsInlineMenu]];
        cell.costPerPersonTextFieldViewOverlayView.showsMenuAsPrimaryAction = true;
        
    });
    
}

#pragma mark - IBAction Methods

-(IBAction)SaveButtonAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Save Button Clicked"] completionHandler:^(BOOL finished) {
        
    }];
  
    BOOL CurrentTotalAmountIsEqualToOriginalAmount = [_amountViewAmountLeftLabel.text isEqualToString:[NSString stringWithFormat:@"%@0%@00 left", PercentageShown ? @"" : localCurrencySymbol, localCurrencyDecimalSeparatorSymbol]] == YES || [_amountViewAmountLeftLabel.text isEqualToString:[NSString stringWithFormat:@"100%@00%% left", localCurrencyDecimalSeparatorSymbol]] == YES || [[_itemItemizedItemsDict allKeys] count] > 0;

    if (CurrentTotalAmountIsEqualToOriginalAmount == YES) {
       
        [self CompleteSaveAction];
        
    } else {
      
        [self GenerateUpdateOriginalAmountAlert];
        
    }
    
}

-(IBAction)ResetButtonAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Reset Button Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    NSString *equalCostPerPerson = [self GenerateEqualCostPerPersonString];
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Would you like to reset all amounts to %@ each?", equalCostPerPerson] message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Reset Amounts" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        [self ResetAmounts];
        
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Reset Button Cancelled"] completionHandler:^(BOOL finished) {
            
        }];
        
    }]];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
    
}

- (IBAction)SegmentControlAction:(id)sender {
    
    BOOL Dollar = [_customSegmentControl selectedSegmentIndex] == 0;
    BOOL Percentage = [_customSegmentControl selectedSegmentIndex] == 1;
    
    PercentageShown = Percentage;
    [self ConvertToOppositeAmountForm:Dollar dollarToPercentage:Percentage];
    
}

-(IBAction)NavigationBackButtonAction:(UIBarButtonItem *)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Navigation Back Button Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - Table View Methods

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    CostPerPersonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CostPerPersonCell"];
    
    
  
    NSString *profileImageURL = userDict[@"ProfileImageURL"][indexPath.row];
    
    UIColor *backgroundColor = [[[GeneralObject alloc] init] GenerateAppColor:0.15f];
    UIColor *textColor = [[[GeneralObject alloc] init] GenerateAppColor:1.0f];
    
    if (profileImageURL == nil || profileImageURL.length == 0 || [profileImageURL containsString:@"(null)"] || [profileImageURL isEqualToString:@"xxx"] || [profileImageURL isEqualToString:@"XXX"] || [profileImageURL isEqualToString:@"https://firebasestorage.googleapis.com/v0/b/wedivvy-afe04.appspot.com/o/DefaultImages%2FdefaultProfileImage.png?alt=media&token=6892f430-8337-4327-89a4-53a403d1186c"] || [profileImageURL containsString:@"DefaultImage"]) {
        
        [cell.userProfileImage setImageWithString:userDict[@"Username"][indexPath.row] color:backgroundColor circular:YES textAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Futura-Medium" size:cell.userProfileImage.frame.size.height*0.45], NSForegroundColorAttributeName:textColor}];
        
    } else {
        
        [cell.userProfileImage sd_setImageWithURL:[NSURL URLWithString:profileImageURL]];
        
    }
    
    
    
    cell.usernameLabel.text = userDict[@"Username"][indexPath.row];
    
    
    
    BOOL CostPerPersonIsItemized = [[_itemItemizedItemsDict allKeys] count] > 0;
  
    cell.costPerPersonTextField.text =
    CostPerPersonIsItemized == YES ?
    [self GenerateItemizedCostPerPersonText:indexPath cell:cell] :
    [NSString stringWithFormat:@"%@%@", userDict[@"Cost"][indexPath.row], PercentageShown ? @"%" : @""];

    
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [(NSArray *)userDict[@"UserID"] count];
    
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(CostPerPersonCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat width = CGRectGetWidth(cell.contentView.bounds);
    CGFloat height = CGRectGetHeight(cell.contentView.bounds);
    
    cell.userProfileImage.frame = CGRectMake(width*0.04830918 > 20?(20):width*0.04830918, height*0.06956522 > 8?(8):height*0.06956522, height*0.260869 > 30?(30):height*0.260869, height*0.260869 > 30?(30):height*0.260869);
    cell.userProfileImage.layer.cornerRadius = cell.userProfileImage.frame.size.height/2;
    cell.usernameLabel.frame = CGRectMake(cell.userProfileImage.frame.origin.x + cell.userProfileImage.frame.size.width + height*0.06956522 > 8?(8):height*0.06956522, height*0.06956522 > 8?(8):height*0.06956522, width - (cell.userProfileImage.frame.origin.x + cell.userProfileImage.frame.size.width + height*0.06956522 > 8?(8):height*0.06956522), 30);
    cell.costPerPersonTextFieldView.frame = CGRectMake(width*0.04830918 > 20?(20):width*0.04830918, cell.userProfileImage.frame.origin.y + cell.userProfileImage.frame.size.height + height*0.104347 > 12?(12):height*0.104347, width - (width*0.04830918 > 20?(20):width*0.04830918)*2, height*0.43478261 > 50?(50):height*0.43478261);
    
    
    
    
    width = CGRectGetWidth(cell.costPerPersonTextFieldView.bounds);
    height = CGRectGetHeight(cell.costPerPersonTextFieldView.bounds);
    
    cell.costPerPersonTextField.frame = CGRectMake(height*0.06956522 > 8?(8):height*0.06956522, height*0.06956522 > 8?(8):height*0.06956522, width - (height*0.06956522 > 8?(8):height*0.06956522)*2, height - (height*0.06956522 > 8?(8):height*0.06956522)*2);
    cell.costPerPersonTextField.delegate = self;
    cell.costPerPersonTextField.userInteractionEnabled = _viewingItemDetails == YES ? NO : YES;
    [[[GeneralObject alloc] init] SetAttributedPlaceholder:cell.costPerPersonTextField color:[UIColor colorWithRed:181.0f/255.0f green:188.0f/255.0f blue:193.0f/255.0f alpha:1.0f]];
    
    cell.costPerPersonTextFieldViewOverlayView.frame = CGRectMake(0, 0, width, height);
    cell.costPerPersonTextFieldViewOverlayView.hidden = [[_itemItemizedItemsDict allKeys] count] > 0 ? NO : YES;
    [cell.costPerPersonTextFieldViewOverlayView setTitle:@"" forState:UIControlStateNormal];
    
    [self GenerateItemItemizedItemsContextMenu:indexPath cell:cell];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.view.frame.size.height*0.14538043 > 115?(115):self.view.frame.size.height*0.14538043;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
    
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Internal Methods
#pragma mark
#pragma mark
#pragma mark -

#pragma mark ViewDidLoad

-(NSMutableDictionary *)GenerateStartingUserDictCostWithSymbols:(NSMutableDictionary *)userDict {
    
    for (NSString *userID in userDict[@"UserID"]) {
        
        NSUInteger index = [userDict[@"UserID"] indexOfObject:userID];
        
        if ([(NSArray *)userDict[@"Cost"] count] > index) {
            
            NSString *cost = userDict[@"Cost"][index];
           
            cost = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:cost arrayOfSymbols:@[localCurrencyDecimalSeparatorSymbol, localCurrencyNumberSeparatorSymbol, localCurrencySymbol]];
           
            cost = [self GenerateTextFieldFormattedText:NSRangeFromString(cost) replacementString:cost];
           
            if (userDict[@"Cost"] && [(NSArray *)userDict[@"Cost"] count] > index) { [userDict[@"Cost"] replaceObjectAtIndex:index withObject:cost]; }
            
        }
        
    }
    
    return userDict;
    
}


#pragma mark - TextField Methods

-(void)GenerateTextFieldAmount:(UITextField *)textField string:(NSString *)string dollar:(BOOL)dollar percentage:(BOOL)percentage {
    
    NSString *cleanCentString = [[textField.text componentsSeparatedByCharactersInSet: [[NSCharacterSet decimalDigitCharacterSet] invertedSet]] componentsJoinedByString:@""];
    NSInteger centValue = [cleanCentString intValue];
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    NSNumber *myNumber = [f numberFromString:cleanCentString];
    NSNumber *result;
    
    
    
    
    if (string.length > 0) {
        
        centValue = centValue * 10 + [string intValue];
        double intermediate = [myNumber doubleValue] * 10 +  [[f numberFromString:string] doubleValue];
        result = [[NSNumber alloc] initWithDouble:intermediate];
        
    } else {
        
        centValue = centValue / 10;
        double intermediate = [myNumber doubleValue]/10;
        result = [[NSNumber alloc] initWithDouble:intermediate];
        
    }
    
    myNumber = result;
    
    
    
    
    NSNumber *formatedValue;
    formatedValue = [[NSNumber alloc] initWithDouble:[myNumber doubleValue]/ 100.0f];
    
    NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
    currencyFormatter.locale = [NSLocale currentLocale];
    [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    
    
    
    textField.text = [NSString stringWithFormat:@"%@%@%@", PercentageShown ? @"" : localCurrencySymbol, [self GenerateAmountWithoutCurrencySymbol:textField.text currencyFormatter:currencyFormatter formatedValue:formatedValue], PercentageShown ? @"%" : @""];
    
    
    
    
    float totalCostPerPersonAmount = [self GenerateTotalAmountFromAllUserTextFields];
  
    [self GenerateAmountViewTotalAmountText:totalCostPerPersonAmount dollar:dollar percentage:percentage];
    
    [self GenerateAmountViewAmountLeftLabel:totalCostPerPersonAmount dollar:dollar percentage:percentage];
    
}

#pragma mark - CompleteSaveAction

-(void)CompleteSaveAction {
    
    if (self->_costPerPersonDict == nil) {
        self->_costPerPersonDict = [NSMutableDictionary dictionary];
    }
    
    
    
    self->_costPerPersonDict = [self GenerateDictWithCurrentTextFieldAmounts];
    
    
    
    NSMutableDictionary *dictToUse = ([[_itemItemizedItemsDict allKeys] count] > 0) ? _itemItemizedItemsDict : _costPerPersonDict;
   
    [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemCostPerPerson" userInfo:@{@"CostDict" : dictToUse} locations:@[@"Tasks", @"AddTask"]];
    
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)GenerateUpdateOriginalAmountAlert {
    
    NSString *message = [self GenerateDifferentAmountAlertMessage];
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Oops!"
                                                                        message:message
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *gotit = [UIAlertAction actionWithTitle:@"Update Original Amount"
                                                    style:UIAlertActionStyleDefault
                                                  handler:^(UIAlertAction * _Nonnull action) {
        
        [self CompleteSaveAction];
        
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction * _Nonnull action) {}];
    
    [controller addAction:cancel];
    [controller addAction:gotit];
    [self presentViewController:controller animated:YES completion:nil];
    
}

-(NSMutableDictionary *)GenerateDictWithCurrentTextFieldAmounts {
    
    NSMutableDictionary *costPerPersonDictLocal = [NSMutableDictionary dictionary];
    
    for (int i=0; i<[(NSArray *)userDict[@"UserID"] count]; i++) {
        
        CostPerPersonCell *cell = [self->_customTableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        
        NSString *costPerPersonText = cell.costPerPersonTextField.text;
        
        BOOL CostPerPersonTextIsValid = (costPerPersonText != nil && [costPerPersonText containsString:@"(null)"] == NO);
        
        if (CostPerPersonTextIsValid == YES && PercentageShown == YES) {
            
            costPerPersonText = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:costPerPersonText arrayOfSymbols:@[@"%", localCurrencySymbol]];
            
            NSString *itemAmountFromPreviousPageString = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:self->_itemAmountFromPreviousPage arrayOfSymbols:@[localCurrencyNumberSeparatorSymbol, localCurrencySymbol]];
            
            float costPerPersonTextPercentageOfTotal = (([costPerPersonText doubleValue]/100) * [itemAmountFromPreviousPageString doubleValue]);
            
            costPerPersonText = [NSString stringWithFormat:@"%.2f", costPerPersonTextPercentageOfTotal];
            
        }
        
        NSString *userID = userDict[@"UserID"] && [(NSArray *)userDict[@"UserID"] count] > i ? userDict[@"UserID"][i] : @"";
        if (costPerPersonText == nil || costPerPersonText == NULL) { costPerPersonText = @""; }
        
        [costPerPersonDictLocal setObject:costPerPersonText forKey:userID];
        
    }
    
    return costPerPersonDictLocal;
}

#pragma mark - SegmentControlAction

-(void)ConvertToOppositeAmountForm:(BOOL)percentageToDollar dollarToPercentage:(BOOL)dollarToPercentage {
    
    [self ConvertTextFields:percentageToDollar dollarToPercentage:dollarToPercentage];
    
    float totalCostPerPersonAmount = [self GenerateTotalAmountFromAllUserTextFields];
    
    BOOL percentage = dollarToPercentage;
    BOOL dollar = percentageToDollar;
    
    [self GenerateAmountViewTotalAmountText:totalCostPerPersonAmount dollar:dollar percentage:percentage];
  
    [self GenerateAmountViewAmountLeftLabel:totalCostPerPersonAmount dollar:dollar percentage:percentage];
    
}

#pragma mark - ResetButtonAction

-(NSString *)GenerateEqualCostPerPersonString {
    
    NSString *itemAmountFromPreviousPageString = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:self->_itemAmountFromPreviousPage arrayOfSymbols:@[localCurrencyNumberSeparatorSymbol, localCurrencySymbol]];
    itemAmountFromPreviousPageString = [[[GeneralObject alloc] init] GenerateLocalCurrencyStringWithReverseSeparatorsForeign:itemAmountFromPreviousPageString];
    
    double equalCostPerPerson = 0.0;
    
    if ([self->_customSegmentControl selectedSegmentIndex] == 0) {
        
        equalCostPerPerson =
        [itemAmountFromPreviousPageString doubleValue]/
        [(NSArray *)userDict[@"Username"] count];
        
    } else if ([self->_customSegmentControl selectedSegmentIndex] == 1) {
        
        equalCostPerPerson =
        100.00/
        [(NSArray *)userDict[@"Username"] count];
        
    }
    
    NSString *equalCostPerPersonString = [NSString stringWithFormat:@"%.02f", equalCostPerPerson];
    
    equalCostPerPersonString = [[[GeneralObject alloc] init] GenerateLocalCurrencyStringWithReverseSeparatorsForeign:equalCostPerPersonString];
    equalCostPerPersonString = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:equalCostPerPersonString arrayOfSymbols:@[localCurrencyDecimalSeparatorSymbol]];
    equalCostPerPersonString = [[[GeneralObject alloc] init] GenerateAmountInTextFieldInProperFormat:NSRangeFromString(equalCostPerPersonString) replacementString:equalCostPerPersonString];
    
    equalCostPerPersonString = [NSString stringWithFormat:@"%@%@", equalCostPerPersonString, PercentageShown == YES ? @"%" : @""];
   
    return equalCostPerPersonString;
}

-(void)ResetAmounts {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Reset Amounts Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    [self GenerateTextFieldsWithOriginalDict];
    
    float totalCostPerPersonAmount = [self GenerateTotalAmountFromAllUserTextFields];
    
    BOOL dollar = self->PercentageShown == NO;
    BOOL percentage = self->PercentageShown == YES;
    
    [self GenerateAmountViewTotalAmountText:totalCostPerPersonAmount dollar:dollar percentage:percentage];
    
    [self GenerateAmountViewAmountLeftLabel:totalCostPerPersonAmount dollar:dollar percentage:percentage];
    
}

#pragma mark - AddItemizedItems

-(NSMutableArray *)GenerateItemizedItemsThatAreAssigned:(NSIndexPath *)indexPath {
    
    NSMutableArray *assignedArr = [NSMutableArray array];
    
    for (NSString *key in [_itemItemizedItemsDict allKeys]) {
        
        NSArray *assignedTo = _itemItemizedItemsDict[key][@"Assigned To"];
        
        NSString *userID = self->userDict && self->userDict[@"UserID"] && [(NSArray *)self->userDict[@"UserID"] count] > indexPath.row ? userDict[@"UserID"][indexPath.row] : @"";
        
        BOOL ItemIsAssignedToSpecificUser = [assignedTo[0] isEqualToString:userID];
        
        if (ItemIsAssignedToSpecificUser == YES) {
            
            NSString *itemAndAmount = [NSString stringWithFormat:@"%@", key];
            [assignedArr addObject:itemAndAmount];
            
        }
        
    }
    
    return assignedArr;
}

-(NSMutableArray *)GenerateItemizedItemsThatAreUnassigned:(NSIndexPath *)indexPath {
    
    NSMutableArray *unassignedArr = [NSMutableArray array];
    
    for (NSString *key in [_itemItemizedItemsDict allKeys]) {
        
        NSArray *assignedTo = _itemItemizedItemsDict[key][@"Assigned To"];
        
        BOOL ItemIsAssignedToAnybody = [assignedTo[0] isEqualToString:@"Anybody"];
        
        if (ItemIsAssignedToAnybody == YES) {
            
            NSString *itemAndAmount = [NSString stringWithFormat:@"%@", key];
            [unassignedArr addObject:itemAndAmount];
            
        }
        
    }
    
    return unassignedArr;
}

-(void)GenerateUnassignedItemizedItemActions:(UIAlertController *)actionSheet unassignedArr:(NSMutableArray *)unassignedArr indexPath:(NSIndexPath *)indexPath {
    
    for (NSString *itemizedItemName in unassignedArr) {
        
        id amountString = _itemItemizedItemsDict[itemizedItemName][@"Amount"];
        
        BOOL ObjectIsKindOfArrayClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:amountString classArr:@[[NSArray class], [NSMutableArray class]]];
        BOOL ObjectIsKindOfStringClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:amountString classArr:@[[NSString class]]];
        
        if (ObjectIsKindOfArrayClass == YES) {
            amountString = amountString[0];
        } else if (ObjectIsKindOfStringClass == YES) {
            amountString = amountString;
        }
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:[NSString stringWithFormat:@"%@ - %@", itemizedItemName, amountString] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            NSMutableDictionary *itemizedDict = [self->_itemItemizedItemsDict mutableCopy];
            NSMutableDictionary *specificItemizedItemDict = [itemizedDict[itemizedItemName] mutableCopy];
            NSMutableArray *assignedTo = [specificItemizedItemDict[@"Assigned To"] mutableCopy];
            
            NSString *userID = self->userDict && self->userDict[@"UserID"] && [(NSArray *)self->userDict[@"UserID"] count] > indexPath.row ? self->userDict[@"UserID"][indexPath.row] : @"";
            
            if ([assignedTo count] > 0) { [assignedTo replaceObjectAtIndex:0 withObject:userID]; }
            [specificItemizedItemDict setObject:assignedTo forKey:@"Assigned To"];
            [itemizedDict setObject:specificItemizedItemDict forKey:itemizedItemName];
            
            self->_itemItemizedItemsDict = [itemizedDict mutableCopy];
            
            [self.customTableView reloadData];
            
        }]];
        
    }
    
}

-(void)GenerateAssignedItemizedItemActions:(UIAlertController *)actionSheet assignedArr:(NSMutableArray *)assignedArr indexPath:(NSIndexPath *)indexPath {
    
    for (NSString *itemizedItemName in assignedArr) {
        
        id amountString = _itemItemizedItemsDict[itemizedItemName][@"Amount"];
        
        BOOL ObjectIsKindOfArrayClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:amountString classArr:@[[NSArray class], [NSMutableArray class]]];
        BOOL ObjectIsKindOfStringClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:amountString classArr:@[[NSString class]]];
        
        if (ObjectIsKindOfArrayClass == YES) {
            amountString = amountString[0];
        } else if (ObjectIsKindOfStringClass == YES) {
            amountString = amountString;
        }
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:[NSString stringWithFormat:@"%@ - %@", itemizedItemName, amountString] style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Add Itemized Item %@", itemizedItemName] completionHandler:^(BOOL finished) {
                
            }];
            
            NSMutableDictionary *itemizedDict = [self->_itemItemizedItemsDict mutableCopy];
            NSMutableDictionary *specificItemizedItemDict = [itemizedDict[itemizedItemName] mutableCopy];
            NSMutableArray *assignedTo = [specificItemizedItemDict[@"Assigned To"] mutableCopy];
            
            if ([assignedTo count] > 0) { [assignedTo replaceObjectAtIndex:0 withObject:@"Anybody"]; }
            [specificItemizedItemDict setObject:assignedTo forKey:@"Assigned To"];
            [itemizedDict setObject:specificItemizedItemDict forKey:itemizedItemName];
            
            self->_itemItemizedItemsDict = [itemizedDict mutableCopy];
            
            [self.customTableView reloadData];
            
        }]];
        
    }
    
}

#pragma mark - Amount View

-(void)GenerateAmountViewAmountLeftLabel:(float)totalCostPerPersonAmount dollar:(BOOL)dollar percentage:(BOOL)percentage {
    
    NSString *totalCostPerPersonAmountString = [NSString stringWithFormat:@"%.2f", totalCostPerPersonAmount];
    NSString *itemAmountFromPreviousPageString = percentage == YES ? [NSString stringWithFormat:@"100%@00%%", localCurrencyDecimalSeparatorSymbol] : [_itemAmountFromPreviousPage mutableCopy];
    
    
    
    totalCostPerPersonAmountString = [[[GeneralObject alloc] init] GenerateLocalCurrencyStringWithReverseSeparatorsForeign:totalCostPerPersonAmountString];
    
    
    
    totalCostPerPersonAmountString = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:totalCostPerPersonAmountString arrayOfSymbols:@[localCurrencyNumberSeparatorSymbol, @"%", localCurrencySymbol]];
    itemAmountFromPreviousPageString = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:itemAmountFromPreviousPageString arrayOfSymbols:@[localCurrencyNumberSeparatorSymbol, @"%", localCurrencySymbol]];
    
   
    
    totalCostPerPersonAmountString = [[[GeneralObject alloc] init] GenerateLocalCurrencyStringWithReverseSeparatorsForeign:totalCostPerPersonAmountString];
    itemAmountFromPreviousPageString = [[[GeneralObject alloc] init] GenerateLocalCurrencyStringWithReverseSeparatorsForeign:itemAmountFromPreviousPageString];
    
   
    
    double difference = [itemAmountFromPreviousPageString doubleValue] - [totalCostPerPersonAmountString doubleValue];
    
    
    
    NSNumber *formatedValue = [[NSNumber alloc] initWithDouble:difference];
    
    NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
    currencyFormatter.locale = [NSLocale currentLocale];
    [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    
    
    NSString *formattedAmountString = [NSString stringWithFormat:@"%@", formatedValue];
   
    NSString *amountWithoutCurrencySymbol = [self GenerateAmountWithoutCurrencySymbol:formattedAmountString currencyFormatter:currencyFormatter formatedValue:formatedValue];
    
    if ([amountWithoutCurrencySymbol isEqualToString:[NSString stringWithFormat:@"0%@01", localCurrencyDecimalSeparatorSymbol]] && percentage == YES) { amountWithoutCurrencySymbol = [NSString stringWithFormat:@"0%@00", localCurrencyDecimalSeparatorSymbol]; }
    
    NSString *amountLeft = [NSString stringWithFormat:@"%@%@%@ left", percentage ? @"" : localCurrencySymbol, amountWithoutCurrencySymbol, percentage == YES ? @"%" : @""];
    
    
    
    _amountViewAmountLeftLabel.text = amountLeft;
    
    [self GenerateAmountViewAmountLeftTextColor:totalCostPerPersonAmount dollar:dollar percentage:percentage];
    
}


-(void)GenerateAmountViewAmountLeftTextColor:(float)totalCostPerPersonAmount dollar:(BOOL)dollar percentage:(BOOL)percentage {
    
    NSString *totalCostPerPersonAmountString = [NSString stringWithFormat:@"%.2f", totalCostPerPersonAmount];
    NSString *itemAmountFromPreviousPageString = percentage == YES ? [NSString stringWithFormat:@"100%@00%%", localCurrencyDecimalSeparatorSymbol] : [_itemAmountFromPreviousPage mutableCopy];
    
    
    
    totalCostPerPersonAmountString = [[[GeneralObject alloc] init] GenerateLocalCurrencyStringWithReverseSeparatorsForeign:totalCostPerPersonAmountString];
    
    
    
    totalCostPerPersonAmountString = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:totalCostPerPersonAmountString arrayOfSymbols:@[localCurrencyNumberSeparatorSymbol, @"%", localCurrencySymbol]];
    itemAmountFromPreviousPageString = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:itemAmountFromPreviousPageString arrayOfSymbols:@[localCurrencyNumberSeparatorSymbol, @"%", localCurrencySymbol]];
    
    
    
    totalCostPerPersonAmountString = [[[GeneralObject alloc] init] GenerateLocalCurrencyStringWithReverseSeparatorsForeign:totalCostPerPersonAmountString];
    itemAmountFromPreviousPageString = [[[GeneralObject alloc] init] GenerateLocalCurrencyStringWithReverseSeparatorsForeign:itemAmountFromPreviousPageString];
    
    
    
    UIColor *textColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTextPrimary] : [[[LightDarkModeObject alloc] init] LightModeTextPrimary];
    
    if ([totalCostPerPersonAmountString floatValue] > [itemAmountFromPreviousPageString floatValue]) {
        
        textColor = [UIColor colorWithRed:161.0f/255.0f green:60.0f/255.0f blue:79.0f/255.0f alpha:1.0f];
        
    }
    
    
    
    _amountViewAmountLeftLabel.textColor = textColor;
    
}

#pragma mark - Amount Total

-(float)GenerateTotalAmountFromAllUserTextFields {
    
    float totalCostPerPersonAmount = 0.0;
    
    for (NSString *userID in self->_itemAssignedToArray) {
        
        NSUInteger index = [self->_itemAssignedToArray indexOfObject:userID];
        CostPerPersonCell *cell = [self->_customTableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
        
        NSString *currentAmount = cell.costPerPersonTextField.text;
      
        currentAmount = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:currentAmount arrayOfSymbols:@[localCurrencyNumberSeparatorSymbol, @"%", localCurrencySymbol]];
        currentAmount = [[[GeneralObject alloc] init] GenerateLocalCurrencyStringWithReverseSeparatorsForeign:currentAmount];
      
        totalCostPerPersonAmount += [currentAmount floatValue];

    }
   
    return totalCostPerPersonAmount;
}

-(void)GenerateAmountViewTotalAmountText:(float)firstAmount dollar:(BOOL)dollar percentage:(BOOL)percentage {
    
    NSString *totalAmount = @"";
    
    if (dollar) {
        
        totalAmount = _itemAmountFromPreviousPage;
        
    } else if (percentage) {
        
        totalAmount = [NSString stringWithFormat:@"100%@00%%", localCurrencyDecimalSeparatorSymbol];
        
    }
   
    NSString *firstAmountString = [NSString stringWithFormat:@"%.2f", firstAmount];
    
    firstAmountString = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:firstAmountString arrayOfSymbols:@[localCurrencyDecimalSeparatorSymbol, localCurrencyNumberSeparatorSymbol, localCurrencySymbol]];
    firstAmountString = [self GenerateTextFieldFormattedText:NSRangeFromString(firstAmountString) replacementString:firstAmountString];
    
    if (percentage == YES) {
        firstAmountString = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:firstAmountString arrayOfSymbols:@[localCurrencySymbol]];
        if ([firstAmountString isEqualToString:[NSString stringWithFormat:@"99%@99", localCurrencyDecimalSeparatorSymbol]]) { firstAmountString = [NSString stringWithFormat:@"100%@00", localCurrencyDecimalSeparatorSymbol]; }
    }
    
    NSString *totalAmountText = [NSString stringWithFormat:@"%@%@ of %@", firstAmountString, percentage == YES ? @"%" : @"", totalAmount];
  
    _amountViewTotalAmountLabel.text = totalAmountText;
    
}

#pragma mark - Formating Text

-(NSString *)GenerateAmountWithoutCurrencySymbol:(NSString *)text currencyFormatter:(NSNumberFormatter *)currencyFormatter formatedValue:(NSNumber *)formatedValue {
    
    NSString *costTextFieldText = text;
    costTextFieldText = [currencyFormatter stringFromNumber:formatedValue];
    costTextFieldText = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:costTextFieldText arrayOfSymbols:@[localCurrencySymbol]];
    
    return costTextFieldText;
    
}

-(NSString *)GenerateDifferentAmountAlertMessage {
    
    NSString *costPerPersonNewTotalAmount = [_amountViewTotalAmountLabel.text componentsSeparatedByString:@" of "][0];
    
    if ([costPerPersonNewTotalAmount containsString:@"%"]) {
        
        NSString *itemAmountFromPreviousPageString = [_itemAmountFromPreviousPage mutableCopy];
        itemAmountFromPreviousPageString = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:_itemAmountFromPreviousPage arrayOfSymbols:@[localCurrencyNumberSeparatorSymbol, localCurrencySymbol]];
        
        costPerPersonNewTotalAmount = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:costPerPersonNewTotalAmount arrayOfSymbols:@[localCurrencyNumberSeparatorSymbol, @"%", localCurrencySymbol]];
        
        double costPerPersonPercentage = 0.0;
        
        costPerPersonPercentage = (([costPerPersonNewTotalAmount doubleValue]/100) * [itemAmountFromPreviousPageString doubleValue]);
        
        costPerPersonNewTotalAmount = [NSString stringWithFormat:@"%.2f", costPerPersonPercentage];
        
        costPerPersonNewTotalAmount = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:costPerPersonNewTotalAmount arrayOfSymbols:@[localCurrencyDecimalSeparatorSymbol, localCurrencyNumberSeparatorSymbol, localCurrencySymbol]];
        costPerPersonNewTotalAmount = [self GenerateTextFieldFormattedText:NSRangeFromString(costPerPersonNewTotalAmount) replacementString:costPerPersonNewTotalAmount];
        
    }
    
    BOOL AmountLeftIsNegative = [_amountViewAmountLeftLabel.text containsString:@"-"];
    
    NSString *message =
    [NSString stringWithFormat:
     @"The amount of all assigned members is %@ than your original amount, would you like to update your original amount to %@?",
     AmountLeftIsNegative == YES ? @"greater" : @"less",
     costPerPersonNewTotalAmount];
    
    return message;
}

-(void)ConvertTextFields:(BOOL)percentageToDollar dollarToPercentage:(BOOL)dollarToPercentage {
    
    NSString *itemAmountFromPreviousPageString = [_itemAmountFromPreviousPage mutableCopy];
    itemAmountFromPreviousPageString = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:_itemAmountFromPreviousPage arrayOfSymbols:@[localCurrencyNumberSeparatorSymbol, localCurrencySymbol]];
   
    NSMutableArray *userDictCostArrayCopy = [userDict[@"Cost"] mutableCopy];
    
    for (int i=0; i<[(NSArray *)userDict[@"UserID"] count]; i++) {
        
        CostPerPersonCell *cell = [self->_customTableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        
        NSString *costPerPersonText = cell.costPerPersonTextField.text;
        
        if ([costPerPersonText containsString:@" - "]) {
            costPerPersonText = [costPerPersonText componentsSeparatedByString:@" - "][0];
        }
        
        NSString *costPerPersonAmountString = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:costPerPersonText arrayOfSymbols:@[localCurrencyNumberSeparatorSymbol, @"%", localCurrencySymbol]];
       
        double costPerPersonPercentage = 0.00;
        
        if (percentageToDollar == YES) {
            
            costPerPersonPercentage = (([costPerPersonAmountString doubleValue]/100) * [itemAmountFromPreviousPageString doubleValue]);
            
        } else if (dollarToPercentage == YES) {
           
            costPerPersonPercentage = ([costPerPersonAmountString doubleValue] / [itemAmountFromPreviousPageString doubleValue]) * 100;
       
        }
       
        if ([[NSString stringWithFormat:@"%.2f", costPerPersonPercentage] containsString:@"nan"]) {
            costPerPersonPercentage = 0.00;
        }
        
        NSString *costPerPersonPercentageString = [NSString stringWithFormat:@"%.2f", costPerPersonPercentage];
        
        costPerPersonPercentageString = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:costPerPersonPercentageString arrayOfSymbols:@[localCurrencyDecimalSeparatorSymbol, localCurrencyNumberSeparatorSymbol, localCurrencySymbol]];
        costPerPersonPercentageString = [self GenerateTextFieldFormattedText:NSRangeFromString(costPerPersonPercentageString) replacementString:costPerPersonPercentageString];
       
        if (dollarToPercentage == YES) {
            costPerPersonPercentageString = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:costPerPersonPercentageString arrayOfSymbols:@[localCurrencySymbol]];
        }
       
        cell.costPerPersonTextField.text = costPerPersonPercentageString;
        
        if ([userDictCostArrayCopy count] > i) { [userDictCostArrayCopy replaceObjectAtIndex:i withObject:costPerPersonPercentageString]; }
        
    }
   
    [userDict setObject:userDictCostArrayCopy forKey:@"Cost"];
   
    [self.customTableView reloadData];
    
}

#pragma mark - TableView Methods

-(NSString *)GenerateItemizedCostPerPersonText:(NSIndexPath *)indexPath cell:(CostPerPersonCell *)cell {
    
    NSString *costPerPersonText = @"";
    
    NSString *itemizedItemsAssignedToSpecificUser = @"";
    float totalAmountForAllItemizedItemsAssignedToSpecificUser = 0;
    
    NSMutableArray *itemizedDictCopy = [[_itemItemizedItemsDict allKeys] mutableCopy];
    NSMutableArray *addedItemizedItems = [NSMutableArray array];
    
    
    
    //Generate String WIth All Items Assigned To Each User
    for (NSString *itemizedItemName in [_itemItemizedItemsDict allKeys]) {
        
        NSArray *assignedTo = _itemItemizedItemsDict[itemizedItemName][@"Assigned To"];
        
        BOOL ItemIsAssignedToAnybody = [assignedTo[0] isEqualToString:@"Anybody"];
        
        if (ItemIsAssignedToAnybody == NO) {
           
            NSUInteger index = [[_itemItemizedItemsDict allKeys] indexOfObject:itemizedItemName];
            
            NSString *userID = userDict[@"UserID"][indexPath.row];
            
            BOOL ItemAssignedToUser = [assignedTo[0] isEqualToString:userID];
            BOOL ItemHasBeenLoopedThrough = [itemizedDictCopy[index] isEqualToString:@"xxx"];
            
            if (ItemAssignedToUser == YES && ItemHasBeenLoopedThrough == NO) {
                
                NSString *itemAmountString = @"";
                id itemAmountArray = _itemItemizedItemsDict[itemizedItemName][@"Amount"];
                
                BOOL ObjectIsKindOfArrayClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:itemAmountArray classArr:@[[NSArray class], [NSMutableArray class]]];
                BOOL ObjectIsKindOfStringClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:itemAmountArray classArr:@[[NSString class]]];
                
                if (ObjectIsKindOfArrayClass == YES) {
                    itemAmountString = itemAmountArray[0];
                } else if (ObjectIsKindOfStringClass == YES) {
                    itemAmountString = itemAmountArray;
                }
               
                itemAmountString = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:itemAmountString arrayOfSymbols:@[localCurrencyNumberSeparatorSymbol, localCurrencySymbol]];
                itemAmountString = [[[GeneralObject alloc] init] GenerateLocalCurrencyStringWithReverseSeparatorsForeign:itemAmountString];
                
                totalAmountForAllItemizedItemsAssignedToSpecificUser += [itemAmountString floatValue];
               
                if ([itemizedDictCopy count] > index) { [itemizedDictCopy replaceObjectAtIndex:index withObject:@"xxx"]; }
               
                itemizedItemsAssignedToSpecificUser = [itemizedItemsAssignedToSpecificUser length] == 0 ?
                [NSString stringWithFormat:@"%@", itemizedItemName] :
                [NSString stringWithFormat:@"%@, %@", itemizedItemsAssignedToSpecificUser, itemizedItemName];
                
                [addedItemizedItems addObject:itemizedItemName];
                
            }
            
        }
        
    }
    
    
    
    //Convert Total Amount For Each User To Readable String
    NSString *totalAmountForAllItemizedItemsAssignedToSpecificUserString = [NSString stringWithFormat:@"%.2f", totalAmountForAllItemizedItemsAssignedToSpecificUser];
   
    totalAmountForAllItemizedItemsAssignedToSpecificUserString = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:totalAmountForAllItemizedItemsAssignedToSpecificUserString arrayOfSymbols:@[localCurrencyDecimalSeparatorSymbol, localCurrencyNumberSeparatorSymbol, localCurrencySymbol]];
    totalAmountForAllItemizedItemsAssignedToSpecificUserString = [self GenerateTextFieldFormattedText:NSRangeFromString(totalAmountForAllItemizedItemsAssignedToSpecificUserString) replacementString:totalAmountForAllItemizedItemsAssignedToSpecificUserString];
    
   
    
    //Convert Amount For Each User To Percentage
    if (PercentageShown == YES) {
        
        float totalItemAmount = 0.0;
       
        for (NSString *itemName in [_itemItemizedItemsDict allKeys]) {
            
            NSString *itemAmountStringNo1 = @"";
            id itemAmountArray = _itemItemizedItemsDict[itemName][@"Amount"];
           
            BOOL ObjectIsKindOfArrayClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:itemAmountArray classArr:@[[NSArray class], [NSMutableArray class]]];
            BOOL ObjectIsKindOfStringClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:itemAmountArray classArr:@[[NSString class]]];
            
            if (ObjectIsKindOfArrayClass == YES) {
                itemAmountStringNo1 = itemAmountArray[0];
            } else if (ObjectIsKindOfStringClass == YES) {
                itemAmountStringNo1 = itemAmountArray;
            }
           
            itemAmountStringNo1 = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:itemAmountStringNo1 arrayOfSymbols:@[localCurrencyNumberSeparatorSymbol, localCurrencySymbol]];
           
            totalItemAmount += [itemAmountStringNo1 floatValue];
            
            //Remove Only Symbol
            totalAmountForAllItemizedItemsAssignedToSpecificUserString = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:totalAmountForAllItemizedItemsAssignedToSpecificUserString arrayOfSymbols:@[localCurrencyNumberSeparatorSymbol, localCurrencySymbol]];
            
        }
        
        double newAmount = ([totalAmountForAllItemizedItemsAssignedToSpecificUserString doubleValue] / totalItemAmount) * 100;
        totalAmountForAllItemizedItemsAssignedToSpecificUserString = [NSString stringWithFormat:@"%.2f%%", newAmount];
       
        if ([totalAmountForAllItemizedItemsAssignedToSpecificUserString containsString:@"nan"]) {
            totalAmountForAllItemizedItemsAssignedToSpecificUserString = [NSString stringWithFormat:@"0%@00%%", localCurrencyDecimalSeparatorSymbol];
        }
   
    }
    
  
    
    //E.g. 10.00 - Item1, Item2, Item3
    costPerPersonText = [NSString stringWithFormat:@"%@ - %@", totalAmountForAllItemizedItemsAssignedToSpecificUserString, itemizedItemsAssignedToSpecificUser];
    
    return costPerPersonText;
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Sub-Internal Methods
#pragma mark
#pragma mark
#pragma mark -

#pragma mark ResetButtonAction

-(void)GenerateTextFieldsWithOriginalDict {
    
    NSMutableArray *userDictCostArrayCopy = [userDict[@"Cost"] mutableCopy];
    
    for (int i=0; i<[(NSArray *)userDict[@"UserID"] count]; i++) {
        
        CostPerPersonCell *cell = [self->_customTableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        
        NSString *costPerPersonText = userDict[@"Cost"][i];
        
        NSString *costPerPersonAmountString = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:costPerPersonText arrayOfSymbols:@[localCurrencyNumberSeparatorSymbol, @"%", localCurrencySymbol]];
        
        if (PercentageShown == NO) {
            
            costPerPersonAmountString = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:costPerPersonAmountString arrayOfSymbols:@[localCurrencyDecimalSeparatorSymbol, localCurrencyNumberSeparatorSymbol, localCurrencySymbol]];
            costPerPersonAmountString = [self GenerateTextFieldFormattedText:NSRangeFromString(costPerPersonAmountString) replacementString:costPerPersonAmountString];
            
        } else {
            
            float equalCostPersonPercentage = 100/[(NSArray *)userDict[@"UserID"] count];
            costPerPersonAmountString = [NSString stringWithFormat:@"%.2f", equalCostPersonPercentage];
            
        }
        
        cell.costPerPersonTextField.text = costPerPersonAmountString;
        if ([userDictCostArrayCopy count] > i) { [userDictCostArrayCopy replaceObjectAtIndex:i withObject:costPerPersonAmountString]; }
        
    }
    
    [userDict setObject:userDictCostArrayCopy forKey:@"Cost"];
    
    [self.customTableView reloadData];
    
}

@end
