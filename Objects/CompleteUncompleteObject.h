//
//  CompleteUncompleteObject.h
//  WeDivvy
//
//  Created by Philip Nagel on 3/25/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CompleteUncompleteObject : NSObject

#pragma mark Tasks

-(void)TaskCompleteUncomplete:(NSMutableDictionary *)dictToUse itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict keyArray:(NSArray *)keyArray homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType topicDict:(NSMutableDictionary *)topicDict taskListDict:(NSMutableDictionary *)taskListDict allItemAssignedToArrays:(NSMutableArray * _Nullable)allItemAssignedToArrays allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays userWhoIsBeingMarkedUserID:(NSString *)userWhoIsBeingMarkedUserID markingForSomeoneElse:(BOOL)markingForSomeoneElse currentViewController:(UIViewController *)currentViewController completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse, NSMutableDictionary *returningUpdatedTaskListDictToUse, BOOL TaskIsFullyCompleted))finishBlock;

-(void)TaskInProgressNotInProgress:(NSMutableDictionary *)dictToUse itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict keyArray:(NSArray *)keyArray homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType topicDict:(NSMutableDictionary *)topicDict allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays userWhoIsBeingMarkedUserID:(NSString *)userWhoIsBeingMarkedUserID markingForSomeoneElse:(BOOL)markingForSomeoneElse currentViewController:(UIViewController *)currentViewController completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse))finishBlock;

-(void)TaskWillDoWontDo:(NSMutableDictionary *)dictToUse itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict keyArray:(NSArray *)keyArray homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType topicDict:(NSMutableDictionary *)topicDict taskListDict:(NSMutableDictionary *)taskListDict allItemAssignedToArrays:(NSMutableArray * _Nullable)allItemAssignedToArrays allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays userWhoIsBeingMarkedUserID:(NSString *)userWhoIsBeingMarkedUserID markingForSomeoneElse:(BOOL)markingForSomeoneElse currentViewController:(UIViewController *)currentViewController completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse, NSMutableDictionary *returningUpdatedTaskListDictToUse, BOOL TaskIsFullyCompleted))finishBlock;

#pragma mark Subtasks

-(void)SubtaskCompleteUncomplete:(NSMutableDictionary *)dictToUse itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict keyArray:(NSArray *)keyArray homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType topicDict:(NSMutableDictionary *)topicDict allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays subtaskThatIsBeingMarked:(NSString *)subtaskThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse currentViewController:(UIViewController *)currentViewController completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse))finishBlock;

-(void)SubtaskInProgressNotInProgress:(NSMutableDictionary *)dictToUse itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict keyArray:(NSArray *)keyArray homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType topicDict:(NSMutableDictionary *)topicDict allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays subtaskThatIsBeingMarked:(NSString *)subtaskThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse currentViewController:(UIViewController *)currentViewController completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse))finishBlock;

-(void)SubtaskWillDoWontDo:(NSMutableDictionary *)dictToUse itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict keyArray:(NSArray *)keyArray homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType topicDict:(NSMutableDictionary *)topicDict allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays subtaskThatIsBeingMarked:(NSString *)subtaskThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse currentViewController:(UIViewController *)currentViewController completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse))finishBlock;

#pragma mark List Items

-(void)ListItemCompleteUncomplete:(NSMutableDictionary *)dictToUse itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict keyArray:(NSArray *)keyArray homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType topicDict:(NSMutableDictionary *)topicDict taskListDict:(NSMutableDictionary *)taskListDict allItemAssignedToArrays:(NSMutableArray * _Nullable)allItemAssignedToArrays allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays listItemThatIsBeingMarked:(NSString *)listItemThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse currentViewController:(UIViewController *)currentViewController completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse, NSMutableDictionary *returningUpdatedTaskListDictToUse))finishBlock;

-(void)ListItemInProgressNotInProgress:(NSMutableDictionary *)dictToUse itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict keyArray:(NSArray *)keyArray homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType topicDict:(NSMutableDictionary *)topicDict allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays listItemThatIsBeingMarked:(NSString *)listItemThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse currentViewController:(UIViewController *)currentViewController completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse))finishBlock;

-(void)ListItemWillDoWontDo:(NSMutableDictionary *)dictToUse itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict keyArray:(NSArray *)keyArray homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType topicDict:(NSMutableDictionary *)topicDict taskListDict:(NSMutableDictionary *)taskListDict allItemAssignedToArrays:(NSMutableArray * _Nullable)allItemAssignedToArrays allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays listItemThatIsBeingMarked:(NSString *)listItemThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse currentViewController:(UIViewController *)currentViewController completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse, NSMutableDictionary *returningUpdatedTaskListDictToUse))finishBlock;

#pragma mark Itemized Items

