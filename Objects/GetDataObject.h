//
//  GetDataObject.h
//  WeDivvy
//
//  Created by Philip Nagel on 9/14/21.
//

#import "AppDelegate.h"
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GetDataObject : NSObject

#pragma mark - Activity

-(void)GetDataItemActivity:(NSString *)collection itemID:(NSString *)itemID homeID:(NSString *)homeID completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningActivityDict))finishBlock;

-(void)GetDataHomeActivity:(NSString *)homeID completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningActivityDict))finishBlock;

-(void)GetDataUnreadHomeActivity:(NSString *)homeID userID:(NSString *)userID completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningActivityDict))finishBlock;

#pragma mark - Core Data

-(void)GetDataCoreData:(NSString *)entity predicate:(NSPredicate * _Nullable)predicate keyArray:(NSArray *)keyArray completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDataDict))finishBlock;

-(void)GetDataCoreDataNo1:(NSString *)entity predicate:(NSPredicate * _Nullable)predicate keyArray:(NSArray *)keyArray managedObjectContext:(NSManagedObjectContext *)managedObjectContext completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDataDict))finishBlock;

#pragma mark - Chats

-(void)GetDataChat:(NSString *)chatID homeID:(NSString *)homeID keyArray:(NSArray *)keyArray completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDataDict))finishBlock;

-(void)GetDataChatsInSpecificHome:(NSString *)homeID keyArray:(NSArray *)keyArray completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDataDict))finishBlock;

-(void)GetDataChatsAssignedToNewHomeMembersInSpecificHome:(NSString *)collection homeID:(NSString *)homeID completionHandler:(void (^)(BOOL finished, FIRQuerySnapshot *snapshot))finishBlock;

-(void)GetDataMasterLiveChats:(NSMutableArray *)chatArray completionHandler:(void (^)(BOOL finished, NSMutableArray *chatArray))finishBlock;

#pragma mark - Drafts

-(void)GetDataDrafts:(NSArray *)keyArray userID:(NSString *)userID completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDataDict))finishBlock;

#pragma mark - Feedback

-(void)GetDataFeedback:(NSArray *)keyArray userID:(NSString *)userID completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDataDict))finishBlock;

#pragma mark - Folders

-(void)GetDataFolders:(NSArray *)keyArray userID:(NSString *)userID completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDataDict))finishBlock;

#pragma mark - Forum

-(void)GetDataForumItem:(NSString *)forumID collectionKey:(NSString *)collectionKey keyArray:(NSArray *)keyArray currentViewController:(UIViewController *)currentViewController completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDataDict))finishBlock;

-(void)GetDataForumItems:(NSString *)collection keyArray:(NSArray *)keyArray completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDataDict))finishBlock;

#pragma mark - Homes

-(void)GetDataHomesUserIdMemberOfSnapshot:(NSString *)userID completionHandler:(void (^)(BOOL finished, FIRQuerySnapshot *snapshot))finishBlock;

-(void)GetDataHomesUserIsMemberOf:(NSArray *)keyArray userID:(NSString *)userID completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningHomeDict))finishBlock;

-(void)GetDataHomesWithHomeIDAndHomeMember:(NSArray *)keyArray userID:(NSString *)userID homeID:(NSString *)homeID completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningHomeDict))finishBlock;

-(void)GetDataHomeMembers:(NSString *)homeID completionHandler:(void (^)(BOOL finished, NSMutableArray *homeMembers))finishBlock;

-(void)GetDataFindHomeKey:(NSString *)homeKey completionHandler:(void (^)(BOOL finished, BOOL homeKeyExists, NSString *homeIDLinkedToKey, NSString *errorString))finishBlock;

-(void)GetDataFindHomeKeyInKeyArray:(NSString *)homeKey completionHandler:(void (^)(BOOL finished, BOOL homeKeyExists, NSString *homeIDLinkedToKey, NSString *errorString))finishBlock;

-(void)GetDataHomeKeys:(NSString *)homeID completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningHomeKeysArray))finishBlock;

-(void)GetDataSpecificHomeData:(NSString *)homeID keyArray:(NSArray *)keyArray completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningHomeToJoinDict, NSMutableArray *queriedHomeMemberArray, NSString *queriedHomeID))finishBlock;

-(void)GetDataSpecificHomeDataWithoutListener:(NSString *)homeID keyArray:(NSArray *)keyArray completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningHomeToJoinDict))finishBlock;

#pragma mark Compound Method

-(void)GetDataHomeWithPromoCodeSender:(NSString *)homeID completionHandler:(void (^)(BOOL finished, BOOL HomeHasPromoCodeSender))finishBlock;

#pragma mark - Messages

