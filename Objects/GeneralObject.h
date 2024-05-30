//
//  GeneralObject.h
//  WeDivvy
//
//  Created by Philip Nagel on 9/14/21.
//

#import "AppDelegate.h"
#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
#import <MRProgress/MRProgressOverlayView.h>
#import <Mixpanel/Mixpanel.h>
#import <StoreKit/StoreKit.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <SystemConfiguration/SystemConfiguration.h>

NS_ASSUME_NONNULL_BEGIN

@interface GeneralObject : NSObject <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

-(NSString *)GenerateItemImageURL:(NSString *)itemType itemUniqueID:(NSString *)itemUniqueID;
-(NSString *)GeneratePhotoConfirmationImageURL:(NSString *)itemType itemUniqueID:(NSString *)itemUniqueID markedObject:(NSString *)markedObject;

-(NSDictionary *)GenerateItemSetDataDict:(NSString *)itemType
                            itemUniqueID:(NSString *)itemUniqueID
                                  itemID:(NSString *)itemID
                        itemOccurrenceID:(NSString *)itemOccurrenceID
                              itemHomeID:(NSString *)itemHomeID
                         itemSuggestedID:(NSString *)itemSuggestedID

                            itemTutorial:(NSString *)itemTutorial

                           itemCreatedBy:(NSString *)itemCreatedBy
                          itemDatePosted:(NSString *)itemDatePosted
                       itemDateLastReset:(NSString *)itemDateLastReset

                       itemCompletedDict:(NSMutableDictionary *)itemCompletedDict
                      itemInProgressDict:(NSMutableDictionary *)itemInProgressDict
                              itemWontDo:(NSMutableDictionary *)itemWontDo

                    itemOccurrenceStatus:(NSString *)itemOccurrenceStatus
                   itemOccurrencePastDue:(NSMutableDictionary *)itemOccurrencePastDue

                       itemAddedLocation:(NSString *)itemAddedLocation
                      itemScheduledStart:(NSString *)itemScheduledStart



//Main View
                                itemName:(NSString *)itemName
                            itemImageURL:(NSString *)itemImageURL
                               itemNotes:(NSString *)itemNotes

                          itemAssignedTo:(NSMutableArray *)itemAssignedTo
            itemAssignedToNewHomeMembers:(NSString *)itemAssignedToNewHomeMembers
                   itemAssignedToAnybody:(NSString *)itemAssignedToAnybody

                                itemDate:(NSString *)itemDate
                             itemDueDate:(NSString *)itemDueDate
                     itemDueDatesSkipped:(NSMutableArray *)itemDueDatesSkipped
                             itemRepeats:(NSString *)itemRepeats
                 itemRepeatIfCompletedEarly:(NSString *)itemRepeatIfCompletedEarly
                    itemCompleteAsNeeded:(NSString *)itemCompleteAsNeeded

                           itemStartDate:(NSString *)itemStartDate
                             itemEndDate:(NSString *)itemEndDate
                    itemEndNumberOfTimes:(NSString *)itemEndNumberOfTimes

                                itemDays:(NSString *)itemDays
                                itemTime:(NSString *)itemTime

                           itemTakeTurns:(NSString *)itemTakeTurns
                      itemAlternateTurns:(NSString *)itemAlternateTurns
             itemDateLastAlternatedTurns:(NSString *)itemDateLastAlternatedTurns
                          itemTurnUserID:(NSString *)itemTurnUserID
                  itemRandomizeTurnOrder:(NSString *)itemRandomizeTurnOrder

                        itemReminderDict:(NSMutableDictionary *)itemReminderDict



//More Options
                         itemGracePeriod:(NSString *)itemGracePeriod
                             itemPastDue:(NSString *)itemPastDue

                               itemColor:(NSString *)itemColor
                                itemTags:(NSMutableArray *)itemTags
                            itemPriority:(NSString *)itemPriority
                          itemDifficulty:(NSString *)itemDifficulty

                              itemReward:(NSMutableDictionary *)itemReward
                             itemPrivate:(NSString *)itemPrivate



                 itemAdditionalReminders:(NSMutableDictionary *)itemAdditionalReminders
                   itemPhotoConfirmation:(NSString *)itemPhotoConfirmation
               itemPhotoConfirmationDict:(NSMutableDictionary *)itemPhotoConfirmationDict
                              itemStatus:(NSString *)itemStatus
                               itemTrash:(NSString *)itemTrash
                              itemPinned:(NSString *)itemPinned
                             itemDeleted:(NSString *)itemDeleted
                            itemTaskList:(NSString *)itemTaskList

                        itemSelfDestruct:(NSString *)itemSelfDestruct
                       itemEstimatedTime:(NSString *)itemEstimatedTime



