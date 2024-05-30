//
//  ViewListViewItemsViewController.m
//  WeDivvy
//
//  Created by Philip Nagel on 2/25/23.
//

#import "AppDelegate.h"
#import "ViewRemindersViewController.h"
#import "OptionsCell.h"

#import "GeneralObject.h"
#import "GetDataObject.h"
#import "SetDataObject.h"
#import "BoolDataObject.h"
#import "PushObject.h"
#import "LightDarkModeObject.h"

@interface ViewRemindersViewController () {
    
    NSMutableDictionary *homeMembersDict;
    
    NSString *reminderAmountComp;
    NSString *reminderFrequencyComp;
    
    NSMutableArray *frequencyReminderAmountArray;
    NSMutableArray *frequencyReminderFrequencyArray;
    
    NSMutableDictionary *premiumPlanPricesDict;
    NSMutableDictionary *premiumPlanExpensivePricesDict;
    NSMutableDictionary *premiumPlanPricesDiscountDict;
    NSMutableDictionary *premiumPlanPricesNoFreeTrialDict;
    NSMutableArray *premiumPlanProductsArray;
    
}

@end

@implementation ViewRemindersViewController

#pragma mark - System Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self InitMethod];

    [self BarButtonItems];
    
    [self.customTableView reloadData];
    
}

-(void)viewDidLayoutSubviews {
    
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    CGFloat navigationBarHeight = [[[GeneralObject alloc] init] GetNavigationBarHeight:self];
 
    _firstFieldView.frame = CGRectMake(width*0.5 - ((width*0.90338164)*0.5), navigationBarHeight + 12, (width*0.90338164), (self.view.frame.size.height*0.067934 > 50?(50):self.view.frame.size.height*0.067934));
    _firstFieldView.layer.cornerRadius = 12;
    
    _customTableView.layer.cornerRadius = 12;
 
    
    
    
    
    width = CGRectGetWidth(_firstFieldView.bounds);
    height = CGRectGetHeight(_firstFieldView.bounds);
    
    _firstFieldTextField.frame = CGRectMake(12, 0, width-24, height);
    _firstFieldTextField.font = [UIFont systemFontOfSize:(self.view.frame.size.height*0.02173813 > 16?16:(self.view.frame.size.height*0.02173813)) weight:UIFontWeightRegular];
    
    
    
    
    
    [self AdjustTableViewFrames];
    
    
    
    
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        self.view.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        self.navigationController.navigationBar.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        self.firstFieldView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeTertiary];
        self.firstFieldTextField.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        self.firstFieldTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.firstFieldTextField.placeholder attributes:@{NSForegroundColorAttributeName : [[[LightDarkModeObject alloc] init] DarkModeTextSecondary]}];
        
        [self preferredStatusBarStyle];
        
    } else {
        
        self.navigationController.navigationBar.backgroundColor = self.view.backgroundColor;
        
    }

    
}

#pragma mark - TextField Methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if ([_firstFieldTextField isFirstResponder] == YES && _firstFieldTextField.text.length > 0) {
        
        [_firstFieldTextField resignFirstResponder];
        
    }
    
    return YES;
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [_firstFieldTextField resignFirstResponder];
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if ([_firstFieldTextField isFirstResponder]) {
        
        [self SetUpKeyBoardToolBar:YES AddAmount:NO];
        
    }
    
}

