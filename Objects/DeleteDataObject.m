//
//  DeleteDataObject.m
//  WeDivvy
//
//  Created by Philip Nagel on 9/14/21.
//

#import "DeleteDataObject.h"
#import "GeneralObject.h"
#import "GetDataObject.h"
#import "SetDataObject.h"
#import "NotificationsObject.h"
#import "BoolDataObject.h"

@import InstantSearch;
@import InstantSearchClient;

@implementation DeleteDataObject

#pragma mark - Activity

#pragma mark Delete Item - Delete All Activity In Specific Item

-(void)DeleteDataItemActivity:(NSString *)collection itemID:(NSString *)itemID itemOccurrenceID:(NSString *)itemOccurrenceID homeID:(NSString *)homeID completionHandler:(void (^)(BOOL finished))finishBlock {
    
    if ([itemOccurrenceID length] > 0 || [itemOccurrenceID isEqualToString:@"xxx"]) {
        
        finishBlock(YES);
        
    } else {
        
        FIRFirestore *defaultFirestore = [FIRFirestore firestore];
        
        if (collection.length == 0 || collection == nil || collection == NULL) {
            collection = @"xxx";
        }
        if (itemID.length == 0 || itemID == nil || itemID == NULL) {
            itemID = @"xxx";
        }
        if (itemOccurrenceID.length == 0 || itemOccurrenceID == nil || itemOccurrenceID == NULL) {
            itemOccurrenceID = @"xxx";
        }
        if (homeID.length == 0 || homeID == nil || homeID == NULL) {
            homeID = @"xxx";
        }
        
        [[[GetDataObject alloc] init] GetDataItemActivity:collection itemID:itemID homeID:homeID completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningActivityDict) {
            
            if (returningActivityDict && [(NSArray *)returningActivityDict[@"ActivityID"] count] > 0) {
                
                NSMutableArray *objectArr = [NSMutableArray array];
                
                for (NSString *activityID in returningActivityDict[@"ActivityID"]) {
                    
                    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
                    [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Homes", collection] documents:@[homeID, itemID] type:@"DeleteData;" setData:@{} name:@"DeleteDataItemActivity" queryID:queryID];
                    
                    [[[[[[[defaultFirestore collectionWithPath:@"Homes"] documentWithPath:homeID] collectionWithPath:collection] documentWithPath:itemID] collectionWithPath:@"Activity"] documentWithPath:activityID] deleteDocumentWithCompletion:^(NSError * _Nullable error) {
                        
                        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
                        
                        if ([[[GeneralObject alloc] init] AddToObjectArrAndCheckIfQueryHasEnded:returningActivityDict[@"ActivityID"] objectArr:objectArr]) {
                            
                            finishBlock(YES);
                            
                        }
                        
                    }];
                    
                }
                
            } else {
                
                finishBlock(YES);
                
            }
            
        }];
        
    }
    
}

#pragma mark Delete Home - Delete All Activity In Specific Home

-(void)DeleteDataHomeActivity:(NSString *)homeID completionHandler:(void (^)(BOOL finished))finishBlock {
    
    [[[GetDataObject alloc] init] GetDataHomeActivity:homeID completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningActivityDict) {
        
        if (returningActivityDict[@"ActivityID"]) {
            
            if ([(NSArray *)returningActivityDict[@"ActivityID"] count] > 0) {
                
                NSMutableArray *objectArr = [NSMutableArray array];
                
                for (NSString *activityID in returningActivityDict[@"ActivityID"]) {
                    
                    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
                    [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Homes", @"Activity"] documents:@[homeID, activityID] type:@"DeleteData;" setData:@{} name:@"DeleteDataHomeActivity" queryID:queryID];
                    
                    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
                    
                    [[[[[defaultFirestore collectionWithPath:@"Homes"] documentWithPath:homeID] collectionWithPath:@"Activity"] documentWithPath:activityID] deleteDocumentWithCompletion:^(NSError * _Nullable error) {
                        
                        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
                        
                        if ([[[GeneralObject alloc] init] AddToObjectArrAndCheckIfQueryHasEnded:returningActivityDict[@"ActivityID"] objectArr:objectArr]) {
                            
                            finishBlock(YES);
                            
                        }
                        
                    }];
                    
                }
                
            } else {
                
                finishBlock(YES);
                
            }
            
        } else {
            
            finishBlock(YES);
            
        }
        
    }];
    
}

#pragma mark - Algolia

-(void)DeleteDataDeleteAlgoliaObject:(NSString *)itemUniqueID completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString * ALGOLIA_APP_ID = @"3VZ11H3TM1";
    NSString * ALGOLIA_USER_INDEX_NAME = @"Tasks";
    NSString * ALGOLIA_ADMIN_API_KEY = @"37558fa21fb4266d0f5213af41a23a7a";
    
    Client *apiClient = [[Client alloc] initWithAppID:ALGOLIA_APP_ID apiKey:ALGOLIA_ADMIN_API_KEY];
    
    Index *algoliaIndex = [apiClient indexWithName:ALGOLIA_USER_INDEX_NAME];
    
    [algoliaIndex deleteObjectWithID:itemUniqueID completionHandler:^(NSDictionary<NSString *,id> * _Nullable test, NSError * _Nullable error) {
        
        finishBlock(YES);
        
    }];
    
}

#pragma mark - Analytics

-(void)DeleteDataOldMixPanelID:(NSString *)currentMixPanelID completionHandler:(void (^)(BOOL finished))finishBlock {
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    NSString *savedMixPanelID = [[NSUserDefaults standardUserDefaults] objectForKey:@"MixPanelID"];
    
    if (![savedMixPanelID isEqualToString:currentMixPanelID] && currentMixPanelID != nil && savedMixPanelID != nil && [savedMixPanelID length] > 0) {
        
        NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
        [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Analytics"] documents:@[savedMixPanelID] type:@"DeleteData;" setData:@{} name:@"DeleteDataOldMixPanelID" queryID:queryID];
        
        [[[defaultFirestore collectionWithPath:@"Analytics"] documentWithPath:savedMixPanelID] deleteDocumentWithCompletion:^(NSError * _Nullable error) {
            
            [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
            
            finishBlock(YES);
            
        }];
        
    } else {
        
        finishBlock(YES);
        
    }
    
}

#pragma mark - Core Data

-(void)DeleteDataCoreData:(NSString *)entity predicate:(NSPredicate * _Nullable)predicate {
    
    return;
    
    //    dispatch_async(dispatch_get_main_queue(), ^{
    //
    //        NSManagedObjectContext *managedObjectContext = [[[AppDelegate alloc] init] managedObjectContext];
    //
    //        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:entity];
    //        if (predicate != nil) { fetchRequest.predicate = predicate; }
    //
    //        NSError *fetchError = nil;
    //        NSArray *existingObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&fetchError];
    //
    //        if (existingObjects.count > 0) {
    //
    //            NSManagedObject *itemObject = [NSEntityDescription insertNewObjectForEntityForName:entity inManagedObjectContext:managedObjectContext];
    //            [managedObjectContext deleteObject:itemObject];
    //
    //        }
    //
    //        NSError *error = nil;
    //        if (![managedObjectContext save:&error]) {
    //            NSLog(@"Error saving context: %@", error.localizedDescription);
    //        }
    //
    //    });
    
}

#pragma mark - Chats

-(void)DeleteDataGroupChat:(NSString *)homeID chatID:(NSString *)chatID completionHandler:(void (^)(BOOL finished, NSError *error))finishBlock {
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Homes", @"GroupChats"] documents:@[homeID, chatID] type:@"DeleteData;" setData:@{} name:@"DeleteDataGroupChat" queryID:queryID];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[[defaultFirestore collectionWithPath:@"Homes"] documentWithPath:homeID] collectionWithPath:@"GroupChats"] documentWithPath:chatID] deleteDocumentWithCompletion:^(NSError * _Nullable error) {
        
        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
        
        finishBlock(YES, error);
        
    }];
    
}

-(void)DeleteDataGroupChatsInSpecificHome:(NSString *)homeID completionHandler:(void (^)(BOOL finished, NSError *error))finishBlock {
    
    NSArray *chatKeyArray = [[[GeneralObject alloc] init] GenerateChatKeyArray];
    
    [[[GetDataObject alloc] init] GetDataChatsInSpecificHome:homeID keyArray:chatKeyArray completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningDataDict) {
        
        if (!returningDataDict || !returningDataDict[@"ChatID"] || [(NSArray *)returningDataDict[@"ChatID"] count] == 0) {
            
            finishBlock(YES, nil);
            
        }
        
        NSMutableArray *objectArrNo1 = [NSMutableArray array];
        
        for (NSString *chatID in returningDataDict[@"ChatID"]) {
            
            [[[DeleteDataObject alloc] init] DeleteAllMessagesInGroupChat:homeID chatID:chatID completionHandler:^(BOOL finished) {
                
                if ([[[GeneralObject alloc] init] AddToObjectArrAndCheckIfQueryHasEnded:[returningDataDict[@"ChatID"] mutableCopy] objectArr:objectArrNo1]) {
                    
                    finishBlock(YES, nil);
                    
                }
                
            }];
            
        }
        
    }];
    
}

#pragma mark - Drafts

-(void)DeleteDataDraft:(NSString *)draftID draftCreatedBy:(NSString *)draftCreatedBy completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Users", @"Drafts"] documents:@[draftCreatedBy, draftID] type:@"DeleteData;" setData:@{} name:@"DeleteDataDraft" queryID:queryID];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[[defaultFirestore collectionWithPath:@"Users"] documentWithPath:draftCreatedBy] collectionWithPath:@"Drafts"] documentWithPath:draftID] deleteDocumentWithCompletion:^(NSError * _Nullable error) {
        
        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
        
        finishBlock(YES);
        
    }];
    
}

#pragma mark - Folders

-(void)DeleteDataFolder:(NSString *)folderID folderCreatedBy:(NSString *)folderCreatedBy completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Users", @"Folders"] documents:@[folderCreatedBy, folderID] type:@"DeleteData;" setData:@{} name:@"DeleteDataFolder" queryID:queryID];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[[defaultFirestore collectionWithPath:@"Users"] documentWithPath:folderCreatedBy] collectionWithPath:@"Folders"] documentWithPath:folderID] deleteDocumentWithCompletion:^(NSError * _Nullable error) {
        
        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
        
        finishBlock(YES);
        
    }];
    
}

#pragma mark - Forum

-(void)DeleteDataForum:(NSString *)collectionKey forumID:(NSString *)forumID completionHandler:(void (^)(BOOL finished, NSError *error))finishBlock {
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Forum", collectionKey] documents:@[collectionKey, forumID] type:@"DeleteData;" setData:@{} name:@"DeleteDataForum" queryID:queryID];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[[defaultFirestore collectionWithPath:@"Forum"] documentWithPath:collectionKey] collectionWithPath:collectionKey] documentWithPath:forumID] deleteDocumentWithCompletion:^(NSError * _Nullable error) {
        
        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
        
        finishBlock(YES, error);
        
    }];
    
}

#pragma mark - Homes

-(void)DeleteDataHome:(NSString *)homeID completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Homes"] documents:@[homeID] type:@"DeleteData;" setData:@{} name:@"DeleteDataHome" queryID:queryID];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[defaultFirestore collectionWithPath:@"Homes"] documentWithPath:homeID] deleteDocumentWithCompletion:^(NSError * _Nullable error) {
        
        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
        
        finishBlock(YES);
        
    }];
    
}

