//
//  AppDelegate.m
//  RoommateApp
//
//  Created by Philip Nagel on 5/16/21.
//

#import "AppDelegate.h"
#import "SceneDelegate.h"

#import <Mixpanel/Mixpanel.h>

#import "HomeMembersViewController.h"
#import "ChatsViewController.h"
#import "LiveChatNavigationController.h"
#import "ViewTaskNavigationController.h"
#import "SettingsViewController.h"
#import "NotificationSettingsNavigationController.h"
#import "TasksViewController.h"
#import "ForumViewController.h"
#import "AddForumViewController.h"
#import "WeDivvyPremiumNavigationController.h"

#import "GeneralObject.h"
#import "SetDataObject.h"
#import "NotificationsObject.h"
#import "PushObject.h"
#import "CompleteUncompleteObject.h"
#import "BoolDataObject.h"
#import "DisplayTasksObject.h"

#import <BackgroundTasks/BackgroundTasks.h>

@interface AppDelegate () {
    BOOL silentNotification;
}

@end

@import UIKit;
@import Firebase;
@import FirebaseCore;

@implementation AppDelegate

#pragma mark - System Methods

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self SetUpThirdParties];
    
    //Post-Spike
    //[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"NotificationReminderHasBeenRemoved"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"NoSignUp"];
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@", [NSDate date]] forKey:@"DateAppOpenned"];
    
    [[FIRCrashlytics crashlytics] logWithFormat:@"GetDataGetItemsInSpecificHome DateAppOpenned:%@ CurrentTime:%@ Processing(0.0)", [[NSUserDefaults standardUserDefaults] objectForKey:@"DateAppOpenned"], [NSString stringWithFormat:@"%@", [NSDate date]]];
    
    __block BOOL isSimulator = [self SetUpIsSimulator];
    
    [self SetUpAppCrashed];
    
    [self SetUpThirdPartyAnalytics:isSimulator];
    
    [self SetUpAnalytics:isSimulator completionHandler:^(BOOL finished) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewViewController:@"didFinishLaunchingWithOptions" completionHandler:^(BOOL finished) {
            
        }];
        
    }];
    
    [self SetUpNSUserDefaults];
    
    [self SetUpNotifications];
    
    [[FIRCrashlytics crashlytics] logWithFormat:@"GetDataGetItemsInSpecificHome DateAppOpenned:%@ CurrentTime:%@ Processing(0.1)", [[NSUserDefaults standardUserDefaults] objectForKey:@"DateAppOpenned"], [NSString stringWithFormat:@"%@", [NSDate date]]];

    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    
    
    BOOL handleGoogleSignIn = [[GIDSignIn sharedInstance] handleURL:url];
    if (handleGoogleSignIn) {
        return handleGoogleSignIn;
    }
    
    return NO;
}

#pragma mark - Setup Methods

-(BOOL)SetUpIsSimulator {
    
    BOOL isSimulator;
    
#if TARGET_OS_SIMULATOR
    isSimulator = YES;
#else
    isSimulator = NO;
#endif
    
    return isSimulator;
    
}

-(BOOL)UserisValid:(BOOL)isSimulator {
    
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] isEqualToString:@"2021-08-24 23:51:563280984"] &&
        ![[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] isEqualToString:@"2021-07-09 19:11:493907435"] &&
        ![[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] isEqualToString:@"2021-06-05 15:07:572627942"] &&
        ![[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] isEqualToString:@"2021-08-24 23:47:407268729"] &&
        !isSimulator) {
        return YES;
    }
    
    return NO;
}

-(void)SetUpNSUserDefaults {
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"CurrentInLiveChat"]) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"CurrentInLiveChat"];
    }
    
}

-(void)SetUpNotifications {
    
    [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    
    //    UNNotificationAction *ActionBtn1 = [UNNotificationAction actionWithIdentifier:@"Btn1" title:@"BUTTON 1" options:UNNotificationActionOptionNone];
    //    UNNotificationAction *ActionBtn2 = [UNNotificationAction actionWithIdentifier:@"Btn2" title:@"BUTTON 2" options:UNNotificationActionOptionDestructive];
    //    UNNotificationCategory *category = [UNNotificationCategory categoryWithIdentifier:@"pusher" actions:@[ActionBtn1,ActionBtn2] intentIdentifiers:@[] options:UNNotificationCategoryOptionNone];
    //    NSSet *categories = [NSSet setWithObject:category];
    //    [[UNUserNotificationCenter currentNotificationCenter] setNotificationCategories:categories];
 
}

-(void)SetUpAppCrashed {
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"AppCrashed"] && [[[NSUserDefaults standardUserDefaults] objectForKey:@"AppCrashed"] isEqualToString:@"No"] == NO) {
        
        [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"AppCrashed"];
        
    } else {
        
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"AppCrashed"];
        
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"AppCrashedReported"] && [[[NSUserDefaults standardUserDefaults] objectForKey:@"AppCrashedReported"] isEqualToString:@"No"] == NO) {
        
        [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"AppCrashedReported"];
        
    } else {
        
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"AppCrashedReported"];
        
    }
    
}

-(void)SetUpThirdParties {
    
    [FIRApp configure];
    
}

-(void)SetUpThirdPartyAnalytics:(BOOL)isSimulator {
    
    BOOL UserIsValid = [self UserisValid:isSimulator];
    
    if (UserIsValid == YES) {
        
        //        [FIRAnalytics setAnalyticsCollectionEnabled:YES];
        
    } else {
        
        //        [FIRAnalytics setAnalyticsCollectionEnabled:NO];
        
    }
    
}

-(void)SetUpAnalytics:(BOOL)isSimulator completionHandler:(void (^)(BOOL finished))finishBlock {
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"MixPanelID"] && !isSimulator) {
        
        NSString *mixPanelID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
        [[NSUserDefaults standardUserDefaults] setObject:mixPanelID forKey:@"MixPanelID"];
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalytics:^(BOOL finished) {
            
            finishBlock(YES);
            
        }];
        
    } else {
        
        finishBlock(YES);
        
    }
    
}

#pragma mark - Lifecycle Methods

-(void)applicationDidBecomeActive:(UIApplication *)application {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ViewControllerDict"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TouchEventDict"];
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewViewController:@"applicationDidBecomeActive" completionHandler:^(BOOL finished) {
        
    }];
}

-(void)applicationWillEnterForeground:(UIApplication *)application {
    
    BOOL isSimulator = [self SetUpIsSimulator];
    BOOL UserIsValid = [self UserisValid:isSimulator];
    BOOL InitialNotificationHasBeenSent = [[[NSUserDefaults standardUserDefaults] objectForKey:@"InitialNotificationSent"] isEqualToString:@"Yes"];
    
    if (UserIsValid == YES) {
        
        if (InitialNotificationHasBeenSent == NO) {
            
            [[[NotificationsObject alloc] init] SendPushNotificationToCreator:[NSString stringWithFormat:@"%@ - Existing User", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] notificationBody:[NSString stringWithFormat:@"%@ -  6.5.98", @"applicationWillEnterForeground"] badgeNumber:(NSInteger *)1 completionHandler:^(BOOL finished) {
                
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ViewControllerDict"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TouchEventDict"];
                [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewViewController:@"applicationWillEnterForeground" completionHandler:^(BOOL finished) {
                    
                }];
                
            }];
            
        } else {
            
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"InitialNotificationSent"];
            
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ViewControllerDict"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TouchEventDict"];
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewViewController:@"applicationWillEnterForeground" completionHandler:^(BOOL finished) {
                
            }];
            
        }
        
    }
    
}

-(void)applicationDidEnterBackground:(UIApplication *)application {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ViewControllerDict"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TouchEventDict"];
    //[[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewViewController:@"applicationDidEnterBackground" completionHandler:^(BOOL finished) {
    
    //}];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"AppCrashed"];
    [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"AppCrashedReported"];
    
}

-(void)applicationWillResignActive:(UIApplication *)application {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ViewControllerDict"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TouchEventDict"];
    //[[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewViewController:@"applicationWillResignActive" completionHandler:^(BOOL finished) {
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"MixPanelCurrentDate"]) {
        
        [[NSUserDefaults standardUserDefaults] setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"MixPanelCurrentDate"] forKey:@"TempMixPanelCurrentDate"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"MixPanelCurrentDate"];
        
    }
    
    //}];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
    Mixpanel *mixpanel = [Mixpanel sharedInstance];
    [mixpanel identify:[[NSUserDefaults standardUserDefaults] objectForKey:@"MixPanelID"]];
    [mixpanel track:@"AppClosed" properties:@{@"AppClosed" : @"AppClosed1"}];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"AppCrashed"];
    [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"AppCrashedReported"];
    
}

- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options  API_AVAILABLE(ios(13.0)) API_AVAILABLE(ios(13.0)){
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    if (@available(iOS 13.0, *)) {
        return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
    } else {
        // Fallback on earlier versions
    }
    
    return nil;
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions  API_AVAILABLE(ios(13.0)){
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}

#pragma mark - Notification Methods

- (void)messaging:(FIRMessaging *)messaging didReceiveRegistrationToken:(NSString *)fcmToken {
    
    NSDictionary *dataDict = [NSDictionary dictionaryWithObject:fcmToken forKey:@"token"];
    [[NSNotificationCenter defaultCenter] postNotificationName:
     @"FCMToken" object:nil userInfo:dataDict];
    
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"Yay! Got a device token 🥳 %@", deviceToken);
    [[FIRMessaging messaging] setAPNSToken:deviceToken type:FIRMessagingAPNSTokenTypeUnknown];
    [[FIRMessaging messaging] APNSToken];
    
    NSMutableArray *subscribeTopicIDArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"didRegisterForRemoteNotificationsWithDeviceToken_Subscribe"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"didRegisterForRemoteNotificationsWithDeviceToken_Subscribe"] mutableCopy] : [NSMutableArray array];
    NSMutableArray *unsubscribeTopicIDArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"didRegisterForRemoteNotificationsWithDeviceToken_Unsubscribe"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"didRegisterForRemoteNotificationsWithDeviceToken_Unsubscribe"] mutableCopy] : [NSMutableArray array];
    
    for (NSString *subscribeTopicID in subscribeTopicIDArray) {
        
        if ([subscribeTopicID isEqualToString:@"AllHomeTopics"]) {
            
            NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
            NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
            NSMutableDictionary *homeMembersDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeMembersDict"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeMembersDict"] : [NSMutableDictionary dictionary];
          
            [[[GeneralObject alloc] init] SubscribeToAllHomeTopics:userID homeID:homeID homeMembersDict:homeMembersDict completionHandler:^(BOOL finished) {
                
                [[[GeneralObject alloc] init] RemoveCompletedTopicFromGenerateTokenArray:subscribeTopicID Subscribe:YES];
                
            }];
            
        } else if ([subscribeTopicID length] > 0) {
          
            [[[GeneralObject alloc] init] SubscribeToUserIDTopic:subscribeTopicID completionHandler:^(BOOL finished) {
                
                [[[GeneralObject alloc] init] RemoveCompletedTopicFromGenerateTokenArray:subscribeTopicID Subscribe:YES];
                
            }];
            
        }
        
    }
    
    for (NSString *unsubscribeTopicID in unsubscribeTopicIDArray) {
        
        if ([unsubscribeTopicID isEqualToString:@"AllHomeTopics"]) {
            
            NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
            NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
            NSMutableDictionary *homeMembersDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeMembersDict"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeMembersDict"] : [NSMutableDictionary dictionary];
            
            [[[GeneralObject alloc] init] UnsubscribeToAllHomeTopics:userID homeID:homeID homeMembersDict:homeMembersDict completionHandler:^(BOOL finished) {
                
                [[[GeneralObject alloc] init] RemoveCompletedTopicFromGenerateTokenArray:unsubscribeTopicID Subscribe:NO];
                
            }];
            
        } else if ([unsubscribeTopicID length] > 0) {
            
            [[[GeneralObject alloc] init] SubscribeToUserIDTopic:unsubscribeTopicID completionHandler:^(BOOL finished) {
                
                [[[GeneralObject alloc] init] RemoveCompletedTopicFromGenerateTokenArray:unsubscribeTopicID Subscribe:NO];
                
            }];
            
        }
        
    }
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    NSLog(@"didReceiveRemoteNotification %@", userInfo);
    
    if (userInfo[@"gcm.message_id"]) {
        
        NSLog(@"Message ID (Background): %@", userInfo[@"gcm.message_id"]);
        
    }
    
    if (userInfo[@"AddToBadgeCount"]) {
        
        if ([userInfo[@"AddToBadgeCount"] isEqualToString:@"Yes"]) {
            
            if(!userInfo[@"SentBy"] || (userInfo[@"SentBy"] && ![userInfo[@"SentBy"] isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]])) {
                
                NSInteger badgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber+1;
                [[UIApplication sharedApplication] setApplicationIconBadgeNumber:badgeNumber];
                
            }
            
        }
        
    }
    
    if (userInfo[@"SendLocalNotificationReminderNotifications"] ||
        userInfo[@"RemoveLocalNotificationReminderNotifications"]) {
        
        NSLog(@"Before merge %@", userInfo);
        
        NSDictionary *dict = [[self GenerateDataMergedUserInfo:[userInfo mutableCopy]] copy];
        
        BOOL UserInfoHasBeenSplitUp = dict[@"UserInfoHasBeenSplitUp"] && [dict[@"UserInfoHasBeenSplitUp"] isEqualToString:@"Yes"] ? YES : NO;
        BOOL UserInfoHasBeenFullyMerged = dict[@"UserInfoHasBeenFullyMerged"] && [dict[@"UserInfoHasBeenFullyMerged"] isEqualToString:@"Yes"] ? YES : NO;
        
        userInfo = dict[@"userInfo"] ? [dict[@"userInfo"] mutableCopy] : @{};
        
        silentNotification = YES;
        
        if (userInfo[@"SendLocalNotificationReminderNotifications"] &&
            (UserInfoHasBeenSplitUp == NO || (UserInfoHasBeenSplitUp == YES && UserInfoHasBeenFullyMerged == YES))) {         NSLog(@"After merge %@", userInfo);
            
            
            
            id itemType =                 userInfo[@"ItemType"] ?                  userInfo[@"ItemType"] : @"";
            id notificationType =         userInfo[@"NotificationType"] ?          userInfo[@"NotificationType"] : @"";
            
            
            
            id allItemTagsArrays =        userInfo[@"AllItemTagsArrays"] &&        [[[GeneralObject alloc] init] GenerateArrayID:userInfo[@"AllItemTagsArrays"]] ?             [[[GeneralObject alloc] init] GenerateArrayID:userInfo[@"AllItemTagsArrays"]]             : [NSMutableArray array];
            
            id dictToUse =                userInfo[@"DictToUse"] &&                [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"DictToUse"]] ?                [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"DictToUse"]]                : [NSMutableDictionary dictionary];
            
            if ([[dictToUse allKeys] containsObject:@"DictToUse"]) {
                
            }
            
            NSLog(@"After merge1 %@ -- %@", userInfo, dictToUse);
            
            id homeMembersDict =
            [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeMembersDict"] ?
            [[[NSUserDefaults standardUserDefaults] objectForKey:@"HomeMembersDict"] mutableCopy] : [NSMutableDictionary dictionary];
            
            
            
            id notificationSettingsDict = userInfo[@"NotificationSettingsDict"] && [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"NotificationSettingsDict"]] ? [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"NotificationSettingsDict"]] : [NSMutableDictionary dictionary];
            id topicDict =                userInfo[@"TopicDict"] && [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"TopicDict"]] ? [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"TopicDict"]] : [NSMutableDictionary dictionary];