//if ([itemType containsString:@"Chore"] || [itemType containsString:@"Expense"]) {

                    itemSpecificDueDates:(NSMutableArray *)itemSpecificDueDates
                      itemApprovalNeeded:(NSString *)itemApprovalNeeded
                    itemApprovalRequests:(NSMutableDictionary *)itemApprovalRequests

//}

//if ([itemType containsString:@"Chore"]) {

                         itemCompletedBy:(NSString *)itemCompletedBy
                            itemSubTasks:(NSMutableDictionary *)itemSubTasks

//} else if ([itemType containsString:@"Expense"]) {

                              itemAmount:(NSString *)itemAmount
                            itemItemized:(NSString *)itemItemized
                       itemItemizedItems:(NSMutableDictionary *)itemItemizedItems
                       itemCostPerPerson:(NSMutableDictionary *)itemCostPerPerson
                       itemPaymentMethod:(NSMutableDictionary *)itemPaymentMethod

//} else if ([itemType containsString:@"List"]) {

                           itemListItems:(NSMutableDictionary *)itemListItems

//}
;

-(NSArray *)GenerateSuggestedTaskListArray:(NSString *)itemType;
-(id)GenerateObjectWithNonHomeMembersRemoved:(id)object homeMembersDict:(NSMutableDictionary *)homeMembersDict;
-(void)AllGenerateTokenMethod:(NSString *)topicID Subscribe:(BOOL)Subscribe GrantedNotifications:(BOOL)GrantedNotifications;
-(void)RemoveCompletedTopicFromGenerateTokenArray:(NSString *)topicID Subscribe:(BOOL)Subscribe;
-(void)SubscribeToUserIDTopic:(NSString *)userID completionHandler:(void (^)(BOOL finished))finishBlock;
-(void)UnsubscribeFromUserIDTopic:(NSString *)userID completionHandler:(void (^)(BOOL finished))finishBlock;

-(void)SubscribeToAllHomeTopics:(NSString *)userID homeID:(NSString *)homeID homeMembersDict:(NSMutableDictionary *)homeMembersDict completionHandler:(void (^)(BOOL finished))finishBlock;
-(void)UnsubscribeToAllHomeTopics:(NSString *)userID homeID:(NSString *)homeID homeMembersDict:(NSMutableDictionary *)homeMembersDict completionHandler:(void (^)(BOOL finished))finishBlock;

-(NSMutableDictionary *)GenerateUpdatedTaskListDictNo1:(NSArray *)arrayOfDicts taskListDict:(NSMutableDictionary *)taskListDict;
-(NSMutableDictionary *)GenerateUpdatedTaskListDict:(NSArray *)arrayOfDicts taskListDict:(NSMutableDictionary *)taskListDict;

-(void)AddTaskToSpecificTaskListAndRemoveFromAllTaskListsThatContainSpecificItem:(NSMutableDictionary *)taskListDict newTaskListName:(NSString *)newTaskListName itemUniqueIDArray:(NSArray *)itemUniqueIDArray itemUniqueIDDict:(NSDictionary *)itemUniqueIDDict completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningUpdatedTaskListDict, NSMutableDictionary *returningUpdatedTaskListDictNo1))finishBlock;

-(void)AddTaskToSpecificTaskListAndRemoveFromDifferentSpecificTaskList:(NSMutableDictionary *)taskListDict newTaskListName:(NSString *)newTaskListName oldTaskListName:(NSString *)oldTaskListName itemUniqueIDArray:(NSArray *)itemUniqueIDArray completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningUpdatedTaskListDict, NSMutableDictionary *returningUpdatedTaskListDictNo1))finishBlock;

-(void)AddOrRemoveTaskToSpecificTaskList:(NSMutableDictionary *)taskListDict newTaskListName:(NSString *)newTaskListName itemUniqueIDArray:(NSArray *)itemUniqueIDArray AddTask:(BOOL)AddTask completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningUpdatedTaskListDict))finishBlock;

