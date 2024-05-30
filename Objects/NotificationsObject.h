//
//  NotificationsObject.h
//  WeDivvy
//
//  Created by Philip Nagel on 9/18/21.
//

#import "AppDelegate.h"
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NotificationsObject : NSObject

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
                                completionHandler:(void (^)(BOOL finished))finishBlock;

-(void)SendLocalNotificationScheduledStartNotification:(NSMutableDictionary *)dictToUse itemType:(NSString *)itemType notificationTitle:(NSString *)notificationTitle notificationBody:(NSString *)notificationBody userIDArray:(NSMutableArray *)usersSendingNotificationsToArray allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays homeMembersArray:(NSMutableArray * _Nullable)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict topicDict:(NSMutableDictionary *)topicDict completionHandler:(void (^)(BOOL finished))finishBlock;

-(void)SendLocalNotificationCustomReminderNotification_LocalOnly:(NSString *)reminderName itemType:(NSString *)itemType dictToUse:(NSMutableDictionary *)dictToUse homeMembersDict:(NSMutableDictionary *)homeMembersDict homeMembersArray:(NSMutableArray *)homeMembersArray allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays completionHandler:(void (^)(BOOL finished))finishBlock;

-(void)SendLocalNotificationSummaryNotifications_LocalOnly:(NSMutableDictionary *)notificationSettingsDict homeMembersDict:(NSMutableDictionary *)homeMembersDict
                                        dataDisplayDictNo1:(NSMutableDictionary *)dataDisplayDictNo1 dataDisplayDictNo2:(NSMutableDictionary *)dataDisplayDictNo2 dataDisplayDictNo3:(NSMutableDictionary *)dataDisplayDictNo3
                                  dataDisplayAmountDictNo1:(NSMutableDictionary *)dataDisplayAmountDictNo1 dataDisplayAmountDictNo2:(NSMutableDictionary *)dataDisplayAmountDictNo2 dataDisplayAmountDictNo3:(NSMutableDictionary *)dataDisplayAmountDictNo3
                                               itemDictNo1:(NSMutableDictionary *)itemDictNo1 itemDictNo2:(NSMutableDictionary *)itemDictNo2 itemDictNo3:(NSMutableDictionary *)itemDictNo3
                                               itemTypeNo1:(NSString *)itemTypeNo1 itemTypeNo2:(NSString *)itemTypeNo2 itemTypeNo3:(NSString *)itemTypeNo3
                                         completionHandler:(void (^)(BOOL finished))finishBlock;

-(void)SendLocalNotificationUnusedPremiumAccountsReminderNotification_LocalOnly:(void (^)(BOOL finished))finishBlock;

-(void)SendLocalNotificationHomeMemberNoInvitationNotification_LocalOnly:(NSMutableDictionary *)homeKeysDict homeMembersUnclaimedDict:(NSMutableDictionary *)homeMembersUnclaimedDict completionHandler:(void (^)(BOOL finished))finishBlock;

-(void)SendLocalNotificationHomeMemberHasNotJoinedNotification_LocalOnly:(NSMutableDictionary *)homeKeysDict homeMembersUnclaimedDict:(NSMutableDictionary *)homeMembersUnclaimedDict completionHandler:(void (^)(BOOL finished))finishBlock;

-(void)SendLocalNotificationPurchasePremiumNotification_LocalOnly:(NSMutableDictionary *)homeMembersDict completionHandler:(void (^)(BOOL finished))finishBlock;

-(void)SendLocalNotificationUpgradePremiumNotification_LocalOnly:(NSMutableDictionary *)homeMembersDict completionHandler:(void (^)(BOOL finished))finishBlock;

#pragma mark

-(void)RemoveLocalNotificationReminderNotifications:(NSString *)itemID itemOccurrenceID:(NSString *)itemOccurrenceID itemUniqueID:(NSString *)itemUniqueID userIDArray:(NSMutableArray *)userIDArray itemCreatedBy:(NSString *)itemCreatedBy homeMembersDict:(NSMutableDictionary *)homeMembersDict topicDict:(NSMutableDictionary *)topicDict completionHandler:(void (^)(BOOL finished))finishBlock;

-(void)RemoveLocalNotificationScheduledStartNotifications:(NSString *)itemID itemOccurrenceID:(NSString *)itemOccurrenceID itemUniqueID:(NSString *)itemUniqueID userIDArray:(NSMutableArray *)userIDArray homeMembersDict:(NSMutableDictionary *)homeMembersDict topicDict:(NSMutableDictionary *)topicDict completionHandler:(void (^)(BOOL finished))finishBlock;

-(void)RemoveLocalNotificationCustomRemindMeNotification_LocalOnly:(NSString *)itemUniqueID completionHandler:(void (^)(BOOL finished))finishBlock;

-(void)RemoveLocalNotificationSummaryNotifications_LocalOnly:(void (^)(BOOL finished))finishBlock;

-(void)RemoveLocalNotificationUnusedPremiumAccountsNotifications_LocalOnly:(void (^)(BOOL finished))finishBlock;

#pragma mark