-(void)ItemizedItemCompleteUncomplete:(NSMutableDictionary *)dictToUse itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict keyArray:(NSArray *)keyArray homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType topicDict:(NSMutableDictionary *)topicDict taskListDict:(NSMutableDictionary *)taskListDict allItemAssignedToArrays:(NSMutableArray * _Nullable)allItemAssignedToArrays allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays itemizedItemThatIsBeingMarked:(NSString *)itemizedItemThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse currentViewController:(UIViewController *)currentViewController completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse, NSMutableDictionary *returningUpdatedTaskListDictToUse))finishBlock;

-(void)ItemizedItemInProgressNotInProgress:(NSMutableDictionary *)dictToUse itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict keyArray:(NSArray *)keyArray homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType topicDict:(NSMutableDictionary *)topicDict allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays  itemizedItemThatIsBeingMarked:(NSString *)itemizedItemThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse currentViewController:(UIViewController *)currentViewController completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse))finishBlock;

-(void)ItemizedItemWillDoWontDo:(NSMutableDictionary *)dictToUse itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict keyArray:(NSArray *)keyArray homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType topicDict:(NSMutableDictionary *)topicDict taskListDict:(NSMutableDictionary *)taskListDict allItemAssignedToArrays:(NSMutableArray * _Nullable)allItemAssignedToArrays allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays  itemizedItemThatIsBeingMarked:(NSString *)itemizedItemThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse currentViewController:(UIViewController *)currentViewController completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse, NSMutableDictionary *returningUpdatedTaskListDictToUse))finishBlock;

#pragma mark

-(NSIndexPath *)GenerateTempIndexPath;

#pragma mark
#pragma mark
#pragma mark
#pragma mark
#pragma mark
#pragma mark - Update Task Dict

-(NSMutableDictionary *)GenerateUpdatedTaskCompleteUncompleteDict:(NSMutableDictionary *)dictToUse itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict homeMembersDict:(NSMutableDictionary *)homeMembersDict userWhoIsBeingMarkedUserID:(NSString *)userWhoIsBeingMarkedUserID markingForSomeoneElse:(BOOL)markingForSomeoneElse;

-(NSMutableDictionary *)GenerateUpdatedTaskInProgressNotInProgressDict:(NSMutableDictionary *)dictToUse userWhoIsBeingMarkedUserID:(NSString *)userWhoIsBeingMarkedUserID markingForSomeoneElse:(BOOL)markingForSomeoneElse;

-(NSMutableDictionary *)GenerateUpdatedTaskWontDoWillDoDict:(NSMutableDictionary *)dictToUse userWhoIsBeingMarkedUserID:(NSString *)userWhoIsBeingMarkedUserID markingForSomeoneElse:(BOOL)markingForSomeoneElse;

#pragma mark - Update Subtasks Dict

-(NSMutableDictionary *)GenerateUpdatedSubtaskCompleteUncompleteDict:(NSMutableDictionary *)dictToUse subtaskThatIsBeingMarked:(NSString *)subtaskThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse;

-(NSMutableDictionary *)GenerateUpdatedSubtaskInProgressNotInProgressDict:(NSMutableDictionary *)dictToUse subtaskThatIsBeingMarked:(NSString *)subtaskThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse;

-(NSMutableDictionary *)GenerateUpdatedSubtaskWontDoWillDoDict:(NSMutableDictionary *)dictToUse subtaskThatIsBeingMarked:(NSString *)subtaskThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse;

#pragma mark - Updated List Items Dict

-(NSMutableDictionary *)GenerateUpdatedListItemCompleteUncompleteDict:(NSMutableDictionary *)dictToUse itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict homeMembersDict:(NSMutableDictionary *)homeMembersDict listItemThatIsBeingMarked:(NSString *)listItemThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse;

-(NSMutableDictionary *)GenerateUpdatedListItemInProgressNotInProgressDict:(NSMutableDictionary *)dictToUse listItemThatIsBeingMarked:(NSString *)listItemThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse;

-(NSMutableDictionary *)GenerateUpdatedListItemWontDoWillDoDict:(NSMutableDictionary *)dictToUse listItemThatIsBeingMarked:(NSString *)listItemThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse;

#pragma mark - Update Itemized Items Dict

-(NSMutableDictionary *)GenerateUpdatedItemizedItemCompleteUncompleteDict:(NSMutableDictionary *)dictToUse itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict homeMembersDict:(NSMutableDictionary *)homeMembersDict itemizedItemThatIsBeingMarked:(NSString *)itemizedItemThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse;

-(NSMutableDictionary *)GenerateUpdatedItemizedItemInProgressNotInProgressDict:(NSMutableDictionary *)dictToUse itemizedItemThatIsBeingMarked:(NSString *)itemizedItemThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse;

-(NSMutableDictionary *)GenerateUpdatedItemizedItemWontDoWillDoDict:(NSMutableDictionary *)dictToUse itemizedItemThatIsBeingMarked:(NSString *)itemizedItemThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse;

@end

NS_ASSUME_NONNULL_END
