//
//  DeleteDataObject.h
//  WeDivvy
//
//  Created by Philip Nagel on 9/14/21.
//

#import "AppDelegate.h"
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeleteDataObject : NSObject

#pragma mark - Activity

#pragma mark Delete Item - Delete All Activity In Specific Item

-(void)DeleteDataItemActivity:(NSString *)collection itemID:(NSString *)itemID itemOccurrenceID:(NSString *)itemOccurrenceID homeID:(NSString *)homeID completionHandler:(void (^)(BOOL finished))finishBlock;

#pragma mark Delete Home - Delete All Activity In Specific Home

-(void)DeleteDataHomeActivity:(NSString *)homeID completionHandler:(void (^)(BOOL finished))finishBlock;

#pragma mark - Algolia

-(void)DeleteDataDeleteAlgoliaObject:(NSString *)itemUniqueID completionHandler:(void (^)(BOOL finished))finishBlock;

#pragma mark - Analytics

-(void)DeleteDataOldMixPanelID:(NSString *)currentMixPanelID completionHandler:(void (^)(BOOL finished))finishBlock;

#pragma mark - Core Data

-(void)DeleteDataCoreData:(NSString *)entity predicate:(NSPredicate * _Nullable)predicate;

#pragma mark - Chats

-(void)DeleteDataGroupChat:(NSString *)homeID chatID:(NSString *)chatID completionHandler:(void (^)(BOOL finished, NSError *error))finishBlock;

-(void)DeleteDataGroupChatsInSpecificHome:(NSString *)homeID completionHandler:(void (^)(BOOL finished, NSError *error))finishBlock;

#pragma mark - Drafts

-(void)DeleteDataDraft:(NSString *)draftID draftCreatedBy:(NSString *)draftCreatedBy completionHandler:(void (^)(BOOL finished))finishBlock;

#pragma mark - Folders

-(void)DeleteDataFolder:(NSString *)folderID folderCreatedBy:(NSString *)folderCreatedBy completionHandler:(void (^)(BOOL finished))finishBlock;

#pragma mark - Forum

-(void)DeleteDataForum:(NSString *)collectionKey forumID:(NSString *)forumID completionHandler:(void (^)(BOOL finished, NSError *error))finishBlock;

#pragma mark - Homes

-(void)DeleteDataHome:(NSString *)homeID completionHandler:(void (^)(BOOL finished))finishBlock;

-(void)DeleteDataHomeImage:(NSString *)homeID completionHandler:(void (^)(BOOL finished))finishBlock;

#pragma mark Delete Home - Delete All Notifications In Specific Home

-(void)DeleteDataHomeNotifications:(NSString *)homeID completionHandler:(void (^)(BOOL finished))finishBlock;

#pragma mark Delete Home - Delete User From Specific Home

-(void)DeleteDataUserFromHome:(NSString *)userID completionHandler:(void (^)(BOOL finished))finishBlock;

#pragma mark Delete Home - Delete Home Completely

-(void)DeleteHomeCompletely:(NSIndexPath *)indexPath homeDict:(NSMutableDictionary *)homeDict keyArray:(NSArray *)keyArray userID:(NSString *)userID homeMembersDict:(NSMutableDictionary *)homeMembersDict topicDict:(NSMutableDictionary *)topicDict QueryAssignedToNewHomeMember:(BOOL)QueryAssignedToNewHomeMember QueryAssignedTo:(BOOL)QueryAssignedTo queryAssignedToUserID:(NSString *)queryAssignedToUserID completionHandler:(void (^)(BOOL finished))finishBlock;

#pragma mark - Messages

-(void)DeleteDataMessage:(NSString *)messageID userID:(NSString *)userID homeID:(NSString *)homeID itemType:(NSString *)itemType itemID:(NSString *)itemID chatID:(NSString *)chatID viewingGroupChat:(BOOL)viewingGroupChat viewingComments:(BOOL)viewingComments viewingLiveSupport:(BOOL)viewingLiveSupport completionHandler:(void (^)(BOOL finished))finishBlock;

#pragma mark Compound Methods

-(void)DeleteAllMessagesInGroupChat:(NSString *)homeID chatID:(NSString *)chatID completionHandler:(void (^)(BOOL finished))finishBlock;

-(void)DeleteAllMessagesInComments:(NSString *)homeID itemID:(NSString *)itemID itemType:(NSString *)itemType completionHandler:(void (^)(BOOL finished))finishBlock;

#pragma mark - Notifications

-(void)DeleteDataNotification:(NSString *)homeID notificationID:(NSString *)notificationID completionHandler:(void (^)(BOOL finishe))finishBlock;

