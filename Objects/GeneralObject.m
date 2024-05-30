//
//  GeneralObject.m
//  WeDivvy
//
//  Created by Philip Nagel on 9/14/21.
//

#import "GeneralObject.h"
#import "NotificationsObject.h"
#import "BoolDataObject.h"
#import "GetDataObject.h"
#import "SetDataObject.h"
#import "DeleteDataObject.h"

#import "CompleteUncompleteObject.h"

@implementation GeneralObject;

-(NSString *)GenerateItemImageURL:(NSString *)itemType itemUniqueID:(NSString *)itemUniqueID {
    
    NSString *firstChild = [NSString stringWithFormat:@"%@Images", itemType];
    NSString *secondChild = [NSString stringWithFormat:@"%@Image", itemType];
    
    NSString *imageURL = [NSString stringWithFormat:@"gs://wedivvy-afe04.appspot.com/%@/%@/%@/%@.jpeg", firstChild, itemUniqueID, secondChild, itemUniqueID];
    
    return imageURL;
}

-(NSString *)GeneratePhotoConfirmationImageURL:(NSString *)itemType itemUniqueID:(NSString *)itemUniqueID markedObject:(NSString *)markedObject {

    NSString *firstChild = [NSString stringWithFormat:@"%@Images", itemType];
    NSString *secondChild = [NSString stringWithFormat:@"%@Image", itemType];
    
    NSString *imageURL = [NSString stringWithFormat:@"gs://wedivvy-afe04.appspot.com/%@/%@/%@/PhotoConfirmations/%@.jpeg", firstChild, itemUniqueID, secondChild, markedObject];
    
    return imageURL;
}

-(NSDictionary *)GenerateItemSetDataDict:(NSString *)itemType
                            itemUniqueID:(NSString *)itemUniqueID
                                  itemID:(NSString *)itemID
                        itemOccurrenceID:(NSString *)itemOccurrenceID
                              itemHomeID:(NSString *)itemHomeID
                         itemSuggestedID:(NSString *)itemSuggestedID

                            itemTutorial:(NSString *)itemTutorial

                           itemCreatedBy:(NSString *)itemCreatedBy
                          itemDatePosted:(NSString *)itemDatePosted
                       itemDateLastReset:(NSString *)itemDateLastReset

                       itemCompletedDict:(NSMutableDictionary *)itemCompletedDict
                      itemInProgressDict:(NSMutableDictionary *)itemInProgressDict
                              itemWontDo:(NSMutableDictionary *)itemWontDo

                    itemOccurrenceStatus:(NSString *)itemOccurrenceStatus
                   itemOccurrencePastDue:(NSMutableDictionary *)itemOccurrencePastDue

                       itemAddedLocation:(NSString *)itemAddedLocation
                      itemScheduledStart:(NSString *)itemScheduledStart



//Main View
                                itemName:(NSString *)itemName
                            itemImageURL:(NSString *)itemImageURL
                               itemNotes:(NSString *)itemNotes

                          itemAssignedTo:(NSMutableArray *)itemAssignedTo
            itemAssignedToNewHomeMembers:(NSString *)itemAssignedToNewHomeMembers
                   itemAssignedToAnybody:(NSString *)itemAssignedToAnybody

                                itemDate:(NSString *)itemDate
                             itemDueDate:(NSString *)itemDueDate
                     itemDueDatesSkipped:(NSMutableArray *)itemDueDatesSkipped
                             itemRepeats:(NSString *)itemRepeats
                 itemRepeatIfCompletedEarly:(NSString *)itemRepeatIfCompletedEarly
                    itemCompleteAsNeeded:(NSString *)itemCompleteAsNeeded

                           itemStartDate:(NSString *)itemStartDate
                             itemEndDate:(NSString *)itemEndDate
                    itemEndNumberOfTimes:(NSString *)itemEndNumberOfTimes

                                itemDays:(NSString *)itemDays
                                itemTime:(NSString *)itemTime

                           itemTakeTurns:(NSString *)itemTakeTurns
                      itemAlternateTurns:(NSString *)itemAlternateTurns
             itemDateLastAlternatedTurns:(NSString *)itemDateLastAlternatedTurns
                          itemTurnUserID:(NSString *)itemTurnUserID
                  itemRandomizeTurnOrder:(NSString *)itemRandomizeTurnOrder

                        itemReminderDict:(NSMutableDictionary *)itemReminderDict



//More Options
                         itemGracePeriod:(NSString *)itemGracePeriod
                             itemPastDue:(NSString *)itemPastDue

                               itemColor:(NSString *)itemColor
                                itemTags:(NSMutableArray *)itemTags
                            itemPriority:(NSString *)itemPriority
                          itemDifficulty:(NSString *)itemDifficulty

                              itemReward:(NSMutableDictionary *)itemReward
                             itemPrivate:(NSString *)itemPrivate



                 itemAdditionalReminders:(NSMutableDictionary *)itemAdditionalReminders
                   itemPhotoConfirmation:(NSString *)itemPhotoConfirmation
               itemPhotoConfirmationDict:(NSMutableDictionary *)itemPhotoConfirmationDict
                              itemStatus:(NSString *)itemStatus
                               itemTrash:(NSString *)itemTrash
                              itemPinned:(NSString *)itemPinned
                             itemDeleted:(NSString *)itemDeleted
                            itemTaskList:(NSString *)itemTaskList

                        itemSelfDestruct:(NSString *)itemSelfDestruct
                       itemEstimatedTime:(NSString *)itemEstimatedTime



//if ([itemType containsString:@"Chore"] || [itemType containsString:@"Expense"]) {

                    itemSpecificDueDates:(NSMutableArray *)itemSpecificDueDates
                      itemApprovalNeeded:(NSString *)itemApprovalNeeded
                    itemApprovalRequests:(NSMutableDictionary *)itemApprovalRequests

//}

//if ([itemType containsString:@"Chore"]) {

                         itemCompletedBy:(NSString *)itemCompletedBy
                            itemSubTasks:(NSMutableDictionary *)itemSubTasks

//} else if ([itemType containsString:@"Expense"]) {

                              itemAmount:(NSString *)itemAmount
                            itemItemized:(NSString *)itemItemized
                       itemItemizedItems:(NSMutableDictionary *)itemItemizedItems
                       itemCostPerPerson:(NSMutableDictionary *)itemCostPerPerson
                       itemPaymentMethod:(NSMutableDictionary *)itemPaymentMethod

//} else if ([itemType containsString:@"List"]) {

                           itemListItems:(NSMutableDictionary *)itemListItems

//}
{
    
    NSMutableDictionary *setDataDict = [NSMutableDictionary dictionary];
    
    
    
    [setDataDict setObject:itemType forKey:@"ItemType"];
    [setDataDict setObject:itemUniqueID forKey:@"ItemUniqueID"];
    [setDataDict setObject:itemID forKey:@"ItemID"];
    [setDataDict setObject:itemOccurrenceID forKey:@"ItemOccurrenceID"];
    [setDataDict setObject:itemHomeID forKey:@"ItemHomeID"];
    [setDataDict setObject:itemSuggestedID forKey:@"ItemSuggestedID"];
    
    [setDataDict setObject:itemTutorial forKey:@"ItemTutorial"];
   
    [setDataDict setObject:itemCreatedBy forKey:@"ItemCreatedBy"];
    [setDataDict setObject:itemDatePosted forKey:@"ItemDatePosted"];
    [setDataDict setObject:itemDateLastReset forKey:@"ItemDateLastReset"];
    
    [setDataDict setObject:itemCompletedDict forKey:@"ItemCompletedDict"];
    [setDataDict setObject:itemInProgressDict forKey:@"ItemInProgressDict"];
    [setDataDict setObject:itemWontDo forKey:@"ItemWontDo"];
    
    [setDataDict setObject:itemOccurrenceStatus forKey:@"ItemOccurrenceStatus"];
    [setDataDict setObject:itemOccurrencePastDue forKey:@"ItemOccurrencePastDue"];
    
    [setDataDict setObject:itemAddedLocation forKey:@"ItemAddedLocation"];
    [setDataDict setObject:itemScheduledStart forKey:@"ItemScheduledStart"];
    
    
    
    //Main View
    [setDataDict setObject:itemName forKey:@"ItemName"];
    [setDataDict setObject:itemImageURL forKey:@"ItemImageURL"];
    [setDataDict setObject:itemNotes forKey:@"ItemNotes"];
    
    [setDataDict setObject:itemAssignedTo forKey:@"ItemAssignedTo"];
    [setDataDict setObject:itemAssignedToNewHomeMembers forKey:@"ItemAssignedToNewHomeMembers"];
    [setDataDict setObject:itemAssignedToAnybody forKey:@"ItemAssignedToAnybody"];
    
    [setDataDict setObject:itemDate forKey:@"ItemDate"];
    [setDataDict setObject:itemDueDate forKey:@"ItemDueDate"];
    [setDataDict setObject:itemDueDatesSkipped forKey:@"ItemDueDatesSkipped"];
    [setDataDict setObject:itemRepeats forKey:@"ItemRepeats"];
    [setDataDict setObject:itemRepeatIfCompletedEarly forKey:@"ItemRepeatIfCompletedEarly"];
    [setDataDict setObject:itemCompleteAsNeeded forKey:@"ItemCompleteAsNeeded"];
    
    [setDataDict setObject:itemStartDate forKey:@"ItemStartDate"];
    [setDataDict setObject:itemEndDate forKey:@"ItemEndDate"];
    [setDataDict setObject:itemEndNumberOfTimes forKey:@"ItemEndNumberOfTimes"];
    
    [setDataDict setObject:itemDays forKey:@"ItemDays"];
    [setDataDict setObject:itemTime forKey:@"ItemTime"];
    
    [setDataDict setObject:itemTakeTurns forKey:@"ItemTakeTurns"];
    [setDataDict setObject:itemAlternateTurns forKey:@"ItemAlternateTurns"];
    [setDataDict setObject:itemDateLastAlternatedTurns forKey:@"ItemDateLastAlternatedTurns"];
    [setDataDict setObject:itemTurnUserID forKey:@"ItemTurnUserID"];
    [setDataDict setObject:itemRandomizeTurnOrder forKey:@"ItemRandomizeTurnOrder"];
    
    [setDataDict setObject:itemReminderDict forKey:@"ItemReminderDict"];
    
    
    
    //More Options
    [setDataDict setObject:itemGracePeriod forKey:@"ItemGracePeriod"];
    [setDataDict setObject:itemPastDue forKey:@"ItemPastDue"];
    
    [setDataDict setObject:itemColor forKey:@"ItemColor"];
    [setDataDict setObject:itemTags forKey:@"ItemTags"];
    [setDataDict setObject:itemPriority forKey:@"ItemPriority"];
    [setDataDict setObject:itemDifficulty forKey:@"ItemDifficulty"];

    [setDataDict setObject:itemReward forKey:@"ItemReward"];
    [setDataDict setObject:itemPrivate forKey:@"ItemPrivate"];
    
    
    
    [setDataDict setObject:itemAdditionalReminders forKey:@"ItemAdditionalReminders"];
    [setDataDict setObject:itemPhotoConfirmation forKey:@"ItemPhotoConfirmation"];
    [setDataDict setObject:itemPhotoConfirmationDict forKey:@"ItemPhotoConfirmationDict"];
    [setDataDict setObject:itemStatus forKey:@"ItemStatus"];
    [setDataDict setObject:itemTrash forKey:@"ItemTrash"];
    [setDataDict setObject:itemPinned forKey:@"ItemPinned"];
    [setDataDict setObject:itemDeleted forKey:@"ItemDeleted"];
    [setDataDict setObject:itemTaskList forKey:@"ItemTaskList"];
    
    [setDataDict setObject:itemSelfDestruct forKey:@"ItemSelfDestruct"];
    [setDataDict setObject:itemEstimatedTime forKey:@"ItemEstimatedTime"];
    
    
    
    if ([itemType containsString:@"Chore"] || [itemType containsString:@"Expense"]) {
        
        [setDataDict setObject:itemSpecificDueDates forKey:@"ItemSpecificDueDates"];
        [setDataDict setObject:itemApprovalNeeded forKey:@"ItemApprovalNeeded"];
        [setDataDict setObject:itemApprovalRequests forKey:@"ItemApprovalRequests"];
        
    }
    
    if ([itemType containsString:@"Chore"]) {
        
        [setDataDict setObject:itemCompletedBy forKey:@"ItemMustComplete"];
        [setDataDict setObject:itemSubTasks forKey:@"ItemSubTasks"];
        
    } else if ([itemType containsString:@"Expense"]) {
        
        [setDataDict setObject:itemAmount forKey:@"ItemAmount"];
        [setDataDict setObject:itemItemized forKey:@"ItemItemized"];
        [setDataDict setObject:itemItemizedItems forKey:@"ItemItemizedItems"];
        [setDataDict setObject:itemCostPerPerson forKey:@"ItemCostPerPerson"];
        [setDataDict setObject:itemPaymentMethod forKey:@"ItemPaymentMethod"];
        
    } else if ([itemType containsString:@"List"]) {
        
        [setDataDict setObject:itemListItems forKey:@"ItemListItems"];
        
    }
    
    
    
    return [setDataDict copy];
}

-(NSArray *)GenerateSuggestedTaskListArray:(NSString *)itemType {
    
    NSArray *arrayToUse = @[@"Kitchen", @"Bathroom", @"Living Room", @"Dining Room", @"Bedroom", @"Office", @"Laundry", @"Entrace", @"Basement", @"Attic"];
    
    if ([itemType isEqualToString:@"Expense"]) {
        arrayToUse = @[@"Bills", @"Insurance", @"Goods", @"Miscellaneous"];
    } else if ([itemType isEqualToString:@"List"]) {
        arrayToUse = @[@"Groceries", @"Household Supplies", @"School Supplies", @"To-Do"];
    }
    
    return arrayToUse;
}

-(id)GenerateObjectWithNonHomeMembersRemoved:(id)object homeMembersDict:(NSMutableDictionary *)homeMembersDict {
    
    BOOL ObjectIsKindOfClassArray = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:object classArr:@[[NSArray class], [NSMutableArray class]]];
    BOOL ObjectIsKindOfClassDict = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:object classArr:@[[NSDictionary class], [NSMutableDictionary class]]];
    
    if (ObjectIsKindOfClassArray == YES) {
        
        for (id innerObject in [object mutableCopy]) {
            
            BOOL ObjectIsKindOfClassString = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:innerObject classArr:@[[NSString class]]];
            
            if (ObjectIsKindOfClassString == YES) {
                
                if ([homeMembersDict[@"UserID"] containsObject:innerObject] == NO && [innerObject containsString:@"-"] && [innerObject containsString:@":"]) {
                    [object removeObject:innerObject];
                }
                
            }
            
        }
        
    } else if (ObjectIsKindOfClassDict == YES) {
        
        for (id innerObject in [[object allKeys] mutableCopy]) {
            
            BOOL ObjectIsKindOfClassString = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:innerObject classArr:@[[NSString class]]];
            
            if (ObjectIsKindOfClassString == YES) {
                
                if ([homeMembersDict[@"UserID"] containsObject:innerObject] == NO && [innerObject containsString:@"-"] && [innerObject containsString:@":"]) {
                    [object removeObjectForKey:innerObject];
                }
                
            }
            
        }
        
    }
    
    return object;
}

#pragma mark

-(void)AllGenerateTokenMethod:(NSString *)topicID Subscribe:(BOOL)Subscribe GrantedNotifications:(BOOL)GrantedNotifications {
    
    NSString *key = [NSString stringWithFormat:@"didRegisterForRemoteNotificationsWithDeviceToken_%@", Subscribe ? @"Subscribe" : @"Unsubscribe"];
    
    NSMutableArray *arr = [[NSUserDefaults standardUserDefaults] objectForKey:key] ? [[[NSUserDefaults standardUserDefaults] objectForKey:key] mutableCopy] : [NSMutableArray array];
    if ([arr containsObject:topicID] == NO) { [arr addObject:topicID]; }
   
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (GrantedNotifications == YES) {
           
            [[NSUserDefaults standardUserDefaults] setObject:arr forKey:key];
            
            [[UIApplication sharedApplication] registerForRemoteNotifications];
            
        } else {
            
            UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
            
            [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings *settings) {
                
                BOOL granted = settings.authorizationStatus == UNAuthorizationStatusAuthorized;
                
                if (granted) {
                    
                    [[NSUserDefaults standardUserDefaults] setObject:arr forKey:key];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [[UIApplication sharedApplication] registerForRemoteNotifications];
                        
                    });
                    
                }
                
            }];
            
        }
        
    });
    
}

-(void)RemoveCompletedTopicFromGenerateTokenArray:(NSString *)topicID Subscribe:(BOOL)Subscribe {
    
    NSString *key = [NSString stringWithFormat:@"didRegisterForRemoteNotificationsWithDeviceToken_%@", Subscribe ? @"Subscribe" : @"Unsubscribe"];
    
    NSMutableArray *arr = [[NSUserDefaults standardUserDefaults] objectForKey:key] ? [[[NSUserDefaults standardUserDefaults] objectForKey:key] mutableCopy] : [NSMutableArray array];
    if ([arr containsObject:topicID]) { [arr removeObject:topicID]; }
    
    [[NSUserDefaults standardUserDefaults] setObject:arr forKey:key];
    
}

#pragma mark

-(void)SubscribeToAllHomeTopics:(NSString *)userID homeID:(NSString *)homeID homeMembersDict:(NSMutableDictionary *)homeMembersDict completionHandler:(void (^)(BOOL finished))finishBlock {
   
    [[[GeneralObject alloc] init] SubscribeToUserIDTopic:userID completionHandler:^(BOOL finished) {
       
        [[[GeneralObject alloc] init] SubscribeToUserIDTopic:homeID completionHandler:^(BOOL finished) {
            
            BOOL UseLocallyGeneratedTopics = [[[BoolDataObject alloc] init] UseLocallyGeneratedTopics:homeMembersDict];
            
            if (UseLocallyGeneratedTopics == YES) {
                
                NSArray *userIDArray = homeMembersDict[@"UserID"] ? homeMembersDict[@"UserID"] : [NSMutableArray array];
                
                NSArray *subSets = [[[NotificationsObject alloc] init] GenerateUniqueSubsets:userIDArray];
                
                if (subSets.count == 0) {
                    finishBlock(YES);
                }
               
                for (NSArray *subset in subSets) {
                    
                    NSString *topic = [[[NotificationsObject alloc] init] GenerateTopicFromSubset:subset];
                    
                    NSString *userIDLast5Characters = [[[NotificationsObject alloc] init] GenerateTopicFromSubset:@[userID]];
                  
                    if ([topic containsString:userIDLast5Characters]) {
                      
                        [[[GeneralObject alloc] init] SubscribeToUserIDTopic:topic completionHandler:^(BOOL finished) {
                            
                            if ([subset isEqualToArray:[subSets lastObject]]) {
                                
                                finishBlock(YES);
                                
                            }
                            
                        }];
                        
                    } else if ([subset isEqualToArray:[subSets lastObject]]) {
                        
                        finishBlock(YES);
                        
                    }
                    
                }
                
            } else {
                
                finishBlock(YES);
                
            }
            
        }];
        
    }];
    
}

-(void)UnsubscribeToAllHomeTopics:(NSString *)userID homeID:(NSString *)homeID homeMembersDict:(NSMutableDictionary *)homeMembersDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    [[[GeneralObject alloc] init] UnsubscribeFromUserIDTopic:homeID completionHandler:^(BOOL finished) {
        
        BOOL UseLocallyGeneratedTopics = [[[BoolDataObject alloc] init] UseLocallyGeneratedTopics:homeMembersDict];
        
        if (UseLocallyGeneratedTopics == YES) {
            
            NSArray *userIDArray = homeMembersDict[@"UserID"] ? homeMembersDict[@"UserID"] : [NSMutableArray array];
            
            NSArray *subSets = [[[NotificationsObject alloc] init] GenerateUniqueSubsets:userIDArray];
            
            if (subSets.count == 0) {
                finishBlock(YES);
            }
            
            for (NSArray *subset in subSets) {
                
                NSString *topic = [[[NotificationsObject alloc] init] GenerateTopicFromSubset:subset];
                
                NSString *userIDLast5Characters = [[[NotificationsObject alloc] init] GenerateTopicFromSubset:@[userID]];
                
                if ([topic containsString:userIDLast5Characters]) {
                    
                    [[[GeneralObject alloc] init] UnsubscribeFromUserIDTopic:topic completionHandler:^(BOOL finished) {
                        
                        if ([subset isEqualToArray:[subSets lastObject]]) {
                            
                            finishBlock(YES);
                            
                        }
                        
                    }];
                    
                } else if ([subset isEqualToArray:[subSets lastObject]]) {
                    
                    finishBlock(YES);
                    
                }
                
            }
            
        } else {
            
            finishBlock(YES);
            
        }
        
    }];
    
}

-(void)SubscribeToUserIDTopic:(NSString *)userID completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSMutableArray *subscribedTopics = [[NSUserDefaults standardUserDefaults] objectForKey:@"TopicsSubsribedTo"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"TopicsSubsribedTo"] mutableCopy] : [NSMutableArray array];
  
    NSString *topic = [[[GeneralObject alloc] init] GetTopicFromUserID:userID];
  
    if ([subscribedTopics containsObject:[NSString stringWithFormat:@"--%@--", topic]] == NO) {
     
        [[FIRMessaging messaging] subscribeToTopic:topic completion:^(NSError * _Nullable error) {
          
            NSMutableArray *subscribedTopics = [[NSUserDefaults standardUserDefaults] objectForKey:@"TopicsSubsribedTo"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"TopicsSubsribedTo"] mutableCopy] : [NSMutableArray array];
            
            if ([subscribedTopics containsObject:[NSString stringWithFormat:@"--%@--", topic]] == NO) {
                [subscribedTopics addObject:[NSString stringWithFormat:@"--%@--", topic]];
            }
            
            [[NSUserDefaults standardUserDefaults] setObject:subscribedTopics forKey:@"TopicsSubsribedTo"];
           
            finishBlock(YES);
            
        }];
        
    } else {
        
        finishBlock(YES);
        
    }
  
}

-(void)UnsubscribeFromUserIDTopic:(NSString *)userID completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSMutableArray *subscribedTopics = [[NSUserDefaults standardUserDefaults] objectForKey:@"TopicsSubsribedTo"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"TopicsSubsribedTo"] mutableCopy] : [NSMutableArray array];
    
    NSString *topic = [[[GeneralObject alloc] init] GetTopicFromUserID:userID];
    
    if ([subscribedTopics containsObject:[NSString stringWithFormat:@"--%@--", topic]] == YES) {
        
        [[FIRMessaging messaging] unsubscribeFromTopic:topic completion:^(NSError * _Nullable error) {
            
            NSMutableArray *subscribedTopics = [[NSUserDefaults standardUserDefaults] objectForKey:@"TopicsSubsribedTo"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"TopicsSubsribedTo"] mutableCopy] : [NSMutableArray array];
            
            if ([subscribedTopics containsObject:[NSString stringWithFormat:@"--%@--", topic]] == YES) {
                [subscribedTopics removeObject:[NSString stringWithFormat:@"--%@--", topic]];
            }
            
            [[NSUserDefaults standardUserDefaults] setObject:subscribedTopics forKey:@"TopicsSubsribedTo"];
            
            finishBlock(YES);
            
        }];
        
    } else {
        
        finishBlock(YES);
        
    }
    
}

#pragma mark

-(NSMutableDictionary *)GenerateUpdatedTaskListDictNo1:(NSArray *)arrayOfDicts taskListDict:(NSMutableDictionary *)taskListDict {
   
    for (NSDictionary *dictToUse in arrayOfDicts) {
        
        for (NSString *taskListID in dictToUse[@"TaskListID"]) {
            
            NSUInteger indexOfTaskListInreturningUpdatedTaskListDict = [dictToUse[@"TaskListID"] indexOfObject:taskListID];
            NSMutableDictionary *returningTaskListItems = dictToUse[@"TaskListItems"][indexOfTaskListInreturningUpdatedTaskListDict];
           
            if ([taskListDict[@"TaskListID"] containsObject:taskListID]) {
               
                NSUInteger indexOfTaskInTaskListDict = [taskListDict[@"TaskListID"] indexOfObject:taskListID];
                NSMutableDictionary *taskListDictCopy = [taskListDict mutableCopy];
                NSMutableArray *taskListItemsArray = taskListDictCopy[@"TaskListItems"] ? [taskListDictCopy[@"TaskListItems"] mutableCopy] : [NSMutableArray array];
                NSMutableDictionary *taskListItems = [taskListItemsArray count] > indexOfTaskInTaskListDict ? [taskListItemsArray[indexOfTaskInTaskListDict] mutableCopy] : [NSMutableDictionary dictionary];
                
                for (NSString *itemUniqueID in [returningTaskListItems allKeys]) {
                    
                    [taskListItems setObject:@{@"ItemUniqueID" : itemUniqueID} forKey:itemUniqueID];
                    
                }
 
                [taskListItemsArray replaceObjectAtIndex:indexOfTaskInTaskListDict withObject:taskListItems];
                [taskListDictCopy setObject:taskListItemsArray forKey:@"TaskListItems"];
                taskListDict = [taskListDictCopy mutableCopy];
           
            }
            
        }
        
    }
    
    return taskListDict;
}

-(NSMutableDictionary *)GenerateUpdatedTaskListDict:(NSArray *)arrayOfDicts taskListDict:(NSMutableDictionary *)taskListDict {
    
    for (NSDictionary *dictToUse in arrayOfDicts) {
        
        for (NSString *taskListID in dictToUse[@"TaskListID"]) {
            
            NSUInteger indexOfTaskListInreturningUpdatedTaskListDict = [dictToUse[@"TaskListID"] indexOfObject:taskListID];
            NSMutableDictionary *returningTaskListItems = dictToUse[@"TaskListItems"][indexOfTaskListInreturningUpdatedTaskListDict];
            
            if ([taskListDict[@"TaskListID"] containsObject:taskListID]) {
                
                NSUInteger indexOfTaskInTaskListDict = [taskListDict[@"TaskListID"] indexOfObject:taskListID];
                NSMutableDictionary *taskListDictCopy = [taskListDict mutableCopy];
                NSMutableArray *taskListItemsArray = taskListDictCopy[@"TaskListItems"] ? [taskListDictCopy[@"TaskListItems"] mutableCopy] : [NSMutableArray array];
                if ([taskListItemsArray count] > indexOfTaskInTaskListDict) { [taskListItemsArray replaceObjectAtIndex:indexOfTaskInTaskListDict withObject:returningTaskListItems]; }
                [taskListDictCopy setObject:taskListItemsArray forKey:@"TaskListItems"];
                taskListDict = [taskListDictCopy mutableCopy];
                
            }
            
        }
        
    }
    
    return taskListDict;
}

-(void)AddTaskToSpecificTaskListAndRemoveFromAllTaskListsThatContainSpecificItem:(NSMutableDictionary *)taskListDict newTaskListName:(NSString *)newTaskListName itemUniqueIDArray:(NSArray *)itemUniqueIDArray itemUniqueIDDict:(NSDictionary *)itemUniqueIDDict completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningUpdatedTaskListDict, NSMutableDictionary *returningUpdatedTaskListDictNo1))finishBlock {
    
    NSMutableDictionary *taskListDictLocal = [taskListDict mutableCopy];
    
    __block NSMutableDictionary *returningUpdatedTaskListDictLocal = [NSMutableDictionary dictionary];
    __block NSMutableDictionary *returningUpdatedTaskListDictLocalNo1 = [NSMutableDictionary dictionary];
  
    [[[GeneralObject alloc] init] AddOrRemoveTaskToSpecificTaskList:taskListDictLocal newTaskListName:newTaskListName itemUniqueIDArray:itemUniqueIDArray AddTask:YES completionHandler:^(BOOL finished, NSMutableDictionary *returningUpdatedTaskListDict) {
       
        returningUpdatedTaskListDictLocal = [returningUpdatedTaskListDict mutableCopy];
       
        [[[GeneralObject alloc] init] AddOrRemoveTaskToAllTaskListsThatContainSpecificItem:taskListDictLocal newTaskListName:newTaskListName itemUniqueIDDict:itemUniqueIDDict AddTask:NO completionHandler:^(BOOL finished, NSMutableDictionary *returningUpdatedTaskListDict) {
          
            returningUpdatedTaskListDictLocalNo1 = [returningUpdatedTaskListDict mutableCopy];
            
            finishBlock(YES, returningUpdatedTaskListDictLocal, returningUpdatedTaskListDictLocalNo1);
            
        }];
        
    }];
    
}

-(void)AddTaskToSpecificTaskListAndRemoveFromDifferentSpecificTaskList:(NSMutableDictionary *)taskListDict newTaskListName:(NSString *)newTaskListName oldTaskListName:(NSString *)oldTaskListName itemUniqueIDArray:(NSArray *)itemUniqueIDArray completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningUpdatedTaskListDict, NSMutableDictionary *returningUpdatedTaskListDictNo1))finishBlock {
    
    NSMutableDictionary *taskListDictLocal = [taskListDict mutableCopy];
    
    __block NSMutableDictionary *returningUpdatedTaskListDictLocal = [NSMutableDictionary dictionary];
    __block NSMutableDictionary *returningUpdatedTaskListDictLocalNo1 = [NSMutableDictionary dictionary];
   
    [[[GeneralObject alloc] init] AddOrRemoveTaskToSpecificTaskList:taskListDictLocal newTaskListName:newTaskListName itemUniqueIDArray:itemUniqueIDArray AddTask:YES completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningUpdatedTaskListDict) {
        
        returningUpdatedTaskListDictLocal = [returningUpdatedTaskListDict mutableCopy];
      
        [[[GeneralObject alloc] init] AddOrRemoveTaskToSpecificTaskList:taskListDictLocal newTaskListName:oldTaskListName itemUniqueIDArray:itemUniqueIDArray AddTask:NO completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningUpdatedTaskListDict) {
            
            returningUpdatedTaskListDictLocalNo1 = [returningUpdatedTaskListDict mutableCopy];
           
            finishBlock(YES, returningUpdatedTaskListDictLocal, returningUpdatedTaskListDictLocalNo1);
            
        }];
        
    }];
    
}

