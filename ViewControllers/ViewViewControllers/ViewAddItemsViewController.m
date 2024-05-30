//
//  ViewListViewItemsViewController.m
//  WeDivvy
//
//  Created by Philip Nagel on 9/14/21.
//

#import "AppDelegate.h"
#import "ViewAddItemsViewController.h"
#import "OptionsCell.h"

#import "GeneralObject.h"
#import "GetDataObject.h"
#import "SetDataObject.h"
#import "BoolDataObject.h"
#import "LightDarkModeObject.h"

@interface ViewAddItemsViewController () {
    
    NSString *localCurrencySymbol;
    NSString *localCurrencyDecimalSeparatorSymbol;
    NSString *localCurrencyNumberSeparatorSymbol;
    
    NSMutableArray *itemsArray;
    NSMutableDictionary *itemsDict;
    
    NSString *assignedToComp;
    
    NSMutableArray *frequencyUsernameArray;
    
    NSMutableArray *frequencyHourArray;
    NSMutableArray *frequencyMinuteArray;
    NSMutableArray *frequencyAMPMArray;
    
    NSMutableArray *frequencyReminderAnyTimeAmountArray;
    NSMutableArray *frequencyReminderAnyTimeFrequencyArray;
    
    NSString *hourComp;
    NSString *minuteComp;
    NSString *AMPMComp;
    
    NSString *reminderAnyTimeAmountComp;
    NSString *reminderAnyTimeFrequencyComp;
    
    BOOL DisplayTwoTextFields;
    BOOL ItemDictUsed;
    
    BOOL viewingListItems;
    BOOL viewingSubtasks;
    BOOL viewingDueDate;
    BOOL viewingTime;
    BOOL viewingSpecificDates;
    BOOL viewingRemindersAnyTime;
    BOOL viewingItemizedAmount;
    BOOL viewingAutoDarkMode;
    BOOL viewingSections;
    
    UIDatePicker *datePickerViewCustom;
    
}

@end

@implementation ViewAddItemsViewController

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
    CGFloat bottomPadding = [[[GeneralObject alloc] init] GetBottomPaddingHeight];
    
    _firstFieldView.frame = CGRectMake(width*0.5 - ((width*0.90338164)*0.5), navigationBarHeight + 12, (width*0.90338164), (self.view.frame.size.height*0.067934 > 50?(50):self.view.frame.size.height*0.067934));
    _firstFieldView.layer.cornerRadius = 12;
    
    
    
    self->_customTableView.frame = CGRectMake(width*0.5 - ((width*0.90338164)*0.5), self->_firstFieldView.frame.origin.y + self->_firstFieldView.frame.size.height + 12, width*0.90338164, 0);
    
    CGFloat tableViewHeight = [self AdjustTableViewFrames:self->_customTableView];
    
    CGRect newRect = self->_customTableView.frame;
    newRect.size.height = tableViewHeight;
    self->_customTableView.frame = newRect;
    
    _customTableView.layer.cornerRadius = 12;
    
    
    
    CGFloat yPos =
    [_firstFieldTextField isFirstResponder] || [_secondFieldTextField isFirstResponder] ?
    _amountView.frame.origin.y :
    height - (self.view.frame.size.height*0.09103261 > 67?(67):self.view.frame.size.height*0.09103261) - bottomPadding;
    
    _amountView.frame = CGRectMake(0, yPos, width*1, (self.view.frame.size.height*0.09103261 > 67?(67):self.view.frame.size.height*0.09103261) + bottomPadding);
    _amountView.hidden = viewingItemizedAmount ? NO : YES;
    
    
    
    
    
    width = CGRectGetWidth(_firstFieldView.bounds);
    height = CGRectGetHeight(_firstFieldView.bounds);
    
    if (DisplayTwoTextFields == YES) {
        
        _firstFieldTextField.frame = CGRectMake(12, 0, width*0.5 - 12 - 12, height);
        _secondFieldTextField.frame = CGRectMake(width - (width*0.5 - 12 - 12) - 12, 0, width*0.5 - 12 - 12, height);
        _lineView.frame = CGRectMake(width*0.5 - 0.5, 0, 1, height);
        
    } else {
        
        _firstFieldTextField.frame = CGRectMake(12, 0, width-24, height);
        _secondFieldTextField.hidden = YES;
        _secondFieldTextField.userInteractionEnabled = NO;
        _lineView.hidden = YES;
        
    }
    
    self->_firstFieldTextField.font = [UIFont systemFontOfSize:(self.view.frame.size.height*0.02173813 > 16?16:(self.view.frame.size.height*0.02173813)) weight:UIFontWeightRegular];
    self->_secondFieldTextField.font = [UIFont systemFontOfSize:(self.view.frame.size.height*0.02173813 > 16?16:(self.view.frame.size.height*0.02173813)) weight:UIFontWeightRegular];
    
    
    
    
    
    width = CGRectGetWidth(_amountView.bounds);
    height = CGRectGetHeight(_amountView.bounds);
    
    _totalAmountLabel.frame = CGRectMake(0, height*0.2537, width, (height-bottomPadding)*0.298507);
    _amountLeftLabel.frame = CGRectMake(0, height*0.56716, width, (height-bottomPadding)*0.298507);
    
    _totalAmountLabel.font = [UIFont systemFontOfSize:(_amountView.frame.size.height-bottomPadding)*0.208955 weight:UIFontWeightSemibold];
    _amountLeftLabel.font = [UIFont systemFontOfSize:(_amountView.frame.size.height-bottomPadding)*0.17910448 weight:UIFontWeightMedium];
    
    _amountView.layer.borderWidth = 0.0;
    _amountView.layer.shadowColor = [[[LightDarkModeObject alloc] init] LightModeShadow].CGColor;
    _amountView.layer.shadowRadius = 5;
    _amountView.layer.shadowOpacity = 1.0;
    _amountView.layer.shadowOffset = CGSizeMake(0, 0);
    
    
    
    
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        self.view.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        self.navigationController.navigationBar.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        self.firstFieldView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeTertiary];
        self.amountView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeTertiary];
        self.totalAmountLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        self.amountLeftLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        self.firstFieldTextField.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        self.secondFieldTextField.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        
        _firstFieldTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_firstFieldTextField.placeholder attributes:@{NSForegroundColorAttributeName : [[[LightDarkModeObject alloc] init] DarkModeTextSecondary]}];
        _secondFieldTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_secondFieldTextField.placeholder attributes:@{NSForegroundColorAttributeName : [[[LightDarkModeObject alloc] init] DarkModeTextSecondary]}];
        
        [self preferredStatusBarStyle];
        
    } else {
        
        self.navigationController.navigationBar.backgroundColor = self.view.backgroundColor;
        
    }
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [_firstFieldTextField resignFirstResponder];
    [_secondFieldTextField resignFirstResponder];
    
}

- (void)keyboardWillShow:(NSNotification *)notification{
    
    [UIView animateWithDuration:0.25 animations:^{
        
        NSDictionary* keyboardInfo = [notification userInfo];
        NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
        CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
        
        CGRect sendCoinsButton = self->_amountView.frame;
        
        sendCoinsButton.origin.y = CGRectGetHeight(self.view.bounds)-keyboardFrameBeginRect.size.height-self->_amountView.frame.size.height;
        
        self->_amountView.frame = sendCoinsButton;
        
    }];
    
}

- (void)keyboardWillHide:(NSNotification *)notification{
    
    [UIView animateWithDuration:0.25 animations:^{
        
        CGFloat width = CGRectGetWidth(self.view.bounds);
        CGFloat height = CGRectGetHeight(self.view.bounds);
        
        CGFloat bottomPadding = [[[GeneralObject alloc] init] GetBottomPaddingHeight];
        
        self->_amountView.frame = CGRectMake(0, height - (self.view.frame.size.height*0.09103261 > 67?(67):self.view.frame.size.height*0.09103261) - bottomPadding, width*1, (self.view.frame.size.height*0.09103261 > 67?(67):self.view.frame.size.height*0.09103261) + bottomPadding);
        
    }];
    
}

#pragma mark - TextField Methods

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (_viewingItemDetails == YES) {
        return NO;
    }
    
    if (textField == _secondFieldTextField) {
        
        if ([textField.text length] < 1000000000000){
            
            [self GenerateTextFieldAmount:textField string:string];
            
            return NO;
            
        } else {
            
            NSNumberFormatter *_currencyFormatter = [[NSNumberFormatter alloc] init];
            [_currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
            textField.text = [_currencyFormatter stringFromNumber:@1];
            
            return NO;
            
        }
        
    }
    
    return YES;
    
}