-(void)GetDataMessagesInSpecificChat:(NSString *)userID homeID:(NSString *)homeID itemType:(NSString *)itemType itemID:(NSString *)itemID chatID:(NSString *)chatID keyArray:(NSArray *)keyArray messageDict:(NSMutableDictionary *)messageDict viewingGroupChat:(BOOL)viewingGroupChat viewingComments:(BOOL)viewingComments viewingLiveSupport:(BOOL)viewingLiveSupport completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningMessageDict))finishBlock;

-(void)GetDataLastMessageInSpecificChat:(NSString *)userID homeID:(NSString *)homeID itemType:(NSString *)itemType itemID:(NSString *)itemID chatID:(NSString *)chatID keyArray:(NSArray *)keyArray viewingGroupChat:(BOOL)viewingGroupChat viewingComments:(BOOL)viewingComments viewingLiveSupport:(BOOL)viewingLiveSupport completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningMessageDict))finishBlock;

#pragma mark - Notifications

-(void)GetDataNotifications:(NSString *)homeID keyArray:(NSArray *)keyArray completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDataDict))finishBlock;

-(void)GetDataNotificationsNotCreatedBySpecificUser:(NSString *)homeID userID:(NSString *)userID keyArray:(NSArray *)keyArray completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDataDict))finishBlock;

-(void)GetDataUnreadNotificationsCountNotCreatedBySpecificUser:(NSString *)homeID userID:(NSString *)userID completionHandler:(void (^)(BOOL finished, NSString *unreadNotificationCount))finishBlock;


#pragma mark - Users

-(void)GetDataCheckIfObjectInFieldExistsInCollection:(NSString *)collection field:(NSString *)field object:(NSString *)object thirdPartySignUp:(BOOL)thirdPartySignUp completionHandler:(void (^)(BOOL finished, BOOL doesObjectExist))finishBlock;

-(void)GetDataCostPerPersonUserData:(NSMutableArray *)itemAssignedToArray costArray:(NSMutableArray *)costArray costPerPersonDict:(NSMutableDictionary *)costPerPersonDict completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningUserDict))finishBlock;

-(void)GetDataExistingUserData:(NSString *)userEmail completionHandler:(void (^)(BOOL finished, NSString *userID, NSString *currentMixPanelID, BOOL userFound))finishBlock;

-(void)GetDataProfileUser:(NSString *)userID completionHandler:(void (^)(BOOL finished, NSString *username, NSString *userImageURL))finishBlock;

-(void)GetDataUserData:(NSString *)userID completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningUserDict))finishBlock;

-(void)GetDataUserDataArray:(NSMutableArray *)userIDArray completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningUserDict))finishBlock;

-(void)GetDataUserNotificationSettingsData:(NSMutableArray *)userIDArray completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningNotificationSettingsDict))finishBlock;

-(void)GetDataUserCalendarSettingsData:(NSMutableArray *)userIDArray completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningCalendarSettingsDict))finishBlock;

-(void)GetDataUserWithEmail:(NSString *)userEmail completionHandler:(void (^)(BOOL finished, FIRQuerySnapshot * _Nullable snapshot))finishBlock;

-(void)GetDataBlockedUser:(NSString *)userID completionHandler:(void (^)(BOOL finished, BOOL userIsBlocked))finishBlock;

-(void)GetDataBlockedUsers:(NSArray *)keyArray userID:(NSString *)userID completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningBlockedUserDict))finishBlock;

-(void)GetDataContacts:(void (^)(BOOL finished, BOOL grantedAccess, NSMutableDictionary *returningContactDict))finishBlock;

-(void)GetDataMixpanelID:(NSString *)userID completionHandler:(void (^)(BOOL finished, NSString *mixPanelID))finishBlock;

#pragma mark - Promotional Codes

-(void)GetDataSpecificUserPromotionalCodeData:(NSString *)userID keyArray:(NSArray *)keyArray completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningPromotionalCodeDict))finishBlock;

-(void)GetDataPromotionalCode:(NSArray *)keyArray userID:(NSString *)userID promotionalCode:(NSString *)promotionalCode completionHandler:(void (^)(BOOL finished, NSDictionary *dataDict))finishBlock;

-(void)GetDataPromotionalCodeWithID:(NSArray *)keyArray promotionalCodeID:(NSString *)promotionalCodeID completionHandler:(void (^)(BOOL finished, NSDictionary *dataDict))finishBlock;

-(void)GetDataPromotionalCodeUsedByReceiverNotBySender:(NSArray *)keyArray userID:(NSString *)userID completionHandler:(void (^)(BOOL finished, NSDictionary *dataDict))finishBlock;

#pragma mark - Reminders

-(void)GetDataReminders:(NSArray *)keyArray userID:(NSString *)userID completionHandler:(void (^)(BOOL finished, NSDictionary *returningDataDict))finishBlock;

#pragma mark - Sections

-(void)GetDataSections:(NSArray *)keyArray userID:(NSString *)userID completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDataDict))finishBlock;

#pragma mark - Subscriptions

