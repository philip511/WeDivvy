//
//  ViewOptionsViewController.m
//  WeDivvy
//
//  Created by Philip Nagel on 6/28/21.
//

#import "UIImageView+Letters.h"

#import "ViewOptionsViewController.h"
#import "SceneDelegate.h"
#import "AssignedToCell.h"
#import "OptionsCell.h"

#import <SDWebImage/SDWebImage.h>

#import "GeneralObject.h"
#import "GetDataObject.h"
#import "SetDataObject.h"
#import "PushObject.h"
#import "BoolDataObject.h"
#import "LightDarkModeObject.h"

@interface ViewOptionsViewController () {
    
    NSMutableArray *optionsArray;
    NSMutableArray *additionalOptionsArray;
    
    NSMutableArray *viewingRepeatingFrequencyEveryArray;
    NSMutableArray *viewingRepeatingFrequencyTypeArray;
    NSMutableArray *viewingRepeatingFrequencyAmountArray;
    
    NSMutableArray *viewingPastDueFrequencyTypeArray;
    NSMutableArray *viewingPastDueFrequencyAmountArray;
    NSMutableArray *viewingPastDueFrequencyTypePluralArray;
    
    NSMutableArray *viewingMonthlyFrequencyTypeArray;
    NSMutableArray *viewingMonthlyFrequencyAmountArray;
    
    NSMutableArray *viewingScheduledStartFrequencyTypeArray;
    NSMutableArray *viewingScheduledStartFrequencyTypePluralArray;
    NSMutableArray *viewingScheduledStartFrequencyAmountArray;
    
    NSMutableArray *viewingCustomReminderFrequencyTypeArray;
    NSMutableArray *viewingCustomReminderFrequencyTypePluralArray;
    NSMutableArray *viewingCustomReminderFrequencyAmountArray;
    
    NSMutableArray *viewingCustomReminderBeforeFrequencyTypeArray;
    NSMutableArray *viewingCustomReminderBeforeFrequencyTypePluralArray;
    NSMutableArray *viewingCustomReminderBeforeFrequencyAmountArray;
    NSMutableArray *viewingCustomReminderBeforeFrequencyBeforeArray;

    NSMutableArray *viewingAlternateTurnsFrequencyEveryArray;
    NSMutableArray *viewingAlternateTurnsFrequencyAmountArray;
    NSMutableArray *viewingAlternateTurnsFrequencyTypeArray;
    NSMutableArray *viewingAlternateTurnsFrequencyTypePluralArray;
    
    NSString *repeatingFrequencyEveryComp;
    NSString *repeatingFrequencyTypeComp;
    NSString *repeatingFrequencyAmountComp;
    
    NSString *pastDueFrequencyAmountComp;
    NSString *pastDueFrequencyTypeComp;
    
    NSString *monthlyFrequencyAmountComp;
    NSString *monthlyFrequencyTypeComp;
    
    NSString *scheduledStartFrequencyAmountComp;
    NSString *scheduledStartFrequencyTypeComp;
    
    NSString *customReminderFrequencyAmountComp;
    NSString *customReminderFrequencyTypeComp;
    
    NSString *customReminderBeforeFrequencyAmountComp;
    NSString *customReminderBeforeFrequencyTypeComp;
    NSString *customReminderBeforeFrequencyBeforeComp;
    
    NSString *alternateTurnsFrequencyEveryComp;
    NSString *alternateTurnsFrequencyAmountComp;
    NSString *alternateTurnsFrequencyTypeComp;
    
    NSMutableArray *homeMemberUsernameArray;
    NSMutableArray *homeMemberProfileImageURLArray;
    
    BOOL viewingTabBar;
    BOOL viewingScheduledStart;
    BOOL viewingCustomReminder;
    BOOL viewingCustomReminderBefore;
    BOOL viewingDifficulty;
    BOOL viewingPriority;
    BOOL viewingRepeats;
    BOOL viewingAlternateTurns;
    BOOL viewingSpecificDates;
    BOOL viewingColor;
    BOOL viewingPastDue;
    BOOL viewingTurnOrder;
    BOOL viewingAppIcon;
    BOOL viewingAppTheme;
    BOOL viewingLaunchPage;
    BOOL viewingDays;
    BOOL viewingSounds;
    BOOL viewingScheduledSummaryFrequency;
    BOOL viewingScheduledSummaryDays;
    BOOL viewingShortcutItems;
    
    NSMutableDictionary *premiumPlanPricesDict;
    NSMutableDictionary *premiumPlanExpensivePricesDict;
    NSMutableDictionary *premiumPlanPricesDiscountDict;
    NSMutableDictionary *premiumPlanPricesNoFreeTrialDict;
    NSMutableArray *premiumPlanProductsArray;
    
}

@end

@implementation ViewOptionsViewController

#pragma mark - System Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self FetchAvailableProducts];
        
    });
    
    [self InitMethod];
    
    [self BarButtonItems];
    
    [self TapGesture];
    
    [self KeyBoardToolBar];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [_customRepeatingTextField resignFirstResponder];
    
}

-(void)viewWillLayoutSubviews {
    
    [self SetUpBool];
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [self SetUpBool];
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    CGFloat navigationBarHeight = [[[GeneralObject alloc] init] GetNavigationBarHeight:self];
    
    CGFloat textFieldSpacing = (height*0.024456);
    
    _randomizeTurnOrderView.frame = CGRectMake(width*0.5 - ((width*0.90338164)*0.5), navigationBarHeight + 12, width*0.90338164, (self.view.frame.size.height*0.067934 > 50?(50):self.view.frame.size.height*0.067934));
    _randomizeTurnOrderView.hidden = viewingTurnOrder ? NO : YES;
    
    _anyDayView.frame = CGRectMake(width*0.5 - ((width*0.90338164)*0.5), navigationBarHeight + 12, width*0.90338164, (self.view.frame.size.height*0.067934 > 50?(50):self.view.frame.size.height*0.067934));
    _anyDayView.hidden = viewingDays ? NO : YES;
    
    UIView *viewToUse = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    
    if (viewingTurnOrder) {
        viewToUse = _randomizeTurnOrderView;
    } else if (viewingDays) {
        viewToUse = _anyDayView;
    }
    
    CGFloat yPos = viewingTurnOrder || viewingDays ? (viewToUse.frame.origin.y + viewToUse.frame.size.height) + textFieldSpacing : navigationBarHeight + 12;
    
    _customView.frame = CGRectMake(width*0.5 - ((width*0.90338164)*0.5), yPos, width*0.90338164, (self.view.frame.size.height*0.067934 > 50?(50):self.view.frame.size.height*0.067934));
    _customView.layer.cornerRadius = 12;
    
    
    
    
    
    BOOL TaskIsRepeatingWeekly = [[[BoolDataObject alloc] init] TaskIsRepeatingWeekly:[@{@"ItemRepeats" : _itemRepeatsFrequency} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType]];
    BOOL TaskIsRepeatingMonthly = [[[BoolDataObject alloc] init] TaskIsRepeatingMonthly:[@{@"ItemRepeats" : _itemRepeatsFrequency} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType]];
    
    yPos = navigationBarHeight;
    
    if (viewingTurnOrder) {
        
        yPos = _randomizeTurnOrderView.frame.origin.y + _randomizeTurnOrderView.frame.size.height + 12;
        
    } else if  ((viewingDays || viewingScheduledSummaryDays) && TaskIsRepeatingWeekly) {
        
        yPos = _anyDayView.frame.origin.y + _anyDayView.frame.size.height + 12;
        
    } else if (viewingScheduledSummaryFrequency == YES || viewingRepeats == YES || viewingPastDue == YES || ((viewingDays || viewingScheduledSummaryDays) && TaskIsRepeatingMonthly)) {
        
        yPos = (_customView.frame.origin.y + _customView.frame.size.height) + 12;
        
    }
    
    _additionalOptionsTableView.frame = CGRectMake(width*0.5 - ((width*0.90338164)*0.5), _customView.frame.origin.y + _customView.frame.size.height + 12, width - ((width*0.5 - ((width*0.90338164)*0.5))*2), 0);
    _additionalOptionsTableView.layer.cornerRadius = 12;
    
    CGRect newRect = self->_additionalOptionsTableView.frame;
    newRect.size.height = [self AdjustTableViewHeight:additionalOptionsArray tableView:_additionalOptionsTableView];
    self->_additionalOptionsTableView.frame = newRect;
    
    
    
    
    
    if ((viewingDays || viewingScheduledSummaryDays) && TaskIsRepeatingMonthly) {
        
        yPos = (_additionalOptionsTableView.frame.origin.y + _additionalOptionsTableView.frame.size.height) + 12;
        
    }
    
    _customTableView.frame = CGRectMake(width*0.5 - ((width*0.90338164)*0.5), yPos, width - ((width*0.5 - ((width*0.90338164)*0.5))*2), 0);
    _customTableView.layer.cornerRadius = 12;
    
    newRect = self->_customTableView.frame;
    newRect.size.height = [self AdjustTableViewHeight:self->optionsArray tableView:self->_customTableView];
    self->_customTableView.frame = newRect;
    
    
    
    
    
    width = CGRectGetWidth(self.customView.bounds);
    height = CGRectGetHeight(self.customView.bounds);
    
    _customLabel.frame = CGRectMake(width*0.04830918, height*0, 100, height);
    _customRepeatingTextField.frame = CGRectMake(width*1 - (width*1 - ((width*0.04830918)*0.5)) - width*0.04830918, height*0, width*1 - ((width*0.04830918)*0.5), height);
    _customRepeatingTextField.textColor = [UIColor colorWithRed:138.0f/255.0f green:137.0f/255.0f blue:142.0f/255.0f alpha:1.0f];
    
    _customLabel.font = [UIFont systemFontOfSize:(height*0.34 > 17?17:(height*0.34)) weight:UIFontWeightRegular];
    _customRepeatingTextField.font = [UIFont systemFontOfSize:(height*0.34 > 17?17:(height*0.34)) weight:UIFontWeightRegular];
    
    newRect = _customLabel.frame;
    newRect.size.width = [[[GeneralObject alloc] init] WidthOfString:_customLabel.text withFont:_customLabel.font];
    _customLabel.frame = newRect;
    
    
    
    
    
    width = CGRectGetWidth(self.randomizeTurnOrderView.bounds);
    height = CGRectGetHeight(self.randomizeTurnOrderView.bounds);
    //374
    
    CGFloat switchTransform = height*0.55/31;
    CGFloat stringWidth;
    
    _randomizeTurnOrderSwitch.transform = CGAffineTransformMakeScale(switchTransform, switchTransform);
    _randomizeTurnOrderSwitch.frame = CGRectMake(width*1 - _randomizeTurnOrderSwitch.frame.size.width - width*0.04830918, height*0.5 - (_randomizeTurnOrderSwitch.frame.size.height*0.5), _randomizeTurnOrderSwitch.frame.size.width, _randomizeTurnOrderSwitch.frame.size.height);
    
    _randomizeTurnOrderLabel.frame = CGRectMake(width*0.04830918, height*0, 0, height);
    _randomizeTurnOrderLabel.font = [UIFont systemFontOfSize:(height*0.34 > 17?17:(height*0.34)) weight:UIFontWeightRegular];
    _randomizeTurnOrderLabel.adjustsFontSizeToFitWidth = YES;
    
    stringWidth = [[[GeneralObject alloc] init] WidthOfString:@"Randomize Turn Order" withFont:_randomizeTurnOrderLabel.font];
    newRect = _randomizeTurnOrderLabel.frame;
    newRect.size.width = stringWidth;
    _randomizeTurnOrderLabel.frame = newRect;
    
    _randomizeTurnOrderInfoImage.frame = CGRectMake(_randomizeTurnOrderLabel.frame.origin.x + _randomizeTurnOrderLabel.frame.size.width + (width*0.02139037), 0, width*0.05347594, height);
    
    float cornerRadius = (self.view.frame.size.height*0.2181818182 > 12?12:(self.view.frame.size.height*0.2181818182));
    [[[GeneralObject alloc] init] RoundingCorners:_randomizeTurnOrderView topCorners:YES bottomCorners:YES cornerRadius:cornerRadius];
    
    
    
    
    
    _anyDaySwitch.transform = CGAffineTransformMakeScale(switchTransform, switchTransform);
    _anyDaySwitch.frame = CGRectMake(width*1 - _anyDaySwitch.frame.size.width - width*0.04830918, height*0.5 - (_anyDaySwitch.frame.size.height*0.5), _anyDaySwitch.frame.size.width, _anyDaySwitch.frame.size.height);
    
    _anyDayLabel.frame = CGRectMake(width*0.04830918, height*0, 0, height);
    _anyDayLabel.font = [UIFont systemFontOfSize:(height*0.34 > 17?17:(height*0.34)) weight:UIFontWeightRegular];
    _anyDayLabel.adjustsFontSizeToFitWidth = YES;
    
    stringWidth = [[[GeneralObject alloc] init] WidthOfString:@"Any Day" withFont:_anyDayLabel.font];
    newRect = _anyDayLabel.frame;
    newRect.size.width = stringWidth;
    _anyDayLabel.frame = newRect;
    
    _anyDayInfoImage.frame = CGRectMake(_anyDayLabel.frame.origin.x + _anyDayLabel.frame.size.width + (width*0.02139037), 0, width*0.05347594, height);
    
    cornerRadius = (self.view.frame.size.height*0.2181818182 > 12?12:(self.view.frame.size.height*0.2181818182));
    [[[GeneralObject alloc] init] RoundingCorners:_anyDayView topCorners:YES bottomCorners:YES cornerRadius:cornerRadius];
    
    
    
    
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        self.view.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        self.navigationController.navigationBar.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        self.customTableView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeTertiary];
        self.anyDayView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeTertiary];
        self.anyDayLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        self.customView.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeTertiary];
        self.customLabel.textColor = [[[LightDarkModeObject alloc] init] DarkModeTextPrimary];
        
        [self preferredStatusBarStyle];
        
    } else {
        
        [self preferredStatusBarStyle];
        
        self.navigationController.navigationBar.backgroundColor = self.view.backgroundColor;
        
    }
    
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    
}