-(void)GenerateTextFieldAmount:(UITextField *)textField string:(NSString *)string {
    
    NSString *cleanCentString = [[textField.text componentsSeparatedByCharactersInSet: [[NSCharacterSet decimalDigitCharacterSet] invertedSet]] componentsJoinedByString:@""];
    NSInteger centValue = [cleanCentString intValue];
    NSNumberFormatter *numbersFormat = [[NSNumberFormatter alloc] init];
    NSNumber *myNumber = [numbersFormat numberFromString:cleanCentString];
    NSNumber *result;
    
    if (string.length > 0) {
        
        centValue = centValue * 10 + [string intValue];
        double intermediate = [myNumber doubleValue] * 10 + [[numbersFormat numberFromString:string] doubleValue];
        result = [[NSNumber alloc] initWithDouble:intermediate];
        
    } else {
        
        centValue = centValue / 10;
        double intermediate = [myNumber doubleValue]/10;
        result = [[NSNumber alloc] initWithDouble:intermediate];
        
    }
    
    myNumber = result;
    
    NSNumber *formatedValue;
    formatedValue = [[NSNumber alloc] initWithDouble:[myNumber doubleValue]/ 100.0f];
    NSNumberFormatter *_currencyFormatter = [[NSNumberFormatter alloc] init];
    _currencyFormatter.locale = [NSLocale currentLocale];
    [_currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    NSString *textFieldText = textField.text;
    textFieldText = [_currencyFormatter stringFromNumber:formatedValue];
    
    if ([textFieldText containsString:localCurrencySymbol] == NO) {
        textFieldText = [NSString stringWithFormat:@"%@%@", localCurrencySymbol, textFieldText];
    }
    
    textField.text = textFieldText;
    
    NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
    NSString *trimmedStringItemAmount = [textField.text stringByTrimmingCharactersInSet:charSet];
    
    if (viewingItemizedAmount == YES && (trimmedStringItemAmount.length == 0 || [trimmedStringItemAmount isEqualToString:[NSString stringWithFormat:@"%@0%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol]] == YES)) {
        
        [[[GeneralObject alloc] init] TextFieldIsEmptyColorChange:_firstFieldView textFieldField:_secondFieldTextField textFieldShouldDisplay:YES defaultColor:[UIColor whiteColor]];
        
    } else {
        
        _firstFieldView.backgroundColor = [UIColor whiteColor];
        
    }
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (DisplayTwoTextFields == YES) {
        
        if (textField == _firstFieldTextField) {
            
            NSString *itemName = [[[GeneralObject alloc] init] TrimString:_firstFieldTextField.text];
            NSString *itemAmount = [[[GeneralObject alloc] init] TrimString:_secondFieldTextField.text];
            
            if ([_firstFieldTextField isFirstResponder] == YES && itemName.length > 0) {
                
                [_secondFieldTextField becomeFirstResponder];
                
            } else if (itemName.length > 0 && itemAmount > 0) {
                
                [_firstFieldTextField resignFirstResponder];
                [_secondFieldTextField resignFirstResponder];
                
                [self AddItem];
                
            } else {
                
                [_firstFieldTextField resignFirstResponder];
                [_secondFieldTextField resignFirstResponder];
                
            }
            
        }
        
    } else {
        
        [self AddItem];
        
    }
    
    return YES;
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    
    [self SetUpKeyBoardToolBar];
    
    if (viewingSubtasks == YES || viewingListItems == YES) {
        
        UIPickerView *datePicker = (UIPickerView *)[self.secondFieldTextField inputView];
        [datePicker selectRow:[frequencyUsernameArray indexOfObject:@""] inComponent:0 animated:YES];
        
    }
    
}

#pragma mark - Picker View Methods

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    NSInteger the_tag = [pickerView tag];
    
    if (the_tag == 1) {
        
        if (component == 0) {
            
            return [frequencyUsernameArray count];
            
        }
        
    } else if (the_tag == 2) {
        
        if (component == 0) {
            
            return [frequencyReminderAnyTimeAmountArray count];
            
        } else if (component == 1) {
            
            return [frequencyReminderAnyTimeFrequencyArray count];
            
        } else if (component == 2) {
            
            return 1;
            
        }
        
    } else if (the_tag == 3) {
        
        if (component == 0) {
            
            return [frequencyHourArray count];
            
        } else if (component == 1) {
            
            return [frequencyMinuteArray count];
            
        } else if (component == 2) {
            
            return [frequencyAMPMArray count];
            
        }
        
    }
    
    return 0;
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    NSInteger the_tag = [pickerView tag];
    
    if (the_tag == 1) {
        
        if (component == 0) {
            
            return [frequencyUsernameArray objectAtIndex:row];
            
        }
        
    } else if (the_tag == 2) {
        
        if (component == 0) {
            
            return [frequencyReminderAnyTimeAmountArray objectAtIndex:row];
            
        } else if (component == 1) {
            
            NSArray *arrayToUse;
            
            if ([reminderAnyTimeAmountComp intValue] == 1 || reminderAnyTimeAmountComp == NULL) {
                
                arrayToUse = @[@"Day"];
                
            } else {
                
                arrayToUse = @[@"Days"];
                
            }
            
            return [arrayToUse objectAtIndex:row];
            
        } else if (component == 2) {
            
            return [@[@"Before"] objectAtIndex:row];
            
        }
        
    } else if (the_tag == 3) {
        
        if (component == 0) {
            
            return [frequencyHourArray objectAtIndex:row];
            
        } else if (component == 1) {
            
            return [frequencyMinuteArray objectAtIndex:row];
            
        } else if (component == 2) {
            
            return [frequencyAMPMArray objectAtIndex:row];
            
        }
        
    }
    
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    NSInteger the_tag = [pickerView tag];
    
    if (the_tag == 1) {
        
        [self GeneratePickerViewCompForSubtasksAndLists:row inComponent:component];
        
    } else if (the_tag == 2) {
        
        [self GeneratePickerViewCompForRemindersAnyTime:row inComponent:component];
        
    } else if (the_tag == 3) {
        
        [self GeneratePickerViewCompForTime:row inComponent:component];
        
    }
    
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    NSInteger the_tag = [pickerView tag];
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    
    if (the_tag == 1) {
        
        if (component == 0) {
            return width*1;
        }
        
    } else if (the_tag == 2) {
        
        if (component == 0) {
            return width*0.25;
        } else if (component == 1) {
            return width*0.35;
        } else if (component == 2) {
            return width*0.25;
        }
        
    } else if (the_tag == 3) {
        
        if (component == 0) {
            return width*0.145;
        } else if (component == 1) {
            return width*0.145;
        } else if (component == 2) {
            return width*0.145;
        }
        
    }
    
    return 0;
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    NSInteger the_tag = [pickerView tag];
    
    if (the_tag == 1) {
        return 1;
    } else if (the_tag == 2) {
        return 3;
    } else if (the_tag == 3) {
        return 3;
    }
    
    return 3;
}

#pragma mark - Init Methods

-(void)InitMethod {
    
    [self SetUpAnalytics];
    
    [self SetUpDelegates];
    
    [self SetUpLocalCurrency];
    
    [self SetUpBool];
    
    [self SetUpTimeFrequency];
    
    [self SetUpReminderAnyTimeFrequencyArray];
    
    [self SetUpArrays];
    
    [self SetUpTextFields];
    
    [self SetUpAmountView];
    
    [self SetUpTableView];
    
    [self SetUpKeyboardNSNotifications];
    
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

-(void)SetUpAnalytics {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewViewController:@"ViewAddItemsViewController" completionHandler:^(BOOL finished) {
        
    }];
    
}

-(void)SetUpDelegates {
    
    _secondFieldTextField.delegate = self;
    _firstFieldTextField.delegate = self;
    
    if (_viewingItemDetails == YES) {
        _firstFieldTextField.userInteractionEnabled = NO;
        _secondFieldTextField.userInteractionEnabled = NO;
    }
    
}

-(void)SetUpLocalCurrency {
    
    localCurrencySymbol = [[[GeneralObject alloc] init] GenerateLocalCurrencySymbol];
    localCurrencyDecimalSeparatorSymbol = [[[GeneralObject alloc] init] GenerateLocalCurrencyDecimalSeparatorSymbol];
    localCurrencyNumberSeparatorSymbol = [[[GeneralObject alloc] init] GenerateLocalCurrencyNumberSeparatorSymbol];
    
}

-(void)SetUpBool {
    
    if ([_optionSelectedString isEqualToString:@"ListItems"]) {
        
        viewingListItems = YES;
        
    } else if ([_optionSelectedString isEqualToString:@"Subtasks"]) {
        
        viewingSubtasks = YES;
        
    } else if ([_optionSelectedString isEqualToString:@"DueDate"]) {
        
        viewingDueDate = YES;
        
    } else if ([_optionSelectedString isEqualToString:@"Time"]) {
        
        viewingTime = YES;
        
    } else if ([_optionSelectedString isEqualToString:@"SpecificDates"]) {
        
        viewingSpecificDates = YES;
        
    } else if ([_optionSelectedString isEqualToString:@"RemindersAnyTime"]) {
        
        viewingRemindersAnyTime = YES;
        
    } else if ([_optionSelectedString isEqualToString:@"Itemized"]) {
        
        viewingItemizedAmount = YES;
        
    } else if ([_optionSelectedString isEqualToString:@"AutoDarkMode"]) {
        
        viewingAutoDarkMode = YES;
        
    } else if ([_optionSelectedString isEqualToString:@"Sections"]) {
        
        viewingSections = YES;
        
    }
    
    ItemDictUsed = viewingItemizedAmount == YES || viewingSubtasks == YES || viewingListItems == YES;
    DisplayTwoTextFields = viewingSpecificDates == YES || viewingRemindersAnyTime || viewingItemizedAmount == YES || viewingSubtasks == YES || viewingListItems == YES || viewingAutoDarkMode == YES;
    
}

-(void)SetUpTimeFrequency {
    
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

-(void)SetUpReminderAnyTimeFrequencyArray {
    
    frequencyReminderAnyTimeAmountArray = [[NSMutableArray alloc] init];
    frequencyReminderAnyTimeFrequencyArray = [[NSMutableArray alloc] init];
    
    NSString *sStr = @"s";
    
    if (reminderAnyTimeAmountComp != NULL && [reminderAnyTimeAmountComp isEqualToString:@"1"]) {
        sStr = @"";
    }
    
    frequencyReminderAnyTimeAmountArray = [[NSMutableArray alloc] init];
    for (int i=1;i<61;i++) {
        [frequencyReminderAnyTimeAmountArray addObject:[NSString stringWithFormat:@"%d", i]];
    }
    
    frequencyReminderAnyTimeFrequencyArray = [[NSMutableArray alloc] init];
    [frequencyReminderAnyTimeFrequencyArray addObject:[NSString stringWithFormat:@"Day%@", sStr]];
    
}

-(void)SetUpArrays {
    
    frequencyUsernameArray = [NSMutableArray array];
    [frequencyUsernameArray addObject:@""];
    
    for (NSString *username in _userDict[@"Username"]) {
        [frequencyUsernameArray addObject:username];
    }
    
    itemsArray = [NSMutableArray array];
    itemsDict = [NSMutableDictionary dictionary];
    
    
    
    
    if (viewingItemizedAmount || viewingSubtasks || viewingListItems) {
        
        itemsDict = _itemsAlreadyChosenDict ? [_itemsAlreadyChosenDict mutableCopy] : [NSMutableArray array];
        
        if ([[itemsDict allKeys] count] == 0) {
            [_firstFieldTextField becomeFirstResponder];
        }
        
    } else {
        
        itemsArray = _itemsAlreadyChosenArray ? [_itemsAlreadyChosenArray mutableCopy] : [NSMutableArray array];
        
        if (itemsArray.count == 0) {
            [_firstFieldTextField becomeFirstResponder];
        }
        
        if (viewingDueDate == YES && itemsArray.count == 1) {
            
            _firstFieldTextField.text = itemsArray[0];
            
            itemsArray = [NSMutableArray array];
            [self.customTableView reloadData];
            
        }
        
        if (viewingAutoDarkMode == YES && itemsArray.count == 2) {
            
            _firstFieldTextField.text = itemsArray[0];
            _secondFieldTextField.text = itemsArray[1];
            
        }
        
    }
    
}

-(void)SetUpTextFields {
    
    NSString *firstPlaceholderToUse = @"Item Name";
    NSString *secondPlaceholderToUse = @"Assigned To";
    
    if (viewingSubtasks) {
        firstPlaceholderToUse = @"Subtask Name";
        secondPlaceholderToUse = @"Assigned To";
    } else if (viewingItemizedAmount) {
        firstPlaceholderToUse = @"Expense Name";
        secondPlaceholderToUse = @"Expense Amount";
    } else if (viewingDueDate) {
        firstPlaceholderToUse = @"Due Date";
        secondPlaceholderToUse = @"";
    } else if (viewingSpecificDates) {
        firstPlaceholderToUse = @"Due Date";
        secondPlaceholderToUse = @"Time";
    } else if (viewingTime) {
        firstPlaceholderToUse = @"Time";
        secondPlaceholderToUse = @"";
    } else if (viewingRemindersAnyTime) {
        firstPlaceholderToUse = @"Day";
        secondPlaceholderToUse = @"Time";
    } else if (viewingAutoDarkMode) {
        firstPlaceholderToUse = @"Start Time";
        secondPlaceholderToUse = @"End Time";
    } else if (viewingSections) {
        firstPlaceholderToUse = @"Section";
        secondPlaceholderToUse = @"";
    }
    
    _firstFieldTextField.placeholder = firstPlaceholderToUse;
    _secondFieldTextField.placeholder = secondPlaceholderToUse;
    
    
    
    
    if (viewingItemizedAmount) {
        
        _secondFieldTextField.keyboardType = UIKeyboardTypeNumberPad;
        _secondFieldTextField.text = [NSString stringWithFormat:@"%@0%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol];
        
    } else if (viewingSubtasks || viewingListItems) {
        
        _secondFieldTextField.text = @"";
        
        UIPickerView *pickerView;
        
        pickerView = [[UIPickerView alloc]init];
        pickerView.delegate = self;
        pickerView.tag = 1;
        [self.secondFieldTextField setInputView:pickerView];
        
    } else if (viewingDueDate) {
        
        UIDatePicker *datePickerView = [[UIDatePicker alloc] init];
        
        [datePickerView setDate:[NSDate date]];
        [datePickerView setDatePickerMode:UIDatePickerModeDateAndTime];
        [datePickerView addTarget:self action:@selector(FormatDateTextField:) forControlEvents:UIControlEventValueChanged];
        if (@available(iOS 13.4, *)) {
            [datePickerView setPreferredDatePickerStyle:UIDatePickerStyleInline];
        }
        
        [self.firstFieldTextField setInputView:datePickerView];
        
    } else if (viewingSpecificDates) {
        
        UIDatePicker *datePickerView = [[UIDatePicker alloc] init];
        
        [datePickerView setDate:[NSDate date]];
        [datePickerView setDatePickerMode:UIDatePickerModeDateAndTime];
        [datePickerView addTarget:self action:@selector(FormatDateTextField:) forControlEvents:UIControlEventValueChanged];
        if (@available(iOS 13.4, *)) {
            [datePickerView setPreferredDatePickerStyle:UIDatePickerStyleInline];
        }
        
        [self.firstFieldTextField setInputView:datePickerView];
        
        UIPickerView *pickerView = [[UIPickerView alloc]init];
        pickerView.delegate = self;
        pickerView.tag = 3;
        
        [_secondFieldTextField setInputView:pickerView];
        
    } else if (viewingTime) {
        
        UIDatePicker *datePickerView = [[UIDatePicker alloc] init];
        
        [datePickerView setDate:[NSDate date]];
        [datePickerView setDatePickerMode:UIDatePickerModeTime];
        [datePickerView addTarget:self action:@selector(FormatDateTextField:) forControlEvents:UIControlEventValueChanged];
        if (@available(iOS 13.4, *)) {
            [datePickerView setPreferredDatePickerStyle:UIDatePickerStyleWheels];
        }
        
        [self.firstFieldTextField setInputView:datePickerView];
        
    } else if (viewingRemindersAnyTime) {
        
        UIPickerView *pickerView = [[UIPickerView alloc]init];
        pickerView.delegate = self;
        pickerView.tag = 2;
        [_firstFieldTextField setInputView:pickerView];
        
        pickerView = [[UIPickerView alloc]init];
        pickerView.delegate = self;
        pickerView.tag = 3;
        [_secondFieldTextField setInputView:pickerView];
        
    } else if (viewingAutoDarkMode) {
        
        UIDatePicker *datePickerView = [[UIDatePicker alloc]init];
        [datePickerView setDate:[NSDate date]];
        [datePickerView setDatePickerMode:UIDatePickerModeTime];
        [datePickerView addTarget:self action:@selector(FormatDateTextFieldTimeOnly:) forControlEvents:UIControlEventValueChanged];
        if (@available(iOS 13.4, *)) {
            [datePickerView setPreferredDatePickerStyle:UIDatePickerStyleWheels];
        }
        [self.firstFieldTextField setInputView:datePickerView];
        
        datePickerView = [[UIDatePicker alloc]init];
        [datePickerView setDate:[NSDate date]];
        [datePickerView setDatePickerMode:UIDatePickerModeTime];
        [datePickerView addTarget:self action:@selector(FormatDateTextFieldTimeOnly:) forControlEvents:UIControlEventValueChanged];
        if (@available(iOS 13.4, *)) {
            [datePickerView setPreferredDatePickerStyle:UIDatePickerStyleWheels];
        }
        [self.secondFieldTextField setInputView:datePickerView];
        
    }
    
}

-(void)SetUpAmountView {
    
    localCurrencySymbol = [[[GeneralObject alloc] init] GenerateLocalCurrencySymbol];
    
    if (viewingItemizedAmount) {
        
        _amountLeftLabel.text = [NSString stringWithFormat:@"%lu item%@", [[itemsDict allKeys] count], [[itemsDict allKeys] count] == 1 ? @"" : @"s"];
        
        if ([[itemsDict allKeys] count] > 0) {
            
            float totalAmount = 0.0;
            
            for (NSString *item in [itemsDict allKeys]) {
                
                id amountString = itemsDict[item][@"Amount"];
                
                BOOL ObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:amountString classArr:@[[NSArray class], [NSMutableArray class]]];
                
                if (ObjectIsKindOfClass == YES) {
                    amountString = amountString[0];
                }
                
                amountString = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:amountString arrayOfSymbols:@[localCurrencyNumberSeparatorSymbol, localCurrencySymbol]];
                amountString = [[[GeneralObject alloc] init] GenerateLocalCurrencyStringWithReverseSeparatorsForeign:amountString];
                
                totalAmount += [amountString floatValue];
            }
            
            NSString *totalAmountString = [NSString stringWithFormat:@"%.2f", totalAmount];
            
            totalAmountString = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:totalAmountString arrayOfSymbols:@[localCurrencyDecimalSeparatorSymbol, localCurrencyNumberSeparatorSymbol, localCurrencySymbol]];
            
            _totalAmountLabel.text = [NSString stringWithFormat:@"%@0%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol];
            _totalAmountLabel.text = [[[GeneralObject alloc] init] GenerateAmountInTextFieldInProperFormat:NSRangeFromString(totalAmountString) replacementString:totalAmountString];
            _totalAmountLabel.text = [NSString stringWithFormat:@"%@", _totalAmountLabel.text];
            
        } else {
            
            _totalAmountLabel.text = [NSString stringWithFormat:@"%@0%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol];
            
        }
        
    }
    
}

-(void)SetUpTableView {
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectZero];
    footer.backgroundColor = self.view.backgroundColor;
    
    _customTableView.tableFooterView = footer;
    _customTableView.delegate = self;
    _customTableView.dataSource = self;
    
}

-(void)SetUpKeyBoardToolBar {
    
    UIToolbar* keyboardToolbar = [[UIToolbar alloc] init];
    
    [keyboardToolbar sizeToFit];
    
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                      target:nil action:nil];
    
    NSString *title = @"Add Item";
    
    if (viewingSubtasks) {
        title = @"Add Subtask";
    } else if (viewingSpecificDates) {
        title = @"Add Due Date";
    } else if (viewingRemindersAnyTime) {
        title = @"Add Reminder";
    } else if (viewingSections) {
        title = @"Add Section";
    }
    
    UIBarButtonItem *addBarButton = [[UIBarButtonItem alloc]
                                     initWithTitle:title style:UIBarButtonItemStyleDone target:self action:@selector(AddItem)];
    UIBarButtonItem *anytimeBarButton = [[UIBarButtonItem alloc]
                                         initWithTitle:@"Any Time" style:UIBarButtonItemStyleDone target:self action:@selector(Time_AnyTime)];
    UIBarButtonItem *anyoneBarButton = [[UIBarButtonItem alloc]
                                        initWithTitle:@"Anybody" style:UIBarButtonItemStyleDone target:self action:@selector(AssignedTo_Anybody)];
    UIBarButtonItem *neverBarButton = [[UIBarButtonItem alloc]
                                       initWithTitle:@"Never" style:UIBarButtonItemStyleDone target:self action:@selector(AutoDarkMode_Never)];
    UIBarButtonItem *manualBarButton = [[UIBarButtonItem alloc]
                                        initWithTitle:@"Manual" style:UIBarButtonItemStyleDone target:self action:@selector(AutoDarkMode_Manual)];
    UIBarButtonItem *onTheDayBarButton = [[UIBarButtonItem alloc]
                                          initWithTitle:@"On The Day" style:UIBarButtonItemStyleDone target:self action:@selector(RemindersAnyTime_OnTheDay)];
    
    if (viewingSubtasks == YES || viewingListItems == YES) {
        
        if ([self.firstFieldTextField isFirstResponder]) {
            
            keyboardToolbar.items = @[flexBarButton, addBarButton];
            self.firstFieldTextField.inputAccessoryView = keyboardToolbar;
            
        }
        
        if ([self.secondFieldTextField isFirstResponder]) {
            
            keyboardToolbar.items = @[anyoneBarButton, flexBarButton, addBarButton];
            self.secondFieldTextField.inputAccessoryView = keyboardToolbar;
            
        }
        
    } else if (viewingSpecificDates == YES) {
        
        keyboardToolbar.items = @[flexBarButton, addBarButton];
        self.firstFieldTextField.inputAccessoryView = keyboardToolbar;
        
        keyboardToolbar.items = @[anytimeBarButton, flexBarButton, addBarButton];
        self.secondFieldTextField.inputAccessoryView = keyboardToolbar;
        
    } else if (viewingRemindersAnyTime == YES) {
        
        if ([self.firstFieldTextField isFirstResponder]) {
            
            keyboardToolbar.items = @[onTheDayBarButton, flexBarButton, addBarButton];
            self.firstFieldTextField.inputAccessoryView = keyboardToolbar;
            
        }
        
        if ([self.secondFieldTextField isFirstResponder]) {
            
            keyboardToolbar.items = @[flexBarButton, addBarButton];
            self.secondFieldTextField.inputAccessoryView = keyboardToolbar;
            
        }
        
    } else if (viewingAutoDarkMode == YES) {
        
        keyboardToolbar.items = @[neverBarButton, flexBarButton, manualBarButton];
        self.firstFieldTextField.inputAccessoryView = keyboardToolbar;
        self.secondFieldTextField.inputAccessoryView = keyboardToolbar;
        
    } else if (viewingTime == YES) {
        
        keyboardToolbar.items = @[flexBarButton, anytimeBarButton];
        self.firstFieldTextField.inputAccessoryView = keyboardToolbar;
        
    } else if (viewingDueDate == NO) {
        
        keyboardToolbar.items = @[flexBarButton, addBarButton];
        self.firstFieldTextField.inputAccessoryView = keyboardToolbar;
        self.secondFieldTextField.inputAccessoryView = keyboardToolbar;
        
    }
    
}

-(void)SetUpKeyboardNSNotifications {
    
    if (viewingItemizedAmount) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
        
    }
    
}

#pragma mark - Keyboard Toolbar Methods

-(void)AddItem {
    
    BOOL ObjectBeingAddedHasErrors = [self ObjectBeingAddedHasErrors];
    
    if (ObjectBeingAddedHasErrors == YES) {
        return;
    }
    
    
    
    
    if (DisplayTwoTextFields == YES) {
        
        NSString *firstFieldText = [[[GeneralObject alloc] init] TrimString:_firstFieldTextField.text];
        NSString *secondFieldText = [[[GeneralObject alloc] init] TrimString:_secondFieldTextField.text];
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Add Item Selected %@ -- %@ For %@", firstFieldText, secondFieldText, [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
            
        }];
        
        if (firstFieldText.length > 0 && secondFieldText > 0) {
            
            [_firstFieldTextField becomeFirstResponder];
            
            if (viewingItemizedAmount) {
                
                [self AddItemizedAmount];
                
            } else if (viewingSubtasks) {
                
                [self AddSubtask];
                
            } else if (viewingListItems) {
                
                [self AddListItem];
                
            } else if (viewingSpecificDates) {
                
                [self AddSpecificDueDate];
                
            } else if (viewingRemindersAnyTime) {
                
                [self AddRemindersAnyTime];
                
            }
            
        } else if (secondFieldText.length == 0) {
            
            [_firstFieldTextField resignFirstResponder];
            [_secondFieldTextField becomeFirstResponder];
            
        } else if (firstFieldText.length == 0) {
            
            [_firstFieldTextField becomeFirstResponder];
            [_secondFieldTextField resignFirstResponder];
            
        }
        
        
        
        
    } else if (DisplayTwoTextFields == NO) {
        
        [self AddSingleTextFieldObject];
        
    }
    
    
    
    
    if (viewingSpecificDates) {
        
        itemsArray = [[[GeneralObject alloc] init] SortArrayOfDatesNo1:itemsArray dateFormatString:@"EEE, MMMM dd, yyyy h:mm a"];
        
    } else if (viewingTime) {
        
        itemsArray = [[[GeneralObject alloc] init] SortArrayOfDates:itemsArray dateFormatString:@"h:mm a"];
        
    }
    
    if (viewingAutoDarkMode) {
        
        [_firstFieldTextField resignFirstResponder];
        [_secondFieldTextField resignFirstResponder];
        
    }
    
    
    
    
    [UIView animateWithDuration:0.25 animations:^{
        
        CGFloat width = CGRectGetWidth(self.view.bounds);
        
        self->_customTableView.frame = CGRectMake(width*0.5 - ((width*0.90338164)*0.5), self->_firstFieldView.frame.origin.y + self->_firstFieldView.frame.size.height + 12, width*0.90338164, 0);
        
        CGFloat tableViewHeight = [self AdjustTableViewFrames:self->_customTableView];
        
        CGRect newRect = self->_customTableView.frame;
        newRect.size.height = tableViewHeight;
        self->_customTableView.frame = newRect;
        
    }];
    
    [self.customTableView reloadData];
    
}

