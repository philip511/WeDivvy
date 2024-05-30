//
//  GetDataObject.m
//  WeDivvy
//
//  Created by Philip Nagel on 9/14/21.
//

#import "GeneralObject.h"

#import <Contacts/Contacts.h>

#import "GetDataObject.h"
#import "SetDataObject.h"
#import "GeneralObject.h"
#import "BoolDataObject.h"
#import "NotificationsObject.h"

@implementation GetDataObject

#pragma mark - Activity

-(void)GetDataItemActivity:(NSString *)collection itemID:(NSString *)itemID homeID:(NSString *)homeID completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningActivityDict))finishBlock {
    
    NSArray *keyArray = [[[GeneralObject alloc] init] GenerateActivityKeyArray];
    
    NSMutableDictionary *activityDict = [NSMutableDictionary dictionary];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    BOOL ObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:itemID classArr:@[[NSString class]]];
    BOOL ObjectIsKindOfClassNo1 = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:collection classArr:@[[NSString class]]];
    
    itemID = itemID && ObjectIsKindOfClass == YES && [itemID length] > 0 ? itemID : @"xxx";
    collection = collection && ObjectIsKindOfClassNo1 == YES && [collection length] > 0 ? collection : @"xxx";
    
    
    [[[[[[defaultFirestore collectionWithPath:@"Homes"] documentWithPath:homeID] collectionWithPath:collection] documentWithPath:itemID] collectionWithPath:@"Activity"] getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        
        for (FIRDocumentSnapshot *doc in snapshot.documents) {
            
            for (NSString *key in keyArray) {
                
                NSMutableArray *arr = activityDict[key] ? [activityDict[key] mutableCopy] : [NSMutableArray array];
                id object = doc.data[key] ? doc.data[key] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                [arr addObject:object];
                [activityDict setObject:arr forKey:key];
                
                
            }
            
        }
        
        finishBlock(YES, activityDict);
        
    }];
    
}

-(void)GetDataHomeActivity:(NSString *)homeID completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningActivityDict))finishBlock {
    
    NSArray *keyArray = [[[GeneralObject alloc] init] GenerateActivityKeyArray];
    
    NSMutableDictionary *activityDict = [NSMutableDictionary dictionary];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[defaultFirestore collectionWithPath:@"Homes"] documentWithPath:homeID] collectionWithPath:@"Activity"] getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        
        for (FIRDocumentSnapshot *doc in snapshot.documents) {
            
            for (NSString *key in keyArray) {
                
                NSMutableArray *arr = activityDict[key] ? [activityDict[key] mutableCopy] : [NSMutableArray array];
                id object = doc.data[key] ? doc.data[key] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                [arr addObject:object];
                [activityDict setObject:arr forKey:key];
                
                
            }
            
        }
        
        finishBlock(YES, activityDict);
        
    }];
    
}

-(void)GetDataUnreadHomeActivity:(NSString *)homeID userID:(NSString *)userID completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningActivityDict))finishBlock {
    
    NSArray *keyArray = [[[GeneralObject alloc] init] GenerateActivityKeyArray];
    
    NSMutableDictionary *activityDict = [NSMutableDictionary dictionary];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[defaultFirestore collectionWithPath:@"Homes"] documentWithPath:homeID] collectionWithPath:@"Activity"] getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        
        for (FIRDocumentSnapshot *doc in snapshot.documents) {
            
            if (doc.data[@"ActivityRead"] && [doc.data[@"ActivityRead"] containsObject:userID] == NO) {
                
                for (NSString *key in keyArray) {
                    
                    NSMutableArray *arr = activityDict[key] ? [activityDict[key] mutableCopy] : [NSMutableArray array];
                    id object = doc.data[key] ? doc.data[key] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                    [arr addObject:object];
                    [activityDict setObject:arr forKey:key];
                    
                    
                }
                
            }
            
        }
        
        finishBlock(YES, activityDict);
        
    }];
    
}

#pragma mark - Core Data

-(void)GetDataCoreData:(NSString *)entity predicate:(NSPredicate * _Nullable)predicate keyArray:(NSArray *)keyArray completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDataDict))finishBlock {
    
    finishBlock(YES, [NSMutableDictionary dictionary]);
    
//    dispatch_async(dispatch_get_main_queue(), ^{
//
//        NSManagedObjectContext *managedObjectContext = [[[AppDelegate alloc] init] managedObjectContext];
//
//        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:entity];
//        if (predicate != nil) { fetchRequest.predicate = predicate; }
//
//        NSError *fetchError = nil;
//        NSArray *matchingItems = [managedObjectContext executeFetchRequest:fetchRequest error:&fetchError];
//
//        NSMutableDictionary *newItemsDict = [NSMutableDictionary dictionary];
//
//        if (!fetchError) {
//
//            for (NSManagedObject *itemObject in matchingItems) {
//
//                for (NSString *key in keyArray) {
//
//                    NSMutableArray *arr = newItemsDict[key] ? [newItemsDict[key] mutableCopy] : [NSMutableArray array];
//                    NSString *originalKey = [key mutableCopy];
//                    NSString *lowercaseFirstCharKey = [originalKey stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[originalKey substringToIndex:1] lowercaseString]];
//
//                    id object = [itemObject valueForKey:lowercaseFirstCharKey];
//
//                    if ([[[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key] isKindOfClass:[NSDictionary class]]) { object = [[[GeneralObject alloc] init] stringToDictionary:object]; }
//                    if ([[[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key] isKindOfClass:[NSArray class]]) { object = [[[GeneralObject alloc] init] stringToArray:object]; }
//
//                    if ([[[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key] isKindOfClass:[NSDictionary class]] == NO && [[[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key] isKindOfClass:[NSArray class]] == NO) { object = [itemObject valueForKey:lowercaseFirstCharKey] ? [itemObject valueForKey:lowercaseFirstCharKey] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key]; }
//
//                    [arr addObject:object];
//                    [newItemsDict setObject:arr forKey:key];
//
//                }
//
//            }
//
//        }
//
//        finishBlock(YES, newItemsDict);
//
//    });
    
}

-(void)GetDataCoreDataNo1:(NSString *)entity predicate:(NSPredicate * _Nullable)predicate keyArray:(NSArray *)keyArray managedObjectContext:(NSManagedObjectContext *)managedObjectContext completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDataDict))finishBlock {
    
    finishBlock(YES, [NSMutableDictionary dictionary]);
    
    //    dispatch_async(dispatch_get_main_queue(), ^{
    
//    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:entity];
//    if (predicate != nil) { fetchRequest.predicate = predicate; }
//
//    NSError *fetchError = nil;
//    NSArray *matchingItems = [managedObjectContext executeFetchRequest:fetchRequest error:&fetchError];
//
//    NSMutableDictionary *newItemsDict = [NSMutableDictionary dictionary];
//
//    if (!fetchError) {
//
//        for (NSManagedObject *itemObject in matchingItems) {
//
//            for (NSString *key in keyArray) {
//
//                NSMutableArray *arr = newItemsDict[key] ? [newItemsDict[key] mutableCopy] : [NSMutableArray array];
//                NSString *originalKey = [key mutableCopy];
//                NSString *lowercaseFirstCharKey = [originalKey stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[originalKey substringToIndex:1] lowercaseString]];
//
//                id object = [itemObject valueForKey:lowercaseFirstCharKey];
//
//                if ([[[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key] isKindOfClass:[NSDictionary class]]) { object = [[[GeneralObject alloc] init] stringToDictionary:object]; }
//                if ([[[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key] isKindOfClass:[NSArray class]]) { object = [[[GeneralObject alloc] init] stringToArray:object]; }
//
//                if ([[[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key] isKindOfClass:[NSDictionary class]] == NO && [[[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key] isKindOfClass:[NSArray class]] == NO) { object = [itemObject valueForKey:lowercaseFirstCharKey] ? [itemObject valueForKey:lowercaseFirstCharKey] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key]; }
//
//                [arr addObject:object];
//                [newItemsDict setObject:arr forKey:key];
//
//            }
//
//        }
//
//    }
//
//    finishBlock(YES, newItemsDict);
    
    //    });
    
}

#pragma mark - Chats

-(void)GetDataChatsInSpecificHome:(NSString *)homeID keyArray:(NSArray *)keyArray completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDataDict))finishBlock {
   
    __block NSMutableDictionary *dataDictLocal = [NSMutableDictionary dictionary];
    
    if (homeID == nil || homeID == NULL || homeID.length == 0) {
        homeID = @"xxx";
    }
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[defaultFirestore collectionWithPath:@"Homes"] documentWithPath:homeID] collectionWithPath:@"GroupChats"] getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        
        for (FIRDocumentSnapshot *doc in snapshot.documents) {
            
            //            if ((doc.data[@"ChatAssignedTo"] && [doc.data[@"ChatAssignedTo"] containsObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]]) ||
            //                (doc.data[@"ChatCreatedBy"] && [doc.data[@"ChatCreatedBy"] isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]])) {
            
            for (NSString *key in keyArray) {
                
                NSMutableArray *arr = dataDictLocal[key] ? [dataDictLocal[key] mutableCopy] : [NSMutableArray array];
                id object = doc.data[key] ? [doc.data[key] mutableCopy] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                [arr addObject:object];
                [dataDictLocal setObject:arr forKey:key];
                
            }
            
            //            }
            
        }
        
        finishBlock(YES, dataDictLocal);
        
    }];
    
}

-(void)GetDataChat:(NSString *)chatID homeID:(NSString *)homeID keyArray:(NSArray *)keyArray completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDataDict))finishBlock {
    
    NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[[defaultFirestore collectionWithPath:@"Homes"] documentWithPath:homeID] collectionWithPath:@"GroupChats"] documentWithPath:chatID] getDocumentWithCompletion:^(FIRDocumentSnapshot * _Nullable snapshot, NSError * _Nullable error) {
        
        for (NSString *key in keyArray) {
            
            id object = snapshot.data[key] ? snapshot.data[key] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
            [dataDict setObject:object forKey:key];
            
        }
        
        finishBlock(YES, dataDict);
        
    }];
    
}

-(void)GetDataChatsAssignedToNewHomeMembersInSpecificHome:(NSString *)collection homeID:(NSString *)homeID completionHandler:(void (^)(BOOL finished, FIRQuerySnapshot *snapshot))finishBlock {
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[[[[defaultFirestore collectionWithPath:@"Homes"] documentWithPath:homeID] collectionWithPath:collection] documentWithPath:homeID] collectionWithPath:@"Chats"] queryWhereField:@"ChatAssignedToNewHomeMembers" isEqualTo:@"Yes"] getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        
        finishBlock(YES, snapshot);
        
    }];
    
}

-(void)GetDataChatsAssignedToSpecificUserInSpecificHome:(NSString *)userID homeID:(NSString *)homeID collection:(NSString *)collection completionHandler:(void (^)(BOOL finished, FIRQuerySnapshot *snapshot))finishBlock {
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[[[defaultFirestore collectionWithPath:@"Homes"] documentWithPath:homeID] collectionWithPath:collection] queryWhereField:@"ItemAssignedTo" arrayContains:userID] queryWhereField:@"ItemHomeID" isEqualTo:homeID] getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        
        finishBlock(YES, snapshot);
        
    }];
    
}

-(void)GetDataMasterLiveChats:(NSMutableArray *)chatArray completionHandler:(void (^)(BOOL finished, NSMutableArray *chatArray))finishBlock {
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    if (chatArray.count == 0) {
        
        chatArray = [NSMutableArray array];
        
    }
    
    [[[[defaultFirestore collectionWithPath:@"Users"] queryLimitedToLast:1000] queryOrderedByField:@"UserID"] getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        
        for (FIRDocumentSnapshot *doc in snapshot.documents) {
            
            NSString *userID = doc.data[@"UserID"] ? doc.data[@"UserID"] : @"xxx";
            
            [[[[defaultFirestore collectionWithPath:@"Users"] documentWithPath:userID] collectionWithPath:@"LiveSupport"] getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
                
                if (snapshot.documents.count > 0) {
                    
                    BOOL Yes = NO;
                    
//                    for (FIRDocumentSnapshot *doc in snapshot.documents) {
                    
//                        if ([doc.data[@"MessageText"] containsString:@"members of my household"]) {
                            Yes = YES;
                    
//                        }
                        
//                    }
                   
                    if (![chatArray containsObject:doc.data[@"UserID"]] && Yes) {
                        
                        [chatArray addObject:doc.data[@"UserID"]];
                        
                    }
                    
                }
                
                finishBlock(YES, chatArray);
                
            }];
            
        }
        
    }];
    
}

#pragma mark - Drafts