-(void)AddOrRemoveTaskToAllTaskListsThatContainSpecificItem:(NSMutableDictionary *)taskListDict newTaskListName:(NSString *)newTaskListName itemUniqueIDDict:(NSDictionary *)itemUniqueIDDict AddTask:(BOOL)AddTask completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningUpdatedTaskListDict))finishBlock;

#pragma mark - Quiet Queries

-(void)AddQueryToDefaults:(NSArray *)collections documents:(NSArray *)documents type:(NSString *)type setData:(NSDictionary *)setData name:(NSString *)name queryID:(NSString *)queryID;
-(void)AddNotificationQueryToDefaults:(NSArray *)notificationUsers notificationTitle:(NSString *)notificationTitle notificationBody:(NSString *)notificationBody setData:(NSDictionary *)setData notificationSettings:(NSDictionary *)notificationSettings notificationType:(NSString *)notificationType queryID:(NSString *)queryID;
-(void)EditNotificationQueryToDefaults:(NSString *)userIDToRemove queryID:(NSString *)queryID;
-(void)RemoveQueryToDefaults:(NSString *)queryID;

#pragma mark - Premium Methods

-(void)CheckPremiumSubscriptionStatus:(NSMutableDictionary *)homeMembersDict completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningHomeMembersDict))finishBlock;

#pragma mark - System Info Methods

-(float)GetSystemVersion;
-(CGFloat)GetStatusBarHeight;
-(CGFloat)GetNavigationBarHeight:(UIViewController *)currentViewController;
-(CGFloat)GetBottomPaddingHeight;

#pragma mark - NSUserDefault Methods

-(void)RemoveCachedInitialDataNSUserDefaults:(BOOL)RemoveHomeMembersDict;
-(void)RemoveHomeDataNSUserDefaults;
-(void)RemoveAppDataNSUserDefaults;

#pragma mark - Generate Methods

-(NSString *)GenerateItemType;
-(NSString *)GenerateRandomESTNumberIntoString;
-(NSString *)GenerateRandomSmallNumberIntoString:(long)lowerBound upperBound:(long)upperBound;
-(NSString *)GenerateRandomSmallAlphaNumberIntoString:(int)len;
-(NSString *)GenerateWhenDueNotificationBody:(NSString *)itemType itemAssignedTo:(NSMutableArray *)itemAssignedTo homeMembersDict:(NSMutableDictionary *)homeMembersDict;
-(NSDictionary *)GenerateDefaultRemindersDict:(NSString *)itemType itemAssignedTo:(NSMutableArray *)itemAssignedTo itemRepeats:(NSString *)itemRepeats homeMembersDict:(NSMutableDictionary *)homeMembersDict AnyTime:(BOOL)AnyTime;
-(NSDictionary *)GenerateDefaultNotificationSettingsDict:(NSString *)userID addMorningOverView:(BOOL)addMorningOverView addEveningOverView:(BOOL)addEveningOverView;
-(NSDictionary *)GenerateDefaultCalendarSettingsDict;
-(NSDictionary *)GenerateDefaultFirstTemplatesDict:(NSString *)userID;
-(NSDictionary *)GenerateDefaultWeDivvyPremiumPlan;
-(NSString *)GenerateShareString:(NSMutableDictionary *)itemDict arrayOfUniqueIDs:(NSArray *)arrayOfUniqueIDs itemType:(NSString *)itemType keyArray:(NSArray *)keyArray homeMembersDict:(NSMutableDictionary *)homeMembersDict;
-(NSMutableArray *)GenerateArrayID:(id _Nullable)object;
-(id)GenerateDictionaryID:(id _Nullable)object;

#pragma mark - Generate Dictionaries & Arrays