#pragma mark - Picker View Methods

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    BOOL TaskIsRepeatingMonthly = [[[BoolDataObject alloc] init] TaskIsRepeatingMonthly:[@{@"ItemRepeats" : _itemRepeatsFrequency} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType]];
    
    NSInteger the_tag = [pickerView tag];
    
    if (viewingRepeats || viewingScheduledSummaryFrequency) {
        
        if (the_tag == 1) {
            
            if (component == 0) {
                
                return [viewingRepeatingFrequencyEveryArray count];
                
            } else if (component == 1) {
                
                return [viewingRepeatingFrequencyAmountArray count];
                
            } else if (component == 2) {
                
                return [viewingRepeatingFrequencyTypeArray count];
                
            }
            
        }
        
    } else if (viewingPastDue) {
        
        if (the_tag == 1) {
            
            if (component == 0) {
                
                return [viewingPastDueFrequencyAmountArray count];
                
            } else if (component == 1) {
                
                NSArray *arrayToUse;
                
                if ([pastDueFrequencyAmountComp intValue] == 1 || pastDueFrequencyAmountComp == NULL || pastDueFrequencyAmountComp == nil || pastDueFrequencyAmountComp.length == 0) {
                    
                    arrayToUse = viewingPastDueFrequencyTypeArray;
                    
                } else {
                    
                    arrayToUse = viewingPastDueFrequencyTypePluralArray;
                    
                }
                
                return [arrayToUse count];
                
            }
            
        }
        
    } else if ((viewingDays || viewingScheduledSummaryDays) && TaskIsRepeatingMonthly) {
        
        if (the_tag == 1) {
            
            if (component == 0) {
                
                return 1;
                
            } else if (component == 1) {
                
                return [viewingMonthlyFrequencyAmountArray count];
                
            } else if (component == 2) {
                
                return [viewingMonthlyFrequencyTypeArray count];
                
            }
            
        }
        
    } else if (viewingScheduledStart) {
        
        if (component == 0) {
            
            return [viewingScheduledStartFrequencyAmountArray count];
            
        } else if (component == 1) {
            
            NSArray *arrayToUse;
            
            if ([scheduledStartFrequencyAmountComp intValue] == 1 || scheduledStartFrequencyAmountComp == NULL || scheduledStartFrequencyAmountComp == nil || scheduledStartFrequencyAmountComp.length == 0) {
                
                arrayToUse = viewingScheduledStartFrequencyTypeArray;
                
            } else {
                
                arrayToUse = viewingScheduledStartFrequencyTypePluralArray;
                
            }
            
            return [arrayToUse count];
            
        }
        
    } else if (viewingCustomReminder) {
        
        if (component == 0) {
            
            return [viewingCustomReminderFrequencyAmountArray count];
            
        } else if (component == 1) {
            
            NSArray *arrayToUse;
            
            if ([customReminderFrequencyAmountComp intValue] == 1 || customReminderFrequencyAmountComp == NULL || customReminderFrequencyAmountComp == nil || customReminderFrequencyAmountComp.length == 0) {
                
                arrayToUse = viewingCustomReminderFrequencyTypeArray;
                
            } else {
                
                arrayToUse = viewingCustomReminderFrequencyTypePluralArray;
                
            }
            
            return [arrayToUse count];
            
        }
        
    } else if (viewingCustomReminderBefore) {
        
        if (component == 0) {
            
            return [viewingCustomReminderBeforeFrequencyAmountArray count];
            
        } else if (component == 1) {
            
            NSArray *arrayToUse;
            
            if ([customReminderBeforeFrequencyAmountComp intValue] == 1 || customReminderBeforeFrequencyAmountComp == NULL || customReminderBeforeFrequencyAmountComp == nil || customReminderBeforeFrequencyAmountComp.length == 0) {
                
                arrayToUse = viewingCustomReminderBeforeFrequencyTypeArray;
                
            } else {
                
                arrayToUse = viewingCustomReminderBeforeFrequencyTypePluralArray;
                
            }
            
            return [arrayToUse count];
            
        } else if (component == 2) {
            
            return [viewingCustomReminderBeforeFrequencyBeforeArray count];
            
        }
        
    } else if (viewingAlternateTurns) {
        
        if (component == 0) {
            
            return [viewingAlternateTurnsFrequencyEveryArray count];
            
        } else if (component == 1) {
            
            return [viewingAlternateTurnsFrequencyAmountArray count];
            
        } else if (component == 2) {
            
            NSArray *arrayToUse;
            
            if ([alternateTurnsFrequencyAmountComp intValue] == 1 || alternateTurnsFrequencyAmountComp == NULL || alternateTurnsFrequencyAmountComp == nil || alternateTurnsFrequencyAmountComp.length == 0) {
                
                arrayToUse = viewingAlternateTurnsFrequencyTypeArray;
                
            } else {
                
                arrayToUse = viewingAlternateTurnsFrequencyTypePluralArray;
                
            }
            
            return [arrayToUse count];
            
        }
        
    }
    
    return 0;
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    BOOL TaskIsRepeatingMonthly = [[[BoolDataObject alloc] init] TaskIsRepeatingMonthly:[@{@"ItemRepeats" : _itemRepeatsFrequency} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType]];
    
    NSInteger the_tag = [pickerView tag];
    
    if (viewingRepeats || viewingScheduledSummaryFrequency) {
        
        if (the_tag == 1) {
            
            if (component == 0) {
                return [viewingRepeatingFrequencyEveryArray objectAtIndex:row];
            }
            else if (component == 1) {
                return [viewingRepeatingFrequencyAmountArray objectAtIndex:row];
            }
            else if (component == 2) {
                return [viewingRepeatingFrequencyTypeArray objectAtIndex:row];
            }
            
        }
        
    } else if (viewingPastDue) {
        
        if (the_tag == 1) {
            
            if (component == 0) {
                return [viewingPastDueFrequencyAmountArray objectAtIndex:row];
            }
            else if (component == 1) {
                
                NSArray *arrayToUse;
                
                if ([pastDueFrequencyAmountComp intValue] == 1 || pastDueFrequencyAmountComp == NULL || pastDueFrequencyAmountComp == nil || pastDueFrequencyAmountComp.length == 0) {
                    
                    arrayToUse = viewingPastDueFrequencyTypeArray;
                    
                } else {
                    
                    arrayToUse = viewingPastDueFrequencyTypePluralArray;
                    
                }
                
                return [arrayToUse objectAtIndex:row];
            }
            
        }
        
    } else if ((viewingDays || viewingScheduledSummaryDays) && TaskIsRepeatingMonthly) {
        
        if (the_tag == 1) {
            
            if (component == 0) {
                
                return @"Every";
                
            } else if (component == 1) {
                
                return [viewingMonthlyFrequencyAmountArray objectAtIndex:row];
                
            } else if (component == 2) {
                
                return [viewingMonthlyFrequencyTypeArray objectAtIndex:row];
                
            }
            
        }
        
    } else if (viewingScheduledStart) {
        
        if (component == 0) {
            
            return [viewingScheduledStartFrequencyAmountArray objectAtIndex:row];
            
        } else if (component == 1) {
            
            NSArray *arrayToUse;
            
            if ([scheduledStartFrequencyAmountComp intValue] == 1 || scheduledStartFrequencyAmountComp == NULL || scheduledStartFrequencyAmountComp == nil || scheduledStartFrequencyAmountComp.length == 0) {
                
                arrayToUse = viewingScheduledStartFrequencyTypeArray;
                
            } else {
                
                arrayToUse = viewingScheduledStartFrequencyTypePluralArray;
                
            }
            
            return [arrayToUse objectAtIndex:row];
            
        }
        
    } else if (viewingCustomReminder) {
        
        if (component == 0) {
            
            return [viewingCustomReminderFrequencyAmountArray objectAtIndex:row];
            
        } else if (component == 1) {
            
            NSArray *arrayToUse;
            
            if ([customReminderFrequencyAmountComp intValue] == 1 || customReminderFrequencyAmountComp == NULL || customReminderFrequencyAmountComp == nil || customReminderFrequencyAmountComp.length == 0) {
                
                arrayToUse = viewingCustomReminderFrequencyTypeArray;
                
            } else {
                
                arrayToUse = viewingCustomReminderFrequencyTypePluralArray;
                
            }
            
            return [arrayToUse objectAtIndex:row];
            
        }
        
    } else if (viewingCustomReminderBefore) {
        
        if (component == 0) {
            
            return [viewingCustomReminderBeforeFrequencyAmountArray objectAtIndex:row];
            
        } else if (component == 1) {
            
            NSArray *arrayToUse;
            
            if ([customReminderBeforeFrequencyAmountComp intValue] == 1 || customReminderBeforeFrequencyAmountComp == NULL || customReminderBeforeFrequencyAmountComp == nil || customReminderBeforeFrequencyAmountComp.length == 0) {
                
                arrayToUse = viewingCustomReminderBeforeFrequencyTypeArray;
                
            } else {
                
                arrayToUse = viewingCustomReminderBeforeFrequencyTypePluralArray;
                
            }
            
            return [arrayToUse objectAtIndex:row];
            
        } else if (component == 2) {
            
            return [viewingCustomReminderBeforeFrequencyBeforeArray objectAtIndex:row];
            
        }
        
    } else if (viewingAlternateTurns) {
        
        if (component == 0) {
            
            return [viewingAlternateTurnsFrequencyEveryArray objectAtIndex:row];
            
        } else if (component == 1) {
            
            return [viewingAlternateTurnsFrequencyAmountArray objectAtIndex:row];
            
        } else if (component == 2) {
            
            NSArray *arrayToUse;
            
            if ([alternateTurnsFrequencyAmountComp intValue] == 1 || alternateTurnsFrequencyAmountComp == NULL || alternateTurnsFrequencyAmountComp == nil || alternateTurnsFrequencyAmountComp.length == 0) {
                
                arrayToUse = viewingAlternateTurnsFrequencyTypeArray;
                
            } else {
                
                arrayToUse = viewingAlternateTurnsFrequencyTypePluralArray;
                
            }
            
            return [arrayToUse objectAtIndex:row];
            
        }
        
    }
    
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    BOOL TaskIsRepeatingMonthly = [[[BoolDataObject alloc] init] TaskIsRepeatingMonthly:[@{@"ItemRepeats" : _itemRepeatsFrequency} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType]];
    BOOL SpecificDatesSelected = _specificDatesArray.count > 0;
    
    if (SpecificDatesSelected == YES) {
        
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Multiple Due Dates Chosen"
                                                                            message:@"Would you like to delete all of your multiple dates?"
                                                                     preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction *gotit = [UIAlertAction actionWithTitle:@"Sure"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * _Nonnull action) {
            
            if (component == 0) {
                
                self->repeatingFrequencyEveryComp=[self->viewingRepeatingFrequencyEveryArray objectAtIndex:row];
                
            } else if (component == 1) {
                
                self->repeatingFrequencyAmountComp=[self->viewingRepeatingFrequencyAmountArray objectAtIndex:row];
                
            } else if (component == 2) {
                
                self->repeatingFrequencyTypeComp=[self->viewingRepeatingFrequencyTypeArray objectAtIndex:row];
                
            }
            
            if ([self->repeatingFrequencyAmountComp isEqualToString:@""] == NO && [self->repeatingFrequencyAmountComp containsString:@"(null)"] == NO && self->repeatingFrequencyAmountComp != nil) {
                
                self->_customRepeatingTextField.text = [NSString stringWithFormat:@"%@ %@ %@", self->repeatingFrequencyEveryComp, self->repeatingFrequencyAmountComp, self->repeatingFrequencyTypeComp];
                
            } else {
                
                self->_customRepeatingTextField.text = [NSString stringWithFormat:@"%@ %@", self->repeatingFrequencyEveryComp, self->repeatingFrequencyTypeComp];
                
            }
            
            self->_specificDatesArray = [NSMutableArray array];
            self->_itemsSelectedArray = [NSMutableArray array];
            [self->_itemsSelectedArray addObject:self->_customRepeatingTextField.text];
            
            [self->_customTableView reloadData];
            
            [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemSpecificDueDates" userInfo:@{@"Items" : self->_specificDatesArray} locations:@[@"AddTask"]];
  
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Nevermind"
                                                         style:UIAlertActionStyleCancel
                                                       handler:^(UIAlertAction * _Nonnull action) {
            
            
        }];
        
        [controller addAction:cancel];
        [controller addAction:gotit];
        [self presentViewController:controller animated:YES completion:nil];
        
        
    } else {
        
        
        
        
        if (viewingRepeats || viewingScheduledSummaryFrequency) {
            
            if (component == 0) {
                
                repeatingFrequencyEveryComp=[viewingRepeatingFrequencyEveryArray objectAtIndex:row];
                
            } else if (component == 1) {
                
                repeatingFrequencyAmountComp=[viewingRepeatingFrequencyAmountArray objectAtIndex:row];
                
            } else if (component == 2) {
                
                repeatingFrequencyTypeComp=[viewingRepeatingFrequencyTypeArray objectAtIndex:row];
                
            }
            
            self->_itemsSelectedArray = [NSMutableArray array];
            
            if ([repeatingFrequencyAmountComp isEqualToString:@""] == NO && [repeatingFrequencyAmountComp containsString:@"(null)"] == NO && repeatingFrequencyAmountComp != nil) {
                
                _customRepeatingTextField.text = [NSString stringWithFormat:@"%@ %@ %@", repeatingFrequencyEveryComp, repeatingFrequencyAmountComp, repeatingFrequencyTypeComp];
                
            } else {
                
                _customRepeatingTextField.text = [NSString stringWithFormat:@"%@ %@", repeatingFrequencyEveryComp, repeatingFrequencyTypeComp];
                
            }
            
            
            
            
        } else if (viewingPastDue) {
            
            if (component == 0) {
                
                pastDueFrequencyAmountComp=[viewingPastDueFrequencyAmountArray objectAtIndex:row];
                
                [(UIPickerView *)_customRepeatingTextField.inputView reloadAllComponents];
                
            } else if (component == 1) {
                
                NSArray *arrayToUse;
                
                if ([pastDueFrequencyAmountComp intValue] == 1 || pastDueFrequencyAmountComp == NULL || pastDueFrequencyAmountComp == nil || pastDueFrequencyAmountComp.length == 0) {
                    
                    arrayToUse = viewingPastDueFrequencyTypeArray;
                    
                } else {
                    
                    arrayToUse = viewingPastDueFrequencyTypePluralArray;
                    
                }
                
                pastDueFrequencyTypeComp=[arrayToUse objectAtIndex:row];
                
            }
            
            if (pastDueFrequencyAmountComp == NULL) {
                pastDueFrequencyAmountComp = @"1";
            }
            
            if (pastDueFrequencyTypeComp == NULL) {
                pastDueFrequencyTypeComp = @"Day";
            }
            
            _customRepeatingTextField.text = [NSString stringWithFormat:@"%@ %@", pastDueFrequencyAmountComp, pastDueFrequencyTypeComp];
            
            
            
            
        } else if ((viewingDays || viewingScheduledSummaryDays) && TaskIsRepeatingMonthly) {
            
            if (component == 0) {
                
                //@"Every";
                
            } else if (component == 1) {
                
                monthlyFrequencyAmountComp=[viewingMonthlyFrequencyAmountArray objectAtIndex:row];
                
            } else if (component == 2) {
                
                monthlyFrequencyTypeComp=[viewingMonthlyFrequencyTypeArray objectAtIndex:row];
                
            }
            
            if (monthlyFrequencyAmountComp == NULL) {
                monthlyFrequencyAmountComp = @"1st";
            }
            
            if (monthlyFrequencyTypeComp == NULL) {
                monthlyFrequencyTypeComp = @"Sunday";
            }
            
            _customRepeatingTextField.text = [NSString stringWithFormat:@"Every %@ %@", monthlyFrequencyAmountComp, monthlyFrequencyTypeComp];
            
            
            
            
        } else if (viewingScheduledStart) {
            
            if (component == 0) {
                
                scheduledStartFrequencyAmountComp=[viewingScheduledStartFrequencyAmountArray objectAtIndex:row];
                
                [(UIPickerView *)_customRepeatingTextField.inputView reloadAllComponents];
                
            } else if (component == 1) {
                
                NSArray *arrayToUse;
                
                if ([scheduledStartFrequencyAmountComp intValue] == 1 || scheduledStartFrequencyAmountComp == NULL || scheduledStartFrequencyAmountComp == nil || scheduledStartFrequencyAmountComp.length == 0) {
                    
                    arrayToUse = viewingScheduledStartFrequencyTypeArray;
                    
                } else {
                    
                    arrayToUse = viewingScheduledStartFrequencyTypePluralArray;
                    
                }
                
                scheduledStartFrequencyTypeComp=[arrayToUse objectAtIndex:row];
                
            }
            
            self->_itemsSelectedArray = [NSMutableArray array];
            
            if (scheduledStartFrequencyAmountComp == NULL) {
                scheduledStartFrequencyAmountComp = @"2";
            }
            
            if (scheduledStartFrequencyTypeComp == NULL) {
                scheduledStartFrequencyTypeComp = @"Minutes";
            }
            
            _customRepeatingTextField.text = [NSString stringWithFormat:@"%@ %@", scheduledStartFrequencyAmountComp, scheduledStartFrequencyTypeComp];
            
            
            
            
        } else if (viewingCustomReminder) {
            
            if (component == 0) {
                
                customReminderFrequencyAmountComp=[viewingCustomReminderFrequencyAmountArray objectAtIndex:row];
                
                [(UIPickerView *)_customRepeatingTextField.inputView reloadAllComponents];
                
            } else if (component == 1) {
                
                NSArray *arrayToUse;
                
                if ([customReminderFrequencyAmountComp intValue] == 1 || customReminderFrequencyAmountComp == NULL || customReminderFrequencyAmountComp == nil || customReminderFrequencyAmountComp.length == 0) {
                    
                    arrayToUse = viewingCustomReminderFrequencyTypeArray;
                    
                } else {
                    
                    arrayToUse = viewingCustomReminderFrequencyTypePluralArray;
                    
                }
                
                customReminderFrequencyTypeComp=[arrayToUse objectAtIndex:row];
                
            }
            
            self->_itemsSelectedArray = [NSMutableArray array];
            
            if (customReminderFrequencyAmountComp == NULL) {
                customReminderFrequencyAmountComp = @"30";
            }
            
            if (customReminderFrequencyTypeComp == NULL) {
                customReminderFrequencyTypeComp = @"Minutes";
            }
            
            _customRepeatingTextField.text = [NSString stringWithFormat:@"%@ %@", customReminderFrequencyAmountComp, customReminderFrequencyTypeComp];
            
            
            
            
        } else if (viewingCustomReminderBefore) {

            if (component == 0) {
                
                customReminderBeforeFrequencyAmountComp=[viewingCustomReminderBeforeFrequencyAmountArray objectAtIndex:row];
                
                [(UIPickerView *)_customRepeatingTextField.inputView reloadAllComponents];
                
            } else if (component == 1) {
                
                NSArray *arrayToUse;
                
                if ([customReminderBeforeFrequencyAmountComp intValue] == 1 || customReminderBeforeFrequencyAmountComp == NULL || customReminderBeforeFrequencyAmountComp == nil || customReminderBeforeFrequencyAmountComp.length == 0) {
                    
                    arrayToUse = viewingCustomReminderBeforeFrequencyTypeArray;
                    
                } else {
                    
                    arrayToUse = viewingCustomReminderBeforeFrequencyTypePluralArray;
                    
                }
                
                customReminderBeforeFrequencyTypeComp=[arrayToUse objectAtIndex:row];
                
            } else if (component == 2) {
                
                customReminderBeforeFrequencyBeforeComp=[viewingCustomReminderBeforeFrequencyBeforeArray objectAtIndex:row];
                
            }
            
            self->_itemsSelectedArray = [NSMutableArray array];
            
            if (customReminderBeforeFrequencyAmountComp == NULL) {
                customReminderBeforeFrequencyAmountComp = @"30";
            }
            
            if (customReminderBeforeFrequencyTypeComp == NULL) {
                customReminderBeforeFrequencyTypeComp = @"Minutes";
            }
            
            if (customReminderBeforeFrequencyBeforeComp == NULL) {
                customReminderBeforeFrequencyBeforeComp = @"Before";
            }
            
            _customRepeatingTextField.text = [NSString stringWithFormat:@"%@ %@ %@", customReminderBeforeFrequencyAmountComp, customReminderBeforeFrequencyTypeComp, customReminderBeforeFrequencyBeforeComp];
            
            
            
            
        } else if (viewingAlternateTurns) {
            
            if (component == 0) {
                
                alternateTurnsFrequencyEveryComp=[viewingAlternateTurnsFrequencyEveryArray objectAtIndex:row];
                
            } else if (component == 1) {
                
                alternateTurnsFrequencyAmountComp=[viewingAlternateTurnsFrequencyAmountArray objectAtIndex:row];
                
                [(UIPickerView *)_customRepeatingTextField.inputView reloadAllComponents];
                
            } else if (component == 2) {
                
                NSArray *arrayToUse;
               
                if ([alternateTurnsFrequencyAmountComp intValue] == 1 || alternateTurnsFrequencyAmountComp == NULL || alternateTurnsFrequencyAmountComp == nil || alternateTurnsFrequencyAmountComp.length == 0) {
                    
                    arrayToUse = viewingAlternateTurnsFrequencyTypeArray;
                    
                } else {
                    
                    arrayToUse = viewingAlternateTurnsFrequencyTypePluralArray;
                    
                }
                
                alternateTurnsFrequencyTypeComp=[arrayToUse objectAtIndex:row];
                
            }
            
            self->_itemsSelectedArray = [NSMutableArray array];
            
            if ([alternateTurnsFrequencyAmountComp isEqualToString:@""] == NO && [alternateTurnsFrequencyAmountComp containsString:@"(null)"] == NO && alternateTurnsFrequencyAmountComp != nil) {
              
                _customRepeatingTextField.text = [NSString stringWithFormat:@"%@ %@ %@", alternateTurnsFrequencyEveryComp, alternateTurnsFrequencyAmountComp, alternateTurnsFrequencyTypeComp];
                
            } else {
              
                _customRepeatingTextField.text = [NSString stringWithFormat:@"%@ %@", alternateTurnsFrequencyEveryComp, alternateTurnsFrequencyTypeComp];
                
            }
            
        }
        
        [_customTableView reloadData];
        
    }
    
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    BOOL TaskIsRepeatingMonthly = [[[BoolDataObject alloc] init] TaskIsRepeatingMonthly:[@{@"ItemRepeats" : _itemRepeatsFrequency} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType]];
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    
    if (viewingRepeats || viewingScheduledSummaryFrequency) {
        
        if (component == 0) {
            return ((width*0.075)*3);
        } else if (component == 1) {
            return ((width*0.085)*3);
        } else if (component == 2) {
            return ((width*0.075)*3);
        }
        
    } else if (viewingPastDue) {
        
        if (component == 0) {
            return ((width*0.085)*3);
        } else if (component == 1) {
            return ((width*0.085)*3);
        }
        
    } else if ((viewingDays || viewingScheduledSummaryDays) && TaskIsRepeatingMonthly) {
        
        if (component == 0) {
            return ((width*0.065)*3);
        } else if (component == 1) {
            return ((width*0.055)*3);
        } else if (component == 2) {
            return ((width*0.115)*3);
        }
        
    } else if (viewingScheduledStart) {
        
        if (component == 0) {
            return ((width*0.085)*3);
        } else if (component == 1) {
            return ((width*0.085)*3);
        }
        
    } else if (viewingCustomReminder) {
        
        if (component == 0) {
            return ((width*0.085)*3);
        } else if (component == 1) {
            return ((width*0.085)*3);
        }
        
    } else if (viewingCustomReminderBefore) {
        
        if (component == 0) {
            return ((width*0.075)*3);
        } else if (component == 1) {
            return ((width*0.085)*3);
        } else if (component == 2) {
            return ((width*0.075)*3);
        }
        
    } else if (viewingAlternateTurns) {
        
        if (component == 0) {
            return ((width*0.075)*3);
        } else if (component == 1) {
            return ((width*0.085)*3);
        } else if (component == 2) {
            return ((width*0.075)*5);
        }
        
    }
    
    return 0;
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    BOOL TaskIsRepeatingMonthly = [[[BoolDataObject alloc] init] TaskIsRepeatingMonthly:[@{@"ItemRepeats" : _itemRepeatsFrequency} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType]];
    
    if (viewingRepeats || viewingScheduledSummaryFrequency) {
        
        return 3;
        
    } else if (viewingPastDue) {
        
        return 2;
        
    } else if ((viewingDays || viewingScheduledSummaryDays) && TaskIsRepeatingMonthly) {
        
        return 3;
        
    } else if (viewingScheduledStart) {
        
        return 2;
        
    } else if (viewingCustomReminder) {
        
        return 2;
        
    } else if (viewingCustomReminderBefore) {
        
        return 3;
        
    } else if (viewingAlternateTurns) {
        
        return 3;
        
    }
    
    return 0;
}