#pragma mark - Picker View Methods

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    NSInteger the_tag = [pickerView tag];
    
    if (the_tag == 1) {
        
        if (component == 0) {
            
            return [frequencyReminderAmountArray count];
            
        } else if (component == 1) {
            
            return [frequencyReminderFrequencyArray count];
            
        } else if (component == 2) {
            
            return 1;
            
        }
    }
    
    return 0;
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    NSInteger the_tag = [pickerView tag];
    
    if (the_tag == 1) {
        
        if (component == 0) {
            
            return [frequencyReminderAmountArray objectAtIndex:row];
            
        } else if (component == 1) {
            
            NSArray *arrayToUse;
            
            if ([reminderAmountComp intValue] == 1 || reminderAmountComp == NULL) {
                
                arrayToUse = @[@"Minute", @"Hour", @"Day", @"Week"];
                
            } else {
                
                arrayToUse = @[@"Minutes", @"Hours", @"Days", @"Weeks"];
                
            }
            
            return [arrayToUse objectAtIndex:row];
            
        } else if (component == 2) {
            
            return [@[@"Before", @"After"] objectAtIndex:row];
            
        }
        
    }
    
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    NSInteger the_tag = [pickerView tag];
    
    if (the_tag == 1) {
        
        if (component == 0) {
            
            if ([frequencyReminderAmountArray count] > row) {
                
                reminderAmountComp = [frequencyReminderAmountArray objectAtIndex:row];
                
            }
            
        } else if (component == 1) {
            
            NSArray *arrayToUse;
            
            if ([reminderAmountComp intValue] == 1 || reminderAmountComp == NULL || reminderAmountComp == nil || reminderAmountComp.length == 0) {
                
                arrayToUse = @[@"Minute", @"Hour", @"Day", @"Week"];
                
            } else {
                
                arrayToUse = @[@"Minutes", @"Hours", @"Days", @"Weeks"];
                
            }
            
            if ([arrayToUse count] > row) {
                
                reminderFrequencyComp = [arrayToUse objectAtIndex:row];
                
            }
            
        }
        
        if (reminderAmountComp == nil || reminderAmountComp == NULL || reminderAmountComp.length == 0 || [reminderAmountComp containsString:@"(null)"]) {
            
            reminderAmountComp = @"2";
            
        }
        
        if (reminderFrequencyComp == nil || reminderFrequencyComp == NULL || reminderFrequencyComp.length == 0 || [reminderFrequencyComp containsString:@"(null)"]) {
            
            reminderFrequencyComp = @"Hours";
            
        }
        
        [(UIPickerView *)_firstFieldTextField.inputView reloadAllComponents];
        
        if ([reminderAmountComp isEqualToString:@"1"] && [reminderFrequencyComp containsString:@"s"]) {
            
            reminderFrequencyComp = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:reminderFrequencyComp arrayOfSymbols:@[@"s"]];
    
        }
        
        _firstFieldTextField.text = [NSString stringWithFormat:@"%@ %@ Before", reminderAmountComp, reminderFrequencyComp];
        
    }
    
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    NSInteger the_tag = [pickerView tag];
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    
    if (the_tag == 1) {
        
        if (component == 0) {
            return width*0.25;
        } else if (component == 1) {
            return width*0.35;
        } else if (component == 2) {
            return width*0.25;
        }
        
    }
    
    return 0;
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    NSInteger the_tag = [pickerView tag];
    
    if (the_tag == 1) {
        return 3;
    }
    
    return 1;
}

#pragma mark - Init Methods

-(void)InitMethod {
    
    [self SetUpAnalytics];
    
    [self SetUpInitialData];
    
    [self SetUpDelegates];
    
    [self SetUpTextFields];
    
    [self SetUpTableView];
    
    [self SetUpReminderFrequency];
    
}

-(void)BarButtonItems {
    
    self.navigationItem.hidesBackButton = YES;
    
    UIBarButtonItem *barButtonItem;
    
    barButtonItem =
    [[UIBarButtonItem alloc]
     initWithTitle:@"Back"
     style:UIBarButtonItemStylePlain
     target:self
     action:@selector(NavigationBackButtonAction:)];
    
    self.navigationItem.leftBarButtonItem = barButtonItem;
    
    if (_viewingItemDetails == NO) {
        
        barButtonItem =
        [[UIBarButtonItem alloc]
         initWithTitle:@"Save"
         style:UIBarButtonItemStyleDone
         target:self
         action:@selector(SaveButtonAction:)];
        
        self.navigationItem.rightBarButtonItem = barButtonItem;
        
    }
    
}

#pragma mark - Setup Methods