-(void)DeleteDataHomeImage:(NSString *)homeID completionHandler:(void (^)(BOOL finished))finishBlock {
    
    FIRStorage *storage = [FIRStorage storage];
    
    FIRStorageReference *storageRef = [storage reference];
    
    FIRStorageReference *mountainsRef = [[[[storageRef child:@"HomeImages"] child:homeID] child:@"HomeImage"] child:@"HomeImage.jpeg"];
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"HomeImages", homeID, @"HomeImage", @"HomeImage.jpeg"] documents:@[] type:@"DeleteDataImage" setData:@{} name:@"DeleteDataHomeImage" queryID:queryID];
    
        [mountainsRef deleteWithCompletion:^(NSError * _Nullable error) {
            
            [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
            
            finishBlock(YES);
            
        }];
 
}

#pragma mark Delete Home - Delete All Notifications In Specific Home

-(void)DeleteDataHomeNotifications:(NSString *)homeID completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSArray *keyArray = [[[GeneralObject alloc] init] GenerateNotificationsKeyArray];
    
    [[[GetDataObject alloc] init] GetDataNotifications:homeID keyArray:keyArray completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningDataDict) {
        
        if ([(NSArray *)returningDataDict[@"NotificationID"] count] == 0) {
            
            finishBlock(YES);
            
        }
        
        NSMutableArray *objectArr = [NSMutableArray array];
        
        for (NSString *notificationID in returningDataDict[@"NotificationID"]) {
            
            [[[DeleteDataObject alloc] init] DeleteDataNotification:homeID notificationID:notificationID completionHandler:^(BOOL finishe) {
                
                if ([[[GeneralObject alloc] init] AddToObjectArrAndCheckIfQueryHasEnded:returningDataDict[@"NotificationID"] objectArr:objectArr]) {
                    
                    finishBlock(YES);
                    
                }
                
            }];
            
        }
        
    }];
    
}


#pragma mark Delete Home - Delete User From Specific Home

-(void)DeleteDataUserFromHome:(NSString *)userID completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSArray *keyArray = [NSArray arrayWithObjects:@"HomeID", @"HomeMembers", nil];
    
    [[[GetDataObject alloc] init] GetDataHomesUserIsMemberOf:keyArray userID:userID completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningHomeDict) {
        
        if ([(NSArray *)returningHomeDict[@"HomeID"] count] == 0) {
            
            finishBlock(YES);
            
        }
        
        NSMutableArray *objectArr = [NSMutableArray array];
        
        for (NSString *homeID in returningHomeDict[@"HomeID"]) {
            
            NSUInteger index = [returningHomeDict[@"HomeID"] indexOfObject:homeID];
            
            NSMutableArray *homeMembersArray =
            returningHomeDict[@"HomeMembers"] &&
            [(NSArray *)returningHomeDict[@"HomeMembers"] count] > index ?
            [returningHomeDict[@"HomeMembers"][index] mutableCopy] : [NSMutableArray array];
            
            if ([homeMembersArray containsObject:userID]) { [homeMembersArray removeObject:userID]; }
            
            [[[SetDataObject alloc] init] UpdateDataHome:homeID homeDict:@{@"HomeMembers" : homeMembersArray} completionHandler:^(BOOL finished) {
                
                if ([[[GeneralObject alloc] init] AddToObjectArrAndCheckIfQueryHasEnded:returningHomeDict[@"HomeID"] objectArr:objectArr]) {
                    
                    finishBlock(YES);
                    
                }
                
            }];
            
        }
        
    }];
    
}

#pragma mark Delete Home - Delete Home Completely

-(void)DeleteHomeCompletely:(NSIndexPath *)indexPath homeDict:(NSMutableDictionary *)homeDict keyArray:(NSArray *)keyArray userID:(NSString *)userID homeMembersDict:(NSMutableDictionary *)homeMembersDict topicDict:(NSMutableDictionary *)topicDict QueryAssignedToNewHomeMember:(BOOL)QueryAssignedToNewHomeMember QueryAssignedTo:(BOOL)QueryAssignedTo queryAssignedToUserID:(NSString *)queryAssignedToUserID completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *homeID = homeDict && homeDict[@"HomeID"] && [(NSArray *)homeDict[@"HomeID"] count] > indexPath.row ? homeDict[@"HomeID"][indexPath.row] : @"";
    
   
    
    __block int totalQueries = 7;
    __block int completedQueries = 0;
    
    
    
    /*
     //
     //
     //Delete Home Image
     //
     //
     */
    [[[DeleteDataObject alloc] init] DeleteHome_DeleteHomeImage:homeID completionHandler:^(BOOL finished) {
      
        [[[DeleteDataObject alloc] init] DeleteHome_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) homeID:homeID completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Delete Home Activity
     //
     //
     */
    [[[DeleteDataObject alloc] init] DeleteHome_DeleteHomeActivity:homeID completionHandler:^(BOOL finished) {
        
        [[[DeleteDataObject alloc] init] DeleteHome_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) homeID:homeID completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Delete Home Notifications
     //
     //
     */
    [[[DeleteDataObject alloc] init] DeleteHome_DeleteHomeNotifications:homeID completionHandler:^(BOOL finished) {
      
        [[[DeleteDataObject alloc] init] DeleteHome_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) homeID:homeID completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Delete Home Items (Chores)
     //
     //
     */
    [[[DeleteDataObject alloc] init] DeleteHome_DeleteHomeItems:homeID collection:@"Chores" itemType:@"Chore" userID:userID homeMembersDict:homeMembersDict topicDict:topicDict completionHandler:^(BOOL finished) {
       
        [[[DeleteDataObject alloc] init] DeleteHome_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) homeID:homeID completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Delete Home Items (Expenses)
     //
     //
     */
    [[[DeleteDataObject alloc] init] DeleteHome_DeleteHomeItems:homeID collection:@"Expenses" itemType:@"Expense" userID:userID homeMembersDict:homeMembersDict topicDict:topicDict completionHandler:^(BOOL finished) {
      
        [[[DeleteDataObject alloc] init] DeleteHome_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) homeID:homeID completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Delete Home Items (Lists)
     //
     //
     */
    [[[DeleteDataObject alloc] init] DeleteHome_DeleteHomeItems:homeID collection:@"Lists" itemType:@"List" userID:userID homeMembersDict:homeMembersDict topicDict:topicDict completionHandler:^(BOOL finished) {
      
        [[[DeleteDataObject alloc] init] DeleteHome_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) homeID:homeID completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Delete Home Group Chats
     //
     //
     */
    [[[DeleteDataObject alloc] init] DeleteHome_DeleteHomeGroupChats:homeID completionHandler:^(BOOL finished) {
      
        [[[DeleteDataObject alloc] init] DeleteHome_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) homeID:homeID completionHandler:^(BOOL finished) {

            finishBlock(YES);
            
        }];
        
    }];
    
}

#pragma mark - Messages

-(void)DeleteDataMessage:(NSString *)messageID userID:(NSString *)userID homeID:(NSString *)homeID itemType:(NSString *)itemType itemID:(NSString *)itemID chatID:(NSString *)chatID viewingGroupChat:(BOOL)viewingGroupChat viewingComments:(BOOL)viewingComments viewingLiveSupport:(BOOL)viewingLiveSupport completionHandler:(void (^)(BOOL finished))finishBlock {
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    if (messageID.length == 0 || messageID == nil || messageID == NULL) {
        messageID = @"xxx";
    }
    if (userID.length == 0 || userID == nil || userID == NULL) {
        userID = @"xxx";
    }
    if (homeID.length == 0 || homeID == nil || homeID == NULL) {
        homeID = @"xxx";
    }
    if (itemType.length == 0 || itemType == nil || itemType == NULL) {
        itemType = @"xxx";
    }
    if (itemID.length == 0 || itemID == nil || itemID == NULL) {
        itemID = @"xxx";
    }
    if (chatID.length == 0 || chatID == nil || chatID == NULL) {
        chatID = @"xxx";
    }
    
    if (viewingGroupChat == YES) {
        
        NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
        
        [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Homes", @"GroupChats", @"Messages"] documents:@[homeID, chatID, messageID] type:@"DeleteData" setData:@{} name:@"DeleteDataMessage" queryID:queryID];
        
        [[[[[[[defaultFirestore collectionWithPath:@"Homes"] documentWithPath:homeID] collectionWithPath:@"GroupChats"] documentWithPath:chatID] collectionWithPath:@"Messages"] documentWithPath:messageID] deleteDocumentWithCompletion:^(NSError * _Nullable error) {
            
            [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
            
            finishBlock(YES);
            
        }];
        
    } else if (viewingComments == YES) {
        
        NSString *collection = [NSString stringWithFormat:@"%@s", itemType];
        
        NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
        
        [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Homes", collection, @"Comments"] documents:@[homeID, itemID, messageID] type:@"DeleteData" setData:@{} name:@"DeleteDataMessage" queryID:queryID];
        
        [[[[[[[defaultFirestore collectionWithPath:@"Homes"] documentWithPath:homeID] collectionWithPath:collection] documentWithPath:itemID] collectionWithPath:@"Comments"] documentWithPath:messageID] deleteDocumentWithCompletion:^(NSError * _Nullable error) {
            
            [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
            
            finishBlock(YES);
            
        }];
        
    } else if (viewingLiveSupport == YES) {
        
        NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
        
        [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Users", @"LiveSupport"] documents:@[userID, messageID] type:@"DeleteData" setData:@{} name:@"DeleteDataMessage" queryID:queryID];
        
        [[[[[defaultFirestore collectionWithPath:@"Users"] documentWithPath:userID] collectionWithPath:@"LiveSupport"] documentWithPath:messageID] deleteDocumentWithCompletion:^(NSError * _Nullable error) {
            
            [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
            
            finishBlock(YES);
            
        }];
        
    }
    
}

#pragma mark Compound Methods

-(void)DeleteAllMessagesInGroupChat:(NSString *)homeID chatID:(NSString *)chatID completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSArray *messageKeyArray = [[[GeneralObject alloc] init] GenerateMessageKeyArray];
    
    [[[GetDataObject alloc] init] GetDataMessagesInSpecificChat:@"" homeID:homeID itemType:@"GroupChat" itemID:@"" chatID:chatID keyArray:messageKeyArray messageDict:[NSMutableDictionary dictionary] viewingGroupChat:YES viewingComments:NO viewingLiveSupport:NO completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningMessageDict) {
        
        if ([(NSArray *)returningMessageDict[@"MessageID"] count] > 0){
            
            NSMutableArray *objectArr = [NSMutableArray array];
            
            for (NSString *messageID in returningMessageDict[@"MessageID"]) {
                
                [[[DeleteDataObject alloc] init] DeleteDataMessage:messageID userID:@"" homeID:homeID itemType:@"GroupChat" itemID:@"" chatID:chatID viewingGroupChat:YES viewingComments:NO viewingLiveSupport:NO completionHandler:^(BOOL finished) {
                    
                    if ([[[GeneralObject alloc] init] AddToObjectArrAndCheckIfQueryHasEnded:[returningMessageDict[@"MessageID"] mutableCopy] objectArr:objectArr]) {
                        
                        finishBlock(YES);
                        
                    }
                    
                }];
                
            }
            
        } else {
            
            finishBlock(YES);
            
        }
        
    }];
    
}

-(void)DeleteAllMessagesInComments:(NSString *)homeID itemID:(NSString *)itemID itemType:(NSString *)itemType completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSArray *messageKeyArray = [[[GeneralObject alloc] init] GenerateMessageKeyArray];
    
    [[[GetDataObject alloc] init] GetDataMessagesInSpecificChat:@"" homeID:homeID itemType:itemType itemID:itemID chatID:@"" keyArray:messageKeyArray messageDict:[NSMutableDictionary dictionary] viewingGroupChat:NO viewingComments:YES viewingLiveSupport:NO completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningMessageDict) {
      
        if ([(NSArray *)returningMessageDict[@"MessageID"] count] > 0){
            
            NSMutableArray *objectArr = [NSMutableArray array];
            
            for (NSString *messageID in returningMessageDict[@"MessageID"]) {
               
                [[[DeleteDataObject alloc] init] DeleteDataMessage:messageID userID:@"" homeID:homeID itemType:itemType itemID:itemID chatID:@"" viewingGroupChat:NO viewingComments:YES viewingLiveSupport:NO completionHandler:^(BOOL finished) {
                    
                    if ([[[GeneralObject alloc] init] AddToObjectArrAndCheckIfQueryHasEnded:[returningMessageDict[@"MessageID"] mutableCopy] objectArr:objectArr]) {
                        
                        finishBlock(YES);
                        
                    }
                    
                }];
                
            }
            
        } else {
            
            finishBlock(YES);
            
        }
        
    }];
    
}

#pragma mark - Notifications

-(void)DeleteDataNotification:(NSString *)homeID notificationID:(NSString *)notificationID completionHandler:(void (^)(BOOL finishe))finishBlock {
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Homes", @"Notifications"] documents:@[homeID, notificationID] type:@"DeleteData;" setData:@{} name:@"DeleteDataHomeNotification" queryID:queryID];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[[defaultFirestore collectionWithPath:@"Homes"]
        documentWithPath:homeID]
       collectionWithPath:@"Notifications"]
      documentWithPath:notificationID]
     deleteDocumentWithCompletion:^(NSError * _Nullable error) {
        
        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
        
        finishBlock(YES);
        
    }];
    
}

#pragma mark - Promotional Codes

-(void)DeleteDataPromotionalCode:(NSString *)promotionalCodeID completionHandler:(void (^)(BOOL finishe))finishBlock {
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"PromotionalCodes"] documents:@[promotionalCodeID] type:@"DeleteData;" setData:@{} name:@"DeleteDataPromotionalCode" queryID:queryID];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[defaultFirestore
       collectionWithPath:@"PromotionalCodes"]
      documentWithPath:promotionalCodeID]
     deleteDocumentWithCompletion:^(NSError * _Nullable error) {
        
        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
        
        finishBlock(YES);
        
    }];
    
}

#pragma mark - Sections

-(void)DeleteDataSection:(NSString *)sectionID sectionCreatedBy:(NSString *)sectionCreatedBy completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Users", @"Sections"] documents:@[sectionCreatedBy, sectionID] type:@"DeleteData;" setData:@{} name:@"DeleteDataSection" queryID:queryID];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[[defaultFirestore collectionWithPath:@"Users"] documentWithPath:sectionCreatedBy] collectionWithPath:@"Sections"] documentWithPath:sectionID] deleteDocumentWithCompletion:^(NSError * _Nullable error) {
        
        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
        
        finishBlock(YES);
        
    }];
    
}

#pragma mark - Task Lists

-(void)DeleteDataRemoveTaskList:(NSString *)taskListID taskListCreatedBy:(NSString *)taskListCreatedBy completionHandler:(void (^)(BOOL finished))finishBlock {
    
    if (taskListCreatedBy.length == 0) {
        taskListCreatedBy = @"xxx";
    }
    if (taskListID.length == 0) {
        taskListID = @"xxx";
    }
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Users", @"TaskLists"] documents:@[taskListCreatedBy, taskListID] type:@"DeleteData;" setData:@{} name:@"DeleteDataRemoveTaskList" queryID:queryID];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[[defaultFirestore collectionWithPath:@"Users"] documentWithPath:taskListCreatedBy] collectionWithPath:@"TaskLists"] documentWithPath:taskListID] deleteDocumentWithCompletion:^(NSError * _Nullable error) {
        
        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
        
        finishBlock(YES);
        
    }];
    
}

