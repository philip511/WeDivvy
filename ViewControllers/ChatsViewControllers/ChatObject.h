//
//  ChatObject.h
//  WeDivvy
//
//  Created by Philip Nagel on 9/20/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChatObject : NSObject

-(void)QueryDataChatsViewController:(NSString *)homeID keyArray:(NSArray *)keyArray messageKeyArray:(NSArray *)messageKeyArray completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningHomeMembersDict, NSMutableDictionary *returningHomeKeysDict, NSMutableDictionary *returningHomeMembersUnclaimedDictLocal, NSMutableDictionary *returningItemDict, NSMutableDictionary *returningLastMessageDict, NSString *returningUnreadNotificationsCount, NSMutableDictionary *returningNotificationSettingsDict, NSMutableDictionary *returningTopicDict))finishBlock;

-(void)QueryDataLiveChatViewController:(NSString *)userID homeID:(NSString *)homeID itemType:(NSString *)itemType itemID:(NSString *)itemID itemName:(NSString *)itemName itemCreatedBy:(NSString *)itemCreatedBy itemAssignedTo:(NSMutableArray *)itemAssignedTo chatID:(NSString *)chatID chatName:(NSString *)chatName chatAssignedTo:(NSMutableArray *)chatAssignedTo chatKeyArray:(NSArray *)chatKeyArray messageKeyArray:(NSArray *)messageKeyArray messageDict:(NSMutableDictionary *)messageDict viewingGroupChat:(BOOL)viewingGroupChat viewingComments:(BOOL)viewingComments viewingLiveSupport:(BOOL)viewingLiveSupport completionHandler:(void (^)(BOOL finished, BOOL callSecondBlock, NSMutableDictionary *returningMessageDict, NSMutableDictionary *returningChatDict, NSMutableDictionary *returningUserDict))finishBlock;

-(void)SendChat:(NSString *)userID homeID:(NSString *)homeID itemType:(NSString *)itemType itemID:(NSString *)itemID itemName:(NSString *)itemName itemCreatedBy:(NSString *)itemCreatedBy itemAssignedTo:(NSMutableArray *)itemAssignedTo chatID:(NSString *)chatID chatName:(NSString *)chatName chatAssignedTo:(NSMutableArray *)chatAssignedTo homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType topicDict:(NSMutableDictionary *)topicDict viewingGroupChat:(BOOL)viewingGroupChat viewingComments:(BOOL)viewingComments viewingLiveSupport:(BOOL)viewingLiveSupport dataDict:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished))finishBlock;

-(void)EndChat:(NSString *)userID homeID:(NSString *)homeID itemType:(NSString *)itemType itemID:(NSString *)itemID chatID:(NSString *)chatID completionHandler:(void (^)(BOOL finished))finishBlock;

@end

NS_ASSUME_NONNULL_END