//            id taskListDict =             userInfo[@"TaskListDict"] &&             [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"TaskListDict"]] ?             [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"TaskListDict"]]             : [NSMutableDictionary dictionary];
//            id sectionDict =              userInfo[@"SectionDict"] &&              [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"SectionDict"]] ?              [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"SectionDict"]]              : [NSMutableDictionary dictionary];
//            
//            
//            
//            NSArray *keyArray = [[[GeneralObject alloc] init] GenerateKeyArrayManually:[itemType containsString:@"Chore"] Expense:[itemType containsString:@"Expense"] List:[itemType containsString:@"List"] Home:NO];
            
            
            
//            if ([[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"]) {
//                
//                NSMutableDictionary *itemDict;
//                NSMutableDictionary *itemDictNo2;
//                NSMutableDictionary *itemDictNo3;
//                
//                NSMutableDictionary *dataDisplayDict;
//                NSMutableDictionary *dataDisplayDictNo2;
//                NSMutableDictionary *dataDisplayDictNo3;
//                
//                NSMutableDictionary *dataDisplayAmountDict;
//                NSMutableDictionary *dataDisplayAmountDictNo2;
//                NSMutableDictionary *dataDisplayAmountDictNo3;
//                
//                NSMutableArray *dataDisplaySectionsArray;
//                NSMutableArray *dataDisplaySectionsArrayNo2;
//                NSMutableArray *dataDisplaySectionsArrayNo3;
//                
//                if ([itemType isEqualToString:@"Chore"]) {
//                    
//                    itemDict = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TempItemDict"] mutableCopy];
//                    dataDisplaySectionsArray = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TempDisplaySectionsArray"] mutableCopy];
//                    dataDisplayDict = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TempDisplayDict"] mutableCopy];
//                    dataDisplayAmountDict = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TempDisplayAmountDict"] mutableCopy];
//                    
//                    itemDictNo2 = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TempItemDictNo1"] mutableCopy];
//                    dataDisplaySectionsArrayNo2 = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TempDisplaySectionsArrayNo1"] mutableCopy];
//                    dataDisplayDictNo2 = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TempDisplayDictNo1"] mutableCopy];
//                    dataDisplayAmountDictNo2 = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TempDisplayAmountDictNo1"] mutableCopy];
//                    
//                    itemDictNo3 = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TempItemDictNo2"] mutableCopy];
//                    dataDisplaySectionsArrayNo3 = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TempDisplaySectionsArrayNo2"] mutableCopy];
//                    dataDisplayDictNo3 = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TempDisplayDictNo2"] mutableCopy];
//                    dataDisplayAmountDictNo3 = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TempDisplayAmountDictNo2"] mutableCopy];
//                    
//                } else if ([itemType isEqualToString:@"Expense"]) {
//                    
//                    itemDict = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TempItemDictNo1"] mutableCopy];
//                    dataDisplaySectionsArray = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TempDisplaySectionsArrayNo1"] mutableCopy];
//                    dataDisplayDict = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TempDisplayDictNo1"] mutableCopy];
//                    dataDisplayAmountDict = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TempDisplayAmountDictNo1"] mutableCopy];
//                    
//                    itemDictNo2 = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TempItemDictNo2"] mutableCopy];
//                    dataDisplaySectionsArrayNo2 = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TempDisplaySectionsArrayNo2"] mutableCopy];
//                    dataDisplayDictNo2 = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TempDisplayDictNo2"] mutableCopy];
//                    dataDisplayAmountDictNo2 = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TempDisplayAmountDictNo2"] mutableCopy];
//                    
//                    itemDictNo3 = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TempItemDict"] mutableCopy];
//                    dataDisplaySectionsArrayNo3 = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TempDisplaySectionsArray"] mutableCopy];
//                    dataDisplayDictNo3 = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TempDisplayDict"] mutableCopy];
//                    dataDisplayAmountDictNo3 = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TempDisplayAmountDict"] mutableCopy];
//                    
//                } else if ([itemType isEqualToString:@"List"]) {
//                    
//                    itemDict = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TempItemDictNo2"] mutableCopy];
//                    dataDisplaySectionsArray = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TempDisplaySectionsArrayNo2"] mutableCopy];
//                    dataDisplayDict = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TempDisplayDictNo2"] mutableCopy];
//                    dataDisplayAmountDict = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TempDisplayAmountDictNo2"] mutableCopy];
//                    
//                    itemDictNo2 = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TempItemDict"] mutableCopy];
//                    dataDisplaySectionsArrayNo2 = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TempDisplaySectionsArray"] mutableCopy];
//                    dataDisplayDictNo2 = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TempDisplayDict"] mutableCopy];
//                    dataDisplayAmountDictNo2 = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TempDisplayAmountDict"] mutableCopy];
//                    
//                    itemDictNo3 = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TempItemDictNo1"] mutableCopy];
//                    dataDisplaySectionsArrayNo3 = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TempDisplaySectionsArrayNo1"] mutableCopy];
//                    dataDisplayDictNo3 = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TempDisplayDictNo1"] mutableCopy];
//                    dataDisplayAmountDictNo3 = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TempDisplayAmountDictNo1"] mutableCopy];
//                    
//                }
//                
//                NSMutableArray *sideBarCategorySectionArrayAltered = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TempSideBarCategorySectionArrayAltered"] mutableCopy];
//                NSMutableArray *sideBarCategorySectionArrayOriginal = [[[NSUserDefaults standardUserDefaults] objectForKey:@"TempSideBarCategorySectionArrayOriginal"] mutableCopy];
//               
//                int sectionOriginalSection = [[[NSUserDefaults standardUserDefaults] objectForKey:@"sectionOriginalSection"] intValue];
//                int usersSection = [[[NSUserDefaults standardUserDefaults] objectForKey:@"usersSection"] intValue];
//                int tagsSection = [[[NSUserDefaults standardUserDefaults] objectForKey:@"tagsSection"] intValue];
//                int colorsSection = [[[NSUserDefaults standardUserDefaults] objectForKey:@"colorsSection"] intValue];
//                
//                [[[DisplayTasksObject alloc] init] GenerateItemsToDisplayForSpecificItem:dictToUse itemType:itemType keyArray:keyArray homeMembersDict:homeMembersDict sideBarCategorySectionArrayAltered:sideBarCategorySectionArrayAltered taskListDict:taskListDict dataDisplayDict:dataDisplayDict dataDisplaySectionsArray:dataDisplaySectionsArray dataDisplayAmountDict:dataDisplayAmountDict sectionDict:sectionDict pinnedDict:[NSMutableDictionary dictionary] sideBarCategorySectionArrayOriginal:sideBarCategorySectionArrayOriginal sectionOriginalSection:sectionOriginalSection usersSection:usersSection tagsSection:tagsSection colorsSection:colorsSection completionHandler:^(BOOL finished, NSMutableArray * _Nonnull returningDataDisplaySectionsArray, NSMutableDictionary * _Nonnull returningDataDisplayDict, NSMutableDictionary * _Nonnull returningDataDisplayAmountDict) {
//                    
//                    if ([itemType isEqualToString:@"Chore"]) {
//                        
//                        [[NSUserDefaults standardUserDefaults] setObject:returningDataDisplaySectionsArray forKey:@"TempDisplaySectionsArray"];
//                        [[NSUserDefaults standardUserDefaults] setObject:returningDataDisplayDict forKey:@"TempDisplayDict"];
//                        [[NSUserDefaults standardUserDefaults] setObject:returningDataDisplayAmountDict forKey:@"TempDisplayAmountDict"];
//                        
//                    } else if ([itemType isEqualToString:@"Expense"]) {
//                        
//                        [[NSUserDefaults standardUserDefaults] setObject:returningDataDisplaySectionsArray forKey:@"TempDisplaySectionsArrayNo1"];
//                        [[NSUserDefaults standardUserDefaults] setObject:returningDataDisplayDict forKey:@"TempDisplayDictNo1"];
//                        [[NSUserDefaults standardUserDefaults] setObject:returningDataDisplayAmountDict forKey:@"TempDisplayAmountDictNo1"];
//                        
//                    } else if ([itemType isEqualToString:@"List"]) {
//                        
//                        [[NSUserDefaults standardUserDefaults] setObject:returningDataDisplaySectionsArray forKey:@"TempDisplaySectionsArrayNo2"];
//                        [[NSUserDefaults standardUserDefaults] setObject:returningDataDisplayDict forKey:@"TempDisplayDictNo2"];
//                        [[NSUserDefaults standardUserDefaults] setObject:returningDataDisplayAmountDict forKey:@"TempDisplayAmountDictNo2"];
//                        
//                    }
//                    
//                }];
//                
//            }
            
            
            
            NSMutableArray *userIDArray = [NSMutableArray array];
            NSMutableArray *userIDToRemoveArray = [NSMutableArray array];
            
            
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                [[[NotificationsObject alloc] init] ResetLocalNotificationReminderNotification:dictToUse homeMembersDict:homeMembersDict userIDArray:userIDArray userIDToRemoveArray:userIDToRemoveArray notificationSettingsDict:notificationSettingsDict allItemTagsArrays:allItemTagsArrays itemType:itemType notificationType:notificationType topicDict:topicDict completionHandler:^(BOOL finished) {
                    
                }];
                
            });
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                [[[NotificationsObject alloc] init] ResetLocalNotificationScheduledStartNotifications:dictToUse itemType:itemType userIDArray:userIDArray userIDToRemoveArray:userIDToRemoveArray allItemTagsArrays:allItemTagsArrays homeMembersArray:[NSMutableArray array] homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict topicDict:topicDict completionHandler:^(BOOL finished) {
                    
                }];
                
            });
            
        } else if (userInfo[@"RemoveLocalNotificationReminderNotifications"]) {
            
            id homeMembersDict =
            [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeMembersDict"] ?
            [[[NSUserDefaults standardUserDefaults] objectForKey:@"HomeMembersDict"] mutableCopy] : [NSMutableDictionary dictionary];
            id topicDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"TopicDict"] ?
            [[[NSUserDefaults standardUserDefaults] objectForKey:@"TopicDict"] mutableCopy] : [NSMutableDictionary dictionary];
            
            id itemID = userInfo[@"ItemID"] ? userInfo[@"ItemID"] : @"";
            id itemOccurrenceID = userInfo[@"ItemOccurrenceID"] ? userInfo[@"ItemOccurrenceID"] : @"";
            id itemUniqueID = userInfo[@"ItemUniqueID"] ? userInfo[@"ItemUniqueID"] : @"";
            id itemCreatedBy = userInfo[@"ItemCreatedBy"] ? userInfo[@"ItemCreatedBy"] : @"";
            
            NSMutableArray *userIDArray = [NSMutableArray array];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                [[[NotificationsObject alloc] init] RemoveLocalNotificationReminderNotifications:itemID itemOccurrenceID:itemOccurrenceID itemUniqueID:itemUniqueID userIDArray:userIDArray itemCreatedBy:itemCreatedBy homeMembersDict:homeMembersDict topicDict:topicDict completionHandler:^(BOOL finished) {
                   
                }];
                
            });
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                [[[NotificationsObject alloc] init] RemoveLocalNotificationScheduledStartNotifications:itemID itemOccurrenceID:itemOccurrenceID itemUniqueID:itemUniqueID userIDArray:userIDArray homeMembersDict:homeMembersDict topicDict:topicDict completionHandler:^(BOOL finished) {
                    
                }];
                
            });
            
        } else if (userInfo[@"RemoveLocalNotificationScheduledStartNotifications"]) {
            
            id homeMembersDict =
            [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeMembersDict"] ?
            [[[NSUserDefaults standardUserDefaults] objectForKey:@"HomeMembersDict"] mutableCopy] : [NSMutableDictionary dictionary];
            id topicDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"TopicDict"] ?
            [[[NSUserDefaults standardUserDefaults] objectForKey:@"TopicDict"] mutableCopy] : [NSMutableDictionary dictionary];
            
            id itemID = userInfo[@"ItemID"] ? userInfo[@"ItemID"] : @"";
            id itemOccurrenceID = userInfo[@"ItemOccurrenceID"] ? userInfo[@"ItemOccurrenceID"] : @"";
            id itemUniqueID = userInfo[@"ItemUniqueID"] ? userInfo[@"ItemUniqueID"] : @"";
            
            NSMutableArray *userIDArray = [NSMutableArray array];
            
            [[[NotificationsObject alloc] init] RemoveLocalNotificationScheduledStartNotifications:itemID itemOccurrenceID:itemOccurrenceID itemUniqueID:itemUniqueID userIDArray:userIDArray homeMembersDict:homeMembersDict topicDict:topicDict completionHandler:^(BOOL finished) {
                
            }];
            
        }
        
    } else if (![[NSUserDefaults standardUserDefaults] objectForKey:@"CurrentInLiveChat"]) {
        
        silentNotification = NO;
        
        NSLog(@"Notification2 %@", userInfo);
        
        NSDictionary *apsDict = userInfo[@"aps"];
        NSDictionary *alertDict = apsDict[@"alert"];
        NSString *title = alertDict[@"title"];
        NSString *body = alertDict[@"body"];
        UNNotificationSound *sound = [UNNotificationSound defaultSound];
        
        if ([title containsString:@"New Message"]) {
            
            [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"NewMessage"];
            
            sound = [UNNotificationSound soundNamed:@"ka-ching.caf"];
            
        }
        
        if (!userInfo[@"com.google.firebase.auth"][@"warning"]){
            
            [UNUserNotificationCenter currentNotificationCenter].delegate = self;
            
            UNNotificationAction *ActionBtn1 = [UNNotificationAction actionWithIdentifier:@"Btn1" title:@"BUTTON 1" options:UNNotificationActionOptionNone];
            UNNotificationAction *ActionBtn2 = [UNNotificationAction actionWithIdentifier:@"Btn2" title:@"BUTTON 2" options:UNNotificationActionOptionDestructive];
            UNNotificationCategory *category = [UNNotificationCategory categoryWithIdentifier:@"pusher" actions:@[ActionBtn1,ActionBtn2] intentIdentifiers:@[] options:UNNotificationCategoryOptionNone];
            NSSet *categories = [NSSet setWithObject:category];
            [[UNUserNotificationCenter currentNotificationCenter] setNotificationCategories:categories];
            
            UNAuthorizationOptions authOptions = UNAuthorizationOptionAlert |
            UNAuthorizationOptionSound | UNAuthorizationOptionBadge;
            [[UNUserNotificationCenter currentNotificationCenter]
             requestAuthorizationWithOptions:authOptions
             completionHandler:^(BOOL granted, NSError * _Nullable error) {
                NSLog(@"request auth");
            }];
            
            UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
            
            UNMutableNotificationContent* contentFor3Days = [[UNMutableNotificationContent alloc] init];
            
            contentFor3Days.title = [NSString localizedUserNotificationStringForKey:title arguments:nil];
            contentFor3Days.body = [NSString localizedUserNotificationStringForKey:body arguments:nil];
            contentFor3Days.sound = sound;
            contentFor3Days.categoryIdentifier = @"Now";
            
            UNTimeIntervalNotificationTrigger* triggerFor3Days = [UNTimeIntervalNotificationTrigger
                                                                  triggerWithTimeInterval:1 repeats:NO];
            UNNotificationRequest* requestFor3Days = [UNNotificationRequest requestWithIdentifier:@"Now"
                                                                                          content:contentFor3Days trigger:triggerFor3Days];
            
            ActionBtn1 = [UNNotificationAction actionWithIdentifier:@"Btn1" title:@"BUTTON 1" options:UNNotificationActionOptionNone];
            ActionBtn2 = [UNNotificationAction actionWithIdentifier:@"Btn2" title:@"BUTTON 2" options:UNNotificationActionOptionDestructive];
            category = [UNNotificationCategory categoryWithIdentifier:@"pusher" actions:@[ActionBtn1,ActionBtn2] intentIdentifiers:@[] options:UNNotificationCategoryOptionNone];
            categories = [NSSet setWithObject:category];
            [center setNotificationCategories:categories];
            
            [center addNotificationRequest:requestFor3Days withCompletionHandler:nil];
            
        }
        
        completionHandler(UIBackgroundFetchResultNewData);
        
    }
    
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response
         withCompletionHandler:(void(^)(void))completionHandler {
    
    NSLog(@"didReceiveNotificationResponse %@ -- %@", response, center);
    
    NSString *previousState = [self GeneratePreviousState];
    NSString *notificationID = [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString];
    
    [self NotificationCenterNotificationActions:response previousState:previousState];
    
    [self NotificationCenterPushToViewController:response previousState:previousState notificationID:notificationID];
    
    [self NotificationCenterSetDataNotificationOpen:response previousState:previousState notificationID:notificationID withCompletionHandler:^{
        
        completionHandler();
        
    }];
    
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    
    NSLog(@"willPresentNotification %@", notification.request.content.userInfo);
    
    [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    
    UNAuthorizationOptions authOptions = UNAuthorizationOptionAlert |
    UNAuthorizationOptionSound | UNAuthorizationOptionBadge;
    [[UNUserNotificationCenter currentNotificationCenter]
     requestAuthorizationWithOptions:authOptions
     completionHandler:^(BOOL granted, NSError * _Nullable error) {
        NSLog(@"request auth");
    }];
    
    if (!silentNotification && ![[NSUserDefaults standardUserDefaults] objectForKey:@"CurrentInLiveChat"]) {
        
        if (@available(iOS 14.0, *)) {
            completionHandler(UNNotificationPresentationOptionList | UNNotificationPresentationOptionBanner);
        } else {
            completionHandler(UNNotificationPresentationOptionList | UNNotificationPresentationOptionBanner | UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound);
        }
        
    } else {
        
        silentNotification = NO;
        
    }
    
}

#pragma mark - Custom Methods

-(void)PushToViewControllerFromNotificationClickSceneDelegate:(NSDictionary *)userInfo previousState:(NSString *)previousState notificationID:(NSString *)notificationID {
    
    if (@available(iOS 13.0, *)) {
        
        SceneDelegate *del = (SceneDelegate *)[UIApplication sharedApplication].connectedScenes.allObjects.firstObject.delegate;
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        UIViewController *notificationClickViewController = [[UIViewController alloc] init];
        notificationClickViewController.restorationIdentifier = @"NotificationClick";
        
        NSString *delegateType = @"Scene";
      
        if (userInfo[@"Home"]) {
            
            
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:notificationClickViewController touchEvent:[NSString stringWithFormat:@"%@ Delegate - %@ - %@ - %@", delegateType, previousState, @"Home", notificationID] completionHandler:^(BOOL finished) {
                
            }];
            
            
            
            HomeMembersViewController *homeMembersViewControllerObject = [storyBoard instantiateViewControllerWithIdentifier:@"HomeMembersViewController"];
            TasksViewController *TasksViewControllerObject = [storyBoard instantiateViewControllerWithIdentifier:@"TasksViewController"];
            
            
            
            
            BOOL viewingHomeMembersFromHomesViewController = [userInfo[@"viewingHomeMembersFromHomesViewController"] isEqualToString:@"Yes"] ? YES : NO;
            
            id homeID = userInfo[@"HomeID"] ? userInfo[@"HomeID"] : @"xxx";
            id homeName = userInfo[@"HomeName"] ? userInfo[@"HomeName"] : @"";
            
            id notificationSettingsDict = userInfo[@"NotificationSettingsDict"] && [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"NotificationSettingsDict"]] ? [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"NotificationSettingsDict"]] : [NSMutableDictionary dictionary];
            id topicDict = userInfo[@"TopicDict"] && [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"TopicDict"]] ? [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"TopicDict"]] : [NSMutableDictionary dictionary];
            
            
            
            
            homeMembersViewControllerObject.viewingHomeMembersFromHomesViewController = viewingHomeMembersFromHomesViewController;
            
            homeMembersViewControllerObject.homeID = homeID;
            homeMembersViewControllerObject.homeName = homeName;
            
            homeMembersViewControllerObject.notificationSettingsDict = notificationSettingsDict;
            
            
            
            UINavigationController *navVC = (UINavigationController *)del.window.rootViewController;
            [navVC pushViewController:TasksViewControllerObject animated:YES];
            [navVC pushViewController:homeMembersViewControllerObject animated:YES];
            
            
            
            [[[PushObject alloc] init] PushToHomeMembersViewController:homeID homeName:homeName notificationSettingsDict:notificationSettingsDict topicDict:topicDict viewingHomeMembersFromHomesViewController:viewingHomeMembersFromHomesViewController currentViewController:[[UIViewController alloc] init] Superficial:YES];
            
            
            
        } else if (userInfo[@"GroupChat"]) {
            
            
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:notificationClickViewController touchEvent:[NSString stringWithFormat:@"%@ Delegate - %@ - %@ - %@", delegateType, previousState, @"GroupChat", notificationID] completionHandler:^(BOOL finished) {
                
            }];
            
            
            
            LiveChatNavigationController *liveChatViewControllerObject = [storyBoard instantiateViewControllerWithIdentifier:@"LiveChatNavigationController"];
            ChatsViewController *chatsViewControllerObject = [storyBoard instantiateViewControllerWithIdentifier:@"ChatsViewController"];
            
            
            
            BOOL viewingGroupChat = userInfo[@"ViewingGroupChat"] && [userInfo[@"ViewingGroupChat"] isEqualToString:@"Yes"] ? YES : NO;
            
            id userID = userInfo[@"UserID"] ? userInfo[@"UserID"] : @"";
            id homeID = userInfo[@"HomeID"] ? userInfo[@"HomeID"] : @"xxx";
            id chatID = userInfo[@"ChatID"] ? userInfo[@"ChatID"] : @"";
            id chatName = userInfo[@"ChatName"] ? userInfo[@"ChatName"] : @"";
            
            id chatAssignedTo = userInfo[@"ChatAssignedTo"] && [[[GeneralObject alloc] init] GenerateArrayID:userInfo[@"ChatAssignedTo"]] ? [[[GeneralObject alloc] init] GenerateArrayID:userInfo[@"ChatAssignedTo"]] : [NSMutableArray array];
            
            id homeMembersDict = userInfo[@"HomeMembersDict"] && [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"HomeMembersDict"]] ? [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"HomeMembersDict"]] : [NSMutableDictionary dictionary];
            id notificationSettingsDict = userInfo[@"NotificationSettingsDict"] && [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"NotificationSettingsDict"]] ? [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"NotificationSettingsDict"]] : [NSMutableDictionary dictionary];
            id topicDict = userInfo[@"TopicDict"] && [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"TopicDict"]] ? [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"TopicDict"]] : [NSMutableDictionary dictionary];
            
            
            
            UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"LiveChatNavigationController" source:del.window.rootViewController destination:liveChatViewControllerObject];
            
            [liveChatViewControllerObject prepareForSegue:segue sender:
             
             @{@"userID" : userID ? userID : @"",
               @"homeID" : homeID ? homeID : @"",
               @"chatID" : chatID ? chatID : @"",
               @"chatName" : chatName ? chatName : @"",
               
               @"homeMembersDict" : homeMembersDict ? homeMembersDict : [NSMutableDictionary dictionary],
               @"notificationSettingsDict" : notificationSettingsDict ? notificationSettingsDict : [NSMutableDictionary dictionary],
               @"topicDict" : topicDict ? topicDict : [NSMutableDictionary dictionary],
               
               @"chatAssignedTo" : chatAssignedTo ? chatAssignedTo : [NSMutableArray array],
               
               @"viewingGroupChat" : viewingGroupChat ? @"Yes" : @"No"
             }];
            
            
            
            [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"ViewingExpenses"];
            [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"ViewingLists"];
            [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"ViewingChats"];
            
            
            
            UINavigationController *navVC = (UINavigationController *)del.window.rootViewController;
            [navVC pushViewController:chatsViewControllerObject animated:YES];
            
            liveChatViewControllerObject.modalInPresentation = true;
            liveChatViewControllerObject.modalPresentationStyle = UIModalPresentationPopover;
            [navVC presentViewController:liveChatViewControllerObject animated:YES completion:nil];
            
            
            
            [[[PushObject alloc] init] PushToLiveChatViewControllerFromGroupChatsTab:userID homeID:homeID chatID:chatID chatName:chatName chatAssignedTo:chatAssignedTo homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict topicDict:topicDict currentViewController:[[UIViewController alloc] init] Superficial:YES];
            
            
            
        } else if (userInfo[@"Comment"]) {
            
            
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:notificationClickViewController touchEvent:[NSString stringWithFormat:@"%@ Delegate - %@ - %@ - %@", delegateType, previousState, @"Comment", notificationID] completionHandler:^(BOOL finished) {
                
            }];
            
            
            
            LiveChatNavigationController *liveChatViewControllerObject = [storyBoard instantiateViewControllerWithIdentifier:@"LiveChatNavigationController"];
            
            
            
            BOOL viewingComments = userInfo[@"ViewingComments"] && [userInfo[@"ViewingComments"] isEqualToString:@"Yes"] ? YES : NO;
            
            id homeID = userInfo[@"HomeID"] ? userInfo[@"HomeID"] : @"xxx";
            
            id itemType = userInfo[@"ItemType"] ? userInfo[@"ItemType"] : @"";
            id itemID = userInfo[@"ItemID"] ? userInfo[@"ItemID"] : @"";
            id itemName = userInfo[@"ItemName"] ? userInfo[@"ItemName"] : @"";
            id itemCreatedBy = userInfo[@"ItemCreatedBy"] ? userInfo[@"ItemCreatedBy"] : @"";
            
            id itemAssignedTo = userInfo[@"ItemAssignedTo"] && [[[GeneralObject alloc] init] GenerateArrayID:userInfo[@"ItemAssignedTo"]] ? [[[GeneralObject alloc] init] GenerateArrayID:userInfo[@"ItemAssignedTo"]] : [NSMutableArray array];
            
            id homeMembersDict = userInfo[@"HomeMembersDict"] && [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"HomeMembersDict"]] ? [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"HomeMembersDict"]] : [NSMutableDictionary dictionary];
            id notificationSettingsDict = userInfo[@"NotificationSettingsDict"] && [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"NotificationSettingsDict"]] ? [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"NotificationSettingsDict"]] : [NSMutableDictionary dictionary];
            id topicDict = userInfo[@"TopicDict"] && [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"TopicDict"]] ? [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"TopicDict"]] : [NSMutableDictionary dictionary];
            
            
            
            if ([itemAssignedTo containsObject:itemCreatedBy] == NO) {
                
                [itemAssignedTo addObject:itemCreatedBy];
                
            }
            
            
            
            UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"LiveChatNavigationController" source:del.window.rootViewController destination:liveChatViewControllerObject];
            
            [liveChatViewControllerObject prepareForSegue:segue sender:
             
             @{@"homeID" : homeID ? homeID : @"",
               
               @"itemID" : itemID ? itemID : @"",
               @"itemName" : itemName ? itemName : @"",
               @"itemCreatedBy" : itemCreatedBy ? itemCreatedBy : @"",
               
               @"homeMembersDict" : homeMembersDict ? homeMembersDict : [NSMutableDictionary dictionary],
               @"notificationSettingsDict" : notificationSettingsDict ? notificationSettingsDict : [NSMutableDictionary dictionary],
               @"topicDict" : topicDict ? topicDict : [NSMutableDictionary dictionary],
               
               @"itemAssignedTo" : itemAssignedTo ? itemAssignedTo : [NSMutableArray array],
               
               @"viewingComments" : viewingComments ? @"Yes" : @"No"
             }];
            
            
            
            [[NSUserDefaults standardUserDefaults] setObject:[itemType isEqualToString:@"Expense"] ? @"Yes" : @"No" forKey:@"ViewingExpenses"];
            [[NSUserDefaults standardUserDefaults] setObject:[itemType isEqualToString:@"List"] ? @"Yes" : @"No" forKey:@"ViewingLists"];
            [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"ViewingChats"];
            
            
            
            UINavigationController *navVC = (UINavigationController *)del.window.rootViewController;
            
            
            
            TasksViewController *TasksViewControllerObject = [storyBoard instantiateViewControllerWithIdentifier:@"TasksViewController"];
            [navVC pushViewController:TasksViewControllerObject animated:YES];
            
            
            
            liveChatViewControllerObject.modalInPresentation = true;
            liveChatViewControllerObject.modalPresentationStyle = UIModalPresentationPopover;
            [navVC presentViewController:liveChatViewControllerObject animated:YES completion:nil];
            
            
            
            [[[PushObject alloc] init] PushToLiveChatViewControllerFromViewTaskPage:homeID itemID:itemID itemName:itemName itemCreatedBy:itemCreatedBy itemAssignedTo:itemAssignedTo homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict topicDict:topicDict currentViewController:[[UIViewController alloc] init] Superficial:YES];
            
            
            
        } else if (userInfo[@"Live Support"]) {
            
            
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:notificationClickViewController touchEvent:[NSString stringWithFormat:@"%@ Delegate - %@ - %@ - %@", delegateType, previousState, @"Live Support", notificationID] completionHandler:^(BOOL finished) {
                
            }];
            
            
            
            LiveChatNavigationController *liveChatViewControllerObject = [storyBoard instantiateViewControllerWithIdentifier:@"LiveChatNavigationController"];
            TasksViewController *TasksViewControllerObject = [storyBoard instantiateViewControllerWithIdentifier:@"TasksViewController"];
            
            
            
            BOOL viewingLiveSupport = userInfo[@"ViewngLiveSupport"] && [userInfo[@"ViewngLiveSupport"] isEqualToString:@"Yes"] ? YES : NO;
            
            id userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
            
            
            
            UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"LiveChatNavigationController" source:del.window.rootViewController destination:liveChatViewControllerObject];
            
            [liveChatViewControllerObject prepareForSegue:segue sender:
             
             @{@"userID" : userID ? userID : @"",
               
               @"viewingLiveSupport" : @"Yes"
             }];
            
            
            
            UINavigationController *navVC = (UINavigationController *)del.window.rootViewController;
            [navVC pushViewController:TasksViewControllerObject animated:YES];
            
            liveChatViewControllerObject.modalInPresentation = true;
            liveChatViewControllerObject.modalPresentationStyle = UIModalPresentationPopover;
            [navVC presentViewController:liveChatViewControllerObject animated:YES completion:nil];
            
            
            
            [[[PushObject alloc] init] PushToLiveChatViewControllerFromSettingsPage:userID viewingLiveSupport:viewingLiveSupport currentViewController:[[UIViewController alloc] init] Superficial:YES];
            
            
            
        } else if (userInfo[@"Forum"]) {
            
            
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:notificationClickViewController touchEvent:[NSString stringWithFormat:@"%@ Delegate - %@ - %@ - %@", delegateType, previousState, @"Forum", notificationID] completionHandler:^(BOOL finished) {
                
            }];
            
            
            
            AddForumViewController *addForumViewControllerObject = [storyBoard instantiateViewControllerWithIdentifier:@"AddForumViewController"];
            ForumViewController *forumViewControllerObject = [storyBoard instantiateViewControllerWithIdentifier:@"ForumViewController"];
            SettingsViewController *settingsViewControllerObject = [storyBoard instantiateViewControllerWithIdentifier:@"SettingsViewController"];
            
            
            
            BOOL viewingFeatureForum = userInfo[@"FeatureForum"] && [userInfo[@"FeatureForum"] isEqualToString:@"Yes"] ? YES : NO;
            BOOL editingSpecificForumPost = NO;
            BOOL viewingSpecificForumPost = YES;
            
            id forumDict = userInfo[@"ForumDict"] && [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"ForumDict"]] ? [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"ForumDict"]] : [NSMutableDictionary dictionary];
            
            
            
            addForumViewControllerObject.viewingFeatureForum = viewingFeatureForum;
            addForumViewControllerObject.editingSpecificForumPost = editingSpecificForumPost;
            addForumViewControllerObject.viewingSpecificForumPost = viewingSpecificForumPost;
            
            addForumViewControllerObject.itemToEditDict = forumDict;
            
            forumViewControllerObject.viewingFeatureForum = viewingFeatureForum;
            
            
            
            UINavigationController *navVC = (UINavigationController *)del.window.rootViewController;
            [navVC pushViewController:settingsViewControllerObject animated:YES];
            [navVC pushViewController:forumViewControllerObject animated:YES];
            
            
            
            [[[PushObject alloc] init] PushToAddForumViewController:nil viewingFeatureForum:viewingFeatureForum editingSpecificForumPost:editingSpecificForumPost viewingSpecificForumPost:viewingSpecificForumPost currentViewController:[[UIViewController alloc] init] Superficial:NO];
            
            
        } else if (userInfo[@"WeDivvyPremium"]) {
            
            
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:notificationClickViewController touchEvent:[NSString stringWithFormat:@"%@ Delegate - %@ - %@ - %@", delegateType, previousState, @"WeDivvyPremium", notificationID] completionHandler:^(BOOL finished) {
                
            }];
            
            
            
            WeDivvyPremiumNavigationController *weDivvyPremiumViewControllerObject = [storyBoard instantiateViewControllerWithIdentifier:@"WeDivvyPremiumNavigationController"];
            TasksViewController *TasksViewControllerObject = [storyBoard instantiateViewControllerWithIdentifier:@"TasksViewController"];
            
            
            
            UINavigationController *navVC = (UINavigationController *)del.window.rootViewController;
            [navVC pushViewController:TasksViewControllerObject animated:YES];
            
            weDivvyPremiumViewControllerObject.modalInPresentation = true;
            weDivvyPremiumViewControllerObject.modalPresentationStyle = UIModalPresentationPopover;
            [navVC presentViewController:weDivvyPremiumViewControllerObject animated:YES completion:nil];
            
            
            
            [[[PushObject alloc] init] PushToWeDivvyPremiumViewController:NO comingFromSignUp:NO defaultPlan:@"" displayDiscount:@"Half-Off Yearly Discount No Sale Sticker" selectedSlide:@"" promoCodeID:@"" premiumPlanProductsArray:[NSMutableArray array] premiumPlanPricesDict:[NSMutableDictionary dictionary] premiumPlanExpensivePricesDict:[NSMutableDictionary dictionary] premiumPlanPricesDiscountDict:[NSMutableDictionary dictionary] premiumPlanPricesNoFreeTrialDict:[NSMutableDictionary dictionary] currentViewController:[[UIViewController alloc] init] Superficial:YES];
            
            
            
        } else if (userInfo[@"PurchasePremium"] || userInfo[@"UpgradePremium"]) {
            
            
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:notificationClickViewController touchEvent:[NSString stringWithFormat:@"%@ Delegate - %@ - %@ - %@", delegateType, previousState, @"PurchasePremium", notificationID] completionHandler:^(BOOL finished) {
                
            }];
            
            
            
            WeDivvyPremiumNavigationController *weDivvyPremiumViewControllerObject = [storyBoard instantiateViewControllerWithIdentifier:@"WeDivvyPremiumNavigationController"];
            TasksViewController *TasksViewControllerObject = [storyBoard instantiateViewControllerWithIdentifier:@"TasksViewController"];
            
            
            
            id defaultPlan = userInfo[@"DefaultPlan"] ? userInfo[@"DefaultPlan"] : @"";
            
            
            
            UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"WeDivvyPremiumNavigationController" source:del.window.rootViewController destination:weDivvyPremiumViewControllerObject];
            
            [weDivvyPremiumViewControllerObject prepareForSegue:segue sender:
             
             @{@"defaultPlan" : defaultPlan ? defaultPlan : @""
               
             }];
            
            
            
            UINavigationController *navVC = (UINavigationController *)del.window.rootViewController;
            [navVC pushViewController:TasksViewControllerObject animated:YES];
            
            weDivvyPremiumViewControllerObject.modalInPresentation = true;
            weDivvyPremiumViewControllerObject.modalPresentationStyle = UIModalPresentationPopover;
            [navVC presentViewController:weDivvyPremiumViewControllerObject animated:YES completion:nil];
            
            
            
            [[[PushObject alloc] init] PushToWeDivvyPremiumViewController:NO comingFromSignUp:NO defaultPlan:@"" displayDiscount:@"Half-Off Yearly Discount No Sale Sticker" selectedSlide:@"" promoCodeID:@"" premiumPlanProductsArray:[NSMutableArray array] premiumPlanPricesDict:[NSMutableDictionary dictionary] premiumPlanExpensivePricesDict:[NSMutableDictionary dictionary] premiumPlanPricesDiscountDict:[NSMutableDictionary dictionary] premiumPlanPricesNoFreeTrialDict:[NSMutableDictionary dictionary] currentViewController:[[UIViewController alloc] init] Superficial:YES];
            
            
            
        } else if (userInfo[@"Item"]) {
            
            
            
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:notificationClickViewController touchEvent:[NSString stringWithFormat:@"%@ Delegate - %@ - %@ - %@", delegateType, previousState, @"Item", notificationID] completionHandler:^(BOOL finished) {
                
            }];
            
            
            
            BOOL TaskNeedsToBeResetFirst = NO;
            
            if (userInfo[@"NotificationFrequency"]) {
                
                if ([userInfo[@"NotificationFrequency"] isEqualToString:@"Now"]) {
                    
                    TaskNeedsToBeResetFirst = YES;
                    
                }
                
            }
            
            
            
            if (TaskNeedsToBeResetFirst == NO) {
                
                
                
                ViewTaskNavigationController *viewTaskViewControllerObject = [storyBoard instantiateViewControllerWithIdentifier:@"ViewTaskNavigationController"];
                
                
                
                id itemType =                           userInfo[@"ItemType"] ? userInfo[@"ItemType"] : @"";
                
                BOOL viewingOccurrence =                userInfo[@"ItemOccurrenceID"] && [userInfo[@"ItemOccurrenceID"] length] == 0 ? NO : YES;
                BOOL viewingViewExpenseViewController = [itemType isEqualToString:@"Expense"] ? YES : NO;
                BOOL viewingViewListViewController =    [itemType isEqualToString:@"List"] ? YES : NO;
                
                id homeMembersArray =         userInfo[@"HomeMembersArray"] &&         [[[GeneralObject alloc] init] GenerateArrayID:userInfo[@"HomeMembersArray"]] ?              [[[GeneralObject alloc] init] GenerateArrayID:userInfo[@"HomeMembersArray"]]              : [NSMutableArray array];
                id itemNamesAlreadyUsed =     userInfo[@"ItemNamesAlreadyUsed"] &&     [[[GeneralObject alloc] init] GenerateArrayID:userInfo[@"ItemNamesAlreadyUsed"]] ?          [[[GeneralObject alloc] init] GenerateArrayID:userInfo[@"ItemNamesAlreadyUsed"]]          : [NSMutableArray array];
                id allItemTagsArrays =        userInfo[@"AllItemTagsArrays"] &&        [[[GeneralObject alloc] init] GenerateArrayID:userInfo[@"AllItemTagsArrays"]] ?             [[[GeneralObject alloc] init] GenerateArrayID:userInfo[@"AllItemTagsArrays"]]             : [NSMutableArray array];
                id allItemAssignedToArrays =  userInfo[@"AllItemAssignedToArrays"] &&  [[[GeneralObject alloc] init] GenerateArrayID:userInfo[@"AllItemAssignedToArrays"]] ?       [[[GeneralObject alloc] init] GenerateArrayID:userInfo[@"AllItemAssignedToArrays"]]       : [NSMutableArray array];
                
                id topicDict =                userInfo[@"TopicDict"] &&                [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"TopicDict"]] ?                [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"TopicDict"]]                : [NSMutableDictionary dictionary];
                id taskListDict =             userInfo[@"TaskListDict"] &&             [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"TaskListDict"]] ?             [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"TaskListDict"]]             : [NSMutableDictionary dictionary];
                
                id itemID =           userInfo[@"ItemID"] ? userInfo[@"ItemID"] : @"";
                id itemOccurrenceID = userInfo[@"ItemOccurrenceID"] ? userInfo[@"ItemOccurrenceID"] : @"";
                
                
                
                UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"ViewTaskNavigationController" source:del.window.rootViewController destination:viewTaskViewControllerObject];
                
                [viewTaskViewControllerObject prepareForSegue:segue sender:
                 
                 @{@"itemID" : itemID ? itemID : @"",
                   @"itemOccurrenceID" : itemOccurrenceID ? itemOccurrenceID : @"",
                   
                   @"homeMembersArray" : homeMembersArray ? homeMembersArray : [NSMutableArray array],
                   
                   @"itemNamesAlreadyUsed" : itemNamesAlreadyUsed ? itemNamesAlreadyUsed : [NSMutableArray array],
                   @"allItemAssignedToArrays" : allItemAssignedToArrays ? allItemAssignedToArrays : [NSMutableArray array],
                   @"allItemTagsArrays" : allItemTagsArrays ? allItemTagsArrays : [NSMutableArray array],
                   
                   @"topicDict" : topicDict ? topicDict : [NSMutableDictionary dictionary],
                   @"taskListDict" : taskListDict ? taskListDict : [NSMutableDictionary dictionary],
                   
                   @"viewingOccurrence" : viewingOccurrence ? @"Yes" : @"No",
                   @"viewingViewExpenseViewController" : viewingViewExpenseViewController ? @"Yes" : @"No",
                   @"viewingViewListViewController" : viewingViewListViewController ? @"Yes" : @"No"
                   
                 }];
                
                
                
                [[NSUserDefaults standardUserDefaults] setObject:[itemType isEqualToString:@"Expense"] ? @"Yes" : @"No" forKey:@"ViewingExpenses"];
                [[NSUserDefaults standardUserDefaults] setObject:[itemType isEqualToString:@"List"] ? @"Yes" : @"No" forKey:@"ViewingLists"];
                [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"ViewingChats"];
                
                
                
                UINavigationController *navVC = (UINavigationController *)del.window.rootViewController;
                
                
                
                TasksViewController *TasksViewControllerObject = [storyBoard instantiateViewControllerWithIdentifier:@"TasksViewController"];
                
                [navVC pushViewController:TasksViewControllerObject animated:YES];
                
                
                
                viewTaskViewControllerObject.modalInPresentation = true;
                viewTaskViewControllerObject.modalPresentationStyle = UIModalPresentationPopover;
                [navVC presentViewController:viewTaskViewControllerObject animated:YES completion:nil];
                
                
                
                [[[PushObject alloc] init] PushToViewTaskViewController:itemID itemOccurrenceID:itemOccurrenceID itemDictFromPreviousPage:[NSMutableDictionary dictionary] homeMembersArray:homeMembersArray homeMembersDict:[NSMutableDictionary dictionary] itemOccurrencesDict:[NSMutableDictionary dictionary] folderDict:[NSMutableDictionary dictionary] taskListDict:taskListDict templateDict:[NSMutableDictionary dictionary] draftDict:[NSMutableDictionary dictionary] notificationSettingsDict:[NSMutableDictionary dictionary] topicDict:[NSMutableDictionary dictionary] itemNamesAlreadyUsed:[NSMutableArray array] allItemAssignedToArrays:[NSMutableArray array] allItemTagsArrays:[NSMutableArray array] allItemIDsArrays:[NSMutableArray array] currentViewController:[[UIViewController alloc] init] Superficial:YES];
                
                
                
            }
            
        }
        
    } else {
        // Fallback on earlier versions
    }
    
}

