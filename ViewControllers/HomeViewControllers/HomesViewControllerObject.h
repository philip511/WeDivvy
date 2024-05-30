//
//  HomesViewControllerObject.h
//  WeDivvy
//
//  Created by Philip Nagel on 9/19/21.
//

#import "AppDelegate.h"
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomesViewControllerObject : NSObject

-(void)CreateHome:(NSString *)homeID homeName:(NSString *)homeName homeMemberArray:(NSMutableArray *)homeMemberArray keyCode:(NSString *)keyCode completionHandler:(void (^)(BOOL finished, NSDictionary *returningHomeDict))finishBlock;

-(void)JoinHome:(NSString *)homeID homeKey:(NSString *)homeKey topicDict:(NSMutableDictionary *)topicDict clickedUnclaimedUser:(BOOL)clickedUnclaimedUser enabledNotifications:(BOOL)enabledNotifications currentViewController:(UIViewController *)currentViewController completionHandler:(void (^)(BOOL finished))finishBlock;

-(void)UserJoiningHome_UpdateDataForNewHomeMemberLocal:(NSString *)homeID userToAdd:(NSString *)userID homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict topicDict:(NSMutableDictionary *)topicDict clickedUnclaimedUser:(BOOL)clickedUnclaimedUser QueryAssignedToNewHomeMember:(BOOL)QueryAssignedToNewHomeMember QueryAssignedTo:(BOOL)QueryAssignedTo queryAssignedToUserID:(NSString *)queryAssignedToUserID ResetNotifications:(BOOL)ResetNotifications completionHandler:(void (^)(BOOL finished))finishBlock;

@end

NS_ASSUME_NONNULL_END