-(void)GetDataDrafts:(NSArray *)keyArray userID:(NSString *)userID completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDataDict))finishBlock {
    
    __block NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[defaultFirestore collectionWithPath:@"Users"] documentWithPath:userID] collectionWithPath:@"Drafts"] getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        
        for (FIRDocumentSnapshot *doc in snapshot.documents) {
            
            for (NSString *key in keyArray) {
                
                NSMutableArray *arr = dataDict[key] ? [dataDict[key] mutableCopy] : [NSMutableArray array];
                id object = doc.data[key] ? [doc.data[key] mutableCopy] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                [arr addObject:object];
                [dataDict setObject:arr forKey:key];
                
                
            }
            
        }
        
        finishBlock(YES, dataDict);
        
    }];
    
}

#pragma mark - Feedback

-(void)GetDataFeedback:(NSArray *)keyArray userID:(NSString *)userID completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDataDict))finishBlock {
    
    __block NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[[[defaultFirestore collectionWithPath:@"Feedback"] documentWithPath:@"Feedback"] collectionWithPath:@"Feedback"] documentWithPath:userID] collectionWithPath:@"Feedback"] getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        
        for (FIRDocumentSnapshot *doc in snapshot.documents) {
            
            for (NSString *key in keyArray) {
                
                NSMutableArray *arr = dataDict[key] ? [dataDict[key] mutableCopy] : [NSMutableArray array];
                [arr addObject:doc.data[key]];
                [dataDict setObject:arr forKey:key];
                
            }
            
        }
        
        finishBlock(YES, dataDict);
        
    }];
    
}

#pragma mark - Folders

-(void)GetDataFolders:(NSArray *)keyArray userID:(NSString *)userID completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDataDict))finishBlock {
    
    __block NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[defaultFirestore collectionWithPath:@"Users"] documentWithPath:userID] collectionWithPath:@"Folders"] getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        
        for (FIRDocumentSnapshot *doc in snapshot.documents) {
            
            for (NSString *key in keyArray) {
                
                NSMutableArray *arr = dataDict[key] ? [dataDict[key] mutableCopy] : [NSMutableArray array];
                id object = doc.data[key] ? [doc.data[key] mutableCopy] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                [arr addObject:object];
                [dataDict setObject:arr forKey:key];
                
            }
            
        }
        
        finishBlock(YES, dataDict);
        
    }];
    
}

#pragma mark - Forum

-(void)GetDataForumItem:(NSString *)forumID collectionKey:(NSString *)collectionKey keyArray:(NSArray *)keyArray currentViewController:(UIViewController *)currentViewController completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDataDict))finishBlock {
    
    __block NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[[defaultFirestore collectionWithPath:@"Forum"] documentWithPath:collectionKey] collectionWithPath:collectionKey] documentWithPath:forumID] getDocumentWithCompletion:^(FIRDocumentSnapshot * _Nullable snapshot, NSError * _Nullable error) {
        
        for (NSString *key in keyArray) {
            
            if (!dataDict[key]) {
                
                NSMutableArray *arr = [NSMutableArray array];
                [arr addObject:snapshot.data[key]];
                [dataDict setObject:arr forKey:key];
                
            } else {
                
                NSMutableArray *arr = [dataDict[key] mutableCopy];
                [arr insertObject:snapshot.data[key] atIndex:0];
                [dataDict setObject:arr forKey:key];
                
            }
            
        }
        
        finishBlock(YES, dataDict);
        
    }];
    
}

-(void)GetDataForumItems:(NSString *)collection keyArray:(NSArray *)keyArray completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDataDict))finishBlock {
    
    __block NSMutableDictionary *dataDictLocal = [NSMutableDictionary dictionary];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[defaultFirestore collectionWithPath:@"Forum"] documentWithPath:collection] collectionWithPath:collection] getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        
        for (FIRDocumentSnapshot *doc in snapshot.documents) {
            
            for (NSString *key in keyArray) {
                
                NSMutableArray *arr = dataDictLocal[key] ? [dataDictLocal[key] mutableCopy] : [NSMutableArray array];
                id object = doc.data[key] ? [doc.data[key] mutableCopy] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                [arr addObject:object];
                [dataDictLocal setObject:arr forKey:key];
                
            }
            
        }
        
        finishBlock(YES, dataDictLocal);
        
    }];
    
}

#pragma mark - Homes

-(void)GetDataHomesUserIdMemberOfSnapshot:(NSString *)userID completionHandler:(void (^)(BOOL finished, FIRQuerySnapshot *snapshot))finishBlock {
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[defaultFirestore collectionWithPath:@"Homes"] queryWhereField:@"HomeMembers" arrayContains:userID] getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        
        finishBlock(YES, snapshot);
        
    }];
    
}

-(void)GetDataHomesUserIsMemberOf:(NSArray *)keyArray userID:(NSString *)userID completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningHomeDict))finishBlock {
    
    NSMutableDictionary *homeDict = [NSMutableDictionary dictionary];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[defaultFirestore collectionWithPath:@"Homes"] queryWhereField:@"HomeMembers" arrayContains:userID] getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        
        for (FIRDocumentSnapshot *doc in snapshot.documents) {
            
            for (NSString *key in keyArray) {
                
                NSMutableArray *arr = homeDict[key] ? [homeDict[key] mutableCopy] : [NSMutableArray array];
                id object = doc.data[key] ? [doc.data[key] mutableCopy] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                [arr addObject:object];
                [homeDict setObject:arr forKey:key];
                
            }
            
        }
        
        finishBlock(YES, homeDict);
        
    }];
    
}

-(void)GetDataHomesWithHomeIDAndHomeMember:(NSArray *)keyArray userID:(NSString *)userID homeID:(NSString *)homeID completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningHomeDict))finishBlock {
    
    NSMutableDictionary *homeDict = [NSMutableDictionary dictionary];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[defaultFirestore collectionWithPath:@"Homes"] queryWhereField:@"HomeID" isEqualTo:homeID] queryWhereField:@"HomeMembers" arrayContains:userID] getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        
        for (FIRDocumentSnapshot *doc in snapshot.documents) {
            
            for (NSString *key in keyArray) {
                
                NSMutableArray *arr = homeDict[key] ? [homeDict[key] mutableCopy] : [NSMutableArray array];
                id object = doc.data[key] ? [doc.data[key] mutableCopy] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                [arr addObject:object];
                [homeDict setObject:arr forKey:key];
                
            }
            
        }
        
        finishBlock(YES, homeDict);
        
    }];
    
}

-(void)GetDataHomeMembers:(NSString *)homeID completionHandler:(void (^)(BOOL finished, NSMutableArray *homeMembers))finishBlock {
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[defaultFirestore collectionWithPath:@"Homes"] documentWithPath:homeID] getDocumentWithCompletion:^(FIRDocumentSnapshot * _Nullable snapshot, NSError * _Nullable error) {
        
        finishBlock(YES, snapshot.data[@"HomeMembers"]);
        
    }];
    
}

-(void)GetDataHomeKeys:(NSString *)homeID completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningHomeKeysArray))finishBlock {
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[defaultFirestore collectionWithPath:@"Homes"] documentWithPath:homeID] getDocumentWithCompletion:^(FIRDocumentSnapshot * _Nullable snapshot, NSError * _Nullable error) {
        
        finishBlock(YES, snapshot.data[@"HomeKeys"]);
        
    }];
    
}

-(void)GetDataFindHomeKey:(NSString *)homeKey completionHandler:(void (^)(BOOL finished, BOOL homeKeyExists, NSString *homeIDLinkedToKey, NSString *errorString))finishBlock {
    
    __block BOOL HomeKeyExists = false;
    __block NSString *homeIDLinkedToKey = @"";
    __block NSMutableArray *homeMemberArray = [NSMutableArray array];
    __block NSMutableDictionary *homeKeysDict = [NSMutableDictionary dictionary];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[defaultFirestore collectionWithPath:@"Homes"] queryWhereField:@"HomeKey" isEqualTo:homeKey] getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        
        for (FIRDocumentSnapshot *doc in snapshot.documents) {
            
            HomeKeyExists = true;
            
            homeIDLinkedToKey = doc.data[@"HomeID"] ? doc.data[@"HomeID"] : @"xxx";
            homeMemberArray = doc.data[@"HomeMembers"] ? [doc.data[@"HomeMembers"] mutableCopy] : [NSMutableArray array];
            homeKeysDict = doc.data[@"HomeKeys"] ? [doc.data[@"HomeKeys"] mutableCopy] : [NSMutableDictionary dictionary];
            
        }
        
        BOOL HomeKeyHasAlreadyBeenUsed = NO;
        
        for (NSString *key in [homeKeysDict allKeys]) {
            
            BOOL HomeKeyExistsInHomeKeysDict = [key containsString:[NSString stringWithFormat:@"%@•••", homeKey]];
            BOOL HomeKeyHasBeenUsed = [homeKeysDict[key][@"DateUsed"] length] > 0;
            
            if (HomeKeyExistsInHomeKeysDict == YES && HomeKeyHasBeenUsed == YES) {
                
                HomeKeyHasAlreadyBeenUsed = YES;
                
                break;
            }
            
        }
        
        NSString *errorString = @"";
        
        if ([homeMemberArray containsObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]]) {
            errorString = @"You are already a member of this home.";
        } else if (HomeKeyHasAlreadyBeenUsed == YES) {
            errorString = @"This home key has already been used by another home member.";
        } else if (HomeKeyExists == NO) {
            errorString = @"This home key does not exist.";
        }
        
        finishBlock(YES, HomeKeyExists, homeIDLinkedToKey, errorString);
        
    }];
    
}

-(void)GetDataFindHomeKeyInKeyArray:(NSString *)homeKey completionHandler:(void (^)(BOOL finished, BOOL homeKeyExists, NSString *homeIDLinkedToKey, NSString *errorString))finishBlock {
    
    __block BOOL HomeKeyExists = false;
    __block NSString *homeIDLinkedToKey = @"";
    __block NSMutableArray *homeMemberArray = [NSMutableArray array];
    __block NSMutableDictionary *homeKeysDict = [NSMutableDictionary dictionary];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[defaultFirestore collectionWithPath:@"Homes"] queryWhereField:@"HomeKeysArray" arrayContains:homeKey] getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        
        for (FIRDocumentSnapshot *doc in snapshot.documents) {
            
            HomeKeyExists = true;
            
            homeIDLinkedToKey = doc.data[@"HomeID"] ? doc.data[@"HomeID"] : @"xxx";
            homeMemberArray = doc.data[@"HomeMembers"] ? [doc.data[@"HomeMembers"] mutableCopy] : [NSMutableArray array];
            homeKeysDict = doc.data[@"HomeKeys"] ? [doc.data[@"HomeKeys"] mutableCopy] : [NSMutableDictionary dictionary];
            
        }
        
        BOOL HomeKeyHasAlreadyBeenUsed = NO;
        
        for (NSString *key in [homeKeysDict allKeys]) {
            
            BOOL HomeKeyExistsInHomeKeysDict = [key containsString:[NSString stringWithFormat:@"%@•••", homeKey]];
            BOOL HomeKeyHasBeenUsed = [homeKeysDict[key][@"DateUsed"] length] > 0;
            
            if (HomeKeyExistsInHomeKeysDict == YES && HomeKeyHasBeenUsed == YES) {
                
                HomeKeyHasAlreadyBeenUsed = YES;
                
                break;
            }
            
        }
        
        NSString *errorString = @"";
        
        if ([homeMemberArray containsObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]]) {
            errorString = @"You are already a member of this home.";
        } else if (HomeKeyHasAlreadyBeenUsed == YES) {
            errorString = @"This home key has already been used by another home member.";
        } else if (HomeKeyExists == NO) {
            errorString = @"This home key does not exist.";
        }
        
        finishBlock(YES, HomeKeyExists, homeIDLinkedToKey, errorString);
        
    }];
    
}

-(void)GetDataSpecificHomeData:(NSString *)homeID keyArray:(NSArray *)keyArray completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningHomeToJoinDict, NSMutableArray *queriedHomeMemberArray, NSString *queriedHomeID))finishBlock {
    
    __block NSMutableArray *queriedHomeMemberArray = [NSMutableArray array];
    NSMutableDictionary *homeToJoinDict = [NSMutableDictionary dictionary];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[defaultFirestore collectionWithPath:@"Homes"] queryWhereField:@"HomeID" isEqualTo:homeID] addSnapshotListener:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        
        NSString *queriedHomeID = @"";
        
        for (FIRDocumentSnapshot *doc in snapshot.documents) {
            
            for (NSString *key in keyArray) {
                
                id object = doc.data[key] ? [doc.data[key] mutableCopy] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                [homeToJoinDict setObject:object forKey:key];
                
            }
            
            queriedHomeID = homeToJoinDict[@"HomeID"] ? homeToJoinDict[@"HomeID"] : @"xxx";
            queriedHomeMemberArray = homeToJoinDict[@"HomeMembers"] ? [homeToJoinDict[@"HomeMembers"] mutableCopy] : [NSMutableArray array];
            
        }
        
        finishBlock(YES, homeToJoinDict, queriedHomeMemberArray, queriedHomeID);
        
    }];
    
}

