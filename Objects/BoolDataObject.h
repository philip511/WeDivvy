//
//  BoolDataObject.h
//  WeDivvy
//
//  Created by Philip Nagel on 8/17/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BoolDataObject : NSObject

#pragma mark - High Compound BOOLs

-(BOOL)TaskIsFullyCompleted:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType homeMembersDict:(NSMutableDictionary *)homeMembersDict;
-(BOOL)TaskIsFullyCompletedButNotByEveryone:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType homeMembersDict:(NSMutableDictionary *)homeMembersDict;
-(BOOL)TaskCanBeCompletedInTaskBySpecificUser:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType userID:(NSString *)userID homeMembersDict:(NSMutableDictionary *)homeMembersDict;
-(BOOL)TaskCanBeCompletedInViewTaskBySpecificUser:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType userID:(NSString *)userID homeMembersDict:(NSMutableDictionary *)homeMembersDict;
-(BOOL)TaskIsValidToBeDisplayed:(NSMutableDictionary *)itemDict index:(NSUInteger)index itemType:(NSString *)itemType homeMembersDict:(NSMutableDictionary *)homeMembersDict keyArray:(NSArray *)keyArray;
-(BOOL)TaskIsExpired:(NSMutableDictionary *)singleObjectItemDict itemType:(NSString *)itemType homeMembersDict:(NSMutableDictionary *)homeMembersDict;
-(BOOL)TaskIsScheduledStartAndVisible:(NSMutableDictionary *)singleObjectItemDict itemType:(NSString *)itemType userID:(NSString *)userID;
-(BOOL)TaskIsHiddenFromUser:(NSMutableDictionary *)singleObjectItemDict itemType:(NSString *)itemType userID:(NSString *)userID;

#pragma mark

-(BOOL)SubtaskCanBeCompletedBySpecificUser:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType userID:(NSString *)userID subtask:(NSString *)subtask homeMembersDict:(NSMutableDictionary *)homeMembersDict;

#pragma mark

-(BOOL)ListItemCanBeCompletedBySpecificUser:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType userID:(NSString *)userID listItem:(NSString *)listItem;

#pragma mark

-(BOOL)ItemizedItemCanBeCompletedBySpecificUser:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType userID:(NSString *)userID itemizedItem:(NSString *)itemizedItem;

#pragma mark

-(BOOL)SpecificUserShouldDisplayDeactivatedColor:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType userID:(NSString *)userID homeMembersDict:(NSMutableDictionary *)homeMembersDict;

#pragma mark - Low Compound BOOLs

-(BOOL)TaskCompletedByMinimumUsers:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType homeMembersDict:(NSMutableDictionary *)homeMembersDict;
-(BOOL)TaskCompletedByCurrentUsersTurn:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType homeMembersDict:(NSMutableDictionary *)homeMembersDict;
-(BOOL)TaskEndHasPassed:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType numberOfTaskOccurrences:(int)numberOfTaskOccurrences;

#pragma mark

-(BOOL)SubtaskCompletedBySpecificUser:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType subtask:(NSString *)subtask userID:(NSString *)userID;
-(BOOL)SubtaskInProgressBySpecificUser:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType subtask:(NSString *)subtask userID:(NSString *)userID;
-(BOOL)SubtaskWontDoBySpecificUser:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType subtask:(NSString *)subtask userID:(NSString *)userID;
-(BOOL)SubtaskAssignedToSpecificUser:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType subtask:(NSString *)subtask userID:(NSString *)userID;

#pragma mark

-(BOOL)ListItemIsCompletedBySpecificUser:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType listItem:(NSString *)listItem userID:(NSString *)userID;
-(BOOL)ListItemIsInProgressBySpecificUser:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType listItem:(NSString *)listItem userID:(NSString *)userID;
-(BOOL)ListItemIsWontDoBySpecificUser:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType listItem:(NSString *)listItem userID:(NSString *)userID;
-(BOOL)ListItemAssignedToSpecificUser:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType listItem:(NSString *)listItem userID:(NSString *)userID;

