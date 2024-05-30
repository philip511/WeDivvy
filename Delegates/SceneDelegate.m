//
//  SceneDelegate.m
//  RoommateApp
//
//  Created by Philip Nagel on 5/16/21.
//

#import "SceneDelegate.h"

//#import <Mixpanel/Mixpanel.h>

#import "GeneralObject.h"
#import "SetDataObject.h"
#import "BoolDataObject.h"
#import "NotificationsObject.h"
#import "PushObject.h"
#import "HomesViewControllerObject.h"
#import "InitialViewControllerObject.h"

#import "TasksViewController.h"
#import "ViewTaskViewController.h"
#import "AddTaskViewController.h"
#import "ChatsViewController.h"
#import "LiveChatViewController.h"
#import "AddChatViewController.h"
#import "WeDivvyPremiumViewController.h"
#import "InitialViewController.h"
#import "HomesViewController.h"
#import "SearchTasksViewController.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate

#pragma mark - System Methods

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions  API_AVAILABLE(ios(13.0)){

    [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"ViewDidLoadShouldStart"];
    [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"QueryFirstTime"];
    
    [[FIRCrashlytics crashlytics] logWithFormat:@"GetDataGetItemsInSpecificHome DateAppOpenned:%@ CurrentTime:%@ Processing(0.0.1)", [[NSUserDefaults standardUserDefaults] objectForKey:@"DateAppOpenned"], [NSString stringWithFormat:@"%@", [NSDate date]]];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"NoSignUp"];
    
    BOOL isSimulator = [self SetUpIsSimulator];
    
    [self SetUpAnalytics:isSimulator completionHandler:^(BOOL finished) {
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewViewController:@"willConnectToSession" completionHandler:^(BOOL finished) {
            
        }];
        
    }];
    
    if (connectionOptions.shortcutItem) {
        
        [self HandleShortcutItem:connectionOptions.shortcutItem];
        
    } else {
      
        [self SetUpShortcutIcons];
        
        if ([[[BoolDataObject alloc] init] NoSignUp]) {
            
            [self SetUpRootViewControllerNoSignUp:isSimulator];
            
        } else {
            
            [[FIRCrashlytics crashlytics] logWithFormat:@"GetDataGetItemsInSpecificHome DateAppOpenned:%@ CurrentTime:%@ Processing(0.0.2)", [[NSUserDefaults standardUserDefaults] objectForKey:@"DateAppOpenned"], [NSString stringWithFormat:@"%@", [NSDate date]]];
            
            [self SetUpRootViewController:isSimulator];
            
        }
        
    }
    
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

-(void)SetUpAnalytics:(BOOL)isSimulator completionHandler:(void (^)(BOOL finished))finishBlock {
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"WeDivvyPremiumWasDisplayedAfterSignUpOnThisSession"];
    
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