-(void)PushToViewControllerFromNotificationClickAppDelegate:(NSDictionary *)userInfo previousState:(NSString *)previousState notificationID:(NSString *)notificationID {
    
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UIViewController *notificationClickViewController = [[UIViewController alloc] init];
    notificationClickViewController.restorationIdentifier = @"NotificationClick";
    
    NSString *delegateType = @"App";
    
    if (userInfo[@"Home"]) {
        
        
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:notificationClickViewController touchEvent:[NSString stringWithFormat:@"%@ Delegate - %@ - %@ - %@", delegateType, previousState, @"Home", notificationID] completionHandler:^(BOOL finished) {
            
        }];
        
        
        
        HomeMembersViewController *homeMembersViewControllerObject = [storyBoard instantiateViewControllerWithIdentifier:@"HomeMembersViewController"];
        TasksViewController *TasksViewControllerObject = [storyBoard instantiateViewControllerWithIdentifier:@"TasksViewController"];
        
        
        
        
        BOOL viewingHomeMembersFromHomesViewController = [userInfo[@"viewingHomeMembersFromHomesViewController"] isEqualToString:@"Yes"] ? YES : NO;
        
        id homeID = userInfo[@"HomeID"] ? userInfo[@"HomeID"] : @"xxx";
        id homeName = userInfo[@"HomeName"] ? userInfo[@"HomeName"] : @"";
        
        id notificationSettingsDict = userInfo[@"NotificationSettingsDict"] && [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"NotificationSettingsDict"]] ? [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"NotificationSettingsDict"]] : [NSMutableDictionary dictionary];
        id topicDict = userInfo[@"TopicDict"] && [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"TopicDict"]] ? [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"TopicDict"]] : [NSMutableDictionary dictionary];
        
        
        
        
        homeMembersViewControllerObject.viewingHomeMembersFromHomesViewController = viewingHomeMembersFromHomesViewController;
        
        homeMembersViewControllerObject.homeID = homeID;
        homeMembersViewControllerObject.homeName = homeName;
        
        homeMembersViewControllerObject.notificationSettingsDict = notificationSettingsDict;
        
        
        
        UINavigationController *navVC = (UINavigationController *)del.window.rootViewController;
        [navVC pushViewController:TasksViewControllerObject animated:YES];
        [navVC pushViewController:homeMembersViewControllerObject animated:YES];
        
        
        
        [[[PushObject alloc] init] PushToHomeMembersViewController:homeID homeName:homeName notificationSettingsDict:notificationSettingsDict topicDict:topicDict viewingHomeMembersFromHomesViewController:viewingHomeMembersFromHomesViewController currentViewController:[[UIViewController alloc] init] Superficial:YES];
        
        
        
    } else if (userInfo[@"GroupChat"]) {
        
        
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:notificationClickViewController touchEvent:[NSString stringWithFormat:@"%@ Delegate - %@ - %@ - %@", delegateType, previousState, @"GroupChat", notificationID] completionHandler:^(BOOL finished) {
            
        }];
        
        
        
        LiveChatNavigationController *liveChatViewControllerObject = [storyBoard instantiateViewControllerWithIdentifier:@"LiveChatNavigationController"];
        ChatsViewController *chatsViewControllerObject = [storyBoard instantiateViewControllerWithIdentifier:@"ChatsViewController"];
        
        
        
        BOOL viewingGroupChat = userInfo[@"ViewingGroupChat"] && [userInfo[@"ViewingGroupChat"] isEqualToString:@"Yes"] ? YES : NO;
        
        id userID = userInfo[@"UserID"] ? userInfo[@"UserID"] : @"";
        id homeID = userInfo[@"HomeID"] ? userInfo[@"HomeID"] : @"xxx";
        id chatID = userInfo[@"ChatID"] ? userInfo[@"ChatID"] : @"";
        id chatName = userInfo[@"ChatName"] ? userInfo[@"ChatName"] : @"";
        
        id chatAssignedTo = userInfo[@"ChatAssignedTo"] && [[[GeneralObject alloc] init] GenerateArrayID:userInfo[@"ChatAssignedTo"]] ? [[[GeneralObject alloc] init] GenerateArrayID:userInfo[@"ChatAssignedTo"]] : [NSMutableArray array];
        
        id homeMembersDict = userInfo[@"HomeMembersDict"] && [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"HomeMembersDict"]] ? [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"HomeMembersDict"]] : [NSMutableDictionary dictionary];
        id notificationSettingsDict = userInfo[@"NotificationSettingsDict"] && [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"NotificationSettingsDict"]] ? [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"NotificationSettingsDict"]] : [NSMutableDictionary dictionary];
        id topicDict = userInfo[@"TopicDict"] && [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"TopicDict"]] ? [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"TopicDict"]] : [NSMutableDictionary dictionary];
        
        
        
        UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"LiveChatNavigationController" source:del.window.rootViewController destination:liveChatViewControllerObject];
        
        [liveChatViewControllerObject prepareForSegue:segue sender:
         
         @{@"userID" : userID ? userID : @"",
           @"homeID" : homeID ? homeID : @"",
           @"chatID" : chatID ? chatID : @"",
           @"chatName" : chatName ? chatName : @"",
           
           @"homeMembersDict" : homeMembersDict ? homeMembersDict : [NSMutableDictionary dictionary],
           @"notificationSettingsDict" : notificationSettingsDict ? notificationSettingsDict : [NSMutableDictionary dictionary],
           @"topicDict" : topicDict ? topicDict : [NSMutableDictionary dictionary],
           
           @"chatAssignedTo" : chatAssignedTo ? chatAssignedTo : [NSMutableArray array],
           
           @"viewingGroupChat" : viewingGroupChat ? @"Yes" : @"No"
         }];
        
        
        
        [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"ViewingExpenses"];
        [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"ViewingLists"];
        [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"ViewingChats"];
        
        
        
        UINavigationController *navVC = (UINavigationController *)del.window.rootViewController;
        [navVC pushViewController:chatsViewControllerObject animated:YES];
        
        liveChatViewControllerObject.modalInPresentation = true;
        liveChatViewControllerObject.modalPresentationStyle = UIModalPresentationPopover;
        [navVC presentViewController:liveChatViewControllerObject animated:YES completion:nil];
        
        
        
        [[[PushObject alloc] init] PushToLiveChatViewControllerFromGroupChatsTab:userID homeID:homeID chatID:chatID chatName:chatName chatAssignedTo:chatAssignedTo homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict topicDict:topicDict currentViewController:[[UIViewController alloc] init] Superficial:YES];
        
        
        
    } else if (userInfo[@"Comment"]) {
        
        
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:notificationClickViewController touchEvent:[NSString stringWithFormat:@"%@ Delegate - %@ - %@ - %@", delegateType, previousState, @"Comment", notificationID] completionHandler:^(BOOL finished) {
            
        }];
        
        
        
        LiveChatNavigationController *liveChatViewControllerObject = [storyBoard instantiateViewControllerWithIdentifier:@"LiveChatNavigationController"];
        
        
        
        BOOL viewingComments = userInfo[@"ViewingComments"] && [userInfo[@"ViewingComments"] isEqualToString:@"Yes"] ? YES : NO;
        
        id homeID = userInfo[@"HomeID"] ? userInfo[@"HomeID"] : @"xxx";
        
        id itemType = userInfo[@"ItemType"] ? userInfo[@"ItemType"] : @"";
        id itemID = userInfo[@"ItemID"] ? userInfo[@"ItemID"] : @"";
        id itemName = userInfo[@"ItemName"] ? userInfo[@"ItemName"] : @"";
        id itemCreatedBy = userInfo[@"ItemCreatedBy"] ? userInfo[@"ItemCreatedBy"] : @"";
        
        id itemAssignedTo = userInfo[@"ItemAssignedTo"] && [[[GeneralObject alloc] init] GenerateArrayID:userInfo[@"ItemAssignedTo"]] ? [[[GeneralObject alloc] init] GenerateArrayID:userInfo[@"ItemAssignedTo"]] : [NSMutableArray array];
        
        id homeMembersDict = userInfo[@"HomeMembersDict"] && [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"HomeMembersDict"]] ? [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"HomeMembersDict"]] : [NSMutableDictionary dictionary];
        id notificationSettingsDict = userInfo[@"NotificationSettingsDict"] && [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"NotificationSettingsDict"]] ? [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"NotificationSettingsDict"]] : [NSMutableDictionary dictionary];
        id topicDict = userInfo[@"TopicDict"] && [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"TopicDict"]] ? [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"TopicDict"]] : [NSMutableDictionary dictionary];
        
        
        
        if ([itemAssignedTo containsObject:itemCreatedBy] == NO) {
            
            [itemAssignedTo addObject:itemCreatedBy];
            
        }
        
        
        
        UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"LiveChatNavigationController" source:del.window.rootViewController destination:liveChatViewControllerObject];
        
        [liveChatViewControllerObject prepareForSegue:segue sender:
         
         @{@"homeID" : homeID ? homeID : @"",
           
           @"itemID" : itemID ? itemID : @"",
           @"itemName" : itemName ? itemName : @"",
           @"itemCreatedBy" : itemCreatedBy ? itemCreatedBy : @"",
           
           @"homeMembersDict" : homeMembersDict ? homeMembersDict : [NSMutableDictionary dictionary],
           @"notificationSettingsDict" : notificationSettingsDict ? notificationSettingsDict : [NSMutableDictionary dictionary],
           @"topicDict" : topicDict ? topicDict : [NSMutableDictionary dictionary],
           
           @"itemAssignedTo" : itemAssignedTo ? itemAssignedTo : [NSMutableArray array],
           
           @"viewingComments" : viewingComments ? @"Yes" : @"No"
         }];
        
        
        
        [[NSUserDefaults standardUserDefaults] setObject:[itemType isEqualToString:@"Expense"] ? @"Yes" : @"No" forKey:@"ViewingExpenses"];
        [[NSUserDefaults standardUserDefaults] setObject:[itemType isEqualToString:@"List"] ? @"Yes" : @"No" forKey:@"ViewingLists"];
        [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"ViewingChats"];
        
        
        
        UINavigationController *navVC = (UINavigationController *)del.window.rootViewController;
        
        
        
        TasksViewController *TasksViewControllerObject = [storyBoard instantiateViewControllerWithIdentifier:@"TasksViewController"];
        
        [navVC pushViewController:TasksViewControllerObject animated:YES];
        
        
        
        liveChatViewControllerObject.modalInPresentation = true;
        liveChatViewControllerObject.modalPresentationStyle = UIModalPresentationPopover;
        [navVC presentViewController:liveChatViewControllerObject animated:YES completion:nil];
        
        
        
        [[[PushObject alloc] init] PushToLiveChatViewControllerFromViewTaskPage:homeID itemID:itemID itemName:itemName itemCreatedBy:itemCreatedBy itemAssignedTo:itemAssignedTo homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict topicDict:topicDict currentViewController:[[UIViewController alloc] init] Superficial:YES];
        
        
        
    } else if (userInfo[@"Live Support"]) {
        
        
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:notificationClickViewController touchEvent:[NSString stringWithFormat:@"%@ Delegate - %@ - %@ - %@", delegateType, previousState, @"Live Support", notificationID] completionHandler:^(BOOL finished) {
            
        }];
        
        
        
        LiveChatNavigationController *liveChatViewControllerObject = [storyBoard instantiateViewControllerWithIdentifier:@"LiveChatNavigationController"];
        TasksViewController *TasksViewControllerObject = [storyBoard instantiateViewControllerWithIdentifier:@"TasksViewController"];
        
        
        
        BOOL viewingLiveSupport = userInfo[@"ViewngLiveSupport"] && [userInfo[@"ViewngLiveSupport"] isEqualToString:@"Yes"] ? YES : NO;
        
        id userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
        
        
        
        UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"LiveChatNavigationController" source:del.window.rootViewController destination:liveChatViewControllerObject];
        
        [liveChatViewControllerObject prepareForSegue:segue sender:
         
         @{@"userID" : userID ? userID : @"",
           
           @"viewingLiveSupport" : @"Yes"
         }];
        
        
        
        UINavigationController *navVC = (UINavigationController *)del.window.rootViewController;
        [navVC pushViewController:TasksViewControllerObject animated:YES];
        
        liveChatViewControllerObject.modalInPresentation = true;
        liveChatViewControllerObject.modalPresentationStyle = UIModalPresentationPopover;
        [navVC presentViewController:liveChatViewControllerObject animated:YES completion:nil];
        
        
        
        [[[PushObject alloc] init] PushToLiveChatViewControllerFromSettingsPage:userID viewingLiveSupport:viewingLiveSupport currentViewController:[[UIViewController alloc] init] Superficial:YES];
        
        
        
    } else if (userInfo[@"Forum"]) {
        
        
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:notificationClickViewController touchEvent:[NSString stringWithFormat:@"%@ Delegate - %@ - %@ - %@", delegateType, previousState, @"Forum", notificationID] completionHandler:^(BOOL finished) {
            
        }];
        
        
        
        AddForumViewController *addForumViewControllerObject = [storyBoard instantiateViewControllerWithIdentifier:@"AddForumViewController"];
        ForumViewController *forumViewControllerObject = [storyBoard instantiateViewControllerWithIdentifier:@"ForumViewController"];
        SettingsViewController *settingsViewControllerObject = [storyBoard instantiateViewControllerWithIdentifier:@"SettingsViewController"];
        
        
        
        BOOL viewingFeatureForum = userInfo[@"FeatureForum"] && [userInfo[@"FeatureForum"] isEqualToString:@"Yes"] ? YES : NO;
        BOOL editingSpecificForumPost = NO;
        BOOL viewingSpecificForumPost = YES;
        
        id forumDict = userInfo[@"ForumDict"] && [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"ForumDict"]] ? [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"ForumDict"]] : [NSMutableDictionary dictionary];
        
        
        
        addForumViewControllerObject.viewingFeatureForum = viewingFeatureForum;
        addForumViewControllerObject.editingSpecificForumPost = editingSpecificForumPost;
        addForumViewControllerObject.viewingSpecificForumPost = viewingSpecificForumPost;
        
        addForumViewControllerObject.itemToEditDict = forumDict;
        
        forumViewControllerObject.viewingFeatureForum = viewingFeatureForum;
        
        
        
        UINavigationController *navVC = (UINavigationController *)del.window.rootViewController;
        [navVC pushViewController:settingsViewControllerObject animated:YES];
        [navVC pushViewController:forumViewControllerObject animated:YES];
        
        
        
        [[[PushObject alloc] init] PushToAddForumViewController:nil viewingFeatureForum:viewingFeatureForum editingSpecificForumPost:editingSpecificForumPost viewingSpecificForumPost:viewingSpecificForumPost currentViewController:[[UIViewController alloc] init] Superficial:NO];
        
        
        
    } else if (userInfo[@"WeDivvyPremium"]) {
        
        
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:notificationClickViewController touchEvent:[NSString stringWithFormat:@"%@ Delegate - %@ - %@ - %@", delegateType, previousState, @"WeDivvyPremium", notificationID] completionHandler:^(BOOL finished) {
            
        }];
        
        
        
        WeDivvyPremiumNavigationController *weDivvyPremiumViewControllerObject = [storyBoard instantiateViewControllerWithIdentifier:@"WeDivvyPremiumNavigationController"];
        TasksViewController *TasksViewControllerObject = [storyBoard instantiateViewControllerWithIdentifier:@"TasksViewController"];
        
        
        
        UINavigationController *navVC = (UINavigationController *)del.window.rootViewController;
        [navVC pushViewController:TasksViewControllerObject animated:YES];
        
        weDivvyPremiumViewControllerObject.modalInPresentation = true;
        weDivvyPremiumViewControllerObject.modalPresentationStyle = UIModalPresentationPopover;
        [navVC presentViewController:weDivvyPremiumViewControllerObject animated:YES completion:nil];
        
        
        
        [[[PushObject alloc] init] PushToWeDivvyPremiumViewController:NO comingFromSignUp:NO defaultPlan:@"" displayDiscount:@"Half-Off Yearly Discount No Sale Sticker" selectedSlide:@"" promoCodeID:@"" premiumPlanProductsArray:[NSMutableArray array] premiumPlanPricesDict:[NSMutableDictionary dictionary] premiumPlanExpensivePricesDict:[NSMutableDictionary dictionary] premiumPlanPricesDiscountDict:[NSMutableDictionary dictionary] premiumPlanPricesNoFreeTrialDict:[NSMutableDictionary dictionary] currentViewController:[[UIViewController alloc] init] Superficial:YES];
        
        
        
    } else if (userInfo[@"PurchasePremium"] || userInfo[@"UpgradePremium"]) {
        
        
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:notificationClickViewController touchEvent:[NSString stringWithFormat:@"%@ Delegate - %@ - %@ - %@", delegateType, previousState, @"PurchasePremium", notificationID] completionHandler:^(BOOL finished) {
            
        }];
        
        
        
        WeDivvyPremiumNavigationController *weDivvyPremiumViewControllerObject = [storyBoard instantiateViewControllerWithIdentifier:@"WeDivvyPremiumNavigationController"];
        TasksViewController *TasksViewControllerObject = [storyBoard instantiateViewControllerWithIdentifier:@"TasksViewController"];
        
        
        
        id defaultPlan = userInfo[@"DefaultPlan"] ? userInfo[@"DefaultPlan"] : @"";
        
        
        
        UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"WeDivvyPremiumNavigationController" source:del.window.rootViewController destination:weDivvyPremiumViewControllerObject];
        
        [weDivvyPremiumViewControllerObject prepareForSegue:segue sender:
         
         @{@"defaultPlan" : defaultPlan ? defaultPlan : @""
           
         }];
        
        
        
        UINavigationController *navVC = (UINavigationController *)del.window.rootViewController;
        [navVC pushViewController:TasksViewControllerObject animated:YES];
        
        weDivvyPremiumViewControllerObject.modalInPresentation = true;
        weDivvyPremiumViewControllerObject.modalPresentationStyle = UIModalPresentationPopover;
        [navVC presentViewController:weDivvyPremiumViewControllerObject animated:YES completion:nil];
        
        
        
        [[[PushObject alloc] init] PushToWeDivvyPremiumViewController:NO comingFromSignUp:NO defaultPlan:@"" displayDiscount:@"Half-Off Yearly Discount No Sale Sticker" selectedSlide:@"" promoCodeID:@"" premiumPlanProductsArray:[NSMutableArray array] premiumPlanPricesDict:[NSMutableDictionary dictionary] premiumPlanExpensivePricesDict:[NSMutableDictionary dictionary] premiumPlanPricesDiscountDict:[NSMutableDictionary dictionary] premiumPlanPricesNoFreeTrialDict:[NSMutableDictionary dictionary] currentViewController:[[UIViewController alloc] init] Superficial:YES];
        
        
        
    } else if (userInfo[@"Item"]) {
        
        
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:notificationClickViewController touchEvent:[NSString stringWithFormat:@"%@ Delegate - %@ - %@ - %@", delegateType, previousState, @"Item", notificationID] completionHandler:^(BOOL finished) {
            
        }];
        
        
        
        BOOL TaskNeedsToBeResetFirst = NO;
        
        if (userInfo[@"NotificationFrequency"]) {
            
            if ([userInfo[@"NotificationFrequency"] isEqualToString:@"Now"]) {
                
                TaskNeedsToBeResetFirst = YES;
                
            }
            
        }
        
        
        
        if (TaskNeedsToBeResetFirst == NO) {
            
            
            
            ViewTaskNavigationController *viewTaskViewControllerObject = [storyBoard instantiateViewControllerWithIdentifier:@"ViewTaskNavigationController"];
            
            
            
            id itemType =                           userInfo[@"ItemType"] ? userInfo[@"ItemType"] : @"";
            
            BOOL viewingOccurrence =                userInfo[@"ItemOccurrenceID"] && [userInfo[@"ItemOccurrenceID"] length] == 0 ? NO : YES;
            BOOL viewingViewExpenseViewController = [itemType isEqualToString:@"Expense"] ? YES : NO;
            BOOL viewingViewListViewController =    [itemType isEqualToString:@"List"] ? YES : NO;
            
            id homeMembersArray =         userInfo[@"HomeMembersArray"] &&         [[[GeneralObject alloc] init] GenerateArrayID:userInfo[@"HomeMembersArray"]] ?              [[[GeneralObject alloc] init] GenerateArrayID:userInfo[@"HomeMembersArray"]]              : [NSMutableArray array];
            id itemNamesAlreadyUsed =     userInfo[@"ItemNamesAlreadyUsed"] &&     [[[GeneralObject alloc] init] GenerateArrayID:userInfo[@"ItemNamesAlreadyUsed"]] ?          [[[GeneralObject alloc] init] GenerateArrayID:userInfo[@"ItemNamesAlreadyUsed"]]          : [NSMutableArray array];
            id allItemTagsArrays =        userInfo[@"AllItemTagsArrays"] &&        [[[GeneralObject alloc] init] GenerateArrayID:userInfo[@"AllItemTagsArrays"]] ?             [[[GeneralObject alloc] init] GenerateArrayID:userInfo[@"AllItemTagsArrays"]]             : [NSMutableArray array];
            id allItemAssignedToArrays =  userInfo[@"AllItemAssignedToArrays"] &&  [[[GeneralObject alloc] init] GenerateArrayID:userInfo[@"AllItemAssignedToArrays"]] ?       [[[GeneralObject alloc] init] GenerateArrayID:userInfo[@"AllItemAssignedToArrays"]]       : [NSMutableArray array];
            
            id topicDict = userInfo[@"TopicDict"] && [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"TopicDict"]] ? [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"TopicDict"]] : [NSMutableDictionary dictionary];
            
            id itemID =           userInfo[@"ItemID"] ? userInfo[@"ItemID"] : @"";
            id itemOccurrenceID = userInfo[@"ItemOccurrenceID"] ? userInfo[@"ItemOccurrenceID"] : @"";
            
            
            
            UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"ViewTaskNavigationController" source:del.window.rootViewController destination:viewTaskViewControllerObject];
            
            [viewTaskViewControllerObject prepareForSegue:segue sender:
             
             @{@"itemID" : itemID ? itemID : @"",
               @"itemOccurrenceID" : itemOccurrenceID ? itemOccurrenceID : @"",
               
               @"homeMembersArray" : homeMembersArray ? homeMembersArray : [NSMutableArray array],
               
               @"itemNamesAlreadyUsed" : itemNamesAlreadyUsed ? itemNamesAlreadyUsed : [NSMutableArray array],
               @"allItemAssignedToArrays" : allItemAssignedToArrays ? allItemAssignedToArrays : [NSMutableArray array],
               @"allItemTagsArrays" : allItemTagsArrays ? allItemTagsArrays : [NSMutableArray array],
               
               @"topicDict" : topicDict ? topicDict : [NSMutableDictionary dictionary],
               
               @"viewingOccurrence" : viewingOccurrence ? @"Yes" : @"No",
               @"viewingViewExpenseViewController" : viewingViewExpenseViewController ? @"Yes" : @"No",
               @"viewingViewListViewController" : viewingViewListViewController ? @"Yes" : @"No"
               
             }];
            
            
            
            [[NSUserDefaults standardUserDefaults] setObject:[itemType isEqualToString:@"Expense"] ? @"Yes" : @"No" forKey:@"ViewingExpenses"];
            [[NSUserDefaults standardUserDefaults] setObject:[itemType isEqualToString:@"List"] ? @"Yes" : @"No" forKey:@"ViewingLists"];
            [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"ViewingChats"];
            
            
            
            UINavigationController *navVC = (UINavigationController *)del.window.rootViewController;
            
            
            
            TasksViewController *TasksViewControllerObject = [storyBoard instantiateViewControllerWithIdentifier:@"TasksViewController"];
            
            [navVC pushViewController:TasksViewControllerObject animated:YES];
            
            
            
            viewTaskViewControllerObject.modalInPresentation = true;
            viewTaskViewControllerObject.modalPresentationStyle = UIModalPresentationPopover;
            [navVC presentViewController:viewTaskViewControllerObject animated:YES completion:nil];
            
            
            
            [[[PushObject alloc] init] PushToViewTaskViewController:itemID itemOccurrenceID:itemOccurrenceID itemDictFromPreviousPage:[NSMutableDictionary dictionary] homeMembersArray:homeMembersArray homeMembersDict:[NSMutableDictionary dictionary] itemOccurrencesDict:[NSMutableDictionary dictionary] folderDict:[NSMutableDictionary dictionary] taskListDict:[NSMutableDictionary dictionary] templateDict:[NSMutableDictionary dictionary] draftDict:[NSMutableDictionary dictionary] notificationSettingsDict:[NSMutableDictionary dictionary] topicDict:topicDict itemNamesAlreadyUsed:[NSMutableArray array] allItemAssignedToArrays:[NSMutableArray array] allItemTagsArrays:[NSMutableArray array] allItemIDsArrays:[NSMutableArray array] currentViewController:[[UIViewController alloc] init] Superficial:YES];
            
            
            
        }
        
    }
    
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Internal Methods
#pragma mark
#pragma mark
#pragma mark -

