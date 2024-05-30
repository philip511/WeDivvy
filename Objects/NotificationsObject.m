//
//  NotificationsObject.m
//  WeDivvy
//
//  Created by Philip Nagel on 9/18/21.
//

#import "NotificationsObject.h"
#import "GeneralObject.h"
#import "GetDataObject.h"
#import "SetDataObject.h"
#import "BoolDataObject.h"

#import "AnalyticsViewController.h"

//Title - 31 Characters
//Body - 73 Characters

@implementation NotificationsObject

#pragma mark - Notification Methods

-(void)SendLocalNotificationReminderNotifications:(NSMutableDictionary *)dictToUse
                                         itemType:(NSString *)itemType
                                      userIDArray:(NSMutableArray *)usersSendingNotificationsToArray
                                  homeMembersDict:(NSMutableDictionary *)homeMembersDict
                         notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict
                                allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays
                             notificationItemType:(NSString *)notificationItemType
                                 notificationType:(NSString *)notificationType
                                        topicDict:(NSMutableDictionary *)topicDict
                                completionHandler:(void (^)(BOOL finished))finishBlock {
    
    BOOL TaskIsDeleted = [[[BoolDataObject alloc] init] TaskIsDeleted:dictToUse itemType:itemType];
    BOOL TaskIsAnOccurrence = [[[BoolDataObject alloc] init] TaskIsOccurrence:dictToUse itemType:itemType];
    BOOL TaskIsTrash = [[[BoolDataObject alloc] init] TaskIsTrash:dictToUse itemType:itemType];
    BOOL TaskIsPaused = [[[BoolDataObject alloc] init] TaskIsPaused:dictToUse itemType:itemType];
    BOOL TaskHasBeenMuted = [[[BoolDataObject alloc] init] TaskHasBeenMuted:dictToUse];
    BOOL TaskIsRepeatingWhenCompleted = [[[BoolDataObject alloc] init] TaskIsRepeatingWhenCompleted:dictToUse itemType:itemType];
    BOOL TaskIsCompleteAsNeeded = [[[BoolDataObject alloc] init] TaskIsCompleteAsNeeded:dictToUse itemType:itemType];
    
    if (TaskIsRepeatingWhenCompleted == YES ||
        TaskIsCompleteAsNeeded == YES ||
        TaskIsAnOccurrence == YES ||
        TaskIsTrash == YES ||
        TaskIsPaused == YES ||
        TaskHasBeenMuted == YES ||
        TaskIsDeleted == YES) {
        
        finishBlock(YES);
        
    } else {
        
        NSString *myUserID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
        
        //Get All The Necessary Data
        NSString *itemID = dictToUse[@"ItemID"] ? dictToUse[@"ItemID"] : @"";
        NSString *itemOccurrenceID = dictToUse[@"ItemOccurrenceID"] ? dictToUse[@"ItemOccurrenceID"] : @"";
        NSString *itemName = dictToUse[@"ItemName"] ? dictToUse[@"ItemName"] : @"";
        NSString *itemCreatedBy = dictToUse[@"ItemCreatedBy"] ? dictToUse[@"ItemCreatedBy"] : @"";
        NSString *itemTime = dictToUse[@"ItemTime"] ? dictToUse[@"ItemTime"] : @"";
        NSString *itemTimeOriginal = dictToUse[@"ItemTime"] ? dictToUse[@"ItemTime"] : @"";
        NSString *itemRepeats = dictToUse[@"ItemRepeats"] ? dictToUse[@"ItemRepeats"] : @"";
        NSString *itemRepeatIfCompletedEarly = dictToUse[@"ItemRepeatIfCompletedEarly"] ? dictToUse[@"ItemRepeatIfCompletedEarly"] : @"";
        NSString *itemCompleteAsNeeded = dictToUse[@"ItemCompleteAsNeeded"] ? dictToUse[@"ItemCompleteAsNeeded"] : @"";
        NSString *itemDatePosted = dictToUse[@"ItemDatePosted"] ? dictToUse[@"ItemDatePosted"] : @"";
        NSString *itemDateLastReset = dictToUse[@"ItemDateLastReset"] ? dictToUse[@"ItemDateLastReset"] : @"";
        NSString *itemDays = dictToUse[@"ItemDays"] ? dictToUse[@"ItemDays"] : @"";
        NSString *itemDueDate = dictToUse[@"ItemDueDate"] ? dictToUse[@"ItemDueDate"] : @"";
        NSString *itemStartDate = dictToUse[@"ItemStartDate"] ? dictToUse[@"ItemStartDate"] : @"";
        NSString *itemEndDate = dictToUse[@"ItemEndDate"] ? dictToUse[@"ItemEndDate"] : @"";
        NSString *itemTakeTurns = dictToUse[@"ItemTakeTurns"] ? dictToUse[@"ItemTakeTurns"] : @"";
        NSString *itemTurnUserID = dictToUse[@"ItemTurnUserID"] ? dictToUse[@"ItemTurnUserID"] : @"";
        NSString *itemAlternateTurns = dictToUse[@"ItemAlternateTurns"] ? dictToUse[@"ItemAlternateTurns"] : @"Every Occurrence";
        NSString *itemRandomizeTurnOrder = dictToUse[@"ItemRandomizeTurnOrder"] ? dictToUse[@"ItemRandomizeTurnOrder"] : @"No";
        
        NSDictionary *itemReminderDict = dictToUse[@"ItemReminderDict"] ? dictToUse[@"ItemReminderDict"] : [[[GeneralObject alloc] init] GenerateDefaultRemindersDict:itemType itemAssignedTo:dictToUse[@"ItemAssignedTo"] itemRepeats:dictToUse[@"ItemRepeats"] homeMembersDict:homeMembersDict AnyTime:[itemTime isEqualToString:@"Any Time"]];
        NSString *itemMustComplete = dictToUse[@"ItemMustComplete"] ? dictToUse[@"ItemMustComplete"] : @"";
        NSString *itemGracePeriod = dictToUse[@"ItemGracePeriod"] ? dictToUse[@"ItemGracePeriod"] : @"";
        NSString *itemItemized = dictToUse[@"ItemItemized"] ? dictToUse[@"ItemItemized"] : @"";
        
        NSMutableArray *itemAssignedTo = dictToUse[@"ItemAssignedTo"] ? [dictToUse[@"ItemAssignedTo"] mutableCopy] : [NSMutableArray array];
        NSMutableArray *itemDueDatesSkipped = dictToUse[@"ItemDueDatesSkipped"] ? [dictToUse[@"ItemDueDatesSkipped"] mutableCopy] : [NSMutableArray array];
        NSMutableArray *itemSpecificDueDatesArray = dictToUse[@"ItemSpecificDueDates"] ? [dictToUse[@"ItemSpecificDueDates"] mutableCopy] : [NSMutableArray array];
        
        NSMutableDictionary *itemCompletedDict = dictToUse[@"ItemCompletedDict"] ? [dictToUse[@"ItemCompletedDict"] mutableCopy] : [NSMutableDictionary dictionary];
        NSMutableDictionary *itemWontDo = dictToUse[@"ItemWontDo"] ? [dictToUse[@"ItemWontDo"] mutableCopy] : [NSMutableDictionary dictionary];
        NSMutableDictionary *itemAdditionalReminders = dictToUse[@"ItemAdditionalReminders"] ? [dictToUse[@"ItemAdditionalReminders"] mutableCopy] : [NSMutableDictionary dictionary];
        
        NSMutableArray *itemListItemKeys = dictToUse[@"ItemListItems"] ? [[dictToUse[@"ItemListItems"] allKeys] mutableCopy] : [NSMutableArray array];
        NSMutableArray *itemItemizedItemKeys = dictToUse[@"ItemItemizedItems"] ? [[dictToUse[@"ItemItemizedItems"] allKeys] mutableCopy] : [NSMutableArray array];
        
        
        
        
        
        
        NSMutableDictionary *itemTimeDict = [@{@"Hour" : @"", @"Minute" : @"", @"AMPM" : @""} mutableCopy];
        
        BOOL TaskIsRepeating = [[[BoolDataObject alloc] init] TaskIsRepeating:dictToUse itemType:itemType];
        BOOL TaskIsRepeatingHourly = [[[BoolDataObject alloc] init] TaskIsRepeatingHourly:dictToUse itemType:itemType];
        BOOL TaskIsRepeatingDaily = [[[BoolDataObject alloc] init] TaskIsRepeatingDaily:dictToUse itemType:itemType];
        BOOL TaskIsRepeatingMonthly = [[[BoolDataObject alloc] init] TaskIsRepeatingMonthly:dictToUse itemType:itemType];
        
        if (TaskIsRepeating == YES) {
            
            itemTime = dictToUse[@"ItemTime"] ? dictToUse[@"ItemTime"] : @"Any Time";
            
            if ([itemTime isEqualToString:@"Any Time"]) {
                itemTime = @"11:59 PM";
            }
            
            itemTimeDict = [[[[GeneralObject alloc] init] GenerateItemTime12HourDict:itemTime] mutableCopy];
            
        }
        
        
        
        
        
        
        //Remove Any Time Which Could Cause A Crash
        itemStartDate = [[[GeneralObject alloc] init] GenerateStringWithReplacementString:itemStartDate stringToReplace:@"Any Time" replacementString:@"12:00 AM"];
        itemEndDate = [[[GeneralObject alloc] init] GenerateStringWithReplacementString:itemEndDate stringToReplace:@"Any Time" replacementString:@"11:59 PM"];
        itemDueDate = [[[GeneralObject alloc] init] GenerateStringWithReplacementString:itemDueDate stringToReplace:@"Any Time" replacementString:@"11:59 PM"];
        itemTime = [[[GeneralObject alloc] init] GenerateStringWithReplacementString:itemTime stringToReplace:@"Any Time" replacementString:@"11:59 PM"];
        
        
        
        
        
        
        if ([itemRandomizeTurnOrder isEqualToString:@"Yes"]) {
            
            //Rearrange ItemAssignedTo (Unknown)
            NSMutableArray *itemAssignedToRearranged = itemAssignedTo ? [itemAssignedTo mutableCopy] : [NSMutableArray array];
            NSMutableArray *itemAssignedToRearrangedCopy = itemAssignedToRearranged ? [itemAssignedToRearranged mutableCopy] : [NSMutableArray array];
            
            for (int i=0 ; i<itemAssignedToRearrangedCopy.count ; i++) {
                
                if ([itemAssignedToRearranged containsObject:itemTurnUserID]) {
                    
                    NSUInteger index = [itemAssignedToRearranged indexOfObject:itemTurnUserID];
                    
                    if (index == 0) {
                        break;
                    }
                    
                    NSString *tempUserID = [itemAssignedToRearranged count] > itemAssignedToRearranged.count - 1 ? itemAssignedToRearranged[itemAssignedToRearranged.count - 1] : @"";
                    [itemAssignedToRearranged removeObject:tempUserID];
                    [itemAssignedToRearranged insertObject:tempUserID atIndex:0];
                    
                }
                
            }
            
            itemAssignedTo = [itemAssignedToRearranged mutableCopy];
            
        }
        
        //Get Index Of Currently Logged In User In ItemAssignedTo
        NSInteger indexUsedInTakingTurns = -1;
        
        for (NSString *userID in itemAssignedTo) {
            
            if ([userID isEqualToString:myUserID] &&
                [itemAssignedTo containsObject:userID]) {
                
                indexUsedInTakingTurns = [itemAssignedTo indexOfObject:userID];
                
            }
            
        }
        
        
        
        
        
        
        //Init Some Necessary Data
        NSString *dateFormat = @"MMMM dd, yyyy hh:mm a";
        NSString *dateStringCurrent = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:dateFormat returnAs:[NSString class]];
        
        //Use To Test Updating Due Dates - Search this string to find sister code
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"TestDueDateIsSet"] isEqualToString:@"Yes"]) {
            dateStringCurrent = [[NSUserDefaults standardUserDefaults] objectForKey:@"TestDueDate"];
        }
        
        BOOL ItemIsRepeating = [[[BoolDataObject alloc] init] TaskIsRepeating:[@{@"ItemRepeats" : itemRepeats} mutableCopy] itemType:itemType];
        BOOL ItemHasGracePeriod = [[[BoolDataObject alloc] init] TaskHasGracePeriod:[@{@"ItemGracePeriod" : itemGracePeriod} mutableCopy] itemType:itemType];
        BOOL ItemStartDateSelected = [[[BoolDataObject alloc] init] ItemStartDateSelected:[@{@"ItemStartDate" : itemStartDate, @"ItemRepeats" : itemRepeats} mutableCopy] itemType:itemType];
        BOOL ItemEndDateSelected = [[[BoolDataObject alloc] init] ItemEndDateSelected:[@{@"ItemEndDate" : itemEndDate, @"ItemRepeats" : itemRepeats} mutableCopy] itemType:itemType];
        BOOL TaskEndIsNumberOfTimes = [[[BoolDataObject alloc] init] TaskEndIsNumberOfTimes:[@{@"ItemEndDate" : itemEndDate, @"ItemRepeats" : itemRepeats} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType]];
        BOOL ItemEndDateNumOfTimesHasPassed = NO;
        
        int totalNotificationsAdded = 0;
        
        NSMutableArray *myIndexesForMyDueDatesArray = [NSMutableArray array];
        
        
        
        
        
        
        BOOL TakingTurnsIndexWasFound = (indexUsedInTakingTurns != -1 && indexUsedInTakingTurns < 10000);
        BOOL TaskIsTakingTurns = [[[BoolDataObject alloc] init] TaskIsTakingTurns:[@{@"ItemTakeTurns" : itemTakeTurns} mutableCopy] itemType:itemType];
        
        if ((TaskIsTakingTurns == YES && TakingTurnsIndexWasFound == YES) || TaskIsTakingTurns == NO) {
            
            
            
          
            
            
            //Generate All The Due Dates For This Task
            NSMutableArray *allDueDatesArray;
            int totalAmountOfFutureDates = TaskIsTakingTurns == YES ? 5 * (int)itemAssignedTo.count : 5;
            
            if (TaskIsRepeatingMonthly == YES) {
                totalAmountOfFutureDates = TaskIsTakingTurns == YES ? 36 * (int)itemAssignedTo.count : 36;
            }
            
            if (ItemIsRepeating == YES) {
                
                BOOL TaskIsRepeatingAndRepeatingIfCompletedEarly = [[[BoolDataObject alloc] init] TaskIsRepeatingAndRepeatingIfCompletedEarly:[@{@"ItemRepeatIfCompletedEarly" : itemRepeatIfCompletedEarly, @"ItemRepeats" : itemRepeats} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType]];
                
                NSString *itemDueDateToUse = TaskIsRepeatingAndRepeatingIfCompletedEarly == YES ? itemDueDate : @"";
          
                allDueDatesArray = [[[NotificationsObject alloc] init] GenerateArrayOfRepeatingDueDates:itemRepeats itemRepeatIfCompletedEarly:itemRepeatIfCompletedEarly itemCompleteAsNeeded:itemCompleteAsNeeded totalAmountOfFutureDates:totalAmountOfFutureDates maxAmountOfDueDatesToLoopThrough:1000 itemDatePosted:itemDatePosted itemDueDate:itemDueDateToUse itemStartDate:itemStartDate itemEndDate:itemEndDate itemTime:itemTime itemDays:itemDays itemDueDatesSkipped:itemDueDatesSkipped itemDateLastReset:itemDateLastReset SkipStartDate:NO];
                
            } else if (ItemIsRepeating == NO) {
                
                allDueDatesArray = itemSpecificDueDatesArray.count > 0 ? itemSpecificDueDatesArray : [@[itemDueDate] mutableCopy];
                
            }
            
            
           
            
            
            
            //Generate The Indexes Of The Due Dates Needed For The Currently Logged In User
            if (ItemIsRepeating == YES && TaskIsTakingTurns == YES && TakingTurnsIndexWasFound == YES) {
                
                myIndexesForMyDueDatesArray = [[[NotificationsObject alloc] init] GenerateArrayOfIndexesForDueDatesEveryXOccurrences:(int)indexUsedInTakingTurns totalAmountOfFutureDates:totalAmountOfFutureDates totalAssignedToUsers:(int)itemAssignedTo.count itemAlternateTurns:itemAlternateTurns dueDateStrings:allDueDatesArray itemTurnUserID:itemTurnUserID];
                
            } else if ((ItemIsRepeating == YES && TaskIsTakingTurns == NO) || ItemIsRepeating == NO) {
                
                myIndexesForMyDueDatesArray = [[[NotificationsObject alloc] init] GenerateArrayOfIndexesForDueDates:totalAmountOfFutureDates];
                
            }
            
            
       
            
            
            
            //Remove All Due Dates That Have Already Passed
            allDueDatesArray = [[[NotificationsObject alloc] init] GenerateArrayWithOldDueDatesRemoved:allDueDatesArray itemDueDate:itemDueDate];
            
            
     
          
            
            
            //Generate All Due Dates For Currently Logged In User Based On The Previous Indexes Found
            NSMutableArray *allMySpecificDueDatesArray = [[[NotificationsObject alloc] init] GenerateArrayOfMyDueDates:allDueDatesArray myIndexesForMyDueDatesArray:myIndexesForMyDueDatesArray];
            
            
            
          
            
            
            int maxAmountOfNotificationsToBeAdded = TaskIsRepeatingHourly == YES || TaskIsRepeatingDaily == YES ? 3 : 2;
            
            for (int i=0; totalNotificationsAdded<maxAmountOfNotificationsToBeAdded && i<allMySpecificDueDatesArray.count; i++) {
                
                
                
                
                
                
                //Remove Any Time For The Current Potential Due Date
                NSString *currentIterationDueDate = [[[GeneralObject alloc] init] GenerateStringWithReplacementString:allMySpecificDueDatesArray[i] stringToReplace:@"Any Time" replacementString:@"11:59 PM"];
                
                //Generate The Current Potential Due Date Plus It's Grace Period
                NSString *currentIterationDueDateWithGracePeriod = ItemHasGracePeriod == YES ? [[[NotificationsObject alloc] init] GenerateDueDateWithGracePeriod:currentIterationDueDate itemGracePeriod:itemGracePeriod] : currentIterationDueDate;
                
                NSTimeInterval secondsUntilCurrentDueDate = [[[GeneralObject alloc] init] GenerateTimeIntervalBetweenTwoDates:dateStringCurrent dateString2:itemDueDate dateFormat:dateFormat];
                NSTimeInterval secondsUntilFutureDueDate = [[[GeneralObject alloc] init] GenerateTimeIntervalBetweenTwoDates:dateStringCurrent dateString2:currentIterationDueDateWithGracePeriod dateFormat:dateFormat];
                
                NSTimeInterval secondsSinceStartDate = 1;
                NSTimeInterval secondsUntilEndDate = 1;
                
                //Find Seconds Since Start Date Has Passed
                if (ItemStartDateSelected == YES) {
                    secondsSinceStartDate = [[[GeneralObject alloc] init] GenerateTimeIntervalBetweenTwoDates:itemStartDate dateString2:currentIterationDueDateWithGracePeriod dateFormat:dateFormat];
                }
                //Find Seconds Until End Date Passes
                if (ItemEndDateSelected == YES && TaskEndIsNumberOfTimes == NO) {
                    secondsUntilEndDate = [[[GeneralObject alloc] init] GenerateTimeIntervalBetweenTwoDates:currentIterationDueDateWithGracePeriod dateString2:itemEndDate dateFormat:dateFormat];
                } else if (ItemEndDateSelected == YES && TaskEndIsNumberOfTimes == YES) {
                    ItemEndDateNumOfTimesHasPassed = [[[BoolDataObject alloc] init] TaskEndHasPassed:[@{@"ItemEndDate" : itemEndDate, @"ItemRepeats" : itemRepeats} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType] numberOfTaskOccurrences:i+1];
                    
                }
                
                if ([[NSString stringWithFormat:@"%f", secondsSinceStartDate] containsString:@"nan"]) {
                    secondsSinceStartDate = 1;
                }
                
                if ([[NSString stringWithFormat:@"%f", secondsUntilEndDate] containsString:@"nan"]) {
                    secondsUntilEndDate = 1;
                }
                
                int gracePeriodSeconds = [[[GeneralObject alloc] init] GenerateSecondsFromDisplayTime:itemGracePeriod];
                
                
                
                
                
                
                //Check If Potential Future Due Date Is Later Than The Current Date
                BOOL PotentialFutureDueDateIsLaterThanCurrentDate = secondsUntilFutureDueDate > 0;
                //Check If Potential Future Due Date Is Later Than The Current Item Due Date
                //Remove Grace Period From This Amount To Check If The Due Date Alone Is Valid, It Was Added A Few Lines Above
                BOOL PotentialFutureDueDateIsLaterThanCurrentDueDate = secondsUntilFutureDueDate - (ItemHasGracePeriod == YES ? gracePeriodSeconds : 0) > secondsUntilCurrentDueDate;
                //Check If The Item End Date Is Later Than The Potential Future Due Date
                BOOL PotentialFutureDueDateIsNotPassedEndDate = secondsUntilEndDate >= 0;
                //Check If The Item Start Date Is NOT Later Than The Potential Future Due Date
                BOOL PotentialFutureDueDateIsLaterThanStartDate = secondsSinceStartDate > 0;
                
                
                
                
                
                //Get The Data Needed To Check If The Task Is Fully Completed Or Not
                NSMutableArray *arrayToCompareCompletedWith = [itemAssignedTo mutableCopy];
                
                if ([itemType isEqualToString:@"Expense"] && [itemItemized isEqualToString:@"Yes"]) {
                    
                    arrayToCompareCompletedWith = [itemItemizedItemKeys mutableCopy];
                    
                } else if ([itemType isEqualToString:@"List"] && itemListItemKeys.count > 0) {
                    
                    arrayToCompareCompletedWith = [itemListItemKeys mutableCopy];
                    
                }
                
                NSString *currentUsersTurn = itemTurnUserID;
                
                
                
                
                
                
                BOOL TaskIsAList = [itemType isEqualToString:@"List"];
                BOOL TaskIsItemized = [itemType isEqualToString:@"Expense"] && [itemItemized isEqualToString:@"Yes"];
                BOOL TaskIsTakingTurns = [[[BoolDataObject alloc] init] TaskIsTakingTurns:[@{@"ItemTakeTurns" : itemTakeTurns} mutableCopy] itemType:itemType];
                BOOL TaskIsAssignedToNobody = [[[BoolDataObject alloc] init] TaskIsAssignedToNobody:[@{@"ItemAssignedTo" : itemAssignedTo} mutableCopy] itemType:itemType];
                BOOL TaskIsCompletedByTakingTurnsUser = ([[itemCompletedDict allKeys] count] >= 1 && [[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemCompletedDict userIDToFind:currentUsersTurn]) ||
                ([[itemWontDo allKeys] count] >= 1 && [[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemWontDo userIDToFind:currentUsersTurn]);
                BOOL TaskCompletedIsEqualToComparableArray = ([[itemCompletedDict allKeys] count] + [[itemWontDo allKeys] count]) >= arrayToCompareCompletedWith.count;
                BOOL TaskCompletedByAllHomeMembers = homeMembersDict[@"UserID"] ? (([(NSArray *)[itemCompletedDict allKeys] count] + [(NSArray *)[itemWontDo allKeys] count]) >= [(NSArray *)homeMembersDict[@"UserID"] count]) : NO;
                BOOL TaskMustBeCompletedByEveryoneAssigned = [itemMustComplete isEqualToString:@"Everyone"] || [itemMustComplete isEqualToString:@""] || [itemMustComplete isEqualToString:@"(null)"] || itemMustComplete == NULL;
                BOOL TaskCompletedIsEqualToMinimumAmountOfComparableArray = TaskMustBeCompletedByEveryoneAssigned == NO && [itemMustComplete containsString:@" "] && [[itemMustComplete componentsSeparatedByString:@" "] count] > 1 ?
                (([[itemCompletedDict allKeys] count] + [[itemWontDo allKeys] count]) >= [[itemMustComplete componentsSeparatedByString:@" "][1] intValue]) : NO;
                
                
                
                
                
                
                BOOL TaskIsFullyCompleted =
                (TaskIsAssignedToNobody == NO && TaskCompletedIsEqualToComparableArray == YES && TaskMustBeCompletedByEveryoneAssigned == YES) ||
                (TaskIsAList == NO && TaskIsItemized == NO && TaskIsAssignedToNobody == YES && TaskMustBeCompletedByEveryoneAssigned == YES && TaskCompletedByAllHomeMembers == YES && TaskIsTakingTurns == NO) ||
                (TaskIsAList == NO && TaskIsItemized == NO && TaskCompletedIsEqualToMinimumAmountOfComparableArray == YES && TaskMustBeCompletedByEveryoneAssigned == NO && TaskIsTakingTurns == NO) ||
                (TaskIsAList == NO && TaskIsItemized == NO && TaskIsAssignedToNobody == NO && TaskIsCompletedByTakingTurnsUser == YES && TaskIsTakingTurns == YES);
                
                BOOL TaskIsFullyUncompleted = [[itemCompletedDict allKeys] count] == 0 && [[itemWontDo allKeys] count] == 0;
                
                
                
                
                
                //First If
                BOOL TaskIsFullyCompletedOrIsFullyUncompleted = (TaskIsFullyCompleted == YES || TaskIsFullyUncompleted == YES);
                
                //Second If
                BOOL PotentialFutureDueDateIsEqualToOrLaterThanCurrentDueDate = secondsUntilFutureDueDate >= secondsUntilCurrentDueDate;
                
                //Both If
                BOOL CurrentUserCompletedThisTask = ([[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemCompletedDict userIDToFind:myUserID]);
                BOOL CurrentUserWontDoThisTask = ([[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemWontDo userIDToFind:myUserID]);
                BOOL YouAreAssignedToThisTask = myUserID && ([itemAssignedTo containsObject:myUserID]);
                
                BOOL PotentialFutureDueDateIsValid = (PotentialFutureDueDateIsLaterThanCurrentDate == YES && PotentialFutureDueDateIsNotPassedEndDate == YES && PotentialFutureDueDateIsLaterThanStartDate == YES && ItemEndDateNumOfTimesHasPassed == NO);
                BOOL PotentialFutureDueDateIsUseable = (PotentialFutureDueDateIsEqualToOrLaterThanCurrentDueDate == YES && TaskIsFullyUncompleted == YES) || (PotentialFutureDueDateIsLaterThanCurrentDueDate == YES && TaskIsFullyCompleted == YES);
                
                
                
                
                
                
                BOOL TwoReminderAndDueNowNotificationsMustBeGenerated = (PotentialFutureDueDateIsValid == YES &&
                                                                         PotentialFutureDueDateIsUseable == YES &&
                                                                         TaskIsFullyCompletedOrIsFullyUncompleted == YES);
                
                BOOL ThreeReminderAndDueNowNotificationsMustBeGenerated = (PotentialFutureDueDateIsValid == YES &&
                                                                           PotentialFutureDueDateIsEqualToOrLaterThanCurrentDueDate == YES &&
                                                                           TaskIsFullyCompletedOrIsFullyUncompleted == NO);
                
                //RemindersDict With "Before" Reminders Removed For Creator of Task If They Are Not Assigned
                //Creator Of Task Should Not Be Receiving These Reminders If They Are Not Assigned
                NSMutableDictionary *itemReminderDictWithBeforeRemindersTakenOut = [itemReminderDict mutableCopy];
               
                for (NSString *itemReminderTitle in [itemReminderDict allKeys]) {
                    if ([itemReminderTitle containsString:@"Before"] ||
                        [itemReminderTitle containsString:@"On The Day at"] ||
                        [itemReminderTitle containsString:@" Day Before at "] ||
                        [itemReminderTitle containsString:@" Days Before at "]) {
                       if ([[itemReminderDictWithBeforeRemindersTakenOut allKeys] containsObject:itemReminderTitle]) {
                            [itemReminderDictWithBeforeRemindersTakenOut removeObjectForKey:itemReminderTitle];
                        }
                    }
                }
              
                
                if (TwoReminderAndDueNowNotificationsMustBeGenerated == YES) {
                    
                    /* Here we will be creating two reminder and two due now notifications for a task that is fully completed, they will be created for the next two due dates */
                    /* Or we will be creating two reminder and two due now notifications for a task that is fully uncompleted, they will be created for the current due date and the next due date */
                    
                    
                    
                    
                    
                    
                    //Remove grace period seconds to properly check if reminder and due now notifications are needed
                    //Not removing the grace period seconds might make the method think there is more time remaining until the due date then there actually is, causing it to add a reminder and/or due now notification
                    
                    BOOL GracePeriodSecondsHaveBeenRemoved = NO;
                    
                    if (ItemHasGracePeriod == YES && [itemTimeOriginal isEqualToString:@"Any Time"] == NO) {
                        
                        int gracePeriodSeconds = [[[GeneralObject alloc] init] GenerateSecondsFromDisplayTime:itemGracePeriod];
                        
                        secondsUntilFutureDueDate -= gracePeriodSeconds;
                        
                        GracePeriodSecondsHaveBeenRemoved = YES;
                        
                    }
                    
                    
                    
                    
                    
                    
                    NSMutableDictionary *newItemCompletedDict = [itemCompletedDict mutableCopy];
                    NSMutableDictionary *newItemWontDoDict = [itemWontDo mutableCopy];
                    NSDictionary *newItemReminderDict = [itemReminderDict mutableCopy];
                    NSMutableDictionary *newItemAdditionalReminders = itemAdditionalReminders[myUserID] ? [itemAdditionalReminders[myUserID] mutableCopy] : [NSMutableDictionary dictionary];
                    
                    BOOL RemoveReminderNotification = (YouAreAssignedToThisTask == NO && TaskIsAssignedToNobody == NO);
                    
                    newItemCompletedDict = TaskIsFullyCompletedOrIsFullyUncompleted == YES ? [NSMutableDictionary dictionary] : [itemCompletedDict mutableCopy];
                    newItemWontDoDict = TaskIsFullyCompletedOrIsFullyUncompleted == YES ? [NSMutableDictionary dictionary] : [itemWontDo mutableCopy];
                    newItemReminderDict = RemoveReminderNotification == YES ? itemReminderDictWithBeforeRemindersTakenOut : itemReminderDict;
                    newItemAdditionalReminders = TaskIsFullyCompletedOrIsFullyUncompleted == YES ? [NSMutableDictionary dictionary] : [itemAdditionalReminders mutableCopy];
                    
                    
                    
                    
                    
                    
                    NSMutableArray *arrayOfUsersCurrentlyAssigned = [NSMutableArray array];
                    
                    if (TaskIsTakingTurns == YES) {
                        
                        //Get the userID and username of the users whose turn it is
                        
                        arrayOfUsersCurrentlyAssigned = [@[itemTurnUserID] mutableCopy];
                        
                    } else {
                        
                        //Get the userID and username of everyone assigned
                        
                        arrayOfUsersCurrentlyAssigned = [itemAssignedTo mutableCopy];
                        
                    }
                    
                    
                    
                    
                    
                    
                    NSMutableDictionary *notificationTextDict = [[[NotificationsObject alloc] init] GenerateNotificationMessages:itemType itemID:itemID itemOccurrenceID:itemOccurrenceID itemName:itemName itemCreatedBy:itemCreatedBy itemAssignedTo:arrayOfUsersCurrentlyAssigned itemAssignedToOriginal:itemAssignedTo itemCompletedDict:newItemCompletedDict itemReminderDict:newItemReminderDict itemAdditionalReminders:newItemAdditionalReminders itemListItemKeys:itemListItemKeys itemGracePeriod:itemGracePeriod itemTakeTurns:itemTakeTurns itemAlternateTurns:itemAlternateTurns itemTurnUserID:itemTurnUserID itemTimeOriginal:itemTimeOriginal homeMembersDict:homeMembersDict];
                    
                    NSString *frequency;
                    int removeSeconds = 0;
                    int removeGracePeriodSeconds = 0;
                    
                    
                    
                    
                    
                    
                    BOOL NotificationOfficiallyAdded = NO;
                    
                    for (NSString *key in [notificationTextDict allKeys]) {
                        
                        
                        
                        
                        
                        
                        frequency = [[[NotificationsObject alloc] init] GenerateFrequencyString:key secondsBetweenHour:secondsUntilFutureDueDate];
                        removeSeconds = [[[NotificationsObject alloc] init] GenerateRemoveSeconds:key secondsUntilTaskIsDue:secondsUntilFutureDueDate gracePeriodSecondsToSubtract:removeGracePeriodSeconds];
                        
                        BOOL FrequencyIsValid = (![frequency containsString:@"(null)"] && frequency != NULL && frequency != nil);
                        BOOL RemoveGracePeriodDueNowNotification = (ItemHasGracePeriod == YES && RemoveReminderNotification == YES && [frequency isEqualToString:@"Now"] == YES);
                        
                        
                        
                        
                        
                        
                        //Check if the "Before" reminders were removed, if so, remove due now notification and only leave the grace period notification
                        //"Before" reminders are removed if the currently logged in user is the crator of the task and is not assigned, they shouldn't be receiving "Before" reminders
                        
                        if (FrequencyIsValid == YES && RemoveGracePeriodDueNowNotification == NO) {
                            
                            
                            
                            
                            
                            
                            //If grace period seconds were removed add them back in to properly check if grace period notification is needed
                            //Task cannot be fully completed, this prevents the grace period notification from a completed task from being re-added
                            
                            BOOL GracePeriodNotificationsHaveBeenReAdded = NO;
                            
                            if (GracePeriodSecondsHaveBeenRemoved == YES && [frequency isEqualToString:@"Grace Period"] == YES && [itemTimeOriginal isEqualToString:@"Any Time"] == NO) {
                                
                                GracePeriodNotificationsHaveBeenReAdded = YES;
                                
                                int gracePeriodSeconds = [[[GeneralObject alloc] init] GenerateSecondsFromDisplayTime:itemGracePeriod];
                                secondsUntilFutureDueDate += gracePeriodSeconds;
                                
                            }
                            
                            NSString *identifier = [NSString stringWithFormat:@"%@ - %d %@", itemID, i, frequency];
                            
                            BOOL IdentifierIsValid = (![identifier containsString:@"(null)"] && identifier != NULL && identifier != nil);
                            BOOL NonGracePeriodNotificationIsValid = (secondsUntilFutureDueDate - removeSeconds > 0);
                            
                            
                            
                            
                            
                            
                            if (IdentifierIsValid == YES && NonGracePeriodNotificationIsValid == YES) {
                                
                                BOOL AddActions = TaskIsItemized == NO && TaskIsAList == NO;
                                
                                [[[NotificationsObject alloc] init] GenerateAndAddNotificationRequest:itemID itemOccurrenceID:itemOccurrenceID itemType:itemType notificationTextDict:notificationTextDict key:key i:i currentIterationDueDate:currentIterationDueDate secondsUntilDueDate:secondsUntilFutureDueDate removeSeconds:removeSeconds itemAssignedTo:itemAssignedTo notificationSettingsDict:notificationSettingsDict allItemTagsArrays:allItemTagsArrays notificationItemType:notificationItemType notificationType:notificationType AddActions:AddActions];
                                
                                
                                
                                
                                
                                
                                NotificationOfficiallyAdded = YES;
                                
                                if (GracePeriodNotificationsHaveBeenReAdded == YES && [itemTimeOriginal isEqualToString:@"Any Time"] == NO) {
                                    
                                    GracePeriodNotificationsHaveBeenReAdded = NO;
                                    
                                    int gracePeriodSeconds = [[[GeneralObject alloc] init] GenerateSecondsFromDisplayTime:itemGracePeriod];
                                    secondsUntilFutureDueDate -= gracePeriodSeconds;
                                    
                                }
                                
                                
                                
                                
                                
                            }
                            
                            
                            
                            
                            
                            
                        }
                        
                        
                        
                        
                        
                        
                    }
                    
                    
                    
                    
                    
                    
                    if (NotificationOfficiallyAdded == YES) {
                        totalNotificationsAdded += 1;
                    }
                    
                    
                    
                    
                    
                    
                } else if (ThreeReminderAndDueNowNotificationsMustBeGenerated == YES) {
                    
                    /* Here we will be creating two reminder and three due now notifications for a task that is partially completed, one due now will be for the current task and the rest will be created for the next two tasks */
                    
                    
                    
                    
                    
                    
                    maxAmountOfNotificationsToBeAdded = TaskIsRepeatingHourly == YES || TaskIsRepeatingDaily == YES ? 3 : 2;
                    
                    
                    
                    
                    
                    
                    //Remove grace period seconds to properly check if reminder and due now notifications are needed
                    //Not removing the grace period seconds might make the method think there is more time remaining until the due date then there actually is and causing it to add a reminder and/or due not notification
                    
                    BOOL GracePeriodSecondsHaveBeenRemoved = NO;
                    
                    if (ItemHasGracePeriod == YES && [itemTimeOriginal isEqualToString:@"Any Time"] == NO) {
                        
                        int gracePeriodSeconds = [[[GeneralObject alloc] init] GenerateSecondsFromDisplayTime:itemGracePeriod];
                        secondsUntilFutureDueDate -= gracePeriodSeconds;
                        
                        GracePeriodSecondsHaveBeenRemoved = YES;
                        
                    }
                    
                    
                    
                    
                    
                    
                    NSDictionary *newItemReminderDict = [itemReminderDict copy];
                    NSMutableDictionary *newItemCompletedDict = [itemCompletedDict mutableCopy];
                    NSMutableDictionary *newItemWontDoDict = [itemWontDo mutableCopy];
                    NSMutableDictionary *newItemAdditionalReminders = [itemAdditionalReminders mutableCopy];
                    
                    //If Current Iteration Due Date Is The Same As Current Due Date, Generate Individual Due Now Notification For Remaining Uncompleted Members
                    //Else Generate Reminder and Due Now Notification With All Users Assigned as Uncompleted Members For Future Tasks
                    BOOL PotentialFutureDateDateIsEqualToCurrentDueDate = secondsUntilFutureDueDate == secondsUntilCurrentDueDate;
                    
                    BOOL RemoveReminderNotification = ((YouAreAssignedToThisTask == NO && TaskIsAssignedToNobody == NO) || ((CurrentUserCompletedThisTask == YES || CurrentUserWontDoThisTask == YES) && PotentialFutureDateDateIsEqualToCurrentDueDate == YES));
                    
                    newItemCompletedDict = PotentialFutureDateDateIsEqualToCurrentDueDate == YES || (PotentialFutureDateDateIsEqualToCurrentDueDate == NO && ItemHasGracePeriod == YES) ? itemCompletedDict : [NSMutableDictionary dictionary];
                    newItemWontDoDict = PotentialFutureDateDateIsEqualToCurrentDueDate == YES || (PotentialFutureDateDateIsEqualToCurrentDueDate == NO && ItemHasGracePeriod == YES) ? itemWontDo : [NSMutableDictionary dictionary];
                    newItemReminderDict = RemoveReminderNotification == YES ? itemReminderDictWithBeforeRemindersTakenOut : itemReminderDict;
                    newItemAdditionalReminders = RemoveReminderNotification == YES ? [NSMutableDictionary dictionary] : newItemAdditionalReminders;
                    
                    
                    
                    
                    
                    
                    NSMutableDictionary *notificationTextDict = [[[NotificationsObject alloc] init] GenerateNotificationMessages:itemType itemID:itemID itemOccurrenceID:itemOccurrenceID itemName:itemName itemCreatedBy:itemCreatedBy itemAssignedTo:itemAssignedTo itemAssignedToOriginal:itemAssignedTo itemCompletedDict:newItemCompletedDict itemReminderDict:newItemReminderDict itemAdditionalReminders:newItemAdditionalReminders itemListItemKeys:[NSMutableArray array] itemGracePeriod:itemGracePeriod itemTakeTurns:itemTakeTurns itemAlternateTurns:itemAlternateTurns itemTurnUserID:itemTurnUserID itemTimeOriginal:itemTimeOriginal homeMembersDict:homeMembersDict];
                    
                    NSString *frequency;
                    int removeSeconds = 0;
                    int removeGracePeriodSeconds = 0;
                    
                    
                    
                    
                    
                    
                    BOOL NotificationOfficiallyAdded = NO;
                    
                    for (NSString *key in [notificationTextDict allKeys]) {
                        
                        
                        
                        
                        
                        
                        frequency = [[[NotificationsObject alloc] init] GenerateFrequencyString:key secondsBetweenHour:secondsUntilFutureDueDate];
                        removeSeconds = [[[NotificationsObject alloc] init] GenerateRemoveSeconds:key secondsUntilTaskIsDue:secondsUntilFutureDueDate gracePeriodSecondsToSubtract:removeGracePeriodSeconds];
                        
                        BOOL FrequencyIsValid = (![frequency containsString:@"(null)"] && frequency != NULL && frequency != nil);
                        BOOL RemoveGracePeriodDueNowNotification = (ItemHasGracePeriod == YES && RemoveReminderNotification == YES && [frequency isEqualToString:@"Now"] == YES);
                        
                        
                        
                        
                        
                        
                        //Check if the "Before" reminders were removed, if so, remove due now notification and only leave the grace period notification
                        //"Before" reminders are removed if the currently logged in user is the crator of the task and is not assigned, they shouldn't be receiving "Before" reminders
                        
                        if (FrequencyIsValid == YES && RemoveGracePeriodDueNowNotification == NO) {
                            
                            
                            
                            
                            
                            
                            BOOL GracePeriodNotificationsHaveBeenReAdded = NO;
                            
                            if (GracePeriodSecondsHaveBeenRemoved == YES && [frequency isEqualToString:@"Grace Period"] == YES && [itemTimeOriginal isEqualToString:@"Any Time"] == NO) {
                                
                                GracePeriodNotificationsHaveBeenReAdded = YES;
                                
                                int gracePeriodSeconds = [[[GeneralObject alloc] init] GenerateSecondsFromDisplayTime:itemGracePeriod];
                                secondsUntilFutureDueDate += gracePeriodSeconds;
                                
                            }
                            
                            NSString *identifier = [NSString stringWithFormat:@"%@ - %d %@", itemID, i, frequency];
                            
                            BOOL IdentifierIsValid = (![identifier containsString:@"(null)"] && identifier != NULL && identifier != nil);
                            BOOL NonGracePeriodNotificationIsValid = (secondsUntilFutureDueDate - removeSeconds > 0);
                            
                            
                            
                            
                            
                            
                            if (IdentifierIsValid == YES && (NonGracePeriodNotificationIsValid)) {
                                
                                BOOL AddActions = TaskIsItemized == NO && TaskIsAList == NO;
                                
                                [[[NotificationsObject alloc] init] GenerateAndAddNotificationRequest:itemID itemOccurrenceID:itemOccurrenceID itemType:itemType notificationTextDict:notificationTextDict key:key i:i currentIterationDueDate:currentIterationDueDate secondsUntilDueDate:secondsUntilFutureDueDate removeSeconds:removeSeconds itemAssignedTo:itemAssignedTo notificationSettingsDict:notificationSettingsDict allItemTagsArrays:allItemTagsArrays notificationItemType:notificationItemType notificationType:notificationType AddActions:AddActions];
                                
                                
                                
                                
                                
                                
                                NotificationOfficiallyAdded = YES;
                                
                                if (GracePeriodNotificationsHaveBeenReAdded == YES && [itemTimeOriginal isEqualToString:@"Any Time"] == NO) {
                                    
                                    GracePeriodNotificationsHaveBeenReAdded = NO;
                                    
                                    int gracePeriodSeconds = [[[GeneralObject alloc] init] GenerateSecondsFromDisplayTime:itemGracePeriod];
                                    secondsUntilFutureDueDate -= gracePeriodSeconds;
                                    
                                }
                                
                                
                                
                                
                                
                                
                            }
                            
                            
                            
                            
                            
                            
                        }
                        
                        
                        
                        
                        
                        
                    }
                    
                    
                    
                    
                    
                    
                    if (NotificationOfficiallyAdded == YES) {
                        totalNotificationsAdded += 1;
                    }
                    
                    
                    
                    
                    
                    
                }
                
            }
            
        }
        
        
        
        
        
        
        NSDictionary *dataDict = @{
            
            @"SendLocalNotificationReminderNotifications" : @"",
            @"ItemType" : itemType ? itemType : @"",
            @"NotificationItemType" : notificationItemType ? notificationItemType : @"",
            @"NotificationType" : notificationType ? notificationType : @"",
            @"DictToUse" : dictToUse ? dictToUse : [NSMutableDictionary dictionary]
            
        };
        
        
        
        
        
        
        [[[NotificationsObject alloc] init] SendSilentNotificationToCustomArrayOfUsers:usersSendingNotificationsToArray dataDict:dataDict homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict topicDict:topicDict completionHandler:^(BOOL finished) {
            
//            [[UNUserNotificationCenter currentNotificationCenter] getPendingNotificationRequestsWithCompletionHandler:^(NSArray<UNNotificationRequest *> * _Nonnull requests) {
//                
//                for (UNNotificationRequest *notificationRequest in requests) {
//                    
//                    NSLog(@"SendLocalNotificationReminderNotifications requests:123 \n--\n--\n--%@\n--%@\n--%@\n--%@--\n--\n--", notificationRequest.content.title, notificationRequest.content.body, notificationRequest.identifier, notificationRequest.trigger);
//                    
//                }
//                
//            }];
            
            finishBlock(YES);
            
        }];
        
        
        
        
        
    }
    
}

-(void)SendLocalNotificationScheduledStartNotification:(NSMutableDictionary *)dictToUse itemType:(NSString *)itemType notificationTitle:(NSString *)notificationTitle notificationBody:(NSString *)notificationBody userIDArray:(NSMutableArray *)userIDArray allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays homeMembersArray:(NSMutableArray * _Nullable)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict topicDict:(NSMutableDictionary *)topicDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *itemID = dictToUse[@"ItemID"];
    NSString *itemOccurrenceID = dictToUse[@"ItemOccurrenceID"];
    NSString *itemScheduledStart = dictToUse[@"ItemScheduledStart"];
    NSString *itemTrash = dictToUse[@"ItemTrash"] ? dictToUse[@"ItemTrash"] : @"";
    NSString *itemDeleted = dictToUse[@"ItemDeleted"] ? dictToUse[@"ItemDeleted"] : @"";
    
    BOOL TaskIsScheduledStart = [[[BoolDataObject alloc] init] TaskIsScheduledStart:dictToUse itemType:itemType];
    BOOL TaskIsScheduledStartHasPassed = [[[BoolDataObject alloc] init] TaskIsScheduledStartHasPassed:dictToUse itemType:itemType];
    
    BOOL TaskIsDeleted = [itemDeleted isEqualToString:@"Yes"];
    BOOL TaskIsAnOccurrence = [itemOccurrenceID length] > 0 && [itemOccurrenceID isEqualToString:@"xxx"] == NO;
    BOOL TaskIsTrash = [itemTrash isEqualToString:@"Yes"];
    BOOL TaskIsPaused = NO;//[itemStatus isEqualToString:@"Yes"];
    BOOL TaskHasBeenMuted = [[[BoolDataObject alloc] init] TaskHasBeenMuted:dictToUse];
    
    if (TaskIsAnOccurrence == YES ||
        TaskIsTrash == YES ||
        TaskIsPaused == YES ||
        TaskHasBeenMuted == YES ||
        TaskIsDeleted == YES ||
        TaskIsScheduledStart == NO ||
        (TaskIsScheduledStart == YES && TaskIsScheduledStartHasPassed == YES)) {
        
        finishBlock(YES);
        
    } else {
        
        UNUserNotificationCenter *notificationCenter = [UNUserNotificationCenter currentNotificationCenter];
        UNMutableNotificationContent *notificationContent = [[UNMutableNotificationContent alloc] init];
        UNTimeIntervalNotificationTrigger *notificationTrigger;
        UNNotificationRequest *notificationRequest;
        
        NSString *identifier = [NSString stringWithFormat:@"%@ - Scheduled Start", itemID];
        identifier = identifier ? identifier : @"UnknownIdentifier";
        
        NSString *categoryIdentifier = itemID;
        categoryIdentifier = categoryIdentifier ? categoryIdentifier : @"UnknownCategoryIdentifier";
        
        NSString *title = notificationTitle;
        NSString *body = notificationBody;
        
        
        
        
        notificationContent.title = [NSString localizedUserNotificationStringForKey:title arguments:nil];
        notificationContent.body = [NSString localizedUserNotificationStringForKey:body arguments:nil];
        notificationContent.sound = [UNNotificationSound defaultSound];
        notificationContent.categoryIdentifier = categoryIdentifier;
        
        
        
        
        NSDictionary *dataDict = [[[NotificationsObject alloc] init] GenerateNotificationDataDictTask:itemID itemOccurrenceID:itemOccurrenceID itemType:itemType allItemTagsArrays:allItemTagsArrays homeMembersArray:homeMembersArray];
        
        notificationContent.userInfo = dataDict;
        
        
        
        
        float reminderAmount = 0;
        
        NSArray *arr = [itemScheduledStart containsString:@" "] ? [itemScheduledStart componentsSeparatedByString:@" "] : @[];
        NSString *frequencyAmountString = [arr count] > 0 ? arr[0] : @"";
        NSString *frequencyString = [arr count] > 1 ? arr[1] : @"";
        
        if ([frequencyString containsString:@"Minute"]) {
            
            reminderAmount = [frequencyAmountString intValue] * 60;
            
        } else if ([frequencyString containsString:@"Hour"]) {
            
            reminderAmount = [frequencyAmountString intValue] * 3600;
            
        } else if ([frequencyString containsString:@"Day"]) {
            
            reminderAmount = [frequencyAmountString intValue] * 86400;
            
        } else if ([frequencyString containsString:@"Week"]) {
            
            reminderAmount = [frequencyAmountString intValue] * 604800;
            
        }
        
        
        
        
        int timeInterval = reminderAmount;
        
        if (timeInterval < 1) {
            
            timeInterval = 1;
            
        }
        
        notificationTrigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:timeInterval repeats:NO];
        notificationRequest = [UNNotificationRequest requestWithIdentifier:identifier content:notificationContent trigger:notificationTrigger];
        
        
        
        
        //    NSDate *dueDateInDateForm = [[NSDate date] dateByAddingTimeInterval:timeInterval];
        //    NSString *dateFormat = @"EEEE"];
        //    NSString *weekDay = [dateFormatter stringFromDate:dueDateInDateForm];
        
        
        
        
        //    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
        //
        //    BOOL UserCanReceiveNotification = [[[BoolDataObject alloc] init] UserCanReceiveNotification:notificationSettingsDict userID:userID notificationItemType:notificationItemType notificationType:notificationType];
        //
        //    BOOL UserCanReceiveNotificationForDayOfTheWeek = [[[BoolDataObject alloc] init] UserCanReceiveNotification:notificationSettingsDict userID:userID notificationItemType:@"DaysOfTheWeek" notificationType:weekDay];
        
        //    if (UserCanReceiveNotification == YES && UserCanReceiveNotificationForDayOfTheWeek == YES) {
        
        [notificationCenter addNotificationRequest:notificationRequest withCompletionHandler:nil];
        
        //    }
        
        [[[NotificationsObject alloc] init] SendSilentNotificationToCustomArrayOfUsers:userIDArray dataDict:dataDict homeMembersDict:homeMembersDict notificationSettingsDict:nil topicDict:topicDict completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    }
    
}

-(void)SendLocalNotificationCustomReminderNotification_LocalOnly:(NSString *)reminderName itemType:(NSString *)itemType dictToUse:(NSMutableDictionary *)dictToUse homeMembersDict:(NSMutableDictionary *)homeMembersDict homeMembersArray:(NSMutableArray *)homeMembersArray allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *itemID = dictToUse[@"ItemID"] ? dictToUse[@"ItemID"] : @"";
    NSString *itemOccurrenceID = dictToUse[@"ItemOccurrenceID"] ? dictToUse[@"ItemOccurrenceID"] : @"";
    NSString *itemUniqueID = dictToUse[@"ItemUniqueID"] ? dictToUse[@"ItemUniqueID"] : @"";
    NSString *itemName = dictToUse[@"ItemName"] ? dictToUse[@"ItemName"] : @"";
    NSString *itemTrash = dictToUse[@"ItemTrash"] ? dictToUse[@"ItemTrash"] : @"";
    NSString *itemDeleted = dictToUse[@"ItemDeleted"] ? dictToUse[@"ItemDeleted"] : @"";
    
    BOOL TaskIsDeleted = [itemDeleted isEqualToString:@"Yes"];
    BOOL TaskIsTrash = [itemTrash isEqualToString:@"Yes"];
    BOOL TaskHasBeenMuted = [[[BoolDataObject alloc] init] TaskHasBeenMuted:dictToUse];
    
    if (TaskIsTrash == YES || TaskHasBeenMuted == YES || TaskIsDeleted == YES) {
        
        finishBlock(YES);
        
    } else {
        
        UNUserNotificationCenter *notificationCenter = [UNUserNotificationCenter currentNotificationCenter];
        UNMutableNotificationContent *notificationContent = [[UNMutableNotificationContent alloc] init];
        UNTimeIntervalNotificationTrigger *notificationTrigger;
        UNNotificationRequest *notificationRequest;
        
        NSString *identifier = [NSString stringWithFormat:@"%@ - Remind Me - %@", itemUniqueID, reminderName];
        identifier = identifier ? identifier : @"UnknownIdentifier";
        
        NSString *categoryIdentifier = itemID;
        categoryIdentifier = categoryIdentifier ? categoryIdentifier : @"UnknownCategoryIdentifier";
        
        NSString *title = itemName;
        NSString *body = [NSString stringWithFormat:@"Time to check on this %@", [itemType lowercaseString]];
        
        notificationContent.title = [NSString localizedUserNotificationStringForKey:title arguments:nil];
        notificationContent.body = [NSString localizedUserNotificationStringForKey:body arguments:nil];
        notificationContent.sound = [UNNotificationSound defaultSound];
        notificationContent.categoryIdentifier = categoryIdentifier;
        
        NSDictionary *dataDict = [[[NotificationsObject alloc] init] GenerateNotificationDataDictTask:itemID itemOccurrenceID:itemOccurrenceID itemType:itemType allItemTagsArrays:allItemTagsArrays homeMembersArray:homeMembersArray];
        
        notificationContent.userInfo = dataDict;
        
        int interval = 1;
        
        NSArray *reminderNameComponentsArray = [reminderName containsString:@" "] ? [reminderName componentsSeparatedByString:@" "] : @[];
        NSString *reminderNameAmount = [reminderNameComponentsArray count] > 0 ? reminderNameComponentsArray[0] : @"0";
        
        if ([reminderName containsString:@"Minute"]) {
            
            interval = [reminderNameAmount intValue] * 60;
            
        } else if ([reminderName containsString:@"Hour"]) {
            
            interval = [reminderNameAmount intValue] * 3600;
            
        } else if ([reminderName containsString:@"Day"]) {
            
            interval = [reminderNameAmount intValue] * 86400;
            
        } else if ([reminderName containsString:@"Week"]) {
            
            interval = [reminderNameAmount intValue] * 604800;
            
        }
        
        if (interval < 1) {
            interval = 1;
        }
        
        notificationTrigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:interval repeats:NO];
        notificationRequest = [UNNotificationRequest requestWithIdentifier:identifier content:notificationContent trigger:notificationTrigger];
        
        [notificationCenter addNotificationRequest:notificationRequest withCompletionHandler:^(NSError * _Nullable error) {
            
            finishBlock(YES);
            
        }];
        
    }
    
}

-(void)SendLocalNotificationSummaryNotifications_LocalOnly:(NSMutableDictionary *)notificationSettingsDict homeMembersDict:(NSMutableDictionary *)homeMembersDict
                                        dataDisplayDictNo1:(NSMutableDictionary *)dataDisplayDictNo1 dataDisplayDictNo2:(NSMutableDictionary *)dataDisplayDictNo2 dataDisplayDictNo3:(NSMutableDictionary *)dataDisplayDictNo3
                                  dataDisplayAmountDictNo1:(NSMutableDictionary *)dataDisplayAmountDictNo1 dataDisplayAmountDictNo2:(NSMutableDictionary *)dataDisplayAmountDictNo2 dataDisplayAmountDictNo3:(NSMutableDictionary *)dataDisplayAmountDictNo3
                                               itemDictNo1:(NSMutableDictionary *)itemDictNo1 itemDictNo2:(NSMutableDictionary *)itemDictNo2 itemDictNo3:(NSMutableDictionary *)itemDictNo3
                                               itemTypeNo1:(NSString *)itemTypeNo1 itemTypeNo2:(NSString *)itemTypeNo2 itemTypeNo3:(NSString *)itemTypeNo3 completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
    NSMutableDictionary *myNotificationSettingsDict = notificationSettingsDict && notificationSettingsDict[userID] ? notificationSettingsDict[userID] : notificationSettingsDict;
    
    BOOL ObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:myNotificationSettingsDict[@"ScheduledSummary"] classArr:@[[NSDictionary class], [NSMutableDictionary class]]];
    
    NSMutableDictionary *scheduledSummaryDict =
    notificationSettingsDict &&
    myNotificationSettingsDict &&
    myNotificationSettingsDict[@"ScheduledSummary"] &&
    ObjectIsKindOfClass == YES ?
    myNotificationSettingsDict[@"ScheduledSummary"] : [NSMutableDictionary dictionary];
    
    if (scheduledSummaryDict && scheduledSummaryDict[@"Summaries"]) {
        
        for (NSString *summaryNotificationName in [scheduledSummaryDict[@"Summaries"] allKeys]) {
            
            //NSMutableDictionary *summaryTaskTypes = scheduledSummaryDict && scheduledSummaryDict[@"TaskTypes"] ? scheduledSummaryDict[@"TaskTypes"] : [NSMutableDictionary dictionary];
            
            NSString *itemRepeats = scheduledSummaryDict && scheduledSummaryDict[@"Summaries"] && scheduledSummaryDict[@"Summaries"][summaryNotificationName] && scheduledSummaryDict[@"Summaries"][summaryNotificationName][@"Frequency"] ?
            scheduledSummaryDict[@"Summaries"][summaryNotificationName][@"Frequency"] : @"";
            
            NSString *itemDays = scheduledSummaryDict && scheduledSummaryDict[@"Summaries"] && scheduledSummaryDict[@"Summaries"][summaryNotificationName] && scheduledSummaryDict[@"Summaries"][summaryNotificationName][@"Day"] ?
            scheduledSummaryDict[@"Summaries"][summaryNotificationName][@"Day"] : @"";
            
            NSString *itemTime = scheduledSummaryDict && scheduledSummaryDict[@"Summaries"] && scheduledSummaryDict[@"Summaries"][summaryNotificationName] && scheduledSummaryDict[@"Summaries"][summaryNotificationName][@"Time"] ?
            scheduledSummaryDict[@"Summaries"][summaryNotificationName][@"Time"] : @"";
            
            
            
            
            NSString *dateFormat = @"MMMM dd, yyyy hh:mm a";
            NSString *dateStringCurrent = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:dateFormat returnAs:[NSString class]];
            
            NSMutableArray *allDueDatesArray = [[[NotificationsObject alloc] init] GenerateArrayOfRepeatingDueDates:itemRepeats itemRepeatIfCompletedEarly:@"No" itemCompleteAsNeeded:@"No" totalAmountOfFutureDates:10 maxAmountOfDueDatesToLoopThrough:1000 itemDatePosted:dateStringCurrent itemDueDate:@"" itemStartDate:@"Now" itemEndDate:@"Never" itemTime:itemTime itemDays:itemDays itemDueDatesSkipped:[NSMutableArray array] itemDateLastReset:@"" SkipStartDate:NO];
            
            
            
            
            int totalNotificationsAdded = 0;
            int maxAmountOfNotificationsToBeAdded = 2;
            
            for (int i=0; totalNotificationsAdded<maxAmountOfNotificationsToBeAdded && i<allDueDatesArray.count; i++) {
                
                NSString *newItemDueDate = allDueDatesArray[i];
                
                NSTimeInterval secondsUntilFutureDueDate = [[[GeneralObject alloc] init] GenerateTimeIntervalBetweenTwoDates:dateStringCurrent dateString2:newItemDueDate dateFormat:dateFormat];
                
                
                
                
                UNUserNotificationCenter *notificationCenter = [UNUserNotificationCenter currentNotificationCenter];
                UNMutableNotificationContent *notificationContent = [[UNMutableNotificationContent alloc] init];
                UNTimeIntervalNotificationTrigger *notificationTrigger;
                UNNotificationRequest *notificationRequest;
                
                int summaryNum = (int)[[scheduledSummaryDict[@"Summaries"] allKeys] indexOfObject:summaryNotificationName] + 1;
                
                NSString *identifier = [NSString stringWithFormat:@"Summary No. %d (%d)", summaryNum, i];
                identifier = identifier ? identifier : @"UnknownIdentifier";
                
                NSString *categoryIdentifier = [NSString stringWithFormat:@"Summary No. %d", summaryNum];
                categoryIdentifier = categoryIdentifier ? categoryIdentifier : @"UnknownCategoryIdentifier";
                
                
                
                
                NSString *homeName = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeName"];
                
                NSMutableDictionary *choreAmountDict = [NSMutableDictionary dictionary];
                NSMutableDictionary *expenseAmountDict = [NSMutableDictionary dictionary];
                NSMutableDictionary *listAmountDict = [NSMutableDictionary dictionary];
                
                if ([itemTypeNo1 isEqualToString:@"Chore"]) {
                    choreAmountDict = [dataDisplayAmountDictNo1 mutableCopy];
                } else if ([itemTypeNo2 isEqualToString:@"Chore"]) {
                    choreAmountDict = [dataDisplayAmountDictNo2 mutableCopy];
                } else if ([itemTypeNo3 isEqualToString:@"Chore"]) {
                    choreAmountDict = [dataDisplayAmountDictNo3 mutableCopy];
                }
                
                if ([itemTypeNo1 isEqualToString:@"Expense"]) {
                    expenseAmountDict = [dataDisplayAmountDictNo1 mutableCopy];
                } else if ([itemTypeNo2 isEqualToString:@"Expense"]) {
                    expenseAmountDict = [dataDisplayAmountDictNo2 mutableCopy];
                } else if ([itemTypeNo3 isEqualToString:@"Expense"]) {
                    expenseAmountDict = [dataDisplayAmountDictNo3 mutableCopy];
                }
                
                if ([itemTypeNo1 isEqualToString:@"List"]) {
                    listAmountDict = [dataDisplayAmountDictNo1 mutableCopy];
                } else if ([itemTypeNo2 isEqualToString:@"List"]) {
                    listAmountDict = [dataDisplayAmountDictNo2 mutableCopy];
                } else if ([itemTypeNo3 isEqualToString:@"List"]) {
                    listAmountDict = [dataDisplayAmountDictNo3 mutableCopy];
                }
                
                int choreAmount = [choreAmountDict[@"All"] intValue] - [choreAmountDict[@"Completed"] intValue];
                int expenseAmount = [expenseAmountDict[@"All"] intValue] - [expenseAmountDict[@"Completed"] intValue];
                int listAmount = [listAmountDict[@"All"] intValue] - [listAmountDict[@"Completed"] intValue];
                
                int choreAssignedToMeAmount = [choreAmountDict[@"Assigned To Me"] intValue];
                int expenseAssignedToMeAmount = [expenseAmountDict[@"Assigned To Me"] intValue];
                int listAssignedToMeAmount = [listAmountDict[@"Assigned To Me"] intValue];
                
                int choreCompletedAmount = [choreAmountDict[@"Completed"] intValue];
                int expenseCompletedAmount = [expenseAmountDict[@"Completed"] intValue];
                int listCompletedAmount = [listAmountDict[@"Completed"] intValue];
                
                NSString *homeTasksString = [NSString stringWithFormat:@"🏠 %@ has 4 chores, 2 expenses, and 2 lists that need to be completed.", homeName];
                
                if (choreAmount == 0 && expenseAmount == 0 && listAmount == 0) {
                    
                    homeTasksString = [NSString stringWithFormat:@"🏠 %@ has 0 chores, expenses, and lists that need to be completed.", homeName];
                    
                } else {
                    
                    if (choreAmount > 0) {
                        homeTasksString = [NSString stringWithFormat:@"🏠 %@ has %d chore%@", homeName, choreAmount, choreAmount == 1 ? @"" : @"s"];
                    }
                    
                    if (choreAmount > 0 && expenseAmount > 0) {
                        homeTasksString = [NSString stringWithFormat:@"%@, %d expense%@", homeTasksString, expenseAmount, expenseAmount == 1 ? @"" : @"s"];
                    } else if (choreAmount == 0 && expenseAmount > 0) {
                        homeTasksString = [NSString stringWithFormat:@"🏠 %@ has %d expense%@", homeName, expenseAmount, expenseAmount == 1 ? @"" : @"s"];
                    }
                    
                    if (choreAmount > 0 && expenseAmount > 0 && listAmount > 0) {
                        homeTasksString = [NSString stringWithFormat:@"%@, %d list%@", homeTasksString, listAmount, listAmount == 1 ? @"" : @"s"];
                    } else if (choreAmount == 0 && expenseAmount == 0 && listAmount > 0) {
                        homeTasksString = [NSString stringWithFormat:@"🏠 %@ has %d list%@", homeName, listAmount, listAmount == 1 ? @"" : @"s"];
                    } else if ((choreAmount > 0 || expenseAmount > 0) && listAmount > 0) {
                        homeTasksString = [NSString stringWithFormat:@"%@ and %d list%@", homeTasksString, listAmount, listAmount == 1 ? @"" : @"s"];
                    }
                    
                    homeTasksString = [NSString stringWithFormat:@"%@ that need to be completed.", homeTasksString];
                    
                }
                
                NSString *assignedToMeTasksString = [NSString stringWithFormat:@"👤 You have 4 chores, 2 expenses, and 2 lists that need to be completed."];
                
                if (choreAssignedToMeAmount == 0 && expenseAssignedToMeAmount == 0 && listAssignedToMeAmount == 0) {
                    
                    assignedToMeTasksString = [NSString stringWithFormat:@"👤 You have 0 chores, expenses, and lists assigned to you that need to be completed."];
                    
                } else {
                    
                    if (choreAssignedToMeAmount > 0) {
                        assignedToMeTasksString = [NSString stringWithFormat:@"👤 You have %d chore%@", choreAssignedToMeAmount, choreAssignedToMeAmount == 1 ? @"" : @"s"];
                    }
                    
                    if (choreAssignedToMeAmount > 0 && expenseAssignedToMeAmount > 0) {
                        assignedToMeTasksString = [NSString stringWithFormat:@"%@, %d expense%@", assignedToMeTasksString, expenseAssignedToMeAmount, expenseAssignedToMeAmount == 1 ? @"" : @"s"];
                    } else if (choreAssignedToMeAmount == 0 && expenseAssignedToMeAmount > 0) {
                        assignedToMeTasksString = [NSString stringWithFormat:@"👤 You have %d expense%@", expenseAssignedToMeAmount, expenseAssignedToMeAmount == 1 ? @"" : @"s"];
                    }
                    
                    if (choreAssignedToMeAmount > 0 && expenseAssignedToMeAmount > 0 && listAssignedToMeAmount > 0) {
                        assignedToMeTasksString = [NSString stringWithFormat:@"%@, %d list%@", assignedToMeTasksString, listAssignedToMeAmount, listAssignedToMeAmount == 1 ? @"" : @"s"];
                    } else if (choreAssignedToMeAmount == 0 && expenseAssignedToMeAmount == 0 && listAssignedToMeAmount > 0) {
                        assignedToMeTasksString = [NSString stringWithFormat:@"👤 You have %d list%@", listAssignedToMeAmount, listAssignedToMeAmount == 1 ? @"" : @"s"];
                    } else if ((choreAssignedToMeAmount > 0 || expenseAssignedToMeAmount > 0) && listAssignedToMeAmount > 0) {
                        assignedToMeTasksString = [NSString stringWithFormat:@"%@ and %d list%@", assignedToMeTasksString, listAssignedToMeAmount, listAssignedToMeAmount == 1 ? @"" : @"s"];
                    }
                    
                    assignedToMeTasksString = [NSString stringWithFormat:@"%@ assigned to you that need to be completed.", assignedToMeTasksString];
                    
                }
                
                NSString *completedTasksString = [NSString stringWithFormat:@"✅ You have completed 4 chores, 2 expenses, and 2 lists this week."];
                
                if (choreCompletedAmount == 0 && expenseCompletedAmount == 0 && listCompletedAmount == 0) {
                    
                    completedTasksString = [NSString stringWithFormat:@"✅ You have completed 0 chores, expenses, and lists this week."];
                    
                } else {
                    
                    if (choreCompletedAmount > 0) {
                        completedTasksString = [NSString stringWithFormat:@"✅ You have completed %d chore%@", choreAssignedToMeAmount, choreAssignedToMeAmount == 1 ? @"" : @"s"];
                    }
                    
                    if (choreCompletedAmount > 0 && expenseCompletedAmount > 0) {
                        completedTasksString = [NSString stringWithFormat:@"%@, %d expense%@", completedTasksString, expenseAssignedToMeAmount, expenseAssignedToMeAmount == 1 ? @"" : @"s"];
                    } else if (choreCompletedAmount == 0 && expenseCompletedAmount > 0) {
                        completedTasksString = [NSString stringWithFormat:@"✅ You have completed %d expense%@", expenseAssignedToMeAmount, expenseAssignedToMeAmount == 1 ? @"" : @"s"];
                    }
                    
                    if (choreCompletedAmount > 0 && expenseCompletedAmount > 0 && listCompletedAmount > 0) {
                        completedTasksString = [NSString stringWithFormat:@"%@, %d list%@", completedTasksString, listAssignedToMeAmount, listAssignedToMeAmount == 1 ? @"" : @"s"];
                    } else if (choreCompletedAmount == 0 && expenseCompletedAmount == 0 && listAmount > 0) {
                        completedTasksString = [NSString stringWithFormat:@"✅ You have completed %d list%@", listAssignedToMeAmount, listAssignedToMeAmount == 1 ? @"" : @"s"];
                    } else if ((choreCompletedAmount > 0 || expenseCompletedAmount > 0) && listCompletedAmount > 0) {
                        completedTasksString = [NSString stringWithFormat:@"%@ and %d list%@", completedTasksString, listAssignedToMeAmount, listAssignedToMeAmount == 1 ? @"" : @"s"];
                    }
                    
                    completedTasksString = [NSString stringWithFormat:@"%@ this week.", completedTasksString];
                    
                }
                
                NSString *title = @"Your Overview";
                NSString *body = [NSString stringWithFormat:@"❗️ Hold Down To View Overview ❗️\n\n%@\n\n%@\n\n%@", homeTasksString, assignedToMeTasksString, completedTasksString];
                //
                //            NSString *dueDateString = @"";
                //            NSString *assignedToString = @"";
                //            NSString *colorString = @"";
                //            NSString *priorityString = @"";
                //            NSString *tagsString = @"";
                //
                //            for (NSString *key in [summaryTaskTypes allKeys]) {
                //
                //                dueDateString = [[[NotificationsObject alloc] init] GenerateSummaryNotificationDueDateBody:dataDisplayAmountDictNo1 dataDisplayAmountDictNo2:dataDisplayAmountDictNo2 dataDisplayAmountDictNo3:dataDisplayAmountDictNo3 summaryTaskTypes:summaryTaskTypes key:key body:dueDateString];
                //
                //                assignedToString = [[[NotificationsObject alloc] init] GenerateSummaryNotificationAssignedToBody:summaryTaskTypes itemDictNo1:itemDictNo1 itemDictNo2:itemDictNo2 itemDictNo3:itemDictNo3 homeMembersDict:homeMembersDict key:key body:assignedToString];
                //
                //                colorString = [[[NotificationsObject alloc] init] GenerateSummaryNotificationColorBody:summaryTaskTypes dataDisplayDictNo1:dataDisplayDictNo1 dataDisplayDictNo2:dataDisplayDictNo2 dataDisplayDictNo3:dataDisplayDictNo3 key:key body:colorString];
                //
                //                priorityString = [[[NotificationsObject alloc] init] GenerateSummaryNotificationPriorityBody:summaryTaskTypes dataDisplayDictNo1:dataDisplayDictNo1 dataDisplayDictNo2:dataDisplayDictNo2 dataDisplayDictNo3:dataDisplayDictNo3 key:key body:priorityString];
                //
                //                tagsString = [[[NotificationsObject alloc] init] GenerateSummaryNotificationTagsBody:summaryTaskTypes dataDisplayDictNo1:dataDisplayDictNo1 dataDisplayDictNo2:dataDisplayDictNo2 dataDisplayDictNo3:dataDisplayDictNo3 key:key body:tagsString];
                //
                //            }
                //
                //            if (dueDateString.length > 0) {
                //                dueDateString = [NSString stringWithFormat:@"\n\n📅 Due Dates:\n\n%@", dueDateString];
                //            }
                //
                //            if (assignedToString.length > 0) {
                //                assignedToString = [NSString stringWithFormat:@"\n\n👤 Assigned To:\n\n%@", assignedToString];
                //            }
                //
                //            if (colorString.length > 0) {
                //                colorString = [NSString stringWithFormat:@"\n\n🌈 Color:\n\n%@", colorString];
                //            }
                //
                //            if (priorityString.length > 0) {
                //                priorityString = [NSString stringWithFormat:@"\n\n❗️ Priority:\n\n%@", priorityString];
                //            }
                //
                //            if (tagsString.length > 0) {
                //                tagsString = [NSString stringWithFormat:@"\n\n🏷 Tags:\n\n%@", tagsString];
                //            }
                //
                //            NSString *body = [NSString stringWithFormat:@"%@%@%@%@%@%@", firstLineString, dueDateString, assignedToString, colorString, priorityString, tagsString];
                
                NSLog(@"For Some Reason This Makes It Work %@", body);
                
                
                
                
                UNNotificationAction *turnOffAction = [UNNotificationAction actionWithIdentifier:@"Turn Off" title:@"Turn Off" options:0];
                UNNotificationCategory *category = [UNNotificationCategory categoryWithIdentifier:categoryIdentifier actions:@[turnOffAction] intentIdentifiers:@[@"Turn Off"] options:UNNotificationCategoryOptionCustomDismissAction];
                [notificationCenter setNotificationCategories:[NSSet setWithObject:category]];
                
                
                
                
                notificationContent.title = [NSString localizedUserNotificationStringForKey:title arguments:nil];
                notificationContent.body = [NSString localizedUserNotificationStringForKey:body arguments:nil];
                notificationContent.sound = [UNNotificationSound defaultSound];
                notificationContent.categoryIdentifier = categoryIdentifier;
                
                
                
                
                NSMutableDictionary *dataDict = [[[NotificationsObject alloc] init] GenerateNotificationDataDictSummaryNotification:dataDisplayDictNo1 notificationSettings:myNotificationSettingsDict];
                notificationContent.userInfo = dataDict;
                
                
                
                
                int timeInterval = secondsUntilFutureDueDate;
                
                if (timeInterval > 0) {
                    
                    notificationTrigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:timeInterval repeats:NO];
                    notificationRequest = [UNNotificationRequest requestWithIdentifier:identifier content:notificationContent trigger:notificationTrigger];
                    
                    [notificationCenter addNotificationRequest:notificationRequest withCompletionHandler:nil];
                    
                    totalNotificationsAdded += 1;
                    
                }
                
            }
            
        }
        
    }
    
    finishBlock(YES);
    
}

#pragma mark

-(void)SendLocalNotificationUnusedPremiumAccountsReminderNotification_LocalOnly:(void (^)(BOOL finished))finishBlock {
    
    UNUserNotificationCenter *notificationCenter = [UNUserNotificationCenter currentNotificationCenter];
    UNMutableNotificationContent *notificationContent = [[UNMutableNotificationContent alloc] init];
    UNTimeIntervalNotificationTrigger *notificationTrigger;
    UNNotificationRequest *notificationRequest;
    
    NSString *identifier = [NSString stringWithFormat:@"Unused Premium Accounts"];
    
    NSString *categoryIdentifier = @"Unused Premium Accounts";
    
    NSString *title = @"⭐️ Unused Premium Accounts ⭐️";
    NSString *body = @"Head to the \"Premium Settings\" page to give your home members WeDivvy Premium.";
    
    notificationContent.title = [NSString localizedUserNotificationStringForKey:title arguments:nil];
    notificationContent.body = [NSString localizedUserNotificationStringForKey:body arguments:nil];
    notificationContent.sound = [UNNotificationSound defaultSound];
    notificationContent.categoryIdentifier = categoryIdentifier;
    
    int interval = 86400*7;
    
    notificationTrigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:interval repeats:NO];
    notificationRequest = [UNNotificationRequest requestWithIdentifier:identifier content:notificationContent trigger:notificationTrigger];
    
    [notificationCenter addNotificationRequest:notificationRequest withCompletionHandler:^(NSError * _Nullable error) {
        
        [[[NotificationsObject alloc] init] SaveMyLocalNotifications:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    }];
    
}

-(void)SendLocalNotificationHomeMemberNoInvitationNotification_LocalOnly:(NSMutableDictionary *)homeKeysDict homeMembersUnclaimedDict:(NSMutableDictionary *)homeMembersUnclaimedDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSDictionary *noInvitationDict = [[[NotificationsObject alloc] init] GenerateNoInvitationSentDict:homeKeysDict homeMembersUnclaimedDict:homeMembersUnclaimedDict];
    NSString *noInvitationTitle = noInvitationDict[@"Title"] ? noInvitationDict[@"Title"] : @"";
    NSString *noInvitationBody = noInvitationDict[@"Body"] ? noInvitationDict[@"Body"] : @"";
    NSTimeInterval noInvitationSeconds = noInvitationDict[@"Seconds"] ? [noInvitationDict[@"Seconds"] floatValue] : 0;
    
    //Generate Notification Time Based On Most Recent User Created / Invitation Sent
    
    UNUserNotificationCenter *notificationCenter = [UNUserNotificationCenter currentNotificationCenter];
    UNMutableNotificationContent *notificationContent = [[UNMutableNotificationContent alloc] init];
    UNTimeIntervalNotificationTrigger *notificationTrigger;
    UNNotificationRequest *notificationRequest;
    
    NSString *identifier = [NSString stringWithFormat:@"NoInvitationSentToHomeMembers"];
    
    NSString *categoryIdentifier = @"NoInvitationSentToHomeMembers";
    
    NSString *title = noInvitationTitle;
    NSString *body = noInvitationBody;
    
    notificationContent.title = [NSString localizedUserNotificationStringForKey:title arguments:nil];
    notificationContent.body = [NSString localizedUserNotificationStringForKey:body arguments:nil];
    notificationContent.sound = [UNNotificationSound defaultSound];
    notificationContent.categoryIdentifier = categoryIdentifier;
    
    int interval = noInvitationSeconds;
    
    if ([noInvitationBody length] > 0 && interval > 0) {
        
        notificationTrigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:interval repeats:NO];
        notificationRequest = [UNNotificationRequest requestWithIdentifier:identifier content:notificationContent trigger:notificationTrigger];
        
        [notificationCenter addNotificationRequest:notificationRequest withCompletionHandler:^(NSError * _Nullable error) {
            
            finishBlock(YES);
            
        }];
        
    } else {
        
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        
        NSArray *notificationIdentifierArray = @[identifier];
        NSMutableArray *arr = [NSMutableArray array];
        
        for (NSString *notificationIdentifier in notificationIdentifierArray) {
            
            [arr addObject:notificationIdentifier];
            
        }
        
        [center removePendingNotificationRequestsWithIdentifiers:arr];
        
        finishBlock(YES);
        
    }
    
}

-(void)SendLocalNotificationHomeMemberHasNotJoinedNotification_LocalOnly:(NSMutableDictionary *)homeKeysDict homeMembersUnclaimedDict:(NSMutableDictionary *)homeMembersUnclaimedDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSDictionary *hasNoJoinedDict = [[[NotificationsObject alloc] init] GenerateHasNotJoinedDict:homeKeysDict homeMembersUnclaimedDict:homeMembersUnclaimedDict];
    NSString *hasNotJoinedTitle = hasNoJoinedDict[@"Title"] ? hasNoJoinedDict[@"Title"] : @"";
    NSString *hasNotJoinedBody = hasNoJoinedDict[@"Body"] ? hasNoJoinedDict[@"Body"] : @"";
    NSTimeInterval hasNotJoinedSeconds = hasNoJoinedDict[@"Seconds"] ? [hasNoJoinedDict[@"Seconds"] floatValue] : 0;
    
    //Generate Notification Time Based On Most Recent User Created / Invitation Sent
    
    UNUserNotificationCenter *notificationCenter = [UNUserNotificationCenter currentNotificationCenter];
    UNMutableNotificationContent *notificationContent = [[UNMutableNotificationContent alloc] init];
    UNTimeIntervalNotificationTrigger *notificationTrigger;
    UNNotificationRequest *notificationRequest;
    
    NSString *identifier = [NSString stringWithFormat:@"InvitedHomeMembersHaveNotJoined"];
    
    NSString *categoryIdentifier = @"InvitedHomeMembersHaveNotJoined";
    
    NSString *title = hasNotJoinedTitle;
    NSString *body = hasNotJoinedBody;
    
    notificationContent.title = [NSString localizedUserNotificationStringForKey:title arguments:nil];
    notificationContent.body = [NSString localizedUserNotificationStringForKey:body arguments:nil];
    notificationContent.sound = [UNNotificationSound defaultSound];
    notificationContent.categoryIdentifier = categoryIdentifier;
    
    int interval = hasNotJoinedSeconds;
    
    if ([hasNotJoinedBody length] > 0 && interval > 0) {
        
        notificationTrigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:interval repeats:NO];
        notificationRequest = [UNNotificationRequest requestWithIdentifier:identifier content:notificationContent trigger:notificationTrigger];
        
        [notificationCenter addNotificationRequest:notificationRequest withCompletionHandler:^(NSError * _Nullable error) {
            
            finishBlock(YES);
            
        }];
        
    } else {
        
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        
        NSArray *notificationIdentifierArray = @[identifier];
        NSMutableArray *arr = [NSMutableArray array];
        
        for (NSString *notificationIdentifier in notificationIdentifierArray) {
            
            [arr addObject:notificationIdentifier];
            
        }
        
        [center removePendingNotificationRequestsWithIdentifiers:arr];
        
        finishBlock(YES);
        
    }
    
}

-(void)SendLocalNotificationPurchasePremiumNotification_LocalOnly:(NSMutableDictionary *)homeMembersDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    UNUserNotificationCenter *notificationCenter = [UNUserNotificationCenter currentNotificationCenter];
    UNMutableNotificationContent *notificationContent = [[UNMutableNotificationContent alloc] init];
    UNTimeIntervalNotificationTrigger *notificationTrigger;
    UNNotificationRequest *notificationRequest;
    
    NSString *identifier = [NSString stringWithFormat:@"PurchasePremium"];
    
    NSString *categoryIdentifier = @"PurchasePremium";
    
    NSString *title = @"WeDivvy - Limited Time Offer! ⭐️";
    NSString *body = @"Enjoy a better experience with WeDivvy Premium! Click here for a 50% discount. 💰";
    
    notificationContent.title = [NSString localizedUserNotificationStringForKey:title arguments:nil];
    notificationContent.body = [NSString localizedUserNotificationStringForKey:body arguments:nil];
    notificationContent.sound = [UNNotificationSound defaultSound];
    notificationContent.categoryIdentifier = categoryIdentifier;
    
    notificationContent.userInfo = @{@"PurchasePremium" : @"", @"DefaultPlan" : @""};
    
    int interval = 86400*5;
    
    BOOL PremiumSubscriptionIsOn = [[[BoolDataObject alloc] init] PremiumSubscriptionIsOn];
    BOOL SideBarPopupAlreadyClicked = [[NSUserDefaults standardUserDefaults] objectForKey:@"SideBarPopupClicked"];
    NSMutableArray *notificationIdentifierArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"MyNotifications"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"MyNotifications"] : [NSMutableArray array];
    
    if ([notificationIdentifierArray containsObject:identifier] == NO && PremiumSubscriptionIsOn == NO && SideBarPopupAlreadyClicked == YES) {
        
        notificationTrigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:interval repeats:NO];
        notificationRequest = [UNNotificationRequest requestWithIdentifier:identifier content:notificationContent trigger:notificationTrigger];
        
        [notificationCenter addNotificationRequest:notificationRequest withCompletionHandler:^(NSError * _Nullable error) {
            
            [[[NotificationsObject alloc] init] SaveMyLocalNotifications:^(BOOL finished) {
                
                finishBlock(YES);
                
            }];
            
        }];
        
    } else if ([notificationIdentifierArray containsObject:identifier] && PremiumSubscriptionIsOn == YES) {
        
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        
        NSArray *notificationIdentifierArray = @[identifier];
        NSMutableArray *arr = [NSMutableArray array];
        
        for (NSString *notificationIdentifier in notificationIdentifierArray) {
            
            [arr addObject:notificationIdentifier];
            
        }
        
        [center removePendingNotificationRequestsWithIdentifiers:arr];
        
        [[[NotificationsObject alloc] init] SaveMyLocalNotifications:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    }
    
}

-(void)SendLocalNotificationUpgradePremiumNotification_LocalOnly:(NSMutableDictionary *)homeMembersDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *defaultPlan = @"";
    
    if (homeMembersDict && homeMembersDict[@"UserID"]) {
        
        if ([(NSArray *)homeMembersDict[@"UserID"] count] > 1 && [(NSArray *)homeMembersDict[@"UserID"] count] < 4) {
            defaultPlan = @"Housemate";
        } else if ([(NSArray *)homeMembersDict[@"UserID"] count] > 3) {
            defaultPlan = @"Family";
        }
        
    }
    
    UNUserNotificationCenter *notificationCenter = [UNUserNotificationCenter currentNotificationCenter];
    UNMutableNotificationContent *notificationContent = [[UNMutableNotificationContent alloc] init];
    UNTimeIntervalNotificationTrigger *notificationTrigger;
    UNNotificationRequest *notificationRequest;
    
    NSString *identifier = [NSString stringWithFormat:@"UpgradePremium"];
    
    NSString *categoryIdentifier = @"UpgradePremium";
    
    NSString *title = @"WeDivvy - Limited Time Offer! ⭐️";
    NSString *body = [NSString stringWithFormat:@"Share WeDivvy Premium with your home! Click here for 50%% off the %@ Plan. 💰", defaultPlan];
    
    notificationContent.title = [NSString localizedUserNotificationStringForKey:title arguments:nil];
    notificationContent.body = [NSString localizedUserNotificationStringForKey:body arguments:nil];
    notificationContent.sound = [UNNotificationSound defaultSound];
    notificationContent.categoryIdentifier = categoryIdentifier;
    
    notificationContent.userInfo = @{@"UpgradePremium" : @"", @"DefaultPlan" : defaultPlan};
    
    int interval = 86400*5;
    
    BOOL PremiumUserHasIndividualPlan = [[[BoolDataObject alloc] init] PremiumUserHasIndividualPlanAndHasMoreThanOneHomeMember:homeMembersDict purchasingUserID:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
    BOOL SideBarPopupAlreadyClicked = [[NSUserDefaults standardUserDefaults] objectForKey:@"SideBarPopupClicked"];
    NSMutableArray *notificationIdentifierArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"MyNotifications"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"MyNotifications"] : [NSMutableArray array];
    
    if ([notificationIdentifierArray containsObject:identifier] == NO && PremiumUserHasIndividualPlan == YES && SideBarPopupAlreadyClicked == YES) {
        
        notificationTrigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:interval repeats:NO];
        notificationRequest = [UNNotificationRequest requestWithIdentifier:identifier content:notificationContent trigger:notificationTrigger];
        
        [notificationCenter addNotificationRequest:notificationRequest withCompletionHandler:^(NSError * _Nullable error) {
            
            [[[NotificationsObject alloc] init] SaveMyLocalNotifications:^(BOOL finished) {
                
                finishBlock(YES);
                
            }];
            
        }];
        
    } else if ([notificationIdentifierArray containsObject:identifier] && PremiumUserHasIndividualPlan == NO) {
        
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        
        NSArray *notificationIdentifierArray = @[identifier];
        NSMutableArray *arr = [NSMutableArray array];
        
        for (NSString *notificationIdentifier in notificationIdentifierArray) {
            
            [arr addObject:notificationIdentifier];
            
        }
        
        [center removePendingNotificationRequestsWithIdentifiers:arr];
        
        [[[NotificationsObject alloc] init] SaveMyLocalNotifications:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    }
    
}

#pragma mark

-(void)RemoveLocalNotificationReminderNotifications:(NSString *)itemID itemOccurrenceID:(NSString *)itemOccurrenceID itemUniqueID:(NSString *)itemUniqueID userIDArray:(NSMutableArray *)userIDArray itemCreatedBy:(NSString *)itemCreatedBy homeMembersDict:(NSMutableDictionary *)homeMembersDict topicDict:(NSMutableDictionary *)topicDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    
    NSMutableArray *notificationIdentifierArray = [NSMutableArray array];
    
    BOOL TaskIsAnOccurrence = [itemOccurrenceID length] > 0 && [itemOccurrenceID isEqualToString:@"xxx"] == NO;
    
    if (TaskIsAnOccurrence == YES) {
        
        finishBlock(YES);
        
        
        
    } else {
        
        
        
        [[UNUserNotificationCenter currentNotificationCenter] getPendingNotificationRequestsWithCompletionHandler:^(NSArray<UNNotificationRequest *> *requests){
            
            for (UNNotificationRequest *notificationRequest in requests) {
                
                if ([notificationRequest.identifier containsString:itemID]) {
                    
                    [notificationIdentifierArray addObject:notificationRequest.identifier];
                    
                }
                
            }
           
            [center removePendingNotificationRequestsWithIdentifiers:notificationIdentifierArray];
            
            NSDictionary *dataDict = @{
                @"RemoveLocalNotificationReminderNotifications" : @"",
                @"ItemID" : itemID ? itemID : @"",
                @"ItemOccurrenceID" : itemOccurrenceID ? itemOccurrenceID : @"",
                @"ItemUniqueID" : itemUniqueID ? itemUniqueID : @"",
                @"ItemCreatedBy" : itemCreatedBy ? itemCreatedBy : @""
            };
            
            
            
            [[[NotificationsObject alloc] init] SendSilentNotificationToCustomArrayOfUsers:userIDArray dataDict:dataDict homeMembersDict:homeMembersDict notificationSettingsDict:nil topicDict:topicDict completionHandler:^(BOOL finished) {
                
                //                [[UNUserNotificationCenter currentNotificationCenter] getPendingNotificationRequestsWithCompletionHandler:^(NSArray<UNNotificationRequest *> * _Nonnull requests) {
                //
                //                    for (UNNotificationRequest *notificationRequest in requests) {
                //
                //                        NSLog(@"RemoveLocalNotificationReminderNotifications requests:123 \n--\n--\n--%@\n--%@\n--%@\n--%@--\n--\n--", notificationRequest.content.title, notificationRequest.content.body, notificationRequest.identifier, notificationRequest.trigger);
                //
                //                    }
                //
                //                }];
                
                finishBlock(YES);
                
            }];
            
        }];
        
    }
    
}

-(void)RemoveLocalNotificationScheduledStartNotifications:(NSString *)itemID itemOccurrenceID:(NSString *)itemOccurrenceID itemUniqueID:(NSString *)itemUniqueID userIDArray:(NSMutableArray *)userIDArray homeMembersDict:(NSMutableDictionary *)homeMembersDict topicDict:(NSMutableDictionary *)topicDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    
    BOOL TaskIsAnOccurrence = [itemOccurrenceID length] > 0 && [itemOccurrenceID isEqualToString:@"xxx"] == NO;
    
    if (TaskIsAnOccurrence == YES) {
        
        finishBlock(YES);
        
    } else {
        
        
        
        NSMutableArray *arr = [NSMutableArray array];
        
        [arr addObject:[NSString stringWithFormat:@"%@ - Scheduled Start", itemUniqueID]];
        
        [center removePendingNotificationRequestsWithIdentifiers:arr];
        
        NSDictionary *dataDict = @{
            @"RemoveLocalNotificationScheduledStartNotifications" : @"",
            @"ItemID" : itemID ? itemID : @"",
            @"ItemOccurrenceID" : itemOccurrenceID ? itemOccurrenceID : @"",
            @"ItemUniqueID" : itemUniqueID ? itemUniqueID : @"",
        };
        
        
        
        [[[NotificationsObject alloc] init] SendSilentNotificationToCustomArrayOfUsers:userIDArray dataDict:dataDict homeMembersDict:homeMembersDict notificationSettingsDict:nil topicDict:topicDict completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    }
    
}

-(void)RemoveLocalNotificationSummaryNotifications_LocalOnly:(void (^)(BOOL finished))finishBlock {
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    
    NSArray *notificationIdentifierArray = @[@"Summary No. 1", @"Summary No. 1 (0)", @"Summary No. 1 (1)", @"Summary No. 1 (2)", @"Summary No. 1 (3)", @"Summary No. 1 (4)",
                                             @"Summary No. 2", @"Summary No. 2 (0)", @"Summary No. 2 (1)", @"Summary No. 2 (2)", @"Summary No. 2 (3)", @"Summary No. 2 (4)"];
    NSMutableArray *arr = [NSMutableArray array];
    
    for (NSString *notificationIdentifier in notificationIdentifierArray) {
        
        [arr addObject:notificationIdentifier];
        
    }
    
    [center removePendingNotificationRequestsWithIdentifiers:arr];
    
    finishBlock(YES);
    
}

-(void)RemoveLocalNotificationCustomRemindMeNotification_LocalOnly:(NSString *)itemUniqueID completionHandler:(void (^)(BOOL finished))finishBlock {
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    
    NSMutableArray *notificationIdentifierArray = [NSMutableArray array];
    
    [[UNUserNotificationCenter currentNotificationCenter] getPendingNotificationRequestsWithCompletionHandler:^(NSArray<UNNotificationRequest *> * _Nonnull requests) {
        
        for (UNNotificationRequest *notificationRequest in requests) {
            
            if ([notificationRequest.identifier containsString:[NSString stringWithFormat:@"%@ - Remind Me - ", itemUniqueID]]) {
                
                [notificationIdentifierArray addObject:notificationRequest.identifier];
                break;
                
            }
            
            //            NSLog(@"RemoveLocalNotificationCustomRemindMeNotifications requests:123 \n--\n--\n--%@\n--%@\n--%@\n--%@--\n--\n--", notificationRequest.content.title, notificationRequest.content.body, notificationRequest.identifier, notificationRequest.trigger);
            
        }
        
        [center removePendingNotificationRequestsWithIdentifiers:notificationIdentifierArray];
        
        finishBlock(YES);
        
    }];
    
}

-(void)RemoveLocalNotificationUnusedPremiumAccountsNotifications_LocalOnly:(void (^)(BOOL finished))finishBlock {
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    
    NSMutableArray *notificationIdentifierArray = [NSMutableArray array];
    
    [[UNUserNotificationCenter currentNotificationCenter] getPendingNotificationRequestsWithCompletionHandler:^(NSArray<UNNotificationRequest *> * _Nonnull requests) {
        
        for (UNNotificationRequest *notificationRequest in requests) {
            
            if ([notificationRequest.identifier containsString:@"Unused Premium Accounts"]) {
                
                [notificationIdentifierArray addObject:notificationRequest.identifier];
                break;
                
            }
            
            //            NSLog(@"RemoveLocalNotificationUnusedPremiumAccountsNotifications requests:123 \n--\n--\n--%@\n--%@\n--%@\n--%@--\n--\n--", notificationRequest.content.title, notificationRequest.content.body, notificationRequest.identifier, notificationRequest.trigger);
            
        }
        
        [center removePendingNotificationRequestsWithIdentifiers:notificationIdentifierArray];
        
        finishBlock(YES);
        
    }];
    
}

#pragma mark

- (void)UserHasAcceptedNotifications:(void (^)(BOOL isActive))handler {
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    
    [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings *settings){
        
        if (settings.authorizationStatus == UNAuthorizationStatusAuthorized) {
            
            handler(YES);
            
        } else {
            
            handler(NO);
            
        }
        
    }];
    
}

#pragma mark - Reset Notifications

-(void)ResetLocalNotificationReminderNotification:(NSMutableDictionary *)dictToUse homeMembersDict:(NSMutableDictionary *)homeMembersDict userIDArray:(NSMutableArray *)userIDArray userIDToRemoveArray:(NSMutableArray *)userIDToRemoveArray notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays itemType:(NSString *)itemType notificationType:(NSString *)notificationType topicDict:(NSMutableDictionary *)topicDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *itemID = dictToUse[@"ItemID"] ? dictToUse[@"ItemID"] : @"";
    NSString *itemOccurrenceID = dictToUse[@"ItemOccurrenceID"] ? dictToUse[@"ItemOccurrenceID"] : @"";
    NSString *itemUniqueID = dictToUse[@"ItemUniqueID"] ? dictToUse[@"ItemUniqueID"] : @"";
    NSString *itemCreatedBy = dictToUse[@"ItemCreatedBy"] ? dictToUse[@"ItemCreatedBy"] : @"";
   
    [[[NotificationsObject alloc] init] RemoveLocalNotificationReminderNotifications:itemID itemOccurrenceID:itemOccurrenceID itemUniqueID:itemUniqueID userIDArray:userIDToRemoveArray itemCreatedBy:itemCreatedBy homeMembersDict:homeMembersDict topicDict:topicDict completionHandler:^(BOOL finished) {
       
        [[[NotificationsObject alloc] init] SendLocalNotificationReminderNotifications:dictToUse itemType:itemType userIDArray:userIDArray homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict allItemTagsArrays:allItemTagsArrays notificationItemType:itemType notificationType:notificationType topicDict:topicDict completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    }];
    
}

-(void)ResetLocalNotificationScheduledStartNotifications:(NSMutableDictionary *)dictToUse itemType:(NSString *)itemType userIDArray:(NSMutableArray *)userIDArray userIDToRemoveArray:(NSMutableArray *)userIDToRemoveArray allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays homeMembersArray:(NSMutableArray * _Nullable)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict topicDict:(NSMutableDictionary *)topicDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *itemID = dictToUse[@"ItemID"] ? dictToUse[@"ItemID"] : @"";
    NSString *itemOccurrenceID = dictToUse[@"ItemOccurrenceID"] ? dictToUse[@"ItemOccurrenceID"] : @"";
    NSString *itemUniqueID = dictToUse[@"ItemUniqueID"] ? dictToUse[@"ItemUniqueID"] : @"";
    NSString *itemName = dictToUse[@"ItemName"] ? dictToUse[@"ItemName"] : @"";
    NSMutableArray *itemAssignedTo = dictToUse[@"ItemAssignedTo"] ? dictToUse[@"ItemAssignedTo"] : [NSMutableArray array];
    
    [[[NotificationsObject alloc] init] RemoveLocalNotificationScheduledStartNotifications:itemID itemOccurrenceID:itemOccurrenceID itemUniqueID:itemUniqueID userIDArray:userIDToRemoveArray homeMembersDict:homeMembersDict topicDict:topicDict completionHandler:^(BOOL finished) {
        
        NSString *notificationTitle = [NSString stringWithFormat:@"\"%@\"", itemName];
        NSString *notificationBody = [[[NotificationsObject alloc] init] GeneratePushNotificationAddItemBody:YES EditItem:NO DeleteItem:NO NotificationItem:NO NobodyAssigned:NO userIDArray:itemAssignedTo];
        
        [[[NotificationsObject alloc] init] SendLocalNotificationScheduledStartNotification:dictToUse itemType:itemType notificationTitle:notificationTitle notificationBody:notificationBody userIDArray:userIDArray allItemTagsArrays:allItemTagsArrays homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict topicDict:topicDict completionHandler:^(BOOL finished) {
            
        }];
        
    }];
    
}

-(void)ResetLocalNotificationCustomReminderNotification_LocalOnly:(NSString *)reminderName itemType:(NSString *)itemType dictToUse:(NSMutableDictionary *)dictToUse homeMembersDict:(NSMutableDictionary *)homeMembersDict homeMembersArray:(NSMutableArray *)homeMembersArray allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *itemUniqueID = dictToUse[@"ItemUniqueID"] ? dictToUse[@"ItemUniqueID"] : @"";
    
    [[[NotificationsObject alloc] init] RemoveLocalNotificationCustomRemindMeNotification_LocalOnly:itemUniqueID completionHandler:^(BOOL finished) {
        
        [[[NotificationsObject alloc] init] SendLocalNotificationCustomReminderNotification_LocalOnly:reminderName itemType:itemType dictToUse:dictToUse homeMembersDict:homeMembersDict homeMembersArray:homeMembersArray allItemTagsArrays:allItemTagsArrays completionHandler:^(BOOL finished) {
            
            [[[NotificationsObject alloc] init] SaveMyLocalNotifications:^(BOOL finished) {
                
                finishBlock(YES);
                
            }];
            
        }];
        
    }];
    
}

-(void)ResetLocalSummaryNotifications_LocalOnly:(NSMutableDictionary *)notificationSettingsDict homeMembersDict:(NSMutableDictionary *)homeMembersDict
                             dataDisplayDictNo1:(NSMutableDictionary *)dataDisplayDictNo1 dataDisplayDictNo2:(NSMutableDictionary *)dataDisplayDictNo2 dataDisplayDictNo3:(NSMutableDictionary *)dataDisplayDictNo3
                       dataDisplayAmountDictNo1:(NSMutableDictionary *)dataDisplayAmountDictNo1 dataDisplayAmountDictNo2:(NSMutableDictionary *)dataDisplayAmountDictNo2 dataDisplayAmountDictNo3:(NSMutableDictionary *)dataDisplayAmountDictNo3
                                    itemDictNo1:(NSMutableDictionary *)itemDictNo1 itemDictNo2:(NSMutableDictionary *)itemDictNo2 itemDictNo3:(NSMutableDictionary *)itemDictNo3
                                    itemTypeNo1:(NSString *)itemTypeNo1 itemTypeNo2:(NSString *)itemTypeNo2 itemTypeNo3:(NSString *)itemTypeNo3
                              completionHandler:(void (^)(BOOL finished))finishBlock {
    
    [[[NotificationsObject alloc] init] RemoveLocalNotificationSummaryNotifications_LocalOnly:^(BOOL finished) {
        
        [[[NotificationsObject alloc] init] SendLocalNotificationSummaryNotifications_LocalOnly:notificationSettingsDict homeMembersDict:homeMembersDict
                                                                             dataDisplayDictNo1:dataDisplayDictNo1 dataDisplayDictNo2:dataDisplayDictNo2 dataDisplayDictNo3:dataDisplayDictNo3
                                                                       dataDisplayAmountDictNo1:dataDisplayAmountDictNo1 dataDisplayAmountDictNo2:dataDisplayAmountDictNo2 dataDisplayAmountDictNo3:dataDisplayAmountDictNo3
                                                                                    itemDictNo1:itemDictNo1 itemDictNo2:itemDictNo2 itemDictNo3:itemDictNo3
                                                                                    itemTypeNo1:itemTypeNo1 itemTypeNo2:itemTypeNo2 itemTypeNo3:itemTypeNo3
                                                                              completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    }];
    
}

#pragma mark - Silent Notifications

-(void)SendSilentNotificationToCustomArrayOfUsers:(NSMutableArray *)userIDArray dataDict:(NSDictionary *)dataDict homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary * _Nullable)notificationSettings topicDict:(NSMutableDictionary *)topicDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *itemID = dataDict[@"ItemID"] ? dataDict[@"ItemID"] : @"xxx";
    
    //Always YES For Local Notifications
    BOOL RemoveUsersNotInHome = YES;
    
    NSMutableArray *usersToSendNotificationTo = [[[NotificationsObject alloc] init] GenerateUsersToSendNotificationToArray:userIDArray homeMembersDict:homeMembersDict RemoveUsersNotInHome:RemoveUsersNotInHome];
    
    usersToSendNotificationTo = [[[NotificationsObject alloc] init] GenerateTopicIDAndUserIDsToSendNotificationTo:topicDict topicID:itemID userIDArray:usersToSendNotificationTo homeMembersDict:homeMembersDict RemoveUsersNotInHome:RemoveUsersNotInHome];
    
    if (usersToSendNotificationTo.count > 0) {
        
        notificationSettings = notificationSettings ? notificationSettings : [NSMutableDictionary dictionary];
        
        [[[NotificationsObject alloc] init] SendSilentNotificationGroup:usersToSendNotificationTo dataDict:dataDict notificationSettingsDict:notificationSettings completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    } else {
        
        finishBlock(YES);
        
    }
    
}

#pragma mark

-(void)SendSilentNotificationGroup:(NSMutableArray *)usersToSendNotificationTo dataDict:(NSDictionary *)dataDict notificationSettingsDict:(NSMutableDictionary * _Nullable)notificationSettings completionHandler:(void (^)(BOOL finished))finishBlock {
    
    if ([usersToSendNotificationTo count] == 0) {
        
        finishBlock(YES);
        
    } else {
        
        dispatch_group_t group = dispatch_group_create();
        
        NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
        [[[GeneralObject alloc] init] AddNotificationQueryToDefaults:usersToSendNotificationTo notificationTitle:@"" notificationBody:@"" setData:dataDict notificationSettings:notificationSettings notificationType:@"" queryID:queryID];
        
        for (NSString *usersIDLocal in usersToSendNotificationTo) {
            
            NSString *userID =
            [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ?
            [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
            
            if ([usersIDLocal isEqualToString:userID] == NO) {
                
                dispatch_group_enter(group);
                
                NSMutableArray *objectArr = [NSMutableArray array];
                
                NSDictionary *dictOfSplitDicts = [[[NotificationsObject alloc] init] GenerateSplitDictionaries:dataDict];
                NSString *fragmentID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
                
                for (NSString *key in [dictOfSplitDicts allKeys]) {
                    
                    dataDict = [[[NotificationsObject alloc] init] GenerateDataDictWithFragmentKey:dictOfSplitDicts key:key dataDict:dataDict fragmentID:fragmentID];
                    
                    //////////////
                    
                    NSString *topicSorted = usersIDLocal;
                    topicSorted = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:topicSorted arrayOfSymbols:@[@"-", @" ", @":"]];
                    
                    NSString *topic = [NSString stringWithFormat:@"/topics/%@", topicSorted];
                    
                    //////////////
                    
                    NSMutableDictionary *sdetails = [[NSMutableDictionary alloc] init];
                    [sdetails setObject:@YES forKey:@"content_available"];
                    [sdetails setObject:@"high" forKey:@"priority"];
                    [sdetails setObject:dataDict ? dataDict : [NSMutableDictionary dictionary] forKey:@"data"];
                    [sdetails setObject:topic ? topic : @"" forKey:@"to"];
                    [sdetails setObject:@"wedivvy-afe04" forKey:@"project_id"];
                    
                    //////////////
                    
                    NSString *post = [NSString stringWithFormat:@"%@", sdetails];
                    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
                    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
                    
                    //////////////
                    
                    NSError *err;
                    NSData *jsonData = [NSData data];
                    
                    //Invalid type in JSON write (_NSZeroData)
                    @try {
                        jsonData = [NSJSONSerialization dataWithJSONObject:sdetails options:NSJSONWritingPrettyPrinted error:&err];
                    }
                    @catch (NSException *exception) {
                        
                        jsonData = [NSData data];
                        
                    }
                    
                    //////////////
                    
                    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
                    [request setURL:[NSURL URLWithString:@"https://fcm.googleapis.com/fcm/send"]];
                    [request setHTTPMethod:@"POST"];
                    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
                    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
                    [request setValue:@"key=AAAAZ-QKMTc:APA91bHtF6911EYJHGJ3_s2TfwRDTPOK5yc3U95Wvl0MenCL0yA50aohcSx2DNbVFTVJLgN6qZ0UoD5nV3-XT3f4yyWMhyCg3wKTsujWauCldYBNYezZRrjfDhIO-7zMvy4jsgyrrFya" forHTTPHeaderField:@"Authorization"];
                    [request setHTTPBody:jsonData];
                    
                    notificationSettings = notificationSettings ? notificationSettings : [NSMutableDictionary dictionary];
                    
                    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                        
                        [[[GeneralObject alloc] init] EditNotificationQueryToDefaults:usersIDLocal queryID:queryID];
                        
                        NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
                        
                        NSLog(@"789Request reply Send Notification: %@ Error: %@", requestReply, error.description);
                        
                        if ([[[GeneralObject alloc] init] AddToObjectArrAndCheckIfQueryHasEnded:[[dictOfSplitDicts allKeys] mutableCopy] objectArr:objectArr]) {
                            
                            dispatch_group_leave(group);
                            
                        }
                        
                    }];
                    
                    [task resume];
                    
                }
                
            } else {
                
                [[[GeneralObject alloc] init] EditNotificationQueryToDefaults:usersIDLocal queryID:queryID];
                
            }
            
        }
        
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            
            finishBlock(YES);
            
        });
        
    }
    
}

#pragma mark

-(NSDictionary *)GenerateSplitDictionaries:(NSDictionary *)dataDict {
    
    //Convert Data Dict Info NSData
    
    NSError *err;
    NSData *jsonData = [NSData data];
    
    @try {
        jsonData = [NSJSONSerialization dataWithJSONObject:dataDict options:NSJSONWritingPrettyPrinted error:&err];
    }
    @catch (NSException *exception) {
        
        jsonData = [NSData data];
        
    }
    
    
    
    
    //Check If Data Dict Is Big Enough To Fragment
    
    NSUInteger dataSize = [jsonData length];
    
    if (dataSize > 4000) {
        
        
        
        
        NSMutableDictionary *dataDictFragementNo1 = [NSMutableDictionary dictionary];
        NSMutableDictionary *dataDictFragementNo2 = [NSMutableDictionary dictionary];
        
        if ([[dataDict allKeys] containsObject:@"SendLocalNotificationReminderNotifications"]) {
            
            
            
            //Find Total Number Of Data Dict Keys
            
            NSMutableDictionary *dictToUse = dataDict && dataDict[@"DictToUse"] ? [dataDict[@"DictToUse"] mutableCopy] : [NSMutableDictionary dictionary];
            
            float totalNumOfDataDictKeys = (float)[[dictToUse allKeys] count];
            
            for (int i=0 ; i<totalNumOfDataDictKeys ; i++) {
                
                
                
                //Split Each Half Of Data Dict Objects Into Different Fragment Dicts
                
                NSString *key =
                [[dictToUse allKeys] count] > i ?
                [dictToUse allKeys][i] : @"";
                
                BOOL LoopWithinFirstHalfOfKeys = (i < [[dictToUse allKeys] count]/2);
                
                if (LoopWithinFirstHalfOfKeys == YES) {
                    [dataDictFragementNo1 setObject:dictToUse[key] forKey:key];
                } else {
                    [dataDictFragementNo2 setObject:dictToUse[key] forKey:key];
                }
                
            }
            
            
            
            
            return @{@"Fragment1" : dataDictFragementNo1, @"Fragment2" : dataDictFragementNo2};
        }
        
    }
    
    return @{@"Fragment1" : dataDict};
}

-(NSDictionary *)GenerateDataDictWithFragmentKey:(NSDictionary *)dictOfFragmentData key:(NSString *)key dataDict:(NSDictionary *)dataDict fragmentID:(NSString *)fragmentID {
    
    //Convert Data Dict Info NSData
    
    NSError *err;
    NSData *jsonData = [NSData data];
    
    @try {
        jsonData = [NSJSONSerialization dataWithJSONObject:dataDict options:NSJSONWritingPrettyPrinted error:&err];
    }
    @catch (NSException *exception) {
        
        jsonData = [NSData data];
        
    }
    
    
    
    
    //Check If Data Dict Is Big Enough To Fragment
    
    NSUInteger dataSize = [jsonData length];
    
    if (dataSize > 4000) {
        
        
        
        
        NSDictionary *fragmentData = dictOfFragmentData[key];
        
        if ([[dataDict allKeys] containsObject:@"SendLocalNotificationReminderNotifications"]) {
            
            int currentFragmentNumber = (int)[[dictOfFragmentData allKeys] indexOfObject:key] + 1;
            int totalNumberOfFragments = (int)[[dictOfFragmentData allKeys] count];
            
            NSString *fragment = [NSString stringWithFormat:@"%@ - %d/%d", fragmentID, currentFragmentNumber, totalNumberOfFragments];
            
            NSMutableDictionary *tempDict = [dataDict mutableCopy];
            [tempDict setObject:fragmentData forKey:@"DictToUse"];
            [tempDict setObject:fragment forKey:@"Fragments"];
            dataDict = [tempDict mutableCopy];
            
        }
        
    }
    
    return dataDict;
}

#pragma mark - Push Notifications

-(void)SendPushNotificationToCreator:(NSString *)notificationTitle notificationBody:(NSString *)notificationBody badgeNumber:(NSInteger *)badgeNumber completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *usersIDLocal = @"2021-08-24 23:51:563280984";
    
    NSString *topicSorted = usersIDLocal;
    topicSorted = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:topicSorted arrayOfSymbols:@[@"-", @" ", @":"]];
    
    NSString *topic = [NSString stringWithFormat:@"/topics/%@", topicSorted];
    
    NSMutableDictionary *notifictionDetails = [[NSMutableDictionary alloc] init];
    [notifictionDetails setObject:notificationTitle ? notificationTitle : @"" forKey:@"title"];
    [notifictionDetails setObject:notificationBody ? notificationBody : @"" forKey:@"body"];
    [notifictionDetails setObject:@"default" forKey:@"sound"];
    //[notifictionDetails setObject:[NSString stringWithFormat:@"%ld", (long)badgeNumber] forKey:@"badge"];
    
    //////////////
    
    NSMutableDictionary *sdetails = [[NSMutableDictionary alloc] init];
    [sdetails setObject:notifictionDetails forKey:@"notification"];
    [sdetails setObject:@"high" forKey:@"priority"];
    [sdetails setObject:topic forKey:@"to"];
    [sdetails setObject:@"wedivvy-afe04" forKey:@"project_id"];
    
    //////////////
    
    NSString *post = [NSString stringWithFormat:@"%@", sdetails];
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    //////////////
    
    NSError *err;
    NSData *jsonData = [NSData data];
    
    //Invalid type in JSON write (_NSZeroData)
    @try {
        jsonData = [NSJSONSerialization dataWithJSONObject:sdetails options:NSJSONWritingPrettyPrinted error:&err];
    }
    @catch (NSException *exception) {
        
        jsonData = [NSData data];
        
    }
    
    //////////////
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"https://fcm.googleapis.com/fcm/send"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"key=AAAAZ-QKMTc:APA91bHtF6911EYJHGJ3_s2TfwRDTPOK5yc3U95Wvl0MenCL0yA50aohcSx2DNbVFTVJLgN6qZ0UoD5nV3-XT3f4yyWMhyCg3wKTsujWauCldYBNYezZRrjfDhIO-7zMvy4jsgyrrFya" forHTTPHeaderField:@"Authorization"];
    [request setHTTPBody:jsonData];
    
    
    //////////////
    
    
    //    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"MixPanelID"] isEqualToString:@"2021-08-24 23:47:407268729"] == NO &&
    //        [[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] isEqualToString:@"2021-08-24 23:51:563280984"] == NO &&
    //        [[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] isEqualToString:@"2021-06-05 15:07:572627942"] == NO) {
    //
    //        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    //        [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    //            NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    //            NSLog(@"Request reply Send Notification To Creator: %@", requestReply);
    
    finishBlock(YES);
    
    //        }] resume];
    //
    //    } else {
    //
    //        finishBlock(YES);
    //
    //    }
    
}

-(void)SendPushNotificationToArrayOfUsers_Items:(NSMutableArray *)userIDArray
                                      dictToUse:(NSMutableDictionary *)dictToUse
                                         homeID:(NSString *)homeID homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary * _Nullable)homeMembersDict
                       notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType
                                      topicDict:(NSMutableDictionary *)topicDict
                              allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays
                          pushNotificationTitle:(NSString *)pushNotificationTitle pushNotificationBody:(NSString *)pushNotificationBody
                              notificationTitle:(NSString *)notificationTitle notificationBody:(NSString *)notificationBody
                        SetDataHomeNotification:(BOOL)SetDataHomeNotification
                           RemoveUsersNotInHome:(BOOL)RemoveUsersNotInHome
                              completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *itemType = dictToUse[@"ItemType"] ? dictToUse[@"ItemType"] : [[[GeneralObject alloc] init] GenerateItemType];
    NSString *itemID = dictToUse[@"ItemID"] ? dictToUse[@"ItemID"] : @"";
    NSString *itemOccurrenceID = dictToUse[@"ItemOccurrenceID"] ? dictToUse[@"ItemOccurrenceID"] : @"";
    
    NSMutableArray *usersToSendNotificationTo = [[[NotificationsObject alloc] init] GenerateUsersToSendNotificationToArray:userIDArray homeMembersDict:homeMembersDict RemoveUsersNotInHome:RemoveUsersNotInHome];
    
    usersToSendNotificationTo = [[[NotificationsObject alloc] init] GenerateTopicIDAndUserIDsToSendNotificationTo:topicDict topicID:itemID userIDArray:usersToSendNotificationTo homeMembersDict:homeMembersDict RemoveUsersNotInHome:RemoveUsersNotInHome];
    
    __block int totalQueries = 2;
    __block int completedQueries = 0;
    
    if (usersToSendNotificationTo.count > 0) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSDictionary *dataDict = [[[NotificationsObject alloc] init] GenerateNotificationDataDictTask:itemID itemOccurrenceID:itemOccurrenceID itemType:itemType allItemTagsArrays:allItemTagsArrays homeMembersArray:homeMembersArray];
            
            [[[NotificationsObject alloc] init] SendPushNotificationGroup:usersToSendNotificationTo notificationTitle:pushNotificationTitle notificationBody:pushNotificationBody badgeNumber:(NSInteger *)1 dataDict:dataDict notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType completionHandler:^(BOOL finished) {
                
                if (totalQueries == (completedQueries+=1)) {
                    
                    finishBlock(YES);
                    
                }
                
            }];
            
        });
        
    } else {
        
        if (totalQueries == (completedQueries+=1)) {
            
            finishBlock(YES);
            
        }
        
    }
    
    if (SetDataHomeNotification == YES && notificationTitle.length > 0) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [[[SetDataObject alloc] init] SetDataNotification:homeID notificationTitle:notificationTitle notificationBody:notificationBody notificationItemID:itemID notificationItemOccurrenceID:itemOccurrenceID notificationItemCollection:[NSString stringWithFormat:@"%@s", itemType] homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType completionHandler:^(BOOL finished) {
                
                if (totalQueries == (completedQueries+=1)) {
                    
                    finishBlock(YES);
                    
                }
                
            }];
            
        });
        
    } else {
        
        if (totalQueries == (completedQueries+=1)) {
            
            finishBlock(YES);
            
        }
        
    }
    
}

-(void)SendPushNotificationToArrayOfUsers_Chats:(NSMutableArray *)userIDArray userID:(NSString *)userID
                                         homeID:(NSString *)homeID homeMembersDict:(NSMutableDictionary * _Nullable)homeMembersDict
                                         chatID:(NSString *)chatID chatName:(NSString *)chatName chatAssignedTo:(NSMutableArray *)chatAssignedTo
                                         itemID:(NSString *)itemID itemName:(NSString *)itemName itemCreatedBy:(NSString *)itemCreatedBy itemAssignedTo:(NSMutableArray *)itemAssignedTo
                       notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType
                                      topicDict:(NSMutableDictionary *)topicDict
                          pushNotificationTitle:(NSString *)pushNotificationTitle pushNotificationBody:(NSString *)pushNotificationBody
                              notificationTitle:(NSString *)notificationTitle notificationBody:(NSString *)notificationBody
                               viewingGroupChat:(BOOL)viewingGroupChat viewingComments:(BOOL)viewingComments viewingLiveSupport:(BOOL)viewingLiveSupport
                        SetDataHomeNotification:(BOOL)SetDataHomeNotification
                           RemoveUsersNotInHome:(BOOL)RemoveUsersNotInHome
                              completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSMutableArray *usersToSendNotificationTo = [[[NotificationsObject alloc] init] GenerateUsersToSendNotificationToArray:userIDArray homeMembersDict:homeMembersDict RemoveUsersNotInHome:RemoveUsersNotInHome];
    usersToSendNotificationTo = [[[NotificationsObject alloc] init] GenerateTopicIDAndUserIDsToSendNotificationTo:topicDict topicID:chatID userIDArray:usersToSendNotificationTo homeMembersDict:homeMembersDict RemoveUsersNotInHome:RemoveUsersNotInHome];
    
    __block int totalQueries = 2;
    __block int completedQueries = 0;
    
    if (usersToSendNotificationTo.count > 0) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSDictionary *dataDict = [[[NotificationsObject alloc] init] GenerateNotificationDataDictGroupChat:chatID chatName:chatName chatAssignedTo:chatAssignedTo userID:userID homeID:homeID homeMembersDict:homeMembersDict];
            
            if (viewingLiveSupport == YES) {
                dataDict = [[[NotificationsObject alloc] init] GenerateNotificationDataDictLiveSupport];
            } else if (viewingComments == YES) {
                dataDict = [[[NotificationsObject alloc] init] GenerateNotificationDataDictComments:homeID itemType:notificationItemType itemID:itemID itemName:itemName itemCreatedBy:itemCreatedBy itemAssignedTo:itemAssignedTo homeMembersDict:homeMembersDict];
            }
            
            [[[NotificationsObject alloc] init] SendPushNotificationGroup:usersToSendNotificationTo notificationTitle:pushNotificationTitle notificationBody:pushNotificationBody badgeNumber:(NSInteger *)1 dataDict:dataDict notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType completionHandler:^(BOOL finished) {
                
                if (totalQueries == (completedQueries+=1)) {
                    
                    finishBlock(YES);
                    
                }
                
            }];
            
        });
        
    } else {
        
        if (totalQueries == (completedQueries+=1)) {
            
            finishBlock(YES);
            
        }
        
    }
    
    if (SetDataHomeNotification == YES) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [[[SetDataObject alloc] init] SetDataNotification:homeID notificationTitle:notificationTitle notificationBody:notificationBody notificationItemID:@"" notificationItemOccurrenceID:@"" notificationItemCollection:@"GroupChats" homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType completionHandler:^(BOOL finished) {
                
                if (totalQueries == (completedQueries+=1)) {
                    
                    finishBlock(YES);
                    
                }
                
            }];
            
        });
        
    } else {
        
        if (totalQueries == (completedQueries+=1)) {
            
            finishBlock(YES);
            
        }
        
    }
    
}

-(void)SendPushNotificationToArrayOfUsers_Homes:(NSMutableArray *)userIDArray
      viewingHomeMembersFromHomesViewController:(BOOL)viewingHomeMembersFromHomesViewController homeID:(NSString *)homeID homeName:(NSString *)homeName homeMembersDict:(NSMutableDictionary * _Nullable)homeMembersDict
                       notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType
                                      topicDict:(NSMutableDictionary *)topicDict
                          pushNotificationTitle:(NSString *)pushNotificationTitle pushNotificationBody:(NSString *)pushNotificationBody
                              notificationTitle:(NSString *)notificationTitle notificationBody:(NSString *)notificationBody
                        SetDataHomeNotification:(BOOL)SetDataHomeNotification
                           RemoveUsersNotInHome:(BOOL)RemoveUsersNotInHome
                              completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSMutableArray *usersToSendNotificationTo = [[[NotificationsObject alloc] init] GenerateUsersToSendNotificationToArray:userIDArray homeMembersDict:homeMembersDict RemoveUsersNotInHome:RemoveUsersNotInHome];
    
    usersToSendNotificationTo = [[[NotificationsObject alloc] init] GenerateTopicIDAndUserIDsToSendNotificationTo:topicDict topicID:homeID userIDArray:usersToSendNotificationTo homeMembersDict:homeMembersDict RemoveUsersNotInHome:RemoveUsersNotInHome];
    
    __block int totalQueries = 2;
    __block int completedQueries = 0;
    
    if (usersToSendNotificationTo.count > 0) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSDictionary *dataDict = [[[NotificationsObject alloc] init] GenerateNotificationDataDictHome:homeID homeName:homeName viewingHomeMembersFromHomesViewController:viewingHomeMembersFromHomesViewController];
            
            [[[NotificationsObject alloc] init] SendPushNotificationGroup:usersToSendNotificationTo notificationTitle:pushNotificationTitle notificationBody:pushNotificationBody badgeNumber:(NSInteger *)1 dataDict:dataDict notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType completionHandler:^(BOOL finished) {
                
                if (totalQueries == (completedQueries+=1)) {
                    
                    finishBlock(YES);
                    
                }
                
            }];
            
        });
        
    } else {
        
        if (totalQueries == (completedQueries+=1)) {
            
            finishBlock(YES);
            
        }
        
    }
    
    if (SetDataHomeNotification == YES) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [[[SetDataObject alloc] init] SetDataNotification:homeID notificationTitle:notificationTitle notificationBody:notificationBody notificationItemID:@"" notificationItemOccurrenceID:@"" notificationItemCollection:@"" homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType completionHandler:^(BOOL finished) {
                
                if (totalQueries == (completedQueries+=1)) {
                    
                    finishBlock(YES);
                    
                }
                
            }];
            
        });
        
    } else {
        
        if (totalQueries == (completedQueries+=1)) {
            
            finishBlock(YES);
            
        }
        
    }
    
}

-(void)SendPushNotificationToArrayOfUsers_Other:(NSMutableArray *)userIDArray
                                       dataDict:(NSMutableDictionary *)dataDict
                                homeMembersDict:(NSMutableDictionary * _Nullable)homeMembersDict
                       notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType
                          pushNotificationTitle:(NSString *)pushNotificationTitle pushNotificationBody:(NSString *)pushNotificationBody
                           RemoveUsersNotInHome:(BOOL)RemoveUsersNotInHome
                              completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSMutableArray *usersToSendNotificationTo = [[[NotificationsObject alloc] init] GenerateUsersToSendNotificationToArray:userIDArray homeMembersDict:homeMembersDict RemoveUsersNotInHome:RemoveUsersNotInHome];
    usersToSendNotificationTo = [[[NotificationsObject alloc] init] GenerateTopicIDAndUserIDsToSendNotificationTo:[NSMutableDictionary dictionary] topicID:@"" userIDArray:usersToSendNotificationTo homeMembersDict:homeMembersDict RemoveUsersNotInHome:RemoveUsersNotInHome];
    
    [[[NotificationsObject alloc] init] SendPushNotificationGroup:usersToSendNotificationTo notificationTitle:pushNotificationTitle notificationBody:pushNotificationBody badgeNumber:(NSInteger *)1 dataDict:dataDict notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType completionHandler:^(BOOL finished) {
        
        finishBlock(YES);
        
    }];
    
}

-(NSString *)GeneratePushNotificationAddItemBody:(BOOL)AddItem EditItem:(BOOL)EditItem DeleteItem:(BOOL)DeleteItem NotificationItem:(BOOL)NotificationItem NobodyAssigned:(BOOL)NobodyAssigned userIDArray:(NSMutableArray *)userIDArray {
    
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
    NSString *usersUsername = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"] : @"";
    
    NSString *itemType = [[[GeneralObject alloc] init] GenerateItemType];
    
    NSString *notificationBody = @"";
    
    if (EditItem) {
        
        notificationBody = [NSString stringWithFormat:@"This %@ has been updated by %@. ✏️", [itemType lowercaseString], [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"]];
        
    } else if (DeleteItem) {
        
        notificationBody = [NSString stringWithFormat:@"This %@ has been deleted by %@. ❌", [itemType lowercaseString], [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"]];
        
    } else if (AddItem) {
        
        if (NotificationItem) {
            
            notificationBody = [NSString stringWithFormat:@"This %@ was created by %@", [itemType lowercaseString], [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"]];
            
            NSMutableArray *adjustedUserIDArray = [userIDArray mutableCopy];
            
            if ([adjustedUserIDArray containsObject:userID]) {
                [adjustedUserIDArray removeObject:userID];
            }
            
            if (NobodyAssigned == YES) {
                
                notificationBody = [NSString stringWithFormat:@"%@ and can be completed by anybody. 📝", notificationBody];
                
            } else {
                
                if (adjustedUserIDArray.count == 1) {
                    
                    NSString *userID = [adjustedUserIDArray count] > 0 ? adjustedUserIDArray[0] : @"";
                    notificationBody = [NSString stringWithFormat:@"%@ and was assigned to %@. 📝", notificationBody, userID];
                    
                } else if (adjustedUserIDArray.count > 1) {
                    
                    for (int i=0;i<adjustedUserIDArray.count;i++) {
                        
                        if (i == 0) {
                            
                            notificationBody = [NSString stringWithFormat:@"%@ and was assigned to %@", notificationBody, adjustedUserIDArray[i]];
                            
                        } else if (i == adjustedUserIDArray.count-1) {
                            
                            NSString *commaString = adjustedUserIDArray.count == 2 ? @"" : @",";
                            NSString *userID = [adjustedUserIDArray count] > adjustedUserIDArray.count-1 ? adjustedUserIDArray[adjustedUserIDArray.count-1] : @"";
                            notificationBody = [NSString stringWithFormat:@"%@%@ and %@. 📝", notificationBody, commaString, userID];
                            
                        } else {
                            
                            notificationBody = [NSString stringWithFormat:@"%@, %@", notificationBody, adjustedUserIDArray[i]];
                            
                        }
                        
                    }
                    
                }
                
            }
            
        } else {
            
            if ([[NSUserDefaults standardUserDefaults] objectForKey:@"ViewingExpenses"] && [[[NSUserDefaults standardUserDefaults] objectForKey:@"ViewingExpenses"] isEqualToString:@"Yes"]) {
                
                if (userIDArray.count >= 3) {
                    
                    notificationBody = [NSString stringWithFormat:@"%@ has requested a payment for this %@ from you and %lu others. 💸", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"], [itemType lowercaseString], userIDArray.count - 1];
                    
                } else if (userIDArray.count == 2) {
                    
                    notificationBody = [NSString stringWithFormat:@"%@ has requested a payment for this %@ from you and %lu other. 💸", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"], [itemType lowercaseString], userIDArray.count - 1];
                    
                } else {
                    
                    notificationBody = [NSString stringWithFormat:@"%@ has requested a payment for this %@ from you. 💸", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"], [itemType lowercaseString]];
                    
                }
                
            } else {
                
                if (userIDArray.count >= 3) {
                    
                    notificationBody = [NSString stringWithFormat:@"This %@ has been assigned to you and %lu others by %@. 📝", [itemType lowercaseString], userIDArray.count - 1, usersUsername];
                    
                } else if (userIDArray.count == 2) {
                    
                    notificationBody = [NSString stringWithFormat:@"This %@ has been assigned to you and %lu other by %@. 📝", [itemType lowercaseString], userIDArray.count - 1, usersUsername];
                    
                } else {
                    
                    notificationBody = [NSString stringWithFormat:@"This %@ has been assigned to you by %@. 📝", [itemType lowercaseString], usersUsername];
                    
                }
                
            }
            
        }
        
    }
    
    return notificationBody;
}

#pragma mark

-(void)SendPushNotificationGroup:(NSMutableArray *)usersToSendNotificationTo notificationTitle:(NSString *)notificationTitle notificationBody:(NSString *)notificationBody badgeNumber:(NSInteger *)badgeNumber dataDict:(NSDictionary *)dataDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType completionHandler:(void (^)(BOOL finished))finishBlock {
    
    if ([usersToSendNotificationTo count] == 0) {
        
        finishBlock(YES);
        
    } else {
        
        dispatch_group_t group = dispatch_group_create();
        
        NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
        [[[GeneralObject alloc] init] AddNotificationQueryToDefaults:usersToSendNotificationTo notificationTitle:notificationTitle notificationBody:notificationBody setData:dataDict notificationSettings:notificationSettingsDict notificationType:notificationType queryID:queryID];
        
        for (NSString *usersIDLocal in usersToSendNotificationTo) {
            
            dispatch_group_enter(group);
            
            NSString *topicSorted = usersIDLocal;
            topicSorted = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:topicSorted arrayOfSymbols:@[@"-", @" ", @":"]];
            
            NSString *topic = [NSString stringWithFormat:@"/topics/%@", topicSorted];
            
            NSMutableDictionary *notifictionDetails = [[NSMutableDictionary alloc] init];
            [notifictionDetails setObject:notificationTitle forKey:@"title"];
            [notifictionDetails setObject:notificationBody forKey:@"body"];
            [notifictionDetails setObject:@"default" forKey:@"sound"];
            //[notifictionDetails setObject:[NSString stringWithFormat:@"%ld", (long)badgeNumber] forKey:@"badge"];
            
            //////////////
            
            NSMutableDictionary *sdetails = [[NSMutableDictionary alloc] init];
            [sdetails setObject:notifictionDetails forKey:@"notification"];
            [sdetails setObject:@"high" forKey:@"priority"];
            [sdetails setObject:topic forKey:@"to"];
            [sdetails setObject:dataDict forKey:@"data"];
            [sdetails setObject:@"wedivvy-afe04" forKey:@"project_id"];
            
            //////////////
            
            NSString *post = [NSString stringWithFormat:@"%@", sdetails];
            NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
            NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
            
            //////////////
            
            NSError *err;
            NSData *jsonData = [NSData data];
            
            //Invalid type in JSON write (_NSZeroData)
            @try {
                jsonData = [NSJSONSerialization dataWithJSONObject:sdetails options:NSJSONWritingPrettyPrinted error:&err];
            }
            @catch (NSException *exception) {
                
                jsonData = [NSData data];
                
            }
            
            //////////////
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:[NSURL URLWithString:@"https://fcm.googleapis.com/fcm/send"]];
            [request setHTTPMethod:@"POST"];
            [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [request setValue:@"key=AAAAZ-QKMTc:APA91bHtF6911EYJHGJ3_s2TfwRDTPOK5yc3U95Wvl0MenCL0yA50aohcSx2DNbVFTVJLgN6qZ0UoD5nV3-XT3f4yyWMhyCg3wKTsujWauCldYBNYezZRrjfDhIO-7zMvy4jsgyrrFya" forHTTPHeaderField:@"Authorization"];
            [request setHTTPBody:jsonData];
            
            BOOL UserCanReceiveNotification = [[[BoolDataObject alloc] init] UserCanReceiveNotification:notificationSettingsDict userID:usersIDLocal notificationItemType:notificationItemType notificationType:notificationType];
            BOOL UserIDIsMe = [[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] isEqualToString:usersIDLocal];
            
            if (UserCanReceiveNotification == YES && UserIDIsMe == NO) {
                
                NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                    
                    [[[GeneralObject alloc] init] EditNotificationQueryToDefaults:usersIDLocal queryID:queryID];
                    
                    NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
                    
                    NSLog(@"abcdefg 123Request reply Send Notification: %@ Error: %@ -- %@ -- %@", requestReply, error.description, jsonData, request);
                    
                    dispatch_group_leave(group);
                    
                }];
                
                [task resume];
                
            } else {
                
                [[[GeneralObject alloc] init] EditNotificationQueryToDefaults:usersIDLocal queryID:queryID];
                
                dispatch_group_leave(group);
                
            }
            
        }
        
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            
            finishBlock(YES);
            
        });
        
    }
    
}

#pragma mark - Generate Notification Data Dict Methods

-(NSMutableDictionary *)GenerateNotificationDataDictSummaryNotification:(NSMutableDictionary *)dataDisplayDict notificationSettings:(NSMutableDictionary *)notificationSettings {
    
    NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    
    for (NSString *section in [dataDisplayDict allKeys]) {
        
        NSMutableDictionary *sectionDict = dataDisplayDict[section] ? [dataDisplayDict[section] mutableCopy] : [NSMutableDictionary dictionary];
        
        NSArray *keysToAdd = @[
            @"ItemUniqueID",
            @"ItemDueDate",
            @"ItemGracePeriod",
            @"ItemPastDue",
            @"ItemPriority",
            @"ItemAssignedTo",
            @"ItemColor",
            @"ItemTags"
        ];
        
        [dataDict setObject:@{} forKey:section];
        
        NSMutableDictionary *sectionDataDict = dataDict[section] ? [dataDict[section] mutableCopy] : [NSMutableDictionary dictionary];
        
        for (NSString *key in keysToAdd) {
            
            NSMutableArray *keyArray = sectionDict[key] ? [sectionDict[key] mutableCopy] : [NSMutableArray array];
            [sectionDataDict setObject:keyArray forKey:key];
            
        }
        
        [dataDict setObject:sectionDataDict forKey:section];
        
    }
    
    [dataDict setObject:notificationSettings forKey:@"NotificationSettings"];
    
    NSMutableArray *sideBarCategorySectionArrayAltered = [[NSUserDefaults standardUserDefaults] objectForKey:@"SideBarCategorySectionArrayAltered"];
    [dataDict setObject:sideBarCategorySectionArrayAltered forKey:@"SideBarCategorySectionArrayAltered"];
    
    return dataDict;
}

-(NSDictionary *)GenerateNotificationDataDictLiveSupport {
    
    NSDictionary *dataDict = @{
        @"Live Support" : @"Yes",
        @"UserID" : @"",
        @"ViewingLiveSupport" : @"Yes"
    };
    
    return dataDict;
}

-(NSDictionary *)GenerateNotificationDataDictForum:(NSMutableDictionary *)forumDict viewingFeatureForum:(BOOL)viewingFeatureForum {
    
    NSDictionary *dataDict =  @{
        @"Forum" : @"Yes",
        @"ForumDict" : forumDict ? [forumDict mutableCopy] : [NSMutableDictionary dictionary],
        @"FeatureForum" : viewingFeatureForum ? @"Yes" : @"No",
    };
    
    return dataDict;
}

-(NSDictionary *)GenerateNotificationDataDictSilentNotification:(NSString *)sentBy {
    
    NSDictionary *dataDict = @{
        @"AddToBadgeCount" : @"Yes",
        @"SentBy" : sentBy ? sentBy : @""
    };
    
    return dataDict;
}

-(NSDictionary *)GenerateNotificationDataDictHome:(NSString *)homeID homeName:(NSString *)homeName viewingHomeMembersFromHomesViewController:(BOOL)viewingHomeMembersFromHomesViewController {
    
    NSDictionary *dataDict = @{
        @"Home" : @"Yes",
        @"HomeID" : homeID ? homeID : @"",
        @"HomeName" : homeName ? homeName : @"",
        @"viewingHomeMembersFromHomesViewController" : viewingHomeMembersFromHomesViewController ? @"Yes" : @"No"};
    
    return dataDict;
}

-(NSDictionary *)GenerateNotificationDataDictGroupChat:(NSString *)chatID chatName:(NSString *)chatName chatAssignedTo:(NSMutableArray *)chatAssignedTo userID:(NSString *)userID homeID:(NSString *)homeID homeMembersDict:(NSMutableDictionary *)homeMembersDict {
    
    NSString *chatAssignedToString = [[[GeneralObject alloc] init] GenerateStringArray:chatAssignedTo];
    
    NSDictionary *dataDict = @{
        @"GroupChat" : @"Yes",
        @"HomeID" : homeID ? homeID : @"",
        @"ChatID" : chatID ? chatID : @"",
        @"ChatName" : chatName ? chatName : @"",
        @"ChatAssignedTo" : chatAssignedToString ? chatAssignedToString : @"",
        @"HomeMembersDict" : homeMembersDict ? homeMembersDict : [NSMutableDictionary dictionary],
        @"ViewingGroupChat" : @"Yes"
    };
    
    return dataDict;
}

-(NSDictionary *)GenerateNotificationDataDictComments:(NSString *)homeID itemType:(NSString *)itemType itemID:(NSString *)itemID itemName:(NSString *)itemName itemCreatedBy:(NSString *)itemCreatedBy itemAssignedTo:(NSMutableArray *)itemAssignedTo homeMembersDict:(NSMutableDictionary *)homeMembersDict {
    
    NSString *itemAssignedToString = [[[GeneralObject alloc] init] GenerateStringArray:itemAssignedTo];
    
    NSDictionary *dataDict = @{
        @"Comment" : @"Yes",
        @"HomeID" : homeID ? homeID : @"",
        @"ItemType" : itemType,
        @"ItemID" : itemID ? itemID : @"",
        @"ItemName" : itemName ? itemName : @"",
        @"ItemCreatedBy" : itemCreatedBy ? itemCreatedBy : @"",
        @"ItemAssignedTo" : itemAssignedToString ? itemAssignedToString : @"",
        @"HomeMembersDict" : homeMembersDict ? homeMembersDict : [NSMutableDictionary dictionary],
        @"ViewingComments" : @"Yes"
        
    };
    
    return dataDict;
}

-(NSDictionary *)GenerateNotificationDataDictTask:(NSString *)itemID itemOccurrenceID:(NSString *)itemOccurrenceID itemType:(NSString *)itemType allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays homeMembersArray:(NSMutableArray * _Nullable)homeMembersArray {
    
    NSString *allItemTagsArraysString = [[[GeneralObject alloc] init] GenerateStringArray:allItemTagsArrays];
    NSString *homeMembersArrayString = [[[GeneralObject alloc] init] GenerateStringArray:homeMembersArray];
    
    NSDictionary *dataDict = @{
        @"Item" : @"Yes",
        @"ItemType" : itemType ? itemType : @"",
        @"ItemID" : itemID ? itemID : @"",
        @"ItemOccurrenceID" : itemOccurrenceID ? itemOccurrenceID : @"",
        @"AllItemTagsArrays" : allItemTagsArraysString ? allItemTagsArraysString : @"",
        @"HomeMembersArray" : homeMembersArrayString ? homeMembersArrayString : @"",
    };
    
    return dataDict;
}

#pragma mark - Generate Due Date Methods

-(NSMutableArray *)GenerateArrayOfRepeatingDueDates:(NSString *)itemRepeats itemRepeatIfCompletedEarly:(NSString *)itemRepeatIfCompletedEarly itemCompleteAsNeeded:(NSString *)itemCompleteAsNeeded totalAmountOfFutureDates:(int)totalAmountOfFutureDates maxAmountOfDueDatesToLoopThrough:(int)maxAmountOfDueDatesToLoopThrough itemDatePosted:(NSString *)itemDatePosted itemDueDate:(NSString *)itemDueDate itemStartDate:(NSString *)itemStartDate itemEndDate:(NSString *)itemEndDate itemTime:(NSString *)itemTime itemDays:(NSString *)itemDays itemDueDatesSkipped:(NSMutableArray *)itemDueDatesSkipped itemDateLastReset:(NSString *)itemDateLastReset SkipStartDate:(BOOL)SkipStartDate {
    
    BOOL TaskIsRepeating = [[[BoolDataObject alloc] init] TaskIsRepeating:[@{@"ItemRepeats" : itemRepeats} mutableCopy] itemType:@""];
    BOOL TaskIsRepeatingWhenCompleted = [[[BoolDataObject alloc] init] TaskIsRepeatingWhenCompleted:[@{@"ItemRepeats" : itemRepeats, @"ItemRepeatIfCompletedEarly" : itemRepeatIfCompletedEarly} mutableCopy] itemType:@""];
    BOOL TaskIsCompleteAsNeeded = [[[BoolDataObject alloc] init] TaskIsCompleteAsNeeded:[@{@"ItemRepeats" : itemRepeats, @"ItemCompleteAsNeeded" : itemCompleteAsNeeded} mutableCopy] itemType:@""];
    
    BOOL TaskIsNotRepeating_OR_RepeatingWithNoDueDate = (TaskIsRepeating == NO || TaskIsRepeatingWhenCompleted == YES || TaskIsCompleteAsNeeded == YES);
    
    if (TaskIsNotRepeating_OR_RepeatingWithNoDueDate == YES) {
        
        return [@[itemDueDate] mutableCopy];
        
    }
    
    
    
    
    //    //When You Need To Find Future Due Date(s) That May Be Later Then The Future Due Date Immediately After The Current Date
    //    //If You Don't Set Yes Then The Method Will Only Find Due Dates Up To And Including The Future Due Date Immediately After The Current Date
    //    [[NSUserDefaults standardUserDefaults] setObject:FindAllFutureDueDates || itemDueDate.length == 0 || [itemDueDatesSkipped containsObject:itemDueDate] ? @"Yes" : @"No"*/ forKey:@"FindAllFutureDueDates"];
    
    
    
    
    NSString *dateFormat = @"MMMM dd, yyyy hh:mm a";
    NSString *dateStringCurrent = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:dateFormat returnAs:[NSString class]];
    
    //Use To Test Updating Due Dates - Search this string to find sister code
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"TestDueDateIsSet"] isEqualToString:@"Yes"]) {
        dateStringCurrent = [[NSUserDefaults standardUserDefaults] objectForKey:@"TestDueDate"];
    }
    
    itemTime = [self GenerateArrayOfRepeatingDueDates_GenerateItemTime:itemDays itemTime:itemTime itemRepeats:itemRepeats];
    itemStartDate = [self GenerateArrayOfRepeatingDueDates_GenerateItemStartDate:itemTime itemStartDate:itemStartDate];
    
    BOOL RepeatingAndRepeatingIfCompletedEarly_ResetBeforeDueDatePassed = [self GenerateArrayOfRepeatingDueDates_RepeatingAndRepeatingIfCompletedEarly_ResetBeforeDueDatePassed:itemRepeats itemRepeatIfCompletedEarly:itemRepeatIfCompletedEarly itemDueDate:itemDueDate itemStartDate:itemStartDate itemDueDatesSkipped:itemDueDatesSkipped dateStringCurrent:dateStringCurrent dateFormat:dateFormat];
   
    NSString *dateToBeginGeneratingDueDates = [self GenerateArrayOfRepeatingDueDates_GenerateDateToBeginGeneratingDueDates:itemRepeats itemDatePosted:itemDatePosted itemDueDate:itemDueDate itemStartDate:itemStartDate itemTime:itemTime itemDateLastReset:itemDateLastReset RepeatingAndRepeatingIfCompletedEarly_ResetBeforeDueDatePassed:RepeatingAndRepeatingIfCompletedEarly_ResetBeforeDueDatePassed];
   
    
    
    //Use To Test Updating Due Dates - Search this string to find sister code
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"TestDueDateIsSet"] isEqualToString:@"Yes"]) {
        dateToBeginGeneratingDueDates = [[NSUserDefaults standardUserDefaults] objectForKey:@"TestDueDate"];
    }
   
    
    NSMutableArray *potentialFutureDueDateArray = [NSMutableArray array];
    NSMutableArray *potentialFutureDueDatesThatAreLaterThanEndDateArray = [NSMutableArray array];
    
    NSString *previousDate = @"";
    NSString *potentialFutureDueDate = @"";
    
    BOOL TaskIsRepeatingHourly = [[[BoolDataObject alloc] init] TaskIsRepeatingHourly:[@{@"ItemRepeats" : itemRepeats} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType]];
    BOOL TaskIsRepeatingDaily = [[[BoolDataObject alloc] init] TaskIsRepeatingDaily:[@{@"ItemRepeats" : itemRepeats} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType]];
    BOOL TaskIsRepeatingWeekly = [[[BoolDataObject alloc] init] TaskIsRepeatingWeekly:[@{@"ItemRepeats" : itemRepeats} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType]];
    BOOL TaskIsRepeatingMonthly = [[[BoolDataObject alloc] init] TaskIsRepeatingMonthly:[@{@"ItemRepeats" : itemRepeats} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType]];
    
    //maxAmountOfFutureDates must be 1 to return same due date of past due task
    
    //Tasks Repeating Monthly Only Work With The Old Way Of Starting Form The Date Posted
    if (TaskIsRepeatingMonthly == YES) {
        maxAmountOfDueDatesToLoopThrough = 36;
        totalAmountOfFutureDates = 36;
    }
    
    for (int i=0;i<maxAmountOfDueDatesToLoopThrough;i++) {
        
        if (previousDate.length == 0) {
            
            if (TaskIsRepeatingHourly) {
                
                potentialFutureDueDate = [[[NotificationsObject alloc] init] GenerateNextHourDueDateForRepeatingTask:dateToBeginGeneratingDueDates potentialFutureDueDate:@"" itemDueDate:itemDueDate itemTime:itemTime itemDatePosted:dateToBeginGeneratingDueDates itemRepeats:itemRepeats itemRepeatIfCompletedEarly:itemRepeatIfCompletedEarly firstIteration:YES];
                
            } else if (TaskIsRepeatingDaily) {
               
                potentialFutureDueDate = [[[NotificationsObject alloc] init] GenerateNextDayDueDateForRepeatingTask:dateToBeginGeneratingDueDates potentialFutureDueDate:@"" itemDueDate:itemDueDate itemTime:itemTime itemDatePosted:dateToBeginGeneratingDueDates itemRepeats:itemRepeats itemRepeatIfCompletedEarly:itemRepeatIfCompletedEarly firstIteration:YES];
              
            } else if (TaskIsRepeatingWeekly) {
              
                potentialFutureDueDate = [[[NotificationsObject alloc] init] GenerateNextWeekDueDateForRepeatingTask:dateToBeginGeneratingDueDates potentialFutureDueDate:@"" itemDays:itemDays itemDueDate:itemDueDate itemTime:itemTime itemDatePosted:dateToBeginGeneratingDueDates itemRepeats:itemRepeats itemRepeatIfCompletedEarly:itemRepeatIfCompletedEarly firstIteration:YES];
           
            } else if (TaskIsRepeatingMonthly) {
                
                potentialFutureDueDate = [[[NotificationsObject alloc] init] GenerateNextMonthDueDateForRepeatingTask:dateToBeginGeneratingDueDates potentialFutureDueDate:@"" itemDays:itemDays itemDueDate:itemDueDate itemTime:itemTime itemDatePosted:dateToBeginGeneratingDueDates itemRepeats:itemRepeats itemRepeatIfCompletedEarly:itemRepeatIfCompletedEarly firstIteration:YES];
                
            }
            
            previousDate = potentialFutureDueDate;
            
        } else {
            
            if (TaskIsRepeatingHourly) {
                
                previousDate = [[[NotificationsObject alloc] init] GenerateNextHourDueDateForRepeatingTask:dateToBeginGeneratingDueDates potentialFutureDueDate:potentialFutureDueDate itemDueDate:itemDueDate itemTime:itemTime itemDatePosted:itemDatePosted itemRepeats:itemRepeats itemRepeatIfCompletedEarly:itemRepeatIfCompletedEarly firstIteration:NO];
                
            } else if (TaskIsRepeatingDaily) {
                
                previousDate = [[[NotificationsObject alloc] init] GenerateNextDayDueDateForRepeatingTask:dateToBeginGeneratingDueDates potentialFutureDueDate:potentialFutureDueDate itemDueDate:itemDueDate itemTime:itemTime itemDatePosted:itemDatePosted itemRepeats:itemRepeats itemRepeatIfCompletedEarly:itemRepeatIfCompletedEarly firstIteration:NO];
            
            } else if (TaskIsRepeatingWeekly) {
               
                previousDate = [[[NotificationsObject alloc] init] GenerateNextWeekDueDateForRepeatingTask:dateToBeginGeneratingDueDates potentialFutureDueDate:potentialFutureDueDate itemDays:itemDays itemDueDate:itemDueDate itemTime:itemTime itemDatePosted:itemDatePosted itemRepeats:itemRepeats itemRepeatIfCompletedEarly:itemRepeatIfCompletedEarly firstIteration:NO];
          
            } else if (TaskIsRepeatingMonthly) {
                
                previousDate = [[[NotificationsObject alloc] init] GenerateNextMonthDueDateForRepeatingTask:dateToBeginGeneratingDueDates potentialFutureDueDate:potentialFutureDueDate itemDays:itemDays itemDueDate:itemDueDate itemTime:itemTime itemDatePosted:itemDatePosted itemRepeats:itemRepeats itemRepeatIfCompletedEarly:itemRepeatIfCompletedEarly firstIteration:NO];
                
            }
            
            potentialFutureDueDate = previousDate;
            
        }
        
        
        
        
        NSDictionary *dict = [self GenerateArrayOfRepeatingDueDates_GenerateBOOLs:itemRepeats itemRepeatIfCompletedEarly:itemRepeatIfCompletedEarly itemDatePosted:itemDatePosted itemDueDate:itemDueDate itemStartDate:itemStartDate itemEndDate:itemEndDate itemTime:itemTime itemDueDatesSkipped:itemDueDatesSkipped previousDate:previousDate i:i dateStringCurrent:dateStringCurrent dateFormat:dateFormat];
        
        BOOL PotentialFutureDueDateIsAcceptable = [dict[@"PotentialFutureDueDateIsAcceptable"] isEqualToString:@"Yes"] ? YES : NO;
        BOOL PotentialFutureDueDateIsEarlierThanEndDate = [dict[@"PotentialFutureDueDateIsEarlierThanEndDate"] isEqualToString:@"Yes"] ? YES : NO;
        BOOL ItemEndDateNumOfTimesHasPassed = [dict[@"ItemEndDateNumOfTimesHasPassed"] isEqualToString:@"Yes"] ? YES : NO;
        BOOL ItemStartDateSelected = [dict[@"ItemStartDateSelected"] isEqualToString:@"Yes"] ? YES : NO;
        
        
      
        
        //This Prevents This Method From Looping Infinite Times, If 5 Due Dates That Are Passed The Due Date Are Found Then Most Likley All Due Dates Past This Point Will Be Past The End Date And Invalid So Stop The Method
        if (PotentialFutureDueDateIsEarlierThanEndDate == NO || ItemEndDateNumOfTimesHasPassed == YES) {
          
            [potentialFutureDueDatesThatAreLaterThanEndDateArray addObject:previousDate];
           
            if ([potentialFutureDueDatesThatAreLaterThanEndDateArray count] > 5) {
                
                int secondsPassedSinceCurrentDateFromStartDate = [[[GeneralObject alloc] init] GenerateTimeIntervalBetweenTwoDates:itemStartDate dateString2:dateStringCurrent dateFormat:dateFormat];
                
                BOOL CurrentDateIsLaterThanStartDate = secondsPassedSinceCurrentDateFromStartDate > 0;
                BOOL StartDateHasBeenSkipped = [itemDueDatesSkipped containsObject:itemStartDate];
                
                if (ItemStartDateSelected == YES && CurrentDateIsLaterThanStartDate == NO && StartDateHasBeenSkipped == NO && SkipStartDate == NO) {
                    [potentialFutureDueDateArray insertObject:itemStartDate atIndex:0];
                }
                
                return potentialFutureDueDateArray;
            }
            
        }
        
        
        
        
        if (PotentialFutureDueDateIsAcceptable == YES) {
        
            if ([potentialFutureDueDateArray containsObject:previousDate] == NO) {
                [potentialFutureDueDateArray addObject:previousDate];
            }
           
            if ([potentialFutureDueDateArray count] >= totalAmountOfFutureDates) {
                
                int secondsPassedSinceCurrentDateFromStartDate = [[[GeneralObject alloc] init] GenerateTimeIntervalBetweenTwoDates:itemStartDate dateString2:dateStringCurrent dateFormat:dateFormat];
                
                BOOL CurrentDateIsLaterThanStartDate = secondsPassedSinceCurrentDateFromStartDate > 0;
                BOOL StartDateHasBeenSkipped = [itemDueDatesSkipped containsObject:itemStartDate];
                
                if (ItemStartDateSelected == YES && CurrentDateIsLaterThanStartDate == NO && StartDateHasBeenSkipped == NO && SkipStartDate == NO) {
                    [potentialFutureDueDateArray insertObject:itemStartDate atIndex:0];
                }
              
                return potentialFutureDueDateArray;
            }
            
        }
        
    }
    
    
    
    
    if ([potentialFutureDueDateArray count] == 0) {
        [potentialFutureDueDateArray addObject:itemDueDate];
    }
    
    return potentialFutureDueDateArray;
}

-(int)GenerateAmountOfDueDatesForTheNextXAmountOfYears:(int)years itemRepeats:(NSString *)itemRepeats itemDays:(NSString *)itemDays {
    
    BOOL TaskIsRepeatingWeekly = [[[BoolDataObject alloc] init] TaskIsRepeatingWeekly:[@{@"ItemRepeats" : itemRepeats} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType]];
    BOOL TaskIsRepeatingMonthly = [[[BoolDataObject alloc] init] TaskIsRepeatingMonthly:[@{@"ItemRepeats" : itemRepeats} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType]];
    
    
    
    int amountOfDueDates = 1000;
    
    int daysInYear = 365;
    int daysInMonth = 31;
    int daysInWeek = 7;
    
    
    
    int daysInFrequency = 1;
    
    if (TaskIsRepeatingWeekly) {
        
        daysInFrequency = daysInWeek;
        
    } else if (TaskIsRepeatingMonthly) {
        
        daysInFrequency = daysInMonth;
        
    }
    
    
    
    int intervalNum = [[[NotificationsObject alloc] init] GenerateRepeatingInterval:itemRepeats];
    NSArray *itemDaysArray = [itemDays length] > 0 ? [itemDays componentsSeparatedByString:@", "] : @[@""];
    int timesPerYear = (daysInYear/daysInFrequency) * (int)itemDaysArray.count;
    
    amountOfDueDates = (timesPerYear/intervalNum) * years;
    
    
    
    return amountOfDueDates;
}

#pragma mark - Notification Types

-(NSString *)NotificationSettingsUnknownItemType_Adding:(BOOL)Adding Editing:(BOOL)Editing Deleting:(BOOL)Deleting Duplicating:(BOOL)Duplicating Waiving:(BOOL)Waiving Skipping:(BOOL)Skipping Pausing:(BOOL)Pausing Comments:(BOOL)Comments
                                           SkippingTurn:(BOOL)SkippingTurn RemovingUser:(BOOL)RemovingUser
                                         FullyCompleted:(BOOL)FullyCompleted Completed:(BOOL)Completed InProgress:(BOOL)InProgress WontDo:(BOOL)WontDo Accept:(BOOL)Accept Decline:(BOOL)Decline
                                                DueDate:(BOOL)DueDate Reminder:(BOOL)Reminder
                                         SubtaskEditing:(BOOL)SubtaskEditing SubtaskDeleting:(BOOL)SubtaskDeleting
                                       SubtaskCompleted:(BOOL)SubtaskCompleted SubtaskInProgress:(BOOL)SubtaskInProgress SubtaskWontDo:(BOOL)SubtaskWontDo SubtaskAccept:(BOOL)SubtaskAccept SubtaskDecline:(BOOL)SubtaskDecline
                                         AddingListItem:(BOOL)AddingListItem EditingListItem:(BOOL)EditingListItem DeletingListItem:(BOOL)DeletingListItem ResetingListItem:(BOOL)ResetingListItem
                                    EditingItemizedItem:(BOOL)EditingItemizedItem DeletingItemizedItem:(BOOL)DeletingItemizedItem
                                      GroupChatMessages:(BOOL)GroupChatMessages LiveSupportMessages:(BOOL)LiveSupportMessages
                                     SendingInvitations:(BOOL)SendingInvitations DeletingInvitations:(BOOL)DeletingInvitations
                                         NewHomeMembers:(BOOL)NewHomeMembers HomeMembersMovedOut:(BOOL)HomeMembersMovedOut HomeMembersKickedOut:(BOOL)HomeMembersKickedOut
                                    FeatureForumUpvotes:(BOOL)FeatureForumUpvotes BugForumUpvotes:(BOOL)BugForumUpvotes
                                               itemType:(NSString *)itemType {
    
    NSString *notificationType = @"";
    
    if ([itemType containsString:@"Chore"]) {
        
        notificationType = [[[NotificationsObject alloc] init] NotificationSettingsChores_Adding:Adding Editing:Editing Deleting:Deleting Duplicating:Duplicating Waiving:Waiving Skipping:Skipping Pausing:Pausing Comments:Comments
                                                                                    SkippingTurn:SkippingTurn RemovingUser:RemovingUser
                                                                                  FullyCompleted:FullyCompleted Completed:Completed InProgress:InProgress WontDo:WontDo Accept:Accept Decline:Decline
                                                                                         DueDate:DueDate Reminder:Reminder
                                                                                  SubtaskEditing:SubtaskEditing SubtaskDeleting:SubtaskDeleting
                                                                                SubtaskCompleted:SubtaskCompleted SubtaskInProgress:SubtaskInProgress SubtaskWontDo:SubtaskWontDo SubtaskAccept:SubtaskAccept SubtaskDecline:SubtaskDecline];
        
    } else if ([itemType containsString:@"Expense"]) {
        
        notificationType = [[[NotificationsObject alloc] init] NotificationSettingsExpenses_Adding:Adding Editing:Editing Deleting:Deleting Duplicating:Duplicating Waiving:Waiving Skipping:Skipping Pausing:Pausing Comments:Comments
                                                                                      SkippingTurn:SkippingTurn RemovingUser:RemovingUser
                                                                                    FullyCompleted:FullyCompleted Completed:Completed InProgress:InProgress WontDo:WontDo Accept:Accept Decline:Decline
                                                                                           DueDate:DueDate Reminder:Reminder
                                                                               EditingItemizedItem:EditingItemizedItem DeletingItemizedItem:DeletingItemizedItem];
        
    } else if ([itemType containsString:@"List"]) {
        
        notificationType = [[[NotificationsObject alloc] init] NotificationSettingsLists_Adding:Adding Editing:Editing Deleting:Deleting Duplicating:Duplicating Waiving:Waiving Skipping:Skipping Pausing:Pausing Comments:Comments
                                                                                 FullyCompleted:FullyCompleted Completed:Completed InProgress:InProgress WontDo:WontDo Accept:Accept Decline:Decline
                                                                                        DueDate:DueDate Reminder:Reminder
                                                                                 AddingListItem:AddingListItem EditingListItem:EditingListItem DeletingListItem:DeletingListItem ResetingListItem:ResetingListItem];
        
    } else if ([itemType containsString:@"GroupChat"]) {
        
        notificationType = [[[NotificationsObject alloc] init] NotificationSettingsGroupChats_Adding:Adding Editing:Editing Deleting:Deleting
                                                                                   GroupChatMessages:GroupChatMessages LiveSupportMessages:LiveSupportMessages];
        
    } else if ([itemType containsString:@"HomeMember"]) {
        
        notificationType = [[[NotificationsObject alloc] init] NotificationSettingsHomeMembers_SendingInvitations:SendingInvitations DeletingInvitations:DeletingInvitations
                                                                                                   NewHomeMembers:NewHomeMembers HomeMembersMovedOut:HomeMembersMovedOut HomeMembersKickedOut:HomeMembersKickedOut];
        
    } else if ([itemType containsString:@"Forum"]) {
        
        notificationType = [[[NotificationsObject alloc] init] NotificationSettingsForum_FeatureForumUpvotes:BugForumUpvotes FeatureForumUpvotes:FeatureForumUpvotes];
        
    }
    
    return notificationType;
}

#pragma mark - Inactive Notification

-(void)GenerateTwoWeekReminderNotification {
    
    [[[NotificationsObject alloc] init] UserHasAcceptedNotifications:^(BOOL isActive) {
        
        if (isActive) {
            
            if (![[NSUserDefaults standardUserDefaults] objectForKey:@"TwoWeekReminderProcessing"]) {
                
                [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"TwoWeekReminderProcessing"];
                
                [[[NotificationsObject alloc] init] GenerateTwoWeekReminderNotificationTitle:^(BOOL finished, NSString *notificationTitleReturning, NSString *notificationBodyResults, int GenerateNotificationSeconds) {
                    
                    NSString *identifier = [NSString stringWithFormat:@"Two Week Reminder"];
                    
                    UNUserNotificationCenter *notificationCenter = [UNUserNotificationCenter currentNotificationCenter];
                    
                    NSMutableArray *arr = [NSMutableArray array];
                    [arr addObject:identifier];
                    
                    [notificationCenter removePendingNotificationRequestsWithIdentifiers:arr];
                    
                    UNMutableNotificationContent *notificationContent = [[UNMutableNotificationContent alloc] init];
                    UNTimeIntervalNotificationTrigger *notificationTrigger;
                    UNNotificationRequest *notificationRequest;
                    
                    notificationContent.title = [NSString localizedUserNotificationStringForKey:notificationTitleReturning arguments:nil];
                    notificationContent.body = [NSString localizedUserNotificationStringForKey:notificationBodyResults arguments:nil];
                    notificationContent.sound = [UNNotificationSound defaultSound];
                    notificationContent.categoryIdentifier = identifier;
                    
                    int notificationSeconds = [[[NotificationsObject alloc] init] GenerateInactiveNotificationSettings:GenerateNotificationSeconds];
                    
                    notificationTrigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:notificationSeconds repeats:NO];
                    
                    notificationRequest = [UNNotificationRequest requestWithIdentifier:identifier content:notificationContent trigger:notificationTrigger];
                    
                    if (notificationContent.title.length > 0 && notificationContent.title != NULL) {
                        
                        [notificationCenter addNotificationRequest:notificationRequest withCompletionHandler:^(NSError * _Nullable error) {
                            
                            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TwoWeekReminderProcessing"];
                            
                        }];
                        
                    }
                    
                }];
                
                [[[NotificationsObject alloc] init] GenerateTwoWeekReminderNotificationTitle_1:^(BOOL finished, NSString *notificationTitleReturning, NSString *notificationBodyResults, int GenerateNotificationSeconds) {
                    
                    NSString *identifier = [NSString stringWithFormat:@"Two Week Reminder (1)"];
                    
                    UNUserNotificationCenter *notificationCenter = [UNUserNotificationCenter currentNotificationCenter];
                    
                    NSMutableArray *arr = [NSMutableArray array];
                    [arr addObject:identifier];
                    
                    [notificationCenter removePendingNotificationRequestsWithIdentifiers:arr];
                    
                    UNMutableNotificationContent *notificationContent = [[UNMutableNotificationContent alloc] init];
                    UNTimeIntervalNotificationTrigger *notificationTrigger;
                    UNNotificationRequest *notificationRequest;
                    
                    notificationContent.title = [NSString localizedUserNotificationStringForKey:notificationTitleReturning arguments:nil];
                    notificationContent.body = [NSString localizedUserNotificationStringForKey:notificationBodyResults arguments:nil];
                    notificationContent.sound = [UNNotificationSound defaultSound];
                    notificationContent.categoryIdentifier = identifier;
                    
                    int notificationSeconds = [[[NotificationsObject alloc] init] GenerateInactiveNotificationSettings:GenerateNotificationSeconds];
                    
                    notificationTrigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:notificationSeconds repeats:NO];
                    
                    notificationRequest = [UNNotificationRequest requestWithIdentifier:identifier content:notificationContent trigger:notificationTrigger];
                    
                    [notificationCenter addNotificationRequest:notificationRequest withCompletionHandler:^(NSError * _Nullable error) {
                        
                        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TwoWeekReminderProcessing"];
                        
                    }];
                    
                }];
                
            }
            
        }
        
    }];
    
}

-(void)RemoveLocalInactiveNotification {
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center removePendingNotificationRequestsWithIdentifiers:@[@"Two Week Reminder", @"Two Week Reminder (1)"]];
    
}

#pragma mark - Unread Notification Methods

-(BOOL)UserSignedUpAfterNotificationWasCreated:(NSString *)userID notificationDatePosted:(NSString *)notificationDatePosted {
    
    if ([userID containsString:@" "]) {
        
        NSArray *userIDArray = [userID componentsSeparatedByString:@" "];
        
        if ([userIDArray count] > 1) {
            
            NSString *userIDDate = userIDArray[0];
            NSString *userIDTime = userIDArray[1];
            
            if ([userIDTime containsString:@":"]) {
                
                NSArray *userIDTimeHourMinuteSecond = [userIDTime componentsSeparatedByString:@":"];
                
                if ([userIDTimeHourMinuteSecond count] > 2) {
                    
                    NSString *userIDHour = userIDTimeHourMinuteSecond[0];
                    NSString *userIDMinute = userIDTimeHourMinuteSecond[1];
                    NSString *userIDSecond = userIDTimeHourMinuteSecond[2];
                    
                    if ([userIDSecond length] > 1) {
                        
                        userIDSecond = [NSString stringWithFormat:@"%c%c", [userIDSecond characterAtIndex:0], [userIDSecond characterAtIndex:1]];
                        
                        NSString *userIDReformatted = [NSString stringWithFormat:@"%@ %@:%@:%@", userIDDate, userIDHour, userIDMinute, userIDSecond];
                        
                        NSString *dateFormat = @"yyyy-MM-dd HH:mm:ss";
                        
                        NSTimeInterval timeInveral = [[[GeneralObject alloc] init] GenerateTimeIntervalBetweenTwoDates:notificationDatePosted dateString2:userIDReformatted dateFormat:dateFormat];
                        BOOL UserSignedUpAfterNotificationWasCreated = timeInveral > 0;
                        
                        return UserSignedUpAfterNotificationWasCreated;
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    return YES;
}

#pragma mark - Other

-(NSMutableArray *)AddAndRemoveSpecificUsersFromArray:(NSMutableArray *)arrayToUse addTheseUsers:(NSArray *)addTheseUsers removeTheseUsers:(NSArray *)removeTheseUsers {
    
    NSMutableArray *usersToSendNotificationTo = [arrayToUse mutableCopy];
    
    for (NSString *userID in addTheseUsers) {
        
        if ([usersToSendNotificationTo containsObject:userID] == NO && userID != nil && userID != NULL) {
            
            [usersToSendNotificationTo addObject:userID];
            
        }
        
    }
    
    for (NSString *userID in removeTheseUsers) {
        
        if ([usersToSendNotificationTo containsObject:userID]) {
            
            [usersToSendNotificationTo removeObject:userID];
            
        }
        
    }
    
    return usersToSendNotificationTo;
}

-(void)SaveMyLocalNotifications:(void (^)(BOOL finished))finishBlock {
    
    NSMutableArray *notificationIdentifierArray = [NSMutableArray array];
    
    [[UNUserNotificationCenter currentNotificationCenter] getPendingNotificationRequestsWithCompletionHandler:^(NSArray<UNNotificationRequest *> *requests){
        
        for (UNNotificationRequest *str in requests) {
            
            [notificationIdentifierArray addObject:str.identifier];
            
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:notificationIdentifierArray forKey:@"MyNotifications"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            finishBlock(YES);
            
        });
        
    }];
    
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Internal Methods
#pragma mark
#pragma mark
#pragma mark - Reminder Notification Methods

-(NSString *)GenerateFrequencyString:(NSString *)key secondsBetweenHour:(NSTimeInterval)secondsUntilTaskIsDue {
    
    NSString *frequencyString;
    
    if ([key containsString:@" ççç "]) {
        
        NSArray *titleArray = [key componentsSeparatedByString:@" ççç "];
        NSString *reminderFrequency = [titleArray count] > 1 ? titleArray[1] : @"";
        NSArray *itemReminderArray = [reminderFrequency componentsSeparatedByString:@" "];
        NSString *reminderFrequencyAmount = [itemReminderArray count] > 0 ? itemReminderArray[0] : @"";
        
        if ([reminderFrequency containsString:@"Grace Period"]) {
            
            NSString *newReminderFrequency = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:reminderFrequency arrayOfSymbols:@[@" Grace Period"]];
            NSArray *itemGracePeriodArray = [newReminderFrequency componentsSeparatedByString:@" "];
            NSString *itemGracePeriodAmount = [itemGracePeriodArray count] > 0 ? itemGracePeriodArray[0] : @"";
            NSString *itemGracePeriodInterval = [itemGracePeriodArray count] > 1 ? itemGracePeriodArray[1] : @"";
            
            if (
                ([itemGracePeriodInterval containsString:@"Minute"] &&
                 (secondsUntilTaskIsDue > 0 || (secondsUntilTaskIsDue < 0 && (secondsUntilTaskIsDue*-1 < 60*([itemGracePeriodAmount intValue])))))
                
                || ([itemGracePeriodInterval containsString:@"Hour"] &&
                    (secondsUntilTaskIsDue > 0 || (secondsUntilTaskIsDue < 0 && (secondsUntilTaskIsDue*-1 < 3600*([itemGracePeriodAmount intValue])))))
                
                || ([itemGracePeriodInterval containsString:@"Day"] &&
                    (secondsUntilTaskIsDue > 0 || (secondsUntilTaskIsDue < 0 && (secondsUntilTaskIsDue*-1 < 86400*([itemGracePeriodAmount intValue])))))
                
                || ([itemGracePeriodInterval containsString:@"Week"] &&
                    (secondsUntilTaskIsDue > 0 || (secondsUntilTaskIsDue < 0 && (secondsUntilTaskIsDue*-1 < 604800*([itemGracePeriodAmount intValue])))))) {
                        
                        frequencyString = @"Grace Period";
                        
                    }
            
        } else if ([reminderFrequency containsString:@"Due Now"] && secondsUntilTaskIsDue > 0) {
            
            frequencyString = @"Now";
            
        } else if ([reminderFrequency containsString:@"Minute"] && secondsUntilTaskIsDue > 60*([reminderFrequencyAmount intValue])) {
            
            frequencyString = @"Minute";
            
        } else if ([[reminderFrequency lowercaseString] containsString:@"hour"] && secondsUntilTaskIsDue > 3600*([reminderFrequencyAmount intValue])) {
            
            frequencyString = @"Hour";
            
        } else if ([reminderFrequency containsString:@"Day"] && secondsUntilTaskIsDue > 86400*([reminderFrequencyAmount intValue])) {
            
            frequencyString = @"Day";
            
        } else if ([reminderFrequency containsString:@"Week"] && secondsUntilTaskIsDue > 604800*([reminderFrequencyAmount intValue])) {
            
            frequencyString = @"Week";
            
        }
        
    }
    
    return frequencyString;
    
}

-(int)GenerateRemoveSeconds:(NSString *)key secondsUntilTaskIsDue:(NSTimeInterval)secondsUntilTaskIsDue gracePeriodSecondsToSubtract:(int)gracePeriodSecondsToSubtract {
    
    int removeSeconds = 0;
    
    if ([key containsString:@" ççç "]) {
        
        NSArray *titleArray = [key componentsSeparatedByString:@" ççç "];
        NSString *reminderFrequency = [titleArray count] > 1 ? titleArray[1] : @"";
        NSArray *itemReminderArray = [reminderFrequency componentsSeparatedByString:@" "];
        NSString *reminderFrequencyAmount = [itemReminderArray count] > 0 ? itemReminderArray[0] : @"";
        
        if ([reminderFrequency containsString:@"Grace Period"]) {
            
            removeSeconds = 0;
            
        } else if ([reminderFrequency containsString:@"Due Now"] && secondsUntilTaskIsDue > 0) {
            
            removeSeconds = 0;
            
        } else if ([reminderFrequency containsString:@"Minute"] && secondsUntilTaskIsDue > 60*([reminderFrequencyAmount intValue])) {
            
            removeSeconds = 60*([reminderFrequencyAmount intValue]) + gracePeriodSecondsToSubtract;
            
        } else if ([reminderFrequency containsString:@"Hour"] && secondsUntilTaskIsDue > 3600*([reminderFrequencyAmount intValue])) {
            
            removeSeconds = 3600*([reminderFrequencyAmount intValue]) + gracePeriodSecondsToSubtract;
            
        } else if ([reminderFrequency containsString:@"Day"] && secondsUntilTaskIsDue > 86400*([reminderFrequencyAmount intValue])) {
            
            removeSeconds = 86400*([reminderFrequencyAmount intValue]) + gracePeriodSecondsToSubtract;
            
        } else if ([reminderFrequency containsString:@"Week"] && secondsUntilTaskIsDue > 604800*([reminderFrequencyAmount intValue])) {
            
            removeSeconds = 604800*([reminderFrequencyAmount intValue]) + gracePeriodSecondsToSubtract;
            
        }
        
    }
    
    return removeSeconds;
    
}

-(NSMutableArray *)GenerateArrayOfIndexesForDueDatesEveryXOccurrences:(int)indexOfUser totalAmountOfFutureDates:(int)totalAmountOfFutureDates totalAssignedToUsers:(int)totalAssignedToUsers itemAlternateTurns:(NSString *)itemAlternateTurns dueDateStrings:(NSArray *)dueDateStrings itemTurnUserID:(NSString *)itemTurnUserID {
    
    NSMutableArray *indexArr = [NSMutableArray array];
    
    if ([itemAlternateTurns containsString:@"Completion"]) {
        
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] &&
            [itemTurnUserID isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]]) {
            
            for (int i=0 ; i<totalAmountOfFutureDates ; i++) {
                [indexArr addObject:[NSString stringWithFormat:@"%d", i]];
            }
            
        }
        
    } else if ([itemAlternateTurns containsString:@" Day"] ||
               [itemAlternateTurns containsString:@" Week"] ||
               [itemAlternateTurns containsString:@" Month"]) {
        
        indexArr = [[[NotificationsObject alloc] init] GenerateArrayOfIndexForDaysWeeksMonths:indexOfUser totalAmountOfFutureDates:totalAmountOfFutureDates totalAssignedToUsers:totalAssignedToUsers itemAlternateTurns:itemAlternateTurns dueDateStrings:dueDateStrings];
        
    } else {
        
        indexArr = [[[NotificationsObject alloc] init] GenerateArrayOfIndexForOccurrences:indexOfUser totalAmountOfFutureDates:totalAmountOfFutureDates totalAssignedToUsers:totalAssignedToUsers itemAlternateTurns:itemAlternateTurns];
        
    }
    
    
    
    return indexArr;
}

-(NSMutableArray *)GenerateArrayOfIndexesForDueDates:(int)totalAmountOfFutureDates {
    
    NSMutableArray *indexArr = [NSMutableArray array];
    
    for (int i=0;i<totalAmountOfFutureDates;i+=1) {
        
        [indexArr addObject:[NSString stringWithFormat:@"%d", i]];
        
    }
    
    return indexArr;
}

-(NSMutableArray *)GenerateArrayWithOldDueDatesRemoved:(NSMutableArray *)allDueDatesArray itemDueDate:(NSString *)itemDueDate {
    
    NSMutableArray *allDueDatesArrayCopy = [allDueDatesArray mutableCopy];
    
    NSString *dateFormat = @"MMMM dd, yyyy hh:mm a";
    
    //Remove All Due Dates Before Current ItemDueDate
    for (NSString *itemDueDateIteration in allDueDatesArray) {
        
        NSTimeInterval seconds = [[[GeneralObject alloc] init] GenerateTimeIntervalBetweenTwoDates:itemDueDateIteration dateString2:itemDueDate dateFormat:dateFormat];
        
        if (seconds > 0) {
            
            if ([allDueDatesArrayCopy containsObject:itemDueDateIteration] == YES) {
                
                [allDueDatesArrayCopy removeObject:itemDueDateIteration];
                
            }
            
        } else {
            
            break;
            
        }
        
    }
    
    if (allDueDatesArrayCopy.count == 0) {
        
        allDueDatesArrayCopy = [allDueDatesArray mutableCopy];
        
        NSString *dateFormat = @"MMMM dd, yyyy hh:mm a";
        NSString *currentDateString = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:dateFormat returnAs:[NSString class]];
        
        for (NSString *itemDueDateIteration in allDueDatesArray) {
            
            NSTimeInterval seconds = [[[GeneralObject alloc] init] GenerateTimeIntervalBetweenTwoDates:itemDueDateIteration dateString2:currentDateString dateFormat:dateFormat];
            
            if (seconds > 0) {
                
                [allDueDatesArrayCopy removeObject:itemDueDateIteration];
                
            } else {
                
                break;
                
            }
            
        }
        
    }
    
    return allDueDatesArrayCopy;
    
}

-(NSMutableArray *)GenerateArrayOfMyDueDates:(NSMutableArray *)allDueDatesArray myIndexesForMyDueDatesArray:(NSMutableArray *)myIndexesForMyDueDatesArray {
    
    NSMutableArray *allMyDueDatesArray = [NSMutableArray array];
    int startingInt = [myIndexesForMyDueDatesArray count] > 0 ? [myIndexesForMyDueDatesArray[0] intValue] : 0;
    
    for (int i=startingInt;i<allDueDatesArray.count;i++) {
        
        if ([myIndexesForMyDueDatesArray containsObject:[NSString stringWithFormat:@"%d", i]]) {
            
            if ([allDueDatesArray count] > i) {
                
                [allMyDueDatesArray addObject:allDueDatesArray[i]];
                
            }
            
        }
        
    }
    
    return allMyDueDatesArray;
    
}

-(void)GenerateAndAddNotificationRequest:(NSString *)itemID itemOccurrenceID:(NSString *)itemOccurrenceID itemType:(NSString *)itemType notificationTextDict:(NSDictionary *)notificationTextDict key:(NSString *)key i:(int)i currentIterationDueDate:(NSString *)currentIterationDueDate secondsUntilDueDate:(NSTimeInterval)secondsUntilDueDate removeSeconds:(int)removeSeconds itemAssignedTo:(NSMutableArray *)itemAssignedTo notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType AddActions:(BOOL)AddActions {
    
    UNUserNotificationCenter *notificationCenter = [UNUserNotificationCenter currentNotificationCenter];
    UNMutableNotificationContent *notificationContent = [[UNMutableNotificationContent alloc] init];
    UNTimeIntervalNotificationTrigger *notificationTrigger;
    UNNotificationRequest *notificationRequest;
    
    NSArray *keyArr = [key containsString:@" ççç "] ? [key componentsSeparatedByString:@" ççç "] : @[];
    NSString *keyIdentifier = [keyArr count] > 1 ? keyArr[1] : key;
    
    NSString *identifier = [NSString stringWithFormat:@"%@ - %d (%@) - %@", itemID, i, keyIdentifier, currentIterationDueDate];
    identifier = identifier ? identifier : @"UnknownIdentifier";
    
    NSString *categoryIdentifier = itemID;
    categoryIdentifier = categoryIdentifier ? categoryIdentifier : @"UnknownCategoryIdentifier";
    
    NSString *title = [[[NotificationsObject alloc] init] RemoveExtraTextFromKey:[key mutableCopy]];
    NSString *body = notificationTextDict[key];
    
    
    
    
    if (AddActions) {
        
        //        UNNotificationAction *completedAction = [UNNotificationAction actionWithIdentifier:@"Mark Completed" title:@"Mark Completed" options:0];
        //        UNNotificationAction *inProgressAction = [UNNotificationAction actionWithIdentifier:@"Mark In Progress" title:@"Mark In Progress" options:0];
        //        UNNotificationAction *wontDoAction = [UNNotificationAction actionWithIdentifier:@"Mark Won't Do" title:@"Mark Won't Do" options:0];
        //        UNNotificationCategory *category = [UNNotificationCategory categoryWithIdentifier:categoryIdentifier actions:@[completedAction, inProgressAction, wontDoAction] intentIdentifiers:@[@"Mark Completed", @"Mark In Progress", @"Mark Won't Do"] options:UNNotificationCategoryOptionCustomDismissAction];
        //        [notificationCenter setNotificationCategories:[NSSet setWithObject:category]];
        
    }
    
    
    
    
    notificationContent.title = [NSString localizedUserNotificationStringForKey:title arguments:nil];
    notificationContent.body = [NSString localizedUserNotificationStringForKey:body arguments:nil];
    notificationContent.sound = [UNNotificationSound defaultSound];
    notificationContent.categoryIdentifier = categoryIdentifier;
    
    
    
    
    NSDictionary *dataDict = [[[NotificationsObject alloc] init] GenerateNotificationDataDictTask:itemID itemOccurrenceID:itemOccurrenceID itemType:itemType allItemTagsArrays:allItemTagsArrays homeMembersArray:itemAssignedTo];
    
    notificationContent.userInfo = dataDict;
    
    
    
    
    int timeInterval = secondsUntilDueDate - removeSeconds;
    
    if ([identifier containsString:@"Grace Period"] == YES) {
        
        timeInterval = secondsUntilDueDate;
        
    }
    
    if (timeInterval < 1) {
        
        timeInterval = 1;
        
    }
    
    notificationTrigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:timeInterval repeats:NO];
    notificationRequest = [UNNotificationRequest requestWithIdentifier:identifier content:notificationContent trigger:notificationTrigger];
    
    
    
    
    //        NSDate *dueDateInDateForm = [[NSDate date] dateByAddingTimeInterval:timeInterval];
    //        NSString *dateFormat = @"EEEE"];
    //        NSString *weekDay = [dateFormatter stringFromDate:dueDateInDateForm];
    //
    //
    //
    //
    //        NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
    //
    //        BOOL UserCanReceiveNotification = [[[BoolDataObject alloc] init] UserCanReceiveNotification:notificationSettingsDict userID:userID notificationItemType:notificationItemType notificationType:notificationType];
    //
    //        BOOL UserCanReceiveNotificationForDayOfTheWeek = [[[BoolDataObject alloc] init] UserCanReceiveNotification:notificationSettingsDict userID:userID notificationItemType:@"DaysOfTheWeek" notificationType:weekDay];
    //
    //        if (UserCanReceiveNotification == YES && UserCanReceiveNotificationForDayOfTheWeek == YES) {
    
    [notificationCenter addNotificationRequest:notificationRequest withCompletionHandler:nil];
    
    //        }
    
}

-(NSMutableDictionary *)GenerateNotificationMessages:(NSString *)itemType itemID:(NSString *)itemID itemOccurrenceID:(NSString *)itemOccurrenceID itemName:(NSString *)itemName itemCreatedBy:(NSString *)itemCreatedBy itemAssignedTo:(NSMutableArray *)itemAssignedTo itemAssignedToOriginal:(NSMutableArray *)itemAssignedToOriginal itemCompletedDict:(NSMutableDictionary *)itemCompletedDict itemReminderDict:(NSDictionary *)itemReminderDict itemAdditionalReminders:(NSMutableDictionary *)itemAdditionalReminders itemListItemKeys:(NSMutableArray *)itemListItems itemGracePeriod:(NSString *)itemGracePeriod itemTakeTurns:(NSString *)itemTakeTurns itemAlternateTurns:(NSString *)itemAlternateTurns itemTurnUserID:(NSString *)itemTurnUserID itemTimeOriginal:(NSString *)itemTimeOriginal homeMembersDict:(NSMutableDictionary *)homeMembersDict {
    
    /* itemAssignedToOriginal Is Used When ItemAssignedTo Is Replaced With Specific User When Task Is Taking Turns.
     ItemAssignedTo Is Used To Generate Notification Text So It Needs To Be Populated By Specific User Who's Turn It Is. */
    
    if ([itemTimeOriginal isEqualToString:@"Any Time"] == YES) {
        
        BOOL ItemReminderExists = [[itemReminderDict allKeys] count] == 0 == NO;
        
        NSMutableDictionary *reminderNotificationDict = [NSMutableDictionary dictionary];
        
        if (ItemReminderExists == YES) {
            
            for (NSString *itemReminder in [itemReminderDict allKeys]) {
                
                if ([itemReminder containsString:@"Due Now"] == NO) {
                    
                    NSDictionary *reminderNotificationTextDict = [[[NotificationsObject alloc] init] GenerateReminderAnyTimeNotificationText:itemType itemName:itemName itemCreatedBy:itemCreatedBy itemAssignedTo:itemAssignedTo itemAssignedToOriginal:itemAssignedToOriginal itemReminder:itemReminder itemGracePeriod:itemGracePeriod];
                    [reminderNotificationDict setObject:reminderNotificationTextDict[@"Body"] forKey:reminderNotificationTextDict[@"Title"]];
                    
                }
                
            }
            
        }
        
        NSMutableDictionary *notificationTextDict = [NSMutableDictionary dictionary];
        
        for (NSString *itemReminderTitle in [reminderNotificationDict allKeys]) {
            [notificationTextDict setObject:reminderNotificationDict[itemReminderTitle] forKey:itemReminderTitle];
        }
        
        return notificationTextDict;
    }
    
    //    [itemAdditionalReminders setObject:@{@"Reminder" : @"4 Hours Before"} forKey:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
    BOOL ItemHasGracePeriod = [[[BoolDataObject alloc] init] TaskHasGracePeriod:[@{@"ItemGracePeriod" : itemGracePeriod} mutableCopy] itemType:itemType];
    BOOL ItemReminderExists = [[itemReminderDict allKeys] count] == 0 == NO;
    BOOL ItemAdditionalReminderExists = itemAdditionalReminders[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] ? itemAdditionalReminders[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] : NO;
    
    NSMutableDictionary *reminderNotificationDict = [NSMutableDictionary dictionary];
    
    NSString *additionalReminderNotificationTitle = @"";
    NSString *additionalReminderNotificationBody = @"";
    
    NSString *dueNowNotificationTitle = @"";
    NSString *dueNowNotificationBody = @"";
    
    NSString *gracePeriodNotificationTitle = @"";
    NSString *gracePeriodNotificationBody = @"";
    
    
    
    if (ItemReminderExists == YES) {
        
        for (NSString *itemReminder in [itemReminderDict allKeys]) {
            
            if ([itemReminder containsString:@"Due Now"] == NO) {
                
                NSDictionary *reminderNotificationTextDict = [[[NotificationsObject alloc] init] GenerateReminderNotificationText:itemType itemName:itemName itemCreatedBy:itemCreatedBy itemAssignedTo:itemAssignedTo itemAssignedToOriginal:itemAssignedToOriginal itemCompletedDict:itemCompletedDict itemReminder:itemReminder itemReminderDict:itemReminderDict homeMembersDict:homeMembersDict];
                
                [reminderNotificationDict setObject:reminderNotificationTextDict[@"Body"] forKey:reminderNotificationTextDict[@"Title"]];
                
            }
            
        }
        
    }
    
    
    
    if (ItemAdditionalReminderExists == YES) {
        
        NSString *itemAdditonalReminder =
        itemAdditionalReminders[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]][@"Reminder"] ?
        itemAdditionalReminders[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]][@"Reminder"] : @"";
        
        NSDictionary *additionalReminderNotificationTextDict = [[[NotificationsObject alloc] init] GenerateReminderNotificationText:itemType itemName:itemName itemCreatedBy:itemCreatedBy itemAssignedTo:itemAssignedTo itemAssignedToOriginal:itemAssignedToOriginal itemCompletedDict:itemCompletedDict itemReminder:itemAdditonalReminder itemReminderDict:itemReminderDict homeMembersDict:homeMembersDict];
        additionalReminderNotificationTitle = additionalReminderNotificationTextDict[@"Title"];
        additionalReminderNotificationBody = additionalReminderNotificationTextDict[@"Body"];
        
    }
    
    
    
    NSMutableDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:itemTurnUserID homeMembersDict:homeMembersDict];
    NSString *itemTurnUsername = dataDict[@"Username"] ? dataDict[@"Username"] : @"";
    
    
    
    NSDictionary *dueNowNotificationTextDict =
    itemReminderDict && itemReminderDict[@"Due Now"] ?
    [[[NotificationsObject alloc] init] GenerateDueNowNotificationText:itemType itemName:itemName itemCreatedBy:itemCreatedBy itemAssignedTo:itemAssignedTo itemAssignedToOriginal:itemAssignedToOriginal itemCompletedDict:itemCompletedDict itemGracePeriod:itemGracePeriod homeMembersDict:homeMembersDict itemReminder:@"Due Now" itemReminderDict:itemReminderDict itemTakeTurns:itemTakeTurns itemAlternateTurns:itemAlternateTurns itemTurnUsername:itemTurnUsername] :
    @{@"Title" : @"", @"Body" : @""};
    dueNowNotificationTitle = dueNowNotificationTextDict[@"Title"];
    dueNowNotificationBody = dueNowNotificationTextDict[@"Body"];
    
    
    
    NSDictionary *gracePeriodNotificationTextDict = [[[NotificationsObject alloc] init] GenerateGracePeriodNotificationText:itemType itemName:itemName itemCreatedBy:itemCreatedBy itemAssignedTo:itemAssignedTo itemAssignedToOriginal:itemAssignedToOriginal itemGracePeriod:itemGracePeriod];
    gracePeriodNotificationTitle = gracePeriodNotificationTextDict[@"Title"];
    gracePeriodNotificationBody = gracePeriodNotificationTextDict[@"Body"];
    
    
    
    BOOL ReminderNotificationDisabled =
    [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"DisabledReminderNotificationForItemID%@AndItemOccurrenceID%@", itemID, itemOccurrenceID]] ||
    [[reminderNotificationDict allKeys] count] == 0;
    
    BOOL DueDateNotificationDisabled =
    [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"DisabledDueDateNotificationForItemID%@AndItemOccurrenceID%@", itemID, itemOccurrenceID]] ||
    dueNowNotificationTitle.length == 0;
    
    BOOL GracePeriodNotificationDisabled =
    [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"DisabledGracePeriodNotificationForItemID%@AndItemOccurrenceID%@", itemID, itemOccurrenceID]] ||
    gracePeriodNotificationTitle.length == 0;
    
    
    
    NSMutableDictionary *notificationTextDict = [NSMutableDictionary dictionary];
    
    if (ItemHasGracePeriod == YES) {
        
        if (GracePeriodNotificationDisabled == NO) {
            [notificationTextDict setObject:gracePeriodNotificationBody forKey:dueNowNotificationTitle];
        }
        
        if (DueDateNotificationDisabled == NO) {
            [notificationTextDict setObject:dueNowNotificationBody forKey:gracePeriodNotificationTitle];
        }
        
        if (ReminderNotificationDisabled == NO) {
            for (NSString *itemReminderTitle in [reminderNotificationDict allKeys]) {
                [notificationTextDict setObject:reminderNotificationDict[itemReminderTitle] forKey:itemReminderTitle];
            }
        }
        
        if (ItemAdditionalReminderExists == YES) {
            [notificationTextDict setObject:additionalReminderNotificationBody forKey:additionalReminderNotificationTitle];
        }
        
    } else {
        
        if (DueDateNotificationDisabled == NO) {
            [notificationTextDict setObject:dueNowNotificationBody forKey:dueNowNotificationTitle];
        }
        
        if (ReminderNotificationDisabled == NO) {
            for (NSString *itemReminderTitle in [reminderNotificationDict allKeys]) {
                [notificationTextDict setObject:reminderNotificationDict[itemReminderTitle] forKey:itemReminderTitle];
            }
        }
        
        if (ItemAdditionalReminderExists == YES) {
            [notificationTextDict setObject:additionalReminderNotificationBody forKey:additionalReminderNotificationTitle];
        }
        
    }
    
    return notificationTextDict;
    
}

-(NSDictionary *)GenerateNoInvitationSentDict:(NSMutableDictionary *)homeKeysDict homeMembersUnclaimedDict:(NSMutableDictionary *)homeMembersUnclaimedDict {
    
    NSMutableArray *arrayOfNoInvitationArray = [NSMutableArray array];
    NSMutableArray *arrayOfNoInvitationDateUserAddedArray = [NSMutableArray array];
    
    
    
    
    for (NSString *key in [homeMembersUnclaimedDict allKeys]) {
        
        if (homeMembersUnclaimedDict[key]) {
            
            NSString *invitationSent = homeMembersUnclaimedDict[key][@"InvitationSent"] ? homeMembersUnclaimedDict[key][@"InvitationSent"] : @"";
            NSString *username = homeMembersUnclaimedDict[key][@"Username"] ? homeMembersUnclaimedDict[key][@"Username"] : @"";
            NSString *userID = homeMembersUnclaimedDict[key][@"UserID"] ? homeMembersUnclaimedDict[key][@"UserID"] : @"";
            
            if ([invitationSent containsString:@"•••"] == NO) {
                
                [arrayOfNoInvitationArray addObject:username];
                
                NSArray *arr = [userID containsString:@":"] ? [userID componentsSeparatedByString:@":"] : @[];
                NSString *lastComp = [arr count] > 2 ? arr[2] : @"";
                NSString *lastCompNo1 = [lastComp length] > 2 ? [NSString stringWithFormat:@"%@", [lastComp substringToIndex:2]] : @"";
                NSString *userIDWithLastComp = [arr count] > 1 ? [NSString stringWithFormat:@"%@:%@:%@", arr[0], arr[1], lastCompNo1] : @"";
                
                [arrayOfNoInvitationDateUserAddedArray addObject:userIDWithLastComp];
                
            }
            
        }
        
    }
    
    
    
    
    NSString *uncalimedHomeMemberNoInvitationNotificationTitle =
    [arrayOfNoInvitationArray count] > 0 ?
    [NSString stringWithFormat:@"%lu Uninvited Home Member%@ 😢", [arrayOfNoInvitationArray count], [arrayOfNoInvitationArray count] != 1 ? @"s" : @""] :
    @"";
    NSString *uncalimedHomeMemberNoInvitationNotificationBody = @"";
    
    if ([arrayOfNoInvitationArray count] == 1) {
        
        uncalimedHomeMemberNoInvitationNotificationBody = [NSString stringWithFormat:@"Don't forget to send an invitation to %@.", arrayOfNoInvitationArray[0]];
        
    } else if ([arrayOfNoInvitationArray count] == 2) {
        
        uncalimedHomeMemberNoInvitationNotificationBody = [NSString stringWithFormat:@"Don't forget to send an invitation to %@ and %@.", arrayOfNoInvitationArray[0], arrayOfNoInvitationArray[1]];
        
    } else if ([arrayOfNoInvitationArray count] > 2) {
        
        for (NSString *username in arrayOfNoInvitationArray) {
            
            if ([uncalimedHomeMemberNoInvitationNotificationBody length] == 0) {
                
                uncalimedHomeMemberNoInvitationNotificationBody = [NSString stringWithFormat:@"Don't forget to send an invitation to %@", username];
                
            } else if ([username isEqualToString:[arrayOfNoInvitationArray lastObject]]) {
                
                uncalimedHomeMemberNoInvitationNotificationBody = [NSString stringWithFormat:@"%@, and %@.", uncalimedHomeMemberNoInvitationNotificationBody, username];
                
            } else {
                
                uncalimedHomeMemberNoInvitationNotificationBody = [NSString stringWithFormat:@"%@, %@", uncalimedHomeMemberNoInvitationNotificationBody, username];
                
            }
            
        }
        
    }
    
    
    
    
    if ([uncalimedHomeMemberNoInvitationNotificationBody length] == 0 || [arrayOfNoInvitationDateUserAddedArray count] == 0) {
        return @{@"Title" : uncalimedHomeMemberNoInvitationNotificationTitle,
                 @"Body" : uncalimedHomeMemberNoInvitationNotificationBody,
                 @"Seconds" : [NSString stringWithFormat:@"%d", 0]};
    }
    
    
    
    
    arrayOfNoInvitationDateUserAddedArray = [[arrayOfNoInvitationDateUserAddedArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] mutableCopy];
    
    NSString *dateFormat = @"MMMM dd, yyyy hh:mm a";
    
    NSDate *currentDate = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:dateFormat returnAs:[NSDate class]];
    NSString *mostRecentNoInvitationUserAdded = [arrayOfNoInvitationDateUserAddedArray count] > 0 ? arrayOfNoInvitationDateUserAddedArray[0] : @"";
    NSDate *mostRecentNoInvitationUserAddedDateForm = [[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:mostRecentNoInvitationUserAdded returnAs:[NSDate class]];
    NSTimeInterval timeRemainingUntilFutureDate = 0;
    
    for (int i=1 ; i<100 ; i++) {
        
        int multiple = 1;
        
        if (i == 2) {
            multiple = 4;
        } else if (i > 2) {
            multiple = 4 + (7*(i-2));
        }
        
        NSDate *futureDateToSendNotification = [[[GeneralObject alloc] init] GenerateDateWithAddedTimeWithFormat:dateFormat dateToAddTimeTo:mostRecentNoInvitationUserAddedDateForm timeToAdd:86400*multiple returnAs:[NSDate class]];
        
        timeRemainingUntilFutureDate = [futureDateToSendNotification timeIntervalSinceDate:currentDate];
        
        if (timeRemainingUntilFutureDate > 1) {
            break;
        }
        
    }
    
    
    
    
    return @{@"Title" : uncalimedHomeMemberNoInvitationNotificationTitle,
             @"Body" : uncalimedHomeMemberNoInvitationNotificationBody,
             @"Seconds" : [NSString stringWithFormat:@"%f", timeRemainingUntilFutureDate]};
}

-(NSDictionary *)GenerateHasNotJoinedDict:(NSMutableDictionary *)homeKeysDict homeMembersUnclaimedDict:(NSMutableDictionary *)homeMembersUnclaimedDict {
    
    NSMutableArray *arrayOfInvitationNotUsedArray = [NSMutableArray array];
    NSMutableArray *arrayOfInvitationNotUsedDateSentArray = [NSMutableArray array];
    
    
    
    
    for (NSString *key in [homeMembersUnclaimedDict allKeys]) {
        
        if (homeMembersUnclaimedDict[key]) {
            
            NSString *invitationSent = homeMembersUnclaimedDict[key][@"InvitationSent"] ? homeMembersUnclaimedDict[key][@"InvitationSent"] : @"";
            NSString *username = homeMembersUnclaimedDict[key][@"Username"] ? homeMembersUnclaimedDict[key][@"Username"] : @"";
            
            if ([invitationSent containsString:@"•••"]) {
                
                if (homeKeysDict[invitationSent]) {
                    
                    NSString *dateUsed = homeKeysDict[invitationSent][@"DateUsed"] ? homeKeysDict[invitationSent][@"DateUsed"] : @"";
                    NSString *dateSent = homeKeysDict[invitationSent][@"DateSent"] ? homeKeysDict[invitationSent][@"DateSent"] : @"";
                    
                    if ([dateUsed length] == 0) {
                        
                        [arrayOfInvitationNotUsedArray addObject:username];
                        [arrayOfInvitationNotUsedDateSentArray addObject:dateSent];
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    
    
    
    NSString *uncalimedHomeMemberInvitationNotUsedNotificationTitle =
    [arrayOfInvitationNotUsedArray count] > 0 ?
    [NSString stringWithFormat:@"%lu Unused Invitation%@ 💌", [arrayOfInvitationNotUsedArray count], [arrayOfInvitationNotUsedArray count] != 1 ? @"s" : @""] :
    @"";
    NSString *uncalimedHomeMemberInvitationNotUsedNotificationBody = @"";
    
    if ([arrayOfInvitationNotUsedArray count] == 1) {
        
        uncalimedHomeMemberInvitationNotUsedNotificationBody = [NSString stringWithFormat:@"Don't forget to remind %@ to join your home.", arrayOfInvitationNotUsedArray[0]];
        
    } else if ([arrayOfInvitationNotUsedArray count] == 2) {
        
        uncalimedHomeMemberInvitationNotUsedNotificationBody = [NSString stringWithFormat:@"Don't forget to remind %@ and %@ to join your home.", arrayOfInvitationNotUsedArray[0], arrayOfInvitationNotUsedArray[1]];
        
    } else if ([arrayOfInvitationNotUsedArray count] > 2) {
        
        for (NSString *username in arrayOfInvitationNotUsedArray) {
            
            if ([uncalimedHomeMemberInvitationNotUsedNotificationBody length] == 0) {
                
                uncalimedHomeMemberInvitationNotUsedNotificationBody = [NSString stringWithFormat:@"Don't forget to remind %@", username];
                
            } else if ([username isEqualToString:[arrayOfInvitationNotUsedArray lastObject]]) {
                
                uncalimedHomeMemberInvitationNotUsedNotificationBody = [NSString stringWithFormat:@"%@, and %@ to join your home.", uncalimedHomeMemberInvitationNotUsedNotificationBody, username];
                
            } else {
                
                uncalimedHomeMemberInvitationNotUsedNotificationBody = [NSString stringWithFormat:@"%@, %@", uncalimedHomeMemberInvitationNotUsedNotificationBody, username];
                
            }
            
        }
        
    }
    
    
    
    
    if ([arrayOfInvitationNotUsedDateSentArray count] == 0) {
        return
        @{@"Title" : uncalimedHomeMemberInvitationNotUsedNotificationTitle,
          @"Body" : uncalimedHomeMemberInvitationNotUsedNotificationBody,
          @"Seconds" : [NSString stringWithFormat:@"%d", 0]};
    }
    
    
    
    
    arrayOfInvitationNotUsedDateSentArray = [[arrayOfInvitationNotUsedDateSentArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] mutableCopy];
    
    NSString *dateFormat = @"MMMM dd, yyyy hh:mm a";
    
    NSDate *currentDate = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:dateFormat returnAs:[NSDate class]];
    NSString *mostRecentInvitationSent = [arrayOfInvitationNotUsedDateSentArray count] > 0 ? arrayOfInvitationNotUsedDateSentArray[0] : @"";
    NSDate *mostRecentInvitationSentDateForm = [[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:mostRecentInvitationSent returnAs:[NSDate class]];
    NSTimeInterval timeRemainingUntilFutureDate = 0;
    
    for (int i=1 ; i<100 ; i++) {
        
        int multiple = 1;
        
        if (i == 2) {
            multiple = 4;
        } else if (i > 2) {
            multiple = 4 + (7*(i-2));
        }
        
        NSDate *futureDateToSendNotification = [[[GeneralObject alloc] init] GenerateDateWithAddedTimeWithFormat:dateFormat dateToAddTimeTo:mostRecentInvitationSentDateForm timeToAdd:86400*multiple+30 returnAs:[NSDate class]];
        
        timeRemainingUntilFutureDate = [futureDateToSendNotification timeIntervalSinceDate:currentDate];
        
        if (timeRemainingUntilFutureDate > 1) {
            break;
        }
        
    }
    
    
    
    
    return
    @{@"Title" : uncalimedHomeMemberInvitationNotUsedNotificationTitle,
      @"Body" : uncalimedHomeMemberInvitationNotUsedNotificationBody,
      @"Seconds" : [NSString stringWithFormat:@"%f", timeRemainingUntilFutureDate]};
}

-(NSMutableArray *)GenerateUsersToSendNotificationToArray:(NSMutableArray *)userIDArray homeMembersDict:(NSMutableDictionary *)homeMembersDict RemoveUsersNotInHome:(BOOL)RemoveUsersNotInHome {
    
    if ([userIDArray count] == 0) {
        return userIDArray;
    }
    
    NSString *myUserID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
    
    if ([userIDArray containsObject:myUserID]) {
        [userIDArray removeObject:myUserID];
    }
    
    if (RemoveUsersNotInHome == YES) {
        
        BOOL HomeMemberDictIsFull = homeMembersDict[@"UserID"] && [(NSArray *)homeMembersDict[@"UserID"] count] > 0 && homeMembersDict[@"Email"] && [(NSArray *)homeMembersDict[@"Email"] count] > 0;
        
        if (HomeMemberDictIsFull == YES) {
            
            for (NSString *userID in [userIDArray mutableCopy]) {
                
                NSDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:userID homeMembersDict:homeMembersDict];
                NSString *email = dataDict[@"Email"];
                
                BOOL UserHasJoinedHome = [email length] > 0;
                
                if (UserHasJoinedHome == NO) {
                    [userIDArray removeObject:userID];
                }
                
            }
            
        }
        
    }
    
    userIDArray = [[[GeneralObject alloc] init] RemoveDupliatesFromArray:userIDArray];
    
    return userIDArray;
}

-(NSMutableArray *)GenerateTopicIDAndUserIDsToSendNotificationTo:(NSMutableDictionary *)topicDict topicID:(NSString *)topicID userIDArray:(NSMutableArray *)userIDArray homeMembersDict:(NSMutableDictionary *)homeMembersDict RemoveUsersNotInHome:(BOOL)RemoveUsersNotInHome {
    
    BOOL UserWasCreatedAfterTheChange = [[[BoolDataObject alloc] init] UserWasCreatedAfterChange];
    
    if (UserWasCreatedAfterTheChange == NO) {
        return userIDArray;
    }
    
    
    
    if (userIDArray.count == 10 || userIDArray.count == 1 || userIDArray.count == 0) {
        return userIDArray;
    }
    
    NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"";
    //    NSMutableArray *homeMembersArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeMembersArray"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeMembersArray"] : [NSMutableArray array];
    
    
    if (userIDArray.count == [(NSArray *)homeMembersDict[@"UserID"] count]) {
        
        NSArray *sortedUserIDArray = [[[NotificationsObject alloc] init] SortArrayOfUniqueIDs:userIDArray];
        NSArray *sortedHomeMemberDictUserIDArray = [[[NotificationsObject alloc] init] SortArrayOfUniqueIDs:homeMembersDict[@"UserID"]];
        
        if ([sortedUserIDArray isEqualToArray:sortedHomeMemberDictUserIDArray]) {
            return [@[homeID] mutableCopy];
        }
        
    }
    
    BOOL UseLocallyGeneratedTopics = [[[BoolDataObject alloc] init] UseLocallyGeneratedTopics:homeMembersDict];
    
    if (UseLocallyGeneratedTopics == YES) {
        
        userIDArray = [[[[NotificationsObject alloc] init] SortArrayOfUniqueIDs:userIDArray] mutableCopy];
        
        NSArray *subsets = [[[NotificationsObject alloc] init] GenerateUniqueSubsets:homeMembersDict[@"UserID"]];
        
        for (NSArray *subset in subsets) {
            
            if ([userIDArray isEqualToArray:subset]) {
                
                NSString *topicID = [[[NotificationsObject alloc] init] GenerateTopicFromSubset:subset];
                
                if (topicID.length > 0) {
                    
                    return [@[topicID] mutableCopy];
                    
                }
                
            }
            
        }
        
    }
    
    //    if (topicDict && topicDict[@"TopicID"] && [topicDict[@"TopicID"] containsObject:topicID]) {
    //
    //        NSArray *keyArray = [[[GeneralObject alloc] init] GenerateTopicKeyArray];
    //        NSUInteger index = [topicDict[@"TopicID"] indexOfObject:topicID];
    //        NSDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSingleObjectDictionary:topicDict keyArray:keyArray indexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    //
    //
    //        NSMutableArray *topicAssignedTo = dataDict[@"TopicAssignedTo"] ? dataDict[@"TopicAssignedTo"] : [NSMutableArray array];
    //        NSMutableArray *topicSubscribedTo = dataDict[@"TopicSubscribedTo"] ? dataDict[@"TopicSubscribedTo"] : [NSMutableArray array];
    //
    //
    //        NSArray *sortedHomeMembesArray = [[[NotificationsObject alloc] init] SortArrayOfUniqueIDs:homeMembersArray];
    //        NSArray *sortedAssignedToArray = [[[NotificationsObject alloc] init] SortArrayOfUniqueIDs:topicAssignedTo];
    //        NSArray *sortedTopicSubscribedToArray = [[[NotificationsObject alloc] init] SortArrayOfUniqueIDs:topicSubscribedTo];
    //
    //
    //        NSSet *homeMembersArraySet = [NSSet setWithArray:sortedHomeMembesArray];
    //        NSSet *topicAssignedToSet = [NSSet setWithArray:sortedAssignedToArray];
    //        NSSet *topicSubscribedToSet = [NSSet setWithArray:sortedTopicSubscribedToArray];
    //
    //
    //
    //        BOOL HomeMembersArrayAndTopicSubscribedToArrayHaveTheSameUserIDs =
    //        (homeMembersArraySet.count > 0 && topicAssignedToSet.count > 0 && topicSubscribedToSet.count > 0 &&
    //         [homeMembersArraySet isEqualToSet:topicAssignedToSet] && [homeMembersArraySet isEqualToSet:topicSubscribedToSet]);
    //
    //        BOOL TopicAssignedToToAndTopicSubscribedToArrayHaveTheSameUserIDs =
    //        (topicAssignedToSet.count > 0 && topicSubscribedToSet.count > 0 &&
    //         [topicAssignedToSet isEqualToSet:topicSubscribedToSet]);
    //
    //
    //        if (HomeMembersArrayAndTopicSubscribedToArrayHaveTheSameUserIDs == YES) {
    //            return [@[homeID] mutableCopy];
    //        }
    //
    //        if (TopicAssignedToToAndTopicSubscribedToArrayHaveTheSameUserIDs == YES) {
    //            return [@[topicID] mutableCopy];
    //        }
    //
    //
    //        if (topicAssignedTo.count > 0 && topicSubscribedTo.count > 0) {
    //
    //
    //            //Found User Who Has Not Unsubscribed From A Topic They Were Removed From
    //            //Can't Send To Topic Because At Least One User Will Receive Notification Who Shouldn't
    //            //Send To Specific Users Instead
    //            for (NSString *userID in topicSubscribedTo) {
    //
    //                if ([topicAssignedTo containsObject:userID] == NO) {
    //
    //                    return userIDArray;
    //
    //                }
    //
    //            }
    //
    //
    //
    //            //Found User Who Has Not Subscribed To A Topic They Were Added To
    //            //Get Specific Users Not Subscribed To Topic
    //            //Send Notification To Topic + Not Subscribed Users
    //            NSMutableArray *arrayOfUsersNotSubscribedTo = [NSMutableArray array];
    //
    //            for (NSString *userID in topicAssignedTo) {
    //
    //                if ([topicSubscribedTo containsObject:userID] == NO) {
    //
    //                    [arrayOfUsersNotSubscribedTo addObject:userID];
    //
    //                }
    //
    //            }
    //
    //
    //
    //            if ([arrayOfUsersNotSubscribedTo containsObject:myUserID]) {
    //                [arrayOfUsersNotSubscribedTo removeObject:myUserID];
    //            }
    //
    //
    //
    //            //Remove Users Who Are Not In Home
    //            if (RemoveUsersNotInHome == YES) {
    //
    //                BOOL HomeMemberDictIsFull = homeMembersDict[@"UserID"] && [(NSArray *)homeMembersDict[@"UserID"] count] > 0 && homeMembersDict[@"Email"] && [(NSArray *)homeMembersDict[@"Email"] count] > 0;
    //
    //                if (HomeMemberDictIsFull == YES) {
    //
    //                    for (NSString *userID in [arrayOfUsersNotSubscribedTo mutableCopy]) {
    //
    //                        NSDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:userID homeMembersDict:homeMembersDict];
    //                        NSString *email = dataDict[@"Email"];
    //
    //                        BOOL UserHasJoinedHome = [email length] > 0;
    //
    //                        if (UserHasJoinedHome == NO) {
    //                            [arrayOfUsersNotSubscribedTo removeObject:userID];
    //                        }
    //
    //                    }
    //
    //                }
    //
    //            }
    //
    //
    //
    //            NSMutableArray *arrayOfUsersNotSubscribedToPlusTopic = [arrayOfUsersNotSubscribedTo mutableCopy];
    //            [arrayOfUsersNotSubscribedToPlusTopic addObject:topicID];
    //
    //
    //
    //            return arrayOfUsersNotSubscribedToPlusTopic;
    //
    //        }
    //
    //    }
    
    return userIDArray;
}

- (NSArray *)SortArrayOfUniqueIDs:(NSArray *)inputArray {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ssSSS"];
    
    NSArray *sortedArray = [inputArray sortedArrayUsingComparator:^NSComparisonResult(NSString *str1, NSString *str2) {
        NSDate *date1 = [dateFormatter dateFromString:str1];
        NSDate *date2 = [dateFormatter dateFromString:str2];
        
        if (date1 && date2) {
            return [date1 compare:date2];
        } else {
            return [str1 compare:str2];
        }
    }];
    
    return sortedArray;
}

-(NSArray *)GenerateUniqueSubsets:(NSArray *)inputArray {
    
    inputArray = [[[NotificationsObject alloc] init] SortArrayOfUniqueIDs:inputArray];
    NSUInteger n = inputArray.count;
    
    NSMutableArray *uniqueSubsets = [NSMutableArray array];
    
    for (NSUInteger i = 1; i < (1 << n); i++) {
        NSMutableArray *subset = [NSMutableArray array];
        for (NSUInteger j = 0; j < n; j++) {
            if (i & (1 << j)) {
                [subset addObject:inputArray[j]];
            }
        }
        if (subset.count > 1 && subset.count < n) {
            [uniqueSubsets addObject:subset];
        }
    }
    
    // Sort the subsets by the number of objects in each subset
    [uniqueSubsets sortUsingComparator:^NSComparisonResult(NSArray *subset1, NSArray *subset2) {
        return subset1.count - subset2.count;
    }];
    
    // Print the sorted subsets
    return uniqueSubsets;
}

-(NSString *)GenerateTopicFromSubset:(NSArray *)subset {
    
    NSMutableString *result = [NSMutableString string];
    
    for (NSString *string in subset) {
        
        if (string.length >= 5) {
            NSString *lastFive = [string substringFromIndex:string.length - 5];
            [result appendString:lastFive];
        }
    }
    
    return result;
}

#pragma mark - Summary Notification Methods

-(NSString *)GenerateSummaryNotificationDueDateBody:(NSMutableDictionary *)dataDisplayAmountDictNo1 dataDisplayAmountDictNo2:(NSMutableDictionary *)dataDisplayAmountDictNo2 dataDisplayAmountDictNo3:(NSMutableDictionary *)dataDisplayAmountDictNo3 summaryTaskTypes:(NSMutableDictionary *)summaryTaskTypes key:(NSString *)key body:(NSString *)body {
    
    NSArray *arr = @[dataDisplayAmountDictNo1, dataDisplayAmountDictNo2, dataDisplayAmountDictNo3];
    
    if ([key isEqualToString:@"DueDates"] && summaryTaskTypes && summaryTaskTypes[@"DueDates"] && [(NSArray *)summaryTaskTypes[@"DueDates"] count] > 0) {
        
        for (NSString *dueDateToFind in summaryTaskTypes[@"DueDates"]) {
            
            NSString *key = @"";
            NSString *notificationText = @"";
            
            if ([dueDateToFind isEqualToString:@"Past Due"]) {
                key = @"Past Due";
                notificationText = @"Past Due";
            } else if ([dueDateToFind isEqualToString:@"Due Today"]) {
                key = @"Today";
                notificationText = @"Due Today";
            } else if ([dueDateToFind isEqualToString:@"Due Tomorrow"]) {
                key = @"Tomorrow";
                notificationText = @"Due Tomorrow";
            } else if ([dueDateToFind isEqualToString:@"Due Next 7 Days"]) {
                key = @"Next 7 Days";
                notificationText = @"Due In The Next 7 Days";
            }
            
            
            
            int total = 0;
            
            for (NSMutableDictionary *dictToUse in arr) {
                
                total += dictToUse[key] ? [dictToUse[key] intValue] : 0;
                
            }
            
            if (body.length == 0) {
                
                body = [NSString stringWithFormat:@"%@: %d Task%@", notificationText, total, total != 1 ? @"s" : @""];
                
            } else {
                
                body = [NSString stringWithFormat:@"%@\n%@: %d Task%@", body, notificationText, total, total != 1 ? @"s" : @""];
                
            }
            
        }
        
    }
    
    return body;
}

-(NSString *)GenerateSummaryNotificationAssignedToBody:(NSMutableDictionary *)summaryTaskTypes itemDictNo1:(NSMutableDictionary *)itemDictNo1 itemDictNo2:(NSMutableDictionary *)itemDictNo2 itemDictNo3:(NSMutableDictionary *)itemDictNo3 homeMembersDict:(NSMutableDictionary *)homeMembersDict key:(NSString *)key body:(NSString *)body {
    
    if ([key isEqualToString:@"AssignedTo"] && summaryTaskTypes && summaryTaskTypes[@"AssignedTo"] && [(NSArray *)summaryTaskTypes[@"AssignedTo"] count] > 0) {
        
        for (NSString *userID in summaryTaskTypes[@"AssignedTo"]) {
            
            if ([homeMembersDict[@"UserID"] containsObject:userID]) {
                
                NSUInteger index = homeMembersDict && homeMembersDict[@"Username"] ? [homeMembersDict[@"UserID"] indexOfObject:userID] : 0;
                NSString *username = homeMembersDict && homeMembersDict[@"Username"] && [(NSArray *)homeMembersDict[@"Username"] count] > index ? homeMembersDict[@"Username"][index] : @"";
                
                int total = 0;
                
                NSArray *arr = @[itemDictNo1, itemDictNo2, itemDictNo3];
                
                for (NSMutableDictionary *dictToUse in arr) {
                    
                    for (NSString *itemUniqueID in dictToUse[@"ItemUniqueID"]) {
                        
                        NSUInteger index = [dictToUse[@"ItemUniqueID"] indexOfObject:itemUniqueID];
                        
                        if (dictToUse && dictToUse[@"ItemAssignedTo"] && [(NSArray *)dictToUse[@"ItemAssignedTo"] count] > index && [dictToUse[@"ItemAssignedTo"][index] containsObject:userID]) {
                            
                            total += 1;
                            
                        }
                        
                    }
                    
                }
                
                if (body.length == 0) {
                    
                    body = [NSString stringWithFormat:@"%@: %d Task%@", username, total, total != 1 ? @"s" : @""];
                    
                } else {
                    
                    body = [NSString stringWithFormat:@"%@\n%@: %d Task%@", body, username, total, total != 1 ? @"s" : @""];
                    
                }
                
            }
            
        }
        
    }
    
    return body;
}

-(NSString *)GenerateSummaryNotificationColorBody:(NSMutableDictionary *)summaryTaskTypes dataDisplayDictNo1:(NSMutableDictionary *)dataDisplayDictNo1 dataDisplayDictNo2:(NSMutableDictionary *)dataDisplayDictNo2 dataDisplayDictNo3:(NSMutableDictionary *)dataDisplayDictNo3 key:(NSString *)key body:(NSString *)body {
    
    if ([key isEqualToString:@"Color"] && summaryTaskTypes && summaryTaskTypes[@"Color"] && [(NSArray *)summaryTaskTypes[@"Color"] count] > 0) {
        
        for (NSString *colorToFind in summaryTaskTypes[@"Color"]) {
            
            int total = 0;
            
            NSArray *arr = @[dataDisplayDictNo1, dataDisplayDictNo2, dataDisplayDictNo3];
            
            for (NSMutableDictionary *dictToUse in arr) {
                
                for (NSString *section in [dictToUse allKeys]) {
                    
                    if (dictToUse && dictToUse[section] && dictToUse[section][@"ItemUniqueID"]) {
                        
                        for (NSString *itemUniqueID in dictToUse[section][@"ItemUniqueID"]) {
                            
                            NSUInteger index = [dictToUse[section][@"ItemUniqueID"] indexOfObject:itemUniqueID];
                            
                            if (dictToUse && dictToUse[section] && dictToUse[section][@"ItemColor"] && [(NSArray *)dictToUse[section][@"ItemColor"] count] > index && [dictToUse[section][@"ItemColor"][index] isEqualToString:colorToFind]) {
                                
                                total += 1;
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            
            if (body.length == 0) {
                
                body = [NSString stringWithFormat:@"%@: %d Task%@", colorToFind, total, total != 1 ? @"s" : @""];
                
            } else {
                
                body = [NSString stringWithFormat:@"%@\n%@: %d Task%@", body, colorToFind, total, total != 1 ? @"s" : @""];
                
            }
            
        }
        
    }
    
    return body;
}

-(NSString *)GenerateSummaryNotificationPriorityBody:(NSMutableDictionary *)summaryTaskTypes dataDisplayDictNo1:(NSMutableDictionary *)dataDisplayDictNo1 dataDisplayDictNo2:(NSMutableDictionary *)dataDisplayDictNo2 dataDisplayDictNo3:(NSMutableDictionary *)dataDisplayDictNo3 key:(NSString *)key body:(NSString *)body {
    
    if ([key isEqualToString:@"Priority"] && summaryTaskTypes && summaryTaskTypes[@"Priority"] && [(NSArray *)summaryTaskTypes[@"Priority"] count] > 0) {
        
        for (NSString *priorityToFind in summaryTaskTypes[@"Priority"]) {
            
            int total = 0;
            
            NSArray *arr = @[dataDisplayDictNo1, dataDisplayDictNo2, dataDisplayDictNo3];
            
            for (NSMutableDictionary *dictToUse in arr) {
                
                for (NSString *section in [dictToUse allKeys]) {
                    
                    for (NSString *itemUniqueID in dictToUse[section][@"ItemUniqueID"]) {
                        
                        NSUInteger index = [dictToUse[section][@"ItemUniqueID"] indexOfObject:itemUniqueID];
                        
                        if (dictToUse && dictToUse[section] && dictToUse[section][@"ItemPriority"] && [(NSArray *)dictToUse[section][@"ItemPriority"] count] > index && [dictToUse[section][@"ItemPriority"][index] isEqualToString:priorityToFind]) {
                            
                            total += 1;
                            
                        }
                        
                    }
                    
                }
                
            }
            
            NSString *key = @"";
            
            if ([priorityToFind isEqualToString:@"High"]) {
                key = @"High Priority";
            } else if ([priorityToFind isEqualToString:@"Medium"]) {
                key = @"Medium Priority";
            } else if ([priorityToFind isEqualToString:@"Low"]) {
                key = @"Low Priority";
            } else if ([priorityToFind isEqualToString:@"No Priortiy"]) {
                key = @"No Priortiy";
            }
            
            if (body.length == 0) {
                
                body = [NSString stringWithFormat:@"%@: %d Task%@", key, total, total != 1 ? @"s" : @""];
                
            } else {
                
                body = [NSString stringWithFormat:@"%@\n%@: %d Task%@", body, key, total, total != 1 ? @"s" : @""];
                
            }
            
            
        }
        
    }
    
    return body;
}

-(NSString *)GenerateSummaryNotificationTagsBody:(NSMutableDictionary *)summaryTaskTypes dataDisplayDictNo1:(NSMutableDictionary *)dataDisplayDictNo1 dataDisplayDictNo2:(NSMutableDictionary *)dataDisplayDictNo2 dataDisplayDictNo3:(NSMutableDictionary *)dataDisplayDictNo3 key:(NSString *)key body:(NSString *)body {
    
    if ([key isEqualToString:@"Tags"] && summaryTaskTypes && summaryTaskTypes[@"Tags"] && [(NSArray *)summaryTaskTypes[@"Tags"] count] > 0) {
        
        for (NSString *tagsToFind in summaryTaskTypes[@"Tags"]) {
            
            int total = 0;
            
            NSArray *arr = @[dataDisplayDictNo1, dataDisplayDictNo2, dataDisplayDictNo3];
            
            for (NSMutableDictionary *dictToUse in arr) {
                
                for (NSString *section in [dictToUse allKeys]) {
                    
                    for (NSString *itemUniqueID in dictToUse[section][@"ItemUniqueID"]) {
                        
                        NSUInteger index = [dictToUse[section][@"ItemUniqueID"] indexOfObject:itemUniqueID];
                        
                        if (dictToUse && dictToUse[section] && dictToUse[section][@"ItemTags"] && [(NSArray *)dictToUse[section][@"ItemTags"] count] > index && [dictToUse[section][@"ItemTags"][index] containsObject:tagsToFind]) {
                            
                            total += 1;
                            
                        }
                        
                    }
                    
                }
                
            }
            
            if (body.length == 0) {
                
                body = [NSString stringWithFormat:@"#%@: %d Task%@", tagsToFind, total, total != 1 ? @"s" : @""];
                
            } else {
                
                body = [NSString stringWithFormat:@"%@\n#%@: %d Task%@", body, tagsToFind, total, total != 1 ? @"s" : @""];
                
            }
            
            
        }
        
    }
    
    return body;
}

#pragma mark - Generate Due Date Methods

-(NSString *)GenerateArrayOfRepeatingDueDates_GenerateItemTime:(NSString *)itemDays itemTime:(NSString *)itemTime itemRepeats:(NSString *)itemRepeats {
    
    BOOL TaskIsRepeating = [[[BoolDataObject alloc] init] TaskIsRepeating:[@{@"ItemRepeats" : itemRepeats} mutableCopy] itemType:@""];
    
    if ([itemDays containsString:@"Any Day"] || (TaskIsRepeating == YES && [itemTime isEqualToString:@""]) || (TaskIsRepeating == YES && [itemTime isEqualToString:@"Any Time"])) {
        itemTime = @"11:59 PM";
    }
    
    return itemTime;
}

-(NSString *)GenerateArrayOfRepeatingDueDates_GenerateItemStartDate:(NSString *)itemTime itemStartDate:(NSString *)itemStartDate {
    
    if ([itemStartDate isEqualToString:@"Now"]) {
        itemStartDate = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:@"MMMM dd, yyyy" returnAs:[NSString class]];
        itemStartDate = [NSString stringWithFormat:@"%@ 11:59 PM", itemStartDate];
    }
    
    if ([itemStartDate containsString:@"12:00 AM"]) {
        
        NSString *replaceStartDateTime = @"11:59 PM";
        
        if ([itemTime containsString:@"AM"] || [itemTime containsString:@"PM"]) {
            replaceStartDateTime = itemTime;
        }
        
        itemStartDate = [itemStartDate stringByReplacingOccurrencesOfString:@"12:00 AM" withString:replaceStartDateTime];
        
    }
    
    return itemStartDate;
}

-(BOOL)GenerateArrayOfRepeatingDueDates_RepeatingAndRepeatingIfCompletedEarly_ResetBeforeDueDatePassed:(NSString *)itemRepeats itemRepeatIfCompletedEarly:(NSString *)itemRepeatIfCompletedEarly itemDueDate:(NSString *)itemDueDate itemStartDate:(NSString *)itemStartDate itemDueDatesSkipped:(NSMutableArray *)itemDueDatesSkipped dateStringCurrent:(NSString *)dateStringCurrent dateFormat:(NSString *)dateFormat {
    
    BOOL TaskIsRepeatingAndRepeatingIfCompletedEarly = [[[BoolDataObject alloc] init] TaskIsRepeatingAndRepeatingIfCompletedEarly:[@{@"ItemRepeatIfCompletedEarly" : itemRepeatIfCompletedEarly, @"ItemRepeats" : itemRepeats} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType]];
    BOOL TaskIsRepeatingHourly = [[[BoolDataObject alloc] init] TaskIsRepeatingHourly:[@{@"ItemRepeats" : itemRepeats} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType]];
    
    NSTimeInterval secondsPassedSinceCurrentDateFromPotentialFutureDueDate = [[[GeneralObject alloc] init] GenerateTimeIntervalBetweenTwoDates:dateStringCurrent dateString2:itemDueDate dateFormat:dateFormat];
   
    BOOL ItemDueDateIsLaterThanCurrentDate = secondsPassedSinceCurrentDateFromPotentialFutureDueDate > 0;
    BOOL ItemDueDateHasBeenSkipped = [itemDueDatesSkipped containsObject:itemDueDate];
    
  
   
    if (TaskIsRepeatingAndRepeatingIfCompletedEarly == YES &&
        TaskIsRepeatingHourly == NO &&
        ItemDueDateIsLaterThanCurrentDate == YES &&
        ItemDueDateHasBeenSkipped == NO) {
        
        return YES;
        
    }
    
    return NO;
}

-(NSString *)GenerateArrayOfRepeatingDueDates_GenerateDateToBeginGeneratingDueDates:(NSString *)itemRepeats itemDatePosted:(NSString *)itemDatePosted itemDueDate:(NSString *)itemDueDate itemStartDate:(NSString *)itemStartDate itemTime:(NSString *)itemTime itemDateLastReset:(NSString *)itemDateLastReset RepeatingAndRepeatingIfCompletedEarly_ResetBeforeDueDatePassed:(BOOL)RepeatingAndRepeatingIfCompletedEarly_ResetBeforeDueDatePassed {

    BOOL ItemStartDateSelected = [[[BoolDataObject alloc] init] ItemStartDateSelected:[@{@"ItemStartDate" : itemStartDate, @"ItemRepeats" : itemRepeats} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType]];
    BOOL TaskIsRepeatingMonthly = [[[BoolDataObject alloc] init] TaskIsRepeatingMonthly:[@{@"ItemRepeats" : itemRepeats} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType]];
    
    
    
    NSString *dateToBeginGeneratingDueDates = itemDueDate;
    
    if (RepeatingAndRepeatingIfCompletedEarly_ResetBeforeDueDatePassed == YES &&
        [[[NSUserDefaults standardUserDefaults] objectForKey:@"ResetingTask"] isEqualToString:@"Yes"]) {
      
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ResetingTask"];
        
        NSString *dateFormat = @"MMMM dd, yyyy hh:mm a";
        
        dateToBeginGeneratingDueDates = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:dateFormat returnAs:[NSString class]];
        
        //Use To Test Updating Due Dates - Search this string to find sister code
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"TestDueDateIsSet"] isEqualToString:@"Yes"]) {
            dateToBeginGeneratingDueDates = [[NSUserDefaults standardUserDefaults] objectForKey:@"TestDueDate"];
        }
        
        if ([dateToBeginGeneratingDueDates containsString:@" "]) {
            
            NSArray *arr = [dateToBeginGeneratingDueDates componentsSeparatedByString:@" "];
            dateToBeginGeneratingDueDates = [arr count] > 2 ? [NSString stringWithFormat:@"%@ %@ %@ %@", arr[0], arr[1], arr[2], itemTime] : dateToBeginGeneratingDueDates;
            
        }
   
    } else if (RepeatingAndRepeatingIfCompletedEarly_ResetBeforeDueDatePassed == YES) {
        
        dateToBeginGeneratingDueDates = itemDateLastReset;
  
    }
    
    //Task Added For The First Time
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"AddingTaskForTheFirstTime1"] isEqualToString:@"Yes"]) {
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"AddingTaskForTheFirstTime1"];
        
        if (ItemStartDateSelected == YES) {
            dateToBeginGeneratingDueDates = itemStartDate;
        } else if ([[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:@"MMMM dd, yyyy hh:mm a" dateToConvert:itemDatePosted returnAs:[NSDate class]] == nil) {
            dateToBeginGeneratingDueDates = [[[GeneralObject alloc] init] GenerateDateWithConvertedFormatWithFormat:@"yyyy-MM-dd HH:mm:ss" dateToConvert:itemDatePosted newFormat:@"MMMM dd, yyyy hh:mm a" returnAs:[NSString class]];
        } else if ([[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:@"MMMM dd, yyyy hh:mm a" dateToConvert:itemDatePosted returnAs:[NSDate class]] != nil) {
            dateToBeginGeneratingDueDates = itemDatePosted;
        }
        
    }
    
    //Tasks Repeating Monthly Only Work With The Old Way Of Starting Form The Date Posted
    if (TaskIsRepeatingMonthly == YES) {
        
        if (ItemStartDateSelected == YES) {
            dateToBeginGeneratingDueDates = itemStartDate;
        } else if ([[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:@"MMMM dd, yyyy hh:mm a" dateToConvert:itemDatePosted returnAs:[NSDate class]] == nil) {
            dateToBeginGeneratingDueDates = [[[GeneralObject alloc] init] GenerateDateWithConvertedFormatWithFormat:@"yyyy-MM-dd HH:mm:ss" dateToConvert:itemDatePosted newFormat:@"MMMM dd, yyyy hh:mm a" returnAs:[NSString class]];
        } else if ([[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:@"MMMM dd, yyyy hh:mm a" dateToConvert:itemDatePosted returnAs:[NSDate class]] != nil) {
            dateToBeginGeneratingDueDates = itemDatePosted;
        }
        
    }
   
    //Backstop
    if (dateToBeginGeneratingDueDates.length == 0) {
     
        if (ItemStartDateSelected == YES) {
            dateToBeginGeneratingDueDates = itemStartDate;
        } else if ([[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:@"MMMM dd, yyyy hh:mm a" dateToConvert:itemDatePosted returnAs:[NSDate class]] == nil) {
            dateToBeginGeneratingDueDates = [[[GeneralObject alloc] init] GenerateDateWithConvertedFormatWithFormat:@"yyyy-MM-dd HH:mm:ss" dateToConvert:itemDatePosted newFormat:@"MMMM dd, yyyy hh:mm a" returnAs:[NSString class]];
        } else if ([[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:@"MMMM dd, yyyy hh:mm a" dateToConvert:itemDatePosted returnAs:[NSDate class]] != nil) {
            dateToBeginGeneratingDueDates = itemDatePosted;
        }
    }
  
    return dateToBeginGeneratingDueDates;
}

-(NSDictionary *)GenerateArrayOfRepeatingDueDates_GenerateBOOLs:(NSString *)itemRepeats itemRepeatIfCompletedEarly:(NSString *)itemRepeatIfCompletedEarly itemDatePosted:(NSString *)itemDatePosted itemDueDate:(NSString *)itemDueDate itemStartDate:(NSString *)itemStartDate itemEndDate:(NSString *)itemEndDate itemTime:(NSString *)itemTime itemDueDatesSkipped:(NSMutableArray *)itemDueDatesSkipped previousDate:(NSString *)previousDate i:(int)i dateStringCurrent:(NSString *)dateStringCurrent dateFormat:(NSString *)dateFormat {
    
    BOOL ItemStartDateSelected = [[[BoolDataObject alloc] init] ItemStartDateSelected:[@{@"ItemStartDate" : itemStartDate, @"ItemRepeats" : itemRepeats} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType]];
    BOOL ItemEndDateSelected = [[[BoolDataObject alloc] init] ItemEndDateSelected:[@{@"ItemEndDate" : itemEndDate, @"ItemRepeats" : itemRepeats} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType]];
    BOOL TaskEndIsNumberOfTimes = [[[BoolDataObject alloc] init] TaskEndIsNumberOfTimes:[@{@"ItemEndDate" : itemEndDate, @"ItemRepeats" : itemRepeats} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType]];
    BOOL ItemEndDateNumOfTimesHasPassed = NO;
    
    NSTimeInterval secondsPassedSinceCurrentDateFromPotentialFutureDueDate = [[[GeneralObject alloc] init] GenerateTimeIntervalBetweenTwoDates:dateStringCurrent dateString2:previousDate dateFormat:dateFormat];
    NSTimeInterval secondsPassedSinceStartDateFromPotentialFutureDueDate = 1;
    NSTimeInterval secondsPassedSinceEndDateFromPotentialFutureDueDate = -1;
    
    if (ItemStartDateSelected) {
        secondsPassedSinceStartDateFromPotentialFutureDueDate = [[[GeneralObject alloc] init] GenerateTimeIntervalBetweenTwoDates:itemStartDate dateString2:previousDate dateFormat:dateFormat];
    }
    
    if (ItemEndDateSelected && TaskEndIsNumberOfTimes == NO) {
        secondsPassedSinceEndDateFromPotentialFutureDueDate = [[[GeneralObject alloc] init] GenerateTimeIntervalBetweenTwoDates:itemEndDate dateString2:previousDate dateFormat:dateFormat];
    } else if (ItemEndDateSelected && TaskEndIsNumberOfTimes == YES) {
        ItemEndDateNumOfTimesHasPassed = [[[BoolDataObject alloc] init] TaskEndHasPassed:[@{@"ItemEndDate" : itemEndDate, @"ItemRepeats" : itemRepeats} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType] numberOfTaskOccurrences:i+1];
    }
    
    if ([[NSString stringWithFormat:@"%f", secondsPassedSinceStartDateFromPotentialFutureDueDate] containsString:@"nan"]) {
        secondsPassedSinceStartDateFromPotentialFutureDueDate = 1;
    }
    
    if ([[NSString stringWithFormat:@"%f", secondsPassedSinceEndDateFromPotentialFutureDueDate] containsString:@"nan"]) {
        secondsPassedSinceEndDateFromPotentialFutureDueDate = -1;
    }
    
    BOOL PotentialFutureDueDateIsLaterThanCurrentDate = secondsPassedSinceCurrentDateFromPotentialFutureDueDate > 0;
    BOOL PotentialFutureDueDateIsLaterThanStartDate = secondsPassedSinceStartDateFromPotentialFutureDueDate > 0;
    BOOL PotentialFutureDueDateIsEarlierThanEndDate = secondsPassedSinceEndDateFromPotentialFutureDueDate <= 0;
    BOOL PotentialFutureDueDateHasBeenSkipped = [itemDueDatesSkipped containsObject:previousDate];
    
    BOOL PotentialFutureDueDateIsAcceptable =
    (PotentialFutureDueDateIsLaterThanCurrentDate == YES &&
     PotentialFutureDueDateIsLaterThanStartDate == YES &&
     PotentialFutureDueDateIsEarlierThanEndDate == YES &&
     PotentialFutureDueDateHasBeenSkipped == NO &&
     ItemEndDateNumOfTimesHasPassed == NO);
    
    return @{
        @"PotentialFutureDueDateIsAcceptable" : PotentialFutureDueDateIsAcceptable ? @"Yes" : @"No",
        @"PotentialFutureDueDateIsEarlierThanEndDate" : PotentialFutureDueDateIsEarlierThanEndDate ? @"Yes" : @"No",
        @"ItemEndDateNumOfTimesHasPassed" : ItemEndDateNumOfTimesHasPassed ? @"Yes" : @"No",
        @"ItemStartDateSelected" : ItemStartDateSelected ? @"Yes" : @"No"
    };
}

#pragma mark

-(NSString *)GenerateNextHourDueDateForRepeatingTask:(NSString *)dateToBegin potentialFutureDueDate:(NSString *)potentialFutureDueDate itemDueDate:(NSString *)itemDueDate itemTime:(NSString *)itemTime itemDatePosted:(NSString *)itemDatePosted itemRepeats:(NSString *)itemRepeats itemRepeatIfCompletedEarly:(NSString *)itemRepeatIfCompletedEarly firstIteration:(BOOL)firstIteration {
    
    NSString *dateFormat = @"MMMM dd, yyyy hh:mm a";
    NSString *currentDateWithFormat = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:dateFormat returnAs:[NSString class]];
    
    NSDateFormatter *dateFormatter = [[[GeneralObject alloc] init] GenerateDateFormatWithString:dateFormat];
    
    if (dateFormatter == nil || dateFormatter == NULL) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
        [dateFormatter setCalendar:[NSCalendar currentCalendar]];
        [dateFormatter setLocale:[NSLocale currentLocale]];
        [dateFormatter setDateFormat:dateFormat];
        
    }
    
    if (currentDateWithFormat == nil || currentDateWithFormat == NULL) {
        
        NSDate *currentDate = [NSDate date];
        NSString *dateStringCurrent = [dateFormatter stringFromDate:currentDate];
        
        if (dateStringCurrent == nil || dateStringCurrent == NULL || dateStringCurrent.length == 0) {
            dateStringCurrent = @"";
        }
        
        currentDateWithFormat = dateStringCurrent;
        
    }
    
    //NSDate *currentDate = [dateFormatter dateFromString:itemDatePosted];
    NSDate *currentDate = [dateFormatter dateFromString:currentDateWithFormat];
    
    if (currentDate == NULL) {
        
        currentDate = [dateFormatter dateFromString:currentDateWithFormat];
        //currentDate = [[[[GeneralObject alloc] init] GenerateDateFormatWithString:@"yyyy-MM-dd HH:mm:ss"] dateFromString:itemDatePosted];
        
    }
    
    itemRepeats = [[[NotificationsObject alloc] init] GenerateItemRepeatWithTranslatedNewRepeatingOptions:itemRepeats];
    
    NSDate *dueDateInDateForm = [[[NotificationsObject alloc] init] GenerateDueDateToStartFrom:dateToBegin potentialFutureDueDate:potentialFutureDueDate itemRepeats:itemRepeats itemRepeatIfCompletedEarly:itemRepeatIfCompletedEarly itemDays:@"" itemDatePosted:itemDatePosted itemDueDate:itemDueDate firstIteration:firstIteration];
    
    NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
    NSString *trimmedItemTimeString = [itemTime stringByTrimmingCharactersInSet:charSet];
    
    if ([itemTime isEqualToString:@"Any Time"] || [trimmedItemTimeString isEqualToString:@""]) {
        itemTime = @"11:59 PM";
    }
    
    //Use To Test Updating Due Dates - Search this string to find sister code
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"TestDueDateIsSet"] isEqualToString:@"Yes"]) {
        currentDate = [dateFormatter dateFromString:[[NSUserDefaults standardUserDefaults] objectForKey:@"TestDueDate"]];
    }
    
    /*•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••*/
    
    //NSLog(@"testing GenerateNextDayDueDateForRepeatingTask dueDateInDateForm:%@", dueDateInDateForm);
    int hoursToAdd = [[[NotificationsObject alloc] init] GenerateHoursToAddFromFirstHoursThatHasNotPassed:currentDate dueDateInDateForm:dueDateInDateForm itemTime:itemTime itemRepeats:itemRepeats itemRepeatIfCompletedEarly:itemRepeatIfCompletedEarly firstIteration:firstIteration];
    //NSLog(@"testing GenerateNextDayDueDateForRepeatingTask firstDayAvaliable daysToAdd:%d", daysToAdd);
    hoursToAdd += [[[NotificationsObject alloc] init] GenerateHoursToAddForHourlyRepeatingIntervals:itemRepeats];
    //NSLog(@"testing GenerateNextDayDueDateForRepeatingTask addRepeatingInterval daysToAdd:%d", daysToAdd);
    hoursToAdd = [[[NotificationsObject alloc] init] GenerateDaysOrHoursToAddIfRepeatingAndRepeatingIfCompletedEarlyAndAnyDaySelected:YES Day:NO Week:NO itemRepeats:itemRepeats itemRepeatIfCompletedEarly:itemRepeatIfCompletedEarly itemDays:@"" daysToAdd:hoursToAdd firstIteration:firstIteration];
    //NSLog(@"testing GenerateNextDayDueDateForRepeatingTask addDaysForAnyDay daysToAdd:%d", daysToAdd);
    dueDateInDateForm = [[[NotificationsObject alloc] init] GenerateDueDateToAddDaysOrHoursTo:itemRepeats itemRepeatIfCompletedEarly:itemRepeatIfCompletedEarly itemDays:@"" currentDate:currentDate dueDateInDateForm:dueDateInDateForm];
    //NSLog(@"testing GenerateNextDayDueDateForRepeatingTask dueDateInDateForm(1):%@", dueDateInDateForm);
    NSDictionary *dict = [[[NotificationsObject alloc] init] GenerateDaysOrHoursToAddAndDueDateIfYouAreEditingNonDueDateAspectsOfTask:dueDateInDateForm daysToAdd:hoursToAdd dateFormatter:dateFormatter itemDueDate:itemDueDate];
    
    dueDateInDateForm = dict[@"DueDate"] ? dict[@"DueDate"] : dueDateInDateForm;
    hoursToAdd = dict[@"DaysToAdd"] ? [dict[@"DaysToAdd"] intValue] : hoursToAdd;
    //NSLog(@"testing GenerateNextDayDueDateForRepeatingTask dueDateInDateForm:%@ daysToAdd:%d", dueDateInDateForm, daysToAdd);
    NSString *dueDateToReturn = [[[NotificationsObject alloc] init] GenerateDueDateWithHoursToAddAndCorrectTime:dueDateInDateForm itemTime:itemTime hoursToAdd:hoursToAdd dateFormat:dateFormat firstIteration:firstIteration];
    
    //NSLog(@"testing GenerateNextDayDueDateForRepeatingTask dueDateToReturn:%@", dueDateToReturn);
    return dueDateToReturn;
}

-(NSString *)GenerateNextDayDueDateForRepeatingTask:(NSString *)dateToBegin potentialFutureDueDate:(NSString *)potentialFutureDueDate itemDueDate:(NSString *)itemDueDate itemTime:(NSString *)itemTime itemDatePosted:(NSString *)itemDatePosted itemRepeats:(NSString *)itemRepeats itemRepeatIfCompletedEarly:(NSString *)itemRepeatIfCompletedEarly firstIteration:(BOOL)firstIteration {
    
    NSString *dateFormat = @"MMMM dd, yyyy hh:mm a";
    NSString *currentDateWithFormat = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:dateFormat returnAs:[NSString class]];
    
    NSDateFormatter *dateFormatter = [[[GeneralObject alloc] init] GenerateDateFormatWithString:dateFormat];
    
    if (dateFormatter == nil || dateFormatter == NULL) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
        [dateFormatter setCalendar:[NSCalendar currentCalendar]];
        [dateFormatter setLocale:[NSLocale currentLocale]];
        [dateFormatter setDateFormat:dateFormat];
        
    }
    
    if (currentDateWithFormat == nil || currentDateWithFormat == NULL) {
        
        NSDate *currentDate = [NSDate date];
        NSString *dateStringCurrent = [dateFormatter stringFromDate:currentDate];
        
        if (dateStringCurrent == nil || dateStringCurrent == NULL || dateStringCurrent.length == 0) {
            dateStringCurrent = @"";
        }
        
        currentDateWithFormat = dateStringCurrent;
        
    }
    
    //NSDate *currentDate = [dateFormatter dateFromString:itemDatePosted];
    NSDate *currentDate = [dateFormatter dateFromString:currentDateWithFormat];
    
    if (currentDate == NULL) {
        
        currentDate = [dateFormatter dateFromString:currentDateWithFormat];
        //currentDate = [[[[GeneralObject alloc] init] GenerateDateFormatWithString:@"yyyy-MM-dd HH:mm:ss"] dateFromString:itemDatePosted];
        
    }
   
    itemRepeats = [[[NotificationsObject alloc] init] GenerateItemRepeatWithTranslatedNewRepeatingOptions:itemRepeats];
    
    NSDate *dueDateInDateForm = [[[NotificationsObject alloc] init] GenerateDueDateToStartFrom:dateToBegin potentialFutureDueDate:potentialFutureDueDate itemRepeats:itemRepeats itemRepeatIfCompletedEarly:itemRepeatIfCompletedEarly itemDays:@"" itemDatePosted:itemDatePosted itemDueDate:itemDueDate firstIteration:firstIteration];
   
    NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
    NSString *trimmedItemTimeString = [itemTime stringByTrimmingCharactersInSet:charSet];
    
    if ([itemTime isEqualToString:@"Any Time"] || [trimmedItemTimeString isEqualToString:@""]) {
        itemTime = @"11:59 PM";
    }
    
    
    //Use To Test Updating Due Dates - Search this string to find sister code
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"TestDueDateIsSet"] isEqualToString:@"Yes"]) {
        currentDate = [dateFormatter dateFromString:[[NSUserDefaults standardUserDefaults] objectForKey:@"TestDueDate"]];
    }
    
    /*•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••*/
    
    //NSLog(@"testing GenerateNextDayDueDateForRepeatingTask dueDateInDateForm:%@", dueDateInDateForm);
    int daysToAdd = [[[NotificationsObject alloc] init] GenerateDaysToAddFromFirstDayThatHasNotPassed:currentDate dueDateInDateForm:dueDateInDateForm itemTime:itemTime itemRepeats:itemRepeats itemRepeatIfCompletedEarly:itemRepeatIfCompletedEarly firstIteration:firstIteration];
    
    //NSLog(@"testing GenerateNextDayDueDateForRepeatingTask firstDayAvaliable daysToAdd:%d", daysToAdd);
    daysToAdd += [[[NotificationsObject alloc] init] GenerateDaysToAddForDailyRepeatingIntervals:itemRepeats];
    //NSLog(@"testing GenerateNextDayDueDateForRepeatingTask addRepeatingInterval daysToAdd:%d", daysToAdd);
   
    daysToAdd = [[[NotificationsObject alloc] init] GenerateDaysOrHoursToAddIfRepeatingAndRepeatingIfCompletedEarlyAndAnyDaySelected:NO Day:YES Week:NO itemRepeats:itemRepeats itemRepeatIfCompletedEarly:itemRepeatIfCompletedEarly itemDays:@"" daysToAdd:daysToAdd firstIteration:firstIteration];
    //NSLog(@"testing GenerateNextDayDueDateForRepeatingTask addDaysForAnyDay daysToAdd:%d", daysToAdd);
   
    dueDateInDateForm = [[[NotificationsObject alloc] init] GenerateDueDateToAddDaysOrHoursTo:itemRepeats itemRepeatIfCompletedEarly:itemRepeatIfCompletedEarly itemDays:@"" currentDate:currentDate dueDateInDateForm:dueDateInDateForm];
   
    //NSLog(@"testing GenerateNextDayDueDateForRepeatingTask dueDateInDateForm(1):%@", dueDateInDateForm);
    NSDictionary *dict = [[[NotificationsObject alloc] init] GenerateDaysOrHoursToAddAndDueDateIfYouAreEditingNonDueDateAspectsOfTask:dueDateInDateForm daysToAdd:daysToAdd dateFormatter:dateFormatter itemDueDate:itemDueDate];
    
    dueDateInDateForm = dict[@"DueDate"] ? dict[@"DueDate"] : dueDateInDateForm;
    daysToAdd = dict[@"DaysToAdd"] ? [dict[@"DaysToAdd"] intValue] : daysToAdd;
    //NSLog(@"testing GenerateNextDayDueDateForRepeatingTask dueDateInDateForm:%@ daysToAdd:%d", dueDateInDateForm, daysToAdd);
    
    NSString *dueDateToReturn = [[[NotificationsObject alloc] init] GenerateDueDateWithDaysToAddAndCorrectTime:dueDateInDateForm itemTime:itemTime daysToAdd:daysToAdd dateFormat:dateFormat firstIteration:firstIteration];
   
    //NSLog(@"testing GenerateNextDayDueDateForRepeatingTask dueDateToReturn:%@", dueDateToReturn);
    return dueDateToReturn;
}

-(NSString *)GenerateNextWeekDueDateForRepeatingTask:(NSString *)dateToBegin potentialFutureDueDate:(NSString *)potentialFutureDueDate itemDays:(NSString *)itemDays itemDueDate:(NSString *)itemDueDate itemTime:(NSString *)itemTime itemDatePosted:(NSString *)itemDatePosted itemRepeats:(NSString *)itemRepeats itemRepeatIfCompletedEarly:(NSString *)itemRepeatIfCompletedEarly firstIteration:(BOOL)firstIteration {
    
    NSString *dateFormat = @"MMMM dd, yyyy hh:mm a";
    NSString *currentDateWithFormat = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:dateFormat returnAs:[NSString class]];
    
    NSDateFormatter *dateFormatter = [[[GeneralObject alloc] init] GenerateDateFormatWithString:dateFormat];
    
    if (dateFormatter == nil || dateFormatter == NULL) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
        [dateFormatter setCalendar:[NSCalendar currentCalendar]];
        [dateFormatter setLocale:[NSLocale currentLocale]];
        [dateFormatter setDateFormat:dateFormat];
        
    }
    
    //NSDate *currentDate = [dateFormatter dateFromString:itemDatePosted];
    NSDate *currentDate = [NSDate date];
    
    if (currentDateWithFormat == nil || currentDateWithFormat == NULL) {
        
        NSDate *currentDate = [NSDate date];
        NSString *dateStringCurrent = [dateFormatter stringFromDate:currentDate];
        
        if (dateStringCurrent == nil || dateStringCurrent == NULL || dateStringCurrent.length == 0) {
            dateStringCurrent = @"";
        }
        
        currentDateWithFormat = dateStringCurrent;
        
    }
    
    //NSDate *currentDate = [dateFormatter dateFromString:itemDatePosted];
    currentDate = [dateFormatter dateFromString:currentDateWithFormat];
    
    if (currentDate == NULL) {
        
        currentDate = [dateFormatter dateFromString:currentDateWithFormat];
        //currentDate = [[[[GeneralObject alloc] init] GenerateDateFormatWithString:@"yyyy-MM-dd HH:mm:ss"] dateFromString:itemDatePosted];
        
    }
    
    itemRepeats = [[[NotificationsObject alloc] init] GenerateItemRepeatWithTranslatedNewRepeatingOptions:itemRepeats];
    
    if (currentDate == NULL) {
        
        currentDate = [dateFormatter dateFromString:[[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:dateFormat returnAs:[NSString class]]];
        //currentDate = [[[[GeneralObject alloc] init] GenerateDateFormatWithString:@"yyyy-MM-dd HH:mm:ss"] dateFromString:itemDatePosted];
        
    }
    
    itemRepeats = [[[NotificationsObject alloc] init] GenerateItemRepeatWithTranslatedNewRepeatingOptions:itemRepeats];
   
    NSDate *dueDateInDateForm = [[[NotificationsObject alloc] init] GenerateDueDateToStartFrom:dateToBegin potentialFutureDueDate:potentialFutureDueDate itemRepeats:itemRepeats itemRepeatIfCompletedEarly:itemRepeatIfCompletedEarly itemDays:itemDays itemDatePosted:itemDatePosted itemDueDate:itemDueDate firstIteration:firstIteration];
   
    NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
    NSString *trimmedItemTimeString = [itemTime stringByTrimmingCharactersInSet:charSet];
    
    if ([itemTime isEqualToString:@"Any Time"] || [trimmedItemTimeString isEqualToString:@""]) {
        itemTime = @"11:59 PM";
    }
    
    //Use To Test Updating Due Dates - Search this string to find sister code
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"TestDueDateIsSet"] isEqualToString:@"Yes"]) {
        currentDate = [dateFormatter dateFromString:[[NSUserDefaults standardUserDefaults] objectForKey:@"TestDueDate"]];
    }
    
    /*•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••*/
    
    if (itemDays.length == 0) {
        return [dateFormatter stringFromDate:dueDateInDateForm];
    }

    //NSLog(@"testing GenerateNextWeekDueDateForRepeatingTask dueDateInDateForm:%@", dueDateInDateForm);
    NSMutableArray *itemDaysInNumberFormArray = [[[NotificationsObject alloc] init] GenerateWeekDaysArray:itemDays];
   
    //NSLog(@"testing GenerateNextWeekDueDateForRepeatingTask itemDaysInNumberFormArray:%@", itemDaysInNumberFormArray);
    int daysToAdd = [[[NotificationsObject alloc] init] GenerateDaysToAddFromFirstDayThatHasNotPassedInCurrentWeekOrFirstDayInNextWeek:itemDaysInNumberFormArray dueDateInDateForm:dueDateInDateForm currentDate:currentDate itemTime:itemTime itemRepeats:itemRepeats firstIteration:firstIteration];
   
    //NSLog(@"testing GenerateNextWeekDueDateForRepeatingTask firstDayAvaliable daysToAdd:%d", daysToAdd);
    daysToAdd += [[[NotificationsObject alloc] init] GenerateDaysToAddForWeeklyRepeatingIntervals:itemRepeats itemRepeatIfCompletedEarly:itemRepeatIfCompletedEarly dueDateInDateForm:dueDateInDateForm firstIteration:firstIteration daysToAdd:daysToAdd];
   
    //NSLog(@"testing GenerateNextWeekDueDateForRepeatingTask addRepeatingInterval daysToAdd:%d", daysToAdd);
    daysToAdd = [[[NotificationsObject alloc] init] GenerateDaysOrHoursToAddIfRepeatingAndRepeatingIfCompletedEarlyAndAnyDaySelected:NO Day:NO Week:YES itemRepeats:itemRepeats itemRepeatIfCompletedEarly:itemRepeatIfCompletedEarly itemDays:itemDays daysToAdd:daysToAdd firstIteration:firstIteration];
    
    //NSLog(@"testing GenerateNextWeekDueDateForRepeatingTask addDaysForRepeatingWhenCompletedAnyDay daysToAdd:%d", daysToAdd);
    dueDateInDateForm = [[[NotificationsObject alloc] init] GenerateDueDateToAddDaysOrHoursTo:itemRepeats itemRepeatIfCompletedEarly:itemRepeatIfCompletedEarly itemDays:itemDays currentDate:currentDate dueDateInDateForm:dueDateInDateForm];
   
    //NSLog(@"testing GenerateNextWeekDueDateForRepeatingTask dueDateInDateForm:%@ currentDate:%@", dueDateInDateForm, currentDate);
    NSDictionary *dict = [[[NotificationsObject alloc] init] GenerateDaysOrHoursToAddAndDueDateIfYouAreEditingNonDueDateAspectsOfTask:dueDateInDateForm daysToAdd:daysToAdd dateFormatter:dateFormatter itemDueDate:itemDueDate];
    
    dueDateInDateForm = dict[@"DueDate"] ? dict[@"DueDate"] : dueDateInDateForm;
    daysToAdd = dict[@"DaysToAdd"] ? [dict[@"DaysToAdd"] intValue] : daysToAdd;
    
    //NSLog(@"testing GenerateNextDayDueDateForRepeatingTask dueDateInDateForm:%@ daysToAdd:%d", dueDateInDateForm, daysToAdd);
    NSString *dueDateToReturn = [[[NotificationsObject alloc] init] GenerateDueDateWithDaysToAddAndCorrectTime:dueDateInDateForm itemTime:itemTime daysToAdd:daysToAdd dateFormat:dateFormat firstIteration:firstIteration];
    //NSLog(@"testing GenerateNextWeekDueDateForRepeatingTask dueDateToReturn:%@", dueDateToReturn);
   
    return dueDateToReturn;
}

-(NSString *)GenerateNextMonthDueDateForRepeatingTask:(NSString *)dateToBegin potentialFutureDueDate:(NSString *)potentialFutureDueDate itemDays:(NSString *)itemDays itemDueDate:(NSString *)itemDueDate itemTime:(NSString *)itemTime itemDatePosted:(NSString *)itemDatePosted itemRepeats:(NSString *)itemRepeats itemRepeatIfCompletedEarly:(NSString *)itemRepeatIfCompletedEarly firstIteration:(BOOL)firstIteration {
    
    NSString *dateFormat = @"MMMM dd, yyyy hh:mm a";
    NSString *currentDateWithFormat = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:dateFormat returnAs:[NSString class]];
    
    NSDateFormatter *dateFormatter = [[[GeneralObject alloc] init] GenerateDateFormatWithString:dateFormat];
    
    if (dateFormatter == nil || dateFormatter == NULL) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
        [dateFormatter setCalendar:[NSCalendar currentCalendar]];
        [dateFormatter setLocale:[NSLocale currentLocale]];
        [dateFormatter setDateFormat:dateFormat];
        
    }
    
    if (currentDateWithFormat == nil || currentDateWithFormat == NULL) {
        
        NSDate *currentDate = [NSDate date];
        NSString *dateStringCurrent = [dateFormatter stringFromDate:currentDate];
        
        if (dateStringCurrent == nil || dateStringCurrent == NULL || dateStringCurrent.length == 0) {
            dateStringCurrent = @"";
        }
        
        currentDateWithFormat = dateStringCurrent;
        
    }
    
    //NSDate *currentDate = [dateFormatter dateFromString:itemDatePosted];
    NSDate *currentDate = [dateFormatter dateFromString:currentDateWithFormat];
    
    if (currentDate == NULL) {
        
        currentDate = [dateFormatter dateFromString:currentDateWithFormat];
        //currentDate = [[[[GeneralObject alloc] init] GenerateDateFormatWithString:@"yyyy-MM-dd HH:mm:ss"] dateFromString:itemDatePosted];
        
    }
    
    itemRepeats = [[[NotificationsObject alloc] init] GenerateItemRepeatWithTranslatedNewRepeatingOptions:itemRepeats];
   
    NSDate *dueDateInDateForm = [[[NotificationsObject alloc] init] GenerateDueDateToStartFrom:dateToBegin potentialFutureDueDate:potentialFutureDueDate itemRepeats:itemRepeats itemRepeatIfCompletedEarly:itemRepeatIfCompletedEarly itemDays:itemDays itemDatePosted:itemDatePosted itemDueDate:itemDueDate firstIteration:firstIteration];
    
    NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
    NSString *trimmedItemTimeString = [itemTime stringByTrimmingCharactersInSet:charSet];
    
    if ([itemTime isEqualToString:@"Any Time"] || [trimmedItemTimeString isEqualToString:@""]) {
        itemTime = @"11:59 PM";
    }
    
    //Use To Test Updating Due Dates - Search this string to find sister code
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"TestDueDateIsSet"] isEqualToString:@"Yes"]) {
        currentDate = [dateFormatter dateFromString:[[NSUserDefaults standardUserDefaults] objectForKey:@"TestDueDate"]];
    }
    
    /*•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••*/
    
    if (itemDays.length == 0) {
        return [dateFormatter stringFromDate:dueDateInDateForm];
    }
  
    //NSLog(@"testing1 GenerateNextMonthDueDateForRepeatingTask dueDateInDateForm:%@", dueDateInDateForm);
    NSDictionary *dict = [[[NotificationsObject alloc] init] GenerateDayArray:itemDays];
    
    NSString *monthDaysArray = dict[@"MonthDays"] ? dict[@"MonthDays"] : @"";
    NSString *monthWeekdaysArray = dict[@"MonthWeekdays"] ? dict[@"MonthWeekdays"] : @"";
    //NSLog(@"testing2 GenerateNextMonthDueDateForRepeatingTask monthDaysArray:%@", monthDaysArray);
    //NSLog(@"testing3 GenerateNextMonthDueDateForRepeatingTask monthWeekdaysArray:%@", monthWeekdaysArray);
    NSMutableArray *arrayOfFutureDueDates = [[[NotificationsObject alloc] init] GenerateFutureDueDatesArray:monthWeekdaysArray itemTime:itemTime itemRepeats:itemRepeats dueDateInDateForm:dueDateInDateForm currentDate:currentDate dateFormatter:dateFormatter firstIteration:firstIteration];
    //NSLog(@"testing4 GenerateNextMonthDueDateForRepeatingTask GenerateFutureDueDatesArrayForMonthWeekdays arrayOfFutureDueDates:%@", arrayOfFutureDueDates);
   
    NSString *futureDueDateForMonthDays = [[[NotificationsObject alloc] init] GenerateNextMonthDueDateForRepeatingTaskForMonthDays:dateToBegin potentialFutureDueDate:potentialFutureDueDate itemDays:monthDaysArray itemDueDate:itemDueDate itemTime:itemTime itemDatePosted:itemDatePosted itemRepeats:itemRepeats itemRepeatIfCompletedEarly:itemRepeatIfCompletedEarly firstIteration:firstIteration];
   
    //NSLog(@"testing5 GenerateNextMonthDueDateForRepeatingTask GenerateNextMonthDueDateForRepeatingTaskForMonthDays futureDueDate:%@", futureDueDateForMonthDays);
    if (futureDueDateForMonthDays != nil && futureDueDateForMonthDays != NULL && futureDueDateForMonthDays.length > 0) {
        [arrayOfFutureDueDates addObject:futureDueDateForMonthDays];
    }
    
    //NSLog(@"testing6 GenerateNextMonthDueDateForRepeatingTask GenerateNextMonthDueDateForRepeatingTaskForMonthDays arrayOfFutureDueDates:%@", arrayOfFutureDueDates);
    arrayOfFutureDueDates = [[[GeneralObject alloc] init] SortArrayOfDates:arrayOfFutureDueDates dateFormatString:@"MMMM dd, yyyy hh:mm a"];
   
    //NSLog(@"testing7 GenerateNextMonthDueDateForRepeatingTask SortArrayOfDates arrayOfFutureDueDates:%@", arrayOfFutureDueDates);
    NSString *dueDateToReturn = [[[NotificationsObject alloc] init] GenerateFutureMonthDueDateToReturn:itemDueDate itemTime:itemTime dueDateInDateForm:dueDateInDateForm currentDate:currentDate arrayOfFutureDueDates:arrayOfFutureDueDates dateFormat:dateFormat firstIteration:firstIteration];
   
    //NSLog(@"testing8 GenerateNextMonthDueDateForRepeatingTask GenerateFutureMonthDueDateToReturnForMonthDaysAndMonthWeekdays dueDateToReturn:%@", dueDateToReturn);
    return dueDateToReturn;
}

-(NSString *)GenerateNextMonthDueDateForRepeatingTaskForMonthDays:(NSString *)dateToBegin potentialFutureDueDate:(NSString *)potentialFutureDueDate itemDays:(NSString *)itemDays itemDueDate:(NSString *)itemDueDate itemTime:(NSString *)itemTime itemDatePosted:(NSString *)itemDatePosted itemRepeats:(NSString *)itemRepeats itemRepeatIfCompletedEarly:(NSString *)itemRepeatIfCompletedEarly firstIteration:(BOOL)firstIteration {
    
    NSString *dateFormat = @"MMMM dd, yyyy hh:mm a";
    NSString *currentDateWithFormat = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:dateFormat returnAs:[NSString class]];
    
    NSDateFormatter *dateFormatter = [[[GeneralObject alloc] init] GenerateDateFormatWithString:dateFormat];
    
    if (dateFormatter == nil || dateFormatter == NULL) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
        [dateFormatter setCalendar:[NSCalendar currentCalendar]];
        [dateFormatter setLocale:[NSLocale currentLocale]];
        [dateFormatter setDateFormat:dateFormat];
        
    }
    
    if (currentDateWithFormat == nil || currentDateWithFormat == NULL) {
        
        NSDate *currentDate = [NSDate date];
        NSString *dateStringCurrent = [dateFormatter stringFromDate:currentDate];
        
        if (dateStringCurrent == nil || dateStringCurrent == NULL || dateStringCurrent.length == 0) {
            dateStringCurrent = @"";
        }
        
        currentDateWithFormat = dateStringCurrent;
        
    }
    
    //NSDate *currentDate = [dateFormatter dateFromString:itemDatePosted];
    NSDate *currentDate = [dateFormatter dateFromString:currentDateWithFormat];
    
    if (currentDate == NULL) {
        
        currentDate = [dateFormatter dateFromString:currentDateWithFormat];
        //currentDate = [[[[GeneralObject alloc] init] GenerateDateFormatWithString:@"yyyy-MM-dd HH:mm:ss"] dateFromString:itemDatePosted];
        
    }
   
    NSDate *dueDateInDateForm = [[[NotificationsObject alloc] init] GenerateDueDateToStartFrom:dateToBegin potentialFutureDueDate:potentialFutureDueDate itemRepeats:itemRepeats itemRepeatIfCompletedEarly:itemRepeatIfCompletedEarly itemDays:itemDays itemDatePosted:itemDatePosted itemDueDate:itemDueDate firstIteration:firstIteration];
   
    NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
    NSString *trimmedItemTimeString = [itemTime stringByTrimmingCharactersInSet:charSet];
    
    if ([itemTime isEqualToString:@"Any Time"] || [trimmedItemTimeString isEqualToString:@""]) {
        itemTime = @"11:59 PM";
    }
    
    //Use To Test Updating Due Dates - Search this string to find sister code
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"TestDueDateIsSet"] isEqualToString:@"Yes"]) {
        currentDate = [dateFormatter dateFromString:[[NSUserDefaults standardUserDefaults] objectForKey:@"TestDueDate"]];
    }
    
    /*•••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••••*/
    
    if (itemDays.length == 0) {
        return [dateFormatter stringFromDate:dueDateInDateForm];
    }
    //NSLog(@"testing4.1 GenerateNextMonthDueDateForRepeatingTask dueDateInDateForm:%@ itemDays:%@", dueDateInDateForm, itemDays);
    NSMutableArray *itemDaysInNumberFormArray = [[[NotificationsObject alloc] init] GenerateMonthDaysArray:itemDays firstIteration:firstIteration];
    //NSLog(@"testing4.2 GenerateNextMonthDueDateForRepeatingTask itemDaysInNumberFormArray:%@", itemDaysInNumberFormArray);
    
    //(2,3,4) If Repeat When Completed And Any Day Get the Current Date, Add The Number Of Days In The Current Date Month To The Current Date, Update The Time
    //(1,4) Else Find Next Available Due Date, Update The Time
   
    //1. Find Next Available Due Date
    dueDateInDateForm = [[[NotificationsObject alloc] init] GenerateDueDateFromFirstDayThatHasNotPassedInCurrentMonthOrFirstDayInNextMonth:itemRepeats itemDaysInNumberFormArray:itemDaysInNumberFormArray dueDateInDateForm:dueDateInDateForm currentDate:currentDate itemTime:itemTime firstIteration:firstIteration];
   
    //NSLog(@"testing4.4 GenerateNextMonthDueDateForRepeatingTask dueDateInDateForm:%@", dueDateInDateForm);
    //2. If Repeat When Completed And Any Day, Due Date Is Now Current Date
    //   Else Nothing Changes
    dueDateInDateForm = [[[NotificationsObject alloc] init] GenerateDueDateToAddDaysOrHoursTo:itemRepeats itemRepeatIfCompletedEarly:itemRepeatIfCompletedEarly itemDays:itemDays currentDate:currentDate dueDateInDateForm:dueDateInDateForm];
   
    int daysToAdd = 0;
  
    //NSLog(@"testing4.6 GenerateNextMonthDueDateForRepeatingTask daysToAdd:%d", daysToAdd);
    NSDictionary *dict = [[[NotificationsObject alloc] init] GenerateDaysOrHoursToAddAndDueDateIfYouAreEditingNonDueDateAspectsOfTask:dueDateInDateForm daysToAdd:daysToAdd dateFormatter:dateFormatter itemDueDate:itemDueDate];
   
    dueDateInDateForm = dict[@"DueDate"] ? dict[@"DueDate"] : dueDateInDateForm;
    daysToAdd = dict[@"DaysToAdd"] ? [dict[@"DaysToAdd"] intValue] : daysToAdd;
    //NSLog(@"testing4.7 GenerateNextDayDueDateForRepeatingTask dueDateInDateForm:%@ daysToAdd:%d", dueDateInDateForm, daysToAdd);
    //3. If Repeat When Completed And Any Day, Add The Amount Of Days To The Current Date Month And Replace The Time
    //   Else Nothing Changes Just Replace The Time
    NSString *dueDateToReturn = [[[NotificationsObject alloc] init] GenerateDueDateWithDaysToAddAndCorrectTime:dueDateInDateForm itemTime:itemTime daysToAdd:daysToAdd dateFormat:dateFormat firstIteration:firstIteration];
    //NSLog(@"testing4.8 GenerateNextMonthDueDateForRepeatingTask dueDateToReturn:%@", dueDateToReturn);
  
    return dueDateToReturn;
}

#pragma mark - Notification Types

-(NSString *)NotificationSettingsChores_Adding:(BOOL)Adding Editing:(BOOL)Editing Deleting:(BOOL)Deleting Duplicating:(BOOL)Duplicating Waiving:(BOOL)Waiving Skipping:(BOOL)Skipping Pausing:(BOOL)Pausing Comments:(BOOL)Comments
                                  SkippingTurn:(BOOL)SkippingTurn RemovingUser:(BOOL)RemovingUser
                                FullyCompleted:(BOOL)FullyCompleted Completed:(BOOL)Completed InProgress:(BOOL)InProgress WontDo:(BOOL)WontDo Accept:(BOOL)Accept Decline:(BOOL)Decline
                                       DueDate:(BOOL)DueDate Reminder:(BOOL)Reminder
                                SubtaskEditing:(BOOL)SubtaskEditing SubtaskDeleting:(BOOL)SubtaskDeleting
                              SubtaskCompleted:(BOOL)SubtaskCompleted SubtaskInProgress:(BOOL)SubtaskInProgress SubtaskWontDo:(BOOL)SubtaskWontDo SubtaskAccept:(BOOL)SubtaskAccept SubtaskDecline:(BOOL)SubtaskDecline {
    
    NSString *notificationType = @"";
    
    if (Adding) {
        
        notificationType = @"Adding";
        
    } else if (Editing) {
        
        notificationType = @"Editing";
        
    } else if (Deleting) {
        
        notificationType = @"Deleting";
        
    } else if (Duplicating) {
        
        notificationType = @"Duplicating";
        
    } else if (Waiving) {
        
        notificationType = @"Waiving";
        
    } else if (Skipping) {
        
        notificationType = @"Skipping";
        
    } else if (Pausing) {
        
        notificationType = @"Pausing/Unpausing";
        
    } else if (Comments) {
        
        notificationType = @"Comments";
        
    }
    
    else if (SkippingTurn) {
        
        notificationType = @"SkippingTurn";
        
    } else if (RemovingUser) {
        
        notificationType = @"RemovingUser";
        
    }
    
    else if (FullyCompleted) {
        
        notificationType = @"FullyCompleted";
        
    } else if (Completed) {
        
        notificationType = @"Completed";
        
    } else if (InProgress) {
        
        notificationType = @"InProgress";
        
    } else if (WontDo) {
        
        notificationType = @"WontDo";
        
    } else if (Accept) {
        
        notificationType = @"Accept";
        
    } else if (Decline) {
        
        notificationType = @"Decline";
        
    }
    
    else if (DueDate) {
        
        notificationType = @"DueDate";
        
    } else if (Reminder) {
        
        notificationType = @"Reminder";
        
    }
    
    else if (SubtaskEditing) {
        
        notificationType = @"SubtaskEditing";
        
    } else if (SubtaskDeleting) {
        
        notificationType = @"SubtaskDeleting";
        
    }
    
    else if (SubtaskCompleted) {
        
        notificationType = @"SubtaskCompleted";
        
    } else if (SubtaskInProgress) {
        
        notificationType = @"SubtaskInProgress";
        
    } else if (SubtaskAccept) {
        
        notificationType = @"SubtaskAccept";
        
    } else if (SubtaskDecline) {
        
        notificationType = @"SubtaskDecline";
        
    } else if (SubtaskWontDo) {
        
        notificationType = @"SubtaskWontDo";
        
    }
    
    return notificationType;
}

-(NSString *)NotificationSettingsExpenses_Adding:(BOOL)Adding Editing:(BOOL)Editing Deleting:(BOOL)Deleting Duplicating:(BOOL)Duplicating Waiving:(BOOL)Waiving Skipping:(BOOL)Skipping Pausing:(BOOL)Pausing Comments:(BOOL)Comments
                                    SkippingTurn:(BOOL)SkippingTurn RemovingUser:(BOOL)RemovingUser
                                  FullyCompleted:(BOOL)FullyCompleted Completed:(BOOL)Completed InProgress:(BOOL)InProgress WontDo:(BOOL)WontDo Accept:(BOOL)Accept Decline:(BOOL)Decline
                                         DueDate:(BOOL)DueDate Reminder:(BOOL)Reminder
                             EditingItemizedItem:(BOOL)EditingItemizedItem DeletingItemizedItem:(BOOL)DeletingItemizedItem{
    
    NSString *notificationType = @"";
    
    if (Adding) {
        
        notificationType = @"Adding";
        
    } else if (Editing) {
        
        notificationType = @"Editing";
        
    } else if (Deleting) {
        
        notificationType = @"Deleting";
        
    } else if (Duplicating) {
        
        notificationType = @"Duplicating";
        
    } else if (Waiving) {
        
        notificationType = @"Waiving";
        
    } else if (Skipping) {
        
        notificationType = @"Skipping";
        
    } else if (Pausing) {
        
        notificationType = @"Pausing/Unpausing";
        
    } else if (Comments) {
        
        notificationType = @"Comments";
        
    }
    
    else if (SkippingTurn) {
        
        notificationType = @"SkippingTurn";
        
    } else if (RemovingUser) {
        
        notificationType = @"RemovingUser";
        
    }
    
    else if (FullyCompleted) {
        
        notificationType = @"FullyCompleted";
        
    } else if (Completed) {
        
        notificationType = @"Completed";
        
    } else if (InProgress) {
        
        notificationType = @"InProgress";
        
    } else if (WontDo) {
        
        notificationType = @"WontDo";
        
    } else if (Accept) {
        
        notificationType = @"Accept";
        
    } else if (Decline) {
        
        notificationType = @"Decline";
        
    }
    
    else if (DueDate) {
        
        notificationType = @"DueDate";
        
    } else if (Reminder) {
        
        notificationType = @"Reminder";
        
    }
    
    else if (EditingItemizedItem) {
        
        notificationType = @"EditingItemizedItem";
        
    } else if (DeletingItemizedItem) {
        
        notificationType = @"DeletingItemizedItem";
        
    }
    
    return notificationType;
}

-(NSString *)NotificationSettingsLists_Adding:(BOOL)Adding Editing:(BOOL)Editing Deleting:(BOOL)Deleting Duplicating:(BOOL)Duplicating Waiving:(BOOL)Waiving Skipping:(BOOL)Skipping Pausing:(BOOL)Pausing Comments:(BOOL)Comments
                               FullyCompleted:(BOOL)FullyCompleted Completed:(BOOL)Completed InProgress:(BOOL)InProgress WontDo:(BOOL)WontDo Accept:(BOOL)Accept Decline:(BOOL)Decline
                                      DueDate:(BOOL)DueDate Reminder:(BOOL)Reminder
                               AddingListItem:(BOOL)AddingListItem EditingListItem:(BOOL)EditingListItem DeletingListItem:(BOOL)DeletingListItem ResetingListItem:(BOOL)ResetingListItem {
    
    NSString *notificationType = @"";
    
    if (Adding) {
        
        notificationType = @"Adding";
        
    } else if (Editing) {
        
        notificationType = @"Editing";
        
    } else if (Deleting) {
        
        notificationType = @"Deleting";
        
    } else if (Duplicating) {
        
        notificationType = @"Duplicating";
        
    } else if (Waiving) {
        
        notificationType = @"Waiving";
        
    } else if (Skipping) {
        
        notificationType = @"Skipping";
        
    } else if (Pausing) {
        
        notificationType = @"Pausing/Unpausing";
        
    } else if (Comments) {
        
        notificationType = @"Comments";
        
    }
    
    else if (FullyCompleted) {
        
        notificationType = @"FullyCompleted";
        
    } else if (Completed) {
        
        notificationType = @"Completed";
        
    } else if (InProgress) {
        
        notificationType = @"InProgress";
        
    } else if (WontDo) {
        
        notificationType = @"WontDo";
        
    } else if (Accept) {
        
        notificationType = @"Accept";
        
    } else if (Decline) {
        
        notificationType = @"Decline";
        
    }
    
    else if (DueDate) {
        
        notificationType = @"DueDate";
        
    } else if (Reminder) {
        
        notificationType = @"Reminder";
        
    }
    
    else if (AddingListItem) {
        
        notificationType = @"AddingListItem";
        
    } else if (EditingListItem) {
        
        notificationType = @"EditingListItem";
        
    } else if (DeletingListItem) {
        
        notificationType = @"DeletingListItem";
        
    } else if (ResetingListItem) {
        
        notificationType = @"ResetingListItem";
        
    }
    
    return notificationType;
}

-(NSString *)NotificationSettingsGroupChats_Adding:(BOOL)Adding Editing:(BOOL)Editing Deleting:(BOOL)Deleting
                                 GroupChatMessages:(BOOL)GroupChatMessages LiveSupportMessages:(BOOL)LiveSupportMessages {
    
    NSString *notificationType = @"";
    
    if (Adding) {
        
        notificationType = @"Adding";
        
    } else if (Editing) {
        
        notificationType = @"Editing";
        
    } else if (Deleting) {
        
        notificationType = @"Deleting";
        
    }
    
    else if (GroupChatMessages) {
        
        notificationType = @"GroupChatMessages";
        
    } else if (LiveSupportMessages) {
        
        notificationType = @"LiveSupportMessages";
        
    }
    
    return notificationType;
}

-(NSString *)NotificationSettingsHomeMembers_SendingInvitations:(BOOL)SendingInvitations DeletingInvitations:(BOOL)DeletingInvitations
                                                 NewHomeMembers:(BOOL)NewHomeMembers HomeMembersMovedOut:(BOOL)HomeMembersMovedOut HomeMembersKickedOut:(BOOL)HomeMembersKickedOut {
    
    NSString *notificationType = @"";
    
    if (SendingInvitations) {
        
        notificationType = @"SendingInvitations";
        
    } else if (DeletingInvitations) {
        
        notificationType = @"DeletingInvitations";
        
    }
    
    else if (NewHomeMembers) {
        
        notificationType = @"NewHomeMembers";
        
    } else if (HomeMembersMovedOut) {
        
        notificationType = @"HomeMembersMovedOut";
        
    } else if (HomeMembersKickedOut) {
        
        notificationType = @"HomeMembersKickedOut";
        
    }
    
    return notificationType;
}

-(NSString *)NotificationSettingsForum_FeatureForumUpvotes:(BOOL)BugForumUpvotes FeatureForumUpvotes:(BOOL)FeatureForumUpvotes {
    
    NSString *notificationType = @"";
    
    if (BugForumUpvotes) {
        
        notificationType = @"BugForumUpvotes";
        
    } else if (FeatureForumUpvotes) {
        
        notificationType = @"FeatureForumUpvotes";
        
    }
    
    return notificationType;
}

#pragma mark - Inactive Notification

-(int)GenerateInactiveNotificationSettings:(int)notificationSeconds {
    
    if (notificationSeconds < 691200) {
        return notificationSeconds;
    }
    
    NSString *dateFormat = @"MMMM dd, yyyy hh:mm a";
    NSString *currentDateString = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:dateFormat returnAs:[NSString class]];
    
    NSArray *randomHourObjectsArr = @[@"5", @"6"];
    NSMutableArray *randomMinuteObjectsArr = [NSMutableArray array];
    
    uint32_t rnd = arc4random_uniform((uint32_t)[randomHourObjectsArr count]);
    NSString *randomHourObject = [randomHourObjectsArr objectAtIndex:rnd];
    
    int startingMin = [randomHourObject isEqualToString:@"5"] ? 30 : 01;
    int endingMin = [randomHourObject isEqualToString:@"5"] ? 59 : 45;
    
    for (int i=startingMin;i<endingMin;i++) {
        [randomMinuteObjectsArr addObject:[NSString stringWithFormat:@"%d", i]];
    }
    
    NSString *randomMinuteObject = [randomMinuteObjectsArr objectAtIndex:rnd];
    
    NSString *AMPM;
    
    //    if ([randomHourObject isEqualToString:@"10"] || [randomHourObject isEqualToString:@"11"]) {
    //        AMPM = @"AM";
    //    } else {
    AMPM = @"PM";
    //    }
    
    NSString *time = [NSString stringWithFormat:@"%@:%@ %@", randomHourObject, randomMinuteObject, AMPM];
    
    NSMutableArray *allDueDatesArray = [[[NotificationsObject alloc] init] GenerateArrayOfRepeatingDueDates:@"Weekly" itemRepeatIfCompletedEarly:@"No" itemCompleteAsNeeded:@"No" totalAmountOfFutureDates:10 maxAmountOfDueDatesToLoopThrough:1000 itemDatePosted:currentDateString itemDueDate:@"" itemStartDate:currentDateString itemEndDate:@"Never" itemTime:time itemDays:@"Saturday, Sunday, Tuesday" itemDueDatesSkipped:[NSMutableArray array] itemDateLastReset:@"" SkipStartDate:NO];
    
    for (NSString *date in allDueDatesArray) {
        
        NSTimeInterval seconds = [[[GeneralObject alloc] init] GenerateTimeIntervalBetweenTwoDates:currentDateString dateString2:date dateFormat:dateFormat];
        
        if (seconds > 691199) {
            
            notificationSeconds = seconds;
            break;
            
        }
        
    }
    
    return notificationSeconds;
    
}

-(void)GenerateTwoWeekReminderNotificationTitle:(void (^)(BOOL finished, NSString *notificationTitleReturning, NSString *notificationBodyResults, int GenerateNotificationSeconds))finishBlock {
    
    __weak typeof (self) weakSelf = self;
    
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
    
    __block NSString *notificationTitle = @"";
    __block NSString *notificationBody = @"";
    __block int GenerateNotificationSeconds = 691200;
    
    NSMutableArray *totalUserIDArray = [NSMutableArray array];
    
    if (userID) {
        [totalUserIDArray addObject:userID];
    } else {
        [totalUserIDArray addObject:@"null"];
    }
    
    if ([totalUserIDArray containsObject:@"null"] == NO) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [[[GetDataObject alloc] init] GetDataHomesUserIdMemberOfSnapshot:userID completionHandler:^(BOOL finished, FIRQuerySnapshot * _Nonnull firstSnapshot) {
                
                @synchronized (firstSnapshot) {
                    
                    NSMutableDictionary *numberOfHomesDict = [NSMutableDictionary dictionary];
                    NSMutableDictionary *homeNamesDict = [NSMutableDictionary dictionary];
                    NSMutableDictionary *homeIDsDict = [NSMutableDictionary dictionary];
                    NSMutableDictionary *homeMembersDict = [NSMutableDictionary dictionary];
                    NSMutableDictionary *homeKeysDict = [NSMutableDictionary dictionary];
                    NSMutableDictionary *homeMembersUncalaimedDict = [NSMutableDictionary dictionary];
                    
                    for (NSString *userID in totalUserIDArray) {
                        [numberOfHomesDict setObject:@"0" forKey:userID];
                    }
                    for (NSString *userID in totalUserIDArray) {
                        [homeNamesDict setObject:@"" forKey:userID];
                    }
                    for (NSString *userID in totalUserIDArray) {
                        [homeIDsDict setObject:@"" forKey:userID];
                    }
                    for (NSString *userID in totalUserIDArray) {
                        [homeMembersDict setObject:@"0" forKey:userID];
                    }
                    for (NSString *userID in totalUserIDArray) {
                        [homeKeysDict setObject:@"0" forKey:userID];
                    }
                    for (NSString *userID in totalUserIDArray) {
                        [homeMembersUncalaimedDict setObject:@"0" forKey:userID];
                    }
                    
                    for (FIRDocumentSnapshot *firstDoc in firstSnapshot.documents) {
                        
                        @synchronized (firstDoc) {
                            
                            for (NSString *firstUserID in totalUserIDArray) {
                                
                                int numberOfHomes = numberOfHomesDict[firstUserID] ? [numberOfHomesDict[firstUserID] intValue] : 0;
                                NSString *homeName = homeNamesDict[firstUserID] ? homeNamesDict[firstUserID] : @"";
                                
                                NSString *docHomeID = firstDoc.data[@"HomeID"] ? firstDoc.data[@"HomeID"] : @"xxx";
                                NSString *docHomeName = firstDoc.data[@"HomeName"] ? firstDoc.data[@"HomeName"] : @"";
                                NSMutableArray *docHomeMembers = firstDoc.data[@"HomeMembers"] ? [firstDoc.data[@"HomeMembers"] mutableCopy] : [NSMutableArray array];
                                NSMutableDictionary *docHomeKeys = firstDoc.data[@"HomeKeys"] ? [firstDoc.data[@"HomeKeys"] mutableCopy] : [NSMutableDictionary dictionary];
                                NSMutableDictionary *docHomeMembersUnclaimed = firstDoc.data[@"HomeMembersUnclaimed"] ? [firstDoc.data[@"HomeMembersUnclaimed"] mutableCopy] : [NSMutableDictionary dictionary];
                                
                                if ([docHomeMembers containsObject:firstUserID]) {
                                    
                                    numberOfHomes += 1;
                                    
                                    [numberOfHomesDict setObject:[NSString stringWithFormat:@"%d", numberOfHomes] forKey:firstUserID];
                                    
                                    if (homeName.length > 0) {
                                        
                                        [homeNamesDict setObject:[NSString stringWithFormat:@"%@,%@", homeName, docHomeName] forKey:firstUserID];
                                        
                                    } else {
                                        
                                        [homeNamesDict setObject:[NSString stringWithFormat:@"%@", docHomeName] forKey:firstUserID];
                                        
                                    }
                                    
                                    [homeIDsDict setObject:[NSString stringWithFormat:@"%@", docHomeID] forKey:firstUserID];
                                    
                                    [homeMembersDict setObject:[NSString stringWithFormat:@"%lu", (unsigned long)[docHomeMembers count]] forKey:firstUserID];
                                    
                                    if ([docHomeKeys isMemberOfClass:[NSMutableDictionary class]] || [docHomeKeys isMemberOfClass:[NSDictionary class]]) {
                                        
                                        [homeKeysDict setObject:[NSString stringWithFormat:@"%lu", (unsigned long)[[docHomeKeys allKeys] count]] forKey:firstUserID];
                                        
                                    } else {
                                        
                                        [homeKeysDict setObject:[NSString stringWithFormat:@"%lu", (unsigned long)[docHomeKeys count]] forKey:firstUserID];
                                        
                                    }
                                    
                                    if ([docHomeMembersUnclaimed isMemberOfClass:[NSMutableDictionary class]] || [docHomeMembersUnclaimed isMemberOfClass:[NSDictionary class]]) {
                                        
                                        [homeMembersUncalaimedDict setObject:[NSString stringWithFormat:@"%lu", (unsigned long)[[docHomeMembersUnclaimed allKeys] count]] forKey:firstUserID];
                                        
                                    } else {
                                        
                                        [homeMembersUncalaimedDict setObject:[NSString stringWithFormat:@"%lu", (unsigned long)[docHomeMembersUnclaimed count]] forKey:firstUserID];
                                        
                                    }
                                    
                                }
                                
                            }
                            
                        }
                        //Just Get First Home
                        break;
                    }
                    
                    for (NSString *secondUserID in totalUserIDArray) {
                        
                        NSString *numberOfHomesPerUser = numberOfHomesDict[secondUserID] ? numberOfHomesDict[secondUserID] : @"";
                        NSString *numberOfHomesMembersPerUser = homeMembersDict[secondUserID] ? homeMembersDict[secondUserID] : @"";
                        //NSString *numberOfHomesKeysPerUser = homeKeysDict[secondUserID] ? homeKeysDict[secondUserID] : @"";
                        NSString *numberOfHomesMembersUnclaimedPerUser = homeMembersUncalaimedDict[secondUserID] ? homeMembersUncalaimedDict[secondUserID] : @"";
                        NSString *homeNamePerUser = homeNamesDict[secondUserID] ? homeNamesDict[secondUserID] : @"";
                        NSString *homeIDPerUser = homeIDsDict[secondUserID] ? homeIDsDict[secondUserID] : @"";
                        
                        if ([numberOfHomesPerUser isEqualToString:@"0"] && ![[NSUserDefaults standardUserDefaults] objectForKey:@"InactiveNotif(1)"]) {
                            
                            notificationTitle = @"Tired of work not getting done? 😓";
                            notificationBody = @"Try scheduling some chores, expenses, and to-do lists! 🏠";
                            GenerateNotificationSeconds = 86400;
                            
                            [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"InactiveNotif(1)"];
                            
                            finishBlock(YES, notificationTitle, notificationBody, GenerateNotificationSeconds);
                            
                        } else if ([numberOfHomesPerUser isEqualToString:@"1"] && [numberOfHomesMembersPerUser intValue] <= 1 && [numberOfHomesMembersUnclaimedPerUser intValue] == 0 && ![[NSUserDefaults standardUserDefaults] objectForKey:@"InactiveNotif(2)"]) {
                            
                            NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
                            NSString *trimmedString = [homeNamePerUser stringByTrimmingCharactersInSet:charSet];
                            
                            notificationTitle = [NSString stringWithFormat:@"Don't forget your home members. 😄"];
                            notificationBody = [NSString stringWithFormat:@"Invite everyone to \"%@\" and get the party started! 💌🥳", trimmedString];
                            GenerateNotificationSeconds = 3600;
                            
                            [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"InactiveNotif(2)"];
                            
                            finishBlock(YES, notificationTitle, notificationBody, GenerateNotificationSeconds);
                            //
                            //                        } else if ([numberOfHomesPerUser isEqualToString:@"1"] && [numberOfHomesMembersUnclaimedPerUser intValue] > 0 && [numberOfHomesKeysPerUser intValue] > 0 && ![[NSUserDefaults standardUserDefaults] objectForKey:@"InactiveNotif(3)"]) {
                            //
                            //                            NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
                            //                            NSString *trimmedString = [homeNamePerUser stringByTrimmingCharactersInSet:charSet];
                            //
                            //                            notificationTitle = [NSString stringWithFormat:@"Your peeps haven't joined your home yet 😓"];
                            //                            notificationBody = [NSString stringWithFormat:@"\"%@\" is still empty! A quick reminder hever hurt anyone. 😄🔔", trimmedString];
                            //                            GenerateNotificationSeconds = 86400;
                            //                            [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"InactiveNotif(3)"];
                            //
                            //                            finishBlock(YES, notificationTitle, notificationBody, GenerateNotificationSeconds);
                            
                        } else if (([numberOfHomesPerUser isEqualToString:@"1"] && [numberOfHomesMembersPerUser intValue] > 1) || ([numberOfHomesPerUser intValue] > 1)) {
                            
                            __block int GenerateNotificationSeconds = 691200;
                            
                            __block NSString *firstAttemptTitle = @"";
                            __block NSString *firstAttemptBody = @"";
                            
                            __block NSString *secondAttemptTitle = @"";
                            __block NSString *secondAttemptBody = @"";
                            
                            __block NSString *thirdAttemptTitle = @"";
                            __block NSString *thirdAttemptBody = @"";
                            
                            __block NSString *fourthAttemptTitle = @"";
                            __block NSString *fourthAttemptBody = @"";
                            
                            __block NSString *fifthAttemptTitle = @"";
                            __block NSString *fifthAttemptBody = @"";
                            
                            __block NSString *sixthAttemptTitle = @"";
                            __block NSString *sixthAttemptBody = @"";
                            
                            __strong __typeof(weakSelf) strongSelf = weakSelf;
                            
                            __block int totalQueries = 6;
                            __block int completedQueries = 0;
                            
                            /*
                             //
                             //
                             // First
                             //
                             //
                             */
                            if (strongSelf) {
                                
                                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                    
                                    [[[NotificationsObject alloc] init] GenerateFirstNotificationTitle:homeIDPerUser secondUserID:secondUserID completionHandler:^(BOOL finished, NSString *notificationTitleReturning, NSString *notificationBodyResults, int GenerateNotificationSeconds) {
                                        
                                        firstAttemptTitle = notificationTitleReturning;
                                        firstAttemptBody = notificationBodyResults;
                                        
                                        if (totalQueries == (completedQueries += 1)) {
                                            
                                            [[[NotificationsObject alloc] init] PickCorrectTitle:firstAttemptTitle firstBody:firstAttemptBody secondTitle:secondAttemptTitle secondBody:secondAttemptBody thirdTitle:thirdAttemptTitle thirdBody:thirdAttemptBody fourthTitle:fourthAttemptTitle fourthBody:fourthAttemptBody fifthTitle:fifthAttemptTitle fifthBody:fifthAttemptBody sixthTitle:sixthAttemptTitle sixthBody:sixthAttemptBody GenerateNotificationSeconds:GenerateNotificationSeconds completionHandler:^(BOOL finished, NSString *notificationTitleReturning, NSString *notificationBodyResults, int GenerateNotificationSeconds) {
                                                
                                                finishBlock(YES, notificationTitleReturning, notificationBodyResults, GenerateNotificationSeconds);
                                                
                                            }];
                                            
                                        }
                                        
                                    }];
                                    
                                });
                                
                            } else {
                                
                                if (totalQueries == (completedQueries += 1)) {
                                    
                                    [[[NotificationsObject alloc] init] PickCorrectTitle:firstAttemptTitle firstBody:firstAttemptBody secondTitle:secondAttemptTitle secondBody:secondAttemptBody thirdTitle:thirdAttemptTitle thirdBody:thirdAttemptBody fourthTitle:fourthAttemptTitle fourthBody:fourthAttemptBody fifthTitle:fifthAttemptTitle fifthBody:fifthAttemptBody sixthTitle:sixthAttemptTitle sixthBody:sixthAttemptBody GenerateNotificationSeconds:GenerateNotificationSeconds completionHandler:^(BOOL finished, NSString *notificationTitleReturning, NSString *notificationBodyResults, int GenerateNotificationSeconds) {
                                        
                                        finishBlock(YES, notificationTitleReturning, notificationBodyResults, GenerateNotificationSeconds);
                                        
                                    }];
                                    
                                }
                                
                            }
                            
                            /*
                             //
                             //
                             // Second
                             //
                             //
                             */
                            if (strongSelf) {
                                
                                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                    
                                    [[[NotificationsObject alloc] init] GenerateSecondNotificationTitle:homeIDPerUser secondUserID:secondUserID completionHandler:^(BOOL finished, NSString *notificationTitleReturning, NSString *notificationBodyResults, int GenerateNotificationSeconds) {
                                        
                                        secondAttemptTitle = notificationTitleReturning;
                                        secondAttemptBody = notificationBodyResults;
                                        
                                        if (totalQueries == (completedQueries += 1)) {
                                            
                                            [[[NotificationsObject alloc] init] PickCorrectTitle:firstAttemptTitle firstBody:firstAttemptBody secondTitle:secondAttemptTitle secondBody:secondAttemptBody thirdTitle:thirdAttemptTitle thirdBody:thirdAttemptBody fourthTitle:fourthAttemptTitle fourthBody:fourthAttemptBody fifthTitle:fifthAttemptTitle fifthBody:fifthAttemptBody sixthTitle:sixthAttemptTitle sixthBody:sixthAttemptBody GenerateNotificationSeconds:GenerateNotificationSeconds completionHandler:^(BOOL finished, NSString *notificationTitleReturning, NSString *notificationBodyResults, int GenerateNotificationSeconds) {
                                                
                                                finishBlock(YES, notificationTitleReturning, notificationBodyResults, GenerateNotificationSeconds);
                                                
                                            }];
                                            
                                        }
                                        
                                    }];
                                    
                                });
                                
                            } else {
                                
                                if (totalQueries == (completedQueries += 1)) {
                                    
                                    [[[NotificationsObject alloc] init] PickCorrectTitle:firstAttemptTitle firstBody:firstAttemptBody secondTitle:secondAttemptTitle secondBody:secondAttemptBody thirdTitle:thirdAttemptTitle thirdBody:thirdAttemptBody fourthTitle:fourthAttemptTitle fourthBody:fourthAttemptBody fifthTitle:fifthAttemptTitle fifthBody:fifthAttemptBody sixthTitle:sixthAttemptTitle sixthBody:sixthAttemptBody GenerateNotificationSeconds:GenerateNotificationSeconds completionHandler:^(BOOL finished, NSString *notificationTitleReturning, NSString *notificationBodyResults, int GenerateNotificationSeconds) {
                                        
                                        finishBlock(YES, notificationTitleReturning, notificationBodyResults, GenerateNotificationSeconds);
                                        
                                    }];
                                    
                                }
                                
                            }
                            
                            /*
                             //
                             //
                             // Third
                             //
                             //
                             */
                            if (strongSelf) {
                                
                                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                    
                                    [[[NotificationsObject alloc] init] GenerateThirdNotificationTitle:homeIDPerUser secondUserID:secondUserID completionHandler:^(BOOL finished, NSString *notificationTitleReturning, NSString *notificationBodyResults, int GenerateNotificationSeconds) {
                                        
                                        thirdAttemptTitle = notificationTitleReturning;
                                        thirdAttemptBody = notificationBodyResults;
                                        
                                        if (totalQueries == (completedQueries += 1)) {
                                            
                                            [[[NotificationsObject alloc] init] PickCorrectTitle:firstAttemptTitle firstBody:firstAttemptBody secondTitle:secondAttemptTitle secondBody:secondAttemptBody thirdTitle:thirdAttemptTitle thirdBody:thirdAttemptBody fourthTitle:fourthAttemptTitle fourthBody:fourthAttemptBody fifthTitle:fifthAttemptTitle fifthBody:fifthAttemptBody sixthTitle:sixthAttemptTitle sixthBody:sixthAttemptBody GenerateNotificationSeconds:GenerateNotificationSeconds completionHandler:^(BOOL finished, NSString *notificationTitleReturning, NSString *notificationBodyResults, int GenerateNotificationSeconds) {
                                                
                                                finishBlock(YES, notificationTitleReturning, notificationBodyResults, GenerateNotificationSeconds);
                                                
                                            }];
                                            
                                        }
                                        
                                    }];
                                    
                                });
                                
                            } else {
                                
                                if (totalQueries == (completedQueries += 1)) {
                                    
                                    [[[NotificationsObject alloc] init] PickCorrectTitle:firstAttemptTitle firstBody:firstAttemptBody secondTitle:secondAttemptTitle secondBody:secondAttemptBody thirdTitle:thirdAttemptTitle thirdBody:thirdAttemptBody fourthTitle:fourthAttemptTitle fourthBody:fourthAttemptBody fifthTitle:fifthAttemptTitle fifthBody:fifthAttemptBody sixthTitle:sixthAttemptTitle sixthBody:sixthAttemptBody GenerateNotificationSeconds:GenerateNotificationSeconds completionHandler:^(BOOL finished, NSString *notificationTitleReturning, NSString *notificationBodyResults, int GenerateNotificationSeconds) {
                                        
                                        finishBlock(YES, notificationTitleReturning, notificationBodyResults, GenerateNotificationSeconds);
                                        
                                    }];
                                    
                                }
                                
                            }
                            
                            /*
                             //
                             //
                             // Fourth
                             //
                             //
                             */
                            if (strongSelf) {
                                
                                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                    
                                    [[[NotificationsObject alloc] init] GenerateFourthNotificationTitle:homeIDPerUser secondUserID:secondUserID completionHandler:^(BOOL finished, NSString *notificationTitleReturning, NSString *notificationBodyResults, int GenerateNotificationSeconds) {
                                        
                                        fourthAttemptTitle = notificationTitleReturning;
                                        fourthAttemptBody = notificationBodyResults;
                                        
                                        if (totalQueries == (completedQueries += 1)) {
                                            
                                            [[[NotificationsObject alloc] init] PickCorrectTitle:firstAttemptTitle firstBody:firstAttemptBody secondTitle:secondAttemptTitle secondBody:secondAttemptBody thirdTitle:thirdAttemptTitle thirdBody:thirdAttemptBody fourthTitle:fourthAttemptTitle fourthBody:fourthAttemptBody fifthTitle:fifthAttemptTitle fifthBody:fifthAttemptBody sixthTitle:sixthAttemptTitle sixthBody:sixthAttemptBody GenerateNotificationSeconds:GenerateNotificationSeconds completionHandler:^(BOOL finished, NSString *notificationTitleReturning, NSString *notificationBodyResults, int GenerateNotificationSeconds) {
                                                
                                                finishBlock(YES, notificationTitleReturning, notificationBodyResults, GenerateNotificationSeconds);
                                                
                                            }];
                                            
                                        }
                                        
                                    }];
                                    
                                });
                                
                            } else {
                                
                                if (totalQueries == (completedQueries += 1)) {
                                    
                                    [[[NotificationsObject alloc] init] PickCorrectTitle:firstAttemptTitle firstBody:firstAttemptBody secondTitle:secondAttemptTitle secondBody:secondAttemptBody thirdTitle:thirdAttemptTitle thirdBody:thirdAttemptBody fourthTitle:fourthAttemptTitle fourthBody:fourthAttemptBody fifthTitle:fifthAttemptTitle fifthBody:fifthAttemptBody sixthTitle:sixthAttemptTitle sixthBody:sixthAttemptBody GenerateNotificationSeconds:GenerateNotificationSeconds completionHandler:^(BOOL finished, NSString *notificationTitleReturning, NSString *notificationBodyResults, int GenerateNotificationSeconds) {
                                        
                                        finishBlock(YES, notificationTitleReturning, notificationBodyResults, GenerateNotificationSeconds);
                                        
                                    }];
                                    
                                }
                                
                            }
                            
                            /*
                             //
                             //
                             // Fifth
                             //
                             //
                             */
                            if (strongSelf) {
                                
                                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                    
                                    [[[NotificationsObject alloc] init] GenerateFifthNotificationTitle:homeIDPerUser secondUserID:secondUserID completionHandler:^(BOOL finished, NSString *notificationTitleReturning, NSString *notificationBodyResults, int GenerateNotificationSeconds) {
                                        
                                        fifthAttemptTitle = notificationTitleReturning;
                                        fifthAttemptBody = notificationBodyResults;
                                        
                                        if (totalQueries == (completedQueries += 1)) {
                                            
                                            [[[NotificationsObject alloc] init] PickCorrectTitle:firstAttemptTitle firstBody:firstAttemptBody secondTitle:secondAttemptTitle secondBody:secondAttemptBody thirdTitle:thirdAttemptTitle thirdBody:thirdAttemptBody fourthTitle:fourthAttemptTitle fourthBody:fourthAttemptBody fifthTitle:fifthAttemptTitle fifthBody:fifthAttemptBody sixthTitle:sixthAttemptTitle sixthBody:sixthAttemptBody GenerateNotificationSeconds:GenerateNotificationSeconds completionHandler:^(BOOL finished, NSString *notificationTitleReturning, NSString *notificationBodyResults, int GenerateNotificationSeconds) {
                                                
                                                finishBlock(YES, notificationTitleReturning, notificationBodyResults, GenerateNotificationSeconds);
                                                
                                            }];
                                            
                                        }
                                        
                                    }];
                                    
                                });
                                
                            } else {
                                
                                if (totalQueries == (completedQueries += 1)) {
                                    
                                    [[[NotificationsObject alloc] init] PickCorrectTitle:firstAttemptTitle firstBody:firstAttemptBody secondTitle:secondAttemptTitle secondBody:secondAttemptBody thirdTitle:thirdAttemptTitle thirdBody:thirdAttemptBody fourthTitle:fourthAttemptTitle fourthBody:fourthAttemptBody fifthTitle:fifthAttemptTitle fifthBody:fifthAttemptBody sixthTitle:sixthAttemptTitle sixthBody:sixthAttemptBody GenerateNotificationSeconds:GenerateNotificationSeconds completionHandler:^(BOOL finished, NSString *notificationTitleReturning, NSString *notificationBodyResults, int GenerateNotificationSeconds) {
                                        
                                        finishBlock(YES, notificationTitleReturning, notificationBodyResults, GenerateNotificationSeconds);
                                        
                                    }];
                                    
                                }
                                
                            }
                            
                            /*
                             //
                             //
                             // Sixth
                             //
                             //
                             */
                            if (strongSelf) {
                                
                                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                    
                                    [[[NotificationsObject alloc] init] GenerateSixthNotificationTitle:homeIDPerUser secondUserID:secondUserID completionHandler:^(BOOL finished, NSString *notificationTitleReturning, NSString *notificationBodyResults, int GenerateNotificationSeconds) {
                                        
                                        sixthAttemptTitle = notificationTitleReturning;
                                        sixthAttemptBody = notificationBodyResults;
                                        
                                        if (totalQueries == (completedQueries += 1)) {
                                            
                                            [[[NotificationsObject alloc] init] PickCorrectTitle:firstAttemptTitle firstBody:firstAttemptBody secondTitle:secondAttemptTitle secondBody:secondAttemptBody thirdTitle:thirdAttemptTitle thirdBody:thirdAttemptBody fourthTitle:fourthAttemptTitle fourthBody:fourthAttemptBody fifthTitle:fifthAttemptTitle fifthBody:fifthAttemptBody sixthTitle:sixthAttemptTitle sixthBody:sixthAttemptBody GenerateNotificationSeconds:GenerateNotificationSeconds completionHandler:^(BOOL finished, NSString *notificationTitleReturning, NSString *notificationBodyResults, int GenerateNotificationSeconds) {
                                                
                                                finishBlock(YES, notificationTitleReturning, notificationBodyResults, GenerateNotificationSeconds);
                                                
                                            }];
                                            
                                        }
                                        
                                    }];
                                    
                                });
                                
                            } else {
                                
                                if (totalQueries == (completedQueries += 1)) {
                                    
                                    [[[NotificationsObject alloc] init] PickCorrectTitle:firstAttemptTitle firstBody:firstAttemptBody secondTitle:secondAttemptTitle secondBody:secondAttemptBody thirdTitle:thirdAttemptTitle thirdBody:thirdAttemptBody fourthTitle:fourthAttemptTitle fourthBody:fourthAttemptBody fifthTitle:fifthAttemptTitle fifthBody:fifthAttemptBody sixthTitle:sixthAttemptTitle sixthBody:sixthAttemptBody GenerateNotificationSeconds:GenerateNotificationSeconds completionHandler:^(BOOL finished, NSString *notificationTitleReturning, NSString *notificationBodyResults, int GenerateNotificationSeconds) {
                                        
                                        finishBlock(YES, notificationTitleReturning, notificationBodyResults, GenerateNotificationSeconds);
                                        
                                    }];
                                    
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
            }];
            
        });
        
    } else if (![[NSUserDefaults standardUserDefaults] objectForKey:@"InactiveNotif(1)"]) {
        
        notificationTitle = @"Tired of work not getting done? 😓";
        notificationBody = @"Try scheduling some chores, expenses, and to-do lists! 🏠";
        GenerateNotificationSeconds = 86400;
        [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"InactiveNotif(1)"];
        
        finishBlock(YES, notificationTitle, notificationBody, GenerateNotificationSeconds);
        
    }
    
}

-(void)GenerateTwoWeekReminderNotificationTitle_1:(void (^)(BOOL finished, NSString *notificationTitleReturning, NSString *notificationBodyResults, int GenerateNotificationSeconds))finishBlock {
    
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
    
    __block NSString *notificationTitle = @"";
    __block NSString *notificationBody = @"";
    __block int GenerateNotificationSeconds = 0;
    
    NSMutableArray *totalUserIDArray = [NSMutableArray array];
    
    if (userID) {
        [totalUserIDArray addObject:userID];
    } else {
        [totalUserIDArray addObject:@"null"];
    }
    
    if ([totalUserIDArray containsObject:@"null"] == NO) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [[[GetDataObject alloc] init] GetDataHomesUserIdMemberOfSnapshot:userID completionHandler:^(BOOL finished, FIRQuerySnapshot * _Nonnull firstSnapshot) {
                
                @synchronized (firstSnapshot) {
                    
                    NSMutableDictionary *numberOfHomesDict = [NSMutableDictionary dictionary];
                    NSMutableDictionary *homeNamesDict = [NSMutableDictionary dictionary];
                    NSMutableDictionary *homeIDsDict = [NSMutableDictionary dictionary];
                    NSMutableDictionary *homeMembersDict = [NSMutableDictionary dictionary];
                    NSMutableDictionary *homeKeysDict = [NSMutableDictionary dictionary];
                    NSMutableDictionary *homeMembersUncalaimedDict = [NSMutableDictionary dictionary];
                    
                    for (NSString *userID in totalUserIDArray) {
                        [numberOfHomesDict setObject:@"0" forKey:userID];
                    }
                    for (NSString *userID in totalUserIDArray) {
                        [homeNamesDict setObject:@"" forKey:userID];
                    }
                    for (NSString *userID in totalUserIDArray) {
                        [homeIDsDict setObject:@"" forKey:userID];
                    }
                    for (NSString *userID in totalUserIDArray) {
                        [homeMembersDict setObject:@"0" forKey:userID];
                    }
                    for (NSString *userID in totalUserIDArray) {
                        [homeKeysDict setObject:@"0" forKey:userID];
                    }
                    for (NSString *userID in totalUserIDArray) {
                        [homeMembersUncalaimedDict setObject:@"0" forKey:userID];
                    }
                    
                    for (FIRDocumentSnapshot *firstDoc in firstSnapshot.documents) {
                        
                        @synchronized (firstDoc) {
                            
                            for (NSString *firstUserID in totalUserIDArray) {
                                
                                int numberOfHomes = numberOfHomesDict[firstUserID] ? [numberOfHomesDict[firstUserID] intValue] : 0;
                                NSString *homeName = homeNamesDict[firstUserID] ? homeNamesDict[firstUserID] : @"";
                                
                                NSString *docHomeID = firstDoc.data[@"HomeID"] ? firstDoc.data[@"HomeID"] : @"xxx";
                                NSString *docHomeName = firstDoc.data[@"HomeName"] ? firstDoc.data[@"HomeName"] : @"";
                                NSMutableArray *docHomeMembers = firstDoc.data[@"HomeMembers"] ? [firstDoc.data[@"HomeMembers"] mutableCopy] : [NSMutableArray array];
                                NSMutableDictionary *docHomeKeys = firstDoc.data[@"HomeKeys"] ? [firstDoc.data[@"HomeKeys"] mutableCopy] : [NSMutableDictionary dictionary];
                                NSMutableDictionary *docHomeMembersUnclaimed = firstDoc.data[@"HomeMembersUnclaimed"] ? [firstDoc.data[@"HomeMembersUnclaimed"] mutableCopy] : [NSMutableDictionary dictionary];
                                
                                if ([docHomeMembers containsObject:firstUserID]) {
                                    
                                    numberOfHomes += 1;
                                    
                                    [numberOfHomesDict setObject:[NSString stringWithFormat:@"%d", numberOfHomes] forKey:firstUserID];
                                    
                                    if (homeName.length > 0) {
                                        
                                        [homeNamesDict setObject:[NSString stringWithFormat:@"%@,%@", homeName, docHomeName] forKey:firstUserID];
                                        
                                    } else {
                                        
                                        [homeNamesDict setObject:[NSString stringWithFormat:@"%@", docHomeName] forKey:firstUserID];
                                        
                                    }
                                    
                                    [homeIDsDict setObject:[NSString stringWithFormat:@"%@", docHomeID] forKey:firstUserID];
                                    
                                    [homeMembersDict setObject:[NSString stringWithFormat:@"%lu", (unsigned long)[docHomeMembers count]] forKey:firstUserID];
                                    
                                    if ([docHomeKeys isMemberOfClass:[NSMutableDictionary class]] || [docHomeKeys isMemberOfClass:[NSDictionary class]]) {
                                        
                                        [homeKeysDict setObject:[NSString stringWithFormat:@"%lu", (unsigned long)[[docHomeKeys allKeys] count]] forKey:firstUserID];
                                        
                                    } else {
                                        
                                        [homeKeysDict setObject:[NSString stringWithFormat:@"%lu", (unsigned long)[docHomeKeys count]] forKey:firstUserID];
                                        
                                    }
                                    
                                    if ([docHomeMembersUnclaimed isMemberOfClass:[NSMutableDictionary class]] || [docHomeMembersUnclaimed isMemberOfClass:[NSDictionary class]]) {
                                        
                                        [homeMembersUncalaimedDict setObject:[NSString stringWithFormat:@"%lu", (unsigned long)[[docHomeMembersUnclaimed allKeys] count]] forKey:firstUserID];
                                        
                                    } else {
                                        
                                        [homeMembersUncalaimedDict setObject:[NSString stringWithFormat:@"%lu", (unsigned long)[docHomeMembersUnclaimed count]] forKey:firstUserID];
                                        
                                    }
                                    
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                    for (NSString *secondUserID in totalUserIDArray) {
                        
                        NSString *numberOfHomesPerUser = numberOfHomesDict[secondUserID] ? numberOfHomesDict[secondUserID] : @"";
                        NSString *numberOfHomesMembersPerUser = homeMembersDict[secondUserID] ? homeMembersDict[secondUserID] : @"";
                        //                        NSString *numberOfHomesKeysPerUser = homeKeysDict[secondUserID] ? homeKeysDict[secondUserID] : @"";
                        NSString *numberOfHomesMembersUnclaimedPerUser = homeMembersUncalaimedDict[secondUserID] ? homeMembersUncalaimedDict[secondUserID] : @"";
                        NSString *homeNamePerUser = homeNamesDict[secondUserID] ? homeNamesDict[secondUserID] : @"";
                        //                        NSString *homeIDPerUser = homeIDsDict[secondUserID] ? homeIDsDict[secondUserID] : @"";
                        
                        if ([numberOfHomesPerUser isEqualToString:@"1"] && [numberOfHomesMembersPerUser intValue] <= 1 && [numberOfHomesMembersUnclaimedPerUser intValue] == 0 && ![[NSUserDefaults standardUserDefaults] objectForKey:@"InactiveNotif(2.1)"]) {
                            
                            NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
                            NSString *trimmedString = [homeNamePerUser stringByTrimmingCharactersInSet:charSet];
                            
                            notificationTitle = [NSString stringWithFormat:@"Uh-oh, it looks like your home is still empty. 👻"];
                            notificationBody = [NSString stringWithFormat:@"Invite your home members to \"%@\" and so you can get stuff done! 🏠", trimmedString];
                            GenerateNotificationSeconds = 86400 + 3600;
                            
                            [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"InactiveNotif(2.1)"];
                            
                            finishBlock(YES, notificationTitle, notificationBody, GenerateNotificationSeconds);
                            
                        }
                        
                    }
                    
                }
                
            }];
            
        });
        
    }
    
}

-(void)GenerateFirstNotificationTitle:(NSString *)homeIDPerUser secondUserID:(NSString *)secondUserID completionHandler:(void (^)(BOOL finished, NSString *notificationTitleReturning, NSString *notificationBodyResults, int GenerateNotificationSeconds))finishBlock {
    
    __block NSString *notificationTitle = @"";
    __block NSString *notificationBody = @"";
    __block int GenerateNotificationSeconds = 691200;
    
    [[[GetDataObject alloc] init] GetDataGetItemsCompletedBy:homeIDPerUser collection:@"Chores" userID:secondUserID completionHandler:^(BOOL finished, FIRQuerySnapshot * _Nonnull thirdSnapshot) {
        
        @synchronized (thirdSnapshot) {
            
            if (thirdSnapshot.documents.count > 0) {
                
                @synchronized (thirdSnapshot) {
                    
                    for (FIRDocumentSnapshot *thirdDoc in thirdSnapshot.documents) {
                        
                        @synchronized (thirdDoc) {
                            
                            NSString *itemName = thirdDoc.data[@"ItemName"] ? thirdDoc.data[@"ItemName"] : @"";
                            
                            notificationTitle = [NSString stringWithFormat:@"Keep Up The Good Work! 😄"];
                            notificationBody = [NSString stringWithFormat:@"Great job completing \"%@\"! Check if you have any chores remaining. 🏠", itemName];
                            
                            finishBlock(YES, notificationTitle, notificationBody, GenerateNotificationSeconds);
                            
                        }
                        
                    }
                    
                }
                
            } else {
                
                finishBlock(YES, notificationTitle, notificationBody, GenerateNotificationSeconds);
                
            }
            
        }
        
    }];
    
}

-(void)GenerateSecondNotificationTitle:(NSString *)homeIDPerUser secondUserID:(NSString *)secondUserID completionHandler:(void (^)(BOOL finished, NSString *notificationTitleReturning, NSString *notificationBodyResults, int GenerateNotificationSeconds))finishBlock {
    
    __block NSString *notificationTitle = @"";
    __block NSString *notificationBody = @"";
    __block int GenerateNotificationSeconds = 691200;
    
    [[[GetDataObject alloc] init] GetDataGetItemsCompletedBy:homeIDPerUser collection:@"Expenses" userID:secondUserID completionHandler:^(BOOL finished, FIRQuerySnapshot * _Nonnull fourthSnapshot) {
        
        @synchronized (fourthSnapshot) {
            
            if (fourthSnapshot.documents.count > 0) {
                
                for (FIRDocumentSnapshot *fourthDoc in fourthSnapshot.documents) {
                    
                    @synchronized (fourthDoc) {
                        
                        NSString *itemName = fourthDoc.data[@"ItemName"] ? fourthDoc.data[@"ItemName"] : @"";
                        
                        notificationTitle = [NSString stringWithFormat:@"Keep Up The Good Work! 😄"];
                        notificationBody = [NSString stringWithFormat:@"Great job completing \"%@\"! Check if you have any expenses remaining. 🏠", itemName];
                        
                        finishBlock(YES, notificationTitle, notificationBody, GenerateNotificationSeconds);
                        
                    }
                    
                }
                
            } else {
                
                finishBlock(YES, notificationTitle, notificationBody, GenerateNotificationSeconds);
                
            }
            
        }
        
    }];
    
}

-(void)GenerateThirdNotificationTitle:(NSString *)homeIDPerUser secondUserID:(NSString *)secondUserID completionHandler:(void (^)(BOOL finished, NSString *notificationTitleReturning, NSString *notificationBodyResults, int GenerateNotificationSeconds))finishBlock {
    
    __block NSString *notificationTitle = @"";
    __block NSString *notificationBody = @"";
    __block int GenerateNotificationSeconds = 691200;
    
    [[[GetDataObject alloc] init] GetDataGetItemsCompletedBy:homeIDPerUser collection:@"Lists" userID:secondUserID completionHandler:^(BOOL finished, FIRQuerySnapshot * _Nonnull fifthSnapshot) {
        
        @synchronized (fifthSnapshot) {
            
            if (fifthSnapshot.documents.count > 0) {
                
                for (FIRDocumentSnapshot *fifthDoc in fifthSnapshot.documents) {
                    
                    @synchronized (fifthDoc) {
                        
                        NSString *itemName = fifthDoc.data[@"ItemName"] ? fifthDoc.data[@"ItemName"] : @"";
                        NSMutableDictionary *itemCompletedDict = fifthDoc.data[@"ItemCompletedDict"] ? [fifthDoc.data[@"ItemCompletedDict"] mutableCopy] : [NSMutableDictionary dictionary];
                        NSMutableDictionary *itemListItems = fifthDoc.data[@"ItemListItems"] ? [fifthDoc.data[@"ItemListItems"] mutableCopy] : [NSMutableDictionary dictionary];
                        
                        NSMutableArray *arrayToCheck = [NSMutableArray array];
                        
                        BOOL ObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:itemCompletedDict classArr:@[[NSDictionary class], [NSMutableDictionary class]]];
                        
                        arrayToCheck =
                        ObjectIsKindOfClass == YES ?
                        [[itemCompletedDict allKeys] mutableCopy] :
                        [itemCompletedDict mutableCopy];
                        
                        if ([[itemListItems allKeys] count] == [arrayToCheck count]) {
                            
                            notificationTitle = [NSString stringWithFormat:@"Keep Up The Good Work! 😄"];
                            notificationBody = [NSString stringWithFormat:@"Great job completing \"%@\"! Check if you have any lists remaining. 🏠", itemName];
                            
                            finishBlock(YES, notificationTitle, notificationBody, GenerateNotificationSeconds);
                            
                        }
                        
                    }
                    
                }
                
            } else {
                
                finishBlock(YES, notificationTitle, notificationBody, GenerateNotificationSeconds);
                
            }
            
        }
        
    }];
    
}

-(void)GenerateFourthNotificationTitle:(NSString *)homeIDPerUser secondUserID:(NSString *)secondUserID completionHandler:(void (^)(BOOL finished, NSString *notificationTitleReturning, NSString *notificationBodyResults, int GenerateNotificationSeconds))finishBlock {
    
    __block NSString *notificationTitle = @"";
    __block NSString *notificationBody = @"";
    __block int GenerateNotificationSeconds = 691200;
    
    [[[GetDataObject alloc] init] GetDataGetItemsCreatedBy:homeIDPerUser collection:@"Chores" userID:secondUserID completionHandler:^(BOOL finished, FIRQuerySnapshot * _Nonnull sixthSnapshot) {
        
        @synchronized (sixthSnapshot) {
            
            if (sixthSnapshot.documents.count > 0) {
                
                for (FIRDocumentSnapshot *sixthDoc in sixthSnapshot.documents) {
                    
                    @synchronized (sixthDoc) {
                        
                        NSString *itemName = sixthDoc.data[@"ItemName"] ? sixthDoc.data[@"ItemName"] : @"";
                        NSMutableDictionary *itemCompletedDict = sixthDoc.data[@"ItemCompletedDict"] ? [sixthDoc.data[@"ItemCompletedDict"] mutableCopy] : [NSMutableDictionary dictionary];
                        NSMutableArray *itemAssignedTo = sixthDoc.data[@"ItemAssignedTo"] ? [sixthDoc.data[@"ItemAssignedTo"] mutableCopy] : [NSMutableArray array];
                        
                        NSMutableArray *arrayToCheck = [NSMutableArray array];
                        
                        BOOL ObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:itemCompletedDict classArr:@[[NSDictionary class], [NSMutableDictionary class]]];
                        
                        arrayToCheck =
                        ObjectIsKindOfClass == YES ?
                        [[itemCompletedDict allKeys] mutableCopy] :
                        [itemCompletedDict mutableCopy];
                        
                        if ([itemAssignedTo count] >= [arrayToCheck count]) {
                            
                            notificationTitle = [NSString stringWithFormat:@"Schedule Some More Chores 😄"];
                            notificationBody = [NSString stringWithFormat:@"Great job getting \"%@\" completed! Try scheduling a new chore for your home. 🏠", itemName];
                            
                            finishBlock(YES, notificationTitle, notificationBody, GenerateNotificationSeconds);
                            
                        }
                        
                    }
                    
                }
                
            } else {
                
                finishBlock(YES, notificationTitle, notificationBody, GenerateNotificationSeconds);
                
            }
            
        }
        
    }];
    
}

-(void)GenerateFifthNotificationTitle:(NSString *)homeIDPerUser secondUserID:(NSString *)secondUserID completionHandler:(void (^)(BOOL finished, NSString *notificationTitleReturning, NSString *notificationBodyResults, int GenerateNotificationSeconds))finishBlock {
    
    __block NSString *notificationTitle = @"";
    __block NSString *notificationBody = @"";
    __block int GenerateNotificationSeconds = 691200;
    
    [[[GetDataObject alloc] init] GetDataGetItemsCreatedBy:homeIDPerUser collection:@"Expenses" userID:secondUserID completionHandler:^(BOOL finished, FIRQuerySnapshot * _Nonnull seventhSnapshot) {
        
        @synchronized (seventhSnapshot) {
            
            if (seventhSnapshot.documents.count > 0) {
                
                for (FIRDocumentSnapshot *seventhDoc in seventhSnapshot.documents) {
                    
                    @synchronized (seventhDoc) {
                        
                        NSString *itemName = seventhDoc.data[@"ItemName"] ? seventhDoc.data[@"ItemName"] : @"";
                        NSMutableDictionary *itemCompletedDict = seventhDoc.data[@"ItemCompletedDict"] ? [seventhDoc.data[@"ItemCompletedDict"] mutableCopy] : [NSMutableDictionary dictionary];
                        NSMutableArray *itemAssignedTo = seventhDoc.data[@"ItemAssignedTo"] ? [seventhDoc.data[@"ItemAssignedTo"] mutableCopy] : [NSMutableArray array];
                        
                        NSMutableArray *arrayToCheck = [NSMutableArray array];
                        
                        BOOL ObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:itemCompletedDict classArr:@[[NSDictionary class], [NSMutableDictionary class]]];
                        
                        arrayToCheck =
                        ObjectIsKindOfClass == YES ?
                        [[itemCompletedDict allKeys] mutableCopy] :
                        [itemCompletedDict mutableCopy];
                        
                        if ([itemAssignedTo count] >= [arrayToCheck count]) {
                            
                            notificationTitle = [NSString stringWithFormat:@"Schedule Some More Expenses 😄"];
                            notificationBody = [NSString stringWithFormat:@"Great job getting \"%@\" completed! Try scheduling a new expense for your home. 🏠", itemName];
                            
                            finishBlock(YES, notificationTitle, notificationBody, GenerateNotificationSeconds);
                            
                        }
                        
                    }
                    
                }
                
            } else {
                
                finishBlock(YES, notificationTitle, notificationBody, GenerateNotificationSeconds);
                
            }
            
        }
        
    }];
    
}

-(void)GenerateSixthNotificationTitle:(NSString *)homeIDPerUser secondUserID:(NSString *)secondUserID completionHandler:(void (^)(BOOL finished, NSString *notificationTitleReturning, NSString *notificationBodyResults, int GenerateNotificationSeconds))finishBlock {
    
    __block NSString *notificationTitle = @"";
    __block NSString *notificationBody = @"";
    __block int GenerateNotificationSeconds = 691200;
    
    [[[GetDataObject alloc] init] GetDataGetItemsCreatedBy:homeIDPerUser collection:@"Lists" userID:secondUserID completionHandler:^(BOOL finished, FIRQuerySnapshot * _Nonnull eigthSnapshot) {
        
        @synchronized (eigthSnapshot) {
            
            if (eigthSnapshot.documents.count > 0) {
                
                for (FIRDocumentSnapshot *eigthDoc in eigthSnapshot.documents) {
                    
                    @synchronized (eigthDoc) {
                        
                        NSString *itemName = eigthDoc.data[@"ItemName"] ? eigthDoc.data[@"ItemName"] : @"";
                        NSMutableDictionary *itemCompletedDict = eigthDoc.data[@"ItemCompletedDict"] ? [eigthDoc.data[@"ItemCompletedDict"] mutableCopy] : [NSMutableDictionary dictionary];
                        NSMutableDictionary *itemListItems = eigthDoc.data[@"ItemListItems"] ? [eigthDoc.data[@"ItemListItems"] mutableCopy] : [NSMutableDictionary dictionary];
                        
                        NSMutableArray *arrayToCheck = [NSMutableArray array];
                        
                        BOOL ObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:itemCompletedDict classArr:@[[NSDictionary class], [NSMutableDictionary class]]];
                        
                        arrayToCheck =
                        ObjectIsKindOfClass == YES ?
                        [[itemCompletedDict allKeys] mutableCopy] :
                        [itemCompletedDict mutableCopy];
                        
                        if ([[itemListItems allKeys] count] == [arrayToCheck count]) {
                            
                            notificationTitle = [NSString stringWithFormat:@"Schedule Some More Lists 😄"];
                            notificationBody = [NSString stringWithFormat:@"Great job getting \"%@\" completed! Try scheduling a new list for your home. 🏠", itemName];
                            
                            finishBlock(YES, notificationTitle, notificationBody, GenerateNotificationSeconds);
                            
                        }
                        
                    }
                    
                }
                
            } else {
                
                finishBlock(YES, notificationTitle, notificationBody, GenerateNotificationSeconds);
                
            }
            
        }
        
    }];
    
}

-(void)PickCorrectTitle:(NSString *)firstTitle firstBody:(NSString *)firstBody secondTitle:(NSString *)secondTitle secondBody:(NSString *)secondBody thirdTitle:(NSString *)thirdTitle thirdBody:(NSString *)thirdBody fourthTitle:(NSString *)fourthTitle fourthBody:(NSString *)fourthBody fifthTitle:(NSString *)fifthTitle fifthBody:(NSString *)fifthBody sixthTitle:(NSString *)sixthTitle sixthBody:(NSString *)sixthBody GenerateNotificationSeconds:(int)GenerateNotificationSeconds completionHandler:(void (^)(BOOL finished, NSString *notificationTitleReturning, NSString *notificationBodyResults, int GenerateNotificationSeconds))finishBlock {
    
    if (firstTitle.length > 0 && firstBody.length > 0) {
        
        finishBlock(YES, firstTitle, firstBody, GenerateNotificationSeconds);
        
    } else if (secondTitle.length > 0 && secondBody.length > 0) {
        
        finishBlock(YES, secondTitle, secondBody, GenerateNotificationSeconds);
        
    } else if (thirdTitle.length > 0 && thirdBody.length > 0) {
        
        finishBlock(YES, thirdTitle, thirdBody, GenerateNotificationSeconds);
        
    } else if (fourthTitle.length > 0 && fourthBody.length > 0) {
        
        finishBlock(YES, fourthTitle, fourthBody, GenerateNotificationSeconds);
        
    } else if (fifthTitle.length > 0 && fifthBody.length > 0) {
        
        finishBlock(YES, fifthTitle, fifthBody, GenerateNotificationSeconds);
        
    } else if (sixthTitle.length > 0 && sixthBody.length > 0) {
        
        finishBlock(YES, sixthTitle, sixthBody, GenerateNotificationSeconds);
        
    } else if (![[NSUserDefaults standardUserDefaults] objectForKey:@"InactiveNotif(1)"]) {
        
        [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"InactiveNotif(1)"];
        
        finishBlock(YES, @"Tired of work not getting done? 😓", @"Try scheduling some chores, expenses, and to-do lists! 🏠", GenerateNotificationSeconds);
        
    } else {
        
        finishBlock(YES, @"", @"", GenerateNotificationSeconds);
        
    }
    
}


#pragma mark -
#pragma mark
#pragma mark
#pragma mark Sub-Internal Methods
#pragma mark
#pragma mark
#pragma mark -

#pragma mark Reminder Notification Methods

-(NSString *)RemoveExtraTextFromKey:(NSString *)key {
    
    NSString *itemName = @"";
    
    if ([key containsString:@" ççç "]) {
        
        NSArray *titleArray = [key componentsSeparatedByString:@" ççç "];
        itemName = [titleArray count] > 0 ? titleArray[0] : @"";
        
    }
    
    return itemName;
}

-(NSString *)GenerateDueDateWithGracePeriod:(NSString *)previousDate itemGracePeriod:(NSString *)itemGracePeriod {
    
    NSString *dueDate = previousDate;
    
    if ([itemGracePeriod isEqualToString:@"None"] == NO && itemGracePeriod.length > 0) {
        
        int gracePeriodSeconds = [[[GeneralObject alloc] init] GenerateSecondsFromDisplayTime:itemGracePeriod];
        
        NSDateFormatter *dateFormatter = [[[GeneralObject alloc] init] GenerateDateFormatWithString:@"MMMM dd, yyyy hh:mm a"];
        
        NSDate *dueDateInDateForm = [NSDate date];
        
        if (dueDate.length > 0) {
            dueDateInDateForm = [dateFormatter dateFromString:dueDate];
        }
        
        dueDate = [[[GeneralObject alloc] init] GenerateDateWithAddedTimeWithFormat:@"MMMM dd, yyyy hh:mm a" dateToAddTimeTo:dueDateInDateForm timeToAdd:gracePeriodSeconds returnAs:[NSString class]];
        
    }
    
    return dueDate;
    
}

-(NSDictionary *)GenerateReminderNotificationText:(NSString *)itemType itemName:(NSString *)itemName itemCreatedBy:(NSString *)itemCreatedBy itemAssignedTo:(NSMutableArray *)itemAssignedTo itemAssignedToOriginal:(NSMutableArray *)itemAssignedToOriginal itemCompletedDict:(NSMutableDictionary *)itemCompletedDict itemReminder:(NSString *)itemReminder itemReminderDict:(NSDictionary *)itemReminderDict homeMembersDict:(NSMutableDictionary *)homeMembersDict {
    
    NSString *reminderNotificationTitle = @"";
    NSString *reminderNotificationBody = @"";
    
    BOOL ItemCreatedByMe = [itemCreatedBy isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
    BOOL ItemAssignedToMe = [itemAssignedToOriginal containsObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
    
    NSArray *frequencyArr = [itemReminder componentsSeparatedByString:@" "];
    NSString *frequencyAmount = [frequencyArr count] > 0 ? frequencyArr[0] : @"";
    NSString *frequencType = [frequencyArr count] > 1 ? frequencyArr[1] : @"";
    NSString *amountOfTime = [NSString stringWithFormat:@"%@ %@", frequencyAmount, frequencType];
    
    
    
    reminderNotificationTitle = [NSString stringWithFormat:@"\"%@\" ççç %@", itemName, itemReminder];
    
    
    
    
    NSString *createdByMeReminderBody = [NSString stringWithFormat:@"This %@ is due in %@. WeDivvy is letting everyone you assigned know! 🔔", [itemType lowercaseString], [amountOfTime lowercaseString]];
    NSString *selectedReminderBody = [NSString stringWithFormat:@"This %@ is due in %@. Remember to mark it as completed so everyone knows! 😄", [itemType lowercaseString], [amountOfTime lowercaseString]];
    
    BOOL IsKindOfNSStringClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:itemReminderDict[itemReminder] classArr:@[[NSString class]]];
    
    NSString *reminderOption =
    (itemReminderDict[itemReminder] && IsKindOfNSStringClass == NO && itemReminderDict[itemReminder][@"Option"]) ?
    itemReminderDict[itemReminder][@"Option"] : itemReminder;
    
    BOOL ReminderOptionObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:reminderOption classArr:@[[NSString class]]];
    
    if (ReminderOptionObjectIsKindOfClass == NO || (ReminderOptionObjectIsKindOfClass == YES && [reminderOption isEqualToString:@"Option 1"])) {
        
        selectedReminderBody = [[[NotificationsObject alloc] init] GenerateReminderBodyOption1:itemType amountOfTime:amountOfTime];
        
    } else if ([reminderOption isEqualToString:@"Option 2"]) {
        
        selectedReminderBody = [[[NotificationsObject alloc] init] GenerateReminderBodyOption2:itemType itemAssignedTo:itemAssignedTo itemCompletedDict:itemCompletedDict amountOfTime:amountOfTime];
        
    } else if ([reminderOption isEqualToString:@"Option 3"]) {
        
        selectedReminderBody = [[[NotificationsObject alloc] init] GenerateReminderBodyOption3:itemType itemAssignedTo:itemAssignedTo itemCompletedDict:itemCompletedDict homeMembersDict:homeMembersDict amountOfTime:amountOfTime];
        
    }
    
    
    
    
    if (itemAssignedTo.count > 0) {
        
        reminderNotificationBody = ItemCreatedByMe == YES && ItemAssignedToMe == NO ?
        createdByMeReminderBody :
        selectedReminderBody;
        
    } else {
        
        reminderNotificationBody = selectedReminderBody;
        
    }
    
    
    
    
    return @{@"Title" : reminderNotificationTitle, @"Body" : reminderNotificationBody};
}

-(NSDictionary *)GenerateReminderAnyTimeNotificationText:(NSString *)itemType itemName:(NSString *)itemName itemCreatedBy:(NSString *)itemCreatedBy itemAssignedTo:(NSMutableArray *)itemAssignedTo itemAssignedToOriginal:(NSMutableArray *)itemAssignedToOriginal itemReminder:(NSString *)itemReminder itemGracePeriod:(NSString *)itemGracePeriod {
    
    
    float hours = [[[NotificationsObject alloc] init] GenerateReminderAnyTimeNotificationHoursBefore:itemReminder itemGracePeriod:itemGracePeriod];
    
    NSString *reminderNotificationTitle =  reminderNotificationTitle = [NSString stringWithFormat:@"\"%@\" ççç %ld Hours before", itemName, (long)hours];
    NSString *reminderNotificationBody = @"";
    
    BOOL ItemCreatedByMe = [itemCreatedBy isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
    BOOL ItemAssignedToMe = [itemAssignedToOriginal containsObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
    
    NSString *dueString = [[[NotificationsObject alloc] init] GenerateReminderAnyTimeNotificationDueString:itemReminder];
    
    NSString *createdByMeReminderBody = [NSString stringWithFormat:@"This %@ is due %@. WeDivvy is letting everyone you assigned know! 🔔", [itemType lowercaseString], dueString];
    NSString *selectedReminderBody = [NSString stringWithFormat:@"This %@ is due %@. Remember to mark it as completed so everyone knows! 😄", [itemType lowercaseString], dueString];
    
    
    
    
    if (itemAssignedTo.count > 0) {
        
        reminderNotificationBody = ItemCreatedByMe == YES && ItemAssignedToMe == NO ?
        createdByMeReminderBody :
        selectedReminderBody;
        
    } else {
        
        reminderNotificationBody = selectedReminderBody;
        
    }
    
    
    
    
    return @{@"Title" : reminderNotificationTitle, @"Body" : reminderNotificationBody};
}

-(NSDictionary *)GenerateDueNowNotificationText:(NSString *)itemType itemName:(NSString *)itemName itemCreatedBy:(NSString *)itemCreatedBy itemAssignedTo:(NSMutableArray *)itemAssignedTo itemAssignedToOriginal:(NSMutableArray *)itemAssignedToOriginal itemCompletedDict:(NSMutableDictionary *)itemCompletedDict itemGracePeriod:(NSString *)itemGracePeriod homeMembersDict:(NSMutableDictionary *)homeMembersDict itemReminder:(NSString *)itemReminder itemReminderDict:(NSDictionary *)itemReminderDict itemTakeTurns:(NSString *)itemTakeTurns itemAlternateTurns:(NSString *)itemAlternateTurns itemTurnUsername:(NSString *)itemTurnUsername {
    
    NSString *dueNowNotificationTitle = @"";
    NSString *dueNowNotificationBody = @"";
    
    BOOL ItemCreatedByMe = [itemCreatedBy isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
    BOOL ItemAssignedToMe = [itemAssignedToOriginal containsObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
    
    dueNowNotificationTitle = [NSString stringWithFormat:@"\"%@\" ççç Due Now", itemName];
    
    
    
    
    if (itemAssignedTo.count > 0 && [(NSArray *)homeMembersDict[@"Username"] count] > 0) {
        
        
        
        
        NSString *createdByMeDueNowBody = [[[NotificationsObject alloc] init] GenerateDueNowBodyOption3:itemAssignedTo homeMembersDict:homeMembersDict itemCompletedDict:itemCompletedDict itemGracePeriod:itemGracePeriod itemTakeTurns:itemTakeTurns itemAlternateTurns:itemAlternateTurns itemTurnUsername:itemTurnUsername itemType:itemType];
        NSString *selectedDueNowBody = [[[NotificationsObject alloc] init] GenerateDueNowBodyOption3:itemAssignedTo homeMembersDict:homeMembersDict itemCompletedDict:itemCompletedDict itemGracePeriod:itemGracePeriod itemTakeTurns:itemTakeTurns itemAlternateTurns:itemAlternateTurns itemTurnUsername:itemTurnUsername itemType:itemType];
        
        BOOL IsKindOfNSStringClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:itemReminderDict[itemReminder] classArr:@[[NSString class]]];
        
        NSString *reminderOption =
        (itemReminderDict[itemReminder] && IsKindOfNSStringClass == NO && itemReminderDict[itemReminder][@"Option"]) ?
        itemReminderDict[itemReminder][@"Option"] : itemReminder;
        
        BOOL ReminderOptionObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:reminderOption classArr:@[[NSString class]]];
        
        if (ReminderOptionObjectIsKindOfClass == YES && [reminderOption isEqualToString:@"Option 1"]) {
          
            selectedDueNowBody = [[[NotificationsObject alloc] init] GenerateDueNowBodyOption1:itemAssignedTo homeMembersDict:homeMembersDict itemCompletedDict:itemCompletedDict itemGracePeriod:itemGracePeriod itemType:itemType];
            
        } else if (ReminderOptionObjectIsKindOfClass == YES && [reminderOption isEqualToString:@"Option 2"]) {
          
            selectedDueNowBody = [[[NotificationsObject alloc] init] GenerateDueNowBodyOption2:itemAssignedTo homeMembersDict:homeMembersDict itemCompletedDict:itemCompletedDict itemGracePeriod:itemGracePeriod itemTakeTurns:itemTakeTurns itemAlternateTurns:itemAlternateTurns itemTurnUsername:itemTurnUsername itemType:itemType];
            
        } else if (ReminderOptionObjectIsKindOfClass == NO || (ReminderOptionObjectIsKindOfClass == YES && [reminderOption isEqualToString:@"Option 3"])) {
          
            selectedDueNowBody = [[[NotificationsObject alloc] init] GenerateDueNowBodyOption3:itemAssignedTo homeMembersDict:homeMembersDict itemCompletedDict:itemCompletedDict itemGracePeriod:itemGracePeriod itemTakeTurns:itemTakeTurns itemAlternateTurns:itemAlternateTurns itemTurnUsername:itemTurnUsername itemType:itemType];
            
        }
       
        dueNowNotificationBody = ItemCreatedByMe == YES && ItemAssignedToMe == NO ?
        createdByMeDueNowBody :
        selectedDueNowBody;
        
        
        
        
    } else if (itemAssignedTo.count == 0) {
        
        
        
        
        NSString *createdByMeDueNowBody = [[[NotificationsObject alloc] init] GenerateDueNowBodyOption3NobodyAssigned:homeMembersDict[@"UserID"] homeMembersDict:homeMembersDict itemCompletedDict:itemCompletedDict itemGracePeriod:itemGracePeriod itemType:itemType];
        NSString *selectedDueNowBody = [[[NotificationsObject alloc] init] GenerateDueNowBodyOption3NobodyAssigned:homeMembersDict[@"UserID"] homeMembersDict:homeMembersDict itemCompletedDict:itemCompletedDict itemGracePeriod:itemGracePeriod itemType:itemType];
        
        BOOL IsKindOfNSStringClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:itemReminderDict[itemReminder] classArr:@[[NSString class]]];
        
        NSString *reminderOption =
        (itemReminderDict[itemReminder] && IsKindOfNSStringClass == NO && itemReminderDict[itemReminder][@"Option"]) ?
        itemReminderDict[itemReminder][@"Option"] : itemReminder;
        
        BOOL ReminderOptionObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:reminderOption classArr:@[[NSString class]]];
        
        if (ReminderOptionObjectIsKindOfClass == YES && [reminderOption isEqualToString:@"Option 1"]) {
            
            selectedDueNowBody = [[[NotificationsObject alloc] init] GenerateDueNowBodyOption1NobodyAssigned:itemAssignedTo homeMembersDict:homeMembersDict itemCompletedDict:itemCompletedDict itemGracePeriod:itemGracePeriod itemType:itemType];
            
        } else if (ReminderOptionObjectIsKindOfClass == YES && [reminderOption isEqualToString:@"Option 2"]) {
            
            selectedDueNowBody = [[[NotificationsObject alloc] init] GenerateDueNowBodyOption2NobodyAssigned:itemAssignedTo homeMembersDict:homeMembersDict itemCompletedDict:itemCompletedDict itemGracePeriod:itemGracePeriod itemType:itemType];
            
        } else if (ReminderOptionObjectIsKindOfClass == NO || (ReminderOptionObjectIsKindOfClass == YES && [reminderOption isEqualToString:@"Option 3"])) {
            
            selectedDueNowBody = [[[NotificationsObject alloc] init] GenerateDueNowBodyOption3NobodyAssigned:itemAssignedTo homeMembersDict:homeMembersDict itemCompletedDict:itemCompletedDict itemGracePeriod:itemGracePeriod itemType:itemType];
            
        }
        
        dueNowNotificationBody = ItemCreatedByMe == YES && ItemAssignedToMe == NO ?
        createdByMeDueNowBody :
        selectedDueNowBody;
        
        
        
        
    } else {
        
        dueNowNotificationBody = ItemCreatedByMe == YES && ItemAssignedToMe == NO ?
        [NSString stringWithFormat:@"This %@ is due now. Check and see who's completed it! 😎", [itemType lowercaseString]] :
        [NSString stringWithFormat:@"This %@ is due now. Last chance to mark it as completed! ✅", [itemType lowercaseString]];
        
    }
    
    return @{@"Title" : dueNowNotificationTitle, @"Body" : dueNowNotificationBody};
}

-(NSDictionary *)GenerateGracePeriodNotificationText:(NSString *)itemType itemName:(NSString *)itemName itemCreatedBy:(NSString *)itemCreatedBy itemAssignedTo:(NSMutableArray *)itemAssignedTo itemAssignedToOriginal:(NSMutableArray *)itemAssignedToOriginal itemGracePeriod:(NSString *)itemGracePeriod {
    
    NSString *gracePeriodNotificationTitle = @"";
    NSString *gracePeriodNotificationBody = @"";
    
    BOOL ItemCreatedByMe = [itemCreatedBy isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
    BOOL ItemAssignedToMe = [itemAssignedToOriginal containsObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]];
    
    gracePeriodNotificationTitle = [NSString stringWithFormat:@"\"%@\" ççç %@ Grace Period", itemName, itemGracePeriod];
    
    gracePeriodNotificationBody = ItemCreatedByMe == YES && ItemAssignedToMe == NO ?
    [NSString stringWithFormat:@"This %@ is due now. Check and see who's completed it! 😎", [itemType lowercaseString]] :
    [NSString stringWithFormat:@"This %@ is due now. You have a grace period of %@ to mark it as completed! ✅", [itemType lowercaseString], [itemGracePeriod lowercaseString]];
    
    return @{@"Title" : gracePeriodNotificationTitle, @"Body" : gracePeriodNotificationBody};
}

-(NSMutableArray *)GenerateArrayOfIndexForOccurrences:(int)indexOfUser totalAmountOfFutureDates:(int)totalAmountOfFutureDates totalAssignedToUsers:(int)totalAssignedToUsers itemAlternateTurns:(NSString *)itemAlternateTurns {
    
    int numOfOccurrencesBeforeAlternate = 1;
    
    if ([itemAlternateTurns containsString:@" "] &&
        [[itemAlternateTurns componentsSeparatedByString:@" "] count] > 2) {
        NSArray *arr = [itemAlternateTurns componentsSeparatedByString:@" "];
        numOfOccurrencesBeforeAlternate = [(NSString *)arr[1] intValue];
    }
 
    NSMutableArray *indexArr = [NSMutableArray array];
    
    // Set the start and end numbers
    int startNumber = indexOfUser * numOfOccurrencesBeforeAlternate;
    int endNumber = totalAmountOfFutureDates;
   
    // Iterate through the numbers with a for loop
    for (int i = startNumber; i <= endNumber; i += totalAssignedToUsers * numOfOccurrencesBeforeAlternate) {
        
        // Ensure the second number does not exceed the end number
        if (i + (numOfOccurrencesBeforeAlternate-1) <= endNumber) {
            
            for (int k=i ; k < (i + (numOfOccurrencesBeforeAlternate-1)) + 1 ; k++) {
                
                [indexArr addObject:[NSString stringWithFormat:@"%d", k]];
                
            }
        }
    }
   
    return indexArr;
}

-(NSMutableArray *)GenerateArrayOfIndexForDaysWeeksMonths:(int)indexOfUser totalAmountOfFutureDates:(int)totalAmountOfFutureDates totalAssignedToUsers:(int)totalAssignedToUsers itemAlternateTurns:(NSString *)itemAlternateTurns dueDateStrings:(NSArray<NSString *> *)dueDateStrings {
    
    int numOfOccurrencesBeforeAlternate = 1;
    
    if ([itemAlternateTurns containsString:@" "] &&
        [[itemAlternateTurns componentsSeparatedByString:@" "] count] > 2) {
        NSArray *arr = [itemAlternateTurns componentsSeparatedByString:@" "];
        numOfOccurrencesBeforeAlternate = [(NSString *)arr[1] intValue];
    }
    
    NSMutableArray *indexArr = [NSMutableArray array];
    
    //Find the starting day, week or month of the first due date
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"MMMM dd, yyyy hh:mm a";
    NSDate *firstPotentialDueDate = [dateFormatter dateFromString:dueDateStrings.firstObject];
    
    int dayWeekOrMonthOfYearToStartFrom = [[[NotificationsObject alloc] init] GenerateUnitToCheck:firstPotentialDueDate itemAlternateTurns:itemAlternateTurns];
    
    int timesBeforeAlternatingTurns = numOfOccurrencesBeforeAlternate;
    int numOfUsersAssigned = totalAssignedToUsers;
    int amountOfUnitsInYear = 365;
    
    if ([itemAlternateTurns containsString:@" Week"]) {
        amountOfUnitsInYear = 52;
    } else if ([itemAlternateTurns containsString:@" Month"]) {
        amountOfUnitsInYear = 12;
    }
    
    //Get all the day, week, or month numbers for specific users due dates
    NSMutableArray *desiredWeekNumbers = [NSMutableArray array];
    
    //Depending On Index Of User You Will Start Counting Their Desired Weeks On Different Indexes
    int amountToAddToStarting = (int)indexOfUser*(int)timesBeforeAlternatingTurns;
    
    for (int i = dayWeekOrMonthOfYearToStartFrom + amountToAddToStarting; i < dueDateStrings.count; i += (timesBeforeAlternatingTurns * numOfUsersAssigned)) {
        // Ensure that we have at least two elements remaining
        
        BOOL ThereAreStillEnoughDueDatesToCheck = i + timesBeforeAlternatingTurns < dueDateStrings.count;
        BOOL WeHaveLoopedThroughTheEntireYear = i > amountOfUnitsInYear;
        BOOL WeHaveLoopedOverTheOriginalStartingWeek = i >= (amountOfUnitsInYear+(dayWeekOrMonthOfYearToStartFrom-4));
        
        if (ThereAreStillEnoughDueDatesToCheck == YES &&
            (WeHaveLoopedThroughTheEntireYear == NO || (WeHaveLoopedThroughTheEntireYear == YES && WeHaveLoopedOverTheOriginalStartingWeek == NO))) {
            
            for (int k=0 ; k<timesBeforeAlternatingTurns ; k++) {
                
                int weekOfYear = i+k > amountOfUnitsInYear ? (i+k) % amountOfUnitsInYear : i+k;
                [desiredWeekNumbers addObject:[NSString stringWithFormat:@"%d", weekOfYear]];
                
            }
            
        }
        
    }
    
    // Find all the due dates in the desired days, weeks, or months
    NSMutableArray *dueDatesInDesiredWeeks = [NSMutableArray array];
    
    for (NSString *dueDateStr in dueDateStrings) {
        
        NSDate *dueDate = [dateFormatter dateFromString:dueDateStr];
        int dayWeekOrMonthOfYear = [[[NotificationsObject alloc] init] GenerateUnitToCheck:dueDate itemAlternateTurns:itemAlternateTurns];
        
        if ([desiredWeekNumbers containsObject:[NSString stringWithFormat:@"%d", dayWeekOrMonthOfYear]]) {
            [dueDatesInDesiredWeeks addObject:dueDateStr];
        }
        
    }
    
    for (NSString *dueDateStr in dueDatesInDesiredWeeks) {
        
        NSUInteger index = [dueDateStrings indexOfObject:dueDateStr];
        [indexArr addObject:[NSString stringWithFormat:@"%ld", index]];
        
    }
    
    return indexArr;
}

#pragma mark - Generate Due Date Methods

#pragma mark Hours

-(int)GenerateHoursToAddFromFirstHoursThatHasNotPassed:(NSDate *)currentDate dueDateInDateForm:(NSDate *)dueDateInDateForm itemTime:(NSString *)itemTime itemRepeats:(NSString *)itemRepeats itemRepeatIfCompletedEarly:(NSString *)itemRepeatIfCompletedEarly firstIteration:(BOOL)firstIteration {
    
    if ([itemTime isEqualToString:@"Any Time"]) {
        itemTime = @"11:59 PM";
    }
    
    NSDateComponents *componentsForTodayDate;
    
    //    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"FindAllFutureDueDates"] &&
    //        [[[NSUserDefaults standardUserDefaults] objectForKey:@"FindAllFutureDueDates"] isEqualToString:@"Yes"]) {
    
    componentsForTodayDate = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitWeekOfYear|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:dueDateInDateForm];
    
    //    } else {
    //
    //        componentsForTodayDate = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitWeekOfYear|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:currentDate];
    //
    //    }
    
    NSDateComponents *componentsForDueDate = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitWeekOfYear|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:dueDateInDateForm];
    //NSLog(@"testing componentsForDueDate:%@\n\ncomponentsForTodayDate:%@", componentsForDueDate, componentsForTodayDate);
    int hoursToAdd = 1;
    
    //Check If Todays Time Has Not Passed The Future Due Date Time Yet
    //i.e. First Future Due Date Should Be August 1, 2022 11:59 PM and Todays Date Is August 1, 2022 10:59 PM
    //In This Case Don't Add A Day To Todays Date Since Todays Date and The Future Due Date Are On The Same Day
    BOOL FutureDueDateAndTodaysDateAreOnTheSameDay =
    
    ((componentsForDueDate.year > componentsForTodayDate.year) ||
     
     (componentsForDueDate.year == componentsForTodayDate.year && componentsForDueDate.month > componentsForTodayDate.month) ||
     
     (componentsForDueDate.year == componentsForTodayDate.year && componentsForDueDate.month == componentsForTodayDate.month && componentsForDueDate.weekOfYear > componentsForTodayDate.weekOfYear) ||
     
     (componentsForDueDate.year == componentsForTodayDate.year && componentsForDueDate.month == componentsForTodayDate.month && componentsForDueDate.weekOfYear == componentsForTodayDate.weekOfYear && componentsForDueDate.day > componentsForTodayDate.day) ||
     
     (componentsForDueDate.year == componentsForTodayDate.year && componentsForDueDate.month == componentsForTodayDate.month && componentsForDueDate.weekOfYear == componentsForTodayDate.weekOfYear && componentsForDueDate.day > componentsForTodayDate.day && componentsForDueDate.hour > componentsForTodayDate.hour)
     
     );
    
    if (FutureDueDateAndTodaysDateAreOnTheSameDay == YES) {
        //NSLog(@"testing componentsForDueDate:%@\n\ncomponentsForTodayDate:%@", componentsForDueDate, componentsForTodayDate);
        hoursToAdd = 0;
        
    }
    
    return hoursToAdd;
}

-(int)GenerateHoursToAddForHourlyRepeatingIntervals:(NSString *)itemRepeats {
    
    int hoursToAdd = 0;
    
    BOOL TaskIsRepeatingInterval = [[[BoolDataObject alloc] init] TaskIsRepeatingInterval:[@{@"ItemRepeats" : itemRepeats} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType]];
    
    if (TaskIsRepeatingInterval == YES) {
        
        int intervalNum = [[[NotificationsObject alloc] init] GenerateRepeatingInterval:itemRepeats];
        
        //-1 Because It Already Jumped To The Day Immediatley After The Current Due Date Before This Method Began
        hoursToAdd = ((intervalNum-1) * 1);
        
    }
    
    return hoursToAdd;
}

-(NSString *)GenerateDueDateWithHoursToAddAndCorrectTime:(NSDate *)dueDateInDateForm itemTime:(NSString *)itemTime hoursToAdd:(int)hoursToAdd dateFormat:(NSString *)dateFormat firstIteration:(BOOL)firstIteration {
    
    NSString *dueDate = [[[GeneralObject alloc] init] GenerateDateWithAddedTimeWithFormat:dateFormat dateToAddTimeTo:dueDateInDateForm timeToAdd:60*60*hoursToAdd returnAs:[NSString class]];
    
    //    if (firstIteration == NO) {
    //
    //        dueDate = [[[NotificationsObject alloc] init] GenerateDueDateWithDayligHasvingsTime:dueDate itemTime:itemTime];
    //
    //    }
    
    NSString *dueDateWithCorrectTime = dueDate;//[[[NotificationsObject alloc] init] GenerateDueDateWithCorrectTime:dueDate itemTime:itemTime];
    
    return dueDateWithCorrectTime;
}

#pragma mark Days

-(int)GenerateDaysToAddFromFirstDayThatHasNotPassed:(NSDate *)currentDate dueDateInDateForm:(NSDate *)dueDateInDateForm itemTime:(NSString *)itemTime itemRepeats:(NSString *)itemRepeats itemRepeatIfCompletedEarly:(NSString *)itemRepeatIfCompletedEarly firstIteration:(BOOL)firstIteration {
    
    NSDictionary *dict = [[[NotificationsObject alloc] init] GenerateDictOfDateComponentsAndTimeComponents:dueDateInDateForm currentDate:currentDate itemTime:itemTime];
    
    NSString *hour = dict[@"Hour"];
    NSString *minute = dict[@"Minute"];
    NSDateComponents *componentsForTodayDate = dict[@"ComponentsForTodayDate"];
    
    NSDateComponents *componentsForDueDate = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitWeekOfYear|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:dueDateInDateForm];
    //NSLog(@"testing componentsForDueDate:%@\n\ncomponentsForTodayDate:%@", componentsForDueDate, componentsForTodayDate);
    int daysToAdd = 1;
    
    //Check If Todays Time Has Not Passed The Future Due Date Time Yet
    //i.e. First Future Due Date Should Be August 1, 2022 11:59 PM and Todays Date Is August 1, 2022 10:59 PM
    //In This Case Don't Add A Day To Todays Date Since Todays Date and The Future Due Date Are On The Same Day
    BOOL FutureDueDateAndTodaysDateAreOnTheSameDay =
    
    ((componentsForDueDate.year > componentsForTodayDate.year) ||
     
     (componentsForDueDate.year == componentsForTodayDate.year && componentsForDueDate.month > componentsForTodayDate.month) ||
     
     (componentsForDueDate.year == componentsForTodayDate.year && componentsForDueDate.month == componentsForTodayDate.month && componentsForDueDate.weekOfYear > componentsForTodayDate.weekOfYear) ||
     
     (componentsForDueDate.year == componentsForTodayDate.year && componentsForDueDate.month == componentsForTodayDate.month && componentsForDueDate.weekOfYear == componentsForTodayDate.weekOfYear && componentsForDueDate.day > componentsForTodayDate.day)
     
     //First Closest Due Date
     
     ||
     
     (componentsForDueDate.year == componentsForTodayDate.year && componentsForDueDate.month == componentsForTodayDate.month && componentsForDueDate.weekOfYear == componentsForTodayDate.weekOfYear && componentsForDueDate.day == componentsForTodayDate.day && [hour intValue] > componentsForTodayDate.hour) ||
     
     (componentsForDueDate.year == componentsForTodayDate.year && componentsForDueDate.month == componentsForTodayDate.month && componentsForDueDate.weekOfYear == componentsForTodayDate.weekOfYear && componentsForDueDate.day == componentsForTodayDate.day && [hour intValue] == componentsForTodayDate.hour && [minute intValue] > componentsForTodayDate.minute)
     
     //First Closest Due Date
     
     );
    
    if (FutureDueDateAndTodaysDateAreOnTheSameDay == YES) {
        
        NSLog(@"testing componentsForDueDate:%@\n\ncomponentsForTodayDate:%@", componentsForDueDate, componentsForTodayDate);
        daysToAdd = 0;
        
    }
    
    return daysToAdd;
}

-(int)GenerateDaysToAddForDailyRepeatingIntervals:(NSString *)itemRepeats {
    
    int daysToAdd = 0;
    
    BOOL TaskIsRepeatingInterval = [[[BoolDataObject alloc] init] TaskIsRepeatingInterval:[@{@"ItemRepeats" : itemRepeats} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType]];
    
    if (TaskIsRepeatingInterval == YES) {
        
        int intervalNum = [[[NotificationsObject alloc] init] GenerateRepeatingInterval:itemRepeats];
        
        //-1 Because It Already Jumped To The Day Immediatley After The Current Due Date Before This Method Began
        daysToAdd = ((intervalNum-1) * 1);
        
    }
    
    return daysToAdd;
}

#pragma mark Week

-(NSMutableArray *)GenerateWeekDaysArray:(NSString *)itemDays {
    
    NSMutableArray *itemDaysInNumberFormArray = [NSMutableArray array];
    
    NSDictionary *weekDayDict = @{@"Sunday" : @"1", @"Monday" : @"2", @"Tuesday" : @"3", @"Wednesday" : @"4", @"Thursday" : @"5", @"Friday" : @"6", @"Saturday" : @"7"};
    
    NSArray *itemDaysArray = [itemDays componentsSeparatedByString:@", "];
    
    if (itemDaysArray.count > 0) {
        
        for (NSString *day in itemDaysArray) {
            
            if (weekDayDict[day]) {
                
                [itemDaysInNumberFormArray addObject:weekDayDict[day]];
                
            } else if ([day isEqualToString:@"Any Day"]) {
                
                [itemDaysInNumberFormArray addObject:@"Any Day"];
                
            }
            
        }
        
    }
    
    //Sort Days
    itemDaysInNumberFormArray = [[itemDaysInNumberFormArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        if ([obj1 intValue] == [obj2 intValue])
            return NSOrderedSame;
        
        else if ([obj1 intValue] < [obj2 intValue])
            return NSOrderedAscending;
        
        else
            return NSOrderedDescending;
        
    }] mutableCopy];
    
    if (itemDaysInNumberFormArray.count < itemDaysArray.count) {
        itemDaysInNumberFormArray = [itemDaysArray mutableCopy];
    }
    
    if ([itemDaysInNumberFormArray containsObject:@"Any Day"]) {
        [itemDaysInNumberFormArray removeObject:@"Any Day"];
        [itemDaysInNumberFormArray addObject:@"Any Day"];
    }
    
    return itemDaysInNumberFormArray;
    
}

-(int)GenerateDaysToAddFromFirstDayThatHasNotPassedInCurrentWeekOrFirstDayInNextWeek:(NSArray *)itemDaysInNumberFormArray dueDateInDateForm:(NSDate *)dueDateInDateForm currentDate:(NSDate *)currentDate itemTime:(NSString *)itemTime itemRepeats:(NSString *)itemRepeats firstIteration:(BOOL)firstIteration {
    
    NSDateComponents *componentsForDueDate = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitWeekOfYear|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:dueDateInDateForm];
    
    if ([itemTime isEqualToString:@"Any Time"]) {
        itemTime = @"11:59 PM";
    }
    
    BOOL FoundSelectedDayThatHasntPassed = NO;
    int daysToAdd = 0;
    
    for (NSString *selectedDayInNumberForm in itemDaysInNumberFormArray) {
        
        NSString *selectedDayInNumberFormCopy = [selectedDayInNumberForm mutableCopy];
        
        if ([selectedDayInNumberFormCopy isEqualToString:@"Any Day"]) {
            selectedDayInNumberFormCopy = @"1";
        }
        
        BOOL SelectedDayHasntPassedDueDate =
        
        ([selectedDayInNumberFormCopy intValue] > componentsForDueDate.weekday);
        
        if (SelectedDayHasntPassedDueDate == YES) {
            
            daysToAdd = [selectedDayInNumberFormCopy intValue] - (int)componentsForDueDate.weekday;
            
            FoundSelectedDayThatHasntPassed = YES;
            
            break;
            
        }
        
    }
    
    if (FoundSelectedDayThatHasntPassed == NO) {
        
        NSString *lastSelectedDayInNumberForm = @"";
        
        
        if ([itemDaysInNumberFormArray count] > 0 && [itemDaysInNumberFormArray[0] isEqualToString:@"Any Day"]) {
            
            lastSelectedDayInNumberForm = @"1";
            
        } else if ([itemDaysInNumberFormArray count] > 0) {
            
            lastSelectedDayInNumberForm = itemDaysInNumberFormArray[0];
            
        }
        
        daysToAdd = ((7 + [lastSelectedDayInNumberForm intValue]) - (int)componentsForDueDate.weekday) % 7;
        
        
        
        
        //First Closest Due Date
        BOOL TaskHasRepeatingIntervals = [[itemRepeats componentsSeparatedByString:@" "] count] > 2;
        
        NSDictionary *dict = [[[NotificationsObject alloc] init] GenerateDictOfDateComponentsAndTimeComponents:dueDateInDateForm currentDate:currentDate itemTime:itemTime];
        
        NSString *hour = dict[@"Hour"];
        NSString *minute = dict[@"Minute"];
        NSDateComponents *componentsForTodayDate = dict[@"ComponentsForTodayDate"];
        
        BOOL FutureDueDateAndTodaysDateAreOnTheSameDay =
        
        (([hour intValue] > componentsForTodayDate.hour) ||
         ([hour intValue] == componentsForTodayDate.hour && [minute intValue] > componentsForTodayDate.minute));
        
        
        
        //To Make The First Closest Due Date,
        //1.Today Must Be The Same Day As The Due Date,
        //2.It Must Be The Very First Interation So It Can Conitnue Adding Days If It Is On The Same Day In The Future Iterations,
        //3.It Must Have No Intervals (Just A Preference),
        //4.It Must Be Past The Hour And Minute On The Same Day
        
        if (daysToAdd == 0 && firstIteration == YES && TaskHasRepeatingIntervals == NO && FutureDueDateAndTodaysDateAreOnTheSameDay == YES) {
            
            daysToAdd = 0;
            
        } else {
            
            daysToAdd = daysToAdd == 0 ? 7 : daysToAdd;
            
        }
        
        //Second Closest Due Date
        //daysToAdd = daysToAdd == 0 ? 7 : daysToAdd;
        
    }
    
    return daysToAdd;
}

-(int)GenerateDaysToAddForWeeklyRepeatingIntervals:(NSString *)itemRepeats itemRepeatIfCompletedEarly:(NSString *)itemRepeatIfCompletedEarly dueDateInDateForm:(NSDate *)dueDateInDateForm firstIteration:(BOOL)firstIteration daysToAdd:(int)daysToAdd {
    
    //    NSDateComponents *componentsForDueDate = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitWeekOfYear|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:dueDateInDateForm];
    
    int weekDaysToAdd = 0;
    
    BOOL TaskIsRepeatingInterval = [[[BoolDataObject alloc] init] TaskIsRepeatingInterval:[@{@"ItemRepeats" : itemRepeats} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType]];
    //    BOOL NeedToAddMoreDaysThanDaysRemainingInWeek = (componentsForDueDate.weekday + daysToAdd > 7);
    
    if (TaskIsRepeatingInterval == YES) {//} && NeedToAddMoreDaysThanDaysRemainingInWeek == YES) {
        
        int intervalNum = [[[NotificationsObject alloc] init] GenerateRepeatingInterval:itemRepeats];
        
        //I Added -1 Because It Already Jumped To The Week Immediatley After The Current Due Date Before This Method Began
        weekDaysToAdd = ((intervalNum-1) * 7);
        
    }
    
    return weekDaysToAdd;
}

#pragma mark Month (Days)

-(NSMutableArray *)GenerateMonthDaysArray:(NSString *)itemDays firstIteration:(BOOL)firstIteration {
    
    NSArray *itemDaysArray = [itemDays componentsSeparatedByString:@", "];
    
    NSMutableArray *itemDaysInNumberFormArray = [NSMutableArray array];
    
    for (NSString *day in itemDaysArray) {
        
        NSString *dayCopy = [day mutableCopy];
        //NSLog(@"testing4.1.1 GenerateNextMonthDueDateForRepeatingTask dayCopy:%@", dayCopy);
        if ([dayCopy isEqualToString:@"Last Day"] == NO && [dayCopy isEqualToString:@"Any Day"] == NO) {
            
            dayCopy = [[[NotificationsObject alloc] init] RemoveIntervalCharacters:dayCopy];
            
        }
        
        [itemDaysInNumberFormArray addObject:dayCopy];
        
    }
    
    //NSLog(@"testing4.1.4 GenerateNextMonthDueDateForRepeatingTask itemDaysInNumberFormArray:%@", itemDaysInNumberFormArray);
    
    //Sort Days
    itemDaysInNumberFormArray = [[itemDaysInNumberFormArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        if ([obj1 intValue] == [obj2 intValue])
            return NSOrderedSame;
        
        else if ([obj1 intValue] < [obj2 intValue])
            return NSOrderedAscending;
        
        else
            return NSOrderedDescending;
        
    }] mutableCopy];
    
    //NSLog(@"testing4.1.5 GenerateNextMonthDueDateForRepeatingTask itemDaysInNumberFormArray:%@", itemDaysInNumberFormArray);
    
    if (itemDaysInNumberFormArray.count < itemDaysArray.count) {
        itemDaysInNumberFormArray = [itemDaysArray mutableCopy];
    }
    
    if ([itemDaysInNumberFormArray containsObject:@"Any Day"]) {
        [itemDaysInNumberFormArray removeObject:@"Any Day"];
        [itemDaysInNumberFormArray addObject:@"Any Day"];
    }
    
    if ([itemDaysInNumberFormArray containsObject:@"Last Day"]) {
        [itemDaysInNumberFormArray removeObject:@"Last Day"];
        [itemDaysInNumberFormArray addObject:@"Last Day"];
    }
    
    //NSLog(@"testing4.1.6 GenerateNextMonthDueDateForRepeatingTask itemDaysInNumberFormArray:%@", itemDaysInNumberFormArray);
    
    return itemDaysInNumberFormArray;
}

-(NSDate *)GenerateDueDateFromFirstDayThatHasNotPassedInCurrentMonthOrFirstDayInNextMonth:(NSString *)itemRepeats itemDaysInNumberFormArray:(NSMutableArray *)itemDaysInNumberFormArray dueDateInDateForm:(NSDate *)dueDateInDateForm currentDate:(NSDate *)currentDate itemTime:(NSString *)itemTime firstIteration:(BOOL)firstIteration {
    
    NSDateComponents *componentsForDueDate = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitWeekOfYear|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:dueDateInDateForm];
    
    
    
    //Find First Selected Day That Has Not Passed In Current Month
    BOOL FoundSelectedDayThatHasntPassed = NO;
    
    for (NSString *selectedDayInNumberForm in itemDaysInNumberFormArray) {
        
        int selectedDayToUse = [selectedDayInNumberForm intValue];
        
        if ([selectedDayInNumberForm isEqualToString:@"Last Day"] || [selectedDayInNumberForm isEqualToString:@"Any Day"]) {
            
            int dueDateMonthNum = (int)componentsForDueDate.month;
            int dueDateMonthDays = [[[NotificationsObject alloc] init] GetMonthDayAmountFromMonthNumber:dueDateMonthNum];
            
            selectedDayToUse = dueDateMonthDays;
            
        }
        
      
        
        //First Closest Due Date
        BOOL TaskHasRepeatingIntervals = [[itemRepeats componentsSeparatedByString:@" "] count] > 2;
        
        NSDictionary *dict = [[[NotificationsObject alloc] init] GenerateDictOfDateComponentsAndTimeComponents:dueDateInDateForm currentDate:currentDate itemTime:itemTime];
        
        NSString *hour = dict[@"Hour"];
        NSString *minute = dict[@"Minute"];
        NSDateComponents *componentsForTodayDate = dict[@"ComponentsForTodayDate"];
        
        BOOL FutureDueDateAndTodaysDateAreOnTheSameDay =
        
        (([hour intValue] > componentsForTodayDate.hour) ||
         ([hour intValue] == componentsForTodayDate.hour && [minute intValue] > componentsForTodayDate.minute));
        
        
        if (selectedDayToUse == componentsForDueDate.day && 
            firstIteration == YES &&
            TaskHasRepeatingIntervals == NO &&
            FutureDueDateAndTodaysDateAreOnTheSameDay == YES) {
            
            componentsForDueDate.day = selectedDayToUse;
            FoundSelectedDayThatHasntPassed = YES;
            break;
            
        } else
            
            
            //Second Closest Due Date
            if (selectedDayToUse > componentsForDueDate.day) {
                
                componentsForDueDate.day = selectedDayToUse;
                FoundSelectedDayThatHasntPassed = YES;
                break;
                
            }
        
    }
    
  
    BOOL TaskHasRepeatingIntervals = [[itemRepeats componentsSeparatedByString:@" "] count] > 2;
    
    //All Selected Days Have Passed, Find First Selected Day In The Next Month
    if (FoundSelectedDayThatHasntPassed == NO || (TaskHasRepeatingIntervals == YES && firstIteration == YES)) {
      
        //Set The Next Due Dates Month (& Year)
        BOOL TaskIsRepeatingInterval = [[[BoolDataObject alloc] init] TaskIsRepeatingInterval:[@{@"ItemRepeats" : itemRepeats} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType]];
        
        int intervalNum = 1;
        
        if (TaskIsRepeatingInterval == YES && firstIteration == YES) {
            intervalNum = [[[NotificationsObject alloc] init] GenerateRepeatingInterval:itemRepeats] - 1;
        } else if (TaskIsRepeatingInterval == YES && firstIteration == NO) {
            intervalNum = [[[NotificationsObject alloc] init] GenerateRepeatingInterval:itemRepeats];
        }
       
        int monthNum = (int)componentsForDueDate.month;
       
        monthNum += intervalNum;
       
        if (monthNum > 12) {
            
            componentsForDueDate.year = (int)componentsForDueDate.year + 1;
            componentsForDueDate.month = monthNum - 12;
            
        } else {
            
            componentsForDueDate.month = monthNum;
            
        }
        
        
        //Set The Next Due Date Day Using First Selected Day
        NSString *firstSelectedDayInNumberForm = [itemDaysInNumberFormArray count] > 0 ? itemDaysInNumberFormArray[0] : @"Last Day";
        
        if ([firstSelectedDayInNumberForm isEqualToString:@"Last Day"] || [firstSelectedDayInNumberForm isEqualToString:@"Any Day"]) {
            
            int dueDateMonthNum = (int)componentsForDueDate.month;
            int dueDateMonthDays = [[[NotificationsObject alloc] init] GetMonthDayAmountFromMonthNumber:dueDateMonthNum];
            
            firstSelectedDayInNumberForm = [NSString stringWithFormat:@"%d", dueDateMonthDays];
            
        }
        
        componentsForDueDate.day = [firstSelectedDayInNumberForm intValue];
        
        
        
    }
    
    
    
    dueDateInDateForm = [[NSCalendar currentCalendar] dateFromComponents:componentsForDueDate];
    
    
    
    return dueDateInDateForm;
}

#pragma mark Month (Weekdays)

-(NSMutableArray *)GenerateFutureDueDatesArray:(NSString *)itemDays itemTime:(NSString *)itemTime itemRepeats:(NSString *)itemRepeats dueDateInDateForm:(NSDate *)dueDateInDateForm currentDate:(NSDate *)currentDate dateFormatter:(NSDateFormatter *)dateFormatter firstIteration:(BOOL)firstIteration {
    
    if (itemDays.length == 0) {
        return [NSMutableArray array];
    }
    
    NSArray *itemDaysArray = [itemDays componentsSeparatedByString:@", "];
    
    NSMutableArray *arrayOfFutureDueDateComponentsToReturn = [NSMutableArray array];
    
    NSDateComponents *futureDueDateComponentsToReturn = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitWeekOfYear|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:[NSDate date]];
    NSDateComponents *componentsForDueDate = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitWeekOfYear|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:dueDateInDateForm];
    
    
    //Find All Specific Weekday Due Dates That Have Not Passed Yet
    for (NSString *selectedDay in itemDaysArray) {
        
        
        
        NSString *selectedDayToUse = [selectedDay mutableCopy];
        int dueDateMonthNum = (int)componentsForDueDate.month;
        
        futureDueDateComponentsToReturn = [[[NotificationsObject alloc] init] GenerateFutureDueDateComponents:selectedDayToUse dueDateMonthNum:dueDateMonthNum intervalNum:0 dueDateInDateForm:dueDateInDateForm];
        
        
        
        //        //First Closest Due Date
        //        BOOL TaskHasRepeatingIntervals = [[itemRepeats componentsSeparatedByString:@" "] count] > 2;
        //        
        //        NSDictionary *dict = [[[NotificationsObject alloc] init] GenerateDictOfDateComponentsAndTimeComponents:dueDateInDateForm currentDate:currentDate itemTime:itemTime];
        //        
        //        NSString *hour = dict[@"Hour"];
        //        NSString *minute = dict[@"Minute"];
        //        NSDateComponents *componentsForTodayDate = dict[@"ComponentsForTodayDate"];
        //        
        //        BOOL FutureDueDateAndTodaysDateAreOnTheSameDay =
        //        
        //        (([hour intValue] > componentsForTodayDate.hour) ||
        //         ([hour intValue] == componentsForTodayDate.hour && [minute intValue] > componentsForTodayDate.minute));
        
        
        
        //If The Due Date For This Specific Weekday Has Already Passed Then Look For The Same Weekday In The Next Month
        BOOL FutureDueDateIsEarlierThanCurrentDueDate = ((int)futureDueDateComponentsToReturn.day <= (int)componentsForDueDate.day);
        
        if (FutureDueDateIsEarlierThanCurrentDueDate == YES) {
            
            selectedDayToUse = [selectedDay mutableCopy];
            int dueDateMonthNum = (int)componentsForDueDate.month;
            
            BOOL TaskIsRepeatingInterval = [[[BoolDataObject alloc] init] TaskIsRepeatingInterval:[@{@"ItemRepeats" : itemRepeats} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType]];
            
            //If There Is A Repeating Interval Use The Interval To Find The Next Appropriate Month Else Just Check The Next Month
            int intervalNum =
            (TaskIsRepeatingInterval == YES) ?
            [[[NotificationsObject alloc] init] GenerateRepeatingInterval:itemRepeats] : 1;
            
            futureDueDateComponentsToReturn = [[[NotificationsObject alloc] init] GenerateFutureDueDateComponents:selectedDayToUse dueDateMonthNum:dueDateMonthNum intervalNum:intervalNum dueDateInDateForm:dueDateInDateForm];
            
        }
        
        
        
        [arrayOfFutureDueDateComponentsToReturn addObject:futureDueDateComponentsToReturn];
        
    }
    
    
    //Create Array Of Due Dates Using Due Date Components
    NSMutableArray *arrayOfFutureDueDates = [NSMutableArray array];
    
    for (NSDateComponents *dateComponents in arrayOfFutureDueDateComponentsToReturn) {
        
        NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
        NSString *futureDateDate = [dateFormatter stringFromDate:date];
        [arrayOfFutureDueDates addObject:futureDateDate];
        
    }
    
    return arrayOfFutureDueDates;
}

#pragma mark Month (Days & Weekdays)

-(NSDictionary *)GenerateDayArray:(NSString *)itemDays {
    
    NSMutableArray *itemDaysArray = [[itemDays componentsSeparatedByString:@", "] mutableCopy];
    NSMutableArray *monthWeekdayArray = [NSMutableArray array];
    NSMutableArray *monthDayArray = [NSMutableArray array];
    
    NSString *monthDayStringArray = @"";
    NSString *monthWeekdayStringArray = @"";
    
    //Create Month Days Array
    for (NSString *day in itemDaysArray) {
        
        BOOL DayIsMonthDay = ([day containsString:@"day"] == NO || [day isEqualToString:@"Last Day"] || [day isEqualToString:@"Any Day"]);
        
        if (DayIsMonthDay == YES) {
            
            [monthDayArray addObject:day];
            
        }
        
    }
    
    //Create Month Weekdays Array
    for (NSString *day in itemDaysArray) {
        
        if ([monthDayArray containsObject:day] == NO) {
            
            [monthWeekdayArray addObject:day];
            
        }
        
    }
    
    //Create Month Day String
    for (NSString *day in monthDayArray) {
        
        monthDayStringArray =
        monthDayStringArray.length == 0 ?
        day : [NSString stringWithFormat:@"%@, %@", monthDayStringArray, day];
        
    }
    
    //Create Month Weekday String
    for (NSString *day in monthWeekdayArray) {
        
        monthWeekdayStringArray =
        monthWeekdayStringArray.length == 0 ?
        day : [NSString stringWithFormat:@"%@, %@", monthWeekdayStringArray, day];
        
    }
    
    return @{@"MonthDays" : monthDayStringArray, @"MonthWeekdays" : monthWeekdayStringArray};
}

#pragma mark Multiple

-(NSString *)GenerateItemRepeatWithTranslatedNewRepeatingOptions:(NSString *)itemRepeats {
    
    NSString *translatedItemRepeats = itemRepeats;
    
    if ([itemRepeats isEqualToString:@"Bi-Weekly"]) {
        
        translatedItemRepeats = @"Every Other Week";
        
    } else if ([itemRepeats isEqualToString:@"Semi-Monthly"]) {
        
        translatedItemRepeats = @"Monthly";
        
    }
    
    return translatedItemRepeats;
}

-(NSDate *)GenerateDueDateToStartFrom:(NSString *)dateToBegin potentialFutureDueDate:(NSString *)potentialFutureDueDate itemRepeats:(NSString *)itemRepeats itemRepeatIfCompletedEarly:(NSString *)itemRepeatIfCompletedEarly itemDays:(NSString *)itemDays itemDatePosted:(NSString *)itemDatePosted itemDueDate:(NSString *)itemDueDate firstIteration:(BOOL)firstIteration {
    
    NSString *dateToUse = firstIteration || [potentialFutureDueDate length] == 0 ? dateToBegin : potentialFutureDueDate;
    
    NSDateFormatter *dateFormatter = [[[GeneralObject alloc] init] GenerateDateFormatWithString:@"MMMM dd, yyyy hh:mm a"];
    
    NSDate *dueDateInDateForm = [NSDate date];
    
    BOOL ObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:dateToUse classArr:@[[NSString class]]];
    
    if (dateToUse != nil && dateToUse != NULL && ObjectIsKindOfClass == YES && dateToUse.length > 0) {
        dueDateInDateForm = [dateFormatter dateFromString:dateToUse];
    }
    
    if (itemDays.length > 0 && itemDueDate.length > 0) {
        
        BOOL TaskIsRepeatingAndRepeatingIfCompletedEarly = [[[BoolDataObject alloc] init] TaskIsRepeatingAndRepeatingIfCompletedEarly:[@{@"ItemRepeats" : itemRepeats, @"ItemRepeatIfCompletedEarly" : itemRepeatIfCompletedEarly} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType]];
        BOOL TaskHasAnyDay = [[[BoolDataObject alloc] init] TaskHasAnyDay:[@{@"ItemDays" : itemDays, @"ItemRepeats" : itemRepeats} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType]];
        
        BOOL TaskIsRepeatingAndRepeatingIfCompletedEarlyWithSpecificDaysSelected = (((TaskIsRepeatingAndRepeatingIfCompletedEarly == YES && TaskHasAnyDay == NO))); //|| (TaskIsRepeatingWhenCompleted == NO))); //&& firstIteration == NO);
        
        //If Task Is Repeating When Completed       And Has Specific Day,                              Find The Amount Of Days Starting From Current Item Due Date
        //If Task Is Not Repeating When Completed   (Specific Day and Any Day Are Treated The Same),   Find The Amount Of Days Starting From Current Item Due Date
        if (TaskIsRepeatingAndRepeatingIfCompletedEarlyWithSpecificDaysSelected == YES) {
            
            //If Not Editing Task Begin With Current Item Due Date
            if ((![[NSUserDefaults standardUserDefaults] objectForKey:@"EditingTaskWithoutAlteringDueDateData"] ||
                 [[[NSUserDefaults standardUserDefaults] objectForKey:@"EditingTaskWithoutAlteringDueDateData"] isEqualToString:@"No"]) ||
                (![[NSUserDefaults standardUserDefaults] objectForKey:@"EditingTaskWithoutAlteringDueDateData1"] ||
                 [[[NSUserDefaults standardUserDefaults] objectForKey:@"EditingTaskWithoutAlteringDueDateData1"] isEqualToString:@"No"])) {
                
                //Removed For Getting The Next Due Date When Editting Task
                dueDateInDateForm = [dateFormatter dateFromString:itemDueDate];
                
            }
            
        }
        
    }
    
    return dueDateInDateForm;
}

-(NSDate *)GenerateDueDateToAddDaysOrHoursTo:(NSString *)itemRepeats itemRepeatIfCompletedEarly:(NSString *)itemRepeatIfCompletedEarly itemDays:(NSString *)itemDays currentDate:(NSDate *)currentDate dueDateInDateForm:(NSDate *)dueDateInDateForm {
    
    //    BOOL TaskIsRepeatingAndRepeatingIfCompletedEarly = [[[BoolDataObject alloc] init] TaskIsRepeatingAndRepeatingIfCompletedEarly:[@{@"ItemRepeats" : itemRepeats, @"ItemRepeatIfCompletedEarly" : itemRepeatIfCompletedEarly} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType]];
    //    BOOL TaskHasAnyDay = [[[BoolDataObject alloc] init] TaskHasAnyDay:[@{@"ItemDays" : itemDays, @"ItemRepeats" : itemRepeats} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType]];
    //
    //    BOOL CheckingForNextDayDueDate = itemDays.length == 0;
    //
    //    //If Weekly Or Monthly Repeating Task Is Repeating When Completed And Any Day Is Selected, Add Days To Current Due Date
    //    //If Daily Repeating Task Is Repeating When Completed, Add Days To Current Due Date
    //    BOOL TaskIsRepeatingAndRepeatingIfCompletedEarlyAndAnyDayHasBeenSelected = (TaskIsRepeatingAndRepeatingIfCompletedEarly && (TaskHasAnyDay || CheckingForNextDayDueDate));
    
    //    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"FindAllFutureDueDates"] &&
    //        [[[NSUserDefaults standardUserDefaults] objectForKey:@"FindAllFutureDueDates"] isEqualToString:@"Yes"]) {
    
    dueDateInDateForm = dueDateInDateForm;
    
    //    } else {
    //
    //        dueDateInDateForm = TaskIsRepeatingWhenCompletedAndAnyDayHasBeenSelected == YES ? currentDate : dueDateInDateForm;
    //
    //    }
    
    return dueDateInDateForm;
}

-(NSString *)GenerateDueDateWithDayligHasvingsTime:(NSString *)itemDueDate itemTime:(NSString *)itemTime {
    
    NSDateFormatter *dateFormatter = [[[GeneralObject alloc] init] GenerateDateFormatWithString:@"MMMM dd, yyyy hh:mm a"];
    
    if (![itemDueDate containsString:itemTime]) {
        
        NSDate *newItemDueDate = [dateFormatter dateFromString:itemDueDate];
        
        itemDueDate = [[[GeneralObject alloc] init] GenerateDateWithAddedTimeWithFormat:@"MMMM dd, yyyy hh:mm a" dateToAddTimeTo:newItemDueDate timeToAdd:-1*(60*60) returnAs:[NSString class]];
        
        if (![itemDueDate containsString:itemTime]) {
            itemDueDate = [[[GeneralObject alloc] init] GenerateDateWithAddedTimeWithFormat:@"MMMM dd, yyyy hh:mm a" dateToAddTimeTo:newItemDueDate timeToAdd:2*(60*60) returnAs:[NSString class]];
        }
        
    }
    
    if (![itemDueDate containsString:itemTime]) {
        
        NSDate *newItemDueDate = [dateFormatter dateFromString:itemDueDate];
        itemDueDate = [[[GeneralObject alloc] init] GenerateDateWithAddedTimeWithFormat:@"MMMM dd, yyyy hh:mm a" dateToAddTimeTo:newItemDueDate timeToAdd:(60*60) returnAs:[NSString class]];
        
        if (![itemDueDate containsString:itemTime]) {
            
            NSDate *newItemDueDate = [dateFormatter dateFromString:itemDueDate];
            itemDueDate = [[[GeneralObject alloc] init] GenerateDateWithAddedTimeWithFormat:@"MMMM dd, yyyy hh:mm a" dateToAddTimeTo:newItemDueDate timeToAdd:-2*(60*60) returnAs:[NSString class]];
            
        }
        
    }
    
    return itemDueDate;
    
}

-(NSString *)GenerateDueDateWithCorrectTime:(NSString *)itemDueDate itemTime:(NSString *)itemTime {
    
    if ([itemTime isEqualToString:@"Any Time"]) {
        itemTime = @"11:59 PM";
    }
    
    NSMutableArray *splitDueDateArray = [[itemDueDate componentsSeparatedByString:@" "] mutableCopy];
    NSArray *splitHourMinuteAMPM = [itemTime componentsSeparatedByString:@" "];//@[@"11:59", @"PM"];
    
    int hourMinuteIndex = 3;
    int AMPMIndex = 4;
    
    NSString *hourMinute = [splitHourMinuteAMPM count] > 0 ? splitHourMinuteAMPM[0] : @"11:59";
    NSString *AMPM = [splitHourMinuteAMPM count] > 1 ? splitHourMinuteAMPM[1] : @"PM";
    
    if ([splitDueDateArray count] > hourMinuteIndex) { [splitDueDateArray replaceObjectAtIndex:hourMinuteIndex withObject:hourMinute]; }
    if ([splitDueDateArray count] > AMPMIndex) { [splitDueDateArray replaceObjectAtIndex:AMPMIndex withObject:AMPM]; }
    
    NSString *dueDateWithCorrectTime = @"";
    
    for (NSString *dueDateComp in splitDueDateArray) {
        
        if (dueDateWithCorrectTime.length == 0) {
            
            dueDateWithCorrectTime = dueDateComp;
            
        } else {
            
            dueDateWithCorrectTime = [NSString stringWithFormat:@"%@ %@", dueDateWithCorrectTime, dueDateComp];
            
        }
        
    }
    
    return dueDateWithCorrectTime;
    
}

-(NSDictionary *)GenerateDaysOrHoursToAddAndDueDateIfYouAreEditingNonDueDateAspectsOfTask:(NSDate *)dueDateInDateForm daysToAdd:(int)daysToAdd dateFormatter:(NSDateFormatter *)dateFormatter itemDueDate:(NSString *)itemDueDate {
    
    //If Editing Task, Don't Add Any Days And Return The Current Item Due Date
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"EditingTaskWithoutAlteringDueDateData"] isEqualToString:@"Yes"]) {
        
        [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"EditingTaskWithoutAlteringDueDateData"];
        daysToAdd = 0;
        
        if ([itemDueDate length] > 0) {
            
            itemDueDate = [[[GeneralObject alloc] init] GenerateStringWithReplacementString:itemDueDate stringToReplace:@"Any Time" replacementString:@"11:59 PM"];
            
            dueDateInDateForm = [dateFormatter dateFromString:itemDueDate];
            
            if (dueDateInDateForm == nil || dueDateInDateForm == NULL) {
                
                NSDateFormatter *dateFormatter = [[[GeneralObject alloc] init] GenerateDateFormatWithString:@"MMMM dd, yyyy hh:mm a"];
                dueDateInDateForm = [dateFormatter dateFromString:itemDueDate];
                
            }
            
            if (dueDateInDateForm == nil || dueDateInDateForm == NULL) {
                
                NSDateFormatter *dateFormatter = [[[GeneralObject alloc] init] GenerateDateFormatWithString:@"MMMM dd, yyyy h:mm a"];
                dueDateInDateForm = [dateFormatter dateFromString:itemDueDate];
                
            }
            
        }
        
    }
    
    if (dueDateInDateForm == nil || dueDateInDateForm == NULL) {
        
        dueDateInDateForm = [NSDate date];
        
    }
    
    return @{@"DueDate" : dueDateInDateForm, @"DaysToAdd" : [NSString stringWithFormat:@"%d", daysToAdd]};
}

-(NSString *)GenerateDueDateWithDaysToAddAndCorrectTime:(NSDate *)dueDateInDateForm itemTime:(NSString *)itemTime daysToAdd:(int)daysToAdd dateFormat:(NSString *)dateFormat firstIteration:(BOOL)firstIteration {
    
    NSString *dueDate = [[[GeneralObject alloc] init] GenerateDateWithAddedTimeWithFormat:dateFormat dateToAddTimeTo:dueDateInDateForm timeToAdd:60*60*24*daysToAdd returnAs:[NSString class]];
    
    if (firstIteration == NO) {
        
        dueDate = [[[NotificationsObject alloc] init] GenerateDueDateWithDayligHasvingsTime:dueDate itemTime:itemTime];
        
    }
    
    NSString *dueDateWithCorrectTime = [[[NotificationsObject alloc] init] GenerateDueDateWithCorrectTime:dueDate itemTime:itemTime];
    
    return dueDateWithCorrectTime;
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Sub-Sub-Internal Methods
#pragma mark
#pragma mark
#pragma mark -

#pragma mark Reminder Notification Methods

-(NSString *)GenerateDueNowBodyOption1:(NSMutableArray *)itemAssignedTo homeMembersDict:(NSMutableDictionary *)homeMembersDict itemCompletedDict:(NSMutableDictionary *)itemCompletedDict itemGracePeriod:(NSString *)itemGracePeriod itemType:(NSString *)itemType {
    
    BOOL ItemHasGracePeriod = [[[BoolDataObject alloc] init] TaskHasGracePeriod:[@{@"ItemGracePeriod" : itemGracePeriod} mutableCopy] itemType:itemType];
    
    NSMutableArray *itemNotCompletedBy = [NSMutableArray array];
    
    for (NSString *assignedTo in itemAssignedTo) {
        
        BOOL taskCompletedByThisUser = false;
        
        for (NSString *completedBy in [itemCompletedDict allKeys]) {
            
            if ([assignedTo isEqualToString:completedBy]) {
                
                taskCompletedByThisUser = true;
                
            }
            
        }
        
        if (taskCompletedByThisUser == false) {
            
            [itemNotCompletedBy addObject:assignedTo];
            
        }
        
    }
    
    NSMutableArray *itemNotCompletedByUsername = [NSMutableArray array];
    
    for (NSString *userID in itemNotCompletedBy) {
        
        if ([itemAssignedTo containsObject:userID]) {
            
            NSDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:userID homeMembersDict:homeMembersDict];
            NSString *username = dataDict[@"Username"];
            
            if ([username length] > 0) { [itemNotCompletedByUsername addObject:username]; }
            
        }
        
    }
    
    NSString *dueNowOrGracePeriod = ItemHasGracePeriod == YES ? [NSString stringWithFormat:@"This %@s grace period is over.", [itemType lowercaseString]] : [NSString stringWithFormat:@"This %@ is due now.", [itemType lowercaseString]];
    NSString *notificationBody = [itemNotCompletedByUsername count] > 0 ? [NSString stringWithFormat:@"%@ It was not completed it in time. 😪", dueNowOrGracePeriod] : [NSString stringWithFormat:@"🎊 This %@ has been completed by everyone! 🎊", [itemType lowercaseString]];
    
    return notificationBody;
    
}

-(NSString *)GenerateDueNowBodyOption2:(NSMutableArray *)itemAssignedTo homeMembersDict:(NSMutableDictionary *)homeMembersDict itemCompletedDict:(NSMutableDictionary *)itemCompletedDict itemGracePeriod:(NSString *)itemGracePeriod itemTakeTurns:(NSString *)itemTakeTurns itemAlternateTurns:(NSString *)itemAlternateTurns itemTurnUsername:(NSString *)itemTurnUsername itemType:(NSString *)itemType {
    
    BOOL ItemHasGracePeriod = [[[BoolDataObject alloc] init] TaskHasGracePeriod:[@{@"ItemGracePeriod" : itemGracePeriod} mutableCopy] itemType:itemType];
    
    NSMutableArray *itemNotCompletedBy = [NSMutableArray array];
    
    for (NSString *assignedTo in itemAssignedTo) {
        
        BOOL taskCompletedByThisUser = false;
        
        for (NSString *completedBy in [itemCompletedDict allKeys]) {
            
            if ([assignedTo isEqualToString:completedBy]) {
                
                taskCompletedByThisUser = true;
                
            }
            
        }
        
        if (taskCompletedByThisUser == false) {
            
            [itemNotCompletedBy addObject:assignedTo];
            
        }
        
    }
    
    NSMutableArray *itemNotCompletedByUsername = [NSMutableArray array];
    
    for (NSString *userID in itemNotCompletedBy) {
        
        if ([itemAssignedTo containsObject:userID]) {
            
            NSDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:userID homeMembersDict:homeMembersDict];
            NSString *username = dataDict[@"Username"];
            
            if ([username length] > 0) { [itemNotCompletedByUsername addObject:username]; }
            
        }
        
    }
    
    if ([itemTakeTurns isEqualToString:@"Yes"] && [[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"] length] > 0) {
        itemNotCompletedByUsername = [@[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"]] mutableCopy];
    }
    
    NSString *personString = [itemNotCompletedByUsername count] != 1 ? @"people" : @"person";
    NSString *nextTurnString = [itemTakeTurns isEqualToString:@"Yes"] && [[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"] length] > 0 && [itemAlternateTurns isEqualToString:@"Completion"] ? [NSString stringWithFormat:@" It is still %@'s turn.", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"]] : @"";
    NSString *completedByEveryoneNotificationBody = [NSString stringWithFormat:@"🎊 This %@ has been completed by everyone! 🎊", [itemType lowercaseString]];
    
    NSString *dueNowOrGracePeriod =
    ItemHasGracePeriod == YES ?
    [NSString stringWithFormat:@"This %@s grace period is over.", [itemType lowercaseString]] :
    [NSString stringWithFormat:@"This %@ is due now.", [itemType lowercaseString]];
    
    NSString *notificationBody =
    [itemNotCompletedByUsername count] > 0 ?
    [NSString stringWithFormat:@"%@ %lu %@ did not complete it in time. 😪%@", dueNowOrGracePeriod, (unsigned long)[itemNotCompletedByUsername count], personString, nextTurnString]:
    completedByEveryoneNotificationBody;
    
    return notificationBody;
    
}

-(NSString *)GenerateDueNowBodyOption3:(NSMutableArray *)itemAssignedTo homeMembersDict:(NSMutableDictionary *)homeMembersDict itemCompletedDict:(NSMutableDictionary *)itemCompletedDict itemGracePeriod:(NSString *)itemGracePeriod itemTakeTurns:(NSString *)itemTakeTurns itemAlternateTurns:(NSString *)itemAlternateTurns itemTurnUsername:(NSString *)itemTurnUsername itemType:(NSString *)itemType {
    
    BOOL ItemHasGracePeriod = [[[BoolDataObject alloc] init] TaskHasGracePeriod:[@{@"ItemGracePeriod" : itemGracePeriod} mutableCopy] itemType:itemType];
    
    NSMutableArray *itemNotCompletedBy = [NSMutableArray array];
    
    for (NSString *assignedTo in itemAssignedTo) {
        
        BOOL taskCompletedByThisUser = false;
        
        for (NSString *completedBy in [itemCompletedDict allKeys]) {
            
            if ([assignedTo isEqualToString:completedBy]) {
                
                taskCompletedByThisUser = true;
                
            }
            
        }
        
        if (taskCompletedByThisUser == false) {
            
            [itemNotCompletedBy addObject:assignedTo];
            
        }
        
    }
    
    NSMutableArray *itemNotCompletedByUsername = [NSMutableArray array];
    
    for (NSString *userID in itemNotCompletedBy) {
        
        if ([itemAssignedTo containsObject:userID]) {
            
            NSDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:userID homeMembersDict:homeMembersDict];
            NSString *username = dataDict[@"Username"];
            
            if ([username length] > 0) { [itemNotCompletedByUsername addObject:username]; }
            
        }
        
    }
    
    if ([itemTakeTurns isEqualToString:@"Yes"] && [[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"] length] > 0) {
        itemNotCompletedByUsername = [@[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"]] mutableCopy];
    }
    
    NSString *notificationBody = @"";
    NSString *dueNowOrGracePeriod =
    ItemHasGracePeriod == YES ?
    [NSString stringWithFormat:@"This %@s grace period is over.", [itemType lowercaseString]] :
    [NSString stringWithFormat:@"This %@ is due now.", [itemType lowercaseString]];
    NSString *nextTurnString = [itemTakeTurns isEqualToString:@"Yes"] && [[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"] length] > 0 && [itemAlternateTurns isEqualToString:@"Completion"] ? [NSString stringWithFormat:@" It is still %@'s turn.", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"]] : @"";
    
    if (itemNotCompletedByUsername.count == 1) {
        
        notificationBody = [NSString stringWithFormat:@"%@ %@ did not complete it in time. 😪%@", dueNowOrGracePeriod, itemNotCompletedByUsername[0], nextTurnString];
        
    } else if (itemNotCompletedByUsername.count > 1) {
        
        notificationBody = [NSString stringWithFormat:@"This %@ is due now. ", [itemType lowercaseString]];
        
        for (int i=0;i<itemNotCompletedByUsername.count;i++) {
            
            if (i == 0) {
                
                notificationBody = [NSString stringWithFormat:@"%@%@", notificationBody, itemNotCompletedByUsername[i]];
                
            } else if (i == itemNotCompletedByUsername.count-1) {
                
                NSString *commaString = itemNotCompletedByUsername.count == 2 ? @"" : @",";
                
                notificationBody = [NSString stringWithFormat:@"%@%@ and %@ did not complete it in time. 😪%@", notificationBody, commaString, itemNotCompletedByUsername[itemNotCompletedByUsername.count-1], nextTurnString];
                
            } else {
                
                notificationBody = [NSString stringWithFormat:@"%@, %@", notificationBody, itemNotCompletedByUsername[i]];
                
            }
            
        }
        
    }
    
    if (itemNotCompletedByUsername.count == 0) {
        notificationBody = [NSString stringWithFormat:@"🎊 This %@ has been completed by everyone! 🎊", [itemType lowercaseString]];
    }
    
    return notificationBody;
}

#pragma mark

-(NSString *)GenerateDueNowBodyOption1NobodyAssigned:(NSMutableArray *)itemAssignedTo homeMembersDict:(NSMutableDictionary *)homeMembersDict itemCompletedDict:(NSMutableDictionary *)itemCompletedDict itemGracePeriod:(NSString *)itemGracePeriod itemType:(NSString *)itemType {
    
    BOOL ItemHasGracePeriod = [[[BoolDataObject alloc] init] TaskHasGracePeriod:[@{@"ItemGracePeriod" : itemGracePeriod} mutableCopy] itemType:itemType];
    
    NSMutableArray *itemCompletedBy = [NSMutableArray array];
    
    for (NSString *assignedTo in itemAssignedTo) {
        
        BOOL taskCompletedByThisUser = false;
        
        for (NSString *completedBy in [itemCompletedDict allKeys]) {
            
            if ([assignedTo isEqualToString:completedBy]) {
                
                taskCompletedByThisUser = true;
                
            }
            
        }
        
        if (taskCompletedByThisUser == true) {
            
            [itemCompletedBy addObject:assignedTo];
            
        }
        
    }
    
    NSMutableArray *itemCompletedByUsername = [NSMutableArray array];
    
    for (NSString *userID in itemCompletedBy) {
        
        if ([itemAssignedTo containsObject:userID]) {
            
            NSDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:userID homeMembersDict:homeMembersDict];
            NSString *username = dataDict[@"Username"];
            
            if ([username length] > 0) { [itemCompletedByUsername addObject:username]; }
            
        }
        
    }
    
    NSString *dueNowOrGracePeriod = ItemHasGracePeriod == YES ? [NSString stringWithFormat:@"This %@s grace period is over.", [itemType lowercaseString]] : [NSString stringWithFormat:@"This %@ is due now.", [itemType lowercaseString]];
    NSString *notificationBody = [itemAssignedTo count] >= [itemCompletedByUsername count] ? [NSString stringWithFormat:@"%@ It was completed in time. 🎉", dueNowOrGracePeriod] : [NSString stringWithFormat:@"%@ It was not completed in time. 😪", dueNowOrGracePeriod];
    
    return notificationBody;
    
}

-(NSString *)GenerateDueNowBodyOption2NobodyAssigned:(NSMutableArray *)itemAssignedTo homeMembersDict:(NSMutableDictionary *)homeMembersDict itemCompletedDict:(NSMutableDictionary *)itemCompletedDict itemGracePeriod:(NSString *)itemGracePeriod itemType:(NSString *)itemType {
    
    BOOL ItemHasGracePeriod = [[[BoolDataObject alloc] init] TaskHasGracePeriod:[@{@"ItemGracePeriod" : itemGracePeriod} mutableCopy] itemType:itemType];
    
    NSMutableArray *itemCompletedBy = [NSMutableArray array];
    
    for (NSString *assignedTo in itemAssignedTo) {
        
        BOOL taskCompletedByThisUser = false;
        
        for (NSString *completedBy in [itemCompletedDict allKeys]) {
            
            if ([assignedTo isEqualToString:completedBy]) {
                
                taskCompletedByThisUser = true;
                
            }
            
        }
        
        if (taskCompletedByThisUser == true) {
            
            [itemCompletedBy addObject:assignedTo];
            
        }
        
    }
    
    NSMutableArray *itemCompletedByUsername = [NSMutableArray array];
    
    for (NSString *userID in itemCompletedBy) {
        
        if ([itemAssignedTo containsObject:userID]) {
            
            NSDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:userID homeMembersDict:homeMembersDict];
            NSString *username = dataDict[@"Username"];
            
            if ([username length] > 0) { [itemCompletedByUsername addObject:username]; }
            
        }
        
    }
    
    NSString *dueNowOrGracePeriod = ItemHasGracePeriod == YES ? [NSString stringWithFormat:@"This %@s grace period is over.", [itemType lowercaseString]] : [NSString stringWithFormat:@"This %@ is due now.", [itemType lowercaseString]];
    NSString *notificationBody = [itemCompletedByUsername count] > 0 ? [NSString stringWithFormat:@"%@ %lu %@ completed it in time. 🎉", dueNowOrGracePeriod, (unsigned long)[itemCompletedByUsername count], [itemCompletedByUsername count] != 1 ? @"people" : @"person"] : [NSString stringWithFormat:@"This %@ is due now. Nobody has completed it in time. 😪", [itemType lowercaseString]];
    
    return notificationBody;
    
}

-(NSString *)GenerateDueNowBodyOption3NobodyAssigned:(NSMutableArray *)itemAssignedTo homeMembersDict:(NSMutableDictionary *)homeMembersDict itemCompletedDict:(NSMutableDictionary *)itemCompletedDict itemGracePeriod:(NSString *)itemGracePeriod itemType:(NSString *)itemType {
    
    BOOL ItemHasGracePeriod = [[[BoolDataObject alloc] init] TaskHasGracePeriod:[@{@"ItemGracePeriod" : itemGracePeriod} mutableCopy] itemType:itemType];
    
    NSMutableArray *itemCompletedBy = [NSMutableArray array];
    
    for (NSString *assignedTo in itemAssignedTo) {
        
        BOOL taskCompletedByThisUser = false;
        
        for (NSString *completedBy in [itemCompletedDict allKeys]) {
            
            if ([assignedTo isEqualToString:completedBy]) {
                
                taskCompletedByThisUser = true;
                
            }
            
        }
        
        if (taskCompletedByThisUser == true) {
            
            [itemCompletedBy addObject:assignedTo];
            
        }
        
    }
    
    NSMutableArray *itemCompletedByUsername = [NSMutableArray array];
    
    for (NSString *userID in itemCompletedBy) {
        
        if ([itemAssignedTo containsObject:userID]) {
            
            NSDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:userID homeMembersDict:homeMembersDict];
            NSString *username = dataDict[@"Username"];
            
            if ([username length] > 0) { [itemCompletedByUsername addObject:username]; }
            
        }
        
    }
    
    NSString *notificationBody = @"";
    NSString *dueNowOrGracePeriod = ItemHasGracePeriod == YES ? [NSString stringWithFormat:@"This %@s grace period is over.", [itemType lowercaseString]] : [NSString stringWithFormat:@"This %@ is due now.", [itemType lowercaseString]];
    
    if (itemCompletedByUsername.count == 1) {
        
        notificationBody = [NSString stringWithFormat:@"🎉 %@ %@ completed it in time! 🎉", dueNowOrGracePeriod, itemCompletedByUsername[0]];
        
    } else if (itemCompletedByUsername.count > 1) {
        
        notificationBody = [NSString stringWithFormat:@"This %@ is due now. ", [itemType lowercaseString]];
        
        for (int i=0;i<itemCompletedByUsername.count;i++) {
            
            if (i == 0) {
                
                notificationBody = [NSString stringWithFormat:@"%@%@", notificationBody, itemCompletedByUsername[i]];
                
            } else if (i == itemCompletedByUsername.count-1) {
                
                NSString *commaString = itemCompletedByUsername.count == 2 ? @"" : @",";
                
                notificationBody = [NSString stringWithFormat:@"%@%@ and %@ completed it in time! 🎉", notificationBody, commaString, itemCompletedByUsername[itemCompletedByUsername.count-1]];
                
            } else {
                
                notificationBody = [NSString stringWithFormat:@"%@, %@", notificationBody, itemCompletedByUsername[i]];
                
            }
            
        }
        
    }
    
    if (itemCompletedByUsername.count >= [itemAssignedTo count]) {
        notificationBody = [NSString stringWithFormat:@"🎊 This %@ has been completed by everyone! 🎊", [itemType lowercaseString]];
    }
    
    if (itemCompletedByUsername.count == 0) {
        notificationBody = [NSString stringWithFormat:@"This %@ is due now. Nobody has completed it in time. 😪", [itemType lowercaseString]];
    }
    
    return notificationBody;
    
}

#pragma mark

-(NSString *)GenerateReminderBodyOption1:(NSString *)itemType amountOfTime:(NSString *)amountOfTime {
    
    NSString *selectedReminderBody = [NSString stringWithFormat:@"This %@ is due in %@. Remember to mark it as completed so everyone knows! 😄", [itemType lowercaseString], [amountOfTime lowercaseString]];
    
    return selectedReminderBody;
}

-(NSString *)GenerateReminderBodyOption2:(NSString *)itemType itemAssignedTo:(NSMutableArray *)itemAssignedTo itemCompletedDict:(NSMutableDictionary *)itemCompletedDict amountOfTime:(NSString *)amountOfTime {
    
    int amountOfUsersNotCompleted = 0;
    NSString *personPeopleString = amountOfUsersNotCompleted != 1 ? @"people" : @"person";
    
    for (NSString *userID in itemAssignedTo) {
        
        if ([[itemCompletedDict allKeys] containsObject:userID]) {
            
            amountOfUsersNotCompleted += 1;
            
        }
        
    }
    
    NSString *selectedReminderBody = [NSString stringWithFormat:@"This %@ is due in %@ and %d %@ haven't completed it yet. Remember to mark it as completed so everyone knows! 😄", [itemType lowercaseString], [amountOfTime lowercaseString], amountOfUsersNotCompleted, personPeopleString];
    
    return selectedReminderBody;
}

-(NSString *)GenerateReminderBodyOption3:(NSString *)itemType itemAssignedTo:(NSMutableArray *)itemAssignedTo itemCompletedDict:(NSMutableDictionary *)itemCompletedDict homeMembersDict:(NSMutableDictionary *)homeMembersDict amountOfTime:(NSString *)amountOfTime {
    
    NSMutableArray *itemAssignedToUsername = [NSMutableArray array];
    NSString *whenDueString = @"";
    
    for (NSString *userID in itemAssignedTo) {
        
        if ([[itemCompletedDict allKeys] containsObject:userID] == NO) {
            
            if ([homeMembersDict[@"UserID"] containsObject:userID]) {
                
                NSUInteger index = [homeMembersDict[@"UserID"] indexOfObject:userID];
                NSString *username = homeMembersDict && homeMembersDict[@"Username"] && [(NSArray *)homeMembersDict[@"Username"] count] > index ? homeMembersDict[@"Username"][index] : @"";
                [itemAssignedToUsername addObject:username];
                
            }
            
        }
        
    }
    
    if (itemAssignedToUsername.count == 1) {
        
        whenDueString = [NSString stringWithFormat:@"%@ haven't completed it yet", itemAssignedToUsername[0]];
        
    } else if (itemAssignedToUsername.count > 1) {
        
        for (int i=0;i<itemAssignedToUsername.count;i++) {
            
            if (i == 0) {
                
                whenDueString = [NSString stringWithFormat:@"%@", itemAssignedToUsername[i]];
                
            } else if (i == itemAssignedToUsername.count-1) {
                
                NSString *commaString = itemAssignedToUsername.count == 2 ? @"" : @",";
                
                whenDueString = [NSString stringWithFormat:@"%@%@ and %@ haven't completed it yet", whenDueString, commaString, itemAssignedToUsername[itemAssignedToUsername.count-1]];
                
            } else {
                
                whenDueString = [NSString stringWithFormat:@"%@, %@", whenDueString, itemAssignedToUsername[i]];
                
            }
            
        }
        
    }
    
    NSString *selectedReminderBody = [NSString stringWithFormat:@"This %@ is due in %@. %@. Remember to mark it as completed so everyone knows! 😄", [itemType lowercaseString], [amountOfTime lowercaseString], whenDueString];
    
    return selectedReminderBody;
}

#pragma mark

-(long)GenerateReminderAnyTimeNotificationHoursBefore:(NSString *)itemReminder itemGracePeriod:(NSString *)itemGracePeriod {
    
    if ([itemReminder containsString:@"On The Day"] || [itemReminder containsString:@"Day Before"] || [itemReminder containsString:@"Days Before"]) {
        
        NSArray *arr = [[itemReminder mutableCopy] componentsSeparatedByString:@" Day"];
        int daySeconds = [itemReminder containsString:@"On The Day"] && [arr count] > 0 ? 0 : [arr[0] intValue] * 86400;
        
        // Create an instance of NSCalendar
        NSCalendar *calendar = [NSCalendar currentCalendar];
        
        // Create an instance of NSDateFormatter
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"hh:mm a"]; // Set the format of the input date string
        
        arr = [[itemReminder mutableCopy] componentsSeparatedByString:@" at "];
        
        // Specify the date string
        NSString *dateString = [arr count] > 1 ? arr[1] : @""; // Example date string
        
        // Convert the date string to an NSDate object
        NSDate *date = [dateFormatter dateFromString:dateString];
        
        // Extract the date components from the NSDate object
        NSDateComponents *startDateComponents = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:date];
        
        // Convert the date string to an NSDate object
        date = [dateFormatter dateFromString:@"11:59 PM"];
        
        // Specify the end date components
        NSDateComponents *endDateComponents = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:date];
        
        // Create NSDate objects from the specified date components
        NSDate *startDate = [calendar dateFromComponents:startDateComponents];
        NSDate *endDate = [calendar dateFromComponents:endDateComponents];
        
        // Calculate the time interval between the start and end dates
        NSTimeInterval timeInterval = [endDate timeIntervalSinceDate:startDate];
        
        // Convert the time interval to minutes or hours as desired
        NSInteger hours = lround((timeInterval+daySeconds) / 3600);
        
        
        int gracePeriodSeconds = [[[GeneralObject alloc] init] GenerateSecondsFromDisplayTime:itemGracePeriod] / 3600;
        
        hours += gracePeriodSeconds;
        
        return hours;
    }
    
    return 0;
}

-(NSString *)GenerateReminderAnyTimeNotificationDueString:(NSString *)itemReminder {
    
    NSString *dueString = @"soon";
    
    if ([itemReminder containsString:@"On The Day"]) {
        
        dueString = @"today";
        
    } else if ([itemReminder containsString:@"Day Before"] || [itemReminder containsString:@"Days Before"]) {
        
        NSArray *arr = [itemReminder componentsSeparatedByString:@" "];
        dueString = [arr count] > 0 ? [NSString stringWithFormat:@"in %@ day%@", arr[0], [arr[0] isEqualToString:@"1"] ? @"" : @"s"] : @"soon";
        
    }
    
    return dueString;
}

#pragma mark

-(int)GenerateUnitToCheck:(NSDate *)firstPotentialDueDate itemAlternateTurns:(NSString *)itemAlternateTurns {
    
    int startingPointForFirstDueDate = 0;
    
    if ([itemAlternateTurns containsString:@" Week"]) {
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components = [calendar components:NSCalendarUnitWeekOfYear fromDate:firstPotentialDueDate];
        startingPointForFirstDueDate = (int)components.weekOfYear;
        
    } else if ([itemAlternateTurns containsString:@" Month"]) {
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components = [calendar components:NSCalendarUnitMonth fromDate:firstPotentialDueDate];
        startingPointForFirstDueDate = (int)components.month;
        
    } else if ([itemAlternateTurns containsString:@" Day"]) {
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSUInteger dayOfYear = [calendar ordinalityOfUnit:NSCalendarUnitDay
                                                   inUnit:NSCalendarUnitYear
                                                  forDate:firstPotentialDueDate];
        startingPointForFirstDueDate = (int)dayOfYear;
        
    }
    
    return startingPointForFirstDueDate;
}


#pragma mark - Generate Due Date Methods

#pragma mark Month (Weekdays)

-(NSDictionary *)GenerateMonthWeekdayToFindAndAmountOfTimesToFindMonthWeekday:(NSString *)dayToFind {
    
    dayToFind = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:dayToFind arrayOfSymbols:@[@"Every "]];
    
    NSArray *dayToFindArray = [dayToFind componentsSeparatedByString:@" "];
    
    NSString *amountOfTimesToFindDayString = [dayToFindArray count] > 0 ? [[[NotificationsObject alloc] init] RemoveIntervalCharacters:dayToFindArray[0]] : @"1";
    dayToFind = [dayToFindArray count] > 1 ? dayToFindArray[1] : @"Sunday";
    
    return @{@"DayToFind" : dayToFind, @"AmountOfTimes" : amountOfTimesToFindDayString};
}

-(NSDateComponents *)GenerateFutureDueDateComponents:(NSString *)dayToFind dueDateMonthNum:(NSInteger)dueDateMonthNum intervalNum:(int)intervalNum dueDateInDateForm:(NSDate *)dueDateInDateForm {
    
    NSDateFormatter *dateFormatter = [[[GeneralObject alloc] init] GenerateDateFormatWithString:@"MMMM dd, yyyy hh:mm a"];
    
    NSDateComponents *componentsForDueDate = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitWeekOfYear|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:dueDateInDateForm];
    
    
    
    //Set Future Due Date Month (& Year)
    if (dueDateMonthNum + intervalNum > 12) {
        
        dueDateMonthNum = (dueDateMonthNum + intervalNum) - 12;
        componentsForDueDate.year = componentsForDueDate.year+1;
        
    } else {
        
        dueDateMonthNum = (dueDateMonthNum + intervalNum);
        
    }
    
    componentsForDueDate.month = dueDateMonthNum;
    
    
    
    //Get Weekday To Find And Amount Of Times To Find It
    NSDictionary *dict = [[[NotificationsObject alloc] init] GenerateMonthWeekdayToFindAndAmountOfTimesToFindMonthWeekday:dayToFind];
    
    dayToFind = dict[@"DayToFind"] ? dict[@"DayToFind"] : @"Sunday";
    NSString *amountOfTimesToFindDayString = dict[@"AmountOfTimes"] ? dict[@"AmountOfTimes"] : @"1";
    
    int amountOfTimesToFindDay = [amountOfTimesToFindDayString intValue];
    
    
    
    //Get Future Due Date Day
    componentsForDueDate = [[[NotificationsObject alloc] init] GenerateComponentsForDueDateUsingSpecificWeekday:componentsForDueDate dateFormatter:dateFormatter dayToFind:dayToFind amountOfTimesToFindDay:amountOfTimesToFindDay];
    
    
    
    return componentsForDueDate;
}

#pragma mark Month (Days & Weekdays)

-(int)GetMonthDayAmountFromMonthNumber:(NSInteger)monthNum {
    
    if (monthNum == 1) {
        return 31;
    } else if (monthNum == 2) {
        return 28;
    } else if (monthNum == 3) {
        return 31;
    } else if (monthNum == 4) {
        return 30;
    } else if (monthNum == 5) {
        return 31;
    } else if (monthNum == 6) {
        return 30;
    } else if (monthNum == 7) {
        return 31;
    } else if (monthNum == 8) {
        return 31;
    } else if (monthNum == 9) {
        return 30;
    } else if (monthNum == 10) {
        return 31;
    } else if (monthNum == 11) {
        return 30;
    } else if (monthNum == 12) {
        return 31;
    }
    
    return 0;
}

-(NSString *)GenerateFutureMonthDueDateToReturn:(NSString *)itemDueDate itemTime:(NSString *)itemTime dueDateInDateForm:(NSDate *)dueDateInDateForm currentDate:(NSDate *)currentDate arrayOfFutureDueDates:(NSMutableArray *)arrayOfFutureDueDates dateFormat:(NSString *)dateFormat firstIteration:(BOOL)firstIteration {
    
    if (itemDueDate.length == 0 && dueDateInDateForm > 0) {
        itemDueDate = [[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:dueDateInDateForm returnAs:[NSString class]];
    }
    if (itemDueDate.length == 0) {
        itemDueDate = [[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:currentDate returnAs:[NSString class]];
    }
    
    NSString *dueDateToReturn = itemDueDate;
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"EditingTaskWithoutAlteringDueDateData1"] isEqualToString:@"Yes"]) {
        
        [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"EditingTaskWithoutAlteringDueDateData1"];
        
        dueDateInDateForm = [[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:itemDueDate returnAs:[NSDate class]];
        
        dueDateToReturn = [[[NotificationsObject alloc] init] GenerateDueDateWithDaysToAddAndCorrectTime:dueDateInDateForm itemTime:itemTime daysToAdd:0 dateFormat:dateFormat firstIteration:firstIteration];
        
        return dueDateToReturn;
        
    }
    
    //Find First Due Date That Has Not Passed
    for (NSString *futureDueDate in arrayOfFutureDueDates) {
        
        NSDateFormatter *dateFormatter = [[[GeneralObject alloc] init] GenerateDateFormatWithString:dateFormat];
        
        NSTimeInterval timeSincePreviousDueDate = [[[GeneralObject alloc] init] GenerateTimeIntervalBetweenTwoDates:itemDueDate dateString2:futureDueDate dateFormat:dateFormat];
        
        if (timeSincePreviousDueDate > 0) {
            
            dueDateInDateForm = [dateFormatter dateFromString:futureDueDate];
            
            dueDateToReturn = [[[NotificationsObject alloc] init] GenerateDueDateWithDaysToAddAndCorrectTime:dueDateInDateForm itemTime:itemTime daysToAdd:0 dateFormat:dateFormat firstIteration:firstIteration];
            
            return dueDateToReturn;
            
        }
        
    }
    
    //If Due Date That Has Not Passed Is Not Found, Find Due Date That Is Equal
    for (NSString *futureDueDate in arrayOfFutureDueDates) {
        
        NSDateFormatter *dateFormatter = [[[GeneralObject alloc] init] GenerateDateFormatWithString:dateFormat];
        
        NSTimeInterval timeSincePreviousDueDate = [[[GeneralObject alloc] init] GenerateTimeIntervalBetweenTwoDates:itemDueDate dateString2:futureDueDate dateFormat:dateFormat];
        
        if (timeSincePreviousDueDate >= 0) {
            
            dueDateInDateForm = [dateFormatter dateFromString:futureDueDate];
            
            dueDateToReturn = [[[NotificationsObject alloc] init] GenerateDueDateWithDaysToAddAndCorrectTime:dueDateInDateForm itemTime:itemTime daysToAdd:0 dateFormat:dateFormat firstIteration:firstIteration];
            
            return dueDateToReturn;
            
        }
        
    }
    
    dueDateToReturn = [[[NotificationsObject alloc] init] GenerateDueDateWithDaysToAddAndCorrectTime:dueDateInDateForm itemTime:itemTime daysToAdd:0 dateFormat:dateFormat firstIteration:firstIteration];
    
    return dueDateToReturn;
}

#pragma mark Months (Days), Months (Weekdays)

-(NSString *)RemoveIntervalCharacters:(NSString *)intervalString {
    
    if ([intervalString isEqualToString:@"Other"]) {
        intervalString = @"2nd";
    }
    
    if ([intervalString containsString:@"Last Day"] == NO) {
        intervalString = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:intervalString arrayOfSymbols:@[@"st"]];
    }
    
    intervalString = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:intervalString arrayOfSymbols:@[@"nd", @"rd", @"th"]];
    
    return intervalString;
}

#pragma mark Hours, Days, Weeks,

-(int)GenerateDaysOrHoursToAddIfRepeatingAndRepeatingIfCompletedEarlyAndAnyDaySelected:(BOOL)Hour Day:(BOOL)Day Week:(BOOL)Week itemRepeats:(NSString *)itemRepeats itemRepeatIfCompletedEarly:(NSString *)itemRepeatIfCompletedEarly itemDays:(NSString *)itemDays daysToAdd:(int)daysToAdd firstIteration:(BOOL)firstIteration {
    
    BOOL TaskIsRepeatingAndRepeatingIfCompletedEarly = [[[BoolDataObject alloc] init] TaskIsRepeatingAndRepeatingIfCompletedEarly:[@{@"ItemRepeats" : itemRepeats, @"ItemRepeatIfCompletedEarly" : itemRepeatIfCompletedEarly} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType]];
    BOOL TaskHasAnyDay = [[[BoolDataObject alloc] init] TaskHasAnyDay:[@{@"ItemDays" : itemDays, @"ItemRepeats" : itemRepeats} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType]];
    
    if ((Hour && TaskIsRepeatingAndRepeatingIfCompletedEarly == YES) ||
        (Day && TaskIsRepeatingAndRepeatingIfCompletedEarly == YES) ||
        (Week && TaskIsRepeatingAndRepeatingIfCompletedEarly == YES && TaskHasAnyDay == YES)) {
     
        BOOL TaskIsRepeatingInterval = [[[BoolDataObject alloc] init] TaskIsRepeatingInterval:[@{@"ItemRepeats" : itemRepeats} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType]];
        int intervalNum = 1;
        
        if (TaskIsRepeatingInterval == YES) {
            
            intervalNum = [[[NotificationsObject alloc] init] GenerateRepeatingInterval:itemRepeats];
            
        }
        
        int numberToMultiply = 1;
        
        if (Week) {
            numberToMultiply = 7;
        }
        
        daysToAdd = numberToMultiply*intervalNum;
        
        if ((Hour == YES || Day == YES) && firstIteration == YES) {
            daysToAdd = intervalNum-1;
        }
        
    }
    
    return daysToAdd;
}

#pragma mark Days, Weeks, Months (Days), Months (Weekdays)

-(NSDictionary *)GenerateDictOfDateComponentsAndTimeComponents:(NSDate *)dueDateInDateForm currentDate:(NSDate *)currentDate itemTime:(NSString *)itemTime {
    
    NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
    NSString *trimmedItemTimeString = [itemTime stringByTrimmingCharactersInSet:charSet];
    
    if ([itemTime isEqualToString:@"Any Time"] || [trimmedItemTimeString isEqualToString:@""]) {
        itemTime = @"11:59 PM";
    }
    
    NSString *minute = @"59";
    NSString *hour = @"23";
    
    if ([itemTime containsString:@" "] && [itemTime containsString:@":"]) {
        
        NSString *timeIn24HourFormat = [[[GeneralObject alloc] init] GenerateDateWithConvertedFormatWithFormat:@"hh:mm a" dateToConvert:itemTime newFormat:@"HH:mm" returnAs:[NSString class]];
        
        NSArray *minteHourAMPMArray = [timeIn24HourFormat componentsSeparatedByString:@" "];
        NSArray *minuteHourArray = [minteHourAMPMArray[0] componentsSeparatedByString:@":"];
        hour = [minuteHourArray count] > 0 ? minuteHourArray[0] : @"23";
        minute = [minuteHourArray count] > 1 ? minuteHourArray[1] : @"59";
        
    }
    
    NSDateComponents *componentsForTodayDate;
    
    //    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"FindAllFutureDueDates"] &&
    //        [[[NSUserDefaults standardUserDefaults] objectForKey:@"FindAllFutureDueDates"] isEqualToString:@"Yes"]) {
    
    componentsForTodayDate = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitWeekOfYear|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:dueDateInDateForm];
    
    //    } else {
    //
    //        componentsForTodayDate = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitWeekOfYear|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:currentDate];
    //
    //    }
    
    if (hour == nil) {
        hour = @"11";
    }
    if (minute == nil) {
        minute = @"11";
    }
    if (componentsForTodayDate == nil) {
        NSDate *currentDate = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:@"yyyy-MM-dd HH:mm:ss" returnAs:[NSDate class]];
        componentsForTodayDate = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitWeekOfYear|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:currentDate];
    }
    
    return @{@"Hour" : hour, @"Minute" : minute, @"ComponentsForTodayDate" : componentsForTodayDate};
}


#pragma mark Hours, Days, Weeks, Months (Days), Months (Weekdays)

-(int)GenerateRepeatingInterval:(NSString *)itemRepeats {
    
    NSArray *frequencyArray = [itemRepeats componentsSeparatedByString:@" "];
    NSString *intervalString = [frequencyArray count] > 1 ? frequencyArray[1] : @"1st";
    intervalString = [[[NotificationsObject alloc] init] RemoveIntervalCharacters:intervalString];
    
    int intervalNum = [intervalString intValue] > 0 ? [intervalString intValue] : 1;
    
    return intervalNum;
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Sub-Sub-Sub-Internal Methods
#pragma mark
#pragma mark
#pragma mark -

#pragma mark Generate Due Date Methods

#pragma mark Month (Weekdays)

-(NSDateComponents *)GenerateComponentsForDueDateUsingSpecificWeekday:(NSDateComponents *)componentsForDueDate dateFormatter:(NSDateFormatter *)dateFormatter dayToFind:(NSString *)dayToFind amountOfTimesToFindDay:(int)amountOfTimesToFindDay {
    
    int amountOfTimesDayWasFound = 0;
    int amountOfDaysInMonth = [[[NotificationsObject alloc] init] GetMonthDayAmountFromMonthNumber:componentsForDueDate.month];
    
    for (int i=1 ; i<=amountOfDaysInMonth ; i++) {
        
        componentsForDueDate.day = i;
        
        NSDate *dueDate = [[NSCalendar currentCalendar] dateFromComponents:componentsForDueDate];
        
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"EEEE"];
        
        NSString *weekDay = [dateFormatter stringFromDate:dueDate];
        
        if ([weekDay isEqualToString:dayToFind]) {
            
            amountOfTimesDayWasFound += 1;
            
            if (amountOfTimesDayWasFound == amountOfTimesToFindDay) {
                
                return componentsForDueDate;
                
            }
            
        }
        
    }
    
    return componentsForDueDate;
}

//NSMutableArray *arr = [[[NotificationsObject alloc] init] GenerateArrayOfRepeatingDueDates:@"Hourly" itemRepeatIfCompletedEarly:@"No" itemCompleteAsNeeded:@"No" totalAmountOfFutureDates:10 maxAmountOfDueDatesToLoopThrough:1000 itemDatePosted:@"March 01, 2023 04:38 PM" itemDueDate:@"March 01, 2023 06:00 PM" itemStartDate:@"March 01, 2023 12:00 AM" itemEndDate:@"Never" itemTime:@"11:59 PM" itemDays:@"Any Day" itemDueDatesSkipped:[NSMutableArray array] SkipStartDate:NO];

@end
