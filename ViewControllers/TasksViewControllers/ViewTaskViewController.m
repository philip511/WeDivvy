//
//  ViewItemViewController.m
//  RoommateApp
//
//  Created by Philip Nagel on 5/21/21.
//

#import "UIImageView+Letters.h"

#import "ViewTaskViewController.h"
#import "AppDelegate.h"
#import "ViewTaskCell.h"

#import "GeneralObject.h"
#import "GetDataObject.h"
#import "SetDataObject.h"
#import "DeleteDataObject.h"
#import "PushObject.h"
#import "NotificationsObject.h"
#import "CompleteUncompleteObject.h"
#import "ChatObject.h"
#import "BoolDataObject.h"
#import "LightDarkModeObject.h"

#import "AlertView.h"
#import "PopupCompleteView.h"

@interface ViewTaskViewController () {
    
    AlertView *alertView;
    
    MRProgressOverlayView *progressView;
    
    NSMutableDictionary *itemDict;
    NSMutableDictionary *itemxxxOccurrencesDict;
    
    NSString *itemUniqueID;
    NSString *itemName;
    NSString *itemAmount;
    NSString *itemDueDate;
    NSString *itemMustComplete;
    NSString *itemDatePosted;
    NSString *itemCreatedBy;
    NSString *itemCreatedByUsername;
    NSString *itemPrivate;
    NSString *itemDays;
    NSString *itemTime;
    NSDictionary *itemReminderDict;
    NSString *itemScheduledStart;
    NSString *itemRepeats;
    NSString *itemRepeatIfCompletedEarly;
    NSString *itemTakeTurns;
    NSString *itemStartDate;
    NSString *itemEndDate;
    NSString *itemCompleteAsNeeded;
    NSString *itemApprovalNeeded;
    NSString *itemItemized;
    NSString *itemTrash;
    NSString *itemImageURL;
    NSString *itemPriority;
    NSString *itemColor;
    NSString *itemTurnUserID;
    NSString *itemStatus;
    NSString *itemOccurrenceStatus;
    NSString *itemPhotoConfirmation;
    NSMutableDictionary *itemListItems;
    NSMutableDictionary *itemSubTasksDict;
    NSMutableDictionary *itemCostPerPersonDict;
    NSMutableDictionary *itemPaymentMethodDict;
    NSMutableDictionary *itemRewardDict;
    NSMutableDictionary *itemApprovalRequestsDict;
    NSMutableDictionary *itemPhotoConfirmationDict;
    NSMutableDictionary *itemItemizedItems;
    NSMutableArray *itemSpecificDueDatesArray;
    NSMutableArray *itemAssignedToArray;
    NSMutableArray *itemAssignedUsernameArray;
    NSMutableArray *itemAssignedProfileImageURLArray;
    NSMutableDictionary *itemCompletedDict;
    NSMutableDictionary *itemInProgressDict;
    NSMutableDictionary *itemWontDoDict;
    NSMutableDictionary *itemAdditionalRemindersDict;
    NSMutableArray *itemDueDatesSkippedArray;
    NSMutableArray *itemTagsArray;
    
    NSMutableArray *totalCompletedArray;
    NSMutableArray *totalCompletedSubTaskArray;
    
    NSString *itemNotes;
    
    NSArray *keyArray;
    NSArray *sectionsArray;
    
    NSString *itemType;
    NSString *itemTypeCollection;
    NSString *homeID;
    NSString *homeName;
    
    NSString *localCurrencySymbol;
    NSString *localCurrencyDecimalSeparatorSymbol;
    NSString *localCurrencyNumberSeparatorSymbol;
    
    NSString *reminderFrequencyComp;
    NSString *reminderAmountComp;
    NSMutableArray *frequencyReminderFrequencyArray;
    NSMutableArray *frequencyReminderAmountArray;
    
    UIImage *itemImage;
    
    BOOL ViewingAnalytics;
    BOOL duplicateItemDetails;
    
    BOOL UserCellsVisible;
    BOOL NonUserCellsVisible;
    BOOL SubtaskCellsVisible;
    BOOL ItemizedItemsVisible;
    BOOL ListItemsVisible;
    
    int totalQueries;
    int completedQueries;
    
    BOOL keyboardIsShown;
    
    //    NSMutableArray *itemListSectionsArray;
    //    NSMutableArray *itemItemizedSectionsArray;
    NSMutableArray *writeTaskAssignedToArray;
    
    NSString *twoCompOne;
    
    NSDate *date1;
    NSDate *date2;
    
    UIView *topView;
    UIButton *topViewCover;
    UILabel *topViewLabel;
    UIImageView *topViewImageView;
    
    UIView *lastCommentViewOverlayView;
    
    dispatch_once_t onceToken;
    dispatch_once_t onceTokenNo1;
    dispatch_once_t onceTokenNo2;
    
    NSMutableDictionary *premiumPlanPricesDict;
    NSMutableDictionary *premiumPlanExpensivePricesDict;
    NSMutableDictionary *premiumPlanPricesDiscountDict;
    NSMutableDictionary *premiumPlanPricesNoFreeTrialDict;
    NSMutableArray *premiumPlanProductsArray;
    
    float titleLabelHeight;
    float subLabelHeight;
    float alertLabelHeight;
    float primaryLabelSpacingHeight;
    float secondaryLabelSpacingHeight;
    float spacingBetweenCells;

    float maxSubLabelWidth;
    
}

@end

@implementation ViewTaskViewController

#pragma mark - System Methods

- (void)viewDidLoad {
    [super viewDidLoad];
   
    titleLabelHeight = (self.view.frame.size.height*0.02998501 > 20?(20):self.view.frame.size.height*0.02998501);
    subLabelHeight = (self.view.frame.size.height*0.02398801 > 16?(16):self.view.frame.size.height*0.02398801);
    alertLabelHeight = (self.view.frame.size.height*0.02398801 > 16?(16):self.view.frame.size.height*0.02398801);
    primaryLabelSpacingHeight = (self.view.frame.size.height*0.011994 > 8?(8):self.view.frame.size.height*0.011994);
    secondaryLabelSpacingHeight = (self.view.frame.size.height*0.005997 > 4?(4):self.view.frame.size.height*0.005997);
    spacingBetweenCells = (self.view.frame.size.height*0.017991 > 12?(12):self.view.frame.size.height*0.017991);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self FetchAvailableProducts];
        
    });
    
    onceToken = 0;
    onceTokenNo1 = 0;
    onceTokenNo2 = 0;
    
    NSLog(@"Viewing ItemID: %@ and ItemOccurrenceID: %@", _itemID, _itemOccurrenceID);
    
    [self InitMethod];
    
    [self BarButtonItems];
    
    [self NSNotificationObservers:NO];
    
    [self KeyboardNSNotifications];
    
    [self TapGestures];
    
    if (_itemDictFromPreviousPage[@"ItemID"]) {
        
        itemDict = [_itemDictFromPreviousPage mutableCopy];
        itemxxxOccurrencesDict = [_itemOccurrencesDict mutableCopy];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self SetDataGeneral:self->itemDict];
            [self UpdateViews];
            
        });
        
    } else {
        
        [self StartProgressView];
        
        [self QueryInitialData];
        
        [self QueryLastComment];
        
    }
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        return UIStatusBarStyleLightContent;
        
    } else {
        
        return UIStatusBarStyleDefault;
        
    }
    
}

-(void)viewDidLayoutSubviews {
    
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    
    CGFloat height = CGRectGetHeight(self.view.bounds);
    CGFloat width = CGRectGetWidth(self.view.bounds);
    
    CGFloat navigationBarHeight = [[[GeneralObject alloc] init] GetNavigationBarHeight:self];
    CGFloat bottomPadding = [[[GeneralObject alloc] init] GetBottomPaddingHeight];
    
    dispatch_once(&onceToken, ^{
        
        _customScrollView.frame = CGRectMake(-1, navigationBarHeight - 1, width + 1, 0);
        
        _customScrollView.layer.borderWidth = 1.0f;
        _customScrollView.layer.borderColor = (NonUserCellsVisible == YES && _viewingOccurrence == NO) ? [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModePrimary].CGColor : [UIColor colorWithRed:230.0f/255.0f green:232.0f/255.0f blue:236.0f/255.0f alpha:1.0f].CGColor : [UIColor clearColor].CGColor;
        
    });
    
    _viewItemView.frame = CGRectMake((width*0.5 - ((width*0.90338164)*0.5)), height*0.0271739, width*0.90338164, ((self.view.frame.size.height*0.11005435 > 81?(81):self.view.frame.size.height*0.11005435)*0.7037037));
    
    _viewRewardView.frame = CGRectMake((width*0.5 - ((width*0.90338164)*0.5)), _viewItemView.frame.origin.y + _viewItemView.frame.size.height + (self.view.frame.size.height*0.017991 > 12?(12):self.view.frame.size.height*0.017991), width*0.90338164, ((self.view.frame.size.height*0.11005435 > 81?(81):self.view.frame.size.height*0.11005435)*0.7037037));
    
    _viewPaymentMethodView.frame = CGRectMake((width*0.5 - ((width*0.90338164)*0.5)), _viewItemView.frame.origin.y + _viewItemView.frame.size.height + (self.view.frame.size.height*0.017991 > 12?(12):self.view.frame.size.height*0.017991), width*0.90338164, ((self.view.frame.size.height*0.11005435 > 81?(81):self.view.frame.size.height*0.11005435)*0.7037037));
    
//    _subTasksTableView.frame = CGRectMake(0, topView.frame.origin.y + (topView.frame.size.height) + (height*0.01494565 > 11?(11):height*0.01494565), width, 0);
//    
//    _customTableView.frame = CGRectMake(0, self->_subTasksTableView.frame.origin.y + (self->_subTasksTableView.frame.size.height), width, 0);
    
    _lastCommentView.frame = CGRectMake(0, height-((self.view.frame.size.height*0.09646739 > 71?(71):self.view.frame.size.height*0.09646739)+bottomPadding), width, (self.view.frame.size.height*0.09646739 > 71?(71):self.view.frame.size.height*0.09646739) + bottomPadding);
    
    _lastCommentNoCommentView.frame = _lastCommentView.frame;
    _lastCommentNoCommentView.layer.borderWidth = 1.0f;
    _lastCommentNoCommentView.layer.borderColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModePrimary].CGColor : [UIColor colorWithRed:230.0f/255.0f green:232.0f/255.0f blue:236.0f/255.0f alpha:1.0f].CGColor;
    
    dispatch_once(&onceTokenNo1, ^{
        
        CGRect frameToUse = _lastCommentNoCommentView.frame;
        
        if (NonUserCellsVisible == YES && _viewingOccurrence == NO) {
            frameToUse = _writeTaskContainerView.frame;
        } else {
            frameToUse = _lastCommentView.frame;
        }
        
        CGRect newRect = _customScrollView.frame;
        newRect.size.height = height - (height - frameToUse.origin.y) - navigationBarHeight;
        _customScrollView.frame = newRect;
        
        _customScrollView.layer.borderWidth = 1.0f;
        _customScrollView.layer.borderColor = (NonUserCellsVisible == YES && _viewingOccurrence == NO) ? [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModePrimary].CGColor : [UIColor colorWithRed:230.0f/255.0f green:232.0f/255.0f blue:236.0f/255.0f alpha:1.0f].CGColor : [UIColor clearColor].CGColor;
        
    });
    
    dispatch_once(&onceTokenNo2, ^{
        
        CGRect frameToUse = _lastCommentView.frame;
        
        if (NonUserCellsVisible == YES && _viewingOccurrence == NO) {
            frameToUse = _writeTaskContainerView.frame;
        } else {
            frameToUse = _lastCommentView.frame;
        }
        
        CGRect newRect = _customScrollView.frame;
        newRect.size.height = height - (height - frameToUse.origin.y) - navigationBarHeight;
        _customScrollView.frame = newRect;
        
        _customScrollView.layer.borderWidth = 1.0f;
        _customScrollView.layer.borderColor = (NonUserCellsVisible == YES && _viewingOccurrence == NO) ? [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModePrimary].CGColor : [UIColor colorWithRed:230.0f/255.0f green:232.0f/255.0f blue:236.0f/255.0f alpha:1.0f].CGColor : [UIColor clearColor].CGColor;
        
    });
    
    
    
    
    
    height = CGRectGetHeight(_subTasksTableView.bounds);
    width = CGRectGetWidth(_subTasksTableView.bounds);
    
    [self AdjustTableViewFrames];
    
    height = CGRectGetHeight(_customTableView.bounds);
    width = CGRectGetWidth(_customTableView.bounds);
    
    [self AdjustTableViewFrames];
    
    height = CGRectGetHeight(_viewItemView.bounds);
    width = CGRectGetWidth(_viewItemView.bounds);
    //374
    
    [self ViewItemViewInnerViews];
    
    height = CGRectGetHeight(_viewRewardView.bounds);
    width = CGRectGetWidth(_viewRewardView.bounds);
    //374
    
    [self ViewRewardViewInnerViews];
    
    height = CGRectGetHeight(_viewPaymentMethodView.bounds);
    width = CGRectGetWidth(_viewPaymentMethodView.bounds);
    //374
    
    [self ViewPaymentMethodViewInnerViews];
    
    [self AdjustTableViewFrames];
    
    
    
    
    
    width = CGRectGetWidth(self.lastCommentView.bounds);
    height = CGRectGetHeight(self.lastCommentView.bounds);
    //414, 71
    CGFloat heightWithoutBottomPadding = height - bottomPadding;
    
    _lastCommentViewProfileImage.frame = CGRectMake(width*0.01932367, heightWithoutBottomPadding*0.15492958, width*0.08454106, width*0.08454106);
    _lastCommentViewNameLabel.frame = CGRectMake(_lastCommentViewProfileImage.frame.origin.x + _lastCommentViewProfileImage.frame.size.width + width*0.01932367, _lastCommentViewProfileImage.frame.origin.y, 100, heightWithoutBottomPadding*0.28169014);
    _lastCommentViewTimeLabel.frame = CGRectMake(width - 75 - _lastCommentViewProfileImage.frame.origin.x, _lastCommentViewNameLabel.frame.origin.y, 75, _lastCommentViewNameLabel.frame.size.height);
    _lastCommentViewTextView.frame = CGRectMake(_lastCommentViewNameLabel.frame.origin.x, _lastCommentViewNameLabel.frame.origin.y + _lastCommentViewNameLabel.frame.size.height, width - (_lastCommentViewNameLabel.frame.origin.x*2), heightWithoutBottomPadding*0.45070423);
    _lastCommentPremiumImage.frame = CGRectMake(_lastCommentViewNameLabel.frame.origin.x + _lastCommentViewNameLabel.frame.size.width + 6, _lastCommentViewNameLabel.frame.origin.y, _lastCommentViewNameLabel.frame.size.height*0.7, _lastCommentViewNameLabel.frame.size.height);
    
    _lastCommentViewTextView.clipsToBounds = YES;
    _lastCommentViewTextView.layer.cornerRadius = 7;
    
    _lastCommentView.layer.borderWidth = 1.0f;
    _lastCommentView.layer.borderColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModePrimary].CGColor : [UIColor colorWithRed:230.0f/255.0f green:232.0f/255.0f blue:236.0f/255.0f alpha:1.0f].CGColor;
    
    lastCommentViewOverlayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _lastCommentView.frame.size.width, _lastCommentView.frame.size.height)];
    lastCommentViewOverlayView.backgroundColor = [UIColor clearColor];
    [_lastCommentView addSubview:lastCommentViewOverlayView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGestureActionPushToLiveChatViewController:)];
    [lastCommentViewOverlayView addGestureRecognizer:tapGesture];
    
    
    
    
    
    width = CGRectGetWidth(self.lastCommentNoCommentView.bounds);
    height = CGRectGetHeight(self.lastCommentNoCommentView.bounds);
    //414, 71
    
    _lastCommentNoCommentLabel.frame = CGRectMake(0, 0, width, height);
    _lastCommentNoCommentLabel.font = [UIFont systemFontOfSize:(self.view.frame.size.height*0.02011494) > 14?(14):(self.view.frame.size.height*0.02011494) weight:UIFontWeightSemibold];
    _lastCommentNoCommentLabel.adjustsFontSizeToFitWidth = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGestureActionPushToLiveChatViewController:)];
    [_lastCommentNoCommentView addGestureRecognizer:tapGesture];
    
    
    
    
    
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [[[LightDarkModeObject alloc] init] DarkModeTextPrimary]};
        self.customScrollView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        self.viewItemView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeTertiary];
        self.viewItemNameLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        self.viewItemitemDueDateLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextSecondary];
        self.viewPaymentMethodView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeTertiary];
        self.viewPaymentMethodNameLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        self.viewPaymentMethodDataLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextSecondary];
        self.writeTaskView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        self.writeTaskTextField.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        self.lastCommentView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeTertiary];
        self.lastCommentNoCommentView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeTertiary];
        self.customTableView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        self.subTasksTableView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        
        [self preferredStatusBarStyle];
        
    } else {
        
        _customTableView.backgroundColor = self.customScrollView.backgroundColor;
        _subTasksTableView.backgroundColor = self.customScrollView.backgroundColor;
        
    }
    
    self.writeTaskContainerView.backgroundColor = (NonUserCellsVisible == YES && _viewingOccurrence == NO) ? self.customScrollView.backgroundColor : [UIColor clearColor];
    self.view.backgroundColor = self.lastCommentNoCommentView.backgroundColor;
    self.navigationController.navigationBar.backgroundColor = self.customScrollView.backgroundColor;

}

-(void)viewWillAppear:(BOOL)animated {
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    CGFloat navigationBarHeight = [[[GeneralObject alloc] init] GetNavigationBarHeight:self];
    CGFloat bottomPadding = 0.0;
    
    UIWindow *currentwindow = [UIApplication sharedApplication].windows.firstObject;
    bottomPadding = currentwindow.safeAreaInsets.bottom;
    
    
    
    
    _notificationReminderView.frame = CGRectMake(0, 0, width, navigationBarHeight);
    
    _viewItemView.layer.cornerRadius = _viewItemView.frame.size.height/3;
    _viewRewardView.layer.cornerRadius = _viewRewardView.frame.size.height/3;
    _viewPaymentMethodView.layer.cornerRadius = _viewPaymentMethodView.frame.size.height/3;
    
    topView.hidden = NO;
    topViewCover.hidden = NO;
    
    
    
    
    _subTasksTableView.frame = CGRectMake(0, topView.frame.origin.y + (topView.frame.size.height) + (height*0.01494565 > 11?(11):height*0.01494565), width, 0);
    
    _customTableView.frame = CGRectMake(0, self->_subTasksTableView.frame.origin.y + (self->_subTasksTableView.frame.size.height), width, 0);
    
    
    
    
    _writeTaskContainerView.frame = CGRectMake(0, (height-((self.view.frame.size.height*0.09646739 > 71?(71):self.view.frame.size.height*0.09646739)+bottomPadding)) - (self.view.frame.size.height*0.09646739 > 71?(71):self.view.frame.size.height*0.09646739), width, (self.view.frame.size.height*0.09646739 > 71?(71):self.view.frame.size.height*0.09646739));
    _writeTaskContainerView.hidden = (NonUserCellsVisible == YES && _viewingOccurrence == NO) ? NO : YES;
    
    _writeTaskBackgroundView.alpha = 0.0f;
    _writeTaskBackgroundView.frame = CGRectMake(0, 0, width, height);
    
    
    
    
    
    
    
    
    
    width = CGRectGetWidth(self.writeTaskContainerView.bounds);
    height = CGRectGetHeight(self.writeTaskContainerView.bounds);
    
    self->_writeTaskView.frame = CGRectMake(width*0.5 - ((width*0.75)*0.5),
                                            height*0.5 - (self.view.frame.size.height*0.07744565 > 57?57:(self.view.frame.size.height*0.07744565))*0.5,
                                            width*0.75,
                                            (self.view.frame.size.height*0.07744565 > 57?57:(self.view.frame.size.height*0.07744565)));
    
    _writeTaskView.layer.cornerRadius = _writeTaskView.frame.size.height/3;
    
    _writeTaskView.layer.borderWidth = 0.0;
    _writeTaskView.layer.shadowColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeShadow].CGColor : [[[LightDarkModeObject alloc] init] LightModeShadow].CGColor;
    _writeTaskView.layer.shadowRadius = 5;
    _writeTaskView.layer.shadowOpacity = 1.0;
    _writeTaskView.layer.shadowOffset = CGSizeMake(0, 0);
    
    CAGradientLayer *viewLayer = [CAGradientLayer layer];
    viewLayer = [CAGradientLayer layer];
    [viewLayer setFrame:_writeTaskView.bounds];
    [_writeTaskView.layer insertSublayer:viewLayer atIndex:0];
    [_writeTaskView.layer addSublayer:viewLayer];
    
    
    
    width = CGRectGetWidth(self.writeTaskView.bounds);
    height = CGRectGetHeight(self.writeTaskView.bounds);
    
    [self ViewWriteTaskInnerViews];
    
}

-(void)viewDidAppear:(BOOL)animated {
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"SeenInstructionalCompletionPopup"]) {
        
        NSString *bodyString = @"";
        
        if (UserCellsVisible == YES) {
            
            bodyString = [NSString stringWithFormat:@"Mark off all home members"];
            
        } else if (NonUserCellsVisible == YES) {
            
            bodyString = [NSString stringWithFormat:@"Mark off all items"];
            
        }
        
        //[[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"SeenInstructionalCompletionPopup"];
        
    }
    
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [self->topView removeFromSuperview];
    
}

-(void)viewDidDisappear:(BOOL)animated {
    
    [self->topView removeFromSuperview];
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"View Task View Controller Scrolling"] completionHandler:^(BOOL finished) {
        
    }];
    
    [_writeTaskTextField resignFirstResponder];
    [_writeAssignedToTaskTextField resignFirstResponder];
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if ([_writeTaskTextField isFirstResponder]) {
        
        [self GenerateKeyBoardToolBar:YES Assigned:NO Reminder:NO];
        
    } else if ([_writeAssignedToTaskTextField isFirstResponder]) {
        
        [self GenerateKeyBoardToolBar:NO Assigned:YES Reminder:NO];
        
    }
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if ([_writeTaskTextField isFirstResponder]) {
        
        if (_writeAssignedToTaskTextField.text.length == 0 || [_writeAssignedToTaskTextField.text isEqualToString:[NSString stringWithFormat:@"%@0%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol]]) {
            [_writeAssignedToTaskTextField becomeFirstResponder];
        } else {
            [_writeTaskTextField resignFirstResponder];
            [_writeAssignedToTaskTextField resignFirstResponder];
        }
        
    } else if ([_writeAssignedToTaskTextField isFirstResponder]) {
        
        if ([itemType isEqualToString:@"List"]) {
            
            UIPickerView *datePicker = (UIPickerView *)[self.writeAssignedToTaskTextField inputView];
            [datePicker selectRow:[writeTaskAssignedToArray indexOfObject:@""] inComponent:0 animated:YES];
            
        }
        
        [_writeTaskTextField resignFirstResponder];
        [_writeAssignedToTaskTextField resignFirstResponder];
        
    }
    
    return YES;
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == _writeAssignedToTaskTextField) {
        
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
        
        return YES;
    }
    
    return YES;
}

-(BOOL)FormatAmountTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    textField.text = [[[GeneralObject alloc] init] FormatAmountTextField:textField.text replacementString:string];
    
    return NO;
    
}

#pragma mark - Keyboard Methods

- (void)keyboardWillShow:(NSNotification *)notification {
    
    if ([_writeTaskTextField isFirstResponder] || [_writeAssignedToTaskTextField isFirstResponder]) {
        
        if (_viewingViewExpenseViewController == YES && [_writeAssignedToTaskTextField.text isEqualToString:@""]) {
            _writeAssignedToTaskTextField.text = [NSString stringWithFormat:@"%@0%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol];
        }
        
        keyboardIsShown = true;
        
        [UIView animateWithDuration:0.25 animations:^{
            
            NSDictionary* keyboardInfo = [notification userInfo];
            NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
            CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
            CGFloat width = CGRectGetWidth(self.view.bounds);
            
            
            
            self->_writeTaskContainerView.backgroundColor = [UIColor clearColor];
            
            CGRect sendCoinsButton = self->_writeTaskContainerView.frame;
            
            sendCoinsButton.origin.y = CGRectGetHeight(self.view.bounds)-keyboardFrameBeginRect.size.height-self->_writeTaskContainerView.frame.size.height;
            sendCoinsButton.size.width = width;
            
            self->_writeTaskContainerView.frame = sendCoinsButton;
            
            
            
            sendCoinsButton = self->_writeTaskView.frame;
            
            sendCoinsButton.origin.x = width*0.5 - ((width*0.90338164)*0.5);
            sendCoinsButton.size.width = width*0.90338164;
            
            self->_writeTaskView.frame = sendCoinsButton;
            
            sendCoinsButton = self->_writeTaskView.frame;
            
            
            
            self->_writeTaskView.layer.cornerRadius = self->_writeTaskView.frame.size.height/3;
            self->_writeTaskBackgroundView.alpha = 0.75f;
            
            
            
            [self ViewWriteTaskInnerViews];
            
        }];
        
    }
    
}

- (void)keyboardWillHide:(NSNotification *)notification {
    
    keyboardIsShown = false;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        CGFloat width = CGRectGetWidth(self.view.bounds);
        CGFloat height = CGRectGetHeight(self.view.bounds);
        CGFloat bottomPadding = 0.0;
        
        UIWindow *currentwindow = [UIApplication sharedApplication].windows.firstObject;
        bottomPadding = currentwindow.safeAreaInsets.bottom;
        
        self->_writeTaskBackgroundView.alpha = 0.0f;
        self->_writeTaskContainerView.frame = CGRectMake(0, self->_lastCommentView.frame.origin.y - (self.view.frame.size.height*0.09646739 > 71?(71):self.view.frame.size.height*0.09646739), width, (self.view.frame.size.height*0.09646739 > 71?(71):self.view.frame.size.height*0.09646739));
        
        width = CGRectGetWidth(self.writeTaskContainerView.bounds);
        height = CGRectGetHeight(self.writeTaskContainerView.bounds);
        
        self->_writeTaskView.frame = CGRectMake(width*0.5 - ((width*0.75)*0.5),
                                                height*0.5 - (self.view.frame.size.height*0.07744565 > 57?57:(self.view.frame.size.height*0.07744565))*0.5,
                                                width*0.75,
                                                (self.view.frame.size.height*0.07744565 > 57?57:(self.view.frame.size.height*0.07744565)));
        
        [self ViewWriteTaskInnerViews];
        
    }];
    
}

#pragma mark - Image Picker Methods

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self->progressView setHidden:YES];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    
    
    [self StartProgressView];
    
    NSIndexPath *indexPath = [[[CompleteUncompleteObject alloc] init] GenerateTempIndexPath] ? [[[CompleteUncompleteObject alloc] init] GenerateTempIndexPath] : nil;
    NSString *markedObject = [self GenerateDataForSpeificItemAtIndex:indexPath];
    
    __block int totalQueries = 3;
    __block int completedQueries = 0;
    
    
    
    if ([markedObject length] > 0) {
        
        NSString *imageURL = [[[GeneralObject alloc] init] GeneratePhotoConfirmationImageURL:self->itemType itemUniqueID:self->itemUniqueID markedObject:markedObject];
        NSData *imgData = UIImageJPEGRepresentation(image, 0.15);
        
        NSMutableDictionary *tempDict = [self->itemPhotoConfirmationDict mutableCopy];
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        
        NSString *dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSString *dateString = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:dateFormat returnAs:[NSString class]];
        
        NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ?
        [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
        
        [dict setObject:userID forKey:@"Uploaded By"];
        [dict setObject:markedObject forKey:@"Marked Object"];
        [dict setObject:imageURL forKey:@"Image URL"];
        [dict setObject:dateString ? dateString : @"" forKey:@"Date Uploaded"];
        
        [tempDict setObject:dict forKey:markedObject];
        
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [[[SetDataObject alloc] init] UpdateDataItemPhotoConfirmationImage:self->itemUniqueID itemType:self->itemType markedObject:markedObject imgData:imgData completionHandler:^(BOOL finished) {
                
                if (totalQueries == (completedQueries+=1)) {
                    
                    [self UpdateAllDataInViewController:nil dictToUse:[@{@"ItemPhotoConfirmationDict" : tempDict} mutableCopy]];
                    
                }
                
            }];
            
        });
        
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [[[SetDataObject alloc] init] UpdateDataEditItem:@{@"ItemPhotoConfirmationDict" : tempDict} itemID:self->_itemID itemOccurrenceID:self->_itemOccurrenceID collection:self->itemTypeCollection homeID:self->homeID completionHandler:^(BOOL finished) {
                
                if (totalQueries == (completedQueries+=1)) {
                    
                    [self UpdateAllDataInViewController:nil dictToUse:[@{@"ItemPhotoConfirmationDict" : tempDict} mutableCopy]];
                    
                }
                
            }];
            
        });
        
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSMutableDictionary *singleObjectItemDict = [[[GeneralObject alloc] init] GenerateSingleObjectDictionary:[self->itemDict mutableCopy] keyArray:[self->keyArray mutableCopy] indexPath:nil];
            
            
            
            NSString *notificationType = [[[NotificationsObject alloc] init] NotificationSettingsUnknownItemType_Adding:NO Editing:NO Deleting:NO Duplicating:NO Waiving:NO Skipping:NO Pausing:NO Comments:NO
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
                                                                                                               itemType:self->itemType];
            
            
            
            NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
            
            
            
            NSString *notificationTitle = [NSString stringWithFormat:@"\"%@\"", self->itemName];
            NSString *notificationBody = [NSString stringWithFormat:@"%@ uploaded an image for this %@. 🙂", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"], [self->itemType lowercaseString]];
            
            
            
            NSMutableArray *usersToSendNotificationTo = [self->itemAssignedToArray mutableCopy];
            
            NSArray *addTheseUsers = @[self->itemCreatedBy];
            NSArray *removeTheseUsers = @[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx"];
            
            usersToSendNotificationTo = [[[[NotificationsObject alloc] init] AddAndRemoveSpecificUsersFromArray:usersToSendNotificationTo addTheseUsers:addTheseUsers removeTheseUsers:removeTheseUsers] mutableCopy];
            
            
            
            [[[NotificationsObject alloc] init] SendPushNotificationToArrayOfUsers_Items:usersToSendNotificationTo
                                                                               dictToUse:singleObjectItemDict
                                                                                  homeID:homeID homeMembersArray:self->_homeMembersArray homeMembersDict:self->_homeMembersDict
                                                                notificationSettingsDict:self->_notificationSettingsDict notificationItemType:self->itemType notificationType:notificationType
                                                                               topicDict:self->_topicDict
                                                                       allItemTagsArrays:self->_allItemTagsArrays
                                                                   pushNotificationTitle:notificationTitle pushNotificationBody:notificationBody
                                                                       notificationTitle:notificationTitle notificationBody:notificationBody
                                                                 SetDataHomeNotification:YES
                                                                    RemoveUsersNotInHome:YES
                                                                       completionHandler:^(BOOL finished) {
                
                if (totalQueries == (completedQueries+=1)) {
                    
                    //                    [self UpdateAllDataInViewController:nil dictToUse:[@{@"ItemPhotoConfirmationDict" : tempDict} mutableCopy]];
                    
                }
                
            }];
            
        });
        
    } else {
        
        [self->progressView setHidden:YES];
        
        [self.customTableView reloadData];
        
    }
    
}

#pragma mark - Photo Methods

-(void)openCamera {
    
    AVAuthorizationStatus authStatusCamera = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if (authStatusCamera == AVAuthorizationStatusAuthorized) {
        
        UIImagePickerController * picker = [[UIImagePickerController alloc] init];
        
        picker.delegate = self;
        
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:nil];
        
    } else if (authStatusCamera != AVAuthorizationStatusAuthorized) {
        
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            
            if (granted) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
                    
                    picker.delegate = self;
                    
                    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                    
                    [self presentViewController:picker animated:YES completion:nil];
                    
                });
                
            } else {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Oops 😪"
                                                                                        message:@"In order upload a profile picture you must allow access to your camera 📷"
                                                                                 preferredStyle:UIAlertControllerStyleAlert];
                    
                    
                    UIAlertAction *gotit = [UIAlertAction actionWithTitle:@"Sure"
                                                                    style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * _Nonnull action) {
                        
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:^(BOOL success) {
                            
                            [self->progressView setHidden:YES];
                            
                        }];
                        
                    }];
                    
                    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Nevermind"
                                                                     style:UIAlertActionStyleCancel
                                                                   handler:^(UIAlertAction * _Nonnull action) {
                        
                        [self->progressView setHidden:YES];
                        
                    }];
                    
                    [controller addAction:cancel];
                    [controller addAction:gotit];
                    [self presentViewController:controller animated:YES completion:nil];
                    
                });
                
            }
            
        }];
        
    }
    
}

-(void)openPhotoLibrary {
    
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    
    if (status == PHAuthorizationStatusAuthorized) {
        
        UIImagePickerController * picker = [[UIImagePickerController alloc] init];
        
        picker.delegate = self;
        
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        
        [self presentViewController:picker animated:YES completion:nil];
        
    } else if (status != PHAuthorizationStatusAuthorized) {
        
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            
            if (status == PHAuthorizationStatusAuthorized) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
                    
                    picker.delegate = self;
                    
                    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                    
                    [self presentViewController:picker animated:YES completion:nil];
                    
                });
                
            } else {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Oops 😪"
                                                                                        message:@"In order to upload a profile picture you must allow access to your photo library 💾"
                                                                                 preferredStyle:UIAlertControllerStyleAlert];
                    
                    
                    UIAlertAction *gotit = [UIAlertAction actionWithTitle:@"Sure thing"
                                                                    style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * _Nonnull action) {
                        
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:^(BOOL success) {
                            
                            [self->progressView setHidden:YES];
                            
                        }];
                        
                    }];
                    
                    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Nevermind"
                                                                     style:UIAlertActionStyleCancel
                                                                   handler:^(UIAlertAction * _Nonnull action) {
                        
                        [self->progressView setHidden:YES];
                        
                    }];
                    
                    [controller addAction:cancel];
                    [controller addAction:gotit];
                    [self presentViewController:controller animated:YES completion:nil];
                    
                });
                
            }
            
        }];
        
    }
    
}

#pragma mark - Picker View Methods

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    NSInteger the_tag = [pickerView tag];
    
    if (the_tag == 1) {
        
        if (component == 0) {
            
            return [writeTaskAssignedToArray count];
            
        }
        
    } else if (the_tag == 2) {
        
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
            
            return [writeTaskAssignedToArray objectAtIndex:row];
            
        }
        
    } else if (the_tag == 2) {
        
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
            
            return [@[@"Before"] objectAtIndex:row];
            
        }
        
    }
    
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    NSInteger the_tag = [pickerView tag];
    
    if (the_tag == 1) {
        
        if (component == 0) {
            
            twoCompOne = [writeTaskAssignedToArray objectAtIndex:row];
            
        }
        
        if (twoCompOne == nil) {
            twoCompOne = @"Anybody";
        }
        
        if (twoCompOne.length > 0) {
            
            _writeAssignedToTaskTextField.text = [NSString stringWithFormat:@"%@", twoCompOne];
            
        } else {
            
            _writeAssignedToTaskTextField.text = @"Anybody";
            twoCompOne = @"Anybody";
            
        }
        
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
        
    }
    
    return 0;
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    NSInteger the_tag = [pickerView tag];
    
    if (the_tag == 1) {
        return 1;
    } else if (the_tag == 2) {
        return 3;
    }
    
    return 3;
}

#pragma mark - Init Methods

-(void)InitMethod {
    
    [self SetUpAnalytics];
    
    [self SetUpLocalCurrencySymbol];
    
    [self SetUpArrays];
    
    [self SetUpItemType];
    
    [self SetUpSectionsArray];
    
    [self SetUpKeyArray];
    
    [self SetUpTableView];
    
    [self SetUpInitUI];
    
    [self SetUpTextFields];
    
    [self SetUpViewsHidden];
    
    [self SetUpTopView];
    
}

-(void)BarButtonItems {
    
    self.navigationItem.hidesBackButton = YES;
    
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(NavigationBackButtonAction:)];
    self.navigationItem.leftBarButtonItem = newBackButton;
    
    UIBarButtonItem *rightBackButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ViewTaskActivity"] style:UIBarButtonItemStylePlain target:self action:@selector(TapGestureActionPushToViewActivityViewController:)];
    self.navigationItem.rightBarButtonItem = rightBackButton;
    
}

-(void)TapGestures {
    
    UITapGestureRecognizer *tapGesture;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(DismissAllKeyboards)];
    [_writeTaskBackgroundView addGestureRecognizer:tapGesture];
    _writeTaskBackgroundView.userInteractionEnabled = YES;
    
}

-(void)NSNotificationObservers:(BOOL)RemoveOnly {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_ViewTask_AddHomeMember" object:nil];
    if (RemoveOnly == NO) { [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_ViewTask_AddHomeMember:) name:@"NSNotification_ViewTask_AddHomeMember" object:nil]; }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_ViewTask_EditTask" object:nil];
    if (RemoveOnly == NO) { [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_ViewTask_EditTask:) name:@"NSNotification_ViewTask_EditTask" object:nil]; }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_ViewTask_ReloadTask" object:nil];
    if (RemoveOnly == NO) { [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_ViewTask_ReloadTask:) name:@"NSNotification_ViewTask_ReloadTask" object:nil]; }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_ViewTask_CompletedReset" object:nil];
    if (RemoveOnly == NO) { [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_ViewTask_CompletedReset:) name:@"NSNotification_ViewTask_CompletedReset" object:nil]; }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_ViewTask_ItemTags" object:nil];
    if (RemoveOnly == NO) { [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_ViewTask_ItemTags:) name:@"NSNotification_ViewTask_ItemTags" object:nil]; }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_ViewTask_ItemReward" object:nil];
    if (RemoveOnly == NO) { [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_ViewTask_ItemReward:) name:@"NSNotification_ViewTask_ItemReward" object:nil]; }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_ViewTask_ItemPaymentMethod" object:nil];
    if (RemoveOnly == NO) { [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_ViewTask_ItemPaymentMethod:) name:@"NSNotification_ViewTask_ItemPaymentMethod" object:nil]; }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_ViewTask_ItemCustomReminder" object:nil];
    if (RemoveOnly == NO) { [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_ViewTask_ItemCustomReminder:) name:@"NSNotification_ViewTask_ItemCustomReminder" object:nil]; }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_ViewTask_ItemComments" object:nil];
    if (RemoveOnly == NO) { [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_ViewTask_ItemComments:) name:@"NSNotification_ViewTask_ItemComments" object:nil]; }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_ViewTask_AddTaskToTaskList" object:nil];
    if (RemoveOnly == NO) { [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_ViewTask_AddTaskToTaskList:) name:@"NSNotification_ViewTask_AddTaskToTaskList" object:nil]; }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_ViewTask_RemoveTaskFromTaskList" object:nil];
    if (RemoveOnly == NO) { [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_ViewTask_RemoveTaskFromTaskList:) name:@"NSNotification_ViewTask_RemoveTaskFromTaskList" object:nil]; }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_ViewTask_RemoveTaskFromAllTaskLists" object:nil];
    if (RemoveOnly == NO) { [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_ViewTask_RemoveTaskFromAllTaskLists:) name:@"NSNotification_ViewTask_RemoveTaskFromAllTaskLists" object:nil]; }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_ViewTask_MoveTaskToDifferentTaskList" object:nil];
    if (RemoveOnly == NO) { [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_ViewTask_MoveTaskToDifferentTaskList:) name:@"NSNotification_ViewTask_MoveTaskToDifferentTaskList" object:nil]; }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_ViewTask_AddOrEditTaskList" object:nil];
    if (RemoveOnly == NO) { [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_ViewTask_AddOrEditTaskList:) name:@"NSNotification_ViewTask_AddOrEditTaskList" object:nil]; }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_ViewTask_AddOrEditItemTemplate" object:nil];
    if (RemoveOnly == NO) { [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_ViewTask_AddOrEditItemTemplate:) name:@"NSNotification_ViewTask_AddOrEditItemTemplate" object:nil]; }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_ViewTask_AddOrEditItemDraft" object:nil];
    if (RemoveOnly == NO) { [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_ViewTask_AddOrEditItemDraft:) name:@"NSNotification_ViewTask_AddOrEditItemDraft" object:nil]; }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_ViewTask_ItemWeDivvyPremiumAccounts" object:nil];
    if (RemoveOnly == NO) { [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_ViewTask_ItemWeDivvyPremiumAccounts:) name:@"NSNotification_ViewTask_ItemWeDivvyPremiumAccounts" object:nil]; }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_ViewTask_ItemMutedNotifications" object:nil];
    if (RemoveOnly == NO) { [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_ViewTask_ItemMutedNotifications:) name:@"NSNotification_ViewTask_ItemMutedNotifications" object:nil]; }
    
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

-(void)QueryInitialData {
    
    totalQueries = 7;
    completedQueries = 0;
    
    [self GetDataItem:^(BOOL finished) {
        
        [self SetQueriedData];
        
    }];
    
    [self GetDataItemOccurrences:^(BOOL finished) {
        
        [self SetQueriedData];
        
    }];
    
    [self GetDataUserData:^(BOOL finished) {
        
        [self SetQueriedData];
        
    }];
    
    [self GetDataNotificationSettings:^(BOOL finished) {
        
        [self SetQueriedData];
        
    }];
    
    [self GetDataTaskLists:^(BOOL finished) {
        
        [self SetQueriedData];
        
    }];
    
    [self GetDataFolders:^(BOOL finished) {
        
        [self SetQueriedData];
        
    }];
    
    //    [self GetDataSections:^(BOOL finished) {
    
    [self SetQueriedData];
    
    //    }];
    
}

-(void)QueryLastComment {
    
    NSArray *messageKeyArray = [[[GeneralObject alloc] init] GenerateMessageKeyArray];
    NSString *chatID = _itemID;
    NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
    
    [[[GetDataObject alloc] init] GetDataLastMessageInSpecificChat:userID homeID:homeID itemType:itemType itemID:_itemID chatID:chatID keyArray:messageKeyArray viewingGroupChat:NO viewingComments:YES viewingLiveSupport:NO completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningMessageDict) {
        
        [self GenerateLastCommentFrames:returningMessageDict messageKeyArray:messageKeyArray];
        
    }];
    
}

#pragma mark - Setup Methods

-(void)SetUpAnalytics {
    
    [[[GeneralObject alloc] init] TrackInMixPanel:@"ViewTaskViewController"];
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewViewController:@"ViewTaskViewController" completionHandler:^(BOOL finished) {
        
    }];
    
    self->ViewingAnalytics = NO;
    self->_viewItemitemDueDateLabel.alpha = 1.0f;
    self->_progressBarOne.alpha = 0.0f;
    self->_progressBarTwo.alpha = 0.0f;
    self->_percentageLabel.alpha = 0.0f;
    
}

-(void)SetUpLocalCurrencySymbol {
    
    localCurrencySymbol = [[[GeneralObject alloc] init] GenerateLocalCurrencySymbol];
    localCurrencyDecimalSeparatorSymbol = [[[GeneralObject alloc] init] GenerateLocalCurrencyDecimalSeparatorSymbol];
    localCurrencyNumberSeparatorSymbol = [[[GeneralObject alloc] init] GenerateLocalCurrencyNumberSeparatorSymbol];
    
}

-(void)SetUpSectionsArray {
    
    if (NonUserCellsVisible == YES) {
        
        self->sectionsArray = @[@"UNCOMPLETED", @"IN PROGRESS", @"COMPLETED", @"WONT DO"];
        
    } else {
        
        sectionsArray = @[@"COMPLETED", @"IN PROGRESS", @"UNCOMPLETED", @"NOT THEIR TURN", @"WONT DO"];
        
    }
    
}

-(void)SetUpArrays {
    
    self->itemItemizedItems = [NSMutableDictionary dictionary];
    self->itemPhotoConfirmationDict = [NSMutableDictionary dictionary];
    self->itemApprovalRequestsDict = [NSMutableDictionary dictionary];
    self->itemPaymentMethodDict = [NSMutableDictionary dictionary];
    self->itemRewardDict = [NSMutableDictionary dictionary];
    self->itemSpecificDueDatesArray = [NSMutableArray array];
    self->itemAssignedToArray = [NSMutableArray array];
    self->itemAssignedUsernameArray = [NSMutableArray array];
    self->itemAssignedProfileImageURLArray = [NSMutableArray array];
    self->totalCompletedArray = [NSMutableArray array];
    self->totalCompletedSubTaskArray = [NSMutableArray array];
    self->itemCompletedDict = [NSMutableDictionary dictionary];
    self->itemInProgressDict = [NSMutableDictionary dictionary];
    self->itemWontDoDict = [NSMutableDictionary dictionary];
    self->itemAdditionalRemindersDict = [NSMutableDictionary dictionary];
    self->itemDueDatesSkippedArray = [NSMutableArray array];
    self->frequencyReminderFrequencyArray = [NSMutableArray array];
    self->frequencyReminderAmountArray = [NSMutableArray array];
    
}

-(void)SetUpItemType {
    
    homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
    homeName = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeName"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeName"] : @"xxx";
    
    if (_viewingViewExpenseViewController) {
        
        itemType = @"Expense";
        itemTypeCollection = @"Expenses";
        
    } else if (_viewingViewListViewController) {
        
        itemType = @"List";
        itemTypeCollection = @"Lists";
        
    } else {
        
        itemType = @"Chore";
        itemTypeCollection = @"Chores";
        
    }
    
}

-(void)SetUpKeyArray {
    
    keyArray = [[[GeneralObject alloc] init] GenerateKeyArray];
    
}

-(void)SetUpTableView {
    
    _customScrollView.delegate = self;
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectZero];
    footer.backgroundColor = self.view.backgroundColor;
    self->_customTableView.tableFooterView = footer;
    
    _customTableView.delegate = self;
    _customTableView.dataSource = self;
    
    footer = [[UIView alloc] initWithFrame:CGRectZero];
    footer.backgroundColor = self.view.backgroundColor;
    self->_subTasksTableView.tableFooterView = footer;
    
    _subTasksTableView.delegate = self;
    _subTasksTableView.dataSource = self;
    
}

-(void)SetUpInitUI {
    
    _viewItemNameLabel.text = @"";
    _viewItemitemDueDateLabel.text = @"";
    
}

-(void)SetUpTextFields {
    
    _writeTaskTextField.delegate = self;
    _writeAssignedToTaskTextField.delegate = self;
    
    if (_viewingViewListViewController) {
        
        UIPickerView *pickerView;
        
        pickerView = [[UIPickerView alloc] init];
        pickerView.delegate = self;
        pickerView.tag = 1;
        [self.writeAssignedToTaskTextField setInputView:pickerView];
        
    } else {
        
        self.writeAssignedToTaskTextField.keyboardType = UIKeyboardTypeNumberPad;
        self.writeAssignedToTaskTextField.placeholder = @"Amount";
        
    }
    
}

-(void)SetUpViewsHidden {
    
    _viewPaymentMethodView.hidden = YES;
    _viewRewardView.hidden = YES;
    _writeTaskView.hidden = YES;
    _lastCommentView.hidden = YES;
    //    _viewItemItemPriorityImage.hidden = YES;
    _viewItemItemPrivateImage.hidden = YES;
    _viewItemItemMutedImage.hidden = YES;
    _viewItemItemReminderImage.hidden = YES;
    
}

-(void)SetUpTopView {
    
    topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, self.navigationController.navigationBar.frame.size.height)];
    topViewCover = [[UIButton alloc] initWithFrame:topView.frame];
    
    topViewImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 8.5, self.navigationController.navigationBar.frame.size.height)];
    topViewImageView.image = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [UIImage imageNamed:@"down.white.arrow"] : [UIImage imageNamed:@"GeneralIcons.TopLabelArrow"];
    topViewImageView.contentMode = UIViewContentModeScaleAspectFit;
    topViewImageView.hidden = YES;
    
    topViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [[[GeneralObject alloc] init] WidthOfString:@"" withFont:[UIFont systemFontOfSize:15 weight:UIFontWeightSemibold]], topView.frame.size.height)];
    topViewLabel.text = @"";
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
    
    [self SetUpTopLabelContextMenu];
    
}

-(void)SetUpDefaultFrequency {
    
    frequencyReminderAmountArray = [[NSMutableArray alloc] init];
    
    for (int i=1;i<61;i++) {
        [frequencyReminderAmountArray addObject:[NSString stringWithFormat:@"%d", i]];
    }
    
    [self GenerateReminderFrequencyArray];
    
}

#pragma mark

-(void)SetUpItemViewContextMenu {
    
    [[UNUserNotificationCenter currentNotificationCenter] getPendingNotificationRequestsWithCompletionHandler:^(NSArray<UNNotificationRequest *> *requests){
        
        NSMutableArray *identifierArray = [NSMutableArray array];
        
        for (UNNotificationRequest *str in requests) {
            
            [identifierArray addObject:str.identifier];
            
        }
        
        NSMutableArray *contextMenuItemDataActions = [[NSMutableArray alloc] init];
        NSMutableArray *contextMenuItemMainActions = [self ItemViewContextMenuMainActions];
        NSMutableArray *contextMenuItemRepeatingActions = [self ItemViewContextMenuRepeatingActions];
        NSMutableArray *contextMenuItemDetailsActions = [self ItemViewContextMenuDetailsActions];
        NSMutableArray *contextMenuItemOtherActions = [self ItemViewContextMenuOtherActions];
        NSMutableArray *contextMenuItemShareActions = [self ItemViewContextMenuShareActions];
        NSMutableArray *contextMenuItemTrashActions = [self ItemViewContextMenuTrashActions];
        
        
        UIMenu *itemDetailActionsInlineMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"Main" options:UIMenuOptionsDisplayInline children:contextMenuItemMainActions];
        if (@available(iOS 16.0, *)) {
            itemDetailActionsInlineMenu.preferredElementSize = UIMenuElementSizeMedium;
        }
        [contextMenuItemDataActions addObject:itemDetailActionsInlineMenu];
        
        UIMenu *itemRepeatingActionsInlineMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"Repeating" options:UIMenuOptionsDisplayInline children:contextMenuItemRepeatingActions];
        [contextMenuItemDataActions addObject:itemRepeatingActionsInlineMenu];
        
        UIMenu *itemDetailsActionsInlineMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"Details" options:UIMenuOptionsDisplayInline children:contextMenuItemDetailsActions];
        [contextMenuItemDataActions addObject:itemDetailsActionsInlineMenu];
        
        UIMenu *itemOtherActionsInlineMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"Comment, Duplicate" options:UIMenuOptionsDisplayInline children:contextMenuItemOtherActions];
        [contextMenuItemDataActions addObject:itemOtherActionsInlineMenu];
        
        UIMenu *itemReminderActionsInlineMenu = [self ItemContextMenuReminderActionsMenu:identifierArray];
        [contextMenuItemDataActions addObject:itemReminderActionsInlineMenu];
        
        UIMenu *itemShareActionsInlineMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"Share" options:UIMenuOptionsDisplayInline children:contextMenuItemShareActions];
        [contextMenuItemDataActions addObject:itemShareActionsInlineMenu];
        
        UIMenu *itemTrashActionsInlineMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"Trash" options:UIMenuOptionsDisplayInline children:contextMenuItemTrashActions];
        [contextMenuItemDataActions addObject:itemTrashActionsInlineMenu];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self->_viewItemViewOverlay.menu = [UIMenu menuWithTitle:@"" children:contextMenuItemDataActions];
            self->_viewItemViewOverlay.showsMenuAsPrimaryAction = true;
            
        });
        
    }];
    
}

-(void)SetUpItemPaymentMethodContextMenu {
    
    NSMutableArray* actions = [[NSMutableArray alloc] init];
    
    UIAction *openPaymentMethodAction = [self ItemPaymentMethodContextMenuOpenPaymentMethodAction];
    UIAction *copyUsernameAction = [self ItemPaymentMethodContextMenuCopyUsernameAction];
    
    UIMenu *inlineMenu = [self ItemPaymentMethodContextMenuInlineMenu];
    
    if (openPaymentMethodAction.title.length > 0) { [actions addObject:openPaymentMethodAction]; }
    if (copyUsernameAction.title.length > 0) { [actions addObject:openPaymentMethodAction]; }
    
    if ([inlineMenu.children count] > 0) { [actions addObject:inlineMenu]; }
    
    _viewPaymentMethodViewOverlay.menu = [UIMenu menuWithTitle:@"" children:actions];
    _viewPaymentMethodViewOverlay.showsMenuAsPrimaryAction = true;
    
}

-(void)SetUpItemRewardContextMenu {
    
    NSMutableArray* contextMenuActions = [[NSMutableArray alloc] init];
    
    BOOL TaskIsCreatedByMe = [itemCreatedBy isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
    BOOL TaskIsAssignedToCreator = [_homeMembersDict[@"UserID"] containsObject:itemCreatedBy];
    
    if (TaskIsCreatedByMe == YES ||
        TaskIsAssignedToCreator == NO) {
        
        UIAction *editAction = [self ItemRewardContextMenuEditAction];
        [contextMenuActions addObject:editAction];
        
        UIAction *deleteAction = [self ItemRewardContextMenuDeleteAction];
        [contextMenuActions addObject:deleteAction];
        
    }
    
    _viewRewardViewOverlay.menu = [UIMenu menuWithTitle:@"" children:contextMenuActions];
    _viewRewardViewOverlay.showsMenuAsPrimaryAction = true;
    
}

-(void)SetUpUserItemContextMenu:(NSIndexPath *)indexPath cell:(ViewTaskCell *)cell {
    
    NSMutableArray *contextMenuActions = [[NSMutableArray alloc] init];
    NSMutableArray *contextMenuMarkingActions = [[NSMutableArray alloc] init];
    NSMutableArray *contextMenuUserActions = [[NSMutableArray alloc] init];
    NSMutableArray *contextMenuPhotoConfirmationActions = [[NSMutableArray alloc] init];
    NSMutableArray *contextMenuUploadImageActions = [[NSMutableArray alloc] init];
    
    UIAction *completedUncompleteAction = [self UserItemContextMenuCompleteUncompleteAction:indexPath];
    UIAction *inProgressNotInProgressAction = [self UserItemContextMenuInProgressNotInProgressAction:indexPath];
    UIAction *wontDoAction = [self UserItemContextMenuWontDoAction:indexPath];
    
    UIAction *skipTurnAction = [self UserItemContextMenuSkipTurnAction:indexPath];
    UIAction *remindAction = [self UserItemContextMenuRemindAction:indexPath];
    UIAction *removeAction = [self UserItemContextMenuRemoveAction:indexPath];
    
    UIAction *cameraAction = [self UserItemContextMenuCameraAction:indexPath];
    UIAction *photoLibaryAction = [self UserItemContextMenuPhotoLibraryAction:indexPath];
    UIAction *viewImageAction = [self UserItemContextMenuViewImageAction:indexPath];
    UIAction *noPhotoAction = [self UserItemContextMenuNoPhotoAction:indexPath];
    
    if (removeAction.title.length > 0) { [contextMenuUserActions addObject:removeAction]; }
    if (remindAction.title.length > 0) { [contextMenuUserActions addObject:remindAction]; }
    if (skipTurnAction.title.length > 0) { [contextMenuUserActions addObject:skipTurnAction]; }
    
    if (noPhotoAction.title.length > 0) { [contextMenuPhotoConfirmationActions addObject:noPhotoAction]; }
    if (viewImageAction.title.length > 0) { [contextMenuPhotoConfirmationActions addObject:viewImageAction]; }
    
    if (photoLibaryAction.title.length > 0) { [contextMenuUploadImageActions addObject:photoLibaryAction]; }
    if (cameraAction.title.length > 0) { [contextMenuUploadImageActions addObject:cameraAction]; }
    
    
    
    UIMenu *inlineUserActionsMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"" options:UIMenuOptionsDisplayInline children:contextMenuUserActions];
    if (contextMenuUserActions.count > 0) { [contextMenuActions addObject:inlineUserActionsMenu]; }
    
    
    //Post-Spike
    BOOL ViewImageActionIsAvailable = viewImageAction.title.length > 0;
    UIMenu *inlineUploadImageActionsMenu = [UIMenu menuWithTitle:ViewImageActionIsAvailable ? @"Update Image" : @"Upload Image" image:[UIImage systemImageNamed:@"photo.on.rectangle"] identifier:@"" options:0 children:contextMenuUploadImageActions];
    if (contextMenuUploadImageActions.count > 0) { [contextMenuPhotoConfirmationActions addObject:inlineUploadImageActionsMenu]; }
    
    UIMenu *inlinePhotoConfirmationActionsMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"" options:UIMenuOptionsDisplayInline children:contextMenuPhotoConfirmationActions];
    if (contextMenuPhotoConfirmationActions.count > 0) { [contextMenuActions addObject:inlinePhotoConfirmationActionsMenu]; }
    
    
    
    if (wontDoAction.title.length > 0) { [contextMenuMarkingActions addObject:wontDoAction]; }
    if (inProgressNotInProgressAction.title.length > 0) { [contextMenuMarkingActions addObject:inProgressNotInProgressAction]; }
    
    
    
    NSDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:itemAssignedToArray[indexPath.row] homeMembersDict:_homeMembersDict];
    NSString *username = dataDict[@"Username"];
    NSString *userID = dataDict[@"UserID"];
    
    if ([userID isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]]) {
        
        if (completedUncompleteAction.title.length > 0) { [contextMenuMarkingActions addObject:completedUncompleteAction]; }
        
    } else {
        
        NSDictionary *completedMenuDict = [self UserItemContextMenuCompleteMenu:indexPath username:username];
        UIMenu *completedForMenu = completedMenuDict[@"CompletedForMenu"];
        UIMenu *markingForMenu = completedMenuDict[@"MarkingForMenu"];
        
        UIMenu *completedMenu = [UIMenu menuWithTitle:@"Complete" image:[[UIImage systemImageNamed:@"checkmark"] imageWithTintColor:[UIColor systemGreenColor] renderingMode:UIImageRenderingModeAlwaysOriginal] identifier:@"Completed" options:0 children:@[completedForMenu, markingForMenu]];
        [contextMenuMarkingActions addObject:completedMenu];
        
    }
    
    UIMenu *contextMenuMarkingMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"Marking" options:UIMenuOptionsDisplayInline children:contextMenuMarkingActions];
    if (@available(iOS 16.0, *)) {
        contextMenuMarkingMenu.preferredElementSize = UIMenuElementSizeMedium;
    }
    if (contextMenuMarkingActions.count > 0) { [contextMenuActions addObject:contextMenuMarkingMenu]; }
    
    
    
    cell.ellipsisImageOverlay.menu = [UIMenu menuWithTitle:@"" children:contextMenuActions];
    cell.ellipsisImageOverlay.showsMenuAsPrimaryAction = true;
    
}

-(void)SetUpSomeoneElseContextMenu:(NSIndexPath *)indexPath cell:(ViewTaskCell *)cell {
    
    NSMutableArray *contextMenuActions = [[NSMutableArray alloc] init];
    
    NSDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:itemAssignedToArray[indexPath.row] homeMembersDict:_homeMembersDict];
    NSString *username = dataDict[@"Username"];
    
    NSDictionary *completedMenuDict = [self UserItemContextMenuCompleteMenu:indexPath username:username];
    UIMenu *completedForMenu = completedMenuDict[@"CompletedForMenu"];
    UIMenu *markingForMenu = completedMenuDict[@"MarkingForMenu"];
    
    [contextMenuActions addObject:completedForMenu];
    [contextMenuActions addObject:markingForMenu];
    
    cell.mainViewOverlay.menu = [UIMenu menuWithTitle:@"" children:contextMenuActions];
    cell.mainViewOverlay.showsMenuAsPrimaryAction = true;
    
}

-(void)SetUpNonUserItemContextMenu:(NSIndexPath *)indexPath cell:(ViewTaskCell *)cell tableView:(UITableView *)tableView {
    
    NSMutableArray *contextMenuActions = [[NSMutableArray alloc] init];
    NSMutableArray *contextMenuMarkingActions = [[NSMutableArray alloc] init];
    NSMutableArray *contextMenuNonUserActions = [[NSMutableArray alloc] init];
    
    UIAction *completedUncompleteAction = [self NonUserItemContextMenuCompleteUncompleteAction:indexPath tableView:tableView];
    UIAction *inProgressNotInProgressAction = [self NonUserItemContextMenuInProgressNotInProgressAction:indexPath tableView:tableView];
    UIAction *wontDoAction = [self NonUserItemContextMenuWontDoAction:indexPath tableView:tableView];
    
    UIAction *deleteAction = [self NonUserItemContextMenuDeleteAction:indexPath tableView:tableView];
    UIAction *editAction = [self NonUserItemContextMenuEditAction:indexPath tableView:tableView];
    
    if (deleteAction.title.length > 0) { [contextMenuNonUserActions addObject:deleteAction]; }
    if (editAction.title.length > 0) { [contextMenuNonUserActions addObject:editAction]; }
    
    UIMenu *inlineNonUserActionsMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"" options:UIMenuOptionsDisplayInline children:contextMenuNonUserActions];
    if (contextMenuNonUserActions.count > 0) { [contextMenuActions addObject:inlineNonUserActionsMenu]; }
    
    if (wontDoAction.title.length > 0) { [contextMenuMarkingActions addObject:wontDoAction]; }
    if (inProgressNotInProgressAction.title.length > 0) { [contextMenuMarkingActions addObject:inProgressNotInProgressAction]; }
    if (completedUncompleteAction.title.length > 0) { [contextMenuMarkingActions addObject:completedUncompleteAction]; }
    
    UIMenu *contextMenuMarkingMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"Marking" options:UIMenuOptionsDisplayInline children:contextMenuMarkingActions];
    if (@available(iOS 16.0, *)) {
        contextMenuMarkingMenu.preferredElementSize = UIMenuElementSizeMedium;
    }
    if (contextMenuMarkingActions.count > 0) { [contextMenuActions addObject:contextMenuMarkingMenu]; }
    
    cell.ellipsisImageOverlay.menu = [UIMenu menuWithTitle:@"" children:contextMenuActions];
    cell.ellipsisImageOverlay.showsMenuAsPrimaryAction = true;
    
}

-(void)SetUpTopLabelContextMenu {
    
    NSMutableArray *actions = [NSMutableArray array];
    
    
    
    NSMutableArray *taskListActions = [NSMutableArray array];
    
    for (NSString *taskListName in _taskListDict[@"TaskListName"]) {
        
        UIAction *taskListAction = [self TaskListItemContextMenuTaskListAction:taskListName];
        
        [taskListActions addObject:taskListAction];
        
    }
    
    UIMenu *taskListActionsMenu = [self TaskListItemContextMenuTaskListActionsMenu:taskListActions];
    
    [actions addObject:taskListActionsMenu];
    
    
    
    NSMutableArray *suggestedTaskListActions = [NSMutableArray array];
    
    NSArray *arrayToUse = [[[GeneralObject alloc] init] GenerateSuggestedTaskListArray:itemType];
    
    for (NSString *taskListName in arrayToUse) {
        
        UIAction *taskListAction = [self TaskListItemContextMenuSuggestedTaskListAction:taskListName];
        
        [suggestedTaskListActions addObject:taskListAction];
        
    }
    
    UIMenu *suggestedTaskListActionsMenu = [self TaskListItemContextMenuSuggestedTaskListActionsMenu:suggestedTaskListActions arrayToUse:arrayToUse];
    
    [actions addObject:suggestedTaskListActionsMenu];
    
    
    
    
    NSMutableArray *newTaskListMenuActions = [NSMutableArray array];
    
    UIAction *newTaskListAction = [self TaskListItemContextMenuNewTaskListAction];
    [newTaskListMenuActions addObject:newTaskListAction];
    
    UIMenu *newTaskListActionsMenu = [self TaskListItemContextMenuNewTaskListActionsMenu:newTaskListMenuActions];
    
    [actions addObject:newTaskListActionsMenu];
    
    
    
    
    NSMutableArray *deleteListMenuActions = [NSMutableArray array];
    
    UIAction *noTaskListAction = [self TaskListItemContextMenuNoTaskListAction];
    [deleteListMenuActions addObject:noTaskListAction];
    
    UIMenu *noTaskListActionsMenu = [self TaskListItemContextMenuNoTaskListActionsMenu:deleteListMenuActions];
    
    [actions addObject:noTaskListActionsMenu];
    
    
    
    
    NSString *menuTitle = @"";
    
    if (actions.count - 2 == 0) {
        menuTitle = [NSString stringWithFormat:@"Create a list to organize your %@s", [itemType lowercaseString]];
    }
    
    
    
    
    topViewCover.menu = [UIMenu menuWithTitle:menuTitle children:actions];
    topViewCover.showsMenuAsPrimaryAction = true;
    
}

#pragma mark - User Context Menu

-(NSDictionary *)UserItemContextMenuCompleteMenu:(NSIndexPath *)indexPath username:(NSString *)username {
    
    UIAction *completedFor = [UIAction actionWithTitle:[NSString stringWithFormat:@"Complete for %@", username] image:[[UIImage systemImageNamed:@"checkmark"] imageWithTintColor:[UIColor systemGreenColor] renderingMode:UIImageRenderingModeAlwaysOriginal] identifier:@"CompletedFor" handler:^(__kindof UIAction * _Nonnull action) {
        
        UIImpactFeedbackGenerator *myGen = [[UIImpactFeedbackGenerator alloc] initWithStyle:(UIImpactFeedbackStyleMedium)];
        [myGen impactOccurred];
        
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld", (long)indexPath.row] forKey:@"TempIndexPathRow"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld", (long)indexPath.section] forKey:@"TempIndexPathSection"];
        
        NSString *myUsername = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"];
        NSString *username = self->itemAssignedUsernameArray[indexPath.row];
        
        [[NSUserDefaults standardUserDefaults] setObject:
         @{@"CompletedBy" : myUsername, @"CompletedFor" : username, @"CompletedForSomeoneElse" : @"Yes"}
                                                  forKey:@"TaskCompletedForSomeoneElse"];
        
        [self CompletedUncompletedAction:self];
        
    }];
    
    UIMenu *completedForMenu = [UIMenu menuWithTitle:[NSString stringWithFormat:@"You have %@ this %@ for %@", [itemType isEqualToString:@"Expense"] ? @"paid" : @"completed", [itemType lowercaseString], username] image:nil identifier:@"CompletedFor" options:UIMenuOptionsDisplayInline children:@[completedFor]];
    
    
    
    
    UIAction *markingFor = [UIAction actionWithTitle:[NSString stringWithFormat:@"Mark for %@", username] image:[[UIImage systemImageNamed:@"pencil.line"] imageWithTintColor:[UIColor systemBlueColor] renderingMode:UIImageRenderingModeAlwaysOriginal] identifier:@"MarkingFor" handler:^(__kindof UIAction * _Nonnull action) {
        
        UIImpactFeedbackGenerator *myGen = [[UIImpactFeedbackGenerator alloc] initWithStyle:(UIImpactFeedbackStyleMedium)];
        [myGen impactOccurred];
        
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld", (long)indexPath.row] forKey:@"TempIndexPathRow"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld", (long)indexPath.section] forKey:@"TempIndexPathSection"];
        
        NSString *myUsername = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"];
        NSString *username = self->itemAssignedUsernameArray[indexPath.row];
        
        [[NSUserDefaults standardUserDefaults] setObject:
         @{@"CompletedBy" : myUsername, @"CompletedFor" : username, @"CompletedForSomeoneElse" : @""}
                                                  forKey:@"TaskCompletedForSomeoneElse"];
        
        
        [self CompletedUncompletedAction:self];
        
    }];
    
    UIMenu *markingForMenu = [UIMenu menuWithTitle:[NSString stringWithFormat:@"You are just marking this %@ %@ for %@", [itemType lowercaseString], [itemType isEqualToString:@"Expense"] ? @"paid" : @"completed", username] image:nil identifier:@"MarkingFor" options:UIMenuOptionsDisplayInline children:@[markingFor]];
    
    
    
    
    return @{@"CompletedForMenu" : completedForMenu, @"MarkingForMenu" : markingForMenu};
}

-(UIAction *)UserItemContextMenuCompleteUncompleteAction:(NSIndexPath *)indexPath {
    
    NSMutableDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:itemAssignedToArray[indexPath.row] homeMembersDict:_homeMembersDict];
    NSString *userID = dataDict[@"UserID"];
    
    BOOL TaskCanBeCompletedInViewTaskBySpecificUser = [[[BoolDataObject alloc] init] TaskCanBeCompletedInViewTaskBySpecificUser:self->itemDict itemType:itemType userID:userID homeMembersDict:_homeMembersDict];
    
    if (TaskCanBeCompletedInViewTaskBySpecificUser == YES) {
        
        BOOL TaskApprovalRequestPendingBySpecificUser = [[[BoolDataObject alloc] init] TaskApprovalRequestPendingBySpecificUser:self->itemDict itemType:itemType userID:userID];
        BOOL TaskAlreadyCompleted = [[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:self->itemCompletedDict userIDToFind:userID];
        BOOL TaskIsCompleteAsNeeded = [[[BoolDataObject alloc] init] TaskIsCompleteAsNeeded:self->itemDict itemType:itemType];
        BOOL TaskIsPendingApprovalAndLoggedInUserIsCreator = (TaskApprovalRequestPendingBySpecificUser == YES && [itemCreatedBy isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]]);
        
        NSString *completedUncompletedString = @"";
        NSString *completedUncompletedImageString = @"";
        
        if ((TaskAlreadyCompleted == NO || TaskIsCompleteAsNeeded == YES) &&
            
            (TaskApprovalRequestPendingBySpecificUser == NO || (TaskIsPendingApprovalAndLoggedInUserIsCreator == YES))) {
            
            completedUncompletedString = @"Complete";
            completedUncompletedImageString = @"checkmark";
            
        } else {
            
            completedUncompletedString = @"Uncomplete";
            completedUncompletedImageString = @"xmark";
        }
        
        UIColor *colorToUse = [completedUncompletedString isEqualToString:@"Complete"] ? [UIColor systemGreenColor] : [UIColor systemPinkColor];
        
        UIAction *completedAction = [UIAction actionWithTitle:completedUncompletedString image:[[UIImage systemImageNamed:completedUncompletedImageString] imageWithTintColor:colorToUse renderingMode:UIImageRenderingModeAlwaysOriginal] identifier:nil handler:^(__kindof UIAction * _Nonnull action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Secondary %@d Clicked For %@", completedUncompletedString, [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
                
            }];
            
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld", (long)indexPath.row] forKey:@"TempIndexPathRow"];
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld", (long)indexPath.section] forKey:@"TempIndexPathSection"];
            
            [self CompletedUncompletedAction:self];
            
        }];
        
        return completedAction;
        
    }
    
    return [UIAction actionWithTitle:@"" image:nil identifier:@"" handler:^(__kindof UIAction * _Nonnull action) {}];
    
}

-(UIAction *)UserItemContextMenuInProgressNotInProgressAction:(NSIndexPath *)indexPath {
    
    NSMutableDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:itemAssignedToArray[indexPath.row] homeMembersDict:_homeMembersDict];
    NSString *userID = dataDict[@"UserID"];
    
    BOOL TaskCanBeCompletedInViewTaskBySpecificUser = [[[BoolDataObject alloc] init] TaskCanBeCompletedInViewTaskBySpecificUser:self->itemDict itemType:itemType userID:userID homeMembersDict:_homeMembersDict];
    
    if (TaskCanBeCompletedInViewTaskBySpecificUser == YES) {
        
        BOOL TaskAlreadyInProgress = [[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:self->itemInProgressDict userIDToFind:userID];
        
        NSString *inProgressNotInProgressString = @"";
        NSString *inProgressNotInProgressImageString = @"";
        
        if (TaskAlreadyInProgress == NO) {
            
            inProgressNotInProgressString = @"In Progress";
            inProgressNotInProgressImageString = @"clock.arrow.circlepath";
            
        } else {
            
            inProgressNotInProgressString = @"Not In Progress";
            inProgressNotInProgressImageString = @"exclamationmark.arrow.circlepath";
            
        }
        
        UIAction *inProgressAction = [UIAction actionWithTitle:inProgressNotInProgressString image:[[UIImage systemImageNamed:inProgressNotInProgressImageString] imageWithTintColor:[UIColor systemYellowColor] renderingMode:UIImageRenderingModeAlwaysOriginal] identifier:nil handler:^(__kindof UIAction * _Nonnull action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Secondary %@ Clicked For %@", inProgressNotInProgressString, [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
                
            }];
            
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld", (long)indexPath.row] forKey:@"TempIndexPathRow"];
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld", (long)indexPath.section] forKey:@"TempIndexPathSection"];
            
            [self InProgressNotInProgressAction:self];
            
        }];
        
        return inProgressAction;
        
    }
    
    return [UIAction actionWithTitle:@"" image:nil identifier:@"" handler:^(__kindof UIAction * _Nonnull action) {}];
}

-(UIAction *)UserItemContextMenuWontDoAction:(NSIndexPath *)indexPath {
    
    NSMutableDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:itemAssignedToArray[indexPath.row] homeMembersDict:_homeMembersDict];
    NSString *userID = dataDict[@"UserID"];
    
    BOOL TaskIsCompleteAsNeeded = [itemCompleteAsNeeded isEqualToString:@"Yes"];
    
    if (TaskIsCompleteAsNeeded == NO) {
        
        BOOL TaskAlreadyMarkedWontDo = [[itemWontDoDict allKeys] containsObject:userID];
        
        NSString *wontDoString = TaskAlreadyMarkedWontDo ? @"Will Do" : @"Won't Do";
        NSString *wontDoImageString = TaskAlreadyMarkedWontDo ? @"checkmark.square" : @"xmark.square";
        
        UIAction *wontDoAction = [UIAction actionWithTitle:wontDoString image:[[UIImage systemImageNamed:wontDoImageString] imageWithTintColor:[UIColor systemGrayColor] renderingMode:UIImageRenderingModeAlwaysOriginal] identifier:nil handler:^(__kindof UIAction * _Nonnull action) {
            
            BOOL TaskIsInTrash = [self->itemTrash isEqualToString:@"Yes"];
            
            if (TaskIsInTrash == NO) {
                
                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld", (long)indexPath.row] forKey:@"TempIndexPathRow"];
                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld", (long)indexPath.section] forKey:@"TempIndexPathSection"];
                
                [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"%@ Clicked For %@", wontDoString, [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
                    
                }];
                
//                [self StartProgressView];
                
                NSMutableDictionary *dictToUse = [self->itemDict mutableCopy];
                NSMutableDictionary *dictToUseLocal = [dictToUse mutableCopy];
                
                NSMutableDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:self->itemAssignedToArray[indexPath.row] homeMembersDict:self->_homeMembersDict];
                NSString *userWhoIsBeingMarkedUserID = dataDict[@"UserID"];
                
                NSString *notificationType = [[[NotificationsObject alloc] init] NotificationSettingsUnknownItemType_Adding:NO Editing:NO Deleting:NO Duplicating:NO Waiving:NO Skipping:NO Pausing:NO Comments:NO
                                                                                                               SkippingTurn:NO RemovingUser:NO
                                                                                                             FullyCompleted:NO Completed:NO InProgress:NO WontDo:YES Accept:NO Decline:NO
                                                                                                                    DueDate:NO Reminder:NO
                                                                                                             SubtaskEditing:NO SubtaskDeleting:NO
                                                                                                           SubtaskCompleted:NO SubtaskInProgress:NO SubtaskWontDo:NO SubtaskAccept:NO SubtaskDecline:NO
                                                                                                             AddingListItem:NO EditingListItem:NO DeletingListItem:NO ResetingListItem:NO
                                                                                                        EditingItemizedItem:NO DeletingItemizedItem:NO
                                                                                                          GroupChatMessages:NO LiveSupportMessages:NO
                                                                                                         SendingInvitations:NO DeletingInvitations:NO NewHomeMembers:NO HomeMembersMovedOut:NO HomeMembersKickedOut:NO
                                                                                                        FeatureForumUpvotes:NO BugForumUpvotes:NO
                                                                                                                   itemType:self->itemType];
                
                NSString *notificationItemType = self->itemType;
                
                BOOL markingForSomeoneElse = NO;
                
                
                
                //Remove Loading
                
                dictToUseLocal = [[[CompleteUncompleteObject alloc] init] GenerateUpdatedTaskWontDoWillDoDict:dictToUseLocal userWhoIsBeingMarkedUserID:userWhoIsBeingMarkedUserID markingForSomeoneElse:markingForSomeoneElse];
             
                self->itemxxxOccurrencesDict = [self->itemxxxOccurrencesDict mutableCopy];
                self->_taskListDict = [[[GeneralObject alloc] init] GenerateUpdatedTaskListDict:@[[NSMutableDictionary dictionary]] taskListDict:self->_taskListDict];
                [self UpdateAllDataInViewController:indexPath dictToUse:dictToUseLocal];
                
                //
                
                
                
                [[[CompleteUncompleteObject alloc] init] TaskWillDoWontDo:dictToUse itemOccurrencesDict:self->itemxxxOccurrencesDict keyArray:self->keyArray homeMembersArray:self->_homeMembersArray homeMembersDict:self->_homeMembersDict notificationSettingsDict:self->_notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType topicDict:self->_topicDict taskListDict:self->_taskListDict allItemAssignedToArrays:self->_allItemAssignedToArrays allItemTagsArrays:self->_allItemTagsArrays userWhoIsBeingMarkedUserID:userWhoIsBeingMarkedUserID markingForSomeoneElse:markingForSomeoneElse currentViewController:self completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningDictToUse, NSMutableDictionary * _Nonnull returningOccurrencesDictToUse, NSMutableDictionary * _Nonnull returningUpdatedTaskListDictToUse, BOOL TaskIsFullyCompleted) {
                    
                    self->itemxxxOccurrencesDict = [returningOccurrencesDictToUse mutableCopy];
                    self->_taskListDict = [[[GeneralObject alloc] init] GenerateUpdatedTaskListDict:@[returningUpdatedTaskListDictToUse] taskListDict:self->_taskListDict];
                    [self UpdateAllDataInViewController:indexPath dictToUse:returningDictToUse];
                    
                    TaskIsFullyCompleted = [[[BoolDataObject alloc] init] TaskIsFullyCompleted:dictToUseLocal itemType:self->itemType homeMembersDict:self->_homeMembersDict];
                    
                    [self CompleteUncompleteTaskAction_DisplayRepeatIfCompletedEarlyResetDropDown:dictToUseLocal TaskIsFullyCompleted:TaskIsFullyCompleted];
                    
                }];
                
            } else {
                
                [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:[NSString stringWithFormat:@"To perform this action you must move this %@ out of the trash", [self->itemType lowercaseString]] currentViewController:self];
                
            }
            
        }];
        
        return wontDoAction;
    }
    
    return [UIAction actionWithTitle:@"" image:nil identifier:@"" handler:^(__kindof UIAction * _Nonnull action) {}];
}

-(UIAction *)UserItemContextMenuSkipTurnAction:(NSIndexPath *)indexPath {
    
    NSMutableDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:itemAssignedToArray[indexPath.row] homeMembersDict:_homeMembersDict];
    NSString *userID = dataDict[@"UserID"];
    NSString *username = dataDict[@"Username"];
    
    BOOL TaskIsAssignedToMoreThanOnePerson = itemAssignedToArray.count > 1;
    BOOL TaskIsTakingTurns = [itemTakeTurns isEqualToString:@"Yes"];
    
    if (TaskIsAssignedToMoreThanOnePerson == YES && TaskIsTakingTurns == YES) {
        
        UIAction *skipTurnAction = [UIAction actionWithTitle:@"Skip Turn" image:[UIImage systemImageNamed:@"arrowshape.turn.up.right"] identifier:nil handler:^(__kindof UIAction * _Nonnull action) {
            
            if ([[[GeneralObject alloc] init] ConnectedToInternet] == NO) {
                [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You need to be connected to the internet to do that." currentViewController:self];
                return;
            }
            
            BOOL TaskIsInTrash = [self->itemTrash isEqualToString:@"Yes"];
            
            if (TaskIsInTrash == NO) {
                
                NSString *userTurn = [username isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"]] ? @"your" : [NSString stringWithFormat:@"%@'s", username];
                
                UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Are you sure you would like to skip %@ turn?", userTurn] message:nil preferredStyle:UIAlertControllerStyleActionSheet];
                
                UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"Skip Turn" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld", (long)indexPath.row] forKey:@"TempIndexPathRow"];
                    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld", (long)indexPath.section] forKey:@"TempIndexPathSection"];
                    
                    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Skipping Turn %@ For %@", self->_itemID, self->itemType] completionHandler:^(BOOL finished) {
                        
                    }];
                    
                    NSString *itemType = self->itemType;
                    NSMutableDictionary *homeMembersDict = [self->_homeMembersDict mutableCopy];
                    NSMutableDictionary *dictToUse = [self->itemDict mutableCopy];
                    NSMutableDictionary *dictToUseLocal = [dictToUse mutableCopy];
                    
//                    [self StartProgressView];
                    
                    NSString *notificationItemType = itemType;
                    
                    
                    
                    //Remove Loading
                    
                    dictToUseLocal = [[[[SetDataObject alloc] init] UpdateDataSkipUsersTurn_GenerateSkipUserTurnDict:dictToUseLocal homeMembersDict:homeMembersDict itemType:itemType] copy];
                    
                    
                    [self UpdateAllDataInViewController:nil dictToUse:dictToUseLocal];
                    
                    //
                    
                    
                    
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        
                        [[[SetDataObject alloc] init] UpdateDataSkipUsersTurn:itemType itemTypeCollection:self->itemTypeCollection homeID:self->homeID keyArray:self->keyArray homeMembersDict:homeMembersDict notificationSettingsDict:self->_notificationSettingsDict notificationItemType:notificationItemType topicDict:self->_topicDict allItemTagsArrays:self->_allItemTagsArrays homeMembersArray:self->_homeMembersArray dictToUse:dictToUse userID:userID SkippingTurn:YES DeletingHomeMember:NO completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningDictToUse) {
                            
                            [self UpdateAllDataInViewController:nil dictToUse:returningDictToUse];
                            
                        }];
                        
                    });
                    
                }];
                
                [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                    
                    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Skip Cancelled %@ For %@", self->_itemID, self->itemType] completionHandler:^(BOOL finished) {
                        
                    }];
                    
                }]];
                
                [deleteAction setValue:[UIColor systemRedColor] forKey:@"titleTextColor"];
                
                [actionSheet addAction:deleteAction];
                
                [self presentViewController:actionSheet animated:YES completion:nil];
                
            } else {
                
                [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:[NSString stringWithFormat:@"To perform this action you must move this %@ out of the trash", [self->itemType lowercaseString]] currentViewController:self];
                
            }
            
            
        }];
        
        return skipTurnAction;
    }
    
    return [UIAction actionWithTitle:@"" image:nil identifier:@"" handler:^(__kindof UIAction * _Nonnull action) {}];
}

-(UIAction *)UserItemContextMenuRemindAction:(NSIndexPath *)indexPath {
    
    NSMutableDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:itemAssignedToArray[indexPath.row] homeMembersDict:_homeMembersDict];
    NSString *userID = dataDict[@"UserID"];
    NSString *username = dataDict[@"Username"];
    
    BOOL DisplayRemindAction = [userID isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] == NO;

    if (DisplayRemindAction == YES) {
        
        UIAction *remindAction = [UIAction actionWithTitle:@"Remind" image:[UIImage systemImageNamed:@"bell"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
            
            UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Are you sure you would like to remind %@?", username] message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            
            UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"Remind" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Remind Selected"] completionHandler:^(BOOL finished) {
                    
                }];
                
                if ([self->itemTrash isEqualToString:@"No"]) {
                    
                    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld", (long)indexPath.row] forKey:@"TempIndexPathRow"];
                    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld", (long)indexPath.section] forKey:@"TempIndexPathSection"];
                    
                    [self TapGestureActionReminder:username];
                    
                } else {
                    
                    [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:[NSString stringWithFormat:@"To perform this action you must move this %@ out of the trash", [self->itemType lowercaseString]] currentViewController:self];
                    
                }
                
            }];
            
            [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                
                [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Remind Cancelled"] completionHandler:^(BOOL finished) {
                    
                }];
                
            }]];
            
            [actionSheet addAction:deleteAction];
            
            [self presentViewController:actionSheet animated:YES completion:nil];
            
        }];
        
        return remindAction;
    }
    
    return [UIAction actionWithTitle:@"" image:nil identifier:@"" handler:^(__kindof UIAction * _Nonnull action) {}];
}

-(UIAction *)UserItemContextMenuRemoveAction:(NSIndexPath *)indexPath {
    
    NSMutableDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:itemAssignedToArray[indexPath.row] homeMembersDict:_homeMembersDict];
    NSString *userID = dataDict[@"UserID"];
    NSString *username = dataDict[@"Username"];
    
    if (itemAssignedToArray.count > 1) {
        
        UIAction *deleteAction = [UIAction actionWithTitle:@"Remove" image:[UIImage systemImageNamed:@"minus.circle"] identifier:nil handler:^(__kindof UIAction * _Nonnull action) {
            
            if ([[[GeneralObject alloc] init] ConnectedToInternet] == NO) {
                [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You need to be connected to the internet to do that." currentViewController:self];
                return;
            }
            
            if ([self->itemTrash isEqualToString:@"No"]) {
                
                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld", (long)indexPath.row] forKey:@"TempIndexPathRow"];
                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld", (long)indexPath.section] forKey:@"TempIndexPathSection"];
                
                
                
                
                UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Are you sure you would like to remove %@ from this %@?", username, [self->itemType lowercaseString]] message:nil preferredStyle:UIAlertControllerStyleActionSheet];
                
                [actionSheet addAction:[UIAlertAction actionWithTitle:@"Remove" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                    
                    
                    
                    
                    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Removing User Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
                        
                    }];
                    
//                    [self StartProgressView];
                    
                    NSMutableDictionary *dictToUse = [self->itemDict mutableCopy];
                    NSMutableDictionary *dictToUseLocal = [dictToUse mutableCopy];
                    
                    NSString *notificationType = [[[NotificationsObject alloc] init] NotificationSettingsUnknownItemType_Adding:NO Editing:NO Deleting:NO Duplicating:NO Waiving:NO Skipping:NO Pausing:NO Comments:NO
                                                                                                                   SkippingTurn:NO RemovingUser:YES
                                                                                                                 FullyCompleted:NO Completed:NO InProgress:NO WontDo:NO Accept:NO Decline:NO
                                                                                                                        DueDate:NO Reminder:NO
                                                                                                                 SubtaskEditing:NO SubtaskDeleting:NO
                                                                                                               SubtaskCompleted:NO SubtaskInProgress:NO SubtaskWontDo:NO SubtaskAccept:NO SubtaskDecline:NO
                                                                                                                 AddingListItem:NO EditingListItem:NO DeletingListItem:NO ResetingListItem:NO
                                                                                                            EditingItemizedItem:NO DeletingItemizedItem:NO
                                                                                                              GroupChatMessages:NO LiveSupportMessages:NO
                                                                                                             SendingInvitations:NO DeletingInvitations:NO NewHomeMembers:NO HomeMembersMovedOut:NO HomeMembersKickedOut:NO
                                                                                                            FeatureForumUpvotes:NO BugForumUpvotes:NO
                                                                                                                       itemType:self->itemType];
                    
                    NSString *notificationItemType = self->itemType;
                    
                    NSString *userIDToRemove = userID;
                    
                    
                    
                    //Remove Loading
                    
                    dictToUseLocal = [[[DeleteDataObject alloc] init] DeleteUserFromAssignedTo_GenerateDictWithUserRemoved:dictToUseLocal homeMembersDict:self->_homeMembersDict userIDToRemove:userIDToRemove itemType:self->itemType itemAssignedToUsername:self->itemAssignedToArray];
                    
                    
                    [self UpdateAllDataInViewController:nil dictToUse:dictToUseLocal];
                    
                    //
                    
                    
                    
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        
                        [[[DeleteDataObject alloc] init] DeleteUserFromAssignedTo:self->itemType itemTypeCollection:self->itemTypeCollection keyArray:self->keyArray homeMembersArray:self->_homeMembersArray homeMembersDict:self->_homeMembersDict notificationSettingsDict:self->_notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType topicDict:self->_topicDict allItemTagsArrays:self->_allItemTagsArrays dictToUse:dictToUse itemAssignedToUsername:self->itemAssignedUsernameArray userIDToRemove:userIDToRemove completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningDictToUse) {
                            
                            [self UpdateAllDataInViewController:nil dictToUse:returningDictToUse];
                            
                        }];
                        
                    });
                    
                }]];
                
                [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                    
                    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Remove User Canceled For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
                        
                    }];
                    
                }]];
                
                [self presentViewController:actionSheet animated:YES completion:nil];
                
            } else {
                
                [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:[NSString stringWithFormat:@"To perform this action you must move this %@ out of the trash", [self->itemType lowercaseString]] currentViewController:self];
                
            }
            
            
            
            
        }];
        
        [deleteAction setAttributes:UIMenuElementAttributesDestructive];
        
        return deleteAction;
    }
    
    return [UIAction actionWithTitle:@"" image:nil identifier:@"" handler:^(__kindof UIAction * _Nonnull action) {}];
}

-(UIAction *)UserItemContextMenuCameraAction:(NSIndexPath *)indexPath {
    
    UIAction *cameraAction = [UIAction actionWithTitle:@"Camera" image:[UIImage systemImageNamed:@"camera"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld", (long)indexPath.row] forKey:@"TempIndexPathRow"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld", (long)indexPath.section] forKey:@"TempIndexPathSection"];
        
        [self openCamera];
        
    }];
    
    return cameraAction;
    
    return [UIAction actionWithTitle:@"" image:nil identifier:@"" handler:^(__kindof UIAction * _Nonnull action) {}];
}

-(UIAction *)UserItemContextMenuPhotoLibraryAction:(NSIndexPath *)indexPath {
    
    UIAction *photoLibraryAction = [UIAction actionWithTitle:@"Photo Library" image:[UIImage systemImageNamed:@"photo.on.rectangle"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld", (long)indexPath.row] forKey:@"TempIndexPathRow"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld", (long)indexPath.section] forKey:@"TempIndexPathSection"];
        
        [self openPhotoLibrary];
        
    }];
    
    return photoLibraryAction;
    
    return [UIAction actionWithTitle:@"" image:nil identifier:@"" handler:^(__kindof UIAction * _Nonnull action) {}];
}

-(UIAction *)UserItemContextMenuNoPhotoAction:(NSIndexPath *)indexPath {
    
    NSString *markedObject = [self GenerateDataForSpeificItemAtIndex:indexPath];
    
    NSMutableDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:itemAssignedToArray[indexPath.row] homeMembersDict:_homeMembersDict];
    NSString *username = dataDict[@"Username"];
    
    BOOL ConfirmationImageExists = itemPhotoConfirmationDict[markedObject] ? YES : NO;
    
    BOOL TaskCreatedByMe = [self->itemCreatedBy isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
    BOOL MarkedObjectIsMe = [markedObject isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
    BOOL MarkedObjectWasMarkedByMe = ConfirmationImageExists ? [itemPhotoConfirmationDict[markedObject][@"Uploaded By"] isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] : NO;
    
    if (ConfirmationImageExists && (TaskCreatedByMe || MarkedObjectIsMe || MarkedObjectWasMarkedByMe)) {
        
        UIAction *noPhotoAction = [UIAction actionWithTitle:@"Delete Image" image:[UIImage systemImageNamed:@"trash"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
            
            UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Are you sure you would like to delete %@'s image?", username] message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            
            UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"Delete Image" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                NSString *imageURL = [[[GeneralObject alloc] init] GeneratePhotoConfirmationImageURL:self->itemType itemUniqueID:self->itemUniqueID markedObject:markedObject];
                
                if ([markedObject length] > 0) {
                    
//                    [self StartProgressView];
                    
                    __block int totalQueries = 3;
                    __block int completedQueries = 0;
                    
                    
                    
                    //Remove Loading
                    
                    NSMutableDictionary *tempDict = [self->itemPhotoConfirmationDict mutableCopy];
                    if ([[tempDict allKeys] containsObject:markedObject]) { [tempDict removeObjectForKey:markedObject]; }
                    self->itemPhotoConfirmationDict = [tempDict mutableCopy];
                    
                    [self UpdateAllDataInViewController:nil dictToUse:[@{@"ItemPhotoConfirmationDict" : tempDict} mutableCopy]];
                    
                    //
                    
                    
                    
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        
                        [[[DeleteDataObject alloc] init] DeleteDataItemPhotoConfirmationImage:imageURL itemType:self->itemType markedObject:markedObject completionHandler:^(BOOL finished) {
                            
                            if (totalQueries == (completedQueries+=1)) {
                                
                                [self UpdateAllDataInViewController:nil dictToUse:[@{@"ItemPhotoConfirmationDict" : tempDict} mutableCopy]];
                                
                            }
                            
                        }];
                        
                    });
                    
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        
                        [[[SetDataObject alloc] init] UpdateDataEditItem:@{@"ItemPhotoConfirmationDict" : self->itemPhotoConfirmationDict} itemID:self->_itemID itemOccurrenceID:self->_itemOccurrenceID collection:self->itemTypeCollection homeID:self->homeID completionHandler:^(BOOL finished) {
                            
                            if (totalQueries == (completedQueries+=1)) {
                                
                                [self UpdateAllDataInViewController:nil dictToUse:[@{@"ItemPhotoConfirmationDict" : tempDict} mutableCopy]];
                                
                            }
                            
                        }];
                        
                    });
                    
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        
                        NSMutableDictionary *singleObjectItemDict = [[[GeneralObject alloc] init] GenerateSingleObjectDictionary:[self->itemDict mutableCopy] keyArray:[self->keyArray mutableCopy] indexPath:nil];
                        
                        
                        
                        NSString *notificationType = [[[NotificationsObject alloc] init] NotificationSettingsUnknownItemType_Adding:NO Editing:NO Deleting:NO Duplicating:NO Waiving:NO Skipping:NO Pausing:NO Comments:NO
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
                                                                                                                           itemType:self->itemType];
                        
                        
                        
                        NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
                        
                        
                        
                        NSString *notificationTitle = [NSString stringWithFormat:@"\"%@\"", self->itemName];
                        NSString *notificationBody = [NSString stringWithFormat:@"%@ deleted an image for this %@. 🙂", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"], [self->itemType lowercaseString]];
                        
                        
                        
                        NSMutableArray *usersToSendNotificationTo = [self->itemAssignedToArray mutableCopy];
                        
                        NSArray *addTheseUsers = @[self->itemCreatedBy];
                        NSArray *removeTheseUsers = @[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx"];
                        
                        usersToSendNotificationTo = [[[[NotificationsObject alloc] init] AddAndRemoveSpecificUsersFromArray:usersToSendNotificationTo addTheseUsers:addTheseUsers removeTheseUsers:removeTheseUsers] mutableCopy];
                        
                        
                        
                        [[[NotificationsObject alloc] init] SendPushNotificationToArrayOfUsers_Items:usersToSendNotificationTo
                                                                                           dictToUse:singleObjectItemDict
                                                                                              homeID:homeID
                                                                                    homeMembersArray:self->_homeMembersArray homeMembersDict:self->_homeMembersDict notificationSettingsDict:self->_notificationSettingsDict notificationItemType:self->itemType notificationType:notificationType
                                                                                           topicDict:self->_topicDict
                                                                                   allItemTagsArrays:self->_allItemTagsArrays
                                                                               pushNotificationTitle:notificationTitle pushNotificationBody:notificationBody notificationTitle:notificationTitle notificationBody:notificationBody
                                                                             SetDataHomeNotification:YES
                                                                                RemoveUsersNotInHome:YES
                                                                                   completionHandler:^(BOOL finished) {
                            
                            if (totalQueries == (completedQueries+=1)) {
                                
                                [self UpdateAllDataInViewController:nil dictToUse:[@{@"ItemPhotoConfirmationDict" : tempDict} mutableCopy]];
                                
                            }
                            
                        }];
                        
                    });
                    
                }
                
            }];
            
            [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                
                [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Delete Image Cancelled %@ For %@", self->_itemID, self->itemType] completionHandler:^(BOOL finished) {
                    
                }];
                
            }]];
            
            [deleteAction setValue:[UIColor systemRedColor] forKey:@"titleTextColor"];
            
            [actionSheet addAction:deleteAction];
            
            [self presentViewController:actionSheet animated:YES completion:nil];
            
        }];
        
        [noPhotoAction setAttributes:UIMenuElementAttributesDestructive];
        
        return noPhotoAction;
        
    }
    
    return [UIAction actionWithTitle:@"" image:nil identifier:@"" handler:^(__kindof UIAction * _Nonnull action) {}];
}

-(UIAction *)UserItemContextMenuViewImageAction:(NSIndexPath *)indexPath {
    
    NSString *markedObject = [self GenerateDataForSpeificItemAtIndex:indexPath];
    
    BOOL ConfirmationImageExists = itemPhotoConfirmationDict[markedObject] ? YES : NO;
    
    if (ConfirmationImageExists) {
        
        UIAction *viewImageAction = [UIAction actionWithTitle:@"View Image" image:[UIImage systemImageNamed:@"magnifyingglass"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"View Image"] completionHandler:^(BOOL finished) {
                
            }];
            
            NSString *itemImageDataURLString = self->itemPhotoConfirmationDict[markedObject][@"Image URL"] ? self->itemPhotoConfirmationDict[markedObject][@"Image URL"] : @"xxx";
            
            [self StartProgressView];
            
            [[[GetDataObject alloc] init] GetDataItemImage:itemImageDataURLString completionHandler:^(BOOL finished, NSURL * _Nonnull itemImageURL) {
                
                NSData *data = [NSData dataWithContentsOfURL:itemImageURL];
                UIImage *image = [UIImage imageWithData:data];
                
                [self->progressView setHidden:YES];
                
                [[[PushObject alloc] init] PushToViewImageViewController:self itemImage:image];
                
            }];
            
        }];
        
        return viewImageAction;
        
    }
    
    return [UIAction actionWithTitle:@"" image:nil identifier:@"" handler:^(__kindof UIAction * _Nonnull action) {}];
}

#pragma mark - Non-User Context Menu

-(UIAction *)NonUserItemContextMenuCompleteUncompleteAction:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    
    NSString *listItem = @"";
    NSString *itemizedItem = @"";
    NSString *subtask = @"";
    
    if (ListItemsVisible == YES) {
        
        listItem = [self GenerateDataForSpeificItemAtIndex:indexPath];
        
    } else if (ItemizedItemsVisible == YES) {
        
        itemizedItem = [self GenerateDataForSpeificItemAtIndex:indexPath];
        
    } else if (SubtaskCellsVisible == YES) {
        
        subtask = [[itemSubTasksDict allKeys] count] > indexPath.row ? [itemSubTasksDict allKeys][indexPath.row] : @"";
        
    }
    
    NSString *completedUncompletedString = @"";
    NSString *completedUncompletedImageString = @"";
    
    if (ListItemsVisible == YES) {
        
        NSString *completedOrUncompleted = [[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemCompletedDict userIDToFind:listItem] ? @"Uncomplete" : @"Complete";
        
        BOOL TaskIsCompleteAsNeeded = [[[BoolDataObject alloc] init] TaskIsCompleteAsNeeded:self->itemDict itemType:itemType];
        
        if ([completedOrUncompleted isEqualToString:@"Complete"] || TaskIsCompleteAsNeeded == YES) {
            
            completedUncompletedString = @"Complete";
            completedUncompletedImageString = @"checkmark";
            
        } else {
            
            completedUncompletedString = @"Uncomplete";
            completedUncompletedImageString = @"xmark";
            
        }
        
    } else if (ItemizedItemsVisible == YES) {
        
        BOOL TaskIsCompleteAsNeeded = [[[BoolDataObject alloc] init] TaskIsCompleteAsNeeded:self->itemDict itemType:itemType];
        
        NSString *completedOrUncompleted = [[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemCompletedDict userIDToFind:itemizedItem] ? @"Uncomplete" : @"Complete";
        
        if ([completedOrUncompleted isEqualToString:@"Complete"] || TaskIsCompleteAsNeeded == YES) {
            
            completedUncompletedString = @"Complete";
            completedUncompletedImageString = @"checkmark";
            
        } else {
            
            completedUncompletedString = @"Uncomplete";
            completedUncompletedImageString = @"xmark";
            
        }
        
    } else if (tableView == self->_subTasksTableView && [self->itemType isEqualToString:@"Chore"]) {
        
        BOOL TaskIsCompleteAsNeeded = [[[BoolDataObject alloc] init] TaskIsCompleteAsNeeded:self->itemDict itemType:itemType];
        NSString *completedOrUncompleted = ([[self->itemSubTasksDict[subtask][@"Completed Dict"] allKeys] count] > 0) ? @"Uncomplete" : @"Complete";
        
        if ([completedOrUncompleted isEqualToString:@"Complete"] || TaskIsCompleteAsNeeded == YES) {
            
            completedUncompletedString = @"Complete";
            completedUncompletedImageString = @"checkmark";
            
        } else {
            
            completedUncompletedString = @"Uncomplete";
            completedUncompletedImageString = @"xmark";
            
        }
        
    }
    
    UIColor *colorToUse = [completedUncompletedString isEqualToString:@"Complete"] ? [UIColor systemGreenColor] : [UIColor systemPinkColor];
    
    UIAction *completedAction = [UIAction actionWithTitle:completedUncompletedString image:[[UIImage systemImageNamed:completedUncompletedImageString] imageWithTintColor:colorToUse renderingMode:UIImageRenderingModeAlwaysOriginal] identifier:nil handler:^(__kindof UIAction * _Nonnull action) {
        
        UIImpactFeedbackGenerator *myGen = [[UIImpactFeedbackGenerator alloc] initWithStyle:(UIImpactFeedbackStyleMedium)];
        [myGen impactOccurred];
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Secondary %@d Clicked For %@", completedUncompletedString, [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
            
        }];
        
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld", (long)indexPath.row] forKey:@"TempIndexPathRow"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld", (long)indexPath.section] forKey:@"TempIndexPathSection"];
        
        if (self->ListItemsVisible == YES) {
            
            [self ListItemCompletedUncompletedAction:self];
            
        } else if (self->ItemizedItemsVisible == YES) {
            
            [self ItemizedItemCompletedUncompletedAction:self];
            
        } else if (tableView == self->_subTasksTableView && [self->itemType isEqualToString:@"Chore"]) {
            
            [self SubTaskCompletedUncompletedAction:self];
            
        }
        
    }];
    
    return completedAction;
}

-(UIAction *)NonUserItemContextMenuInProgressNotInProgressAction:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    
    NSString *listItem = @"";
    NSString *itemizedItem = @"";
    NSString *subtask = @"";
    
    if (ListItemsVisible == YES) {
        
        listItem = [self GenerateDataForSpeificItemAtIndex:indexPath];
        
    } else if (ItemizedItemsVisible == YES) {
        
        itemizedItem = [self GenerateDataForSpeificItemAtIndex:indexPath];
        
    } else if (tableView == self->_subTasksTableView && [self->itemType isEqualToString:@"Chore"]) {
        
        subtask = [[itemSubTasksDict allKeys] count] > indexPath.row ? [itemSubTasksDict allKeys][indexPath.row] : @"";
        
    }
    
    NSString *inProgressNotInProgressString = @"";
    NSString *inProgressNotInProgressImageString = @"";
    
    if (ListItemsVisible == YES) {
        
        NSString *inProgressOrNotInProgress = [[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemInProgressDict userIDToFind:listItem] ? @"Not In Progress" : @"In Progress";
        
        if ([inProgressOrNotInProgress isEqualToString:@"In Progress"]) {
            
            inProgressNotInProgressString = @"In Progress";
            inProgressNotInProgressImageString = @"clock.arrow.circlepath";
            
        } else {
            
            inProgressNotInProgressString = @"Not In Progress";
            inProgressNotInProgressImageString = @"exclamationmark.arrow.circlepath";
            
        }
        
    } else if (ItemizedItemsVisible == YES) {
        
        NSString *inProgressOrNotInProgress = [[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemInProgressDict userIDToFind:itemizedItem] ? @"Not In Progress" : @"In Progress";
        
        if ([inProgressOrNotInProgress isEqualToString:@"In Progress"]) {
            
            inProgressNotInProgressString = @"In Progress";
            inProgressNotInProgressImageString = @"clock.arrow.circlepath";
            
        } else {
            
            inProgressNotInProgressString = @"Not In Progress";
            inProgressNotInProgressImageString = @"exclamationmark.arrow.circlepath";
            
        }
        
    } else if (tableView == self->_subTasksTableView && [self->itemType isEqualToString:@"Chore"]) {
        
        NSString *inProgressOrNotInProgress = ([[self->itemSubTasksDict[subtask][@"In Progress Dict"] allKeys] count] > 0) ? @"Not In Progress" : @"In Progress";
        
        if ([inProgressOrNotInProgress isEqualToString:@"In Progress"]) {
            
            inProgressNotInProgressString = @"In Progress";
            inProgressNotInProgressImageString = @"clock.arrow.circlepath";
            
        } else {
            
            inProgressNotInProgressString = @"Not In Progress";
            inProgressNotInProgressImageString = @"exclamationmark.arrow.circlepath";
            
        }
        
    }
    
    UIAction *inProgressAction = [UIAction actionWithTitle:inProgressNotInProgressString image:[[UIImage systemImageNamed:inProgressNotInProgressImageString] imageWithTintColor:[UIColor systemYellowColor] renderingMode:UIImageRenderingModeAlwaysOriginal] identifier:nil handler:^(__kindof UIAction * _Nonnull action) {
        
        UIImpactFeedbackGenerator *myGen = [[UIImpactFeedbackGenerator alloc] initWithStyle:(UIImpactFeedbackStyleMedium)];
        [myGen impactOccurred];
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Secondary %@ Clicked For %@", inProgressNotInProgressString, [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
            
        }];
        
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld", (long)indexPath.row] forKey:@"TempIndexPathRow"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld", (long)indexPath.section] forKey:@"TempIndexPathSection"];
        
        if (self->ListItemsVisible == YES) {
            
            [self ListItemInProgressNotInProgressAction:self];
            
        } else if (self->ItemizedItemsVisible == YES) {
            
            [self ItemizedItemInProgressNotInProgressAction:self];
            
        } else if (tableView == self->_subTasksTableView && [self->itemType isEqualToString:@"Chore"]) {
            
            [self SubTaskInProgressNotInProgressAction:self];
            
        }
        
    }];
    
    return inProgressAction;
}

-(UIAction *)NonUserItemContextMenuWontDoAction:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    
    id sender = indexPath;
    
    if ([itemCompleteAsNeeded isEqualToString:@"No"]) {
        
        NSString *wontDoString = @"Won't Do";
        NSString *wontDoImageString = @"xmark.square";
        
        if (ListItemsVisible == YES) {
            
            NSString *listItemThatIsBeingMarked = [self GenerateDataForSpeificItemAtIndex:indexPath];
            
            if ([[itemWontDoDict allKeys] containsObject:listItemThatIsBeingMarked]) {
                wontDoString = @"Will Do";
                wontDoImageString = @"checkmark.square";
            }
            
        } else if (ItemizedItemsVisible == YES) {
            
            NSString *itemizedItemThatIsBeingMarked = [self GenerateDataForSpeificItemAtIndex:indexPath];
            
            if ([[itemWontDoDict allKeys] containsObject:itemizedItemThatIsBeingMarked]) {
                wontDoString = @"Will Do";
                wontDoImageString = @"checkmark.square";
            }
            
        } else if (tableView == self->_subTasksTableView && [self->itemType isEqualToString:@"Chore"]) {
            
            NSString *subtaskThatIsBeingMarked = itemSubTasksDict && [[itemSubTasksDict allKeys] count] ? [itemSubTasksDict allKeys][indexPath.row] : @"";
            NSMutableDictionary *subtaskWontDoDict = [itemSubTasksDict[subtaskThatIsBeingMarked][@"Wont Do"] mutableCopy];
            
            if ([[subtaskWontDoDict allKeys] containsObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]]) {
                wontDoString = @"Will Do";
                wontDoImageString = @"checkmark.square";
            }
            
        }
        
        UIAction *wontDoAction = [UIAction actionWithTitle:wontDoString image:[[UIImage systemImageNamed:wontDoImageString] imageWithTintColor:[UIColor systemGrayColor] renderingMode:UIImageRenderingModeAlwaysOriginal] identifier:nil handler:^(__kindof UIAction * _Nonnull action) {
            
            if ([self->itemTrash isEqualToString:@"No"]) {
                
                UIImpactFeedbackGenerator *myGen = [[UIImpactFeedbackGenerator alloc] initWithStyle:(UIImpactFeedbackStyleMedium)];
                [myGen impactOccurred];
                
                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld", (long)indexPath.row] forKey:@"TempIndexPathRow"];
                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld", (long)indexPath.section] forKey:@"TempIndexPathSection"];
                
                if (self->ListItemsVisible == YES) {
                    
                    [self WontDoListItemItemTypeList:sender];
                    
                } else if (self->ItemizedItemsVisible == YES) {
                    
                    [self WontDoItemizedItemItemTypeExpense:sender];
                    
                } else if (tableView == self->_subTasksTableView && [self->itemType isEqualToString:@"Chore"]) {
                    
                    [self WontDoSubtask:sender];
                    
                }
                
            } else {
                
                [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:[NSString stringWithFormat:@"To perform this action you must move this %@ out of the trash", [self->itemType lowercaseString]] currentViewController:self];
                
            }
            
        }];
        
        return wontDoAction;
    }
    
    return [UIAction actionWithTitle:@"" image:nil identifier:@"" handler:^(__kindof UIAction * _Nonnull action) {}];
}

-(UIAction *)NonUserItemContextMenuEditAction:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    
    id sender = indexPath;
    
    if ([itemCompleteAsNeeded isEqualToString:@"No"]) {
        
        UIAction *editAction = [UIAction actionWithTitle:@"Edit" image:[UIImage systemImageNamed:@"pencil"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
            
            if ([[[GeneralObject alloc] init] ConnectedToInternet] == NO) {
                [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You need to be connected to the internet to do that." currentViewController:self];
                return;
            }
            
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld", (long)indexPath.row] forKey:@"TempIndexPathRow"];
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld", (long)indexPath.section] forKey:@"TempIndexPathSection"];
            
            if (self->ListItemsVisible == YES) {
                
                [self EditListItemItemTypeList:sender];
                
            } else if (self->ItemizedItemsVisible == YES) {
                
                [self EditItemizedItemItemTypeExpense:sender];
                
            } else if (tableView == self->_subTasksTableView && [self->itemType isEqualToString:@"Chore"]) {
                
                [self EditSubtask:sender];
                
            }
            
        }];
        
        return editAction;
    }
    
    return [UIAction actionWithTitle:@"" image:nil identifier:@"" handler:^(__kindof UIAction * _Nonnull action) {}];
}

-(UIAction *)NonUserItemContextMenuDeleteAction:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    
    id sender = indexPath;
    
    BOOL NonUserItemIsAbleToBeDeleted = ((tableView == _subTasksTableView && [itemType isEqualToString:@"Chore"]) ||
                                         [[itemListItems allKeys] count] > 1 ||
                                         [[itemItemizedItems allKeys] count] > 1);
    
    if (NonUserItemIsAbleToBeDeleted == YES) {
        
        NSString *deleteActionTitle = @"Delete";
        
        UIAction *deleteAction;
        
        deleteAction = [UIAction actionWithTitle:deleteActionTitle image:[UIImage systemImageNamed:@"minus.circle"] identifier:nil handler:^(__kindof UIAction * _Nonnull action) {
            
            if ([[[GeneralObject alloc] init] ConnectedToInternet] == NO) {
                [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You need to be connected to the internet to do that." currentViewController:self];
                return;
            }
            
            NSString *itemName = @"";
            
            if (self->ListItemsVisible == YES) {
                
                NSString *itemListItem = [self GenerateDataForSpeificItemAtIndex:indexPath];
                
                itemName = itemListItem;
                
            } else if (self->ItemizedItemsVisible == YES) {
                
                NSString *itemItemizedItem = [self GenerateDataForSpeificItemAtIndex:indexPath];
                
                itemName = itemItemizedItem;
                
            } else if (tableView == self->_subTasksTableView && [self->itemType isEqualToString:@"Chore"]) {
                
                NSString *itemSubtask = [self->itemSubTasksDict allKeys][indexPath.row];
                
                itemName = itemSubtask;
                
            }
            
            UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Are you sure you would like to delete \"%@\" from this %@?", itemName, [self->itemType lowercaseString]] message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            
            [actionSheet addAction:[UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                
                if ([self->itemTrash isEqualToString:@"No"]) {
                    
                    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld", (long)indexPath.row] forKey:@"TempIndexPathRow"];
                    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld", (long)indexPath.section] forKey:@"TempIndexPathSection"];
                    
                    if (self->ListItemsVisible == YES) {
                        
                        [self DeleteListItemItemTypeList:sender];
                        
                    } else if (self->ItemizedItemsVisible == YES) {
                        
                        [self DeleteItemizedItemItemTypeExpense:sender];
                        
                    } else if (tableView == self->_subTasksTableView && [self->itemType isEqualToString:@"Chore"]) {
                        
                        [self DeleteSubtask:sender];
                        
                    }
                    
                } else {
                    
                    [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:[NSString stringWithFormat:@"To perform this action you must move this %@ out of the trash", [self->itemType lowercaseString]] currentViewController:self];
                    
                }
                
            }]];
            
            [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                
                NSString *item = @"";
                
                if (self->ListItemsVisible == YES) {
                    
                    item = @"List Item";
                    
                } else if (self->ItemizedItemsVisible == YES) {
                    
                    item = @"Itemized Item";
                    
                } else if (tableView == self->_subTasksTableView && [self->itemType isEqualToString:@"Chore"]) {
                    
                    item = @"Subtask";
                    
                }
                
                [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Remove %@ Canceled For %@", item, [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
                    
                }];
                
            }]];
            
            [self presentViewController:actionSheet animated:YES completion:nil];
            
        }];
        
        [deleteAction setAttributes:UIMenuElementAttributesDestructive];
        
        return deleteAction;
    }
    
    return [UIAction actionWithTitle:@"" image:nil identifier:@"" handler:^(__kindof UIAction * _Nonnull action) {}];
}

#pragma mark - Task List Context Menu Actions

-(UIAction *)TaskListItemContextMenuTaskListAction:(NSString *)taskListName {
    
    NSString *imageString = [topViewLabel.text isEqualToString:taskListName] ? @"checkmark" : @"list.bullet.rectangle.portrait";
    
    UIAction *taskListAction = [UIAction actionWithTitle:taskListName image:[UIImage systemImageNamed:imageString] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        if ([[[GeneralObject alloc] init] ConnectedToInternet] == NO) {
            [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You need to be connected to the internet to do that." currentViewController:self];
            return;
        }
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Specific List Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
            
        }];
        
        [self StartProgressView];
        
        [self UpdateTaskListItems:taskListName oldTaskListName:self->topViewLabel.text completionHandler:^(BOOL finished, NSString *oldTaskListID, NSString *newTaskListID) {
            
            [self UpdateTaskListItems_CompletionBlock:taskListName oldTaskListID:oldTaskListID newTaskListID:newTaskListID itemUniqueID:self->itemUniqueID];
            
        }];
        
    }];
    
    return taskListAction;
}

-(UIAction *)TaskListItemContextMenuSuggestedTaskListAction:(NSString *)taskListName {
    
    NSString *imageString = [topViewLabel.text isEqualToString:taskListName] && [_taskListDict[@"TaskListName"] containsObject:topViewLabel.text] == NO ? @"checkmark" : @"list.bullet.rectangle.portrait";
    
    UIAction *taskListAction = [UIAction actionWithTitle:taskListName image:[UIImage systemImageNamed:imageString] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [self StartProgressView];
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Specific List Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
            
        }];
        
        BOOL TaskListChosenAlreadyExists =  [self->_taskListDict[@"TaskListName"] containsObject:taskListName];
        
        if (TaskListChosenAlreadyExists == YES) {
            
            [self UpdateTaskListItems:taskListName oldTaskListName:self->topViewLabel.text completionHandler:^(BOOL finished, NSString *oldTaskListID, NSString *newTaskListID) {
                
                [self UpdateTaskListItems_CompletionBlock:taskListName oldTaskListID:oldTaskListID newTaskListID:newTaskListID itemUniqueID:self->itemUniqueID];
                
            }];
            
        } else {
            
            NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
            NSString *randomID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
            NSString *dateCreated = [[[GeneralObject alloc] init] GenerateCurrentDateString];
            NSString *newName = taskListName;
            
            NSMutableDictionary *setDataDict = [@{
                @"TaskListID" : randomID,
                @"TaskListDateCreated" : dateCreated,
                @"TaskListCreatedBy" : userID,
                @"TaskListName" : newName,
                @"TaskListSections" : [NSMutableArray array],
                @"TaskListItems" : [NSMutableDictionary dictionary]
            } mutableCopy];
            
            [[[SetDataObject alloc] init] SetDataAddTaskList:setDataDict[@"TaskListCreatedBy"] taskListID:setDataDict[@"TaskListID"] dataDict:setDataDict completionHandler:^(BOOL finished) {
                
                [[[GeneralObject alloc] init] CallNSNotificationMethods:@"AddOrEditTaskList" userInfo:setDataDict locations:@[@"Tasks", @"MultiAddTasks", @"ViewTask"]];
                
                [self UpdateTaskListItems:taskListName oldTaskListName:self->topViewLabel.text completionHandler:^(BOOL finished, NSString *oldTaskListID, NSString *newTaskListID) {
                    
                    [self UpdateTaskListItems_CompletionBlock:taskListName oldTaskListID:oldTaskListID newTaskListID:newTaskListID itemUniqueID:self->itemUniqueID];
                    
                }];
                
            }];
            
        }
        
    }];
    
    return taskListAction;
}

-(UIAction *)TaskListItemContextMenuNewTaskListAction {
    
    UIAction *newTaskListAction = [UIAction actionWithTitle:@"New List" image:[UIImage systemImageNamed:@"plus"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        if ([[[GeneralObject alloc] init] ConnectedToInternet] == NO) {
            [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You need to be connected to the internet to do that." currentViewController:self];
            return;
        }
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"New List Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
            
        }];
        
        [[[PushObject alloc] init] PushToViewTaskListsViewController:[self->_folderDict mutableCopy] taskListDict:[self->_taskListDict mutableCopy] itemToEditDict:nil itemUniqueID:self->itemUniqueID comingFromTasksViewController:NO comingFromViewTaskViewController:YES currentViewController:self];
        
    }];
    
    return newTaskListAction;
}

-(UIAction *)TaskListItemContextMenuNoTaskListAction {
    
    UIAction *noTaskListAction = [UIAction actionWithTitle:@"No List" image:[UIImage systemImageNamed:@"nosign"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        if ([[[GeneralObject alloc] init] ConnectedToInternet] == NO) {
            [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You need to be connected to the internet to do that." currentViewController:self];
            return;
        }
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"No List Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
            
        }];
        
        [self StartProgressView];
        
        [self RemoveTaskListItems:^(BOOL finished) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [[[GeneralObject alloc] init] CallNSNotificationMethods:@"RemoveTaskFromAllTaskLists" userInfo:@{@"ItemUniqueID" : self->itemUniqueID} locations:@[@"Tasks"]];
                
                [self UpdateTopViewLabel:@"No List"];
                
                [self->progressView setHidden:YES];
                
            });
            
        }];
        
    }];
    
    [noTaskListAction setAttributes:UIMenuElementAttributesDestructive];
    
    return noTaskListAction;
}

#pragma mark - Task List Context Menus

-(UIMenu *)TaskListItemContextMenuTaskListActionsMenu:(NSMutableArray *)taskListActions {
    
    UIMenu *taskListMenu = [UIMenu menuWithTitle:@"" image:[UIImage systemImageNamed:@"list.bullet.rectangle.portrait"] identifier:@"" options:UIMenuOptionsDisplayInline children:taskListActions];
    
    return taskListMenu;
}


-(UIMenu *)TaskListItemContextMenuSuggestedTaskListActionsMenu:(NSMutableArray *)suggestedTaskListActions arrayToUse:(NSArray *)arrayToUse {
    
    NSString *imageString = [arrayToUse containsObject:topViewLabel.text] && [_taskListDict[@"TaskListName"] containsObject:topViewLabel.text] == NO ? @"checkmark" : @"list.bullet.rectangle.portrait";
    
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

#pragma mark - Payment Method Context Menu Actions

-(UIAction *)ItemPaymentMethodContextMenuOpenPaymentMethodAction {
    
    __block NSString *paymentMethod = self->itemPaymentMethodDict[@"PaymentMethod"];
    __block NSString *paymentMethodData = self->itemPaymentMethodDict[@"PaymentMethodData"];
    __block NSString *costPerPerson = @"";
    
    if ([[self->itemCostPerPersonDict allKeys] containsObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]]) {
        costPerPerson = self->itemCostPerPersonDict[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
    }
    
    UIAction *openPaymentMethodAction = [UIAction actionWithTitle:@"Open Payment Method" image:[UIImage systemImageNamed:@"envelope.open"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Open Payment Method"] completionHandler:^(BOOL finished) {
            
        }];
        
        NSString *urlString = @"";
        NSString *secondaryUrlString = @"";
        
        if ([paymentMethod isEqualToString:@"Venmo"]) {
            
            NSString *note = [NSString stringWithFormat:@"WeDivvy: %@", self->itemName];
            
            note = [[[GeneralObject alloc] init] GenerateStringWithReplacementString:note stringToReplace:@" " replacementString:[NSString stringWithFormat:@"%%20"]];
            paymentMethodData = [[[GeneralObject alloc] init] GenerateStringWithReplacementString:paymentMethodData stringToReplace:@" " replacementString:[NSString stringWithFormat:@"%%20"]];
            
            urlString = [NSString stringWithFormat:@"venmo://paycharge?txn=pay&recipients=%@&amount=%@&note=%@", paymentMethodData, costPerPerson, note];
            secondaryUrlString = [NSString stringWithFormat:@"https://account.venmo.com/pay?recipients=%@&amount=%@", paymentMethodData, costPerPerson];
            
        } else if ([paymentMethod isEqualToString:@"CashApp"]) {
            
            if ([paymentMethodData containsString:@"$"] == NO) { paymentMethodData = [NSString stringWithFormat:@"$%@", paymentMethodData]; }
            
            paymentMethodData = [[[GeneralObject alloc] init] GenerateStringWithReplacementString:paymentMethodData stringToReplace:@" " replacementString:[NSString stringWithFormat:@"%%20"]];
            
            urlString = [NSString stringWithFormat:@"https://cash.app/%@/%@", paymentMethodData, costPerPerson];
            secondaryUrlString = [NSString stringWithFormat:@"https://cash.app/%@/%@", paymentMethodData, costPerPerson];
            
        } else if ([paymentMethod isEqualToString:@"PayPal"]) {
            
            urlString = @"paypal://";
            secondaryUrlString = @"https://www.paypal.com/myaccount/transfer/homepage";
            
        } else if ([paymentMethod isEqualToString:@"Zelle"]) {
            
            urlString = @"zelle://";
            secondaryUrlString = @"";
            
        }
        
        NSURL *url = [NSURL URLWithString:paymentMethodData];
        
        if (url && url.scheme && url.host) {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:paymentMethodData] options:@{} completionHandler:^(BOOL success) {
                
            }];
            
        } else {
            
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlString]]) {
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString] options:@{} completionHandler:^(BOOL success) {
                    
                }];
                
            } else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:secondaryUrlString]]) {
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:secondaryUrlString] options:@{} completionHandler:^(BOOL success) {
                    
                }];
                
            } else {
                
                [[[GeneralObject alloc] init] CreateAlert:@"Oops!" message:@"Payment method could not be openned." currentViewController:self];
                
            }
            
        }
        
    }];
    
    return openPaymentMethodAction;
}

-(UIAction *)ItemPaymentMethodContextMenuCopyUsernameAction {
    
    if (self->itemPaymentMethodDict[@"PaymentMethodData"] && [self->itemPaymentMethodDict[@"PaymentMethodData"] length] > 0) {
        
        UIAction *copyUsernameAction = [UIAction actionWithTitle:@"Copy Username, Email, URL, etc." image:[UIImage systemImageNamed:@"doc.on.doc"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Copy Payment Method Data"] completionHandler:^(BOOL finished) {
                
            }];
            
            UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
            pasteBoard.string = self->itemPaymentMethodDict[@"PaymentMethodData"];
            
            [[[GeneralObject alloc] init] CreateAlert:@"Copied!" message:[NSString stringWithFormat:@"%@ was copied", self->itemPaymentMethodDict[@"PaymentMethodData"]] currentViewController:self];
            
        }];
        
        return copyUsernameAction;
    }
    
    return [UIAction actionWithTitle:@"" image:nil identifier:@"" handler:^(__kindof UIAction * _Nonnull action) {}];
}

#pragma mark

-(UIMenu *)ItemPaymentMethodContextMenuInlineMenu {
    
    BOOL TaskIsCreatedByMe = [itemCreatedBy isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
    BOOL TaskIsAssignedToCreator = [_homeMembersDict[@"UserID"] containsObject:itemCreatedBy];
    
    if (TaskIsCreatedByMe == YES ||
        TaskIsAssignedToCreator == NO) {
        
        NSMutableArray* actions = [[NSMutableArray alloc] init];
        
        UIAction *editAction = [self ItemPaymentMethodContextMenuInlineMenuEditAction];
        UIAction *deleteAction = [self ItemPaymentMethodContextMenuInlineMenuDeleteAction];
        
        [actions addObject:editAction];
        [actions addObject:deleteAction];
        
        UIMenu *inlineMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"" options:UIMenuOptionsDisplayInline children:actions];
        
        return inlineMenu;
    }
    
    return [UIMenu menuWithChildren:@[]];
}

-(UIAction *)ItemPaymentMethodContextMenuInlineMenuEditAction {
    
    UIAction *editAction = [UIAction actionWithTitle:@"Edit" image:[UIImage systemImageNamed:@"pencil"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Edit Payment Method"] completionHandler:^(BOOL finished) {
            
        }];
        
        [[[PushObject alloc] init] PushToViewPaymentMethodViewController:self->itemPaymentMethodDict viewingReward:NO comingFromAddTaskViewController:NO viewingItemDetails:NO currentViewController:self];
        
    }];
    
    return editAction;
}

-(UIAction *)ItemPaymentMethodContextMenuInlineMenuDeleteAction {
    
    UIAction *deleteAction = [UIAction actionWithTitle:@"Delete" image:[UIImage systemImageNamed:@"trash"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Delete Payment Method"] completionHandler:^(BOOL finished) {
            
        }];
        
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Are you sure you would like to delete the payment method?"] message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"Delete Payment Method" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Clicked Delete Payment Method"] completionHandler:^(BOOL finished) {
                
            }];
            
//            [self StartProgressView];
            
            NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
            
            NSMutableDictionary *defaultPaymentMethodDict = [@{@"ItemPaymentMethod" : @{@"PaymentMethod" : @"None", @"PaymentMethodData" : @"", @"PaymentMethodNotes" : @""}} mutableCopy];
            
            
            
            //Remove Loading
            
            [self UpdateAllDataInViewController:nil dictToUse:defaultPaymentMethodDict];
            
            //
            
            
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                NSMutableDictionary *itemPaymentMethod = [@{@"PaymentMethod" : @"None", @"PaymentMethodData" : @"", @"PaymentMethodNotes" : @""} mutableCopy];
                
                [[[SetDataObject alloc] init] UpdateDataEditItem:@{@"ItemPaymentMethod" : itemPaymentMethod} itemID:self->_itemID itemOccurrenceID:self->_itemOccurrenceID collection:self->itemTypeCollection homeID:homeID completionHandler:^(BOOL finished) {
                    
                    [self UpdateAllDataInViewController:nil dictToUse:defaultPaymentMethodDict];
                    
                }];
                
            });
            
        }];
        
        [deleteAction setValue:[UIColor systemRedColor] forKey:@"titleTextColor"];
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Delete Payment Method Cancelled %@ For %@", self->_itemID, self->itemType] completionHandler:^(BOOL finished) {
                
            }];
            
        }]];
        
        [actionSheet addAction:deleteAction];
        
        [self presentViewController:actionSheet animated:YES completion:nil];
        
    }];
    
    [deleteAction setAttributes:UIMenuElementAttributesDestructive];
    
    return deleteAction;
}

#pragma mark - Reward Context Menu Actions

-(UIAction *)ItemRewardContextMenuEditAction {
    
    UIAction *editAction = [UIAction actionWithTitle:@"Edit" image:[UIImage systemImageNamed:@"pencil"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Edit Reward"] completionHandler:^(BOOL finished) {
            
        }];
        
        [[[PushObject alloc] init] PushToViewPaymentMethodViewController:self->itemRewardDict viewingReward:YES comingFromAddTaskViewController:NO viewingItemDetails:NO currentViewController:self];
        
    }];
    
    return editAction;
}

-(UIAction *)ItemRewardContextMenuDeleteAction {
    
    UIAction *deleteAction = [UIAction actionWithTitle:@"Delete" image:[UIImage systemImageNamed:@"trash"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Delete Reward"] completionHandler:^(BOOL finished) {
            
        }];
        
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Are you sure you would like to delete the reward?"] message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"Delete Reward" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Clicked Delete Reward"] completionHandler:^(BOOL finished) {
                
            }];
            
//            [self StartProgressView];
            
            NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
            
            NSMutableDictionary *itemRewardDict = [@{@"ItemReward" : @{@"Reward" : @"None", @"RewardDescription" : @"", @"RewardNotes" : @""}} mutableCopy];
            
            
            
            //Remove Loading
            
            [self UpdateAllDataInViewController:nil dictToUse:itemRewardDict];
            
            //
            
            
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                NSMutableDictionary *itemReward = [@{@"Reward" : @"None", @"RewardDescription" : @"", @"RewardNotes" : @""} mutableCopy];
                
                [[[SetDataObject alloc] init] UpdateDataEditItem:@{@"ItemReward" : itemReward} itemID:self->_itemID itemOccurrenceID:self->_itemOccurrenceID collection:self->itemTypeCollection homeID:homeID completionHandler:^(BOOL finished) {
                    
                    [self UpdateAllDataInViewController:nil dictToUse:itemRewardDict];
                    
                }];
                
            });
            
        }];
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Delete Reward Cancelled %@ For %@", self->_itemID, self->itemType] completionHandler:^(BOOL finished) {
                
            }];
            
        }]];
        
        [deleteAction setValue:[UIColor systemRedColor] forKey:@"titleTextColor"];
        
        [actionSheet addAction:deleteAction];
        
        [self presentViewController:actionSheet animated:YES completion:nil];
        
    }];
    
    [deleteAction setAttributes:UIMenuElementAttributesDestructive];
    
    return deleteAction;
}

#pragma mark - UI Methods

-(void)StartProgressView {
    
    self->progressView = [MRProgressOverlayView showOverlayAddedTo:self.navigationController.view animated:YES];
    self->progressView.mode = MRProgressOverlayViewModeIndeterminateSmall;
    
}

-(void)AdjustScrollViewFrames {
    
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    CGFloat navigationBarHeight = [[[GeneralObject alloc] init] GetNavigationBarHeight:self];
    
    CGRect frameToUse = self->_lastCommentView.frame;
    
    if (self->NonUserCellsVisible == YES && self->_viewingOccurrence == NO) {
        frameToUse = self->_writeTaskContainerView.frame;
    } else {
        frameToUse = self->_lastCommentView.frame;
    }
    
    CGRect newRect = self->_customScrollView.frame;
    newRect.size.height = height - (height - frameToUse.origin.y) - navigationBarHeight;
    self->_customScrollView.frame = newRect;
    
}

-(void)AdjustTableViewFrames {
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    
    [UIView animateWithDuration:0.25 animations:^{
        
        int cellHeight = [self GenerateViewTaskCellHeightNo1];
        
        CGFloat subTasksTableViewHeight = cellHeight * [[self->itemSubTasksDict allKeys] count];
    
        NSMutableArray *arrayToUse = self->itemAssignedToArray;
        UIView *topView = self->_viewItemView;
        
        if (self->ListItemsVisible == YES) {
            arrayToUse = [[self->itemListItems allKeys] mutableCopy];
        }
        
        if (self->ItemizedItemsVisible == YES) {
            arrayToUse = [[self->itemItemizedItems allKeys] mutableCopy];
        }
        
        if ([self->itemType isEqualToString:@"Expense"] == YES && [self->itemPaymentMethodDict[@"PaymentMethod"] isEqualToString:@"None"] == NO) {
            topView = self->_viewPaymentMethodView;
        }
        
        if ([self->itemRewardDict[@"Reward"] isEqualToString:@"None"] == NO) {
            topView = self->_viewRewardView;
        }
        
      
        
        CGFloat customTableViewHeight = 10000;
        
        if (self->UserCellsVisible == YES) {
            
            customTableViewHeight = 0;
            
            for (NSString *userID in self->itemAssignedToArray) {
       
                NSUInteger index = [self->itemAssignedToArray indexOfObject:userID];
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
                
                int cellHeight = [self GenerateViewTaskCellHeight:indexPath];
                customTableViewHeight += cellHeight;
                
            }
            
        } else {
            
            int cellHeight = [self GenerateViewTaskCellHeightNo1];
            customTableViewHeight = (cellHeight * [arrayToUse count]);
            
        }
        
        
       
        CGFloat subTasksTableViewYPos = topView.frame.origin.y + (topView.frame.size.height) + (self.view.frame.size.height*0.017991 > 12?(12):self.view.frame.size.height*0.017991);
        CGFloat customTableViewYPos = subTasksTableViewHeight > 0 ?
        self->_subTasksTableView.frame.origin.y + subTasksTableViewHeight :
        topView.frame.origin.y + (topView.frame.size.height) + (self.view.frame.size.height*0.017991 > 12?(12):self.view.frame.size.height*0.017991);
        
        
        
        self->_subTasksTableView.frame = CGRectMake(0, subTasksTableViewYPos, width, subTasksTableViewHeight);
        self->_customTableView.frame = CGRectMake(0, customTableViewYPos, width, customTableViewHeight);
        
        
        
        CGFloat floatToUse =
        (self->_customTableView.frame.origin.y + self->_customTableView.frame.size.height) < self.customScrollView.frame.size.height + 1 ?
        self.customScrollView.frame.size.height + 1 : (self->_customTableView.frame.origin.y + self->_customTableView.frame.size.height);
        
        self->_customScrollView.contentSize = CGSizeMake(width, floatToUse);
        
    }];
    
}

#pragma mark View Frames

-(void)ViewWriteTaskInnerViews {
    
    CGFloat width = CGRectGetWidth(self.writeTaskView.bounds);
    CGFloat height = CGRectGetHeight(self.writeTaskView.bounds);
    
    self->_writeTaskTextField.frame = CGRectMake(width*0.10306, height*0.5 - ((height*1 - (height*0.28070))*0.5), width*0.5 - ((width*0.10306)*2), height*1 - (height*0.28070));
    self->_writeAssignedToTaskTextField.frame = CGRectMake(width - width*0.10306 - (width*0.5 - ((width*0.10306)*2)), height*0.5 - ((height*1 - (height*0.28070))*0.5), width*0.5 - ((width*0.10306)*2), height*1 - (height*0.28070));
    
    self->_writeTaskTextField.font = [UIFont systemFontOfSize:(self->_writeAssignedToTaskTextField.frame.size.width*0.15853659) > 14?(14):(self->_writeAssignedToTaskTextField.frame.size.width*0.15853659) weight:UIFontWeightSemibold];
    self->_writeAssignedToTaskTextField.font = [UIFont systemFontOfSize:(self->_writeAssignedToTaskTextField.frame.size.width*0.15853659) > 14?(14):(self->_writeAssignedToTaskTextField.frame.size.width*0.15853659) weight:UIFontWeightSemibold];
    
    self->_writeAssignedToTaskTextField.adjustsFontSizeToFitWidth = YES;
    self->_writeTaskTextField.adjustsFontSizeToFitWidth = YES;
    
}

-(void)ViewItemViewInnerViews {
    
    BOOL TaskIsRepeating = [[[BoolDataObject alloc] init] TaskIsRepeating:self->itemDict itemType:itemType];
    
    CGFloat height = ((self.view.frame.size.height*0.11005435 > 81?(81):self.view.frame.size.height*0.11005435)*0.7037037);
    CGFloat width = CGRectGetWidth(_viewItemView.bounds);
    
    
    
    _viewItemViewOverlay.frame = _viewItemView.frame;
    
    _viewItemImageView.frame = CGRectMake(width*0.04278075, height*0.5 - ((height*0.43859)*0.5), height*0.43859, height*0.43859);
    _viewItemEllipsisImage.frame = CGRectMake(width - width*0.04278075 - ((height*0.4385965)*0.24), height*0.5 - ((height*0.4385965)*0.5), ((height*0.4385965)*0.24), height*0.4385965);
    _viewItemEllipsisImage.image = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [UIImage imageNamed:@"GeneralIcons.Ellipsis.White"] : [UIImage imageNamed:@"GeneralIcons.Ellipsis"];
    
    
    
    CGFloat viewItemNameLabelXPos = width*0.04278075 + width*0.04278075 + height*0.43859;
    UIView *viewToSubtractFrom = TaskIsRepeating == NO ? _viewItemEllipsisImage : _viewItemEllipsisImage;
    
    _viewItemNameLabel.frame = CGRectMake(width*0.04278075 + width*0.04278075 + height*0.43859, height*0.14035, width - viewItemNameLabelXPos - (width - viewToSubtractFrom.frame.origin.x), height*0.29824561);
    _viewItemitemDueDateLabel.frame = CGRectMake(_viewItemNameLabel.frame.origin.x, _viewItemNameLabel.frame.origin.y + _viewItemNameLabel.frame.size.height + (height*0.12280702), _viewItemNameLabel.frame.size.width, height*0.26315789);
    
    
    
    CGFloat Imageheight = (self.view.frame.size.height*0.13505747 > 94?(94):self.view.frame.size.height*0.13505747);
    
    _viewItemItemPriorityImage.frame = CGRectMake(width - ((Imageheight*0.15957447 > 15?(15):Imageheight*0.15957447)*0.9) - (width - _viewItemEllipsisImage.frame.origin.x) - _viewItemImageView.frame.origin.x,  _viewItemNameLabel.frame.origin.y, ((Imageheight*0.15957447 > 15?(15):Imageheight*0.15957447)*0.9), ((Imageheight*0.15957447 > 15?(15):Imageheight*0.15957447)*0.9));
    
    _viewItemItemMutedImage.frame = CGRectMake(width - ((Imageheight*0.15957447 > 15?(15):Imageheight*0.15957447)*0.9) - (width - _viewItemEllipsisImage.frame.origin.x) - _viewItemImageView.frame.origin.x,  _viewItemNameLabel.frame.origin.y, ((Imageheight*0.15957447 > 15?(15):Imageheight*0.15957447)*0.9), ((Imageheight*0.15957447 > 15?(15):Imageheight*0.15957447)*0.9));
    _viewItemItemReminderImage.frame = CGRectMake(width - ((Imageheight*0.15957447 > 15?(15):Imageheight*0.15957447)*0.9) - (width - _viewItemEllipsisImage.frame.origin.x) - _viewItemImageView.frame.origin.x,  _viewItemNameLabel.frame.origin.y, ((Imageheight*0.15957447 > 15?(15):Imageheight*0.15957447)*0.9), ((Imageheight*0.15957447 > 15?(15):Imageheight*0.15957447)*0.9));
    _viewItemItemPrivateImage.frame = CGRectMake(width - ((Imageheight*0.15957447 > 15?(15):Imageheight*0.15957447)*1.25) - (width - _viewItemEllipsisImage.frame.origin.x) - _viewItemImageView.frame.origin.x,  _viewItemItemPriorityImage.frame.origin.y + _viewItemItemPriorityImage.frame.size.height*0.5 - ((((Imageheight*0.15957447 > 15?(15):Imageheight*0.15957447)*1.25))*0.5), ((Imageheight*0.15957447 > 15?(15):Imageheight*0.15957447)*1.25), ((Imageheight*0.15957447 > 15?(15):Imageheight*0.15957447)*1.25));
    
    
    
    BOOL UserShouldReceiveNotificationsForTask = [[[BoolDataObject alloc] init] UserShouldReceiveNotificationsForTask:self->itemDict itemType:itemType userID:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] homeMembersDict:_homeMembersDict];
    BOOL TaskHasBeenMuted = self->itemDict ? [[[BoolDataObject alloc] init] TaskHasBeenMuted:self->itemDict] : NO;
    BOOL TaskHasReminderNotification = self->itemDict ? [[[BoolDataObject alloc] init] TaskHasReminderNotification:self->itemDict] : NO;
    
    _viewItemItemMutedImage.hidden = TaskHasBeenMuted == NO || UserShouldReceiveNotificationsForTask == NO || [[[BoolDataObject alloc] init] PremiumSubscriptionIsOn] == NO ? YES : NO;
    _viewItemItemReminderImage.hidden = TaskHasReminderNotification == YES && TaskHasBeenMuted == NO ? NO : YES;
    _viewItemItemPrivateImage.hidden = [self->itemPrivate isEqualToString:@"Yes"] ? NO : YES;
    
    if ([self->itemPriority isEqualToString:@"No Priority"] == YES && (_viewItemItemMutedImage.hidden == NO || _viewItemItemReminderImage.hidden == NO) && _viewItemItemPrivateImage.hidden == NO) {
        
        UIImageView *viewToUse = _viewItemItemMutedImage.hidden == NO ? _viewItemItemMutedImage : _viewItemItemReminderImage;
        
        CGRect newRect = viewToUse.frame;
        newRect.origin.x = _viewItemItemPrivateImage.frame.origin.x - newRect.size.width - width*0.02139037;
        viewToUse.frame = newRect;
        
    } else if ([self->itemPriority isEqualToString:@"No Priority"] == NO && (_viewItemItemMutedImage.hidden == NO || _viewItemItemReminderImage.hidden == NO) && _viewItemItemPrivateImage.hidden == YES) {
        
        UIImageView *viewToUse = _viewItemItemMutedImage.hidden == NO ? _viewItemItemMutedImage : _viewItemItemReminderImage;
        
        CGRect newRect = viewToUse.frame;
        newRect.origin.x = _viewItemItemPriorityImage.frame.origin.x - newRect.size.width - width*0.02139037;
        viewToUse.frame = newRect;
        
    } else if ([self->itemPriority isEqualToString:@"No Priority"] == NO && (_viewItemItemMutedImage.hidden == YES && _viewItemItemReminderImage.hidden == YES) && _viewItemItemPrivateImage.hidden == NO) {
        
        CGRect newRect = _viewItemItemPrivateImage.frame;
        newRect.origin.x = _viewItemItemPriorityImage.frame.origin.x - newRect.size.width - width*0.02139037;
        _viewItemItemPrivateImage.frame = newRect;
        
    } else if ([self->itemPriority isEqualToString:@"No Priority"] == NO && (_viewItemItemMutedImage.hidden == NO || _viewItemItemReminderImage.hidden == NO) && _viewItemItemPrivateImage.hidden == NO) {
        
        UIImageView *viewToUse = _viewItemItemMutedImage.hidden == NO ? _viewItemItemMutedImage : _viewItemItemReminderImage;
        
        CGRect newRect = _viewItemItemPrivateImage.frame;
        newRect.origin.x = _viewItemItemPriorityImage.frame.origin.x - newRect.size.width - width*0.02139037;
        _viewItemItemPrivateImage.frame = newRect;
        
        newRect = viewToUse.frame;
        newRect.origin.x = _viewItemItemPrivateImage.frame.origin.x - newRect.size.width - width*0.02139037;
        viewToUse.frame = newRect;
        
    }
    
    
    
    _viewItemItemColor.frame = CGRectMake(_viewItemItemPriorityImage.frame.origin.x, _viewItemitemDueDateLabel.frame.origin.y, _viewItemItemPriorityImage.frame.size.width, _viewItemItemPriorityImage.frame.size.width);
    _viewItemItemColor.layer.cornerRadius = _viewItemItemColor.frame.size.height/3;
    
    CGRect newRect = _viewItemNameLabel.frame;
    newRect.size.width = width - newRect.origin.x - (width - _viewItemItemPriorityImage.frame.origin.x) - _viewItemImageView.frame.origin.x;
    _viewItemNameLabel.frame = newRect;
    
    newRect = _viewItemitemDueDateLabel.frame;
    newRect.size.width = _viewItemNameLabel.frame.size.width;
    _viewItemitemDueDateLabel.frame = newRect;
    
    
    
    _progressBarOne.frame = CGRectMake(_viewItemNameLabel.frame.origin.x, _viewItemitemDueDateLabel.frame.origin.y + (_viewItemitemDueDateLabel.frame.size.height*0.5 - 5*0.5), (width*0.2 > 69?(69):width*0.2), 5);
    _progressBarTwo.frame = CGRectMake(_progressBarOne.frame.origin.x, _progressBarOne.frame.origin.y, 0, _progressBarOne.frame.size.height);
    _percentageLabel.frame = CGRectMake(_progressBarOne.frame.origin.x + _progressBarOne.frame.size.width + 8, _viewItemitemDueDateLabel.frame.origin.y, width - (_progressBarOne.frame.origin.x + _progressBarOne.frame.size.width + 8), _viewItemitemDueDateLabel.frame.size.height);
    
    _progressBarOne.layer.cornerRadius = _progressBarOne.frame.size.height/2;
    _progressBarTwo.layer.cornerRadius = _progressBarTwo.frame.size.height/2;
    
    
    
    _viewItemNameLabel.font = [UIFont systemFontOfSize:_viewItemNameLabel.frame.size.height*0.88235294 weight:UIFontWeightSemibold];
    _viewItemitemDueDateLabel.font = [UIFont systemFontOfSize:_viewItemitemDueDateLabel.frame.size.height*0.86666667 weight:UIFontWeightSemibold];
    
    _viewItemitemDueDateLabel.adjustsFontSizeToFitWidth = YES;
    
    _percentageLabel.font = _viewItemitemDueDateLabel.font;
    
    _viewItemImageView.layer.cornerRadius = (_viewItemImageView.frame.size.height*0.2181818182);
    _viewItemImageView.clipsToBounds = YES;
    _viewItemImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    
    
    _viewItemView.layer.borderWidth = 0.0;
    _viewItemView.layer.shadowColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeShadow].CGColor : [[[LightDarkModeObject alloc] init] LightModeShadow].CGColor;
    _viewItemView.layer.shadowRadius = 5;
    _viewItemView.layer.shadowOpacity = 1.0;
    _viewItemView.layer.shadowOffset = CGSizeMake(0, 0);
    
    
    
    
    
    
    
    UIView *viewToRepalTagFrom = _viewItemNotesLabel;
    
    if (self->itemNotes.length == 0) {
        
        viewToRepalTagFrom = _viewItemitemDueDateLabel;
        
        _viewItemNotesLabel.frame = CGRectMake(width*0.04278075, _viewItemitemDueDateLabel.frame.origin.y + _viewItemitemDueDateLabel.frame.size.height + (self.view.frame.size.height*0.01086957), _viewItemitemDueDateLabel.frame.size.width, 0);
        
    }
    
    for (UIButton *subView in _viewItemView.subviews) {
        
        if (subView.tag == 100) {
            
            [subView removeFromSuperview];
            
        }
        
    }
    
    NSMutableArray *itemTagsLocal = [itemTagsArray mutableCopy];
    
    NSMutableArray *tagSubViews = [NSMutableArray array];
    CGFloat tabSubViewHeight = (height*0.21052632 > 12?(12):height*0.21052632);
    
    int totalLines = 1;
    
    for (int i=0; i<itemTagsLocal.count; i++) {
        
        NSString *tagText = [NSString stringWithFormat:@"#%@", itemTagsLocal[i]];
        
        BOOL changeYPos = false;
        
        BOOL TagAlreadyAdded = NO;
        
        for (UIButton *subView in _viewItemView.subviews) {
            
            if (subView.tag == 100) {
                
                [tagSubViews addObject:subView];
                
                if ([subView.titleLabel.text isEqualToString:tagText]) {
                    TagAlreadyAdded = YES;
                }
                
            }
            
        }
        
        if (TagAlreadyAdded == NO) {
            
            NSString *tagText = [NSString stringWithFormat:@"#%@", itemTagsLocal[i]];
            CGFloat gapBetweenStartAndEndHorizontalTags = _viewItemImageView.frame.origin.x;
            CGFloat gapBetweenTagsToUse = (width*0.01604278 > 6?(6):width*0.01604278);
            CGFloat yGapToUse = (height*0.10526316 > 6?(6):height*0.10526316);
            UIButton *lastHorizontalSubView = [(UIButton *)[tagSubViews lastObject] tag] == 100 ? [tagSubViews lastObject] : nil;
            CGFloat xPos = lastHorizontalSubView != nil ? lastHorizontalSubView.frame.origin.x + lastHorizontalSubView.frame.size.width + gapBetweenTagsToUse : gapBetweenStartAndEndHorizontalTags;
            
            CGFloat tagWidth = [[[GeneralObject alloc] init] WidthOfString:tagText withFont:[UIFont systemFontOfSize:tabSubViewHeight*1.083333 weight:UIFontWeightSemibold]];
            
            if (xPos + tagWidth > (_viewItemView.frame.size.width-(gapBetweenStartAndEndHorizontalTags*2))) {
                
                xPos = gapBetweenStartAndEndHorizontalTags;
                changeYPos = true;
                totalLines += 1;
                
            }
            
            yGapToUse = totalLines == 1 ? (self.view.frame.size.height*0.01086957) : (height*0.14035088 > 8?(8):height*0.14035088);
            
            CGFloat yPos = changeYPos == true ?
            lastHorizontalSubView.frame.origin.y + lastHorizontalSubView.frame.size.height + yGapToUse :
            lastHorizontalSubView.frame.origin.y != 0 ?
            lastHorizontalSubView.frame.origin.y : viewToRepalTagFrom.frame.origin.y + viewToRepalTagFrom.frame.size.height + yGapToUse;
            
            UIButton *tagLabelSubview = [[UIButton alloc] initWithFrame:CGRectMake(xPos, yPos, tagWidth, tabSubViewHeight)];
            [tagLabelSubview.titleLabel setFont:[UIFont systemFontOfSize:tabSubViewHeight*1.083333 weight:UIFontWeightSemibold]];
            [tagLabelSubview setTitleColor:[UIColor colorWithRed:90.0f/255.0f green:123.0f/255.0f blue:165.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
            tagLabelSubview.tag = 100;
            [tagLabelSubview setTitle:tagText forState:UIControlStateNormal];
            [tagLabelSubview addTarget:self action:@selector(TapGestureSelectTag:) forControlEvents:UIControlEventTouchUpInside];
            [_viewItemView addSubview:tagLabelSubview];
            
        }
        
    }
    
    if (itemTagsLocal.count > 0) {
        
        CGFloat addY = itemNotes.length > 0 ? (self.view.frame.size.height*0.01086957) : 0;
        
        CGRect rect = _viewItemView.frame;
        rect.size.height = _viewItemNotesLabel.frame.origin.y + _viewItemNotesLabel.frame.size.height + (((height*0.14035088 > 8?(8):height*0.14035088))*(totalLines)) + tabSubViewHeight*totalLines + addY;
        _viewItemView.frame = rect;
        
    }
    
}

-(void)ViewRewardViewInnerViews {
    
    CGFloat height = ((self.view.frame.size.height*0.11005435 > 81?(81):self.view.frame.size.height*0.11005435)*0.7037037);
    CGFloat width = CGRectGetWidth(_viewRewardView.bounds);
    
    _viewRewardViewOverlay.frame = _viewRewardView.frame;
    
    _viewRewardEllipsisImage.frame = CGRectMake(width - width*0.04278075 - ((height*0.4385965)*0.24), height*0.5 - ((height*0.4385965)*0.5), ((height*0.4385965)*0.24), height*0.4385965);
    
    CGFloat viewItemNameLabelXPos = width*0.04278075 + width*0.04278075 + height*0.43859;
    UIView *viewToSubtractFrom = _viewRewardEllipsisImage;
    
    _viewRewardImage.frame = CGRectMake(width*0.04278075, height*0.14035, height*0.29824561, height*0.29824561);
    _viewRewardNameLabel.frame = CGRectMake(_viewRewardImage.frame.origin.x + _viewRewardImage.frame.size.width + (self.view.frame.size.height*0.01086957), height*0.14035, width - viewItemNameLabelXPos - (width - viewToSubtractFrom.frame.origin.x), height*0.29824561);
    _viewRewardDescriptionLabel.frame = CGRectMake(width*0.04278075, _viewRewardNameLabel.frame.origin.y + _viewRewardNameLabel.frame.size.height + (height*0.12280702), width - ((width*0.04278075)*2), height*0.26315789);
    
    _viewRewardNotesLabel.frame = CGRectMake(width*0.04278075, _viewRewardDescriptionLabel.frame.origin.y + _viewRewardDescriptionLabel.frame.size.height + (self.view.frame.size.height*0.01086957), width - ((width*0.04278075)*2), 0);
    
    
    
    _viewRewardNameLabel.font = _viewItemNameLabel.font;
    _viewRewardDescriptionLabel.font = _viewItemitemDueDateLabel.font;
    _viewRewardNotesLabel.font = _viewItemNotesLabel.font;
    
    
    
    _viewRewardView.layer.borderWidth = 0.0;
    _viewRewardView.layer.shadowColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeShadow].CGColor : [[[LightDarkModeObject alloc] init] LightModeShadow].CGColor;
    _viewRewardView.layer.shadowRadius = 5;
    _viewRewardView.layer.shadowOpacity = 1.0;
    _viewRewardView.layer.shadowOffset = CGSizeMake(0, 0);
    
}

-(void)ViewPaymentMethodViewInnerViews {
    
    CGFloat height = ((self.view.frame.size.height*0.11005435 > 81?(81):self.view.frame.size.height*0.11005435)*0.7037037);
    CGFloat width = CGRectGetWidth(_viewPaymentMethodView.bounds);
    
    _viewPaymentMethodViewOverlay.frame = _viewPaymentMethodView.frame;
    
    _viewPaymentMethodEllipsisImage.frame = CGRectMake(width - width*0.04278075 - ((height*0.4385965)*0.24), height*0.5 - ((height*0.4385965)*0.5), ((height*0.4385965)*0.24), height*0.4385965);
    
    CGFloat viewItemNameLabelXPos = width*0.04278075 + width*0.04278075 + height*0.43859;
    UIView *viewToSubtractFrom = _viewPaymentMethodEllipsisImage;
    
    _viewPaymentMethodNameLabel.frame = CGRectMake(width*0.04278075, height*0.14035, width - viewItemNameLabelXPos - (width - viewToSubtractFrom.frame.origin.x), height*0.29824561);
    _viewPaymentMethodDataLabel.frame = CGRectMake(_viewPaymentMethodNameLabel.frame.origin.x, _viewPaymentMethodNameLabel.frame.origin.y + _viewPaymentMethodNameLabel.frame.size.height + (height*0.12280702), _viewPaymentMethodNameLabel.frame.size.width, height*0.26315789);
    
    _viewPaymentMethodNotesLabel.frame = CGRectMake(width*0.04278075, _viewPaymentMethodDataLabel.frame.origin.y + _viewPaymentMethodDataLabel.frame.size.height + (self.view.frame.size.height*0.01086957), width - ((width*0.04278075)*2), 0);
    
    
    
    _viewPaymentMethodNameLabel.font = _viewItemNameLabel.font;
    _viewPaymentMethodDataLabel.font = _viewItemitemDueDateLabel.font;
    _viewPaymentMethodNotesLabel.font = _viewItemNotesLabel.font;
    
    
    
    _viewPaymentMethodView.layer.borderWidth = 0.0;
    _viewPaymentMethodView.layer.shadowColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeShadow].CGColor : [[[LightDarkModeObject alloc] init] LightModeShadow].CGColor;
    _viewPaymentMethodView.layer.shadowRadius = 5;
    _viewPaymentMethodView.layer.shadowOpacity = 1.0;
    _viewPaymentMethodView.layer.shadowOffset = CGSizeMake(0, 0);
    
}

#pragma mark View Hidden Status

-(void)GenerateWriteTaskHiddenStatus {
    
    BOOL TaskWasCreatedByMe = [[[BoolDataObject alloc] init] TaskWasCreatedBySpecificUser:self->itemDict itemType:itemType userID:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
    BOOL TaskIsAssignedToMe = [[[BoolDataObject alloc] init] TaskWasAssignedToSpecificUser:self->itemDict itemType:itemType userID:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
    BOOL TaskIsAssignedToNobody = [[[BoolDataObject alloc] init] TaskIsAssignedToNobody:self->itemDict itemType:itemType];
    
    if ((TaskWasCreatedByMe || TaskIsAssignedToMe == YES || TaskIsAssignedToNobody == YES) && NonUserCellsVisible == YES && self->_viewingOccurrence == NO) {
        
        self.writeTaskView.hidden = NO;
        self.writeTaskView.userInteractionEnabled = YES;
        
    } else {
        
        self.writeTaskView.hidden = YES;
        self.writeTaskView.userInteractionEnabled = NO;
        
    }
    
}

-(void)GeneratePaymentMethodViewHiddenStatus {
    
    if ([self->itemType isEqualToString:@"Expense"] == NO || [self->itemPaymentMethodDict[@"PaymentMethod"] isEqualToString:@"None"] == YES) {
        
        self->_viewPaymentMethodView.hidden = YES;
        self->_viewPaymentMethodViewOverlay.hidden = YES;
        self->_viewPaymentMethodViewOverlay.userInteractionEnabled = NO;
        
    } else {
        
        self->_viewPaymentMethodView.hidden = NO;
        self->_viewPaymentMethodViewOverlay.hidden = NO;
        self->_viewPaymentMethodViewOverlay.userInteractionEnabled = YES;
        
    }
    
    [_viewPaymentMethodViewOverlay setTitle:@"" forState:UIControlStateNormal];
    
}

-(void)GenerateRewardViewHiddenStatus {
    
    if ([self->itemRewardDict[@"Reward"] isEqualToString:@"None"] == YES) {
        
        self->_viewRewardView.hidden = YES;
        self->_viewRewardViewOverlay.hidden = YES;
        self->_viewRewardViewOverlay.userInteractionEnabled = NO;
        
    } else {
        
        self->_viewRewardView.hidden = NO;
        self->_viewRewardViewOverlay.hidden = NO;
        self->_viewRewardViewOverlay.userInteractionEnabled = YES;
        
    }
    
    [_viewRewardViewOverlay setTitle:@"" forState:UIControlStateNormal];
    
}

#pragma mark View Frames

-(void)UpdateTopViewLabel:(NSString *)topViewLabelString {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self->topViewImageView.hidden = NO;
        
        self->topViewLabel.text = topViewLabelString;
        
        CGRect newRect;
        
        newRect = self->topViewLabel.frame;
        newRect.size.width = [[[GeneralObject alloc] init] WidthOfString:topViewLabelString withFont:self->topViewLabel.font];
        self->topViewLabel.frame = newRect;
        
        newRect = self->topView.frame;
        newRect.size.width = self->topViewLabel.frame.size.width;
        newRect.origin.x = self.view.frame.size.width*0.5 - newRect.size.width*0.5;
        self->topView.frame = newRect;
        
        newRect = self->topViewImageView.frame;
        newRect.origin.x = self->topView.frame.size.width + 4;
        self->topViewImageView.frame = newRect;
        
        newRect = self->topViewCover.frame;
        newRect = self->topView.frame;
        newRect.size.width = self->topViewLabel.frame.size.width + self->topViewImageView.frame.size.width;
        self->topViewCover.frame = newRect;
        
        [self SetUpTopLabelContextMenu];
        
    });
    
}

#pragma mark - UX Methods

-(void)GenerateKeyBoardToolBar:(BOOL)Name Assigned:(BOOL)Assigned Reminder:(BOOL)Reminder {
    
    UIToolbar* keyboardToolbar = [[UIToolbar alloc] init];
    
    [keyboardToolbar sizeToFit];
    
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                      target:nil action:nil];
    
    UIBarButtonItem *anytimeBarButton = [[UIBarButtonItem alloc]
                                         initWithTitle:@"Add Item" style:UIBarButtonItemStyleDone target:self action:@selector(AddListItemItemTypeList:)];
    
    if (_viewingViewExpenseViewController == YES) {
        
        anytimeBarButton = [[UIBarButtonItem alloc]
                            initWithTitle:@"Add Item" style:UIBarButtonItemStyleDone target:self action:@selector(AddItemizedItemItemTypeExpense:)];
        
    }
    
    UIBarButtonItem *anyoneBarButton = [[UIBarButtonItem alloc]
                                        initWithTitle:@"Anybody" style:UIBarButtonItemStyleDone target:self action:@selector(AssignedTo_Anybody)];
    
    if (Name && Reminder == NO) {
        keyboardToolbar.items = @[flexBarButton, anytimeBarButton];
        self.writeTaskTextField.inputAccessoryView = keyboardToolbar;
    }
    
    if (Assigned) {
        keyboardToolbar.items = @[anyoneBarButton, flexBarButton, anytimeBarButton];
        self.writeAssignedToTaskTextField.inputAccessoryView = keyboardToolbar;
    }
    
}

-(void)GenerateSectionDictionary {
    
//    if (ListItemsVisible == YES) {
//        
//        itemListSectionsArray = [NSMutableArray array];
//        
//        NSMutableDictionary *completedDict = [NSMutableDictionary dictionary];
//        NSMutableDictionary *inProgressDict = [NSMutableDictionary dictionary];
//        NSMutableDictionary *uncompletedDict = [NSMutableDictionary dictionary];
//        NSMutableDictionary *wontDoDict = [NSMutableDictionary dictionary];
//        
//        for (NSString *item in [itemListItems allKeys]) {
//            
//            if ([[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemCompletedDict userIDToFind:item] == YES && [[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemInProgressDict userIDToFind:item] == NO && ([[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemWontDoDict userIDToFind:item] == NO)) {
//                [completedDict setObject:itemListItems[item] forKey:item];
//            } else if ([[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemInProgressDict userIDToFind:item] == YES) {
//                [inProgressDict setObject:itemListItems[item] forKey:item];
//            } else if ([[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemWontDoDict userIDToFind:item] == YES) {
//                [wontDoDict setObject:itemListItems[item] forKey:item];
//            } else {
//                [uncompletedDict setObject:itemListItems[item] forKey:item];
//            }
//            
//        }
//        
//        [itemListSectionsArray addObject:uncompletedDict];
//        [itemListSectionsArray addObject:inProgressDict];
//        [itemListSectionsArray addObject:completedDict];
//        [itemListSectionsArray addObject:wontDoDict];
//        
//    } else if (ItemizedItemsVisible == YES) {
//        
//        itemItemizedSectionsArray = [NSMutableArray array];
//        
//        NSMutableDictionary *completedDict = [NSMutableDictionary dictionary];
//        NSMutableDictionary *inProgressDict = [NSMutableDictionary dictionary];
//        NSMutableDictionary *uncompletedDict = [NSMutableDictionary dictionary];
//        NSMutableDictionary *wontDoDict = [NSMutableDictionary dictionary];
//        
//        for (NSString *item in [itemItemizedItems allKeys]) {
//            
//            if (([[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemCompletedDict userIDToFind:item] == YES) && ([[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemInProgressDict userIDToFind:item] == NO) && ([[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemWontDoDict userIDToFind:item] == NO)) {
//                [completedDict setObject:itemItemizedItems[item] forKey:item];
//            } else if ([[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemInProgressDict userIDToFind:item] == YES) {
//                [inProgressDict setObject:itemItemizedItems[item] forKey:item];
//            } else if ([[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemWontDoDict userIDToFind:item] == YES) {
//                [wontDoDict setObject:itemItemizedItems[item] forKey:item];
//            } else {
//                [uncompletedDict setObject:itemItemizedItems[item] forKey:item];
//            }
//            
//        }
//        
//        [itemItemizedSectionsArray addObject:uncompletedDict];
//        [itemItemizedSectionsArray addObject:inProgressDict];
//        [itemItemizedSectionsArray addObject:completedDict];
//        [itemItemizedSectionsArray addObject:wontDoDict];
//        
//    }
    
}

-(void)GenerateReminderFrequencyArray {
    
    frequencyReminderAmountArray = [[NSMutableArray alloc] init];
    frequencyReminderFrequencyArray = [[NSMutableArray alloc] init];
    
    NSString *sStr = @"s";
    
    if (reminderAmountComp != NULL && [reminderAmountComp isEqualToString:@"1"]) {
        sStr = @"";
    }
    
    if ([itemRepeats isEqualToString:@"Never"] == NO && [self->itemRepeatIfCompletedEarly isEqualToString:@"Yes"] == NO && itemRepeats.length > 0) {
        
        frequencyReminderAmountArray = [[NSMutableArray alloc] init];
        for (int i=1;i<61;i++) {
            [frequencyReminderAmountArray addObject:[NSString stringWithFormat:@"%d", i]];
        }
        
        BOOL TaskIsRepeatingDaily = [[[BoolDataObject alloc] init] TaskIsRepeatingDaily:[@{@"ItemRepeats" : itemRepeats} mutableCopy] itemType:itemType];
        BOOL TaskIsRepeatingWeekly = [[[BoolDataObject alloc] init] TaskIsRepeatingWeekly:[@{@"ItemRepeats" : itemRepeats} mutableCopy] itemType:itemType];
        BOOL TaskIsRepeatingMonthly = [[[BoolDataObject alloc] init] TaskIsRepeatingMonthly:[@{@"ItemRepeats" : itemRepeats} mutableCopy] itemType:itemType];
        
        if (TaskIsRepeatingDaily) {
            
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
        
    } else if ([itemRepeats isEqualToString:@"Never"] == YES || [self->itemRepeatIfCompletedEarly isEqualToString:@"Yes"] == YES || itemRepeats.length == 0) {
        
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
    
    [(UIPickerView *)_writeTaskTextField.inputView reloadAllComponents];
    
}

-(NSString *)GenerateItemDueDateLabelText {
    
    NSString *dateFormat = @"MMMM dd, yyyy hh:mm a";
    NSString *dateFormatSecondary = @"MMMM dd, yyyy h:mm a";
    
    NSDate *itemDueDateInDateForm = [[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:self->itemDueDate returnAs:[NSDate class]];
    NSDate *itemDueDateInDateFormSecondary = [[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormatSecondary dateToConvert:self->itemDueDate returnAs:[NSDate class]];
    
    BOOL DueDateIsNotValid =
    ([self->itemDueDate isEqualToString:@"No Due Date"] ||
     self->itemDueDate.length == 0 ||
     (itemDueDateInDateForm == NULL &&
      itemDueDateInDateForm == nil &&
      itemDueDateInDateFormSecondary == NULL &&
      itemDueDateInDateFormSecondary == nil));
    
    if (DueDateIsNotValid == YES) {
        return @"No Due Date";
    }
    
    
    
    NSString *itemitemDueDateLabelText = [self GenerateDueDateInReadableFormat:itemDueDateInDateForm];
    itemitemDueDateLabelText = [self GenerateDueDateIfScheduledToStart:itemitemDueDateLabelText];
    itemitemDueDateLabelText = [self GenerateDueDateIfPaused:itemitemDueDateLabelText];
    
    
    
    return itemitemDueDateLabelText;
}

-(void)AssignedTo_Anybody {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:@"Anybody" completionHandler:^(BOOL finished) {
        
    }];
    
    twoCompOne = @"Anybody";
    _writeAssignedToTaskTextField.text = @"Anybody";
    
}

-(void)DismissAllKeyboards {
    
    [self.writeTaskTextField resignFirstResponder];
    [self.writeAssignedToTaskTextField resignFirstResponder];
    
}

-(NSString *)GenerateDataForSpeificItemAtIndex:(NSIndexPath *)indexPath {
    
    NSString *markedObject = @"";
    
    if (ListItemsVisible == YES) {
        
        NSArray *keysArray = itemListItems /*[itemListSectionsArray count] > indexPath.section*/ ? [itemListItems allKeys] /*[itemListSectionsArray[indexPath.section] allKeys]*/ : @[];
        NSArray *sortedKeysArray = [keysArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        NSString *listItem = [sortedKeysArray count] > indexPath.row ? sortedKeysArray[indexPath.row] : @"";
        
        markedObject = listItem;
        
    } else if (ItemizedItemsVisible == YES) {
        
        NSArray *keysArray = itemItemizedItems /*[itemItemizedSectionsArray count] > indexPath.section*/ ? [itemItemizedItems allKeys] /*[itemItemizedSectionsArray[indexPath.section] allKeys]*/ : @[];
        NSArray *sortedKeysArray = [keysArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        NSString *itemizedItem = [sortedKeysArray count] > indexPath.row ? sortedKeysArray[indexPath.row] : @"";
        
        markedObject = itemizedItem;
        
    } else {
        
        NSMutableDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:itemAssignedToArray[indexPath.row] homeMembersDict:_homeMembersDict];
        NSString *userID = dataDict[@"UserID"];
        
        markedObject = userID;
        
    }
    
    return markedObject;
}

-(void)GenerateUpdateDueDateAlertView:(NSMutableDictionary *)singleObjectItemDict completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDictToUse))finishBlock {
    
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
    
    if (TaskWasCreatedBySpecificUser == YES && 
        TaskIsPastDue == YES &&
        TaskIsRepeating == YES &&
        TaskIsRepeatingDaily == NO &&
        DontShowAgainClicked == NO) {
        
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
            
            BOOL TaskIsRepeatingWeekly = [[[BoolDataObject alloc] init] TaskIsRepeatingWeekly:[@{@"ItemRepeats" : singleObjectItemDict[@"ItemRepeats"]} mutableCopy] itemType:self->itemType];
            BOOL TaskIsRepeatingMonthly = [[[BoolDataObject alloc] init] TaskIsRepeatingMonthly:[@{@"ItemRepeats" : singleObjectItemDict[@"ItemRepeats"]} mutableCopy] itemType:self->itemType];
            
            if (TaskIsRepeatingWeekly == YES) {
                [singleObjectItemDict setObject:weekdayStr forKey:@"ItemDays"];
            } else if (TaskIsRepeatingMonthly == YES) {
                [singleObjectItemDict setObject:dayString forKey:@"ItemDays"];
            }
            
            NSString *newItemDueDate = [[[NotificationsObject alloc] init] GenerateArrayOfRepeatingDueDates:singleObjectItemDict[@"ItemRepeats"] itemRepeatIfCompletedEarly:singleObjectItemDict[@"ItemRepeatIfCompletedEarly"] itemCompleteAsNeeded:singleObjectItemDict[@"ItemCompleteAsNeeded"] totalAmountOfFutureDates:2 maxAmountOfDueDatesToLoopThrough:1000 itemDatePosted:singleObjectItemDict[@"ItemDatePosted"] itemDueDate:singleObjectItemDict[@"ItemDueDate"] itemStartDate:singleObjectItemDict[@"ItemStartDate"] itemEndDate:singleObjectItemDict[@"ItemEndDate"] itemTime:singleObjectItemDict[@"ItemTime"] itemDays:singleObjectItemDict[@"ItemDays"] itemDueDatesSkipped:singleObjectItemDict[@"ItemDueDatesSkipped"] itemDateLastReset:singleObjectItemDict[@"ItemDateLastReset"] SkipStartDate:NO][0];
            
            [singleObjectItemDict setObject:newItemDueDate forKey:@"ItemDueDate"];
            
            [[[SetDataObject alloc] init] UpdateDataEditItem:@{@"ItemUniqueID" : singleObjectItemDict[@"ItemUniqueID"], @"ItemDays" : singleObjectItemDict[@"ItemDays"], @"ItemDueDate" : singleObjectItemDict[@"ItemDueDate"]} itemID:singleObjectItemDict[@"ItemID"] itemOccurrenceID:singleObjectItemDict[@"ItemOccurrenceID"] collection:self->itemTypeCollection homeID:self->homeID completionHandler:^(BOOL finished) {
                
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

#pragma mark - NSNotification Methods

-(void)NSNotification_ViewTask_EditTask:(NSNotification *)notification {
    
    NSDictionary *userInfo = notification.userInfo ? notification.userInfo  : [NSDictionary dictionary];
   
    [self UpdateAllDataInViewController:nil dictToUse:[userInfo mutableCopy]];
    
}

-(void)NSNotification_ViewTask_ReloadTask:(NSNotification *)notification {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self QueryInitialData];
        
    });
    
}

#pragma mark

-(void)NSNotification_ViewTask_ItemTags:(NSNotification *)notification {
    
    NSDictionary *userInfo = notification.userInfo;
    
    NSMutableArray *itemTags = userInfo[@"Tags"] ? userInfo[@"Tags"] : [NSMutableArray array];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"StopDoneActionReloadTableView"];
    
//    [self StartProgressView];
    
    
    
    //Remove Loading
    
    [self UpdateAllDataInViewController:nil dictToUse:[@{@"ItemTags" : itemTags} mutableCopy]];
    
    //
    
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[SetDataObject alloc] init] UpdateDataEditItem:@{@"ItemTags" : itemTags} itemID:self->_itemID itemOccurrenceID:self->_itemOccurrenceID collection:self->itemTypeCollection homeID:self->homeID completionHandler:^(BOOL finished) {
            
            [self UpdateAllDataInViewController:nil dictToUse:[@{@"ItemTags" : itemTags} mutableCopy]];
            
        }];
        
    });
    
}

-(void)NSNotification_ViewTask_ItemReward:(NSNotification *)notification {
    
    NSDictionary *userInfo = notification.userInfo;
    
    NSMutableDictionary *itemReward = userInfo[@"Reward"] ? userInfo[@"Reward"] : [@{@"Reward" : @"None", @"RewardDescription" : @"", @"RewardNotes" : @""} mutableCopy];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"StopDoneActionReloadTableView"];
    
//    [self StartProgressView];
    
    
  
    //Remove Loading
    
    [self UpdateAllDataInViewController:nil dictToUse:[@{@"ItemReward" : itemReward} mutableCopy]];
    
    //
    
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[SetDataObject alloc] init] UpdateDataEditItem:@{@"ItemReward" : itemReward} itemID:self->_itemID itemOccurrenceID:self->_itemOccurrenceID collection:self->itemTypeCollection homeID:self->homeID completionHandler:^(BOOL finished) {
            
            [self UpdateAllDataInViewController:nil dictToUse:[@{@"ItemReward" : itemReward} mutableCopy]];
            
        }];
        
    });
    
}

-(void)NSNotification_ViewTask_ItemPaymentMethod:(NSNotification *)notification {
    
    NSDictionary *userInfo = notification.userInfo;
    
    NSMutableDictionary *itemPaymentMethod = userInfo[@"PaymentMethod"] ? userInfo[@"PaymentMethod"] : [@{@"PaymentMethod" : @"None", @"PaymentMethodData" : @"", @"PaymentMethodNotes" : @""} mutableCopy];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"StopDoneActionReloadTableView"];
    
//    [self StartProgressView];
    
    
    
    //Remove Loading
    
    [self UpdateAllDataInViewController:nil dictToUse:[@{@"ItemPaymentMethod" : itemPaymentMethod} mutableCopy]];
    
    //
    
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[SetDataObject alloc] init] UpdateDataEditItem:@{@"ItemPaymentMethod" : itemPaymentMethod} itemID:self->_itemID itemOccurrenceID:self->_itemOccurrenceID collection:self->itemTypeCollection homeID:self->homeID completionHandler:^(BOOL finished) {
            
            [self UpdateAllDataInViewController:nil dictToUse:[@{@"ItemPaymentMethod" : itemPaymentMethod} mutableCopy]];
            
        }];
        
    });
    
}

-(void)NSNotification_ViewTask_ItemCustomReminder:(NSNotification *)notification {
    
    dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        
        NSDictionary *userInfo = notification.userInfo;
        
        NSString *customReminderString = userInfo[@"CustomReminder"] && [userInfo[@"CustomReminder"] length] > 0 ? userInfo[@"CustomReminder"] : @"Never";
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self->progressView setHidden:YES];
            [self SetUpItemViewContextMenu];
            
        });
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [[[NotificationsObject alloc] init] ResetLocalNotificationCustomReminderNotification_LocalOnly:customReminderString itemType:self->itemType dictToUse:self->itemDict homeMembersDict:self->_homeMembersDict homeMembersArray:self->_homeMembersArray  allItemTagsArrays:self->_allItemTagsArrays completionHandler:^(BOOL finished) {
                
            }];
            
        });
        
    });
    
}

-(void)NSNotification_ViewTask_ItemComments:(NSNotification *)notification {
    
    [self QueryLastComment];
    
}

#pragma mark

-(void)NSNotification_ViewTask_AddTaskToTaskList:(NSNotification *)notification {
    
    NSMutableDictionary *userInfo = [notification.userInfo mutableCopy];
    
    if (userInfo[@"runOnBackgroundThread"]) { [userInfo removeObjectForKey:@"runOnBackgroundThread"]; }
    
    NSString *taskListID = userInfo[@"TaskListID"];
    NSString *itemUniqueID = userInfo[@"ItemUniqueID"];
    
    
    NSUInteger index = [self->_taskListDict[@"TaskListID"] containsObject:taskListID] ? [self->_taskListDict[@"TaskListID"] indexOfObject:taskListID] : 1000;
    
    if (index != 1000) {
        
        NSMutableDictionary *taskListDictCopy = [self->_taskListDict mutableCopy];
        NSMutableArray *taskListItemsArray = [taskListDictCopy[@"TaskListItems"] mutableCopy];
        NSMutableDictionary *taskListItems = [taskListItemsArray[index] mutableCopy];
        
        if ([[taskListItems allKeys] containsObject:itemUniqueID] == NO) {
            [taskListItems setObject:@{@"ItemUniqueID" : itemUniqueID} forKey:itemUniqueID];
        }
        
        [taskListItemsArray replaceObjectAtIndex:index withObject:taskListItems];
        [taskListDictCopy setObject:taskListItemsArray forKey:@"TaskListItems"];
        self->_taskListDict = [taskListDictCopy mutableCopy];
        
        
        
        NSString *taskListName = [taskListDictCopy[@"TaskListName"][index] mutableCopy];
        [self UpdateTopViewLabel:taskListName];
        
    }
    
}

-(void)NSNotification_ViewTask_RemoveTaskFromTaskList:(NSNotification *)notification {
    
    NSDictionary *userInfo = notification.userInfo;
    
    NSString *taskListID = userInfo[@"TaskListID"];
    NSString *itemUniqueID = userInfo[@"ItemUniqueID"];
    
    
    NSUInteger index = [self->_taskListDict[@"TaskListID"] containsObject:taskListID] ? [self->_taskListDict[@"TaskListID"] indexOfObject:taskListID] : 1000;
    
    if (index != 1000) {
        
        NSMutableDictionary *taskListDictCopy = [self->_taskListDict mutableCopy];
        NSMutableArray *taskListItemsArray = [taskListDictCopy[@"TaskListItems"] mutableCopy];
        NSMutableDictionary *taskListItems = [taskListItemsArray[index] mutableCopy];
        
        if ([[taskListItems allKeys] containsObject:itemUniqueID] == YES) {
            [taskListItems removeObjectForKey:itemUniqueID];
        }
        
        [taskListItemsArray replaceObjectAtIndex:index withObject:taskListItems];
        [taskListDictCopy setObject:taskListItemsArray forKey:@"TaskListItems"];
        self->_taskListDict = [taskListDictCopy mutableCopy];
        
        
        
        NSString *taskListName = @"No List";
        [self UpdateTopViewLabel:taskListName];
        
    }
    
}

-(void)NSNotification_ViewTask_RemoveTaskFromAllTaskLists:(NSNotification *)notification {
    
    NSDictionary *userInfo = notification.userInfo;
    
    NSString *itemUniqueID = userInfo[@"ItemUniqueID"];
    
    
    for (NSString *taskListID in _taskListDict[@"TaskListID"]) {
        
        NSUInteger index = [_taskListDict[@"TaskListID"] indexOfObject:taskListID];
        
        NSMutableDictionary *taskListDictCopy = [self->_taskListDict mutableCopy];
        NSMutableArray *taskListItemsArray = [taskListDictCopy[@"TaskListItems"] mutableCopy];
        NSMutableDictionary *taskListItems = [taskListItemsArray[index] mutableCopy];
        
        if ([[taskListItems allKeys] containsObject:itemUniqueID] == YES) {
            [taskListItems removeObjectForKey:itemUniqueID];
        }
        
        [taskListItemsArray replaceObjectAtIndex:index withObject:taskListItems];
        [taskListDictCopy setObject:taskListItemsArray forKey:@"TaskListItems"];
        self->_taskListDict = [taskListDictCopy mutableCopy];
        
    }
    
    
    
    NSString *taskListName = @"No List";
    [self UpdateTopViewLabel:taskListName];
    
}

-(void)NSNotification_ViewTask_MoveTaskToDifferentTaskList:(NSNotification *)notification {
   
    NSDictionary *userInfo = notification.userInfo;
    
    NSString *oldTaskListID = userInfo[@"OldTaskListID"];
    NSString *newTaskListID = userInfo[@"NewTaskListID"];
    NSString *itemUniqueID = userInfo[@"ItemUniqueID"];
    
    
    
    NSUInteger index = [self->_taskListDict[@"TaskListID"] containsObject:oldTaskListID] ? [self->_taskListDict[@"TaskListID"] indexOfObject:oldTaskListID] : 1000;
    
    if (index != 1000) {
        
        NSMutableDictionary *taskListDictCopy = [self->_taskListDict mutableCopy];
        NSMutableArray *taskListItemsArray = [taskListDictCopy[@"TaskListItems"] mutableCopy];
        NSMutableDictionary *taskListItems = [taskListItemsArray[index] mutableCopy];
        
        if ([[taskListItems allKeys] containsObject:itemUniqueID] == YES) {
            [taskListItems removeObjectForKey:itemUniqueID];
        }
        
        [taskListItemsArray replaceObjectAtIndex:index withObject:taskListItems];
        [taskListDictCopy setObject:taskListItemsArray forKey:@"TaskListItems"];
        self->_taskListDict = [taskListDictCopy mutableCopy];
        
    }
    
    
    
    index = [self->_taskListDict[@"TaskListID"] containsObject:newTaskListID] ? [self->_taskListDict[@"TaskListID"] indexOfObject:newTaskListID] : 1000;
    
    if (index != 1000) {
        
        NSMutableDictionary *taskListDictCopy = [self->_taskListDict mutableCopy];
        NSMutableArray *taskListItemsArray = [taskListDictCopy[@"TaskListItems"] mutableCopy];
        NSMutableDictionary *taskListItems = [taskListItemsArray[index] mutableCopy];
        
        if ([[taskListItems allKeys] containsObject:itemUniqueID] == NO) {
            [taskListItems setObject:@{@"ItemUniqueID" : itemUniqueID} forKey:itemUniqueID];
        }
        
        [taskListItemsArray replaceObjectAtIndex:index withObject:taskListItems];
        [taskListDictCopy setObject:taskListItemsArray forKey:@"TaskListItems"];
        self->_taskListDict = [taskListDictCopy mutableCopy];
        
        
        
        NSString *taskListName = [taskListDictCopy[@"TaskListName"][index] mutableCopy];
        [self UpdateTopViewLabel:taskListName];
        
    }
    
}

#pragma mark

-(void)NSNotification_ViewTask_AddOrEditTaskList:(NSNotification *)notification {
    
    NSMutableDictionary *userInfo = [notification.userInfo mutableCopy];
    
    NSString *selectListInViewTaskViewController = @"No";
    
    if (userInfo[@"SelectListInViewTaskViewController"]) {
        selectListInViewTaskViewController = [userInfo[@"SelectListInViewTaskViewController"] mutableCopy];
        [userInfo removeObjectForKey:@"SelectListInViewTaskViewController"];
    }
    
    if (userInfo[@"runOnBackgroundThread"]) { [userInfo removeObjectForKey:@"runOnBackgroundThread"]; }
   
    NSString *taskListID = userInfo[@"TaskListID"] ? userInfo[@"TaskListID"] : @"";
    NSString *taskListName = userInfo[@"TaskListName"] ? userInfo[@"TaskListName"] : @"No List";
   
    BOOL Editing = [_taskListDict[@"TaskListID"] containsObject:taskListID];
    
    for (NSString *key in [userInfo allKeys]) {
        
        NSMutableArray *arr = _taskListDict[key] ? [_taskListDict[key] mutableCopy] : [NSMutableArray array];
        
        if (Editing) {
            
            NSUInteger index = [_taskListDict[@"TaskListID"] indexOfObject:taskListID];
            if (arr.count > index) { [arr replaceObjectAtIndex:index withObject:userInfo[key]]; }
            
        } else {
            
            id object = userInfo[key] ? [userInfo[key] mutableCopy] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
            [arr addObject:object];
            
        }
        
        [_taskListDict setObject:arr forKey:key];
        
    }
   
    if ([selectListInViewTaskViewController isEqualToString:@"Yes"]) {
       
        NSString *oldTaskListName = [self->topViewLabel.text mutableCopy];
        
        [self UpdateTopViewLabel:taskListName];
        
        [self UpdateTaskListItems:taskListName oldTaskListName:oldTaskListName completionHandler:^(BOOL finished, NSString *oldTaskListID, NSString *newTaskListID) {
            
            [self UpdateTaskListItems_CompletionBlock:taskListName oldTaskListID:oldTaskListID newTaskListID:newTaskListID itemUniqueID:self->itemUniqueID];
            
        }];
        
    } else {
        
        [self UpdateTopViewLabel:taskListName];
        
    }
    
}

-(void)NSNotification_ViewTask_AddOrEditItemTemplate:(NSNotification *)notification {
    
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
            
            id object = userInfo[key] ? [userInfo[key] mutableCopy] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
            [arr addObject:object];
            
        }
        
        [_templateDict setObject:arr forKey:key];
        
    }
    
}

-(void)NSNotification_ViewTask_AddOrEditItemDraft:(NSNotification *)notification {
    
    NSDictionary *userInfo = notification.userInfo;
    
    NSString *draftID = userInfo[@"DraftID"] ? userInfo[@"DraftID"] : @"";
    
    BOOL Editing = NO;
    
    if (_draftDict[@"DraftID"] && [_draftDict[@"DraftID"] containsObject:draftID]) {
        Editing = YES;
    }
    
    for (NSString *key in [userInfo allKeys]) {
        
        NSMutableArray *arr = _draftDict[key] ? [_draftDict[key] mutableCopy] : [NSMutableArray array];
        
        if (Editing) {
            
            NSUInteger index = [_draftDict[@"DraftID"] indexOfObject:draftID];
            if (arr.count > index) { [arr replaceObjectAtIndex:index withObject:userInfo[key]]; }
            
        } else {
            
            id object = userInfo[key] ? [userInfo[key] mutableCopy] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
            [arr addObject:object];
            
        }
        
        [_draftDict setObject:arr forKey:key];
        
    }
    
}

#pragma mark

-(void)NSNotification_ViewTask_AddHomeMember:(NSNotification *)notification {
    
    NSDictionary *dict = [notification.userInfo mutableCopy];
    
    _homeMembersArray = dict[@"HomeMembersArray"] ? dict[@"HomeMembersArray"] : [NSMutableArray array];
    _homeMembersDict = dict[@"HomeMembersDict"] ? dict[@"HomeMembersDict"] : [NSMutableDictionary dictionary];
    _notificationSettingsDict = dict[@"NotificationSettingsDict"] ? dict[@"NotificationSettingsDict"] : [NSMutableDictionary dictionary];
    
    [[NSUserDefaults standardUserDefaults] setObject:self->_homeMembersArray forKey:@"HomeMembersArray"];
    [[NSUserDefaults standardUserDefaults] setObject:self->_homeMembersDict forKey:@"HomeMembersDict"];
    [[NSUserDefaults standardUserDefaults] setObject:dict[@"HomeKeysDict"] ? dict[@"HomeKeysDict"] : [NSMutableDictionary dictionary] forKey:@"HomeKeysDict"];
    [[NSUserDefaults standardUserDefaults] setObject:dict[@"HomeKeysArray"] ? dict[@"HomeKeysArray"] : [NSMutableArray array] forKey:@"HomeKeysArray"];
    [[NSUserDefaults standardUserDefaults] setObject:self->_notificationSettingsDict forKey:@"NotificationSettingsDict"];
    
    completedQueries = totalQueries - 1;
    [self SetQueriedData];
    
}

-(void)NSNotification_ViewTask_CompletedReset:(NSNotification *)notification {
    
    NSMutableDictionary *dataDict = [notification.userInfo mutableCopy];
    
    if (dataDict[@"ItemDueDate"] != NULL && [dataDict[@"ItemDueDate"] isEqualToString:itemDueDate] == NO) {
        
        [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"ResetViewTask"];
        
    }
    
}

#pragma mark

-(void)NSNotification_ViewTask_ItemWeDivvyPremiumAccounts:(NSNotification *)notification {
    
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

-(void)NSNotification_ViewTask_ItemMutedNotifications:(NSNotification *)notification {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self ViewItemViewInnerViews];
        
        [self AdjustTableViewFrames];
        
    });
    
}

#pragma mark - IBAction Methods

-(void)UpdateTaskListItems_AllTaskLists:(NSString *)newTaskListName oldTaskListName:(NSString *)oldTaskListName itemUniqueIDDict:(NSDictionary *)itemUniqueIDDict completionHandler:(void (^)(BOOL finished, NSString *oldTaskListID, NSString *newTaskListID))finishBlock {
    
    if ([[[GeneralObject alloc] init] ConnectedToInternet] == NO) {
        [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You need to be connected to the internet to do that." currentViewController:self];
        return;
    }
    
    if ([newTaskListName isEqualToString:oldTaskListName]) {
        finishBlock(YES, @"", @"");
    } else {
        
        
        
        NSString *oldTaskListID = @"";
        NSString *newTaskListID = @"";
        
        
        
        NSUInteger index = [self->_taskListDict[@"TaskListName"] containsObject:oldTaskListName] ? [self->_taskListDict[@"TaskListName"] indexOfObject:oldTaskListName] : 1000;
        
        if (index != 1000) {
            oldTaskListID = [self->_taskListDict[@"TaskListID"][index] mutableCopy];
        }
        
        
        
        index = [self->_taskListDict[@"TaskListName"] containsObject:newTaskListName] ? [self->_taskListDict[@"TaskListName"] indexOfObject:newTaskListName] : 1000;
        
        if (index != 1000) {
            newTaskListID = [self->_taskListDict[@"TaskListID"][index] mutableCopy];
        }
        
        
        
        [[[GeneralObject alloc] init] AddOrRemoveTaskToAllTaskListsThatContainSpecificItem:_taskListDict newTaskListName:newTaskListName itemUniqueIDDict:itemUniqueIDDict AddTask:YES completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningUpdatedTaskListDict) {
            
            NSArray *arrayOfDicts = @[returningUpdatedTaskListDict];
            
            self->_taskListDict = [[[GeneralObject alloc] init] GenerateUpdatedTaskListDict:arrayOfDicts taskListDict:self->_taskListDict];
           
            finishBlock(YES, oldTaskListID, newTaskListID);
            
        }];
        
    }
    
}

-(void)UpdateTaskListItems:(NSString *)newTaskListName oldTaskListName:(NSString *)oldTaskListName completionHandler:(void (^)(BOOL finished, NSString *oldTaskListID, NSString *newTaskListID))finishBlock {
    
    if ([[[GeneralObject alloc] init] ConnectedToInternet] == NO) {
        [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You need to be connected to the internet to do that." currentViewController:self];
        return;
    }
    
    if ([newTaskListName isEqualToString:oldTaskListName]) {
        finishBlock(YES, @"", @"");
    } else {
        
        
        
        NSString *oldTaskListID = @"";
        NSString *newTaskListID = @"";
        
        
        
        NSUInteger index = [self->_taskListDict[@"TaskListName"] containsObject:oldTaskListName] ? [self->_taskListDict[@"TaskListName"] indexOfObject:oldTaskListName] : 1000;
        
        if (index != 1000) {
            oldTaskListID = [self->_taskListDict[@"TaskListID"][index] mutableCopy];
        }
        
        
        
        index = [self->_taskListDict[@"TaskListName"] containsObject:newTaskListName] ? [self->_taskListDict[@"TaskListName"] indexOfObject:newTaskListName] : 1000;
        
        if (index != 1000) {
            newTaskListID = [self->_taskListDict[@"TaskListID"][index] mutableCopy];
        }
        
        
        
        [[[GeneralObject alloc] init] AddTaskToSpecificTaskListAndRemoveFromDifferentSpecificTaskList:_taskListDict newTaskListName:newTaskListName oldTaskListName:oldTaskListName itemUniqueIDArray:@[itemUniqueID] completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningUpdatedTaskListDict, NSMutableDictionary * _Nonnull returningUpdatedTaskListDictNo1) {
            
            NSArray *arrayOfDicts = @[returningUpdatedTaskListDict, returningUpdatedTaskListDictNo1];
            
            self->_taskListDict = [[[GeneralObject alloc] init] GenerateUpdatedTaskListDict:arrayOfDicts taskListDict:self->_taskListDict];
            
            finishBlock(YES, oldTaskListID, newTaskListID);
            
        }];
        
    }
    
}

-(void)RemoveTaskListItems:(void (^)(BOOL finished))finishBlock {
    
    if ([[[GeneralObject alloc] init] ConnectedToInternet] == NO) {
        [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You need to be connected to the internet to do that." currentViewController:self];
        return;
    }
   
    [[[GeneralObject alloc] init] AddOrRemoveTaskToAllTaskListsThatContainSpecificItem:_taskListDict newTaskListName:@"" itemUniqueIDDict:@{itemUniqueID : @{@"SpecificItemUniqueID" : @""}} AddTask:NO completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningUpdatedTaskListDict) {
        
        self->_taskListDict = [[[GeneralObject alloc] init] GenerateUpdatedTaskListDict:@[returningUpdatedTaskListDict] taskListDict:self->_taskListDict];
        
        finishBlock(YES);
        
    }];
    
}

#pragma mark - Ellipsis Options

#pragma mark Tasks

-(IBAction)EditTask:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Edit Clicked %@ For %@", _itemID, itemType] completionHandler:^(BOOL finished) {
        
    }];
    
    self->duplicateItemDetails = NO;
    
    sender = @"Edit";
    
    [self TapGestureActionPushToAddTaskViewController:sender];
    
}

-(IBAction)DeleteTask:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Delete Selected %@ For %@", _itemID, itemType] completionHandler:^(BOOL finished) {
        
    }];
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Are you sure you would like to permanently delete all this %@?", [itemType lowercaseString]] message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"Permanently Delete" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Deleting %@ For %@", self->_itemID, self->itemType] completionHandler:^(BOOL finished) {
            
        }];
        
        [self TapGestureDeleteTrashPermanently:nil];
        
    }];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Delete Cancelled %@ For %@", self->_itemID, self->itemType] completionHandler:^(BOOL finished) {
            
        }];
        
    }]];
    
    [deleteAction setValue:[UIColor systemRedColor] forKey:@"titleTextColor"];
    
    [actionSheet addAction:deleteAction];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
    
}

#pragma mark Subtasks

-(IBAction)WontDoSubtask:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Wont Do Subtask Selected %@ For %@", _itemID, itemType] completionHandler:^(BOOL finished) {
        
    }];
    
//    [self StartProgressView];
    
    NSMutableDictionary *dictToUse = [self->itemDict mutableCopy];
    NSMutableDictionary *dictToUseLocal = [dictToUse mutableCopy];
    NSIndexPath *indexPath = [[[CompleteUncompleteObject alloc] init] GenerateTempIndexPath];
    
    NSMutableDictionary *homeMembersDictLocal = _homeMembersDict ? [_homeMembersDict mutableCopy] : [NSMutableDictionary dictionary];
    NSString *subtaskThatIsBeingMarked = itemSubTasksDict && [[itemSubTasksDict allKeys] count] ? [itemSubTasksDict allKeys][indexPath.row] : @"";
    
    NSString *notificationType = [[[NotificationsObject alloc] init] NotificationSettingsUnknownItemType_Adding:NO Editing:NO Deleting:NO Duplicating:NO Waiving:NO Skipping:NO Pausing:NO Comments:NO
                                                                                                   SkippingTurn:NO RemovingUser:NO
                                                                                                 FullyCompleted:NO Completed:NO InProgress:NO WontDo:NO Accept:NO Decline:NO
                                                                                                        DueDate:NO Reminder:NO
                                                                                                 SubtaskEditing:NO SubtaskDeleting:NO
                                                                                               SubtaskCompleted:NO SubtaskInProgress:NO SubtaskWontDo:YES SubtaskAccept:NO SubtaskDecline:NO
                                                                                                 AddingListItem:NO EditingListItem:NO DeletingListItem:NO ResetingListItem:NO
                                                                                            EditingItemizedItem:NO DeletingItemizedItem:NO
                                                                                              GroupChatMessages:NO LiveSupportMessages:NO
                                                                                             SendingInvitations:NO DeletingInvitations:NO NewHomeMembers:NO HomeMembersMovedOut:NO HomeMembersKickedOut:NO
                                                                                            FeatureForumUpvotes:NO BugForumUpvotes:NO
                                                                                                       itemType:itemType];
    
    NSString *notificationItemType = itemType;
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Subtask Completed/Uncompleted Clicked %@ For %@", _itemID, itemType] completionHandler:^(BOOL finished) {
        
    }];
    
    BOOL markingForSomeoneElse = NO;
    
    
    //Remove Loading
    
    dictToUseLocal = [[[CompleteUncompleteObject alloc] init] GenerateUpdatedSubtaskWontDoWillDoDict:dictToUseLocal subtaskThatIsBeingMarked:subtaskThatIsBeingMarked markingForSomeoneElse:markingForSomeoneElse];
    
    
    
    self->itemxxxOccurrencesDict = [itemxxxOccurrencesDict mutableCopy];
    [self UpdateAllDataInViewController:indexPath dictToUse:dictToUseLocal];
    
    //
    
    
    
    [[[CompleteUncompleteObject alloc] init] SubtaskWillDoWontDo:dictToUse itemOccurrencesDict:itemxxxOccurrencesDict keyArray:self->keyArray homeMembersArray:self->_homeMembersArray homeMembersDict:homeMembersDictLocal notificationSettingsDict:self->_notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType topicDict:self->_topicDict allItemTagsArrays:_allItemTagsArrays subtaskThatIsBeingMarked:subtaskThatIsBeingMarked markingForSomeoneElse:markingForSomeoneElse currentViewController:self completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningDictToUse, NSMutableDictionary * _Nonnull returningOccurrencesDictToUse) {
        
        self->itemxxxOccurrencesDict = [returningOccurrencesDictToUse mutableCopy];
        [self UpdateAllDataInViewController:indexPath dictToUse:returningDictToUse];
        
    }];
    
}

-(IBAction)EditSubtask:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Edit Subtask Selected %@ For %@", _itemID, itemType] completionHandler:^(BOOL finished) {
        
    }];
    
    NSIndexPath *indexPath = (NSIndexPath *)sender;
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Update subtask name" message:nil
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Update"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Update Subtask Selected %@ For %@", self->_itemID, self->itemType] completionHandler:^(BOOL finished) {
            
        }];
        
//        [self StartProgressView];
        
        NSString *itemSubTask = [self->itemSubTasksDict allKeys][indexPath.row];
        NSMutableDictionary *oldSubTaskCompletedDict = [self->itemSubTasksDict[itemSubTask][@"Completed Dict"] mutableCopy];
        NSMutableDictionary *oldSubTaskInProgressDict = [self->itemSubTasksDict[itemSubTask][@"In Progress Dict"] mutableCopy];
        NSMutableDictionary *oldSubTaskWontDoDict = self->itemSubTasksDict[itemSubTask][@"Wont Do"] ? [self->itemSubTasksDict[itemSubTask][@"Wont Do"] mutableCopy] : [NSMutableDictionary dictionary];
        NSMutableArray *oldSubTaskAssignedToArray = [self->itemSubTasksDict[itemSubTask][@"Assigned To"] mutableCopy];
        NSString *oldItem = [self->itemSubTasksDict allKeys][indexPath.row];
        NSString *newItem = controller.textFields[0].text;
        
        [self->itemSubTasksDict removeObjectForKey:oldItem];
        [self->itemSubTasksDict setObject:@{@"Completed Dict" : oldSubTaskCompletedDict, @"In Progress Dict" : oldSubTaskInProgressDict, @"Wont Do" : oldSubTaskWontDoDict, @"Assigned To" : oldSubTaskAssignedToArray} forKey:newItem];
        
        
        
        //Remove Loading
        
        [self UpdateAllDataInViewController:nil dictToUse:[@{@"ItemSubTasks" : self->itemSubTasksDict} mutableCopy]];
        
        //
        
        
        
        __block int totalQueries = 2;
        __block int completedQueries = 0;
        
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSMutableDictionary *singleObjectItemDict = [[[GeneralObject alloc] init] GenerateSingleObjectDictionary:[self->itemDict mutableCopy] keyArray:[self->keyArray mutableCopy] indexPath:nil];
            
            
            
            NSString *notificationType = [[[NotificationsObject alloc] init] NotificationSettingsUnknownItemType_Adding:NO Editing:NO Deleting:NO Duplicating:NO Waiving:NO Skipping:NO Pausing:NO Comments:NO
                                                                                                           SkippingTurn:NO RemovingUser:NO
                                                                                                         FullyCompleted:NO Completed:NO InProgress:NO WontDo:NO Accept:NO Decline:NO
                                                                                                                DueDate:NO Reminder:NO
                                                                                                         SubtaskEditing:YES SubtaskDeleting:NO
                                                                                                       SubtaskCompleted:NO SubtaskInProgress:NO SubtaskWontDo:NO SubtaskAccept:NO SubtaskDecline:NO
                                                                                                         AddingListItem:NO EditingListItem:NO DeletingListItem:NO ResetingListItem:NO
                                                                                                    EditingItemizedItem:NO DeletingItemizedItem:NO
                                                                                                      GroupChatMessages:NO LiveSupportMessages:NO
                                                                                                     SendingInvitations:NO DeletingInvitations:NO NewHomeMembers:NO HomeMembersMovedOut:NO HomeMembersKickedOut:NO
                                                                                                    FeatureForumUpvotes:NO BugForumUpvotes:NO
                                                                                                               itemType:self->itemType];
            
            
            
            NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
            
            
            
            NSString *notificationTitle = [NSString stringWithFormat:@"\"%@\"", self->itemName];
            NSString *notificationBody = [NSString stringWithFormat:@"%@ updated the subtask \"%@\" to \"%@\" in this %@. ✏️", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"], oldItem, newItem,  [self->itemType lowercaseString]];
            
            
            
            NSMutableArray *usersToSendNotificationTo = [self->itemAssignedToArray mutableCopy];
            
            NSArray *addTheseUsers = @[self->itemCreatedBy];
            NSArray *removeTheseUsers = @[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx"];
            
            usersToSendNotificationTo = [[[[NotificationsObject alloc] init] AddAndRemoveSpecificUsersFromArray:usersToSendNotificationTo addTheseUsers:addTheseUsers removeTheseUsers:removeTheseUsers] mutableCopy];
            
            
            
            [[[NotificationsObject alloc] init] SendPushNotificationToArrayOfUsers_Items:usersToSendNotificationTo
                                                                               dictToUse:singleObjectItemDict
                                                                                  homeID:homeID homeMembersArray:self->_homeMembersArray homeMembersDict:self->_homeMembersDict
                                                                notificationSettingsDict:self->_notificationSettingsDict notificationItemType:self->itemType notificationType:notificationType
                                                                               topicDict:self->_topicDict
                                                                     allItemTagsArrays:self->_allItemTagsArrays
                                                                   pushNotificationTitle:notificationTitle pushNotificationBody:notificationBody
                                                                       notificationTitle:notificationTitle notificationBody:notificationBody
                                                                 SetDataHomeNotification:YES
                                                                    RemoveUsersNotInHome:YES
                                                                       completionHandler:^(BOOL finished) {
                
                if (totalQueries == (completedQueries+=1)) {
                    
                    [self UpdateAllDataInViewController:nil dictToUse:[@{@"ItemSubTasks" : self->itemSubTasksDict} mutableCopy]];
                    
                }
                
            }];
            
        });
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [[[SetDataObject alloc] init] UpdateDataEditItem:@{@"ItemSubTasks" : self->itemSubTasksDict} itemID:self->_itemID itemOccurrenceID:self->_itemOccurrenceID collection:self->itemTypeCollection homeID:self->homeID completionHandler:^(BOOL finished) {
                
                if (totalQueries == (completedQueries+=1)) {
                    
                    [self UpdateAllDataInViewController:nil dictToUse:[@{@"ItemSubTasks" : self->itemSubTasksDict} mutableCopy]];
                    
                }
                
            }];
            
        });
        
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction * _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Edit Subtask Cancelled %@ For %@", self->_itemID, self->itemType] completionHandler:^(BOOL finished) {
            
        }];
        
    }];
    
    
    
    [controller addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        
        textField.delegate = self;
        textField.text = [self->itemSubTasksDict allKeys][indexPath.row];
        textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
        
    }];
    
    [controller addAction:action1];
    [controller addAction:cancel];
    [self presentViewController:controller animated:YES completion:nil];
    
}

-(IBAction)DeleteSubtask:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Delete Subtask Selected %@ For %@", _itemID, itemType] completionHandler:^(BOOL finished) {
        
    }];
    
//    [self StartProgressView];
    
    NSIndexPath *indexPath = (NSIndexPath *)sender;
    
    NSString *oldItem = itemSubTasksDict && [[itemSubTasksDict allKeys] count] ? [itemSubTasksDict allKeys][indexPath.row] : @"";
    
    [itemSubTasksDict removeObjectForKey:oldItem];
    
    
    
    //Remove Loading
    
    [self UpdateAllDataInViewController:nil dictToUse:[@{@"ItemSubTasks" : self->itemSubTasksDict} mutableCopy]];
    
    //
    
    
    
    
    __block int totalQueries = 2;
    __block int completedQueries = 0;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSMutableDictionary *singleObjectItemDict = [[[GeneralObject alloc] init] GenerateSingleObjectDictionary:[self->itemDict mutableCopy] keyArray:[self->keyArray mutableCopy] indexPath:nil];
        
        
        
        NSString *notificationType = [[[NotificationsObject alloc] init] NotificationSettingsUnknownItemType_Adding:NO Editing:NO Deleting:NO Duplicating:NO Waiving:NO Skipping:NO Pausing:NO Comments:NO
                                                                                                       SkippingTurn:NO RemovingUser:NO
                                                                                                     FullyCompleted:NO Completed:NO InProgress:NO WontDo:NO Accept:NO Decline:NO
                                                                                                            DueDate:NO Reminder:NO
                                                                                                     SubtaskEditing:NO SubtaskDeleting:YES
                                                                                                   SubtaskCompleted:NO SubtaskInProgress:NO SubtaskWontDo:NO SubtaskAccept:NO SubtaskDecline:NO
                                                                                                     AddingListItem:NO EditingListItem:NO DeletingListItem:NO ResetingListItem:NO
                                                                                                EditingItemizedItem:NO DeletingItemizedItem:NO
                                                                                                  GroupChatMessages:NO LiveSupportMessages:NO
                                                                                                 SendingInvitations:NO DeletingInvitations:NO NewHomeMembers:NO HomeMembersMovedOut:NO HomeMembersKickedOut:NO
                                                                                                FeatureForumUpvotes:NO BugForumUpvotes:NO
                                                                                                           itemType:self->itemType];
        
        
        
        NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
        
        
        
        NSString *notificationTitle = [NSString stringWithFormat:@"\"%@\"", self->itemName];
        NSString *notificationBody = [NSString stringWithFormat:@"%@ removed the subtask \"%@\" from this %@. ❌", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"], oldItem, [self->itemType lowercaseString]];
        
        
        
        NSMutableArray *usersToSendNotificationTo = [self->itemAssignedToArray mutableCopy];
        
        NSArray *addTheseUsers = @[self->itemCreatedBy];
        NSArray *removeTheseUsers = @[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx"];
        
        usersToSendNotificationTo = [[[[NotificationsObject alloc] init] AddAndRemoveSpecificUsersFromArray:usersToSendNotificationTo addTheseUsers:addTheseUsers removeTheseUsers:removeTheseUsers] mutableCopy];
        
        
        
        [[[NotificationsObject alloc] init] SendPushNotificationToArrayOfUsers_Items:usersToSendNotificationTo
                                                                           dictToUse:singleObjectItemDict
                                                                              homeID:homeID homeMembersArray:self->_homeMembersArray homeMembersDict:self->_homeMembersDict
                                                            notificationSettingsDict:self->_notificationSettingsDict notificationItemType:self->itemType notificationType:notificationType
                                                                           topicDict:self->_topicDict
                                                                 allItemTagsArrays:self->_allItemTagsArrays
                                                               pushNotificationTitle:notificationTitle pushNotificationBody:notificationBody
                                                                   notificationTitle:notificationTitle notificationBody:notificationBody
                                                             SetDataHomeNotification:YES
                                                                RemoveUsersNotInHome:YES
                                                                   completionHandler:^(BOOL finished) {
            
            if (totalQueries == (completedQueries+=1)) {
                
                [self UpdateAllDataInViewController:nil dictToUse:[@{@"ItemSubTasks" : self->itemSubTasksDict} mutableCopy]];
                
            }
            
        }];
        
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[SetDataObject alloc] init] UpdateDataEditItem:@{@"ItemSubTasks" : self->itemSubTasksDict} itemID:self->_itemID itemOccurrenceID:self->_itemOccurrenceID collection:self->itemTypeCollection homeID:self->homeID completionHandler:^(BOOL finished) {
            
            if (totalQueries == (completedQueries+=1)) {
                
                [self UpdateAllDataInViewController:nil dictToUse:[@{@"ItemSubTasks" : self->itemSubTasksDict} mutableCopy]];
                
            }
            
        }];
        
    });
    
}

#pragma mark Lists

-(IBAction)AddListItemItemTypeList:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Add List Item Selected %@ For %@", _itemID, itemType] completionHandler:^(BOOL finished) {
        
    }];
    
    NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
    NSString *trimmedStringItemName = [_writeTaskTextField.text stringByTrimmingCharactersInSet:charSet];
    
    if (trimmedStringItemName.length > 0) {
        
        BOOL ListItemAlreadyExists = NO;
        BOOL ListItemIsCompleted = NO;
        BOOL ListItemIsInProgress = NO;
        
        NSString *existingItemName = @"";
        
        for (NSString *itemName in [itemListItems allKeys]) {
            
            if ([[itemName lowercaseString] isEqualToString:[_writeTaskTextField.text lowercaseString]]) {
                
                ListItemAlreadyExists = YES;
                ListItemIsCompleted = [[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemCompletedDict userIDToFind:itemName];
                ListItemIsInProgress = [[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemInProgressDict userIDToFind:itemName];
                existingItemName = itemName;
                
            }
            
        }
        
        if (ListItemAlreadyExists) {
            
            [self ListItemExistsMessage:ListItemIsCompleted ListItemIsInProgress:ListItemIsInProgress existingItemName:existingItemName];
            
        } else {
            
            [self AddListItem];
            
        }
        
    } else {
        
        [[[GeneralObject alloc] init] CreateAlert:@"Oops!" message:@"You must enter an item name." currentViewController:self];
        
    }
    
}

-(IBAction)WontDoListItemItemTypeList:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Wont Do List Item Selected %@ For %@", _itemID, itemType] completionHandler:^(BOOL finished) {
        
    }];
    
//    [self StartProgressView];
    
    NSMutableDictionary *dictToUse = [self->itemDict mutableCopy];
    NSMutableDictionary *dictToUseLocal = [dictToUse mutableCopy];
    NSIndexPath *indexPath = [[[CompleteUncompleteObject alloc] init] GenerateTempIndexPath];
    
    NSMutableDictionary *homeMembersDictLocal = _homeMembersDict ? [_homeMembersDict mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableArray *allItemAssignedToArrays = _allItemAssignedToArrays ? [self->_allItemAssignedToArrays mutableCopy] : [NSMutableArray array];
    
    NSString *listItemThatIsBeingMarked = [self GenerateDataForSpeificItemAtIndex:indexPath];
    
    
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"List Item Completed/Uncompleted Clicked %@ For %@", _itemID, itemType] completionHandler:^(BOOL finished) {
        
    }];
    
    
    
    NSString *notificationType = [[[NotificationsObject alloc] init] NotificationSettingsUnknownItemType_Adding:NO Editing:NO Deleting:NO Duplicating:NO Waiving:NO Skipping:NO Pausing:NO Comments:NO
                                                                                                   SkippingTurn:NO RemovingUser:NO
                                                                                                 FullyCompleted:NO Completed:NO InProgress:NO WontDo:YES Accept:NO Decline:NO
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
    
    dictToUseLocal = [[[CompleteUncompleteObject alloc] init] GenerateUpdatedListItemWontDoWillDoDict:dictToUseLocal listItemThatIsBeingMarked:listItemThatIsBeingMarked markingForSomeoneElse:markingForSomeoneElse];
    
    self->itemxxxOccurrencesDict = [itemxxxOccurrencesDict mutableCopy];
    self->_taskListDict = [[[GeneralObject alloc] init] GenerateUpdatedTaskListDict:@[[NSMutableDictionary dictionary]] taskListDict:self->_taskListDict];
    [self UpdateAllDataInViewController:indexPath dictToUse:dictToUseLocal];
    
    //
    
    
    
    [[[CompleteUncompleteObject alloc] init] ListItemWillDoWontDo:dictToUse itemOccurrencesDict:self->itemxxxOccurrencesDict keyArray:self->keyArray homeMembersArray:self->_homeMembersArray homeMembersDict:homeMembersDictLocal notificationSettingsDict:self->_notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType topicDict:self->_topicDict taskListDict:_taskListDict allItemAssignedToArrays:allItemAssignedToArrays allItemTagsArrays:_allItemTagsArrays listItemThatIsBeingMarked:listItemThatIsBeingMarked markingForSomeoneElse:markingForSomeoneElse currentViewController:self completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningDictToUse, NSMutableDictionary * _Nonnull returningOccurrencesDictToUse, NSMutableDictionary * _Nonnull returningUpdatedTaskListDictToUse) {
        
        self->itemxxxOccurrencesDict = [returningOccurrencesDictToUse mutableCopy];
        self->_taskListDict = [[[GeneralObject alloc] init] GenerateUpdatedTaskListDict:@[returningUpdatedTaskListDictToUse] taskListDict:self->_taskListDict];
        [self UpdateAllDataInViewController:indexPath dictToUse:returningDictToUse];
        
        BOOL TaskIsFullyCompleted = [[[BoolDataObject alloc] init] TaskIsFullyCompleted:dictToUseLocal itemType:self->itemType homeMembersDict:self->_homeMembersDict];
        
        [self CompleteUncompleteTaskAction_DisplayRepeatIfCompletedEarlyResetDropDown:dictToUseLocal TaskIsFullyCompleted:TaskIsFullyCompleted];
        
    }];
    
}

-(IBAction)EditListItemItemTypeList:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Edit List Item Selected %@ For %@", _itemID, itemType] completionHandler:^(BOOL finished) {
        
    }];
    
    NSIndexPath *indexPath = (NSIndexPath *)sender;
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Update item name" message:nil
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Update"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Update List Item Selected %@ For %@", self->_itemID, self->itemType] completionHandler:^(BOOL finished) {
            
        }];
        
//        [self StartProgressView];
        
        NSString *oldItem = [self GenerateDataForSpeificItemAtIndex:indexPath];
        
        NSString *oldItemObject = self->itemListItems[oldItem]/*self->itemListSectionsArray[indexPath.section][oldItem]*/;
        NSString *newItem = controller.textFields[0].text;
        
        [self->itemListItems removeObjectForKey:oldItem];
        [self->itemListItems setObject:oldItemObject forKey:newItem];
        
        
        
        //Remove Loading
        
        NSMutableDictionary *dictToUse = [@{@"ItemCompletedDict" : self->itemCompletedDict, @"ItemInProgressDict" : self->itemInProgressDict, @"ItemWontDo" : self->itemWontDoDict, @"ItemListItems" : self->itemListItems} mutableCopy];
        
        [self UpdateAllDataInViewController:nil dictToUse:dictToUse];
        
        //
        
        
        
        __block int totalQueries = 2;
        __block int completedQueries = 0;
        
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSMutableDictionary *singleObjectItemDict = [[[GeneralObject alloc] init] GenerateSingleObjectDictionary:[self->itemDict mutableCopy] keyArray:[self->keyArray mutableCopy] indexPath:nil];
            
            
            
            NSString *notificationType = [[[NotificationsObject alloc] init] NotificationSettingsUnknownItemType_Adding:NO Editing:NO Deleting:NO Duplicating:NO Waiving:NO Skipping:NO Pausing:NO Comments:NO
                                                                                                           SkippingTurn:NO RemovingUser:NO
                                                                                                         FullyCompleted:NO Completed:NO InProgress:NO WontDo:NO Accept:NO Decline:NO
                                                                                                                DueDate:NO Reminder:NO
                                                                                                         SubtaskEditing:NO SubtaskDeleting:NO
                                                                                                       SubtaskCompleted:NO SubtaskInProgress:NO SubtaskWontDo:NO SubtaskAccept:NO SubtaskDecline:NO
                                                                                                         AddingListItem:NO EditingListItem:YES DeletingListItem:NO ResetingListItem:NO
                                                                                                    EditingItemizedItem:NO DeletingItemizedItem:NO
                                                                                                      GroupChatMessages:NO LiveSupportMessages:NO
                                                                                                     SendingInvitations:NO DeletingInvitations:NO NewHomeMembers:NO HomeMembersMovedOut:NO HomeMembersKickedOut:NO
                                                                                                    FeatureForumUpvotes:NO BugForumUpvotes:NO
                                                                                                               itemType:self->itemType];
            
            
            
            NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
            
            
            
            NSString *notificationTitle = [NSString stringWithFormat:@"\"%@\"", self->itemName];
            NSString *notificationBody = [NSString stringWithFormat:@"%@ updated \"%@\" to \"%@\" in this list. ✏️", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"], oldItem, newItem];
            
            
            
            NSMutableArray *usersToSendNotificationTo = [self->itemAssignedToArray mutableCopy];
            
            NSArray *addTheseUsers = @[self->itemCreatedBy];
            NSArray *removeTheseUsers = @[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx"];
            
            usersToSendNotificationTo = [[[[NotificationsObject alloc] init] AddAndRemoveSpecificUsersFromArray:usersToSendNotificationTo addTheseUsers:addTheseUsers removeTheseUsers:removeTheseUsers] mutableCopy];
            
            
            
            [[[NotificationsObject alloc] init] SendPushNotificationToArrayOfUsers_Items:usersToSendNotificationTo
                                                                               dictToUse:singleObjectItemDict
                                                                                  homeID:homeID homeMembersArray:self->_homeMembersArray homeMembersDict:self->_homeMembersDict
                                                                notificationSettingsDict:self->_notificationSettingsDict notificationItemType:self->itemType notificationType:notificationType
                                                                               topicDict:self->_topicDict
                                                                     allItemTagsArrays:self->_allItemTagsArrays
                                                                   pushNotificationTitle:notificationTitle pushNotificationBody:notificationBody
                                                                       notificationTitle:notificationTitle notificationBody:notificationBody
                                                                 SetDataHomeNotification:YES
                                                                    RemoveUsersNotInHome:YES
                                                                       completionHandler:^(BOOL finished) {
                
                if (totalQueries == (completedQueries+=1)) {
                    
                    NSMutableDictionary *dictToUse = [@{@"ItemCompletedDict" : self->itemCompletedDict, @"ItemInProgressDict" : self->itemInProgressDict, @"ItemWontDo" : self->itemWontDoDict, @"ItemListItems" : self->itemListItems} mutableCopy];
                    
                    [self UpdateAllDataInViewController:nil dictToUse:dictToUse];
                    
                }
                
            }];
            
        });
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [[[SetDataObject alloc] init] UpdateDataEditItem:@{@"ItemListItems" : self->itemListItems} itemID:self->_itemID itemOccurrenceID:self->_itemOccurrenceID collection:self->itemTypeCollection homeID:self->homeID completionHandler:^(BOOL finished) {
                
                if (totalQueries == (completedQueries+=1)) {
                    
                    NSMutableDictionary *dictToUse = [@{@"ItemCompletedDict" : self->itemCompletedDict, @"ItemInProgressDict" : self->itemInProgressDict, @"ItemWontDo" : self->itemWontDoDict, @"ItemListItems" : self->itemListItems} mutableCopy];
                    
                    [self UpdateAllDataInViewController:nil dictToUse:dictToUse];
                    
                }
                
            }];
            
        });
        
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction * _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Edit List Item Cancelled %@ For %@", self->_itemID, self->itemType] completionHandler:^(BOOL finished) {
            
        }];
        
    }];
    
    
    
    [controller addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        
        NSString *listItem = [self GenerateDataForSpeificItemAtIndex:indexPath];
        
        textField.delegate = self;
        textField.text = listItem;
        textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
        
    }];
    
    [controller addAction:action1];
    [controller addAction:cancel];
    [self presentViewController:controller animated:YES completion:nil];
    
}

-(IBAction)DeleteListItemItemTypeList:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Delete List Item Selected %@ For %@", _itemID, itemType] completionHandler:^(BOOL finished) {
        
    }];
    
//    [self StartProgressView];
    
    NSIndexPath *indexPath = (NSIndexPath *)sender;
    
    
    
    NSString *listItem = [self GenerateDataForSpeificItemAtIndex:indexPath];
    NSString *oldItem = listItem;
    
    [itemListItems removeObjectForKey:listItem];
    
    
    
    listItem = [self GenerateDataForSpeificItemAtIndex:indexPath];
    
    if ([[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:self->itemCompletedDict userIDToFind:listItem]) {
        [self->itemCompletedDict removeObjectForKey:listItem];
    }
    
    listItem = [self GenerateDataForSpeificItemAtIndex:indexPath];
    
    if ([[self->itemInProgressDict allKeys] containsObject:listItem]) {
        [self->itemInProgressDict removeObjectForKey:listItem];
    }
    
    
    
    //Remove Loading
    
    NSMutableDictionary *dictToUse = [@{@"ItemCompletedDict" : self->itemCompletedDict, @"ItemInProgressDict" : self->itemInProgressDict, @"ItemWontDo" : self->itemWontDoDict, @"ItemListItems" : self->itemListItems} mutableCopy];
    
    [self UpdateAllDataInViewController:nil dictToUse:dictToUse];
    
    //
    
    
    
    __block int totalQueries = 2;
    __block int completedQueries = 0;
    
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSMutableDictionary *singleObjectItemDict = [[[GeneralObject alloc] init] GenerateSingleObjectDictionary:[self->itemDict mutableCopy] keyArray:[self->keyArray mutableCopy] indexPath:nil];
        
        
        
        NSString *notificationType = [[[NotificationsObject alloc] init] NotificationSettingsUnknownItemType_Adding:NO Editing:NO Deleting:NO Duplicating:NO Waiving:NO Skipping:NO Pausing:NO Comments:NO
                                                                                                       SkippingTurn:NO RemovingUser:NO
                                                                                                     FullyCompleted:NO Completed:NO InProgress:NO WontDo:NO Accept:NO Decline:NO
                                                                                                            DueDate:NO Reminder:NO
                                                                                                     SubtaskEditing:NO SubtaskDeleting:NO
                                                                                                   SubtaskCompleted:NO SubtaskInProgress:NO SubtaskWontDo:NO SubtaskAccept:NO SubtaskDecline:NO
                                                                                                     AddingListItem:NO EditingListItem:NO DeletingListItem:YES ResetingListItem:NO
                                                                                                EditingItemizedItem:NO DeletingItemizedItem:NO
                                                                                                  GroupChatMessages:NO LiveSupportMessages:NO
                                                                                                 SendingInvitations:NO DeletingInvitations:NO NewHomeMembers:NO HomeMembersMovedOut:NO HomeMembersKickedOut:NO
                                                                                                FeatureForumUpvotes:NO BugForumUpvotes:NO
                                                                                                           itemType:self->itemType];
        
        
        
        NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
        
        
        
        NSString *notificationTitle = [NSString stringWithFormat:@"\"%@\"", self->itemName];
        NSString *notificationBody = [NSString stringWithFormat:@"%@ removed \"%@\" from this list. ❌", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"], oldItem];
        
        
        
        NSMutableArray *usersToSendNotificationTo = [self->itemAssignedToArray mutableCopy];
        
        NSArray *addTheseUsers = @[self->itemCreatedBy];
        NSArray *removeTheseUsers = @[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx"];
        
        usersToSendNotificationTo = [[[[NotificationsObject alloc] init] AddAndRemoveSpecificUsersFromArray:usersToSendNotificationTo addTheseUsers:addTheseUsers removeTheseUsers:removeTheseUsers] mutableCopy];
        
        
        
        [[[NotificationsObject alloc] init] SendPushNotificationToArrayOfUsers_Items:usersToSendNotificationTo
                                                                           dictToUse:singleObjectItemDict
                                                                              homeID:homeID homeMembersArray:self->_homeMembersArray homeMembersDict:self->_homeMembersDict
                                                            notificationSettingsDict:self->_notificationSettingsDict notificationItemType:self->itemType notificationType:notificationType
                                                                           topicDict:self->_topicDict
                                                                 allItemTagsArrays:self->_allItemTagsArrays
                                                               pushNotificationTitle:notificationTitle pushNotificationBody:notificationBody
                                                                   notificationTitle:notificationTitle notificationBody:notificationBody
                                                             SetDataHomeNotification:YES
                                                                RemoveUsersNotInHome:YES
                                                                   completionHandler:^(BOOL finished) {
            
            if (totalQueries == (completedQueries+=1)) {
                
                NSMutableDictionary *dictToUse = [@{@"ItemCompletedDict" : self->itemCompletedDict, @"ItemInProgressDict" : self->itemInProgressDict, @"ItemWontDo" : self->itemWontDoDict, @"ItemListItems" : self->itemListItems} mutableCopy];
                
                [self UpdateAllDataInViewController:nil dictToUse:dictToUse];
                
            }
            
        }];
        
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[SetDataObject alloc] init] UpdateDataEditItem:@{@"ItemListItems" : self->itemListItems, @"ItemCompletedDict" : self->itemCompletedDict, @"ItemInProgressDict" : self->itemInProgressDict} itemID:self->_itemID itemOccurrenceID:self->_itemOccurrenceID collection:self->itemTypeCollection homeID:self->homeID completionHandler:^(BOOL finished) {
            
            if (totalQueries == (completedQueries+=1)) {
                
                NSMutableDictionary *dictToUse = [@{@"ItemCompletedDict" : self->itemCompletedDict, @"ItemInProgressDict" : self->itemInProgressDict, @"ItemWontDo" : self->itemWontDoDict, @"ItemListItems" : self->itemListItems} mutableCopy];
                
                [self UpdateAllDataInViewController:nil dictToUse:dictToUse];
                
            }
            
        }];
        
    });
    
}

-(IBAction)ResetListActionItemTypeList:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Reset List Selected %@ For %@", _itemID, itemType] completionHandler:^(BOOL finished) {
        
    }];
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Would you like to reset all items in \"%@\" to uncompleted?", itemName] message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *completeUncompleteAction = [UIAlertAction actionWithTitle:@"Reset List" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Resetting List %@ For %@", self->_itemID, self->itemType] completionHandler:^(BOOL finished) {
            
        }];
        
//        [self StartProgressView];
        
        __block int totalQueries = 2;
        __block int completedQueries = 0;
        
        NSMutableDictionary *itemDictLocal = [NSMutableDictionary dictionary];
        
        if ([self->itemListItems allKeys] > 0) {
            
            for (NSString *key in [self->itemListItems allKeys]) {
                
                if ([[itemDictLocal allKeys] containsObject:key] == NO) {
                    
                    NSString *previousAssignedTo = itemDictLocal[key][@"Assigned To"];
                    [itemDictLocal setObject:@{@"Assigned To" : previousAssignedTo, @"Status" : @"Uncompleted"} forKey:key];
                    
                }
                
            }
            
        }
        
        self->itemListItems = [itemDictLocal mutableCopy];
        
        
        
        //Remove Loading
        
        NSMutableDictionary *dictToUse = [@{@"ItemCompletedDict" : [NSMutableDictionary dictionary], @"ItemInProgressDict" : [NSMutableDictionary dictionary], @"ItemWontDo" : [NSMutableDictionary dictionary], @"ItemListItems" : self->itemListItems} mutableCopy];
        
        [self UpdateAllDataInViewController:nil dictToUse:dictToUse];
        
        //
        
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSMutableDictionary *singleObjectItemDict = [[[GeneralObject alloc] init] GenerateSingleObjectDictionary:[self->itemDict mutableCopy] keyArray:[self->keyArray mutableCopy] indexPath:nil];
            
            
            
            NSString *notificationType = [[[NotificationsObject alloc] init] NotificationSettingsUnknownItemType_Adding:NO Editing:NO Deleting:NO Duplicating:NO Waiving:NO Skipping:NO Pausing:NO Comments:NO
                                                                                                           SkippingTurn:NO RemovingUser:NO
                                                                                                         FullyCompleted:NO Completed:NO InProgress:NO WontDo:NO Accept:NO Decline:NO
                                                                                                                DueDate:NO Reminder:NO
                                                                                                         SubtaskEditing:NO SubtaskDeleting:NO
                                                                                                       SubtaskCompleted:NO SubtaskInProgress:NO SubtaskWontDo:NO SubtaskAccept:NO SubtaskDecline:NO
                                                                                                         AddingListItem:NO EditingListItem:NO DeletingListItem:NO ResetingListItem:YES
                                                                                                    EditingItemizedItem:NO DeletingItemizedItem:NO
                                                                                                      GroupChatMessages:NO LiveSupportMessages:NO
                                                                                                     SendingInvitations:NO DeletingInvitations:NO NewHomeMembers:NO HomeMembersMovedOut:NO HomeMembersKickedOut:NO
                                                                                                    FeatureForumUpvotes:NO BugForumUpvotes:NO
                                                                                                               itemType:self->itemType];
            
            
            
            NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
            
            
            
            NSString *notificationTitle = [NSString stringWithFormat:@"\"%@\"", self->itemName];
            NSString *notificationBody = [NSString stringWithFormat:@"%@ has reset this list", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"]];
            
            
            
            NSMutableArray *usersToSendNotificationTo = [self->itemAssignedToArray mutableCopy];
            
            NSArray *addTheseUsers = @[self->itemCreatedBy];
            NSArray *removeTheseUsers = @[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx"];
            
            usersToSendNotificationTo = [[[[NotificationsObject alloc] init] AddAndRemoveSpecificUsersFromArray:usersToSendNotificationTo addTheseUsers:addTheseUsers removeTheseUsers:removeTheseUsers] mutableCopy];
            
            
            
            [[[NotificationsObject alloc] init] SendPushNotificationToArrayOfUsers_Items:usersToSendNotificationTo
                                                                               dictToUse:singleObjectItemDict
                                                                                  homeID:homeID homeMembersArray:self->_homeMembersArray homeMembersDict:self->_homeMembersDict
                                                                notificationSettingsDict:self->_notificationSettingsDict notificationItemType:self->itemType notificationType:notificationType
                                                                               topicDict:self->_topicDict
                                                                     allItemTagsArrays:self->_allItemTagsArrays
                                                                   pushNotificationTitle:notificationTitle pushNotificationBody:notificationBody
                                                                       notificationTitle:notificationTitle notificationBody:notificationBody
                                                                 SetDataHomeNotification:YES
                                                                    RemoveUsersNotInHome:YES
                                                                       completionHandler:^(BOOL finished) {
                
                if (totalQueries == (completedQueries+=1)) {
                    
                    NSMutableDictionary *dictToUse = [@{@"ItemCompletedDict" : [NSMutableDictionary dictionary], @"ItemInProgressDict" : [NSMutableDictionary dictionary], @"ItemWontDo" : [NSMutableDictionary dictionary], @"ItemListItems" : self->itemListItems} mutableCopy];
                    
                    [self UpdateAllDataInViewController:nil dictToUse:dictToUse];
                    
                }
                
            }];
            
        });
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [[[SetDataObject alloc] init] UpdateDataEditItem:@{@"ItemListItems" : itemDictLocal} itemID:self->_itemID itemOccurrenceID:self->_itemOccurrenceID collection:self->itemTypeCollection homeID:self->homeID completionHandler:^(BOOL finished) {
                
                if (totalQueries == (completedQueries+=1)) {
                    
                    NSMutableDictionary *dictToUse = [@{@"ItemCompletedDict" : [NSMutableDictionary dictionary], @"ItemInProgressDict" : [NSMutableDictionary dictionary], @"ItemWontDo" : [NSMutableDictionary dictionary], @"ItemListItems" : self->itemListItems} mutableCopy];
                    
                    [self UpdateAllDataInViewController:nil dictToUse:dictToUse];
                    
                }
                
            }];
            
        });
        
    }];
    
    [completeUncompleteAction setValue:[UIColor redColor] forKey:@"titleTextColor"];
    
    [actionSheet addAction:completeUncompleteAction];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Reset List Cancelled %@ For %@", self->_itemID, self->itemType] completionHandler:^(BOOL finished) {
            
        }];
        
    }]];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
    
}

#pragma mark Itemized Items

-(IBAction)AddItemizedItemItemTypeExpense:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Add Itemized Item Selected %@ For %@", _itemID, itemType] completionHandler:^(BOOL finished) {
        
    }];
    
    NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
    NSString *trimmedStringItemName = [_writeTaskTextField.text stringByTrimmingCharactersInSet:charSet];
    
    if (trimmedStringItemName.length > 0) {
        
        BOOL ItemizedItemAlreadyExists = NO;
        BOOL ItemizedItemIsCompleted = NO;
        BOOL ItemizedItemIsInProgress = NO;
        
        NSString *existingItemName = @"";
        
        for (NSString *itemName in [itemItemizedItems allKeys]) {
            
            if ([[itemName lowercaseString] isEqualToString:[_writeTaskTextField.text lowercaseString]]) {
                
                ItemizedItemAlreadyExists = YES;
                ItemizedItemIsCompleted = [[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemCompletedDict userIDToFind:itemName];
                ItemizedItemIsInProgress = [[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemInProgressDict userIDToFind:itemName];
                existingItemName = itemName;
                
            }
            
        }
        
        if (ItemizedItemAlreadyExists) {
            
            [self ItemizedItemMessage:ItemizedItemIsCompleted ItemizedItemIsInProgress:ItemizedItemIsInProgress existingItemName:existingItemName];
            
        } else {
            
            [self AddItemizedItem];
            
        }
        
    } else {
        
        
        [[[GeneralObject alloc] init] CreateAlert:@"Oops!" message:@"You must enter an item name." currentViewController:self];
        
    }
    
}

-(IBAction)WontDoItemizedItemItemTypeExpense:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Wont Do Itemized Item Selected %@ For %@", _itemID, itemType] completionHandler:^(BOOL finished) {
        
    }];
    
//    [self StartProgressView];
    
    NSMutableDictionary *dictToUse = [self->itemDict mutableCopy];
    NSMutableDictionary *dictToUseLocal = [dictToUse mutableCopy];
    NSIndexPath *indexPath = [[[CompleteUncompleteObject alloc] init] GenerateTempIndexPath];
    
    NSMutableDictionary *homeMembersDictLocal = _homeMembersDict ? [_homeMembersDict mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableArray *allItemAssignedToArrays = _allItemAssignedToArrays ? [self->_allItemAssignedToArrays mutableCopy] : [NSMutableArray array];
    
    NSString *itemizedItemThatIsBeingMarked = [self GenerateDataForSpeificItemAtIndex:indexPath];
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Itemized Item Completed/Uncompleted Clicked %@ For %@", _itemID, itemType] completionHandler:^(BOOL finished) {
        
    }];
    
    NSString *notificationType = [[[NotificationsObject alloc] init] NotificationSettingsUnknownItemType_Adding:NO Editing:NO Deleting:NO Duplicating:NO Waiving:NO Skipping:NO Pausing:NO Comments:NO
                                                                                                   SkippingTurn:NO RemovingUser:NO
                                                                                                 FullyCompleted:NO Completed:NO InProgress:NO WontDo:YES Accept:NO Decline:NO
                                                                                                        DueDate:NO Reminder:NO
                                                                                                 SubtaskEditing:NO SubtaskDeleting:NO
                                                                                               SubtaskCompleted:NO SubtaskInProgress:NO SubtaskWontDo:NO SubtaskAccept:NO SubtaskDecline:NO
                                                                                                 AddingListItem:NO EditingListItem:NO DeletingListItem:NO ResetingListItem:NO
                                                                                            EditingItemizedItem:NO DeletingItemizedItem:NO
                                                                                              GroupChatMessages:NO LiveSupportMessages:NO
                                                                                             SendingInvitations:NO DeletingInvitations:NO NewHomeMembers:NO HomeMembersMovedOut:NO HomeMembersKickedOut:NO
                                                                                            FeatureForumUpvotes:NO BugForumUpvotes:NO
                                                                                                       itemType:self->itemType];
    
    NSString *notificationItemType = itemType;
    
    BOOL markingForSomeoneElse = NO;
    
    
    
    //Remove Loading
    
    dictToUseLocal = [[[CompleteUncompleteObject alloc] init] GenerateUpdatedItemizedItemWontDoWillDoDict:dictToUseLocal itemizedItemThatIsBeingMarked:itemizedItemThatIsBeingMarked markingForSomeoneElse:markingForSomeoneElse];
        
    self->itemxxxOccurrencesDict = [itemxxxOccurrencesDict mutableCopy];
    self->_taskListDict = [[[GeneralObject alloc] init] GenerateUpdatedTaskListDict:@[[NSMutableDictionary dictionary]] taskListDict:self->_taskListDict];
    [self UpdateAllDataInViewController:indexPath dictToUse:dictToUseLocal];
    
    //
    
    
    
    [[[CompleteUncompleteObject alloc] init] ItemizedItemWillDoWontDo:dictToUse itemOccurrencesDict:self->itemxxxOccurrencesDict keyArray:self->keyArray homeMembersArray:self->_homeMembersArray homeMembersDict:homeMembersDictLocal notificationSettingsDict:self->_notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType topicDict:self->_topicDict taskListDict:_taskListDict allItemAssignedToArrays:allItemAssignedToArrays allItemTagsArrays:_allItemTagsArrays itemizedItemThatIsBeingMarked:itemizedItemThatIsBeingMarked markingForSomeoneElse:NO currentViewController:self completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningDictToUse, NSMutableDictionary * _Nonnull returningOccurrencesDictToUse, NSMutableDictionary * _Nonnull returningUpdatedTaskListDictToUse) {
        
        self->itemxxxOccurrencesDict = [returningOccurrencesDictToUse mutableCopy];
        self->_taskListDict = [[[GeneralObject alloc] init] GenerateUpdatedTaskListDict:@[returningUpdatedTaskListDictToUse] taskListDict:self->_taskListDict];
        [self UpdateAllDataInViewController:indexPath dictToUse:returningDictToUse];
        
        BOOL TaskIsFullyCompleted = [[[BoolDataObject alloc] init] TaskIsFullyCompleted:dictToUseLocal itemType:self->itemType homeMembersDict:self->_homeMembersDict];
        
        [self CompleteUncompleteTaskAction_DisplayRepeatIfCompletedEarlyResetDropDown:dictToUseLocal TaskIsFullyCompleted:TaskIsFullyCompleted];
        
    }];
    
}

-(IBAction)EditItemizedItemItemTypeExpense:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Edit Itemized Item Selected %@ For %@", _itemID, itemType] completionHandler:^(BOOL finished) {
        
    }];
    
    NSIndexPath *indexPath = (NSIndexPath *)sender;
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Update item name" message:nil
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Update"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Update Itemized Item Selected %@ For %@", self->_itemID, self->itemType] completionHandler:^(BOOL finished) {
            
        }];
        
//        [self StartProgressView];
        
        NSString *oldItem = [self GenerateDataForSpeificItemAtIndex:indexPath];
        
        NSString *oldItemObject = self->itemItemizedItems[oldItem];//self->itemItemizedSectionsArray[indexPath.section][oldItem];
        NSString *newItem = controller.textFields[0].text;
        
        [self->itemItemizedItems removeObjectForKey:oldItem];
        [self->itemItemizedItems setObject:oldItemObject forKey:newItem];
        
        
        
        //Remove Loading
        
        NSMutableDictionary *dictToUse = [@{@"ItemCompletedDict" : self->itemCompletedDict, @"ItemInProgressDict" : self->itemInProgressDict, @"ItemWontDo" : self->itemWontDoDict, @"ItemItemizedItems" : self->itemItemizedItems} mutableCopy];
        
        [self UpdateAllDataInViewController:nil dictToUse:dictToUse];
        
        //
        
        
        
        __block int totalQueries = 2;
        __block int completedQueries = 0;
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSMutableDictionary *singleObjectItemDict = [[[GeneralObject alloc] init] GenerateSingleObjectDictionary:[self->itemDict mutableCopy] keyArray:[self->keyArray mutableCopy] indexPath:nil];
            
            
            
            NSString *notificationType = [[[NotificationsObject alloc] init] NotificationSettingsUnknownItemType_Adding:NO Editing:NO Deleting:NO Duplicating:NO Waiving:NO Skipping:NO Pausing:NO Comments:NO
                                                                                                           SkippingTurn:NO RemovingUser:NO
                                                                                                         FullyCompleted:NO Completed:NO InProgress:NO WontDo:NO Accept:NO Decline:NO
                                                                                                                DueDate:NO Reminder:NO
                                                                                                         SubtaskEditing:NO SubtaskDeleting:NO
                                                                                                       SubtaskCompleted:NO SubtaskInProgress:NO SubtaskWontDo:NO SubtaskAccept:NO SubtaskDecline:NO
                                                                                                         AddingListItem:NO EditingListItem:NO DeletingListItem:NO ResetingListItem:NO
                                                                                                    EditingItemizedItem:YES DeletingItemizedItem:NO
                                                                                                      GroupChatMessages:NO LiveSupportMessages:NO
                                                                                                     SendingInvitations:NO DeletingInvitations:NO NewHomeMembers:NO HomeMembersMovedOut:NO HomeMembersKickedOut:NO
                                                                                                    FeatureForumUpvotes:NO BugForumUpvotes:NO
                                                                                                               itemType:self->itemType];
            
            
            
            NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
            
            
            
            NSString *notificationTitle = [NSString stringWithFormat:@"\"%@\"", self->itemName];
            NSString *notificationBody = [NSString stringWithFormat:@"%@ updated \"%@\" to \"%@\" in this expense. ✏️", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"], oldItem, newItem];
            
            
            
            NSMutableArray *usersToSendNotificationTo = [self->itemAssignedToArray mutableCopy];
            
            NSArray *addTheseUsers = @[self->itemCreatedBy];
            NSArray *removeTheseUsers = @[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx"];
            
            usersToSendNotificationTo = [[[[NotificationsObject alloc] init] AddAndRemoveSpecificUsersFromArray:usersToSendNotificationTo addTheseUsers:addTheseUsers removeTheseUsers:removeTheseUsers] mutableCopy];
            
            
            
            [[[NotificationsObject alloc] init] SendPushNotificationToArrayOfUsers_Items:usersToSendNotificationTo
                                                                               dictToUse:singleObjectItemDict
                                                                                  homeID:homeID homeMembersArray:self->_homeMembersArray homeMembersDict:self->_homeMembersDict
                                                                notificationSettingsDict:self->_notificationSettingsDict notificationItemType:self->itemType notificationType:notificationType
                                                                               topicDict:self->_topicDict
                                                                     allItemTagsArrays:self->_allItemTagsArrays
                                                                   pushNotificationTitle:notificationTitle pushNotificationBody:notificationBody
                                                                       notificationTitle:notificationTitle notificationBody:notificationBody
                                                                 SetDataHomeNotification:YES
                                                                    RemoveUsersNotInHome:YES
                                                                       completionHandler:^(BOOL finished) {
                
                if (totalQueries == (completedQueries+=1)) {
                    
                    NSMutableDictionary *dictToUse = [@{@"ItemCompletedDict" : self->itemCompletedDict, @"ItemInProgressDict" : self->itemInProgressDict, @"ItemWontDo" : self->itemWontDoDict, @"ItemItemizedItems" : self->itemItemizedItems} mutableCopy];
                    
                    [self UpdateAllDataInViewController:nil dictToUse:dictToUse];
                    
                }
                
            }];
            
        });
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [[[SetDataObject alloc] init] UpdateDataEditItem:@{@"ItemItemizedItems" : self->itemItemizedItems} itemID:self->_itemID itemOccurrenceID:self->_itemOccurrenceID collection:self->itemTypeCollection homeID:self->homeID completionHandler:^(BOOL finished) {
                
                if (totalQueries == (completedQueries+=1)) {
                    
                    NSMutableDictionary *dictToUse = [@{@"ItemCompletedDict" : self->itemCompletedDict, @"ItemInProgressDict" : self->itemInProgressDict, @"ItemWontDo" : self->itemWontDoDict, @"ItemItemizedItems" : self->itemItemizedItems} mutableCopy];
                    
                    [self UpdateAllDataInViewController:nil dictToUse:dictToUse];
                    
                }
                
            }];
            
        });
        
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction * _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Edit Itemized Item Cancelled %@ For %@", self->_itemID, self->itemType] completionHandler:^(BOOL finished) {
            
        }];
        
    }];
    
    
    
    [controller addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        
        NSString *itemizedItem = [self GenerateDataForSpeificItemAtIndex:indexPath];
        
        textField.delegate = self;
        textField.text = itemizedItem;
        textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
        
    }];
    
    [controller addAction:action1];
    [controller addAction:cancel];
    [self presentViewController:controller animated:YES completion:nil];
    
}

-(IBAction)DeleteItemizedItemItemTypeExpense:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Delete Itemized Item Selected %@ For %@", _itemID, itemType] completionHandler:^(BOOL finished) {
        
    }];
    
//    [self StartProgressView];
    
    NSIndexPath *indexPath = (NSIndexPath *)sender;
    
    
    
    NSString *itemizedItem = [self GenerateDataForSpeificItemAtIndex:indexPath];
    NSString *oldItem = itemizedItem;
    [itemItemizedItems removeObjectForKey:itemizedItem];
    
    itemAmount = [self GenerateItemAmountFromItemizedItems];
    
    
    
    float totalAmountForAllItemizedItems = 0.0;
    
    for (NSString *itemizedItemName in [itemItemizedItems allKeys]) {
        
        NSString *itemAmountString = @"";
        id itemAmountArray = itemItemizedItems[itemizedItemName][@"Amount"];
        
        BOOL ObjectIsKindOfArrayClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:itemAmountArray classArr:@[[NSArray class], [NSMutableArray class]]];
        BOOL ObjectIsKindOfStringClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:itemAmountArray classArr:@[[NSString class]]];
        
        if (ObjectIsKindOfArrayClass == YES) {
            itemAmountString = itemAmountArray[0];
        } else if (ObjectIsKindOfStringClass == YES) {
            itemAmountString = itemAmountArray;
        }
        
        itemAmountString = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:itemAmountString arrayOfSymbols:@[localCurrencyNumberSeparatorSymbol, localCurrencySymbol]];
        
        itemAmountString = [[[GeneralObject alloc] init] GenerateLocalCurrencyStringWithReverseSeparatorsForeign:itemAmountString];
        
        totalAmountForAllItemizedItems += [itemAmountString floatValue];
        
    }
    
    NSString *totalAmountForAllItemizedItemsString = [NSString stringWithFormat:@"%.2f", totalAmountForAllItemizedItems];
    
    totalAmountForAllItemizedItemsString = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:totalAmountForAllItemizedItemsString arrayOfSymbols:@[localCurrencyNumberSeparatorSymbol, localCurrencyDecimalSeparatorSymbol, localCurrencySymbol]];
    totalAmountForAllItemizedItemsString = [[[GeneralObject alloc] init] GenerateAmountInTextFieldInProperFormat:NSRangeFromString(totalAmountForAllItemizedItemsString) replacementString:totalAmountForAllItemizedItemsString];
    
    itemAmount = [totalAmountForAllItemizedItemsString isEqualToString:[NSString stringWithFormat:@"%@0%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol]] ? itemAmount : totalAmountForAllItemizedItemsString;
    
    
    
    
    itemizedItem = [self GenerateDataForSpeificItemAtIndex:indexPath];
    
    if ([[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:self->itemCompletedDict userIDToFind:itemizedItem]) {
        [self->itemCompletedDict removeObjectForKey:itemizedItem];
    }
    
    
    
    //Remove Loading
    
    NSMutableDictionary *dictToUse = [@{@"ItemCompletedDict" : self->itemCompletedDict, @"ItemInProgressDict" : self->itemInProgressDict, @"ItemWontDo" : self->itemWontDoDict, @"ItemItemizedItems" : self->itemItemizedItems, @"ItemAmount" : self->itemAmount} mutableCopy];
    
    [self UpdateAllDataInViewController:nil dictToUse:dictToUse];
    
    //
    
    
    
    __block int totalQueries = 2;
    __block int completedQueries = 0;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSMutableDictionary *singleObjectItemDict = [[[GeneralObject alloc] init] GenerateSingleObjectDictionary:[self->itemDict mutableCopy] keyArray:[self->keyArray mutableCopy] indexPath:nil];
        
        
        
        NSString *notificationType = [[[NotificationsObject alloc] init] NotificationSettingsUnknownItemType_Adding:NO Editing:NO Deleting:NO Duplicating:NO Waiving:NO Skipping:NO Pausing:NO Comments:NO
                                                                                                       SkippingTurn:NO RemovingUser:NO
                                                                                                     FullyCompleted:NO Completed:NO InProgress:NO WontDo:NO Accept:NO Decline:NO
                                                                                                            DueDate:NO Reminder:NO
                                                                                                     SubtaskEditing:NO SubtaskDeleting:NO
                                                                                                   SubtaskCompleted:NO SubtaskInProgress:NO SubtaskWontDo:NO SubtaskAccept:NO SubtaskDecline:NO
                                                                                                     AddingListItem:NO EditingListItem:NO DeletingListItem:NO ResetingListItem:NO
                                                                                                EditingItemizedItem:NO DeletingItemizedItem:YES
                                                                                                  GroupChatMessages:NO LiveSupportMessages:NO
                                                                                                 SendingInvitations:NO DeletingInvitations:NO NewHomeMembers:NO HomeMembersMovedOut:NO HomeMembersKickedOut:NO
                                                                                                FeatureForumUpvotes:NO BugForumUpvotes:NO
                                                                                                           itemType:self->itemType];
        
        
        
        NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
        
        
        
        NSString *notificationTitle = [NSString stringWithFormat:@"\"%@\"", self->itemName];
        NSString *notificationBody = [NSString stringWithFormat:@"%@ removed \"%@\" from this itemized expense. ❌", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"], oldItem];
        
        
        
        NSMutableArray *usersToSendNotificationTo = [self->itemAssignedToArray mutableCopy];
        
        NSArray *addTheseUsers = @[self->itemCreatedBy];
        NSArray *removeTheseUsers = @[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx"];
        
        usersToSendNotificationTo = [[[[NotificationsObject alloc] init] AddAndRemoveSpecificUsersFromArray:usersToSendNotificationTo addTheseUsers:addTheseUsers removeTheseUsers:removeTheseUsers] mutableCopy];
        
        
        
        [[[NotificationsObject alloc] init] SendPushNotificationToArrayOfUsers_Items:usersToSendNotificationTo
                                                                           dictToUse:singleObjectItemDict
                                                                              homeID:homeID homeMembersArray:self->_homeMembersArray homeMembersDict:self->_homeMembersDict
                                                            notificationSettingsDict:self->_notificationSettingsDict notificationItemType:self->itemType notificationType:notificationType
                                                                           topicDict:self->_topicDict
                                                                 allItemTagsArrays:self->_allItemTagsArrays
                                                               pushNotificationTitle:notificationTitle pushNotificationBody:notificationBody
                                                                   notificationTitle:notificationTitle notificationBody:notificationBody
                                                             SetDataHomeNotification:YES
                                                                RemoveUsersNotInHome:YES
                                                                   completionHandler:^(BOOL finished) {
            
            if (totalQueries == (completedQueries+=1)) {
                
                NSMutableDictionary *dictToUse = [@{@"ItemCompletedDict" : self->itemCompletedDict, @"ItemInProgressDict" : self->itemInProgressDict, @"ItemWontDo" : self->itemWontDoDict, @"ItemItemizedItems" : self->itemItemizedItems, @"ItemAmount" : self->itemAmount} mutableCopy];
                
                [self UpdateAllDataInViewController:nil dictToUse:dictToUse];
                
            }
            
        }];
        
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *itemizedItem = [self GenerateDataForSpeificItemAtIndex:indexPath];
        
        if ([[self->itemInProgressDict allKeys] containsObject:itemizedItem]) {
            [self->itemInProgressDict removeObjectForKey:itemizedItem];
        }
        
        [[[SetDataObject alloc] init] UpdateDataEditItem:@{@"ItemItemizedItems" : self->itemItemizedItems, @"ItemAmount" : self->itemAmount, @"ItemCompletedDict" : self->itemCompletedDict, @"ItemInProgressDict" : self->itemInProgressDict} itemID:self->_itemID itemOccurrenceID:self->_itemOccurrenceID collection:self->itemTypeCollection homeID:self->homeID completionHandler:^(BOOL finished) {
            
            if (totalQueries == (completedQueries+=1)) {
                
                NSMutableDictionary *dictToUse = [@{@"ItemCompletedDict" : self->itemCompletedDict, @"ItemInProgressDict" : self->itemInProgressDict, @"ItemWontDo" : self->itemWontDoDict, @"ItemItemizedItems" : self->itemItemizedItems, @"ItemAmount" : self->itemAmount} mutableCopy];
                
                [self UpdateAllDataInViewController:nil dictToUse:dictToUse];
                
            }
            
        }];
        
    });
    
}

-(IBAction)ResetExpenseActionItemTypeExpense:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Reset Itemized Selected %@ For %@", _itemID, itemType] completionHandler:^(BOOL finished) {
        
    }];
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Would you like to reset all items in \"%@\" to uncompleted?", itemName] message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *completeUncompleteAction = [UIAlertAction actionWithTitle:@"Reset Itemized" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Resetting Itemized %@ For %@", self->_itemID, self->itemType] completionHandler:^(BOOL finished) {
            
        }];
        
//        [self StartProgressView];
        
        __block int totalQueries = 2;
        __block int completedQueries = 0;
        
        NSMutableDictionary *itemDictLocal = [NSMutableDictionary dictionary];
        
        if ([self->itemItemizedItems allKeys] > 0) {
            
            for (NSString *key in [self->itemItemizedItems allKeys]) {
                
                if ([[itemDictLocal allKeys] containsObject:key] == NO) {
                    
                    NSString *previousAssignedTo = itemDictLocal[key][@"Assigned To"];
                    [itemDictLocal setObject:@{@"Assigned To" : previousAssignedTo, @"Status" : @"Uncompleted"} forKey:key];
                    
                }
                
            }
            
        }
        
        self->itemItemizedItems = [itemDictLocal mutableCopy];
        
        
        
        //Remove Loading
        
        NSMutableDictionary *dictToUse = [@{@"ItemCompletedDict" : [NSMutableDictionary dictionary], @"ItemInProgressDict" : [NSMutableDictionary dictionary], @"ItemWontDo" : [NSMutableDictionary dictionary], @"ItemItemizedItems" : self->itemItemizedItems} mutableCopy];
        
        [self UpdateAllDataInViewController:nil dictToUse:dictToUse];
        
        //
        
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
            
            
            
            NSString *notificationTitle = [NSString stringWithFormat:@"\"%@\"", self->itemName];
            NSString *notificationBody = [NSString stringWithFormat:@"%@ has reset this itemized expense.", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"]];
            
            
            
            NSMutableArray *usersToSendNotificationTo = [self->itemAssignedToArray mutableCopy];
            
            NSArray *addTheseUsers = @[self->itemCreatedBy];
            NSArray *removeTheseUsers = @[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx"];
            
            usersToSendNotificationTo = [[[[NotificationsObject alloc] init] AddAndRemoveSpecificUsersFromArray:usersToSendNotificationTo addTheseUsers:addTheseUsers removeTheseUsers:removeTheseUsers] mutableCopy];
            
            
            
            NSMutableDictionary *singleObjectItemDict = [[[GeneralObject alloc] init] GenerateSingleObjectDictionary:[self->itemDict mutableCopy] keyArray:[self->keyArray mutableCopy] indexPath:nil];
            
            [[[NotificationsObject alloc] init] SendPushNotificationToArrayOfUsers_Items:usersToSendNotificationTo
                                                                               dictToUse:singleObjectItemDict
                                                                                  homeID:homeID homeMembersArray:self->_homeMembersArray homeMembersDict:self->_homeMembersDict
                                                                notificationSettingsDict:self->_notificationSettingsDict notificationItemType:self->itemType notificationType:@""
                                                                               topicDict:self->_topicDict
                                                                     allItemTagsArrays:self->_allItemTagsArrays
                                                                   pushNotificationTitle:notificationTitle pushNotificationBody:notificationBody
                                                                       notificationTitle:notificationTitle notificationBody:notificationBody
                                                                 SetDataHomeNotification:YES
                                                                    RemoveUsersNotInHome:YES
                                                                       completionHandler:^(BOOL finished) {
                
                if (totalQueries == (completedQueries+=1)) {
                    
                    NSMutableDictionary *dictToUse = [@{@"ItemCompletedDict" : [NSMutableDictionary dictionary], @"ItemInProgressDict" : [NSMutableDictionary dictionary], @"ItemWontDo" : [NSMutableDictionary dictionary], @"ItemItemizedItems" : self->itemItemizedItems} mutableCopy];
                    
                    [self UpdateAllDataInViewController:nil dictToUse:dictToUse];
                    
                }
                
            }];
            
        });
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSMutableDictionary *itemDict = [NSMutableDictionary dictionary];
            
            if ([self->itemItemizedItems allKeys] > 0) {
                
                for (NSString *key in [self->itemItemizedItems allKeys]) {
                    
                    if ([[itemDict allKeys] containsObject:key] == NO) {
                        
                        id previousAmount = itemDict[key] && itemDict[key][@"Amount"] ? itemDict[key][@"Amount"] : [NSString stringWithFormat:@"0%@00", self->localCurrencyDecimalSeparatorSymbol];
                        
                        BOOL ObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:previousAmount classArr:@[[NSArray class], [NSMutableArray class]]];
                        
                        if (ObjectIsKindOfClass == YES) {
                            previousAmount = previousAmount[0];
                        }
                        
                        NSString *previousAssignedTo = itemDict[key][@"Assigned To"];
                        [itemDict setObject:@{@"Amount" : previousAmount, @"Assigned To" : previousAssignedTo, @"Status" : @"Uncompleted"} forKey:key];
                        
                    }
                    
                }
                
            }
            
            NSDictionary *setDataDict = @{@"ItemCompletedDict" : [NSMutableDictionary dictionary], @"ItemInProgressDict" : [NSMutableDictionary dictionary], @"ItemItemizedItems" : itemDict};
            
            [[[SetDataObject alloc] init] UpdateDataEditItem:setDataDict itemID:self->_itemID itemOccurrenceID:self->_itemOccurrenceID collection:self->itemTypeCollection homeID:self->homeID completionHandler:^(BOOL finished) {
                
                if (totalQueries == (completedQueries+=1)) {
                    
                    NSMutableDictionary *dictToUse = [@{@"ItemCompletedDict" : [NSMutableDictionary dictionary], @"ItemInProgressDict" : [NSMutableDictionary dictionary], @"ItemWontDo" : [NSMutableDictionary dictionary], @"ItemItemizedItems" : self->itemItemizedItems} mutableCopy];
                    
                    [self UpdateAllDataInViewController:nil dictToUse:dictToUse];
                    
                }
                
            }];
            
        });
        
    }];
    
    [completeUncompleteAction setValue:[UIColor redColor] forKey:@"titleTextColor"];
    
    [actionSheet addAction:completeUncompleteAction];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Reset Itemized Cancelled %@ For %@", self->_itemID, self->itemType] completionHandler:^(BOOL finished) {
            
        }];
        
    }]];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
    
}

#pragma mark - Task

-(IBAction)CompletedUncompletedAction:(id)sender {
    
//    [self StartProgressView];
    
    NSMutableDictionary *dictToUse = [self->itemDict mutableCopy];
    NSMutableDictionary *dictToUseLocal = [dictToUse mutableCopy];
    NSIndexPath *indexPath = [[[CompleteUncompleteObject alloc] init] GenerateTempIndexPath];
    
    NSMutableDictionary *homeMembersDictLocal = _homeMembersDict ? [_homeMembersDict mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableArray *allItemAssignedToArrays = _allItemAssignedToArrays ? [self->_allItemAssignedToArrays mutableCopy] : [NSMutableArray array];
    NSString *userWhoIsBeingMarkedUserID = itemAssignedToArray && [itemAssignedToArray count] > indexPath.row ? itemAssignedToArray[indexPath.row] : @"";
    
    
    BOOL markingForSomeoneElse = ([[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"] &&
                                  [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"][@"CompletedBy"] &&
                                  [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"][@"CompletedFor"] &&
                                  [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"][@"CompletedForSomeoneElse"] &&
                                  [[[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"][@"CompletedBy"] length] > 0 &&
                                  [[[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"][@"CompletedFor"] length] > 0 &&
                                  [[[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"][@"CompletedForSomeoneElse"] length] > 0 &&
                                  [[[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"][@"CompletedBy"] isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"][@"CompletedFor"]] == NO &&
                                  [[[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"][@"CompletedForSomeoneElse"] isEqualToString:@"Yes"] == YES) ? YES : NO;
    
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"";
    NSMutableDictionary *itemCompletedDict = self->itemCompletedDict ? [self->itemCompletedDict mutableCopy] : [NSMutableDictionary dictionary];
    
    BOOL TaskAlreadyCompleted = [[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemCompletedDict userIDToFind:userID];
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"%@ Clicked %@ For %@", TaskAlreadyCompleted == YES ? @"Uncomplete" : @"Complete", _itemID, itemType] completionHandler:^(BOOL finished) {
        
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
    
    
    
    //Remove Loading
    
    dictToUseLocal = [[[CompleteUncompleteObject alloc] init] GenerateUpdatedTaskCompleteUncompleteDict:dictToUseLocal itemOccurrencesDict:itemxxxOccurrencesDict homeMembersDict:_homeMembersDict userWhoIsBeingMarkedUserID:userWhoIsBeingMarkedUserID markingForSomeoneElse:markingForSomeoneElse];
    
    self->itemxxxOccurrencesDict = [itemxxxOccurrencesDict mutableCopy];
    self->_taskListDict = [[[GeneralObject alloc] init] GenerateUpdatedTaskListDict:@[[NSMutableDictionary dictionary]] taskListDict:self->_taskListDict];
    [self UpdateAllDataInViewController:indexPath dictToUse:dictToUseLocal];
    
    //
    
   
    
    [[[CompleteUncompleteObject alloc] init] TaskCompleteUncomplete:dictToUse itemOccurrencesDict:self->itemxxxOccurrencesDict keyArray:self->keyArray homeMembersArray:self->_homeMembersArray homeMembersDict:homeMembersDictLocal notificationSettingsDict:self->_notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType topicDict:self->_topicDict taskListDict:_taskListDict allItemAssignedToArrays:allItemAssignedToArrays allItemTagsArrays:_allItemTagsArrays userWhoIsBeingMarkedUserID:userWhoIsBeingMarkedUserID markingForSomeoneElse:markingForSomeoneElse currentViewController:self completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningDictToUse, NSMutableDictionary * _Nonnull returningOccurrencesDictToUse, NSMutableDictionary * _Nonnull returningUpdatedTaskListDictToUse, BOOL TaskIsFullyCompleted) {
        
        self->itemxxxOccurrencesDict = [returningOccurrencesDictToUse mutableCopy];
        self->_taskListDict = [[[GeneralObject alloc] init] GenerateUpdatedTaskListDict:@[returningUpdatedTaskListDictToUse] taskListDict:self->_taskListDict];
        [self UpdateAllDataInViewController:indexPath dictToUse:returningDictToUse];
        
        TaskIsFullyCompleted = [[[BoolDataObject alloc] init] TaskIsFullyCompleted:dictToUseLocal itemType:self->itemType homeMembersDict:self->_homeMembersDict];
        
        [self CompleteUncompleteTaskAction_DisplayRepeatIfCompletedEarlyResetDropDown:dictToUseLocal TaskIsFullyCompleted:TaskIsFullyCompleted];
        
    }];
    
}

-(IBAction)InProgressNotInProgressAction:(id)sender {
    
//    [self StartProgressView];
    
    NSMutableDictionary *dictToUse = [self->itemDict mutableCopy];
    NSMutableDictionary *dictToUseLocal = [dictToUse mutableCopy];
    NSIndexPath *indexPath = [[[CompleteUncompleteObject alloc] init] GenerateTempIndexPath];
    
    NSMutableDictionary *homeMembersDictLocal = _homeMembersDict ? [_homeMembersDict mutableCopy] : [NSMutableDictionary dictionary];
    NSString *userWhoIsBeingMarkedUserID = itemAssignedToArray && [itemAssignedToArray count] > indexPath.row ? itemAssignedToArray[indexPath.row] : @"";
    
    
    
    BOOL markingForSomeoneElse = ([[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"] &&
                                  [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"][@"CompletedBy"] &&
                                  [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"][@"CompletedFor"] &&
                                  [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"][@"CompletedForSomeoneElse"] &&
                                  [[[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"][@"CompletedBy"] length] > 0 &&
                                  [[[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"][@"CompletedFor"] length] > 0 &&
                                  [[[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"][@"CompletedForSomeoneElse"] length] > 0 &&
                                  [[[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"][@"CompletedBy"] isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"][@"CompletedFor"]] == NO &&
                                  [[[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"][@"CompletedForSomeoneElse"] isEqualToString:@"Yes"] == YES) ? YES : NO;
    
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"";
    NSMutableDictionary *itemInProgressDict = self->itemInProgressDict ? [self->itemInProgressDict mutableCopy] : [NSMutableDictionary dictionary];
    
    BOOL TaskAlreadyInProgress = [[itemInProgressDict allKeys] containsObject:userID];
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"%@ Clicked %@ For %@", TaskAlreadyInProgress == YES ? @"Not In Progress" : @"In Progress", _itemID, itemType] completionHandler:^(BOOL finished) {
        
    }];
    
    
    
    NSString *notificationType = [[[NotificationsObject alloc] init] NotificationSettingsUnknownItemType_Adding:NO Editing:NO Deleting:NO Duplicating:NO Waiving:NO Skipping:NO Pausing:NO Comments:NO
                                                                                                   SkippingTurn:NO RemovingUser:NO
                                                                                                 FullyCompleted:NO Completed:NO InProgress:YES WontDo:NO Accept:NO Decline:NO
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
    
    
    
    //Remove Loading
    
    dictToUseLocal = [[[CompleteUncompleteObject alloc] init] GenerateUpdatedTaskInProgressNotInProgressDict:dictToUseLocal userWhoIsBeingMarkedUserID:userWhoIsBeingMarkedUserID markingForSomeoneElse:markingForSomeoneElse];
    
    
    self->itemxxxOccurrencesDict = [itemxxxOccurrencesDict mutableCopy];
    [self UpdateAllDataInViewController:indexPath dictToUse:dictToUseLocal];
    
    //
    
    
    
    [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress:dictToUse itemOccurrencesDict:itemxxxOccurrencesDict keyArray:self->keyArray homeMembersArray:self->_homeMembersArray homeMembersDict:homeMembersDictLocal notificationSettingsDict:self->_notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType topicDict:self->_topicDict allItemTagsArrays:_allItemTagsArrays userWhoIsBeingMarkedUserID:userWhoIsBeingMarkedUserID markingForSomeoneElse:markingForSomeoneElse currentViewController:self completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningDictToUse, NSMutableDictionary * _Nonnull returningOccurrencesDictToUse) {
        
        self->itemxxxOccurrencesDict = [returningOccurrencesDictToUse mutableCopy];
        [self UpdateAllDataInViewController:indexPath dictToUse:returningDictToUse];
        
    }];
    
}

-(IBAction)MuteTaskAction:(id)sender {
    
    NSMutableDictionary *singleObjectItemDict = [[[GeneralObject alloc] init] GenerateSingleObjectDictionary:[self->itemDict mutableCopy] keyArray:[self->keyArray mutableCopy] indexPath:nil];
    
    
    
    BOOL TaskHasBeenMuted = [[[BoolDataObject alloc] init] TaskHasBeenMuted:singleObjectItemDict];
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"%@ Clicked For %@", TaskHasBeenMuted == NO ? @"Mute" : @"Unmute", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    BOOL Mute = TaskHasBeenMuted == NO;
    
    
    
    [self MuteUnmute_UpdateMutedArray:Mute];
    
    
    
    __block int totalQueries = 3;
    __block int completedQueries = 0;
    
    
    
    /*
     //
     //
     //Reset Item Notifications
     //
     //
     */
    [self MuteUnmute_ResetItemNotifications:singleObjectItemDict completionHandler:^(BOOL finished) {
        
        [self MuteUnmute_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) indexPath:nil singleObjectItemDict:singleObjectItemDict];
        
    }];
    
    
    /*
     //
     //
     //Reset Item Scheduled Start Notifications
     //
     //
     */
    [self MuteUnmute_ResetItemScheduledStartNotifications:singleObjectItemDict completionHandler:^(BOOL finished) {
        
        [self MuteUnmute_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) indexPath:nil singleObjectItemDict:singleObjectItemDict];
        
    }];
    
    
    /*
     //
     //
     //Reset Item Custom Reminder Notifications
     //
     //
     */
    [self MuteUnmute_ResetItemCustomReminderNotifications:singleObjectItemDict completionHandler:^(BOOL finished) {
        
        [self MuteUnmute_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) indexPath:nil singleObjectItemDict:singleObjectItemDict];;
        
    }];
    
}

#pragma mark - Subtask

-(IBAction)SubTaskCompletedUncompletedAction:(id)sender {
    
//    [self StartProgressView];

    NSMutableDictionary *dictToUse = [self->itemDict mutableCopy];
    NSMutableDictionary *dictToUseLocal = [dictToUse mutableCopy];
    NSIndexPath *indexPath = [[[CompleteUncompleteObject alloc] init] GenerateTempIndexPath];
    
    NSMutableDictionary *homeMembersDictLocal = _homeMembersDict ? [_homeMembersDict mutableCopy] : [NSMutableDictionary dictionary];
    NSString *subtaskThatIsBeingMarked = itemSubTasksDict && [[itemSubTasksDict allKeys] count] > indexPath.row ? [[itemSubTasksDict allKeys][indexPath.row] mutableCopy] : @"";
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Subtask Completed/Uncompleted Clicked %@ For %@", _itemID, itemType] completionHandler:^(BOOL finished) {
        
    }];
    
    NSString *notificationType = [[[NotificationsObject alloc] init] NotificationSettingsUnknownItemType_Adding:NO Editing:NO Deleting:NO Duplicating:NO Waiving:NO Skipping:NO Pausing:NO Comments:NO
                                                                                                   SkippingTurn:NO RemovingUser:NO
                                                                                                 FullyCompleted:NO Completed:NO InProgress:NO WontDo:NO Accept:NO Decline:NO
                                                                                                        DueDate:NO Reminder:NO
                                                                                                 SubtaskEditing:NO SubtaskDeleting:NO
                                                                                               SubtaskCompleted:YES SubtaskInProgress:NO SubtaskWontDo:NO SubtaskAccept:NO SubtaskDecline:NO
                                                                                                 AddingListItem:NO EditingListItem:NO DeletingListItem:NO ResetingListItem:NO
                                                                                            EditingItemizedItem:NO DeletingItemizedItem:NO
                                                                                              GroupChatMessages:NO LiveSupportMessages:NO
                                                                                             SendingInvitations:NO DeletingInvitations:NO NewHomeMembers:NO HomeMembersMovedOut:NO HomeMembersKickedOut:NO
                                                                                            FeatureForumUpvotes:NO BugForumUpvotes:NO
                                                                                                       itemType:itemType];
    
    NSString *notificationItemType = itemType;
    
    BOOL markingForSomeoneElse = NO;
    
    
    
    //Remove Loading
    
    dictToUseLocal = [[[[CompleteUncompleteObject alloc] init] GenerateUpdatedSubtaskCompleteUncompleteDict:[dictToUseLocal mutableCopy] subtaskThatIsBeingMarked:subtaskThatIsBeingMarked markingForSomeoneElse:markingForSomeoneElse] mutableCopy];
  
    self->itemxxxOccurrencesDict = [itemxxxOccurrencesDict mutableCopy];
    [self UpdateAllDataInViewController:indexPath dictToUse:dictToUseLocal];
    
    //
    

    
    [[[CompleteUncompleteObject alloc] init] SubtaskCompleteUncomplete:[dictToUse mutableCopy] itemOccurrencesDict:itemxxxOccurrencesDict keyArray:self->keyArray homeMembersArray:self->_homeMembersArray homeMembersDict:homeMembersDictLocal notificationSettingsDict:self->_notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType topicDict:self->_topicDict allItemTagsArrays:_allItemTagsArrays subtaskThatIsBeingMarked:subtaskThatIsBeingMarked markingForSomeoneElse:markingForSomeoneElse currentViewController:self completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningDictToUse, NSMutableDictionary * _Nonnull returningOccurrencesDictToUse) {
        
        self->itemxxxOccurrencesDict = [returningOccurrencesDictToUse mutableCopy];
        [self UpdateAllDataInViewController:indexPath dictToUse:returningDictToUse];
        
    }];
    
}

-(IBAction)SubTaskInProgressNotInProgressAction:(id)sender {
    
//    [self StartProgressView];
    
    NSMutableDictionary *dictToUse = [self->itemDict mutableCopy];
    NSMutableDictionary *dictToUseLocal = [dictToUse mutableCopy];
    NSIndexPath *indexPath = [[[CompleteUncompleteObject alloc] init] GenerateTempIndexPath];
    
    NSMutableDictionary *homeMembersDictLocal = _homeMembersDict ? [_homeMembersDict mutableCopy] : [NSMutableDictionary dictionary];
    NSString *subtaskThatIsBeingMarked = itemSubTasksDict && [[itemSubTasksDict allKeys] count] > indexPath.row ? [itemSubTasksDict allKeys][indexPath.row] : @"";
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Subtask In Progress/Not In Progress Clicked %@ For %@", _itemID, itemType] completionHandler:^(BOOL finished) {
        
    }];
    
    NSString *notificationType = [[[NotificationsObject alloc] init] NotificationSettingsUnknownItemType_Adding:NO Editing:NO Deleting:NO Duplicating:NO Waiving:NO Skipping:NO Pausing:NO Comments:NO
                                                                                                   SkippingTurn:NO RemovingUser:NO
                                                                                                 FullyCompleted:NO Completed:NO InProgress:NO WontDo:NO Accept:NO Decline:NO
                                                                                                        DueDate:NO Reminder:NO
                                                                                                 SubtaskEditing:NO SubtaskDeleting:NO
                                                                                               SubtaskCompleted:NO SubtaskInProgress:YES SubtaskWontDo:NO SubtaskAccept:NO SubtaskDecline:NO
                                                                                                 AddingListItem:NO EditingListItem:NO DeletingListItem:NO ResetingListItem:NO
                                                                                            EditingItemizedItem:NO DeletingItemizedItem:NO
                                                                                              GroupChatMessages:NO LiveSupportMessages:NO
                                                                                             SendingInvitations:NO DeletingInvitations:NO NewHomeMembers:NO HomeMembersMovedOut:NO HomeMembersKickedOut:NO
                                                                                            FeatureForumUpvotes:NO BugForumUpvotes:NO
                                                                                                       itemType:itemType];
    
    NSString *notificationItemType = itemType;
    
    BOOL markingForSomeoneElse = NO;
    
    
    
    //Remove Loading
    
    dictToUseLocal = [[[CompleteUncompleteObject alloc] init] GenerateUpdatedSubtaskInProgressNotInProgressDict:dictToUseLocal subtaskThatIsBeingMarked:subtaskThatIsBeingMarked markingForSomeoneElse:markingForSomeoneElse];
    
    
    self->itemxxxOccurrencesDict = [itemxxxOccurrencesDict mutableCopy];
    [self UpdateAllDataInViewController:indexPath dictToUse:dictToUseLocal];
    
    //
    
    
    
    [[[CompleteUncompleteObject alloc] init] SubtaskInProgressNotInProgress:dictToUse itemOccurrencesDict:itemxxxOccurrencesDict keyArray:self->keyArray homeMembersArray:self->_homeMembersArray homeMembersDict:homeMembersDictLocal notificationSettingsDict:self->_notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType topicDict:self->_topicDict allItemTagsArrays:_allItemTagsArrays subtaskThatIsBeingMarked:subtaskThatIsBeingMarked markingForSomeoneElse:markingForSomeoneElse currentViewController:self completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningDictToUse, NSMutableDictionary * _Nonnull returningOccurrencesDictToUse) {
        
        self->itemxxxOccurrencesDict = [returningOccurrencesDictToUse mutableCopy];
        [self UpdateAllDataInViewController:indexPath dictToUse:returningDictToUse];
        
    }];
    
}

#pragma mark - List

-(IBAction)ListItemCompletedUncompletedAction:(id)sender {
    
//    [self StartProgressView];
    
    NSMutableDictionary *dictToUse = [self->itemDict mutableCopy];
    NSMutableDictionary *dictToUseLocal = [dictToUse mutableCopy];
    NSIndexPath *indexPath = [[[CompleteUncompleteObject alloc] init] GenerateTempIndexPath];
    
    NSMutableDictionary *homeMembersDictLocal = _homeMembersDict ? [_homeMembersDict mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableArray *allItemAssignedToArrays = _allItemAssignedToArrays ? [self->_allItemAssignedToArrays mutableCopy] : [NSMutableArray array];
    
    NSArray *keysArray = itemListItems/*itemListSectionsArray && [itemListSectionsArray count] > indexPath.section && [itemListSectionsArray[indexPath.section] allKeys]*/ ? [itemListItems allKeys]/*[itemListSectionsArray[indexPath.section] allKeys]*/ : @[];
    NSArray *sortedKeysArray = [keysArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    NSString *listItemThatIsBeingMarked = sortedKeysArray && [sortedKeysArray count] > indexPath.row ? sortedKeysArray[indexPath.row] : @"";
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"List Item Completed/Uncompleted Clicked %@ For %@", _itemID, itemType] completionHandler:^(BOOL finished) {
        
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
    
    dictToUseLocal = [[[CompleteUncompleteObject alloc] init] GenerateUpdatedListItemCompleteUncompleteDict:dictToUseLocal itemOccurrencesDict:itemxxxOccurrencesDict homeMembersDict:_homeMembersDict listItemThatIsBeingMarked:listItemThatIsBeingMarked markingForSomeoneElse:markingForSomeoneElse];
    
    self->itemxxxOccurrencesDict = [itemxxxOccurrencesDict mutableCopy];
    self->_taskListDict = [[[GeneralObject alloc] init] GenerateUpdatedTaskListDict:@[[NSMutableDictionary dictionary]] taskListDict:self->_taskListDict];
    [self UpdateAllDataInViewController:indexPath dictToUse:dictToUseLocal];
    
    //
    

    
    [[[CompleteUncompleteObject alloc] init] ListItemCompleteUncomplete:dictToUse itemOccurrencesDict:self->itemxxxOccurrencesDict keyArray:self->keyArray homeMembersArray:self->_homeMembersArray homeMembersDict:homeMembersDictLocal notificationSettingsDict:self->_notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType topicDict:self->_topicDict taskListDict:_taskListDict allItemAssignedToArrays:allItemAssignedToArrays allItemTagsArrays:_allItemTagsArrays listItemThatIsBeingMarked:listItemThatIsBeingMarked markingForSomeoneElse:markingForSomeoneElse currentViewController:self completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningDictToUse, NSMutableDictionary * _Nonnull returningOccurrencesDictToUse, NSMutableDictionary * _Nonnull returningUpdatedTaskListDictToUse) {
       
        self->itemxxxOccurrencesDict = [returningOccurrencesDictToUse mutableCopy];
        self->_taskListDict = [[[GeneralObject alloc] init] GenerateUpdatedTaskListDict:@[returningUpdatedTaskListDictToUse] taskListDict:self->_taskListDict];
        [self UpdateAllDataInViewController:indexPath dictToUse:returningDictToUse];
        
        BOOL TaskIsFullyCompleted = [[[BoolDataObject alloc] init] TaskIsFullyCompleted:dictToUseLocal itemType:self->itemType homeMembersDict:self->_homeMembersDict];
        
        [self CompleteUncompleteTaskAction_DisplayRepeatIfCompletedEarlyResetDropDown:dictToUseLocal TaskIsFullyCompleted:TaskIsFullyCompleted];
        
    }];
    
}

-(IBAction)ListItemInProgressNotInProgressAction:(id)sender {
    
//    [self StartProgressView];
    
    NSMutableDictionary *dictToUse = [self->itemDict mutableCopy];
    NSMutableDictionary *dictToUseLocal = [dictToUse mutableCopy];
    NSIndexPath *indexPath = [[[CompleteUncompleteObject alloc] init] GenerateTempIndexPath];
    
    NSMutableDictionary *homeMembersDictLocal = _homeMembersDict ? [_homeMembersDict mutableCopy] : [NSMutableDictionary dictionary];
    
    NSArray *keysArray = itemListItems/*itemListSectionsArray && [itemListSectionsArray count] > indexPath.section && [itemListSectionsArray[indexPath.section] allKeys]*/ ? [itemListItems allKeys]/*[itemListSectionsArray[indexPath.section] allKeys]*/ : @[];
    NSArray *sortedKeysArray = [keysArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    NSString *listItemThatIsBeingMarked = sortedKeysArray && [sortedKeysArray count] > indexPath.row ? sortedKeysArray[indexPath.row] : @"";
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"List Item In Progress/Not In Progress Clicked %@ For %@", _itemID, itemType] completionHandler:^(BOOL finished) {
        
    }];
    
    NSString *notificationType = [[[NotificationsObject alloc] init] NotificationSettingsUnknownItemType_Adding:NO Editing:NO Deleting:NO Duplicating:NO Waiving:NO Skipping:NO Pausing:NO Comments:NO
                                                                                                   SkippingTurn:NO RemovingUser:NO
                                                                                                 FullyCompleted:NO Completed:NO InProgress:YES WontDo:NO Accept:NO Decline:NO
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
    
    dictToUseLocal = [[[CompleteUncompleteObject alloc] init] GenerateUpdatedListItemInProgressNotInProgressDict:dictToUseLocal listItemThatIsBeingMarked:listItemThatIsBeingMarked markingForSomeoneElse:markingForSomeoneElse];
    
    
    self->itemxxxOccurrencesDict = [itemxxxOccurrencesDict mutableCopy];
    [self UpdateAllDataInViewController:indexPath dictToUse:dictToUseLocal];
    
    //
    
    
    
    [[[CompleteUncompleteObject alloc] init] ListItemInProgressNotInProgress:dictToUse itemOccurrencesDict:itemxxxOccurrencesDict keyArray:self->keyArray homeMembersArray:self->_homeMembersArray homeMembersDict:homeMembersDictLocal notificationSettingsDict:self->_notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType topicDict:self->_topicDict allItemTagsArrays:_allItemTagsArrays listItemThatIsBeingMarked:listItemThatIsBeingMarked markingForSomeoneElse:markingForSomeoneElse currentViewController:self completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningDictToUse, NSMutableDictionary * _Nonnull returningOccurrencesDictToUse) {
        
        self->itemxxxOccurrencesDict = [returningOccurrencesDictToUse mutableCopy];
        [self UpdateAllDataInViewController:indexPath dictToUse:returningDictToUse];
        
    }];
    
}

#pragma mark - Itemized

-(IBAction)ItemizedItemCompletedUncompletedAction:(id)sender {
    
//    [self StartProgressView];
    
    NSMutableDictionary *dictToUse = [self->itemDict mutableCopy];
    NSMutableDictionary *dictToUseLocal = [dictToUse mutableCopy];
    NSIndexPath *indexPath = [[[CompleteUncompleteObject alloc] init] GenerateTempIndexPath];
    
    NSMutableDictionary *homeMembersDictLocal = _homeMembersDict ? [_homeMembersDict mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableArray *allItemAssignedToArrays = _allItemAssignedToArrays ? [self->_allItemAssignedToArrays mutableCopy] : [NSMutableArray array];
    
    NSArray *keysArray = itemItemizedItems/*itemItemizedSectionsArray && [itemItemizedSectionsArray count] > indexPath.section && [itemItemizedSectionsArray[indexPath.section] allKeys]*/ ? [itemItemizedItems/*itemItemizedSectionsArray[indexPath.section]*/ allKeys] : @[];
    NSArray *sortedKeysArray = [keysArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    NSString *itemizedItemThatIsBeingMarked = sortedKeysArray && [sortedKeysArray count] > indexPath.row ? sortedKeysArray[indexPath.row] : @"";
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Itemized Item Completed/Uncompleted Clicked %@ For %@", _itemID, itemType] completionHandler:^(BOOL finished) {
        
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
    
    dictToUseLocal = [[[CompleteUncompleteObject alloc] init] GenerateUpdatedItemizedItemCompleteUncompleteDict:dictToUseLocal itemOccurrencesDict:itemxxxOccurrencesDict homeMembersDict:_homeMembersDict itemizedItemThatIsBeingMarked:itemizedItemThatIsBeingMarked markingForSomeoneElse:markingForSomeoneElse];
    
    self->itemxxxOccurrencesDict = [itemxxxOccurrencesDict mutableCopy];
    self->_taskListDict = [[[GeneralObject alloc] init] GenerateUpdatedTaskListDict:@[[NSMutableDictionary dictionary]] taskListDict:self->_taskListDict];
    [self UpdateAllDataInViewController:indexPath dictToUse:dictToUseLocal];
    
    //
    
   
    
    [[[CompleteUncompleteObject alloc] init] ItemizedItemCompleteUncomplete:dictToUse itemOccurrencesDict:self->itemxxxOccurrencesDict keyArray:self->keyArray homeMembersArray:self->_homeMembersArray homeMembersDict:homeMembersDictLocal notificationSettingsDict:self->_notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType topicDict:self->_topicDict taskListDict:_taskListDict allItemAssignedToArrays:allItemAssignedToArrays allItemTagsArrays:_allItemTagsArrays itemizedItemThatIsBeingMarked:itemizedItemThatIsBeingMarked markingForSomeoneElse:markingForSomeoneElse currentViewController:self completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningDictToUse, NSMutableDictionary * _Nonnull returningOccurrencesDictToUse, NSMutableDictionary * _Nonnull returningUpdatedTaskListDictToUse) {
       
        self->itemxxxOccurrencesDict = [returningOccurrencesDictToUse mutableCopy];
        self->_taskListDict = [[[GeneralObject alloc] init] GenerateUpdatedTaskListDict:@[returningUpdatedTaskListDictToUse] taskListDict:self->_taskListDict];
        [self UpdateAllDataInViewController:indexPath dictToUse:returningDictToUse];
        
        BOOL TaskIsFullyCompleted = [[[BoolDataObject alloc] init] TaskIsFullyCompleted:dictToUseLocal itemType:self->itemType homeMembersDict:self->_homeMembersDict];
        
        [self CompleteUncompleteTaskAction_DisplayRepeatIfCompletedEarlyResetDropDown:dictToUseLocal TaskIsFullyCompleted:TaskIsFullyCompleted];
        
    }];
    
}

-(IBAction)ItemizedItemInProgressNotInProgressAction:(id)sender {
    
//    [self StartProgressView];
    
    NSMutableDictionary *dictToUse = [self->itemDict mutableCopy];
    NSMutableDictionary *dictToUseLocal = [dictToUse mutableCopy];
    NSIndexPath *indexPath = [[[CompleteUncompleteObject alloc] init] GenerateTempIndexPath];
    
    NSMutableDictionary *homeMembersDictLocal = _homeMembersDict ? [_homeMembersDict mutableCopy] : [NSMutableDictionary dictionary];
    
    NSArray *keysArray = itemItemizedItems/*itemItemizedSectionsArray && [itemItemizedSectionsArray count] > indexPath.section && [itemItemizedSectionsArray[indexPath.section] allKeys]*/ ? [itemItemizedItems/*itemItemizedSectionsArray[indexPath.section]*/ allKeys] : @[];
    NSArray *sortedKeysArray = [keysArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    NSString *itemizedItemThatIsBeingMarked = sortedKeysArray && [sortedKeysArray count] > indexPath.row ? sortedKeysArray[indexPath.row] : @"";
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Itemized Item In Progress/Not In Progress Clicked %@ For %@", _itemID, itemType] completionHandler:^(BOOL finished) {
        
    }];
    
    NSString *notificationType = [[[NotificationsObject alloc] init] NotificationSettingsUnknownItemType_Adding:NO Editing:NO Deleting:NO Duplicating:NO Waiving:NO Skipping:NO Pausing:NO Comments:NO
                                                                                                   SkippingTurn:NO RemovingUser:NO
                                                                                                 FullyCompleted:NO Completed:NO InProgress:YES WontDo:NO Accept:NO Decline:NO
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
    
    dictToUseLocal = [[[CompleteUncompleteObject alloc] init] GenerateUpdatedItemizedItemInProgressNotInProgressDict:dictToUseLocal itemizedItemThatIsBeingMarked:itemizedItemThatIsBeingMarked markingForSomeoneElse:markingForSomeoneElse];

    
    self->itemxxxOccurrencesDict = [itemxxxOccurrencesDict mutableCopy];
    [self UpdateAllDataInViewController:indexPath dictToUse:dictToUseLocal];
    
    //
    
    
    
    [[[CompleteUncompleteObject alloc] init] ItemizedItemInProgressNotInProgress:dictToUse itemOccurrencesDict:itemxxxOccurrencesDict keyArray:self->keyArray homeMembersArray:self->_homeMembersArray homeMembersDict:homeMembersDictLocal notificationSettingsDict:self->_notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType topicDict:self->_topicDict allItemTagsArrays:_allItemTagsArrays itemizedItemThatIsBeingMarked:itemizedItemThatIsBeingMarked markingForSomeoneElse:markingForSomeoneElse currentViewController:self completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningDictToUse, NSMutableDictionary * _Nonnull returningOccurrencesDictToUse) {
        
        self->itemxxxOccurrencesDict = [returningOccurrencesDictToUse mutableCopy];
        [self UpdateAllDataInViewController:indexPath dictToUse:returningDictToUse];
        
    }];
    
}

#pragma mark - Select Option - Difficulty

-(IBAction)TapGestureDifficulty:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Difficulty Clicked %@ For %@", _itemID, itemType] completionHandler:^(BOOL finished) {
        
    }];
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"What difficulty level would you like to make these %@s?", [itemType lowercaseString]] message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    NSArray *options = @[@"Hard", @"Medium", @"Easy", @"None"];
    
    for (NSString *difficulty in options) {
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:difficulty style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Difficulty %@ Clicked %@ For %@", difficulty, self->_itemID, self->itemType] completionHandler:^(BOOL finished) {
                
            }];
            
//            [self StartProgressView];
            
            
            
            //Remove Loading
            
            [self UpdateAllDataInViewController:nil dictToUse:[@{@"ItemDifficulty" : difficulty} mutableCopy]];
            
            //
            
            
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                [[[SetDataObject alloc] init] UpdateDataEditItem:@{@"ItemDifficulty" : difficulty} itemID:self->_itemID itemOccurrenceID:self->_itemOccurrenceID collection:self->itemTypeCollection homeID:self->homeID completionHandler:^(BOOL finished) {
                    
                    [self UpdateAllDataInViewController:nil dictToUse:[@{@"ItemDifficulty" : difficulty} mutableCopy]];
                    
                }];
                
            });
            
        }]];
        
    }
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Difficulty Cancelled %@ For %@", self->_itemID, self->itemType] completionHandler:^(BOOL finished) {
            
        }];
        
    }]];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
    
}

#pragma mark - Select Option - Priority

-(IBAction)TapGesturePriority:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Priority Clicked %@ For %@", _itemID, itemType] completionHandler:^(BOOL finished) {
        
    }];
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"What priority level would you like to make these %@s?", [itemType lowercaseString]] message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    NSArray *options = @[@"High", @"Medium", @"Low", @"No Priority"];
    
    for (NSString *priority in options) {
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:priority style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Priority %@ Clicked %@ For %@", priority, self->_itemID, self->itemType] completionHandler:^(BOOL finished) {
                
            }];
            
//            [self StartProgressView];
            
            
            
            //Remove Loading
            
            [self UpdateAllDataInViewController:nil dictToUse:[@{@"ItemPriority" : priority} mutableCopy]];
            
            //
            
            
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                [[[SetDataObject alloc] init] UpdateDataEditItem:@{@"ItemPriority" : priority} itemID:self->_itemID itemOccurrenceID:self->_itemOccurrenceID collection:self->itemTypeCollection homeID:self->homeID completionHandler:^(BOOL finished) {
                    
                    [self UpdateAllDataInViewController:nil dictToUse:[@{@"ItemPriority" : priority} mutableCopy]];
                    
                }];
                
            });
            
        }]];
        
    }
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Priority Cancelled %@ For %@", self->_itemID, self->itemType] completionHandler:^(BOOL finished) {
            
        }];
        
    }]];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
    
}

#pragma mark - Select Option - Tags

-(IBAction)TapGestureTags:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Tags Clicked %@ For %@", _itemID, itemType] completionHandler:^(BOOL finished) {
        
    }];
    
    NSMutableArray *allItemTagsArrays = [_allItemTagsArrays mutableCopy];
    NSMutableArray *itemTagsArrays = [self->itemTagsArray mutableCopy];
    
    [[[PushObject alloc] init] PushToViewTagsViewController:itemTagsArrays allItemTagsArrays:allItemTagsArrays viewingItemDetails:NO comingFromAddTaskViewController:NO comingFromViewTaskViewController:YES currentViewController:self];
    
}

#pragma mark - Select Option - Color

-(IBAction)TapGestureColor:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Color Clicked %@ For %@", _itemID, itemType] completionHandler:^(BOOL finished) {
        
    }];
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"What color would you like to make these %@s?", [itemType lowercaseString]] message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    NSArray *options = [[[GeneralObject alloc] init] GenerateColorOptionsArray];
    
    for (NSString *color in options) {
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:color style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Priority %@ Clicked %@ For %@", color, self->_itemID, self->itemType] completionHandler:^(BOOL finished) {
                
            }];
            
//            [self StartProgressView];
            
            
            
            //Remove Loading
            
            [self UpdateAllDataInViewController:nil dictToUse:[@{@"ItemColor" : color} mutableCopy]];
            
            //
            
            
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                [[[SetDataObject alloc] init] UpdateDataEditItem:@{@"ItemColor" : color} itemID:self->_itemID itemOccurrenceID:self->_itemOccurrenceID collection:self->itemTypeCollection homeID:self->homeID completionHandler:^(BOOL finished) {
                    
                    [self UpdateAllDataInViewController:nil dictToUse:[@{@"ItemColor" : color} mutableCopy]];
                    
                }];
                
            });
            
        }]];
        
    }
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Color Cancelled %@ For %@", self->_itemID, self->itemType] completionHandler:^(BOOL finished) {
            
        }];
        
    }]];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
    
}

#pragma mark - Select Option - Duplicate

-(void)TapGestureDuplicate:(id)sender {
    
    [self StartProgressView];
    
    NSMutableArray *itemNamesAlreadyUsed = _itemNamesAlreadyUsed;
    NSMutableArray *newItemNames = [NSMutableArray array];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"StopDoneActionReloadTableView"];
    
    NSMutableDictionary *singleObjectItemDict = [[[GeneralObject alloc] init] GenerateSingleObjectDictionary:[self->itemDict mutableCopy] keyArray:[self->keyArray mutableCopy] indexPath:nil];
    
    NSMutableDictionary *setDataDict = [self Duplicate_GenerateSetDataDict:singleObjectItemDict itemNamesAlreadyUsed:itemNamesAlreadyUsed newItemNames:newItemNames];
    
   
    
    __block int totalQueries = 5;
    __block int completedQueries = 0;
    
    
    
    /*
     //
     //
     //Send Push Notification
     //
     //
     */
    [self Duplicate_SendPushNotifications:setDataDict completionHandler:^(BOOL finished) {
        
        [self Duplicate_CompletionBlock:setDataDict totalQueries:totalQueries completedQueries:(completedQueries+=1) completionHandler:^(BOOL finished) {
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Send Item Silent Notification
     //
     //
     */
    [self Duplicate_SendItemSilentNotifications:setDataDict completionHandler:^(BOOL finished) {
        
        [self Duplicate_CompletionBlock:setDataDict totalQueries:totalQueries completedQueries:(completedQueries+=1) completionHandler:^(BOOL finished) {
            
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Set Item Data
     //
     //
     */
    [self Duplicate_SetItemData:setDataDict completionHandler:^(BOOL finished) {
        
        [self Duplicate_CompletionBlock:setDataDict totalQueries:totalQueries completedQueries:(completedQueries+=1) completionHandler:^(BOOL finished) {
            
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Set Image Data
     //
     //
     */
    [self Duplicate_SetImageData:setDataDict completionHandler:^(BOOL finished) {
        
        [self Duplicate_CompletionBlock:setDataDict totalQueries:totalQueries completedQueries:(completedQueries+=1) completionHandler:^(BOOL finished) {
            
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Update Task List Data
     //
     //
     */
    [self Duplicate_UpdateTaskListData:_taskListDict newItemUniqueID:setDataDict[@"ItemUniqueID"] originalItemUniqueID:itemUniqueID completionHandler:^(BOOL finished) {
        
        [self Duplicate_CompletionBlock:setDataDict totalQueries:totalQueries completedQueries:(completedQueries+=1) completionHandler:^(BOOL finished) {
            
            
        }];
        
    }];
    
}

#pragma mark - Select Option - Share

-(IBAction)TapGestureShare:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Tell A Friend Clicked"] completionHandler:^(BOOL finished) {
        
    }];
    
    NSMutableDictionary *itemDictLocal = [[[GeneralObject alloc] init] GenerateSingleArraySingleObjectDictionary:self->itemDict keyArray:self->keyArray indexPath:nil];
    
    NSString *body = [[[GeneralObject alloc] init] GenerateShareString:itemDictLocal arrayOfUniqueIDs:@[itemUniqueID] itemType:itemType keyArray:keyArray homeMembersDict:_homeMembersDict];
    NSURL *attachment = [NSURL URLWithString:@"https://apps.apple.com/us/app/wedivvy/id1570700094"];
    
    NSArray* dataToShare = @[body, attachment];
    
    UIActivityViewController* activityViewController = [[UIActivityViewController alloc] initWithActivityItems:dataToShare applicationActivities:nil];
    [activityViewController setValue:@"WeDivvy Tasks" forKey:@"subject"];
    activityViewController.excludedActivityTypes = @[UIActivityTypeAirDrop];
    
    [activityViewController setCompletionWithItemsHandler:^(NSString * __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError) {
        
    }];
    
    [self presentViewController:activityViewController animated:YES completion:^{}];
    
}

#pragma mark - Other

-(IBAction)DismissViewController:(id)sender {
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"ComingFromShortcut"] isEqualToString:@"Yes"]) {
        [self.navigationController popViewControllerAnimated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

-(IBAction)NavigationBackButtonAction:(UIBarButtonItem *)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Navigation Back Button Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    [self NSNotificationObservers:YES];
    
    [self DismissViewController:self];
    
}

#pragma mark - Tap Gesture IBActions Methods

-(IBAction)TapGestureViewAnalytics:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Analytics Clicked %@ For %@", _itemID, itemType] completionHandler:^(BOOL finished) {
        
    }];
    
    if (self->ViewingAnalytics == NO) {
        
        [self CalculateItemProgressBarWidth];
        
    }
    
    NSMutableArray *indexPathArray = [NSMutableArray array];
    NSMutableArray *indexPathSubTasksArray = [NSMutableArray array];
    
    for (int i=0;i<[self->itemAssignedToArray count];i++) {
        [indexPathArray addObject:[NSIndexPath indexPathForRow:i inSection:0]];
    }
    
    for (int i=0;i<[[self->itemSubTasksDict allKeys] count];i++) {
        [indexPathSubTasksArray addObject:[NSIndexPath indexPathForRow:i inSection:0]];
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        
        if (self->ViewingAnalytics == YES) {
            
            self->ViewingAnalytics = NO;
            self->_viewItemitemDueDateLabel.alpha = 1.0f;
            self->_progressBarOne.alpha = 0.0f;
            self->_progressBarTwo.alpha = 0.0f;
            self->_percentageLabel.alpha = 0.0f;
            
        } else {
            
            self->ViewingAnalytics = YES;
            self->_viewItemitemDueDateLabel.alpha = 0.0f;
            self->_progressBarOne.alpha = 1.0f;
            self->_progressBarTwo.alpha = 1.0f;
            self->_percentageLabel.alpha = 1.0f;
            
        }
        
    } completion:^(BOOL finished) {
        
        [self.subTasksTableView beginUpdates];
        [self.subTasksTableView reloadRowsAtIndexPaths:indexPathSubTasksArray withRowAnimation:UITableViewRowAnimationFade];
        [self.subTasksTableView endUpdates];
        
        [self.customTableView beginUpdates];
        [self.customTableView reloadRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationFade];
        [self.customTableView endUpdates];
        
        [self SetUpItemViewContextMenu];
        
    }];
    
}

-(IBAction)TapGestureWaive:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Waive Clicked %@ For %@", _itemID, itemType] completionHandler:^(BOOL finished) {
        
    }];
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Are you sure you would like to waive this past due %@?", [itemType lowercaseString]] message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"Waive" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Waiving %@ For %@", self->_itemID, self->itemType] completionHandler:^(BOOL finished) {
            
        }];
        
        __block int totalQueries = 2;
        __block int completedQueries = 0;
        
//        [self StartProgressView];
        
        NSMutableArray *usersToSendNotificationTo = [self->itemAssignedToArray mutableCopy];
        
        NSArray *addTheseUsers = @[self->itemCreatedBy];
        NSArray *removeTheseUsers = @[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx"];
        
        usersToSendNotificationTo = [[[[NotificationsObject alloc] init] AddAndRemoveSpecificUsersFromArray:usersToSendNotificationTo addTheseUsers:addTheseUsers removeTheseUsers:removeTheseUsers] mutableCopy];
        
        
        
        NSString *notificationTitle = [NSString stringWithFormat:@"\"%@\"", self->itemName];
        NSString *notificationBody = [NSString stringWithFormat:@"%@ has waived a past due occurrence for this %@. 🙂", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"], [self->itemType lowercaseString]];
        
        NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
        
        NSString *notificationType = [[[NotificationsObject alloc] init] NotificationSettingsUnknownItemType_Adding:NO Editing:NO Deleting:NO Duplicating:NO Waiving:YES Skipping:NO Pausing:NO Comments:NO
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
                                                                                                           itemType:self->itemType];
        
        NSMutableDictionary *singleObjectItemDict = [[[GeneralObject alloc] init] GenerateSingleObjectDictionary:[self->itemDict mutableCopy] keyArray:[self->keyArray mutableCopy] indexPath:nil];
        
        
        
        //Remove Loading
        
        [self UpdateAllDataInViewController:nil dictToUse:[@{@"ItemOccurrenceStatus" : @"Waived"} mutableCopy]];
        
        [self DismissViewController:self];
        
        //
        
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [[[NotificationsObject alloc] init] SendPushNotificationToArrayOfUsers_Items:usersToSendNotificationTo
                                                                               dictToUse:singleObjectItemDict
                                                                                  homeID:homeID homeMembersArray:self->_homeMembersArray homeMembersDict:self->_homeMembersDict
                                                                notificationSettingsDict:self->_notificationSettingsDict notificationItemType:self->itemType notificationType:notificationType
                                                                               topicDict:self->_topicDict
                                                                     allItemTagsArrays:self->_allItemTagsArrays
                                                                   pushNotificationTitle:notificationTitle pushNotificationBody:notificationBody
                                                                       notificationTitle:notificationTitle notificationBody:notificationBody
                                                                 SetDataHomeNotification:YES
                                                                    RemoveUsersNotInHome:YES
                                                                       completionHandler:^(BOOL finished) {
                
                if (totalQueries == (completedQueries += 1)) {
                    
                    [self UpdateAllDataInViewController:nil dictToUse:[@{@"ItemOccurrenceStatus" : @"Waived"} mutableCopy]];
                    
                    [self DismissViewController:self];
                    
                }
                
            }];
            
        });
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [[[SetDataObject alloc] init] UpdateDataEditItem:@{@"ItemOccurrenceStatus" : @"Waived"} itemID:self->_itemID itemOccurrenceID:self->_itemOccurrenceID collection:self->itemTypeCollection homeID:self->homeID completionHandler:^(BOOL finished) {
                
                if (totalQueries == (completedQueries += 1)) {
                    
                    [self UpdateAllDataInViewController:nil dictToUse:[@{@"ItemOccurrenceStatus" : @"Waived"} mutableCopy]];
                    
                    [self DismissViewController:self];
                    
                }
                
            }];
            
        });
        
    }];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Waive Cancelled %@ For %@", self->_itemID, self->itemType] completionHandler:^(BOOL finished) {
            
        }];
        
    }]];
    
    [deleteAction setValue:[UIColor systemRedColor] forKey:@"titleTextColor"];
    
    [actionSheet addAction:deleteAction];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
    
}

-(IBAction)TapGesturePauseOrPlay:(id)sender {
    
    NSString *pauseOrPlay = (NSString *)sender;
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"%@ Selected %@ For %@", [(NSString *)sender isEqualToString:@"Paused"] ? @"Pause" : @"Unpause", _itemID , self->itemType] completionHandler:^(BOOL finished) {
        
    }];
    
//    [self StartProgressView];
    
    __block int completedQueries = 0;
    __block int totalQueries = 3;
    
    
    
    NSMutableDictionary *singleObjectItemDict = [[[GeneralObject alloc] init] GenerateSingleObjectDictionary:[self->itemDict mutableCopy] keyArray:[self->keyArray mutableCopy] indexPath:nil];
    
    
    
    NSString *notificationType = [[[NotificationsObject alloc] init] NotificationSettingsUnknownItemType_Adding:NO Editing:NO Deleting:NO Duplicating:NO Waiving:NO Skipping:NO Pausing:[[(NSString *)sender isEqualToString:@"Paused"] ? @"paused" : @"unpaused" isEqualToString:@"paused"] Comments:NO
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
                                                                                                       itemType:self->itemType];
    
    
    
    NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
    
    
    
    NSString *notificationTitle = [NSString stringWithFormat:@"\"%@\"", self->itemName];
    NSString *notificationBody = [NSString stringWithFormat:@"%@ has %@ the %@ \"%@\". %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"], [(NSString *)sender isEqualToString:@"Paused"] ? @"paused" : @"unpaused", [self->itemType lowercaseString], self->itemName, [(NSString *)sender isEqualToString:@"Paused"] ? @"⏸" : @"▶️"];
    
    
    
    NSMutableArray *usersToSendNotificationTo = [self->itemAssignedToArray mutableCopy];
    
    NSArray *addTheseUsers = @[self->itemCreatedBy];
    NSArray *removeTheseUsers = @[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx"];
    
    usersToSendNotificationTo = [[[[NotificationsObject alloc] init] AddAndRemoveSpecificUsersFromArray:usersToSendNotificationTo addTheseUsers:addTheseUsers removeTheseUsers:removeTheseUsers] mutableCopy];
    
    
    
    //Remove Loading
    
    [self UpdateAllDataInViewController:nil dictToUse:[@{@"ItemStatus" : pauseOrPlay} mutableCopy]];
    
    //
    
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[NotificationsObject alloc] init] SendPushNotificationToArrayOfUsers_Items:usersToSendNotificationTo
                                                                           dictToUse:singleObjectItemDict
                                                                              homeID:homeID homeMembersArray:self->_homeMembersArray homeMembersDict:self->_homeMembersDict
                                                            notificationSettingsDict:self->_notificationSettingsDict notificationItemType:self->itemType notificationType:notificationType
                                                                           topicDict:self->_topicDict
                                                                 allItemTagsArrays:self->_allItemTagsArrays
                                                               pushNotificationTitle:notificationTitle pushNotificationBody:notificationBody
                                                                   notificationTitle:notificationTitle notificationBody:notificationBody
                                                             SetDataHomeNotification:YES
                                                                RemoveUsersNotInHome:YES
                                                                   completionHandler:^(BOOL finished) {
            
            if (totalQueries == (completedQueries += 1)) {
                
                [self UpdateAllDataInViewController:nil dictToUse:[@{@"ItemStatus" : pauseOrPlay} mutableCopy]];
                
            }
            
        }];
        
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[SetDataObject alloc] init] UpdateDataEditItem:@{@"ItemStatus" : pauseOrPlay} itemID:self->_itemID itemOccurrenceID:self->_itemOccurrenceID collection:self->itemTypeCollection homeID:self->homeID completionHandler:^(BOOL finished) {
            
            if (totalQueries == (completedQueries += 1)) {
                
                [self UpdateAllDataInViewController:nil dictToUse:[@{@"ItemStatus" : pauseOrPlay} mutableCopy]];
                
            }
            
        }];
        
    });
    
    if (totalQueries == (completedQueries += 1)) {
        
        [self UpdateAllDataInViewController:nil dictToUse:[@{@"ItemStatus" : pauseOrPlay} mutableCopy]];
        
    }
    
}

-(IBAction)TapGestureSkip:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Skip Selected %@ For %@", _itemID , self->itemType] completionHandler:^(BOOL finished) {
        
    }];
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Are you sure you would like to skip to the next due date?"] message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"Skip" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Skipping %@ For %@", self->_itemID, self->itemType] completionHandler:^(BOOL finished) {
            
        }];
        
        
        
        [self StartProgressView];
        
        
        
        NSMutableDictionary *singleObjectItemDict = [self Skip_GenerateUpdatedSingleObjectDict];
        __block NSMutableDictionary *returningItemDict = [NSMutableDictionary dictionary];
        __block NSMutableDictionary *returningItemOccurrencesDict = [NSMutableDictionary dictionary];
        
        
        
        __block int totalQueries = 3;
        __block int completedQueries = 0;
        
        
        
        /*
         //
         //
         //Send Push Notifications
         //
         //
         */
        [self Skip_SendPushNotifications:singleObjectItemDict completionHandler:^(BOOL finished) {
            
            [self Skip_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) returningItemDict:returningItemDict returningItemOccurrencesDict:returningItemOccurrencesDict];
            
        }];
        
        
        /*
         //
         //
         //Reset Item Data
         //
         //
         */
        [self Skip_ResetItemData:singleObjectItemDict completionHandler:^(BOOL finished, NSMutableDictionary *returningItemDictLocal, NSMutableDictionary *returningItemOccurrencesDictLocal) {
            
            returningItemDict = [returningItemDictLocal mutableCopy];
            returningItemOccurrencesDict = [returningItemOccurrencesDictLocal mutableCopy];
            
            [self Skip_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) returningItemDict:returningItemDict returningItemOccurrencesDict:returningItemOccurrencesDict];
            
        }];
        
        
        /*
         //
         //
         //Update Item Data
         //
         //
         */
        [self Skip_UpdateItemData:singleObjectItemDict completionHandler:^(BOOL finished) {
            
            [self Skip_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) returningItemDict:returningItemDict returningItemOccurrencesDict:returningItemOccurrencesDict];
            
        }];
        
    }];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Skip Cancelled %@ For %@", self->_itemID, self->itemType] completionHandler:^(BOOL finished) {
            
        }];
        
    }]];
    
    [deleteAction setValue:[UIColor systemRedColor] forKey:@"titleTextColor"];
    
    [actionSheet addAction:deleteAction];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
    
}

-(IBAction)MoveTaskOutOfTrash:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Move Out of Trash Selected %@ For %@", _itemID , self->itemType] completionHandler:^(BOOL finished) {
        
    }];
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Are you sure you would like to move this %@ out of \"Trash\"?", [itemType lowercaseString]] message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"Move Out of Trash" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self StartProgressView];
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Moving Out of Trash Selected %@ For %@", self->_itemID , self->itemType] completionHandler:^(BOOL finished) {
            
        }];
        
        __block int totalQueries = 3;
        __block int completedQueries = 0;
        
        
        
        /*
         //
         //
         //Send Push Notifications
         //
         //
         */
        [self MoveToTrash_MoveOutOfTrash_SendPushNotifications:[self->itemDict mutableCopy] completionHandler:^(BOOL finished) {
            
            [self MoveOutOfTrash_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) MoveToTrash:NO];
            
        }];
        
        
        /*
         //
         //
         //Update Item Data
         //
         //
         */
        [self MoveToTrash_MoveOutOfTrash_UpdateItemData:self->_itemID itemOccurrenceID:self->_itemOccurrenceID MoveToTrash:NO completionHandler:^(BOOL finished) {
            
            [self MoveOutOfTrash_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) MoveToTrash:NO];
            
        }];
        
        
        /*
         //
         //
         //Set Item Silent Notifications
         //
         //
         */
        [self MoveToTrash_MoveOutOfTrash_SetItemSilentNotifications:[self->itemDict mutableCopy] MoveToTrash:NO completionHandler:^(BOOL finished) {
            
            [self MoveOutOfTrash_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) MoveToTrash:NO];
            
        }];
        
    }];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Move Out of Trash Cancelled %@ For %@", self->_itemID , self->itemType] completionHandler:^(BOOL finished) {
            
        }];
        
    }]];
    
    [actionSheet addAction:deleteAction];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
    
}

-(IBAction)MoveTaskToTrash:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Move To Trash Selected %@ For %@", _itemID, itemType] completionHandler:^(BOOL finished) {
        
    }];
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Are you sure you would like to move this %@ to \"Trash\"?", [itemType lowercaseString]] message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"Move To Trash" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self StartProgressView];
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Moving To Trash Selected %@ For %@", self->_itemID, self->itemType] completionHandler:^(BOOL finished) {
            
        }];
        
        __block int totalQueries = 3;
        __block int completedQueries = 0;
        
        
        
        /*
         //
         //
         //Send Push Notifications
         //
         //
         */
        [self MoveToTrash_MoveOutOfTrash_SendPushNotifications:[self->itemDict mutableCopy] completionHandler:^(BOOL finished) {
            
            [self MoveOutOfTrash_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) MoveToTrash:YES];
            
        }];
        
        
        /*
         //
         //
         //Update Item Data
         //
         //
         */
        [self MoveToTrash_MoveOutOfTrash_UpdateItemData:self->_itemID itemOccurrenceID:self->_itemOccurrenceID MoveToTrash:YES completionHandler:^(BOOL finished) {
            
            [self MoveOutOfTrash_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) MoveToTrash:YES];
            
        }];
        
        
        /*
         //
         //
         //Set Item Silent Notifications
         //
         //
         */
        [self MoveToTrash_MoveOutOfTrash_SetItemSilentNotifications:[self->itemDict mutableCopy] MoveToTrash:YES completionHandler:^(BOOL finished) {
            
            [self MoveOutOfTrash_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) MoveToTrash:YES];
            
        }];
        
    }];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Move To Trash Cancelled %@ For %@", self->_itemID, self->itemType] completionHandler:^(BOOL finished) {
            
        }];
        
    }]];
    
    [deleteAction setValue:[UIColor systemRedColor] forKey:@"titleTextColor"];
    
    [actionSheet addAction:deleteAction];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
    
}

-(IBAction)TapGestureActionReminder:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Reminder Clicked %@ For %@", _itemID, itemType] completionHandler:^(BOOL finished) {
        
    }];
    
    NSString *username = (NSString *)sender;
    
    BOOL TaskIsCompleteAsNeeded = [[[BoolDataObject alloc] init] TaskIsCompleteAsNeeded:self->itemDict itemType:itemType];
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Reminding %@ Clicked %@ For %@", username, _itemID, itemType] completionHandler:^(BOOL finished) {
        
    }];
    
    if ([itemAssignedUsernameArray containsObject:username]) {
        
        NSUInteger index = [itemAssignedUsernameArray indexOfObject:username];
        NSString *userID = itemAssignedToArray.count > index ? itemAssignedToArray[index] : @"";
        
        if (((([[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemCompletedDict userIDToFind:userID] == YES) && TaskIsCompleteAsNeeded == YES) ||
             ([[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemCompletedDict userIDToFind:userID] == NO)) &&
            [userID isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] == NO) {
            
            [self StartProgressView];
            
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                NSString *notificationTitle = [NSString stringWithFormat:@"\"%@\"", self->itemName];
                NSString *notificationBody = [NSString stringWithFormat:@"Here's a quick reminder to complete this %@. WeDivvy beleives in you! 😇", [self->itemType lowercaseString]];
                
                [[[NotificationsObject alloc] init] SendPushNotificationToArrayOfUsers_Items:[@[userID] mutableCopy]
                                                                                   dictToUse:self->itemDict
                                                                                      homeID:self->homeID homeMembersArray:self->_homeMembersArray homeMembersDict:self->_homeMembersDict
                                                                    notificationSettingsDict:self->_notificationSettingsDict notificationItemType:self->itemType notificationType:@""
                                                                                   topicDict:self->_topicDict
                                                                         allItemTagsArrays:self->_allItemTagsArrays
                                                                       pushNotificationTitle:notificationTitle pushNotificationBody:notificationBody
                                                                           notificationTitle:notificationTitle notificationBody:notificationBody
                                                                     SetDataHomeNotification:NO
                                                                        RemoveUsersNotInHome:YES
                                                                           completionHandler:^(BOOL finished) {
                    
                    [[[GeneralObject alloc] init] CreateAlert:@"Reminder Sent!" message:[NSString stringWithFormat:@"A reminder has been sent to %@", username] currentViewController:self];
                    
                    [self->progressView setHidden:YES];
                    
                }];
                
            });
            
        }
        
    }
    
}

- (IBAction)TapGestureActionPushToViewActivityViewController:(id)sender {
    
    if ([[[GeneralObject alloc] init] ConnectedToInternet] == NO) {
        [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You need to be connected to the internet to do that." currentViewController:self];
        return;
    }
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"View Activity Clicked %@ For %@", _itemID, itemType] completionHandler:^(BOOL finished) {
        
    }];
    
    [[[PushObject alloc] init] PushToViewActivityViewController:NO ViewingItem:YES itemID:self->_itemID homeMembersArray:_homeMembersArray homeMembersDict:_homeMembersDict notificationSettingsDict:_notificationSettingsDict topicDict:_topicDict folderDict:_folderDict taskListDict:_taskListDict templateDict:_templateDict draftDict:_draftDict itemNamesAlreadyUsed:_itemNamesAlreadyUsed allItemAssignedToArrays:_allItemAssignedToArrays allItemTagsArrays:_allItemTagsArrays allItemIDsArrays:_allItemIDsArrays currentViewController:self];
    
}

- (IBAction)TapGestureActionPushToLiveChatViewController:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Comment Clicked %@ For %@", _itemID, itemType] completionHandler:^(BOOL finished) {
        
    }];
    
    NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
    
    [[[PushObject alloc] init] PushToLiveChatViewControllerFromViewTaskPage:homeID itemID:self->_itemID itemName:self->itemName itemCreatedBy:self->itemCreatedBy itemAssignedTo:self->itemAssignedToArray homeMembersDict:self->_homeMembersDict notificationSettingsDict:self->_notificationSettingsDict topicDict:self->_topicDict currentViewController:self Superficial:NO];
    
}

-(IBAction)TapGestureActionPushToAddTaskViewController:(id)sender {
    
    NSString *itemType = [[[GeneralObject alloc] init] GenerateItemType];
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"%@ Task Clicked %@ For %@", (NSString *)sender, _itemID, itemType] completionHandler:^(BOOL finished) {
        
    }];
    
    NSMutableDictionary *itemToEditDict = [NSMutableDictionary dictionary];
    
    for (NSString *key in keyArray) {
        
        id object = self->itemDict[key] ? self->itemDict[key] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
        [itemToEditDict setObject:object forKey:key];
        
    }
   
    NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
    
    [[[PushObject alloc] init] PushToAddTaskViewController:itemToEditDict partiallyAddedDict:nil suggestedItemToAddDict:nil templateToEditDict:nil draftToEditDict:nil moreOptionsDict:nil multiAddDict:nil notificationSettingsDict:self->_notificationSettingsDict topicDict:self->_topicDict homeID:homeID homeMembersArray:_homeMembersArray homeMembersDict:_homeMembersDict itemOccurrencesDict:self->itemxxxOccurrencesDict folderDict:_folderDict taskListDict:_taskListDict templateDict:_templateDict draftDict:_draftDict allItemAssignedToArrays:_allItemAssignedToArrays allItemTagsArrays:self->_allItemTagsArrays allItemIDsArrays:nil defaultTaskListName:self->topViewLabel.text partiallyAddedTask:NO addingTask:NO addingMultipleTasks:NO addingSuggestedTask:NO editingTask:YES viewingTask:NO viewingMoreOptions:NO duplicatingTask:duplicateItemDetails editingTemplate:NO viewingTemplate:NO editingDraft:NO viewingDraft:NO currentViewController:self Superficial:NO];
    
}

-(IBAction)TapGestureSelectTag:(id)sender {
    
    UIButton *buttonSender = (UIButton *)sender;
    NSString *itemTag = buttonSender.titleLabel.text;
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Clicked Tag %@ For %@", itemTag, [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    [[NSUserDefaults standardUserDefaults] setObject:itemTag forKey:@"CategorySelected"];
    
    [[[GeneralObject alloc] init] CallNSNotificationMethods:@"SelectTag" userInfo:@{@"ItemTag" : itemTag} locations:@[@"Tasks"]];
    
    [self DismissViewController:self];
    
}

-(IBAction)TapGestureDeleteTrashPermanently:(id)sender {
    
    [self StartProgressView];
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Delete Trash Selected For Tasks %@ For %@", _itemID , self->itemType] completionHandler:^(BOOL finished) {
        
    }];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"StopDoneActionReloadTableView"];
    
    
    
    NSMutableDictionary *singleObjectItemDict = [[[GeneralObject alloc] init] GenerateSingleObjectDictionary:self->itemDict keyArray:keyArray indexPath:nil];
    
    [self DeleteTrashPermanently_DeleteItemData:singleObjectItemDict completionHandler:^(BOOL finished) {
        
        [self DeleteTrashPermanently_FinishBlock];
        
    }];
    
}

-(IBAction)DisplaySubtaskOrListItemOptions:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Subtask Or List Item Options Clicked %@ For %@", _itemID, itemType] completionHandler:^(BOOL finished) {
        
    }];
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self->_customTableView];
    NSIndexPath *indexPath = [self->_customTableView indexPathForRowAtPoint:buttonPosition];
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *editAction = [UIAlertAction actionWithTitle:@"Edit" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Subtask Or List Item Edit Option Clicked %@ For %@", self->_itemID, self->itemType] completionHandler:^(BOOL finished) {
            
        }];
        
        if (self->ListItemsVisible == YES) {
            
            [self EditListItemItemTypeList:sender];
            
        } else {
            
            [self EditSubtask:sender];
            
        }
        
    }];
    
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Subtask Or List Item Delete Option Clicked %@ For %@", self->_itemID, self->itemType] completionHandler:^(BOOL finished) {
            
        }];
        
        if (self->ListItemsVisible == YES) {
            
            [self DeleteListItemItemTypeList:sender];
            
        } else {
            
            [self DeleteSubtask:sender];
            
        }
        
    }];
    
    if (ListItemsVisible == YES) {
        
        NSString *listItem = [self GenerateDataForSpeificItemAtIndex:indexPath];
        
        BOOL ListItemIsCompleted = [[[BoolDataObject alloc] init] ListItemIsCompleted:self->itemDict itemType:itemType listItem:listItem];
        BOOL ListItemIsInProgress = [[[BoolDataObject alloc] init] ListItemIsInProgress:self->itemDict itemType:itemType listItem:listItem];
        BOOL ListItemIsWontDo = [[[BoolDataObject alloc] init] ListItemIsWontDo:self->itemDict itemType:itemType listItem:listItem];
        
        if (ListItemIsCompleted == NO && ListItemIsInProgress == NO && ListItemIsWontDo == NO) {
            
            [actionSheet addAction:editAction];
            
        }
        
    } else {
        
        CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self->_subTasksTableView];
        NSIndexPath *indexPath = [self->_subTasksTableView indexPathForRowAtPoint:buttonPosition];
        
        NSString *subtask = itemSubTasksDict && [[itemSubTasksDict allKeys] count] ? [itemSubTasksDict allKeys][indexPath.row] : @"";
        
        BOOL SubtaskIsCompleted = [[[BoolDataObject alloc] init] SubtaskIsCompleted:self->itemDict itemType:itemType subtask:subtask];
        BOOL SubtaskIsInProgress = [[[BoolDataObject alloc] init] SubtaskIsInProgress:self->itemDict itemType:itemType subtask:subtask];
        BOOL SubtaskIsWontDo = [[[BoolDataObject alloc] init] SubtaskIsWontDo:self->itemDict itemType:itemType subtask:subtask];
        
        if (SubtaskIsCompleted == NO && SubtaskIsInProgress == NO && SubtaskIsWontDo == NO) {
            
            [actionSheet addAction:editAction];
            
        }
        
    }
    
    [actionSheet addAction:deleteAction];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Subtask Or List Item Options Cancelled %@ For %@", self->_itemID, self->itemType] completionHandler:^(BOOL finished) {
            
        }];
        
    }]];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
    
}

#pragma mark - Table View Methods

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    ViewTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ViewTaskCell"];
    
    BOOL TaskIsCompleteAsNeeded = [[[BoolDataObject alloc] init] TaskIsCompleteAsNeeded:self->itemDict itemType:itemType];
    
    if (tableView == _customTableView) {
        
        cell.userAlertLabel.hidden = YES;
        cell.userAlertImage.hidden = YES;
        
        if (ListItemsVisible == YES) {
            
            NSString *listItem = [self GenerateDataForSpeificItemAtIndex:indexPath];
            
            cell.titleLabel.text = listItem;
            cell.subLabel.text = TaskIsCompleteAsNeeded == NO ?
            [self GenerateItemCompletedTextListItemCell:indexPath] :
            [self GenerateItemCompletedTextListItemCompleteAsNeeded:indexPath];
            
        } else if (ItemizedItemsVisible == YES) {
            
            NSString *itemizedItem = [self GenerateDataForSpeificItemAtIndex:indexPath];
            
            cell.titleLabel.text = itemizedItem;
            cell.subLabel.text = TaskIsCompleteAsNeeded == NO ?
            [self GenerateItemCompletedTextItemizedItemCell:indexPath] :
            [self GenerateItemCompletedTextItemizedItemCompleteAsNeeded:indexPath];
            
        } else {
            
            //Post-Spike
            NSMutableDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:itemAssignedToArray[indexPath.row] homeMembersDict:_homeMembersDict];
            
            cell.titleLabel.text = dataDict[@"Username"];
            
            cell.subLabel.text = TaskIsCompleteAsNeeded == YES ?
            [self GenerateItemCompletedTextUserCellItemCompleteAsNeeded:indexPath] :
            [self GenerateItemCompletedTextUserCell:indexPath];
            
            [self GenerateItemAssignedToImage:cell.profileImage indexPath:indexPath];

            [self GenerateUserAlertLabelAndImage:indexPath cell:cell];
            
            cell.percentageLabel.text = [self GenerateCompletionRatePercentageText:totalCompletedArray indexPath:indexPath];
            
        }
        
        return cell;
        
    } else if (tableView == _subTasksTableView) {
        
        cell.titleLabel.text = [[itemSubTasksDict allKeys] count] > indexPath.row ? [itemSubTasksDict allKeys][indexPath.row] : @"";
        cell.subLabel.text = TaskIsCompleteAsNeeded == NO ?
        [self GenerateItemCompletedTextSubtaskCell:indexPath] :
        [self GenerateItemCompletedTextSubtaskCellItemCompleteAsNeeded:indexPath];
        cell.percentageLabel.text = [self GenerateCompletionRatePercentageText:totalCompletedSubTaskArray indexPath:indexPath];
        
        return cell;
        
    }
    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == _subTasksTableView) {
        
        return [[itemSubTasksDict allKeys] count];
        
    } else if (tableView == _customTableView) {
        
        if (ListItemsVisible == YES) {
            
            int lowestNumber = 10000;
            
            if ([itemListItems count]/*[itemListSectionsArray count]*/ > section) {
                
                if (lowestNumber > [[itemListItems/*itemListSectionsArray[section]*/ allKeys] count]) {
                    
                    lowestNumber = (int)[[itemListItems/*itemListSectionsArray[section]*/ allKeys] count];
                    
                }
                
            }
            
            if (lowestNumber == 10000) {
                lowestNumber = 0;
            }
            
            return lowestNumber;
            
        } else if (ItemizedItemsVisible == YES) {
            
            int lowestNumber = 10000;
            
            if ([itemItemizedItems/*itemItemizedSectionsArray*/ count] > section) {
                
                if (lowestNumber > [[itemItemizedItems/*itemItemizedSectionsArray[section]*/ allKeys] count]) {
                    
                    lowestNumber = (int)[[itemItemizedItems/*itemItemizedSectionsArray[section]*/ allKeys] count];
                    
                }
                
            }
            
            if (lowestNumber == 10000) {
                lowestNumber = 0;
            }
            
            return lowestNumber;
            
        } else {
            
            return itemAssignedToArray.count;
            
        }
        
    }
    
    return 0;
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(ViewTaskCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == _subTasksTableView) {
        
        [self SubtaskCellFrames:tableView cell:cell indexPath:indexPath];
        
    } else if (tableView == _customTableView) {
        
        if (ListItemsVisible == YES) {
            
            [self ListCellFrame:tableView cell:cell indexPath:indexPath];
            
        } else if (ItemizedItemsVisible == YES) {
            
            [self ItemizedCellFrame:tableView cell:cell indexPath:indexPath];
            
        } else {
            
            [self ChoreCellFrame:tableView cell:cell indexPath:indexPath];
            
        }
        
    }
    
    BOOL ViewingNonUserItems = ((tableView == _subTasksTableView && [itemType isEqualToString:@"Chore"]) || NonUserCellsVisible == YES);
    BOOL ViewingUserItems = ((tableView == _customTableView) && UserCellsVisible == YES);
    
    if (ViewingNonUserItems == YES) {
        
        [self SetUpNonUserItemContextMenu:indexPath cell:cell tableView:tableView];
        
    } else if (ViewingUserItems == YES) {
        
        [self SetUpUserItemContextMenu:indexPath cell:cell];
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Did Select Main Table View Item For %@", itemType] completionHandler:^(BOOL finished) {
        
    }];
    
    if ([itemTrash isEqualToString:@"No"]) {
        
        if (tableView == _customTableView) {
            
            if (UserCellsVisible == YES) {
                
                [self DidSelectUserCell:indexPath];
                
            } else if (ListItemsVisible == YES) {
                
                [self DidSelectListItemCell:indexPath];
                
            } else if (ItemizedItemsVisible == YES) {
                
                [self DidSelectItemizedItemCell:indexPath];
                
            }
            
        } else if (tableView == _subTasksTableView) {
            
            [self DidSelectSubTaskCell:indexPath];
            
        }
        
    } else {
        
        [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:[NSString stringWithFormat:@"To perform this action you must move this %@ out of the trash", [itemType lowercaseString]] currentViewController:self];
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == _customTableView && UserCellsVisible == YES) {
        
        int cellHeight = [self GenerateViewTaskCellHeight:indexPath];
        
        return cellHeight;
        
    }
    
    int cellHeight = [self GenerateViewTaskCellHeightNo1];
   
    return cellHeight;
    
}

#pragma mark

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 0)];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger )section {
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger )section {
    return 0.0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return nil;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (tableView == _customTableView && NonUserCellsVisible == YES) {
        
        return [sectionsArray count];
        
    }
    
    return 1;
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

#pragma mark General

-(void)UpdateAllDataInViewController:(NSIndexPath * _Nullable)indexPath dictToUse:(NSMutableDictionary *)dictToUse {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
       
        
        for (NSString *key in [dictToUse allKeys]) {
            
            id object = dictToUse[key] ? dictToUse[key] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
            [self->itemDict setObject:object forKey:key];
            
        }
       
        [self SetDataGeneral:self->itemDict];
        
        
     
        
        [self GenerateWriteTaskHiddenStatus];
        
        [self GeneratePaymentMethodViewHiddenStatus];
        
        [self GenerateRewardViewHiddenStatus];
        
        [self SetUpItemViewContextMenu];
        
        [self SetUpItemPaymentMethodContextMenu];
        
        [self SetUpItemRewardContextMenu];
        
        
        
        
        if (indexPath != nil) {
            
            NSString *myUserID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
            
            BOOL TaskCompletedBySpecificUser = [[[BoolDataObject alloc] init] TaskCompletedBySpecificUser:self->itemDict itemType:self->itemType userID:myUserID];
            BOOL SpecificUserIsMe = [[[BoolDataObject alloc] init] SpecificUserIsMe:myUserID];
            
            if (TaskCompletedBySpecificUser == YES && SpecificUserIsMe == YES) {
                
                [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"DisplayRegisterForNotificationsPopup"];
                
            }
            
        } else {
            
            self->_writeTaskTextField.text = @"";
            self->_writeAssignedToTaskTextField.text = @"";
            [self->_writeTaskTextField resignFirstResponder];
            [self->_writeAssignedToTaskTextField resignFirstResponder];
            
        }
        
        
        
        
        NSMutableDictionary *setDataDict = [[[GeneralObject alloc] init] GenerateSingleObjectDictionary:self->itemDict keyArray:self->keyArray indexPath:nil];
        
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"EditTask" userInfo:setDataDict locations:@[@"Tasks", @"Calendar"]];
        
        
        
        
//        [self GenerateSectionDictionary];
        [self CalculateItemProgressBarWidth];
        [self AdjustScrollViewFrames];
        
        [self.customTableView reloadData];
        [self.subTasksTableView reloadData];
        
        [self->progressView setHidden:YES];
        
        
        
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TaskCompletedForSomeoneElse"];
        
        
        
        
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"ResetViewTask"]) {
            
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ResetViewTask"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self DismissViewController:self];
                
            });
            
        }
        
        
        
        
        [[[GeneralObject alloc] init] AppStoreRating:^(BOOL finished) {
            
            self->alertView = [[AlertView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) viewControllerWidth:self.view.frame.size.width viewControllerHeight:self.view.frame.size.height text:[NSString stringWithFormat:@"Enjoying WeDivvy?\n\nYour review keeps our small team motivated! 😊"] acceptButtonSelector:@selector(RequestAppReviewAccepted:) declineButtonSelector:@selector(RequestAppReviewRejected:) viewControllerObject:[[ViewTaskViewController alloc] init]];
            self->alertView.alpha = 0.0f;
            [self.view addSubview:self->alertView];
            
            [UIView animateWithDuration:0.25 animations:^{
                self->alertView.alpha = 1.0f;
            }];
            
        }];
        
        
        
        
    });
    
}

#pragma mark - QueryInitialData Methods

-(void)GetDataItem:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
        
        [[[GetDataObject alloc] init] GetDataItem:self->_itemID itemOccurrenceID:self->_itemOccurrenceID collection:self->itemTypeCollection homeID:homeID keyArray:self->keyArray completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningDataDict) {
            
            if (returningDataDict[@"ItemID"] == NULL) {
                
                UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Oops" message:[NSString stringWithFormat:@"This %@ has been deleted", [self->itemType lowercaseString]]
                                                                             preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Got it"
                                                                 style:UIAlertActionStyleCancel
                                                               handler:^(UIAlertAction * _Nonnull action) {
                    
                    [self DismissViewController:self];
                    [self->progressView setHidden:YES];
                    
                }];
                
                [controller addAction:cancel];
                [self presentViewController:controller animated:YES completion:nil];
                
            } else {
                
                self->itemDict = [returningDataDict mutableCopy];
                
                finishBlock(YES);
                
            }
            
        }];
        
    });
    
}

-(void)GetDataItemOccurrences:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
        
        [[[GetDataObject alloc] init] GetDataItemOccurrencesForSingleItem:self->itemTypeCollection itemID:self->_itemID homeID:homeID keyArray:self->keyArray completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningOccurrencesDict) {
            
            self->itemxxxOccurrencesDict = [returningOccurrencesDict mutableCopy];
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)GetDataUserData:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        BOOL HomeMemberDictIsNotValid =
        (!self->_homeMembersDict ||
         !self->_homeMembersDict[@"UserID"] ||
         (self->_homeMembersDict[@"UserID"] && [(NSArray *)self->_homeMembersDict[@"UserID"] count] == 0));
        
        if (HomeMemberDictIsNotValid == YES) {
            
            self->_homeMembersDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeMembersDict"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"HomeMembersDict"] mutableCopy] : [NSMutableDictionary dictionary];
            
            HomeMemberDictIsNotValid =
            (!self->_homeMembersDict ||
             !self->_homeMembersDict[@"UserID"] ||
             (self->_homeMembersDict[@"UserID"] && [(NSArray *)self->_homeMembersDict[@"UserID"] count] == 0));
            
        }
        
        if (HomeMemberDictIsNotValid == YES) {
            
            [[[GetDataObject alloc] init] GetDataUserDataArray:self->_homeMembersArray completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningUserDict) {
                
                self->_homeMembersDict = [returningUserDict mutableCopy];
                
                finishBlock(YES);
                
            }];
            
        } else {
            
            finishBlock(YES);
            
        }
        
    });
    
}

-(void)GetDataNotificationSettings:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        BOOL NotificationSettingsDictIsNotValid = ([[self->_notificationSettingsDict allKeys] count] == 0);
        
        if (NotificationSettingsDictIsNotValid == YES) {
            
            self->_notificationSettingsDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"NotificationSettingsDict"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"NotificationSettingsDict"] mutableCopy] : [NSMutableDictionary dictionary];
            
            NotificationSettingsDictIsNotValid = ([[self->_notificationSettingsDict allKeys] count] == 0);
            
        }
        
        if (NotificationSettingsDictIsNotValid == YES) {
            
            [[[GetDataObject alloc] init] GetDataUserNotificationSettingsData:self->_homeMembersArray completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningNotificationSettingsDict) {
                
                self->_notificationSettingsDict = [returningNotificationSettingsDict mutableCopy];
                
                finishBlock(YES);
                
            }];
            
        } else {
            
            finishBlock(YES);
            
        }
        
    });
    
}

-(void)GetDataTaskLists:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        BOOL TaskListDictIsNotValid = ([(NSArray *)self->_taskListDict[@"TaskListID"] count] == 0);
        
        if (TaskListDictIsNotValid == YES) {
            
            self->_taskListDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskListDict"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"TaskListDict"] mutableCopy] : [NSMutableDictionary dictionary];
            
            TaskListDictIsNotValid = ([(NSArray *)self->_taskListDict[@"TaskListID"] count] == 0);
            
        }
        
        if (TaskListDictIsNotValid == YES) {
           
            NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
            
            NSArray *keyArray = [[[GeneralObject alloc] init] GenerateTaskListKeyArray];
            
            [[[GetDataObject alloc] init] GetDataTaskLists:keyArray userID:userID completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningDataDict) {
                
                self->_taskListDict = [returningDataDict mutableCopy];
                
                finishBlock(YES);
                
            }];
            
        } else {
            
            finishBlock(YES);
            
        }
        
    });
    
}

-(void)GetDataFolders:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        BOOL FolderDictIsNotValid = ([(NSArray *)self->_folderDict[@"FolderID"] count] == 0);
        
        if (FolderDictIsNotValid == YES) {
            
            self->_folderDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"FolderDict"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"FolderDict"] mutableCopy] : [NSMutableDictionary dictionary];
            
            FolderDictIsNotValid = ([(NSArray *)self->_folderDict[@"FolderID"] count] == 0);
            
        }
        
        if (FolderDictIsNotValid == YES) {
            
            NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
            
            NSArray *keyArray = [[[GeneralObject alloc] init] GenerateFolderKeyArray];
            
            [[[GetDataObject alloc] init] GetDataFolders:keyArray userID:userID completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningDataDict) {
                
                self->_folderDict = [returningDataDict mutableCopy];
                
                finishBlock(YES);
                
            }];
            
        } else {
            
            finishBlock(YES);
            
        }
        
    });
    
}

-(void)GetDataSections:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        BOOL FolderDictIsNotValid = ([(NSArray *)self->_sectionDict[@"SectionID"] count] == 0);
        
        if (FolderDictIsNotValid == YES) {
            
            self->_sectionDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"SectionDict"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"SectionDict"] mutableCopy] : [NSMutableDictionary dictionary];
            
            FolderDictIsNotValid = ([(NSArray *)self->_sectionDict[@"SectionID"] count] == 0);
            
        }
        
        if (FolderDictIsNotValid == YES) {
            
            NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
            
            NSArray *keyArray = [[[GeneralObject alloc] init] GenerateSectionKeyArray];
            
            [[[GetDataObject alloc] init] GetDataSections:keyArray userID:userID completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningDataDict) {
                
                self->_sectionDict = [returningDataDict mutableCopy];
                
                finishBlock(YES);
                
            }];
            
        } else {
            
            finishBlock(YES);
            
        }
        
    });
    
}

#pragma mark - GenerateLastComment Methods

-(void)GenerateLastCommentFrames:(NSMutableDictionary *)lastMessageDict messageKeyArray:(NSArray *)messageKeyArray {
    
    BOOL AtLeastOneCommentExists = lastMessageDict[@"MessageID"] && [lastMessageDict[@"MessageID"] length] > 0;
    
    if (AtLeastOneCommentExists == YES) {
        
        self->_lastCommentView.hidden = NO;
        self->_lastCommentNoCommentView.hidden = YES;
        
        NSMutableDictionary *specificUserDataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:lastMessageDict[@"MessageSentBy"] homeMembersDict:self->_homeMembersDict];
        
        NSString *messageSentByUsername = specificUserDataDict[@"Username"];
        NSString *messageSentByProfileImageURL = specificUserDataDict[@"ProfileImageURL"];
        NSString *messageTimeStampConverted = [[[GeneralObject alloc] init] GetDisplayTimeSinceDate:lastMessageDict[@"MessageTimeStamp"] shortStyle:NO reallyShortStyle:NO];
        
        [self->_lastCommentViewProfileImage sd_setImageWithURL:[NSURL URLWithString:messageSentByProfileImageURL] placeholderImage:[UIImage imageNamed:@"DefaultIcons.DefaultProfileImage.png"]];
        self->_lastCommentViewNameLabel.text = messageSentByUsername;
        self->_lastCommentViewTextLabel.text = lastMessageDict[@"MessageText"];
        self->_lastCommentViewTimeLabel.text = messageTimeStampConverted;
        
        self->_lastCommentViewProfileImage.clipsToBounds = YES;
        self->_lastCommentViewProfileImage.layer.cornerRadius = self->_lastCommentViewProfileImage.frame.size.height/2;
        self->_lastCommentViewProfileImage.contentMode = UIViewContentModeScaleAspectFill;
        
        NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
        BOOL MessageSentByMe = [lastMessageDict[@"MessageSentBy"] isEqualToString:userID];
        
        CGFloat lastCommentWidth = [[[GeneralObject alloc] init] WidthOfString:self->_lastCommentViewTextLabel.text withFont:self->_lastCommentViewTextLabel.font];
        CGFloat lastNameWidth = [[[GeneralObject alloc] init] WidthOfString:self->_lastCommentViewNameLabel.text withFont:self->_lastCommentViewNameLabel.font];
        CGFloat lastTimeWidth = [[[GeneralObject alloc] init] WidthOfString:self->_lastCommentViewTimeLabel.text withFont:self->_lastCommentViewTimeLabel.font];
        CGFloat xSpace = self.view.frame.size.width*0.01932367;
        
        CGRect newRect = self->_lastCommentViewTextLabel.frame;
        newRect.origin.x = xSpace;
        newRect.origin.y = self->_lastCommentViewTextView.frame.size.height*0.5 - newRect.size.height*0.5;
        newRect.size.width = lastCommentWidth + xSpace*2 > self.view.frame.size.width - (xSpace*3 + self->_lastCommentViewProfileImage.frame.size.width) ? self.view.frame.size.width - (xSpace*3 + self->_lastCommentViewProfileImage.frame.size.width) : lastCommentWidth + xSpace*2;
        self->_lastCommentViewTextLabel.frame = newRect;
        
        newRect = self->_lastCommentViewTextView.frame;
        newRect.size.width = self->_lastCommentViewTextLabel.frame.size.width;
        newRect.origin.x = MessageSentByMe == YES ? self.view.frame.size.width - newRect.size.width - self->_lastCommentViewProfileImage.frame.size.width - (xSpace*2) : self->_lastCommentViewNameLabel.frame.origin.x;
        self->_lastCommentViewTextView.frame = newRect;
        
        newRect = self->_lastCommentViewProfileImage.frame;
        newRect.origin.x = MessageSentByMe == YES ? self.view.frame.size.width - newRect.size.width - xSpace : xSpace;
        self->_lastCommentViewProfileImage.frame = newRect;
        
        newRect = self->_lastCommentViewNameLabel.frame;
        newRect.size.width = lastNameWidth;
        newRect.origin.x = MessageSentByMe == YES ? self->_lastCommentViewProfileImage.frame.origin.x - newRect.size.width - xSpace : self->_lastCommentViewProfileImage.frame.origin.x + self->_lastCommentViewProfileImage.frame.size.width + xSpace;
        self->_lastCommentViewNameLabel.frame = newRect;
        
        newRect = self->_lastCommentPremiumImage.frame;
        newRect.origin.x = MessageSentByMe == YES ? self->_lastCommentViewNameLabel.frame.origin.x - self->_lastCommentViewNameLabel.frame.size.height*0.7 - 6 : self->_lastCommentViewNameLabel.frame.origin.x + self->_lastCommentViewNameLabel.frame.size.width + 6;
        self->_lastCommentPremiumImage.frame = newRect;
        
        newRect = self->_lastCommentViewTimeLabel.frame;
        newRect.size.width = lastTimeWidth;
        newRect.origin.x = MessageSentByMe == YES ? xSpace : self.view.frame.size.width - newRect.size.width - xSpace;
        self->_lastCommentViewTimeLabel.frame = newRect;
        
        if (MessageSentByMe == YES) {
            
            self->_lastCommentViewTextView.backgroundColor = [UIColor colorWithRed:42.0f/255.0f green:171.0f/255.0f blue:250.0f/255.0f alpha:1.0f];
            self->_lastCommentViewTextLabel.textColor = [UIColor whiteColor];
            self->_lastCommentViewTextLabel.textAlignment = NSTextAlignmentLeft;
            
            self->_lastCommentViewNameLabel.textAlignment = NSTextAlignmentRight;
            self->_lastCommentViewTimeLabel.textAlignment = NSTextAlignmentLeft;
            
        } else {
            
            self->_lastCommentViewTextView.backgroundColor = [UIColor colorWithRed:235.0f/255.0f green:237.0f/255.0f blue:242.0f/255.0f alpha:1.0f];
            self->_lastCommentViewTextLabel.textColor = [UIColor blackColor];
            self->_lastCommentViewTextLabel.textAlignment = NSTextAlignmentLeft;
            
            self->_lastCommentViewNameLabel.textAlignment = NSTextAlignmentLeft;
            self->_lastCommentViewTimeLabel.textAlignment = NSTextAlignmentRight;
            
        }
        
        NSUInteger index = self->_homeMembersDict && self->_homeMembersDict[@"UserID"] && [self->_homeMembersDict[@"UserID"] containsObject:lastMessageDict[@"MessageSentBy"]] ? [self->_homeMembersDict[@"UserID"] indexOfObject:lastMessageDict[@"MessageSentBy"]] : -1;
        
        BOOL PremiumSubscriptionIsActiveForSpecificUserAtIndex = [[[BoolDataObject alloc] init] PremiumSubscriptionIsActiveForSpecificUserAtIndex:self->_homeMembersDict userID:lastMessageDict[@"MessageSentBy"]];
        
        self->_lastCommentPremiumImage.hidden = PremiumSubscriptionIsActiveForSpecificUserAtIndex && index != -1 ? NO : YES;
        
    } else {
        
        self->_lastCommentView.hidden = YES;
        self->_lastCommentNoCommentView.hidden = NO;
        
    }
    
}

#pragma mark - UX Methods

-(NSString *)GenerateDueDateInReadableFormat:(NSDate *)itemDueDateInDateForm {
    
    BOOL TaskIsRepeatingHourly = [[[BoolDataObject alloc] init] TaskIsRepeatingHourly:self->itemDict itemType:itemType];
    
    
    
    NSString *itemitemDueDateLabelText = [NSString stringWithFormat:@"%@", self->itemDueDate];
    
    if ([self->itemTime isEqualToString:@"Any Time"] && [itemitemDueDateLabelText containsString:@"11:59 PM"]) {
        
        itemitemDueDateLabelText = [[[GeneralObject alloc] init] GenerateStringWithReplacementString:itemitemDueDateLabelText stringToReplace:@"11:59 PM" replacementString:@"Any Time"];
        
    }
    
    
    
    NSDateFormatter *dateFormatter = nil;
    
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE"];
    
    NSString *weekDay = [dateFormatter stringFromDate:itemDueDateInDateForm];
    
    
    
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMMM"];
    
    NSString *month = [dateFormatter stringFromDate:itemDueDateInDateForm];
    
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YY"];
    
    NSString *year = [dateFormatter stringFromDate:itemDueDateInDateForm];
    
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"d"];
    
    NSString *day = [dateFormatter stringFromDate:itemDueDateInDateForm];
    
    if ([day isEqualToString:@"1"] || [day isEqualToString:@"21"] || [day isEqualToString:@"31"]) {
        day = [NSString stringWithFormat:@"%@st", day];
    } else if ([day isEqualToString:@"2"] || [day isEqualToString:@"22"]) {
        day = [NSString stringWithFormat:@"%@nd", day];
    } else if ([day isEqualToString:@"3"] || [day isEqualToString:@"23"]) {
        day = [NSString stringWithFormat:@"%@rd", day];
    } else {
        day = [NSString stringWithFormat:@"%@th", day];
    }
    
    
    
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"h"];
    
    NSString *hour = [dateFormatter stringFromDate:itemDueDateInDateForm];
    
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"mm"];
    
    NSString *minute = [dateFormatter stringFromDate:itemDueDateInDateForm];
    
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"a"];
    
    NSString *AMPM = [dateFormatter stringFromDate:itemDueDateInDateForm];
    
    
    
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YY"];
    
    NSString *currentYear = [dateFormatter stringFromDate:[NSDate date]];
    
    year = [currentYear intValue] != [year intValue] ? [NSString stringWithFormat:@", %@'", year] : @"";
    
    
    
    NSString *at = [self->itemTime isEqualToString:@"Any Time"] && TaskIsRepeatingHourly == NO ? @", " : @" at ";
    
    NSString *timeToUse = [self->itemTime isEqualToString:@"Any Time"] && TaskIsRepeatingHourly == NO ? @"Any Time" : [NSString stringWithFormat:@"%@:%@ %@", hour, minute, AMPM];
    
    itemitemDueDateLabelText = [NSString stringWithFormat:@"Due %@., %@ %@%@%@", weekDay, month, day, at, timeToUse];
    
    return itemitemDueDateLabelText;
}

-(NSString *)GenerateDueDateIfScheduledToStart:(NSString *)itemitemDueDateLabelText {
    
    BOOL TaskIsScheduledStart = [[[BoolDataObject alloc] init] TaskIsScheduledStart:[@{@"ItemScheduledStart" : self->itemScheduledStart} mutableCopy] itemType:self->itemType];
    BOOL TaskIsScheduledStartHasPassed = [[[BoolDataObject alloc] init] TaskIsScheduledStartHasPassed:[@{@"ItemScheduledStart" : self->itemScheduledStart} mutableCopy] itemType:self->itemType];
    
    if (TaskIsScheduledStart == YES && TaskIsScheduledStartHasPassed == NO) {
        
        NSString *itemDatePosted = [[[GeneralObject alloc] init] GenerateDateWithConvertedFormatWithFormat:@"yyyy-MM-dd HH:mm:ss" dateToConvert:self->itemDatePosted newFormat:@"MMMM dd, yyyy hh:mm a" returnAs:[NSString class]];
        
        NSString *left = [[[GeneralObject alloc] init] GenerateDisplayTimeUntilDisplayTimeStartingFromCustomStartDate:self->itemScheduledStart itemDueDate:itemDatePosted shortStyle:NO reallyShortStyle:NO];
        
        left = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:left arrayOfSymbols:@[@" left"]];
        
        itemitemDueDateLabelText = [NSString stringWithFormat:@"Scheduled to begin in %@", left];
        
    }
    
    return itemitemDueDateLabelText;
}

-(NSString *)GenerateDueDateIfPaused:(NSString *)itemitemDueDateLabelText {
    
    if ([self->itemStatus isEqualToString:@"Paused"]) {
        itemitemDueDateLabelText = @"Paused";
    }
    
    return itemitemDueDateLabelText;
}

-(NSString *)GenerateCompletedLabelItemCompleteAsNeeded:(NSMutableDictionary *)singleObjectItemDict {
    
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
    
    NSMutableDictionary *itemCompletedDict = singleObjectItemDict[@"ItemCompletedDict"] ? [singleObjectItemDict[@"ItemCompletedDict"] mutableCopy] : [NSMutableDictionary dictionary];
    
    NSString *subLabelString = @"No Due Date";
    NSString *lastTimeCompleted = @"";
    
    if ([[itemCompletedDict allKeys] count] > 0) {
        
        NSDictionary *lastTimeCompletedDict = [[[GeneralObject alloc] init] GeneralLastUserIDCompletedTaskRepeatingWhenCompleted:itemCompletedDict specificUserID:userID];
        NSString *temp = lastTimeCompletedDict[@"LastDateMarkedCompleted"] ? [[[GeneralObject alloc] init] GenerateDateWithConvertedFormatWithFormat:@"yyyy-MM-dd HH:mm:ss" dateToConvert:lastTimeCompletedDict[@"LastDateMarkedCompleted"] newFormat:@"EEE, MMM. dd, h:mm a" returnAs:[NSString class]] : @"";
        lastTimeCompleted = lastTimeCompletedDict[@"LastDateMarkedCompleted"] ? [NSString stringWithFormat:@"%@", temp] : @"";
        
        subLabelString = [lastTimeCompleted containsString:@"null"] == NO ? [NSString stringWithFormat:@"Last Completed on %@", lastTimeCompleted] : @"No Due Date";
        
    }
    
    return subLabelString;
}

#pragma mark - IBAction Methods

- (IBAction)RequestAppReviewAccepted:(id)sender {
    
    if ([[[GeneralObject alloc] init] ConnectedToInternet] == NO) {
        [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You need to be connected to the internet to do that." currentViewController:self];
        [self RequestRejected:self];
        return;
    }
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Review"] completionHandler:^(BOOL finished) {
        
    }];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if ([SKStoreReviewController class]){
            
            int numberOfTimes = 0;
            
            if (![[NSUserDefaults standardUserDefaults] objectForKey:@"TimesAskedForReview"]) {
                [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"TimesAskedForReview"];
            } else {
                numberOfTimes = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TimesAskedForReview"] intValue];
                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d", numberOfTimes+1] forKey:@"TimesAskedForReview"];
            }
            
            if (numberOfTimes < 3) {
                [SKStoreReviewController requestReviewInScene:self.view.window.windowScene];
            } else {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://apps.apple.com/us/app/wedivvy/id1570700094"] options:@{} completionHandler:^(BOOL success) {
                    
                }];
            }
            
        }
        
        [self RequestRejected:self];
        
    });
    
}

-(IBAction)RequestAppReviewRejected:(id)sender {
    
    NSString *dateFormat = @"MMMM dd, yyyy hh:mm a";
    
    if ([[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:[[NSUserDefaults standardUserDefaults] objectForKey:@"RequestedReview"] returnAs:[NSDate class]] == nil) {
        dateFormat = @"MMMM dd, yyyy HH:mm";
    }
    
    NSString *dateStringCurrent = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:dateFormat returnAs:[NSString class]];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"AddedItem"];
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"CompletedItem"];
    [[NSUserDefaults standardUserDefaults] setObject:dateStringCurrent forKey:@"RequestedReview"];
    
    [self RequestRejected:self];
    
}

-(IBAction)RequestRejected:(id)sender {
    
    [UIView animateWithDuration:0.25 animations:^{
        self->alertView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self->alertView removeFromSuperview];
    }];
    
}

-(void)UpdateTaskListItems_CompletionBlock:(NSString *)taskListName oldTaskListID:(NSString *)oldTaskListID newTaskListID:(NSString *)newTaskListID itemUniqueID:(NSString *)itemUniqueID {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSString *notificationObserver = @"";
        NSDictionary *dataDict = @{};
       
        if (oldTaskListID.length > 0 && newTaskListID.length > 0) {
            notificationObserver = @"MoveTaskToDifferentTaskList";
            dataDict = @{@"ItemUniqueID" : itemUniqueID, @"OldTaskListID" : oldTaskListID, @"NewTaskListID" : newTaskListID};
        } else if (newTaskListID.length > 0 && oldTaskListID.length == 0) {
            notificationObserver = @"AddTaskToTaskList";
            dataDict = @{@"ItemUniqueID" : itemUniqueID, @"TaskListID" : newTaskListID};
        } else if (oldTaskListID.length > 0 && newTaskListID.length == 0) {
            notificationObserver = @"RemoveTaskFromTaskList";
            dataDict = @{@"ItemUniqueID" : itemUniqueID, @"TaskListID" : oldTaskListID};
        }
       
        [[[GeneralObject alloc] init] CallNSNotificationMethods:notificationObserver userInfo:dataDict locations:@[@"Tasks"]];
        
        [self UpdateTopViewLabel:taskListName];
        
        [self->progressView setHidden:YES];
  
    });
    
}

-(void)CompleteUncompleteTaskAction_DisplayRepeatIfCompletedEarlyResetDropDown:(NSMutableDictionary *)returningDictToUse TaskIsFullyCompleted:(BOOL)TaskIsFullyCompleted {
    
    BOOL TaskIsOccurrence = [[[BoolDataObject alloc] init] TaskIsOccurrence:returningDictToUse itemType:itemType];
    BOOL TaskIsRepeatingAndRepeatingIfCompletedEarly = [[[BoolDataObject alloc] init] TaskIsRepeatingAndRepeatingIfCompletedEarly:returningDictToUse itemType:itemType];
    BOOL TaskIsRepeating = [[[BoolDataObject alloc] init] TaskIsRepeating:returningDictToUse itemType:itemType];
    BOOL TaskIsRepeatingAsNeeded = [[[BoolDataObject alloc] init] TaskIsRepeatingAsNeeded:returningDictToUse itemType:itemType];
    BOOL TaskIsRepeatingWhenCompleted = [[[BoolDataObject alloc] init] TaskIsRepeatingWhenCompleted:returningDictToUse itemType:itemType];
    BOOL TaskIsRepeatingDaily = [[[BoolDataObject alloc] init] TaskIsRepeatingDaily:returningDictToUse itemType:itemType];
    BOOL TaskIsRepeatingWeekly = [[[BoolDataObject alloc] init] TaskIsRepeatingWeekly:returningDictToUse itemType:itemType];
    BOOL TaskIsRepeatingMonthly = [[[BoolDataObject alloc] init] TaskIsRepeatingMonthly:returningDictToUse itemType:itemType];
    BOOL TaskHasAnyDay = [[[BoolDataObject alloc] init] TaskHasAnyDay:returningDictToUse itemType:itemType];
    
    if (TaskIsFullyCompleted == YES && TaskIsOccurrence == NO && TaskIsRepeatingAndRepeatingIfCompletedEarly == YES && TaskIsRepeating == YES && TaskIsRepeatingAsNeeded == NO && TaskIsRepeatingWhenCompleted == NO &&
        
        ((TaskIsRepeatingDaily == YES) ||
         ((TaskIsRepeatingWeekly == YES || TaskIsRepeatingMonthly == YES) && TaskHasAnyDay == YES))) {
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSString *repeatIfCompletedEarlyDropDownText = [self CompleteUncompleteTaskAction_GenerateRepeatIfCompletedEarlyDrowDownText:returningDictToUse];
            self->_notificationitemReminderLabel.text = repeatIfCompletedEarlyDropDownText;
            
            
            
            __block CGFloat width = CGRectGetWidth(self.view.bounds);
            __block CGFloat height = CGRectGetHeight(self.view.bounds);
            
            CGRect newRect = self->_customTableView.frame;
            newRect.size.height = self->_customTableView.frame.size.height;
            self->_customTableView.frame = newRect;
            
            [UIView animateWithDuration:0.25 animations:^{
                
                CGFloat navigationBarHeight = [[[GeneralObject alloc] init] GetNavigationBarHeight:self];
                
                self->_notificationReminderView.frame = CGRectMake(0, navigationBarHeight, width, self.view.frame.size.height*0.07201 > 53?(53):self.view.frame.size.height*0.07201);
                
                CGRect frameToUse = self->_lastCommentNoCommentView.frame;
                
                if (self->NonUserCellsVisible == YES && self->_viewingOccurrence == NO) {
                    frameToUse = self->_writeTaskContainerView.frame;
                } else {
                    frameToUse = self->_lastCommentNoCommentView.frame;
                }
                
                CGRect newRect = self->_customScrollView.frame;
                newRect.origin.y = self->_notificationReminderView.frame.origin.y + self->_notificationReminderView.frame.size.height;
                newRect.size.height = height - (height - frameToUse.origin.y) - (self->_notificationReminderView.frame.origin.y + self->_notificationReminderView.frame.size.height) - navigationBarHeight;
                self->_customScrollView.frame = newRect;
                
                newRect = self->_customTableView.frame;
                newRect.size.height = self->_customTableView.frame.size.height;
                self->_customTableView.frame = newRect;
                
                width = CGRectGetWidth(self.notificationReminderView.bounds);
                height = CGRectGetHeight(self.notificationReminderView.bounds);
                
                height = self.view.frame.size.height*0.07201 > 53?(53):self.view.frame.size.height*0.07201;
                
                self->_notificationReminderSeparator.frame = CGRectMake(0, 0, width, 0);
                self->_notificationitemReminderLabel.frame = CGRectMake(width*0.028985, height*0.5 - (((height*0.5471698)*0.5)), width - (width*0.028985)*2, height*0.5471698);
                
                self->_notificationitemReminderLabel.font = [UIFont systemFontOfSize:height*0.413793 weight:UIFontWeightBold];
                self->_notificationitemReminderLabel.adjustsFontSizeToFitWidth = YES;
                
            } completion:^(BOOL finished) {
                
                [UIView animateWithDuration:0.25 delay:7.5 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                    
                    CGFloat navigationBarHeight = [[[GeneralObject alloc] init] GetNavigationBarHeight:self];
                    width = CGRectGetWidth(self.view.bounds);
                    height = CGRectGetHeight(self.view.bounds);
                    
                    self->_notificationReminderView.frame = CGRectMake(0, 0, width, navigationBarHeight);
                    
                    CGRect frameToUse = self->_lastCommentNoCommentView.frame;
                    
                    if (self->NonUserCellsVisible == YES && self->_viewingOccurrence == NO) {
                        frameToUse = self->_writeTaskContainerView.frame;
                    } else {
                        frameToUse = self->_lastCommentNoCommentView.frame;
                    }
                    
                    CGRect newRect = self->_customScrollView.frame;
                    newRect.origin.y = navigationBarHeight;
                    newRect.size.height = height - (height - frameToUse.origin.y) - navigationBarHeight;
                    self->_customScrollView.frame = newRect;
                    
                    width = CGRectGetWidth(self.notificationReminderView.bounds);
                    height = CGRectGetHeight(self.notificationReminderView.bounds);
                    
                    height = self.view.frame.size.height*0.07201 > 53?(53):self.view.frame.size.height*0.07201;
                    
                    self->_notificationReminderSeparator.frame = CGRectMake(0, 0, width, 0);
                    self->_notificationitemReminderLabel.frame = CGRectMake(width*0.028985, height*0.5 - (((height*0.5471698)*0.5)), width - (width*0.028985)*2, height*0.5471698);
                    
                    self->_notificationitemReminderLabel.font = [UIFont systemFontOfSize:height*0.413793 weight:UIFontWeightBold];
                    self->_notificationitemReminderLabel.adjustsFontSizeToFitWidth = YES;
                    
                } completion:nil];
                
            }];
            
        });
        
    }
    
}

#pragma mark

-(NSString *)GenerateItemAmountFromItemizedItems {
    
    float totalAmountForAllItemizedItems = 0.0;
    
    for (NSString *itemizedItemName in [itemItemizedItems allKeys]) {
        
        NSString *itemAmountString = @"";
        id itemAmountArray = itemItemizedItems[itemizedItemName][@"Amount"];
        
        BOOL ObjectIsKindOfArrayClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:itemAmountArray classArr:@[[NSArray class], [NSMutableArray class]]];
        BOOL ObjectIsKindOfStringClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:itemAmountArray classArr:@[[NSString class]]];
        
        if (ObjectIsKindOfArrayClass == YES) {
            itemAmountString = itemAmountArray[0];
        } else if (ObjectIsKindOfStringClass == YES) {
            itemAmountString = itemAmountArray;
        }
        
        itemAmountString = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:itemAmountString arrayOfSymbols:@[localCurrencyNumberSeparatorSymbol, localCurrencySymbol]];
        itemAmountString = [[[GeneralObject alloc] init] GenerateLocalCurrencyStringWithReverseSeparatorsForeign:itemAmountString];
        
        totalAmountForAllItemizedItems += [itemAmountString floatValue];
        
    }
    
    NSString *totalAmountForAllItemizedItemsString = [NSString stringWithFormat:@"%.2f", totalAmountForAllItemizedItems];
    
    totalAmountForAllItemizedItemsString = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:totalAmountForAllItemizedItemsString arrayOfSymbols:@[localCurrencyNumberSeparatorSymbol, localCurrencyDecimalSeparatorSymbol, localCurrencySymbol]];
    totalAmountForAllItemizedItemsString = [[[GeneralObject alloc] init] GenerateAmountInTextFieldInProperFormat:NSRangeFromString(totalAmountForAllItemizedItemsString) replacementString:totalAmountForAllItemizedItemsString];
    
    NSString *itemAmountLocal = [totalAmountForAllItemizedItemsString isEqualToString:[NSString stringWithFormat:@"%@0%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol]] ? itemAmount : totalAmountForAllItemizedItemsString;
    
    return itemAmountLocal;
}

#pragma mark - Ellipsis Options

#pragma mark Task

#pragma mark Skip

-(NSMutableDictionary *)Skip_GenerateUpdatedSingleObjectDict {
    
    NSMutableDictionary *singleObjectItemDict = [[[GeneralObject alloc] init] GenerateSingleObjectDictionary:[self->itemDict mutableCopy] keyArray:[self->keyArray mutableCopy] indexPath:nil];
    
    NSMutableArray *itemDueDatesSkipped = singleObjectItemDict[@"ItemDueDatesSkipped"] ? [singleObjectItemDict[@"ItemDueDatesSkipped"] mutableCopy] : [NSMutableArray array];
    NSString *itemDueDate = singleObjectItemDict[@"ItemDueDate"] ? singleObjectItemDict[@"ItemDueDate"] : self->itemDueDate ? self->itemDueDate : @"No Due Date";
    
    if ([itemDueDatesSkipped containsObject:itemDueDate] == NO) {
        [itemDueDatesSkipped addObject:itemDueDate];
    }
    
    [singleObjectItemDict setObject:itemDueDatesSkipped forKey:@"ItemDueDatesSkipped"];
    
    return singleObjectItemDict;
}

#pragma mark

-(void)Skip_UpdateItemData:(NSMutableDictionary *)singleObjectItemDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSMutableArray *itemDueDatesSkipped = singleObjectItemDict[@"ItemDueDatesSkipped"] ? [singleObjectItemDict[@"ItemDueDatesSkipped"] mutableCopy] : [NSMutableArray array];
        
        [[[SetDataObject alloc] init] UpdateDataEditItem:@{@"ItemDueDatesSkipped" : itemDueDatesSkipped} itemID:self->_itemID itemOccurrenceID:self->_itemOccurrenceID collection:self->itemTypeCollection homeID:self->homeID completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)Skip_ResetItemData:(NSMutableDictionary *)singleObjectItemDict completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningItemDictLocal, NSMutableDictionary *returningItemOccurrencesDictLocal))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSMutableDictionary *singleObjectItemArrayDict = [[[GeneralObject alloc] init] GenerateSingleArraySingleObjectDictionary:singleObjectItemDict keyArray:self->keyArray indexPath:nil];
        
        [[[SetDataObject alloc] init] UpdateDataResetRepeatingTask:singleObjectItemArrayDict itemOccurrencesDict:self->itemxxxOccurrencesDict homeID:self->homeID itemType:self->itemType keyArray:self->keyArray homeMembersDict:self->_homeMembersDict notificationSettingsDict:self->_notificationSettingsDict topicDict:self->_topicDict taskListDict:self->_taskListDict allItemAssignedToArrays:self->_allItemAssignedToArrays allItemTagsArrays:self->_allItemTagsArrays SkipOccurrence:YES completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningItemDict, NSMutableDictionary * _Nonnull returningItemOccurrencesDict, NSMutableDictionary * _Nonnull returningUpdatedTaskListDict) {
            
            self->_taskListDict = [[[GeneralObject alloc] init] GenerateUpdatedTaskListDict:@[returningUpdatedTaskListDict] taskListDict:self->_taskListDict];
            
            NSMutableDictionary *singleObjectDict = [[[GeneralObject alloc] init] GenerateSingleObjectDictionary:returningItemDict keyArray:self->keyArray indexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            
            finishBlock(YES, singleObjectDict, returningItemOccurrencesDict);
            
        }];
        
    });
    
}

-(void)Skip_SendPushNotifications:(NSMutableDictionary *)singleObjectItemDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
    
    
    
    NSString *notificationType = [[[NotificationsObject alloc] init] NotificationSettingsUnknownItemType_Adding:NO Editing:NO Deleting:NO Duplicating:NO Waiving:NO Skipping:YES Pausing:NO Comments:NO
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
                                                                                                       itemType:self->itemType];
    
    
    
    NSString *notificationTitle = [NSString stringWithFormat:@"\"%@\"", self->itemName];
    NSString *notificationBody = [NSString stringWithFormat:@"%@ has skipped to the next due date for this %@. 🙂", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"], [self->itemType lowercaseString]];
    
    
    
    NSMutableArray *usersToSendNotificationTo = [self->itemAssignedToArray mutableCopy];
    
    NSArray *addTheseUsers = @[self->itemCreatedBy];
    NSArray *removeTheseUsers = @[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx"];
    
    usersToSendNotificationTo = [[[[NotificationsObject alloc] init] AddAndRemoveSpecificUsersFromArray:usersToSendNotificationTo addTheseUsers:addTheseUsers removeTheseUsers:removeTheseUsers] mutableCopy];
    
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[NotificationsObject alloc] init] SendPushNotificationToArrayOfUsers_Items:usersToSendNotificationTo
                                                                           dictToUse:singleObjectItemDict
                                                                              homeID:homeID homeMembersArray:self->_homeMembersArray homeMembersDict:self->_homeMembersDict
                                                            notificationSettingsDict:self->_notificationSettingsDict notificationItemType:self->itemType notificationType:notificationType
                                                                           topicDict:self->_topicDict
                                                                 allItemTagsArrays:self->_allItemTagsArrays
                                                               pushNotificationTitle:notificationTitle pushNotificationBody:notificationBody
                                                                   notificationTitle:notificationTitle notificationBody:notificationBody
                                                             SetDataHomeNotification:YES
                                                                RemoveUsersNotInHome:YES
                                                                   completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

#pragma mark

-(void)Skip_CompletionBlock:(int)totalQueries completedQueries:(int)completedQueries returningItemDict:(NSMutableDictionary *)returningItemDict returningItemOccurrencesDict:(NSMutableDictionary *)returningItemOccurrencesDict {
    
    if (totalQueries == completedQueries) {
        
        itemxxxOccurrencesDict = [returningItemOccurrencesDict mutableCopy];
        
        [self UpdateAllDataInViewController:nil dictToUse:returningItemDict];
        
    }
    
}

#pragma mark Move To/Out Of Trash

-(void)MoveToTrash_MoveOutOfTrash_UpdateItemData:(NSString *)itemID itemOccurrenceID:(NSString *)itemOccurrenceID MoveToTrash:(BOOL)MoveToTrash completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *itemTrash = MoveToTrash ? @"Yes" : @"No";
        
        [[[SetDataObject alloc] init] UpdateDataEditItem:@{@"ItemTrash" : itemTrash} itemID:itemID itemOccurrenceID:itemOccurrenceID collection:self->itemTypeCollection homeID:self->homeID completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)MoveToTrash_MoveOutOfTrash_SendPushNotifications:(NSMutableDictionary *)singleObjectItemDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *notificationType = [[[NotificationsObject alloc] init] NotificationSettingsUnknownItemType_Adding:NO Editing:NO Deleting:YES Duplicating:NO Waiving:NO Skipping:NO Pausing:NO Comments:NO
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
                                                                                                       itemType:self->itemType];
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *pushNotificationTitle = [NSString stringWithFormat:@"\"%@\"", singleObjectItemDict[@"ItemName"] ? singleObjectItemDict[@"ItemName"] : @""];
        NSString *pushNotificationBody = [NSString stringWithFormat:@"%@ moved this %@ %@ \"Trash\". 🗑️", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"], [self->itemType lowercaseString], [singleObjectItemDict[@"ItemTrash"] isEqualToString:@"No"] ? @"to" : @"out of"];
        
        
        
        NSString *notificationTitle = [NSString stringWithFormat:@"\"%@\"", singleObjectItemDict[@"ItemName"] ? singleObjectItemDict[@"ItemName"] : @""];
        NSString *notificationBody = [NSString stringWithFormat:@"%@ moved this %@ %@ \"Trash\". 🗑️", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"], [self->itemType lowercaseString], [singleObjectItemDict[@"ItemTrash"] isEqualToString:@"No"] ? @"to" : @"out of"];
        
        
        
        NSMutableArray *userIDArray = singleObjectItemDict[@"ItemAssignedTo"] ? [singleObjectItemDict[@"ItemAssignedTo"] mutableCopy] : [NSMutableArray array];
        NSMutableArray *usersToSendNotificationTo = [userIDArray mutableCopy];
        
        NSArray *addTheseUsers = @[singleObjectItemDict[@"ItemCreatedBy"]];
        NSArray *removeTheseUsers = @[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx"];
        
        usersToSendNotificationTo = [[[[NotificationsObject alloc] init] AddAndRemoveSpecificUsersFromArray:usersToSendNotificationTo addTheseUsers:addTheseUsers removeTheseUsers:removeTheseUsers] mutableCopy];
        
        
        
        [[[NotificationsObject alloc] init] SendPushNotificationToArrayOfUsers_Items:usersToSendNotificationTo
                                                                           dictToUse:singleObjectItemDict
                                                                              homeID:self->homeID homeMembersArray:self->_homeMembersArray homeMembersDict:self->_homeMembersDict
                                                            notificationSettingsDict:self->_notificationSettingsDict notificationItemType:self->itemType notificationType:notificationType
                                                                           topicDict:self->_topicDict
                                                                 allItemTagsArrays:self->_allItemTagsArrays
                                                               pushNotificationTitle:pushNotificationTitle pushNotificationBody:pushNotificationBody
                                                                   notificationTitle:notificationTitle notificationBody:notificationBody
                                                             SetDataHomeNotification:YES
                                                                RemoveUsersNotInHome:YES
                                                                   completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)MoveToTrash_MoveOutOfTrash_SetItemSilentNotifications:(NSMutableDictionary *)singleObjectItemDict MoveToTrash:(BOOL)MoveToTrash completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *notificationType = [[[NotificationsObject alloc] init] NotificationSettingsUnknownItemType_Adding:NO Editing:NO Deleting:YES Duplicating:NO Waiving:NO Skipping:NO Pausing:NO Comments:NO
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
                                                                                                       itemType:self->itemType];
    
    [singleObjectItemDict setObject:MoveToTrash ? @"Yes" : @"No" forKey:@"ItemTrash"];
    
    NSString *itemTrash = singleObjectItemDict[@"ItemTrash"] ? singleObjectItemDict[@"ItemTrash"] : @"";
    NSString *itemCreatedBy = singleObjectItemDict[@"ItemCreatedBy"] ? singleObjectItemDict[@"ItemCreatedBy"] : @"";
    NSMutableArray *itemAssignedTo = singleObjectItemDict[@"ItemAssignedTo"] ? singleObjectItemDict[@"ItemAssignedTo"] : [NSMutableArray array];
    
    NSMutableArray *userIDArray = [NSMutableArray array];
    NSMutableArray *userIDToRemoveArray = [NSMutableArray array];
    
    if ([itemTrash isEqualToString:@"Yes"]) {
        
        userIDArray = [NSMutableArray array];
        userIDToRemoveArray = [itemAssignedTo mutableCopy];
        
        [userIDToRemoveArray addObject:itemCreatedBy];
        
    } else {
        
        userIDArray = [itemAssignedTo mutableCopy];
        userIDToRemoveArray = [NSMutableArray array];
        
        [userIDArray addObject:itemCreatedBy];
        
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[NotificationsObject alloc] init] ResetLocalNotificationReminderNotification:singleObjectItemDict homeMembersDict:self->_homeMembersDict userIDArray:userIDArray userIDToRemoveArray:userIDToRemoveArray notificationSettingsDict:self->_notificationSettingsDict allItemTagsArrays:self->_allItemTagsArrays itemType:self->itemType notificationType:notificationType topicDict:self->_topicDict completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

#pragma mark

-(void)MoveOutOfTrash_CompletionBlock:(int)totalQueries completedQueries:(int)completedQueries MoveToTrash:(BOOL)MoveToTrash {
    
    if (totalQueries == completedQueries) {
        
        NSString *itemTrash = MoveToTrash ? @"Yes" : @"No";
        
        [self UpdateAllDataInViewController:nil dictToUse:[@{@"ItemTrash" : itemTrash} mutableCopy]];
        
        [self->progressView setHidden:YES];
        
    }
    
}

#pragma mark Mute/Unmute

-(void)MuteUnmute_UpdateMutedArray:(BOOL)Mute {
    
    NSMutableArray *mutedItemsArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"MutedItems"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"MutedItems"] : [NSMutableArray array];
    
    if (Mute == YES) {
        if ([mutedItemsArray containsObject:itemUniqueID] == NO) { [mutedItemsArray addObject:itemUniqueID]; }
    } else {
        if ([mutedItemsArray containsObject:itemUniqueID] == YES) { [mutedItemsArray removeObject:itemUniqueID]; }
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:mutedItemsArray forKey:@"MutedItems"];
    
}

#pragma mark

-(void)MuteUnmute_ResetItemNotifications:(NSMutableDictionary *)singleObjectItemDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSMutableArray *userIDArray = [NSMutableArray array];
        NSMutableArray *userIDToRemoveArray = [NSMutableArray array];
        
        [[[NotificationsObject alloc] init] ResetLocalNotificationReminderNotification:singleObjectItemDict homeMembersDict:self->_homeMembersDict userIDArray:userIDArray userIDToRemoveArray:userIDToRemoveArray notificationSettingsDict:self->_notificationSettingsDict allItemTagsArrays:self->_allItemTagsArrays itemType:self->itemType notificationType:@"" topicDict:self->_topicDict completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)MuteUnmute_ResetItemScheduledStartNotifications:(NSMutableDictionary *)singleObjectItemDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[NotificationsObject alloc] init] ResetLocalNotificationScheduledStartNotifications:[singleObjectItemDict mutableCopy] itemType:self->itemType userIDArray:[NSMutableArray array] userIDToRemoveArray:[NSMutableArray array]  allItemTagsArrays:self->_allItemTagsArrays homeMembersArray:self->_homeMembersArray homeMembersDict:self->_homeMembersDict notificationSettingsDict:self->_notificationSettingsDict topicDict:self->_topicDict completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)MuteUnmute_ResetItemCustomReminderNotifications:(NSMutableDictionary *)singleObjectItemDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[NotificationsObject alloc] init] ResetLocalNotificationCustomReminderNotification_LocalOnly:@"" itemType:self->itemType dictToUse:singleObjectItemDict homeMembersDict:self->_homeMembersDict homeMembersArray:self->_homeMembersArray  allItemTagsArrays:self->_allItemTagsArrays completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

#pragma mark

-(void)MuteUnmute_CompletionBlock:(int)totalQueries completedQueries:(int)completedQueries indexPath:(NSIndexPath *)indexPath singleObjectItemDict:(NSMutableDictionary *)singleObjectItemDict {
    
    if (totalQueries == completedQueries) {
        
        [self UpdateAllDataInViewController:indexPath dictToUse:singleObjectItemDict];
        
    }
    
}

#pragma mark Duplicate

-(NSString *)Duplicate_GenerateNewItemName:(NSMutableDictionary *)singleObjectItemDict itemNamesAlreadyUsed:(NSMutableArray *)itemNamesAlreadyUsed newItemNames:(NSMutableArray *)newItemNames {
    
    id object = singleObjectItemDict[@"ItemName"] ? singleObjectItemDict[@"ItemName"] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:@"ItemName"];
    
    NSString *newItemName = [NSString stringWithFormat:@"%@", object];
    
    for (int i=1 ; i<100 ; i++) {
        
        if ([itemNamesAlreadyUsed containsObject:newItemName] || [newItemNames containsObject:newItemName]) {
            
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
    
    return newItemName;
}

-(NSMutableDictionary *)Duplicate_GenerateSetDataDict:(NSMutableDictionary *)singleObjectItemDict itemNamesAlreadyUsed:(NSMutableArray *)itemNamesAlreadyUsed newItemNames:(NSMutableArray *)newItemNames {
    
    NSMutableDictionary *setDataDict = [NSMutableDictionary dictionary];
    
    NSString *chosenItemUniqueID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    NSString *chosenItemID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    NSString *chosenItemOccurrenceID = @"";
    NSString *chosenItemDatePosted = [[[GeneralObject alloc] init] GenerateCurrentDateString];
    
    if ([singleObjectItemDict[@"ItemOccurrenceID"] length] > 0) {
        chosenItemUniqueID = singleObjectItemDict[@"ItemUniqueID"];
        chosenItemID = singleObjectItemDict[@"ItemID"];
        chosenItemOccurrenceID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    }
    
    for (NSString *key in keyArray) {
        
        if ([key isEqualToString:@"ItemName"]) {
            
            NSString *newItemName = [self Duplicate_GenerateNewItemName:singleObjectItemDict itemNamesAlreadyUsed:itemNamesAlreadyUsed newItemNames:newItemNames];
            
            [newItemNames addObject:newItemName];
            [setDataDict setObject:newItemName forKey:key];
            
        } else if ([key isEqualToString:@"ItemID"]) {
            
            [setDataDict setObject:chosenItemID forKey:key];
            
        } else if ([key isEqualToString:@"ItemUniqueID"]) {
            
            [setDataDict setObject:chosenItemUniqueID forKey:key];
            
        } else if ([key isEqualToString:@"ItemOccurrenceID"]) {
            
            [setDataDict setObject:chosenItemOccurrenceID forKey:key];
            
        } else if ([key isEqualToString:@"ItemDatePosted"]) {
            
            [setDataDict setObject:chosenItemDatePosted forKey:key];
            
        } else if ([key isEqualToString:@"ItemOccurrenceStatus"]) {
            
            [setDataDict setObject:@"None" forKey:key];
            
        } else if ([key isEqualToString:@"ItemStatus"]) {
            
            [setDataDict setObject:@"None" forKey:key];
            
        } else if ([key isEqualToString:@"ItemCompletedDict"]) {
            
            [setDataDict setObject:[NSMutableDictionary dictionary] forKey:key];
            
        } else if ([key isEqualToString:@"ItemInProgressDict"]) {
            
            [setDataDict setObject:[NSMutableDictionary dictionary] forKey:key];
            
        } else {
            
            id object = self->itemDict[key] ? self->itemDict[key] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
            [setDataDict setObject:object forKey:key];
            
        }
        
    }
    
    return setDataDict;
}

#pragma mark

-(void)Duplicate_SendPushNotifications:(NSMutableDictionary *)setDataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *itemName = setDataDict[@"ItemName"];
    NSMutableArray *userIDArray = [setDataDict[@"ItemAssignedTo"] mutableCopy];
    
    NSString *notificationType = [[[NotificationsObject alloc] init] NotificationSettingsUnknownItemType_Adding:NO Editing:NO Deleting:NO Duplicating:YES Waiving:NO Skipping:NO Pausing:NO Comments:NO
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
                                                                                                       itemType:self->itemType];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
        
        
        
        NSString *pushNotificationTitle = [NSString stringWithFormat:@"\"%@\"", itemName];
        NSString *pushNotificationBody = [[[NotificationsObject alloc] init] GeneratePushNotificationAddItemBody:YES EditItem:NO DeleteItem:NO NotificationItem:NO NobodyAssigned:NO userIDArray:userIDArray];
        
        
        
        NSString *notificationTitle = [NSString stringWithFormat:@"\"%@\"", itemName];
        NSString *notificationBody = [[[NotificationsObject alloc] init] GeneratePushNotificationAddItemBody:YES EditItem:NO DeleteItem:NO NotificationItem:YES NobodyAssigned:NO userIDArray:userIDArray];
        
        
        
        NSMutableArray *usersToSendNotificationTo = [userIDArray mutableCopy];
        
        NSArray *addTheseUsers = @[setDataDict[@"ItemCreatedBy"]];
        NSArray *removeTheseUsers = @[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx"];
        
        usersToSendNotificationTo = [[[[NotificationsObject alloc] init] AddAndRemoveSpecificUsersFromArray:usersToSendNotificationTo addTheseUsers:addTheseUsers removeTheseUsers:removeTheseUsers] mutableCopy];
        
        
        
        [[[NotificationsObject alloc] init] SendPushNotificationToArrayOfUsers_Items:usersToSendNotificationTo
                                                                           dictToUse:setDataDict
                                                                              homeID:homeID homeMembersArray:self->_homeMembersArray homeMembersDict:self->_homeMembersDict
                                                            notificationSettingsDict:self->_notificationSettingsDict notificationItemType:self->itemType notificationType:notificationType
                                                                           topicDict:self->_topicDict
                                                                 allItemTagsArrays:self->_allItemTagsArrays
                                                               pushNotificationTitle:pushNotificationTitle pushNotificationBody:pushNotificationBody
                                                                   notificationTitle:notificationTitle notificationBody:notificationBody
                                                             SetDataHomeNotification:YES
                                                                RemoveUsersNotInHome:YES
                                                                   completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)Duplicate_SendItemSilentNotifications:(NSMutableDictionary *)setDataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *notificationType = [[[NotificationsObject alloc] init] NotificationSettingsUnknownItemType_Adding:NO Editing:NO Deleting:NO Duplicating:YES Waiving:NO Skipping:NO Pausing:NO Comments:NO
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
                                                                                                       itemType:self->itemType];
    
    NSString *itemCreatedBy = setDataDict[@"ItemCreatedBy"] ? setDataDict[@"ItemCreatedBy"] : @"";
    NSMutableArray *itemAssignedTo = setDataDict[@"ItemAssignedTo"] ? setDataDict[@"ItemAssignedTo"] : [NSMutableArray array];
    
    NSMutableArray *userIDArray = [itemAssignedTo mutableCopy];
    NSMutableArray *userIDToRemoveArray = [NSMutableArray array];
    
    [userIDArray addObject:itemCreatedBy];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[NotificationsObject alloc] init] ResetLocalNotificationReminderNotification:setDataDict homeMembersDict:self->_homeMembersDict userIDArray:userIDArray userIDToRemoveArray:userIDToRemoveArray notificationSettingsDict:self->_notificationSettingsDict allItemTagsArrays:self->_allItemTagsArrays itemType:self->itemType notificationType:notificationType topicDict:self->_topicDict completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)Duplicate_SetItemData:(NSMutableDictionary *)setDataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *collection = [NSString stringWithFormat:@"%@s", self->itemType];
        
        [[[SetDataObject alloc] init] SetDataAddItem:setDataDict collection:collection homeID:self->homeID completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)Duplicate_SetImageData:(NSMutableDictionary *)setDataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    UIImage *itemImageImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:setDataDict[@"ItemImageURL"]]]];
    NSString *chosenItemUniqueID = setDataDict[@"ItemUniqueID"] ? setDataDict[@"ItemUniqueID"] : @"xxx";
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *imgData = UIImageJPEGRepresentation(itemImageImage, 0.15);
        
        if (imgData != nil) {
            
            [[[SetDataObject alloc] init] SetDataItemImage:chosenItemUniqueID itemType:self->itemType imgData:imgData completionHandler:^(BOOL finished) {
                
                finishBlock(YES);
                
            }];
            
        } else {
            
            finishBlock(YES);
            
        }
        
    });
    
}

-(void)Duplicate_UpdateTaskListData:(NSMutableDictionary *)taskListDict newItemUniqueID:(NSString *)newItemUniqueID originalItemUniqueID:(NSString *)originalItemUniqueID completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *newTaskListName = topViewLabel.text;
    NSDictionary *itemUniqueIDDict = @{newItemUniqueID : @{@"SpecificItemUniqueID" : originalItemUniqueID}};
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self UpdateTaskListItems_AllTaskLists:newTaskListName oldTaskListName:@"" itemUniqueIDDict:itemUniqueIDDict completionHandler:^(BOOL finished, NSString *oldTaskListID, NSString *newTaskListID) {
            
            [self UpdateTaskListItems_CompletionBlock:newTaskListName oldTaskListID:oldTaskListID newTaskListID:newTaskListID itemUniqueID:newItemUniqueID];
            
            finishBlock(YES);
            
        }];
        
    });
    
}

#pragma mark

-(void)Duplicate_CompletionBlock:(NSMutableDictionary *)setDataDict totalQueries:(int)totalQueries completedQueries:(int)completedQueries completionHandler:(void (^)(BOOL finished))finishBlock {
    
    if (totalQueries == completedQueries) {
        
        [[[GeneralObject alloc] init] CreateAlert:@"Duplicate Created!" message:[NSString stringWithFormat:@"A duplicate of this %@ has been created", [self->itemType lowercaseString]] currentViewController:self];
        
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"AddTask" userInfo:setDataDict locations:@[@"Tasks", @"Calendar"]];
        
        [self->progressView setHidden:YES];
        
        finishBlock(YES);
        
    }
    
}

#pragma mark Delete Trash Permanently

-(void)DeleteTrashPermanently_DeleteItemData:(NSMutableDictionary *)singleObjectItemDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *notificationType = [[[NotificationsObject alloc] init] NotificationSettingsUnknownItemType_Adding:NO Editing:NO Deleting:YES Duplicating:NO Waiving:NO Skipping:NO Pausing:NO Comments:NO
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
                                                                                                       itemType:self->itemType];
    
    NSString *notificationItemType = itemType;
    
    NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
    
    [[[DeleteDataObject alloc] init] DeleteDataItemCompletely:singleObjectItemDict homeID:homeID itemType:itemType keyArray:self->keyArray homeMembersArray:self->_homeMembersArray homeMembersDict:self->_homeMembersDict notificationSettingsDict:self->_notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType topicDict:self->_topicDict taskListDict:[self->_taskListDict mutableCopy] allItemTagsArrays:self->_allItemTagsArrays currentViewController:self completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningUpdatedTaskListDict) {
        
        self->_taskListDict = [[[GeneralObject alloc] init] GenerateUpdatedTaskListDict:@[returningUpdatedTaskListDict] taskListDict:self->_taskListDict];
        
        finishBlock(YES);
        
    }];
    
}

#pragma mark

-(void)DeleteTrashPermanently_FinishBlock {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSMutableDictionary *setDataDict = [NSMutableDictionary dictionary];
        
        for (NSString *key in self->keyArray) {
            id object = self->itemDict[key] ? self->itemDict[key] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
            [setDataDict setObject:object forKey:key];
        }
        
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"DeleteTask" userInfo:setDataDict locations:@[@"Tasks", @"Calendar"]];
        
        [self->progressView setHidden:YES];
        [self DismissViewController:self];
        
    });
    
}

#pragma mark - TableView Methods, cellForRow

-(void)GenerateAlterateCheckmarkViewBackgroundColorUserCell:(NSIndexPath *)indexPath cell:(ViewTaskCell *)cell {
    
    NSMutableDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:itemAssignedToArray[indexPath.row] homeMembersDict:_homeMembersDict];
    NSString *userID = dataDict[@"UserID"];
    
    BOOL TaskIsDeactivedForSpecificUser = [[[BoolDataObject alloc] init] SpecificUserShouldDisplayDeactivatedColor:self->itemDict itemType:itemType userID:userID homeMembersDict:_homeMembersDict];
    BOOL TaskCompletedBySpecificUser = [[[BoolDataObject alloc] init] TaskCompletedBySpecificUser:self->itemDict itemType:itemType userID:userID];
    BOOL TaskInProgressBySpecificUser = [[[BoolDataObject alloc] init] TaskInProgressBySpecificUser:self->itemDict itemType:itemType userID:userID];
    BOOL TaskWontDoBySpecificUser = [[[BoolDataObject alloc] init] TaskWontDoBySpecificUser:self->itemDict itemType:itemType userID:userID];
    BOOL TaskApprovalRequestPendingBySpecificUser = [[[BoolDataObject alloc] init] TaskApprovalRequestPendingBySpecificUser:self->itemDict itemType:itemType userID:userID];
    
    BOOL TaskIsTakingTurns = [[[BoolDataObject alloc] init] TaskIsTakingTurns:self->itemDict itemType:itemType];
    BOOL TaskIsCompleteAsNeeded = [[[BoolDataObject alloc] init] TaskIsCompleteAsNeeded:self->itemDict itemType:itemType];
    
    if (TaskIsCompleteAsNeeded == NO) {
       
        if (TaskIsDeactivedForSpecificUser == YES && TaskCompletedBySpecificUser == NO && TaskInProgressBySpecificUser == NO && TaskWontDoBySpecificUser == NO) {
            
            cell.alternateCheckmarkView.backgroundColor = [UIColor colorWithRed:236.0f/255.0f green:238.0f/255.0f blue:240.0f/255.0f alpha:1.0f];
            
        } else if (TaskCompletedBySpecificUser == YES && TaskInProgressBySpecificUser == NO && TaskWontDoBySpecificUser == NO) {
            
            cell.alternateCheckmarkView.backgroundColor = [UIColor systemGreenColor];
            
        } else if (TaskInProgressBySpecificUser == YES && TaskWontDoBySpecificUser == NO) {
            
            cell.alternateCheckmarkView.backgroundColor = [UIColor systemYellowColor];
            
        } else if (TaskWontDoBySpecificUser == YES) {
            
            cell.alternateCheckmarkView.backgroundColor = [UIColor colorWithRed:236.0f/255.0f green:238.0f/255.0f blue:240.0f/255.0f alpha:1.0f];
            
        } else if (TaskApprovalRequestPendingBySpecificUser == YES) {
            
            cell.alternateCheckmarkView.backgroundColor = [UIColor systemBlueColor];
            
        } else {
            
            cell.alternateCheckmarkView.backgroundColor = [UIColor systemPinkColor];
            
        }
        
    } else {
        
        if (TaskIsDeactivedForSpecificUser == YES) {
            
            cell.alternateCheckmarkView.backgroundColor = [UIColor colorWithRed:236.0f/255.0f green:238.0f/255.0f blue:240.0f/255.0f alpha:1.0f];
            
        } else if (TaskCompletedBySpecificUser == YES && TaskInProgressBySpecificUser == NO && TaskApprovalRequestPendingBySpecificUser == NO && (TaskIsTakingTurns == NO || (TaskIsTakingTurns == YES && itemAssignedToArray.count == 1))) {
            
            cell.alternateCheckmarkView.backgroundColor = [UIColor systemGreenColor];
            
        } else if (TaskInProgressBySpecificUser == YES) {
            
            cell.alternateCheckmarkView.backgroundColor = [UIColor systemYellowColor];
            
        } else if (TaskWontDoBySpecificUser == YES) {
            
            cell.alternateCheckmarkView.backgroundColor = [UIColor colorWithRed:236.0f/255.0f green:238.0f/255.0f blue:240.0f/255.0f alpha:1.0f];
            
        } else if (TaskApprovalRequestPendingBySpecificUser == YES) {
            
            cell.alternateCheckmarkView.backgroundColor = [UIColor systemBlueColor];
            
        } else {
            
            cell.alternateCheckmarkView.backgroundColor = [UIColor systemPinkColor];
            
        }
        
    }
    
}

-(void)GenerateAlterateCheckmarkViewBackgroundColorSubtaskCell:(NSIndexPath *)indexPath cell:(ViewTaskCell *)cell {
    
    UIColor *color = [UIColor redColor];
    
    NSString *subtask = itemSubTasksDict && [[itemSubTasksDict allKeys] count] ? [itemSubTasksDict allKeys][indexPath.row] : @"";
    
    BOOL SubtaskIsCompleted = [[[BoolDataObject alloc] init] SubtaskIsCompleted:self->itemDict itemType:itemType subtask:subtask];
    BOOL SubtaskIsInProgress = [[[BoolDataObject alloc] init] SubtaskIsInProgress:self->itemDict itemType:itemType subtask:subtask];
    BOOL SubtaskIsWontDo = [[[BoolDataObject alloc] init] SubtaskIsWontDo:self->itemDict itemType:itemType subtask:subtask];
    
    BOOL SubtaskIsRequestingApprovalPending = [[[BoolDataObject alloc] init] SubtaskIsRequestingApprovalPending:self->itemDict itemType:itemType subtask:subtask];
    
    if (SubtaskIsCompleted == YES && SubtaskIsWontDo == NO) {
        
        cell.titleLabel.textColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ?  [[[LightDarkModeObject alloc] init] DarkModeTextSecondary] : [[[LightDarkModeObject alloc] init] LightModeTextSecondary];
        cell.titleLabel.alpha = 0.75;
        
        color = [UIColor systemGreenColor];
        cell.checkmarkView.backgroundColor = color;
        
    } else if (SubtaskIsInProgress == YES && SubtaskIsWontDo == NO) {
        
        cell.titleLabel.textColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ?  [[[LightDarkModeObject alloc] init] DarkModeTextPrimary] : [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        cell.titleLabel.alpha = 0.75;
        
        color = [UIColor systemYellowColor];
        cell.checkmarkView.backgroundColor = color;
        
    } else if (SubtaskIsWontDo == YES) {
        
        cell.titleLabel.textColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ?  [[[LightDarkModeObject alloc] init] DarkModeTextPrimary] : [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        cell.titleLabel.alpha = 0.75;
        
        color = [UIColor colorWithRed:236.0f/255.0f green:238.0f/255.0f blue:240.0f/255.0f alpha:1.0f];
        cell.checkmarkView.backgroundColor = color;
        
    } else if (SubtaskIsRequestingApprovalPending == YES) {
        
        cell.titleLabel.textColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ?  [[[LightDarkModeObject alloc] init] DarkModeTextPrimary] : [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        cell.titleLabel.alpha = 0.75;
        
        color = [UIColor systemBlueColor];
        cell.checkmarkView.backgroundColor = color;
        
    } else {
        
        cell.titleLabel.textColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ?  [[[LightDarkModeObject alloc] init] DarkModeTextPrimary] : [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        cell.titleLabel.alpha = 0.75;
        
        color = [UIColor systemPinkColor];
        cell.checkmarkView.backgroundColor = color;
        
    }
    
}

-(NSString *)GenerateCompletionRatePercentageText:(NSMutableArray *)totalCompletedArrayLocal indexPath:(NSIndexPath *)indexPath {
    
    float percentage = 0.0;
    NSString *completedAnalytic = @"0";
    NSString *assignedAnalytic = @"0";
    
    BOOL IndexIsInRange = totalCompletedArrayLocal.count > indexPath.row;
    
    if (IndexIsInRange == YES) {
        
        if ([totalCompletedArrayLocal count] > indexPath.row) {
            if (totalCompletedArrayLocal[indexPath.row][@"TotalCompleted"]) {
                if (totalCompletedArrayLocal[indexPath.row][@"TotalAssigned"]) {
                    
                    percentage = ([totalCompletedArrayLocal[indexPath.row][@"TotalCompleted"] floatValue]/[totalCompletedArrayLocal[indexPath.row][@"TotalAssigned"] floatValue])*100;
                    
                }
            }
        }
        
        if ([[NSString stringWithFormat:@"%f", percentage] isEqualToString:@"nan"]) {
            percentage = 0.0;
        }
        
        completedAnalytic = [totalCompletedArrayLocal count] > indexPath.row && totalCompletedArrayLocal[indexPath.row][@"TotalCompleted"] ? totalCompletedArrayLocal[indexPath.row][@"TotalCompleted"] : @"0";
        assignedAnalytic = [totalCompletedArrayLocal count] > indexPath.row && totalCompletedArrayLocal[indexPath.row][@"TotalAssigned"] ? totalCompletedArrayLocal[indexPath.row][@"TotalAssigned"] : @"0";
        
    }
    
    return [NSString stringWithFormat:@"%.0f%% (%@/%@)", percentage , completedAnalytic, assignedAnalytic];
    
}

-(NSDictionary *)GenerateCompletionRatePercentageBackgroundColorAndWidth:(NSMutableArray *)totalCompletedArrayLocal indexPath:(NSIndexPath *)indexPath width:(CGFloat)width {
    
    CGFloat progressBarWidth = 0.0;
    float percentage = 0.0;
    
    if (totalCompletedArrayLocal.count > indexPath.row) {
        
        if ([totalCompletedArrayLocal count] > indexPath.row) {
            if (totalCompletedArrayLocal[indexPath.row][@"TotalCompleted"]) {
                if (totalCompletedArrayLocal[indexPath.row][@"TotalAssigned"]) {
                    
                    progressBarWidth = ([totalCompletedArrayLocal[indexPath.row][@"TotalCompleted"] floatValue]/[totalCompletedArrayLocal[indexPath.row][@"TotalAssigned"] floatValue])*((width*0.2 > 69?(69):width*0.2));
                    percentage = ([totalCompletedArrayLocal[indexPath.row][@"TotalCompleted"] floatValue]/[totalCompletedArrayLocal[indexPath.row][@"TotalAssigned"] floatValue])*100;
                    
                }
            }
        }
        
    }
    
    if ([[NSString stringWithFormat:@"%f", progressBarWidth] isEqualToString:@"nan"]) {
        progressBarWidth = 0.0;
    } else if (progressBarWidth > (width*0.2 > 69?(69):width*0.2)) {
        progressBarWidth = (width*0.2 > 69?(69):width*0.2);
    }
    
    if ([[NSString stringWithFormat:@"%f", percentage] isEqualToString:@"nan"]) {
        percentage = 0.0;
    }
    
    UIColor *progressBarColor = [UIColor systemGreenColor];
    
    if (percentage > 0 && percentage <= 25) {
        progressBarColor = [UIColor systemPinkColor];
    } else if (percentage > 25 && percentage <= 50) {
        progressBarColor = [UIColor systemOrangeColor];
    } else if (percentage > 50 && percentage <= 75) {
        progressBarColor = [UIColor systemYellowColor];
    }
    
    return @{@"BackgroundColor" : progressBarColor, @"Width" : [NSString stringWithFormat:@"%f", progressBarWidth]};
    
}

-(NSString *)GenerateItemCompletedTextUserCell:(NSIndexPath *)indexPath {
    
    NSMutableDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:itemAssignedToArray[indexPath.row] homeMembersDict:_homeMembersDict];
    NSString *userIDForUserInCell = dataDict[@"UserID"];
    NSString *usernameForUserInCell = dataDict[@"Username"];
   
    BOOL TaskCompletedBySpecificUser = [[[BoolDataObject alloc] init] TaskCompletedBySpecificUser:self->itemDict itemType:itemType userID:userIDForUserInCell];
    BOOL TaskInProgressBySpecificUser = [[[BoolDataObject alloc] init] TaskInProgressBySpecificUser:self->itemDict itemType:itemType userID:userIDForUserInCell];
    BOOL TaskWontDoBySpecificUser = [[[BoolDataObject alloc] init] TaskWontDoBySpecificUser:self->itemDict itemType:itemType userID:userIDForUserInCell];
    BOOL TaskIsTakingTurns = [[[BoolDataObject alloc] init] TaskIsTakingTurns:self->itemDict itemType:itemType];
    BOOL ViewingAExpense = _viewingViewExpenseViewController == YES;
    BOOL TaskApprovalRequestPendingBySpecificUser = [[[BoolDataObject alloc] init] TaskApprovalRequestPendingBySpecificUser:self->itemDict itemType:itemType userID:userIDForUserInCell];
    
    NSString *completedString = @"";
    NSString *paidString = @"";
    NSString *amountString = @"";
    NSString *timeString = @"";
    
    if (ViewingAExpense == YES) {
        
        NSString *someAmount = @"";
        
        if (itemCostPerPersonDict[userIDForUserInCell]) {
            someAmount = itemCostPerPersonDict[userIDForUserInCell];
        }
        
        someAmount = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:someAmount arrayOfSymbols:@[localCurrencyNumberSeparatorSymbol, localCurrencyDecimalSeparatorSymbol, localCurrencySymbol]];
        
        amountString = [[[GeneralObject alloc] init] GenerateAmountInTextFieldInProperFormat:NSRangeFromString(someAmount) replacementString:someAmount];
        
    }
    
    if (TaskCompletedBySpecificUser == YES) {
        
        NSDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:itemCompletedDict[userIDForUserInCell][@"Marked By"] homeMembersDict:_homeMembersDict];
        NSString *username = dataDict[@"Username"];
        
        BOOL UserIsMe = [itemCompletedDict[userIDForUserInCell][@"Marked For"] isEqualToString:itemCompletedDict[userIDForUserInCell][@"Marked By"]];
        BOOL UserIsTheSameAsUserInCell = [username isEqualToString:usernameForUserInCell] == YES;
        
        completedString = (UserIsMe == YES || UserIsTheSameAsUserInCell == YES) ? @"Completed" : [NSString stringWithFormat:@"Completed by %@", username];
        paidString = (UserIsMe == YES || UserIsTheSameAsUserInCell == YES) ? @"Paid" : [NSString stringWithFormat:@"Paid by %@", username];
        timeString = itemCompletedDict[userIDForUserInCell] && itemCompletedDict[userIDForUserInCell][@"Date Marked"] ? [NSString stringWithFormat:@"• %@", [[[GeneralObject alloc] init] GetDisplayTimeSinceDate:itemCompletedDict[userIDForUserInCell][@"Date Marked"] shortStyle:NO reallyShortStyle:NO]] : @"";
        
    } else if (TaskCompletedBySpecificUser == NO) {
        
        completedString = @"Uncompleted";
        paidString = @"Unpaid";
        
    }
    
    if (TaskInProgressBySpecificUser == YES) {
        
        BOOL UserIsMe = [itemCompletedDict[userIDForUserInCell][@"Marked For"] isEqualToString:itemCompletedDict[userIDForUserInCell][@"Marked By"]];
        
        NSDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:itemInProgressDict[userIDForUserInCell][@"Marked By"] homeMembersDict:_homeMembersDict];
        NSString *username = dataDict[@"Username"];
        
        completedString = UserIsMe ? @"In Progress" : [NSString stringWithFormat:@"In Progress by %@", username];
        paidString = UserIsMe ? @"In Progress" : [NSString stringWithFormat:@"In Progress by %@", username];
        timeString = itemCompletedDict[userIDForUserInCell] && itemCompletedDict[userIDForUserInCell][@"Date Marked"] ? [NSString stringWithFormat:@"• %@", [[[GeneralObject alloc] init] GetDisplayTimeSinceDate:itemInProgressDict[userIDForUserInCell][@"Date Marked"] shortStyle:NO reallyShortStyle:NO]] : @"";
        
    }
    
    if (TaskApprovalRequestPendingBySpecificUser == YES) {
        
        completedString = @"Completion Request Pending";
        paidString = @"Completion Request Pending";
        
    }
    
    NSString *finalPaidString = [NSString stringWithFormat:@"%@ %@ %@", paidString, amountString, timeString];
    NSString *finalCompletedString = [NSString stringWithFormat:@"%@ %@", completedString, timeString];
    
    NSString *finalString = ViewingAExpense == YES ? finalPaidString : finalCompletedString;
    
    
    
    
    BOOL TaskIsSpecificUsersTurn = [[[BoolDataObject alloc] init] TaskIsSpecificUsersTurn:self->itemDict itemType:itemType userID:userIDForUserInCell homeMembersDict:_homeMembersDict];
    BOOL TaskIsSpecificUsersTurnNext = [[[BoolDataObject alloc] init] TaskIsSpecificUsersTurnNext:[@{@"ItemTakeTurns" : itemTakeTurns, @"ItemTurnUserID" : itemTurnUserID, @"ItemAssignedTo" : itemAssignedToArray} mutableCopy] itemType:self->itemType userID:userIDForUserInCell];
    BOOL SpecificUserIsMe = [[[BoolDataObject alloc] init] SpecificUserIsMe:userIDForUserInCell];
    
    NSString *string = finalString;
    
    
    if (TaskIsSpecificUsersTurn == NO && TaskIsSpecificUsersTurnNext == YES && TaskIsTakingTurns == YES && TaskCompletedBySpecificUser == NO && TaskInProgressBySpecificUser == NO) {
        
        string = @"Up next";
        
    } else if (TaskIsSpecificUsersTurn == NO && TaskIsSpecificUsersTurnNext == NO && TaskIsTakingTurns == YES && SpecificUserIsMe == NO && TaskCompletedBySpecificUser == NO && TaskInProgressBySpecificUser == NO) {
        
        string = @"Not their turn";
        
    } else if (TaskIsSpecificUsersTurn == NO && TaskIsSpecificUsersTurnNext == NO && TaskIsTakingTurns == YES && SpecificUserIsMe == YES && TaskCompletedBySpecificUser == NO && TaskInProgressBySpecificUser == NO) {
        
        string = @"Not my turn";
        
    }
    
    if (TaskWontDoBySpecificUser == YES) {
        
        string = @"Won't Do";
        
    }
    
    BOOL TaskPhotoConfirmationNeededForSpecificObject = [[[BoolDataObject alloc] init] TaskPhotoConfirmationNeededForSpecificObject:self->itemDict itemType:self->itemType objectToUse:userIDForUserInCell];
    
    if (TaskPhotoConfirmationNeededForSpecificObject == YES) {
        
        string = @"Photo Confirmation Needed";
        
    }
    
    return string;
}

-(NSString *)GenerateItemCompletedTextUserCellItemCompleteAsNeeded:(NSIndexPath *)indexPath {
    
    NSMutableDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:itemAssignedToArray[indexPath.row] homeMembersDict:_homeMembersDict];
    NSString *userID = dataDict[@"UserID"];
    
    BOOL TaskCompletedBySpecificUser = [[[BoolDataObject alloc] init] TaskCompletedBySpecificUser:self->itemDict itemType:itemType userID:userID];
    BOOL TaskInProgressBySpecificUser = [[[BoolDataObject alloc] init] TaskInProgressBySpecificUser:self->itemDict itemType:itemType userID:userID];
    BOOL TaskIsTakingTurns = [[[BoolDataObject alloc] init] TaskIsTakingTurns:self->itemDict itemType:itemType];
    BOOL TaskIsSpecificUsersTurn = [[[BoolDataObject alloc] init] TaskIsSpecificUsersTurn:self->itemDict itemType:itemType userID:userID homeMembersDict:_homeMembersDict];
    BOOL ViewingAExpense = _viewingViewExpenseViewController == YES;
    BOOL TaskIsCompleteAsNeeded = [[[BoolDataObject alloc] init] TaskIsCompleteAsNeeded:self->itemDict itemType:itemType];
    BOOL TaskApprovalRequestPendingBySpecificUser = [[[BoolDataObject alloc] init] TaskApprovalRequestPendingBySpecificUser:self->itemDict itemType:itemType userID:userID];
    
    NSString *amountString;
    
    if (ViewingAExpense == YES) {
        
        NSString *someAmount = @"";
        
        if (itemCostPerPersonDict[userID]) {
            someAmount = itemCostPerPersonDict[userID];
        }
        
        someAmount = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:someAmount arrayOfSymbols:@[localCurrencyNumberSeparatorSymbol, localCurrencyDecimalSeparatorSymbol, localCurrencySymbol]];
        
        amountString = [[[GeneralObject alloc] init] GenerateAmountInTextFieldInProperFormat:NSRangeFromString(someAmount) replacementString:someAmount];
        
    }
    
    NSString *completedString = TaskCompletedBySpecificUser == YES ? @"Completed" : @"Uncompleted";
    NSString *paidString = TaskCompletedBySpecificUser == YES ? @"Paid" : @"Unpaid";
    NSDictionary *lastTimeCompletedDict = [[[GeneralObject alloc] init] GeneralLastUserIDCompletedTaskRepeatingWhenCompleted:itemCompletedDict specificUserID:userID];
    NSString *temp = lastTimeCompletedDict[@"LastDateMarkedCompleted"] ? [[[GeneralObject alloc] init] GenerateDateWithConvertedFormatWithFormat:@"yyyy-MM-dd HH:mm:ss" dateToConvert:lastTimeCompletedDict[@"LastDateMarkedCompleted"] newFormat:@"EEE, MMM. dd, h:mm a" returnAs:[NSString class]] : @"";
    NSString *lastTimeCompleted = lastTimeCompletedDict[@"LastDateMarkedCompleted"] ? [NSString stringWithFormat:@"%@", temp] : @"";
    
    NSString *completeAsNeededString = @"";
    
    if (TaskIsCompleteAsNeeded == YES) {
        
        int countDict = 0;
        
        NSMutableDictionary *itemCompletedDictLocal = itemCompletedDict ? [itemCompletedDict mutableCopy] : [NSMutableDictionary dictionary];
        
        for (NSString *userIDKey in [itemCompletedDictLocal allKeys]) {
            
            NSString *userIDKeyCopy = [userIDKey mutableCopy];
            
            if ([userIDKeyCopy containsString:@"•••"] == YES) {
                
                userIDKeyCopy = [[userIDKeyCopy componentsSeparatedByString:@"•••"] count] > 0 ? [userIDKeyCopy componentsSeparatedByString:@"•••"][0] : @"";
                
            }
            
            if ([userIDKeyCopy isEqualToString:userID]) {
                
                countDict += 1;
                
            }
            
        }
        
        NSString *sString = countDict == 1 ? @"" : @"s";
        
        int countToUse = countDict;
        
        NSString *lastCompletionString = countDict > 0 ? [NSString stringWithFormat:@"\nLast %@: %@", ViewingAExpense == YES ? @"Payment" : @"Completion", lastTimeCompleted] : @"";
        
        completeAsNeededString = countDict != 0 ? [NSString stringWithFormat:@"%d Time%@%@", countToUse, sString, lastCompletionString] : @"";
        
    }
    
    if (TaskInProgressBySpecificUser == YES) {
        
        if (TaskIsCompleteAsNeeded == NO) {
            
            completedString = @"In Progress";
            paidString = @"In Progress";
            
        } else {
            
            completeAsNeededString = [NSString stringWithFormat:@"%@\nIn Progress", completeAsNeededString];
            
        }
        
    }
    
    if (TaskApprovalRequestPendingBySpecificUser == YES) {
        
        if (TaskIsCompleteAsNeeded == NO) {
            
            completedString = @"Completion Request Pending";
            paidString = @"Completion Request Pending";
            
        } else {
            
            completeAsNeededString = [NSString stringWithFormat:@"%@\nCompletion Request Pending", completeAsNeededString];
            
        }
        
    }
    
    NSString *finalPaidString = [NSString stringWithFormat:@"%@ %@ %@", paidString, amountString, completeAsNeededString];
    NSString *finalCompletedString = [NSString stringWithFormat:@"%@ %@", completedString, completeAsNeededString];
    
    NSString *finalString = ViewingAExpense == YES ? finalPaidString : finalCompletedString;
    
    
    
    
    BOOL SpecificUserIsMe = [[[BoolDataObject alloc] init] SpecificUserIsMe:userID];
    
    NSString *string = finalString;
    
    if (TaskIsSpecificUsersTurn == NO && TaskIsTakingTurns == YES && SpecificUserIsMe == NO) {
        
        if (TaskIsTakingTurns == YES && TaskIsCompleteAsNeeded == YES && TaskIsSpecificUsersTurn == NO && [string containsString:@"Uncompleted"]) {
            
            string = [NSString stringWithFormat:@"Not their turn"];
            
        } else {
            
            string = [NSString stringWithFormat:@"%@\nNot their turn", string];
            
        }
        
    } else if (TaskIsSpecificUsersTurn == NO && TaskIsTakingTurns == YES && SpecificUserIsMe == YES) {
        
        if (TaskIsTakingTurns == YES && TaskIsCompleteAsNeeded == YES && TaskIsSpecificUsersTurn == NO && [string containsString:@"Uncompleted"]) {
            
            string = [NSString stringWithFormat:@"Not my turn"];
            
        } else {
            
            string = [NSString stringWithFormat:@"%@\nNot my turn", string];
            
        }
        
    }
    
    BOOL TaskPhotoConfirmationNeededForSpecificObject = [[[BoolDataObject alloc] init] TaskPhotoConfirmationNeededForSpecificObject:self->itemDict itemType:self->itemType objectToUse:userID];
    
    if (TaskPhotoConfirmationNeededForSpecificObject == YES) {
        
        string = @"Photo Confirmation Needed";
        
    }
    
    return string;
    
}

-(NSString *)GenerateItemCompletedTextSubtaskCell:(NSIndexPath *)indexPath {
    
    NSString *completedString = @"";
    
    NSString *subtask = [[itemSubTasksDict allKeys] count] > indexPath.row ? [itemSubTasksDict allKeys][indexPath.row] : @"";
    
    BOOL SubtaskIsCompleted = [[[BoolDataObject alloc] init] SubtaskIsCompleted:self->itemDict itemType:itemType subtask:subtask];
    BOOL SubtaskIsInProgress = [[[BoolDataObject alloc] init] SubtaskIsInProgress:self->itemDict itemType:itemType subtask:subtask];
    BOOL SubtaskIsWontDo = [[[BoolDataObject alloc] init] SubtaskIsWontDo:self->itemDict itemType:itemType subtask:subtask];
    
    BOOL SubtaskIsRequestingApprovalPending = [[[BoolDataObject alloc] init] SubtaskIsRequestingApprovalPending:self->itemDict itemType:itemType subtask:subtask];
    
    if (SubtaskIsCompleted == YES || SubtaskIsInProgress == YES || SubtaskIsWontDo == YES) {
        
        NSString *arrayStringKey;
        NSString *arrayKey;
        
        if (SubtaskIsCompleted == YES) {
            arrayStringKey = @"Completed";
            arrayKey = @"Completed Dict";
        } else if (SubtaskIsInProgress == YES) {
            arrayStringKey = @"In Progress";
            arrayKey = @"In Progress Dict";
        }
        
        NSString *subTaskName = itemSubTasksDict && [[itemSubTasksDict allKeys] count] ? [itemSubTasksDict allKeys][indexPath.row] : @"";
        NSString *userID = @"";
        NSString *lastCompletedKey = @"";
        
        if (itemSubTasksDict && itemSubTasksDict[subTaskName] && itemSubTasksDict[subTaskName][arrayKey] && [(NSArray *)[itemSubTasksDict[subTaskName][arrayKey] allKeys] count] > 0) {
            
            lastCompletedKey = [itemSubTasksDict[subTaskName][arrayKey] allKeys][0];
            
        }
        
        userID = itemSubTasksDict[subTaskName][arrayKey][lastCompletedKey][@"Marked By"] ? itemSubTasksDict[subTaskName][arrayKey][lastCompletedKey][@"Marked By"] : @"";
        
        NSString *usernameString = @"";
        
        if ([_homeMembersDict[@"UserID"] containsObject:userID]) {
            
            NSDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:userID homeMembersDict:_homeMembersDict];
            usernameString = [NSString stringWithFormat:@" by %@", dataDict[@"Username"]];
            
        } else if ([itemCreatedBy isEqualToString:userID]) {
            
            usernameString = [NSString stringWithFormat:@" by %@", itemCreatedByUsername];
            
        }
        
        completedString = [NSString stringWithFormat:@"%@%@", arrayStringKey, usernameString];
        
    } else {
        
        NSString *arrayKey = @"Assigned To";
        
        NSString *subTaskName = [[itemSubTasksDict allKeys] count] > indexPath.row ? [itemSubTasksDict allKeys][indexPath.row] : @"";
        
        NSString *addedString = @"";
        
        if (itemSubTasksDict && itemSubTasksDict[subTaskName] && itemSubTasksDict[subTaskName][arrayKey] && [(NSArray *)itemSubTasksDict[subTaskName][arrayKey] count] > 0) {
            
            NSString *userID = itemSubTasksDict && itemSubTasksDict[subTaskName] && itemSubTasksDict[subTaskName][arrayKey] && [(NSArray *)itemSubTasksDict[subTaskName][arrayKey] count] > 0 ? itemSubTasksDict[subTaskName][arrayKey][0] : @"";
            
            NSDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:userID homeMembersDict:_homeMembersDict];
            NSString *username = dataDict[@"Username"];
            addedString = [username length] > 0 ? [NSString stringWithFormat:@" • Assigned to %@", username] : @"";
            
        }
        
        completedString = [NSString stringWithFormat:@"Uncompleted%@", addedString];
        
    }
    
    if (SubtaskIsRequestingApprovalPending == YES) {
        
        completedString = @"Completion Request Pending";
        
    }
    
    if (SubtaskIsWontDo == YES) {
        
        completedString = @"Won't Do";
        
    }
    
    BOOL TaskPhotoConfirmationNeededForSpecificObject = [[[BoolDataObject alloc] init] TaskPhotoConfirmationNeededForSpecificObject:self->itemDict itemType:self->itemType objectToUse:subtask];
    
    if (TaskPhotoConfirmationNeededForSpecificObject == YES) {
        
        completedString = @"Photo Confirmation Needed";
        
    }
    
    return completedString;
    
}

-(NSString *)GenerateItemCompletedTextSubtaskCellItemCompleteAsNeeded:(NSIndexPath *)indexPath {
    
    NSString *completedString = @"";
    
    NSString *subtask = [[itemSubTasksDict allKeys] count] > indexPath.row ? [itemSubTasksDict allKeys][indexPath.row] : @"";
    
    BOOL SubtaskIsCompleted = [[[BoolDataObject alloc] init] SubtaskIsCompleted:self->itemDict itemType:itemType subtask:subtask];
    BOOL SubtaskIsInProgress = [[[BoolDataObject alloc] init] SubtaskIsInProgress:self->itemDict itemType:itemType subtask:subtask];
    BOOL SubtaskIsWontDo = [[[BoolDataObject alloc] init] SubtaskIsWontDo:self->itemDict itemType:itemType subtask:subtask];
    
    BOOL SubtaskIsRequestingApprovalPending = [[[BoolDataObject alloc] init] SubtaskIsRequestingApprovalPending:self->itemDict itemType:itemType subtask:subtask];
    
    if (SubtaskIsCompleted == YES || SubtaskIsInProgress == YES || SubtaskIsWontDo == YES) {
        
        int countDict = 0;
        
        NSString *subTaskName = [[itemSubTasksDict allKeys] count] > indexPath.row ? [itemSubTasksDict allKeys][indexPath.row] : @"";
        
        for (NSString *userIDKey in [itemSubTasksDict[subTaskName][@"Completed Dict"] allKeys]) {
            
            NSString *userIDKeyCopy = [userIDKey mutableCopy];
            
            if ([userIDKeyCopy containsString:@"•••"] == YES) {
                
                userIDKeyCopy = [[userIDKeyCopy componentsSeparatedByString:@"•••"] count] > 0 ? [userIDKeyCopy componentsSeparatedByString:@"•••"][0] : @"";
                
            }
            
            for (NSString *userID in _homeMembersDict[@"UserID"]) {
                
                if ([userIDKeyCopy isEqualToString:userID]) {
                    
                    countDict += 1;
                    break;
                    
                }
                
            }
            
        }
        
        NSString *completeAsNeededString = @"";
        
        NSString *sString = countDict == 1 ? @"" : @"s";
        
        if (SubtaskIsInProgress == NO) {
            
            completeAsNeededString = [NSString stringWithFormat:@" %d Time%@", countDict, sString];
            
        }
        
        NSString *arrayKey;
        
        if (SubtaskIsCompleted == YES) {
            arrayKey = @"Completed";
        } else if (SubtaskIsInProgress == YES) {
            arrayKey = @"In Progress";
        }
        
        completedString = [NSString stringWithFormat:@"%@%@", arrayKey, completeAsNeededString];
        
    } else {
        
        NSString *arrayKey = @"Assigned To";
        
        NSString *subTaskName = [[itemSubTasksDict allKeys] count] > indexPath.row ? [itemSubTasksDict allKeys][indexPath.row] : @"";
        
        NSString *addedString = @"";
        
        if (itemSubTasksDict && itemSubTasksDict[subTaskName] && itemSubTasksDict[subTaskName][arrayKey] && [(NSArray *)itemSubTasksDict[subTaskName][arrayKey] count] > 0) {
            
            NSString *userID = itemSubTasksDict && itemSubTasksDict[subTaskName] && itemSubTasksDict[subTaskName][arrayKey] && [(NSArray *)itemSubTasksDict[subTaskName][arrayKey] count] > 0 ? itemSubTasksDict[subTaskName][arrayKey][0] : @"";
            
            NSDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:userID homeMembersDict:_homeMembersDict];
            NSString *username = dataDict[@"Username"];
            addedString = [username length] > 0 ? [NSString stringWithFormat:@" • Assigned to %@", username] : @"";
            
        }
        
        completedString = [NSString stringWithFormat:@"Uncompleted%@", addedString];
        
    }
    
    if (SubtaskIsRequestingApprovalPending == YES) {
        
        completedString = @"Completion Request Pending";
        
    }
    
    BOOL TaskPhotoConfirmationNeededForSpecificObject = [[[BoolDataObject alloc] init] TaskPhotoConfirmationNeededForSpecificObject:self->itemDict itemType:self->itemType objectToUse:subtask];
    
    if (TaskPhotoConfirmationNeededForSpecificObject == YES) {
        
        completedString = @"Photo Confirmation Needed";
        
    }
    
    return completedString;
    
}

-(NSString *)GenerateItemCompletedTextListItemCell:(NSIndexPath *)indexPath {
    
    NSString *listItem = [self GenerateDataForSpeificItemAtIndex:indexPath];
   
    BOOL TaskIsTakingTurns = [[[BoolDataObject alloc] init] TaskIsTakingTurns:self->itemDict itemType:itemType];
    
    BOOL ListItemIsCompleted = [[[BoolDataObject alloc] init] ListItemIsCompleted:self->itemDict itemType:itemType listItem:listItem];
    BOOL ListItemIsInProgress = [[[BoolDataObject alloc] init] ListItemIsInProgress:self->itemDict itemType:itemType listItem:listItem];
    BOOL ListItemIsWontDo = [[[BoolDataObject alloc] init] ListItemIsWontDo:self->itemDict itemType:itemType listItem:listItem];
    
    BOOL ListItemIsRequestingApprovalPending = [[[BoolDataObject alloc] init] ListItemIsRequestingApprovalPending:self->itemDict itemType:itemType listItem:listItem];
    
    NSString *completedString = @"";
   
    if (ListItemIsCompleted == YES || ListItemIsInProgress == YES || ListItemIsWontDo == YES) {
        
        NSString *startingLabel = ListItemIsInProgress == YES ? @"In Progress" : @"Completed";
        
        NSString *userID = itemListItems[listItem] && itemListItems[listItem][@"Status"] ? itemListItems[listItem][@"Status"] : @"";
       
        BOOL TaskWasAssignedToSpecificUser = [[[BoolDataObject alloc] init] TaskWasAssignedToSpecificUser:self->itemDict itemType:itemType userID:userID];
        BOOL TaskWasCreatedBySpecificUser = [[[BoolDataObject alloc] init] TaskWasCreatedBySpecificUser:self->itemDict itemType:itemType userID:userID];
        BOOL TaskIsAssignedToNobody = [[[BoolDataObject alloc] init] TaskIsAssignedToNobody:self->itemDict itemType:itemType];
        
        if (TaskWasAssignedToSpecificUser == YES || (TaskIsAssignedToNobody == YES && TaskWasCreatedBySpecificUser == NO)) {
            
            NSDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:userID homeMembersDict:_homeMembersDict];
            
            completedString = [NSString stringWithFormat:@"%@ by %@", startingLabel, dataDict[@"Username"]];
            
        } else if (TaskWasCreatedBySpecificUser == YES) {
            
            completedString = [NSString stringWithFormat:@"%@ by %@", startingLabel, itemCreatedByUsername];
            
        }
        
    } else if ([(NSArray *)itemListItems[listItem][@"Assigned To"] count] > 0 && TaskIsTakingTurns == NO) {
      
        NSString *assignedTo = itemListItems[listItem][@"Assigned To"][0];
        
        if ([assignedTo isEqualToString:@"Anybody"] == NO && [_homeMembersDict[@"UserID"] containsObject:assignedTo]) {
            
            NSDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:assignedTo homeMembersDict:_homeMembersDict];
            NSString *username = dataDict[@"Username"] ? dataDict[@"Username"] : @"";
            completedString = [username length] > 0 ? [NSString stringWithFormat:@"Assigned to %@", username] : @"";
            
        } else if ([itemCreatedBy isEqualToString:assignedTo]) {
            
            completedString = [itemCreatedByUsername length] > 0 ? [NSString stringWithFormat:@"Assigned to %@", itemCreatedByUsername] : @"";
            
        }
   
    } else if (TaskIsTakingTurns == YES) {
        
        NSDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:itemTurnUserID homeMembersDict:_homeMembersDict];
        NSString *username = dataDict[@"Username"] ? dataDict[@"Username"] : @"";
        completedString = [username length] > 0 ? [NSString stringWithFormat:@"%@'s turn to complete", username] : @"";
        
    }
    
    if (ListItemIsRequestingApprovalPending == YES) {
        
        completedString = @"Completion Request Pending";
        
    }
    
    if (ListItemIsWontDo == YES) {
        
        completedString = @"Won't Do";
        
    }
    
    BOOL TaskPhotoConfirmationNeededForSpecificObject = [[[BoolDataObject alloc] init] TaskPhotoConfirmationNeededForSpecificObject:self->itemDict itemType:self->itemType objectToUse:listItem];
    
    if (TaskPhotoConfirmationNeededForSpecificObject == YES) {
        
        completedString = @"Photo Confirmation Needed";
        
    }
  
    return completedString;
}

-(NSString *)GenerateItemCompletedTextListItemCompleteAsNeeded:(NSIndexPath *)indexPath {
    
    NSString *finalString = @"";
    
    NSString *listItem = [self GenerateDataForSpeificItemAtIndex:indexPath];
    
    BOOL ListItemIsCompleted = [[[BoolDataObject alloc] init] ListItemIsCompleted:self->itemDict itemType:itemType listItem:listItem];
    BOOL ListItemIsInProgress = [[[BoolDataObject alloc] init] ListItemIsInProgress:self->itemDict itemType:itemType listItem:listItem];
    BOOL ListItemIsWontDo = [[[BoolDataObject alloc] init] ListItemIsWontDo:self->itemDict itemType:itemType listItem:listItem];
    
    BOOL TaskIsCompleteAsNeeded = [[[BoolDataObject alloc] init] TaskIsCompleteAsNeeded:self->itemDict itemType:itemType];
    BOOL ListItemIsRequestingApprovalPending = [[[BoolDataObject alloc] init] ListItemIsRequestingApprovalPending:self->itemDict itemType:itemType listItem:listItem];
    
    if (ListItemIsCompleted == YES || ListItemIsInProgress == YES || ListItemIsWontDo == YES) {
        
        NSString *completedString = ListItemIsCompleted == YES ? @"Completed" : @"Uncompleted";
        
        NSString *completeAsNeededString = @"";
        
        if (TaskIsCompleteAsNeeded == YES) {
            
            int countDict = 0;
            
            NSMutableDictionary *itemCompletedDictLocal = itemCompletedDict ? [itemCompletedDict mutableCopy] : [NSMutableDictionary dictionary];
            
            for (NSString *userIDKey in [itemCompletedDictLocal allKeys]) {
                
                NSString *userIDKeyCopy = [userIDKey mutableCopy];
                
                if ([userIDKeyCopy containsString:@"•••"] == YES) {
                    
                    userIDKeyCopy = [[userIDKeyCopy componentsSeparatedByString:@"•••"] count] > 0 ? [userIDKeyCopy componentsSeparatedByString:@"•••"][0] : @"";
                    
                }
                
                if ([userIDKeyCopy isEqualToString:listItem]) {
                    
                    countDict += 1;
                    
                }
                
            }
            
            NSString *sString = countDict == 1 ? @"" : @"s";
            
            int countToUse = countDict;
            
            completeAsNeededString = countDict != 0 ? [NSString stringWithFormat:@" %d Time%@", countToUse, sString] : @"";
            
        }
        
        if (ListItemIsInProgress == YES) {
            
            completedString = @"In Progress";
            
            completeAsNeededString = @"";
            
        }
        
        NSString *finalCompletedString = [NSString stringWithFormat:@"%@%@", completedString, completeAsNeededString];
        
        finalString = finalCompletedString;
        
    } else if ([(NSArray *)itemListItems[listItem][@"Assigned To"] count] > 0) {
        
        NSString *assignedTo = itemListItems[listItem][@"Assigned To"][0];
        
        if ([assignedTo isEqualToString:@"Anybody"] == NO && [_homeMembersDict[@"UserID"] containsObject:assignedTo]) {
            
            NSUInteger index = [_homeMembersDict[@"UserID"] indexOfObject:assignedTo];
            NSString *username = _homeMembersDict[@"Username"][index];
            finalString = [username length] > 0 ? [NSString stringWithFormat:@"Assigned to %@", username] : @"";
            
        } else if ([itemCreatedBy isEqualToString:assignedTo]) {
            
            finalString = [itemCreatedByUsername length] > 0 ? [NSString stringWithFormat:@"Assigned to %@", itemCreatedByUsername] : @"";
            
        }
        
    }
    
    if (ListItemIsRequestingApprovalPending == YES) {
        
        finalString = @"Completion Request Pending";
        
    }
    
    BOOL TaskPhotoConfirmationNeededForSpecificObject = [[[BoolDataObject alloc] init] TaskPhotoConfirmationNeededForSpecificObject:self->itemDict itemType:self->itemType objectToUse:listItem];
    
    if (TaskPhotoConfirmationNeededForSpecificObject == YES) {
        
        finalString = @"Photo Confirmation Needed";
        
    }
    
    return finalString;
    
}

-(NSString *)GenerateItemCompletedTextItemizedItemCell:(NSIndexPath *)indexPath {
    
    NSString *itemizedItem = [self GenerateDataForSpeificItemAtIndex:indexPath];
    
    BOOL TaskIsTakingTurns = [[[BoolDataObject alloc] init] TaskIsTakingTurns:self->itemDict itemType:itemType];
    
    BOOL ItemizedItemIsCompleted = [[[BoolDataObject alloc] init] ItemizedItemIsCompleted:self->itemDict itemType:itemType itemizedItem:itemizedItem];
    BOOL ItemizedItemIsInProgress = [[[BoolDataObject alloc] init] ItemizedItemIsInProgress:self->itemDict itemType:itemType itemizedItem:itemizedItem];
    BOOL ItemizedItemIsWontDo = [[[BoolDataObject alloc] init] ItemizedItemIsWontDo:self->itemDict itemType:itemType itemizedItem:itemizedItem];
    
    BOOL ItemizedItemIsRequestingApprovalPending = [[[BoolDataObject alloc] init] ItemizedItemIsRequestingApprovalPending:self->itemDict itemType:itemType itemizedItem:itemizedItem];
    
    NSString *completedString = @"";
    NSString *assignedToString = @"";
    
    if (ItemizedItemIsCompleted == YES || ItemizedItemIsInProgress == YES || ItemizedItemIsWontDo == YES) {
      
        NSString *startingLabel = ItemizedItemIsInProgress == YES ? @"In Progress" : @"Completed";
        
        NSString *userID = itemItemizedItems[itemizedItem] && itemItemizedItems[itemizedItem][@"Status"] ? itemItemizedItems[itemizedItem][@"Status"] : @"";
       
        BOOL TaskWasAssignedToSpecificUser = [[[BoolDataObject alloc] init] TaskWasAssignedToSpecificUser:self->itemDict itemType:itemType userID:userID];
        BOOL TaskWasCreatedBySpecificUser = [[[BoolDataObject alloc] init] TaskWasCreatedBySpecificUser:self->itemDict itemType:itemType userID:userID];
        BOOL TaskIsAssignedToNobody = [[[BoolDataObject alloc] init] TaskIsAssignedToNobody:self->itemDict itemType:itemType];
        
        if (TaskWasAssignedToSpecificUser == YES || (TaskIsAssignedToNobody == YES && TaskWasCreatedBySpecificUser == NO)) {
            
            NSDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:userID homeMembersDict:_homeMembersDict];
            
            completedString = [NSString stringWithFormat:@" • %@ by %@", startingLabel, dataDict[@"Username"]];
            
        } else if (TaskWasCreatedBySpecificUser == YES) {
            
            completedString = [NSString stringWithFormat:@" • %@ by %@", startingLabel, itemCreatedByUsername];
            
        }
//Itemied Doesn't Have Assigned To
//    } else if ([(NSArray *)itemItemizedItems[itemizedItem][@"Assigned To"] count] > 0) {
//
//        NSString *assignedTo = itemItemizedItems[itemizedItem] && itemItemizedItems[itemizedItem][@"Assigned To"] && [(NSArray *)itemItemizedItems[itemizedItem][@"Assigned To"] count] > 0 ? itemItemizedItems[itemizedItem][@"Assigned To"][0] : @"";
//        
//        if ([assignedTo isEqualToString:@"Anybody"] == NO && [_homeMembersDict[@"UserID"] containsObject:assignedTo]) {
//            
//            NSUInteger index = [_homeMembersDict[@"UserID"] indexOfObject:assignedTo];
//            NSString *username = _homeMembersDict[@"Username"][index];
//            assignedToString = [username length] > 0 ? [NSString stringWithFormat:@" • Assigned to %@", username] : @"";
//            
//        } else if ([itemCreatedBy isEqualToString:assignedTo]) {
//            
//            assignedToString = [itemCreatedByUsername length] > 0 ? [NSString stringWithFormat:@" • Assigned to %@", itemCreatedByUsername] : @"";
//            
//        }
//        
    } else if (TaskIsTakingTurns == YES) {
       
        NSDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:itemTurnUserID homeMembersDict:_homeMembersDict];
        NSString *username = dataDict[@"Username"] ? dataDict[@"Username"] : @"";
        completedString = [username length] > 0 ? [NSString stringWithFormat:@" • %@'s turn to complete", username] : @"";
        
    }
    
    if (ItemizedItemIsRequestingApprovalPending == YES) {
        
        completedString = @" • Completion Request Pending";
        
    }
    
    if (ItemizedItemIsWontDo == YES) {
        
        completedString = @" • Won't Do";
        
    }
    
    id amount = itemItemizedItems[itemizedItem] && itemItemizedItems[itemizedItem][@"Amount"] ? itemItemizedItems[itemizedItem][@"Amount"] : @"";
    
    BOOL ObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:amount classArr:@[[NSArray class], [NSMutableArray class]]];
    
    if (ObjectIsKindOfClass == YES) {
        amount = [(NSArray *)amount count] > 0 ? amount[0] : [NSString stringWithFormat:@"0%@00", localCurrencyDecimalSeparatorSymbol];
    }
    
    NSString *finalString = [NSString stringWithFormat:@"%@%@%@", amount, completedString, assignedToString];
  
    BOOL TaskPhotoConfirmationNeededForSpecificObject = [[[BoolDataObject alloc] init] TaskPhotoConfirmationNeededForSpecificObject:self->itemDict itemType:self->itemType objectToUse:itemizedItem];
    
    if (TaskPhotoConfirmationNeededForSpecificObject == YES) {
        
        finalString = @"Photo Confirmation Needed";
        
    }
    
    return finalString;
    
}

-(NSString *)GenerateItemCompletedTextItemizedItemCompleteAsNeeded:(NSIndexPath *)indexPath {
    
    NSString *completedString = @"";
    NSString *assignedToString = @"";
    
    NSString *itemizedItem = [self GenerateDataForSpeificItemAtIndex:indexPath];
    
    BOOL ItemizedItemIsCompleted = [[[BoolDataObject alloc] init] ItemizedItemIsCompleted:self->itemDict itemType:itemType itemizedItem:itemizedItem];
    BOOL ItemizedItemIsInProgress = [[[BoolDataObject alloc] init] ItemizedItemIsInProgress:self->itemDict itemType:itemType itemizedItem:itemizedItem];
    BOOL ItemizedItemIsWontDo = [[[BoolDataObject alloc] init] ItemizedItemIsWontDo:self->itemDict itemType:itemType itemizedItem:itemizedItem];
    
    BOOL TaskIsCompleteAsNeeded = [[[BoolDataObject alloc] init] TaskIsCompleteAsNeeded:self->itemDict itemType:itemType];
    BOOL ItemizedItemIsRequestingApprovalPending = [[[BoolDataObject alloc] init] ItemizedItemIsRequestingApprovalPending:self->itemDict itemType:itemType itemizedItem:itemizedItem];
    
    if (ItemizedItemIsCompleted == YES || ItemizedItemIsInProgress == YES || ItemizedItemIsWontDo == YES) {
        
        completedString = ItemizedItemIsCompleted == YES ? @" • Completed" : @" • Uncompleted";
        
        NSString *completeAsNeededString = @"";
        
        if (TaskIsCompleteAsNeeded == YES) {
            
            int countDict = 0;
            
            NSMutableDictionary *itemCompletedDictLocal = itemCompletedDict ? [itemCompletedDict mutableCopy] : [NSMutableDictionary dictionary];
            
            for (NSString *userIDKey in [itemCompletedDictLocal allKeys]) {
                
                NSString *userIDKeyCopy = [userIDKey mutableCopy];
                
                if ([userIDKeyCopy containsString:@"•••"] == YES) {
                    
                    userIDKeyCopy = [[userIDKeyCopy componentsSeparatedByString:@"•••"] count] > 0 ? [userIDKeyCopy componentsSeparatedByString:@"•••"][0] : @"";
                    
                }
                
                if ([userIDKeyCopy isEqualToString:itemizedItem]) {
                    
                    countDict += 1;
                    
                }
                
            }
            
            NSString *sString = countDict == 1 ? @"" : @"s";
            
            int countToUse = countDict;
            
            completeAsNeededString = countDict != 0 ? [NSString stringWithFormat:@" %d Time%@", countToUse, sString] : @"";
            
        }
        
        if (ItemizedItemIsInProgress == YES) {
            
            completedString = @" • In Progress";
            
            completeAsNeededString = @"";
            
        }
        
        NSString *finalCompletedString = [NSString stringWithFormat:@"%@%@", completedString, completeAsNeededString];
        
        completedString = finalCompletedString;
        
    } else if ([(NSArray *)itemItemizedItems[itemizedItem][@"Assigned To"] count] > 0) {
        
        NSString *assignedTo = itemItemizedItems[itemizedItem] && itemItemizedItems[itemizedItem][@"Assigned To"] && [(NSArray *)itemItemizedItems[itemizedItem][@"Assigned To"] count] > 0 ? itemItemizedItems[itemizedItem][@"Assigned To"][0] : @"";
        
        if ([assignedTo isEqualToString:@"Anybody"] == NO && [_homeMembersDict[@"UserID"] containsObject:assignedTo]) {
            
            NSUInteger index = [_homeMembersDict[@"UserID"] indexOfObject:assignedTo];
            NSString *username = _homeMembersDict[@"Username"][index];
            assignedToString = [username length] > 0 ? [NSString stringWithFormat:@" • Assigned to %@", username] : @"";
            
        } else if ([itemCreatedBy isEqualToString:assignedTo]) {
            
            assignedToString = [itemCreatedByUsername length] > 0 ? [NSString stringWithFormat:@" • Assigned to %@", itemCreatedByUsername] : @"";
            
        }
        
    }
    
    if (ItemizedItemIsRequestingApprovalPending == YES) {
        
        completedString = @" • Completion Request Pending";
        
    }
    
    if (ItemizedItemIsWontDo == YES) {
        
        completedString = @" • Won't Do";
        
    }
    
    id amount = itemItemizedItems[itemizedItem] && itemItemizedItems[itemizedItem][@"Amount"] ? itemItemizedItems[itemizedItem][@"Amount"] : @"";
    
    BOOL ObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:amount classArr:@[[NSArray class], [NSMutableArray class]]];
    
    if (ObjectIsKindOfClass == YES) {
        amount = [(NSArray *)amount count] > 0 ? amount[0] : [NSString stringWithFormat:@"0%@00", localCurrencyDecimalSeparatorSymbol];
    }
    
    NSString *finalString = [NSString stringWithFormat:@"%@%@%@", amount, completedString, assignedToString];
    
    BOOL TaskPhotoConfirmationNeededForSpecificObject = [[[BoolDataObject alloc] init] TaskPhotoConfirmationNeededForSpecificObject:self->itemDict itemType:self->itemType objectToUse:itemizedItem];
    
    if (TaskPhotoConfirmationNeededForSpecificObject == YES) {
        
        finalString = @"Photo Confirmation Needed";
        
    }
    
    return finalString;
    
}

-(void)GenerateItemAssignedToImage:(UIImageView *)imageViewToCheck indexPath:(NSIndexPath *)indexPath {
    
    UIColor *backgroundColor = [[[GeneralObject alloc] init] GenerateAppColor:0.15f];
    UIColor *textColor = [[[GeneralObject alloc] init] GenerateAppColor:1.0f];
    
    NSMutableDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:itemAssignedToArray[indexPath.row] homeMembersDict:_homeMembersDict];
    NSString *username = dataDict[@"Username"];
    NSString *profileImageURL = dataDict[@"ProfileImageURL"];
    
    BOOL CustomProfileImageDoesNotExist = (profileImageURL == nil || profileImageURL.length == 0 || [profileImageURL containsString:@"(null)"] || [profileImageURL isEqualToString:@"xxx"] || [profileImageURL isEqualToString:@"XXX"] || [profileImageURL isEqualToString:@"https://firebasestorage.googleapis.com/v0/b/wedivvy-afe04.appspot.com/o/DefaultImages%2FdefaultProfileImage.png?alt=media&token=6892f430-8337-4327-89a4-53a403d1186c"] || [profileImageURL containsString:@"DefaultImage"]) == YES;
    
    if (CustomProfileImageDoesNotExist == YES) {
        
        [imageViewToCheck setImageWithString:username color:backgroundColor circular:YES textAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Futura-Medium" size:imageViewToCheck.frame.size.height*0.45], NSForegroundColorAttributeName:textColor}];
        
    } else {
        
        [imageViewToCheck sd_setImageWithURL:[NSURL URLWithString:profileImageURL]];
        
    }
    
}

-(void)GenerateUserAlertLabelAndImage:(NSIndexPath *)indexPath cell:(ViewTaskCell *)cell {
    
    NSMutableDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:itemAssignedToArray[indexPath.row] homeMembersDict:_homeMembersDict];
    NSString *username = dataDict[@"Username"];
    
    dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"Username" object:username homeMembersDict:_homeMembersDict];
    NSString *notification = dataDict[@"Notifications"];
    NSString *email = dataDict[@"Email"];
    
    BOOL UserHasNotificationTurnedOff = [notification isEqualToString:@"No"];
    BOOL UserHasJoinedHome = [email length] > 0;
    
    if (UserHasNotificationTurnedOff == YES && UserHasJoinedHome == YES) {
        cell.userAlertLabel.text = @"This user has their notifications turned off.";
        cell.userAlertImage.image = [UIImage systemImageNamed:@"exclamationmark.circle.fill"];
        cell.userAlertLabel.hidden = NO;
        cell.userAlertImage.hidden = NO;
    } else if (UserHasJoinedHome == NO) {
        cell.userAlertLabel.text = @"This user has not joined your home yet.";
        cell.userAlertImage.image = [UIImage systemImageNamed:@"exclamationmark.triangle.fill"];
        cell.userAlertLabel.hidden = NO;
        cell.userAlertImage.hidden = NO;
    }
    
}

#pragma mark - TableView Methods, willDisplayCell

-(void)ChoreCellFrame:(UITableView *)tableView cell:(ViewTaskCell *)cell indexPath:(NSIndexPath *)indexPath {
    
    CGFloat height = CGRectGetHeight(cell.contentView.bounds);
    CGFloat width = CGRectGetWidth(cell.contentView.bounds);
    
    NSMutableDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:itemAssignedToArray[indexPath.row] homeMembersDict:_homeMembersDict];
    NSString *objectToUse = dataDict[@"UserID"];
    
    
    
    
    
    
    [self GenerateAlterateCheckmarkViewBackgroundColorUserCell:indexPath cell:cell];
    
    
    
    
    
    
    BOOL TaskCanBeCompletedInViewTaskBySpecificUser = [[[BoolDataObject alloc] init] TaskCanBeCompletedInViewTaskBySpecificUser:self->itemDict itemType:itemType userID:objectToUse homeMembersDict:_homeMembersDict];
    
    cell.ellipsisImage.hidden = TaskCanBeCompletedInViewTaskBySpecificUser ? NO : YES;
    cell.ellipsisImageOverlay.hidden = TaskCanBeCompletedInViewTaskBySpecificUser ? NO : YES;
    cell.ellipsisImage.userInteractionEnabled = TaskCanBeCompletedInViewTaskBySpecificUser ? YES : NO;
    cell.ellipsisImageOverlay.userInteractionEnabled = TaskCanBeCompletedInViewTaskBySpecificUser ? YES : NO;
    cell.ellipsisImage.image = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [UIImage imageNamed:@"GeneralIcons.Ellipsis.White"] : [UIImage imageNamed:@"GeneralIcons.Ellipsis"];
    
    
    
    
    
    
    cell.titleLabel.textColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ?  [[[LightDarkModeObject alloc] init] DarkModeTextPrimary] : [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
    cell.titleLabel.alpha = 1;
    
    
    
    
    
    
    NSDictionary *progressBarDict = [self GenerateCompletionRatePercentageBackgroundColorAndWidth:totalCompletedArray indexPath:indexPath width:width];
    cell.progressBarTwo.backgroundColor = progressBarDict[@"BackgroundColor"];
    
    
    
    
    
    cell.subLabel.alpha = ViewingAnalytics ? 0.0f : 1.0f;
    cell.progressBarOne.alpha = ViewingAnalytics ? 1.0f : 0.0f;
    cell.progressBarTwo.alpha = ViewingAnalytics ? 1.0f : 0.0f;
    cell.percentageLabel.alpha = ViewingAnalytics ? 1.0f : 0.0f;
    
    
    
    
    //Post-Spike
    dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:itemAssignedToArray[indexPath.row] homeMembersDict:_homeMembersDict];
    NSString *userID = dataDict[@"UserID"];
    
    BOOL UserIsMe = ([userID isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]]);
    BOOL TaskAlreadyCompleted = [[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:self->itemCompletedDict userIDToFind:userID];
    BOOL TaskIsCompleteAsNeeded = [[[BoolDataObject alloc] init] TaskIsCompleteAsNeeded:self->itemDict itemType:itemType];
    
    
    
    
    //Post-Spike
    cell.mainView.frame = CGRectMake(width*0.5 - ((width*0.90338164)*0.5), 0, width*0.90338164, height - spacingBetweenCells);
    cell.mainViewOverlay.frame = CGRectMake(cell.mainView.frame.origin.x, cell.mainView.frame.origin.y, cell.mainView.frame.size.width*0.785, cell.mainView.frame.size.height);
    
    cell.mainViewOverlay.hidden = YES;
    
    if (TaskCanBeCompletedInViewTaskBySpecificUser == YES && UserIsMe == NO && (TaskAlreadyCompleted == NO || TaskIsCompleteAsNeeded == YES)) {
        
        [self SetUpSomeoneElseContextMenu:indexPath cell:cell];
        cell.mainViewOverlay.hidden = NO;
        
    }
    
    
    
    
    //Post-Spike
    height = CGRectGetHeight(cell.mainView.bounds);
    width = CGRectGetWidth(cell.mainView.bounds);
    
    CGFloat spacing = width*0.04278075;
    
    cell.alternateCheckmarkView.frame = CGRectMake(spacing, 8, (cell.contentView.frame.size.height*0.24691358 > 14?(14):cell.contentView.frame.size.height*0.24691358), (cell.contentView.frame.size.height*0.24691358 > 14?(14):cell.contentView.frame.size.height*0.24691358));
    cell.profileImage.frame = CGRectMake(cell.alternateCheckmarkView.frame.origin.x + cell.alternateCheckmarkView.frame.size.width + spacing*0.5, 8, (cell.contentView.frame.size.height*0.43859 > 25?(25):cell.contentView.frame.size.height*0.43859), (cell.contentView.frame.size.height*0.43859 > 25?(25):cell.contentView.frame.size.height*0.43859));
    
    cell.titleLabel.frame = CGRectMake(cell.profileImage.frame.origin.x + cell.profileImage.frame.size.width + spacing*0.5, primaryLabelSpacingHeight, width*0.772727, titleLabelHeight);
    
    cell.subLabel.frame = CGRectMake(cell.titleLabel.frame.origin.x, cell.titleLabel.frame.origin.y + cell.titleLabel.frame.size.height + secondaryLabelSpacingHeight, cell.titleLabel.frame.size.width, subLabelHeight);
    cell.subLabel.numberOfLines = 0;

    CGRect newRect = cell.alternateCheckmarkView.frame;
    newRect.origin.y = cell.titleLabel.frame.origin.y + ((cell.titleLabel.frame.size.height + secondaryLabelSpacingHeight + cell.subLabel.frame.size.height)*0.5 - newRect.size.height*0.5);
    cell.alternateCheckmarkView.frame = newRect;
    
    newRect = cell.profileImage.frame;
    newRect.origin.y = cell.alternateCheckmarkView.frame.origin.y + (cell.alternateCheckmarkView.frame.size.height*0.5 - newRect.size.height*0.5);
    cell.profileImage.frame = newRect;
    
    cell.userAlertImage.frame = CGRectMake(cell.profileImage.frame.origin.x + (cell.profileImage.frame.size.width*0.5 - ((cell.contentView.frame.size.height*0.24691358 > 14?(14):cell.contentView.frame.size.height*0.24691358))*0.5), cell.subLabel.frame.origin.y + cell.subLabel.frame.size.height + secondaryLabelSpacingHeight, (cell.contentView.frame.size.height*0.28070175 > 16?(16):cell.contentView.frame.size.height*0.28070175), (cell.contentView.frame.size.height*0.28070175 > 16?(16):cell.contentView.frame.size.height*0.28070175));
    cell.userAlertLabel.frame = CGRectMake(cell.titleLabel.frame.origin.x, cell.subLabel.frame.origin.y + cell.subLabel.frame.size.height + secondaryLabelSpacingHeight, cell.titleLabel.frame.size.width, alertLabelHeight);
    
    newRect = cell.userAlertImage.frame;
    newRect.origin.y = cell.userAlertLabel.frame.origin.y + (cell.userAlertLabel.frame.size.height*0.5 - newRect.size.height*0.5);
    cell.userAlertImage.frame = newRect;
    
    cell.titleLabel.font = [UIFont systemFontOfSize:cell.titleLabel.frame.size.height*0.75 weight:UIFontWeightSemibold];
    cell.subLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightSemibold];
    cell.userAlertLabel.font = [UIFont systemFontOfSize:cell.userAlertLabel.frame.size.height*0.75 weight:UIFontWeightSemibold];
    
    
    
    
    
    
    NSString *markedObject = [self GenerateDataForSpeificItemAtIndex:indexPath];
    
    BOOL ConfirmationImageExists = itemPhotoConfirmationDict[markedObject] ? YES : NO;
    
    cell.photoConfirmationImage.contentMode = UIViewContentModeScaleAspectFill;
    cell.photoConfirmationImage.hidden = ConfirmationImageExists ? NO : YES;
    
    if (ConfirmationImageExists) {
        
        [[[GetDataObject alloc] init] GetDataItemImage:self->itemPhotoConfirmationDict[markedObject][@"Image URL"] completionHandler:^(BOOL finished, NSURL * _Nonnull itemImageURL) {
            
            NSData *data = [NSData dataWithContentsOfURL:itemImageURL];
            UIImage *image = [UIImage imageWithData:data];
            
            cell.photoConfirmationImage.image = image;
            
        }];
        
    }
    
    
    
    
    
    
    cell.progressBarOne.frame = CGRectMake(cell.titleLabel.frame.origin.x, cell.subLabel.frame.origin.y + (cell.subLabel.frame.size.height*0.5 - 5*0.5), (width*0.2 > 69?(69):width*0.2), 5);
    cell.progressBarTwo.frame = CGRectMake(cell.progressBarOne.frame.origin.x, cell.progressBarOne.frame.origin.y, [progressBarDict[@"Width"] floatValue], cell.progressBarOne.frame.size.height);
    cell.percentageLabel.frame = CGRectMake(cell.progressBarOne.frame.origin.x + cell.progressBarOne.frame.size.width + 8, cell.subLabel.frame.origin.y, width - (cell.progressBarOne.frame.origin.x + cell.progressBarOne.frame.size.width + 8), cell.subLabel.frame.size.height);
    
    cell.percentageLabel.font = cell.subLabel.font;
    
    
    
    
    
    
    cell.ellipsisImage.frame = CGRectMake(width - (((cell.contentView.frame.size.height*0.43859 > 25?(25):cell.contentView.frame.size.height*0.43859))*0.24) - (width*0.04278075), cell.mainView.frame.size.height*0.5 - (((cell.contentView.frame.size.height*0.43859 > 25?(25):cell.contentView.frame.size.height*0.43859))*0.5), (((cell.contentView.frame.size.height*0.43859 > 25?(25):cell.contentView.frame.size.height*0.43859))*0.24), (cell.contentView.frame.size.height*0.43859 > 25?(25):cell.contentView.frame.size.height*0.43859));
    cell.ellipsisImageOverlay.frame = CGRectMake(cell.ellipsisImage.frame.origin.x - (width*0.125), cell.ellipsisImage.frame.origin.y - (width*0.026738), cell.ellipsisImage.frame.size.width + ((width*0.075)*2), cell.ellipsisImage.frame.size.height + ((width*0.026738)*2));
    cell.ellipsisImage.image = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [UIImage imageNamed:@"GeneralIcons.Ellipsis.White"] : [UIImage imageNamed:@"GeneralIcons.Ellipsis"];
    
    
    
    
    
    
    cell.photoConfirmationImage.backgroundColor = _viewItemImageView.backgroundColor;
    cell.photoConfirmationImage.frame = CGRectMake(cell.ellipsisImage.frame.origin.x - (cell.contentView.frame.size.height*0.43859 > 25?(25):cell.contentView.frame.size.height*0.43859) - spacing*0.5, cell.mainView.frame.size.height*0.5 - (((cell.contentView.frame.size.height*0.43859 > 25?(25):cell.contentView.frame.size.height*0.43859))*0.5), (cell.contentView.frame.size.height*0.43859 > 25?(25):cell.contentView.frame.size.height*0.43859), (cell.contentView.frame.size.height*0.43859 > 25?(25):cell.contentView.frame.size.height*0.43859));
    cell.photoConfirmationImage.layer.cornerRadius = (cell.photoConfirmationImage.frame.size.height*0.2181818182);
    
    
    
    
    
    
    cell.checkmarkView.hidden = YES;
    cell.checkmarkView.userInteractionEnabled = NO;
    
    
    
    
    
    
    maxSubLabelWidth =
    cell.photoConfirmationImage.hidden == YES ?
    width - cell.titleLabel.frame.origin.x - (width - cell.ellipsisImage.frame.origin.x) - spacing*0.5 :
    width - cell.titleLabel.frame.origin.x - (width - cell.photoConfirmationImage.frame.origin.x) - spacing*0.5;
    
    
    
    
    
    
    CGFloat widthOfItemLabel = [[[GeneralObject alloc] init] WidthOfString:cell.titleLabel.text withFont:cell.titleLabel.font];
    CGFloat widthOfUserAlertLabel = [[[GeneralObject alloc] init] WidthOfString:cell.userAlertLabel.text withFont:cell.userAlertLabel.font];
    
    newRect = cell.titleLabel.frame;
    newRect.size.width = widthOfItemLabel > maxSubLabelWidth ? maxSubLabelWidth : widthOfItemLabel;
    cell.titleLabel.frame = newRect;
    
    newRect = cell.subLabel.frame;
    newRect.size.width = maxSubLabelWidth;
    cell.subLabel.frame = newRect;
    
    newRect = cell.userAlertLabel.frame;
    newRect.size.width = widthOfUserAlertLabel > maxSubLabelWidth ? maxSubLabelWidth : widthOfUserAlertLabel;
    cell.userAlertLabel.frame = newRect;
    
    cell.premiumImage.frame = CGRectMake(cell.titleLabel.frame.origin.x + cell.titleLabel.frame.size.width + 6, cell.titleLabel.frame.origin.y, cell.titleLabel.frame.size.height*0.7, cell.titleLabel.frame.size.height);
    
    BOOL PremiumSubscriptionIsActiveForSpecificUserAtIndex = [[[BoolDataObject alloc] init] PremiumSubscriptionIsActiveForSpecificUserAtIndex:_homeMembersDict userID:objectToUse];
    cell.premiumImage.hidden = PremiumSubscriptionIsActiveForSpecificUserAtIndex ? NO : YES;
    
    
    
    
    
    
    int lineCount = [[[GeneralObject alloc] init] LineCountForText:cell.subLabel.text label:cell.subLabel];
    
    newRect = cell.subLabel.frame;
    newRect.size.height = lineCount*subLabelHeight;
    cell.subLabel.frame = newRect;
    
    
    
    
    
    
    newRect = cell.userAlertLabel.frame;
    newRect.origin.y = cell.subLabel.frame.origin.y + cell.subLabel.frame.size.height + secondaryLabelSpacingHeight;
    cell.userAlertLabel.frame = newRect;
    
    
    
    
    
    
    BOOL TaskPhotoConfirmationNeededForSpecificObject = [[[BoolDataObject alloc] init] TaskPhotoConfirmationNeededForSpecificObject:self->itemDict itemType:self->itemType objectToUse:objectToUse];
    
    if (TaskPhotoConfirmationNeededForSpecificObject == YES) {
        
        CGFloat Imageheight = 94;
        
        cell.itemPastDueImage.frame = CGRectMake(cell.titleLabel.frame.origin.x, cell.subLabel.frame.origin.y, (Imageheight*0.15957447 > 15?(15):Imageheight*0.15957447), cell.subLabel.frame.size.height);
        
        CGRect newRect = cell.subLabel.frame;
        newRect.origin.x = cell.itemPastDueImage.frame.origin.x + cell.itemPastDueImage.frame.size.width + ((cell.contentView.frame.size.width*0.04278075)*0.25);
        cell.subLabel.frame = newRect;
        
    } else {
        
        cell.itemPastDueImage.hidden = YES;
        
    }
 
}

-(void)SubtaskCellFrames:(UITableView *)tableView cell:(ViewTaskCell *)cell indexPath:(NSIndexPath *)indexPath {
    
    CGFloat height = CGRectGetHeight(cell.contentView.bounds);
    CGFloat width = CGRectGetWidth(cell.contentView.bounds);
    
    NSArray *keysArray = [itemSubTasksDict allKeys];
    NSArray *sortedKeysArray = [keysArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    NSString *subtaskItem = [sortedKeysArray count] > indexPath.row ? sortedKeysArray[indexPath.row] : @"";
    
    NSString *objectToUse = subtaskItem;
    
    
    
    
    
    
    [self GenerateAlterateCheckmarkViewBackgroundColorSubtaskCell:indexPath cell:cell];
    
    
    
    
    
    
    BOOL TaskCanBeCompletedInViewTaskBySpecificUser = [[[BoolDataObject alloc] init] TaskCanBeCompletedInViewTaskBySpecificUser:self->itemDict itemType:itemType userID:objectToUse homeMembersDict:_homeMembersDict];
    
    cell.ellipsisImage.hidden = TaskCanBeCompletedInViewTaskBySpecificUser ? NO : YES;
    cell.ellipsisImageOverlay.hidden = TaskCanBeCompletedInViewTaskBySpecificUser ? NO : YES;
    cell.ellipsisImage.userInteractionEnabled = TaskCanBeCompletedInViewTaskBySpecificUser ? YES : NO;
    cell.ellipsisImageOverlay.userInteractionEnabled = TaskCanBeCompletedInViewTaskBySpecificUser ? YES : NO;
    cell.ellipsisImage.image = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [UIImage imageNamed:@"GeneralIcons.Ellipsis.White"] : [UIImage imageNamed:@"GeneralIcons.Ellipsis"];
    
    
    
    
    
    
    cell.titleLabel.textColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ?  [[[LightDarkModeObject alloc] init] DarkModeTextPrimary] : [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
    cell.titleLabel.alpha = 1;
    
    
    
    
    
    
    NSDictionary *progressBarDict = [self GenerateCompletionRatePercentageBackgroundColorAndWidth:totalCompletedArray indexPath:indexPath width:width];
    cell.progressBarTwo.backgroundColor = progressBarDict[@"BackgroundColor"];
    
    
    
    
    
    cell.subLabel.alpha = ViewingAnalytics ? 0.0f : 1.0f;
    cell.progressBarOne.alpha = ViewingAnalytics ? 1.0f : 0.0f;
    cell.progressBarTwo.alpha = ViewingAnalytics ? 1.0f : 0.0f;
    cell.percentageLabel.alpha = ViewingAnalytics ? 1.0f : 0.0f;
    
    
    
    
    
    cell.mainView.frame = CGRectMake(self.view.frame.size.width - ((width*0.90338164)*0.85) - (width*0.5 - ((width*0.90338164)*0.5)), 0, (width*0.90338164)*0.85, height - spacingBetweenCells);
    cell.mainViewOverlay.hidden = YES;
    
    
    
    
    
    height = CGRectGetHeight(cell.mainView.bounds);
    width = CGRectGetWidth(cell.mainView.bounds);
    
    CGFloat spacing = width*0.04278075;
    
    cell.checkmarkView.frame = CGRectMake(spacing, height*0.5 - ((height*0.24691358)*0.5), height*0.24691358, height*0.24691358);
    cell.checkmarkView.layer.cornerRadius = cell.checkmarkView.frame.size.height/3;
    
    cell.titleLabel.frame = CGRectMake(cell.checkmarkView.frame.origin.x + cell.checkmarkView.frame.size.width + spacing, cell.checkmarkView.frame.origin.y + cell.checkmarkView.frame.size.height*0.5 - (height*0.350878), width*0.772727, height*0.350878);
    cell.subLabel.frame = CGRectMake(cell.titleLabel.frame.origin.x, cell.checkmarkView.frame.origin.y + cell.checkmarkView.frame.size.height*0.5, cell.titleLabel.frame.size.width, cell.titleLabel.frame.size.height);
  
    cell.userAlertImage.frame = CGRectMake(cell.checkmarkView.frame.origin.x + (cell.checkmarkView.frame.size.width*0.5 - (height*0.24691358)*0.5), cell.subLabel.frame.origin.y + cell.subLabel.frame.size.height + height*0.07017544, height*0.28070175, height*0.28070175);
    cell.userAlertLabel.frame = CGRectMake(cell.titleLabel.frame.origin.x, cell.userAlertImage.frame.origin.y, cell.titleLabel.frame.size.width, cell.userAlertImage.frame.size.height);
    
    cell.titleLabel.font = [UIFont systemFontOfSize:cell.titleLabel.frame.size.height*0.75 weight:UIFontWeightSemibold];
    cell.subLabel.font = [UIFont systemFontOfSize:cell.subLabel.frame.size.height*0.65 weight:UIFontWeightSemibold];
    cell.userAlertLabel.font = [UIFont systemFontOfSize:cell.userAlertLabel.frame.size.height*0.75 weight:UIFontWeightSemibold];
    
    CGFloat widthOfItemLabel = [[[GeneralObject alloc] init] WidthOfString:cell.titleLabel.text withFont:cell.titleLabel.font];
    CGFloat widthOfCompletedLabel = [[[GeneralObject alloc] init] WidthOfString:cell.subLabel.text withFont:cell.subLabel.font];
    
    CGRect newRect = cell.titleLabel.frame;
    newRect.size.width = widthOfItemLabel;
    cell.titleLabel.frame = newRect;
    
    newRect = cell.subLabel.frame;
    newRect.size.width = widthOfCompletedLabel;
    cell.subLabel.frame = newRect;
    
    
    
    
    
    
    cell.progressBarOne.frame = CGRectMake(cell.titleLabel.frame.origin.x, cell.subLabel.frame.origin.y + (cell.subLabel.frame.size.height*0.5 - 5*0.5), (width*0.2 > 69?(69):width*0.2), 5);
    cell.progressBarTwo.frame = CGRectMake(cell.progressBarOne.frame.origin.x, cell.progressBarOne.frame.origin.y, [progressBarDict[@"Width"] floatValue], cell.progressBarOne.frame.size.height);
    cell.percentageLabel.frame = CGRectMake(cell.progressBarOne.frame.origin.x + cell.progressBarOne.frame.size.width + 8, cell.subLabel.frame.origin.y, width - (cell.progressBarOne.frame.origin.x + cell.progressBarOne.frame.size.width + 8), cell.subLabel.frame.size.height);
    
    cell.percentageLabel.font = cell.subLabel.font;
    
    
    
    
    
    
    cell.ellipsisImage.frame = CGRectMake(width - ((height*0.4385965)*0.24) - (width*0.04278075), cell.mainView.frame.size.height*0.5 - ((height*0.4385965)*0.5), ((height*0.4385965)*0.24), height*0.4385965);
    cell.ellipsisImageOverlay.frame = CGRectMake(cell.ellipsisImage.frame.origin.x - (width*0.125), cell.ellipsisImage.frame.origin.y - (width*0.026738), cell.ellipsisImage.frame.size.width + ((width*0.075)*2), cell.ellipsisImage.frame.size.height + ((width*0.026738)*2));
    cell.ellipsisImage.image = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [UIImage imageNamed:@"GeneralIcons.Ellipsis.White"] : [UIImage imageNamed:@"GeneralIcons.Ellipsis"];
    
    
    
    
    
    
    cell.photoConfirmationImage.backgroundColor = _viewItemImageView.backgroundColor;
    cell.photoConfirmationImage.frame = CGRectMake(cell.ellipsisImage.frame.origin.x - height*0.43859 - spacing, height*0.5 - ((height*0.43859)*0.5), height*0.43859, height*0.43859);
    cell.photoConfirmationImage.layer.cornerRadius = (cell.photoConfirmationImage.frame.size.height*0.2181818182);
    
    
    
    
    
    
   BOOL TaskPhotoConfirmationNeededForSpecificObject = [[[BoolDataObject alloc] init] TaskPhotoConfirmationNeededForSpecificObject:self->itemDict itemType:self->itemType objectToUse:objectToUse];
    
    if (TaskPhotoConfirmationNeededForSpecificObject == YES) {
        
        CGFloat Imageheight = 94;
        
        cell.itemPastDueImage.frame = CGRectMake(cell.titleLabel.frame.origin.x, cell.subLabel.frame.origin.y, (Imageheight*0.15957447 > 15?(15):Imageheight*0.15957447), cell.subLabel.frame.size.height);
        
        CGRect newRect = cell.subLabel.frame;
        newRect.origin.x = cell.itemPastDueImage.frame.origin.x + cell.itemPastDueImage.frame.size.width + ((cell.contentView.frame.size.width*0.04278075)*0.25);
        cell.subLabel.frame = newRect;
        
    } else {
        
        cell.itemPastDueImage.hidden = YES;
        
    }
    
}

-(void)ListCellFrame:(UITableView *)tableView cell:(ViewTaskCell *)cell indexPath:(NSIndexPath *)indexPath {
    
    CGFloat height = CGRectGetHeight(cell.contentView.bounds);
    CGFloat width = CGRectGetWidth(cell.contentView.bounds);
    
    cell.mainView.frame = CGRectMake(width*0.5 - ((width*0.90338164)*0.5), 0, width*0.90338164, height - spacingBetweenCells);
    cell.mainViewOverlay.hidden = YES;
    
    height = CGRectGetHeight(cell.mainView.bounds);
    width = CGRectGetWidth(cell.mainView.bounds);
    
    cell.checkmarkView.frame = CGRectMake(width*0.04278075, height*0.5 - ((height*0.43859)*0.5), height*0.43859, height*0.43859);
    cell.checkmarkView.layer.cornerRadius = cell.checkmarkView.frame.size.height/3;
    
    cell.ellipsisImage.frame = CGRectMake(width - ((height*0.4385965)*0.24) - (width*0.04278075), height*0.5 - ((height*0.4385965)*0.5), ((height*0.4385965)*0.24), height*0.4385965);
    cell.ellipsisImageOverlay.frame = CGRectMake(cell.ellipsisImage.frame.origin.x - (width*0.125), cell.ellipsisImage.frame.origin.y - (width*0.026738), cell.ellipsisImage.frame.size.width + ((width*0.075)*2), cell.ellipsisImage.frame.size.height + ((width*0.026738)*2));
    cell.ellipsisImage.image = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [UIImage imageNamed:@"GeneralIcons.Ellipsis.White"] : [UIImage imageNamed:@"GeneralIcons.Ellipsis"];
    
    NSString *objectToUse = [self GenerateDataForSpeificItemAtIndex:indexPath];
    
    BOOL ListItemCanBeCompletedBySpecificUser = [[[BoolDataObject alloc] init] ListItemCanBeCompletedBySpecificUser:self->itemDict itemType:itemType userID:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] listItem:objectToUse];
    
    if (ListItemCanBeCompletedBySpecificUser == YES) {
        
        cell.ellipsisImageOverlay.userInteractionEnabled = YES;
        cell.ellipsisImage.userInteractionEnabled = YES;
        cell.ellipsisImageOverlay.hidden = NO;
        cell.ellipsisImage.hidden = NO;
        
    } else {
        
        cell.ellipsisImageOverlay.userInteractionEnabled = NO;
        cell.ellipsisImage.userInteractionEnabled = NO;
        cell.ellipsisImageOverlay.hidden = YES;
        cell.ellipsisImage.hidden = YES;
        
    }
    
    cell.subLabel.hidden = YES;
    cell.premiumImage.hidden = YES;
   
    BOOL ListItemIsCompleted = [[[BoolDataObject alloc] init] ListItemIsCompleted:self->itemDict itemType:itemType listItem:objectToUse];
    BOOL ListItemIsInProgress = [[[BoolDataObject alloc] init] ListItemIsInProgress:self->itemDict itemType:itemType listItem:objectToUse];
    BOOL ListItemIsWontDo = [[[BoolDataObject alloc] init] ListItemIsWontDo:self->itemDict itemType:itemType listItem:objectToUse];
    BOOL TaskIsTakingTurns = [[[BoolDataObject alloc] init] TaskIsTakingTurns:self->itemDict itemType:itemType];
    
    if (ListItemIsCompleted == YES && ListItemIsInProgress == NO && ListItemIsWontDo == NO) {
      
        cell.titleLabel.textColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ?  [[[LightDarkModeObject alloc] init] DarkModeTextSecondary] : [[[LightDarkModeObject alloc] init] LightModeTextSecondary];
        cell.titleLabel.alpha = 0.75;
        
        cell.titleLabel.frame = CGRectMake(cell.checkmarkView.frame.origin.x + cell.checkmarkView.frame.size.width + width*0.04278075, height*0.14035, width*0.772727, height*0.350878);
        cell.subLabel.frame = CGRectMake(cell.titleLabel.frame.origin.x, height - cell.titleLabel.frame.size.height - height*0.14035, cell.titleLabel.frame.size.width, cell.titleLabel.frame.size.height);
        
        cell.subLabel.hidden = NO;
        
        cell.checkmarkView.backgroundColor = [UIColor systemGreenColor];
        
    } else if (ListItemIsInProgress == YES && ListItemIsWontDo == NO) {
        
        cell.titleLabel.textColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ?  [[[LightDarkModeObject alloc] init] DarkModeTextPrimary] : [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        cell.titleLabel.alpha = 1;
        
        cell.titleLabel.frame = CGRectMake(cell.checkmarkView.frame.origin.x + cell.checkmarkView.frame.size.width + width*0.04278075, height*0.14035, width*0.772727, height*0.350878);
        cell.subLabel.frame = CGRectMake(cell.titleLabel.frame.origin.x, height - cell.titleLabel.frame.size.height - height*0.14035, cell.titleLabel.frame.size.width, cell.titleLabel.frame.size.height);
        
        cell.subLabel.hidden = NO;
        
        cell.checkmarkView.backgroundColor = [UIColor systemYellowColor];
        
    } else if (ListItemIsWontDo == YES) {
      
        cell.titleLabel.textColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ?  [[[LightDarkModeObject alloc] init] DarkModeTextPrimary] : [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        cell.titleLabel.alpha = 1;
        
        cell.titleLabel.frame = CGRectMake(cell.checkmarkView.frame.origin.x + cell.checkmarkView.frame.size.width + width*0.04278075, height*0.14035, width*0.772727, height*0.350878);
        cell.subLabel.frame = CGRectMake(cell.titleLabel.frame.origin.x, height - cell.titleLabel.frame.size.height - height*0.14035, cell.titleLabel.frame.size.width, cell.titleLabel.frame.size.height);
        
        cell.subLabel.hidden = NO;
        
        cell.checkmarkView.backgroundColor = [UIColor colorWithRed:236.0f/255.0f green:238.0f/255.0f blue:240.0f/255.0f alpha:1.0f];
        
    } else if (TaskIsTakingTurns == YES) {
        
        cell.titleLabel.textColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ?  [[[LightDarkModeObject alloc] init] DarkModeTextPrimary] : [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        cell.titleLabel.alpha = 1;
        
        cell.titleLabel.frame = CGRectMake(cell.checkmarkView.frame.origin.x + cell.checkmarkView.frame.size.width + width*0.04278075, height*0.14035, width*0.772727, height*0.350878);
        cell.subLabel.frame = CGRectMake(cell.titleLabel.frame.origin.x, height - cell.titleLabel.frame.size.height - height*0.14035, cell.titleLabel.frame.size.width, cell.titleLabel.frame.size.height);
        
        cell.subLabel.hidden = NO;
        
        cell.checkmarkView.backgroundColor = [UIColor colorWithRed:236.0f/255.0f green:238.0f/255.0f blue:240.0f/255.0f alpha:1.0f];
        
    } else {
       
        cell.titleLabel.textColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ?  [[[LightDarkModeObject alloc] init] DarkModeTextPrimary] : [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        cell.titleLabel.alpha = 1;
        
        cell.titleLabel.frame = CGRectMake(cell.checkmarkView.frame.origin.x + cell.checkmarkView.frame.size.width + width*0.04278075, height*0.5 - ((height*0.350878)*0.5), width*0.772727, height*0.350878);
        cell.checkmarkView.backgroundColor = [UIColor colorWithRed:236.0f/255.0f green:238.0f/255.0f blue:240.0f/255.0f alpha:1.0f];
        
        NSString *listItem = [self GenerateDataForSpeificItemAtIndex:indexPath];
        
        if (itemListItems[listItem] && itemListItems[listItem][@"Assigned To"]) {
            
            if ([(NSArray *)itemListItems[listItem][@"Assigned To"] count] > 0) {
                
                NSString *assignedTo = itemListItems[listItem][@"Assigned To"][0];
                
                if ([assignedTo isEqualToString:@"Anybody"] == NO && [_homeMembersDict[@"UserID"] containsObject:assignedTo]) {
                    
                    cell.titleLabel.frame = CGRectMake(cell.checkmarkView.frame.origin.x + cell.checkmarkView.frame.size.width + width*0.04278075, height*0.14035, width*0.772727, height*0.350878);
                    cell.subLabel.frame = CGRectMake(cell.titleLabel.frame.origin.x, height - cell.titleLabel.frame.size.height - height*0.14035, cell.titleLabel.frame.size.width, cell.titleLabel.frame.size.height);
                    
                    cell.subLabel.hidden = NO;
                    
                }
                
            }
            
        }
        
    }
    
    cell.titleLabel.font = [UIFont systemFontOfSize:cell.titleLabel.frame.size.height*0.75 weight:UIFontWeightSemibold];
    cell.subLabel.font = [UIFont systemFontOfSize:cell.subLabel.frame.size.height*0.65 weight:UIFontWeightSemibold];
    cell.percentageLabel.font = cell.subLabel.font;
    
    cell.percentageLabel.hidden = YES;
    cell.progressBarOne.hidden = YES;
    cell.progressBarTwo.hidden = YES;
    cell.alternateCheckmarkView.hidden = YES;
    cell.profileImage.hidden = YES;
    
    BOOL TaskPhotoConfirmationNeededForSpecificObject = [[[BoolDataObject alloc] init] TaskPhotoConfirmationNeededForSpecificObject:self->itemDict itemType:self->itemType objectToUse:objectToUse];
    
    if (TaskPhotoConfirmationNeededForSpecificObject == YES) {
        
        CGFloat Imageheight = 94;
        
        cell.itemPastDueImage.frame = CGRectMake(cell.titleLabel.frame.origin.x, cell.subLabel.frame.origin.y, (Imageheight*0.15957447 > 15?(15):Imageheight*0.15957447), cell.subLabel.frame.size.height);
        
        CGRect newRect = cell.subLabel.frame;
        newRect.origin.x = cell.itemPastDueImage.frame.origin.x + cell.itemPastDueImage.frame.size.width + ((cell.contentView.frame.size.width*0.04278075)*0.25);
        cell.subLabel.frame = newRect;
        
    } else {
        
        cell.itemPastDueImage.hidden = YES;
        
    }
    
}

-(void)ItemizedCellFrame:(UITableView *)tableView cell:(ViewTaskCell *)cell indexPath:(NSIndexPath *)indexPath {
    
    CGFloat height = CGRectGetHeight(cell.contentView.bounds);
    CGFloat width = CGRectGetWidth(cell.contentView.bounds);
    
    cell.mainView.frame = CGRectMake(width*0.5 - ((width*0.90338164)*0.5), 0, width*0.90338164, height - spacingBetweenCells);
    cell.mainViewOverlay.hidden = YES;
    
    height = CGRectGetHeight(cell.mainView.bounds);
    width = CGRectGetWidth(cell.mainView.bounds);
    
    cell.checkmarkView.frame = CGRectMake(width*0.04278075, height*0.5 - ((height*0.43859)*0.5), height*0.43859, height*0.43859);
    cell.checkmarkView.layer.cornerRadius = cell.checkmarkView.frame.size.height/3;
    
    cell.ellipsisImage.frame = CGRectMake(width - ((height*0.4385965)*0.24) - (width*0.04278075), height*0.5 - ((height*0.4385965)*0.5), ((height*0.4385965)*0.24), height*0.4385965);
    cell.ellipsisImageOverlay.frame = CGRectMake(cell.ellipsisImage.frame.origin.x - (width*0.125), cell.ellipsisImage.frame.origin.y - (width*0.026738), cell.ellipsisImage.frame.size.width + ((width*0.075)*2), cell.ellipsisImage.frame.size.height + ((width*0.026738)*2));
    cell.ellipsisImage.image = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [UIImage imageNamed:@"GeneralIcons.Ellipsis.White"] : [UIImage imageNamed:@"GeneralIcons.Ellipsis"];
    
    NSString *objectToUse = [self GenerateDataForSpeificItemAtIndex:indexPath];
    
    BOOL ItemizedItemCanBeCompletedBySpecificUser = [[[BoolDataObject alloc] init] ItemizedItemCanBeCompletedBySpecificUser:self->itemDict itemType:itemType userID:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] itemizedItem:objectToUse];
    
    if (ItemizedItemCanBeCompletedBySpecificUser == YES) {
        
        cell.ellipsisImageOverlay.userInteractionEnabled = YES;
        cell.ellipsisImage.userInteractionEnabled = YES;
        cell.ellipsisImageOverlay.hidden = NO;
        cell.ellipsisImage.hidden = NO;
        
    } else {
        
        cell.ellipsisImageOverlay.userInteractionEnabled = NO;
        cell.ellipsisImage.userInteractionEnabled = NO;
        cell.ellipsisImageOverlay.hidden = YES;
        cell.ellipsisImage.hidden = YES;
        
    }
    
    cell.premiumImage.hidden = YES;
    
    BOOL ItemizedItemIsCompleted = [[[BoolDataObject alloc] init] ItemizedItemIsCompleted:self->itemDict itemType:itemType itemizedItem:objectToUse];
    BOOL ItemizedItemIsInProgress = [[[BoolDataObject alloc] init] ItemizedItemIsInProgress:self->itemDict itemType:itemType itemizedItem:objectToUse];
    BOOL ItemizedItemIsWontDo = [[[BoolDataObject alloc] init] ItemizedItemIsWontDo:self->itemDict itemType:itemType itemizedItem:objectToUse];
    BOOL TaskIsTakingTurns = [[[BoolDataObject alloc] init] TaskIsTakingTurns:self->itemDict itemType:itemType];
    
    if (ItemizedItemIsCompleted == YES && ItemizedItemIsInProgress == NO && ItemizedItemIsWontDo == NO) {
        
        cell.titleLabel.textColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ?  [[[LightDarkModeObject alloc] init] DarkModeTextSecondary] : [[[LightDarkModeObject alloc] init] LightModeTextSecondary];
        cell.titleLabel.alpha = 0.75;
        
        cell.titleLabel.frame = CGRectMake(cell.checkmarkView.frame.origin.x + cell.checkmarkView.frame.size.width + width*0.04278075, height*0.14035, width*0.772727, height*0.350878);
        cell.subLabel.frame = CGRectMake(cell.titleLabel.frame.origin.x, height - cell.titleLabel.frame.size.height - height*0.14035, cell.titleLabel.frame.size.width, cell.titleLabel.frame.size.height);
        
        cell.subLabel.hidden = NO;
        
        cell.checkmarkView.backgroundColor = [UIColor systemGreenColor];
        
    } else if (ItemizedItemIsInProgress == YES && ItemizedItemIsWontDo == NO) {
        
        cell.titleLabel.textColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ?  [[[LightDarkModeObject alloc] init] DarkModeTextPrimary] : [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        cell.titleLabel.alpha = 1;
        
        cell.titleLabel.frame = CGRectMake(cell.checkmarkView.frame.origin.x + cell.checkmarkView.frame.size.width + width*0.04278075, height*0.14035, width*0.772727, height*0.350878);
        cell.subLabel.frame = CGRectMake(cell.titleLabel.frame.origin.x, height - cell.titleLabel.frame.size.height - height*0.14035, cell.titleLabel.frame.size.width, cell.titleLabel.frame.size.height);
        
        cell.subLabel.hidden = NO;
        
        cell.checkmarkView.backgroundColor = [UIColor systemYellowColor];
        
    } else if (ItemizedItemIsWontDo == YES) {
        
        cell.titleLabel.textColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ?  [[[LightDarkModeObject alloc] init] DarkModeTextPrimary] : [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        cell.titleLabel.alpha = 1;
        
        cell.titleLabel.frame = CGRectMake(cell.checkmarkView.frame.origin.x + cell.checkmarkView.frame.size.width + width*0.04278075, height*0.14035, width*0.772727, height*0.350878);
        cell.subLabel.frame = CGRectMake(cell.titleLabel.frame.origin.x, height - cell.titleLabel.frame.size.height - height*0.14035, cell.titleLabel.frame.size.width, cell.titleLabel.frame.size.height);
        
        cell.subLabel.hidden = NO;
        
        cell.checkmarkView.backgroundColor = [UIColor colorWithRed:236.0f/255.0f green:238.0f/255.0f blue:240.0f/255.0f alpha:1.0f];
        
    } else if (TaskIsTakingTurns == YES) {
        
        cell.titleLabel.textColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ?  [[[LightDarkModeObject alloc] init] DarkModeTextPrimary] : [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        cell.titleLabel.alpha = 1;
        
        cell.titleLabel.frame = CGRectMake(cell.checkmarkView.frame.origin.x + cell.checkmarkView.frame.size.width + width*0.04278075, height*0.14035, width*0.772727, height*0.350878);
        cell.subLabel.frame = CGRectMake(cell.titleLabel.frame.origin.x, height - cell.titleLabel.frame.size.height - height*0.14035, cell.titleLabel.frame.size.width, cell.titleLabel.frame.size.height);
        
        cell.subLabel.hidden = NO;
        
        cell.checkmarkView.backgroundColor = [UIColor colorWithRed:236.0f/255.0f green:238.0f/255.0f blue:240.0f/255.0f alpha:1.0f];
        
    } else {
        
        cell.titleLabel.textColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ?  [[[LightDarkModeObject alloc] init] DarkModeTextPrimary] : [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        cell.titleLabel.alpha = 1;
        
        cell.titleLabel.frame = CGRectMake(cell.checkmarkView.frame.origin.x + cell.checkmarkView.frame.size.width + width*0.04278075, height*0.14035, width*0.772727, height*0.350878);
        cell.subLabel.frame = CGRectMake(cell.titleLabel.frame.origin.x, height - cell.titleLabel.frame.size.height - height*0.14035, cell.titleLabel.frame.size.width, cell.titleLabel.frame.size.height);
        cell.checkmarkView.backgroundColor = [UIColor colorWithRed:236.0f/255.0f green:238.0f/255.0f blue:240.0f/255.0f alpha:1.0f];
        
        NSString *itemizedItem = [self GenerateDataForSpeificItemAtIndex:indexPath];
        
        if (itemListItems[itemizedItem] && itemListItems[itemizedItem][@"Assigned To"]) {
            
            if ([(NSArray *)itemItemizedItems[itemizedItem][@"Assigned To"] count] > 0) {
                
                cell.titleLabel.frame = CGRectMake(cell.checkmarkView.frame.origin.x + cell.checkmarkView.frame.size.width + width*0.04278075, height*0.14035, width*0.772727, height*0.350878);
                cell.subLabel.frame = CGRectMake(cell.titleLabel.frame.origin.x, height - cell.titleLabel.frame.size.height - height*0.14035, cell.titleLabel.frame.size.width, cell.titleLabel.frame.size.height);
                
                cell.subLabel.hidden = NO;
                
            }
            
        }
        
    }
    
    cell.titleLabel.font = [UIFont systemFontOfSize:cell.titleLabel.frame.size.height*0.75 weight:UIFontWeightSemibold];
    cell.subLabel.font = [UIFont systemFontOfSize:cell.subLabel.frame.size.height*0.65 weight:UIFontWeightSemibold];
    cell.percentageLabel.font = cell.subLabel.font;
    
    cell.percentageLabel.hidden = YES;
    cell.progressBarOne.hidden = YES;
    cell.progressBarTwo.hidden = YES;
    cell.alternateCheckmarkView.hidden = YES;
    cell.profileImage.hidden = YES;
    
    
    
    BOOL TaskPhotoConfirmationNeededForSpecificObject = [[[BoolDataObject alloc] init] TaskPhotoConfirmationNeededForSpecificObject:self->itemDict itemType:self->itemType objectToUse:objectToUse];
    
    if (TaskPhotoConfirmationNeededForSpecificObject == YES) {
        
        CGFloat Imageheight = 94;
        
        cell.itemPastDueImage.frame = CGRectMake(cell.titleLabel.frame.origin.x, cell.subLabel.frame.origin.y, (Imageheight*0.15957447 > 15?(15):Imageheight*0.15957447), cell.subLabel.frame.size.height);
        
        CGRect newRect = cell.subLabel.frame;
        newRect.origin.x = cell.itemPastDueImage.frame.origin.x + cell.itemPastDueImage.frame.size.width + ((cell.contentView.frame.size.width*0.04278075)*0.25);
        cell.subLabel.frame = newRect;
        
    } else {
        
        cell.itemPastDueImage.hidden = YES;
        
    }
    
}

#pragma mark - TableView Methods, didSelectRow

-(void)DidSelectUserCell:(NSIndexPath *)indexPath {
    
    UIImpactFeedbackGenerator *myGen = [[UIImpactFeedbackGenerator alloc] initWithStyle:(UIImpactFeedbackStyleMedium)];
    [myGen impactOccurred];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TaskCompletedForSomeoneElse"];
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld", (long)indexPath.row] forKey:@"TempIndexPathRow"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld", (long)indexPath.section] forKey:@"TempIndexPathSection"];
    
    
    
    NSString *myUserID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"];
    NSString *myUsername = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"];
    
    NSMutableDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:itemAssignedToArray[indexPath.row] homeMembersDict:_homeMembersDict];
    NSString *userID = dataDict[@"UserID"];
    NSString *username = dataDict[@"Username"];
    
    
    
    BOOL CompletingForSomeoneElse = [self->itemAssignedToArray[indexPath.row] isEqualToString:myUserID] == NO;
    
    if (CompletingForSomeoneElse == YES) {
        
        [[NSUserDefaults standardUserDefaults] setObject:
         @{@"CompletedBy" : myUsername,
           @"CompletedFor" : username,
           @"CompletedForSomeoneElse" : @""} forKey:@"TaskCompletedForSomeoneElse"];
        
    }
    
    
    
    BOOL TaskCanBeCompletedInViewTaskBySpecificUser = [[[BoolDataObject alloc] init] TaskCanBeCompletedInViewTaskBySpecificUser:self->itemDict itemType:itemType userID:userID homeMembersDict:_homeMembersDict];
    
    if (TaskCanBeCompletedInViewTaskBySpecificUser == YES) {
        
        [self CompletedUncompletedAction:self];
        
    }
    
}

-(void)DidSelectListItemCell:(NSIndexPath *)indexPath {
    
    UIImpactFeedbackGenerator *myGen = [[UIImpactFeedbackGenerator alloc] initWithStyle:(UIImpactFeedbackStyleMedium)];
    [myGen impactOccurred];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TaskCompletedForSomeoneElse"];
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld", (long)indexPath.row] forKey:@"TempIndexPathRow"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld", (long)indexPath.section] forKey:@"TempIndexPathSection"];
    
    
    
    NSString *myUserID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUseID"];
    NSString *myUsername = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"];
    
    
    
    NSString *listItem = [self GenerateDataForSpeificItemAtIndex:indexPath];
    NSString *listItemAssignedToUserID = @"";
    NSString *listItemAssignedToUsername = @"";
    
    if ([(NSArray *)itemListItems[listItem][@"Assigned To"] count] > 0) {
        
        listItemAssignedToUserID = itemListItems[listItem] && itemListItems[listItem][@"Assigned To"] && [(NSArray *)itemListItems[listItem][@"Assigned To"] count] > 0 ? itemListItems[listItem][@"Assigned To"][0] : @"";
        
        if ([listItemAssignedToUserID isEqualToString:@"Anybody"] == NO && [_homeMembersDict[@"UserID"] containsObject:listItemAssignedToUserID]) {
            
            NSDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:listItemAssignedToUserID homeMembersDict:_homeMembersDict];
            listItemAssignedToUsername = dataDict[@"Username"];
            
        }
        
    }
    
    
    
    BOOL SpecificPersonMustCompleteThisItem = listItemAssignedToUsername.length > 0;
    
    if (SpecificPersonMustCompleteThisItem == YES) {
        
        [[NSUserDefaults standardUserDefaults] setObject:
         @{@"CompletedBy" : myUsername,
           @"CompletedFor" : listItemAssignedToUsername,
           @"CompletedForSomeoneElse" : @""} forKey:@"TaskCompletedForSomeoneElse"];
        
    }
    
    
    
    BOOL ListItemCanBeCompletedBySpecificUser = [[[BoolDataObject alloc] init] ListItemCanBeCompletedBySpecificUser:self->itemDict itemType:itemType userID:myUserID listItem:listItem];
  
    if (ListItemCanBeCompletedBySpecificUser == YES) {
       
        [self ListItemCompletedUncompletedAction:self];

    }
    
}

-(void)DidSelectItemizedItemCell:(NSIndexPath *)indexPath {
    
    UIImpactFeedbackGenerator *myGen = [[UIImpactFeedbackGenerator alloc] initWithStyle:(UIImpactFeedbackStyleMedium)];
    [myGen impactOccurred];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TaskCompletedForSomeoneElse"];
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld", (long)indexPath.row] forKey:@"TempIndexPathRow"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld", (long)indexPath.section] forKey:@"TempIndexPathSection"];
    
    
    
    NSString *myUserID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUseID"];
    NSString *myUsername = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"];
    
    
    
    NSString *itemizedItem = [self GenerateDataForSpeificItemAtIndex:indexPath];
    NSString *itemizedItemAssignedToUserID = @"";
    NSString *itemizedItemAssignedToUsername = @"";
    
    if ([(NSArray *)itemItemizedItems[itemizedItem][@"Assigned To"] count] > 0) {
        
        itemizedItemAssignedToUserID = itemItemizedItems[itemizedItem] && itemItemizedItems[itemizedItem][@"Assigned To"] && [(NSArray *)itemItemizedItems[itemizedItem][@"Assigned To"] count] > 0 ? itemItemizedItems[itemizedItem][@"Assigned To"][0] : @"";
        
        if ([itemizedItemAssignedToUserID isEqualToString:@"Anybody"] == NO && [_homeMembersDict[@"UserID"] containsObject:itemizedItemAssignedToUserID]) {
            
            NSDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:itemizedItemAssignedToUserID homeMembersDict:_homeMembersDict];
            itemizedItemAssignedToUsername = dataDict[@"Username"];
            
        }
        
    }
    
    
    
    BOOL SpecificPersonMustCompleteThisItem = itemizedItemAssignedToUsername.length > 0;
    
    if (SpecificPersonMustCompleteThisItem == YES) {
        
        [[NSUserDefaults standardUserDefaults] setObject:
         @{@"CompletedBy" : myUsername,
           @"CompletedFor" : itemizedItemAssignedToUsername,
           @"CompletedForSomeoneElse" : @""} forKey:@"TaskCompletedForSomeoneElse"];
        
    }
    
    
    
    BOOL ItemizedItemCanBeCompletedBySpecificUser = [[[BoolDataObject alloc] init] ItemizedItemCanBeCompletedBySpecificUser:self->itemDict itemType:itemType userID:myUserID itemizedItem:itemizedItem];
    
    if (ItemizedItemCanBeCompletedBySpecificUser == YES) {
        
        [self ItemizedItemCompletedUncompletedAction:self];
        
    }
    
}

-(void)DidSelectSubTaskCell:(NSIndexPath *)indexPath {
    
    UIImpactFeedbackGenerator *myGen = [[UIImpactFeedbackGenerator alloc] initWithStyle:(UIImpactFeedbackStyleMedium)];
    [myGen impactOccurred];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TaskCompletedForSomeoneElse"];
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld", (long)indexPath.row] forKey:@"TempIndexPathRow"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld", (long)indexPath.section] forKey:@"TempIndexPathSection"];
    
    
    
    NSString *myUserID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUseID"];
    NSString *myUsername = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"];
    
    
    
    NSString *subTaskName = [[itemSubTasksDict allKeys] count] > indexPath.row ? [itemSubTasksDict allKeys][indexPath.row] : @"";
    NSString *subTaskAssignedToUserID = @"";
    NSString *subTaskAssignedToUsername = @"";
    
    if (itemSubTasksDict && itemSubTasksDict[subTaskName] && itemSubTasksDict[subTaskName][@"Assigned To"] && [(NSArray *)itemSubTasksDict[subTaskName][@"Assigned To"] count] > 0) {
        
        subTaskAssignedToUserID = itemSubTasksDict && itemSubTasksDict[subTaskName] && itemSubTasksDict[subTaskName][@"Assigned To"] && [(NSArray *)itemSubTasksDict[subTaskName][@"Assigned To"] count] > 0 ? itemSubTasksDict[subTaskName][@"Assigned To"][0] : @"";
        
        NSDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:subTaskAssignedToUserID homeMembersDict:_homeMembersDict];
        subTaskAssignedToUsername = dataDict[@"Username"];
        
    }
    
    
    
    BOOL SpecificPersonMustCompleteThisItem = subTaskAssignedToUsername.length > 0;
    
    if (SpecificPersonMustCompleteThisItem == YES) {
        
        [[NSUserDefaults standardUserDefaults] setObject:
         @{@"CompletedBy" : myUsername,
           @"CompletedFor" : subTaskAssignedToUsername,
           @"CompletedForSomeoneElse" : @""}  forKey:@"TaskCompletedForSomeoneElse"];
        
    }
    
    
    
    BOOL SubtaskCanBeCompletedBySpecificUser = [[[BoolDataObject alloc] init] SubtaskCanBeCompletedBySpecificUser:self->itemDict itemType:itemType userID:myUserID subtask:subTaskName homeMembersDict:_homeMembersDict];
    
    if (SubtaskCanBeCompletedBySpecificUser == YES) {
      
        [self SubTaskCompletedUncompletedAction:self];
        
    }
    
}

#pragma mark - TableView Methods, heightForRow

-(float)GenerateViewTaskCellHeight:(NSIndexPath *)indexPath {
    
    ViewTaskCell *cell = [_customTableView dequeueReusableCellWithIdentifier:@"ViewTaskCell"];
    
    CGFloat width = CGRectGetWidth(cell.mainView.bounds);
    
    CGFloat spacing = width*0.04278075;
    
    CGFloat maxWidth =
    cell.photoConfirmationImage.hidden == YES ?
    width - cell.titleLabel.frame.origin.x - (width - cell.ellipsisImage.frame.origin.x) - spacing*0.5 :
    width - cell.titleLabel.frame.origin.x - (width - cell.photoConfirmationImage.frame.origin.x) - spacing*0.5;
    
    CGRect newRect = cell.subLabel.frame;
    newRect.size.width = maxSubLabelWidth > 0 ? maxSubLabelWidth : maxWidth;
    cell.subLabel.frame = newRect;
    
    BOOL TaskIsCompleteAsNeeded = [[[BoolDataObject alloc] init] TaskIsCompleteAsNeeded:self->itemDict itemType:itemType];
    
    NSString *description =
    TaskIsCompleteAsNeeded == YES ?
    [self GenerateItemCompletedTextUserCellItemCompleteAsNeeded:indexPath] :
    [self GenerateItemCompletedTextUserCell:indexPath];
    int lineCount = [[[GeneralObject alloc] init] LineCountForText:description label:cell.subLabel];
    
    float additionalHeightToAddForAdditionalSubLabelLines = subLabelHeight*lineCount;
    float cellHeight = additionalHeightToAddForAdditionalSubLabelLines;
    
    NSMutableDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:itemAssignedToArray[indexPath.row] homeMembersDict:_homeMembersDict];
    NSString *userID = dataDict[@"UserID"];
    NSString *username = dataDict[@"Username"];
    
    //Post-Spike
    dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:userID homeMembersDict:_homeMembersDict];
    NSString *email = dataDict[@"Email"];
    
    BOOL UserHasJoinedHome = [email length] > 0;
    BOOL UserWithUsernameHasNotificationsTurnedOn = [[[BoolDataObject alloc] init] UserWithUsernameHasNotificationsTurnedOn:username homeMembersDict:_homeMembersDict];
    
   
    if ((UserWithUsernameHasNotificationsTurnedOn == NO || UserHasJoinedHome == NO)) {
        
        cellHeight =
        primaryLabelSpacingHeight +
        titleLabelHeight +
        secondaryLabelSpacingHeight +
        additionalHeightToAddForAdditionalSubLabelLines +
        secondaryLabelSpacingHeight +
        alertLabelHeight +
        primaryLabelSpacingHeight +
        spacingBetweenCells;
        
    } else {
        
        cellHeight =
        primaryLabelSpacingHeight +
        titleLabelHeight +
        secondaryLabelSpacingHeight +
        additionalHeightToAddForAdditionalSubLabelLines +
        primaryLabelSpacingHeight +
        spacingBetweenCells;
        
    }
    
    return cellHeight;
}

-(float)GenerateViewTaskCellHeightNo1 {
    
    ViewTaskCell *cell = [_customTableView dequeueReusableCellWithIdentifier:@"ViewTaskCell"];
    
    CGFloat width = CGRectGetWidth(cell.mainView.bounds);
    
    CGFloat maxWidth = width - cell.titleLabel.frame.origin.x - (width - (cell.ellipsisImage.frame.origin.x + cell.ellipsisImage.frame.size.width));
    
    CGRect newRect = cell.subLabel.frame;
    newRect.size.width = maxWidth;
    cell.subLabel.frame = newRect;
    
    int lineCount = [[[GeneralObject alloc] init] LineCountForText:@"xxx" label:cell.subLabel];
    
    float additionalHeightToAddForAdditionalSubLabelLines = subLabelHeight*lineCount;
    float cellHeight = additionalHeightToAddForAdditionalSubLabelLines;
    
    cellHeight =
    primaryLabelSpacingHeight +
    titleLabelHeight +
    secondaryLabelSpacingHeight +
    additionalHeightToAddForAdditionalSubLabelLines +
    primaryLabelSpacingHeight +
    spacingBetweenCells;
    
    return cellHeight;
}

#pragma mark - Item View Context Menu Methods

-(UIAction *)ItemViewContextMenuViewImageAction {
    
    UIAction *viewImageAction = [UIAction actionWithTitle:@"View Image" image:[UIImage systemImageNamed:@"photo"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"View Image"] completionHandler:^(BOOL finished) {
            
        }];
        
        UIImage *itemImage = self->itemImage;
        [[[PushObject alloc] init] PushToViewImageViewController:self itemImage:itemImage];
        
    }];
    
    return viewImageAction;
}

-(UIAction *)ItemViewContextMenuViewItemAction {
    
    UIAction *viewItemAction = [UIAction actionWithTitle:@"View" image:[UIImage systemImageNamed:@"magnifyingglass"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
        
        [[[PushObject alloc] init] PushToAddTaskViewController:self->itemDict partiallyAddedDict:nil suggestedItemToAddDict:nil templateToEditDict:nil draftToEditDict:nil moreOptionsDict:nil multiAddDict:nil notificationSettingsDict:self->_notificationSettingsDict topicDict:self->_topicDict homeID:homeID homeMembersArray:self->_homeMembersArray homeMembersDict:self->_homeMembersDict itemOccurrencesDict:self->itemxxxOccurrencesDict folderDict:self->_folderDict taskListDict:self->_taskListDict templateDict:self->_templateDict draftDict:self->_draftDict allItemAssignedToArrays:self->_allItemAssignedToArrays allItemTagsArrays:self->_allItemTagsArrays allItemIDsArrays:nil defaultTaskListName:self->topViewLabel.text partiallyAddedTask:NO addingTask:NO addingMultipleTasks:NO addingSuggestedTask:NO editingTask:NO viewingTask:YES viewingMoreOptions:NO duplicatingTask:NO editingTemplate:NO viewingTemplate:NO editingDraft:NO viewingDraft:NO currentViewController:self Superficial:NO];
        
    }];
    
    return viewItemAction;
}

-(UIAction *)ItemViewContextMenuEditItemAction {
    
    UIAction *editItemAction = [UIAction actionWithTitle:@"Edit" image:[UIImage systemImageNamed:@"pencil"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [self EditTask:nil];
        
    }];
    
    return editItemAction;
}

-(UIAction *)ItemViewContextMenuViewAnalyticsAction {
    
    NSString *analyticsString = self->ViewingAnalytics == NO ? @"Analytics" : @"Hide Analytics";
    NSString *analyticsImageString = self->ViewingAnalytics == NO ? @"chart.bar" : @"chart.bar";
    
    UIAction *viewAnalyticsAction = [UIAction actionWithTitle:analyticsString image:[UIImage systemImageNamed:analyticsImageString] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [self TapGestureViewAnalytics:self];
        
    }];
    
    return viewAnalyticsAction;
}

-(NSMutableArray *)ItemViewContextMenuMainActions {
    
    NSMutableArray *contextMenuItemDetailActions = [[NSMutableArray alloc] init];
    
    BOOL ImageExists = ([self->itemImageURL containsString:@"(null)"] == NO &&
                        self->itemImageURL != nil &&
                        self->itemImageURL.length > 0 &&
                        [self->itemImageURL isEqualToString:@"xxx"] == NO &&
                        [self->itemImageURL containsString:@"gs://"] &&
                        self->itemImage != NULL);
    BOOL TaskIsRepeating = [[[BoolDataObject alloc] init] TaskIsRepeating:itemDict itemType:itemType];
   
    if (ImageExists) {
        
        UIAction *viewImageAction = [self ItemViewContextMenuViewImageAction];
        [contextMenuItemDetailActions addObject:viewImageAction];
        
    }
    
    UIAction *viewItemAction = [self ItemViewContextMenuViewItemAction];
    [contextMenuItemDetailActions addObject:viewItemAction];
    
    UIAction *editItemAction = [self ItemViewContextMenuEditItemAction];
    [contextMenuItemDetailActions addObject:editItemAction];
    
    if (TaskIsRepeating == YES) {
        
        //        UIAction *viewAnalyticsAction = [self ItemViewContextMenuViewAnalyticsAction];
        //        [contextMenuItemDetailActions addObject:viewAnalyticsAction];
        
    }
    
    return contextMenuItemDetailActions;
}

#pragma mark

-(UIAction *)ItemViewContextMenuWaiveAction {
    
    UIAction *waiveAction = [UIAction actionWithTitle:@"Waive" image:[UIImage systemImageNamed:@"hand.wave"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [self TapGestureWaive:self];
        
    }];
    
    return waiveAction;
}

-(UIAction *)ItemViewContextMenuSkipAction {
    
    UIAction *skipAction = [UIAction actionWithTitle:@"Skip" image:[UIImage systemImageNamed:@"arrowshape.turn.up.right"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [self TapGestureSkip:self];
        
    }];
    
    return skipAction;
}

-(UIAction *)ItemViewContextMenuPauseAction {
    
    UIAction *pauseAction = [UIAction actionWithTitle:@"Pause" image:[UIImage systemImageNamed:@"pause"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [self TapGesturePauseOrPlay:@"Paused"];
        
    }];
    
    return pauseAction;
}

-(UIAction *)ItemViewContextMenuUnpauseAction {
    
    UIAction *waiveAction = [UIAction actionWithTitle:@"Unpause" image:[UIImage systemImageNamed:@"play"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [self TapGesturePauseOrPlay:@""];
        
    }];
    
    return waiveAction;
}

-(NSMutableArray *)ItemViewContextMenuRepeatingActions {
    
    NSMutableArray *contextMenuItemRepeatingActions = [[NSMutableArray alloc] init];
    
    BOOL ItemIsInTrash = [self->itemTrash isEqualToString:@"Yes"];
    BOOL TaskIsRepeating = [[[BoolDataObject alloc] init] TaskIsRepeating:self->itemDict itemType:self->itemType];
    BOOL TaskIsAnOccurrence = (self->_itemOccurrenceID.length > 0 && [self->_itemOccurrenceID isEqualToString:@"xxx"] == NO);
    BOOL TaskIsPaused = ([self->itemStatus isEqualToString:@"Paused"]);
    
    if (ItemIsInTrash == NO && TaskIsRepeating == YES && TaskIsAnOccurrence == YES) {
        
        UIAction *waiveAction = [self ItemViewContextMenuWaiveAction];
        [contextMenuItemRepeatingActions addObject:waiveAction];
        
    }
    
    if (ItemIsInTrash == NO && TaskIsRepeating == YES && TaskIsAnOccurrence == NO && TaskIsPaused == NO) {
        
        UIAction *skipAction = [self ItemViewContextMenuSkipAction];
        [contextMenuItemRepeatingActions addObject:skipAction];
        
        UIAction *pauseAction = [self ItemViewContextMenuPauseAction];
        [contextMenuItemRepeatingActions addObject:pauseAction];
        
    }
    
    if (ItemIsInTrash == NO && TaskIsRepeating == YES && TaskIsAnOccurrence == NO && TaskIsPaused == YES) {
        
        UIAction *unpauseAction = [self ItemViewContextMenuUnpauseAction];
        [contextMenuItemRepeatingActions addObject:unpauseAction];
        
    }
    
    return contextMenuItemRepeatingActions;
}

#pragma mark

-(UIAction *)ItemViewContextMenuDifficultyAction {
    
    UIAction *difficultyAction = [UIAction actionWithTitle:@"Difficulty" image:[UIImage systemImageNamed:@"speedometer"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [self TapGestureDifficulty:self];
        
    }];
    
    return difficultyAction;
}

-(UIAction *)ItemViewContextMenuPriorityAction {
    
    UIAction *priorityAction = [UIAction actionWithTitle:@"Priority" image:[UIImage systemImageNamed:@"flag"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [self TapGesturePriority:self];
        
    }];
    
    return priorityAction;
}

-(UIAction *)ItemViewContextMenuTagsAction {
    
    UIAction *tagAction = [UIAction actionWithTitle:@"Tag" image:[UIImage systemImageNamed:@"tag"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [self TapGestureTags:self];
        
    }];
    
    return tagAction;
}

-(UIAction *)ItemViewContextMenuColorAction {
    
    UIAction *colorAction = [UIAction actionWithTitle:@"Color" image:[UIImage systemImageNamed:@"drop"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [self TapGestureColor:self];
        
    }];
    
    return colorAction;
}

-(NSMutableArray *)ItemViewContextMenuDetailsActions {
    
    NSMutableArray *contextMenuItemDataActions = [[NSMutableArray alloc] init];
    
    UIAction *difficultyAction = [self ItemViewContextMenuDifficultyAction];
    [contextMenuItemDataActions addObject:difficultyAction];
    
    UIAction *priorityAction = [self ItemViewContextMenuPriorityAction];
    [contextMenuItemDataActions addObject:priorityAction];
    
    UIAction *tagsAction = [self ItemViewContextMenuTagsAction];
    [contextMenuItemDataActions addObject:tagsAction];
    
    UIAction *colorAction = [self ItemViewContextMenuColorAction];
    [contextMenuItemDataActions addObject:colorAction];
    
    return contextMenuItemDataActions;
}

#pragma mark

-(UIAction *)ItemViewContextMenuCommentAction {
    
    UIAction *commentAction = [UIAction actionWithTitle:@"Comment" image:[UIImage systemImageNamed:@"text.bubble"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [self TapGestureActionPushToLiveChatViewController:self];
        
    }];
    
    return commentAction;
}

-(UIAction *)ItemViewContextMenuDuplicateAction {
    
    UIAction *duplicateAction = [UIAction actionWithTitle:@"Duplicate" image:[UIImage systemImageNamed:@"doc.on.doc"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [self TapGestureDuplicate:self];
        
    }];
    
    return duplicateAction;
}

-(NSMutableArray *)ItemViewContextMenuOtherActions {
    
    NSMutableArray *contextMenuItemOtherActions = [[NSMutableArray alloc] init];
    
    UIAction *commentAction = [self ItemViewContextMenuCommentAction];
    [contextMenuItemOtherActions addObject:commentAction];
    
    UIAction *duplicateAction = [self ItemViewContextMenuDuplicateAction];
    [contextMenuItemOtherActions addObject:duplicateAction];
    
    return contextMenuItemOtherActions;
}

#pragma mark

-(UIAction *)ItemViewContextMenuMuteAction {
    
    UIAction *muteAction = [UIAction actionWithTitle:@"Mute" image:[UIImage systemImageNamed:@"bell.slash"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        if ([[[BoolDataObject alloc] init] PremiumSubscriptionIsOn] == NO) {
            
            [[[PushObject alloc] init] PushToWeDivvyPremiumViewController:YES comingFromSignUp:NO defaultPlan:@"" displayDiscount:@"Half-Off Yearly Discount No Sale Sticker" selectedSlide:@"Mute Tasks" promoCodeID:@"" premiumPlanProductsArray:self->premiumPlanProductsArray premiumPlanPricesDict:self->premiumPlanPricesDict premiumPlanExpensivePricesDict:self->premiumPlanExpensivePricesDict premiumPlanPricesDiscountDict:self->premiumPlanPricesDiscountDict premiumPlanPricesNoFreeTrialDict:self->premiumPlanPricesNoFreeTrialDict currentViewController:self Superficial:NO];
            
        } else {
            
            [self MuteTaskAction:self];
            
        }
        
    }];
    
    return muteAction;
}

-(UIAction *)ItemViewContextMenuUnmuteAction {
    
    UIAction *unmuteAction = [UIAction actionWithTitle:@"Unmute" image:[UIImage systemImageNamed:@"bell"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [self MuteTaskAction:self];
        
    }];
    
    return unmuteAction;
}

-(NSMutableArray *)ItemViewContextMenuMuteActions {
    
    NSMutableArray *reminderActions = [NSMutableArray array];
    
    BOOL TaskHasBeenMuted = [[[BoolDataObject alloc] init] TaskHasBeenMuted:self->itemDict];
    BOOL UserShouldReceiveNotificationsForTask = UserShouldReceiveNotificationsForTask = [[[BoolDataObject alloc] init] UserShouldReceiveNotificationsForTask:self->itemDict itemType:itemType userID:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] homeMembersDict:_homeMembersDict];
    
    if (UserShouldReceiveNotificationsForTask == YES) {
        
        if (TaskHasBeenMuted == NO) {
            
            UIAction *muteAction = [self ItemViewContextMenuMuteAction];
            [reminderActions addObject:muteAction];
            
        } else {
            
            UIAction *unmuteAction = [self ItemViewContextMenuUnmuteAction];
            [reminderActions addObject:unmuteAction];
            
        }
        
    }
    
    return reminderActions;
}

-(UIMenu *)ItemViewContextMenuRemindInlineMenu:(NSMutableArray *)identifierArray {
    
    NSMutableArray *arrayOfReminderNotifications = [NSMutableArray array];
    NSString *currentItemReminderNotificationIdentifier = @"";
    
    for (NSString *identifier in identifierArray) {
        
        if ([identifier containsString:@" - Remind Me - "]) {
            
            [arrayOfReminderNotifications addObject:identifier];
            
            if ([identifier containsString:self->itemUniqueID]) {
                
                currentItemReminderNotificationIdentifier = identifier;
                
            }
            
        }
        
    }
    
    
    
    
    NSArray *reminderNotificationIdentifierComponentsArray =
    [currentItemReminderNotificationIdentifier length] > 0 &&
    [currentItemReminderNotificationIdentifier containsString:@" - "] ?
    [currentItemReminderNotificationIdentifier componentsSeparatedByString:@" - "] : @[];
    NSString *reminderNotificationIdentifierNameComponent = [reminderNotificationIdentifierComponentsArray count] > 2 ? reminderNotificationIdentifierComponentsArray[2] : @"Never";
    NSString *customReminder = reminderNotificationIdentifierNameComponent;
    
    if (customReminder == nil || customReminder == NULL || [customReminder length] == 0) {
        customReminder = @"Never";
    }
    
    
    
    
    NSMutableArray *reminderActions = [NSMutableArray array];
    
    NSArray *reminderNameArray =
    [self->itemDueDate isEqualToString:@"No Due Date"] ?
    @[@"30 Minutes", @"2 Hours", @"12 Hours", @"1 Day", @"1 Week"] :
    @[@"30 Minutes Before", @"2 Hours Before", @"12 Hours Before", @"1 Day Before", @"1 Week Before"];
    
    
    
    
    
    
    NSMutableArray *neverReminderActions = [self ItemViewContextMenuNeverRemindActions:currentItemReminderNotificationIdentifier];
    
    UIMenu *neverReminderActionMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"Never" options:UIMenuOptionsDisplayInline children:neverReminderActions];
    [reminderActions addObject:neverReminderActionMenu];
    
    
    NSMutableArray *remindActions = [self ItemViewContextMenuRemindActions:reminderNameArray reminderNotificationIdentifierNameComponent:reminderNotificationIdentifierNameComponent];
    
    UIMenu *remindActionMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"Remind" options:UIMenuOptionsDisplayInline children:remindActions];
    [reminderActions addObject:remindActionMenu];
    
    
    NSMutableArray *customReminderActions = [self ItemViewContextMenuCustomRemindActions:reminderNameArray customReminder:customReminder];
    
    UIMenu *customRemindActionMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"Remind" options:UIMenuOptionsDisplayInline children:customReminderActions];
    [reminderActions addObject:customRemindActionMenu];
    
    
    
    
    
    
    NSString *reminderMenuTitle = [self->itemDueDate isEqualToString:@"No Due Date"] ? @"Remind Me In" : @"Remind Me";
    
    UIMenu *reminderActionsMenu = [UIMenu menuWithTitle:reminderMenuTitle image:[UIImage systemImageNamed:@"alarm"] identifier:reminderMenuTitle options:0 children:reminderActions];
    
    if (@available(iOS 15.0, *)) {
        
        reminderActionsMenu.subtitle = customReminder;
        
    }
    
    
    
    
    
    
    return reminderActionsMenu;
}

-(UIMenu *)ItemContextMenuReminderActionsMenu:(NSMutableArray *)identifierArray {
    
    NSMutableArray *reminderActions = [self ItemViewContextMenuMuteActions];
    
    UIMenu *remindInlineMenu = [self ItemViewContextMenuRemindInlineMenu:identifierArray];
    [reminderActions addObject:remindInlineMenu];
    
    UIMenu *reminderActionsMenuActionMenu = [UIMenu menuWithTitle: @"" image:nil identifier:@"" options:UIMenuOptionsDisplayInline children:reminderActions];
    
    return reminderActionsMenuActionMenu;
}

#pragma mark

-(UIAction *)ItemViewContextMenuShareAction {
    
    UIAction *shareAction = [UIAction actionWithTitle:@"Share" image:[UIImage systemImageNamed:@"square.and.arrow.up"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [self TapGestureShare:self];
        
    }];
    
    return shareAction;
}

-(NSMutableArray *)ItemViewContextMenuShareActions {
    
    NSMutableArray *contextMenuItemShareActions = [[NSMutableArray alloc] init];
    
    UIAction *shareAction = [self ItemViewContextMenuShareAction];
    [contextMenuItemShareActions addObject:shareAction];
    
    return contextMenuItemShareActions;
}

#pragma mark

-(UIAction *)ItemViewContextMenuMoveToTrashAction {
    
    UIAction *moveToTrashAction = [UIAction actionWithTitle:@"Move To Trash" image:[UIImage systemImageNamed:@"trash"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [self MoveTaskToTrash:nil];
        
    }];
    
    [moveToTrashAction setAttributes:UIMenuElementAttributesDestructive];
    
    return moveToTrashAction;
}

-(UIAction *)ItemViewContextMenuPermanentlyDeleteAction {
    
    UIAction *permanentlyDeleteAction = [UIAction actionWithTitle:@"Permanently Delete" image:[UIImage systemImageNamed:@"trash"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [self DeleteTask:nil];
        
    }];
    
    [permanentlyDeleteAction setAttributes:UIMenuElementAttributesDestructive];
    
    return permanentlyDeleteAction;
}

-(UIAction *)ItemViewContextMenuMoveOutOfTrashAction {
    
    UIAction *moveOutOfTrashAction = [UIAction actionWithTitle:@"Move Out of Trash" image:[UIImage systemImageNamed:@"arrow.up.bin"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [self MoveTaskOutOfTrash:nil];
        
    }];
    
    return moveOutOfTrashAction;
}

-(NSMutableArray *)ItemViewContextMenuTrashActions {
    
    NSMutableArray *contextMenuItemTrashActions = [[NSMutableArray alloc] init];
    
    BOOL ItemIsInTrash = [self->itemTrash isEqualToString:@"Yes"];
    
    if (ItemIsInTrash == NO) {
        
        UIAction *moveToTrashAction = [self ItemViewContextMenuMoveToTrashAction];
        [contextMenuItemTrashActions addObject:moveToTrashAction];
        
    } else {
        
        UIAction *moveOutOfTrashAction = [self ItemViewContextMenuMoveOutOfTrashAction];
        [contextMenuItemTrashActions addObject:moveOutOfTrashAction];
        
        UIAction *permanentlyDeleteAction = [self ItemViewContextMenuPermanentlyDeleteAction];
        [contextMenuItemTrashActions addObject:permanentlyDeleteAction];
        
    }
    
    return contextMenuItemTrashActions;
}


#pragma mark -
#pragma mark
#pragma mark
#pragma mark Sub-Internal Methods
#pragma mark
#pragma mark
#pragma mark -

#pragma mark QueryInitialData Methods

-(void)SetQueriedData {
    
    completedQueries += 1;
    
    if (totalQueries == completedQueries) {

        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self SetDataGeneral:self->itemDict];
            [self UpdateViews];
            
            [UIView animateWithDuration:0.25 animations:^{
                
                [self CalculateItemProgressBarWidth];
                
            }];
            
        });
        
    }
    
}

#pragma mark - Item View Context Menu Reminder Menu

-(UIAction *)ItemViewContextMenuNeverRemindAction:(NSString *)currentItemReminderNotificationIdentifier {
    
    NSString *imageString = [currentItemReminderNotificationIdentifier length] == 0 ? @"checkmark" : @"";
    
    UIAction *neverRemindAction = [UIAction actionWithTitle:@"Never" image:[UIImage systemImageNamed:imageString] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Never Remind Me Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
            
        }];
        
        [self->progressView setHidden:YES];
        [self SetUpItemViewContextMenu];
        [self ViewItemViewInnerViews];
        
        [self AdjustTableViewFrames];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [[[NotificationsObject alloc] init] ResetLocalNotificationCustomReminderNotification_LocalOnly:@"" itemType:self->itemType dictToUse:self->itemDict homeMembersDict:self->_homeMembersDict homeMembersArray:self->_homeMembersArray  allItemTagsArrays:self->_allItemTagsArrays completionHandler:^(BOOL finished) {
                
            }];
            
        });
        
    }];
    
    return neverRemindAction;
}

-(NSMutableArray *)ItemViewContextMenuNeverRemindActions:(NSString *)currentItemReminderNotificationIdentifier {
    
    NSMutableArray *neverReminderActions = [NSMutableArray array];
    
    UIAction *neverRemindAction = [self ItemViewContextMenuNeverRemindAction:currentItemReminderNotificationIdentifier];
    [neverReminderActions addObject:neverRemindAction];
    
    return neverReminderActions;
}

#pragma mark

-(UIAction *)ItemViewContextMenuRemindAction:(NSString *)reminderName reminderNotificationIdentifierNameComponent:(NSString *)reminderNotificationIdentifierNameComponent {
    
    BOOL ThisReminderFrequencyHasAlreadyBeenSelected = [reminderName isEqualToString:reminderNotificationIdentifierNameComponent];
    
    NSString *imageString = ThisReminderFrequencyHasAlreadyBeenSelected == YES ? @"checkmark" : @"";
    
    UIAction *remindAction = [UIAction actionWithTitle:reminderName image:[UIImage systemImageNamed:imageString] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"%@ Remind Me Clicked For %@", reminderName, [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
            
        }];
        
        if ([[[BoolDataObject alloc] init] PremiumSubscriptionIsOn] == YES) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self->progressView setHidden:YES];
                [self SetUpItemViewContextMenu];
                [self ViewItemViewInnerViews];
                
                [self AdjustTableViewFrames];
                
            });
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                [[[NotificationsObject alloc] init] ResetLocalNotificationCustomReminderNotification_LocalOnly:reminderName itemType:self->itemType dictToUse:self->itemDict homeMembersDict:self->_homeMembersDict homeMembersArray:self->_homeMembersArray  allItemTagsArrays:self->_allItemTagsArrays completionHandler:^(BOOL finished) {
                    
                }];
                
            });
            
        } else {
            
            [[[PushObject alloc] init] PushToWeDivvyPremiumViewController:YES comingFromSignUp:NO defaultPlan:@"" displayDiscount:@"Half-Off Yearly Discount No Sale Sticker" selectedSlide:@"Third Reminder" promoCodeID:@"" premiumPlanProductsArray:self->premiumPlanProductsArray premiumPlanPricesDict:self->premiumPlanPricesDict premiumPlanExpensivePricesDict:self->premiumPlanExpensivePricesDict premiumPlanPricesDiscountDict:self->premiumPlanPricesDiscountDict premiumPlanPricesNoFreeTrialDict:self->premiumPlanPricesNoFreeTrialDict currentViewController:self Superficial:NO];
            
        }
        
    }];
    
    return remindAction;
}

-(NSMutableArray *)ItemViewContextMenuRemindActions:(NSArray *)reminderNameArray reminderNotificationIdentifierNameComponent:(NSString *)reminderNotificationIdentifierNameComponent {
    
    NSMutableArray *remindActions = [NSMutableArray array];
    
    for (NSString *reminderName in reminderNameArray) {
        
        UIAction *remindAction = [self ItemViewContextMenuRemindAction:reminderName reminderNotificationIdentifierNameComponent:reminderNotificationIdentifierNameComponent];
        [remindActions addObject:remindAction];
        
    }
    
    return remindActions;
}

#pragma mark

-(UIAction *)ItemViewContextMenuCustomRemindAction:(NSArray *)reminderNameArray customReminder:(NSString *)customReminder {
    
    BOOL CustomReminderHasBeenSelected = [reminderNameArray containsObject:customReminder] == NO && [customReminder isEqualToString:@"Never"] == NO;
    
    NSString *imageString = CustomReminderHasBeenSelected == YES ? @"checkmark" : @"";
    
    UIAction *customRemindAction = [UIAction actionWithTitle:@"More Options" image:[UIImage systemImageNamed:imageString] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Custom Remind Me Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
            
        }];
        
        if ([[[BoolDataObject alloc] init] PremiumSubscriptionIsOn] == YES) {
            
            NSMutableArray *itemsSelectedArray = [NSMutableArray array];
            
            if (customReminder.length > 0) {
                
                itemsSelectedArray = [[customReminder componentsSeparatedByString:@""] mutableCopy];
                
            }
            
            NSString *optionSelectedString =
            [self->itemDueDate isEqualToString:@"No Due Date"] ?
            @"CustomReminder" : @"CustomReminderBefore";
            
            [[[PushObject alloc] init] PushToViewOptionsViewController:itemsSelectedArray customOptionsArray:nil specificDatesArray:nil viewingItemDetails:NO optionSelectedString:optionSelectedString itemRepeatsFrequency:nil homeMembersDict:nil currentViewController:self];
            
        } else {
            
            [[[PushObject alloc] init] PushToWeDivvyPremiumViewController:YES comingFromSignUp:NO defaultPlan:@"" displayDiscount:@"Half-Off Yearly Discount No Sale Sticker" selectedSlide:@"Third Reminder" promoCodeID:@"" premiumPlanProductsArray:self->premiumPlanProductsArray premiumPlanPricesDict:self->premiumPlanPricesDict premiumPlanExpensivePricesDict:self->premiumPlanExpensivePricesDict premiumPlanPricesDiscountDict:self->premiumPlanPricesDiscountDict premiumPlanPricesNoFreeTrialDict:self->premiumPlanPricesNoFreeTrialDict currentViewController:self Superficial:NO];
            
        }
        
    }];
    
    return customRemindAction;
}

-(NSMutableArray *)ItemViewContextMenuCustomRemindActions:(NSArray *)reminderNameArray customReminder:(NSString *)customReminder {
    
    NSMutableArray *customReminderActions = [NSMutableArray array];
    
    UIAction *customRemindAction = [self ItemViewContextMenuCustomRemindAction:reminderNameArray customReminder:customReminder];
    [customReminderActions addObject:customRemindAction];
    
    return customReminderActions;
}

#pragma mark - AddListItemItemTypeList

-(void)AddListItem {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Add List Item"] completionHandler:^(BOOL finished) {
        
    }];
    
//    [self StartProgressView];
    
    NSString *itemName = _writeTaskTextField.text;
    
    NSMutableArray *assignedToArray = [NSMutableArray array];
    
    if ([_writeAssignedToTaskTextField.text isEqualToString:@"Anybody"] == NO && _writeAssignedToTaskTextField.text.length > 0) {
        
        NSString *userID = @"";
        
        if ([_homeMembersDict[@"Username"] containsObject:_writeAssignedToTaskTextField.text]) {
            
            NSUInteger index = [_homeMembersDict[@"Username"] indexOfObject:_writeAssignedToTaskTextField.text];
            userID = _homeMembersDict[@"UserID"][index];
            
        } else {
            
            userID = itemCreatedBy;
            
        }
        
        [assignedToArray addObject:userID];
    }
    
    [itemListItems setObject:@{@"Assigned To" : assignedToArray, @"Status" : @"Uncompleted"} forKey:_writeTaskTextField.text];
    
    
    
    __block int totalQueries = 2;
    __block int completedQueries = 0;
    
    
    
    //Remove Loading
    
    NSMutableDictionary *dictToUse = [@{@"ItemCompletedDict" : self->itemCompletedDict, @"ItemInProgressDict" : self->itemInProgressDict, @"ItemWontDo" : self->itemWontDoDict, @"ItemListItems" : self->itemListItems} mutableCopy];
    
    [self UpdateAllDataInViewController:nil dictToUse:dictToUse];
    
    //
    
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSMutableDictionary *singleObjectItemDict = [[[GeneralObject alloc] init] GenerateSingleObjectDictionary:[self->itemDict mutableCopy] keyArray:[self->keyArray mutableCopy] indexPath:nil];
        
        
        
        NSString *notificationType = [[[NotificationsObject alloc] init] NotificationSettingsUnknownItemType_Adding:NO Editing:NO Deleting:NO Duplicating:NO Waiving:NO Skipping:NO Pausing:NO Comments:NO
                                                                                                       SkippingTurn:NO RemovingUser:NO
                                                                                                     FullyCompleted:NO Completed:NO InProgress:NO WontDo:NO Accept:NO Decline:NO
                                                                                                            DueDate:NO Reminder:NO
                                                                                                     SubtaskEditing:NO SubtaskDeleting:NO
                                                                                                   SubtaskCompleted:NO SubtaskInProgress:NO SubtaskWontDo:NO SubtaskAccept:NO SubtaskDecline:NO
                                                                                                     AddingListItem:YES EditingListItem:NO DeletingListItem:NO ResetingListItem:NO
                                                                                                EditingItemizedItem:NO DeletingItemizedItem:NO
                                                                                                  GroupChatMessages:NO LiveSupportMessages:NO
                                                                                                 SendingInvitations:NO DeletingInvitations:NO NewHomeMembers:NO HomeMembersMovedOut:NO HomeMembersKickedOut:NO
                                                                                                FeatureForumUpvotes:NO BugForumUpvotes:NO
                                                                                                           itemType:self->itemType];
        
        
        
        NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
        
        
        
        NSString *notificationTitle = [NSString stringWithFormat:@"\"%@\"", self->itemName];
        NSString *notificationBody = [NSString stringWithFormat:@"%@ added \"%@\" to this list. 📝", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"], itemName];
        
        
        
        NSMutableArray *usersToSendNotificationTo = [self->itemAssignedToArray mutableCopy];
        
        NSArray *addTheseUsers = @[self->itemCreatedBy];
        NSArray *removeTheseUsers = @[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx"];
        
        usersToSendNotificationTo = [[[[NotificationsObject alloc] init] AddAndRemoveSpecificUsersFromArray:usersToSendNotificationTo addTheseUsers:addTheseUsers removeTheseUsers:removeTheseUsers] mutableCopy];
        
        
        
        [[[NotificationsObject alloc] init] SendPushNotificationToArrayOfUsers_Items:usersToSendNotificationTo
                                                                           dictToUse:singleObjectItemDict
                                                                              homeID:homeID homeMembersArray:self->_homeMembersArray homeMembersDict:self->_homeMembersDict
                                                            notificationSettingsDict:self->_notificationSettingsDict notificationItemType:self->itemType notificationType:notificationType
                                                                           topicDict:self->_topicDict
                                                                 allItemTagsArrays:self->_allItemTagsArrays
                                                               pushNotificationTitle:notificationTitle pushNotificationBody:notificationBody
                                                                   notificationTitle:notificationTitle notificationBody:notificationBody
                                                             SetDataHomeNotification:YES
                                                                RemoveUsersNotInHome:YES
                                                                   completionHandler:^(BOOL finished) {
            
            if (totalQueries == (completedQueries+=1)) {
                
                NSMutableDictionary *dictToUse = [@{@"ItemCompletedDict" : self->itemCompletedDict, @"ItemInProgressDict" : self->itemInProgressDict, @"ItemWontDo" : self->itemWontDoDict, @"ItemListItems" : self->itemListItems} mutableCopy];
                
                [self UpdateAllDataInViewController:nil dictToUse:dictToUse];
                
            }
            
        }];
        
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[SetDataObject alloc] init] UpdateDataEditItem:@{@"ItemListItems" : self->itemListItems} itemID:self->_itemID itemOccurrenceID:self->_itemOccurrenceID collection:self->itemTypeCollection homeID:self->homeID completionHandler:^(BOOL finished) {
            
            if (totalQueries == (completedQueries+=1)) {
                
                NSMutableDictionary *dictToUse = [@{@"ItemCompletedDict" : self->itemCompletedDict, @"ItemInProgressDict" : self->itemInProgressDict, @"ItemWontDo" : self->itemWontDoDict, @"ItemListItems" : self->itemListItems} mutableCopy];
                
                [self UpdateAllDataInViewController:nil dictToUse:dictToUse];
                
            }
            
        }];
        
    });
    
}

-(void)ResetListItem:(NSString *)existingItemName {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Re-Add List Item"] completionHandler:^(BOOL finished) {
        
    }];
    
//    [self StartProgressView];
    
    NSMutableArray *assignedToArray = [NSMutableArray array];
    
    if ([self->_writeAssignedToTaskTextField.text isEqualToString:@"Anybody"] == NO && self->_writeAssignedToTaskTextField.text.length > 0) {
        
        NSString *userID = @"";
        
        if ([self->_homeMembersDict[@"Username"] containsObject:self->_writeAssignedToTaskTextField.text]) {
            
            NSUInteger index = [self->_homeMembersDict[@"Username"] indexOfObject:self->_writeAssignedToTaskTextField.text];
            userID = self->_homeMembersDict[@"UserID"][index];
            
        } else {
            
            userID = self->itemCreatedBy;
            
        }
        
        [assignedToArray addObject:userID];
    }
    
    [self->itemListItems setObject:@{@"Assigned To" : assignedToArray, @"Status" : @"Uncompleted"} forKey:existingItemName];
    
    if ([[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:self->itemCompletedDict userIDToFind:existingItemName]) {
        [self->itemCompletedDict removeObjectForKey:existingItemName];
    }
    
    if ([[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:self->itemInProgressDict userIDToFind:existingItemName]) {
        [self->itemInProgressDict removeObjectForKey:existingItemName];
    }
    
    __block int totalQueries = 2;
    __block int completedQueries = 0;
    
    
    
    //Remove Loading
    
    NSMutableDictionary *dictToUse = [@{@"ItemCompletedDict" : self->itemCompletedDict, @"ItemInProgressDict" : self->itemInProgressDict, @"ItemWontDo" : self->itemWontDoDict, @"ItemListItems" : self->itemListItems} mutableCopy];
    
    [self UpdateAllDataInViewController:nil dictToUse:dictToUse];
    
    //
    
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSMutableDictionary *singleObjectItemDict = [[[GeneralObject alloc] init] GenerateSingleObjectDictionary:[self->itemDict mutableCopy] keyArray:[self->keyArray mutableCopy] indexPath:nil];
        
        
        
        NSString *notificationType = [[[NotificationsObject alloc] init] NotificationSettingsUnknownItemType_Adding:NO Editing:NO Deleting:NO Duplicating:NO Waiving:NO Skipping:NO Pausing:NO Comments:NO
                                                                                                       SkippingTurn:NO RemovingUser:NO
                                                                                                     FullyCompleted:NO Completed:NO InProgress:NO WontDo:NO Accept:NO Decline:NO
                                                                                                            DueDate:NO Reminder:NO
                                                                                                     SubtaskEditing:NO SubtaskDeleting:NO
                                                                                                   SubtaskCompleted:NO SubtaskInProgress:NO SubtaskWontDo:NO SubtaskAccept:NO SubtaskDecline:NO
                                                                                                     AddingListItem:YES EditingListItem:NO DeletingListItem:NO ResetingListItem:NO
                                                                                                EditingItemizedItem:NO DeletingItemizedItem:NO
                                                                                                  GroupChatMessages:NO LiveSupportMessages:NO
                                                                                                 SendingInvitations:NO DeletingInvitations:NO NewHomeMembers:NO HomeMembersMovedOut:NO HomeMembersKickedOut:NO
                                                                                                FeatureForumUpvotes:NO BugForumUpvotes:NO
                                                                                                           itemType:self->itemType];
        
        
        
        NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
        
        
        
        NSString *notificationTitle = [NSString stringWithFormat:@"\"%@\"", self->itemName];
        NSString *notificationBody = [NSString stringWithFormat:@"%@ re-added \"%@\" to this list. 🔄", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"], existingItemName];
        
        
        
        NSMutableArray *usersToSendNotificationTo = [self->itemAssignedToArray mutableCopy];
        
        NSArray *addTheseUsers = @[self->itemCreatedBy];
        NSArray *removeTheseUsers = @[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx"];
        
        usersToSendNotificationTo = [[[[NotificationsObject alloc] init] AddAndRemoveSpecificUsersFromArray:usersToSendNotificationTo addTheseUsers:addTheseUsers removeTheseUsers:removeTheseUsers] mutableCopy];
        
        
        
        [[[NotificationsObject alloc] init] SendPushNotificationToArrayOfUsers_Items:usersToSendNotificationTo
                                                                           dictToUse:singleObjectItemDict
                                                                              homeID:homeID homeMembersArray:self->_homeMembersArray homeMembersDict:self->_homeMembersDict
                                                            notificationSettingsDict:self->_notificationSettingsDict notificationItemType:self->itemType notificationType:notificationType
                                                                           topicDict:self->_topicDict
                                                                 allItemTagsArrays:self->_allItemTagsArrays
                                                               pushNotificationTitle:notificationTitle pushNotificationBody:notificationBody
                                                                   notificationTitle:notificationTitle notificationBody:notificationBody
                                                             SetDataHomeNotification:YES
                                                                RemoveUsersNotInHome:YES
                                                                   completionHandler:^(BOOL finished) {
            
            if (totalQueries == (completedQueries+=1)) {
                
                NSMutableDictionary *dictToUse = [@{@"ItemCompletedDict" : self->itemCompletedDict, @"ItemInProgressDict" : self->itemInProgressDict, @"ItemWontDo" : self->itemWontDoDict, @"ItemListItems" : self->itemListItems} mutableCopy];
                
                [self UpdateAllDataInViewController:nil dictToUse:dictToUse];
                
            }
            
        }];
        
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[SetDataObject alloc] init] UpdateDataEditItem:@{@"ItemCompletedDict" : self->itemCompletedDict, @"ItemInProgressDict" : self->itemInProgressDict, @"ItemListItems" : self->itemListItems} itemID:self->_itemID itemOccurrenceID:self->_itemOccurrenceID collection:self->itemTypeCollection homeID:self->homeID completionHandler:^(BOOL finished) {
            
            if (totalQueries == (completedQueries+=1)) {
                
                NSMutableDictionary *dictToUse = [@{@"ItemCompletedDict" : self->itemCompletedDict, @"ItemInProgressDict" : self->itemInProgressDict, @"ItemWontDo" : self->itemWontDoDict, @"ItemListItems" : self->itemListItems} mutableCopy];
                
                [self UpdateAllDataInViewController:nil dictToUse:dictToUse];
                
            }
            
        }];
        
    });
    
}

-(void)ListItemExistsMessage:(BOOL)ListItemIsCompleted ListItemIsInProgress:(BOOL)ListItemIsInProgress existingItemName:(NSString *)existingItemName {

        
        NSString *message = ListItemIsCompleted == NO && ListItemIsInProgress == NO ? [NSString stringWithFormat:@"\"%@\" already exists", existingItemName] : [NSString stringWithFormat:@"\"%@\" has already been completed, would you like to reset it to uncompleted?", existingItemName];
        NSString *buttonTitle = ListItemIsCompleted == NO && ListItemIsInProgress == NO ? @"Got it" : @"Cancel";
        
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Existing Item Found"
                                                                            message:message
                                                                     preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:buttonTitle
                                                         style:UIAlertActionStyleCancel
                                                       handler:^(UIAlertAction * _Nonnull action) {
            
            [self->_writeTaskTextField resignFirstResponder];
            [self->_writeAssignedToTaskTextField resignFirstResponder];
            
        }];
        
        UIAlertAction *gotIt = [UIAlertAction actionWithTitle:@"Sure"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * _Nonnull action) {
            
            [self ResetListItem:existingItemName];
            
        }];
        
        if (ListItemIsCompleted == YES) {
            [controller addAction:gotIt];
        }
        [controller addAction:cancel];
        [self presentViewController:controller animated:YES completion:nil];

}

#pragma mark - AddItemizedItemItemTypeExpense

-(void)AddItemizedItem {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Add Itemized Item"] completionHandler:^(BOOL finished) {
        
    }];
    
//    [self StartProgressView];
    
    NSString *itemItemizedName = _writeTaskTextField.text;
    
    [itemItemizedItems setObject:@{@"Amount" : _writeAssignedToTaskTextField.text, @"Assigned To" : @[@"Anybody"], @"Status" : @"Uncompleted"} forKey:itemItemizedName];
    
    itemAmount = [self GenerateItemAmountFromItemizedItems];
    
    
    
    __block int totalQueries = 2;
    __block int completedQueries = 0;
    
    
    
    //Remove Loading
    
    NSMutableDictionary *dictToUse = [@{@"ItemCompletedDict" : self->itemCompletedDict, @"ItemInProgressDict" : self->itemInProgressDict, @"ItemWontDo" : self->itemWontDoDict, @"ItemItemizedItems" : self->itemItemizedItems, @"ItemAmount" : self->itemAmount} mutableCopy];

    [self UpdateAllDataInViewController:nil dictToUse:dictToUse];
    
    //
    
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSMutableDictionary *singleObjectItemDict = [[[GeneralObject alloc] init] GenerateSingleObjectDictionary:[self->itemDict mutableCopy] keyArray:[self->keyArray mutableCopy] indexPath:nil];
        
        
        
        NSString *notificationType = [[[NotificationsObject alloc] init] NotificationSettingsUnknownItemType_Adding:NO Editing:NO Deleting:NO Duplicating:NO Waiving:NO Skipping:NO Pausing:NO Comments:NO
                                                                                                       SkippingTurn:NO RemovingUser:NO
                                                                                                     FullyCompleted:NO Completed:NO InProgress:NO WontDo:NO Accept:NO Decline:NO
                                                                                                            DueDate:NO Reminder:NO
                                                                                                     SubtaskEditing:NO SubtaskDeleting:NO
                                                                                                   SubtaskCompleted:NO SubtaskInProgress:NO SubtaskWontDo:NO SubtaskAccept:NO SubtaskDecline:NO
                                                                                                     AddingListItem:YES EditingListItem:NO DeletingListItem:NO ResetingListItem:NO
                                                                                                EditingItemizedItem:NO DeletingItemizedItem:NO
                                                                                                  GroupChatMessages:NO LiveSupportMessages:NO
                                                                                                 SendingInvitations:NO DeletingInvitations:NO NewHomeMembers:NO HomeMembersMovedOut:NO HomeMembersKickedOut:NO
                                                                                                FeatureForumUpvotes:NO BugForumUpvotes:NO
                                                                                                           itemType:self->itemType];
        
        
        
        NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
        
        
        
        NSString *notificationTitle = [NSString stringWithFormat:@"\"%@\"", self->itemName];
        NSString *notificationBody = [NSString stringWithFormat:@"%@ added \"%@\" to this expense. 📝", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"], itemItemizedName];
        
        
        
        NSMutableArray *usersToSendNotificationTo = [self->itemAssignedToArray mutableCopy];
        
        NSArray *addTheseUsers = @[self->itemCreatedBy];
        NSArray *removeTheseUsers = @[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx"];
        
        usersToSendNotificationTo = [[[[NotificationsObject alloc] init] AddAndRemoveSpecificUsersFromArray:usersToSendNotificationTo addTheseUsers:addTheseUsers removeTheseUsers:removeTheseUsers] mutableCopy];
        
        
        
        [[[NotificationsObject alloc] init] SendPushNotificationToArrayOfUsers_Items:usersToSendNotificationTo
                                                                           dictToUse:singleObjectItemDict
                                                                              homeID:homeID homeMembersArray:self->_homeMembersArray homeMembersDict:self->_homeMembersDict
                                                            notificationSettingsDict:self->_notificationSettingsDict notificationItemType:self->itemType notificationType:notificationType
                                                                           topicDict:self->_topicDict
                                                                 allItemTagsArrays:self->_allItemTagsArrays
                                                               pushNotificationTitle:notificationTitle pushNotificationBody:notificationBody
                                                                   notificationTitle:notificationTitle notificationBody:notificationBody
                                                             SetDataHomeNotification:YES
                                                                RemoveUsersNotInHome:YES
                                                                   completionHandler:^(BOOL finished) {
            
            if (totalQueries == (completedQueries+=1)) {
                
                NSMutableDictionary *dictToUse = [@{@"ItemCompletedDict" : self->itemCompletedDict, @"ItemInProgressDict" : self->itemInProgressDict, @"ItemWontDo" : self->itemWontDoDict, @"ItemItemizedItems" : self->itemItemizedItems, @"ItemAmount" : self->itemAmount} mutableCopy];
                
                [self UpdateAllDataInViewController:nil dictToUse:dictToUse];
                
            }
            
        }];
        
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[SetDataObject alloc] init] UpdateDataEditItem:@{@"ItemItemizedItems" : self->itemItemizedItems, @"ItemAmount" : self->itemAmount} itemID:self->_itemID itemOccurrenceID:self->_itemOccurrenceID collection:self->itemTypeCollection homeID:self->homeID completionHandler:^(BOOL finished) {
            
            if (totalQueries == (completedQueries+=1)) {
                
                NSMutableDictionary *dictToUse = [@{@"ItemCompletedDict" : self->itemCompletedDict, @"ItemInProgressDict" : self->itemInProgressDict, @"ItemWontDo" : self->itemWontDoDict, @"ItemItemizedItems" : self->itemItemizedItems, @"ItemAmount" : self->itemAmount} mutableCopy];
                
                [self UpdateAllDataInViewController:nil dictToUse:dictToUse];
                
            }
            
        }];
        
    });
    
}

-(void)ResetItemizedItem:(NSString *)existingItemName {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Re-Add Itemized Item"] completionHandler:^(BOOL finished) {
        
    }];
    
//    [self StartProgressView];
    
    [self->itemItemizedItems setObject:@{@"Amount" : self->_writeAssignedToTaskTextField.text, @"Assigned To" : @[@"Anybody"], @"Status" : @"Uncompleted"} forKey:existingItemName];
    
    
    
    if ([[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:self->itemCompletedDict userIDToFind:existingItemName]) {
        [self->itemCompletedDict removeObjectForKey:existingItemName];
    }
    
    if ([[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:self->itemInProgressDict userIDToFind:existingItemName]) {
        [self->itemInProgressDict removeObjectForKey:existingItemName];
    }
    
    
    
    __block int totalQueries = 2;
    __block int completedQueries = 0;
    
    
    
    //Remove Loading
    
    NSMutableDictionary *dictToUse = [@{@"ItemCompletedDict" : self->itemCompletedDict, @"ItemInProgressDict" : self->itemInProgressDict, @"ItemWontDo" : self->itemWontDoDict, @"ItemItemizedItems" : self->itemItemizedItems} mutableCopy];
    
    [self UpdateAllDataInViewController:nil dictToUse:dictToUse];
    
    //
    
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSMutableDictionary *singleObjectItemDict = [[[GeneralObject alloc] init] GenerateSingleObjectDictionary:[self->itemDict mutableCopy] keyArray:[self->keyArray mutableCopy] indexPath:nil];
        
        
        
        NSString *notificationType = [[[NotificationsObject alloc] init] NotificationSettingsUnknownItemType_Adding:NO Editing:NO Deleting:NO Duplicating:NO Waiving:NO Skipping:NO Pausing:NO Comments:NO
                                                                                                       SkippingTurn:NO RemovingUser:NO
                                                                                                     FullyCompleted:NO Completed:NO InProgress:NO WontDo:NO Accept:NO Decline:NO
                                                                                                            DueDate:NO Reminder:NO
                                                                                                     SubtaskEditing:NO SubtaskDeleting:NO
                                                                                                   SubtaskCompleted:NO SubtaskInProgress:NO SubtaskWontDo:NO SubtaskAccept:NO SubtaskDecline:NO
                                                                                                     AddingListItem:YES EditingListItem:NO DeletingListItem:NO ResetingListItem:NO
                                                                                                EditingItemizedItem:NO DeletingItemizedItem:NO
                                                                                                  GroupChatMessages:NO LiveSupportMessages:NO
                                                                                                 SendingInvitations:NO DeletingInvitations:NO NewHomeMembers:NO HomeMembersMovedOut:NO HomeMembersKickedOut:NO
                                                                                                FeatureForumUpvotes:NO BugForumUpvotes:NO
                                                                                                           itemType:self->itemType];
        
        
        
        NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
        
        
        
        NSString *notificationTitle = [NSString stringWithFormat:@"\"%@\"", self->itemName];
        NSString *notificationBody = [NSString stringWithFormat:@"%@ re-added \"%@\" to this expense. 🔄", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"], existingItemName];
        
        
        
        NSMutableArray *usersToSendNotificationTo = [self->itemAssignedToArray mutableCopy];
        
        NSArray *addTheseUsers = @[self->itemCreatedBy];
        NSArray *removeTheseUsers = @[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx"];
        
        usersToSendNotificationTo = [[[[NotificationsObject alloc] init] AddAndRemoveSpecificUsersFromArray:usersToSendNotificationTo addTheseUsers:addTheseUsers removeTheseUsers:removeTheseUsers] mutableCopy];
        
        
        
        [[[NotificationsObject alloc] init] SendPushNotificationToArrayOfUsers_Items:usersToSendNotificationTo
                                                                           dictToUse:singleObjectItemDict
                                                                              homeID:homeID homeMembersArray:self->_homeMembersArray homeMembersDict:self->_homeMembersDict
                                                            notificationSettingsDict:self->_notificationSettingsDict notificationItemType:self->itemType notificationType:notificationType
                                                                           topicDict:self->_topicDict
                                                                 allItemTagsArrays:self->_allItemTagsArrays
                                                               pushNotificationTitle:notificationTitle pushNotificationBody:notificationBody
                                                                   notificationTitle:notificationTitle notificationBody:notificationBody
                                                             SetDataHomeNotification:YES
                                                                RemoveUsersNotInHome:YES
                                                                   completionHandler:^(BOOL finished) {
            
            if (totalQueries == (completedQueries+=1)) {
                
                NSMutableDictionary *dictToUse = [@{@"ItemCompletedDict" : self->itemCompletedDict, @"ItemInProgressDict" : self->itemInProgressDict, @"ItemWontDo" : self->itemWontDoDict, @"ItemItemizedItems" : self->itemItemizedItems} mutableCopy];
                
                [self UpdateAllDataInViewController:nil dictToUse:dictToUse];
                
            }
            
        }];
        
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[SetDataObject alloc] init] UpdateDataEditItem:@{@"ItemCompletedDict" : self->itemCompletedDict, @"ItemInProgressDict" : self->itemInProgressDict, @"ItemItemizedItems" : self->itemItemizedItems} itemID:self->_itemID itemOccurrenceID:self->_itemOccurrenceID collection:self->itemTypeCollection homeID:self->homeID completionHandler:^(BOOL finished) {
            
            if (totalQueries == (completedQueries+=1)) {
                
                NSMutableDictionary *dictToUse = [@{@"ItemCompletedDict" : self->itemCompletedDict, @"ItemInProgressDict" : self->itemInProgressDict, @"ItemWontDo" : self->itemWontDoDict, @"ItemItemizedItems" : self->itemItemizedItems} mutableCopy];
                
                [self UpdateAllDataInViewController:nil dictToUse:dictToUse];
                
            }
            
        }];
        
    });
    
}

-(void)ItemizedItemMessage:(BOOL)ItemizedItemIsCompleted ItemizedItemIsInProgress:(BOOL)ItemizedItemIsInProgress existingItemName:(NSString *)existingItemName {
        
        NSString *message = ItemizedItemIsCompleted == NO && ItemizedItemIsInProgress == NO ? [NSString stringWithFormat:@"\"%@\" already exists", existingItemName] : [NSString stringWithFormat:@"\"%@\" has already been completed, would you like to reset it to uncompleted?", existingItemName];
        NSString *buttonTitle = ItemizedItemIsCompleted == NO && ItemizedItemIsInProgress == NO ? @"Got it" : @"Cancel";
        
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Existing Item Found"
                                                                            message:message
                                                                     preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:buttonTitle
                                                         style:UIAlertActionStyleCancel
                                                       handler:^(UIAlertAction * _Nonnull action) {
            
            [self->_writeTaskTextField resignFirstResponder];
            [self->_writeAssignedToTaskTextField resignFirstResponder];
            
        }];
        
        UIAlertAction *gotIt = [UIAlertAction actionWithTitle:@"Sure"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * _Nonnull action) {
            
            [self ResetItemizedItem:existingItemName];
            
        }];
        
        if (ItemizedItemIsCompleted == YES) {
            [controller addAction:gotIt];
        }
        [controller addAction:cancel];
        [self presentViewController:controller animated:YES completion:nil];
 
}

#pragma mark - IBAction Methods

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


#pragma mark -
#pragma mark
#pragma mark
#pragma mark Sub-Sub-Internal Methods
#pragma mark
#pragma mark
#pragma mark -

-(void)SetDataGeneral:(NSMutableDictionary *)viewDataDict {

    //Expenses
    if (self->_viewingViewExpenseViewController) {
        
        self->itemAmount = viewDataDict[@"ItemAmount"] ? viewDataDict[@"ItemAmount"] : @"";
        self->itemCostPerPersonDict = viewDataDict[@"ItemCostPerPerson"] ? [viewDataDict[@"ItemCostPerPerson"] mutableCopy] : [NSMutableDictionary dictionary];
        self->itemPaymentMethodDict = viewDataDict[@"ItemPaymentMethod"] ? [viewDataDict[@"ItemPaymentMethod"] mutableCopy] : [NSMutableDictionary dictionary];
        self->itemItemized = viewDataDict[@"ItemItemized"] ? viewDataDict[@"ItemItemized"] : @"";
        self->itemItemizedItems = viewDataDict[@"ItemItemizedItems"] ? [viewDataDict[@"ItemItemizedItems"] mutableCopy] : [NSMutableDictionary dictionary];
        
        //Lists
    } else if (self->_viewingViewListViewController) {
        
        self->itemListItems = viewDataDict[@"ItemListItems"] ? [viewDataDict[@"ItemListItems"] mutableCopy] : [NSMutableDictionary dictionary];
        
        //Chores
    } else {
        
        self->itemMustComplete = viewDataDict[@"ItemMustComplete"] ? viewDataDict[@"ItemMustComplete"] : @"";
        self->itemSubTasksDict = viewDataDict[@"ItemSubTasks"] ? [viewDataDict[@"ItemSubTasks"] mutableCopy] : [NSMutableDictionary dictionary];
        
    }
    
    self->itemUniqueID = viewDataDict[@"ItemUniqueID"] ? viewDataDict[@"ItemUniqueID"] : @"";
    self->itemName = viewDataDict[@"ItemName"] ? viewDataDict[@"ItemName"] : @"";
    self->itemDueDate = viewDataDict[@"ItemDueDate"] ? viewDataDict[@"ItemDueDate"] : @"";
    self->itemCompleteAsNeeded = viewDataDict[@"ItemCompleteAsNeeded"] ? viewDataDict[@"ItemCompleteAsNeeded"] : @"";
    self->itemDatePosted = viewDataDict[@"ItemDatePosted"] ? viewDataDict[@"ItemDatePosted"] : @"";
    self->itemCreatedBy = viewDataDict[@"ItemCreatedBy"] ? viewDataDict[@"ItemCreatedBy"] : @"";
    self->itemPrivate = viewDataDict[@"ItemPrivate"] ? viewDataDict[@"ItemPrivate"] : @"";
    self->itemScheduledStart = viewDataDict[@"ItemScheduledStart"] ? viewDataDict[@"ItemScheduledStart"] : @"";
    self->itemSpecificDueDatesArray = viewDataDict[@"ItemSpecificDueDates"] ? [viewDataDict[@"ItemSpecificDueDates"] mutableCopy] : [NSMutableArray array];
    self->itemAssignedToArray = viewDataDict[@"ItemAssignedTo"] ? [viewDataDict[@"ItemAssignedTo"] mutableCopy] : [NSMutableArray array];
    self->itemCompletedDict = viewDataDict[@"ItemCompletedDict"] ? [viewDataDict[@"ItemCompletedDict"] mutableCopy] : [NSMutableDictionary dictionary];
    self->itemInProgressDict = viewDataDict[@"ItemInProgressDict"] ? [viewDataDict[@"ItemInProgressDict"] mutableCopy] : [NSMutableDictionary dictionary];
    self->itemWontDoDict = viewDataDict[@"ItemWontDo"] ? [viewDataDict[@"ItemWontDo"] mutableCopy] : [NSMutableDictionary dictionary];
    self->itemDueDatesSkippedArray = viewDataDict[@"ItemDueDatesSkipped"] ? [viewDataDict[@"ItemDueDatesSkipped"] mutableCopy] : [NSMutableArray array];
    self->itemNotes = viewDataDict[@"ItemNotes"] ? viewDataDict[@"ItemNotes"] : @"";
    self->itemRepeats = viewDataDict[@"ItemRepeats"] ? viewDataDict[@"ItemRepeats"] : @"";
    self->itemRepeatIfCompletedEarly = viewDataDict[@"ItemRepeatIfCompletedEarly"] ? viewDataDict[@"ItemRepeatIfCompletedEarly"] : @"";
    self->itemTakeTurns = viewDataDict[@"ItemTakeTurns"] ? viewDataDict[@"ItemTakeTurns"] : @"";
    self->itemDays = viewDataDict[@"ItemDays"] ? viewDataDict[@"ItemDays"] : @"";
    self->itemTime = viewDataDict[@"ItemTime"] ? viewDataDict[@"ItemTime"] : @"";
    self->itemReminderDict = viewDataDict[@"ItemReminderDict"] ? viewDataDict[@"ItemReminderDict"] : @{};
    self->itemStartDate = viewDataDict[@"ItemStartDate"] ? viewDataDict[@"ItemStartDate"] : @"";
    self->itemEndDate = viewDataDict[@"ItemEndDate"] ? viewDataDict[@"ItemEndDate"] : @"";
    self->itemApprovalNeeded = viewDataDict[@"ItemApprovalNeeded"] ? viewDataDict[@"ItemApprovalNeeded"] : @"";
    self->itemApprovalRequestsDict = viewDataDict[@"ItemApprovalRequests"] ? [viewDataDict[@"ItemApprovalRequests"] mutableCopy] : [NSMutableDictionary dictionary];
    self->itemRewardDict = viewDataDict[@"ItemReward"] ? [viewDataDict[@"ItemReward"] mutableCopy] : [NSMutableDictionary dictionary];
    self->itemTrash = viewDataDict[@"ItemTrash"] ? viewDataDict[@"ItemTrash"] : @"";
    self->itemTagsArray = viewDataDict[@"ItemTags"] ? [viewDataDict[@"ItemTags"] mutableCopy] : [NSMutableArray array];
    self->itemImageURL = viewDataDict[@"ItemImageURL"] ? viewDataDict[@"ItemImageURL"] : @"";
    self->itemPriority = viewDataDict[@"ItemPriority"] ? viewDataDict[@"ItemPriority"] : @"";
    self->itemColor = viewDataDict[@"ItemColor"] ? viewDataDict[@"ItemColor"] : @"";
    
    self->itemTurnUserID = [[[GeneralObject alloc] init] GenerateCurrentUserTurnFromDict:[viewDataDict mutableCopy] homeMembersDict:_homeMembersDict itemType:itemType];
    self->itemStatus = viewDataDict[@"ItemStatus"] ? viewDataDict[@"ItemStatus"] : @"None";
    self->itemOccurrenceStatus = viewDataDict[@"ItemOccurrenceStatus"] ? viewDataDict[@"ItemOccurrenceStatus"] : @"None";
    self->itemPhotoConfirmationDict = viewDataDict[@"ItemPhotoConfirmationDict"] ? [viewDataDict[@"ItemPhotoConfirmationDict"] mutableCopy] : [NSMutableDictionary dictionary];
    self->itemPhotoConfirmation = viewDataDict[@"ItemPhotoConfirmation"] && [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:viewDataDict[@"ItemPhotoConfirmation"] classArr:@[[NSString class]]] ? viewDataDict[@"ItemPhotoConfirmation"] : @"No";
    
    
    
    ItemizedItemsVisible = [itemType isEqualToString:@"Expense"] && [itemItemized isEqualToString:@"Yes"];
    ListItemsVisible = [itemType isEqualToString:@"List"];
    
    UserCellsVisible = ([itemType isEqualToString:@"Chore"] || [itemType isEqualToString:@"Expense"]) && ItemizedItemsVisible == NO;
    NonUserCellsVisible = (ListItemsVisible == YES || ItemizedItemsVisible == YES);
    SubtaskCellsVisible = [itemType isEqualToString:@"Chore"] && [[itemSubTasksDict allKeys] count] > 0;
    
    
    
    NSString *listName = @"No List";
  
    for (NSString *taskListID in _taskListDict[@"TaskListID"]) {
        
        NSUInteger index = [_taskListDict[@"TaskListID"] indexOfObject:taskListID];
        
        NSMutableDictionary *taskListItems = [(NSArray *)_taskListDict[@"TaskListItems"] count] > index ? _taskListDict[@"TaskListItems"][index] : [NSMutableDictionary dictionary];
       
        if ([[taskListItems allKeys] containsObject:itemUniqueID]) {
            
            listName = [(NSArray *)_taskListDict[@"TaskListName"] count] > index ? _taskListDict[@"TaskListName"][index] : @"";
            break;
            
        }
        
    }
    
    [self UpdateTopViewLabel:listName];
    
    
    
    [self GenerateReminderFrequencyArray];
    
    
    
    UIImage *imageToReturn = nil;
    
    if ([itemPriority isEqualToString:@"High"]) {
        
        imageToReturn = [UIImage imageNamed:@"MainCellIcons.HighPriority"];
        
    } else if ([itemPriority isEqualToString:@"Medium"]) {
        
        imageToReturn = [UIImage imageNamed:@"MainCellIcons.MediumPriority"];
        
    } else if ([itemPriority isEqualToString:@"Low"]) {
        
        imageToReturn = [UIImage imageNamed:@"MainCellIcons.LowPriority"];
        
    }
    
    _viewItemItemPriorityImage.hidden = NO;
    _viewItemItemPriorityImage.image = imageToReturn;
    
    
    
    NSString *colorString = itemColor;
    UIColor *colorColor = [[[GeneralObject alloc] init] GenerateColorOptionFromColorString:colorString];
    
    _viewItemItemColor.backgroundColor = colorColor;
    
    
    
    self->itemAssignedUsernameArray = [NSMutableArray array];
    self->itemAssignedProfileImageURLArray = [NSMutableArray array];
    
    for (NSString *userID in [itemAssignedToArray mutableCopy]) {
        
        NSDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:userID homeMembersDict:_homeMembersDict];
        
        if ([dataDict[@"Username"] length] > 0) {
            
            [itemAssignedUsernameArray addObject:dataDict[@"Username"]];
            [itemAssignedProfileImageURLArray addObject:dataDict[@"ProfileImageURL"]];
            
        } else {
            
            [itemAssignedToArray removeObject:userID];
            
        }
        
    }
    
    if (itemAssignedToArray.count == 0) {
        
        itemAssignedToArray = [_homeMembersDict[@"UserID"] mutableCopy];
        itemAssignedUsernameArray = [_homeMembersDict[@"Username"] mutableCopy];
        itemAssignedProfileImageURLArray = [_homeMembersDict[@"ProfileImageURL"] mutableCopy];
        
    }
    
    
    
    if ([self->_homeMembersDict[@"UserID"] containsObject:self->itemCreatedBy]) {
        
        NSUInteger index = [self->_homeMembersDict[@"UserID"] indexOfObject:self->itemCreatedBy];
        self->itemCreatedByUsername = self->_homeMembersDict[@"Username"][index];
        
    } else {
        
        self->itemCreatedByUsername = @"";
        
    }
    
    
    
    NSString *itemitemDueDateLabelText = [NSString stringWithFormat:@"Due %@", self->itemDueDate];
    
    
    
    BOOL TaskIsRepeatingHourly = [[[BoolDataObject alloc] init] TaskIsRepeatingHourly:self->itemDict itemType:itemType];
    
    if ([self->itemTime isEqualToString:@"Any Time"] && TaskIsRepeatingHourly == NO) {
        itemitemDueDateLabelText = [[[GeneralObject alloc] init] GenerateStringWithReplacementString:itemitemDueDateLabelText stringToReplace:@"11:59 PM" replacementString:@"Any Time"];
    }
    
    
    
    if ([self->itemStatus isEqualToString:@"Paused"]) {
        itemitemDueDateLabelText = @"Paused";
    }
    
    
    
    _viewItemNameLabel.text = self->itemName;
    _viewItemitemDueDateLabel.text = [self GenerateItemDueDateLabelText];
    _viewItemNotesLabel.text = self->itemNotes;
    
    
    
    if ([self->itemImageURL containsString:@"gs://"]) {
        
        [[[GetDataObject alloc] init] GetDataItemImage:self->itemImageURL completionHandler:^(BOOL finished, NSURL * _Nonnull itemImageURL) {
            
            NSData *data = [NSData dataWithContentsOfURL:itemImageURL];
            UIImage *image = [UIImage imageWithData:data];
            
            self->itemImage = image;
            self->_viewItemImageView.image = image;
            
            [self SetUpItemViewContextMenu];
            
        }];
        
    } else {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self->itemImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self->itemImageURL]]];
            self->_viewItemImageView.image = self->itemImage;
            
            [self SetUpItemViewContextMenu];
            
        });
        
    }
    
    
    if ([itemNotes length] > 0) {
        
        NSInteger numberOfLines = [[[GeneralObject alloc] init] LineCountForText:self->itemNotes label:_viewItemNotesLabel];
        
        [UIView animateWithDuration:0.25 animations:^{
            
            CGRect newRect = self->_viewItemNotesLabel.frame;
            newRect.size.height = (self.view.frame.size.height*0.02309783)*numberOfLines;
            self->_viewItemNotesLabel.frame = newRect;
            
            newRect = self->_viewItemView.frame;
            newRect.size.height = self-> _viewItemNotesLabel.frame.origin.y + self->_viewItemNotesLabel.frame.size.height + (self.view.frame.size.height*0.01630435);
            self->_viewItemView.frame = newRect;
            
            self->_viewItemViewOverlay.frame = self->_viewItemView.frame;
            
            [self ViewItemViewInnerViews];
            
            [self AdjustTableViewFrames];
            
        }];
        
    } else {
        
        [UIView animateWithDuration:0.25 animations:^{
            
            CGFloat height = CGRectGetHeight(self.view.bounds);
            CGFloat width = CGRectGetWidth(self.view.bounds);
            
            self->_viewItemView.frame = CGRectMake((width*0.5 - ((width*0.90338164)*0.5)), height*0.0271739, width*0.90338164, ((self.view.frame.size.height*0.11005435 > 81?(81):self.view.frame.size.height*0.11005435)*0.7037037));
            
            height = CGRectGetHeight(self->_viewItemView.bounds);
            width = CGRectGetWidth(self->_viewItemView.bounds);
            //374, 57
            
            [self ViewItemViewInnerViews];
            
            [self AdjustTableViewFrames];
            
        }];
        
    }
    
    
    
    _viewPaymentMethodNameLabel.text = self->itemPaymentMethodDict[@"PaymentMethod"];
    _viewPaymentMethodDataLabel.text = self->itemPaymentMethodDict[@"PaymentMethodData"];
    _viewPaymentMethodNotesLabel.text = self->itemPaymentMethodDict[@"PaymentMethodNotes"];
    
    _viewRewardNameLabel.text = self->itemRewardDict[@"Reward"];
    _viewRewardDescriptionLabel.text = self->itemRewardDict[@"RewardDescription"];
    _viewRewardNotesLabel.text = self->itemRewardDict[@"RewardNotes"];
    
    
    
    if ([self->itemPaymentMethodDict[@"PaymentMethodNotes"] length] > 0) {
        
        NSInteger numberOfLines = [[[GeneralObject alloc] init] LineCountForText:self->itemPaymentMethodDict[@"PaymentMethodNotes"] label:_viewPaymentMethodNotesLabel];
        
        [UIView animateWithDuration:0.25 animations:^{
            
            CGRect newRect = self->_viewPaymentMethodNotesLabel.frame;
            newRect.size.height = (self.view.frame.size.height*0.02309783)*numberOfLines;
            self->_viewPaymentMethodNotesLabel.frame = newRect;
            
            newRect = self->_viewPaymentMethodView.frame;
            newRect.size.height = self->_viewPaymentMethodNotesLabel.frame.origin.y + self->_viewPaymentMethodNotesLabel.frame.size.height + (self.view.frame.size.height*0.017991 > 12?(12):self.view.frame.size.height*0.017991);
            self->_viewPaymentMethodView.frame = newRect;
            
            self->_viewPaymentMethodViewOverlay.frame = self->_viewPaymentMethodView.frame;
            
            [self AdjustTableViewFrames];
            
        }];
        
    } else {
        
        [UIView animateWithDuration:0.25 animations:^{
            
            CGFloat height = CGRectGetHeight(self.view.bounds);
            CGFloat width = CGRectGetWidth(self.view.bounds);
            
            self->_viewPaymentMethodView.frame = CGRectMake((width*0.5 - ((width*0.90338164)*0.5)), self->_viewItemView.frame.origin.y + self->_viewItemView.frame.size.height + (self.view.frame.size.height*0.017991 > 12?(12):self.view.frame.size.height*0.017991), width*0.90338164, ((self.view.frame.size.height*0.11005435 > 81?(81):self.view.frame.size.height*0.11005435)*0.7037037));
            
            height = CGRectGetHeight(self->_viewPaymentMethodView.bounds);
            width = CGRectGetWidth(self->_viewPaymentMethodView.bounds);
            //374, 57
            
            [self ViewPaymentMethodViewInnerViews];
            
            [self AdjustTableViewFrames];
            
        }];
        
    }
    
    
    
    if ([self->itemRewardDict[@"RewardNotes"] length] > 0) {
        
        NSInteger numberOfLines = [[[GeneralObject alloc] init] LineCountForText:self->itemRewardDict[@"RewardNotes"] label:_viewRewardNotesLabel];
        
        [UIView animateWithDuration:0.25 animations:^{
            
            CGRect newRect = self->_viewRewardNotesLabel.frame;
            newRect.size.height = (self.view.frame.size.height*0.02309783)*numberOfLines;
            self->_viewRewardNotesLabel.frame = newRect;
            
            UIView *viewToUse = self->_viewingViewExpenseViewController == YES && self->itemPaymentMethodDict[@"PaymentMethod"] && [self->itemPaymentMethodDict[@"PaymentMethod"] isEqualToString:@"None"] == NO ? self->_viewPaymentMethodView : self->_viewItemView;
            
            newRect = self->_viewRewardView.frame;
            newRect.origin.y = viewToUse.frame.origin.y + viewToUse.frame.size.height + (self.view.frame.size.height*0.017991 > 12?(12):self.view.frame.size.height*0.017991) ;
            newRect.size.height = self->_viewRewardNotesLabel.frame.origin.y + self->_viewRewardNotesLabel.frame.size.height + (self.view.frame.size.height*0.01630435);
            self->_viewRewardView.frame = newRect;
            
            self->_viewRewardViewOverlay.frame = self->_viewRewardView.frame;
            
            [self AdjustTableViewFrames];
            
        }];
        
    } else {
        
        [UIView animateWithDuration:0.25 animations:^{
            
            CGFloat height = CGRectGetHeight(self.view.bounds);
            CGFloat width = CGRectGetWidth(self.view.bounds);
            
            self->_viewRewardView.frame = CGRectMake((width*0.5 - ((width*0.90338164)*0.5)), self->_viewItemView.frame.origin.y + self->_viewItemView.frame.size.height + (self.view.frame.size.height*0.017991 > 12?(12):self.view.frame.size.height*0.017991), width*0.90338164, ((self.view.frame.size.height*0.11005435 > 81?(81):self.view.frame.size.height*0.11005435)*0.7037037));
            
            height = CGRectGetHeight(self->_viewRewardView.bounds);
            width = CGRectGetWidth(self->_viewRewardView.bounds);
            //374, 57
            
            [self ViewRewardViewInnerViews];
            
            [self AdjustTableViewFrames];
            
        }];
        
    }
    
    
    
    if ([_viewItemitemDueDateLabel.text containsString:@"No Due Date"]) {
        _viewItemitemDueDateLabel.text = @"No Due Date";
    }
    
    
    
    BOOL TaskIsCompleteAsNeeded = [[[BoolDataObject alloc] init] TaskIsCompleteAsNeeded:itemDict itemType:itemType];
    
    if (TaskIsCompleteAsNeeded == YES) {
        _viewItemitemDueDateLabel.text = [self GenerateCompletedLabelItemCompleteAsNeeded:itemDict];
    }
    
    
    
    BOOL TaskIsScheduledStart = [[[BoolDataObject alloc] init] TaskIsScheduledStart:[@{@"ItemScheduledStart" : self->itemScheduledStart} mutableCopy] itemType:self->itemType];
    BOOL TaskIsScheduledStartHasPassed = [[[BoolDataObject alloc] init] TaskIsScheduledStartHasPassed:[@{@"ItemScheduledStart" : self->itemScheduledStart} mutableCopy] itemType:self->itemType];
    
    if (TaskIsScheduledStart == YES && TaskIsScheduledStartHasPassed == NO) {
        
        NSString *itemDatePosted = [[[GeneralObject alloc] init] GenerateDateWithConvertedFormatWithFormat:@"yyyy-MM-dd HH:mm:ss" dateToConvert:self->itemDatePosted newFormat:@"MMMM dd, yyyy hh:mm a" returnAs:[NSString class]];
        
        NSString *left = [[[GeneralObject alloc] init] GenerateDisplayTimeUntilDisplayTimeStartingFromCustomStartDate:self->itemScheduledStart itemDueDate:itemDatePosted  shortStyle:NO reallyShortStyle:NO];
        
        left = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:left arrayOfSymbols:@[@" left"]];
        
        _viewItemitemDueDateLabel.text = [NSString stringWithFormat:@"Scheduled to begin in %@", left];
        
    }
    
    
    
    writeTaskAssignedToArray = [NSMutableArray array];
    [writeTaskAssignedToArray addObject:@""];
    
    for (NSString *username in itemAssignedUsernameArray) {
        [writeTaskAssignedToArray addObject:username];
    }
    
    if ([writeTaskAssignedToArray containsObject:itemCreatedByUsername] == NO && itemCreatedByUsername != nil && itemCreatedByUsername != NULL) {
        [writeTaskAssignedToArray addObject:itemCreatedByUsername];
    }
    
    _writeTaskContainerView.hidden = (NonUserCellsVisible == YES && _viewingOccurrence == NO) ? NO : YES;
  
}

-(void)UpdateViews {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self AdjustTableViewFrames];
        
        [self GenerateWriteTaskHiddenStatus];
        
        [self GeneratePaymentMethodViewHiddenStatus];
        
        [self GenerateRewardViewHiddenStatus];
        
        [self SetUpItemViewContextMenu];
        
        [self SetUpItemPaymentMethodContextMenu];
        
        [self SetUpItemRewardContextMenu];
        
        [self GenerateSectionDictionary];
        
        [self AdjustScrollViewFrames];
        
        [self.customTableView reloadData];
        [self.subTasksTableView reloadData];
        
        [self->progressView setHidden:YES];
        
    });
    
}

-(void)CalculateItemProgressBarWidth {
    
    self->totalCompletedArray = [NSMutableArray array];
    self->totalCompletedSubTaskArray = [NSMutableArray array];
    
    
    
    if ([self->itemRepeats isEqualToString:@"Never"] == NO && [self->itemRepeatIfCompletedEarly isEqualToString:@"Yes"] == NO && self->itemRepeats.length > 0) {
        
        
        
        //Current Task Analytics
        
        int totalOccurrencesOfSpecificTask = 0;
        int totalCompletionsOfSpecificTask = 0;
        
        for (int i=0;i<[(NSArray *)self->itemxxxOccurrencesDict[@"ItemID"] count];i++) {
            
            NSMutableDictionary *itemCompletedDict = self->itemxxxOccurrencesDict[@"ItemCompletedDict"] && [(NSArray *)self->itemxxxOccurrencesDict[@"ItemCompletedDict"] count] > i ? [self->itemxxxOccurrencesDict[@"ItemCompletedDict"][i] mutableCopy] : [NSMutableDictionary dictionary];
            NSMutableArray *itemAssignedTo = self->itemxxxOccurrencesDict[@"ItemAssignedTo"] && [(NSArray *)self->itemxxxOccurrencesDict[@"ItemAssignedTo"] count] > i ? [self->itemxxxOccurrencesDict[@"ItemAssignedTo"][i] mutableCopy] : [NSMutableArray array];
            //            NSMutableArray *itemDueDatesSkipped = [self->occurrencesDict[@"ItemDueDatesSkipped"][i] mutableCopy];
            //            NSString *itemRepeats = self->occurrencesDict[@"ItemRepeats"][i];
            //            NSString *itemTakeTurns = self->occurrencesDict[@"ItemTakeTurns"][i];
            //            NSString *itemDueDate = self->occurrencesDict[@"ItemDueDate"][i];
            //            NSString *itemDatePosted = self->occurrencesDict[@"ItemDatePosted"][i];
            //            NSString *itemTime = self->occurrencesDict[@"ItemTime"][i];
            //            NSString *itemDays = self->occurrencesDict[@"ItemDays"][i];
            //            NSString *itemStartDate = self->occurrencesDict[@"ItemStartDate"][i];
            
            BOOL TaskIsRepeating = [[[BoolDataObject alloc] init] TaskIsRepeating:self->itemDict itemType:itemType];
            BOOL TaskIsTakingTurns = [[[BoolDataObject alloc] init] TaskIsTakingTurns:self->itemDict itemType:itemType];
            
            NSString *userIDWhosTurnItIs = self->itemTurnUserID;
            
            totalOccurrencesOfSpecificTask += 1;
            
            if (
                
                (TaskIsRepeating == YES && TaskIsTakingTurns == NO &&
                 ([[itemCompletedDict allKeys] count] == [itemAssignedTo count])) ||
                
                (TaskIsRepeating == YES && TaskIsTakingTurns == YES &&
                 (([[itemCompletedDict allKeys] count] == 1 && [[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemCompletedDict userIDToFind:userIDWhosTurnItIs])))
                
                ) {
                    
                    totalCompletionsOfSpecificTask += 1;
                    
                }
            
        }
        
        
        
        
        
        
        
        //Add Current Task to Current Task Analytics
        
        BOOL TaskIsRepeating = [[[BoolDataObject alloc] init] TaskIsRepeating:self->itemDict itemType:itemType];
        BOOL TaskIsTakingTurns = [[[BoolDataObject alloc] init] TaskIsTakingTurns:self->itemDict itemType:itemType];
        
        totalOccurrencesOfSpecificTask += 1;
        
        if (TaskIsRepeating == YES && TaskIsTakingTurns == NO) {
            
            if ([[self->itemCompletedDict allKeys] count] == [self->itemAssignedToArray count]) {
                totalCompletionsOfSpecificTask += 1;
            }
            
        } else if (TaskIsRepeating == YES && TaskIsTakingTurns == YES) {
            
            NSString *userIDWhosTurnItIs = self->itemTurnUserID;
            
            if (([[itemCompletedDict allKeys] count] == 1 && [[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemCompletedDict userIDToFind:userIDWhosTurnItIs])) {
                totalCompletionsOfSpecificTask += 1;
            }
            
        }
        
        
        
        
        
        
        
        //Individual Analytics
        
        for (NSString *userID in self->itemAssignedToArray) {
            
            int totalOccurrencesOfSpecificUser = 0;
            int totalCompletionsOfSpecificUser = 0;
            
            for (int i=0;i<[(NSArray *)self->itemxxxOccurrencesDict[@"ItemID"] count];i++) {
                
                NSMutableDictionary *itemCompletedDict = self->itemxxxOccurrencesDict[@"ItemCompletedDict"] && [(NSArray *)self->itemxxxOccurrencesDict[@"ItemCompletedDict"] count] > i ? [self->itemxxxOccurrencesDict[@"ItemCompletedDict"][i] mutableCopy] : [NSMutableDictionary dictionary];
                NSMutableArray *itemAssignedTo = self->itemxxxOccurrencesDict[@"ItemAssignedTo"] && [(NSArray *)self->itemxxxOccurrencesDict[@"ItemAssignedTo"] count] > i ? [self->itemxxxOccurrencesDict[@"ItemAssignedTo"][i] mutableCopy] : [NSMutableArray array];
                //                NSMutableArray *itemDueDatesSkipped = [self->occurrencesDict[@"ItemDueDatesSkipped"][i] mutableCopy];
                //                NSString *itemRepeats = self->occurrencesDict[@"ItemRepeats"][i];
                //                NSString *itemTakeTurns = self->occurrencesDict[@"ItemTakeTurns"][i];
                //                NSString *itemDueDate = self->occurrencesDict[@"ItemDueDate"][i];
                //                NSString *itemDatePosted = self->occurrencesDict[@"ItemDatePosted"][i];
                //                NSString *itemTime = self->occurrencesDict[@"ItemTime"][i];
                //                NSString *itemDays = self->occurrencesDict[@"ItemDays"][i];
                //                NSString *itemStartDate = self->occurrencesDict[@"ItemStartDate"][i];
                
                BOOL TaskIsRepeating = [[[BoolDataObject alloc] init] TaskIsRepeating:self->itemDict itemType:itemType];
                BOOL TaskIsTakingTurns = [[[BoolDataObject alloc] init] TaskIsTakingTurns:self->itemDict itemType:itemType];
                
                if (TaskIsRepeating == YES && TaskIsTakingTurns == NO) {
                    
                    if ([[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemCompletedDict userIDToFind:userID]) {
                        totalCompletionsOfSpecificUser += 1;
                    }
                    
                    if ([itemAssignedTo containsObject:userID]) {
                        totalOccurrencesOfSpecificUser += 1;
                    }
                    
                } else if (TaskIsRepeating == YES && TaskIsTakingTurns == YES) {
                    
                    NSString *userIDWhosTurnItIs = self->itemTurnUserID;
                    
                    if ([userIDWhosTurnItIs isEqualToString:userID]) {
                        
                        if ([itemAssignedTo containsObject:userID]) {
                            totalOccurrencesOfSpecificUser += 1;
                        }
                        
                        
                    }
                    
                }
                
            }
            
            
            
            
            
            
            
            //Add Current Task to Individual Analytics
            
            BOOL TaskIsRepeating = [[[BoolDataObject alloc] init] TaskIsRepeating:self->itemDict itemType:itemType];
            BOOL TaskIsTakingTurns = [[[BoolDataObject alloc] init] TaskIsTakingTurns:self->itemDict itemType:itemType];
            
            if (TaskIsRepeating == YES && TaskIsTakingTurns == NO) {
                
                if ([[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:self->itemCompletedDict userIDToFind:userID]) {
                    totalCompletionsOfSpecificUser += 1;
                }
                if ([self->itemAssignedToArray containsObject:userID]) {
                    totalOccurrencesOfSpecificUser += 1;
                }
                
            } else if (TaskIsRepeating == YES && TaskIsTakingTurns == YES) {
                
                NSString *userIDWhosTurnItIs = self->itemTurnUserID;
                
                if ([userIDWhosTurnItIs isEqualToString:userID]) {
                    
                    if ([[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:self->itemCompletedDict userIDToFind:userID]) {
                        totalCompletionsOfSpecificUser += 1;
                    }
                    if ([self->itemAssignedToArray containsObject:userID]) {
                        totalOccurrencesOfSpecificUser += 1;
                    }
                    
                }
                
            }
            
            [self->totalCompletedArray addObject:@{@"TotalAssigned" : [NSString stringWithFormat:@"%d", totalOccurrencesOfSpecificUser], @"TotalCompleted" : [NSString stringWithFormat:@"%d", totalCompletionsOfSpecificUser]}];
            
        }
        
        
        
        
        
        
        
        //SubTask Analytics
        
        for (NSString *subTask in [self->itemSubTasksDict allKeys]) {
            
            int totalOccurrencesOfSpecificSubTask = 0;
            int totalCompletionsOfSpecificSubTask = 0;
            
            for (int i=0;i<[(NSArray *)self->itemxxxOccurrencesDict[@"ItemID"] count];i++) {
                
                NSMutableDictionary *itemSubTasks = self->itemxxxOccurrencesDict[@"ItemSubTasks"] && [(NSArray *)self->itemxxxOccurrencesDict[@"ItemSubTasks"] count] > i ? [self->itemxxxOccurrencesDict[@"ItemSubTasks"][i] mutableCopy] : [NSMutableDictionary dictionary];
                
                if ([[itemSubTasks allKeys] containsObject:subTask]) {
                    
                    totalOccurrencesOfSpecificSubTask += 1;
                    
                    if (itemSubTasks[subTask] && itemSubTasks[subTask][@"Completed Dict"] && [[itemSubTasks[subTask][@"Completed Dict"] allKeys] count] > 0) {
                        totalCompletionsOfSpecificSubTask += 1;
                    }
                    
                }
                
            }
            
            
            
            
            
            
            
            //Add Current Task to SubTask Analytics
            
            if ([[itemSubTasksDict allKeys] containsObject:subTask]) {
                
                totalOccurrencesOfSpecificSubTask += 1;
                
                if (itemSubTasksDict[subTask] && itemSubTasksDict[subTask][@"Completed Dict"] && [[itemSubTasksDict[subTask][@"Completed Dict"] allKeys] count] > 0) {
                    totalCompletionsOfSpecificSubTask += 1;
                }
                
            }
            
            [self->totalCompletedSubTaskArray addObject:@{@"TotalAssigned" : [NSString stringWithFormat:@"%d", totalOccurrencesOfSpecificSubTask], @"TotalCompleted" : [NSString stringWithFormat:@"%d", totalCompletionsOfSpecificSubTask]}];
            
        }
        
        
        
        
        
        
        
        //Display Specific Task Analytics
        
        CGFloat width = CGRectGetWidth(self.viewItemView.bounds);
        CGFloat progressBarWidth = ((float)totalCompletionsOfSpecificTask/(float)totalOccurrencesOfSpecificTask)*((width*0.2 > 69?(69):width*0.2));
        float percentage = ((float)totalCompletionsOfSpecificTask/(float)totalOccurrencesOfSpecificTask)*100;
        
        if ([[NSString stringWithFormat:@"%f", progressBarWidth] isEqualToString:@"nan"]) {
            progressBarWidth = 0.0;
        } else if (progressBarWidth > (width*0.2 > 69?(69):width*0.2)) {
            progressBarWidth = (width*0.2 > 69?(69):width*0.2);
        }
        
        if ([[NSString stringWithFormat:@"%f", percentage] isEqualToString:@"nan"]) {
            percentage = 0.0;
        }
        
        UIColor *progressBarColor = [UIColor systemGreenColor];
        
        if (percentage > 0 && percentage <= 25) {
            progressBarColor = [UIColor systemPinkColor];
        } else if (percentage > 25 && percentage <= 50) {
            progressBarColor = [UIColor systemOrangeColor];
        } else if (percentage > 50 && percentage <= 75) {
            progressBarColor = [UIColor systemYellowColor];
        }
        
        self->_progressBarTwo.backgroundColor = progressBarColor;
        
        CGRect bar = self->_progressBarTwo.frame;
        bar.size.width = progressBarWidth;
        self->_progressBarTwo.frame = bar;
        
        self->_percentageLabel.text = [NSString stringWithFormat:@"%.0f%% (%d/%d)", percentage , totalCompletionsOfSpecificTask, totalOccurrencesOfSpecificTask];
        
        
    }
    
}

@end