-(void)UserHasAcceptedNotifications:(void (^)(BOOL isActive))handler;

#pragma mark - Reset Notifications

-(void)ResetLocalNotificationReminderNotification:(NSMutableDictionary *)dictToUse homeMembersDict:(NSMutableDictionary *)homeMembersDict userIDArray:(NSMutableArray *)userIDArray userIDToRemoveArray:(NSMutableArray *)userIDToRemoveArray notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays itemType:(NSString *)itemType notificationType:(NSString *)notificationType topicDict:(NSMutableDictionary *)topicDict completionHandler:(void (^)(BOOL finished))finishBlock;

-(void)ResetLocalNotificationScheduledStartNotifications:(NSMutableDictionary *)dictToUse itemType:(NSString *)itemType userIDArray:(NSMutableArray *)userIDArray userIDToRemoveArray:(NSMutableArray *)userIDToRemoveArray allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays homeMembersArray:(NSMutableArray * _Nullable)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict topicDict:(NSMutableDictionary *)topicDict completionHandler:(void (^)(BOOL finished))finishBlock;

-(void)ResetLocalNotificationCustomReminderNotification_LocalOnly:(NSString *)reminderName itemType:(NSString *)itemType dictToUse:(NSMutableDictionary *)dictToUse homeMembersDict:(NSMutableDictionary *)homeMembersDict homeMembersArray:(NSMutableArray *)homeMembersArray allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays completionHandler:(void (^)(BOOL finished))finishBlock;

-(void)ResetLocalSummaryNotifications_LocalOnly:(NSMutableDictionary *)notificationSettingsDict homeMembersDict:(NSMutableDictionary *)homeMembersDict
                             dataDisplayDictNo1:(NSMutableDictionary *)dataDisplayDictNo1 dataDisplayDictNo2:(NSMutableDictionary *)dataDisplayDictNo2 dataDisplayDictNo3:(NSMutableDictionary *)dataDisplayDictNo3
                       dataDisplayAmountDictNo1:(NSMutableDictionary *)dataDisplayAmountDictNo1 dataDisplayAmountDictNo2:(NSMutableDictionary *)dataDisplayAmountDictNo2 dataDisplayAmountDictNo3:(NSMutableDictionary *)dataDisplayAmountDictNo3
                                    itemDictNo1:(NSMutableDictionary *)itemDictNo1 itemDictNo2:(NSMutableDictionary *)itemDictNo2 itemDictNo3:(NSMutableDictionary *)itemDictNo3
                                    itemTypeNo1:(NSString *)itemTypeNo1 itemTypeNo2:(NSString *)itemTypeNo2 itemTypeNo3:(NSString *)itemTypeNo3
                              completionHandler:(void (^)(BOOL finished))finishBlock;

#pragma mark - Silent Notifications

-(void)SendSilentNotificationGroup:(NSMutableArray *)usersIDLocalArray dataDict:(NSDictionary *)dataDict notificationSettingsDict:(NSMutableDictionary * _Nullable)notificationSettings completionHandler:(void (^)(BOOL finished))finishBlock;
-(void)SendSilentNotificationToCustomArrayOfUsers:(NSMutableArray *)userIDArray dataDict:(NSDictionary *)dataDict homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary * _Nullable)notificationSettings topicDict:(NSMutableDictionary *)topicDict completionHandler:(void (^)(BOOL finished))finishBlock;

#pragma mark - Push Notifications

-(void)SendPushNotificationToCreator:(NSString *)notificationTitle notificationBody:(NSString *)notificationBody badgeNumber:(NSInteger *)badgeNumber completionHandler:(void (^)(BOOL finished))finishBlock;
-(void)SendPushNotificationGroup:(NSMutableArray *)usersIDLocalArray notificationTitle:(NSString *)notificationTitle notificationBody:(NSString *)notificationBody badgeNumber:(NSInteger *)badgeNumber dataDict:(NSDictionary *)dataDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType completionHandler:(void (^)(BOOL finished))finishBlock;

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
                              completionHandler:(void (^)(BOOL finished))finishBlock;

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
                              completionHandler:(void (^)(BOOL finished))finishBlock;

-(void)SendPushNotificationToArrayOfUsers_Homes:(NSMutableArray *)userIDArray
      viewingHomeMembersFromHomesViewController:(BOOL)viewingHomeMembersFromHomesViewController homeID:(NSString *)homeID homeName:(NSString *)homeName homeMembersDict:(NSMutableDictionary * _Nullable)homeMembersDict
                       notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType
                                      topicDict:(NSMutableDictionary *)topicDict
                          pushNotificationTitle:(NSString *)pushNotificationTitle pushNotificationBody:(NSString *)pushNotificationBody
                              notificationTitle:(NSString *)notificationTitle notificationBody:(NSString *)notificationBody
                        SetDataHomeNotification:(BOOL)SetDataHomeNotification
                           RemoveUsersNotInHome:(BOOL)RemoveUsersNotInHome
                              completionHandler:(void (^)(BOOL finished))finishBlock;