#pragma mark SetUpRootViewControllers Methods

-(void)GenerateDefaultViewController {
    
    NSString *defaultViewController = [[NSUserDefaults standardUserDefaults] objectForKey:@"DefaultViewController"];
    
    if ([defaultViewController isEqualToString:@"Chores"]) {
        
        [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"ViewingExpenses"];
        [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"ViewingLists"];
        [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"ViewingChats"];
        
    } else if ([defaultViewController isEqualToString:@"Expenses"]) {
        
        [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"ViewingExpenses"];
        [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"ViewingLists"];
        [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"ViewingChats"];
        
    } else if ([defaultViewController isEqualToString:@"Lists"]) {
        
        [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"ViewingExpenses"];
        [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"ViewingLists"];
        [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"ViewingChats"];
        
    } else if ([defaultViewController isEqualToString:@"Chats"]) {
        
        [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"ViewingExpenses"];
        [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"ViewingLists"];
        [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"ViewingChats"];
        
    }
    
}

#pragma mark - application:didReceiveRemoteNotification Methods

-(NSDictionary *)GenerateDataMergedUserInfo:(NSDictionary *)userInfo {
    
    BOOL UserInfoHasBeenSplitUp = NO;
    BOOL UserInfoHasBeenFullyMerged = NO;
    
    id fragments = userInfo[@"Fragments"] ? userInfo[@"Fragments"] : @"";
    
    if ([fragments length] > 0) {
        
        
        
        
        //Get FragmentID and Fragment Amount
        
        NSArray *fragmentIDArray = [fragments componentsSeparatedByString:@" - "];
        NSString *fragmentID = [fragmentIDArray count] > 0 ? fragmentIDArray[0] : @"";
        
        NSArray *fragmentsAmountArray = [fragments componentsSeparatedByString:@"/"];
        NSString *totalFragmentsAmount = [fragmentsAmountArray count] > 1 ? fragmentsAmountArray[1] : @"1";
        
        
        
        
        //Check If User Info Has Been Fragmented
        
        UserInfoHasBeenSplitUp = [totalFragmentsAmount intValue] > 1;
        
        if (UserInfoHasBeenSplitUp) {
            
            
            
            
            //Add Found Fragment of User Info
            
            NSMutableArray *arrayOfFragmentDicts =
            [[NSUserDefaults standardUserDefaults] objectForKey:fragmentID] ?
            [[[NSUserDefaults standardUserDefaults] objectForKey:fragmentID] mutableCopy] : [NSMutableArray array];
            
            id userInfoFragmentDict = userInfo[@"DictToUse"] && [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"DictToUse"]] ? [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"DictToUse"]] : [NSMutableDictionary dictionary];
            
            [arrayOfFragmentDicts addObject:userInfoFragmentDict];
            
            [[NSUserDefaults standardUserDefaults] setObject:arrayOfFragmentDicts forKey:fragmentID];
            
            
            
            
            //Check If All User Info Fragments Found
            
            BOOL AllUserInfoFragmentsHaveBeenFound = [arrayOfFragmentDicts count] == [totalFragmentsAmount intValue];
            
            if (AllUserInfoFragmentsHaveBeenFound == YES) {
                
                //If All User Info Fragments Found, Delete From NSUserDefaults
                //If All User Info Fragments Found, Merge Fragments Info Single Dict
                
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:fragmentID];
                
                NSMutableDictionary *mergedFragmentDict = [NSMutableDictionary dictionary];
                NSMutableDictionary *firstFragmentDict = [arrayOfFragmentDicts count] > 0 ? [arrayOfFragmentDicts[0] mutableCopy] : [NSMutableDictionary dictionary];
                NSMutableDictionary *secondFragmentDict = [arrayOfFragmentDicts count] > 1 ? [arrayOfFragmentDicts[1] mutableCopy] : [NSMutableDictionary dictionary];
                
                for (NSString *key in [firstFragmentDict allKeys]) {
                    [mergedFragmentDict setObject:firstFragmentDict[key] forKey:key];
                }
                for (NSString *key in [secondFragmentDict allKeys]) {
                    [mergedFragmentDict setObject:secondFragmentDict[key] forKey:key];
                }
                
                NSMutableDictionary *tempDict = [userInfo mutableCopy];
                [tempDict setObject:mergedFragmentDict forKey:@"DictToUse"];
                userInfo = [tempDict mutableCopy];
                
                UserInfoHasBeenFullyMerged = YES;
                
            }
            
        }
        
    }
    
    return @{@"userInfo" : userInfo,
             @"UserInfoHasBeenSplitUp" : UserInfoHasBeenSplitUp ? @"Yes" : @"No",
             @"UserInfoHasBeenFullyMerged" : UserInfoHasBeenFullyMerged ? @"Yes" : @"No"};
}

