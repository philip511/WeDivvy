//
//  HomesViewControllerObject.m
//  WeDivvy
//
//  Created by Philip Nagel on 9/19/21.
//

#import "HomesViewControllerObject.h"

#import <Mixpanel/Mixpanel.h>

#import "GetDataObject.h"
#import "SetDataObject.h"
#import "DeleteDataObject.h"
#import "PushObject.h"
#import "GeneralObject.h"
#import "BoolDataObject.h"
#import "NotificationsObject.h"

@implementation HomesViewControllerObject

-(void)CreateHome:(NSString *)homeID homeName:(NSString *)homeName homeMemberArray:(NSMutableArray *)homeMemberArray keyCode:(NSString *)keyCode completionHandler:(void (^)(BOOL finished, NSDictionary *returningHomeDict))finishBlock {
   
    __block int totalQueries = 2;
    __block int completedQueries = 0;
    
    
    
    NSDictionary *homeDict = [self GenerateHomeDict:homeID homeName:homeName homeMemberArray:homeMemberArray keyCode:keyCode];
    
    
    
    /*
     //
     //
     //Set Home Data
     //
     //
     */
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[SetDataObject alloc] init] SetDataAddHome:homeID homeDict:homeDict completionHandler:^(BOOL finished) {
            
            [self CreateHomeFinishBlock:homeDict totalQueries:totalQueries completedQueries:(completedQueries+=1) completionHandler:^(BOOL finished, NSDictionary *returningHomeDict) {
               
                finishBlock(YES, homeDict);
                
            }];
            
        }];
        
    });
    
//    /*
//     //
//     //
//     //Update User Data
//     //
//     //
//     */
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        
//        NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
//        
//        [[[SetDataObject alloc] init] UpdateDataUserData:userID userDict:@{@"KeyCode" : keyCode} completionHandler:^(BOOL finished, NSError * _Nonnull error) {
//            
//            [self CreateHomeFinishBlock:homeDict totalQueries:totalQueries completedQueries:(completedQueries+=1) completionHandler:^(BOOL finished, NSDictionary *returningHomeDict) {
//                
//                finishBlock(YES, homeDict);
//                
//            }];
//            
//        }];
//        
//    });
    
//    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
//    NSString *homeCreationDate = [[[GeneralObject alloc] init] GenerateCurrentDateString];
//    
//    FIRFirestore *defaultFirestore = [FIRFirestore firestore];
//    
//    [[[defaultFirestore collectionWithPath:@"InvitationCodes"] documentWithPath:keyCode] setData:@{@"InvitationCodeUsed" : @"Yes", @"InvitationCodeDateUsed" : homeCreationDate, @"InvitationCodeUserID" : userID, @"InvitationCodeHomeID" : homeID} merge:YES completion:^(NSError * _Nullable error) {
//        
//        finishBlock(YES, homeDict);
//        
//    }];
    
    
    /*
     //
     //
     //Set Home Chat Data
     //
     //
     */
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *chatID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
        
        NSMutableDictionary *itemDict = [self GenerateGroupChatDict:chatID homeID:homeID homeName:homeName];
        
        [[[SetDataObject alloc] init] SetDataAddGroupChat:homeID itemDict:itemDict completionHandler:^(BOOL finished) {
            
            [self CreateHomeFinishBlock:homeDict totalQueries:totalQueries completedQueries:(completedQueries+=1) completionHandler:^(BOOL finished, NSDictionary *returningHomeDict) {
                
                finishBlock(YES, homeDict);
                
            }];
            
        }];
      
    });
    
    
    /*
     //
     //
     //Send Notification To Creator
     //
     //
     */
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[NotificationsObject alloc] init] SendPushNotificationToCreator:[NSString stringWithFormat:@"%@ - Created Home", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] notificationBody:[NSString stringWithFormat:@"Home ID - %@", homeID] badgeNumber:(NSInteger *)1 completionHandler:^(BOOL finished) {
            
        }];
        
    });
    
}

-(void)JoinHome:(NSString *)homeID homeKey:(NSString *)homeKey topicDict:(NSMutableDictionary *)topicDict clickedUnclaimedUser:(BOOL)clickedUnclaimedUser enabledNotifications:(BOOL)enabledNotifications currentViewController:(UIViewController *)currentViewController completionHandler:(void (^)(BOOL finished))finishBlock {
    
    if (clickedUnclaimedUser) {
        
        [self UnclaimedUserJoiningHome:homeID homeKey:homeKey topicDict:topicDict clickedUnclaimedUser:clickedUnclaimedUser enabledNotifications:enabledNotifications currentViewController:currentViewController completionHandler:^(BOOL finished) {
            
            [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"JoinedHome"];
            
            finishBlock(YES);
            
        }];
        
    } else {
        
        [self NewUserJoiningHome:homeID homeKey:homeKey topicDict:topicDict clickedUnclaimedUser:clickedUnclaimedUser enabledNotifications:enabledNotifications currentViewController:currentViewController completionHandler:^(BOOL finished) {
            
            [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"JoinedHome"];
            
            finishBlock(YES);
            
        }];
        
    }
    
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Internal Methods
#pragma mark
#pragma mark
#pragma mark -

#pragma mark Create Home

-(NSDictionary *)GenerateHomeDict:(NSString *)homeID homeName:(NSString *)homeName homeMemberArray:(NSMutableArray *)homeMemberArray keyCode:(NSString *)keyCode {
    
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
    
    NSString *homeKey = [[[GeneralObject alloc] init] GenerateRandomSmallNumberIntoString:100000 upperBound:999999];
    NSString *homeCreationDate = [[[GeneralObject alloc] init] GenerateCurrentDateString];
    
    NSDictionary *homeDict = @{@"HomeName" : homeName,
                               @"HomeID" : homeID,
                               @"HomeImageURL" : @"xxx",
                               @"HomeMembers" : homeMemberArray,
                               @"HomeMembersUnclaimed" : [NSMutableDictionary dictionary],
                               @"HomeKey" : homeKey,
                               @"HomeKeys" : [NSMutableDictionary dictionary],
                               @"HomeKeysArray" : [NSMutableArray array],
                               @"HomeCreationDate": homeCreationDate,
                               @"HomeOwnerUserID" : userID,
                               @"HomeWeDivvyPremium" : @"No",
                               @"HomeKeyCode" : keyCode
    };
    
    return homeDict;
}

-(NSMutableDictionary *)GenerateGroupChatDict:(NSString *)chatID homeID:(NSString *)homeID homeName:(NSString *)homeName {
    
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
    NSString *chatName = [NSString stringWithFormat:@"%@'s Main Chat", homeName];
    
    NSMutableDictionary *itemDict = [@{
        
        @"ChatID" : chatID,
        @"ChatCreatedBy" : userID,
        @"ChatDateCreated" : [[[GeneralObject alloc] init] GenerateCurrentDateString],
        @"ChatName" : chatName,
        @"ChatImageURL" : @"xxx",
        @"ChatAssignedTo" : @[userID],
        @"ChatAssignedToNewHomeMembers" : @"Yes",
        @"ChatHomeID" : homeID
        
    } mutableCopy];
    
    return itemDict;
}

-(void)CreateHomeFinishBlock:(NSDictionary *)homeDict totalQueries:(int)totalQueries completedQueries:(int)completedQueries completionHandler:(void (^)(BOOL finished, NSDictionary *returningHomeDict))finishBlock {
    
    if (totalQueries == completedQueries) {
      
        [[NSUserDefaults standardUserDefaults] setObject:homeDict forKey:@"HomeChosen"];
        [[[GeneralObject alloc] init] CallNSNotificationMethods:@"AddHome" userInfo:homeDict locations:@[@"Homes"]];
        
        [[NSUserDefaults standardUserDefaults] setObject:homeDict[@"HomeMembers"] forKey:@"HomeMembersArray"];
        [[NSUserDefaults standardUserDefaults] setObject:homeDict forKey:@"HomeDict"];
        [[NSUserDefaults standardUserDefaults] setObject:[self GenerateNewHomeMembersDict] forKey:@"HomeMembersDict"];
        
        if ([[[BoolDataObject alloc] init] PremiumSubscriptionIsOn] == NO) {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"WeDivvyPremiumWasDisplayedAfterSignUp"];
        }
        
        finishBlock(YES, homeDict);
        
    }
    
}