-(void)SendPushNotificationToArrayOfUsers_Other:(NSMutableArray *)userIDArray
                                       dataDict:(NSMutableDictionary *)dataDict
                                homeMembersDict:(NSMutableDictionary * _Nullable)homeMembersDict
                       notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType
                          pushNotificationTitle:(NSString *)pushNotificationTitle pushNotificationBody:(NSString *)pushNotificationBody
                           RemoveUsersNotInHome:(BOOL)RemoveUsersNotInHome
                              completionHandler:(void (^)(BOOL finished))finishBlock;

-(NSString *)GeneratePushNotificationAddItemBody:(BOOL)AddItem EditItem:(BOOL)EditItem DeleteItem:(BOOL)DeleteItem NotificationItem:(BOOL)NotificationItem NobodyAssigned:(BOOL)NobodyAssigned userIDArray:(NSMutableArray *)userIDArray;

#pragma mark - Generate Notification Data Dict Methods

-(NSDictionary *)GenerateNotificationDataDictLiveSupport;
-(NSDictionary *)GenerateNotificationDataDictForum:(NSMutableDictionary *)forumDict viewingFeatureForum:(BOOL)viewingFeatureForum;
-(NSDictionary *)GenerateNotificationDataDictSilentNotification:(NSString *)sentBy;
-(NSDictionary *)GenerateNotificationDataDictHome:(NSString *)homeID homeName:(NSString *)homeName viewingHomeMembersFromHomesViewController:(BOOL)viewingHomeMembersFromHomesViewController;
-(NSDictionary *)GenerateNotificationDataDictGroupChat:(NSString *)chatID chatName:(NSString *)chatName chatAssignedTo:(NSMutableArray *)chatAssignedTo userID:(NSString *)userID homeID:(NSString *)homeID homeMembersDict:(NSMutableDictionary *)homeMembersDict;
-(NSDictionary *)GenerateNotificationDataDictComments:(NSString *)homeID itemType:(NSString *)itemType itemID:(NSString *)itemID itemName:(NSString *)itemName itemCreatedBy:(NSString *)itemCreatedBy itemAssignedTo:(NSMutableArray *)itemAssignedTo homeMembersDict:(NSMutableDictionary *)homeMembersDict;
-(NSDictionary *)GenerateNotificationDataDictTask:(NSString *)itemID itemOccurrenceID:(NSString *)itemOccurrenceID itemType:(NSString *)itemType allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays homeMembersArray:(NSMutableArray * _Nullable)homeMembersArray;

#pragma mark - Generate Due Date Methods

-(NSMutableArray *)GenerateArrayOfRepeatingDueDates:(NSString *)itemRepeats itemRepeatIfCompletedEarly:(NSString *)itemRepeatIfCompletedEarly itemCompleteAsNeeded:(NSString *)itemCompleteAsNeeded totalAmountOfFutureDates:(int)totalAmountOfFutureDates maxAmountOfDueDatesToLoopThrough:(int)maxAmountOfDueDatesToLoopThrough itemDatePosted:(NSString *)itemDatePosted itemDueDate:(NSString *)itemDueDate itemStartDate:(NSString *)itemStartDate itemEndDate:(NSString *)itemEndDate itemTime:(NSString *)itemTime itemDays:(NSString *)itemDays itemDueDatesSkipped:(NSMutableArray *)itemDueDatesSkipped itemDateLastReset:(NSString *)itemDateLastReset SkipStartDate:(BOOL)SkipStartDate;
-(int)GenerateAmountOfDueDatesForTheNextXAmountOfYears:(int)years itemRepeats:(NSString *)itemRepeats itemDays:(NSString *)itemDays;

#pragma mark - Notification Type

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
                                               itemType:(NSString *)itemType;

#pragma mark - Inactive Notification

-(void)GenerateTwoWeekReminderNotification;
-(void)RemoveLocalInactiveNotification;

#pragma mark - Unread Notification Methods

-(BOOL)UserSignedUpAfterNotificationWasCreated:(NSString *)userID notificationDatePosted:(NSString *)notificationDatePosted;

#pragma mark - Other

-(NSMutableArray *)AddAndRemoveSpecificUsersFromArray:(NSMutableArray *)arrayToUse addTheseUsers:(NSArray *)addTheseUsers removeTheseUsers:(NSArray *)removeTheseUsers;
-(void)SaveMyLocalNotifications:(void (^)(BOOL finished))finishBlock;

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Internal Methods
#pragma mark
#pragma mark
#pragma mark -

-(NSString *)RemoveIntervalCharacters:(NSString *)intervalString;
-(int)GetMonthDayAmountFromMonthNumber:(NSInteger)monthNum;
-(NSArray *)GenerateUniqueSubsets:(NSArray *)inputArray;
-(NSString *)GenerateTopicFromSubset:(NSArray *)subset;

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Sub-Sub-Internal Methods
#pragma mark
#pragma mark
#pragma mark -

#pragma mark Reminder Notification Methods

-(int)GenerateUnitToCheck:(NSDate *)firstPotentialDueDate itemAlternateTurns:(NSString *)itemAlternateTurns;

@end

NS_ASSUME_NONNULL_END