-(void)GetDataSpecificHomeDataWithoutListener:(NSString *)homeID keyArray:(NSArray *)keyArray completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningHomeToJoinDict))finishBlock {
    
    __block NSMutableArray *queriedHomeMemberArray = [NSMutableArray array];
    NSMutableDictionary *homeToJoinDict = [NSMutableDictionary dictionary];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[defaultFirestore collectionWithPath:@"Homes"] queryWhereField:@"HomeID" isEqualTo:homeID] getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        
        NSString *queriedHomeID = @"";
        
        for (FIRDocumentSnapshot *doc in snapshot.documents) {
            
            for (NSString *key in keyArray) {
                
                id object = doc.data[key] ? [doc.data[key] mutableCopy] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                [homeToJoinDict setObject:object forKey:key];
                
            }
            
            queriedHomeID = homeToJoinDict[@"HomeID"] ? homeToJoinDict[@"HomeID"] : @"xxx";
            queriedHomeMemberArray = homeToJoinDict[@"HomeMembers"] ? [homeToJoinDict[@"HomeMembers"] mutableCopy] : [NSMutableArray array];
            
            
        }
        
        finishBlock(YES, homeToJoinDict);
        
    }];
    
}

#pragma mark Compound Method

-(void)GetDataHomeWithPromoCodeSender:(NSString *)homeID completionHandler:(void (^)(BOOL finished, BOOL HomeHasPromoCodeSender))finishBlock {
    
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"];
    
    [[[GetDataObject alloc] init] GetDataUserData:userID completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningUserDict) {
        
        NSDictionary *weDivvyPremiumDict = returningUserDict[@"WeDivvyPremium"] ? returningUserDict[@"WeDivvyPremium"] : [[[GeneralObject alloc] init] GenerateDefaultWeDivvyPremiumPlan];
        
        
        
        
        NSString *subscriptionID = weDivvyPremiumDict && weDivvyPremiumDict[@"SubscriptionID"] ? weDivvyPremiumDict[@"SubscriptionID"] : @"xxx";
        BOOL UserHasSubscription = weDivvyPremiumDict && weDivvyPremiumDict[@"SubscriptionPlan"] && [weDivvyPremiumDict[@"SubscriptionPlan"] length] > 0;
        
        if (UserHasSubscription) {
            
            [[[GetDataObject alloc] init] GetDataSubscriptionWithID:subscriptionID completionhandler:^(BOOL finished, NSDictionary * _Nullable subscriptionDict) {
                
                NSString *subscriptionPromotionalCodeID = subscriptionDict[@"SubscriptionPromotionalCodeID"] ? subscriptionDict[@"SubscriptionPromotionalCodeID"] : @"";
                
                
                
                
                BOOL SubscriptionHasPromotionalCode = [subscriptionPromotionalCodeID length] > 0;
                
                if (SubscriptionHasPromotionalCode) {
                    
                    NSArray *keyArray = [[[GeneralObject alloc] init] GeneratePromotionalCodesKeyArray];
                    
                    [[[GetDataObject alloc] init] GetDataPromotionalCodeWithID:keyArray promotionalCodeID:subscriptionPromotionalCodeID completionHandler:^(BOOL finished, NSDictionary * _Nonnull dataDict) {
                        
                        NSString *promotionalCodeSentBy = dataDict[@"PromotionalCodeSentBy"] ? dataDict[@"PromotionalCodeSentBy"] : @"";
                        
                        
                        
                        
                        NSArray *keyArray = [[[GeneralObject alloc] init] GenerateKeyArrayManually:NO Expense:NO List:NO Home:YES];
                        
                        [[[GetDataObject alloc] init] GetDataHomesWithHomeIDAndHomeMember:keyArray userID:promotionalCodeSentBy homeID:homeID completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningHomeDict) {
                            
                            BOOL HomeHasSenderOfPromotionalCodeThatYouUsed = returningHomeDict && returningHomeDict[@"HomeID"] && [(NSArray *)returningHomeDict[@"HomeID"] count] > 0;
                            
                            if (HomeHasSenderOfPromotionalCodeThatYouUsed) {
                                
                                finishBlock(YES, YES);
                                
                            } else {
                                
                                finishBlock(YES, NO);
                                
                            }
                            
                        }];
                        
                    }];
                    
                } else {
                    
                    finishBlock(YES, NO);
                    
                }
                
            }];
            
        } else {
            
            finishBlock(YES, NO);
            
        }
        
    }];
    
}

#pragma mark - Messages

-(void)GetDataMessagesInSpecificChat:(NSString *)userID homeID:(NSString *)homeID itemType:(NSString *)itemType itemID:(NSString *)itemID chatID:(NSString *)chatID keyArray:(NSArray *)keyArray messageDict:(NSMutableDictionary *)messageDict viewingGroupChat:(BOOL)viewingGroupChat viewingComments:(BOOL)viewingComments viewingLiveSupport:(BOOL)viewingLiveSupport completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningMessageDict))finishBlock {
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    NSMutableDictionary *messageDictLocal = [messageDict mutableCopy];
    
    if ([(NSArray *)messageDictLocal[@"MessageID"] count] == 0) {
        
        messageDictLocal = [NSMutableDictionary dictionary];
        
        for (NSString *key in keyArray) {
            
            [messageDictLocal setObject:[NSMutableArray array] forKey:key];
            
        }
        
    }
    
    FIRQuery *queryToUse;
    
    if (homeID.length == 0 || homeID == nil || homeID == NULL) {
        homeID = @"xxx";
    }
    
    if (itemType.length == 0 || itemType == nil || itemType == NULL) {
        itemType = @"xxx";
    }
    
    if (chatID.length == 0 || chatID == nil || chatID == NULL) {
        chatID = @"xxx";
    }
    
    if (userID.length == 0 || userID == nil || userID == NULL) {
        userID = @"xxx";
    }
    
    if (itemID.length == 0 || itemID == nil || itemID == NULL) {
        itemID = @"xxx";
    }
    
    if (viewingComments == YES) {
        
        NSString *collection = [NSString stringWithFormat:@"%@s", itemType];
        
        queryToUse = [[[[[defaultFirestore collectionWithPath:@"Homes"] documentWithPath:homeID] collectionWithPath:collection]
                       documentWithPath:itemID] collectionWithPath:@"Comments"];
  
    } else if (viewingGroupChat == YES) {
        
        queryToUse = [[[[[defaultFirestore collectionWithPath:@"Homes"] documentWithPath:homeID] collectionWithPath:@"GroupChats"] documentWithPath:chatID] collectionWithPath:@"Messages"];
        
    } else if (viewingLiveSupport == YES) {
        
        queryToUse = [[[defaultFirestore collectionWithPath:@"Users"] documentWithPath:userID] collectionWithPath:@"LiveSupport"];
        
    }
    
    if (queryToUse == nil) {
        
        finishBlock(YES, messageDictLocal);
        
    } else {
        
        [queryToUse addSnapshotListener:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
            
            for (FIRDocumentSnapshot *doc in snapshot.documents) {
             
                if ([messageDictLocal[@"MessageID"] containsObject:doc.data[@"MessageID"]] == NO) {
                    
                    for (NSString *key in keyArray) {
                        
                        NSMutableArray *arr = [messageDictLocal[key] mutableCopy];
                        id object = doc.data[key] ? doc.data[key] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                        [arr addObject:object];
                        [messageDictLocal setObject:arr forKey:key];
                        
                    }
              
                }
                
            }
           
            finishBlock(YES, messageDictLocal);
            
        }];
        
    }
    
}

-(void)GetDataLastMessageInSpecificChat:(NSString *)userID homeID:(NSString *)homeID itemType:(NSString *)itemType itemID:(NSString *)itemID chatID:(NSString *)chatID keyArray:(NSArray *)keyArray viewingGroupChat:(BOOL)viewingGroupChat viewingComments:(BOOL)viewingComments viewingLiveSupport:(BOOL)viewingLiveSupport completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningMessageDict))finishBlock {
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    NSMutableDictionary *messageDictLocal = [NSMutableDictionary dictionary];
    
    FIRQuery *queryToUse;
    
    if (homeID.length == 0 || homeID == nil || homeID == NULL) {
        homeID = @"xxx";
    }
    
    if (itemType.length == 0 || itemType == nil || itemType == NULL) {
        itemType = @"xxx";
    }
    
    if (chatID.length == 0 || chatID == nil || chatID == NULL) {
        chatID = @"xxx";
    }
    
    if (userID.length == 0 || userID == nil || userID == NULL) {
        userID = @"xxx";
    }
    
    if (itemID.length == 0 || itemID == nil || itemID == NULL) {
        itemID = @"xxx";
    }
    
    if (viewingComments == YES) {
        
        NSString *collection = [NSString stringWithFormat:@"%@s", itemType];
        
        queryToUse = [[[[[defaultFirestore collectionWithPath:@"Homes"] documentWithPath:homeID] collectionWithPath:collection]
                       documentWithPath:itemID] collectionWithPath:@"Comments"];
        
    } else if (viewingGroupChat == YES) {
        
        queryToUse = [[[[[defaultFirestore collectionWithPath:@"Homes"] documentWithPath:homeID] collectionWithPath:@"GroupChats"] documentWithPath:chatID] collectionWithPath:@"Messages"];
        
    } else if (viewingLiveSupport == YES) {
        
        queryToUse = [[[defaultFirestore collectionWithPath:@"Users"] documentWithPath:userID] collectionWithPath:@"LiveSupport"];
        
    }
    
    if (queryToUse == nil) {
        
        finishBlock(YES, messageDictLocal);
        
    } else {
        
        [queryToUse
         getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
            
            if (snapshot.documents.count > 0) {
                
                FIRDocumentSnapshot *lastDocument = snapshot.documents[snapshot.documents.count - 1];
                
                for (NSString *key in keyArray) {
                    
                    id object = lastDocument.data[key] ? lastDocument.data[key] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                    [messageDictLocal setObject:object forKey:key];
                    
                }
                
            }
            
            finishBlock(YES, messageDictLocal);
            
        }];
        
    }
    
}

#pragma mark - Notifications

-(void)GetDataNotifications:(NSString *)homeID keyArray:(NSArray *)keyArray completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDataDict))finishBlock {
    
    NSMutableDictionary *notificationsDict = [NSMutableDictionary dictionary];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[defaultFirestore
        collectionWithPath:@"Homes"] documentWithPath:homeID] collectionWithPath:@"Notifications"] getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        
        for (FIRDocumentSnapshot *doc in snapshot.documents) {
            
            for (NSString *key in keyArray) {
                
                NSMutableArray *arr = notificationsDict[key] ? [notificationsDict[key] mutableCopy] : [NSMutableArray array];
                id object = doc.data[key] ? [doc.data[key] mutableCopy] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                [arr addObject:object];
                [notificationsDict setObject:arr forKey:key];
                
            }
            
        }
        
        finishBlock(YES, notificationsDict);
        
    }];
    
}

-(void)GetDataNotificationsNotCreatedBySpecificUser:(NSString *)homeID userID:(NSString *)userID keyArray:(NSArray *)keyArray completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDataDict))finishBlock {
    
    NSMutableDictionary *notificationsDict = [NSMutableDictionary dictionary];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[[defaultFirestore
         collectionWithPath:@"Homes"] documentWithPath:homeID] collectionWithPath:@"Notifications"] queryWhereField:@"NotificationCreatedBy" isNotEqualTo:userID] getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        
        for (FIRDocumentSnapshot *doc in snapshot.documents) {
            
            for (NSString *key in keyArray) {
                
                NSMutableArray *arr = notificationsDict[key] ? [notificationsDict[key] mutableCopy] : [NSMutableArray array];
                id object = doc.data[key] ? [doc.data[key] mutableCopy] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                [arr addObject:object];
                [notificationsDict setObject:arr forKey:key];
                
            }
            
        }
        
        finishBlock(YES, notificationsDict);
        
    }];
    
}