#pragma mark - Init Methods

-(void)InitMethod {
    
    [self SetUpAnalytics];
    
    [self SetUpTableView];
    
    [self SetUpBool];
    
    [self SetUpViewingRepeatsDataAndViews];
    
    [self SetUpViewingTurnOrderDataAndViews];
    
    [self SetUpViewingPastDueDataAndViews];
    
    [self SetUpViewingScheduledStartDataAndViews];
    
    [self SetUpViewingCustomReminderDataAndViews];
    
    [self SetUpViewingCustomReminderBeforeDataAndViews];
    
    [self SetUpViewingAlternateTurnsBeforeDataAndViews];
    
    [self SetUpOptions];
    
    [self SetUpCustomTextFieldLabel];
    
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
    
    if (_viewingItemDetails == NO && viewingAppIcon == NO) {
        
        barButtonItem = [[UIBarButtonItem alloc]
                         initWithTitle:@"Save"
                         style:UIBarButtonItemStyleDone
                         target:self
                         action:@selector(SaveButtonAction:)];
        
        NSArray *arrayToUse = @[barButtonItem];
        
        self.navigationItem.rightBarButtonItems = arrayToUse;
        
    }
    
}

-(void)TapGesture {
    
    UITapGestureRecognizer *tapGesture;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(RandomizeTurnOrderPopup)];
    [_randomizeTurnOrderInfoImage addGestureRecognizer:tapGesture];
    _randomizeTurnOrderInfoImage.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(AnyDayPopup)];
    [_anyDayInfoImage addGestureRecognizer:tapGesture];
    _anyDayInfoImage.userInteractionEnabled = YES;
    
}


-(void)KeyBoardToolBar {
    
    UIToolbar* keyboardToolbar = [[UIToolbar alloc] init];
    
    [keyboardToolbar sizeToFit];
    
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                      target:nil action:nil];
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc]
                                      initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(DoneCustom)];
    UIBarButtonItem *addOptionBarButton = [[UIBarButtonItem alloc]
                                           initWithTitle:@"Add Option" style:UIBarButtonItemStyleDone target:self action:@selector(AddOption:)];
    
    BOOL TaskIsRepeatingMonthly = [[[BoolDataObject alloc] init] TaskIsRepeatingMonthly:[@{@"ItemRepeats" : _itemRepeatsFrequency} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType]];
    
    if (viewingRepeats || viewingScheduledSummaryFrequency || viewingPastDue || viewingScheduledStart || viewingCustomReminder) {
        
        keyboardToolbar.items = @[flexBarButton, doneBarButton];
        self.customRepeatingTextField.inputAccessoryView = keyboardToolbar;
        
    } else if ((viewingDays || viewingScheduledSummaryDays) && TaskIsRepeatingMonthly) {
        
        keyboardToolbar.items = @[addOptionBarButton, flexBarButton, doneBarButton];
        self.customRepeatingTextField.inputAccessoryView = keyboardToolbar;
        
    }
    
}

#pragma mark - Setup Methods

-(void)SetUpAnalytics {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewViewController:@"ViewOptionsViewController" completionHandler:^(BOOL finished) {
        
    }];
    
}

-(void)SetUpTableView {
    
    _customTableView.delegate = self;
    _customTableView.dataSource = self;
    _additionalOptionsTableView.delegate = self;
    _additionalOptionsTableView.dataSource = self;
    
}

-(void)SetUpBool {
    
    if ([_optionSelectedString isEqualToString:@"TabBar"]) {
        
        viewingTabBar = YES;
        
    } else if ([_optionSelectedString isEqualToString:@"ScheduledStart"]) {
        
        viewingScheduledStart = YES;
        
    } else if ([_optionSelectedString isEqualToString:@"CustomReminder"]) {
        
        viewingCustomReminder = YES;
        
    } else if ([_optionSelectedString isEqualToString:@"CustomReminderBefore"]) {
        
        viewingCustomReminderBefore = YES;
        
    } else if ([_optionSelectedString isEqualToString:@"Difficulty"]) {
        
        viewingDifficulty = YES;
        
    } else if ([_optionSelectedString isEqualToString:@"Priority"]) {
        
        viewingPriority = YES;
        
    } else if ([_optionSelectedString isEqualToString:@"Repeats"]) {
        
        viewingRepeats = YES;
        
    } else if ([_optionSelectedString isEqualToString:@"AlternateTurns"]) {
        
        viewingAlternateTurns = YES;
        
    } else if ([_optionSelectedString isEqualToString:@"SpecificDates"]) {
        
        viewingSpecificDates = YES;
        
    } else if ([_optionSelectedString isEqualToString:@"Colors"]) {
        
        viewingColor = YES;
        
    } else if ([_optionSelectedString isEqualToString:@"PastDue"]) {
        
        viewingPastDue = YES;
        
    } else if ([_optionSelectedString isEqualToString:@"TurnOrder"]) {
        
        viewingTurnOrder = YES;
        
    } else if ([_optionSelectedString isEqualToString:@"AppIcon"]) {
        
        viewingAppIcon = YES;
        
    } else if ([_optionSelectedString isEqualToString:@"AppTheme"]) {
        
        viewingAppTheme = YES;
        
    } else if ([_optionSelectedString isEqualToString:@"LaunchPage"]) {
        
        viewingLaunchPage = YES;
        
    } else if ([_optionSelectedString isEqualToString:@"Days"]) {
        
        viewingDays = YES;
        
    } else if ([_optionSelectedString isEqualToString:@"Sounds"]) {
        
        viewingSounds = YES;
        
    } else if ([_optionSelectedString isEqualToString:@"ScheduledSummaryFrequency"]) {
        
        viewingScheduledSummaryFrequency = YES;
        
    } else if ([_optionSelectedString isEqualToString:@"ScheduledSummaryDays"]) {
        
        viewingScheduledSummaryDays = YES;
        
    } else if ([_optionSelectedString isEqualToString:@"ShortcutItems"]) {
        
        viewingShortcutItems = YES;
        
    }
    
}