#pragma mark

-(BOOL)ItemizedItemIsCompletedBySpecificUser:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType itemizedItem:(NSString *)itemizedItem userID:(NSString *)userID;

-(BOOL)ItemizedItemIsInProgressBySpecificUser:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType itemizedItem:(NSString *)itemizedItem userID:(NSString *)userID;
-(BOOL)ItemizedItemIsWontDoBySpecificUser:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType itemizedItem:(NSString *)itemizedItem userID:(NSString *)userID;
-(BOOL)ItemizedItemAssignedToSpecificUser:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType itemizedItem:(NSString *)itemizedItem userID:(NSString *)userID;

#pragma mark - Simple BOOLs

-(BOOL)TaskHasGracePeriod:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType;
-(BOOL)TaskIsPaused:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType;
-(BOOL)TaskIsPinned:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType;
-(BOOL)TaskIsOccurrence:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType;
-(BOOL)TaskOccurrenceStatusIsNone:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType;
-(BOOL)TaskIsList:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType;
-(BOOL)TaskIsItemized:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType;
-(BOOL)TaskHasTime:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType;
-(BOOL)TaskHasReminder:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType;
-(BOOL)TaskHasSelfDestruct:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType;
-(BOOL)TaskHasEstimatedTime:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType;
-(BOOL)TaskHasColor:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType;
-(BOOL)TaskHasDifficulty:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType;
-(BOOL)TaskHasPriority:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType;
-(BOOL)TaskHasAnyTime:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType;
-(BOOL)TaskHasAnyDay:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType;
-(BOOL)TaskIsCompleteAsNeeded:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType;
-(BOOL)TaskIsRepeating:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType;
-(BOOL)TaskIsRepeatingInterval:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType;
//-(BOOL)TaskIsRepeatingOneTime:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType;
-(BOOL)TaskIsRepeatingAsNeeded:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType;
-(BOOL)TaskIsRepeatingHourly:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType;
-(BOOL)TaskIsRepeatingDaily:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType;
-(BOOL)TaskIsRepeatingWeekly:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType;
-(BOOL)TaskIsRepeatingBiWeekly:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType;
-(BOOL)TaskIsRepeatingSemiMonthly:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType;
-(BOOL)TaskIsRepeatingMonthly:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType;
-(BOOL)TaskIsRepeatingWhenCompleted:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType;
-(BOOL)TaskIsRepeatingAndRepeatingIfCompletedEarly:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType;
-(BOOL)TaskHasNoDueDate:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType;
-(BOOL)TaskHasMultipleDueDate:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType;
-(BOOL)ItemStartDateSelected:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType;
-(BOOL)ItemEndDateSelected:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType;
-(BOOL)TaskEndIsNumberOfTimes:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType;
-(BOOL)TaskEndIsSpecificDate:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType;
-(BOOL)TaskIsTakingTurns:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType;
-(BOOL)TaskIsPrivate:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType;
-(BOOL)TaskIsTrash:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType;
-(BOOL)TaskIsDeleted:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType;
-(BOOL)TaskIsSpecificUsersTurn:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType userID:(NSString *)userID homeMembersDict:(NSMutableDictionary *)homeMembersDict;
-(BOOL)TaskIsSpecificUsersTurnNext:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType userID:(NSString *)userID;
-(BOOL)TaskMustBeCompletedByEveryoneAssigned:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType;
-(BOOL)TaskCompletedByAllAssignedUsers:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType homeMembersDict:(NSMutableDictionary *)homeMembersDict;
-(BOOL)TaskCompletedBySpecificUser:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType userID:(NSString *)userID;
-(BOOL)TaskInProgressBySpecificUser:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType userID:(NSString *)userID;
-(BOOL)TaskWontDoBySpecificUser:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType userID:(NSString *)userID;
-(BOOL)TaskIsPhotoConfirmation:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType;
-(BOOL)TaskPhotoConfirmationNeededForSpecificObject:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType objectToUse:(NSString *)objectToUse;
-(BOOL)TaskApprovalRequestPendingBySpecificUser:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType userID:(NSString *)userID;
-(BOOL)TaskApprovalRequestAcceptedBySpecificUser:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType userID:(NSString *)userID;
-(BOOL)TaskIsRequestApproval:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType;
-(BOOL)TaskWasCreatedBySpecificUser:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType userID:(NSString *)userID;
-(BOOL)TaskWasAssignedToSpecificUser:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType userID:(NSString *)userID;
-(BOOL)TaskIsAssignedToOnlyMyself:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType;
-(BOOL)TaskIsAssignedToAnybody:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType;
-(BOOL)TaskIsAssignedToNobody:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType;
-(BOOL)TaskIsPastDueIsUntilNever:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType;
-(BOOL)TaskIsPastDueIsUntilCompleted:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType;
-(BOOL)TaskHasAddMoreTime:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType;
-(BOOL)TaskAddMoreTimeRejected:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType;
-(BOOL)TaskIsAddMoreTimeUnlimited:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType;
-(BOOL)TaskIsPastDue:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType;
-(BOOL)TaskIsPastPastDueLimit:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType;
-(BOOL)TaskIsPastAddMoreTimeLimit:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType;
-(BOOL)TaskIsScheduledStart:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType;
-(BOOL)TaskIsScheduledStartHasPassed:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType;
-(BOOL)TaskIsTutorial:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType;
-(BOOL)UserShouldReceiveNotificationsForTask:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType userID:(NSString *)userID homeMembersDict:(NSMutableDictionary *)homeMembersDict;
-(BOOL)TaskHasBeenMuted:(NSMutableDictionary *)itemDict;
-(BOOL)TaskHasReminderNotification:(NSMutableDictionary *)itemDict;

