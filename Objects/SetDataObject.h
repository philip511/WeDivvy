//
//  SetDataObject.h
//  WeDivvy
//
//  Created by Philip Nagel on 9/14/21.
//

#import <Foundation/Foundation.h>
#import <AVKit/AVKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SetDataObject : NSObject

#pragma mark - Activity

-(void)SetDataItemActivity:(NSString *)homeID collection:(NSString *)collection itemID:(NSString *)itemID activityID:(NSString *)activityID setDataDict:(NSDictionary *)setDataDict completionHandler:(void (^)(BOOL finished))finishBlock;

-(void)SetDataHomeActivity:(NSString *)activityHomeID activityID:(NSString *)activityID dataDict:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished, NSError *error))finishBlock;

-(void)UpdateDataHomeActivity:(NSString *)activityHomeID activityID:(NSString *)activityID dataDict:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished, NSError *error))finishBlock;

-(void)UpdateDataItemActivity:(NSString *)homeID collection:(NSString *)collection itemID:(NSString *)itemID activityID:(NSString *)activityID setDataDict:(NSDictionary *)setDataDict completionHandler:(void (^)(BOOL finished))finishBlock;

#pragma mark Compound Methods

-(void)SetDataHomeAndItemActivity:(NSMutableDictionary *)itemActivityDict homeActivityDict:(NSMutableDictionary *)homeActivityDict completionHandler:(void (^)(BOOL finished))finishBlock;

-(void)UpdateDataHomeAndItemActivity:(NSString *)activityID activityRead:(NSMutableArray *)activityRead itemType:(NSString *)itemType homeID:(NSString *)homeID itemID:(NSString *)itemID completionHandler:(void (^)(BOOL finished))finishBlock;

#pragma mark - Algolia

-(void)SetDataAddAlgoliaObject:(NSString *)itemUniqueID dictToUse:(NSMutableDictionary *)dictToUse completionHandler:(void (^)(BOOL finished))finishBlock;

-(void)SetDataAddMultipleAlgoliaObjects:(NSMutableArray *)arrayOfObjects completionHandler:(void (^)(BOOL finished))finishBlock;

-(void)UpdateDataEditAlgoliaObject:(NSString *)itemUniqueID dictToUse:(NSMutableDictionary *)dictToUse completionHandler:(void (^)(BOOL finished))finishBlock;

#pragma mark - Analytics

-(BOOL)UserisValid:(BOOL)isSimulator;

-(void)SetDataFIRStoreAnalytics:(void (^)(BOOL finished))finishBlock;

-(void)SetDataFIRStoreAnalyticsNewViewController:(NSString *)identifier completionHandler:(void (^)(BOOL finished))finishBlock;

-(void)SetDataFIRStoreAnalyticsNewTouchEvent:(UIViewController *)currentViewController touchEvent:(NSString *)touchEvent completionHandler:(void (^)(BOOL finished))finishBlock;

-(void)SetDataAnalyticsMixPanelID:(NSString *)mixPanelID completionHandler:(void (^)(BOOL finished))finishBlock;

-(void)SetDataEmailAsMixPanelIDForDeletedAccount:(NSString *)userEmail mixPanelID:(NSString *)mixPanelID completionHandler:(void (^)(BOOL finished))finishBlock;

#pragma mark - Android

-(void)SetDataAndroid:(void (^)(BOOL finished))finishBlock;

#pragma mark - Core Data

-(void)SetDataAddCoreData:(NSString *)entity predicate:(NSPredicate * _Nullable)predicate setDataObject:(NSDictionary *)setDataObject;

-(void)SetDataAddCoreDataNo1:(NSString *)entity predicate:(NSPredicate * _Nullable)predicate setDataObject:(NSDictionary *)setDataObject managedObjectContext:(NSManagedObjectContext *)managedObjectContext;

-(void)SetDataEditCoreDataNo1:(NSString *)entity predicate:(NSPredicate * _Nullable)predicate setDataObject:(NSDictionary *)setDataObject managedObjectContext:(NSManagedObjectContext *)managedObjectContext;