-(void)SetUpOptions {
    
    optionsArray = [NSMutableArray array];
    
    if (viewingTabBar) {
        
        [self SetUpTabBarOptions];
        
    } else if (viewingShortcutItems) {
        
        [self SetUpShortcutOptions];
        
    } else if (viewingTurnOrder) {
        
        [self SetUpTurnOrderOptions];
        
    } else if (viewingColor) {
        
        [self SetUpColorOptions];
        
    } else if (viewingAppTheme) {
        
        [self SetUpAppThemeOptions];
        
    } else if (viewingAppIcon) {
        
        [self SetUpAppIconOptions];
        
    } else if (viewingLaunchPage) {
        
        [self SetUpLaunchOptions];
        
    } else if (viewingRepeats || viewingScheduledSummaryFrequency) {
        
        [self SetUpRepeatsOptions];
        
    } else if (viewingAlternateTurns) {
        
        [self SetUpAlternateTurnsOptions];
        
    } else if (viewingPastDue) {
      
        [self SetUpPastDueOptions];
        
    } else if (viewingSounds) {
        
        [self SetUpSoundOptions];
        
    } else if (viewingDifficulty) {
        
        [self SetUpDifficultyOptions];
        
    } else if (viewingPriority) {
        
        [self SetUpPriorityOptions];
        
    } else if (viewingDays || viewingScheduledSummaryDays) {
        
        [self SetUpDayOptions];
        
    } else if (viewingScheduledStart) {
        
        [self SetUpScheduledStartOptions];
        
    } else if (viewingCustomReminder) {
        
        [self SetUpCustomReminderOptions];
        
    } else if (viewingCustomReminderBefore) {
        
        [self SetUpCustomReminderBeforeOptions];
        
    }
    
}

-(void)SetUpCustomTextFieldLabel {
    
    BOOL TaskIsRepeatingMonthly = [[[BoolDataObject alloc] init] TaskIsRepeatingMonthly:[@{@"ItemRepeats" : _itemRepeatsFrequency} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType]];
    
    _customLabel.text = @"Custom";
    
    if (viewingRepeats) {
        _customLabel.text = @"Repeats";
    } else if (viewingAlternateTurns) {
        _customLabel.text = @"Alternate Turns";
    } else if (viewingPastDue) {
        _customLabel.text = @"Past Due";
    } else if ((viewingDays || viewingScheduledSummaryDays) && TaskIsRepeatingMonthly) {
        _customLabel.text = @"Weekdays";
    }
    
    CGRect newRect = _customLabel.frame;
    newRect.size.width = [[[GeneralObject alloc] init] WidthOfString:_customLabel.text withFont:_customLabel.font];
    _customLabel.frame = newRect;
    
}

-(void)SetUpViewingRepeatsDataAndViews {
    
    BOOL TaskIsRepeatingMonthly = [[[BoolDataObject alloc] init] TaskIsRepeatingMonthly:[@{@"ItemRepeats" : _itemRepeatsFrequency} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType]];
    
    if (viewingRepeats || viewingScheduledSummaryFrequency) {
        
        repeatingFrequencyEveryComp = @"Every";
        repeatingFrequencyTypeComp = @"Day";
        
        viewingRepeatingFrequencyEveryArray = [[NSMutableArray alloc] init];
        [viewingRepeatingFrequencyEveryArray addObject:@"Every"];
        
        viewingRepeatingFrequencyTypeArray = [[NSMutableArray alloc] init];
        [viewingRepeatingFrequencyTypeArray addObject:@"Hour"];
        [viewingRepeatingFrequencyTypeArray addObject:@"Day"];
        [viewingRepeatingFrequencyTypeArray addObject:@"Week"];
        [viewingRepeatingFrequencyTypeArray addObject:@"Month"];
        
        viewingRepeatingFrequencyAmountArray = [[NSMutableArray alloc] init];
        [viewingRepeatingFrequencyAmountArray addObject:@""];
        [viewingRepeatingFrequencyAmountArray addObject:@"Other"];
        [viewingRepeatingFrequencyAmountArray addObject:@"3rd"];
        for (int i=4;i<=12;i++) {
            [viewingRepeatingFrequencyAmountArray addObject:[NSString stringWithFormat:@"%dth", i]];
        }
        
        _customRepeatingTextField.delegate = self;
        
        UIPickerView *pickerView;
        
        pickerView = [[UIPickerView alloc]init];
        pickerView.delegate = self;
        pickerView.tag = 1;
        [_customRepeatingTextField setInputView:pickerView];
        
    } else if ((viewingDays || viewingScheduledSummaryDays) && TaskIsRepeatingMonthly) {
        
        repeatingFrequencyEveryComp = @"Sunday";
        repeatingFrequencyTypeComp = @"1st";
        
        viewingMonthlyFrequencyTypeArray = [[NSMutableArray alloc] init];
        [viewingMonthlyFrequencyTypeArray addObject:@"Sunday"];
        [viewingMonthlyFrequencyTypeArray addObject:@"Monday"];
        [viewingMonthlyFrequencyTypeArray addObject:@"Tuesday"];
        [viewingMonthlyFrequencyTypeArray addObject:@"Wednesday"];
        [viewingMonthlyFrequencyTypeArray addObject:@"Thursday"];
        [viewingMonthlyFrequencyTypeArray addObject:@"Friday"];
        [viewingMonthlyFrequencyTypeArray addObject:@"Saturday"];
        
        viewingMonthlyFrequencyAmountArray = [[NSMutableArray alloc] init];
        [viewingMonthlyFrequencyAmountArray addObject:@"1st"];
        [viewingMonthlyFrequencyAmountArray addObject:@"2nd"];
        [viewingMonthlyFrequencyAmountArray addObject:@"3rd"];
        [viewingMonthlyFrequencyAmountArray addObject:@"4th"];
        [viewingMonthlyFrequencyAmountArray addObject:@"5th"];
        
        _customRepeatingTextField.delegate = self;
        
        UIPickerView *pickerView;
        
        pickerView = [[UIPickerView alloc]init];
        pickerView.delegate = self;
        pickerView.tag = 1;
        [_customRepeatingTextField setInputView:pickerView];
        
    }
    
    if (viewingRepeats) { [_customRepeatingTextField becomeFirstResponder]; }
    
}

-(void)SetUpViewingTurnOrderDataAndViews {
    
    if (viewingTurnOrder) {
        
        homeMemberUsernameArray = [_homeMembersDict[@"Username"] mutableCopy];
        homeMemberProfileImageURLArray = [_homeMembersDict[@"ProfileImageURL"] mutableCopy];
      
        [self.customTableView setEditing:YES animated:YES];
        
    }
    
}

-(void)SetUpViewingPastDueDataAndViews {
    
    if (viewingPastDue) {
        
        pastDueFrequencyAmountComp = @"1";
        pastDueFrequencyTypeComp = @"Day";
        
        viewingPastDueFrequencyTypeArray = [[NSMutableArray alloc] init];
        [viewingPastDueFrequencyTypeArray addObject:@"Minute"];
        [viewingPastDueFrequencyTypeArray addObject:@"Hour"];
        [viewingPastDueFrequencyTypeArray addObject:@"Day"];
        [viewingPastDueFrequencyTypeArray addObject:@"Week"];
        [viewingPastDueFrequencyTypeArray addObject:@"Month"];
        
        viewingPastDueFrequencyTypePluralArray = [[NSMutableArray alloc] init];
        [viewingPastDueFrequencyTypePluralArray addObject:@"Minutes"];
        [viewingPastDueFrequencyTypePluralArray addObject:@"Hours"];
        [viewingPastDueFrequencyTypePluralArray addObject:@"Days"];
        [viewingPastDueFrequencyTypePluralArray addObject:@"Weeks"];
        [viewingPastDueFrequencyTypePluralArray addObject:@"Months"];
        
        viewingPastDueFrequencyAmountArray = [[NSMutableArray alloc] init];
        for (int i=1;i<=60;i++) {
            [viewingPastDueFrequencyAmountArray addObject:[NSString stringWithFormat:@"%d", i]];
        }
        
        _customRepeatingTextField.delegate = self;
        
        UIPickerView *pickerView;
        
        pickerView = [[UIPickerView alloc]init];
        pickerView.delegate = self;
        pickerView.tag = 1;
        [_customRepeatingTextField setInputView:pickerView];
        
    }
    
}

-(void)SetUpViewingScheduledStartDataAndViews {
    
    if (viewingScheduledStart) {
        
        scheduledStartFrequencyAmountComp = @"30";
        scheduledStartFrequencyTypeComp = @"Minutes";
        
        viewingScheduledStartFrequencyTypeArray = [[NSMutableArray alloc] init];
        [viewingScheduledStartFrequencyTypeArray addObject:@"Minute"];
        [viewingScheduledStartFrequencyTypeArray addObject:@"Hour"];
        [viewingScheduledStartFrequencyTypeArray addObject:@"Day"];
        [viewingScheduledStartFrequencyTypeArray addObject:@"Week"];
        
        [viewingScheduledStartFrequencyTypeArray addObject:@"Monday"];
        [viewingScheduledStartFrequencyTypeArray addObject:@"Tuesday"];
        [viewingScheduledStartFrequencyTypeArray addObject:@"Wednesday"];
        [viewingScheduledStartFrequencyTypeArray addObject:@"Thursday"];
        [viewingScheduledStartFrequencyTypeArray addObject:@"Friday"];
        [viewingScheduledStartFrequencyTypeArray addObject:@"Saturday"];
        [viewingScheduledStartFrequencyTypeArray addObject:@"Sunday"];
        
        viewingScheduledStartFrequencyTypePluralArray = [[NSMutableArray alloc] init];
        [viewingScheduledStartFrequencyTypePluralArray addObject:@"Minutes"];
        [viewingScheduledStartFrequencyTypePluralArray addObject:@"Hours"];
        [viewingScheduledStartFrequencyTypePluralArray addObject:@"Days"];
        [viewingScheduledStartFrequencyTypePluralArray addObject:@"Weeks"];
        [viewingScheduledStartFrequencyTypePluralArray addObject:@"Months"];
        
        [viewingScheduledStartFrequencyTypePluralArray addObject:@"Mondays"];
        [viewingScheduledStartFrequencyTypePluralArray addObject:@"Tuesdays"];
        [viewingScheduledStartFrequencyTypePluralArray addObject:@"Wednesdays"];
        [viewingScheduledStartFrequencyTypePluralArray addObject:@"Thursdays"];
        [viewingScheduledStartFrequencyTypePluralArray addObject:@"Fridays"];
        [viewingScheduledStartFrequencyTypePluralArray addObject:@"Saturdays"];
        [viewingScheduledStartFrequencyTypePluralArray addObject:@"Sundays"];
        
        viewingScheduledStartFrequencyAmountArray = [[NSMutableArray alloc] init];
        
        for (int i=1;i<=59;i++) {
            [viewingScheduledStartFrequencyAmountArray addObject:[NSString stringWithFormat:@"%d", i]];
        }
        
        _customRepeatingTextField.delegate = self;
        
        UIPickerView *pickerView;
        
        pickerView = [[UIPickerView alloc]init];
        pickerView.delegate = self;
        pickerView.tag = 1;
        [_customRepeatingTextField setInputView:pickerView];
        
    }
    
}

-(void)SetUpViewingCustomReminderDataAndViews {
    
    if (viewingCustomReminder) {
        
        customReminderFrequencyAmountComp = @"30";
        customReminderFrequencyTypeComp = @"Minutes";
        
        viewingCustomReminderFrequencyTypeArray = [[NSMutableArray alloc] init];
        [viewingCustomReminderFrequencyTypeArray addObject:@"Minute"];
        [viewingCustomReminderFrequencyTypeArray addObject:@"Hour"];
        [viewingCustomReminderFrequencyTypeArray addObject:@"Day"];
        [viewingCustomReminderFrequencyTypeArray addObject:@"Week"];
        
        viewingCustomReminderFrequencyTypePluralArray = [[NSMutableArray alloc] init];
        [viewingCustomReminderFrequencyTypePluralArray addObject:@"Minutes"];
        [viewingCustomReminderFrequencyTypePluralArray addObject:@"Hours"];
        [viewingCustomReminderFrequencyTypePluralArray addObject:@"Days"];
        [viewingCustomReminderFrequencyTypePluralArray addObject:@"Weeks"];
        [viewingCustomReminderFrequencyTypePluralArray addObject:@"Months"];
        
        viewingCustomReminderFrequencyAmountArray = [[NSMutableArray alloc] init];
        
        for (int i=1;i<=59;i++) {
            [viewingCustomReminderFrequencyAmountArray addObject:[NSString stringWithFormat:@"%d", i]];
        }
        
        _customRepeatingTextField.delegate = self;
        
        UIPickerView *pickerView;
        
        pickerView = [[UIPickerView alloc]init];
        pickerView.delegate = self;
        pickerView.tag = 1;
        [_customRepeatingTextField setInputView:pickerView];
        
    }
    
}

-(void)SetUpViewingCustomReminderBeforeDataAndViews {
    
    if (viewingCustomReminderBefore) {
        
        customReminderBeforeFrequencyAmountComp = @"30";
        customReminderBeforeFrequencyTypeComp = @"Minutes";
        customReminderBeforeFrequencyBeforeComp = @"Before";
        
        viewingCustomReminderBeforeFrequencyTypeArray = [[NSMutableArray alloc] init];
        [viewingCustomReminderBeforeFrequencyTypeArray addObject:@"Minute"];
        [viewingCustomReminderBeforeFrequencyTypeArray addObject:@"Hour"];
        [viewingCustomReminderBeforeFrequencyTypeArray addObject:@"Day"];
        [viewingCustomReminderBeforeFrequencyTypeArray addObject:@"Week"];
        
        viewingCustomReminderBeforeFrequencyTypePluralArray = [[NSMutableArray alloc] init];
        [viewingCustomReminderBeforeFrequencyTypePluralArray addObject:@"Minutes"];
        [viewingCustomReminderBeforeFrequencyTypePluralArray addObject:@"Hours"];
        [viewingCustomReminderBeforeFrequencyTypePluralArray addObject:@"Days"];
        [viewingCustomReminderBeforeFrequencyTypePluralArray addObject:@"Weeks"];
        [viewingCustomReminderBeforeFrequencyTypePluralArray addObject:@"Months"];
        
        viewingCustomReminderBeforeFrequencyBeforeArray = [[NSMutableArray alloc] init];
        [viewingCustomReminderBeforeFrequencyBeforeArray addObject:@"Before"];
        
        viewingCustomReminderBeforeFrequencyAmountArray = [[NSMutableArray alloc] init];
        
        for (int i=1;i<=59;i++) {
            [viewingCustomReminderBeforeFrequencyAmountArray addObject:[NSString stringWithFormat:@"%d", i]];
        }
        
        _customRepeatingTextField.delegate = self;
        
        UIPickerView *pickerView;
        
        pickerView = [[UIPickerView alloc]init];
        pickerView.delegate = self;
        pickerView.tag = 1;
        [_customRepeatingTextField setInputView:pickerView];
        
    }
    
}

