//
//  CompleteUncompleteObject.m
//  WeDivvy
//
//  Created by Philip Nagel on 3/25/22.
//

#import "CompleteUncompleteObject.h"

#import "GeneralObject.h"
#import "GetDataObject.h"
#import "SetDataObject.h"
#import "NotificationsObject.h"
#import "BoolDataObject.h"

@implementation CompleteUncompleteObject

#pragma mark - Mark Task Complete / In Progress

-(void)TaskCompleteUncomplete:(NSMutableDictionary *)dictToUse itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict keyArray:(NSArray *)keyArray homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType topicDict:(NSMutableDictionary *)topicDict taskListDict:(NSMutableDictionary *)taskListDict allItemAssignedToArrays:(NSMutableArray * _Nullable)allItemAssignedToArrays allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays userWhoIsBeingMarkedUserID:(NSString *)userWhoIsBeingMarkedUserID markingForSomeoneElse:(BOOL)markingForSomeoneElse currentViewController:(UIViewController *)currentViewController completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse, NSMutableDictionary *returningUpdatedTaskListDictToUse, BOOL TaskIsFullyCompleted))finishBlock {
   
    NSString *itemType = [[[GeneralObject alloc] init] GenerateItemType];
    
    
    
    
    dictToUse = [[[CompleteUncompleteObject alloc] init] GenerateUpdatedTaskCompleteUncompleteDict:dictToUse itemOccurrencesDict:itemOccurrencesDict homeMembersDict:homeMembersDict userWhoIsBeingMarkedUserID:userWhoIsBeingMarkedUserID markingForSomeoneElse:markingForSomeoneElse];
    
    
    
    
    BOOL TaskIsBeingMarkedCompleted = [[[CompleteUncompleteObject alloc] init] GenerateTaskIsBeingMarkedCompleted:dictToUse userWhoIsBeingMarkedUserID:userWhoIsBeingMarkedUserID];
    [[[CompleteUncompleteObject alloc] init] IncreaseCountForCompletedItemCount:TaskIsBeingMarkedCompleted];
    
    
    
    
    __block int totalQueries = 5;
    __block int completedQueries = 0;
    
    
    
    
    __block BOOL TaskIsFullyCompletedLocal = [[[BoolDataObject alloc] init] TaskIsFullyCompleted:dictToUse itemType:itemType homeMembersDict:homeMembersDict];
    __block NSMutableDictionary *returningDictToUseLocal = [dictToUse mutableCopy];
    __block NSMutableDictionary *returningOccurrencesDictToUseLocal = [itemOccurrencesDict mutableCopy];
    __block NSMutableDictionary *returningUpdatedTaskListDictToUseLocal = [NSMutableDictionary dictionary];
    
    
    
    /*
     //
     //
     //Send Push Notifications
     //
     //
     */
    [[[CompleteUncompleteObject alloc] init] TaskCompleteUncomplete_SendPushNotifications:dictToUse itemOccurrencesDict:itemOccurrencesDict keyArray:keyArray homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType topicDict:topicDict allItemTagsArrays:allItemTagsArrays userWhoIsBeingMarkedUserID:userWhoIsBeingMarkedUserID markingForSomeoneElse:markingForSomeoneElse TaskIsFullyCompleted:TaskIsFullyCompletedLocal completionHandler:^(BOOL finished) {
        
        [[[CompleteUncompleteObject alloc] init] TaskCompleteUncomplete_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:returningDictToUseLocal itemOccurrencesDict:returningOccurrencesDictToUseLocal TaskIsFullyCompletedLocal:TaskIsFullyCompletedLocal CallNSNotificationMethods:YES completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse, BOOL TaskIsFullyCompleted) {
           
            finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse, returningUpdatedTaskListDictToUseLocal, TaskIsFullyCompleted);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Task Is Fully Completed
     //
     //
     */
    [[[CompleteUncompleteObject alloc] init] TaskCompleteUncomplete_TaskIsFullyCompleted:dictToUse itemOccurrencesDict:itemOccurrencesDict keyArray:keyArray homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType topicDict:topicDict taskListDict:taskListDict allItemAssignedToArrays:allItemAssignedToArrays allItemTagsArrays:allItemTagsArrays userWhoIsBeingMarkedUserID:userWhoIsBeingMarkedUserID markingForSomeoneElse:markingForSomeoneElse TaskIsFullyCompleted:TaskIsFullyCompletedLocal currentViewController:currentViewController completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse, NSMutableDictionary *returningUpdatedTaskListDictToUse, BOOL TaskIsFullyCompleted) {
        
        TaskIsFullyCompletedLocal = TaskIsFullyCompleted;
        returningDictToUseLocal = [returningDictToUse mutableCopy];
        returningOccurrencesDictToUseLocal = [returningOccurrencesDictToUse mutableCopy];
        returningUpdatedTaskListDictToUseLocal = [returningUpdatedTaskListDictToUse mutableCopy];
        
        [[[CompleteUncompleteObject alloc] init] TaskCompleteUncomplete_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:returningDictToUseLocal itemOccurrencesDict:returningOccurrencesDictToUseLocal TaskIsFullyCompletedLocal:TaskIsFullyCompletedLocal CallNSNotificationMethods:YES completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse, BOOL TaskIsFullyCompleted) {
          
            finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse, returningUpdatedTaskListDictToUseLocal, TaskIsFullyCompleted);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Update Item Data
     //
     //
     */
    [[[CompleteUncompleteObject alloc] init] TaskCompleteUncomplete_UpdateItemData:dictToUse itemOccurrencesDict:itemOccurrencesDict homeMembersDict:homeMembersDict keyArray:keyArray completionHandler:^(BOOL finished) {
       
        [[[CompleteUncompleteObject alloc] init] TaskCompleteUncomplete_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:returningDictToUseLocal itemOccurrencesDict:returningOccurrencesDictToUseLocal TaskIsFullyCompletedLocal:TaskIsFullyCompletedLocal CallNSNotificationMethods:YES completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse, BOOL TaskIsFullyCompleted) {
            
            finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse, returningUpdatedTaskListDictToUseLocal, TaskIsFullyCompleted);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Update Algolia Data
     //
     //
     */
    [[[CompleteUncompleteObject alloc] init] TaskCompleteUncomplete_UpdateAlgoliaData:dictToUse completionHandler:^(BOOL finished) {
       
        [[[CompleteUncompleteObject alloc] init] TaskCompleteUncomplete_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:returningDictToUseLocal itemOccurrencesDict:returningOccurrencesDictToUseLocal TaskIsFullyCompletedLocal:TaskIsFullyCompletedLocal CallNSNotificationMethods:YES completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse, BOOL TaskIsFullyCompleted) {
            
            finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse, returningUpdatedTaskListDictToUseLocal, TaskIsFullyCompleted);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Set Item And Home Activity Data
     //
     //
     */
    [[[CompleteUncompleteObject alloc] init] TaskCompleteUncomplete_SetItemAndHomeActivityData:dictToUse userWhoIsBeingMarkedUserID:userWhoIsBeingMarkedUserID TaskIsBeingMarkedCompleted:TaskIsBeingMarkedCompleted completionHandler:^(BOOL finished) {
       
        [[[CompleteUncompleteObject alloc] init] TaskCompleteUncomplete_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:returningDictToUseLocal itemOccurrencesDict:returningOccurrencesDictToUseLocal TaskIsFullyCompletedLocal:TaskIsFullyCompletedLocal CallNSNotificationMethods:YES completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse, BOOL TaskIsFullyCompleted) {
           
            finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse, returningUpdatedTaskListDictToUseLocal, TaskIsFullyCompleted);
            
        }];
        
    }];
    
}

-(void)TaskInProgressNotInProgress:(NSMutableDictionary *)dictToUse itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict keyArray:(NSArray *)keyArray homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType topicDict:(NSMutableDictionary *)topicDict allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays userWhoIsBeingMarkedUserID:(NSString *)userWhoIsBeingMarkedUserID markingForSomeoneElse:(BOOL)markingForSomeoneElse currentViewController:(UIViewController *)currentViewController completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse))finishBlock {
    
    dictToUse = [[[CompleteUncompleteObject alloc] init] GenerateUpdatedTaskInProgressNotInProgressDict:dictToUse userWhoIsBeingMarkedUserID:userWhoIsBeingMarkedUserID markingForSomeoneElse:markingForSomeoneElse];
    
    
    
    __block int totalQueries = 4;
    __block int completedQueries = 0;
    
    
    
    /*
     //
     //
     //Send Push Notifications
     //
     //
     */
    [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress_SendPushNotifications:dictToUse homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType topicDict:topicDict allItemTagsArrays:allItemTagsArrays userWhoIsBeingMarkedUserID:userWhoIsBeingMarkedUserID markingForSomeoneElse:markingForSomeoneElse completionHandler:^(BOOL finished) {
    
        [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:dictToUse itemOccurrencesDict:itemOccurrencesDict CallNSNotificationMethods:YES completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse) {
                
                finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Update Item Data
     //
     //
     */
    [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress_UpdateItemData:dictToUse completionHandler:^(BOOL finished) {
        
        [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:dictToUse itemOccurrencesDict:itemOccurrencesDict CallNSNotificationMethods:YES completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse) {
                
                finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Update Algolia Data
     //
     //
     */
    [[[CompleteUncompleteObject alloc] init] TaskCompleteUncomplete_UpdateAlgoliaData:dictToUse completionHandler:^(BOOL finished) {
        
        [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:dictToUse itemOccurrencesDict:itemOccurrencesDict CallNSNotificationMethods:YES completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse) {
                
                finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Update Item And Home Activity Data
     //
     //
     */
    [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress_SetItemAndHomeActivityData:dictToUse userWhoIsBeingMarkedUserID:userWhoIsBeingMarkedUserID completionHandler:^(BOOL finished) {
        
        [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:dictToUse itemOccurrencesDict:itemOccurrencesDict CallNSNotificationMethods:YES completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse) {
                
                finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse);
            
        }];
        
    }];
    
}

-(void)TaskWillDoWontDo:(NSMutableDictionary *)dictToUse itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict keyArray:(NSArray *)keyArray homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType topicDict:(NSMutableDictionary *)topicDict taskListDict:(NSMutableDictionary *)taskListDict allItemAssignedToArrays:(NSMutableArray * _Nullable)allItemAssignedToArrays allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays userWhoIsBeingMarkedUserID:(NSString *)userWhoIsBeingMarkedUserID markingForSomeoneElse:(BOOL)markingForSomeoneElse currentViewController:(UIViewController *)currentViewController completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse, NSMutableDictionary *returningUpdatedTaskListDictToUse, BOOL TaskIsFullyCompleted))finishBlock {
    
    NSString *itemType = [[[GeneralObject alloc] init] GenerateItemType];
    
    
    
    dictToUse = [[[CompleteUncompleteObject alloc] init] GenerateUpdatedTaskWontDoWillDoDict:dictToUse userWhoIsBeingMarkedUserID:userWhoIsBeingMarkedUserID markingForSomeoneElse:markingForSomeoneElse];
    
    
    
    __block int totalQueries = 5;
    __block int completedQueries = 0;
    
    
    
    __block BOOL TaskIsFullyCompletedLocal = [[[BoolDataObject alloc] init] TaskIsFullyCompleted:dictToUse itemType:itemType homeMembersDict:homeMembersDict];
    __block NSMutableDictionary *returningDictToUseLocal = [dictToUse mutableCopy];
    __block NSMutableDictionary *returningOccurrencesDictToUseLocal = [itemOccurrencesDict mutableCopy];
    __block NSMutableDictionary *returningUpdatedTaskListDictToUseLocal = [NSMutableDictionary dictionary];
    
    

    /*
     //
     //
     //Send Push Notifications
     //
     //
     */
    [[[CompleteUncompleteObject alloc] init] TaskCompleteUncomplete_SendPushNotifications:dictToUse itemOccurrencesDict:itemOccurrencesDict keyArray:keyArray homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType topicDict:topicDict allItemTagsArrays:allItemTagsArrays userWhoIsBeingMarkedUserID:userWhoIsBeingMarkedUserID markingForSomeoneElse:markingForSomeoneElse TaskIsFullyCompleted:TaskIsFullyCompletedLocal completionHandler:^(BOOL finished) {
        
        [[[CompleteUncompleteObject alloc] init] TaskCompleteUncomplete_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:returningDictToUseLocal itemOccurrencesDict:returningOccurrencesDictToUseLocal TaskIsFullyCompletedLocal:TaskIsFullyCompletedLocal CallNSNotificationMethods:YES completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse, BOOL TaskIsFullyCompleted) {
            
            finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse, returningUpdatedTaskListDictToUseLocal, TaskIsFullyCompleted);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Task Is Fully Completed
     //
     //
     */
    [[[CompleteUncompleteObject alloc] init] TaskCompleteUncomplete_TaskIsFullyCompleted:dictToUse itemOccurrencesDict:itemOccurrencesDict keyArray:keyArray homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType topicDict:topicDict taskListDict:taskListDict allItemAssignedToArrays:allItemAssignedToArrays allItemTagsArrays:allItemTagsArrays userWhoIsBeingMarkedUserID:userWhoIsBeingMarkedUserID markingForSomeoneElse:markingForSomeoneElse TaskIsFullyCompleted:TaskIsFullyCompletedLocal currentViewController:currentViewController completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse, NSMutableDictionary *returningUpdatedTaskListDictToUse, BOOL TaskIsFullyCompleted) {
        
        TaskIsFullyCompletedLocal = TaskIsFullyCompleted;
        returningDictToUseLocal = [returningDictToUse mutableCopy];
        returningOccurrencesDictToUseLocal = [returningOccurrencesDictToUse mutableCopy];
        returningUpdatedTaskListDictToUseLocal = [returningUpdatedTaskListDictToUse mutableCopy];
        
        [[[CompleteUncompleteObject alloc] init] TaskCompleteUncomplete_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:returningDictToUseLocal itemOccurrencesDict:returningOccurrencesDictToUseLocal TaskIsFullyCompletedLocal:TaskIsFullyCompletedLocal CallNSNotificationMethods:YES completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse, BOOL TaskIsFullyCompleted) {
            
            finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse, returningUpdatedTaskListDictToUseLocal, TaskIsFullyCompleted);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Update Item Data
     //
     //
     */
    [[[CompleteUncompleteObject alloc] init] TaskCompleteUncomplete_UpdateItemData:dictToUse itemOccurrencesDict:itemOccurrencesDict homeMembersDict:homeMembersDict keyArray:keyArray completionHandler:^(BOOL finished) {
        
        [[[CompleteUncompleteObject alloc] init] TaskCompleteUncomplete_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:returningDictToUseLocal itemOccurrencesDict:returningOccurrencesDictToUseLocal TaskIsFullyCompletedLocal:TaskIsFullyCompletedLocal CallNSNotificationMethods:YES completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse, BOOL TaskIsFullyCompleted) {
            
            finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse, returningUpdatedTaskListDictToUseLocal, TaskIsFullyCompleted);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Update Algolia Data
     //
     //
     */
    [[[CompleteUncompleteObject alloc] init] TaskCompleteUncomplete_UpdateAlgoliaData:dictToUse completionHandler:^(BOOL finished) {
        
        [[[CompleteUncompleteObject alloc] init] TaskCompleteUncomplete_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:returningDictToUseLocal itemOccurrencesDict:returningOccurrencesDictToUseLocal TaskIsFullyCompletedLocal:TaskIsFullyCompletedLocal CallNSNotificationMethods:YES completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse, BOOL TaskIsFullyCompleted) {
            
            finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse, returningUpdatedTaskListDictToUseLocal, TaskIsFullyCompleted);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Update Algolia Data
     //
     //
     */
    [[[CompleteUncompleteObject alloc] init] TaskWillDoWontDo_SetItemAndHomeActivityData:dictToUse userWhoIsBeingMarkedUserID:userWhoIsBeingMarkedUserID completionHandler:^(BOOL finished) {
        
        [[[CompleteUncompleteObject alloc] init] TaskCompleteUncomplete_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:returningDictToUseLocal itemOccurrencesDict:returningOccurrencesDictToUseLocal TaskIsFullyCompletedLocal:TaskIsFullyCompletedLocal CallNSNotificationMethods:YES completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse, BOOL TaskIsFullyCompleted) {
            
            finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse, returningUpdatedTaskListDictToUseLocal, TaskIsFullyCompleted);
            
        }];
        
    }];
    
    
}

#pragma mark - Mark Subtask Complete / In Progress

-(void)SubtaskCompleteUncomplete:(NSMutableDictionary *)dictToUse itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict keyArray:(NSArray *)keyArray homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType topicDict:(NSMutableDictionary *)topicDict allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays subtaskThatIsBeingMarked:(NSString *)subtaskThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse currentViewController:(UIViewController *)currentViewController completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse))finishBlock {
    
    dictToUse = [[[CompleteUncompleteObject alloc] init] GenerateUpdatedSubtaskCompleteUncompleteDict:dictToUse subtaskThatIsBeingMarked:subtaskThatIsBeingMarked markingForSomeoneElse:markingForSomeoneElse];
    
    
    
    __block int totalQueries = 4;
    __block int completedQueries = 0;
    
    
    
    /*
     //
     //
     //Send Push Notifications
     //
     //
     */
    [[[CompleteUncompleteObject alloc] init] SubtaskCompleteUncomplete_SendPushNotifications:dictToUse homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType topicDict:topicDict allItemTagsArrays:allItemTagsArrays subtaskThatIsBeingMarked:subtaskThatIsBeingMarked markingForSomeoneElse:markingForSomeoneElse completionHandler:^(BOOL finished) {
        
        [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:dictToUse itemOccurrencesDict:itemOccurrencesDict CallNSNotificationMethods:YES completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse) {
                
                finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse);
            
        }];
        
    }];
    
   
    /*
     //
     //
     //Update Item Data
     //
     //
     */
    [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress_UpdateItemData:dictToUse completionHandler:^(BOOL finished) {
        
        [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:dictToUse itemOccurrencesDict:itemOccurrencesDict CallNSNotificationMethods:YES completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse) {
                
                finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Update Algolia Data
     //
     //
     */
    [[[CompleteUncompleteObject alloc] init] TaskCompleteUncomplete_UpdateAlgoliaData:dictToUse completionHandler:^(BOOL finished) {
        
        [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:dictToUse itemOccurrencesDict:itemOccurrencesDict CallNSNotificationMethods:YES completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse) {
                
                finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Set Item And Home Activity Data
     //
     //
     */
    [[[CompleteUncompleteObject alloc] init] SubtaskCompleteUncomplete_SetItemAndHomeActivityData:dictToUse subtaskThatIsBeingMarked:subtaskThatIsBeingMarked completionHandler:^(BOOL finished) {
        
        [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:dictToUse itemOccurrencesDict:itemOccurrencesDict CallNSNotificationMethods:YES completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse) {
                
                finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse);
            
        }];
        
    }];
    
}

-(void)SubtaskInProgressNotInProgress:(NSMutableDictionary *)dictToUse itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict keyArray:(NSArray *)keyArray homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType topicDict:(NSMutableDictionary *)topicDict allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays subtaskThatIsBeingMarked:(NSString *)subtaskThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse currentViewController:(UIViewController *)currentViewController completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse))finishBlock {
    
    dictToUse = [[[CompleteUncompleteObject alloc] init] GenerateUpdatedSubtaskInProgressNotInProgressDict:dictToUse subtaskThatIsBeingMarked:subtaskThatIsBeingMarked markingForSomeoneElse:markingForSomeoneElse];
    
    
    
    __block int totalQueries = 4;
    __block int completedQueries = 0;
    
    
    
    /*
     //
     //
     //Send Push Notification
     //
     //
     */
    [[[CompleteUncompleteObject alloc] init] SubtaskInProgressNotInProgress_SendPushNotifications:dictToUse homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType topicDict:topicDict allItemTagsArrays:allItemTagsArrays subtaskThatIsBeingMarked:subtaskThatIsBeingMarked markingForSomeoneElse:markingForSomeoneElse completionHandler:^(BOOL finished) {
        
        [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:dictToUse itemOccurrencesDict:itemOccurrencesDict CallNSNotificationMethods:YES completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse) {
                
                finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Update Item Data
     //
     //
     */
    [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress_UpdateItemData:dictToUse completionHandler:^(BOOL finished) {
        
        [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:dictToUse itemOccurrencesDict:itemOccurrencesDict CallNSNotificationMethods:YES completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse) {
                
                finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Update Algolia Data
     //
     //
     */
    [[[CompleteUncompleteObject alloc] init] TaskCompleteUncomplete_UpdateAlgoliaData:dictToUse completionHandler:^(BOOL finished) {
        
        [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:dictToUse itemOccurrencesDict:itemOccurrencesDict CallNSNotificationMethods:YES completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse) {
                
                finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Set Item and Home Activity Data
     //
     //
     */
    [[[CompleteUncompleteObject alloc] init] SubtaskInProgressNotInProgress_SetItemAndHomeActivityData:dictToUse subtaskThatIsBeingMarked:subtaskThatIsBeingMarked completionHandler:^(BOOL finished) {
        
        [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:dictToUse itemOccurrencesDict:itemOccurrencesDict CallNSNotificationMethods:YES completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse) {
                
                finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse);
            
        }];
        
    }];
    
}

-(void)SubtaskWillDoWontDo:(NSMutableDictionary *)dictToUse itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict keyArray:(NSArray *)keyArray homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType topicDict:(NSMutableDictionary *)topicDict allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays subtaskThatIsBeingMarked:(NSString *)subtaskThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse currentViewController:(UIViewController *)currentViewController completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse))finishBlock {
    
    dictToUse = [[[CompleteUncompleteObject alloc] init] GenerateUpdatedSubtaskWontDoWillDoDict:dictToUse subtaskThatIsBeingMarked:subtaskThatIsBeingMarked markingForSomeoneElse:markingForSomeoneElse];
    
    
    
    __block int totalQueries = 4;
    __block int completedQueries = 0;
    
    
    
    /*
     //
     //
     //Send Push Notification
     //
     //
     */
    [[[CompleteUncompleteObject alloc] init] SubtaskWillDoWontDo_SendPushNotifications:dictToUse homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType topicDict:topicDict allItemTagsArrays:allItemTagsArrays subtaskThatIsBeingMarked:subtaskThatIsBeingMarked markingForSomeoneElse:markingForSomeoneElse completionHandler:^(BOOL finished) {
        
        [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:dictToUse itemOccurrencesDict:itemOccurrencesDict CallNSNotificationMethods:YES completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse) {
                
                finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Update Item Data
     //
     //
     */
    [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress_UpdateItemData:dictToUse completionHandler:^(BOOL finished) {
        
        [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:dictToUse itemOccurrencesDict:itemOccurrencesDict CallNSNotificationMethods:YES completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse) {
                
                finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Update Algolia Data
     //
     //
     */
    [[[CompleteUncompleteObject alloc] init] TaskCompleteUncomplete_UpdateAlgoliaData:dictToUse completionHandler:^(BOOL finished) {
        
        [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:dictToUse itemOccurrencesDict:itemOccurrencesDict CallNSNotificationMethods:YES completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse) {
                
                finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Set Item And Home Activity Data
     //
     //
     */
    [[[CompleteUncompleteObject alloc] init] SubtaskWillDoWontDo_SetItemAndHomeActivityData:dictToUse subtaskThatIsBeingMarked:subtaskThatIsBeingMarked completionHandler:^(BOOL finished) {
        
        [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:dictToUse itemOccurrencesDict:itemOccurrencesDict CallNSNotificationMethods:YES completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse) {
                
                finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse);
            
        }];
        
    }];
    
}

#pragma mark - Mark List Item Complete / In Progress

-(void)ListItemCompleteUncomplete:(NSMutableDictionary *)dictToUse itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict keyArray:(NSArray *)keyArray homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType topicDict:(NSMutableDictionary *)topicDict taskListDict:(NSMutableDictionary *)taskListDict allItemAssignedToArrays:(NSMutableArray * _Nullable)allItemAssignedToArrays allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays listItemThatIsBeingMarked:(NSString *)listItemThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse currentViewController:(UIViewController *)currentViewController completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse, NSMutableDictionary *returningUpdatedTaskListDictToUse))finishBlock {
    
    dictToUse = [[[CompleteUncompleteObject alloc] init] GenerateUpdatedListItemCompleteUncompleteDict:dictToUse itemOccurrencesDict:itemOccurrencesDict homeMembersDict:homeMembersDict listItemThatIsBeingMarked:listItemThatIsBeingMarked markingForSomeoneElse:markingForSomeoneElse];
    
    __block NSMutableDictionary *returningDictToUseLocal = [dictToUse mutableCopy];
    __block NSMutableDictionary *returningOccurrencesDictToUseLocal = [itemOccurrencesDict mutableCopy];
    __block NSMutableDictionary *returningUpdatedTaskListDictToUseLocal = [NSMutableDictionary dictionary];
    
    
    
    __block int totalQueries = 5;
    __block int completedQueries = 0;
    
    
    
    /*
     //
     //
     //Send Push Notification
     //
     //
     */
    [[[CompleteUncompleteObject alloc] init] ListItemCompleteUncomplete_SendPushNotifications:dictToUse itemOccurrencesDict:itemOccurrencesDict keyArray:keyArray homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType topicDict:topicDict allItemTagsArrays:allItemTagsArrays listItemThatIsBeingMarked:listItemThatIsBeingMarked markingForSomeoneElse:markingForSomeoneElse currentViewController:currentViewController completionHandler:^(BOOL finished) {
        
        [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:returningDictToUseLocal itemOccurrencesDict:returningOccurrencesDictToUseLocal CallNSNotificationMethods:YES completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse) {
           
            finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse, returningUpdatedTaskListDictToUseLocal);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //List Is Fully Completed
     //
     //
     */
    [[[CompleteUncompleteObject alloc] init] ListItemCompleteUncomplete_ListItemIsFullyCompleted:dictToUse itemOccurrencesDict:itemOccurrencesDict keyArray:keyArray homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType topicDict:topicDict taskListDict:taskListDict allItemAssignedToArrays:allItemAssignedToArrays allItemTagsArrays:allItemTagsArrays listItemThatIsBeingMarked:listItemThatIsBeingMarked markingForSomeoneElse:markingForSomeoneElse currentViewController:currentViewController completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse, NSMutableDictionary *returningUpdatedTaskListDictToUse) {
        
        returningDictToUseLocal = [returningDictToUse mutableCopy];
        returningOccurrencesDictToUseLocal = [returningOccurrencesDictToUse mutableCopy];
        returningUpdatedTaskListDictToUseLocal = [returningUpdatedTaskListDictToUse mutableCopy];
        
        [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:returningDictToUseLocal itemOccurrencesDict:returningOccurrencesDictToUseLocal CallNSNotificationMethods:YES completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse) {
          
            finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse, returningUpdatedTaskListDictToUseLocal);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Update Item Data
     //
     //
     */
    [[[CompleteUncompleteObject alloc] init] ListItemCompleteUncomplete_UpdateItemData:dictToUse completionHandler:^(BOOL finished) {
        
        [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:returningDictToUseLocal itemOccurrencesDict:returningOccurrencesDictToUseLocal CallNSNotificationMethods:YES completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse) {
           
            finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse, returningUpdatedTaskListDictToUseLocal);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Update Algolia Data
     //
     //
     */
    [[[CompleteUncompleteObject alloc] init] TaskCompleteUncomplete_UpdateAlgoliaData:dictToUse completionHandler:^(BOOL finished) {
        
        [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:returningDictToUseLocal itemOccurrencesDict:returningOccurrencesDictToUseLocal CallNSNotificationMethods:YES completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse) {
           
            finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse, returningUpdatedTaskListDictToUseLocal);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Set Item And Home Activity Data
     //
     //
     */
    [[[CompleteUncompleteObject alloc] init] ListItemCompleteUncomplete_SetItemAndHomeActivityData:dictToUse listItemThatIsBeingMarked:listItemThatIsBeingMarked completionHandler:^(BOOL finished) {
        
        [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:returningDictToUseLocal itemOccurrencesDict:returningOccurrencesDictToUseLocal CallNSNotificationMethods:YES completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse) {
            
            finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse, returningUpdatedTaskListDictToUseLocal);
            
        }];
        
    }];
    
}

-(void)ListItemInProgressNotInProgress:(NSMutableDictionary *)dictToUse itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict keyArray:(NSArray *)keyArray homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType topicDict:(NSMutableDictionary *)topicDict allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays listItemThatIsBeingMarked:(NSString *)listItemThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse currentViewController:(UIViewController *)currentViewController completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse))finishBlock {
    
    dictToUse = [[[CompleteUncompleteObject alloc] init] GenerateUpdatedListItemInProgressNotInProgressDict:dictToUse listItemThatIsBeingMarked:listItemThatIsBeingMarked markingForSomeoneElse:markingForSomeoneElse];
    
    
    
    __block int totalQueries = 4;
    __block int completedQueries = 0;
    
    
    
    /*
     //
     //
     //Send Push Notification
     //
     //
     */
    [[[CompleteUncompleteObject alloc] init] ListItemInProgressNotInProgress_SendPushNotifications:dictToUse keyArray:keyArray homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType topicDict:topicDict allItemTagsArrays:allItemTagsArrays listItemThatIsBeingMarked:listItemThatIsBeingMarked markingForSomeoneElse:markingForSomeoneElse currentViewController:currentViewController completionHandler:^(BOOL finished) {
        
        [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:dictToUse itemOccurrencesDict:itemOccurrencesDict CallNSNotificationMethods:YES completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse) {
                
                finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Update Item Data
     //
     //
     */
    [[[CompleteUncompleteObject alloc] init] ListItemCompleteUncomplete_UpdateItemData:dictToUse completionHandler:^(BOOL finished) {
        
        [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:dictToUse itemOccurrencesDict:itemOccurrencesDict CallNSNotificationMethods:YES completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse) {
                
                finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Update Algolia Data
     //
     //
     */
    [[[CompleteUncompleteObject alloc] init] TaskCompleteUncomplete_UpdateAlgoliaData:dictToUse completionHandler:^(BOOL finished) {
        
        [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:dictToUse itemOccurrencesDict:itemOccurrencesDict CallNSNotificationMethods:YES completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse) {
                
                finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Set Item And Home Activity Data
     //
     //
     */
    [[[CompleteUncompleteObject alloc] init] ListItemInProgressNotInProgress_SetItemAndHomeActivityData:dictToUse listItemThatIsBeingMarked:listItemThatIsBeingMarked completionHandler:^(BOOL finished) {
        
        [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:dictToUse itemOccurrencesDict:itemOccurrencesDict CallNSNotificationMethods:YES completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse) {
                
                finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse);
            
        }];
        
    }];
    
}

-(void)ListItemWillDoWontDo:(NSMutableDictionary *)dictToUse itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict keyArray:(NSArray *)keyArray homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType topicDict:(NSMutableDictionary *)topicDict taskListDict:(NSMutableDictionary *)taskListDict allItemAssignedToArrays:(NSMutableArray * _Nullable)allItemAssignedToArrays allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays listItemThatIsBeingMarked:(NSString *)listItemThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse currentViewController:(UIViewController *)currentViewController completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse, NSMutableDictionary *returningUpdatedTaskListDictToUse))finishBlock {
    
    dictToUse = [[[CompleteUncompleteObject alloc] init] GenerateUpdatedListItemWontDoWillDoDict:dictToUse listItemThatIsBeingMarked:listItemThatIsBeingMarked markingForSomeoneElse:markingForSomeoneElse];
    
    __block NSMutableDictionary *returningDictToUseLocal = [dictToUse mutableCopy];
    __block NSMutableDictionary *returningOccurrencesDictToUseLocal = [itemOccurrencesDict mutableCopy];
    __block NSMutableDictionary *returningUpdatedTaskListDictToUseLocal = [NSMutableDictionary dictionary];
    
    
    
    __block int totalQueries = 5;
    __block int completedQueries = 0;
    
    
    
    /*
     //
     //
     //Send Push Notifications
     //
     //
     */
    [[[CompleteUncompleteObject alloc] init] ListItemWillDoWontDo_SendPushNotifications:dictToUse keyArray:keyArray homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType topicDict:topicDict allItemTagsArrays:allItemTagsArrays listItemThatIsBeingMarked:listItemThatIsBeingMarked markingForSomeoneElse:markingForSomeoneElse currentViewController:currentViewController completionHandler:^(BOOL finished) {
        
        [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:returningDictToUseLocal itemOccurrencesDict:itemOccurrencesDict CallNSNotificationMethods:YES completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse) {
            
            finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse, returningUpdatedTaskListDictToUseLocal);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //List Is Fully Completed
     //
     //
     */
    [[[CompleteUncompleteObject alloc] init] ListItemCompleteUncomplete_ListItemIsFullyCompleted:dictToUse itemOccurrencesDict:itemOccurrencesDict keyArray:keyArray homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType topicDict:topicDict taskListDict:taskListDict allItemAssignedToArrays:allItemAssignedToArrays allItemTagsArrays:allItemTagsArrays listItemThatIsBeingMarked:listItemThatIsBeingMarked markingForSomeoneElse:markingForSomeoneElse currentViewController:currentViewController completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse, NSMutableDictionary *returningUpdatedTaskListDictToUse) {
        
        returningDictToUseLocal = [returningDictToUse mutableCopy];
        returningOccurrencesDictToUseLocal = [returningOccurrencesDictToUse mutableCopy];
        returningUpdatedTaskListDictToUseLocal = [returningUpdatedTaskListDictToUse mutableCopy];
        
        [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:returningDictToUseLocal itemOccurrencesDict:itemOccurrencesDict CallNSNotificationMethods:YES completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse) {
            
            finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse, returningUpdatedTaskListDictToUseLocal);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Update Item Data
     //
     //
     */
    [[[CompleteUncompleteObject alloc] init] ListItemCompleteUncomplete_UpdateItemData:dictToUse completionHandler:^(BOOL finished) {
        
        [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:returningDictToUseLocal itemOccurrencesDict:itemOccurrencesDict CallNSNotificationMethods:YES completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse) {
            
            finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse, returningUpdatedTaskListDictToUseLocal);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Update Algolia Data
     //
     //
     */
    [[[CompleteUncompleteObject alloc] init] TaskCompleteUncomplete_UpdateAlgoliaData:dictToUse completionHandler:^(BOOL finished) {
        
        [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:returningDictToUseLocal itemOccurrencesDict:itemOccurrencesDict CallNSNotificationMethods:YES completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse) {
            
            finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse, returningUpdatedTaskListDictToUseLocal);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Set Item And Home Activity Data
     //
     //
     */
    [[[CompleteUncompleteObject alloc] init] ListItemWillDoWontDo_SetItemAndHomeActivityData:dictToUse listItemThatIsBeingMarked:listItemThatIsBeingMarked completionHandler:^(BOOL finished) {
        
        [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:returningDictToUseLocal itemOccurrencesDict:itemOccurrencesDict CallNSNotificationMethods:YES completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse) {
            
            finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse, returningUpdatedTaskListDictToUseLocal);
            
        }];
        
    }];
    
}

#pragma mark - Mark Itemized Item Complete / In Progress

-(void)ItemizedItemCompleteUncomplete:(NSMutableDictionary *)dictToUse itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict keyArray:(NSArray *)keyArray homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType topicDict:(NSMutableDictionary *)topicDict taskListDict:(NSMutableDictionary *)taskListDict allItemAssignedToArrays:(NSMutableArray * _Nullable)allItemAssignedToArrays allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays itemizedItemThatIsBeingMarked:(NSString *)itemizedItemThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse currentViewController:(UIViewController *)currentViewController completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse, NSMutableDictionary *returningUpdatedTaskListDictToUse))finishBlock {
    
    dictToUse = [[[CompleteUncompleteObject alloc] init] GenerateUpdatedItemizedItemCompleteUncompleteDict:dictToUse itemOccurrencesDict:itemOccurrencesDict homeMembersDict:homeMembersDict itemizedItemThatIsBeingMarked:itemizedItemThatIsBeingMarked markingForSomeoneElse:markingForSomeoneElse];
    
    __block NSMutableDictionary *returningDictToUseLocal = [dictToUse mutableCopy];
    __block NSMutableDictionary *returningOccurrencesDictToUseLocal = [itemOccurrencesDict mutableCopy];
    __block NSMutableDictionary *returningUpdatedTaskListDictToUseLocal = [NSMutableDictionary dictionary];
    
    
    
    __block int totalQueries = 5;
    __block int completedQueries = 0;
    
    
    
    /*
     //
     //
     //Send Push Notification
     //
     //
     */
    [[[CompleteUncompleteObject alloc] init] ItemizedItemCompleteUncomplete_SendPushNotifications:dictToUse itemOccurrencesDict:itemOccurrencesDict keyArray:keyArray homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType topicDict:topicDict allItemTagsArrays:allItemTagsArrays itemizedItemThatIsBeingMarked:itemizedItemThatIsBeingMarked markingForSomeoneElse:markingForSomeoneElse currentViewController:currentViewController completionHandler:^(BOOL finished) {
        
        [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:returningDictToUseLocal itemOccurrencesDict:returningOccurrencesDictToUseLocal CallNSNotificationMethods:YES completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse) {
            
            finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse, returningUpdatedTaskListDictToUseLocal);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Itemized Is Fully Completed
     //
     //
     */
    [[[CompleteUncompleteObject alloc] init] ItemizedItemCompleteUncomplete_ItemizedItemIsFullyCompleted:dictToUse itemOccurrencesDict:itemOccurrencesDict keyArray:keyArray homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType topicDict:topicDict taskListDict:taskListDict allItemAssignedToArrays:allItemAssignedToArrays allItemTagsArrays:allItemTagsArrays itemizedItemThatIsBeingMarked:itemizedItemThatIsBeingMarked  markingForSomeoneElse:markingForSomeoneElse currentViewController:currentViewController completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningDictToUse, NSMutableDictionary * _Nonnull returningOccurrencesDictToUse, NSMutableDictionary * _Nonnull returningUpdatedTaskListDictToUse) {
        
        returningDictToUseLocal = [returningDictToUse mutableCopy];
        returningOccurrencesDictToUseLocal = [returningOccurrencesDictToUse mutableCopy];
        returningUpdatedTaskListDictToUseLocal = [returningUpdatedTaskListDictToUse mutableCopy];
        
        [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:returningDictToUseLocal itemOccurrencesDict:returningOccurrencesDictToUseLocal CallNSNotificationMethods:YES completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse) {
            
            finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse, returningUpdatedTaskListDictToUseLocal);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Update Item Data
     //
     //
     */
    [[[CompleteUncompleteObject alloc] init] ItemizedItemCompleteUncomplete_UpdateItemData:dictToUse completionHandler:^(BOOL finished) {
        
        [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:returningDictToUseLocal itemOccurrencesDict:returningOccurrencesDictToUseLocal CallNSNotificationMethods:YES completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse) {
            
            finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse, returningUpdatedTaskListDictToUseLocal);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Update Algolia Data
     //
     //
     */
    [[[CompleteUncompleteObject alloc] init] TaskCompleteUncomplete_UpdateAlgoliaData:dictToUse completionHandler:^(BOOL finished) {
        
        [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:returningDictToUseLocal itemOccurrencesDict:returningOccurrencesDictToUseLocal CallNSNotificationMethods:YES completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse) {
            
            finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse, returningUpdatedTaskListDictToUseLocal);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Set Item And Home Activity Data
     //
     //
     */
    [[[CompleteUncompleteObject alloc] init] ItemizedItemCompleteUncomplete_SetItemAndHomeActivityData:dictToUse itemizedItemThatIsBeingMarked:itemizedItemThatIsBeingMarked completionHandler:^(BOOL finished) {
        
        [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:returningDictToUseLocal itemOccurrencesDict:returningOccurrencesDictToUseLocal CallNSNotificationMethods:YES completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse) {
            
            finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse, returningUpdatedTaskListDictToUseLocal);
            
        }];
        
    }];
    
}

-(void)ItemizedItemInProgressNotInProgress:(NSMutableDictionary *)dictToUse itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict keyArray:(NSArray *)keyArray homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType topicDict:(NSMutableDictionary *)topicDict allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays  itemizedItemThatIsBeingMarked:(NSString *)itemizedItemThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse currentViewController:(UIViewController *)currentViewController completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse))finishBlock {
    
    dictToUse = [[[CompleteUncompleteObject alloc] init] GenerateUpdatedItemizedItemInProgressNotInProgressDict:dictToUse itemizedItemThatIsBeingMarked:itemizedItemThatIsBeingMarked markingForSomeoneElse:markingForSomeoneElse];
    
    
    
    __block int totalQueries = 4;
    __block int completedQueries = 0;
    
    
    
    /*
     //
     //
     //Send Push Notifications
     //
     //
     */
    [[[CompleteUncompleteObject alloc] init] ItemizedItemInProgressNotInProgress_SendPushNotifications:dictToUse keyArray:keyArray homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType topicDict:topicDict allItemTagsArrays:allItemTagsArrays itemizedItemThatIsBeingMarked:itemizedItemThatIsBeingMarked markingForSomeoneElse:markingForSomeoneElse currentViewController:currentViewController completionHandler:^(BOOL finished) {
        
        [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:dictToUse itemOccurrencesDict:itemOccurrencesDict CallNSNotificationMethods:YES completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse) {
                
                finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Update Item Data
     //
     //
     */
    [[[CompleteUncompleteObject alloc] init] ItemizedItemCompleteUncomplete_UpdateItemData:dictToUse completionHandler:^(BOOL finished) {
        
        [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:dictToUse itemOccurrencesDict:itemOccurrencesDict CallNSNotificationMethods:YES completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse) {
                
                finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Update Algolia Data
     //
     //
     */
    [[[CompleteUncompleteObject alloc] init] TaskCompleteUncomplete_UpdateAlgoliaData:dictToUse completionHandler:^(BOOL finished) {
        
        [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:dictToUse itemOccurrencesDict:itemOccurrencesDict CallNSNotificationMethods:YES completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse) {
                
                finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Set Item And Home Activity Data
     //
     //
     */
    [[[CompleteUncompleteObject alloc] init] ItemizedItemInProgressNotInProgress_SetItemAndHomeActivityData:dictToUse itemizedItemThatIsBeingMarked:itemizedItemThatIsBeingMarked completionHandler:^(BOOL finished) {
        
        [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:dictToUse itemOccurrencesDict:itemOccurrencesDict CallNSNotificationMethods:YES completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse) {
                
                finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse);
            
        }];
        
    }];
    
}

-(void)ItemizedItemWillDoWontDo:(NSMutableDictionary *)dictToUse itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict keyArray:(NSArray *)keyArray homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType topicDict:(NSMutableDictionary *)topicDict taskListDict:(NSMutableDictionary *)taskListDict allItemAssignedToArrays:(NSMutableArray * _Nullable)allItemAssignedToArrays allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays  itemizedItemThatIsBeingMarked:(NSString *)itemizedItemThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse currentViewController:(UIViewController *)currentViewController completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse, NSMutableDictionary *returningUpdatedTaskListDictToUse))finishBlock {
    
    dictToUse = [[[CompleteUncompleteObject alloc] init] GenerateUpdatedItemizedItemWontDoWillDoDict:dictToUse itemizedItemThatIsBeingMarked:itemizedItemThatIsBeingMarked markingForSomeoneElse:markingForSomeoneElse];
    
    __block NSMutableDictionary *returningDictToUseLocal = [dictToUse mutableCopy];
    __block NSMutableDictionary *returningOccurrencesDictToUseLocal = [itemOccurrencesDict mutableCopy];
    __block NSMutableDictionary *returningUpdatedTaskListDictToUseLocal = [NSMutableDictionary dictionary];
    
    
    
    __block int totalQueries = 5;
    __block int completedQueries = 0;
    
    
    
    /*
     //
     //
     //Send Push Notifications
     //
     //
     */
    [[[CompleteUncompleteObject alloc] init] ItemizedItemWillDoWontDo_SendPushNotifications:dictToUse keyArray:keyArray homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType topicDict:topicDict allItemTagsArrays:allItemTagsArrays itemizedItemThatIsBeingMarked:itemizedItemThatIsBeingMarked markingForSomeoneElse:markingForSomeoneElse currentViewController:currentViewController completionHandler:^(BOOL finished) {
        
        [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:returningDictToUseLocal itemOccurrencesDict:returningOccurrencesDictToUseLocal CallNSNotificationMethods:YES completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse) {
            
            finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse, returningUpdatedTaskListDictToUseLocal);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Itemized Is Fully Completed
     //
     //
     */
    [[[CompleteUncompleteObject alloc] init] ItemizedItemCompleteUncomplete_ItemizedItemIsFullyCompleted:dictToUse itemOccurrencesDict:itemOccurrencesDict keyArray:keyArray homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType topicDict:topicDict taskListDict:taskListDict allItemAssignedToArrays:allItemAssignedToArrays allItemTagsArrays:allItemTagsArrays itemizedItemThatIsBeingMarked:itemizedItemThatIsBeingMarked  markingForSomeoneElse:markingForSomeoneElse currentViewController:currentViewController completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningDictToUse, NSMutableDictionary * _Nonnull returningOccurrencesDictToUse, NSMutableDictionary * _Nonnull returningUpdatedTaskListDictToUse) {
        
        returningDictToUseLocal = [returningDictToUse mutableCopy];
        returningOccurrencesDictToUseLocal = [returningOccurrencesDictToUse mutableCopy];
        returningUpdatedTaskListDictToUseLocal = [returningUpdatedTaskListDictToUse mutableCopy];
        
        [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:returningDictToUseLocal itemOccurrencesDict:returningOccurrencesDictToUseLocal CallNSNotificationMethods:YES completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse) {
            
            finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse, returningUpdatedTaskListDictToUseLocal);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Update Item Data
     //
     //
     */
    [[[CompleteUncompleteObject alloc] init] ItemizedItemCompleteUncomplete_UpdateItemData:dictToUse completionHandler:^(BOOL finished) {
      
        [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:returningDictToUseLocal itemOccurrencesDict:returningOccurrencesDictToUseLocal CallNSNotificationMethods:YES completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse) {
            
            finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse, returningUpdatedTaskListDictToUseLocal);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Update Algolia Data
     //
     //
     */
    [[[CompleteUncompleteObject alloc] init] TaskCompleteUncomplete_UpdateAlgoliaData:dictToUse completionHandler:^(BOOL finished) {
    
        [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:returningDictToUseLocal itemOccurrencesDict:returningOccurrencesDictToUseLocal CallNSNotificationMethods:YES completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse) {
            
            finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse, returningUpdatedTaskListDictToUseLocal);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Set Item And Home Activity Data
     //
     //
     */
    [[[CompleteUncompleteObject alloc] init] ItemizedItemWillDoWontDo_SetItemAndHomeActivityData:dictToUse itemizedItemThatIsBeingMarked:itemizedItemThatIsBeingMarked completionHandler:^(BOOL finished) {
        
        [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:returningDictToUseLocal itemOccurrencesDict:returningOccurrencesDictToUseLocal CallNSNotificationMethods:YES completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse) {
            
            finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse, returningUpdatedTaskListDictToUseLocal);
            
        }];
        
    }];
    
}

#pragma mark
#pragma mark
#pragma mark
#pragma mark
#pragma mark
#pragma mark - Update Task Dict

-(NSMutableDictionary *)GenerateUpdatedTaskCompleteUncompleteDict:(NSMutableDictionary *)dictToUse itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict homeMembersDict:(NSMutableDictionary *)homeMembersDict userWhoIsBeingMarkedUserID:(NSString *)userWhoIsBeingMarkedUserID markingForSomeoneElse:(BOOL)markingForSomeoneElse {
    
    NSString *itemType = [[[GeneralObject alloc] init] GenerateItemType];
    
    BOOL TaskIsCompleteAsNeeded = [[[BoolDataObject alloc] init] TaskIsCompleteAsNeeded:dictToUse itemType:itemType];
    BOOL TaskIsTakingTurns = [[[BoolDataObject alloc] init] TaskIsTakingTurns:dictToUse itemType:itemType];
    BOOL TaskIsRequestApproval = [[[BoolDataObject alloc] init] TaskIsRequestApproval:dictToUse itemType:itemType];
    
    NSMutableDictionary *itemCompletedDict = dictToUse[@"ItemCompletedDict"] ? [dictToUse[@"ItemCompletedDict"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemInProgressDict = dictToUse[@"ItemInProgressDict"] ? [dictToUse[@"ItemInProgressDict"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemWontDoDict = dictToUse[@"ItemWontDo"] ? [dictToUse[@"ItemWontDo"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemApprovalRequests  = dictToUse[@"ItemApprovalRequests"] ? [dictToUse[@"ItemApprovalRequests"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableArray *itemAssignedTo = dictToUse[@"ItemAssignedTo"] ? [dictToUse[@"ItemAssignedTo"] mutableCopy] : [NSMutableArray array];
    NSString *itemTurnUserID = dictToUse[@"ItemTurnUserID"] ? dictToUse[@"ItemTurnUserID"] : @"";
    NSString *itemTakeTurns = dictToUse[@"ItemTakeTurns"] ? dictToUse[@"ItemTakeTurns"] : @"";
    
    BOOL TaskHasAlreadyBeenCompleted = [[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemCompletedDict userIDToFind:userWhoIsBeingMarkedUserID];
    
    
    
    if (TaskHasAlreadyBeenCompleted == YES && TaskIsCompleteAsNeeded == NO) {
        
        [itemCompletedDict removeObjectForKey:userWhoIsBeingMarkedUserID];
        
        [dictToUse setObject:itemCompletedDict forKey:@"ItemCompletedDict"];
        
    } else {
        
        
        
        NSString *keyToUse = [[[CompleteUncompleteObject alloc] init] GenerateCompleteAsNeededKey:dictToUse objectBeingMarked:userWhoIsBeingMarkedUserID itemType:itemType];
    
        [itemCompletedDict setObject:[[[CompleteUncompleteObject alloc] init] GenerateCompletedDict:userWhoIsBeingMarkedUserID markingForSomeoneElse:markingForSomeoneElse] forKey:keyToUse];
        
        
        if ([[itemInProgressDict allKeys] containsObject:userWhoIsBeingMarkedUserID]) {
            
            [itemInProgressDict removeObjectForKey:userWhoIsBeingMarkedUserID];
            
        }
        
        
        if ([[itemWontDoDict allKeys] containsObject:userWhoIsBeingMarkedUserID]) {
            
            [itemWontDoDict removeObjectForKey:userWhoIsBeingMarkedUserID];
            
        }
        
        
        if (TaskIsRequestApproval == YES) {
            
            if (itemApprovalRequests[userWhoIsBeingMarkedUserID]) {
                
                [itemApprovalRequests removeObjectForKey:userWhoIsBeingMarkedUserID];
                
            }
            
        }
        
        
        
        [dictToUse setObject:itemCompletedDict forKey:@"ItemCompletedDict"];
        [dictToUse setObject:itemInProgressDict forKey:@"ItemInProgressDict"];
        [dictToUse setObject:itemWontDoDict forKey:@"ItemWontDo"];
        [dictToUse setObject:itemApprovalRequests forKey:@"ItemApprovalRequests"];

        
        
        BOOL TimeToAlternateTurns = [[[BoolDataObject alloc] init] TimeToAlternateTurns:dictToUse itemOccurrencesDict:itemOccurrencesDict itemType:itemType keyArray:[dictToUse allKeys] homeMembersDict:homeMembersDict];
        
        if (TaskIsCompleteAsNeeded == YES && TaskIsTakingTurns == YES && TimeToAlternateTurns == YES) {
            
            itemTurnUserID = [[[GeneralObject alloc] init] GenerateNextUsersTurn:itemAssignedTo itemAssignedToOriginal:itemAssignedTo homeMembersDict:homeMembersDict itemTakeTurns:itemTakeTurns itemTurnUserID:itemTurnUserID];
         
        }
        
        [dictToUse setObject:itemTurnUserID forKey:@"ItemTurnUserID"];
        
    }
    
    return dictToUse;
}

-(NSMutableDictionary *)GenerateUpdatedTaskInProgressNotInProgressDict:(NSMutableDictionary *)dictToUse userWhoIsBeingMarkedUserID:(NSString *)userWhoIsBeingMarkedUserID markingForSomeoneElse:(BOOL)markingForSomeoneElse {
    
    NSString *itemType = [[[GeneralObject alloc] init] GenerateItemType];
    BOOL TaskIsCompleteAsNeeded = [[[BoolDataObject alloc] init] TaskIsCompleteAsNeeded:dictToUse itemType:itemType];
    BOOL TaskIsRequestApproval = [[[BoolDataObject alloc] init] TaskIsRequestApproval:dictToUse itemType:itemType];
    
    NSMutableDictionary *itemCompletedDict = dictToUse[@"ItemCompletedDict"] ? [dictToUse[@"ItemCompletedDict"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemInProgressDict = dictToUse[@"ItemInProgressDict"] ? [dictToUse[@"ItemInProgressDict"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemWontDoDict = dictToUse[@"ItemWontDo"] ? [dictToUse[@"ItemWontDo"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemApprovalRequests  = dictToUse[@"ItemApprovalRequests"] ? [dictToUse[@"ItemApprovalRequests"] mutableCopy] : [NSMutableDictionary dictionary];
    
    BOOL TaskHasAlreadyBeenMarkedInProgress = [[itemInProgressDict allKeys] containsObject:userWhoIsBeingMarkedUserID];
    
    if (TaskHasAlreadyBeenMarkedInProgress == YES) {
        
        if ([[itemInProgressDict allKeys] containsObject:userWhoIsBeingMarkedUserID]) {
            
            [itemInProgressDict removeObjectForKey:userWhoIsBeingMarkedUserID];
            
        }
        
    } else {
        
        if (TaskIsRequestApproval == YES) {
            
            if (itemApprovalRequests[userWhoIsBeingMarkedUserID]) {
                
                [itemApprovalRequests removeObjectForKey:userWhoIsBeingMarkedUserID];
                
            }
            
        }
        
        if (userWhoIsBeingMarkedUserID == nil || userWhoIsBeingMarkedUserID == NULL || [userWhoIsBeingMarkedUserID length] == 0) {
            userWhoIsBeingMarkedUserID = @"UnknownKey";
        }
        
        [itemInProgressDict setObject:[[[CompleteUncompleteObject alloc] init] GenerateCompletedDict:userWhoIsBeingMarkedUserID markingForSomeoneElse:markingForSomeoneElse] forKey:userWhoIsBeingMarkedUserID];
        
        if ([[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemCompletedDict userIDToFind:userWhoIsBeingMarkedUserID] && TaskIsCompleteAsNeeded == NO) {
            
            [itemCompletedDict removeObjectForKey:userWhoIsBeingMarkedUserID];
            
        }
        
        if ([[itemWontDoDict allKeys] containsObject:userWhoIsBeingMarkedUserID]) {
            
            [itemWontDoDict removeObjectForKey:userWhoIsBeingMarkedUserID];
            
        }
        
    }
    
    [dictToUse setObject:itemCompletedDict forKey:@"ItemCompletedDict"];
    [dictToUse setObject:itemInProgressDict forKey:@"ItemInProgressDict"];
    [dictToUse setObject:itemWontDoDict forKey:@"ItemWontDo"];
    [dictToUse setObject:itemApprovalRequests forKey:@"ItemApprovalRequests"];
    
    return dictToUse;
}

-(NSMutableDictionary *)GenerateUpdatedTaskWontDoWillDoDict:(NSMutableDictionary *)dictToUse userWhoIsBeingMarkedUserID:(NSString *)userWhoIsBeingMarkedUserID markingForSomeoneElse:(BOOL)markingForSomeoneElse {
    
    NSString *itemType = [[[GeneralObject alloc] init] GenerateItemType];
    BOOL TaskIsCompleteAsNeeded = [[[BoolDataObject alloc] init] TaskIsCompleteAsNeeded:dictToUse itemType:itemType];
    
    NSMutableDictionary *itemCompletedDict = dictToUse[@"ItemCompletedDict"] ? [dictToUse[@"ItemCompletedDict"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemInProgressDict = dictToUse[@"ItemInProgressDict"] ? [dictToUse[@"ItemInProgressDict"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemWontDoDict = dictToUse[@"ItemWontDo"] ? [dictToUse[@"ItemWontDo"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemApprovalRequests = dictToUse[@"ItemApprovalRequests"] ? [dictToUse[@"ItemApprovalRequests"] mutableCopy] : [NSMutableDictionary dictionary];
    
    BOOL TaskHasAlreadyBeenMarkedWontDo = [[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemWontDoDict userIDToFind:userWhoIsBeingMarkedUserID];
    
    
    
    if (TaskHasAlreadyBeenMarkedWontDo == YES && TaskIsCompleteAsNeeded == NO) {
        
        [itemWontDoDict removeObjectForKey:userWhoIsBeingMarkedUserID];
        
    } else {
        
        
        
        NSString *keyToUse = [[[CompleteUncompleteObject alloc] init] GenerateCompleteAsNeededKey:dictToUse objectBeingMarked:userWhoIsBeingMarkedUserID itemType:itemType];
        
        [itemWontDoDict setObject:[[[CompleteUncompleteObject alloc] init] GenerateCompletedDict:userWhoIsBeingMarkedUserID markingForSomeoneElse:markingForSomeoneElse] forKey:keyToUse];
        
        if ([[itemCompletedDict allKeys] containsObject:userWhoIsBeingMarkedUserID]) {
            
            [itemCompletedDict removeObjectForKey:userWhoIsBeingMarkedUserID];
            
        }
        
        if ([[itemInProgressDict allKeys] containsObject:userWhoIsBeingMarkedUserID]) {
            
            [itemInProgressDict removeObjectForKey:userWhoIsBeingMarkedUserID];
            
        }
        
        if ([[itemApprovalRequests allKeys] containsObject:userWhoIsBeingMarkedUserID]) {
            
            [itemApprovalRequests removeObjectForKey:userWhoIsBeingMarkedUserID];
            
        }
        
    }
    
    
    
    [dictToUse setObject:itemCompletedDict forKey:@"ItemCompletedDict"];
    [dictToUse setObject:itemInProgressDict forKey:@"ItemInProgressDict"];
    [dictToUse setObject:itemWontDoDict forKey:@"ItemWontDo"];
    [dictToUse setObject:itemApprovalRequests forKey:@"ItemApprovalRequests"];
    
    return dictToUse;
}

#pragma mark - Update Subtasks Dict

-(NSMutableDictionary *)GenerateUpdatedSubtaskCompleteUncompleteDict:(NSMutableDictionary *)dictToUse subtaskThatIsBeingMarked:(NSString *)subtaskThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse {
    
    NSString *itemType = [[[GeneralObject alloc] init] GenerateItemType];
    BOOL TaskIsCompleteAsNeeded = [[[BoolDataObject alloc] init] TaskIsCompleteAsNeeded:dictToUse itemType:itemType];
    
    NSMutableDictionary *itemSubTasksDict = dictToUse[@"ItemSubTasks"] ? [dictToUse[@"ItemSubTasks"] mutableCopy] : [NSMutableDictionary dictionary];
    
    NSMutableDictionary *subtaskCompletedDict = itemSubTasksDict[subtaskThatIsBeingMarked] && itemSubTasksDict[subtaskThatIsBeingMarked][@"Completed Dict"] ?
    [itemSubTasksDict[subtaskThatIsBeingMarked][@"Completed Dict"] mutableCopy] : [NSMutableDictionary dictionary];
   
    NSMutableDictionary *subtaskInProgressDict = itemSubTasksDict[subtaskThatIsBeingMarked] && itemSubTasksDict[subtaskThatIsBeingMarked][@"In Progress Dict"] ?
    [itemSubTasksDict[subtaskThatIsBeingMarked][@"In Progress Dict"] mutableCopy] : [NSMutableDictionary dictionary];
    
    NSMutableDictionary *subtaskWontDoDict = itemSubTasksDict[subtaskThatIsBeingMarked] && itemSubTasksDict[subtaskThatIsBeingMarked][@"Wont Do"] ?
    [itemSubTasksDict[subtaskThatIsBeingMarked][@"Wont Do"] mutableCopy] : [NSMutableDictionary dictionary];
    
    NSString *userWhoIsBeingMarkedUserID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
    
    if (([[subtaskCompletedDict allKeys] count] > 0) && TaskIsCompleteAsNeeded == NO) {
        
        [subtaskCompletedDict removeObjectForKey:userWhoIsBeingMarkedUserID];
   
    } else {
        
        NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"UnknownKey";
        
        NSString *keyToUse = [[[CompleteUncompleteObject alloc] init] GenerateCompleteAsNeededSubTaskKey:dictToUse subtaskThatIsBeingMarked:subtaskThatIsBeingMarked userIDKey:userID itemType:itemType];
        
        [subtaskCompletedDict setObject:[[[CompleteUncompleteObject alloc] init] GenerateCompletedDict:userWhoIsBeingMarkedUserID markingForSomeoneElse:markingForSomeoneElse] forKey:keyToUse];
      
        if ([[subtaskInProgressDict allKeys] count] > 0) {
            
            subtaskInProgressDict = [NSMutableDictionary dictionary];
            
        }
        
        if ([[subtaskWontDoDict allKeys] count] > 0) {
            
            subtaskWontDoDict = [NSMutableDictionary dictionary];
            
        }
        
    }
    
    if (subtaskThatIsBeingMarked == nil || subtaskThatIsBeingMarked == NULL || [subtaskThatIsBeingMarked length] == 0) {
        subtaskThatIsBeingMarked = @"UnknownKey";
    }
    
    NSMutableDictionary *tempDict = [itemSubTasksDict[subtaskThatIsBeingMarked] mutableCopy];
    tempDict[@"Wont Do"] ? [tempDict setObject:subtaskWontDoDict forKey:@"Wont Do"] : [tempDict setObject:[NSMutableDictionary dictionary] forKey:@"Wont Do"];
    itemSubTasksDict[subtaskThatIsBeingMarked] = [tempDict mutableCopy];
    
    tempDict = itemSubTasksDict[subtaskThatIsBeingMarked] ? [itemSubTasksDict[subtaskThatIsBeingMarked] mutableCopy] : [NSMutableDictionary dictionary];
    [tempDict setObject:subtaskInProgressDict forKey:@"In Progress Dict"];
    [itemSubTasksDict setObject:tempDict forKey:subtaskThatIsBeingMarked];
    
    tempDict = itemSubTasksDict[subtaskThatIsBeingMarked] ? [itemSubTasksDict[subtaskThatIsBeingMarked] mutableCopy] : [NSMutableDictionary dictionary];
    [tempDict setObject:subtaskCompletedDict forKey:@"Completed Dict"];
    [itemSubTasksDict setObject:tempDict forKey:subtaskThatIsBeingMarked];
   
    [dictToUse setObject:itemSubTasksDict forKey:@"ItemSubTasks"];
  
    return dictToUse;
}

-(NSMutableDictionary *)GenerateUpdatedSubtaskInProgressNotInProgressDict:(NSMutableDictionary *)dictToUse subtaskThatIsBeingMarked:(NSString *)subtaskThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse {
    
    NSString *itemType = [[[GeneralObject alloc] init] GenerateItemType];
    BOOL TaskIsCompleteAsNeeded = [[[BoolDataObject alloc] init] TaskIsCompleteAsNeeded:dictToUse itemType:itemType];
    
    NSMutableDictionary *itemSubTasksDict = dictToUse[@"ItemSubTasks"] ? [dictToUse[@"ItemSubTasks"] mutableCopy] : [NSMutableDictionary dictionary];
    
    NSMutableDictionary *subtaskCompletedDict = itemSubTasksDict[subtaskThatIsBeingMarked] && itemSubTasksDict[subtaskThatIsBeingMarked][@"Completed Dict"] ?
    [itemSubTasksDict[subtaskThatIsBeingMarked][@"Completed Dict"] mutableCopy] : [NSMutableDictionary dictionary];
    
    NSMutableDictionary *subtaskInProgressDict = itemSubTasksDict[subtaskThatIsBeingMarked] && itemSubTasksDict[subtaskThatIsBeingMarked][@"In Progress Dict"] ?
    [itemSubTasksDict[subtaskThatIsBeingMarked][@"In Progress Dict"] mutableCopy] : [NSMutableDictionary dictionary];
    
    NSMutableDictionary *subtaskWontDoDict = itemSubTasksDict[subtaskThatIsBeingMarked] && itemSubTasksDict[subtaskThatIsBeingMarked][@"Wont Do"] ?
    [itemSubTasksDict[subtaskThatIsBeingMarked][@"Wont Do"] mutableCopy] : [NSMutableDictionary dictionary];
    
    NSString *userWhoIsBeingMarkedUserID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
    
    if ([[subtaskInProgressDict allKeys] count] > 0) {
        
        subtaskInProgressDict = [NSMutableDictionary dictionary];
        
    } else {
        
        NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"UnknownKey";
        
        [subtaskInProgressDict setObject:[[[CompleteUncompleteObject alloc] init] GenerateCompletedDict:userWhoIsBeingMarkedUserID markingForSomeoneElse:markingForSomeoneElse] forKey:userID];
        
        if ([[subtaskCompletedDict allKeys] count] > 0 && TaskIsCompleteAsNeeded == NO) {
            
            if ([[subtaskCompletedDict allKeys] count] > 0) {
                
                subtaskCompletedDict = [NSMutableDictionary dictionary];
                
            }
            
        }
        
        if ([[subtaskWontDoDict allKeys] count] > 0) {
            
            subtaskWontDoDict = [NSMutableDictionary dictionary];
            
        }
        
    }
    
    if (subtaskThatIsBeingMarked == nil || subtaskThatIsBeingMarked == NULL || [subtaskThatIsBeingMarked length] == 0) {
        subtaskThatIsBeingMarked = @"UnknownKey";
    }
    
    NSMutableDictionary *tempDict = [itemSubTasksDict[subtaskThatIsBeingMarked] mutableCopy];
    tempDict[@"Wont Do"] ? [tempDict setObject:subtaskWontDoDict forKey:@"Wont Do"] : [tempDict setObject:[NSMutableDictionary dictionary] forKey:@"Wont Do"];
    itemSubTasksDict[subtaskThatIsBeingMarked] = [tempDict mutableCopy];
    
    tempDict = itemSubTasksDict[subtaskThatIsBeingMarked] ? [itemSubTasksDict[subtaskThatIsBeingMarked] mutableCopy] : [NSMutableDictionary dictionary];
    [tempDict setObject:subtaskInProgressDict forKey:@"In Progress Dict"];
    [itemSubTasksDict setObject:tempDict forKey:subtaskThatIsBeingMarked];
    
    tempDict = itemSubTasksDict[subtaskThatIsBeingMarked] ? [itemSubTasksDict[subtaskThatIsBeingMarked] mutableCopy] : [NSMutableDictionary dictionary];
    [tempDict setObject:subtaskCompletedDict forKey:@"Completed Dict"];
    [itemSubTasksDict setObject:tempDict forKey:subtaskThatIsBeingMarked];
    
    [dictToUse setObject:itemSubTasksDict forKey:@"ItemSubTasks"];
    
    return dictToUse;
}

-(NSMutableDictionary *)GenerateUpdatedSubtaskWontDoWillDoDict:(NSMutableDictionary *)dictToUse subtaskThatIsBeingMarked:(NSString *)subtaskThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse {
    
    NSString *itemType = [[[GeneralObject alloc] init] GenerateItemType];
    BOOL TaskIsCompleteAsNeeded = [[[BoolDataObject alloc] init] TaskIsCompleteAsNeeded:dictToUse itemType:itemType];
    
    NSMutableDictionary *itemSubTasksDict = dictToUse[@"ItemSubTasks"] ? [dictToUse[@"ItemSubTasks"] mutableCopy] : [NSMutableDictionary dictionary];
    
    NSMutableDictionary *subtaskCompletedDict = itemSubTasksDict[subtaskThatIsBeingMarked] && itemSubTasksDict[subtaskThatIsBeingMarked][@"Completed Dict"] ?
    [itemSubTasksDict[subtaskThatIsBeingMarked][@"Completed Dict"] mutableCopy] : [NSMutableDictionary dictionary];
    
    NSMutableDictionary *subtaskInProgressDict = itemSubTasksDict[subtaskThatIsBeingMarked] && itemSubTasksDict[subtaskThatIsBeingMarked][@"In Progress Dict"] ?
    [itemSubTasksDict[subtaskThatIsBeingMarked][@"In Progress Dict"] mutableCopy] : [NSMutableDictionary dictionary];
    
    NSMutableDictionary *subtaskWontDoDict = itemSubTasksDict[subtaskThatIsBeingMarked] && itemSubTasksDict[subtaskThatIsBeingMarked][@"Wont Do"] ?
    [itemSubTasksDict[subtaskThatIsBeingMarked][@"Wont Do"] mutableCopy] : [NSMutableDictionary dictionary];
    
    if (([[subtaskWontDoDict allKeys] count] > 0) && TaskIsCompleteAsNeeded == NO) {
        
        if ([[subtaskWontDoDict allKeys] count] > 0) {
            
            subtaskWontDoDict = [NSMutableDictionary dictionary];
            
        }
        
    } else {
        
        NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"UnknownKey";
        
        [subtaskWontDoDict setObject:[[[CompleteUncompleteObject alloc] init] GenerateCompletedDict:subtaskThatIsBeingMarked markingForSomeoneElse:markingForSomeoneElse] forKey:userID];
        
        if ([[subtaskCompletedDict allKeys] count] > 0) {
            
            subtaskCompletedDict = [NSMutableDictionary dictionary];
            
        }
        
        if ([[subtaskInProgressDict allKeys] count] > 0) {
            
            subtaskInProgressDict = [NSMutableDictionary dictionary];
            
        }
        
    }
    
    if (subtaskThatIsBeingMarked == nil || subtaskThatIsBeingMarked == NULL || [subtaskThatIsBeingMarked length] == 0) {
        subtaskThatIsBeingMarked = @"UnknownKey";
    }
    
    NSMutableDictionary *tempDict = [itemSubTasksDict[subtaskThatIsBeingMarked] mutableCopy];
    tempDict[@"Wont Do"] ? [tempDict setObject:subtaskWontDoDict forKey:@"Wont Do"] : [tempDict setObject:[NSMutableDictionary dictionary] forKey:@"Wont Do"];
    itemSubTasksDict[subtaskThatIsBeingMarked] = [tempDict mutableCopy];
    
    tempDict = itemSubTasksDict[subtaskThatIsBeingMarked] ? [itemSubTasksDict[subtaskThatIsBeingMarked] mutableCopy] : [NSMutableDictionary dictionary];
    [tempDict setObject:subtaskInProgressDict forKey:@"In Progress Dict"];
    [itemSubTasksDict setObject:tempDict forKey:subtaskThatIsBeingMarked];
    
    tempDict = itemSubTasksDict[subtaskThatIsBeingMarked] ? [itemSubTasksDict[subtaskThatIsBeingMarked] mutableCopy] : [NSMutableDictionary dictionary];
    [tempDict setObject:subtaskCompletedDict forKey:@"Completed Dict"];
    [itemSubTasksDict setObject:tempDict forKey:subtaskThatIsBeingMarked];
    
    [dictToUse setObject:itemSubTasksDict forKey:@"ItemSubTasks"];
    
    return dictToUse;
}

#pragma mark - Updated List Items Dict

-(NSMutableDictionary *)GenerateUpdatedListItemCompleteUncompleteDict:(NSMutableDictionary *)dictToUse itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict homeMembersDict:(NSMutableDictionary *)homeMembersDict listItemThatIsBeingMarked:(NSString *)listItemThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse {
    
    NSString *itemType = [[[GeneralObject alloc] init] GenerateItemType];
    BOOL TaskIsCompleteAsNeeded = [[[BoolDataObject alloc] init] TaskIsCompleteAsNeeded:dictToUse itemType:itemType];
    BOOL TaskIsTakingTurns = [[[BoolDataObject alloc] init] TaskIsTakingTurns:dictToUse itemType:itemType];
    BOOL TaskIsFullyCompleted = [[[BoolDataObject alloc] init] TaskIsFullyCompleted:dictToUse itemType:itemType homeMembersDict:homeMembersDict];
    
    NSMutableDictionary *itemCompletedDict = dictToUse[@"ItemCompletedDict"] ? [dictToUse[@"ItemCompletedDict"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemInProgressDict = dictToUse[@"ItemInProgressDict"] ? [dictToUse[@"ItemInProgressDict"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemWontDoDict = dictToUse[@"ItemWontDo"] ? [dictToUse[@"ItemWontDo"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemListItems = dictToUse[@"ItemListItems"] ? [dictToUse[@"ItemListItems"] mutableCopy] : [NSMutableDictionary dictionary];
    NSString *userWhoIsBeingMarkedUserID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
    NSMutableArray *itemAssignedTo = dictToUse[@"ItemAssignedTo"] ? [dictToUse[@"ItemAssignedTo"] mutableCopy] : [NSMutableArray array];
    NSString *itemTurnUserID = dictToUse[@"ItemTurnUserID"] ? dictToUse[@"ItemTurnUserID"] : @"";
    NSString *itemTakeTurns = dictToUse[@"ItemTakeTurns"] ? dictToUse[@"ItemTakeTurns"] : @"";
    
    if ([[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemCompletedDict userIDToFind:listItemThatIsBeingMarked] && TaskIsCompleteAsNeeded == NO) {
        
        [itemCompletedDict removeObjectForKey:listItemThatIsBeingMarked];
      
        [dictToUse setObject:itemCompletedDict forKey:@"ItemCompletedDict"];
        
    } else {
        
        
        
        NSString *keyToUse = [[[CompleteUncompleteObject alloc] init] GenerateCompleteAsNeededKey:dictToUse objectBeingMarked:listItemThatIsBeingMarked itemType:itemType];
       
        [itemCompletedDict setObject:[[[CompleteUncompleteObject alloc] init] GenerateCompletedDict:userWhoIsBeingMarkedUserID markingForSomeoneElse:markingForSomeoneElse] forKey:keyToUse];
       
        if ([[itemInProgressDict allKeys] containsObject:listItemThatIsBeingMarked]) {
            
            [itemInProgressDict removeObjectForKey:listItemThatIsBeingMarked];
            
        }
        
        if ([[itemWontDoDict allKeys] containsObject:listItemThatIsBeingMarked]) {
            
            [itemWontDoDict removeObjectForKey:listItemThatIsBeingMarked];
            
        }
        
        
        
        [dictToUse setObject:itemCompletedDict forKey:@"ItemCompletedDict"];
        [dictToUse setObject:itemInProgressDict forKey:@"ItemInProgressDict"];
        [dictToUse setObject:itemWontDoDict forKey:@"ItemWontDo"];
        
        
        
        BOOL TimeToAlternateTurns = [[[BoolDataObject alloc] init] TimeToAlternateTurns:dictToUse itemOccurrencesDict:itemOccurrencesDict itemType:itemType keyArray:[dictToUse allKeys] homeMembersDict:homeMembersDict];
        
        if (TaskIsCompleteAsNeeded == YES && TaskIsTakingTurns == YES && TaskIsFullyCompleted == YES && TimeToAlternateTurns == YES) {
            
            itemTurnUserID = [[[GeneralObject alloc] init] GenerateNextUsersTurn:itemAssignedTo itemAssignedToOriginal:itemAssignedTo homeMembersDict:homeMembersDict itemTakeTurns:itemTakeTurns itemTurnUserID:itemTurnUserID];
            
        }
        
        [dictToUse setObject:itemTurnUserID forKey:@"ItemTurnUserID"];
        
    }
    
    
    BOOL ListItemHasBeenMarkedCompleted =  [[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemCompletedDict userIDToFind:listItemThatIsBeingMarked];
    BOOL ListItemHasBeenMarkedInProgress =  [[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemInProgressDict userIDToFind:listItemThatIsBeingMarked];
    BOOL ListItemHasBeenMarkedWontDo =  [[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemWontDoDict userIDToFind:listItemThatIsBeingMarked];
    BOOL ListItemIsBeenUncompleted = (ListItemHasBeenMarkedCompleted == NO && ListItemHasBeenMarkedInProgress == NO && ListItemHasBeenMarkedWontDo == NO);
    
    if (listItemThatIsBeingMarked == nil || listItemThatIsBeingMarked == NULL || [listItemThatIsBeingMarked length] == 0) {
        listItemThatIsBeingMarked = @"UnknownKey";
    }
    
    NSMutableDictionary *tempDict = itemListItems[listItemThatIsBeingMarked] ? [itemListItems[listItemThatIsBeingMarked] mutableCopy] : [NSMutableDictionary dictionary];
    [tempDict setObject:ListItemIsBeenUncompleted == YES ? @"Uncompleted" : [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] forKey:@"Status"];
    [itemListItems setObject:[tempDict mutableCopy] forKey:listItemThatIsBeingMarked];
    
    [dictToUse setObject:itemListItems forKey:@"ItemListItems"];
    
    return dictToUse;
}

-(NSMutableDictionary *)GenerateUpdatedListItemInProgressNotInProgressDict:(NSMutableDictionary *)dictToUse listItemThatIsBeingMarked:(NSString *)listItemThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse {
    
    NSString *itemType = [[[GeneralObject alloc] init] GenerateItemType];
    BOOL TaskIsCompleteAsNeeded = [[[BoolDataObject alloc] init] TaskIsCompleteAsNeeded:dictToUse itemType:itemType];
    
    NSMutableDictionary *itemCompletedDict = dictToUse[@"ItemCompletedDict"] ? [dictToUse[@"ItemCompletedDict"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemInProgressDict = dictToUse[@"ItemInProgressDict"] ? [dictToUse[@"ItemInProgressDict"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemWontDoDict = dictToUse[@"ItemWontDo"] ? [dictToUse[@"ItemWontDo"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemListItems = dictToUse[@"ItemListItems"] ? [dictToUse[@"ItemListItems"] mutableCopy] : [NSMutableDictionary dictionary];
    NSString *userWhoIsBeingMarkedUserID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
    
    if (listItemThatIsBeingMarked == nil || listItemThatIsBeingMarked == NULL || [listItemThatIsBeingMarked length] == 0) {
        listItemThatIsBeingMarked = @"UnknownKey";
    }
    
    if ([[itemInProgressDict allKeys] containsObject:listItemThatIsBeingMarked]) {
        
        [itemInProgressDict removeObjectForKey:listItemThatIsBeingMarked];
        
    } else {
        
        [itemInProgressDict setObject:[[[CompleteUncompleteObject alloc] init] GenerateCompletedDict:userWhoIsBeingMarkedUserID markingForSomeoneElse:markingForSomeoneElse] forKey:listItemThatIsBeingMarked];
        
        if ([[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemCompletedDict userIDToFind:listItemThatIsBeingMarked] && TaskIsCompleteAsNeeded == NO) {
            
            [itemCompletedDict removeObjectForKey:listItemThatIsBeingMarked];
            
        }
        
        if ([[itemWontDoDict allKeys] containsObject:listItemThatIsBeingMarked]) {
            
            [itemWontDoDict removeObjectForKey:listItemThatIsBeingMarked];
            
        }
        
    }
    
    BOOL ListItemHasBeenMarkedCompleted =  [[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemCompletedDict userIDToFind:listItemThatIsBeingMarked];
    BOOL ListItemHasBeenMarkedInProgress =  [[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemInProgressDict userIDToFind:listItemThatIsBeingMarked];
    BOOL ListItemIsBeenUncompleted = (ListItemHasBeenMarkedCompleted == NO && ListItemHasBeenMarkedInProgress == NO);
    
    NSMutableDictionary *tempDict = itemListItems && itemListItems[listItemThatIsBeingMarked] ? [itemListItems[listItemThatIsBeingMarked] mutableCopy] : [NSMutableDictionary dictionary];
    [tempDict setObject:ListItemIsBeenUncompleted == YES ? @"Uncompleted" : [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] forKey:@"Status"];
    [itemListItems setObject:tempDict ? [tempDict mutableCopy] : [NSMutableDictionary dictionary] forKey:listItemThatIsBeingMarked];
    
    [dictToUse setObject:itemCompletedDict ? itemCompletedDict : [NSMutableDictionary dictionary] forKey:@"ItemCompletedDict"];
    [dictToUse setObject:itemInProgressDict ? itemInProgressDict : [NSMutableDictionary dictionary] forKey:@"ItemInProgressDict"];
    [dictToUse setObject:itemWontDoDict ? itemWontDoDict : [NSMutableDictionary dictionary] forKey:@"ItemWontDo"];
    [dictToUse setObject:itemListItems ? itemListItems : [NSMutableDictionary dictionary] forKey:@"ItemListItems"];
    
    return dictToUse;
}

-(NSMutableDictionary *)GenerateUpdatedListItemWontDoWillDoDict:(NSMutableDictionary *)dictToUse listItemThatIsBeingMarked:(NSString *)listItemThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse {
    
    NSString *itemType = [[[GeneralObject alloc] init] GenerateItemType];
    BOOL TaskIsCompleteAsNeeded = [[[BoolDataObject alloc] init] TaskIsCompleteAsNeeded:dictToUse itemType:itemType];
    
    NSMutableDictionary *itemCompletedDict = dictToUse[@"ItemCompletedDict"] ? [dictToUse[@"ItemCompletedDict"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemInProgressDict = dictToUse[@"ItemInProgressDict"] ? [dictToUse[@"ItemInProgressDict"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemWontDoDict = dictToUse[@"ItemWontDo"] ? [dictToUse[@"ItemWontDo"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemListItems = dictToUse[@"ItemListItems"] ? [dictToUse[@"ItemListItems"] mutableCopy] : [NSMutableDictionary dictionary];
    NSString *userWhoIsBeingMarkedUserID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
    
    if (listItemThatIsBeingMarked == nil || listItemThatIsBeingMarked == NULL || [listItemThatIsBeingMarked length] == 0) {
        listItemThatIsBeingMarked = @"UnknownKey";
    }
    
    if ([[itemWontDoDict allKeys] containsObject:listItemThatIsBeingMarked]) {
        
        if ([[itemWontDoDict allKeys] containsObject:listItemThatIsBeingMarked]) {
            
            [itemWontDoDict removeObjectForKey:listItemThatIsBeingMarked];
            
        }
        
    } else {
        
        [itemWontDoDict setObject:[[[CompleteUncompleteObject alloc] init] GenerateCompletedDict:userWhoIsBeingMarkedUserID markingForSomeoneElse:markingForSomeoneElse] forKey:listItemThatIsBeingMarked];
        
        if ([[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemCompletedDict userIDToFind:listItemThatIsBeingMarked] && TaskIsCompleteAsNeeded == NO) {
            
            [itemCompletedDict removeObjectForKey:listItemThatIsBeingMarked];
            
        }
        
        if ([[itemInProgressDict allKeys] containsObject:listItemThatIsBeingMarked]) {
            
            [itemInProgressDict removeObjectForKey:listItemThatIsBeingMarked];
            
        }
        
    }
    
    BOOL ListItemHasBeenMarkedCompleted =  [[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemCompletedDict userIDToFind:listItemThatIsBeingMarked];
    BOOL ListItemHasBeenMarkedInProgress =  [[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemInProgressDict userIDToFind:listItemThatIsBeingMarked];
    BOOL ListItemHasBeenMarkedWontDo =  [[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemWontDoDict userIDToFind:listItemThatIsBeingMarked];
    BOOL ListItemIsBeenUncompleted = (ListItemHasBeenMarkedCompleted == NO && ListItemHasBeenMarkedInProgress == NO && ListItemHasBeenMarkedWontDo == NO);
    
    NSMutableDictionary *tempDict = itemListItems[listItemThatIsBeingMarked] ? [itemListItems[listItemThatIsBeingMarked] mutableCopy] : [NSMutableDictionary dictionary];
    [tempDict setObject:ListItemIsBeenUncompleted == YES ? @"Uncompleted" : [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] forKey:@"Status"];
    [itemListItems setObject:[tempDict mutableCopy] forKey:listItemThatIsBeingMarked];
    
    [dictToUse setObject:itemCompletedDict forKey:@"ItemCompletedDict"];
    [dictToUse setObject:itemInProgressDict forKey:@"ItemInProgressDict"];
    [dictToUse setObject:itemWontDoDict forKey:@"ItemWontDo"];
    [dictToUse setObject:itemListItems forKey:@"ItemListItems"];
    
    return dictToUse;
}

#pragma mark - Update Itemized Items Dict

-(NSMutableDictionary *)GenerateUpdatedItemizedItemCompleteUncompleteDict:(NSMutableDictionary *)dictToUse itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict homeMembersDict:(NSMutableDictionary *)homeMembersDict itemizedItemThatIsBeingMarked:(NSString *)itemizedItemThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse {
    
    NSString *itemType = [[[GeneralObject alloc] init] GenerateItemType];
    BOOL TaskIsCompleteAsNeeded = [[[BoolDataObject alloc] init] TaskIsCompleteAsNeeded:dictToUse itemType:itemType];
    BOOL TaskIsTakingTurns = [[[BoolDataObject alloc] init] TaskIsTakingTurns:dictToUse itemType:itemType];
    BOOL TaskIsFullyCompleted = [[[BoolDataObject alloc] init] TaskIsFullyCompleted:dictToUse itemType:itemType homeMembersDict:homeMembersDict];
    
    NSMutableDictionary *itemCompletedDict = dictToUse[@"ItemCompletedDict"] ? [dictToUse[@"ItemCompletedDict"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemInProgressDict = dictToUse[@"ItemInProgressDict"] ? [dictToUse[@"ItemInProgressDict"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemWontDoDict = dictToUse[@"ItemWontDo"] ? [dictToUse[@"ItemWontDo"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemItemizedItems = dictToUse[@"ItemItemizedItems"] ? [dictToUse[@"ItemItemizedItems"] mutableCopy] : [NSMutableDictionary dictionary];
    NSString *userWhoIsBeingMarkedUserID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
    NSMutableArray *itemAssignedTo = dictToUse[@"ItemAssignedTo"] ? [dictToUse[@"ItemAssignedTo"] mutableCopy] : [NSMutableArray array];
    NSString *itemTurnUserID = dictToUse[@"ItemTurnUserID"] ? dictToUse[@"ItemTurnUserID"] : @"";
    NSString *itemTakeTurns = dictToUse[@"ItemTakeTurns"] ? dictToUse[@"ItemTakeTurns"] : @"";
    
    if ([[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemCompletedDict userIDToFind:itemizedItemThatIsBeingMarked] && TaskIsCompleteAsNeeded == NO) {
        
        [itemCompletedDict removeObjectForKey:itemizedItemThatIsBeingMarked];
        
        [dictToUse setObject:itemCompletedDict forKey:@"ItemCompletedDict"];
        
    } else {
        
        
        
        NSString *keyToUse = [[[CompleteUncompleteObject alloc] init] GenerateCompleteAsNeededKey:dictToUse objectBeingMarked:itemizedItemThatIsBeingMarked itemType:itemType];
        
        [itemCompletedDict setObject:[[[CompleteUncompleteObject alloc] init] GenerateCompletedDict:userWhoIsBeingMarkedUserID markingForSomeoneElse:markingForSomeoneElse] forKey:keyToUse];
        
        if ([[itemInProgressDict allKeys] containsObject:itemizedItemThatIsBeingMarked]) {
            
            [itemInProgressDict removeObjectForKey:itemizedItemThatIsBeingMarked];
            
        }
        
        if ([[itemWontDoDict allKeys] containsObject:itemizedItemThatIsBeingMarked]) {
            
            [itemWontDoDict removeObjectForKey:itemizedItemThatIsBeingMarked];
            
        }
        
        
        
        [dictToUse setObject:itemCompletedDict forKey:@"ItemCompletedDict"];
        [dictToUse setObject:itemInProgressDict forKey:@"ItemInProgressDict"];
        [dictToUse setObject:itemWontDoDict forKey:@"ItemWontDo"];
        
        
        
        BOOL TimeToAlternateTurns = [[[BoolDataObject alloc] init] TimeToAlternateTurns:dictToUse itemOccurrencesDict:itemOccurrencesDict itemType:itemType keyArray:[dictToUse allKeys] homeMembersDict:homeMembersDict];
        
        if (TaskIsCompleteAsNeeded == YES && TaskIsTakingTurns == YES && TaskIsFullyCompleted == YES && TimeToAlternateTurns == YES) {
            
            itemTurnUserID = [[[GeneralObject alloc] init] GenerateNextUsersTurn:itemAssignedTo itemAssignedToOriginal:itemAssignedTo homeMembersDict:homeMembersDict itemTakeTurns:itemTakeTurns itemTurnUserID:itemTurnUserID];
            
        }
        
        [dictToUse setObject:itemTurnUserID forKey:@"ItemTurnUserID"];
        
    }
    
    
    BOOL ItemizedItemHasBeenMarkedCompleted =  [[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemCompletedDict userIDToFind:itemizedItemThatIsBeingMarked];
    BOOL ItemizedItemHasBeenMarkedInProgress =  [[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemInProgressDict userIDToFind:itemizedItemThatIsBeingMarked];
    BOOL ItemizedItemHasBeenMarkedWontDo =  [[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemWontDoDict userIDToFind:itemizedItemThatIsBeingMarked];
    BOOL ItemizedItemIsBeenUncompleted = (ItemizedItemHasBeenMarkedCompleted == NO && ItemizedItemHasBeenMarkedInProgress == NO && ItemizedItemHasBeenMarkedWontDo == NO);
    
    NSMutableDictionary *tempDict = itemItemizedItems[itemizedItemThatIsBeingMarked] ? [itemItemizedItems[itemizedItemThatIsBeingMarked] mutableCopy] : [NSMutableDictionary dictionary];
    [tempDict setObject:ItemizedItemIsBeenUncompleted == YES ? @"Uncompleted" : [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] forKey:@"Status"];
    [itemItemizedItems setObject:[tempDict mutableCopy] forKey:itemizedItemThatIsBeingMarked];

    [dictToUse setObject:itemItemizedItems forKey:@"ItemItemizedItems"];
    
    return dictToUse;
}

-(NSMutableDictionary *)GenerateUpdatedItemizedItemInProgressNotInProgressDict:(NSMutableDictionary *)dictToUse itemizedItemThatIsBeingMarked:(NSString *)itemizedItemThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse {
    
    NSString *itemType = [[[GeneralObject alloc] init] GenerateItemType];
    BOOL TaskIsCompleteAsNeeded = [[[BoolDataObject alloc] init] TaskIsCompleteAsNeeded:dictToUse itemType:itemType];
    
    NSMutableDictionary *itemCompletedDict = dictToUse[@"ItemCompletedDict"] ? [dictToUse[@"ItemCompletedDict"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemInProgressDict = dictToUse[@"ItemInProgressDict"] ? [dictToUse[@"ItemInProgressDict"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemWontDoDict = dictToUse[@"ItemWontDo"] ? [dictToUse[@"ItemWontDo"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemItemizedItems = dictToUse[@"ItemItemizedItems"] ? [dictToUse[@"ItemItemizedItems"] mutableCopy] : [NSMutableDictionary dictionary];
    NSString *userWhoIsBeingMarkedUserID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
    
    if (userWhoIsBeingMarkedUserID == nil || userWhoIsBeingMarkedUserID == NULL || [userWhoIsBeingMarkedUserID length] == 0) {
        userWhoIsBeingMarkedUserID = @"UnknownKey";
    }
    
    if (itemizedItemThatIsBeingMarked == nil || itemizedItemThatIsBeingMarked == NULL || [itemizedItemThatIsBeingMarked length] == 0) {
        itemizedItemThatIsBeingMarked = @"UnknownKey";
    }
    
    if ([[itemInProgressDict allKeys] containsObject:itemizedItemThatIsBeingMarked]) {
        
        if ([[itemInProgressDict allKeys] containsObject:itemizedItemThatIsBeingMarked]) {
            
            [itemInProgressDict removeObjectForKey:itemizedItemThatIsBeingMarked];
            
        }
        
    } else {
        
        [itemInProgressDict setObject:[[[CompleteUncompleteObject alloc] init] GenerateCompletedDict:userWhoIsBeingMarkedUserID markingForSomeoneElse:markingForSomeoneElse] forKey:itemizedItemThatIsBeingMarked];
        
        if ([[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemCompletedDict userIDToFind:itemizedItemThatIsBeingMarked] && TaskIsCompleteAsNeeded == NO) {
            
            [itemCompletedDict removeObjectForKey:itemizedItemThatIsBeingMarked];
            
        }
        
        if ([[itemWontDoDict allKeys] containsObject:itemizedItemThatIsBeingMarked]) {
            
            [itemWontDoDict removeObjectForKey:itemizedItemThatIsBeingMarked];
            
        }
        
    }
    
    BOOL ItemizedItemHasBeenMarkedCompleted =  [[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemCompletedDict userIDToFind:itemizedItemThatIsBeingMarked];
    BOOL ItemizedItemHasBeenMarkedInProgress =  [[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemInProgressDict userIDToFind:itemizedItemThatIsBeingMarked];
    BOOL ItemizedItemHasBeenMarkedWontDo =  [[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemWontDoDict userIDToFind:itemizedItemThatIsBeingMarked];
    BOOL ItemizedItemIsBeenUncompleted = (ItemizedItemHasBeenMarkedCompleted == NO && ItemizedItemHasBeenMarkedInProgress == NO && ItemizedItemHasBeenMarkedWontDo == NO);
    
    NSMutableDictionary *tempDict = itemItemizedItems[itemizedItemThatIsBeingMarked] ? [itemItemizedItems[itemizedItemThatIsBeingMarked] mutableCopy] : [NSMutableDictionary dictionary];
    [tempDict setObject:ItemizedItemIsBeenUncompleted == YES ? @"Uncompleted" : [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] forKey:@"Status"];
    [itemItemizedItems setObject:[tempDict mutableCopy] forKey:itemizedItemThatIsBeingMarked];
    
    [dictToUse setObject:itemCompletedDict forKey:@"ItemCompletedDict"];
    [dictToUse setObject:itemInProgressDict forKey:@"ItemInProgressDict"];
    [dictToUse setObject:itemWontDoDict forKey:@"ItemWontDo"];
    [dictToUse setObject:itemItemizedItems forKey:@"ItemItemizedItems"];
    
    return dictToUse;
}

-(NSMutableDictionary *)GenerateUpdatedItemizedItemWontDoWillDoDict:(NSMutableDictionary *)dictToUse itemizedItemThatIsBeingMarked:(NSString *)itemizedItemThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse {
    
    NSString *itemType = [[[GeneralObject alloc] init] GenerateItemType];
    BOOL TaskIsCompleteAsNeeded = [[[BoolDataObject alloc] init] TaskIsCompleteAsNeeded:dictToUse itemType:itemType];
    
    NSMutableDictionary *itemCompletedDict = dictToUse[@"ItemCompletedDict"] ? [dictToUse[@"ItemCompletedDict"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemInProgressDict = dictToUse[@"ItemInProgressDict"] ? [dictToUse[@"ItemInProgressDict"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemWontDoDict = dictToUse[@"ItemWontDo"] ? [dictToUse[@"ItemWontDo"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemItemizedItems = dictToUse[@"ItemItemizedItems"] ? [dictToUse[@"ItemItemizedItems"] mutableCopy] : [NSMutableDictionary dictionary];
    NSString *userWhoIsBeingMarkedUserID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
    
    if (userWhoIsBeingMarkedUserID == nil || userWhoIsBeingMarkedUserID == NULL || [userWhoIsBeingMarkedUserID length] == 0) {
        userWhoIsBeingMarkedUserID = @"UnknownKey";
    }
    
    if (itemizedItemThatIsBeingMarked == nil || itemizedItemThatIsBeingMarked == NULL || [itemizedItemThatIsBeingMarked length] == 0) {
        itemizedItemThatIsBeingMarked = @"UnknownKey";
    }
    
    if ([[itemWontDoDict allKeys] containsObject:itemizedItemThatIsBeingMarked]) {
        
        [itemWontDoDict removeObjectForKey:itemizedItemThatIsBeingMarked];
        
    } else {
        
        [itemWontDoDict setObject:[[[CompleteUncompleteObject alloc] init] GenerateCompletedDict:userWhoIsBeingMarkedUserID markingForSomeoneElse:markingForSomeoneElse] forKey:itemizedItemThatIsBeingMarked];
        
        if ([[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemCompletedDict userIDToFind:itemizedItemThatIsBeingMarked] && TaskIsCompleteAsNeeded == NO) {
            
            [itemCompletedDict removeObjectForKey:itemizedItemThatIsBeingMarked];
            
        }
        
        if ([[itemInProgressDict allKeys] containsObject:itemizedItemThatIsBeingMarked]) {
            
            [itemInProgressDict removeObjectForKey:itemizedItemThatIsBeingMarked];
            
        }
        
    }
    
    BOOL ItemizedItemHasBeenMarkedCompleted =  [[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemCompletedDict userIDToFind:itemizedItemThatIsBeingMarked];
    BOOL ItemizedItemHasBeenMarkedInProgress =  [[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemInProgressDict userIDToFind:itemizedItemThatIsBeingMarked];
    BOOL ItemizedItemHasBeenMarkedWontDo =  [[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemWontDoDict userIDToFind:itemizedItemThatIsBeingMarked];
    BOOL ItemizedItemIsBeenUncompleted = (ItemizedItemHasBeenMarkedCompleted == NO && ItemizedItemHasBeenMarkedInProgress == NO && ItemizedItemHasBeenMarkedWontDo == NO);
    
    NSMutableDictionary *tempDict = itemItemizedItems[itemizedItemThatIsBeingMarked] ? [itemItemizedItems[itemizedItemThatIsBeingMarked] mutableCopy] : [NSMutableDictionary dictionary];
    [tempDict setObject:ItemizedItemIsBeenUncompleted == YES ? @"Uncompleted" : [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] forKey:@"Status"];
    [itemItemizedItems setObject:[tempDict mutableCopy] forKey:itemizedItemThatIsBeingMarked];
    
    [dictToUse setObject:itemCompletedDict forKey:@"ItemCompletedDict"];
    [dictToUse setObject:itemInProgressDict forKey:@"ItemInProgressDict"];
    [dictToUse setObject:itemWontDoDict forKey:@"ItemWontDo"];
    [dictToUse setObject:itemItemizedItems forKey:@"ItemItemizedItems"];
    
    return dictToUse;
}

#pragma mark
#pragma mark
#pragma mark
#pragma mark
#pragma mark
#pragma mark - Notification Text

#pragma mark Tasks

-(NSMutableDictionary *)GenerateTaskFullCompletedNotificationText:(NSMutableDictionary *)dictToUse userWhoIsBeingMarkedUserID:(NSString *)userWhoIsBeingMarkedUserID homeMembersDict:(NSMutableDictionary *)homeMembersDict {
    
    NSMutableDictionary *notificationText = [NSMutableDictionary dictionary];
    
    
    
    NSString *itemName = dictToUse[@"ItemName"] ? dictToUse[@"ItemName"] : @"";
    NSMutableArray *itemAssignedTo = dictToUse[@"ItemAssignedTo"] ? [dictToUse[@"ItemAssignedTo"] mutableCopy] : [NSMutableArray array];
    NSMutableDictionary *itemWontDo = dictToUse[@"ItemWontDo"] ? [dictToUse[@"ItemWontDo"] mutableCopy] : [NSMutableDictionary dictionary];
    
    NSString *notificationTitle = [NSString stringWithFormat:@"\"%@\"", itemName];
    NSString *notificationBody = @"";
    
    NSString *itemType = [[[GeneralObject alloc] init] GenerateItemType];
    
    BOOL TaskIsFullyCompletedButNotByEveryone = [[[BoolDataObject alloc] init] TaskIsFullyCompletedButNotByEveryone:dictToUse itemType:itemType homeMembersDict:homeMembersDict];
    BOOL TaskIsBeingCompleted = [[[CompleteUncompleteObject alloc] init] GenerateTaskIsBeingMarkedCompleted:dictToUse userWhoIsBeingMarkedUserID:userWhoIsBeingMarkedUserID];
    BOOL TaskIsTakingTurns = [[[BoolDataObject alloc] init] TaskIsTakingTurns:dictToUse itemType:itemType];
    BOOL TaskIsPartiallyCompleted = TaskIsTakingTurns == NO && [[itemWontDo allKeys] count] > 0 ? YES : NO;
    BOOL TaskIsWontDo = NO;
    
    if ((TaskIsTakingTurns && [[itemWontDo allKeys] count] > 0) ||
        (TaskIsTakingTurns == NO && [[itemWontDo allKeys] count] >= [itemAssignedTo count])) {
        TaskIsWontDo = YES;
    }
    
    NSString *completedOrUncompleted = TaskIsBeingCompleted == YES ? @"Complete" : @"Uncomplete";
    
    
    
    //🎉 This task has been completed by philip! 🎉
    if (TaskIsBeingCompleted == YES && TaskIsFullyCompletedButNotByEveryone == NO && TaskIsPartiallyCompleted == NO && TaskIsWontDo == NO) {
        
        notificationBody = [NSString stringWithFormat:@"🎊 This %@ has been %@d by everyone! 🎊",
                            [itemType lowercaseString],
                            [completedOrUncompleted lowercaseString]];
        
    } else if (TaskIsBeingCompleted == YES && TaskIsPartiallyCompleted == NO && TaskIsWontDo == NO) {
        
        notificationBody = [NSString stringWithFormat:@"🎊 This %@ has been %@d! 🎊",
                            [itemType lowercaseString],
                            [completedOrUncompleted lowercaseString]];
        
    } else if (TaskIsPartiallyCompleted == YES && TaskIsWontDo == NO) {
        
        notificationBody = [NSString stringWithFormat:@"🎊 This %@ has been partially completed! 🎊",
                            [itemType lowercaseString]];
        
    } else if (TaskIsWontDo == YES) {
        
        notificationBody = [NSString stringWithFormat:@"This %@ won't be completed! 😢",
                            [itemType lowercaseString]];
        
    }
    
    
    
    [notificationText setObject:notificationTitle forKey:@"Title"];
    [notificationText setObject:notificationBody forKey:@"Body"];
    
    return notificationText;
    
}

-(NSMutableDictionary *)GenerateCompletedNotificationText:(NSMutableDictionary *)dictToUse keyArray:(NSArray *)keyArray homeMembersDict:(NSMutableDictionary *)homeMembersDict userWhoIsBeingMarkedUserID:(NSString *)userWhoIsBeingMarkedUserID markingForSomeoneElse:(BOOL)markingForSomeoneElse {
    
    NSMutableDictionary *notificationText = [NSMutableDictionary dictionary];
    
    
    
    NSString *itemName = dictToUse[@"ItemName"] ? dictToUse[@"ItemName"] : @"";
    
    NSString *notificationTitle = [NSString stringWithFormat:@"\"%@\"", itemName];
    
    BOOL TaskIsMarkedForSomeoneElse = [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"][@"CompletedFor"];
    NSString *markedString = TaskIsMarkedForSomeoneElse == YES && [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"] && [[[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"][@"CompletedForSomeoneElse"] isEqualToString:@"Yes"] == NO ? @"marked " : @"";
   
    
    //This chore is being worked on by philip! ⏳
    BOOL TaskIsBeingMarkedCompleted = [[[CompleteUncompleteObject alloc] init] GenerateTaskIsBeingMarkedCompleted:dictToUse userWhoIsBeingMarkedUserID:userWhoIsBeingMarkedUserID];
    NSString *bodyEmojiStringBefore = TaskIsBeingMarkedCompleted == YES ? @"🎉" : @"";
    NSString *bodyEmojiStringAfter = TaskIsBeingMarkedCompleted == YES ? @"! 🎉" : @". 😢";
    NSString *bodyString = TaskIsBeingMarkedCompleted == YES ? [NSString stringWithFormat:@"has been %@completed by", markedString] : [NSString stringWithFormat:@"has been %@uncompleted by", markedString];
    NSString *bodyStringSomeoneElse = markingForSomeoneElse && TaskIsMarkedForSomeoneElse == YES ? [NSString stringWithFormat:@" for %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"][@"CompletedFor"]] : @"";
    NSString *bodyStringNextUsersTurn = @"";
    
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"] : @"";
    
    if (markingForSomeoneElse && [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"][@"CompletedBy"]) {
        
        username = [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"][@"CompletedBy"];
        
    } else {
        
        NSDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:userWhoIsBeingMarkedUserID homeMembersDict:homeMembersDict];
        username = dataDict[@"Username"] ? dataDict[@"Username"] : username;
        
    }
    
    //---🎉--- This ---chore--- ---has been completed by--- ---philip--- --- for john1--- ---. It is jack's turn next--- ---! 🎉---
    NSString *notificationBody = @"";
    
    notificationBody = [NSString stringWithFormat:@"%@ This %@ %@ %@%@%@%@",
                        bodyEmojiStringBefore,
                        [[[[GeneralObject alloc] init] GenerateItemType] lowercaseString],
                        bodyString,
                        username,
                        bodyStringSomeoneElse,
                        bodyStringNextUsersTurn,
                        bodyEmojiStringAfter];
    
    [notificationText setObject:notificationTitle forKey:@"Title"];
    [notificationText setObject:notificationBody forKey:@"Body"];
    
    return notificationText;
}

-(NSMutableDictionary *)GenerateInProgressNotificationText:(NSMutableDictionary *)dictToUse userWhoIsBeingMarkedUserID:(NSString *)userWhoIsBeingMarkedUserID markingForSomeoneElse:(BOOL)markingForSomeoneElse {
    
    NSMutableDictionary *notificationText = [NSMutableDictionary dictionary];
    
    
    
    NSString *itemName = dictToUse[@"ItemName"] ? dictToUse[@"ItemName"] : @"";
    
    NSString *notificationTitle = [NSString stringWithFormat:@"\"%@\"", itemName];
    
    
    BOOL TaskIsInProgress = [[[CompleteUncompleteObject alloc] init] GenerateTaskIsBeingMarkedInProgress:dictToUse userWhoIsBeingMarkedUserID:userWhoIsBeingMarkedUserID];
    NSString *bodyEmojiStringAfter = TaskIsInProgress == YES ? @"! ⏳" : @". 😢";
    NSString *bodyString = TaskIsInProgress == YES ? @"is being worked on by" : @"is no longer being worked on by";
    NSString *bodyExtraString = markingForSomeoneElse && [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"][@"CompletedFor"] ? [NSString stringWithFormat:@" for %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"][@"CompletedFor"]] : @"";
    
    //This chore is being worked on by philip! ⏳
    NSString *notificationBody = [NSString stringWithFormat:@"This %@ %@ %@%@%@",
                                  [[[[GeneralObject alloc] init] GenerateItemType] lowercaseString],
                                  bodyString,
                                  [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"] : @"",
                                  bodyExtraString,
                                  bodyEmojiStringAfter];
    
    
    
    [notificationText setObject:notificationTitle forKey:@"Title"];
    [notificationText setObject:notificationBody forKey:@"Body"];
    
    return notificationText;
}

-(NSMutableDictionary *)GenerateWillDoNotificationText:(NSMutableDictionary *)dictToUse userWhoIsBeingMarkedUserID:(NSString *)userWhoIsBeingMarkedUserID markingForSomeoneElse:(BOOL)markingForSomeoneElse {
    
    NSMutableDictionary *notificationText = [NSMutableDictionary dictionary];
    
    
    
    NSString *itemName = dictToUse[@"ItemName"] ? dictToUse[@"ItemName"] : @"";
    
    NSString *notificationTitle = [NSString stringWithFormat:@"\"%@\"", itemName];
    
    
    BOOL TaskIsWontDo = [[[CompleteUncompleteObject alloc] init] GenerateTaskIsBeingMarkedWontDo:dictToUse userWhoIsBeingMarkedUserID:userWhoIsBeingMarkedUserID];
    NSString *bodyEmojiStringAfter = TaskIsWontDo == YES ? @". 😢" : @"! ⏳";
    NSString *bodyString = TaskIsWontDo == YES ? @"will not be done by" : @"will be done by";
    NSString *bodyExtraString = markingForSomeoneElse && [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"][@"CompletedFor"] ? [NSString stringWithFormat:@" for %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"][@"CompletedFor"]] : @"";
    
    //This chore is being worked on by philip! ⏳
    NSString *notificationBody = [NSString stringWithFormat:@"This %@ %@ %@%@%@",
                                  [[[[GeneralObject alloc] init] GenerateItemType] lowercaseString],
                                  bodyString,
                                  [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"] : @"",
                                  bodyExtraString,
                                  bodyEmojiStringAfter];
    
    
    
    [notificationText setObject:notificationTitle forKey:@"Title"];
    [notificationText setObject:notificationBody forKey:@"Body"];
    
    return notificationText;
}

-(NSMutableDictionary *)GenerateCreateAcceptDeclineNotificationText:(NSMutableDictionary *)dictToUse homeMembersDict:(NSMutableDictionary *)homeMembersDict userWhoIsBeingMarkedUserID:(NSString *)userWhoIsBeingMarkedUserID {
    
    NSMutableDictionary *notificationText = [NSMutableDictionary dictionary];
    
    
    
    NSString *itemName = dictToUse[@"ItemName"] ? dictToUse[@"ItemName"] : @"";
    NSString *itemCreatedBy = dictToUse[@"ItemCreatedBy"] ? dictToUse[@"ItemCreatedBy"] : @"";
    
    NSString *notificationTitle = [NSString stringWithFormat:@"\"%@\"", itemName];
    
    
    
    //🎉 This task has been completed by philip! 🎉
    NSString *notificationBody = @"";
    
    NSDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:userWhoIsBeingMarkedUserID homeMembersDict:homeMembersDict];
    NSString *userID = dataDict[@"UserID"];
    
    NSString *usernameWhoIsBeingMarkedUserID = userID;
    
    NSString *itemType = [[[GeneralObject alloc] init] GenerateItemType];
    
    BOOL TaskApprovalRequestAcceptedBySpecificUser = [[[BoolDataObject alloc] init] TaskApprovalRequestAcceptedBySpecificUser:dictToUse itemType:itemType userID:userWhoIsBeingMarkedUserID];
    BOOL TaskApprovalRequestPendingBySpecificUser = [[[BoolDataObject alloc] init] TaskApprovalRequestPendingBySpecificUser:dictToUse itemType:itemType userID:userWhoIsBeingMarkedUserID];
    
    NSString *bodyEmojiStringBefore = TaskApprovalRequestAcceptedBySpecificUser == YES || TaskApprovalRequestPendingBySpecificUser == YES ? @"🎉" : @"";
    NSString *bodyEmojiStringAfter = TaskApprovalRequestAcceptedBySpecificUser == YES || TaskApprovalRequestPendingBySpecificUser == YES ? @"! 🎉" : @". 😢";
    
    NSString *bodyStringRequestApproval = TaskApprovalRequestPendingBySpecificUser == YES ? @"has submitted a completion request" : @"has removed a completion request";
    NSString *bodyStringCreatorRequestApproval = TaskApprovalRequestAcceptedBySpecificUser == YES ? [NSString stringWithFormat:@"has approved %@'s completion request", usernameWhoIsBeingMarkedUserID] : [NSString stringWithFormat:@"has declined %@'s completion request", usernameWhoIsBeingMarkedUserID];
    
    if ([itemCreatedBy isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] == YES) {
        
        notificationBody = [NSString stringWithFormat:@"%@ %@ %@%@",
                            bodyEmojiStringBefore,
                            [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"] : @"",
                            bodyStringCreatorRequestApproval,
                            bodyEmojiStringAfter];
        
    } else {
        
        notificationBody = [NSString stringWithFormat:@"%@ %@ %@%@",
                            bodyEmojiStringBefore,
                            [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"] : @"",
                            bodyStringRequestApproval,
                            bodyEmojiStringAfter];
        
    }
    
    [notificationText setObject:notificationTitle forKey:@"Title"];
    [notificationText setObject:notificationBody forKey:@"Body"];
    
    return notificationText;
}


#pragma mark Subtasks

-(NSMutableDictionary *)GenerateSubtaskCompletedNotificationText:(NSMutableDictionary *)dictToUse subtaskThatIsBeingMarked:(NSString *)subtaskThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse {
    
    NSMutableDictionary *notificationText = [NSMutableDictionary dictionary];
    
    
    
    NSString *itemName = dictToUse[@"ItemName"] ? dictToUse[@"ItemName"] : @"";
    
    NSString *notificationTitle = [NSString stringWithFormat:@"\"%@\"", itemName];
    
    
    BOOL SubtaskIsBeingMarkedCompleted = [[[CompleteUncompleteObject alloc] init] GenerateSubtaskIsBeingMarkedCompleted:dictToUse subtaskThatIsBeingMarked:subtaskThatIsBeingMarked];
    NSString *bodyEmojiStringBefore = SubtaskIsBeingMarkedCompleted == YES ? @"🎉" : @"";
    NSString *bodyEmojiStringAfter = SubtaskIsBeingMarkedCompleted == YES ? @"! 🎉" : @". 😢";
    NSString *bodyString = SubtaskIsBeingMarkedCompleted == YES ? @"has been completed by" : @"has been uncompleted by";
    NSString *bodyExtraString = markingForSomeoneElse && [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"][@"CompletedFor"] ? [NSString stringWithFormat:@" for %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"][@"CompletedFor"]] : @"";
    
    //🎉 This subtask has been completed by philip! 🎉
    NSString *notificationBody = [NSString stringWithFormat:@"%@ The subtask, \"%@\",  %@ %@%@%@",
                                  bodyEmojiStringBefore,
                                  subtaskThatIsBeingMarked,
                                  bodyString,
                                  [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"] : @"",
                                  bodyExtraString,
                                  bodyEmojiStringAfter];
    
    
    
    [notificationText setObject:notificationTitle forKey:@"Title"];
    [notificationText setObject:notificationBody forKey:@"Body"];
    
    return notificationText;
}

-(NSMutableDictionary *)GenerateSubtaskInProgressNotificationText:(NSMutableDictionary *)dictToUse subtaskThatIsBeingMarked:(NSString *)subtaskThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse {
    
    NSMutableDictionary *notificationText = [NSMutableDictionary dictionary];
    
    
    
    NSString *itemName = dictToUse[@"ItemName"] ? dictToUse[@"ItemName"] : @"";
    
    NSString *notificationTitle = [NSString stringWithFormat:@"\"%@\"", itemName];
    
    
    BOOL SubtaskIsBeingMarkedInProgress = [[[CompleteUncompleteObject alloc] init] GenerateSubtaskIsBeingMarkedInProgress:dictToUse subtaskThatIsBeingMarked:subtaskThatIsBeingMarked];
    NSString *bodyEmojiStringAfter = SubtaskIsBeingMarkedInProgress == YES ? @"! ⏳" : @". 😢";
    NSString *bodyString = SubtaskIsBeingMarkedInProgress == YES ? @"is being worked on by" : @"is no longer being worked on by";
    NSString *bodyExtraString = markingForSomeoneElse && [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"][@"CompletedFor"] ? [NSString stringWithFormat:@" for %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"][@"CompletedFor"]] : @"";
    
    //🎉 This subtask has been completed by philip! 🎉
    NSString *notificationBody = [NSString stringWithFormat:@"The subtask, \"%@\",  %@ %@%@%@",
                                  subtaskThatIsBeingMarked,
                                  bodyString,
                                  [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"] : @"",
                                  bodyExtraString,
                                  bodyEmojiStringAfter];
    
    
    
    [notificationText setObject:notificationTitle forKey:@"Title"];
    [notificationText setObject:notificationBody forKey:@"Body"];
    
    return notificationText;
}

-(NSMutableDictionary *)GenerateSubtaskWontDoNotificationText:(NSMutableDictionary *)dictToUse subtaskThatIsBeingMarked:(NSString *)subtaskThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse {
    
    NSMutableDictionary *notificationText = [NSMutableDictionary dictionary];
    
    
    
    NSString *itemName = dictToUse[@"ItemName"] ? dictToUse[@"ItemName"] : @"";
    
    NSString *notificationTitle = [NSString stringWithFormat:@"\"%@\"", itemName];
    
    BOOL SubtaskIsBeingMarkedWontDo = [[[CompleteUncompleteObject alloc] init] GenerateSubtaskIsBeingMarkedWontDo:dictToUse subtaskThatIsBeingMarked:subtaskThatIsBeingMarked];
    NSString *bodyEmojiStringAfter = SubtaskIsBeingMarkedWontDo == YES ? @". 😢" : @"! ⏳";
    NSString *bodyString = SubtaskIsBeingMarkedWontDo == YES ? @"will not be done by" : @"will be done by";
    NSString *bodyExtraString = markingForSomeoneElse && [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"][@"CompletedFor"] ? [NSString stringWithFormat:@" for %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"][@"CompletedFor"]] : @"";
    
    //🎉 This subtask has been completed by philip! 🎉
    NSString *notificationBody = [NSString stringWithFormat:@"The subtask, \"%@\",  %@ %@%@%@",
                                  subtaskThatIsBeingMarked,
                                  bodyString,
                                  [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"] : @"",
                                  bodyExtraString,
                                  bodyEmojiStringAfter];
    
    
    
    [notificationText setObject:notificationTitle forKey:@"Title"];
    [notificationText setObject:notificationBody forKey:@"Body"];
    
    return notificationText;
}

-(NSMutableDictionary *)GenerateSubtaskCreateAcceptDeclineNotificationText:(NSMutableDictionary *)dictToUse homeMembersDict:(NSMutableDictionary *)homeMembersDict subtaskThatIsBeingMarked:(NSString *)subtaskThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse {
    
    NSMutableDictionary *notificationText = [NSMutableDictionary dictionary];
    
    
    
    NSString *itemName = dictToUse[@"ItemName"] ? dictToUse[@"ItemName"] : @"";
    NSString *itemCreatedBy = dictToUse[@"ItemCreatedBy"] ? dictToUse[@"ItemCreatedBy"] : @"";
    
    NSString *notificationTitle = [NSString stringWithFormat:@"\"%@\"", itemName];
    
    
    NSString *itemType = [[[GeneralObject alloc] init] GenerateItemType];
    BOOL TaskIsRequestApproval = [[[BoolDataObject alloc] init] TaskIsRequestApproval:dictToUse itemType:itemType];
    BOOL SubtaskIsBeingMarkedCompleted = [[[CompleteUncompleteObject alloc] init] GenerateSubtaskIsBeingMarkedCompleted:dictToUse subtaskThatIsBeingMarked:subtaskThatIsBeingMarked];
    BOOL SubtaskIsRequestingApprovalPending = [[[BoolDataObject alloc] init] SubtaskIsRequestingApprovalPending:dictToUse itemType:itemType subtask:subtaskThatIsBeingMarked];
    
    NSString *bodyEmojiStringBefore = SubtaskIsBeingMarkedCompleted == YES || SubtaskIsRequestingApprovalPending == YES ? @"🎉" : @"";
    NSString *bodyEmojiStringAfter = SubtaskIsBeingMarkedCompleted == YES || SubtaskIsRequestingApprovalPending == YES ? @"! 🎉" : @". 😢";
    NSString *bodyString = SubtaskIsBeingMarkedCompleted == YES ? @"has been completed by" : @"has been uncompleted by";
    NSString *bodyExtraString = markingForSomeoneElse && [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"][@"CompletedFor"] ? [NSString stringWithFormat:@" for %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"][@"CompletedFor"]] : @"";
    
    NSString *notificationBody = @"";
    
    if (TaskIsRequestApproval == YES) {
        
        NSString *usernameWhoIsBeingMarkedUserID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"];
        
        NSString *bodyStringRequestApproval = SubtaskIsRequestingApprovalPending == YES ? [NSString stringWithFormat:@"has submitted a completion request for subtask, \"%@\"", subtaskThatIsBeingMarked] : [NSString stringWithFormat:@"has removed a completion request for subtask, \"%@\"", subtaskThatIsBeingMarked];
        NSString *bodyStringCreatorRequestApproval = SubtaskIsBeingMarkedCompleted == YES ? [NSString stringWithFormat:@"has approved %@'s completion request", usernameWhoIsBeingMarkedUserID] : [NSString stringWithFormat:@"has declined %@'s completion request for subtask, \"%@\"", usernameWhoIsBeingMarkedUserID, subtaskThatIsBeingMarked];
        
        if ([itemCreatedBy isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]]) {
            
            notificationBody = [NSString stringWithFormat:@"%@ %@ %@%@%@",
                                bodyEmojiStringBefore,
                                [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"] : @"",
                                bodyStringCreatorRequestApproval,
                                bodyExtraString,
                                bodyEmojiStringAfter];
            
        } else {
            
            notificationBody = [NSString stringWithFormat:@"%@ %@ %@%@%@",
                                bodyEmojiStringBefore,
                                [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"] : @"",
                                bodyStringRequestApproval,
                                bodyExtraString,
                                bodyEmojiStringAfter];
            
        }
        
    } else {
        
        //🎉 This subtask has been completed by philip! 🎉
        notificationBody = [NSString stringWithFormat:@"%@ The subtask, \"%@\",  %@ %@%@%@",
                            bodyEmojiStringBefore,
                            subtaskThatIsBeingMarked,
                            bodyString,
                            [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"] : @"",
                            bodyExtraString,
                            bodyEmojiStringAfter];
        
    }
    
    
    [notificationText setObject:notificationTitle forKey:@"Title"];
    [notificationText setObject:notificationBody forKey:@"Body"];
    
    return notificationText;
}

#pragma mark List Items

-(NSMutableDictionary *)GenerateListItemFullCompletedNotificationText:(NSMutableDictionary *)dictToUse listItemThatIsBeingMarked:(NSString *)listItemThatIsBeingMarked homeMembersDict:(NSMutableDictionary *)homeMembersDict {
    
    NSMutableDictionary *notificationText = [NSMutableDictionary dictionary];
    
    
    
    NSString *itemName = dictToUse[@"ItemName"] ? dictToUse[@"ItemName"] : @"";
    NSMutableArray *itemAssignedTo = dictToUse[@"ItemAssignedTo"] ? dictToUse[@"ItemAssignedTo"] : [NSMutableArray array];
    NSMutableDictionary *itemWontDo = dictToUse[@"ItemWontDo"] ? [dictToUse[@"ItemWontDo"] mutableCopy] : [NSMutableDictionary dictionary];
    
    NSString *notificationTitle = [NSString stringWithFormat:@"\"%@\"", itemName];
    NSString *notificationBody = @"";
    
    NSString *itemType = [[[GeneralObject alloc] init] GenerateItemType];
    
    BOOL TaskIsFullyCompletedButNotByEveryone = [[[BoolDataObject alloc] init] TaskIsFullyCompletedButNotByEveryone:dictToUse itemType:itemType homeMembersDict:homeMembersDict];
    BOOL TaskIsBeingCompleted = [[[CompleteUncompleteObject alloc] init] GenerateListItemIsBeingMarkedCompleted:dictToUse listItemThatIsBeingMarked:listItemThatIsBeingMarked];
    BOOL TaskIsTakingTurns = [[[BoolDataObject alloc] init] TaskIsTakingTurns:dictToUse itemType:itemType];
    BOOL TaskIsPartiallyCompleted = TaskIsTakingTurns == NO && [[itemWontDo allKeys] count] > 0 ? YES : NO;
    BOOL TaskIsWontDo = NO;
    
    if ((TaskIsTakingTurns && [[itemWontDo allKeys] count] > 0) ||
        (TaskIsTakingTurns == NO && [[itemWontDo allKeys] count] >= [itemAssignedTo count])) {
        TaskIsWontDo = YES;
    }
    
    NSString *completedOrUncompleted = TaskIsBeingCompleted == YES ? @"Complete" : @"Uncomplete";
    
    
    
    //🎉 This list item has been completed by philip! 🎉
    if (TaskIsFullyCompletedButNotByEveryone == NO && TaskIsPartiallyCompleted == NO && TaskIsWontDo == NO) {
        
        notificationBody = [NSString stringWithFormat:@"🎊 This %@ has been %@d by everyone! 🎊",
                            [itemType lowercaseString],
                            [completedOrUncompleted lowercaseString]];
        
    } else if (TaskIsBeingCompleted == YES && TaskIsPartiallyCompleted == NO && TaskIsWontDo == NO) {
        
        notificationBody = [NSString stringWithFormat:@"🎊 This %@ has been %@d! 🎊",
                            [itemType lowercaseString],
                            [completedOrUncompleted lowercaseString]];
        
    } else if (TaskIsPartiallyCompleted == YES && TaskIsWontDo == NO) {
        
        notificationBody = [NSString stringWithFormat:@"🎊 This %@ has been partially completed! 🎊",
                            [itemType lowercaseString]];
        
        
    } else if (TaskIsWontDo == YES) {
        
        notificationBody = [NSString stringWithFormat:@"This %@ won't be completed! 😢",
                            [itemType lowercaseString]];
        
    }
    
    
    
    [notificationText setObject:notificationTitle forKey:@"Title"];
    [notificationText setObject:notificationBody forKey:@"Body"];
    
    return notificationText;
    
}

-(NSMutableDictionary *)GenerateListItemCompletedNotificationText:(NSMutableDictionary *)dictToUse listItemThatIsBeingMarked:(NSString *)listItemThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse {
    
    NSMutableDictionary *notificationText = [NSMutableDictionary dictionary];
    
    
    
    NSString *itemName = dictToUse[@"ItemName"] ? dictToUse[@"ItemName"] : @"";
    
    NSString *notificationTitle = [NSString stringWithFormat:@"\"%@\"", itemName];
    
    
    BOOL ListItemIsBeingMarkedCompleted = [[[CompleteUncompleteObject alloc] init] GenerateListItemIsBeingMarkedCompleted:dictToUse listItemThatIsBeingMarked:listItemThatIsBeingMarked];
    NSString *bodyEmojiStringBefore = ListItemIsBeingMarkedCompleted == YES ? @"🎉" : @"";
    NSString *bodyEmojiStringAfter = ListItemIsBeingMarkedCompleted == YES ? @"! 🎉" : @". 😢";
    NSString *bodyString = ListItemIsBeingMarkedCompleted == YES ? @"has been completed by" : @"has been uncompleted by";
    NSString *bodyExtraString = markingForSomeoneElse && [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"][@"CompletedFor"] ? [NSString stringWithFormat:@" for %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"][@"CompletedFor"]] : @"";
    
    //🎉 This list item has been completed by philip! 🎉
    NSString *notificationBody = [NSString stringWithFormat:@"%@ The list item, \"%@\",  %@ %@%@%@",
                                  bodyEmojiStringBefore,
                                  listItemThatIsBeingMarked,
                                  bodyString,
                                  [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"] : @"",
                                  bodyExtraString,
                                  bodyEmojiStringAfter];
    
    
    
    [notificationText setObject:notificationTitle forKey:@"Title"];
    [notificationText setObject:notificationBody forKey:@"Body"];
    
    return notificationText;
}

-(NSMutableDictionary *)GenerateListItemCompletedCompleteAsNeededNotificationText:(NSMutableDictionary *)dictToUse homeMembersDict:(NSMutableDictionary *)homeMembersDict listItemThatIsBeingMarked:(NSString *)listItemThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse {
    
    BOOL TaskIsBeingCompleted = [[[CompleteUncompleteObject alloc] init] GenerateListItemIsBeingMarkedCompleted:dictToUse listItemThatIsBeingMarked:listItemThatIsBeingMarked];
    NSString *completedOrUncompleted = TaskIsBeingCompleted == YES ? @"Complete" : @"Uncomplete";
    
    NSString *itemType = [[[GeneralObject alloc] init] GenerateItemType];
    
    BOOL TaskIsCompleteAsNeeded = NO;
    BOOL TaskIsTakingTurns = NO;
    
    BOOL TaskCompletedBySomeoneElse = [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"];
    
    NSMutableDictionary *notificationText = [NSMutableDictionary dictionary];
    
    
    
    NSString *itemName = dictToUse[@"ItemName"] ? dictToUse[@"ItemName"] : @"";
    NSMutableArray *itemAssignedTo = dictToUse[@"ItemAssignedTo"] ? dictToUse[@"ItemAssignedTo"] : [NSMutableArray array];
    
    NSString *notificationTitle = [NSString stringWithFormat:@"\"%@\"", itemName];
    
    
    BOOL ListItemIsBeingMarkedCompleted = [[[CompleteUncompleteObject alloc] init] GenerateListItemIsBeingMarkedCompleted:dictToUse listItemThatIsBeingMarked:listItemThatIsBeingMarked];
    NSString *bodyEmojiStringBefore = ListItemIsBeingMarkedCompleted == YES ? @"🎉" : @"";
    NSString *bodyEmojiStringAfter = ListItemIsBeingMarkedCompleted == YES ? @"! 🎉" : @"";
    NSString *bodyString = [NSString stringWithFormat:@"%@ for %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"][@"CompletedBy"], [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"][@"CompletedFor"]];
    
    NSString *notificationBody = @"";
    
    
    
    
    if (TaskIsCompleteAsNeeded == YES && TaskIsTakingTurns == YES && TaskCompletedBySomeoneElse == NO) {
        
        NSMutableDictionary *itemCompletedDict = dictToUse[@"ItemCompletedDict"] ? [dictToUse[@"ItemCompletedDict"] mutableCopy] : [NSMutableDictionary dictionary];
        NSString *itemTurnUserID = dictToUse[@"ItemTurnUserID"] ? dictToUse[@"ItemTurnUserID"] : @"";
        
        if (itemTurnUserID.length == 0 && [dictToUse[@"ItemTakeTurns"] isEqualToString:@"Yes"]) {
            
            itemTurnUserID = [[[GeneralObject alloc] init] GenerateCurrentUsersTurn:dictToUse[@"ItemDueDate"] ? dictToUse[@"ItemDueDate"] : @""
                                                                        itemRepeats:dictToUse[@"ItemRepeats"] ? dictToUse[@"ItemRepeats"] : @""
                                                            itemRepeatIfCompletedEarly:dictToUse[@"ItemRepeatIfCompletedEarly"] ? dictToUse[@"ItemRepeatIfCompletedEarly"] : @""
                                                               itemCompleteAsNeeded:dictToUse[@"ItemCompleteAsNeeded"] ? dictToUse[@"ItemCompleteAsNeeded"] : @""
                                                                      itemTakeTurns:dictToUse[@"ItemTakeTurns"] ? dictToUse[@"ItemTakeTurns"] : @""
                                                                  itemCompletedDict:itemCompletedDict
                                                                itemAssignedToArray:itemAssignedTo
                                                                           itemType:itemType itemTurnUserID:dictToUse[@"ItemTurnUserID"] homeMembersDict:homeMembersDict];
            
        }
        
        NSString *userIDWhosTurnItIs = itemTurnUserID;
        
        NSString *usernameWhosTurnIsIs;
        
        if ([itemAssignedTo containsObject:userIDWhosTurnItIs]) {
            
            NSDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:userIDWhosTurnItIs homeMembersDict:homeMembersDict];
            NSString *username = dataDict[@"Username"];
            
            usernameWhosTurnIsIs = username;
            
        } else {
            
            usernameWhosTurnIsIs = @"the next persons";
            
        }
        
        //🎉 This list item has been completed by philip for alex. It is not john's turn! 🎉
        notificationBody = [NSString stringWithFormat:@"%@ The list item, \"%@\", has been %@d by %@%@%@",
                            bodyEmojiStringBefore,
                            listItemThatIsBeingMarked,
                            [completedOrUncompleted lowercaseString],
                            bodyString,
                            @"",//[NSString stringWithFormat:@". It is now %@'s turn", usernameWhosTurnIsIs],
                            bodyEmojiStringAfter];
        
    } else if (TaskCompletedBySomeoneElse == YES) {
        
        //🎉 This list item has been completed by philip for alex! 🎉
        notificationBody = [NSString stringWithFormat:@"%@ This list item, \"%@\", has been %@d by %@%@",
                            bodyEmojiStringBefore,
                            listItemThatIsBeingMarked,
                            [completedOrUncompleted lowercaseString],
                            bodyString,
                            bodyEmojiStringAfter];
        
    }
    
    
    
    
    
    [notificationText setObject:notificationTitle forKey:@"Title"];
    [notificationText setObject:notificationBody forKey:@"Body"];
    
    return notificationText;
    
}

-(NSMutableDictionary *)GenerateListItemInProgressNotificationText:(NSMutableDictionary *)dictToUse listItemThatIsBeingMarked:(NSString *)listItemThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse {
    
    NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"] : @"";
    
    NSMutableDictionary *notificationText = [NSMutableDictionary dictionary];
    
    
    
    NSString *itemName = dictToUse[@"ItemName"] ? dictToUse[@"ItemName"] : @"";
    
    NSString *notificationTitle = [NSString stringWithFormat:@"\"%@\"", itemName];
    
    
    BOOL ListItemIsBeingMarkedInProgress = [[[CompleteUncompleteObject alloc] init] GenerateListItemIsBeingMarkedInProgress:dictToUse listItemThatIsBeingMarked:listItemThatIsBeingMarked];
    NSString *bodyEmojiStringAfter = ListItemIsBeingMarkedInProgress == YES ? @"! ⏳" : @". 😢";
    NSString *bodyString = ListItemIsBeingMarkedInProgress == YES ? @"is being worked on by" : @"is no longer being worked on by";
    NSString *bodyExtraString = markingForSomeoneElse && [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"][@"CompletedFor"] ? [NSString stringWithFormat:@" for %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"][@"CompletedFor"]] : @"";
    
    //🎉 This list item has been completed by philip! 🎉
    NSString *notificationBody = [NSString stringWithFormat:@"The list item, \"%@\",  %@ %@%@%@",
                                  listItemThatIsBeingMarked,
                                  bodyString,
                                  userName,
                                  bodyExtraString,
                                  bodyEmojiStringAfter];
    
    
    
    [notificationText setObject:notificationTitle forKey:@"Title"];
    [notificationText setObject:notificationBody forKey:@"Body"];
    
    return notificationText;
}

-(NSMutableDictionary *)GenerateListItemWontDoNotificationText:(NSMutableDictionary *)dictToUse listItemThatIsBeingMarked:(NSString *)listItemThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse {
    
    NSMutableDictionary *notificationText = [NSMutableDictionary dictionary];
    
    
    
    NSString *itemName = dictToUse[@"ItemName"] ? dictToUse[@"ItemName"] : @"";
    
    NSString *notificationTitle = [NSString stringWithFormat:@"\"%@\"", itemName];
    
    
    BOOL ListItemIsBeingMarkedWontDo = [[[CompleteUncompleteObject alloc] init] GenerateListItemIsBeingMarkedWontDo:dictToUse listItemThatIsBeingMarked:listItemThatIsBeingMarked];
    NSString *bodyEmojiStringAfter = ListItemIsBeingMarkedWontDo == YES ? @". 😢" : @"! ⏳";
    NSString *bodyString = ListItemIsBeingMarkedWontDo == YES ? @"will not be done by" : @"will be done by";
    NSString *bodyExtraString = markingForSomeoneElse && [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"][@"CompletedFor"] ? [NSString stringWithFormat:@" for %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"][@"CompletedFor"]] : @"";
    
    //🎉 This list item has been completed by philip! 🎉
    NSString *notificationBody = [NSString stringWithFormat:@"The list item, \"%@\",  %@ %@%@%@",
                                  listItemThatIsBeingMarked,
                                  bodyString,
                                  [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"] : @"",
                                  bodyExtraString,
                                  bodyEmojiStringAfter];
    
    
    
    [notificationText setObject:notificationTitle forKey:@"Title"];
    [notificationText setObject:notificationBody forKey:@"Body"];
    
    return notificationText;
}

#pragma mark Itemized Items

-(NSMutableDictionary *)GenerateItemizedItemFullCompletedNotificationText:(NSMutableDictionary *)dictToUse itemizedItemThatIsBeingMarked:(NSString *)itemizedItemThatIsBeingMarked homeMembersDict:(NSMutableDictionary *)homeMembersDict {
    
    NSMutableDictionary *notificationText = [NSMutableDictionary dictionary];
    
    
    
    NSString *itemName = dictToUse[@"ItemName"] ? dictToUse[@"ItemName"] : @"";
    NSMutableArray *itemAssignedTo = dictToUse[@"ItemAssignedTo"] ? dictToUse[@"ItemAssignedTo"] : [NSMutableArray array];
    NSMutableDictionary *itemWontDo = dictToUse[@"ItemWontDo"] ? [dictToUse[@"ItemWontDo"] mutableCopy] : [NSMutableDictionary dictionary];
    
    NSString *notificationTitle = [NSString stringWithFormat:@"\"%@\"", itemName];
    NSString *notificationBody = @"";
    
    NSString *itemType = [[[GeneralObject alloc] init] GenerateItemType];
    
    BOOL TaskIsFullyCompletedButNotByEveryone = [[[BoolDataObject alloc] init] TaskIsFullyCompletedButNotByEveryone:dictToUse itemType:itemType homeMembersDict:homeMembersDict];
    BOOL TaskIsBeingCompleted = [[[CompleteUncompleteObject alloc] init] GenerateItemizedItemIsBeingMarkedCompleted:dictToUse itemizedItemThatIsBeingMarked:itemizedItemThatIsBeingMarked];
    BOOL TaskIsTakingTurns = [[[BoolDataObject alloc] init] TaskIsTakingTurns:dictToUse itemType:itemType];
    BOOL TaskIsPartiallyCompleted = TaskIsTakingTurns == NO && [[itemWontDo allKeys] count] > 0 ? YES : NO;
    BOOL TaskIsWontDo = NO;
    
    if ((TaskIsTakingTurns && [[itemWontDo allKeys] count] > 0) ||
        (TaskIsTakingTurns == NO && [[itemWontDo allKeys] count] >= [itemAssignedTo count])) {
        TaskIsWontDo = YES;
    }
    
    NSString *completedOrUncompleted = TaskIsBeingCompleted == YES ? @"Complete" : @"Uncomplete";
    
    
    
    //🎉 This itemized item has been completed by philip! 🎉
    if (TaskIsFullyCompletedButNotByEveryone == NO && TaskIsPartiallyCompleted == NO && TaskIsWontDo == NO) {
        
        notificationBody = [NSString stringWithFormat:@"🎊 This %@ has been %@d by everyone! 🎊",
                            [itemType lowercaseString],
                            [completedOrUncompleted lowercaseString]];
        
    } else if (TaskIsBeingCompleted == YES && TaskIsPartiallyCompleted == NO && TaskIsWontDo == NO) {
        
        notificationBody = [NSString stringWithFormat:@"🎊 This %@ has been %@d! 🎊",
                            [itemType lowercaseString],
                            [completedOrUncompleted lowercaseString]];
        
    } else if (TaskIsPartiallyCompleted == YES && TaskIsWontDo == NO) {
        
        notificationBody = [NSString stringWithFormat:@"🎊 This %@ has been partially completed! 🎊",
                            [itemType lowercaseString]];
        
        
    } else if (TaskIsWontDo == YES) {
        
        notificationBody = [NSString stringWithFormat:@"This %@ won't be completed! 😢",
                            [itemType lowercaseString]];
        
    }
    
    
    
    [notificationText setObject:notificationTitle forKey:@"Title"];
    [notificationText setObject:notificationBody forKey:@"Body"];
    
    return notificationText;
    
}

-(NSMutableDictionary *)GenerateItemizedItemCompletedNotificationText:(NSMutableDictionary *)dictToUse itemizedItemThatIsBeingMarked:(NSString *)itemizedItemThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse {
    
    NSMutableDictionary *notificationText = [NSMutableDictionary dictionary];
    
    
    
    NSString *itemName = dictToUse[@"ItemName"] ? dictToUse[@"ItemName"] : @"";
    
    NSString *notificationTitle = [NSString stringWithFormat:@"\"%@\"", itemName];
    
    
    BOOL ItemizedItemIsBeingMarkedCompleted = [[[CompleteUncompleteObject alloc] init] GenerateItemizedItemIsBeingMarkedCompleted:dictToUse itemizedItemThatIsBeingMarked:itemizedItemThatIsBeingMarked];
    NSString *bodyEmojiStringBefore = ItemizedItemIsBeingMarkedCompleted == YES ? @"🎉" : @"";
    NSString *bodyEmojiStringAfter = ItemizedItemIsBeingMarkedCompleted == YES ? @"! 🎉" : @". 😢";
    NSString *bodyString = ItemizedItemIsBeingMarkedCompleted == YES ? @"has been completed by" : @"has been uncompleted by";
    NSString *bodyExtraString = markingForSomeoneElse && [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"][@"CompletedFor"] ? [NSString stringWithFormat:@" for %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"][@"CompletedFor"]] : @"";
    
    //🎉 This itemized item has been completed by philip! 🎉
    NSString *notificationBody = [NSString stringWithFormat:@"%@ The expense item, \"%@\",  %@ %@%@%@",
                                  bodyEmojiStringBefore,
                                  itemizedItemThatIsBeingMarked,
                                  bodyString,
                                  [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"] : @"",
                                  bodyExtraString,
                                  bodyEmojiStringAfter];
    
    
    
    [notificationText setObject:notificationTitle forKey:@"Title"];
    [notificationText setObject:notificationBody forKey:@"Body"];
    
    return notificationText;
}

-(NSMutableDictionary *)GenerateItemizedItemCompletedCompleteAsNeededNotificationText:(NSMutableDictionary *)dictToUse homeMembersDict:(NSMutableDictionary *)homeMembersDict itemizedItemThatIsBeingMarked:(NSString *)itemizedItemThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse {
    
    BOOL TaskIsBeingCompleted = [[[CompleteUncompleteObject alloc] init] GenerateItemizedItemIsBeingMarkedCompleted:dictToUse itemizedItemThatIsBeingMarked:itemizedItemThatIsBeingMarked];
    NSString *completedOrUncompleted = TaskIsBeingCompleted == YES ? @"Complete" : @"Uncomplete";
    
    NSString *itemType = [[[GeneralObject alloc] init] GenerateItemType];
    
    BOOL TaskIsCompleteAsNeeded = NO;
    BOOL TaskIsTakingTurns = NO;
    
    BOOL TaskCompletedBySomeoneElse = [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"];
    
    NSMutableDictionary *notificationText = [NSMutableDictionary dictionary];
    
    
    
    NSString *itemName = dictToUse[@"ItemName"] ? dictToUse[@"ItemName"] : @"";
    NSMutableArray *itemAssignedTo = dictToUse[@"ItemAssignedTo"] ? dictToUse[@"ItemAssignedTo"] : [NSMutableArray array];
    
    NSString *notificationTitle = [NSString stringWithFormat:@"\"%@\"", itemName];
    
    
    BOOL ItemizedItemIsBeingMarkedCompleted = [[[CompleteUncompleteObject alloc] init] GenerateItemizedItemIsBeingMarkedCompleted:dictToUse itemizedItemThatIsBeingMarked:itemizedItemThatIsBeingMarked];
    NSString *bodyEmojiStringBefore = ItemizedItemIsBeingMarkedCompleted == YES ? @"🎉" : @"";
    NSString *bodyEmojiStringAfter = ItemizedItemIsBeingMarkedCompleted == YES ? @"! 🎉" : @"";
    NSString *bodyString = [NSString stringWithFormat:@"%@ for %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"][@"CompletedBy"], [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"][@"CompletedFor"]];
    
    NSString *notificationBody = @"";
    
    
    
    
    if (TaskIsCompleteAsNeeded == YES && TaskIsTakingTurns == YES && TaskCompletedBySomeoneElse == NO) {
        
        NSMutableDictionary *itemCompletedDict = dictToUse[@"ItemCompletedDict"] ? [dictToUse[@"ItemCompletedDict"] mutableCopy] : [NSMutableDictionary dictionary];
        NSString *itemTurnUserID = dictToUse[@"ItemTurnUserID"] ? dictToUse[@"ItemTurnUserID"] : @"";
        
        if (itemTurnUserID.length == 0 && [dictToUse[@"ItemTakeTurns"] isEqualToString:@"Yes"]) {
            
            itemTurnUserID = [[[GeneralObject alloc] init] GenerateCurrentUsersTurn:dictToUse[@"ItemDueDate"] ? dictToUse[@"ItemDueDate"] : @""
                                                                        itemRepeats:dictToUse[@"ItemRepeats"] ? dictToUse[@"ItemRepeats"] : @""
                                                            itemRepeatIfCompletedEarly:dictToUse[@"ItemRepeatIfCompletedEarly"] ? dictToUse[@"ItemRepeatIfCompletedEarly"] : @""
                                                               itemCompleteAsNeeded:dictToUse[@"ItemCompleteAsNeeded"] ? dictToUse[@"ItemCompleteAsNeeded"] : @""
                                                                      itemTakeTurns:dictToUse[@"ItemTakeTurns"] ? dictToUse[@"ItemTakeTurns"] : @""
                                                                  itemCompletedDict:itemCompletedDict
                                                                itemAssignedToArray:itemAssignedTo
                                                                           itemType:itemType itemTurnUserID:dictToUse[@"ItemTurnUserID"] homeMembersDict:homeMembersDict];
            
        }
        
        NSString *userIDWhosTurnItIs = itemTurnUserID;
        
        NSString *usernameWhosTurnIsIs;
        
        if ([itemAssignedTo containsObject:userIDWhosTurnItIs]) {
            
            NSDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:userIDWhosTurnItIs homeMembersDict:homeMembersDict];
            NSString *username = dataDict[@"Username"];
            
            usernameWhosTurnIsIs = username;
            
        } else {
            
            usernameWhosTurnIsIs = @"the next persons";
            
        }
        
        //🎉 This itemized item has been completed by philip for alex. It is not john's turn! 🎉
        notificationBody = [NSString stringWithFormat:@"%@ The expense item, \"%@\", has been %@d by %@%@%@",
                            bodyEmojiStringBefore,
                            itemizedItemThatIsBeingMarked,
                            [completedOrUncompleted lowercaseString],
                            bodyString,
                            @"",//[NSString stringWithFormat:@". It is now %@'s turn", usernameWhosTurnIsIs],
                            bodyEmojiStringAfter];
        
    } else if (TaskCompletedBySomeoneElse == YES) {
        
        //🎉 This itemized item has been completed by philip for alex! 🎉
        notificationBody = [NSString stringWithFormat:@"%@ This expense item, \"%@\", has been %@d by %@%@",
                            bodyEmojiStringBefore,
                            itemizedItemThatIsBeingMarked,
                            [completedOrUncompleted lowercaseString],
                            bodyString,
                            bodyEmojiStringAfter];
        
    }
    
    
    
    
    
    [notificationText setObject:notificationTitle forKey:@"Title"];
    [notificationText setObject:notificationBody forKey:@"Body"];
    
    return notificationText;
    
}

-(NSMutableDictionary *)GenerateItemizedItemInProgressNotificationText:(NSMutableDictionary *)dictToUse itemizedItemThatIsBeingMarked:(NSString *)itemizedItemThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse {
    
    NSMutableDictionary *notificationText = [NSMutableDictionary dictionary];
    
    
    
    NSString *itemName = dictToUse[@"ItemName"] ? dictToUse[@"ItemName"] : @"";
    
    NSString *notificationTitle = [NSString stringWithFormat:@"\"%@\"", itemName];
    
    
    BOOL ItemizedItemIsBeingMarkedInProgress = [[[CompleteUncompleteObject alloc] init] GenerateItemizedItemIsBeingMarkedInProgress:dictToUse itemizedItemThatIsBeingMarked:itemizedItemThatIsBeingMarked];
    NSString *bodyEmojiStringAfter = ItemizedItemIsBeingMarkedInProgress == YES ? @"! ⏳" : @". 😢";
    NSString *bodyString = ItemizedItemIsBeingMarkedInProgress == YES ? @"is being worked on by" : @"is no longer being worked on by";
    NSString *bodyExtraString = markingForSomeoneElse && [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"][@"CompletedFor"] ? [NSString stringWithFormat:@" for %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"][@"CompletedFor"]] : @"";
    
    //🎉 This itemized item has been completed by philip! 🎉
    NSString *notificationBody = [NSString stringWithFormat:@"The expense item, \"%@\",  %@ %@%@%@",
                                  itemizedItemThatIsBeingMarked,
                                  bodyString,
                                  [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"] : @"",
                                  bodyExtraString,
                                  bodyEmojiStringAfter];
    
    
    
    [notificationText setObject:notificationTitle forKey:@"Title"];
    [notificationText setObject:notificationBody forKey:@"Body"];
    
    return notificationText;
}

-(NSMutableDictionary *)GenerateItemizedItemWontDoNotificationText:(NSMutableDictionary *)dictToUse itemizedItemThatIsBeingMarked:(NSString *)itemizedItemThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse {
    
    NSMutableDictionary *notificationText = [NSMutableDictionary dictionary];
    
    
    
    NSString *itemName = dictToUse[@"ItemName"] ? dictToUse[@"ItemName"] : @"";
    
    NSString *notificationTitle = [NSString stringWithFormat:@"\"%@\"", itemName];
    
    
    BOOL ItemizedItemIsBeingMarkedWontDo = [[[CompleteUncompleteObject alloc] init] GenerateItemizedItemIsBeingMarkedWontDo:dictToUse itemizedItemThatIsBeingMarked:itemizedItemThatIsBeingMarked];
    
    NSString *bodyEmojiStringAfter = ItemizedItemIsBeingMarkedWontDo == YES ? @". 😢" : @"! ⏳";
    NSString *bodyString = ItemizedItemIsBeingMarkedWontDo == YES ? @"will not be done by" : @"will be done by";
    NSString *bodyExtraString = markingForSomeoneElse && [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"][@"CompletedFor"] ? [NSString stringWithFormat:@" for %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"TaskCompletedForSomeoneElse"][@"CompletedFor"]] : @"";
    
    //🎉 This itemized item has been completed by philip! 🎉
    NSString *notificationBody = [NSString stringWithFormat:@"The expense item, \"%@\",  %@ %@%@%@",
                                  itemizedItemThatIsBeingMarked,
                                  bodyString,
                                  [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"] : @"",
                                  bodyExtraString,
                                  bodyEmojiStringAfter];
    
    
    
    [notificationText setObject:notificationTitle forKey:@"Title"];
    [notificationText setObject:notificationBody forKey:@"Body"];
    
    return notificationText;
}

#pragma mark
#pragma mark
#pragma mark
#pragma mark
#pragma mark
#pragma mark - Is Being Marked BOOL

#pragma mark Tasks

-(BOOL)GenerateTaskIsBeingMarkedCompleted:(NSMutableDictionary *)dictToUse userWhoIsBeingMarkedUserID:(NSString *)userWhoIsBeingMarkedUserID {
    
    NSString *itemType = [[[GeneralObject alloc] init] GenerateItemType];
    
    NSMutableDictionary *itemCompletedDict = dictToUse[@"ItemCompletedDict"] ? [dictToUse[@"ItemCompletedDict"] mutableCopy] : [NSMutableDictionary dictionary];
    
    BOOL TaskIsCompleteAsNeeded = [[[BoolDataObject alloc] init] TaskIsCompleteAsNeeded:dictToUse itemType:itemType];
    BOOL TaskWasCompleted =  [[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemCompletedDict userIDToFind:userWhoIsBeingMarkedUserID];
    
    BOOL TaskIsBeingMarkedCompleted = TaskWasCompleted == YES || TaskIsCompleteAsNeeded == YES;
    
    return TaskIsBeingMarkedCompleted;
}

-(BOOL)GenerateTaskIsBeingMarkedInProgress:(NSMutableDictionary *)dictToUse userWhoIsBeingMarkedUserID:(NSString *)userWhoIsBeingMarkedUserID {
    
    NSMutableDictionary *itemInProgressDict = dictToUse[@"ItemInProgressDict"] ? [dictToUse[@"ItemInProgressDict"] mutableCopy] : [NSMutableDictionary dictionary];
    
    BOOL ObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:itemInProgressDict classArr:@[[NSDictionary class], [NSMutableDictionary class]]];
    
    BOOL TaskIsInProgress = ObjectIsKindOfClass == YES ? [[itemInProgressDict allKeys] containsObject:userWhoIsBeingMarkedUserID] : NO;
    
    BOOL TaskIsBeingMarkedInProgress = TaskIsInProgress == YES;
    
    return TaskIsBeingMarkedInProgress;
}

-(BOOL)GenerateTaskIsBeingMarkedWontDo:(NSMutableDictionary *)dictToUse userWhoIsBeingMarkedUserID:(NSString *)userWhoIsBeingMarkedUserID {
    
    NSMutableDictionary *itemWontDo = dictToUse[@"ItemWontDo"] ? [dictToUse[@"ItemWontDo"] mutableCopy] : [NSMutableDictionary dictionary];
    
    BOOL TaskIsInWontDo = [[itemWontDo allKeys] containsObject:userWhoIsBeingMarkedUserID];
    
    BOOL TaskIsBeingMarkedWontDo = TaskIsInWontDo == YES;
    
    return TaskIsBeingMarkedWontDo;
}

#pragma mark Subtasks

-(BOOL)GenerateSubtaskIsBeingMarkedCompleted:(NSMutableDictionary *)dictToUse subtaskThatIsBeingMarked:(NSString *)subtaskThatIsBeingMarked {
    
    NSMutableDictionary *itemSubTasksDict = dictToUse[@"ItemSubTasks"] ? [dictToUse[@"ItemSubTasks"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *subtaskCompletedDict = itemSubTasksDict[subtaskThatIsBeingMarked] && itemSubTasksDict[subtaskThatIsBeingMarked][@"Completed Dict"] ? itemSubTasksDict[subtaskThatIsBeingMarked][@"Completed Dict"] : [NSMutableDictionary dictionary];
    
    BOOL SubtaskIsCompleted = [[subtaskCompletedDict allKeys] count] > 0;
    
    BOOL SubtaskIsBeingMarkedCompleted = SubtaskIsCompleted == YES;
    
    return SubtaskIsBeingMarkedCompleted;
}

-(BOOL)GenerateSubtaskIsBeingMarkedInProgress:(NSMutableDictionary *)dictToUse subtaskThatIsBeingMarked:(NSString *)subtaskThatIsBeingMarked {
    
    NSMutableDictionary *itemSubTasksDict = dictToUse[@"ItemSubTasks"] ? [dictToUse[@"ItemSubTasks"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *subtaskInProgressDict = itemSubTasksDict[subtaskThatIsBeingMarked] && itemSubTasksDict[subtaskThatIsBeingMarked][@"In Progress Dict"] ? itemSubTasksDict[subtaskThatIsBeingMarked][@"In Progress Dict"] : [NSMutableDictionary dictionary];
    
    BOOL SubtaskIsAlreadInProgress = [[subtaskInProgressDict allKeys] count] > 0;
    
    BOOL SubtaskIsBeingMarkedInProgress = SubtaskIsAlreadInProgress == YES;
    
    return SubtaskIsBeingMarkedInProgress;
}

-(BOOL)GenerateSubtaskIsBeingMarkedWontDo:(NSMutableDictionary *)dictToUse subtaskThatIsBeingMarked:(NSString *)subtaskThatIsBeingMarked {
    
    NSMutableDictionary *itemSubTasksDict = dictToUse[@"ItemSubTasks"] ? [dictToUse[@"ItemSubTasks"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *subtaskWontDo = itemSubTasksDict[subtaskThatIsBeingMarked] && itemSubTasksDict[subtaskThatIsBeingMarked][@"Wont Do"] ? itemSubTasksDict[subtaskThatIsBeingMarked][@"Wont Do"] : [NSMutableDictionary dictionary];
    
    BOOL SubtaskIsAlreadWontDo = [[subtaskWontDo allKeys] count] > 0;
    
    BOOL SubtaskIsBeingMarkedWontDo = SubtaskIsAlreadWontDo == YES;
    
    return SubtaskIsBeingMarkedWontDo;
}

#pragma mark List Items

-(BOOL)GenerateListItemIsBeingMarkedCompleted:(NSMutableDictionary *)dictToUse listItemThatIsBeingMarked:(NSString *)listItemThatIsBeingMarked {
    
    NSMutableDictionary *itemCompletedDict = dictToUse[@"ItemCompletedDict"] ? [dictToUse[@"ItemCompletedDict"] mutableCopy] : [NSMutableDictionary dictionary];
    
    NSString *itemType = [[[GeneralObject alloc] init] GenerateItemType];
    
    BOOL ListItemIsCompleted =  [[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemCompletedDict userIDToFind:listItemThatIsBeingMarked];
    BOOL TaskIsCompleteAsNeeded = [[[BoolDataObject alloc] init] TaskIsCompleteAsNeeded:dictToUse itemType:itemType];
    
    BOOL ListItemIsBeingMarkedCompleted = (ListItemIsCompleted == YES && TaskIsCompleteAsNeeded == NO) || TaskIsCompleteAsNeeded == YES;
    
    return ListItemIsBeingMarkedCompleted;
}

-(BOOL)GenerateListItemIsBeingMarkedInProgress:(NSMutableDictionary *)dictToUse listItemThatIsBeingMarked:(NSString *)listItemThatIsBeingMarked {
    
    NSMutableDictionary *itemInProgressDict = dictToUse[@"ItemInProgressDict"] ? [dictToUse[@"ItemInProgressDict"] mutableCopy] : [NSMutableDictionary dictionary];
    
    BOOL ListItemIsInProgress = [[itemInProgressDict allKeys] containsObject:listItemThatIsBeingMarked];
    
    BOOL ListItemIsBeingMarkedInProgress = ListItemIsInProgress == YES;
    
    return ListItemIsBeingMarkedInProgress;
}

-(BOOL)GenerateListItemIsBeingMarkedWontDo:(NSMutableDictionary *)dictToUse listItemThatIsBeingMarked:(NSString *)listItemThatIsBeingMarked {
    
    NSMutableDictionary *itemWontDoDict = dictToUse[@"ItemWontDo"] ? [dictToUse[@"ItemWontDo"] mutableCopy] : [NSMutableDictionary dictionary];
    
    BOOL ListItemIsWontDo = [[itemWontDoDict allKeys] containsObject:listItemThatIsBeingMarked];
    
    BOOL ListItemIsBeingMarkedWontDo = ListItemIsWontDo == YES;
    
    return ListItemIsBeingMarkedWontDo;
}

#pragma mark Itemized Items

-(BOOL)GenerateItemizedItemIsBeingMarkedCompleted:(NSMutableDictionary *)dictToUse itemizedItemThatIsBeingMarked:(NSString *)itemizedItemThatIsBeingMarked {
    
    NSMutableDictionary *itemCompletedDict = dictToUse[@"ItemCompletedDict"] ? [dictToUse[@"ItemCompletedDict"] mutableCopy] : [NSMutableDictionary dictionary];
    
    NSString *itemType = [[[GeneralObject alloc] init] GenerateItemType];
    
    BOOL ItemizedItemIsCompleted =  [[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemCompletedDict userIDToFind:itemizedItemThatIsBeingMarked];
    BOOL TaskIsCompleteAsNeeded = [[[BoolDataObject alloc] init] TaskIsCompleteAsNeeded:dictToUse itemType:itemType];
    
    BOOL ItemizedItemIsBeingMarkedCompleted = (ItemizedItemIsCompleted == YES && TaskIsCompleteAsNeeded == NO) || TaskIsCompleteAsNeeded == YES;
    
    return ItemizedItemIsBeingMarkedCompleted;
}

-(BOOL)GenerateItemizedItemIsBeingMarkedInProgress:(NSMutableDictionary *)dictToUse itemizedItemThatIsBeingMarked:(NSString *)itemizedItemThatIsBeingMarked {
    
    NSMutableDictionary *itemInProgressDict = dictToUse[@"ItemInProgressDict"] ? [dictToUse[@"ItemInProgressDict"] mutableCopy] : [NSMutableDictionary dictionary];
    
    BOOL ItemizedItemIsInProgress = [[itemInProgressDict allKeys] containsObject:itemizedItemThatIsBeingMarked];
    
    BOOL ItemizedItemIsBeingMarkedInProgress = ItemizedItemIsInProgress == YES;
    
    return ItemizedItemIsBeingMarkedInProgress;
}

-(BOOL)GenerateItemizedItemIsBeingMarkedWontDo:(NSMutableDictionary *)dictToUse itemizedItemThatIsBeingMarked:(NSString *)itemizedItemThatIsBeingMarked {
    
    NSMutableDictionary *itemWontDoDict = dictToUse[@"ItemWontDo"] ? [dictToUse[@"ItemWontDo"] mutableCopy] : [NSMutableDictionary dictionary];
    
    BOOL ItemizedItemIsWontDo = [[itemWontDoDict allKeys] containsObject:itemizedItemThatIsBeingMarked];
    
    BOOL ItemizedItemIsBeingMarkedWontDo = ItemizedItemIsWontDo == YES;
    
    return ItemizedItemIsBeingMarkedWontDo;
}

#pragma mark - Other

-(NSIndexPath *)GenerateTempIndexPath {
    
    NSInteger row = [[NSUserDefaults standardUserDefaults] objectForKey:@"TempIndexPathRow"] ?
    [[NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"TempIndexPathRow"]] intValue] : 0;
    NSInteger section = [[NSUserDefaults standardUserDefaults] objectForKey:@"TempIndexPathSection"] ?
    [[NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"TempIndexPathSection"]] intValue] : 0;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    
    return indexPath;
}

-(void)IncreaseCountForCompletedItemCount:(BOOL)Increase {
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"CompletedItem"] ||
        [[[NSUserDefaults standardUserDefaults] objectForKey:@"CompletedItem"] isEqualToString:@"0"]) {
        
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"CompletedItem"];
        
    } else {
        
        int completedItemCount = [[NSUserDefaults standardUserDefaults] objectForKey:@"CompletedItem"] ? [[NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"CompletedItem"]] intValue] : 0;
        
        if (Increase) {
            completedItemCount += 1;
        } else {
            completedItemCount -= 1;
        }
        
        NSString *completedItemCountStr = [NSString stringWithFormat:@"%d", completedItemCount];
        [[NSUserDefaults standardUserDefaults] setObject:completedItemCountStr forKey:@"CompletedItem"];
        
    }
    
}

-(NSMutableDictionary *)GenerateCompletedDict:(NSString *)userWhoIsBeingMarkedUserID markingForSomeoneElse:(BOOL)markingForSomeoneElse {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    NSString *dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *dateString = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:dateFormat returnAs:[NSString class]];
    
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ?
    [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
    
    [dict setObject:markingForSomeoneElse ? userID : userWhoIsBeingMarkedUserID forKey:@"Marked By"];
    [dict setObject:markingForSomeoneElse ? userWhoIsBeingMarkedUserID : @"" forKey:@"Marked For"];
    [dict setObject:dateString ? dateString : @"" forKey:@"Date Marked"];
   
    return dict;
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Internal Methods
#pragma mark
#pragma mark
#pragma mark -

#pragma mark Tasks
#pragma mark
#pragma mark
#pragma mark
#pragma mark
#pragma mark
#pragma mark TaskCompleteUncomplete

-(void)TaskCompleteUncomplete_SendPushNotifications:(NSMutableDictionary *)dictToUse itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict keyArray:(NSArray *)keyArray homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType topicDict:(NSMutableDictionary *)topicDict allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays userWhoIsBeingMarkedUserID:(NSString *)userWhoIsBeingMarkedUserID markingForSomeoneElse:(BOOL)markingForSomeoneElse TaskIsFullyCompleted:(BOOL)TaskIsFullyCompletedLocal completionHandler:(void (^)(BOOL finished))finishBlock {
    
    if (TaskIsFullyCompletedLocal == NO) {
        
        NSMutableDictionary *notificationText = [[[CompleteUncompleteObject alloc] init] GenerateCompletedNotificationText:dictToUse keyArray:(NSArray *)keyArray homeMembersDict:homeMembersDict userWhoIsBeingMarkedUserID:userWhoIsBeingMarkedUserID markingForSomeoneElse:markingForSomeoneElse];
        NSString *notificationTitle = notificationText[@"Title"] ? notificationText[@"Title"] : @"";
        NSString *notificationBody = notificationText[@"Body"] ? notificationText[@"Body"] : @"";
        
        NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
        
        
        
        NSString *itemCreatedBy = dictToUse[@"ItemCreatedBy"] ? dictToUse[@"ItemCreatedBy"] : @"";
        NSMutableArray *itemAssignedTo = dictToUse[@"ItemAssignedTo"] ? [dictToUse[@"ItemAssignedTo"] mutableCopy] : [NSMutableArray array];
        
        [itemAssignedTo addObject:itemCreatedBy];
        
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [[[NotificationsObject alloc] init] SendPushNotificationToArrayOfUsers_Items:itemAssignedTo
                                                                               dictToUse:dictToUse
                                                                                  homeID:homeID homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict
                                                                notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType
                                                                               topicDict:topicDict
                                                                       allItemTagsArrays:allItemTagsArrays
                                                                   pushNotificationTitle:notificationTitle pushNotificationBody:notificationBody
                                                                       notificationTitle:notificationTitle notificationBody:notificationBody
                                                                 SetDataHomeNotification:YES
                                                                    RemoveUsersNotInHome:YES
                                                                       completionHandler:^(BOOL finished) {
                
                finishBlock(YES);
                
            }];
            
        });
        
    } else {
        
        finishBlock(YES);
        
    }
    
}

-(void)TaskCompleteUncomplete_UpdateItemData:(NSMutableDictionary *)dictToUse itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict homeMembersDict:(NSMutableDictionary *)homeMembersDict keyArray:(NSArray *)keyArray completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *itemType = [[[GeneralObject alloc] init] GenerateItemType];
    NSString *collection = [NSString stringWithFormat:@"%@s", itemType];
    
    NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";

    BOOL TimeToAlternateTurns = [[[BoolDataObject alloc] init] TimeToAlternateTurns:dictToUse itemOccurrencesDict:itemOccurrencesDict itemType:itemType keyArray:keyArray homeMembersDict:homeMembersDict];
   
    NSString *itemTurnUserID = TimeToAlternateTurns ? [[[GeneralObject alloc] init] GenerateCurrentUserTurnFromDict:[dictToUse mutableCopy] homeMembersDict:homeMembersDict itemType:itemType] : dictToUse[@"ItemTurnUserID"];
    
    
    NSString *itemID = dictToUse[@"ItemID"] ? dictToUse[@"ItemID"] : @"";
    NSString *itemOccurrenceID = dictToUse[@"ItemOccurrenceID"] ? dictToUse[@"ItemOccurrenceID"] : @"";
    
    NSMutableDictionary *itemCompletedDict = dictToUse[@"ItemCompletedDict"] ? [dictToUse[@"ItemCompletedDict"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemInProgressDict = dictToUse[@"ItemInProgressDict"] ? [dictToUse[@"ItemInProgressDict"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemWontDo = dictToUse[@"ItemWontDo"] ? [dictToUse[@"ItemWontDo"] mutableCopy] : [NSMutableDictionary dictionary];
    __block NSMutableDictionary *itemSubTasksDict = dictToUse[@"ItemSubTasks"] ? [dictToUse[@"ItemSubTasks"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemApprovalRequests  = dictToUse[@"ItemApprovalRequests"] ? [dictToUse[@"ItemApprovalRequests"] mutableCopy] : [NSMutableDictionary dictionary];
    
    BOOL TaskIsCompleteAsNeeded = [[[BoolDataObject alloc] init] TaskIsCompleteAsNeeded:dictToUse itemType:itemType];
    BOOL TaskIsTakingTurns = [[[BoolDataObject alloc] init] TaskIsTakingTurns:dictToUse itemType:itemType];
    
    NSMutableDictionary *subTasksDictLocal = [itemSubTasksDict mutableCopy];
    
    if (TaskIsCompleteAsNeeded == YES && TaskIsTakingTurns == YES && [[itemSubTasksDict allKeys] count] > 0) {
        
        for (NSString *subtaskItem in [itemSubTasksDict allKeys]) {
            
            NSMutableDictionary *tempDict = [subTasksDictLocal[subtaskItem] mutableCopy];
            
            [tempDict setObject:[NSMutableDictionary dictionary] forKey:@"Completed Dict"];
            [tempDict setObject:[NSMutableDictionary dictionary] forKey:@"In Progress Dict"];
            [tempDict setObject:[NSMutableDictionary dictionary] forKey:@"Wont Do"];
            
            subTasksDictLocal[subtaskItem] = [tempDict mutableCopy];
            
        }
        
        [dictToUse setObject:subTasksDictLocal forKey:@"ItemSubTasks"];
        
    }
    
    itemCompletedDict = [[[GeneralObject alloc] init] GenerateDictWithoutEmptyKeys:[itemCompletedDict mutableCopy]] ? [[[[GeneralObject alloc] init] GenerateDictWithoutEmptyKeys:[itemCompletedDict mutableCopy]] mutableCopy] : [NSMutableDictionary dictionary];
    itemInProgressDict = [[[GeneralObject alloc] init] GenerateDictWithoutEmptyKeys:[itemInProgressDict mutableCopy]] ? [[[[GeneralObject alloc] init] GenerateDictWithoutEmptyKeys:[itemInProgressDict mutableCopy]] mutableCopy] : [NSMutableDictionary dictionary];
    itemWontDo = [[[GeneralObject alloc] init] GenerateDictWithoutEmptyKeys:[itemWontDo mutableCopy]] ? [[[[GeneralObject alloc] init] GenerateDictWithoutEmptyKeys:[itemWontDo mutableCopy]] mutableCopy] : [NSMutableDictionary dictionary];
    itemApprovalRequests = [[[GeneralObject alloc] init] GenerateDictWithoutEmptyKeys:[itemApprovalRequests mutableCopy]] ? [[[[GeneralObject alloc] init] GenerateDictWithoutEmptyKeys:[itemApprovalRequests mutableCopy]] mutableCopy] : [NSMutableDictionary dictionary];
    
    NSDictionary *dataDict = @{@"ItemCompletedDict" : itemCompletedDict ? itemCompletedDict : [NSMutableDictionary dictionary],
                               @"ItemInProgressDict" : itemInProgressDict ? itemInProgressDict : [NSMutableDictionary dictionary],
                               @"ItemWontDo" : itemWontDo ? itemWontDo : [NSMutableDictionary dictionary],
                               @"ItemSubTasks" : subTasksDictLocal ? subTasksDictLocal : [NSMutableDictionary dictionary],
                               @"ItemApprovalRequests" : itemApprovalRequests ? itemApprovalRequests : [NSMutableDictionary dictionary],
                               @"ItemTurnUserID" : itemTurnUserID};
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[SetDataObject alloc] init] UpdateDataEditItem:dataDict itemID:itemID itemOccurrenceID:itemOccurrenceID collection:collection homeID:homeID completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)TaskCompleteUncomplete_UpdateAlgoliaData:(NSMutableDictionary *)dictToUse completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[SetDataObject alloc] init] UpdateDataEditAlgoliaObject:dictToUse[@"ItemUniqueID"] dictToUse:dictToUse completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)TaskCompleteUncomplete_SetItemAndHomeActivityData:(NSMutableDictionary *)dictToUse userWhoIsBeingMarkedUserID:(NSString *)userWhoIsBeingMarkedUserID TaskIsBeingMarkedCompleted:(BOOL)TaskIsBeingMarkedCompleted completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *itemType = [[[GeneralObject alloc] init] GenerateItemType];
    
    NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
    
    NSString *itemID = dictToUse[@"ItemID"] ? dictToUse[@"ItemID"] : @"";
    NSString *itemOccurrenceID = dictToUse[@"ItemOccurrenceID"] ? dictToUse[@"ItemOccurrenceID"] : @"";
    NSString *itemName = dictToUse[@"ItemName"] ? dictToUse[@"ItemName"] : @"";
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *activityAction = [NSString stringWithFormat:@"%@ Task", TaskIsBeingMarkedCompleted ? @"Completing" : @"Uncompleting"];
        NSString *userTitle = [NSString stringWithFormat:@"%@ %@ a %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"], TaskIsBeingMarkedCompleted ? @"completed" : @"uncompleted", [itemType lowercaseString]];
        NSString *itemTitle = [NSString stringWithFormat:@"%@ %@ a %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"], TaskIsBeingMarkedCompleted ? @"completed" : @"uncompleted", [itemType lowercaseString]];
        NSString *itemDescription = [NSString stringWithFormat:@"\"%@\" was %@", itemName, TaskIsBeingMarkedCompleted ? @"completed" : @"uncompleted"];
        NSString *activityUserIDNo1 = [userWhoIsBeingMarkedUserID isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] == NO ? userWhoIsBeingMarkedUserID : @"";
        
        NSMutableDictionary *itemActivityDict = [[[SetDataObject alloc] init] GenerateItemActivityDict:itemID itemOccurrenceID:itemOccurrenceID activityUserIDNo1:activityUserIDNo1 homeID:homeID activityAction:activityAction userTitle:userTitle userDescription:itemDescription itemType:itemType];
        NSMutableDictionary *homeActivityDict = [[[SetDataObject alloc] init] GenerateHomeActivityDict:activityUserIDNo1 homeID:homeID activityAction:activityAction itemTitle:itemTitle itemDescription:itemDescription itemType:itemType];
        
        [[[SetDataObject alloc] init] SetDataHomeAndItemActivity:itemActivityDict homeActivityDict:homeActivityDict completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)TaskCompleteUncomplete_CompletionBlock:(int)totalQueries completedQueries:(int)completedQueries dictToUse:(NSMutableDictionary *)dictToUse itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict TaskIsFullyCompletedLocal:(BOOL)TaskIsFullyCompletedLocal CallNSNotificationMethods:(BOOL)CallNSNotificationMethods completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse, BOOL TaskIsFullyCompleted))finishBlock {
    
    if (totalQueries == completedQueries) {
        
        if (CallNSNotificationMethods == YES) {
            
            NSArray *locations = [[[NSUserDefaults standardUserDefaults] objectForKey:@"SelectOptionActionSelected"] isEqualToString:@"Yes"] ? @[@"Calendar"] : @[@"Tasks", @"Calendar"];
            
            [[[GeneralObject alloc] init] CallNSNotificationMethods:@"EditTask" userInfo:dictToUse locations:locations];
            
        }
        
        finishBlock(YES, dictToUse, itemOccurrencesDict, TaskIsFullyCompletedLocal);
        
    }
    
}

#pragma mark

-(void)TaskCompleteUncomplete_TaskIsFullyCompleted:(NSMutableDictionary *)dictToUse itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict keyArray:(NSArray *)keyArray homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType topicDict:(NSMutableDictionary *)topicDict taskListDict:(NSMutableDictionary *)taskListDict allItemAssignedToArrays:(NSMutableArray * _Nullable)allItemAssignedToArrays allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays userWhoIsBeingMarkedUserID:(NSString *)userWhoIsBeingMarkedUserID markingForSomeoneElse:(BOOL)markingForSomeoneElse TaskIsFullyCompleted:(BOOL)TaskIsFullyCompleted currentViewController:(UIViewController *)currentViewController completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse, NSMutableDictionary *returningUpdatedTaskListDictToUse, BOOL TaskIsFullyCompleted))finishBlock {
   
    __block NSMutableDictionary *returningDictToUseLocal = [dictToUse mutableCopy];
    __block NSMutableDictionary *returningOccurrencesDictToUseLocal = [itemOccurrencesDict mutableCopy];
    __block NSMutableDictionary *returningUpdatedTaskListDictToUseLocal = [NSMutableDictionary dictionary];
    
    
    
    __block int totalQueries = 2;
    __block int completedQueries = 0;
    
    
    
    if (TaskIsFullyCompleted == YES) {
        
      
        /*
         //
         //
         //Send Push Notifications
         //
         //
         */
        [[[CompleteUncompleteObject alloc] init] TaskCompleteUncomplete_TaskIsFullyCompleted_SendPushNotifications:dictToUse itemOccurrencesDict:itemOccurrencesDict keyArray:keyArray homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType topicDict:topicDict allItemTagsArrays:allItemTagsArrays userWhoIsBeingMarkedUserID:userWhoIsBeingMarkedUserID markingForSomeoneElse:markingForSomeoneElse currentViewController:currentViewController completionHandler:^(BOOL finished) {
            
            [[[CompleteUncompleteObject alloc] init] TaskCompleteUncomplete_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:returningDictToUseLocal itemOccurrencesDict:returningOccurrencesDictToUseLocal TaskIsFullyCompletedLocal:YES CallNSNotificationMethods:NO completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse, BOOL TaskIsFullyCompleted) {
                
                finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse, returningUpdatedTaskListDictToUseLocal, TaskIsFullyCompleted);
                
            }];
            
        }];
        
        
        /*
         //
         //
         //Reset Item Silent Notifications
         //
         //
         */
        [[[CompleteUncompleteObject alloc] init] TaskCompleteUncomplete_TaskIsFullyCompleted_ResetItemSilentNotifications:dictToUse itemOccurrencesDict:itemOccurrencesDict keyArray:keyArray homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType topicDict:topicDict allItemTagsArrays:allItemTagsArrays userWhoIsBeingMarkedUserID:userWhoIsBeingMarkedUserID markingForSomeoneElse:markingForSomeoneElse currentViewController:currentViewController completionHandler:^(BOOL finished) {
           
            /*
             //
             //
             //Reset Item Data
             //
             //
             */
            [[[CompleteUncompleteObject alloc] init] TaskCompleteUncomplete_TaskIsFullyCompleted_ResetItemData:dictToUse itemOccurrencesDict:itemOccurrencesDict keyArray:keyArray homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType topicDict:topicDict taskListDict:taskListDict allItemAssignedToArrays:allItemAssignedToArrays allItemTagsArrays:allItemTagsArrays userWhoIsBeingMarkedUserID:userWhoIsBeingMarkedUserID markingForSomeoneElse:markingForSomeoneElse currentViewController:currentViewController completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse, NSMutableDictionary *returningUpdatedTaskListDictToUse) {
                
                returningDictToUseLocal = [returningDictToUse mutableCopy];
                returningOccurrencesDictToUseLocal = [returningOccurrencesDictToUse mutableCopy];
                returningUpdatedTaskListDictToUseLocal = [returningUpdatedTaskListDictToUse mutableCopy];
                
                [[[CompleteUncompleteObject alloc] init] TaskCompleteUncomplete_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:returningDictToUseLocal itemOccurrencesDict:returningOccurrencesDictToUseLocal TaskIsFullyCompletedLocal:YES CallNSNotificationMethods:NO completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse, BOOL TaskIsFullyCompleted) {
                    
                    finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse, returningUpdatedTaskListDictToUseLocal, TaskIsFullyCompleted);
                    
                }];
                
            }];
            
        }];
        
        
//        /*
//         //
//         //
//         //Reset Item Data
//         //
//         //
//         */
//        [[[CompleteUncompleteObject alloc] init] TaskCompleteUncomplete_TaskIsFullyCompleted_ResetItemData:dictToUse itemOccurrencesDict:itemOccurrencesDict keyArray:keyArray homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType topicDict:topicDict taskListDict:taskListDict allItemAssignedToArrays:allItemAssignedToArrays allItemTagsArrays:allItemTagsArrays userWhoIsBeingMarkedUserID:userWhoIsBeingMarkedUserID markingForSomeoneElse:markingForSomeoneElse currentViewController:currentViewController completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse, NSMutableDictionary *returningUpdatedTaskListDictToUse) {
//            
//            returningDictToUseLocal = [returningDictToUse mutableCopy];
//            returningOccurrencesDictToUseLocal = [returningOccurrencesDictToUse mutableCopy];
//            returningUpdatedTaskListDictToUseLocal = [returningUpdatedTaskListDictToUse mutableCopy];
//            
//            [[[CompleteUncompleteObject alloc] init] TaskCompleteUncomplete_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:returningDictToUseLocal itemOccurrencesDict:returningOccurrencesDictToUseLocal TaskIsFullyCompletedLocal:YES CallNSNotificationMethods:NO completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse, BOOL TaskIsFullyCompleted) {
//                
//                finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse, returningUpdatedTaskListDictToUseLocal, TaskIsFullyCompleted);
//                
//            }];
//            
//        }];
        
    } else {
        
       
        /*
         //
         //
         //Reset Item Silent Notifications
         //
         //
         */
        [[[CompleteUncompleteObject alloc] init] TaskCompleteUncomplete_TaskIsFullyCompleted_ResetItemSilentNotifications:dictToUse itemOccurrencesDict:itemOccurrencesDict keyArray:keyArray homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType topicDict:topicDict allItemTagsArrays:allItemTagsArrays userWhoIsBeingMarkedUserID:userWhoIsBeingMarkedUserID markingForSomeoneElse:markingForSomeoneElse currentViewController:currentViewController completionHandler:^(BOOL finished) {
            
            [[[CompleteUncompleteObject alloc] init] TaskCompleteUncomplete_CompletionBlock:1 completedQueries:1 dictToUse:returningDictToUseLocal itemOccurrencesDict:returningOccurrencesDictToUseLocal TaskIsFullyCompletedLocal:YES CallNSNotificationMethods:NO completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse, BOOL TaskIsFullyCompleted) {
                
                finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse, returningUpdatedTaskListDictToUseLocal, TaskIsFullyCompleted);

            }];
            
        }];
        
    }
    
}

#pragma mark - TaskInProgressNotInProgress

-(void)TaskInProgressNotInProgress_SendPushNotifications:(NSMutableDictionary *)dictToUse homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType topicDict:(NSMutableDictionary *)topicDict allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays userWhoIsBeingMarkedUserID:(NSString *)userWhoIsBeingMarkedUserID markingForSomeoneElse:(BOOL)markingForSomeoneElse completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
        
        
        
        NSMutableDictionary *itemAssignedTo = dictToUse[@"ItemAssignedTo"] ? [dictToUse[@"ItemAssignedTo"] mutableCopy] : [NSMutableArray array];
        NSString *itemCreatedBy = dictToUse[@"ItemCreatedBy"] ? dictToUse[@"ItemCreatedBy"] : @"";
        
        
        
        NSMutableArray *usersToSendNotificationTo = [itemAssignedTo mutableCopy];
        
        NSArray *addTheseUsers = @[itemCreatedBy];
        NSArray *removeTheseUsers = @[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx"];
        
        usersToSendNotificationTo = [[[[NotificationsObject alloc] init] AddAndRemoveSpecificUsersFromArray:usersToSendNotificationTo addTheseUsers:addTheseUsers removeTheseUsers:removeTheseUsers] mutableCopy];
        
        
        
        NSMutableDictionary *notificationText = [[[CompleteUncompleteObject alloc] init] GenerateInProgressNotificationText:dictToUse userWhoIsBeingMarkedUserID:userWhoIsBeingMarkedUserID markingForSomeoneElse:markingForSomeoneElse];
        NSString *notificationTitle = notificationText && notificationText[@"Title"] ? notificationText[@"Title"] : @"";
        NSString *notificationBody = notificationText && notificationText[@"Body"] ? notificationText[@"Body"] : @"";
        
        
        
        [[[NotificationsObject alloc] init] SendPushNotificationToArrayOfUsers_Items:usersToSendNotificationTo
                                                                           dictToUse:dictToUse
                                                                              homeID:homeID homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict
                                                            notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType
                                                                           topicDict:topicDict
                                                               allItemTagsArrays:allItemTagsArrays
                                                               pushNotificationTitle:notificationTitle pushNotificationBody:notificationBody
                                                                   notificationTitle:notificationTitle notificationBody:notificationBody
                                                             SetDataHomeNotification:YES
                                                                RemoveUsersNotInHome:YES
                                                                   completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)TaskInProgressNotInProgress_UpdateItemData:(NSMutableDictionary *)dictToUse completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *itemType = [[[GeneralObject alloc] init] GenerateItemType];
    NSString *collection = [NSString stringWithFormat:@"%@s", itemType];
    
    NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
    
    NSString *itemID = dictToUse[@"ItemID"] ? dictToUse[@"ItemID"] : @"";
    NSString *itemOccurrenceID = dictToUse[@"ItemOccurrenceID"] ? dictToUse[@"ItemOccurrenceID"] : @"";
   
    NSMutableDictionary *itemCompletedDict = dictToUse[@"ItemCompletedDict"] ? [dictToUse[@"ItemCompletedDict"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemInProgressDict = dictToUse[@"ItemInProgressDict"] ? [dictToUse[@"ItemInProgressDict"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemWontDo = dictToUse[@"ItemWontDo"] ? [dictToUse[@"ItemWontDo"] mutableCopy] : [NSMutableDictionary dictionary];
    __block NSMutableDictionary *itemSubTasks = dictToUse[@"ItemSubTasks"] ? [dictToUse[@"ItemSubTasks"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemApprovalRequests  = dictToUse[@"ItemApprovalRequests"] ? [dictToUse[@"ItemApprovalRequests"] mutableCopy] : [NSMutableDictionary dictionary];
    
    itemCompletedDict = [[[GeneralObject alloc] init] GenerateDictWithoutEmptyKeys:[itemCompletedDict mutableCopy]] ? [[[[GeneralObject alloc] init] GenerateDictWithoutEmptyKeys:[itemCompletedDict mutableCopy]] mutableCopy] : [NSMutableDictionary dictionary];
    itemInProgressDict = [[[GeneralObject alloc] init] GenerateDictWithoutEmptyKeys:[itemInProgressDict mutableCopy]] ? [[[[GeneralObject alloc] init] GenerateDictWithoutEmptyKeys:[itemInProgressDict mutableCopy]] mutableCopy] : [NSMutableDictionary dictionary];
    itemWontDo = [[[GeneralObject alloc] init] GenerateDictWithoutEmptyKeys:[itemWontDo mutableCopy]] ? [[[[GeneralObject alloc] init] GenerateDictWithoutEmptyKeys:[itemWontDo mutableCopy]] mutableCopy] : [NSMutableDictionary dictionary];
    itemApprovalRequests = [[[GeneralObject alloc] init] GenerateDictWithoutEmptyKeys:[itemApprovalRequests mutableCopy]] ? [[[[GeneralObject alloc] init] GenerateDictWithoutEmptyKeys:[itemApprovalRequests mutableCopy]] mutableCopy] : [NSMutableDictionary dictionary];

    NSDictionary *dataDict = @{@"ItemCompletedDict" : itemCompletedDict ? itemCompletedDict : [NSMutableDictionary dictionary],
                               @"ItemInProgressDict" : itemInProgressDict ? itemInProgressDict : [NSMutableDictionary dictionary],
                               @"ItemWontDo" : itemWontDo ? itemWontDo : [NSMutableDictionary dictionary],
                               @"ItemSubTasks" : itemSubTasks ? itemSubTasks : [NSMutableDictionary dictionary],
                               @"ItemApprovalRequests" : itemApprovalRequests ? itemApprovalRequests : [NSMutableDictionary dictionary]};
   
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
    [[[SetDataObject alloc] init] UpdateDataEditItem:dataDict itemID:itemID itemOccurrenceID:itemOccurrenceID collection:collection homeID:homeID completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)TaskInProgressNotInProgress_SetItemAndHomeActivityData:(NSMutableDictionary *)dictToUse userWhoIsBeingMarkedUserID:(NSString *)userWhoIsBeingMarkedUserID completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *itemType = [[[GeneralObject alloc] init] GenerateItemType];
    
    NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
    
    NSString *itemID = dictToUse[@"ItemID"] ? dictToUse[@"ItemID"] : @"";
    NSString *itemOccurrenceID = dictToUse[@"ItemOccurrenceID"] ? dictToUse[@"ItemOccurrenceID"] : @"";
    NSString *itemName = dictToUse[@"ItemName"] ? dictToUse[@"ItemName"] : @"";
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        BOOL TaskIsInProgress = [[[CompleteUncompleteObject alloc] init] GenerateTaskIsBeingMarkedInProgress:dictToUse userWhoIsBeingMarkedUserID:userWhoIsBeingMarkedUserID];
        
        NSString *activityAction = [NSString stringWithFormat:@"%@ Task", TaskIsInProgress ? @"In Progress" : @"Not In Progress"];
        NSString *userTitle = [NSString stringWithFormat:@"%@ marked a %@ %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"], [itemType lowercaseString], TaskIsInProgress ? @"in progress" : @"not in progress"];
        NSString *itemTitle = [NSString stringWithFormat:@"%@ marked a %@ %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"], [itemType lowercaseString], TaskIsInProgress ? @"in progress" : @"not in progress"];
        NSString *itemDescription = [NSString stringWithFormat:@"\"%@\" was marked %@", itemName, TaskIsInProgress ? @"in progress" : @"not in progress"];
        NSString *activityUserIDNo1 = [userWhoIsBeingMarkedUserID isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] == NO ? userWhoIsBeingMarkedUserID : @"";
        
        NSMutableDictionary *itemActivityDict = [[[SetDataObject alloc] init] GenerateItemActivityDict:itemID itemOccurrenceID:itemOccurrenceID activityUserIDNo1:activityUserIDNo1 homeID:homeID activityAction:activityAction userTitle:userTitle userDescription:itemDescription itemType:itemType];
        NSMutableDictionary *homeActivityDict = [[[SetDataObject alloc] init] GenerateHomeActivityDict:activityUserIDNo1 homeID:homeID activityAction:activityAction itemTitle:itemTitle itemDescription:itemDescription itemType:itemType];
        
        [[[SetDataObject alloc] init] SetDataHomeAndItemActivity:itemActivityDict homeActivityDict:homeActivityDict completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)TaskInProgressNotInProgress_CompletionBlock:(int)totalQueries completedQueries:(int)completedQueries dictToUse:(NSMutableDictionary *)dictToUse itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict CallNSNotificationMethods:(BOOL)CallNSNotificationMethods completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse))finishBlock {
    
    if (totalQueries == completedQueries) {
        
        if (CallNSNotificationMethods == YES) {
            
            NSArray *locations = [[[NSUserDefaults standardUserDefaults] objectForKey:@"SelectOptionActionSelected"] isEqualToString:@"Yes"] ? @[@"Calendar"] : @[@"Tasks", @"Calendar"];
            
            [[[GeneralObject alloc] init] CallNSNotificationMethods:@"EditTask" userInfo:dictToUse locations:locations];
            
        }
        
        finishBlock(YES, dictToUse, itemOccurrencesDict);
        
    }
    
}

#pragma mark - TaskWillDoWontDo

-(void)TaskWillDoWontDo_SetItemAndHomeActivityData:(NSMutableDictionary *)dictToUse userWhoIsBeingMarkedUserID:(NSString *)userWhoIsBeingMarkedUserID completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *itemType = [[[GeneralObject alloc] init] GenerateItemType];
    
    NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
    
    NSString *itemID = dictToUse[@"ItemID"] ? dictToUse[@"ItemID"] : @"";
    NSString *itemOccurrenceID = dictToUse[@"ItemOccurrenceID"] ? dictToUse[@"ItemOccurrenceID"] : @"";
    NSString *itemName = dictToUse[@"ItemName"] ? dictToUse[@"ItemName"] : @"";
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        BOOL TaskIsWontDo = [[[CompleteUncompleteObject alloc] init] GenerateTaskIsBeingMarkedWontDo:dictToUse userWhoIsBeingMarkedUserID:userWhoIsBeingMarkedUserID];
        
        NSString *activityAction = [NSString stringWithFormat:@"%@ Task", TaskIsWontDo ? @"Won't Do" : @"Will Do"];
        NSString *userTitle = [NSString stringWithFormat:@"%@ %@ a %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"], TaskIsWontDo ? @"won't do" : @"will do", [itemType lowercaseString]];
        NSString *itemTitle = [NSString stringWithFormat:@"%@ %@ a %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"], TaskIsWontDo ? @"won't do" : @"will do", [itemType lowercaseString]];
        NSString *itemDescription = [NSString stringWithFormat:@"\"%@\" was marked %@", itemName, TaskIsWontDo ? @"won't do" : @"will do"];
        NSString *activityUserIDNo1 = [userWhoIsBeingMarkedUserID isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] == NO ? userWhoIsBeingMarkedUserID : @"";
        
        NSMutableDictionary *itemActivityDict = [[[SetDataObject alloc] init] GenerateItemActivityDict:itemID itemOccurrenceID:itemOccurrenceID activityUserIDNo1:activityUserIDNo1 homeID:homeID activityAction:activityAction userTitle:userTitle userDescription:itemDescription itemType:itemType];
        NSMutableDictionary *homeActivityDict = [[[SetDataObject alloc] init] GenerateHomeActivityDict:activityUserIDNo1 homeID:homeID activityAction:activityAction itemTitle:itemTitle itemDescription:itemDescription itemType:itemType];
        
        [[[SetDataObject alloc] init] SetDataHomeAndItemActivity:itemActivityDict homeActivityDict:homeActivityDict completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

#pragma mark - TaskIsFullyCompleted

-(void)TaskCompleteUncomplete_TaskIsFullyCompleted_SendPushNotifications:(NSMutableDictionary *)dictToUse itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict keyArray:(NSArray *)keyArray homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType topicDict:(NSMutableDictionary *)topicDict allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays userWhoIsBeingMarkedUserID:(NSString *)userWhoIsBeingMarkedUserID markingForSomeoneElse:(BOOL)markingForSomeoneElse currentViewController:(UIViewController *)currentViewController completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSMutableDictionary *notificationText = [[[CompleteUncompleteObject alloc] init] GenerateTaskFullCompletedNotificationText:dictToUse userWhoIsBeingMarkedUserID:userWhoIsBeingMarkedUserID homeMembersDict:homeMembersDict];
    
    NSString *notificationTitle = notificationText && notificationText[@"Title"] ? notificationText[@"Title"] : @"";
    NSString *notificationBody = notificationText && notificationText[@"Body"] ? notificationText[@"Body"] : @"";
    
    NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
    
   
    
    NSString *itemCreatedBy = dictToUse[@"ItemCreatedBy"] ? dictToUse[@"ItemCreatedBy"] : @"";
    NSMutableArray *itemAssignedTo = dictToUse[@"ItemAssignedTo"] ? [dictToUse[@"ItemAssignedTo"] mutableCopy] : [NSMutableArray array];
    
    [itemAssignedTo addObject:itemCreatedBy];
    
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[NotificationsObject alloc] init] SendPushNotificationToArrayOfUsers_Items:itemAssignedTo
                                                                           dictToUse:dictToUse
                                                                              homeID:homeID homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict
                                                            notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType
                                                                           topicDict:topicDict
                                                                allItemTagsArrays:allItemTagsArrays
                                                               pushNotificationTitle:notificationTitle pushNotificationBody:notificationBody
                                                                   notificationTitle:notificationTitle notificationBody:notificationBody
                                                             SetDataHomeNotification:YES
                                                                RemoveUsersNotInHome:YES
                                                                   completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
          
        }];
        
    });
    
}

-(void)TaskCompleteUncomplete_TaskIsFullyCompleted_ResetItemSilentNotifications:(NSMutableDictionary *)dictToUse itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict keyArray:(NSArray *)keyArray homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType topicDict:(NSMutableDictionary *)topicDict allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays userWhoIsBeingMarkedUserID:(NSString *)userWhoIsBeingMarkedUserID markingForSomeoneElse:(BOOL)markingForSomeoneElse currentViewController:(UIViewController *)currentViewController completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *itemType = [[[GeneralObject alloc] init] GenerateItemType];
    
    NSString *itemCreatedBy = dictToUse[@"ItemCreatedBy"] ? dictToUse[@"ItemCreatedBy"] : @"";
    NSMutableArray *itemAssignedTo = dictToUse[@"ItemAssignedTo"] ? dictToUse[@"ItemAssignedTo"] : [NSMutableArray array];
    
    NSMutableArray *userIDArray = [itemAssignedTo mutableCopy];
    NSMutableArray *userIDToRemoveArray = [NSMutableArray array];
    
    [userIDArray addObject:itemCreatedBy];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
        [[[NotificationsObject alloc] init] ResetLocalNotificationReminderNotification:dictToUse homeMembersDict:homeMembersDict userIDArray:userIDArray userIDToRemoveArray:userIDToRemoveArray notificationSettingsDict:notificationSettingsDict allItemTagsArrays:allItemTagsArrays itemType:itemType notificationType:notificationType topicDict:topicDict completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)TaskCompleteUncomplete_TaskIsFullyCompleted_ResetItemData:(NSMutableDictionary *)dictToUse itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict keyArray:(NSArray *)keyArray homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType topicDict:(NSMutableDictionary *)topicDict taskListDict:(NSMutableDictionary *)taskListDict allItemAssignedToArrays:(NSMutableArray * _Nullable)allItemAssignedToArrays allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays userWhoIsBeingMarkedUserID:(NSString *)userWhoIsBeingMarkedUserID markingForSomeoneElse:(BOOL)markingForSomeoneElse currentViewController:(UIViewController *)currentViewController completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse, NSMutableDictionary *returningUpdatedTaskListDictToUse))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        __block NSMutableDictionary *returningUpdatedTaskListDictLocal = [NSMutableDictionary dictionary];
        
        NSString *itemType = [[[GeneralObject alloc] init] GenerateItemType];
        
        NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
        
        BOOL TaskIsRepeating = [[[BoolDataObject alloc] init] TaskIsRepeating:dictToUse itemType:itemType];
        
        if (TaskIsRepeating == YES) {
            
            NSMutableDictionary *singleObjectDict = [[[GeneralObject alloc] init] GenerateSingleArraySingleObjectDictionary:dictToUse keyArray:keyArray indexPath:nil];
            
            [[[SetDataObject alloc] init] UpdateDataResetRepeatingTask:singleObjectDict itemOccurrencesDict:itemOccurrencesDict homeID:homeID itemType:itemType keyArray:keyArray homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict topicDict:topicDict taskListDict:taskListDict allItemAssignedToArrays:allItemAssignedToArrays allItemTagsArrays:allItemTagsArrays SkipOccurrence:NO completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningItemDict, NSMutableDictionary * _Nonnull returningItemOccurrencesDict, NSMutableDictionary * _Nonnull returningUpdatedTaskListDict) {
                
                returningUpdatedTaskListDictLocal = [returningUpdatedTaskListDict mutableCopy];
                
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                NSMutableDictionary *singleObjectDict = [[[GeneralObject alloc] init] GenerateSingleObjectDictionary:returningItemDict keyArray:keyArray indexPath:indexPath];
                
                for (NSString *key in [singleObjectDict allKeys]) {
                    [dictToUse setObject:singleObjectDict[key] forKey:key];
                }
                
                [[[GeneralObject alloc] init] CallNSNotificationMethods:@"CompletedReset" userInfo:nil locations:@[@"ViewTask"]];
                
                finishBlock(YES, dictToUse, returningItemOccurrencesDict, returningUpdatedTaskListDictLocal);
                
            }];
            
        } else {
            
            finishBlock(YES, dictToUse, itemOccurrencesDict, returningUpdatedTaskListDictLocal);
            
        }
        
    });
    
}

#pragma mark - Subtask
#pragma mark
#pragma mark
#pragma mark
#pragma mark
#pragma mark  SubtaskCompleteUncomplete

-(void)SubtaskCompleteUncomplete_SendPushNotifications:(NSMutableDictionary *)dictToUse homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType topicDict:(NSMutableDictionary *)topicDict allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays subtaskThatIsBeingMarked:(NSString *)subtaskThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSMutableArray *itemAssignedTo = [dictToUse[@"ItemAssignedTo"] mutableCopy];
    NSString *itemCreatedBy  = dictToUse[@"ItemCreatedBy"] ? dictToUse[@"ItemCreatedBy"] : @"";
    
    NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        
        
        NSMutableArray *usersToSendNotificationTo = [itemAssignedTo mutableCopy];
        NSArray *addTheseUsers = @[itemCreatedBy];
        NSArray *removeTheseUsers = @[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx"];
        usersToSendNotificationTo = [[[[NotificationsObject alloc] init] AddAndRemoveSpecificUsersFromArray:usersToSendNotificationTo addTheseUsers:addTheseUsers removeTheseUsers:removeTheseUsers] mutableCopy];
        
        
        
        NSMutableDictionary *notificationText = [[[CompleteUncompleteObject alloc] init] GenerateSubtaskCompletedNotificationText:dictToUse subtaskThatIsBeingMarked:subtaskThatIsBeingMarked markingForSomeoneElse:markingForSomeoneElse];
        NSString *notificationTitle = notificationText && notificationText[@"Title"] ? notificationText[@"Title"] : @"";
        NSString *notificationBody = notificationText && notificationText[@"Body"] ? notificationText[@"Body"] : @"";
        
        
        
        [[[NotificationsObject alloc] init] SendPushNotificationToArrayOfUsers_Items:usersToSendNotificationTo
                                                                           dictToUse:dictToUse
                                                                              homeID:homeID homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict
                                                            notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType
                                                                           topicDict:topicDict
                                                                allItemTagsArrays:allItemTagsArrays
                                                               pushNotificationTitle:notificationTitle pushNotificationBody:notificationBody
                                                                   notificationTitle:notificationTitle notificationBody:notificationBody
                                                             SetDataHomeNotification:YES
                                                                RemoveUsersNotInHome:YES
                                                                   completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)SubtaskCompleteUncomplete_SetItemAndHomeActivityData:(NSMutableDictionary *)dictToUse subtaskThatIsBeingMarked:(NSString *)subtaskThatIsBeingMarked completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *itemType = [[[GeneralObject alloc] init] GenerateItemType];
    
    NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
    
    NSString *itemID = dictToUse[@"ItemID"] ? dictToUse[@"ItemID"] : @"";
    NSString *itemOccurrenceID = dictToUse[@"ItemOccurrenceID"] ? dictToUse[@"ItemOccurrenceID"] : @"";
    NSString *itemName = dictToUse[@"ItemName"] ? dictToUse[@"ItemName"] : @"";
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        BOOL SubtaskIsBeingMarkedCompleted = [[[CompleteUncompleteObject alloc] init] GenerateSubtaskIsBeingMarkedCompleted:dictToUse subtaskThatIsBeingMarked:subtaskThatIsBeingMarked];
        
        NSString *activityAction = [NSString stringWithFormat:@"%@ Subtask", SubtaskIsBeingMarkedCompleted ? @"Completing" : @"Uncompleting"];
        NSString *userTitle = [NSString stringWithFormat:@"%@ %@ a subtask", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"], SubtaskIsBeingMarkedCompleted ? @"completed" : @"uncompleted"];
        NSString *itemTitle = [NSString stringWithFormat:@"%@ %@ a subtask", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"], SubtaskIsBeingMarkedCompleted ? @"completed" : @"uncompleted"];
        NSString *itemDescription = [NSString stringWithFormat:@"\"%@\"'s subtask, \"%@\", was marked %@", itemName, subtaskThatIsBeingMarked, SubtaskIsBeingMarkedCompleted ? @"completed" : @"uncompleted"];
        
        NSMutableDictionary *itemActivityDict = [[[SetDataObject alloc] init] GenerateItemActivityDict:itemID itemOccurrenceID:itemOccurrenceID activityUserIDNo1:@"" homeID:homeID activityAction:activityAction userTitle:userTitle userDescription:itemDescription itemType:itemType];
        NSMutableDictionary *homeActivityDict = [[[SetDataObject alloc] init] GenerateHomeActivityDict:@"" homeID:homeID activityAction:activityAction itemTitle:itemTitle itemDescription:itemDescription itemType:itemType];
        
        [[[SetDataObject alloc] init] SetDataHomeAndItemActivity:itemActivityDict homeActivityDict:homeActivityDict completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

#pragma mark - SubtaskInProgressNotInProgress

-(void)SubtaskInProgressNotInProgress_SendPushNotifications:(NSMutableDictionary *)dictToUse homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType topicDict:(NSMutableDictionary *)topicDict allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays subtaskThatIsBeingMarked:(NSString *)subtaskThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSMutableArray *itemAssignedTo = [dictToUse[@"ItemAssignedTo"] mutableCopy];
    NSString *itemCreatedBy  = dictToUse[@"ItemCreatedBy"] ? dictToUse[@"ItemCreatedBy"] : @"";
    
    NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        
        
        
        NSMutableArray *usersToSendNotificationTo = [itemAssignedTo mutableCopy];
        
        NSArray *addTheseUsers = @[itemCreatedBy];
        NSArray *removeTheseUsers = @[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx"];
        
        usersToSendNotificationTo = [[[[NotificationsObject alloc] init] AddAndRemoveSpecificUsersFromArray:usersToSendNotificationTo addTheseUsers:addTheseUsers removeTheseUsers:removeTheseUsers] mutableCopy];
        
        
        
        NSMutableDictionary *notificationText = [[[CompleteUncompleteObject alloc] init] GenerateSubtaskInProgressNotificationText:dictToUse subtaskThatIsBeingMarked:subtaskThatIsBeingMarked markingForSomeoneElse:markingForSomeoneElse];
        NSString *notificationTitle = notificationText && notificationText[@"Title"] ? notificationText[@"Title"] : @"";
        NSString *notificationBody = notificationText && notificationText[@"Body"] ? notificationText[@"Body"] : @"";
        
        
        
        [[[NotificationsObject alloc] init] SendPushNotificationToArrayOfUsers_Items:usersToSendNotificationTo
                                                                           dictToUse:dictToUse
                                                                              homeID:homeID homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict
                                                            notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType
                                                                           topicDict:topicDict
                                                                allItemTagsArrays:allItemTagsArrays
                                                               pushNotificationTitle:notificationTitle pushNotificationBody:notificationBody
                                                                   notificationTitle:notificationTitle notificationBody:notificationBody
                                                             SetDataHomeNotification:YES
                                                                RemoveUsersNotInHome:YES
                                                                   completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)SubtaskInProgressNotInProgress_SetItemAndHomeActivityData:(NSMutableDictionary *)dictToUse subtaskThatIsBeingMarked:(NSString *)subtaskThatIsBeingMarked completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *itemType = [[[GeneralObject alloc] init] GenerateItemType];
    
    NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
    
    NSString *itemID = dictToUse[@"ItemID"] ? dictToUse[@"ItemID"] : @"";
    NSString *itemOccurrenceID = dictToUse[@"ItemOccurrenceID"] ? dictToUse[@"ItemOccurrenceID"] : @"";
    NSString *itemName = dictToUse[@"ItemName"] ? dictToUse[@"ItemName"] : @"";
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        BOOL SubtaskIsBeingMarkedInProgress = [[[CompleteUncompleteObject alloc] init] GenerateSubtaskIsBeingMarkedInProgress:dictToUse subtaskThatIsBeingMarked:subtaskThatIsBeingMarked];
        
        NSString *activityAction = [NSString stringWithFormat:@"%@ Subtask", SubtaskIsBeingMarkedInProgress ? @"In Progress" : @"Not In Progress"];
        NSString *userTitle = [NSString stringWithFormat:@"%@ marked a subtask %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"], SubtaskIsBeingMarkedInProgress ? @"in progress" : @"not in progress"];
        NSString *itemTitle = [NSString stringWithFormat:@"%@ marked a subtask %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"], SubtaskIsBeingMarkedInProgress ? @"in progress" : @"not in progress"];
        NSString *itemDescription = [NSString stringWithFormat:@"\"%@\"'s subtask, \"%@\", was marked %@", itemName, subtaskThatIsBeingMarked, SubtaskIsBeingMarkedInProgress ? @"in progress" : @"not in progress"];
        
        NSMutableDictionary *itemActivityDict = [[[SetDataObject alloc] init] GenerateItemActivityDict:itemID itemOccurrenceID:itemOccurrenceID activityUserIDNo1:@"" homeID:homeID activityAction:activityAction userTitle:userTitle userDescription:itemDescription itemType:itemType];
        NSMutableDictionary *homeActivityDict = [[[SetDataObject alloc] init] GenerateHomeActivityDict:@"" homeID:homeID activityAction:activityAction itemTitle:itemTitle itemDescription:itemDescription itemType:itemType];
        
        [[[SetDataObject alloc] init] SetDataHomeAndItemActivity:itemActivityDict homeActivityDict:homeActivityDict completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

#pragma mark - SubtaskWillDoWontDo

-(void)SubtaskWillDoWontDo_SendPushNotifications:(NSMutableDictionary *)dictToUse homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType topicDict:(NSMutableDictionary *)topicDict allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays subtaskThatIsBeingMarked:(NSString *)subtaskThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSMutableArray *itemAssignedTo = [dictToUse[@"ItemAssignedTo"] mutableCopy];
    NSString *itemCreatedBy  = dictToUse[@"ItemCreatedBy"] ? dictToUse[@"ItemCreatedBy"] : @"";
    
    NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        
        
        NSMutableArray *usersToSendNotificationTo = [itemAssignedTo mutableCopy];
        NSArray *addTheseUsers = @[itemCreatedBy];
        NSArray *removeTheseUsers = @[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx"];
        usersToSendNotificationTo = [[[[NotificationsObject alloc] init] AddAndRemoveSpecificUsersFromArray:usersToSendNotificationTo addTheseUsers:addTheseUsers removeTheseUsers:removeTheseUsers] mutableCopy];
        
        
        
        NSMutableDictionary *notificationText = [[[CompleteUncompleteObject alloc] init] GenerateSubtaskWontDoNotificationText:dictToUse subtaskThatIsBeingMarked:subtaskThatIsBeingMarked markingForSomeoneElse:markingForSomeoneElse];
        NSString *notificationTitle = notificationText && notificationText[@"Title"] ? notificationText[@"Title"] : @"";
        NSString *notificationBody = notificationText && notificationText[@"Body"] ? notificationText[@"Body"] : @"";
        
        
        
        [[[NotificationsObject alloc] init] SendPushNotificationToArrayOfUsers_Items:usersToSendNotificationTo
                                                                           dictToUse:dictToUse
                                                                              homeID:homeID homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict
                                                            notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType
                                                                           topicDict:topicDict
                                                                allItemTagsArrays:allItemTagsArrays
                                                               pushNotificationTitle:notificationTitle pushNotificationBody:notificationBody
                                                                   notificationTitle:notificationTitle notificationBody:notificationBody
                                                             SetDataHomeNotification:YES
                                                                RemoveUsersNotInHome:YES
                                                                   completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)SubtaskWillDoWontDo_SetItemAndHomeActivityData:(NSMutableDictionary *)dictToUse subtaskThatIsBeingMarked:(NSString *)subtaskThatIsBeingMarked completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *itemType = [[[GeneralObject alloc] init] GenerateItemType];
    
    NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
    
    NSString *itemID = dictToUse[@"ItemID"] ? dictToUse[@"ItemID"] : @"";
    NSString *itemOccurrenceID = dictToUse[@"ItemOccurrenceID"] ? dictToUse[@"ItemOccurrenceID"] : @"";
    NSString *itemName = dictToUse[@"ItemName"] ? dictToUse[@"ItemName"] : @"";
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        BOOL SubtaskIsBeingMarkedWontDo = [[[CompleteUncompleteObject alloc] init] GenerateSubtaskIsBeingMarkedWontDo:dictToUse subtaskThatIsBeingMarked:subtaskThatIsBeingMarked];
        
        NSString *activityAction = [NSString stringWithFormat:@"%@ Subtask", SubtaskIsBeingMarkedWontDo ? @"Won't Do" : @"Will Do"];
        NSString *userTitle = [NSString stringWithFormat:@"%@ %@ a subtask", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"], SubtaskIsBeingMarkedWontDo ? @"won't do" : @"will do"];
        NSString *itemTitle = [NSString stringWithFormat:@"%@ %@ a subtask", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"], SubtaskIsBeingMarkedWontDo ? @"won't do" : @"will do"];
        NSString *itemDescription = [NSString stringWithFormat:@"\"%@\"'s subtask, \"%@\", was marked %@", itemName, subtaskThatIsBeingMarked, SubtaskIsBeingMarkedWontDo ? @"won't do" : @"will do"];
        
        NSMutableDictionary *itemActivityDict = [[[SetDataObject alloc] init] GenerateItemActivityDict:itemID itemOccurrenceID:itemOccurrenceID activityUserIDNo1:@"" homeID:homeID activityAction:activityAction userTitle:userTitle userDescription:itemDescription itemType:itemType];
        NSMutableDictionary *homeActivityDict = [[[SetDataObject alloc] init] GenerateHomeActivityDict:@"" homeID:homeID activityAction:activityAction itemTitle:itemTitle itemDescription:itemDescription itemType:itemType];
        
        [[[SetDataObject alloc] init] SetDataHomeAndItemActivity:itemActivityDict homeActivityDict:homeActivityDict completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

#pragma mark - List Items
#pragma mark
#pragma mark
#pragma mark
#pragma mark
#pragma mark  ListItemCompleteUncomplete

-(void)ListItemCompleteUncomplete_SendPushNotifications:(NSMutableDictionary *)dictToUse itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict keyArray:(NSArray *)keyArray homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType topicDict:(NSMutableDictionary *)topicDict allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays listItemThatIsBeingMarked:(NSString *)listItemThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse currentViewController:(UIViewController *)currentViewController completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
    
    
    
    
    
    
    BOOL ListItemIsBeingMarkedCompleted = [[[CompleteUncompleteObject alloc] init] GenerateListItemIsBeingMarkedCompleted:dictToUse listItemThatIsBeingMarked:listItemThatIsBeingMarked];
    
    [[[CompleteUncompleteObject alloc] init] IncreaseCountForCompletedItemCount:ListItemIsBeingMarkedCompleted];
    
    
    
    
    NSMutableDictionary *notificationText = [[[CompleteUncompleteObject alloc] init] GenerateListItemCompletedNotificationText:dictToUse listItemThatIsBeingMarked:listItemThatIsBeingMarked markingForSomeoneElse:markingForSomeoneElse];
    NSString *notificationTitle = notificationText && notificationText[@"Title"] ? notificationText[@"Title"] : @"";
    NSString *notificationBody = notificationText && notificationText[@"Body"] ? notificationText[@"Body"] : @"";
    

    
    NSString *itemCreatedBy = dictToUse[@"ItemCreatedBy"] ? dictToUse[@"ItemCreatedBy"] : @"";
    NSMutableArray *itemAssignedTo = dictToUse[@"ItemAssignedTo"] ? [dictToUse[@"ItemAssignedTo"] mutableCopy] : [NSMutableArray array];
    
    [itemAssignedTo addObject:itemCreatedBy];
    
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[NotificationsObject alloc] init] SendPushNotificationToArrayOfUsers_Items:itemAssignedTo
                                                                           dictToUse:dictToUse
                                                                              homeID:homeID homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict
                                                            notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType
                                                                           topicDict:topicDict
                                                                allItemTagsArrays:allItemTagsArrays
                                                               pushNotificationTitle:notificationTitle pushNotificationBody:notificationBody
                                                                   notificationTitle:notificationTitle notificationBody:notificationBody
                                                             SetDataHomeNotification:YES
                                                                RemoveUsersNotInHome:YES
                                                                   completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)ListItemCompleteUncomplete_UpdateItemData:(NSMutableDictionary *)dictToUse completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *itemType = [[[GeneralObject alloc] init] GenerateItemType];
    NSString *collection = [NSString stringWithFormat:@"%@s", itemType];
    
    NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
    
    NSString *itemID = dictToUse[@"ItemID"] ? dictToUse[@"ItemID"] : @"";
    NSString *itemOccurrenceID = dictToUse[@"ItemOccurrenceID"] ? dictToUse[@"ItemOccurrenceID"] : @"";
    NSMutableDictionary *itemCompletedDict = dictToUse[@"ItemCompletedDict"] ? [dictToUse[@"ItemCompletedDict"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemInProgressDict = dictToUse[@"ItemInProgressDict"] ? [dictToUse[@"ItemInProgressDict"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemWontDo = dictToUse[@"ItemWontDo"] ? [dictToUse[@"ItemWontDo"] mutableCopy] : [NSMutableDictionary dictionary];
    __block NSMutableDictionary *itemListItems = dictToUse[@"ItemListItems"] ? [dictToUse[@"ItemListItems"] mutableCopy] : [NSMutableDictionary dictionary];
    
    itemCompletedDict = [[[GeneralObject alloc] init] GenerateDictWithoutEmptyKeys:[itemCompletedDict mutableCopy]] ? [[[[GeneralObject alloc] init] GenerateDictWithoutEmptyKeys:[itemCompletedDict mutableCopy]] mutableCopy] : [NSMutableDictionary dictionary];
    itemInProgressDict = [[[GeneralObject alloc] init] GenerateDictWithoutEmptyKeys:[itemInProgressDict mutableCopy]] ? [[[[GeneralObject alloc] init] GenerateDictWithoutEmptyKeys:[itemInProgressDict mutableCopy]] mutableCopy] : [NSMutableDictionary dictionary];
    itemWontDo = [[[GeneralObject alloc] init] GenerateDictWithoutEmptyKeys:[itemWontDo mutableCopy]] ? [[[[GeneralObject alloc] init] GenerateDictWithoutEmptyKeys:[itemWontDo mutableCopy]] mutableCopy] : [NSMutableDictionary dictionary];
    itemListItems = [[[GeneralObject alloc] init] GenerateDictWithoutEmptyKeys:[itemListItems mutableCopy]] ? [[[[GeneralObject alloc] init] GenerateDictWithoutEmptyKeys:[itemListItems mutableCopy]] mutableCopy] : [NSMutableDictionary dictionary];
    
    NSDictionary *dataDict = @{@"ItemCompletedDict" : itemCompletedDict ? itemCompletedDict : [NSMutableDictionary dictionary],
                               @"ItemInProgressDict" : itemInProgressDict ? itemInProgressDict : [NSMutableDictionary dictionary],
                               @"ItemWontDo" : itemWontDo ? itemWontDo : [NSMutableDictionary dictionary],
                               @"ItemListItems" : itemListItems ? itemListItems : [NSMutableDictionary dictionary]};
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[SetDataObject alloc] init] UpdateDataEditItem:dataDict itemID:itemID itemOccurrenceID:itemOccurrenceID collection:collection homeID:homeID completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)ListItemCompleteUncomplete_SetItemAndHomeActivityData:(NSMutableDictionary *)dictToUse listItemThatIsBeingMarked:(NSString *)listItemThatIsBeingMarked completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *itemType = [[[GeneralObject alloc] init] GenerateItemType];
    
    NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
    
    NSString *itemID = dictToUse[@"ItemID"] ? dictToUse[@"ItemID"] : @"";
    NSString *itemOccurrenceID = dictToUse[@"ItemOccurrenceID"] ? dictToUse[@"ItemOccurrenceID"] : @"";
    NSString *itemName = dictToUse[@"ItemName"] ? dictToUse[@"ItemName"] : @"";
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        BOOL ListItemIsBeingMarkedCompleted = [[[CompleteUncompleteObject alloc] init] GenerateListItemIsBeingMarkedCompleted:dictToUse listItemThatIsBeingMarked:listItemThatIsBeingMarked];
        
        NSString *activityAction = [NSString stringWithFormat:@"%@ List Item", ListItemIsBeingMarkedCompleted ? @"Completing" : @"Uncompleting"];
        NSString *userTitle = [NSString stringWithFormat:@"%@ %@ a list item", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"], ListItemIsBeingMarkedCompleted ? @"completed" : @"uncompleted"];
        NSString *itemTitle = [NSString stringWithFormat:@"%@ %@ a list item", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"], ListItemIsBeingMarkedCompleted ? @"completed" : @"uncompleted"];
        NSString *itemDescription = [NSString stringWithFormat:@"\"%@\"'s list item, \"%@\", was marked %@", itemName, listItemThatIsBeingMarked, ListItemIsBeingMarkedCompleted ? @"completed" : @"uncompleted"];
        
        NSMutableDictionary *itemActivityDict = [[[SetDataObject alloc] init] GenerateItemActivityDict:itemID itemOccurrenceID:itemOccurrenceID activityUserIDNo1:@"" homeID:homeID activityAction:activityAction userTitle:userTitle userDescription:itemDescription itemType:itemType];
        NSMutableDictionary *homeActivityDict = [[[SetDataObject alloc] init] GenerateHomeActivityDict:@"" homeID:homeID activityAction:activityAction itemTitle:itemTitle itemDescription:itemDescription itemType:itemType];
        
        [[[SetDataObject alloc] init] SetDataHomeAndItemActivity:itemActivityDict homeActivityDict:homeActivityDict completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

#pragma mark

-(void)ListItemCompleteUncomplete_ListItemIsFullyCompleted:(NSMutableDictionary *)dictToUse itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict keyArray:(NSArray *)keyArray homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType topicDict:(NSMutableDictionary *)topicDict taskListDict:(NSMutableDictionary *)taskListDict allItemAssignedToArrays:(NSMutableArray * _Nullable)allItemAssignedToArrays allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays listItemThatIsBeingMarked:(NSString *)listItemThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse currentViewController:(UIViewController *)currentViewController completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse, NSMutableDictionary *returningUpdatedTaskListDictToUse))finishBlock {
    
    __block int totalQueries = 2;
    __block int completedQueries = 0;
    
    
    
    __block NSMutableDictionary *returningDictToUseLocal = [dictToUse mutableCopy];
    __block NSMutableDictionary *returningOccurrencesDictToUseLocal = [itemOccurrencesDict mutableCopy];
    __block NSMutableDictionary *returningUpdatedTaskListDictToUseLocal = [NSMutableDictionary dictionary];
    
    
    
    BOOL ListItemIsBeingMarkedCompleted = [[[CompleteUncompleteObject alloc] init] GenerateListItemIsBeingMarkedCompleted:dictToUse listItemThatIsBeingMarked:listItemThatIsBeingMarked];
    
    [[[CompleteUncompleteObject alloc] init] IncreaseCountForCompletedItemCount:ListItemIsBeingMarkedCompleted];
    
    
    
    NSString *itemType = [[[GeneralObject alloc] init] GenerateItemType];
    
    BOOL TaskIsFullyCompleted = [[[BoolDataObject alloc] init] TaskIsFullyCompleted:dictToUse itemType:itemType homeMembersDict:homeMembersDict];
    
    
    
    if (TaskIsFullyCompleted == YES) {
        
        
        /*
         //
         //
         //Send Push Notifications
         //
         //
         */
        [[[CompleteUncompleteObject alloc] init] ListItemCompleteUncomplete_ListIsFullyCompleted_SendPushNotifications:dictToUse keyArray:keyArray homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType topicDict:topicDict allItemTagsArrays:allItemTagsArrays listItemThatIsBeingMarked:listItemThatIsBeingMarked markingForSomeoneElse:markingForSomeoneElse currentViewController:currentViewController completionHandler:^(BOOL finished) {
            
            [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:returningDictToUseLocal itemOccurrencesDict:returningOccurrencesDictToUseLocal CallNSNotificationMethods:NO completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse) {
               
                finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse, returningUpdatedTaskListDictToUseLocal);
                
            }];
            
        }];
        
        
        /*
         //
         //
         //Reset Item Notifications
         //
         //
         */
        [[[CompleteUncompleteObject alloc] init] ListItemCompleteUncomplete_ListIsFullyCompleted_ResetItemNotifications:dictToUse itemOccurrencesDict:itemOccurrencesDict keyArray:keyArray homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType topicDict:topicDict allItemTagsArrays:allItemTagsArrays listItemThatIsBeingMarked:listItemThatIsBeingMarked markingForSomeoneElse:markingForSomeoneElse currentViewController:currentViewController completionHandler:^(BOOL finished) {
            
            
            /*
             //
             //
             //Reset Item Data
             //
             //
             */
            [[[CompleteUncompleteObject alloc] init] ListItemCompleteUncomplete_ListIsFullyCompleted_ResetItemData:dictToUse itemOccurrencesDict:itemOccurrencesDict keyArray:keyArray homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType topicDict:topicDict taskListDict:taskListDict allItemAssignedToArrays:allItemAssignedToArrays allItemTagsArrays:allItemTagsArrays listItemThatIsBeingMarked:listItemThatIsBeingMarked markingForSomeoneElse:markingForSomeoneElse currentViewController:currentViewController completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencecsDictToUse, NSMutableDictionary *returningUpdatedTaskListDictToUse) {
                
                returningDictToUseLocal = [returningDictToUse mutableCopy];
                returningOccurrencesDictToUseLocal = [returningOccurrencecsDictToUse mutableCopy];
                returningUpdatedTaskListDictToUseLocal = [returningUpdatedTaskListDictToUse mutableCopy];
                
                [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:returningDictToUseLocal itemOccurrencesDict:returningOccurrencesDictToUseLocal CallNSNotificationMethods:NO completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse) {
                    
                    finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse, returningUpdatedTaskListDictToUseLocal);
                    
                }];
                
            }];
            
        }];
        
        
//        /*
//         //
//         //
//         //Reset Item Data
//         //
//         //
//         */
//        [[[CompleteUncompleteObject alloc] init] ListItemCompleteUncomplete_ListIsFullyCompleted_ResetItemData:dictToUse itemOccurrencesDict:itemOccurrencesDict keyArray:keyArray homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType topicDict:topicDict taskListDict:taskListDict allItemAssignedToArrays:allItemAssignedToArrays allItemTagsArrays:allItemTagsArrays listItemThatIsBeingMarked:listItemThatIsBeingMarked markingForSomeoneElse:markingForSomeoneElse currentViewController:currentViewController completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencecsDictToUse, NSMutableDictionary *returningUpdatedTaskListDictToUse) {
//         
//            returningDictToUseLocal = [returningDictToUse mutableCopy];
//            returningOccurrencesDictToUseLocal = [returningOccurrencecsDictToUse mutableCopy];
//            returningUpdatedTaskListDictToUseLocal = [returningUpdatedTaskListDictToUse mutableCopy];
//            
//            [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:returningDictToUseLocal itemOccurrencesDict:returningOccurrencesDictToUseLocal CallNSNotificationMethods:NO completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse) {
//                
//                finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse, returningUpdatedTaskListDictToUseLocal);
//                
//            }];
//            
//        }];
        
        
        
    } else {
        
        totalQueries = 1;
        
        
        /*
         //
         //
         //Reset Item Notifications
         //
         //
         */
        [[[CompleteUncompleteObject alloc] init] ListItemCompleteUncomplete_ListIsFullyCompleted_ResetItemNotifications:dictToUse itemOccurrencesDict:itemOccurrencesDict keyArray:keyArray homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType topicDict:topicDict allItemTagsArrays:allItemTagsArrays listItemThatIsBeingMarked:listItemThatIsBeingMarked markingForSomeoneElse:markingForSomeoneElse currentViewController:currentViewController completionHandler:^(BOOL finished) {
            
            [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:returningDictToUseLocal itemOccurrencesDict:returningOccurrencesDictToUseLocal CallNSNotificationMethods:NO completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse) {
                
                finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse, returningUpdatedTaskListDictToUseLocal);
                
            }];
            
        }];
        
    }
    
}

#pragma mark - ListItemInProgressNotInProgress

-(void)ListItemInProgressNotInProgress_SendPushNotifications:(NSMutableDictionary *)dictToUse keyArray:(NSArray *)keyArray homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType topicDict:(NSMutableDictionary *)topicDict allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays listItemThatIsBeingMarked:(NSString *)listItemThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse currentViewController:(UIViewController *)currentViewController completionHandler:(void (^)(BOOL finished))finishBlock {
    
    
    NSMutableDictionary *itemAssignedTo = dictToUse[@"ItemAssignedTo"] ? [dictToUse[@"ItemAssignedTo"] mutableCopy] : [NSMutableArray array];
    NSString *itemCreatedBy = dictToUse[@"ItemCreatedBy"] ? dictToUse[@"ItemCreatedBy"] : @"";
    
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        
        
        NSMutableDictionary *notificationText = [[[CompleteUncompleteObject alloc] init] GenerateListItemInProgressNotificationText:dictToUse listItemThatIsBeingMarked:listItemThatIsBeingMarked markingForSomeoneElse:markingForSomeoneElse];
        NSString *notificationTitle = notificationText && notificationText[@"Title"] ? notificationText[@"Title"] : @"";
        NSString *notificationBody = notificationText && notificationText[@"Body"] ? notificationText[@"Body"] : @"";
        
        
        
        NSMutableArray *usersToSendNotificationTo = [itemAssignedTo mutableCopy];
        
        NSArray *addTheseUsers = @[itemCreatedBy];
        NSArray *removeTheseUsers = @[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx"];
        
        usersToSendNotificationTo = [[[[NotificationsObject alloc] init] AddAndRemoveSpecificUsersFromArray:usersToSendNotificationTo addTheseUsers:addTheseUsers removeTheseUsers:removeTheseUsers] mutableCopy];
        
        
        
        NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
        
        [[[NotificationsObject alloc] init] SendPushNotificationToArrayOfUsers_Items:usersToSendNotificationTo
                                                                           dictToUse:dictToUse
                                                                              homeID:homeID homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict
                                                            notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType
                                                                           topicDict:topicDict
                                                                allItemTagsArrays:allItemTagsArrays
                                                               pushNotificationTitle:notificationTitle pushNotificationBody:notificationBody
                                                                   notificationTitle:notificationTitle notificationBody:notificationBody
                                                             SetDataHomeNotification:YES
                                                                RemoveUsersNotInHome:YES
                                                                   completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)ListItemInProgressNotInProgress_SetItemAndHomeActivityData:(NSMutableDictionary *)dictToUse listItemThatIsBeingMarked:(NSString *)listItemThatIsBeingMarked completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *itemType = [[[GeneralObject alloc] init] GenerateItemType];
    
    NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
    
    NSString *itemID = dictToUse[@"ItemID"] ? dictToUse[@"ItemID"] : @"";
    NSString *itemOccurrenceID = dictToUse[@"ItemOccurrenceID"] ? dictToUse[@"ItemOccurrenceID"] : @"";
    NSString *itemName = dictToUse[@"ItemName"] ? dictToUse[@"ItemName"] : @"";
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        BOOL ListItemIsBeingMarkedInProgress = [[[CompleteUncompleteObject alloc] init] GenerateListItemIsBeingMarkedInProgress:dictToUse listItemThatIsBeingMarked:listItemThatIsBeingMarked];
        
        NSString *activityAction = [NSString stringWithFormat:@"%@ List Item", ListItemIsBeingMarkedInProgress ? @"In Progress" : @"Not In Progress"];
        NSString *userTitle = [NSString stringWithFormat:@"%@ marked a list item %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"], ListItemIsBeingMarkedInProgress ? @"in progress" : @"not in progress"];
        NSString *itemTitle = [NSString stringWithFormat:@"%@ marked a list item %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"], ListItemIsBeingMarkedInProgress ? @"in progress" : @"not in progress"];
        NSString *itemDescription = [NSString stringWithFormat:@"\"%@\"'s list item, \"%@\", was marked %@", itemName, listItemThatIsBeingMarked, ListItemIsBeingMarkedInProgress ? @"in progress" : @"not in progress"];
        
        NSMutableDictionary *itemActivityDict = [[[SetDataObject alloc] init] GenerateItemActivityDict:itemID itemOccurrenceID:itemOccurrenceID activityUserIDNo1:@"" homeID:homeID activityAction:activityAction userTitle:userTitle userDescription:itemDescription itemType:itemType];
        NSMutableDictionary *homeActivityDict = [[[SetDataObject alloc] init] GenerateHomeActivityDict:@"" homeID:homeID activityAction:activityAction itemTitle:itemTitle itemDescription:itemDescription itemType:itemType];
        
        [[[SetDataObject alloc] init] SetDataHomeAndItemActivity:itemActivityDict homeActivityDict:homeActivityDict completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

#pragma mark - ListItemWillDoWontDo

-(void)ListItemWillDoWontDo_SendPushNotifications:(NSMutableDictionary *)dictToUse keyArray:(NSArray *)keyArray homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType topicDict:(NSMutableDictionary *)topicDict allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays listItemThatIsBeingMarked:(NSString *)listItemThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse currentViewController:(UIViewController *)currentViewController completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSMutableDictionary *itemAssignedTo = dictToUse[@"ItemAssignedTo"] ? [dictToUse[@"ItemAssignedTo"] mutableCopy] : [NSMutableArray array];
    NSString *itemCreatedBy = dictToUse[@"ItemCreatedBy"] ? dictToUse[@"ItemCreatedBy"] : @"";
    
    
    
    NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        
        
        NSMutableDictionary *notificationText = [[[CompleteUncompleteObject alloc] init] GenerateListItemWontDoNotificationText:dictToUse listItemThatIsBeingMarked:listItemThatIsBeingMarked markingForSomeoneElse:markingForSomeoneElse];
        NSString *notificationTitle = notificationText && notificationText[@"Title"] ? notificationText[@"Title"] : @"";
        NSString *notificationBody = notificationText && notificationText[@"Body"] ? notificationText[@"Body"] : @"";
        
        
        
        NSMutableArray *usersToSendNotificationTo = [itemAssignedTo mutableCopy];
        
        NSArray *addTheseUsers = @[itemCreatedBy];
        NSArray *removeTheseUsers = @[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx"];
        
        usersToSendNotificationTo = [[[[NotificationsObject alloc] init] AddAndRemoveSpecificUsersFromArray:usersToSendNotificationTo addTheseUsers:addTheseUsers removeTheseUsers:removeTheseUsers] mutableCopy];
        
        
        
        [[[NotificationsObject alloc] init] SendPushNotificationToArrayOfUsers_Items:usersToSendNotificationTo dictToUse:dictToUse
                                                                              homeID:homeID homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict
                                                            notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType
                                                                           topicDict:topicDict
                                                                allItemTagsArrays:allItemTagsArrays
                                                               pushNotificationTitle:notificationTitle pushNotificationBody:notificationBody
                                                                   notificationTitle:notificationTitle notificationBody:notificationBody
                                                             SetDataHomeNotification:YES
                                                                RemoveUsersNotInHome:YES
                                                                   completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)ListItemWillDoWontDo_SetItemAndHomeActivityData:(NSMutableDictionary *)dictToUse listItemThatIsBeingMarked:(NSString *)listItemThatIsBeingMarked completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *itemType = [[[GeneralObject alloc] init] GenerateItemType];
    
    NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
    
    NSString *itemID = dictToUse[@"ItemID"] ? dictToUse[@"ItemID"] : @"";
    NSString *itemOccurrenceID = dictToUse[@"ItemOccurrenceID"] ? dictToUse[@"ItemOccurrenceID"] : @"";
    NSString *itemName = dictToUse[@"ItemName"] ? dictToUse[@"ItemName"] : @"";
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        BOOL ListItemIsBeingMarkedWontDo = [[[CompleteUncompleteObject alloc] init] GenerateListItemIsBeingMarkedWontDo:dictToUse listItemThatIsBeingMarked:listItemThatIsBeingMarked];
        
        NSString *activityAction = [NSString stringWithFormat:@"%@ List Item", ListItemIsBeingMarkedWontDo ? @"Won't Do" : @"Will Do"];
        NSString *userTitle = [NSString stringWithFormat:@"%@ %@ a list item", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"], ListItemIsBeingMarkedWontDo ? @"won't do" : @"will do"];
        NSString *itemTitle = [NSString stringWithFormat:@"%@ %@ a list item", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"], ListItemIsBeingMarkedWontDo ? @"won't do" : @"will do"];
        NSString *itemDescription = [NSString stringWithFormat:@"\"%@\"'s list item, \"%@\", was marked %@", itemName, listItemThatIsBeingMarked, ListItemIsBeingMarkedWontDo ? @"won't do" : @"will do"];
        
        NSMutableDictionary *itemActivityDict = [[[SetDataObject alloc] init] GenerateItemActivityDict:itemID itemOccurrenceID:itemOccurrenceID activityUserIDNo1:@"" homeID:homeID activityAction:activityAction userTitle:userTitle userDescription:itemDescription itemType:itemType];
        NSMutableDictionary *homeActivityDict = [[[SetDataObject alloc] init] GenerateHomeActivityDict:@"" homeID:homeID activityAction:activityAction itemTitle:itemTitle itemDescription:itemDescription itemType:itemType];
        
        [[[SetDataObject alloc] init] SetDataHomeAndItemActivity:itemActivityDict homeActivityDict:homeActivityDict completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

#pragma mark - ListItemFullyCompleted

-(void)ListItemCompleteUncomplete_ListIsFullyCompleted_SendPushNotifications:(NSMutableDictionary *)dictToUse keyArray:(NSArray *)keyArray homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType topicDict:(NSMutableDictionary *)topicDict allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays listItemThatIsBeingMarked:(NSString *)listItemThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse currentViewController:(UIViewController *)currentViewController completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSMutableDictionary *notificationText = [[[CompleteUncompleteObject alloc] init] GenerateListItemFullCompletedNotificationText:dictToUse listItemThatIsBeingMarked:listItemThatIsBeingMarked homeMembersDict:homeMembersDict];
    NSString *notificationTitle = notificationText && notificationText[@"Title"] ? notificationText[@"Title"] : @"";
    NSString *notificationBody = notificationText && notificationText[@"Body"] ? notificationText[@"Body"] : @"";
    
    NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
    
    
    
    NSString *itemCreatedBy = dictToUse[@"ItemCreatedBy"] ? dictToUse[@"ItemCreatedBy"] : @"";
    NSMutableArray *itemAssignedTo = dictToUse[@"ItemAssignedTo"] ? [dictToUse[@"ItemAssignedTo"] mutableCopy] : [NSMutableArray array];
    
    [itemAssignedTo addObject:itemCreatedBy];
    
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[NotificationsObject alloc] init] SendPushNotificationToArrayOfUsers_Items:itemAssignedTo
                                                                           dictToUse:dictToUse
                                                                              homeID:homeID homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict
                                                            notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType
                                                                           topicDict:topicDict
                                                                allItemTagsArrays:allItemTagsArrays
                                                               pushNotificationTitle:notificationTitle pushNotificationBody:notificationBody
                                                                   notificationTitle:notificationTitle notificationBody:notificationBody
                                                             SetDataHomeNotification:YES
                                                                RemoveUsersNotInHome:YES
                                                                   completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)ListItemCompleteUncomplete_ListIsFullyCompleted_ResetItemNotifications:(NSMutableDictionary *)dictToUse itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict keyArray:(NSArray *)keyArray homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType topicDict:(NSMutableDictionary *)topicDict allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays listItemThatIsBeingMarked:(NSString *)listItemThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse currentViewController:(UIViewController *)currentViewController completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *itemType = [[[GeneralObject alloc] init] GenerateItemType];
    
    NSString *itemCreatedBy = dictToUse[@"ItemCreatedBy"] ? dictToUse[@"ItemCreatedBy"] : @"";
    NSMutableArray *itemAssignedTo = dictToUse[@"ItemAssignedTo"] ? dictToUse[@"ItemAssignedTo"] : [NSMutableArray array];
    
    NSMutableArray *userIDArray = [itemAssignedTo mutableCopy];
    NSMutableArray *userIDToRemoveArray = [NSMutableArray array];
    
    [userIDArray addObject:itemCreatedBy];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[NotificationsObject alloc] init] ResetLocalNotificationReminderNotification:dictToUse homeMembersDict:homeMembersDict userIDArray:userIDArray userIDToRemoveArray:userIDToRemoveArray notificationSettingsDict:notificationSettingsDict allItemTagsArrays:allItemTagsArrays itemType:itemType notificationType:notificationType topicDict:topicDict completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)ListItemCompleteUncomplete_ListIsFullyCompleted_ResetItemData:(NSMutableDictionary *)dictToUse itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict keyArray:(NSArray *)keyArray homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType topicDict:(NSMutableDictionary *)topicDict taskListDict:(NSMutableDictionary *)taskListDict allItemAssignedToArrays:(NSMutableArray * _Nullable)allItemAssignedToArrays allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays listItemThatIsBeingMarked:(NSString *)listItemThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse currentViewController:(UIViewController *)currentViewController completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencecsDictToUse, NSMutableDictionary *returningUpdatedTaskListDictToUse))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        __block NSMutableDictionary *returningUpdatedTaskListDictLocal = [NSMutableDictionary dictionary];
        
        NSString *itemType = [[[GeneralObject alloc] init] GenerateItemType];
        
        NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
        
        BOOL TaskIsRepeating = [[[BoolDataObject alloc] init] TaskIsRepeating:dictToUse itemType:itemType];
        
        if (TaskIsRepeating == YES) {
            
            NSMutableDictionary *singleObjectDict = [[[GeneralObject alloc] init] GenerateSingleArraySingleObjectDictionary:dictToUse keyArray:keyArray indexPath:nil];
            
            [[[SetDataObject alloc] init] UpdateDataResetRepeatingTask:singleObjectDict itemOccurrencesDict:itemOccurrencesDict homeID:homeID itemType:itemType keyArray:keyArray homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict topicDict:topicDict taskListDict:taskListDict allItemAssignedToArrays:allItemAssignedToArrays allItemTagsArrays:allItemTagsArrays SkipOccurrence:NO completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningItemDict, NSMutableDictionary *returningItemOccurrencesDict, NSMutableDictionary * _Nonnull returningUpdatedTaskListDict) {
                
                returningUpdatedTaskListDictLocal = [returningUpdatedTaskListDict mutableCopy];
                
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                NSMutableDictionary *singleObjectDict = [[[GeneralObject alloc] init] GenerateSingleObjectDictionary:returningItemDict keyArray:keyArray indexPath:indexPath];
                
                for (NSString *key in [singleObjectDict allKeys]) {
                    [dictToUse setObject:singleObjectDict[key] forKey:key];
                }
               
                [[[GeneralObject alloc] init] CallNSNotificationMethods:@"CompletedReset" userInfo:nil locations:@[@"ViewTask"]];
                
                finishBlock(YES, dictToUse, returningItemOccurrencesDict, returningUpdatedTaskListDictLocal);
                
            }];
            
        } else {
            
            finishBlock(YES, dictToUse, itemOccurrencesDict, returningUpdatedTaskListDictLocal);
            
        }
        
    });
    
}

#pragma mark - Itemized Items
#pragma mark
#pragma mark
#pragma mark
#pragma mark
#pragma mark ItemizedItemCompleteUncomplete

-(void)ItemizedItemCompleteUncomplete_SendPushNotifications:(NSMutableDictionary *)dictToUse itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict keyArray:(NSArray *)keyArray homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType topicDict:(NSMutableDictionary *)topicDict allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays itemizedItemThatIsBeingMarked:(NSString *)itemizedItemThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse currentViewController:(UIViewController *)currentViewController completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
    
    
    
    
    
    
    BOOL ItemizedItemIsBeingMarkedCompleted = [[[CompleteUncompleteObject alloc] init] GenerateItemizedItemIsBeingMarkedCompleted:dictToUse itemizedItemThatIsBeingMarked:itemizedItemThatIsBeingMarked];
    
    [[[CompleteUncompleteObject alloc] init] IncreaseCountForCompletedItemCount:ItemizedItemIsBeingMarkedCompleted];
    
    
    
    
    NSMutableDictionary *notificationText = [[[CompleteUncompleteObject alloc] init] GenerateItemizedItemCompletedNotificationText:dictToUse itemizedItemThatIsBeingMarked:itemizedItemThatIsBeingMarked markingForSomeoneElse:markingForSomeoneElse];
    NSString *notificationTitle = notificationText && notificationText[@"Title"] ? notificationText[@"Title"] : @"";
    NSString *notificationBody = notificationText && notificationText[@"Body"] ? notificationText[@"Body"] : @"";
    
    
    
    NSString *itemCreatedBy = dictToUse[@"ItemCreatedBy"] ? dictToUse[@"ItemCreatedBy"] : @"";
    NSMutableArray *itemAssignedTo = dictToUse[@"ItemAssignedTo"] ? [dictToUse[@"ItemAssignedTo"] mutableCopy] : [NSMutableArray array];
    
    [itemAssignedTo addObject:itemCreatedBy];
    
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[NotificationsObject alloc] init] SendPushNotificationToArrayOfUsers_Items:itemAssignedTo
                                                                           dictToUse:dictToUse
                                                                              homeID:homeID homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict
                                                            notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType
                                                                           topicDict:topicDict
                                                                allItemTagsArrays:allItemTagsArrays
                                                               pushNotificationTitle:notificationTitle pushNotificationBody:notificationBody
                                                                   notificationTitle:notificationTitle notificationBody:notificationBody
                                                             SetDataHomeNotification:YES
                                                                RemoveUsersNotInHome:YES
                                                                   completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)ItemizedItemCompleteUncomplete_UpdateItemData:(NSMutableDictionary *)dictToUse completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *itemType = [[[GeneralObject alloc] init] GenerateItemType];
    NSString *collection = [NSString stringWithFormat:@"%@s", itemType];
    
    NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
    
    NSString *itemID = dictToUse[@"ItemID"] ? dictToUse[@"ItemID"] : @"";
    NSString *itemOccurrenceID = dictToUse[@"ItemOccurrenceID"] ? dictToUse[@"ItemOccurrenceID"] : @"";
    NSMutableDictionary *itemCompletedDict = dictToUse[@"ItemCompletedDict"] ? [dictToUse[@"ItemCompletedDict"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemInProgressDict = dictToUse[@"ItemInProgressDict"] ? [dictToUse[@"ItemInProgressDict"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemWontDo = dictToUse[@"ItemWontDo"] ? [dictToUse[@"ItemWontDo"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemItemizedItems = dictToUse[@"ItemItemizedItems"] ? [dictToUse[@"ItemItemizedItems"] mutableCopy] : [NSMutableDictionary dictionary];
    
    itemCompletedDict = [[[GeneralObject alloc] init] GenerateDictWithoutEmptyKeys:[itemCompletedDict mutableCopy]] ? [[[[GeneralObject alloc] init] GenerateDictWithoutEmptyKeys:[itemCompletedDict mutableCopy]] mutableCopy] : [NSMutableDictionary dictionary];
    itemInProgressDict = [[[GeneralObject alloc] init] GenerateDictWithoutEmptyKeys:[itemInProgressDict mutableCopy]] ? [[[[GeneralObject alloc] init] GenerateDictWithoutEmptyKeys:[itemInProgressDict mutableCopy]] mutableCopy] : [NSMutableDictionary dictionary];
    itemWontDo = [[[GeneralObject alloc] init] GenerateDictWithoutEmptyKeys:[itemWontDo mutableCopy]] ? [[[[GeneralObject alloc] init] GenerateDictWithoutEmptyKeys:[itemWontDo mutableCopy]] mutableCopy] : [NSMutableDictionary dictionary];
    itemItemizedItems = [[[GeneralObject alloc] init] GenerateDictWithoutEmptyKeys:[itemItemizedItems mutableCopy]] ? [[[[GeneralObject alloc] init] GenerateDictWithoutEmptyKeys:[itemItemizedItems mutableCopy]] mutableCopy] : [NSMutableDictionary dictionary];
    
    NSDictionary *dataDict = @{@"ItemCompletedDict" : itemCompletedDict ? itemCompletedDict : [NSMutableDictionary dictionary],
                               @"ItemInProgressDict" : itemInProgressDict ? itemInProgressDict : [NSMutableDictionary dictionary],
                               @"ItemWontDo" : itemWontDo ? itemWontDo : [NSMutableDictionary dictionary],
                               @"ItemItemizedItems" : itemItemizedItems ? itemItemizedItems : [NSMutableDictionary dictionary]};
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[SetDataObject alloc] init] UpdateDataEditItem:dataDict itemID:itemID itemOccurrenceID:itemOccurrenceID collection:collection homeID:homeID completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)ItemizedItemCompleteUncomplete_SetItemAndHomeActivityData:(NSMutableDictionary *)dictToUse itemizedItemThatIsBeingMarked:(NSString *)itemizedItemThatIsBeingMarked completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *itemType = [[[GeneralObject alloc] init] GenerateItemType];
    
    NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
    
    NSString *itemID = dictToUse[@"ItemID"] ? dictToUse[@"ItemID"] : @"";
    NSString *itemOccurrenceID = dictToUse[@"ItemOccurrenceID"] ? dictToUse[@"ItemOccurrenceID"] : @"";
    NSString *itemName = dictToUse[@"ItemName"] ? dictToUse[@"ItemName"] : @"";
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        BOOL ItemizedItemIsBeingMarkedCompleted = [[[CompleteUncompleteObject alloc] init] GenerateItemizedItemIsBeingMarkedCompleted:dictToUse itemizedItemThatIsBeingMarked:itemizedItemThatIsBeingMarked];
        
        NSString *activityAction = [NSString stringWithFormat:@"%@ Itemized Item", ItemizedItemIsBeingMarkedCompleted ? @"Completing" : @"Uncompleting"];
        NSString *userTitle = [NSString stringWithFormat:@"%@ %@ a itemized item", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"], ItemizedItemIsBeingMarkedCompleted ? @"completed" : @"uncompleted"];
        NSString *itemTitle = [NSString stringWithFormat:@"%@ %@ a itemized item", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"], ItemizedItemIsBeingMarkedCompleted ? @"completed" : @"uncompleted"];
        NSString *itemDescription = [NSString stringWithFormat:@"\"%@\"'s itemized item, \"%@\", was marked %@", itemName, itemizedItemThatIsBeingMarked, ItemizedItemIsBeingMarkedCompleted ? @"completed" : @"uncompleted"];
        
        NSMutableDictionary *itemActivityDict = [[[SetDataObject alloc] init] GenerateItemActivityDict:itemID itemOccurrenceID:itemOccurrenceID activityUserIDNo1:@"" homeID:homeID activityAction:activityAction userTitle:userTitle userDescription:itemDescription itemType:itemType];
        NSMutableDictionary *homeActivityDict = [[[SetDataObject alloc] init] GenerateHomeActivityDict:@"" homeID:homeID activityAction:activityAction itemTitle:itemTitle itemDescription:itemDescription itemType:itemType];
        
        [[[SetDataObject alloc] init] SetDataHomeAndItemActivity:itemActivityDict homeActivityDict:homeActivityDict completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

#pragma mark

-(void)ItemizedItemCompleteUncomplete_ItemizedItemIsFullyCompleted:(NSMutableDictionary *)dictToUse itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict keyArray:(NSArray *)keyArray homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType topicDict:(NSMutableDictionary *)topicDict taskListDict:(NSMutableDictionary *)taskListDict allItemAssignedToArrays:(NSMutableArray * _Nullable)allItemAssignedToArrays allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays itemizedItemThatIsBeingMarked:(NSString *)itemizedItemThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse currentViewController:(UIViewController *)currentViewController completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse, NSMutableDictionary *returningUpdatedTaskListDictToUse))finishBlock {
    
    __block int totalQueries = 2;
    __block int completedQueries = 0;
    
    
    
    __block NSMutableDictionary *returningDictToUseLocal = [dictToUse mutableCopy];
    __block NSMutableDictionary *returningOccurrencesDictToUseLocal = [itemOccurrencesDict mutableCopy];
    __block NSMutableDictionary *returningUpdatedTaskListDictToUseLocal = [NSMutableDictionary dictionary];
    
    
    
    BOOL ItemizedItemIsBeingMarkedCompleted = [[[CompleteUncompleteObject alloc] init] GenerateItemizedItemIsBeingMarkedCompleted:dictToUse itemizedItemThatIsBeingMarked:itemizedItemThatIsBeingMarked];
    
    [[[CompleteUncompleteObject alloc] init] IncreaseCountForCompletedItemCount:ItemizedItemIsBeingMarkedCompleted];
    
    
    
    NSString *itemType = [[[GeneralObject alloc] init] GenerateItemType];
    
    BOOL TaskIsFullyCompleted = [[[BoolDataObject alloc] init] TaskIsFullyCompleted:dictToUse itemType:itemType homeMembersDict:homeMembersDict];
    
    
    
    if (TaskIsFullyCompleted == YES) {
    
        
        /*
         //
         //
         //Send Push Notifications
         //
         //
         */
        [[[CompleteUncompleteObject alloc] init] ItemizedItemCompleteUncomplete_ItemizedIsFullyCompleted_SendPushNotifications:dictToUse keyArray:keyArray homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType topicDict:topicDict allItemTagsArrays:allItemTagsArrays itemizedItemThatIsBeingMarked:itemizedItemThatIsBeingMarked markingForSomeoneElse:markingForSomeoneElse currentViewController:currentViewController completionHandler:^(BOOL finished) {
            
            [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:returningDictToUseLocal itemOccurrencesDict:returningOccurrencesDictToUseLocal CallNSNotificationMethods:NO completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse) {
                
                finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse, returningUpdatedTaskListDictToUseLocal);
                
            }];
            
        }];
        
        
        /*
         //
         //
         //Reset Item Notifications
         //
         //
         */
        [[[CompleteUncompleteObject alloc] init] ItemizedItemCompleteUncomplete_ItemizedIsFullyCompleted_ResetItemNotifications:dictToUse itemOccurrencesDict:itemOccurrencesDict keyArray:keyArray homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType topicDict:topicDict allItemTagsArrays:allItemTagsArrays itemizedItemThatIsBeingMarked:itemizedItemThatIsBeingMarked markingForSomeoneElse:markingForSomeoneElse currentViewController:currentViewController completionHandler:^(BOOL finished) {
            
            /*
             //
             //
             //Reset Item Data
             //
             //
             */
            [[[CompleteUncompleteObject alloc] init] ItemizedItemCompleteUncomplete_ItemizedIsFullyCompleted_ResetItemData:dictToUse itemOccurrencesDict:itemOccurrencesDict keyArray:keyArray homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType topicDict:topicDict taskListDict:taskListDict allItemAssignedToArrays:allItemAssignedToArrays allItemTagsArrays:allItemTagsArrays itemizedItemThatIsBeingMarked:itemizedItemThatIsBeingMarked markingForSomeoneElse:markingForSomeoneElse currentViewController:currentViewController completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencecsDictToUse, NSMutableDictionary *returningUpdatedTaskListDictToUse) {
                
                returningDictToUseLocal = [returningDictToUse mutableCopy];
                returningOccurrencesDictToUseLocal = [returningOccurrencecsDictToUse mutableCopy];
                returningUpdatedTaskListDictToUseLocal = [returningUpdatedTaskListDictToUse mutableCopy];
                
                [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:returningDictToUseLocal itemOccurrencesDict:returningOccurrencesDictToUseLocal CallNSNotificationMethods:NO completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse) {
                    
                    finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse, returningUpdatedTaskListDictToUseLocal);
                    
                }];
                
            }];
            
        }];
        
        
//        /*
//         //
//         //
//         //Reset Item Data
//         //
//         //
//         */
//        [[[CompleteUncompleteObject alloc] init] ItemizedItemCompleteUncomplete_ItemizedIsFullyCompleted_ResetItemData:dictToUse itemOccurrencesDict:itemOccurrencesDict keyArray:keyArray homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType topicDict:topicDict taskListDict:taskListDict allItemAssignedToArrays:allItemAssignedToArrays allItemTagsArrays:allItemTagsArrays itemizedItemThatIsBeingMarked:itemizedItemThatIsBeingMarked markingForSomeoneElse:markingForSomeoneElse currentViewController:currentViewController completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencecsDictToUse, NSMutableDictionary *returningUpdatedTaskListDictToUse) {
//            
//            returningDictToUseLocal = [returningDictToUse mutableCopy];
//            returningOccurrencesDictToUseLocal = [returningOccurrencecsDictToUse mutableCopy];
//            returningUpdatedTaskListDictToUseLocal = [returningUpdatedTaskListDictToUse mutableCopy];
//            
//            [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:returningDictToUseLocal itemOccurrencesDict:returningOccurrencesDictToUseLocal CallNSNotificationMethods:NO completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse) {
//                
//                finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse, returningUpdatedTaskListDictToUseLocal);
//                
//            }];
//            
//        }];
        
        
        
    } else {
        
        totalQueries = 1;
        
        
        /*
         //
         //
         //Reset Item Notifications
         //
         //
         */
        [[[CompleteUncompleteObject alloc] init] ItemizedItemCompleteUncomplete_ItemizedIsFullyCompleted_ResetItemNotifications:dictToUse itemOccurrencesDict:itemOccurrencesDict keyArray:keyArray homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType topicDict:topicDict allItemTagsArrays:allItemTagsArrays itemizedItemThatIsBeingMarked:itemizedItemThatIsBeingMarked markingForSomeoneElse:markingForSomeoneElse currentViewController:currentViewController completionHandler:^(BOOL finished) {
            
            [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:returningDictToUseLocal itemOccurrencesDict:returningOccurrencesDictToUseLocal CallNSNotificationMethods:NO completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencesDictToUse) {
                
                finishBlock(YES, returningDictToUse, returningOccurrencesDictToUse, returningUpdatedTaskListDictToUseLocal);
                
            }];
            
        }];
        
    }
    
}

#pragma mark - ItemizedItemInProgressNotInProgress

-(void)ItemizedItemInProgressNotInProgress_SendPushNotifications:(NSMutableDictionary *)dictToUse keyArray:(NSArray *)keyArray homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType topicDict:(NSMutableDictionary *)topicDict allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays itemizedItemThatIsBeingMarked:(NSString *)itemizedItemThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse currentViewController:(UIViewController *)currentViewController completionHandler:(void (^)(BOOL finished))finishBlock {
    
    
    NSMutableDictionary *itemAssignedTo = dictToUse[@"ItemAssignedTo"] ? [dictToUse[@"ItemAssignedTo"] mutableCopy] : [NSMutableArray array];
    NSString *itemCreatedBy = dictToUse[@"ItemCreatedBy"] ? dictToUse[@"ItemCreatedBy"] : @"";
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        
        
        NSMutableDictionary *notificationText = [[[CompleteUncompleteObject alloc] init] GenerateItemizedItemInProgressNotificationText:dictToUse itemizedItemThatIsBeingMarked:itemizedItemThatIsBeingMarked markingForSomeoneElse:markingForSomeoneElse];
        NSString *notificationTitle = notificationText && notificationText[@"Title"] ? notificationText[@"Title"] : @"";
        NSString *notificationBody = notificationText && notificationText[@"Body"] ? notificationText[@"Body"] : @"";
        
        
        
        NSMutableArray *usersToSendNotificationTo = [itemAssignedTo mutableCopy];
        
        NSArray *addTheseUsers = @[itemCreatedBy];
        NSArray *removeTheseUsers = @[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx"];
        
        usersToSendNotificationTo = [[[[NotificationsObject alloc] init] AddAndRemoveSpecificUsersFromArray:usersToSendNotificationTo addTheseUsers:addTheseUsers removeTheseUsers:removeTheseUsers] mutableCopy];
        
        
        
        NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
        
        [[[NotificationsObject alloc] init] SendPushNotificationToArrayOfUsers_Items:usersToSendNotificationTo
                                                                           dictToUse:dictToUse
                                                                              homeID:homeID homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict
                                                            notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType
                                                                           topicDict:topicDict
                                                                allItemTagsArrays:allItemTagsArrays
                                                               pushNotificationTitle:notificationTitle pushNotificationBody:notificationBody
                                                                   notificationTitle:notificationTitle notificationBody:notificationBody
                                                             SetDataHomeNotification:YES
                                                                RemoveUsersNotInHome:YES
                                                                   completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)ItemizedItemInProgressNotInProgress_SetItemAndHomeActivityData:(NSMutableDictionary *)dictToUse itemizedItemThatIsBeingMarked:(NSString *)itemizedItemThatIsBeingMarked completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *itemType = [[[GeneralObject alloc] init] GenerateItemType];
    
    NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
    
    NSString *itemID = dictToUse[@"ItemID"] ? dictToUse[@"ItemID"] : @"";
    NSString *itemOccurrenceID = dictToUse[@"ItemOccurrenceID"] ? dictToUse[@"ItemOccurrenceID"] : @"";
    NSString *itemName = dictToUse[@"ItemName"] ? dictToUse[@"ItemName"] : @"";
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        BOOL ItemizedItemIsBeingMarkedInProgress = [[[CompleteUncompleteObject alloc] init] GenerateItemizedItemIsBeingMarkedInProgress:dictToUse itemizedItemThatIsBeingMarked:itemizedItemThatIsBeingMarked];
        
        NSString *activityAction = [NSString stringWithFormat:@"%@ Itemized Item", ItemizedItemIsBeingMarkedInProgress ? @"In Progress" : @"Not In Progress"];
        NSString *userTitle = [NSString stringWithFormat:@"%@ marked a itemized item %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"], ItemizedItemIsBeingMarkedInProgress ? @"in progress" : @"not in progress"];
        NSString *itemTitle = [NSString stringWithFormat:@"%@ marked a itemized item %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"], ItemizedItemIsBeingMarkedInProgress ? @"in progress" : @"not in progress"];
        NSString *itemDescription = [NSString stringWithFormat:@"\"%@\"'s itemized item, \"%@\", was marked %@", itemName, itemizedItemThatIsBeingMarked, ItemizedItemIsBeingMarkedInProgress ? @"in progress" : @"not in progress"];
        
        NSMutableDictionary *itemActivityDict = [[[SetDataObject alloc] init] GenerateItemActivityDict:itemID itemOccurrenceID:itemOccurrenceID activityUserIDNo1:@"" homeID:homeID activityAction:activityAction userTitle:userTitle userDescription:itemDescription itemType:itemType];
        NSMutableDictionary *homeActivityDict = [[[SetDataObject alloc] init] GenerateHomeActivityDict:@"" homeID:homeID activityAction:activityAction itemTitle:itemTitle itemDescription:itemDescription itemType:itemType];
        
        [[[SetDataObject alloc] init] SetDataHomeAndItemActivity:itemActivityDict homeActivityDict:homeActivityDict completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

#pragma mark - ItemizedItemWillDoWontDo

-(void)ItemizedItemWillDoWontDo_SendPushNotifications:(NSMutableDictionary *)dictToUse keyArray:(NSArray *)keyArray homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType topicDict:(NSMutableDictionary *)topicDict allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays itemizedItemThatIsBeingMarked:(NSString *)itemizedItemThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse currentViewController:(UIViewController *)currentViewController completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSMutableDictionary *itemAssignedTo = dictToUse[@"ItemAssignedTo"] ? [dictToUse[@"ItemAssignedTo"] mutableCopy] : [NSMutableArray array];
    NSString *itemCreatedBy = dictToUse[@"ItemCreatedBy"] ? dictToUse[@"ItemCreatedBy"] : @"";
    
    
    
    NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        
        
        NSMutableDictionary *notificationText = [[[CompleteUncompleteObject alloc] init] GenerateItemizedItemWontDoNotificationText:dictToUse itemizedItemThatIsBeingMarked:itemizedItemThatIsBeingMarked markingForSomeoneElse:markingForSomeoneElse];
        NSString *notificationTitle = notificationText && notificationText[@"Title"] ? notificationText[@"Title"] : @"";
        NSString *notificationBody = notificationText && notificationText[@"Body"] ? notificationText[@"Body"] : @"";
        
        
        
        NSMutableArray *usersToSendNotificationTo = [itemAssignedTo mutableCopy];
        
        NSArray *addTheseUsers = @[itemCreatedBy];
        NSArray *removeTheseUsers = @[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx"];
        
        usersToSendNotificationTo = [[[[NotificationsObject alloc] init] AddAndRemoveSpecificUsersFromArray:usersToSendNotificationTo addTheseUsers:addTheseUsers removeTheseUsers:removeTheseUsers] mutableCopy];
        
        
        
        [[[NotificationsObject alloc] init] SendPushNotificationToArrayOfUsers_Items:usersToSendNotificationTo dictToUse:dictToUse
                                                                              homeID:homeID homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict
                                                            notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType
                                                                           topicDict:topicDict
                                                                allItemTagsArrays:allItemTagsArrays
                                                               pushNotificationTitle:notificationTitle pushNotificationBody:notificationBody
                                                                   notificationTitle:notificationTitle notificationBody:notificationBody
                                                             SetDataHomeNotification:YES
                                                                RemoveUsersNotInHome:YES
                                                                   completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)ItemizedItemWillDoWontDo_SetItemAndHomeActivityData:(NSMutableDictionary *)dictToUse itemizedItemThatIsBeingMarked:(NSString *)itemizedItemThatIsBeingMarked completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *itemType = [[[GeneralObject alloc] init] GenerateItemType];
    
    NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
    
    NSString *itemID = dictToUse[@"ItemID"] ? dictToUse[@"ItemID"] : @"";
    NSString *itemOccurrenceID = dictToUse[@"ItemOccurrenceID"] ? dictToUse[@"ItemOccurrenceID"] : @"";
    NSString *itemName = dictToUse[@"ItemName"] ? dictToUse[@"ItemName"] : @"";
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        BOOL ItemizedItemIsBeingMarkedWontDo = [[[CompleteUncompleteObject alloc] init] GenerateItemizedItemIsBeingMarkedWontDo:dictToUse itemizedItemThatIsBeingMarked:itemizedItemThatIsBeingMarked];
        
        NSString *activityAction = [NSString stringWithFormat:@"%@ Itemized Item", ItemizedItemIsBeingMarkedWontDo ? @"Won't Do" : @"Will Do"];
        NSString *userTitle = [NSString stringWithFormat:@"%@ %@ a itemized item", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"], ItemizedItemIsBeingMarkedWontDo ? @"won't do" : @"will do"];
        NSString *itemTitle = [NSString stringWithFormat:@"%@ %@ a itemized item", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"], ItemizedItemIsBeingMarkedWontDo ? @"won't do" : @"will do"];
        NSString *itemDescription = [NSString stringWithFormat:@"\"%@\"'s itemized item, \"%@\", was marked %@", itemName, itemizedItemThatIsBeingMarked, ItemizedItemIsBeingMarkedWontDo ? @"won't do" : @"will do"];
        
        NSMutableDictionary *itemActivityDict = [[[SetDataObject alloc] init] GenerateItemActivityDict:itemID itemOccurrenceID:itemOccurrenceID activityUserIDNo1:@"" homeID:homeID activityAction:activityAction userTitle:userTitle userDescription:itemDescription itemType:itemType];
        NSMutableDictionary *homeActivityDict = [[[SetDataObject alloc] init] GenerateHomeActivityDict:@"" homeID:homeID activityAction:activityAction itemTitle:itemTitle itemDescription:itemDescription itemType:itemType];
        
        [[[SetDataObject alloc] init] SetDataHomeAndItemActivity:itemActivityDict homeActivityDict:homeActivityDict completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

#pragma mark - ItemizedItemFullyCompleted

-(void)ItemizedItemCompleteUncomplete_ItemizedIsFullyCompleted_SendPushNotifications:(NSMutableDictionary *)dictToUse keyArray:(NSArray *)keyArray homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType topicDict:(NSMutableDictionary *)topicDict allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays itemizedItemThatIsBeingMarked:(NSString *)itemizedItemThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse currentViewController:(UIViewController *)currentViewController completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSMutableDictionary *notificationText = [[[CompleteUncompleteObject alloc] init] GenerateItemizedItemFullCompletedNotificationText:dictToUse itemizedItemThatIsBeingMarked:itemizedItemThatIsBeingMarked homeMembersDict:homeMembersDict];
    NSString *notificationTitle = notificationText && notificationText[@"Title"] ? notificationText[@"Title"] : @"";
    NSString *notificationBody = notificationText && notificationText[@"Body"] ? notificationText[@"Body"] : @"";
    
    NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";

    
    
    NSString *itemCreatedBy = dictToUse[@"ItemCreatedBy"] ? dictToUse[@"ItemCreatedBy"] : @"";
    NSMutableArray *itemAssignedTo = dictToUse[@"ItemAssignedTo"] ? [dictToUse[@"ItemAssignedTo"] mutableCopy] : [NSMutableArray array];
    
    [itemAssignedTo addObject:itemCreatedBy];
    
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[NotificationsObject alloc] init] SendPushNotificationToArrayOfUsers_Items:itemAssignedTo
                                                                           dictToUse:dictToUse
                                                                              homeID:homeID homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict
                                                            notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType
                                                                           topicDict:topicDict
                                                                allItemTagsArrays:allItemTagsArrays
                                                               pushNotificationTitle:notificationTitle pushNotificationBody:notificationBody
                                                                   notificationTitle:notificationTitle notificationBody:notificationBody
                                                             SetDataHomeNotification:YES
                                                                RemoveUsersNotInHome:YES
                                                                   completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)ItemizedItemCompleteUncomplete_ItemizedIsFullyCompleted_ResetItemNotifications:(NSMutableDictionary *)dictToUse itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict keyArray:(NSArray *)keyArray homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType topicDict:(NSMutableDictionary *)topicDict allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays itemizedItemThatIsBeingMarked:(NSString *)itemizedItemThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse currentViewController:(UIViewController *)currentViewController completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *itemType = [[[GeneralObject alloc] init] GenerateItemType];
    
    NSString *itemCreatedBy = dictToUse[@"ItemCreatedBy"] ? dictToUse[@"ItemCreatedBy"] : @"";
    NSMutableArray *itemAssignedTo = dictToUse[@"ItemAssignedTo"] ? dictToUse[@"ItemAssignedTo"] : [NSMutableArray array];
    
    NSMutableArray *userIDArray = [itemAssignedTo mutableCopy];
    NSMutableArray *userIDToRemoveArray = [NSMutableArray array];
    
    [userIDArray addObject:itemCreatedBy];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[NotificationsObject alloc] init] ResetLocalNotificationReminderNotification:dictToUse homeMembersDict:homeMembersDict userIDArray:userIDArray userIDToRemoveArray:userIDToRemoveArray notificationSettingsDict:notificationSettingsDict allItemTagsArrays:allItemTagsArrays itemType:itemType notificationType:notificationType topicDict:topicDict completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)ItemizedItemCompleteUncomplete_ItemizedIsFullyCompleted_ResetItemData:(NSMutableDictionary *)dictToUse itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict keyArray:(NSArray *)keyArray homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType topicDict:(NSMutableDictionary *)topicDict taskListDict:(NSMutableDictionary *)taskListDict allItemAssignedToArrays:(NSMutableArray * _Nullable)allItemAssignedToArrays allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays itemizedItemThatIsBeingMarked:(NSString *)itemizedItemThatIsBeingMarked markingForSomeoneElse:(BOOL)markingForSomeoneElse currentViewController:(UIViewController *)currentViewController completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDictToUse, NSMutableDictionary *returningOccurrencecsDictToUse, NSMutableDictionary *returningUpdatedTaskListDictToUse))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        __block NSMutableDictionary *returningUpdatedTaskListDictLocal = [NSMutableDictionary dictionary];
        
        NSString *itemType = [[[GeneralObject alloc] init] GenerateItemType];
        
        NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
        
        BOOL TaskIsRepeating = [[[BoolDataObject alloc] init] TaskIsRepeating:dictToUse itemType:itemType];
        
        if (TaskIsRepeating == YES) {
            
            NSMutableDictionary *singleObjectDict = [[[GeneralObject alloc] init] GenerateSingleArraySingleObjectDictionary:dictToUse keyArray:keyArray indexPath:nil];
            
            [[[SetDataObject alloc] init] UpdateDataResetRepeatingTask:singleObjectDict itemOccurrencesDict:itemOccurrencesDict homeID:homeID itemType:itemType keyArray:keyArray homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict topicDict:topicDict taskListDict:taskListDict allItemAssignedToArrays:allItemAssignedToArrays allItemTagsArrays:allItemTagsArrays SkipOccurrence:NO completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningItemDict, NSMutableDictionary *returningItemOccurrencesDict, NSMutableDictionary * _Nonnull returningUpdatedTaskListDict) {
                
                returningUpdatedTaskListDictLocal = [returningUpdatedTaskListDict mutableCopy];
                
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                NSMutableDictionary *singleObjectDict = [[[GeneralObject alloc] init] GenerateSingleObjectDictionary:returningItemDict keyArray:keyArray indexPath:indexPath];
                
                for (NSString *key in [singleObjectDict allKeys]) {
                    [dictToUse setObject:singleObjectDict[key] forKey:key];
                }
                
                [[[GeneralObject alloc] init] CallNSNotificationMethods:@"CompletedReset" userInfo:nil locations:@[@"ViewTask"]];
                
                finishBlock(YES, dictToUse, returningItemOccurrencesDict, returningUpdatedTaskListDictLocal);
                
            }];
            
        } else {
            
            finishBlock(YES, dictToUse, itemOccurrencesDict, returningUpdatedTaskListDictLocal);
            
        }
        
    });
    
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Sub-Internal Methods
#pragma mark
#pragma mark
#pragma mark -

-(NSString *)GenerateCompleteAsNeededKey:(NSMutableDictionary *)dictToUse objectBeingMarked:(NSString *)objectBeingMarked itemType:(NSString *)itemType {
    
    BOOL TaskIsCompleteAsNeeded = [[[BoolDataObject alloc] init] TaskIsCompleteAsNeeded:dictToUse itemType:itemType];
    
    NSMutableDictionary *itemCompletedDict = dictToUse[@"ItemCompletedDict"] ? [dictToUse[@"ItemCompletedDict"] mutableCopy] : [NSMutableDictionary dictionary];
    
    NSString *keyToUse = objectBeingMarked;
    
    if (TaskIsCompleteAsNeeded == YES) {
        
        int amountOfOriginalKeys = 0;
        
        for (NSString *key in [itemCompletedDict allKeys]) {
            
            NSString *keyCopy = [key mutableCopy];
            
            if ([keyCopy containsString:@"•••"] == YES) {
                
                keyCopy = [[keyCopy componentsSeparatedByString:@"•••"] count] > 0 ? [keyCopy componentsSeparatedByString:@"•••"][0] : @"";
                
            }
            
            if ([keyCopy isEqualToString:keyToUse]) {
                
                amountOfOriginalKeys += 1;
                
            }
            
        }
        
        if (amountOfOriginalKeys > 0) {
            
            keyToUse = [NSString stringWithFormat:@"%@•••%d•••", objectBeingMarked, amountOfOriginalKeys];
            
        }
        
    }
    
    if (keyToUse == nil || keyToUse == NULL || [keyToUse length] == 0) {
        keyToUse = @"UnknownKey";
    }
    
    return keyToUse;
}

-(NSString *)GenerateCompleteAsNeededSubTaskKey:(NSMutableDictionary *)dictToUse subtaskThatIsBeingMarked:(NSString *)subtaskThatIsBeingMarked userIDKey:(NSString *)userIDKey itemType:(NSString *)itemType {
    
    BOOL TaskIsCompleteAsNeeded = [[[BoolDataObject alloc] init] TaskIsCompleteAsNeeded:dictToUse itemType:itemType];
    
    NSMutableDictionary *itemSubTasksDict = dictToUse[@"ItemSubTasks"] ? [dictToUse[@"ItemSubTasks"] mutableCopy] : [NSMutableDictionary dictionary];
    
    NSMutableDictionary *subtaskCompletedDict = itemSubTasksDict[subtaskThatIsBeingMarked] && itemSubTasksDict[subtaskThatIsBeingMarked][@"Completed Dict"] ?
    [itemSubTasksDict[subtaskThatIsBeingMarked][@"Completed Dict"] mutableCopy] : [NSMutableDictionary dictionary];
    
    NSString *keyToUse = userIDKey;
   
    if (TaskIsCompleteAsNeeded == YES) {
        
        int amountOfOriginalKeys = 0;
        
        for (NSString *key in [subtaskCompletedDict allKeys]) {
            
            NSString *keyCopy = [key mutableCopy];
            
            if ([keyCopy containsString:@"•••"] == YES) {
                
                keyCopy = [[keyCopy componentsSeparatedByString:@"•••"] count] > 0 ? [keyCopy componentsSeparatedByString:@"•••"][0] : @"";
                
            }
            
            if ([keyCopy isEqualToString:keyToUse]) {
                
                amountOfOriginalKeys += 1;
                
            }
            
        }
        
        if (amountOfOriginalKeys > 0) {
            
            keyToUse = [NSString stringWithFormat:@"%@•••%d•••", userIDKey, amountOfOriginalKeys];
            
        }
        
    }
    
    if (keyToUse == nil || keyToUse == NULL || [keyToUse length] == 0) {
        keyToUse = @"UnknownKey";
    }
  
    return keyToUse;
}
                   
@end