-(void)SetDataEditCoreData:(NSString *)entity predicate:(NSPredicate * _Nullable)predicate setDataObject:(NSDictionary *)setDataObject;

#pragma mark - Chats

-(void)SetDataAddGroupChat:(NSString *)homeID itemDict:(NSMutableDictionary *)itemDict completionHandler:(void (^)(BOOL finished))finishBlock;

-(void)UpdateDataEditChat:(NSDictionary *)setDataDict itemID:(NSString *)itemID collection:(NSString *)collection homeID:(NSString *)homeID completionHandler:(void (^)(BOOL finished))finishBlock;
  
-(void)UpdateDataChatAssignedToArrayArray:(NSString *)collection homeID:(NSString *)homeID itemID:(NSString *)itemID itemAssignedTo:(NSMutableArray *)itemAssignedTo completionHandler:(void (^)(BOOL finished))finishBlock;

-(void)UpdateDataUpdateGroupChatsAssignedToNewHomeMembersInSpecificHome:(NSString *)homeID userToAdd:(NSString *)userToAdd completionHandler:(void (^)(BOOL finished))finishBlock;

#pragma mark - Drafts

-(void)SetDataAddDraft:(NSString *)draftCreatedBy draftID:(NSString *)draftID setDataDict:(NSDictionary *)setDataDict completionHandler:(void (^)(BOOL finished))finishBlock;

-(void)UpdateDataDraft:(NSString *)draftCreatedBy draftID:(NSString *)draftID setDataDict:(NSDictionary *)setDataDict completionHandler:(void (^)(BOOL finished))finishBlock;

#pragma mark - Crashes

-(void)SetDataCrash:(void (^)(BOOL finished))finishBlock;

-(void)SetDataCrashData:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished))finishBlock;

#pragma mark - FAQ

-(void)SetDataFAQ:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished))finishBlock;

#pragma mark - Folders

-(void)SetDataAddFolder:(NSString *)folderCreatedBy folderID:(NSString *)folderID dataDict:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished))finishBlock;

-(void)UpdateDataFolder:(NSString *)folderCreatedBy folderID:(NSString *)folderID dataDict:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished))finishBlock;

#pragma mark - Forum

-(void)SetDataAddForum:(NSString *)collection forumID:(NSString *)forumID dataDict:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished))finishBlock;

-(void)UpdateDataAddForum:(NSString *)collection forumID:(NSString *)forumID dataDict:(NSDictionary *)dataDict;

#pragma mark - Homes

-(void)SetDataAddHome:(NSString *)homeID homeDict:(NSDictionary *)homeDict completionHandler:(void (^)(BOOL finished))finishBlock;

-(void)SetDataHomeImage:(UIImage *)profileImage homeID:(NSString *)homeID completionHandler:(void (^)(BOOL finished, NSString *homeImageURL))finishBlock;

-(void)UpdateDataHome:(NSString *)homeID homeDict:(NSDictionary *)homeDict completionHandler:(void (^)(BOOL finished))finishBlock;

#pragma mark - Messages

-(void)SetDataAddMessage:(NSDictionary *)dataDict userID:(NSString *)userID homeID:(NSString *)homeID itemType:(NSString *)itemType itemID:(NSString *)itemID chatID:(NSString *)chatID viewingGroupChat:(BOOL)viewingGroupChat viewingComments:(BOOL)viewingComments viewingLiveSupport:(BOOL)viewingLiveSupport completionHandler:(void (^)(BOOL finished))finishBlock;

-(void)SetDataMessageRead:(NSString *)userID homeID:(NSString *)homeID itemType:(NSString *)itemType itemID:(NSString *)itemID chatID:(NSString *)chatID messageDict:(NSMutableDictionary *)messageDict viewingGroupChat:(BOOL)viewingGroupChat viewingComments:(BOOL)viewingComments viewingLiveSupport:(BOOL)viewingLiveSupport completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningMessageDict))finishBlock;