-(void)GetDataUnreadNotificationsNotCreatedBySpecificUser:(NSString *)homeID userID:(NSString *)userID completionHandler:(void (^)(BOOL finished, BOOL unreadNotificationFound))finishBlock {
    
    __block BOOL unreadNotificationFound = false;
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    if (homeID.length == 0 || homeID == nil || homeID == NULL) {
        homeID = @"xxx";
    }
    
    if (userID.length == 0 || userID == nil || userID == NULL) {
        userID = @"xxx";
    }
    
    if ([homeID isEqualToString:@"xxx"] || [userID isEqualToString:@"xxx"]) {
        
        finishBlock(YES, unreadNotificationFound);
        
    } else {
        
        [[[[[defaultFirestore
             collectionWithPath:@"Homes"] documentWithPath:homeID] collectionWithPath:@"Notifications"] queryWhereField:@"NotificationCreatedBy" isNotEqualTo:userID] getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
            
            for (FIRDocumentSnapshot *doc in snapshot.documents) {
                
                if (doc.data[@"NotificationRead"]) {
                    
                    if ([doc.data[@"NotificationRead"] containsObject:userID] == NO) {
                        
                        unreadNotificationFound = true;
                        break;
                        
                    }
                    
                }
                
            }
            
            finishBlock(YES, unreadNotificationFound);
            
        }];
        
    }
    
}

-(void)GetDataUnreadNotificationsCountNotCreatedBySpecificUser:(NSString *)homeID userID:(NSString *)userID completionHandler:(void (^)(BOOL finished, NSString *unreadNotificationCount))finishBlock {
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    if (homeID.length == 0 || homeID == nil || homeID == NULL) {
        homeID = @"xxx";
    }
    
    if (userID.length == 0 || userID == nil || userID == NULL) {
        userID = @"xxx";
    }
    
    if ([homeID isEqualToString:@"xxx"] || [userID isEqualToString:@"xxx"]) {
        
        finishBlock(YES, [NSString stringWithFormat:@"0"]);
        
    } else {
        
        [[[[[defaultFirestore
             collectionWithPath:@"Homes"] documentWithPath:homeID] collectionWithPath:@"Notifications"] queryWhereField:@"NotificationCreatedBy" isNotEqualTo:userID] getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
            
            int totalUnreadNotifications = 0;
            
            for (FIRDocumentSnapshot *doc in snapshot.documents) {
                
                if (doc.data[@"NotificationRead"] && doc.data[@"NotificationDateCreated"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]) {
                    
                    BOOL UserSignedUpAfterNotificationWasCreated = [[[NotificationsObject alloc] init] UserSignedUpAfterNotificationWasCreated:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] notificationDatePosted:doc.data[@"NotificationDateCreated"]];
                    
                    if ([doc.data[@"NotificationRead"] containsObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] == NO && UserSignedUpAfterNotificationWasCreated == NO) {
                        
                        totalUnreadNotifications += 1;
                        
                    }
                    
                }
                
            }
            
            finishBlock(YES, [NSString stringWithFormat:@"%d", totalUnreadNotifications]);
            
        }];
        
    }
    
}

#pragma mark - Promotional Codes

-(void)GetDataSpecificUserPromotionalCodeData:(NSString *)userID keyArray:(NSArray *)keyArray completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningPromotionalCodeDict))finishBlock {
    
    NSMutableDictionary *promotionalCodeDict = [NSMutableDictionary dictionary];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[defaultFirestore collectionWithPath:@"PromotionalCodes"] queryWhereField:@"PromotionalCodeSentBy" isEqualTo:userID] addSnapshotListener:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        
        for (FIRDocumentSnapshot *doc in snapshot.documents) {
            
            NSString *promotionalCodeID = doc.data[@"PromotionalCodeID"];
            
            if (!promotionalCodeDict[@"PromotionalCodeID"] ||
                (promotionalCodeDict[@"PromotionalCodeID"] && [promotionalCodeDict[@"PromotionalCodeID"] containsObject:promotionalCodeID] == NO)) {
                
                for (NSString *key in keyArray) {
                    
                    NSMutableArray *arr = promotionalCodeDict[key] ? [promotionalCodeDict[key] mutableCopy] : [NSMutableArray array];
                    id object = doc.data[key] ? [doc.data[key] mutableCopy] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                    [arr addObject:object];
                    [promotionalCodeDict setObject:arr forKey:key];
                    
                }
                
            }
            
        }
        
        finishBlock(YES, promotionalCodeDict);
    }];
    
}

-(void)GetDataPromotionalCode:(NSArray *)keyArray userID:(NSString *)userID promotionalCode:(NSString *)promotionalCode completionHandler:(void (^)(BOOL finished, NSDictionary *dataDict))finishBlock {
    
    NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[defaultFirestore
       collectionWithPath:@"PromotionalCodes"]
      queryWhereField:@"PromotionalCode" isEqualTo:promotionalCode]
     getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        
        for (FIRDocumentSnapshot *doc in snapshot.documents) {
            
            for (NSString *key in keyArray) {
                
                NSMutableArray *arr = dataDict[key] ?[dataDict[key] mutableCopy] : [NSMutableArray array];
                [arr addObject:doc.data[key]];
                [dataDict setObject:arr forKey:key];
                
            }
            
        }
        
        finishBlock(YES, dataDict);
        
    }];
    
}

-(void)GetDataPromotionalCodeWithID:(NSArray *)keyArray promotionalCodeID:(NSString *)promotionalCodeID completionHandler:(void (^)(BOOL finished, NSDictionary *dataDict))finishBlock {
    
    NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[defaultFirestore
       collectionWithPath:@"PromotionalCodes"]
      queryWhereField:@"PromotionalCodeID" isEqualTo:promotionalCodeID]
     getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        
        for (FIRDocumentSnapshot *doc in snapshot.documents) {
            
            for (NSString *key in keyArray) {
                
                NSMutableArray *arr = dataDict[key] ?[dataDict[key] mutableCopy] : [NSMutableArray array];
                [arr addObject:doc.data[key]];
                [dataDict setObject:arr forKey:key];
                
            }
            
        }
        
        finishBlock(YES, dataDict);
        
    }];
    
}

-(void)GetDataPromotionalCodeUsedByReceiverNotBySender:(NSArray *)keyArray userID:(NSString *)userID completionHandler:(void (^)(BOOL finished, NSDictionary *dataDict))finishBlock {
    
    NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[defaultFirestore
       collectionWithPath:@"PromotionalCodes"]
      queryWhereField:@"PromotionalCodeSentBy" isEqualTo:userID]
     getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        
        for (FIRDocumentSnapshot *doc in snapshot.documents) {
            
            if ([doc.data[@"PromotionalCodeUsedByReceiver"] isEqualToString:@""] == NO &&
                [doc.data[@"PromotionalCodeUsedBySender"] isEqualToString:@""]) {
                
                for (NSString *key in keyArray) {
                    
                    NSMutableArray *arr = dataDict[key] ?[dataDict[key] mutableCopy] : [NSMutableArray array];
                    [arr addObject:doc.data[key]];
                    [dataDict setObject:arr forKey:key];
                    
                }
                
            }
            
        }
        
        finishBlock(YES, dataDict);
        
    }];
    
}

#pragma mark - Reminders

-(void)GetDataReminders:(NSArray *)keyArray userID:(NSString *)userID completionHandler:(void (^)(BOOL finished, NSDictionary *dataDict))finishBlock {
    
    NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[defaultFirestore
        collectionWithPath:@"Reminders"]
       documentWithPath:userID]
      collectionWithPath:@"Reminders"]
     getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        
        for (FIRDocumentSnapshot *doc in snapshot.documents) {
            
            for (NSString *key in keyArray) {
                
                NSMutableArray *arr = dataDict[key] ?[dataDict[key] mutableCopy] : [NSMutableArray array];
                [arr addObject:doc.data[key]];
                [dataDict setObject:arr forKey:key];
                
            }
            
        }
        
        finishBlock(YES, dataDict);
        
    }];
    
}

#pragma mark - Sections

-(void)GetDataSections:(NSArray *)keyArray userID:(NSString *)userID completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDataDict))finishBlock {
    
    __block NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[defaultFirestore collectionWithPath:@"Users"] documentWithPath:userID] collectionWithPath:@"Sections"] getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        
        for (FIRDocumentSnapshot *doc in snapshot.documents) {
            
            for (NSString *key in keyArray) {
                
                NSMutableArray *arr = dataDict[key] ? [dataDict[key] mutableCopy] : [NSMutableArray array];
                id object = doc.data[key] ? [doc.data[key] mutableCopy] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                [arr addObject:object];
                [dataDict setObject:arr forKey:key];
                
                
            }
            
        }
        
        finishBlock(YES, dataDict);
        
    }];
    
}

#pragma mark - Subscriptions

-(void)GetDataSubscriptionPurchsedByUser:(NSString *)userID completionhandler:(void (^)(BOOL finished, NSDictionary * _Nullable subscriptionDict))finishBlock {
    
    __block NSDictionary *subscriptionDict = NULL;
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[defaultFirestore
        collectionWithPath:@"Subscriptions"]
       queryWhereField:@"SubscriptionPurchasedBy" isEqualTo:userID] queryWhereField:@"SubscriptionDateCancelled" isEqualTo:@""]
     getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        
        for (FIRDocumentSnapshot *doc in snapshot.documents) {
            
            if (doc == [snapshot.documents lastObject]) {
                
                subscriptionDict = doc.data;
                
                finishBlock(YES, subscriptionDict);
                
            }
            
        }
        
        if (subscriptionDict == NULL) {
            
            finishBlock(YES, subscriptionDict);
            
        }
        
    }];
    
}

-(void)GetDataSubscriptionWithID:(NSString *)subscriptionID completionhandler:(void (^)(BOOL finished, NSDictionary * _Nullable subscriptionDict))finishBlock {
    
    __block NSDictionary *subscriptionDict = NULL;
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[defaultFirestore
       collectionWithPath:@"Subscriptions"]
      queryWhereField:@"SubscriptionID" isEqualTo:subscriptionID]
     getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        
        for (FIRDocumentSnapshot *doc in snapshot.documents) {
            
            if (doc == [snapshot.documents lastObject]) {
                
                subscriptionDict = doc.data;
                
                finishBlock(YES, subscriptionDict);
                
            }
            
        }
        
        if (subscriptionDict == NULL) {
            
            finishBlock(YES, subscriptionDict);
            
        }
        
    }];
    
}

#pragma mark - Task Lists

-(void)GetDataTaskLists:(NSArray *)keyArray userID:(NSString *)userID completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDataDict))finishBlock {
    
    if (userID.length == 0) {
        userID = @"xxx";
    }
    
    __block NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[defaultFirestore collectionWithPath:@"Users"] documentWithPath:userID] collectionWithPath:@"TaskLists"] getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        
        for (FIRDocumentSnapshot *doc in snapshot.documents) {
            
            if (doc.data[@"TaskListID"]) {
                
                for (NSString *key in keyArray) {
                    
                    NSMutableArray *arr = dataDict[key] ? [dataDict[key] mutableCopy] : [NSMutableArray array];
                    id object = doc.data[key] ? [doc.data[key] mutableCopy] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                    [arr addObject:object];
                    [dataDict setObject:arr forKey:key];
                    
                }
                
            }
            
        }
        
        finishBlock(YES, dataDict);
        
    }];
    
}

#pragma mark - Templates

-(void)GetDataTemplates:(NSArray *)keyArray userID:(NSString *)userID completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDataDict))finishBlock {
    
    __block NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[defaultFirestore collectionWithPath:@"Users"] documentWithPath:userID] collectionWithPath:@"Templates"] getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        
        for (FIRDocumentSnapshot *doc in snapshot.documents) {
            
            for (NSString *key in keyArray) {
                
                NSMutableArray *arr = dataDict[key] ? [dataDict[key] mutableCopy] : [NSMutableArray array];
                id object = doc.data[key] ? [doc.data[key] mutableCopy] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                [arr addObject:object];
                [dataDict setObject:arr forKey:key];
                
                
            }
            
        }
        
        finishBlock(YES, dataDict);
        
    }];
    
}

#pragma mark - Topics

-(void)GetDataTopics:(NSArray *)keyArray homeID:(NSString *)homeID completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDataDict))finishBlock {
    
    __block NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[defaultFirestore collectionWithPath:@"Homes"] documentWithPath:homeID] collectionWithPath:@"Topics"] getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        
        for (FIRDocumentSnapshot *doc in snapshot.documents) {
            
            for (NSString *key in keyArray) {
                
                NSMutableArray *arr = dataDict[key] ? [dataDict[key] mutableCopy] : [NSMutableArray array];
                id object = doc.data[key] ? [doc.data[key] mutableCopy] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                [arr addObject:object];
                [dataDict setObject:arr forKey:key];
                
                
            }
            
        }
        
        finishBlock(YES, dataDict);
        
    }];
    
}

#pragma mark - Users

-(void)GetDataCheckIfObjectInFieldExistsInCollection:(NSString *)collection field:(NSString *)field object:(NSString *)object thirdPartySignUp:(BOOL)thirdPartySignUp completionHandler:(void (^)(BOOL finished, BOOL doesObjectExist))finishBlock {
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[defaultFirestore collectionWithPath:collection] queryWhereField:field isEqualTo:object] getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        
        BOOL doesObjectExist = NO;
        
        int limit = thirdPartySignUp ? 1 : 0;
        
        if (snapshot.documents.count > limit) {
            
            doesObjectExist = YES;
            
        }
        
        finishBlock(YES, doesObjectExist);
        
    }];
    
}