-(void)AddOrRemoveTaskToSpecificTaskList:(NSMutableDictionary *)taskListDict newTaskListName:(NSString *)newTaskListName itemUniqueIDArray:(NSArray *)itemUniqueIDArray AddTask:(BOOL)AddTask completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningUpdatedTaskListDict))finishBlock {
    
    __block NSMutableDictionary *taskListDictLocal = [taskListDict mutableCopy];
    
    NSMutableDictionary *updateTaskListDict = [NSMutableDictionary dictionary];
    
    
    
    for (NSString *itemUniqueID in itemUniqueIDArray) {
        
        NSString *itemUniqueIDOuter = itemUniqueID;
        
        
        
        NSMutableDictionary *newTaskListDict = [[[GeneralObject alloc] init] GenerateDictWithSpecificTaskList:taskListDictLocal itemUniqueIDOuter:itemUniqueIDOuter newTaskListName:newTaskListName];
        NSString *newTaskListID = newTaskListDict[@"TaskListID"] ? newTaskListDict[@"TaskListID"] : @"xxx";
        NSMutableDictionary *newTaskListItems = [newTaskListDict[@"TaskListItems"] mutableCopy];
        
        
        
        NSMutableDictionary *taskListDictCopy = taskListDictLocal ? [taskListDictLocal mutableCopy] : [NSMutableDictionary dictionary];
        NSMutableArray *taskListItems = taskListDictLocal && taskListDictLocal[@"TaskListItems"] ? [taskListDictLocal[@"TaskListItems"] mutableCopy] : [NSMutableArray array];
        
        if ([taskListDict[@"TaskListID"] containsObject:newTaskListID]) {
            
            NSUInteger newTaskListIndex = [taskListDict[@"TaskListID"] indexOfObject:newTaskListID];
            
            if (AddTask == YES) {
                if ([[newTaskListItems allKeys] containsObject:itemUniqueID] == NO) { [newTaskListItems setObject:@{@"ItemUniqueID" : itemUniqueID} forKey:itemUniqueID];}
            } else if (AddTask == NO) {
                if ([[newTaskListItems allKeys] containsObject:itemUniqueID] == YES) { [newTaskListItems removeObjectForKey:itemUniqueID]; }
            }
            
            [newTaskListDict setObject:newTaskListItems forKey:@"TaskListItems"];
            
            if ([taskListItems count] > newTaskListIndex) { [taskListItems replaceObjectAtIndex:newTaskListIndex withObject:newTaskListItems]; }
           
            if ([updateTaskListDict[@"TaskListID"] containsObject:newTaskListID]) {
                
                NSUInteger index = [updateTaskListDict[@"TaskListID"] indexOfObject:newTaskListID];
                NSMutableDictionary *updateTaskListDictCopy = [updateTaskListDict mutableCopy];
                NSMutableArray *taskListItemsArray = [updateTaskListDictCopy[@"TaskListItems"] mutableCopy];
                [taskListItemsArray replaceObjectAtIndex:index withObject:newTaskListItems];
                [updateTaskListDictCopy setObject:taskListItemsArray forKey:@"TaskListItems"];
                updateTaskListDict = [updateTaskListDictCopy mutableCopy];
                
            } else {
                
                for (NSString *key in @[@"TaskListID", @"TaskListCreatedBy", @"TaskListItems"]) {
                
                    NSMutableArray *arr = updateTaskListDict[key] ? [updateTaskListDict[key] mutableCopy] : [NSMutableArray array];
                    id object = newTaskListDict[key] ? newTaskListDict[key] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                    [arr addObject:object];
                    [updateTaskListDict setObject:arr forKey:key];
                    
                }
                
            }
      
        }
        
        [taskListDictCopy setObject:taskListItems forKey:@"TaskListItems"];
        taskListDictLocal = [taskListDictCopy mutableCopy];
        
    }
    
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSMutableArray *objectArr = [NSMutableArray array];
        
        if ([(NSArray *)updateTaskListDict[@"TaskListID"] count] == 0) {
            finishBlock(YES, updateTaskListDict);
        }
        
        for (NSString *taskListID in updateTaskListDict[@"TaskListID"]) {
            
            NSUInteger index = [updateTaskListDict[@"TaskListID"] indexOfObject:taskListID];
            NSString *taskListCreatedBy = updateTaskListDict[@"TaskListCreatedBy"][index];
            NSString *taskListItems = updateTaskListDict[@"TaskListItems"][index];
            
            [[[SetDataObject alloc] init] UpdateDataTaskList:taskListCreatedBy taskListID:taskListID dataDict:@{@"TaskListItems" : taskListItems} completionHandler:^(BOOL finished) {
                
                if ([[[GeneralObject alloc] init] AddToObjectArrAndCheckIfQueryHasEnded:[updateTaskListDict[@"TaskListID"] mutableCopy] objectArr:objectArr]) {
                    
                    finishBlock(YES, updateTaskListDict);
                    
                }
                
            }];
            
        }
        
    });
    
}

-(void)AddOrRemoveTaskToAllTaskListsThatContainSpecificItem:(NSMutableDictionary *)taskListDict newTaskListName:(NSString *)newTaskListName itemUniqueIDDict:(NSDictionary *)itemUniqueIDDict AddTask:(BOOL)AddTask completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningUpdatedTaskListDict))finishBlock {
    
    NSMutableDictionary *updateTaskListDict = [NSMutableDictionary dictionary];
    
    for (NSString *itemUniqueID in [itemUniqueIDDict allKeys]) {
      
        NSString *specificItemUniqueID =
        itemUniqueIDDict[itemUniqueID] &&
        itemUniqueIDDict[itemUniqueID][@"SpecificItemUniqueID"] &&
        [itemUniqueIDDict[itemUniqueID][@"SpecificItemUniqueID"] length] > 0 ?
        itemUniqueIDDict[itemUniqueID][@"SpecificItemUniqueID"] : itemUniqueID;
       
        NSMutableDictionary *oldTaskListDict = [[[[GeneralObject alloc] init] GenerateDictOfTaskListsWithSpecificItem:taskListDict itemUniqueIDOuter:specificItemUniqueID] mutableCopy];
       
        NSMutableDictionary *taskListDictCopy = taskListDict ? [taskListDict mutableCopy] : [NSMutableDictionary dictionary];
        NSMutableArray *taskListItemsArray = taskListDictCopy && taskListDictCopy[@"TaskListItems"] ? [taskListDictCopy[@"TaskListItems"] mutableCopy] : [NSMutableArray array];
        
        NSMutableDictionary *oldTaskListDictCopy = oldTaskListDict ? [oldTaskListDict mutableCopy] : [NSMutableDictionary dictionary];
        NSMutableArray *oldTaskListItemsArray = oldTaskListDictCopy && oldTaskListDictCopy[@"TaskListItems"] ? [oldTaskListDictCopy[@"TaskListItems"] mutableCopy] : [NSMutableArray array];
        
       
        
        for (NSString *oldTaskListID in oldTaskListDictCopy[@"TaskListID"]) {
            
            
            
            NSUInteger oldTaskListIndex = [oldTaskListDictCopy[@"TaskListID"] indexOfObject:oldTaskListID];
            
            NSArray *keyArray = [[[GeneralObject alloc] init] GenerateTaskListKeyArray];
            NSMutableDictionary *dataDict = [[[[GeneralObject alloc] init] GenerateSingleObjectDictionary:oldTaskListDictCopy keyArray:keyArray indexPath:[NSIndexPath indexPathForRow:oldTaskListIndex inSection:0]] mutableCopy];
           
            NSString *oldTaskListName = dataDict[@"TaskListName"] ? [dataDict[@"TaskListName"] mutableCopy] : @"";
            NSMutableDictionary *oldTaskListItems = dataDict[@"TaskListItems"] ? [dataDict[@"TaskListItems"] mutableCopy] : [NSMutableDictionary dictionary];
        
           
            
            if ([oldTaskListName isEqualToString:newTaskListName] == NO) {
               
                if ([taskListDictCopy[@"TaskListID"] containsObject:oldTaskListID]) {
                    
                    NSUInteger oldTaskListIndex = [taskListDictCopy[@"TaskListID"] indexOfObject:oldTaskListID];
                    
                    if (AddTask == YES) {
                        if ([[oldTaskListItems allKeys] containsObject:itemUniqueID] == NO) { [oldTaskListItems setObject:@{@"ItemUniqueID" : itemUniqueID} forKey:itemUniqueID]; }
                    } else if (AddTask == NO) {
                        if ([[oldTaskListItems allKeys] containsObject:itemUniqueID] == YES) { [oldTaskListItems removeObjectForKey:itemUniqueID]; }
                    }
                    
                    [dataDict setObject:oldTaskListItems forKey:@"TaskListItems"];
                    
                    if ([oldTaskListItemsArray count] > oldTaskListIndex) { [oldTaskListItemsArray replaceObjectAtIndex:oldTaskListIndex withObject:oldTaskListItems]; }
                    if ([taskListItemsArray count] > oldTaskListIndex) { [taskListItemsArray replaceObjectAtIndex:oldTaskListIndex withObject:oldTaskListItems]; }
                    
                }
               
              
                
                if ([updateTaskListDict[@"TaskListID"] containsObject:oldTaskListID]) {
                   
                    NSUInteger index = [updateTaskListDict[@"TaskListID"] indexOfObject:oldTaskListID];
                    NSMutableDictionary *updateTaskListDictCopy = [updateTaskListDict mutableCopy];
                    NSMutableArray *taskListItemsArray = [updateTaskListDictCopy[@"TaskListItems"] mutableCopy];
                    [taskListItemsArray replaceObjectAtIndex:index withObject:oldTaskListItems];
                    [updateTaskListDictCopy setObject:taskListItemsArray forKey:@"TaskListItems"];
                    updateTaskListDict = [updateTaskListDictCopy mutableCopy];
              
                } else {
                   
                    for (NSString *key in @[@"TaskListID", @"TaskListCreatedBy", @"TaskListItems"]) {
                        
                        NSMutableArray *arr = updateTaskListDict[key] ? [updateTaskListDict[key] mutableCopy] : [NSMutableArray array];
                        id object = dataDict[key] ? dataDict[key] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                        [arr addObject:object];
                        [updateTaskListDict setObject:arr forKey:key];
                        
                    }
               
                }
          
            }
            
        }
        
        [oldTaskListDictCopy setObject:oldTaskListItemsArray forKey:@"TaskListItems"];
        oldTaskListDict = [oldTaskListDictCopy mutableCopy];
        
        
        [taskListDictCopy setObject:taskListItemsArray forKey:@"TaskListItems"];
        taskListDict = [taskListDictCopy mutableCopy];
        
    }
    
  
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSMutableArray *objectArr = [NSMutableArray array];
        
        if ([(NSArray *)updateTaskListDict[@"TaskListID"] count] == 0) {
            finishBlock(YES, updateTaskListDict);
        }
        
        for (NSString *taskListID in updateTaskListDict[@"TaskListID"]) {
            
            NSUInteger index = [updateTaskListDict[@"TaskListID"] indexOfObject:taskListID];
            NSString *taskListCreatedBy = updateTaskListDict[@"TaskListCreatedBy"][index];
            NSString *taskListItems = updateTaskListDict[@"TaskListItems"][index];
           
            [[[SetDataObject alloc] init] UpdateDataTaskList:taskListCreatedBy taskListID:taskListID dataDict:@{@"TaskListItems" : taskListItems} completionHandler:^(BOOL finished) {
                
                if ([[[GeneralObject alloc] init] AddToObjectArrAndCheckIfQueryHasEnded:[updateTaskListDict[@"TaskListID"] mutableCopy] objectArr:objectArr]) {
                    
                    finishBlock(YES, updateTaskListDict);
                    
                }
                
            }];
            
        }
        
    });
    
}

-(NSMutableDictionary *)GenerateDictWithSpecificTaskList:(NSMutableDictionary *)taskListDict itemUniqueIDOuter:(NSString *)itemUniqueIDOuter newTaskListName:(NSString *)newTaskListName {
    
    NSMutableDictionary *newTaskListDict = [NSMutableDictionary dictionary];
    
    NSUInteger newTaskListIndex = -1;
    
    NSString *newTaskListID = @"";
    NSString *newTaskListCreatedBy = @"";
    NSMutableDictionary *newTaskListItems = [NSMutableDictionary dictionary];
    
    if ([taskListDict[@"TaskListName"] containsObject:newTaskListName] && [newTaskListName isEqualToString:@"No List"] == NO) {
        
        newTaskListIndex = [taskListDict[@"TaskListName"] indexOfObject:newTaskListName];
        
        newTaskListID = [(NSArray *)taskListDict[@"TaskListID"] count] > newTaskListIndex ? taskListDict[@"TaskListID"][newTaskListIndex] : @"";
        newTaskListCreatedBy = [(NSArray *)taskListDict[@"TaskListCreatedBy"] count] > newTaskListIndex ? taskListDict[@"TaskListCreatedBy"][newTaskListIndex] : @"";
        newTaskListItems = [(NSArray *)taskListDict[@"TaskListItems"] count] > newTaskListIndex ? [taskListDict[@"TaskListItems"][newTaskListIndex] mutableCopy] : [NSMutableDictionary dictionary];
        
    }
    
    [newTaskListDict setObject:[NSString stringWithFormat:@"%lu", newTaskListIndex] forKey:@"TaskListIndex"];
    [newTaskListDict setObject:newTaskListID forKey:@"TaskListID"];
    [newTaskListDict setObject:newTaskListCreatedBy forKey:@"TaskListCreatedBy"];
    [newTaskListDict setObject:newTaskListItems forKey:@"TaskListItems"];
    
    return newTaskListDict;
}

-(NSMutableDictionary *)GenerateDictOfTaskListsWithSpecificItem:(NSMutableDictionary *)taskListDict itemUniqueIDOuter:(NSString *)itemUniqueIDOuter {
    
    NSMutableDictionary *oldTaskListDict = [NSMutableDictionary dictionary];
    
    for (NSString *taskListID in taskListDict[@"TaskListID"]) {
        
        NSUInteger index = [taskListDict[@"TaskListID"] indexOfObject:taskListID];
        NSArray *keyArray = [[[GeneralObject alloc] init] GenerateTaskListKeyArray];
        NSMutableDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSingleObjectDictionary:taskListDict keyArray:keyArray indexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        
        NSMutableDictionary *taskListItems = dataDict[@"TaskListItems"] ? [dataDict[@"TaskListItems"] mutableCopy] : [NSMutableDictionary dictionary];
        
        if ([[taskListItems allKeys] containsObject:itemUniqueIDOuter]) {
            
            for (NSString *key in keyArray) {
                NSMutableArray *arr = oldTaskListDict[key] ? [oldTaskListDict[key] mutableCopy] : [NSMutableArray array];
                id object = dataDict[key] ? dataDict[key] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                [arr addObject:object];
                [oldTaskListDict setObject:arr forKey:key];
            }
            
        }
        
    }
    
    return oldTaskListDict;
}


#pragma mark - Quiet Queries

-(void)AddQueryToDefaults:(NSArray *)collections documents:(NSArray *)documents type:(NSString *)type setData:(NSDictionary *)setData name:(NSString *)name queryID:(NSString *)queryID {
    
    NSMutableDictionary *queuedQueries = [[NSUserDefaults standardUserDefaults] objectForKey:@"QueuedQueries"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"QueuedQueries"] mutableCopy] : [NSMutableDictionary dictionary];
    
    NSDictionary *queryDict = @{@"Collections" : collections, @"Documents" : documents, @"Type" : type, @"SetData" : setData, @"Name" : name, @"QueryID" : queryID};
    [queuedQueries setObject:queryDict forKey:queryID];
    
    [[NSUserDefaults standardUserDefaults] setObject:queuedQueries forKey:@"QueuedQueries"];
    
}

-(void)AddNotificationQueryToDefaults:(NSArray *)notificationUsers notificationTitle:(NSString *)notificationTitle notificationBody:(NSString *)notificationBody setData:(NSDictionary *)setData notificationSettings:(NSDictionary *)notificationSettings notificationType:(NSString *)notificationType queryID:(NSString *)queryID {
    
    NSMutableDictionary *queuedQueries = [[NSUserDefaults standardUserDefaults] objectForKey:@"QueuedQueries"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"QueuedQueries"] mutableCopy] : [NSMutableDictionary dictionary];
    
    NSDictionary *queryDict = @{@"NotificationUsers" : notificationUsers, @"NotificationTitle" : notificationTitle, @"NotificationBody" : notificationBody, @"SetData" : setData, @"NotificationSettings" : notificationSettings, @"NotificationType" : notificationType, @"PusNotification" : @"", @"QueryID" : queryID};
    [queuedQueries setObject:queryDict forKey:queryID];
    
    [[NSUserDefaults standardUserDefaults] setObject:queuedQueries forKey:@"QueuedQueries"];
    
}

-(void)EditNotificationQueryToDefaults:(NSString *)userIDToRemove queryID:(NSString *)queryID {
    
    NSMutableDictionary *queuedQueries = [[NSUserDefaults standardUserDefaults] objectForKey:@"QueuedQueries"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"QueuedQueries"] mutableCopy] : [NSMutableDictionary dictionary];
    
    NSMutableDictionary *queryDict = queuedQueries[queryID] ? [queuedQueries[queryID] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableArray *notificationUsers = queryDict[@"NotificationUsers"] ? [queryDict[@"NotificationUsers"] mutableCopy] : [NSMutableArray array];
    if ([notificationUsers containsObject:userIDToRemove]) { [notificationUsers removeObject:userIDToRemove]; }
    [queryDict setObject:notificationUsers forKey:@"NotificationUsers"];
    [queuedQueries setObject:queryDict forKey:queryID];
    
    [[NSUserDefaults standardUserDefaults] setObject:queuedQueries forKey:@"QueuedQueries"];
    
}

-(void)RemoveQueryToDefaults:(NSString *)queryID {
    
    NSMutableDictionary *queuedQueries = [[NSUserDefaults standardUserDefaults] objectForKey:@"QueuedQueries"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"QueuedQueries"] mutableCopy] : [NSMutableDictionary dictionary];
    
    if (queuedQueries[queryID]) {
        [queuedQueries removeObjectForKey:queryID];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:queuedQueries forKey:@"QueuedQueries"];
    
}

#pragma mark - Premium Methods
//Remember to use sandbox url when testing
-(void)CheckPremiumSubscriptionStatus:(NSMutableDictionary *)homeMembersDict completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningHomeMembersDict))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        BOOL HomeMembersDictIsNotValid = (!homeMembersDict || (homeMembersDict && [(NSArray *)homeMembersDict[@"UserID"] count] == 0));
        
        if (HomeMembersDictIsNotValid) {NSLog(@"CheckPremiumSubscriptionStatus: HomeMembersDictIsNotValid");
            finishBlock(YES, homeMembersDict);
        } else {
            
            
            
            [[[GeneralObject alloc] init] CheckIfMyPremiumSubscriptionWasGivenByAdmin:homeMembersDict completionHandler:^(BOOL finished, BOOL SubscriptionWasGivenToMeByAdmin) {
                
                if (SubscriptionWasGivenToMeByAdmin == YES) {
                    
                    [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"PremiumSubscription"];
                    [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"HaveNotSavedCoreData"];
                    finishBlock(YES, homeMembersDict);
                    
                } else {
                    
                    
                    
                    [[[GeneralObject alloc] init] CheckIfMyPremiumSubscriptionWasGivenBySomeoneElse:homeMembersDict completionHandler:^(BOOL finished, BOOL SubscriptionWasGivenToMe, BOOL SubscriptionGivenByStillHasSubscription, NSString *purchasingUsersUsrID) {
                        
                        BOOL NoSubscriptionWasGivenToMe = (SubscriptionWasGivenToMe == NO && SubscriptionGivenByStillHasSubscription == NO);
                        BOOL SubscriptionWasGivenToMeAndPurchasingUserStillHasIt = (SubscriptionWasGivenToMe == YES && SubscriptionGivenByStillHasSubscription == YES);
                        BOOL SubscriptionWasGivenToMeAndPurchasingUserDoesNotHaveSubscriptionAnymore = (SubscriptionWasGivenToMe == YES && SubscriptionGivenByStillHasSubscription == NO);
                        
                        
                        
                        if (SubscriptionWasGivenToMeAndPurchasingUserStillHasIt == YES) {NSLog(@"CheckPremiumSubscriptionStatus: SubscriptionWasGivenToMeAndPurchasingUserStillHasIt");
                            
                            [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"PremiumSubscription"];
                            [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"HaveNotSavedCoreData"];
                            finishBlock(YES, homeMembersDict);
                            
                        } else {
                            
                            
                            
                            if (SubscriptionWasGivenToMeAndPurchasingUserDoesNotHaveSubscriptionAnymore == YES) {NSLog(@"CheckPremiumSubscriptionStatus: SubscriptionWasGivenToMeAndPurchasingUserDoesNotHaveSubscriptionAnymore");
                                
                                //Remove Subscription For All Users That Were Given Subscription From Purchasing User
                                [[[SetDataObject alloc] init] UpdateDataWeDivvyPremiumRemoveSubscriptionForGivenByUsers:purchasingUsersUsrID homeMembersDict:homeMembersDict completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningHomeMembersDict) {
                                    
                                    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"PremiumSubscription"] &&
                                        [[[NSUserDefaults standardUserDefaults] objectForKey:@"PremiumSubscription"] isEqualToString:@"Yes"]) {
                                        
                                        [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"PremiumSubscriptionJustCancelled"];
                                        
                                    }
                                    
                                    [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"PremiumSubscription"];
                                    [[[GeneralObject alloc] init] ResetNSUserDefaultsToNonPremium];
                                    finishBlock(YES, returningHomeMembersDict);
                                    
                                }];
                                
                            } else {
                                
                                
                                
                                //Scenarios:
                                //You Have A Subscription
                                //You Have A Subscription That Expired Or No Longer Exists
                                //You Don't Have A Subscription But Database Says You Does
                                if (NoSubscriptionWasGivenToMe == YES) {NSLog(@"CheckPremiumSubscriptionStatus: NoSubscriptionWasGivenToMe");
                                    
                                    BOOL SubscriptionWasPurchasedByMe = [[[GeneralObject alloc] init] SubscriptionWasPurchasedByMe:homeMembersDict];
                                    
                                    
                                    
                                    purchasingUsersUsrID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
                                    
                                    NSURL *receiptURL = [[NSBundle mainBundle] appStoreReceiptURL];
                                    NSData *receipt = [NSData dataWithContentsOfURL:receiptURL];
                                    
                                    
                                    
                                    //Scenarios:
                                    //You Have A Subscription
                                    //You Have A Subscription That Expired Or No Longer Exists
                                    if (receipt) {NSLog(@"CheckPremiumSubscriptionStatus: receipt");
                                        
                                        
                                        
                                        NSDictionary *receiptData = [[[GeneralObject alloc] init] GetReceiptData];
                                        
                                        NSURLRequest *storeRequest = receiptData[@"storeRequest"] ? receiptData[@"storeRequest"] : [[NSURLRequest alloc] init];
                                        NSData *requestData = receiptData[@"requestData"] ? receiptData[@"requestData"] : [NSData data];
                                        
                                        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
                                        
                                        
                                        
                                        [[session uploadTaskWithRequest:storeRequest fromData:requestData completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                            
                                            
                                            
                                            NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding] ? [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding] : @"";
                                            NSData *requestReplyData = [requestReply dataUsingEncoding:NSUTF8StringEncoding] ? [requestReply dataUsingEncoding:NSUTF8StringEncoding] : [NSData data];
                                            
                                            id SubscriptionData = [NSJSONSerialization JSONObjectWithData:requestReplyData options:0 error:nil] ? [NSJSONSerialization JSONObjectWithData:requestReplyData options:0 error:nil] : [NSMutableDictionary dictionary];
                                            
                                            
                                            
                                            id subscriptionRenewalInfo = SubscriptionData[@"pending_renewal_info"] ? SubscriptionData[@"pending_renewal_info"] : @[];
                                            //id subscriptionReceiptInfo = SubscriptionData[@"receipt"] ? SubscriptionData[@"receipt"] : @{};
                                            //id subscriptionLatestReceiptInfo = SubscriptionData[@"latest_receipt_info"] ? SubscriptionData[@"latest_receipt_info"] : @[];
                                            
                                            
                                            
                                            NSSet *productIdentifiers = [[[GeneralObject alloc] init] GenerateSubscriptionsKeyArray];
                                            
                                            BOOL SubscriptionExpired = (subscriptionRenewalInfo && [(NSArray *)subscriptionRenewalInfo count] > 0 && subscriptionRenewalInfo[0][@"expiration_intent"] && [subscriptionRenewalInfo[0][@"expiration_intent"] isEqualToString:@"0"] == NO);
                                            BOOL SubscriptionExists = (subscriptionRenewalInfo && [(NSArray *)subscriptionRenewalInfo count] > 0 && subscriptionRenewalInfo[0][@"auto_renew_product_id"] && [productIdentifiers containsObject:subscriptionRenewalInfo[0][@"auto_renew_product_id"]] == YES);
                                            
                                            
                                            
                                            //Scenarios:
                                            //You Have A Subscription
                                            if (SubscriptionExists == YES && SubscriptionExpired == NO) {NSLog(@"CheckPremiumSubscriptionStatus: SubscriptionExists == YES && SubscriptionExpired == NO");
                                                
                                                NSString *subscriptionDateLastOpenned = [[[GeneralObject alloc] init] GenerateCurrentDateString];
                                                
                                                [[[SetDataObject alloc] init] UpdateDataSubscriptionLastDateOpenned:subscriptionDateLastOpenned purchasingUsersUserID:purchasingUsersUsrID homeMembersDict:homeMembersDict completionHandler:^(BOOL finished) {
                                                    
                                                    [[[SetDataObject alloc] init] UpdataDataWeDivvyPremiumPurchasingUserHasWeDivvyPremiumButItIsNotShownInDatabase:homeMembersDict purchasingUsersUserID:purchasingUsersUsrID completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningHomeMembersDict) {
                                                        
                                                        [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"PremiumSubscription"];
                                                        [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"HaveNotSavedCoreData"];
                                                        finishBlock(YES, homeMembersDict);
                                                        
                                                    }];
                                                    
                                                }];
                                                
                                                //Scenarios:
                                                //You Have A Subscription That Expired Or No Longer Exists
                                            } else if (SubscriptionExists == NO || SubscriptionExpired == YES) {NSLog(@"CheckPremiumSubscriptionStatus: SubscriptionExists == NO || SubscriptionExpired == YES");
                                                
                                                NSString *subscriptionDateCancelled = [[[GeneralObject alloc] init] GenerateCurrentDateString];
                                                
                                                //Update Subscription To Cancelled
                                                [[[SetDataObject alloc] init] UpdateDataSubscriptionCancelled:@"Yes" subscriptionDateCancelled:subscriptionDateCancelled purchasingUsersUserID:purchasingUsersUsrID homeMembersDict:homeMembersDict completionHandler:^(BOOL finished) {
                                                    
                                                    //Remove Subscription For Myself
                                                    [[[SetDataObject alloc] init] UpdataDataWeDivvyPremiumPurchasingUserNoLongHasWeDivvyPremium:homeMembersDict purchasingUsersUserID:purchasingUsersUsrID completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningHomeMembersDict) {
                                                        
                                                        //Remove Subscription For All Users That Were Given Subscription From Purchasing User
                                                        [[[SetDataObject alloc] init] UpdateDataWeDivvyPremiumRemoveSubscriptionForGivenByUsers:purchasingUsersUsrID homeMembersDict:returningHomeMembersDict completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningHomeMembersDict) {
                                                            
                                                            if ([[NSUserDefaults standardUserDefaults] objectForKey:@"PremiumSubscription"] &&
                                                                [[[NSUserDefaults standardUserDefaults] objectForKey:@"PremiumSubscription"] isEqualToString:@"Yes"]) {
                                                                
                                                                [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"PremiumSubscriptionJustCancelled"];
                                                                
                                                            }
                                                            
                                                            [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"PremiumSubscription"];
                                                            [[[GeneralObject alloc] init] ResetNSUserDefaultsToNonPremium];
                                                            finishBlock(YES, returningHomeMembersDict);
                                                            
                                                        }];
                                                        
                                                    }];
                                                    
                                                }];
                                                
                                            } else {NSLog(@"CheckPremiumSubscriptionStatus: SubscriptionExists == NO || SubscriptionExpired == NO");
                                                
                                                if ([[NSUserDefaults standardUserDefaults] objectForKey:@"PremiumSubscription"] &&
                                                    [[[NSUserDefaults standardUserDefaults] objectForKey:@"PremiumSubscription"] isEqualToString:@"Yes"]) {
                                                    
                                                    [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"PremiumSubscriptionJustCancelled"];
                                                    
                                                }
                                                
                                                [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"PremiumSubscription"];
                                                [[[GeneralObject alloc] init] ResetNSUserDefaultsToNonPremium];
                                                finishBlock(YES, homeMembersDict);
                                                
                                            }
                                            
                                        }] resume];
                                        
                                        
                                        
                                        //Scenarios:
                                        //You Don't Have A Subscription But Database Says You Do
                                    } else {
                                        
                                        BOOL SubscriptionWasPurchasedByMeAndNoSubscriptionFound = SubscriptionWasPurchasedByMe == YES;
                                        
                                        if (SubscriptionWasPurchasedByMeAndNoSubscriptionFound == YES) {NSLog(@"CheckPremiumSubscriptionStatus: SubscriptionWasPurchasedByMeAndNoSubscriptionFound");
                                            
                                            NSString *subscriptionDateCancelled = [[[GeneralObject alloc] init] GenerateCurrentDateString];
                                            
                                            //Update Subscription To Cancelled
                                            [[[SetDataObject alloc] init] UpdateDataSubscriptionCancelled:@"Yes" subscriptionDateCancelled:subscriptionDateCancelled purchasingUsersUserID:purchasingUsersUsrID homeMembersDict:homeMembersDict completionHandler:^(BOOL finished) {
                                                
                                                //Remove Subscription For Myself
                                                [[[SetDataObject alloc] init] UpdataDataWeDivvyPremiumPurchasingUserNoLongHasWeDivvyPremium:homeMembersDict purchasingUsersUserID:purchasingUsersUsrID completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningHomeMembersDict) {
                                                    
                                                    //Remove Subscription For All Users That Were Given Subscription From Purchasing User
                                                    [[[SetDataObject alloc] init] UpdateDataWeDivvyPremiumRemoveSubscriptionForGivenByUsers:purchasingUsersUsrID homeMembersDict:returningHomeMembersDict completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningHomeMembersDict) {
                                                        
                                                        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"PremiumSubscription"] &&
                                                            [[[NSUserDefaults standardUserDefaults] objectForKey:@"PremiumSubscription"] isEqualToString:@"Yes"]) {
                                                            
                                                            [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"PremiumSubscriptionJustCancelled"];
                                                            
                                                        }
                                                        
                                                        [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"PremiumSubscription"];
                                                        [[[GeneralObject alloc] init] ResetNSUserDefaultsToNonPremium];
                                                        finishBlock(YES, returningHomeMembersDict);
                                                        
                                                    }];
                                                    
                                                }];
                                                
                                            }];
                                            
                                        } else {NSLog(@"CheckPremiumSubscriptionStatus: SubscriptionWasPurchasedByMeAndNoSubscriptionFound == NO");
                                            
                                            if ([[NSUserDefaults standardUserDefaults] objectForKey:@"PremiumSubscription"] &&
                                                [[[NSUserDefaults standardUserDefaults] objectForKey:@"PremiumSubscription"] isEqualToString:@"Yes"]) {
                                                
                                                [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"PremiumSubscriptionJustCancelled"];
                                                
                                            }
                                            
                                            [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"PremiumSubscription"];
                                            [[[GeneralObject alloc] init] ResetNSUserDefaultsToNonPremium];
                                            finishBlock(YES, homeMembersDict);
                                            
                                        }
                                        
                                    }
                                    
                                } else {NSLog(@"CheckPremiumSubscriptionStatus: NoSubscriptionWasGivenToMe == NO");
                                    
                                    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"PremiumSubscription"] &&
                                        [[[NSUserDefaults standardUserDefaults] objectForKey:@"PremiumSubscription"] isEqualToString:@"Yes"]) {
                                        
                                        [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"PremiumSubscriptionJustCancelled"];
                                        
                                    }
                                    
                                    [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"PremiumSubscription"];
                                    [[[GeneralObject alloc] init] ResetNSUserDefaultsToNonPremium];
                                    finishBlock(YES, homeMembersDict);
                                    
                                }
                                
                            }
                            
                        }
                        
                    }];
                    
                }
                
            }];
            
        }
        
    });
    
}