-(NSMutableArray *)GenerateArrayInReverse:(NSMutableArray *)arrayToUse;
-(NSMutableDictionary *)GenerateDictOfArraysInReverse:(NSMutableDictionary *)dictToUse;
-(NSMutableDictionary *)GenerateSingleObjectDictionary:(NSMutableDictionary *)itemDictToUse keyArray:(NSArray *)keyArray indexPath:(NSIndexPath * _Nullable)indexPath;
-(NSMutableDictionary *)GenerateSingleArraySingleObjectDictionary:(NSMutableDictionary *)itemDictToUse keyArray:(NSArray *)keyArray indexPath:(NSIndexPath * _Nullable)indexPath;
-(NSMutableDictionary *)GenerateSpecificUserDataBasedOnKey:(NSString *)key object:(NSString *)object homeMembersDict:(NSMutableDictionary *)homeMembersDict;
-(NSMutableDictionary *)GenerateDictWithoutEmptyKeys:(NSMutableDictionary *)dictToUse;
-(NSString *)GenerateStringArray:(NSMutableArray *)arrayToUse;
-(NSString *)dictionaryToString:(NSDictionary *)dictionary;
-(NSString *)arrayToString:(NSArray *)array;
-(NSDictionary *)stringToDictionary:(NSString *)jsonString;
-(NSArray *)stringToArray:(NSString *)jsonString;

#pragma mark - Key Methods

-(NSArray *)GenerateKeyArray;
-(NSArray *)GenerateKeyArrayManually:(BOOL)Chore Expense:(BOOL)Expense List:(BOOL)List Home:(BOOL)Home;
-(NSArray *)GenerateUserKeyArray;
-(NSArray *)GenerateActivityKeyArray;
-(NSArray *)GenerateNotificationsKeyArray;
-(NSArray *)GenerateFolderKeyArray;
-(NSArray *)GenerateTaskListKeyArray;
-(NSArray *)GenerateSectionKeyArray;
-(NSArray *)GenerateTemplateKeyArray;
-(NSArray *)GenerateDraftKeyArray;
-(NSArray *)GenerateChatKeyArray;
-(NSArray *)GenerateMessageKeyArray;
-(NSArray *)GenerateForumKeyArray;
-(NSArray *)GeneratePromotionalCodesKeyArray;
-(NSArray *)GenerateNotificationSettingsKeyArray;
-(NSArray *)GenerateTopicKeyArray;
-(NSSet *)GenerateSubscriptionsKeyArray;
-(NSArray *)GenerateSubscriptionsMonthly:(BOOL)Monthly ThreeMonthly:(BOOL)ThreeMonthly Yearly:(BOOL)Yearly;
-(NSString *)GenerateDefaultStringValueForKey:(NSString *)key;
-(id)GenerateDefaultValueBasedOnKey:(NSString *)key;

#pragma mark - Filter Methods

-(NSString *)TrimString:(NSString *)string;
-(NSString *)GetTopicFromUserID:(NSString *)userID;
-(NSMutableArray *)RemoveDupliatesFromArray:(NSMutableArray *)array;
-(NSMutableArray *)SortArrayOfDates:(NSMutableArray *)datesArray dateFormatString:(NSString *)dateFormatString;
-(NSMutableArray *)SortArrayOfDatesNo1:(NSMutableArray *)datesArray dateFormatString:(NSString *)dateFormatString;
-(NSString *)RemoveSpecialCharactersFromString:(NSString *)string;
-(NSString *)GenerateStringWithRemovedSymbols:(NSString *)strToAlter arrayOfSymbols:(NSArray *)arrayOfSymbols;
-(NSString *)FormatAmountTextField:(NSString *)textFieldText replacementString:(NSString *)string;
-(NSString *)GenerateAmountInTextFieldInProperFormat:(NSRange)range replacementString:(NSString *)string;
-(NSString *)GenerateLocalCurrencySymbol;
-(NSString *)GenerateLocalCurrencyDecimalSeparatorSymbol;
-(NSString *)GenerateLocalCurrencyNumberSeparatorSymbol;
-(void)CallNSNotificationMethods:(NSString *)action userInfo:(NSDictionary * _Nullable)userInfo locations:(NSArray *)locations;
-(NSString *)GenerateLocalCurrencyStringWithReverseSeparatorsForeign:(NSString *)string;
-(NSString *)GenerateStringWithReplacementString:(NSString *)string stringToReplace:(NSString *)stringToReplace replacementString:(NSString *)replacementString;

#pragma mark - Generate Options Methods

-(UIColor *)GenerateAppColor:(float)alpha;
-(NSArray *)GenerateColorOptionsArray;
-(NSDictionary *)GenerateAppIconNumberArray;
-(NSArray *)GenerateLaunchPageOptionsArray;
-(NSArray *)GenerateAppIconColorNameOptionsArray ;
-(NSArray *)GenerateAppIconImageNameOptionsArray;
-(UIColor *)GenerateColor:(float)red green:(float)green blue:(float)blue;
-(UIColor *)GenerateColorOptionFromColorString:(NSString *)colorStr;