-(void)AssignedTo_Anybody {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Keyboard Toolbar Button \"Anyone\" Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    assignedToComp = @"Anybody";
    _secondFieldTextField.text = @"Anybody";
    
}

-(void)Time_AnyTime {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Keyboard Toolbar Button \"Anytime\" Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    if (viewingTime) {
        
        _firstFieldTextField.text = @"Any Time";
        
    } else if (viewingSpecificDates) {
        
        _secondFieldTextField.text = @"Any Time";
        
    } else {
        
        BOOL DueDateExists = (_firstFieldTextField.text.length > 0 && [_firstFieldTextField.text isEqualToString:@"No Due Date"] == NO);
        
        NSString *dueDate = _firstFieldTextField.text;
        
        if (DueDateExists == NO) {
            
            NSString *dateFormat = @"MMM dd, yyyy";
            NSArray *arr = [[[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:dateFormat returnAs:[NSString class]] componentsSeparatedByString:@" "];
            
            NSUInteger hour = (NSUInteger)arr[3];
            
            if (((hour >= 13) || (hour <= 21 && [arr containsObject:@"PM"])) || ((hour >= 1 && [arr containsObject:@"PM"]) || (hour <= 9 && [arr containsObject:@"AM"]))) {
                
                dateFormat = @"MMMM dd, yyyy";
                
            }
            
            dueDate = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:dateFormat returnAs:[NSString class]];
            
        }
        
        NSArray *arr = [dueDate componentsSeparatedByString:@" "];
        
        _firstFieldTextField.text =  [NSString stringWithFormat:@"%@ %@ %@ Any Time", arr[0], arr[1], arr[2]];
        
    }
    
}