-(void)GetDataCostPerPersonUserData:(NSMutableArray *)itemAssignedToArray costArray:(NSMutableArray *)costArray costPerPersonDict:(NSMutableDictionary *)costPerPersonDict completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningUserDict))finishBlock {
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    NSMutableDictionary *userDict = [NSMutableDictionary dictionary];
    
    if (itemAssignedToArray.count == 0) {
        
        finishBlock(YES, userDict);
        
    }
    
    if ([[costPerPersonDict allKeys] count] > 0) {
        itemAssignedToArray = [[costPerPersonDict allKeys] mutableCopy];
    }
    
    NSMutableArray *objectArr = [NSMutableArray array];
    NSMutableArray *itemAssignedToUsernameArrayLocal = [itemAssignedToArray mutableCopy];
    NSMutableArray *itemAssignedToProfileImageArrayLocal = [itemAssignedToArray mutableCopy];
    NSMutableArray *arrayToLoop = [NSMutableArray array];
    
    [arrayToLoop addObject:@""];
    
    //    if (itemAssignedToArray.count > 10 || itemAssignedToArray.count == 0) {
    arrayToLoop = [itemAssignedToArray mutableCopy];
    //    }
    
    for (NSString *userID in arrayToLoop) {
        
        FIRQuery *queryToUse;
        
        //        if (itemAssignedToArray.count > 10 || itemAssignedToArray.count == 0) {
        queryToUse = [[defaultFirestore collectionWithPath:@"Users"] queryWhereField:@"UserID" isEqualTo:userID];
        //        } else {
        //            queryToUse = [[defaultFirestore collectionWithPath:@"Users"] queryWhereField:@"UserID" in:itemAssignedToArray];
        //        }
        
        [queryToUse getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
            
            for (FIRDocumentSnapshot *doc in snapshot.documents) {
                
                if (doc.data == nil) {
                    NSString *userID = @"User Does Not Exist";
                    NSUInteger index = [itemAssignedToArray containsObject:userID] ? [itemAssignedToArray indexOfObject:userID] : 0;
                    if ([itemAssignedToUsernameArrayLocal count] > index) { [itemAssignedToUsernameArrayLocal replaceObjectAtIndex:index withObject:@"User Does Not Exist"]; }
                    if ([itemAssignedToProfileImageArrayLocal count] > index) { [itemAssignedToProfileImageArrayLocal replaceObjectAtIndex:index withObject:@"User Does Not Exist"]; }
                } else {
                    NSString *userID = doc.data[@"UserID"];
                    NSUInteger index = [itemAssignedToArray containsObject:userID] ? [itemAssignedToArray indexOfObject:userID] : 0;
                    if ([itemAssignedToUsernameArrayLocal count] > index) {  [itemAssignedToUsernameArrayLocal replaceObjectAtIndex:index withObject:doc.data[@"Username"]]; }
                    if ([itemAssignedToProfileImageArrayLocal count] > index) {  [itemAssignedToProfileImageArrayLocal replaceObjectAtIndex:index withObject:doc.data[@"ProfileImageURL"]]; }
                }
                
                if ([[[GeneralObject alloc] init] AddToObjectArrAndCheckIfQueryHasEnded:arrayToLoop objectArr:objectArr]) {
                    
                    [userDict setObject:costArray forKey:@"Cost"];
                    [userDict setObject:itemAssignedToArray forKey:@"UserID"];
                    [userDict setObject:itemAssignedToUsernameArrayLocal forKey:@"Username"];
                    [userDict setObject:itemAssignedToProfileImageArrayLocal forKey:@"ProfileImageURL"];
                    
                    finishBlock(YES, userDict);
                    
                }
                
            }
            
        }];
        
    }
    
}

-(void)GetDataExistingUserData:(NSString *)userEmail completionHandler:(void (^)(BOOL finished, NSString *userID, NSString *currentMixPanelID, BOOL userFound))finishBlock {
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[defaultFirestore
       collectionWithPath:@"Users"] queryWhereField:@"Email" isEqualTo:userEmail] getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        
        NSString *userID;
        NSString *currentMixPanelID;
        BOOL userFound = NO;
        
        if (snapshot.documents.count == 0) {
            
            userID = @"";
            currentMixPanelID = @"";
            userFound = NO;
            
        } else {
            
            for (FIRDocumentSnapshot *doc in snapshot.documents) {
                
                userID = doc.data[@"UserID"];
                [[NSUserDefaults standardUserDefaults] setObject:doc.data[@"Email"] forKey:@"UsersEmail"];
                [[NSUserDefaults standardUserDefaults] setObject:doc.data[@"UserID"] forKey:@"UsersUserID"];
                [[NSUserDefaults standardUserDefaults] setObject:doc.data[@"Username"] forKey:@"UsersUsername"];
                [[NSUserDefaults standardUserDefaults] setObject:doc.data[@"ProfileImageURL"] forKey:@"UsersProfileImage"];
                
                if (doc.data[@"MixPanelID"]) {
                    
                    currentMixPanelID = doc.data[@"MixPanelID"];
                    
                }
                
                userFound = YES;
                
            }
            
        }
        
        finishBlock(YES, userID, currentMixPanelID, userFound);
        
    }];
    
}

-(void)GetDataProfileUser:(NSString *)userID completionHandler:(void (^)(BOOL finished, NSString *username, NSString *userImageURL))finishBlock {
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[defaultFirestore
       collectionWithPath:@"Users"]
      documentWithPath:userID]
     getDocumentWithCompletion:^(FIRDocumentSnapshot * _Nullable snapshot, NSError * _Nullable error) {
        
        NSString *username = snapshot.data[@"Username"];
        NSString *profileImageURL = snapshot.data[@"ProfileImageURL"];
        
        finishBlock(YES, username, profileImageURL);
        
    }];
    
}

-(void)GetDataUserData:(NSString *)userID completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningUserDict))finishBlock {
    
    __block NSArray *keyArray = [[[GeneralObject alloc] init] GenerateUserKeyArray];
    __block NSMutableDictionary *userDict = [NSMutableDictionary dictionary];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[defaultFirestore collectionWithPath:@"Users"] documentWithPath:userID] getDocumentWithCompletion:^(FIRDocumentSnapshot * _Nullable snapshot, NSError * _Nullable error) {
        
        for (NSString *key in keyArray) {
            
            id object = snapshot.data[key] ? snapshot.data[key] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
            [userDict setObject:object forKey:key];
            
        }
        
        finishBlock(YES, userDict);
        
    }];
    
}

-(void)GetDataUserDataArray:(NSMutableArray *)userIDArray completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningUserDict))finishBlock {
    
    __block NSArray *keyArray = [[[GeneralObject alloc] init] GenerateUserKeyArray];
    __block NSMutableDictionary *userDict = [NSMutableDictionary dictionary];
    __block NSMutableArray *tempUserIDArr = [userIDArray mutableCopy];
    
    userDict = [[[GetDataObject alloc] init] FillDictWithArrays:keyArray userDict:userDict];
    
    if (userIDArray.count == 0) {
        finishBlock(YES, userDict);
    }
    
    userDict = [[[GetDataObject alloc] init] FillDictWithData:keyArray userDict:userDict userIDArray:userIDArray];
    
    NSMutableArray *objectArr = [NSMutableArray array];
    NSMutableArray *arrayToLoop = [NSMutableArray array];
    
    [arrayToLoop addObject:@""];
    
    //    if (userIDArray.count > 10 || userIDArray.count == 0) {
    arrayToLoop = [userIDArray mutableCopy];
    //    }
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    for (NSString *userID in arrayToLoop) {
        
        FIRQuery *queryToUse;
        
        //        if (userIDArray.count > 10 || userIDArray.count == 0) {
        queryToUse = [[defaultFirestore collectionWithPath:@"Users"]
                      queryWhereField:@"UserID" isEqualTo:userID];
        //        } else {
        //            queryToUse = [[defaultFirestore collectionWithPath:@"Users"]
        //                          queryWhereField:@"UserID" in:userIDArray];
        //        }
        
        [queryToUse getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
         
            userDict = [[[GetDataObject alloc] init] FillDictWithQueriedData:keyArray userDict:userDict tempUserIDArr:tempUserIDArr userIDFromLoop:userID snapshot:snapshot];
           
            tempUserIDArr = [[[GetDataObject alloc] init] RemoveAlreadyQueriedUserIDs:tempUserIDArr userIDFromLoop:userID snapshot:snapshot];
            
            if ([[[GeneralObject alloc] init] AddToObjectArrAndCheckIfQueryHasEnded:arrayToLoop objectArr:objectArr]) {
                
                [userDict setObject:userIDArray forKey:@"UserID"];
               
                userDict = [[[GetDataObject alloc] init] RemoveNonExistentUsers:userDict keyArray:keyArray];
               
                userDict = [[[GetDataObject alloc] init] RemoveExcessUserIDFromArrays:keyArray userDict:userDict];
               
                finishBlock(YES, userDict);
                
            }
            
        }];
        
    }
    
}

-(void)GetDataUserNotificationSettingsData:(NSMutableArray *)userIDArray completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningNotificationSettingsDict))finishBlock {
    
    __block NSArray *keyArray = [[[GeneralObject alloc] init] GenerateNotificationSettingsKeyArray];
    __block NSMutableDictionary *notificationSettingsDict = [NSMutableDictionary dictionary];
    
    if (userIDArray.count == 0) {
        finishBlock(YES, notificationSettingsDict);
    } else {
        
        NSMutableArray *objectArr = [NSMutableArray array];
        
        FIRFirestore *defaultFirestore = [FIRFirestore firestore];
        
        for (NSString *userID in userIDArray) {
            
            FIRQuery *queryToUse = [[[defaultFirestore collectionWithPath:@"Users"]
                                     documentWithPath:userID] collectionWithPath:@"NotificationSettings"];
            
            [queryToUse getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
                
                for (FIRDocumentSnapshot *doc in snapshot.documents) {
                    
                    NSMutableDictionary *settingsDict = [NSMutableDictionary dictionary];
                    
                    for (NSString *key in keyArray) {
                        
                        id defaultObject = [key isEqualToString:@"HomeMembers"] ? @{} : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                        
                        id object = doc.data[key] ? doc.data[key] : defaultObject;
                        [settingsDict setObject:object forKey:key];
                        
                    }
                    
                    [notificationSettingsDict setObject:settingsDict forKey:userID];
                    
                }
                
                if ([[[GeneralObject alloc] init] AddToObjectArrAndCheckIfQueryHasEnded:userIDArray objectArr:objectArr]) {
                    
                    finishBlock(YES, notificationSettingsDict);
                    
                }
                
            }];
            
        }
        
    }
    
}

-(void)GetDataUserCalendarSettingsData:(NSMutableArray *)userIDArray completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningCalendarSettingsDict))finishBlock {
    
    __block NSArray *keyArray = [[[GeneralObject alloc] init] GenerateNotificationSettingsKeyArray];
    __block NSMutableDictionary *calendarSettingsDict = [NSMutableDictionary dictionary];
    
    if (userIDArray.count == 0) {
        finishBlock(YES, calendarSettingsDict);
    } else {
        
        NSMutableArray *objectArr = [NSMutableArray array];
        
        FIRFirestore *defaultFirestore = [FIRFirestore firestore];
        
        for (NSString *userID in userIDArray) {
            
            FIRQuery *queryToUse = [[[defaultFirestore collectionWithPath:@"Users"]
                                     documentWithPath:userID] collectionWithPath:@"CalendarSettings"];
            
            [queryToUse getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
                
                for (FIRDocumentSnapshot *doc in snapshot.documents) {
                    
                    NSMutableDictionary *settingsDict = [NSMutableDictionary dictionary];
                    
                    for (NSString *key in keyArray) {
                        
                        id defaultObject = [key isEqualToString:@"HomeMembers"] ? @{} : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                        
                        id object = doc.data[key] ? doc.data[key] : defaultObject;
                        [settingsDict setObject:object forKey:key];
                        
                    }
                    
                    [calendarSettingsDict setObject:settingsDict forKey:userID];
                    
                }
                
                if ([[[GeneralObject alloc] init] AddToObjectArrAndCheckIfQueryHasEnded:userIDArray objectArr:objectArr]) {
                    
                    finishBlock(YES, calendarSettingsDict);
                    
                }
                
            }];
            
        }
        
    }
    
}