-(void)GetDataSubscriptionPurchsedByUser:(NSString *)userID completionhandler:(void (^)(BOOL finished, NSDictionary * _Nullable subscriptionDict))finishBlock;

-(void)GetDataSubscriptionWithID:(NSString *)subscriptionID completionhandler:(void (^)(BOOL finished, NSDictionary * _Nullable subscriptionDict))finishBlock;

#pragma mark - Task Lists

-(void)GetDataTaskLists:(NSArray *)keyArray userID:(NSString *)userID completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDataDict))finishBlock;

#pragma mark - Templates

-(void)GetDataTemplates:(NSArray *)keyArray userID:(NSString *)userID completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDataDict))finishBlock;

#pragma mark - Topics

-(void)GetDataTopics:(NSArray *)keyArray homeID:(NSString *)homeID completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDataDict))finishBlock;

#pragma mark - Items

-(void)GetDataItem:(NSString *)itemID itemOccurrenceID:(NSString *)itemOccurrenceID collection:(NSString *)collection homeID:(NSString *)homeID keyArray:(NSArray *)keyArray completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDataDict))finishBlock;

-(void)GetDataItemImage:(NSString *)itemImageURL completionHandler:(void (^)(BOOL finished, NSURL *itemImageURL))finishBlock;

-(void)GetDataItemsInSpecificHome:(NSString *)homeID collection:(NSString *)collection keyArray:(NSArray *)keyArray currentViewController:(UIViewController *)currentViewController crashlyticsString:(NSString *)crashlyticsString completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDataDict))finishBlock;

-(void)GetDataItemsInSpecificHome_Chores_BugFix:(NSString *)homeID collection:(NSString *)collection keyArray:(NSArray *)keyArray currentViewController:(UIViewController *)currentViewController crashlyticsString:(NSString *)crashlyticsString completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDataDict))finishBlock;

-(void)GetDataItemsInSpecificHomeWithSpecificQuery:(NSString *)homeID collection:(NSString *)collection QueryAssignedToNewHomeMember:(BOOL)QueryAssignedToNewHomeMember QueryAssignedTo:(BOOL)QueryAssignedTo queryAssignedToUserID:(NSString *)queryAssignedToUserID completionHandler:(void (^)(BOOL finished, FIRQuerySnapshot *snapshot))finishBlock;

-(void)GetDataGetItemsTurnUserID:(NSString *)homeID collection:(NSString *)collection userID:(NSString *)userID keyArray:(NSArray *)keyArray completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningItemsDict))finishBlock;

-(void)GetDataGetItemsCreatedBy:(NSString *)homeID collection:(NSString *)collection userID:(NSString *)userID completionHandler:(void (^)(BOOL finished, FIRQuerySnapshot *snapshot))finishBlock;

-(void)GetDataGetItemsCompletedBy:(NSString *)homeID collection:(NSString *)collection userID:(NSString *)userID completionHandler:(void (^)(BOOL finished, FIRQuerySnapshot *snapshot))finishBlock;

-(void)GetDataItemOccurrencesForSingleItem:(NSString *)collection itemID:(NSString *)itemID homeID:(NSString *)homeID keyArray:(NSArray *)keyArray completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningOccurrencesDict))finishBlock;

#pragma mark

-(void)GetDataItemOccurrenceAmounts:(NSString *)collection homeID:(NSString *)homeID itemID:(NSString *)itemID keyArray:(NSArray *)keyArray ItemOccurrenceStatusCompleted:(BOOL)ItemOccurrenceStatus completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningOccurrencesDict))finishBlock;

#pragma mark

-(void)GetDataItemOccurrencesEndNumberOfTimes_Amounts:(NSString *)collection homeID:(NSString *)homeID dictToUse:(NSMutableDictionary *)dictToUse keyArray:(NSArray *)keyArray completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningOccurrencesDict))finishBlock;

-(void)GetDataItemOccurrencesAlternatingTurnsCompleted_Amounts:(NSString *)collection homeID:(NSString *)homeID dictToUse:(NSMutableDictionary *)dictToUse keyArray:(NSArray *)keyArray completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningOccurrencesDict))finishBlock;

-(void)GetDataItemOccurrencesAlternatingTurnsOccurrences_Amounts:(NSString *)collection homeID:(NSString *)homeID dictToUse:(NSMutableDictionary *)dictToUse keyArray:(NSArray *)keyArray completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningOccurrencesDict))finishBlock;

#pragma mark

-(void)GetDataItemOccurrences_OccurrenceStatusNone_NotFullyCompleted:(NSString *)collection homeID:(NSString *)homeID keyArray:(NSArray *)keyArray itemType:(NSString *)itemType homeMembersDict:(NSMutableDictionary *)homeMembersDict completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningOccurrencesDict))finishBlock;

@end

NS_ASSUME_NONNULL_END
