//
//  ChatObject.m
//  WeDivvy
//
//  Created by Philip Nagel on 9/20/21.
//

#import "AppDelegate.h"
#import "ChatObject.h"

#import "GeneralObject.h"
#import "GetDataObject.h"
#import "SetDataObject.h"
#import "NotificationsObject.h"

@implementation ChatObject

-(void)QueryDataChatsViewController:(NSString *)homeID keyArray:(NSArray *)keyArray messageKeyArray:(NSArray *)messageKeyArray completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningHomeMembersDict, NSMutableDictionary *returningHomeKeysDict, NSMutableDictionary *returningHomeMembersUnclaimedDictLocal, NSMutableDictionary *returningItemDict, NSMutableDictionary *returningLastMessageDict, NSString *returningUnreadNotificationsCount, NSMutableDictionary *returningNotificationSettingsDict, NSMutableDictionary *returningTopicDict))finishBlock {
    
    __block NSMutableDictionary *homeMembersDict = [NSMutableDictionary dictionary];
    __block NSMutableDictionary *homeKeysDict = [NSMutableDictionary dictionary];
    __block NSMutableDictionary *homeMembersUnclaimedDict = [NSMutableDictionary dictionary];
    
    __block NSMutableDictionary *chatsDataDict = [NSMutableDictionary dictionary];
    __block NSMutableDictionary *lastMessageDict = [NSMutableDictionary dictionary];
    __block NSString *unreadNotificationsCountLocal = @"0";
    
    __block NSMutableDictionary *notificationSettingsDict = [NSMutableDictionary dictionary];
    __block NSMutableDictionary *topicDict = [NSMutableDictionary dictionary];
    
    __block int totalQueries = 3;
    __block int completedQueries = 0;
   
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
        [[[GetDataObject alloc] init] GetDataChatsInSpecificHome:homeID keyArray:keyArray completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningDataDict) {
           
            chatsDataDict = returningDataDict ? [returningDataDict mutableCopy] : [NSMutableDictionary dictionary];
            
            [self QueryDataChatsViewController_GenerateLastMessageDict:chatsDataDict messageKeyArray:messageKeyArray homeID:homeID completionHandler:^(BOOL finished, NSMutableDictionary *returningChatDict, NSMutableDictionary *returningLastMessageDict) {
                
                chatsDataDict = [returningChatDict mutableCopy];
         
                lastMessageDict = [returningLastMessageDict mutableCopy];
                
                completedQueries += 1;
               
                if (totalQueries == completedQueries) {
                    
                    finishBlock(YES, homeMembersDict, homeKeysDict, homeMembersUnclaimedDict, chatsDataDict, lastMessageDict, unreadNotificationsCountLocal, notificationSettingsDict, topicDict);
                    
                }
                
            }];
            
        }];
        
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
        NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
        NSArray *keyArray = [[[GeneralObject alloc] init] GenerateKeyArrayManually:NO Expense:NO List:NO Home:YES];
        
        [[[GetDataObject alloc] init] GetDataSpecificHomeData:homeID keyArray:keyArray completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningHomeToJoinDict, NSMutableArray * _Nonnull queriedHomeMemberArray, NSString * _Nonnull queriedHomeID) {
           
            NSMutableArray *homeMembersArray = returningHomeToJoinDict[@"HomeMembers"] ? [returningHomeToJoinDict[@"HomeMembers"] mutableCopy] : [NSMutableArray array];
            homeKeysDict = returningHomeToJoinDict[@"HomeKeys"] ? [returningHomeToJoinDict[@"HomeKeys"] mutableCopy] : [NSMutableDictionary dictionary];
            homeMembersUnclaimedDict = returningHomeToJoinDict[@"HomeMembersUnclaimed"] ? [returningHomeToJoinDict[@"HomeMembersUnclaimed"] mutableCopy] : [NSMutableDictionary dictionary];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                [[[GetDataObject alloc] init] GetDataUserDataArray:homeMembersArray completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningUserDict) {
                    
                    homeMembersDict = [returningUserDict mutableCopy];
                    
                    completedQueries += 1;
                   
                    if (totalQueries == completedQueries) {
                       
                        finishBlock(YES, homeMembersDict, homeKeysDict, homeMembersUnclaimedDict, chatsDataDict, lastMessageDict, unreadNotificationsCountLocal, notificationSettingsDict, topicDict);

                    }
                    
                }];
                
            });
      
        }];

    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
        NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
        
        [[[GetDataObject alloc] init] GetDataUnreadNotificationsCountNotCreatedBySpecificUser:homeID userID:userID completionHandler:^(BOOL finished, NSString * _Nonnull unreadNotificationCount) {
            
            unreadNotificationsCountLocal = unreadNotificationCount;
            
            [[NSUserDefaults standardUserDefaults] setObject:unreadNotificationsCountLocal forKey:@"NotificationViewCount"];
            
            completedQueries += 1;
           
            if (totalQueries == completedQueries) {
                
                finishBlock(YES, homeMembersDict, homeKeysDict, homeMembersUnclaimedDict, chatsDataDict, lastMessageDict, unreadNotificationsCountLocal, notificationSettingsDict, topicDict);

            }
            
        }];
        
    });
    
}