-(void)SetUpViewingAlternateTurnsBeforeDataAndViews {
    
//    BOOL TaskIsRepeating = [[[BoolDataObject alloc] init] TaskIsRepeating:[@{@"ItemRepeats" : _itemRepeatsFrequency} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType]];
//    BOOL TaskIsRepeatingDaily = [[[BoolDataObject alloc] init] TaskIsRepeatingDaily:[@{@"ItemRepeats" : _itemRepeatsFrequency} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType]];
//    BOOL TaskIsRepeatingWeekly = [[[BoolDataObject alloc] init] TaskIsRepeatingWeekly:[@{@"ItemRepeats" : _itemRepeatsFrequency} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType]];
//    BOOL TaskIsRepeatingMonthly = [[[BoolDataObject alloc] init] TaskIsRepeatingMonthly:[@{@"ItemRepeats" : _itemRepeatsFrequency} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType]];
    BOOL TaskIsCompleteAsNeeded = [[[BoolDataObject alloc] init] TaskIsCompleteAsNeeded:[@{@"ItemRepeats" : _itemRepeatsFrequency} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType]];
    
 

    if (viewingAlternateTurns) {
        
        alternateTurnsFrequencyEveryComp = @"Every";
        alternateTurnsFrequencyAmountComp = @"1";
        alternateTurnsFrequencyTypeComp = TaskIsCompleteAsNeeded ? @"Completion" : @"Occurrence";
        
        viewingAlternateTurnsFrequencyEveryArray = [[NSMutableArray alloc] init];
        [viewingAlternateTurnsFrequencyEveryArray addObject:@"Every"];
        
        
        
        viewingAlternateTurnsFrequencyTypeArray = [[NSMutableArray alloc] init];
        if (TaskIsCompleteAsNeeded == NO) { [viewingAlternateTurnsFrequencyTypeArray addObject:@"Occurrence"]; }
        [viewingAlternateTurnsFrequencyTypeArray addObject:@"Completion"];
        
//        if (TaskIsCompleteAsNeeded == NO) {
//            
//            if (TaskIsRepeating == NO || TaskIsRepeatingDaily == YES) {
//                
//                [viewingAlternateTurnsFrequencyTypeArray addObject:@"Day"];
//                [viewingAlternateTurnsFrequencyTypeArray addObject:@"Week"];
//                [viewingAlternateTurnsFrequencyTypeArray addObject:@"Month"];
//                
//            } else if (TaskIsRepeatingWeekly == YES) {
//                
//                [viewingAlternateTurnsFrequencyTypeArray addObject:@"Week"];
//                [viewingAlternateTurnsFrequencyTypeArray addObject:@"Month"];
//                
//            } else if (TaskIsRepeatingMonthly == YES) {
//                
//                [viewingAlternateTurnsFrequencyTypeArray addObject:@"Month"];
//                
//            } else {
//                
//                [viewingAlternateTurnsFrequencyTypeArray addObject:@"Day"];
//                [viewingAlternateTurnsFrequencyTypeArray addObject:@"Week"];
//                [viewingAlternateTurnsFrequencyTypeArray addObject:@"Month"];
//                
//            }
//            
//        }
       
        
        
        viewingAlternateTurnsFrequencyTypePluralArray = [[NSMutableArray alloc] init];
        if (TaskIsCompleteAsNeeded == NO) { [viewingAlternateTurnsFrequencyTypePluralArray addObject:@"Occurrences"]; }
        [viewingAlternateTurnsFrequencyTypePluralArray addObject:@"Completions"];

//        if (TaskIsCompleteAsNeeded == NO) {
//            
//            if (TaskIsRepeating == NO || TaskIsRepeatingDaily == YES) {
//                
//                [viewingAlternateTurnsFrequencyTypePluralArray addObject:@"Days"];
//                [viewingAlternateTurnsFrequencyTypePluralArray addObject:@"Weeks"];
//                [viewingAlternateTurnsFrequencyTypePluralArray addObject:@"Months"];
//                
//            } else if (TaskIsRepeatingWeekly == YES) {
//                
//                [viewingAlternateTurnsFrequencyTypePluralArray addObject:@"Weeks"];
//                [viewingAlternateTurnsFrequencyTypePluralArray addObject:@"Months"];
//                
//            } else if (TaskIsRepeatingMonthly == YES) {
//                
//                [viewingAlternateTurnsFrequencyTypePluralArray addObject:@"Months"];
//                
//            } else {
//                
//                [viewingAlternateTurnsFrequencyTypePluralArray addObject:@"Days"];
//                [viewingAlternateTurnsFrequencyTypePluralArray addObject:@"Weeks"];
//                [viewingAlternateTurnsFrequencyTypePluralArray addObject:@"Months"];
//                
//            }
//            
//        }
        
        
        
        viewingAlternateTurnsFrequencyAmountArray = [[NSMutableArray alloc] init];
        
        for (int i=1;i<=59;i++) {
            [viewingAlternateTurnsFrequencyAmountArray addObject:[NSString stringWithFormat:@"%d", i]];
        }
        
        
        
        _customRepeatingTextField.delegate = self;
        
        UIPickerView *pickerView;
        
        pickerView = [[UIPickerView alloc]init];
        pickerView.delegate = self;
        pickerView.tag = 1;
        [_customRepeatingTextField setInputView:pickerView];
        
    }
    
}

#pragma mark - Custom Methods

-(CGFloat)AdjustTableViewHeight:(NSMutableArray *)arrayToUse tableView:(UITableView *)tableView {
    
    CGFloat tableViewHeight = 0;
    
    if (arrayToUse.count > 0) {
        
        tableViewHeight = (self.view.frame.size.height*0.067934 > 50?(50):self.view.frame.size.height*0.067934)*[arrayToUse count];
        
        CGFloat height = CGRectGetHeight(self.view.bounds);
        
        CGFloat bottomPadding = [[[GeneralObject alloc] init] GetBottomPaddingHeight];
        
        CGFloat maxiumHeightToCheck =
        tableView == _additionalOptionsTableView ?
        (tableViewHeight > (self.view.frame.size.height*0.067934 > 50?(50):self.view.frame.size.height*0.067934)*6) :
        (tableViewHeight > (height - tableView.frame.origin.y - 12 - bottomPadding));
        
        CGFloat mexiumHeight = (height - tableView.frame.origin.y - 12 - bottomPadding);
        
        if (maxiumHeightToCheck) {
            if (tableView == _additionalOptionsTableView) {
                tableViewHeight = (self.view.frame.size.height*0.067934 > 50?(50):self.view.frame.size.height*0.067934)*6;
            } else if (tableView == _customTableView) {
                tableViewHeight = mexiumHeight;
            }
        }
        
    }
    
    return tableViewHeight;
    
}

-(void)DoneCustom {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Keyboard Toolbar Button \"Done\" Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    [_customRepeatingTextField resignFirstResponder];
    
}

-(void)RandomizeTurnOrderPopup {
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Randomize Turn Order" message:[NSString stringWithFormat:@"This option automatically generates a random turn order everytime a %@ repeats", [[[[GeneralObject alloc] init] GenerateItemType] lowercaseString]] preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Got it!"
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction * _Nonnull action) {}];
    
    [controller addAction:cancel];
    [self presentViewController:controller animated:YES completion:nil];
    
}

-(void)AnyDayPopup {
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Any Day" message:[NSString stringWithFormat:@"This option allows assignees to complete this %@ at any day in a given %@", [[[[GeneralObject alloc] init] GenerateItemType] lowercaseString], [_itemRepeatsFrequency containsString:@"Week"] ? @"week" : @"month"] preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Got it!"
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction * _Nonnull action) {}];
    
    [controller addAction:cancel];
    [self presentViewController:controller animated:YES completion:nil];
    
}

#pragma mark - IBAction Methods

-(IBAction)SaveButtonAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Save Options Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    BOOL TaskIsRepeatingMonthly = [[[BoolDataObject alloc] init] TaskIsRepeatingMonthly:[@{@"ItemRepeats" : _itemRepeatsFrequency} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType]];
    
    NSMutableArray *tempSelectedArr = [NSMutableArray array];
    
    if ((viewingDays || viewingScheduledSummaryDays) && TaskIsRepeatingMonthly) {
        
        for (NSString *option in additionalOptionsArray) {
            
            if ([_itemsSelectedArray containsObject:option] && ![tempSelectedArr containsObject:option]) {
                
                [tempSelectedArr addObject:option];
                
            }
            
        }
        
    }
    
    for (NSString *option in optionsArray) {
        
        if ([_itemsSelectedArray containsObject:option] && ![tempSelectedArr containsObject:option]) {
            
            [tempSelectedArr addObject:option];
            
        }
        
    }
    
    if ((viewingRepeats || viewingAlternateTurns || viewingScheduledSummaryFrequency || viewingPastDue || viewingScheduledStart || viewingCustomReminder || viewingCustomReminderBefore) && _customRepeatingTextField.text.length > 0) {
        
        [tempSelectedArr addObject:_customRepeatingTextField.text];
        
    }
    
    NSString *notificationObserver = @"";
    NSDictionary *notificationDict = [NSDictionary dictionary];
    
    if (viewingTabBar) {
      
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemTabBar" userInfo:@{@"TabBar" : tempSelectedArr} locations:@[@"Tasks", @"Chats"]];
        
    } else if (viewingShortcutItems) {
        
        [[NSUserDefaults standardUserDefaults] setObject:_itemsSelectedArray forKey:@"ShortcutItems"];
        [[[SceneDelegate alloc] init] SetUpShortcutIcons];
   
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemShortcutItems" userInfo:nil locations:@[@"Tasks"]];
        
    } else if (viewingLaunchPage) {
        
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"LaunchPage" userInfo:@{@"LaunchPage" : tempSelectedArr.count > 0 ? tempSelectedArr[0] : @""} locations:@[@"Settings"]];
        
    } else if (viewingAppIcon) {

        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"AppIcon" userInfo:@{@"AppIcon" : tempSelectedArr.count > 0 ? tempSelectedArr[0] : @""} locations:@[@"Settings"]];
        
    } else if (viewingAppTheme) {
        
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"AppTheme" userInfo:@{@"AppTheme" : tempSelectedArr.count > 0 ? tempSelectedArr[0] : @""} locations:@[@"Settings"]];
   
        [[NSUserDefaults standardUserDefaults] setObject:tempSelectedArr.count > 0 ? tempSelectedArr[0] : @"" forKey:@"AppThemeSelected"];
        
    } else if (viewingColor) {
        
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemColor" userInfo:@{@"Color" : tempSelectedArr.count > 0 ? tempSelectedArr[0] : @""} locations:@[@"AddTask", @"CalendarSettings"]];
        
    } else if (viewingRepeats) {
        
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemRepeats" userInfo:@{@"Repeats" : tempSelectedArr.count > 0 ? tempSelectedArr[0] : @""} locations:@[@"Tasks", @"AddTask", @"MultiAddTasks"]];
        
    } else if (viewingAlternateTurns) {
        
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemAlternateTurns" userInfo:@{@"AlternateTurns" : tempSelectedArr.count > 0 ? tempSelectedArr[0] : @""} locations:@[@"Tasks", @"AddTask", @"MultiAddTasks"]];
    
    } else if (viewingPastDue) {
        
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemPastDue" userInfo:@{@"PastDue" : tempSelectedArr.count > 0 ? tempSelectedArr[0] : @""} locations:@[@"Tasks", @"AddTask"]];
        
    } else if (viewingSounds) {
        
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"Sound" userInfo:@{@"Sound" : tempSelectedArr.count > 0 ? tempSelectedArr[0] : @""} locations:@[@"NotificationSettings"]];
        
    } else if (viewingDifficulty) {
        
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemDifficulty" userInfo:@{@"Difficulty" : tempSelectedArr.count > 0 ? tempSelectedArr[0] : @""} locations:@[@"AddTask"]];
        
    } else if (viewingPriority) {
        
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemPriority" userInfo:@{@"Priority" : tempSelectedArr.count > 0 ? tempSelectedArr[0] : @""} locations:@[@"AddTask"]];
        
    } else if (viewingDays) {
     
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemDays" userInfo:@{@"Days" : tempSelectedArr, @"AnyDay" : [_anyDaySwitch isOn] ? @"Yes" : @"No"} locations:@[@"Tasks", @"AddTask"]];
        
    } else if (viewingScheduledSummaryDays) {
        
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ScheduledSummaryDays" userInfo:@{@"Days" : tempSelectedArr} locations:@[@"NotificationSettings"]];
        
    } else if (viewingTurnOrder) {
        
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemSpecificOrder" userInfo:@{@"SpecificOrder" : optionsArray, @"Randomize" : [_randomizeTurnOrderSwitch isOn] ? @"Yes" : @"No"} locations:@[@"AddTask"]];
        
    } else if (viewingScheduledSummaryFrequency) {
        
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ScheduledSummaryFrequency" userInfo:@{@"Frequency" : tempSelectedArr.count > 0 ? tempSelectedArr[0] : @"Daily"} locations:@[@"NotificationSettings"]];
        
    } else if (viewingScheduledStart) {
        
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemScheduledStart" userInfo:@{@"ScheduledStart" : tempSelectedArr.count > 0 ? tempSelectedArr[0] : @""} locations:@[@"AddTask"]];
        
        notificationObserver = @"NSNotification_AddTask_ItemScheduledStart";
        notificationDict = @{@"ScheduledStart" : tempSelectedArr.count > 0 ? tempSelectedArr[0] : @""};
        
    } else if (viewingCustomReminder || viewingCustomReminderBefore) {
        
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemCustomReminder" userInfo:@{@"CustomReminder" : tempSelectedArr.count > 0 ? tempSelectedArr[0] : @""} locations:@[@"AddTask"]];
    
    }

    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(IBAction)AddOption:(id)sender {
    
    _itemsSelectedArray = _itemsSelectedArray ? _itemsSelectedArray : [NSMutableArray array];
    additionalOptionsArray = additionalOptionsArray ? additionalOptionsArray : [NSMutableArray array];
    
    NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
    NSString *trimmedString = [_customRepeatingTextField.text stringByTrimmingCharactersInSet:charSet];
    
    if (trimmedString.length > 0) {
        
        if ([additionalOptionsArray containsObject:_customRepeatingTextField.text]) {
            
            [additionalOptionsArray removeObject:_customRepeatingTextField.text];
        }
        
        [additionalOptionsArray addObject:_customRepeatingTextField.text];
        
        if ([_itemsSelectedArray containsObject:_customRepeatingTextField.text] == NO) {
            
            [_itemsSelectedArray addObject:_customRepeatingTextField.text];
            
        }
        
    }
    
    if ([_itemsSelectedArray count] > 0) {
        
        [_anyDaySwitch setOn:NO];
        
    }
    
    _customRepeatingTextField.text = @"";
    
    [UIView animateWithDuration:0.25 animations:^{
        
        CGRect newRect = self->_additionalOptionsTableView.frame;
        newRect.size.height = [self AdjustTableViewHeight:self->additionalOptionsArray tableView:self->_additionalOptionsTableView];
        self->_additionalOptionsTableView.frame = newRect;
        
        newRect = self->_customTableView.frame;
        newRect.origin.y = self->_additionalOptionsTableView.frame.origin.y + self->_additionalOptionsTableView.frame.size.height + 12;
        self->_customTableView.frame = newRect;
        
        newRect = self->_customTableView.frame;
        newRect.size.height = [self AdjustTableViewHeight:self->optionsArray tableView:self->_customTableView];
        self->_customTableView.frame = newRect;
        
    } completion:^(BOOL finished) {
        
        [self.additionalOptionsTableView reloadData];
        
        NSInteger numberOfRows = [self.additionalOptionsTableView numberOfRowsInSection:0];
        
        if (numberOfRows > 0) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.additionalOptionsTableView numberOfRowsInSection:0]-1 inSection:0];
            [self.additionalOptionsTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            
        }
        
    }];
    
}

-(IBAction)RandomizeTurnOrderSwitchAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Randomize Turn Order Switch Clicked %@ For %@", [_randomizeTurnOrderSwitch isOn] ? @"On" : @"Off", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
}

-(IBAction)AnyDaySwitchAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Any Day Switch Clicked %@ For %@", [_anyDaySwitch isOn] ? @"On" : @"Off", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    if ([_anyDaySwitch isOn]) {
        
        _itemsSelectedArray = [NSMutableArray array];
        [self.customTableView reloadData];
        [self.additionalOptionsTableView reloadData];
        
    }
    
}

-(IBAction)NavigationBackButtonAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Navigation Back Button Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - Table View Methods

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    OptionsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OptionsCell" forIndexPath:indexPath];
    
    if (cell) {
        
        [self GenerateOptionLeftLabel:cell indexPath:indexPath tableView:tableView];
        
        [self GenerateCheckMarkImage:cell indexPath:indexPath tableView:tableView];
        
        [self GenerateProfileImage:cell indexPath:indexPath];
        
        [self GenerateColorView:cell indexPath:indexPath];
        
        return cell;
    }
    
    UITableViewCell *cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DefaultCellIdentifier"];
    
    return cell1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == _additionalOptionsTableView) {
        
        return additionalOptionsArray.count;
        
    }
    
    return optionsArray.count;
    
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(OptionsCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    cell.itemOptionLeftLabel.font = [UIFont systemFontOfSize:(self.view.frame.size.height*0.02298851 > 16?16:(self.view.frame.size.height*0.02298851)) weight:UIFontWeightRegular];
    
    CGFloat height = CGRectGetHeight(cell.contentView.bounds);
    CGFloat width = CGRectGetWidth(cell.contentView.bounds);
    //374
    
    cell.itemOptionLeftLabel.frame = CGRectMake(width*0.04830918, height*0, width*0.89304813, height);
    
    cell.checkMarkImage.frame = viewingAppIcon == YES ?
    CGRectMake(width - (height*0.5) - width*0.04830918, height*0.5 - (((height*0.5)*0.5)), height*0.5, height*0.5) :
    CGRectMake(width - (height*0.5) - width*0.04830918, height*0.5 - (((height*0.5)*0.5)), height*0.5, height*0.5);
    
    cell.itemOptionColorView.frame = CGRectMake(cell.checkMarkImage.frame.origin.x - (height*0.5) - width*0.04278075, height*0.5 - ((height*0.5)*0.5), height*0.5, height*0.5);
    
    if (viewingTurnOrder) {
        
        cell.profileImage.layer.cornerRadius = cell.profileImage.frame.size.height/2;
        cell.profileImage.contentMode = UIViewContentModeScaleAspectFill;
        
        cell.profileImage.frame = CGRectMake(width*0.04830918, height*0.5 - ((height*0.575)*0.5), height*0.575, height*0.575);
        cell.itemOptionLeftLabel.frame = CGRectMake(cell.profileImage.frame.origin.x + cell.profileImage.frame.size.width + width*0.04830918, height*0, width*0.89304813, height);
        
    } else if (viewingAppIcon) {
        
        cell.profileImage.frame = CGRectMake(cell.checkMarkImage.frame.origin.x - (height*0.6) - width*0.04278075, height*0.5 - ((height*0.6)*0.5), height*0.6, height*0.6);
        cell.profileImage.layer.cornerRadius = cell.profileImage.frame.size.height/5;
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_viewingItemDetails == NO) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Did Select Option %@ For %@", optionsArray[indexPath.row], [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {}];
        
        [self SpecificDatesDeleteMessage:indexPath];

        _customRepeatingTextField.text = @"";
        [_customRepeatingTextField resignFirstResponder];
        
        NSString *objectToAdd = tableView == _additionalOptionsTableView && [additionalOptionsArray count] > indexPath.row ? additionalOptionsArray[indexPath.row] : optionsArray[indexPath.row];
        
        //Multiple Selection Allowed
        if (viewingDays == NO && viewingShortcutItems == NO && viewingTabBar == NO) { _itemsSelectedArray = [NSMutableArray array]; }
        if (viewingDays == NO && viewingShortcutItems == NO && viewingTabBar == NO) { [_itemsSelectedArray addObject:objectToAdd]; }
        
        if (viewingAppIcon == YES) {
            
            [self SelectAppIcon:indexPath];
            
        } else if (viewingAppTheme == YES) {
            
            [self SelectAppTheme:indexPath];
            
        } else if (viewingLaunchPage) {
            
            [self SelectLaunchPage:indexPath];
            
        } else if (viewingColor) {
            
            [self SelectColor:indexPath];
            
        } else if (viewingDays) {
            
            [self SelectDays:indexPath tableView:tableView];
            
        } else if (viewingShortcutItems) {
            
            [self SelectShortcutItems:indexPath];
            
        } else if (viewingTabBar) {
            
            [self SelectTabBar:indexPath];
            
        } else if (viewingRepeats || viewingAlternateTurns || viewingScheduledSummaryFrequency || viewingDifficulty || viewingPriority || viewingPastDue) {
            
            //[self dismissViewControllerAnimated:YES completion:nil];
            
        }
        
        [self.customTableView reloadData];
        [self.additionalOptionsTableView reloadData];
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return (self.view.frame.size.height*0.067934 > 50?(50):self.view.frame.size.height*0.067934);
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    
    NSMutableArray *array = optionsArray;
    NSInteger index = sourceIndexPath.row;
    id obj = array[index];
    [array removeObjectAtIndex:index];
    [array insertObject:obj atIndex:destinationIndexPath.row];
    
    array = homeMemberProfileImageURLArray;
    index = sourceIndexPath.row;
    obj = array[index];
    [array removeObjectAtIndex:index];
    [array insertObject:obj atIndex:destinationIndexPath.row];

    array = homeMemberUsernameArray;
    index = sourceIndexPath.row;
    obj = array[index];
    [array removeObjectAtIndex:index];
    [array insertObject:obj atIndex:destinationIndexPath.row];
    
    [self.customTableView reloadData];
}

- (BOOL)tableView:(UITableView *)tableview shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