#pragma mark - Join Home

-(void)NewUserJoiningHome:(NSString *)homeID homeKey:(NSString *)homeKey topicDict:(NSMutableDictionary *)topicDict clickedUnclaimedUser:(BOOL)clickedUnclaimedUser enabledNotifications:(BOOL)enabledNotifications currentViewController:(UIViewController *)currentViewController completionHandler:(void (^)(BOOL finished))finishBlock {
    
    [[NSUserDefaults standardUserDefaults] setObject:@{@"HomeID" : homeID} forKey:@"HomeChosen"];
    
    NSArray *keyArray = [[[GeneralObject alloc] init] GenerateKeyArrayManually:NO Expense:NO List:NO Home:YES];
    
    [[[GetDataObject alloc] init] GetDataSpecificHomeDataWithoutListener:homeID keyArray:keyArray completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningHomeToJoinDict) {
        
        NSString *queriedHomeID = returningHomeToJoinDict[@"HomeID"] ? [returningHomeToJoinDict[@"HomeID"] mutableCopy] : @"";
        NSMutableArray *queriedHomeMemberArray = returningHomeToJoinDict[@"HomeMembers"] ? [returningHomeToJoinDict[@"HomeMembers"] mutableCopy] : [NSMutableArray array];
        
        __block NSMutableDictionary *homeMembersDict = [NSMutableDictionary dictionary];
        NSMutableArray *updatedHomeMembersArray = [[self UserJoiningHome_GenerateHomeMemberArrayWithCurrentlyLoggedInUser:[queriedHomeMemberArray mutableCopy]] mutableCopy];
        
        
        
        __block int totalQueries = 3;
        __block int completedQueries = 0;
        
        
        
        /*
         //
         //
         //Get HomeMemberDict, NotificationSettingsDict
         //
         //
         */
        [self UserJoiningHome_GetHomeMemberDataBeforeAddingJoiningUser:queriedHomeMemberArray completionHandler:^(BOOL finished, NSMutableDictionary *returningUserDict, NSMutableDictionary *returningNotificationSettingsDict) {
            
            homeMembersDict = [returningUserDict mutableCopy];
            NSMutableDictionary *notificationSettingsDict = [returningNotificationSettingsDict mutableCopy];
            
            
            /*
             //
             //
             //Send Push Notifications To Existing Home Members
             //
             //
             */
            [self NewUserJoiningHome_SendPushNotificationToExistingHomeMembers:returningHomeToJoinDict homeMembersDict:homeMembersDict queriedHomeMemberArray:queriedHomeMemberArray homeID:homeID notificationSettingsDict:notificationSettingsDict topicDict:topicDict completionHandler:^(BOOL finished) {
                
                [self UserJoiningHome_JoinHomeCompletionBlock:returningHomeToJoinDict homeMembersDict:homeMembersDict updatedHomeMembersArray:updatedHomeMembersArray WeDivvyPremiumFound:NO totalQueries:totalQueries completedQueries:(completedQueries+=1) currentViewController:currentViewController completionHandler:^(BOOL finished) {
                    
                    finishBlock(YES);
                    
                }];
                
            }];
            
            /*
             //
             //
             //Update Data For New Home Member
             //
             //
             */
            [self NewUserJoiningHome_UpdateDataForNewHomeMember:queriedHomeID homeMembersDict:homeMembersDict topicDict:topicDict notificationSettingsDict:notificationSettingsDict enabledNotifications:enabledNotifications completionHandler:^(BOOL finished) {
                
                [self UserJoiningHome_JoinHomeCompletionBlock:returningHomeToJoinDict homeMembersDict:homeMembersDict updatedHomeMembersArray:updatedHomeMembersArray WeDivvyPremiumFound:NO totalQueries:totalQueries completedQueries:(completedQueries+=1) currentViewController:currentViewController completionHandler:^(BOOL finished) {
                    
                    finishBlock(YES);
                    
                }];
                
            }];
            
        }];
        
        
        /*
         //
         //
         //Update Home Data
         //
         //
         */
        [self NewUserJoiningHome_UpdateHomeData:returningHomeToJoinDict updatedHomeMembersArray:updatedHomeMembersArray homeID:homeID homeKey:homeKey completionHandler:^(BOOL finished) {
            
            [self UserJoiningHome_JoinHomeCompletionBlock:returningHomeToJoinDict homeMembersDict:homeMembersDict updatedHomeMembersArray:updatedHomeMembersArray WeDivvyPremiumFound:NO totalQueries:totalQueries completedQueries:(completedQueries+=1) currentViewController:currentViewController completionHandler:^(BOOL finished) {
                
                finishBlock(YES);
                
            }];
            
        }];
        
    }];
    
}