#pragma mark - Templates

-(void)DeleteDataTemplate:(NSString *)templateID templateCreatedBy:(NSString *)templateCreatedBy completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Users", @"Templates"] documents:@[templateCreatedBy, templateID] type:@"DeleteData;" setData:@{} name:@"DeleteDataTemplate" queryID:queryID];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[[defaultFirestore collectionWithPath:@"Users"] documentWithPath:templateCreatedBy] collectionWithPath:@"Templates"] documentWithPath:templateID] deleteDocumentWithCompletion:^(NSError * _Nullable error) {
        
        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
        
        finishBlock(YES);
        
    }];
    
}

#pragma mark - Users

-(void)DeleteDataUser:(NSString *)userID completionHandler:(void (^)(BOOL finished, NSError *error))finishBlock {
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Users"] documents:@[userID] type:@"DeleteData;" setData:@{} name:@"DeleteDataUser" queryID:queryID];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[defaultFirestore
       collectionWithPath:@"Users"]
      documentWithPath:userID] deleteDocumentWithCompletion:^(NSError * _Nullable error) {
        
        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
        
        finishBlock(YES, error);
        
    }];
    
}

-(void)DeleteDataUserNotificationSettings:(NSString *)userID completionHandler:(void (^)(BOOL finished, NSError *error))finishBlock {
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Users", @"NotificationSettings"] documents:@[userID, userID] type:@"DeleteData;" setData:@{} name:@"DeleteDataUserNotificationSettings" queryID:queryID];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[[defaultFirestore
         collectionWithPath:@"Users"]
        documentWithPath:userID]
       collectionWithPath:@"NotificationSettings"]
      documentWithPath:userID]
     deleteDocumentWithCompletion:^(NSError * _Nullable error) {
        
        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
        
        finishBlock(YES, error);
        
    }];
    
}

-(void)DeleteDataUserCalendarSettings:(NSString *)userID completionHandler:(void (^)(BOOL finished, NSError *error))finishBlock {
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Users", @"CalendarSettings"] documents:@[userID, userID] type:@"DeleteData;" setData:@{} name:@"DeleteDataUserCalendarSettings" queryID:queryID];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[[defaultFirestore
         collectionWithPath:@"Users"]
        documentWithPath:userID]
       collectionWithPath:@"CalendarSettings"]
      documentWithPath:userID]
     deleteDocumentWithCompletion:^(NSError * _Nullable error) {
        
        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
        
        finishBlock(YES, error);
        
    }];
    
}

-(void)DeleteDataProfileImage:(NSString *)userID completionHandler:(void (^)(BOOL finished, NSError *error))finishBlock {
    
    FIRStorage *storage = [FIRStorage storage];
    
    FIRStorageReference *storageRef = [storage reference];
    
    FIRStorageReference *mountainsRef = [[[[storageRef child:@"UserImages"] child:userID] child:@"ProfileImage"] child:@"ProfileImage.jpeg"];
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"UserImages", userID, @"ProfileImage", @"ProfileImage.jpeg"] documents:@[] type:@"DeleteDataImage" setData:@{} name:@"DeleteDataProfileImage" queryID:queryID];
    
        [mountainsRef deleteWithCompletion:^(NSError * _Nullable error) {
            
            [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
            
            finishBlock(YES, error);
            
        }];

}

#pragma mark - Items

//Batch

-(void)DeleteDataItem:(NSString *)collection itemID:(NSString *)itemID itemOccurrenceID:(NSString *)itemOccurrenceID homeID:(NSString *)homeID completionHandler:(void (^)(BOOL finished))finishBlock {
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    if (collection.length == 0 || collection == nil || collection == NULL) {
        collection = @"xxx";
    }
    if (itemID.length == 0 || itemID == nil || itemID == NULL) {
        itemID = @"xxx";
    }
    if (itemOccurrenceID.length == 0 || itemOccurrenceID == nil || itemOccurrenceID == NULL) {
        itemOccurrenceID = @"xxx";
    }
    if (homeID.length == 0 || homeID == nil || homeID == NULL) {
        homeID = @"xxx";
    }
    
    FIRDocumentReference *queryToUse;
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    
    BOOL ItemIsAnOccurrence = itemOccurrenceID.length > 0 && [itemOccurrenceID isEqualToString:@"xxx"] == NO;
    
    if (ItemIsAnOccurrence == YES) {
        
        collection = [collection substringToIndex:[collection length] - 1];
        
        queryToUse = [[[[defaultFirestore collectionWithPath:@"Homes"]
                        documentWithPath:homeID]
                       collectionWithPath:[NSString stringWithFormat:@"%@Occurrences", collection]]
                      documentWithPath:itemOccurrenceID];
        
        [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Homes", [NSString stringWithFormat:@"%@Occurrences", collection]]
                                               documents:@[homeID, itemOccurrenceID]
                                                    type:@"DeleteData;"
                                                 setData:@{}
                                                    name:@"DeleteDataItem"
                                                 queryID:queryID];
        
    } else {
        
        queryToUse = [[[[defaultFirestore collectionWithPath:@"Homes"]
                        documentWithPath:homeID]
                       collectionWithPath:collection]
                      documentWithPath:itemID];
        
        [[[GeneralObject alloc] init] AddQueryToDefaults:@[@"Homes", collection]
                                               documents:@[homeID, itemID]
                                                    type:@"DeleteData;"
                                                 setData:@{}
                                                    name:@"DeleteDataItem"
                                                 queryID:queryID];
        
    }
    
    [queryToUse deleteDocumentWithCompletion:^(NSError * _Nullable error) {
        
        [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
        
        finishBlock(YES);
        
    }];
    
}

-(void)DeleteDataItemOccurrences:(NSString *)collection itemID:(NSString *)itemID itemOccurrenceID:(NSString *)itemOccurrenceID homeID:(NSString *)homeID keyArray:(NSArray *)keyArray completionHandler:(void (^)(BOOL finished))finishBlock {
    
    BOOL ItemIsAnOccurrence = itemOccurrenceID.length > 0 && [itemOccurrenceID isEqualToString:@"xxx"] == NO;
    
    if (ItemIsAnOccurrence == NO) {
        
        if (collection.length == 0 || collection == nil || collection == NULL) {
            collection = @"xxx";
        }
        if (itemID.length == 0 || itemID == nil || itemID == NULL) {
            itemID = @"xxx";
        }
        if (itemOccurrenceID.length == 0 || itemOccurrenceID == nil || itemOccurrenceID == NULL) {
            itemOccurrenceID = @"xxx";
        }
        if (homeID.length == 0 || homeID == nil || homeID == NULL) {
            homeID = @"xxx";
        }
        
        [[[GetDataObject alloc] init] GetDataItemOccurrencesForSingleItem:collection itemID:itemID homeID:homeID keyArray:keyArray completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningOccurrencesDict) {
            
            if (!returningOccurrencesDict || [(NSArray *)returningOccurrencesDict[@"ItemOccurrenceID"] count] == 0) {
                
                finishBlock(YES);
                
            }
            
            NSMutableArray *objectArr = [NSMutableArray array];
            
            for (NSString *itemOccurrenceID in returningOccurrencesDict[@"ItemOccurrenceID"]) {
                
                [[[DeleteDataObject alloc] init] DeleteDataItem:collection itemID:itemID itemOccurrenceID:itemOccurrenceID homeID:homeID completionHandler:^(BOOL finished) {
                    
                    if ([[[GeneralObject alloc] init] AddToObjectArrAndCheckIfQueryHasEnded:returningOccurrencesDict[@"ItemOccurrenceID"] objectArr:objectArr]) {
                        
                        finishBlock(YES);
                        
                    }
                    
                }];
                
            }
            
        }];
        
    }
    
}