-(void)SetDataMessageImage:(NSString *)homeID messageID:(NSString *)messageID messageImage:(UIImage *)messageImage completionHandler:(void (^)(BOOL finished, NSString *imageURL))finishBlock;

-(void)SetDataMessageVideo:(NSString *)homeID messageID:(NSString *)messageID messageVideoData:(NSData *)messageVideoData completionHandler:(void (^)(BOOL finished, NSString *videoURL, UIImage *videoImage))finishBlock;

#pragma mark - Notifications

-(void)SetDataNotification:(NSString *)homeID notificationTitle:(NSString *)notificationTitle notificationBody:(NSString *)notificationBody notificationItemID:(NSString *)notificationItemID notificationItemOccurrenceID:(NSString *)notificationItemOccurrenceID notificationItemCollection:(NSString *)notificationItemCollection homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType completionHandler:(void (^)(BOOL finished))finishBlock;

-(void)UpdateDataNotification:(NSString *)homeID notificationID:(NSString *)notificationID notificationReadArray:(NSMutableArray *)notificationReadArray completionHandler:(void (^)(BOOL finished))finishBlock;

#pragma mark - Promotional Codes

-(void)SetDataPromotionalCode:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished))finishBlock;

-(void)UpdateDataPromotionalCodeUsed:(NSString *)promotionalCodeID dataDict:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished))finishBlock;

#pragma mark - Reported Crashes

-(void)SetDataReportedCrash:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished))finishBlock;

#pragma mark - Sections

-(void)SetDataAddSection:(NSString *)sectionCreatedBy sectionID:(NSString *)sectionID setDataDict:(NSDictionary *)setDataDict completionHandler:(void (^)(BOOL finished))finishBlock;

-(void)UpdateDataSection:(NSString *)sectionCreatedBy sectionID:(NSString *)sectionID setDataDict:(NSDictionary *)setDataDict completionHandler:(void (^)(BOOL finished))finishBlock;

#pragma mark - Survey/Feedback/Premium Feedback/Premium Cancelled Feedback

-(void)SetDataSurvey:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished))finishBlock;

-(void)SetDataFeedback:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished))finishBlock;

-(void)SetDataPremiumFeedback:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished))finishBlock;

-(void)SetDataPremiumCancelledFeedback:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished))finishBlock;

-(void)UpdateDataFeedback:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished))finishBlock;

#pragma mark - Subscriptions

-(void)SetDataSubscription:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished, NSError *error))finishBlock;

-(void)UpdateDataSubscription:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished, NSError *error))finishBlock;

-(void)UpdateDataSubscriptionCancelled:(NSString *)subscriptionCancelled subscriptionDateCancelled:(NSString *)subscriptionDateCancelled purchasingUsersUserID:(NSString *)purchasingUsersUserID homeMembersDict:(NSMutableDictionary *)homeMembersDict completionHandler:(void (^)(BOOL finished))finishBlock;

-(void)UpdateDataSubscriptionLastDateOpenned:(NSString *)subscriptionDateLastOpenned purchasingUsersUserID:(NSString *)purchasingUsersUserID homeMembersDict:(NSMutableDictionary *)homeMembersDict completionHandler:(void (^)(BOOL finished))finishBlock;

#pragma mark - Task Lists

-(void)SetDataAddTaskList:(NSString *)taskListCreatedBy taskListID:(NSString *)taskListID dataDict:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished))finishBlock;

-(void)UpdateDataTaskList:(NSString *)taskListCreatedBy taskListID:(NSString *)taskListID dataDict:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished))finishBlock;

#pragma mark - Templates

-(void)SetDataAddTemplate:(NSString *)templateCreatedBy templateID:(NSString *)templateID dataDict:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished))finishBlock;

-(void)UpdateDataTemplate:(NSString *)templateCreatedBy templateID:(NSString *)templateID dataDict:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished))finishBlock;

#pragma mark - Topics

-(void)SetDataAddTopic:(NSString *)homeID topicID:(NSString *)topicID dataDict:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished))finishBlock;

-(void)UpdateDataTopic:(NSString *)homeID topicID:(NSString *)topicID dataDict:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished))finishBlock;