-(void)GetDataUserWithEmail:(NSString *)userEmail completionHandler:(void (^)(BOOL finished, FIRQuerySnapshot * _Nullable snapshot))finishBlock {
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[defaultFirestore collectionWithPath:@"Users"] queryWhereField:@"Email" isEqualTo:userEmail] getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
     
        finishBlock(YES, snapshot);
        
    }];
    
}

-(void)GetDataBlockedUser:(NSString *)userID completionHandler:(void (^)(BOOL finished, BOOL userIsBlocked))finishBlock {
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[[defaultFirestore
         collectionWithPath:@"Blocked"]
        documentWithPath:userID]
       collectionWithPath:@"Blocked"]
      documentWithPath:userID]
     getDocumentWithCompletion:^(FIRDocumentSnapshot * _Nullable snapshot, NSError * _Nullable error) {
        
        BOOL userIsBlocked = NO;
        
        if (snapshot.data != nil) {
            
            userIsBlocked = YES;
            
        }
        
        finishBlock(YES, userIsBlocked);
        
    }];
    
}

-(void)GetDataBlockedUsers:(NSArray *)keyArray userID:(NSString *)userID completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningBlockedUserDict))finishBlock {
    
    NSMutableDictionary *blockedUserDict = [NSMutableDictionary dictionary];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[defaultFirestore collectionWithPath:@"Blocked"] documentWithPath:userID] collectionWithPath:@"Blocked"] getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        
        for (FIRDocumentSnapshot *doc in snapshot.documents) {
            
            for (NSString *key in keyArray) {
                
                NSMutableArray *arr = blockedUserDict[key] ? [blockedUserDict[key] mutableCopy] : [NSMutableArray array];
                [arr addObject:doc.data[key]];
                [blockedUserDict setObject:arr forKey:key];
                
            }
            
        }
        
        finishBlock(YES, blockedUserDict);
        
    }];
    
}

-(void)GetDataContacts:(void (^)(BOOL finished, BOOL grantedAccess, NSMutableDictionary *returningContactDict))finishBlock {
    
    NSMutableDictionary *contactDict = [NSMutableDictionary dictionary];
    [contactDict setObject:[NSMutableArray array] forKey:@"FirstName"];
    [contactDict setObject:[NSMutableArray array] forKey:@"LastName"];
    [contactDict setObject:[NSMutableArray array] forKey:@"PhoneNumber"];
    [contactDict setObject:[NSMutableArray array] forKey:@"Image"];
    
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    if( status == CNAuthorizationStatusDenied || status == CNAuthorizationStatusRestricted)
    {
        NSLog(@"access denied");
        finishBlock(YES, NO, contactDict);
    }
    else
    {
        NSLog(@"access granted");
        
        CNContactStore *store = [[CNContactStore alloc] init];
        
        [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            
            if (granted == YES) {
                
                NSArray *keys = @[CNContactFamilyNameKey, CNContactGivenNameKey, CNContactPhoneNumbersKey, CNContactImageDataKey];
                CNContactFetchRequest *request = [[CNContactFetchRequest alloc] initWithKeysToFetch:keys];
                NSError *error;
                
                [store enumerateContactsWithFetchRequest:request error:&error usingBlock:^(CNContact * __nonnull contact, BOOL * __nonnull stop) {
                    
                    if (error) {
                        
                        NSLog(@"error fetching contacts %@", error);
                        
                    } else {
                        
                        if (contact.givenName.length > 0 || contact.familyName.length > 0) {
                            
                            if (contact.givenName != nil) {
                                [contactDict[@"FirstName"] addObject:contact.givenName];
                            } else {
                                [contactDict[@"FirstName"] addObject:@""];
                            }
                            
                            if (contact.familyName != nil) {
                                [contactDict[@"LastName"] addObject:contact.familyName];
                            } else {
                                [contactDict[@"LastName"] addObject:@""];
                            }
                            
                            if (contact.imageData != nil) {
                                [contactDict[@"Image"] addObject:contact.imageData];
                            } else {
                                [contactDict[@"Image"] addObject:@""];
                            }
                            
                            for (CNLabeledValue *label in contact.phoneNumbers) {
                                NSString *phone = [label.value stringValue];
                                if ([phone length] > 0) {
                                    [contactDict[@"PhoneNumber"] addObject:phone];
                                    break;
                                }
                            }
                            
                            if (contact.phoneNumbers.count == 0) {
                                [contactDict[@"PhoneNumber"] addObject:@""];
                            }
                            
                        }
                        
                    }
                    
                }];
                
                finishBlock(YES, granted, contactDict);
                
            } else {
                
                finishBlock(YES, granted, contactDict);
                
            }
            
        }];
        
    }
    
}

-(void)GetDataMixpanelID:(NSString *)userID completionHandler:(void (^)(BOOL finished, NSString *mixPanelID))finishBlock {
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[defaultFirestore collectionWithPath:@"Users"] documentWithPath:userID] getDocumentWithCompletion:^(FIRDocumentSnapshot * _Nullable snapshot, NSError * _Nullable error) {
        
        NSString *mixPanelID = snapshot.data[@"MixPanelID"] ? snapshot.data[@"MixPanelID"] : @"";
        
        finishBlock(YES, mixPanelID);
        
    }];
    
}

#pragma mark - Items

-(void)GetDataItem:(NSString *)itemID itemOccurrenceID:(NSString *)itemOccurrenceID collection:(NSString *)collection homeID:(NSString *)homeID keyArray:(NSArray *)keyArray completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDataDict))finishBlock {
    
    NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    
        FIRFirestore *defaultFirestore = [FIRFirestore firestore];
        
        FIRQuery *queryToUse;
        
        if (itemOccurrenceID.length > 0 && [itemOccurrenceID isEqualToString:@"xxx"] == NO) {
            
            collection = [collection substringToIndex:[collection length] - 1];
            
            queryToUse = [[[[defaultFirestore collectionWithPath:@"Homes"] documentWithPath:homeID] collectionWithPath:[NSString stringWithFormat:@"%@Occurrences", collection]] queryWhereField:@"ItemOccurrenceID" isEqualTo:itemOccurrenceID];
             
        } else {
            
            queryToUse = [[[[defaultFirestore collectionWithPath:@"Homes"] documentWithPath:homeID] collectionWithPath:collection] queryWhereField:@"ItemID" isEqualTo:itemID];
            
        }
        
        [queryToUse getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
            
            for (FIRDocumentSnapshot *doc in snapshot.documents) {
                
                for (NSString *key in keyArray) {
                    
                    id object = doc.data[key] ? doc.data[key] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                    [dataDict setObject:object forKey:key];
                    
                }
                
            }
            
            finishBlock(YES, dataDict);
            
        }];
  
}

-(void)GetDataItemImage:(NSString *)itemImageURL completionHandler:(void (^)(BOOL finished, NSURL *itemImageURL))finishBlock {
    
    FIRStorage *storage = [FIRStorage storage];
    FIRStorageReference *mountainsRef = [storage referenceForURL:itemImageURL];
    
    [mountainsRef downloadURLWithCompletion:^(NSURL * _Nullable URL, NSError * _Nullable error) {
       
        finishBlock(YES, URL.absoluteURL);
        
    }];
    
}

-(void)GetDataItemsInSpecificHome:(NSString *)homeID collection:(NSString *)collection keyArray:(NSArray *)keyArray currentViewController:(UIViewController *)currentViewController crashlyticsString:(NSString *)crashlyticsString completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDataDict))finishBlock {
    
    [[FIRCrashlytics crashlytics] logWithFormat:@"GetDataGetItemsInSpecificHome DateAppOpenned:%@ CurrentTime:%@ Processing(0.17)", [[NSUserDefaults standardUserDefaults] objectForKey:@"DateAppOpenned"], [NSString stringWithFormat:@"%@", [NSDate date]]];
    
    [[FIRCrashlytics crashlytics] logWithFormat:@"GetDataGetItemsInSpecificHome:%@ collection:%@ homeID:%@ Processing(1)", crashlyticsString, collection, homeID];
    
    NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    
    if ([homeID length] == 0) {
        homeID = @"xxx";
    }
    if ([collection length] == 0) {
        collection = @"xxx";
    }
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[defaultFirestore collectionWithPath:@"Homes"] documentWithPath:homeID] collectionWithPath:collection] getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        
        [[FIRCrashlytics crashlytics] logWithFormat:@"GetDataGetItemsInSpecificHome:%@ collection:%@ error:%@ snapshot.documents.count:%lu Processing(2)", crashlyticsString, collection, error.description, snapshot.documents.count];
        
        
        
        for (FIRDocumentSnapshot *doc in snapshot.documents) {
            
            [[FIRCrashlytics crashlytics] logWithFormat:@"GetDataGetItemsInSpecificHome:%@ doc:%@ Processing(3)", crashlyticsString, doc];
            
            for (NSString *key in keyArray) {
                
                [[FIRCrashlytics crashlytics] logWithFormat:@"GetDataGetItemsInSpecificHome:%@ key:%@ Processing(3.0.0)", crashlyticsString, key];
                
                NSMutableArray *arr = dataDict[key] ? [dataDict[key] mutableCopy] : [NSMutableArray array];
                
                [[FIRCrashlytics crashlytics] logWithFormat:@"GetDataGetItemsInSpecificHome:%@ arr.count:%lu Processing(3.0.1)", crashlyticsString, (unsigned long)arr.count];
                
                id object = doc.data[key] ? doc.data[key] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                
                [[FIRCrashlytics crashlytics] logWithFormat:@"GetDataGetItemsInSpecificHome:%@ object:%@ Processing(3.0.2)", crashlyticsString, object];
                
                [arr addObject:object];
                
                [[FIRCrashlytics crashlytics] logWithFormat:@"GetDataGetItemsInSpecificHome:%@ arr.count:%lu Processing(3.0.3)", crashlyticsString, (unsigned long)arr.count];
                
                [dataDict setObject:arr forKey:key];
                
                [[FIRCrashlytics crashlytics] logWithFormat:@"GetDataGetItemsInSpecificHome:%@ key:%@ Processing(3.0.4)", crashlyticsString, key];
                
            }
            
        }
        
        
        
        [[FIRCrashlytics crashlytics] logWithFormat:@"GetDataGetItemsInSpecificHome Processing(3.0.5)"];
        
        if (dataDict[@"ItemAssignedTo"]) {
            
            [[FIRCrashlytics crashlytics] logWithFormat:@"GetDataGetItemsInSpecificHome Processing(3.0.6)"];
            
            for (NSMutableArray *itemAssignedTo in dataDict[@"ItemAssignedTo"]) {
                
                if ([[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] &&
                    ([itemAssignedTo containsObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] || itemAssignedTo.count == 0)) {
                    
                    [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"DisplayRegisterForNotificationsPopup"];
                    
                }
                
            }
            
            [[FIRCrashlytics crashlytics] logWithFormat:@"GetDataGetItemsInSpecificHome Processing(3.0.7)"];
            
        }
        
        [[FIRCrashlytics crashlytics] logWithFormat:@"GetDataGetItemsInSpecificHome Processing(3.0.8)"];
        
        
        
        finishBlock(YES, dataDict);
        
    }];
    
}