#pragma mark

-(BOOL)SubtaskIsCompleted:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType subtask:(NSString *)subtask;
-(BOOL)SubtaskIsInProgress:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType subtask:(NSString *)subtask;
-(BOOL)SubtaskIsWontDo:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType subtask:(NSString *)subtask;
-(BOOL)SubtaskIsAssignedToAnybody:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType subtask:(NSString *)subtask;
-(BOOL)SubtaskIsRequestingApprovalPending:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType subtask:(NSString *)subtask;

#pragma mark

-(BOOL)AllListItemsAreCompleted:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType;
-(BOOL)ListItemIsCompleted:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType listItem:(NSString *)listItem;
-(BOOL)ListItemIsInProgress:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType listItem:(NSString *)listItem;
-(BOOL)ListItemIsWontDo:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType listItem:(NSString *)listItem;
-(BOOL)ListItemIsAssignedToNewHomeMembers:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType listItem:(NSString *)listItem;
-(BOOL)ListItemIsRequestingApprovalPending:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType listItem:(NSString *)listItem;

#pragma mark

-(BOOL)AllItemizedItemsAreCompleted:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType;
-(BOOL)ItemizedItemIsCompleted:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType itemizedItem:(NSString *)itemizedItem;
-(BOOL)ItemizedItemIsInProgress:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType itemizedItem:(NSString *)itemizedItem;
-(BOOL)ItemizedItemIsWontDo:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType itemizedItem:(NSString *)itemizedItem;
-(BOOL)ItemizedItemIsAssignedToNewHomeMembers:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType itemizedItem:(NSString *)itemizedItem;
-(BOOL)ItemizedItemIsRequestingApprovalPending:(NSMutableDictionary *)itemDict itemType:(NSString *)itemType itemizedItem:(NSString *)itemizedItem;

#pragma mark