-(void)QueryDataLiveChatViewController:(NSString *)userID homeID:(NSString *)homeID itemType:(NSString *)itemType itemID:(NSString *)itemID itemName:(NSString *)itemName itemCreatedBy:(NSString *)itemCreatedBy itemAssignedTo:(NSMutableArray *)itemAssignedTo chatID:(NSString *)chatID chatName:(NSString *)chatName chatAssignedTo:(NSMutableArray *)chatAssignedTo chatKeyArray:(NSArray *)chatKeyArray messageKeyArray:(NSArray *)messageKeyArray messageDict:(NSMutableDictionary *)messageDict viewingGroupChat:(BOOL)viewingGroupChat viewingComments:(BOOL)viewingComments viewingLiveSupport:(BOOL)viewingLiveSupport completionHandler:(void (^)(BOOL finished, BOOL callSecondBlock, NSMutableDictionary *returningMessageDict, NSMutableDictionary *returningChatDict, NSMutableDictionary *returningUserDict))finishBlock {
    
    __block BOOL callSecondBlockLocal = NO;
    __block NSMutableDictionary *messageDictLocal = [messageDict mutableCopy];
    __block NSMutableDictionary *chatDictDictLocal = [NSMutableDictionary dictionary];
    __block NSMutableDictionary *userDictLocal = [NSMutableDictionary dictionary];
    
    __block int totalQueries = 2;
    __block int completedQueries = 0;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[GetDataObject alloc] init] GetDataMessagesInSpecificChat:userID homeID:homeID itemType:itemType itemID:itemID chatID:chatID keyArray:messageKeyArray messageDict:[messageDictLocal mutableCopy] viewingGroupChat:viewingGroupChat viewingComments:viewingComments viewingLiveSupport:viewingLiveSupport completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningMessageDict) {
            
            messageDictLocal = [returningMessageDict mutableCopy];
            
            if ([(NSArray *)messageDictLocal[@"MessageText"] count] > 0) {
                
                NSMutableArray *arrayToUse = [NSMutableArray array];
                
                if (viewingGroupChat == YES) {
                    arrayToUse = [chatAssignedTo mutableCopy];
                } else if (viewingComments == YES) {
                    arrayToUse = [itemAssignedTo mutableCopy];
                } else if (viewingLiveSupport == YES) {
                    arrayToUse = [@[userID] mutableCopy];
                }
                
                [[[GetDataObject alloc] init] GetDataUserDataArray:arrayToUse completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningUserDict) {
                    
                    callSecondBlockLocal = YES;
                    userDictLocal = [returningUserDict mutableCopy];
                    
                    completedQueries += 1;
                    
                    if (totalQueries <= completedQueries) {
                        
                        finishBlock(YES, callSecondBlockLocal, messageDictLocal, chatDictDictLocal, userDictLocal);
                        
                    }
                    
                }];
                
            } else {
                
                completedQueries += 1;
                
                if (totalQueries <= completedQueries) {
                    
                    finishBlock(YES, callSecondBlockLocal, messageDictLocal, chatDictDictLocal, userDictLocal);
                    
                }
                
            }
            
        }];
        
    });
    
    if (viewingLiveSupport == NO && chatID != NULL && chatID != nil && [chatID length] > 0) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [[[GetDataObject alloc] init] GetDataChat:chatID homeID:homeID keyArray:chatKeyArray completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningDataDict) {
                
                chatDictDictLocal = [returningDataDict mutableCopy];
                
                completedQueries += 1;
                
                if (totalQueries <= completedQueries) {
                    
                    finishBlock(YES, callSecondBlockLocal, messageDictLocal, chatDictDictLocal, userDictLocal);
                    
                }
                
            }];
            
        });
        
    } else {
        
        completedQueries += 1;
        
        if (totalQueries <= completedQueries) {
            
            finishBlock(YES, callSecondBlockLocal, messageDictLocal, chatDictDictLocal, userDictLocal);
            
        }
        
    }
    
}