-(NSMutableDictionary *)GenerateItemTimeDict:(NSMutableDictionary *)dictToUse itemType:(NSString *)itemType {
    
    NSMutableDictionary *itemTimeDict = [@{@"Hour" : @"", @"Minute" : @"", @"AMPM" : @""} mutableCopy];
    
    BOOL TaskIsRepeating = [[[BoolDataObject alloc] init] TaskIsRepeating:[dictToUse mutableCopy] itemType:itemType];
    
    if (TaskIsRepeating == YES) {
        
        NSString *itemTime = dictToUse[@"ItemTime"] ? dictToUse[@"ItemTime"] : @"11:59 PM";
        
        
        
        
        NSDictionary *timeDict = [[[GeneralObject alloc] init] GenerateItemTime12HourDict:itemTime];
        
        NSString *AMPMComp = timeDict[@"AMPM"];
        NSString *hourComp = timeDict[@"Hour"];
        NSString *minuteComp = timeDict[@"Minute"];
        
        
        
        
        itemTimeDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:hourComp, @"Hour", minuteComp, @"Minute", AMPMComp, @"AMPM", nil];
        
        
        
        
        BOOL TaskHasAnyTime = [[[BoolDataObject alloc] init] TaskHasAnyTime:[dictToUse mutableCopy] itemType:itemType];
        
        if (TaskHasAnyTime == YES) {
            itemTimeDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"11", @"Hour", @"59", @"Minute", @"PM", @"AMPM", nil];
            itemTime = @"11:59 PM";
        }
        
        
        
        
        BOOL TaskHasAnyDay = [[[BoolDataObject alloc] init] TaskHasAnyDay:[dictToUse mutableCopy] itemType:itemType];
        
        if (TaskHasAnyDay == YES) {
            itemTimeDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"11", @"Hour", @"59", @"Minute", @"PM", @"AMPM", nil];
            itemTime = @"11:59 PM";
        }
        
        
        
        
    }
    
    return itemTimeDict;
}