-(void)RemindersAnyTime_OnTheDay {
    
    _firstFieldTextField.text = @"On The Day";
    
}

-(void)AutoDarkMode_Manual {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Keyboard Toolbar Button \"Manual\" Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    _firstFieldTextField.text = @"Manual";
    
}

-(void)AutoDarkMode_Never {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Keyboard Toolbar Button \"Never\" Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    _firstFieldTextField.text = @"Never";
    _secondFieldTextField.text = @"Never";
    
}

#pragma mark - UI Methods

-(CGFloat)AdjustTableViewFrames:(UITableView *)tableView {
    
    NSMutableArray *arrayToUse = ItemDictUsed == YES ? [[itemsDict allKeys] mutableCopy] : itemsArray;
    
    if (viewingAutoDarkMode == YES) {
        arrayToUse = [NSMutableArray array];
    }
    
    CGFloat tableViewHeight = 0;
    
    if (arrayToUse.count > 0) {
        
        tableViewHeight = (self.view.frame.size.height*0.067934 > 50?(50):self.view.frame.size.height*0.067934)*[arrayToUse count];
        
        CGFloat height = CGRectGetHeight(self.view.bounds);
        
        CGFloat bottomPadding = [[[GeneralObject alloc] init] GetBottomPaddingHeight];
        
        CGFloat maxiumHeightToCheck = (tableViewHeight > (height - tableView.frame.origin.y - 12 - bottomPadding));
        
        CGFloat mexiumHeight = (height - (height - tableView.frame.origin.y - 12 - bottomPadding));
        
        if (maxiumHeightToCheck) {
            tableViewHeight = mexiumHeight;
        }
        
    }
    
    return tableViewHeight;
    
}