#pragma mark - Compound Methods

-(void)SubscribeAndSetDataTopic:(NSString *)homeID topicID:(NSString *)topicID dataDict:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished))finishBlock;

-(void)SubsribeOrUnsubscribeAndUpdateTopic:(NSString *)homeID topicID:(NSString *)topicID itemOccurrenceID:(NSString *)itemOccurrenceID dataDict:(NSDictionary *)dataDict SubscribeToTopic:(BOOL)SubscribeToTopic UnsubscribeFromTopic:(BOOL)UnsubscribeFromTopic completionHandler:(void (^)(BOOL finished))finishBlock;

#pragma mark - Users

-(void)SetDataUserData:(NSString *)userID userDict:(NSDictionary *)userDict completionHandler:(void (^)(BOOL finished, NSError *error))finishBlock;

-(void)SetDataProfileImage:(UIImage *)profileImage completionHandler:(void (^)(BOOL finished, NSString *profileImageURL))finishBlock;

-(void)SetDataNotificationSettings:(NSString *)userID dataDict:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished, NSError *error))finishBlock;

-(void)SetDataCalendarSettings:(NSString *)userID dataDict:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished, NSError *error))finishBlock;

-(void)SetDataNotificationOpen:(NSString *)userID dataDict:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished, NSError *error))finishBlock;

-(void)UpdateDataUserData:(NSString *)userID userDict:(NSDictionary *)userDict completionHandler:(void (^)(BOOL finished, NSError *error))finishBlock;

-(void)UpdateDataNotificationSettings:(NSString *)userID dataDict:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished, NSError *error))finishBlock;

-(void)UpdateDataCalendarSettings:(NSString *)userID dataDict:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished, NSError *error))finishBlock;

#pragma mark Compound Methods

-(void)UpdateDataWeDivvyPremiumUsersSelected:(NSMutableDictionary *)homeMembersDict oldHomeMembersDict:(NSMutableDictionary *)oldHomeMembersDict completionHandler:(void (^)(BOOL finished))finishBlock;
   
-(void)UpdataDataWeDivvyPremiumPurchasingUserHasWeDivvyPremiumButItIsNotShownInDatabase:(NSMutableDictionary *)homeMembersDict purchasingUsersUserID:(NSString *)purchasingUsersUserID completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningHomeMembersDict))finishBlock;

-(void)UpdataDataWeDivvyPremiumPurchasingUserNoLongHasWeDivvyPremium:(NSMutableDictionary *)homeMembersDict purchasingUsersUserID:(NSString *)purchasingUsersUserID completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningHomeMembersDict))finishBlock;

-(void)UpdateDataWeDivvyPremiumRemoveSubscriptionForGivenByUsers:(NSString *)purchasingUsersUserID homeMembersDict:(NSMutableDictionary *)homeMembersDict completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningHomeMembersDict))finishBlock;

#pragma mark - Items

-(void)SetDataAddItem:(NSDictionary *)setDataDict collection:(NSString *)collection homeID:(NSString *)homeID completionHandler:(void (^)(BOOL finished))finishBlock;

-(void)SetDataItemImage:(NSString *)itemUniqueID itemType:(NSString *)itemType imgData:(NSData *)imgData completionHandler:(void (^)(BOOL finished))finishBlock;

-(void)SetDataItemPhotoConfirmationImage:(NSString *)itemUniqueID itemType:(NSString *)itemType markedObject:(NSString *)markedObject imgData:(NSData *)imgData completionHandler:(void (^)(BOOL finished, NSString *imageURL))finishBlock;

-(void)UpdateDataEditItem:(NSDictionary *)setDataDict itemID:(NSString *)itemID itemOccurrenceID:(NSString *)itemOccurrenceID collection:(NSString *)collection homeID:(NSString *)homeID completionHandler:(void (^)(BOOL finished))finishBlock;

-(void)UpdateDataItemImage:(NSString *)itemUniqueID itemType:(NSString *)itemType imgData:(NSData *)imgData completionHandler:(void (^)(BOOL finished))finishBlock;