#pragma mark - System Info Methods

-(float)GetSystemVersion {
    
    NSString *sysVer = [[UIDevice currentDevice] systemVersion];
    [[NSUserDefaults standardUserDefaults] setObject:sysVer forKey:@"systemVersion"];
    
    float sysVerFloat = [[[NSUserDefaults standardUserDefaults] objectForKey:@"systemVersion"] floatValue];
    
    return sysVerFloat;
    
}

-(CGFloat)GetStatusBarHeight {
    
    CGFloat statusBarSizeHeight = 0.0;
    
    UIWindow *currentwindow = [UIApplication sharedApplication].windows.firstObject;
    UIView *statusBar = [[UIView alloc]initWithFrame:currentwindow.windowScene.statusBarManager.statusBarFrame];
    statusBarSizeHeight = statusBar.frame.size.height;
    
    if (@available(iOS 13.0, *)) {
        
        UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
        CGFloat x = window.safeAreaInsets.top;
        statusBarSizeHeight = x;
        
    } else {
        
        UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
        CGFloat statusBar = window.windowScene.statusBarManager.statusBarFrame.size.height;
        statusBarSizeHeight = statusBar;
        
    }
    
    return statusBarSizeHeight;
    
}

-(CGFloat)GetNavigationBarHeight:(UIViewController *)currentViewController {
    
    CGFloat navigationBarHeight = currentViewController.navigationController.navigationBar.frame.origin.y + currentViewController.navigationController.navigationBar.frame.size.height;
    
    if (navigationBarHeight > 0) {
        
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f", navigationBarHeight] forKey:@"NavigationBarHeight"];
        
    } else if (navigationBarHeight < 0 && [[NSUserDefaults standardUserDefaults] objectForKey:@"NavigationBarHeight"]) {
        
        navigationBarHeight = [[[NSUserDefaults standardUserDefaults] objectForKey:@"NavigationBarHeight"] floatValue];
        
    }
    
    return navigationBarHeight;
    
}

-(CGFloat)GetBottomPaddingHeight {
    
    CGFloat bottomPadding = 0.0;
    
    if (@available(iOS 11.0, *)) {
        
        UIWindow *window = [UIApplication sharedApplication].windows.firstObject;//UIWindow *window = UIApplication.sharedApplication.keyWindow;
        bottomPadding = window.safeAreaInsets.bottom;
        
    }
    
    return bottomPadding;
    
}

#pragma mark - NSUserDefault Methods

-(void)RemoveCachedInitialDataNSUserDefaults:(BOOL)RemoveHomeMembersDict {
    
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TempItemDict"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TempDisplaySectionsArray"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TempDisplayDict"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TempDisplayAmountDict"];
//    
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TempItemDictNo1"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TempDisplaySectionsArrayNo1"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TempDisplayDictNo1"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TempDisplayAmountDictNo1"];
//    
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TempItemDictNo2"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TempDisplaySectionsArrayNo2"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TempDisplayDictNo2"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TempDisplayAmountDictNo2"];
//    
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TempCategoryNameArray"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TempCategoryImageArray"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TempCategoryIDArray"];
//    
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TempSideBarSectionsArray"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TempSideBarCategorySectionArrayOriginal"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TempSideBarCategorySectionArrayAltered"];
//    
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ChoreDict"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ExpenseDict"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ListDict"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ChatDict"];
//    
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"HomeMembersArray"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"HomeDict"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"HomeKeysDict"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"HomeKeysArray"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"HomeMembersUnclaimedDict"];
    
    //Need this for setting up local notifications when app is closed
    if (RemoveHomeMembersDict == YES) { [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"HomeMembersDict"]; }
    
    //    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"NotificationSettingsDict"];
    //    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"CalendarSettingsDict"];
    //
    //    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SideBarCategorySectionArrayOriginal"];
    //    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SideBarCategorySectionArrayAltered"];
    //
    //    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"FolderDict"];
    //    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TaskListDict"];
    //    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SectionDict"];
    //    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TemplateDict"];
    //
    //    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ChatDict"];
    //    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"UnreadMessageDictChats"];
    //    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"LastMessageDict"];
    //
    //    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SuggestedDict"];
    //    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"UnreadActivityDict"];
    
}

-(void)RemoveHomeDataNSUserDefaults {
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TwoWeekReminderProcessing"];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ViewingExpenses"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ViewingLists"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ViewingChats"];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TouchEventDict"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SideBarCollapseSectionsArray"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"CurrentFeedbackID"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SortSelectedDefaultUser"];
    
}

-(void)RemoveAppDataNSUserDefaults {
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ComingFromShortcut"];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"MixPanelCurrentDate"]) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"MixPanelCurrentDate"];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"TempMixPanelCurrentDate"]) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TempMixPanelCurrentDate"];
    }
    
}

#pragma mark - Generate Methods

-(NSString *)GenerateItemType {
    
    NSString *itemType = @"x";
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"ViewingExpenses"] && [[[NSUserDefaults standardUserDefaults] objectForKey:@"ViewingExpenses"] isEqualToString:@"Yes"]) {
        
        itemType = @"Expense";
        
    } else if ([[NSUserDefaults standardUserDefaults] objectForKey:@"ViewingLists"] && [[[NSUserDefaults standardUserDefaults] objectForKey:@"ViewingLists"] isEqualToString:@"Yes"]) {
        
        itemType = @"List";
        
    } else if ([[NSUserDefaults standardUserDefaults] objectForKey:@"ViewingChats"] && [[[NSUserDefaults standardUserDefaults] objectForKey:@"ViewingChats"] isEqualToString:@"Yes"]) {
        
        itemType = @"GroupChat";
        
    } else if (
               
               ([[[NSUserDefaults standardUserDefaults] objectForKey:@"ViewingExpenses"] isEqualToString:@"No"] || ![[NSUserDefaults standardUserDefaults] objectForKey:@"ViewingExpenses"]) &&
               
               ([[[NSUserDefaults standardUserDefaults] objectForKey:@"ViewingLists"] isEqualToString:@"No"] || ![[NSUserDefaults standardUserDefaults] objectForKey:@"ViewingLists"]) &&
               
               ([[[NSUserDefaults standardUserDefaults] objectForKey:@"ViewingChats"] isEqualToString:@"No"] || ![[NSUserDefaults standardUserDefaults] objectForKey:@"ViewingChats"])) {
                   
                   itemType = @"Chore";
                   
               }
    
    return itemType;
    
}

-(NSString *)GenerateRandomESTNumberIntoString {
    
    NSString *dateString = [[[GeneralObject alloc] init] GenerateESTCurrentDateWithFormat:@"yyyy-MM-dd HH:mm:ss" returnAs:[NSString class]];
    
    long lowerBound = 100;
    long upperBound = 10000000;
    long rndValue = lowerBound + arc4random() % (upperBound - lowerBound);
    NSString *num = [NSString stringWithFormat:@"%@%ld", dateString,rndValue];
    
    if ([num containsString:@" AM"]) {
        
        num = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:num arrayOfSymbols:@[@" AM"]];
        
    } else if ([num containsString:@" PM"]) {
        
        num = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:num arrayOfSymbols:@[@" PM"]];
        
    } else if ([num containsString:@" am"]) {
        
        num = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:num arrayOfSymbols:@[@" am"]];
        
    } else if ([num containsString:@" pm"]) {
        
        num = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:num arrayOfSymbols:@[@" pm"]];
        
    } else if ([num containsString:@" a.m."]) {
        
        num = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:num arrayOfSymbols:@[@" a.m."]];
        
    } else if ([num containsString:@" p.m."]) {
        
        num = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:num arrayOfSymbols:@[@" p.m."]];
        
    }
    
    return num;
    
}

-(NSString *)GenerateRandomSmallNumberIntoString:(long)lowerBound upperBound:(long)upperBound {
    
    long rndValue = lowerBound + arc4random() % (upperBound - lowerBound);
    NSString *num = [NSString stringWithFormat:@"%ld", rndValue];
    
    return num;
    
}

-(NSString *)GenerateRandomSmallAlphaNumberIntoString:(int)len {
    
    NSString *letters = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSString *num = @"";
    for (int i=0 ; i<len ; i++) {
        long rndValue = 0 + arc4random() % (35 - 0);
        char randomChar = [letters characterAtIndex:rndValue];
        num = [NSString stringWithFormat:@"%@%c", num, randomChar];
    }
    
    return num;
}

-(NSString *)GenerateWhenDueNotificationBody:(NSString *)itemType itemAssignedTo:(NSMutableArray *)itemAssignedTo homeMembersDict:(NSMutableDictionary *)homeMembersDict {
    
    NSString *whenDueString = [NSString stringWithFormat:@"This %@ is due now. It was completed in time! 🎉", [itemType lowercaseString]];
    
    if ([itemAssignedTo count] > 0 && homeMembersDict[@"UserID"] && [(NSArray *)homeMembersDict[@"UserID"] count] > 0 && homeMembersDict[@"Username"] && [(NSArray *)homeMembersDict[@"Username"] count] > 0) {
        
        NSMutableArray *itemAssignedToUsername = [NSMutableArray array];
        whenDueString = @"";
        
        for (NSString *userID in itemAssignedTo) {
            
            NSDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:userID homeMembersDict:homeMembersDict];
            NSString *username = dataDict[@"Username"];
            [itemAssignedToUsername addObject:username];
            
        }
        
        NSString *dueNowOrGracePeriod = [NSString stringWithFormat:@"This %@ is due now.", [itemType lowercaseString]];
        
        if (itemAssignedToUsername.count == 1) {
            
            whenDueString = [NSString stringWithFormat:@"%@ %@ completed it in time! 🎉", dueNowOrGracePeriod, itemAssignedToUsername[0]];
            
        } else if (itemAssignedToUsername.count > 1) {
            
            whenDueString = [NSString stringWithFormat:@"This %@ is due now. ", [itemType lowercaseString]];
            
            for (int i=0;i<itemAssignedToUsername.count;i++) {
                
                if (i == 0) {
                    
                    whenDueString = [NSString stringWithFormat:@"%@%@", whenDueString, itemAssignedToUsername[i]];
                    
                } else if (i == itemAssignedToUsername.count-1) {
                    
                    NSString *commaString = itemAssignedToUsername.count == 2 ? @"" : @",";
                    
                    whenDueString = [NSString stringWithFormat:@"%@%@ and %@ completed it in time! 🎉", whenDueString, commaString, itemAssignedToUsername[itemAssignedToUsername.count-1]];
                    
                } else {
                    
                    whenDueString = [NSString stringWithFormat:@"%@, %@", whenDueString, itemAssignedToUsername[i]];
                    
                }
                
            }
            
        }
        
    }
    
    return whenDueString;
}

-(NSDictionary *)GenerateDefaultRemindersDict:(NSString *)itemType itemAssignedTo:(NSMutableArray *)itemAssignedTo itemRepeats:(NSString *)itemRepeats homeMembersDict:(NSMutableDictionary *)homeMembersDict AnyTime:(BOOL)AnyTime {
    
    if (AnyTime == YES) {
        if (([itemRepeats isEqualToString:@"Daily"] || [itemRepeats containsString:@"Hour"]) == YES) {
            return @{
                @"On The Day at 9:00 AM" : @"",
            };
        } else {
            return @{
                @"1 Day Before at 9:00 AM" : @"",
                @"On The Day at 9:00 AM" : @"",
            };
        }
        
    }
    
    NSString *whenDueString = [[[GeneralObject alloc] init] GenerateWhenDueNotificationBody:itemType itemAssignedTo:itemAssignedTo homeMembersDict:homeMembersDict];
    
    NSDictionary *dataDict = @{
        @"2 Hours Before" : @{@"Body" : [NSString stringWithFormat:@"This %@ is due in 2 hours", [itemType lowercaseString]], @"Option" : @"Option 1"},
        @"Due Now" : @{@"Body" : whenDueString, @"Option" : @"Option 3"}
    };
    
    return dataDict;
}

-(NSDictionary *)GenerateDefaultNotificationSettingsDict:(NSString *)userID addMorningOverView:(BOOL)addMorningOverView addEveningOverView:(BOOL)addEveningOverView {
    
    NSMutableDictionary *summaries = [NSMutableDictionary dictionary];
    
    if (addMorningOverView) {
        [summaries setObject:@{@"Name" : @"Morning Overview", @"Frequency" : @"Daily", @"Day" : @"", @"Time" : @"10:00 AM"} forKey:@"Morning Overview"];
    }
    if (addEveningOverView) {
        [summaries setObject:@{@"Name" : @"Evening Overview", @"Frequency" : @"Daily", @"Day" : @"", @"Time" : @"6:00 PM"} forKey:@"Evening Overview"];
    }
    
    NSString *myUserID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
    
    NSDictionary *dataDict = @{
        
        @"UserID" : myUserID,
        
        @"AllowNotifications" : @"Yes",
        
        @"DaysOfTheWeek" : @[@"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"Saturday", @"Sunday"],
        
        @"Sound" : @"Default",
        @"BadgeIcon" : @"Yes",
        
        @"Chores" : @{
            
            @"Adding" : @"Yes",
            @"Editing" : @"Yes",
            @"Deleting" : @"Yes",
            @"Duplicating" : @"Yes",
            @"Waiving" : @"Yes",
            @"Skipping" : @"Yes",
            @"Pause/Unpause" : @"Yes",
            @"Comments" : @"Yes",
            
            @"SkippingTurn" : @"Yes",
            @"RemovingUser" : @"Yes",
            
            @"FullyCompleted" : @"Yes",
            @"Completed" : @"Yes",
            @"InProgress" : @"Yes",
            @"WontDo" : @"Yes",
            @"Accept" : @"Yes",
            @"Decline" : @"Yes",
            
            @"DueDate" : @"Yes",
            @"Reminder" : @"Yes",
            
            @"SubtaskEditing" : @"Yes",
            @"SubtaskDeleting" : @"Yes",
            
            @"SubtaskCompleted" : @"Yes",
            @"SubtaskInProgress" : @"Yes",
            @"SubtaskWontDo" : @"Yes",
            @"SubtaskAccept" : @"Yes",
            @"SubtaskDecline" : @"Yes",
            
        },
        
        @"Expenses" : @{
            
            @"Adding" : @"Yes",
            @"Editing" : @"Yes",
            @"Deleting" : @"Yes",
            @"Duplicating" : @"Yes",
            @"Waiving" : @"Yes",
            @"Skipping" : @"Yes",
            @"Pause/Unpause" : @"Yes",
            @"Comments" : @"Yes",
            
            @"SkippingTurn" : @"Yes",
            @"RemovingUser" : @"Yes",
            
            @"FullyCompleted" : @"Yes",
            @"Completed" : @"Yes",
            @"InProgress" : @"Yes",
            @"WontDo" : @"Yes",
            @"Accept" : @"Yes",
            @"Decline" : @"Yes",
            
            @"DueDate" : @"Yes",
            @"Reminder" : @"Yes",
            
            @"EditingItemizedItem" : @"Yes",
            @"DeletingItemizedItem" : @"Yes",
            
        },
        
        @"Lists" : @{
            
            @"Adding" : @"Yes",
            @"Editing" : @"Yes",
            @"Deleting" : @"Yes",
            @"DeletingPermanently" : @"Yes",
            @"Duplicating" : @"Yes",
            @"Waiving" : @"Yes",
            @"Skipping" : @"Yes",
            @"Pause/Unpause" : @"Yes",
            @"Comments" : @"Yes",
            
            @"FullyCompleted" : @"Yes",
            @"Completed" : @"Yes",
            @"InProgress" : @"Yes",
            @"WontDo" : @"Yes",
            @"Accept" : @"Yes",
            @"Decline" : @"Yes",
            
            @"DueDate" : @"Yes",
            @"Reminder" : @"Yes",
            
            @"AddingListItem" : @"Yes",
            @"EditingListItem" : @"Yes",
            @"DeletingListItem" : @"Yes",
            @"ResetingListItem" : @"Yes",
            
        },
        
        @"GroupChats" : @{
            
            @"Adding" : @"Yes",
            @"Editing" : @"Yes",
            @"Deleting" : @"Yes",
            
            @"GroupChatMessages" : @"Yes",
            @"LiveSupportMessages" : @"Yes",
            
        },
        
        @"HomeMembers_NotificationSettings" : @{
            
            @"SendingInvitations" : @"Yes",
            @"DeletingInvitations" : @"Yes",
            
            @"NewHomeMembers" : @"Yes",
            @"HomeMembersMovedOut" : @"Yes",
            @"HomeMembersKickedOut" : @"Yes",
            
        },
        
        @"Forum" : @{
            
            @"BugForumUpvotes" : @"Yes",
            @"FeatureForumUpvotes" : @"Yes",
            
        },
        
        @"ScheduledSummary" : @{}
        //
        //            @"Activated" : @"Yes",
        //            @"Summaries" : summaries,
        //            @"TaskTypes" : @{@"ItemTaskTypes" : @[@"Chores", @"Expenses", @"Lists"], @"DueDates" : @[@"Past Due", @"Due Today", @"Due Tomorrow", @"Due Next 7 Days"], @"Priority" : @[@"High"], @"Color" : @[], @"Tags" : @[], @"AssignedTo" : @[userID]}
        //
        //        }
        
    };
    
    return dataDict;
}

-(NSDictionary *)GenerateDefaultCalendarSettingsDict {
    
    NSDictionary *dataDict = @{
        
        @"DatePosted" : @{@"Chores" : @"Yellow", @"Expenses" : @"Yellow", @"Lists" : @"Yellow"},
        @"DueDates" : @{@"Chores" : @"Red", @"Expenses" : @"Red", @"Lists" : @"Red"},
        @"Marked" : @{@"Completed" : @"Green", @"In Progress" : @"Green", @"Won't Do" : @"Green"}
        
    };
    
    return dataDict;
}

-(NSDictionary *)GenerateDefaultFirstTemplatesDict:(NSString *)userID {
    
    NSDictionary *dataDict = @{@"TemplateName" : @"Monthly Task",
                               @"TemplateDefault" : @"No",
                               @"TemplateCreatedBy" : userID,
                               @"TemplateID" : @"1",
                               @"TemplateDateCreated" : @"x",
                               @"TemplateData" : @{@"ItemRepeats" : @"Monthly", @"ItemDays" : @"Last Day"}};
    
    return dataDict;
}

-(NSDictionary *)GenerateDefaultWeDivvyPremiumPlan {
    
    NSDictionary *dataDict = @{@"SubscriptionPlan" : @"", @"SubscriptionFrequency" : @"", @"SubscriptionDatePurchased" : @"", @"SubscriptionGivenBy" : @"", @"SubscriptionHistory" : @{}};
    
    return dataDict;
}

-(NSString *)GenerateShareString:(NSMutableDictionary *)itemDict arrayOfUniqueIDs:(NSArray *)arrayOfUniqueIDs itemType:(NSString *)itemType keyArray:(NSArray *)keyArray homeMembersDict:(NSMutableDictionary *)homeMembersDict {
    
    NSString *shareString = @"";
    
    NSString *title = [NSString stringWithFormat:@"%@s\n\n*************************************\n\n", itemType];
    NSString *body = @"";
    NSString *tag = [NSString stringWithFormat:@"\n\nFrom The WeDivvy App.\nAvailable for free on iPhone."];
    
    if ([arrayOfUniqueIDs count] > 0) {
        
        for (NSString *itemUniqueID in arrayOfUniqueIDs) {
            
            NSMutableDictionary *singleObjectItemDict = [NSMutableDictionary dictionary];
            
            NSUInteger index = [itemDict[@"ItemUniqueID"] indexOfObject:itemUniqueID];
            
            singleObjectItemDict = [[[GeneralObject alloc] init] GenerateSingleObjectDictionary:itemDict keyArray:keyArray indexPath:[NSIndexPath indexPathForRow:index inSection:0]];
            
            NSString *itemName = singleObjectItemDict[@"ItemName"] ? singleObjectItemDict[@"ItemName"] : @"";
            
            
            
            
            NSString *itemDictItemsString = @"";
            
            itemDictItemsString =
            [[[[GeneralObject alloc] init] GenerateSubTaskShareString:singleObjectItemDict itemType:itemType homeMembersDict:homeMembersDict] length] > 0 ?
            [[[GeneralObject alloc] init] GenerateSubTaskShareString:singleObjectItemDict itemType:itemType homeMembersDict:homeMembersDict] : itemDictItemsString;
            
            itemDictItemsString =
            [[[[GeneralObject alloc] init] GenerateCostPerPersonShareString:singleObjectItemDict itemType:itemType homeMembersDict:homeMembersDict] length] > 0 ?
            [[[GeneralObject alloc] init] GenerateCostPerPersonShareString:singleObjectItemDict itemType:itemType homeMembersDict:homeMembersDict] : itemDictItemsString;
            
            itemDictItemsString =
            [[[[GeneralObject alloc] init] GenerateItemizedItemsShareString:singleObjectItemDict itemType:itemType homeMembersDict:homeMembersDict] length] > 0 ?
            [[[GeneralObject alloc] init] GenerateItemizedItemsShareString:singleObjectItemDict itemType:itemType homeMembersDict:homeMembersDict] : itemDictItemsString;
            
            itemDictItemsString =
            [[[[GeneralObject alloc] init] GenerateListItemsShareString:singleObjectItemDict itemType:itemType homeMembersDict:homeMembersDict] length] > 0 ?
            [[[GeneralObject alloc] init] GenerateListItemsShareString:singleObjectItemDict itemType:itemType homeMembersDict:homeMembersDict] : itemDictItemsString;
            
            
            
            
            NSString *itemDueDateShareString = [[[GeneralObject alloc] init] GenerateItemDueDateShareString:singleObjectItemDict itemType:itemType];
            NSString *itemNotesShareString = [[[GeneralObject alloc] init] GenerateItemNotesShareString:singleObjectItemDict];
            
            
            
            
            if ([body length] == 0) {
                
                body =
                [NSString stringWithFormat:@"%@%@\n   - %@%@\n\n*************************************",
                 itemName,
                 itemDictItemsString,
                 itemDueDateShareString,
                 itemNotesShareString];
                
            } else {
                
                body =
                [NSString stringWithFormat:@"%@\n\n%@%@\n   - %@%@\n\n*************************************",
                 body,
                 itemName,
                 itemDictItemsString,
                 itemDueDateShareString,
                 itemNotesShareString];
                
            }
            
        }
        
    }
    
    
    
    
    shareString = [NSString stringWithFormat:@"%@%@%@", title, body, tag];
    
    return shareString;
}

-(NSMutableArray *)GenerateArrayID:(id _Nullable)object {
    
    NSMutableArray *array = [NSMutableArray array];
    
    BOOL ObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:object classArr:@[[NSArray class], [NSMutableArray class]]];
    
    array = ObjectIsKindOfClass ?
    [object mutableCopy] :
    object == nil || object == NULL || [object length] == 0 ? [NSMutableArray array] : [[object componentsSeparatedByString:@"*** "] mutableCopy];
    
    return array;
}

-(id)GenerateDictionaryID:(id _Nullable)object {
    
    id jsonOutput = object;
    NSData *data;
    
    BOOL ObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:object classArr:@[[NSDictionary class], [NSMutableDictionary class]]];
    
    if (ObjectIsKindOfClass == NO) {
        
        data = [object dataUsingEncoding:NSUTF8StringEncoding];
        jsonOutput = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
    }
    
    return [jsonOutput mutableCopy];
}


#pragma mark - Generate Dictionaries & Arrays

-(NSMutableArray *)GenerateArrayInReverse:(NSMutableArray *)arrayToUse {
    
    NSMutableArray *reverseArray = [NSMutableArray array];
    
    for (int i=(int)arrayToUse.count-1;i>-1;i--) {
        
        [reverseArray addObject:arrayToUse[i]];
    }
    
    return reverseArray;
}

-(NSMutableDictionary *)GenerateDictOfArraysInReverse:(NSMutableDictionary *)dictToUse {
    
    for (NSString *key in [dictToUse allKeys]) {
        
        NSMutableArray *originalArray = dictToUse[key] ? [dictToUse[key] mutableCopy] : [NSMutableArray array];
        NSMutableArray *reverseArray = [NSMutableArray array];
        
        for (int i=(int)originalArray.count-1;i>-1;i--) {
            
            [reverseArray addObject:originalArray[i]];
        }
        
        [dictToUse setObject:reverseArray forKey:key];
        
    }
    
    return dictToUse;
}