-(UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UIContextualAction *DeleteAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:nil handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        
        NSString *objectToRemove = self->additionalOptionsArray && [self->additionalOptionsArray count] > indexPath.row ? self->additionalOptionsArray[indexPath.row] : @"";
        
        if ([self->_itemsSelectedArray containsObject:objectToRemove]) {
            [self->_itemsSelectedArray removeObject:objectToRemove];
        }
        if ([self->additionalOptionsArray containsObject:objectToRemove]) {
            [self->additionalOptionsArray removeObject:objectToRemove];
        }
        
        [UIView animateWithDuration:0.25 animations:^{
            
            CGRect newRect = self->_additionalOptionsTableView.frame;
            newRect.size.height = [self AdjustTableViewHeight:self->additionalOptionsArray tableView:self->_additionalOptionsTableView];
            self->_additionalOptionsTableView.frame = newRect;
            
            newRect = self->_customTableView.frame;
            newRect.origin.y = self->_additionalOptionsTableView.frame.origin.y + self->_additionalOptionsTableView.frame.size.height + 12;
            self->_customTableView.frame = newRect;
            
            newRect = self->_customTableView.frame;
            newRect.size.height = [self AdjustTableViewHeight:self->optionsArray tableView:self->_customTableView];
            self->_customTableView.frame = newRect;
            
        } completion:^(BOOL finished) {
            
            [self.additionalOptionsTableView reloadData];
            
        }];
        
    }];
    
    DeleteAction.image = [UIImage systemImageNamed:@"xmark"];
    DeleteAction.backgroundColor = [UIColor systemRedColor];
    
    NSMutableArray *actionsArray = [NSMutableArray array];
    
    if (tableView == _additionalOptionsTableView) {
        [actionsArray addObject:DeleteAction];
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

#pragma mark SetUpOptions

-(void)SetUpTabBarOptions {
 
    [optionsArray addObject:@"🧹 Chores"];
    [optionsArray addObject:@"💵 Expenses"];
    [optionsArray addObject:@"📝 Lists"];
    [optionsArray addObject:@"💬 Chats"];
    
}

-(void)SetUpShortcutOptions {
    
    optionsArray = [_customOptionsArray mutableCopy];
    
    NSMutableArray *itemsSelectedArrayCopy = [_itemsSelectedArray mutableCopy];
    
    for (NSString *shortcutItem in itemsSelectedArrayCopy) {
        
        if ([optionsArray containsObject:shortcutItem] == NO && [_itemsSelectedArray containsObject:shortcutItem]) {
            
            [_itemsSelectedArray removeObject:shortcutItem];
            
        }
        
    }
    
}

-(void)SetUpTurnOrderOptions {
    
    NSString *selectedItem = _itemsSelectedArray && [_itemsSelectedArray count] > 0 ? _itemsSelectedArray[0] : @"";
    
    if ([selectedItem containsString:@"Randomize"]) {
        
        [_randomizeTurnOrderSwitch setOn:YES];
        
    }
    
    for (NSString *str in homeMemberUsernameArray) {
        [optionsArray addObject:str];
    }
    
}

-(void)SetUpColorOptions {
    
    NSArray *colorsArray = [[[GeneralObject alloc] init] GenerateColorOptionsArray];
    
    for (NSString *color in colorsArray) {
        [optionsArray addObject:color];
    }
    
}

-(void)SetUpAppThemeOptions {
    
    NSArray *colorsArray = [[[GeneralObject alloc] init] GenerateAppIconColorNameOptionsArray];
    
    for (NSString *color in colorsArray) {
        [optionsArray addObject:color];
    }
    
}

-(void)SetUpAppIconOptions {
    
    NSArray *colorsArray = [[[GeneralObject alloc] init] GenerateAppIconColorNameOptionsArray];
    
    for (NSString *color in colorsArray) {
        [optionsArray addObject:color];
    }
    
}

-(void)SetUpLaunchOptions {
    
    NSArray *colorsArray = [[[GeneralObject alloc] init] GenerateLaunchPageOptionsArray];
    
    for (NSString *color in colorsArray) {
        [optionsArray addObject:color];
    }
    
}

-(void)SetUpRepeatsOptions {
    
    NSString *selectedItem = _itemsSelectedArray && [_itemsSelectedArray count] > 0 ? _itemsSelectedArray[0] : @"";
    
    if (viewingScheduledSummaryFrequency) {
        
        [optionsArray addObject:@"Never"];
        [optionsArray addObject:@"Daily"];
        [optionsArray addObject:@"Weekly"];
        [optionsArray addObject:@"Bi-Weekly"];
        [optionsArray addObject:@"Semi-Monthly"];
        [optionsArray addObject:@"Monthly"];
        
    }
    
    if (((viewingRepeats == YES) &&
         ([selectedItem isEqualToString:@"Never"] == NO &&
          [selectedItem isEqualToString:@"Hourly"] == NO &&
          [selectedItem isEqualToString:@"Daily"] == NO &&
          [selectedItem isEqualToString:@"Bi-Weekly"] == NO &&
          [selectedItem isEqualToString:@"Weekly"] == NO &&
          [selectedItem isEqualToString:@"Semi-Monthly"] == NO &&
          [selectedItem isEqualToString:@"Monthly"] == NO &&
          [selectedItem containsString:@"When Completed"] == NO &&
          [selectedItem length] > 0)) ||
        
        ((viewingScheduledSummaryFrequency == YES) &&
         ([optionsArray containsObject:selectedItem] == NO &&
          [selectedItem containsString:@"When Completed"] == NO &&
          [selectedItem length] > 0)) ) {
        
        _customRepeatingTextField.text = selectedItem;
        
        NSArray *frequencyArray = [selectedItem componentsSeparatedByString:@" "];
        
        if (frequencyArray.count == 2) {
            repeatingFrequencyEveryComp = [frequencyArray count] > 0 ? frequencyArray[0] : @"";
            repeatingFrequencyAmountComp = @"";
            repeatingFrequencyTypeComp = [frequencyArray count] > 1 ? frequencyArray[1] : @"";
        } else {
            repeatingFrequencyEveryComp = [frequencyArray count] > 0 ? frequencyArray[0] : @"";
            repeatingFrequencyAmountComp = [frequencyArray count] > 1 ? frequencyArray[1] : @"";
            repeatingFrequencyTypeComp = [frequencyArray count] > 2 ? frequencyArray[2] : @"";
        }
        
        UIPickerView *datePicker = (UIPickerView *)[self.customRepeatingTextField inputView];
        if ([self->viewingRepeatingFrequencyAmountArray containsObject:self->repeatingFrequencyAmountComp]) { [datePicker selectRow:[self->viewingRepeatingFrequencyAmountArray indexOfObject:self->repeatingFrequencyAmountComp] inComponent:1 animated:YES]; }
        if ([self->viewingRepeatingFrequencyTypeArray containsObject:self->repeatingFrequencyTypeComp]) { [datePicker selectRow:[self->viewingRepeatingFrequencyTypeArray indexOfObject:self->repeatingFrequencyTypeComp] inComponent:2 animated:YES]; }
        
        
    }
    
}

-(void)SetUpPastDueOptions {
    
    NSString *selectedItem = _itemsSelectedArray && [_itemsSelectedArray count] > 0 ? _itemsSelectedArray[0] : @"";
    
    if ([selectedItem isEqualToString:@"Never"] == NO &&
        [selectedItem isEqualToString:@"30 Minutes"] == NO &&
        [selectedItem isEqualToString:@"1 Hour"] == NO &&
        [selectedItem isEqualToString:@"1 Day"] == NO &&
        [selectedItem isEqualToString:@"1 Week"] == NO &&
        [selectedItem isEqualToString:@"Until Completed"] == NO &&
        [selectedItem length] > 0) {
        
        _customRepeatingTextField.text = selectedItem;
        
        NSArray *frequencyArray = [selectedItem componentsSeparatedByString:@" "];
        
        pastDueFrequencyAmountComp = frequencyArray[0];
        pastDueFrequencyTypeComp = frequencyArray[1];
        
        UIPickerView *datePicker = (UIPickerView *)[self.customRepeatingTextField inputView];
        
        if ([self->viewingPastDueFrequencyAmountArray containsObject:self->pastDueFrequencyAmountComp] && [self->viewingPastDueFrequencyTypeArray containsObject:self->pastDueFrequencyTypeComp]) {
            
            [datePicker selectRow:[self->viewingPastDueFrequencyAmountArray indexOfObject:self->pastDueFrequencyAmountComp] inComponent:0 animated:YES];
            [datePicker selectRow:[self->viewingPastDueFrequencyTypeArray indexOfObject:self->pastDueFrequencyTypeComp] inComponent:1 animated:YES];
            
        } else if ([self->viewingPastDueFrequencyAmountArray containsObject:self->pastDueFrequencyAmountComp] && [self->viewingPastDueFrequencyTypePluralArray containsObject:self->pastDueFrequencyTypeComp]) {
            
            [datePicker selectRow:[self->viewingPastDueFrequencyAmountArray indexOfObject:self->pastDueFrequencyAmountComp] inComponent:0 animated:YES];
            [datePicker selectRow:[self->viewingPastDueFrequencyTypePluralArray indexOfObject:self->pastDueFrequencyTypeComp] inComponent:1 animated:YES];
            
        }
        
    } else if ([selectedItem isEqualToString:@"Until Completed"]) {
        
        UIPickerView *datePicker = (UIPickerView *)[self.customRepeatingTextField inputView];
        
        if ([self->viewingPastDueFrequencyAmountArray containsObject:@"1"] && [self->viewingPastDueFrequencyTypeArray containsObject:@"Day"]) {
            
            [datePicker selectRow:[self->viewingPastDueFrequencyAmountArray indexOfObject:@"1"] inComponent:0 animated:YES];
            [datePicker selectRow:[self->viewingPastDueFrequencyTypeArray indexOfObject:@"Day"] inComponent:1 animated:YES];
            
        }
        
    }
    
}

-(void)SetUpAlternateTurnsOptions {
    
    NSString *selectedItem = _itemsSelectedArray && [_itemsSelectedArray count] > 0 ? _itemsSelectedArray[0] : @"";
    
    if ([selectedItem isEqualToString:@"Never"] == NO &&
        [selectedItem isEqualToString:@"30 Minutes"] == NO &&
        [selectedItem isEqualToString:@"1 Hour"] == NO &&
        [selectedItem isEqualToString:@"1 Day"] == NO &&
        [selectedItem isEqualToString:@"1 Week"] == NO &&
        [selectedItem isEqualToString:@"Until Completed"] == NO &&
        [selectedItem length] > 0) {
        
        _customRepeatingTextField.text = selectedItem;
        
        NSArray *frequencyArray = [selectedItem componentsSeparatedByString:@" "];
        
        if ([frequencyArray count] == 2) {
            
            alternateTurnsFrequencyEveryComp = frequencyArray[0];
            alternateTurnsFrequencyTypeComp = frequencyArray[1];
            
        } else if ([frequencyArray count] == 3) {
            
            alternateTurnsFrequencyEveryComp = frequencyArray[0];
            alternateTurnsFrequencyAmountComp = frequencyArray[1];
            alternateTurnsFrequencyTypeComp = frequencyArray[2];
            
        }
        
        UIPickerView *datePicker = (UIPickerView *)[self.customRepeatingTextField inputView];
        
        if ([self->viewingAlternateTurnsFrequencyAmountArray containsObject:self->alternateTurnsFrequencyAmountComp] && [self->viewingPastDueFrequencyTypeArray containsObject:self->alternateTurnsFrequencyTypeComp]) {
            
            [datePicker selectRow:[self->viewingAlternateTurnsFrequencyAmountArray indexOfObject:self->alternateTurnsFrequencyAmountComp] inComponent:0 animated:YES];
            [datePicker selectRow:[self->viewingAlternateTurnsFrequencyTypeArray indexOfObject:self->alternateTurnsFrequencyTypeComp] inComponent:1 animated:YES];
            
        } else if ([self->viewingAlternateTurnsFrequencyAmountArray containsObject:self->alternateTurnsFrequencyAmountComp] && [self->viewingAlternateTurnsFrequencyTypeArray containsObject:self->alternateTurnsFrequencyTypeComp]) {
            
            [datePicker selectRow:[self->viewingAlternateTurnsFrequencyAmountArray indexOfObject:self->alternateTurnsFrequencyAmountComp] inComponent:0 animated:YES];
            [datePicker selectRow:[self->viewingAlternateTurnsFrequencyTypeArray indexOfObject:self->alternateTurnsFrequencyTypeComp] inComponent:1 animated:YES];
            
        }
        
    } else if ([selectedItem isEqualToString:@"Until Completed"]) {
        
        UIPickerView *datePicker = (UIPickerView *)[self.customRepeatingTextField inputView];
        
        if ([self->viewingAlternateTurnsFrequencyAmountArray containsObject:@"1"] && [self->viewingAlternateTurnsFrequencyTypeArray containsObject:@"Day"]) {
            
            [datePicker selectRow:[self->viewingAlternateTurnsFrequencyAmountArray indexOfObject:@"1"] inComponent:0 animated:YES];
            [datePicker selectRow:[self->viewingAlternateTurnsFrequencyTypeArray indexOfObject:@"Day"] inComponent:1 animated:YES];
            
        }
        
    }
    
}

-(void)SetUpSoundOptions {
    
    [optionsArray addObject:@"Default"];
    [optionsArray addObject:@"Sound1"];
    [optionsArray addObject:@"Sound2"];
    [optionsArray addObject:@"Sound3"];
    [optionsArray addObject:@"Sound4"];
    [optionsArray addObject:@"Sound5"];
    
}

-(void)SetUpDifficultyOptions {
    
    [optionsArray addObject:@"None"];
    [optionsArray addObject:@"Easy"];
    [optionsArray addObject:@"Medium"];
    [optionsArray addObject:@"Hard"];
    
}

-(void)SetUpPriorityOptions {
    
    [optionsArray addObject:@"No Priority"];
    [optionsArray addObject:@"Low"];
    [optionsArray addObject:@"Medium"];
    [optionsArray addObject:@"High"];
    
}

-(void)SetUpDayOptions {
    
    BOOL TaskIsRepeatingWeekly = [[[BoolDataObject alloc] init] TaskIsRepeatingWeekly:[@{@"ItemRepeats" : _itemRepeatsFrequency} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType]];
    BOOL TaskIsRepeatingMonthly = [[[BoolDataObject alloc] init] TaskIsRepeatingMonthly:[@{@"ItemRepeats" : _itemRepeatsFrequency} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType]];
    
    if (TaskIsRepeatingWeekly) {
        
        NSString *selectedItem = _itemsSelectedArray && [_itemsSelectedArray count] > 0 ? _itemsSelectedArray[0] : @"";
        
        if ([selectedItem containsString:@"Any Day"]) {
            
            [_anyDaySwitch setOn:YES];
            
        }
        
        [optionsArray addObject:@"Sunday"];
        [optionsArray addObject:@"Monday"];
        [optionsArray addObject:@"Tuesday"];
        [optionsArray addObject:@"Wednesday"];
        [optionsArray addObject:@"Thursday"];
        [optionsArray addObject:@"Friday"];
        [optionsArray addObject:@"Saturday"];
        
    } else if ((viewingDays || viewingScheduledSummaryDays) && TaskIsRepeatingMonthly) {
        
        NSString *selectedItem = _itemsSelectedArray && [_itemsSelectedArray count] > 0 ? _itemsSelectedArray[0] : @"";
        
        if ([selectedItem containsString:@"Any Day"]) {
            
            [_anyDaySwitch setOn:YES];
            
        }
        
        [optionsArray addObject:@"1st"];
        [optionsArray addObject:@"2nd"];
        [optionsArray addObject:@"3rd"];
        for (int i=4;i<21;i++) {
            [optionsArray addObject:[NSString stringWithFormat:@"%dth", i]];
        }
        [optionsArray addObject:@"21st"];
        [optionsArray addObject:@"22nd"];
        [optionsArray addObject:@"23rd"];
        for (int i=24;i<29;i++) {
            [optionsArray addObject:[NSString stringWithFormat:@"%dth", i]];
        }
        [optionsArray addObject:@"Last Day"];
        
        if (_itemsSelectedArray.count > 0) {
            
            additionalOptionsArray = additionalOptionsArray ? additionalOptionsArray : [NSMutableArray array];
            
            for (NSString *str in _itemsSelectedArray) {
                
                if ([str containsString:@"day"] && [str isEqualToString:@"Last Day"] == NO) {
                    
                    [additionalOptionsArray addObject:str];
                    
                }
                
            }
            
        }
        
    }
}

-(void)SetUpScheduledStartOptions {
    
    NSString *selectedItem = _itemsSelectedArray && [_itemsSelectedArray count] > 0 ? _itemsSelectedArray[0] : @"";
    
    if ([selectedItem length] > 0 && [selectedItem isEqualToString:@"Now"] == NO && [selectedItem isEqualToString:@"Never"] == NO) {
        
        _customRepeatingTextField.text = selectedItem;
        
        NSArray *frequencyArray = [selectedItem componentsSeparatedByString:@" "];
        
        scheduledStartFrequencyAmountComp = frequencyArray[0];
        scheduledStartFrequencyTypeComp = frequencyArray[1];
        
        UIPickerView *datePicker = (UIPickerView *)[self.customRepeatingTextField inputView];
        
        if ([self->viewingScheduledStartFrequencyAmountArray containsObject:self->scheduledStartFrequencyAmountComp] && [self->viewingScheduledStartFrequencyTypeArray containsObject:self->scheduledStartFrequencyTypeComp]) {
            
            [datePicker selectRow:[self->viewingScheduledStartFrequencyAmountArray indexOfObject:self->scheduledStartFrequencyAmountComp] inComponent:0 animated:YES];
            [datePicker selectRow:[self->viewingScheduledStartFrequencyTypeArray indexOfObject:self->scheduledStartFrequencyTypeComp] inComponent:1 animated:YES];
            
        } else if ([self->viewingScheduledStartFrequencyAmountArray containsObject:self->scheduledStartFrequencyAmountComp] && [self->viewingScheduledStartFrequencyTypePluralArray containsObject:self->scheduledStartFrequencyTypeComp]) {
            
            [datePicker selectRow:[self->viewingScheduledStartFrequencyAmountArray indexOfObject:self->scheduledStartFrequencyAmountComp] inComponent:0 animated:YES];
            [datePicker selectRow:[self->viewingScheduledStartFrequencyTypePluralArray indexOfObject:self->scheduledStartFrequencyTypeComp] inComponent:1 animated:YES];
            
        }
        
    }
    
}

-(void)SetUpCustomReminderOptions {
    
    NSString *selectedItem = _itemsSelectedArray && [_itemsSelectedArray count] > 0 ? _itemsSelectedArray[0] : @"";
    
    if ([selectedItem length] > 0 && [selectedItem isEqualToString:@"Now"] == NO && [selectedItem isEqualToString:@"Never"] == NO) {
        
        _customRepeatingTextField.text = selectedItem;
        
        NSArray *frequencyArray = [selectedItem componentsSeparatedByString:@" "];
        
        customReminderFrequencyAmountComp = frequencyArray[0];
        customReminderFrequencyTypeComp = frequencyArray[1];
        
        UIPickerView *datePicker = (UIPickerView *)[self.customRepeatingTextField inputView];
        
        if ([self->viewingCustomReminderFrequencyAmountArray containsObject:self->customReminderFrequencyAmountComp] && [self->viewingCustomReminderFrequencyTypeArray containsObject:self->customReminderFrequencyTypeComp]) {
            
            [datePicker selectRow:[self->viewingCustomReminderFrequencyAmountArray indexOfObject:self->customReminderFrequencyAmountComp] inComponent:0 animated:YES];
            [datePicker selectRow:[self->viewingCustomReminderFrequencyTypeArray indexOfObject:self->customReminderFrequencyTypeComp] inComponent:1 animated:YES];
            
        } else if ([self->viewingCustomReminderFrequencyAmountArray containsObject:self->customReminderFrequencyAmountComp] && [self->viewingCustomReminderFrequencyTypePluralArray containsObject:self->customReminderFrequencyTypeComp]) {
            
            [datePicker selectRow:[self->viewingCustomReminderFrequencyAmountArray indexOfObject:self->customReminderFrequencyAmountComp] inComponent:0 animated:YES];
            [datePicker selectRow:[self->viewingCustomReminderFrequencyTypePluralArray indexOfObject:self->customReminderFrequencyTypeComp] inComponent:1 animated:YES];
            
        }
        
    }
    
}

-(void)SetUpCustomReminderBeforeOptions {
    
    NSString *selectedItem = _itemsSelectedArray && [_itemsSelectedArray count] > 0 ? _itemsSelectedArray[0] : @"";
    
    if ([selectedItem length] > 0 && [selectedItem isEqualToString:@"Now"] == NO && [selectedItem isEqualToString:@"Never"] == NO) {
        
        _customRepeatingTextField.text = selectedItem;
        
        NSArray *frequencyArray = [selectedItem componentsSeparatedByString:@" "];
        
        customReminderBeforeFrequencyAmountComp = frequencyArray[0];
        customReminderBeforeFrequencyTypeComp = frequencyArray[1];
        
        UIPickerView *datePicker = (UIPickerView *)[self.customRepeatingTextField inputView];
        
        if ([self->viewingCustomReminderBeforeFrequencyAmountArray containsObject:self->customReminderBeforeFrequencyAmountComp] && [self->viewingCustomReminderBeforeFrequencyTypeArray containsObject:self->customReminderBeforeFrequencyTypeComp]) {
            
            [datePicker selectRow:[self->viewingCustomReminderBeforeFrequencyAmountArray indexOfObject:self->customReminderBeforeFrequencyAmountComp] inComponent:0 animated:YES];
            [datePicker selectRow:[self->viewingCustomReminderBeforeFrequencyTypeArray indexOfObject:self->customReminderBeforeFrequencyTypeComp] inComponent:1 animated:YES];
            [datePicker selectRow:[self->viewingCustomReminderBeforeFrequencyBeforeArray indexOfObject:self->customReminderBeforeFrequencyBeforeComp] inComponent:2 animated:YES];
            
        } else if ([self->viewingCustomReminderBeforeFrequencyAmountArray containsObject:self->customReminderBeforeFrequencyAmountComp] && [self->viewingCustomReminderBeforeFrequencyTypePluralArray containsObject:self->customReminderBeforeFrequencyTypeComp]) {
            
            [datePicker selectRow:[self->viewingCustomReminderBeforeFrequencyAmountArray indexOfObject:self->customReminderBeforeFrequencyAmountComp] inComponent:0 animated:YES];
            [datePicker selectRow:[self->viewingCustomReminderBeforeFrequencyTypePluralArray indexOfObject:self->customReminderBeforeFrequencyTypeComp] inComponent:1 animated:YES];
            [datePicker selectRow:[self->viewingCustomReminderBeforeFrequencyBeforeArray indexOfObject:self->customReminderBeforeFrequencyBeforeComp] inComponent:2 animated:YES];
            
        }
        
    }
    
}

#pragma mark - cellForRow

-(void)GenerateOptionLeftLabel:(OptionsCell *)cell indexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    
    if (tableView == _additionalOptionsTableView) {
        
        cell.itemOptionLeftLabel.text = additionalOptionsArray && [additionalOptionsArray count] > indexPath.row ? additionalOptionsArray[indexPath.row] : @"";
        
        BOOL OptionIsSelected = additionalOptionsArray && [additionalOptionsArray count] > indexPath.row && [_itemsSelectedArray containsObject:additionalOptionsArray[indexPath.row]] ? YES : NO;
        cell.checkMarkImage.image = OptionIsSelected == YES ? [UIImage systemImageNamed:@"checkmark"] : nil;
        
    } else {
        
        cell.itemOptionLeftLabel.text = optionsArray && [optionsArray count] > indexPath.row ? optionsArray[indexPath.row] : @"";
        
    }
    
}