-(void)UnclaimedUserJoiningHome:(NSString *)homeID homeKey:(NSString *)homeKey topicDict:(NSMutableDictionary *)topicDict clickedUnclaimedUser:(BOOL)clickedUnclaimedUser enabledNotifications:(BOOL)enabledNotifications currentViewController:(UIViewController *)currentViewController completionHandler:(void (^)(BOOL finished))finishBlock {
    
    [[NSUserDefaults standardUserDefaults] setObject:@{@"HomeID" : homeID} forKey:@"HomeChosen"];
    
    NSArray *keyArray = [[[GeneralObject alloc] init] GenerateKeyArrayManually:NO Expense:NO List:NO Home:YES];
    
    [[[GetDataObject alloc] init] GetDataSpecificHomeDataWithoutListener:homeID keyArray:keyArray completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningHomeToJoinDict) {
        
        NSString *queriedHomeID = returningHomeToJoinDict[@"HomeID"] ? [returningHomeToJoinDict[@"HomeID"] mutableCopy] : @"";
        NSMutableArray *queriedHomeMemberArray = returningHomeToJoinDict[@"HomeMembers"] ? [returningHomeToJoinDict[@"HomeMembers"] mutableCopy] : [NSMutableArray array];
        
        __block BOOL WeDivvyPremiumFound = NO;
        
        NSString *currentUsersUserID = [[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] mutableCopy];
        NSString *unclaimedUsersUserID = [self UnclaimedUserJoiningHome_GenerateUnclaimedUsersUserID:homeKey returningHomeToJoinDict:returningHomeToJoinDict];
        
        __block NSMutableDictionary *homeMembersDict = [NSMutableDictionary dictionary];
        NSMutableArray *updatedHomeMembersArray = [[self UserJoiningHome_GenerateHomeMemberArrayWithCurrentlyLoggedInUser:[queriedHomeMemberArray mutableCopy]] mutableCopy];
        
        BOOL UnclaimedUserFound = [unclaimedUsersUserID length] > 0;
        
        
        
        __block int totalQueries = UnclaimedUserFound == YES ? 6 : 4;
        __block int completedQueries = 0;
        
        
        
        /*
         //
         //
         //Get HomeMemberDict, NotificationSettingsDict
         //
         //
         */
        [self UserJoiningHome_GetHomeMemberDataBeforeAddingJoiningUser:queriedHomeMemberArray completionHandler:^(BOOL finished, NSMutableDictionary *returningUserDict, NSMutableDictionary *returningNotificationSettingsDict) {
            
            homeMembersDict = [returningUserDict mutableCopy];
            NSMutableDictionary *notificationSettingsDict = [returningNotificationSettingsDict mutableCopy];
            
            
            /*
             //
             //
             //Send Push Notifications To Existing Home Members
             //
             //
             */
            [self UnclaimedUserJoiningHome_SendPushNotificationToExistingHomeMembers:returningHomeToJoinDict homeMembersDict:homeMembersDict queriedHomeMemberArray:queriedHomeMemberArray homeID:homeID notificationSettingsDict:notificationSettingsDict topicDict:topicDict completionHandler:^(BOOL finished) {
                
                [self UserJoiningHome_JoinHomeCompletionBlock:returningHomeToJoinDict homeMembersDict:homeMembersDict updatedHomeMembersArray:updatedHomeMembersArray WeDivvyPremiumFound:WeDivvyPremiumFound totalQueries:totalQueries completedQueries:(completedQueries+=1) currentViewController:currentViewController completionHandler:^(BOOL finished) {
                    
                    finishBlock(YES);
                    
                }];
                
            }];
            
            
            /*
             //
             //
             //(Not Query If Notifications Not Enabled) Update Data For New Home Member
             //
             //
             */
            [self UnclaimedUserJoiningHome_UpdateDataForNewHomeMember:queriedHomeID homeMembersDict:homeMembersDict topicDict:topicDict notificationSettingsDict:notificationSettingsDict enabledNotifications:enabledNotifications completionHandler:^(BOOL finished) {
                
                [self UserJoiningHome_JoinHomeCompletionBlock:returningHomeToJoinDict homeMembersDict:homeMembersDict updatedHomeMembersArray:updatedHomeMembersArray WeDivvyPremiumFound:WeDivvyPremiumFound totalQueries:totalQueries completedQueries:(completedQueries+=1) currentViewController:currentViewController completionHandler:^(BOOL finished) {
                    
                    finishBlock(YES);
                    
                }];
                
            }];
            
            
            /*
             //
             //
             //(Not Query) If Unclaimed User Found, Check If Unclaimed User Was Given Premium
             //
             //
             */
            [self UnclaimedUserJoiningHome_CheckIfUnclaimedUserHasPremium:homeMembersDict unclaimedUsersUserID:unclaimedUsersUserID completionHandler:^(BOOL finished, BOOL returningWeDivvyPremiumFound) {
                
                WeDivvyPremiumFound = returningWeDivvyPremiumFound;
                
                [self UserJoiningHome_JoinHomeCompletionBlock:returningHomeToJoinDict homeMembersDict:homeMembersDict updatedHomeMembersArray:updatedHomeMembersArray WeDivvyPremiumFound:WeDivvyPremiumFound totalQueries:totalQueries completedQueries:(completedQueries+=1) currentViewController:currentViewController completionHandler:^(BOOL finished) {
                    
                    finishBlock(YES);
                    
                }];
                
            }];
            
        }];
        
        
        /*
         //
         //
         //Update Home Data
         //
         //
         */
        [self UnclaimedUserJoiningHome_UpdateHomeData:returningHomeToJoinDict homeID:homeID homeKey:homeKey completionHandler:^(BOOL finished) {
            
            [self UserJoiningHome_JoinHomeCompletionBlock:returningHomeToJoinDict homeMembersDict:homeMembersDict updatedHomeMembersArray:updatedHomeMembersArray WeDivvyPremiumFound:WeDivvyPremiumFound totalQueries:totalQueries completedQueries:(completedQueries+=1) currentViewController:currentViewController completionHandler:^(BOOL finished) {
                
                finishBlock(YES);
                
            }];
            
        }];
        
        
        
        
        
        
        
        if (UnclaimedUserFound == YES) {
            
            [[NSUserDefaults standardUserDefaults] setObject:unclaimedUsersUserID forKey:@"UsersUserID"];
            
            /*
             //
             //
             //If Unclaimed User Found, Update User Data
             //
             //
             */
            [self UncalimedUserJoiningHome_UpdateUserData:unclaimedUsersUserID completionHandler:^(BOOL finished) {
                
                [self UserJoiningHome_JoinHomeCompletionBlock:returningHomeToJoinDict homeMembersDict:homeMembersDict updatedHomeMembersArray:updatedHomeMembersArray WeDivvyPremiumFound:WeDivvyPremiumFound totalQueries:totalQueries completedQueries:(completedQueries+=1) currentViewController:currentViewController completionHandler:^(BOOL finished) {
                    
                    finishBlock(YES);
                    
                }];
                
            }];
            
            
            /*
             //
             //
             //If Unclaimed User Found, Delete Signed Up User Data
             //
             //
             */
            [self UnclaimedUserJoiningHome_DeleteSignedUpUserData:currentUsersUserID completionHandler:^(BOOL finished) {
                
                [self UserJoiningHome_JoinHomeCompletionBlock:returningHomeToJoinDict homeMembersDict:homeMembersDict updatedHomeMembersArray:updatedHomeMembersArray WeDivvyPremiumFound:WeDivvyPremiumFound totalQueries:totalQueries completedQueries:(completedQueries+=1) currentViewController:currentViewController completionHandler:^(BOOL finished) {
                    
                    finishBlock(YES);
                    
                }];
                
            }];
            
        }
        
    }];
    
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Sub-Internal Methods
#pragma mark
#pragma mark
#pragma mark -