#pragma mark - UX Methods

-(void)FormatDateTextField:(id)sender
{
    UIDatePicker *picker;
    NSDateFormatter *dateFormatter = viewingTime ? [[[GeneralObject alloc] init] GenerateDateFormatWithString:@"h:mm a"] : [[[GeneralObject alloc] init] GenerateDateFormatWithString:@"EEE, MMMM dd, yyyy"];
    
    if ([_firstFieldTextField isFirstResponder]) {
        
        picker = (UIDatePicker*)self.firstFieldTextField.inputView;
        
    }
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components;
    NSInteger hour = 0;
    
    components = [calendar components:(NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:picker.date];
    hour = [components hour];
    
    if ((
         ((hour >= 13) || (hour <= 21 && [[dateFormatter stringFromDate:picker.date] containsString:@"PM"])) ||
         ((hour >= 1 && [[dateFormatter stringFromDate:picker.date] containsString:@"PM"]) ||
          (hour <= 9 && [[dateFormatter stringFromDate:picker.date] containsString:@"AM"]))
         
         )) {
             
             dateFormatter = viewingTime ? [[[GeneralObject alloc] init] GenerateDateFormatWithString:@"h:mm a"] : [[[GeneralObject alloc] init] GenerateDateFormatWithString:@"EEE, MMMM dd, yyyy"];
             
         }
    
    NSString *dueDate = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:picker.date]];
    
    NSArray *arr = [dueDate componentsSeparatedByString:@" "];
    
    if ([_firstFieldTextField isFirstResponder]) {
        
        if (viewingTime) {
            
            dueDate = [arr count] > 1 ? [NSString stringWithFormat:@"%@ %@", arr[0], arr[1]] : @"Any Time";
            
        } else {
            
            dueDate = [arr count] > 3 ? [NSString stringWithFormat:@"%@ %@ %@ %@", arr[0], arr[1], arr[2], arr[3]] : @"";
            
        }
        
        self.firstFieldTextField.text = dueDate;
        
    }
    
}