-(void)SetUpContextMenu:(NSIndexPath *)indexPath cell:(OptionsCell *)cell {
    
    NSArray *keysArray = [_itemsAlreadyChosenDict allKeys];
    NSArray *sortedKeysArray = [keysArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    NSString *reminderName = sortedKeysArray[indexPath.row];
    
    NSMutableArray* actions = [[NSMutableArray alloc] init];
    
    
   
    
    UIImage *image1 = nil;
    UIImage *image2 = nil;
    UIImage *image3 = nil;
    
    if ([reminderName isEqualToString:@"Due Now"]) {
        
        if ([self->_itemsAlreadyChosenDict[reminderName][@"Option"] containsString:@"Option 3"]) {
            image3 = [UIImage systemImageNamed:@"checkmark"];
        } else if ([self->_itemsAlreadyChosenDict[reminderName][@"Option"] containsString:@"Option 2"]) {
            image2 = [UIImage systemImageNamed:@"checkmark"];
        } else {
            image1 = [UIImage systemImageNamed:@"checkmark"];
        }
        
    } else {
        
        if ([self->_itemsAlreadyChosenDict[reminderName][@"Option"] containsString:@"Option 3"]) {
            image3 = [UIImage systemImageNamed:@"checkmark"];
        } else if ([self->_itemsAlreadyChosenDict[reminderName][@"Option"] containsString:@"Option 2"]) {
            image2 = [UIImage systemImageNamed:@"checkmark"];
        } else {
            image1 = [UIImage systemImageNamed:@"checkmark"];
        }
        
    }
    
    
    
    
    NSArray *itemOptionArray = [reminderName isEqualToString:@"Due Now"] ?
    @[
        [NSString stringWithFormat:@"This %@ is due now. It was completed it in time! 🎉", [[[[GeneralObject alloc] init] GenerateItemType] lowercaseString]],
        [NSString stringWithFormat:@"This %@ is due now. 3 people did not complete it in time! 🎉", [[[[GeneralObject alloc] init] GenerateItemType] lowercaseString]],
        [NSString stringWithFormat:@"This %@ is due now. Jack, John, and Mary did not complete it in time! 🎉", [[[[GeneralObject alloc] init] GenerateItemType] lowercaseString]]
    ] :
    @[
        [NSString stringWithFormat:@"This %@ is due in 2 hours.", [[[[GeneralObject alloc] init] GenerateItemType] lowercaseString]],
        [NSString stringWithFormat:@"This %@ is due in 2 hours and 3 people have completed it so far.", [[[[GeneralObject alloc] init] GenerateItemType] lowercaseString]],
        [NSString stringWithFormat:@"This %@ is due in 2 hours and Jack, John, and Mary have completed it so far.", [[[[GeneralObject alloc] init] GenerateItemType] lowercaseString]]
    ];
    
    
    
    
    for (int i=0 ; i<[itemOptionArray count] ; i++) {
        
        __block NSString *reminderOption = itemOptionArray[i];
        NSString *optionNumber = [NSString stringWithFormat:@"Option %d", i+1];
        UIImage *imageToUse = nil;
        
        
        
        if (i == 0) {
            imageToUse = image1;
        } else if (i == 1) {
            imageToUse = image2;
        } else if (i == 2) {
            imageToUse = image3;
        }
        
        
        
        NSMutableArray *optionMenuActions = [NSMutableArray array];
        
        UIAction *optionMenuSelectAction = [self OptionMenuSelectAction:reminderName reminderOption:reminderOption optionNumber:optionNumber];

        [optionMenuActions addObject:optionMenuSelectAction];
        
        
        
        UIMenu *optionMenu = [UIMenu menuWithTitle:optionNumber image:imageToUse identifier:optionNumber options:0 children:optionMenuActions];
        
        if (@available(iOS 15.0, *)) {
            optionMenu.subtitle = reminderOption;
        }
        
        [actions addObject:optionMenu];
        
    }
    
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        cell.ellipsisImageOverlay.userInteractionEnabled = YES;
        cell.ellipsisImageOverlay.hidden = NO;
        cell.ellipsisImageOverlay.menu = [UIMenu menuWithTitle:@"" children:actions];
        cell.ellipsisImageOverlay.showsMenuAsPrimaryAction = self->_viewingItemDetails == NO ? true : false;
    });
    
}