-(NSMutableDictionary *)GenerateSingleObjectDictionary:(NSMutableDictionary *)itemDictToUse keyArray:(NSArray *)keyArray indexPath:(NSIndexPath * _Nullable)indexPath {
    
    NSMutableDictionary *dictToUse = [itemDictToUse mutableCopy];
    
    NSMutableDictionary *dictToUseSingleObject = [NSMutableDictionary dictionary];
    
    for (NSString *key in keyArray) {
        
        id object = [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
        
        if (indexPath != nil && indexPath != NULL) {
            
            object = dictToUse && dictToUse[key] && [(NSArray *)dictToUse[key] count] > indexPath.row ? dictToUse[key][indexPath.row] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
            
        } else {
            
            object = dictToUse && dictToUse[key] ? dictToUse[key] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
            
        }
        
        [dictToUseSingleObject setObject:object forKey:key];
        
    }
    
    return dictToUseSingleObject;
}

-(NSMutableDictionary *)GenerateSingleArraySingleObjectDictionary:(NSMutableDictionary *)itemDictToUse keyArray:(NSArray *)keyArray indexPath:(NSIndexPath * _Nullable)indexPath {
    
    NSMutableDictionary *dictToUse = [itemDictToUse mutableCopy];
    
    NSMutableDictionary *dictToUseSingleObject = [NSMutableDictionary dictionary];
    
    for (NSString *key in keyArray) {
        
        NSMutableArray *arr = dictToUseSingleObject[key] ? [dictToUseSingleObject[key] mutableCopy] : [NSMutableArray array];
        
        id object = [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
        
        if (indexPath != nil && indexPath != NULL) {
            
            object = dictToUse && dictToUse[key] && [(NSArray *)dictToUse[key] count] > indexPath.row ? dictToUse[key][indexPath.row] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
            
        } else {
            
            object = dictToUse && dictToUse[key] ? dictToUse[key] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
            
        }
        
        [arr addObject:object];
        
        [dictToUseSingleObject setObject:arr forKey:key];
        
    }
    
    return dictToUseSingleObject;
}

-(NSMutableDictionary *)GenerateSpecificUserDataBasedOnKey:(NSString *)key object:(NSString *)object homeMembersDict:(NSMutableDictionary *)homeMembersDict {
    
    NSUInteger index = homeMembersDict[key] && [homeMembersDict[key] containsObject:object] ? [homeMembersDict[key] indexOfObject:object] : 1000;
    NSArray *keyArray = [[[GeneralObject alloc] init] GenerateUserKeyArray];
    
    NSMutableDictionary *specificHomeMemberDict = [@{@"Username" : @"", @"UserID" : @"", @"ProfileImageURL" : @"", @"Notifications" : @"", @"Email" : @"", @"HeardAboutUs" : @"", @"ReceiveUpdateEmails" : @"", @"WeDivvyPremium" : [[[GeneralObject alloc] init] GenerateDefaultWeDivvyPremiumPlan]} mutableCopy];
    
    if (index != 1000) {
        
        for (NSString *key in keyArray) {
            
            id object = homeMembersDict[key] && [(NSArray *)homeMembersDict[key] count] > index ? [homeMembersDict[key][index] mutableCopy] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
            [specificHomeMemberDict setObject:object forKey:key];
            
        }
        
    }
    
    return specificHomeMemberDict;
}

-(NSMutableDictionary *)GenerateDictWithoutEmptyKeys:(NSMutableDictionary *)dictToUse {
    
    NSMutableDictionary *tempDictToUseDict = dictToUse ? [dictToUse mutableCopy] : [NSMutableDictionary dictionary];
    
    
    
    
    for (int i=0 ; i<[[tempDictToUseDict allKeys] count] ; i++) {
        
        id key = [tempDictToUseDict allKeys][i];
        
        BOOL ObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:key classArr:@[[NSString class]]];
        
        BOOL KeyIsNotValid = ObjectIsKindOfClass == YES && ([key length] == 0 || key == nil || key == NULL || [key containsString:@"(null)"]);
        
        if (KeyIsNotValid) {
            
            
            
            
            BOOL OriginalDictContainsKey = [[dictToUse allKeys] containsObject:key];
            
            if (OriginalDictContainsKey) {
                
                [dictToUse removeObjectForKey:key];
                
            }
            
            
            
            
        } else {
            
            BOOL ObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:tempDictToUseDict[key] classArr:@[[NSDictionary class], [NSMutableDictionary class]]];
            
            BOOL InnerDictIsDict = ObjectIsKindOfClass == YES;
            
            if (InnerDictIsDict) {
                
                NSMutableDictionary *tempInnerDict = tempDictToUseDict[key];
                
                for (int j=0 ; j<[[tempInnerDict allKeys] count] ; j++) {
                    
                    NSString *secondKey = [tempInnerDict allKeys][j];
                    
                    BOOL ObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:secondKey classArr:@[[NSString class]]];
                    
                    BOOL SecondKeyIsNotValid = ObjectIsKindOfClass == YES && ([secondKey length] == 0 || secondKey == nil || secondKey == NULL || [secondKey containsString:@"(null)"]);
                    
                    if (SecondKeyIsNotValid) {
                        
                        
                        
                        
                        BOOL OriginalDictContainsKey = [[dictToUse allKeys] containsObject:key];
                        
                        if (OriginalDictContainsKey) {
                            
                            BOOL OriginalInnerDictContainsSecondKey = [[dictToUse[key] allKeys] containsObject:secondKey];
                            
                            if (OriginalInnerDictContainsSecondKey) {
                                
                                NSMutableDictionary *tempDict = [dictToUse mutableCopy];
                                NSMutableDictionary *tempInnerDict = [tempDict[key] mutableCopy];
                                [tempInnerDict removeObjectForKey:secondKey];
                                [tempDict setObject:tempInnerDict forKey:key];
                                dictToUse = [tempDict mutableCopy];
                                
                            }
                            
                        }
                        
                        
                        
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    return dictToUse;
}

-(NSString *)GenerateStringArray:(NSMutableArray *)arrayToUse {
    
    NSString *stringArray = @"";
    
    for (NSString *element in arrayToUse) {
        
        if (stringArray.length == 0) {
            
            stringArray = element;
            
        } else {
            
            stringArray = [NSString stringWithFormat:@"%@*** %@", stringArray, element];
            
        }
        
        
    }
    
    return stringArray;
    
}

-(NSString *)dictionaryToString:(NSDictionary *)dictionary {
    if (!dictionary) {
        return nil;
    }
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if (!jsonData) {
        NSLog(@"Error converting dictionary to string: %@", error.localizedDescription);
        return nil;
    }
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

-(NSString *)arrayToString:(NSArray *)array {
    if (!array) {
        return nil;
    }
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if (!jsonData) {
        NSLog(@"Error converting array to string: %@", error.localizedDescription);
        return nil;
    }
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return jsonString;
}

-(NSDictionary *)stringToDictionary:(NSString *)jsonString {
    if (!jsonString) {
        return @{};
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingMutableContainers
                                                      error:&error];
    
    if (error) {
        NSLog(@"Error converting JSON string to dictionary: %@", error.localizedDescription);
        return @{};
    }
    
    if ([jsonObject isKindOfClass:[NSDictionary class]]) {
        return (NSDictionary *)jsonObject;
    }
    
    return @{};
}

-(NSArray *)stringToArray:(NSString *)jsonString {
    if (!jsonString) {
        return @[];
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingMutableContainers
                                                      error:&error];
    
    if (error) {
        NSLog(@"Error converting JSON string to array: %@", error.localizedDescription);
        return @[];
    }
    
    if ([jsonObject isKindOfClass:[NSArray class]]) {
        return (NSArray *)jsonObject;
    }
    
    return @[];
}


#pragma mark - Key Methods

-(NSArray *)GenerateKeyArray {
    
    NSArray *keyArray = @[];
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"ViewingExpenses"] isEqualToString:@"Yes"]) {
        
        keyArray = [[[GeneralObject alloc] init] GenerateKeyArrayManually:NO Expense:YES List:NO Home:NO];
        
    } else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"ViewingLists"] isEqualToString:@"Yes"]) {
        
        keyArray = [[[GeneralObject alloc] init] GenerateKeyArrayManually:NO Expense:NO List:YES Home:NO];
        
    } else if (
               ([[[NSUserDefaults standardUserDefaults] objectForKey:@"ViewingExpenses"] isEqualToString:@"No"] ||
                ![[NSUserDefaults standardUserDefaults] objectForKey:@"ViewingExpenses"]) &&
               ([[[NSUserDefaults standardUserDefaults] objectForKey:@"ViewingLists"] isEqualToString:@"No"] ||
                ![[NSUserDefaults standardUserDefaults] objectForKey:@"ViewingLists"])
               ) {
                   
                   keyArray = [[[GeneralObject alloc] init] GenerateKeyArrayManually:YES Expense:NO List:NO Home:NO];
                   
               }
    
    return keyArray;
    
}

-(NSArray *)GenerateKeyArrayManually:(BOOL)Chore Expense:(BOOL)Expense List:(BOOL)List Home:(BOOL)Home {
    
    NSArray *keyArray = @[];
    
    if (Chore == YES) {
        
        keyArray = [NSArray arrayWithObjects:
                    
                    @"ItemAddedLocation", @"ItemAdditionalReminders", @"ItemAlternateTurns", @"ItemApprovalNeeded", @"ItemApprovalRequests", @"ItemAssignedTo", @"ItemAssignedToAnybody", @"ItemAssignedToNewHomeMembers",
                    
                    @"ItemCompletedDict", @"ItemCreatedBy", @"ItemColor", @"ItemCompleteAsNeeded",
                    
                    @"ItemDate", @"ItemDateLastAlternatedTurns", @"ItemDateLastReset", @"ItemDatePosted", @"ItemDays", @"ItemDeleted", @"ItemDifficulty", @"ItemDueDate", @"ItemDueDatesSkipped",
                    
                    @"ItemEndDate", @"ItemEndNumberOfTimes", @"ItemEstimatedTime",
                    
                    @"ItemGracePeriod",
                    
                    @"ItemHomeID",
                    
                    @"ItemID", @"ItemImageURL", @"ItemInProgressDict",
                    
                    @"ItemMustComplete",
                    
                    @"ItemName", @"ItemNotes",
                    
                    @"ItemOccurrenceID", @"ItemOccurrencePastDue", @"ItemOccurrenceStatus",
                    
                    @"ItemPastDue", @"ItemPhotoConfirmation", @"ItemPhotoConfirmationDict", @"ItemPinned", @"ItemPriority", @"ItemPrivate",
                    
                    @"ItemRandomizeTurnOrder", @"ItemReminderDict", @"ItemRepeats", @"ItemRepeatIfCompletedEarly", @"ItemReward",
                    
                    @"ItemScheduledStart", @"ItemSelfDestruct", @"ItemSpecificDueDates", @"ItemStartDate", @"ItemStatus", @"ItemSubTasks", @"ItemSuggestedID",
                    
                    @"ItemTags", @"ItemTakeTurns", @"ItemTaskList", @"ItemTime", @"ItemTrash", @"ItemTutorial", @"ItemTurnUserID", @"ItemType",
                    
                    @"ItemWontDo",
                    
                    @"ItemUniqueID",
                    
                    nil];
        
    } else if (Expense == YES) {
        
        keyArray = [NSArray arrayWithObjects:
                    
                    @"ItemAddedLocation", @"ItemAmount", @"ItemAlternateTurns", @"ItemAdditionalReminders", @"ItemApprovalNeeded", @"ItemApprovalRequests", @"ItemAssignedTo", @"ItemAssignedToAnybody", @"ItemAssignedToNewHomeMembers",
                    
                    @"ItemColor", @"ItemCompleteAsNeeded", @"ItemCompletedDict", @"ItemCostPerPerson", @"ItemCreatedBy",
                    
                    @"ItemDate", @"ItemDateLastAlternatedTurns", @"ItemDateLastReset", @"ItemDatePosted", @"ItemDays", @"ItemDeleted", @"ItemDifficulty", @"ItemDueDate", @"ItemDueDatesSkipped",
                    
                    @"ItemEndDate", @"ItemEndNumberOfTimes", @"ItemEstimatedTime",
                    
                    @"ItemGracePeriod",
                    
                    @"ItemHomeID",
                    
                    @"ItemID", @"ItemImageURL", @"ItemInProgressDict", @"ItemItemized", @"ItemItemizedItems",
                    
                    @"ItemName", @"ItemNotes",
                    
                    @"ItemOccurrenceID", @"ItemOccurrencePastDue", @"ItemOccurrenceStatus",
                    
                    @"ItemPastDue", @"ItemPaymentMethod", @"ItemPhotoConfirmation", @"ItemPhotoConfirmationDict", @"ItemPinned", @"ItemPriority", @"ItemPrivate",
                    
                    @"ItemRandomizeTurnOrder", @"ItemReminderDict", @"ItemRepeats", @"ItemRepeatIfCompletedEarly", @"ItemReward",
                    
                    @"ItemScheduledStart", @"ItemSelfDestruct", @"ItemSpecificDueDates", @"ItemStartDate", @"ItemStatus", @"ItemSuggestedID",
                    
                    @"ItemTags", @"ItemTakeTurns", @"ItemTaskList", @"ItemTime", @"ItemTrash", @"ItemTurnUserID", @"ItemType",
                    
                    @"ItemWontDo",
                    
                    @"ItemUniqueID",
                    
                    nil];
        
    } else if (List == YES) {
        
        keyArray = [NSArray arrayWithObjects:
                    
                    @"ItemAddedLocation", @"ItemAdditionalReminders", @"ItemAlternateTurns", @"ItemAssignedTo", @"ItemAssignedToAnybody", @"ItemAssignedToNewHomeMembers",
                    
                    @"ItemColor", @"ItemCompleteAsNeeded", @"ItemCompletedDict", @"ItemCreatedBy",
                    
                    @"ItemDate", @"ItemDateLastAlternatedTurns", @"ItemDateLastReset", @"ItemDatePosted", @"ItemDays", @"ItemDeleted", @"ItemDifficulty", @"ItemDueDate", @"ItemDueDatesSkipped",
                    
                    @"ItemEndDate", @"ItemEndNumberOfTimes", @"ItemEstimatedTime",
                    
                    @"ItemGracePeriod",
                    
                    @"ItemHomeID",
                    
                    @"ItemID", @"ItemImageURL", @"ItemInProgressDict",
                    
                    @"ItemListItems",
                    
                    @"ItemName", @"ItemNotes",
                    
                    @"ItemOccurrenceID", @"ItemOccurrencePastDue", @"ItemOccurrenceStatus",
                    
                    @"ItemPastDue", @"ItemPhotoConfirmation", @"ItemPhotoConfirmationDict", @"ItemPinned", @"ItemPriority", @"ItemPrivate",
                    
                    @"ItemRandomizeTurnOrder", @"ItemReminderDict", @"ItemRepeats", @"ItemRepeatIfCompletedEarly", @"ItemReward",
                    
                    @"ItemScheduledStart", @"ItemSelfDestruct", @"ItemStartDate", @"ItemStatus", @"ItemSuggestedID",
                    
                    @"ItemTags", @"ItemTakeTurns", @"ItemTaskList", @"ItemTime", @"ItemTrash", @"ItemTurnUserID", @"ItemType",
                    
                    @"ItemWontDo",
                    
                    @"ItemUniqueID",
                    
                    nil];
        
    } else if (Home == YES) {
        
        keyArray = [NSArray arrayWithObjects:
                    
                    @"HomeCreationDate",
                    
                    @"HomeFeatures",
                    
                    @"HomeID", @"HomeImageURL",
                    
                    @"HomeKey", @"HomeKeys", @"HomeKeysArray",
                    
                    @"HomeMembers",
                    
                    @"HomeName",
                    
                    @"HomeOwnerUserID",
                    
                    @"HomeMembersUnclaimed",
                    
                    nil];
        
    }
    
    return keyArray;
    
}

-(NSArray *)GenerateUserKeyArray {
    
    NSArray *keyArray = @[@"Email", @"HeardAboutUs", @"Notifications", @"ProfileImageURL", @"ReceiveUpdateEmails", @"UserID", @"Username", @"WeDivvyPremium", @"SubscriptionAdmin"];
    
    return keyArray;
}

-(NSArray *)GenerateActivityKeyArray {
    
    NSArray *keyArray = @[@"ActivityID", @"ActivityUserID", @"ActivityUserIDNo1", @"ActivityHomeID", @"ActivityDatePosted", @"ActivityTitle", @"ActivityDescription", @"ActivityAction", @"ActivityRead", @"ActivityItemType", @"ActivityForHome"];
    
    return keyArray;
}

-(NSArray *)GenerateNotificationsKeyArray {
    
    NSArray *keyArray = @[@"NotificationID", @"NotificationDateCreated", @"NotificationCreatedBy", @"NotificationTitle", @"NotificationBody", @"NotificationRead", @"NotificationHomeID", @"NotificationItemID", @"NotificationItemOccurrenceID", @"NotificationItemCollection"];
    
    return keyArray;
}

-(NSArray *)GenerateFolderKeyArray {
    
    NSArray *keyArray = @[@"FolderID", @"FolderName", @"FolderDateCreated", @"FolderCreatedBy", @"FolderTaskLists"];
    
    return keyArray;
}

-(NSArray *)GenerateTaskListKeyArray {
    
    NSArray *keyArray = @[@"TaskListID", @"TaskListName", @"TaskListDateCreated", @"TaskListCreatedBy", @"TaskListSections", @"TaskListItems"];
    
    return keyArray;
}

-(NSArray *)GenerateSectionKeyArray {
    
    NSArray *keyArray = @[@"SectionID", @"SectionName", @"SectionDateCreated", @"SectionCreatedBy", @"SectionItems"];
    
    return keyArray;
}

-(NSArray *)GenerateTemplateKeyArray {
    
    NSArray *keyArray = @[@"TemplateID", @"TemplateName", @"TemplateDateCreated", @"TemplateCreatedBy", @"TemplateDefault", @"TemplateData"];
    
    return keyArray;
}

-(NSArray *)GenerateDraftKeyArray {
    
    NSArray *keyArray = @[@"DraftID", @"DraftName", @"DraftDateCreated", @"DraftCreatedBy", @"DraftDefault", @"DraftData"];
    
    return keyArray;
}

-(NSArray *)GenerateChatKeyArray {
    
    NSArray *keyArray = @[@"ChatID", @"ChatHomeID", @"ChatName", @"ChatImageURL", @"ChatCreatedBy", @"ChatDateCreated", @"ChatAssignedTo", @"ChatAssignedToNewHomeMembers"];
    
    return keyArray;
}

-(NSArray *)GenerateMessageKeyArray {
    
    NSArray *keyArray = @[@"MessageID", @"MessageEnd", @"MessageText", @"MessageSentBy", @"MessageTimeStamp", @"MessageRead", @"MessageImageURL", @"MessageVideoURL", @"MessageChatID", @"MessageHomeID", @"MessageItemID"];
    
    return keyArray;
}

-(NSArray *)GenerateForumKeyArray {
    
    NSArray *keyArray = @[@"ForumTitle", @"ForumDetails", @"ForumID", @"ForumDatePosted", @"ForumCreatedBy", @"ForumLikes", @"ForumImageURL", @"ForumCompleted"];
    
    return keyArray;
}

-(NSArray *)GeneratePromotionalCodesKeyArray {
    
    NSArray *keyArray = @[@"PromotionalCodeID", @"PromotionalCodeDateUsedByReceiver", @"PromotionalCodeDateSent", @"PromotionalCodeUsedBy", @"PromotionalCodeSentBy", @"PromotionalCode", @"PromotionalCodeDateUsedBySender", @"PromotinoalCodeReceiverName"];
    
    return keyArray;
}

-(NSArray *)GenerateNotificationSettingsKeyArray {
    
    return @[@"UserID", @"AllowNotifications", @"Sound", @"BadgeIcon", @"DaysOfTheWeek", @"Chores", @"Expenses", @"Lists", @"GroupChats", @"HomeMembers_NotificationSettings", @"Forum", @"ScheduledSummary"];
    
}


-(NSArray *)GenerateTopicKeyArray {
    
    return @[@"TopicID", @"TopicCreatedBy", @"TopicSubscribedTo", @"TopicAssignedTo", @"TopicDateCreated", @"TopicDeleted"];
    
}

-(NSSet *)GenerateSubscriptionsKeyArray {
    
    NSSet *productIdentifiers = [NSSet setWithObjects:
                                 @"WeDivvyPremiumIndividualMonthly1", @"WeDivvyPremiumIndividualThreeMonthly1", @"WeDivvyPremiumIndividualYearly1",
                                 @"WeDivvyPremiumHousemateMonthly1", @"WeDivvyPremiumHousemateThreeMonthly1", @"WeDivvyPremiumHousemateYearly1",
                                 @"WeDivvyPremiumFamilyMonthly1", @"WeDivvyPremiumFamilyThreeMonthly1", @"WeDivvyPremiumFamilyYearly1",
                                 
                                 /*@"WeDivvyPremiumIndividualYearlyExpensive1", @"WeDivvyPremiumHousemateYearlyExpensive1", @"WeDivvyPremiumFamilyYearlyExpensive1",*/
                                 
                                 @"WeDivvyPremiumIndividualMonthlyDiscount2", @"WeDivvyPremiumIndividualThreeMonthlyDiscount2", @"WeDivvyPremiumIndividualYearlyDiscount2",
                                 @"WeDivvyPremiumHousemateMonthlyDiscount3", @"WeDivvyPremiumHousemateThreeMonthlyDiscount3", @"WeDivvyPremiumHousemateYearlyDiscount3",
                                 @"WeDivvyPremiumFamilyMonthlyDiscount2", @"WeDivvyPremiumFamilyThreeMonthlyDiscount2", @"WeDivvyPremiumFamilyYearlyDiscount2",
                                 
                                 /*@"WeDivvyPremiumIndividualNoFreeTrialMonthly1", @"WeDivvyPremiumIndividualNoFreeTrialThreeMonthly1", @"WeDivvyPremiumIndividualNoFreeTrialYearly1",
                                 @"WeDivvyPremiumHousemateNoFreeTrialMonthly1", @"WeDivvyPremiumHousemateNoFreeTrialThreeMonthly1", @"WeDivvyPremiumHousemateNoFreeTrialYearly1",
                                 @"WeDivvyPremiumFamilyNoFreeTrialMonthly1", @"WeDivvyPremiumFamilyNoFreeTrialThreeMonthly1", @"WeDivvyPremiumFamilyNoFreeTrialYearly1",*/ nil];
    
    return productIdentifiers;
    
}

-(NSArray *)GenerateSubscriptionsMonthly:(BOOL)Monthly ThreeMonthly:(BOOL)ThreeMonthly Yearly:(BOOL)Yearly {
    
    NSArray *arrayToReturn = @[];
    
    if (Monthly) {
        
        arrayToReturn = @[
            @"WeDivvyPremiumIndividualMonthly1", @"WeDivvyPremiumHousemateMonthly1", @"WeDivvyPremiumFamilyMonthly1",
            @"WeDivvyPremiumIndividualMonthlyDiscount2", @"WeDivvyPremiumHousemateMonthlyDiscount3", @"WeDivvyPremiumFamilyMonthlyDiscount2",
            @"WeDivvyPremiumIndividualNoFreeTrialMonthly1", @"WeDivvyPremiumHousemateNoFreeTrialMonthly1", @"WeDivvyPremiumFamilyNoFreeTrialMonthly1"];
        
    } else if (ThreeMonthly) {
        
        arrayToReturn = @[
            @"WeDivvyPremiumIndividualThreeMonthly1", @"WeDivvyPremiumHousemateThreeMonthly1", @"WeDivvyPremiumFamilyThreeMonthly1",
            @"WeDivvyPremiumIndividualThreeMonthlyDiscount2", @"WeDivvyPremiumHousemateThreeMonthlyDiscount3", @"WeDivvyPremiumFamilyThreeMonthlyDiscount2",
            @"WeDivvyPremiumIndividualNoFreeTrialThreeMonthly1", @"WeDivvyPremiumHousemateNoFreeTrialThreeMonthly1", @"WeDivvyPremiumFamilyNoFreeTrialThreeMonthly1"];
        
    } else if (Yearly) {
        
        arrayToReturn = @[
            @"WeDivvyPremiumIndividualYearly1", @"WeDivvyPremiumHousemateYearly1", @"WeDivvyPremiumFamilyYearly1",
            @"WeDivvyPremiumIndividualYearlyDiscount2", @"WeDivvyPremiumHousemateYearlyDiscount3", @"WeDivvyPremiumFamilyYearlyDiscount2",
            @"WeDivvyPremiumIndividualNoFreeTrialYearly1", @"WeDivvyPremiumHousemateNoFreeTrialYearly1", @"WeDivvyPremiumFamilyNoFreeTrialYearly1",
            
            @"WeDivvyPremiumIndividualYearlyExpensive1", @"WeDivvyPremiumHousemateYearlyExpensive1", @"WeDivvyPremiumFamilyYearlyExpensive1",];
        
    }
    
    return arrayToReturn;
}

-(NSArray *)GenerateDefaultArrayValueForKey:(NSString *)key {
    
    if ([key isEqualToString:@"HomeFeatures"]) {
        return @[@"🧹 Chores", @"💵 Expenses", @"📝 Lists", @"💬 Group Chats"];
    }
    
    return [NSArray array];
    
}

-(NSString *)GenerateDefaultStringValueForKey:(NSString *)key {
    
    NSString *localCurrencyDecimalSeparatorSymbol = [[[GeneralObject alloc] init] GenerateLocalCurrencyDecimalSeparatorSymbol];
    
    if ([key isEqualToString:@"ItemAmount"]) {
        return [NSString stringWithFormat:@"0%@00", localCurrencyDecimalSeparatorSymbol];
    } else if ([key isEqualToString:@"ItemMustComplete"]) {
        return @"Everyone";
    } else if ([key isEqualToString:@"ItemPastDue"]) {
        return @"2 Days";
    } else if ([key isEqualToString:@"ItemGracePeriod"]) {
        return @"None";
    } else if ([key isEqualToString:@"ItemTrash"]) {
        return @"No";
    } else if ([key isEqualToString:@"ItemTaskList"]) {
        return @"No List";
    }
    
    return @"";
}

-(id)GenerateDefaultValueBasedOnKey:(NSString *)key {
    
    NSArray *defaultValueArrayKeys = @[
        //Items
        @"ItemAssignedTo", @"ItemTags", @"ItemSpecificDueDates", @"ItemDueDatesSkipped",
        //Homes
        @"HomeMembers", @"HomeKeysArray", @"HomeFeatures",
        //Activity
        @"ActivityRead",
        //Chats
        @"ChatAssignedTo",
        //Messages
        @"MessageRead",
        //Task Lists
        @"TaskListSections",
        //Topics
        @"TopicSubscribedTo", @"TopicAssignedTo",
        //Forums
        @"ForumLikes",
        //Notifications
        @"NotificationRead",
        //Notification Settings
        @"DaysOfTheWeek"];
    
    NSArray *defaultValueDictionaryKeys = @[
        //Items
        @"ItemCompletedDict", @"ItemInProgressDict", @"ItemWontDo", @"ItemCostPerPerson", @"ItemListItems", @"ItemSubTasks", @"ItemReward", @"ItemPaymentMethod", @"ItemApprovalRequests", @"ItemItemizedItems", @"ItemAdditionalReminders", @"ItemReminderDict", @"ItemOccurrencePastDue", @"ItemPhotoConfirmationDict",
        //Homes
        @"HomeKeys", @"HomeMembersUnclaimed",
        //Folders
        @"FolderTaskLists",
        //Task Lists
        @"TaskListItems",
        //Sections
        @"SectionItems",
        //Templates
        @"TemplateData",
        //Drafts
        @"DraftData",
        //Notification Settings
        @"Chores", @"Expenses", @"Lists", @"GroupChats", @"Forum", @"ScheduledSummary", @"HomeMembers_NotificationSettings",
        //Users
        @"WeDivvyPremium"];
    
    if ([defaultValueArrayKeys containsObject:key]) {
        return [[[GeneralObject alloc] init] GenerateDefaultArrayValueForKey:key];
    } else if ([defaultValueDictionaryKeys containsObject:key]) {
        return [NSMutableDictionary dictionary];
    } else {
        return [[[GeneralObject alloc] init] GenerateDefaultStringValueForKey:key];
    }
    
}

#pragma mark - Filter Methods

-(NSString *)TrimString:(NSString *)string {
    
    NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
    NSString *trimmedEmail = [string stringByTrimmingCharactersInSet:charSet];
    [trimmedEmail stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    return trimmedEmail;
}

-(NSString *)GetTopicFromUserID:(NSString *)userID {
    
    NSString *topic = userID;
    topic = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:topic arrayOfSymbols:@[@"-", @" ", @":"]];
    
    return topic;
    
}

-(NSMutableArray *)RemoveDupliatesFromArray:(NSMutableArray *)array {
    
    NSOrderedSet *orderedSet = [NSOrderedSet orderedSetWithArray:array];
    array = [[orderedSet array] mutableCopy];
    
    return array;
}