#pragma mark Create Home

-(NSMutableDictionary *)GenerateNewHomeMembersDict {
    
    NSMutableDictionary *dict = [@{
        @"UserID" : @[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]],
        @"Username" : @[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"]],
        @"Email" : @[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersEmail"]],
        @"Notifications" : @[@"No"],
        @"HeardAboutUs" : @[@"xxx"],
        @"ProfileImageURL" : @[@"xxx"],
        @"ReceiveUpdateEmails" : @[@"Yes"],
        @"WeDivvyPremium" : @[[[[GeneralObject alloc] init] GenerateDefaultWeDivvyPremiumPlan]]
    } mutableCopy];
    
    return dict;
}

#pragma mark - Join Home; NewUserJoiningHome

-(void)NewUserJoiningHome_SendPushNotificationToExistingHomeMembers:(NSMutableDictionary *)returningHomeToJoinDict homeMembersDict:(NSMutableDictionary *)homeMembersDict queriedHomeMemberArray:(NSMutableArray *)queriedHomeMemberArray homeID:(NSString *)homeID notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict topicDict:(NSMutableDictionary *)topicDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *notificationType = [[[NotificationsObject alloc] init] NotificationSettingsUnknownItemType_Adding:NO Editing:NO Deleting:NO Duplicating:NO Waiving:NO Skipping:NO Pausing:NO Comments:NO
                                                                                                       SkippingTurn:NO RemovingUser:NO
                                                                                                     FullyCompleted:NO Completed:NO InProgress:NO WontDo:NO Accept:NO Decline:NO
                                                                                                            DueDate:NO Reminder:NO
                                                                                                     SubtaskEditing:NO SubtaskDeleting:NO
                                                                                                   SubtaskCompleted:NO SubtaskInProgress:NO SubtaskWontDo:NO SubtaskAccept:NO SubtaskDecline:NO
                                                                                                     AddingListItem:NO EditingListItem:NO DeletingListItem:NO ResetingListItem:NO
                                                                                                EditingItemizedItem:NO DeletingItemizedItem:NO
                                                                                                  GroupChatMessages:NO LiveSupportMessages:NO
                                                                                                 SendingInvitations:NO DeletingInvitations:NO NewHomeMembers:YES HomeMembersMovedOut:NO HomeMembersKickedOut:NO
                                                                                                FeatureForumUpvotes:NO BugForumUpvotes:NO
                                                                                                           itemType:@"HomeMembers"];
        
        
        
        NSString *notificationTitle = [NSString stringWithFormat:@"New Home Member 🏠"];
        NSString *notificationBody = [NSString stringWithFormat:@"%@ joined your home!", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"]];
        
        
        
        NSString *homeName = returningHomeToJoinDict[@"HomeName"] ? returningHomeToJoinDict[@"HomeName"] : @"";
        
        
        
        [[[NotificationsObject alloc] init] SendPushNotificationToArrayOfUsers_Homes:queriedHomeMemberArray
                                           viewingHomeMembersFromHomesViewController:NO homeID:homeID homeName:homeName homeMembersDict:homeMembersDict
                                                            notificationSettingsDict:notificationSettingsDict notificationItemType:@"HomeMembers" notificationType:notificationType
                                                                           topicDict:topicDict
                                                               pushNotificationTitle:notificationTitle pushNotificationBody:notificationBody
                                                                   notificationTitle:notificationTitle notificationBody:notificationBody
                                                             SetDataHomeNotification:YES
                                                                        RemoveUsersNotInHome:YES
                                                                  completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)NewUserJoiningHome_UpdateDataForNewHomeMember:(NSString *)queriedHomeID homeMembersDict:(NSMutableDictionary *)homeMembersDict topicDict:(NSMutableDictionary *)topicDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict enabledNotifications:(BOOL)enabledNotifications completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
        
        BOOL UserCanReceiveNotifications = enabledNotifications == YES;
        
        [self UserJoiningHome_UpdateDataForNewHomeMemberLocal:queriedHomeID userToAdd:userID homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict topicDict:topicDict clickedUnclaimedUser:NO QueryAssignedToNewHomeMember:NO QueryAssignedTo:UserCanReceiveNotifications queryAssignedToUserID:userID ResetNotifications:UserCanReceiveNotifications completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)NewUserJoiningHome_UpdateHomeData:(NSMutableDictionary *)returningHomeToJoinDict updatedHomeMembersArray:(NSMutableArray *)updatedHomeMembersArray homeID:(NSString *)homeID homeKey:(NSString *)homeKey completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSDictionary *dataDict = [self NewUserJoiningHome_GenerateUpdatedHomeDataDict:returningHomeToJoinDict updatedHomeMembersArray:updatedHomeMembersArray homeKey:homeKey];
        
        [[[SetDataObject alloc] init] UpdateDataHome:homeID homeDict:dataDict completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

#pragma mark - Join Home; UnclaimedUserJoiningHome

-(NSString *)UnclaimedUserJoiningHome_GenerateUnclaimedUsersUserID:(NSString *)homeKey returningHomeToJoinDict:(NSMutableDictionary *)returningHomeToJoinDict {
    
    NSMutableDictionary *tempHomeMembersUnclaimedDict = returningHomeToJoinDict[@"HomeMembersUnclaimed"] ? [returningHomeToJoinDict[@"HomeMembersUnclaimed"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *tempHomeMembersUnclaimedDictCopy = [tempHomeMembersUnclaimedDict mutableCopy];
    
    NSString *unclaimedUsersUserID = @"";
    
    for (NSString *key in [tempHomeMembersUnclaimedDictCopy allKeys]) {
        
        NSString *invitationSent = tempHomeMembersUnclaimedDictCopy[key][@"InvitationSent"];
        
        if ([invitationSent containsString:[NSString stringWithFormat:@"%@•••", homeKey]]) {
            
            unclaimedUsersUserID = tempHomeMembersUnclaimedDictCopy[key][@"UserID"];
            
            break;
        }
        
    }
    
    return unclaimedUsersUserID;
}

#pragma mark

-(void)UnclaimedUserJoiningHome_SendPushNotificationToExistingHomeMembers:(NSMutableDictionary *)returningHomeToJoinDict homeMembersDict:(NSMutableDictionary *)homeMembersDict queriedHomeMemberArray:(NSMutableArray *)queriedHomeMemberArray homeID:(NSString *)homeID notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict topicDict:(NSMutableDictionary *)topicDict completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *notificationType = [[[NotificationsObject alloc] init] NotificationSettingsUnknownItemType_Adding:NO Editing:NO Deleting:NO Duplicating:NO Waiving:NO Skipping:NO Pausing:NO Comments:NO
                                                                                                       SkippingTurn:NO RemovingUser:NO
                                                                                                     FullyCompleted:NO Completed:NO InProgress:NO WontDo:NO Accept:NO Decline:NO
                                                                                                            DueDate:NO Reminder:NO
                                                                                                     SubtaskEditing:NO SubtaskDeleting:NO
                                                                                                   SubtaskCompleted:NO SubtaskInProgress:NO SubtaskWontDo:NO SubtaskAccept:NO SubtaskDecline:NO
                                                                                                     AddingListItem:NO EditingListItem:NO DeletingListItem:NO ResetingListItem:NO
                                                                                                EditingItemizedItem:NO DeletingItemizedItem:NO
                                                                                                  GroupChatMessages:NO LiveSupportMessages:NO
                                                                                                 SendingInvitations:NO DeletingInvitations:NO NewHomeMembers:YES HomeMembersMovedOut:NO HomeMembersKickedOut:NO
                                                                                                FeatureForumUpvotes:NO BugForumUpvotes:NO
                                                                                                           itemType:@"HomeMembers"];
        
        
        
        NSString *notificationTitle = [NSString stringWithFormat:@"New Home Member 🏠"];
        NSString *notificationBody = [NSString stringWithFormat:@"%@ joined your home!", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"]];
        
        
        
        NSString *homeName = returningHomeToJoinDict[@"HomeName"] ? returningHomeToJoinDict[@"HomeName"] : @"";
        
        
        
        [[[NotificationsObject alloc] init] SendPushNotificationToArrayOfUsers_Homes:queriedHomeMemberArray
                                           viewingHomeMembersFromHomesViewController:NO homeID:homeID homeName:homeName homeMembersDict:homeMembersDict
                                                            notificationSettingsDict:notificationSettingsDict notificationItemType:@"HomeMembers" notificationType:notificationType
                                                                           topicDict:topicDict
                                                               pushNotificationTitle:notificationTitle pushNotificationBody:notificationBody
                                                                   notificationTitle:notificationTitle notificationBody:notificationBody
                                                             SetDataHomeNotification:YES
                                                                        RemoveUsersNotInHome:YES
                                                                 completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)UnclaimedUserJoiningHome_UpdateDataForNewHomeMember:(NSString *)queriedHomeID homeMembersDict:(NSMutableDictionary *)homeMembersDict topicDict:(NSMutableDictionary *)topicDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict enabledNotifications:(BOOL)enabledNotifications completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
        
        BOOL UserCanReceiveNotifications = enabledNotifications == YES;
       
        [self UserJoiningHome_UpdateDataForNewHomeMemberLocal:queriedHomeID userToAdd:userID homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict topicDict:topicDict clickedUnclaimedUser:YES QueryAssignedToNewHomeMember:NO QueryAssignedTo:UserCanReceiveNotifications queryAssignedToUserID:userID ResetNotifications:UserCanReceiveNotifications completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)UnclaimedUserJoiningHome_UpdateHomeData:(NSMutableDictionary *)returningHomeToJoinDict homeID:(NSString *)homeID homeKey:(NSString *)homeKey completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSDictionary *dataDict = [self UnclaimedUserJoiningHome_GenerateUpdatedHomeDataDict:returningHomeToJoinDict homeKey:homeKey];
        
        [[[SetDataObject alloc] init] UpdateDataHome:homeID homeDict:dataDict completionHandler:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)UncalimedUserJoiningHome_UpdateUserData:(NSString *)unclaimedUsersUserID completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *currentUsername = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUsername"];
        NSString *currentUserEmail = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersEmail"];
        NSString *currentUserMixPanelID = [[NSUserDefaults standardUserDefaults] objectForKey:@"MixPanelID"];
        
        NSDictionary *userDict = @{
            @"Username" : currentUsername,
            @"Email" : currentUserEmail,
            @"MixPanelID" : currentUserMixPanelID
        };
        
        [[[SetDataObject alloc] init] UpdateDataUserData:unclaimedUsersUserID userDict:userDict completionHandler:^(BOOL finished, NSError * _Nonnull error) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)UnclaimedUserJoiningHome_DeleteSignedUpUserData:(NSString *)currentUsersUserID completionHandler:(void (^)(BOOL finished))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[DeleteDataObject alloc] init] DeleteDataUser:currentUsersUserID completionHandler:^(BOOL finished, NSError * _Nonnull error) {
            
            finishBlock(YES);
            
        }];
        
    });
    
}

-(void)UnclaimedUserJoiningHome_CheckIfUnclaimedUserHasPremium:(NSMutableDictionary *)homeMembersDict unclaimedUsersUserID:(NSString *)unclaimedUsersUserID completionHandler:(void (^)(BOOL finished, BOOL WeDivvyPremiumFound))finishBlock {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        __block BOOL WeDivvyPremiumFound = NO;
        
        if (homeMembersDict) {
            
            BOOL ObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:homeMembersDict classArr:@[[NSDictionary class], [NSMutableDictionary class]]];
            
            if (ObjectIsKindOfClass == YES) {
                
                NSMutableDictionary *returningUserDict = [NSMutableDictionary dictionary];
                
                NSUInteger index =
                homeMembersDict[@"UserID"] &&
                [homeMembersDict[@"UserID"] containsObject:unclaimedUsersUserID] ?
                [homeMembersDict[@"UserID"] indexOfObject:unclaimedUsersUserID] : 1000;
                
                NSArray *keyArray = [[[GeneralObject alloc] init] GenerateUserKeyArray];
                
                for (NSString *key in keyArray) {
                    
                    id object = homeMembersDict[key] && [(NSArray *)homeMembersDict[key] count] > index ? homeMembersDict[key][index] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
                    [returningUserDict setObject:object forKey:key];
                    
                }
                
                if (returningUserDict[@"WeDivvyPremium"]) {
                    
                    BOOL ObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:returningUserDict[@"WeDivvyPremium"] classArr:@[[NSDictionary class], [NSMutableDictionary class]]];
                    
                    if (ObjectIsKindOfClass == YES) {
                        
                        if (returningUserDict[@"WeDivvyPremium"][@"SubscriptionGivenBy"]) {
                            
                            BOOL ObjectIsKindOfClass = [[[BoolDataObject alloc] init] CheckIfObjectIsKindOfClass:returningUserDict[@"WeDivvyPremium"][@"SubscriptionGivenBy"] classArr:@[[NSString class]]];
                            
                            if (ObjectIsKindOfClass == YES) {
                                
                                if ([returningUserDict[@"WeDivvyPremium"][@"SubscriptionGivenBy"] length] > 0) {
                                    
                                    WeDivvyPremiumFound = YES;
                                    
                                }
                            }
                        }
                    }
                }
            }
        }
        
        finishBlock(YES, WeDivvyPremiumFound);
        
    });
    
}