-(void)SetUpAnalytics {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewViewController:@"ViewAddItemsViewController" completionHandler:^(BOOL finished) {
        
    }];
    
}

-(void)SetUpInitialData {
    
    homeMembersDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeMembersDict"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"HomeMembersDict"] mutableCopy] : [NSMutableDictionary dictionary];
    
}

-(void)SetUpDelegates {
    
    _firstFieldTextField.delegate = self;
    
    if (_viewingItemDetails == YES) {
        _firstFieldTextField.userInteractionEnabled = NO;
    }
    
}

-(void)SetUpTextFields {
    
    NSString *firstPlaceholderToUse = @"Reminder";
    
    _firstFieldTextField.placeholder = firstPlaceholderToUse;
    
    
    UIPickerView *pickerView;
    
    pickerView = [[UIPickerView alloc]init];
    pickerView.delegate = self;
    pickerView.tag = 1;
    [self.firstFieldTextField setInputView:pickerView];
    
    
}

-(void)SetUpTableView {
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectZero];
    footer.backgroundColor = self.view.backgroundColor;
    
    _customTableView.tableFooterView = footer;
    _customTableView.delegate = self;
    _customTableView.dataSource = self;
    
}

-(void)SetUpKeyBoardToolBar:(BOOL)AddItem AddAmount:(BOOL)AddAmount {
    
    UIToolbar* keyboardToolbar = [[UIToolbar alloc] init];
    
    [keyboardToolbar sizeToFit];
    
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                      target:nil action:nil];
   
    UIBarButtonItem *dueDateReminderBarButton = [[UIBarButtonItem alloc]
                                     initWithTitle:@"Due Now Reminder" style:UIBarButtonItemStyleDone target:self action:@selector(AddDueDateReminder:)];
    UIBarButtonItem *addBarButton = [[UIBarButtonItem alloc]
                                     initWithTitle:@"Add Reminder" style:UIBarButtonItemStyleDone target:self action:@selector(AddItem:)];
    
    keyboardToolbar.items = @[dueDateReminderBarButton, flexBarButton, addBarButton];
    self.firstFieldTextField.inputAccessoryView = keyboardToolbar;
    
}