-(void)UpdateDataItemPhotoConfirmationImage:(NSString *)itemUniqueID itemType:(NSString *)itemType markedObject:(NSString *)markedObject imgData:(NSData *)imgData completionHandler:(void (^)(BOOL finished))finishBlock;

#pragma mark - Compound Methods

-(void)UpdateDataForNewHomeMember:(NSString *)homeID collection:(NSString *)collection userToAdd:(NSString *)userToAdd homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict topicDict:(NSMutableDictionary *)topicDict allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays QueryAssignedToNewHomeMember:(BOOL)QueryAssignedToNewHomeMember QueryAssignedTo:(BOOL)QueryAssignedTo queryAssignedToUserID:(NSString *)queryAssignedToUserID ResetNotifications:(BOOL)ResetNotifications completionHandler:(void (^)(BOOL finished))finishBlock;

-(void)UpdateDataNextUsersTurnForDeletedHomeMember:(NSString *)homeID homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict topicDict:(NSMutableDictionary *)topicDict allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays homeMembersArray:(NSMutableArray *)homeMembersArray userID:(NSString *)userID completionHandler:(void (^)(BOOL finished))finishBlock;

-(void)UpdateDataSkipUsersTurn:(NSString *)itemType itemTypeCollection:(NSString *)itemTypeCollection homeID:(NSString *)homeID keyArray:(NSArray *)keyArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType topicDict:(NSMutableDictionary *)topicDict allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays homeMembersArray:(NSMutableArray *)homeMembersArray dictToUse:(NSMutableDictionary *)dictToUse userID:(NSString *)userID SkippingTurn:(BOOL)SkippingTurn DeletingHomeMember:(BOOL)DeletingHomeMember completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDictToUse))finishBlock;

-(void)UpdateDataResetRepeatingTask:(NSMutableDictionary *)itemDict itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict homeID:(NSString *)homeID itemType:(NSString *)itemType keyArray:(NSArray *)keyArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict topicDict:(NSMutableDictionary *)topicDict taskListDict:(NSMutableDictionary *)taskListDict allItemAssignedToArrays:(NSMutableArray * _Nullable)allItemAssignedToArrays allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays SkipOccurrence:(BOOL)SkipOccurrence completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningItemDict, NSMutableDictionary *returningItemOccurrencesDict, NSMutableDictionary *returningUpdatedTaskListDict))finishBlock;

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Internal Methods
#pragma mark
#pragma mark
#pragma mark -

#pragma mark Users

-(NSMutableDictionary *)GenerateItemActivityDict:(NSString *)itemID itemOccurrenceID:(NSString *)itemOccurrenceID activityUserIDNo1:(NSString *)activityUserIDNo1 homeID:(NSString *)homeID activityAction:(NSString *)activityAction userTitle:(NSString *)userTitle userDescription:(NSString *)userDescription itemType:(NSString *)itemType;

-(NSMutableDictionary *)GenerateHomeActivityDict:(NSString *)activityUserIDNo1 homeID:(NSString *)homeID activityAction:(NSString *)activityAction itemTitle:(NSString *)itemTitle itemDescription:(NSString *)itemDescription itemType:(NSString *)itemType;

#pragma mark UpdateDataSkipUsersTurn

-(NSDictionary *)UpdateDataSkipUsersTurn_GenerateSkipUserTurnDict:(NSMutableDictionary *)dictToUse homeMembersDict:(NSMutableDictionary *)homeMembersDict itemType:(NSString *)itemType;

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Sub-Internal Methods
#pragma mark
#pragma mark
#pragma mark -

#pragma mark Reset Repeating Item

-(NSDictionary *)UpdateDataResetItemFields_GenerateComplicatedRandomArray:(NSMutableArray *)userIDArray homeMembersDict:(NSMutableDictionary *)homeMembersDict allItemAssignedToArrays:(NSMutableArray *)allItemAssignedToArrays;

@end

NS_ASSUME_NONNULL_END