#pragma mark - Join Home; NewUserJoiningHome, UnclaimedUserJoiningHome

-(NSMutableArray *)UserJoiningHome_GenerateHomeMemberArrayWithCurrentlyLoggedInUser:(NSMutableArray *)homeMemberArray {
    
    NSMutableArray *arrayWithoutDuplicates = [[[GeneralObject alloc] init] RemoveDupliatesFromArray:homeMemberArray];
    
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
    
    if ([arrayWithoutDuplicates containsObject:userID] == NO) {
        [arrayWithoutDuplicates addObject:userID];
    }
    
    return arrayWithoutDuplicates;
    
}

-(void)UserJoiningHome_GetHomeMemberDataBeforeAddingJoiningUser:(NSMutableArray *)homeMembersArray completionHandler:(void (^)(BOOL finished, NSMutableDictionary *returningUserDict, NSMutableDictionary *returningNotificationSettingsDict))finishBlock {
   
    __block NSMutableDictionary *returningUserDictLocal = [NSMutableDictionary dictionary];
    __block NSMutableDictionary *returningNotificationSettingsDictLocal = [NSMutableDictionary dictionary];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[GetDataObject alloc] init] GetDataUserDataArray:homeMembersArray completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningUserDict) {
            
            returningUserDictLocal = [returningUserDict mutableCopy];
            
            finishBlock(YES, returningUserDictLocal, returningNotificationSettingsDictLocal);
        
        }];
        
    });
    
}