-(void)SetUpReminderFrequency {
    
    frequencyReminderAmountArray = [[NSMutableArray alloc] init];
    frequencyReminderFrequencyArray = [[NSMutableArray alloc] init];
    
    NSString *sStr = @"s";
    
    if (reminderAmountComp != NULL && [reminderAmountComp isEqualToString:@"1"]) {
        sStr = @"";
    }
    
    BOOL TaskIsRepeatingHourly = [[[BoolDataObject alloc] init] TaskIsRepeatingHourly:[@{@"ItemRepeats" : _itemRepeats} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType]];
    BOOL TaskIsRepeatingDaily = [[[BoolDataObject alloc] init] TaskIsRepeatingDaily:[@{@"ItemRepeats" : _itemRepeats} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType]];
    BOOL TaskIsRepeatingWeekly = [[[BoolDataObject alloc] init] TaskIsRepeatingWeekly:[@{@"ItemRepeats" : _itemRepeats} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType]];
    BOOL TaskIsRepeatingMonthly = [[[BoolDataObject alloc] init] TaskIsRepeatingMonthly:[@{@"ItemRepeats" : _itemRepeats} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType]];
    
    if ([_itemRepeats isEqualToString:@"Never"] == NO && _itemRepeats.length > 0) {
        
        frequencyReminderAmountArray = [[NSMutableArray alloc] init];
        for (int i=1;i<61;i++) {
            [frequencyReminderAmountArray addObject:[NSString stringWithFormat:@"%d", i]];
        }
        
        if (TaskIsRepeatingHourly || TaskIsRepeatingDaily) {
            
            frequencyReminderFrequencyArray = [[NSMutableArray alloc] init];
            [frequencyReminderFrequencyArray addObject:[NSString stringWithFormat:@"Minute%@", sStr]];
            [frequencyReminderFrequencyArray addObject:[NSString stringWithFormat:@"Hour%@", sStr]];
            
        } else if (TaskIsRepeatingWeekly) {
            
            frequencyReminderFrequencyArray = [[NSMutableArray alloc] init];
            [frequencyReminderFrequencyArray addObject:[NSString stringWithFormat:@"Minute%@", sStr]];
            [frequencyReminderFrequencyArray addObject:[NSString stringWithFormat:@"Hour%@", sStr]];
            [frequencyReminderFrequencyArray addObject:[NSString stringWithFormat:@"Day%@", sStr]];
            
        } else if (TaskIsRepeatingMonthly) {
            
            frequencyReminderFrequencyArray = [[NSMutableArray alloc] init];
            [frequencyReminderFrequencyArray addObject:[NSString stringWithFormat:@"Minute%@", sStr]];
            [frequencyReminderFrequencyArray addObject:[NSString stringWithFormat:@"Hour%@", sStr]];
            [frequencyReminderFrequencyArray addObject:[NSString stringWithFormat:@"Day%@", sStr]];
            [frequencyReminderFrequencyArray addObject:[NSString stringWithFormat:@"Week%@", sStr]];
            
        }
        
    } else if ([_itemRepeats isEqualToString:@"Never"] == YES || _itemRepeats.length == 0) {
        
        frequencyReminderAmountArray = [[NSMutableArray alloc] init];
        for (int i=1;i<61;i++) {
            [frequencyReminderAmountArray addObject:[NSString stringWithFormat:@"%d", i]];
        }
        
        frequencyReminderFrequencyArray = [[NSMutableArray alloc] init];
        [frequencyReminderFrequencyArray addObject:[NSString stringWithFormat:@"Minute%@", sStr]];
        [frequencyReminderFrequencyArray addObject:[NSString stringWithFormat:@"Hour%@", sStr]];
        [frequencyReminderFrequencyArray addObject:[NSString stringWithFormat:@"Day%@", sStr]];
        [frequencyReminderFrequencyArray addObject:[NSString stringWithFormat:@"Week%@", sStr]];
        
    }
    
}

#pragma mark - UI Methods

-(void)AdjustTableViewFrames {
    
    [UIView animateWithDuration:0.25 animations:^{
        
        CGFloat width = CGRectGetWidth(self.view.bounds);
        
        self->_customTableView.frame = CGRectMake(width*0.5 - ((width*0.90338164)*0.5), self->_firstFieldView.frame.origin.y + self->_firstFieldView.frame.size.height + 12, width*0.90338164, 0);
        
        CGFloat tableViewHeight = [self AdjustTableViewHeight:self->_customTableView];
        
        CGRect newRect = self->_customTableView.frame;
        newRect.size.height = tableViewHeight;
        self->_customTableView.frame = newRect;
        
    }];
    
    [self.customTableView reloadData];
    
}

-(CGFloat)AdjustTableViewHeight:(UITableView *)tableView {
    
    NSMutableArray *arrayToUse = [[_itemsAlreadyChosenDict allKeys] mutableCopy];
    
    CGFloat tableViewHeight = 0;
    
    if (arrayToUse.count > 0) {
        //65,85
        
        for (NSString *itemName in [_itemsAlreadyChosenDict allKeys]) {
            
            int numToAdd = (self.view.frame.size.height*0.07531866 > 65?65:(self.view.frame.size.height*0.07531866));
            
            if ([self->_itemsAlreadyChosenDict[itemName][@"Body"] containsString:@"and Jack, John, and Mary have completed it so far"] ||
                [self->_itemsAlreadyChosenDict[itemName][@"Body"] containsString:@"and 3 people have completed it so far"] ||
                [itemName isEqualToString:@"Due Now"]) {
                numToAdd = (self.view.frame.size.height*0.09849363 > 85?85:(self.view.frame.size.height*0.09849363));
            }
            
            tableViewHeight += numToAdd;
            
            CGFloat height = CGRectGetHeight(self.view.bounds);
            
            CGFloat bottomPadding = [[[GeneralObject alloc] init] GetBottomPaddingHeight];
            
            CGFloat maxiumHeightToCheck = (tableViewHeight > (height - tableView.frame.origin.y - 12 - bottomPadding));
            
            CGFloat mexiumHeight = (height - (height - tableView.frame.origin.y - 12 - bottomPadding));
            
            if (maxiumHeightToCheck) {
                tableViewHeight = mexiumHeight;
            }
            
        }
        
    }
    
    return tableViewHeight;
    
}