-(void)DeleteDataItemImage:(NSString *)itemUniqueID itemType:(NSString *)itemType completionHandler:(void (^)(BOOL finished))finishBlock {
    
    FIRStorage *storage = [FIRStorage storage];
    
    FIRStorageReference *storageRef = [storage reference];
    
    NSString *firstChild = [NSString stringWithFormat:@"%@Images", itemType];
    NSString *secondChild = [NSString stringWithFormat:@"%@Image", itemType];
    
    //ChoreImages/123/ChoreImage/123.jpeg/
    FIRStorageReference *mountainsRef = [[[[storageRef child:firstChild] child:itemUniqueID] child:secondChild] child:[NSString stringWithFormat:@"%@.jpeg", itemUniqueID]];
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[firstChild, itemUniqueID, secondChild, [NSString stringWithFormat:@"%@.jpeg", itemUniqueID]] documents:@[] type:@"DeleteDataImage" setData:@{} name:@"DeleteDataItemImage" queryID:queryID];
  
        [mountainsRef deleteWithCompletion:^(NSError * _Nullable error) {
            
            [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
            
            finishBlock(YES);
            
        }];
 
}

-(void)DeleteDataItemPhotoConfirmationImage:(NSString *)itemUniqueID itemType:(NSString *)itemType markedObject:(NSString *)markedObject completionHandler:(void (^)(BOOL finished))finishBlock {
    
    FIRStorage *storage = [FIRStorage storage];
    
    FIRStorageReference *storageRef = [storage reference];
    
    NSString *firstChild = [NSString stringWithFormat:@"%@Images", itemType];
    NSString *secondChild = [NSString stringWithFormat:@"%@Image", itemType];
    
    //ChoreImages/123/ChoreImage/PhotoConfirmations/123.jpeg/
    FIRStorageReference *mountainsRef = [[[[[storageRef child:firstChild] child:itemUniqueID] child:secondChild] child:@"PhotoConfirmations"] child:[NSString stringWithFormat:@"%@.jpeg", markedObject]];
    
    NSString *queryID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    [[[GeneralObject alloc] init] AddQueryToDefaults:@[firstChild, itemUniqueID, secondChild, @"PhotoConfirmations"] documents:@[] type:@"DeleteDataImage" setData:@{} name:@"DeleteDataItemPhotoConfirmationImage" queryID:queryID];
    
        [mountainsRef deleteWithCompletion:^(NSError * _Nullable error) {
            
            [[[GeneralObject alloc] init] RemoveQueryToDefaults:queryID];
            
            finishBlock(YES);
            
        }];
 
}

#pragma mark Delete User - Remove User From Item