-(void)UserJoiningHome_JoinHomeCompletionBlock:(NSMutableDictionary *)homeToJoinDict homeMembersDict:(NSMutableDictionary *)homeMembersDict updatedHomeMembersArray:(NSMutableArray *)updatedHomeMembersArray WeDivvyPremiumFound:(BOOL)WeDivvyPremiumFound totalQueries:(int)totalQueries completedQueries:(int)completedQueries currentViewController:(UIViewController *)currentViewController completionHandler:(void (^)(BOOL finished))finishBlock {
    
    if (totalQueries >= completedQueries) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSMutableDictionary *homeChosenDict = [self UserJoiningHome_GenerateHomeChosenDict:updatedHomeMembersArray homeToJoinDict:homeToJoinDict];
            
            //Set Data For Later Use
            NSMutableArray *homeFeatures = homeChosenDict[@"HomeFeatures"] ? [homeChosenDict[@"HomeFeatures"] mutableCopy] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:@"HomeFeatures"];
            [[NSUserDefaults standardUserDefaults] setObject:homeFeatures forKey:@"VisibleTabBarOptions"];
            
            //Set Data For Later Use
            [[NSUserDefaults standardUserDefaults] setObject:homeChosenDict forKey:@"HomeChosen"];
            [[NSUserDefaults standardUserDefaults] setObject:updatedHomeMembersArray forKey:@"HomeMembersArray"];
            [[NSUserDefaults standardUserDefaults] setObject:homeMembersDict forKey:@"HomeMembersDict"];
            
            //Update HomesViewController
            [[[GeneralObject alloc] init] CallNSNotificationMethods:@"AddHome" userInfo:homeChosenDict locations:@[@"Homes"]];
            
            //Check If Popup Needed
            if (WeDivvyPremiumFound == NO) {
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"WeDivvyPremiumWasDisplayedAfterSignUp"];
            }
            
            [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"ViewDidLoadShouldStart"];
            
            //Push To Next Page
            [[[PushObject alloc] init] PushToTasksNavigationController:YES Expenses:NO Lists:NO Animated:YES currentViewController:currentViewController];
            
            finishBlock(YES);
            
        });
        
    }
    
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Sub-Sub-Internal Methods
#pragma mark
#pragma mark
#pragma mark -