#pragma mark - Date Methods

-(NSString *)GenerateCurrentDateString;
-(NSString *)GenerateReadableCurrentESTDate;
-(NSDateFormatter *)GenerateDateFormatWithString:(NSString *)dateFormatString;
-(NSDateFormatter *)GenerateESTDateFormatWithString:(NSString *)dateFormatString;
-(id)GenerateCurrentDateWithFormat:(NSString *)dateFormat returnAs:(Class)returnAs;
-(id)GenerateESTCurrentDateWithFormat:(NSString *)dateFormat returnAs:(Class)returnAs;
-(id)GenerateDateWithAddedTimeWithFormat:(NSString *)dateFormat dateToAddTimeTo:(id)dateToAddTimeTo timeToAdd:(int)timeToAdd returnAs:(Class)returnAs;
-(id)GenerateDateWithConvertedClassWithFormat:(NSString *)dateFormat dateToConvert:(id)dateToConvert returnAs:(Class)returnAs;
-(id)GenerateDateWithConvertedFormatWithFormat:(NSString *)dateFormat dateToConvert:(id)dateToConvert newFormat:(NSString *)newFormat returnAs:(Class)returnAs;

#pragma mark - Time Methods

-(NSDictionary *)GenerateItemTime12HourDict:(NSString *)itemTime;
-(NSDictionary *)GenerateItemTime24HourDict:(NSString *)itemTime;
-(NSDictionary *)GenerateConvert12HourTo24HourDict:(NSString *)itemTime;
-(NSDictionary *)GenerateConvert24HourTo12HourDict:(NSString *)itemTime;
-(NSTimeInterval)GenerateTimeIntervalBetweenTwoDates:(NSString *)dateString1 dateString2:(NSString *)dateString2 dateFormat:(NSString *)dateFormat;
-(int)GenerateNumberOfUnitsStringToSeconds:(NSString *)numberOfUnits;

#pragma mark - Generate Date Methods

-(NSString *)GetMonthNumberInYear:(NSString *)monthString;
-(NSString *)GetDisplayTimeSinceDate:(NSString *)dateString shortStyle:(BOOL)shortStyle reallyShortStyle:(BOOL)reallyShortStyle;
-(NSString *)GetDisplayTimeRemainingUntilDateStartingFromCurrentDate:(NSString *)dateString shortStyle:(BOOL)shortStyle reallyShortStyle:(BOOL)reallyShortStyle;
-(NSString *)GetDisplayTimeUntilDateStartingFromCustomStartDate:(NSString *)dateString dateToStartFrom:(NSString *)dateToStartFrom shortStyle:(BOOL)shortStyle reallyShortStyle:(BOOL)reallyShortStyle;
-(NSString *)GenerateDisplayTimeUntilDisplayTimeStartingFromCustomStartDate:(NSString *)displayTime itemDueDate:(NSString *)itemDueDate shortStyle:(BOOL)shortStyle reallyShortStyle:(BOOL)reallyShortStyle;
-(int)GenerateSecondsFromDisplayTime:(NSString *)itemGracePeriod;
-(BOOL)AddToObjectArrAndCheckIfQueryHasEnded:(NSMutableArray *)queryArray objectArr:(NSMutableArray *)objectArr;

#pragma mark - UI Methods

-(void)SelectCursorPosition:(UITextView *)textView pos:(int)pos len:(int)len;
-(void)SetAttributedPlaceholder:(UITextField *)textField color:(UIColor *)color;
-(void)RoundingCorners:(UIView *)viewToUse topCorners:(BOOL)topCorners bottomCorners:(BOOL)bottomCorners cornerRadius:(int)cornerRadius;
-(void)TextFieldIsEmptyColorChange:(UIView *)textFieldView textFieldField:(UITextField * _Nullable)textFieldField textFieldShouldDisplay:(BOOL)textFieldShouldDisplay defaultColor:(UIColor *)defaultColor;

#pragma mark - UX Methods

- (CGFloat)WidthOfString:(NSString *)string withFont:(UIFont *)font;
-(int)LineCountForText:(NSString *)text label:(UILabel *)label;
-(void)CreateAlert:(NSString *)title message:(NSString * _Nullable)message currentViewController:(UIViewController *)currentViewController;