-(void)DeleteUserFromAssignedTo:(NSString *)itemType itemTypeCollection:(NSString *)itemTypeCollection keyArray:(NSArray *)keyArray homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType topicDict:(NSMutableDictionary *)topicDict allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays dictToUse:(NSMutableDictionary *)dictToUse itemAssignedToUsername:(NSMutableArray *)itemAssignedToUsername userIDToRemove:(NSString *)userIDToRemove completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDictToUse))finishBlock {
    
    dictToUse = [[[DeleteDataObject alloc] init] DeleteUserFromAssignedTo_GenerateDictWithUserRemoved:dictToUse homeMembersDict:homeMembersDict userIDToRemove:userIDToRemove itemType:itemType itemAssignedToUsername:itemAssignedToUsername];
    
    
    
    __block int totalQueries = 4;
    __block int completedQueries = 0;
    
    
    
    /*
     //
     //
     //Update Item Data
     //
     //
     */
    [[[DeleteDataObject alloc] init] DeleteUserFromAssignedTo_UpdateItemData:dictToUse itemTypeCollection:itemTypeCollection completionHandler:^(BOOL finished) {
        
        [[[DeleteDataObject alloc] init] DeleteUserFromAssignedTo_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:dictToUse completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse) {
            
            finishBlock(YES, dictToUse);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Update Topic Data
     //
     //
     */
    [[[DeleteDataObject alloc] init] DeleteUserFromAssignedTo_UpdateTopicData:dictToUse userIDToRemove:userIDToRemove completionHandler:^(BOOL finished) {
        
        [[[DeleteDataObject alloc] init] DeleteUserFromAssignedTo_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:dictToUse completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse) {
            
            finishBlock(YES, dictToUse);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Send Push Notifications
     //
     //
     */
    [[[DeleteDataObject alloc] init] DeleteUserFromAssignedTo_SendPushNotifications:dictToUse keyArray:keyArray itemType:itemType itemTypeCollection:itemTypeCollection userIDToRemove:userIDToRemove homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType topicDict:topicDict allItemTagsArrays:allItemTagsArrays completionHandler:^(BOOL finished) {
        
        [[[DeleteDataObject alloc] init] DeleteUserFromAssignedTo_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:dictToUse completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse) {
            
            finishBlock(YES, dictToUse);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Reset Item Silent Notifications
     //
     //
     */
    [[[DeleteDataObject alloc] init] DeleteUserFromAssignedTo_ResetItemSilentNotifications:dictToUse keyArray:keyArray itemType:itemType homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType topicDict:topicDict allItemTagsArrays:allItemTagsArrays userIDToRemove:userIDToRemove completionHandler:^(BOOL finished) {
        
        [[[DeleteDataObject alloc] init] DeleteUserFromAssignedTo_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:dictToUse completionHandler:^(BOOL finished, NSMutableDictionary *returningDictToUse) {
            
            finishBlock(YES, dictToUse);
            
        }];
        
    }];
    
}

#pragma mark Delete Item - Delete Specific Item Entirely

-(void)DeleteDataItemCompletely:(NSMutableDictionary *)dictToUse homeID:(NSString *)homeID itemType:(NSString *)itemType keyArray:(NSArray *)keyArray homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType topicDict:(NSMutableDictionary *)topicDict taskListDict:(NSMutableDictionary *)taskListDict allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays currentViewController:(UIViewController *)currentViewController completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningUpdatedTaskListDict))finishBlock {
    
    __block NSMutableDictionary *returningUpdatedTaskListDictLocal = [NSMutableDictionary dictionary];
    
  
    
    __block int totalQueries = 11;
    __block int completedQueries = 0;
    
    
    
    /*
     //
     //
     //Send Push Notifications
     //
     //
     */
    [[[DeleteDataObject alloc] init] DeleteDataItemCompletely_SendPushNotifications:dictToUse homeID:homeID itemType:itemType homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType topicDict:topicDict allItemTagsArrays:allItemTagsArrays completionHandler:^(BOOL finished) {
        
        [[[DeleteDataObject alloc] init] DeleteDataItemCompletely_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:dictToUse homeID:homeID itemType:itemType completionHandler:^(BOOL finished) {
            
            finishBlock(YES, returningUpdatedTaskListDictLocal);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Reset Item Notification
     //
     //
     */
    [[[DeleteDataObject alloc] init] DeleteDataItemCompletely_ResetItemNotifications:dictToUse keyArray:keyArray itemType:itemType homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict notificationType:notificationType topicDict:topicDict allItemTagsArrays:allItemTagsArrays completionHandler:^(BOOL finished) {
      
        [[[DeleteDataObject alloc] init] DeleteDataItemCompletely_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:dictToUse homeID:homeID itemType:itemType completionHandler:^(BOOL finished) {
            
            finishBlock(YES, returningUpdatedTaskListDictLocal);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Reset Scheduled Start Notification
     //
     //
     */
    [[[DeleteDataObject alloc] init] DeleteDataItemCompletely_ResetScheduledStartNotifications:dictToUse itemType:itemType topicDict:topicDict completionHandler:^(BOOL finished) {
       
        [[[DeleteDataObject alloc] init] DeleteDataItemCompletely_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:dictToUse homeID:homeID itemType:itemType completionHandler:^(BOOL finished) {
            
            finishBlock(YES, returningUpdatedTaskListDictLocal);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //(Not Query) Reset Custom Reminder Notification
     //
     //
     */
    [[[DeleteDataObject alloc] init] DeleteDataItemCompletely_ResetCustomReminderNotifications:dictToUse itemType:itemType homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict allItemTagsArrays:allItemTagsArrays completionHandler:^(BOOL finished) {
       
        [[[DeleteDataObject alloc] init] DeleteDataItemCompletely_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:dictToUse homeID:homeID itemType:itemType completionHandler:^(BOOL finished) {
            
            finishBlock(YES, returningUpdatedTaskListDictLocal);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Delete Image Data
     //
     //
     */
    [[[DeleteDataObject alloc] init] DeleteDataItemCompletely_DeleteImageData:dictToUse itemType:itemType completionHandler:^(BOOL finished) {
       
        [[[DeleteDataObject alloc] init] DeleteDataItemCompletely_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:dictToUse homeID:homeID itemType:itemType completionHandler:^(BOOL finished) {
            
            finishBlock(YES, returningUpdatedTaskListDictLocal);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Update Task List Data
     //
     //
     */
    [[[DeleteDataObject alloc] init] DeleteDataItemCompletely_UpdateTaskListData:dictToUse taskListDict:taskListDict completionHandler:^(BOOL finished, NSMutableDictionary *returningUpdatedTaskListDict) {
       
        returningUpdatedTaskListDictLocal = [returningUpdatedTaskListDict mutableCopy];
        
        [[[DeleteDataObject alloc] init] DeleteDataItemCompletely_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:dictToUse homeID:homeID itemType:itemType completionHandler:^(BOOL finished) {
            
            finishBlock(YES, returningUpdatedTaskListDictLocal);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Delete Algolia Data
     //
     //
     */
    [[[DeleteDataObject alloc] init] DeleteDataItemCompletely_DeleteAlgoliaData:dictToUse completionHandler:^(BOOL finished) {
       
        [[[DeleteDataObject alloc] init] DeleteDataItemCompletely_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:dictToUse homeID:homeID itemType:itemType completionHandler:^(BOOL finished) {
            
            finishBlock(YES, returningUpdatedTaskListDictLocal);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Update Topic Data
     //
     //
     */
    [[[DeleteDataObject alloc] init] DeleteDataItemCompletely_UpdateTopicData:dictToUse homeID:homeID completionHandler:^(BOOL finished) {
       
        [[[DeleteDataObject alloc] init] DeleteDataItemCompletely_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:dictToUse homeID:homeID itemType:itemType completionHandler:^(BOOL finished) {
            
            finishBlock(YES, returningUpdatedTaskListDictLocal);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Delete Occurrence Data
     //
     //
     */
    [[[DeleteDataObject alloc] init] DeleteDataItemCompletely_DeleteOccurrenceData:dictToUse homeID:homeID itemType:itemType completionHandler:^(BOOL finished) {
        
        [[[DeleteDataObject alloc] init] DeleteDataItemCompletely_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:dictToUse homeID:homeID itemType:itemType completionHandler:^(BOOL finished) {
            
            finishBlock(YES, returningUpdatedTaskListDictLocal);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Delete Item Activity Data
     //
     //
     */
    [[[DeleteDataObject alloc] init] DeleteDataItemCompletely_DeleteItemActivityData:dictToUse homeID:homeID itemType:itemType completionHandler:^(BOOL finished) {
       
        [[[DeleteDataObject alloc] init] DeleteDataItemCompletely_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:dictToUse homeID:homeID itemType:itemType completionHandler:^(BOOL finished) {
            
            finishBlock(YES, returningUpdatedTaskListDictLocal);
            
        }];
        
    }];
    
    
    /*
     //
     //
     //Delete Comment Data
     //
     //
     */
    [[[DeleteDataObject alloc] init] DeleteDataItemCompletely_DeleteCommmentData:dictToUse homeID:homeID itemType:itemType completionHandler:^(BOOL finished) {
       
        [[[DeleteDataObject alloc] init] DeleteDataItemCompletely_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) dictToUse:dictToUse homeID:homeID itemType:itemType completionHandler:^(BOOL finished) {
            
            finishBlock(YES, returningUpdatedTaskListDictLocal);
            
        }];
        
    }];
    
}

#pragma mark Delete Home - Delete All Items In Specific Home

-(void)DeleteDataAllItemsInSpecificHome:(NSString *)homeID collection:(NSString *)collection itemType:(NSString *)itemType userID:(NSString *)userID homeMembersDict:(NSMutableDictionary *)homeMembersDict topicDict:(NSMutableDictionary *)topicDict QueryAssignedToNewHomeMember:(BOOL)QueryAssignedToNewHomeMember QueryAssignedTo:(BOOL)QueryAssignedTo queryAssignedToUserID:(NSString *)queryAssignedToUserID completionHandler:(void (^)(BOOL finished))finishBlock {
    
    [[[GetDataObject alloc] init] GetDataItemsInSpecificHomeWithSpecificQuery:homeID collection:collection QueryAssignedToNewHomeMember:QueryAssignedToNewHomeMember QueryAssignedTo:QueryAssignedTo queryAssignedToUserID:queryAssignedToUserID completionHandler:^(BOOL finished, FIRQuerySnapshot * _Nonnull snapshot) {
        
        if (snapshot.documents.count == 0) {
            
            finishBlock(YES);
            
        } else {
            
            for (FIRDocumentSnapshot *doc in snapshot.documents) {
                
                
                
                __block int totalQueries = 7;
                __block int completedQueries = 0;
                
                
                
                /*
                 //
                 //
                 //Delete Item Occurrences
                 //
                 //
                 */
                [[[DeleteDataObject alloc] init] DeleteDataAllItemsInSpecificHome_DeleteItemOccurrences:doc homeID:homeID collection:collection completionHandler:^(BOOL finished) {
                    
                    [[[DeleteDataObject alloc] init] DeleteDataAllItemsInSpecificHome_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) doc:doc snapshot:snapshot homeID:homeID collection:collection completionHandler:^(BOOL finished) {
                        
                        finishBlock(YES);
                        
                    }];
                    
                }];
                
                
                /*
                 //
                 //
                 //Delete Item Activity
                 //
                 //
                 */
                [[[DeleteDataObject alloc] init] DeleteDataAllItemsInSpecificHome_DeleteItemActivity:doc homeID:homeID collection:collection completionHandler:^(BOOL finished) {
                    
                    [[[DeleteDataObject alloc] init] DeleteDataAllItemsInSpecificHome_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) doc:doc snapshot:snapshot homeID:homeID collection:collection completionHandler:^(BOOL finished) {
                        
                        finishBlock(YES);
                        
                    }];
                    
                }];
                
                
                /*
                 //
                 //
                 //Delete Item Comments
                 //
                 //
                 */
                [[[DeleteDataObject alloc] init] DeleteDataAllItemsInSpecificHome_DeleteItemComments:doc homeID:homeID itemType:itemType completionHandler:^(BOOL finished) {
                    
                    [[[DeleteDataObject alloc] init] DeleteDataAllItemsInSpecificHome_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) doc:doc snapshot:snapshot homeID:homeID collection:collection completionHandler:^(BOOL finished) {
                        
                        finishBlock(YES);
                        
                    }];
                    
                }];
                
                
                /*
                 //
                 //
                 //Delete Image Data
                 //
                 //
                 */
                [[[DeleteDataObject alloc] init] DeleteDataAllItemsInSpecificHome_DeleteItemImageData:doc itemType:itemType completionHandler:^(BOOL finished) {
                    
                    [[[DeleteDataObject alloc] init] DeleteDataAllItemsInSpecificHome_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) doc:doc snapshot:snapshot homeID:homeID collection:collection completionHandler:^(BOOL finished) {
                        
                        finishBlock(YES);
                        
                    }];
                    
                }];
                
                
                /*
                 //
                 //
                 //Update Topic Data
                 //
                 //
                 */
                [[[DeleteDataObject alloc] init] DeleteDataAllItemsInSpecificHome_UpdateTopicData:doc homeID:homeID collection:collection completionHandler:^(BOOL finished) {
                    
                    [[[DeleteDataObject alloc] init] DeleteDataAllItemsInSpecificHome_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) doc:doc snapshot:snapshot homeID:homeID collection:collection completionHandler:^(BOOL finished) {
                        
                        finishBlock(YES);
                        
                    }];
                    
                }];
                
                
                /*
                 //
                 //
                 //Remove Item Silent Notifications
                 //
                 //
                 */
                [[[DeleteDataObject alloc] init] DeleteDataAllItemsInSpecificHome_RemoveItemSilentNotifications:doc itemType:itemType collection:collection userID:userID homeMembersDict:homeMembersDict topicDict:topicDict completionHandler:^(BOOL finished) {
                    
                    [[[DeleteDataObject alloc] init] DeleteDataAllItemsInSpecificHome_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) doc:doc snapshot:snapshot homeID:homeID collection:collection completionHandler:^(BOOL finished) {
                        
                        finishBlock(YES);
                        
                    }];
                    
                }];
                
                
                /*
                 //
                 //
                 //Remove Scheduled Start Notifications
                 //
                 //
                 */
                [[[DeleteDataObject alloc] init] DeleteDataAllItemsInSpecificHome_RemoveScheuledStartNotifications:doc itemType:itemType homeMembersDict:homeMembersDict topicDict:topicDict completionHandler:^(BOOL finished) {
                    
                    [[[DeleteDataObject alloc] init] DeleteDataAllItemsInSpecificHome_CompletionBlock:totalQueries completedQueries:(completedQueries+=1) doc:doc snapshot:snapshot homeID:homeID collection:collection completionHandler:^(BOOL finished) {
                        
                        finishBlock(YES);
                        
                    }];
                    
                }];
                
            }
            
        }
        
    }];
    
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Internal Method
#pragma mark
#pragma mark
#pragma mark -

#pragma mark Homes

#pragma mark Delete Home - Delete Home Completely

-(void)DeleteHome_DeleteHomeActivity:(NSString *)homeID completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[DeleteDataObject alloc] init] DeleteDataHomeActivity:homeID completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)DeleteHome_DeleteHomeNotifications:(NSString *)homeID completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[DeleteDataObject alloc] init] DeleteDataHomeNotifications:homeID completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)DeleteHome_DeleteHomeItems:(NSString *)homeID collection:(NSString *)collection itemType:(NSString *)itemType userID:(NSString *)userID homeMembersDict:(NSMutableDictionary *)homeMembersDict topicDict:(NSMutableDictionary *)topicDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[DeleteDataObject alloc] init] DeleteDataAllItemsInSpecificHome:homeID collection:collection itemType:itemType userID:userID homeMembersDict:homeMembersDict topicDict:topicDict QueryAssignedToNewHomeMember:NO QueryAssignedTo:NO queryAssignedToUserID:@"" completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)DeleteHome_DeleteHomeGroupChats:(NSString *)homeID completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[DeleteDataObject alloc] init] DeleteDataGroupChatsInSpecificHome:homeID completionHandler:^(BOOL finished, NSError * _Nonnull error) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)DeleteHome_DeleteHomeImage:(NSString *)homeID completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[DeleteDataObject alloc] init] DeleteDataHomeImage:homeID completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)DeleteHome_DeleteHomeData:(NSString *)homeID completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[DeleteDataObject alloc] init] DeleteDataHome:homeID completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)DeleteHome_CompletionBlock:(int)totalQueries completedQueries:(int)completedQueries homeID:(NSString *)homeID completionHandler:(void (^)(BOOL finished))finishBlock {
    
    if (totalQueries == completedQueries) {
        
        /*
         //
         //
         //Delete Home Data
         //
         //
         */
        [[[DeleteDataObject alloc] init] DeleteHome_DeleteHomeData:homeID completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    }
    
}

#pragma mark Items

#pragma mark Delete User - Remove User From Item

-(NSMutableDictionary *)DeleteUserFromAssignedTo_GenerateDictWithUserRemoved:(NSMutableDictionary *)dictToUse homeMembersDict:(NSMutableDictionary *)homeMembersDict userIDToRemove:(NSString *)userIDToRemove itemType:(NSString *)itemType itemAssignedToUsername:(NSMutableArray *)itemAssignedToUsername {
    
    NSDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:userIDToRemove homeMembersDict:homeMembersDict];
    NSString *usernameToRemove = dataDict[@"Username"];
    
    
    
    NSString *itemDueDate = dictToUse[@"ItemDueDate"] ? dictToUse[@"ItemDueDate"] : @"";
    NSString *itemCompleteAsNeeded = dictToUse[@"ItemCompleteAsNeeded"] ? dictToUse[@"ItemCompleteAsNeeded"] : @"";
    NSString *itemTakeTurns = dictToUse[@"ItemTakeTurns"] ? dictToUse[@"ItemTakeTurns"] : @"";
    __block NSString *itemTurnUserID = [[[GeneralObject alloc] init] GenerateCurrentUserTurnFromDict:[dictToUse mutableCopy] homeMembersDict:homeMembersDict itemType:itemType];
    NSString *itemRepeats = dictToUse[@"ItemRepeats"] ? dictToUse[@"ItemRepeats"] : @"";
    NSString *itemRepeatIfCompletedEarly = dictToUse[@"ItemRepeatIfCompletedEarly"] ? dictToUse[@"ItemRepeatIfCompletedEarly"] : @"";
    
    __block NSMutableArray *itemAssignedTo = dictToUse[@"ItemAssignedTo"] ? [dictToUse[@"ItemAssignedTo"] mutableCopy] : [NSMutableArray array];
    NSMutableDictionary *itemCompletedDict = dictToUse[@"ItemCompletedDict"] ? dictToUse[@"ItemCompletedDict"] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemInProgressDict = dictToUse[@"ItemInProgressDict"] ? [dictToUse[@"ItemInProgressDict"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemWontDo = dictToUse[@"ItemWontDo"] ? [dictToUse[@"ItemWontDo"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemSubTasks = dictToUse[@"ItemSubTasks"] ? [dictToUse[@"ItemSubTasks"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *itemApprovalRequests = dictToUse[@"ItemApprovalRequests"] ? [dictToUse[@"ItemApprovalRequests"] mutableCopy] : [NSMutableDictionary dictionary];
 
    
    
    for (NSString *userID in [itemAssignedTo mutableCopy]) {
        if ([userID isEqualToString:userIDToRemove]) {
            if ([itemAssignedTo containsObject:userIDToRemove]) {
                [itemAssignedTo removeObject:userIDToRemove];
            }
        }
    }
    
    for (NSString *userID in [itemAssignedToUsername mutableCopy]) {
        if ([userID isEqualToString:userIDToRemove]) {
            if ([itemAssignedToUsername containsObject:usernameToRemove]) {
                [itemAssignedToUsername removeObject:usernameToRemove];
            }
        }
    }
    
    for (NSString *userID in [[itemCompletedDict mutableCopy] allKeys]) {
        if ([userID isEqualToString:userIDToRemove]) {
            if ([[itemCompletedDict allKeys] containsObject:userIDToRemove]) {
                [itemCompletedDict removeObjectForKey:userIDToRemove];
            }
        }
    }
    
    for (NSString *userID in [[itemInProgressDict mutableCopy] allKeys]) {
        if ([userID isEqualToString:userIDToRemove]) {
            if ([[itemInProgressDict allKeys] containsObject:userIDToRemove]) {
                [itemInProgressDict removeObjectForKey:userIDToRemove];
            }
        }
    }
    
    for (NSString *userID in [[itemWontDo mutableCopy] allKeys]) {
        if ([userID isEqualToString:userIDToRemove]) {
            if ([[itemWontDo allKeys] containsObject:userIDToRemove]) {
                [itemWontDo removeObjectForKey:userIDToRemove];
            }
        }
    }
    
    for (NSString *userID in [[itemApprovalRequests mutableCopy] allKeys]) {
        if ([userID isEqualToString:userIDToRemove]) {
            if ([[itemApprovalRequests allKeys] containsObject:userIDToRemove]) {
                [itemApprovalRequests removeObjectForKey:userIDToRemove];
            }
        }
    }
    
    
    
    NSMutableDictionary *itemSubTasksDict = [itemSubTasks mutableCopy];
    
    for (NSString *subtask in [itemSubTasksDict allKeys]) {
        
        NSMutableDictionary *subtaskCompletedDict = itemSubTasksDict[subtask][@"Completed Dict"] ? [itemSubTasksDict[subtask][@"Completed Dict"] mutableCopy] : [NSMutableDictionary dictionary];
        NSMutableDictionary *subtaskInProgressDict = itemSubTasksDict[subtask][@"In Progress Dict"] ? [itemSubTasksDict[subtask][@"In Progress Dict"] mutableCopy] : [NSMutableDictionary dictionary];
        NSMutableDictionary *subtaskWontDoDict = itemSubTasksDict[subtask][@"Wont Do"] ? [itemSubTasksDict[subtask][@"Wont Do"] mutableCopy] : [NSMutableDictionary dictionary];
        
        for (NSString *userID in [[subtaskCompletedDict allKeys] mutableCopy]) {
            if ([userID isEqualToString:userIDToRemove]) {
                if ([[subtaskCompletedDict allKeys] containsObject:userID]) {
                    [subtaskCompletedDict removeObjectForKey:userID];
                }
            }
        }
        
        for (NSString *userID in [[subtaskInProgressDict allKeys] mutableCopy]) {
            if ([userID isEqualToString:userIDToRemove]) {
                if ([[subtaskInProgressDict allKeys] containsObject:userID]) {
                    [subtaskInProgressDict removeObjectForKey:userID];
                }
            }
        }
        
        for (NSString *userID in [[subtaskWontDoDict allKeys] mutableCopy]) {
            if ([userID isEqualToString:userIDToRemove]) {
                if ([[subtaskWontDoDict allKeys] containsObject:userID]) {
                    [subtaskWontDoDict removeObjectForKey:userID];
                }
            }
        }
        
        NSMutableDictionary *tempDict = [itemSubTasksDict[subtask] mutableCopy];
        [tempDict setObject:subtaskCompletedDict forKey:@"Completed Dict"];
        itemSubTasksDict[subtask] = [tempDict mutableCopy];
        
        tempDict = [itemSubTasksDict[subtask] mutableCopy];
        [tempDict setObject:subtaskInProgressDict forKey:@"In Progress Dict"];
        itemSubTasksDict[subtask] = [tempDict mutableCopy];
        
        tempDict = [itemSubTasksDict[subtask] mutableCopy];
        [tempDict setObject:subtaskWontDoDict forKey:@"Wont Do"];
        itemSubTasksDict[subtask] = [tempDict mutableCopy];
        
    }
    
    itemSubTasks = [itemSubTasksDict mutableCopy];
    
    
    
    if ([userIDToRemove isEqualToString:itemTurnUserID]) {
        
        itemTurnUserID = [[[GeneralObject alloc] init] GenerateNextUsersTurn:itemAssignedTo itemAssignedToOriginal:itemAssignedTo homeMembersDict:homeMembersDict itemTakeTurns:itemTakeTurns itemTurnUserID:itemTurnUserID];
        
        if (itemTurnUserID.length == 0 && [itemTakeTurns isEqualToString:@"Yes"]) {
            
            itemTurnUserID = [[[GeneralObject alloc] init] GenerateCurrentUsersTurn:itemDueDate itemRepeats:itemRepeats itemRepeatIfCompletedEarly:itemRepeatIfCompletedEarly itemCompleteAsNeeded:itemCompleteAsNeeded itemTakeTurns:itemTakeTurns itemCompletedDict:itemCompletedDict itemAssignedToArray:itemAssignedTo itemType:itemType itemTurnUserID:itemTurnUserID homeMembersDict:homeMembersDict];
            
        }
        
        [dictToUse setObject:itemTurnUserID forKey:@"ItemTurnUserID"];
        
    }
    
    
    
    [dictToUse setObject:itemAssignedTo forKey:@"ItemAssignedTo"];
    [dictToUse setObject:@"No" forKey:@"ItemAssignedToAnybody"];
    [dictToUse setObject:itemCompletedDict forKey:@"ItemCompletedDict"];
    [dictToUse setObject:itemInProgressDict forKey:@"ItemInProgressDict"];
    [dictToUse setObject:itemSubTasks forKey:@"ItemSubTasks"];
    [dictToUse setObject:itemApprovalRequests forKey:@"ItemApprovalRequests"];
    
    return dictToUse;
}

-(void)DeleteUserFromAssignedTo_UpdateItemData:(NSMutableDictionary *)dictToUse itemTypeCollection:(NSString *)itemTypeCollection completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
        
        NSString *itemID = dictToUse[@"ItemID"] ? dictToUse[@"ItemID"] : @"xxx";
        NSString *itemOccurrenceID = dictToUse[@"ItemOccurrenceID"] ? dictToUse[@"ItemOccurrenceID"] : @"xxx";
        NSString *itemTurnUserID = dictToUse[@"ItemTurnUserID"] ? dictToUse[@"ItemTurnUserID"] : @"xxx";
        NSMutableArray *itemAssignedTo = dictToUse[@"ItemAssignedTo"] ? dictToUse[@"ItemAssignedTo"] : [NSMutableArray array];
        
        
        NSMutableDictionary *itemCompletedDict = dictToUse[@"ItemCompletedDict"] ? dictToUse[@"ItemCompletedDict"] : [NSMutableDictionary dictionary];
        NSMutableDictionary *itemInProgressDict = dictToUse[@"ItemInProgressDict"] ? [dictToUse[@"ItemInProgressDict"] mutableCopy] : [NSMutableDictionary dictionary];
        NSMutableDictionary *itemWontDo = dictToUse[@"ItemWontDo"] ? [dictToUse[@"ItemWontDo"] mutableCopy] : [NSMutableDictionary dictionary];
        NSMutableDictionary *itemSubTasks = dictToUse[@"ItemSubTasks"] ? [dictToUse[@"ItemSubTasks"] mutableCopy] : [NSMutableDictionary dictionary];
        NSMutableDictionary *itemApprovalRequests = dictToUse[@"ItemApprovalRequests"] ? [dictToUse[@"ItemApprovalRequests"] mutableCopy] : [NSMutableDictionary dictionary];
        
        itemCompletedDict = [[[GeneralObject alloc] init] GenerateDictWithoutEmptyKeys:[itemCompletedDict mutableCopy]] ? [[[[GeneralObject alloc] init] GenerateDictWithoutEmptyKeys:[itemCompletedDict mutableCopy]] mutableCopy] : [NSMutableDictionary dictionary];
        itemInProgressDict = [[[GeneralObject alloc] init] GenerateDictWithoutEmptyKeys:[itemInProgressDict mutableCopy]] ? [[[[GeneralObject alloc] init] GenerateDictWithoutEmptyKeys:[itemInProgressDict mutableCopy]] mutableCopy] : [NSMutableDictionary dictionary];
        itemWontDo = [[[GeneralObject alloc] init] GenerateDictWithoutEmptyKeys:[itemWontDo mutableCopy]] ? [[[[GeneralObject alloc] init] GenerateDictWithoutEmptyKeys:[itemWontDo mutableCopy]] mutableCopy] : [NSMutableDictionary dictionary];
        itemApprovalRequests = [[[GeneralObject alloc] init] GenerateDictWithoutEmptyKeys:[itemApprovalRequests mutableCopy]] ? [[[[GeneralObject alloc] init] GenerateDictWithoutEmptyKeys:[itemApprovalRequests mutableCopy]] mutableCopy] : [NSMutableDictionary dictionary];
        
        NSDictionary *dataDict = @{@"ItemCompletedDict" : itemCompletedDict ? itemCompletedDict : [NSMutableDictionary dictionary],
                                   @"ItemInProgressDict" : itemInProgressDict ? itemInProgressDict : [NSMutableDictionary dictionary],
                                   @"ItemWontDo" : itemWontDo ? itemWontDo : [NSMutableDictionary dictionary],
                                   @"ItemSubTasks" : itemSubTasks ? itemSubTasks : [NSMutableDictionary dictionary],
                                   @"ItemApprovalRequests" : itemApprovalRequests ? itemApprovalRequests : [NSMutableDictionary dictionary],
                                   @"ItemAssignedTo" : itemAssignedTo, @"ItemTurnUserID" : itemTurnUserID,
                                   @"ItemAssignedToAnybody" : @"No"};
        
        
        [[[SetDataObject alloc] init] UpdateDataEditItem:dataDict itemID:itemID itemOccurrenceID:itemOccurrenceID collection:itemTypeCollection homeID:homeID completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)DeleteUserFromAssignedTo_UpdateTopicData:(NSMutableDictionary *)dictToUse userIDToRemove:(NSString *)userIDToRemove completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *myUserID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
        
        NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
        
        NSString *itemID = dictToUse[@"ItemID"] ? dictToUse[@"ItemID"] : @"";
        NSString *itemOccurrenceID = dictToUse[@"ItemOccurrenceID"] ? dictToUse[@"ItemOccurrenceID"] : @"";
        NSMutableArray *itemAssignedTo = dictToUse[@"ItemAssignedTo"] ? dictToUse[@"ItemAssignedTo"] : [NSMutableArray array];
        
        BOOL UnsubscribeFromTopic = ([userIDToRemove isEqualToString:myUserID]);
        
        [[[SetDataObject alloc] init] SubsribeOrUnsubscribeAndUpdateTopic:homeID topicID:itemID itemOccurrenceID:itemOccurrenceID dataDict:@{@"TopicAssignedTo" : itemAssignedTo} SubscribeToTopic:NO UnsubscribeFromTopic:UnsubscribeFromTopic completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)DeleteUserFromAssignedTo_SendPushNotifications:(NSMutableDictionary *)dictToUse keyArray:(NSArray *)keyArray itemType:(NSString *)itemType itemTypeCollection:(NSString *)itemTypeCollection userIDToRemove:(NSString *)userIDToRemove homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType topicDict:(NSMutableDictionary *)topicDict allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
    
    NSString *itemName = dictToUse[@"ItemName"] ? dictToUse[@"ItemName"] : @"";
    
    NSDictionary *dataDict = [[[GeneralObject alloc] init] GenerateSpecificUserDataBasedOnKey:@"UserID" object:userIDToRemove homeMembersDict:homeMembersDict];
    NSString *usernameToRemove = dataDict[@"Username"];
    
    NSString *notificationTitle = [NSString stringWithFormat:@"\"%@\"", itemName];
    NSString *notificationBody = [NSString stringWithFormat:@"%@ was removed from this %@", usernameToRemove, [itemType lowercaseString]];
    
    
    
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

-(void)DeleteUserFromAssignedTo_ResetItemSilentNotifications:(NSMutableDictionary *)dictToUse keyArray:(NSArray *)keyArray itemType:(NSString *)itemType homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType topicDict:(NSMutableDictionary *)topicDict allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays userIDToRemove:(NSString *)userIDToRemove completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *itemCreatedBy = dictToUse[@"ItemCreatedBy"] ? dictToUse[@"ItemCreatedBy"] : @"";
        NSMutableArray *itemAssignedTo = dictToUse[@"ItemAssignedTo"] ? dictToUse[@"ItemAssignedTo"] : [NSMutableArray array];
        
        NSMutableArray *userIDArray = [itemAssignedTo mutableCopy];
        NSMutableArray *userIDToRemoveArray = [userIDToRemove isEqualToString:itemCreatedBy] == NO ? [@[userIDToRemove] mutableCopy] : [NSMutableArray array];
        
        [userIDArray addObject:itemCreatedBy];
        
        [[[NotificationsObject alloc] init] ResetLocalNotificationReminderNotification:dictToUse homeMembersDict:homeMembersDict userIDArray:userIDArray userIDToRemoveArray:userIDToRemoveArray notificationSettingsDict:notificationSettingsDict allItemTagsArrays:allItemTagsArrays itemType:itemType notificationType:notificationType topicDict:topicDict completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)DeleteUserFromAssignedTo_CompletionBlock:(int)totalQueries completedQueries:(int)completedQueries dictToUse:(NSMutableDictionary *)dictToUse completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDictToUse))finishBlock {
    
    if (totalQueries == completedQueries) {
        
        finishBlock(YES, dictToUse);
        
    }
    
}

#pragma mark Delete Item - Delete Specific Item Entirely

-(void)DeleteDataItemCompletely_DeleteItemData:(NSMutableDictionary *)dictToUse homeID:(NSString *)homeID itemType:(NSString *)itemType completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *collection = [NSString stringWithFormat:@"%@s", itemType];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *itemID = dictToUse[@"ItemID"] ? dictToUse[@"ItemID"] : @"xxx";
        NSString *itemOccurrenceID = dictToUse[@"ItemOccurrenceID"] ? dictToUse[@"ItemOccurrenceID"] : @"xxx";
        
        if (itemOccurrenceID.length == 0) {
            
            [[[DeleteDataObject alloc] init] DeleteDataItem:collection itemID:itemID itemOccurrenceID:itemOccurrenceID homeID:homeID completionHandler:^(BOOL finished) {
                
                finishBlock(YES);
                
            }];
            
        } else {
            
            [[[SetDataObject alloc] init] UpdateDataEditItem:@{@"ItemDeleted" : @"Yes"} itemID:itemID itemOccurrenceID:itemOccurrenceID collection:collection homeID:homeID completionHandler:^(BOOL finished) {
                
                finishBlock(YES);
                
            }];
            
        }
        
    });
    
}

-(void)DeleteDataItemCompletely_UpdateTopicData:(NSMutableDictionary *)dictToUse homeID:(NSString *)homeID completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *itemID = dictToUse[@"ItemID"] ? dictToUse[@"ItemID"] : @"";
        NSString *itemOccurrenceID = dictToUse[@"ItemOccurrenceID"] ? dictToUse[@"ItemOccurrenceID"] : @"";
        NSString *itemCreatedBy = dictToUse[@"ItemCreatedBy"] ? dictToUse[@"ItemCreatedBy"] : @"";
        NSMutableArray *itemAssignedTo = dictToUse[@"ItemAssignedTo"] ? dictToUse[@"ItemAssignedTo"] : [NSMutableArray array];
        
        NSString *myUserID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
        
        BOOL UnsubscribeFromTopic = ([itemAssignedTo containsObject:myUserID] || [itemCreatedBy isEqualToString:myUserID]);
        
        [[[SetDataObject alloc] init] SubsribeOrUnsubscribeAndUpdateTopic:homeID topicID:itemID itemOccurrenceID:itemOccurrenceID dataDict:@{@"TopicDeleted" : @"Yes"} SubscribeToTopic:NO UnsubscribeFromTopic:UnsubscribeFromTopic completionHandler:^(BOOL finished) {
      
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)DeleteDataItemCompletely_DeleteCommmentData:(NSMutableDictionary *)dictToUse homeID:(NSString *)homeID itemType:(NSString *)itemType completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *itemID = dictToUse[@"ItemID"] ? dictToUse[@"ItemID"] : @"";
        NSString *itemOccurrenceID = dictToUse[@"ItemOccurrenceID"] ? dictToUse[@"ItemOccurrenceID"] : @"";
        
        if (itemOccurrenceID.length == 0) {
         
            [[[DeleteDataObject alloc] init] DeleteAllMessagesInComments:homeID itemID:itemID itemType:itemType completionHandler:^(BOOL finished) {
                
                finishBlock(YES);
                
            }];
            
        } else {
            
            finishBlock(YES);
            
        }
        
    });
    
}

-(void)DeleteDataItemCompletely_DeleteItemActivityData:(NSMutableDictionary *)dictToUse homeID:(NSString *)homeID itemType:(NSString *)itemType completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *collection = [NSString stringWithFormat:@"%@s", itemType];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *itemID = dictToUse[@"ItemID"] ? dictToUse[@"ItemID"] : @"xxx";
        NSString *itemOccurrenceID = dictToUse[@"ItemOccurrenceID"] ? dictToUse[@"ItemOccurrenceID"] : @"xxx";
        
        if (itemOccurrenceID.length == 0) {
            
            [[[DeleteDataObject alloc] init] DeleteDataItemActivity:collection itemID:itemID itemOccurrenceID:itemOccurrenceID homeID:homeID completionHandler:^(BOOL finished) {
                
                finishBlock(YES);
                
            }];
            
        } else {
            
            finishBlock(YES);
            
        }
        
    });
    
}

-(void)DeleteDataItemCompletely_DeleteOccurrenceData:(NSMutableDictionary *)dictToUse homeID:(NSString *)homeID itemType:(NSString *)itemType completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *collection = [NSString stringWithFormat:@"%@s", itemType];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *itemID = dictToUse[@"ItemID"] ? dictToUse[@"ItemID"] : @"";
        NSString *itemOccurrenceID = dictToUse[@"ItemOccurrenceID"] ? dictToUse[@"ItemOccurrenceID"] : @"";
        
        if (itemOccurrenceID.length == 0) {
            
            NSArray *keyArray = [[[GeneralObject alloc] init] GenerateKeyArray];
            
            [[[DeleteDataObject alloc] init] DeleteDataItemOccurrences:collection itemID:itemID itemOccurrenceID:itemOccurrenceID homeID:homeID keyArray:keyArray completionHandler:^(BOOL finished) {
                
                finishBlock(YES);
                
            }];
            
        } else {
            
            finishBlock(YES);
            
        }
        
    });
    
}

-(void)DeleteDataItemCompletely_DeleteImageData:(NSMutableDictionary *)dictToUse itemType:(NSString *)itemType completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *itemUniqueID = dictToUse[@"ItemUniqueID"] ? dictToUse[@"ItemUniqueID"] : @"xxx";
        
        [[[DeleteDataObject alloc] init] DeleteDataItemImage:itemUniqueID itemType:itemType completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
   
    });
    
}

-(void)DeleteDataItemCompletely_UpdateTaskListData:(NSMutableDictionary *)dictToUse taskListDict:(NSMutableDictionary *)taskListDict completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningUpdatedTaskListDict))finishBlock {
   
    NSString *itemUniqueID = dictToUse[@"ItemUniqueID"] ? dictToUse[@"ItemUniqueID"] : @"xxx";
    
    [[[GeneralObject alloc] init] AddOrRemoveTaskToAllTaskListsThatContainSpecificItem:taskListDict newTaskListName:@"" itemUniqueIDDict:@{itemUniqueID : @{@"SpecificItemUniqueID" : @""}} AddTask:NO completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningUpdatedTaskListDict) {
        
        finishBlock(YES, returningUpdatedTaskListDict);
        
    }];
    
}

-(void)DeleteDataItemCompletely_DeleteAlgoliaData:(NSMutableDictionary *)dictToUse completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[DeleteDataObject alloc] init] DeleteDataDeleteAlgoliaObject:dictToUse[@"ItemUniqueID"] completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)DeleteDataItemCompletely_SendPushNotifications:(NSMutableDictionary *)dictToUse homeID:(NSString *)homeID itemType:(NSString *)itemType homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationItemType:(NSString *)notificationItemType notificationType:(NSString *)notificationType topicDict:(NSMutableDictionary *)topicDict allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays completionHandler:(void (^)(BOOL finished))finishBlock {
       
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *itemOccurrenceID = dictToUse[@"ItemOccurrenceID"] ? dictToUse[@"ItemOccurrenceID"] : @"";
        
        if (itemOccurrenceID.length == 0) {
            
            NSMutableArray *itemAssignedTo = dictToUse[@"ItemAssignedTo"] ? [dictToUse[@"ItemAssignedTo"] mutableCopy] : [NSMutableArray array];
            NSString *itemName = dictToUse[@"ItemName"] ? dictToUse[@"ItemName"] : @"";
            
            
            
            NSString *pushNotificationTitle = [NSString stringWithFormat:@"\"%@\"", itemName];
            NSString *pushNotificationBody = [[[NotificationsObject alloc] init] GeneratePushNotificationAddItemBody:NO EditItem:NO DeleteItem:YES NotificationItem:NO NobodyAssigned:NO userIDArray:itemAssignedTo];
            
            NSString *notificationTitle = [NSString stringWithFormat:@"\"%@\"", itemName];
            NSString *notificationBody = [[[NotificationsObject alloc] init] GeneratePushNotificationAddItemBody:NO EditItem:NO DeleteItem:YES NotificationItem:YES NobodyAssigned:NO userIDArray:itemAssignedTo];
            
            
            
            NSMutableArray *usersToSendNotificationTo = [itemAssignedTo mutableCopy];
            
            NSArray *addTheseUsers = @[dictToUse[@"ItemCreatedBy"]];
            NSArray *removeTheseUsers = @[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx"];
            
            usersToSendNotificationTo = [[[[NotificationsObject alloc] init] AddAndRemoveSpecificUsersFromArray:usersToSendNotificationTo addTheseUsers:addTheseUsers removeTheseUsers:removeTheseUsers] mutableCopy];
            
            
            
            [[[NotificationsObject alloc] init] SendPushNotificationToArrayOfUsers_Items:usersToSendNotificationTo
                                                                               dictToUse:dictToUse
                                                                                  homeID:homeID homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict
                                                                notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType
                                                                               topicDict:topicDict
                                                                    allItemTagsArrays:allItemTagsArrays
                                                                   pushNotificationTitle:pushNotificationTitle pushNotificationBody:pushNotificationBody
                                                                       notificationTitle:notificationTitle notificationBody:notificationBody
                                                                 SetDataHomeNotification:YES
                                                                    RemoveUsersNotInHome:YES
                                                                       completionHandler:^(BOOL finished) {
                finishBlock(YES);
                
            }];
            
        } else {
            
            finishBlock(YES);
            
        }
        
    });
    
}

-(void)DeleteDataItemCompletely_ResetItemNotifications:(NSMutableDictionary *)dictToUse keyArray:(NSArray *)keyArray itemType:(NSString *)itemType homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict notificationType:(NSString *)notificationType topicDict:(NSMutableDictionary *)topicDict allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *itemCreatedBy = dictToUse[@"ItemCreatedBy"] ? dictToUse[@"ItemCreatedBy"] : @"";
    NSMutableArray *itemAssignedTo = dictToUse[@"ItemAssignedTo"] ? [dictToUse[@"ItemAssignedTo"] mutableCopy] : [NSMutableArray array];
    
    [dictToUse setObject:@"Yes" forKey:@"ItemDeleted"];
    
    NSMutableArray *userIDArray = [NSMutableArray array];
    NSMutableArray *userIDToRemoveArray = [itemAssignedTo mutableCopy];
    
    [userIDToRemoveArray addObject:itemCreatedBy];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[NotificationsObject alloc] init] ResetLocalNotificationReminderNotification:dictToUse homeMembersDict:homeMembersDict userIDArray:userIDArray userIDToRemoveArray:userIDToRemoveArray notificationSettingsDict:notificationSettingsDict allItemTagsArrays:allItemTagsArrays itemType:itemType notificationType:notificationType topicDict:topicDict completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)DeleteDataItemCompletely_ResetScheduledStartNotifications:(NSMutableDictionary *)dictToUse itemType:(NSString *)itemType topicDict:(NSMutableDictionary *)topicDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    NSString *itemCreatedBy = dictToUse[@"ItemCreatedBy"] ? dictToUse[@"ItemCreatedBy"] : @"";
    NSMutableArray *itemAssignedTo = dictToUse[@"ItemAssignedTo"] ? [dictToUse[@"ItemAssignedTo"] mutableCopy] : [NSMutableArray array];
    
    [dictToUse setObject:@"Yes" forKey:@"ItemDeleted"];
    
    NSMutableArray *userIDArray = [NSMutableArray array];
    NSMutableArray *userIDToRemoveArray = [itemAssignedTo mutableCopy];
    
    [userIDToRemoveArray addObject:itemCreatedBy];
    
    BOOL TaskIsScheduledStart = [[[BoolDataObject alloc] init] TaskIsScheduledStart:dictToUse itemType:itemType];
    BOOL TaskIsScheduledStartHasPassed = [[[BoolDataObject alloc] init] TaskIsScheduledStartHasPassed:dictToUse itemType:itemType];
    
    if (TaskIsScheduledStart == YES && TaskIsScheduledStartHasPassed == NO) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [[[NotificationsObject alloc] init] ResetLocalNotificationScheduledStartNotifications:[dictToUse mutableCopy] itemType:itemType userIDArray:userIDArray userIDToRemoveArray:userIDToRemoveArray allItemTagsArrays:[NSMutableArray array] homeMembersArray:[NSMutableArray array] homeMembersDict:[NSMutableDictionary dictionary] notificationSettingsDict:[NSMutableDictionary dictionary] topicDict:topicDict completionHandler:^(BOOL finished) {
                
                finishBlock(YES);
                
            }];
            
        });
        
    } else {
        
        finishBlock(YES);
        
    }
    
}

-(void)DeleteDataItemCompletely_ResetCustomReminderNotifications:(NSMutableDictionary *)dictToUse itemType:(NSString *)itemType homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays completionHandler:(void (^)(BOOL finished))finishBlock {

    [[[NotificationsObject alloc] init] ResetLocalNotificationCustomReminderNotification_LocalOnly:@"" itemType:itemType dictToUse:dictToUse homeMembersDict:homeMembersDict homeMembersArray:homeMembersArray allItemTagsArrays:allItemTagsArrays completionHandler:^(BOOL finished) {
        
        finishBlock(YES);
        
    }];
    
}

-(void)DeleteDataItemCompletely_CompletionBlock:(int)totalQueries completedQueries:(int)completedQueries dictToUse:(NSMutableDictionary *)dictToUse homeID:(NSString *)homeID itemType:(NSString *)itemType completionHandler:(void (^)(BOOL finished))finishBlock {
    
    if (totalQueries == completedQueries) {
       
        /*
         //
         //
         //Delete Item Data
         //
         //
         */
        [[[DeleteDataObject alloc] init] DeleteDataItemCompletely_DeleteItemData:dictToUse homeID:homeID itemType:itemType completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    }
    
}

#pragma mark Delete Home - Delete All Items In Specific Home

-(void)DeleteDataAllItemsInSpecificHome_DeleteItemOccurrences:(FIRDocumentSnapshot *)doc homeID:(NSString *)homeID collection:(NSString *)collection completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSArray *keyArray = [[[GeneralObject alloc] init] GenerateKeyArrayManually:[collection isEqualToString:@"Chore"] ? YES : NO Expense:[collection isEqualToString:@"Expense"] ? YES : NO List:[collection isEqualToString:@"List"] ? YES : NO Home:NO];
        
        NSString *itemID = doc.data[@"ItemID"] ? doc.data[@"ItemID"] : @"";
        NSString *itemOccurrenceID = doc.data[@"ItemOccurrenceID"] ? doc.data[@"ItemOccurrenceID"] : @"";
        
        [[[DeleteDataObject alloc] init] DeleteDataItemOccurrences:collection itemID:itemID itemOccurrenceID:itemOccurrenceID homeID:homeID keyArray:keyArray completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)DeleteDataAllItemsInSpecificHome_DeleteItemActivity:(FIRDocumentSnapshot *)doc homeID:(NSString *)homeID collection:(NSString *)collection completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *itemID = doc.data[@"ItemID"] ? doc.data[@"ItemID"] : @"";
        NSString *itemOccurrenceID = doc.data[@"ItemOccurrenceID"] ? doc.data[@"ItemOccurrenceID"] : @"";
        
        [[[DeleteDataObject alloc] init] DeleteDataItemActivity:collection itemID:itemID itemOccurrenceID:itemOccurrenceID homeID:homeID completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)DeleteDataAllItemsInSpecificHome_DeleteItemComments:(FIRDocumentSnapshot *)doc homeID:(NSString *)homeID itemType:(NSString *)itemType completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *itemID = doc.data[@"ItemID"] ? doc.data[@"ItemID"] : @"";
        
        [[[DeleteDataObject alloc] init] DeleteAllMessagesInComments:homeID itemID:itemID itemType:itemType completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
    
}

-(void)DeleteDataAllItemsInSpecificHome_DeleteItemImageData:(FIRDocumentSnapshot *)doc itemType:(NSString *)itemType completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *itemUniqueID = doc.data[@"ItemUniqueID"] ? doc.data[@"ItemUniqueID"] : @"";
        
        [[[DeleteDataObject alloc] init] DeleteDataItemImage:itemUniqueID itemType:itemType completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
    
}

-(void)DeleteDataAllItemsInSpecificHome_DeleteItemData:(FIRDocumentSnapshot *)doc homeID:(NSString *)homeID collection:(NSString *)collection completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *itemID = doc.data[@"ItemID"] ? doc.data[@"ItemID"] : @"";
        NSString *itemOccurrenceID = doc.data[@"ItemOccurrenceID"] ? doc.data[@"ItemOccurrenceID"] : @"";
       
        [[[DeleteDataObject alloc] init] DeleteDataItem:collection itemID:itemID itemOccurrenceID:itemOccurrenceID homeID:homeID completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
    
}

-(void)DeleteDataAllItemsInSpecificHome_UpdateTopicData:(FIRDocumentSnapshot *)doc homeID:(NSString *)homeID collection:(NSString *)collection completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *itemID = doc.data[@"ItemID"] ? doc.data[@"ItemID"] : @"";
        NSString *itemOccurrenceID = doc.data[@"ItemOccurrenceID"] ? doc.data[@"ItemOccurrenceID"] : @"";
        NSString *itemCreatedBy = doc.data[@"ItemCreatedBy"] ? doc.data[@"ItemCreatedBy"] : @"";
        NSMutableArray *itemAssignedTo = doc.data[@"ItemAssignedTo"] ? doc.data[@"ItemAssignedTo"] : [NSMutableArray array];
        
        NSString *myUserID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
        
        BOOL UnsubscribeFromTopic = ([itemAssignedTo containsObject:myUserID] || [itemCreatedBy isEqualToString:myUserID]);
        
        [[[SetDataObject alloc] init] SubsribeOrUnsubscribeAndUpdateTopic:homeID topicID:itemID itemOccurrenceID:itemOccurrenceID dataDict:@{@"TopicDeleted" : @"Yes"} SubscribeToTopic:NO UnsubscribeFromTopic:UnsubscribeFromTopic completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
    
    
}

-(void)DeleteDataAllItemsInSpecificHome_RemoveItemSilentNotifications:(FIRDocumentSnapshot *)doc itemType:(NSString *)itemType collection:(NSString *)collection userID:(NSString *)userID homeMembersDict:(NSMutableDictionary *)homeMembersDict topicDict:(NSMutableDictionary *)topicDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *itemCreatedBy = doc.data[@"ItemCreatedBy"] ? doc.data[@"ItemCreatedBy"] : @"";
        NSMutableArray *itemAssignedTo = doc.data[@"ItemAssignedTo"] ? doc.data[@"ItemAssignedTo"] : [NSMutableArray array];
        
        [itemAssignedTo addObject:itemCreatedBy];
        
        NSMutableDictionary *singleObjectItemDict = doc.data ? [doc.data mutableCopy] : [NSMutableArray array];
        [singleObjectItemDict setObject:@"Yes" forKey:@"ItemDeleted"];
        
        NSMutableArray *userIDArray = [NSMutableArray array];
        NSMutableArray *userIDToRemoveArray = [itemAssignedTo mutableCopy];
        
        [userIDToRemoveArray addObject:itemCreatedBy];
        
        [[[NotificationsObject alloc] init] ResetLocalNotificationReminderNotification:singleObjectItemDict homeMembersDict:homeMembersDict userIDArray:userIDArray userIDToRemoveArray:userIDToRemoveArray notificationSettingsDict:[NSMutableDictionary dictionary] allItemTagsArrays:[NSMutableArray array] itemType:itemType notificationType:@"" topicDict:topicDict completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)DeleteDataAllItemsInSpecificHome_RemoveScheuledStartNotifications:(FIRDocumentSnapshot *)doc itemType:(NSString *)itemType homeMembersDict:(NSMutableDictionary *)homeMembersDict topicDict:(NSMutableDictionary *)topicDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *itemCreatedBy = doc.data[@"ItemCreatedBy"] ? doc.data[@"ItemCreatedBy"] : @"";
        NSMutableArray *itemAssignedTo = doc.data[@"ItemAssignedTo"] ? [doc.data[@"ItemAssignedTo"] mutableCopy] : [NSMutableArray array];
        
        BOOL TaskIsScheduledStart = [[[BoolDataObject alloc] init] TaskIsScheduledStart:[doc.data mutableCopy] itemType:itemType];
        BOOL TaskIsScheduledStartHasPassed = [[[BoolDataObject alloc] init] TaskIsScheduledStartHasPassed:[doc.data mutableCopy] itemType:itemType];
        
        NSMutableDictionary *singleObjectItemDict = doc.data ? [doc.data mutableCopy] : [NSMutableArray array];
        [singleObjectItemDict setObject:@"Yes" forKey:@"ItemDeleted"];
        
        NSMutableArray *userIDArray = [NSMutableArray array];
        NSMutableArray *userIDToRemoveArray = [itemAssignedTo mutableCopy];
        
        [userIDToRemoveArray addObject:itemCreatedBy];
        
        if (TaskIsScheduledStart == YES && TaskIsScheduledStartHasPassed == NO) {
            
            [[[NotificationsObject alloc] init] ResetLocalNotificationScheduledStartNotifications:[singleObjectItemDict mutableCopy] itemType:itemType userIDArray:userIDArray userIDToRemoveArray:userIDToRemoveArray allItemTagsArrays:[NSMutableArray array] homeMembersArray:[NSMutableArray array] homeMembersDict:[NSMutableDictionary dictionary] notificationSettingsDict:[NSMutableDictionary dictionary] topicDict:topicDict completionHandler:^(BOOL finished) {

                finishBlock(YES);
                
            }];
            
        } else {
            
            finishBlock(YES);
            
        }
        
    });
    
}

-(void)DeleteDataAllItemsInSpecificHome_CompletionBlock:(int)totalQueries completedQueries:(int)completedQueries doc:(FIRDocumentSnapshot *)doc snapshot:(FIRQuerySnapshot * _Nonnull)snapshot homeID:(NSString *)homeID collection:(NSString *)collection completionHandler:(void (^)(BOOL finished))finishBlock {
    
    if (totalQueries == completedQueries) {
        
        /*
         //
         //
         //Delete Item Data
         //
         //
         */
        [[[DeleteDataObject alloc] init] DeleteDataAllItemsInSpecificHome_DeleteItemData:doc homeID:homeID collection:collection completionHandler:^(BOOL finished) {
            
            if (doc == [snapshot.documents lastObject]) {
                
                finishBlock(YES);
                
            }
            
        }];
        
    }
    
}

@end