-(void)FormatDateTextFieldTimeOnly:(id)sender
{
    UIDatePicker *picker;
    NSDateFormatter *dateFormatter = [[[GeneralObject alloc] init] GenerateDateFormatWithString:@"hh:mm a"];
    
    if ([_firstFieldTextField isFirstResponder]) {
        
        picker = (UIDatePicker*)self.firstFieldTextField.inputView;
        
    } else if ([_secondFieldTextField isFirstResponder]) {
        
        picker = (UIDatePicker*)self.secondFieldTextField.inputView;
        
    }
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components;
    NSInteger hour = 0;
    
    components = [calendar components:(NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:picker.date];
    hour = [components hour];
    
    if ((
         ((hour >= 13) || (hour <= 21 && [[dateFormatter stringFromDate:picker.date] containsString:@"PM"])) ||
         ((hour >= 1 && [[dateFormatter stringFromDate:picker.date] containsString:@"PM"]) ||
          (hour <= 9 && [[dateFormatter stringFromDate:picker.date] containsString:@"AM"]))
         
         )) {
             
             dateFormatter = [[[GeneralObject alloc] init] GenerateDateFormatWithString:@"h:mm a"];
             
         }
    
    NSString *dueDate = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:picker.date]];
    
    if ([_firstFieldTextField isFirstResponder]) {
        
        self.firstFieldTextField.text = dueDate;
        
    } else if ([_secondFieldTextField isFirstResponder]) {
        
        self.secondFieldTextField.text = dueDate;
        
    }
    
}

-(void)SelectRowForCompAndArrays:(NSArray *)arrayDict textField:(UITextField *)textField {
    
    UIPickerView *datePicker = (UIPickerView *)[textField inputView];
    
    for (NSDictionary *dict in arrayDict) {
        
        if ([arrayDict containsObject:dict]) {
            
            NSUInteger count = [arrayDict indexOfObject:dict];
            
            if ([dict[@"Array"] containsObject:dict[@"Comp"]]) {
                
                [datePicker selectRow:[dict[@"Array"] indexOfObject:dict[@"Comp"]] inComponent:count animated:YES];
                
            }
            
        }
        
    }
    
}

#pragma mark - IBAction Methods

-(IBAction)SaveButtonAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Save Button Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    if (viewingDueDate == YES && _firstFieldTextField.text.length == 0) {
        
        [[[GeneralObject alloc] init] TextFieldIsEmptyColorChange:_firstFieldView textFieldField:_firstFieldTextField textFieldShouldDisplay:YES defaultColor:_firstFieldView.backgroundColor];
        return;
    }
    
    if (viewingSubtasks) {
        
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemSubTasks" userInfo:@{@"ItemsDict" : itemsDict} locations:@[@"AddTask"]];
        
    } else if (viewingListItems) {
        
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemListItems" userInfo:@{@"Items" : itemsArray, @"ItemsDict" : itemsDict} locations:@[@"Tasks", @"AddTask", @"MultiAddTasks"]];
        
    } else if (viewingDueDate) {
        
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemDueDate" userInfo:@{@"Items" : _firstFieldTextField.text} locations:@[@"Tasks", @"AddTask"]];
        
    } else if (viewingTime) {
        
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemTime" userInfo:@{@"Items" : _firstFieldTextField.text} locations:@[@"Tasks"]];
        
    } else if (viewingSpecificDates) {
        
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemSpecificDueDates" userInfo:@{@"Items" : itemsArray, @"ItemsDict" : itemsDict} locations:@[@"AddTask"]];
        
    } else if (viewingRemindersAnyTime) {
        
        for (NSString *itemReminder in itemsArray) {
            [itemsDict setObject:@"" forKey:itemReminder];
        }
        
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemReminders" userInfo:@{@"Items" : itemsArray, @"ItemsDict" : itemsDict} locations:@[@"AddTask"]];
        
    } else if (viewingItemizedAmount) {
        
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemAmount" userInfo:@{@"Items" : itemsArray, @"ItemsDict" : itemsDict} locations:@[@"Tasks", @"AddTask"]];
        
    } else if (viewingAutoDarkMode) {
        
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"AutoDarkMode" userInfo:@{@"StartTime" : _firstFieldTextField.text, @"EndTime" : _secondFieldTextField.text} locations:@[@"Settings"]];
        
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(IBAction)NavigationBackButtonAction:(UIBarButtonItem *)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Navigation Back Button Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - Table View Methods

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    OptionsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OptionsCell"];
    
    if (ItemDictUsed == YES) {
        
        NSString *itemOptionLeftStr = [self GenerateItemOptionLeftLabelForDict:indexPath];
        cell.itemOptionLeftLabel.text = itemOptionLeftStr;
        
        NSString *itemOptionRightStr = [self GenerateItemOptionRightLabelForDict:indexPath itemOptionLeftStr:itemOptionLeftStr];
        cell.itemOptionRightLabel.text = itemOptionRightStr;
        
    } else {
       
        NSString *itemOptionLeftStr = [self GenerateItemOptionLeftLabelForArray:indexPath];
        cell.itemOptionLeftLabel.text = itemOptionLeftStr;
        cell.itemOptionRightLabel.text = @"";
        
    }
    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (ItemDictUsed == YES) {
        
        return [[itemsDict allKeys] count];
        
    }
    
    return itemsArray.count;
    
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(OptionsCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    cell.itemOptionLeftLabel.font = [UIFont systemFontOfSize:(self.view.frame.size.height*0.02173813 > 16?16:(self.view.frame.size.height*0.02173813)) weight:UIFontWeightRegular];
    cell.itemOptionRightLabel.font = [UIFont systemFontOfSize:(self.view.frame.size.height*0.02173813 > 16?16:(self.view.frame.size.height*0.02173813)) weight:UIFontWeightRegular];
    
    CGFloat height = CGRectGetHeight(cell.contentView.bounds);
    CGFloat width = CGRectGetWidth(cell.contentView.bounds);
    //374
    
    CGFloat widthToUse = DisplayTwoTextFields == YES ?
    (width*0.89304813)*0.5 :
    width*0.89304813;
   
    if (viewingSpecificDates == YES || viewingRemindersAnyTime == YES) {
        widthToUse = [[[GeneralObject alloc] init] WidthOfString:cell.itemOptionLeftLabel.text withFont:cell.itemOptionLeftLabel.font];
    }
    
    cell.itemOptionLeftLabel.frame = CGRectMake(width*0.0534759, height*0, widthToUse, height);
    cell.itemOptionRightLabel.frame = CGRectMake(width - widthToUse - width*0.0534759, height*0, widthToUse, height);
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        cell.itemOptionLeftLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        cell.itemOptionRightLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return (self.view.frame.size.height*0.067934 > 50?(50):self.view.frame.size.height*0.067934);
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

-(UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UIContextualAction *RemoveAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:nil handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        
        NSMutableArray *arrayToUse = self->ItemDictUsed == YES ? nil : [self->itemsArray mutableCopy];
        NSMutableDictionary *dictToUse = self->ItemDictUsed == YES ? [self->itemsDict mutableCopy] : nil;
        
        [self ListRemoveAction:indexPath itemsArray:arrayToUse itemsDict:dictToUse completionHandler:^(BOOL finished, NSMutableArray * _Nullable itemsArray, NSMutableDictionary * _Nullable returningItemsDict) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Remove Item For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
                
            }];
            
            if (self->ItemDictUsed == YES) {
                self->itemsDict = [returningItemsDict mutableCopy];
            } else {
                self->itemsArray = [itemsArray mutableCopy];
            }
            
            [UIView animateWithDuration:0.25 animations:^{
                
                CGFloat width = CGRectGetWidth(self.view.bounds);
                
                self->_customTableView.frame = CGRectMake(width*0.5 - ((width*0.90338164)*0.5), self->_firstFieldView.frame.origin.y + self->_firstFieldView.frame.size.height + 12, width*0.90338164, 0);
                
                CGFloat tableViewHeight = [self AdjustTableViewFrames:self->_customTableView];
                
                CGRect newRect = self->_customTableView.frame;
                newRect.size.height = tableViewHeight;
                self->_customTableView.frame = newRect;
                
            }];
            
            [self.customTableView reloadData];
            
            [self SetUpAmountView];
            
        }];
        
    }];
    
    RemoveAction.image = [UIImage systemImageNamed:@"xmark"];
    RemoveAction.backgroundColor = [UIColor systemRedColor];
    
    NSArray *actionsArray = @[RemoveAction];
    
    if (self->_viewingItemDetails == YES) {
        actionsArray = @[];
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

#pragma mark PickerView Methods

-(void)GeneratePickerViewCompForSubtasksAndLists:(NSInteger)row inComponent:(NSInteger)component {
    
    if (component == 0) {
        
        assignedToComp = [frequencyUsernameArray objectAtIndex:row];
        
    }
    
    if (assignedToComp == nil) {
        assignedToComp = @"Anybody";
    }
    
    if (assignedToComp.length > 0) {
        
        _secondFieldTextField.text = [NSString stringWithFormat:@"%@", assignedToComp];
        
    } else {
        
        _secondFieldTextField.text = @"Anybody";
        assignedToComp = @"Anybody";
        
        
    }
    
}

-(void)GeneratePickerViewCompForRemindersAnyTime:(NSInteger)row inComponent:(NSInteger)component {
    
    if (component == 0) {
        
        reminderAnyTimeAmountComp = [frequencyReminderAnyTimeAmountArray objectAtIndex:row];
        
    } else if (component == 1) {
        
        NSArray *arrayToUse;
        
        if ([reminderAnyTimeAmountComp intValue] == 1 || reminderAnyTimeAmountComp == NULL || reminderAnyTimeAmountComp == nil || reminderAnyTimeAmountComp.length == 0) {
            
            arrayToUse = @[@"Day"];
            
        } else {
            
            arrayToUse = @[@"Days"];
            
        }
        
        reminderAnyTimeFrequencyComp = [arrayToUse objectAtIndex:row];
        
    }
    
    if (reminderAnyTimeAmountComp == nil || reminderAnyTimeAmountComp == NULL || reminderAnyTimeAmountComp.length == 0 || [reminderAnyTimeAmountComp containsString:@"(null)"]) {
        
        reminderAnyTimeAmountComp = @"1";
        
    }
    
    reminderAnyTimeFrequencyComp = [reminderAnyTimeAmountComp isEqualToString:@"1"] ? @"Day" : @"Days";
    
    if ([reminderAnyTimeAmountComp isEqualToString:@"1"] && [reminderAnyTimeFrequencyComp containsString:@"s"]) {
        
        reminderAnyTimeFrequencyComp = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:reminderAnyTimeFrequencyComp arrayOfSymbols:@[@"s"]];
        
    }
    
    [(UIPickerView *)_firstFieldTextField.inputView reloadAllComponents];
    
    _firstFieldTextField.text = [NSString stringWithFormat:@"%@ %@ Before", reminderAnyTimeAmountComp, reminderAnyTimeFrequencyComp];
    
}

