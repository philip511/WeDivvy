//
//  AddItemViewController.m
//  RoommateApp
//
//  Created by Philip Nagel on 5/17/21.
//

#import "AddTaskViewController.h"
#import "AppDelegate.h"

#import <Photos/Photos.h>
#import <SDWebImage/SDWebImage.h>
#import <Mixpanel/Mixpanel.h>
#import <MRProgressOverlayView.h>

#import "GeneralObject.h"
#import "GetDataObject.h"
#import "SetDataObject.h"
#import "DeleteDataObject.h"
#import "PushObject.h"
#import "NotificationsObject.h"
#import "BoolDataObject.h"
#import "LightDarkModeObject.h"

@interface AddTaskViewController () {
    
    MRProgressOverlayView *progressView;
    
    NSMutableArray *assignedToIDArray;
    NSMutableArray *assignedToUsernameArray;
    NSMutableArray *assignedToProfileImageArray;
    
    NSMutableDictionary *itemCompletedDict;
    NSMutableDictionary *itemInProgressDict;
    NSMutableDictionary *itemWontDoDict;
    
    NSMutableDictionary *userDictForHomeMembers;
    
    NSMutableArray *frequencyHourArray;
    NSMutableArray *frequencyMinuteArray;
    NSMutableArray *frequencyAMPMArray;
    
    NSMutableArray *frequencyCompletedByOnlyArray;
    NSMutableArray *frequencyCompletedByAmountArray;
    
    NSMutableArray *frequencyGracePeriodAmountArray;
    NSMutableArray *frequencyGracePeriodFrequencyArray;
    
    NSMutableArray *frequencySelfDestructAmountArray;
    NSMutableArray *frequencySelfDestructFrequencyArray;
    
    NSMutableArray *frequencyEstimatedTimeAmountArray;
    NSMutableArray *frequencyEstimatedTimeFrequencyArray;
    
    NSString *selectedScheduledStart;
    NSString *selectedTemplate;
    NSString *selectedDraft;
    
    NSString *hourComp;
    NSString *minuteComp;
    NSString *AMPMComp;
    
    NSString *completedByOnlyComp;
    NSString *completedByAmountComp;
    
    NSString *gracePeriodAmountComp;
    NSString *gracePeriodFrequencyComp;
    
    NSString *selfDestructAmountComp;
    NSString *selfDestructFrequencyComp;
    
    NSString *estimatedTimeAmountComp;
    NSString *estimatedTimeFrequencyComp;
    
    NSMutableArray *itemSpecificDueDatesArray;
    NSMutableArray *itemDueDatesSkippedArray;
    NSMutableArray *itemTagsArrays;
    NSArray *keyArray;
    
    NSMutableDictionary *itemListItemsDict;
    NSMutableDictionary *itemSubTasksDict;
    NSMutableDictionary *itemReminderDict;
    NSMutableDictionary *itemCostPerPersonDict;
    NSMutableDictionary *itemPaymentMethodDict;
    NSMutableDictionary *itemRewardDict;
    NSMutableDictionary *itemItemizedItemsDict;
    NSMutableDictionary *itemApprovalRequestsDict;
    
    NSString *oldTaskList;
    
    NSString *chosenItemUniqueID;
    NSString *chosenItemID;
    NSString *chosenItemOccurrenceID;
    NSString *chosenItemDatePosted;
    NSString *chosenItemAssignedToAnybody;
    NSString *chosenItemAssignedToNewHomeMembers;
    NSString *chosenItemRepeats;
    NSString *chosenItemRepeatIfCompletedEarly;
    NSString *chosenItemAlternateTurns;
    UIImage *chosenItemImage;
    
    NSString *chosenItemGracePeriod;
    NSString *chosenItemPastDue;
    
    NSString *chosenItemColor;
    NSString *chosenItemPriority;
    NSString *chosenItemDifficulty;
    
    NSString *chosenItemPrivate;
    NSString *chosenItemApprovalNeeded;
    
    
    NSString *itemType;
    NSString *itemTypeCollection;
    
    NSString *localCurrencySymbol;
    NSString *localCurrencyDecimalSeparatorSymbol;
    NSString *localCurrencyNumberSeparatorSymbol;
    
    int completedQueries;
    int totalQueries;
    
    BOOL DataChanged;
    
    BOOL BoldTurnedOn;
    BOOL ItalicTurnedOn;
    BOOL UnderlinedTurnedOn;
    
    UIColor *defaultFieldColor;
    
    UIView *itemAssignedToView;
    UIImageView *itemAssignedToImage;
    UILabel *itemAssignedToLabel;
    UITextField *itemAssignedToTextField;
    UIImageView *itemAssignedToRightArrowImage;
    
    UIView *itemRepeatsView;
    UIImageView *itemRepeatsImage;
    UILabel *itemRepeatsLabel;
    UITextField *itemRepeatsTextField;
    UIButton *itemRepeatsTextFieldOverlay;
    
    UIView *itemDueDateView;
    UIImageView *itemDueDateImage;
    UILabel *itemDueDateLabel;
    UITextField *itemDueDateTextField;
    UIButton *itemDueDateTextFieldOverlay;
    
    UIView *itemRepeatIfCompletedEarlyView;
    UIImageView *itemRepeatIfCompletedEarlyImage;
    UILabel *itemRepeatIfCompletedEarlyLabel;
    UISwitch *itemRepeatIfCompletedEarlySwitch;
    
    UIView *itemStartDateView;
    UIImageView *itemStartDateImage;
    UILabel *itemStartDateLabel;
    UIImageView *itemStartDateInfoImage;
    UITextField *itemStartDateTextField;
    
    UIView *itemEndDateView;
    UIImageView *itemEndDateImage;
    UILabel *itemEndDateLabel;
    UITextField *itemEndDateTextField;
    UIButton *itemEndDateTextFieldOverlay;
    
    UIView *itemMustCompleteView;
    UILabel *itemMustCompleteLabel;
    UITextField *itemMustCompleteTextField;
    
    UIView *itemCostPerPersonView;
    UIImageView *itemCostPerPersonImage;
    UILabel *itemCostPerPersonLabel;
    UITextField *itemCostPerPersonTextField;
    UIImageView *itemCostPerPersonRightArrowImage;
    
    UIView *itemPaymentMethodView;
    UIImageView *itemPaymentMethodImage;
    UILabel *itemPaymentMethodLabel;
    UITextField *itemPaymentMethodTextField;
    UIImageView *itemPaymentMethodRightArrowImage;
    
    UIView *itemAmountView;
    UIImageView *itemAmountImage;
    UILabel *itemAmountLabel;
    UITextField *itemAmountTextField;
    UIImageView *itemAmountRightArrowImage;
    
    UIView *itemSubTasksView;
    UIImageView *itemSubTasksImage;
    UILabel *itemSubTasksLabel;
    UITextField *itemSubTasksTextField;
    UIImageView *itemSubTasksRightArrowImage;
    
    UIView *itemReminderView;
    UIImageView *itemReminderImage;
    UILabel *itemReminderLabel;
    UITextField *itemReminderTextField;
    UIImageView *itemRemindersRightArrowImage;
    
    UIView *itemListItemsView;
    UIImageView *itemListItemsImage;
    UILabel *itemListItemsLabel;
    UITextField *itemListItemsTextField;
    UIImageView *itemListItemsRightArrowImage;
    
    UIView *itemMoreOptionsView;
    UIImageView *itemMoreOptionsImage;
    UILabel *itemMoreOptionsLabel;
    UITextField *itemMoreOptionsTextField;
    UIImageView *itemMoreOptionsRightArrowImage;
    
    UIView *itemApprovalNeededView;
    UIImageView *itemApprovalNeededImage;
    UILabel *itemApprovalNeededLabel;
    UITextField *itemApprovalNeededTextField;
    UISwitch *itemApprovalNeededSwitch;
    UIImageView *itemApprovalNeededInfoImage;
    UIImageView *itemApprovalNeededPremiumImage;
    
    UIView *itemTurnOrderView;
    UILabel *itemTurnOrderLabel;
    UITextField *itemTurnOrderTextField;
    UIImageView *itemTurnOrderRightArrowImage;
    
    UIView *itemDifficultyView;
    UIImageView *itemDifficultyImage;
    UILabel *itemDifficultyLabel;
    UITextField *itemDifficultyTextField;
    UIButton *itemDifficultyTextFieldOverlay;
    UIImageView *itemDifficultyRightArrowImage;
    
    UIView *itemPriorityView;
    UIImageView *itemPriorityImage;
    UILabel *itemPriorityLabel;
    UITextField *itemPriorityTextField;
    UIButton *itemPriorityTextFieldOverlay;
    UIImageView *itemPriorityRightArrowImage;
    
    UIView *itemColorView;
    UIImageView *itemColorImage;
    UILabel *itemColorLabel;
    UIImageView *itemColorRightArrowImage;
    UIView *itemColorSelectedView;
    
    UIView *itemNameView;
    UITextField *itemNameTextField;
    
    UIView *itemEveryoneTakesTurnsView;
    UIImageView *itemEveryoneTakesTurnsImage;
    UILabel *itemEveryoneTakesTurnsLabel;
    UISwitch *itemEveryoneTakesTurnsSwitch;
    
    UIView *itemAlternateTurnsView;
    UILabel *itemAlternateTurnsLabel;
    UITextField *itemAlternateTurnsTextField;
    UIButton *itemAlternateTurnsTextFieldOverlay;
    
    UIView *itemDaysView;
    UIImageView *itemDaysImage;
    UILabel *itemDaysLabel;
    UITextField *itemDaysTextField;
    UIImageView *itemDaysRightArrowImage;
    
    UIView *itemTimeView;
    UIImageView *itemTimeImage;
    UILabel *itemTimeLabel;
    UITextField *itemTimeTextField;
    
    UIView *itemGracePeriodView;
    UIImageView *itemGracePeriodImage;
    UILabel *itemGracePeriodLabel;
    UITextField *itemGracePeriodTextField;
    UIImageView *itemGracePeriodInfoImage;
    
    UIView *itemPrivateView;
    UIImageView *itemPrivateImage;
    UILabel *itemPrivateLabel;
    UISwitch *itemPrivateSwitch;
    UIImageView *itemPrivatePremiumImage;
    
    UIView *itemRewardView;
    UIImageView *itemRewardImage;
    UILabel *itemRewardLabel;
    UITextField *itemRewardTextField;
    UIImageView *itemRewardRightArrowImage;
    
    UIView *itemPastDueView;
    UIImageView *itemPastDueImage;
    UILabel *itemPastDueLabel;
    UITextField *itemPastDueTextField;
    UIButton *itemPastDueTextFieldOverlay;
    UIImageView *itemPastDueInfoImage;
    
    UIView *itemTagsView;
    UIImageView *itemTagsImage;
    UILabel *itemTagsLabel;
    UITextField *itemTagsTextField;
    UIImageView *itemTagsRightArrowImage;
    
    UIView *itemNotesView;
    UITextView *itemNotesTextField;
    
    UIView *itemAddImageView;
    UIImageView *addImageImage;
    UIButton *itemAddImageLabel;
    UIButton *addPhotoViewOverlay;
    
    UIButton *deleteButton;
    
    UIView *topView;
    UIButton *topViewCover;
    UILabel *topViewLabel;
    UIImageView *topViewImageView;
    
    UIImageView *notesTextOptionsPremiumImage;
    UIImageView *boldTextImage;
    UIImageView *italicTextImage;
    UIImageView *underlineTextImage;
    UIImageView *fontImage;
    UIImageView *fontSizeImage;
    UIImageView *textColorImage;
    UIImageView *backgroundColorImage;
    UIImageView *highlightImage;
    UIImageView *linkImage;
    
    UIButton *fontImageButton;
    UIButton *fontSizeImageButton;
    UIButton *textColorImageButton;
    UIButton *backgroundColorImageButton;
    
    NSString *fontChosen;
    NSString *fontSizehosen;
    NSString *textColorChosen;
    NSString *backgroundColorChosen;
    
    NSMutableDictionary *premiumPlanPricesDict;
    NSMutableDictionary *premiumPlanExpensivePricesDict;
    NSMutableDictionary *premiumPlanPricesDiscountDict;
    NSMutableDictionary *premiumPlanPricesNoFreeTrialDict;
    NSMutableArray *premiumPlanProductsArray;
    
    UIView *newUserInfoView;
    UIView *tapView;
    
}

@end

@implementation AddTaskViewController

#pragma mark - System Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self FetchAvailableProducts];
        
    });
    
    _toolbarView.hidden = NO;
    
    chosenItemRepeatIfCompletedEarly = chosenItemRepeatIfCompletedEarly ? chosenItemRepeatIfCompletedEarly : @"No";
    
    if (itemNameView == nil || itemNameView == NULL) {
        
        [self SetUpView];
        
    }
    
    [self BarButtonItems];
    
    [self NSNotificationObservers:NO];
    
    [self InitialUserData];
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    topView.hidden = _viewingTemplate || _viewingDraft ? YES : NO;
    topViewCover.hidden = _viewingTemplate || _viewingDraft ? YES : NO;
    
    //    templateView.hidden = _multiAddTasks || _viewingTemplate || _viewingDraft ? YES : NO;
    //    templateViewCover.hidden = _multiAddTasks || _viewingTemplate || _viewingDraft ? YES : NO;
    
}

-(void)viewWillDisappear:(BOOL)animated {
    
    topView.hidden = YES;
    topViewCover.hidden = YES;
    
    //    templateView.hidden = YES;
    //    templateViewCover.hidden = YES;
    
    [self DismissAllKeyboards:NO];
    
}

-(void)viewDidLayoutSubviews {
    
    if (itemNameView == nil || itemNameView == NULL) {
        
        [self SetUpView];
        
    }
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        return UIStatusBarStyleLightContent;
        
    } else {
        
        return UIStatusBarStyleDefault;
        
    }
    
}

-(BOOL)prefersStatusBarHidden {
    
    return YES;
}

#pragma mark - Text View Methods

-(void)textViewDidChange:(UITextView *)textView
{
    
    if (itemNotesTextField.text.length == 0) {
        
        itemNotesTextField.textColor = [UIColor colorWithRed:181.0f/255.0f green:188.0f/255.0f blue:193.0f/255.0f alpha:1.0f];
        itemNotesTextField.text = @"Notes";
        [itemNotesTextField resignFirstResponder];
        
    }
    
    [self AdjustTextFieldFramesToUse:0.25];
    
}

-(void)textViewDidBeginEditing:(UITextView *)textView {
    
    [self KeyBoardToolBar:NO
                StartDate:NO
                  EndDate:NO
                     Time:NO
               Difficulty:NO
                 Priority:NO
                 Reminder:NO
                   Amount:NO
              CompletedBy:NO
              GracePeriod:NO
                   Reward:NO
                    Notes:YES
                     Name:NO];
    
    if (itemNotesTextField.text.length == 0 || [itemNotesTextField.text isEqualToString:@"Notes"] == YES) {
        
        itemNotesTextField.text = @"";
        itemNotesTextField.textColor = [UIColor colorWithRed:138.0f/255.0f green:137.0f/255.0f blue:142.0f/255.0f alpha:1.0f];
        
    }
    
    [self AdjustTextFieldFramesToUse:0.25];
    
}

-(void)textViewDidEndEditing:(UITextView *)textView {
    
    if (itemNotesTextField.text.length == 0) {
        
        itemNotesTextField.textColor = [UIColor colorWithRed:181.0f/255.0f green:188.0f/255.0f blue:193.0f/255.0f alpha:1.0f];
        itemNotesTextField.text = @"Notes";
        [itemNotesTextField resignFirstResponder];
        
    }
    
    [self AdjustTextFieldFramesToUse:0.25];
    
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    
    [self KeyBoardToolBar:NO
                StartDate:NO
                  EndDate:NO
                     Time:NO
               Difficulty:NO
                 Priority:NO
                 Reminder:NO
                   Amount:NO
              CompletedBy:NO
              GracePeriod:NO
                   Reward:NO
                    Notes:YES
                     Name:NO];
    
    [self AdjustTextFieldFramesToUse:0.25];
    
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)replacementText {
    
    if (itemNotesTextField.text.length > 0 && [itemNotesTextField.text isEqualToString:@"Notes"] == NO) {
        
        itemNotesTextField.textColor = [UIColor colorWithRed:138.0f/255.0f green:137.0f/255.0f blue:142.0f/255.0f alpha:1.0f];
        
    } else {
        
        itemNotesTextField.textColor = [UIColor colorWithRed:181.0f/255.0f green:188.0f/255.0f blue:193.0f/255.0f alpha:1.0f];
        
    }
    
    if ([textView.text isEqualToString:@"Notes"]) {
        
        NSString *str = [NSString stringWithFormat:@"%@%@", textView.text, replacementText];
        str = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:str arrayOfSymbols:@[@"Notes"]];
        textView.text = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:textView.text arrayOfSymbols:@[@"Notes"]];
        itemNotesTextField.textColor = [UIColor colorWithRed:138.0f/255.0f green:137.0f/255.0f blue:142.0f/255.0f alpha:1.0f];
        
    }
    
    [self AdjustTextFieldFramesToUse:0.25];
    
    [self BarButtonItems];
    
    return YES;
}

#pragma mark - Scroll View Methods

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self DismissAllKeyboards:YES];
    
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

#pragma mark - Image Picker Methods

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self->progressView setHidden:YES];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    addImageImage.image = image;
    
    if (addImageImage.image == nil) {
        
        addImageImage.hidden = YES;
        [self->progressView setHidden:YES];
        
    } else {
        
        addImageImage.hidden = NO;
        [self->progressView setHidden:YES];
        
    }
    
    [self BarButtonItems];
    
}

#pragma mark - Text Field Methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self DismissAllKeyboards:NO];
    
    return YES;
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    
    [self KeyBoardToolBar:[itemDueDateTextField isFirstResponder] ? YES : NO
                StartDate:[itemStartDateTextField isFirstResponder] ? YES : NO
                  EndDate:[itemEndDateTextField isFirstResponder] ? YES : NO
                     Time:[itemTimeTextField isFirstResponder] ? YES : NO
               Difficulty:[itemDifficultyTextField isFirstResponder] ? YES : NO
                 Priority:[itemPriorityTextField isFirstResponder] ? YES : NO
                 Reminder:[itemReminderTextField isFirstResponder] ? YES : NO
                   Amount:[itemAmountTextField isFirstResponder] ? YES : NO
              CompletedBy:[itemMustCompleteTextField isFirstResponder] ? YES : NO
              GracePeriod:[itemGracePeriodTextField isFirstResponder] ? YES : NO
                   Reward:[itemRewardTextField isFirstResponder] ? YES : NO
                    Notes:[itemNotesTextField isFirstResponder] ? YES : NO
                     Name:[itemNameTextField isFirstResponder] ? YES : NO];
    
    [self SelectRowForCompAndArrays:
     @[@{@"Array" : self->frequencyGracePeriodAmountArray, @"Comp" : self->gracePeriodAmountComp},
       @{@"Array" : self->frequencyGracePeriodFrequencyArray, @"Comp" : self->gracePeriodFrequencyComp}]
                          textField:itemGracePeriodTextField];
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if ([itemNameTextField isFirstResponder]) {
        
        [self KeyBoardToolBar:NO
                    StartDate:NO
                      EndDate:NO
                         Time:NO
                   Difficulty:NO
                     Priority:NO
                     Reminder:NO
                       Amount:NO
                  CompletedBy:NO
                  GracePeriod:NO
                       Reward:NO
                        Notes:NO
                         Name:[itemNameTextField isFirstResponder] ? YES : NO];
        
    }
    
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    DataChanged = textField.text.length > 0;
    
    if (textField == itemNameTextField && [NSString stringWithFormat:@"%@%@", textField.text, string].length != 0) {
        
        itemNameView.backgroundColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTertiary] : [[[LightDarkModeObject alloc] init] LightModeSecondary];
        
        [self BarButtonItems];
        
        return YES;
        
    } else if (textField == itemAmountTextField) {
        
        if ([[itemItemizedItemsDict allKeys] count] > 0) {
            
            UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Itemized Expenses Created"
                                                                                message:@"Would you like to delete all of your itemized expenses?"
                                                                         preferredStyle:UIAlertControllerStyleAlert];
            
            
            UIAlertAction *gotit = [UIAlertAction actionWithTitle:@"Sure"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * _Nonnull action) {
                
                self->itemItemizedItemsDict = [NSMutableDictionary dictionary];
                
                NSString *itemAmountString = [NSString stringWithFormat:@"%@", self->itemAmountTextField.text];
                
                itemAmountString = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:itemAmountString arrayOfSymbols:@[self->localCurrencyNumberSeparatorSymbol, self->localCurrencyDecimalSeparatorSymbol, self->localCurrencySymbol]];
                
                self->itemAmountTextField.text = [[[GeneralObject alloc] init] GenerateAmountInTextFieldInProperFormat:NSRangeFromString(itemAmountString) replacementString:itemAmountString];
                
                [self FormatAmountTextField:textField shouldChangeCharactersInRange:range replacementString:string];
                
                [self BarButtonItems];
                
            }];
            
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Nevermind"
                                                             style:UIAlertActionStyleCancel
                                                           handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [controller addAction:cancel];
            [controller addAction:gotit];
            [self presentViewController:controller animated:YES completion:nil];
            
        } else {
            
            [self BarButtonItems];
            
            return [self FormatAmountTextField:textField shouldChangeCharactersInRange:range replacementString:string];
            
        }
        
    } else {
        
        [self BarButtonItems];
        
        return YES;
        
    }
    
    return NO;
    
}

-(BOOL)FormatAmountTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    textField.text = [[[GeneralObject alloc] init] FormatAmountTextField:textField.text replacementString:string];
    
    [self GenerateCostPerPersonTextFieldText:[NSMutableDictionary dictionary]];
    
    itemAmountView.backgroundColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTertiary] : [[[LightDarkModeObject alloc] init] LightModeSecondary];
    
    return NO;
    
}

#pragma mark - Picker View Methods

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    NSInteger the_tag = [pickerView tag];
    
    if (the_tag == 2) {
        
        if (component == 0) {
            
            return [frequencyHourArray count];
            
        } else if (component == 1) {
            
            return [frequencyMinuteArray count];
            
        } else if (component == 2) {
            
            return [frequencyAMPMArray count];
            
        }
        
    } else if (the_tag == 4) {
        
        if (component == 0) {
            
            return [frequencyCompletedByOnlyArray count];
            
        } else if (component == 1) {
            
            return [frequencyCompletedByAmountArray count];
            
        } else if (component == 2) {
            
            return 1;
            
        }
        
    } else if (the_tag == 6) {
        
        if (component == 0) {
            
            return [frequencyGracePeriodAmountArray count];
            
        } else if (component == 1) {
            
            return [frequencyGracePeriodFrequencyArray count];
            
        } else if (component == 2) {
            
            return 1;
            
        }
        
    } else if (the_tag == 7) {
        
        if (component == 0) {
            
            return [frequencySelfDestructAmountArray count];
            
        } else if (component == 1) {
            
            return [frequencySelfDestructFrequencyArray count];
            
        }
        
    } else if (the_tag == 8) {
        
        if (component == 0) {
            
            return [frequencyEstimatedTimeAmountArray count];
            
        } else if (component == 1) {
            
            return [frequencyEstimatedTimeFrequencyArray count];
            
        }
        
    }
    
    return 0;
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    NSInteger the_tag = [pickerView tag];
    
    if (the_tag == 2) {
        
        if (component == 0) {
            
            return [frequencyHourArray objectAtIndex:row];
            
        } else if (component == 1) {
            
            return [frequencyMinuteArray objectAtIndex:row];
            
        } else if (component == 2) {
            
            return [frequencyAMPMArray objectAtIndex:row];
            
        }
        
    } else if (the_tag == 4) {
        
        if (component == 0) {
            
            return [frequencyCompletedByOnlyArray objectAtIndex:row];
            
        } else if (component == 1) {
            
            return [frequencyCompletedByAmountArray objectAtIndex:row];
            
        } else if (component == 2) {
            
            NSArray *arrayToUse;
            
            if ([completedByAmountComp isEqualToString:@"1"] == NO && completedByAmountComp != NULL && [completedByAmountComp length] > 0) {
                
                arrayToUse = @[@"People"];
                
            } else {
                
                arrayToUse = @[@"Person"];
                
            }
            
            return [arrayToUse objectAtIndex:row];
            
        }
        
    } else if (the_tag == 6) {
        
        if (component == 0) {
            
            return [frequencyGracePeriodAmountArray objectAtIndex:row];
            
        } else if (component == 1) {
            
            NSArray *arrayToUse;
            
            if ([gracePeriodAmountComp intValue] == 1 || gracePeriodAmountComp == NULL) {
                
                arrayToUse = @[@"Minute", @"Hour", @"Day", @"Week"];
                
            } else {
                
                arrayToUse = @[@"Minutes", @"Hours", @"Days", @"Weeks"];
                
            }
            
            return [arrayToUse objectAtIndex:row];
        }
        
    } else if (the_tag == 7) {
        
        if (component == 0) {
            
            return [frequencySelfDestructAmountArray objectAtIndex:row];
            
        } else if (component == 1) {
            
            NSArray *arrayToUse;
            
            if ([selfDestructAmountComp intValue] == 1 || selfDestructAmountComp == NULL) {
                
                arrayToUse = @[@"Minute", @"Hour", @"Day", @"Week", @"Month", @"Year"];
                
            } else {
                
                arrayToUse = @[@"Minutes", @"Hours", @"Days", @"Weeks", @"Months", @"Years"];
                
            }
            
            return [arrayToUse objectAtIndex:row];
            
        }
        
    } else if (the_tag == 8) {
        
        if (component == 0) {
            
            return [frequencyEstimatedTimeAmountArray objectAtIndex:row];
            
        } else if (component == 1) {
            
            NSArray *arrayToUse;
            
            if ([estimatedTimeAmountComp intValue] == 1 || estimatedTimeAmountComp == NULL) {
                
                arrayToUse = @[@"Minute", @"Hour", @"Day", @"Week", @"Month", @"Year"];
                
            } else {
                
                arrayToUse = @[@"Minutes", @"Hours", @"Days", @"Weeks", @"Months", @"Years"];
                
            }
            
            return [arrayToUse objectAtIndex:row];
            
        }
        
    }
    
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    NSInteger the_tag = [pickerView tag];
    
    if (the_tag == 2) {
        
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
        
        DataChanged = YES;
        
        itemTimeTextField.text = [NSString stringWithFormat:@"%@:%@ %@", hourComp, minuteComp, AMPMComp];
        
        itemReminderDict = [[self GenerateItemReminder:itemDueDateTextField.text itemRepeats:itemRepeatsTextField.text itemTime:itemTimeTextField.text SettingData:NO] mutableCopy];
        itemReminderTextField.text = [NSString stringWithFormat:@"%lu", (unsigned long)[[itemReminderDict allKeys] count]];
        
        [self BarButtonItems];
        
    } else if (the_tag == 4) {
        
        if (component == 0) {
            
            if ([frequencyCompletedByOnlyArray count] > row) {
                
                completedByOnlyComp = [frequencyCompletedByOnlyArray objectAtIndex:row];
                
            }
            
        } else if (component == 1) {
            
            if ([frequencyCompletedByAmountArray count] > row) {
                
                completedByAmountComp = [frequencyCompletedByAmountArray objectAtIndex:row];
                
            }
            
        }
        
        if (completedByOnlyComp == nil || completedByOnlyComp == NULL || completedByOnlyComp.length == 0 || [completedByOnlyComp containsString:@"(null)"]) {
            
            completedByOnlyComp = @"Only";
            
        }
        
        if (completedByAmountComp == nil || completedByAmountComp == NULL || completedByAmountComp.length == 0 || [completedByAmountComp containsString:@"(null)"]) {
            
            completedByAmountComp = @"1";
            
        }
        
        NSString *defaultText = @"Person";
        
        if ([completedByAmountComp isEqualToString:@"1"] == NO && completedByAmountComp != NULL && [completedByAmountComp length] > 0) {
            
            defaultText = @"People";
            
        }
        
        [(UIPickerView *)itemMustCompleteTextField.inputView reloadAllComponents];
        
        if (completedByAmountComp.length > 0) {
            
            itemMustCompleteTextField.text = [NSString stringWithFormat:@"%@ %@ %@", completedByOnlyComp, completedByAmountComp, defaultText];
            
        } else {
            
            itemMustCompleteTextField.text = @"Everyone";
            completedByOnlyComp = @"";
            completedByAmountComp = @"";
            
        }
        
        [self BarButtonItems];
        
    } else if (the_tag == 6) {
        
        if (component == 0) {
            
            if ([frequencyGracePeriodAmountArray count] > row) {
                
                gracePeriodAmountComp = [frequencyGracePeriodAmountArray objectAtIndex:row];
                
            }
            
        } else if (component == 1) {
            
            NSArray *arrayToUse;
            
            if ([gracePeriodAmountComp intValue] == 1 || gracePeriodAmountComp == NULL || gracePeriodAmountComp == nil || gracePeriodAmountComp.length == 0 || [gracePeriodAmountComp containsString:@"(null)"]) {
                
                arrayToUse = @[@"Minute", @"Hour", @"Day", @"Week"];
                
            } else {
                
                arrayToUse = @[@"Minutes", @"Hours", @"Days", @"Weeks"];
                
            }
            
            if ([arrayToUse count] > row) {
                
                gracePeriodFrequencyComp = [arrayToUse objectAtIndex:row];
                
            }
            
        }
        
        if (gracePeriodAmountComp == nil || gracePeriodAmountComp == NULL || gracePeriodAmountComp.length == 0 || [gracePeriodAmountComp containsString:@"(null)"]) {
            gracePeriodAmountComp = @"1";
        }
        if (gracePeriodFrequencyComp == nil || gracePeriodFrequencyComp == NULL || gracePeriodFrequencyComp.length == 0 || [gracePeriodFrequencyComp containsString:@"(null)"]) {
            gracePeriodFrequencyComp = @"Minute";
        }
        
        [(UIPickerView *)itemGracePeriodTextField.inputView reloadAllComponents];
        
        if ([gracePeriodAmountComp isEqualToString:@"1"] && [gracePeriodFrequencyComp containsString:@"s"]) {
            
            gracePeriodFrequencyComp = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:gracePeriodFrequencyComp arrayOfSymbols:@[@"s"]];
            
        }
        
        itemGracePeriodTextField.text = [NSString stringWithFormat:@"%@ %@", gracePeriodAmountComp, gracePeriodFrequencyComp];
        
        [self BarButtonItems];
        
    }
    
    [self BarButtonItems];
    
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    NSInteger the_tag = [pickerView tag];
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    
    if (the_tag == 2) {
        
        if (component == 0) {
            return width*0.145;
        } else if (component == 1) {
            return width*0.145;
        } else if (component == 2) {
            return width*0.145;
        }
        
    } else if (the_tag == 3) {
        
        if (component == 0) {
            return width*0.25;
        } else if (component == 1) {
            return width*0.35;
        } else if (component == 2) {
            return width*0.25;
        }
        
    } else if (the_tag == 4) {
        
        if (component == 0) {
            return width*0.35;
        } else if (component == 1) {
            return width*0.15;
        } else if (component == 2) {
            return width*0.35;
        }
        
    } else if (the_tag == 5) {
        
        if (component == 0) {
            return width;
        }
        
    } else if (the_tag == 6) {
        
        if (component == 0) {
            return width*0.25;
        } else if (component == 1) {
            return width*0.35;
        }
        
    } else if (the_tag == 7) {
        
        if (component == 0) {
            return width*0.25;
        } else if (component == 1) {
            return width*0.35;
        }
        
    } else if (the_tag == 8) {
        
        if (component == 0) {
            return width*0.25;
        } else if (component == 1) {
            return width*0.35;
        }
        
    }
    
    return 0;
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    NSInteger the_tag = [pickerView tag];
    
    if (the_tag == 2) {
        return 3;
    } else if (the_tag == 3) {
        return 3;
    } else if (the_tag == 4) {
        return 3;
    } else if (the_tag == 5) {
        return 1;
    } else if (the_tag == 6) {
        return 2;
    } else if (the_tag == 7) {
        return 2;
    } else if (the_tag == 8) {
        return 2;
    }
    
    return 1;
}

#pragma mark - Keyboard Methods

- (void)keyboardWillShow: (NSNotification *) notification{
    
    //    if ([itemNotesTextField isFirstResponder]) {
    //
    //        [UIView animateWithDuration:0.25 animations:^{
    //
    //            CGFloat height = CGRectGetHeight(self.view.bounds);
    //            CGFloat bottomPadding = [[[GeneralObject alloc] init] GetBottomPaddingHeight];
    //            CGFloat textFieldSpacing = (height*0.024456);
    //
    //            NSDictionary* keyboardInfo = [notification userInfo];
    //            NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    //            CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    //
    //            CGFloat heightToUse = self->deleteButton.hidden == YES ? self->itemNotesView.frame.origin.y + self->itemNotesView.frame.size.height + textFieldSpacing : self->deleteButton.frame.origin.y + self->deleteButton.frame.size.height + textFieldSpacing;
    //
    //            if (heightToUse + bottomPadding + keyboardFrameBeginRect.size.height < self.view.frame.size.height) {
    //                heightToUse = self.customScrollView.frame.size.height + 1;
    //            }
    //
    //            CGFloat navigationBarHeight = [[[GeneralObject alloc] init] GetNavigationBarHeight:self];
    //
    //            self->_customScrollView.contentSize = CGSizeMake(self.view.frame.size.width, heightToUse + bottomPadding + keyboardFrameBeginRect.size.height + navigationBarHeight);
    //
    //            CGRect sendCoinsButton = self->_toolbarView.frame;
    //
    //            sendCoinsButton.origin.y = CGRectGetHeight(self.view.bounds)-keyboardFrameBeginRect.size.height-sendCoinsButton.size.height;
    //
    //            self->_toolbarView.frame = sendCoinsButton;
    //
    //        } completion:^(BOOL finished) {
    //
    //            [self->_customScrollView setContentOffset:CGPointMake(0, self.customScrollView.contentSize.height - self.customScrollView.bounds.size.height + self.customScrollView.contentInset.bottom) animated:YES];
    //
    //        }];
    //
    //    }
    
}

- (void)keyboardWillHide: (NSNotification *) notification{
    
    if ([itemNotesTextField isFirstResponder]) {
        
        [UIView animateWithDuration:0.25 animations:^{
            
            CGFloat height = CGRectGetHeight(self.view.bounds);
            CGFloat bottomPadding = [[[GeneralObject alloc] init] GetBottomPaddingHeight];
            CGFloat textFieldSpacing = (height*0.024456);
            
            CGFloat heightToUse = self->deleteButton.hidden == YES ? self->itemNotesView.frame.origin.y + self->itemNotesView.frame.size.height + textFieldSpacing : self->deleteButton.frame.origin.y + self->deleteButton.frame.size.height + textFieldSpacing;
            if (heightToUse + bottomPadding < self.view.frame.size.height) {
                heightToUse = self.view.frame.size.height + 1;
            }
            
            CGFloat navigationBarHeight = [[[GeneralObject alloc] init] GetNavigationBarHeight:self];
            
            self->_customScrollView.contentSize = CGSizeMake(self.view.frame.size.width, heightToUse + bottomPadding + navigationBarHeight);
            
            CGRect newRect = self->_toolbarView.frame;
            newRect.origin.y = height;
            self->_toolbarView.frame = newRect;
            
        } completion:^(BOOL finished) {
            
        }];
        
    }
    
}

#pragma mark - View Methods

-(void)SetUpView {
    
    [self SetUpDataUI];
    
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    CGFloat navigationBarHeight = [[[GeneralObject alloc] init] GetNavigationBarHeight:self];
    
    self->_customScrollView.frame = CGRectMake(0, navigationBarHeight, width*1, height*1 - navigationBarHeight);
    
    [self GenerateNewUserInfoView];
    
    itemAssignedToView = [[UIView alloc] init];
    itemAssignedToImage = [[UIImageView alloc] init];
    itemAssignedToLabel = [[UILabel alloc] init];
    itemAssignedToTextField = [[UITextField alloc] init];
    itemAssignedToRightArrowImage = [[UIImageView alloc] init];
    
    itemAssignedToTextField.textAlignment = NSTextAlignmentRight;
    itemAssignedToTextField.text = @"Myself";
    itemAssignedToImage.image = [UIImage imageNamed:@"AddItemIcon.AssignedToBox"];
    itemAssignedToLabel.text = @"Assigned To";
    itemAssignedToRightArrowImage.image = [UIImage imageNamed:@"AddItemIcon.TextFieldRightArrow.png"];
    
    itemRepeatsView = [[UIView alloc] init];
    itemRepeatsImage = [[UIImageView alloc] init];
    itemRepeatsLabel = [[UILabel alloc] init];
    itemRepeatsTextField = [[UITextField alloc] init];
    itemRepeatsTextFieldOverlay = [[UIButton alloc] init];
    
    itemRepeatsTextField.textAlignment = NSTextAlignmentRight;
    itemRepeatsImage.image = [UIImage imageNamed:@"AddItemIcon.RepeatBox"];
    itemRepeatsLabel.text = @"Repeats";
    
    itemDueDateView = [[UIView alloc] init];
    itemDueDateImage = [[UIImageView alloc] init];
    itemDueDateLabel = [[UILabel alloc] init];
    itemDueDateTextField = [[UITextField alloc] init];
    itemDueDateTextFieldOverlay = [[UIButton alloc] init];
    
    itemDueDateTextField.textAlignment = NSTextAlignmentRight;
    itemDueDateImage.image = [UIImage imageNamed:@"AddItemIcon.DueDateBox"];
    itemDueDateLabel.text = @"Due Date";
    
    itemRepeatIfCompletedEarlyView = [[UIView alloc] init];
    itemRepeatIfCompletedEarlyImage = [[UIImageView alloc] init];
    itemRepeatIfCompletedEarlyLabel = [[UILabel alloc] init];
    itemRepeatIfCompletedEarlySwitch = [[UISwitch alloc] init];
    
    [itemRepeatIfCompletedEarlySwitch addTarget:self action:@selector(RepeatIfCompletedEarlySwitchAction:) forControlEvents:UIControlEventAllTouchEvents];
    itemRepeatIfCompletedEarlySwitch.onTintColor = [[[GeneralObject alloc] init] GenerateAppColor:1.0f];
    itemRepeatIfCompletedEarlyImage.image = [UIImage imageNamed:@"AddItemIcon.TakeTurnsBox"];
    itemRepeatIfCompletedEarlyLabel.text = @"Repeat If Completed Early";
    
    itemStartDateView = [[UIView alloc] init];
    itemStartDateLabel = [[UILabel alloc] init];
    itemStartDateTextField = [[UITextField alloc] init];
    itemStartDateInfoImage = [[UIImageView alloc] init];
    
    itemStartDateTextField.textAlignment = NSTextAlignmentRight;
    itemStartDateLabel.text = @"Start";
    itemStartDateInfoImage.image = [UIImage imageNamed:@"AddItemIcon.InfoButton.png"];
    
    itemEndDateView = [[UIView alloc] init];
    itemEndDateLabel = [[UILabel alloc] init];
    itemEndDateTextField = [[UITextField alloc] init];
    itemEndDateTextFieldOverlay = [[UIButton alloc] init];
    
    itemEndDateTextField.textAlignment = NSTextAlignmentRight;
    itemEndDateLabel.text = @"End";
    
    itemMustCompleteView = [[UIView alloc] init];
    itemMustCompleteLabel = [[UILabel alloc] init];
    itemMustCompleteTextField = [[UITextField alloc] init];
    
    itemMustCompleteTextField.textAlignment = NSTextAlignmentRight;
    itemMustCompleteLabel.text = @"Must Be Completed By";
    
    itemCostPerPersonView = [[UIView alloc] init];
    itemCostPerPersonImage = [[UIImageView alloc] init];
    itemCostPerPersonLabel = [[UILabel alloc] init];
    itemCostPerPersonTextField = [[UITextField alloc] init];
    itemCostPerPersonRightArrowImage = [[UIImageView alloc] init];
    
    itemCostPerPersonTextField.textAlignment = NSTextAlignmentRight;
    itemCostPerPersonImage.image = [UIImage imageNamed:@"AddItemIcon.CostPerPersonBox"];
    itemCostPerPersonLabel.text = @"Cost Per Person";
    itemCostPerPersonRightArrowImage.image = [UIImage imageNamed:@"AddItemIcon.TextFieldRightArrow.png"];
    
    itemPaymentMethodView = [[UIView alloc] init];
    itemPaymentMethodImage = [[UIImageView alloc] init];
    itemPaymentMethodLabel = [[UILabel alloc] init];
    itemPaymentMethodTextField = [[UITextField alloc] init];
    itemPaymentMethodRightArrowImage = [[UIImageView alloc] init];
    
    itemPaymentMethodTextField.textAlignment = NSTextAlignmentRight;
    itemPaymentMethodImage.image = [UIImage imageNamed:@"AddItemIcon.PaymentMethodBox"];
    itemPaymentMethodLabel.text = @"Payment Method";
    itemPaymentMethodRightArrowImage.image = [UIImage imageNamed:@"AddItemIcon.TextFieldRightArrow.png"];
    
    itemAmountView = [[UIView alloc] init];
    itemAmountImage = [[UIImageView alloc] init];
    itemAmountLabel = [[UILabel alloc] init];
    itemAmountTextField = [[UITextField alloc] init];
    itemAmountRightArrowImage = [[UIImageView alloc] init];
    
    itemAmountTextField.keyboardType = UIKeyboardTypeNumberPad;
    itemAmountTextField.textAlignment = NSTextAlignmentRight;
    itemAmountImage.image = [UIImage imageNamed:@"AddItemIcon.AmountBox"];
    itemAmountLabel.text = @"Amount";
    itemAmountRightArrowImage.image = [UIImage imageNamed:@"AddItemIcon.TextFieldRightArrow.png"];
    
    itemSubTasksView = [[UIView alloc] init];
    itemSubTasksImage = [[UIImageView alloc] init];
    itemSubTasksLabel = [[UILabel alloc] init];
    itemSubTasksTextField = [[UITextField alloc] init];
    itemSubTasksRightArrowImage = [[UIImageView alloc] init];
    
    itemSubTasksTextField.textAlignment = NSTextAlignmentRight;
    itemSubTasksImage.image = [UIImage imageNamed:@"AddItemIcon.SubtasksBox"];
    itemSubTasksLabel.text = @"Subtasks";
    itemSubTasksRightArrowImage.image = [UIImage imageNamed:@"AddItemIcon.TextFieldRightArrow.png"];
    
    itemReminderView = [[UIView alloc] init];
    itemReminderImage = [[UIImageView alloc] init];
    itemReminderLabel = [[UILabel alloc] init];
    itemReminderTextField = [[UITextField alloc] init];
    itemRemindersRightArrowImage = [[UIImageView alloc] init];
    
    itemReminderTextField.textAlignment = NSTextAlignmentRight;
    itemReminderImage.image = [UIImage imageNamed:@"AddItemIcon.ReminderBox"];
    itemReminderLabel.text = @"Reminders";
    itemRemindersRightArrowImage.image = [UIImage imageNamed:@"AddItemIcon.TextFieldRightArrow.png"];
    
    itemApprovalNeededView = [[UIView alloc] init];
    itemApprovalNeededImage = [[UIImageView alloc] init];
    itemApprovalNeededLabel = [[UILabel alloc] init];
    itemApprovalNeededTextField = [[UITextField alloc] init];
    itemApprovalNeededSwitch = [[UISwitch alloc] init];
    itemApprovalNeededInfoImage = [[UIImageView alloc] init];
    itemApprovalNeededPremiumImage = [[UIImageView alloc] init];
    
    [itemApprovalNeededSwitch addTarget:self action:@selector(ApprovalNeededSwitchAction:) forControlEvents:UIControlEventAllTouchEvents];
    itemApprovalNeededSwitch.onTintColor = [[[GeneralObject alloc] init] GenerateAppColor:1.0f];
    itemApprovalNeededTextField.textAlignment = NSTextAlignmentRight;
    itemApprovalNeededImage.image = [UIImage imageNamed:@"AddItemIcon.ApprovalNeededBox"];
    itemApprovalNeededLabel.text = @"Approval Needed";
    itemApprovalNeededInfoImage.image = [UIImage imageNamed:@"AddItemIcon.InfoButton.png"];
    itemApprovalNeededPremiumImage.image = nil;
    
    itemListItemsView = [[UIView alloc] init];
    itemListItemsImage = [[UIImageView alloc] init];
    itemListItemsLabel = [[UILabel alloc] init];
    itemListItemsTextField = [[UITextField alloc] init];
    itemListItemsRightArrowImage = [[UIImageView alloc] init];
    
    itemListItemsTextField.textAlignment = NSTextAlignmentRight;
    itemListItemsImage.image = [UIImage imageNamed:@"AddItemIcon.SubtasksBox"];
    itemListItemsLabel.text = @"List Items";
    itemListItemsRightArrowImage.image = [UIImage imageNamed:@"AddItemIcon.TextFieldRightArrow.png"];
    
    itemMoreOptionsView = [[UIView alloc] init];
    itemMoreOptionsImage = [[UIImageView alloc] init];
    itemMoreOptionsLabel = [[UILabel alloc] init];
    itemMoreOptionsTextField = [[UITextField alloc] init];
    itemMoreOptionsRightArrowImage = [[UIImageView alloc] init];
    
    itemMoreOptionsTextField.textAlignment = NSTextAlignmentRight;
    itemMoreOptionsImage.image = [UIImage imageNamed:@"AddItemIcon.MoreOptionsBox"];
    itemMoreOptionsLabel.text = @"More Options";
    itemMoreOptionsRightArrowImage.image = [UIImage imageNamed:@"AddItemIcon.TextFieldRightArrow.png"];
    
    itemTurnOrderView = [[UIView alloc] init];
    itemTurnOrderLabel = [[UILabel alloc] init];
    itemTurnOrderTextField = [[UITextField alloc] init];
    itemTurnOrderRightArrowImage = [[UIImageView alloc] init];
    
    itemTurnOrderTextField.textAlignment = NSTextAlignmentRight;
    itemTurnOrderTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"];
    itemTurnOrderLabel.text = @"Turn Order";
    itemTurnOrderRightArrowImage.image = [UIImage imageNamed:@"AddItemIcon.TextFieldRightArrow.png"];
    
    itemDifficultyView = [[UIView alloc] init];
    itemDifficultyImage = [[UIImageView alloc] init];
    itemDifficultyLabel = [[UILabel alloc] init];
    itemDifficultyTextField = [[UITextField alloc] init];
    itemDifficultyTextFieldOverlay = [[UIButton alloc] init];
    itemDifficultyRightArrowImage = [[UIImageView alloc] init];
    
    itemDifficultyTextField.textAlignment = NSTextAlignmentRight;
    itemDifficultyImage.image = [UIImage imageNamed:@"AddItemIcon.DifficultyBox"];
    itemDifficultyLabel.text = @"Difficulty";
    itemDifficultyRightArrowImage.image = [UIImage imageNamed:@"AddItemIcon.TextFieldRightArrow.png"];
    
    itemPriorityView = [[UIView alloc] init];
    itemPriorityImage = [[UIImageView alloc] init];
    itemPriorityLabel = [[UILabel alloc] init];
    itemPriorityTextField = [[UITextField alloc] init];
    itemPriorityTextFieldOverlay = [[UIButton alloc] init];
    itemPriorityRightArrowImage = [[UIImageView alloc] init];
    
    itemPriorityTextField.textAlignment = NSTextAlignmentRight;
    itemPriorityImage.image = [UIImage imageNamed:@"AddItemIcon.PriorityBox"];
    itemPriorityLabel.text = @"Priority";
    itemPriorityRightArrowImage.image = [UIImage imageNamed:@"AddItemIcon.TextFieldRightArrow.png"];
    
    itemColorView = [[UIView alloc] init];
    itemColorImage = [[UIImageView alloc] init];
    itemColorLabel = [[UILabel alloc] init];
    itemColorRightArrowImage = [[UIImageView alloc] init];
    itemColorSelectedView = [[UIView alloc] init];
    
    itemColorImage.image = [UIImage imageNamed:@"AddItemIcon.ColorBox"];
    itemColorLabel.text = @"Color";
    itemColorRightArrowImage.image = [UIImage imageNamed:@"AddItemIcon.TextFieldRightArrow.png"];
    
    itemNameView = [[UIView alloc] init];
    itemNameTextField = [[UITextField alloc] init];
    
    itemTimeView = [[UIView alloc] init];
    itemTimeImage = [[UIImageView alloc] init];
    itemTimeLabel = [[UILabel alloc] init];
    itemTimeTextField = [[UITextField alloc] init];
    
    itemTimeTextField.textAlignment = NSTextAlignmentRight;
    itemTimeImage.image = [UIImage imageNamed:@"AddItemIcon.TimeBox"];
    itemTimeLabel.text = @"Time";
    
    itemDaysView = [[UIView alloc] init];
    itemDaysImage = [[UIImageView alloc] init];
    itemDaysLabel = [[UILabel alloc] init];
    itemDaysTextField = [[UITextField alloc] init];
    itemDaysRightArrowImage = [[UIImageView alloc] init];
    
    itemDaysTextField.textAlignment = NSTextAlignmentRight;
    itemDaysImage.image = [UIImage imageNamed:@"AddItemIcon.DaysBox"];
    itemDaysLabel.text = @"Days";
    itemDaysRightArrowImage.image = [UIImage imageNamed:@"AddItemIcon.TextFieldRightArrow.png"];
    
    itemEveryoneTakesTurnsView = [[UIView alloc] init];
    itemEveryoneTakesTurnsImage = [[UIImageView alloc] init];
    itemEveryoneTakesTurnsLabel = [[UILabel alloc] init];
    itemEveryoneTakesTurnsSwitch = [[UISwitch alloc] init];
    
    [itemEveryoneTakesTurnsSwitch addTarget:self action:@selector(TakeTurnsSwitchAction:) forControlEvents:UIControlEventAllTouchEvents];
    itemEveryoneTakesTurnsSwitch.onTintColor = [[[GeneralObject alloc] init] GenerateAppColor:1.0f];
    itemEveryoneTakesTurnsImage.image = [UIImage imageNamed:@"AddItemIcon.TakeTurnsBox"];
    itemEveryoneTakesTurnsLabel.text = @"Take Turns";
    
    itemAlternateTurnsView = [[UIView alloc] init];
    itemAlternateTurnsLabel = [[UILabel alloc] init];
    itemAlternateTurnsTextField = [[UITextField alloc] init];
    itemAlternateTurnsTextFieldOverlay = [[UIButton alloc] init];
    
    itemAlternateTurnsTextField.textAlignment = NSTextAlignmentRight;
    itemAlternateTurnsLabel.text = @"Alternate Turns";
    
    itemGracePeriodView = [[UIView alloc] init];
    itemGracePeriodImage = [[UIImageView alloc] init];
    itemGracePeriodLabel = [[UILabel alloc] init];
    itemGracePeriodTextField = [[UITextField alloc] init];
    itemGracePeriodInfoImage = [[UIImageView alloc] init];
    
    itemGracePeriodTextField.textAlignment = NSTextAlignmentRight;
    itemGracePeriodImage.image = [UIImage imageNamed:@"AddItemIcon.GracePeriodBox"];
    itemGracePeriodLabel.text = @"Grace Period";
    itemGracePeriodInfoImage.image = [UIImage imageNamed:@"AddItemIcon.InfoButton.png"];
    
    itemPrivateView = [[UIView alloc] init];
    itemPrivateImage = [[UIImageView alloc] init];
    itemPrivateLabel = [[UILabel alloc] init];
    itemPrivateSwitch = [[UISwitch alloc] init];
    itemPrivatePremiumImage = [[UIImageView alloc] init];
    
    itemPrivateSwitch.onTintColor = [[[GeneralObject alloc] init] GenerateAppColor:1.0f];
    [itemPrivateSwitch addTarget:self action:@selector(PrivateSwitchAction:) forControlEvents:UIControlEventAllTouchEvents];
    itemPrivateImage.image = [UIImage imageNamed:@"AddItemIcon.PrivateBox"];
    itemPrivateLabel.text = @"Private";
    itemPrivatePremiumImage.image = nil;
    
    itemRewardView = [[UIView alloc] init];
    itemRewardImage = [[UIImageView alloc] init];
    itemRewardLabel = [[UILabel alloc] init];
    itemRewardTextField = [[UITextField alloc] init];
    itemRewardRightArrowImage = [[UIImageView alloc] init];
    
    itemRewardTextField.textAlignment = NSTextAlignmentRight;
    itemRewardImage.image = [UIImage imageNamed:@"AddItemIcon.RewardBox"];
    itemRewardLabel.text = @"Reward";
    itemRewardRightArrowImage.image = [UIImage imageNamed:@"AddItemIcon.TextFieldRightArrow.png"];
    
    itemPastDueView = [[UIView alloc] init];
    itemPastDueImage = [[UIImageView alloc] init];
    itemPastDueLabel = [[UILabel alloc] init];
    itemPastDueTextField = [[UITextField alloc] init];
    itemPastDueTextFieldOverlay = [[UIButton alloc] init];
    itemPastDueInfoImage = [[UIImageView alloc] init];
    
    itemPastDueTextField.textAlignment = NSTextAlignmentRight;
    itemPastDueImage.image = [UIImage imageNamed:@"AddItemIcon.PastDueBox"];
    itemPastDueLabel.text = @"Past Due Expires";
    itemPastDueInfoImage.image = [UIImage imageNamed:@"AddItemIcon.InfoButton.png"];
    
    itemTagsView = [[UIView alloc] init];
    itemTagsImage = [[UIImageView alloc] init];
    itemTagsLabel = [[UILabel alloc] init];
    itemTagsTextField = [[UITextField alloc] init];
    itemTagsRightArrowImage = [[UIImageView alloc] init];
    
    itemTagsTextField.textAlignment = NSTextAlignmentRight;
    itemTagsImage.image = [UIImage imageNamed:@"AddItemIcon.TagsBox"];
    itemTagsLabel.text = @"Tags";
    itemTagsRightArrowImage.image = [UIImage imageNamed:@"AddItemIcon.TextFieldRightArrow.png"];
    
    itemNotesView = [[UIView alloc] init];
    itemNotesTextField = [[UITextView alloc] init];
    
    itemAddImageView = [[UIView alloc] init];
    addImageImage = [[UIImageView alloc] init];
    itemAddImageLabel = [[UIButton alloc] init];
    
    [itemAddImageLabel setTitle:@"Add Image" forState:UIControlStateNormal];
    [itemAddImageLabel setTitleColor:[UIColor colorWithRed:0.0f/255.0f green:122.0f/255.0f blue:255.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    itemAddImageLabel.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    deleteButton = [[UIButton alloc] init];
    
    
    
    
    
    
    
    //    UIColor *unselectedBackgroundColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeSecondary] : [UIColor colorWithRed:238.0f/255.0f green:238.0f/255.0f blue:240.0f/255.0f alpha:1.0f];
    //    UIColor *unselectedTextColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTextSecondary] : [UIColor colorWithRed:129.0f/255.0f green:128.0f/255.0f blue:133.0f/255.0f alpha:1.0f];
    //
    //    templateViewLabelNo1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 100, (self.view.frame.size.height*0.04076 > 30?30:(self.view.frame.size.height*0.04076)))];
    //    templateViewLabelNo1.backgroundColor = [UIColor whiteColor];
    //    templateViewLabelNo1.layer.cornerRadius = templateViewLabelNo1.frame.size.height/3;
    //    templateViewLabelNo1.clipsToBounds = YES;
    //    templateViewLabelNo1.textColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTextSecondary] : [[[LightDarkModeObject alloc] init] LightModeTexAddTaskTextField];
    //    templateViewLabelNo1.textAlignment = NSTextAlignmentCenter;
    //    templateViewLabelNo1.text = [NSString stringWithFormat:@"No Template"];
    //    templateViewLabelNo1.font = [UIFont systemFontOfSize:(self.view.frame.size.height*0.04076 > 30?30:(self.view.frame.size.height*0.04076))*0.5 weight:UIFontWeightSemibold];
    //    [templateViewLabelNo1 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SelectTag:)]];
    //    templateViewLabelNo1.userInteractionEnabled = YES;
    //
    //    CGFloat cornerRadius = (self.view.frame.size.height*0.2181818182 > 12?12:(self.view.frame.size.height*0.2181818182));
    //    [[[GeneralObject alloc] init] RoundingCorners:templateViewNo1 topCorners:YES bottomCorners:YES cornerRadius:cornerRadius];
    //
    //    [self.customScrollView addSubview:templateViewLabelNo1];
    
    
    
    
    
    
    
    [deleteButton addTarget:self action:@selector(DeleteItem:) forControlEvents:UIControlEventAllTouchEvents];
    
    [self AdjustTextFieldFramesToUse:0];
    
    width = CGRectGetWidth(itemNameView.bounds);
    height = CGRectGetHeight(itemNameView.bounds);
    //342
    
    
    NSArray *rightArrowFrameArray = @[
        
        @{@"View" : itemAssignedToRightArrowImage},
        @{@"View" : itemCostPerPersonRightArrowImage},
        @{@"View" : itemAmountRightArrowImage},
        @{@"View" : itemPaymentMethodRightArrowImage},
        @{@"View" : itemSubTasksRightArrowImage},
        @{@"View" : itemRemindersRightArrowImage},
        @{@"View" : itemListItemsRightArrowImage},
        @{@"View" : itemMoreOptionsRightArrowImage},
        @{@"View" : itemTurnOrderRightArrowImage},
        @{@"View" : itemDifficultyRightArrowImage},
        @{@"View" : itemPriorityRightArrowImage},
        @{@"View" : itemColorRightArrowImage},
        @{@"View" : itemDaysRightArrowImage},
        @{@"View" : itemRewardRightArrowImage},
        @{@"View" : itemTagsRightArrowImage}
        
    ];
    
    [self RightArrowFrame:rightArrowFrameArray];
    
    NSArray *labelWithoutImageArray = @[
        
        @{@"View" : itemMustCompleteLabel, @"Width" : @"0.52631589"},
        @{@"View" : itemRepeatIfCompletedEarlyLabel, @"Width" : @"0.320"},
        @{@"View" : itemStartDateLabel, @"Width" : @"0.320"},
        @{@"View" : itemEndDateLabel, @"Width" : @"0.320"},
        @{@"View" : itemTurnOrderLabel, @"Width" : @"0.24853801"},
        @{@"View" : itemAlternateTurnsLabel, @"Width" : @"0.24853801"},
        
    ];
    
    [self LabelWithoutImage:labelWithoutImageArray];
    
    NSArray *labelWithImageArray = @[
        
        @{@"View" : itemListItemsLabel, @"Width" : @"0.21929825"},
        @{@"View" : itemSubTasksLabel, @"Width" : @"0.21929825"},
        @{@"View" : itemRepeatsLabel, @"Width" : @"0.1754386"},
        @{@"View" : itemDueDateLabel, @"Width" : @"0.175"},
        @{@"View" : itemGracePeriodLabel, @"Width" : @"0.25"},
        @{@"View" : itemDifficultyLabel, @"Width" : @"0.19005848"},
        @{@"View" : itemPriorityLabel, @"Width" : @"0.19005848"},
        @{@"View" : itemAssignedToLabel, @"Width" : @"0.25"},
        @{@"View" : itemDaysLabel, @"Width" : @"0.14619883"},
        @{@"View" : itemTimeLabel, @"Width" : @"0.14619883"},
        @{@"View" : itemEveryoneTakesTurnsLabel, @"Width" : @"0.49707602"},
        @{@"View" : itemAmountLabel, @"Width" : @"0.19005848"},
        @{@"View" : itemCostPerPersonLabel, @"Width" : @"0.38011696"},
        @{@"View" : itemColorLabel, @"Width" : @"0.94"},
        @{@"View" : itemReminderLabel, @"Width" : @"0.21929825"},
        @{@"View" : itemPrivateLabel, @"Width" : @"0.1754386"},
        @{@"View" : itemMoreOptionsLabel, @"Width" : @"0.5"},
        @{@"View" : itemPaymentMethodLabel, @"Width" : @"0.345"},
        @{@"View" : itemRewardLabel, @"Width" : @"0.15"},
        @{@"View" : itemApprovalNeededLabel, @"Width" : @"0.5"},
        @{@"View" : itemPastDueLabel, @"Width" : @"0.20"},
        @{@"View" : itemTagsLabel, @"Width" : @"0.20"}
        
    ];
    
    [self LabelWithImage:labelWithImageArray];
    
    NSArray *textFieldWithArrowArray = @[
        
        @{@"View" : itemListItemsTextField, @"Label" : itemListItemsLabel},
        @{@"View" : itemSubTasksTextField, @"Label" : itemSubTasksLabel},
        @{@"View" : itemReminderTextField, @"Label" : itemReminderLabel},
        @{@"View" : itemDifficultyTextField, @"Button" : itemDifficultyTextFieldOverlay, @"Label" : itemDifficultyLabel},
        @{@"View" : itemPriorityTextField, @"Button" : itemPriorityTextFieldOverlay, @"Label" : itemPriorityLabel},
        @{@"View" : itemAssignedToTextField, @"Label" : itemAssignedToLabel},
        @{@"View" : itemDaysTextField, @"Label" : itemDaysLabel},
        @{@"View" : itemCostPerPersonTextField, @"Label" : itemCostPerPersonLabel},
        @{@"View" : itemTurnOrderTextField, @"Label" : itemTurnOrderLabel},
        @{@"View" : itemPaymentMethodTextField, @"Label" : itemPaymentMethodLabel},
        @{@"View" : itemRewardTextField, @"Label" : itemRewardLabel},
        @{@"View" : itemEndDateTextField, @"Button" : itemEndDateTextFieldOverlay, @"Label" : itemEndDateLabel},
        @{@"View" : itemAlternateTurnsTextField, @"Button" : itemAlternateTurnsTextFieldOverlay, @"Label" : itemAlternateTurnsLabel},
        @{@"View" : itemTagsTextField, @"Label" : itemTagsLabel}
        
    ];
    
    [self TextFieldWithArrow:textFieldWithArrowArray];
    
    NSArray *textFieldWithoutArrowArray = @[
        
        @{@"TextField" : itemRepeatsTextField, @"Button" : itemRepeatsTextFieldOverlay, @"Label" : itemRepeatsLabel},
        @{@"TextField" : itemAlternateTurnsTextField, @"Label" : itemAlternateTurnsLabel},
        @{@"TextField" : itemMustCompleteTextField, @"Label" : itemMustCompleteLabel},
        @{@"TextField" : itemDueDateTextField, @"Button" : itemDueDateTextFieldOverlay, @"Label" : itemDueDateLabel},
        @{@"TextField" : itemTimeTextField, @"Label" : itemTimeLabel},
        @{@"TextField" : itemStartDateTextField, @"Label" : itemStartDateLabel},
        @{@"TextField" : itemEndDateTextField, @"Label" : itemEndDateLabel},
        @{@"TextField" : itemAmountTextField, @"Label" : itemAmountLabel},
        @{@"TextField" : itemGracePeriodTextField, @"Label" : itemGracePeriodLabel},
        @{@"TextField" : itemPastDueTextField, @"Button" : itemPastDueTextFieldOverlay, @"Label" : itemPastDueLabel},
        
    ];
    
    [self TextFieldWithoutArrow:textFieldWithoutArrowArray];
    
    NSArray *controlSwitchFrameArray = @[
        
        @{@"View" : itemRepeatIfCompletedEarlySwitch},
        @{@"View" : itemEveryoneTakesTurnsSwitch},
        @{@"View" : itemPrivateSwitch},
        @{@"View" : itemApprovalNeededSwitch}
        
    ];
    
    [self ControlSwitchFrame:controlSwitchFrameArray];
    
    NSArray *viewArray = @[
        
        //        itemNameView,
        itemReminderView,
        itemMoreOptionsView,
        itemAddImageView,
        //        itemNotesView,
        deleteButton
        
    ];
    
    [self ViewWithFourRoundedCorners:viewArray];
    
    NSArray *viewBackgroundColorArr = @[
        
        itemNameView,
        itemListItemsView,
        itemDifficultyView,
        itemPriorityView,
        itemReminderView,
        itemAmountView,
        itemSubTasksView,
        itemDueDateView,
        itemRepeatsView,
        itemRepeatIfCompletedEarlyView,
        itemGracePeriodView,
        itemTimeView,
        itemStartDateView,
        itemEndDateView,
        itemDaysView,
        itemAssignedToView,
        itemMustCompleteView,
        itemCostPerPersonView,
        itemAddImageView,
        itemNotesView,
        itemColorView,
        itemTurnOrderView,
        itemPrivateView,
        itemEveryoneTakesTurnsView,
        itemAlternateTurnsView,
        itemMoreOptionsView,
        itemPaymentMethodView,
        itemRewardView,
        itemApprovalNeededView,
        itemPastDueView,
        itemTagsView
        
    ];
    
    [self ViewBackgroundColor:viewBackgroundColorArr];
    
    NSArray *imageArr = @[
        
        itemRepeatsImage,
        itemGracePeriodImage,
        itemDueDateImage,
        itemAssignedToImage,
        itemSubTasksImage,
        itemDifficultyImage,
        itemPriorityImage,
        itemReminderImage,
        itemDaysImage,
        itemTimeImage,
        itemEveryoneTakesTurnsImage,
        itemAmountImage,
        itemCostPerPersonImage,
        itemColorImage,
        itemListItemsImage,
        itemPrivateImage,
        itemMoreOptionsImage,
        itemPaymentMethodImage,
        itemRewardImage,
        itemApprovalNeededImage,
        itemPastDueImage,
        itemTagsImage
        
    ];
    
    [self ImageIconViewFrame:imageArr];
    
    NSArray *fontTextFieldArr = @[
        
        itemNameTextField,
        itemAssignedToTextField,
        itemMustCompleteTextField,
        itemAmountTextField,
        itemCostPerPersonTextField,
        itemListItemsTextField,
        itemRepeatsTextField,
        itemDueDateTextField,
        itemStartDateTextField,
        itemEndDateTextField,
        itemDaysTextField,
        itemTimeTextField,
        itemTurnOrderTextField,
        itemAlternateTurnsTextField,
        itemGracePeriodTextField,
        itemSubTasksTextField,
        itemReminderTextField,
        itemDifficultyTextField,
        itemPriorityTextField,
        itemPaymentMethodTextField,
        itemRewardTextField,
        itemPastDueTextField,
        itemTagsTextField
        
    ];
    
    [self TextFieldFontSize:fontTextFieldArr];
    
    NSArray *fontLabelArr = @[
        
        itemListItemsLabel,
        itemDifficultyLabel,
        itemPriorityLabel,
        itemReminderLabel,
        itemAmountLabel,
        itemSubTasksLabel,
        itemDueDateLabel,
        itemRepeatsLabel,
        itemGracePeriodLabel,
        itemDaysLabel,
        itemTimeLabel,
        itemRepeatIfCompletedEarlyLabel,
        itemStartDateLabel,
        itemEndDateLabel,
        itemAssignedToLabel,
        itemMustCompleteLabel,
        itemCostPerPersonLabel,
        itemTurnOrderLabel,
        itemColorLabel,
        itemEveryoneTakesTurnsLabel,
        itemAlternateTurnsLabel,
        itemPrivateLabel,
        itemMustCompleteLabel,
        itemMoreOptionsLabel,
        itemPaymentMethodLabel,
        itemRewardLabel,
        itemApprovalNeededLabel,
        itemPastDueLabel,
        itemTagsLabel
        
    ];
    
    [self LabelFontSize:fontLabelArr];
    
    NSArray *InfoImageFrameArr = @[
        
        @{@"ImageView" : itemApprovalNeededInfoImage, @"Label" : itemApprovalNeededLabel, @"View" : itemApprovalNeededView},
        @{@"ImageView" : itemGracePeriodInfoImage, @"Label" : itemGracePeriodLabel, @"View" : itemGracePeriodView},
        @{@"ImageView" : itemPastDueInfoImage, @"Label" : itemPastDueLabel, @"View" : itemPastDueView},
        @{@"ImageView" : itemStartDateInfoImage, @"Label" : itemStartDateLabel, @"View" : itemStartDateView},
        
    ];
    
    [self InfoImageFrame:InfoImageFrameArr];
    
    
    
    
    
    
    
    
    [self.customScrollView addSubview:itemAssignedToView];
    [itemAssignedToView addSubview:itemAssignedToImage];
    [itemAssignedToView addSubview:itemAssignedToLabel];
    [itemAssignedToView addSubview:itemAssignedToTextField];
    [itemAssignedToView addSubview:itemAssignedToRightArrowImage];
    
    [self.customScrollView addSubview:itemRepeatsView];
    [itemRepeatsView addSubview:itemRepeatsImage];
    [itemRepeatsView addSubview:itemRepeatsLabel];
    [itemRepeatsView addSubview:itemRepeatsTextField];
    [itemRepeatsView addSubview:itemRepeatsTextFieldOverlay];
    
    [self.customScrollView addSubview:itemDueDateView];
    [itemDueDateView addSubview:itemDueDateImage];
    [itemDueDateView addSubview:itemDueDateLabel];
    [itemDueDateView addSubview:itemDueDateTextField];
    [itemDueDateView addSubview:itemDueDateTextFieldOverlay];
    
    [self.customScrollView addSubview:itemRepeatIfCompletedEarlyView];
    [itemRepeatIfCompletedEarlyView addSubview:itemRepeatIfCompletedEarlyImage];
    [itemRepeatIfCompletedEarlyView addSubview:itemRepeatIfCompletedEarlyLabel];
    [itemRepeatIfCompletedEarlyView addSubview:itemRepeatIfCompletedEarlySwitch];
    
    [self.customScrollView addSubview:itemStartDateView];
    [itemStartDateView addSubview:itemStartDateLabel];
    [itemStartDateView addSubview:itemStartDateTextField];
    [itemStartDateView addSubview:itemStartDateInfoImage];
    
    [self.customScrollView addSubview:itemEndDateView];
    [itemEndDateView addSubview:itemEndDateLabel];
    [itemEndDateView addSubview:itemEndDateTextField];
    [itemEndDateView addSubview:itemEndDateTextFieldOverlay];
    
    [self.customScrollView addSubview:itemMustCompleteView];
    [itemMustCompleteView addSubview:itemMustCompleteLabel];
    [itemMustCompleteView addSubview:itemMustCompleteTextField];
    
    [self.customScrollView addSubview:itemCostPerPersonView];
    [itemCostPerPersonView addSubview:itemCostPerPersonImage];
    [itemCostPerPersonView addSubview:itemCostPerPersonLabel];
    [itemCostPerPersonView addSubview:itemCostPerPersonTextField];
    [itemCostPerPersonView addSubview:itemCostPerPersonRightArrowImage];
    
    [self.customScrollView addSubview:itemPaymentMethodView];
    [itemPaymentMethodView addSubview:itemPaymentMethodImage];
    [itemPaymentMethodView addSubview:itemPaymentMethodLabel];
    [itemPaymentMethodView addSubview:itemPaymentMethodTextField];
    [itemPaymentMethodView addSubview:itemPaymentMethodRightArrowImage];
    
    [self.customScrollView addSubview:itemAmountView];
    [itemAmountView addSubview:itemAmountImage];
    [itemAmountView addSubview:itemAmountLabel];
    [itemAmountView addSubview:itemAmountTextField];
    
    [self.customScrollView addSubview:itemSubTasksView];
    [itemSubTasksView addSubview:itemSubTasksImage];
    [itemSubTasksView addSubview:itemSubTasksLabel];
    [itemSubTasksView addSubview:itemSubTasksTextField];
    [itemSubTasksView addSubview:itemSubTasksRightArrowImage];
    
    [self.customScrollView addSubview:itemReminderView];
    [itemReminderView addSubview:itemReminderImage];
    [itemReminderView addSubview:itemReminderLabel];
    [itemReminderView addSubview:itemReminderTextField];
    [itemReminderView addSubview:itemRemindersRightArrowImage];
    
    [self.customScrollView addSubview:itemApprovalNeededView];
    [itemApprovalNeededView addSubview:itemApprovalNeededImage];
    [itemApprovalNeededView addSubview:itemApprovalNeededLabel];
    [itemApprovalNeededView addSubview:itemApprovalNeededTextField];
    [itemApprovalNeededView addSubview:itemApprovalNeededSwitch];
    [itemApprovalNeededView addSubview:itemApprovalNeededInfoImage];
    [itemApprovalNeededView addSubview:itemApprovalNeededPremiumImage];
    
    [self.customScrollView addSubview:itemListItemsView];
    [itemListItemsView addSubview:itemListItemsImage];
    [itemListItemsView addSubview:itemListItemsLabel];
    [itemListItemsView addSubview:itemListItemsTextField];
    [itemListItemsView addSubview:itemListItemsRightArrowImage];
    
    [self.customScrollView addSubview:itemMoreOptionsView];
    [itemMoreOptionsView addSubview:itemMoreOptionsImage];
    [itemMoreOptionsView addSubview:itemMoreOptionsLabel];
    [itemMoreOptionsView addSubview:itemMoreOptionsTextField];
    [itemMoreOptionsView addSubview:itemMoreOptionsRightArrowImage];
    
    [self.customScrollView addSubview:itemTurnOrderView];
    [itemTurnOrderView addSubview:itemTurnOrderLabel];
    [itemTurnOrderView addSubview:itemTurnOrderTextField];
    [itemTurnOrderView addSubview:itemTurnOrderRightArrowImage];
    
    [self.customScrollView addSubview:itemDifficultyView];
    [itemDifficultyView addSubview:itemDifficultyImage];
    [itemDifficultyView addSubview:itemDifficultyLabel];
    [itemDifficultyView addSubview:itemDifficultyTextField];
    [itemDifficultyView addSubview:itemDifficultyTextFieldOverlay];
    [itemDifficultyView addSubview:itemDifficultyRightArrowImage];
    
    [self.customScrollView addSubview:itemPriorityView];
    [itemPriorityView addSubview:itemPriorityImage];
    [itemPriorityView addSubview:itemPriorityLabel];
    [itemPriorityView addSubview:itemPriorityTextField];
    [itemPriorityView addSubview:itemPriorityTextFieldOverlay];
    [itemPriorityView addSubview:itemPriorityRightArrowImage];
    
    [self.customScrollView addSubview:itemColorView];
    [itemColorView addSubview:itemColorImage];
    [itemColorView addSubview:itemColorLabel];
    [itemColorView addSubview:itemColorRightArrowImage];
    [itemColorView addSubview:itemColorSelectedView];
    
    [self.customScrollView addSubview:itemNameView];
    [itemNameView addSubview:itemNameTextField];
    
    [self.customScrollView addSubview:itemTimeView];
    [itemTimeView addSubview:itemTimeImage];
    [itemTimeView addSubview:itemTimeLabel];
    [itemTimeView addSubview:itemTimeTextField];
    
    [self.customScrollView addSubview:itemDaysView];
    [itemDaysView addSubview:itemDaysImage];
    [itemDaysView addSubview:itemDaysLabel];
    [itemDaysView addSubview:itemDaysTextField];
    [itemDaysView addSubview:itemDaysRightArrowImage];
    
    [self.customScrollView addSubview:itemEveryoneTakesTurnsView];
    [itemEveryoneTakesTurnsView addSubview:itemEveryoneTakesTurnsImage];
    [itemEveryoneTakesTurnsView addSubview:itemEveryoneTakesTurnsLabel];
    [itemEveryoneTakesTurnsView addSubview:itemEveryoneTakesTurnsSwitch];
    
    [self.customScrollView addSubview:itemAlternateTurnsView];
    [itemAlternateTurnsView addSubview:itemAlternateTurnsLabel];
    [itemAlternateTurnsView addSubview:itemAlternateTurnsTextField];
    [itemAlternateTurnsView addSubview:itemAlternateTurnsTextFieldOverlay];
    
    [self.customScrollView addSubview:itemGracePeriodView];
    [itemGracePeriodView addSubview:itemGracePeriodImage];
    [itemGracePeriodView addSubview:itemGracePeriodLabel];
    [itemGracePeriodView addSubview:itemGracePeriodTextField];
    [itemGracePeriodView addSubview:itemGracePeriodInfoImage];
    
    [self.customScrollView addSubview:itemPrivateView];
    [itemPrivateView addSubview:itemPrivateImage];
    [itemPrivateView addSubview:itemPrivateLabel];
    [itemPrivateView addSubview:itemPrivateSwitch];
    [itemPrivateView addSubview:itemPrivatePremiumImage];
    
    [self.customScrollView addSubview:itemRewardView];
    [itemRewardView addSubview:itemRewardImage];
    [itemRewardView addSubview:itemRewardLabel];
    [itemRewardView addSubview:itemRewardTextField];
    [itemRewardView addSubview:itemRewardRightArrowImage];
    
    [self.customScrollView addSubview:itemPastDueView];
    [itemPastDueView addSubview:itemPastDueImage];
    [itemPastDueView addSubview:itemPastDueLabel];
    [itemPastDueView addSubview:itemPastDueTextField];
    [itemPastDueView addSubview:itemPastDueTextFieldOverlay];
    [itemPastDueView addSubview:itemPastDueInfoImage];
    
    [self.customScrollView addSubview:itemTagsView];
    [itemTagsView addSubview:itemTagsImage];
    [itemTagsView addSubview:itemTagsLabel];
    [itemTagsView addSubview:itemTagsTextField];
    [itemTagsView addSubview:itemTagsRightArrowImage];
    
    //    [self.customScrollView addSubview:itemAddImageView];
    //    [itemAddImageView addSubview:addImageImage];
    //    [itemAddImageView addSubview:itemAddImageLabel];
    
    [self.customScrollView addSubview:itemNotesView];
    [itemNotesView addSubview:itemNotesTextField];
    
    [self.customScrollView addSubview:deleteButton];
    
    defaultFieldColor = itemNameView.backgroundColor;
    
    itemNameTextField.frame = CGRectMake(width*0.04830918, height*0, width*1 - ((width*0.04830918)*2) - (height*0.5), height);
    //    itemNotesTextField.frame = CGRectMake(width*0.04830918, width*0.04830918, width*1 - ((width*0.04830918)*2), itemNotesView.frame.size.height - ((width*0.04830918)*2));
    itemNotesTextField.frame = CGRectMake(width*0.04830918, itemNotesView.frame.size.height*0.5 - 35*0.5, width*1 - ((width*0.04830918)*2), 35);
    
    itemNotesTextField.font = itemNameTextField.font;
    itemNotesTextField.backgroundColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ?
    [[[LightDarkModeObject alloc] init] DarkModeTertiary] :
    [[[LightDarkModeObject alloc] init] LightModeSecondary];
    
    itemAddImageLabel.frame = CGRectMake(width*0.04830918, height*0, width*1 - ((width*0.04830918)*2), height);
    itemAddImageLabel.titleLabel.font = [UIFont systemFontOfSize:(self.view.frame.size.height*0.02173813 > 16?16:(self.view.frame.size.height*0.02173813)) weight:UIFontWeightRegular];
    
    addImageImage.image = [UIImage systemImageNamed:@"camera.viewfinder"];
    addImageImage.contentMode = UIViewContentModeScaleAspectFit;
    addImageImage.tintColor = [UIColor linkColor];
    addImageImage.frame = CGRectMake(width - (height*0.5) - width*0.04830918, height*0.5 - ((height*0.5)*0.5), height*0.5, height*0.5);
    addImageImage.layer.cornerRadius = (addImageImage.frame.size.height*0.2181818182);
    addImageImage.clipsToBounds = YES;
    addImageImage.contentMode = UIViewContentModeScaleAspectFill;
    [itemNameView addSubview:addImageImage];
    
    itemColorSelectedView.frame = CGRectMake(itemColorRightArrowImage.frame.origin.x - (height*0.5) - width*0.04278075, height*0.5 - ((height*0.5)*0.5), height*0.5, height*0.5);
    itemColorSelectedView.layer.cornerRadius = itemColorSelectedView.frame.size.height/3;
    itemColorSelectedView.clipsToBounds = YES;
    
    itemPrivatePremiumImage.frame = CGRectMake(itemPrivateLabel.frame.origin.x + itemPrivateLabel.frame.size.width + itemNameView.frame.size.width*0.0275, height*0.5 - ((height*0.30)*0.5), height*0.30, height*0.30);
    itemApprovalNeededPremiumImage.frame = CGRectMake(itemApprovalNeededInfoImage.frame.origin.x + itemApprovalNeededInfoImage.frame.size.width + itemNameView.frame.size.width*0.0275, height*0.5 - ((height*0.30)*0.5), height*0.30, height*0.30);
    
    self->itemAddImageLabel.titleLabel.adjustsFontSizeToFitWidth = YES;
    self->deleteButton.titleLabel.font = [UIFont systemFontOfSize:itemNameTextField.font.pointSize weight:UIFontWeightSemibold];
    
    [self InitMethod];
    
    [self TapGestures];
    
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        self.view.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [[[LightDarkModeObject alloc] init] DarkModeTextPrimary]};
        itemNameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Name" attributes:@{NSForegroundColorAttributeName : [[[LightDarkModeObject alloc] init] DarkModeTextSecondary]}];
        
        [self preferredStatusBarStyle];
        
        self.navigationController.navigationBar.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        
    } else {
        
        self.navigationController.navigationBar.backgroundColor = [[[LightDarkModeObject alloc] init] LightModePrimary];
        
    }
    
    itemApprovalNeededView.hidden = YES;
    
}

-(void)LabelWithImage:(NSArray *)viewArray {
    
    CGFloat width = CGRectGetWidth(itemNameView.bounds);
    CGFloat height = CGRectGetHeight(itemNameView.bounds);
    
    for (NSDictionary *dictToUse in viewArray) {
        
        UILabel *viewToUse = dictToUse[@"View"];
        float labelWidth = [[[GeneralObject alloc] init] WidthOfString:viewToUse.text withFont:viewToUse.font];//[dictToUse[@"Width"] floatValue];
        
        viewToUse.frame = CGRectMake(width*0.04830918 + width*0.0275 + height*0.5, height*0, labelWidth, height);
        
    }
    
}

-(void)LabelWithoutImage:(NSArray *)viewArray {
    
    CGFloat width = CGRectGetWidth(itemNameView.bounds);
    CGFloat height = CGRectGetHeight(itemNameView.bounds);
    
    for (NSDictionary *dictToUse in viewArray) {
        
        UILabel *viewToUse = dictToUse[@"View"];
        float labelWidth = [[[GeneralObject alloc] init] WidthOfString:viewToUse.text withFont:viewToUse.font];//[dictToUse[@"Width"] floatValue];
        
        viewToUse.frame = CGRectMake(width*0.04830918, height*0, labelWidth, height);
        
    }
    
}

-(void)TextFieldWithArrow:(NSArray *)viewArray {
    
    CGFloat width = CGRectGetWidth(itemNameView.bounds);
    CGFloat height = CGRectGetHeight(itemNameView.bounds);
    
    for (NSDictionary *dictToUse in viewArray) {
        
        UIView *viewToUse = dictToUse[@"View"];
        UILabel *labelToUse = dictToUse[@"Label"];
        UIButton * _Nullable buttonToUse = dictToUse[@"Button"] ? dictToUse[@"Button"] : nil;
        
        CGFloat textFieldWidth = (width*1 - (width*0.04830918) - itemNameView.frame.origin.x - labelToUse.frame.origin.x - labelToUse.frame.size.width);
        
        viewToUse.frame = CGRectMake(itemAssignedToRightArrowImage.frame.origin.x - textFieldWidth - width*0.025 + width*0.025, height*0, textFieldWidth - width*0.025, height);
        
        if (buttonToUse != nil) {
            buttonToUse.frame = CGRectMake(viewToUse.frame.origin.x, viewToUse.frame.origin.y, viewToUse.frame.size.width + 100, viewToUse.frame.size.height);
        }
        
    }
    
}

-(void)TextFieldWithoutArrow:(NSArray *)viewArray {
    
    CGFloat width = CGRectGetWidth(itemNameView.bounds);
    CGFloat height = CGRectGetHeight(itemNameView.bounds);
    
    for (NSDictionary *dictToUse in viewArray) {
        
        UITextField *textFieldToUse = dictToUse[@"TextField"];
        UILabel *labelToUse = dictToUse[@"Label"];
        UIButton * _Nullable buttonToUse = dictToUse[@"Button"] ? dictToUse[@"Button"] : nil;
        
        CGFloat textFieldWidth = (width*1 - ((width*0.04830918)*0.5) - itemNameView.frame.origin.x - labelToUse.frame.origin.x - labelToUse.frame.size.width);
        
        textFieldToUse.frame = CGRectMake(width - textFieldWidth - width*0.04830918, height*0, textFieldWidth, height);
        
        if (buttonToUse != nil) {
            buttonToUse.frame = textFieldToUse.frame;
        }
        
    }
    
}

-(void)RightArrowFrame:(NSArray *)viewArray {
    
    CGFloat width = CGRectGetWidth(itemNameView.bounds);
    CGFloat height = CGRectGetHeight(itemNameView.bounds);
    
    for (NSDictionary *dictToUse in viewArray) {
        
        UIImageView *viewToUse = dictToUse[@"View"];
        
        viewToUse.contentMode = UIViewContentModeScaleAspectFit;
        viewToUse.frame = CGRectMake(width*1 - width*0.02339181 - width*0.04830918, height*0, width*0.02339181, height*1);
        
    }
    
}

-(void)ControlSwitchFrame:(NSArray *)viewArray {
    
    CGFloat width = CGRectGetWidth(itemNameView.bounds);
    CGFloat height = CGRectGetHeight(itemNameView.bounds);
    
    for (NSDictionary *dictToUse in viewArray) {
        
        UIView *viewToUse = dictToUse[@"View"];
        
        CGFloat switchTransform = height*0.5/31;
        
        viewToUse.transform = CGAffineTransformMakeScale(switchTransform, switchTransform);
        viewToUse.frame = CGRectMake(width*1 - viewToUse.frame.size.width - width*0.04830918, height*0.5 - (viewToUse.frame.size.height*0.5), viewToUse.frame.size.width, viewToUse.frame.size.height);
        
    }
    
}

-(void)ViewAlpha:(NSArray *)viewArray {
    
    for (UIView *view in viewArray) {
        
        view.alpha = 1.0f;
        
    }
    
}

-(void)ViewBackgroundColor:(NSArray *)viewArray {
    
    for (UIView *view in viewArray) {
        
        view.backgroundColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ?
        [[[LightDarkModeObject alloc] init] DarkModeTertiary] :
        [[[LightDarkModeObject alloc] init] LightModeSecondary];
        
    }
    
}

-(void)ViewWithFourRoundedCorners:(NSArray *)viewArray {
    
    CGFloat cornerRadius = (self.view.frame.size.height*0.2181818182 > 12?12:(self.view.frame.size.height*0.2181818182));
    
    for (UIView *view in viewArray) {
        
        view.layer.cornerRadius = cornerRadius;
        
    }
    
}

-(void)ImageIconViewFrame:(NSArray *)viewArray {
    
    CGFloat width = CGRectGetWidth(itemNameView.bounds);
    CGFloat height = CGRectGetHeight(itemNameView.bounds);
    
    CGRect imageFrame = CGRectMake(width*0.04830918, height*0.5 - ((height*0.5)*0.5), height*0.5, height*0.5);
    
    for (UIImageView *image in viewArray) {
        
        image.frame = imageFrame;
        
    }
    
}

-(void)TextFieldFontSize:(NSArray *)viewArray {
    
    CGFloat height = CGRectGetHeight(itemNameView.bounds);
    
    UIFont *fontSize = [UIFont systemFontOfSize:(self.view.frame.size.height*0.02173813 > 16?16:(self.view.frame.size.height*0.02173813)) weight:UIFontWeightRegular];
    UIColor *textColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTextSecondary] : [[[LightDarkModeObject alloc] init] LightModeTexAddTaskTextField];
    UIColor *backgroundColor = [UIColor clearColor];
    
    for (UITextField *textField in viewArray) {
        
        textField.font = fontSize;
        textField.minimumFontSize = (height*0.25454545 > 14?14:(height*0.25454545));
        textField.adjustsFontSizeToFitWidth = YES;
        textField.textColor = textColor;
        textField.backgroundColor = backgroundColor;
        
    }
    
}

-(void)LabelFontSize:(NSArray *)viewArray {
    
    UIFont *fontSize = [UIFont systemFontOfSize:(self.view.frame.size.height*0.02173813 > 16?16:(self.view.frame.size.height*0.02173813)) weight:UIFontWeightRegular];
    
    for (UILabel *label in viewArray) {
        
        label.font = fontSize;
        label.adjustsFontSizeToFitWidth = YES;
        label.textColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTextPrimary] : [[[LightDarkModeObject alloc] init] LightModeTextPrimary];
        
        CGRect newRect = label.frame;
        newRect.size.width = [[[GeneralObject alloc] init] WidthOfString:label.text withFont:label.font];
        label.frame = newRect;
        
    }
    
}

-(void)InfoImageFrame:(NSArray *)viewArray {
    
    for (NSDictionary *dictToUse in viewArray) {
        
        UIImageView *imageViewToUse = dictToUse[@"ImageView"];
        UILabel *labelToUse = dictToUse[@"Label"];
        UIView *viewToUse = dictToUse[@"View"];
        
        imageViewToUse.contentMode = UIViewContentModeScaleAspectFit;
        imageViewToUse.frame = CGRectMake(labelToUse.frame.origin.x + labelToUse.frame.size.width + (viewToUse.frame.size.width*0.02139037), 0, viewToUse.frame.size.width*0.05347594, viewToUse.frame.size.height);
        
    }
    
}

-(void)ViewingItemDetailsInteraction:(NSArray *)viewArray {
    
    for (UIView *view in viewArray) {
        
        view.userInteractionEnabled = NO;
        
    }
    
}

-(void)TextFieldDelegate:(NSArray *)viewArray {
    
    for (UITextField *view in viewArray) {
        
        view.delegate = self;
        
    }
    
}

-(void)TextFieldPickerViews:(NSArray *)viewArray {
    
    for (NSDictionary *dictToUse in viewArray) {
        
        UITextField *viewToUse = dictToUse[@"TextField"];
        int tagToUse = [[NSString stringWithFormat:@"%@", dictToUse[@"Tag"]] intValue];
        
        UIPickerView *pickerView = [[UIPickerView alloc]init];
        pickerView.delegate = self;
        pickerView.tag = tagToUse;
        [viewToUse setInputView:pickerView];
        
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

#pragma mark - Init Methods

-(void)InitMethod {
    
    [self SetUpAnalytics];
    
    [self SetUpLocalCurrencySymbolAndCostPerPerson];
    
    [self SetUpDeleteButton];
    
    [self SetUpDefaultValues];
    
    [self SetUpCompValues];
    
    [self SetUpTitle];
    
    [self SetUpViewingTaskBool];
    
    [self SetUpScrollView];
    
    [self SetUpArraysDicts];
    
    [self SetUpTextFields];
    
    [self SetUpDefaultFrequency];
    
    [self SetUpUIPickerViews];
    
    [self SetUpDataUI];
    
    [self SetUpTopLabel];
    
    [self SetUpMainViewContextMenus];
    
    [self SetUpKeyboardNSNotifications];
    
    [self SetUpDefaultTemplate];
    
    [self SetUpToolbar];
    
}

-(void)TapGestures {
    
    UITapGestureRecognizer *tapGesture;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGestureItemAssignedTo:)];
    [itemAssignedToTextField addGestureRecognizer:tapGesture];
    [itemAssignedToView addGestureRecognizer:tapGesture];
    itemAssignedToTextField.userInteractionEnabled = NO;
    itemAssignedToView.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGestureItemCostPerPerson:)];
    [itemCostPerPersonTextField addGestureRecognizer:tapGesture];
    [itemCostPerPersonView addGestureRecognizer:tapGesture];
    itemCostPerPersonTextField.userInteractionEnabled = NO;
    itemCostPerPersonView.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGestureItemPaymentMethod:)];
    [itemPaymentMethodTextField addGestureRecognizer:tapGesture];
    [itemPaymentMethodView addGestureRecognizer:tapGesture];
    itemPaymentMethodTextField.userInteractionEnabled = NO;
    itemPaymentMethodView.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGestureItemDays:)];
    [itemDaysTextField addGestureRecognizer:tapGesture];
    [itemDaysView addGestureRecognizer:tapGesture];
    itemDaysTextField.userInteractionEnabled = NO;
    itemDaysView.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGestureitemSubTasks:)];
    [itemSubTasksTextField addGestureRecognizer:tapGesture];
    [itemSubTasksView addGestureRecognizer:tapGesture];
    itemSubTasksTextField.userInteractionEnabled = NO;
    itemSubTasksView.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGestureItemReminders:)];
    [itemReminderTextField addGestureRecognizer:tapGesture];
    [itemReminderView addGestureRecognizer:tapGesture];
    itemReminderTextField.userInteractionEnabled = NO;
    itemReminderView.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGestureItemColor:)];
    [itemColorLabel addGestureRecognizer:tapGesture];
    [itemColorView addGestureRecognizer:tapGesture];
    itemColorLabel.userInteractionEnabled = NO;
    itemColorView.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGestureItemColor:)];
    [itemColorSelectedView addGestureRecognizer:tapGesture];
    [itemColorSelectedView addGestureRecognizer:tapGesture];
    itemColorSelectedView.userInteractionEnabled = NO;
    itemColorSelectedView.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGestureItemMoreOptions:)];
    [itemMoreOptionsLabel addGestureRecognizer:tapGesture];
    [itemMoreOptionsView addGestureRecognizer:tapGesture];
    itemMoreOptionsLabel.userInteractionEnabled = NO;
    itemMoreOptionsView.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGestureItemSpecificOrder:)];
    [itemTurnOrderView addGestureRecognizer:tapGesture];
    itemTurnOrderView.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGestureItemSpecificOrder:)];
    [itemTurnOrderTextField addGestureRecognizer:tapGesture];
    itemTurnOrderTextField.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGestureItemListItems:)];
    [itemListItemsTextField addGestureRecognizer:tapGesture];
    [itemListItemsView addGestureRecognizer:tapGesture];
    itemListItemsTextField.userInteractionEnabled = NO;
    itemListItemsView.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGestureItemReward:)];
    [itemRewardView addGestureRecognizer:tapGesture];
    itemRewardView.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGestureItemReward:)];
    [itemRewardTextField addGestureRecognizer:tapGesture];
    itemRewardTextField.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGestureItemTags:)];
    [itemTagsTextField addGestureRecognizer:tapGesture];
    [itemTagsView addGestureRecognizer:tapGesture];
    itemTagsTextField.userInteractionEnabled = NO;
    itemTagsView.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ApprovalNeededPopup)];
    [itemApprovalNeededInfoImage addGestureRecognizer:tapGesture];
    itemApprovalNeededInfoImage.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(GracePeriodPopup)];
    [itemGracePeriodInfoImage addGestureRecognizer:tapGesture];
    itemGracePeriodInfoImage.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(PastDuePopup)];
    [itemPastDueInfoImage addGestureRecognizer:tapGesture];
    itemPastDueInfoImage.userInteractionEnabled = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(StartDatePopup)];
    [itemStartDateInfoImage addGestureRecognizer:tapGesture];
    itemStartDateInfoImage.userInteractionEnabled = YES;
    
}

-(void)BarButtonItems {
    
    self.navigationItem.hidesBackButton = YES;
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(NavigationBackButtonAction:)];
    
    if (@available(iOS 16.0, *)) {
        
        BOOL AllDefault = [self CheckIfAllDefault];
        
        if (AllDefault == NO) {
            UIMenu *leftBarButtonItemMenu = [self SetUpBackButtonContextMenu];
            leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" image:nil target:self action:nil menu:leftBarButtonItemMenu];
        } else {
            leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(NavigationBackButtonAction:)];
        }
        
    }
    
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    
    
    
    
    UIMenu *barButtonEllipsisMenu = [self SetUpBarButtonContextMenu];
    UIBarButtonItem *barButtonEllipsisItem = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"ellipsis.circle"] menu:barButtonEllipsisMenu];
    
    if (_viewingTask == NO) {
        
        if ((_addingTask || _duplicatingTask || _addingSuggestedTask || _partiallyAddedTask) && _viewingMoreOptions == NO) {
            
            UIBarButtonItem * rightBarButtonItem = [[UIBarButtonItem alloc]
                                                    initWithTitle:@"Add"
                                                    style:UIBarButtonItemStyleDone
                                                    target:self
                                                    action:@selector(AddItem:)];
            
            self.navigationItem.rightBarButtonItems = @[rightBarButtonItem, barButtonEllipsisItem];
            
        } else if (_addingMultipleTasks && _viewingMoreOptions == NO) {
            
            UIBarButtonItem * rightBarButtonItem = [[UIBarButtonItem alloc]
                                                    initWithTitle:@"Add"
                                                    style:UIBarButtonItemStyleDone
                                                    target:self
                                                    action:@selector(MultiAddItem:)];
            
            self.navigationItem.rightBarButtonItems = @[rightBarButtonItem, barButtonEllipsisItem];
            
        } else if (_viewingMoreOptions) {
            
            UIBarButtonItem * rightBarButtonItem = [[UIBarButtonItem alloc]
                                                    initWithTitle:@"Save"
                                                    style:UIBarButtonItemStyleDone
                                                    target:self
                                                    action:@selector(SaveMoreOptions:)];
            
            self.navigationItem.rightBarButtonItems = @[rightBarButtonItem];
            
        } else if (_editingTask && _viewingMoreOptions == NO) {
            
            UIBarButtonItem * rightBarButtonItem = [[UIBarButtonItem alloc]
                                                    initWithTitle:@"Save"
                                                    style:UIBarButtonItemStyleDone
                                                    target:self
                                                    action:@selector(EditItem:)];
            
            self.navigationItem.rightBarButtonItems = @[rightBarButtonItem, barButtonEllipsisItem];
            
        } else if ((_editingTemplate || _viewingTemplate) && _viewingMoreOptions == NO) {
            
            UIBarButtonItem * rightBarButtonItem = [[UIBarButtonItem alloc]
                                                    initWithTitle:@"Save"
                                                    style:UIBarButtonItemStyleDone
                                                    target:self
                                                    action:@selector(SaveTemplate:)];
            
            self.navigationItem.rightBarButtonItems = @[rightBarButtonItem, barButtonEllipsisItem];
            
        } else if ((_editingDraft || _viewingDraft) && _viewingMoreOptions == NO) {
            
            UIBarButtonItem * rightBarButtonItem = [[UIBarButtonItem alloc]
                                                    initWithTitle:@"Save"
                                                    style:UIBarButtonItemStyleDone
                                                    target:self
                                                    action:@selector(SaveDraft:)];
            
            self.navigationItem.rightBarButtonItems = @[rightBarButtonItem, barButtonEllipsisItem];
            
        }
        
    }
    
}

-(void)NSNotificationObservers:(BOOL)RemoveOnly {
    
    if (_viewingMoreOptions == NO) {
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_AddTask_AddHomeMember" object:nil];
        if (RemoveOnly == NO) { [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_AddTask_AddHomeMember:) name:@"NSNotification_AddTask_AddHomeMember" object:nil]; }
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_AddTask_ItemAssignedTo" object:nil];
        if (RemoveOnly == NO) { [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_AddTask_ItemAssignedTo:) name:@"NSNotification_AddTask_ItemAssignedTo" object:nil]; }
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_AddTask_ItemDays" object:nil];
        if (RemoveOnly == NO) { [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_AddTask_ItemDays:) name:@"NSNotification_AddTask_ItemDays" object:nil]; }
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_AddTask_ItemCostPerPerson" object:nil];
        if (RemoveOnly == NO) { [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_AddTask_ItemCostPerPerson:) name:@"NSNotification_AddTask_ItemCostPerPerson" object:nil]; }
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_AddTask_ItemPaymentMethod" object:nil];
        if (RemoveOnly == NO) { [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_AddTask_ItemPaymentMethod:) name:@"NSNotification_AddTask_ItemPaymentMethod" object:nil]; }
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_AddTask_ItemRepeats" object:nil];
        if (RemoveOnly == NO) { [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_AddTask_ItemRepeats:) name:@"NSNotification_AddTask_ItemRepeats" object:nil]; }
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_AddTask_ItemAlternateTurns" object:nil];
        if (RemoveOnly == NO) { [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_AddTask_ItemAlternateTurns:) name:@"NSNotification_AddTask_ItemAlternateTurns" object:nil]; }
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_AddTask_ItemSpecificDueDates" object:nil];
        if (RemoveOnly == NO) { [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_AddTask_ItemSpecificDueDates:) name:@"NSNotification_AddTask_ItemSpecificDueDates" object:nil]; }
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_AddTask_ItemDueDate" object:nil];
        if (RemoveOnly == NO) { [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_AddTask_ItemDueDate:) name:@"NSNotification_AddTask_ItemDueDate" object:nil]; }
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_AddTask_ItemAmount" object:nil];
        if (RemoveOnly == NO) { [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_AddTask_ItemAmount:) name:@"NSNotification_AddTask_ItemAmount" object:nil]; }
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_AddTask_ItemSpecificOrder" object:nil];
        if (RemoveOnly == NO) { [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_AddTask_ItemSpecificOrder:) name:@"NSNotification_AddTask_ItemSpecificOrder" object:nil]; }
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_AddTask_ItemListItems" object:nil];
        if (RemoveOnly == NO) { [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_AddTask_ItemListItems:) name:@"NSNotification_AddTask_ItemListItems" object:nil]; }
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_AddTask_ItemReminders" object:nil];
        if (RemoveOnly == NO) { [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_AddTask_ItemReminders:) name:@"NSNotification_AddTask_ItemReminders" object:nil]; }
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_AddTask_ItemBringBackMoreOptions" object:nil];
        if (RemoveOnly == NO) { [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_AddTask_ItemBringBackMoreOptions:) name:@"NSNotification_AddTask_ItemBringBackMoreOptions" object:nil]; }
        
    } else {
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_AddTask_ItemPastDue" object:nil];
        if (RemoveOnly == NO) { [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_AddTask_ItemPastDue:) name:@"NSNotification_AddTask_ItemPastDue" object:nil]; }
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_AddTask_ItemSubTasks" object:nil];
        if (RemoveOnly == NO) { [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_AddTask_ItemSubTasks:) name:@"NSNotification_AddTask_ItemSubTasks" object:nil]; }
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_AddTask_ItemDifficulty" object:nil];
        if (RemoveOnly == NO) { [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_AddTask_ItemDifficulty:) name:@"NSNotification_AddTask_ItemDifficulty" object:nil]; }
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_AddTask_ItemPriority" object:nil];
        if (RemoveOnly == NO) {  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_AddTask_ItemPriority:) name:@"NSNotification_AddTask_ItemPriority" object:nil]; }
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_AddTask_ItemColor" object:nil];
        if (RemoveOnly == NO) { [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_AddTask_ItemColor:) name:@"NSNotification_AddTask_ItemColor" object:nil]; }
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_AddTask_ItemReward" object:nil];
        if (RemoveOnly == NO) { [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_AddTask_ItemReward:) name:@"NSNotification_AddTask_ItemReward" object:nil]; }
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_AddTask_ItemTags" object:nil];
        if (RemoveOnly == NO) { [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_AddTask_ItemTags:) name:@"NSNotification_AddTask_ItemTags" object:nil]; }
        
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_AddTask_ItemScheduledStart" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_AddTask_ItemScheduledStart:) name:@"NSNotification_AddTask_ItemScheduledStart" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_AddTask_AddOrEditTaskList" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_AddTask_AddOrEditTaskList:) name:@"NSNotification_AddTask_AddOrEditTaskList" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_AddTask_AddOrEditItemTemplate" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_AddTask_AddOrEditItemTemplate:) name:@"NSNotification_AddTask_AddOrEditItemTemplate" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_AddTask_AddOrEditItemDraft" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_AddTask_AddOrEditItemTemplate:) name:@"NSNotification_AddTask_AddOrEditItemDraft" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotification_AddTask_ItemWeDivvyPremiumAccounts" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSNotification_AddTask_ItemWeDivvyPremiumAccounts:) name:@"NSNotification_AddTask_ItemWeDivvyPremiumAccounts" object:nil];
    
}

-(void)KeyBoardToolBar:(BOOL)DueDate StartDate:(BOOL)StartDate EndDate:(BOOL)EndDate Time:(BOOL)Time Difficulty:(BOOL)Difficulty Priority:(BOOL)Priority Reminder:(BOOL)Reminder Amount:(BOOL)Amount CompletedBy:(BOOL)CompletedBy GracePeriod:(BOOL)GracePeriod Reward:(BOOL)Reward Notes:(BOOL)Notes Name:(BOOL)Name {
    
    UIToolbar* keyboardToolbar = [[UIToolbar alloc] init];
    
    [keyboardToolbar sizeToFit];
    
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                      target:nil action:nil];
    UIBarButtonItem *timeTextField_AnyTimeButton = [[UIBarButtonItem alloc]
                                                    initWithTitle:@"Any Time" style:UIBarButtonItemStyleDone target:self action:@selector(TimeTextField_AnyTime)];
    UIBarButtonItem *startTextField_ClearButton = [[UIBarButtonItem alloc]
                                                   initWithTitle:@"Clear" style:UIBarButtonItemStyleDone target:self action:@selector(StartTextField_Clear)];
    UIBarButtonItem *endTextField_NeverButton = [[UIBarButtonItem alloc]
                                                 initWithTitle:@"Never" style:UIBarButtonItemStyleDone target:self action:@selector(EndTextField_Never)];
    UIBarButtonItem *amountTextField_ItemizedButton = [[UIBarButtonItem alloc]
                                                       initWithTitle:@"Itemize" style:UIBarButtonItemStyleDone target:self action:@selector(AmountTextField_Itemized)];
    UIBarButtonItem *mustCompleteTextField_EveryoneButton = [[UIBarButtonItem alloc]
                                                             initWithTitle:@"Everyone" style:UIBarButtonItemStyleDone target:self action:@selector(MustCompleteTextField_Everyone)];
    UIBarButtonItem *gracePeriodTextField_NoneButton = [[UIBarButtonItem alloc]
                                                        initWithTitle:@"None" style:UIBarButtonItemStyleDone target:self action:@selector(GracePeriodTextField_None)];
    UIBarButtonItem *generalTextField_DoneButton = [[UIBarButtonItem alloc]
                                                    initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(NotesTextField_Done)];
    
    if (Name || Notes) {
        
        keyboardToolbar.items = @[flexBarButton, generalTextField_DoneButton];
        
        if (Name) {
            itemNameTextField.inputAccessoryView = keyboardToolbar;
        }
        
        if (Notes) {
            itemNotesTextField.inputAccessoryView = keyboardToolbar;
        }
        
    } else if (Amount) {
        
        keyboardToolbar.items = @[amountTextField_ItemizedButton, flexBarButton, generalTextField_DoneButton];
        itemAmountTextField.inputAccessoryView = keyboardToolbar;
        
    } else if (CompletedBy) {
        
        keyboardToolbar.items = @[mustCompleteTextField_EveryoneButton, flexBarButton, generalTextField_DoneButton];
        itemMustCompleteTextField.inputAccessoryView = keyboardToolbar;
        
    } else if (StartDate) {
        
        keyboardToolbar.items = @[startTextField_ClearButton, flexBarButton, generalTextField_DoneButton];
        itemStartDateTextField.inputAccessoryView = keyboardToolbar;
        
    } else if (EndDate) {
        
        keyboardToolbar.items = @[endTextField_NeverButton, flexBarButton, generalTextField_DoneButton];
        itemEndDateTextField.inputAccessoryView = keyboardToolbar;
        
    } else if (Time) {
        
        keyboardToolbar.items = @[timeTextField_AnyTimeButton, flexBarButton, generalTextField_DoneButton];
        itemTimeTextField.inputAccessoryView = keyboardToolbar;
        
    } else if (GracePeriod || Reward) {
        
        keyboardToolbar.items = @[gracePeriodTextField_NoneButton, flexBarButton, generalTextField_DoneButton];
        
        if (GracePeriod) {
            itemGracePeriodTextField.inputAccessoryView = keyboardToolbar;
        }
        
        if (Reward) {
            itemRewardTextField.inputAccessoryView = keyboardToolbar;
        }
        
    }
    
}

#pragma mark - Setup Methods

-(void)SetUpAnalytics {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewViewController:@"AddTaskViewController" completionHandler:^(BOOL finished) {
        
    }];
    
    [[[GeneralObject alloc] init] TrackInMixPanel:@"AddTaskViewController"];
    
}

-(void)SetUpLocalCurrencySymbolAndCostPerPerson {
    
    localCurrencySymbol = [[[GeneralObject alloc] init] GenerateLocalCurrencySymbol];
    localCurrencyDecimalSeparatorSymbol = [[[GeneralObject alloc] init] GenerateLocalCurrencyDecimalSeparatorSymbol];
    localCurrencyNumberSeparatorSymbol = [[[GeneralObject alloc] init] GenerateLocalCurrencyNumberSeparatorSymbol];
    itemCostPerPersonTextField.text = [[[[GeneralObject alloc] init] GenerateItemType] isEqualToString:@"Expense"] ? [NSString stringWithFormat:@"%@0%@00 Each", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol] : @"";
    
}

-(void)SetUpDeleteButton {
    
    deleteButton.hidden = _editingTask == NO || self->_viewingTask == YES || self->_duplicatingTask == YES || self->_duplicatingTask == YES || _addingMultipleTasks ? YES : NO;
    deleteButton.userInteractionEnabled = _editingTask == NO || self->_viewingTask == YES || self->_duplicatingTask == YES ? NO : YES;
    [deleteButton setTitle:[NSString stringWithFormat:@"Delete %@", [[[GeneralObject alloc] init] GenerateItemType]] forState:UIControlStateNormal];
    deleteButton.backgroundColor = [UIColor systemPinkColor];
    
}

-(void)SetUpDefaultValues {
    
    itemColorSelectedView.backgroundColor = [UIColor clearColor];
    
    itemNameTextField.text = _addingMultipleTasks && self->_itemToEditDict && self->_itemToEditDict[@"ItemName"] && [self->_itemToEditDict[@"ItemName"] length] > 0 ? self->_itemToEditDict[@"ItemName"] : @"";
    itemDueDateTextField.text = @"No Due Date";
    itemAssignedToTextField.text = @"Myself";
    itemMustCompleteTextField.text = @"Everyone";
    itemAmountTextField.text = _addingMultipleTasks && self->_itemToEditDict && self->_itemToEditDict[@"ItemAmount"] && [self->_itemToEditDict[@"ItemAmount"] length] > 0 ? self->_itemToEditDict[@"ItemAmount"] : [NSString stringWithFormat:@"%@0%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol];
    itemSubTasksTextField.text = @"0";
    itemDifficultyTextField.text = @"No Difficulty";
    itemPriorityTextField.text = _addingMultipleTasks && self->_itemToEditDict && self->_itemToEditDict[@"ItemPriority"] && [self->_itemToEditDict[@"ItemPriority"] length] > 0 ? self->_itemToEditDict[@"ItemPriority"] : @"No Priority";
    itemRepeatsTextField.text = _addingMultipleTasks && self->_itemToEditDict && self->_itemToEditDict[@"ItemRepeats"] && [self->_itemToEditDict[@"ItemRepeats"] length] > 0 ? self->_itemToEditDict[@"ItemRepeats"] : @"Never";
    itemReminderTextField.text = @"0";
    itemRewardTextField.text = @"None";
    itemListItemsTextField.text = _addingMultipleTasks && self->_itemToEditDict && self->_itemToEditDict[@"ItemListItems"] ? [NSString stringWithFormat:@"%lu", [(NSArray *)[self->_itemToEditDict[@"ItemListItems"] allKeys] count]] : @"0";
    itemGracePeriodTextField.text = @"None";
    itemPaymentMethodTextField.text = @"None";
    itemDaysTextField.text = _addingMultipleTasks && self->_itemToEditDict && self->_itemToEditDict[@"ItemDays"] && [self->_itemToEditDict[@"ItemDays"] length] > 0 ? self->_itemToEditDict[@"ItemDays"] : @"";
    itemTimeTextField.text = _addingMultipleTasks && self->_itemToEditDict && self->_itemToEditDict[@"ItemTime"] && [self->_itemToEditDict[@"ItemTime"] length] > 0 ? self->_itemToEditDict[@"ItemTime"] : @"Any Time";
    itemStartDateTextField.text = @"";
    itemEndDateTextField.text = @"Never";
    itemAlternateTurnsTextField.text = @"Every Occurrence";
    itemPastDueTextField.text = @"2 Days";
    itemTagsTextField.text = @"0 Tags";
    
//    if (_addingTask == YES) {
//        NSString *currentHour = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:@"h" returnAs:[NSString class]];
//        hourComp = currentHour;
//        NSString *currentMinute = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:@"mm" returnAs:[NSString class]];
//        minuteComp = currentMinute;
//        NSString *currentTime = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:@"a" returnAs:[NSString class]];
//        AMPMComp = currentTime;
//    }
    
    [self RepeatIfCompletedEarlySwitchAction:_addingMultipleTasks && self->_itemToEditDict && self->_itemToEditDict[@"ItemRepeatIfCompletedEarly"] && [self->_itemToEditDict[@"ItemRepeatIfCompletedEarly"] length] > 0 && [self->_itemToEditDict[@"ItemRepeatIfCompletedEarly"] isEqualToString:@"Yes"]&& [self->_itemToEditDict[@"ItemRepeats"] isEqualToString:@"When Completed"] == NO ? @"Yes" : @"No"];
    
    [itemEveryoneTakesTurnsSwitch setOn:_addingMultipleTasks && self->_itemToEditDict && self->_itemToEditDict[@"ItemTakeTurns"] && [self->_itemToEditDict[@"ItemTakeTurns"] length] > 0 && [self->_itemToEditDict[@"ItemTakeTurns"] isEqualToString:@"Yes"] ? YES : NO];
    
}

-(void)SetUpCompValues {
    
    hourComp = @"";
    minuteComp = @"";
    AMPMComp = @"";
    
    completedByOnlyComp = @"";
    completedByAmountComp = @"";
    
    gracePeriodAmountComp = @"";
    gracePeriodFrequencyComp = @"";
    
    selfDestructAmountComp = @"";
    selfDestructFrequencyComp = @"";
    
    estimatedTimeAmountComp = @"";
    estimatedTimeFrequencyComp = @"";
    
}

-(void)SetUpTitle {
    
    NSString *titleString = @"";
    
    if (_viewingMoreOptions == YES) {
        
        titleString = @"More Options";
        
    } else if (_viewingTask == YES && _viewingMoreOptions == NO) {
        
        titleString = [NSString stringWithFormat:@"Viewing %@", [[[GeneralObject alloc] init] GenerateItemType]];
        
    } else if (_editingTask == YES && _duplicatingTask == NO) {
        
        titleString = [NSString stringWithFormat:@"Edit %@", [[[GeneralObject alloc] init] GenerateItemType]];
        
    } else {
        
        titleString = [NSString stringWithFormat:@"New %@", [[[GeneralObject alloc] init] GenerateItemType]];
        
    }
    
    if (_viewingTemplate) {
        
        self.title = @"Create Template";
        
    } else if (_editingTemplate) {
        
        self.title = @"";
        
    } else if (_viewingDraft) {
        
        self.title = @"Create Draft";
        
    } else if (_editingDraft) {
        
        self.title = @"";
        
    }
    
}

-(void)SetUpViewingTaskBool {
    
    if (_viewingTask) {
        
        NSArray *viewingItemDetailsInteractionArray = @[
            
            itemNameTextField,
            itemAmountTextField,
            itemAssignedToTextField,
            itemDueDateTextField,
            itemCostPerPersonTextField,
            itemPaymentMethodTextField,
            itemTurnOrderTextField,
            itemRepeatsTextField,
            itemMustCompleteTextField,
            itemStartDateTextField,
            itemEndDateTextField,
            itemDaysTextField,
            itemTimeTextField,
            itemDifficultyTextField,
            itemPriorityTextField,
            itemSubTasksTextField,
            itemReminderTextField,
            itemGracePeriodTextField,
            itemListItemsTextField,
            itemAddImageLabel,
            itemNotesTextField,
            
            itemNameView,
            itemAmountView,
            itemDueDateView,
            itemCostPerPersonView,
            itemPaymentMethodView,
            itemRepeatsView,
            itemMustCompleteView,
            itemStartDateView,
            itemEndDateView,
            itemDaysView,
            itemTimeView,
            itemDifficultyView,
            itemPriorityView,
            itemSubTasksView,
            itemReminderView,
            itemGracePeriodView,
            itemColorView,
            
            itemPrivateSwitch,
            itemEveryoneTakesTurnsSwitch,
            itemPrivateSwitch,
            itemApprovalNeededSwitch,
            
        ];
        
        [self ViewingItemDetailsInteraction:viewingItemDetailsInteractionArray];
        
    }
    
}

-(void)SetUpScrollView {
    
    _customScrollView.delegate = self;
    
}

-(void)SetUpArraysDicts {
    
    itemSpecificDueDatesArray = [NSMutableArray array];
    itemDueDatesSkippedArray = [NSMutableArray array];
    itemTagsArrays = [NSMutableArray array];
    itemCompletedDict = [NSMutableDictionary dictionary];
    itemInProgressDict = [NSMutableDictionary dictionary];
    itemWontDoDict = [NSMutableDictionary dictionary];
    
    keyArray = [[[GeneralObject alloc] init] GenerateKeyArray];
    assignedToIDArray = [NSMutableArray array];
    assignedToUsernameArray = [NSMutableArray array];
    
    if (_editingTask == NO && _duplicatingTask == NO) {
        [assignedToUsernameArray addObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"]];
    }
    
    assignedToProfileImageArray = [NSMutableArray array];
    
    itemCostPerPersonDict = [NSMutableDictionary dictionary];
    itemPaymentMethodDict = [NSMutableDictionary dictionary];
    itemRewardDict = [NSMutableDictionary dictionary];
    itemItemizedItemsDict = [NSMutableDictionary dictionary];
    itemApprovalRequestsDict = [NSMutableDictionary dictionary];
    itemSubTasksDict = [NSMutableDictionary dictionary];
    itemReminderDict = [[[[GeneralObject alloc] init] GenerateDefaultRemindersDict:[[[GeneralObject alloc] init] GenerateItemType] itemAssignedTo:[self GenerateItemAssignedTo:[self GenerateItemRandomizeTurnOrder]] itemRepeats:[self GenerateItemRepeat] homeMembersDict:_homeMembersDict AnyTime:YES] mutableCopy];
    itemListItemsDict = [NSMutableDictionary dictionary];
    
}

-(void)SetUpTextFields {
    
    [self textViewDidChange:itemNotesTextField];
    
    NSArray *textFieldDelegatesArray = @[
        
        itemNameTextField,
        itemDueDateTextField,
        itemMustCompleteTextField,
        itemStartDateTextField,
        itemEndDateTextField,
        itemTimeTextField,
        itemDifficultyTextField,
        itemPriorityTextField,
        itemAmountTextField,
        itemReminderTextField,
        itemGracePeriodTextField,
        itemRewardTextField,
        itemNotesTextField,
        
    ];
    
    [self TextFieldDelegate:textFieldDelegatesArray];
    
    itemNameTextField.placeholder = @"Name";
    itemRepeatsTextField.userInteractionEnabled = NO;
    
}

-(void)SetUpUIPickerViews {
    
    UIDatePicker *datePickerView = [[UIDatePicker alloc]init];
    [datePickerView setDate:[NSDate date]];
    [datePickerView setDatePickerMode:UIDatePickerModeDateAndTime];
    [datePickerView addTarget:self action:@selector(FormatDateTextField:) forControlEvents:UIControlEventValueChanged];
    if (@available(iOS 13.4, *)) {
        [datePickerView setPreferredDatePickerStyle:UIDatePickerStyleWheels];
    }
    [itemDueDateTextField setInputView:datePickerView];
    
    datePickerView = [[UIDatePicker alloc]init];
    [datePickerView setDate:[NSDate date]];
    [datePickerView setPreferredDatePickerStyle:UIDatePickerStyleCompact];
    [datePickerView setCalendar:[NSCalendar currentCalendar]];
    [datePickerView setDatePickerMode:UIDatePickerModeDateAndTime];
    [datePickerView addTarget:self action:@selector(FormatDateTextField:) forControlEvents:UIControlEventValueChanged];
    if (@available(iOS 13.4, *)) {
        [datePickerView setPreferredDatePickerStyle:UIDatePickerStyleInline];
    }
    
    [itemStartDateTextField setInputView:datePickerView];
    [itemEndDateTextField setInputView:datePickerView];
    
    NSArray *textFieldPickerViewsArray = @[
        
        @{@"TextField" : itemTimeTextField, @"Tag" : @"2"},
        @{@"TextField" : itemReminderTextField, @"Tag" : @"3"},
        @{@"TextField" : itemMustCompleteTextField, @"Tag" : @"4"},
        @{@"TextField" : itemGracePeriodTextField, @"Tag" : @"6"},
        
    ];
    
    [self TextFieldPickerViews:textFieldPickerViewsArray];
    
    if (!self->_itemToEditDict) {
        
        self->gracePeriodAmountComp = @"1";
        self->gracePeriodFrequencyComp = @"Day";
        
        [self SelectRowForCompAndArrays:
         @[@{@"Array" : self->frequencyGracePeriodAmountArray, @"Comp" : self->gracePeriodAmountComp},
           @{@"Array" : self->frequencyGracePeriodFrequencyArray, @"Comp" : self->gracePeriodFrequencyComp}]
                              textField:itemGracePeriodTextField];
        
    }
    
}

-(void)SetUpDataUI {
    
    if (_viewingAddExpenseViewController == YES) {
        
        itemType = @"Expense";
        
    } else if (_viewingAddListViewController == YES) {
        
        itemType = @"List";
        
    } else {
        
        itemType = @"Chore";
        
    }
    
    itemTypeCollection = [NSString stringWithFormat:@"%@s", itemType];
    
    if (_viewingMoreOptions == NO) {
        
        if (_viewingAddExpenseViewController) {
            
            itemAmountView.hidden = NO;
            itemCostPerPersonView.hidden = NO;
            itemPaymentMethodView.hidden = NO;
            itemListItemsView.hidden = YES;
            
            itemAmountView.userInteractionEnabled = YES;
            itemCostPerPersonView.userInteractionEnabled = YES;
            itemPaymentMethodView.userInteractionEnabled = YES;
            itemListItemsView.userInteractionEnabled = NO;
            
        } else if (_viewingAddListViewController) {
            
            itemAmountView.hidden = YES;
            itemCostPerPersonView.hidden = YES;
            itemPaymentMethodView.hidden = YES;
            itemListItemsView.hidden = NO;
            
            itemAmountView.userInteractionEnabled = NO;
            itemCostPerPersonView.userInteractionEnabled = NO;
            itemPaymentMethodView.userInteractionEnabled = NO;
            itemListItemsView.userInteractionEnabled = YES;
            
        } else {
            
            itemAmountView.hidden = YES;
            itemCostPerPersonView.hidden = YES;
            itemPaymentMethodView.hidden = YES;
            itemListItemsView.hidden = YES;
            
            itemAmountView.userInteractionEnabled = NO;
            itemCostPerPersonView.userInteractionEnabled = NO;
            itemPaymentMethodView.userInteractionEnabled = NO;
            itemListItemsView.userInteractionEnabled = YES;
            
        }
        
    }
    
}

-(void)SetUpDefaultFrequency {
    
    
    
    
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
    
    
    
    
    frequencyGracePeriodAmountArray = [[NSMutableArray alloc] init];
    for (int i=1;i<61;i++) {
        [frequencyGracePeriodAmountArray addObject:[NSString stringWithFormat:@"%d", i]];
    }
    
    
    
    
    frequencyCompletedByOnlyArray = [[NSMutableArray alloc] init];
    [frequencyCompletedByOnlyArray addObject:@"Only"];
    
    
    
    
    [self GenerateCompletedByFrequencyArray:self->assignedToIDArray];
    [self GenerateGracePeriodFrequencyArray:[self GenerateItemRepeat]];
    
}

-(void)SetUpTopLabel {
    
    NSString *listName = _defaultTaskListName != NULL && _defaultTaskListName != nil ? _defaultTaskListName : @"No List";
  
    if (_editingTask == YES) {
        
        NSString *listName = @"No List";
        
        NSString *itemUniqueID = [self->_itemToEditDict[@"ItemUniqueID"] length] > 0 ? self->_itemToEditDict[@"ItemUniqueID"] : @"xxx";
        
        for (NSString *taskListID in _taskListDict[@"TaskListID"]) {
            
            NSUInteger index = [_taskListDict[@"TaskListID"] indexOfObject:taskListID];
            
            NSMutableDictionary *taskListItems = [(NSArray *)_taskListDict[@"TaskListItems"] count] > index ? _taskListDict[@"TaskListItems"][index] : [NSMutableDictionary dictionary];
            
            if ([[taskListItems allKeys] containsObject:itemUniqueID]) {
                
                listName = [(NSArray *)_taskListDict[@"TaskListName"] count] > index ? _taskListDict[@"TaskListName"][index] : @"";
                break;
                
            }
            
        }
        
    } else if (_addingMultipleTasks) {
        
        listName = _itemToEditDict[@"ItemTaskList"] ? _itemToEditDict[@"ItemTaskList"] : @"No List";
        
    }
    
    oldTaskList = listName;
    
    topViewLabel.text = listName;
    
    topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, self.navigationController.navigationBar.frame.size.height+12)];
    topViewCover = [[UIButton alloc] initWithFrame:topView.frame];
    
    topViewImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 8.5, self.navigationController.navigationBar.frame.size.height+12)];
    topViewImageView.image = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [UIImage imageNamed:@"GeneralIcons.TopLabelArrow.White"] : [UIImage imageNamed:@"GeneralIcons.TopLabelArrow"];
    topViewImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    topViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [[[GeneralObject alloc] init] WidthOfString:listName withFont:[UIFont systemFontOfSize:15 weight:UIFontWeightSemibold]], self.navigationController.navigationBar.frame.size.height+12)];
    topViewLabel.text = listName;
    topViewLabel.textColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTextPrimary] : [[[LightDarkModeObject alloc] init] LightModeTextPrimary];
    topViewLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightSemibold];
    topViewLabel.textAlignment = NSTextAlignmentCenter;
    topViewLabel.adjustsFontSizeToFitWidth = YES;
    
    CGRect newRect = topView.frame;
    newRect.size.width = topViewLabel.frame.size.width;
    newRect.origin.x = self.view.frame.size.width*0.5 - (newRect.size.width*0.5);
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

-(void)SetUpMainViewContextMenus {
    
    [self SetUpAddPhotoContextMenu];
    
    [self SetUpTopLabelContextMenu];
    
    [self SetUpRepeatsContextMenu:YES];
    
    [self SetUpDueDateContextMenu:YES];
    
    [self SetUpEndDateContextMenu];
    
    [self SetUpAlternateTurnsContextMenu];
    
    [self SetUpPastDueContextMenu];
    
    [self SetUpDifficultyContextMenu];
    
    [self SetUpPriorityContextMenu];
    
}

-(UIMenu *)SetUpBackButtonContextMenu {
    
    NSMutableArray *backButtonActions = [self BackItemContextMenuActions];
    
    UIMenu *backButtonMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"Back" options:0 children:backButtonActions];
    
    return backButtonMenu;
}

-(UIMenu *)SetUpBarButtonContextMenu {
    
    NSMutableArray *draftActions = [self DraftItemContextMenuActions];
    NSMutableArray *templateActions = [self TemplateItemContextMenuActions];
    NSMutableArray *scheduledStartActions = [self ScheduledStartItemContextMenuActions];
    
    
    
    
    UIMenu *draftsMenu = [UIMenu menuWithTitle:@"Drafts" image:[UIImage systemImageNamed:@"square.and.pencil"] identifier:@"Drafts" options:0 children:draftActions];
    if (@available(iOS 15.0, *)) {
        draftsMenu.subtitle = _draftDict[@"DraftID"] ? [NSString stringWithFormat:@"%lu", [(NSArray *)_draftDict[@"DraftID"] count]] : @"";
    } else {
        // Fallback on earlier versions
    }
    
    
    
    
    UIMenu *templateMenu = [UIMenu menuWithTitle:@"Templates" image:[UIImage systemImageNamed:@"list.bullet.rectangle.portrait"] identifier:@"Templates" options:0 children:templateActions];
    if (@available(iOS 15.0, *)) {
        templateMenu.subtitle = self->selectedTemplate;
    } else {
        // Fallback on earlier versions
    }
    
    
    
    
    NSString *scheduledStartMenuTitle = [self->selectedScheduledStart isEqualToString:@"Now"] ? @"Scheduled to begin" : @"Scheduled to begin in";
    
    UIMenu *scheduledStartMenu = [UIMenu menuWithTitle:scheduledStartMenuTitle image:[UIImage systemImageNamed:@"clock.badge"] identifier:@"Scheduled to begin" options:0 children:scheduledStartActions];
    if (@available(iOS 15.0, *)) {
        scheduledStartMenu.subtitle = self->selectedScheduledStart;
    } else {
        // Fallback on earlier versions
    }
    
    
    
    
    //    UIMenu *makeDefaultMenu = [UIMenu menuWithTitle:@"Make this view the default for adding tasks" image:nil identifier:@"Make Default" options:UIMenuOptionsDisplayInline children:makeDefaultActions];
    
    
    
    
    NSMutableArray *barButtonItemActions = [NSMutableArray array];
    
    if (_viewingDraft == NO && _editingDraft == NO) { [barButtonItemActions addObject:draftsMenu]; }
    if (_viewingTemplate == NO && _editingTemplate == NO) { [barButtonItemActions addObject:templateMenu]; }
    [barButtonItemActions addObject:scheduledStartMenu];
    //Post-Spike
    //    [barButtonItemActions addObject:makeDefaultMenu];
    
    
    
    
    UIMenu *barButtonItemMenu = [UIMenu menuWithChildren:barButtonItemActions];
    
    return barButtonItemMenu;
}

-(void)SetUpRepeatsContextMenu:(BOOL)InitialSetUp {
    
    if (InitialSetUp == NO) {
        
        itemReminderDict = [[self GenerateItemReminder:itemDueDateTextField.text itemRepeats:itemRepeatsTextField.text itemTime:itemTimeTextField.text SettingData:NO] mutableCopy];
        itemReminderTextField.text = [NSString stringWithFormat:@"%lu", (unsigned long)[[itemReminderDict allKeys] count]];
        
    }
    
    [self DismissAllKeyboards:NO];
    
    [self BarButtonItems];
    
    NSMutableArray* actions = [[NSMutableArray alloc] init];
    NSMutableArray* neverMenuActions = [[NSMutableArray alloc] init];
    NSMutableArray* asNeededMenuActions = [[NSMutableArray alloc] init];
    NSMutableArray* whenCompletedMenuActions = [[NSMutableArray alloc] init];
    NSMutableArray* repeatingMenuActions = [[NSMutableArray alloc] init];
    NSMutableArray* customMenuActions = [[NSMutableArray alloc] init];
    
    NSString *imageString = [itemRepeatsTextField.text isEqualToString:@"Never"] ? @"checkmark" : @"";
    
    [neverMenuActions addObject:[UIAction actionWithTitle:@"Never" image:[UIImage systemImageNamed:imageString] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Never Repeats Clicked For %@", self->itemType] completionHandler:^(BOOL finished) {
            
        }];
        
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemRepeats" userInfo:@{@"Repeats" : @"Never", @"RepeatIfCompletedEarly" : @"No"} locations:@[@"AddTask"]];
        
        [self SetUpRepeatsContextMenu:NO];
        [self SetUpDueDateContextMenu:NO];
        
    }]];
    
    imageString = [itemRepeatsTextField.text isEqualToString:@"As Needed"] ? @"checkmark" : @"";
    
    NSMutableArray *selectActions = [NSMutableArray array];
    NSMutableArray *selectMenuActions = [NSMutableArray array];
    
    UIAction *selectAction = [UIAction actionWithTitle:@"Select" image:nil identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"As Needed For %@", self->itemType] completionHandler:^(BOOL finished) {
            
        }];
        
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemRepeats" userInfo:@{@"Repeats" : @"As Needed", @"RepeatIfCompletedEarly" : @"No"} locations:@[@"AddTask"]];
        
        if ([self->itemAlternateTurnsTextField.text containsString:@"Completion"] == NO) {
            self->itemAlternateTurnsTextField.text = @"Every Completion";
        }
        
        [self AdjustTextFieldFramesToUse:0.25];
        
        [self SetUpRepeatsContextMenu:NO];
        
    }];
    
    [selectActions addObject:selectAction];
    
    UIMenu *selectMenu = [UIMenu menuWithTitle:[NSString stringWithFormat:@"Create a %@ with no due due. Complete it as often as is needed.", [itemType lowercaseString]] image:nil identifier:@"Select" options:UIMenuOptionsDisplayInline children:selectActions];
    [selectMenuActions addObject:selectMenu];
    
    UIMenu *asNeededMenu = [UIMenu menuWithTitle:@"As Needed" image:[UIImage systemImageNamed:imageString] identifier:@"As Needed" options:0 children:selectMenuActions];
    [asNeededMenuActions addObject:asNeededMenu];
    
    
    
    //Post-Spike
    imageString = [itemRepeatsTextField.text isEqualToString:@"When Completed"] ? @"checkmark" : @"";
    
    selectActions = [NSMutableArray array];
    selectMenuActions = [NSMutableArray array];
    
    selectAction = [UIAction actionWithTitle:@"Select" image:nil identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"When Completed For %@", self->itemType] completionHandler:^(BOOL finished) {
            
        }];
        
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemRepeats" userInfo:@{@"Repeats" : @"When Completed", @"RepeatIfCompletedEarly" : @"No"} locations:@[@"AddTask"]];
        
        if ([self->itemAlternateTurnsTextField.text containsString:@"Completion"] == YES) {
            self->itemAlternateTurnsTextField.text = @"Every Occurrence";
        }
        
        [self AdjustTextFieldFramesToUse:0.25];
        
        [self SetUpRepeatsContextMenu:NO];
        
    }];
    
    [selectActions addObject:selectAction];
    
    
    
    
    selectMenu = [UIMenu menuWithTitle:[NSString stringWithFormat:@"Create a %@ with no due due. It repeats only when it is fully completed.", [itemType lowercaseString]] image:nil identifier:@"Select" options:UIMenuOptionsDisplayInline children:selectActions];
    [selectMenuActions addObject:selectMenu];
    
    UIMenu *whenCompletedMenu = [UIMenu menuWithTitle:@"When Completed" image:[UIImage systemImageNamed:imageString] identifier:@"When Completed" options:0 children:selectMenuActions];
    [whenCompletedMenuActions addObject:whenCompletedMenu];
    
    
    
    NSArray *repeatingArray = @[@"Hourly", @"Daily", @"Weekly", @"Bi-Weekly", @"Semi-Monthly", @"Monthly"];
    
    for (NSString *repeats in repeatingArray) {
        
        imageString = [itemRepeatsTextField.text isEqualToString:repeats] || [itemRepeatsTextField.text isEqualToString:[NSString stringWithFormat:@"%@ or When Completed", repeats]] ? @"checkmark" : @"";
        
        [repeatingMenuActions addObject:[UIAction actionWithTitle:repeats image:[UIImage systemImageNamed:imageString] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"%@ For %@", repeats, self->itemType] completionHandler:^(BOOL finished) {
                
            }];
            
            [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemRepeats" userInfo:@{@"Repeats" : repeats, @"RepeatIfCompletedEarly" : @"No"} locations:@[@"AddTask"]];
            
            [self SetUpRepeatsContextMenu:NO];
            
        }]];
        
    }
    
    
    
    NSString *repeatsWithoutOrWhenCompleted = itemRepeatsTextField.text;
    
    imageString = [repeatingArray containsObject:itemRepeatsTextField.text] == NO && [repeatingArray containsObject:repeatsWithoutOrWhenCompleted] == NO && [itemRepeatsTextField.text isEqualToString:@"Never"] == NO && [itemRepeatsTextField.text isEqualToString:@"As Needed"] == NO && [itemRepeatsTextField.text isEqualToString:@"When Completed"] == NO && [itemRepeatsTextField.text isEqualToString:@"When Completed"] == NO ? @"checkmark" : @"";
    
    [customMenuActions addObject:[UIAction actionWithTitle:@"More Options" image:[UIImage systemImageNamed:imageString] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Custom For %@", self->itemType] completionHandler:^(BOOL finished) {
            
        }];
        
        [self TapGestureItemRepeats:self];
        
        [self SetUpRepeatsContextMenu:NO];
        
    }]];
    
    
    
    UIMenu *neverInlineMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"1" options:UIMenuOptionsDisplayInline children:neverMenuActions];
    //UIMenu *oneTimeInlineMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"2" options:UIMenuOptionsDisplayInline children:oneTimeMenuActions];
    UIMenu *nasNeededInlineMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"3" options:UIMenuOptionsDisplayInline children:asNeededMenuActions];
    UIMenu *whenCompletedInlineMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"3" options:UIMenuOptionsDisplayInline children:whenCompletedMenuActions];
    UIMenu *repeatingInlineMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"4" options:UIMenuOptionsDisplayInline children:repeatingMenuActions];
    UIMenu *customInlineMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"5" options:UIMenuOptionsDisplayInline children:customMenuActions];
    
    [actions addObject:neverInlineMenu];
    [actions addObject:nasNeededInlineMenu];
    [actions addObject:whenCompletedInlineMenu];
    
    [actions addObject:repeatingInlineMenu];
    [actions addObject:customInlineMenu];
    
    itemRepeatsTextFieldOverlay.menu = [UIMenu menuWithTitle:@"" children:actions];
    itemRepeatsTextFieldOverlay.showsMenuAsPrimaryAction = true;
    
}

-(void)SpecificDates {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Keyboard Toolbar Button \"SpecificDates\" (Due Date) Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    [[[PushObject alloc] init] PushToViewAddItemsViewController:itemSpecificDueDatesArray itemsAlreadyChosenDict:nil userDict:nil optionSelectedString:@"SpecificDates" itemRepeats:itemRepeatsTextField.text viewingItemDetails:_viewingTask currentViewController:self];
    
}

-(void)SetUpDueDateContextMenu:(BOOL)InitialSetUp {
    
    if (InitialSetUp == NO) {
        
        itemReminderDict = [[self GenerateItemReminder:itemDueDateTextField.text itemRepeats:itemRepeatsTextField.text itemTime:itemTimeTextField.text SettingData:NO] mutableCopy];
        itemReminderTextField.text = [NSString stringWithFormat:@"%lu", (unsigned long)[[itemReminderDict allKeys] count]];
        
    }
    
    NSMutableArray* actions = [[NSMutableArray alloc] init];
    NSMutableArray* neverMenuActions = [[NSMutableArray alloc] init];
    NSMutableArray* repeatingMenuActions = [[NSMutableArray alloc] init];
    NSMutableArray* multipleDatesMenuActions = [[NSMutableArray alloc] init];
    NSMutableArray* customMenuActions = [[NSMutableArray alloc] init];
    
    NSString *imageString = [itemDueDateTextField.text isEqualToString:@"No Due Date"] ? @"checkmark" : @"";
    
    [neverMenuActions addObject:[UIAction actionWithTitle:@"No Due Date" image:[UIImage systemImageNamed:imageString] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"No Due Date Clicked For %@", self->itemType] completionHandler:^(BOOL finished) {
            
        }];
        
        [self ClearMultipleDueDatesArray:@"No Due Date" completionHandler:^(BOOL finished, BOOL SureSelected, BOOL PopupDisplayed) {
            
            if (PopupDisplayed == NO) {
                
                self->itemDueDateTextField.text = @"No Due Date";
                
            }
            
            [self BarButtonItems];
            [self SetUpDueDateContextMenu:NO];
            [self AdjustTextFieldFramesToUse:0.25];
            
        }];
        
    }]];
    
    NSArray *dueDateArray = @[[NSString stringWithFormat:@"Today (%@)", [self GenerateTodaysDate:NO]], [NSString stringWithFormat:@"Tomorrow (%@)", [self GenerateTomorrowsDate:NO]], [NSString stringWithFormat:@"End of Week (%@)", [self GenerateEndOfWeeksDate:NO]], [NSString stringWithFormat:@"Next Week (%@)", [self GenerateStartOfNextWeeksDate:NO]], [NSString stringWithFormat:@"End of Month (%@)", [self GenerateEndOfMonthDate:NO]], [NSString stringWithFormat:@"Next Month (%@)", [self GenerateBeginningOfNextMonthDate:NO]]];
    
    for (NSString *dueDate in dueDateArray) {
        
        imageString = [itemDueDateTextField.text containsString:dueDate] ? @"checkmark" : @"";
        
        if ([dueDate containsString:@"Today "] && [itemDueDateTextField.text containsString:[self GenerateTodaysDate:YES]]) {
            
            imageString = @"checkmark";
            
        } else if ([dueDate containsString:@"Tomorrow "] && [itemDueDateTextField.text containsString:[self GenerateTomorrowsDate:YES]]) {
            
            imageString = @"checkmark";
            
        } else if ([dueDate containsString:@"End of Week "] && [itemDueDateTextField.text containsString:[self GenerateEndOfWeeksDate:YES]]) {
            
            imageString = @"checkmark";
            
        } else if ([dueDate containsString:@"Next Week "] && [itemDueDateTextField.text containsString:[self GenerateStartOfNextWeeksDate:YES]]) {
            
            imageString = @"checkmark";
            
        } else if ([dueDate containsString:@"End of Month "] && [itemDueDateTextField.text containsString:[self GenerateEndOfMonthDate:YES]]) {
            
            imageString = @"checkmark";
            
        } else if ([dueDate containsString:@"Next Month "] && [itemDueDateTextField.text containsString:[self GenerateBeginningOfNextMonthDate:YES]]) {
            
            imageString = @"checkmark";
            
        }
        
        [repeatingMenuActions addObject:[UIAction actionWithTitle:dueDate image:[UIImage systemImageNamed:imageString] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"%@ For %@", dueDate, self->itemType] completionHandler:^(BOOL finished) {
                
            }];
            
            NSString *itemDueDate = dueDate;
            
            if ([itemDueDate containsString:@"Today "]) {
                
                itemDueDate = [self GenerateTodaysDate:YES];
                
            } else if ([itemDueDate containsString:@"Tomorrow "]) {
                
                itemDueDate = [self GenerateTomorrowsDate:YES];
                
            } else if ([itemDueDate containsString:@"End of Week "]) {
                
                itemDueDate = [self GenerateEndOfWeeksDate:YES];
                
            } else if ([itemDueDate containsString:@"Next Week "]) {
                
                itemDueDate = [self GenerateStartOfNextWeeksDate:YES];
                
            } else if ([itemDueDate containsString:@"End of Month "]) {
                
                itemDueDate = [self GenerateEndOfMonthDate:YES];
                
            } else if ([itemDueDate containsString:@"Next Month "]) {
                
                itemDueDate = [self GenerateBeginningOfNextMonthDate:YES];
                
            }
            
            [self ClearMultipleDueDatesArray:itemDueDate completionHandler:^(BOOL finished, BOOL SureSelected, BOOL PopupDisplayed) {
                
                if (PopupDisplayed == NO) {
                    
                    self->itemDueDateTextField.text = itemDueDate;
                    
                }
                
                [self BarButtonItems];
                [self SetUpDueDateContextMenu:NO];
                [self AdjustTextFieldFramesToUse:0.25];
                
            }];
            
        }]];
        
    }
    
    imageString = [itemSpecificDueDatesArray count] > 0 ? @"checkmark" : @"";
    
    [multipleDatesMenuActions addObject:[UIAction actionWithTitle:@"Multiple Dates" image:[UIImage systemImageNamed:imageString] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Multiple Dates Clicked For %@", self->itemType] completionHandler:^(BOOL finished) {
            
        }];
        
        [[[PushObject alloc] init] PushToViewAddItemsViewController:self->itemSpecificDueDatesArray itemsAlreadyChosenDict:nil userDict:nil optionSelectedString:@"SpecificDates" itemRepeats:self->itemRepeatsTextField.text viewingItemDetails:self->_viewingTask currentViewController:self];
        
    }]];
    
    imageString =
    [itemDueDateTextField.text containsString:@"No Due Date"] == NO &&
    [itemDueDateTextField.text containsString:[self GenerateTodaysDate:YES]] == NO &&
    [itemDueDateTextField.text containsString:[self GenerateTomorrowsDate:YES]] == NO &&
    [itemDueDateTextField.text containsString:[self GenerateEndOfWeeksDate:YES]] == NO &&
    [itemDueDateTextField.text containsString:[self GenerateStartOfNextWeeksDate:YES]] == NO &&
    [itemDueDateTextField.text containsString:[self GenerateEndOfMonthDate:YES]] == NO &&
    [itemDueDateTextField.text containsString:[self GenerateBeginningOfNextMonthDate:YES]] == NO &&
    [itemDueDateTextField.text containsString:@"Multiple Dates"] == NO &&
    [itemSpecificDueDatesArray count] == 0 ? @"checkmark" : @"";
    
    [customMenuActions addObject:[UIAction actionWithTitle:@"More Options" image:[UIImage systemImageNamed:imageString] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Custom Clicked For %@", self->itemType] completionHandler:^(BOOL finished) {
            
        }];
        
        NSMutableArray *selectedArray = [@[self->itemDueDateTextField.text] mutableCopy];
        
        if ([selectedArray containsObject:@"No Due Date"] ||
            [self->itemSpecificDueDatesArray count] > 0) {
            
            [selectedArray removeAllObjects];
            
        }
        
        [[[PushObject alloc] init] PushToViewAddItemsViewController:selectedArray itemsAlreadyChosenDict:nil userDict:nil optionSelectedString:@"DueDate" itemRepeats:self->itemRepeatsTextField.text viewingItemDetails:self->_viewingTask currentViewController:self];
        
    }]];
    
    UIMenu *neverInlineMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"1" options:UIMenuOptionsDisplayInline children:neverMenuActions];
    UIMenu *repeatingInlineMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"4" options:UIMenuOptionsDisplayInline children:repeatingMenuActions];
    //    UIMenu *multipleDatesInlineMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"4.1" options:UIMenuOptionsDisplayInline children:multipleDatesMenuActions];
    UIMenu *customInlineMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"5" options:UIMenuOptionsDisplayInline children:customMenuActions];
    
    [actions addObject:neverInlineMenu];
    [actions addObject:repeatingInlineMenu];
    //    [actions addObject:multipleDatesInlineMenu];
    [actions addObject:customInlineMenu];
    
    itemDueDateTextFieldOverlay.menu = [UIMenu menuWithTitle:@"" children:actions];
    itemDueDateTextFieldOverlay.showsMenuAsPrimaryAction = true;
    
}

-(void)SetUpEndDateContextMenu {
    
    [self BarButtonItems];
    
    NSMutableArray* actions = [[NSMutableArray alloc] init];
    NSMutableArray* endDateMenuActions = [[NSMutableArray alloc] init];
    NSMutableArray* neverMenuActions = [[NSMutableArray alloc] init];
    
    NSString *imageString = [itemPastDueTextField.text isEqualToString:@"On Specific Date"] ? @"checkmark" : @"";
    
    [endDateMenuActions addObject:[UIAction actionWithTitle:@"On Specific Date" image:[UIImage systemImageNamed:imageString] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:@"On Specific Date" completionHandler:^(BOOL finished) {
            
        }];
        
        [self->itemEndDateTextField becomeFirstResponder];
        
        [self SetUpEndDateContextMenu];
        
    }]];
    
    imageString = [itemPastDueTextField.text isEqualToString:@"After # of Times"] ? @"checkmark" : @"";
    
    [endDateMenuActions addObject:[UIAction actionWithTitle:@"After # of Times" image:[UIImage systemImageNamed:imageString] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:@"After # of Times" completionHandler:^(BOOL finished) {
            
        }];
        
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Enter the number of times until the task ends." message:nil
                                                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Subimt"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * _Nonnull action) {
            
            self->itemEndDateTextField.text = [NSString stringWithFormat:@"After %@ time%@", controller.textFields[0].text, [controller.textFields[0].text isEqualToString:@"1"] ? @"" : @"s"];
            
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                         style:UIAlertActionStyleCancel
                                                       handler:^(UIAlertAction * _Nonnull action) {}];
        
        
        
        [controller addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            
            textField.delegate = self;
            textField.placeholder = @"Number of times";
            textField.text = @"";
            textField.keyboardType = UIKeyboardTypeNumberPad;
            
        }];
        
        [controller addAction:action1];
        [controller addAction:cancel];
        [self presentViewController:controller animated:YES completion:nil];
        
        [self SetUpEndDateContextMenu];
        
    }]];
    
    imageString = [itemPastDueTextField.text isEqualToString:@"Never"] ? @"checkmark" : @"";
    
    [neverMenuActions addObject:[UIAction actionWithTitle:@"Never" image:[UIImage systemImageNamed:imageString] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Never End Date Clicked For %@", self->itemType] completionHandler:^(BOOL finished) {
            
        }];
        
        self->itemEndDateTextField.text = @"Never";
        
        [self SetUpEndDateContextMenu];
        
    }]];
    
    UIMenu *endDateInlineMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"3" options:UIMenuOptionsDisplayInline children:endDateMenuActions];
    UIMenu *neverInlineMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"4" options:UIMenuOptionsDisplayInline children:neverMenuActions];
    
    [actions addObject:endDateInlineMenu];
    [actions addObject:neverInlineMenu];
    
    itemEndDateTextFieldOverlay.menu = [UIMenu menuWithTitle:@"" children:actions];
    itemEndDateTextFieldOverlay.showsMenuAsPrimaryAction = true;
    
}

-(void)SetUpAlternateTurnsContextMenu {
    
    [self BarButtonItems];
    
    NSMutableArray* actions = [[NSMutableArray alloc] init];
    NSMutableArray* occurrenceMenuActions = [[NSMutableArray alloc] init];
    NSMutableArray* completionMenuActions = [[NSMutableArray alloc] init];
    NSMutableArray* alternateTurnsMenuActions = [[NSMutableArray alloc] init];
    NSMutableArray* customMenuActions = [[NSMutableArray alloc] init];
    
    NSString *imageString = [itemAlternateTurnsTextField.text isEqualToString:@"Every Occurrence"] ? @"checkmark" : @"";
    
    [occurrenceMenuActions addObject:[UIAction actionWithTitle:@"Every Occurrence" image:[UIImage systemImageNamed:imageString] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Every Occurrence Alternate Turns Clicked For %@", self->itemType] completionHandler:^(BOOL finished) {
            
        }];
        
        self->itemAlternateTurnsTextField.text = @"Every Occurrence";
        
        [self SetUpAlternateTurnsContextMenu];
        
    }]];
    
    imageString = [itemAlternateTurnsTextField.text isEqualToString:@"Every Completion"] ? @"checkmark" : @"";
    
    [completionMenuActions addObject:[UIAction actionWithTitle:@"Every Completion" image:[UIImage systemImageNamed:imageString] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Every Completion Alternate Turns Clicked For %@", self->itemType] completionHandler:^(BOOL finished) {
            
        }];
        
        self->itemAlternateTurnsTextField.text = @"Every Completion";
        
        [self SetUpAlternateTurnsContextMenu];
        
    }]];
    
    NSMutableArray *alternateTurnsArray = [NSMutableArray array];
    
    NSString *itemRepeatsTextFieldText = self->itemRepeatsTextField.text ? self->itemRepeatsTextField.text : @"";
    NSString *chosenItemRepeatIfCompletedEarlyLocal = chosenItemRepeatIfCompletedEarly ? chosenItemRepeatIfCompletedEarly : @"";
    
    BOOL TaskIsRepeating = [[[BoolDataObject alloc] init] TaskIsRepeating:[@{@"ItemRepeats" : itemRepeatsTextFieldText, @"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal} mutableCopy] itemType:itemType];
    BOOL TaskIsRepeatingDaily = [[[BoolDataObject alloc] init] TaskIsRepeatingDaily:[@{@"ItemRepeats" : itemRepeatsTextFieldText, @"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal} mutableCopy] itemType:itemType];
    BOOL TaskIsRepeatingWeekly = [[[BoolDataObject alloc] init] TaskIsRepeatingWeekly:[@{@"ItemRepeats" : itemRepeatsTextFieldText} mutableCopy] itemType:itemType];
    BOOL TaskIsRepeatingMonthly = [[[BoolDataObject alloc] init] TaskIsRepeatingMonthly:[@{@"ItemRepeats" : itemRepeatsTextFieldText} mutableCopy] itemType:itemType];
    
    if (TaskIsRepeating == NO || TaskIsRepeatingDaily == YES) {
        
        [alternateTurnsArray addObject:@"Every Day"];
        [alternateTurnsArray addObject:@"Every Week"];
        [alternateTurnsArray addObject:@"Every Other Week"];
        [alternateTurnsArray addObject:@"Every Month"];
        
    } else if (TaskIsRepeatingWeekly == YES) {
        
        [alternateTurnsArray addObject:@"Every Week"];
        [alternateTurnsArray addObject:@"Every Other Week"];
        [alternateTurnsArray addObject:@"Every Month"];
        
    } else if (TaskIsRepeatingMonthly == YES) {
        
        [alternateTurnsArray addObject:@"Every Month"];
        
    } else {
        
        alternateTurnsArray = [@[@"Every Day", @"Every Week", @"Every Other Week", @"Every Month"] mutableCopy];
    }
    
    for (NSString *alternateTurns in alternateTurnsArray) {
        
        imageString = [itemPastDueTextField.text isEqualToString:alternateTurns] ? @"checkmark" : @"";
        
        [alternateTurnsMenuActions addObject:[UIAction actionWithTitle:alternateTurns image:[UIImage systemImageNamed:imageString] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"%@ For %@", alternateTurns, self->itemType] completionHandler:^(BOOL finished) {
                
            }];
            
            self->itemAlternateTurnsTextField.text = alternateTurns;
            
            [self SetUpAlternateTurnsContextMenu];
            
        }]];
        
    }
    
    imageString =
    [alternateTurnsArray containsObject:itemAlternateTurnsTextField.text] == NO &&
    [itemAlternateTurnsTextField.text isEqualToString:@"Every Occurrence"] == NO &&
    [itemAlternateTurnsTextField.text isEqualToString:@"Every Completion"] == NO ? @"checkmark" : @"";
    
    [customMenuActions addObject:[UIAction actionWithTitle:@"More Options" image:[UIImage systemImageNamed:imageString] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Custom Alternate Turns Clicked For %@", self->itemType] completionHandler:^(BOOL finished) {
            
        }];
        
        [self TapGestureItemAlternateTurns:self];
        
        [self SetUpAlternateTurnsContextMenu];
        
    }]];
    
    BOOL TaskIsCompleteAsNeeded = [[self GenerateItemCompleteAsNeeded:itemRepeatsTextFieldText] isEqualToString:@"Yes"];
 
    UIMenu *occurrenceInlineMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"1" options:UIMenuOptionsDisplayInline children:occurrenceMenuActions];
    UIMenu *completionsInlineMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"1" options:UIMenuOptionsDisplayInline children:completionMenuActions];
//    UIMenu *alternateTurnsInlineMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"2" options:UIMenuOptionsDisplayInline children:alternateTurnsMenuActions];
    UIMenu *customInlineMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"2" options:UIMenuOptionsDisplayInline children:customMenuActions];
    
    if (TaskIsCompleteAsNeeded == NO) { [actions addObject:occurrenceInlineMenu]; }
    [actions addObject:completionsInlineMenu];
    [actions addObject:customInlineMenu];
    
    itemAlternateTurnsTextFieldOverlay.menu = [UIMenu menuWithTitle:@"" children:actions];
    itemAlternateTurnsTextFieldOverlay.showsMenuAsPrimaryAction = true;
    
}

-(void)SetUpPastDueContextMenu {
    
    [self BarButtonItems];
    
    NSMutableArray* actions = [[NSMutableArray alloc] init];
    NSMutableArray* neverMenuActions = [[NSMutableArray alloc] init];
    NSMutableArray* pastDueMenuActions = [[NSMutableArray alloc] init];
    NSMutableArray* untilCompletedMenuActions = [[NSMutableArray alloc] init];
    NSMutableArray* customMenuActions = [[NSMutableArray alloc] init];
    
    NSString *imageString = [itemPastDueTextField.text isEqualToString:@"Never"] ? @"checkmark" : @"";
    
    [neverMenuActions addObject:[UIAction actionWithTitle:@"Never" image:[UIImage systemImageNamed:imageString] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Never Past Due Clicked For %@", self->itemType] completionHandler:^(BOOL finished) {
            
        }];
        
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemPastDue" userInfo:@{@"PastDue" : @"Never"} locations:@[@"AddTask"]];
        
        [self SetUpPastDueContextMenu];
        
    }]];
    
    NSArray *pastDueArray = @[@"30 Minutes", @"2 Hours", @"2 Days", @"1 Week"];
    
    for (NSString *pastDue in pastDueArray) {
        
        imageString = [itemPastDueTextField.text isEqualToString:pastDue] ? @"checkmark" : @"";
        
        [pastDueMenuActions addObject:[UIAction actionWithTitle:pastDue image:[UIImage systemImageNamed:imageString] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"%@ For %@", pastDue, self->itemType] completionHandler:^(BOOL finished) {
                
            }];
            
            [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemPastDue" userInfo:@{@"PastDue" : pastDue} locations:@[@"AddTask"]];
            
            [self SetUpPastDueContextMenu];
            
        }]];
        
    }
    
    imageString = [itemPastDueTextField.text isEqualToString:@"Until Completed"] ? @"checkmark" : @"";
    
    [untilCompletedMenuActions addObject:[UIAction actionWithTitle:@"Until Completed" image:[UIImage systemImageNamed:imageString] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Until Completed For %@", self->itemType] completionHandler:^(BOOL finished) {
            
        }];
        
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemPastDue" userInfo:@{@"PastDue" : @"Until Completed"} locations:@[@"AddTask"]];
        
        self->itemPastDueTextField.text = @"Until Completed";
        
        [self SetUpPastDueContextMenu];
        
    }]];
    
    imageString = [pastDueArray containsObject:itemPastDueTextField.text] == NO && [itemPastDueTextField.text isEqualToString:@"Never"] == NO && [itemPastDueTextField.text isEqualToString:@"Until Completed"] == NO ? @"checkmark" : @"";
    
    [customMenuActions addObject:[UIAction actionWithTitle:@"More Options" image:[UIImage systemImageNamed:imageString] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Custom For %@", self->itemType] completionHandler:^(BOOL finished) {
            
        }];
        
        [self TapGestureItemPastDue:self];
        
        [self SetUpPastDueContextMenu];
        
    }]];
    
    UIMenu *neverInlineMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"1" options:UIMenuOptionsDisplayInline children:neverMenuActions];
    UIMenu *pastDueInlineMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"2" options:UIMenuOptionsDisplayInline children:pastDueMenuActions];
    UIMenu *untilCompletedInlineMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"3" options:UIMenuOptionsDisplayInline children:untilCompletedMenuActions];
    UIMenu *customInlineMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"4" options:UIMenuOptionsDisplayInline children:customMenuActions];
    
    [actions addObject:neverInlineMenu];
    [actions addObject:pastDueInlineMenu];
    [actions addObject:untilCompletedInlineMenu];
    [actions addObject:customInlineMenu];
    
    itemPastDueTextFieldOverlay.menu = [UIMenu menuWithTitle:@"" children:actions];
    itemPastDueTextFieldOverlay.showsMenuAsPrimaryAction = true;
    
}

-(void)SetUpDifficultyContextMenu {
    
    [self BarButtonItems];
    
    NSMutableArray* actions = [[NSMutableArray alloc] init];
    NSMutableArray* neverMenuActions = [[NSMutableArray alloc] init];
    NSMutableArray* difficultyMenuActions = [[NSMutableArray alloc] init];
    
    NSString *imageString = [itemDifficultyTextField.text isEqualToString:@"No Difficulty"] ? @"checkmark" : @"";
    
    [neverMenuActions addObject:[UIAction actionWithTitle:@"No Difficulty" image:[UIImage systemImageNamed:imageString] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"No Difficulty Difficulty Clicked For %@", self->itemType] completionHandler:^(BOOL finished) {
            
        }];
        
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemDifficulty" userInfo:@{@"Difficulty" : @"No Difficulty"} locations:@[@"AddTask"]];
        
        [self SetUpDifficultyContextMenu];
        
    }]];
    
    NSArray *difficultyArray = @[@"Easy", @"Medium", @"Hard"];
    
    for (NSString *difficultyLevel in difficultyArray) {
        
        imageString = [itemDifficultyTextField.text isEqualToString:difficultyLevel] ? @"checkmark" : @"";
        
        [difficultyMenuActions addObject:[UIAction actionWithTitle:difficultyLevel image:[UIImage systemImageNamed:imageString] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"%@ Difficulty Clicked For %@", difficultyLevel, self->itemType] completionHandler:^(BOOL finished) {
                
            }];
            
            [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemDifficulty" userInfo:@{@"Difficulty" : difficultyLevel} locations:@[@"AddTask"]];
            
            [self SetUpDifficultyContextMenu];
            
        }]];
        
    }
    
    UIMenu *neverInlineMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"1" options:UIMenuOptionsDisplayInline children:neverMenuActions];
    UIMenu *difficultyInlineMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"4" options:UIMenuOptionsDisplayInline children:difficultyMenuActions];
    
    [actions addObject:neverInlineMenu];
    [actions addObject:difficultyInlineMenu];
    
    itemDifficultyTextFieldOverlay.menu = [UIMenu menuWithTitle:@"" children:actions];
    itemDifficultyTextFieldOverlay.showsMenuAsPrimaryAction = true;
    
}

-(void)SetUpPriorityContextMenu {
    
    [self BarButtonItems];
    
    NSMutableArray* actions = [[NSMutableArray alloc] init];
    NSMutableArray* neverMenuActions = [[NSMutableArray alloc] init];
    NSMutableArray* priorityMenuActions = [[NSMutableArray alloc] init];
    
    NSString *imageString = [itemPriorityTextField.text isEqualToString:@"No Priority"] ? @"checkmark" : @"";
    
    [neverMenuActions addObject:[UIAction actionWithTitle:@"No Priority" image:[UIImage systemImageNamed:imageString] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"No Priority Clicked For %@", self->itemType] completionHandler:^(BOOL finished) {
            
        }];
        
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemPriority" userInfo:@{@"Priority" : @"No Priority"} locations:@[@"AddTask"]];
        
        [self SetUpPriorityContextMenu];
        
    }]];
    
    NSArray *priorityArray = @[@"Low", @"Medium", @"High"];
    
    for (NSString *priorityLevel in priorityArray) {
        
        imageString = [itemPriorityTextField.text isEqualToString:priorityLevel] ? @"checkmark" : @"";
        
        [priorityMenuActions addObject:[UIAction actionWithTitle:priorityLevel image:[UIImage systemImageNamed:imageString] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"%@ Priority Clicked For %@", priorityLevel, self->itemType] completionHandler:^(BOOL finished) {
                
            }];
            
            [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemPriority" userInfo:@{@"Priority" : priorityLevel} locations:@[@"AddTask"]];
            
            [self SetUpPriorityContextMenu];
            
        }]];
        
    }
    
    UIMenu *neverInlineMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"1" options:UIMenuOptionsDisplayInline children:neverMenuActions];
    UIMenu *priorityInlineMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"4" options:UIMenuOptionsDisplayInline children:priorityMenuActions];
    
    [actions addObject:neverInlineMenu];
    [actions addObject:priorityInlineMenu];
    
    itemPriorityTextFieldOverlay.menu = [UIMenu menuWithTitle:@"" children:actions];
    itemPriorityTextFieldOverlay.showsMenuAsPrimaryAction = true;
    
}

-(void)SetUpAddPhotoContextMenu {
    
    [self BarButtonItems];
    
    addPhotoViewOverlay = [[UIButton alloc] initWithFrame:CGRectMake(addImageImage.frame.origin.x - 10, addImageImage.frame.origin.y - 10, addImageImage.frame.size.width + 20, addImageImage.frame.size.height + 20)];
    [itemNameView addSubview:addPhotoViewOverlay];
    
    NSMutableArray* actions = [[NSMutableArray alloc] init];
    NSMutableArray* noPhotoActions = [[NSMutableArray alloc] init];
    
    [actions addObject:[UIAction actionWithTitle:@"Camera" image:[UIImage systemImageNamed:@"camera"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Camera Clicked For %@", self->itemType] completionHandler:^(BOOL finished) {
            
        }];
        
        [self StartProgressView];
        
        [self openCamera];
        
        [self DismissAllKeyboards:NO];
        
    }]];
    
    [actions addObject:[UIAction actionWithTitle:@"Photo Library" image:[UIImage systemImageNamed:@"photo.on.rectangle"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Photo Library For %@", self->itemType] completionHandler:^(BOOL finished) {
            
        }];
        
        [self StartProgressView];
        
        [self openPhotoLibrary];
        
        [self DismissAllKeyboards:NO];
        
    }]];
    
    UIAction *noPhotoAction = [UIAction actionWithTitle:@"No Photo" image:[UIImage systemImageNamed:@"nosign"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"No Photo Clicked For %@", self->itemType] completionHandler:^(BOOL finished) {
            
        }];
        
        self->addImageImage.image = [UIImage systemImageNamed:@"camera.viewfinder"];
        
        [self DismissAllKeyboards:NO];
        
    }];
    
    [noPhotoAction setAttributes:UIMenuElementAttributesDestructive];
    
    [noPhotoActions addObject:noPhotoAction];
    
    UIMenu *noPhotoMenuActions = [UIMenu menuWithTitle:@"" image:nil identifier:@"" options:UIMenuOptionsDisplayInline children:noPhotoActions];
    
    [actions addObject:noPhotoMenuActions];
    
    addPhotoViewOverlay.menu = [UIMenu menuWithTitle:@"" children:actions];
    addPhotoViewOverlay.showsMenuAsPrimaryAction = true;
    
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
    topViewCover.showsMenuAsPrimaryAction = _viewingTask == NO ? true : false;
    
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

-(void)SetUpDefaultTemplate {
    
    if (_editingTask == NO) {
        
        NSString *templateNameString = @"";
        
        for (NSString *templateName in _templateDict[@"TemplateName"]) {
            
            NSUInteger outerIndex = [_templateDict[@"TemplateName"] indexOfObject:templateName];
            
            if ([_templateDict[@"TemplateDefault"][outerIndex] isEqualToString:@"Yes"]) {
                
                templateNameString = templateName;
                break;
                
            }
        }
        
        if ([templateNameString length] > 0) {
            
            self->selectedTemplate = templateNameString;
            [self SelectTemplate:self templateName:templateNameString];
            [self BarButtonItems];
            
        }
        
    }
    
}

#pragma mark - BOOL Methods

-(BOOL)DisplayDaysView {
    
    NSString *itemRepeatsTextFieldText = self->itemRepeatsTextField.text ? self->itemRepeatsTextField.text : @"";
    NSString *chosenItemRepeatIfCompletedEarlyLocal = chosenItemRepeatIfCompletedEarly ? chosenItemRepeatIfCompletedEarly : @"";
    
    BOOL TaskIsRepeating = [[[BoolDataObject alloc] init] TaskIsRepeating:[@{@"ItemRepeats" : itemRepeatsTextFieldText, @"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal} mutableCopy] itemType:itemType];
    BOOL TaskIsRepeatingHourly = [[[BoolDataObject alloc] init] TaskIsRepeatingHourly:[@{@"ItemRepeats" : itemRepeatsTextFieldText, @"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal} mutableCopy] itemType:itemType];
    BOOL TaskIsRepeatingDaily = [[[BoolDataObject alloc] init] TaskIsRepeatingDaily:[@{@"ItemRepeats" : itemRepeatsTextFieldText, @"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal} mutableCopy] itemType:itemType];
    
    BOOL TaskIsRepeatingAsNeeded = [[[BoolDataObject alloc] init] TaskIsRepeatingAsNeeded:[@{@"ItemRepeats" : itemRepeatsTextFieldText, @"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal} mutableCopy] itemType:itemType];
    
    return
    (TaskIsRepeating == YES)
    && TaskIsRepeatingHourly == NO
    && TaskIsRepeatingDaily == NO
    && TaskIsRepeatingAsNeeded == NO;
    
}

-(BOOL)DisplayAmountView {
    
    return self->_viewingAddExpenseViewController == YES;
    
}

-(BOOL)DisplaySubtaskView {
    
    return self->_viewingAddListViewController == NO && self->_viewingAddExpenseViewController == NO;
    
}

-(BOOL)DisplayListItemsView {
    
    return self->_viewingAddListViewController == YES;
    
}

-(BOOL)DisplayTakeTurnsView {
    
    NSString *itemAssignedToTextFieldText = self->itemAssignedToTextField.text ? self->itemAssignedToTextField.text : @"";
    NSString *itemRepeatsTextFieldText = self->itemRepeatsTextField.text ? self->itemRepeatsTextField.text : @"";
    NSString *chosenItemRepeatIfCompletedEarlyLocal = chosenItemRepeatIfCompletedEarly ? chosenItemRepeatIfCompletedEarly : @"";
    
    BOOL TaskIsRepeating = [[[BoolDataObject alloc] init] TaskIsRepeating:[@{@"ItemRepeats" : itemRepeatsTextFieldText, @"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal} mutableCopy] itemType:itemType];
    BOOL TaskIsRepeatingAsNeeded = [[[BoolDataObject alloc] init] TaskIsRepeatingAsNeeded:[@{@"ItemRepeats" : itemRepeatsTextFieldText, @"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal} mutableCopy] itemType:itemType];
    
    return
    ((TaskIsRepeating == YES)
     && [itemAssignedToTextFieldText isEqualToString:@""] == NO
     && [itemAssignedToTextFieldText isEqualToString:@"Nobody"] == NO)
    || TaskIsRepeatingAsNeeded == YES;
    
}


-(BOOL)DisplayMustCompleteView {
    
    NSString *itemRepeatsTextFieldText = self->itemRepeatsTextField.text ? self->itemRepeatsTextField.text : @"";
    NSString *itemAssignedToTextFieldText = self->itemAssignedToTextField.text ? self->itemAssignedToTextField.text : @"";
    NSString *chosenItemRepeatIfCompletedEarlyLocal = chosenItemRepeatIfCompletedEarly ? chosenItemRepeatIfCompletedEarly : @"";
    
    BOOL TaskAssignToNewHomeMembers = [chosenItemAssignedToNewHomeMembers isEqualToString:@"Yes"];
    BOOL TaskIsRepeatingAsNeeded = [[[BoolDataObject alloc] init] TaskIsRepeatingAsNeeded:[@{@"ItemRepeats" : itemRepeatsTextFieldText, @"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal} mutableCopy] itemType:itemType];
  
    BOOL MustCompleteShouldShow =
    ([[self GenerateItemAssignedTo:@"No"] count] != 1 || [itemAssignedToTextFieldText isEqualToString:@"Anybody"] || TaskAssignToNewHomeMembers == YES) &&
    self->_viewingAddExpenseViewController == NO &&
    self->_viewingAddListViewController == NO &&
    [self->itemEveryoneTakesTurnsSwitch isOn] == NO &&
    TaskIsRepeatingAsNeeded == NO;
    
    
    
    return MustCompleteShouldShow;
}

-(BOOL)DisplayCostPerPersonView {
    
    return self->_viewingAddExpenseViewController == YES;
    
}

-(BOOL)DisplayPaymentMethodView {
    
    return self->_viewingAddExpenseViewController == YES;
    
}

-(BOOL)DisplaySpecificTurnOrderView {
    
    //    BOOL TaskIsAssignedToMoreThanOnePerson = [[self GenerateItemAssignedTo:@"No"] count] != 1;
    //    BOOL TaskIsAssignedToNobody = [[self GenerateItemAssignedTo:@"No"] count] == 0;
    BOOL TaskIsTakingTurns = [itemEveryoneTakesTurnsSwitch isOn];
    
    return /*(TaskIsAssignedToNobody == NO && TaskIsAssignedToMoreThanOnePerson == YES &&*/ TaskIsTakingTurns == YES/*)*/;
    
}

#pragma mark - UI Methods

-(void)GenerateNewUserInfoView {
    
    BOOL NewNewUserInfoViewWasDismissede = [[[NSUserDefaults standardUserDefaults] objectForKey:@"NewUserInfoViewWasDismissed"] isEqualToString:@"Yes"];
    
    CGFloat height = CGRectGetHeight(self.view.bounds);
    CGFloat width = CGRectGetWidth(self.view.bounds);
    
    CGFloat textFieldSpacing = (height*0.024456);
    
    newUserInfoView = [[UIView alloc] initWithFrame:CGRectMake(textFieldSpacing, 0, (width*1 - (textFieldSpacing*2)), (height*0.07496 > 50?50:(height*0.07496)))];
    newUserInfoView.backgroundColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModePrimary] : [UIColor colorWithRed:228.0f/255.0f green:231.0f/255.0f blue:236.0f/255.0f alpha:1.0f];
    newUserInfoView.layer.cornerRadius = newUserInfoView.frame.size.height*0.24;
    newUserInfoView.hidden = _viewingMoreOptions || NewNewUserInfoViewWasDismissede;
    
    height = CGRectGetHeight(newUserInfoView.bounds);
    width = CGRectGetWidth(newUserInfoView.bounds);
    
    UIImageView *infoViewInfoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, newUserInfoView.frame.size.height*0.5 - (newUserInfoView.frame.size.height*0.45)*0.5, newUserInfoView.frame.size.height*0.45, newUserInfoView.frame.size.height*0.45)];
    infoViewInfoImageView.image = [UIImage imageNamed:@"AddItemIcon.InfoButton"];
    [newUserInfoView addSubview:infoViewInfoImageView];
    
    UILabel *infoViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(12 + newUserInfoView.frame.size.height*0.45 + 12, 0, newUserInfoView.frame.size.width - (12 + (newUserInfoView.frame.size.height*0.45) + 12) - (12 + (newUserInfoView.frame.size.height*0.35) + 12), newUserInfoView.frame.size.height)];
    infoViewLabel.text = [NSString stringWithFormat:@"More options will be made visible to you as you create your %@.", [itemType lowercaseString]];
    infoViewLabel.textColor = [UIColor blackColor];
    infoViewLabel.font = [UIFont systemFontOfSize:infoViewLabel.frame.size.height*0.28 weight:UIFontWeightSemibold];
    infoViewLabel.textAlignment = NSTextAlignmentLeft;
    infoViewLabel.numberOfLines = 0;
    infoViewLabel.textColor = [UIColor colorWithRed:55.0f/255.0f green:81.0f/255.0f blue:101.0f/255.0f alpha:0.85];
    [newUserInfoView addSubview:infoViewLabel];
    
    UIImageView *infoViewXImageView = [[UIImageView alloc] initWithFrame:CGRectMake(newUserInfoView.frame.size.width - newUserInfoView.frame.size.height*0.35 - 12, newUserInfoView.frame.size.height*0.5 - (newUserInfoView.frame.size.height*0.35)*0.5, newUserInfoView.frame.size.height*0.35, newUserInfoView.frame.size.height*0.35)];
    infoViewXImageView.image = [UIImage imageNamed:@"AddTaskViewIcons.XMark.png"];
    infoViewXImageView.alpha = 0.65f;
    [newUserInfoView addSubview:infoViewXImageView];
    
    UIButton *infoViewXImageViewCover = [[UIButton alloc] initWithFrame:CGRectMake(infoViewXImageView.frame.origin.x - 20, 0, infoViewXImageView.frame.size.width + 40, height)];
    infoViewXImageViewCover.userInteractionEnabled = YES;
    [infoViewXImageViewCover addTarget:self action:@selector(TapGestureCloseNewUserInfoView:) forControlEvents:UIControlEventTouchUpInside];
    [newUserInfoView addSubview:infoViewXImageViewCover];
    
    [self->_customScrollView addSubview:newUserInfoView];
    
}

-(void)StartProgressView {
    
    self->progressView = [MRProgressOverlayView showOverlayAddedTo:self.navigationController.view animated:YES];
    self->progressView.mode = MRProgressOverlayViewModeIndeterminateSmall;
    
}

-(void)DismissAllKeyboards:(BOOL)Scrolling {
    
    NSArray *textFieldArr = @[
        
        itemNameTextField,
        itemAssignedToTextField,
        itemMustCompleteTextField,
        itemAmountTextField,
        itemCostPerPersonTextField,
        itemPaymentMethodTextField,
        itemListItemsTextField,
        itemRepeatsTextField,
        itemDueDateTextField,
        itemStartDateTextField,
        itemEndDateTextField,
        itemDaysTextField,
        itemTimeTextField,
        itemTurnOrderTextField,
        itemGracePeriodTextField,
        itemSubTasksTextField,
        itemReminderTextField,
        itemDifficultyTextField,
        itemPriorityTextField,
        
    ];
    
    for (UITextField *textField in textFieldArr) {
        
        [textField resignFirstResponder];
        
    }
    
    if (Scrolling == NO) {
        
        [itemNotesTextField resignFirstResponder];
        
    }
    
}

-(void)UpdateTopViewLabel:(NSString *)topViewLabelString {
    
    topViewLabel.text = topViewLabelString;
    
    CGRect newRect;
    
    newRect = topViewLabel.frame;
    newRect.size.width = [[[GeneralObject alloc] init] WidthOfString:topViewLabelString withFont:topViewLabel.font];
    topViewLabel.frame = newRect;
    
    newRect = topView.frame;
    newRect.size.width = topViewLabel.frame.size.width + 4 + topViewImageView.frame.size.width;
    newRect.origin.x = self.view.frame.size.width*0.5 - (newRect.size.width*0.5);
    topView.frame = newRect;
    
    newRect = topViewImageView.frame;
    newRect.origin.x = topView.frame.size.width - newRect.size.width;
    topViewImageView.frame = newRect;
    
    newRect = topViewCover.frame;
    newRect = topView.frame;
    newRect.size.width = topViewLabel.frame.size.width + topViewImageView.frame.size.width;
    topViewCover.frame = newRect;
    
    [self SetUpTopLabelContextMenu];
    
}

#pragma mark

-(void)AdjustTextFieldFramesToUse:(NSTimeInterval)interval {
    
    if (_viewingAddExpenseViewController == YES) {
        
        [self AdjustTextFieldFramesExpenses:interval];
        
    } else if (_viewingAddListViewController == YES) {
        
        [self AdjustTextFieldFramesLists:interval];
        
    } else {
        
        [self AdjustTextFieldFramesChores:interval];
        
    }
    
}

-(void)GenerateNotesViewFrames {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self->itemNotesTextField.frame.origin.x, self->itemNotesTextField.frame.origin.y, self->itemNotesTextField.frame.size.width, 35)];
    label.text = self->itemNotesTextField.text;
    NSInteger numberOfLines = [[[GeneralObject alloc] init] LineCountForText:label.text label:label];
    
    if (numberOfLines < 1) {
        numberOfLines = 1;
    } else if (numberOfLines > 3) {
        numberOfLines = 3;
    }
    
    long textFieldHeight = 35;
    
    if (numberOfLines == 2) {
        textFieldHeight = numberOfLines*25;
    } else if (numberOfLines == 3) {
        textFieldHeight = numberOfLines*22.5;
    } else if (numberOfLines > 3) {
        textFieldHeight = numberOfLines*20;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        
        CGRect newRect = self->itemNotesView.frame;
        newRect.size.height = numberOfLines > 1 ? textFieldHeight + 12 : (self.view.frame.size.height*0.07472826 > 55?55:(self.view.frame.size.height*0.07472826));
        self->itemNotesView.frame = newRect;
        
        newRect = self->itemNotesTextField.frame;
        newRect.size.height = textFieldHeight;//numberOfLines > 1 ? 20*numberOfLines : 35;
        newRect.origin.y = self->itemNotesView.frame.size.height*0.5 - newRect.size.height*0.5;
        self->itemNotesTextField.frame = newRect;
        
    } completion:^(BOOL finished) {
        
    }];
    
}

-(void)AdjustTextFieldFramesChores:(NSTimeInterval)interval {
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    CGFloat bottomPadding = [[[GeneralObject alloc] init] GetBottomPaddingHeight];
    
    CGFloat textFieldSpacing = (height*0.024456);
    
    NSString *itemDueDateTextFieldText = self->itemDueDateTextField.text ? self->itemDueDateTextField.text : @"";
    NSString *itemAssignedToTextFieldText = self->itemAssignedToTextField.text ? self->itemAssignedToTextField.text : @"";
    NSString *itemDaysTextFieldText = self->itemDaysTextField.text ? self->itemDaysTextField.text : @"";
    NSString *itemRepeatsTextFieldText = self->itemRepeatsTextField.text ? self->itemRepeatsTextField.text : @"";
    NSString *chosenItemRepeatIfCompletedEarlyLocal = chosenItemRepeatIfCompletedEarly ? chosenItemRepeatIfCompletedEarly : @"";
    NSMutableArray *itemSpecificDueDatesArrayLocal = itemSpecificDueDatesArray ? itemSpecificDueDatesArray : [NSMutableArray array];
    
    BOOL TaskHasMultipleDueDate =  [[[BoolDataObject alloc] init] TaskHasMultipleDueDate:[@{@"ItemSpecificDueDates" : itemSpecificDueDatesArrayLocal, @"ItemRepeats" : itemRepeatsTextFieldText, @"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal} mutableCopy] itemType:itemType];
    BOOL TaskHasNoDueDate = [[[BoolDataObject alloc] init] TaskHasNoDueDate:[@{@"ItemDueDate" : itemDueDateTextFieldText, @"ItemSpecificDueDates" : itemSpecificDueDatesArrayLocal, @"ItemRepeats" : itemRepeatsTextFieldText, @"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal} mutableCopy] itemType:itemType];
    BOOL TaskIsRepeating = [[[BoolDataObject alloc] init] TaskIsRepeating:[@{@"ItemRepeats" : itemRepeatsTextFieldText, @"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal} mutableCopy] itemType:itemType];
    BOOL TaskIsRepeatingAsNeeded = [[[BoolDataObject alloc] init] TaskIsRepeatingAsNeeded:[@{@"ItemRepeats" : itemRepeatsTextFieldText, @"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal} mutableCopy] itemType:itemType];
    BOOL TaskIsTakingTurns = [itemEveryoneTakesTurnsSwitch isOn];
    BOOL TaskAssignToNewHomeMembers = chosenItemAssignedToNewHomeMembers && [chosenItemAssignedToNewHomeMembers isEqualToString:@"Yes"];
    BOOL TaskIsRepeatingHourly = [[[BoolDataObject alloc] init] TaskIsRepeatingHourly:[@{@"ItemRepeats" : itemRepeatsTextFieldText} mutableCopy] itemType:itemType];
    BOOL TaskIsRepeatingWeekly = [[[BoolDataObject alloc] init] TaskIsRepeatingWeekly:[@{@"ItemRepeats" : itemRepeatsTextFieldText} mutableCopy] itemType:itemType];
    BOOL TaskIsRepeatingMonthly = [[[BoolDataObject alloc] init] TaskIsRepeatingMonthly:[@{@"ItemRepeats" : itemRepeatsTextFieldText} mutableCopy] itemType:itemType];
    BOOL TaskIsRepeatingWhenCompleted = [[[BoolDataObject alloc] init] TaskIsRepeatingWhenCompleted:[@{@"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal ? chosenItemRepeatIfCompletedEarlyLocal : @"No", @"ItemRepeats" : itemRepeatsTextFieldText} mutableCopy] itemType:itemType];
    BOOL TaskIsAssignedToMoreThanOnePerson = [[self GenerateItemAssignedTo:@"No"] count] != 1;
    BOOL TaskIsAssignedToNobody = [[self GenerateItemAssignedTo:@"No"] count] == 0;
    BOOL TaskIsAssignedToAnybody = [itemAssignedToTextFieldText isEqualToString:@"Anybody"];
    
    itemAmountView.hidden = YES;
    itemCostPerPersonView.hidden = YES;
    itemPaymentMethodView.hidden = YES;
    itemListItemsView.hidden = YES;
    
    NSArray *viewBackgroundColorArr = @[
        
        itemNameView,
        itemAssignedToView,
        itemMustCompleteView,
        itemAmountView,
        itemCostPerPersonView,
        itemPaymentMethodView,
        itemListItemsView,
        itemRepeatsView,
        itemDueDateView,
        itemRepeatIfCompletedEarlyView,
        itemStartDateView,
        itemEndDateView,
        itemDaysView,
        itemTimeView,
        itemEveryoneTakesTurnsView,
        itemAlternateTurnsView,
        itemTurnOrderView,
        itemGracePeriodView,
        itemSubTasksView,
        itemReminderView,
        itemDifficultyView,
        itemPriorityView,
        itemTagsView,
        itemColorView,
        itemPrivateView,
        itemRewardView,
        itemPastDueView,
        
    ];
    
    [self ViewAlpha:viewBackgroundColorArr];
    
    if (TaskIsRepeating == NO) {
        
        self->itemRepeatIfCompletedEarlyView.alpha = 0.0f;
        self->itemStartDateView.alpha = 0.0f;
        self->itemEndDateView.alpha = 0.0f;
        self->itemDaysView.alpha = 0.0f;
        
        if (TaskIsRepeatingAsNeeded == YES) {
            
            self->itemDueDateView.alpha = 0.0f;
            
        }
        
        if ((TaskIsAssignedToMoreThanOnePerson == NO && TaskIsAssignedToAnybody == NO) || TaskIsRepeatingAsNeeded == YES || TaskIsTakingTurns == YES) {
            
            self->itemMustCompleteView.alpha = 0.0f;
            
        }
        
        if (/*TaskIsAssignedToNobody == YES || TaskIsAssignedToMoreThanOnePerson == NO ||*/ TaskIsTakingTurns == NO) {
            
            self->itemTurnOrderView.alpha = 0.0f;
            
        }
        
        if (TaskIsRepeatingAsNeeded == NO) {
            
            self->itemEveryoneTakesTurnsView.alpha = 0.0f;
            
        }
        
        if (TaskIsTakingTurns == NO) {
            
            self->itemAlternateTurnsView.alpha = 0.0f;
            
        }
        
        if (TaskHasNoDueDate == YES || TaskHasMultipleDueDate == YES || TaskIsRepeatingAsNeeded == YES || TaskIsRepeatingWhenCompleted == YES) {
            
            self->itemTimeView.alpha = 0.0f;
            
        }
        
        if ((TaskHasNoDueDate == YES && TaskIsRepeating == NO) || TaskIsRepeatingAsNeeded == YES || TaskIsRepeatingWhenCompleted == YES) {
            
            self->itemReminderView.alpha = 0.0f;
            
        }
        
    } else {
        
        self->itemDueDateView.alpha = 0.0f;
        
        if ((TaskIsAssignedToMoreThanOnePerson == NO && TaskAssignToNewHomeMembers == NO && TaskIsAssignedToAnybody == NO) || TaskIsRepeatingAsNeeded == YES || TaskIsTakingTurns == YES) {
            
            self->itemMustCompleteView.alpha = 0.0f;
            
        }
        
        if (/*TaskIsAssignedToNobody == YES || TaskIsAssignedToMoreThanOnePerson == NO ||*/ TaskIsTakingTurns == NO) {
            
            self->itemTurnOrderView.alpha = 0.0f;
            
        }
        
        if (TaskIsRepeatingHourly == YES) {
            
            self->itemTimeView.alpha = 0.0f;
        }
        
        if (TaskIsRepeatingWeekly == NO && TaskIsRepeatingMonthly == NO) {
            
            self->itemDaysView.alpha = 0.0f;
            
        }
        
        if (TaskIsAssignedToNobody == YES) {
            
            self->itemEveryoneTakesTurnsView.alpha = 0.0f;
            
        }
        
        if (TaskIsTakingTurns == NO) {
            
            self->itemAlternateTurnsView.alpha = 0.0f;
            
        }
        
        if (((TaskIsRepeatingWeekly == YES || TaskIsRepeatingMonthly == YES) && [itemDaysTextFieldText containsString:@"Any Day"]) ||
            (TaskIsRepeating == NO) ||
            (TaskIsRepeatingHourly == YES) ||
            TaskIsRepeatingAsNeeded == YES ||
            TaskIsRepeatingWhenCompleted == YES) {
            
            self->itemTimeView.alpha = 0.0f;
            
        }
        
        if ((TaskHasNoDueDate == YES && TaskIsRepeating == NO) || TaskIsRepeatingAsNeeded == YES || TaskIsRepeatingWhenCompleted == YES) {
            
            self->itemReminderView.alpha = 0.0f;
            
        }
        
        if (TaskIsRepeatingAsNeeded == YES || TaskIsRepeatingWhenCompleted == YES) {
            
            self->itemRepeatIfCompletedEarlyView.alpha = 0.0f;
            self->itemStartDateView.alpha = 0.0f;
            self->itemEndDateView.alpha = 0.0f;
            
        }
        
    }
    
    [UIView animateWithDuration:interval animations:^{
        
        
        
        CGFloat repeatsViewX = textFieldSpacing;
        CGFloat repeatsViewWidth = (width*1 - (textFieldSpacing*2));
        
        
        
        
        CGFloat navigationBarHeight = [[[GeneralObject alloc] init] GetNavigationBarHeight:self];
        
        
        
        CGFloat itemNameRect = self->newUserInfoView.hidden == NO ? self->newUserInfoView.frame.origin.y + self->newUserInfoView.frame.size.height + textFieldSpacing : textFieldSpacing;
        
        self->itemNameView.frame = CGRectMake(textFieldSpacing, itemNameRect, (width*1 - (textFieldSpacing*2)), (self.view.frame.size.height*0.07472826 > 55?55:(self.view.frame.size.height*0.07472826)));
        self->itemNotesView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemNameView.frame.origin.y + self->itemNameView.frame.size.height, self->itemNameView.frame.size.width, (self.view.frame.size.height*0.07472826 > 55?55:(self.view.frame.size.height*0.07472826)));
        
        [self GenerateNotesViewFrames];
        
        
        
        CGFloat cornerRadius = (self.view.frame.size.height*0.2181818182 > 12?12:(self.view.frame.size.height*0.2181818182));
        [[[GeneralObject alloc] init] RoundingCorners:self->itemNameView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
        [[[GeneralObject alloc] init] RoundingCorners:self->itemNotesView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
        
        
        
        
        self->itemAssignedToView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemNotesView.frame.origin.y + self->itemNotesView.frame.size.height + textFieldSpacing, self->itemNameView.frame.size.width, self->itemNameView.frame.size.height);
        
        
        
        
        CGRect completedByViewRect = CGRectMake(textFieldSpacing, self->itemAssignedToView.frame.origin.y + self->itemAssignedToView.frame.size.height, (width*1 - (textFieldSpacing*2)), (self->itemNameView.frame.size.height));
        BOOL DisplayCompletedByView = [self DisplayMustCompleteView];
        self->itemMustCompleteView.frame = DisplayCompletedByView == YES ? completedByViewRect : CGRectMake(self->itemNameView.frame.origin.x, self->itemAssignedToView.frame.origin.y + self->itemAssignedToView.frame.size.height, self->itemNameView.frame.size.width, self->itemNameView.frame.size.height);
        
        
        
        
        self->itemDaysView.frame = self->itemMustCompleteView.frame;
        self->itemTimeView.frame = self->itemMustCompleteView.frame;
        self->itemEveryoneTakesTurnsView.frame = self->itemMustCompleteView.frame;
        
        
        
        
        CGFloat width;
        CGFloat height;
        
        
        
        
        if (TaskIsRepeating == NO) {
            
            
            CGFloat yPos = 0;
            
            if (TaskIsAssignedToMoreThanOnePerson == NO && TaskIsRepeatingAsNeeded == NO && TaskIsTakingTurns == NO) {
                yPos = self->itemAssignedToView.frame.origin.y + self->itemAssignedToView.frame.size.height;
            } else if (TaskIsAssignedToMoreThanOnePerson == YES && TaskIsRepeatingAsNeeded == NO && TaskIsTakingTurns == NO) {
                yPos = self->itemMustCompleteView.frame.origin.y + self->itemMustCompleteView.frame.size.height + textFieldSpacing;
            } else if (TaskIsAssignedToMoreThanOnePerson == NO && TaskIsRepeatingAsNeeded == YES && TaskIsTakingTurns == NO) {
                yPos = self->itemAssignedToView.frame.origin.y + self->itemAssignedToView.frame.size.height;
            } else if (TaskIsAssignedToMoreThanOnePerson == NO && TaskIsRepeatingAsNeeded == YES && TaskIsTakingTurns == YES) {
                yPos = self->itemAssignedToView.frame.origin.y + self->itemAssignedToView.frame.size.height;
            } else if (TaskIsAssignedToMoreThanOnePerson == YES && TaskIsRepeatingAsNeeded == YES && TaskIsTakingTurns == NO) {
                yPos = self->itemAssignedToView.frame.origin.y + self->itemAssignedToView.frame.size.height;
            } else if (TaskIsAssignedToMoreThanOnePerson == YES && TaskIsRepeatingAsNeeded == YES && TaskIsTakingTurns == YES) {
                yPos = self->itemTurnOrderView.frame.origin.y + self->itemTurnOrderView.frame.size.height + textFieldSpacing;
            }
            
            self->itemRepeatsView.frame = CGRectMake(repeatsViewX, yPos, self->itemNameView.frame.size.width, self->itemNameView.frame.size.height);
            
            
            
            
            width = CGRectGetWidth(self.view.bounds);
            height = CGRectGetHeight(self.view.bounds);
            
            self->itemRepeatIfCompletedEarlyView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemRepeatsView.frame.origin.y, self->itemNameView.frame.size.width, (self->itemNameView.frame.size.height));
            
            self->itemStartDateView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemRepeatsView.frame.origin.y, self->itemNameView.frame.size.width, (self->itemNameView.frame.size.height));
            
            self->itemEndDateView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemRepeatsView.frame.origin.y, self->itemNameView.frame.size.width, (self->itemNameView.frame.size.height));
            
            self->itemDaysView.frame = self->itemEndDateView.frame;
            self->itemTimeView.frame = self->itemEndDateView.frame;
            self->itemEveryoneTakesTurnsView.frame = self->itemEndDateView.frame;
            
            yPos = TaskIsRepeatingAsNeeded == YES ? self->itemRepeatsView.frame.origin.y : self->itemRepeatsView.frame.origin.y + self->itemRepeatsView.frame.size.height;
            self->itemDueDateView.frame = CGRectMake(self->itemNameView.frame.origin.x, yPos, (width*1 - (textFieldSpacing*2)), (self->itemNameView.frame.size.height));
            
            yPos = TaskHasNoDueDate == YES || TaskHasMultipleDueDate == YES ? self->itemDueDateView.frame.origin.y : self->itemDueDateView.frame.origin.y + self->itemDueDateView.frame.size.height;
            self->itemTimeView.frame = CGRectMake(self->itemNameView.frame.origin.x, yPos, (width*1 - (textFieldSpacing*2)), (self->itemNameView.frame.size.height));
            
            
            
            
            if (TaskIsRepeatingAsNeeded == YES) {
                
                self->itemEveryoneTakesTurnsView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemTimeView.frame.origin.y + self->itemTimeView.frame.size.height + textFieldSpacing, (width*1 - (textFieldSpacing*2)), (self->itemNameView.frame.size.height));
                
                self->itemAlternateTurnsView.frame = TaskIsTakingTurns == YES ? CGRectMake(self->itemNameView.frame.origin.x, self->itemEveryoneTakesTurnsView.frame.origin.y + self->itemEveryoneTakesTurnsView.frame.size.height, (width*1 - (textFieldSpacing*2)), (self->itemNameView.frame.size.height)) : self->itemEveryoneTakesTurnsView.frame;
                
                CGRect assignedToViewRect = CGRectMake(textFieldSpacing, self->itemAlternateTurnsView.frame.origin.y + self->itemAlternateTurnsView.frame.size.height, (width*1 - (textFieldSpacing*2)), (self->itemNameView.frame.size.height));
                BOOL DisplaySpecificTurnOrderView = [self DisplaySpecificTurnOrderView];
                self->itemTurnOrderView.frame = DisplaySpecificTurnOrderView == YES ? assignedToViewRect : self->itemAlternateTurnsView.frame;
                
            }
            
            
            
            
        } else {
            
            
            
            
            //            self->itemDaysView.hidden = NO;
            //            self->itemTimeView.hidden = NO;
            
            
            
            
            BOOL DisplaySpecificTurnOrderView = [self DisplaySpecificTurnOrderView];
            BOOL DisplayCompletedByView = [self DisplayMustCompleteView];
            
            if (DisplayCompletedByView) {
                self->itemRepeatsView.frame = CGRectMake(repeatsViewX, self->itemMustCompleteView.frame.origin.y + self->itemMustCompleteView.frame.size.height + textFieldSpacing, (self.view.frame.size.width*1 - (textFieldSpacing*2)), (self->itemNameView.frame.size.height));
            } else {
                self->itemRepeatsView.frame = CGRectMake(repeatsViewX, self->itemAssignedToView.frame.origin.y + self->itemAssignedToView.frame.size.height, (self.view.frame.size.width*1 - (textFieldSpacing*2)), (self->itemNameView.frame.size.height));
            }
            
            
            width = CGRectGetWidth(self.view.bounds);
            height = CGRectGetHeight(self.view.bounds);
            
            
            CGFloat yPos = TaskIsRepeating == YES || TaskIsRepeatingAsNeeded == YES ? self->itemRepeatsView.frame.origin.y : self->itemRepeatsView.frame.origin.y + self->itemRepeatsView.frame.size.height;
            self->itemDueDateView.frame = CGRectMake(self->itemNameView.frame.origin.x, yPos, (width*1 - (textFieldSpacing*2)), (self->itemNameView.frame.size.height));
            
            
            self->itemRepeatIfCompletedEarlyView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemRepeatsView.frame.origin.y + self->itemRepeatsView.frame.size.height, self->itemNameView.frame.size.width, (self->itemNameView.frame.size.height));
            
            
            self->itemStartDateView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemRepeatIfCompletedEarlyView.frame.origin.y + self->itemRepeatIfCompletedEarlyView.frame.size.height, (width*1 - (textFieldSpacing*2)), (self->itemNameView.frame.size.height));
            
            
            self->itemEndDateView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemStartDateView.frame.origin.y + self->itemStartDateView.frame.size.height, (width*1 - (textFieldSpacing*2)), (self->itemNameView.frame.size.height));
            
            
            self->itemDaysView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemEndDateView.frame.origin.y + self->itemEndDateView.frame.size.height + textFieldSpacing, self->itemNameView.frame.size.width, self->itemNameView.frame.size.height);
            
            
            
            BOOL DisplayDaysView = [self DisplayDaysView];
            
            CGRect timeViewRect = DisplayDaysView == YES && [itemDaysTextFieldText containsString:@"Any Day"] == NO ? CGRectMake(self->itemNameView.frame.origin.x, self->itemDaysView.frame.origin.y + self->itemDaysView.frame.size.height, self->itemNameView.frame.size.width, self->itemNameView.frame.size.height) : self->itemDaysView.frame;
            self->itemTimeView.frame = timeViewRect;
            
            
            
            BOOL DisplayTakeTurnsView = [self DisplayTakeTurnsView];
            
            CGFloat everyTakesTurnsViewToRepelFrom = self->itemTimeView.frame.origin.y + self->itemTimeView.frame.size.height;
            
            if (TaskIsRepeating == NO || TaskIsRepeatingHourly == YES) {
                
                everyTakesTurnsViewToRepelFrom = self->itemEndDateView.frame.origin.y + self->itemEndDateView.frame.size.height + textFieldSpacing;
                
            }
            
            if (TaskIsRepeatingAsNeeded == YES || TaskIsRepeatingWhenCompleted == YES) {
                
                everyTakesTurnsViewToRepelFrom = self->itemRepeatsView.frame.origin.y + self->itemRepeatsView.frame.size.height + textFieldSpacing;
                
            }
            
            self->itemEveryoneTakesTurnsView.frame = DisplayTakeTurnsView == YES ? CGRectMake(self->itemNameView.frame.origin.x, everyTakesTurnsViewToRepelFrom, self->itemNameView.frame.size.width, self->itemNameView.frame.size.height) : self->itemTimeView.frame;
            self->itemAlternateTurnsView.frame = TaskIsTakingTurns == YES ? CGRectMake(self->itemNameView.frame.origin.x, self->itemEveryoneTakesTurnsView.frame.origin.y + self->itemEveryoneTakesTurnsView.frame.size.height, (width*1 - (textFieldSpacing*2)), (self->itemNameView.frame.size.height)) : self->itemEveryoneTakesTurnsView.frame;
            CGRect assignedToViewRect = CGRectMake(textFieldSpacing, self->itemAlternateTurnsView.frame.origin.y + self->itemAlternateTurnsView.frame.size.height, (width*1 - (textFieldSpacing*2)), (self->itemNameView.frame.size.height));
            DisplaySpecificTurnOrderView = [self DisplaySpecificTurnOrderView];
            self->itemTurnOrderView.frame = DisplaySpecificTurnOrderView == YES ? assignedToViewRect : self->itemAlternateTurnsView.frame;
            
            
        }
        
        
        UIView *viewToRepelFrom;
        
        if (TaskIsRepeating == NO && TaskIsRepeatingAsNeeded == NO && TaskIsRepeatingWhenCompleted == NO) {
            viewToRepelFrom = self->itemTimeView;
        } else if ((TaskIsRepeating == YES || TaskIsRepeatingWhenCompleted == YES || TaskIsRepeatingAsNeeded == YES) && TaskIsAssignedToNobody == NO) {
            viewToRepelFrom = self->itemTurnOrderView;
        } else if ((TaskIsRepeating == NO && TaskIsRepeatingAsNeeded == NO && TaskIsRepeatingWhenCompleted == YES) && TaskIsAssignedToNobody == YES) {
            viewToRepelFrom = self->itemEndDateView;
        } else if ((TaskIsRepeating == YES || TaskIsRepeatingWhenCompleted == YES || TaskIsRepeatingAsNeeded == YES) && TaskIsAssignedToNobody == YES && TaskIsRepeatingHourly == YES) {
            viewToRepelFrom = self->itemEndDateView;
        } else if ((TaskIsRepeating == YES || TaskIsRepeatingWhenCompleted == YES) && TaskIsAssignedToNobody == YES && TaskIsRepeatingHourly == NO) {
            viewToRepelFrom = self->itemTimeView;
        } else if (TaskIsRepeatingAsNeeded == YES && TaskIsAssignedToNobody == YES) {
            viewToRepelFrom = self->itemTurnOrderView;
        }
        
        CGFloat yPos = self->itemReminderView.alpha == 1.0f ? viewToRepelFrom.frame.origin.y + viewToRepelFrom.frame.size.height + textFieldSpacing : viewToRepelFrom.frame.origin.y;
        self->itemReminderView.frame = CGRectMake(self->itemNameView.frame.origin.x, yPos, (width*1 - (textFieldSpacing*2)), (self->itemNameView.frame.size.height));
        
        yPos = self->itemReminderView.frame.origin.y + self->itemReminderView.frame.size.height + textFieldSpacing;
        
        if (TaskIsAssignedToNobody == YES && (TaskIsRepeatingAsNeeded == YES || TaskIsRepeatingWhenCompleted == YES)) {
            yPos = self->itemRepeatsView.frame.origin.y + self->itemRepeatsView.frame.size.height + textFieldSpacing;
        }
        
        self->itemMoreOptionsView.frame = CGRectMake(self->itemNameView.frame.origin.x, yPos, repeatsViewWidth, (self->itemNameView.frame.size.height));
        
        self->itemAddImageView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemMoreOptionsView.frame.origin.y + self->itemMoreOptionsView.frame.size.height + textFieldSpacing, repeatsViewWidth, (self->itemNameView.frame.size.height));
        
        //        self->itemNotesView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemAddImageView.frame.origin.y + self->itemAddImageView.frame.size.height + textFieldSpacing, self->itemNameView.frame.size.width, height*0.24456522);
        
        self->deleteButton.frame = CGRectMake(self->itemNotesView.frame.origin.x, self->itemMoreOptionsView.frame.origin.y + self->itemMoreOptionsView.frame.size.height + textFieldSpacing, self->itemNameView.frame.size.width, self->itemNameView.frame.size.height);
        
        
        
        /*-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
        
        
        
        self->itemSubTasksView.frame = CGRectMake(self->itemNameView.frame.origin.x, textFieldSpacing, repeatsViewWidth, (self->itemNameView.frame.size.height));
        self->itemGracePeriodView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemSubTasksView.frame.origin.y + self->itemSubTasksView.frame.size.height, (width*1 - (textFieldSpacing*2)), (self->itemNameView.frame.size.height));
        self->itemPastDueView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemGracePeriodView.frame.origin.y + self->itemGracePeriodView.frame.size.height, (width*1 - (textFieldSpacing*2)), (self->itemNameView.frame.size.height));
        
        
        
        self->itemColorView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemPastDueView.frame.origin.y + self->itemPastDueView.frame.size.height + textFieldSpacing, repeatsViewWidth, (self->itemNameView.frame.size.height));
        self->itemTagsView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemColorView.frame.origin.y + self->itemColorView.frame.size.height, self->itemNameView.frame.size.width, self->itemNameView.frame.size.height);
        self->itemPriorityView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemTagsView.frame.origin.y + self->itemTagsView.frame.size.height, repeatsViewWidth, (self->itemNameView.frame.size.height));
        self->itemDifficultyView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemPriorityView.frame.origin.y + self->itemPriorityView.frame.size.height, repeatsViewWidth, (self->itemNameView.frame.size.height));
        
        
        
        self->itemRewardView.frame = CGRectMake(self->itemNameView.frame.origin.x,  self->itemDifficultyView.frame.origin.y + self->itemDifficultyView.frame.size.height + textFieldSpacing, repeatsViewWidth, (self->itemNameView.frame.size.height));
        self->itemPrivateView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemRewardView.frame.origin.y + self->itemRewardView.frame.size.height, repeatsViewWidth, (self->itemNameView.frame.size.height));
        self->itemApprovalNeededView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemPrivateView.frame.origin.y + self->itemPrivateView.frame.size.height, repeatsViewWidth, (self->itemNameView.frame.size.height));
        
        
        
        CGFloat heightToUse = self->deleteButton.hidden == YES ?
        self->itemMoreOptionsView.frame.origin.y + self->itemMoreOptionsView.frame.size.height + textFieldSpacing :
        self->deleteButton.frame.origin.y + self->deleteButton.frame.size.height + textFieldSpacing;
        
        if (heightToUse + bottomPadding < self.view.frame.size.height) {
            heightToUse = self.customScrollView.frame.size.height + 1;
        }
        
        navigationBarHeight = [[[GeneralObject alloc] init] GetNavigationBarHeight:self];
        
        self->_customScrollView.contentSize = CGSizeMake(self.view.frame.size.width, heightToUse + bottomPadding + navigationBarHeight);
        
        self->tapView.frame = self->itemDaysView.frame;
        self->tapView.alpha = self->itemDaysView.alpha;
        self->tapView.hidden = self->itemDaysView.hidden;
        
        
        
        [self AdjustTextFieldViewsToUse];
        
        
        
        if (self->_viewingMoreOptions == NO) {
            
            self->itemSubTasksView.hidden = YES;
            self->itemRewardView.hidden = YES;
            self->itemDifficultyView.hidden = YES;
            self->itemPriorityView.hidden = YES;
            self->itemColorView.hidden = YES;
            self->itemPrivateView.hidden = YES;
            self->itemApprovalNeededView.hidden = YES;
            self->itemTagsView.hidden = YES;
            self->itemGracePeriodView.hidden = YES;
            self->itemPastDueView.hidden = YES;
            
        } else {
            
            self->itemNameView.hidden = YES;
            self->itemAssignedToView.hidden = YES;
            self->itemMustCompleteView.hidden = YES;
            self->itemRepeatsView.hidden = YES;
            self->itemRepeatIfCompletedEarlyView.hidden = YES;
            self->itemStartDateView.hidden = YES;
            self->itemEndDateView.hidden = YES;
            self->itemDueDateView.hidden = YES;
            self->itemDaysView.hidden = YES;
            self->itemTimeView.hidden = YES;
            self->itemEveryoneTakesTurnsView.hidden = YES;
            self->itemAlternateTurnsView.hidden = YES;
            self->itemTurnOrderView.hidden = YES;
            self->itemReminderView.hidden = YES;
            self->itemMoreOptionsView.hidden = YES;
            self->itemAddImageView.hidden = YES;
            self->itemNotesView.hidden = YES;
            self->deleteButton.hidden = YES;
            
        }
        
    }];
    //    itemNotesView.hidden = YES;
    itemAddImageView.hidden = YES;

}

-(void)AdjustTextFieldFramesExpenses:(NSTimeInterval)interval {
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    CGFloat bottomPadding = [[[GeneralObject alloc] init] GetBottomPaddingHeight];
    
    CGFloat textFieldSpacing = (height*0.024456);
    
    NSString *itemDueDateTextFieldText = self->itemDueDateTextField.text ? self->itemDueDateTextField.text : @"";
    NSString *itemDaysTextFieldText = self->itemDaysTextField.text ? self->itemDaysTextField.text : @"";
    NSString *itemRepeatsTextFieldText = self->itemRepeatsTextField.text ? self->itemRepeatsTextField.text : @"";
    NSString *chosenItemRepeatIfCompletedEarlyLocal = chosenItemRepeatIfCompletedEarly ? chosenItemRepeatIfCompletedEarly : @"";
    NSMutableArray *itemSpecificDueDatesArrayLocal = itemSpecificDueDatesArray ? itemSpecificDueDatesArray : [NSMutableArray array];
    
    BOOL TaskHasMultipleDueDate =  [[[BoolDataObject alloc] init] TaskHasMultipleDueDate:[@{@"ItemSpecificDueDates" : itemSpecificDueDatesArrayLocal, @"ItemRepeats" : itemRepeatsTextFieldText, @"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal} mutableCopy] itemType:itemType];
    BOOL TaskHasNoDueDate = [[[BoolDataObject alloc] init] TaskHasNoDueDate:[@{@"ItemDueDate" : itemDueDateTextFieldText, @"ItemSpecificDueDates" : itemSpecificDueDatesArrayLocal, @"ItemRepeats" : itemRepeatsTextFieldText, @"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal} mutableCopy] itemType:itemType];
    BOOL TaskIsRepeating = [[[BoolDataObject alloc] init] TaskIsRepeating:[@{@"ItemRepeats" : itemRepeatsTextFieldText, @"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal} mutableCopy] itemType:itemType];
    BOOL TaskIsRepeatingAsNeeded = [[[BoolDataObject alloc] init] TaskIsRepeatingAsNeeded:[@{@"ItemRepeats" : itemRepeatsTextFieldText, @"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal} mutableCopy] itemType:itemType];
    BOOL TaskIsTakingTurns = [itemEveryoneTakesTurnsSwitch isOn];
    BOOL TaskIsRepeatingHourly = [[[BoolDataObject alloc] init] TaskIsRepeatingHourly:[@{@"ItemRepeats" : itemRepeatsTextFieldText} mutableCopy] itemType:itemType];
    BOOL TaskIsRepeatingWeekly = [[[BoolDataObject alloc] init] TaskIsRepeatingWeekly:[@{@"ItemRepeats" : itemRepeatsTextFieldText} mutableCopy] itemType:itemType];
    BOOL TaskIsRepeatingMonthly = [[[BoolDataObject alloc] init] TaskIsRepeatingMonthly:[@{@"ItemRepeats" : itemRepeatsTextFieldText} mutableCopy] itemType:itemType];
    BOOL TaskIsRepeatingWhenCompleted = [[[BoolDataObject alloc] init] TaskIsRepeatingWhenCompleted:[@{@"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal ? chosenItemRepeatIfCompletedEarlyLocal : @"No", @"ItemRepeats" : itemRepeatsTextFieldText} mutableCopy] itemType:itemType];
    BOOL TaskIsAssignedToNobody = [[self GenerateItemAssignedTo:@"No"] count] == 0;
    //    BOOL TaskIsAssignedToMoreThanOnePerson = [[self GenerateItemAssignedTo:@"No"] count] != 1;
    
    itemMustCompleteView.hidden = YES;
    itemListItemsView.hidden = YES;
    itemSubTasksView.hidden = YES;
    
    NSArray *viewBackgroundColorArr = @[
        
        itemNameView,
        itemAssignedToView,
        itemMustCompleteView,
        itemRepeatIfCompletedEarlyView,
        itemAmountView,
        itemCostPerPersonView,
        itemPaymentMethodView,
        itemListItemsView,
        itemRepeatsView,
        itemDueDateView,
        itemStartDateView,
        itemEndDateView,
        itemDaysView,
        itemTimeView,
        itemEveryoneTakesTurnsView,
        itemAlternateTurnsView,
        itemTurnOrderView,
        itemGracePeriodView,
        itemPastDueView,
        itemTagsView,
        
        itemSubTasksView,
        itemReminderView,
        itemRewardView,
        itemDifficultyView,
        itemPriorityView,
        itemColorView,
        itemPrivateView
        
    ];
    
    [self ViewAlpha:viewBackgroundColorArr];
    
    if (TaskIsRepeating == NO) {
        
        self->itemRepeatIfCompletedEarlyView.alpha = 0.0f;
        self->itemStartDateView.alpha = 0.0f;
        self->itemEndDateView.alpha = 0.0f;
        self->itemDaysView.alpha = 0.0f;
        
        if (TaskIsRepeatingAsNeeded == YES) {
            
            self->itemDueDateView.alpha = 0.0f;
            
        }
        
        if (/*TaskIsAssignedToNobody == YES || TaskIsAssignedToMoreThanOnePerson == NO ||*/ TaskIsTakingTurns == NO) {
            
            self->itemTurnOrderView.alpha = 0.0f;
            
        }
        
        if (TaskIsRepeatingAsNeeded == NO) {
            
            self->itemEveryoneTakesTurnsView.alpha = 0.0f;
            
        }
        
        if (TaskIsTakingTurns == NO) {
            
            self->itemAlternateTurnsView.alpha = 0.0f;
            
        }
        
        if (TaskHasNoDueDate == YES || TaskHasMultipleDueDate == YES || TaskIsRepeatingAsNeeded == YES || TaskIsRepeatingWhenCompleted == YES) {
            
            self->itemTimeView.alpha = 0.0f;
            
        }
        
        if ((TaskHasNoDueDate == YES && TaskIsRepeating == NO) || TaskIsRepeatingAsNeeded == YES || TaskIsRepeatingWhenCompleted == YES) {
            
            self->itemReminderView.alpha = 0.0f;
            
        }
        
    } else {
        
        self->itemDueDateView.alpha = 0.0f;
        
        if (/*TaskIsAssignedToNobody == YES || TaskIsAssignedToMoreThanOnePerson == NO ||*/ TaskIsTakingTurns == NO) {
            
            self->itemTurnOrderView.alpha = 0.0f;
            
        }
        
        if (TaskIsRepeatingWeekly == NO && TaskIsRepeatingMonthly == NO) {
            
            self->itemDaysView.alpha = 0.0f;
            
        }
        
        if (TaskIsAssignedToNobody == YES) {
            
            self->itemEveryoneTakesTurnsView.alpha = 0.0f;
            
        }
        
        if (TaskIsTakingTurns == NO) {
            
            self->itemAlternateTurnsView.alpha = 0.0f;
            
        }
        
        if (((TaskIsRepeatingWeekly == YES || TaskIsRepeatingMonthly == YES) && [itemDaysTextFieldText containsString:@"Any Day"]) ||
            (TaskIsRepeating == NO) ||
            (TaskIsRepeatingHourly == YES) ||
            TaskIsRepeatingAsNeeded == YES ||
            TaskIsRepeatingWhenCompleted == YES) {
            
            self->itemTimeView.alpha = 0.0f;
            
        }
        
        if ((TaskHasNoDueDate == YES && TaskIsRepeating == NO) || TaskIsRepeatingAsNeeded == YES || TaskIsRepeatingWhenCompleted == YES) {
            
            self->itemReminderView.alpha = 0.0f;
            
        }
        
        if (TaskIsRepeatingAsNeeded == YES || TaskIsRepeatingWhenCompleted == YES) {
            
            self->itemRepeatIfCompletedEarlyView.alpha = 0.0f;
            self->itemStartDateView.alpha = 0.0f;
            self->itemEndDateView.alpha = 0.0f;
            
        }
        
    }
    
    [UIView animateWithDuration:interval animations:^{
        
        
        
        CGFloat repeatsViewX = textFieldSpacing;
        CGFloat repeatsViewWidth = (width*1 - (textFieldSpacing*2));
        
        
        
        CGFloat itemNameRect = self->newUserInfoView.hidden == NO ? self->newUserInfoView.frame.origin.y + self->newUserInfoView.frame.size.height + textFieldSpacing : textFieldSpacing;
        
        self->itemNameView.frame = CGRectMake(textFieldSpacing, itemNameRect, (width*1 - (textFieldSpacing*2)), (self.view.frame.size.height*0.07472826 > 55?55:(self.view.frame.size.height*0.07472826)));
        self->itemNotesView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemNameView.frame.origin.y + self->itemNameView.frame.size.height, self->itemNameView.frame.size.width, (self.view.frame.size.height*0.07472826 > 55?55:(self.view.frame.size.height*0.07472826)));
        
        [self GenerateNotesViewFrames];
        
        
        
        CGFloat cornerRadius = (self.view.frame.size.height*0.2181818182 > 12?12:(self.view.frame.size.height*0.2181818182));
        [[[GeneralObject alloc] init] RoundingCorners:self->itemNameView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
        [[[GeneralObject alloc] init] RoundingCorners:self->itemNotesView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
        
        
        
        
        self->itemAssignedToView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemNotesView.frame.origin.y + self->itemNotesView.frame.size.height + textFieldSpacing, self->itemNameView.frame.size.width, self->itemNameView.frame.size.height);
        
        
        
        
        CGRect completedByViewRect = CGRectMake(textFieldSpacing, self->itemAssignedToView.frame.origin.y + self->itemAssignedToView.frame.size.height, (width*1 - (textFieldSpacing*2)), (self->itemNameView.frame.size.height));
        BOOL DisplayCompletedByView = [self DisplayMustCompleteView];
        self->itemMustCompleteView.frame = DisplayCompletedByView == YES ? completedByViewRect : self->itemAssignedToView.frame;
        
        
        
        
        self->itemDaysView.frame = self->itemMustCompleteView.frame;
        self->itemTimeView.frame = self->itemMustCompleteView.frame;
        self->itemEveryoneTakesTurnsView.frame = self->itemMustCompleteView.frame;
        
        
        
        
        self->itemAmountView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemMustCompleteView.frame.origin.y + self->itemMustCompleteView.frame.size.height, self->itemNameView.frame.size.width, self->itemNameView.frame.size.height);
        
        
        
        
        self->itemCostPerPersonView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemAmountView.frame.origin.y + self->itemAmountView.frame.size.height, self->itemNameView.frame.size.width, self->itemNameView.frame.size.height);
        
        
        
        
        self->itemPaymentMethodView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemCostPerPersonView.frame.origin.y + self->itemCostPerPersonView.frame.size.height, self->itemNameView.frame.size.width, self->itemNameView.frame.size.height);
        
        
        
        
        CGFloat width;
        CGFloat height;
        
        
        
        if (TaskIsRepeating == NO) {
            
            self->itemDaysView.hidden = YES;
            
            
            self->itemRepeatsView.frame = CGRectMake(repeatsViewX, self->itemPaymentMethodView.frame.origin.y + self->itemPaymentMethodView.frame.size.height + textFieldSpacing, self->itemNameView.frame.size.width, self->itemNameView.frame.size.height);
            
            
            
            
            width = CGRectGetWidth(self.view.bounds);
            height = CGRectGetHeight(self.view.bounds);
            
            self->itemRepeatIfCompletedEarlyView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemRepeatsView.frame.origin.y, self->itemNameView.frame.size.width, (self->itemNameView.frame.size.height));
            
            self->itemStartDateView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemRepeatsView.frame.origin.y, self->itemNameView.frame.size.width, (self->itemNameView.frame.size.height));
            
            self->itemEndDateView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemRepeatsView.frame.origin.y, self->itemNameView.frame.size.width, (self->itemNameView.frame.size.height));
            
            self->itemDaysView.frame = self->itemEndDateView.frame;
            self->itemTimeView.frame = self->itemEndDateView.frame;
            self->itemEveryoneTakesTurnsView.frame = self->itemEndDateView.frame;
            
            CGFloat yPos = TaskIsRepeating == YES || TaskIsRepeatingAsNeeded == YES ? self->itemRepeatsView.frame.origin.y : self->itemRepeatsView.frame.origin.y + self->itemRepeatsView.frame.size.height;
            self->itemDueDateView.frame = CGRectMake(self->itemNameView.frame.origin.x, yPos, (width*1 - (textFieldSpacing*2)), (self->itemNameView.frame.size.height));
            
            yPos = TaskHasNoDueDate == YES || TaskHasMultipleDueDate == YES ? self->itemDueDateView.frame.origin.y : self->itemDueDateView.frame.origin.y + self->itemDueDateView.frame.size.height;
            self->itemTimeView.frame = CGRectMake(self->itemNameView.frame.origin.x, yPos, (width*1 - (textFieldSpacing*2)), (self->itemNameView.frame.size.height));
            
            
            
            
            if (TaskIsRepeatingAsNeeded == YES || TaskIsRepeatingWhenCompleted == YES) {
                
                self->itemEveryoneTakesTurnsView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemTimeView.frame.origin.y + self->itemTimeView.frame.size.height, (width*1 - (textFieldSpacing*2)), (self->itemNameView.frame.size.height));
                
                self->itemAlternateTurnsView.frame = TaskIsTakingTurns == YES ? CGRectMake(self->itemNameView.frame.origin.x, self->itemEveryoneTakesTurnsView.frame.origin.y + self->itemEveryoneTakesTurnsView.frame.size.height, (width*1 - (textFieldSpacing*2)), (self->itemNameView.frame.size.height)) : self->itemEveryoneTakesTurnsView.frame;
                CGRect assignedToViewRect = CGRectMake(textFieldSpacing, self->itemAlternateTurnsView.frame.origin.y + self->itemAlternateTurnsView.frame.size.height, (width*1 - (textFieldSpacing*2)), (self->itemNameView.frame.size.height));
                BOOL DisplaySpecificTurnOrderView = [self DisplaySpecificTurnOrderView];
                self->itemTurnOrderView.frame = DisplaySpecificTurnOrderView == YES ? assignedToViewRect : self->itemAlternateTurnsView.frame;
                
            }
            
            
            
            
        } else {
            
            
            self->itemDaysView.hidden = NO;
            //            self->itemTimeView.hidden = NO;
            
            
            
            self->itemRepeatsView.frame = CGRectMake(repeatsViewX, self->itemPaymentMethodView.frame.origin.y + self->itemPaymentMethodView.frame.size.height + textFieldSpacing, (self.view.frame.size.width*1 - (textFieldSpacing*2)), (self->itemNameView.frame.size.height));
            
            
            width = CGRectGetWidth(self.view.bounds);
            height = CGRectGetHeight(self.view.bounds);
            
            
            
            
            
            
            
            
            
            
            self->itemDueDateView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemPaymentMethodView.frame.origin.y + self->itemPaymentMethodView.frame.size.height, (width*1 - (textFieldSpacing*2)), (self->itemNameView.frame.size.height));
            
            
            self->itemRepeatIfCompletedEarlyView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemRepeatsView.frame.origin.y + self->itemRepeatsView.frame.size.height, self->itemNameView.frame.size.width, (self->itemNameView.frame.size.height));
            
            
            self->itemStartDateView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemRepeatIfCompletedEarlyView.frame.origin.y + self->itemRepeatIfCompletedEarlyView.frame.size.height, (width*1 - (textFieldSpacing*2)), (self->itemNameView.frame.size.height));
            
            
            self->itemEndDateView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemStartDateView.frame.origin.y + self->itemStartDateView.frame.size.height, (width*1 - (textFieldSpacing*2)), (self->itemNameView.frame.size.height));
            
            
            self->itemDaysView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemEndDateView.frame.origin.y + self->itemEndDateView.frame.size.height + textFieldSpacing, self->itemNameView.frame.size.width, self->itemNameView.frame.size.height);
            
            
            
            BOOL DisplayDaysView = [self DisplayDaysView];
            CGRect timeViewRect = DisplayDaysView == YES && [itemDaysTextFieldText containsString:@"Any Day"] == NO ? CGRectMake(self->itemNameView.frame.origin.x, self->itemDaysView.frame.origin.y + self->itemDaysView.frame.size.height, self->itemNameView.frame.size.width, self->itemNameView.frame.size.height) : self->itemDaysView.frame;
            self->itemTimeView.frame = timeViewRect;
            
            
            
            BOOL DisplayTakeTurnsView = [self DisplayTakeTurnsView];
            
            CGFloat everyTakesTurnsViewToRepelFrom = self->itemTimeView.frame.origin.y + self->itemTimeView.frame.size.height;
            
            if ((TaskIsRepeating == NO) || (TaskIsRepeatingHourly == YES)) {
                
                everyTakesTurnsViewToRepelFrom = self->itemEndDateView.frame.origin.y + self->itemEndDateView.frame.size.height + textFieldSpacing;
                
            }
            
            if ((TaskIsRepeatingAsNeeded == YES) || (TaskIsRepeatingWhenCompleted == YES)) {
                
                everyTakesTurnsViewToRepelFrom = self->itemRepeatsView.frame.origin.y + self->itemRepeatsView.frame.size.height + textFieldSpacing;
                
            }
            
            self->itemEveryoneTakesTurnsView.frame = DisplayTakeTurnsView == YES ? CGRectMake(self->itemNameView.frame.origin.x, everyTakesTurnsViewToRepelFrom, self->itemNameView.frame.size.width, self->itemNameView.frame.size.height) : self->itemTimeView.frame;
            self->itemAlternateTurnsView.frame = TaskIsTakingTurns == YES ? CGRectMake(self->itemNameView.frame.origin.x, self->itemEveryoneTakesTurnsView.frame.origin.y + self->itemEveryoneTakesTurnsView.frame.size.height, (width*1 - (textFieldSpacing*2)), (self->itemNameView.frame.size.height)) : self->itemEveryoneTakesTurnsView.frame;
            CGRect assignedToViewRect = CGRectMake(textFieldSpacing, self->itemAlternateTurnsView.frame.origin.y + self->itemAlternateTurnsView.frame.size.height, (width*1 - (textFieldSpacing*2)), (self->itemNameView.frame.size.height));
            BOOL DisplaySpecificTurnOrderView = [self DisplaySpecificTurnOrderView];
            self->itemTurnOrderView.frame = DisplaySpecificTurnOrderView == YES ? assignedToViewRect : self->itemAlternateTurnsView.frame;
            
            
        }
        
        
        UIView *viewToRepelFrom;
        
        if (TaskIsRepeating == NO && TaskIsRepeatingAsNeeded == NO && TaskIsRepeatingWhenCompleted == NO) {
            viewToRepelFrom = self->itemTimeView;
        } else if ((TaskIsRepeating == YES || TaskIsRepeatingWhenCompleted == YES || TaskIsRepeatingAsNeeded == YES) && TaskIsAssignedToNobody == NO) {
            viewToRepelFrom = self->itemTurnOrderView;
        } else if ((TaskIsRepeating == NO && TaskIsRepeatingAsNeeded == NO && TaskIsRepeatingWhenCompleted == YES) && TaskIsAssignedToNobody == YES) {
            viewToRepelFrom = self->itemEndDateView;
        } else if ((TaskIsRepeating == YES || TaskIsRepeatingWhenCompleted == YES || TaskIsRepeatingAsNeeded == YES) && TaskIsAssignedToNobody == YES && TaskIsRepeatingHourly == YES) {
            viewToRepelFrom = self->itemEndDateView;
        } else if ((TaskIsRepeating == YES || TaskIsRepeatingWhenCompleted == YES || TaskIsRepeatingAsNeeded == YES) && TaskIsAssignedToNobody == YES && TaskIsRepeatingHourly == NO) {
            viewToRepelFrom = self->itemTimeView;
        }
        
        CGFloat yPos = self->itemReminderView.alpha == 1.0f ? viewToRepelFrom.frame.origin.y + viewToRepelFrom.frame.size.height + textFieldSpacing : viewToRepelFrom.frame.origin.y;
        self->itemReminderView.frame = CGRectMake(self->itemNameView.frame.origin.x, yPos, (width*1 - (textFieldSpacing*2)), (self->itemNameView.frame.size.height));
        
        yPos = self->itemReminderView.frame.origin.y + self->itemReminderView.frame.size.height + textFieldSpacing;
        
        if (TaskIsAssignedToNobody == YES && (TaskIsRepeatingAsNeeded == YES || TaskIsRepeatingWhenCompleted == YES)) {
            yPos = self->itemRepeatsView.frame.origin.y + self->itemRepeatsView.frame.size.height + textFieldSpacing;
        }
        
        self->itemMoreOptionsView.frame = CGRectMake(self->itemNameView.frame.origin.x, yPos, repeatsViewWidth, (self->itemNameView.frame.size.height));
        
        self->deleteButton.frame = CGRectMake(self->itemNotesView.frame.origin.x, self->itemMoreOptionsView.frame.origin.y + self->itemMoreOptionsView.frame.size.height + textFieldSpacing, self->itemNameView.frame.size.width, self->itemNameView.frame.size.height);
        
        
        
        /*-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
        
        
        
        self->itemGracePeriodView.frame = CGRectMake(self->itemNameView.frame.origin.x, textFieldSpacing, (width*1 - (textFieldSpacing*2)), (self->itemNameView.frame.size.height));
        self->itemPastDueView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemGracePeriodView.frame.origin.y + self->itemGracePeriodView.frame.size.height, (width*1 - (textFieldSpacing*2)), (self->itemNameView.frame.size.height));
        
        
        
        self->itemColorView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemPastDueView.frame.origin.y + self->itemPastDueView.frame.size.height + textFieldSpacing, repeatsViewWidth, (self->itemNameView.frame.size.height));
        self->itemTagsView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemColorView.frame.origin.y + self->itemColorView.frame.size.height, self->itemNameView.frame.size.width, self->itemNameView.frame.size.height);
        self->itemPriorityView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemTagsView.frame.origin.y + self->itemTagsView.frame.size.height, repeatsViewWidth, (self->itemNameView.frame.size.height));
        self->itemDifficultyView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemPriorityView.frame.origin.y + self->itemPriorityView.frame.size.height, repeatsViewWidth, (self->itemNameView.frame.size.height));
        
        
        
        self->itemRewardView.frame = CGRectMake(self->itemNameView.frame.origin.x,  self->itemDifficultyView.frame.origin.y + self->itemDifficultyView.frame.size.height + textFieldSpacing, repeatsViewWidth, (self->itemNameView.frame.size.height));
        self->itemPrivateView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemRewardView.frame.origin.y + self->itemRewardView.frame.size.height, repeatsViewWidth, (self->itemNameView.frame.size.height));
        self->itemApprovalNeededView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemPrivateView.frame.origin.y + self->itemPrivateView.frame.size.height, repeatsViewWidth, (self->itemNameView.frame.size.height));
        
        
        
        CGFloat heightToUse = self->deleteButton.frame.origin.y + self->deleteButton.frame.size.height + textFieldSpacing;
        if (heightToUse + bottomPadding < self.view.frame.size.height) {
            heightToUse = self.customScrollView.frame.size.height + 1;
        }
        
        CGFloat navigationBarHeight = [[[GeneralObject alloc] init] GetNavigationBarHeight:self];
        
        self->_customScrollView.contentSize = CGSizeMake(self.view.frame.size.width, heightToUse + bottomPadding + navigationBarHeight);
        
        self->tapView.frame = self->itemDaysView.frame;
        self->tapView.alpha = self->itemDaysView.alpha;
        self->tapView.hidden = self->itemDaysView.hidden;
        
        
        
        [self AdjustTextFieldViewsToUse];
        
        
        
        if (self->_viewingMoreOptions == NO) {
            
            self->itemSubTasksView.hidden = YES;
            self->itemRewardView.hidden = YES;
            self->itemDifficultyView.hidden = YES;
            self->itemPriorityView.hidden = YES;
            self->itemColorView.hidden = YES;
            self->itemPrivateView.hidden = YES;
            self->itemApprovalNeededView.hidden = YES;
            self->itemTagsView.hidden = YES;
            self->itemGracePeriodView.hidden = YES;
            self->itemPastDueView.hidden = YES;
            
        } else {
            
            self->itemNameView.hidden = YES;
            self->itemAssignedToView.hidden = YES;
            self->itemAmountView.hidden = YES;
            self->itemCostPerPersonView.hidden = YES;
            self->itemPaymentMethodView.hidden = YES;
            self->itemMustCompleteView.hidden = YES;
            self->itemRepeatsView.hidden = YES;
            self->itemRepeatIfCompletedEarlyView.hidden = YES;
            self->itemStartDateView.hidden = YES;
            self->itemEndDateView.hidden = YES;
            self->itemDueDateView.hidden = YES;
            self->itemDaysView.hidden = YES;
            self->itemTimeView.hidden = YES;
            self->itemEveryoneTakesTurnsView.hidden = YES;
            self->itemAlternateTurnsView.hidden = YES;
            self->itemTurnOrderView.hidden = YES;
            self->itemReminderView.hidden = YES;
            self->itemMoreOptionsView.hidden = YES;
            self->itemAddImageView.hidden = YES;
            self->itemNotesView.hidden = YES;
            self->deleteButton.hidden = YES;
            
        }
        
    }];
    
}

-(void)AdjustTextFieldFramesLists:(NSTimeInterval)interval {
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    CGFloat bottomPadding = [[[GeneralObject alloc] init] GetBottomPaddingHeight];
    
    CGFloat textFieldSpacing = (height*0.024456);
    
    NSString *itemDueDateTextFieldText = self->itemDueDateTextField.text ? self->itemDueDateTextField.text : @"";
    NSString *itemDaysTextFieldText = self->itemDaysTextField.text ? self->itemDaysTextField.text : @"";
    NSString *itemRepeatsTextFieldText = self->itemRepeatsTextField.text ? self->itemRepeatsTextField.text : @"";
    NSString *chosenItemRepeatIfCompletedEarlyLocal = chosenItemRepeatIfCompletedEarly ? chosenItemRepeatIfCompletedEarly : @"";
    NSMutableArray *itemSpecificDueDatesArrayLocal = itemSpecificDueDatesArray ? itemSpecificDueDatesArray : [NSMutableArray array];
    
    BOOL TaskHasMultipleDueDate =  [[[BoolDataObject alloc] init] TaskHasMultipleDueDate:[@{@"ItemSpecificDueDates" : itemSpecificDueDatesArrayLocal, @"ItemRepeats" : itemRepeatsTextFieldText, @"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal} mutableCopy] itemType:itemType];
    BOOL TaskHasNoDueDate = [[[BoolDataObject alloc] init] TaskHasNoDueDate:[@{@"ItemDueDate" : itemDueDateTextFieldText, @"ItemSpecificDueDates" : itemSpecificDueDatesArrayLocal, @"ItemRepeats" : itemRepeatsTextFieldText, @"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal} mutableCopy] itemType:itemType];
    BOOL TaskIsRepeating = [[[BoolDataObject alloc] init] TaskIsRepeating:[@{@"ItemRepeats" : itemRepeatsTextFieldText, @"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal} mutableCopy] itemType:itemType];
    BOOL TaskIsRepeatingAsNeeded = [[[BoolDataObject alloc] init] TaskIsRepeatingAsNeeded:[@{@"ItemRepeats" : itemRepeatsTextFieldText, @"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal} mutableCopy] itemType:itemType];
    BOOL TaskIsTakingTurns = [itemEveryoneTakesTurnsSwitch isOn];
    BOOL TaskIsRepeatingHourly = [[[BoolDataObject alloc] init] TaskIsRepeatingHourly:[@{@"ItemRepeats" : itemRepeatsTextFieldText} mutableCopy] itemType:itemType];
    BOOL TaskIsRepeatingWeekly = [[[BoolDataObject alloc] init] TaskIsRepeatingWeekly:[@{@"ItemRepeats" : itemRepeatsTextFieldText} mutableCopy] itemType:itemType];
    BOOL TaskIsRepeatingMonthly = [[[BoolDataObject alloc] init] TaskIsRepeatingMonthly:[@{@"ItemRepeats" : itemRepeatsTextFieldText} mutableCopy] itemType:itemType];
    BOOL TaskIsRepeatingWhenCompleted = [[[BoolDataObject alloc] init] TaskIsRepeatingWhenCompleted:[@{@"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal ? chosenItemRepeatIfCompletedEarlyLocal : @"No", @"ItemRepeats" : itemRepeatsTextFieldText} mutableCopy] itemType:itemType];
    BOOL TaskIsAssignedToNobody = [[self GenerateItemAssignedTo:@"No"] count] == 0;
    //    BOOL TaskIsAssignedToMoreThanOnePerson = [[self GenerateItemAssignedTo:@"No"] count] != 1;
    
    itemMustCompleteView.hidden = YES;
    itemAmountView.hidden = YES;
    itemCostPerPersonView.hidden = YES;
    itemPaymentMethodView.hidden = YES;
    itemSubTasksView.hidden = YES;
    itemApprovalNeededView.hidden = YES;
    
    NSArray *viewBackgroundColorArr = @[
        
        itemNameView,
        itemAssignedToView,
        itemRepeatIfCompletedEarlyView,
        itemPaymentMethodView,
        itemListItemsView,
        itemRepeatsView,
        itemDueDateView,
        itemStartDateView,
        itemEndDateView,
        itemDaysView,
        itemTimeView,
        itemEveryoneTakesTurnsView,
        itemAlternateTurnsView,
        itemTurnOrderView,
        itemGracePeriodView,
        itemPastDueView,
        itemTagsView,
        
        itemReminderView,
        itemRewardView,
        itemDifficultyView,
        itemPriorityView,
        itemColorView,
        itemPrivateView
        
    ];
    
    [self ViewAlpha:viewBackgroundColorArr];
    
    if (TaskIsRepeating == NO) {
        
        self->itemRepeatIfCompletedEarlyView.alpha = 0.0f;
        self->itemStartDateView.alpha = 0.0f;
        self->itemEndDateView.alpha = 0.0f;
        self->itemDaysView.alpha = 0.0f;
        
        if (TaskIsRepeatingAsNeeded == YES) {
            
            self->itemDueDateView.alpha = 0.0f;
            
        }
        
        if (/*TaskIsAssignedToNobody == YES || TaskIsAssignedToMoreThanOnePerson == NO ||*/ TaskIsTakingTurns == NO) {
            
            self->itemTurnOrderView.alpha = 0.0f;
            
        }
        
        if (TaskIsRepeatingAsNeeded == NO) {
            
            self->itemEveryoneTakesTurnsView.alpha = 0.0f;
            
        }
        
        if (TaskIsTakingTurns == NO) {
            
            self->itemAlternateTurnsView.alpha = 0.0f;
            
        }
        
        if (TaskHasNoDueDate == YES || TaskHasMultipleDueDate == YES || TaskIsRepeatingAsNeeded == YES || TaskIsRepeatingWhenCompleted == YES) {
            
            self->itemTimeView.alpha = 0.0f;
            
        }
        
        if ((TaskHasNoDueDate == YES && TaskIsRepeating == NO) || TaskIsRepeatingAsNeeded == YES || TaskIsRepeatingWhenCompleted == YES) {
            
            self->itemReminderView.alpha = 0.0f;
            
        }
        
    } else {
        
        self->itemDueDateView.alpha = 0.0f;
        
        if (/*TaskIsAssignedToNobody == YES || TaskIsAssignedToMoreThanOnePerson == NO ||*/ TaskIsTakingTurns == NO) {
            
            self->itemTurnOrderView.alpha = 0.0f;
            
        }
        
        if (TaskIsRepeatingWeekly == NO && TaskIsRepeatingMonthly == NO) {
            
            self->itemDaysView.alpha = 0.0f;
            
        }
        
        if (TaskIsAssignedToNobody == YES) {
            
            self->itemEveryoneTakesTurnsView.alpha = 0.0f;
            
        }
        
        if (TaskIsTakingTurns == NO) {
            
            self->itemAlternateTurnsView.alpha = 0.0f;
            
        }
        
        if (((TaskIsRepeatingWeekly == YES || TaskIsRepeatingMonthly == YES) && [itemDaysTextFieldText containsString:@"Any Day"]) ||
            (TaskIsRepeating == NO) ||
            (TaskIsRepeatingHourly == YES) ||
            TaskIsRepeatingAsNeeded == YES ||
            TaskIsRepeatingWhenCompleted == YES) {
            
            self->itemTimeView.alpha = 0.0f;
            
        }
        
        if ((TaskHasNoDueDate == YES && TaskIsRepeating == NO) || TaskIsRepeatingAsNeeded == YES || TaskIsRepeatingWhenCompleted == YES) {
            
            self->itemReminderView.alpha = 0.0f;
            
        }
        
        if (TaskIsRepeatingAsNeeded == YES || TaskIsRepeatingWhenCompleted == YES) {
            
            self->itemRepeatIfCompletedEarlyView.alpha = 0.0f;
            self->itemStartDateView.alpha = 0.0f;
            self->itemEndDateView.alpha = 0.0f;
            
        }
        
    }
    
    [UIView animateWithDuration:interval animations:^{
        
        
        
        CGFloat repeatsViewX = textFieldSpacing;
        CGFloat repeatsViewWidth = (width*1 - (textFieldSpacing*2));
        
        
        
        CGFloat itemNameRect = self->newUserInfoView.hidden == NO ? self->newUserInfoView.frame.origin.y + self->newUserInfoView.frame.size.height + textFieldSpacing : textFieldSpacing;
        
        self->itemNameView.frame = CGRectMake(textFieldSpacing, itemNameRect, (width*1 - (textFieldSpacing*2)), (self.view.frame.size.height*0.07472826 > 55?55:(self.view.frame.size.height*0.07472826)));
        self->itemNotesView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemNameView.frame.origin.y + self->itemNameView.frame.size.height, self->itemNameView.frame.size.width, (self.view.frame.size.height*0.07472826 > 55?55:(self.view.frame.size.height*0.07472826)));
        
        [self GenerateNotesViewFrames];
        
        
        
        CGFloat cornerRadius = (self.view.frame.size.height*0.2181818182 > 12?12:(self.view.frame.size.height*0.2181818182));
        [[[GeneralObject alloc] init] RoundingCorners:self->itemNameView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
        [[[GeneralObject alloc] init] RoundingCorners:self->itemNotesView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
        
        
        
        self->itemAssignedToView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemNotesView.frame.origin.y + self->itemNotesView.frame.size.height + textFieldSpacing, self->itemNameView.frame.size.width, self->itemNameView.frame.size.height);
        
        
        
        
        CGRect completedByViewRect = CGRectMake(textFieldSpacing, self->itemAssignedToView.frame.origin.y + self->itemAssignedToView.frame.size.height, (width*1 - (textFieldSpacing*2)), (self->itemNameView.frame.size.height));
        BOOL DisplayCompletedByView = [self DisplayMustCompleteView];
        self->itemMustCompleteView.frame = DisplayCompletedByView == YES ? completedByViewRect : self->itemAssignedToView.frame;
        
        
        
        
        self->itemDaysView.frame = self->itemMustCompleteView.frame;
        self->itemTimeView.frame = self->itemMustCompleteView.frame;
        self->itemEveryoneTakesTurnsView.frame = self->itemMustCompleteView.frame;
        
        
        
        
        self->itemListItemsView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemMustCompleteView.frame.origin.y + self->itemMustCompleteView.frame.size.height, (width*1 - (textFieldSpacing*2)), (self->itemNameView.frame.size.height));
        
        
        
        CGFloat width;
        CGFloat height;
        
        
        
        if (TaskIsRepeating == NO) {
            
            self->itemDaysView.hidden = YES;
            //            self->itemTimeView.hidden = YES;
            
            
            self->itemRepeatsView.frame = CGRectMake(repeatsViewX, self->itemListItemsView.frame.origin.y + self->itemListItemsView.frame.size.height + textFieldSpacing, self->itemNameView.frame.size.width, self->itemNameView.frame.size.height);
            
            
            
            
            width = CGRectGetWidth(self.view.bounds);
            height = CGRectGetHeight(self.view.bounds);
            
            self->itemRepeatIfCompletedEarlyView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemRepeatsView.frame.origin.y, self->itemNameView.frame.size.width, (self->itemNameView.frame.size.height));
            
            self->itemStartDateView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemRepeatsView.frame.origin.y, self->itemNameView.frame.size.width, (self->itemNameView.frame.size.height));
            
            self->itemEndDateView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemRepeatsView.frame.origin.y, self->itemNameView.frame.size.width, (self->itemNameView.frame.size.height));
            
            self->itemDaysView.frame = self->itemEndDateView.frame;
            self->itemTimeView.frame = self->itemEndDateView.frame;
            self->itemEveryoneTakesTurnsView.frame = self->itemEndDateView.frame;
            
            self->itemDueDateView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemRepeatsView.frame.origin.y + self->itemRepeatsView.frame.size.height, (width*1 - (textFieldSpacing*2)), (self->itemNameView.frame.size.height));
            
            CGFloat yPos = TaskHasNoDueDate == YES || TaskHasMultipleDueDate == YES ? self->itemDueDateView.frame.origin.y : self->itemDueDateView.frame.origin.y + self->itemDueDateView.frame.size.height;
            self->itemTimeView.frame = CGRectMake(self->itemNameView.frame.origin.x, yPos, (width*1 - (textFieldSpacing*2)), (self->itemNameView.frame.size.height));
            
            
            
            
            if (TaskIsRepeatingAsNeeded == YES || TaskIsRepeatingWhenCompleted == YES) {
                
                self->itemEveryoneTakesTurnsView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemTimeView.frame.origin.y + self->itemTimeView.frame.size.height, (width*1 - (textFieldSpacing*2)), (self->itemNameView.frame.size.height));
                
                self->itemAlternateTurnsView.frame = TaskIsTakingTurns == YES ? CGRectMake(self->itemNameView.frame.origin.x, self->itemEveryoneTakesTurnsView.frame.origin.y + self->itemEveryoneTakesTurnsView.frame.size.height, (width*1 - (textFieldSpacing*2)), (self->itemNameView.frame.size.height)) : self->itemEveryoneTakesTurnsView.frame;
                CGRect assignedToViewRect = CGRectMake(textFieldSpacing, self->itemAlternateTurnsView.frame.origin.y + self->itemAlternateTurnsView.frame.size.height, (width*1 - (textFieldSpacing*2)), (self->itemNameView.frame.size.height));
                BOOL DisplaySpecificTurnOrderView = [self DisplaySpecificTurnOrderView];
                self->itemTurnOrderView.frame = DisplaySpecificTurnOrderView == YES ? assignedToViewRect : self->itemAlternateTurnsView.frame;
                
            }
            
            
            
            
        } else {
            
            self->itemDaysView.hidden = NO;
            
            
            
            self->itemRepeatsView.frame = CGRectMake(repeatsViewX, self->itemListItemsView.frame.origin.y + self->itemListItemsView.frame.size.height + textFieldSpacing, (self.view.frame.size.width*1 - (textFieldSpacing*2)), (self->itemNameView.frame.size.height));
            
            
            width = CGRectGetWidth(self.view.bounds);
            height = CGRectGetHeight(self.view.bounds);
            
            
            
            
            
            
            
            
            
            
            self->itemDueDateView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemListItemsView.frame.origin.y + self->itemListItemsView.frame.size.height, (width*1 - (textFieldSpacing*2)), (self->itemNameView.frame.size.height));
            
            
            self->itemRepeatIfCompletedEarlyView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemRepeatsView.frame.origin.y + self->itemRepeatsView.frame.size.height, self->itemNameView.frame.size.width, (self->itemNameView.frame.size.height));
            
            
            self->itemStartDateView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemRepeatIfCompletedEarlyView.frame.origin.y + self->itemRepeatIfCompletedEarlyView.frame.size.height, (width*1 - (textFieldSpacing*2)), (self->itemNameView.frame.size.height));
            
            
            self->itemEndDateView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemStartDateView.frame.origin.y + self->itemStartDateView.frame.size.height, (width*1 - (textFieldSpacing*2)), (self->itemNameView.frame.size.height));
            
            
            self->itemDaysView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemEndDateView.frame.origin.y + self->itemEndDateView.frame.size.height + textFieldSpacing, self->itemNameView.frame.size.width, self->itemNameView.frame.size.height);
            
            
            
            BOOL DisplayDaysView = [self DisplayDaysView];
            CGRect timeViewRect = DisplayDaysView == YES && [itemDaysTextFieldText containsString:@"Any Day"] == NO ? CGRectMake(self->itemNameView.frame.origin.x, self->itemDaysView.frame.origin.y + self->itemDaysView.frame.size.height, self->itemNameView.frame.size.width, self->itemNameView.frame.size.height) : self->itemDaysView.frame;
            self->itemTimeView.frame = timeViewRect;
            
            
            
            BOOL DisplayTakeTurnsView = [self DisplayTakeTurnsView];
            
            CGFloat everyTakesTurnsViewToRepelFrom = self->itemTimeView.frame.origin.y + self->itemTimeView.frame.size.height;
            
            if ((TaskIsRepeating == NO) || (TaskIsRepeatingHourly == YES)) {
                
                everyTakesTurnsViewToRepelFrom = self->itemEndDateView.frame.origin.y + self->itemEndDateView.frame.size.height + textFieldSpacing;
                
            }
            
            if ((TaskIsRepeatingAsNeeded == YES) || (TaskIsRepeatingWhenCompleted == YES)) {
                
                everyTakesTurnsViewToRepelFrom = self->itemRepeatsView.frame.origin.y + self->itemRepeatsView.frame.size.height + textFieldSpacing;
                
            }
            
            self->itemEveryoneTakesTurnsView.frame = DisplayTakeTurnsView == YES ? CGRectMake(self->itemNameView.frame.origin.x, everyTakesTurnsViewToRepelFrom, self->itemNameView.frame.size.width, self->itemNameView.frame.size.height) : self->itemTimeView.frame;
            self->itemAlternateTurnsView.frame = TaskIsTakingTurns == YES ? CGRectMake(self->itemNameView.frame.origin.x, self->itemEveryoneTakesTurnsView.frame.origin.y + self->itemEveryoneTakesTurnsView.frame.size.height, (width*1 - (textFieldSpacing*2)), (self->itemNameView.frame.size.height)) : self->itemEveryoneTakesTurnsView.frame;
            CGRect assignedToViewRect = CGRectMake(textFieldSpacing, self->itemAlternateTurnsView.frame.origin.y + self->itemAlternateTurnsView.frame.size.height, (width*1 - (textFieldSpacing*2)), (self->itemNameView.frame.size.height));
            BOOL DisplaySpecificTurnOrderView = [self DisplaySpecificTurnOrderView];
            self->itemTurnOrderView.frame = DisplaySpecificTurnOrderView == YES ? assignedToViewRect : self->itemAlternateTurnsView.frame;
            
            
        }
        
        
        UIView *viewToRepelFrom;
        
        if (TaskIsRepeating == NO && TaskIsRepeatingAsNeeded == NO && TaskIsRepeatingWhenCompleted == NO) {
            viewToRepelFrom = self->itemTimeView;
        } else if ((TaskIsRepeating == YES || TaskIsRepeatingWhenCompleted == YES || TaskIsRepeatingAsNeeded == YES) && TaskIsAssignedToNobody == NO) {
            viewToRepelFrom = self->itemTurnOrderView;
        } else if ((TaskIsRepeating == NO && TaskIsRepeatingAsNeeded == NO && TaskIsRepeatingWhenCompleted == YES) && TaskIsAssignedToNobody == YES) {
            viewToRepelFrom = self->itemEndDateView;
        } else if ((TaskIsRepeating == YES || TaskIsRepeatingWhenCompleted == YES || TaskIsRepeatingAsNeeded == YES) && TaskIsAssignedToNobody == YES && TaskIsRepeatingHourly == YES) {
            viewToRepelFrom = self->itemEndDateView;
        } else if ((TaskIsRepeating == YES || TaskIsRepeatingWhenCompleted == YES || TaskIsRepeatingAsNeeded == YES) && TaskIsAssignedToNobody == YES && TaskIsRepeatingHourly == NO) {
            viewToRepelFrom = self->itemTimeView;
        }
        
        CGFloat yPos = self->itemReminderView.alpha == 1.0f ? viewToRepelFrom.frame.origin.y + viewToRepelFrom.frame.size.height + textFieldSpacing : viewToRepelFrom.frame.origin.y;
        self->itemReminderView.frame = CGRectMake(self->itemNameView.frame.origin.x, yPos, (width*1 - (textFieldSpacing*2)), (self->itemNameView.frame.size.height));
        
        yPos = self->itemReminderView.frame.origin.y + self->itemReminderView.frame.size.height + textFieldSpacing;
        
        if (TaskIsAssignedToNobody == YES && (TaskIsRepeatingAsNeeded == YES || TaskIsRepeatingWhenCompleted == YES)) {
            yPos = self->itemRepeatsView.frame.origin.y + self->itemRepeatsView.frame.size.height + textFieldSpacing;
        }
        
        self->itemMoreOptionsView.frame = CGRectMake(self->itemNameView.frame.origin.x, yPos, repeatsViewWidth, (self->itemNameView.frame.size.height));
        
        self->deleteButton.frame = CGRectMake(self->itemMoreOptionsView.frame.origin.x, self->itemMoreOptionsView.frame.origin.y + self->itemNotesView.frame.size.height + textFieldSpacing, self->itemNameView.frame.size.width, self->itemNameView.frame.size.height);
        
        
        
        /*-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
        
        
        
        self->itemGracePeriodView.frame = CGRectMake(self->itemNameView.frame.origin.x, textFieldSpacing, (width*1 - (textFieldSpacing*2)), (self->itemNameView.frame.size.height));
        self->itemPastDueView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemGracePeriodView.frame.origin.y + self->itemGracePeriodView.frame.size.height, (width*1 - (textFieldSpacing*2)), (self->itemNameView.frame.size.height));
        
        
        
        self->itemColorView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemPastDueView.frame.origin.y + self->itemPastDueView.frame.size.height + textFieldSpacing, repeatsViewWidth, (self->itemNameView.frame.size.height));
        self->itemTagsView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemColorView.frame.origin.y + self->itemColorView.frame.size.height, self->itemNameView.frame.size.width, self->itemNameView.frame.size.height);
        self->itemPriorityView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemTagsView.frame.origin.y + self->itemTagsView.frame.size.height, repeatsViewWidth, (self->itemNameView.frame.size.height));
        self->itemDifficultyView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemPriorityView.frame.origin.y + self->itemPriorityView.frame.size.height, repeatsViewWidth, (self->itemNameView.frame.size.height));
        
        
        
        self->itemRewardView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemDifficultyView.frame.origin.y + self->itemDifficultyView.frame.size.height + textFieldSpacing, repeatsViewWidth, (self->itemNameView.frame.size.height));
        self->itemPrivateView.frame = CGRectMake(self->itemNameView.frame.origin.x, self->itemRewardView.frame.origin.y + self->itemRewardView.frame.size.height, repeatsViewWidth, (self->itemNameView.frame.size.height));
        
        
        
        CGFloat heightToUse = self->deleteButton.frame.origin.y + self->deleteButton.frame.size.height + textFieldSpacing;
        if (heightToUse + bottomPadding < self.view.frame.size.height) {
            heightToUse = self.customScrollView.frame.size.height + 1;
        }
        
        CGFloat navigationBarHeight = [[[GeneralObject alloc] init] GetNavigationBarHeight:self];
        
        self->_customScrollView.contentSize = CGSizeMake(self.view.frame.size.width, heightToUse + bottomPadding + navigationBarHeight);
        
        self->tapView.frame = self->itemDaysView.frame;
        self->tapView.alpha = self->itemDaysView.alpha;
        self->tapView.hidden = self->itemDaysView.hidden;
        
        
        
        [self AdjustTextFieldViewsToUse];
        
        
        
        if (self->_viewingMoreOptions == NO) {
            
            self->itemSubTasksView.hidden = YES;
            self->itemRewardView.hidden = YES;
            self->itemDifficultyView.hidden = YES;
            self->itemPriorityView.hidden = YES;
            self->itemColorView.hidden = YES;
            self->itemPrivateView.hidden = YES;
            self->itemTagsView.hidden = YES;
            self->itemPastDueView.hidden = YES;
            self->itemGracePeriodView.hidden = YES;
            
        } else {
            
            self->itemNameView.hidden = YES;
            self->itemAssignedToView.hidden = YES;
            self->itemListItemsView.hidden = YES;
            self->itemDueDateView.hidden = YES;
            self->itemMustCompleteView.hidden = YES;
            self->itemRepeatsView.hidden = YES;
            self->itemRepeatIfCompletedEarlyView.hidden = YES;
            self->itemStartDateView.hidden = YES;
            self->itemEndDateView.hidden = YES;
            self->itemDueDateView.hidden = YES;
            self->itemDaysView.hidden = YES;
            self->itemTimeView.hidden = YES;
            self->itemEveryoneTakesTurnsView.hidden = YES;
            self->itemAlternateTurnsView.hidden = YES;
            self->itemTurnOrderView.hidden = YES;
            self->itemReminderView.hidden = YES;
            self->itemMoreOptionsView.hidden = YES;
            self->itemAddImageView.hidden = YES;
            self->itemNotesView.hidden = YES;
            self->deleteButton.hidden = YES;
            
        }
        
    }];
    
}

#pragma mark

-(void)AdjustTextFieldViewsToUse {
    
    if (_viewingAddExpenseViewController == YES) {
        
        [self AdjustTextFieldViewsExpenses];
        
    } else if (_viewingAddListViewController == YES) {
        
        [self AdjustTextFieldViewsLists];
        
    } else {
        
        [self AdjustTextFieldViewsChores];
        
    }
    
}

-(void)AdjustTextFieldViewsChores {
    
    NSString *itemDueDateTextFieldText = self->itemDueDateTextField.text ? self->itemDueDateTextField.text : @"";
    NSString *itemDaysTextFieldText = self->itemDaysTextField.text ? self->itemDaysTextField.text : @"";
    NSString *itemRepeatsTextFieldText = self->itemRepeatsTextField.text ? self->itemRepeatsTextField.text : @"";
    NSString *chosenItemRepeatIfCompletedEarlyLocal = chosenItemRepeatIfCompletedEarly ? chosenItemRepeatIfCompletedEarly : @"";
    NSMutableArray *itemSpecificDueDatesArrayLocal = itemSpecificDueDatesArray ? itemSpecificDueDatesArray : [NSMutableArray array];
    
    CGFloat cornerRadius = (self.view.frame.size.height*0.2181818182 > 12?12:(self.view.frame.size.height*0.2181818182));
    
    BOOL TaskHasMultipleDueDate =  [[[BoolDataObject alloc] init] TaskHasMultipleDueDate:[@{@"ItemSpecificDueDates" : itemSpecificDueDatesArrayLocal, @"ItemRepeats" : itemRepeatsTextFieldText, @"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal} mutableCopy] itemType:itemType];
    BOOL TaskHasNoDueDate = [[[BoolDataObject alloc] init] TaskHasNoDueDate:[@{@"ItemDueDate" : itemDueDateTextFieldText, @"ItemSpecificDueDates" : itemSpecificDueDatesArrayLocal, @"ItemRepeats" : itemRepeatsTextFieldText, @"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal} mutableCopy] itemType:itemType];
    BOOL TaskIsRepeating = [[[BoolDataObject alloc] init] TaskIsRepeating:[@{@"ItemRepeats" : itemRepeatsTextFieldText, @"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal} mutableCopy] itemType:itemType];
    BOOL TaskIsRepeatingAsNeeded = [[[BoolDataObject alloc] init] TaskIsRepeatingAsNeeded:[@{@"ItemRepeats" : itemRepeatsTextFieldText, @"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal} mutableCopy] itemType:itemType];
    BOOL TaskIsRepeatingHourly = [[[BoolDataObject alloc] init] TaskIsRepeatingHourly:[@{@"ItemRepeats" : itemRepeatsTextFieldText} mutableCopy] itemType:itemType];
    BOOL TaskIsRepeatingWeekly = [[[BoolDataObject alloc] init] TaskIsRepeatingWeekly:[@{@"ItemRepeats" : itemRepeatsTextFieldText} mutableCopy] itemType:itemType];
    BOOL TaskIsRepeatingMonthly = [[[BoolDataObject alloc] init] TaskIsRepeatingMonthly:[@{@"ItemRepeats" : itemRepeatsTextFieldText} mutableCopy] itemType:itemType];
    BOOL TaskIsRepeatingWhenCompleted = [[[BoolDataObject alloc] init] TaskIsRepeatingWhenCompleted:[@{@"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal ? chosenItemRepeatIfCompletedEarlyLocal : @"No", @"ItemRepeats" : itemRepeatsTextFieldText} mutableCopy] itemType:itemType];
    BOOL TaskIsTakingTurns = [itemEveryoneTakesTurnsSwitch isOn];
    BOOL TaskIsAssignedToMoreThanOnePerson = [[self GenerateItemAssignedTo:@"No"] count] != 1;
    BOOL TaskIsAssignedToNobody = [[self GenerateItemAssignedTo:@"No"] count] == 0;
    
    if (TaskIsRepeating == NO) {
        
        if (TaskIsRepeatingAsNeeded == NO) {
            
            if (TaskIsAssignedToMoreThanOnePerson == NO) {
                
                [[[GeneralObject alloc] init] RoundingCorners:itemAssignedToView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
                [[[GeneralObject alloc] init] RoundingCorners:itemRepeatsView topCorners:NO   bottomCorners:NO cornerRadius:cornerRadius];
                
            } else {
                
                [[[GeneralObject alloc] init] RoundingCorners:itemAssignedToView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
                [[[GeneralObject alloc] init] RoundingCorners:itemMustCompleteView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
                
                [[[GeneralObject alloc] init] RoundingCorners:itemRepeatsView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
                
            }
            
            if (TaskHasNoDueDate == NO && TaskHasMultipleDueDate == NO) {
                
                [[[GeneralObject alloc] init] RoundingCorners:itemDueDateView topCorners:NO bottomCorners:NO cornerRadius:cornerRadius];
                [[[GeneralObject alloc] init] RoundingCorners:itemTimeView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
                
            } else {
                
                [[[GeneralObject alloc] init] RoundingCorners:itemDueDateView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
                
            }
            
        } else {
            
            if (TaskIsAssignedToMoreThanOnePerson == NO) {
                
                [[[GeneralObject alloc] init] RoundingCorners:itemAssignedToView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
                [[[GeneralObject alloc] init] RoundingCorners:itemRepeatsView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
                
            } else {
                
                if (TaskIsTakingTurns == NO) {
                    
                    [[[GeneralObject alloc] init] RoundingCorners:itemAssignedToView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
                    [[[GeneralObject alloc] init] RoundingCorners:itemRepeatsView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
                    
                } else {
                    
                    [[[GeneralObject alloc] init] RoundingCorners:itemAssignedToView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
                    [[[GeneralObject alloc] init] RoundingCorners:itemRepeatsView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
                    
                }
                
            }
            
            if (TaskIsTakingTurns == NO) {
                
                [[[GeneralObject alloc] init] RoundingCorners:itemEveryoneTakesTurnsView topCorners:YES bottomCorners:YES cornerRadius:cornerRadius];
                
            } else {
                
                [[[GeneralObject alloc] init] RoundingCorners:itemEveryoneTakesTurnsView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
                [[[GeneralObject alloc] init] RoundingCorners:itemTurnOrderView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
                
            }
            
        }
        
    } else {
        
        BOOL DisplayCompletedByView = [self DisplayMustCompleteView];
        
        if (DisplayCompletedByView) {
            
            [[[GeneralObject alloc] init] RoundingCorners:itemAssignedToView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
            [[[GeneralObject alloc] init] RoundingCorners:itemMustCompleteView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
            
            [[[GeneralObject alloc] init] RoundingCorners:itemRepeatsView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
            [[[GeneralObject alloc] init] RoundingCorners:itemEndDateView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
       
        } else {
            
            [[[GeneralObject alloc] init] RoundingCorners:itemAssignedToView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
            [[[GeneralObject alloc] init] RoundingCorners:itemRepeatsView topCorners:NO bottomCorners:NO cornerRadius:cornerRadius];
            [[[GeneralObject alloc] init] RoundingCorners:itemEndDateView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
            
        }
        
        if (TaskIsRepeatingWeekly == NO && TaskIsRepeatingMonthly == NO) {
            
            if (TaskIsRepeatingAsNeeded == YES || (TaskIsRepeatingWhenCompleted == YES && TaskIsAssignedToNobody == NO && TaskIsAssignedToMoreThanOnePerson == NO)) {
                
                [[[GeneralObject alloc] init] RoundingCorners:itemAssignedToView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
                [[[GeneralObject alloc] init] RoundingCorners:itemRepeatsView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
                
                if (TaskIsTakingTurns == NO) {
                    
                    [[[GeneralObject alloc] init] RoundingCorners:itemEveryoneTakesTurnsView topCorners:YES bottomCorners:YES cornerRadius:cornerRadius];
                    
                } else if (TaskIsTakingTurns == YES) {
                    
                    [[[GeneralObject alloc] init] RoundingCorners:itemEveryoneTakesTurnsView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
                    [[[GeneralObject alloc] init] RoundingCorners:itemTurnOrderView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
                    
                }
                
            } else if (TaskIsRepeatingWhenCompleted == YES && (TaskIsAssignedToNobody == YES || TaskIsAssignedToMoreThanOnePerson == YES)) {
                
                if (TaskIsTakingTurns == NO) {
                    
                    [[[GeneralObject alloc] init] RoundingCorners:itemRepeatsView topCorners:YES bottomCorners:YES cornerRadius:cornerRadius];
                   
                    [[[GeneralObject alloc] init] RoundingCorners:itemEveryoneTakesTurnsView topCorners:YES bottomCorners:YES cornerRadius:cornerRadius];
                    
                } else if (TaskIsTakingTurns == YES) {
                    
                    [[[GeneralObject alloc] init] RoundingCorners:itemRepeatsView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
                    
                    [[[GeneralObject alloc] init] RoundingCorners:itemEveryoneTakesTurnsView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
                    [[[GeneralObject alloc] init] RoundingCorners:itemTurnOrderView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
                    
                }
                
            } else if (TaskIsAssignedToNobody == YES) {
                
                [[[GeneralObject alloc] init] RoundingCorners:itemTimeView topCorners:YES bottomCorners:YES cornerRadius:cornerRadius];
                
            } else if (TaskIsTakingTurns == NO) {
                
                if (TaskIsRepeatingHourly == YES) {
                    
                    [[[GeneralObject alloc] init] RoundingCorners:itemEveryoneTakesTurnsView topCorners:YES bottomCorners:YES cornerRadius:cornerRadius];
                    
                } else {
                    
                    [[[GeneralObject alloc] init] RoundingCorners:itemTimeView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
                    [[[GeneralObject alloc] init] RoundingCorners:itemEveryoneTakesTurnsView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
                    
                }
                
            } else {
                
                if (TaskIsRepeatingHourly == YES) {
                    
                    [[[GeneralObject alloc] init] RoundingCorners:itemEveryoneTakesTurnsView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
                    [[[GeneralObject alloc] init] RoundingCorners:itemTurnOrderView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
                    
                } else {
                    
                    [[[GeneralObject alloc] init] RoundingCorners:itemTimeView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
                    [[[GeneralObject alloc] init] RoundingCorners:itemEveryoneTakesTurnsView topCorners:NO bottomCorners:NO cornerRadius:cornerRadius];
                    [[[GeneralObject alloc] init] RoundingCorners:itemTurnOrderView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
                    
                }
                
            }
            
        } else {
            
            if ([itemDaysTextFieldText isEqualToString:@"Any Day"]) {
                
                if (TaskIsAssignedToNobody == YES) {
                    
                    [[[GeneralObject alloc] init] RoundingCorners:itemDaysView topCorners:YES bottomCorners:YES cornerRadius:cornerRadius];
                    
                } else if (TaskIsTakingTurns == NO) {
                    
                    [[[GeneralObject alloc] init] RoundingCorners:itemDaysView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
                    [[[GeneralObject alloc] init] RoundingCorners:itemEveryoneTakesTurnsView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
                    
                } else {
                    
                    [[[GeneralObject alloc] init] RoundingCorners:itemDaysView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
                    [[[GeneralObject alloc] init] RoundingCorners:itemEveryoneTakesTurnsView topCorners:NO bottomCorners:NO cornerRadius:cornerRadius];
                    [[[GeneralObject alloc] init] RoundingCorners:itemTurnOrderView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
                    
                }
                
            } else {
                
                if (TaskIsAssignedToNobody == YES) {
                    
                    [[[GeneralObject alloc] init] RoundingCorners:itemDaysView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
                    [[[GeneralObject alloc] init] RoundingCorners:itemTimeView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
                    
                } else if (TaskIsTakingTurns == NO) {
                    
                    [[[GeneralObject alloc] init] RoundingCorners:itemDaysView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
                    [[[GeneralObject alloc] init] RoundingCorners:itemTimeView topCorners:NO bottomCorners:NO cornerRadius:cornerRadius];
                    [[[GeneralObject alloc] init] RoundingCorners:itemEveryoneTakesTurnsView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
                    
                } else {
                    
                    [[[GeneralObject alloc] init] RoundingCorners:itemDaysView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
                    [[[GeneralObject alloc] init] RoundingCorners:itemTimeView topCorners:NO bottomCorners:NO cornerRadius:cornerRadius];
                    [[[GeneralObject alloc] init] RoundingCorners:itemEveryoneTakesTurnsView topCorners:NO bottomCorners:NO cornerRadius:cornerRadius];
                    [[[GeneralObject alloc] init] RoundingCorners:itemTurnOrderView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
                    
                }
                
            }
            
        }
        
    }
    
    
    
    [[[GeneralObject alloc] init] RoundingCorners:itemSubTasksView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
    [[[GeneralObject alloc] init] RoundingCorners:itemPastDueView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
    
    [[[GeneralObject alloc] init] RoundingCorners:itemColorView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
    [[[GeneralObject alloc] init] RoundingCorners:itemDifficultyView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
    
    [[[GeneralObject alloc] init] RoundingCorners:itemRewardView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
    [[[GeneralObject alloc] init] RoundingCorners:itemPrivateView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
    
    
    
    NSArray *arrView = @[itemNameView, itemNotesView, itemGracePeriodView, itemAssignedToView, itemMustCompleteView, itemRepeatsView, itemDueDateView, itemRepeatIfCompletedEarlyView, itemEveryoneTakesTurnsView, itemAlternateTurnsView, itemTurnOrderView, itemStartDateView, itemEndDateView, itemDaysView, itemTimeView, itemSubTasksView, itemReminderView, itemDifficultyView, itemPriorityView, itemColorView, itemPrivateView, itemRewardView, itemApprovalNeededView, itemPastDueView, itemTagsView];
    
    for (UIView *viewNo1 in arrView) {
        
        for (UIView *subViewNo1 in [viewNo1 subviews]) {
            
            if (subViewNo1.tag == 1111) {
                
                [subViewNo1 removeFromSuperview];
                
            }
            
        }
        
    }
    
    for (UIView *viewNo1 in arrView) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(viewNo1.frame.size.width*0.04830918, viewNo1.frame.size.height-1, viewNo1.frame.size.width - (viewNo1.frame.size.width*0.04830918), 1)];
        view.backgroundColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTextSecondary] : [[[LightDarkModeObject alloc] init] LightModeSubviewLine];
        view.tag = 1111;
        [viewNo1 addSubview:view];
        
    }
    
}

-(void)AdjustTextFieldViewsExpenses {
    
    NSString *itemDueDateTextFieldText = self->itemDueDateTextField.text ? self->itemDueDateTextField.text : @"";
    NSString *itemDaysTextFieldText = self->itemDaysTextField.text ? self->itemDaysTextField.text : @"";
    NSString *itemRepeatsTextFieldText = self->itemRepeatsTextField.text ? self->itemRepeatsTextField.text : @"";
    NSString *chosenItemRepeatIfCompletedEarlyLocal = chosenItemRepeatIfCompletedEarly ? chosenItemRepeatIfCompletedEarly : @"";
    NSMutableArray *itemSpecificDueDatesArrayLocal = itemSpecificDueDatesArray ? itemSpecificDueDatesArray : [NSMutableArray array];
    
    CGFloat cornerRadius = (self.view.frame.size.height*0.2181818182 > 12?12:(self.view.frame.size.height*0.2181818182));
    
    BOOL TaskHasMultipleDueDate =  [[[BoolDataObject alloc] init] TaskHasMultipleDueDate:[@{@"ItemSpecificDueDates" : itemSpecificDueDatesArrayLocal, @"ItemRepeats" : itemRepeatsTextFieldText, @"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal} mutableCopy] itemType:itemType];
    BOOL TaskHasNoDueDate = [[[BoolDataObject alloc] init] TaskHasNoDueDate:[@{@"ItemDueDate" : itemDueDateTextFieldText, @"ItemSpecificDueDates" : itemSpecificDueDatesArrayLocal, @"ItemRepeats" : itemRepeatsTextFieldText, @"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal} mutableCopy] itemType:itemType];
    BOOL TaskIsRepeating = [[[BoolDataObject alloc] init] TaskIsRepeating:[@{@"ItemRepeats" : itemRepeatsTextFieldText, @"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal} mutableCopy] itemType:itemType];
    BOOL TaskIsRepeatingHourly = [[[BoolDataObject alloc] init] TaskIsRepeatingHourly:[@{@"ItemRepeats" : itemRepeatsTextFieldText} mutableCopy] itemType:itemType];
    BOOL TaskIsRepeatingWeekly = [[[BoolDataObject alloc] init] TaskIsRepeatingWeekly:[@{@"ItemRepeats" : itemRepeatsTextFieldText} mutableCopy] itemType:itemType];
    BOOL TaskIsRepeatingMonthly = [[[BoolDataObject alloc] init] TaskIsRepeatingMonthly:[@{@"ItemRepeats" : itemRepeatsTextFieldText} mutableCopy] itemType:itemType];
    BOOL TaskIsRepeatingWhenCompleted = [[[BoolDataObject alloc] init] TaskIsRepeatingWhenCompleted:[@{@"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal ? chosenItemRepeatIfCompletedEarlyLocal : @"No", @"ItemRepeats" : itemRepeatsTextFieldText} mutableCopy] itemType:itemType];
    BOOL TaskIsRepeatingAsNeeded = [[[BoolDataObject alloc] init] TaskIsRepeatingAsNeeded:[@{@"ItemRepeats" : itemRepeatsTextFieldText, @"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal} mutableCopy] itemType:itemType];
    BOOL TaskIsTakingTurns = [itemEveryoneTakesTurnsSwitch isOn];
    BOOL TaskIsAssignedToMoreThanOnePerson = [[self GenerateItemAssignedTo:@"No"] count] != 1;
    BOOL TaskIsAssignedToNobody = [[self GenerateItemAssignedTo:@"No"] count] == 0;
    
    if (TaskIsRepeating == NO) {
        
        if (TaskIsRepeatingAsNeeded == NO) {
            
            if (TaskIsAssignedToMoreThanOnePerson == NO) {
                
                [[[GeneralObject alloc] init] RoundingCorners:itemAssignedToView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
                [[[GeneralObject alloc] init] RoundingCorners:itemPaymentMethodView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
                
                //                if (TaskIsRepeatingOneTime == NO) {
                
                [[[GeneralObject alloc] init] RoundingCorners:itemRepeatsView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
                
                //                } else {
                //
                //                    [[[GeneralObject alloc] init] RoundingCorners:itemRepeatsView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
                //                    [[[GeneralObject alloc] init] RoundingCorners:itemDueDateView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
                //
                //                }
                
            } else {
                
                [[[GeneralObject alloc] init] RoundingCorners:itemAssignedToView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
                [[[GeneralObject alloc] init] RoundingCorners:itemPaymentMethodView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
                
                //                if (TaskIsRepeatingOneTime == NO) {
                
                [[[GeneralObject alloc] init] RoundingCorners:itemRepeatsView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
                
                //                } else {
                //
                //                    [[[GeneralObject alloc] init] RoundingCorners:itemRepeatsView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
                //                    [[[GeneralObject alloc] init] RoundingCorners:itemDueDateView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
                //
                //                }
                
            }
            
            if (TaskHasNoDueDate == NO && TaskHasMultipleDueDate == NO) {
                
                [[[GeneralObject alloc] init] RoundingCorners:itemDueDateView topCorners:NO bottomCorners:NO cornerRadius:cornerRadius];
                [[[GeneralObject alloc] init] RoundingCorners:itemTimeView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
                
            } else {
                
                [[[GeneralObject alloc] init] RoundingCorners:itemDueDateView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
                
            }
            
        } else {
            
            [[[GeneralObject alloc] init] RoundingCorners:itemAssignedToView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
            [[[GeneralObject alloc] init] RoundingCorners:itemPaymentMethodView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
            
            [[[GeneralObject alloc] init] RoundingCorners:itemRepeatsView topCorners:YES bottomCorners:YES cornerRadius:cornerRadius];
            
            if (TaskIsTakingTurns == NO) {
                
                [[[GeneralObject alloc] init] RoundingCorners:itemEveryoneTakesTurnsView topCorners:YES bottomCorners:YES cornerRadius:cornerRadius];
                
            } else {
                
                [[[GeneralObject alloc] init] RoundingCorners:itemEveryoneTakesTurnsView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
                [[[GeneralObject alloc] init] RoundingCorners:itemTurnOrderView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
                
            }
            
        }
        
    } else {
        
        [[[GeneralObject alloc] init] RoundingCorners:itemAssignedToView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
        [[[GeneralObject alloc] init] RoundingCorners:itemPaymentMethodView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
        
        [[[GeneralObject alloc] init] RoundingCorners:itemRepeatsView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
        [[[GeneralObject alloc] init] RoundingCorners:itemEndDateView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
        
        if (TaskIsRepeatingWeekly == NO && TaskIsRepeatingMonthly == NO) {
            
            if (TaskIsRepeatingAsNeeded == YES || TaskIsRepeatingWhenCompleted == YES) {
                
                if (TaskIsTakingTurns == NO) {
                    
                    [[[GeneralObject alloc] init] RoundingCorners:itemEveryoneTakesTurnsView topCorners:YES bottomCorners:YES cornerRadius:cornerRadius];
                    
                } else {
                    
                    [[[GeneralObject alloc] init] RoundingCorners:itemEveryoneTakesTurnsView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
                    [[[GeneralObject alloc] init] RoundingCorners:itemTurnOrderView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
                    
                }
                
                [[[GeneralObject alloc] init] RoundingCorners:itemRepeatsView topCorners:YES bottomCorners:YES cornerRadius:cornerRadius];
                
            } else if (TaskIsAssignedToNobody == YES) {
                
                [[[GeneralObject alloc] init] RoundingCorners:itemTimeView topCorners:YES bottomCorners:YES cornerRadius:cornerRadius];
                
            } else if (TaskIsTakingTurns == NO) {
                
                if (TaskIsRepeatingHourly == YES) {
                    
                    [[[GeneralObject alloc] init] RoundingCorners:itemEveryoneTakesTurnsView topCorners:YES bottomCorners:YES cornerRadius:cornerRadius];
                    
                } else {
                    
                    [[[GeneralObject alloc] init] RoundingCorners:itemTimeView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
                    [[[GeneralObject alloc] init] RoundingCorners:itemEveryoneTakesTurnsView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
                    
                }
                
            } else {
                
                [[[GeneralObject alloc] init] RoundingCorners:itemTimeView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
                
                if (TaskIsTakingTurns == NO) {
                    
                    [[[GeneralObject alloc] init] RoundingCorners:itemEveryoneTakesTurnsView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
                    
                } else {
                    
                    [[[GeneralObject alloc] init] RoundingCorners:itemEveryoneTakesTurnsView topCorners:NO bottomCorners:NO cornerRadius:cornerRadius];
                    [[[GeneralObject alloc] init] RoundingCorners:itemTurnOrderView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
                    
                }
                
            }
            
        } else {
            
            if ([itemDaysTextFieldText isEqualToString:@"Any Day"]) {
                
                if (TaskIsAssignedToNobody == YES) {
                    
                    [[[GeneralObject alloc] init] RoundingCorners:itemDaysView topCorners:YES bottomCorners:YES cornerRadius:cornerRadius];
                    
                } else if (TaskIsTakingTurns == NO) {
                    
                    [[[GeneralObject alloc] init] RoundingCorners:itemDaysView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
                    [[[GeneralObject alloc] init] RoundingCorners:itemEveryoneTakesTurnsView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
                    
                } else {
                    
                    [[[GeneralObject alloc] init] RoundingCorners:itemDaysView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
                    [[[GeneralObject alloc] init] RoundingCorners:itemEveryoneTakesTurnsView topCorners:NO bottomCorners:NO cornerRadius:cornerRadius];
                    [[[GeneralObject alloc] init] RoundingCorners:itemTurnOrderView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
                    
                }
                
            } else {
                
                if (TaskIsAssignedToNobody == YES) {
                    
                    [[[GeneralObject alloc] init] RoundingCorners:itemDaysView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
                    [[[GeneralObject alloc] init] RoundingCorners:itemTimeView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
                    
                } else if (TaskIsTakingTurns == NO) {
                    
                    [[[GeneralObject alloc] init] RoundingCorners:itemDaysView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
                    [[[GeneralObject alloc] init] RoundingCorners:itemTimeView topCorners:NO bottomCorners:NO cornerRadius:cornerRadius];
                    [[[GeneralObject alloc] init] RoundingCorners:itemEveryoneTakesTurnsView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
                    
                } else {
                    
                    [[[GeneralObject alloc] init] RoundingCorners:itemDaysView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
                    [[[GeneralObject alloc] init] RoundingCorners:itemTimeView topCorners:NO bottomCorners:NO cornerRadius:cornerRadius];
                    [[[GeneralObject alloc] init] RoundingCorners:itemEveryoneTakesTurnsView topCorners:NO bottomCorners:NO cornerRadius:cornerRadius];
                    [[[GeneralObject alloc] init] RoundingCorners:itemTurnOrderView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
                    
                }
                
            }
            
        }
        
    }
    
    
    
    [[[GeneralObject alloc] init] RoundingCorners:itemGracePeriodView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
    [[[GeneralObject alloc] init] RoundingCorners:itemPastDueView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
    
    [[[GeneralObject alloc] init] RoundingCorners:itemColorView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
    [[[GeneralObject alloc] init] RoundingCorners:itemDifficultyView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
    
    [[[GeneralObject alloc] init] RoundingCorners:itemRewardView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
    [[[GeneralObject alloc] init] RoundingCorners:itemPrivateView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
    
    NSArray *arrView = @[itemNameView, itemNotesView, itemRepeatIfCompletedEarlyView, itemGracePeriodView, itemAssignedToView, itemMustCompleteView, itemAmountView, itemCostPerPersonView, itemPaymentMethodView, itemRepeatsView, itemDueDateView, itemEveryoneTakesTurnsView, itemAlternateTurnsView, itemTurnOrderView, itemStartDateView, itemEndDateView, itemDaysView, itemTimeView, itemSubTasksView, itemReminderView, itemDifficultyView, itemPriorityView, itemColorView, itemPrivateView, itemRewardView, itemApprovalNeededView, itemPastDueView, itemTagsView];
    
    for (UIView *viewNo1 in arrView) {
        
        for (UIView *subViewNo1 in [viewNo1 subviews]) {
            
            if (subViewNo1.tag == 1111) {
                
                [subViewNo1 removeFromSuperview];
                
            }
            
        }
        
    }
    
    for (UIView *viewNo1 in arrView) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(viewNo1.frame.size.width*0.04830918, viewNo1.frame.size.height-1, viewNo1.frame.size.width - (viewNo1.frame.size.width*0.04830918), 1)];
        view.backgroundColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTextSecondary] : [[[LightDarkModeObject alloc] init] LightModeSubviewLine];
        view.tag = 1111;
        [viewNo1 addSubview:view];
        
    }
    
}

-(void)AdjustTextFieldViewsLists {
    
    NSString *itemDueDateTextFieldText = self->itemDueDateTextField.text ? self->itemDueDateTextField.text : @"";
    NSString *itemDaysTextFieldText = self->itemDaysTextField.text ? self->itemDaysTextField.text : @"";
    NSString *itemRepeatsTextFieldText = self->itemRepeatsTextField.text ? self->itemRepeatsTextField.text : @"";
    NSString *chosenItemRepeatIfCompletedEarlyLocal = chosenItemRepeatIfCompletedEarly ? chosenItemRepeatIfCompletedEarly : @"";
    NSMutableArray *itemSpecificDueDatesArrayLocal = itemSpecificDueDatesArray ? itemSpecificDueDatesArray : [NSMutableArray array];
    
    CGFloat cornerRadius = (self.view.frame.size.height*0.2181818182 > 12?12:(self.view.frame.size.height*0.2181818182));
    
    BOOL TaskHasMultipleDueDate =  [[[BoolDataObject alloc] init] TaskHasMultipleDueDate:[@{@"ItemSpecificDueDates" : itemSpecificDueDatesArrayLocal, @"ItemRepeats" : itemRepeatsTextFieldText, @"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal} mutableCopy] itemType:itemType];
    BOOL TaskHasNoDueDate = [[[BoolDataObject alloc] init] TaskHasNoDueDate:[@{@"ItemDueDate" : itemDueDateTextFieldText, @"ItemSpecificDueDates" : itemSpecificDueDatesArrayLocal, @"ItemRepeats" : itemRepeatsTextFieldText, @"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal} mutableCopy] itemType:itemType];
    BOOL TaskIsRepeating = [[[BoolDataObject alloc] init] TaskIsRepeating:[@{@"ItemRepeats" : itemRepeatsTextFieldText, @"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal} mutableCopy] itemType:itemType];
    BOOL TaskIsRepeatingHourly = [[[BoolDataObject alloc] init] TaskIsRepeatingHourly:[@{@"ItemRepeats" : itemRepeatsTextFieldText} mutableCopy] itemType:itemType];
    BOOL TaskIsRepeatingWeekly = [[[BoolDataObject alloc] init] TaskIsRepeatingWeekly:[@{@"ItemRepeats" : itemRepeatsTextFieldText} mutableCopy] itemType:itemType];
    BOOL TaskIsRepeatingMonthly = [[[BoolDataObject alloc] init] TaskIsRepeatingMonthly:[@{@"ItemRepeats" : itemRepeatsTextFieldText} mutableCopy] itemType:itemType];
    BOOL TaskIsRepeatingWhenCompleted = [[[BoolDataObject alloc] init] TaskIsRepeatingWhenCompleted:[@{@"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal ? chosenItemRepeatIfCompletedEarlyLocal : @"No", @"ItemRepeats" : itemRepeatsTextFieldText} mutableCopy] itemType:itemType];
    BOOL TaskIsRepeatingAsNeeded = [[[BoolDataObject alloc] init] TaskIsRepeatingAsNeeded:[@{@"ItemRepeats" : itemRepeatsTextFieldText, @"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal} mutableCopy] itemType:itemType];
    BOOL TaskIsTakingTurns = [itemEveryoneTakesTurnsSwitch isOn];
    BOOL TaskIsAssignedToMoreThanOnePerson = [[self GenerateItemAssignedTo:@"No"] count] != 1;
    BOOL TaskIsAssignedToNobody = [[self GenerateItemAssignedTo:@"No"] count] == 0;
    
    if (TaskIsRepeating == NO) {
        
        if (TaskIsRepeatingAsNeeded == NO) {
            
            if (TaskIsAssignedToMoreThanOnePerson == NO) {
                
                [[[GeneralObject alloc] init] RoundingCorners:itemAssignedToView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
                [[[GeneralObject alloc] init] RoundingCorners:itemListItemsView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
                
                [[[GeneralObject alloc] init] RoundingCorners:itemRepeatsView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
                
            } else {
                
                [[[GeneralObject alloc] init] RoundingCorners:itemAssignedToView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
                [[[GeneralObject alloc] init] RoundingCorners:itemListItemsView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
                
                [[[GeneralObject alloc] init] RoundingCorners:itemRepeatsView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
                
            }
            
            if (TaskHasNoDueDate == NO && TaskHasMultipleDueDate == NO) {
                
                [[[GeneralObject alloc] init] RoundingCorners:itemDueDateView topCorners:NO bottomCorners:NO cornerRadius:cornerRadius];
                [[[GeneralObject alloc] init] RoundingCorners:itemTimeView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
                
            } else {
                
                [[[GeneralObject alloc] init] RoundingCorners:itemDueDateView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
                
            }
            
        } else {
            
            [[[GeneralObject alloc] init] RoundingCorners:itemAssignedToView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
            [[[GeneralObject alloc] init] RoundingCorners:itemListItemsView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
            
            [[[GeneralObject alloc] init] RoundingCorners:itemRepeatsView topCorners:YES bottomCorners:YES cornerRadius:cornerRadius];
            
            if (TaskIsTakingTurns == NO) {
                
                [[[GeneralObject alloc] init] RoundingCorners:itemEveryoneTakesTurnsView topCorners:YES bottomCorners:YES cornerRadius:cornerRadius];
                
            } else {
                
                [[[GeneralObject alloc] init] RoundingCorners:itemEveryoneTakesTurnsView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
                [[[GeneralObject alloc] init] RoundingCorners:itemTurnOrderView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
                
            }
            
        }
        
    } else {
        
        [[[GeneralObject alloc] init] RoundingCorners:itemAssignedToView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
        [[[GeneralObject alloc] init] RoundingCorners:itemListItemsView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
        
        [[[GeneralObject alloc] init] RoundingCorners:itemRepeatsView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
        [[[GeneralObject alloc] init] RoundingCorners:itemEndDateView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
        
        if (TaskIsRepeatingWeekly == NO && TaskIsRepeatingMonthly == NO) {
            
            if (TaskIsRepeatingAsNeeded == YES || TaskIsRepeatingWhenCompleted == YES) {
                
                if (TaskIsTakingTurns == NO) {
                    
                    [[[GeneralObject alloc] init] RoundingCorners:itemEveryoneTakesTurnsView topCorners:YES bottomCorners:YES cornerRadius:cornerRadius];
                    
                } else {
                    
                    [[[GeneralObject alloc] init] RoundingCorners:itemEveryoneTakesTurnsView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
                    [[[GeneralObject alloc] init] RoundingCorners:itemTurnOrderView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
                    
                }
                
                [[[GeneralObject alloc] init] RoundingCorners:itemRepeatsView topCorners:YES bottomCorners:YES cornerRadius:cornerRadius];
                
            } else if (TaskIsAssignedToNobody == YES) {
                
                [[[GeneralObject alloc] init] RoundingCorners:itemTimeView topCorners:YES bottomCorners:YES cornerRadius:cornerRadius];
                
            } else if (TaskIsTakingTurns == NO) {
                
                if (TaskIsRepeatingHourly == YES) {
                    
                    [[[GeneralObject alloc] init] RoundingCorners:itemEveryoneTakesTurnsView topCorners:YES bottomCorners:YES cornerRadius:cornerRadius];
                    
                } else {
                    
                    [[[GeneralObject alloc] init] RoundingCorners:itemTimeView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
                    [[[GeneralObject alloc] init] RoundingCorners:itemEveryoneTakesTurnsView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
                    
                }
                
            } else {
                
                [[[GeneralObject alloc] init] RoundingCorners:itemTimeView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
                [[[GeneralObject alloc] init] RoundingCorners:itemEveryoneTakesTurnsView topCorners:NO bottomCorners:NO cornerRadius:cornerRadius];
                [[[GeneralObject alloc] init] RoundingCorners:itemTurnOrderView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
                
            }
            
        } else {
            
            if ([itemDaysTextFieldText isEqualToString:@"Any Day"]) {
                
                if (TaskIsAssignedToNobody == YES) {
                    
                    [[[GeneralObject alloc] init] RoundingCorners:itemDaysView topCorners:YES bottomCorners:YES cornerRadius:cornerRadius];
                    
                } else if (TaskIsTakingTurns == NO) {
                    
                    [[[GeneralObject alloc] init] RoundingCorners:itemDaysView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
                    [[[GeneralObject alloc] init] RoundingCorners:itemEveryoneTakesTurnsView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
                    
                } else {
                    
                    [[[GeneralObject alloc] init] RoundingCorners:itemDaysView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
                    [[[GeneralObject alloc] init] RoundingCorners:itemEveryoneTakesTurnsView topCorners:NO bottomCorners:NO cornerRadius:cornerRadius];
                    [[[GeneralObject alloc] init] RoundingCorners:itemTurnOrderView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
                    
                }
                
            } else {
                
                if (TaskIsAssignedToNobody == YES) {
                    
                    [[[GeneralObject alloc] init] RoundingCorners:itemDaysView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
                    [[[GeneralObject alloc] init] RoundingCorners:itemTimeView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
                    
                } else if (TaskIsTakingTurns == NO) {
                    
                    [[[GeneralObject alloc] init] RoundingCorners:itemDaysView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
                    [[[GeneralObject alloc] init] RoundingCorners:itemTimeView topCorners:NO bottomCorners:NO cornerRadius:cornerRadius];
                    [[[GeneralObject alloc] init] RoundingCorners:itemEveryoneTakesTurnsView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
                    
                } else {
                    
                    [[[GeneralObject alloc] init] RoundingCorners:itemDaysView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
                    [[[GeneralObject alloc] init] RoundingCorners:itemTimeView topCorners:NO bottomCorners:NO cornerRadius:cornerRadius];
                    [[[GeneralObject alloc] init] RoundingCorners:itemEveryoneTakesTurnsView topCorners:NO bottomCorners:NO cornerRadius:cornerRadius];
                    [[[GeneralObject alloc] init] RoundingCorners:itemTurnOrderView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
                    
                }
                
            }
            
        }
        
    }
    
    
    
    [[[GeneralObject alloc] init] RoundingCorners:itemGracePeriodView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
    [[[GeneralObject alloc] init] RoundingCorners:itemPastDueView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
    
    [[[GeneralObject alloc] init] RoundingCorners:itemColorView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
    [[[GeneralObject alloc] init] RoundingCorners:itemDifficultyView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
    
    [[[GeneralObject alloc] init] RoundingCorners:itemRewardView topCorners:YES bottomCorners:NO cornerRadius:cornerRadius];
    [[[GeneralObject alloc] init] RoundingCorners:itemPrivateView topCorners:NO bottomCorners:YES cornerRadius:cornerRadius];
    
    
    
    NSArray *arrView = @[itemNameView, itemNotesView, itemRepeatIfCompletedEarlyView, itemGracePeriodView, itemAssignedToView, itemMustCompleteView, itemListItemsView, itemRepeatsView, itemDueDateView, itemEveryoneTakesTurnsView, itemAlternateTurnsView, itemTurnOrderView, itemStartDateView, itemEndDateView, itemDaysView, itemTimeView, itemSubTasksView, itemReminderView, itemDifficultyView, itemPriorityView, itemColorView, itemPrivateView, itemRewardView, itemApprovalNeededView, itemPastDueView, itemTagsView];
    
    for (UIView *viewNo1 in arrView) {
        
        for (UIView *subViewNo1 in [viewNo1 subviews]) {
            
            if (subViewNo1.tag == 1111) {
                
                [subViewNo1 removeFromSuperview];
                
            }
            
        }
        
    }
    
    for (UIView *viewNo1 in arrView) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(viewNo1.frame.size.width*0.04830918, viewNo1.frame.size.height-1, viewNo1.frame.size.width - (viewNo1.frame.size.width*0.04830918), 1)];
        view.backgroundColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTextSecondary] : [[[LightDarkModeObject alloc] init] LightModeSubviewLine];
        view.tag = 1111;
        [viewNo1 addSubview:view];
        
    }
    
}

#pragma mark

-(void)MustCompleteTextField_Everyone {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Keyboard Toolbar Button \"Everything\" (Must Complete) Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    completedByOnlyComp = @"";
    completedByAmountComp = @"";
    
    itemMustCompleteTextField.text = @"Everyone";
    
}

-(void)AmountTextField_Itemized {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Keyboard Toolbar Button \"Itemize\" (Amount) Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    [self TapGestureItemItemize:nil];
    
}

-(void)NotesTextField_Done {
    
    [self DismissAllKeyboards:NO];
    
    if ([itemNotesTextField isFirstResponder]) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Keyboard Toolbar Button \"Done\" (Notes) Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
            
        }];
        
        if (itemNotesTextField.text.length == 0) {
            
            itemNotesTextField.textColor = [UIColor colorWithRed:181.0f/255.0f green:188.0f/255.0f blue:193.0f/255.0f alpha:1.0f];
            itemNotesTextField.text = @"Notes";
            [itemNotesTextField resignFirstResponder];
            
        }
        
    } else {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Keyboard Toolbar Button \"Done\" (Name) Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
            
        }];
        
    }
    
}

-(void)StartTextField_Clear {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Keyboard Toolbar Button \"Clear\" (Start Repeating) Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    itemStartDateTextField.text = @"";
    
}

-(void)EndTextField_Never {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Keyboard Toolbar Button \"Never\" (End Repeating) Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    itemEndDateTextField.text = @"Never";
    
}

-(void)TimeTextField_AnyTime {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Keyboard Toolbar Button \"Anytime\" (Time) Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    itemTimeTextField.text = @"Any Time";
    
    itemReminderDict = [[self GenerateItemReminder:itemDueDateTextField.text itemRepeats:itemRepeatsTextField.text itemTime:itemTimeTextField.text SettingData:NO] mutableCopy];
    itemReminderTextField.text = [NSString stringWithFormat:@"%lu", (unsigned long)[[itemReminderDict allKeys] count]];
    
}

-(void)GracePeriodTextField_None {
    
    if ([itemGracePeriodTextField isFirstResponder]) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Keyboard Toolbar Button \"None\" (Grace Period) Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
            
        }];
        
        itemGracePeriodTextField.text = @"None";
        [self->itemGracePeriodTextField resignFirstResponder];
        
    }
    
    [self DismissAllKeyboards:NO];
    
}

#pragma mark - UX Methods

-(BOOL)TaskBeingAddedHasErrors {
    
    NSString *itemRepeatsTextFieldText = self->itemRepeatsTextField.text ? self->itemRepeatsTextField.text : @"";
    NSString *chosenItemRepeatIfCompletedEarlyLocal = chosenItemRepeatIfCompletedEarly ? chosenItemRepeatIfCompletedEarly : @"";
    
    NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
    NSString *trimmedStringItemName = [itemNameTextField.text stringByTrimmingCharactersInSet:charSet];
    NSString *trimmedStringItemStartDate = [itemStartDateTextField.text stringByTrimmingCharactersInSet:charSet];
    NSString *trimmedStringItemEndDate = [itemEndDateTextField.text stringByTrimmingCharactersInSet:charSet];
    NSString *trimmedStringItemAmount = [itemAmountTextField.text stringByTrimmingCharactersInSet:charSet];
    NSString *trimmedStringItemAssignedTo = [itemAssignedToTextField.text stringByTrimmingCharactersInSet:charSet];
    NSString *trimmedStringItemDays = [itemDaysTextField.text stringByTrimmingCharactersInSet:charSet];
    NSString *trimmedStringItemListItems = [itemListItemsTextField.text stringByTrimmingCharactersInSet:charSet];
    
    if ([trimmedStringItemStartDate isEqualToString:@"Now"]) {
        trimmedStringItemStartDate = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:@"MMMM dd, yyyy" returnAs:[NSString class]];
    }
    
    
    
    
    NSString *itemDueDate = itemDueDateTextField.text;
    itemDueDate = itemTimeTextField.text.length > 0 ? [NSString stringWithFormat:@"%@ %@", itemDueDate, itemTimeTextField.text] : [NSString stringWithFormat:@"%@ %@", itemDueDate, @"Any Time"];
    itemDueDate = [[[GeneralObject alloc] init] GenerateStringWithReplacementString:itemDueDate stringToReplace:@"Any Time" replacementString:@"11:59 PM"];
    
    NSString *dateFormat = @"MMMM dd, yyyy hh:mm a";
    
    if ([[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:itemDueDate returnAs:[NSDate class]] == nil) {
        
        dateFormat = @"MMMM dd, yyyy h:mm a";
    }
    
    if ([[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:itemDueDate returnAs:[NSDate class]] == nil) {
        
        dateFormat = @"MMMM dd, yyyy";
    }
    
    if ([[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:itemDueDate returnAs:[NSDate class]] == nil) {
        
        dateFormat = @"EEE, MMMM dd, yyyy hh:mm a";
    }
    
    NSString *dateStringCurrent = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:dateFormat returnAs:[NSString class]];
    
    
    
    
    BOOL TaskIsRepeating = [[[BoolDataObject alloc] init] TaskIsRepeating:[@{@"ItemRepeats" : itemRepeatsTextFieldText, @"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal} mutableCopy] itemType:itemType];
    BOOL TaskIsRepeatingHourly = [[[BoolDataObject alloc] init] TaskIsRepeatingHourly:[@{@"ItemRepeats" : itemRepeatsTextFieldText, @"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal} mutableCopy] itemType:itemType];
    BOOL TaskIsRepeatingDaily = [[[BoolDataObject alloc] init] TaskIsRepeatingDaily:[@{@"ItemRepeats" : itemRepeatsTextFieldText} mutableCopy] itemType:itemType];
    BOOL TaskIsRepeatingWeekly = [[[BoolDataObject alloc] init] TaskIsRepeatingWeekly:[@{@"ItemRepeats" : itemRepeatsTextFieldText} mutableCopy] itemType:itemType];
    BOOL TaskIsRepeatingMonthly = [[[BoolDataObject alloc] init] TaskIsRepeatingMonthly:[@{@"ItemRepeats" : itemRepeatsTextFieldText} mutableCopy] itemType:itemType];
    
    BOOL CheckIfAddingExpense = _viewingAddExpenseViewController == YES;
    
    
    
    
    int minimumSeconds = 1;
    
    if (TaskIsRepeatingHourly == YES) {
        minimumSeconds = 3600;
    } else if (TaskIsRepeatingDaily == YES) {
        minimumSeconds = 86400;
    } else if (TaskIsRepeatingWeekly == YES) {
        minimumSeconds = 604800;
    } else if (TaskIsRepeatingMonthly == YES) {
        minimumSeconds = 2419200;
    }
    
    
    
    
    NSTimeInterval secondsSinceCurrentDateStartingFromItemDueDate = [[[GeneralObject alloc] init] GenerateTimeIntervalBetweenTwoDates:dateStringCurrent dateString2:itemDueDate dateFormat:dateFormat];
    NSTimeInterval secondsBetweenStartAndEndDate = minimumSeconds + 1;
    
    
    
    
    BOOL StartDateSelected = (trimmedStringItemStartDate.length > 0 && [trimmedStringItemStartDate containsString:@"(null)"] == NO && [trimmedStringItemStartDate containsString:@"Now"] == NO && trimmedStringItemStartDate != nil);
    BOOL EndDateSelected = (trimmedStringItemEndDate.length > 0 && [trimmedStringItemEndDate containsString:@"(null)"] == NO && [trimmedStringItemEndDate containsString:@"Never"] == NO  && trimmedStringItemEndDate != nil);
   
    if ((StartDateSelected == YES && EndDateSelected == YES) && TaskIsRepeating == YES) {
        
        secondsBetweenStartAndEndDate = [[[GeneralObject alloc] init] GenerateTimeIntervalBetweenTwoDates:trimmedStringItemStartDate dateString2:trimmedStringItemEndDate dateFormat:@"MMMM dd, yyyy"];
   
    } else if ((StartDateSelected == NO && EndDateSelected == YES) && TaskIsRepeating == YES) {
        
        NSString *dateStringCurrent = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:@"MMMM dd, yyyy" returnAs:[NSString class]];
        
        secondsBetweenStartAndEndDate = [[[GeneralObject alloc] init] GenerateTimeIntervalBetweenTwoDates:dateStringCurrent dateString2:trimmedStringItemEndDate dateFormat:@"MMMM dd, yyyy"];
   
    }
    
    
    
    
    BOOL CheckIfNameIsEmpty = trimmedStringItemName.length == 0;
    BOOL CheckIfAmountIsEmpty = (CheckIfAddingExpense == YES && (trimmedStringItemAmount.length == 0 || [trimmedStringItemAmount isEqualToString:[NSString stringWithFormat:@"%@0%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol]] == YES));
    BOOL CheckIfItemAssignedToIsEmpty = CheckIfAddingExpense == YES && (trimmedStringItemAssignedTo.length == 0 || [trimmedStringItemAssignedTo isEqualToString:@"Nobody"] == YES);
    BOOL CheckIfCostPerPersonIsEmpty = (CheckIfAddingExpense == YES && (trimmedStringItemListItems.length == 0 || [itemCostPerPersonTextField.text isEqualToString:[NSString stringWithFormat:@"%@0%@00 Each", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol]] || [itemCostPerPersonTextField.text isEqualToString:[NSString stringWithFormat:@"%@0%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol]]) && [[itemItemizedItemsDict allKeys] count] > 0 == NO);
    BOOL CheckIfDaysIsEmpty = (TaskIsRepeatingWeekly == YES || TaskIsRepeatingMonthly == YES) && trimmedStringItemDays.length == 0;
    BOOL CheckIfListItemsIsEmpty = _viewingAddListViewController == YES && (trimmedStringItemListItems.length == 0 || [trimmedStringItemListItems isEqualToString:@"0"] == YES);
    
    BOOL MissingData = (CheckIfNameIsEmpty == YES ||
                        CheckIfAmountIsEmpty == YES ||
                        CheckIfItemAssignedToIsEmpty == YES ||
                        CheckIfCostPerPersonIsEmpty == YES ||
                        CheckIfDaysIsEmpty == YES ||
                        CheckIfListItemsIsEmpty == YES);
    
    
    
    
    //BOOL TaskNameAlreadyExists = [_itemNamesAlreadyUsed containsObject:trimmedStringItemName] && (_editingTask == NO || (_editingTask == YES && _duplicatingTask == YES));
    BOOL TaskHasNoDueDate = [[[BoolDataObject alloc] init] TaskHasNoDueDate:[@{@"ItemDueDate" : itemDueDateTextField.text, @"ItemSpecificDueDates" : itemSpecificDueDatesArray, @"ItemRepeats" : itemRepeatsTextFieldText, @"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal} mutableCopy] itemType:itemType];
    BOOL DueDateHasADate = TaskHasNoDueDate == NO && [itemDueDateTextField.text containsString:@"Date"] == NO;
    
    BOOL DueDateIsNotValid = (TaskIsRepeating == NO && secondsSinceCurrentDateStartingFromItemDueDate < 1 && (_editingTask == NO || _duplicatingTask == YES));
    BOOL DueDateIsNotValidBecauseItIsLessThan15Minutes = (TaskIsRepeating == NO && secondsSinceCurrentDateStartingFromItemDueDate < 1 && (_editingTask == NO || _duplicatingTask == YES));
    
    BOOL EndDateIsNumberOfTimes = [[[BoolDataObject alloc] init] TaskEndIsNumberOfTimes:[@{@"ItemEndDate" : itemEndDateTextField.text} mutableCopy] itemType:itemType];
    BOOL EndDateIsOneDayLaterThanStartDate = secondsBetweenStartAndEndDate >= minimumSeconds;
    
    
    
    
    if (MissingData == YES) {
        
        
        
        
        CGFloat height = CGRectGetHeight(self.view.bounds);
        CGFloat textFieldSpacing = (height*0.024456);
        
        BOOL scrolledToMissingData = false;
        NSString *missingString = @"";
        
        
        
        
        if (CheckIfNameIsEmpty == YES) {
            
            [[[GeneralObject alloc] init] TextFieldIsEmptyColorChange:itemNameView textFieldField:itemNameTextField textFieldShouldDisplay:MissingData defaultColor:defaultFieldColor];
            missingString = @"Missing Name";
            
        }
        
        if (CheckIfItemAssignedToIsEmpty == YES) {
            
            [[[GeneralObject alloc] init] TextFieldIsEmptyColorChange:itemAssignedToView textFieldField:itemAssignedToTextField textFieldShouldDisplay:MissingData defaultColor:defaultFieldColor];
            missingString = @"Missing Assigned To";
            
        }
        
        if (CheckIfAmountIsEmpty == YES) {
            
            [[[GeneralObject alloc] init] TextFieldIsEmptyColorChange:itemAmountView textFieldField:itemAmountTextField textFieldShouldDisplay:CheckIfAddingExpense defaultColor:defaultFieldColor];
            missingString = @"Missing Amount";
            
        }
        
        if (CheckIfCostPerPersonIsEmpty == YES) {
            
            [[[GeneralObject alloc] init] TextFieldIsEmptyColorChange:itemCostPerPersonView textFieldField:itemCostPerPersonTextField textFieldShouldDisplay:CheckIfAddingExpense defaultColor:defaultFieldColor];
            missingString = @"Missing Cost Per Person";
            
        }
        
        if (CheckIfDaysIsEmpty == YES) {
            
            [[[GeneralObject alloc] init] TextFieldIsEmptyColorChange:itemDaysView textFieldField:itemDaysTextField textFieldShouldDisplay:CheckIfDaysIsEmpty defaultColor:defaultFieldColor];
            missingString = @"Missing Days";
            
        }
        
        if (CheckIfListItemsIsEmpty == YES) {
            
            [[[GeneralObject alloc] init] TextFieldIsEmptyColorChange:itemListItemsView textFieldField:itemListItemsTextField textFieldShouldDisplay:YES defaultColor:defaultFieldColor];
            missingString = @"Missing List Items";
            
        }
        
        if (self->_customScrollView.contentOffset.y > (itemNameView.frame.origin.y + itemNameView.frame.size.height) && scrolledToMissingData == false) {
            
            [self->_customScrollView setContentOffset:CGPointMake(0, itemNameView.frame.origin.y - textFieldSpacing) animated:YES];
            scrolledToMissingData = true;
            
        }
        
        [progressView setHidden:YES];
        
        
        
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"EmptyFields - %@ - %@;", missingString, [[[GeneralObject alloc] init] GenerateItemType]]  completionHandler:^(BOOL finished) {
            
            NSString *touchEvent;
            
            if (TaskIsRepeating == YES && TaskIsRepeatingHourly == YES) {
                
                if ([[[[GeneralObject alloc] init] GenerateItemType] isEqualToString:@"Chore"]) {
                    
                    touchEvent = [NSString stringWithFormat:@"Repeating %@ Every Hour: Item Name: \"%@\" -- Item Assigned: \"%@\" --", [[[GeneralObject alloc] init] GenerateItemType], self->itemNameTextField.text, self->itemAssignedToTextField.text];
                    
                } else {
                    
                    touchEvent = [NSString stringWithFormat:@"Repeating %@ Every Hour: Item Name: \"%@\" -- Item Amount: \"%@\" -- Item Assigned: \"%@\" -- Item Cost Each: \"%@\" --", [[[GeneralObject alloc] init] GenerateItemType], self->itemNameTextField.text, self->itemAmountTextField.text, self->itemAssignedToTextField.text, self->itemCostPerPersonTextField.text];
                    
                }
                
            } else if (TaskIsRepeating == YES && TaskIsRepeatingDaily == YES) {
                
                if ([[[[GeneralObject alloc] init] GenerateItemType] isEqualToString:@"Chore"]) {
                    
                    touchEvent = [NSString stringWithFormat:@"Repeating %@ Every Day: Item Name: \"%@\" -- Item Assigned: \"%@\" --", [[[GeneralObject alloc] init] GenerateItemType], self->itemNameTextField.text, self->itemAssignedToTextField.text];
                    
                } else {
                    
                    touchEvent = [NSString stringWithFormat:@"Repeating %@ Every Day: Item Name: \"%@\" -- Item Amount: \"%@\" -- Item Assigned: \"%@\" -- Item Cost Each: \"%@\" --", [[[GeneralObject alloc] init] GenerateItemType], self->itemNameTextField.text, self->itemAmountTextField.text, self->itemAssignedToTextField.text, self->itemCostPerPersonTextField.text];
                    
                }
                
            } else if (TaskIsRepeating == YES && TaskIsRepeatingDaily == NO) {
                
                if ([[[[GeneralObject alloc] init] GenerateItemType] isEqualToString:@"Chore"]) {
                    
                    touchEvent = [NSString stringWithFormat:@"Repeating %@ Every Week/Month: Item Name: \"%@\" -- Item Assigned: \"%@\" --", [[[GeneralObject alloc] init] GenerateItemType],  self->itemNameTextField.text, self->itemAssignedToTextField.text];
                    
                } else {
                    
                    touchEvent = [NSString stringWithFormat:@"Repeating %@ Every Week/Month: Item Name: \"%@\" -- Item Amount: \"%@\" -- Item Assigned: \"%@\" -- Item Cost Each: \"%@\" --", [[[GeneralObject alloc] init] GenerateItemType],  self->itemNameTextField.text, self->itemAmountTextField.text, self->itemAssignedToTextField.text, self->itemCostPerPersonTextField.text];
                    
                }
                
            } else if (TaskIsRepeating == NO) {
                
                if ([[[[GeneralObject alloc] init] GenerateItemType] isEqualToString:@"Chore"]) {
                    
                    touchEvent = [NSString stringWithFormat:@"Not Repeating %@: Item Name: \"%@\" -- Item Due Date: \"%@\" -- Item Assigned: \"%@\" --", [[[GeneralObject alloc] init] GenerateItemType], self->itemNameTextField.text, self->itemDueDateTextField.text, self->itemAssignedToTextField.text];
                    
                } else {
                    
                    touchEvent = [NSString stringWithFormat:@"Not Repeating %@: Item Name: \"%@\" -- Item Amount: \"%@\" -- Item Due Date: \"%@\" -- Item Assigned: \"%@\" -- Item Cost Each: \"%@\" --", [[[GeneralObject alloc] init] GenerateItemType], self->itemNameTextField.text, self->itemAmountTextField.text, self->itemDueDateTextField.text, self->itemAssignedToTextField.text, self->itemCostPerPersonTextField.text];
                    
                }
                
            }
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:touchEvent completionHandler:^(BOOL finished) {
                
            }];
            
            
            
            
        }];
        
        
        
        
        return true;
        
        
        
        
    }
    
    
    
    
    BOOL DueDateHasADateAndItIsNotValidOrNotFarEnouch = ((DueDateIsNotValid == YES || DueDateIsNotValidBecauseItIsLessThan15Minutes == YES) && DueDateHasADate == YES);
    BOOL TaskIsRepeatingAndEndDateIsNotFarEnough = (TaskIsRepeating == YES && EndDateIsNumberOfTimes == NO && EndDateIsOneDayLaterThanStartDate == NO);
    BOOL TaskIsAssignedToNobodyAndTakingTurns = (itemAssignedToTextField.text.length == 0 || [itemAssignedToTextField.text isEqualToString:@"Nobody"]) && [itemEveryoneTakesTurnsSwitch isOn];
    
    if (DueDateHasADateAndItIsNotValidOrNotFarEnouch == YES || TaskIsRepeatingAndEndDateIsNotFarEnough == YES || TaskIsAssignedToNobodyAndTakingTurns == YES) {
        
        
        
        
        NSString *alertMessage = DueDateIsNotValidBecauseItIsLessThan15Minutes == YES ? @"You must enter a due date and time that is later than the current date and time" : @"You must enter a future due date not a past one";
        
        if (EndDateIsOneDayLaterThanStartDate == NO) {
            
            NSString *str = @"24 hours";
            
            if (TaskIsRepeatingWeekly) {
                str = @"7 days";
            }
            if (TaskIsRepeatingMonthly) {
                str = @"28 days later";
            }
            
            alertMessage = [NSString stringWithFormat:@"If your %@ is repeating %@, the \"End\" date must be at least %@ later than the \"Start\" date", [itemType lowercaseString], [itemRepeatsTextFieldText lowercaseString], str];
            
        }
        
        //        if (TaskNameAlreadyExists == YES) {
        //
        //            alertMessage = [NSString stringWithFormat:@"A %@ with the name \"%@\" already exists", [itemType lowercaseString], itemNameTextField.text];
        //
        //        }
        
        if (TaskIsAssignedToNobodyAndTakingTurns == YES) {
            
            alertMessage = @"A task that is taking turns must be assigned to at least one person";
            
        }
        
        [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:alertMessage currentViewController:self];
        
        [progressView setHidden:YES];
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"EmptyFieldsDate - %@;", [[[GeneralObject alloc] init] GenerateItemType]]  completionHandler:^(BOOL finished) {
            
        }];
        
        
        
        
        return true;
        
        
        
        
    }
    
    
    
    
    return false;
    
    
    
    
}

-(void)FormatDateTextField:(id)sender {
    
    UIDatePicker *picker;
    
    if ([itemDueDateTextField isFirstResponder]) {
        
        picker = (UIDatePicker*)itemDueDateTextField.inputView;
        
    } else if ([itemStartDateTextField isFirstResponder]) {
        
        picker = (UIDatePicker*)itemStartDateTextField.inputView;
        
    } else if ([itemEndDateTextField isFirstResponder]) {
        
        picker = (UIDatePicker*)itemEndDateTextField.inputView;
        
    }
    
    
    
    
    NSDateFormatter *dateFormatter = [[[GeneralObject alloc] init] GenerateDateFormatWithString:@"MMMM dd, yyyy"];
    NSString *dueDateString = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:picker.date]];
    NSArray *dueDateArray = [dueDateString componentsSeparatedByString:@" "];
    
    NSString *month = dueDateArray.count > 0 ? dueDateArray[0] : @"";
    NSString *day = dueDateArray.count > 1 ? dueDateArray[1] : @"";
    NSString *year = dueDateArray.count > 2 ? dueDateArray[2] : @"";
    
    dueDateString = [NSString stringWithFormat:@"%@ %@ %@", month, day, year];
    
    
    
    
    if ([itemDueDateTextField isFirstResponder]) {
        
        itemDueDateTextField.text = dueDateString;
        
    } else if ([itemStartDateTextField isFirstResponder]) {
        
        itemStartDateTextField.text = dueDateString;
        
    } else if ([itemEndDateTextField isFirstResponder]) {
        
        itemEndDateTextField.text = dueDateString;
        
    }
    
}

-(void)IncreaseCountForAppStoreRatingPopup {
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"AddedItem"] || [[[NSUserDefaults standardUserDefaults] objectForKey:@"AddedItem"] isEqualToString:@"0"]) {
        
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"AddedItem"];
        
    } else {
        
        int addedItemCount = [[NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"AddedItem"]] intValue] + 1;
        NSString *addedItemCountStr = [NSString stringWithFormat:@"%d", addedItemCount];
        [[NSUserDefaults standardUserDefaults] setObject:addedItemCountStr forKey:@"AddedItem"];
        
    }
    
}

-(void)ClearMultipleDueDatesArray:(NSString *)itemDueDate completionHandler:(void (^)(BOOL finished, BOOL SureSelected, BOOL PopupDisplayed))finishBlock {
    
    if ([itemSpecificDueDatesArray count] > 0) {
        
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Multiple Dates Chosen"
                                                                            message:@"Would you like to delete all of your selected dates?"
                                                                     preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction *gotit = [UIAlertAction actionWithTitle:@"Sure"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * _Nonnull action) {
            
            self->itemSpecificDueDatesArray = [NSMutableArray array];
            self->itemDueDateTextField.text = itemDueDate;
            [self SetUpDueDateContextMenu:NO];
            
            finishBlock(YES, YES, YES);
            
            
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Nevermind"
                                                         style:UIAlertActionStyleCancel
                                                       handler:^(UIAlertAction * _Nonnull action) {
            
            finishBlock(YES, NO, YES);
            
        }];
        
        [controller addAction:cancel];
        [controller addAction:gotit];
        [self presentViewController:controller animated:YES completion:nil];
        
    } else {
        
        finishBlock(YES, NO, NO);
        
    }
    
}

#pragma mark

-(void)InitialUserData {
    
    self->userDictForHomeMembers = [_homeMembersDict mutableCopy];
    
    if (_partiallyAddedTask) { [self EditingUserData:self->_partiallyAddedDict]; }
    if (_addingSuggestedTask) { [self EditingUserData:self->_suggestedItemToAddDict]; }
    if (_editingTask || _addingMultipleTasks || _viewingTask) { [self EditingUserData:self->_itemToEditDict]; }
    if (_editingTemplate) { [self EditingUserData:self->_templateToEditDict[@"Template"][@"TemplateData"]]; }
    if (_editingDraft) { [self EditingUserData:self->_draftToEditDict[@"Draft"][@"DraftData"]]; }
    if (_viewingMoreOptions) { [self MoreOptionsData:_moreOptionsDict]; }
    if (_editingTemplate && _viewingMoreOptions) { [self MoreOptionsData:self->_templateToEditDict[@"Template"][@"TemplateData"]]; }
    if (_editingDraft && _viewingMoreOptions) { [self MoreOptionsData:self->_draftToEditDict[@"Draft"][@"DraftData"]]; }
 
}

-(void)EditingUserData:(NSMutableDictionary *)dictToUse {
   
    [self EditingUserData_Name:dictToUse];
    
    [self EditingUserData_AssignedTo:dictToUse];
    [self EditingUserData_MustComplete:dictToUse];
    
    [self EditingUserData_Amount:dictToUse];
    [self EditingUserData_ItemizedItems:dictToUse];
    [self EditingUserData_CostPerPerson:dictToUse];
    [self EditingUserData_PaymentMethods:dictToUse];
    
    [self EditingUserData_ListItems:dictToUse];
    
    [self EditingUserData_Repeats:dictToUse];
    [self EditingUserData_DueDate:dictToUse];
    [self EditingUserData_RepeatIfCompletedEarly:dictToUse];
    
    [self EditingUserData_Start:dictToUse];
    [self EditingUserData_End:dictToUse];
    
    [self EditingUserData_Days:dictToUse];
    [self EditingUserData_Time:dictToUse];
    [self EditingUserData_TakeTurns:dictToUse];
    [self EditingUserData_AlternateTurns:dictToUse];
    [self EditingUserData_TurnOrder:dictToUse];
    
    [self EditingUserData_Reminders:dictToUse];
    
    [self EditingUserData_Image:dictToUse];
    [self EditingUserData_Notes:dictToUse];
    
    [self EditingUserData_Subtasks:dictToUse];
    [self EditingUserData_GracePeriod:dictToUse];
    [self EditingUserData_PastDue:dictToUse];
    
    [self EditingUserData_Color:dictToUse];
    [self EditingUserData_Tags:dictToUse];
    [self EditingUserData_Priority:dictToUse];
    [self EditingUserData_Difficulty:dictToUse];
    
    [self EditingUserData_Reward:dictToUse];
    [self EditingUserData_Private:dictToUse];
    [self EditingUserData_ApprovalNeeded:dictToUse];
    
    self->chosenItemOccurrenceID = dictToUse[@"ItemOccurrenceID"] ? dictToUse[@"ItemOccurrenceID"] : @"";
    
    self->itemCompletedDict = dictToUse[@"ItemCompletedDict"] ? [dictToUse[@"ItemCompletedDict"] mutableCopy] : [NSMutableDictionary dictionary];
    self->itemInProgressDict = dictToUse[@"ItemInProgressDict"] ? [dictToUse[@"ItemInProgressDict"] mutableCopy] : [NSMutableDictionary dictionary];
    self->itemWontDoDict = dictToUse[@"ItemWontDo"] ? [dictToUse[@"ItemWontDo"] mutableCopy] : [NSMutableDictionary dictionary];
    
    self->selectedScheduledStart = dictToUse[@"ItemScheduledStart"] ? [dictToUse[@"ItemScheduledStart"] mutableCopy] : @"Now";
    
    [self BarButtonItems];
    
    [self AdjustTextFieldFramesToUse:0];
    
    [self SetUpMainViewContextMenus];
    
}

-(void)MoreOptionsData:(NSMutableDictionary *)dictToUse {
    
    assignedToIDArray = [dictToUse[@"ItemAssignedTo"] mutableCopy];
    
    [self UpdateTopViewLabel:dictToUse[@"TaskList"]];
    
    [self MoreOptionsData_Subtasks:dictToUse];
    [self MoreOptionsData_GracePeriod:dictToUse];
    [self MoreOptionsData_PastDue:dictToUse];
    
    [self MoreOptionsData_Color:dictToUse];
    [self MoreOptionsData_Tags:dictToUse];
    [self MoreOptionsData_Priority:dictToUse];
    [self MoreOptionsData_Difficulty:dictToUse];
    
    [self MoreOptionsData_Reward:dictToUse];
    [self MoreOptionsData_Private:dictToUse];
    [self MoreOptionsData_ApprovalNeeded:dictToUse];
    
    [self SetUpMainViewContextMenus];
    
}

#pragma mark

-(NSMutableArray *)BackItemContextMenuActions {
    
    NSMutableArray *backButtonActions = [NSMutableArray array];
    
    
    
    
    UIAction *saveDraft = [self BackItemContextMenuSaveDraftAction];
    if (_viewingMoreOptions == NO && _viewingTask == NO && _addingSuggestedTask == NO && _editingTemplate == NO && _viewingTemplate == NO && _editingDraft == NO && _viewingDraft == NO) {
        [backButtonActions addObject:saveDraft];
    }
    
    
    
    
    NSMutableArray *discardMenuActions = [NSMutableArray array];
    UIAction *discard = [self BackItemContextMenuDiscardAction];
    [discardMenuActions addObject:discard];
    
    UIMenu *discardMenu = [self BackItemContextMenuDiscardActionsMenu:discardMenuActions];
    [backButtonActions addObject:discardMenu];
    
    
    
    
    return backButtonActions;
}

-(NSMutableArray *)DraftItemContextMenuActions {
    
    NSMutableArray *draftActions = [NSMutableArray array];
    
    
    
    
    for (NSString *draftName in _draftDict[@"DraftName"]) {
        
        NSMutableArray *draftMenuActions = [NSMutableArray array];
        
        UIAction *selectDraft = [self DraftItemContextMenuSelectUnselectAction:draftName];
        [draftMenuActions addObject:selectDraft];
        
        UIAction *editName = [self DraftItemContextMenuEditDraftNameAction:draftName];
        [draftMenuActions addObject:editName];
        
        UIAction *editDraft = [self DraftItemContextMenuEditDraftAction:draftName];
        [draftMenuActions addObject:editDraft];
        
        
        
        
        NSMutableArray *deleteDraftMenuActions = [NSMutableArray array];
        
        UIAction *deleteDraft = [self DraftItemContextMenuDeleteDraftAction:draftName];
        [deleteDraftMenuActions addObject:deleteDraft];
        
        UIMenu *deleteDraftMenu = [self DraftItemContextMenuDeleteDraftActionsMenu:deleteDraftMenuActions];
        [draftMenuActions addObject:deleteDraftMenu];
        
        
        
        
        UIMenu *draftActionsMenu = [self DraftItemContextMenuDraftActionsMenu:draftName draftNameArray:_draftDict[@"DraftName"] draftMenuActions:draftMenuActions];
        [draftActions addObject:draftActionsMenu];
        
    }
    
    
    
    
    NSMutableArray *newDraftActions = [NSMutableArray array];
    UIAction *newDraft = [self DraftItemContextMenuNewDraftAction];
    [newDraftActions addObject:newDraft];
    
    UIMenu *newDraftMenu = [self DraftItemContextMenuNewDraftActionsMenu:newDraftActions];
    [draftActions addObject:newDraftMenu];
    
    
    
    
    NSMutableArray *noDraftActions = [NSMutableArray array];
    UIAction *noDraft = [self DraftItemContextMenuNoDraftAction];
    [noDraftActions addObject:noDraft];
    
    UIMenu *noDraftMenu = [self DraftItemContextMenuNoDraftActionsMenu:noDraftActions];
    [draftActions addObject:noDraftMenu];
    
    
    
    
    return draftActions;
}

-(NSMutableArray *)TemplateItemContextMenuActions {
    
    NSMutableArray *templateActions = [NSMutableArray array];
    
    
    
    
    for (NSString *templateName in _templateDict[@"TemplateName"]) {
        
        NSMutableArray *templateMenuActions = [NSMutableArray array];
        
        UIAction *selectTemplate = [self TemplateItemContextMenuSelectUnselectAction:templateName];
        [templateMenuActions addObject:selectTemplate];
        
        UIAction *editName = [self TemplateItemContextMenuEditTemplateNameAction:templateName];
        [templateMenuActions addObject:editName];
        
        UIAction *editTemplate = [self TemplateItemContextMenuEditTemplateAction:templateName];
        [templateMenuActions addObject:editTemplate];
        
        UIAction *defaultTemplate = [self TemplateItemContextMenuDefaultAction:templateName templateNameArray:_templateDict[@"TemplateName"] templateDefaultArray:_templateDict[@"TemplateDefault"]];
        [templateMenuActions addObject:defaultTemplate];
        
        
        
        
        NSMutableArray *deleteTemplateMenuActions = [NSMutableArray array];
        UIAction *deleteTemplate = [self TemplateItemContextMenuDeleteTemplateAction:templateName];
        [deleteTemplateMenuActions addObject:deleteTemplate];
        
        UIMenu *deleteTemplateMenu = [self TemplateItemContextMenuDeleteTemplateActionsMenu:deleteTemplateMenuActions];
        [templateMenuActions addObject:deleteTemplateMenu];
        
        
        
        
        UIMenu *templateActionsMenu = [self TemplateItemContextMenuTemplateActionsMenu:templateName templateNameArray:_templateDict[@"TemplateName"] templateDefaultArray:_templateDict[@"TemplateDefault"] templateMenuActions:templateMenuActions];
        [templateActions addObject:templateActionsMenu];
        
    }
    
    
    
    
    NSMutableArray *newTemplateActions = [NSMutableArray array];
    UIAction *newTemplate = [self TemplateItemContextMenuNewTemplateAction];
    [newTemplateActions addObject:newTemplate];
    
    UIMenu *newTemplateMenu = [self TemplateItemContextMenuNewTemplateActionsMenu:newTemplateActions];
    [templateActions addObject:newTemplateMenu];
    
    
    
    
    NSMutableArray *noTemplateActions = [NSMutableArray array];
    UIAction *noTemplate = [self TemplateItemContextMenuNoTemplateAction];
    [noTemplateActions addObject:noTemplate];
    
    UIMenu *noTemplateMenu = [self TemplateItemContextMenuNoTemplateActionsMenu:noTemplateActions];
    [templateActions addObject:noTemplateMenu];
    
    
    
    
    return templateActions;
}

-(NSMutableArray *)ScheduledStartItemContextMenuActions {
    
    NSMutableArray* scheduledStartActions = [[NSMutableArray alloc] init];
    
    
    
    
    NSArray *scheduledStartArray = @[@"30 Minutes", @"2 Hours", @"12 Hours", @"1 Day", @"1 Week"];
    
    if (selectedScheduledStart == nil || selectedScheduledStart == NULL || [selectedScheduledStart length] == 0) {
        selectedScheduledStart = @"Now";
    }
    
    
    
    
    UIAction *scheduledStartAction = [self ScheuledStartItemContextMenuAction:@"Now"];
    [scheduledStartActions addObject:scheduledStartAction];
    
    
    
    
    NSMutableArray* scheduledStartOptionsActions = [[NSMutableArray alloc] init];
    
    for (NSString *scheduledStartName in scheduledStartArray) {
        
        UIAction *scheduledStartAction = [self ScheuledStartItemContextMenuAction:scheduledStartName];
        [scheduledStartOptionsActions addObject:scheduledStartAction];
        
    }
    
    UIMenu *optionsScheduledStartMenu = [self ScheduledStartItemContextMenuOptionsActionsMenu:scheduledStartOptionsActions];
    [scheduledStartActions addObject:optionsScheduledStartMenu];
    
    
    
    
    NSMutableArray* customScheduledStartMenuActions = [[NSMutableArray alloc] init];
    UIAction *customScheduledStartAction = [self ScheuledStartItemContextMenuCustomAction:scheduledStartArray];
    [customScheduledStartMenuActions addObject:customScheduledStartAction];
    
    UIMenu *customScheduledStartMenu = [self ScheduledStartItemContextMenuCustomActionsMenu:customScheduledStartMenuActions];
    [scheduledStartActions addObject:customScheduledStartMenu];
    
    
    
    
    return scheduledStartActions;
}

#pragma mark

-(void)GenerateCompletedByFrequencyArray:(NSMutableArray *)assignedToIDArray {
    
    frequencyCompletedByAmountArray = [NSMutableArray array];
    [frequencyCompletedByAmountArray addObject:@""];
    
    BOOL TaskIsAssignedToNobody = [[[BoolDataObject alloc] init] TaskIsAssignedToNobody:[@{@"ItemAssignedTo" : assignedToIDArray} mutableCopy] itemType:itemType];
    BOOL TaskAssignToNewHomeMembers = [chosenItemAssignedToNewHomeMembers isEqualToString:@"Yes"];
    
    if (TaskIsAssignedToNobody == NO && TaskAssignToNewHomeMembers == NO) {
        
        for (NSString *userID in assignedToIDArray) {
            
            if ([assignedToIDArray containsObject:userID]) {
                
                NSUInteger index = [assignedToIDArray indexOfObject:userID];
                [frequencyCompletedByAmountArray addObject:[NSString stringWithFormat:@"%lu", index+1]];
                
            }
            
        }
        
    } else if (TaskAssignToNewHomeMembers == YES) {
        
        for (int i=1; i<11; i++) {
            
            [frequencyCompletedByAmountArray addObject:[NSString stringWithFormat:@"%d", i]];
            
        }
        
    } else {
        
        if (self->_homeMembersDict && self->_homeMembersDict[@"UserID"]) {
            
            for (NSString *userID in self->_homeMembersDict[@"UserID"]) {
                
                if ([self->_homeMembersDict[@"UserID"] containsObject:userID]) {
                    
                    NSUInteger index = [self->_homeMembersDict[@"UserID"] indexOfObject:userID];
                    [frequencyCompletedByAmountArray addObject:[NSString stringWithFormat:@"%lu", index+1]];
                    
                }
                
            }
            
        }
        
    }
    
}

-(void)GenerateGracePeriodFrequencyArray:(NSString *)itemRepeats {
    
    NSString *chosenItemRepeatIfCompletedEarlyLocal = chosenItemRepeatIfCompletedEarly ? chosenItemRepeatIfCompletedEarly : @"";
    
    frequencyGracePeriodAmountArray = [[NSMutableArray alloc] init];
    frequencyGracePeriodFrequencyArray = [[NSMutableArray alloc] init];
    
    NSString *sStr = @"s";
    
    if (gracePeriodAmountComp != NULL && [gracePeriodAmountComp isEqualToString:@"1"]) {
        sStr = @"";
    }
    
    if ([itemRepeats isEqualToString:@"Never"] == NO && [itemRepeats isEqualToString:@"One-Time"] == NO && [itemRepeats isEqualToString:@"As Needed"] == NO && [itemRepeats isEqualToString:@"When Completed"] == NO && itemRepeats.length > 0) {
        
        frequencyGracePeriodAmountArray = [[NSMutableArray alloc] init];
        
        for (int i=1;i<61;i++) {
            [frequencyGracePeriodAmountArray addObject:[NSString stringWithFormat:@"%d", i]];
        }
        
        BOOL TaskIsRepeatingHourly = [[[BoolDataObject alloc] init] TaskIsRepeatingHourly:[@{@"ItemRepeats" : itemRepeats, @"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal} mutableCopy] itemType:itemType];
        BOOL TaskIsRepeatingDaily = [[[BoolDataObject alloc] init] TaskIsRepeatingDaily:[@{@"ItemRepeats" : itemRepeats} mutableCopy] itemType:itemType];
        BOOL TaskIsRepeatingWeekly = [[[BoolDataObject alloc] init] TaskIsRepeatingWeekly:[@{@"ItemRepeats" : itemRepeats} mutableCopy] itemType:itemType];
        BOOL TaskIsRepeatingMonthly = [[[BoolDataObject alloc] init] TaskIsRepeatingMonthly:[@{@"ItemRepeats" : itemRepeats} mutableCopy] itemType:itemType];
        
        if (TaskIsRepeatingHourly) {
            
            frequencyGracePeriodFrequencyArray = [[NSMutableArray alloc] init];
            [frequencyGracePeriodFrequencyArray addObject:[NSString stringWithFormat:@"Minute%@", sStr]];
            
        } else if (TaskIsRepeatingDaily) {
            
            frequencyGracePeriodFrequencyArray = [[NSMutableArray alloc] init];
            [frequencyGracePeriodFrequencyArray addObject:[NSString stringWithFormat:@"Minute%@", sStr]];
            [frequencyGracePeriodFrequencyArray addObject:[NSString stringWithFormat:@"Hour%@", sStr]];
            
        } else if (TaskIsRepeatingWeekly) {
            
            frequencyGracePeriodFrequencyArray = [[NSMutableArray alloc] init];
            [frequencyGracePeriodFrequencyArray addObject:[NSString stringWithFormat:@"Minute%@", sStr]];
            [frequencyGracePeriodFrequencyArray addObject:[NSString stringWithFormat:@"Hour%@", sStr]];
            [frequencyGracePeriodFrequencyArray addObject:[NSString stringWithFormat:@"Day%@", sStr]];
            
        } else if (TaskIsRepeatingMonthly) {
            
            frequencyGracePeriodFrequencyArray = [[NSMutableArray alloc] init];
            [frequencyGracePeriodFrequencyArray addObject:[NSString stringWithFormat:@"Minute%@", sStr]];
            [frequencyGracePeriodFrequencyArray addObject:[NSString stringWithFormat:@"Hour%@", sStr]];
            [frequencyGracePeriodFrequencyArray addObject:[NSString stringWithFormat:@"Day%@", sStr]];
            [frequencyGracePeriodFrequencyArray addObject:[NSString stringWithFormat:@"Week%@", sStr]];
            
        }
        
    } else if ([itemRepeats isEqualToString:@"Never"] == YES || [itemRepeats isEqualToString:@"When Completed"] == YES || itemRepeats.length == 0) {
        
        frequencyGracePeriodAmountArray = [[NSMutableArray alloc] init];
        for (int i=1;i<61;i++) {
            [frequencyGracePeriodAmountArray addObject:[NSString stringWithFormat:@"%d", i]];
        }
        
        frequencyGracePeriodFrequencyArray = [[NSMutableArray alloc] init];
        [frequencyGracePeriodFrequencyArray addObject:[NSString stringWithFormat:@"Minute%@", sStr]];
        [frequencyGracePeriodFrequencyArray addObject:[NSString stringWithFormat:@"Hour%@", sStr]];
        [frequencyGracePeriodFrequencyArray addObject:[NSString stringWithFormat:@"Day%@", sStr]];
        [frequencyGracePeriodFrequencyArray addObject:[NSString stringWithFormat:@"Week%@", sStr]];
        
    }
    
    [(UIPickerView *)itemGracePeriodTextField.inputView reloadAllComponents];
    
}

#pragma mark

-(void)GenerateSpecificOrderTextFieldText:(NSMutableArray *)usernameArray {
    
    if ((usernameArray == NULL || usernameArray.count == 0) && [itemAssignedToTextField.text isEqualToString:@"Nobody"] == NO) {
        usernameArray = [@[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"]] mutableCopy];
    }
    
    itemTurnOrderTextField.userInteractionEnabled = _viewingTask == NO ? YES : NO;
    itemTurnOrderView.userInteractionEnabled = _viewingTask == NO ? YES : NO;
    
    [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemSpecificOrder" userInfo:@{@"SpecificOrder" : usernameArray} locations:@[@"AddTask"]];
    
}

-(void)GenerateCostPerPersonTextFieldText:(NSMutableDictionary *)itemCostPerPersonDictLocal {
    
    if ([[itemItemizedItemsDict allKeys] count] > 0) {
        
        if ([[itemItemizedItemsDict allKeys] count] == 0) {
            
            itemCostPerPersonTextField.text = [NSString stringWithFormat:@"%@0%@00 Each", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol];
            
        } else {
            
            BOOL AssignedToFound = false;
            
            for (NSString *key in [itemItemizedItemsDict allKeys]) {
                
                if (itemItemizedItemsDict[key]) {
                    
                    BOOL IsKindOfNSStringClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:itemItemizedItemsDict[key] classArr:@[[NSDictionary class]]];
                    
                    if (IsKindOfNSStringClass == YES) {
                        
                        if (itemItemizedItemsDict[key][@"Assigned To"]) {
                            
                            if ([(NSArray *)itemItemizedItemsDict[key][@"Assigned To"] count] > 0) {
                                
                                if ([itemItemizedItemsDict[key][@"Assigned To"][0] isEqualToString:@"Anybody"] == NO) {
                                    
                                    AssignedToFound = true;
                                    break;
                                    
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            
            if (AssignedToFound || self->_itemToEditDict) {
                
                itemCostPerPersonTextField.text = @"Custom";
                
                itemCostPerPersonView.backgroundColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTertiary] : [[[LightDarkModeObject alloc] init] LightModeSecondary];
                
            } else {
                
                itemCostPerPersonTextField.text = [NSString stringWithFormat:@"%@0%@00 Each", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol];
                
            }
            
        }
        
        return;
    }
    
    itemCostPerPersonDict = [itemCostPerPersonDictLocal mutableCopy];
    
    NSString *costPerPersonFieldText = @"";
    
    BOOL different = false;
    
    if ([[itemCostPerPersonDict allKeys] count] > 0) {
        
        NSString *firstCostPerPersonString = itemCostPerPersonDict[[itemCostPerPersonDict allKeys][0]];
        
        for (NSString *userID in itemCostPerPersonDict) {
            
            NSString *nextCostPerPersonString = itemCostPerPersonDict[userID];
            
            BOOL firstAndNextCostPerPersonStringsAreTheSame = [nextCostPerPersonString isEqualToString:firstCostPerPersonString];
            
            if (firstAndNextCostPerPersonStringsAreTheSame == NO) {
                
                costPerPersonFieldText = @"Custom";
                different = true;
                
            }
            
        }
        
    }
    
    if (different == NO) {
        
        NSMutableArray *userIDArray = [self GenerateItemAssignedTo:@"No"];
        
        if (userIDArray.count > 0) {
            
            BOOL TaskHasAmount = itemAmountTextField.text.length > 0;
            
            if (TaskHasAmount == YES) {
                
                NSString *itemAmountTextFieldText = itemAmountTextField.text;
                itemAmountTextFieldText = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:itemAmountTextFieldText arrayOfSymbols:@[localCurrencyNumberSeparatorSymbol, localCurrencySymbol]];
                
                double equalAmountPerPerson = [itemAmountTextFieldText doubleValue]/userIDArray.count;
                
                NSString *equalAmountPerPersonString = [NSString stringWithFormat:@"%.2f", equalAmountPerPerson];
                
                equalAmountPerPersonString = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:equalAmountPerPersonString arrayOfSymbols:@[localCurrencyNumberSeparatorSymbol, localCurrencyDecimalSeparatorSymbol, localCurrencySymbol]];
                equalAmountPerPersonString = [[[GeneralObject alloc] init] GenerateAmountInTextFieldInProperFormat:NSRangeFromString(equalAmountPerPersonString) replacementString:equalAmountPerPersonString];
                
                costPerPersonFieldText = [NSString stringWithFormat:@"%@", equalAmountPerPersonString];
                
                for (NSString *userID in userIDArray) {
                    
                    [itemCostPerPersonDict setObject:equalAmountPerPersonString forKey:userID];
                    
                }
                
            } else {
                
                costPerPersonFieldText = [NSString stringWithFormat:@"%@0%@00 Each", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol];
                
                for (NSString *userID in userIDArray) {
                    
                    [itemCostPerPersonDict setObject:[NSString stringWithFormat:@"%@0%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol] forKey:userID];
                    
                }
                
            }
            
            if ([costPerPersonFieldText isEqualToString:@"inf Each"] && [itemAssignedToTextField.text isEqualToString:@"Nobody"] == NO) {
                
                costPerPersonFieldText = [NSString stringWithFormat:@"%@0%@00 Each", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol];
                
                for (NSString *userID in userIDArray) {
                    
                    [itemCostPerPersonDict setObject:[NSString stringWithFormat:@"%@0%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol] forKey:userID];
                    
                }
                
            }
            
        } else {
            
            costPerPersonFieldText = @"";
        }
        
    }
    
    itemCostPerPersonTextField.text = [NSString stringWithFormat:@"%@ Each", costPerPersonFieldText];
    
    if ([itemCostPerPersonTextField.text isEqualToString:[NSString stringWithFormat:@"%@0%@00 Each", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol]] == NO) {
        
        itemCostPerPersonView.backgroundColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTertiary] : [[[LightDarkModeObject alloc] init] LightModeSecondary];
        
    }
    
}

-(void)GenerateCompletedByTextFieldText {
    
    NSMutableArray *userIDArray = [self GenerateItemAssignedTo:@"No"];
    
    BOOL TaskIsAssignedToAtLeastOnePerson = userIDArray.count > 0;
    BOOL TaskIsAssigedToNobody =
    userIDArray.count == 0 &&
    ([itemAssignedToTextField.text isEqualToString:@"Nobody"] == YES || [itemAssignedToTextField.text isEqualToString:@""] == YES);
    
    if (TaskIsAssignedToAtLeastOnePerson == YES || TaskIsAssigedToNobody == YES) {
        
        itemMustCompleteLabel.textColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTextPrimary] : [[[LightDarkModeObject alloc] init] LightModeTextPrimary];
        itemMustCompleteTextField.userInteractionEnabled = _viewingTask == NO ? YES : NO;
        itemMustCompleteView.userInteractionEnabled = _viewingTask == NO ? YES : NO;
        
        
    }
    
    NSString *itemMustCompleteTextFieldText = itemMustCompleteTextField.text ? itemMustCompleteTextField.text : @"";
    
    BOOL TaskMustBeCompletedByEveryoneAssigned = [[[BoolDataObject alloc] init] TaskMustBeCompletedByEveryoneAssigned:[@{@"ItemMustComplete" : itemMustCompleteTextFieldText} mutableCopy] itemType:itemType];
    
    if (TaskMustBeCompletedByEveryoneAssigned == NO) {
        
        int CompletedByTextFieldMinimumAmountNumber = [itemMustCompleteTextField.text containsString:@" "] && [[itemMustCompleteTextField.text componentsSeparatedByString:@" "] count] > 1 ? [[itemMustCompleteTextField.text componentsSeparatedByString:@" "][1] intValue] : 0;
        int MaximumFrequencyArrayCompletedByNumber = frequencyCompletedByAmountArray && [frequencyCompletedByAmountArray count] > (frequencyCompletedByAmountArray.count-1) ? [[NSString stringWithFormat:@"%@", frequencyCompletedByAmountArray[frequencyCompletedByAmountArray.count-1]] intValue] : 0;
        
        BOOL CompletedByTextFieldDisplayingNumberHigherThanAmountOfUsers = CompletedByTextFieldMinimumAmountNumber > MaximumFrequencyArrayCompletedByNumber;
        
        if (CompletedByTextFieldDisplayingNumberHigherThanAmountOfUsers == YES) {
            
            completedByOnlyComp = @"Only";
            completedByAmountComp = [NSString stringWithFormat:@"%d", MaximumFrequencyArrayCompletedByNumber];
            NSString *personOrPeople = ([completedByAmountComp isEqualToString:@"1"] == NO && completedByAmountComp != NULL && [completedByAmountComp length] > 0) ? @"People" : @"Person";
            
            itemMustCompleteTextField.text = [NSString stringWithFormat:@"Only %@ %@", completedByAmountComp, personOrPeople];
            
        }
        
    }
    
}

#pragma mark

-(NSDictionary *)GenerateSetDataDict {
    
    //Item Type Is Chore, Expense, List
    
    NSString *itemTypeLocal = itemType;
    
    if (_viewingAddExpenseViewController == YES) {
        itemTypeLocal = @"Expense";
    } else if (_viewingAddListViewController == YES) {
        itemTypeLocal = @"List";
    } else {
        itemTypeLocal = @"Chore";
    }
    
    NSString *itemUniqueID = self->chosenItemUniqueID;
    NSString *itemID = self->chosenItemID;
    NSString *itemOccurrenceID = self->chosenItemOccurrenceID;
    NSString *itemHomeID = self->_homeID;
    NSString *itemSuggestedID = [self GenerateItemSuggestedID];
    
    NSString *itemTutorial = @"No";
    
    NSString *itemCreatedBy = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"];
    NSString *itemDatePosted = self->chosenItemDatePosted;
    
    NSString *itemRandomizeTurnOrder = [self GenerateItemRandomizeTurnOrder];
    NSMutableArray *itemAssignedTo = [[self GenerateItemAssignedTo:itemRandomizeTurnOrder] mutableCopy];
    NSString *itemDateLastAlternatedTurns = [self GenerateItemDateLastAlternatedTurns];
    
    
    
    
    //Item Type Is Chore
    NSString *itemCompletedBy = [self GenerateItemCompletedBy];
    NSMutableDictionary *itemSubTasks = [[self GenerateItemSubTasks] mutableCopy];
    
    
    
    
    //Item Type Is Expense
    NSString *itemAmount = itemAmountTextField.text;
    NSMutableDictionary *itemItemizedItems = [self GenerateItemItemizedItems:itemItemizedItemsDict itemAssignedTo:itemAssignedTo];
    NSMutableDictionary *itemCostPerPerson = [self GenerateItemCostPerPerson:itemCostPerPersonDict itemItemizedItems:itemItemizedItems];
    NSMutableDictionary *itemPaymentMethod = [self GenerateItemPaymentMethod:itemPaymentMethodDict];
    NSString *itemItemized = [self GenerateItemItemized:itemItemizedItems];
    
    
    
    
    //Item Type Is List
    NSMutableDictionary *itemListItems = [[self GenerateItemListItems:itemListItemsDict itemAssignedTo:itemAssignedTo] mutableCopy];
    
    
    
    
    
    //Item Type Is Chore or Expense
    NSMutableArray *itemSpecificDueDates = [self GenerateItemSpecificDueDates:[self GenerateItemRepeat]];
    NSString *itemApprovalNeeded = [self GenerateItemApprovalNeeded];
    NSMutableDictionary *itemApprovalRequests = [self GenerateItemApprovalRequests];
    
    
    
    
    //Item Type Is Chore, Expense, List
    NSString *itemOccurrenceStatus = [self GenerateItemOccurrenceStatus];
    NSString *itemName = itemNameTextField.text;
    NSString *itemAssignedToNewHomeMembers = [self GenerateItemAssignedToNewHomeMembers];
    NSString *itemAssignedToAnybody = [self GenerateItemAssignedToAnybody];
    NSString *itemRepeatIfCompletedEarly = [self GenerateItemRepeatIfCompletedEarly];
    NSString *itemRepeats = [self GenerateItemRepeat];
    NSString *itemDays = [self GenerateItemDays:itemRepeats];
    NSString *itemTime = [self GenerateItemTime:itemDays itemRepeats:itemRepeats itemDueDate:itemDueDateTextField.text];
    NSMutableArray *itemDueDatesSkipped = [[self GenerateItemDueDatesSkipped] mutableCopy];
    NSString *itemDate = [self GenerateItemDate];
    NSString *itemCompleteAsNeeded = [self GenerateItemCompleteAsNeeded:itemRepeats];
    NSString *itemDateLastReset = [self GenerateItemDateLastReset];
    NSString *itemDueDate = [self GenerateItemDueDate:itemRepeats itemTime:itemTime itemDays:itemDays itemRepeatIfCompletedEarly:itemRepeatIfCompletedEarly itemCompleteAsNeeded:itemCompleteAsNeeded itemDueDatesSkipped:itemDueDatesSkipped itemDateLastReset:itemDateLastReset];
    NSMutableDictionary *itemAdditionalReminders = [self GenerateItemAdditionalReminders:itemAssignedTo];
    NSMutableDictionary *itemReminderDict = [[self GenerateItemReminder:itemDueDate itemRepeats:itemRepeats itemTime:itemTime SettingData:YES] mutableCopy];
    NSMutableDictionary *itemReward = [self GenerateItemReward];
    NSString *itemDifficulty = [self GenerateItemDifficulty];
    NSString *itemPriority = [self GenerateItemPriority];
    NSString *itemColor = [self GenerateItemColor];
    NSString *itemPrivate = [self GenerateItemPrivate];
    NSString *itemImageURL = [self GenerateItemImageURL];
    NSString *itemNotes = [self GenerateItemNotes];
    NSString *itemStartDate = [self GenerateItemStartDate:itemRepeats itemDatePosted:itemDatePosted];
    NSString *itemEndDate = [self GenerateItemEndDate:itemRepeats];
    NSString *itemEndNumberOfTimes = [self GenerateItemEndDate:itemEndDate];
    NSString *itemTakeTurns = [self GenerateItemTakeTurns:itemAssignedTo itemRepeats:itemRepeats];
    NSString *itemAlternateTurns = [self GenerateItemAlternateTurns:itemTakeTurns];
    NSString *itemGracePeriod = [self GenerateItemGracePeriod:itemRepeats];
    NSString *itemStatus = [self GenerateItemStatus];
    NSString *itemPastDue = [self GenerateItemPastDue:itemTakeTurns itemDueDate:itemDueDate];
    NSMutableDictionary *itemOccurrencePastDue = [self GenerateItemOccurrencePastDue];
    NSString *itemSelfDestruct = @"Never";
    NSString *itemEstimatedTime = @"0 Minutes";
    
    NSString *itemTurnUserID = [self GenerateItemTurnUserID:itemAssignedTo itemTakeTurns:itemTakeTurns itemDueDate:itemDueDate itemRepeats:itemRepeats itemRepeatIfCompletedEarly:itemRepeatIfCompletedEarly itemCompleteAsNeeded:itemCompleteAsNeeded itemCompletedDict:itemCompletedDict];
    
    NSMutableDictionary *itemCompletedDictLocal = [self GenerateItemCompletedDict:itemAssignedTo itemListItems:itemListItems itemItemizedItems:itemItemizedItems itemCompletedDict:itemCompletedDict itemDatePosted:itemDatePosted itemDueDate:itemDueDate itemRepeats:itemRepeats itemCompleteAsNeeded:itemCompleteAsNeeded itemStartDate:itemStartDate itemTime:itemTime itemDays:itemDays itemDueDatesSkipped:itemDueDatesSkipped itemTurnUserID:itemTurnUserID];
    
    itemTurnUserID = [self GenerateItemTurnUserID:itemAssignedTo itemTakeTurns:itemTakeTurns itemDueDate:itemDueDate itemRepeats:itemRepeats itemRepeatIfCompletedEarly:itemRepeatIfCompletedEarly itemCompleteAsNeeded:itemCompleteAsNeeded itemCompletedDict:itemCompletedDictLocal];
    
    NSMutableDictionary *itemInProgressDictLocal = [self GenerateItemInProgressDict:itemAssignedTo itemListItems:itemListItems itemItemizedItems:itemItemizedItems itemInProgressDict:itemInProgressDict itemDatePosted:itemDatePosted itemDueDate:itemDueDate itemRepeats:itemRepeats itemCompleteAsNeeded:itemCompleteAsNeeded itemStartDate:itemStartDate itemTime:itemTime itemDays:itemDays itemDueDatesSkipped:itemDueDatesSkipped itemTurnUserID:itemTurnUserID];
    NSMutableDictionary *itemWontDoLocal = [self GenerateItemWontDoDict:itemAssignedTo itemListItems:itemListItems itemItemizedItems:itemItemizedItems itemWontDo:itemWontDoDict itemDatePosted:itemDatePosted itemDueDate:itemDueDate itemRepeats:itemRepeats itemCompleteAsNeeded:itemCompleteAsNeeded itemStartDate:itemStartDate itemTime:itemTime itemDays:itemDays itemDueDatesSkipped:itemDueDatesSkipped itemTurnUserID:itemTurnUserID];
    NSMutableArray *itemTags = [[self GenerateItemTags] mutableCopy];
    NSString *itemTrash = [self GenerateItemTrash];
    NSString *itemAddedLocation = [self GenerateItemAddedLocation];
    NSString *itemDeleted = [self GenerateItemDeleted];
    NSString *itemPinned = [self GenerateItemPinned];
    NSString *itemScheduledStart = self->selectedScheduledStart;
    NSString *itemPhotoConfirmation = [self GenerateItemPhotoConfirmation];
    NSMutableDictionary *itemPhotoConfirmationDict = [self GenerateItemPhotoConfirmationDict];
    NSString *itemTaskList = topViewLabel.text && [topViewLabel.text containsString:@"null"] == NO && [topViewLabel.text length] > 0 ? topViewLabel.text : @"No List";
    
    
    
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

-(NSDictionary *)GenerateTemplateDataDict {
    
    NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    
    
    
    
    //Item Type Is Chore, Expense, List
    [dataDict setObject:[self GenerateItemRandomizeTurnOrder] forKey:@"ItemRandomizedTurnOrder"];
    [dataDict setObject:[[self GenerateItemAssignedTo:dataDict[@"ItemRandomizedTurnOrder"]] mutableCopy] forKey:@"ItemAssignedTo"];
    
    
    
    
    //Item Type Is Chore or Expense
    [dataDict setObject:[self GenerateItemSpecificDueDates:[self GenerateItemRepeat]] forKey:@"ItemSpecificDueDates"];
    [dataDict setObject:[self GenerateItemApprovalNeeded] forKey:@"ItemApprovalNeeded"];
    [dataDict setObject:[self GenerateItemApprovalRequests] forKey:@"ItemApprovalRequests"];
    
    
    
    
    //Item Type Is Chore
    [dataDict setObject:[self GenerateItemCompletedBy] forKey:@"ItemCompletedBy"];
    [dataDict setObject:[[self GenerateItemSubTasks] mutableCopy] forKey:@"ItemSubtasks"];
    
    
    
    
    //Item Type Is Expense
    [dataDict setObject:itemAmountTextField.text forKey:@"ItemAmount"];
    [dataDict setObject:[self GenerateItemItemizedItems:itemItemizedItemsDict itemAssignedTo:dataDict[@"ItemAssignedTo"]] forKey:@"ItemItemizedItems"];
    [dataDict setObject:[self GenerateItemCostPerPerson:itemCostPerPersonDict itemItemizedItems:dataDict[@"ItemItemizedItems"]] forKey:@"ItemCostPerPerson"];
    [dataDict setObject:[self GenerateItemPaymentMethod:itemPaymentMethodDict] forKey:@"ItemPaymentMethod"];
    [dataDict setObject:[self GenerateItemItemized:dataDict[@"ItemItemizedItems"]] forKey:@"ItemItemized"];
    
    
    
    
    //Item Type Is List
    [dataDict setObject:[[self GenerateItemListItems:itemListItemsDict itemAssignedTo:dataDict[@"ItemAssignedTo"]] mutableCopy] forKey:@"ItemListItems"];
    
    
    
    
    [dataDict setObject:self->selectedScheduledStart forKey:@"ItemScheduledStart"];
    [dataDict setObject:itemNameTextField.text forKey:@"ItemName"];
    
    [dataDict setObject:[self GenerateItemAssignedToAnybody] forKey:@"ItemAssignedToAnybody"];
    [dataDict setObject:[self GenerateItemAssignedToNewHomeMembers] forKey:@"ItemAssignedToNewHomeMembers"];
    
    [dataDict setObject:[self GenerateItemRepeat] forKey:@"ItemRepeats"];
    [dataDict setObject:[self GenerateItemRepeatIfCompletedEarly] forKey:@"ItemRepeatIfCompletedEarly"];
    [dataDict setObject:[self GenerateItemStartDate:dataDict[@"ItemRepeats"] itemDatePosted:@""] forKey:@"ItemStartDate"];
    [dataDict setObject:[self GenerateItemEndDate:[self GenerateItemRepeat]] forKey:@"ItemEndDate"];
    [dataDict setObject:dataDict[@"ItemEndDate"] forKey:@"ItemEndNumberOfTimes"];
    
    [dataDict setObject:[self GenerateItemDays:dataDict[@"ItemRepeats"]] forKey:@"ItemDays"];
    [dataDict setObject:[self GenerateItemTime:dataDict[@"ItemDays"] itemRepeats:dataDict[@"ItemRepeats"] itemDueDate:itemDueDateTextField.text] forKey:@"ItemTime"];
    [dataDict setObject:[self GenerateItemTakeTurns:dataDict[@"ItemAssignedTo"] itemRepeats:dataDict[@"ItemRepeats"]] forKey:@"ItemTakeTurns"];
    
    [dataDict setObject:[self GenerateItemDate] forKey:@"ItemDueDate"];
    [dataDict setObject:[self GenerateItemDueDate:dataDict[@"ItemRepeats"] itemTime:dataDict[@"ItemTime"] itemDays:dataDict[@"ItemDays"] itemRepeatIfCompletedEarly:dataDict[@"ItemRepeatIfCompletedEarly"] itemCompleteAsNeeded:dataDict[@"ItemCompleteAsNeeded"] itemDueDatesSkipped:[NSMutableArray array] itemDateLastReset:@""] forKey:@"ItemDueDate"];
    
    [dataDict setObject:[self GenerateItemImageURL] forKey:@"ItemImageURL"];
    [dataDict setObject:[self GenerateItemNotes] forKey:@"ItemNotes"];
    
    [dataDict setObject:[self GenerateItemGracePeriod:dataDict[@"ItemRepeats"]] forKey:@"ItemGracePeriod"];
    [dataDict setObject:[self GenerateItemPastDue:dataDict[@"ItemTakeTurns"] itemDueDate:dataDict[@"ItemDueDate"]] forKey:@"ItemPastDue"];
    [dataDict setObject:[self GenerateItemReminder:dataDict[@"ItemDueDate"] itemRepeats:dataDict[@"ItemRepeats"] itemTime:dataDict[@"ItemTime"] SettingData:YES] forKey:@"ItemReminderDict"];
    
    [dataDict setObject:[self GenerateItemDifficulty] forKey:@"ItemDifficulty"];
    [dataDict setObject:[self GenerateItemPriority] forKey:@"ItemPriority"];
    [dataDict setObject:[self GenerateItemTags] forKey:@"ItemTags"];
    [dataDict setObject:[self GenerateItemColor] forKey:@"ItemColor"];
    
    [dataDict setObject:[self GenerateItemReward] forKey:@"ItemReward"];
    [dataDict setObject:[self GenerateItemPrivate] forKey:@"ItemPrivate"];
    
    return dataDict;
}

#pragma mark - IBAction Methods

-(IBAction)MultiAddItem:(id)sender {
    
    [self DismissAllKeyboards:NO];
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Multi-Adding %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    BOOL ErrorsFound = ([self TaskBeingAddedHasErrors] == YES);
    BOOL ReachLimitForChores = NO;//[[[BoolDataObject alloc] init] PremiumLimitForTasksReached:_allItemIDsArrays homeMembersDict:_homeMembersDict];
    
    if (ErrorsFound == NO && ReachLimitForChores == NO) {
        
        [self MultiAddItem_SetLocalIDs];
        
        NSMutableDictionary *setDataDict = [[self GenerateSetDataDict] mutableCopy];
        
        
        
        [self MultiAddItem_UpdateSetDataDict:setDataDict];
        
        [self MultiAddItem_SetLocalItemData:setDataDict];
        
        [self MultiAddItem_CompletionBlock];
        
        
        
    } else if (ReachLimitForChores == YES) {
        
        [[[PushObject alloc] init] PushToWeDivvyPremiumViewController:YES comingFromSignUp:NO defaultPlan:@"" displayDiscount:@"Half-Off Yearly Discount No Sale Sticker" selectedSlide:@"Unlimited Tasks" promoCodeID:@"" premiumPlanProductsArray:premiumPlanProductsArray premiumPlanPricesDict:premiumPlanPricesDict premiumPlanExpensivePricesDict:premiumPlanExpensivePricesDict premiumPlanPricesDiscountDict:premiumPlanPricesDiscountDict premiumPlanPricesNoFreeTrialDict:premiumPlanPricesNoFreeTrialDict currentViewController:self Superficial:NO];
        
    }
    
}

-(IBAction)AddItem:(id)sender {
    
    BOOL AddingItem = YES;
    
    [self DismissAllKeyboards:NO];
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Adding %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    BOOL ErrorsFound = ([self TaskBeingAddedHasErrors] == YES);
    BOOL ReachLimitForChores = NO;//[[[BoolDataObject alloc] init] PremiumLimitForTasksReached:_allItemIDsArrays homeMembersDict:_homeMembersDict];
    
    if (ErrorsFound == NO && ReachLimitForChores == NO) {
        
        [self AddItem_SetLocalIDs];
        
        NSMutableDictionary *setDataDict = [[self GenerateSetDataDict] mutableCopy];
        
        
        
        [self AddItem_SetLocalItemData:setDataDict];
        
        [self AddItem_CompletionBlock];
        
        NSTimeInterval delayInSeconds = 0.1;
        
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            
            [self AddItem_SetLocalTaskListData:^(BOOL finished, NSMutableDictionary *returningNewTaskListDict) {
                
                
                
                self->totalQueries = 8;
                self->completedQueries = 0;
                
                
                
                /*
                 //
                 //
                 //Set Topic Data
                 //
                 //
                 */
                [self AddItem_SetDataTopic:setDataDict completionHandler:^(BOOL finished) {
                    
                }];
                
                /*
                 //
                 //
                 //Scheduled Start Silent Notification
                 //
                 //
                 */
                [self AddItem_PushNotificationOrScheduledStartNotifications:setDataDict completionHandler:^(BOOL finished) {
                    
                }];
                
                
                /*
                 //
                 //
                 //Item Silent Notification
                 //
                 //
                 */
                [self AddItem_EditItem_ResetItemNotifications:setDataDict AddingItem:AddingItem completionHandler:^(BOOL finished) {
                    
                }];
                
                
                /*
                 //
                 //
                 //Set Item Data
                 //
                 //
                 */
                [self AddItem_SetItemData:setDataDict completionHandler:^(BOOL finished) {
                    
                }];
                
                
                /*
                 //
                 //
                 //Set Image Data
                 //
                 //
                 */
                [self AddItem_SetImageData:setDataDict completionHandler:^(BOOL finished) {
                    
                }];
                
                
                /*
                 //
                 //
                 //Set Task List Data
                 //
                 //
                 */
                [self AddItem_SetTaskListData:returningNewTaskListDict completionHandler:^(BOOL finished) {
                    
                }];
                
                
                /*
                 //
                 //
                 //Set Item And Home Data
                 //
                 //
                 */
                [self AddItem_SetItemAndHomeActivity:setDataDict completionHandler:^(BOOL finished) {
                    
                }];
                
                
                /*
                 //
                 //
                 //Set Algolia Data
                 //
                 //
                 */
                [self AddItem_SetAlgoliaData:setDataDict completionHandler:^(BOOL finished) {
                    
                }];
                
            }];
            
        });
        
    } else if (ReachLimitForChores == YES) {
        
        [[[PushObject alloc] init] PushToWeDivvyPremiumViewController:YES comingFromSignUp:NO defaultPlan:@"" displayDiscount:@"Half-Off Yearly Discount No Sale Sticker" selectedSlide:@"Unlimited Tasks" promoCodeID:@"" premiumPlanProductsArray:premiumPlanProductsArray premiumPlanPricesDict:premiumPlanPricesDict premiumPlanExpensivePricesDict:premiumPlanExpensivePricesDict premiumPlanPricesDiscountDict:premiumPlanPricesDiscountDict premiumPlanPricesNoFreeTrialDict:premiumPlanPricesNoFreeTrialDict currentViewController:self Superficial:NO];
        
    }
    
}

-(IBAction)EditItem:(id)sender {
    
    BOOL AddingItem = NO;
    
    [self DismissAllKeyboards:NO];
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Editting %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    BOOL ErrorsFound = ([self TaskBeingAddedHasErrors] == YES);
    
    if (ErrorsFound == NO) {
        
        [self EditItem_SetLocalIDs];
        
        NSDictionary *setDataDict = [self GenerateSetDataDict];
        
        [self EditItem_SetLocalItemData:setDataDict];
        
        [self EditItem_CompletionBlock:setDataDict];
     
        NSTimeInterval delayInSeconds = 0.1;
        
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            
            [self EditItem_SetLocalTaskListData:^(BOOL finished, NSMutableDictionary *returningNewTaskListDict) {
                
              
                
                self->totalQueries = 8;
                self->completedQueries = 0;
                
                
                
                /*
                 //
                 //
                 //Scheduled Start Silent Notification
                 //
                 //
                 */
                [self EditItem_PushNotificationOrScheduledStartNotifications:setDataDict completionHandler:^(BOOL finished) {
                    
                }];
                
                
                /*
                 //
                 //
                 //Item Silent Notification
                 //
                 //
                 */
                [self AddItem_EditItem_ResetItemNotifications:setDataDict AddingItem:AddingItem completionHandler:^(BOOL finished) {
                    
                }];
                
                
                /*
                 //
                 //
                 //Update Topic Data
                 //
                 //
                 */
                [self EditItem_UpdateTopicData:setDataDict completionHandler:^(BOOL finished) {
                    
                }];
                
                
                /*
                 //
                 //
                 //Update Item Data
                 //
                 //
                 */
                [self EditItem_UpdateItemData:setDataDict completionHandler:^(BOOL finished) {
                    
                }];
                
                
                /*
                 //
                 //
                 //Update Image Data
                 //
                 //
                 */
                [self Edititem_UpdateItemImage:^(BOOL finished) {
                    
                }];
                
                
                /*
                 //
                 //
                 //Update Task List Data
                 //
                 //
                 */
                [self EditItem_UpdateTaskListData:returningNewTaskListDict completionHandler:^(BOOL finished) {
                    
                }];
                
                
                /*
                 //
                 //
                 //Set Item And Home Data
                 //
                 //
                 */
                [self EditItem_SetItemHomeAndActivityData:setDataDict completionHandler:^(BOOL finished) {
                    
                }];
                
                
                /*
                 //
                 //
                 //Update Algolia Data
                 //
                 //
                 */
                [self EditItem_UpdateAlgoliaData:setDataDict completionHandler:^(BOOL finished) {
                    
                }];
                
            }];
            
        });
        
    }
    
}

-(IBAction)DeleteItem:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"DeleteItem Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Would you like to delete \"%@\"?", self->_itemToEditDict[@"ItemName"]] message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Deleting %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
            
        }];
        
        
        
        [self DeleteItem_UpdateItemToEditDict];
        
        [self DeleteItem_SetLocalItemData];
        
        [self DeleteItem_CompletionBlock];
        
        
        
        /*
         //
         //
         //Delete Item Data
         //
         //
         */
        [self DeleteItem_DeleteItemData:^(BOOL finished) {
            
        }];
        
    }];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"DeleteItem Cancelled For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
            
        }];
        
    }]];
    
    [deleteAction setValue:[UIColor systemRedColor] forKey:@"titleTextColor"];
    
    [actionSheet addAction:deleteAction];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
    
}

#pragma mark

-(IBAction)SaveTemplate:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"SaveTemplate Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    if (_editingTemplate) {
        
        //        [self StartProgressView];
        
        NSString *templateID = _templateToEditDict[@"Template"][@"TemplateID"];
        NSString *templateCreatedBy = _templateToEditDict[@"Template"][@"TemplateCreatedBy"];
        
        NSDictionary *dataDict = [self GenerateTemplateDataDict];
        
        NSMutableDictionary *setDataDict = _templateToEditDict[@"Template"];
        [setDataDict setObject:dataDict forKey:@"TemplateData"];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"templateID == %@", templateID];
        [[[SetDataObject alloc] init] SetDataEditCoreData:@"Templates" predicate:predicate setDataObject:[dataDict mutableCopy]];
        
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"AddOrEditItemTemplate" userInfo:setDataDict locations:@[@"Tasks", @"AddTask", @"MultiAddTasks", @"ViewTask"]];
        
        [self->progressView setHidden:YES];
        [self DismissViewController:self];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [[[SetDataObject alloc] init] UpdateDataTemplate:templateCreatedBy templateID:templateID dataDict:[dataDict mutableCopy] completionHandler:^(BOOL finished) {
                
            }];
            
        });
        
    } else {
        
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Enter your template name" message:nil
                                                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Save"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * _Nonnull action) {
            
            //            [self StartProgressView];
            
            NSString *templateName = controller.textFields[0].text;
            
            NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
            NSString *trimmedStringString = [templateName stringByTrimmingCharactersInSet:charSet];
            
            if ([trimmedStringString isEqualToString:@""]) {
                
                [self->progressView setHidden:YES];
                [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"Template Name field is empty" currentViewController:self];
                
            } else if (self->_templateDict && self->_templateDict[@"TemplateName"] && [self->_templateDict[@"TemplateName"] containsObject:templateName]) {
                
                [self->progressView setHidden:YES];
                [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You already have a template with this name" currentViewController:self];
                
            } else {
                
                NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
                NSString *randomID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
                NSString *dateCreated = [[[GeneralObject alloc] init] GenerateCurrentDateString];
                NSString *newName = templateName;
                
                NSDictionary *dataDict = [self GenerateTemplateDataDict];
                
                NSDictionary *setDataDict = @{
                    @"TemplateID" : randomID,
                    @"TemplateDateCreated" : dateCreated,
                    @"TemplateCreatedBy" : userID,
                    @"TemplateName" : newName,
                    @"TemplateDefault" : @"No",
                    @"TemplateData" : dataDict
                };
                
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"templateID == %@", setDataDict[@"TemplateID"]];
                [[[SetDataObject alloc] init] SetDataAddCoreData:@"Templates" predicate:predicate setDataObject:[setDataDict mutableCopy]];
                
                [[[GeneralObject alloc] init] CallNSNotificationMethods:@"AddOrEditItemTemplate" userInfo:setDataDict locations:@[@"Tasks", @"AddTask", @"MultiAddTasks", @"ViewTask"]];
                
                [self->progressView setHidden:YES];
                [self DismissViewController:self];
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    
                    [[[SetDataObject alloc] init] SetDataAddTemplate:setDataDict[@"TemplateCreatedBy"] templateID:setDataDict[@"TemplateID"] dataDict:setDataDict completionHandler:^(BOOL finished) {
                        
                    }];
                    
                });
                
            }
            
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                         style:UIAlertActionStyleCancel
                                                       handler:^(UIAlertAction * _Nonnull action) {}];
        
        
        
        [controller addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            
            textField.delegate = self;
            textField.placeholder = @"Template Name";
            textField.text = @"";
            textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
            
        }];
        
        [controller addAction:action1];
        [controller addAction:cancel];
        [self presentViewController:controller animated:YES completion:nil];
        
    }
    
}

-(IBAction)SaveDraft:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"SaveDraft Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    if (_editingDraft) {
        
        //        [self StartProgressView];
        
        NSString *draftID = _draftToEditDict[@"Draft"][@"DraftID"];
        NSString *draftCreatedBy = _draftToEditDict[@"Draft"][@"DraftCreatedBy"];
        
        self->chosenItemUniqueID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
        self->chosenItemID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
        self->chosenItemOccurrenceID = @"";
        self->chosenItemDatePosted = [[[GeneralObject alloc] init] GenerateCurrentDateString];
        
        NSDictionary *dataDict = [self GenerateSetDataDict];
        
        NSMutableDictionary *setDataDict = _draftToEditDict[@"Draft"];
        [setDataDict setObject:dataDict forKey:@"DraftData"];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"draftID == %@", dataDict[@"DraftID"]];
        [[[SetDataObject alloc] init] SetDataEditCoreData:@"Drafts" predicate:predicate setDataObject:dataDict];
        
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"AddOrEditItemDraft" userInfo:setDataDict locations:@[@"Tasks", @"AddTask", @"MultiAddTasks", @"ViewTask"]];
        
        [self->progressView setHidden:YES];
        [self DismissViewController:self];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [[[SetDataObject alloc] init] UpdateDataDraft:draftCreatedBy draftID:draftID setDataDict:dataDict completionHandler:^(BOOL finished) {
                
            }];
            
        });
        
    } else {
        
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Enter your draft name" message:nil
                                                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Save"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * _Nonnull action) {
            
            //            [self StartProgressView];
            
            NSString *draftName = controller.textFields[0].text;
            
            NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
            NSString *trimmedStringString = [draftName stringByTrimmingCharactersInSet:charSet];
            
            if ([trimmedStringString isEqualToString:@""]) {
                
                [self->progressView setHidden:YES];
                [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"Draft Name field is empty" currentViewController:self];
                
            } else if (self->_draftDict && self->_draftDict[@"DraftName"] && [self->_draftDict[@"DraftName"] containsObject:draftName]) {
                
                [self->progressView setHidden:YES];
                [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"You already have a draft with this name" currentViewController:self];
                
            } else {
                
                NSString *draftCreatedBy = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
                NSString *draftID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
                NSString *dateCreated = [[[GeneralObject alloc] init] GenerateCurrentDateString];
                NSString *newName = draftName;
                
                self->chosenItemUniqueID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
                self->chosenItemID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
                self->chosenItemOccurrenceID = @"";
                self->chosenItemDatePosted = [[[GeneralObject alloc] init] GenerateCurrentDateString];
                
                NSDictionary *dataDict = [self GenerateSetDataDict];
                
                NSDictionary *setDataDict = @{
                    @"DraftID" : draftID,
                    @"DraftDateCreated" : dateCreated,
                    @"DraftCreatedBy" : draftCreatedBy,
                    @"DraftName" : newName,
                    @"DraftData" : dataDict
                };
                
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"draftID == %@", setDataDict[@"DraftID"]];
                [[[SetDataObject alloc] init] SetDataAddCoreData:@"Drafts" predicate:predicate setDataObject:[setDataDict mutableCopy]];
                
                [[[GeneralObject alloc] init] CallNSNotificationMethods:@"AddOrEditItemDraft" userInfo:setDataDict locations:@[@"Tasks", @"AddTask", @"MultiAddTasks", @"ViewTask"]];
                
                [self->progressView setHidden:YES];
                
                BOOL ObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:sender classArr:@[[NSString class]]];
                
                BOOL SavingDraftWhileClosingPage = ObjectIsKindOfClass == YES && [sender isEqualToString:@"NavigationBackButtonAction"];
                
                if (SavingDraftWhileClosingPage) {
                    [self DismissViewController:self];
                }
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    
                    [[[SetDataObject alloc] init] SetDataAddDraft:draftCreatedBy draftID:draftID setDataDict:setDataDict completionHandler:^(BOOL finished) {
                        
                    }];
                    
                });
                
            }
            
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                         style:UIAlertActionStyleCancel
                                                       handler:^(UIAlertAction * _Nonnull action) {}];
        
        
        
        [controller addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            
            textField.delegate = self;
            textField.placeholder = @"Draft Name";
            textField.text = @"";
            textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
            
        }];
        
        [controller addAction:action1];
        [controller addAction:cancel];
        [self presentViewController:controller animated:YES completion:nil];
        
    }
    
}


#pragma mark

-(IBAction)RepeatIfCompletedEarlySwitchAction:(id)sender {
    
    BOOL ObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:sender classArr:@[[NSString class]]];
    
    if (ObjectIsKindOfClass == YES && [(NSString *)sender isEqualToString:@"Yes"]) {
        [itemRepeatIfCompletedEarlySwitch setOn:YES];
    } else if (ObjectIsKindOfClass == YES && [(NSString *)sender isEqualToString:@"No"]) {
        [itemRepeatIfCompletedEarlySwitch setOn:NO];
    }
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Repeat If Completed Early Switch Turned %@ For %@", itemRepeatIfCompletedEarlySwitch && itemRepeatIfCompletedEarlySwitch.isOn == YES ? @"On" : @"Off", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    NSString *itemRepeats = [self GenerateItemRepeat];
    
    BOOL TaskIsRepeatingWeekly = [[[BoolDataObject alloc] init] TaskIsRepeatingWeekly:[@{@"ItemRepeats" : itemRepeats} mutableCopy] itemType:itemType];
    BOOL TaskIsRepeatingMonthly = [[[BoolDataObject alloc] init] TaskIsRepeatingMonthly:[@{@"ItemRepeats" : itemRepeats} mutableCopy] itemType:itemType];
    
    if ([itemRepeatIfCompletedEarlySwitch isOn] && (TaskIsRepeatingWeekly == YES || TaskIsRepeatingMonthly == YES)) {
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemDays" userInfo:@{@"Days" : [NSMutableArray array], @"AnyDay" : @"Yes"} locations:@[@"AddTask"]];
    }
    
    chosenItemRepeatIfCompletedEarly = [itemRepeatIfCompletedEarlySwitch isOn] ? @"Yes" : @"No";
   
    if (itemRepeatIfCompletedEarlySwitch.isOn) {
        
        tapView = [[UIView alloc] initWithFrame:itemDaysView.frame];
        tapView.backgroundColor = [UIColor clearColor];
        tapView.alpha = itemDaysView.alpha;
        tapView.hidden = itemDaysView.hidden;
        [_customScrollView addSubview:tapView];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGestureItemRepeatIfCompletedEarly:)];
        [tapView addGestureRecognizer:tapGesture];
        tapView.userInteractionEnabled = YES;
      
    } else {
        
        [tapView removeFromSuperview];
        
    }
    
}

- (IBAction)TakeTurnsSwitchAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Take Turns Switch Turned %@ For %@", itemEveryoneTakesTurnsSwitch && itemEveryoneTakesTurnsSwitch.isOn == YES ? @"On" : @"Off", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    [self AdjustTextFieldFramesToUse:0.25];
    
}


- (IBAction)PrivateSwitchAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Private Switch Turned %@ For %@", itemPrivateSwitch.isOn == YES ? @"On" : @"Off", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    if ([[[BoolDataObject alloc] init] PremiumSubscriptionIsOn] == NO) {
        
        [itemPrivateSwitch setOn:NO];
        
        [[[PushObject alloc] init] PushToWeDivvyPremiumViewController:YES comingFromSignUp:NO defaultPlan:@"" displayDiscount:@"Half-Off Yearly Discount No Sale Sticker" selectedSlide:@"Private Tasks" promoCodeID:@"" premiumPlanProductsArray:premiumPlanProductsArray premiumPlanPricesDict:premiumPlanPricesDict premiumPlanExpensivePricesDict:premiumPlanExpensivePricesDict premiumPlanPricesDiscountDict:premiumPlanPricesDiscountDict premiumPlanPricesNoFreeTrialDict:premiumPlanPricesNoFreeTrialDict currentViewController:self Superficial:NO];
        
    }
    
    chosenItemPrivate = [itemPrivateSwitch isOn] ? @"Yes" : @"";
    
}

-(IBAction)ApprovalNeededSwitchAction:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Approval Needed Switch Turned %@ For %@", itemApprovalNeededSwitch.isOn == YES ? @"On" : @"Off", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    if ([[[BoolDataObject alloc] init] PremiumSubscriptionIsOn] == NO) {
        
        [itemApprovalNeededSwitch setOn:NO];
        
        [[[PushObject alloc] init] PushToWeDivvyPremiumViewController:YES comingFromSignUp:NO defaultPlan:@"" displayDiscount:@"Half-Off Yearly Discount No Sale Sticker" selectedSlide:@"Require Approval" promoCodeID:@"" premiumPlanProductsArray:premiumPlanProductsArray premiumPlanPricesDict:premiumPlanPricesDict premiumPlanExpensivePricesDict:premiumPlanExpensivePricesDict premiumPlanPricesDiscountDict:premiumPlanPricesDiscountDict premiumPlanPricesNoFreeTrialDict:premiumPlanPricesNoFreeTrialDict currentViewController:self Superficial:NO];
        
    }
    
    chosenItemApprovalNeeded = [itemApprovalNeededSwitch isOn] ? @"Yes" : @"No";
    
}


#pragma mark

-(IBAction)SaveMoreOptions:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"SaveMoreOptions Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    NSDictionary *dataDict = @{
        
        @"TaskList" : topViewLabel.text ? topViewLabel.text : @"No List",
        
        @"ItemAssignedTo" : assignedToIDArray ? assignedToIDArray : [NSMutableArray array],
        @"ItemRepeats" : chosenItemRepeats ? chosenItemRepeats : @"Never",
        
        @"ItemSubTasks" : itemSubTasksDict ? itemSubTasksDict : [NSMutableDictionary dictionary],
        @"ItemReminderDict" : itemReminderDict ? itemReminderDict : [NSMutableDictionary dictionary],
        @"ItemGracePeriod" : itemGracePeriodTextField.text ? itemGracePeriodTextField.text : @"",
        @"ItemPastDue" : chosenItemPastDue ? chosenItemPastDue : @"2 Days",
        
        @"ItemReward" : itemRewardDict ? itemRewardDict : @{@"Reward" : @"None", @"RewardDescription" : @"", @"RewardNotes" : @""},
        @"ItemPrivate" : [itemPrivateSwitch isOn] ? @"Yes" : @"No",
        @"ItemApprovalNeeded" : [itemApprovalNeededSwitch isOn] ? @"Yes" : @"No",
        
        @"ItemColor" : chosenItemColor ? chosenItemColor : @"None",
        @"ItemTags" : itemTagsArrays ? itemTagsArrays : [NSMutableArray array],
        @"ItemPriority" : itemPriorityTextField.text ? itemPriorityTextField.text : @"",
        @"ItemDifficulty" : itemDifficultyTextField.text ? itemDifficultyTextField.text : @"",
        
    };
    
    [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemBringBackMoreOptions" userInfo:dataDict locations:@[@"AddTask"]];
    
    [self DismissViewController:self];
    
}

#pragma mark

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
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Navigation Back Button Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"NewUserInfoViewWasDismissed"];
    
    [topView removeFromSuperview];
    
    [self DismissViewController:self];
    
}

#pragma mark - Tap Gesture IBAction Methods

-(IBAction)TapGestureCloseNewUserInfoView:(id)sender {
    
    [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"NewUserInfoViewWasDismissed"];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        CGRect newRect = self->newUserInfoView.frame;
        newRect.size.height = 0;
        self->newUserInfoView.frame = newRect;
        
        self->newUserInfoView.alpha = 0.0f;
        
    }];
    
    [self AdjustTextFieldFramesToUse:0.25];
}

#pragma mark

-(void)ApprovalNeededPopup {
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Approval Needed" message:[NSString stringWithFormat:@"This option requires the %@ creator's approval before it is completed", [itemType lowercaseString]]
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Got it!"
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction * _Nonnull action) {}];
    
    [controller addAction:cancel];
    [self presentViewController:controller animated:YES completion:nil];
    
}

-(void)GracePeriodPopup {
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Grace Period" message:[NSString stringWithFormat:@"This option allows you to give everyone extra time to complete the %@ before it becomes \"Past Due\"", [itemType lowercaseString]]
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Got it!"
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction * _Nonnull action) {}];
    
    [controller addAction:cancel];
    [self presentViewController:controller animated:YES completion:nil];
    
}

-(void)PastDuePopup {
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Past Due" message:[NSString stringWithFormat:@"This option allows you to decide how much time a %@ remains in \"Past Due\" until it expires and is no longer available to complete", [itemType lowercaseString]]
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Got it!"
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction * _Nonnull action) {}];
    
    [controller addAction:cancel];
    [self presentViewController:controller animated:YES completion:nil];
    
}

-(void)StartDatePopup {
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Start Date" message:[NSString stringWithFormat:@"This option allows you choose the first due date of your %@.\n\n(Leave it blank to allow WeDivvy to generate your first due date)", [itemType lowercaseString]]
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Got it!"
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction * _Nonnull action) {}];
    
    [controller addAction:cancel];
    [self presentViewController:controller animated:YES completion:nil];
    
}

#pragma mark

-(IBAction)TapGestureItemAssignedTo:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Assigned To Field Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    NSMutableArray *selectedArray = [NSMutableArray array];
    
    if ([itemAssignedToTextField.text isEqualToString:@"Myself"]) {
        [selectedArray addObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"]];
    } else if ([itemAssignedToTextField.text isEqualToString:@"Nobody"] == NO) {
        selectedArray = [[itemAssignedToTextField.text componentsSeparatedByString:@", "] mutableCopy];
    }
    
    if ([selectedArray containsObject:@""]) {
        [selectedArray removeObject:@""];
    }
    
    NSString *itemAssignedToAnybody = self->chosenItemAssignedToAnybody != NULL ? self->chosenItemAssignedToAnybody : @"No";
    NSString *itemAssignedToNewHomeMembers = self->chosenItemAssignedToNewHomeMembers != NULL ? self->chosenItemAssignedToNewHomeMembers : @"No";
    NSString *itemUniqueID = self->_itemToEditDict[@"ItemUniqueID"] ? self->_itemToEditDict[@"ItemUniqueID"] : @"xxx";
    
    NSMutableDictionary *homeMembersUnclaimedDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeMembersUnclaimedDict"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeMembersUnclaimedDict"] : [NSMutableDictionary dictionary];
    NSMutableDictionary *homeKeysDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeKeysDict"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeKeysDict"] : [NSMutableDictionary dictionary];
    NSMutableArray *homeKeysArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeKeysArray"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeKeysArray"] : [NSMutableArray array];
    
    [[[PushObject alloc] init] PushToViewAssignedViewController:selectedArray itemAssignedToNewHomeMembers:itemAssignedToNewHomeMembers itemAssignedToAnybody:itemAssignedToAnybody itemUniqueID:itemUniqueID homeMembersArray:self->_homeMembersArray homeMembersDict:self->_homeMembersDict homeMembersUnclaimedDict:homeMembersUnclaimedDict homeKeysDict:homeKeysDict homeKeysArray:homeKeysArray notificationSettingsDict:self->_notificationSettingsDict topicDict:self->_topicDict viewingItemDetails:_viewingTask viewingExpense:_viewingAddExpenseViewController viewingChatMembers:NO viewingWeDivvyPremiumAddingAccounts:NO viewingWeDivvyPremiumEditingAccounts:NO currentViewController:self];
    
}

-(IBAction)TapGestureItemItemize:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:@"Itemize" completionHandler:^(BOOL finished) {
        
    }];
    
    [[[PushObject alloc] init] PushToViewAddItemsViewController:nil itemsAlreadyChosenDict:itemItemizedItemsDict userDict:nil optionSelectedString:@"Itemized" itemRepeats:itemRepeatsTextField.text viewingItemDetails:_viewingTask currentViewController:self];
    
}

-(IBAction)TapGestureItemCostPerPerson:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Cost Per Person Field Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
    NSString *trimmedStringItemAssignedTo = [itemAssignedToTextField.text stringByTrimmingCharactersInSet:charSet];
    
    if (trimmedStringItemAssignedTo.length == 0 || [trimmedStringItemAssignedTo isEqualToString:@"Nobody"] == YES) {
        
        [[[GeneralObject alloc] init] TextFieldIsEmptyColorChange:itemAssignedToView textFieldField:itemAssignedToTextField textFieldShouldDisplay:YES defaultColor:defaultFieldColor];
        
    } else {
        
        topView.hidden = YES;
        topViewCover.hidden = YES;
        //        templateView.hidden = YES;
        //        templateViewCover.hidden = YES;
        
        NSMutableArray *userIDArray = [self GenerateItemAssignedTo:@"No"];
        
        [[[PushObject alloc] init] PushToViewViewCostPerPersonViewController:userIDArray itemAssignedToUsernameArray:assignedToUsernameArray itemAssignedToProfileImageArray:assignedToProfileImageArray itemAmount:itemAmountTextField.text costPerPersonDict:itemCostPerPersonDict itemItemizedItemsDict:itemItemizedItemsDict viewingItemDetails:_viewingTask currentViewController:self];
        
    }
    
}

-(IBAction)TapGestureItemPaymentMethod:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Item Payment Method Field Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    [[[PushObject alloc] init] PushToViewPaymentMethodViewController:itemPaymentMethodDict viewingReward:NO comingFromAddTaskViewController:YES viewingItemDetails:_viewingTask currentViewController:self];
    
}

-(IBAction)TapGestureItemListItems:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"List Items Field Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    NSMutableDictionary *currentlyAssignedUserDict = [NSMutableDictionary dictionary];
    [currentlyAssignedUserDict setObject:[NSMutableArray array] forKey:@"UserID"];
    [currentlyAssignedUserDict setObject:[NSMutableArray array] forKey:@"Username"];
    [currentlyAssignedUserDict setObject:[NSMutableArray array] forKey:@"ProfileImageURL"];
    
    for (NSString *userID in _homeMembersDict[@"UserID"]) {
        
        NSDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:userID homeMembersDict:_homeMembersDict];
        [currentlyAssignedUserDict[@"UserID"] addObject:dataDict[@"UserID"]];
        [currentlyAssignedUserDict[@"Username"] addObject:dataDict[@"Username"]];
        [currentlyAssignedUserDict[@"ProfileImageURL"] addObject:dataDict[@"ProfileImageURL"]];
        
    }
    
    //    NSMutableArray *userIDArray = [self GenerateItemAssignedTo:@"No"];
    //
    //    for (NSString *userID in userIDArray) {
    //
    //        if ([userDictForHomeMembers[@"UserID"] containsObject:userID]) {
    //
    //            NSUInteger index = [userDictForHomeMembers[@"UserID"] indexOfObject:userID];
    //            [currentlyAssignedUserDict[@"UserID"] addObject:[(NSArray *)userDictForHomeMembers[@"UserID"] count] > index ? userDictForHomeMembers[@"UserID"][index] : @""];
    //            [currentlyAssignedUserDict[@"Username"] addObject:[(NSArray *)userDictForHomeMembers[@"Username"] count] > index ? userDictForHomeMembers[@"Username"][index] : @""];
    //            [currentlyAssignedUserDict[@"ProfileImageURL"] addObject:[(NSArray *)userDictForHomeMembers[@"ProfileImageURL"] count] > index ? userDictForHomeMembers[@"ProfileImageURL"][index] : @""];
    //
    //        }
    //
    //    }
    
    [[[PushObject alloc] init] PushToViewAddItemsViewController:nil itemsAlreadyChosenDict:itemListItemsDict userDict:currentlyAssignedUserDict optionSelectedString:@"ListItems" itemRepeats:itemRepeatsTextField.text viewingItemDetails:_viewingTask currentViewController:self];
    
}

-(IBAction)TapGestureItemRepeats:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Repeats Field Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    NSMutableArray *itemsSelectedArray = [NSMutableArray array];
    
    if (itemRepeatsTextField.text.length > 0) {
        
        itemsSelectedArray = [[itemRepeatsTextField.text componentsSeparatedByString:@""] mutableCopy];
        
    }
    
    [[[PushObject alloc] init] PushToViewOptionsViewController:itemsSelectedArray customOptionsArray:nil specificDatesArray:nil viewingItemDetails:_viewingTask optionSelectedString:@"Repeats" itemRepeatsFrequency:nil homeMembersDict:nil currentViewController:self];
    
}

-(IBAction)TapGestureItemDays:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Days Field Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    NSMutableArray *itemsSelectedArray = [NSMutableArray array];
    
    if (itemDaysTextField.text.length > 0) {
        
        itemsSelectedArray = [[itemDaysTextField.text componentsSeparatedByString:@", "] mutableCopy];
        
    }
    
    [[[PushObject alloc] init] PushToViewOptionsViewController:itemsSelectedArray customOptionsArray:nil specificDatesArray:nil viewingItemDetails:_viewingTask optionSelectedString:@"Days" itemRepeatsFrequency:itemRepeatsTextField.text homeMembersDict:nil currentViewController:self];
    
}

-(IBAction)TapGestureItemAlternateTurns:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Alternate Turns Field Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    NSMutableArray *itemsSelectedArray = [NSMutableArray array];
    
    if (itemAlternateTurnsTextField.text.length > 0) {
        
        itemsSelectedArray = [[itemAlternateTurnsTextField.text componentsSeparatedByString:@""] mutableCopy];
        
    }
    
    [[[PushObject alloc] init] PushToViewOptionsViewController:itemsSelectedArray customOptionsArray:nil specificDatesArray:nil viewingItemDetails:_viewingTask optionSelectedString:@"AlternateTurns" itemRepeatsFrequency:itemRepeatsTextField.text homeMembersDict:nil currentViewController:self];
    
}

-(IBAction)TapGestureItemSpecificOrder:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Specific Order Field Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    NSMutableArray *itemsSelectedArray = [NSMutableArray array];
    
    if (itemTurnOrderTextField.text.length > 0) {
        
        itemsSelectedArray = [[itemTurnOrderTextField.text componentsSeparatedByString:@", "] mutableCopy];
        
    }
    
    NSMutableDictionary *currentlyAssignedUserDict = [NSMutableDictionary dictionary];
    [currentlyAssignedUserDict setObject:[NSMutableArray array] forKey:@"UserID"];
    [currentlyAssignedUserDict setObject:[NSMutableArray array] forKey:@"Username"];
    [currentlyAssignedUserDict setObject:[NSMutableArray array] forKey:@"ProfileImageURL"];
    
    NSMutableArray *userIDArray = [self GenerateItemAssignedTo:[self GenerateItemRandomizeTurnOrder]];
    
    for (NSString *userID in userIDArray) {
        
        if ([userDictForHomeMembers[@"UserID"] containsObject:userID]) {
            
            NSDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:userID homeMembersDict:_homeMembersDict];
            [currentlyAssignedUserDict[@"UserID"] addObject:dataDict[@"UserID"]];
            [currentlyAssignedUserDict[@"Username"] addObject:dataDict[@"Username"]];
            [currentlyAssignedUserDict[@"ProfileImageURL"] addObject:dataDict[@"ProfileImageURL"]];
            
        }
        
    }
    
    [[[PushObject alloc] init] PushToViewOptionsViewController:itemsSelectedArray customOptionsArray:nil specificDatesArray:nil viewingItemDetails:_viewingTask optionSelectedString:@"TurnOrder" itemRepeatsFrequency:itemRepeatsTextField.text homeMembersDict:currentlyAssignedUserDict currentViewController:self];
    
}

#pragma mark

//More Options
-(IBAction)TapGestureItemMoreOptions:(id)sender {
    
    //    [self AttributeString:itemNotesTextField.text];
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"More Options Field Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    _moreOptionsDict = [NSMutableDictionary dictionary];
    [_moreOptionsDict setObject:itemSubTasksDict ? itemSubTasksDict : [NSMutableDictionary dictionary]  forKey:@"ItemSubTasks"];
    [_moreOptionsDict setObject:[self GenerateItemAssignedTo:[self GenerateItemRandomizeTurnOrder]] ? [[self GenerateItemAssignedTo:[self GenerateItemRandomizeTurnOrder]] mutableCopy] : [@[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] mutableCopy] forKey:@"ItemAssignedTo"];
    [_moreOptionsDict setObject:topViewLabel.text ? topViewLabel.text : @"No List" forKey:@"TaskList"];
    [_moreOptionsDict setObject:itemRewardDict ? itemRewardDict : @{@"Reward" : @"None", @"RewardDescription" : @"", @"RewardNotes" : @""} forKey:@"ItemReward"];
    [_moreOptionsDict setObject:chosenItemDifficulty ? chosenItemDifficulty : @"No Difficulty" forKey:@"ItemDifficulty"];
    [_moreOptionsDict setObject:chosenItemPriority ? chosenItemPriority : @"No Priority" forKey:@"ItemPriority"];
    [_moreOptionsDict setObject:chosenItemColor ? chosenItemColor : @"None" forKey:@"ItemColor"];
    [_moreOptionsDict setObject:chosenItemPrivate ? chosenItemPrivate : @"No" forKey:@"ItemPrivate"];
    [_moreOptionsDict setObject:chosenItemRepeats ? chosenItemRepeats : @"Never" forKey:@"ItemRepeats"];
    [_moreOptionsDict setObject:itemTagsArrays ? itemTagsArrays : @"0 Tags" forKey:@"ItemTags"];
    [_moreOptionsDict setObject:chosenItemGracePeriod ? chosenItemGracePeriod : @"None" forKey:@"ItemGracePeriod"];
    [_moreOptionsDict setObject:chosenItemPastDue ? chosenItemPastDue : @"2 Days" forKey:@"ItemPastDue"];
    [_moreOptionsDict setObject:chosenItemApprovalNeeded ? chosenItemApprovalNeeded : @"No" forKey:@"ItemApprovalNeeded"];
    
    NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
    
    [[[PushObject alloc] init] PushToAddTaskViewController:self->_itemToEditDict partiallyAddedDict:nil suggestedItemToAddDict:self->_suggestedItemToAddDict templateToEditDict:nil draftToEditDict:nil moreOptionsDict:_moreOptionsDict multiAddDict:self->_itemToEditDict notificationSettingsDict:self->_notificationSettingsDict topicDict:self->_topicDict homeID:homeID homeMembersArray:_homeMembersArray homeMembersDict:_homeMembersDict itemOccurrencesDict:_itemOccurrencesDict folderDict:_folderDict taskListDict:_taskListDict templateDict:_templateDict draftDict:_draftDict allItemAssignedToArrays:_allItemAssignedToArrays allItemTagsArrays:_allItemTagsArrays allItemIDsArrays:_allItemIDsArrays defaultTaskListName:topViewLabel.text partiallyAddedTask:_partiallyAddedTask addingTask:_addingTask addingMultipleTasks:_addingMultipleTasks addingSuggestedTask:_addingSuggestedTask editingTask:_editingTask viewingTask:_viewingTask viewingMoreOptions:YES duplicatingTask:_duplicatingTask editingTemplate:_editingTemplate viewingTemplate:_viewingTemplate editingDraft:_editingDraft viewingDraft:_viewingDraft currentViewController:self Superficial:NO];
    
}

-(IBAction)TapGestureitemSubTasks:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Subtasks Field Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    NSMutableDictionary *currentlyAssignedUserDict = [NSMutableDictionary dictionary];
    [currentlyAssignedUserDict setObject:[NSMutableArray array] forKey:@"UserID"];
    [currentlyAssignedUserDict setObject:[NSMutableArray array] forKey:@"Username"];
    [currentlyAssignedUserDict setObject:[NSMutableArray array] forKey:@"ProfileImageURL"];
    
    NSMutableArray *userIDArray = [self GenerateItemAssignedTo:@"No"];
    
    for (NSString *userID in userIDArray) {
        
        if ([userDictForHomeMembers[@"UserID"] containsObject:userID]) {
            
            NSDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:userID homeMembersDict:_homeMembersDict];
            [currentlyAssignedUserDict[@"UserID"] addObject:dataDict[@"UserID"]];
            [currentlyAssignedUserDict[@"Username"] addObject:dataDict[@"Username"]];
            [currentlyAssignedUserDict[@"ProfileImageURL"] addObject:dataDict[@"ProfileImageURL"]];
            
        }
        
    }
    
    [[[PushObject alloc] init] PushToViewAddItemsViewController:nil itemsAlreadyChosenDict:itemSubTasksDict userDict:currentlyAssignedUserDict optionSelectedString:@"Subtasks" itemRepeats:itemRepeatsTextField.text viewingItemDetails:_viewingTask currentViewController:self];
    
}

-(IBAction)TapGestureItemReminders:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Reminders Field Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    NSString *chosenItemRepeatIfCompletedEarlyLocal = chosenItemRepeatIfCompletedEarly ? chosenItemRepeatIfCompletedEarly : @"";
    NSString *itemRepeats = [self GenerateItemRepeat];
    NSString *itemDays = [self GenerateItemDays:itemRepeats];
    NSString *itemTime = [self GenerateItemTime:itemDays itemRepeats:itemRepeats itemDueDate:itemDueDateTextField.text];
    NSString *itemCompleteAsNeeded = [self GenerateItemCompleteAsNeeded:itemRepeats];
    NSString *itemDateLastReset = [self GenerateItemDateLastReset];
    NSString *itemDueDate = [self GenerateItemDueDate:itemRepeats itemTime:itemTime itemDays:itemDays itemRepeatIfCompletedEarly:chosenItemRepeatIfCompletedEarlyLocal itemCompleteAsNeeded:itemCompleteAsNeeded itemDueDatesSkipped:itemDueDatesSkippedArray itemDateLastReset:itemDateLastReset];
    
    BOOL TaskIsRepeating = [[[BoolDataObject alloc] init] TaskIsRepeating:[@{@"ItemRepeats" : itemRepeats, @"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal} mutableCopy] itemType:itemType];
    BOOL TaskHasNoDueDate = [[[BoolDataObject alloc] init] TaskHasNoDueDate:[@{@"ItemDueDate" : itemDueDate, @"ItemSpecificDueDates" : itemSpecificDueDatesArray, @"ItemRepeats" : itemRepeats, @"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal} mutableCopy] itemType:itemType];
    BOOL TaskHasAnyTime = [itemTimeTextField.text isEqualToString:@"Any Time"];
    
    itemReminderDict = [[self GenerateItemReminder:itemDueDateTextField.text itemRepeats:itemRepeatsTextField.text itemTime:itemTimeTextField.text SettingData:YES] mutableCopy];
    itemReminderTextField.text = [NSString stringWithFormat:@"%lu", (unsigned long)[[itemReminderDict allKeys] count]];
    
    if (TaskIsRepeating == YES || TaskHasNoDueDate == NO) {
        
        if (TaskHasAnyTime == YES) {
            
            [[[PushObject alloc] init] PushToViewAddItemsViewController:[[itemReminderDict allKeys] mutableCopy] itemsAlreadyChosenDict:nil userDict:nil optionSelectedString:@"RemindersAnyTime" itemRepeats:itemRepeatsTextField.text viewingItemDetails:_viewingTask currentViewController:self];
            
        } else {
            
            [[[PushObject alloc] init] PushToViewRemindersViewController:itemReminderDict itemRepeats:[self GenerateItemRepeat] itemTime:[self GenerateItemTime:itemDays itemRepeats:itemRepeats itemDueDate:itemDueDate] itemAssignedTo:self->assignedToIDArray viewingItemDetails:_viewingTask currentViewController:self];
            
        }
        
    } else {
        
        [[[GeneralObject alloc] init] CreateAlert:@"Oops!" message:[NSString stringWithFormat:@"Your %@ needs a due date or be repeating to have a reminder.", [itemType lowercaseString]] currentViewController:self];
    }
    
}

-(IBAction)TapGestureItemColor:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Color Field Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    NSMutableArray *itemsSelectedArray = [NSMutableArray array];
    
    if (chosenItemColor.length == 0 || [chosenItemColor containsString:@"(null)"] || chosenItemColor == nil) {
        chosenItemColor = @"None";
    }
    
    [itemsSelectedArray addObject:chosenItemColor];
    
    [[[PushObject alloc] init] PushToViewOptionsViewController:itemsSelectedArray customOptionsArray:nil specificDatesArray:nil viewingItemDetails:_viewingTask optionSelectedString:@"Colors" itemRepeatsFrequency:nil homeMembersDict:nil currentViewController:self];
    
}

-(IBAction)TapGestureItemReward:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Reward Field Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    [[[PushObject alloc] init] PushToViewPaymentMethodViewController:itemRewardDict viewingReward:YES comingFromAddTaskViewController:YES viewingItemDetails:_viewingTask currentViewController:self];
    
}

-(IBAction)TapGestureItemTags:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Tags Field Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    [[[PushObject alloc] init] PushToViewTagsViewController:itemTagsArrays allItemTagsArrays:_allItemTagsArrays viewingItemDetails:_viewingTask comingFromAddTaskViewController:YES comingFromViewTaskViewController:NO currentViewController:self];
    
}

-(IBAction)TapGestureItemPastDue:(id)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Past Due Field Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    NSMutableArray *itemsSelectedArray = [NSMutableArray array];
    
    if (itemPastDueTextField.text.length > 0) {
        
        itemsSelectedArray = [[itemPastDueTextField.text componentsSeparatedByString:@""] mutableCopy];
        
    }
    
    [[[PushObject alloc] init] PushToViewOptionsViewController:itemsSelectedArray customOptionsArray:nil specificDatesArray:nil viewingItemDetails:_viewingTask optionSelectedString:@"PastDue" itemRepeatsFrequency:nil homeMembersDict:nil currentViewController:self];
    
}

#pragma mark - NSNotification Methods

-(void)NSNotification_AddTask_AddHomeMember:(NSNotification *)notification {
    
    NSDictionary *dict = [notification.userInfo mutableCopy];
    
    _homeMembersArray = dict[@"HomeMembersArray"] ? dict[@"HomeMembersArray"] : [NSMutableArray array];
    _homeMembersDict = dict[@"HomeMembersDict"] ? dict[@"HomeMembersDict"] : [NSMutableDictionary dictionary];
    _notificationSettingsDict = dict[@"NotificationSettingsDict"] ? dict[@"NotificationSettingsDict"] : [NSMutableDictionary dictionary];
    
    self->userDictForHomeMembers = [_homeMembersDict mutableCopy];
    
    [[NSUserDefaults standardUserDefaults] setObject:self->_homeMembersArray forKey:@"HomeMembersArray"];
    [[NSUserDefaults standardUserDefaults] setObject:self->_homeMembersDict forKey:@"HomeMembersDict"];
    [[NSUserDefaults standardUserDefaults] setObject:dict[@"HomeKeysDict"] ? dict[@"HomeKeysDict"] : [NSMutableDictionary dictionary] forKey:@"HomeKeysDict"];
    [[NSUserDefaults standardUserDefaults] setObject:dict[@"HomeKeysArray"] ? dict[@"HomeKeysArray"] : [NSMutableArray array] forKey:@"HomeKeysArray"];
    [[NSUserDefaults standardUserDefaults] setObject:self->_notificationSettingsDict forKey:@"NotificationSettingsDict"];
    
}

-(void)NSNotification_AddTask_ItemAssignedTo:(NSNotification *)notification {
    
    DataChanged = YES;
    
    itemAssignedToView.backgroundColor = itemNameView.backgroundColor;
    
    NSDictionary *userInfo = notification.userInfo;
    
    NSString *previousItemAssignedToTextFieldString = itemAssignedToTextField.text;
    NSMutableArray *assignedToUsernameLocalArray = userInfo[@"AssignedToUsername"];
    self->chosenItemAssignedToAnybody = userInfo[@"AssignedToAnybody"];
    self->chosenItemAssignedToNewHomeMembers = userInfo[@"AssignedToNewHomeMembers"];
    
    NSString *itemAssignedToTextFieldString = @"";
    
    if ([previousItemAssignedToTextFieldString isEqualToString:@"Anybody"] || [previousItemAssignedToTextFieldString isEqualToString:@"Nobody"]) {
        
        completedByOnlyComp = @"";
        completedByAmountComp = @"";
        itemMustCompleteTextField.text = @"Everyone";
        
    }
    
    if ([self->chosenItemAssignedToAnybody isEqualToString:@"Yes"]) {
        
        itemAssignedToTextFieldString = @"Anybody";
        assignedToUsernameLocalArray = [userDictForHomeMembers[@"Username"] mutableCopy];
        
        completedByOnlyComp = @"Only";
        completedByAmountComp = @"1";
        itemMustCompleteTextField.text = @"Only 1 Person";
        
    } else if ([assignedToUsernameLocalArray count] > 1) {
        
        for (NSString *assignedToUsernameString in assignedToUsernameLocalArray) {
            
            BOOL AssignedToStringIsEmpty = itemAssignedToTextFieldString.length == 0;
            
            itemAssignedToTextFieldString = AssignedToStringIsEmpty == YES ?
            [NSString stringWithFormat:@"%@", assignedToUsernameString] :
            [NSString stringWithFormat:@"%@, %@", itemAssignedToTextFieldString, assignedToUsernameString];
            
        }
        
    } else if ([assignedToUsernameLocalArray count] == 1) {
        
        for (NSString *assignedToUsernameString in assignedToUsernameLocalArray) {
            
            BOOL UsernameIsMine = [assignedToUsernameString isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"]];
            itemAssignedToTextFieldString = UsernameIsMine == YES ? @"Myself" : assignedToUsernameString;
            
        }
        
    } else if ([assignedToUsernameLocalArray count] == 0) {
        
        itemAssignedToTextFieldString = @"Nobody";
        
    }
    
    
    
    itemAssignedToTextField.text = itemAssignedToTextFieldString;
    
    
    
    NSMutableArray *updatedAssignedIDArray = [NSMutableArray array];
    NSMutableArray *updatedAssignedProfileImageURLArray = [NSMutableArray array];
    
    for (NSString *username in assignedToUsernameLocalArray) {
        
        if ([userDictForHomeMembers[@"Username"] containsObject:username]) {
            
            NSUInteger index = [userDictForHomeMembers[@"Username"] indexOfObject:username];
            NSString *userID = [(NSArray *)userDictForHomeMembers[@"UserID"] count] > index ? userDictForHomeMembers[@"UserID"][index] : @"";
            NSString *profileImageURL = [(NSArray *)userDictForHomeMembers[@"ProfileImageURL"] count] > index ? userDictForHomeMembers[@"ProfileImageURL"][index] : @"";
            [updatedAssignedIDArray addObject:userID];
            [updatedAssignedProfileImageURLArray addObject:profileImageURL];
            
        }
        
    }
    
    self->assignedToIDArray = [updatedAssignedIDArray mutableCopy];
    self->assignedToUsernameArray = [assignedToUsernameLocalArray mutableCopy];
    self->assignedToProfileImageArray = [updatedAssignedProfileImageURLArray mutableCopy];
    
    
    [self GenerateCompletedByFrequencyArray:self->assignedToIDArray];
    [self GenerateCostPerPersonTextFieldText:[NSMutableDictionary dictionary]];
    [self GenerateCompletedByTextFieldText];
    [self GenerateSpecificOrderTextFieldText:[assignedToUsernameArray mutableCopy]];
    
    
    if ([itemAssignedToTextField.text isEqualToString:@"Nobody"]) { [itemEveryoneTakesTurnsSwitch setOn:NO]; }
    [self AdjustTextFieldFramesToUse:0.25];
    [self GenerateItemAssignedTo:[self GenerateItemRandomizeTurnOrder]];
    [self BarButtonItems];
    
}

-(void)NSNotification_AddTask_ItemAmount:(NSNotification *)notification {
    
    DataChanged = YES;
    
    NSDictionary *userInfo = notification.userInfo;
    
    NSMutableDictionary *dict = userInfo[@"ItemsDict"];
    
    itemItemizedItemsDict = [dict mutableCopy];
    
    if (itemItemizedItemsDict == nil) {
        itemItemizedItemsDict = [NSMutableDictionary dictionary];
    }
    
    if ([[dict allKeys] count] > 0) {
        
        float totalAmount = 0.0;
        
        for (NSString *item in [dict allKeys]) {
            
            id amountString = dict[item][@"Amount"];
            
            BOOL ObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:amountString classArr:@[[NSArray class], [NSMutableArray class]]];
            
            if (ObjectIsKindOfClass == YES) {
                amountString = amountString[0];
            }
            
            amountString = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:amountString arrayOfSymbols:@[localCurrencyNumberSeparatorSymbol, localCurrencySymbol]];
            amountString = [[[GeneralObject alloc] init] GenerateLocalCurrencyStringWithReverseSeparatorsForeign:amountString];
            
            totalAmount += [amountString floatValue];
        }
        
        NSString *totalAmountString = [NSString stringWithFormat:@"%.2f", totalAmount];
        
        totalAmountString = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:totalAmountString arrayOfSymbols:@[localCurrencyNumberSeparatorSymbol, localCurrencyDecimalSeparatorSymbol, localCurrencySymbol]];
        
        itemAmountTextField.text = [[[GeneralObject alloc] init] GenerateAmountInTextFieldInProperFormat:NSRangeFromString(totalAmountString) replacementString:totalAmountString];
        
        [self GenerateCostPerPersonTextFieldText:[NSMutableDictionary dictionary]];
        
    } else {
        
        itemAmountTextField.text = [[[GeneralObject alloc] init] GenerateAmountInTextFieldInProperFormat:NSRangeFromString(@"") replacementString:@""];
        
    }
    
    itemAmountView.backgroundColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTertiary] : [[[LightDarkModeObject alloc] init] LightModeSecondary];
    
    [self BarButtonItems];
    
}

-(void)NSNotification_AddTask_ItemCostPerPerson:(NSNotification *)notification {
    
    DataChanged = YES;
    
    NSDictionary *userInfo = notification.userInfo;
    
    if ([[itemItemizedItemsDict allKeys] count] > 0) {
        
        itemItemizedItemsDict = [userInfo[@"CostDict"] mutableCopy];
        
    }
    
    if ([[itemItemizedItemsDict allKeys] count] > 0 == NO) {
        
        float totalAmount = 0.0;
        
        NSMutableDictionary *dict = [userInfo[@"CostDict"] mutableCopy];
        
        for (NSString *key in [dict allKeys]) {
            
            NSString *amountString = [dict[key] mutableCopy];
            amountString = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:amountString arrayOfSymbols:@[localCurrencyNumberSeparatorSymbol, localCurrencySymbol]];
            
            totalAmount += [amountString floatValue];
            
        }
        
        NSString *totalAmountString = [NSString stringWithFormat:@"%@%.2f", localCurrencySymbol, totalAmount];
        
        totalAmountString = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:totalAmountString arrayOfSymbols:@[localCurrencyNumberSeparatorSymbol, localCurrencyDecimalSeparatorSymbol, localCurrencySymbol]];
        
        self->itemAmountTextField.text = [[[GeneralObject alloc] init] GenerateAmountInTextFieldInProperFormat:NSRangeFromString(totalAmountString) replacementString:totalAmountString];
        
    }
    
    [self GenerateCostPerPersonTextFieldText:[userInfo[@"CostDict"] mutableCopy]];
    
    [self BarButtonItems];
    
}

-(void)NSNotification_AddTask_ItemPaymentMethod:(NSNotification *)notification {
    
    DataChanged = YES;
    
    NSDictionary *userInfo = notification.userInfo;
    
    itemPaymentMethodDict = [userInfo[@"PaymentMethod"] mutableCopy];
    
    if (itemPaymentMethodDict[@"PaymentMethod"] && [itemPaymentMethodDict[@"PaymentMethod"] length] > 0) {
        itemPaymentMethodTextField.text = itemPaymentMethodDict[@"PaymentMethod"];
    } else {
        itemPaymentMethodTextField.text = @"None";
    }
    
    [self BarButtonItems];
    
}

-(void)NSNotification_AddTask_ItemReward:(NSNotification *)notification {
    
    DataChanged = YES;
    
    NSDictionary *userInfo = notification.userInfo;
    
    itemRewardDict = [userInfo[@"Reward"] mutableCopy];
    
    if (itemRewardDict[@"Reward"] && [itemRewardDict[@"Reward"] length] > 0) {
        itemRewardTextField.text = itemRewardDict[@"Reward"];
    } else {
        itemRewardTextField.text = @"None";
    }
    
    [self BarButtonItems];
    
}

-(void)NSNotification_AddTask_ItemTags:(NSNotification *)notification {
    
    DataChanged = YES;
    
    NSDictionary *userInfo = notification.userInfo;
    
    itemTagsArrays = [userInfo[@"Tags"] mutableCopy];
    
    NSString *tagStr = itemTagsArrays.count == 1 ? @"Tag" : @"Tags";
    itemTagsTextField.text = [NSString stringWithFormat:@"%ld %@", itemTagsArrays.count, tagStr];
    
    [self BarButtonItems];
    
}

-(void)NSNotification_AddTask_ItemListItems:(NSNotification *)notification {
    
    DataChanged = YES;
    
    NSDictionary *userInfo = notification.userInfo;
    
    NSMutableDictionary *dict = userInfo[@"ItemsDict"];
    
    BOOL ItemListItemsDictHasKeys = ([[dict allKeys] count] > 0);
    
    itemListItemsDict = ItemListItemsDictHasKeys == YES ? dict : [NSMutableDictionary dictionary];
    
    itemListItemsTextField.text = [NSString stringWithFormat:@"%lu", (unsigned long)[[dict allKeys] count]];
    
    
    
    
    for (NSString *key in [itemListItemsDict allKeys]) {
        
        NSMutableArray *assignedTo = itemListItemsDict[key] && itemListItemsDict[key][@"Assigned To"] ? itemListItemsDict[key][@"Assigned To"] : [NSMutableArray array];
        
        NSString *userID = [assignedTo count] > 0 ? assignedTo[0] : @"";
        
        if ([userID isEqualToString:@"Anybody"] == NO && [userID isEqualToString:@""] == NO && [assignedToIDArray containsObject:userID] == NO) {
            
            NSDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:userID homeMembersDict:_homeMembersDict];
            NSString *username = dataDict[@"Username"] ? dataDict[@"Username"] : @"";
            
            if ([assignedToUsernameArray containsObject:username] == NO && [username length] > 0) {
                [assignedToUsernameArray addObject:username];
            }
            
            dataDict = @{
                @"AssignedToUsername" : assignedToUsernameArray,
                @"AssignedToNewHomeMembers" : self->chosenItemAssignedToNewHomeMembers ? self->chosenItemAssignedToNewHomeMembers : @"No",
                @"AssignedToAnybody" : @"No"};
            [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemAssignedTo" userInfo:dataDict locations:@[@"Tasks", @"AddTask"]];
            
        }
        
    }
    
    
    
    
    [self BarButtonItems];
    
}

-(void)NSNotification_AddTask_ItemSpecificDueDates:(NSNotification *)notification {
    
    DataChanged = YES;
    
    NSDictionary *userInfo = notification.userInfo;
    
    NSArray *arr = userInfo[@"Items"];
    NSString *sString = arr.count == 1 ? @"" : @"s";
    
    if ([(NSArray *)userInfo[@"Items"] count] > 0) {
        
        itemSpecificDueDatesArray = userInfo[@"Items"] ? [userInfo[@"Items"] mutableCopy] : [NSMutableArray array];
        itemDueDateTextField.text = [NSString stringWithFormat:@"%lu Date%@", arr.count, sString];
        
    } else {
        
        itemSpecificDueDatesArray = [NSMutableArray array];
        itemDueDateTextField.text = @"No Due Date";
        
    }
    
    [self BarButtonItems];
    [self SetUpDueDateContextMenu:NO];
    [self AdjustTextFieldFramesToUse:0.25];
    
}

-(void)NSNotification_AddTask_ItemDueDate:(NSNotification *)notification {
    
    DataChanged = YES;
    
    NSDictionary *userInfo = notification.userInfo;
    
    itemDueDateTextField.text = userInfo[@"Items"] ? userInfo[@"Items"] : itemDueDateTextField.text;
    
    itemSpecificDueDatesArray = [NSMutableArray array];
    
    [self BarButtonItems];
    [self SetUpDueDateContextMenu:NO];
    [self AdjustTextFieldFramesToUse:0.25];
    
}

-(void)NSNotification_AddTask_ItemRepeats:(NSNotification *)notification {
    
    DataChanged = YES;
    
    NSDictionary *userInfo = notification.userInfo;
    
    if ([chosenItemRepeatIfCompletedEarly length] == 0 || chosenItemRepeatIfCompletedEarly == NULL) {
        chosenItemRepeatIfCompletedEarly = @"No";
    }
    
    
    
    
    NSString *previousItemRepeats = itemRepeatsTextField.text;
    
    chosenItemRepeats = userInfo[@"Repeats"] ? userInfo[@"Repeats"] : @"";
    chosenItemRepeatIfCompletedEarly = userInfo[@"RepeatIfCompletedEarly"] ? userInfo[@"RepeatIfCompletedEarly"] : chosenItemRepeatIfCompletedEarly;
    
    self->itemRepeatsTextField.text = chosenItemRepeats;
    
    
    
    
    if ([self->itemRepeatsTextField.text isEqualToString:@"Never"] == YES) {
        [self->itemEveryoneTakesTurnsSwitch setOn:NO];
    }
    
    
    
    
    if ([previousItemRepeats containsString:@"Week"] == YES && [chosenItemRepeats containsString:@"Month"] == YES && ([itemDaysTextField.text containsString:@"Monday"] || [itemDaysTextField.text containsString:@"Tuesday"] || [itemDaysTextField.text containsString:@"Wednesday"] || [itemDaysTextField.text containsString:@"Thursday"] || [itemDaysTextField.text containsString:@"Friday"] || [itemDaysTextField.text containsString:@"Saturday"] || [itemDaysTextField.text containsString:@"Sunday"])) {
        itemDaysTextField.text = @"";
    } else if ([previousItemRepeats containsString:@"Month"] == YES && [chosenItemRepeats containsString:@"Week"] == YES) {
        
        for (int i=1 ; i<29 ; i++) {
            
            NSString *ending = @"th";
            
            if (i == 1 || i == 21) {
                ending = @"st";
            } else if (i == 2 || i == 22) {
                ending = @"nd";
            } else if (i == 3 || i == 23) {
                ending = @"rd";
            }
            
            if ([itemDaysTextField.text containsString:[NSString stringWithFormat:@"%d%@", i, ending]]) {
                
                itemDaysTextField.text = @"";
                
            }
            
        }
        
    } else if ([previousItemRepeats isEqualToString:@"Semi-Monthly"] == NO && [chosenItemRepeats isEqualToString:@"Semi-Monthly"] == YES) {
        itemDaysTextField.text = @"15th, Last Day";
    } else if ([previousItemRepeats isEqualToString:@"Semi-Monthly"] == YES && [itemDaysTextField.text isEqualToString:@"15th, Last Day"] == YES) {
        itemDaysTextField.text = @"";
    }
    
    
    
    
    if ([chosenItemRepeats containsString:@"Month"] && ([itemAlternateTurnsTextField.text containsString:@"Week"] || [itemAlternateTurnsTextField.text containsString:@"Day"])) {
        self->itemAlternateTurnsTextField.text = @"Every Month";
        [UIView animateWithDuration:0.15 animations:^{
            [self->itemAlternateTurnsView setBackgroundColor:[UIColor colorWithRed:232.0f/255.0f green:152.0f/255.0f blue:152.0f/255.0f alpha:1.0f]];
        } completion:^(BOOL finished) {
            [self->itemAlternateTurnsView setBackgroundColor:[UIColor whiteColor]];
        }];
    } else if ([chosenItemRepeats containsString:@"Week"] && [itemAlternateTurnsTextField.text containsString:@"Day"]) {
        self->itemAlternateTurnsTextField.text = @"Every Week";
        [UIView animateWithDuration:0.15 animations:^{
            [self->itemAlternateTurnsView setBackgroundColor:[UIColor colorWithRed:232.0f/255.0f green:152.0f/255.0f blue:152.0f/255.0f alpha:1.0f]];
        } completion:^(BOOL finished) {
            [self->itemAlternateTurnsView setBackgroundColor:[UIColor whiteColor]];
        }];
    }
    
    
    
    
    if ([chosenItemRepeats isEqualToString:@"Never"] || [chosenItemRepeats isEqualToString:@"As Needed"] || [chosenItemRepeats isEqualToString:@"When Completed"]) {
        [self RepeatIfCompletedEarlySwitchAction:@"No"];
    }
    
    
    
    
    [self AdjustTextFieldFramesToUse:0.25];
    /*[self SetRepeatSwitchOnData:TaskIsRepeating];*/
    
    [self SetUpRepeatsContextMenu:NO];
    [self SetUpAlternateTurnsContextMenu];
    
}

-(void)NSNotification_AddTask_ItemAlternateTurns:(NSNotification *)notification {
    
    DataChanged = YES;
    
    NSDictionary *userInfo = notification.userInfo;
    
    NSString *pastDueString = userInfo[@"AlternateTurns"] && [userInfo[@"AlternateTurns"] length] > 0 ? userInfo[@"AlternateTurns"] : @"Every Week";
    
    itemAlternateTurnsTextField.text = pastDueString;
    
    [self SetUpAlternateTurnsContextMenu];
    [self BarButtonItems];
    
}

-(void)NSNotification_AddTask_ItemDays:(NSNotification *)notification {
    
    DataChanged = YES;
    
    NSDictionary *userInfo = notification.userInfo;
    
    NSMutableArray *daysArray = userInfo[@"Days"] ? userInfo[@"Days"] : @"";
    NSString *anyDay = userInfo[@"AnyDay"] ? userInfo[@"AnyDay"] : @"";
    
    NSString *daysArrayString = @"";
    
    if ([daysArray count] > 1) {
        
        for (NSString *day in daysArray) {
            
            if (daysArrayString.length == 0) {
                
                daysArrayString = [NSString stringWithFormat:@"%@", day];
                
            } else {
                
                daysArrayString = [NSString stringWithFormat:@"%@, %@", daysArrayString, day];
                
            }
            
        }
        
    } else {
        
        for (NSString *day in daysArray) {
            
            daysArrayString = [NSString stringWithFormat:@"%@", day];
            
        }
        
    }
    
    if ([anyDay isEqualToString:@"Yes"]) {
        
        daysArrayString = @"Any Day";
        
    }
    
    itemDaysTextField.text = daysArrayString;
    
    if ([itemDaysTextField.text containsString:@"Any Day"]) {
        [self TimeTextField_AnyTime];
    }
    
    if ([itemRepeatsTextField.text isEqualToString:@"Semi-Monthly"] && [itemDaysTextField.text isEqualToString:@"15th, Last Day"] == NO) {
        
        itemRepeatsTextField.text = @"Monthly";
        [self SetUpRepeatsContextMenu:NO];
        
    }
    
    [self AdjustTextFieldFramesToUse:0.25];
    [self BarButtonItems];
    
}

-(void)NSNotification_AddTask_ItemSpecificOrder:(NSNotification *)notification {
    
    DataChanged = YES;
    
    itemTurnOrderTextField.text = @"";
    
    NSDictionary *userInfo = notification.userInfo;
    
    
    
    
    NSMutableArray *specificOrderUsernameArray = userInfo[@"SpecificOrder"] ? userInfo[@"SpecificOrder"] : [NSMutableArray array];
    NSString *randomize = userInfo[@"Randomize"] ? userInfo[@"Randomize"] : @"No";
    
    BOOL SpecificOrderArrayHasAtLeastOneUser = [specificOrderUsernameArray count] > 0 && specificOrderUsernameArray != nil && specificOrderUsernameArray != NULL;
    
    if (SpecificOrderArrayHasAtLeastOneUser == YES) {
        
        NSString *specificOrderUsernameTextFieldString;
        
        for (int i=0;i<specificOrderUsernameArray.count;i++) {
            
            NSString *username = specificOrderUsernameArray[i];
            
            if (i == 0) {
                
                specificOrderUsernameTextFieldString = username;
                
            } else if (i != 0) {
                
                
                specificOrderUsernameTextFieldString = [NSString stringWithFormat:@"%@, %@", specificOrderUsernameTextFieldString, username];
                
            }
            
        }
        
        if (specificOrderUsernameTextFieldString.length == 0) {
            
            specificOrderUsernameTextFieldString = itemAssignedToTextField.text;
            
        }
        
        if ([randomize isEqualToString:@"Yes"]) {
            
            specificOrderUsernameTextFieldString = @"Randomize";
            
        }
        
        itemTurnOrderTextField.text = specificOrderUsernameTextFieldString;
        
        
        
        
        //Update Assigned To Array
        
        NSMutableArray *updatedAssignedIDArray = [NSMutableArray array];
        NSMutableArray *updatedAssignedProfileImageURLArray = [NSMutableArray array];
        
        for (NSString *username in specificOrderUsernameArray) {
            
            if ([userDictForHomeMembers[@"Username"] containsObject:username]) {
                
                NSUInteger index = [userDictForHomeMembers[@"Username"] indexOfObject:username];
                NSString *userID = [(NSArray *)userDictForHomeMembers[@"UserID"] count] > index ? userDictForHomeMembers[@"UserID"][index] : @"";
                NSString *profileImageURL = [(NSArray *)userDictForHomeMembers[@"ProfileImageURL"] count] > index ? userDictForHomeMembers[@"ProfileImageURL"][index] : @"";
                [updatedAssignedIDArray addObject:userID];
                [updatedAssignedProfileImageURLArray addObject:profileImageURL];
                
            }
            
        }
        
        self->assignedToIDArray = [updatedAssignedIDArray mutableCopy];
        self->assignedToUsernameArray = [specificOrderUsernameArray mutableCopy];
        self->assignedToProfileImageArray = [updatedAssignedProfileImageURLArray mutableCopy];
        
        
        
        
    }
    
    [self BarButtonItems];
    
}

//More Options
-(void)NSNotification_AddTask_ItemBringBackMoreOptions:(NSNotification *)notification {
    
    DataChanged = YES;
    
    _moreOptionsDict = notification.userInfo ? [notification.userInfo mutableCopy] : [NSMutableDictionary dictionary];
    
    topViewLabel.text = self->_moreOptionsDict[@"TaskList"] ? self->_moreOptionsDict[@"TaskList"] : @"No List";
    
    self->assignedToIDArray = self->_moreOptionsDict[@"ItemAssignedTo"] ? [self->_moreOptionsDict[@"ItemAssignedTo"] mutableCopy] : [NSMutableArray array];
    self->chosenItemRepeats = self->_moreOptionsDict[@"ItemRepeats"] ? self->_moreOptionsDict[@"ItemRepeats"] : @"";
    
    self->itemSubTasksDict = self->_moreOptionsDict[@"ItemSubTasks"] ? [self->_moreOptionsDict[@"ItemSubTasks"] mutableCopy] : [NSMutableDictionary dictionary];
    
    self->chosenItemGracePeriod = self->_moreOptionsDict[@"ItemGracePeriod"] ? self->_moreOptionsDict[@"ItemGracePeriod"] : @"";
    self->chosenItemPastDue = self->_moreOptionsDict[@"ItemPastDue"] ? self->_moreOptionsDict[@"ItemPastDue"] : @"";
    
    self->chosenItemColor = self->_moreOptionsDict[@"ItemColor"] ? self->_moreOptionsDict[@"ItemColor"] : @"";
    self->itemTagsArrays = self->_moreOptionsDict[@"ItemTags"] ? [self->_moreOptionsDict[@"ItemTags"] mutableCopy] : [NSMutableArray array];
    self->chosenItemPriority = self->_moreOptionsDict[@"ItemPriority"] ? self->_moreOptionsDict[@"ItemPriority"] : @"";
    self->chosenItemDifficulty = self->_moreOptionsDict[@"ItemDifficulty"] ? self->_moreOptionsDict[@"ItemDifficulty"] : @"";
    
    self->itemRewardDict = self->_moreOptionsDict[@"ItemReward"] ? [self->_moreOptionsDict[@"ItemReward"] mutableCopy] : [NSMutableDictionary dictionary];
    self->chosenItemPrivate = self->_moreOptionsDict[@"ItemPrivate"] ? self->_moreOptionsDict[@"ItemPrivate"] : @"";
    self->chosenItemApprovalNeeded = self->_moreOptionsDict[@"ItemApprovalNeeded"] ? self->_moreOptionsDict[@"ItemApprovalNeeded"] : @"";
    
    [self MoreOptionsData:self->_moreOptionsDict];
    
    [self BarButtonItems];
    
}

-(void)NSNotification_AddTask_ItemSubTasks:(NSNotification *)notification {
    
    DataChanged = YES;
    
    NSDictionary *userInfo = notification.userInfo;
    
    NSMutableDictionary *dict = userInfo[@"ItemsDict"];
    
    if (itemSubTasksDict == nil) {
        itemSubTasksDict = [NSMutableDictionary dictionary];
    }
    
    BOOL ItemSubTasksDictHasKeys = ([[dict allKeys] count] > 0);
    
    itemSubTasksDict = ItemSubTasksDictHasKeys == YES ? [dict mutableCopy] : [NSMutableDictionary dictionary];
    itemSubTasksTextField.text = [NSString stringWithFormat:@"%lu", (unsigned long)[[dict allKeys] count]];
    
    [self BarButtonItems];
    
}

-(void)NSNotification_AddTask_ItemReminders:(NSNotification *)notification {
    
    DataChanged = YES;
    
    NSDictionary *userInfo = notification.userInfo;
    
    NSMutableDictionary *dict = userInfo[@"ItemsDict"];
    
    itemReminderDict = [dict mutableCopy];
    
    itemReminderTextField.text = [NSString stringWithFormat:@"%lu", (unsigned long)[[itemReminderDict allKeys] count]];
    
    [self BarButtonItems];
    
}

-(void)NSNotification_AddTask_ItemDifficulty:(NSNotification *)notification {
    
    DataChanged = YES;
    
    NSDictionary *userInfo = notification.userInfo;
    
    NSString *difficulty = userInfo[@"Difficulty"];
    
    BOOL DifficultyStringIsValid = (difficulty.length > 0 && difficulty != nil && [difficulty containsString:@"(null)"] == NO);
    
    itemDifficultyTextField.text = DifficultyStringIsValid == YES ? difficulty : @"";
    
    chosenItemDifficulty = itemDifficultyTextField.text;
    
    [self BarButtonItems];
    
}

-(void)NSNotification_AddTask_ItemPriority:(NSNotification *)notification {
    
    DataChanged = YES;
    
    NSDictionary *userInfo = notification.userInfo;
    
    NSString *priority = userInfo[@"Priority"];
    
    BOOL PriorityStringIsValid = (priority.length > 0 && priority != nil && [priority containsString:@"(null)"] == NO);
    
    itemPriorityTextField.text = PriorityStringIsValid == YES ? priority : @"";
    
    chosenItemPriority = itemPriorityTextField.text;
    
    [self BarButtonItems];
    
}

-(void)NSNotification_AddTask_ItemColor:(NSNotification *)notification {
    
    DataChanged = YES;
    
    NSDictionary *userInfo = notification.userInfo;
    
    NSString *colorString = userInfo[@"Color"];
    UIColor *colorColor = [[[GeneralObject alloc] init] GenerateColorOptionFromColorString:colorString];
    
    BOOL ColorStringIsValid = (colorString.length > 0 && colorString != nil && [colorString containsString:@"(null)"] == NO);
    
    itemColorSelectedView.backgroundColor = colorColor;
    
    chosenItemColor = ColorStringIsValid == YES ? colorString : @"None";
    
    [self BarButtonItems];
    
}

-(void)NSNotification_AddTask_ItemPastDue:(NSNotification *)notification {
    
    DataChanged = YES;
    
    NSDictionary *userInfo = notification.userInfo;
    
    NSString *pastDueString = userInfo[@"PastDue"] && [userInfo[@"PastDue"] length] > 0 ? userInfo[@"PastDue"] : @"2 Days";
    
    itemPastDueTextField.text = pastDueString;
    
    chosenItemPastDue = itemPastDueTextField.text;
    
    [self SetUpPastDueContextMenu];
    [self BarButtonItems];
    
}

-(void)NSNotification_AddTask_ItemScheduledStart:(NSNotification *)notification {
    
    DataChanged = YES;
    
    NSDictionary *userInfo = notification.userInfo;
    
    NSString *scheduledStartString = userInfo[@"ScheduledStart"] && [userInfo[@"ScheduledStart"] length] > 0 ? userInfo[@"ScheduledStart"] : @"Now";
    
    selectedScheduledStart = scheduledStartString;
    
    [self BarButtonItems];
    
}

-(void)NSNotification_AddTask_AddOrEditTaskList:(NSNotification *)notification {
    
    DataChanged = YES;
    
    NSDictionary *userInfo = notification.userInfo;
    
    NSString *taskListID = userInfo[@"TaskListID"] ? userInfo[@"TaskListID"] : @"";
    NSString *taskListName = userInfo[@"TaskListName"] ? userInfo[@"TaskListName"] : @"No List";
    
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
    
    [self UpdateTopViewLabel:taskListName];
    [self BarButtonItems];
    
    if (self->_viewingMoreOptions) {
        
        NSDictionary *dataDict = @{
            @"TaskList" : self->topViewLabel.text ? self->topViewLabel.text : @"No List",
        };
        
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemBringBackMoreOptions" userInfo:dataDict locations:@[@"AddTask"]];
        
    }
    
}

-(void)NSNotification_AddTask_AddOrEditItemTemplate:(NSNotification *)notification {
    
    [self NSNotificationObservers:NO];
    
    DataChanged = YES;
    
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
    
    [self BarButtonItems];
    
}

-(void)NSNotification_AddTask_AddOrEditItemDraft:(NSNotification *)notification {
    
    [self NSNotificationObservers:NO];
    
    DataChanged = YES;
    
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
    
    [self BarButtonItems];
    
}

-(void)NSNotification_AddTask_ItemWeDivvyPremiumAccounts:(NSNotification *)notification {
    
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

#pragma mark BarButtonItems

-(BOOL)CheckIfAllDefault {
    
    BOOL AllDefault = YES;
    
    BOOL BegainWithDictOfData = NO;
    NSMutableDictionary *dictToUse = [NSMutableDictionary dictionary];
    
    if (_addingMultipleTasks) {
        
        BegainWithDictOfData = _addingMultipleTasks;
        dictToUse = _itemToEditDict;
        
    } else if (_addingSuggestedTask) {
        
        BegainWithDictOfData = _addingSuggestedTask;
        dictToUse = _suggestedItemToAddDict;
        
    } else if (_partiallyAddedTask) {
        
        BegainWithDictOfData = _partiallyAddedTask;
        dictToUse = _partiallyAddedDict;
        
    } else if (_editingTask) {
        
        BegainWithDictOfData = _editingTask;
        dictToUse = _itemToEditDict;
        
    } else if (_editingTemplate) {
        
        BegainWithDictOfData = _editingTemplate;
        dictToUse = _templateToEditDict;
        
    } else if (_editingDraft) {
        
        BegainWithDictOfData = _editingDraft;
        dictToUse = _draftToEditDict;
        
    }
    
    id defaultNameObject = @"";
    id defaultAmountObject = [NSString stringWithFormat:@"%@0%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol];
    id defaultCostPerPersonObject = [NSMutableDictionary dictionary];
    id defaultPaymentMethodObject = [NSMutableDictionary dictionary];
    id defaultListItemsObject = [NSMutableDictionary dictionary];
    id defaultAssignedToObject = @"Myself";
    id defaultMustCompleteObject = @"Everyone";
    id defaultRepeatsObject = @"Never";
    id defaultDueDateObject = @"No Due Date";
    id defaultStartDateObject = @"";
    id defaultEndDateObject = @"Never";
    id defaultDaysObject = @"";
    id defaultTimeObject = @"Any Time";
    id defaultAlternateTurnsObject = @"Every Occurrence";
    id defaultNotesObject = @"Notes";
    id defaultSubtasksObject = [NSMutableDictionary dictionary];
    id defaultColorObject = @"None";
    id defaultRewardObject = [NSMutableDictionary dictionary];
    id defaultPriorityObject = @"No Priority";
    id defaultDifficultyObject = @"No Difficulty";
    id defaultTagsObject = [NSMutableArray array];
    id defaultPrivateObject = @"No";
    id defaultApprovalNeededObject = @"No";
    
    
    
    BOOL TimeTextFieldIsAnyTimeAndTimeDictIsMidnight = [itemTimeTextField.text isEqualToString:@"Any Time"] && [dictToUse[@"ItemTime"] isEqualToString:@"11:59 PM"];
    BOOL TimeTextFieldIsMidnightAndTimeDictIsAnyTime = [dictToUse[@"ItemTime"] isEqualToString:@"Any Time"] && [itemTimeTextField.text isEqualToString:@"11:59 PM"];
    
    if (((BegainWithDictOfData == NO && [itemNameTextField.text isEqualToString:defaultNameObject] == NO) ||
         (BegainWithDictOfData == YES && [itemNameTextField.text isEqualToString:dictToUse[@"ItemName"]] == NO)) && _viewingMoreOptions == NO) {
        
        AllDefault = NO;
        
    } else if (_viewingAddExpenseViewController == YES && ((BegainWithDictOfData == NO && [itemAmountTextField.text isEqualToString:defaultAmountObject] == NO) ||
                                                           (BegainWithDictOfData == YES && [itemAmountTextField.text isEqualToString:dictToUse[@"ItemAmount"]] == NO)) && _viewingMoreOptions == NO) {
        
        AllDefault = NO;
        
    } else if (_viewingAddExpenseViewController == YES && ((BegainWithDictOfData == NO && [itemCostPerPersonDict isEqualToDictionary:defaultCostPerPersonObject] == NO) ||
                                                           (BegainWithDictOfData == YES && dictToUse[@"ItemCostPerPerson"] != NULL && [itemCostPerPersonDict isEqualToDictionary:dictToUse[@"ItemCostPerPerson"]] == NO)) && _viewingMoreOptions == NO) {
        
        AllDefault = NO;
        
    } else if ((_viewingAddExpenseViewController == YES && ((BegainWithDictOfData == NO && [itemPaymentMethodDict isEqualToDictionary:defaultPaymentMethodObject] == NO) ||
                                                            (BegainWithDictOfData == YES && dictToUse[@"ItemPaymentMethod"] != NULL && [itemPaymentMethodDict isEqualToDictionary:dictToUse[@"ItemPaymentMethod"]] == NO))) && _viewingMoreOptions == NO) {
        
        AllDefault = NO;
        
    } else if ((_viewingAddListViewController == YES && ((BegainWithDictOfData == NO && [itemListItemsDict isEqualToDictionary:defaultListItemsObject] == NO) ||
                                                         (BegainWithDictOfData == YES && [itemListItemsDict isEqualToDictionary:dictToUse[@"ItemListItems"]] == NO))) && _viewingMoreOptions == NO) {
        
        AllDefault = NO;
        
    } else if (((BegainWithDictOfData == NO && [itemAssignedToTextField.text isEqualToString:defaultAssignedToObject] == NO) ||
                (BegainWithDictOfData == YES && [self->assignedToIDArray isEqualToArray:dictToUse[@"ItemAssignedTo"]] == NO)) && _viewingMoreOptions == NO) {
        
        AllDefault = NO;
        
    } else if (((BegainWithDictOfData == NO && [itemMustCompleteTextField.text isEqualToString:defaultMustCompleteObject] == NO) ||
                (BegainWithDictOfData == YES && dictToUse[@"ItemMustComplete"] != NULL && [itemMustCompleteTextField.text isEqualToString:dictToUse[@"ItemMustComplete"]] == NO)) && _viewingMoreOptions == NO) {
        
        AllDefault = NO;
        
    } else if (((BegainWithDictOfData == NO && [itemRepeatsTextField.text isEqualToString:defaultRepeatsObject] == NO) ||
                (BegainWithDictOfData == YES && [itemRepeatsTextField.text isEqualToString:dictToUse[@"ItemRepeats"]] == NO &&
                 [itemRepeatsTextField.text isEqualToString:@"When Completed"] && [dictToUse[@"ItemRepeatIfCompletedEarly"] isEqualToString:@"Yes"] == NO &&
                 [itemRepeatsTextField.text isEqualToString:@"Never"] && [dictToUse[@"ItemRepeatIfCompletedEarly"] isEqualToString:@"Yes"] == NO)) &&
               _viewingMoreOptions == NO) {
        
        AllDefault = NO;
        
    } else if (itemDueDateTextField.text != nil && ((BegainWithDictOfData == NO && [itemDueDateTextField.text isEqualToString:defaultDueDateObject] == NO) ||
                                                    (BegainWithDictOfData == YES && dictToUse[@"ItemRepeats"] != nil && [dictToUse[@"ItemRepeats"] isEqualToString:@"Never"] == YES && dictToUse[@"ItemDate"] != nil &&  [itemDueDateTextField.text containsString:dictToUse[@"ItemDate"]] == NO && [itemDueDateTextField.text containsString:@" Date"] == NO)) && _viewingMoreOptions == NO) {
        
        AllDefault = NO;
        
    } else if (((BegainWithDictOfData == NO && [itemStartDateTextField.text isEqualToString:@""] == NO && [itemStartDateTextField.text isEqualToString:defaultStartDateObject] == NO)) && _viewingMoreOptions == NO) {// || (BegainWithDictOfData == YES && [itemStartDateTextField.text isEqualToString:dictToUse[@"ItemStartDate"]] == NO)) {
        
        AllDefault = NO;
        
    } else if (((BegainWithDictOfData == NO && [itemEndDateTextField.text isEqualToString:@""] == NO && [itemEndDateTextField.text isEqualToString:defaultEndDateObject] == NO) ||
                (BegainWithDictOfData == YES && dictToUse[@"ItemEndDate"] != NULL && [itemEndDateTextField.text isEqualToString:dictToUse[@"ItemEndDate"]] == NO && [dictToUse[@"ItemRepeats"] isEqualToString:@"Never"] == NO)) && _viewingMoreOptions == NO) {
        
        AllDefault = NO;
        
    } else if (((BegainWithDictOfData == NO && [itemDaysTextField.text isEqualToString:defaultDaysObject] == NO) ||
                (BegainWithDictOfData == YES && dictToUse[@"ItemDays"] != NULL && [itemDaysTextField.text isEqualToString:dictToUse[@"ItemDays"]] == NO)) && _viewingMoreOptions == NO) {
        
        AllDefault = NO;
        
    } else if (((BegainWithDictOfData == NO && [itemTimeTextField.text isEqualToString:defaultTimeObject] == NO) ||
                (BegainWithDictOfData == YES &&
                 ([itemRepeatsTextField.text isEqualToString:@"Never"] == NO && TimeTextFieldIsAnyTimeAndTimeDictIsMidnight == NO && TimeTextFieldIsMidnightAndTimeDictIsAnyTime == NO) &&
                 [itemRepeatsTextField.text isEqualToString:@"Never"] == YES && [itemTimeTextField.text isEqualToString:@""] == NO && [dictToUse[@"ItemTime"] isEqualToString:@""] == NO)) && _viewingMoreOptions == NO) {
        
        AllDefault = NO;
        
    } else if (((BegainWithDictOfData == NO && [itemEveryoneTakesTurnsSwitch isOn] == YES) ||
                (BegainWithDictOfData == YES && [[itemEveryoneTakesTurnsSwitch isOn] ? @"Yes" : @"No" isEqualToString:dictToUse[@"ItemTakeTurns"]] == NO)) && _viewingMoreOptions == NO) {
        
        AllDefault = NO;
        
    } else if (((BegainWithDictOfData == NO && [itemAlternateTurnsTextField.text isEqualToString:defaultAlternateTurnsObject] == NO) ||
                (BegainWithDictOfData == YES && dictToUse[@"ItemAlternateTurns"] != NULL && [dictToUse[@"ItemAlternateTurns"] isEqualToString:@""] == NO && [itemAlternateTurnsTextField.text isEqualToString:dictToUse[@"ItemAlternateTurns"]] == NO)) && _viewingMoreOptions == NO) {
        
        AllDefault = NO;
        
    } else if (BegainWithDictOfData == NO && addImageImage.image == [UIImage systemImageNamed:@"camera.viewfinder"] == NO && _viewingMoreOptions == NO) {
        
        AllDefault = NO;
        
    } else if (((BegainWithDictOfData == NO && [itemNotesTextField.text isEqualToString:defaultNotesObject] == NO) ||
                (BegainWithDictOfData == YES && dictToUse[@"ItemNotes"] != NULL && [dictToUse[@"ItemNotes"] isEqualToString:@""] == NO && [itemNotesTextField.text isEqualToString:dictToUse[@"ItemNotes"]] == NO)) && _viewingMoreOptions == NO) {
        
        AllDefault = NO;
        
        /* More Options */
        
    } else if ((BegainWithDictOfData == NO && [itemSubTasksDict isEqualToDictionary:defaultSubtasksObject] == NO) ||
               (BegainWithDictOfData == YES && dictToUse[@"ItemSubTasks"] != NULL && [itemSubTasksDict isEqualToDictionary:dictToUse[@"ItemSubTasks"]] == NO)) {
        
        AllDefault = NO;
        
        //    } else if ((BegainWithDictOfData == NO && [itemReminderDict isEqualToDictionary:defaultRemindersObject] == NO) ||
        //               (BegainWithDictOfData == YES && dictToUse[@"ItemReminderDict"] != NULL && [itemReminderDict isEqualToDictionary:dictToUse[@"ItemReminderDict"]] == NO)) {
        
        //        AllDefault = NO;
        
    } else if ((BegainWithDictOfData == NO && chosenItemColor != NULL && [chosenItemColor isEqualToString:defaultColorObject] == NO) ||
               (BegainWithDictOfData == YES && chosenItemColor != NULL && dictToUse[@"ItemColor"] != NULL && [chosenItemColor isEqualToString:dictToUse[@"ItemColor"]] == NO)) {
        
        AllDefault = NO;
        
    } else if ((BegainWithDictOfData == NO && [itemTagsArrays isEqualToArray:defaultTagsObject] == NO) ||
               (BegainWithDictOfData == YES && dictToUse[@"ItemTags"] != NULL && [itemTagsArrays isEqualToArray:dictToUse[@"ItemTags"]] == NO)) {
        
        AllDefault = NO;
        
    } else if ((BegainWithDictOfData == NO && [itemPriorityTextField.text isEqualToString:defaultPriorityObject] == NO) ||
               (BegainWithDictOfData == YES && [itemPriorityTextField.text isEqualToString:dictToUse[@"ItemPriority"]] == NO)) {
        
        AllDefault = NO;
        
    } else if ((BegainWithDictOfData == NO && [itemDifficultyTextField.text isEqualToString:defaultDifficultyObject] == NO) ||
               (BegainWithDictOfData == YES && dictToUse[@"ItemDifficulty"] != NULL && [dictToUse[@"ItemDifficulty"] isEqualToString:@"None"] == NO && [itemDifficultyTextField.text isEqualToString:dictToUse[@"ItemDifficulty"]] == NO)) {
        
        AllDefault = NO;
        
    } else if ((BegainWithDictOfData == NO && [itemRewardDict isEqualToDictionary:defaultRewardObject] == NO) ||
               (BegainWithDictOfData == YES && dictToUse[@"ItemReward"] != NULL && [itemRewardDict isEqualToDictionary:dictToUse[@"ItemReward"]] == NO)) {
        
        AllDefault = NO;
        
    } else if ((BegainWithDictOfData == NO && chosenItemPrivate != NULL && [chosenItemPrivate isEqualToString:defaultPrivateObject] == NO) ||
               (BegainWithDictOfData == YES && chosenItemPrivate != NULL && dictToUse[@"ItemPrivate"] != NULL && [chosenItemPrivate isEqualToString:dictToUse[@"ItemPrivate"]] == NO)) {
        
        AllDefault = NO;
        
    } else if ((BegainWithDictOfData == NO && chosenItemApprovalNeeded != NULL && [chosenItemApprovalNeeded isEqualToString:defaultApprovalNeededObject] == NO) ||
               (BegainWithDictOfData == YES && chosenItemApprovalNeeded != NULL && dictToUse[@"ItemApprovalNeeded"] != NULL && [chosenItemApprovalNeeded isEqualToString:dictToUse[@"ItemApprovalNeeded"]] == NO)) {
        
        AllDefault = NO;
        
    }
    
    return AllDefault;
}

#pragma mark - SetUpDueDateContextMenu

-(NSString *)GenerateTodaysDate:(BOOL)display {
    
    // Get the current date
    NSDate *currentDate = [NSDate date];
    
    // Create a date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    // Set the desired date format
    [dateFormatter setDateFormat:display == NO ? @"EEE, MMM dd" : @"EEE, MMMM dd, yyyy"];
    
    // Format the current date
    NSString *todayDateString = [dateFormatter stringFromDate:currentDate];
    
    return todayDateString;
}

-(NSString *)GenerateTomorrowsDate:(BOOL)display {
    
    // Get the current date
    NSDate *currentDate = [NSDate date];
    
    // Create a calendar instance
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // Create components for adding 1 day
    NSDateComponents *oneDay = [[NSDateComponents alloc] init];
    oneDay.day = 1;
    
    // Add 1 day to the current date
    NSDate *tomorrowDate = [calendar dateByAddingComponents:oneDay toDate:currentDate options:0];
    
    // Create a date formatter to display tomorrow's date
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:display == NO ? @"EEE, MMM dd" : @"EEE, MMMM dd, yyyy"];
    
    // Format tomorrow's date
    NSString *tomorrowDateString = [dateFormatter stringFromDate:tomorrowDate];
    
    return tomorrowDateString;
}

-(NSString *)GenerateStartOfNextWeeksDate:(BOOL)display {
    
    // Get the current date
    NSDate *currentDate = [NSDate date];
    
    // Create a calendar instance
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // Get the beginning of next week by adding necessary components
    NSDateComponents *nextWeekComponents = [[NSDateComponents alloc] init];
    nextWeekComponents.weekday = 2; // Monday (adjust according to your desired start of the week)
    NSDate *beginningOfNextWeekDate = [calendar nextDateAfterDate:currentDate
                                               matchingComponents:nextWeekComponents
                                                          options:NSCalendarMatchNextTime];
    
    // Create a date formatter to display the beginning of next week date
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:display == NO ? @"EEE, MMM dd" : @"EEE, MMMM dd, yyyy"];
    
    // Format the beginning of next week date
    NSString *beginningOfNextWeekDateString = [dateFormatter stringFromDate:beginningOfNextWeekDate];
    
    return beginningOfNextWeekDateString;
}

-(NSString *)GenerateEndOfWeeksDate:(BOOL)display {
    
    // Get the current date
    NSDate *currentDate = [NSDate date];
    
    // Create a calendar instance
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // Get the end of the week using the maximum range of weekdays
    NSDate *endOfWeekDate = nil;
    [calendar rangeOfUnit:NSCalendarUnitWeekOfYear
                startDate:&currentDate
                 interval:NULL
                  forDate:currentDate];
    [calendar rangeOfUnit:NSCalendarUnitDay
                startDate:&endOfWeekDate
                 interval:NULL
                  forDate:[calendar dateByAddingUnit:NSCalendarUnitDay
                                               value:7
                                              toDate:currentDate
                                             options:0]];
    
    // Create a date formatter to display the end of the week date
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:display == NO ? @"EEE, MMM dd" : @"EEE, MMMM dd, yyyy"];
    
    // Format the end of the week date
    NSString *endOfWeekDateString = [dateFormatter stringFromDate:endOfWeekDate];
    
    return endOfWeekDateString;
}

-(NSString *)GenerateBeginningOfNextMonthDate:(BOOL)display {
    
    // Get the current date
    NSDate *currentDate = [NSDate date];
    
    // Create a calendar instance
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // Get the components for the next month
    NSDateComponents *nextMonthComponents = [[NSDateComponents alloc] init];
    nextMonthComponents.month = 1;
    
    // Get the beginning of the next month by adding the components
    NSDate *beginningOfNextMonthDate = [calendar dateByAddingComponents:nextMonthComponents
                                                                 toDate:currentDate
                                                                options:0];
    
    // Get the components for the beginning of the next month
    NSDateComponents *beginningOfNextMonthComponents = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth)
                                                                   fromDate:beginningOfNextMonthDate];
    
    // Set the day component to 1 to get the beginning of the month
    beginningOfNextMonthComponents.day = 1;
    
    // Get the final date for the beginning of the next month
    NSDate *beginningOfNextMonthFinalDate = [calendar dateFromComponents:beginningOfNextMonthComponents];
    
    // Create a date formatter to display the beginning of the next month date
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:display == NO ? @"EEE, MMM dd" : @"EEE, MMMM dd, yyyy"];
    
    // Format the beginning of the next month date
    NSString *beginningOfNextMonthDateString = [dateFormatter stringFromDate:beginningOfNextMonthFinalDate];
    
    return beginningOfNextMonthDateString;
}

-(NSString *)GenerateEndOfMonthDate:(BOOL)display {
    
    // Get the current date
    NSDate *currentDate = [NSDate date];
    
    // Create a calendar instance
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // Extract the month and year components from the current date
    NSDateComponents *components = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:currentDate];
    NSInteger currentDay = [components day];
    NSInteger currentMonth = [components month];
    NSInteger currentYear = [components year];
    
    // Get the range of days for the current month
    NSDateComponents *monthRangeComponents = [[NSDateComponents alloc] init];
    monthRangeComponents.month = currentMonth;
    monthRangeComponents.year = currentYear;
    NSRange daysRange = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[calendar dateFromComponents:monthRangeComponents]];
    
    // Create the end of the month date components
    NSDateComponents *endOfMonthComponents = [[NSDateComponents alloc] init];
    endOfMonthComponents.day = daysRange.length - currentDay;
    
    // Get the end of the month date by adding the components
    NSDate *endOfMonthDate = [calendar dateByAddingComponents:endOfMonthComponents toDate:currentDate options:0];
    
    // Create a date formatter to display the end of the month date
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:display == NO ? @"EEE, MMM dd" : @"EEE, MMMM dd, yyyy"];
    
    // Format the end of the month date
    NSString *endOfMonthDateString = [dateFormatter stringFromDate:endOfMonthDate];
    
    return endOfMonthDateString;
}

-(NSString *)GenerateWeekdayForDate:(NSString *)itemDueDate {
    
    NSDate *itemDueDateInDateForm = [[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:@"MMMM dd, yyyy" dateToConvert:itemDueDate returnAs:[NSDate class]];
    
    // Create an instance of NSCalendar
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // Extract the component numbers from the NSDate object
    NSInteger year = [calendar component:NSCalendarUnitYear fromDate:itemDueDateInDateForm];
    NSInteger month = [calendar component:NSCalendarUnitMonth fromDate:itemDueDateInDateForm];
    NSInteger day = [calendar component:NSCalendarUnitDay fromDate:itemDueDateInDateForm];
    
    // Specify the date components for July 16, 2023
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:year];
    [dateComponents setMonth:month];
    [dateComponents setDay:day];
    
    // Create an NSDate object from the specified date components
    NSDate *date = [calendar dateFromComponents:dateComponents];
    
    // Create a DateFormatter to get the shortened weekday representation
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE"]; // Set the format to get the shortened weekday
    
    // Get the weekday string using the date formatter
    NSString *weekdayString = [dateFormatter stringFromDate:date];
    
    // Print the weekday
    NSLog(@"Weekday: %@", weekdayString);
    
    return weekdayString;
}

#pragma mark - Back Item Context Menu Actions

-(UIAction *)BackItemContextMenuSaveDraftAction {
    
    UIAction *saveDraftAction = [UIAction actionWithTitle:@"Save Draft" image:[UIImage systemImageNamed:@"plus"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Save Draft Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
            
        }];
        
        self->DataChanged = NO;
        
        [self SaveDraft:@"NavigationBackButtonAction"];
        
    }];
    
    return saveDraftAction;
}

-(UIAction *)BackItemContextMenuDiscardAction {
    
    UIAction *discardAction = [UIAction actionWithTitle:@"Discard" image:[UIImage systemImageNamed:@"trash"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Discard Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
            
        }];
        
        self->DataChanged = NO;
        
        [self DismissViewController:self];
        
    }];
    
    [discardAction setAttributes:UIMenuElementAttributesDestructive];
    
    return discardAction;
}

#pragma mark - Back Item Context Menus

-(UIMenu *)BackItemContextMenuDiscardActionsMenu:(NSMutableArray *)discardMenuActions {
    
    UIMenu *discardMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"" options:UIMenuOptionsDisplayInline children:discardMenuActions];
    
    return discardMenu;
}

#pragma mark - Drafts Context Menu Actions

-(UIAction *)DraftItemContextMenuSelectUnselectAction:(NSString *)draftName {
    
    UIAction *selectOrUnselectAction = [UIAction actionWithTitle:@"Select Draft" image:[UIImage systemImageNamed:@"computermouse"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Select Draft Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
            
        }];
        
        self->selectedDraft = draftName;
        [self SelectDraft:self draftName:draftName];
        [self BarButtonItems];
        
    }];
    
    return selectOrUnselectAction;
}

-(UIAction *)DraftItemContextMenuEditDraftNameAction:(NSString *)oldDraftName {
    
    UIAction *editDraftName = [UIAction actionWithTitle:@"Edit Name" image:[UIImage systemImageNamed:@"pencil"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Edit Draft Name Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
            
        }];
        
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Enter your new draft name" message:nil
                                                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Save"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * _Nonnull action) {
            
            //            [self StartProgressView];
            
            NSString *draftName = controller.textFields[0].text;
            
            NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
            NSString *trimmedStringString = [draftName stringByTrimmingCharactersInSet:charSet];
            
            if ([trimmedStringString isEqualToString:@""]) {
                
                [self->progressView setHidden:YES];
                [self BarButtonItems];
                [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"Draft Name field is empty" currentViewController:self];
                
            } else {
                
                NSUInteger index = self->_draftDict[@"DraftName"] && [self->_draftDict[@"DraftName"] containsObject:oldDraftName] ? [self->_draftDict[@"DraftName"] indexOfObject:oldDraftName] : 0;
                NSString *draftID = self->_draftDict[@"DraftID"] && [(NSArray *)self->_draftDict[@"DraftID"] count] > index ? self->_draftDict[@"DraftID"][index] : @"";
                NSString *draftCreatedBy = self->_draftDict[@"DraftCreatedBy"] && [(NSArray *)self->_draftDict[@"DraftCreatedBy"] count] > index ? self->_draftDict[@"DraftCreatedBy"][index] : @"";
                
                NSArray *keyArray = [[[GeneralObject alloc] init] GenerateDraftKeyArray];
                
                NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
                
                for (NSString *key in keyArray) {
                    id object = self->_draftDict[key] && [(NSArray *)self->_draftDict[key] count] > index ? self->_draftDict[key][index] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                    [dataDict setObject:object forKey:key];
                }
                
                [dataDict setObject:draftName forKey:@"DraftName"];
                
                NSMutableArray *arr = self->_draftDict[@"DraftName"] ? [self->_draftDict[@"DraftName"] mutableCopy] : [NSMutableArray array];
                [arr replaceObjectAtIndex:index withObject:draftName];
                [self->_draftDict setObject:arr forKey:@"DraftName"];
                
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"draftID == %@", draftID];
                [[[SetDataObject alloc] init] SetDataEditCoreData:@"Drafts" predicate:predicate setDataObject:@{@"DraftName" : draftName}];
                
                [[[GeneralObject alloc] init] CallNSNotificationMethods:@"AddOrEditItemDraft" userInfo:dataDict locations:@[@"Tasks", @"AddTask", @"MultiAddTasks", @"ViewTask"]];
                
                [self->progressView setHidden:YES];
                [self BarButtonItems];
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    
                    [[[SetDataObject alloc] init] UpdateDataDraft:draftCreatedBy draftID:draftID setDataDict:@{@"DraftName" : draftName} completionHandler:^(BOOL finished) {
                        
                    }];
                    
                });
                
            }
            
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                         style:UIAlertActionStyleCancel
                                                       handler:^(UIAlertAction * _Nonnull action) {}];
        
        
        
        [controller addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            
            textField.delegate = self;
            textField.placeholder = @"Draft Name";
            textField.text = oldDraftName;
            textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
            
        }];
        
        [controller addAction:action1];
        [controller addAction:cancel];
        [self presentViewController:controller animated:YES completion:nil];
        
    }];
    
    return editDraftName;
}

-(UIAction *)DraftItemContextMenuEditDraftAction:(NSString *)draftName {
    
    UIAction *editDraftAction = [UIAction actionWithTitle:@"Edit Draft" image:[UIImage systemImageNamed:@"list.bullet.rectangle.portrait"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Edit Draft Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
            
        }];
        
        NSUInteger index = self->_draftDict[@"DraftName"] && [self->_draftDict[@"DraftName"] containsObject:draftName] ? [self->_draftDict[@"DraftName"] indexOfObject:draftName] : 0;
        NSMutableDictionary *draftData = self->_draftDict[@"DraftData"] && [(NSArray *)self->_draftDict[@"DraftData"] count] > index ? [self->_draftDict[@"DraftData"][index] mutableCopy] : [NSMutableDictionary dictionary];
        
        NSArray *keyArray = [[[GeneralObject alloc] init] GenerateDraftKeyArray];
        
        NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
        
        for (NSString *key in keyArray) {
            id object = self->_draftDict[key] && [(NSArray *)self->_draftDict[key] count] > index ? [self->_draftDict[key][index] mutableCopy] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
            [dataDict setObject:object forKey:key];
        }
        
        [draftData setObject:dataDict forKey:@"Draft"];
        
        [self BarButtonItems];
        
        NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
        
        [[[PushObject alloc] init] PushToAddTaskViewController:nil partiallyAddedDict:nil suggestedItemToAddDict:nil templateToEditDict:nil draftToEditDict:draftData moreOptionsDict:nil multiAddDict:nil notificationSettingsDict:self->_notificationSettingsDict topicDict:self->_topicDict homeID:homeID homeMembersArray:self->_homeMembersArray homeMembersDict:self->_homeMembersDict itemOccurrencesDict:[NSMutableDictionary dictionary] folderDict:self->_folderDict taskListDict:self->_taskListDict templateDict:self->_templateDict draftDict:self->_draftDict allItemAssignedToArrays:self->_allItemAssignedToArrays allItemTagsArrays:self->_allItemTagsArrays allItemIDsArrays:self->_allItemIDsArrays defaultTaskListName:self->topViewLabel.text partiallyAddedTask:NO addingTask:NO addingMultipleTasks:NO addingSuggestedTask:NO editingTask:NO viewingTask:NO viewingMoreOptions:NO duplicatingTask:NO editingTemplate:NO viewingTemplate:NO editingDraft:YES viewingDraft:NO currentViewController:self Superficial:NO];
        
    }];
    
    return editDraftAction;
    
}

-(UIAction *)DraftItemContextMenuDeleteDraftAction:(NSString *)draftName {
    
    UIAction *deleteAction = [UIAction actionWithTitle:@"Delete" image:[UIImage systemImageNamed:@"minus.circle"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Delete Draft Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
            
        }];
        
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Would you like to delete \"%@\"?", draftName] message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Deleting Draft %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
                
            }];
            
            NSUInteger index = self->_draftDict[@"DraftName"] && [self->_draftDict[@"DraftName"] containsObject:draftName] ? [self->_draftDict[@"DraftName"] indexOfObject:draftName] : 0;
            NSString *draftID = self->_draftDict[@"DraftID"] && [(NSArray *)self->_draftDict[@"DraftID"] count] > index ? self->_draftDict[@"DraftID"][index] : @"";
            NSString *draftCreatedBy = self->_draftDict[@"DraftCreatedBy"] && [(NSArray *)self->_draftDict[@"DraftCreatedBy"] count] > index ? self->_draftDict[@"DraftCreatedBy"][index] : @"";
            
            NSArray *keyArray = [[[GeneralObject alloc] init] GenerateDraftKeyArray];
            
            NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
            
            for (NSString *key in keyArray) {
                
                id object = self->_draftDict[key] && [(NSArray *)self->_draftDict[key] count] > index ? self->_draftDict[key][index] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                [dataDict setObject:object forKey:key];
                
            }
            
            for (NSString *key in keyArray) {
                
                NSMutableArray *arr = self->_draftDict[key] ? [self->_draftDict[key] mutableCopy] : [NSMutableArray array];
                if ([arr count] > index) { [arr removeObjectAtIndex:index]; }
                [self->_draftDict setObject:arr forKey:key];
                
            }
            
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"draftID == %@", draftID];
            [[[DeleteDataObject alloc] init] DeleteDataCoreData:@"Drafts" predicate:predicate];
            
            [[[GeneralObject alloc] init] CallNSNotificationMethods:@"DeleteItemDraft" userInfo:dataDict locations:@[@"Tasks", @"AddTask", @"MultiAddTasks", @"ViewTask"]];
            
            [self->progressView setHidden:YES];
            [self BarButtonItems];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                [[[DeleteDataObject alloc] init] DeleteDataDraft:draftID draftCreatedBy:draftCreatedBy completionHandler:^(BOOL finished) {
                    
                }];
                
            });
            
        }];
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"DeleteItem Cancelled For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
                
            }];
            
        }]];
        
        [deleteAction setValue:[UIColor systemRedColor] forKey:@"titleTextColor"];
        
        [actionSheet addAction:deleteAction];
        
        [self presentViewController:actionSheet animated:YES completion:nil];
        
    }];
    
    [deleteAction setAttributes:UIMenuElementAttributesDestructive];
    
    return deleteAction;
}

#pragma mark

-(UIAction *)DraftItemContextMenuNewDraftAction {
    
    UIImage *actionImage = [[[BoolDataObject alloc] init] PremiumSubscriptionIsOn] == NO ? [UIImage systemImageNamed:@"plus"] : [UIImage systemImageNamed:@"plus"];
    
    UIAction *newDraftAction = [UIAction actionWithTitle:@"Save Draft" image:actionImage identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Save Draft Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
            
        }];
        
        [self SaveDraft:self];
        
    }];
    
    return newDraftAction;
}

-(UIAction *)DraftItemContextMenuNoDraftAction {
    
    UIAction *noDraftAction = [UIAction actionWithTitle:@"No Draft" image:[UIImage systemImageNamed:@"nosign"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"No Draft Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
            
        }];
        
        self->selectedDraft = @"";
        [self SelectDraft:self draftName:self->selectedDraft];
        [self BarButtonItems];
        
    }];
    
    [noDraftAction setAttributes:UIMenuElementAttributesDestructive];
    
    return noDraftAction;
}

#pragma mark - Drafts Context Menus

-(UIMenu *)DraftItemContextMenuDraftActionsMenu:(NSString *)draftName draftNameArray:(NSMutableArray *)draftNameArray draftMenuActions:(NSMutableArray *)draftMenuActions {
    
    UIImage *menuImage = [UIImage systemImageNamed:@"list.bullet.rectangle.portrait"];
    
    if ([selectedDraft isEqualToString:draftName]) {
        
        menuImage = [UIImage systemImageNamed:@"checkmark"];
        
    }
    
    UIMenu *draftActionsMenu = [UIMenu menuWithTitle:draftName image:menuImage identifier:draftName options:0 children:draftMenuActions];
    
    return draftActionsMenu;
    
}

-(UIMenu *)DraftItemContextMenuDeleteDraftActionsMenu:(NSMutableArray *)deleteDraftMenuActions {
    
    UIMenu *deleteDraftMenu = [UIMenu menuWithTitle:@"" image:[UIImage systemImageNamed:@"list.bullet.rectangle.portrait"] identifier:@"DraftActions" options:UIMenuOptionsDisplayInline children:deleteDraftMenuActions];
    
    return deleteDraftMenu;
    
}

-(UIMenu *)DraftItemContextMenuNewDraftActionsMenu:(NSMutableArray *)newDraftMenuActions {
    
    UIMenu *newDraftMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"" options:UIMenuOptionsDisplayInline children:newDraftMenuActions];
    
    return newDraftMenu;
    
}

-(UIMenu *)DraftItemContextMenuNoDraftActionsMenu:(NSMutableArray *)noDraftAction {
    
    UIMenu *noDraftMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"" options:UIMenuOptionsDisplayInline children:noDraftAction];
    
    return noDraftMenu;
    
}

#pragma mark - Template Context Menu Actions

-(UIAction *)TemplateItemContextMenuSelectUnselectAction:(NSString *)templateName {
    
    UIAction *selectOrUnselectAction = [UIAction actionWithTitle:@"Select Template" image:[UIImage systemImageNamed:@"computermouse"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Select Template Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
            
        }];
        
        self->selectedTemplate = templateName;
        [self SelectTemplate:self templateName:templateName];
        [self BarButtonItems];
        
    }];
    
    return selectOrUnselectAction;
}

-(UIAction *)TemplateItemContextMenuEditTemplateNameAction:(NSString *)oldTemplateName {
    
    UIAction *editTemplateName = [UIAction actionWithTitle:@"Edit Name" image:[UIImage systemImageNamed:@"pencil"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Edit Template Name Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
            
        }];
        
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Enter your new template name" message:nil
                                                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Save"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * _Nonnull action) {
            
            //            [self StartProgressView];
            
            NSString *templateName = controller.textFields[0].text;
            
            NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
            NSString *trimmedStringString = [templateName stringByTrimmingCharactersInSet:charSet];
            
            if ([trimmedStringString isEqualToString:@""]) {
                
                [self->progressView setHidden:YES];
                [self BarButtonItems];
                [[[GeneralObject alloc] init] CreateAlert:@"Oops" message:@"Template Name field is empty" currentViewController:self];
                
            } else {
                
                NSUInteger index = self->_templateDict[@"TemplateName"] && [self->_templateDict[@"TemplateName"] containsObject:oldTemplateName] ? [self->_templateDict[@"TemplateName"] indexOfObject:oldTemplateName] : 0;
                NSString *templateID = self->_templateDict[@"TemplateID"] && [(NSArray *)self->_templateDict[@"TemplateID"] count] > index ? self->_templateDict[@"TemplateID"][index] : @"";
                NSString *templateCreatedBy = self->_templateDict[@"TemplateCreatedBy"] && [(NSArray *)self->_templateDict[@"TemplateCreatedBy"] count] > index ? self->_templateDict[@"TemplateCreatedBy"][index] : @"";
                
                NSArray *keyArray = [[[GeneralObject alloc] init] GenerateTemplateKeyArray];
                
                NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
                
                for (NSString *key in keyArray) {
                    id object = self->_templateDict[key] && [(NSArray *)self->_templateDict[key] count] > index ? self->_templateDict[key][index] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                    [dataDict setObject:object forKey:key];
                }
                
                [dataDict setObject:templateName forKey:@"TemplateName"];
                
                NSMutableArray *arr = self->_templateDict[@"TemplateName"] ? [self->_templateDict[@"TemplateName"] mutableCopy] : [NSMutableArray array];
                [arr replaceObjectAtIndex:index withObject:templateName];
                [self->_templateDict setObject:arr forKey:@"TemplateName"];
                
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"templateID == %@", templateID];
                [[[SetDataObject alloc] init] SetDataEditCoreData:@"Templates" predicate:predicate setDataObject:@{@"TemplateName" : templateName}];
                
                [[[GeneralObject alloc] init] CallNSNotificationMethods:@"AddOrEditItemTemplate" userInfo:dataDict locations:@[@"Tasks", @"AddTask", @"MultiAddTasks", @"ViewTask"]];
                
                [self->progressView setHidden:YES];
                [self BarButtonItems];
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    
                    [[[SetDataObject alloc] init] UpdateDataTemplate:templateCreatedBy templateID:templateID dataDict:@{@"TemplateName" : templateName} completionHandler:^(BOOL finished) {
                        
                    }];
                    
                });
                
            }
            
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                         style:UIAlertActionStyleCancel
                                                       handler:^(UIAlertAction * _Nonnull action) {}];
        
        
        
        [controller addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            
            textField.delegate = self;
            textField.placeholder = @"Template Name";
            textField.text = oldTemplateName;
            textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
            
        }];
        
        [controller addAction:action1];
        [controller addAction:cancel];
        [self presentViewController:controller animated:YES completion:nil];
        
    }];
    
    return editTemplateName;
}

-(UIAction *)TemplateItemContextMenuEditTemplateAction:(NSString *)templateName {
    
    UIAction *editTemplateAction = [UIAction actionWithTitle:@"Edit Template" image:[UIImage systemImageNamed:@"list.bullet.rectangle.portrait"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Edit Template Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
            
        }];
        
        NSUInteger index = self->_templateDict[@"TemplateName"] && [self->_templateDict[@"TemplateName"] containsObject:templateName] ? [self->_templateDict[@"TemplateName"] indexOfObject:templateName] : 0;
        NSMutableDictionary *templateData = self->_templateDict[@"TemplateData"] && [(NSArray *)self->_templateDict[@"TemplateData"] count] > index ? [self->_templateDict[@"TemplateData"][index] mutableCopy] : [NSMutableDictionary dictionary];
        
        NSArray *keyArray = [[[GeneralObject alloc] init] GenerateTemplateKeyArray];
        
        NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
        
        for (NSString *key in keyArray) {
            id object = self->_templateDict[key] && [(NSArray *)self->_templateDict[key] count] > index ? [self->_templateDict[key][index] mutableCopy] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
            [dataDict setObject:object forKey:key];
        }
        
        [templateData setObject:dataDict forKey:@"Template"];
        
        [self BarButtonItems];
        
        NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
        
        [[[PushObject alloc] init] PushToAddTaskViewController:nil partiallyAddedDict:nil suggestedItemToAddDict:nil templateToEditDict:templateData draftToEditDict:nil moreOptionsDict:nil multiAddDict:nil notificationSettingsDict:self->_notificationSettingsDict topicDict:self->_topicDict homeID:homeID homeMembersArray:self->_homeMembersArray homeMembersDict:self->_homeMembersDict itemOccurrencesDict:[NSMutableDictionary dictionary] folderDict:self->_folderDict taskListDict:self->_taskListDict templateDict:self->_templateDict draftDict:self->_draftDict allItemAssignedToArrays:self->_allItemAssignedToArrays allItemTagsArrays:self->_allItemTagsArrays allItemIDsArrays:self->_allItemIDsArrays defaultTaskListName:self->topViewLabel.text partiallyAddedTask:NO addingTask:NO addingMultipleTasks:NO addingSuggestedTask:NO editingTask:NO viewingTask:NO viewingMoreOptions:NO duplicatingTask:NO editingTemplate:YES viewingTemplate:NO editingDraft:NO viewingDraft:NO currentViewController:self Superficial:NO];
        
    }];
    
    return editTemplateAction;
    
}

-(UIAction *)TemplateItemContextMenuDefaultAction:(NSString *)templateName templateNameArray:(NSMutableArray *)templateNameArray templateDefaultArray:(NSMutableArray *)templateDefaultArray {
    
    NSUInteger outerIndex = [templateNameArray indexOfObject:templateName];
    NSString *actionImageString = [templateDefaultArray[outerIndex] isEqualToString:@"Yes"] ? @"star.fill" : @"star";
    NSString *actionString =  [templateDefaultArray[outerIndex] isEqualToString:@"Yes"] ? @"Remove Default" : @"Make Default";
    UIImage *actionImage = [templateDefaultArray[outerIndex] isEqualToString:@"Yes"] ? [[UIImage systemImageNamed:actionImageString] imageWithTintColor:[UIColor colorWithRed:249.0f/255.0f green:184.0f/255.0f blue:0.0f/255.0f alpha:1.0f] renderingMode:UIImageRenderingModeAlwaysOriginal] : [UIImage systemImageNamed:actionImageString];
    
    UIAction *defaultAction = [UIAction actionWithTitle:actionString image:actionImage identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Delete Template Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
            
        }];
        
        __block int totalQueries = 2;
        __block int completedQueries = 0;
        
        NSUInteger index = self->_templateDict[@"TemplateName"] && [self->_templateDict[@"TemplateName"] containsObject:templateName] ? [self->_templateDict[@"TemplateName"] indexOfObject:templateName] : 0;
        NSString *templateID = self->_templateDict[@"TemplateID"] && [(NSArray *)self->_templateDict[@"TemplateID"] count] > index ? self->_templateDict[@"TemplateID"][index] : @"";
        NSString *templateCreatedBy = self->_templateDict[@"TemplateCreatedBy"] && [(NSArray *)self->_templateDict[@"TemplateCreatedBy"] count] > index ? self->_templateDict[@"TemplateCreatedBy"][index] : @"";
        NSString *templateDefault = [templateDefaultArray count] > index && [templateDefaultArray[index] isEqualToString:@"Yes"] ? @"No" : @"Yes";
        
        NSArray *keyArray = [[[GeneralObject alloc] init] GenerateTemplateKeyArray];
        
        NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
        
        for (NSString *key in keyArray) {
            id object = self->_templateDict[key] && [(NSArray *)self->_templateDict[key] count] > index ? self->_templateDict[key][index] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
            [dataDict setObject:object forKey:key];
        }
        
        [dataDict setObject:templateDefault forKey:@"TemplateDefault"];
        
        NSMutableArray *arr = self->_templateDict[@"TemplateDefault"] ? [self->_templateDict[@"TemplateDefault"] mutableCopy] : [NSMutableArray array];
        [arr replaceObjectAtIndex:index withObject:templateDefault];
        [self->_templateDict setObject:arr forKey:@"TemplateDefault"];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"templateID == %@", templateID];
        [[[SetDataObject alloc] init] SetDataEditCoreData:@"Templates" predicate:predicate setDataObject:@{@"TemplateDefault" : templateDefault}];
        
        [[[SetDataObject alloc] init] UpdateDataTemplate:templateCreatedBy templateID:templateID dataDict:@{@"TemplateDefault" : templateDefault} completionHandler:^(BOOL finished) {
            
            [[[GeneralObject alloc] init] CallNSNotificationMethods:@"AddOrEditItemTemplate" userInfo:dataDict locations:@[@"Tasks", @"AddTask", @"MultiAddTasks", @"ViewTask"]];
            
            if (totalQueries == (completedQueries += 1)) {
                
                [self->progressView setHidden:YES];
                [self BarButtonItems];
                
            }
            
        }];
        
        if ([templateDefault isEqualToString:@"Yes"]) {
            
            for (NSString *templateID in self->_templateDict[@"TemplateID"]) {
                
                NSUInteger index = self->_templateDict[@"TemplateID"] ? [self->_templateDict[@"TemplateID"] indexOfObject:templateID] : 0;
                NSString *templateID = self->_templateDict[@"TemplateID"] && [(NSArray *)self->_templateDict[@"TemplateID"] count] > index ? self->_templateDict[@"TemplateID"][index] : @"";
                NSString *templateCreatedBy = self->_templateDict[@"TemplateCreatedBy"] && [(NSArray *)self->_templateDict[@"TemplateCreatedBy"] count] > index ? self->_templateDict[@"TemplateCreatedBy"][index] : @"";
                NSString *templateDefault = self->_templateDict[@"TemplateDefault"] && [(NSArray *)self->_templateDict[@"TemplateDefault"] count] > index ? self->_templateDict[@"TemplateDefault"][index] : @"";
                
                if ([templateDefault isEqualToString:@"Yes"] && outerIndex != index) {
                    
                    NSArray *keyArray = [[[GeneralObject alloc] init] GenerateTemplateKeyArray];
                    
                    NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
                    
                    for (NSString *key in keyArray) {
                        id object = self->_templateDict[key] && [(NSArray *)self->_templateDict[key] count] > index ? self->_templateDict[key][index] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                        [dataDict setObject:object forKey:key];
                    }
                    
                    [dataDict setObject:@"No" forKey:@"TemplateDefault"];
                    
                    NSMutableArray *arr = self->_templateDict[@"TemplateDefault"] ? [self->_templateDict[@"TemplateDefault"] mutableCopy] : [NSMutableArray array];
                    [arr replaceObjectAtIndex:index withObject:@"No"];
                    [self->_templateDict setObject:arr forKey:@"TemplateDefault"];
                    
                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"templateID == %@", templateID];
                    [[[SetDataObject alloc] init] SetDataEditCoreData:@"Templates" predicate:predicate setDataObject:@{@"TemplateDefault" : @"No"}];
                    
                    [[[SetDataObject alloc] init] UpdateDataTemplate:templateCreatedBy templateID:templateID dataDict:@{@"TemplateDefault" : @"No"} completionHandler:^(BOOL finished) {
                        
                        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"AddOrEditItemTemplate" userInfo:dataDict locations:@[@"Tasks", @"AddTask", @"MultiAddTasks", @"ViewTask"]];
                        
                        if (totalQueries == (completedQueries += 1)) {
                            
                            [self->progressView setHidden:YES];
                            [self BarButtonItems];
                            
                        }
                        
                    }];
                    
                } else if (index == [(NSArray *)self->_templateDict[@"TemplateID"] count] - 1) {
                    
                    if (totalQueries == (completedQueries += 1)) {
                        
                        [self->progressView setHidden:YES];
                        [self BarButtonItems];
                        
                    }
                    
                }
                
            }
            
        } else {
            
            if (totalQueries == (completedQueries += 1)) {
                
                [self->progressView setHidden:YES];
                [self BarButtonItems];
                
            }
            
        }
        
    }];
    
    return defaultAction;
}

-(UIAction *)TemplateItemContextMenuDeleteTemplateAction:(NSString *)templateName {
    
    UIAction *deleteAction = [UIAction actionWithTitle:@"Delete" image:[UIImage systemImageNamed:@"minus.circle"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Delete Template Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
            
        }];
        
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Would you like to delete \"%@\"?", templateName] message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Deleting Template %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
                
            }];
            
            //            [self StartProgressView];
            
            NSUInteger index = self->_templateDict[@"TemplateName"] && [self->_templateDict[@"TemplateName"] containsObject:templateName] ? [self->_templateDict[@"TemplateName"] indexOfObject:templateName] : 0;
            NSString *templateID = self->_templateDict[@"TemplateID"] && [(NSArray *)self->_templateDict[@"TemplateID"] count] > index ? self->_templateDict[@"TemplateID"][index] : @"";
            NSString *templateCreatedBy = self->_templateDict[@"TemplateCreatedBy"] && [(NSArray *)self->_templateDict[@"TemplateCreatedBy"] count] > index ? self->_templateDict[@"TemplateCreatedBy"][index] : @"";
            
            NSArray *keyArray = [[[GeneralObject alloc] init] GenerateTemplateKeyArray];
            
            NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
            
            for (NSString *key in keyArray) {
                
                id object = self->_templateDict[key] && [(NSArray *)self->_templateDict[key] count] > index ? self->_templateDict[key][index] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                [dataDict setObject:object forKey:key];
                
            }
            
            for (NSString *key in keyArray) {
                
                NSMutableArray *arr = self->_templateDict[key] ? [self->_templateDict[key] mutableCopy] : [NSMutableArray array];
                [arr removeObjectAtIndex:index];
                [self->_templateDict setObject:arr forKey:key];
                
            }
            
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"templateID == %@", templateID];
            [[[DeleteDataObject alloc] init] DeleteDataCoreData:@"Templates" predicate:predicate];
            
            [[[GeneralObject alloc] init] CallNSNotificationMethods:@"DeleteItemTemplate" userInfo:dataDict locations:@[@"Tasks", @"AddTask", @"MultiAddTasks", @"ViewTask"]];
            
            [self->progressView setHidden:YES];
            [self BarButtonItems];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                [[[DeleteDataObject alloc] init] DeleteDataTemplate:templateID templateCreatedBy:templateCreatedBy completionHandler:^(BOOL finished) {
                    
                }];
                
            });
            
        }];
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"DeleteItem Cancelled For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
                
            }];
            
        }]];
        
        [deleteAction setValue:[UIColor systemRedColor] forKey:@"titleTextColor"];
        
        [actionSheet addAction:deleteAction];
        
        [self presentViewController:actionSheet animated:YES completion:nil];
        
    }];
    
    [deleteAction setAttributes:UIMenuElementAttributesDestructive];
    
    return deleteAction;
}

#pragma mark

-(UIAction *)TemplateItemContextMenuNewTemplateAction {
    
    UIImage *actionImage = [[[BoolDataObject alloc] init] PremiumSubscriptionIsOn] == NO ? [UIImage systemImageNamed:@"plus"] : [UIImage systemImageNamed:@"plus"];
    
    UIAction *newTemplateAction = [UIAction actionWithTitle:@"New Template" image:actionImage identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"New Template Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
            
        }];
        
        int amountOfTemplates = (int)[(NSArray *)self->_templateDict[@"TemplateID"] count];
        
        if (amountOfTemplates >= 2 && [[[BoolDataObject alloc] init] PremiumSubscriptionIsOn] == NO) {
            
            [[[PushObject alloc] init] PushToWeDivvyPremiumViewController:YES comingFromSignUp:NO defaultPlan:@"" displayDiscount:@"Half-Off Yearly Discount No Sale Sticker" selectedSlide:@"Unlimited Templates" promoCodeID:@"" premiumPlanProductsArray:self->premiumPlanProductsArray premiumPlanPricesDict:self->premiumPlanPricesDict premiumPlanExpensivePricesDict:self->premiumPlanExpensivePricesDict premiumPlanPricesDiscountDict:self->premiumPlanPricesDiscountDict premiumPlanPricesNoFreeTrialDict:self->premiumPlanPricesNoFreeTrialDict currentViewController:self Superficial:NO];
            
        } else {
            
            [self NSNotificationObservers:YES];
            
            NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
            
            [[[PushObject alloc] init] PushToAddTaskViewController:nil partiallyAddedDict:nil suggestedItemToAddDict:nil templateToEditDict:[NSMutableDictionary dictionary] draftToEditDict:nil moreOptionsDict:nil multiAddDict:nil notificationSettingsDict:self->_notificationSettingsDict topicDict:self->_topicDict homeID:homeID homeMembersArray:self->_homeMembersArray homeMembersDict:self->_homeMembersDict itemOccurrencesDict:[NSMutableDictionary dictionary] folderDict:self->_folderDict taskListDict:self->_taskListDict templateDict:self->_templateDict draftDict:self->_draftDict allItemAssignedToArrays:self->_allItemAssignedToArrays allItemTagsArrays:self->_allItemTagsArrays allItemIDsArrays:self->_allItemIDsArrays defaultTaskListName:self->topViewLabel.text partiallyAddedTask:NO addingTask:NO addingMultipleTasks:NO addingSuggestedTask:NO editingTask:NO viewingTask:NO viewingMoreOptions:NO duplicatingTask:NO editingTemplate:NO viewingTemplate:YES editingDraft:NO viewingDraft:NO currentViewController:self Superficial:NO];
            
        }
        
    }];
    
    return newTemplateAction;
}

-(UIAction *)TemplateItemContextMenuNoTemplateAction {
    
    UIAction *noTemplateAction = [UIAction actionWithTitle:@"No Template" image:[UIImage systemImageNamed:@"nosign"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"No Template Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
            
        }];
        
        self->selectedTemplate = @"";
        [self SelectTemplate:self templateName:self->selectedTemplate];
        [self BarButtonItems];
        
    }];
    
    [noTemplateAction setAttributes:UIMenuElementAttributesDestructive];
    
    return noTemplateAction;
}

#pragma mark - Template Context Menus

-(UIMenu *)TemplateItemContextMenuTemplateActionsMenu:(NSString *)templateName templateNameArray:(NSMutableArray *)templateNameArray templateDefaultArray:(NSMutableArray *)templateDefaultArray templateMenuActions:(NSMutableArray *)templateMenuActions {
    
    NSUInteger outerIndex = [templateNameArray indexOfObject:templateName];
    
    UIImage *menuImage = [templateDefaultArray[outerIndex] isEqualToString:@"Yes"] ? [[UIImage systemImageNamed:@"star.fill"] imageWithTintColor:[UIColor colorWithRed:249.0f/255.0f green:184.0f/255.0f blue:0.0f/255.0f alpha:1.0f] renderingMode:UIImageRenderingModeAlwaysOriginal] : [UIImage systemImageNamed:@"list.bullet.rectangle.portrait"];
    
    if ([selectedTemplate isEqualToString:templateName]) {
        
        menuImage = [UIImage systemImageNamed:@"checkmark"];
        
    }
    
    UIMenu *templateActionsMenu = [UIMenu menuWithTitle:templateName image:menuImage identifier:templateName options:0 children:templateMenuActions];
    
    return templateActionsMenu;
    
}

-(UIMenu *)TemplateItemContextMenuDeleteTemplateActionsMenu:(NSMutableArray *)deleteTemplateMenuActions {
    
    UIMenu *deleteTemplateMenu = [UIMenu menuWithTitle:@"" image:[UIImage systemImageNamed:@"list.bullet.rectangle.portrait"] identifier:@"TemplateActions" options:UIMenuOptionsDisplayInline children:deleteTemplateMenuActions];
    
    return deleteTemplateMenu;
    
}

-(UIMenu *)TemplateItemContextMenuNewTemplateActionsMenu:(NSMutableArray *)newTemplateMenuActions {
    
    UIMenu *newTemplateMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"" options:UIMenuOptionsDisplayInline children:newTemplateMenuActions];
    
    return newTemplateMenu;
    
}

-(UIMenu *)TemplateItemContextMenuNoTemplateActionsMenu:(NSMutableArray *)noTemplateAction {
    
    UIMenu *noTemplateMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"" options:UIMenuOptionsDisplayInline children:noTemplateAction];
    
    return noTemplateMenu;
    
}

#pragma mark - Scheduled Start Menu Actions

-(UIAction *)ScheuledStartItemContextMenuAction:(NSString *)scheduledStartName {
    
    NSString *scheduledStartImage = [scheduledStartName isEqualToString:selectedScheduledStart] ? @"checkmark" : @"";
    
    UIImage *actionImage = [[[BoolDataObject alloc] init] PremiumSubscriptionIsOn] == NO && [scheduledStartName isEqualToString:@"Now"] == NO ? [UIImage systemImageNamed:scheduledStartImage] : [UIImage systemImageNamed:scheduledStartImage];
    
    UIAction *scheduledStartAction = [UIAction actionWithTitle:scheduledStartName image:actionImage identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"%@ Scheduled Start Clicked For %@", scheduledStartName, self->itemType] completionHandler:^(BOOL finished) {
            
        }];
        
        if ([[[BoolDataObject alloc] init] PremiumSubscriptionIsOn] == NO) {
            
            [[[PushObject alloc] init] PushToWeDivvyPremiumViewController:YES comingFromSignUp:NO defaultPlan:@"" displayDiscount:@"Half-Off Yearly Discount No Sale Sticker" selectedSlide:@"Scheduled Start" promoCodeID:@"" premiumPlanProductsArray:self->premiumPlanProductsArray premiumPlanPricesDict:self->premiumPlanPricesDict premiumPlanExpensivePricesDict:self->premiumPlanExpensivePricesDict premiumPlanPricesDiscountDict:self->premiumPlanPricesDiscountDict premiumPlanPricesNoFreeTrialDict:self->premiumPlanPricesNoFreeTrialDict currentViewController:self Superficial:NO];
            
        } else {
            
            self->selectedScheduledStart = scheduledStartName;
            
            [self BarButtonItems];
            
        }
        
    }];
    
    return scheduledStartAction;
}

-(UIAction *)ScheuledStartItemContextMenuCustomAction:(NSArray *)scheduledStartArray {
    
    NSString *scheduledStartImage = [scheduledStartArray containsObject:selectedScheduledStart] == NO && [selectedScheduledStart isEqualToString:@"Now"] == NO ? @"checkmark" : @"";
    
    UIImage *actionImage = [[[BoolDataObject alloc] init] PremiumSubscriptionIsOn] == NO ? [UIImage systemImageNamed:scheduledStartImage] : [UIImage systemImageNamed:scheduledStartImage];
    
    UIAction *customScheduledStartAction = [UIAction actionWithTitle:@"More Options" image:actionImage identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Custom Scheduled Start Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
            
        }];
        
        if ([[[BoolDataObject alloc] init] PremiumSubscriptionIsOn] == NO) {
            
            [[[PushObject alloc] init] PushToWeDivvyPremiumViewController:YES comingFromSignUp:NO defaultPlan:@"" displayDiscount:@"Half-Off Yearly Discount No Sale Sticker" selectedSlide:@"Scheduled Start" promoCodeID:@"" premiumPlanProductsArray:self->premiumPlanProductsArray premiumPlanPricesDict:self->premiumPlanPricesDict premiumPlanExpensivePricesDict:self->premiumPlanExpensivePricesDict premiumPlanPricesDiscountDict:self->premiumPlanPricesDiscountDict premiumPlanPricesNoFreeTrialDict:self->premiumPlanPricesNoFreeTrialDict currentViewController:self Superficial:NO];
            
        } else {
            
            NSMutableArray *itemsSelectedArray = [NSMutableArray array];
            
            if (self->selectedScheduledStart.length > 0) {
                
                itemsSelectedArray = [[self->selectedScheduledStart componentsSeparatedByString:@""] mutableCopy];
                
            }
            
            [[[PushObject alloc] init] PushToViewOptionsViewController:itemsSelectedArray customOptionsArray:nil specificDatesArray:nil viewingItemDetails:self->_viewingTask optionSelectedString:@"ScheduledStart" itemRepeatsFrequency:nil homeMembersDict:nil currentViewController:self];
            
        }
        
    }];
    
    return customScheduledStartAction;
}

#pragma mark - Scheduled Start Context Menus

-(UIMenu *)ScheduledStartItemContextMenuOptionsActionsMenu:(NSMutableArray *)optionsScheduledStartMenuActions {
    
    UIMenu *optionsScheduledStarteMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"" options:UIMenuOptionsDisplayInline children:optionsScheduledStartMenuActions];
    
    return optionsScheduledStarteMenu;
    
}

-(UIMenu *)ScheduledStartItemContextMenuCustomActionsMenu:(NSMutableArray *)customScheduledStartMenuActions {
    
    UIMenu *customScheduledStarteMenu = [UIMenu menuWithTitle:@"" image:nil identifier:@"" options:UIMenuOptionsDisplayInline children:customScheduledStartMenuActions];
    
    return customScheduledStarteMenu;
    
}

#pragma mark - Task List Context Menu Actions

-(UIAction *)TaskListItemContextMenuTaskListAction:(NSString *)taskListName {
    
    NSString *imageString = [topViewLabel.text isEqualToString:taskListName] ? @"checkmark" : @"list.bullet.rectangle.portrait";
    
    UIAction *taskListAction = [UIAction actionWithTitle:taskListName image:[UIImage systemImageNamed:imageString] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Specific List Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
            
        }];
        
        [self UpdateTopViewLabel:taskListName];
        
        [self SetUpTopLabelContextMenu];
        
        if (self->_viewingMoreOptions) {
            
            NSDictionary *dataDict = @{
                @"TaskList" : self->topViewLabel.text ? self->topViewLabel.text : @"No List",
            };
            
            [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemBringBackMoreOptions" userInfo:dataDict locations:@[@"AddTask"]];
            
        }
        
    }];
    
    return taskListAction;
}

-(UIAction *)TaskListItemContextMenuSuggestedTaskListAction:(NSString *)taskListName {
    
    NSString *imageString = [topViewLabel.text isEqualToString:taskListName] && [_taskListDict[@"TaskListName"] containsObject:topViewLabel.text] == NO ? @"checkmark" : @"list.bullet.rectangle.portrait";
    
    UIAction *taskListAction = [UIAction actionWithTitle:taskListName image:[UIImage systemImageNamed:imageString] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Specific List Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
            
        }];
        
        [self UpdateTopViewLabel:taskListName];
        
        [self SetUpTopLabelContextMenu];
        
        if (self->_viewingMoreOptions) {
            
            NSDictionary *dataDict = @{
                @"TaskList" : self->topViewLabel.text ? self->topViewLabel.text : @"No List",
                @"TaskListSuggested" : @"Yes",
            };
            
            [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemBringBackMoreOptions" userInfo:dataDict locations:@[@"AddTask"]];
            
        }
        
    }];
    
    return taskListAction;
}

-(UIAction *)TaskListItemContextMenuNewTaskListAction {
    
    UIAction *newTaskListAction = [UIAction actionWithTitle:@"New List" image:[UIImage systemImageNamed:@"plus"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"New List Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
            
        }];
        
        [[[PushObject alloc] init] PushToViewTaskListsViewController:[self->_folderDict mutableCopy] taskListDict:[self->_taskListDict mutableCopy] itemToEditDict:NULL itemUniqueID:@"" comingFromTasksViewController:NO comingFromViewTaskViewController:NO currentViewController:self];
        
        [self SetUpTopLabelContextMenu];
        
    }];
    
    return newTaskListAction;
}

-(UIAction *)TaskListItemContextMenuNoTaskListAction {
    
    UIAction *noTaskListAction = [UIAction actionWithTitle:@"No List" image:[UIImage systemImageNamed:@"nosign"] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"No List Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
            
        }];
        
        [self UpdateTopViewLabel:@"No List"];
        
        [self SetUpTopLabelContextMenu];
        
        if (self->_viewingMoreOptions) {
            
            NSDictionary *dataDict = @{
                @"TaskList" : self->topViewLabel.text ? self->topViewLabel.text : @"No List",
            };
            
            [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemBringBackMoreOptions" userInfo:dataDict locations:@[@"AddTask"]];
            
        }
        
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

#pragma mark - IBAction Methods

-(IBAction)TapGestureItemRepeatIfCompletedEarly:(id)sender {
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Oops"
                                                                        message:@"You cannot select specific days if \"Repeat If Completed Early\" is turned on. Would you like to turn it off?"
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *yeaAction = [UIAlertAction actionWithTitle:@"Turn Off"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * _Nonnull action) {
        
        [self RepeatIfCompletedEarlySwitchAction:@"No"];
        
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Close"
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [controller addAction:yeaAction];
    [controller addAction:cancel];
    [self presentViewController:controller animated:YES completion:nil];
    
}

#pragma mark - EditingUserData

-(void)EditingUserData_Name:(NSMutableDictionary *)dictToUse {
    
    self->itemNameTextField.text = dictToUse[@"ItemName"] ? dictToUse[@"ItemName"] : @"";
    
}

-(void)EditingUserData_AssignedTo:(NSMutableDictionary *)dictToUse {
    
    self->chosenItemAssignedToAnybody = dictToUse[@"ItemAssignedToAnybody"] ? dictToUse[@"ItemAssignedToAnybody"] : @"";
    self->chosenItemAssignedToNewHomeMembers = dictToUse[@"ItemAssignedToNewHomeMembers"] ? dictToUse[@"ItemAssignedToNewHomeMembers"] : @"";
    
    self->assignedToIDArray = dictToUse[@"ItemAssignedTo"] ? [dictToUse[@"ItemAssignedTo"] mutableCopy] : [NSMutableArray array];
    self->assignedToUsernameArray = [NSMutableArray array];
    self->assignedToProfileImageArray = [NSMutableArray array];
    
    for (NSString *userID in assignedToIDArray) {
        
        if ([_homeMembersDict[@"UserID"] containsObject:userID]) {
            
            NSUInteger index = [_homeMembersDict[@"UserID"] indexOfObject:userID];
            [assignedToUsernameArray addObject:[(NSArray *)_homeMembersDict[@"Username"] count] > index ? _homeMembersDict[@"Username"][index] : @""];
            [assignedToProfileImageArray addObject:[(NSArray *)_homeMembersDict[@"ProfileImageURL"] count] > index ? _homeMembersDict[@"ProfileImageURL"][index] : @""];
            
        }
        
    }
    
    if (assignedToIDArray.count == 0) {
        
        assignedToIDArray = [_homeMembersDict[@"UserID"] mutableCopy];
        assignedToUsernameArray = [_homeMembersDict[@"Username"] mutableCopy];
        assignedToProfileImageArray = [_homeMembersDict[@"ProfileImageURL"] mutableCopy];
        
    }
    
    BOOL TaskIsAssignedToNobody = [[[BoolDataObject alloc] init] TaskIsAssignedToNobody:dictToUse itemType:itemType];
    BOOL TaskIsAssignedToMyself = [[[BoolDataObject alloc] init] TaskIsAssignedToOnlyMyself:dictToUse itemType:itemType];
    BOOL TaskIsAssignedToAnybody = [[[BoolDataObject alloc] init] TaskIsAssignedToAnybody:dictToUse itemType:itemType];
    
    if (TaskIsAssignedToNobody == YES) {
        
        self->itemAssignedToTextField.text = @"Nobody";
        self->assignedToIDArray = [NSMutableArray array];
        
    } else if (TaskIsAssignedToMyself == YES) {
        
        self->itemAssignedToTextField.text = @"Myself";
        
    } else if (TaskIsAssignedToAnybody == YES) {
        
        self->itemAssignedToTextField.text = @"Anybody";
        
    } else {
        
        NSString *itemAssignedTo = @"";
        
        for (NSString *userID in self->assignedToIDArray) {
            
            if ([self->assignedToIDArray containsObject:userID]) {
                
                NSUInteger index = [self->assignedToIDArray indexOfObject:userID];
                
                NSString *assignedToUsername = [self->assignedToUsernameArray count] > index ? self->assignedToUsernameArray[index] : @"";
                
                if (itemAssignedTo.length == 0 && TaskIsAssignedToMyself == NO && TaskIsAssignedToAnybody == NO) {
                    
                    itemAssignedTo = [NSString stringWithFormat:@"%@", [self->assignedToUsernameArray count] > index ? self->assignedToUsernameArray[index] : @""];
                    
                } else if (itemAssignedTo.length != 0 && assignedToUsername.length != 0) {
                    
                    itemAssignedTo = [NSString stringWithFormat:@"%@, %@", itemAssignedTo, assignedToUsername];
                    
                }
                
            }
            
        }
        
        self->itemAssignedToTextField.text = itemAssignedTo;
        
    }
    
}

-(void)EditingUserData_MustComplete:(NSMutableDictionary *)dictToUse {
    
    self->itemMustCompleteTextField.text = dictToUse[@"ItemMustComplete"] ? dictToUse[@"ItemMustComplete"] : @"";
    
    [self GenerateCompletedByFrequencyArray:dictToUse[@"ItemAssignedTo"] ? dictToUse[@"ItemAssignedTo"] : [NSMutableDictionary dictionary]];
    
    BOOL TaskMustBeCompletedByEveryoneAssigned = [[[BoolDataObject alloc] init] TaskMustBeCompletedByEveryoneAssigned:dictToUse itemType:itemType];
    
    itemMustCompleteTextField.text = dictToUse[@"ItemMustComplete"] ? dictToUse[@"ItemMustComplete"] : @"Everyone";
    
    if (TaskMustBeCompletedByEveryoneAssigned == NO) {
        
        self->completedByOnlyComp = dictToUse[@"ItemMustComplete"] && [dictToUse[@"ItemMustComplete"] containsString:@" "] ? [dictToUse[@"ItemMustComplete"] componentsSeparatedByString:@" "][0] : @"Only";
        self->completedByAmountComp = dictToUse[@"ItemMustComplete"] && [dictToUse[@"ItemMustComplete"] containsString:@" "] ? [dictToUse[@"ItemMustComplete"] componentsSeparatedByString:@" "][1] : @"1";
        
        [self SelectRowForCompAndArrays:
         @[@{@"Array" : self->frequencyCompletedByOnlyArray, @"Comp" : self->completedByOnlyComp},
           @{@"Array" : self->frequencyCompletedByAmountArray, @"Comp" : self->completedByAmountComp}]
                              textField:itemMustCompleteTextField];
        
    }
    
    [self GenerateCompletedByTextFieldText];
    
}

-(void)EditingUserData_Amount:(NSMutableDictionary *)dictToUse {
    
    self->itemAmountTextField.text = dictToUse[@"ItemAmount"] ? dictToUse[@"ItemAmount"] : [NSString stringWithFormat:@"%@0%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol];
    
}

-(void)EditingUserData_ItemizedItems:(NSMutableDictionary *)dictToUse {
    
    itemItemizedItemsDict = dictToUse[@"ItemItemizedItems"] != nil ? [dictToUse[@"ItemItemizedItems"] mutableCopy] : [NSMutableDictionary dictionary];
    
    if (dictToUse[@"ItemItemizedItems"] != nil && [[dictToUse[@"ItemItemizedItems"] allKeys] count] > 0) {
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"ItemAmount" userInfo:@{@"ItemsDict" : itemItemizedItemsDict} locations:@[@"AddTask"]];
    }
    
}

-(void)EditingUserData_CostPerPerson:(NSMutableDictionary *)dictToUse {
    
    self->itemCostPerPersonDict =  dictToUse[@"ItemCostPerPerson"] ? [dictToUse[@"ItemCostPerPerson"] mutableCopy] : [NSMutableDictionary dictionary];
    [self GenerateCostPerPersonTextFieldText:self->itemCostPerPersonDict];
    
}

-(void)EditingUserData_PaymentMethods:(NSMutableDictionary *)dictToUse {
    
    self->itemPaymentMethodDict =  dictToUse[@"ItemPaymentMethod"] ? [dictToUse[@"ItemPaymentMethod"] mutableCopy] : [NSMutableDictionary dictionary];
    itemPaymentMethodTextField.text = self->itemPaymentMethodDict[@"PaymentMethod"] ? self->itemPaymentMethodDict[@"PaymentMethod"] : @"";
    
}

-(void)EditingUserData_ListItems:(NSMutableDictionary *)dictToUse {
    
    NSString *itemListItemsCount = [NSString stringWithFormat:@"%lu", dictToUse[@"ItemListItems"] ? (unsigned long)[[dictToUse[@"ItemListItems"] allKeys] count] : 0];
    
    itemListItemsTextField.text = itemListItemsCount;
    
    itemListItemsDict = dictToUse[@"ItemListItems"] ? [dictToUse[@"ItemListItems"] mutableCopy] : [NSMutableDictionary dictionary];
    
}

-(void)EditingUserData_DueDate:(NSMutableDictionary *)dictToUse {
    
    self->itemDueDatesSkippedArray = dictToUse[@"ItemDueDatesSkipped"] ? [dictToUse[@"ItemDueDatesSkipped"] mutableCopy] : [NSMutableArray array];
    
    self->itemSpecificDueDatesArray = dictToUse[@"ItemSpecificDueDates"] ? [dictToUse[@"ItemSpecificDueDates"] mutableCopy] : [NSMutableArray array];
    
    
    
    NSString *itemDueDate = dictToUse[@"ItemDueDate"] ? dictToUse[@"ItemDueDate"] : @"";
    
    BOOL TaskHasNoDueDate = [[[BoolDataObject alloc] init] TaskHasNoDueDate:dictToUse itemType:itemType];
    BOOL TaskHasMultipleDueDate =  [[[BoolDataObject alloc] init] TaskHasMultipleDueDate:dictToUse itemType:itemType];
    
    if (TaskHasNoDueDate == YES) {
        
        itemDueDate = @"No Due Date";
        
    } else if (TaskHasMultipleDueDate == YES) {
        
        NSString *sString = dictToUse[@"ItemSpecificDueDates"] && [(NSArray *)dictToUse[@"ItemSpecificDueDates"] count] == 1 ? @"" : @"s";
        
        itemDueDate = [NSString stringWithFormat:@"%lu Date%@", dictToUse[@"ItemSpecificDueDates"] ? [(NSArray *)dictToUse[@"ItemSpecificDueDates"] count] : 0, sString];
        
    } else {
        
        //        itemDueDate = [[[GeneralObject alloc] init] GenerateStringWithReplacementString:itemDueDate stringToReplace:@"11:59 PM" replacementString:@"Any Time"];
        
        NSArray *dueDateArray = [itemDueDate componentsSeparatedByString:@" "];
        
        NSString *month = dueDateArray.count > 0 ? dueDateArray[0] : @"";
        NSString *day = dueDateArray.count > 1 ? dueDateArray[1] : @"";
        NSString *year = dueDateArray.count > 2 ? dueDateArray[2] : @"";
        
        itemDueDate = [NSString stringWithFormat:@"%@ %@ %@", month, day, year];
        
        itemDueDate = [NSString stringWithFormat:@"%@, %@", [self GenerateWeekdayForDate:itemDueDate], itemDueDate];
        
    }
    
    
    
    self->itemDueDateTextField.text = itemDueDate;
    
}

-(void)EditingUserData_Repeats:(NSMutableDictionary *)dictToUse {
    
    self->chosenItemRepeats = dictToUse[@"ItemRepeats"] ? dictToUse[@"ItemRepeats"] : @"Never";
    self->chosenItemRepeatIfCompletedEarly = dictToUse[@"ItemRepeatIfCompletedEarly"] ? [dictToUse[@"ItemRepeatIfCompletedEarly"] mutableCopy] : @"No";
    
    self->itemRepeatsTextField.text = dictToUse[@"ItemRepeats"] ? dictToUse[@"ItemRepeats"] : @"Never";
    
    [self SetUpRepeatsContextMenu:NO];
 
}

-(void)EditingUserData_RepeatIfCompletedEarly:(NSMutableDictionary *)dictToUse {
    
    [self RepeatIfCompletedEarlySwitchAction:dictToUse[@"ItemRepeatIfCompletedEarly"] && [dictToUse[@"ItemRepeatIfCompletedEarly"] isEqualToString:@"Yes"] && [dictToUse[@"ItemRepeats"] isEqualToString:@"When Completed"] == NO ? @"Yes" : @"No"];
    
}

-(void)EditingUserData_Start:(NSMutableDictionary *)dictToUse {
    
    NSString *itemStartDate = dictToUse[@"ItemStartDate"] ? dictToUse[@"ItemStartDate"] : @"";
    
    if ([itemStartDate containsString:@" "]) {
        
        NSArray *arr = [itemStartDate componentsSeparatedByString:@" "];
        
        NSString *month = [arr count] > 0 ? arr[0] : @"";
        NSString *day = [arr count] > 1 ? arr[1] : @"";
        NSString *year = [arr count] > 2 ? arr[2] : @"";
        
        self->itemStartDateTextField.text = [NSString stringWithFormat:@"%@ %@ %@", month, day, year];
        
    }
    
}

-(void)EditingUserData_End:(NSMutableDictionary *)dictToUse {
    
    NSString *itemEndDate = dictToUse[@"ItemEndDate"] ? dictToUse[@"ItemEndDate"] : @"";
    
    if ([itemEndDate containsString:@" "]) {
        
        NSArray *arr = [itemEndDate componentsSeparatedByString:@" "];
        
        NSString *month = [arr count] > 0 ? arr[0] : @"";
        NSString *day = [arr count] > 1 ? arr[1] : @"";
        NSString *year = [arr count] > 2 ? arr[2] : @"";
        
        self->itemEndDateTextField.text = [NSString stringWithFormat:@"%@ %@ %@", month, day, year];
        
    }
    
}

-(void)EditingUserData_Days:(NSMutableDictionary *)dictToUse {
    
    BOOL TaskHasAnyDay = [[[BoolDataObject alloc] init] TaskHasAnyDay:dictToUse itemType:itemType];
    
    NSString *itemDays = TaskHasAnyDay == YES ? @"Any Day" : dictToUse[@"ItemDays"] ? dictToUse[@"ItemDays"] : @"";
    
    self->itemDaysTextField.text = itemDays;
    
}

-(void)EditingUserData_Time:(NSMutableDictionary *)dictToUse {
    
    BOOL TaskHasTime = [[[BoolDataObject alloc] init] TaskHasTime:dictToUse itemType:itemType];
    BOOL TaskHasAnyTime = [[[BoolDataObject alloc] init] TaskHasAnyTime:dictToUse itemType:itemType];
    
    if (TaskHasTime == YES && TaskHasAnyTime == YES) {
        
        itemTimeTextField.text = @"Any Time";
        
        self->AMPMComp = @"PM";
        self->hourComp = @"5";
        self->minuteComp = @"00";
        
    } else if (TaskHasTime == YES && TaskHasAnyTime == NO) {
        
        NSDictionary *timeDict = [[[GeneralObject alloc] init] GenerateItemTime12HourDict:dictToUse[@"ItemTime"]];
        
        self->AMPMComp = timeDict[@"AMPM"];
        self->hourComp = timeDict[@"Hour"];
        self->minuteComp = timeDict[@"Minute"];
        
        itemTimeTextField.text = [NSString stringWithFormat:@"%@:%@ %@", self->hourComp, self->minuteComp, self->AMPMComp];
        
    }
    
    if (TaskHasTime == YES) {
        
        [self SelectRowForCompAndArrays:
         @[@{@"Array" : self->frequencyHourArray, @"Comp" : self->hourComp},
           @{@"Array" : self->frequencyMinuteArray, @"Comp" : self->minuteComp},
           @{@"Array" : self->frequencyAMPMArray, @"Comp" : self->AMPMComp}]
                              textField:itemTimeTextField];
        
    }
    
}

-(void)EditingUserData_TakeTurns:(NSMutableDictionary *)dictToUse {
    
    BOOL ItemTakesTurns = [[[BoolDataObject alloc] init] TaskIsTakingTurns:dictToUse itemType:itemType];
    
    [self->itemEveryoneTakesTurnsSwitch setOn:ItemTakesTurns];
    
}

-(void)EditingUserData_AlternateTurns:(NSMutableDictionary *)dictToUse {
    
    self->chosenItemAlternateTurns = dictToUse[@"ItemAlternateTurns"] && [dictToUse[@"ItemAlternateTurns"] length] > 0 ? dictToUse[@"ItemAlternateTurns"] : @"Every Occurrence";
    
    self->itemAlternateTurnsTextField.text = self->chosenItemAlternateTurns;
    
    itemAlternateTurnsTextField.userInteractionEnabled = _viewingTask == NO ? YES : NO;
    itemAlternateTurnsView.userInteractionEnabled = _viewingTask == NO ? YES : NO;
    
}

-(void)EditingUserData_TurnOrder:(NSMutableDictionary *)dictToUse {
    
    NSString *randomize = dictToUse[@"ItemRandomizeTurnOrder"] ? dictToUse[@"ItemRandomizeTurnOrder"] : @"No";
    
    if ([randomize isEqualToString:@"Yes"]) {
        
        self->itemTurnOrderTextField.text = @"Randomize";
        
    } else {
        
        [self GenerateSpecificOrderTextFieldText:[assignedToUsernameArray mutableCopy]];
        
    }
    
    itemTurnOrderTextField.userInteractionEnabled = _viewingTask == NO ? YES : NO;
    itemTurnOrderView.userInteractionEnabled = _viewingTask == NO ? YES : NO;
    
}

-(void)EditingUserData_Image:(NSMutableDictionary *)dictToUse {
    
    BOOL ItemImageDoesNotExist = [dictToUse[@"ItemImageURL"] isEqualToString:@"xxx"];
    
    if ([dictToUse[@"ItemImageURL"] containsString:@"gs://"]) {
        
        [[[GetDataObject alloc] init] GetDataItemImage:dictToUse[@"ItemImageURL"] completionHandler:^(BOOL finished, NSURL * _Nonnull itemImageURL) {
            
            NSData *data = [NSData dataWithContentsOfURL:itemImageURL];
            UIImage *image = [UIImage imageWithData:data];
            
            self->chosenItemImage = image;
            self->addImageImage.image = ItemImageDoesNotExist == YES || self->chosenItemImage == NULL ? [UIImage systemImageNamed:@"camera.viewfinder"] : self->chosenItemImage;
            
        }];
        
    } else {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self->chosenItemImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:dictToUse[@"ItemImageURL"]]]];
            self->addImageImage.image = ItemImageDoesNotExist == YES || self->chosenItemImage == NULL ? [UIImage systemImageNamed:@"camera.viewfinder"] : self->chosenItemImage;
            
        });
        
    }
    
}

-(void)EditingUserData_Notes:(NSMutableDictionary *)dictToUse {
    
    self->itemNotesTextField.text = dictToUse[@"ItemNotes"] ? dictToUse[@"ItemNotes"] : @"";
    
    BOOL NotesHasText = itemNotesTextField.text.length > 0;
    
    UIColor *notesColor = NotesHasText == YES ? [UIColor colorWithRed:138.0f/255.0f green:137.0f/255.0f blue:142.0f/255.0f alpha:1.0f] : [UIColor colorWithRed:181.0f/255.0f green:188.0f/255.0f blue:193.0f/255.0f alpha:1.0f];
    
    itemNotesTextField.textColor = notesColor;
    
    [self textViewDidChange:itemNotesTextField];
    
}

-(void)EditingUserData_Subtasks:(NSMutableDictionary *)dictToUse {
    
    NSString *itemSubTasksCount = dictToUse[@"ItemSubTasks"] ? [NSString stringWithFormat:@"%lu", (unsigned long)[[dictToUse[@"ItemSubTasks"] allKeys] count]] : @"";
    
    itemSubTasksTextField.text = itemSubTasksCount;
    
    itemSubTasksDict = dictToUse[@"ItemSubTasks"] ? [dictToUse[@"ItemSubTasks"] mutableCopy] : [NSMutableDictionary dictionary];
    
}

-(void)EditingUserData_Reminders:(NSMutableDictionary *)dictToUse {
    
    NSString *itemRemindersCount = [NSString stringWithFormat:@"%lu", dictToUse[@"ItemReminderDict"] ? (unsigned long)[[dictToUse[@"ItemReminderDict"] allKeys] count] : 2];
    
    itemReminderTextField.text = itemRemindersCount;
    
    itemReminderDict = dictToUse[@"ItemReminderDict"] ? [dictToUse[@"ItemReminderDict"] mutableCopy] : [[[[GeneralObject alloc] init] GenerateDefaultRemindersDict:[[[GeneralObject alloc] init] GenerateItemType] itemAssignedTo:[self GenerateItemAssignedTo:[self GenerateItemRandomizeTurnOrder]] itemRepeats:[self GenerateItemRepeat] homeMembersDict:_homeMembersDict AnyTime:YES] mutableCopy];
    
}

-(void)EditingUserData_GracePeriod:(NSMutableDictionary *)dictToUse {
    
    self->chosenItemGracePeriod = dictToUse[@"ItemGracePeriod"] ? dictToUse[@"ItemGracePeriod"] : @"None";
    
    BOOL TaskHasGracePeriod = [[[BoolDataObject alloc] init] TaskHasGracePeriod:dictToUse itemType:itemType];
    
    itemGracePeriodTextField.text = dictToUse[@"ItemGracePeriod"] ? dictToUse[@"ItemGracePeriod"] : @"None";
    
    if (TaskHasGracePeriod == YES) {
        
        self->gracePeriodAmountComp =
        dictToUse[@"ItemGracePeriod"] &&
        [dictToUse[@"ItemGracePeriod"] containsString:@" "] &&
        [[dictToUse[@"ItemGracePeriod"] componentsSeparatedByString:@" "] count] > 0 ?
        [dictToUse[@"ItemGracePeriod"] componentsSeparatedByString:@" "][0] : @"";
        
        self->gracePeriodFrequencyComp =
        dictToUse[@"ItemGracePeriod"] &&
        [dictToUse[@"ItemGracePeriod"] containsString:@" "] &&
        [[dictToUse[@"ItemGracePeriod"] componentsSeparatedByString:@" "] count] > 1 ?
        [dictToUse[@"ItemGracePeriod"] componentsSeparatedByString:@" "][1] : @"";
        
        [self GenerateGracePeriodFrequencyArray:[self GenerateItemRepeat]];
        
        [self SelectRowForCompAndArrays:
         @[
            @{@"Array" : self->frequencyGracePeriodAmountArray ? self->frequencyGracePeriodAmountArray : [NSMutableArray array], @"Comp" : self->gracePeriodAmountComp ? self->gracePeriodAmountComp : @""},
            @{@"Array" : self->frequencyGracePeriodFrequencyArray ? self->frequencyGracePeriodFrequencyArray : [NSMutableArray array], @"Comp" : self->gracePeriodFrequencyComp ? self->gracePeriodFrequencyComp : @""}
        ]
                              textField:itemGracePeriodTextField ? itemGracePeriodTextField : [[UITextField alloc] init]];
        
    } else {
        
        [self GenerateGracePeriodFrequencyArray:[self GenerateItemRepeat]];
        
    }
    
}

-(void)EditingUserData_PastDue:(NSMutableDictionary *)dictToUse {
    
    self->chosenItemPastDue = dictToUse[@"ItemPastDue"] ? dictToUse[@"ItemPastDue"] : @"2 Days";
    
    self->itemPastDueTextField.text = dictToUse[@"ItemPastDue"] ? dictToUse[@"ItemPastDue"] : @"2 Days";
    
    itemPastDueTextField.userInteractionEnabled = _viewingTask == NO ? YES : NO;
    itemPastDueView.userInteractionEnabled = _viewingTask == NO ? YES : NO;
    
}

-(void)EditingUserData_Color:(NSMutableDictionary *)dictToUse {
    
    self->chosenItemColor = dictToUse[@"ItemColor"] ? dictToUse[@"ItemColor"] : @"";
    
    itemColorSelectedView.backgroundColor = [[[GeneralObject alloc] init] GenerateColorOptionFromColorString:chosenItemColor];
    
}

-(void)EditingUserData_Tags:(NSMutableDictionary *)dictToUse {
    
    self->itemTagsArrays = dictToUse[@"ItemTags"] ? [dictToUse[@"ItemTags"] mutableCopy] : [NSMutableArray array];
    
    NSString *tagStr = itemTagsArrays && itemTagsArrays.count == 1 ? @"Tag" : @"Tags";
    self->itemTagsTextField.text = [NSString stringWithFormat:@"%ld %@", itemTagsArrays.count, tagStr];
    
}

-(void)EditingUserData_Priority:(NSMutableDictionary *)dictToUse {
    
    self->chosenItemPriority = dictToUse[@"ItemPriority"] ? dictToUse[@"ItemPriority"] : @"";
    
    BOOL TaskHasPriority = [[[BoolDataObject alloc] init] TaskHasPriority:dictToUse itemType:itemType];
    
    NSString *itemPriority = TaskHasPriority == YES ? dictToUse[@"ItemPriority"] : @"No Priority";
    
    self->itemPriorityTextField.text = itemPriority;
    
}

-(void)EditingUserData_Difficulty:(NSMutableDictionary *)dictToUse {
    
    self->chosenItemDifficulty = dictToUse[@"ItemDifficulty"] ? dictToUse[@"ItemDifficulty"] : @"";
    
    BOOL TaskHasDifficulty = [[[BoolDataObject alloc] init] TaskHasDifficulty:dictToUse itemType:itemType];
    
    NSString *itemDifficulty = TaskHasDifficulty == YES ? dictToUse[@"ItemDifficulty"] : @"No Difficulty";
    
    self->itemDifficultyTextField.text = itemDifficulty;
    
}

-(void)EditingUserData_Reward:(NSMutableDictionary *)dictToUse {
    
    self->itemRewardDict = dictToUse[@"ItemReward"] ? [dictToUse[@"ItemReward"] mutableCopy] : [NSMutableDictionary dictionary];
    
    itemRewardTextField.text = self->itemRewardDict[@"Reward"] ? self->itemRewardDict[@"Reward"] : @"";
    
    itemRewardTextField.userInteractionEnabled = _viewingTask == NO ? YES : NO;
    itemRewardView.userInteractionEnabled = _viewingTask == NO ? YES : NO;
    
}

-(void)EditingUserData_Private:(NSMutableDictionary *)dictToUse {
    
    self->chosenItemPrivate = dictToUse[@"ItemPrivate"] ? dictToUse[@"ItemPrivate"] : @"";
    
    BOOL ItemIsPrivate = [[[BoolDataObject alloc] init] TaskIsPrivate:dictToUse itemType:itemType];
    
    [self->itemPrivateSwitch setOn:ItemIsPrivate];
    
}

-(void)EditingUserData_ApprovalNeeded:(NSMutableDictionary *)dictToUse {
    
    self->chosenItemApprovalNeeded = dictToUse[@"ItemApprovalNeeded"] ? dictToUse[@"ItemApprovalNeeded"] : @"";
    
    itemApprovalRequestsDict = dictToUse[@"ItemApprovalRequests"] != nil ? [dictToUse[@"ItemApprovalRequests"] mutableCopy] : [NSMutableDictionary dictionary];
    
}


#pragma mark - MoreOptionsData

-(void)MoreOptionsData_TopView:(NSMutableDictionary *)dictToUse {
    
    topViewLabel.text = dictToUse[@"TaskList"] ? dictToUse[@"TaskList"] : @"No List";
    [self UpdateTopViewLabel:topViewLabel.text];
    
}

-(void)MoreOptionsData_AssignedTo:(NSMutableDictionary *)dictToUse {
    
    self->assignedToIDArray = dictToUse[@"ItemAssignedTo"] ? [dictToUse[@"ItemAssignedTo"] mutableCopy] : [NSMutableArray array];
    
}

-(void)MoreOptionsData_Repeats:(NSMutableDictionary *)dictToUse {
    
    self->chosenItemRepeats = dictToUse[@"ItemRepeats"] ? dictToUse[@"ItemRepeats"] : @"Never";
    self->itemRepeatsTextField.text = self->chosenItemRepeats;
    
}

-(void)MoreOptionsData_Subtasks:(NSMutableDictionary *)dictToUse {
    
    NSString *itemSubTasksCount = dictToUse[@"ItemSubTasks"] ? [NSString stringWithFormat:@"%lu", (unsigned long)[[dictToUse[@"ItemSubTasks"] allKeys] count]] : @"";
    
    itemSubTasksTextField.text = itemSubTasksCount;
    
    itemSubTasksDict = dictToUse[@"ItemSubTasks"] ? [dictToUse[@"ItemSubTasks"] mutableCopy] : [NSMutableDictionary dictionary];
    
}

-(void)MoreOptionsData_GracePeriod:(NSMutableDictionary *)dictToUse {
    
    BOOL TaskHasGracePeriod = [[[BoolDataObject alloc] init] TaskHasGracePeriod:dictToUse itemType:itemType];
    
    itemGracePeriodTextField.text = dictToUse[@"ItemGracePeriod"] ? dictToUse[@"ItemGracePeriod"] : @"None";
    
    if (TaskHasGracePeriod == YES) {
        
        self->gracePeriodAmountComp =
        dictToUse[@"ItemGracePeriod"] &&
        [dictToUse[@"ItemGracePeriod"] containsString:@" "] &&
        [[dictToUse[@"ItemGracePeriod"] componentsSeparatedByString:@" "] count] > 0 ?
        [dictToUse[@"ItemGracePeriod"] componentsSeparatedByString:@" "][0] : @"";
        
        self->gracePeriodFrequencyComp =
        dictToUse[@"ItemGracePeriod"] &&
        [dictToUse[@"ItemGracePeriod"] containsString:@" "] &&
        [[dictToUse[@"ItemGracePeriod"] componentsSeparatedByString:@" "] count] > 1 ?
        [dictToUse[@"ItemGracePeriod"] componentsSeparatedByString:@" "][1] : @"";
        
        [self GenerateGracePeriodFrequencyArray:[self GenerateItemRepeat]];
        
        [self SelectRowForCompAndArrays:
         @[
            @{@"Array" : self->frequencyGracePeriodAmountArray ? self->frequencyGracePeriodAmountArray : [NSMutableArray array], @"Comp" : self->gracePeriodAmountComp ? self->gracePeriodAmountComp : @""},
            @{@"Array" : self->frequencyGracePeriodFrequencyArray ? self->frequencyGracePeriodFrequencyArray : [NSMutableArray array], @"Comp" : self->gracePeriodFrequencyComp ? self->gracePeriodFrequencyComp : @""}
        ]
                              textField:itemGracePeriodTextField ? itemGracePeriodTextField : [[UITextField alloc] init]];
        
    } else {
        
        [self GenerateGracePeriodFrequencyArray:[self GenerateItemRepeat]];
        
    }
    
}

-(void)MoreOptionsData_PastDue:(NSMutableDictionary *)dictToUse {
    
    self->chosenItemPastDue = dictToUse[@"ItemPastDue"] ? dictToUse[@"ItemPastDue"] : @"2 Days";
    
    
    self->itemPastDueTextField.text = self->chosenItemPastDue;
    
}

-(void)MoreOptionsData_Color:(NSMutableDictionary *)dictToUse {
    
    chosenItemColor = dictToUse[@"ItemColor"] ? dictToUse[@"ItemColor"] : @"";
    itemColorSelectedView.backgroundColor = [[[GeneralObject alloc] init] GenerateColorOptionFromColorString:chosenItemColor];
    
}

-(void)MoreOptionsData_Tags:(NSMutableDictionary *)dictToUse {
    
    itemTagsArrays = dictToUse[@"ItemTags"] ? dictToUse[@"ItemTags"] : [NSMutableArray array];
    
    NSString *tagStr = itemTagsArrays.count == 1 ? @"Tag" : @"Tags";
    itemTagsTextField.text = [NSString stringWithFormat:@"%ld %@", itemTagsArrays.count, tagStr];
    
}

-(void)MoreOptionsData_Priority:(NSMutableDictionary *)dictToUse {
    
    BOOL TaskHasPriority = [[[BoolDataObject alloc] init] TaskHasPriority:dictToUse itemType:itemType];
    
    NSString *itemPriority = dictToUse[@"ItemPriority"] && TaskHasPriority == YES ? dictToUse[@"ItemPriority"] : @"No Priority";
    
    self->itemPriorityTextField.text = itemPriority;
    
    [self SetUpPriorityContextMenu];
    
}

-(void)MoreOptionsData_Difficulty:(NSMutableDictionary *)dictToUse {
    
    BOOL TaskHasDifficulty = [[[BoolDataObject alloc] init] TaskHasDifficulty:dictToUse itemType:itemType];
    
    NSString *itemDifficulty = dictToUse[@"ItemDifficulty"] && TaskHasDifficulty == YES ? dictToUse[@"ItemDifficulty"] : @"No Difficulty";
    
    self->itemDifficultyTextField.text = itemDifficulty;
    
    [self SetUpDifficultyContextMenu];
    
}

-(void)MoreOptionsData_Reward:(NSMutableDictionary *)dictToUse {
    
    itemRewardTextField.text = dictToUse[@"ItemReward"] && dictToUse[@"ItemReward"][@"Reward"] ? dictToUse[@"ItemReward"][@"Reward"] : @"None";
    
    itemRewardDict = dictToUse[@"ItemReward"] ? [dictToUse[@"ItemReward"] mutableCopy] : [NSMutableDictionary dictionary];
    
}

-(void)MoreOptionsData_Private:(NSMutableDictionary *)dictToUse {
    
    BOOL ItemIsPrivate = [[[BoolDataObject alloc] init] TaskIsPrivate:dictToUse itemType:itemType];
    
    [self->itemPrivateSwitch setOn:ItemIsPrivate];
    
}

-(void)MoreOptionsData_ApprovalNeeded:(NSMutableDictionary *)dictToUse {
    
    [self->itemApprovalNeededSwitch setOn:dictToUse[@"ItemApprovalNeeded"] && [dictToUse[@"ItemApprovalNeeded"] isEqualToString:@"Yes"] ? YES : NO];
    self->chosenItemApprovalNeeded = dictToUse[@"ItemApprovalNeeded"] ? dictToUse[@"ItemApprovalNeeded"] : @"";
    
}

#pragma mark - SetDataDict

#pragma mark Chores, Expenses, Lists

-(NSString *)GenerateItemOccurrenceStatus {
    
    NSString *itemOccurrenceStatus = @"None";
    
    if (_editingTask == YES && _duplicatingTask == NO) {
        itemOccurrenceStatus = self->_itemToEditDict[@"ItemOccurrenceStatus"] ? self->_itemToEditDict[@"ItemOccurrenceStatus"] : @"None";
    }
    
    return itemOccurrenceStatus;
}

-(NSString *)GenerateItemImageURL {
    
    NSString *imageURL = [[[GeneralObject alloc] init] GenerateItemImageURL:self->itemType itemUniqueID:self->chosenItemUniqueID];
    
    return imageURL;
}

-(NSString *)GenerateItemDate {
    
    NSString *itemDate = itemDueDateTextField.text;
    
    return itemDate;
}

-(NSString *)GenerateItemDueDate:(NSString *)itemRepeats itemTime:(NSString *)itemTime itemDays:(NSString *)itemDays itemRepeatIfCompletedEarly:(NSString *)itemRepeatIfCompletedEarly itemCompleteAsNeeded:(NSString *)itemCompleteAsNeeded itemDueDatesSkipped:(NSMutableArray *)itemDueDatesSkipped itemDateLastReset:(NSString *)itemDateLastReset {
    
    NSString *itemDueDate = itemDueDateTextField.text;
    NSString *chosenItemRepeatIfCompletedEarlyLocal = chosenItemRepeatIfCompletedEarly ? chosenItemRepeatIfCompletedEarly : @"";
    
    
    
    NSString *itemTimeString = [itemTime length] > 0 ? [NSString stringWithFormat:@" %@", itemTime] : @"";
    
    itemDueDate = [NSString stringWithFormat:@"%@%@", [self GenerateDueDateWithoutWeekday:itemDueDate], itemTimeString];
    itemDueDate = [[[GeneralObject alloc] init] GenerateStringWithReplacementString:itemDueDate stringToReplace:@"Any Time" replacementString:@"11:59 PM"];
    
    
    
    BOOL TaskIsAnOccurrence = (chosenItemOccurrenceID.length > 0 && [chosenItemOccurrenceID isEqualToString:@"xxx"] == NO);
    BOOL TaskHasNoDueDate = [[[BoolDataObject alloc] init] TaskHasNoDueDate:[@{@"ItemDueDate" : itemDueDate, @"ItemSpecificDueDates" : itemSpecificDueDatesArray, @"ItemRepeats" : itemRepeats, @"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal} mutableCopy] itemType:itemType];
    BOOL TaskHasMultipleDueDate =  [[[BoolDataObject alloc] init] TaskHasMultipleDueDate:[@{@"ItemSpecificDueDates" : itemSpecificDueDatesArray, @"ItemRepeats" : itemRepeats, @"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal} mutableCopy] itemType:itemType];
    BOOL TaskIsRepeating = [[[BoolDataObject alloc] init] TaskIsRepeating:[@{@"ItemRepeats" : itemRepeats, @"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal} mutableCopy] itemType:itemType];
    
    
    
    if (TaskIsAnOccurrence == YES) {
        return itemDueDate;
    }
    
    if (TaskHasNoDueDate == YES && TaskIsRepeating == NO) {
        return @"No Due Date";
    }
    
    if (TaskHasMultipleDueDate == YES) {
        return [self GenerateItemDueDate_MultipleDueDates];
    }
    
    if (TaskIsRepeating == YES) {
        return [self GenerateItemDueDate_Repeating:itemRepeats itemTime:itemTime itemDays:itemDays itemRepeatIfCompletedEarly:itemRepeatIfCompletedEarly itemCompleteAsNeeded:itemCompleteAsNeeded itemDueDatesSkipped:itemDueDatesSkipped itemDueDate:itemDueDate itemDateLastReset:itemDateLastReset];
    }
    
    return itemDueDate;
}

-(NSMutableArray *)GenerateItemAssignedTo:(NSString *)itemRandomizeTurnOrder {
    
    NSMutableArray *userIDArray = assignedToIDArray ? [assignedToIDArray mutableCopy] : [NSMutableArray array];
    NSString *itemAssignedToTextFieldText = itemAssignedToTextField.text ? itemAssignedToTextField.text : @"";
    
    BOOL TaskIsAssignedToMyself = ((userIDArray.count == 0 || userIDArray.count == 1) && [itemAssignedToTextFieldText isEqualToString:@"Myself"]);
    
    if (TaskIsAssignedToMyself == YES) {
        userIDArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [@[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] mutableCopy] : [NSMutableArray array];
    }
    
    
    BOOL TaskIsAssignedToAnybody = ([itemAssignedToTextFieldText isEqualToString:@"Anybody"] == YES);
    
    if (TaskIsAssignedToAnybody == YES) {
        userIDArray = userDictForHomeMembers && userDictForHomeMembers[@"UserID"] ? [userDictForHomeMembers[@"UserID"] mutableCopy] : [NSMutableArray array];
    }
    
    
    BOOL TaskIsAssignedToNobody = ([itemAssignedToTextFieldText isEqualToString:@"Nobody"] == YES || [itemAssignedToTextFieldText isEqualToString:@""] == YES);
    
    if (TaskIsAssignedToNobody == YES) {
        userIDArray = [NSMutableArray array];
    }
    
    NSMutableArray *arrayWithoutDuplicates = [[[GeneralObject alloc] init] RemoveDupliatesFromArray:userIDArray];
    
    if ([itemRandomizeTurnOrder isEqualToString:@"Yes"] && arrayWithoutDuplicates.count > 1) {
        
        NSDictionary *dict = [[[SetDataObject alloc] init] UpdateDataResetItemFields_GenerateComplicatedRandomArray:arrayWithoutDuplicates homeMembersDict:_homeMembersDict allItemAssignedToArrays:_allItemAssignedToArrays];
        arrayWithoutDuplicates = dict[@"UserIDArray"] ? [dict[@"UserIDArray"] mutableCopy] : [NSMutableArray array];
        
    }
    
    return arrayWithoutDuplicates;
    
}

-(NSString *)GenerateItemAssignedToNewHomeMembers {
    
    NSString *itemAssignedToNewHomeMembers = self->chosenItemAssignedToNewHomeMembers != NULL ? self->chosenItemAssignedToNewHomeMembers : @"No";
    
    return itemAssignedToNewHomeMembers;
    
}

-(NSString *)GenerateItemAssignedToAnybody {
    
    NSString *itemAssignedToAnybody = [itemAssignedToTextField.text isEqualToString:@"Anybody"] ? @"Yes" : @"No";
    
    return itemAssignedToAnybody;
    
}

-(NSString *)GenerateItemDateLastAlternatedTurns {
    
    NSString *itemDateLastAlternatedTurns = self->_itemToEditDict[@"ItemDateLastAlternatedTurns"] ? self->_itemToEditDict[@"ItemDateLastAlternatedTurns"] : [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:@"MMMM dd, yyyy hh:mm a" returnAs:[NSString class]];
    
    return itemDateLastAlternatedTurns;
    
}

-(NSMutableDictionary *)GenerateItemCompletedDict:(NSMutableArray *)itemAssignedTo itemListItems:(NSMutableDictionary *)itemListItems itemItemizedItems:(NSMutableDictionary *)itemItemizedItems itemCompletedDict:(NSMutableDictionary *)itemCompletedDict itemDatePosted:(NSString *)itemDatePosted itemDueDate:(NSString *)itemDueDate itemRepeats:(NSString *)itemRepeats itemCompleteAsNeeded:(NSString *)itemCompleteAsNeeded itemStartDate:(NSString *)itemStartDate itemTime:(NSString *)itemTime itemDays:(NSString *)itemDays itemDueDatesSkipped:(NSMutableArray *)itemDueDatesSkipped itemTurnUserID:(NSString *)itemTurnUserID {
    
    NSMutableDictionary *itemCompletedDictLocal = [itemCompletedDict mutableCopy];
    NSMutableDictionary *itemItemizedItemsLocal = [itemItemizedItems mutableCopy];
    NSMutableDictionary *itemListItemsLocal = [itemListItems mutableCopy];
    
    NSString *itemTakeTurns = [itemEveryoneTakesTurnsSwitch isOn] ? @"Yes" : @"No";
    
    if (([itemType isEqualToString:@"List"] && [itemTakeTurns isEqualToString:@"No"]) ||
        ([itemType isEqualToString:@"Expense"] && [[itemItemizedItemsLocal allKeys] count] > 0 && [itemTakeTurns isEqualToString:@"No"])) {
        
        NSString *key;
        NSMutableDictionary *dictToUse;
        
        if ([itemType isEqualToString:@"List"] && [itemTakeTurns isEqualToString:@"Yes"]) {
            
            key = @"ItemListItems";
            dictToUse = [itemListItemsLocal mutableCopy];
            
        } else if ([itemType isEqualToString:@"Expense"] && [[itemItemizedItemsLocal allKeys] count] > 0 && [itemTakeTurns isEqualToString:@"Yes"]) {
            
            key = @"ItemItemizedItems";
            dictToUse = [itemItemizedItemsLocal mutableCopy];
            
        }
        
        NSMutableArray *arrayToUse = [[itemCompletedDict allKeys] mutableCopy];
        
        for (NSString *itemName in arrayToUse) {
            
            BOOL OldItemAssignedToSomeone = _editingTask == YES && self->_itemToEditDict[key] && self->_itemToEditDict[key][itemName] && self->_itemToEditDict[key][itemName][@"Assigned To"] && [(NSArray *)self->_itemToEditDict[key][itemName][@"Assigned To"] count] > 0 && [self->_itemToEditDict[key][itemName][@"Assigned To"][0] isEqualToString:@"Anybody"] == NO;
            BOOL NewItemAssignedToSomeone = dictToUse && dictToUse[itemName] && dictToUse[itemName][@"Assigned To"] && [(NSArray *)dictToUse[itemName][@"Assigned To"] count] > 0 && [dictToUse[itemName][@"Assigned To"][0] isEqualToString:@"Anybody"] == NO;
            
            BOOL ItemAssignedToDidntChange = NO;
            
            if (OldItemAssignedToSomeone == YES && NewItemAssignedToSomeone == YES) {
                
                NSString *oldAssignedTo = _editingTask == YES && self->_itemToEditDict[key] && self->_itemToEditDict[key][itemName] && self->_itemToEditDict[key][itemName][@"Assigned To"] && [(NSArray *)self->_itemToEditDict[key][itemName][@"Assigned To"] count] > 0 ? self->_itemToEditDict[key][itemName][@"Assigned To"][0] : @"";
                NSString *newAssignedTo = dictToUse && dictToUse[itemName] && dictToUse[itemName][@"Assigned To"] && [(NSArray *)dictToUse[itemName][@"Assigned To"] count] > 0 ? dictToUse[itemName][@"Assigned To"][0] : @"";
                
                ItemAssignedToDidntChange =
                [oldAssignedTo isEqualToString:newAssignedTo] &&
                [itemAssignedTo containsObject:oldAssignedTo];
                
            } else if (OldItemAssignedToSomeone == NO && NewItemAssignedToSomeone == NO) {
                
                ItemAssignedToDidntChange = YES;
                
            }
            
            if (([[itemListItemsLocal allKeys] containsObject:itemName] == NO && [[itemCompletedDictLocal allKeys] containsObject:itemName]) || ItemAssignedToDidntChange == NO) {
                
                [itemCompletedDictLocal removeObjectForKey:itemName];
                
            }
            
        }
        
    } else if (([itemType isEqualToString:@"List"] && [itemTakeTurns isEqualToString:@"Yes"]) ||
               ([itemType isEqualToString:@"Expense"] && [[itemItemizedItemsLocal allKeys] count] > 0 && [itemTakeTurns isEqualToString:@"Yes"])) {
        
        NSString *key;
        NSMutableDictionary *dictToUse;
        
        if ([itemType isEqualToString:@"List"] && [itemTakeTurns isEqualToString:@"Yes"]) {
            
            key = @"ItemListItems";
            dictToUse = [itemListItemsLocal mutableCopy];
            
        } else if ([itemType isEqualToString:@"Expense"] && [[itemItemizedItemsLocal allKeys] count] > 0 && [itemTakeTurns isEqualToString:@"Yes"]) {
            
            key = @"ItemItemizedItems";
            dictToUse = [itemItemizedItemsLocal mutableCopy];
            
        }
        
        NSString *userIDWhosTurnItIs = itemTurnUserID;
        
        NSMutableArray *arrayToUse = [[itemCompletedDict allKeys] mutableCopy];
        
        for (NSString *itemName in arrayToUse) {
            
            NSString *status = _editingTask == YES && self->_itemToEditDict[key] && self->_itemToEditDict[key][itemName] && self->_itemToEditDict[key][itemName][@"Status"] ? self->_itemToEditDict[key][itemName][@"Status"] : @"";
            
            if ([[itemCompletedDictLocal allKeys] containsObject:status] && [status isEqualToString:userIDWhosTurnItIs] == NO) {
                
                [itemCompletedDictLocal removeObjectForKey:itemName];
                
            }
            
        }
        
    } else if ([itemType isEqualToString:@"List"] == NO && [itemTakeTurns isEqualToString:@"No"]) {
        
        NSMutableArray *arrayToUse = [[itemCompletedDict allKeys] mutableCopy];
        
        for (NSString *userID in arrayToUse) {
            
            if ([itemAssignedTo containsObject:userID] == NO && [[itemCompletedDictLocal allKeys] containsObject:userID]) {
                
                [itemCompletedDictLocal removeObjectForKey:userID];
                
            }
            
        }
        
    } else if ([itemType isEqualToString:@"List"] == NO && [itemTakeTurns isEqualToString:@"Yes"]) {
        
        NSString *userIDWhosTurnItIs = itemTurnUserID;
        
        NSMutableArray *arrayToUse = [[itemCompletedDict allKeys] mutableCopy];
        
        for (NSString *userID in arrayToUse) {
            
            if ([[itemCompletedDictLocal allKeys] containsObject:userID] && [userID isEqualToString:userIDWhosTurnItIs] == NO) {
                
                [itemCompletedDictLocal removeObjectForKey:userID];
                
            }
            
        }
        
    }
    
    if (_duplicatingTask == YES ||
        (_editingTask == YES && [_itemToEditDict[@"ItemRepeats"] isEqualToString:@"As Needed"] && [itemRepeats isEqualToString:@"As Needed"] == NO)) {
        
        itemCompletedDictLocal = [NSMutableDictionary dictionary];
        
    }
    
    return itemCompletedDictLocal;
    
}

-(NSMutableDictionary *)GenerateItemInProgressDict:(NSMutableArray *)itemAssignedTo itemListItems:(NSMutableDictionary *)itemListItems itemItemizedItems:(NSMutableDictionary *)itemItemizedItems itemInProgressDict:(NSMutableDictionary *)itemInProgressDict itemDatePosted:(NSString *)itemDatePosted itemDueDate:(NSString *)itemDueDate itemRepeats:(NSString *)itemRepeats itemCompleteAsNeeded:(NSString *)itemCompleteAsNeeded itemStartDate:(NSString *)itemStartDate itemTime:(NSString *)itemTime itemDays:(NSString *)itemDays itemDueDatesSkipped:(NSMutableArray *)itemDueDatesSkipped itemTurnUserID:(NSString *)itemTurnUserID {
    
    NSMutableDictionary *itemInProgressDictLocal = [itemInProgressDict mutableCopy];
    NSMutableDictionary *itemItemizedItemsLocal = [itemItemizedItems mutableCopy];
    NSMutableDictionary *itemListItemsLocal = [itemListItems mutableCopy];
    
    NSString *itemTakeTurns = [itemEveryoneTakesTurnsSwitch isOn] ? @"Yes" : @"No";
    
    if (([itemType isEqualToString:@"List"] && [itemTakeTurns isEqualToString:@"No"]) ||
        ([itemType isEqualToString:@"Expense"] && [[itemItemizedItemsLocal allKeys] count] > 0 && [itemTakeTurns isEqualToString:@"No"])) {
        
        NSString *key;
        NSMutableDictionary *dictToUse;
        
        if ([itemType isEqualToString:@"List"] && [itemTakeTurns isEqualToString:@"Yes"]) {
            
            key = @"ItemListItems";
            dictToUse = [itemListItemsLocal mutableCopy];
            
        } else if ([itemType isEqualToString:@"Expense"] && [[itemItemizedItemsLocal allKeys] count] > 0 && [itemTakeTurns isEqualToString:@"Yes"]) {
            
            key = @"ItemItemizedItems";
            dictToUse = [itemItemizedItemsLocal mutableCopy];
            
        }
        
        NSMutableArray *arrayToUse = [[itemInProgressDict allKeys] mutableCopy];
        
        for (NSString *itemName in arrayToUse) {
            
            BOOL OldItemAssignedToSomeone = _editingTask == YES && self->_itemToEditDict[key] && self->_itemToEditDict[key][itemName] && self->_itemToEditDict[key][itemName][@"Assigned To"] && [(NSArray *)self->_itemToEditDict[key][itemName][@"Assigned To"] count] > 0 && [self->_itemToEditDict[key][itemName][@"Assigned To"][0] isEqualToString:@"Anybody"] == NO;
            BOOL NewItemAssignedToSomeone = dictToUse && dictToUse[itemName] && dictToUse[itemName][@"Assigned To"] && [(NSArray *)dictToUse[itemName][@"Assigned To"] count] > 0 && [dictToUse[itemName][@"Assigned To"][0] isEqualToString:@"Anybody"] == NO;
            
            BOOL ItemAssignedToDidntChange = NO;
            
            if (OldItemAssignedToSomeone == YES && NewItemAssignedToSomeone == YES) {
                
                NSString *oldAssignedTo = _editingTask == YES && self->_itemToEditDict[key] && self->_itemToEditDict[key][itemName] && self->_itemToEditDict[key][itemName][@"Assigned To"] && [(NSArray *)self->_itemToEditDict[key][itemName][@"Assigned To"] count] > 0 ? self->_itemToEditDict[key][itemName][@"Assigned To"][0] : @"";
                NSString *newAssignedTo = dictToUse && dictToUse[itemName] && dictToUse[itemName][@"Assigned To"] && [(NSArray *)dictToUse[itemName][@"Assigned To"] count] > 0 ? dictToUse[itemName][@"Assigned To"][0] : @"";
                
                ItemAssignedToDidntChange =
                [oldAssignedTo isEqualToString:newAssignedTo] &&
                [itemAssignedTo containsObject:oldAssignedTo];
                
            } else if (OldItemAssignedToSomeone == NO && NewItemAssignedToSomeone == NO) {
                
                ItemAssignedToDidntChange = YES;
                
            }
            
            if (([[itemListItemsLocal allKeys] containsObject:itemName] == NO && [[itemInProgressDictLocal allKeys] containsObject:itemName]) || ItemAssignedToDidntChange == NO) {
                
                [itemInProgressDictLocal removeObjectForKey:itemName];
                
            }
            
        }
        
    } else if (([itemType isEqualToString:@"List"] && [itemTakeTurns isEqualToString:@"Yes"]) ||
               ([itemType isEqualToString:@"Expense"] && [[itemItemizedItemsLocal allKeys] count] > 0 && [itemTakeTurns isEqualToString:@"Yes"])) {
        
        NSString *key;
        NSMutableDictionary *dictToUse;
        
        if ([itemType isEqualToString:@"List"] && [itemTakeTurns isEqualToString:@"Yes"]) {
            
            key = @"ItemListItems";
            dictToUse = [itemListItemsLocal mutableCopy];
            
        } else if ([itemType isEqualToString:@"Expense"] && [[itemItemizedItemsLocal allKeys] count] > 0 && [itemTakeTurns isEqualToString:@"Yes"]) {
            
            key = @"ItemItemizedItems";
            dictToUse = [itemItemizedItemsLocal mutableCopy];
            
        }
        
        NSString *userIDWhosTurnItIs = itemTurnUserID;
        
        NSMutableArray *arrayToUse = [[itemInProgressDict allKeys] mutableCopy];
        
        for (NSString *itemName in arrayToUse) {
            
            NSString *status = _editingTask == YES && self->_itemToEditDict[key] && self->_itemToEditDict[key][itemName] && self->_itemToEditDict[key][itemName][@"Status"] ? self->_itemToEditDict[key][itemName][@"Status"] : @"";
            
            if ([[itemInProgressDictLocal allKeys] containsObject:status] && [status isEqualToString:userIDWhosTurnItIs] == NO) {
                
                [itemInProgressDictLocal removeObjectForKey:itemName];
                
            }
            
        }
        
    } else if ([itemType isEqualToString:@"List"] == NO && [itemTakeTurns isEqualToString:@"No"]) {
        
        NSMutableArray *arrayToUse = [[itemInProgressDict allKeys] mutableCopy];
        
        for (NSString *userID in arrayToUse) {
            
            if ([itemAssignedTo containsObject:userID] == NO && [[itemInProgressDictLocal allKeys] containsObject:userID]) {
                
                [itemInProgressDictLocal removeObjectForKey:userID];
                
            }
            
        }
        
    } else if ([itemType isEqualToString:@"List"] == NO && [itemTakeTurns isEqualToString:@"Yes"]) {
        
        NSString *userIDWhosTurnItIs = itemTurnUserID;
        
        NSMutableArray *arrayToUse = [[itemInProgressDict allKeys] mutableCopy];
        
        for (NSString *userID in arrayToUse) {
            
            if ([[itemInProgressDictLocal allKeys] containsObject:userID] && [userID isEqualToString:userIDWhosTurnItIs] == NO) {
                
                [itemInProgressDictLocal removeObjectForKey:userID];
                
            }
            
        }
        
    }
    
    if (_duplicatingTask == YES) {
        
        itemInProgressDictLocal = [NSMutableDictionary dictionary];
        
    }
    
    return itemInProgressDictLocal;
    
}

-(NSMutableDictionary *)GenerateItemWontDoDict:(NSMutableArray *)itemAssignedTo itemListItems:(NSMutableDictionary *)itemListItems itemItemizedItems:(NSMutableDictionary *)itemItemizedItems itemWontDo:(NSMutableDictionary *)itemWontDo itemDatePosted:(NSString *)itemDatePosted itemDueDate:(NSString *)itemDueDate itemRepeats:(NSString *)itemRepeats itemCompleteAsNeeded:(NSString *)itemCompleteAsNeeded itemStartDate:(NSString *)itemStartDate itemTime:(NSString *)itemTime itemDays:(NSString *)itemDays itemDueDatesSkipped:(NSMutableArray *)itemDueDatesSkipped itemTurnUserID:(NSString *)itemTurnUserID {
    
    NSMutableDictionary *itemWontDoDictLocal = [itemWontDoDict mutableCopy];
    NSMutableDictionary *itemItemizedItemsLocal = [itemItemizedItems mutableCopy];
    NSMutableDictionary *itemListItemsLocal = [itemListItems mutableCopy];
    
    NSString *itemTakeTurns = [itemEveryoneTakesTurnsSwitch isOn] ? @"Yes" : @"No";
    
    if (([itemType isEqualToString:@"List"] && [itemTakeTurns isEqualToString:@"No"]) ||
        ([itemType isEqualToString:@"Expense"] && [[itemItemizedItemsLocal allKeys] count] > 0 && [itemTakeTurns isEqualToString:@"No"])) {
        
        NSString *key;
        NSMutableDictionary *dictToUse;
        
        if ([itemType isEqualToString:@"List"] && [itemTakeTurns isEqualToString:@"Yes"]) {
            
            key = @"ItemListItems";
            dictToUse = [itemListItemsLocal mutableCopy];
            
        } else if ([itemType isEqualToString:@"Expense"] && [[itemItemizedItemsLocal allKeys] count] > 0 && [itemTakeTurns isEqualToString:@"Yes"]) {
            
            key = @"ItemItemizedItems";
            dictToUse = [itemItemizedItemsLocal mutableCopy];
            
        }
        
        NSMutableArray *arrayToUse = [[itemWontDoDict allKeys] mutableCopy];
        
        for (NSString *itemName in arrayToUse) {
            
            BOOL OldItemAssignedToSomeone = _editingTask == YES && self->_itemToEditDict[key] && self->_itemToEditDict[key][itemName] && self->_itemToEditDict[key][itemName][@"Assigned To"] && [(NSArray *)self->_itemToEditDict[key][itemName][@"Assigned To"] count] > 0 && [self->_itemToEditDict[key][itemName][@"Assigned To"][0] isEqualToString:@"Anybody"] == NO;
            BOOL NewItemAssignedToSomeone = dictToUse && dictToUse[itemName] && dictToUse[itemName][@"Assigned To"] && [(NSArray *)dictToUse[itemName][@"Assigned To"] count] > 0 && [dictToUse[itemName][@"Assigned To"][0] isEqualToString:@"Anybody"] == NO;
            
            BOOL ItemAssignedToDidntChange = NO;
            
            if (OldItemAssignedToSomeone == YES && NewItemAssignedToSomeone == YES) {
                
                NSString *oldAssignedTo = _editingTask == YES && self->_itemToEditDict[key] && self->_itemToEditDict[key][itemName] && self->_itemToEditDict[key][itemName][@"Assigned To"] && [(NSArray *)self->_itemToEditDict[key][itemName][@"Assigned To"] count] > 0 ? self->_itemToEditDict[key][itemName][@"Assigned To"][0] : @"";
                NSString *newAssignedTo = dictToUse && dictToUse[itemName] && dictToUse[itemName][@"Assigned To"] && [(NSArray *)dictToUse[itemName][@"Assigned To"] count] > 0 ? dictToUse[itemName][@"Assigned To"][0] : @"";
                
                ItemAssignedToDidntChange =
                [oldAssignedTo isEqualToString:newAssignedTo] &&
                [itemAssignedTo containsObject:oldAssignedTo];
                
            } else if (OldItemAssignedToSomeone == NO && NewItemAssignedToSomeone == NO) {
                
                ItemAssignedToDidntChange = YES;
                
            }
            
            if (([[itemListItemsLocal allKeys] containsObject:itemName] == NO && [[itemWontDoDictLocal allKeys] containsObject:itemName]) || ItemAssignedToDidntChange == NO) {
                
                [itemWontDoDictLocal removeObjectForKey:itemName];
                
            }
            
        }
        
    } else if (([itemType isEqualToString:@"List"] && [itemTakeTurns isEqualToString:@"Yes"]) ||
               ([itemType isEqualToString:@"Expense"] && [[itemItemizedItemsLocal allKeys] count] > 0 && [itemTakeTurns isEqualToString:@"Yes"])) {
        
        NSString *key;
        NSMutableDictionary *dictToUse;
        
        if ([itemType isEqualToString:@"List"] && [itemTakeTurns isEqualToString:@"Yes"]) {
            
            key = @"ItemListItems";
            dictToUse = [itemListItemsLocal mutableCopy];
            
        } else if ([itemType isEqualToString:@"Expense"] && [[itemItemizedItemsLocal allKeys] count] > 0 && [itemTakeTurns isEqualToString:@"Yes"]) {
            
            key = @"ItemItemizedItems";
            dictToUse = [itemItemizedItemsLocal mutableCopy];
            
        }
        
        NSString *userIDWhosTurnItIs = itemTurnUserID;
        
        NSMutableArray *arrayToUse = [[itemWontDoDict allKeys] mutableCopy];
        
        for (NSString *itemName in arrayToUse) {
            
            NSString *status = _editingTask == YES && self->_itemToEditDict[key] && self->_itemToEditDict[key][itemName] && self->_itemToEditDict[key][itemName][@"Status"] ? self->_itemToEditDict[key][itemName][@"Status"] : @"";
            
            if ([[itemWontDoDictLocal allKeys] containsObject:status] && [status isEqualToString:userIDWhosTurnItIs] == NO) {
                
                [itemWontDoDictLocal removeObjectForKey:itemName];
                
            }
            
        }
        
    } else if ([itemType isEqualToString:@"List"] == NO && [itemTakeTurns isEqualToString:@"No"]) {
        
        NSMutableArray *arrayToUse = [[itemWontDoDict allKeys] mutableCopy];
        
        for (NSString *userID in arrayToUse) {
            
            if ([itemAssignedTo containsObject:userID] == NO && [[itemWontDoDictLocal allKeys] containsObject:userID]) {
                
                [itemWontDoDictLocal removeObjectForKey:userID];
                
            }
            
        }
        
    } else if ([itemType isEqualToString:@"List"] == NO && [itemTakeTurns isEqualToString:@"Yes"]) {
        
        NSString *userIDWhosTurnItIs = itemTurnUserID;
        
        NSMutableArray *arrayToUse = [[itemWontDoDict allKeys] mutableCopy];
        
        for (NSString *userID in arrayToUse) {
            
            if ([[itemWontDoDictLocal allKeys] containsObject:userID] && [userID isEqualToString:userIDWhosTurnItIs] == NO) {
                
                [itemWontDoDictLocal removeObjectForKey:userID];
                
            }
            
        }
        
    }
    
    if (_duplicatingTask == YES) {
        
        itemWontDoDictLocal = [NSMutableDictionary dictionary];
        
    }
    
    return itemWontDoDictLocal;
}

-(NSString *)GenerateItemTime:(NSString *)itemDays itemRepeats:(NSString *)itemRepeats itemDueDate:(NSString *)itemDueDate {
    
    NSString *chosenItemRepeatIfCompletedEarlyLocal = chosenItemRepeatIfCompletedEarly ? chosenItemRepeatIfCompletedEarly : @"";
    
    BOOL TaskHasMultipleDueDate =  [[[BoolDataObject alloc] init] TaskHasMultipleDueDate:[@{@"ItemSpecificDueDates" : itemSpecificDueDatesArray, @"ItemRepeats" : itemRepeats, @"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal} mutableCopy] itemType:itemType];
    BOOL TaskHasNoDueDate = [[[BoolDataObject alloc] init] TaskHasNoDueDate:[@{@"ItemDueDate" : itemDueDate, @"ItemSpecificDueDates" : itemSpecificDueDatesArray, @"ItemRepeats" : itemRepeats, @"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal} mutableCopy] itemType:itemType];
    BOOL TaskIsRepeating = [[[BoolDataObject alloc] init] TaskIsRepeating:[@{@"ItemRepeats" : itemRepeats, @"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal} mutableCopy] itemType:itemType];
    BOOL TaskIsRepeatingDaily = [[[BoolDataObject alloc] init] TaskIsRepeatingDaily:[@{@"ItemRepeats" : itemRepeats, @"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal} mutableCopy] itemType:itemType];
    BOOL TaskIsRepeatingWeekly = [[[BoolDataObject alloc] init] TaskIsRepeatingWeekly:[@{@"ItemRepeats" : itemRepeats, @"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal} mutableCopy] itemType:itemType];
    BOOL TaskIsRepeatingMonthly = [[[BoolDataObject alloc] init] TaskIsRepeatingMonthly:[@{@"ItemRepeats" : itemRepeats, @"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal} mutableCopy] itemType:itemType];
    
    NSString *itemTimeString = itemTimeTextField.text;
    
    if ((TaskIsRepeating == NO && (TaskHasNoDueDate == YES || TaskHasMultipleDueDate == YES)) ||
        (TaskIsRepeating == YES && TaskIsRepeatingDaily == NO && TaskIsRepeatingWeekly == NO && TaskIsRepeatingMonthly == NO)) {
        return @"";
    }
    
    if ((TaskIsRepeating == YES && (TaskIsRepeatingWeekly == YES || TaskIsRepeatingMonthly == YES) && [itemDays containsString:@"Any Day"]) ||
        (TaskIsRepeating == YES && (TaskIsRepeatingDaily == YES || TaskIsRepeatingWeekly == YES || TaskIsRepeatingMonthly == YES) && [itemTimeString isEqualToString:@""])) {
        return @"Any Time";
    }
    
    return itemTimeString;
}

-(NSMutableDictionary *)GenerateItemAdditionalReminders:(NSMutableArray *)itemAssignedTo {
    
    NSMutableDictionary *itemAdditionalReminders = [NSMutableDictionary dictionary];
    
    if (self->_itemToEditDict[@"ItemAdditionalReminders"]) {
        itemAdditionalReminders = [self->_itemToEditDict[@"ItemAdditionalReminders"] mutableCopy];
    }
    
    if (assignedToIDArray == NULL || assignedToIDArray == nil) {
        assignedToIDArray = [NSMutableArray array];
    }
    
    BOOL TaskIsAssignedToNobody = [[[BoolDataObject alloc] init] TaskIsAssignedToNobody:[@{@"ItemAssignedTo" : assignedToIDArray} mutableCopy] itemType:itemType];
    
    if (TaskIsAssignedToNobody == NO) {
        
        NSMutableDictionary *itemAdditionalRemindersCopy = [itemAdditionalReminders mutableCopy];
        
        for (NSString *key in [itemAdditionalRemindersCopy allKeys]) {
            
            if ([itemAssignedTo containsObject:key] == NO) {
                
                [itemAdditionalReminders removeObjectForKey:key];
                
            }
            
        }
        
    }
    
    return itemAdditionalReminders;
}

-(NSDictionary *)GenerateItemReminder:(NSString *)itemDueDate itemRepeats:(NSString *)itemRepeats itemTime:(NSString *)itemTime SettingData:(BOOL)SettingData {
    
    NSString *chosenItemRepeatIfCompletedEarlyLocal = chosenItemRepeatIfCompletedEarly ? chosenItemRepeatIfCompletedEarly : @"";
    
    NSMutableDictionary *itemDictToReturn = [itemReminderDict mutableCopy];
    
    BOOL TaskIsRepeating = [[[BoolDataObject alloc] init] TaskIsRepeating:[@{@"ItemRepeats" : itemRepeats, @"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal} mutableCopy] itemType:itemType];
    BOOL TaskHasNoDueDate = [[[BoolDataObject alloc] init] TaskHasNoDueDate:[@{@"ItemDueDate" : itemDueDate, @"ItemSpecificDueDates" : itemSpecificDueDatesArray, @"ItemRepeats" : itemRepeats, @"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal} mutableCopy] itemType:itemType];
    BOOL TaskHasAnyTime = [itemTime isEqualToString:@"Any Time"];
    
    if (TaskIsRepeating == NO && TaskHasNoDueDate == YES) {
        
        return [NSMutableDictionary dictionary];
        
    }
    
    BOOL ItemReminderHasNormalReminders = NO;
    BOOL ItemReminderHasAnyTimeReminders = NO;
    
    for (NSString *itemReminder in [itemReminderDict allKeys]) {
        
        BOOL IsKindOfNSStringClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:itemReminderDict[itemReminder] classArr:@[[NSString class]]];
        
        if (itemReminderDict[itemReminder] && IsKindOfNSStringClass == NO && itemReminderDict[itemReminder][@"Option"]) {
            ItemReminderHasNormalReminders = YES;
        } else {
            ItemReminderHasAnyTimeReminders = YES;
        }
    }
    
    if (SettingData == NO) {
        
        if (TaskHasAnyTime == NO && ItemReminderHasNormalReminders == NO) {
            itemDictToReturn = [[[[GeneralObject alloc] init] GenerateDefaultRemindersDict:itemType itemAssignedTo:self->assignedToIDArray itemRepeats:itemRepeats homeMembersDict:_homeMembersDict AnyTime:NO] mutableCopy];
        } else if (TaskHasAnyTime == YES && ItemReminderHasAnyTimeReminders == NO) {
            itemDictToReturn = [[[[GeneralObject alloc] init] GenerateDefaultRemindersDict:itemType itemAssignedTo:self->assignedToIDArray itemRepeats:itemRepeats homeMembersDict:_homeMembersDict AnyTime:YES] mutableCopy];
        }
        
    }
    
    //Remove Day Before Reminder If Daily
    if (TaskHasAnyTime == YES && ([itemRepeats isEqualToString:@"Daily"] || [itemRepeats containsString:@"Hour"]) && [[itemDictToReturn allKeys] count] > 1) {
        for (NSString *itemReminder in [[itemDictToReturn allKeys] mutableCopy]) {
            if ([itemReminder containsString:@"Day Before"] || [itemReminder containsString:@"Days Before"]) {
                [itemDictToReturn removeObjectForKey:itemReminder];
            }
        }
    }
    
    return itemDictToReturn;
}

-(NSString *)GenerateItemDifficulty {
    
    if (itemDifficultyTextField.text.length == 0) {
        return @"No Difficulty";
    }
    
    return itemDifficultyTextField.text;
    
}

-(NSString *)GenerateItemPriority {
    
    if (itemPriorityTextField.text.length == 0) {
        return @"No Priority";
    }
    
    return itemPriorityTextField.text;
    
}

-(NSString *)GenerateItemColor {
    
    if (chosenItemColor.length == 0 || [chosenItemColor containsString:@"(null)"] || chosenItemColor == nil) {
        chosenItemColor = @"None";
    }
    
    return chosenItemColor;
    
}

-(NSString *)GenerateItemPrivate {
    
    if ([itemPrivateSwitch isOn] == YES) {
        return @"Yes";
    }
    
    return @"No";
}

-(NSMutableDictionary *)GenerateItemReward {
    
    NSMutableDictionary *itemRewardDictLocal = [itemRewardDict mutableCopy];
    
    if (itemRewardDictLocal == NULL || itemRewardDictLocal[@"Reward"] == NULL) {
        itemRewardDictLocal = [@{@"Reward" : @"None", @"RewardDescription" : @"", @"RewardNotes" : @""} mutableCopy];
    }
    
    return itemRewardDictLocal;
}

-(NSString *)GenerateItemNotes {
    
    NSString *notesString = itemNotesTextField.text;
    itemType = [[[GeneralObject alloc] init] GenerateItemType];
    
    notesString = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:notesString arrayOfSymbols:@[@"Notes"]];
    
    NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
    NSString *trimmedStringItemNotes = [notesString stringByTrimmingCharactersInSet:charSet];
    
    if (trimmedStringItemNotes.length == 0) {
        notesString = @"";
    }
    
    return notesString;
    
}

-(NSString *)GenerateItemDays:(NSString *)itemRepeats {
    
    NSString *chosenItemRepeatIfCompletedEarlyLocal = chosenItemRepeatIfCompletedEarly ? chosenItemRepeatIfCompletedEarly : @"";
    
    NSString *itemDaysString = itemDaysTextField.text;
    
    BOOL TaskIsRepeating = [[[BoolDataObject alloc] init] TaskIsRepeating:[@{@"ItemRepeats" : itemRepeats, @"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal} mutableCopy] itemType:itemType];
    BOOL TaskIsRepeatingWeekly = [[[BoolDataObject alloc] init] TaskIsRepeatingWeekly:[@{@"ItemRepeats" : itemRepeats} mutableCopy] itemType:itemType];
    BOOL TaskIsRepeatingMonthly = [[[BoolDataObject alloc] init] TaskIsRepeatingMonthly:[@{@"ItemRepeats" : itemRepeats} mutableCopy] itemType:itemType];
    BOOL TaskIsRepeatingAndRepeatingIfCompletedEarly = [[[BoolDataObject alloc] init] TaskIsRepeatingAndRepeatingIfCompletedEarly:[@{@"ItemRepeats" : itemRepeats} mutableCopy] itemType:itemType];
    
    if (TaskIsRepeating == NO || (TaskIsRepeating == YES && TaskIsRepeatingWeekly == NO && TaskIsRepeatingMonthly == NO)) {
        return @"";
    } else if ((TaskIsRepeating == YES && (TaskIsRepeatingWeekly == YES || TaskIsRepeatingMonthly == YES) && itemDaysString.length == 0) ||
               (TaskIsRepeatingAndRepeatingIfCompletedEarly == YES && (TaskIsRepeatingWeekly == YES || TaskIsRepeatingMonthly == YES))) {
        itemDaysString = @"Any Day";
    }
    
    return itemDaysString;
    
}

-(NSString *)GenerateItemStartDate:(NSString *)itemRepeats itemDatePosted:(NSString *)itemDatePosted {
    
    BOOL TaskIsRepeating = [[[BoolDataObject alloc] init] TaskIsRepeating:[@{@"ItemRepeats" : itemRepeats} mutableCopy] itemType:self->itemType];
    
    if (TaskIsRepeating == NO || [itemStartDateTextField.text isEqualToString:@""]) {
        return @"";
    }
    
    NSString *chosenItemRepeatIfCompletedEarlyLocal = chosenItemRepeatIfCompletedEarly ? chosenItemRepeatIfCompletedEarly : @"";
    
    NSString *startDate = itemStartDateTextField.text;
    NSString *dateFormat = @"MMMM dd, yyyy";
    
    if ([startDate isEqualToString:@"Now"]) {
        startDate = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:@"MMMM dd, yyyy" returnAs:[NSString class]];
    }
    
    if ([[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:startDate returnAs:[NSDate class]] == nil && startDate.length != 0 && [startDate isEqualToString:@"Now"] == NO) {
        dateFormat = @"MMMM dd, yyyy";
    }
    
    if (startDate.length == 0 || [startDate isEqualToString:@"Now"] || [[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:startDate returnAs:[NSDate class]] == nil) {
        
        startDate = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:dateFormat returnAs:[NSString class]];
        
    }
    
    NSArray *dateArr = [startDate componentsSeparatedByString:@" "];
    
    NSString *month = [dateArr count] > 0 ? dateArr[0] : @"";
    NSString *day = [dateArr count] > 1 ? dateArr[1] : @"";
    NSString *year = [dateArr count] > 2 ? dateArr[2] : @"";
    
    BOOL TaskIsRepeatingHourly = [[[BoolDataObject alloc] init] TaskIsRepeatingHourly:[@{@"ItemRepeats" : itemRepeats, @"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal} mutableCopy] itemType:itemType];
    
    if (TaskIsRepeatingHourly == YES && itemDatePosted.length > 0 && [itemDatePosted containsString:@" "]) {
        
        NSString *dateFormat = @"yyyy-MM-dd HH:mm:ss";
        
        if ([[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:itemDatePosted returnAs:[NSDate class]] == nil) {
            itemDatePosted = [[[GeneralObject alloc] init] GenerateDateWithConvertedFormatWithFormat:@"MMMM dd, yyyy hh:mm a" dateToConvert:itemDatePosted newFormat:dateFormat returnAs:[NSString class]];
        }
        
        NSArray *datePostedArr = [itemDatePosted componentsSeparatedByString:@" "];
        
        if ([datePostedArr count] > 1) {
            
            NSString *datePostedTime = datePostedArr[1];
            NSString *datePostedTimeCoverted = [[[GeneralObject alloc] init] GenerateDateWithConvertedFormatWithFormat:@"HH:mm:ss" dateToConvert:datePostedTime newFormat:@"hh:mm a" returnAs:[NSString class]];
            
            startDate = [NSString stringWithFormat:@"%@ %@ %@ %@", month, day, year, datePostedTimeCoverted];
            
        } else {
            
            startDate = [NSString stringWithFormat:@"%@ %@ %@ 12:00 AM", month, day, year];
            
        }
        
    } else {
        
        startDate = [NSString stringWithFormat:@"%@ %@ %@ 12:00 AM", month, day, year];
        
    }
    
    return startDate;
    
}

-(NSString *)GenerateItemEndDate:(NSString *)itemRepeats {
    
    BOOL TaskIsRepeating = [[[BoolDataObject alloc] init] TaskIsRepeating:[@{@"ItemRepeats" : itemRepeats} mutableCopy] itemType:self->itemType];
    
    if (TaskIsRepeating == NO) {
        return @"";
    }
    
    NSString *endDate = itemEndDateTextField.text;
    NSString *dateFormat = @"MMMM dd, yyyy";
    
    if ([[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:endDate returnAs:[NSDate class]] == nil && endDate.length != 0 && [endDate isEqualToString:@"Never"] == NO) {
        dateFormat = @"MMMM dd, yyyy";
    }
    
    if (endDate.length != 0 && [endDate isEqualToString:@"Never"] == NO && [[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:endDate returnAs:[NSDate class]] != nil) {
        
        NSArray *dateArr = [endDate componentsSeparatedByString:@" "];
        
        NSString *month = [dateArr count] > 0 ? dateArr[0] : @"";
        NSString *day = [dateArr count] > 1 ? dateArr[1] : @"";
        NSString *year = [dateArr count] > 2 ? dateArr[2] : @"";
        
        endDate = [NSString stringWithFormat:@"%@ %@ %@ 11:59 PM", month, day, year];
        
    }
    
    return endDate;
    
}

-(NSString *)GenerateItemEndNumberOfTimes:(NSString *)itemEndDate {
    
    NSString *itemEndNumberOfTimes = [itemEndDate containsString:@" Time"] ? @"Yes" : @"No";
    
    return itemEndNumberOfTimes;
    
}

-(NSString *)GenerateItemRandomizeTurnOrder {
    
    NSString *itemRandomizeTurnOrder = @"No";
    
    if ([itemTurnOrderTextField.text isEqualToString:@"Randomize"]) {
        
        itemRandomizeTurnOrder = @"Yes";
        
    }
    
    return itemRandomizeTurnOrder;
}

-(NSString *)GenerateItemRepeat {
    
    NSString *itemRepeat = itemRepeatsTextField.text;
    
    return itemRepeat;
}

-(NSString *)GenerateItemRepeatIfCompletedEarly {
    
    if ([itemRepeatIfCompletedEarlySwitch isOn] == NO ||
        [itemRepeatsTextField.text isEqualToString:@"Never"] == YES ||
        [itemRepeatsTextField.text isEqualToString:@"As Needed"] == YES ||
        [itemRepeatsTextField.text isEqualToString:@"When Completed"] == YES) {
        chosenItemRepeatIfCompletedEarly = @"No";
    }
    
    NSString *itemRepeatIfCompletedEarly = chosenItemRepeatIfCompletedEarly ? chosenItemRepeatIfCompletedEarly : @"No";
    
    return itemRepeatIfCompletedEarly;
}

-(NSString *)GenerateItemTakeTurns:(NSMutableArray *)itemAssignedTo itemRepeats:(NSString *)itemRepeats {
    
    NSString *itemRepeatsTextFieldText = self->itemRepeatsTextField.text ? self->itemRepeatsTextField.text : @"";
    NSString *chosenItemRepeatIfCompletedEarlyLocal = chosenItemRepeatIfCompletedEarly ? chosenItemRepeatIfCompletedEarly : @"";
    
    BOOL TaskIsRepeating = [[[BoolDataObject alloc] init] TaskIsRepeating:[@{@"ItemRepeats" : itemRepeats, @"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal} mutableCopy] itemType:itemType];
    BOOL TaskIsRepeatingWhenCompleted = [[[BoolDataObject alloc] init] TaskIsRepeatingWhenCompleted:[@{@"ItemRepeats" : itemRepeats, @"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal} mutableCopy] itemType:itemType];
    BOOL TaskIsRepeatingAsNeeded = [[[BoolDataObject alloc] init] TaskIsRepeatingAsNeeded:[@{@"ItemRepeats" : itemRepeatsTextFieldText, @"ItemRepeatIfCompletedEarly" : chosenItemRepeatIfCompletedEarlyLocal} mutableCopy] itemType:itemType];
    
    if ([itemEveryoneTakesTurnsSwitch isOn] == YES && (TaskIsRepeating == YES || TaskIsRepeatingWhenCompleted == YES || TaskIsRepeatingAsNeeded == YES) && itemAssignedTo.count > 0) {
        return @"Yes";
    }
    
    return @"No";
}

-(NSString *)GenerateItemAlternateTurns:(NSString *)itemTakeTurns {
    
    NSString *itemAlternateTurns = itemAlternateTurnsTextField.text;
    
    if ([itemTakeTurns isEqualToString:@"Yes"] == NO) {
        itemAlternateTurns = @"";
    }
    
    return itemAlternateTurns;
}

-(NSString *)GenerateItemGracePeriod:(NSString *)itemRepeats {
    
    NSString *itemGracePeriod = itemGracePeriodTextField.text;
    
    return itemGracePeriod;
}

-(NSString *)GenerateItemCompleteAsNeeded:(NSString *)itemRepeats {
    
    NSString *itemRepeatsTextFieldText = self->itemRepeatsTextField.text ? self->itemRepeatsTextField.text : @"";
    
    BOOL TaskIsRepeatingAsNeeded = [[[BoolDataObject alloc] init] TaskIsRepeatingAsNeeded:[@{@"ItemRepeats" : itemRepeatsTextFieldText} mutableCopy] itemType:itemType];
    
    NSString *itemCompleteAsNeeded = TaskIsRepeatingAsNeeded ? @"Yes" : @"No";
    
    if ([itemRepeats isEqualToString:@"Never"] == NO && [itemRepeats isEqualToString:@"One-Time"] == NO && [itemRepeats isEqualToString:@"As Needed"] == NO) {
        itemCompleteAsNeeded = @"No";
    }
    
    return itemCompleteAsNeeded;
}

-(NSString *)GenerateItemDateLastReset {
    
    NSString *itemDateLastReset = self->_itemToEditDict[@"ItemDateLastReset"] ? self->_itemToEditDict[@"ItemDateLastReset"] : [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat: @"MMMM dd, yyyy hh:mm a" returnAs:[NSString class]];
   
    //Use To Test Updating Due Dates - Search this string to find sister code
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"TestDueDateIsSet"] isEqualToString:@"Yes"]) {
        itemDateLastReset = [[NSUserDefaults standardUserDefaults] objectForKey:@"TestDueDate"];
    }
    
    return itemDateLastReset;
}

-(NSString *)GenerateItemStatus {
    
    NSString *itemStatus = @"None";
    
    if (_editingTask == YES && _duplicatingTask == NO) {
        itemStatus = self->_itemToEditDict[@"ItemStatus"] ? self->_itemToEditDict[@"ItemStatus"] : @"";
    }
    
    return itemStatus;
}

-(NSMutableArray *)GenerateItemDueDatesSkipped {
    
    return itemDueDatesSkippedArray;
    
}

-(NSString *)GenerateItemPastDue:(NSString *)itemTakeTurns itemDueDate:(NSString *)itemDueDate {
    
    NSString *itemPastDue = itemPastDueTextField.text;
    
    if ([itemTakeTurns isEqualToString:@"Yes"] || [itemDueDate isEqualToString:@"No Due Date"]) {
        itemPastDue = @"Never";
    }
    
    return itemPastDueTextField.text;
}

-(NSMutableDictionary *)GenerateItemOccurrencePastDue {
  
    NSMutableDictionary *itemOccurrencePastDue = self->_itemToEditDict[@"ItemOccurrencePastDue"] ? self->_itemToEditDict[@"ItemOccurrencePastDue"] : [NSMutableDictionary dictionary];
  
    return itemOccurrencePastDue;
}

-(NSMutableArray *)GenerateItemTags {
    
    NSMutableArray *itemTags = itemTagsArrays ? itemTagsArrays : [NSMutableArray array];
    
    return itemTags;
}

-(NSString *)GenerateItemTrash {
    
    NSString *itemTrash = self->_itemToEditDict[@"ItemTrash"] ? self->_itemToEditDict[@"ItemTrash"] : @"No";
    
    return itemTrash;
    
}

-(NSString *)GenerateItemSuggestedID {
    
    NSString *itemSuggestedID = self->_itemToEditDict[@"ItemSuggestedID"] ? self->_itemToEditDict[@"ItemSuggestedID"] : @"";
    
    if (_addingSuggestedTask) {
        itemSuggestedID = _suggestedItemToAddDict[@"ItemID"];
    }
    
    return itemSuggestedID;
}

-(NSString *)GenerateItemAddedLocation {
    
    NSString *itemAddedLocation = @"AddTaskViewController";
    
    if (_addingMultipleTasks) {
        itemAddedLocation = @"MultiAddTasksViewController";
    }
    
    return itemAddedLocation;
}

-(NSString *)GenerateItemDeleted {
    
    NSString *itemDeleted = self->_itemToEditDict[@"ItemDeleted"] ? self->_itemToEditDict[@"ItemDeleted"] : @"No";
    
    return itemDeleted;
}

-(NSString *)GenerateItemPinned {
    
    NSString *itemPinned = self->_itemToEditDict[@"ItemPinned"] ? self->_itemToEditDict[@"ItemPinned"] : @"No";
    
    return itemPinned;
}

-(NSString *)GenerateItemTurnUserID:(NSMutableArray *)itemAssignedTo itemTakeTurns:(NSString *)itemTakeTurns itemDueDate:(NSString *)itemDueDate itemRepeats:(NSString *)itemRepeats itemRepeatIfCompletedEarly:(NSString *)itemRepeatIfCompletedEarly itemCompleteAsNeeded:(NSString *)itemCompleteAsNeeded itemCompletedDict:(NSMutableDictionary *)itemCompletedDict {
    
    NSMutableArray *itemAssignedToOriginal = self->_itemToEditDict[@"ItemAssignedTo"] ?  [self->_itemToEditDict[@"ItemAssignedTo"] mutableCopy] : [itemAssignedTo mutableCopy];
    
    NSString *itemTurnUserID = @"";
    
    if ([itemTakeTurns isEqualToString:@"Yes"]) {
        
        if (!_itemToEditDict[@"ItemTurnUserID"]) {
            
            itemTurnUserID = [[[GeneralObject alloc] init] GenerateNextUsersTurn:itemAssignedTo itemAssignedToOriginal:itemAssignedToOriginal homeMembersDict:self->_homeMembersDict itemTakeTurns:itemTakeTurns itemTurnUserID:@""];
            
        } else if (self->_itemToEditDict[@"ItemTurnUserID"] && [itemAssignedTo containsObject:self->_itemToEditDict[@"ItemTurnUserID"]] && [itemAssignedToOriginal containsObject:self->_itemToEditDict[@"ItemTurnUserID"]]) {
            
            itemTurnUserID = self->_itemToEditDict[@"ItemTurnUserID"];
            
        }
        
        if ([itemTurnUserID length] == 0) {
            
            itemTurnUserID = [[[GeneralObject alloc] init] GenerateCurrentUsersTurn:itemDueDate itemRepeats:itemRepeats itemRepeatIfCompletedEarly:itemRepeatIfCompletedEarly itemCompleteAsNeeded:itemCompleteAsNeeded itemTakeTurns:itemTakeTurns itemCompletedDict:itemCompletedDict itemAssignedToArray:itemAssignedTo itemType:itemType itemTurnUserID:itemTurnUserID homeMembersDict:_homeMembersDict];
            
        }
        
    }
    
    return itemTurnUserID;
    
}

#pragma mark - Chores & Expeneses

-(NSMutableArray *)GenerateItemSpecificDueDates:(NSString *)itemRepeats {
    
    BOOL TaskIsRepeating = [[[BoolDataObject alloc] init] TaskIsRepeating:[@{@"ItemRepeats" : itemRepeats} mutableCopy] itemType:self->itemType];
    
    if (itemSpecificDueDatesArray.count > 0 && TaskIsRepeating == NO) {
        
        return itemSpecificDueDatesArray;
    }
    
    return [NSMutableArray array];
    
}

-(NSString *)GenerateItemApprovalNeeded {
    
    if ([itemApprovalNeededSwitch isOn] == YES) {
        return @"Yes";
    }
    
    return @"No";
}

-(NSMutableDictionary *)GenerateItemApprovalRequests {
    
    if (itemApprovalRequestsDict) {
        return itemApprovalRequestsDict;
    }
    
    return [NSMutableDictionary dictionary];
}

-(NSString *)GenerateItemPhotoConfirmation {
    
    NSString *itemPhotoConfirmation = self->_itemToEditDict[@"ItemPhotoConfirmation"] ? self->_itemToEditDict[@"ItemPhotoConfirmation"] : @"No";
    
    return itemPhotoConfirmation;
}

-(NSMutableDictionary *)GenerateItemPhotoConfirmationDict {
    
    NSMutableDictionary *itemPhotoConfirmationDict = self->_itemToEditDict[@"ItemPhotoConfirmationDict"] ? self->_itemToEditDict[@"ItemPhotoConfirmationDict"] : [NSMutableDictionary dictionary];
    
    return itemPhotoConfirmationDict;
}

#pragma mark - Chores

-(NSString *)GenerateItemCompletedBy {
    
    NSString *itemCompletedBy = itemMustCompleteTextField.text;
    
    if ([itemEveryoneTakesTurnsSwitch isOn] == YES) {
        itemCompletedBy = @"Everyone";
    }
    
    return itemCompletedBy;
}

-(NSMutableDictionary *)GenerateItemSubTasks {
    
    NSMutableDictionary *itemDictToReturn = [NSMutableDictionary dictionary];
    NSMutableDictionary *dictToUse = [itemSubTasksDict mutableCopy];
    NSMutableArray *itemAssignedTo = [self GenerateItemAssignedTo:@"No"];
    NSString *key = @"ItemSubTasks";
    
    for (NSString *itemName in [dictToUse allKeys]) {
        
        BOOL EdittingExistingItems = _editingTask == YES && self->_itemToEditDict[key] ? self->_itemToEditDict[key] : NO;
        BOOL ItemAlreadyCreated = _editingTask == YES && self->_itemToEditDict[key] ? [[self->_itemToEditDict[key] allKeys] containsObject:itemName] : NO;
        
        BOOL OldItemAssignedToSomeone = _editingTask == YES && self->_itemToEditDict[key] && self->_itemToEditDict[key][itemName] && self->_itemToEditDict[key][itemName][@"Assigned To"] && [(NSArray *)self->_itemToEditDict[key][itemName][@"Assigned To"] count] > 0 && [self->_itemToEditDict[key][itemName][@"Assigned To"][0] isEqualToString:@"Anybody"] == NO;
        BOOL NewItemAssignedToSomeone = dictToUse && dictToUse[itemName] && dictToUse[itemName][@"Assigned To"] && [(NSArray *)dictToUse[itemName][@"Assigned To"] count] > 0 && [dictToUse[itemName][@"Assigned To"][0] isEqualToString:@"Anybody"] == NO;
        
        BOOL ItemAssignedToDidntChange = NO;
        BOOL ItemAssignedToUserDoesntExist = NO;
        
        if (OldItemAssignedToSomeone == YES && NewItemAssignedToSomeone == YES) {
            
            NSString *oldAssignedTo = _editingTask == YES && self->_itemToEditDict[key] && self->_itemToEditDict[key][itemName] && self->_itemToEditDict[key][itemName][@"Assigned To"] && [(NSArray *)self->_itemToEditDict[key][itemName][@"Assigned To"] count] > 0 ? self->_itemToEditDict[key][itemName][@"Assigned To"][0] : @"";
            NSString *newAssignedTo = dictToUse && dictToUse[itemName] && dictToUse[itemName][@"Assigned To"] && [(NSArray *)dictToUse[itemName][@"Assigned To"] count] > 0 ? dictToUse[itemName][@"Assigned To"][0] : @"";
            
            ItemAssignedToDidntChange =
            [oldAssignedTo isEqualToString:newAssignedTo] &&
            [itemAssignedTo containsObject:oldAssignedTo];
            
        } else if (OldItemAssignedToSomeone == NO && NewItemAssignedToSomeone == NO) {
            
            ItemAssignedToDidntChange = YES;
            
        }
        
        if (EdittingExistingItems == YES && ItemAlreadyCreated == YES && ItemAssignedToDidntChange == YES && _duplicatingTask == NO) {
            
            [itemDictToReturn setObject:
             @{@"Completed Dict" : _editingTask == YES && self->_itemToEditDict[key] && self->_itemToEditDict[key][itemName] && self->_itemToEditDict[key][itemName][@"Completed Dict"] ? self->_itemToEditDict[key][itemName][@"Completed Dict"] : [NSMutableDictionary dictionary],
               @"In Progress Dict" : _editingTask == YES && self->_itemToEditDict[key] && self->_itemToEditDict[key][itemName] && self->_itemToEditDict[key][itemName][@"In Progress Dict"] ? self->_itemToEditDict[key][itemName][@"In Progress Dict"] : [NSMutableDictionary dictionary],
               @"Wont Do" : _editingTask == YES && self->_itemToEditDict[key] && self->_itemToEditDict[key][itemName] && self->_itemToEditDict[key][itemName][@"Wont Do"] ? self->_itemToEditDict[key][itemName][@"Wont Do"] : [NSMutableDictionary dictionary],
               @"Assigned To" : _editingTask == YES && self->_itemToEditDict[key] && self->_itemToEditDict[key][itemName] && self->_itemToEditDict[key][itemName][@"Assigned To"] ? self->_itemToEditDict[key][itemName][@"Assigned To"] : [NSMutableArray array]
             }
                                 forKey:itemName];
            
        } else {
            
            NSString *assignedToUser = ItemAssignedToUserDoesntExist == YES ?
            @[@"Anybody"] :
            dictToUse && dictToUse[itemName] && dictToUse[itemName][@"Assigned To"] ? dictToUse[itemName][@"Assigned To"] : [NSMutableArray array];
            
            [itemDictToReturn setObject:
             @{@"Completed Dict" : [NSMutableDictionary dictionary],
               @"In Progress Dict" : [NSMutableDictionary dictionary],
               @"Wont Do" : [NSMutableDictionary dictionary],
               @"Assigned To" : assignedToUser
             }
                                 forKey:itemName];
            
        }
        
    }
    
    return itemDictToReturn;
}

#pragma mark - Expense

-(NSMutableDictionary *)GenerateItemCostPerPerson:(NSMutableDictionary *)itemCostPerPerson itemItemizedItems:(NSMutableDictionary *)itemItemizedItems {
    
    NSMutableDictionary *itemCostPerPersonDictLocal = [itemCostPerPerson mutableCopy];
    
    if (itemCostPerPersonDictLocal == nil || _viewingAddExpenseViewController == NO || [[itemItemizedItems allKeys] count] > 0) {
        itemCostPerPersonDictLocal = [NSMutableDictionary dictionary];
    }
    
    //    for (NSString *userID in [[itemCostPerPersonDictLocal allKeys] mutableCopy]) {
    //
    //        NSString *costPerPerson = itemCostPerPersonDictLocal[userID];
    //        costPerPerson = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:costPerPerson arrayOfSymbols:@[localCurrencyNumberSeparatorSymbol, localCurrencySymbol]];
    //        [itemCostPerPersonDictLocal setObject:costPerPerson forKey:userID];
    //
    //    }
    
    return itemCostPerPersonDictLocal;
}

-(NSMutableDictionary *)GenerateItemPaymentMethod:(NSMutableDictionary *)itemPaymentMethod {
    
    NSMutableDictionary *itemPaymentMethodDictLocal = [itemPaymentMethod mutableCopy];
    
    if (itemPaymentMethodDictLocal == NULL || itemPaymentMethodDictLocal[@"PaymentMethod"] == NULL || _viewingAddExpenseViewController == NO) {
        itemPaymentMethodDictLocal = [@{@"PaymentMethod" : @"None", @"PaymentMethodData" : @"", @"PaymentMethodNotes" : @""} mutableCopy];
    }
    
    return itemPaymentMethodDictLocal;
}

-(NSString *)GenerateItemItemized:(NSMutableDictionary *)itemItemizedItems {
    
    //NSString *itemItemized = [[itemItemizedItemsDict allKeys] count] > 0 ? @"Yes" : @"No";
    NSString *itemItemized = @"No";
    
    if (itemItemizedItems != NULL && [[itemItemizedItems allKeys] count] > 0) {
        
        itemItemized = @"Yes";
        
    }
    
    return itemItemized;
}

-(NSMutableDictionary *)GenerateItemItemizedItems:(NSMutableDictionary *)itemItemizedItems itemAssignedTo:(NSMutableArray *)itemAssignedTo {
    
    NSMutableDictionary *itemDictToReturn = [NSMutableDictionary dictionary];
    NSMutableDictionary *itemItemizedItemsLocal = [itemItemizedItems mutableCopy];
    
    NSString *key = @"ItemItemizedItems";
    
    for (NSString *itemName in [itemItemizedItemsLocal allKeys]) {
        
        BOOL EdittingExistingItems = self->_itemToEditDict[key];
        BOOL ItemAlreadyCreated = [[self->_itemToEditDict[key] allKeys] containsObject:itemName];
        
        BOOL OldItemAssignedToSomeone = _editingTask == YES && self->_itemToEditDict[key] && self->_itemToEditDict[key][itemName] && self->_itemToEditDict[key][itemName][@"Assigned To"]&& [(NSArray *)self->_itemToEditDict[key][itemName][@"Assigned To"] count] > 0 && [self->_itemToEditDict[key][itemName][@"Assigned To"][0] isEqualToString:@"Anybody"] == NO;
        BOOL NewItemAssignedToSomeone = itemItemizedItemsLocal && itemItemizedItemsLocal[itemName] && itemItemizedItemsLocal[itemName][@"Assigned To"] && [(NSArray *)itemItemizedItemsLocal[itemName][@"Assigned To"] count] > 0 && [itemItemizedItemsLocal[itemName][@"Assigned To"][0] isEqualToString:@"Anybody"] == NO;
        
        BOOL ItemAssignedToDidntChange = NO;
        BOOL ItemAssignedToUserDoesntExist = NO;
        
        if (OldItemAssignedToSomeone == YES && NewItemAssignedToSomeone == YES) {
            
            NSString *oldAssignedTo = _editingTask == YES && self->_itemToEditDict[key] && self->_itemToEditDict[key][itemName] && self->_itemToEditDict[key][itemName][@"Assigned To"] && [(NSArray *)self->_itemToEditDict[key][itemName][@"Assigned To"] count] > 0 ? self->_itemToEditDict[key][itemName][@"Assigned To"][0] : @"";
            NSString *newAssignedTo = itemItemizedItemsLocal && itemItemizedItemsLocal[itemName] && itemItemizedItemsLocal[itemName][@"Assigned To"] && [(NSArray *)itemItemizedItemsLocal[itemName][@"Assigned To"] count] > 0 ? itemItemizedItemsLocal[itemName][@"Assigned To"][0] : @"";
            
            ItemAssignedToDidntChange =
            [oldAssignedTo isEqualToString:newAssignedTo] &&
            [itemAssignedTo containsObject:oldAssignedTo];
            
        } else if (OldItemAssignedToSomeone == NO && NewItemAssignedToSomeone == NO) {
            
            ItemAssignedToDidntChange = YES;
            
        }
        
        if (EdittingExistingItems == YES && ItemAlreadyCreated == YES && ItemAssignedToDidntChange == YES && _duplicatingTask == NO) {
            
            id amount = self->_itemToEditDict[key][itemName][@"Amount"];
            
            BOOL ObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:amount classArr:@[[NSArray class], [NSMutableArray class]]];
            
            if (ObjectIsKindOfClass == YES) {
                amount = [(NSArray *)amount count] > 0 ? amount[0] : [NSString stringWithFormat:@"%@0%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol];
            }
            
            [itemDictToReturn setObject:
             @{@"Amount" : amount,
               @"Status" : _editingTask == YES && self->_itemToEditDict[key] && self->_itemToEditDict[key][itemName] && self->_itemToEditDict[key][itemName][@"Status"] ? self->_itemToEditDict[key][itemName][@"Status"] : @"",
               @"Assigned To" : _editingTask == YES && self->_itemToEditDict[key] && self->_itemToEditDict[key][itemName] && self->_itemToEditDict[key][itemName][@"Assigned To"] ? self->_itemToEditDict[key][itemName][@"Assigned To"] : [NSMutableArray array]
             }
                                 forKey:itemName];
            
        } else {
            
            id amount = itemItemizedItemsLocal && itemItemizedItemsLocal[itemName] && itemItemizedItemsLocal[itemName][@"Amount"] ? itemItemizedItemsLocal[itemName][@"Amount"] : [NSString stringWithFormat:@"%@0%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol];
            
            BOOL ObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:amount classArr:@[[NSArray class], [NSMutableArray class]]];
            
            if (ObjectIsKindOfClass == YES) {
                amount = [(NSArray *)amount count] > 0 ? amount[0] : [NSString stringWithFormat:@"%@0%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol];
            }
            
            NSString *assignedToUser = ItemAssignedToUserDoesntExist == YES ?
            @[@"Anybody"] :
            itemItemizedItemsLocal && itemItemizedItemsLocal[itemName] && itemItemizedItemsLocal[itemName][@"Assigned To"] ? itemItemizedItemsLocal[itemName][@"Assigned To"] : @"";
            
            [itemDictToReturn setObject:
             @{@"Amount" : amount,
               @"Status" : @"Uncompleted",
               @"Assigned To" : assignedToUser
             }
                                 forKey:itemName];
            
        }
        
    }
    
    return itemDictToReturn;
}

#pragma mark - Lists

-(NSMutableDictionary *)GenerateItemListItems:(NSMutableDictionary *)itemListItems itemAssignedTo:(NSMutableArray *)itemAssignedTo {
    
    NSMutableDictionary *itemDictToReturn = [NSMutableDictionary dictionary];
    NSMutableDictionary *dictToUse = [itemListItems mutableCopy];
    NSString *key = @"ItemListItems";
    
    for (NSString *itemName in [dictToUse allKeys]) {
        
        BOOL EdittingExistingItems = _editingTask == YES && self->_itemToEditDict[key] ? self->_itemToEditDict[key] : NO;
        BOOL ItemAlreadyCreated = _editingTask == YES && self->_itemToEditDict[key] ? [[self->_itemToEditDict[key] allKeys] containsObject:itemName] : NO;
        
        BOOL OldItemAssignedToSomeone = _editingTask == YES && self->_itemToEditDict[key] && self->_itemToEditDict[key][itemName] && self->_itemToEditDict[key][itemName][@"Assigned To"] && [(NSArray *)self->_itemToEditDict[key][itemName][@"Assigned To"] count] > 0 && [(NSArray *)self->_itemToEditDict[key][itemName][@"Assigned To"] count] > 0 && [self->_itemToEditDict[key][itemName][@"Assigned To"][0] isEqualToString:@"Anybody"] == NO;
        BOOL NewItemAssignedToSomeone = dictToUse && dictToUse[itemName] && dictToUse[itemName][@"Assigned To"] && [(NSArray *)dictToUse[itemName][@"Assigned To"] count] > 0 && [dictToUse[itemName][@"Assigned To"][0] isEqualToString:@"Anybody"] == NO;
        
        BOOL ItemAssignedToDidntChange = NO;
        BOOL ItemAssignedToUserDoesntExist = NO;
        
        if (OldItemAssignedToSomeone == YES && NewItemAssignedToSomeone == YES) {
            
            NSString *oldAssignedTo = _editingTask == YES && self->_itemToEditDict[key] && self->_itemToEditDict[key][itemName] && self->_itemToEditDict[key][itemName][@"Assigned To"] && [(NSArray *)self->_itemToEditDict[key][itemName][@"Assigned To"] count] > 0 ? self->_itemToEditDict[key][itemName][@"Assigned To"][0] : @"";
            NSString *newAssignedTo = dictToUse && dictToUse[itemName] && dictToUse[itemName][@"Assigned To"] && [(NSArray *)dictToUse[itemName][@"Assigned To"] count] > 0 ? dictToUse[itemName][@"Assigned To"][0] : @"";
            
            ItemAssignedToDidntChange =
            [oldAssignedTo isEqualToString:newAssignedTo] &&
            [itemAssignedTo containsObject:oldAssignedTo];
            
        } else if (OldItemAssignedToSomeone == NO && NewItemAssignedToSomeone == NO) {
            
            ItemAssignedToDidntChange = YES;
            
        }
        
        if (EdittingExistingItems == YES && ItemAlreadyCreated == YES && ItemAssignedToDidntChange == YES && _duplicatingTask == NO) {
            
            [itemDictToReturn setObject:
             @{@"Status" : _editingTask == YES && self->_itemToEditDict[key] && self->_itemToEditDict[key][itemName] && self->_itemToEditDict[key][itemName][@"Status"] ? self->_itemToEditDict[key][itemName][@"Status"] : @"",
               @"Assigned To" : _editingTask == YES && self->_itemToEditDict[key] && self->_itemToEditDict[key][itemName] && self->_itemToEditDict[key][itemName][@"Assigned To"] ? self->_itemToEditDict[key][itemName][@"Assigned To"] : [NSMutableArray array]
             }
                                 forKey:itemName];
            
        } else {
            
            NSString *assignedToUser = ItemAssignedToUserDoesntExist == YES ?
            @[@"Anybody"] :
            dictToUse && dictToUse[itemName] && dictToUse[itemName][@"Assigned To"] ? dictToUse[itemName][@"Assigned To"] : [NSMutableArray array];
            
            [itemDictToReturn setObject:
             @{@"Status" : @"Uncompleted",
               @"Assigned To" : assignedToUser
             }
                                 forKey:itemName];
            
        }
        
    }
    
    return itemDictToReturn;
}

#pragma mark - MultiAddItem

-(void)MultiAddItem_SetLocalIDs {
    
    self->chosenItemUniqueID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    self->chosenItemID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    self->chosenItemOccurrenceID = @"";
    self->chosenItemDatePosted = [[[GeneralObject alloc] init] GenerateCurrentDateString];
    
}

-(void)MultiAddItem_UpdateSetDataDict:(NSMutableDictionary *)setDataDict {
    
    UIImage *itemImageImage = addImageImage.image == [UIImage systemImageNamed:@"camera.viewfinder"] ? nil : addImageImage.image;
    NSData *imgData = UIImageJPEGRepresentation(itemImageImage, 0.15);
    if (imgData == nil) { imgData = [NSData data]; }
    [setDataDict setObject:imgData forKey:@"ItemImageData"];
    [setDataDict setObject:topViewLabel.text forKey:@"ItemTaskList"];
    
}

-(void)MultiAddItem_SetLocalItemData:(NSMutableDictionary *)setDataDict {
    
    [[[GeneralObject alloc] init] CallNSNotificationMethods:@"AddTask" userInfo:setDataDict locations:@[@"MultiAddTasks"]];
    
}

-(void)MultiAddItem_CompletionBlock {
    
    [self DismissViewController:self];
    
}

#pragma mark - AddItem

-(void)AddItem_SetLocalIDs {
    
    self->chosenItemUniqueID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    self->chosenItemID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    self->chosenItemOccurrenceID = @"";
    self->chosenItemDatePosted = [[[GeneralObject alloc] init] GenerateCurrentDateString];
    self->_homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
 
}

-(void)AddItem_SetLocalItemData:(NSDictionary *)setDataDict {
    
    [[[GeneralObject alloc] init] CallNSNotificationMethods:@"AddTask" userInfo:setDataDict locations:@[@"Tasks", @"Calendar"]];
    
}

-(void)AddItem_SetLocalTaskListData:(void (^)(BOOL finished, NSMutableDictionary *returningNewTaskListDict))finishBlock {
    
    NSMutableDictionary *newTaskListDict = [NSMutableDictionary dictionary];
    
    NSString *taskListName = topViewLabel.text;
    BOOL TaskListSelected = [taskListName isEqualToString:@"No List"] == NO;
    BOOL TaskListExists =  [_taskListDict[@"TaskListName"] containsObject:taskListName];
    
    if (TaskListSelected == YES && TaskListExists == YES) {
        
        NSUInteger index = [_taskListDict[@"TaskListName"] containsObject:taskListName] ? [_taskListDict[@"TaskListName"] indexOfObject:taskListName] : 1000;
        NSString *taskListID = index != 1000 ? _taskListDict[@"TaskListID"][index] : @"";
        
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"AddTaskToTaskList" userInfo:@{@"ItemUniqueID" : chosenItemUniqueID, @"TaskListID" : taskListID} locations:@[@"Tasks", @"ViewTask"]];
        
        finishBlock(YES, newTaskListDict);
        
    } else if (TaskListSelected == YES && TaskListExists == NO) {
        
        NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
        NSString *randomID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
        NSString *dateCreated = [[[GeneralObject alloc] init] GenerateCurrentDateString];
        NSString *newName = self->topViewLabel.text;
        
        newTaskListDict = [@{
            @"TaskListID" : randomID,
            @"TaskListDateCreated" : dateCreated,
            @"TaskListCreatedBy" : userID,
            @"TaskListName" : newName,
            @"TaskListSections" : [NSMutableArray array],
            @"TaskListItems" : [NSMutableDictionary dictionary]
        } mutableCopy];
        
        NSArray *keyArray = [[[GeneralObject alloc] init] GenerateTaskListKeyArray];
       
        for (NSString *key in keyArray) {
            NSMutableArray *arr = self->_taskListDict[key] ? [self->_taskListDict[key] mutableCopy] : [NSMutableArray array];
            id object = newTaskListDict[key] ? newTaskListDict[key] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
            [arr addObject:object];
            [self->_taskListDict setObject:arr forKey:key];
        }
       
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"AddOrEditTaskList" userInfo:newTaskListDict locations:@[@"Tasks", @"MultiAddTasks", @"ViewTask"]];
        
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"AddTaskToTaskList" userInfo:@{@"ItemUniqueID" : self->chosenItemUniqueID, @"TaskListID" : newTaskListDict[@"TaskListID"]} locations:@[@"Tasks", @"ViewTask"]];
        
        finishBlock(YES, newTaskListDict);
        
    } else {
        
        finishBlock(YES, newTaskListDict);
        
    }
    
}

#pragma mark

-(void)AddItem_PushNotificationOrScheduledStartNotifications:(NSDictionary *)setDataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
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
        
        BOOL TaskIsScheduledStart = [[[BoolDataObject alloc] init] TaskIsScheduledStart:[setDataDict mutableCopy] itemType:self->itemType];
        
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
            
            [[[NotificationsObject alloc] init] ResetLocalNotificationScheduledStartNotifications:[setDataDict mutableCopy] itemType:self->itemType userIDArray:userIDArray userIDToRemoveArray:userIDToRemoveArray  allItemTagsArrays:self->_allItemTagsArrays homeMembersArray:self->_homeMembersArray homeMembersDict:self->_homeMembersDict notificationSettingsDict:self->_notificationSettingsDict topicDict:self->_topicDict completionHandler:^(BOOL finished) {
                
                finishBlock(YES);
                
            }];
            
        }
        
    });
    
}

-(void)AddItem_EditItem_ResetItemNotifications:(NSDictionary *)setDataDict AddingItem:(BOOL)AddingItem completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *itemCreatedBy = setDataDict[@"ItemCreatedBy"] ? setDataDict[@"ItemCreatedBy"] : @"";
    NSMutableArray *itemAssignedTo = setDataDict[@"ItemAssignedTo"] ? setDataDict[@"ItemAssignedTo"] : [NSMutableArray array];
    
    NSMutableArray *userIDArray = [itemAssignedTo mutableCopy];
    NSMutableArray *userIDToRemoveArray = [NSMutableArray array];
    
    [userIDArray addObject:itemCreatedBy];
    
    if (AddingItem == NO) {
        
        NSMutableArray *originalItemAssignedTo = self->_itemToEditDict[@"ItemAssignedTo"];
        NSMutableArray *newItemAssignedTo = setDataDict[@"ItemAssignedTo"];
        
        for (NSString *originalUserID in originalItemAssignedTo) {
            
            if ([newItemAssignedTo containsObject:originalUserID] == NO && [originalUserID isEqualToString:itemCreatedBy] == NO) {
                
                [userIDToRemoveArray addObject:originalUserID];
                
            }
            
        }
        
    }
    
    NSString *notificationType = [[[NotificationsObject alloc] init] NotificationSettingsUnknownItemType_Adding:AddingItem Editing:AddingItem == NO Deleting:NO Duplicating:NO Waiving:NO Skipping:NO Pausing:NO Comments:NO
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
        
        [[[NotificationsObject alloc] init] ResetLocalNotificationReminderNotification:[setDataDict mutableCopy] homeMembersDict:self->_homeMembersDict userIDArray:userIDArray userIDToRemoveArray:userIDToRemoveArray notificationSettingsDict:self->_notificationSettingsDict allItemTagsArrays:self->_allItemTagsArrays itemType:self->itemType notificationType:notificationType topicDict:self->_topicDict completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)AddItem_SetDataTopic:(NSDictionary *)setDataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
        NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
        
        NSDictionary *dataDict = @{@"TopicID" : self->chosenItemID, @"TopicCreatedBy" : userID, @"TopicSubscribedTo" : @[userID], @"TopicAssignedTo" : setDataDict[@"ItemAssignedTo"], @"TopicDateCreated" : self->chosenItemDatePosted, @"TopicDeleted" : @"No"};
        
        [[[SetDataObject alloc] init] SubscribeAndSetDataTopic:homeID topicID:self->chosenItemID dataDict:dataDict completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)AddItem_SetItemData:(NSDictionary *)setDataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *collection = [NSString stringWithFormat:@"%@s", self->itemType];
        NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
        
        [[[SetDataObject alloc] init] SetDataAddItem:setDataDict collection:collection homeID:homeID completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)AddItem_SetImageData:(NSDictionary *)setDataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    UIImage *itemImageImage = addImageImage.image == [UIImage systemImageNamed:@"camera.viewfinder"] ? nil : addImageImage.image;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *imgData = UIImageJPEGRepresentation(itemImageImage, 0.15);
        
        if (imgData != nil) {
            
            [[[SetDataObject alloc] init] SetDataItemImage:self->chosenItemUniqueID itemType:self->itemType imgData:imgData completionHandler:^(BOOL finished) {
                
                finishBlock(YES);
                
            }];
            
        } else {
            
            finishBlock(YES);
            
        }
        
    });
    
}

-(void)AddItem_SetTaskListData:(NSMutableDictionary *)newTaskListDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *navigationBarTitle = [NSString stringWithFormat:@"%@", topViewLabel.text];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        BOOL TaskListSelected = [navigationBarTitle isEqualToString:@"No List"] == NO;
        
        if (TaskListSelected == YES && newTaskListDict[@"TaskListID"]) {
            
            [[[SetDataObject alloc] init] SetDataAddTaskList:newTaskListDict[@"TaskListCreatedBy"] taskListID:newTaskListDict[@"TaskListID"] dataDict:newTaskListDict completionHandler:^(BOOL finished) {
                
                [[[GeneralObject alloc] init] AddOrRemoveTaskToSpecificTaskList:self->_taskListDict newTaskListName:navigationBarTitle itemUniqueIDArray:@[self->chosenItemUniqueID] AddTask:YES completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningUpdatedTaskListDict) {
                    
                    self->_taskListDict = [[[GeneralObject alloc] init] GenerateUpdatedTaskListDict:@[returningUpdatedTaskListDict] taskListDict:self->_taskListDict];
                    
                    finishBlock(YES);
                    
                }];
                
            }];
            
        } else if (TaskListSelected == YES) {
            
            [[[GeneralObject alloc] init] AddOrRemoveTaskToSpecificTaskList:self->_taskListDict newTaskListName:navigationBarTitle itemUniqueIDArray:@[self->chosenItemUniqueID] AddTask:YES completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningUpdatedTaskListDict) {
                
                self->_taskListDict = [[[GeneralObject alloc] init] GenerateUpdatedTaskListDict:@[returningUpdatedTaskListDict] taskListDict:self->_taskListDict];
                
                finishBlock(YES);
                
            }];
            
        } else {
            
            finishBlock(YES);
            
        }
        
    });
    
}

-(void)AddItem_SetItemAndHomeActivity:(NSDictionary *)setDataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
        
        NSString *activityAction = @"Adding Task";
        NSString *userTitle = [NSString stringWithFormat:@"%@ created a %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"], [self->itemType lowercaseString]];
        NSString *itemTitle = [NSString stringWithFormat:@"%@ created this %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"], [self->itemType lowercaseString]];
        NSString *itemDescription = [NSString stringWithFormat:@"\"%@\" was created", setDataDict[@"ItemName"]];
        
        NSMutableDictionary *itemActivityDict = [[[SetDataObject alloc] init] GenerateItemActivityDict:self->chosenItemID itemOccurrenceID:self->chosenItemOccurrenceID activityUserIDNo1:@"" homeID:homeID activityAction:activityAction userTitle:userTitle userDescription:itemDescription itemType:self->itemType];
        NSMutableDictionary *homeActivityDict = [[[SetDataObject alloc] init] GenerateHomeActivityDict:@"" homeID:homeID activityAction:activityAction itemTitle:itemTitle itemDescription:itemDescription itemType:self->itemType];
        
        [[[SetDataObject alloc] init] SetDataHomeAndItemActivity:itemActivityDict homeActivityDict:homeActivityDict completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)AddItem_SetAlgoliaData:(NSDictionary *)setDataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[SetDataObject alloc] init] SetDataAddAlgoliaObject:self->chosenItemUniqueID dictToUse:[setDataDict mutableCopy] completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

#pragma mark

-(void)AddItem_CompletionBlock {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"DisplayRegisterForNotificationsPopup"];
        [self IncreaseCountForAppStoreRatingPopup];
        
        [self->topView removeFromSuperview];
        [self->progressView setHidden:YES];
        [self DismissViewController:self];
        
    });
    
}

#pragma mark - Edit Item

-(void)EditItem_SetLocalIDs {
    
    self->chosenItemUniqueID = self->_itemToEditDict[@"ItemUniqueID"] ? self->_itemToEditDict[@"ItemUniqueID"] : @"xxx";
    self->chosenItemID = self->_itemToEditDict[@"ItemID"] ? self->_itemToEditDict[@"ItemID"] : @"xxx";
    self->chosenItemOccurrenceID = self->_itemToEditDict[@"ItemOccurrenceID"] ? self->_itemToEditDict[@"ItemOccurrenceID"] : @"xxx";
    self->chosenItemDatePosted = self->_itemToEditDict[@"ItemDatePosted"] ? self->_itemToEditDict[@"ItemDatePosted"] : @"xxx";
    self->_homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
    
}

-(void)EditItem_SetLocalItemData:(NSDictionary *)setDataDict {
    
    [[[GeneralObject alloc] init] CallNSNotificationMethods:@"EditTask" userInfo:setDataDict locations:@[@"ViewTask"]];
    
}

-(void)EditItem_SetLocalTaskListData:(void (^)(BOOL finished, NSMutableDictionary *returningNewTaskListDict))finishBlock {
    
    NSMutableDictionary *newTaskListDict = [NSMutableDictionary dictionary];
    
    NSString *oldTaskListName = oldTaskList;
    NSString *newTaskListName = topViewLabel.text;
    
    BOOL TaskListSelected = [newTaskListName isEqualToString:@"No List"] == NO;
    BOOL TaskListExists =  [_taskListDict[@"TaskListName"] containsObject:newTaskListName];
    BOOL TaskListChanged = [newTaskListName isEqualToString:oldTaskListName] == NO;
    
    if (TaskListSelected == YES && TaskListExists == YES && TaskListChanged == YES) {
        
        NSUInteger index = [_taskListDict[@"TaskListName"] containsObject:oldTaskListName] ? [_taskListDict[@"TaskListName"] indexOfObject:oldTaskListName] : 1000;
        NSString *oldTaskListID = index != 1000 ? _taskListDict[@"TaskListID"][index] : @"";
        
        index = [_taskListDict[@"TaskListName"] containsObject:newTaskListName] ? [_taskListDict[@"TaskListName"] indexOfObject:newTaskListName] : 1000;
        NSString *newTaskListID = index != 1000 ? _taskListDict[@"TaskListID"][index] : @"";
        
        
        
        NSString *notificationObserver = @"";
        NSDictionary *dataDict = @{};
        
        if (TaskListSelected == NO) {
            notificationObserver = @"RemoveTaskFromAllTaskLists";
            dataDict = @{@"ItemUniqueID" : chosenItemUniqueID};
        } else if (oldTaskListID.length > 0 && newTaskListID.length > 0) {
            notificationObserver = @"MoveTaskToDifferentTaskList";
            dataDict = @{@"ItemUniqueID" : chosenItemUniqueID, @"OldTaskListID" : oldTaskListID, @"NewTaskListID" : newTaskListID};
        } else if (newTaskListID.length > 0) {
            notificationObserver = @"AddTaskToTaskList";
            dataDict = @{@"ItemUniqueID" : chosenItemUniqueID, @"TaskListID" : newTaskListID};
        }
        
        [[[GeneralObject alloc] init] CallNSNotificationMethods:notificationObserver userInfo:dataDict locations:@[@"Tasks", @"ViewTask"]];
        
        
        
        finishBlock(YES, newTaskListDict);
        
    } else if (TaskListSelected == YES && TaskListExists == NO) {
        
        NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
        NSString *randomID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
        NSString *dateCreated = [[[GeneralObject alloc] init] GenerateCurrentDateString];
        NSString *newName = self->topViewLabel.text;
        
        newTaskListDict = [@{
            @"TaskListID" : randomID,
            @"TaskListDateCreated" : dateCreated,
            @"TaskListCreatedBy" : userID,
            @"TaskListName" : newName,
            @"TaskListSections" : [NSMutableArray array],
            @"TaskListItems" : [NSMutableDictionary dictionary]
        } mutableCopy];
        
        NSArray *keyArray = [[[GeneralObject alloc] init] GenerateTaskListKeyArray];
        
        for (NSString *key in keyArray) {
            NSMutableArray *arr = self->_taskListDict[key] ? [self->_taskListDict[key] mutableCopy] : [NSMutableArray array];
            id object = newTaskListDict[key] ? newTaskListDict[key] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
            [arr addObject:object];
            [self->_taskListDict setObject:arr forKey:key];
        }
        
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"AddOrEditTaskList" userInfo:newTaskListDict locations:@[@"Tasks", @"ViewTask"]];
        
        
        
        NSUInteger index = [self->_taskListDict[@"TaskListName"] containsObject:oldTaskListName] ? [self->_taskListDict[@"TaskListName"] indexOfObject:oldTaskListName] : 1000;
        NSString *oldTaskListID = index != 1000 ? self->_taskListDict[@"TaskListID"][index] : @"";
        NSString *newTaskListID = newTaskListDict[@"TaskListID"];
        
        NSString *notificationObserver = @"";
        NSDictionary *dataDict = @{};
        
        if ([newTaskListName isEqualToString:oldTaskListName] == NO && oldTaskListID.length > 0 && newTaskListID.length > 0) {
            notificationObserver = @"MoveTaskToDifferentTaskList";
            dataDict = @{@"ItemUniqueID" : self->chosenItemUniqueID, @"OldTaskListID" : oldTaskListID, @"NewTaskListID" : newTaskListID};
        } else if (newTaskListID.length > 0) {
            notificationObserver = @"AddTaskToTaskList";
            dataDict = @{@"ItemUniqueID" : self->chosenItemUniqueID, @"TaskListID" : newTaskListID};
        }
        
        [[[GeneralObject alloc] init] CallNSNotificationMethods:notificationObserver userInfo:dataDict locations:@[@"Tasks", @"ViewTask"]];
        
        
        
        finishBlock(YES, newTaskListDict);
        
    } else {
        
        finishBlock(YES, newTaskListDict);
        
    }
    
}

#pragma mark

-(void)EditItem_PushNotificationOrScheduledStartNotifications:(NSDictionary *)setDataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    BOOL TaskIsOriginal = setDataDict[@"ItemOccurrenceID"] && [setDataDict[@"ItemOccurrenceID"] length] == 0;
    
    if (TaskIsOriginal == YES) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSString *itemName = self->_itemToEditDict[@"ItemName"];
            
            NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
            NSString *notificationTitle = [NSString stringWithFormat:@"\"%@\"", itemName];
            NSString *pushNotificationBody = [[[NotificationsObject alloc] init] GeneratePushNotificationAddItemBody:NO EditItem:YES DeleteItem:NO NotificationItem:NO NobodyAssigned:NO userIDArray:setDataDict[@"ItemAssignedTo"]];
            NSString *notificationBody = [[[NotificationsObject alloc] init] GeneratePushNotificationAddItemBody:NO EditItem:YES DeleteItem:NO NotificationItem:YES NobodyAssigned:NO userIDArray:setDataDict[@"ItemAssignedTo"]];
            
            NSString *notificationType = notificationType = [[[NotificationsObject alloc] init] NotificationSettingsUnknownItemType_Adding:NO Editing:YES Deleting:NO Duplicating:NO Waiving:NO Skipping:NO Pausing:NO Comments:NO
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
            
            NSString *notificationItemType = self->itemType;
            
            BOOL TaskIsScheduledStart = [[[BoolDataObject alloc] init] TaskIsScheduledStart:[setDataDict mutableCopy] itemType:self->itemType];
            BOOL TaskIsScheduledStartHasPassed = [[[BoolDataObject alloc] init] TaskIsScheduledStartHasPassed:[setDataDict mutableCopy] itemType:self->itemType];
            
            if (TaskIsScheduledStart == NO || (TaskIsScheduledStart == YES && TaskIsScheduledStartHasPassed == YES)) {
                
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
                
                
                
                NSMutableArray *originalItemAssignedTo = self->_itemToEditDict[@"ItemAssignedTo"];
                NSMutableArray *newItemAssignedTo = itemAssignedTo;
                
                for (NSString *originalUserID in originalItemAssignedTo) {
                    
                    if ([newItemAssignedTo containsObject:originalUserID] == NO) {
                        
                        [userIDToRemoveArray addObject:originalUserID];
                        
                    }
                    
                }
                
                
                
                [[[NotificationsObject alloc] init] ResetLocalNotificationScheduledStartNotifications:[setDataDict mutableCopy] itemType:self->itemType userIDArray:userIDArray userIDToRemoveArray:userIDToRemoveArray  allItemTagsArrays:self->_allItemTagsArrays homeMembersArray:self->_homeMembersArray homeMembersDict:self->_homeMembersDict notificationSettingsDict:self->_notificationSettingsDict topicDict:self->_topicDict completionHandler:^(BOOL finished) {
                    
                    finishBlock(YES);
                }];
                
            }
            
        });
        
    } else {
        
        finishBlock(YES);
        
    }
    
}

-(void)EditItem_UpdateTopicData:(NSDictionary *)setDataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[SetDataObject alloc] init] SubsribeOrUnsubscribeAndUpdateTopic:self->_homeID topicID:self->chosenItemID itemOccurrenceID:self->chosenItemOccurrenceID dataDict:@{@"TopicAssignedTo" : setDataDict[@"ItemAssignedTo"]} SubscribeToTopic:YES UnsubscribeFromTopic:NO completionHandler:^(BOOL finished) {
            
        }];
        
    });
    
}

-(void)EditItem_UpdateItemData:(NSDictionary *)setDataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *collection = [NSString stringWithFormat:@"%@s", self->itemType];
        
        [[[SetDataObject alloc] init] UpdateDataEditItem:setDataDict itemID:setDataDict[@"ItemID"] itemOccurrenceID:setDataDict[@"ItemOccurrenceID"] collection:collection homeID:self->_homeID completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)Edititem_UpdateItemImage:(void (^)(BOOL finished))finishBlock {
    
    UIImage *itemImageImage = addImageImage.image == [UIImage systemImageNamed:@"camera.viewfinder"] ? nil : addImageImage.image;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *imgData = UIImageJPEGRepresentation(itemImageImage, 0.15);
        
        [[[SetDataObject alloc] init] UpdateDataItemImage:self->chosenItemUniqueID itemType:self->itemType imgData:imgData completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)EditItem_UpdateTaskListData:(NSMutableDictionary *)newTaskListDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *navigationBarTitle = [NSString stringWithFormat:@"%@", topViewLabel.text];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        BOOL TaskListSelected = [navigationBarTitle isEqualToString:@"No List"] == NO;
        
        if (TaskListSelected == YES && newTaskListDict[@"TaskListID"]) {
            
            [[[SetDataObject alloc] init] SetDataAddTaskList:newTaskListDict[@"TaskListCreatedBy"] taskListID:newTaskListDict[@"TaskListID"] dataDict:newTaskListDict completionHandler:^(BOOL finished) {
                
                [[[GeneralObject alloc] init] AddTaskToSpecificTaskListAndRemoveFromDifferentSpecificTaskList:self->_taskListDict newTaskListName:navigationBarTitle oldTaskListName:self->oldTaskList itemUniqueIDArray:@[self->chosenItemUniqueID] completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningUpdatedTaskListDict, NSMutableDictionary * _Nonnull returningUpdatedTaskListDictNo1) {
                    
                    NSArray *arrayOfDicts = @[returningUpdatedTaskListDict, returningUpdatedTaskListDictNo1];
                    
                    self->_taskListDict = [[[GeneralObject alloc] init] GenerateUpdatedTaskListDict:arrayOfDicts taskListDict:self->_taskListDict];
                    
                    finishBlock(YES);
                    
                }];
                
            }];
            
        } else if (TaskListSelected == YES) {
            
            [[[GeneralObject alloc] init] AddTaskToSpecificTaskListAndRemoveFromDifferentSpecificTaskList:self->_taskListDict newTaskListName:navigationBarTitle oldTaskListName:self->oldTaskList itemUniqueIDArray:@[self->chosenItemUniqueID] completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningUpdatedTaskListDict, NSMutableDictionary * _Nonnull returningUpdatedTaskListDictNo1) {
            
                NSArray *arrayOfDicts = @[returningUpdatedTaskListDict, returningUpdatedTaskListDictNo1];
              
                self->_taskListDict = [[[GeneralObject alloc] init] GenerateUpdatedTaskListDict:arrayOfDicts taskListDict:self->_taskListDict];
                
                finishBlock(YES);
                
            }];
            
        } else {
            
            [[[GeneralObject alloc] init] AddOrRemoveTaskToAllTaskListsThatContainSpecificItem:self->_taskListDict newTaskListName:@"" itemUniqueIDDict:@{self->chosenItemUniqueID : @{@"SpecificItemUniqueID" : @""}} AddTask:NO completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningUpdatedTaskListDict) {
                
                self->_taskListDict = [[[GeneralObject alloc] init] GenerateUpdatedTaskListDict:@[returningUpdatedTaskListDict] taskListDict:self->_taskListDict];
                
                [[[GeneralObject alloc] init] CallNSNotificationMethods:@"RemoveTaskFromAllTaskLists" userInfo:@{@"ItemUniqueID" : self->chosenItemUniqueID} locations:@[@"Tasks", @"ViewTask"]];
                
                finishBlock(YES);
                
            }];
            
        }
        
    });
    
}

-(void)EditItem_SetItemHomeAndActivityData:(NSDictionary *)setDataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *activityAction = @"Editing Task";
        NSString *userTitle = [NSString stringWithFormat:@"%@ edited a %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"], [self->itemType lowercaseString]];
        NSString *itemTitle = [NSString stringWithFormat:@"%@ edit this %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"], [self->itemType lowercaseString]];
        NSString *itemDescription = [NSString stringWithFormat:@"\"%@\" was edited", setDataDict[@"ItemName"]];
        
        NSMutableDictionary *itemActivityDict = [[[SetDataObject alloc] init] GenerateItemActivityDict:self->chosenItemID itemOccurrenceID:self->chosenItemOccurrenceID activityUserIDNo1:@"" homeID:self->_homeID activityAction:activityAction userTitle:userTitle userDescription:itemDescription itemType:self->itemType];
        NSMutableDictionary *homeActivityDict = [[[SetDataObject alloc] init] GenerateHomeActivityDict:@"" homeID:self->_homeID activityAction:activityAction itemTitle:itemTitle itemDescription:itemDescription itemType:self->itemType];
        
        [[[SetDataObject alloc] init] SetDataHomeAndItemActivity:itemActivityDict homeActivityDict:homeActivityDict completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)EditItem_UpdateAlgoliaData:(NSDictionary *)setDataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[SetDataObject alloc] init] UpdateDataEditAlgoliaObject:setDataDict[@"ItemUniqueID"] dictToUse:[setDataDict mutableCopy] completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

#pragma mark

-(void)EditItem_CompletionBlock:(NSDictionary *)setDataDict {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self->topView removeFromSuperview];
        [self->progressView setHidden:YES];
        [self DismissViewController:self];
        
    });
    
}


#pragma mark - Delete Item

-(void)DeleteItem_UpdateItemToEditDict {
    
    [self->_itemToEditDict setObject:@"Yes" forKey:@"ItemDeleted"];
    
}

-(void)DeleteItem_SetLocalItemData {
    
    [[[GeneralObject alloc] init] CallNSNotificationMethods:@"DeleteTask" userInfo:self->_itemToEditDict locations:@[@"Tasks", @"Calendar"]];
    
}

#pragma mark

-(void)DeleteItem_DeleteItemData:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *itemType = [[[GeneralObject alloc] init] GenerateItemType];
        
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
                                                                                                           itemType:itemType];
        
        NSString *notificationItemType = itemType;
        
        NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
        
        [[[DeleteDataObject alloc] init] DeleteDataItemCompletely:self->_itemToEditDict homeID:homeID itemType:itemType keyArray:self->keyArray homeMembersArray:self->_homeMembersArray homeMembersDict:self->_homeMembersDict notificationSettingsDict:self->_notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType topicDict:self->_topicDict taskListDict:[self->_taskListDict mutableCopy] allItemTagsArrays:self->_allItemTagsArrays currentViewController:self completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningUpdatedTaskListDict) {
            
            self->_taskListDict = [[[GeneralObject alloc] init] GenerateUpdatedTaskListDict:@[returningUpdatedTaskListDict] taskListDict:self->_taskListDict];
            
        }];
        
    });
    
}

#pragma mark

-(void)DeleteItem_CompletionBlock {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self->progressView setHidden:YES];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"ViewDidLoadShouldStart"];
        
        [self NSNotificationObservers:YES];
        
        if (self->_viewingAddExpenseViewController) {
            
            [[[PushObject alloc] init] PushToTasksNavigationController:NO Expenses:YES Lists:NO Animated:YES currentViewController:self];
            
        } else {
            
            [[[PushObject alloc] init] PushToTasksNavigationController:YES Expenses:NO Lists:NO Animated:YES currentViewController:self];
            
        }
        
    });
    
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Sub-Internal Methods
#pragma mark
#pragma mark
#pragma mark -

#pragma mark SetDataDict

-(NSString *)GenerateDueDateWithoutWeekday:(NSString *)itemDueDate {
    
    if ([itemDueDate containsString:@"Mon, "]) {
        
        NSArray *arr = [itemDueDate componentsSeparatedByString:@"Mon, "];
        
        if ([arr count] > 1) {
            itemDueDate = arr[1];
        }
        
    } else if ([itemDueDate containsString:@"Tue, "]) {
        
        NSArray *arr = [itemDueDate componentsSeparatedByString:@"Tue, "];
        
        if ([arr count] > 1) {
            itemDueDate = arr[1];
        }
        
    } else if ([itemDueDate containsString:@"Wed, "]) {
        
        NSArray *arr = [itemDueDate componentsSeparatedByString:@"Wed, "];
        
        if ([arr count] > 1) {
            itemDueDate = arr[1];
        }
        
    } else if ([itemDueDate containsString:@"Thu, "]) {
        
        NSArray *arr = [itemDueDate componentsSeparatedByString:@"Thu, "];
        
        if ([arr count] > 1) {
            itemDueDate = arr[1];
        }
        
    } else if ([itemDueDate containsString:@"Fri, "]) {
        
        NSArray *arr = [itemDueDate componentsSeparatedByString:@"Fri, "];
        
        if ([arr count] > 1) {
            itemDueDate = arr[1];
        }
        
    } else if ([itemDueDate containsString:@"Sat, "]) {
        
        NSArray *arr = [itemDueDate componentsSeparatedByString:@"Sat, "];
        
        if ([arr count] > 1) {
            itemDueDate = arr[1];
        }
        
    } else if ([itemDueDate containsString:@"Sun, "]) {
        
        NSArray *arr = [itemDueDate componentsSeparatedByString:@"Sun, "];
        
        if ([arr count] > 1) {
            itemDueDate = arr[1];
        }
        
    }
    
    return itemDueDate;
}

-(NSString *)GenerateItemDueDate_MultipleDueDates {
    
    NSString *dateStringCurrent = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:@"MMMM dd, yyyy hh:mm a" returnAs:[NSString class]];
    
    NSString *possibleNewDueDate = @"";
    
    BOOL FutureDateFound = false;
    
    for (NSString *dueDate in itemSpecificDueDatesArray) {
        
        NSString *itemDueDate = [self GenerateDueDateWithoutWeekday:dueDate];
        
        NSTimeInterval secondsBetweenHour = [[[GeneralObject alloc] init] GenerateTimeIntervalBetweenTwoDates:dateStringCurrent dateString2:itemDueDate dateFormat:@"MMMM dd, yyyy hh:mm a"];
        
        if (secondsBetweenHour >= 0) {
            
            possibleNewDueDate = itemDueDate;
            FutureDateFound = true;
            break;
            
        }
        
    }
    
    if (FutureDateFound == false) {
        possibleNewDueDate = [itemSpecificDueDatesArray count] > itemSpecificDueDatesArray.count-1 ? itemSpecificDueDatesArray[itemSpecificDueDatesArray.count-1] : @"No Due Date";
        possibleNewDueDate = [self GenerateDueDateWithoutWeekday:possibleNewDueDate];
    }
    
    possibleNewDueDate = [self GenerateDueDateWithoutWeekday:possibleNewDueDate];
    possibleNewDueDate = [[[GeneralObject alloc] init] GenerateStringWithReplacementString:possibleNewDueDate stringToReplace:@"Any Time" replacementString:@"11:59 PM"];
    
    return possibleNewDueDate;
}

-(NSString *)GenerateItemDueDate_Repeating:(NSString *)itemRepeats itemTime:(NSString *)itemTime itemDays:(NSString *)itemDays itemRepeatIfCompletedEarly:(NSString *)itemRepeatIfCompletedEarly itemCompleteAsNeeded:(NSString *)itemCompleteAsNeeded itemDueDatesSkipped:(NSMutableArray *)itemDueDatesSkipped itemDueDate:(NSString *)itemDueDate itemDateLastReset:(NSString *)itemDateLastReset {
    
    //Set Up Data And Avoid Bugs
    if ([itemDueDate containsString:@"No Due Date"]) {
        itemDueDate = @"";
    }
    
    NSString *itemDatePosted = self->chosenItemDatePosted;
    NSString *dateFormat = @"MMMM dd, yyyy hh:mm a";
   
    if ([[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:itemDatePosted returnAs:[NSDate class]] == nil) {
        itemDatePosted = [[[GeneralObject alloc] init] GenerateDateWithConvertedFormatWithFormat:@"yyyy-MM-dd HH:mm:ss" dateToConvert:itemDatePosted newFormat:dateFormat returnAs:[NSString class]];
    }
   
    NSString *itemStartDate = [self GenerateItemStartDate:itemRepeats itemDatePosted:itemDatePosted];
    NSString *itemEndDate = [self GenerateItemEndDate:itemRepeats];
    
    
    
    //Make Sure Due Date Does Not Change If Editing And Fields Are The Same
    BOOL EditingTaskWithoutAlteringDueDateData =
    (_editingTask == YES &&
     self->_itemToEditDict[@"ItemRepeats"] && [self->_itemToEditDict[@"ItemRepeats"] isEqualToString:itemRepeats] &&
     self->_itemToEditDict[@"ItemRepeatIfCompletedEarly"] && [self->_itemToEditDict[@"ItemRepeatIfCompletedEarly"] isEqualToString:itemRepeatIfCompletedEarly] &&
     self->_itemToEditDict[@"ItemDays"] && [self->_itemToEditDict[@"ItemDays"] isEqualToString:itemDays] &&
     self->_itemToEditDict[@"ItemStartDate"] && [self->_itemToEditDict[@"ItemStartDate"] isEqualToString:itemStartDate] &&
     self->_itemToEditDict[@"ItemEndDate"] && [self->_itemToEditDict[@"ItemEndDate"] isEqualToString:itemEndDate]);
    
    [[NSUserDefaults standardUserDefaults] setObject:EditingTaskWithoutAlteringDueDateData ? @"Yes" : @"No" forKey:@"EditingTaskWithoutAlteringDueDateData"];
    [[NSUserDefaults standardUserDefaults] setObject:EditingTaskWithoutAlteringDueDateData ? @"Yes" : @"No" forKey:@"EditingTaskWithoutAlteringDueDateData1"];
    [[NSUserDefaults standardUserDefaults] setObject:EditingTaskWithoutAlteringDueDateData == NO ? @"Yes" : @"No" forKey:@"AddingTaskForTheFirstTime1"];
    
    
    
    //Make Sure There Is No Unnecessary Looping If Task Is Past Due
    BOOL TaskIsPastDue = [[[BoolDataObject alloc] init] TaskIsPastDue:_itemToEditDict itemType:itemType];
    int maxAmountOfDueDatesToLoopThrough = TaskIsPastDue == YES ? 1 : 1000;
    
    //Check If Start Date Should Be Skipped When Looking For Next Valid Due Date
    BOOL SkipStartDate = [self SkipStartDate:[itemStartDate mutableCopy] itemRepeats:[itemRepeats mutableCopy]];
    
    
    
    //First Iteration Should Always Be Equal To YES Here Because It Will Look For The First Future Due Date Even If The First Future Due Date Is The Current Item Due Date
    //If First Iteration Is Equal To NO It Will Ignore The First Future Due Date If It Happens To Be The Current Item Due Date
    NSLog(@"testing %@ing1 itemDatePosted:%@ itemDays:%@", _editingTask == YES ? @"Edit" : @"Add", itemDatePosted, itemDays);
    NSLog(@"testing %@ing1.1 itemRepeats:%@ itemRepeatIfCompletedEarly:%@ itemDatePosted:%@ itemDueDate:%@ itemStartDate:%@ itemEndDate:%@ itemTime:%@ itemDays:%@", _editingTask == YES ? @"Edit" : @"Add", itemRepeats, itemRepeatIfCompletedEarly, itemDatePosted, itemDueDate, itemStartDate, itemEndDate, itemTime, itemDays);
    NSMutableArray *newItemDueDateArray = [[[NotificationsObject alloc] init] GenerateArrayOfRepeatingDueDates:itemRepeats itemRepeatIfCompletedEarly:itemRepeatIfCompletedEarly itemCompleteAsNeeded:itemCompleteAsNeeded totalAmountOfFutureDates:2 maxAmountOfDueDatesToLoopThrough:maxAmountOfDueDatesToLoopThrough itemDatePosted:itemDatePosted itemDueDate:itemDueDate itemStartDate:itemStartDate itemEndDate:itemEndDate itemTime:itemTime itemDays:itemDays itemDueDatesSkipped:itemDueDatesSkipped itemDateLastReset:itemDateLastReset SkipStartDate:SkipStartDate];
    NSString *newItemDueDate = [newItemDueDateArray count] > 0 ? newItemDueDateArray[0] : @"No Due Date";
    NSLog(@"testing %@ing2 newItemDueDate:%@", _editingTask == YES ? @"Edit" : @"Add", newItemDueDate);
    
    
    
    //Make Sure Due Date Is Valid
    newItemDueDate = [[[GeneralObject alloc] init] GenerateStringWithReplacementString:newItemDueDate stringToReplace:@"Any Time" replacementString:@"11:59 PM"];
    
    if ([newItemDueDate isEqualToString:itemDatePosted] && itemDueDate.length > 0 && itemDueDate != nil && itemDueDate != NULL && [itemDueDate containsString:@"(null)"] == NO) {
        newItemDueDate = itemDueDate;
    }
    
    newItemDueDate = [[[GeneralObject alloc] init] GenerateStringWithReplacementString:newItemDueDate stringToReplace:@"Any Time" replacementString:@"11:59 PM"];
    
    
    
    return newItemDueDate;
}

#pragma mark - Template Context Menu Actions

-(IBAction)SelectTemplate:(id)sender templateName:(NSString *)templateName {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"SelectTemplate Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    if ([self->selectedTemplate length] != 0 && self->_templateDict[@"TemplateName"] && [self->_templateDict[@"TemplateName"] containsObject:templateName]) {
        
        selectedTemplate = templateName;
        
        NSUInteger index = self->_templateDict[@"TemplateName"] && [self->_templateDict[@"TemplateName"] containsObject:templateName] ? [self->_templateDict[@"TemplateName"] indexOfObject:templateName] : 0;
        NSMutableDictionary *templateData = self->_templateDict[@"TemplateData"] && [(NSArray *)self->_templateDict[@"TemplateData"] count] > index ? [self->_templateDict[@"TemplateData"][index] mutableCopy] : [NSMutableDictionary dictionary];
        
        [self EditingUserData:templateData];
        [self MoreOptionsData:templateData];
        
        [self viewDidLayoutSubviews];
        
    } else {
        
        NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
        
        [dataDict setObject:@[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] forKey:@"ItemAssignedTo"];
        [dataDict setObject:@"Never" forKey:@"ItemRepeats"];
        [dataDict setObject:@"No Due Date" forKey:@"ItemDate"];
        [dataDict setObject:@"No Due Date" forKey:@"ItemDueDate"];
        
        [self EditingUserData:dataDict];
        [self MoreOptionsData:dataDict];
        [self viewDidLayoutSubviews];
        
    }
    
}

#pragma mark - Draft Context Menu Actions

-(IBAction)SelectDraft:(id)sender draftName:(NSString *)draftName {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"SelectDraft Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    if ([self->selectedDraft length] != 0 && self->_draftDict[@"DraftName"] && [self->_draftDict[@"DraftName"] containsObject:draftName]) {
        
        selectedDraft = draftName;
        
        NSUInteger index = self->_draftDict[@"DraftName"] && [self->_draftDict[@"DraftName"] containsObject:draftName] ? [self->_draftDict[@"DraftName"] indexOfObject:draftName] : 0;
        NSMutableDictionary *draftData = self->_draftDict[@"DraftData"] && [(NSArray *)self->_draftDict[@"DraftData"] count] > index ? [self->_draftDict[@"DraftData"][index] mutableCopy] : [NSMutableDictionary dictionary];
        
        [self EditingUserData:draftData];
        [self MoreOptionsData:draftData];
        
        [self viewDidLayoutSubviews];
        
    } else {
        
        NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
        
        [self EditingUserData:dataDict];
        [self MoreOptionsData:dataDict];
        [self viewDidLayoutSubviews];
        
    }
    
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Sub-Sub-Internal Methods
#pragma mark
#pragma mark
#pragma mark -

#pragma mark SetDataDict

-(BOOL)SkipStartDate:(NSString *)itemStartDate itemRepeats:(NSString *)itemRepeats {
    
    BOOL SkipStartDate = NO;
    
    if (_editingTask == YES) {
        
        if ([itemStartDate isEqualToString:@"Now"]) {
            itemStartDate = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:@"MMMM dd, yyyy" returnAs:[NSString class]];
            itemStartDate = [NSString stringWithFormat:@"%@ 11:59 PM", itemStartDate];
        }
        
        if ([itemStartDate containsString:@"12:00 AM"]) {
            itemStartDate = [itemStartDate stringByReplacingOccurrencesOfString:@"12:00 AM" withString:@"11:59 PM"];
        }
        
        BOOL ItemStartDateSelected = [[[BoolDataObject alloc] init] ItemStartDateSelected:[@{@"ItemStartDate" : itemStartDate, @"ItemRepeats" : itemRepeats} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType]];
        BOOL ItemCurrentDueDateIsLaterThanStartDate = [[[GeneralObject alloc] init] GenerateTimeIntervalBetweenTwoDates:itemStartDate dateString2:_itemToEditDict[@"ItemDueDate"] ? _itemToEditDict[@"ItemDueDate"] : @"" dateFormat:@"MMMM dd, yyyy hh:mm a"] > 0;
        SkipStartDate = ItemStartDateSelected == YES && ItemCurrentDueDateIsLaterThanStartDate == YES;
        
    }
    
    return SkipStartDate;
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Temp Methods
#pragma mark
#pragma mark
#pragma mark -

#pragma mark Text Option Methods

-(void)SetUpToolbar {
    
    _toolbarView.hidden = YES;
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    _toolbarView.frame = CGRectMake(0, height, self.view.frame.size.width, (self.view.frame.size.height*0.05561993 > 48?48:(self.view.frame.size.height*0.05561993)));
    
    _customToolbarScrollView.frame = CGRectMake(0, 0, _toolbarView.frame.size.width, _toolbarView.frame.size.height);
    _customToolbarScrollView.contentSize = CGSizeMake(0, _customToolbarScrollView.frame.size.height);
    _customToolbarScrollView.backgroundColor = [UIColor colorWithRed:252.0f/255.0f green:252.0f/255.0f blue:252.0f/255.0f alpha:1.0f];
    _customToolbarScrollView.scrollEnabled = NO;
    _customToolbarScrollView.pagingEnabled = NO;
    
    //[self.view bringSubviewToFront:_toolbarView];
    
    height = CGRectGetHeight(self->_customToolbarScrollView.bounds);
    //CGFloat width = CGRectGetWidth(self->_customToolbarScrollView.bounds);
    
    CGFloat spacing = width*0.07;
    CGFloat itemWidth = _toolbarView.frame.size.height*0.4167;
    CGFloat itemHeight = _toolbarView.frame.size.height*0.4167;
    
    notesTextOptionsPremiumImage = [[UIImageView alloc] initWithFrame:CGRectMake(_toolbarView.frame.size.height*0.15625, _toolbarView.frame.size.height*0.15625, _toolbarView.frame.size.height*0.26041667, _toolbarView.frame.size.height*0.26041667)];
    notesTextOptionsPremiumImage.image = [UIImage imageNamed:@"MainCellIcons.PremiumStar.png"];
    notesTextOptionsPremiumImage.hidden = [[[BoolDataObject alloc] init] PremiumSubscriptionIsOn] ? YES : NO;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TextType:)];
    
    boldTextImage = [[UIImageView alloc] initWithFrame:CGRectMake(spacing, height*0.5 - itemHeight*0.5, itemWidth, itemHeight)];
    boldTextImage.image = [UIImage systemImageNamed:@"bold"];
    boldTextImage.tintColor = [UIColor lightGrayColor];
    boldTextImage.tag = 1;
    [boldTextImage addGestureRecognizer:tapGesture];
    boldTextImage.userInteractionEnabled = YES;
    boldTextImage.contentMode = UIViewContentModeScaleAspectFill;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TextType:)];
    
    italicTextImage = [[UIImageView alloc] initWithFrame:CGRectMake(boldTextImage.frame.origin.x + boldTextImage.frame.size.width + spacing, height*0.5 - itemHeight*0.5, itemWidth, itemHeight)];
    italicTextImage.image = [UIImage systemImageNamed:@"italic"];
    italicTextImage.tintColor = [UIColor lightGrayColor];
    italicTextImage.tag = 2;
    [italicTextImage addGestureRecognizer:tapGesture];
    italicTextImage.userInteractionEnabled = YES;
    italicTextImage.contentMode = UIViewContentModeScaleAspectFill;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TextType:)];
    
    underlineTextImage = [[UIImageView alloc] initWithFrame:CGRectMake(italicTextImage.frame.origin.x + italicTextImage.frame.size.width + spacing, height*0.5 - itemHeight*0.5, itemWidth, itemHeight)];
    underlineTextImage.image = [UIImage systemImageNamed:@"underline"];
    underlineTextImage.tintColor = [UIColor lightGrayColor];
    underlineTextImage.tag = 3;
    [underlineTextImage addGestureRecognizer:tapGesture];
    underlineTextImage.userInteractionEnabled = YES;
    underlineTextImage.contentMode = UIViewContentModeScaleAspectFill;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TextType:)];
    
    fontImage = [[UIImageView alloc] initWithFrame:CGRectMake(underlineTextImage.frame.origin.x + underlineTextImage.frame.size.width + spacing, height*0.5 - itemHeight*0.5, itemWidth, itemHeight)];
    fontImage.image = [UIImage systemImageNamed:@"textformat.size.smaller"];
    fontImage.tintColor = [UIColor lightGrayColor];
    fontImage.tag = 4;
    [fontImage addGestureRecognizer:tapGesture];
    fontImage.userInteractionEnabled = YES;
    fontImage.contentMode = UIViewContentModeScaleAspectFill;
    
    fontImageButton = [[UIButton alloc] initWithFrame:CGRectMake(fontImage.frame.origin.x - 6.25, fontImage.frame.origin.y - 6.25, fontImage.frame.size.width + 12.5, fontImage.frame.size.height + 12.5)];
    [fontImageButton setTitle:@"" forState:UIControlStateNormal];
    //    fontImageButton.backgroundColor = [UIColor redColor];
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TextType:)];
    
    fontSizeImage = [[UIImageView alloc] initWithFrame:CGRectMake(fontImage.frame.origin.x + fontImage.frame.size.width + spacing, height*0.5 - itemHeight*0.5, itemWidth, itemHeight)];
    fontSizeImage.image = [UIImage systemImageNamed:@"textformat.size"];
    fontSizeImage.tintColor = [UIColor lightGrayColor];
    fontSizeImage.tag = 5;
    [fontSizeImage addGestureRecognizer:tapGesture];
    fontSizeImage.userInteractionEnabled = YES;
    fontSizeImage.contentMode = UIViewContentModeScaleAspectFill;
    
    fontSizeImageButton = [[UIButton alloc] initWithFrame:CGRectMake(fontSizeImage.frame.origin.x - 6.25, fontSizeImage.frame.origin.y - 6.25, fontSizeImage.frame.size.width + 12.5, fontSizeImage.frame.size.height + 12.5)];
    [fontSizeImageButton setTitle:@"" forState:UIControlStateNormal];
    //    fontSizeImageButton.backgroundColor = [UIColor redColor];
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TextType:)];
    
    textColorImage = [[UIImageView alloc] initWithFrame:CGRectMake(fontSizeImage.frame.origin.x + fontSizeImage.frame.size.width + spacing, height*0.5 - itemHeight*0.5, itemWidth, itemHeight)];
    textColorImage.image = [UIImage systemImageNamed:@"paintbrush.pointed"];
    textColorImage.tintColor = [UIColor lightGrayColor];
    textColorImage.tag = 6;
    [textColorImage addGestureRecognizer:tapGesture];
    textColorImage.userInteractionEnabled = YES;
    textColorImage.contentMode = UIViewContentModeScaleAspectFill;
    
    textColorImageButton = [[UIButton alloc] initWithFrame:CGRectMake(textColorImage.frame.origin.x - 6.25, textColorImage.frame.origin.y - 6.25, textColorImage.frame.size.width + 12.5, textColorImage.frame.size.height + 12.5)];
    [textColorImageButton setTitle:@"" forState:UIControlStateNormal];
    //    textColorImageButton.backgroundColor = [UIColor redColor];
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TextType:)];
    
    backgroundColorImage = [[UIImageView alloc] initWithFrame:CGRectMake(textColorImage.frame.origin.x + textColorImage.frame.size.width + spacing, height*0.5 - itemHeight*0.5, itemWidth, itemHeight)];
    backgroundColorImage.image = [UIImage systemImageNamed:@"paintbrush"];
    backgroundColorImage.tintColor = [UIColor lightGrayColor];
    backgroundColorImage.tag = 7;
    [backgroundColorImage addGestureRecognizer:tapGesture];
    backgroundColorImage.userInteractionEnabled = YES;
    backgroundColorImage.contentMode = UIViewContentModeScaleAspectFill;
    
    backgroundColorImageButton = [[UIButton alloc] initWithFrame:CGRectMake(backgroundColorImage.frame.origin.x - 6.25, backgroundColorImage.frame.origin.y - 6.25, backgroundColorImage.frame.size.width + 12.5, backgroundColorImage.frame.size.height + 12.5)];
    [backgroundColorImageButton setTitle:@"" forState:UIControlStateNormal];
    //    backgroundColorImageButton.backgroundColor = [UIColor redColor];
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TextType:)];
    
    highlightImage = [[UIImageView alloc] initWithFrame:CGRectMake(backgroundColorImage.frame.origin.x + backgroundColorImage.frame.size.width + spacing, height*0.5 - itemHeight*0.5, itemWidth, itemHeight)];
    highlightImage.image = [UIImage systemImageNamed:@"highlighter"];
    highlightImage.tintColor = [UIColor lightGrayColor];
    highlightImage.tag = 8;
    [highlightImage addGestureRecognizer:tapGesture];
    highlightImage.userInteractionEnabled = YES;
    highlightImage.contentMode = UIViewContentModeScaleAspectFill;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TextType:)];
    
    linkImage = [[UIImageView alloc] initWithFrame:CGRectMake(highlightImage.frame.origin.x + highlightImage.frame.size.width + spacing, height*0.5 - itemHeight*0.5, itemWidth, itemHeight)];
    linkImage.image = [UIImage systemImageNamed:@"link"];
    linkImage.tintColor = [UIColor lightGrayColor];
    linkImage.tag = 9;
    [linkImage addGestureRecognizer:tapGesture];
    linkImage.userInteractionEnabled = YES;
    linkImage.contentMode = UIViewContentModeScaleAspectFill;
    
    [_customToolbarScrollView addSubview:notesTextOptionsPremiumImage];
    
    [_customToolbarScrollView addSubview:boldTextImage];
    [_customToolbarScrollView addSubview:italicTextImage];
    [_customToolbarScrollView addSubview:underlineTextImage];
    [_customToolbarScrollView addSubview:fontImage];
    [_customToolbarScrollView addSubview:fontImageButton];
    [_customToolbarScrollView addSubview:fontSizeImage];
    [_customToolbarScrollView addSubview:fontSizeImageButton];
    
    [_customToolbarScrollView addSubview:textColorImage];
    [_customToolbarScrollView addSubview:textColorImageButton];
    [_customToolbarScrollView addSubview:backgroundColorImage];
    [_customToolbarScrollView addSubview:backgroundColorImageButton];
    [_customToolbarScrollView addSubview:highlightImage];
    //    [_customToolbarScrollView addSubview:linkImage];
    
    NSArray *arrView = @[_customToolbarScrollView];
    
    for (UIView *viewNo1 in arrView) {
        
        for (UIView *subViewNo1 in [viewNo1 subviews]) {
            
            if (subViewNo1.tag == 1111) {
                
                [subViewNo1 removeFromSuperview];
                
            }
            
        }
        
    }
    
    for (UIView *viewNo1 in arrView) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(viewNo1.frame.size.width*0.04830918, 0, viewNo1.frame.size.width - (viewNo1.frame.size.width*0.04830918), 1)];
        view.backgroundColor = [[[BoolDataObject alloc] init] DarkModeIsOn] ? [[[LightDarkModeObject alloc] init] DarkModeTextSecondary] : [[[LightDarkModeObject alloc] init] LightModeSubviewLine];
        view.tag = 1111;
        [viewNo1 addSubview:view];
        
    }
    
    _customToolbarScrollView.hidden = YES;
    //    [itemNotesTextField becomeFirstResponder];
    //
    //    NSString *string = @"(bold)bold(bold)";
    //    itemNotesTextField.text = string;
    
    //[self AttributeString:itemNotesTextField.text];
    
    //    [self SetUpFontContextMenu:YES FontSize:NO];
    //    [self SetUpFontContextMenu:NO FontSize:YES];
    //
    //    [self SetUpTextColorContextMenu:YES Background:NO];
    //    [self SetUpTextColorContextMenu:NO Background:YES];
    
}

-(void)SetUpFontContextMenu:(BOOL)Font FontSize:(BOOL)FontSize {
    
    NSArray *arr = @[@"System", @"Helvetica Neue", @"Futura", @"Impact", @"Rockwell"];
    NSArray *arr1 = @[@"8", @"12", @"16", @"24", @"32"];
    
    NSArray *arrToUse = nil;
    
    if (Font) {
        arrToUse = arr;
    } else {
        arrToUse = arr1;
    }
    
    NSMutableArray* actions = [[NSMutableArray alloc] init];
    
    for (int i=0 ; i<[arrToUse count] ; i++) {
        
        [actions addObject:[UIAction actionWithTitle:arrToUse[i] image:nil identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
            
            if (Font) {
                self->fontChosen = arrToUse[i];
                [self InsertTextType:[NSString stringWithFormat:@"(font:%@)", arrToUse[i]] replaceString:@"font"];
            } else if (FontSize) {
                self->fontSizehosen = arrToUse[i];
                [self InsertTextType:[NSString stringWithFormat:@"(fontsize:%@)", arrToUse[i]] replaceString:@"fontsize"];
            }
            
        }]];
        
    }
    
    UIButton *buttonToUse = nil;
    
    if (Font) {
        buttonToUse = fontImageButton;
    } else if (FontSize) {
        buttonToUse = fontSizeImageButton;
    }
    
    buttonToUse.menu = [UIMenu menuWithTitle:@"" children:actions];
    buttonToUse.showsMenuAsPrimaryAction = true;
    
}

-(void)SetUpTextColorContextMenu:(BOOL)TextColor Background:(BOOL)Background {
    
    NSArray *arr = @[@"None", @"Red", @"Blue", @"Yellow", @"Green", @"Orange", @"Purple", @"Pink", @"Grey", @"Black", @"White"];
    NSArray *arr1 = @[[UIColor colorWithRed:138.0f/255.0f green:137.0f/255.0f blue:142.0f/255.0f alpha:1.0f], [UIColor systemRedColor], [UIColor systemBlueColor], [UIColor systemYellowColor], [UIColor systemGreenColor], [UIColor systemOrangeColor], [UIColor systemPurpleColor], [UIColor systemPinkColor], [UIColor systemGrayColor], [UIColor blackColor], [UIColor whiteColor]];
    
    NSMutableArray* actions = [[NSMutableArray alloc] init];
    
    for (int i=0 ; i<[arr count] ; i++) {
        
        [actions addObject:[UIAction actionWithTitle:arr[i] image:[[UIImage systemImageNamed:@"square.fill"] imageWithTintColor:arr1[i] renderingMode:UIImageRenderingModeAlwaysOriginal] identifier:nil handler:^(__kindof UIAction* _Nonnull action) {
            
            if (TextColor) {
                self->textColorChosen = arr[i];
                //self->textColorImage.tintColor = arr1[i];
                [self InsertTextType:[NSString stringWithFormat:@"(textColor:%@)", arr[i]] replaceString:@"textColor"];
            } else if (Background) {
                self->backgroundColorChosen = arr[i];
                self->backgroundColorImage.tintColor = arr1[i];
                //self->textColorImage.tintColor = arr1[i];
                [self InsertTextType:[NSString stringWithFormat:@"(backgroundColor:%@)", arr[i]] replaceString:@"backgroundColor"];
            }
            
        }]];
        
    }
    
    UIButton *buttonToUse = nil;
    
    if (TextColor) {
        buttonToUse = textColorImageButton;
    } else if (Background) {
        buttonToUse = backgroundColorImageButton;
    }
    
    buttonToUse.menu = [UIMenu menuWithTitle:@"" children:actions];
    buttonToUse.showsMenuAsPrimaryAction = true;
    
}

-(void)ReturnStyle:(NSString *)textType completionHandler:(void (^)(BOOL finished, id obj, id obj1))finishBlock {
    
    id obj = nil;
    id obj1 = nil;
    
    CGFloat notesPointSize = itemNotesTextField.font.pointSize;
    
    if ([textType isEqualToString:@"(bold)"]) {
        obj = [UIFont fontWithName:@"Avenir-Heavy" size:notesPointSize];
        obj1 = NSFontAttributeName;
    } else if ([textType isEqualToString:@"(italic)"]) {
        obj = [UIFont fontWithName:@"Avenir-Heavy" size:notesPointSize];
        obj1 = NSFontAttributeName;
    } else if ([textType isEqualToString:@"(underlined)"]) {
        obj = [UIFont monospacedSystemFontOfSize:itemNotesTextField.font.pointSize weight:notesPointSize];
        obj1 = NSFontAttributeName;
    } else if ([textType isEqualToString:@"(font:System)"]) {
        obj = [UIFont systemFontOfSize:notesPointSize weight:UIFontWeightRegular];
        obj1 = NSFontAttributeName;
    } else if ([textType isEqualToString:@"(font:Helvetica Neue)"]) {
        obj = [UIFont fontWithName:@"Helvetica Neue" size:notesPointSize];
        obj1 = NSFontAttributeName;
    } else if ([textType isEqualToString:@"(font:Futura)"]) {
        obj = [UIFont fontWithName:@"Futura" size:notesPointSize];
        obj1 = NSFontAttributeName;
    } else if ([textType isEqualToString:@"(font:Impact)"]) {
        obj = [UIFont fontWithName:@"Impact" size:notesPointSize];
        obj1 = NSFontAttributeName;
    } else if ([textType isEqualToString:@"(font:Rockwell)"]) {
        obj = [UIFont fontWithName:@"Rockwell" size:notesPointSize];
        obj1 = NSFontAttributeName;
    } else if ([textType isEqualToString:@"(fontSize:8)"]) {
        obj = [UIFont systemFontOfSize:8 weight:UIFontWeightRegular];
        obj1 = NSFontAttributeName;
    } else if ([textType isEqualToString:@"(fontSize:12)"]) {
        obj = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
        obj1 = NSFontAttributeName;
    } else if ([textType isEqualToString:@"(fontSize:16)"]) {
        obj = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
        obj1 = NSFontAttributeName;
    } else if ([textType isEqualToString:@"(fontSize:24)"]) {
        obj = [UIFont systemFontOfSize:24 weight:UIFontWeightRegular];
        obj1 = NSFontAttributeName;
    } else if ([textType isEqualToString:@"(fontSize:32)"]) {
        obj = [UIFont systemFontOfSize:32 weight:UIFontWeightRegular];
        obj1 = NSFontAttributeName;
    } else if ([textType isEqualToString:@"(textColor:Red)"]) {
        obj = [UIColor colorWithRed:255.0f/255.0f green:59.0f/255.0f blue:48.0f/255.0f alpha:1.0f];
        obj1 = NSForegroundColorAttributeName;
    } else if ([textType isEqualToString:@"(textColor:Blue)"]) {
        obj = [UIColor colorWithRed:0.0f/255.0f green:122.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
        obj1 = NSForegroundColorAttributeName;
    } else if ([textType isEqualToString:@"(textColor:Yellow)"]) {
        obj = [UIColor colorWithRed:255.0f/255.0f green:204.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
        obj1 = NSForegroundColorAttributeName;
    } else if ([textType isEqualToString:@"(textColor:Green)"]) {
        obj = [UIColor colorWithRed:52.0f/255.0f green:199.0f/255.0f blue:89.0f/255.0f alpha:1.0f];
        obj1 = NSForegroundColorAttributeName;
    } else if ([textType isEqualToString:@"(textColor:Orange)"]) {
        obj = [UIColor colorWithRed:255.0f/255.0f green:149.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
        obj1 = NSForegroundColorAttributeName;
    } else if ([textType isEqualToString:@"(textColor:Purple)"]) {
        obj = [UIColor colorWithRed:175.0f/255.0f green:82.0f/255.0f blue:222.0f/255.0f alpha:1.0f];
        obj1 = NSForegroundColorAttributeName;
    } else if ([textType isEqualToString:@"(textColor:Pink)"]) {
        obj = [UIColor colorWithRed:255.0f/255.0f green:45.0f/255.0f blue:85.0f/255.0f alpha:1.0f];
        obj1 = NSForegroundColorAttributeName;
    } else if ([textType isEqualToString:@"(textColor:Grey)"]) {
        obj = [UIColor colorWithRed:138.0f/255.0f green:137.0f/255.0f blue:142.0f/255.0f alpha:1.0f];
        obj1 = NSForegroundColorAttributeName;
    } else if ([textType isEqualToString:@"(textColor:Black)"]) {
        obj = [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
        obj1 = NSForegroundColorAttributeName;
    } else if ([textType isEqualToString:@"(backgroundColor:Red)"]) {
        obj = [UIColor colorWithRed:255.0f/255.0f green:59.0f/255.0f blue:48.0f/255.0f alpha:1.0f];
        obj1 = NSBackgroundColorAttributeName;
    } else if ([textType isEqualToString:@"(backgroundColor:Blue)"]) {
        obj = [UIColor colorWithRed:0.0f/255.0f green:122.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
        obj1 = NSBackgroundColorAttributeName;
    } else if ([textType isEqualToString:@"(backgroundColor:Yellow)"]) {
        obj = [UIColor colorWithRed:255.0f/255.0f green:204.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
        obj1 = NSBackgroundColorAttributeName;
    } else if ([textType isEqualToString:@"(backgroundColor:Green)"]) {
        obj = [UIColor colorWithRed:52.0f/255.0f green:199.0f/255.0f blue:89.0f/255.0f alpha:1.0f];
        obj1 = NSBackgroundColorAttributeName;
    } else if ([textType isEqualToString:@"(backgroundColor:Orange)"]) {
        obj = [UIColor colorWithRed:255.0f/255.0f green:149.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
        obj1 = NSBackgroundColorAttributeName;
    } else if ([textType isEqualToString:@"(backgroundColor:Purple)"]) {
        obj = [UIColor colorWithRed:175.0f/255.0f green:82.0f/255.0f blue:222.0f/255.0f alpha:1.0f];
        obj1 = NSBackgroundColorAttributeName;
    } else if ([textType isEqualToString:@"(backgroundColor:Pink)"]) {
        obj = [UIColor colorWithRed:255.0f/255.0f green:45.0f/255.0f blue:85.0f/255.0f alpha:1.0f];
        obj1 = NSBackgroundColorAttributeName;
    } else if ([textType isEqualToString:@"(backgroundColor:Grey)"]) {
        obj = [UIColor colorWithRed:138.0f/255.0f green:137.0f/255.0f blue:142.0f/255.0f alpha:1.0f];
        obj1 = NSBackgroundColorAttributeName;
    } else if ([textType isEqualToString:@"(backgroundColor:Black)"]) {
        obj = [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
        obj1 = NSBackgroundColorAttributeName;
    } else if ([textType isEqualToString:@"(highlighter)"]) {
        obj = [UIColor colorWithRed:255.0f/255.0f green:204.0f/255.0f blue:0.0f/255.0f alpha:0.5f];
        obj1 = NSBackgroundColorAttributeName;
    }
    
    finishBlock(YES, obj, obj1);
}

-(void)AttributeString:(NSString *)string {
    
    NSMutableDictionary *superDdict = [NSMutableDictionary dictionary];
    NSArray *textTypeArr = @[
        @"(bold)", @"(italic)", @"(underline)",
        @"(fontSize:8)", @"(fontSize:12)", @"(fontSize:16)", @"(fontSize:24)", @"(fontSize:32)",
        @"(font:System)", @"(font:Helvetica Neue)", @"(font:Futura)", @"(font:Impact)", @"(font:Rockwell)",
        @"(textColor:Red)", @"(textColor:Blue)", @"(textColor:Yellow)", @"(textColor:Green)", @"(textColor:Orange)", @"(textColor:Purple)", @"(textColor:Pink)", @"(textColor:Grey)", @"(textColor:Black)", @"(textColor:White)",
        @"(backgroundColor:Red)", @"(backgroundColor:Blue)", @"(backgroundColor:Yellow)", @"(backgroundColor:Green)", @"(backgroundColor:Orange)", @"(backgroundColor:Purple)", @"(backgroundColor:Pink)", @"(backgroundColor:Grey)", @"(backgroundColor:Black)", @"(backgroundColor:White)",
        @"(highlighter)"];
    
    for (NSString *textType in textTypeArr) {
        
        NSMutableArray *arr = [NSMutableArray array];
        
        NSRange searchRange = NSMakeRange(0,string.length);
        NSRange foundRange;
        
        while (searchRange.location < string.length) {
            
            searchRange.length = string.length-searchRange.location;
            foundRange = [string rangeOfString:textType options:0 range:searchRange];
            
            if (foundRange.location != NSNotFound) {
                
                searchRange.location = foundRange.location+foundRange.length;
                
                NSRange range1 = foundRange;
                
                [arr addObject:@{@"textType" : textType, @"location" : [NSString stringWithFormat:@"%lu", range1.location], @"length" : [NSString stringWithFormat:@"%lu", range1.length]}];
                [superDdict setObject:arr forKey:textType];
                
            } else {
                
                // no more substring to find
                [superDdict setObject:arr forKey:textType];
                break;
                
            }
            
        }
        
    }
    
    NSDictionary *dictNo1 = [NSDictionary dictionary];
    NSDictionary *dictNo2 = [NSDictionary dictionary];
    NSDictionary *dictNo3 = [NSDictionary dictionary];
    NSDictionary *dictNo4 = [NSDictionary dictionary];
    NSDictionary *dictNo5 = [NSDictionary dictionary];
    NSDictionary *dictNo6 = [NSDictionary dictionary];
    NSDictionary *dictNo7 = [NSDictionary dictionary];
    NSDictionary *dictNo8 = [NSDictionary dictionary];
    NSDictionary *dictNo9 = [NSDictionary dictionary];
    NSDictionary *dictNo10 = [NSDictionary dictionary];
    NSDictionary *dictNo11 = [NSDictionary dictionary];
    NSDictionary *dictNo12 = [NSDictionary dictionary];
    
    //    NSRange rangeOfAttributeNo1 = NSMakeRange(-1, -1);
    //    NSRange rangeOfAttributeNo2 = NSMakeRange(-1, -1);
    //
    //    NSRange rangeOfAttributeNo3 = NSMakeRange(-1, -1);
    //    NSRange rangeOfAttributeNo4 = NSMakeRange(-1, -1);
    //
    //    NSRange rangeOfAttributeNo5 = NSMakeRange(-1, -1);
    //    NSRange rangeOfAttributeNo6 = NSMakeRange(-1, -1);
    //
    //    NSRange rangeOfAttributeNo7 = NSMakeRange(-1, -1);
    //    NSRange rangeOfAttributeNo8 = NSMakeRange(-1, -1);
    //
    //    NSRange rangeOfAttributeNo9 = NSMakeRange(-1, -1);
    //    NSRange rangeOfAttributeNo10 = NSMakeRange(-1, -1);
    //
    //    NSRange rangeOfAttributeNo11 = NSMakeRange(-1, -1);
    //    NSRange rangeOfAttributeNo12 = NSMakeRange(-1, -1);
    
    NSRange rangeOfTextBetweenAttributesNo1 = NSMakeRange(-1, -1);
    NSRange rangeOfTextBetweenAttributesNo2 = NSMakeRange(-1, -1);
    NSRange rangeOfTextBetweenAttributesNo3 = NSMakeRange(-1, -1);
    NSRange rangeOfTextBetweenAttributesNo4 = NSMakeRange(-1, -1);
    NSRange rangeOfTextBetweenAttributesNo5 = NSMakeRange(-1, -1);
    NSRange rangeOfTextBetweenAttributesNo6 = NSMakeRange(-1, -1);
    
    for (NSString *textType in [superDdict allKeys]) {
        
        for (NSDictionary *dict in superDdict[textType]) {
            
            NSUInteger location = [dict[@"location"] intValue];
            NSUInteger length = [dict[@"length"] intValue];
            
            if ([[dictNo1 allKeys] count] == 0) {
                
                dictNo1 = @{@"textType" : textType, @"location" : [NSString stringWithFormat:@"%lu", location], @"length" : [NSString stringWithFormat:@"%lu", length]};
                
            } else if ([[dictNo2 allKeys] count] == 0) {
                
                dictNo2 = @{@"textType" : textType, @"location" : [NSString stringWithFormat:@"%lu", location], @"length" : [NSString stringWithFormat:@"%lu", length]};
                
            } else if ([[dictNo3 allKeys] count] == 0) {
                
                dictNo3 = @{@"textType" : textType, @"location" : [NSString stringWithFormat:@"%lu", location], @"length" : [NSString stringWithFormat:@"%lu", length]};
                
            } else if ([[dictNo4 allKeys] count] == 0) {
                
                dictNo4 = @{@"textType" : textType, @"location" : [NSString stringWithFormat:@"%lu", location], @"length" : [NSString stringWithFormat:@"%lu", length]};
                
            } else if ([[dictNo5 allKeys] count] == 0) {
                
                dictNo5 = @{@"textType" : textType, @"location" : [NSString stringWithFormat:@"%lu", location], @"length" : [NSString stringWithFormat:@"%lu", length]};
                
            } else if ([[dictNo6 allKeys] count] == 0) {
                
                dictNo6 = @{@"textType" : textType, @"location" : [NSString stringWithFormat:@"%lu", location], @"length" : [NSString stringWithFormat:@"%lu", length]};
                
            } else if ([[dictNo7 allKeys] count] == 0) {
                
                dictNo7 = @{@"textType" : textType, @"location" : [NSString stringWithFormat:@"%lu", location], @"length" : [NSString stringWithFormat:@"%lu", length]};
                
            } else if ([[dictNo8 allKeys] count] == 0) {
                
                dictNo8 = @{@"textType" : textType, @"location" : [NSString stringWithFormat:@"%lu", location], @"length" : [NSString stringWithFormat:@"%lu", length]};
                
            } else if ([[dictNo9 allKeys] count] == 0) {
                
                dictNo9 = @{@"textType" : textType, @"location" : [NSString stringWithFormat:@"%lu", location], @"length" : [NSString stringWithFormat:@"%lu", length]};
                
            } else if ([[dictNo10 allKeys] count] == 0) {
                
                dictNo10 = @{@"textType" : textType, @"location" : [NSString stringWithFormat:@"%lu", location], @"length" : [NSString stringWithFormat:@"%lu", length]};
                
            } else if ([[dictNo11 allKeys] count] == 0) {
                
                dictNo11 = @{@"textType" : textType, @"location" : [NSString stringWithFormat:@"%lu", location], @"length" : [NSString stringWithFormat:@"%lu", length]};
                
            } else if ([[dictNo12 allKeys] count] == 0) {
                
                dictNo12 = @{@"textType" : textType, @"location" : [NSString stringWithFormat:@"%lu", location], @"length" : [NSString stringWithFormat:@"%lu", length]};
                
            }
            
        }
        
    }
    
    if (rangeOfTextBetweenAttributesNo1.location == -1 && [[dictNo1 allKeys] count] > 1 && [[dictNo2 allKeys] count] > 1) {
        
        NSUInteger locationNo1 = [dictNo1[@"location"] intValue];
        NSUInteger lengthNo1 = [dictNo1[@"length"] intValue];
        
        NSUInteger locationNo2 = [dictNo2[@"location"] intValue];
        
        rangeOfTextBetweenAttributesNo1 = NSMakeRange(locationNo1 + lengthNo1, locationNo2 - (locationNo1 + lengthNo1));
        
    }
    
    if (rangeOfTextBetweenAttributesNo2.location == -1 && [[dictNo3 allKeys] count] > 1 && [[dictNo4 allKeys] count] > 1) {
        
        NSUInteger locationNo1 = [dictNo3[@"location"] intValue];
        NSUInteger lengthNo1 = [dictNo3[@"length"] intValue];
        
        NSUInteger locationNo2 = [dictNo4[@"location"] intValue];
        
        rangeOfTextBetweenAttributesNo2 = NSMakeRange(locationNo1 + lengthNo1, locationNo2 - (locationNo1 + lengthNo1));
        
    }
    
    if (rangeOfTextBetweenAttributesNo3.location == -1 && [[dictNo5 allKeys] count] > 1 && [[dictNo6 allKeys] count] > 1) {
        
        NSUInteger locationNo1 = [dictNo5[@"location"] intValue];
        NSUInteger lengthNo1 = [dictNo5[@"length"] intValue];
        
        NSUInteger locationNo3 = [dictNo6[@"location"] intValue];
        
        rangeOfTextBetweenAttributesNo3 = NSMakeRange(locationNo1 + lengthNo1, locationNo3 - (locationNo1 + lengthNo1));
        
    }
    
    if (rangeOfTextBetweenAttributesNo4.location == -1 && [[dictNo7 allKeys] count] > 1 && [[dictNo8 allKeys] count] > 1) {
        
        NSUInteger locationNo1 = [dictNo7[@"location"] intValue];
        NSUInteger lengthNo1 = [dictNo7[@"length"] intValue];
        
        NSUInteger locationNo4 = [dictNo8[@"location"] intValue];
        
        rangeOfTextBetweenAttributesNo4 = NSMakeRange(locationNo1 + lengthNo1, locationNo4 - (locationNo1 + lengthNo1));
        
    }
    
    if (rangeOfTextBetweenAttributesNo5.location == -1 && [[dictNo9 allKeys] count] > 1 && [[dictNo10 allKeys] count] > 1) {
        
        NSUInteger locationNo1 = [dictNo9[@"location"] intValue];
        NSUInteger lengthNo1 = [dictNo9[@"length"] intValue];
        
        NSUInteger locationNo5 = [dictNo10[@"location"] intValue];
        
        rangeOfTextBetweenAttributesNo5 = NSMakeRange(locationNo1 + lengthNo1, locationNo5 - (locationNo1 + lengthNo1));
        
    }
    
    if (rangeOfTextBetweenAttributesNo6.location == -1 && [[dictNo11 allKeys] count] > 1 && [[dictNo12 allKeys] count] > 1) {
        
        NSUInteger locationNo1 = [dictNo11[@"location"] intValue];
        NSUInteger lengthNo1 = [dictNo11[@"length"] intValue];
        
        NSUInteger locationNo6 = [dictNo12[@"location"] intValue];
        
        rangeOfTextBetweenAttributesNo6 = NSMakeRange(locationNo1 + lengthNo1, locationNo6 - (locationNo1 + lengthNo1));
        
    }
    
    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:itemNotesTextField.textColor, NSForegroundColorAttributeName, nil];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:itemNotesTextField.text attributes:attrsDictionary];
    
    if (rangeOfTextBetweenAttributesNo1.location < 1000000 && rangeOfTextBetweenAttributesNo1.length < 1000000) {
        
        __block id obj = nil;
        __block id obj1 = nil;
        
        NSString *textType = dictNo1[@"textType"];
        
        [self ReturnStyle:textType completionHandler:^(BOOL finished, id returningObj, id returningObj1) {
            
            obj = returningObj;
            obj1 = returningObj1;
            
            [str addAttribute:obj1 value:obj range: NSMakeRange(rangeOfTextBetweenAttributesNo1.location, rangeOfTextBetweenAttributesNo1.length)];
            
        }];
        
    }
    
    if (rangeOfTextBetweenAttributesNo2.location < 1000000 && rangeOfTextBetweenAttributesNo2.length < 1000000) {
        
        __block id obj = nil;
        __block id obj1 = nil;
        
        NSString *textType = dictNo3[@"textType"];
        
        [self ReturnStyle:textType completionHandler:^(BOOL finished, id returningObj, id returningObj1) {
            
            obj = returningObj;
            obj1 = returningObj1;
            
            [str addAttribute:obj1 value:obj range: NSMakeRange(rangeOfTextBetweenAttributesNo2.location, rangeOfTextBetweenAttributesNo2.length)];
            
        }];
        
    }
    
    if (rangeOfTextBetweenAttributesNo3.location < 1000000 && rangeOfTextBetweenAttributesNo3.length < 1000000) {
        
        __block id obj = nil;
        __block id obj1 = nil;
        
        NSString *textType = dictNo5[@"textType"];
        
        [self ReturnStyle:textType completionHandler:^(BOOL finished, id returningObj, id returningObj1) {
            
            obj = returningObj;
            obj1 = returningObj1;
            
            [str addAttribute:obj1 value:obj range: NSMakeRange(rangeOfTextBetweenAttributesNo3.location, rangeOfTextBetweenAttributesNo3.length)];
            
        }];
        
    }
    
    if (rangeOfTextBetweenAttributesNo4.location < 1000000 && rangeOfTextBetweenAttributesNo4.length < 1000000) {
        
        __block id obj = nil;
        __block id obj1 = nil;
        
        NSString *textType = dictNo7[@"textType"];
        
        [self ReturnStyle:textType completionHandler:^(BOOL finished, id returningObj, id returningObj1) {
            
            obj = returningObj;
            obj1 = returningObj1;
            
            [str addAttribute:obj1 value:obj range: NSMakeRange(rangeOfTextBetweenAttributesNo4.location, rangeOfTextBetweenAttributesNo4.length)];
            
        }];
        
    }
    
    if (rangeOfTextBetweenAttributesNo5.location < 1000000 && rangeOfTextBetweenAttributesNo5.length < 1000000) {
        
        __block id obj = nil;
        __block id obj1 = nil;
        
        NSString *textType = dictNo9[@"textType"];
        
        [self ReturnStyle:textType completionHandler:^(BOOL finished, id returningObj, id returningObj1) {
            
            obj = returningObj;
            obj1 = returningObj1;
            
            [str addAttribute:obj1 value:obj range: NSMakeRange(rangeOfTextBetweenAttributesNo5.location, rangeOfTextBetweenAttributesNo5.length)];
            
        }];
        
    }
    
    if (rangeOfTextBetweenAttributesNo6.location < 1000000 && rangeOfTextBetweenAttributesNo6.length < 1000000) {
        
        __block id obj = nil;
        __block id obj1 = nil;
        
        NSString *textType = dictNo11[@"textType"];
        
        [self ReturnStyle:textType completionHandler:^(BOOL finished, id returningObj, id returningObj1) {
            
            obj = returningObj;
            obj1 = returningObj1;
            
            [str addAttribute:obj1 value:obj range: NSMakeRange(rangeOfTextBetweenAttributesNo6.location, rangeOfTextBetweenAttributesNo6.length)];
            
        }];
        
    }
    
    itemNotesTextField.attributedText = str;
    
    UITextPosition *beginning = nil;
    UITextPosition *start = nil;
    UITextPosition *end = nil;
    UITextRange *textRange = nil;
    
    if ([[dictNo1 allKeys] count] != 0) {
        
        NSUInteger locationNo1 = [dictNo1[@"location"] intValue];
        NSUInteger lengthNo1 = [dictNo1[@"length"] intValue];
        
        beginning = itemNotesTextField.beginningOfDocument;
        start = [itemNotesTextField positionFromPosition:beginning offset:locationNo1];
        end = [itemNotesTextField positionFromPosition:start offset:lengthNo1];
        textRange = [itemNotesTextField textRangeFromPosition:start toPosition:end];
        //         [self->itemNotesTextField replaceRange:textRange withText:@""];
        
    }
    
    if ([[dictNo2 allKeys] count] != 0) {
        
        NSUInteger locationNo1 = [dictNo1[@"location"] intValue];
        NSUInteger lengthNo1 = [dictNo1[@"length"] intValue];
        
        NSUInteger locationNo2 = [dictNo2[@"location"] intValue];
        NSUInteger lengthNo2 = [dictNo2[@"length"] intValue];
        
        NSUInteger remove = 0;
        
        if (locationNo1 + lengthNo1 < locationNo2) {
            remove += lengthNo1;
        }
        
        beginning = itemNotesTextField.beginningOfDocument;
        start = [itemNotesTextField positionFromPosition:beginning offset:locationNo2-remove];
        end = [itemNotesTextField positionFromPosition:start offset:lengthNo2];
        textRange = [itemNotesTextField textRangeFromPosition:start toPosition:end];
        //        [self->itemNotesTextField replaceRange:textRange withText:@""];
        
    }
    
    if ([[dictNo3 allKeys] count] != 0) {
        
        NSUInteger locationNo1 = [dictNo1[@"location"] intValue];
        NSUInteger lengthNo1 = [dictNo1[@"length"] intValue];
        
        NSUInteger locationNo2 = [dictNo2[@"location"] intValue];
        NSUInteger lengthNo2 = [dictNo2[@"length"] intValue];
        
        NSUInteger locationNo3 = [dictNo3[@"location"] intValue];
        NSUInteger lengthNo3 = [dictNo3[@"length"] intValue];
        
        NSUInteger remove = 0;
        
        if (locationNo1 + lengthNo1 <= locationNo3) {
            remove += lengthNo1;
        }
        
        if (locationNo2 + lengthNo2 <= locationNo3) {
            remove += lengthNo2;
        }
        
        beginning = itemNotesTextField.beginningOfDocument;
        start = [itemNotesTextField positionFromPosition:beginning offset:locationNo3-remove];
        end = [itemNotesTextField positionFromPosition:start offset:lengthNo3];
        textRange = [itemNotesTextField textRangeFromPosition:start toPosition:end];
        //        [self->itemNotesTextField replaceRange:textRange withText:@""];
        
    }
    
    if ([[dictNo4 allKeys] count] != 0) {
        
        NSUInteger locationNo1 = [dictNo1[@"location"] intValue];
        NSUInteger lengthNo1 = [dictNo1[@"length"] intValue];
        
        NSUInteger locationNo2 = [dictNo2[@"location"] intValue];
        NSUInteger lengthNo2 = [dictNo2[@"length"] intValue];
        
        NSUInteger locationNo3 = [dictNo3[@"location"] intValue];
        NSUInteger lengthNo3 = [dictNo3[@"length"] intValue];
        
        NSUInteger locationNo4 = [dictNo4[@"location"] intValue];
        NSUInteger lengthNo4 = [dictNo4[@"length"] intValue];
        
        NSUInteger remove = 0;
        
        if (locationNo1 + lengthNo1 <= locationNo4) {
            remove += lengthNo1;
        }
        
        if (locationNo2 + lengthNo2 <= locationNo4) {
            remove += lengthNo2;
        }
        
        if (locationNo3 + lengthNo3 <= locationNo4) {
            remove += lengthNo3;
        }
        
        beginning = itemNotesTextField.beginningOfDocument;
        start = [itemNotesTextField positionFromPosition:beginning offset:locationNo4-remove];
        end = [itemNotesTextField positionFromPosition:start offset:lengthNo4];
        textRange = [itemNotesTextField textRangeFromPosition:start toPosition:end];
        
        //        [self->itemNotesTextField replaceRange:textRange withText:@""];
        
    }
    
    if ([[dictNo5 allKeys] count] != 0) {
        
        NSUInteger locationNo1 = [dictNo1[@"location"] intValue];
        NSUInteger lengthNo1 = [dictNo1[@"length"] intValue];
        
        NSUInteger locationNo2 = [dictNo2[@"location"] intValue];
        NSUInteger lengthNo2 = [dictNo2[@"length"] intValue];
        
        NSUInteger locationNo3 = [dictNo3[@"location"] intValue];
        NSUInteger lengthNo3 = [dictNo3[@"length"] intValue];
        
        NSUInteger locationNo4 = [dictNo4[@"location"] intValue];
        NSUInteger lengthNo4 = [dictNo4[@"length"] intValue];
        
        NSUInteger locationNo5 = [dictNo5[@"location"] intValue];
        NSUInteger lengthNo5 = [dictNo5[@"length"] intValue];
        
        NSUInteger remove = 0;
        
        if (locationNo1 + lengthNo1 <= locationNo5) {
            remove += lengthNo1;
        }
        
        if (locationNo2 + lengthNo2 <= locationNo5) {
            remove += lengthNo2;
        }
        
        if (locationNo3 + lengthNo3 <= locationNo5) {
            remove += lengthNo3;
        }
        
        if (locationNo4 + lengthNo4 <= locationNo5) {
            remove += lengthNo4;
        }
        
        beginning = itemNotesTextField.beginningOfDocument;
        start = [itemNotesTextField positionFromPosition:beginning offset:locationNo5-remove];
        end = [itemNotesTextField positionFromPosition:start offset:lengthNo5];
        textRange = [itemNotesTextField textRangeFromPosition:start toPosition:end];
        
        //        [self->itemNotesTextField replaceRange:textRange withText:@""];
        
    }
    
    if ([[dictNo6 allKeys] count] != 0) {
        
        NSUInteger locationNo1 = [dictNo1[@"location"] intValue];
        NSUInteger lengthNo1 = [dictNo1[@"length"] intValue];
        
        NSUInteger locationNo2 = [dictNo2[@"location"] intValue];
        NSUInteger lengthNo2 = [dictNo2[@"length"] intValue];
        
        NSUInteger locationNo3 = [dictNo3[@"location"] intValue];
        NSUInteger lengthNo3 = [dictNo3[@"length"] intValue];
        
        NSUInteger locationNo4 = [dictNo4[@"location"] intValue];
        NSUInteger lengthNo4 = [dictNo4[@"length"] intValue];
        
        NSUInteger locationNo5 = [dictNo5[@"location"] intValue];
        NSUInteger lengthNo5 = [dictNo5[@"length"] intValue];
        
        NSUInteger locationNo6 = [dictNo6[@"location"] intValue];
        NSUInteger lengthNo6 = [dictNo6[@"length"] intValue];
        
        NSUInteger remove = 0;
        
        if (locationNo1 + lengthNo1 <= locationNo6) {
            remove += lengthNo1;
        }
        
        if (locationNo2 + lengthNo2 <= locationNo6) {
            remove += lengthNo2;
        }
        
        if (locationNo3 + lengthNo3 <= locationNo6) {
            remove += lengthNo3;
        }
        
        if (locationNo4 + lengthNo4 <= locationNo6) {
            remove += lengthNo4;
        }
        
        if (locationNo5 + lengthNo5 <= locationNo6) {
            remove += lengthNo5;
        }
        
        beginning = itemNotesTextField.beginningOfDocument;
        start = [itemNotesTextField positionFromPosition:beginning offset:locationNo6-remove];
        end = [itemNotesTextField positionFromPosition:start offset:lengthNo6];
        textRange = [itemNotesTextField textRangeFromPosition:start toPosition:end];
        
        //        [self->itemNotesTextField replaceRange:textRange withText:@""];
        
    }
    
    if ([[dictNo7 allKeys] count] != 0) {
        
        NSUInteger locationNo1 = [dictNo1[@"location"] intValue];
        NSUInteger lengthNo1 = [dictNo1[@"length"] intValue];
        
        NSUInteger locationNo2 = [dictNo2[@"location"] intValue];
        NSUInteger lengthNo2 = [dictNo2[@"length"] intValue];
        
        NSUInteger locationNo3 = [dictNo3[@"location"] intValue];
        NSUInteger lengthNo3 = [dictNo3[@"length"] intValue];
        
        NSUInteger locationNo4 = [dictNo4[@"location"] intValue];
        NSUInteger lengthNo4 = [dictNo4[@"length"] intValue];
        
        NSUInteger locationNo5 = [dictNo5[@"location"] intValue];
        NSUInteger lengthNo5 = [dictNo5[@"length"] intValue];
        
        NSUInteger locationNo6 = [dictNo6[@"location"] intValue];
        NSUInteger lengthNo6 = [dictNo6[@"length"] intValue];
        
        NSUInteger locationNo7 = [dictNo7[@"location"] intValue];
        NSUInteger lengthNo7 = [dictNo7[@"length"] intValue];
        
        NSUInteger remove = 0;
        
        if (locationNo1 + lengthNo1 <= locationNo7) {
            remove += lengthNo1;
        }
        
        if (locationNo2 + lengthNo2 <= locationNo7) {
            remove += lengthNo2;
        }
        
        if (locationNo3 + lengthNo3 <= locationNo7) {
            remove += lengthNo3;
        }
        
        if (locationNo4 + lengthNo4 <= locationNo7) {
            remove += lengthNo4;
        }
        
        if (locationNo5 + lengthNo5 <= locationNo7) {
            remove += lengthNo5;
        }
        
        if (locationNo6 + lengthNo6 <= locationNo7) {
            remove += lengthNo6;
        }
        
        beginning = itemNotesTextField.beginningOfDocument;
        start = [itemNotesTextField positionFromPosition:beginning offset:locationNo7-remove];
        end = [itemNotesTextField positionFromPosition:start offset:lengthNo7];
        textRange = [itemNotesTextField textRangeFromPosition:start toPosition:end];
        
        //        [self->itemNotesTextField replaceRange:textRange withText:@""];
        
    }
    
    if ([[dictNo8 allKeys] count] != 0) {
        
        NSUInteger locationNo1 = [dictNo1[@"location"] intValue];
        NSUInteger lengthNo1 = [dictNo1[@"length"] intValue];
        
        NSUInteger locationNo2 = [dictNo2[@"location"] intValue];
        NSUInteger lengthNo2 = [dictNo2[@"length"] intValue];
        
        NSUInteger locationNo3 = [dictNo3[@"location"] intValue];
        NSUInteger lengthNo3 = [dictNo3[@"length"] intValue];
        
        NSUInteger locationNo4 = [dictNo4[@"location"] intValue];
        NSUInteger lengthNo4 = [dictNo4[@"length"] intValue];
        
        NSUInteger locationNo5 = [dictNo5[@"location"] intValue];
        NSUInteger lengthNo5 = [dictNo5[@"length"] intValue];
        
        NSUInteger locationNo6 = [dictNo6[@"location"] intValue];
        NSUInteger lengthNo6 = [dictNo6[@"length"] intValue];
        
        NSUInteger locationNo7 = [dictNo7[@"location"] intValue];
        NSUInteger lengthNo7 = [dictNo7[@"length"] intValue];
        
        NSUInteger locationNo8 = [dictNo8[@"location"] intValue];
        NSUInteger lengthNo8 = [dictNo8[@"length"] intValue];
        
        NSUInteger remove = 0;
        
        if (locationNo1 + lengthNo1 <= locationNo8) {
            remove += lengthNo1;
        }
        
        if (locationNo2 + lengthNo2 <= locationNo8) {
            remove += lengthNo2;
        }
        
        if (locationNo3 + lengthNo3 <= locationNo8) {
            remove += lengthNo3;
        }
        
        if (locationNo4 + lengthNo4 <= locationNo8) {
            remove += lengthNo4;
        }
        
        if (locationNo5 + lengthNo5 <= locationNo8) {
            remove += lengthNo5;
        }
        
        if (locationNo6 + lengthNo6 <= locationNo8) {
            remove += lengthNo6;
        }
        
        if (locationNo7 + lengthNo7 <= locationNo8) {
            remove += lengthNo7;
        }
        
        beginning = itemNotesTextField.beginningOfDocument;
        start = [itemNotesTextField positionFromPosition:beginning offset:locationNo8-remove];
        end = [itemNotesTextField positionFromPosition:start offset:lengthNo8];
        textRange = [itemNotesTextField textRangeFromPosition:start toPosition:end];
        
        //        [self->itemNotesTextField replaceRange:textRange withText:@""];
        
    }
    
    if ([[dictNo9 allKeys] count] != 0) {
        
        NSUInteger locationNo1 = [dictNo1[@"location"] intValue];
        NSUInteger lengthNo1 = [dictNo1[@"length"] intValue];
        
        NSUInteger locationNo2 = [dictNo2[@"location"] intValue];
        NSUInteger lengthNo2 = [dictNo2[@"length"] intValue];
        
        NSUInteger locationNo3 = [dictNo3[@"location"] intValue];
        NSUInteger lengthNo3 = [dictNo3[@"length"] intValue];
        
        NSUInteger locationNo4 = [dictNo4[@"location"] intValue];
        NSUInteger lengthNo4 = [dictNo4[@"length"] intValue];
        
        NSUInteger locationNo5 = [dictNo5[@"location"] intValue];
        NSUInteger lengthNo5 = [dictNo5[@"length"] intValue];
        
        NSUInteger locationNo6 = [dictNo6[@"location"] intValue];
        NSUInteger lengthNo6 = [dictNo6[@"length"] intValue];
        
        NSUInteger locationNo7 = [dictNo7[@"location"] intValue];
        NSUInteger lengthNo7 = [dictNo7[@"length"] intValue];
        
        NSUInteger locationNo8 = [dictNo8[@"location"] intValue];
        NSUInteger lengthNo8 = [dictNo8[@"length"] intValue];
        
        NSUInteger locationNo9 = [dictNo9[@"location"] intValue];
        NSUInteger lengthNo9 = [dictNo9[@"length"] intValue];
        
        NSUInteger remove = 0;
        
        if (locationNo1 + lengthNo1 <= locationNo9) {
            remove += lengthNo1;
        }
        
        if (locationNo2 + lengthNo2 <= locationNo9) {
            remove += lengthNo2;
        }
        
        if (locationNo3 + lengthNo3 <= locationNo9) {
            remove += lengthNo3;
        }
        
        if (locationNo4 + lengthNo4 <= locationNo9) {
            remove += lengthNo4;
        }
        
        if (locationNo5 + lengthNo5 <= locationNo9) {
            remove += lengthNo5;
        }
        
        if (locationNo6 + lengthNo6 <= locationNo9) {
            remove += lengthNo6;
        }
        
        if (locationNo7 + lengthNo7 <= locationNo9) {
            remove += lengthNo7;
        }
        
        if (locationNo8 + lengthNo8 <= locationNo9) {
            remove += lengthNo8;
        }
        
        beginning = itemNotesTextField.beginningOfDocument;
        start = [itemNotesTextField positionFromPosition:beginning offset:locationNo9-remove];
        end = [itemNotesTextField positionFromPosition:start offset:lengthNo9];
        textRange = [itemNotesTextField textRangeFromPosition:start toPosition:end];
        
        //        [self->itemNotesTextField replaceRange:textRange withText:@""];
        
    }
    
    if ([[dictNo10 allKeys] count] != 0) {
        
        NSUInteger locationNo1 = [dictNo1[@"location"] intValue];
        NSUInteger lengthNo1 = [dictNo1[@"length"] intValue];
        
        NSUInteger locationNo2 = [dictNo2[@"location"] intValue];
        NSUInteger lengthNo2 = [dictNo2[@"length"] intValue];
        
        NSUInteger locationNo3 = [dictNo3[@"location"] intValue];
        NSUInteger lengthNo3 = [dictNo3[@"length"] intValue];
        
        NSUInteger locationNo4 = [dictNo4[@"location"] intValue];
        NSUInteger lengthNo4 = [dictNo4[@"length"] intValue];
        
        NSUInteger locationNo5 = [dictNo5[@"location"] intValue];
        NSUInteger lengthNo5 = [dictNo5[@"length"] intValue];
        
        NSUInteger locationNo6 = [dictNo6[@"location"] intValue];
        NSUInteger lengthNo6 = [dictNo6[@"length"] intValue];
        
        NSUInteger locationNo7 = [dictNo7[@"location"] intValue];
        NSUInteger lengthNo7 = [dictNo7[@"length"] intValue];
        
        NSUInteger locationNo8 = [dictNo8[@"location"] intValue];
        NSUInteger lengthNo8 = [dictNo8[@"length"] intValue];
        
        NSUInteger locationNo9 = [dictNo9[@"location"] intValue];
        NSUInteger lengthNo9 = [dictNo9[@"length"] intValue];
        
        NSUInteger locationNo10 = [dictNo10[@"location"] intValue];
        NSUInteger lengthNo10 = [dictNo10[@"length"] intValue];
        
        NSUInteger remove = 0;
        
        if (locationNo1 + lengthNo1 <= locationNo10) {
            remove += lengthNo1;
        }
        
        if (locationNo2 + lengthNo2 <= locationNo10) {
            remove += lengthNo2;
        }
        
        if (locationNo3 + lengthNo3 <= locationNo10) {
            remove += lengthNo3;
        }
        
        if (locationNo4 + lengthNo4 <= locationNo10) {
            remove += lengthNo4;
        }
        
        if (locationNo5 + lengthNo5 <= locationNo10) {
            remove += lengthNo5;
        }
        
        if (locationNo6 + lengthNo6 <= locationNo10) {
            remove += lengthNo6;
        }
        
        if (locationNo7 + lengthNo7 <= locationNo10) {
            remove += lengthNo7;
        }
        
        if (locationNo8 + lengthNo8 <= locationNo10) {
            remove += lengthNo8;
        }
        
        if (locationNo9 + lengthNo9 <= locationNo10) {
            remove += lengthNo9;
        }
        
        beginning = itemNotesTextField.beginningOfDocument;
        start = [itemNotesTextField positionFromPosition:beginning offset:locationNo10-remove];
        end = [itemNotesTextField positionFromPosition:start offset:lengthNo10];
        textRange = [itemNotesTextField textRangeFromPosition:start toPosition:end];
        
        //        [self->itemNotesTextField replaceRange:textRange withText:@""];
        
    }
    
    if ([[dictNo11 allKeys] count] != 0) {
        
        NSUInteger locationNo1 = [dictNo1[@"location"] intValue];
        NSUInteger lengthNo1 = [dictNo1[@"length"] intValue];
        
        NSUInteger locationNo2 = [dictNo2[@"location"] intValue];
        NSUInteger lengthNo2 = [dictNo2[@"length"] intValue];
        
        NSUInteger locationNo3 = [dictNo3[@"location"] intValue];
        NSUInteger lengthNo3 = [dictNo3[@"length"] intValue];
        
        NSUInteger locationNo4 = [dictNo4[@"location"] intValue];
        NSUInteger lengthNo4 = [dictNo4[@"length"] intValue];
        
        NSUInteger locationNo5 = [dictNo5[@"location"] intValue];
        NSUInteger lengthNo5 = [dictNo5[@"length"] intValue];
        
        NSUInteger locationNo6 = [dictNo6[@"location"] intValue];
        NSUInteger lengthNo6 = [dictNo6[@"length"] intValue];
        
        NSUInteger locationNo7 = [dictNo7[@"location"] intValue];
        NSUInteger lengthNo7 = [dictNo7[@"length"] intValue];
        
        NSUInteger locationNo8 = [dictNo8[@"location"] intValue];
        NSUInteger lengthNo8 = [dictNo8[@"length"] intValue];
        
        NSUInteger locationNo9 = [dictNo9[@"location"] intValue];
        NSUInteger lengthNo9 = [dictNo9[@"length"] intValue];
        
        NSUInteger locationNo10 = [dictNo10[@"location"] intValue];
        NSUInteger lengthNo10 = [dictNo10[@"length"] intValue];
        
        NSUInteger locationNo11 = [dictNo11[@"location"] intValue];
        NSUInteger lengthNo11 = [dictNo11[@"length"] intValue];
        
        NSUInteger remove = 0;
        
        if (locationNo1 + lengthNo1 <= locationNo11) {
            remove += lengthNo1;
        }
        
        if (locationNo2 + lengthNo2 <= locationNo11) {
            remove += lengthNo2;
        }
        
        if (locationNo3 + lengthNo3 <= locationNo11) {
            remove += lengthNo3;
        }
        
        if (locationNo4 + lengthNo4 <= locationNo11) {
            remove += lengthNo4;
        }
        
        if (locationNo5 + lengthNo5 <= locationNo11) {
            remove += lengthNo5;
        }
        
        if (locationNo6 + lengthNo6 <= locationNo11) {
            remove += lengthNo6;
        }
        
        if (locationNo7 + lengthNo7 <= locationNo11) {
            remove += lengthNo7;
        }
        
        if (locationNo8 + lengthNo8 <= locationNo11) {
            remove += lengthNo8;
        }
        
        if (locationNo9 + lengthNo9 <= locationNo11) {
            remove += lengthNo9;
        }
        
        if (locationNo10 + lengthNo10 <= locationNo11) {
            remove += lengthNo10;
        }
        
        beginning = itemNotesTextField.beginningOfDocument;
        start = [itemNotesTextField positionFromPosition:beginning offset:locationNo11-remove];
        end = [itemNotesTextField positionFromPosition:start offset:lengthNo11];
        textRange = [itemNotesTextField textRangeFromPosition:start toPosition:end];
        
        //        [self->itemNotesTextField replaceRange:textRange withText:@""];
        
    }
    
    if ([[dictNo12 allKeys] count] != 0) {
        
        NSUInteger locationNo1 = [dictNo1[@"location"] intValue];
        NSUInteger lengthNo1 = [dictNo1[@"length"] intValue];
        
        NSUInteger locationNo2 = [dictNo2[@"location"] intValue];
        NSUInteger lengthNo2 = [dictNo2[@"length"] intValue];
        
        NSUInteger locationNo3 = [dictNo3[@"location"] intValue];
        NSUInteger lengthNo3 = [dictNo3[@"length"] intValue];
        
        NSUInteger locationNo4 = [dictNo4[@"location"] intValue];
        NSUInteger lengthNo4 = [dictNo4[@"length"] intValue];
        
        NSUInteger locationNo5 = [dictNo5[@"location"] intValue];
        NSUInteger lengthNo5 = [dictNo5[@"length"] intValue];
        
        NSUInteger locationNo6 = [dictNo6[@"location"] intValue];
        NSUInteger lengthNo6 = [dictNo6[@"length"] intValue];
        
        NSUInteger locationNo7 = [dictNo7[@"location"] intValue];
        NSUInteger lengthNo7 = [dictNo7[@"length"] intValue];
        
        NSUInteger locationNo8 = [dictNo8[@"location"] intValue];
        NSUInteger lengthNo8 = [dictNo8[@"length"] intValue];
        
        NSUInteger locationNo9 = [dictNo9[@"location"] intValue];
        NSUInteger lengthNo9 = [dictNo9[@"length"] intValue];
        
        NSUInteger locationNo10 = [dictNo10[@"location"] intValue];
        NSUInteger lengthNo10 = [dictNo10[@"length"] intValue];
        
        NSUInteger locationNo11 = [dictNo11[@"location"] intValue];
        NSUInteger lengthNo11 = [dictNo11[@"length"] intValue];
        
        NSUInteger locationNo12 = [dictNo12[@"location"] intValue];
        NSUInteger lengthNo12 = [dictNo12[@"length"] intValue];
        
        NSUInteger remove = 0;
        
        if (locationNo1 + lengthNo1 <= locationNo12) {
            remove += lengthNo1;
        }
        
        if (locationNo2 + lengthNo2 <= locationNo12) {
            remove += lengthNo2;
        }
        
        if (locationNo3 + lengthNo3 <= locationNo12) {
            remove += lengthNo3;
        }
        
        if (locationNo4 + lengthNo4 <= locationNo12) {
            remove += lengthNo4;
        }
        
        if (locationNo5 + lengthNo5 <= locationNo12) {
            remove += lengthNo5;
        }
        
        if (locationNo6 + lengthNo6 <= locationNo12) {
            remove += lengthNo6;
        }
        
        if (locationNo7 + lengthNo7 <= locationNo12) {
            remove += lengthNo7;
        }
        
        if (locationNo8 + lengthNo8 <= locationNo12) {
            remove += lengthNo8;
        }
        
        if (locationNo9 + lengthNo9 <= locationNo12) {
            remove += lengthNo9;
        }
        
        if (locationNo10 + lengthNo10 <= locationNo12) {
            remove += lengthNo10;
        }
        
        if (locationNo11 + lengthNo11 <= locationNo12) {
            remove += lengthNo11;
        }
        
        beginning = itemNotesTextField.beginningOfDocument;
        start = [itemNotesTextField positionFromPosition:beginning offset:locationNo12-remove];
        end = [itemNotesTextField positionFromPosition:start offset:lengthNo12];
        textRange = [itemNotesTextField textRangeFromPosition:start toPosition:end];
        
        //        [self->itemNotesTextField replaceRange:textRange withText:@""];
        
    }
    
}

-(void)InsertTextType:(NSString *)textType replaceString:(NSString *)replaceString {
    
    NSString *randomNum = [[[GeneralObject alloc] init] GenerateRandomSmallNumberIntoString:1000000000 upperBound:9999999999];
    UITextRange *selectedRange = [self->itemNotesTextField selectedTextRange];
    NSString *selectedText = [self->itemNotesTextField textInRange:selectedRange];
    
    if ([selectedText isEqualToString:@"bold"] == NO && selectedText.length != 0) {
        [self->itemNotesTextField replaceRange:selectedRange withText:[NSString stringWithFormat:@"%@%@%@%@", textType, randomNum, selectedText, textType]];
        NSRange range = [self->itemNotesTextField.text rangeOfString:[NSString stringWithFormat:@"%@%@", textType, randomNum]];
        [[[GeneralObject alloc] init] SelectCursorPosition:self->itemNotesTextField pos:(int)range.location+(int)range.length-10+(int)selectedText.length len:0];
    } else {
        [self->itemNotesTextField replaceRange:selectedRange withText:[NSString stringWithFormat:@"%@%@%@%@", textType, randomNum, replaceString, textType]];
        NSRange range = [self->itemNotesTextField.text rangeOfString:[NSString stringWithFormat:@"%@%@", textType, randomNum]];
        [[[GeneralObject alloc] init] SelectCursorPosition:self->itemNotesTextField pos:(int)range.location+(int)range.length-10 len:(int)replaceString.length];
    }
    
    UITextRange *saveRange = [self->itemNotesTextField selectedTextRange];
    NSString *note = self->itemNotesTextField.text;
    note = [[[GeneralObject alloc] init] GenerateStringWithReplacementString:note stringToReplace:[NSString stringWithFormat:@"%@%@", textType, randomNum] replacementString:textType];
    
    self->itemNotesTextField.text = note;
    [self->itemNotesTextField setSelectedTextRange:saveRange];
    
}

-(IBAction)TextType:(id)sender {
    
    UITapGestureRecognizer *tapRecognizer = (UITapGestureRecognizer *)sender;
    NSInteger the_tag = [tapRecognizer.view tag];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        if (the_tag == 1) {
            
            [self InsertTextType:@"(bold)" replaceString:@"bold"];
            
        } else if (the_tag == 2) {
            
            [self InsertTextType:@"(italic)" replaceString:@"italic"];
            
        } else if (the_tag == 3) {
            
            [self InsertTextType:@"(underlined)" replaceString:@"underlined"];
            
        } else if (the_tag == 4) {
            
            //            [self InsertTextType:@"(font)" replaceString:@"font"];
            
        } else if (the_tag == 5) {
            
            //            [self InsertTextType:@"(fontsize)" replaceString:@"fontsize"];
            
        } else if (the_tag == 6) {
            
            //            [self InsertTextType:@"(textcolor)" replaceString:@"textcolor"];
            
        } else if (the_tag == 7) {
            
            //            [self InsertTextType:@"(backgroundcolor)" replaceString:@"backgroundcolor"];
            
        } else if (the_tag == 8) {
            
            [self InsertTextType:@"(highlighter)" replaceString:@"highlighter"];
            
        } else if (the_tag == 9) {
            
            UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Enter your email" message:nil
                                                                         preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"Reset"
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * _Nonnull action) {
                
                NSString *linkName = [controller.textFields[0].text lowercaseString];
                NSString *linkURL = [controller.textFields[1].text lowercaseString];
                
                [self InsertTextType:@"(link)" replaceString:[NSString stringWithFormat:@"[%@](%@)", linkName, linkURL]];
                
            }];
            
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                             style:UIAlertActionStyleCancel
                                                           handler:^(UIAlertAction * _Nonnull action) {}];
            
            
            
            [controller addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                
                textField.delegate = self;
                textField.placeholder = @"Link Name";
                textField.text = @"";
                textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
                
            }];
            
            [controller addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                
                textField.delegate = self;
                textField.placeholder = @"Link URL";
                textField.text = @"";
                textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
                
            }];
            
            [controller addAction:action1];
            [controller addAction:cancel];
            [self presentViewController:controller animated:YES completion:nil];
            
        }
        
    }];
    
}

@end