-(void)SendChat:(NSString *)userID homeID:(NSString *)homeID itemType:(NSString *)itemType itemID:(NSString *)itemID itemName:(NSString *)itemName itemCreatedBy:(NSString *)itemCreatedBy itemAssignedTo:(NSMutableArray *)itemAssignedTo chatID:(NSString *)chatID chatName:(NSString *)chatName chatAssignedTo:(NSMutableArray *)chatAssignedTo homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType topicDict:(NSMutableDictionary *)topicDict viewingGroupChat:(BOOL)viewingGroupChat viewingComments:(BOOL)viewingComments viewingLiveSupport:(BOOL)viewingLiveSupport dataDict:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished))finishBlock {

    __block int totalQueries = 2;
    __block int completedQueries = 0;
    
    
    
    /*
     //
     //
     //Set Message Data
     //
     //
     */
    [self SendChat_SetMessageData:dataDict userID:userID homeID:homeID itemType:itemType itemID:itemID chatID:chatID viewingGroupChat:viewingGroupChat viewingComments:viewingComments viewingLiveSupport:viewingLiveSupport completionHandler:^(BOOL finished) {
        
        [self SendChat_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Send Push Notification
     //
     //
     */
    [self SendChat_SendPushNotification:userID homeID:homeID itemID:itemID itemName:itemName itemCreatedBy:itemCreatedBy itemAssignedTo:itemAssignedTo chatID:chatID chatName:chatName chatAssignedTo:chatAssignedTo homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType topicDict:topicDict viewingGroupChat:viewingGroupChat viewingComments:viewingComments viewingLiveSupport:viewingLiveSupport dataDict:dataDict completionHandler:^(BOOL finished) {
 
        [self SendChat_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    }];
    
}

-(void)EndChat:(NSString *)userID homeID:(NSString *)homeID itemType:(NSString *)itemType itemID:(NSString *)itemID chatID:(NSString *)chatID completionHandler:(void (^)(BOOL finished))finishBlock {
    
    __block int totalQueries = 2;
    __block int completedQueries = 0;
    
    
    
    /*
     //
     //
     //Set Message Data
     //
     //
     */
    [self EndChat_SetMessageData:userID homeID:homeID itemType:itemType itemID:itemID chatID:chatID completionHandler:^(BOOL finished) {
        
        [self SendChat_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Send Push Notification
     //
     //
     */
    [self EndChat_SendPushNotification:^(BOOL finished) {
        
        [self SendChat_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    }];
    
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Internal Methods
#pragma mark
#pragma mark
#pragma mark -

-(void)QueryDataChatsViewController_GenerateLastMessageDict:(NSMutableDictionary *)chatsDataDict messageKeyArray:(NSArray *)messageKeyArray homeID:(NSString *)homeID completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningChatDict, NSMutableDictionary *returningLastMessageDict))finishBlock {
    
    __block NSMutableDictionary *lastMessageDict = [NSMutableDictionary dictionary];
    NSMutableArray *objectArr = [NSMutableArray array];
    
    if ([(NSArray *)chatsDataDict[@"ChatID"] count] == 0) {
        finishBlock(YES, chatsDataDict, lastMessageDict);
    }
    
    for (NSString *chatID in chatsDataDict[@"ChatID"]) {
        
        [[[GetDataObject alloc] init] GetDataLastMessageInSpecificChat:@"" homeID:homeID itemType:@"GroupChat" itemID:@"" chatID:chatID keyArray:messageKeyArray viewingGroupChat:YES viewingComments:NO viewingLiveSupport:NO completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningMessageDict) {
            
            [lastMessageDict setObject:[returningMessageDict mutableCopy] forKey:chatID];
            
            if ([[[GeneralObject alloc] init] AddToObjectArrAndCheckIfQueryHasEnded:chatsDataDict[@"ChatID"] objectArr:objectArr]) {
                
                NSMutableDictionary *sortedItemsDict = [self ReorganizeChatsByMostRecentMessage:[chatsDataDict mutableCopy] lastMessageDict:[lastMessageDict mutableCopy] keyArray:messageKeyArray];
                
                finishBlock(YES, sortedItemsDict, lastMessageDict);
                
            }
            
        }];
        
    }
    
}

#pragma mark

-(void)SendChat_SetMessageData:(NSDictionary *)dataDict userID:(NSString *)userID homeID:(NSString *)homeID itemType:(NSString *)itemType itemID:(NSString *)itemID chatID:(NSString *)chatID viewingGroupChat:(BOOL)viewingGroupChat viewingComments:(BOOL)viewingComments viewingLiveSupport:(BOOL)viewingLiveSupport completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[SetDataObject alloc] init] SetDataAddMessage:dataDict userID:userID homeID:homeID itemType:itemType itemID:itemID chatID:chatID viewingGroupChat:viewingGroupChat viewingComments:viewingComments viewingLiveSupport:viewingLiveSupport completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)SendChat_SendPushNotification:(NSString *)userID homeID:(NSString *)homeID itemID:(NSString *)itemID itemName:(NSString *)itemName itemCreatedBy:(NSString *)itemCreatedBy itemAssignedTo:(NSMutableArray *)itemAssignedTo chatID:(NSString *)chatID chatName:(NSString *)chatName chatAssignedTo:(NSMutableArray *)chatAssignedTo homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType topicDict:(NSMutableDictionary *)topicDict viewingGroupChat:(BOOL)viewingGroupChat viewingComments:(BOOL)viewingComments viewingLiveSupport:(BOOL)viewingLiveSupport dataDict:(NSDictionary *)dataDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    if (viewingGroupChat == YES || viewingComments == YES) {
        
        NSString *notificationTitle = @"";
        NSString *notificationBody = @"";
        
        notificationTitle = [NSString stringWithFormat:@"%@", viewingComments ? itemName : chatName];
        
        if (viewingComments == YES) {
            notificationTitle = [NSString stringWithFormat:@"\"%@\"", viewingComments ? itemName : chatName];
        }
        
        notificationBody = [NSString stringWithFormat:@"%@: %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"], dataDict[@"MessageText"]];
        
        
        
        __block NSMutableArray *userIDArray = viewingComments ? [itemAssignedTo mutableCopy] : [chatAssignedTo mutableCopy];
        
        if (viewingComments) {
            [userIDArray addObject:itemCreatedBy];
        } else {
            userIDArray = [homeMembersDict[@"UserID"] mutableCopy];
        }
        
        
        
        NSString *notificationType = @"";
        
        
        
        if (viewingComments == YES) {
            
            notificationType = [[[NotificationsObject alloc] init] NotificationSettingsUnknownItemType_Adding:NO Editing:NO Deleting:NO Duplicating:NO Waiving:NO Skipping:NO Pausing:NO Comments:NO
                                                                                                 SkippingTurn:NO RemovingUser:NO
                                                                                               FullyCompleted:NO Completed:NO InProgress:NO WontDo:NO Accept:NO Decline:NO
                                                                                                      DueDate:NO Reminder:NO
                                                                                               SubtaskEditing:NO SubtaskDeleting:NO
                                                                                             SubtaskCompleted:NO SubtaskInProgress:NO SubtaskWontDo:NO SubtaskAccept:NO SubtaskDecline:NO
                                                                                               AddingListItem:NO EditingListItem:NO DeletingListItem:NO ResetingListItem:NO
                                                                                          EditingItemizedItem:NO DeletingItemizedItem:NO
                                                                                            GroupChatMessages:NO LiveSupportMessages:NO
                                                                                           SendingInvitations:NO DeletingInvitations:NO NewHomeMembers:NO HomeMembersMovedOut:NO HomeMembersKickedOut:NO
                                                                                          FeatureForumUpvotes:NO BugForumUpvotes:NO
                                                                                                     itemType:@"GroupChat"];
            
        } else if (viewingGroupChat == YES) {
            
            notificationType = [[[NotificationsObject alloc] init] NotificationSettingsUnknownItemType_Adding:NO Editing:NO Deleting:NO Duplicating:NO Waiving:NO Skipping:NO Pausing:NO Comments:NO
                                                                                                 SkippingTurn:NO RemovingUser:NO
                                                                                               FullyCompleted:NO Completed:NO InProgress:NO WontDo:NO Accept:NO Decline:NO
                                                                                                      DueDate:NO Reminder:NO
                                                                                               SubtaskEditing:NO SubtaskDeleting:NO
                                                                                             SubtaskCompleted:NO SubtaskInProgress:NO SubtaskWontDo:NO SubtaskAccept:NO SubtaskDecline:NO
                                                                                               AddingListItem:NO EditingListItem:NO DeletingListItem:NO ResetingListItem:NO
                                                                                          EditingItemizedItem:NO DeletingItemizedItem:NO
                                                                                            GroupChatMessages:YES LiveSupportMessages:NO
                                                                                           SendingInvitations:NO DeletingInvitations:NO NewHomeMembers:NO HomeMembersMovedOut:NO HomeMembersKickedOut:NO
                                                                                          FeatureForumUpvotes:NO BugForumUpvotes:NO
                                                                                                     itemType:@"GroupChat"];
            
        }
        
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [[[NotificationsObject alloc] init] SendPushNotificationToArrayOfUsers_Chats:[userIDArray mutableCopy] userID:userID 
                                                                                  homeID:homeID homeMembersDict:homeMembersDict
                                                                                  chatID:chatID chatName:chatName chatAssignedTo:chatAssignedTo
                                                                                  itemID:itemID itemName:itemName itemCreatedBy:itemCreatedBy itemAssignedTo:itemAssignedTo
                                                                notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType
                                                                               topicDict:topicDict
                                                                   pushNotificationTitle:notificationTitle pushNotificationBody:notificationBody
                                                                       notificationTitle:notificationTitle notificationBody:notificationBody
                                                                        viewingGroupChat:viewingGroupChat viewingComments:viewingComments viewingLiveSupport:viewingLiveSupport
                                                                 SetDataHomeNotification:YES RemoveUsersNotInHome:YES
                                                                       completionHandler:^(BOOL finished) {
                
                finishBlock(YES);
                
            }];
            
        });
        
        //Live Support
    } else {
        
        NSString *notificationTitle = @"WeDivvy Live Support";
        NSString *notificationBody = dataDict[@"MessageText"];
        
        
        
        NSString *userIDToUse = @"";
        
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] isEqualToString:@"2021-08-24 23:51:563280984"]) {
            
            userIDToUse = userID;
            notificationTitle = [NSString stringWithFormat:@"%@ - %@", notificationTitle, userID];
            
        } else {
            
            userIDToUse = @"2021-08-24 23:51:563280984";
            
        }
        
        
        
        NSString *notificationType = [[[NotificationsObject alloc] init] NotificationSettingsUnknownItemType_Adding:NO Editing:NO Deleting:NO Duplicating:NO Waiving:NO Skipping:NO Pausing:NO Comments:NO
                                                                                                       SkippingTurn:NO RemovingUser:NO
                                                                                                     FullyCompleted:NO Completed:NO InProgress:NO WontDo:NO Accept:NO Decline:NO
                                                                                                            DueDate:NO Reminder:NO
                                                                                                     SubtaskEditing:NO SubtaskDeleting:NO
                                                                                                   SubtaskCompleted:NO SubtaskInProgress:NO SubtaskWontDo:NO SubtaskAccept:NO SubtaskDecline:NO
                                                                                                     AddingListItem:NO EditingListItem:NO DeletingListItem:NO ResetingListItem:NO
                                                                                                EditingItemizedItem:NO DeletingItemizedItem:NO
                                                                                                  GroupChatMessages:NO LiveSupportMessages:YES
                                                                                                 SendingInvitations:NO DeletingInvitations:NO NewHomeMembers:NO HomeMembersMovedOut:NO HomeMembersKickedOut:NO
                                                                                                FeatureForumUpvotes:NO BugForumUpvotes:NO
                                                                                                           itemType:@"GroupChat"];
        
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [[[NotificationsObject alloc] init] SendPushNotificationToArrayOfUsers_Chats:[@[userIDToUse] mutableCopy] userID:userID
                                                                                  homeID:homeID homeMembersDict:homeMembersDict
                                                                                  chatID:chatID chatName:chatName chatAssignedTo:chatAssignedTo
                                                                                  itemID:itemID itemName:itemName itemCreatedBy:itemCreatedBy itemAssignedTo:itemAssignedTo
                                                                notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType
                                                                               topicDict:topicDict
                                                                   pushNotificationTitle:notificationTitle pushNotificationBody:notificationBody
                                                                       notificationTitle:notificationTitle notificationBody:notificationBody
                                                                        viewingGroupChat:viewingGroupChat viewingComments:viewingComments viewingLiveSupport:viewingLiveSupport
                                                                 SetDataHomeNotification:YES RemoveUsersNotInHome:NO
                                                                       completionHandler:^(BOOL finished) {
                
                finishBlock(YES);
                
            }];
            
        });
        
    }
    
}