-(NSMutableArray *)SortArrayOfDates:(NSMutableArray *)datesArray dateFormatString:(NSString *)dateFormatString {
    
    NSString *stringToReplace = [dateFormatString isEqualToString:@"MMMM dd, yyyy hh:mm:ss a"] == YES ? @"11:59:00 PM" : @"11:59 PM";
    
    NSMutableArray *dueDateArrayToSort = [NSMutableArray array];
    NSMutableArray *indexesOfReplacedDates = [NSMutableArray array];
    
    
    
    
    for (NSString *dueDate in datesArray) {
        
        NSString *tempDueDateStr = [dueDate mutableCopy];
        
        if ([tempDueDateStr containsString:@"Any Time"] && [indexesOfReplacedDates containsObject:dueDate] == NO) {
            [indexesOfReplacedDates addObject:dueDate];
            tempDueDateStr = [[[GeneralObject alloc] init] GenerateStringWithReplacementString:tempDueDateStr stringToReplace:@"Any Time" replacementString:stringToReplace];
        }
        
        [dueDateArrayToSort addObject:tempDueDateStr];
        
    }
    
    
    
    
    NSArray *sortedArray = [dueDateArrayToSort sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        NSDate *d1 = [[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormatString dateToConvert:obj1 returnAs:[NSDate class]];
        NSDate *d2 = [[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormatString dateToConvert:obj2 returnAs:[NSDate class]];
        
        return [d1 compare: d2];
    }];
    
    
    
    
    NSMutableArray *sortedItemsArray = [NSMutableArray array];
    
    for (NSString *dueDate in sortedArray) {
        
        NSString *updatedDueDate = dueDate;
        
        if ([updatedDueDate containsString:stringToReplace]) {
            
            BOOL added = false;
            updatedDueDate = [[[GeneralObject alloc] init] GenerateStringWithReplacementString:updatedDueDate stringToReplace:@"Any Time" replacementString:stringToReplace];
            
            if ([indexesOfReplacedDates containsObject:updatedDueDate] == YES && [sortedItemsArray containsObject:updatedDueDate] == NO) {
                [sortedItemsArray addObject:updatedDueDate];
                added = true;
            }
            
            updatedDueDate = [[[GeneralObject alloc] init] GenerateStringWithReplacementString:updatedDueDate stringToReplace:@"Any Time" replacementString:stringToReplace];
            
            if (added == false && [sortedItemsArray containsObject:updatedDueDate] == NO) {
                [sortedItemsArray addObject:updatedDueDate];
            }
            
        } else {
            
            [sortedItemsArray addObject:updatedDueDate];
            
        }
        
    }
    
    
    
    
    return [sortedItemsArray mutableCopy];
}

-(NSMutableArray *)SortArrayOfDatesNo1:(NSMutableArray *)datesArray dateFormatString:(NSString *)dateFormatString {
    
    NSString *stringToReplace = [dateFormatString isEqualToString:@"MMMM dd, yyyy hh:mm:ss a"] == YES ? @"11:59:00 PM" : @"11:59 PM";
    
    NSMutableArray *dueDateArrayToSort = [NSMutableArray array];
    NSMutableArray *indexesOfReplacedDates = [NSMutableArray array];
    
    
    
    
    for (NSString *dueDate in datesArray) {
        
        NSString *tempDueDateStr = [dueDate mutableCopy];
       
        if ([tempDueDateStr containsString:@"Any Time"]) {
            NSArray *arr = [[dueDate mutableCopy] componentsSeparatedByString:@" "];
            NSString *dueDateWithoutTime = [NSString stringWithFormat:@"%@ %@ %@ %@", arr[0], arr[1], arr[2], arr[3]];
           
            [indexesOfReplacedDates addObject:dueDateWithoutTime];
            tempDueDateStr = [[[GeneralObject alloc] init] GenerateStringWithReplacementString:tempDueDateStr stringToReplace:@"Any Time" replacementString:stringToReplace];
        }
       
        [dueDateArrayToSort addObject:tempDueDateStr];
        
    }
    
    
    
    
    NSMutableArray *sortedArray = [[dueDateArrayToSort sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        NSDate *d1 = [[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormatString dateToConvert:obj1 returnAs:[NSDate class]];
        NSDate *d2 = [[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormatString dateToConvert:obj2 returnAs:[NSDate class]];
        
        return [d1 compare: d2];
    }] mutableCopy];
    
    
   
    
    for (NSString *dueDate in [sortedArray mutableCopy]) {
        
        NSUInteger index = [sortedArray indexOfObject:dueDate];
        NSArray *arr = [[dueDate mutableCopy] componentsSeparatedByString:@" "];
        NSString *dueDateWithoutTime = [NSString stringWithFormat:@"%@ %@ %@ %@", arr[0], arr[1], arr[2], arr[3]];
        
        if ([indexesOfReplacedDates containsObject:dueDateWithoutTime]) {
            [sortedArray replaceObjectAtIndex:index withObject:[NSString stringWithFormat:@"%@ Any Time", dueDateWithoutTime]];
        }
        
    }
    
    
    
    
    return [sortedArray mutableCopy];
}

-(NSString *)RemoveSpecialCharactersFromString:(NSString *)string {
    
    NSArray *charactersAndSymbolsArray = [NSArray arrayWithObjects:
                                          @"@",@"%",@"+",@"\\",@"/",@"'",@"!",@"#",@"$",@"^",@"?",@":",@".",@"(",@")",@"{",@"}",@"[",@"]",@"~",@",",nil];
    
    for (NSString *character in charactersAndSymbolsArray) {
        
        if ([string containsString:character]) {
            
            string = [string stringByReplacingOccurrencesOfString:character withString:@""];
            
        }
        
    }
    
    return string;
    
}

-(NSString *)GenerateStringWithRemovedSymbols:(NSString *)strToAlter arrayOfSymbols:(NSArray *)arrayOfSymbols {
    
    for (NSString *symbol in arrayOfSymbols) {
        
        if ([strToAlter containsString:symbol]) {
            
            strToAlter = [strToAlter stringByReplacingOccurrencesOfString:symbol withString:@""];
            
        }
        
    }
    
    return strToAlter;
}

-(NSString *)FormatAmountTextField:(NSString *)textFieldText replacementString:(NSString *)string {
    
    NSString *localCurrencyDecimalSeparatorSymbol = [[[GeneralObject alloc] init] GenerateLocalCurrencyDecimalSeparatorSymbol];
    
    NSString *cleanCentString = [[textFieldText componentsSeparatedByCharactersInSet: [[NSCharacterSet decimalDigitCharacterSet] invertedSet]] componentsJoinedByString:@""];
    
    NSInteger centValue = [cleanCentString intValue];
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    NSNumber *myNumber = [f numberFromString:cleanCentString];
    NSNumber *result;
    
    if([textFieldText length] < 1000000000000){
        
        if (string.length > 0) {
            
            centValue = centValue * 10 + [string intValue];
            double intermediate = [myNumber doubleValue] * 10 +  [[f numberFromString:string] doubleValue];
            result = [[NSNumber alloc] initWithDouble:intermediate];
            
        } else {
            
            centValue = centValue / 10;
            double intermediate = [myNumber doubleValue]/10;
            result = [[NSNumber alloc] initWithDouble:intermediate];
            
        }
        
        myNumber = result;
        
        NSNumber *formatedValue;
        formatedValue = [[NSNumber alloc] initWithDouble:[myNumber doubleValue]/ 100.0f];
        NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
        currencyFormatter.locale = [NSLocale currentLocale];
        [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        
        NSString *amountTextFieldText = textFieldText;
        amountTextFieldText = [currencyFormatter stringFromNumber:formatedValue];
        
        return amountTextFieldText;
        
        
        
        
    } else {
        
        
        
        
        NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
        [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        
        return [currencyFormatter stringFromNumber:@1];
        
        
        
        
    }
    
    return [NSString stringWithFormat:@"0%@00", localCurrencyDecimalSeparatorSymbol];
}

-(NSString *)GenerateAmountInTextFieldInProperFormat:(NSRange)range replacementString:(NSString *)string {
    
    NSString *localCurrencySymbol = [[[GeneralObject alloc] init] GenerateLocalCurrencySymbol];
    NSString *localCurrencyDecimalSeparatorSymbol = [[[GeneralObject alloc] init] GenerateLocalCurrencyDecimalSeparatorSymbol];
    
    NSString *textField = [NSString stringWithFormat:@"%@0%@00", localCurrencySymbol, localCurrencyDecimalSeparatorSymbol];
    
    NSString *cleanCentString = [[textField componentsSeparatedByCharactersInSet: [[NSCharacterSet decimalDigitCharacterSet] invertedSet]] componentsJoinedByString:@""];
    NSInteger centValue = [cleanCentString intValue];
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    NSNumber *myNumber = [f numberFromString:cleanCentString];
    NSNumber *result;
    
    if([textField length] < 1000000000000){
        
        if (string.length > 0) {
            
            centValue = centValue * 10 + [string intValue];
            double intermediate = [myNumber doubleValue] * 10 +  [[f numberFromString:string] doubleValue];
            result = [[NSNumber alloc] initWithDouble:intermediate];
            
        } else {
            
            centValue = centValue / 10;
            double intermediate = [myNumber doubleValue]/10;
            result = [[NSNumber alloc] initWithDouble:intermediate];
            
        }
        
        myNumber = result;
        
        NSNumber *formatedValue;
        formatedValue = [[NSNumber alloc] initWithDouble:[myNumber doubleValue]/ 100.0f];
        NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
        currencyFormatter.locale = [NSLocale currentLocale];
        [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        
        NSString *str = textField;
        str = [currencyFormatter stringFromNumber:formatedValue];
        
        //        str = [[[GeneralObject alloc] init] GenerateStringWithoutNumericSymbols:str arrayOfSymbols:@[@"$"]];
        
        textField = [NSString stringWithFormat:@"%@", str];
        
        NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
        NSString *trimmedStringItemAmount = [textField stringByTrimmingCharactersInSet:charSet];
        
        return trimmedStringItemAmount;
        
    } else {
        
        NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
        [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        textField = [currencyFormatter stringFromNumber:@1];
        NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
        NSString *trimmedStringItemAmount = [textField stringByTrimmingCharactersInSet:charSet];
        
        return trimmedStringItemAmount;
        
    }
    
}

-(NSString *)GenerateLocalCurrencySymbol {
    
    NSLocale *currentLocale = [NSLocale currentLocale];
    NSString *currencySymbol = [currentLocale objectForKey:NSLocaleCurrencySymbol];
    
    return currencySymbol;
}

-(NSString *)GenerateLocalCurrencyDecimalSeparatorSymbol {
    
    // Get the current locale
    NSLocale *currentLocale = [NSLocale currentLocale];
    
    // Create an NSNumberFormatter for currency formatting using the current locale
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setLocale:currentLocale];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    // Check the decimal separator used in currency
    NSString *decimalSeparator = [numberFormatter decimalSeparator];
    
    return decimalSeparator;
}

-(NSString *)GenerateLocalCurrencyNumberSeparatorSymbol {
    
    NSString *decimalSeparator = [[[GeneralObject alloc] init] GenerateLocalCurrencyDecimalSeparatorSymbol];
    
    if ([decimalSeparator isEqualToString:@","]) {
        return @".";
    } else {
        return @",";
    }
    
}

-(NSString *)GenerateLocalCurrencyStringWithReverseSeparatorsForeign:(NSString *)string {
    
    NSString *decimalSeparator = [[[GeneralObject alloc] init] GenerateLocalCurrencyDecimalSeparatorSymbol];
    
    if ([decimalSeparator isEqualToString:@","]) {
        if ([string containsString:@","]) {
            string = [string stringByReplacingOccurrencesOfString:@"," withString:@"xxx"];
        }
        if ([string containsString:@"."]) {
            string = [string stringByReplacingOccurrencesOfString:@"." withString:@"yyy"];
        }
        if ([string containsString:@"xxx"]) {
            string = [string stringByReplacingOccurrencesOfString:@"xxx" withString:@"."];
        }
        if ([string containsString:@"yyy"]) {
            string = [string stringByReplacingOccurrencesOfString:@"yyy" withString:@","];
        }
    }
    
    return string;
}

-(NSString *)GenerateStringWithReplacementString:(NSString *)string stringToReplace:(NSString *)stringToReplace replacementString:(NSString *)replacementString {
    
    if ([string containsString:stringToReplace]) {
        string = [string stringByReplacingOccurrencesOfString:stringToReplace withString:replacementString];
    }
    
    return string;
}

-(void)CallNSNotificationMethods:(NSString *)action userInfo:(NSDictionary * _Nullable)userInfo locations:(NSArray *)locations {
    
    for (NSString *location in locations) {
        
        NSString *postNotificationName = [NSString stringWithFormat:@"NSNotification_%@_%@", location, action];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:postNotificationName object:nil userInfo:userInfo];
        
    }
    
}

#pragma mark - Generate Options Methods

-(UIColor *)GenerateAppColor:(float)alpha {
    
    NSString *appIcon = @"Default";
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"AppThemeSelected"]) {
        appIcon = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppThemeSelected"];
    }
    
    return [[[[GeneralObject alloc] init] GenerateColorOptionFromColorString:appIcon] colorWithAlphaComponent:alpha];
    
}

-(NSArray *)GenerateColorOptionsArray {
    
    return @[@"None", @"Blue", @"Green", @"Indigo", @"Orange", @"Purple", @"Red", @"Yellow", @"Pink", @"Black Coffee", @"Black Coral", @"Blue Munsell", @"Cambridge Blue", @"Carrot Orange", @"Charcoal", @"Dark Purple", @"Green Sheen", @"Liberty", @"Light Coral", @"Light Salmon", @"Maroon X 11", @"Medium Turquoise", @"Olivine", @"Raisin Black", @"Razzmic Berry", @"Red Salsa", @"Royal Purple", @"Sea Green Crayola", @"Steel Blue", @"Sunglow", @"Umber", @"Yellow Green", @"Yellow Green Crayola"];
    
}

-(NSDictionary *)GenerateAppIconNumberArray {
    
    return @{@"WeDivvyOriginal.png" : @"AppIcon-0", @"WeDivvyBlackCoffee.png" : @"AppIcon-1", @"WeDivvyBlackCoral.png" : @"AppIcon-2", @"WeDivvyBlueMunsell.png" : @"AppIcon-3", @"WeDivvyCambridgeBlue.png" : @"AppIcon-4", @"WeDivvyCarrotOrange.png" : @"AppIcon-5", @"WeDivvyCharcoal.png" : @"AppIcon-6", @"WeDivvyDarkPurple.png" : @"AppIcon-7", @"WeDivvyGreenSheen.png" : @"AppIcon-8", @"WeDivvyLiberty.png" : @"AppIcon-9", @"WeDivvyLightCoral.png" : @"AppIcon-10", @"WeDivvyLightSalmon.png" : @"AppIcon-11", @"WeDivvyMaroonX11.png" : @"AppIcon-12", @"WeDivvyMediumTurquoise.png" : @"AppIcon-13", @"WeDivvyOlivine.png" : @"AppIcon-14", @"WeDivvyRaisinBlack.png" : @"AppIcon-15", @"WeDivvyRazzmicBerry.png" : @"AppIcon-16", @"WeDivvyRedSalsa.png" : @"AppIcon-17", @"WeDivvyRoyalPurple.png" : @"AppIcon-18", @"WeDivvySeaGreenCrayola.png" : @"AppIcon-19", @"WeDivvySteelBlue.png" : @"AppIcon-20", @"WeDivvySunglow.png" : @"AppIcon-21", @"WeDivvyUmber.png" : @"AppIcon-22", @"WeDivvyYellowGreen.png" : @"AppIcon-23", @"WeDivvyYellowGreenCrayola.png" : @"AppIcon-24"};
    
}

-(NSArray *)GenerateLaunchPageOptionsArray {
    
    return @[@"🧹 Chores", @"💵 Expenses", @"📝 Lists", @"💬 Group Chats"];
    
}

-(NSArray *)GenerateAppIconColorNameOptionsArray {
    
    return @[@"Default", @"Black Coffee", @"Black Coral", @"Blue Munsell", @"Cambridge Blue", @"Carrot Orange", @"Charcoal", @"Dark Purple", @"Green Sheen", @"Liberty", @"Light Coral", @"Light Salmon", @"Maroon X 11", @"Medium Turquoise", @"Olivine", @"Raisin Black", @"Razzmic Berry", @"Red Salsa", @"Royal Purple", @"Sea Green Crayola", @"Steel Blue", @"Sunglow", @"Umber", @"Yellow Green", @"Yellow Green Crayola"];
    
}

-(NSArray *)GenerateAppIconImageNameOptionsArray {
    
    return @[@"WeDivvyOriginal.png", @"WeDivvyBlackCoffee.png", @"WeDivvyBlackCoral.png", @"WeDivvyBlueMunsell.png", @"WeDivvyCambridgeBlue.png", @"WeDivvyCarrotOrange.png", @"WeDivvyCharcoal.png", @"WeDivvyDarkPurple.png", @"WeDivvyGreenSheen.png", @"WeDivvyLiberty.png", @"WeDivvyLightCoral.png", @"WeDivvyLightSalmon.png", @"WeDivvyMaroonX11.png", @"WeDivvyMediumTurquoise.png", @"WeDivvyOlivine.png", @"WeDivvyRaisinBlack.png", @"WeDivvyRazzmicBerry.png", @"WeDivvyRedSalsa.png", @"WeDivvyRoyalPurple.png", @"WeDivvySeaGreenCrayola.png", @"WeDivvySteelBlue.png", @"WeDivvySunglow.png", @"WeDivvyUmber.png", @"WeDivvyYellowGreen.png", @"WeDivvyYellowGreenCrayola.png"];
    
}

-(UIColor *)GenerateColor:(float)red green:(float)green blue:(float)blue {
    
    return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1.0f];
    
}

-(UIColor *)GenerateColorOptionFromColorString:(NSString *)colorStr {
    
    UIColor *color = [UIColor clearColor];
    
    if ([colorStr isEqualToString:@"Default"]) {
        
        color = [[[GeneralObject alloc] init] GenerateColor:16 green:156 blue:220];
        
    } else if ([colorStr isEqualToString:@"Red"]) {
        
        color = [UIColor colorWithRed:238.0f/255.0f green:56.0f/255.0f blue:97.0f/255.0f alpha:1.0f];
        
    } else if ([colorStr isEqualToString:@"Green"]) {
        
        color = [UIColor colorWithRed:20.0f/255.0f green:214.0f/255.0f blue:159.0f/255.0f alpha:1.0f];
        
    } else if ([colorStr isEqualToString:@"Blue"]) {
        
        color = [UIColor colorWithRed:57.0f/255.0f green:202.0f/255.0f blue:249.0f/255.0f alpha:1.0f];
        
    } else if ([colorStr isEqualToString:@"Yellow"]) {
        
        color = [UIColor colorWithRed:246.0f/255.0f green:223.0f/255.0f blue:94.0f/255.0f alpha:1.0f];
        
    } else if ([colorStr isEqualToString:@"Pink"]) {
        
        color = [UIColor colorWithRed:225.0f/255.0f green:113.0f/255.0f blue:150.0f/255.0f alpha:1.0f];
        
    } else if ([colorStr isEqualToString:@"Orange"]) {
        
        color = [UIColor colorWithRed:246.0f/255.0f green:126.0f/255.0f blue:82.0f/255.0f alpha:1.0f];
        
    } else if ([colorStr isEqualToString:@"Purple"]) {
        
        color = [UIColor colorWithRed:121.0f/255.0f green:84.0f/255.0f blue:245.0f/255.0f alpha:1.0f];
        
    } else if ([colorStr isEqualToString:@"Indigo"]) {
        
        color = [UIColor colorWithRed:102.0f/255.0f green:63.0f/255.0f blue:112.0f/255.0f alpha:1.0f];
        
    } else if ([colorStr isEqualToString:@"Black Coffee"]) {
        
        color = [[[GeneralObject alloc] init] GenerateColor:53 green:45 blue:56];
        
    } else if ([colorStr isEqualToString:@"Black Coral"]) {
        
        color = [[[GeneralObject alloc] init] GenerateColor:105 green:109 blue:126];
        
    } else if ([colorStr isEqualToString:@"Blue Munsell"]) {
        
        color = [[[GeneralObject alloc] init] GenerateColor:10 green:138 blue:168];
        
    } else if ([colorStr isEqualToString:@"Cambridge Blue"]) {
        
        color = [[[GeneralObject alloc] init] GenerateColor:143 green:192 blue:169];
        
    } else if ([colorStr isEqualToString:@"Carrot Orange"]) {
        
        color = [[[GeneralObject alloc] init] GenerateColor:241 green:143 blue:1];
        
    } else if ([colorStr isEqualToString:@"Charcoal"]) {
        
        color = [[[GeneralObject alloc] init] GenerateColor:46 green:64 blue:87];
        
    } else if ([colorStr isEqualToString:@"Dark Purple"]) {
        
        color = [[[GeneralObject alloc] init] GenerateColor:53 green:30 blue:41];
        
    } else if ([colorStr isEqualToString:@"Green Sheen"]) {
        
        color = [[[GeneralObject alloc] init] GenerateColor:103 green:175 blue:170];
        
    } else if ([colorStr isEqualToString:@"Liberty"]) {
        
        color = [[[GeneralObject alloc] init] GenerateColor:74 green:89 blue:152];
        
    } else if ([colorStr isEqualToString:@"Light Coral"]) {
        
        color = [[[GeneralObject alloc] init] GenerateColor:236 green:147 blue:144];
        
    } else if ([colorStr isEqualToString:@"Light Salmon"]) {
        
        color = [[[GeneralObject alloc] init] GenerateColor:247 green:162 blue:120];
        
    } else if ([colorStr isEqualToString:@"Maroon X 11"]) {
        
        color = [[[GeneralObject alloc] init] GenerateColor:160 green:60 blue:98];
        
    } else if ([colorStr isEqualToString:@"Medium Turquoise"]) {
        
        color = [[[GeneralObject alloc] init] GenerateColor:109 green:211 blue:206];
        
    } else if ([colorStr isEqualToString:@"Olivine"]) {
        
        color = [[[GeneralObject alloc] init] GenerateColor:163 green:174 blue:105];
        
    } else if ([colorStr isEqualToString:@"Raisin Black"]) {
        
        color = [[[GeneralObject alloc] init] GenerateColor:38 green:41 blue:49];
        
    } else if ([colorStr isEqualToString:@"Razzmic Berry"]) {
        
        color = [[[GeneralObject alloc] init] GenerateColor:140 green:83 blue:131];
        
    } else if ([colorStr isEqualToString:@"Red Salsa"]) {
        
        color = [[[GeneralObject alloc] init] GenerateColor:254 green:89 blue:94];
        
    } else if ([colorStr isEqualToString:@"Royal Purple"]) {
        
        color = [[[GeneralObject alloc] init] GenerateColor:106 green:76 blue:147];
        
    } else if ([colorStr isEqualToString:@"Sea Green Crayola"]) {
        
        color = [[[GeneralObject alloc] init] GenerateColor:26 green:255 blue:196];
        
    } else if ([colorStr isEqualToString:@"Steel Blue"]) {
        
        color = [[[GeneralObject alloc] init] GenerateColor:77 green:126 blue:168];
        
    } else if ([colorStr isEqualToString:@"Sunglow"]) {
        
        color = [[[GeneralObject alloc] init] GenerateColor:254 green:202 blue:57];
        
    } else if ([colorStr isEqualToString:@"Umber"]) {
        
        color = [[[GeneralObject alloc] init] GenerateColor:94 green:80 blue:63];
        
    } else if ([colorStr isEqualToString:@"Yellow Green"]) {
        
        color = [[[GeneralObject alloc] init] GenerateColor:139 green:200 blue:40];
        
    } else if ([colorStr isEqualToString:@"Yellow Green Crayola"]) {
        
        color = [[[GeneralObject alloc] init] GenerateColor:199 green:233 blue:159];
        
    }
    
    return color;
}

#pragma mark - Date Methods

-(NSString *)GenerateCurrentDateString {
    
    if (@available(iOS 11.0, *)) {
        
        [NSTimeZone setDefaultTimeZone:[NSTimeZone localTimeZone]];
        
    } else {
        
        [NSTimeZone setDefaultTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"EST"]];
        
    }
    NSDateFormatter *dateFormat = [[[GeneralObject alloc] init] GenerateDateFormatWithString:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *today = [NSDate date];
    NSString *dateString = [dateFormat stringFromDate:today];
    
    return dateString;
    
}

-(NSString *)GenerateReadableCurrentESTDate {
    
    NSString *currentDateString = [[[GeneralObject alloc] init] GenerateESTCurrentDateWithFormat:@"MMMM dd, yyyy hh:mm:ss a" returnAs:[NSString class]];
    NSDate *currentDate = [[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:@"MMMM dd, yyyy hh:mm:ss a" dateToConvert:currentDateString returnAs:[NSDate class]];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:currentDate];
    NSInteger hour = [components hour];
    
    NSDictionary *monthDict = @{@"1" : @"January",
                                @"2" : @"February",
                                @"3" : @"March",
                                @"4" : @"April",
                                @"5" : @"May",
                                @"6" : @"June",
                                @"7" : @"July",
                                @"8" : @"August",
                                @"9" : @"September",
                                @"10" : @"October",
                                @"11" : @"November",
                                @"12" : @"December"};
    
    if ([[[BoolDataObject alloc] init] DateHasAMPM:currentDateString] == NO) {
        
        long trueHour = 0;
        NSString *AMorPM = @"";
        
        if (hour > 12) {
            trueHour = hour - 12;
            AMorPM = @"PM";
        } else if (hour == 12) {
            trueHour = 12;
            AMorPM = @"PM";
        } else if (hour < 12 && hour > 0) {
            trueHour = hour;
            AMorPM = @"AM";
        } else if (hour == 0) {
            trueHour = 12;
            AMorPM = @"AM";
        }
        
        currentDateString = [NSString stringWithFormat:@"%@ %ld, %ld %ld:%02ld:%02ld %@", monthDict[[NSString stringWithFormat:@"%ld", components.month]], (long)components.day, (long)components.year, trueHour, (long)components.minute, (long)components.second, AMorPM];
        
    }
    
    return currentDateString;
}

-(NSDateFormatter *)GenerateDateFormatWithString:(NSString *)dateFormatString {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormatter setCalendar:[NSCalendar currentCalendar]];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setDateFormat:dateFormatString];
    
    return dateFormatter;
    
}

-(NSDateFormatter *)GenerateESTDateFormatWithString:(NSString *)dateFormatString {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"EST"]];
    [dateFormatter setCalendar:[NSCalendar currentCalendar]];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setDateFormat:dateFormatString];

    return dateFormatter;
    
}

-(id)GenerateCurrentDateWithFormat:(NSString *)dateFormat returnAs:(Class)returnAs {
    
    NSDateFormatter *dateFormatter = [[[GeneralObject alloc] init] GenerateDateFormatWithString:dateFormat];
    
    NSDate *currentDate = [NSDate date];
    NSString *dateStringCurrent = [dateFormatter stringFromDate:currentDate];
        
    if (dateStringCurrent == nil || dateStringCurrent == NULL || dateStringCurrent.length == 0) {
        dateStringCurrent = @"";
    }
    
    if (returnAs == [NSDate class]) {
        
        NSDate *dateStringCurrentDate = [[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:dateStringCurrent returnAs:[NSDate class]];
        
        return dateStringCurrentDate;
    }
 
    return dateStringCurrent;
}

-(id)GenerateESTCurrentDateWithFormat:(NSString *)dateFormat returnAs:(Class)returnAs {
    
    NSDateFormatter *dateFormatter = [[[GeneralObject alloc] init] GenerateESTDateFormatWithString:dateFormat];
    
    NSDate *currentDate = [NSDate date];
    NSString *dateStringCurrent = [dateFormatter stringFromDate:currentDate];
    
    if (dateStringCurrent == nil || dateStringCurrent == NULL || dateStringCurrent.length == 0) {
        dateStringCurrent = @"";
    }
    
    if (returnAs == [NSDate class]) {
        
        NSDate *dateStringCurrentDate = [[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:dateStringCurrent returnAs:[NSDate class]];
        
        return dateStringCurrentDate;
    }
    
    return dateStringCurrent;
    
}

-(id)GenerateDateWithAddedTimeWithFormat:(NSString *)dateFormat dateToAddTimeTo:(id)dateToAddTimeTo timeToAdd:(int)timeToAdd returnAs:(Class)returnAs {
 
    NSDate *dateStringWithAddedTime = nil;
    
    BOOL ObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:dateToAddTimeTo classArr:@[[NSString class]]];
    
    if (ObjectIsKindOfClass) {
        
        NSDate *date = [[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:dateToAddTimeTo returnAs:[NSDate class]];
        dateStringWithAddedTime = [date dateByAddingTimeInterval:timeToAdd];

    } else {
        
        dateStringWithAddedTime = [dateToAddTimeTo dateByAddingTimeInterval:timeToAdd];
        
    }
    
    if (returnAs == [NSString class]) {
        NSString *dateStringWithAddedTimeStringVersion = [[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:dateStringWithAddedTime returnAs:[NSString class]];
        return dateStringWithAddedTimeStringVersion;
    }
    
    return dateStringWithAddedTime;
}

-(id)GenerateDateWithConvertedClassWithFormat:(NSString *)dateFormat dateToConvert:(id)dateToConvert returnAs:(Class)returnAs {
    
    NSDateFormatter *dateFormatter = [[[GeneralObject alloc] init] GenerateDateFormatWithString:dateFormat];
    //EXC_BAD_ACCESS
    if (returnAs == [NSString class] && [dateToConvert isKindOfClass:[NSDate class]]) {
        NSString *dateToReturn = [dateFormatter stringFromDate:dateToConvert];
        return dateToReturn;
    }
    else if (returnAs == [NSDate class] && [dateToConvert isKindOfClass:[NSString class]]) {
        NSDate *dateToReturn = [dateFormatter dateFromString:dateToConvert];
        return dateToReturn;
    }
    //
    return nil; // Return nil for unsupported conversions or invalid inputs
}

-(id)GenerateDateWithConvertedFormatWithFormat:(NSString *)dateFormat dateToConvert:(id)dateToConvert newFormat:(NSString *)newFormat returnAs:(Class)returnAs {
  
    //Date In Old Format
    NSDateFormatter *dateFormatterWithOriginialFormat = [[[GeneralObject alloc] init] GenerateDateFormatWithString:dateFormat];
    
    NSDate *dateToConvertInNSDateClassInOriginalFormat =
    [dateToConvert isKindOfClass:[NSDate class]] ?
    dateToConvert : [dateFormatterWithOriginialFormat dateFromString:dateToConvert];

    
    //Date In New Format
    NSDateFormatter *dateFormatterWithNewFormat = [[[GeneralObject alloc] init] GenerateDateFormatWithString:newFormat];
   
    NSString *dateToConvertInNSStringClassInNewFormat = [dateFormatterWithNewFormat stringFromDate:dateToConvertInNSDateClassInOriginalFormat];
    NSDate *dateToConvertInNSDateClassInNewFormat = [dateFormatterWithNewFormat dateFromString:dateToConvertInNSStringClassInNewFormat];
   
    return [returnAs isKindOfClass:[NSDate class]] ?
    dateToConvertInNSDateClassInNewFormat : dateToConvertInNSStringClassInNewFormat;
}

#pragma mark - Time Methods

-(NSDictionary *)GenerateItemTime12HourDict:(NSString *)itemTime {
    
    if ([itemTime isEqualToString:@"Any Time"]) {
        itemTime = @"11:59 PM";
    }
    
    NSArray *minuteHourAMPMArray = [itemTime componentsSeparatedByString:@":"];
    
    NSString *minuteAMPM = [minuteHourAMPMArray count] > 1 ? minuteHourAMPMArray[1] : @"";
    
    NSArray *minuteAMPMArray = [minuteAMPM componentsSeparatedByString:@" "];
    
    NSString *hour = [minuteHourAMPMArray count] > 0 ? minuteHourAMPMArray[0] : @"11";
    NSString *minute = [minuteAMPMArray count] > 0 ? minuteAMPMArray[0] : @"59";
    NSString *AMPM = [minuteAMPMArray count] > 1 ? minuteAMPMArray[1] : @"PM";
    
    NSMutableDictionary *dateDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:hour, @"Hour", minute, @"Minute", AMPM, @"AMPM", nil];
    
    return dateDict;
}

-(NSDictionary *)GenerateItemTime24HourDict:(NSString *)itemTime {
    
    if ([itemTime isEqualToString:@"Any Time"]) {
        itemTime = @"11:59 PM";
    }
    
    NSArray *minuteHourArray = [itemTime componentsSeparatedByString:@":"];
    
    NSString *hour = [minuteHourArray count] > 0 ? minuteHourArray[0] : @"11";
    NSArray *minute = [minuteHourArray count] > 1 ? minuteHourArray[1] : @"59";
    
    NSMutableDictionary *dateDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:hour, @"Hour", minute, @"Minute", nil];
    
    return dateDict;
}

-(NSDictionary *)GenerateConvert12HourTo24HourDict:(NSString *)itemTime {
    
    if ([itemTime isEqualToString:@"Any Time"]) {
        itemTime = @"11:59 PM";
    }
    
    NSArray *splitHourMinuteAMPM = [itemTime componentsSeparatedByString:@" "];
    NSArray *splitHourMinute = [splitHourMinuteAMPM count] > 0 ? [splitHourMinuteAMPM[0] componentsSeparatedByString:@":"] : @[@"59", @"PM"];
    
    int hour = [splitHourMinute count] > 0 ? [splitHourMinute[0] intValue] : 11;
    NSString *minute = [splitHourMinute count] > 1 ? splitHourMinute[1] : @"59";
    NSString *AMPM = [splitHourMinuteAMPM count] > 1 ? splitHourMinuteAMPM[1] : @"PM";
    
    if (hour == 12 && [AMPM isEqualToString:@"AM"]) {
        
        hour = 0;
        
    } else if ((hour >= 1 && hour < 12) && ([AMPM isEqualToString:@"PM"])) {
        
        hour += 12;
        
    }
    
    NSString *hourString = [NSString stringWithFormat:@"%d", hour];
    
    NSMutableDictionary *dateDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:hourString, @"Hour", minute, @"Minute", nil];
    
    return dateDict;
}

-(NSDictionary *)GenerateConvert24HourTo12HourDict:(NSString *)itemTime {
    
    if ([itemTime isEqualToString:@"Any Time"]) {
        itemTime = @"11:59 PM";
    }
    
    NSArray *splitHourMinute = [itemTime componentsSeparatedByString:@":"];
    
    int hour = [splitHourMinute count] > 0 ? [splitHourMinute[0] intValue] : 11;
    NSString *hourString;
    NSString *minute = [splitHourMinute count] > 1 ? splitHourMinute[1] : @"59";
    NSString *AMPM;
    
    if (hour == 0) {
        
        hourString = @"12";
        AMPM = @"AM";
        
    } else if (hour == 12) {
        
        hourString = @"12";
        AMPM = @"PM";
        
    } else if (hour > 12) {
        
        hourString = [NSString stringWithFormat:@"%d", hour - 12];
        AMPM = @"PM";
        
    } else if (hour < 12) {
        
        hourString = [NSString stringWithFormat:@"%d", hour];
        AMPM = @"AM";
        
    }
    
    NSMutableDictionary *dateDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:hourString, @"Hour", minute, @"Minute", AMPM, @"AMPM", nil];
    
    return dateDict;
}