-(void)GenerateCheckMarkImage:(OptionsCell *)cell indexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    
    if (tableView == _additionalOptionsTableView) {
        
        
        
        BOOL OptionIsSelected = additionalOptionsArray && [additionalOptionsArray count] > indexPath.row && [_itemsSelectedArray containsObject:additionalOptionsArray[indexPath.row]] ? YES : NO;
        cell.checkMarkImage.image = OptionIsSelected == YES ? [UIImage systemImageNamed:@"checkmark"] : nil;
        
        
        
    } else {
        
        
        
        BOOL OptionIsSelected = optionsArray && [optionsArray count] > indexPath.row && [_itemsSelectedArray containsObject:optionsArray[indexPath.row]] ? YES : NO;
        
        
        
        if (viewingAppIcon) {
            
            if (([_itemsSelectedArray count] == 0 ||
                 ([_itemsSelectedArray count] > 0 && [optionsArray containsObject:_itemsSelectedArray[0]] == NO)) &&
                
                indexPath.row == 0) {
                
                OptionIsSelected = YES;
                
            }
            
        } else if (viewingTurnOrder) {
            
            OptionIsSelected = NO;
            
        }
        
        
        
        cell.checkMarkImage.image = OptionIsSelected == YES ? [UIImage systemImageNamed:@"checkmark"] : nil;
        
    }
    
}

-(void)GenerateProfileImage:(OptionsCell *)cell indexPath:(NSIndexPath *)indexPath {
    
    if (viewingAppIcon) {
        
        NSString *imageString = [[[GeneralObject alloc] init] GenerateAppIconImageNameOptionsArray][indexPath.row];
        
        NSString *str = optionsArray[indexPath.row];
        NSUInteger index = [optionsArray containsObject:str] ? [optionsArray indexOfObject:str] : 0;
        NSArray *appIconStringImageArray = [[[GeneralObject alloc] init] GenerateAppIconImageNameOptionsArray];
        imageString = [appIconStringImageArray count] > index ? appIconStringImageArray[index] : appIconStringImageArray[0];
        
        cell.profileImage.image = [UIImage imageNamed:imageString];
        
    } else if (viewingTurnOrder) {
        
        NSString *imageString = homeMemberProfileImageURLArray[indexPath.row];
       
        UIColor *backgroundColor = [[[GeneralObject alloc] init] GenerateAppColor:0.15f];
        UIColor *textColor = [[[GeneralObject alloc] init] GenerateAppColor:1.0f];
        
        NSMutableDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"Username" object:homeMemberUsernameArray[indexPath.row] homeMembersDict:_homeMembersDict];
        NSString *username = dataDict[@"Username"];
        NSString *profileImageURL = dataDict[@"ProfileImageURL"];
        
        BOOL CustomProfileImageDoesNotExist = (profileImageURL == nil || profileImageURL.length == 0 || [profileImageURL containsString:@"(null)"] || [profileImageURL isEqualToString:@"xxx"] || [profileImageURL isEqualToString:@"XXX"] || [profileImageURL isEqualToString:@"https://firebasestorage.googleapis.com/v0/b/wedivvy-afe04.appspot.com/o/DefaultImages%2FdefaultProfileImage.png?alt=media&token=6892f430-8337-4327-89a4-53a403d1186c"] || [profileImageURL containsString:@"DefaultImage"]) == YES;
        
        if (CustomProfileImageDoesNotExist == YES) {
            
            [cell.profileImage setImageWithString:username color:backgroundColor circular:YES textAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Futura-Medium" size:cell.profileImage.frame.size.height*0.45], NSForegroundColorAttributeName:textColor}];
            
        } else {
            
            [cell.profileImage sd_setImageWithURL:[NSURL URLWithString:imageString]];
            
        }
        
    }
    
}

-(void)GenerateColorView:(OptionsCell *)cell indexPath:(NSIndexPath *)indexPath {
    
    if (viewingColor == YES || viewingAppTheme == YES) {
        
        cell.itemOptionColorView.backgroundColor = [[[GeneralObject alloc] init] GenerateColorOptionFromColorString:optionsArray[indexPath.row]];
        
    } else {
        
        cell.itemOptionColorView.backgroundColor = [UIColor clearColor];
        
    }
    
}

#pragma mark - didSelectRow

-(void)SpecificDatesDeleteMessage:(NSIndexPath *)indexPath {
    
    BOOL SpecificDatesSelected = _specificDatesArray.count > 0;
    
    if (SpecificDatesSelected == YES && viewingRepeats == YES) {
        
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Multiple Due Dates Chosen"
                                                                            message:@"Would you like to delete all of your due dates?"
                                                                     preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction *gotit = [UIAlertAction actionWithTitle:@"Sure"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * _Nonnull action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Clear Multiple Dates For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
                
            }];
            
            self->_specificDatesArray = [NSMutableArray array];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:
             @"NSNotification_AddTask_ItemSpecificDueDates" object:nil userInfo:@{@"Items" : self->_specificDatesArray}];
            
            self->_customRepeatingTextField.text = @"";
            [self->_customRepeatingTextField resignFirstResponder];
            
            self->_itemsSelectedArray = [NSMutableArray array];
            [self->_itemsSelectedArray addObject:self->optionsArray[indexPath.row]];
            
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Nevermind"
                                                         style:UIAlertActionStyleCancel
                                                       handler:^(UIAlertAction * _Nonnull action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Clear Multiple Dates Cancelled For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
                
            }];
            
        }];
        
        [controller addAction:cancel];
        [controller addAction:gotit];
        [self presentViewController:controller animated:YES completion:nil];
        
    }
    
}

#pragma mark

-(BOOL)ColorIsPremium:(NSString *)color {
    
    BOOL PremiumColor = NO;
    
    NSArray *colorsArray = [[[GeneralObject alloc] init] GenerateAppIconColorNameOptionsArray];
    
    if ([colorsArray containsObject:color]) {
        
        PremiumColor = YES;
        
    }
    
    return PremiumColor;
    
}

-(void)SelectAppIcon:(NSIndexPath *)indexPath {
    
    NSString *optionSelected = optionsArray[indexPath.row];
    
    if ([[[BoolDataObject alloc] init] PremiumSubscriptionIsOn] == NO) {
        
        _itemsSelectedArray = [NSMutableArray array];
        
        [[[PushObject alloc] init] PushToWeDivvyPremiumViewController:YES comingFromSignUp:NO defaultPlan:@"" displayDiscount:@"Half-Off Yearly Discount No Sale Sticker" selectedSlide:@"Custom App Icons" promoCodeID:@"" premiumPlanProductsArray:premiumPlanProductsArray premiumPlanPricesDict:premiumPlanPricesDict premiumPlanExpensivePricesDict:premiumPlanExpensivePricesDict premiumPlanPricesDiscountDict:premiumPlanPricesDiscountDict premiumPlanPricesNoFreeTrialDict:premiumPlanPricesNoFreeTrialDict currentViewController:self Superficial:NO];
        
    } else {
        
        NSDictionary *appIconDict = [[[GeneralObject alloc] init] GenerateAppIconNumberArray];
        NSArray *appIconStringNameArray = [[[GeneralObject alloc] init] GenerateAppIconImageNameOptionsArray];
        NSString *appIconImageName = appIconStringNameArray[indexPath.row];
        
        [[UIApplication sharedApplication] setAlternateIconName:appIconDict[appIconImageName] completionHandler:^(NSError * _Nullable error) {
            
            if (error == nil) {
                
                [[NSUserDefaults standardUserDefaults] setObject:optionSelected forKey:@"AppIconSelected"];
                [[NSUserDefaults standardUserDefaults] setObject:[[[GeneralObject alloc] init] GenerateAppIconColorNameOptionsArray][indexPath.row] forKey:@"AppIconSelectedReadableName"];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:
                 @"NSNotification_Settings_AppIcon" object:nil userInfo:@{}];
                
            }
            
        }];
        
    }
    
}

-(void)SelectAppTheme:(NSIndexPath *)indexPath {
    
    if ([[[BoolDataObject alloc] init] PremiumSubscriptionIsOn] == NO) {
        
        _itemsSelectedArray = [NSMutableArray array];
        
        [[[PushObject alloc] init] PushToWeDivvyPremiumViewController:YES comingFromSignUp:NO defaultPlan:@"" displayDiscount:@"Half-Off Yearly Discount No Sale Sticker" selectedSlide:@"Custom App Themes" promoCodeID:@"" premiumPlanProductsArray:premiumPlanProductsArray premiumPlanPricesDict:premiumPlanPricesDict premiumPlanExpensivePricesDict:premiumPlanExpensivePricesDict premiumPlanPricesDiscountDict:premiumPlanPricesDiscountDict premiumPlanPricesNoFreeTrialDict:premiumPlanPricesNoFreeTrialDict currentViewController:self Superficial:NO];
        
    } else {
        
        //[[NSUserDefaults standardUserDefaults] setObject:self->optionsArray[indexPath.row] forKey:@"AppThemeSelected"];
        
    }
    
}

-(void)SelectLaunchPage:(NSIndexPath *)indexPath {
    
    if ([[[BoolDataObject alloc] init] PremiumSubscriptionIsOn] == NO) {
        
        _itemsSelectedArray = [NSMutableArray array];
        
        [[[PushObject alloc] init] PushToWeDivvyPremiumViewController:YES comingFromSignUp:NO defaultPlan:@"" displayDiscount:@"Half-Off Yearly Discount No Sale Sticker" selectedSlide:@"Default Launch Page" promoCodeID:@"" premiumPlanProductsArray:premiumPlanProductsArray premiumPlanPricesDict:premiumPlanPricesDict premiumPlanExpensivePricesDict:premiumPlanExpensivePricesDict premiumPlanPricesDiscountDict:premiumPlanPricesDiscountDict premiumPlanPricesNoFreeTrialDict:premiumPlanPricesNoFreeTrialDict currentViewController:self Superficial:NO];
        
    } else {
        
        [[NSUserDefaults standardUserDefaults] setObject:self->optionsArray[indexPath.row] forKey:@"LaunchPageSelected"];
        
    }
    
}

-(void)SelectDays:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    
    NSString *objectToAdd = tableView == _additionalOptionsTableView ? additionalOptionsArray[indexPath.row] : optionsArray[indexPath.row];
    
    if ([_itemsSelectedArray containsObject:objectToAdd]) {
        
        [_itemsSelectedArray removeObject:objectToAdd];
        
    } else {
        
        [_itemsSelectedArray addObject:objectToAdd];
        
    }
    
    if ([_itemsSelectedArray count] > 0) {
        
        [_anyDaySwitch setOn:NO];
        
    }
    
}

-(void)SelectShortcutItems:(NSIndexPath *)indexPath {
    
    NSString *objectToAdd = optionsArray[indexPath.row];
    
    if ([_itemsSelectedArray count] < 4) {
        
        if ([_itemsSelectedArray containsObject:objectToAdd]) {
            
            [_itemsSelectedArray removeObject:objectToAdd];
            
        } else {
            
            [_itemsSelectedArray addObject:objectToAdd];
            
        }
        
    } else if ([_itemsSelectedArray count] == 4) {
        
        if ([_itemsSelectedArray containsObject:objectToAdd]) {
            
            [_itemsSelectedArray removeObject:objectToAdd];
            
        } else {
            
            [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You can only select 4 shortcuts" currentViewController:self];
            
        }
        
    }
    
}

-(void)SelectColor:(NSIndexPath *)indexPath {
    
    BOOL ColorIsPremium = [self ColorIsPremium:optionsArray[indexPath.row]];
    
    if (ColorIsPremium == YES) {
        
        if ([[[BoolDataObject alloc] init] PremiumSubscriptionIsOn] == NO) {
            
            _itemsSelectedArray = [NSMutableArray array];
            
            [[[PushObject alloc] init] PushToWeDivvyPremiumViewController:YES comingFromSignUp:NO defaultPlan:@"" displayDiscount:@"Half-Off Yearly Discount No Sale Sticker" selectedSlide:@"Additional Task Colors" promoCodeID:@"" premiumPlanProductsArray:premiumPlanProductsArray premiumPlanPricesDict:premiumPlanPricesDict premiumPlanExpensivePricesDict:premiumPlanExpensivePricesDict premiumPlanPricesDiscountDict:premiumPlanPricesDiscountDict premiumPlanPricesNoFreeTrialDict:premiumPlanPricesNoFreeTrialDict currentViewController:self Superficial:NO];
            
        }
        
    }
    
}

-(void)SelectTabBar:(NSIndexPath *)indexPath {
    
    NSString *objectToAdd = optionsArray[indexPath.row];
    
    if ([_itemsSelectedArray containsObject:objectToAdd]) {
        
        if (_itemsSelectedArray.count == 1) {
            
            [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You must have at least one tab" currentViewController:self];
            
        } else {
            
            [_itemsSelectedArray removeObject:objectToAdd];
            
        }
        
    } else {
        
        [_itemsSelectedArray addObject:objectToAdd];
        
    }
    
}

@end