-(void)SendChat_CompletionBlock:(int)totalQueries completedQueries:(int)completedQueries completionHandler:(void (^)(BOOL finished))finishBlock {
    
    if (totalQueries == completedQueries) {
        
        finishBlock(YES);
        
    }
    
}

#pragma mark

-(void)EndChat_SetMessageData:(NSString *)userID homeID:(NSString *)homeID itemType:(NSString *)itemType itemID:(NSString *)itemID chatID:(NSString *)chatID completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *myUserID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"";
    NSString *myUsername = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"] : @"";
    
    NSDictionary *dataDict = @{
        @"MessageID" : chatID,
        @"MessageText" : [NSString stringWithFormat:@"%@ has ended the conversation", myUsername],
        @"MessageSentBy" : myUserID,
        @"MessageTimeStamp" : [[[GeneralObject alloc] init] GenerateCurrentDateString],
        @"MessageEnd" : @"Yes",
        @"MessageRead" : [@[myUserID] mutableCopy],
        @"MessageImageURL" : @"xxx",
        @"MessageVideoURL" : @"xxx",
        @"MessageChatID" : @"LiveSupport",
        @"MessageHomeID" : homeID
    };
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[SetDataObject alloc] init] SetDataAddMessage:dataDict userID:userID homeID:homeID itemType:itemType itemID:itemID chatID:chatID viewingGroupChat:NO viewingComments:NO viewingLiveSupport:YES completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)EndChat_SendPushNotification:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[NotificationsObject alloc] init] SendPushNotificationToCreator:[NSString stringWithFormat:@"%@ - Ended Conversation", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] notificationBody:@"End Conversation" badgeNumber:(NSInteger *)1 completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Sub-Internal Methods
#pragma mark
#pragma mark
#pragma mark -