- (void)SetUpShortcutIcons {
    
    UIApplicationShortcutIcon *shortcutSearchIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeSearch];
    UIApplicationShortcutIcon *shortcutComposeIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeCompose];
    
    /*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
    
    UIApplicationShortcutItem *shortcutSearch = [[UIApplicationShortcutItem alloc]
                                                 initWithType:[NSString stringWithFormat:@"%@.SearchTasks", NSBundle.mainBundle.bundleIdentifier]
                                                 localizedTitle:@"🔍 Search Tasks"
                                                 localizedSubtitle:nil
                                                 icon:shortcutSearchIcon
                                                 userInfo:nil];
    
    /*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
    
//    NSDictionary *shortcutItemsMultiAddTasks = [self ShortcutIconsMultiAddTasks];
//
//    UIApplicationShortcutItem *shortcutMultiAddChore = shortcutItemsMultiAddTasks[@"MultiAddChore"];
//
//    UIApplicationShortcutItem *shortcutMultiAddExpense = shortcutItemsMultiAddTasks[@"MultiAddExpense"];
//
//    UIApplicationShortcutItem *shortcutMultiAddList = shortcutItemsMultiAddTasks[@"MultiAddList"];
//    
//    UIApplicationShortcutItem *shortcutMultiAddGroupChat = shortcutItemsMultiAddTasks[@"AddGroupChat"];
    
    /*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
    
    NSDictionary *shortcutItemsAddTasks = [self ShortcutIconsAddTasks];
    
    UIApplicationShortcutItem *shortcutAddChore = shortcutItemsAddTasks[@"AddChore"];
    
    UIApplicationShortcutItem *shortcutAddExpense = shortcutItemsAddTasks[@"AddExpense"];
    
    UIApplicationShortcutItem *shortcutAddList = shortcutItemsAddTasks[@"AddList"];
    
    UIApplicationShortcutItem *shortcutAddGroupChat = shortcutItemsAddTasks[@"AddGroupChat"];
    
    /*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
    
    NSDictionary *shortcutItemsViewTasks = [self ShortcutIconsViewTasks];
    
    UIApplicationShortcutItem *shortcutViewChores = shortcutItemsViewTasks[@"ViewChores"];
    
    UIApplicationShortcutItem *shortcutViewExpenses = shortcutItemsViewTasks[@"ViewExpenses"];
    
    UIApplicationShortcutItem *shortcutViewLists = shortcutItemsViewTasks[@"ViewLists"];
    
    UIApplicationShortcutItem *shortcutViewGroupChats = shortcutItemsViewTasks[@"ViewGroupChats"];
    
    /*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
    
    NSDictionary *shortcutItemsViewDefaultSections = [self ShortcutIconsViewDefaultSections];
    
    UIApplicationShortcutItem *shortcutViewAll = shortcutItemsViewDefaultSections[@"ViewAll"];
    
    UIApplicationShortcutItem *shortcutViewToday = shortcutItemsViewDefaultSections[@"ViewToday"];
    
    UIApplicationShortcutItem *shortcutViewTomorrow = shortcutItemsViewDefaultSections[@"ViewTomorrow"];
    
    UIApplicationShortcutItem *shortcutViewNext7Days = shortcutItemsViewDefaultSections[@"ViewNext7Days"];
    
    UIApplicationShortcutItem *shortcutViewAssignedToMe = shortcutItemsViewDefaultSections[@"ViewAssignedToMe"];
    
    UIApplicationShortcutItem *shortcutViewCompleted = shortcutItemsViewDefaultSections[@"ViewCompleted"];
    
    UIApplicationShortcutItem *shortcutViewPastDue = shortcutItemsViewDefaultSections[@"ViewPastDue"];
    
    UIApplicationShortcutItem *shortcutViewTrash = shortcutItemsViewDefaultSections[@"ViewTrash"];
    
    /*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
    
    NSDictionary *shortcutItemsViewGenericOptions = [self ShortcutIconsViewGenericOptions];
    
    UIApplicationShortcutItem *shortcutViewGeneric1 = shortcutItemsViewGenericOptions[@"ViewGeneric1"];
    
    UIApplicationShortcutItem *shortcutViewGeneric2 = shortcutItemsViewGenericOptions[@"ViewGeneric2"];
    
    UIApplicationShortcutItem *shortcutViewGeneric3 = shortcutItemsViewGenericOptions[@"ViewGeneric3"];
    
    UIApplicationShortcutItem *shortcutViewGeneric4 = shortcutItemsViewGenericOptions[@"ViewGeneric4"];
    
    /*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
    
    UIApplicationShortcutItem *shortcutCustomizeIcons = [[UIApplicationShortcutItem alloc]
                                                         initWithType:[NSString stringWithFormat:@"%@.WeDivvyPremium", NSBundle.mainBundle.bundleIdentifier]
                                                         localizedTitle:[NSString stringWithFormat:@"⚙️ Customize Shortcuts"]
                                                         localizedSubtitle:nil
                                                         icon:shortcutComposeIcon
                                                         userInfo:nil];
    
    UIApplicationShortcutItem *shortcuAnythingWrong = [[UIApplicationShortcutItem alloc]
                                                       initWithType:[NSString stringWithFormat:@"%@.AnythingWrong", NSBundle.mainBundle.bundleIdentifier]
                                                       localizedTitle:[NSString stringWithFormat:@"🥺 Anything wrong with WeDivvy?"]
                                                       localizedSubtitle:nil
                                                       icon:shortcutComposeIcon
                                                       userInfo:nil];
    
    NSMutableArray *items = [NSMutableArray array];
    
    if ([[[BoolDataObject alloc] init] PremiumSubscriptionIsOn]) {
        
        NSMutableArray *arr =
        [[NSUserDefaults standardUserDefaults] objectForKey:@"ShortcutItems"] ?
        [[[NSUserDefaults standardUserDefaults] objectForKey:@"ShortcutItems"] mutableCopy] : [NSMutableArray array];
        
        if ([arr count] == 0 && [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]) {
            arr = [@[@"🧹 Add Chore", @"📁 Today", @"📁 Next 7 Days", @"⚙️ Customize Shortcuts"] mutableCopy];
        }
        
        for (NSString *shortcutItemTitle in arr) {
            
            if ([shortcutItemTitle containsString:@"Search Tasks"]) {
                
                [items addObject:shortcutSearch];
                
                /*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
                
//            } else if ([shortcutItemTitle containsString:@"Multi-Add Chore"]) {
//
//                [items addObject:shortcutMultiAddChore];
//
//            } else if ([shortcutItemTitle containsString:@"Multi-Add Expense"]) {
//
//                [items addObject:shortcutMultiAddExpense];
//
//            } else if ([shortcutItemTitle containsString:@"Multi-Add List"]) {
//
//                [items addObject:shortcutMultiAddList];
//
//            } else if ([shortcutItemTitle containsString:@"Multi-Add Group Chat"]) {
//
//                [items addObject:shortcutMultiAddGroupChat];
                
                /*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
                
            } else if ([shortcutItemTitle containsString:@"Add Chore"]) {
                
                [items addObject:shortcutAddChore];
                
            } else if ([shortcutItemTitle containsString:@"Add Expense"]) {
                
                [items addObject:shortcutAddExpense];
                
            } else if ([shortcutItemTitle containsString:@"Add List"]) {
                
                [items addObject:shortcutAddList];
                
            } else if ([shortcutItemTitle containsString:@"Add Group Chat"]) {
                
                [items addObject:shortcutAddGroupChat];
                
                /*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
                
            } else if ([shortcutItemTitle containsString:@"View Chores"]) {
                
                [items addObject:shortcutViewChores];
                
            } else if ([shortcutItemTitle containsString:@"View Expenses"]) {
                
                [items addObject:shortcutViewExpenses];
                
            } else if ([shortcutItemTitle containsString:@"View Lists"]) {
                
                [items addObject:shortcutViewLists];
                
            } else if ([shortcutItemTitle containsString:@"View Group Chats"]) {
                
                [items addObject:shortcutViewGroupChats];
                
                /*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
                
            } else if ([shortcutItemTitle containsString:@"📁 All"]) {
                
                [items addObject:shortcutViewAll];
                
            } else if ([shortcutItemTitle containsString:@"📁 Today"]) {
                
                [items addObject:shortcutViewToday];
                
            } else if ([shortcutItemTitle containsString:@"📁 Tomorrow"]) {
                
                [items addObject:shortcutViewTomorrow];
                
            } else if ([shortcutItemTitle containsString:@"📁 Next 7 Days"]) {
                
                [items addObject:shortcutViewNext7Days];
                
            } else if ([shortcutItemTitle containsString:@"📁 Assigned To Me"]) {
                
                [items addObject:shortcutViewAssignedToMe];
                
            } else if ([shortcutItemTitle containsString:@"📁 Completed"]) {
                
                [items addObject:shortcutViewCompleted];
                
            } else if ([shortcutItemTitle containsString:@"📁 Past Due"]) {
                
                [items addObject:shortcutViewPastDue];
                
            } else if ([shortcutItemTitle containsString:@"📁 Trash"]) {
                
                [items addObject:shortcutViewTrash];
                
                /*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
                
            } else if ([shortcutItemTitle containsString:@"WeDivvyPremium"]) {
                
                [items addObject:shortcutCustomizeIcons];
                
            } else if ([shortcutItemTitle containsString:@"AnythingWrong"]) {
                
                [items addObject:shortcuAnythingWrong];
                
                /*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
                
            } else {
                
                NSString *identifier = @"";
                
                if ([shortcutItemTitle containsString:@"View Chore:"]) {
                    identifier = @"ViewChore";
                } else if ([shortcutItemTitle containsString:@"View Expense:"]) {
                    identifier = @"ViewExpense";
                } else if ([shortcutItemTitle containsString:@"View List:"]) {
                    identifier = @"ViewList";
                } else if ([shortcutItemTitle containsString:@"View Group Chat:"]) {
                    identifier = @"ViewGroupChat";
                } else if ([shortcutItemTitle containsString:@"🏷️ #"]) {
                    identifier = @"ViewTag";
                } else if ([shortcutItemTitle containsString:@"👤 "]) {
                    identifier = @"ViewUser";
                } else if ([shortcutItemTitle containsString:@"🖍️ "]) {
                    identifier = @"ViewColor";
                } else if ([shortcutItemTitle containsString:@"🗄️ "]) {
                    identifier = @"ViewTaskList";
                }
                
                if ([items containsObject:shortcutViewGeneric1] == NO) {
                    
                    shortcutViewGeneric1 = [[UIApplicationShortcutItem alloc]
                                            initWithType:[NSString stringWithFormat:@"%@.%@1", NSBundle.mainBundle.bundleIdentifier, identifier]
                                            localizedTitle:shortcutItemTitle
                                            localizedSubtitle:nil
                                            icon:shortcutComposeIcon
                                            userInfo:nil];
                    
                    [items addObject:shortcutViewGeneric1];
                    
                } else if ([items containsObject:shortcutViewGeneric2] == NO) {
                    
                    shortcutViewGeneric2 = [[UIApplicationShortcutItem alloc]
                                            initWithType:[NSString stringWithFormat:@"%@.%@2", NSBundle.mainBundle.bundleIdentifier, identifier]
                                            localizedTitle:shortcutItemTitle
                                            localizedSubtitle:nil
                                            icon:shortcutComposeIcon
                                            userInfo:nil];
                    
                    [items addObject:shortcutViewGeneric2];
                    
                } else if ([items containsObject:shortcutViewGeneric3] == NO) {
                    
                    shortcutViewGeneric3 = [[UIApplicationShortcutItem alloc]
                                            initWithType:[NSString stringWithFormat:@"%@.%@3", NSBundle.mainBundle.bundleIdentifier, identifier]
                                            localizedTitle:shortcutItemTitle
                                            localizedSubtitle:nil
                                            icon:shortcutComposeIcon
                                            userInfo:nil];
                    
                    [items addObject:shortcutViewGeneric3];
                    
                } else if ([items containsObject:shortcutViewGeneric4] == NO) {
                    
                    shortcutViewGeneric4 = [[UIApplicationShortcutItem alloc]
                                            initWithType:[NSString stringWithFormat:@"%@.%@4", NSBundle.mainBundle.bundleIdentifier, identifier]
                                            localizedTitle:shortcutItemTitle
                                            localizedSubtitle:nil
                                            icon:shortcutComposeIcon
                                            userInfo:nil];
                    
                    [items addObject:shortcutViewGeneric4];
                    
                }
                
            }
            
            if ([items count] == 4) {
                break;
            }
            
        }
        
        //        if ([items count] < 4 && [items containsObject:shortcuAnythingWrong] == NO) {
        //            [items addObject:shortcuAnythingWrong];
        //        }
        
    } else {
        
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"]) {
            [items addObject:shortcutViewToday];
            [items addObject:shortcutViewNext7Days];
            [items addObject:shortcutAddChore];
            [items addObject:shortcutCustomizeIcons];
        }
        
        //        [items addObject:shortcuAnythingWrong];
        
    }
    
    if ([items count] > 0) {
        
        [UIApplication sharedApplication].shortcutItems = items;
        
    }
    
}

-(void)SetUpRootViewControllerNoSignUp:(BOOL)isSimulator {
    
    if (@available(iOS 13, *)) {
        
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *controller = [[UIViewController alloc] init];
        NSString *restorationIdentifier = @"";
        
        [[[GeneralObject alloc] init] RemoveCachedInitialDataNSUserDefaults:NO];
        [[[GeneralObject alloc] init] RemoveHomeDataNSUserDefaults];
        [[[GeneralObject alloc] init] RemoveAppDataNSUserDefaults];
        
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"LaunchPageSelected"]) {

            NSString *launchPage = [[NSUserDefaults standardUserDefaults] objectForKey:@"LaunchPageSelected"];

            if ([launchPage isEqualToString:@"Expenses"]) {
                
                [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"ViewingExpenses"];
                
            } else if ([launchPage isEqualToString:@"Lists"]) {

                [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"ViewingLists"];

            } else if ([launchPage isEqualToString:@"Chats"]) {

                [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"ViewingChats"];

            }
            
        }
        
        
        
        
        
        
        if (![[NSUserDefaults standardUserDefaults] objectForKey:@"MixPanelID"]) {
            
            [[NSUserDefaults standardUserDefaults] setObject:[[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString] forKey:@"MixPanelID"];
            
            if (![[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]) {
                
                [[NSUserDefaults standardUserDefaults] setObject:[[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString] forKey:@"UsersUserID"];
                
                NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"];
                NSString *username = [NSString stringWithFormat:@"User%@", [[[GeneralObject alloc] init] GenerateRandomSmallNumberIntoString:10000 upperBound:99999]];
                NSString *userEmail = @"xxx";
                NSString *userPassword = [NSString stringWithFormat:@"xxx%@xxx", [[[GeneralObject alloc] init] GenerateRandomSmallNumberIntoString:100000 upperBound:999999]];
                NSString *howYouHeardAboutUs = @"xxx";
                NSString *whoIsThisFor = @"xxx";
                NSString *receiveEmails = @"Yes";
                
                [[[InitialViewControllerObject alloc] init] SignUpUser_StandardSignUp:userID username:username userEmail:userEmail userPassword:userPassword howYouHeardAboutUs:howYouHeardAboutUs whoIsThisFor:whoIsThisFor receiveEmails:receiveEmails thirdPartySignUp:NO completionHandler:^(BOOL finished, NSString * _Nonnull errorString) {
                    
                }];
                
            }
            
            if (![[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"]) {
                
                [[NSUserDefaults standardUserDefaults] setObject:
                 @{@"HomeName" : [NSString stringWithFormat:@"MyHome%@", [[[GeneralObject alloc] init] GenerateRandomSmallNumberIntoString:10000 upperBound:99999]],
                   @"HomeID" : [[[GeneralObject alloc] init] GenerateRandomESTNumberIntoString],
                   @"HomeImageURL" : @"xxx",
                   @"HomeMembers" : @[[[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]],
                   @"HomeMembersUnclaimed" : [NSMutableDictionary dictionary],
                   @"HomeKey" : [[[GeneralObject alloc] init] GenerateRandomSmallNumberIntoString:100000 upperBound:999999],
                   @"HomeKeys" : [NSMutableDictionary dictionary],
                   @"HomeKeysArray" : [NSMutableArray array],
                   @"HomeCreationDate": [[[GeneralObject alloc] init] GenerateCurrentDateString],
                   @"HomeOwnerUserID" : [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"],
                   @"HomeWeDivvyPremium" : @"No",
                 } forKey:@"HomeChosen"];
                
                NSString *homeID = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeID"] : @"xxx";
                NSString *homeName = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeName"] ? [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeName"] : @"xxx";
                NSMutableArray *homeMembers = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"] && [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeMembers"] ? [[[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"][@"HomeMembers"] mutableCopy] : [NSMutableArray array];
                
//                [[[HomesViewControllerObject alloc] init] CreateHome:homeID homeName:homeName homeMemberArray:homeMembers completionHandler:^(BOOL finished, NSDictionary * _Nonnull returningHomeDict) {
//                    
//                }];
                
            }
            
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"UserHasLoggedIn"];
        
        
        
        
        
        
        BOOL UserIsValid = [self UserisValid:isSimulator];
        BOOL UserIsLoggedInButHomeHasNotBeenChosen = ([[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] && ([[[NSUserDefaults standardUserDefaults] objectForKey:@"UserHasLoggedIn"] isEqualToString:@"Yes"]) && (![[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"]) && (![[NSUserDefaults standardUserDefaults] objectForKey:@"UpdateEmail"]));
        BOOL UserIsLoggedInAndHasChosenAHome = ([[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"]);
        
        
        
        if (UserIsLoggedInButHomeHasNotBeenChosen == YES) {
            
            controller = [storyBoard instantiateViewControllerWithIdentifier:@"HomeNavigationController"];
            restorationIdentifier = @"HomeNavigationController";
            
            if (UserIsValid == YES) {
                
                [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"InitialNotificationSent"];
                
                [[[NotificationsObject alloc] init] SendPushNotificationToCreator:[NSString stringWithFormat:@"%@ - Existing User Home", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] notificationBody:[NSString stringWithFormat:@"%@ Delegate -  6.5.98", @"Scene"] badgeNumber:(NSInteger *)1 completionHandler:^(BOOL finished) {
                    
                }];
                
            }
            
            
            
            
            
            
        } else if (UserIsLoggedInAndHasChosenAHome == YES) {
            
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"ViewingChats"] isEqualToString:@"Yes"]) {
                
                controller = [storyBoard instantiateViewControllerWithIdentifier:@"ChatsNavigationController"];
                restorationIdentifier = @"ChatsNavigationController";
                
            } else {
                
                controller = [storyBoard instantiateViewControllerWithIdentifier:@"TasksNavigationController"];
                restorationIdentifier = @"TasksNavigationController";
                
            }
            
            [self GenerateDefaultViewController];
            
            if (UserIsValid == YES) {
                
                [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"InitialNotificationSent"];
                
                [[[NotificationsObject alloc] init] SendPushNotificationToCreator:[NSString stringWithFormat:@"%@ - Existing User CustomTab", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] notificationBody:[NSString stringWithFormat:@"%@ Delegate -  6.5.98", @"Scene"] badgeNumber:(NSInteger *)1 completionHandler:^(BOOL finished) {
                    
                }];
                
            }
            
            
            
            
            
            
        } else {
            
            controller = [storyBoard instantiateViewControllerWithIdentifier:@"InitialNavigationViewController"];
            restorationIdentifier = @"InitialNavigationViewController";
            
            [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"InitialNotificationSent"];
            
            NSString *addedString = [[NSUserDefaults standardUserDefaults] objectForKey:@"MixPanelID"] ? @" MixPanelID" : @"";
            NSString *addedStringNo1 = isSimulator ? @" Simulator" : @"";
            
            [[[NotificationsObject alloc] init] SendPushNotificationToCreator:[NSString stringWithFormat:@"Unknown User%@%@", addedString, addedStringNo1] notificationBody:[NSString stringWithFormat:@"%@ Delegate -  6.5.98", @"Scene"] badgeNumber:(NSInteger *)1 completionHandler:^(BOOL finished) {
                
            }];
            
        }
        
        
        
        
        
        //        controller = [storyBoard instantiateViewControllerWithIdentifier:@"AddTaskViewController"];
        //        restorationIdentifier = @"AddTaskViewController";
        NSString *identifier = restorationIdentifier;
        
        identifier = [[[GeneralObject alloc] init] GenerateStringWithReplacementString:identifier stringToReplace:@"Navigation" replacementString:@"View"];
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewViewController:identifier completionHandler:^(BOOL finished) {
            
        }];
        
        self->_window.rootViewController = controller;
        [self.window makeKeyAndVisible];
        
    }
    
}

-(void)SetUpRootViewController:(BOOL)isSimulator {
    
    [[FIRCrashlytics crashlytics] logWithFormat:@"GetDataGetItemsInSpecificHome DateAppOpenned:%@ CurrentTime:%@ Processing(0.0.3)", [[NSUserDefaults standardUserDefaults] objectForKey:@"DateAppOpenned"], [NSString stringWithFormat:@"%@", [NSDate date]]];
    
    if (@available(iOS 13, *)) {
        
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *controller = [[UIViewController alloc] init];
        NSString *restorationIdentifier = @"";
        
        [[[GeneralObject alloc] init] RemoveCachedInitialDataNSUserDefaults:NO];
        [[[GeneralObject alloc] init] RemoveHomeDataNSUserDefaults];
        [[[GeneralObject alloc] init] RemoveAppDataNSUserDefaults];
        
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"LaunchPageSelected"]) {

            NSString *launchPage = [[NSUserDefaults standardUserDefaults] objectForKey:@"LaunchPageSelected"];

            if ([launchPage isEqualToString:@"Expenses"]) {
                
                [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"ViewingExpenses"];
                
            } else if ([launchPage isEqualToString:@"Lists"]) {

                [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"ViewingLists"];

            } else if ([launchPage isEqualToString:@"Chats"]) {

                [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"ViewingChats"];

            }

        }
        
        

        
        
        
        BOOL UserIsValid = [self UserisValid:isSimulator];
        BOOL UserIsLoggedInButHomeHasNotBeenChosen = ([[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] && ([[[NSUserDefaults standardUserDefaults] objectForKey:@"UserHasLoggedIn"] isEqualToString:@"Yes"]) && (![[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"]) && (![[NSUserDefaults standardUserDefaults] objectForKey:@"UpdateEmail"]));
        BOOL UserIsLoggedInAndHasChosenAHome = ([[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"]);
        
        
        
        
        
        
        if (UserIsLoggedInButHomeHasNotBeenChosen == YES) {

            controller = [storyBoard instantiateViewControllerWithIdentifier:@"HomeNavigationController"];
            restorationIdentifier = @"HomeNavigationController";
            
            if (UserIsValid == YES) {
            
                [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"InitialNotificationSent"];
                
                [[[NotificationsObject alloc] init] SendPushNotificationToCreator:[NSString stringWithFormat:@"%@ - Existing User Home", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] notificationBody:[NSString stringWithFormat:@"%@ Delegate -  6.5.98", @"Scene"] badgeNumber:(NSInteger *)1 completionHandler:^(BOOL finished) {

                }];
                
            }
            
            
            
            
            
            
        } else if (UserIsLoggedInAndHasChosenAHome == YES) {

            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"ViewingChats"] isEqualToString:@"Yes"]) {
                
                controller = [storyBoard instantiateViewControllerWithIdentifier:@"ChatsNavigationController"];
                restorationIdentifier = @"ChatsNavigationController";
                
            } else {
                
                controller = [storyBoard instantiateViewControllerWithIdentifier:@"TasksNavigationController"];
                restorationIdentifier = @"TasksNavigationController";
                
            }

            [self GenerateDefaultViewController];
            
            if (UserIsValid == YES) {
                
                [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"InitialNotificationSent"];
                
                [[[NotificationsObject alloc] init] SendPushNotificationToCreator:[NSString stringWithFormat:@"%@ - Existing User CustomTab", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] notificationBody:[NSString stringWithFormat:@"%@ Delegate -  6.5.98", @"Scene"] badgeNumber:(NSInteger *)1 completionHandler:^(BOOL finished) {
                    
                }];

            }

            
            
            
            
            
        } else {
           
            controller = [storyBoard instantiateViewControllerWithIdentifier:@"InitialNavigationViewController"];
            restorationIdentifier = @"InitialNavigationViewController";
            
            [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"InitialNotificationSent"];
            
            NSString *addedString = [[NSUserDefaults standardUserDefaults] objectForKey:@"MixPanelID"] ? @" MixPanelID" : @"";
            NSString *addedStringNo1 = isSimulator ? @" Simulator" : @"";
            
            [[[NotificationsObject alloc] init] SendPushNotificationToCreator:[NSString stringWithFormat:@"Unknown User%@%@", addedString, addedStringNo1] notificationBody:[NSString stringWithFormat:@"%@ Delegate -  6.5.98", @"Scene"] badgeNumber:(NSInteger *)1 completionHandler:^(BOOL finished) {
                
            }];
            
        }
        
        
        
      
        
//        controller = [storyBoard instantiateViewControllerWithIdentifier:@"HomeNavigationController"];
//        restorationIdentifier = @"HomeNavigationController";
        NSString *identifier = restorationIdentifier;
        
        identifier = [[[GeneralObject alloc] init] GenerateStringWithReplacementString:identifier stringToReplace:@"Navigation" replacementString:@"View"];
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewViewController:identifier completionHandler:^(BOOL finished) {
            
        }];
        
        [[FIRCrashlytics crashlytics] logWithFormat:@"GetDataGetItemsInSpecificHome:%@ Processing(0.0.4)", identifier];
        
        self->_window.rootViewController = controller;
        [self.window makeKeyAndVisible];
        
    }
    
}

-(void)SetUpRootViewControllerHandleShortcuts:(BOOL)isSimulator viewControllerIdentifier:(NSString *)viewControllerIdentifier {
    
    if (@available(iOS 13, *)) {
        
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *controller = [[UIViewController alloc] init];
        NSString *restorationIdentifier = @"";
        
        [[[GeneralObject alloc] init] RemoveCachedInitialDataNSUserDefaults:NO];
        [[[GeneralObject alloc] init] RemoveHomeDataNSUserDefaults];
        [[[GeneralObject alloc] init] RemoveAppDataNSUserDefaults];
        
        
        
        
        
        
        controller = [storyBoard instantiateViewControllerWithIdentifier:viewControllerIdentifier];
        restorationIdentifier = viewControllerIdentifier;
        
        NSString *identifier = restorationIdentifier;
        
        identifier = [[[GeneralObject alloc] init] GenerateStringWithReplacementString:identifier stringToReplace:@"Navigation" replacementString:@"View"];
        
        [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewViewController:identifier completionHandler:^(BOOL finished) {
            
        }];
        
        self->_window.rootViewController = controller;
        [self.window makeKeyAndVisible];
        
    }
    
}

#pragma mark - Scene Methods

- (void)sceneDidDisconnect:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
  
    [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"AppCrashed"];
    [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"AppCrashedReported"];
}


- (void)sceneDidBecomeActive:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ViewControllerDict"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TouchEventDict"];
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewViewController:@"sceneDidBecomeActive" completionHandler:^(BOOL finished) {

    }];
}


- (void)sceneWillResignActive:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ViewControllerDict"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TouchEventDict"];
    //[[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewViewController:@"sceneWillResignActive" completionHandler:^(BOOL finished) {
        
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"MixPanelCurrentDate"]) {
            
            [[NSUserDefaults standardUserDefaults] setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"MixPanelCurrentDate"] forKey:@"TempMixPanelCurrentDate"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"MixPanelCurrentDate"];
            
        }
    
    //}];
    
}


- (void)sceneWillEnterForeground:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
    
    BOOL isSimulator = [self SetUpIsSimulator];
    BOOL UserIsValid = [self UserisValid:isSimulator];
    BOOL InitialNotificationHasBeenSent = [[[NSUserDefaults standardUserDefaults] objectForKey:@"InitialNotificationSent"] isEqualToString:@"Yes"];
    
    if (UserIsValid == YES) {
        
        if (InitialNotificationHasBeenSent == NO) {
            
            [[[NotificationsObject alloc] init] SendPushNotificationToCreator:[NSString stringWithFormat:@"%@ - Existing User", [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"]] notificationBody:[NSString stringWithFormat:@"%@ -  6.5.98", @"sceneWillEnterForeground"] badgeNumber:(NSInteger *)1 completionHandler:^(BOOL finished) {
                
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ViewControllerDict"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TouchEventDict"];
                [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewViewController:@"sceneWillEnterForeground" completionHandler:^(BOOL finished) {
                    
                }];
                
            }];
            
        } else {
            
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"InitialNotificationSent"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ViewControllerDict"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TouchEventDict"];
            [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewViewController:@"sceneWillEnterForeground" completionHandler:^(BOOL finished) {
                
            }];
            
        }
        
    }
    
}


- (void)sceneDidEnterBackground:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ViewControllerDict"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TouchEventDict"];
    //[[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewViewController:@"sceneDidEnterBackground" completionHandler:^(BOOL finished) {
  
    //}];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"AppCrashed"];
    [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"AppCrashedReported"];
    
    [(AppDelegate *)UIApplication.sharedApplication.delegate saveContext];
}

-(void)windowScene:(UIWindowScene *)windowScene performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    
    completionHandler([self HandleShortcutItem:shortcutItem]);
    
}

#pragma mark -
#pragma mark
#pragma mark
#pragma mark Internal Methods
#pragma mark
#pragma mark
#pragma mark -

#pragma mark SetUpRootViewController Methods

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

#pragma mark - Shortcut Icon Actions

-(NSDictionary *)ShortcutIconsAddTasks {
    
    UIApplicationShortcutIcon *shortcutComposeIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeCompose];
    
    UIApplicationShortcutItem *shortcutAddChore = [[UIApplicationShortcutItem alloc]
                                                   initWithType:[NSString stringWithFormat:@"%@.AddChore", NSBundle.mainBundle.bundleIdentifier]
                                                   localizedTitle:@"🧹 Add Chore"
                                                   localizedSubtitle:nil
                                                   icon:shortcutComposeIcon
                                                   userInfo:nil];
    
    UIApplicationShortcutItem *shortcutAddExpense = [[UIApplicationShortcutItem alloc]
                                                     initWithType:[NSString stringWithFormat:@"%@.AddExpense", NSBundle.mainBundle.bundleIdentifier]
                                                     localizedTitle:@"💵 Add Expense"
                                                     localizedSubtitle:nil
                                                     icon:shortcutComposeIcon
                                                     userInfo:nil];
    
    UIApplicationShortcutItem *shortcutAddList = [[UIApplicationShortcutItem alloc]
                                                  initWithType:[NSString stringWithFormat:@"%@.AddList", NSBundle.mainBundle.bundleIdentifier]
                                                  localizedTitle:@"📋 Add List"
                                                  localizedSubtitle:nil
                                                  icon:shortcutComposeIcon
                                                  userInfo:nil];
    
    UIApplicationShortcutItem *shortcutAddGroupChat = [[UIApplicationShortcutItem alloc]
                                                       initWithType:[NSString stringWithFormat:@"%@.AddGroupChat", NSBundle.mainBundle.bundleIdentifier]
                                                       localizedTitle:@"💬 Add Group Chat"
                                                       localizedSubtitle:nil
                                                       icon:shortcutComposeIcon
                                                       userInfo:nil];
    
    return @{@"AddChore" : shortcutAddChore, @"AddExpense" : shortcutAddExpense, @"AddList" : shortcutAddList, @"AddGroupChat" : shortcutAddGroupChat};
}

-(NSDictionary *)ShortcutIconsMultiAddTasks {
    
    UIApplicationShortcutIcon *shortcutComposeIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeCompose];
    
    UIApplicationShortcutItem *shortcutAddChore = [[UIApplicationShortcutItem alloc]
                                                   initWithType:[NSString stringWithFormat:@"%@.MultiAddChore", NSBundle.mainBundle.bundleIdentifier]
                                                   localizedTitle:@"🧹 Add Multiple Chores"
                                                   localizedSubtitle:nil
                                                   icon:shortcutComposeIcon
                                                   userInfo:nil];
    
    UIApplicationShortcutItem *shortcutAddExpense = [[UIApplicationShortcutItem alloc]
                                                     initWithType:[NSString stringWithFormat:@"%@.MultiAddExpense", NSBundle.mainBundle.bundleIdentifier]
                                                     localizedTitle:@"💵 Add Multiple Expenses"
                                                     localizedSubtitle:nil
                                                     icon:shortcutComposeIcon
                                                     userInfo:nil];
    
    UIApplicationShortcutItem *shortcutAddList = [[UIApplicationShortcutItem alloc]
                                                  initWithType:[NSString stringWithFormat:@"%@.MultiAddList", NSBundle.mainBundle.bundleIdentifier]
                                                  localizedTitle:@"📋 Add Multiple Lists"
                                                  localizedSubtitle:nil
                                                  icon:shortcutComposeIcon
                                                  userInfo:nil];
    
    UIApplicationShortcutItem *shortcutAddGroupChat = [[UIApplicationShortcutItem alloc]
                                                       initWithType:[NSString stringWithFormat:@"%@.MultiAddGroupChat", NSBundle.mainBundle.bundleIdentifier]
                                                       localizedTitle:@"💬 Add Multiple Group Chats"
                                                       localizedSubtitle:nil
                                                       icon:shortcutComposeIcon
                                                       userInfo:nil];
    
    return @{@"MultiAddChore" : shortcutAddChore, @"MultiAddExpense" : shortcutAddExpense, @"MultiAddList" : shortcutAddList, @"MultiAddGroupChat" : shortcutAddGroupChat};
}

-(NSDictionary *)ShortcutIconsViewTasks {
    
    UIApplicationShortcutIcon *shortcutComposeIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeCompose];
    
    UIApplicationShortcutItem *shortcutViewChores = [[UIApplicationShortcutItem alloc]
                                                     initWithType:[NSString stringWithFormat:@"%@.ViewChores", NSBundle.mainBundle.bundleIdentifier]
                                                     localizedTitle:@"🧹 View Chores"
                                                     localizedSubtitle:nil
                                                     icon:shortcutComposeIcon
                                                     userInfo:nil];
    
    UIApplicationShortcutItem *shortcutViewExpenses = [[UIApplicationShortcutItem alloc]
                                                       initWithType:[NSString stringWithFormat:@"%@.ViewExpenses", NSBundle.mainBundle.bundleIdentifier]
                                                       localizedTitle:@"💵 View Expenses"
                                                       localizedSubtitle:nil
                                                       icon:shortcutComposeIcon
                                                       userInfo:nil];
    
    UIApplicationShortcutItem *shortcutViewLists = [[UIApplicationShortcutItem alloc]
                                                    initWithType:[NSString stringWithFormat:@"%@.ViewLists", NSBundle.mainBundle.bundleIdentifier]
                                                    localizedTitle:@"📋 View Lists"
                                                    localizedSubtitle:nil
                                                    icon:shortcutComposeIcon
                                                    userInfo:nil];
    
    UIApplicationShortcutItem *shortcutViewGroupChats = [[UIApplicationShortcutItem alloc]
                                                         initWithType:[NSString stringWithFormat:@"%@.ViewGroupChats", NSBundle.mainBundle.bundleIdentifier]
                                                         localizedTitle:@"💬 View Group Chats"
                                                         localizedSubtitle:nil
                                                         icon:shortcutComposeIcon
                                                         userInfo:nil];
    
    return @{@"ViewChores" : shortcutViewChores, @"ViewExpenses" : shortcutViewExpenses, @"ViewLists" : shortcutViewLists, @"ViewGroupChats" : shortcutViewGroupChats};
}

-(NSDictionary *)ShortcutIconsViewDefaultSections {
    
    UIApplicationShortcutIcon *shortcutComposeIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeCompose];
    
    UIApplicationShortcutItem *shortcutViewAll = [[UIApplicationShortcutItem alloc]
                                                  initWithType:[NSString stringWithFormat:@"%@.ViewAll", NSBundle.mainBundle.bundleIdentifier]
                                                  localizedTitle:@"📁 All"
                                                  localizedSubtitle:nil
                                                  icon:shortcutComposeIcon
                                                  userInfo:nil];
    
    UIApplicationShortcutItem *shortcutViewToday = [[UIApplicationShortcutItem alloc]
                                                    initWithType:[NSString stringWithFormat:@"%@.ViewToday", NSBundle.mainBundle.bundleIdentifier]
                                                    localizedTitle:@"📁 Today"
                                                    localizedSubtitle:nil
                                                    icon:shortcutComposeIcon
                                                    userInfo:nil];
    
    UIApplicationShortcutItem *shortcutViewTomorrow = [[UIApplicationShortcutItem alloc]
                                                       initWithType:[NSString stringWithFormat:@"%@.ViewTomorrow", NSBundle.mainBundle.bundleIdentifier]
                                                       localizedTitle:@"📁 Tomorrow"
                                                       localizedSubtitle:nil
                                                       icon:shortcutComposeIcon
                                                       userInfo:nil];
    
    UIApplicationShortcutItem *shortcutViewNext7Days = [[UIApplicationShortcutItem alloc]
                                                        initWithType:[NSString stringWithFormat:@"%@.ViewNext7Days", NSBundle.mainBundle.bundleIdentifier]
                                                        localizedTitle:@"📁 Next 7 Days"
                                                        localizedSubtitle:nil
                                                        icon:shortcutComposeIcon
                                                        userInfo:nil];
    
    UIApplicationShortcutItem *shortcutViewAssignedToMe = [[UIApplicationShortcutItem alloc]
                                                           initWithType:[NSString stringWithFormat:@"%@.ViewAssignedToMe", NSBundle.mainBundle.bundleIdentifier]
                                                           localizedTitle:@"📁 Assigned To Me"
                                                           localizedSubtitle:nil
                                                           icon:shortcutComposeIcon
                                                           userInfo:nil];
    
    UIApplicationShortcutItem *shortcutViewCompleted = [[UIApplicationShortcutItem alloc]
                                                        initWithType:[NSString stringWithFormat:@"%@.ViewCompleted", NSBundle.mainBundle.bundleIdentifier]
                                                        localizedTitle:@"📁 Completed"
                                                        localizedSubtitle:nil
                                                        icon:shortcutComposeIcon
                                                        userInfo:nil];
    
    UIApplicationShortcutItem *shortcutViewPastDue = [[UIApplicationShortcutItem alloc]
                                                      initWithType:[NSString stringWithFormat:@"%@.ViewPastDue", NSBundle.mainBundle.bundleIdentifier]
                                                      localizedTitle:@"📁 Past Due"
                                                      localizedSubtitle:nil
                                                      icon:shortcutComposeIcon
                                                      userInfo:nil];
    
    UIApplicationShortcutItem *shortcutViewTrash = [[UIApplicationShortcutItem alloc]
                                                    initWithType:[NSString stringWithFormat:@"%@.ViewTrash", NSBundle.mainBundle.bundleIdentifier]
                                                    localizedTitle:@"📁 Trash"
                                                    localizedSubtitle:nil
                                                    icon:shortcutComposeIcon
                                                    userInfo:nil];
    
    return @{@"ViewAll" : shortcutViewAll, @"ViewToday" : shortcutViewToday, @"ViewTomorrow" : shortcutViewTomorrow, @"ViewNext7Days" : shortcutViewNext7Days, @"ViewAssignedToMe" : shortcutViewAssignedToMe, @"ViewCompleted" : shortcutViewCompleted, @"ViewPastDue" : shortcutViewPastDue, @"ViewTrash" : shortcutViewTrash};
}

-(NSDictionary *)ShortcutIconsViewGenericOptions {
    
    UIApplicationShortcutIcon *shortcutComposeIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeCompose];
    
    NSString *identifier = @"";
    NSString *title = @"";
    
    UIApplicationShortcutItem *shortcutViewGeneric1 = [[UIApplicationShortcutItem alloc]
                                                       initWithType:[NSString stringWithFormat:@"%@.%@1", NSBundle.mainBundle.bundleIdentifier, identifier]
                                                       localizedTitle:[NSString stringWithFormat:@"%@ 1", title]
                                                       localizedSubtitle:nil
                                                       icon:shortcutComposeIcon
                                                       userInfo:nil];
    
    UIApplicationShortcutItem *shortcutViewGeneric2 = [[UIApplicationShortcutItem alloc]
                                                       initWithType:[NSString stringWithFormat:@"%@.%@2", NSBundle.mainBundle.bundleIdentifier, identifier]
                                                       localizedTitle:[NSString stringWithFormat:@"%@ 2", title]
                                                       localizedSubtitle:nil
                                                       icon:shortcutComposeIcon
                                                       userInfo:nil];
    
    UIApplicationShortcutItem *shortcutViewGeneric3 = [[UIApplicationShortcutItem alloc]
                                                       initWithType:[NSString stringWithFormat:@"%@.%@3", NSBundle.mainBundle.bundleIdentifier, identifier]
                                                       localizedTitle:[NSString stringWithFormat:@"%@ 3", title]
                                                       localizedSubtitle:nil
                                                       icon:shortcutComposeIcon
                                                       userInfo:nil];
    
    UIApplicationShortcutItem *shortcutViewGeneric4 = [[UIApplicationShortcutItem alloc]
                                                       initWithType:[NSString stringWithFormat:@"%@.%@4", NSBundle.mainBundle.bundleIdentifier, identifier]
                                                       localizedTitle:[NSString stringWithFormat:@"%@ 4", title]
                                                       localizedSubtitle:nil
                                                       icon:shortcutComposeIcon
                                                       userInfo:nil];
    
    return @{@"ViewGeneric1" : shortcutViewGeneric1, @"ViewGeneric2" : shortcutViewGeneric2, @"ViewGeneric3" : shortcutViewGeneric3, @"ViewGeneric4" : shortcutViewGeneric4};
}

- (BOOL)HandleShortcutItem:(UIApplicationShortcutItem *)shortcutItem {
    
    [[[GeneralObject alloc] init] RemoveCachedInitialDataNSUserDefaults:NO];
    [[[GeneralObject alloc] init] RemoveHomeDataNSUserDefaults];
    [[[GeneralObject alloc] init] RemoveAppDataNSUserDefaults];
    
    BOOL isSimulator = [self SetUpIsSimulator];
    
    NSString *devIdent = [NSString stringWithFormat:@"%@.",NSBundle.mainBundle.bundleIdentifier];
    
    SceneDelegate *del = (SceneDelegate *)[UIApplication sharedApplication].connectedScenes.allObjects.firstObject.delegate;
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"ComingFromShortcut"];
    
    UIViewController *controller = [[UIViewController alloc] init];
    controller = [storyBoard instantiateViewControllerWithIdentifier:@"TasksNavigationController"];
    self->_window.rootViewController = controller;
    [self.window makeKeyAndVisible];
    
    
    
    
    if ([shortcutItem.type isEqualToString:[devIdent stringByAppendingString:@"SearchTasks"]]) {
        
        
        
        
        SearchTasksViewController *SearchTasksViewControllerObject = [storyBoard instantiateViewControllerWithIdentifier:@"SearchTasksViewController"];
        TasksViewController *TasksViewControllerObject = [storyBoard instantiateViewControllerWithIdentifier:@"TasksViewController"];
        
        NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"ShortcutSearchTasks"];
        
        
        
        NSMutableDictionary *notificationSettingsDict = dict[@"notificationSettingsDict"] ? dict[@"notificationSettingsDict"] : [NSMutableDictionary dictionary];
        NSMutableDictionary *topicDict = dict[@"topicDict"] ? dict[@"topicDict"] : [NSMutableDictionary dictionary];
        
        NSMutableArray *homeMembersArray = dict[@"homeMembersArray"] ? dict[@"homeMembersArray"] : [NSMutableArray array];
        NSMutableArray *allItemTagsArrays = dict[@"allItemTagsArrays"] ? dict[@"allItemTagsArrays"] : [NSMutableArray array];
        
        NSMutableDictionary *itemDict = dict[@"itemDict"] ? dict[@"itemDict"] : [NSMutableDictionary dictionary];
        NSMutableDictionary *itemDictNo2 = dict[@"itemDictNo2"] ? dict[@"itemDictNo2"] : [NSMutableDictionary dictionary];
        NSMutableDictionary *itemDictNo3 = dict[@"itemDictNo3"] ? dict[@"itemDictNo3"] : [NSMutableDictionary dictionary];
        
        NSMutableDictionary *homeMembersDict = dict[@"homeMembersDict"] ? dict[@"homeMembersDict"] : [NSMutableDictionary dictionary];
        
        
        
        SearchTasksViewControllerObject.homeMembersArray = dict[@"homeMembersArray"] ? dict[@"homeMembersArray"] : [NSMutableArray array];
        SearchTasksViewControllerObject.itemNamesAlreadyUsed = dict[@"itemNamesAlreadyUsed"] ? dict[@"itemNamesAlreadyUsed"] : [NSMutableArray array];
        SearchTasksViewControllerObject.allItemAssignedToArrays = dict[@"allItemAssignedToArrays"] ? dict[@"allItemAssignedToArrays"] : [NSMutableArray array];
        SearchTasksViewControllerObject.allItemTagsArrays = dict[@"allItemTagsArrays"] ? dict[@"allItemTagsArrays"] : [NSMutableArray array];
       
        SearchTasksViewControllerObject.itemDict = dict[@"itemDict"] ? dict[@"itemDict"] : [NSMutableDictionary dictionary];
        SearchTasksViewControllerObject.itemDictNo2 = dict[@"itemDictNo2"] ? dict[@"itemDictNo2"] : [NSMutableDictionary dictionary];
        SearchTasksViewControllerObject.itemDictNo3 = dict[@"itemDictNo3"] ? dict[@"itemDictNo3"] : [NSMutableDictionary dictionary];
        
        SearchTasksViewControllerObject.homeMembersDict = dict[@"homeMembersDict"] ? dict[@"homeMembersDict"] : [NSMutableDictionary dictionary];
        SearchTasksViewControllerObject.folderDict = dict[@"folderDict"] ? dict[@"folderDict"] : [NSMutableDictionary dictionary];
        SearchTasksViewControllerObject.taskListDict = dict[@"taskListDict"] ? dict[@"taskListDict"] : [NSMutableDictionary dictionary];
        SearchTasksViewControllerObject.sectionDict = dict[@"sectionDict"] ? dict[@"sectionDict"] : [NSMutableDictionary dictionary];
        SearchTasksViewControllerObject.templateDict = dict[@"templateDict"] ? dict[@"templateDict"] : [NSMutableDictionary dictionary];
        
        SearchTasksViewControllerObject.notificationSettingsDict = dict[@"notificationSettingsDict"] ? dict[@"notificationSettingsDict"] : [NSMutableDictionary dictionary];
        SearchTasksViewControllerObject.topicDict = dict[@"topicDict"] ? dict[@"topicDict"] : [NSMutableDictionary dictionary];
        
        
        
        [[[PushObject alloc] init] PushToSearchTasksViewController:notificationSettingsDict topicDict:topicDict itemDict:itemDict itemDictNo2:itemDictNo2 itemDictNo3:itemDictNo3 homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict allItemTagsArrays:allItemTagsArrays currentViewController:[[UIViewController alloc] init] Superficial:YES];
 
        
        
        UINavigationController *navVC = (UINavigationController *)del.window.rootViewController;
        [navVC pushViewController:TasksViewControllerObject animated:YES];
        [navVC pushViewController:SearchTasksViewControllerObject animated:YES];
        
        return YES;
        
        /*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
        
        
        
        
    } else if ([shortcutItem.type isEqualToString:[devIdent stringByAppendingString:@"MultiAddChore"]] ||
               [shortcutItem.type isEqualToString:[devIdent stringByAppendingString:@"MultiAddExpense"]] ||
               [shortcutItem.type isEqualToString:[devIdent stringByAppendingString:@"MultiAddList"]]) {
        
        
        
        
        
//        [[NSUserDefaults standardUserDefaults] setObject:[shortcutItem.type isEqualToString:[devIdent stringByAppendingString:@"MultiAddExpense"]] ? @"Yes" : @"No" forKey:@"ViewingExpenses"];
//        [[NSUserDefaults standardUserDefaults] setObject:[shortcutItem.type isEqualToString:[devIdent stringByAppendingString:@"MultiAddList"]] ? @"Yes" : @"No" forKey:@"ViewingLists"];
//        [[NSUserDefaults standardUserDefaults] setObject:[shortcutItem.type isEqualToString:[devIdent stringByAppendingString:@"MultiAddListGroupChat"]] ? @"Yes" : @"No" forKey:@"ViewingChats"];
//
//
//
//        MultiAddTasksViewController *multiAddTaskViewControllerObject = [storyBoard instantiateViewControllerWithIdentifier:@"MultiAddTasksViewController"];
//        TasksViewController *TasksViewControllerObject = [storyBoard instantiateViewControllerWithIdentifier:@"TasksViewController"];
//
//        NSDictionary *dict = [NSDictionary dictionary];
//
//
//
//        NSString *key = @"";
//
//        if ([shortcutItem.type isEqualToString:[devIdent stringByAppendingString:@"MultiAddChore"]]) {
//            key = @"ShortcutMultiAddChore";
//        } else if ([shortcutItem.type isEqualToString:[devIdent stringByAppendingString:@"MultiAddExpense"]]) {
//            key = @"ShortcutMultiAddExpense";
//        } else if ([shortcutItem.type isEqualToString:[devIdent stringByAppendingString:@"MultiAddList"]]) {
//            key = @"ShortcutMultiAddList";
//        }
//
//        dict = [[NSUserDefaults standardUserDefaults] objectForKey:key];
//
//
//
//        NSString *defaultTaskListName = dict[@"defaultTaskListName"] ? dict[@"defaultTaskListName"] : @"No List";
//
//        NSMutableDictionary *notificationSettingsDict = dict[@"notificationSettingsDict"] ? dict[@"notificationSettingsDict"] : [NSMutableDictionary dictionary];
//
//        NSMutableArray *homeMembersArray = dict[@"homeMembersArray"] ? dict[@"homeMembersArray"] : [NSMutableArray array];
//        NSMutableArray *itemNamesAlreadyUsed = dict[@"itemNamesAlreadyUsed"] ? dict[@"itemNamesAlreadyUsed"] : [NSMutableArray array];
//        NSMutableArray *allItemAssignedToArrays = dict[@"allItemAssignedToArrays"] ? dict[@"allItemAssignedToArrays"] : [NSMutableArray array];
//        NSMutableArray *allItemTagsArrays = dict[@"allItemTagsArrays"] ? dict[@"allItemTagsArrays"] : [NSMutableArray array];
//
//        NSMutableDictionary *homeMembersDict = dict[@"homeMembersDict"] ? dict[@"homeMembersDict"] : [NSMutableDictionary dictionary];
//        NSMutableDictionary *folderDict = dict[@"folderDict"] ? dict[@"folderDict"] : [NSMutableDictionary dictionary];
//        NSMutableDictionary *taskListDict = dict[@"taskListDict"] ? dict[@"taskListDict"] : [NSMutableDictionary dictionary];
//        NSMutableDictionary *sectionDict = dict[@"sectionDict"] ? dict[@"sectionDict"] : [NSMutableDictionary dictionary];
//        NSMutableDictionary *templateDict = dict[@"templateDict"] ? dict[@"templateDict"] : [NSMutableDictionary dictionary];
//
//
//
//        multiAddTaskViewControllerObject.defaultTaskListName = dict[@"defaultTaskListName"] ? dict[@"defaultTaskListName"] : @"No List";
//
//        multiAddTaskViewControllerObject.itemSelectedDict = dict[@"itemSelectedDict"] ? dict[@"itemSelectedDict"] : [NSMutableDictionary dictionary];
//        multiAddTaskViewControllerObject.homeMembersDict = dict[@"homeMembersDict"] ? dict[@"homeMembersDict"] : [NSMutableDictionary dictionary];
//        multiAddTaskViewControllerObject.notificationSettingsDict = dict[@"notificationSettingsDict"] ? dict[@"notificationSettingsDict"] : [NSMutableDictionary dictionary];
//        multiAddTaskViewControllerObject.folderDict = dict[@"folderDict"] ? dict[@"folderDict"] : [NSMutableDictionary dictionary];
//        multiAddTaskViewControllerObject.taskListDict = dict[@"taskListDict"] ? dict[@"taskListDict"] : [NSMutableDictionary dictionary];
//        multiAddTaskViewControllerObject.sectionDict = dict[@"sectionDict"] ? dict[@"sectionDict"] : [NSMutableDictionary dictionary];
//        multiAddTaskViewControllerObject.templateDict = dict[@"templateDict"] ? dict[@"templateDict"] : [NSMutableDictionary dictionary];
//
//        multiAddTaskViewControllerObject.homeMembersArray = dict[@"homeMembersArray"] ? dict[@"homeMembersArray"] : [NSMutableArray array];
//        multiAddTaskViewControllerObject.itemNamesAlreadyUsed = dict[@"itemNamesAlreadyUsed"] ? dict[@"itemNamesAlreadyUsed"] : [NSMutableArray array];
//        multiAddTaskViewControllerObject.allItemAssignedToArrays = dict[@"allItemAssignedToArrays"] ? dict[@"allItemAssignedToArrays"] : [NSMutableArray array];
//        multiAddTaskViewControllerObject.allItemTagsArrays = dict[@"allItemTagsArrays"] ? dict[@"allItemTagsArrays"] : [NSMutableArray array];
//
//
//
//        [[[PushObject alloc] init] PushToMultiAddTasksViewController:NO itemDictFromPreviousPage:[NSMutableDictionary dictionary] itemDictKeysFromPreviousPage:[NSMutableDictionary dictionary] itemSelectedDict:[NSMutableDictionary dictionary] homeMembersDict:homeMembersDict notificationSettingsDict:notificationSettingsDict folderDict:folderDict taskListDict:taskListDict sectionDict:sectionDict templateDict:templateDict draftDict:[NSMutableDictionary dictionary] homeMembersArray:homeMembersArray itemNamesAlreadyUsed:itemNamesAlreadyUsed allItemAssignedToArrays:allItemAssignedToArrays allItemTagsArrays:allItemTagsArrays allItemIDsArrays:nil defaultTaskListName:defaultTaskListName currentViewController:[[UIViewController alloc] init] Superficial:YES];
//
//
//
//        UINavigationController *navVC = (UINavigationController *)del.window.rootViewController;
//        [navVC pushViewController:TasksViewControllerObject animated:YES];
//        [navVC pushViewController:multiAddTaskViewControllerObject animated:YES];
        
        return YES;
        
        /*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
        
        
        
        
    } else if ([shortcutItem.type isEqualToString:[devIdent stringByAppendingString:@"AddChore"]] ||
               [shortcutItem.type isEqualToString:[devIdent stringByAppendingString:@"AddExpense"]] ||
               [shortcutItem.type isEqualToString:[devIdent stringByAppendingString:@"AddList"]]) {
        
        
        
        
        [[NSUserDefaults standardUserDefaults] setObject:[shortcutItem.type isEqualToString:[devIdent stringByAppendingString:@"AddExpense"]] ? @"Yes" : @"No" forKey:@"ViewingExpenses"];
        [[NSUserDefaults standardUserDefaults] setObject:[shortcutItem.type isEqualToString:[devIdent stringByAppendingString:@"AddList"]] ? @"Yes" : @"No" forKey:@"ViewingLists"];
        [[NSUserDefaults standardUserDefaults] setObject:[shortcutItem.type isEqualToString:[devIdent stringByAppendingString:@"AddGroupChats"]] ? @"Yes" : @"No" forKey:@"ViewingChats"];



        AddTaskViewController *addTaskViewControllerObject = [storyBoard instantiateViewControllerWithIdentifier:@"AddTaskViewController"];

        NSDictionary *dict = [NSDictionary dictionary];



        NSString *key = @"";

        if ([shortcutItem.type isEqualToString:[devIdent stringByAppendingString:@"AddChore"]]) {
            key = @"ShortcutAddChore";
        } else if ([shortcutItem.type isEqualToString:[devIdent stringByAppendingString:@"AddExpense"]]) {
            key = @"ShortcutAddExpense";
        } else if ([shortcutItem.type isEqualToString:[devIdent stringByAppendingString:@"AddList"]]) {
            key = @"ShortcutAddList";
        }

        dict = [[NSUserDefaults standardUserDefaults] objectForKey:key];
        
        
        
        BOOL ExpandedAddingViewSelected = [[NSUserDefaults standardUserDefaults] objectForKey:@"AddingViewDefault"] && [[[NSUserDefaults standardUserDefaults] objectForKey:@"AddingViewDefault"] isEqualToString:@"Yes"];
        
        
        
        if (ExpandedAddingViewSelected) {
            
            NSString *homeID = dict[@"homeID"] ? dict[@"homeID"] : @"xxx";
            NSString *defaultTaskListName = dict[@"defaultTaskListName"] ? dict[@"defaultTaskListName"] : @"No List";
            
            NSMutableDictionary *notificationSettingsDict = dict[@"notificationSettingsDict"] ? dict[@"notificationSettingsDict"] : [NSMutableDictionary dictionary];
            NSMutableDictionary *topicDict = dict[@"topicDict"] ? dict[@"topicDict"] : [NSMutableDictionary dictionary];
            
            NSMutableArray *homeMembersArray = dict[@"homeMembersArray"] ? dict[@"homeMembersArray"] : [NSMutableArray array];
            NSMutableArray *allItemAssignedToArrays = dict[@"allItemAssignedToArrays"] ? dict[@"allItemAssignedToArrays"] : [NSMutableArray array];
            NSMutableArray *allItemIDsArrays = dict[@"allItemIDsArrays"] ? dict[@"allItemIDsArrays"] : [NSMutableArray array];
            NSMutableArray *allItemTagsArrays = dict[@"allItemTagsArrays"] ? dict[@"allItemTagsArrays"] : [NSMutableArray array];
            
            NSMutableDictionary *homeMembersDict = dict[@"homeMembersDict"] ? dict[@"homeMembersDict"] : [NSMutableDictionary dictionary];
            NSMutableDictionary *itemOccurrencesDict = dict[@"itemOccurrencesDict"] ? dict[@"itemOccurrencesDict"] : [NSMutableDictionary dictionary];
            NSMutableDictionary *folderDict = dict[@"folderDict"] ? dict[@"folderDict"] : [NSMutableDictionary dictionary];
            NSMutableDictionary *taskListDict = dict[@"taskListDict"] ? dict[@"taskListDict"] : [NSMutableDictionary dictionary];
            NSMutableDictionary *templateDict = dict[@"templateDict"] ? dict[@"templateDict"] : [NSMutableDictionary dictionary];
            NSMutableDictionary *draftDict = dict[@"draftDict"] ? dict[@"draftDict"] : [NSMutableDictionary dictionary];
            
            BOOL partiallyAddedTask = dict[@"partiallyAddedTask"] && [dict[@"partiallyAddedTask"] isEqualToString:@"Yes"] ? YES : NO;
            BOOL addingTask = dict[@"addingTask"] && [dict[@"addingTask"] isEqualToString:@"Yes"] ? YES : NO;
            BOOL addingMultipleTasks = dict[@"addingMultipleTasks"] && [dict[@"addingMultipleTasks"] isEqualToString:@"Yes"] ? YES : NO;
            BOOL addingSuggestedTask = dict[@"addingSuggestedTask"] && [dict[@"addingSuggestedTask"] isEqualToString:@"Yes"] ? YES : NO;
            BOOL editingTask = dict[@"editingTask"] && [dict[@"editingTask"] isEqualToString:@"Yes"] ? YES : NO;
            BOOL viewingTask = dict[@"viewingTask"] && [dict[@"viewingTask"] isEqualToString:@"Yes"] ? YES : NO;
            BOOL viewingMoreOptions = dict[@"viewingMoreOptions"] && [dict[@"viewingMoreOptions"] isEqualToString:@"Yes"] ? YES : NO;
            BOOL duplicatingTask = dict[@"duplicatingTask"] && [dict[@"duplicatingTask"] isEqualToString:@"Yes"] ? YES : NO;
            BOOL editingTemplate = dict[@"editingTemplate"] && [dict[@"editingTemplate"] isEqualToString:@"Yes"] ? YES : NO;
            BOOL viewingTemplate = dict[@"viewingTemplate"] && [dict[@"viewingTemplate"] isEqualToString:@"Yes"] ? YES : NO;
            BOOL editingDraft = dict[@"editingDraft"] && [dict[@"editingDraft"] isEqualToString:@"Yes"] ? YES : NO;
            BOOL viewingDraft = dict[@"viewingDraft"] && [dict[@"viewingDraft"] isEqualToString:@"Yes"] ? YES : NO;
            
            
            
            addTaskViewControllerObject.homeID = dict[@"homeID"] ? dict[@"homeID"] : @"xxx";
            addTaskViewControllerObject.defaultTaskListName = dict[@"defaultTaskListName"] ? dict[@"defaultTaskListName"] : @"No List";
            
            addTaskViewControllerObject.homeMembersArray = dict[@"homeMembersArray"] ? dict[@"homeMembersArray"] : [NSMutableArray array];
            addTaskViewControllerObject.allItemAssignedToArrays = dict[@"allItemAssignedToArrays"] ? dict[@"allItemAssignedToArrays"] : [NSMutableArray array];
            addTaskViewControllerObject.allItemIDsArrays = dict[@"allItemIDsArrays"] ? dict[@"allItemIDsArrays"] : [NSMutableArray array];
            addTaskViewControllerObject.allItemTagsArrays = dict[@"allItemTagsArrays"] ? dict[@"allItemTagsArrays"] : [NSMutableArray array];
            
            addTaskViewControllerObject.homeMembersDict = dict[@"homeMembersDict"] ? dict[@"homeMembersDict"] : [NSMutableDictionary dictionary];
            addTaskViewControllerObject.itemOccurrencesDict = dict[@"itemOccurrencesDict"] ? dict[@"itemOccurrencesDict"] : [NSMutableDictionary dictionary];
            addTaskViewControllerObject.folderDict = dict[@"folderDict"] ? dict[@"folderDict"] : [NSMutableDictionary dictionary];
            addTaskViewControllerObject.taskListDict = dict[@"taskListDict"] ? dict[@"taskListDict"] : [NSMutableDictionary dictionary];
            addTaskViewControllerObject.templateDict = dict[@"templateDict"] ? dict[@"templateDict"] : [NSMutableDictionary dictionary];
            
            addTaskViewControllerObject.itemToEditDict = dict[@"itemToEditDict"] ? dict[@"itemToEditDict"] : [NSMutableDictionary dictionary];
            addTaskViewControllerObject.templateToEditDict = dict[@"templateToEditDict"] ? dict[@"templateToEditDict"] : [NSMutableDictionary dictionary];
            addTaskViewControllerObject.moreOptionsDict = dict[@"moreOptionsDict"] ? dict[@"moreOptionsDict"] : [NSMutableDictionary dictionary];
            addTaskViewControllerObject.multiAddDict = dict[@"multiAddDict"] ? dict[@"multiAddDict"] : [NSMutableDictionary dictionary];
            addTaskViewControllerObject.notificationSettingsDict = dict[@"notificationSettingsDict"] ? dict[@"notificationSettingsDict"] : [NSMutableDictionary dictionary];
            addTaskViewControllerObject.topicDict = dict[@"topicDict"] ? dict[@"topicDict"] : [NSMutableDictionary dictionary];
            addTaskViewControllerObject.draftDict = dict[@"draftDict"] ? dict[@"draftDict"] : [NSMutableDictionary dictionary];
            
            addTaskViewControllerObject.viewingAddExpenseViewController = [[[[GeneralObject alloc] init] GenerateItemType] isEqualToString:@"Expense"] ? YES : NO;
            addTaskViewControllerObject.viewingAddListViewController = [[[[GeneralObject alloc] init] GenerateItemType] isEqualToString:@"List"] ? YES : NO;
            
            addTaskViewControllerObject.partiallyAddedTask = dict[@"partiallyAddedTask"] && [dict[@"partiallyAddedTask"] isEqualToString:@"Yes"] ? YES : NO;
            addTaskViewControllerObject.addingTask = dict[@"addingTask"] && [dict[@"addingTask"] isEqualToString:@"Yes"] ? YES : NO;
            addTaskViewControllerObject.addingMultipleTasks = dict[@"addingMultipleTasks"] && [dict[@"addingMultipleTasks"] isEqualToString:@"Yes"] ? YES : NO;
            addTaskViewControllerObject.addingSuggestedTask = dict[@"addingSuggestedTask"] && [dict[@"addingSuggestedTask"] isEqualToString:@"Yes"] ? YES : NO;
            addTaskViewControllerObject.editingTask = dict[@"editingTask"] && [dict[@"editingTask"] isEqualToString:@"Yes"] ? YES : NO;
            addTaskViewControllerObject.viewingTask = dict[@"viewingTask"] && [dict[@"viewingTask"] isEqualToString:@"Yes"] ? YES : NO;
            addTaskViewControllerObject.viewingMoreOptions = dict[@"viewingMoreOptions"] && [dict[@"viewingMoreOptions"] isEqualToString:@"Yes"] ? YES : NO;
            addTaskViewControllerObject.duplicatingTask = dict[@"duplicatingTask"] && [dict[@"duplicatingTask"] isEqualToString:@"Yes"] ? YES : NO;
            addTaskViewControllerObject.editingTemplate = dict[@"editingTemplate"] && [dict[@"editingTemplate"] isEqualToString:@"Yes"] ? YES : NO;
            addTaskViewControllerObject.viewingTemplate = dict[@"viewingTemplate"] && [dict[@"viewingTemplate"] isEqualToString:@"Yes"] ? YES : NO;
            addTaskViewControllerObject.editingDraft = dict[@"editingDraft"] && [dict[@"editingDraft"] isEqualToString:@"Yes"] ? YES : NO;
            addTaskViewControllerObject.viewingDraft = dict[@"viewingDraft"] && [dict[@"viewingDraft"] isEqualToString:@"Yes"] ? YES : NO;
            
            
            
            [[[PushObject alloc] init] PushToAddTaskViewController:nil partiallyAddedDict:nil suggestedItemToAddDict:nil templateToEditDict:nil draftToEditDict:nil moreOptionsDict:nil multiAddDict:nil notificationSettingsDict:notificationSettingsDict topicDict:topicDict homeID:homeID homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict itemOccurrencesDict:itemOccurrencesDict folderDict:folderDict taskListDict:taskListDict templateDict:templateDict draftDict:draftDict allItemAssignedToArrays:allItemAssignedToArrays allItemTagsArrays:allItemTagsArrays allItemIDsArrays:allItemIDsArrays defaultTaskListName:defaultTaskListName partiallyAddedTask:partiallyAddedTask addingTask:addingTask addingMultipleTasks:addingMultipleTasks addingSuggestedTask:addingSuggestedTask editingTask:editingTask viewingTask:viewingTask viewingMoreOptions:viewingMoreOptions duplicatingTask:duplicatingTask editingTemplate:editingTemplate viewingTemplate:viewingTemplate editingDraft:editingDraft viewingDraft:viewingDraft currentViewController:[[UIViewController alloc] init] Superficial:YES];
            
        } else {
            
            [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"ShortcutAddItem"];
            
        }
        
        
        
        
        UINavigationController *navVC = (UINavigationController *)del.window.rootViewController;
       
        if ([shortcutItem.type isEqualToString:[devIdent stringByAppendingString:@"AddChore"]] ||
            [shortcutItem.type isEqualToString:[devIdent stringByAppendingString:@"AddExpense"]] ||
            [shortcutItem.type isEqualToString:[devIdent stringByAppendingString:@"AddList"]]) {
            TasksViewController *TasksViewControllerObject = [storyBoard instantiateViewControllerWithIdentifier:@"TasksViewController"];
            [navVC pushViewController:TasksViewControllerObject animated:YES];
        }
      
        if (ExpandedAddingViewSelected) { [navVC pushViewController:addTaskViewControllerObject animated:YES]; }
        
        return YES;
        
        /*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
        
        
        
        
    } else if ([shortcutItem.type isEqualToString:[devIdent stringByAppendingString:@"ViewChore"]] ||
               [shortcutItem.type isEqualToString:[devIdent stringByAppendingString:@"ViewExpense"]] ||
               [shortcutItem.type isEqualToString:[devIdent stringByAppendingString:@"ViewList"]]) {
        
        
        
        
        [[NSUserDefaults standardUserDefaults] setObject:[shortcutItem.type isEqualToString:[devIdent stringByAppendingString:@"ViewExpense"]] ? @"Yes" : @"No" forKey:@"ViewingExpenses"];
        [[NSUserDefaults standardUserDefaults] setObject:[shortcutItem.type isEqualToString:[devIdent stringByAppendingString:@"ViewList"]] ? @"Yes" : @"No" forKey:@"ViewingLists"];
        [[NSUserDefaults standardUserDefaults] setObject:[shortcutItem.type isEqualToString:[devIdent stringByAppendingString:@"ViewChats"]] ? @"Yes" : @"No" forKey:@"ViewingChats"];
        
        if ([shortcutItem.type isEqualToString:[devIdent stringByAppendingString:@"ViewChats"]]) {
            
            [self SetUpRootViewControllerHandleShortcuts:isSimulator viewControllerIdentifier:@"ChatsViewController"];
            
        } else {
            
            [self SetUpRootViewControllerHandleShortcuts:isSimulator viewControllerIdentifier:@"TasksNavigationController"];
            
        }
        
        return YES;
        
        /*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
        
        
        
        
    } else if ([shortcutItem.localizedTitle containsString:@"📁 "]) {
        
        
        
        
        NSString *categorySelected = @"📁 All";
        
        NSString *separateString = @"📁 ";

        if ([shortcutItem.localizedTitle containsString:separateString]) {
            if ([shortcutItem.localizedTitle componentsSeparatedByString:separateString]) {
                if ([[shortcutItem.localizedTitle componentsSeparatedByString:separateString] count] > 1) {
                    categorySelected = [shortcutItem.localizedTitle componentsSeparatedByString:separateString][1];
                }
            }
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:categorySelected forKey:@"CategorySelected"];
        
        [self SetUpRootViewControllerHandleShortcuts:isSimulator viewControllerIdentifier:@"TasksNavigationController"];
        
        return YES;
        
        /*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
        
        
        
        
    } else if ([shortcutItem.localizedTitle containsString:@"View Chore:"] ||
               [shortcutItem.localizedTitle containsString:@"View Expense:"] ||
               [shortcutItem.localizedTitle containsString:@"View List:"]) {
        
        [[NSUserDefaults standardUserDefaults] setObject:[shortcutItem.type isEqualToString:[devIdent stringByAppendingString:@"ViewExpense"]] ? @"Yes" : @"No" forKey:@"ViewingExpenses"];
        [[NSUserDefaults standardUserDefaults] setObject:[shortcutItem.type isEqualToString:[devIdent stringByAppendingString:@"ViewList"]] ? @"Yes" : @"No" forKey:@"ViewingLists"];
        [[NSUserDefaults standardUserDefaults] setObject:[shortcutItem.type isEqualToString:[devIdent stringByAppendingString:@"ViewChats"]] ? @"Yes" : @"No" forKey:@"ViewingChats"];
        
        
        
        ViewTaskViewController *viewTaskViewControllerObject = [storyBoard instantiateViewControllerWithIdentifier:@"ViewTaskViewController"];
      
        NSDictionary *dict = [NSDictionary dictionary];
        
        
        
        NSString *key = @"";
        
        if ([shortcutItem.type isEqualToString:[devIdent stringByAppendingString:@"ViewChore"]]) {
            key = @"ShortcutViewChore";
        } else if ([shortcutItem.type isEqualToString:[devIdent stringByAppendingString:@"ViewExpense"]]) {
            key = @"ShortcutViewExpense";
        } else if ([shortcutItem.type isEqualToString:[devIdent stringByAppendingString:@"ViewList"]]) {
            key = @"ShortcutViewList";
        }
        
        dict = [[NSUserDefaults standardUserDefaults] objectForKey:key];
        
        
        
        NSString *itemID = dict[@"itemID"] ? dict[@"itemID"] : @"";
        NSString *itemOccurrenceID = dict[@"itemOccurrenceID"] ? dict[@"itemOccurrenceID"] : @"";
        
        NSMutableDictionary *notificationSettingsDict = dict[@"notificationSettingsDict"] ? dict[@"notificationSettingsDict"] : [NSMutableDictionary dictionary];
        NSMutableDictionary *topicDict = dict[@"topicDict"] ? dict[@"topicDict"] : [NSMutableDictionary dictionary];
        
        NSMutableArray *homeMembersArray = dict[@"homeMembersArray"] ? dict[@"homeMembersArray"] : [NSMutableArray array];
        NSMutableArray *itemNamesAlreadyUsed = dict[@"itemNamesAlreadyUsed"] ? dict[@"itemNamesAlreadyUsed"] : [NSMutableArray array];
        NSMutableArray *allItemAssignedToArrays = dict[@"allItemAssignedToArrays"] ? dict[@"allItemAssignedToArrays"] : [NSMutableArray array];
        NSMutableArray *allItemIDsArrays = dict[@"allItemIDsArrays"] ? dict[@"allItemIDsArrays"] : [NSMutableArray array];
        NSMutableArray *allItemTagsArrays = dict[@"allItemTagsArrays"] ? dict[@"allItemTagsArrays"] : [NSMutableArray array];
        
        NSMutableDictionary *homeMembersDict = dict[@"homeMembersDict"] ? dict[@"homeMembersDict"] : [NSMutableDictionary dictionary];
        NSMutableDictionary *itemOccurrencesDict = dict[@"itemOccurrencesDict"] ? dict[@"itemOccurrencesDict"] : [NSMutableDictionary dictionary];
        NSMutableDictionary *folderDict = dict[@"folderDict"] ? dict[@"folderDict"] : [NSMutableDictionary dictionary];
        NSMutableDictionary *taskListDict = dict[@"taskListDict"] ? dict[@"taskListDict"] : [NSMutableDictionary dictionary];
        NSMutableDictionary *templateDict = dict[@"templateDict"] ? dict[@"templateDict"] : [NSMutableDictionary dictionary];
        NSMutableDictionary *draftDict = dict[@"draftDict"] ? dict[@"draftDict"] : [NSMutableDictionary dictionary];
        
        
        
        viewTaskViewControllerObject.itemID = dict[@"itemID"] ? dict[@"itemID"] : @"";
        viewTaskViewControllerObject.itemOccurrenceID = dict[@"itemOccurrenceID"] ? dict[@"itemOccurrenceID"] : @"";
        
        viewTaskViewControllerObject.homeMembersArray = dict[@"homeMembersArray"] ? dict[@"homeMembersArray"] : [NSMutableArray array];
        viewTaskViewControllerObject.itemNamesAlreadyUsed = dict[@"itemNamesAlreadyUsed"] ? dict[@"itemNamesAlreadyUsed"] : [NSMutableArray array];
        viewTaskViewControllerObject.allItemAssignedToArrays = dict[@"allItemAssignedToArrays"] ? dict[@"allItemAssignedToArrays"] : [NSMutableArray array];
        viewTaskViewControllerObject.allItemTagsArrays = dict[@"allItemTagsArrays"] ? dict[@"allItemTagsArrays"] : [NSMutableArray array];
        
        viewTaskViewControllerObject.notificationSettingsDict = dict[@"notificationSettingsDict"] ? dict[@"notificationSettingsDict"] : [NSMutableDictionary dictionary];
        viewTaskViewControllerObject.topicDict = dict[@"topicDict"] ? dict[@"topicDict"] : [NSMutableDictionary dictionary];
        viewTaskViewControllerObject.homeMembersDict = dict[@"homeMembersDict"] ? dict[@"homeMembersDict"] : [NSMutableDictionary dictionary];
        viewTaskViewControllerObject.folderDict = dict[@"folderDict"] ? dict[@"folderDict"] : [NSMutableDictionary dictionary];
        viewTaskViewControllerObject.taskListDict = dict[@"taskListDict"] ? dict[@"taskListDict"] : [NSMutableDictionary dictionary];
        viewTaskViewControllerObject.templateDict = dict[@"templateDict"] ? dict[@"templateDict"] : [NSMutableDictionary dictionary];
        
        viewTaskViewControllerObject.viewingOccurrence = itemOccurrenceID != nil && itemOccurrenceID != NULL && itemOccurrenceID.length > 0 ? YES : NO;
        
        viewTaskViewControllerObject.viewingViewExpenseViewController = [[[[GeneralObject alloc] init] GenerateItemType] isEqualToString:@"Expense"] ? YES : NO;
        viewTaskViewControllerObject.viewingViewListViewController = [[[[GeneralObject alloc] init] GenerateItemType] isEqualToString:@"List"] ? YES : NO;
        
        
        
        [[[PushObject alloc] init] PushToViewTaskViewController:itemID itemOccurrenceID:itemOccurrenceID itemDictFromPreviousPage:[NSMutableDictionary dictionary] homeMembersArray:homeMembersArray homeMembersDict:homeMembersDict itemOccurrencesDict:itemOccurrencesDict folderDict:folderDict taskListDict:taskListDict templateDict:templateDict draftDict:draftDict notificationSettingsDict:notificationSettingsDict topicDict:topicDict itemNamesAlreadyUsed:itemNamesAlreadyUsed allItemAssignedToArrays:allItemAssignedToArrays allItemTagsArrays:allItemTagsArrays allItemIDsArrays:allItemIDsArrays currentViewController:[[UIViewController alloc] init] Superficial:YES];
        
        
        
        UINavigationController *navVC = (UINavigationController *)del.window.rootViewController;
      
        if ([shortcutItem.type isEqualToString:[devIdent stringByAppendingString:@"ViewChore"]] ||
            [shortcutItem.type isEqualToString:[devIdent stringByAppendingString:@"ViewExpense"]] ||
            [shortcutItem.type isEqualToString:[devIdent stringByAppendingString:@"ViewList"]]) {
            TasksViewController *TasksViewControllerObject = [storyBoard instantiateViewControllerWithIdentifier:@"TasksViewController"];
            [navVC pushViewController:TasksViewControllerObject animated:YES];
        }

        [navVC pushViewController:viewTaskViewControllerObject animated:YES];
        
        return YES;
        
        /*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
        
        
        
        
    } else if ([shortcutItem.localizedTitle containsString:@"🏷️ #"] ||
               [shortcutItem.localizedTitle containsString:@"👤 "] ||
               [shortcutItem.localizedTitle containsString:@"🖍️ "] ||
               [shortcutItem.localizedTitle containsString:@"🗄️ "]) {
        
        
        
        
        NSString *categorySelected = @"📁 All";
        
        NSString *separateString = @"";
        
        if ([shortcutItem.localizedTitle containsString:@"🏷️ #"]) {
            separateString = @"🏷️ #";
        } else if ([shortcutItem.localizedTitle containsString:@"👤 "]) {
            separateString = @"👤 ";
        } else if ([shortcutItem.localizedTitle containsString:@"🖍️ "]) {
            separateString = @"🖍️ ";
        } else if ([shortcutItem.localizedTitle containsString:@"🗄️ "]) {
            separateString = @"🗄️ ";
        }
        
        if ([shortcutItem.localizedTitle containsString:separateString]) {
            if ([shortcutItem.localizedTitle componentsSeparatedByString:separateString]) {
                if ([[shortcutItem.localizedTitle componentsSeparatedByString:separateString] count] > 1) {
                    categorySelected = [shortcutItem.localizedTitle componentsSeparatedByString:separateString][1];
                }
            }
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:categorySelected forKey:@"CategorySelected"];
        
        [self SetUpRootViewControllerHandleShortcuts:isSimulator viewControllerIdentifier:@"TasksNavigationController"];
        
        return YES;
        
        /*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
        
        
        
        
    } else if ([shortcutItem.type containsString:[devIdent stringByAppendingString:@"WeDivvyPremium"]]) {
        
        
        
        
        WeDivvyPremiumViewController *weDivvyPremiumViewControllerObject = [storyBoard instantiateViewControllerWithIdentifier:@"WeDivvyPremiumViewController"];
        HomesViewController *viewControllerObject = [storyBoard instantiateViewControllerWithIdentifier:@"HomesViewController"];
        
        
        
        BOOL UserIsLoggedInButHomeHasNotBeenChosen = ([[NSUserDefaults standardUserDefaults] objectForKey:@"UsersUserID"] && ([[[NSUserDefaults standardUserDefaults] objectForKey:@"UserHasLoggedIn"] isEqualToString:@"Yes"]) && (![[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"]) && (![[NSUserDefaults standardUserDefaults] objectForKey:@"UpdateEmail"]));
        BOOL UserIsLoggedInAndHasChosenAHome = ([[NSUserDefaults standardUserDefaults] objectForKey:@"HomeChosen"]);
        
        if (UserIsLoggedInButHomeHasNotBeenChosen == YES) {
            
            viewControllerObject = [storyBoard instantiateViewControllerWithIdentifier:@"HomesViewController"];
            
        } else if (UserIsLoggedInAndHasChosenAHome == YES) {
            
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"ViewingChats"] isEqualToString:@"Yes"]) {
                
                viewControllerObject = [storyBoard instantiateViewControllerWithIdentifier:@"ChatsViewController"];
                
            } else {
                
                viewControllerObject = [storyBoard instantiateViewControllerWithIdentifier:@"TasksViewController"];
                
            }
            
        } else {
            
            viewControllerObject = [storyBoard instantiateViewControllerWithIdentifier:@"InitialViewController"];
            
        }
        
        weDivvyPremiumViewControllerObject.selectedSlide = @"Custom Shortcuts";
        weDivvyPremiumViewControllerObject.viewingSlideShow = YES;
        
        
        
        UINavigationController *navVC = (UINavigationController *)del.window.rootViewController;
        [navVC pushViewController:viewControllerObject animated:YES];
        [navVC pushViewController:weDivvyPremiumViewControllerObject animated:YES];
        
        return YES;
        
        
        
        
    } else if ([shortcutItem.type containsString:[devIdent stringByAppendingString:@"AnythingWrong"]]) {
        
        
        
        
        [self SetUpRootViewControllerHandleShortcuts:isSimulator viewControllerIdentifier:@"TasksNavigationController"];
        
        return YES;
        
        
        
        
    }
    
    return NO;
}

@end