-(NSTimeInterval)GenerateTimeIntervalBetweenTwoDates:(NSString *)dateString1 dateString2:(NSString *)dateString2 dateFormat:(NSString *)dateFormat {
    
    NSDate *date1 = [[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:dateString1 returnAs:[NSDate class]];
    NSDate *date2 = [[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:dateString2 returnAs:[NSDate class]];
    
    NSTimeInterval timeInterval = [date2 timeIntervalSinceDate:date1];
    
    return timeInterval;
    
}

-(int)GenerateNumberOfUnitsStringToSeconds:(NSString *)numberOfUnits {
    
    int interval = 1;
    
    NSArray *numberOfUnitsComponentsArray = [numberOfUnits containsString:@" "] ? [numberOfUnits componentsSeparatedByString:@" "] : @[];
    NSString *numberOfUnitsAmount = [numberOfUnitsComponentsArray count] > 0 ? numberOfUnitsComponentsArray[0] : @"0";
    
    if ([numberOfUnits containsString:@"Minute"]) {
        
        interval = [numberOfUnitsAmount intValue] * 60;
        
    } else if ([numberOfUnits containsString:@"Hour"]) {
        
        interval = [numberOfUnitsAmount intValue] * 3600;
        
    } else if ([numberOfUnits containsString:@"Day"]) {
        
        interval = [numberOfUnitsAmount intValue] * 86400;
        
    } else if ([numberOfUnits containsString:@"Week"]) {
        
        interval = [numberOfUnitsAmount intValue] * 604800;
        
    } else if ([numberOfUnits containsString:@"Month"]) {
        
        interval = 2419200;
        
    } else if ([numberOfUnits containsString:@"Year"]) {
        
        interval = 31536000;
        
    }
    
    if (interval < 1) {
        interval = 1;
    }
    
    return interval;
}

#pragma mark - Generate Date Methods

-(NSString *)GetMonthNumberInYear:(NSString *)monthString {
    
    if ([monthString isEqualToString:@"January"]) {
        
        return @"01";
        
    } else if ([monthString isEqualToString:@"February"]) {
        
        return @"02";
        
    } else if ([monthString isEqualToString:@"March"]) {
        
        return @"03";
        
    } else if ([monthString isEqualToString:@"April"]) {
        
        return @"04";
        
    } else if ([monthString isEqualToString:@"May"]) {
        
        return @"05";
        
    } else if ([monthString isEqualToString:@"June"]) {
        
        return @"06";
        
    } else if ([monthString isEqualToString:@"July"]) {
        
        return @"07";
        
    } else if ([monthString isEqualToString:@"August"]) {
        
        return @"08";
        
    } else if ([monthString isEqualToString:@"September"]) {
        
        return @"09";
        
    } else if ([monthString isEqualToString:@"October"]) {
        
        return @"10";
        
    } else if ([monthString isEqualToString:@"November"]) {
        
        return @"11";
        
    } else if ([monthString isEqualToString:@"December"]) {
        
        return @"12";
        
    }
    
    return @"00";
}

-(NSString *)GetDisplayTimeSinceDate:(NSString *)dateString shortStyle:(BOOL)shortStyle reallyShortStyle:(BOOL)reallyShortStyle {
    
    if (dateString.length == 0 || [dateString isEqualToString:@"No Due Date"]) {
        return @"";
    }
    
    dateString = [[[GeneralObject alloc] init] GenerateStringWithReplacementString:dateString stringToReplace:@"Any Time" replacementString:@"11:59 PM"];
 
    NSString *dateFormat = @"MMMM dd, yyyy hh:mm a";
    
    if ([[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:dateString returnAs:[NSDate class]] == nil) {
        dateFormat = @"yyyy-MM-dd HH:mm:ss";
    }

    NSString *currentDateString = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:dateFormat returnAs:[NSString class]];
    
    NSTimeInterval secondsBetween = [[[GeneralObject alloc] init] GenerateTimeIntervalBetweenTwoDates:dateString dateString2:currentDateString dateFormat:dateFormat];
    
    NSString *sStr = @"s";
    
    int secs = secondsBetween;
    
    if (secs < 60) {
        if (shortStyle) {
            return @"< min ago";
        } else if (reallyShortStyle) {
            return @"< 1m";
        }
        return @"a few seconds ago";
    }
    if (secs < 3600) {
        if ((secs)/60 == 1) {
            sStr = @"";
        }
        if (shortStyle) {
            return [NSString stringWithFormat:@"%dm ago", (secs)/60];
        } else if (reallyShortStyle) {
            return [NSString stringWithFormat:@"%dm", (secs)/60];
        }
        return [NSString stringWithFormat:@"%d min ago", (secs)/60];
    }
    if (secs < 86400) {
        if ((secs)/3600 == 1) {
            sStr = @"";
        }
        if (shortStyle) {
            return [NSString stringWithFormat:@"%dhr%@ ago", (secs)/3600, sStr];
        } else if (reallyShortStyle) {
            return [NSString stringWithFormat:@"%dh", (secs)/3600];
        }
        return [NSString stringWithFormat:@"%d hour%@ ago", (secs)/3600, sStr];
    }
    if (secs < 2592000) {
        if ((secs)/86400 == 1) {
            sStr = @"";
        }
        if (shortStyle) {
            return [NSString stringWithFormat:@"%dd ago", (secs)/86400];
        } else if (reallyShortStyle) {
            return [NSString stringWithFormat:@"%dd", (secs)/86400];
        }
        return [NSString stringWithFormat:@"%d day%@ ago", (secs)/(86400), sStr];
    }
    if (secs < 31536000) {
        if ((secs)/2592000 == 1) {
            sStr = @"";
        }
        if (shortStyle) {
            return [NSString stringWithFormat:@"%dmo ago", (secs)/2592000];
        } else if (reallyShortStyle) {
            return [NSString stringWithFormat:@"%dmo", (secs)/2592000];
        }
        return [NSString stringWithFormat:@"%d month%@ ago", (secs)/2592000, sStr];
    }
    
    if ((secs)/31536000 == 1) {
        sStr = @"";
    }
    if (shortStyle) {
        return [NSString stringWithFormat:@"%dyr%@ ago", (secs)/31536000, sStr];
    } else if (reallyShortStyle) {
        return [NSString stringWithFormat:@"%dy", (secs)/31536000];
    }
    return [NSString stringWithFormat:@"%d year%@ ago", (secs)/31536000, sStr];
    
}

-(NSString *)GetDisplayTimeRemainingUntilDateStartingFromCurrentDate:(NSString *)dateString shortStyle:(BOOL)shortStyle reallyShortStyle:(BOOL)reallyShortStyle {
    
    if (dateString.length == 0 || [dateString isEqualToString:@"No Due Date"]) {
        return @"";
    }
    
    dateString = [[[GeneralObject alloc] init] GenerateStringWithReplacementString:dateString stringToReplace:@"Any Time" replacementString:@"11:59 PM"];
   
    NSString *dateFormat = @"MMMM dd, yyyy hh:mm a";
    
    if ([[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:@"MMMM dd, yyyy hh:mm a" dateToConvert:dateString returnAs:[NSDate class]] == nil) {
        dateFormat = @"yyyy-MM-dd HH:mm:ss";
    }
    
    NSString *currentDateString = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:dateFormat returnAs:[NSString class]];
   
    NSTimeInterval secondsBetween = [[[GeneralObject alloc] init] GenerateTimeIntervalBetweenTwoDates:currentDateString dateString2:dateString dateFormat:dateFormat];
   
    int secs = secondsBetween;
   
    return [[[GeneralObject alloc] init] GenerateDisplayTimeFromSeconds:secs shortStyle:shortStyle reallyShortStyle:reallyShortStyle];
}

-(NSString *)GetDisplayTimeUntilDateStartingFromCustomStartDate:(NSString *)dateString dateToStartFrom:(NSString *)dateToStartFrom shortStyle:(BOOL)shortStyle reallyShortStyle:(BOOL)reallyShortStyle {
    
    if (dateString.length == 0 || [dateString isEqualToString:@"No Due Date"]) {
        return @"";
    }
    
    dateString = [[[GeneralObject alloc] init] GenerateStringWithReplacementString:dateString stringToReplace:@"Any Time" replacementString:@"11:59 PM"];
  
    NSString *dateFormat = @"MMMM dd, yyyy hh:mm a";
    
    if ([[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:dateString returnAs:[NSDate class]] == nil) {
        dateFormat = @"MMMM dd, yyyy HH:mm";
    }
    
    NSString *dateStringCurrent = dateToStartFrom;
    
    NSTimeInterval secondsBetween = [[[GeneralObject alloc] init] GenerateTimeIntervalBetweenTwoDates:dateStringCurrent dateString2:dateString dateFormat:dateFormat];
    
    int secs = isnan(secondsBetween) == NO ? secondsBetween : 0;
    
    return [[[GeneralObject alloc] init] GenerateDisplayTimeFromSeconds:secs shortStyle:shortStyle reallyShortStyle:reallyShortStyle];
}

-(NSString *)GenerateDisplayTimeUntilDisplayTimeStartingFromCustomStartDate:(NSString *)displayTime itemDueDate:(NSString *)itemDueDate shortStyle:(BOOL)shortStyle reallyShortStyle:(BOOL)reallyShortStyle {

    if (displayTime.length == 0 || [displayTime isEqualToString:@"None"]) {
        return @"";
    }
    
    NSString *dateFormat = @"MMMM dd, yyyy HH:mm";
   
    if ([[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:itemDueDate returnAs:[NSDate class]] == nil) {
        dateFormat = @"MMMM dd, yyyy hh:mm a";
    }
    
    if ([[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:itemDueDate returnAs:[NSDate class]] == nil) {
        dateFormat = @"yyyy-MM-dd HH:mm:ss";
    }
   
    NSString *currentDateString = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:dateFormat returnAs:[NSString class]];
   
    NSTimeInterval secondsPassedSinceItemDueDate = [[[GeneralObject alloc] init] GenerateTimeIntervalBetweenTwoDates:itemDueDate dateString2:currentDateString dateFormat:dateFormat];
   
    int secs = [[[GeneralObject alloc] init] GenerateSecondsFromDisplayTime:displayTime] - secondsPassedSinceItemDueDate;
   
    return [[[GeneralObject alloc] init] GenerateDisplayTimeFromSeconds:secs shortStyle:shortStyle reallyShortStyle:reallyShortStyle];
}

-(int)GenerateSecondsFromDisplayTime:(NSString *)itemGracePeriod {
    
    int secondsThatNeedToPass = 0;
    
    if ([itemGracePeriod isEqualToString:@"None"] == NO && [itemGracePeriod isEqualToString:@"Never"] == NO && [itemGracePeriod isEqualToString:@"Until Completed"] == NO && itemGracePeriod.length != 0 && itemGracePeriod != NULL) {
        
        NSArray *itemGracePeriodArray = [itemGracePeriod containsString:@" "] ? [itemGracePeriod componentsSeparatedByString:@" "] : @[];
        NSString *gracePeriodAmount = [itemGracePeriodArray count] > 0 ? itemGracePeriodArray[0] : @"";
        NSString *gracePeriodInterval = [itemGracePeriodArray count] > 1 ? itemGracePeriodArray[1] : @"";
        
        int multiple = 0;
        
        if ([gracePeriodInterval containsString:@"Minute"]) {
            
            multiple = 60;
            
        } else if ([gracePeriodInterval containsString:@"Hour"]) {
            
            multiple = 3600;
            
        } else if ([gracePeriodInterval containsString:@"Day"]) {
            
            multiple = 86400;
            
        } else if ([gracePeriodInterval containsString:@"Week"]) {
            
            multiple = 604800;
            
        } else if ([gracePeriodInterval containsString:@"Month"]) {
            
            multiple = 2419200;
            
        } else if ([gracePeriodInterval containsString:@"Year"]) {
            
            multiple = 31536000;
            
        }
        
        secondsThatNeedToPass = [gracePeriodAmount intValue] * multiple;
        
    }
    
    return secondsThatNeedToPass;
    
}

-(BOOL)AddToObjectArrAndCheckIfQueryHasEnded:(NSMutableArray *)queryArray objectArr:(NSMutableArray *)objectArr {
    
    [objectArr addObject:@""];
    
    if ([objectArr count] == queryArray.count) {
        
        return YES;
        
    }
    
    return NO;
}

#pragma mark - UI Methods

-(void)SelectCursorPosition:(UITextView *)textView pos:(int)pos len:(int)len {
    
    NSRange range = NSMakeRange(pos, len);
    UITextPosition *beginning = textView.beginningOfDocument;
    UITextPosition *start = [textView positionFromPosition:beginning offset:range.location];
    UITextPosition *end = [textView positionFromPosition:start offset:range.length];
    UITextRange *textRange = [textView textRangeFromPosition:start toPosition:end];
    [textView setSelectedTextRange:textRange];
    
}

-(void)SetAttributedPlaceholder:(UITextField *)textField color:(UIColor *)color {
    
    if ([textField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        
        NSString *str = textField.placeholder;
        
        if (textField.placeholder == nil) {
            str = @"";
        }
        
        textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:str attributes:@{NSForegroundColorAttributeName: color}];
        
    }
    
}

-(void)RoundingCorners:(UIView *)viewToUse topCorners:(BOOL)topCorners bottomCorners:(BOOL)bottomCorners cornerRadius:(int)cornerRadius {
    
    UIBezierPath *maskPath;
    CAShapeLayer *maskLayer;
    
    if (topCorners == YES && bottomCorners == NO) {
        
        maskPath = [UIBezierPath bezierPathWithRoundedRect:viewToUse.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight) cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        
    } else if (topCorners == NO && bottomCorners == YES) {
        
        maskPath = [UIBezierPath bezierPathWithRoundedRect:viewToUse.bounds byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight) cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        
    } else if (topCorners == YES && bottomCorners == YES) {
        
        maskPath = [UIBezierPath bezierPathWithRoundedRect:viewToUse.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight) cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        
    } else if (topCorners == NO && bottomCorners == NO) {
        
        maskPath = [UIBezierPath bezierPathWithRoundedRect:viewToUse.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight) cornerRadii:CGSizeMake(0, 0)];
        
    }
    
    maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = viewToUse.bounds;
    maskLayer.path  = maskPath.CGPath;
    viewToUse.layer.mask = maskLayer;
    
}

-(void)TextFieldIsEmptyColorChange:(UIView *)textFieldView textFieldField:(UITextField * _Nullable)textFieldField textFieldShouldDisplay:(BOOL)textFieldShouldDisplay defaultColor:(UIColor *)defaultColor {
    
    UIColor *errorBackgoundColor = [UIColor colorWithRed:255.0f/255.0f green:228.0f/255.0f blue:228.0f/255.0f alpha:1.0f];
    UIColor *errorPlaceholderColor = [UIColor colorWithRed:232.0f/255.0f green:152.0f/255.0f blue:152.0f/255.0f alpha:1.0f];
    
    UIColor *defaultPlaceholderColor = [UIColor colorWithRed:181.0f/255.0f green:188.0f/255.0f blue:193.0f/255.0f alpha:1.0f];
    
    BOOL TextFieldIsEmptyAndShouldBeDisplayed = (textFieldShouldDisplay == YES);
    
    if (TextFieldIsEmptyAndShouldBeDisplayed == YES) {
        
        if (textFieldView != nil) {
            textFieldView.backgroundColor = errorBackgoundColor;
        }
        
        [[[GeneralObject alloc] init] SetAttributedPlaceholder:textFieldField color:errorPlaceholderColor];
        
    } else {
        
        if (textFieldView != nil) {
            textFieldView.backgroundColor = defaultColor;
        }
        
        [[[GeneralObject alloc] init] SetAttributedPlaceholder:textFieldField color:defaultPlaceholderColor];
        
    }
    
}

#pragma mark - UX Methods

- (CGFloat)WidthOfString:(NSString *)string withFont:(UIFont *)font {
    
    if (string == nil || string == NULL) {
        string = @"";
    }
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    return [[[NSAttributedString alloc] initWithString:string attributes:attributes] size].width;
    
}

-(int)LineCountForText:(NSString *)text label:(UILabel *)label {
  
    UIFont *font = label.font;
    int width = label.frame.size.width;
    //MAXFLOAT
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin  attributes:@{NSFontAttributeName : font} context:nil];
    return ceil(rect.size.height / font.lineHeight);
    
}

-(void)CreateAlert:(NSString *)title message:(NSString * _Nullable)message currentViewController:(UIViewController *)currentViewController {
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:title
                                                                        message:message
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Got it!"
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction * _Nonnull action) {
        
        
        
    }];
    
    [controller addAction:cancel];
    [currentViewController presentViewController:controller animated:YES completion:nil];
    
}

#pragma mark - Popup Methods

-(void)AppStoreRating:(void (^)(BOOL finished))finishBlock {
    
    BOOL ThreeItemsHaveBeenCompleted = ([[[NSUserDefaults standardUserDefaults] objectForKey:@"CompletedItem"] isEqualToString:@"3"] || [[[NSUserDefaults standardUserDefaults] objectForKey:@"CompletedItem"] intValue] > 3);
    
    if (@available(iOS 10.3, *)) {
        
        if([SKStoreReviewController class]){
            
            if (ThreeItemsHaveBeenCompleted == YES) {
                
                int numberOfTimesReviewWasRequested =
                [[NSUserDefaults standardUserDefaults] objectForKey:@"TimesAskedForReview"] && [[[NSUserDefaults standardUserDefaults] objectForKey:@"TimesAskedForReview"] intValue] ?
                [[[NSUserDefaults standardUserDefaults] objectForKey:@"TimesAskedForReview"] intValue] : 0;
                
                BOOL ReviewWasRequestedLessThanThreeTimes = numberOfTimesReviewWasRequested < 3;
                
                if (ReviewWasRequestedLessThanThreeTimes) {
                    
                    BOOL ReviewWasNeverRequested = ![[NSUserDefaults standardUserDefaults] objectForKey:@"RequestedReview"];
                    
                    if (ReviewWasNeverRequested) {
                        
                        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"AddedItem"];
                        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"CompletedItem"];
                        
                        NSString *dateStringCurrent = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:@"MMMM dd, yyyy hh:mm a" returnAs:[NSString class]];
                        
                        [[NSUserDefaults standardUserDefaults] setObject:dateStringCurrent forKey:@"RequestedReview"];
                        
                    } else {
                        
                        NSString *dateFormat = @"MMMM dd, yyyy hh:mm a";
                        
                        if ([[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:[[NSUserDefaults standardUserDefaults] objectForKey:@"RequestedReview"] returnAs:[NSDate class]] == nil) {
                            dateFormat = @"MMMM dd, yyyy HH:mm";
                        }
                        
                        NSString *dateStringCurrent = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:dateFormat returnAs:[NSString class]];
                        
                        NSTimeInterval secondsBetween = [[[GeneralObject alloc] init] GenerateTimeIntervalBetweenTwoDates:[[NSUserDefaults standardUserDefaults] objectForKey:@"RequestedReview"] dateString2:dateStringCurrent dateFormat:dateFormat];
                        
                        if (secondsBetween > 2419200) {
                            
                            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"AddedItem"];
                            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"CompletedItem"];
                            [[NSUserDefaults standardUserDefaults] setObject:dateStringCurrent forKey:@"RequestedReview"];
                            
                            finishBlock(YES);
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
}

-(void)RequestFeedback:(void (^)(BOOL finished))finishBlock {
    
    BOOL ThreeItemsHaveBeenCompleted = ([[NSUserDefaults standardUserDefaults] objectForKey:@"CompletedItem"] &&
                                        ([[[NSUserDefaults standardUserDefaults] objectForKey:@"CompletedItem"] isEqualToString:@"3"] || [[[NSUserDefaults standardUserDefaults] objectForKey:@"CompletedItem"] intValue] > 3));
    BOOL SurveyHasBeenCompleted = [[NSUserDefaults standardUserDefaults] objectForKey:@"CompletedSurvey"] && [[[NSUserDefaults standardUserDefaults] objectForKey:@"CompletedSurvey"] isEqualToString:@"Yes"];
    
    if (ThreeItemsHaveBeenCompleted == YES && SurveyHasBeenCompleted == NO) {
        
        BOOL SurveyHasNeverBeenRequested = ![[NSUserDefaults standardUserDefaults] objectForKey:@"CompletedSurveyDate"];
        
        if (SurveyHasNeverBeenRequested) {
            
            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"AddedItem"];
            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"CompletedItem"];
            
            NSString *dateStringCurrent = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:@"MMMM dd, yyyy hh:mm a" returnAs:[NSString class]];
            
            [[NSUserDefaults standardUserDefaults] setObject:dateStringCurrent forKey:@"CompletedSurveyDate"];
            
        } else {
            
            NSString *dateFormat = @"MMMM dd, yyyy hh:mm a";
            
            if ([[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:[[NSUserDefaults standardUserDefaults] objectForKey:@"CompletedSurveyDate"] returnAs:[NSDate class]] == nil) {
                dateFormat = @"MMMM dd, yyyy HH:mm";
            }
            
            NSString *dateStringCurrent = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:dateFormat returnAs:[NSString class]];
            
            NSTimeInterval secondsBetween = [[[GeneralObject alloc] init] GenerateTimeIntervalBetweenTwoDates:[[NSUserDefaults standardUserDefaults] objectForKey:@"CompletedSurveyDate"] dateString2:dateStringCurrent dateFormat:dateFormat];
            
            if (secondsBetween > 1209600) {
                
                [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"AddedItem"];
                [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"CompletedItem"];
                [[NSUserDefaults standardUserDefaults] setObject:dateStringCurrent forKey:@"CompletedSurveyDate"];
                
                finishBlock(YES);
                
            }
            
        }
        
    }
    
}

-(void)AddingHomeMembersMessage:(void (^)(BOOL finished))finishBlock {
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"ImportantReminderDate"]) {
        
        NSString *dateStringCurrent = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:@"MMMM dd, yyyy hh:mm:ss a" returnAs:[NSString class]];
        
        [[NSUserDefaults standardUserDefaults] setObject:dateStringCurrent forKey:@"ImportantReminderDate"];
        
        finishBlock(YES);
        
    } else {

        NSString *dateFormat = @"MMMM dd, yyyy hh:mm a";
        
        if ([[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:[[NSUserDefaults standardUserDefaults] objectForKey:@"ImportantReminderDate"] returnAs:[NSDate class]] == nil) {
            dateFormat = @"MMMM dd, yyyy HH:mm";
        }
        
        NSString *dateStringCurrent = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:dateFormat returnAs:[NSString class]];
        
        NSTimeInterval secondsBetween = [[[GeneralObject alloc] init] GenerateTimeIntervalBetweenTwoDates:[[NSUserDefaults standardUserDefaults] objectForKey:@"ImportantReminderDate"] dateString2:dateStringCurrent dateFormat:dateFormat];
        
        if (secondsBetween > 86400) {
            
            [[NSUserDefaults standardUserDefaults] setObject:dateStringCurrent forKey:@"ImportantReminderDate"];
            
            finishBlock(YES);
            
        }
        
    }
    
}

-(void)InvitingHomeMembersPopup:(void (^)(BOOL finished))finishBlock {
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"InviteHomeMemberDate"]) {
        
        NSString *dateStringCurrent = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:@"MMMM dd, yyyy hh:mm:ss a" returnAs:[NSString class]];
        
        [[NSUserDefaults standardUserDefaults] setObject:dateStringCurrent forKey:@"InviteHomeMemberDate"];
        
        finishBlock(YES);
        
    } else {
        
        NSString *dateFormat = @"MMMM dd, yyyy hh:mm a";
        
        if ([[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:[[NSUserDefaults standardUserDefaults] objectForKey:@"InviteHomeMemberDate"] returnAs:[NSDate class]] == nil) {
            dateFormat = @"MMMM dd, yyyy HH:mm";
        }
        
        NSString *dateStringCurrent = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:dateFormat returnAs:[NSString class]];
        
        NSTimeInterval secondsBetween = [[[GeneralObject alloc] init] GenerateTimeIntervalBetweenTwoDates:[[NSUserDefaults standardUserDefaults] objectForKey:@"InviteHomeMemberDate"] dateString2:dateStringCurrent dateFormat:dateFormat];
        
        if (secondsBetween > 86400) {
            
            [[NSUserDefaults standardUserDefaults] setObject:dateStringCurrent forKey:@"InviteHomeMemberDate"];
            
            finishBlock(YES);
            
        }
        
    }
    
}

-(void)InvitingHomeMembersAcceptedPopup:(void (^)(BOOL finished))finishBlock {
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"InviteHomeMemberAcceptedDate"]) {
        
        NSString *dateStringCurrent = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:@"MMMM dd, yyyy hh:mm:ss a" returnAs:[NSString class]];
        
        [[NSUserDefaults standardUserDefaults] setObject:dateStringCurrent forKey:@"InviteHomeMemberAcceptedDate"];
        
        finishBlock(YES);
        
    } else {
 
        NSString *dateFormat = @"MMMM dd, yyyy hh:mm a";
        
        if ([[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:[[NSUserDefaults standardUserDefaults] objectForKey:@"InviteHomeMemberAcceptedDate"] returnAs:[NSDate class]] == nil) {
            dateFormat = @"MMMM dd, yyyy HH:mm";
        }
        
        NSString *dateStringCurrent = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:dateFormat returnAs:[NSString class]];
        
        NSTimeInterval secondsBetween = [[[GeneralObject alloc] init] GenerateTimeIntervalBetweenTwoDates:[[NSUserDefaults standardUserDefaults] objectForKey:@"InviteHomeMemberAcceptedDate"] dateString2:dateStringCurrent dateFormat:dateFormat];
        
        if (secondsBetween > 86400) {
            
            [[NSUserDefaults standardUserDefaults] setObject:dateStringCurrent forKey:@"InviteHomeMemberAccepted"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"InviteHomeMemberAccepted"];
            
            finishBlock(YES);
            
        }
        
    }
    
}

-(void)DisplayWeDivvyPremiumPage:(void (^)(BOOL finished, BOOL DisplayDiscount))finishBlock {
    
    BOOL PremiumSubscriptionIsOn = [[[BoolDataObject alloc] init] PremiumSubscriptionIsOn];
    BOOL SideBarPopupAlreadyClicked = [[NSUserDefaults standardUserDefaults] objectForKey:@"SideBarPopupClicked"];
    
    if (PremiumSubscriptionIsOn == NO && [[[NSUserDefaults standardUserDefaults] objectForKey:@"JoinedHome"] isEqualToString:@"Yes"] == NO) {
        
        finishBlock(YES, YES);
        
    }
        
//    if (PremiumSubscriptionIsOn == NO && SideBarPopupAlreadyClicked == YES) {
//        
//        if ((![[NSUserDefaults standardUserDefaults] objectForKey:@"DisplayWeDivvyPremiumPageDisplayedNumberOfTimes"]) ||
//            ([[NSUserDefaults standardUserDefaults] objectForKey:@"DisplayWeDivvyPremiumPageDisplayedNumberOfTimes"] &&
//             [[[NSUserDefaults standardUserDefaults] objectForKey:@"DisplayWeDivvyPremiumPageDisplayedNumberOfTimes"] isEqualToString:@"1"])) {
//            
//            if (![[NSUserDefaults standardUserDefaults] objectForKey:@"DisplayWeDivvyPremiumPage"]) {
//                
//                NSString *dateStringCurrent = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:@"MMMM dd, yyyy hh:mm:ss a" returnAs:[NSString class]];
//                
//                [[NSUserDefaults standardUserDefaults] setObject:dateStringCurrent forKey:@"DisplayWeDivvyPremiumPage"];
//                
//            } else {
//
//                NSString *dateFormat = @"MMMM dd, yyyy hh:mm a";
//                
//                if ([[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:[[NSUserDefaults standardUserDefaults] objectForKey:@"DisplayWeDivvyPremiumPage"] returnAs:[NSDate class]] == nil) {
//                    dateFormat = @"MMMM dd, yyyy HH:mm";
//                }
//                
//                NSString *dateStringCurrent = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:dateFormat returnAs:[NSString class]];
//              
//                NSTimeInterval secondsBetween = [[[GeneralObject alloc] init] GenerateTimeIntervalBetweenTwoDates:[[NSUserDefaults standardUserDefaults] objectForKey:@"DisplayWeDivvyPremiumPage"] dateString2:dateStringCurrent dateFormat:dateFormat];
//                
//                float SecondsToPass = 0;
//                
//                //If Popup Never Shown Show After 1 Week
//                if (![[NSUserDefaults standardUserDefaults] objectForKey:@"DisplayWeDivvyPremiumPageDisplayedNumberOfTimes"]) {
//                    SecondsToPass = 86400*12;
//                    
//                    //If Popup Shown Once Show After 2 Week
//                } else if ([[NSUserDefaults standardUserDefaults] objectForKey:@"DisplayWeDivvyPremiumPageDisplayedNumberOfTimes"] &&
//                           [[[NSUserDefaults standardUserDefaults] objectForKey:@"DisplayWeDivvyPremiumPageDisplayedNumberOfTimes"] isEqualToString:@"1"]) {
//                    SecondsToPass = 86400*19;
//                }
//                
//                if (secondsBetween > SecondsToPass) {
//                    
//                    [[NSUserDefaults standardUserDefaults] setObject:dateStringCurrent forKey:@"DisplayWeDivvyPremiumPage"];
//                    
//                    //If Popup Never Shown
//                    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"DisplayWeDivvyPremiumPageDisplayedNumberOfTimes"]) {
//                        
//                        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"DisplayWeDivvyPremiumPageDisplayedNumberOfTimes"];
//                        
//                        finishBlock(YES, NO);
//                        
//                        //If Popup Shown Once
//                    } else if ([[NSUserDefaults standardUserDefaults] objectForKey:@"DisplayWeDivvyPremiumPageDisplayedNumberOfTimes"] &&
//                               [[[NSUserDefaults standardUserDefaults] objectForKey:@"DisplayWeDivvyPremiumPageDisplayedNumberOfTimes"] isEqualToString:@"1"]) {
//                        
//                        [[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:@"DisplayWeDivvyPremiumPageDisplayedNumberOfTimes"];
//                        
//                        finishBlock(YES, YES);
//                        
//                    }
//                    
//                }
//                
//            }
//            
//        }
//        
//    }
    
}