-(void)GeneratePickerViewCompForTime:(NSInteger)row inComponent:(NSInteger)component {
    
    if (component == 0) {
        
        if ([frequencyHourArray count] > row) {
            
            hourComp = [frequencyHourArray objectAtIndex:row];
            
        }
        
    } else if (component == 1) {
        
        if ([frequencyMinuteArray count] > row) {
            
            minuteComp = [frequencyMinuteArray objectAtIndex:row];
            
        }
        
    } else if (component == 2) {
        
        if ([frequencyAMPMArray count] > row) {
            
            AMPMComp = [frequencyAMPMArray objectAtIndex:row];
            
        }
        
    }
    
    if (hourComp == nil || hourComp == NULL || hourComp.length == 0) {
        hourComp = @"1";
    }
    if (minuteComp == nil || minuteComp == NULL || minuteComp.length == 0) {
        minuteComp = @"00";
    }
    if (AMPMComp == nil || AMPMComp == NULL || AMPMComp.length == 0) {
        AMPMComp = @"AM";
    }
    
    _secondFieldTextField.text = [NSString stringWithFormat:@"%@:%@ %@", hourComp, minuteComp, AMPMComp];
    
}

#pragma mark - AddItem Methods

-(BOOL)ObjectBeingAddedHasErrors {
    
    if (viewingSpecificDates == YES) {
        
        for (NSString *dueDate in itemsArray) {
            
            NSString *tempDueDate = [dueDate mutableCopy];
            
            NSArray *arr = [tempDueDate containsString:@" "] ? [tempDueDate componentsSeparatedByString:@" "] : @[];
            tempDueDate = [arr count] > 3 ? [NSString stringWithFormat:@"%@ %@ %@ %@", arr[0], arr[1], arr[2], arr[3]] : @"";
            
            if ([tempDueDate isEqualToString:_firstFieldTextField.text]) {
                
                [[[GeneralObject alloc] init] CreateAlert:@"Oops!" message:@"You can't add the same date twice" currentViewController:self];
                return YES;
                
            }
            
        }
        
        if (_firstFieldTextField.text.length == 0) {
            
            [[[GeneralObject alloc] init] TextFieldIsEmptyColorChange:_firstFieldView textFieldField:_firstFieldTextField textFieldShouldDisplay:YES defaultColor:_firstFieldView.backgroundColor];
            return YES;
            
        } else if (_secondFieldTextField.text.length == 0) {
            
            [[[GeneralObject alloc] init] TextFieldIsEmptyColorChange:_firstFieldView textFieldField:_secondFieldTextField textFieldShouldDisplay:YES defaultColor:_firstFieldView.backgroundColor];
            return YES;
            
        }
        
        
    }
    
    if (viewingRemindersAnyTime == YES) {
        
        if (([_itemRepeats isEqualToString:@"Daily"] || [_itemRepeats containsString:@"Hour"]) && ([_firstFieldTextField.text containsString:@"Day Before"] || [_firstFieldTextField.text containsString:@"Days Before"])) {
            
            [[[GeneralObject alloc] init] CreateAlert:@"Oops!" message:[NSString stringWithFormat:@"A %@ that is repeating %@ can't have a reminder a day or more before.", [[[[GeneralObject alloc] init] GenerateItemType] lowercaseString], [_itemRepeats isEqualToString:@"Daily"] ? @"daily" : @"hourly"] currentViewController:self];;
            return YES;
            
        } else if ([itemsArray count] >= 2) {
            
            [[[GeneralObject alloc] init] CreateAlert:@"Oops!" message:@"You can only have two reminders" currentViewController:self];;
            return YES;
            
        } else if (_firstFieldTextField.text.length == 0) {
            
            [[[GeneralObject alloc] init] TextFieldIsEmptyColorChange:_firstFieldView textFieldField:_firstFieldTextField textFieldShouldDisplay:YES defaultColor:_firstFieldView.backgroundColor];
            return YES;
            
        } else if (_secondFieldTextField.text.length == 0) {
            
            [[[GeneralObject alloc] init] TextFieldIsEmptyColorChange:_firstFieldView textFieldField:_secondFieldTextField textFieldShouldDisplay:YES defaultColor:_firstFieldView.backgroundColor];
            return YES;
            
        }
        
    }
    
    return NO;
}

#pragma mark