#pragma mark - IBAction Methods

-(IBAction)NavigationBackButtonAction:(UIBarButtonItem *)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Navigation Back Button Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(IBAction)SaveButtonAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Save Button Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    NSDictionary *dataDict = @{@"Items" : [NSMutableArray array], @"ItemsDict" : _itemsAlreadyChosenDict};
   
    [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemReminders" userInfo:dataDict locations:@[@"Tasks", @"AddTask"]];

    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(IBAction)AddItem:(id)sender {
    
    NSString *firstFieldText = _firstFieldTextField.text;
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Add Item Selected %@ For %@", firstFieldText, [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    int numberOfBeforeReminders = 0;
    
    for (NSString *itemReminder in [_itemsAlreadyChosenDict allKeys]) {
     
        if ([itemReminder containsString:@"Before"]) {
            numberOfBeforeReminders += 1;
        }
        
    }
   
    if ([[[BoolDataObject alloc] init] PremiumSubscriptionIsOn] == NO && numberOfBeforeReminders == 2) {
        
        [[[PushObject alloc] init] PushToWeDivvyPremiumViewController:YES comingFromSignUp:NO defaultPlan:@"" displayDiscount:@"Half-Off Yearly Discount No Sale Sticker" selectedSlide:@"Third Reminder" promoCodeID:@"" premiumPlanProductsArray:premiumPlanProductsArray premiumPlanPricesDict:premiumPlanPricesDict premiumPlanExpensivePricesDict:premiumPlanExpensivePricesDict premiumPlanPricesDiscountDict:premiumPlanPricesDiscountDict premiumPlanPricesNoFreeTrialDict:premiumPlanPricesNoFreeTrialDict currentViewController:self Superficial:NO];
        
    } else if ([[_itemsAlreadyChosenDict allKeys] containsObject:_firstFieldTextField.text]) {
        
        [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You already have this reminder" currentViewController:self];
        
    } else {
        
        NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
        NSString *trimmedStringItemName = [firstFieldText stringByTrimmingCharactersInSet:charSet];
        
        if (trimmedStringItemName.length > 0) {
            
            NSString *itemNameWithoutBefore = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:_firstFieldTextField.text arrayOfSymbols:@[@" Before"]];
           
            [_itemsAlreadyChosenDict setObject:@{@"Body" : [NSString stringWithFormat:@"This %@ is due in %@", [[[[GeneralObject alloc] init] GenerateItemType] lowercaseString], [itemNameWithoutBefore lowercaseString]], @"Option" : @"Option 1"} forKey:_firstFieldTextField.text];
            
            _firstFieldTextField.text = @"";
            
        }
      
        [self AdjustTableViewFrames];
  
    }
    
}

-(IBAction)AddDueDateReminder:(id)sender {
    
    if ([[_itemsAlreadyChosenDict allKeys] containsObject:@"Due Now"]) {
        
        [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You already have this reminder" currentViewController:self];
        
    } else {
        
        [_itemsAlreadyChosenDict setObject:@{@"Body" : [NSString stringWithFormat:@"This %@ is due now. Jack, John, and Mary completed it in time! 🎉", [[[[GeneralObject alloc] init] GenerateItemType] lowercaseString]],
                                             @"Option" : @"Option 3"} forKey:@"Due Now"];
        
        [self AdjustTableViewFrames];
        
    }
    
}

#pragma mark - Table View Methods

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    OptionsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OptionsCell"];
    
    NSArray *keysArray = [_itemsAlreadyChosenDict allKeys];
    NSArray *sortedKeysArray = [keysArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    NSString *itemName = sortedKeysArray[indexPath.row];
    
    if ([itemName containsString:@" Before"] && [_itemTime containsString:@"Any Time"] == NO && _itemTime != NULL) {
        
        NSDateFormatter *dateFormat = [[[GeneralObject alloc] init] GenerateDateFormatWithString:@"h:mm a"];
        
        // Create an instance of NSCalendar
        NSCalendar *calendar = [NSCalendar currentCalendar];
        
        // Extract the date components from the current date and time
        NSDateComponents *dateComponents = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:[dateFormat dateFromString:_itemTime]];
        
        // Create an NSDate object from the specified date components
        NSDate *date = [calendar dateFromComponents:dateComponents];
        
        NSArray *beforeArr = [itemName componentsSeparatedByString:@" "];
        int num = [beforeArr count] > 0 ? [beforeArr[0] intValue] : 0;
        
        if (num > 0) {
            
            // Subtract 2 hours from the NSDate object
            NSDateComponents *subtractComponents = [[NSDateComponents alloc] init];
            if ([itemName containsString:@"Hour"]) { [subtractComponents setHour:-1*num]; }
            if ([itemName containsString:@"Minute"]) { [subtractComponents setHour:-1*num]; }
            
            NSDate *resultDate = [calendar dateByAddingComponents:subtractComponents toDate:date options:0];
            
            // Create a date formatter to display the result
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"h:mm a"];
            
            // Format and print the result
            NSString *resultString = [dateFormatter stringFromDate:resultDate];
            NSLog(@"Result: %@", resultString);
            
            itemName = [NSString stringWithFormat:@"%@ (%@)", itemName, resultString];
            
        }
        
    }
    
    cell.itemOptionLeftLabel.text = itemName;
    cell.itemOptionSubLabel.text = [NSString stringWithFormat:@"Example: %@", _itemsAlreadyChosenDict[sortedKeysArray[indexPath.row]][@"Body"]];
    
    cell.itemOptionRightLabel.text = @"";
    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[_itemsAlreadyChosenDict allKeys] count];
    
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(OptionsCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    cell.itemOptionLeftLabel.font = [UIFont systemFontOfSize:(self.view.frame.size.height*0.02173813 > 16?16:(self.view.frame.size.height*0.02173813)) weight:UIFontWeightRegular];
    cell.itemOptionRightLabel.font = [UIFont systemFontOfSize:(self.view.frame.size.height*0.02173813 > 16?16:(self.view.frame.size.height*0.02173813)) weight:UIFontWeightRegular];
    
    CGFloat height = 65;
    CGFloat width = CGRectGetWidth(cell.contentView.bounds);
    
    NSArray *keysArray = [_itemsAlreadyChosenDict allKeys];
    NSArray *sortedKeysArray = [keysArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    NSString *itemName = sortedKeysArray[indexPath.row];
    
    CGFloat widthToUse = width*0.89304813;
    
    CGFloat numberOfLines = [[[GeneralObject alloc] init] LineCountForText:cell.itemOptionSubLabel.text label:cell.itemOptionSubLabel];
    
    int numToAdd = (self.view.frame.size.height*0.01969873 > 17?17:(self.view.frame.size.height*0.01969873)) * numberOfLines;

    cell.itemOptionLeftLabel.frame = CGRectMake(width*0.0534759, 12, widthToUse, 20);
    cell.itemOptionRightLabel.frame = CGRectMake(width - widthToUse - width*0.0534759, height*0, widthToUse, height);
    cell.itemOptionSubLabel.frame = CGRectMake(cell.itemOptionLeftLabel.frame.origin.x, cell.itemOptionLeftLabel.frame.origin.y + cell.itemOptionLeftLabel.frame.size.height + 8, widthToUse, numToAdd);
    
    if ([self->_itemsAlreadyChosenDict[itemName][@"Body"] containsString:@"and Jack, John, and Mary have completed it so far"] ||
        [self->_itemsAlreadyChosenDict[itemName][@"Body"] containsString:@"and 3 people have completed it so far"] ||
        [itemName isEqualToString:@"Due Now"]) {
    
        cell.ellipsisImage.frame = CGRectMake(width - ((height*0.35)*0.24) - width*0.0534759, 85*0.5 - ((height*0.35)*0.5), ((height*0.35)*0.24), height*0.35);
        
    } else {
        
        cell.ellipsisImage.frame = CGRectMake(width - ((height*0.35)*0.24) - width*0.0534759, height*0.5 - ((height*0.35)*0.5), ((height*0.35)*0.24), height*0.35);
        
    }
    
    cell.ellipsisImage.image = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [UIImage imageNamed:@"GeneralIcons.Ellipsis.White"] : [UIImage imageNamed:@"GeneralIcons.Ellipsis"];
    
    cell.ellipsisImageOverlay.frame = CGRectMake(cell.ellipsisImage.frame.origin.x - (width*0.125), cell.ellipsisImage.frame.origin.y - (width*0.026738), cell.ellipsisImage.frame.size.width + ((width*0.075)*2), cell.ellipsisImage.frame.size.height + ((width*0.026738)*2));
    
    CGRect newRect = cell.itemOptionSubLabel.frame;
    newRect.size.width = width - cell.itemOptionLeftLabel.frame.origin.x*2 - (width-cell.ellipsisImage.frame.origin.x);
    cell.itemOptionSubLabel.frame = newRect;
    
    [self SetUpContextMenu:indexPath cell:cell];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSArray *keysArray = [_itemsAlreadyChosenDict allKeys];
    NSArray *sortedKeysArray = [keysArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    NSString *itemName = sortedKeysArray[indexPath.row];
  
    int numToAdd = (self.view.frame.size.height*0.07531866 > 65?65:(self.view.frame.size.height*0.07531866));
    
    if ([self->_itemsAlreadyChosenDict[itemName][@"Body"] containsString:@"and Jack, John, and Mary have completed it so far"] ||
        [self->_itemsAlreadyChosenDict[itemName][@"Body"] containsString:@"and 3 people have completed it so far"] ||
        [itemName isEqualToString:@"Due Now"]) {
        numToAdd = (self.view.frame.size.height*0.09849363 > 85?85:(self.view.frame.size.height*0.09849363));
    }
    
    return numToAdd;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

-(UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UIContextualAction *RemoveAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:nil handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        
        NSArray *keysArray = [self->_itemsAlreadyChosenDict allKeys];
        NSArray *sortedKeysArray = [keysArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        NSString *itemName = sortedKeysArray[indexPath.row];
        
        [self->_itemsAlreadyChosenDict removeObjectForKey:itemName];
        
        [self AdjustTableViewFrames];
        
    }];
    
    RemoveAction.image = [UIImage systemImageNamed:@"xmark"];
    RemoveAction.backgroundColor = [UIColor systemRedColor];
    
    NSArray *actionsArray;
    
    actionsArray = @[RemoveAction];
    
    if (self->_viewingItemDetails == YES) {
        actionsArray = @[];
    }
    
    //right to left
    return [UISwipeActionsConfiguration configurationWithActions:actionsArray];
    
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

#pragma mark SetUpContextMenu

-(UIAction *)OptionMenuSelectAction:(NSString *)reminderName reminderOption:(NSString *)reminderOption optionNumber:(NSString *)optionNumber {
    
    __block NSString *reminderOptionCopy = [reminderOption mutableCopy];
    
    UIAction *optionMenuSelectAction = [UIAction actionWithTitle:@"Select" image:nil identifier:0 handler:^(__kindof UIAction * _Nonnull action) {
        
        if ([reminderName containsString:@"Due Now"] == NO) {
            
            NSString *itemReminderWithoutBefore = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:reminderName arrayOfSymbols:@[@" Before"]];
            
            reminderOptionCopy = [[[GeneralObject alloc] init] GenerateStringWithReplacementString:reminderOptionCopy stringToReplace:@"2 hours" replacementString:[itemReminderWithoutBefore lowercaseString]];
        
        }
        
        [self->_itemsAlreadyChosenDict setObject:@{@"Body" : reminderOptionCopy, @"Option" : optionNumber} forKey:reminderName];
        
        [self AdjustTableViewFrames];
        
    }];
    
    return optionMenuSelectAction;
}

@end