-(BOOL)UserCanReceiveNotification:(NSMutableDictionary *)notificationSettingsDict userID:(NSString *)userID notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType;
-(BOOL)UserAllowsNotification:(NSMutableDictionary *)notificationSettingsDict userID:(NSString *)userID notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType;
-(BOOL)UserCanReceiveBagdeIconNotification:(NSMutableDictionary *)notificationSettingsDict userID:(NSString *)userID;
-(BOOL)UserCanReceiveNotificationForSpecificDay:(NSMutableDictionary *)notificationSettingsDict userID:(NSString *)userID notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType;
-(BOOL)UserCanReceiveNotificationForSpecificNotificationType:(NSMutableDictionary *)notificationSettingsDict userID:(NSString *)userID notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType;
-(BOOL)UserWithUsernameHasNotificationsTurnedOn:(NSString *)username homeMembersDict:(NSMutableDictionary *)homeMembersDict;

#pragma mark

-(BOOL)SpecificUserIsMe:(NSString *)userID;

#pragma mark

-(BOOL)TimeToAlternateTurns:(NSMutableDictionary *)dictToUse itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict itemType:(NSString *)itemType keyArray:(NSArray *)keyArray homeMembersDict:(NSMutableDictionary *)homeMembersDict;
-(BOOL)TimeToAlternateTurnsEveryOccurrence:(NSMutableDictionary *)dictToUse itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict itemType:(NSString *)itemType;
-(BOOL)TimeToAlternateTurnsEveryCompletion:(NSMutableDictionary *)dictToUse itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict itemType:(NSString *)itemType keyArray:(NSArray *)keyArray homeMembersDict:(NSMutableDictionary *)homeMembersDict;
-(BOOL)TimeToAlternateTurnsEveryMonthDays:(NSMutableDictionary *)dictToUse;
-(BOOL)TimeToAlternateTurnsEveryWeekDays:(NSMutableDictionary *)dictToUse;
-(BOOL)TimeToAlternateTurnsEveryDayWeekMonth:(NSMutableDictionary *)dictToUse allDueDatesArray:(NSMutableArray *)allDueDatesArray;

#pragma mark - Premium BOOLs

-(BOOL)PremiumSubscriptionIsOn;
-(BOOL)PremiumSubscriptionIsActiveForSpecificUserAtIndex:(NSMutableDictionary *)homeMembersDict userID:(NSString *)userID;
-(BOOL)PremiumSubscriptionIsOnForAtLeastOneHomeMember:(NSMutableDictionary *)homeMembersDict;
-(BOOL)PremiumUserHasSubscriptionHistory:(NSMutableDictionary *)homeMembersDict purchasingUserID:(NSString *)purchasingUserID;
-(BOOL)PremiumUserHasAccountsToGiveAndNotAllUsersHavePremium:(NSMutableDictionary *)homeMembersDict purchasingUserID:(NSString *)purchasingUserID;
-(BOOL)PremiumUnusedAccountsNotificationExists;
-(BOOL)PremiumUserHasIndividualPlanAndHasMoreThanOneHomeMember:(NSMutableDictionary *)homeMembersDict purchasingUserID:(NSString *)purchasingUserID;
-(BOOL)PremiumUserHasHousemateOrFamilyPlan:(NSMutableDictionary *)homeMembersDict purchasingUserID:(NSString *)purchasingUserID;
-(BOOL)PremiumLimitForTasksReached:(NSMutableArray *)allItemIDsArrays homeMembersDict:(NSMutableDictionary *)homeMembersDict;

#pragma mark - Other BOOLs

-(BOOL)CheckIfObjectIsKindOfClass:(id)object classArr:(NSArray *)classArr;
-(BOOL)NoSignUp;
-(BOOL)DarkModeIsOn;
-(BOOL)DateHasAMPM:(NSString *)dateString;
-(BOOL)EmailFormatValid:(NSString *)email;
-(BOOL)CheckIfUserIsUsing24HourFormat;
-(BOOL)UseLocallyGeneratedTopics:(NSMutableDictionary *)homeMembersDict;
-(BOOL)UserWasCreatedAfterChange;

@end

NS_ASSUME_NONNULL_END