-(NSMutableArray *)GenerateItemAssignedToUsername:(NSMutableArray *)itemAssignedTo homeMembersDict:(NSMutableDictionary *)homeMembersDict {
    
    NSMutableArray *itemAssignedToUsername = [NSMutableArray array];
    
    if (itemAssignedTo && homeMembersDict[@"UserID"]) {
        
        for (NSString *userID in itemAssignedTo) {
            
            NSUInteger index = [homeMembersDict[@"UserID"] containsObject:userID] ? [homeMembersDict[@"UserID"] indexOfObject:userID] : -1;
            NSString *username = homeMembersDict[@"Username"] && [(NSArray *)homeMembersDict[@"Username"] count] > index && index != -1 ? homeMembersDict[@"Username"][index] : @"";
            
            [itemAssignedToUsername addObject:username];
            
        }
        
    }
    
    return itemAssignedToUsername;
}

- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error {
    
}

#pragma mark - userNotificationCenter:didReceiveNotificationResponse Methods

-(NSString *)GeneratePreviousState {
    
    NSString *previousState = @"";
    
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateInactive) {
        
        //Puts In Foreground
        previousState = @"Closed(1)";
        
    } else if([UIApplication sharedApplication].applicationState==UIApplicationStateActive){
        
        //App Already Openned
        previousState = @"Openned";
        
    } else if([UIApplication sharedApplication].applicationState==UIApplicationStateBackground){
        
        //Opens App
        previousState = @"Closed(2)";
        
    } else {
        
        previousState = @"Unknown";
        
    }
    
    return previousState;
}