-(void)DisplayWeDivvyPremiumSideBarPopup:(void (^)(BOOL finished))finishBlock {
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"DisplayWeDivvyPremiumSideBarPopupDisplayedNumberOfTimes"]) {
        
        if (![[NSUserDefaults standardUserDefaults] objectForKey:@"DisplayWeDivvyPremiumSideBarPopupDate"]) {
            
            NSString *dateStringCurrent = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:@"MMMM dd, yyyy hh:mm:ss a" returnAs:[NSString class]];
            
            [[NSUserDefaults standardUserDefaults] setObject:dateStringCurrent forKey:@"DisplayWeDivvyPremiumSideBarPopupDate"];
            
        } else {

            NSString *dateFormat = @"MMMM dd, yyyy hh:mm a";
            
            if ([[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:[[NSUserDefaults standardUserDefaults] objectForKey:@"DisplayWeDivvyPremiumSideBarPopupDate"] returnAs:[NSDate class]] == nil) {
                dateFormat = @"MMMM dd, yyyy HH:mm";
            }
            
            NSString *dateStringCurrent = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:dateFormat returnAs:[NSString class]];
           
            NSTimeInterval secondsBetween = [[[GeneralObject alloc] init] GenerateTimeIntervalBetweenTwoDates:[[NSUserDefaults standardUserDefaults] objectForKey:@"DisplayWeDivvyPremiumSideBarPopupDate"] dateString2:dateStringCurrent dateFormat:dateFormat];
            
            float SecondsToPass = 86400*5;
            
            if (secondsBetween > SecondsToPass) {
                
                [[NSUserDefaults standardUserDefaults] setObject:dateStringCurrent forKey:@"DisplayWeDivvyPremiumSideBarPopupDate"];
                [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"DisplayWeDivvyPremiumSideBarPopupDisplayedNumberOfTimes"];
                
                finishBlock(YES);
                
            }
            
        }
        
    }
    
}

-(void)DisplayCancelledSubscriptionFeedback:(void (^)(BOOL finished))finishBlock {
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"PremiumSubscriptionJustCancelled"] &&
        [[[NSUserDefaults standardUserDefaults] objectForKey:@"PremiumSubscriptionJustCancelled"] isEqualToString:@"Yes"]) {
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"PremiumSubscriptionJustCancelled"];
        
        finishBlock(YES);
        
    }
    
}

-(void)RegisterForNotifications:(void (^)(BOOL finished))finishBlock {
    
    BOOL DisplayRegisterForNotifications = [[NSUserDefaults standardUserDefaults] objectForKey:@"DisplayRegisterForNotificationsPopup"] && [[[NSUserDefaults standardUserDefaults] objectForKey:@"DisplayRegisterForNotificationsPopup"] isEqualToString:@"Yes"];
    BOOL UserHasAlreadyBeenAskedToReceiveNotifications = [[NSUserDefaults standardUserDefaults] objectForKey:@"HasTheUserBeenAskedToReceiveNotifications"] && [[[NSUserDefaults standardUserDefaults] objectForKey:@"HasTheUserBeenAskedToReceiveNotifications"] isEqualToString:@"Yes"];
   
    if (DisplayRegisterForNotifications == YES) {
       
        if (UserHasAlreadyBeenAskedToReceiveNotifications == NO) {
           
            if (![[NSUserDefaults standardUserDefaults] objectForKey:@"RegisterForNotificationsDate"]) {
                
                [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"DisplayRegisterForNotificationsPopup"];
                [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"RegisterForNotificationsHasBeenShown"];
                
                NSString *dateStringCurrent = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:@"MMMM dd, yyyy hh:mm:ss a" returnAs:[NSString class]];
                
                [[NSUserDefaults standardUserDefaults] setObject:dateStringCurrent forKey:@"RegisterForNotificationsDate"];
               
                finishBlock(YES);
                
            } else {

                NSString *dateFormat = @"MMMM dd, yyyy hh:mm a";
                
                if ([[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:[[NSUserDefaults standardUserDefaults] objectForKey:@"RegisterForNotificationsDate"] returnAs:[NSDate class]] == nil) {
                    dateFormat = @"MMMM dd, yyyy HH:mm";
                }
                
                NSString *dateStringCurrent = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:dateFormat returnAs:[NSString class]];
               
                NSTimeInterval secondsBetween = [[[GeneralObject alloc] init] GenerateTimeIntervalBetweenTwoDates:[[NSUserDefaults standardUserDefaults] objectForKey:@"RegisterForNotificationsDate"] dateString2:dateStringCurrent dateFormat:dateFormat];
               
                if (secondsBetween > 604800) {
                    
                    [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"DisplayRegisterForNotificationsPopup"];
                    [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"RegisterForNotificationsHasBeenShown"];
                    
                    finishBlock(YES);
                    
                }
                
            }
            
        }
        
    }
    
}

#pragma mark - Generate Users Turn

-(NSString *)GenerateNextUsersTurn:(NSMutableArray *)itemAssignedTo itemAssignedToOriginal:(NSMutableArray *)itemAssignedToOriginal homeMembersDict:(NSMutableDictionary *)homeMembersDict itemTakeTurns:(NSString *)itemTakeTurns itemTurnUserID:(NSString *)itemTurnUserID {
   
    if ([itemTakeTurns isEqualToString:@"No"]) {
        return @"";
    }
    
    if (itemAssignedTo.count == 0) {
        itemAssignedTo = homeMembersDict[@"UserID"] ? [homeMembersDict[@"UserID"] mutableCopy] : [NSMutableArray array];
    }
   
    if (itemAssignedTo.count > 1) {
        
        if ([itemAssignedTo containsObject:itemTurnUserID]) {
            
            
            
            
            BOOL BothAssignedToArraysAreTheSame = itemAssignedTo.count == itemAssignedToOriginal.count ? YES : NO;
            
            for (NSString *userID in itemAssignedTo) {
                
                if ([itemAssignedToOriginal containsObject:userID] == NO) {
                    
                    BothAssignedToArraysAreTheSame = NO;
                    break;
                    
                }
                
            }
            
            
            
            
            if (BothAssignedToArraysAreTheSame == YES) {
             
                NSUInteger index = [itemAssignedToOriginal indexOfObject:itemTurnUserID];
                
                if (index + 1 > itemAssignedToOriginal.count - 1) {
                    
                    itemTurnUserID = [itemAssignedToOriginal count] > 0 ? itemAssignedToOriginal[0] : @"";
                    
                } else {
                    
                    itemTurnUserID = [itemAssignedToOriginal count] > (index + 1) ? itemAssignedToOriginal[(index + 1)] : @"";
                    
                }
           
            } else {
                
                if ([itemAssignedToOriginal containsObject:itemTurnUserID]) {
                    
                    NSUInteger index = [itemAssignedToOriginal indexOfObject:itemTurnUserID];
                    NSUInteger indexToUse = index;
                    NSMutableArray *arrayToUse = itemAssignedTo.count > itemAssignedToOriginal.count ? itemAssignedTo : itemAssignedToOriginal;
                    
                    for (int i=0 ; i<arrayToUse.count ; i++) {
                        
                        if (indexToUse + 1 > itemAssignedTo.count - 1) {
                            
                            indexToUse = 0;
                            
                        } else {
                            
                            indexToUse += 1;
                            
                        }
                        
                        if ([itemAssignedTo containsObject:itemAssignedTo[indexToUse]]) {
                            itemTurnUserID = [itemAssignedTo count] > indexToUse ? itemAssignedTo[indexToUse] : @"";
                            break;
                        }
                        
                    }
                    
                } else {
                    
                    itemTurnUserID = @"";
                    
                }
                
            }
            
          
            
            
        } else {
            
            itemTurnUserID = [itemAssignedTo count] > 0 ? itemAssignedTo[0] : @"";
            
        }
        
    } else {
        
        itemTurnUserID = [itemAssignedTo count] > 0 ? itemAssignedTo[0] : @"";
        
    }
    
    if ([itemTurnUserID isEqualToString:@""]) {
        itemTurnUserID = [itemAssignedTo count] > 0 ? itemAssignedTo[0] : @"";
    }
 
    return itemTurnUserID;
}

-(NSString *)GenerateCurrentUserTurnFromDict:(NSMutableDictionary *)dictToUse homeMembersDict:(NSMutableDictionary *)homeMembersDict itemType:(NSString *)itemType {
    
    NSMutableArray *itemAssignedTo = dictToUse[@"ItemAssignedTo"] ? [dictToUse[@"ItemAssignedTo"] mutableCopy] : [NSMutableArray array];
    NSMutableDictionary *itemCompletedDict = dictToUse[@"ItemCompletedDict"] ? [dictToUse[@"ItemCompletedDict"] mutableCopy] : [NSMutableDictionary dictionary];
    NSString *itemDueDate = dictToUse[@"ItemDueDate"] ? dictToUse[@"ItemDueDate"] : @"";
    NSString *itemRepeats = dictToUse[@"ItemRepeats"] ? dictToUse[@"ItemRepeats"] : @"";
    NSString *itemRepeatIfCompletedEarly = dictToUse[@"ItemRepeatIfCompletedEarly"] ? dictToUse[@"ItemRepeatIfCompletedEarly"] : @"";
    NSString *itemCompleteAsNeeded = dictToUse[@"ItemCompleteAsNeeded"] ? dictToUse[@"ItemCompleteAsNeeded"] : @"";
    NSString *itemTakeTurns = dictToUse[@"ItemTakeTurns"] ? dictToUse[@"ItemTakeTurns"] : @"";
    NSString *itemTurnUserID = dictToUse[@"ItemTurnUserID"] ? dictToUse[@"ItemTurnUserID"] : @"";
   
    if (itemTurnUserID.length == 0 && [itemTakeTurns isEqualToString:@"Yes"]) {
        
        itemTurnUserID = [[[GeneralObject alloc] init] GenerateCurrentUsersTurn:itemDueDate itemRepeats:itemRepeats itemRepeatIfCompletedEarly:itemRepeatIfCompletedEarly itemCompleteAsNeeded:itemCompleteAsNeeded itemTakeTurns:itemTakeTurns itemCompletedDict:itemCompletedDict itemAssignedToArray:itemAssignedTo itemType:itemType itemTurnUserID:itemTurnUserID homeMembersDict:homeMembersDict];
   
    }
   
    return itemTurnUserID;
}

-(NSString *)GenerateCurrentUsersTurn:(NSString *)itemDueDate itemRepeats:(NSString *)itemRepeats itemRepeatIfCompletedEarly:(NSString *)itemRepeatIfCompletedEarly itemCompleteAsNeeded:(NSString *)itemCompleteAsNeeded itemTakeTurns:(NSString *)itemTakeTurns itemCompletedDict:(NSMutableDictionary *)itemCompletedDict itemAssignedToArray:(NSMutableArray *)itemAssignedToArray itemType:(NSString *)itemType itemTurnUserID:(NSString *)itemTurnUserID homeMembersDict:(NSMutableDictionary *)homeMembersDict {
    
    BOOL TaskIsTakingTurns = itemTakeTurns != nil && itemTakeTurns != NULL ? [[[BoolDataObject alloc] init] TaskIsTakingTurns:[@{@"ItemTakeTurns" : itemTakeTurns} mutableCopy] itemType:itemType] : NO;
    BOOL TaskIsCompleteAsNeeded = itemCompleteAsNeeded != nil && itemCompleteAsNeeded != NULL ? [[[BoolDataObject alloc] init] TaskIsCompleteAsNeeded:[@{@"ItemCompleteAsNeeded" : itemCompleteAsNeeded} mutableCopy] itemType:itemType] : NO;
    
    if (TaskIsTakingTurns == NO) {
        return @"";
    }
    
    itemDueDate = [[[GeneralObject alloc] init] GenerateStringWithReplacementString:itemDueDate stringToReplace:@"Any Time" replacementString:@"11:59 PM"];
    
    if (TaskIsCompleteAsNeeded == YES && TaskIsTakingTurns == YES) {
        
        return [[[GeneralObject alloc] init] GenerateCurrentUsersTurnCompleteAsNeeded:itemRepeats itemRepeatIfCompletedEarly:itemRepeatIfCompletedEarly itemTakeTurns:itemTakeTurns itemCompleteAsNeeded:itemCompleteAsNeeded itemCompletedDict:itemCompletedDict itemAssignedToArray:itemAssignedToArray itemType:itemType homeMembersDict:homeMembersDict];
        
    } else if (TaskIsCompleteAsNeeded == NO && TaskIsTakingTurns == YES && [itemTurnUserID length] == 0) {
        
        return [[[GeneralObject alloc] init] GenerateNextUsersTurn:itemAssignedToArray itemAssignedToOriginal:itemAssignedToArray homeMembersDict:homeMembersDict itemTakeTurns:itemTakeTurns itemTurnUserID:itemTurnUserID];
        
    }
    
    return @"";
}

#pragma mark - Other

-(BOOL)ConnectedToInternet {
    
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr*)&zeroAddress);
    if (reachability != NULL) {
        //NetworkStatus retVal = NotReachable;
        SCNetworkReachabilityFlags flags;
        if (SCNetworkReachabilityGetFlags(reachability, &flags)) {
            if ((flags & kSCNetworkReachabilityFlagsReachable) == 0)
            {
                // If target host is not reachable
                return NO;
            }
            
            if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) == 0)
            {
                // If target host is reachable and no connection is required
                //  then we'll assume (for now) that your on Wi-Fi
                return YES;
            }
            
            
            if ((((flags & kSCNetworkReachabilityFlagsConnectionOnDemand ) != 0) ||
                 (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0))
            {
                // ... and the connection is on-demand (or on-traffic) if the
                //     calling application is using the CFSocketStream or higher APIs.
                
                if ((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0)
                {
                    // ... and no [user] intervention is needed
                    return YES;
                }
            }
            
            if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN)
            {
                // ... but WWAN connections are OK if the calling application
                //     is using the CFNetwork (CFSocketStream?) APIs.
                return YES;
            }
        }
    }
    
    return NO;
}

-(BOOL)ItemCompletedOrItemInProgressDictContainsUserID:(NSMutableDictionary *)dictToUse userIDToFind:(NSString *)userIDToFind {
    
    BOOL ObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:dictToUse classArr:@[[NSDictionary class], [NSMutableDictionary class]]];

    if (dictToUse != nil && dictToUse != NULL && ObjectIsKindOfClass == YES) {
        
        for (NSString *userIDKey in [dictToUse allKeys]) {
            
            NSString *userIDKeyCopy = [userIDKey mutableCopy];
            
            if ([userIDKeyCopy containsString:@"•••"] == YES) {
                
                userIDKeyCopy = [[userIDKeyCopy componentsSeparatedByString:@"•••"] count] > 0 ? [userIDKeyCopy componentsSeparatedByString:@"•••"][0] : @"";
                
            }
            
            if ([userIDKeyCopy isEqualToString:userIDToFind]) {
                
                return YES;
                
            }
            
        }
        
    }
    
    return NO;
}

-(NSDictionary *)GeneralLastUserIDCompletedTaskRepeatingWhenCompleted:(NSMutableDictionary *)itemCompletedDict specificUserID:(NSString *)specificUserID {
    
    NSMutableArray *arrayOfDateMarked = [NSMutableArray array];
    
    for (NSString *userIDKey in [itemCompletedDict allKeys]) {
        
        if (([specificUserID length] > 0 && [userIDKey containsString:specificUserID]) || [specificUserID length] == 0) {
            
            [arrayOfDateMarked addObject:itemCompletedDict[userIDKey][@"Date Marked"]];
            
        }
        
    }
    
    arrayOfDateMarked = [[[GeneralObject alloc] init] SortArrayOfDates:arrayOfDateMarked dateFormatString:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *lastUserIDCompleted = @"";
    NSString *lastCompletedDictKey = @"";
    NSString *lastDateMarkedCompleted = @"";
    
    if ([arrayOfDateMarked count] > 0) {
        
        lastDateMarkedCompleted = [arrayOfDateMarked lastObject];
        
        for (NSString *userIDKey in [itemCompletedDict allKeys]) {
            
            if (itemCompletedDict[userIDKey] && itemCompletedDict[userIDKey][@"Date Marked"] && [itemCompletedDict[userIDKey][@"Date Marked"] isEqualToString:lastDateMarkedCompleted]) {
                
                lastCompletedDictKey = userIDKey;
                lastUserIDCompleted = userIDKey;
                break;
                
            }
            
        }
        
    }
    
    if ([lastUserIDCompleted containsString:@"•••"]) {
        lastUserIDCompleted = [[lastUserIDCompleted componentsSeparatedByString:@"•••"] count] > 0 ? [lastUserIDCompleted componentsSeparatedByString:@"•••"][0] : @"";
    }
    
    return @{@"LastUserIDCompleted" : lastUserIDCompleted, @"LastDateMarkedCompleted" : lastDateMarkedCompleted, @"Key" : lastCompletedDictKey};
    
}

#pragma mark - Analytics Methods

-(void)TrackInMixPanel:(NSString *)track {
    
    Mixpanel *mixpanel = [Mixpanel sharedInstance];
    [mixpanel identify:[[NSUserDefaults standardUserDefaults] objectForKey:@"MixPanelID"]];
    [mixpanel track:track properties:@{track : [NSString stringWithFormat:@"%@1", track]}];
    
}

#pragma mark - IAP Methods

-(void)GenerateProducts:(NSArray<SKProduct *> * _Nonnull)products
      completionHandler:(void (^)(BOOL finished,
                                  NSString *errorString,
                                  NSMutableArray *returningPremiumPlanProductsArray,
                                  NSMutableDictionary *returningPremiumPlanPricesDict,
                                  NSMutableDictionary *returningPremiumPlanExpensivePricesDict,
                                  NSMutableDictionary *returningPremiumPlanPricesDiscountDict,
                                  NSMutableDictionary *returningPremiumPlanPricesNoFreeTrialDict))finishBlock {
    
    __block BOOL BlockFinished = NO;
    
    // Define a timeout interval (adjust as needed)
    NSTimeInterval timeoutInterval = 10.0; // 10 seconds
    
    // Create a dispatch queue for executing the completion block
    dispatch_queue_t completionQueue = dispatch_queue_create("com.example.completionQueue", DISPATCH_QUEUE_SERIAL);
    
    // Execute the completion block on the completionQueue
    dispatch_async(completionQueue, ^{
        
        NSTimeInterval delayInSeconds = 0.0;
        
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            
            NSMutableArray *premiumPlanProductsArray = products ? [products mutableCopy] : [NSMutableDictionary dictionary];
            
            NSMutableDictionary *premiumPlanPricesDict = [[[[GeneralObject alloc] init] GeneratePremiumPlanPricesDict] mutableCopy];
            NSMutableDictionary *premiumPlanExpensivePricesDict = [[[[GeneralObject alloc] init] GeneratePremiumPlanExpensivePricesDict] mutableCopy];
            NSMutableDictionary *premiumPlanPricesDiscountDict = [[[[GeneralObject alloc] init] GeneratePremiumPlanPricesDiscountDict] mutableCopy];
            NSMutableDictionary *premiumPlanPricesNoFreeTrialDict = [[[[GeneralObject alloc] init] GeneratePremiumPlanPricesNoFreeTrialDict] mutableCopy];
            
            for (SKProduct *product in products) {
                
                BOOL ProductIsInExpensiveGroup = [product.productIdentifier containsString:@"Expensive"];
                BOOL ProductIsInDiscountGroup = [product.productIdentifier containsString:@"Discount"];
                BOOL ProductIsInNoFreeTrialGroup = [product.productIdentifier containsString:@"NoFreeTrial"];
                
                if (ProductIsInExpensiveGroup == YES) {
                    
                    premiumPlanExpensivePricesDict = [[[GeneralObject alloc] init] GeneratePremiumPlanWithUpdatedPrices:premiumPlanExpensivePricesDict product:product];
                    
                } else if (ProductIsInDiscountGroup == YES) {
                    
                    premiumPlanPricesDiscountDict = [[[GeneralObject alloc] init] GeneratePremiumPlanWithUpdatedPrices:premiumPlanPricesDiscountDict product:product];
                    
                } else if (ProductIsInNoFreeTrialGroup == YES) {
                    
                    premiumPlanPricesNoFreeTrialDict = [[[GeneralObject alloc] init] GeneratePremiumPlanWithUpdatedPrices:premiumPlanPricesNoFreeTrialDict product:product];
                    
                }  else {
                    
                    premiumPlanPricesDict = [[[GeneralObject alloc] init] GeneratePremiumPlanWithUpdatedPrices:premiumPlanPricesDict product:product];
                    
                }
                
            }
            
            // Call the completion block on the main queue
            dispatch_async(dispatch_get_main_queue(), ^{
                
                BlockFinished = YES;
                
                finishBlock(YES, @"", premiumPlanProductsArray, premiumPlanPricesDict, premiumPlanExpensivePricesDict, premiumPlanPricesDiscountDict, premiumPlanPricesNoFreeTrialDict);
                
            });
            
        });
        
    });
    
    // Schedule a timeout block to cancel the execution if it takes too long
    dispatch_time_t timeoutTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeoutInterval * NSEC_PER_SEC));
    dispatch_after(timeoutTime, completionQueue, ^{
        
        if (BlockFinished == NO) {
            
            // The completion block execution took too long; cancel it
            NSLog(@"Completion block timed out");
            // You can handle the timeout event here (e.g., set an error flag)
            // Optionally, you can also call the finishBlock with a failure status
            NSString *errorString = @"An error occurred while trying to retreive the WeDivvy Premium products.\nTry reopening the page to try again.";
            
            finishBlock(YES, errorString, [NSMutableArray array], [NSMutableDictionary dictionary], [NSMutableDictionary dictionary], [NSMutableDictionary dictionary], [NSMutableDictionary dictionary]);
            
        }
        
    });
    
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Internal Methods
#pragma mark
#pragma mark
#pragma mark -

#pragma mark Premium Methods

-(void)CheckIfMyPremiumSubscriptionWasGivenByAdmin:(NSMutableDictionary *)homeMembersDict completionHandler:(void (^)(BOOL finished, BOOL SubscriptionWasGivenToMeByAdmin))finishBlock {
    
    BOOL SubscriptionWasGivenByAdmin = NO;
    
    NSString *myUserID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
    
    NSMutableArray *userIDArray = homeMembersDict && homeMembersDict[@"UserID"] ? homeMembersDict[@"UserID"] : [NSMutableArray array];
    
    
    
    if ([userIDArray containsObject:myUserID]) {
        
        
        
        NSUInteger index = [userIDArray indexOfObject:myUserID];
        NSString *subscriptionAdmin = homeMembersDict && homeMembersDict[@"SubscriptionAdmin"] && [(NSArray *)homeMembersDict[@"SubscriptionAdmin"] count] > index ? homeMembersDict[@"SubscriptionAdmin"][index] : [NSMutableDictionary dictionary];
        
        SubscriptionWasGivenByAdmin = subscriptionAdmin ? [subscriptionAdmin length] > 0 : NO;
        
        
        
    }
    
    
    
    finishBlock(YES, SubscriptionWasGivenByAdmin);
}

-(void)CheckIfMyPremiumSubscriptionWasGivenBySomeoneElse:(NSMutableDictionary *)homeMembersDict completionHandler:(void (^)(BOOL finished, BOOL SubscriptionWasGivenToMe, BOOL SubscriptionGivenByStillHasSubscription, NSString *purchasingUsersUsrID))finishBlock {
    
    BOOL SubscriptionWasGivenToMe = NO;
    BOOL SubscriptionGivenByStillHasSubscription = NO;
    NSString *purchasingUsersUsrID = @"";
    
    NSString *myUserID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
    
    NSMutableArray *userIDArray = homeMembersDict && homeMembersDict[@"UserID"] ? homeMembersDict[@"UserID"] : [NSMutableArray array];
    
    
    
    if ([userIDArray containsObject:myUserID]) {
        
        
        
        NSUInteger index = [userIDArray indexOfObject:myUserID];
        NSMutableDictionary *myWeDivvyPremiumDict = homeMembersDict && homeMembersDict[@"WeDivvyPremium"] && [(NSArray *)homeMembersDict[@"WeDivvyPremium"] count] > index ? homeMembersDict[@"WeDivvyPremium"][index] : [NSMutableDictionary dictionary];
        
        SubscriptionWasGivenToMe = myWeDivvyPremiumDict && myWeDivvyPremiumDict[@"SubscriptionGivenBy"] ? [myWeDivvyPremiumDict[@"SubscriptionGivenBy"] length] > 0 : NO;
        
        
        
        if (SubscriptionWasGivenToMe) {
            
            NSString *mySubscriptionGivenBy = myWeDivvyPremiumDict[@"SubscriptionGivenBy"] ? myWeDivvyPremiumDict[@"SubscriptionGivenBy"] : @"";
            NSUInteger indexOfSubscriptionGivenByUser = [userIDArray containsObject:mySubscriptionGivenBy] ? [userIDArray indexOfObject:mySubscriptionGivenBy] : -1;
            
            NSMutableDictionary *subscriptionGivenByWeDivvyPremiumDict =
            homeMembersDict[@"WeDivvyPremium"] &&
            [(NSArray *)homeMembersDict[@"WeDivvyPremium"] count] > indexOfSubscriptionGivenByUser ?
            homeMembersDict[@"WeDivvyPremium"][indexOfSubscriptionGivenByUser] : [NSMutableDictionary dictionary];
            
            SubscriptionGivenByStillHasSubscription =
            subscriptionGivenByWeDivvyPremiumDict[@"SubscriptionDatePurchased"] ?
            [subscriptionGivenByWeDivvyPremiumDict[@"SubscriptionDatePurchased"] length] > 0 : NO;
            
            purchasingUsersUsrID = mySubscriptionGivenBy;
            
        }
        
        
        
    }
    
    
    
    finishBlock(YES, SubscriptionWasGivenToMe, SubscriptionGivenByStillHasSubscription, purchasingUsersUsrID);
}

-(BOOL)SubscriptionWasPurchasedByMe:(NSMutableDictionary *)homeMembersDict {
    
    BOOL SubscriptionWasPurchasedByMe = NO;
    
    NSString *myUserID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
    
    NSMutableArray *userIDArray = homeMembersDict && homeMembersDict[@"UserID"] ? homeMembersDict[@"UserID"] : [NSMutableArray array];
    NSUInteger index = [userIDArray containsObject:myUserID] ? [userIDArray indexOfObject:myUserID] : -1;
    
    NSMutableDictionary *myWeDivvyPremiumDict = homeMembersDict && homeMembersDict[@"WeDivvyPremium"] && [(NSArray *)homeMembersDict[@"WeDivvyPremium"] count] > index ? homeMembersDict[@"WeDivvyPremium"][index] : [NSMutableDictionary dictionary];
    NSString *subscriptionDataPurchased = myWeDivvyPremiumDict && myWeDivvyPremiumDict[@"SubscriptionDatePurchased"] ? myWeDivvyPremiumDict[@"SubscriptionDatePurchased"] : @"";
    
    SubscriptionWasPurchasedByMe = [subscriptionDataPurchased length] > 0;
    
    return SubscriptionWasPurchasedByMe;
}


-(NSDictionary *)GetReceiptData {
    
    NSURL *receiptURL = [[NSBundle mainBundle] appStoreReceiptURL] ? [[NSBundle mainBundle] appStoreReceiptURL] : [NSURL URLWithString:@""];
    NSData *receipt = [NSData dataWithContentsOfURL:receiptURL] ? [NSData dataWithContentsOfURL:receiptURL] : [NSData data];
    
    NSError *error;
    
    NSDictionary *requestContents = @{@"receipt-data": [receipt base64EncodedStringWithOptions:0] ,
                                      @"password" : @"667f42d14716491cb696a45d5cbeef05",
                                      @"exclude-old-transactions" : @"false"};
    
    NSData *requestData =
    [NSJSONSerialization dataWithJSONObject:requestContents options:0 error:&error] ?
    [NSJSONSerialization dataWithJSONObject:requestContents options:0 error:&error] : [NSData data];
    
    //https://sandbox.itunes.apple.com/verifyReceipt
    //https://buy.itunes.apple.com/verifyReceipt
    NSURL *storeURL = [NSURL URLWithString:@"https://buy.itunes.apple.com/verifyReceipt"];
    
    NSMutableURLRequest *storeRequest = [NSMutableURLRequest requestWithURL:storeURL];
    [storeRequest setHTTPMethod:@"POST"];
    
    return @{@"storeRequest" : storeRequest, @"requestData" : requestData};
}

-(void)ResetNSUserDefaultsToNonPremium {
    
//    NSArray *arr = @[@"Chores", @"Expenses", @"Lists"];
    
//    for (NSString *collection in arr) {
        
//        NSArray *keyArray = [[[GeneralObject alloc] init] GenerateKeyArrayManually:[collection isEqualToString:@"Chores"] Expense:[collection isEqualToString:@"Expenses"] List:[collection isEqualToString:@"Lists"] Home:NO];
        
//        [[[GetDataObject alloc] init] GetDataCoreData:collection keyArray:keyArray completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningDataDict) {
//
//            if (returningDataDict && returningDataDict[@"ItemUniqueID"]) {
//
//                for (NSString *itemUniqueID in returningDataDict[@"ItemUniqueID"]) {
//
//                    [[[DeleteDataObject alloc] init] DeleteDataCoreData:itemUniqueID collection:collection completionHandler:^(BOOL finished) {
                        
//                    }];
//                    
//                }
//                
//            }
//            
//        }];
        
//    }
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"HaveNotSavedCoreData"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"AppThemeSelected"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"LaunchPageSelected"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"AutoDarkModeSelected"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"AppIconSelected"] ||
            [[NSUserDefaults standardUserDefaults] objectForKey:@"AppIconSelectedReadableName"]) {
            
            [[UIApplication sharedApplication] setAlternateIconName:@"AppIcon-0" completionHandler:^(NSError * _Nullable error) {
                
                if (error == nil) {
                    
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"AppIconSelected"];
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"AppIconSelectedReadableName"];
                    
                }
                
            }];
            
        }
        
    });
    
}

#pragma mark - Generate Methods