#pragma mark Join Home; NewUserJoiningHome

-(NSDictionary *)NewUserJoiningHome_GenerateUpdatedHomeDataDict:(NSMutableDictionary *)returningHomeToJoinDict updatedHomeMembersArray:(NSMutableArray *)updatedHomeMembersArray homeKey:(NSString *)homeKey {
    
    NSMutableDictionary *tempHomeKeysDict = returningHomeToJoinDict[@"HomeKeys"] ? [returningHomeToJoinDict[@"HomeKeys"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableArray *tempHomeKeysArray = returningHomeToJoinDict[@"HomeKeysArray"] ? [returningHomeToJoinDict[@"HomeKeysArray"] mutableCopy] : [NSMutableArray array];
    
    NSDictionary *updatedHomeKeys = [self UserJoiningHome_GenerateUpdatedHomeKeys:[tempHomeKeysDict mutableCopy] homeKeysArray:[tempHomeKeysArray mutableCopy] homeKey:homeKey clickedUnclaimedUser:NO];
    
    NSMutableDictionary *updatedHomeKeyDict = updatedHomeKeys[@"HomeKeys"] ? [updatedHomeKeys[@"HomeKeys"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableArray *updatedHomeKeyArray = updatedHomeKeys[@"HomeKeysArray"] ? [updatedHomeKeys[@"HomeKeysArray"] mutableCopy] : [NSMutableArray array];
    
    [returningHomeToJoinDict setObject:updatedHomeKeyDict forKey:@"HomeKeys"];
    [returningHomeToJoinDict setObject:updatedHomeKeyArray forKey:@"HomeKeysArray"];
    
    NSDictionary *dataDict = @{@"HomeKeys" : updatedHomeKeyDict, @"HomeKeysArray" : updatedHomeKeyArray, @"HomeMembers" : updatedHomeMembersArray};
    
    return dataDict;
}

#pragma mark - Join Home; UnclaimedUserJoiningHome

-(NSMutableDictionary *)UnclaimedUserJoiningHome_GenerateUpdatedHomeDataDict:(NSMutableDictionary *)returningHomeToJoinDict homeKey:(NSString *)homeKey {
    
    NSMutableDictionary *tempHomeMembersUnclaimedDict = returningHomeToJoinDict[@"HomeMembersUnclaimed"] ? [returningHomeToJoinDict[@"HomeMembersUnclaimed"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *tempHomeMembersUnclaimedDictCopy = [tempHomeMembersUnclaimedDict mutableCopy];
    
    for (NSString *key in [tempHomeMembersUnclaimedDictCopy allKeys]) {
        
        NSString *invitationSent = tempHomeMembersUnclaimedDictCopy[key][@"InvitationSent"];
        
        if ([invitationSent containsString:[NSString stringWithFormat:@"%@•••", homeKey]]) {
            
            [tempHomeMembersUnclaimedDict removeObjectForKey:key];
            
            break;
        }
        
    }
    
    NSMutableDictionary *tempHomeKeysDict = returningHomeToJoinDict[@"HomeKeys"] ? [returningHomeToJoinDict[@"HomeKeys"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableArray *tempHomeKeysArray = returningHomeToJoinDict[@"HomeKeysArray"] ? [returningHomeToJoinDict[@"HomeKeysArray"] mutableCopy] : [NSMutableArray array];
    
    NSDictionary *updatedHomeKeys = [self UserJoiningHome_GenerateUpdatedHomeKeys:[tempHomeKeysDict mutableCopy] homeKeysArray:[tempHomeKeysArray mutableCopy] homeKey:homeKey clickedUnclaimedUser:YES];
    
    NSMutableDictionary *updatedHomeKeyDict = updatedHomeKeys[@"HomeKeys"] ? [updatedHomeKeys[@"HomeKeys"] mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableArray *updatedHomeKeyArray = updatedHomeKeys[@"HomeKeysArray"] ? [updatedHomeKeys[@"HomeKeysArray"] mutableCopy] : [NSMutableArray array];
    
    [returningHomeToJoinDict setObject:tempHomeMembersUnclaimedDict forKey:@"HomeMembersUnclaimed"];
    [returningHomeToJoinDict setObject:updatedHomeKeyDict forKey:@"HomeKeys"];
    [returningHomeToJoinDict setObject:updatedHomeKeyArray forKey:@"HomeKeysArray"];
    
    return returningHomeToJoinDict;
}

#pragma mark - Join Home; NewUserJoiningHome, UnclaimedUserJoiningHome

-(void)UserJoiningHome_UpdateDataForNewHomeMemberLocal:(NSString *)homeID userToAdd:(NSString *)userID homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict topicDict:(NSMutableDictionary *)topicDict clickedUnclaimedUser:(BOOL)clickedUnclaimedUser QueryAssignedToNewHomeMember:(BOOL)QueryAssignedToNewHomeMember QueryAssignedTo:(BOOL)QueryAssignedTo queryAssignedToUserID:(NSString *)queryAssignedToUserID ResetNotifications:(BOOL)ResetNotifications completionHandler:(void (^)(BOOL finished))finishBlock {
    
    __block int totalQueries = 4;
    __block int completedQueries = 0;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[SetDataObject alloc] init] UpdateDataForNewHomeMember:homeID collection:@"Chores" userToAdd:userID homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict topicDict:topicDict allItemTagsArrays:nil QueryAssignedToNewHomeMember:QueryAssignedToNewHomeMember QueryAssignedTo:QueryAssignedTo queryAssignedToUserID:queryAssignedToUserID ResetNotifications:ResetNotifications completionHandler:^(BOOL finished) {
            
            if (totalQueries == (completedQueries += 1)) {
                
                finishBlock(YES);
                
            }
            
        }];
        
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[SetDataObject alloc] init] UpdateDataForNewHomeMember:homeID collection:@"Expenses" userToAdd:userID homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict topicDict:topicDict allItemTagsArrays:nil QueryAssignedToNewHomeMember:QueryAssignedToNewHomeMember QueryAssignedTo:QueryAssignedTo queryAssignedToUserID:queryAssignedToUserID ResetNotifications:ResetNotifications completionHandler:^(BOOL finished) {
           
            if (totalQueries == (completedQueries += 1)) {
                
                finishBlock(YES);
                
            }
            
        }];
        
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[SetDataObject alloc] init] UpdateDataForNewHomeMember:homeID collection:@"Lists" userToAdd:userID homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict topicDict:topicDict allItemTagsArrays:nil QueryAssignedToNewHomeMember:QueryAssignedToNewHomeMember QueryAssignedTo:QueryAssignedTo queryAssignedToUserID:queryAssignedToUserID ResetNotifications:ResetNotifications completionHandler:^(BOOL finished) {
           
            if (totalQueries == (completedQueries += 1)) {
                
                finishBlock(YES);
                
            }
            
        }];
        
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[[SetDataObject alloc] init] UpdateDataUpdateGroupChatsAssignedToNewHomeMembersInSpecificHome:homeID userToAdd:userID completionHandler:^(BOOL finished) {
           
            if (totalQueries == (completedQueries += 1)) {
                
                finishBlock(YES);
                
            }
            
        }];
        
    });
    
}