-(void)NotificationCenterNotificationActions:(UNNotificationResponse *)response previousState:(NSString *)previousState {
    
    if ([response.actionIdentifier isEqualToString:@"Mark Completed"]) {
        
        [self NotificationActionMarkedCompleted:response previousState:previousState];
        
    } else if ([response.actionIdentifier isEqualToString:@"Mark In Progress"]) {
        
        [self NotificationActionMarkedInProgress:response previousState:previousState];
        
    } else if ([response.actionIdentifier isEqualToString:@"Mark Won't Do"]) {
        
        [self NotificationActionMarkedWontDo:response previousState:previousState];
        
//    } else if ([response.actionIdentifier isEqualToString:@"Reschedule"]) {
//
//        [self NotificationActionReschedule:response previousState:previousState];
        
    } else if ([response.actionIdentifier isEqualToString:@"Turn Off"]) {
        
        [self NotificationActionTurnOff:response previousState:previousState];
        
    }
    
}

-(void)NotificationCenterPushToViewController:(UNNotificationResponse *)response previousState:(NSString *)previousState notificationID:(NSString *)notificationID {
    
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    
    NSLog(@"didReceiveNotificationResponse userInfo:%@", userInfo);
    
    if (userInfo[@"Home"] ||
        userInfo[@"GroupChat"] ||
        userInfo[@"Comment"] ||
        userInfo[@"Live Support"] ||
        userInfo[@"Forum"] ||
        userInfo[@"WeDivvyPremium"] ||
        userInfo[@"PurchasePremium"] ||
        userInfo[@"UpgradePremium"] ||
        userInfo[@"Item"]) {
        
        NSString *sysVer = [[UIDevice currentDevice] systemVersion];
        [[NSUserDefaults standardUserDefaults] setObject:sysVer forKey:@"systemVersion"];
        float sysVerFloat = [[[NSUserDefaults standardUserDefaults] objectForKey:@"systemVersion"] floatValue];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"ComingFromShortcut"];
        [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"ViewDidLoadShouldStart"];
        [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"ViewDidLoadShouldStartNo1"];
        
        if (sysVerFloat < 13.00) {
            
            [self PushToViewControllerFromNotificationClickAppDelegate:userInfo previousState:previousState notificationID:notificationID];
            
        } else {
            
            [self PushToViewControllerFromNotificationClickSceneDelegate:userInfo previousState:previousState notificationID:notificationID];
            
        }
        
    }
    
}

-(void)NotificationCenterSetDataNotificationOpen:(UNNotificationResponse *)response previousState:(NSString *)previousState notificationID:(NSString *)notificationID withCompletionHandler:(void(^)(void))completionHandler {
    
    BOOL isSimulator;
    
#if TARGET_OS_SIMULATOR
    isSimulator = YES;
#else
    isSimulator = NO;
#endif
    
    BOOL UserIsValid = [self UserisValid:isSimulator];
    
    if (UserIsValid == YES) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSLog(@"Noticication Response %@ -- %@", response.notification.date, response.notification.request.content.title);
            NSString *dateString = response.notification.date ? [NSString stringWithFormat:@"%@", response.notification.date] : @"";
            NSString *dateFormat = @"yyyy-MM-dd HH:mm:ss";
            NSString *appOpennedDate = [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:dateFormat returnAs:[NSString class]] ? [[[GeneralObject alloc] init] GenerateCurrentDateWithFormat:dateFormat returnAs:[NSString class]] : @"";
            NSString *notificationTitle = response.notification.request.content.title ? response.notification.request.content.title : @"";
            NSString *notificationBody = response.notification.request.content.body ? response.notification.request.content.body : @"";
            NSString *usersUserID = @"Unknown";
            
            if ([[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]) {
                usersUserID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
            }
            
            NSDictionary *dataDict = @{@"NotificationOpenPreviousState" : previousState, @"NotificationOpenID" : notificationID, @"NotificationOpenDate" : dateString, @"NotificationOpenTitle" : notificationTitle, @"NotificationOpenBody" : notificationBody, @"NotificationOpenAppOpenDate" : appOpennedDate, @"NotificationOpenUserID" : usersUserID, @"NotificationAppVersion" : @"6.5.98"};
            
            if ([[[GeneralObject alloc] init] ConnectedToInternet] == NO) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    completionHandler();
                    
                });
                
            } else {
                
                NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
                
                [[[SetDataObject alloc] init] SetDataNotificationOpen:userID dataDict:dataDict completionHandler:^(BOOL finished, NSError * _Nonnull error) {
                   
                    //Add Code
                    
                    completionHandler();
                    
                }];
                
            }
            
        });
        
    } else {
        
        completionHandler();
        
    }
    
}

#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"WeDivvyDataModel"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                     */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

- (NSManagedObjectContext *)managedObjectContext {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return [delegate persistentContainer].viewContext;
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Sub-Internal Methods
#pragma mark
#pragma mark
#pragma mark -

#pragma mark userNotificationCenter:didReceiveNotificationResponse Methods

-(void)NotificationActionMarkedCompleted:(UNNotificationResponse *)response previousState:(NSString *)previousState {
    
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    
    id itemType = userInfo[@"ItemType"] ? userInfo[@"ItemType"] : @"";
    
    id keyArray =                 userInfo[@"KeyArray"] &&                 [[[GeneralObject alloc] init] GenerateArrayID:userInfo[@"KeyArray"]] ?                      [[[GeneralObject alloc] init] GenerateArrayID:userInfo[@"KeyArray"]]                      : [NSMutableArray array];
    id homeMembersArray =         userInfo[@"HomeMembersArray"] &&         [[[GeneralObject alloc] init] GenerateArrayID:userInfo[@"HomeMembersArray"]] ?              [[[GeneralObject alloc] init] GenerateArrayID:userInfo[@"HomeMembersArray"]]              : [NSMutableArray array];
    id allItemTagsArrays =        userInfo[@"AllItemTagsArrays"] &&        [[[GeneralObject alloc] init] GenerateArrayID:userInfo[@"AllItemTagsArrays"]] ?             [[[GeneralObject alloc] init] GenerateArrayID:userInfo[@"AllItemTagsArrays"]]             : [NSMutableArray array];
    id allItemAssignedToArrays =  userInfo[@"AllItemAssignedToArrays"] &&  [[[GeneralObject alloc] init] GenerateArrayID:userInfo[@"AllItemAssignedToArrays"]] ?       [[[GeneralObject alloc] init] GenerateArrayID:userInfo[@"AllItemAssignedToArrays"]]       : [NSMutableArray array];
    
    id dictToUse =                userInfo[@"DictToUse"] &&                [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"DictToUse"]] ?                [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"DictToUse"]]                : [NSMutableDictionary dictionary];
    id homeMembersDict =          userInfo[@"HomeMembersDict"] &&          [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"HomeMembersDict"]] ?          [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"HomeMembersDict"]]          : [NSMutableDictionary dictionary];
    id notificationSettingsDict = userInfo[@"NotificationSettingsDict"] && [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"NotificationSettingsDict"]] ? [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"NotificationSettingsDict"]] : [NSMutableDictionary dictionary];
    id topicDict =                userInfo[@"TopicDict"] &&                [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"TopicDict"]] ?                [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"TopicDict"]]                : [NSMutableDictionary dictionary];
    id taskListDict =             userInfo[@"TaskListDict"] &&             [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"TaskListDict"]] ?             [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"TaskListDict"]]             : [NSMutableDictionary dictionary];
    
    NSString *itemID = dictToUse[@"ItemID"] ? dictToUse[@"ItemID"] : @"";
    NSMutableDictionary *itemCompletedDict = dictToUse[@"ItemCompletedDict"] ? dictToUse[@"ItemCompletedDict"] : [NSMutableDictionary dictionary];
    
    NSString *userWhoIsBeingMarkedUserID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
    
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
    BOOL TaskAlreadyCompleted = [[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemCompletedDict userIDToFind:userID];
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:[[UIViewController alloc] init] touchEvent:[NSString stringWithFormat:@"%@ Clicked %@ (%@) For %@", TaskAlreadyCompleted == YES ? @"Uncomplete" : @"Complete", itemID, previousState, itemType] completionHandler:^(BOOL finished) {
        
    }];
    
    NSString *notificationType = [[[NotificationsObject alloc] init] NotificationSettingsUnknownItemType_Adding:NO Editing:NO Deleting:NO Duplicating:NO Waiving:NO Skipping:NO Pausing:NO Comments:NO
                                                                                                   SkippingTurn:NO RemovingUser:NO
                                                                                                 FullyCompleted:NO Completed:YES InProgress:NO WontDo:NO Accept:NO Decline:NO
                                                                                                        DueDate:NO Reminder:NO
                                                                                                 SubtaskEditing:NO SubtaskDeleting:NO
                                                                                               SubtaskCompleted:NO SubtaskInProgress:NO SubtaskWontDo:NO SubtaskAccept:NO SubtaskDecline:NO
                                                                                                 AddingListItem:NO EditingListItem:NO DeletingListItem:NO ResetingListItem:NO
                                                                                            EditingItemizedItem:NO DeletingItemizedItem:NO
                                                                                              GroupChatMessages:NO LiveSupportMessages:NO
                                                                                             SendingInvitations:NO DeletingInvitations:NO NewHomeMembers:NO HomeMembersMovedOut:NO HomeMembersKickedOut:NO
                                                                                            FeatureForumUpvotes:NO BugForumUpvotes:NO
                                                                                                       itemType:itemType];
    
    NSString *notificationItemType = itemType;
    
    if ([[itemCompletedDict allKeys] containsObject:userID] == NO) {
        
        [[[CompleteUncompleteObject alloc] init] TaskCompleteUncomplete:dictToUse itemOccurrencesDict:[NSMutableDictionary dictionary] keyArray:keyArray homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType topicDict:topicDict taskListDict:taskListDict allItemAssignedToArrays:allItemAssignedToArrays allItemTagsArrays:allItemTagsArrays userWhoIsBeingMarkedUserID:userWhoIsBeingMarkedUserID markingForSomeoneElse:NO currentViewController:[[UIViewController alloc] init] completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningDictToUse, NSMutableDictionary * _Nonnull returningOccurrencesDictToUse, NSMutableDictionary * _Nonnull returningUpdatedTaskListDictToUse, BOOL TaskIsFullyCompleted) {
            
        }];
        
    }
    
}

-(void)NotificationActionMarkedInProgress:(UNNotificationResponse *)response previousState:(NSString *)previousState {
    
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    
    id itemType = userInfo[@"ItemType"] ? userInfo[@"ItemType"] : @"";
    
    id keyArray =                 userInfo[@"KeyArray"] &&                 [[[GeneralObject alloc] init] GenerateArrayID:userInfo[@"KeyArray"]] ?                      [[[GeneralObject alloc] init] GenerateArrayID:userInfo[@"KeyArray"]]                      : [NSMutableArray array];
    id homeMembersArray =         userInfo[@"HomeMembersArray"] &&         [[[GeneralObject alloc] init] GenerateArrayID:userInfo[@"HomeMembersArray"]] ?              [[[GeneralObject alloc] init] GenerateArrayID:userInfo[@"HomeMembersArray"]]              : [NSMutableArray array];
    id allItemTagsArrays =        userInfo[@"AllItemTagsArrays"] &&        [[[GeneralObject alloc] init] GenerateArrayID:userInfo[@"AllItemTagsArrays"]] ?             [[[GeneralObject alloc] init] GenerateArrayID:userInfo[@"AllItemTagsArrays"]]             : [NSMutableArray array];
    
    id dictToUse =                userInfo[@"DictToUse"] &&                [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"DictToUse"]] ?                [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"DictToUse"]]                : [NSMutableDictionary dictionary];
    id homeMembersDict =          userInfo[@"HomeMembersDict"] &&          [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"HomeMembersDict"]] ?          [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"HomeMembersDict"]]          : [NSMutableDictionary dictionary];
    id notificationSettingsDict = userInfo[@"NotificationSettingsDict"] && [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"NotificationSettingsDict"]] ? [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"NotificationSettingsDict"]] : [NSMutableDictionary dictionary];
    id topicDict =                userInfo[@"TopicDict"] &&                [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"TopicDict"]] ?                [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"TopicDict"]]                : [NSMutableDictionary dictionary];
    
    NSString *itemID = dictToUse[@"ItemID"] ? dictToUse[@"ItemID"] : @"";
    NSMutableDictionary *itemInProgressDict = dictToUse[@"ItemInProgressDict"] ? dictToUse[@"ItemInProgressDict"] : [NSMutableDictionary dictionary];
    
    NSString *userWhoIsBeingMarkedUserID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
    
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
    BOOL TaskAlreadyInProgress = [[[GeneralObject alloc] init] ItemCompletedOrItemInProgressDictContainsUserID:itemInProgressDict userIDToFind:userID];
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:[[UIViewController alloc] init] touchEvent:[NSString stringWithFormat:@"%@ Clicked %@ (%@) For %@", TaskAlreadyInProgress == YES ? @"Not In Progress" : @"In Progress", itemID, previousState, itemType] completionHandler:^(BOOL finished) {
        
    }];
    
    NSString *notificationType = [[[NotificationsObject alloc] init] NotificationSettingsUnknownItemType_Adding:NO Editing:NO Deleting:NO Duplicating:NO Waiving:NO Skipping:NO Pausing:NO Comments:NO
                                                                                                   SkippingTurn:NO RemovingUser:NO
                                                                                                 FullyCompleted:NO Completed:NO InProgress:YES WontDo:NO Accept:NO Decline:NO
                                                                                                        DueDate:NO Reminder:NO
                                                                                                 SubtaskEditing:NO SubtaskDeleting:NO
                                                                                               SubtaskCompleted:NO SubtaskInProgress:NO SubtaskWontDo:NO SubtaskAccept:NO SubtaskDecline:NO
                                                                                                 AddingListItem:NO EditingListItem:NO DeletingListItem:NO ResetingListItem:NO
                                                                                            EditingItemizedItem:NO DeletingItemizedItem:NO
                                                                                              GroupChatMessages:NO LiveSupportMessages:NO
                                                                                             SendingInvitations:NO DeletingInvitations:NO NewHomeMembers:NO HomeMembersMovedOut:NO HomeMembersKickedOut:NO
                                                                                            FeatureForumUpvotes:NO BugForumUpvotes:NO
                                                                                                       itemType:itemType];
    
    NSString *notificationItemType = itemType;
    
    if ([[itemInProgressDict allKeys] containsObject:userID] == NO) {
        
        [[[CompleteUncompleteObject alloc] init] TaskInProgressNotInProgress:dictToUse itemOccurrencesDict:[NSMutableDictionary dictionary] keyArray:keyArray homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType topicDict:topicDict allItemTagsArrays:allItemTagsArrays userWhoIsBeingMarkedUserID:userWhoIsBeingMarkedUserID markingForSomeoneElse:NO currentViewController:[[UIViewController alloc] init] completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningDictToUse, NSMutableDictionary * _Nonnull returningOccurrencesDictToUse) {
            
        }];
        
    }
    
}