-(NSMutableDictionary *)ReorganizeChatsByMostRecentMessage:(NSMutableDictionary *)dataDict lastMessageDict:(NSMutableDictionary *)lastMessageDict keyArray:(NSArray *)keyArray {
    
    NSMutableArray *arrayOfTimeStamps = [NSMutableArray array];
   
    for (NSString *chatID in dataDict[@"ChatID"]) {
       
        NSString *dateString;
        
        if (lastMessageDict[chatID][@"MessageTimeStamp"]) {
            
            dateString = lastMessageDict[chatID][@"MessageTimeStamp"];
            
        } else {
            
            NSUInteger index = [dataDict[@"ChatID"] indexOfObject:chatID];
            dateString = dataDict[@"ChatDateCreated"][index];
            
        }
        
        [arrayOfTimeStamps addObject:dateString];
        
    }
  
    NSMutableArray *sortedTimeStampArray = [[arrayOfTimeStamps sortedArrayUsingComparator:^(NSString *string1, NSString *string2) {
        
        NSString *dateFormat = @"yyyy-MM-dd hh:mm:ss";
        
        NSDate *date1 = [[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:string1 returnAs:[NSDate class]];
        NSDate *date2 = [[[GeneralObject alloc] init] GenerateDateWithConvertedClassWithFormat:dateFormat dateToConvert:string2 returnAs:[NSDate class]];
        
        return [date1 compare:date2];
        
    }] mutableCopy];
   
    NSMutableArray *reversedSortedTimeStampArray = [[[GeneralObject alloc] init] GenerateArrayInReverse:[sortedTimeStampArray mutableCopy]];
    
    NSMutableDictionary *sortedChatDict = [NSMutableDictionary dictionary];
   
    NSArray *chatKeyArray = [[[GeneralObject alloc] init] GenerateChatKeyArray];
    
    for (NSString *dateString in reversedSortedTimeStampArray) {
        
        for (NSString *chatID in [lastMessageDict allKeys]) {
            
            //If Chat Has At Least One Message, Find Latest Message
           
            if (lastMessageDict[chatID][@"MessageTimeStamp"]) {
              
                if ([lastMessageDict[chatID][@"MessageTimeStamp"] isEqualToString:dateString]) {
                    
                    NSUInteger index = [dataDict[@"ChatID"] indexOfObject:chatID];
                    
                    for (NSString *key in chatKeyArray) {
                        
                        NSMutableArray *arr = sortedChatDict[key] ? [sortedChatDict[key] mutableCopy] : [NSMutableArray array];
                        id object = dataDict[key] && [(NSArray *)dataDict[key] count] > index ? dataDict[key][index] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                        [arr addObject:object];
                        [sortedChatDict setObject:arr forKey:key];
                        
                    }
               
                }
                
            } else {
                
                //If Chat Has No Messages, Use Chat Date Created To Sort
                
                for (NSString *chatDateString in dataDict[@"ChatDateCreated"]) {
                    
                    if ([chatDateString isEqualToString:dateString]) {
                        
                        if ([sortedChatDict[@"ChatID"] containsObject:chatID] == NO) {
                            
                            NSUInteger index = [dataDict[@"ChatID"] indexOfObject:chatID];
                            
                            for (NSString *key in chatKeyArray) {
                                
                                NSMutableArray *arr = sortedChatDict[key] ? [sortedChatDict[key] mutableCopy] : [NSMutableArray array];
                                id object = dataDict[key] && [(NSArray *)dataDict[key] count] > index ? dataDict[key][index] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                                [arr addObject:object];
                                [sortedChatDict setObject:arr forKey:key];
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
    }
   
    return sortedChatDict;
}

@end