-(NSMutableDictionary *)UserJoiningHome_GenerateHomeChosenDict:(NSMutableArray *)updatedHomeMembersArray homeToJoinDict:(NSMutableDictionary *)homeToJoinDict {
    
    NSMutableDictionary *homeChosenDict = [NSMutableDictionary dictionary];
    
    for (NSString *key in [homeToJoinDict allKeys]) {
        
        id object = homeToJoinDict[key] ? homeToJoinDict[key] : [[[GeneralObject alloc] init] GenerateDefaultValueBasedOnKey:key];
        [homeChosenDict setObject:object forKey:key];
        
    }
    
    [homeChosenDict setObject:updatedHomeMembersArray forKey:@"HomeMembers"];
    
    return homeChosenDict;
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Sub-Sub-Sub-Internal Methods
#pragma mark
#pragma mark
#pragma mark -

#pragma mark Join Home; NewUserJoiningHome, UnclaimedUserJoiningHome

-(NSDictionary *)UserJoiningHome_GenerateUpdatedHomeKeys:(NSMutableDictionary *)homeKeysDict homeKeysArray:(NSMutableArray *)homeKeysArray homeKey:(NSString *)homeKey clickedUnclaimedUser:(BOOL)clickedUnclaimedUser {
    
    BOOL UnusedInvitationFound = [self UserJoiningHome_UnusedInvitationFound:homeKeysDict];
    
    NSString *unusedHomeKey = [self UserJoiningHome_FindUnusedHomeKey:homeKeysDict homeKey:homeKey UnusedInvitationFound:UnusedInvitationFound];
    
    if ([[homeKeysDict allKeys] containsObject:unusedHomeKey] && UnusedInvitationFound == true) {
        
        if (homeKeysDict[unusedHomeKey][@"DateSent"] &&
            homeKeysDict[unusedHomeKey][@"MemberName"] &&
            homeKeysDict[unusedHomeKey][@"SentBy"]) {
            
            
            
            if ([homeKeysArray containsObject:homeKey]) {
                
                int customCount = (int)homeKeysArray.count;
                
                [homeKeysArray removeObject:homeKey];
                
                if (clickedUnclaimedUser == NO) {
                    
                    for (int i=0 ; i<customCount-1 ; i++) {
                        
                        [homeKeysArray addObject:homeKey];
                        
                    }
                    
                }
                
            }
            
            
            NSString *currentDateString = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:@"MMMM dd, yyyy hh:mm a" returnAs:[NSString class]];
            
            NSString *dateSent = homeKeysDict[unusedHomeKey] && homeKeysDict[unusedHomeKey][@"DateSent"] ? homeKeysDict[unusedHomeKey][@"DateSent"] : @"";
            NSString *memberName = homeKeysDict[unusedHomeKey] && homeKeysDict[unusedHomeKey][@"MemberName"] ? homeKeysDict[unusedHomeKey][@"MemberName"] : @"";
            NSString *sentBy = homeKeysDict[unusedHomeKey] && homeKeysDict[unusedHomeKey][@"SentBy"] ? homeKeysDict[unusedHomeKey][@"SentBy"] : @"";
            NSString *viewController = homeKeysDict[unusedHomeKey] && homeKeysDict[unusedHomeKey][@"ViewController"] ? homeKeysDict[unusedHomeKey][@"ViewController"] : @"";
            
            [homeKeysDict setObject:@{@"DateSent" : dateSent, @"DateUsed" : currentDateString, @"MemberName" : memberName, @"SentBy" : sentBy, @"ViewController" : viewController} forKey:unusedHomeKey];
            
            
            
        }
        
    }
    
    return @{@"HomeKeys" : homeKeysDict, @"HomeKeysArray" : homeKeysArray};
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Sub-Sub-Sub-Sub-Internal Methods
#pragma mark
#pragma mark
#pragma mark -

#pragma mark Join Home; NewUserJoiningHome, UnclaimedUserJoiningHome

-(BOOL)UserJoiningHome_UnusedInvitationFound:(NSMutableDictionary *)homeKeysDict {
    
    BOOL UnusedInvitationFound = false;
    
    for (NSString *homeKey in [homeKeysDict allKeys]) {
        
        if (homeKeysDict[homeKey][@"DateUsed"] && [homeKeysDict[homeKey][@"DateUsed"] length] == 0) {
            
            UnusedInvitationFound = true;
            
        }
        
    }
    
    return UnusedInvitationFound;
}

-(NSString *)UserJoiningHome_FindUnusedHomeKey:(NSMutableDictionary *)homeKeysDict homeKey:(NSString *)homeKey UnusedInvitationFound:(BOOL)UnusedInvitationFound {
    
    if (UnusedInvitationFound == true) {
        
        if (!homeKeysDict[homeKey][@"DateUsed"] || (homeKeysDict[homeKey][@"DateUsed"] && [homeKeysDict[homeKey][@"DateUsed"] length] > 0)) {
            
            for (int i=0 ; i<1000 ; i++) {
                
                NSString *tempHomeKey = [NSString stringWithFormat:@"%@•••%d•••", homeKey, i];
                
                if ([[homeKeysDict allKeys] containsObject:tempHomeKey]) {
                    
                    if ([homeKeysDict[tempHomeKey][@"DateUsed"] length] == 0) {
                        
                        homeKey = tempHomeKey;
                        break;
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    return homeKey;
}

@end