-(void)NotificationActionMarkedWontDo:(UNNotificationResponse *)response previousState:(NSString *)previousState {
    
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    
    id itemType = userInfo[@"ItemType"] ? userInfo[@"ItemType"] : @"";
    
    id keyArray =                 userInfo[@"KeyArray"] &&                 [[[GeneralObject alloc] init] GenerateArrayID:userInfo[@"KeyArray"]] ?                      [[[GeneralObject alloc] init] GenerateArrayID:userInfo[@"KeyArray"]]                      : [NSMutableArray array];
    id homeMembersArray =         userInfo[@"HomeMembersArray"] &&         [[[GeneralObject alloc] init] GenerateArrayID:userInfo[@"HomeMembersArray"]] ?              [[[GeneralObject alloc] init] GenerateArrayID:userInfo[@"HomeMembersArray"]]              : [NSMutableArray array];
    id allItemTagsArrays =        userInfo[@"AllItemTagsArrays"] &&        [[[GeneralObject alloc] init] GenerateArrayID:userInfo[@"AllItemTagsArrays"]] ?             [[[GeneralObject alloc] init] GenerateArrayID:userInfo[@"AllItemTagsArrays"]]             : [NSMutableArray array];
    id allItemAssignedToArrays =  userInfo[@"AllItemAssignedToArrays"] &&  [[[GeneralObject alloc] init] GenerateArrayID:userInfo[@"AllItemAssignedToArrays"]] ?       [[[GeneralObject alloc] init] GenerateArrayID:userInfo[@"AllItemAssignedToArrays"]]       : [NSMutableArray array];
    
    id dictToUse =                userInfo[@"DictToUse"] &&                [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"DictToUse"]] ?                [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"DictToUse"]]                : [NSMutableDictionary dictionary];
    id homeMembersDict =          userInfo[@"HomeMembersDict"] &&          [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"HomeMembersDict"]] ?          [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"HomeMembersDict"]]          : [NSMutableDictionary dictionary];
    id notificationSettingsDict = userInfo[@"NotificationSettingsDict"] && [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"NotificationSettingsDict"]] ? [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"NotificationSettingsDict"]] : [NSMutableDictionary dictionary];
    id topicDict =                userInfo[@"TopicDict"] &&                [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"TopicDict"]] ?                [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"TopicDict"]]                : [NSMutableDictionary dictionary];
    id taskListDict =             userInfo[@"TaskListDict"] &&             [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"TaskListDict"]] ?             [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"TaskListDict"]]             : [NSMutableDictionary dictionary];
    
    NSMutableDictionary *itemWontDoDict = dictToUse[@"ItemWontDoDict"] ? dictToUse[@"ItemWontDoDict"] : [NSMutableDictionary dictionary];
    
    NSString *userWhoIsBeingMarkedUserID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
    
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
    
    NSString *wontDoString = @"Won't Do";
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:[[UIViewController alloc] init] touchEvent:[NSString stringWithFormat:@"%@ Clicked (%@) For %@", wontDoString, previousState, [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    NSString *notificationType = [[[NotificationsObject alloc] init] NotificationSettingsUnknownItemType_Adding:NO Editing:NO Deleting:NO Duplicating:NO Waiving:NO Skipping:NO Pausing:NO Comments:NO
                                                                                                   SkippingTurn:NO RemovingUser:NO
                                                                                                 FullyCompleted:NO Completed:NO InProgress:NO WontDo:YES Accept:NO Decline:NO
                                                                                                        DueDate:NO Reminder:NO
                                                                                                 SubtaskEditing:NO SubtaskDeleting:NO
                                                                                               SubtaskCompleted:NO SubtaskInProgress:NO SubtaskWontDo:NO SubtaskAccept:NO SubtaskDecline:NO
                                                                                                 AddingListItem:NO EditingListItem:NO DeletingListItem:NO ResetingListItem:NO
                                                                                            EditingItemizedItem:NO DeletingItemizedItem:NO
                                                                                              GroupChatMessages:NO LiveSupportMessages:NO
                                                                                             SendingInvitations:NO DeletingInvitations:NO NewHomeMembers:NO HomeMembersMovedOut:NO HomeMembersKickedOut:NO
                                                                                            FeatureForumUpvotes:NO BugForumUpvotes:NO
                                                                                                       itemType:itemType];
    
    NSString *notificationItemType = itemType;
    
    if ([[itemWontDoDict allKeys] containsObject:userID] == NO) {
        
        [[[CompleteUncompleteObject alloc] init] TaskWillDoWontDo:dictToUse itemOccurrencesDict:[NSMutableDictionary dictionary] keyArray:keyArray homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict notificationItemType:notificationItemType notificationType:notificationType topicDict:topicDict taskListDict:taskListDict allItemAssignedToArrays:allItemAssignedToArrays allItemTagsArrays:allItemTagsArrays userWhoIsBeingMarkedUserID:userWhoIsBeingMarkedUserID markingForSomeoneElse:NO currentViewController:[[UIViewController alloc] init] completionHandler:^(BOOL finished, NSMutableDictionary * _Nonnull returningDictToUse, NSMutableDictionary * _Nonnull returningOccurrencesDictToUse, NSMutableDictionary * _Nonnull returningUpdatedTaskListDictToUse, BOOL TaskIsFullyCompleted) {
            
        }];
        
    }
    
}

//-(void)NotificationActionReschedule:(UNNotificationResponse *)response previousState:(NSString *)previousState {
//
//    NSDictionary *userInfo = response.notification.request.content.userInfo;
//
//    NSString *sysVer = [[UIDevice currentDevice] systemVersion];
//    [[NSUserDefaults standardUserDefaults] setObject:sysVer forKey:@"systemVersion"];
//    float sysVerFloat = [[[NSUserDefaults standardUserDefaults] objectForKey:@"systemVersion"] floatValue];
//
//    [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"ComingFromShortcut"];
//
//    if (sysVerFloat < 13.00) {
//
//        AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
//        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//
//        UIViewController *notificationClickViewController = [[UIViewController alloc] init];
//        notificationClickViewController.restorationIdentifier = @"NotificationClick";
//
//        NSString *delegateType = @"App";
//
//
//
//        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:notificationClickViewController touchEvent:[NSString stringWithFormat:@"%@ Delegate - %@ - %@", delegateType, previousState, @"Notification Overview"] completionHandler:^(BOOL finished) {
//
//        }];
//
//
//
//        NotificationSettingsNavigationController *notificationSettingsViewControllerObjectNo1 = [storyBoard instantiateViewControllerWithIdentifier:@"NotificationSettingsNavigationController"];
//        NotificationSettingsNavigationController *notificationSettingsViewControllerObject = [storyBoard instantiateViewControllerWithIdentifier:@"NotificationSettingsNavigationController"];
//        SettingsViewController *settingsViewControllerObject = [storyBoard instantiateViewControllerWithIdentifier:@"SettingsViewController"];
//
//
//
//        id notificationSettings = userInfo[@"NotificationSettings"] && [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"NotificationSettings"]] ? [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"NotificationSettings"]] : [NSMutableDictionary dictionary];
//        id sideBarCategorySectionArrayAltered = userInfo[@"SideBarCategorySectionArrayAltered"] && [[[GeneralObject alloc] init] GenerateArrayID:userInfo[@"SideBarCategorySectionArrayAltered"]] ? [[[GeneralObject alloc] init] GenerateArrayID:userInfo[@"SideBarCategorySectionArrayAltered"]] : [NSMutableArray array];
//
//        NSMutableArray *userIDArray = [(NSArray *)sideBarCategorySectionArrayAltered count] > 1 && sideBarCategorySectionArrayAltered[1][@"IDs"] ? sideBarCategorySectionArrayAltered[1][@"IDs"] : [NSMutableArray array];
//        NSMutableArray *userNameArray = [(NSArray *)sideBarCategorySectionArrayAltered count] > 1 && sideBarCategorySectionArrayAltered[1][@"Names"] ? sideBarCategorySectionArrayAltered[1][@"Names"] : [NSMutableArray array];
//        NSMutableArray *tagNameArray = [(NSArray *)sideBarCategorySectionArrayAltered count] > 2 && sideBarCategorySectionArrayAltered[2][@"Names"] ? sideBarCategorySectionArrayAltered[2][@"Names"] : [NSMutableArray array];
//        NSMutableArray *allColorsArray = [(NSArray *)sideBarCategorySectionArrayAltered count] > 3 && sideBarCategorySectionArrayAltered[3][@"Names"] ? sideBarCategorySectionArrayAltered[3][@"Names"] : [NSMutableArray array];
//
//        [[NSUserDefaults standardUserDefaults] setObject:@{@"Users" : @{@"Username" : userNameArray, @"UserID" : userIDArray}, @"Tags" : tagNameArray, @"Colors" : allColorsArray} forKey:@"Stuff"];
//
//        NSMutableDictionary *myNotificationSettingsDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] && notificationSettings[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] ? notificationSettings[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] : [NSMutableDictionary dictionary];
//
//
//
//        UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"NotificationSettingsNavigationController" source:del.window.rootViewController destination:notificationSettingsViewControllerObject];
//
//        [notificationSettingsViewControllerObject prepareForSegue:segue sender:
//
//         @{@"notificationSettings" : myNotificationSettingsDict ? myNotificationSettingsDict : [NSMutableDictionary dictionary],
//
//         }];
//
//        segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"NotificationSettingsNavigationController" source:del.window.rootViewController destination:notificationSettingsViewControllerObjectNo1];
//
//        [notificationSettingsViewControllerObjectNo1 prepareForSegue:segue sender:
//
//         @{@"notificationSettings" : myNotificationSettingsDict ? myNotificationSettingsDict : [NSMutableDictionary dictionary],
//           @"viewingScheduledSummary" : @"Yes"
//         }];
//
//
//
//        UINavigationController *navVC = (UINavigationController *)del.window.rootViewController;
//        [navVC pushViewController:settingsViewControllerObject animated:YES];
//
//        notificationSettingsViewControllerObject.modalInPresentation = true;
//        notificationSettingsViewControllerObject.modalPresentationStyle = UIModalPresentationPopover;
//        [navVC presentViewController:notificationSettingsViewControllerObject animated:YES completion:nil];
//
//        notificationSettingsViewControllerObjectNo1.modalInPresentation = true;
//        notificationSettingsViewControllerObjectNo1.modalPresentationStyle = UIModalPresentationPopover;
//        [navVC presentViewController:notificationSettingsViewControllerObjectNo1 animated:YES completion:nil];
//
//    } else {
//
//        SceneDelegate *del = (SceneDelegate *)[UIApplication sharedApplication].connectedScenes.allObjects.firstObject.delegate;
//        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//
//        UIViewController *notificationClickViewController = [[UIViewController alloc] init];
//        notificationClickViewController.restorationIdentifier = @"NotificationClick";
//
//        NSString *delegateType = @"Scene";
//
//
//
//        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:notificationClickViewController touchEvent:[NSString stringWithFormat:@"%@ Delegate - %@ - %@", delegateType, previousState, @"Notification Overview"] completionHandler:^(BOOL finished) {
//
//        }];
//
//
//
//        NotificationSettingsNavigationController *notificationSettingsViewControllerObject = [storyBoard instantiateViewControllerWithIdentifier:@"NotificationSettingsNavigationController"];
//        SettingsViewController *settingsViewControllerObject = [storyBoard instantiateViewControllerWithIdentifier:@"SettingsViewController"];
//
//
//
//        id notificationSettings = userInfo[@"NotificationSettings"] && [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"NotificationSettings"]] ? [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"NotificationSettings"]] : [NSMutableDictionary dictionary];
//        id sideBarCategorySectionArrayAltered = userInfo[@"SideBarCategorySectionArrayAltered"] && [[[GeneralObject alloc] init] GenerateArrayID:userInfo[@"SideBarCategorySectionArrayAltered"]] ? [[[GeneralObject alloc] init] GenerateArrayID:userInfo[@"SideBarCategorySectionArrayAltered"]] : [NSMutableArray array];
//
//        NSMutableArray *userIDArray = [(NSArray *)sideBarCategorySectionArrayAltered count] > 1 && sideBarCategorySectionArrayAltered[1][@"IDs"] ? sideBarCategorySectionArrayAltered[1][@"IDs"] : [NSMutableArray array];
//        NSMutableArray *userNameArray = [(NSArray *)sideBarCategorySectionArrayAltered count] > 1 && sideBarCategorySectionArrayAltered[1][@"Names"] ? sideBarCategorySectionArrayAltered[1][@"Names"] : [NSMutableArray array];
//        NSMutableArray *tagNameArray = [(NSArray *)sideBarCategorySectionArrayAltered count] > 2 && sideBarCategorySectionArrayAltered[2][@"Names"] ? sideBarCategorySectionArrayAltered[2][@"Names"] : [NSMutableArray array];
//        NSMutableArray *allColorsArray = [(NSArray *)sideBarCategorySectionArrayAltered count] > 3 && sideBarCategorySectionArrayAltered[3][@"Names"] ? sideBarCategorySectionArrayAltered[3][@"Names"] : [NSMutableArray array];
//
//        [[NSUserDefaults standardUserDefaults] setObject:@{@"Users" : @{@"Username" : userNameArray, @"UserID" : userIDArray}, @"Tags" : tagNameArray, @"Colors" : allColorsArray} forKey:@"Stuff"];
//
//        NSMutableDictionary *myNotificationSettingsDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] && notificationSettings[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] ? notificationSettings[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] : [NSMutableDictionary dictionary];
//
//
//
//        UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"NotificationSettingsNavigationController" source:del.window.rootViewController destination:notificationSettingsViewControllerObject];
//
//        [notificationSettingsViewControllerObject prepareForSegue:segue sender:
//
//         @{@"notificationSettings" : myNotificationSettingsDict ? myNotificationSettingsDict : [NSMutableDictionary dictionary],
//           @"viewingScheduledSummary" : @"Yes"
//         }];
//
//
//
//        UINavigationController *navVC = (UINavigationController *)del.window.rootViewController;
//        [navVC pushViewController:settingsViewControllerObject animated:YES];
//
//        notificationSettingsViewControllerObject.modalInPresentation = true;
//        notificationSettingsViewControllerObject.modalPresentationStyle = UIModalPresentationPopover;
//        [navVC presentViewController:notificationSettingsViewControllerObject animated:YES completion:nil];
//
//    }
//
//}

-(void)NotificationActionTurnOff:(UNNotificationResponse *)response previousState:(NSString *)previousState {
    
    NSDictionary *userInfo = response.notification.request.content.userInfo;

    id notificationSettings = userInfo[@"NotificationSettings"] && [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"NotificationSettings"]] ? [[[GeneralObject alloc] init] GenerateDictionaryID:userInfo[@"NotificationSettings"]] : [NSMutableDictionary dictionary];

    NSMutableDictionary *notificationSettingsCopy = notificationSettings ? [notificationSettings mutableCopy] : [NSMutableDictionary dictionary];
    NSMutableDictionary *dict = notificationSettingsCopy && notificationSettingsCopy[@"ScheduledSummary"] ? [notificationSettingsCopy[@"ScheduledSummary"] mutableCopy] : [NSMutableDictionary dictionary];
    [dict setObject:@"No" forKey:@"Activated"];
    [notificationSettingsCopy setObject:dict forKey:@"ScheduledSummary"];
    notificationSettings = [notificationSettingsCopy mutableCopy];
    
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] : @"xxx";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userID == %@", userID];
    [[[SetDataObject alloc] init] SetDataEditCoreData:@"NotificationSettings" predicate:predicate setDataObject:notificationSettings];
    
    [[[SetDataObject alloc] init] UpdateDataNotificationSettings:userID dataDict:notificationSettings completionHandler:^(BOOL finished, NSError * _Nonnull error) {
        
        [[NSUserDefaults standardUserDefaults] setObject:notificationSettings forKey:@"NotificationSettingsDict"];
        
    }];
    
}

@end