#pragma mark - Popup Methods

-(void)AppStoreRating:(void (^)(BOOL finished))finishBlock;
-(void)RequestFeedback:(void (^)(BOOL finished))finishBlock;
-(void)DisplayWeDivvyPremiumPage:(void (^)(BOOL finished, BOOL DisplayDiscount))finishBlock;
-(void)DisplayWeDivvyPremiumSideBarPopup:(void (^)(BOOL finished))finishBlock;
-(void)DisplayCancelledSubscriptionFeedback:(void (^)(BOOL finished))finishBlock;
-(void)AddingHomeMembersMessage:(void (^)(BOOL finished))finishBlock;
-(void)InvitingHomeMembersPopup:(void (^)(BOOL finished))finishBlock;
-(void)InvitingHomeMembersAcceptedPopup:(void (^)(BOOL finished))finishBlock;
-(void)RegisterForNotifications:(void (^)(BOOL finished))finishBlock;

#pragma mark - Generate Users Turn

-(NSString *)GenerateNextUsersTurn:(NSMutableArray *)itemAssignedTo itemAssignedToOriginal:(NSMutableArray *)itemAssignedToOriginal homeMembersDict:(NSMutableDictionary *)homeMembersDict itemTakeTurns:(NSString *)itemTakeTurns itemTurnUserID:(NSString *)itemTurnUserID;
-(NSString *)GenerateCurrentUserTurnFromDict:(NSMutableDictionary *)dictToUse homeMembersDict:(NSMutableDictionary *)homeMembersDict itemType:(NSString *)itemType;
-(NSString *)GenerateCurrentUsersTurn:(NSString *)itemDueDate itemRepeats:(NSString *)itemRepeats itemRepeatIfCompletedEarly:(NSString *)itemRepeatIfCompletedEarly itemCompleteAsNeeded:(NSString *)itemCompleteAsNeeded itemTakeTurns:(NSString *)itemTakeTurns itemCompletedDict:(NSMutableDictionary *)itemCompletedDict itemAssignedToArray:(NSMutableArray *)itemAssignedToArray itemType:(NSString *)itemType itemTurnUserID:(NSString *)itemTurnUserID homeMembersDict:(NSMutableDictionary *)homeMembersDict;

#pragma mark - Other

-(BOOL)ConnectedToInternet;
-(BOOL)ItemCompletedOrItemInProgressDictContainsUserID:(NSMutableDictionary *)dictToUse userIDToFind:(NSString *)userIDToFind;
-(NSDictionary *)GeneralLastUserIDCompletedTaskRepeatingWhenCompleted:(NSMutableDictionary *)itemCompletedDict specificUserID:(NSString *)specificUserID;

#pragma mark - Analytics Methods

-(void)TrackInMixPanel:(NSString *)track;

#pragma mark - IAP Methods

-(NSDictionary *)GeneratePremiumPlanPricesDict;
-(NSDictionary *)GeneratePremiumPlanExpensivePricesDict;
-(NSDictionary *)GeneratePremiumPlanPricesDiscountDict;
-(NSDictionary *)GeneratePremiumPlanPricesNoFreeTrialDict;
-(void)GenerateProducts:(NSArray<SKProduct *> * _Nonnull)products
      completionHandler:(void (^)(BOOL finished,
                                  NSString *errorString,
                                  NSMutableArray *returningPremiumPlanProductsArray,
                                  NSMutableDictionary *returningPremiumPlanPricesDict,
                                  NSMutableDictionary *returningPremiumPlanExpensivePricesDict,
                                  NSMutableDictionary *returningPremiumPlanPricesDiscountDict,
                                  NSMutableDictionary *returningPremiumPlanPricesNoFreeTrialDict))finishBlock;

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Internal Methods
#pragma mark
#pragma mark
#pragma mark -

-(NSMutableArray *)GenerateArrayOfRepeatingDayIntervalDueDates:(NSMutableArray *)allDueDatesArray itemRepeats:(NSString *)itemRepeats;
-(NSMutableArray *)GenerateArrayOfRepeatingWeekOrMonthIntervalDueDates:(NSMutableArray *)allDueDatesArray itemRepeats:(NSString *)itemRepeats;

@end

NS_ASSUME_NONNULL_END