-(void)GetDataItemsInSpecificHome_Chores_BugFix:(NSString *)homeID collection:(NSString *)collection keyArray:(NSArray *)keyArray currentViewController:(UIViewController *)currentViewController crashlyticsString:(NSString *)crashlyticsString completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningDataDict))finishBlock {
    
    [[FIRCrashlytics crashlytics] logWithFormat:@"GetDataGetItemsInSpecificHome DateAppOpenned:%@ CurrentTime:%@ Processing(0.17)", [[NSUserDefaults standardUserDefaults] objectForKey:@"DateAppOpenned"], [NSString stringWithFormat:@"%@", [NSDate date]]];
    
    [[FIRCrashlytics crashlytics] logWithFormat:@"GetDataGetItemsInSpecificHome:%@ collection:%@ homeID:%@ Processing(1)", crashlyticsString, collection, homeID];
    
    NSMutableDictionary *dataDict = [NSMutableDictionary dictionary];
    
    if ([homeID length] == 0) {
        homeID = @"xxx";
    }
    if ([collection length] == 0) {
        collection = @"xxx";
    }
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[defaultFirestore collectionWithPath:@"Homes"] documentWithPath:homeID] collectionWithPath:collection] getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        
        [[FIRCrashlytics crashlytics] logWithFormat:@"GetDataGetItemsInSpecificHome:%@ collection:%@ error:%@ snapshot.documents.count:%lu Processing(2)", crashlyticsString, collection, error.description, snapshot.documents.count];
        
        
        
        for (FIRDocumentSnapshot *doc in snapshot.documents) {
            
            [[FIRCrashlytics crashlytics] logWithFormat:@"GetDataGetItemsInSpecificHome:%@ doc:%@ Processing(3)", crashlyticsString, doc];
            
            for (NSString *key in keyArray) {
                
                [[FIRCrashlytics crashlytics] logWithFormat:@"GetDataGetItemsInSpecificHome:%@ key:%@ Processing(3.0.0)", crashlyticsString, key];
                
                NSMutableArray *arr = dataDict[key] ? [dataDict[key] mutableCopy] : [NSMutableArray array];
                
                [[FIRCrashlytics crashlytics] logWithFormat:@"GetDataGetItemsInSpecificHome:%@ arr.count:%lu Processing(3.0.1)", crashlyticsString, (unsigned long)arr.count];
                
                id object = doc.data[key] ? doc.data[key] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                
                [[FIRCrashlytics crashlytics] logWithFormat:@"GetDataGetItemsInSpecificHome:%@ object:%@ Processing(3.0.2)", crashlyticsString, object];
                
                [arr addObject:object];
                
                [[FIRCrashlytics crashlytics] logWithFormat:@"GetDataGetItemsInSpecificHome:%@ arr.count:%lu Processing(3.0.3)", crashlyticsString, (unsigned long)arr.count];
                
                [dataDict setObject:arr forKey:key];
                
                [[FIRCrashlytics crashlytics] logWithFormat:@"GetDataGetItemsInSpecificHome:%@ key:%@ Processing(3.0.4)", crashlyticsString, key];
                
            }
            
        }
        
        
        
        [[FIRCrashlytics crashlytics] logWithFormat:@"GetDataGetItemsInSpecificHome Processing(3.0.5)"];
        
        if (dataDict[@"ItemAssignedTo"]) {
            
            [[FIRCrashlytics crashlytics] logWithFormat:@"GetDataGetItemsInSpecificHome Processing(3.0.6)"];
            
            for (NSMutableArray *itemAssignedTo in dataDict[@"ItemAssignedTo"]) {
                
                if ([[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] &&
                    ([itemAssignedTo containsObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] || itemAssignedTo.count == 0)) {
                    
                    [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"DisplayRegisterForNotificationsPopup"];
                    
                }
                
            }
            
            [[FIRCrashlytics crashlytics] logWithFormat:@"GetDataGetItemsInSpecificHome Processing(3.0.7)"];
            
        }
        
        [[FIRCrashlytics crashlytics] logWithFormat:@"GetDataGetItemsInSpecificHome Processing(3.0.8)"];
        
        
        
        finishBlock(YES, dataDict);
        
    }];
    
}

-(void)GetDataItemsInSpecificHomeWithSpecificQuery:(NSString *)homeID collection:(NSString *)collection QueryAssignedToNewHomeMember:(BOOL)QueryAssignedToNewHomeMember QueryAssignedTo:(BOOL)QueryAssignedTo queryAssignedToUserID:(NSString *)queryAssignedToUserID completionHandler:(void (^)(BOOL finished, FIRQuerySnapshot *snapshot))finishBlock {
    
    if (QueryAssignedToNewHomeMember == NO && QueryAssignedTo == NO) {
        
        finishBlock(YES, nil);
        
    } else {
        
        FIRFirestore *defaultFirestore = [FIRFirestore firestore];
        
        FIRQuery *queryToUse = [[[[defaultFirestore collectionWithPath:@"Homes"] documentWithPath:homeID] collectionWithPath:collection] queryWhereField:@"ItemHomeID" isEqualTo:homeID];
        
        if (QueryAssignedToNewHomeMember == YES && QueryAssignedTo == NO) {
            
            queryToUse = [[[[[defaultFirestore collectionWithPath:@"Homes"] documentWithPath:homeID] collectionWithPath:collection] queryWhereField:@"ItemHomeID" isEqualTo:homeID] queryWhereField:@"ItemAssignedToNewHomeMembers" isEqualTo:@"Yes"];
            
        } else if (QueryAssignedToNewHomeMember == NO && QueryAssignedTo == YES) {
            
            queryToUse = [[[[[defaultFirestore collectionWithPath:@"Homes"] documentWithPath:homeID] collectionWithPath:collection] queryWhereField:@"ItemHomeID" isEqualTo:homeID] queryWhereField:@"ItemAssignedTo" arrayContains:queryAssignedToUserID];
            
        } else if (QueryAssignedToNewHomeMember == YES && QueryAssignedTo == YES) {
            
            queryToUse = [[[[[[defaultFirestore collectionWithPath:@"Homes"] documentWithPath:homeID] collectionWithPath:collection] queryWhereField:@"ItemHomeID" isEqualTo:homeID] queryWhereField:@"ItemAssignedToNewHomeMembers" isEqualTo:@"Yes"] queryWhereField:@"ItemAssignedTo" arrayContains:queryAssignedToUserID];
            
        }
        
        [queryToUse getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
            
            finishBlock(YES, snapshot);
            
        }];
        
    }
    
}

-(void)GetDataGetItemsTurnUserID:(NSString *)homeID collection:(NSString *)collection userID:(NSString *)userID keyArray:(NSArray *)keyArray completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningItemsDict))finishBlock {
    
    NSMutableDictionary *itemsDict = [NSMutableDictionary dictionary];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[[defaultFirestore collectionWithPath:@"Homes"] documentWithPath:homeID] collectionWithPath:collection] queryWhereField:@"ItemTurnUserID" isEqualTo:userID] getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
        
        for (FIRDocumentSnapshot *doc in snapshot.documents) {
            
            for (NSString *key in keyArray) {
                
                NSMutableArray *arr = itemsDict[key] ? [itemsDict[key] mutableCopy] : [NSMutableArray array];
                id object = doc.data[key] ? doc.data[key] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                [arr addObject:object];
                [itemsDict setObject:arr forKey:key];
                
                
            }
            
        }
        
        finishBlock(YES, itemsDict);
        
    }];
    
}

-(void)GetDataGetItemsCreatedBy:(NSString *)homeID collection:(NSString *)collection userID:(NSString *)userID completionHandler:(void (^)(BOOL finished, FIRQuerySnapshot *snapshot))finishBlock {
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[[defaultFirestore collectionWithPath:@"Homes"] documentWithPath:homeID] collectionWithPath:collection] queryWhereField:@"ItemCreatedBy" isEqualTo:userID] getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable thirdSnapshot, NSError * _Nullable error) {
        
        finishBlock(YES, thirdSnapshot);
        
    }];
    
}

-(void)GetDataGetItemsCompletedBy:(NSString *)homeID collection:(NSString *)collection userID:(NSString *)userID completionHandler:(void (^)(BOOL finished, FIRQuerySnapshot *snapshot))finishBlock {
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    [[[[[defaultFirestore collectionWithPath:@"Homes"] documentWithPath:homeID] collectionWithPath:collection] queryWhereField:@"ItemCompletedDict" arrayContains:userID] getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable thirdSnapshot, NSError * _Nullable error) {
        
        finishBlock(YES, thirdSnapshot);
        
    }];
    
}

-(void)GetDataItemOccurrencesForSingleItem:(NSString *)collection itemID:(NSString *)itemID homeID:(NSString *)homeID keyArray:(NSArray *)keyArray completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningOccurrencesDict))finishBlock {

        NSMutableDictionary *occurrencesDict = [NSMutableDictionary dictionary];
        
        FIRFirestore *defaultFirestore = [FIRFirestore firestore];
        
        BOOL ObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:itemID classArr:@[[NSString class]]];
        BOOL ObjectIsKindOfClassNo1 = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:collection classArr:@[[NSString class]]];
        
        itemID = itemID && ObjectIsKindOfClass == YES && [itemID length] > 0 ? itemID : @"xxx";
        collection = collection && ObjectIsKindOfClassNo1 == YES && [collection length] > 0 ? collection : @"xxx";
        
        collection = [collection substringToIndex:[collection length] - 1];
       
        [[[[[defaultFirestore collectionWithPath:@"Homes"] documentWithPath:homeID] collectionWithPath:[NSString stringWithFormat:@"%@Occurrences", collection]] queryWhereField:@"ItemID" isEqualTo:itemID] getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
            
            for (FIRDocumentSnapshot *doc in snapshot.documents) {
                
                for (NSString *key in keyArray) {
                    
                    NSMutableArray *arr = occurrencesDict[key] ? [occurrencesDict[key] mutableCopy] : [NSMutableArray array];
                    id object = doc.data[key] ? doc.data[key] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                    [arr addObject:object];
                    [occurrencesDict setObject:arr forKey:key];
                    
                    
                }
                
            }
            
            finishBlock(YES, occurrencesDict);
            
        }];
    
}

#pragma mark

-(void)GetDataItemOccurrenceAmounts:(NSString *)collection homeID:(NSString *)homeID itemID:(NSString *)itemID keyArray:(NSArray *)keyArray ItemOccurrenceStatusCompleted:(BOOL)ItemOccurrenceStatus completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningOccurrencesDict))finishBlock {
    
    NSMutableDictionary *occurrencesDict = [NSMutableDictionary dictionary];
    
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    if ([homeID length] == 0) {
        homeID = @"xxx";
    }
    if ([collection length] == 0) {
        collection = @"xxx";
    }
    
    collection = [collection substringToIndex:[collection length] - 1];
    
    FIRQuery *queryToUse = [[[[defaultFirestore collectionWithPath:@"Homes"] documentWithPath:homeID] collectionWithPath:[NSString stringWithFormat:@"%@Occurrences", collection]] queryWhereField:@"ItemID" isEqualTo:itemID];
    
    if (ItemOccurrenceStatus == YES) {
        queryToUse = [[[[[defaultFirestore collectionWithPath:@"Homes"] documentWithPath:homeID] collectionWithPath:[NSString stringWithFormat:@"%@Occurrences", collection]] queryWhereField:@"ItemID" isEqualTo:itemID] queryWhereField:@"ItemOccurrenceStatus" isEqualTo:@"Completed"];
    }
   
    [queryToUse getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
       
        [occurrencesDict setObject:[NSString stringWithFormat:@"%lu", snapshot.documents.count] forKey:itemID];
        
        finishBlock(YES, occurrencesDict);
        
    }];
    
}

#pragma mark

-(void)GetDataItemOccurrencesEndNumberOfTimes_Amounts:(NSString *)collection homeID:(NSString *)homeID dictToUse:(NSMutableDictionary *)dictToUse keyArray:(NSArray *)keyArray completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningOccurrencesDict))finishBlock {
    
    NSMutableDictionary *occurrencesDict = [NSMutableDictionary dictionary];
    
    if ([(NSArray *)dictToUse[@"ItemUniqueID"] count] == 0) {
        finishBlock(YES, occurrencesDict);
    } else {
        
        NSMutableArray *objectArr = [NSMutableArray array];
        
        for (NSString *itemUniqueID in dictToUse[@"ItemUniqueID"]) {
            
            NSUInteger index = [dictToUse[@"ItemUniqueID"] indexOfObject:itemUniqueID];
            NSString *itemID = dictToUse[@"ItemID"][index];
            NSString *itemOccurrenceID = dictToUse[@"ItemOccurrenceID"][index];
            NSString *itemEndNumberOfTimes = dictToUse[@"ItemEndNumberOfTimes"][index];
            
            if ([itemEndNumberOfTimes isEqualToString:@"Yes"] && itemOccurrenceID.length == 0) {
                
                [[[GetDataObject alloc] init] GetDataItemOccurrenceAmounts:collection homeID:homeID itemID:itemID keyArray:keyArray ItemOccurrenceStatusCompleted:NO completionHandler:^(BOOL finished, NSMutableDictionary *returningOccurrencesDict) {
                    
                    for (NSString *key in [returningOccurrencesDict allKeys]) {
                        [occurrencesDict setObject:returningOccurrencesDict[key] forKey:key];
                    }
                    
                    if ([[[GeneralObject alloc] init] AddToObjectArrAndCheckIfQueryHasEnded:[dictToUse[@"ItemUniqueID"] mutableCopy] objectArr:objectArr]) {
                        
                        finishBlock(YES, occurrencesDict);
                        
                    }
                    
                }];
                
            } else {
                
                if ([[[GeneralObject alloc] init] AddToObjectArrAndCheckIfQueryHasEnded:[dictToUse[@"ItemUniqueID"] mutableCopy] objectArr:objectArr]) {
                    
                    finishBlock(YES, occurrencesDict);
                    
                }
                
            }
            
        }
        
    }
    
}