-(NSString *)GenerateSubTaskShareString:(NSMutableDictionary *)singleObjectItemDict itemType:(NSString *)itemType homeMembersDict:(NSMutableDictionary *)homeMembersDict {
    
    NSMutableDictionary *itemSubTasks = singleObjectItemDict[@"ItemSubTasks"] ? singleObjectItemDict[@"ItemSubTasks"] : [NSMutableDictionary dictionary];
    
    if ([itemType containsString:@"Chore"] == NO) {
        return @"";
    }
    
    NSString *shareString = @"";
    
    
    
    for (NSString *itemSubTask in [itemSubTasks allKeys]) {
        
        NSString *subtaskTaskAssignedToUsername = @"";
        NSString *subtaskTaskAssignedTo =
        itemSubTasks[itemSubTask] &&
        itemSubTasks[itemSubTask][@"Assigned To"] &&
        [(NSArray *)itemSubTasks[itemSubTask][@"Assigned To"] count] > 0
        ? itemSubTasks[itemSubTask][@"Assigned To"][0] : @"";
        
        if ([subtaskTaskAssignedTo isEqualToString:@"Anybody"] == NO && [homeMembersDict[@"UserID"] containsObject:subtaskTaskAssignedTo]) {
            NSUInteger index = [homeMembersDict[@"UserID"] indexOfObject:subtaskTaskAssignedTo];
            subtaskTaskAssignedToUsername = homeMembersDict[@"Username"] && [(NSArray *)homeMembersDict[@"Username"] count] > index ? homeMembersDict[@"Username"][index] : @"";
        }
        
        NSString *subTaskAssignedToString = @"";
        
        if ([subtaskTaskAssignedToUsername length] > 0) {
            subTaskAssignedToString = [NSString stringWithFormat:@"; Assigned To: %@", subtaskTaskAssignedToUsername];
        }
        
        shareString = [NSString stringWithFormat:@"%@\n   ❏ %@%@", shareString, itemSubTask, subTaskAssignedToString];
    }
    
    
    
    if ([shareString length] > 0) {
        shareString = [NSString stringWithFormat:@"%@\n", shareString];
    }
    
    
    
    return shareString;
}

-(NSString *)GenerateCostPerPersonShareString:(NSMutableDictionary *)singleObjectItemDict itemType:(NSString *)itemType homeMembersDict:(NSMutableDictionary *)homeMembersDict {
    
    NSString *itemItemized = singleObjectItemDict[@"ItemItemized"] ? singleObjectItemDict[@"ItemItemized"] : @"";
    NSMutableDictionary *itemCostPerPerson = singleObjectItemDict[@"ItemCostPerPerson"] ? singleObjectItemDict[@"ItemCostPerPerson"] : [NSMutableDictionary dictionary];
    
    if ([itemType containsString:@"Expense"] == NO || [itemItemized isEqualToString:@"Yes"]) {
        return @"";
    }
    
    NSString *shareString = @"";
    
    
    
    for (NSString *userID in [itemCostPerPerson allKeys]) {
        
        NSString *costPerPersonAmount = itemCostPerPerson[userID];
        
        NSString *costPerPersonAssignedToUsername = @"";
        NSString *costPerPersonAssignedTo = userID;
        
        if ([costPerPersonAssignedTo isEqualToString:@"Anybody"] == NO && [homeMembersDict[@"UserID"] containsObject:costPerPersonAssignedTo]) {
            NSUInteger index = [homeMembersDict[@"UserID"] indexOfObject:costPerPersonAssignedTo];
            costPerPersonAssignedToUsername = homeMembersDict[@"Username"] && [(NSArray *)homeMembersDict[@"Username"] count] > index ? homeMembersDict[@"Username"][index] : @"";
        }
        
        shareString = [NSString stringWithFormat:@"%@\n   ❏ %@; Amount: %@", shareString, costPerPersonAssignedToUsername, costPerPersonAmount];
    }
    
    
    
    if ([shareString length] > 0) {
        shareString = [NSString stringWithFormat:@"%@\n", shareString];
    }
    
    
    
    return shareString;
}

-(NSString *)GenerateItemizedItemsShareString:(NSMutableDictionary *)singleObjectItemDict itemType:(NSString *)itemType homeMembersDict:(NSMutableDictionary *)homeMembersDict {
    
    NSString *itemItemized = singleObjectItemDict[@"ItemItemized"] ? singleObjectItemDict[@"ItemItemized"] : @"";
    NSMutableDictionary *itemItemizedItems = singleObjectItemDict[@"ItemItemizedItems"] ? singleObjectItemDict[@"ItemItemizedItems"] : [NSMutableDictionary dictionary];
    
    if ([itemType containsString:@"Expense"] == NO || [itemItemized isEqualToString:@"No"]) {
        return @"";
    }
    
    NSString *shareString = @"";
    
    
    
    for (NSString *itemItemizedItem in [itemItemizedItems allKeys]) {
        
        NSString *itemizedItemAmount = itemItemizedItems[itemItemizedItem][@"Amount"];
        
        NSString *itemizedItemAssignedToUsername = @"";
        NSString *itemizedItemAssignedTo =
        itemItemizedItems[itemItemizedItem] &&
        itemItemizedItems[itemItemizedItem][@"Assigned To"] &&
        [(NSArray *)itemItemizedItems[itemItemizedItem][@"Assigned To"] count] > 0
        ? itemItemizedItems[itemItemizedItem][@"Assigned To"][0] : @"";
        
        if ([itemizedItemAssignedTo isEqualToString:@"Anybody"] == NO && [homeMembersDict[@"UserID"] containsObject:itemizedItemAssignedTo]) {
            NSUInteger index = [homeMembersDict[@"UserID"] indexOfObject:itemizedItemAssignedTo];
            itemizedItemAssignedToUsername = homeMembersDict[@"Username"] && [(NSArray *)homeMembersDict[@"Username"] count] > index ? homeMembersDict[@"Username"][index] : @"";
        }
        
        shareString = [NSString stringWithFormat:@"%@\n   ❏ %@; Amount: %@", shareString, itemItemizedItem, itemizedItemAmount];
    }
    
    
    
    if ([shareString length] > 0) {
        shareString = [NSString stringWithFormat:@"%@\n", shareString];
    }
    
    
    
    return shareString;
}

-(NSString *)GenerateListItemsShareString:(NSMutableDictionary *)singleObjectItemDict itemType:(NSString *)itemType homeMembersDict:(NSMutableDictionary *)homeMembersDict {
    
    NSMutableDictionary *itemListItems = singleObjectItemDict[@"ItemListItems"] ? singleObjectItemDict[@"ItemListItems"] : [NSMutableDictionary dictionary];
    
    NSString *shareString = @"";
    
    
    
    for (NSString *itemListItem in [itemListItems allKeys]) {
        
        NSString *listItemAssignedToUsername = @"";
        NSString *listItemAssignedTo =
        itemListItems[itemListItem] &&
        itemListItems[itemListItem][@"Assigned To"] &&
        [(NSArray *)itemListItems[itemListItem][@"Assigned To"] count] > 0
        ? itemListItems[itemListItem][@"Assigned To"][0] : @"";
        
        if ([listItemAssignedTo isEqualToString:@"Anybody"] == NO && [homeMembersDict[@"UserID"] containsObject:listItemAssignedTo]) {
            NSUInteger index = [homeMembersDict[@"UserID"] indexOfObject:listItemAssignedTo];
            listItemAssignedToUsername = homeMembersDict[@"Username"] && [(NSArray *)homeMembersDict[@"Username"] count] > index ? homeMembersDict[@"Username"][index] : @"";
        }
        
        NSString *subTaskAssignedToString = @"";
        
        if ([listItemAssignedToUsername length] > 0) {
            subTaskAssignedToString = [NSString stringWithFormat:@"; Assigned To: %@", listItemAssignedToUsername];
        }
        
        shareString = [NSString stringWithFormat:@"%@\n   ❏ %@%@", shareString, itemListItem, subTaskAssignedToString];
    }
    
    
    
    if ([shareString length] > 0) {
        shareString = [NSString stringWithFormat:@"%@\n", shareString];
    }
    
    
    
    return shareString;
}

-(NSString *)GenerateItemDueDateShareString:(NSMutableDictionary *)singleObjectItemDict itemType:(NSString *)itemType {
    
    NSString *itemTime = singleObjectItemDict[@"ItemTime"];
    NSString *itemDueDate = singleObjectItemDict[@"ItemDueDate"];
    
    NSString *shareString = @"";
    
    
    
    if ([itemTime containsString:@"Any Time"]) {
        
        itemDueDate = [[[GeneralObject alloc] init] GenerateStringWithReplacementString:itemDueDate stringToReplace:@" 11:59 PM" replacementString:@", Any Time"];
        
    }
    
    if ([itemDueDate containsString:@"No Due Date"]) {
        
        shareString = [NSString stringWithFormat:@"%@", itemDueDate];
        
    } else {
        
        shareString = [NSString stringWithFormat:@"Due: %@", itemDueDate];
        
    }
    
    
    
    return shareString;
}

-(NSString *)GenerateItemNotesShareString:(NSMutableDictionary *)singleObjectItemDict {
    
    NSString *itemNotes = singleObjectItemDict[@"ItemNotes"];
    
    NSString *shareString = @"";
    
    shareString = [itemNotes length] > 0 ? [NSString stringWithFormat:@"\n   - Notes: %@", itemNotes] : @"";
    
    return shareString;
}

#pragma mark - Generate Date Methods

-(NSString *)GenerateDisplayTimeFromSeconds:(int)secs shortStyle:(BOOL)shortStyle reallyShortStyle:(BOOL)reallyShortStyle {
    
    NSString *sStr = @"s";
    
    if (secs < 1) {
        return @"Past due";
    }
    if (secs < 3600) {
        if ((secs+30)/60 == 1) {
            sStr = @"";
        }
        if (shortStyle) {
            return [NSString stringWithFormat:@"%d min left", (secs+30)/60];
        } else if (reallyShortStyle) {
            return [NSString stringWithFormat:@"%dm", (secs+30)/60];
        }
        return [NSString stringWithFormat:@"%d min left", (secs+30)/60];
    }
    if (secs < 86400 - 3600) {
        if ((secs+1800)/3600 == 1) {
            sStr = @"";
        }
        if (shortStyle) {
            return [NSString stringWithFormat:@"%d hr%@ left", (secs+1800)/3600, sStr];
        } else if (reallyShortStyle) {
            return [NSString stringWithFormat:@"%dh", (secs+1800)/3600];
        }
        return [NSString stringWithFormat:@"%d hour%@ left", (secs+1800)/3600, sStr];
    }
    if (secs < 2592000) {
        if ((secs+43200)/86400 == 1) {
            sStr = @"";
        }
        if (shortStyle) {
            return [NSString stringWithFormat:@"%d day%@ left", (secs+43200)/86400, sStr];
        } else if (reallyShortStyle) {
            return [NSString stringWithFormat:@"%dd", (secs+43200)/86400];
        }
        return [NSString stringWithFormat:@"%d day%@ left", (secs+43200)/(86400), sStr];
    }
    if (secs < 31536000) {
        if ((secs+1296000)/2592000 == 1) {
            sStr = @"";
        }
        if (shortStyle) {
            return [NSString stringWithFormat:@"%d mon%@ left", (secs+1296000)/2592000, sStr];
        } else if (reallyShortStyle) {
            return [NSString stringWithFormat:@"%dmo", (secs+1296000)/2592000];
        }
        return [NSString stringWithFormat:@"%d month%@ left", (secs+1296000)/2592000, sStr];
    }
    
    if ((secs+15768000)/31536000 == 1) {
        sStr = @"";
    }
    if (shortStyle) {
        return [NSString stringWithFormat:@"%d yr %@left", (secs+15768000)/31536000, sStr];
    } else if (reallyShortStyle) {
        return [NSString stringWithFormat:@"%dy", (secs+15768000)/31536000];
    }
    return [NSString stringWithFormat:@"%d year%@ left", (secs+15768000)/31536000, sStr];
    
}

#pragma mark - Generate Users Turn

-(NSString *)GenerateCurrentUsersTurnCompleteAsNeeded:(NSString *)itemRepeats itemRepeatIfCompletedEarly:(NSString *)itemRepeatIfCompletedEarly itemTakeTurns:(NSString *)itemTakeTurns itemCompleteAsNeeded:(NSString *)itemCompleteAsNeeded itemCompletedDict:(NSMutableDictionary *)itemCompletedDict itemAssignedToArray:(NSMutableArray *)itemAssignedToArray itemType:(NSString *)itemType homeMembersDict:(NSMutableDictionary *)homeMembersDict {
    
    NSMutableArray *arrayOfDateMarked = [NSMutableArray array];
    
    for (NSString *userIDKey in [itemCompletedDict allKeys]) {
        
        if (itemCompletedDict[userIDKey] && itemCompletedDict[userIDKey][@"Date Marked"]) {
            
            [arrayOfDateMarked addObject:itemCompletedDict[userIDKey][@"Date Marked"]];
            
        }
        
    }
    
    arrayOfDateMarked = [[[GeneralObject alloc] init] SortArrayOfDates:arrayOfDateMarked dateFormatString:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *userIDWhosTurnItIs = @"";
    
    if ([arrayOfDateMarked count] > 0 && itemAssignedToArray.count > 1) {
        
        NSDictionary *lastCompletedDictItem = [[[GeneralObject alloc] init] GeneralLastUserIDCompletedTaskRepeatingWhenCompleted:itemCompletedDict specificUserID:@""];
        NSString *lastUserIDCompleted = lastCompletedDictItem[@"LastUserIDCompleted"] ? lastCompletedDictItem[@"LastUserIDCompleted"] : @"";
        
        for (NSString *userID in itemAssignedToArray) {
            
            if ([lastUserIDCompleted isEqualToString:userID]) {
                
                if ([itemAssignedToArray containsObject:userID]) {
                    
                    NSUInteger index = [itemAssignedToArray indexOfObject:userID];
                    NSUInteger indexOfNextUsersTurn = index + 1;
                    
                    if (indexOfNextUsersTurn > itemAssignedToArray.count - 1) {
                        indexOfNextUsersTurn = 0;
                    }
                    
                    userIDWhosTurnItIs = itemAssignedToArray[indexOfNextUsersTurn];
                    break;
                    
                }
                
            }
            
        }
        
    } else if (itemAssignedToArray.count < 2 || [arrayOfDateMarked count] < 1) {
        
        userIDWhosTurnItIs = itemAssignedToArray.count > 0 ? itemAssignedToArray[0] : @"";
        
    }
    
    return userIDWhosTurnItIs;
    
}

-(NSString *)GenerateDueDateWithTimeRemoved:(NSString *)itemDueDate {
    
    NSString *dueDateToAlter = [itemDueDate mutableCopy];
    NSArray *dueDateArray = [dueDateToAlter containsString:@" "] ? [dueDateToAlter componentsSeparatedByString:@" "]: @[];
    
    NSString *month = [dueDateArray count] > 0 ? dueDateArray[0] : @"";
    NSString *day = [dueDateArray count] > 1 ? dueDateArray[1] : @"";
    NSString *year = [dueDateArray count] > 2 ? dueDateArray[2] : @"";
    
    NSString *dueDateWithremovedTime = [NSString stringWithFormat:@"%@ %@ %@", month, day, year];
    
    return dueDateWithremovedTime;
    
}

-(NSString *)GenerateDueDateWithLeadingZeroRemoved:(NSString *)itemDueDate {
    
    NSString *dueDateToAlter = [itemDueDate mutableCopy];
    NSArray *dueDateArray = [dueDateToAlter containsString:@" "] ? [dueDateToAlter componentsSeparatedByString:@" "]: @[];
    
    NSString *month = [dueDateArray count] > 0 ? dueDateArray[0] : @"";
    NSString *dayNumber = [dueDateArray count] > 1 ? dueDateArray[1] : @"";
    NSString *year = [dueDateArray count] > 2 ? dueDateArray[2] : @"";
    
    BOOL commaFound = false;
    
    if ([dayNumber containsString:@","]) {
        dayNumber = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:dayNumber arrayOfSymbols:@[@","]];
        commaFound = true;
    }
    
    BOOL LeadingZeroFoundInSingleDigitNumber = ([dayNumber intValue] < 10 && [dayNumber intValue] > 0 && [dayNumber containsString:@"0"]);
    
    if (LeadingZeroFoundInSingleDigitNumber == YES) {
        dayNumber = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:dayNumber arrayOfSymbols:@[@"0"]];
    }
    
    NSString *comma = commaFound == YES ? @"," : @"";
    
    NSString *separatedDate = [NSString stringWithFormat:@"%@ %@%@ %@", month, dayNumber, comma, year];
    
    return separatedDate;
    
}

-(NSMutableArray *)GenerateArrayOfDueDatesWithTimeRemoved:(NSMutableArray *)allDueDatesArray {
    
    NSMutableArray *allDueDatesWithTimeRemoved = [NSMutableArray array];
    
    for (NSString *dueDate in allDueDatesArray) {
        
        if ([dueDate containsString:@" "]) {
            
            NSArray *dateArray = [dueDate componentsSeparatedByString:@" "];
            NSString *date1 = [dateArray count] > 0 ? dateArray[0] : @"";
            NSString *date2 = [dateArray count] > 1 ? dateArray[1] : @"";
            NSString *date3 = [dateArray count] > 2 ? dateArray[2] : @"";
            NSString *removedTime = [NSString stringWithFormat:@"%@ %@ %@", date1, date2, date3];
            
            [allDueDatesWithTimeRemoved addObject:removedTime];
            
        }
        
    }
    
    return allDueDatesWithTimeRemoved;
    
}

-(NSMutableArray *)GenerateArrayOfDueDatesWithLeadingZeroRemoved:(NSMutableArray *)allDueDatesArray {
    
    NSMutableArray *allDueDatesWithTimeRemoved = [NSMutableArray array];
    
    for (NSString *dueDate in allDueDatesArray) {
        
        NSArray *dateArray = [dueDate containsString:@" "] ? [dueDate componentsSeparatedByString:@" "] : @[];
        NSString *month = [dateArray count] > 0 ? dateArray[0] : @"";
        NSString *dayNumber = [dateArray count] > 1 ? dateArray[1] : @"0";
        NSString *year = [dateArray count] > 2 ? dateArray[2] : @"";
        BOOL commaFound = false;
        
        if ([dayNumber containsString:@","]) {
            dayNumber = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:dayNumber arrayOfSymbols:@[@","]];
            commaFound = true;
        }
        
        BOOL LeadingZeroFoundInSingleDigitNumber = ([dayNumber intValue] < 10 && [dayNumber intValue] > 0 && [dayNumber containsString:@"0"]);
        
        if (LeadingZeroFoundInSingleDigitNumber == YES) {
            dayNumber = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:dayNumber arrayOfSymbols:@[@"0"]];
        }
        
        NSString *comma = commaFound == YES ? @"," : @"";
        
        NSString *separatedDate = [NSString stringWithFormat:@"%@ %@%@ %@", month, dayNumber, comma, year];
        
        [allDueDatesWithTimeRemoved addObject:separatedDate];
        
    }
    
    return allDueDatesWithTimeRemoved;
    
}

-(NSMutableArray *)GenerateArrayOfRepeatingDayIntervalDueDates:(NSMutableArray *)allDueDatesArray itemRepeats:(NSString *)itemRepeats {
    
    NSArray *frequencyArray = [itemRepeats componentsSeparatedByString:@" "];
    NSString *intervalString = @"";
    
    BOOL TaskIsRepeatingInterval = [[[BoolDataObject alloc] init] TaskIsRepeatingInterval:[@{@"ItemRepeats" : itemRepeats} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType]];
    
    if (TaskIsRepeatingInterval == YES) {
        intervalString = [frequencyArray count] > 1 ? frequencyArray[1] : @"";
    } else {
        return allDueDatesArray;
    }
    
    intervalString = [[[NotificationsObject alloc] init] RemoveIntervalCharacters:intervalString];
    
    int intervalNum = [intervalString intValue];
    
    NSMutableArray *allCorrectlyFormatedDueDatesArray = [NSMutableArray array];
    
    for (int i=0;i<allDueDatesArray.count;i+=intervalNum) {
        
        [allCorrectlyFormatedDueDatesArray addObject:allDueDatesArray[i]];
        
    }
    
    return allCorrectlyFormatedDueDatesArray;
    
}

-(NSMutableArray *)GenerateArrayOfRepeatingWeekOrMonthIntervalDueDates:(NSMutableArray *)allDueDatesArray itemRepeats:(NSString *)itemRepeats {
    
    NSArray *frequencyArray = [itemRepeats componentsSeparatedByString:@" "];
    NSString *intervalString = @"";
    
    BOOL TaskIsRepeatingInterval = [[[BoolDataObject alloc] init] TaskIsRepeatingInterval:[@{@"ItemRepeats" : itemRepeats} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType]];
    BOOL TaskIsRepeatingWeekly = [[[BoolDataObject alloc] init] TaskIsRepeatingWeekly:[@{@"ItemRepeats" : itemRepeats} mutableCopy] itemType:[[[GeneralObject alloc] init] GenerateItemType]];
    
    if (TaskIsRepeatingInterval == YES) {
        intervalString = [frequencyArray count] > 1 ? frequencyArray[1] : @"";
    } else {
        return allDueDatesArray;
    }
    
    intervalString = [[[NotificationsObject alloc] init] RemoveIntervalCharacters:intervalString];
    
    NSMutableArray *allUncorrectlyFormatedDueDatesArray = [NSMutableArray array];
    
    for (NSString *dueDate in allDueDatesArray) {
        
        NSString *dateFormat = @"MMMM dd, yyyy hh:mm a";
        NSDate *currentDate = [[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:dueDate returnAs:[NSDate class]];
        NSDateComponents *componentsForTodayDate = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth|NSCalendarUnitWeekOfYear|NSCalendarUnitDay|NSCalendarUnitWeekOfYear|NSCalendarUnitWeekday|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:currentDate];
        
        NSInteger compToUse = TaskIsRepeatingWeekly ? componentsForTodayDate.weekOfYear : componentsForTodayDate.month;
        [allUncorrectlyFormatedDueDatesArray addObject:[NSString stringWithFormat:@"%@ -- %ld.", dueDate, compToUse]];
        
    }
    
    NSString *startingCompNum = @"";
    
    if ([allUncorrectlyFormatedDueDatesArray count] > 0) {
        
        NSString *dueDate = allUncorrectlyFormatedDueDatesArray[0];
        
        if ([dueDate containsString:@" -- "]) {
            
            NSArray *arr = [dueDate componentsSeparatedByString:@" -- "];
            
            if ([arr count] > 1) {
                
                startingCompNum = arr[1];
                
            }
            
        }
        
    }
    
    startingCompNum = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:startingCompNum arrayOfSymbols:@[@"."]];
  
    NSMutableArray *correctIntervalArray = [NSMutableArray array];
    int totalCompNum = TaskIsRepeatingWeekly ? 52 : 12;
    BOOL passedEndOfYear = false;
    int intervalNum = [intervalString intValue];
    
    for (int i=[startingCompNum intValue];i<=totalCompNum;i+=intervalNum) {
        
        if ([correctIntervalArray containsObject:[NSString stringWithFormat:@"%d.", i]] == NO) {
            [correctIntervalArray addObject:[NSString stringWithFormat:@"%d.", i]];
        }
        
        if (i+intervalNum > totalCompNum && passedEndOfYear == false) {
            
            i = (i+intervalNum)%totalCompNum;
            i -= intervalNum;
            passedEndOfYear = true;
            
        }
        
    }
    
    NSMutableArray *allCorrectDueDatesArray = [NSMutableArray array];
    
    for (NSString *interval in correctIntervalArray) {
        BOOL intervalFound = false;
        for (NSString *dueDate in allUncorrectlyFormatedDueDatesArray) {
            if ([dueDate containsString:[NSString stringWithFormat:@" -- %@", interval]]) {
                [allCorrectDueDatesArray addObject:dueDate];
                intervalFound = true;
            } else if ([dueDate containsString:[NSString stringWithFormat:@" -- %@", interval]] == NO && intervalFound == true) {
                break;
            }
        }
    }
    
    NSMutableArray *allCorrectlyFormatedDueDatesArray = [NSMutableArray array];
    
    for (NSString *dueDate in allCorrectDueDatesArray) {
        NSString *dueDateOnly = [dueDate containsString:@" -- "] && [[dueDate componentsSeparatedByString:@" -- "] count] > 0 ? [dueDate componentsSeparatedByString:@" -- "][0] : @"";
        dueDateOnly = [[[GeneralObject alloc] init] GenerateStringWithRemovedSymbols:dueDateOnly arrayOfSymbols:@[@"."]];
        [allCorrectlyFormatedDueDatesArray addObject:dueDateOnly];
    }
    
    return allCorrectlyFormatedDueDatesArray;
    
}

-(NSMutableArray *)GenerateDueDateArrayWithoutSkippedDueDates:(NSMutableArray *)allDueDatesArray itemDueDatesSkipped:(NSMutableArray *)itemDueDatesSkipped {
    
    for (NSString *itemDueDate in itemDueDatesSkipped) {
        
        if ([allDueDatesArray containsObject:itemDueDate]) {
            
            [allDueDatesArray removeObject:itemDueDate];
            
        }
        
    }
    
    return allDueDatesArray;
}

-(NSMutableArray *)GenerateIndexOfEachUserForEachDueDateArray:(int)totalAmountOfFutureDates totalAssignedToUsers:(int)totalAssignedToUsers itemAssignedToArray:(NSMutableArray *)itemAssignedToArray {
    
    NSMutableArray *indexOfEachUserInDueDateArray = [NSMutableArray array];
    
    for (int i=0;i<totalAmountOfFutureDates;i++) {
        
        [indexOfEachUserInDueDateArray addObject:@""];
        
    }
    
    NSMutableArray *itemAssignedToArrayCopy = [itemAssignedToArray mutableCopy];
    
    if ([itemAssignedToArrayCopy containsObject:@""]) {
        [itemAssignedToArrayCopy removeObject:@""];
    }
    
    for (int k=0;k<itemAssignedToArrayCopy.count;k++) {
        
        for (int i=k;i<totalAmountOfFutureDates;i+=totalAssignedToUsers) {
            
            if ([indexOfEachUserInDueDateArray count] > i && itemAssignedToArrayCopy[k]) {
                
                [indexOfEachUserInDueDateArray replaceObjectAtIndex:i withObject:itemAssignedToArrayCopy[k]];
                
            }
            
        }
        
    }
    
    return indexOfEachUserInDueDateArray;
    
}

#pragma mark - IAP Methods

-(NSDictionary *)GeneratePremiumPlanPricesDict {
    
    NSDictionary *premiumPlanPricesDict = @{
        @"Individual Plan" : @[@"$x.99", @"$x.99", @"$x.99"],
        @"Housemate Plan" : @[@"$x.99", @"$x.99", @"$x.99"],
        @"Family Plan" : @[@"$x.99", @"$x.99", @"$x.99 "]
    };
    
    return premiumPlanPricesDict;
}

-(NSDictionary *)GeneratePremiumPlanExpensivePricesDict {
    
    NSDictionary *premiumPlanExpensivePricesDict = @{
        @"Individual Plan" : @[@"", @"", @"$x.99"],
        @"Housemate Plan" : @[@"", @"", @"$x.99"],
        @"Family Plan" : @[@"", @"", @"$x.99"]
    };
    
    return premiumPlanExpensivePricesDict;
}

-(NSDictionary *)GeneratePremiumPlanPricesDiscountDict {
    
    NSDictionary *premiumPlanPricesDiscountDict = @{
        @"Individual Plan" : @[@"$x.99", @"$x.99", @"$x.99"],
        @"Housemate Plan" : @[@"$x.99", @"$x.99", @"$x.99"],
        @"Family Plan" : @[@"$x.99", @"$x.99", @"$x.99"]
    };
    
    return premiumPlanPricesDiscountDict;
}

-(NSDictionary *)GeneratePremiumPlanPricesNoFreeTrialDict {
    
    NSDictionary *premiumPlanPricesNoFreeTrialDict = @{
        @"Individual Plan" : @[@"$x.99", @"$x.99", @"$x.99"],
        @"Housemate Plan" : @[@"$x.99", @"$x.99", @"$x.99"],
        @"Family Plan" : @[@"$x.99", @"$x.99", @"$x.99"]
    };
    
    return premiumPlanPricesNoFreeTrialDict;
}

-(NSString *)GenerateProductPriceInLocalCurrencyFormat:(SKProduct *)product {
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [numberFormatter setLocale:product.priceLocale];
    
    NSString *localCurrency = [numberFormatter stringFromNumber:product.price];
    
    return localCurrency;
}

-(NSString *)GenerateProductPlanFrequency:(SKProduct *)product {
    
    NSString *planToCheck = @"";
    
    if ([product.productIdentifier containsString:@"Individual"]) {
        planToCheck = @"Individual";
    } else if ([product.productIdentifier containsString:@"Housemate"]) {
        planToCheck = @"Housemate";
    } else if ([product.productIdentifier containsString:@"Family"]) {
        planToCheck = @"Family";
    }
    
    return planToCheck;
}

-(NSMutableDictionary *)GeneratePremiumPlanWithUpdatedPrices:(NSMutableDictionary *)premiumPlanPricesDict product:(SKProduct *)product {
    
    NSString *productPrice = [[[GeneralObject alloc] init] GenerateProductPriceInLocalCurrencyFormat:product];
    NSString *productPlanFrequency = [[[GeneralObject alloc] init] GenerateProductPlanFrequency:product];
    
    
    
    NSInteger index = 0;
    
    //Individual Plan
    NSString *specificPlanFrequency = [NSString stringWithFormat:@"%@ Plan", productPlanFrequency];
    
    //@[@"0.99", @"1.99", @"2.99"]
    NSMutableArray *arrayOfPricesForSpecificPlanFrequency = [premiumPlanPricesDict[specificPlanFrequency] mutableCopy];
    
 
    
    if ([product.productIdentifier containsString:[NSString stringWithFormat:@"%@Monthly", productPlanFrequency]] ||
        [product.productIdentifier containsString:[NSString stringWithFormat:@"%@NoFreeTrialMonthly", productPlanFrequency]]) {
        
        index = 0;
        
    } else if ([product.productIdentifier containsString:[NSString stringWithFormat:@"%@ThreeMonthly", productPlanFrequency]] ||
               [product.productIdentifier containsString:[NSString stringWithFormat:@"%@NoFreeTrialThreeMonthly", productPlanFrequency]]) {
        
        index = 1;
        
    } else if ([product.productIdentifier containsString:[NSString stringWithFormat:@"%@Yearly", productPlanFrequency]] ||
               [product.productIdentifier containsString:[NSString stringWithFormat:@"%@NoFreeTrialYearly", productPlanFrequency]]) {
        
        index = 2;
        
    }
    
    
    
    [arrayOfPricesForSpecificPlanFrequency replaceObjectAtIndex:index withObject:[NSString stringWithFormat:@"%@", productPrice]];
    [premiumPlanPricesDict setObject:arrayOfPricesForSpecificPlanFrequency forKey:specificPlanFrequency];
    
    return premiumPlanPricesDict;
}

@end