#pragma mark - Promotional Codes

-(void)DeleteDataPromotionalCode:(NSString *)promotionalCodeID completionHandler:(void (^)(BOOL finishe))finishBlock;

#pragma mark - Sections

-(void)DeleteDataSection:(NSString *)sectionID sectionCreatedBy:(NSString *)sectionCreatedBy completionHandler:(void (^)(BOOL finished))finishBlock;

#pragma mark - Task Lists

-(void)DeleteDataRemoveTaskList:(NSString *)taskListID taskListCreatedBy:(NSString *)taskListCreatedBy completionHandler:(void (^)(BOOL finished))finishBlock;

#pragma mark - Templates

-(void)DeleteDataTemplate:(NSString *)templateID templateCreatedBy:(NSString *)templateCreatedBy completionHandler:(void (^)(BOOL finished))finishBlock;

#pragma mark - Users

-(void)DeleteDataUser:(NSString *)userID completionHandler:(void (^)(BOOL finished, NSError *error))finishBlock;

-(void)DeleteDataUserNotificationSettings:(NSString *)userID completionHandler:(void (^)(BOOL finished, NSError *error))finishBlock;

-(void)DeleteDataUserCalendarSettings:(NSString *)userID completionHandler:(void (^)(BOOL finished, NSError *error))finishBlock;

-(void)DeleteDataProfileImage:(NSString *)userID completionHandler:(void (^)(BOOL finished, NSError *error))finishBlock;

#pragma mark - Items

#pragma mark Delete Item

-(void)DeleteDataItem:(NSString *)collection itemID:(NSString *)itemID itemOccurrenceID:(NSString *)itemOccurrenceID homeID:(NSString *)homeID completionHandler:(void (^)(BOOL finished))finishBlock;

-(void)DeleteDataItemOccurrences:(NSString *)collection itemID:(NSString *)itemID itemOccurrenceID:(NSString *)itemOccurrenceID homeID:(NSString *)homeID keyArray:(NSArray *)keyArray completionHandler:(void (^)(BOOL finished))finishBlock;

-(void)DeleteDataItemImage:(NSString *)itemUniqueID itemType:(NSString *)itemType completionHandler:(void (^)(BOOL finished))finishBlock;

-(void)DeleteDataItemPhotoConfirmationImage:(NSString *)itemUniqueID itemType:(NSString *)itemType markedObject:(NSString *)markedObject completionHandler:(void (^)(BOOL finished))finishBlock;

#pragma mark Delete User - Remove User From Item

-(void)DeleteUserFromAssignedTo:(NSString *)itemType itemTypeCollection:(NSString *)itemTypeCollection keyArray:(NSArray *)keyArray homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType topicDict:(NSMutableDictionary *)topicDict allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays dictToUse:(NSMutableDictionary *)dictToUse itemAssignedToUsername:(NSMutableArray *)itemAssignedToUsername userIDToRemove:(NSString *)userIDToRemove completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDictToUse))finishBlock;

#pragma mark Delete Item - Delete Specific Item Entirely

-(void)DeleteDataItemCompletely:(NSMutableDictionary *)dictToUse homeID:(NSString *)homeID itemType:(NSString *)itemType keyArray:(NSArray *)keyArray homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType topicDict:(NSMutableDictionary *)topicDict taskListDict:(NSMutableDictionary *)taskListDict allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays currentViewController:(UIViewController *)currentViewController completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningUpdatedTaskListDict))finishBlock;

#pragma mark Delete Home - Delete All Items In Specific Home

-(void)DeleteDataAllItemsInSpecificHome:(NSString *)homeID collection:(NSString *)collection itemType:(NSString *)itemType userID:(NSString *)userID homeMembersDict:(NSMutableDictionary *)homeMembersDict topicDict:(NSMutableDictionary *)topicDict QueryAssignedToNewHomeMember:(BOOL)QueryAssignedToNewHomeMember QueryAssignedTo:(BOOL)QueryAssignedTo queryAssignedToUserID:(NSString *)queryAssignedToUserID completionHandler:(void (^)(BOOL finished))finishBlock;

#pragma mark Delete User - Remove User From Item

-(NSMutableDictionary *)DeleteUserFromAssignedTo_GenerateDictWithUserRemoved:(NSMutableDictionary *)dictToUse homeMembersDict:(NSMutableDictionary *)homeMembersDict userIDToRemove:(NSString *)userIDToRemove itemType:(NSString *)itemType itemAssignedToUsername:(NSMutableArray *)itemAssignedToUsername;

@end

NS_ASSUME_NONNULL_END