-(void)GetDataItemOccurrencesAlternatingTurnsCompleted_Amounts:(NSString *)collection homeID:(NSString *)homeID dictToUse:(NSMutableDictionary *)dictToUse keyArray:(NSArray *)keyArray completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningOccurrencesDict))finishBlock {
    
    NSMutableDictionary *occurrencesDict = [NSMutableDictionary dictionary];
    
    if ([(NSArray *)dictToUse[@"ItemUniqueID"] count] == 0) {
        finishBlock(YES, occurrencesDict);
    } else {
        
        NSMutableArray *objectArr = [NSMutableArray array];
        
        for (NSString *itemUniqueID in dictToUse[@"ItemUniqueID"]) {
            
            NSUInteger index = [dictToUse[@"ItemUniqueID"] indexOfObject:itemUniqueID];
            NSString *itemID = dictToUse[@"ItemID"][index];
            NSString *itemOccurrenceID = dictToUse[@"ItemOccurrenceID"][index];
            NSString *itemAlternateTurns = dictToUse[@"ItemAlternateTurns"][index];
            
            if ([itemAlternateTurns length] > 0 && itemOccurrenceID.length == 0 && [itemAlternateTurns containsString:@" Completion"]) {
                
                [[[GetDataObject alloc] init] GetDataItemOccurrenceAmounts:collection homeID:homeID itemID:itemID keyArray:keyArray ItemOccurrenceStatusCompleted:YES completionHandler:^(BOOL finished, NSMutableDictionary *returningOccurrencesDict) {
                    
                    for (NSString *key in [returningOccurrencesDict allKeys]) {
                        [occurrencesDict setObject:returningOccurrencesDict[key] forKey:key];
                    }
                    
                    if ([[[GeneralObject alloc] init] AddToObjectArrAndCheckIfQueryHasEnded:[dictToUse[@"ItemUniqueID"] mutableCopy] objectArr:objectArr]) {
                        
                        finishBlock(YES, occurrencesDict);
                        
                    }
                    
                }];
                
            } else {
                
                if ([[[GeneralObject alloc] init] AddToObjectArrAndCheckIfQueryHasEnded:[dictToUse[@"ItemUniqueID"] mutableCopy] objectArr:objectArr]) {
                    
                    finishBlock(YES, occurrencesDict);
                    
                }
                
            }
            
        }
        
    }
    
}

-(void)GetDataItemOccurrencesAlternatingTurnsOccurrences_Amounts:(NSString *)collection homeID:(NSString *)homeID dictToUse:(NSMutableDictionary *)dictToUse keyArray:(NSArray *)keyArray completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningOccurrencesDict))finishBlock {
    
    NSMutableDictionary *occurrencesDict = [NSMutableDictionary dictionary];
    
    if ([(NSArray *)dictToUse[@"ItemUniqueID"] count] == 0) {
        finishBlock(YES, occurrencesDict);
    } else {
        
        NSMutableArray *objectArr = [NSMutableArray array];
        
        for (NSString *itemUniqueID in dictToUse[@"ItemUniqueID"]) {
            
            NSUInteger index = [dictToUse[@"ItemUniqueID"] indexOfObject:itemUniqueID];
            NSString *itemID = dictToUse[@"ItemID"][index];
            NSString *itemOccurrenceID = dictToUse[@"ItemOccurrenceID"][index];
            NSString *itemAlternateTurns = dictToUse[@"ItemAlternateTurns"][index];
           
            if ([itemAlternateTurns length] > 0 && itemOccurrenceID.length == 0 && [itemAlternateTurns containsString:@" Occurrence"]) {
               
                [[[GetDataObject alloc] init] GetDataItemOccurrenceAmounts:collection homeID:homeID itemID:itemID keyArray:keyArray ItemOccurrenceStatusCompleted:NO completionHandler:^(BOOL finished, NSMutableDictionary *returningOccurrencesDict) {
                    
                    for (NSString *key in [returningOccurrencesDict allKeys]) {
                        [occurrencesDict setObject:returningOccurrencesDict[key] forKey:key];
                    }
                    
                    if ([[[GeneralObject alloc] init] AddToObjectArrAndCheckIfQueryHasEnded:[dictToUse[@"ItemUniqueID"] mutableCopy] objectArr:objectArr]) {
                       
                        finishBlock(YES, occurrencesDict);
                        
                    }
                    
                }];
                
            } else {
                
                if ([[[GeneralObject alloc] init] AddToObjectArrAndCheckIfQueryHasEnded:[dictToUse[@"ItemUniqueID"] mutableCopy] objectArr:objectArr]) {
                   
                    finishBlock(YES, occurrencesDict);
                    
                }
                
            }
            
        }
        
    }
    
}

#pragma mark

-(void)GetDataItemOccurrences_OccurrenceStatusNone_NotFullyCompleted:(NSString *)collection homeID:(NSString *)homeID keyArray:(NSArray *)keyArray itemType:(NSString *)itemType homeMembersDict:(NSMutableDictionary *)homeMembersDict completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningOccurrencesDict))finishBlock {
    
    NSMutableDictionary *occurrencesDict = [NSMutableDictionary dictionary];
   
    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
    
    if ([homeID length] == 0) {
        homeID = @"xxx";
    }
    if ([collection length] == 0) {
        collection = @"xxx";
    }
    
    collection = [collection substringToIndex:[collection length] - 1];
    
    [[[[[defaultFirestore collectionWithPath:@"Homes"] documentWithPath:homeID] collectionWithPath:[NSString stringWithFormat:@"%@Occurrences", collection]] queryWhereField:@"ItemOccurrenceStatus" isEqualTo:@"None"] getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
      
        for (FIRDocumentSnapshot *doc in snapshot.documents) {
            
            NSMutableDictionary *tempItemOccurrenceDict = [NSMutableDictionary dictionary];
            
            for (NSString *key in keyArray) {
                
                id object = doc.data[key] ? doc.data[key] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                [tempItemOccurrenceDict setObject:object forKey:key];
                
            }
            
            BOOL TaskIsFullyCompleted = [[[BoolDataObject alloc] init] TaskIsFullyCompleted:tempItemOccurrenceDict itemType:itemType homeMembersDict:homeMembersDict];
            
            if (TaskIsFullyCompleted == NO && [tempItemOccurrenceDict[@"ItemOccurrenceStatus"] isEqualToString:@"None"]) {
                
                for (NSString *key in keyArray) {
                    
                    NSMutableArray *arr = occurrencesDict[key] ? [occurrencesDict[key] mutableCopy] : [NSMutableArray array];
                    id object = doc.data[key] ? doc.data[key] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                    [arr addObject:object];
                    [occurrencesDict setObject:arr forKey:key];
                    
                }
                
            }
            
        }
        
        finishBlock(YES, occurrencesDict);
        
    }];
    
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Internal Methods
#pragma mark
#pragma mark
#pragma mark -

#pragma mark Users

-(NSMutableDictionary *)FillDictWithArrays:(NSArray *)keyArray userDict:(NSMutableDictionary *)userDict {
    
    for (NSString *key in keyArray) {
        [userDict setObject:[NSMutableArray array] forKey:key];
    }
    
    return userDict;
    
}

-(NSMutableDictionary *)FillDictWithData:(NSArray *)keyArray userDict:(NSMutableDictionary *)userDict userIDArray:(NSMutableArray *)userIDArray {
    
    for (NSString *key in keyArray) {
        
        for (NSString *userID in userIDArray) {
            
            if (userDict[key]) {
                
                [userDict[key] addObject:userID];
                
            }
            
        }
        
    }
    
    return userDict;
    
}


-(NSMutableDictionary *)FillDictWithQueriedData:(NSArray *)keyArray userDict:(NSMutableDictionary *)userDict tempUserIDArr:(NSMutableArray *)tempUserIDArr userIDFromLoop:(NSString *)userIDFromLoop snapshot:(FIRQuerySnapshot *)snapshot {
    
    for (FIRDocumentSnapshot *doc in snapshot.documents) {
        
        for (NSString *key in keyArray) {
            
            NSMutableArray *arr = userDict[key] ? [userDict[key] mutableCopy] : [NSMutableArray array];
            
            if (doc.data[@"UserID"]) {
                
                NSUInteger index =
                [tempUserIDArr containsObject:doc.data[@"UserID"]] ?
                [tempUserIDArr indexOfObject:doc.data[@"UserID"]] :
                -1;
                
                if (doc.data == nil) {
                    
                    NSUInteger index =
                    [tempUserIDArr containsObject:userIDFromLoop] ?
                    [tempUserIDArr indexOfObject:userIDFromLoop] :
                    -1;
                    
                    if (arr.count > index) { [arr replaceObjectAtIndex:index withObject:@"User Does Not Exist"]; }
                    
                } else {
                    
                    id object = doc.data[key] ? doc.data[key] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                    
                    BOOL ObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:object classArr:@[[NSString class]]];
                    
                    if ([key isEqualToString:@"WeDivvyPremium"] && ObjectIsKindOfClass == YES) {
                        object = [[[GeneralObject alloc] init] GenerateDefaultWeDivvyPremiumPlan];
                    }
                    
                    if (arr.count > index) { [arr replaceObjectAtIndex:index withObject:object]; }
                    
                }
                
            }
            
            [userDict setObject:arr forKey:key];
            
        }
        
    }
    
    return userDict;
    
}

-(NSMutableDictionary *)RemoveExcessUserIDFromArrays:(NSArray *)keyArray userDict:(NSMutableDictionary *)userDict {
    
    for (NSString *key in keyArray) {
        
        if ([key isEqualToString:@"UserID"] == NO && [key isEqualToString:@"WeDivvyPremium"] == NO) {
            
            NSMutableArray *tempArr = [userDict[key] mutableCopy];
            
            for (id object in [tempArr mutableCopy]) {
                
                if (([object containsString:@"2022-"] && [object containsString:@"firebasestorage.googleapis.com"] == NO) ||
                    ([object containsString:@"2023-"] && [object containsString:@"firebasestorage.googleapis.com"] == NO) ||
                    ([object containsString:@"2024-"] && [object containsString:@"firebasestorage.googleapis.com"] == NO) ||
                    ([object containsString:@"2025-"] && [object containsString:@"firebasestorage.googleapis.com"] == NO) ||
                    ([object containsString:@"2026-"] && [object containsString:@"firebasestorage.googleapis.com"] == NO) ||
                    ([object containsString:@"2027-"] && [object containsString:@"firebasestorage.googleapis.com"] == NO) ||
                    ([object containsString:@"2028-"] && [object containsString:@"firebasestorage.googleapis.com"] == NO) ||
                    ([object containsString:@"2029-"] && [object containsString:@"firebasestorage.googleapis.com"] == NO)) {
                    
                    [tempArr removeObject:object];
                    
                }
                
            }
            
            [userDict setObject:tempArr forKey:key];
            
        } else if ([key isEqualToString:@"WeDivvyPremium"] == YES) {
            
            NSMutableArray *tempArr = [userDict[key] mutableCopy];
            
            for (id object in [tempArr mutableCopy]) {
                
                BOOL ObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:object classArr:@[[NSString class]]];
                
                if (ObjectIsKindOfClass == YES) {
                    
                    [tempArr removeObject:object];
                    
                }
                
            }
            
            [userDict setObject:tempArr forKey:key];
            
        }
        
    }
    
    return userDict;
}

-(NSMutableDictionary *)RemoveNonExistentUsers:(NSMutableDictionary *)userDict keyArray:(NSArray *)keyArray {
    
    NSMutableDictionary *userDictCopy = [userDict mutableCopy];
    
    if (userDictCopy[@"Notifications"]) {
        
        for (int i=0;i<[(NSArray *)userDictCopy[@"Notifications"] count];i++) {
            
            if ([userDictCopy[@"Notifications"][i] containsString:@"-"]) {
                
                for (NSString *key in keyArray) {
                    
                    if (userDict[key] && [(NSArray *)userDict[key] count] > i) { [userDict[key] removeObjectAtIndex:i]; }
                    
                }
                
                if (userDict[@"UserID"] && [(NSArray *)userDict[@"UserID"] count] > i) { [userDict[@"UserID"] removeObjectAtIndex:i]; }
                
            }
            
        }
        
    }
    
    return userDict;
    
}

-(NSMutableArray *)RemoveAlreadyQueriedUserIDs:(NSMutableArray *)tempUserIDArr userIDFromLoop:(NSString *)userIDFromLoop snapshot:(FIRQuerySnapshot *)snapshot {
    
    for (FIRDocumentSnapshot *doc in snapshot.documents) {
        
        NSUInteger index = -1;
        
        if (doc.data == nil) {
            
            index =
            [tempUserIDArr containsObject:userIDFromLoop] ?
            [tempUserIDArr indexOfObject:userIDFromLoop] :
            -1;
            
        } else if (doc.data[@"UserID"]) {
            
            index =
            [tempUserIDArr containsObject:doc.data[@"UserID"]] ?
            [tempUserIDArr indexOfObject:doc.data[@"UserID"]] :
            -1;
            
        }
        
        if (tempUserIDArr.count > index) { [tempUserIDArr replaceObjectAtIndex:index withObject:@"xxx"]; }
        
    }
    
    return tempUserIDArr;
    
}


@end