-(void)AddItemizedAmount {
    
    NSString *itemName = _firstFieldTextField.text;
    NSString *itemAmount = [NSString stringWithFormat:@"%@", _secondFieldTextField.text];
    
    [itemsDict setObject:@{@"Amount" : itemAmount, @"Assigned To" : @[@"Anybody"], @"Status" : @"Uncompleted"} forKey:itemName];
    
    _firstFieldTextField.text = @"";
    _secondFieldTextField.text = [NSString stringWithFormat:@"%@0%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol];
    
    [self SetUpAmountView];
    
}

-(void)AddSubtask {
    
    NSString *subtaskName = _firstFieldTextField.text;
    
    NSString *userID =
    [_userDict[@"Username"] containsObject:_secondFieldTextField.text] ?
    _userDict[@"UserID"][[_userDict[@"Username"] indexOfObject:_secondFieldTextField.text]] : @"Anybody";
    
    [itemsDict setObject:@{@"Assigned To" : @[userID]} forKey:subtaskName];
    
    NSArray *keysArray = [itemsDict allKeys];
    NSArray *sortedKeysArray = [keysArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    NSMutableDictionary *sortedDict = [NSMutableDictionary dictionary];
    
    for (NSString *subtask in sortedKeysArray) {
        [sortedDict setObject:itemsDict[subtask] forKey:subtask];
    }
    
    itemsDict = [sortedDict mutableCopy];
    
    _firstFieldTextField.text = @"";
    _secondFieldTextField.text = @"";
    
}

-(void)AddListItem {
    
    NSString *listItemName = _firstFieldTextField.text;
    
    NSString *userID = [_userDict[@"Username"] containsObject:_secondFieldTextField.text] ? _userDict[@"UserID"][[_userDict[@"Username"] indexOfObject:_secondFieldTextField.text]] : @"Anybody";
    
    [itemsDict setObject:@{@"Assigned To" : @[userID], @"Status" : @"Uncompleted"} forKey:listItemName];
    
    NSArray *keysArray = [itemsDict allKeys];
    NSArray *sortedKeysArray = [keysArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    NSMutableDictionary *sortedDict = [NSMutableDictionary dictionary];
    
    for (NSString *listItem in sortedKeysArray) {
        [sortedDict setObject:itemsDict[listItem] forKey:listItem];
    }
    
    itemsDict = [sortedDict mutableCopy];
    
    _firstFieldTextField.text = @"";
    _secondFieldTextField.text = @"";
    
}

-(void)AddSpecificDueDate {
    
    NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
    NSString *trimmedStringItemName = [_firstFieldTextField.text stringByTrimmingCharactersInSet:charSet];
    
    if (trimmedStringItemName.length > 0) {
        
        NSString *objectToAdd = [NSString stringWithFormat:@"%@ %@", _firstFieldTextField.text, _secondFieldTextField.text];
        
        [itemsArray insertObject:objectToAdd atIndex:0];
        
        _firstFieldTextField.text = @"";
        _secondFieldTextField.text = @"";
        
        NSArray *keysArray = itemsArray;
        NSArray *sortedKeysArray = [keysArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        NSMutableArray *sortedArray = [NSMutableArray array];
        
        for (NSString *itemName in sortedKeysArray) {
            [sortedArray addObject:itemName];
        }
        
        itemsArray = [sortedArray mutableCopy];
        
    }
    
    _firstFieldView.backgroundColor = [UIColor whiteColor];
    _firstFieldTextField.backgroundColor = [UIColor clearColor];
    _secondFieldTextField.backgroundColor = [UIColor clearColor];
    
    _secondFieldTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Time" attributes:@{NSForegroundColorAttributeName : [UIColor placeholderTextColor]}];
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        _firstFieldTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_firstFieldTextField.placeholder attributes:@{NSForegroundColorAttributeName : [[[LightDarkModeObject alloc] init] DarkModeTextSecondary]}];
        _secondFieldTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_secondFieldTextField.placeholder attributes:@{NSForegroundColorAttributeName : [[[LightDarkModeObject alloc] init] DarkModeTextSecondary]}];
    }
    
}

-(void)AddRemindersAnyTime {
    
    NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
    NSString *trimmedStringItemName = [_firstFieldTextField.text stringByTrimmingCharactersInSet:charSet];
    
    if (trimmedStringItemName.length > 0) {
        
        NSString *objectToAdd = [NSString stringWithFormat:@"%@ at %@", _firstFieldTextField.text, _secondFieldTextField.text];
        
        if ([itemsArray containsObject:objectToAdd] == NO) {
            
            [itemsArray insertObject:objectToAdd atIndex:0];
            
            _firstFieldTextField.text = @"";
            _secondFieldTextField.text = @"";
            
            NSArray *keysArray = itemsArray;
            NSArray *sortedKeysArray = [keysArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
            NSMutableArray *sortedArray = [NSMutableArray array];
            
            for (NSString *itemName in sortedKeysArray) {
                [sortedArray addObject:itemName];
            }
            
            itemsArray = [sortedArray mutableCopy];
            
        } else {
            
            [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You already have this reminder" currentViewController:self];
            
        }
        
    }
    
    _firstFieldView.backgroundColor = [UIColor whiteColor];
    _firstFieldTextField.backgroundColor = [UIColor clearColor];
    _secondFieldTextField.backgroundColor = [UIColor clearColor];
    
    _secondFieldTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Time" attributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:60.0f/255.0f green:60.0f/255.0f blue:67.0f/255.0f alpha:0.3f]}];
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        _firstFieldTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_firstFieldTextField.placeholder attributes:@{NSForegroundColorAttributeName : [[[LightDarkModeObject alloc] init] DarkModeTextSecondary]}];
        _secondFieldTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_secondFieldTextField.placeholder attributes:@{NSForegroundColorAttributeName : [[[LightDarkModeObject alloc] init] DarkModeTextSecondary]}];
    }
    
}

#pragma mark

-(void)AddSingleTextFieldObject {
    
    NSString *firstFieldText = _firstFieldTextField.text;
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Add Item Selected %@ For %@", firstFieldText, [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
    NSString *trimmedStringItemName = [firstFieldText stringByTrimmingCharactersInSet:charSet];
    
    if (trimmedStringItemName.length > 0) {
        
        NSString *objectToAdd = firstFieldText;
        
        [itemsArray insertObject:objectToAdd atIndex:0];
        
        _firstFieldTextField.text = @"";
        
        NSArray *keysArray = itemsArray;
        NSArray *sortedKeysArray = [keysArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        NSMutableArray *sortedArray = [NSMutableArray array];
        
        for (NSString *itemName in sortedKeysArray) {
            [sortedArray addObject:itemName];
        }
        
        itemsArray = [sortedArray mutableCopy];
        
    }
    
}

#pragma mark - TableView Methods

#pragma mark CellForRow

-(NSString *)GenerateItemOptionLeftLabelForDict:(NSIndexPath *)indexPath {
    
    NSArray *keysArray = [itemsDict allKeys];
    NSArray *sortedKeysArray = [keysArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    NSString *itemOptionLeftStr = sortedKeysArray[indexPath.row];
    
    return itemOptionLeftStr;
}

-(NSString *)GenerateItemOptionRightLabelForDict:(NSIndexPath *)indexPath itemOptionLeftStr:(NSString *)itemOptionLeftStr {
    
    NSString *keyToUse = viewingSubtasks || viewingListItems ? @"Assigned To" : @"Amount";
    NSString *itemOptionRightStr = viewingItemizedAmount == NO ? @"Anybody" : itemsDict[itemOptionLeftStr][keyToUse];
    
    if (viewingItemizedAmount == NO) {
        
        if ([(NSArray *)itemsDict[itemOptionLeftStr][keyToUse] count] > 0) {
            
            if ([_userDict[@"UserID"] containsObject:itemsDict[itemOptionLeftStr][keyToUse][0]]) {
                
                NSUInteger index = [_userDict[@"UserID"] indexOfObject:itemsDict[itemOptionLeftStr][keyToUse][0]];
                
                itemOptionRightStr = _userDict[@"Username"][index];
                
            }
            
        }
        
    }
    
    return itemOptionRightStr;
}

-(NSString *)GenerateItemOptionLeftLabelForArray:(NSIndexPath *)indexPath {
    
    NSArray *keysArray = itemsArray;
    NSArray *sortedKeysArray = [keysArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    if (viewingSpecificDates) {
        sortedKeysArray = [[[GeneralObject alloc] init] SortArrayOfDatesNo1:itemsArray dateFormatString:@"EEE, MMMM dd, yyyy h:mm a"];
    }
    
    NSString *itemOptionLeftStr = sortedKeysArray[indexPath.row];
    
    return itemOptionLeftStr;
}

#pragma mark TrailingSwipe

-(void)ListRemoveAction:(NSIndexPath *)indexPath itemsArray:(NSMutableArray * _Nullable)itemsArray itemsDict:(NSMutableDictionary * _Nullable)itemsDict completionHandler:(void (^)(BOOL finished, NSMutableArray * _Nullable itemsArray, NSMutableDictionary * _Nullable returningItemsDict))finishBlock {
    
    if (itemsArray != nil) {
        
        NSArray *keysArray = itemsArray;
        NSArray *sortedKeysArray = [keysArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        NSMutableArray *sortedArray = [NSMutableArray array];
        
        for (NSString *itemName in sortedKeysArray) {
            [sortedArray addObject:itemName];
        }
        
        itemsArray = [sortedArray mutableCopy];
        
        [itemsArray removeObjectAtIndex:indexPath.row];
        
    }
    
    if (itemsDict != nil) {
        
        NSArray *keysArray = [itemsDict allKeys];
        NSArray *sortedKeysArray = [keysArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        
        NSString *key = sortedKeysArray[indexPath.row];
        [itemsDict removeObjectForKey:key];
        
    }
    
    finishBlock(YES, itemsArray, itemsDict);
    
}

@end
