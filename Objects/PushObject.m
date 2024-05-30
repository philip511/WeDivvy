//
//  PushObject.m
//  WeDivvy
//
//  Created by Philip Nagel on 9/14/21.
//

#import "AppDelegate.h"
#import "PushObject.h"
#import "GeneralObject.h"

#import "ChatsViewController.h"
#import "AddChatNavigationController.h"
#import "MasterLiveChatViewController.h"
#import "LiveChatNavigationController.h"

#import "ForumViewController.h"
#import "AddForumViewController.h"

#import "HomeNavigationController.h"
#import "HomeMembersViewController.h"
#import "CreateHomeViewController.h"

#import "InitialNavigationViewController.h"
#import "LoginViewController.h"
#import "SignUpViewController.h"
#import "EnableNotificationsViewController.h"
#import "InviteMembersViewController.h"
#import "HomeFeaturesViewController.h"

#import "NotificationsViewController.h"

#import "SettingsViewController.h"
#import "UpdateEmailViewController.h"
#import "BillingViewController.h"
#import "NotificationSettingsNavigationController.h"
#import "FAQViewController.h"

#import "TasksNavigationController.h"

#import "SearchTasksNavigationController.h"

#import "WeDivvyPremiumNavigationController.h"

#import "ProfileViewController.h"
#import "EditProfileViewController.h"

#import "MultiAddTasksNavigationController.h"
#import "AddTaskNavigationController.h"
#import "ViewTaskNavigationController.h"

#import "ViewPromoCodeNavigationController.h"
#import "ViewCalendarNavigationController.h"
#import "ViewActivityNavigationController.h"
#import "ViewTaskListsNavigationController.h"
#import "ViewMutableOptionsNavigationController.h"
#import "ViewAssignedToNavigationController.h"
#import "ViewOptionsNavigationController.h"
#import "ViewAddItemsNavigationController.h"
#import "ViewCostPerPersonNavigationController.h"
#import "ViewPaymentMethodNavigationController.h"
#import "ViewPaymentsNavigationController.h"
#import "ViewTagsNavigationController.h"
#import "ViewRemindersNavigationController.h"
#import "ViewImageNavigationController.h"
#import "ViewVideoNavigationController.h"

#import "NotificationsObject.h"

@implementation PushObject

#pragma mark - Chats

-(void)PushToChatsViewController:(UIViewController *)currentViewController {
    
    ChatsViewController *viewControllerObject = [currentViewController.storyboard instantiateViewControllerWithIdentifier:@"ChatsViewController"];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"ViewingChats"];
    [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"ViewingExpenses"];
    [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"ViewingLists"];
    
    [currentViewController.navigationController pushViewController:viewControllerObject animated:NO];
    
}


-(void)PushToAddChatViewController:(NSMutableDictionary  * _Nullable)itemToEditDict homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict topicDict:(NSMutableDictionary *)topicDict currentViewController:(UIViewController *)currentViewController Superficial:(BOOL)Superficial {
    
    if (Superficial) {
        return;
    }
   
    AddChatNavigationController *viewControllerObject = [currentViewController.storyboard instantiateViewControllerWithIdentifier:@"AddChatNavigationController"];
    
    viewControllerObject.modalInPresentation = true;
    
    UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"AddChatNavigationController" source:currentViewController destination:viewControllerObject];
    
    [viewControllerObject prepareForSegue:segue sender:
     
     @{@"itemToEditDict" : itemToEditDict ? itemToEditDict : [NSMutableDictionary dictionary],
       @"homeMembersDict" : homeMembersDict ? homeMembersDict : [NSMutableDictionary dictionary],
       @"notificationSettingsDict" : notificationSettingsDict ? notificationSettingsDict : [NSMutableDictionary dictionary],
       @"topicDict" : topicDict ? topicDict : [NSMutableDictionary dictionary],

       @"homeMembersArray" : homeMembersArray ? homeMembersArray : [NSMutableArray array],
     }];
    
    currentViewController.modalPresentationStyle = UIModalPresentationPopover;
    
    [currentViewController presentViewController:viewControllerObject animated:YES completion:nil];
    
}

-(void)PushToMasterLiveChatViewController:(UIViewController *)currentViewController {
    
    MasterLiveChatViewController *viewControllerObject = [currentViewController.storyboard instantiateViewControllerWithIdentifier:@"MasterLiveChatViewController"];
    
    [currentViewController.navigationController pushViewController:viewControllerObject animated:YES];
    
}

-(void)PushToLiveChatViewControllerFromGroupChatsTab:(NSString *)userID homeID:(NSString *)homeID chatID:(NSString *)chatID chatName:(NSString *)chatName chatAssignedTo:(NSMutableArray *)chatAssignedTo homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict topicDict:(NSMutableDictionary *)topicDict currentViewController:(UIViewController *)currentViewController Superficial:(BOOL)Superficial {
    
    if (Superficial) {
        return;
    }
    
    LiveChatNavigationController *viewControllerObject = [currentViewController.storyboard instantiateViewControllerWithIdentifier:@"LiveChatNavigationController"];
    
    viewControllerObject.modalInPresentation = true;
    
    UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"LiveChatNavigationController" source:currentViewController destination:viewControllerObject];
   
    [viewControllerObject prepareForSegue:segue sender:
     
     @{@"userID" : userID ? userID : @"",
       @"homeID" : homeID ? homeID : @"",
       @"chatID" : chatID ? chatID : @"",
       @"chatName" : chatName ? chatName : @"",
       
       @"homeMembersDict" : homeMembersDict ? homeMembersDict : [NSMutableDictionary dictionary],
       @"notificationSettingsDict" : notificationSettingsDict ? notificationSettingsDict : [NSMutableDictionary dictionary],
       @"topicDict" : topicDict ? topicDict : [NSMutableDictionary dictionary],
       
       @"chatAssignedTo" : chatAssignedTo ? chatAssignedTo : [NSMutableArray array],
       
       @"viewingGroupChat" : @"Yes"
     }];
    
    currentViewController.modalPresentationStyle = UIModalPresentationPopover;
   
    [currentViewController presentViewController:viewControllerObject animated:YES completion:nil];
 
}

-(void)PushToLiveChatViewControllerFromViewTaskPage:(NSString *)homeID itemID:(NSString *)itemID itemName:(NSString *)itemName itemCreatedBy:(NSString *)itemCreatedBy itemAssignedTo:(NSMutableArray *)itemAssignedTo homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict topicDict:(NSMutableDictionary *)topicDict currentViewController:(UIViewController *)currentViewController Superficial:(BOOL)Superficial {
   
    if (Superficial) {
        return;
    }
    
    LiveChatNavigationController *viewControllerObject = [currentViewController.storyboard instantiateViewControllerWithIdentifier:@"LiveChatNavigationController"];
    
    viewControllerObject.modalInPresentation = true;
    
    UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"LiveChatNavigationController" source:currentViewController destination:viewControllerObject];
    
    if ([itemAssignedTo containsObject:itemCreatedBy] == NO && itemCreatedBy != nil) {
        [itemAssignedTo addObject:itemCreatedBy];
    }
    
    [viewControllerObject prepareForSegue:segue sender:
     
     @{
       @"homeID" : homeID ? homeID : @"",
        
       @"itemID" : itemID ? itemID : @"",
       @"itemName" : itemName ? itemName : @"",
       @"itemCreatedBy" : itemCreatedBy ? itemCreatedBy : @"",
       
       @"homeMembersDict" : homeMembersDict ? homeMembersDict : [NSMutableDictionary dictionary],
       @"notificationSettingsDict" : notificationSettingsDict ? notificationSettingsDict : [NSMutableDictionary dictionary],
       @"topicDict" : topicDict ? topicDict : [NSMutableDictionary dictionary],
       
       @"itemAssignedTo" : itemAssignedTo ? itemAssignedTo : [NSMutableArray array],
       
       @"viewingComments" : @"Yes"
     }];
    
    currentViewController.modalPresentationStyle = UIModalPresentationPopover;
    
    [currentViewController presentViewController:viewControllerObject animated:YES completion:nil];

}

-(void)PushToLiveChatViewControllerFromSettingsPage:(NSString *)userID viewingLiveSupport:(BOOL)viewingLiveSupport currentViewController:(UIViewController *)currentViewController Superficial:(BOOL)Superficial {
    
    if (Superficial) {
        return;
    }
    
    LiveChatNavigationController *viewControllerObject = [currentViewController.storyboard instantiateViewControllerWithIdentifier:@"LiveChatNavigationController"];
    
    viewControllerObject.modalInPresentation = true;
    
    UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"LiveChatNavigationController" source:currentViewController destination:viewControllerObject];

    [viewControllerObject prepareForSegue:segue sender:
     
     @{@"userID" : userID ? userID : @"",

       @"viewingLiveSupport" : @"Yes"
     }];
    
    currentViewController.modalPresentationStyle = UIModalPresentationPopover;
    
    [currentViewController presentViewController:viewControllerObject animated:YES completion:nil];

}

-(void)PushToLiveChatViewControllerFromMasterLiveChat:(NSString *)userID currentViewController:(UIViewController *)currentViewController {
    
    LiveChatNavigationController *viewControllerObject = [currentViewController.storyboard instantiateViewControllerWithIdentifier:@"LiveChatNavigationController"];
    
    viewControllerObject.modalInPresentation = true;
    
    UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"LiveChatNavigationController" source:currentViewController destination:viewControllerObject];
    
    [viewControllerObject prepareForSegue:segue sender:
     
     @{@"userID" : userID ? userID : @"",
       
       @"viewingLiveSupport" : @"Yes"
     }];
    
    currentViewController.modalPresentationStyle = UIModalPresentationPopover;
    
    [currentViewController presentViewController:viewControllerObject animated:YES completion:nil];

}

#pragma mark - Forum

-(void)PushToForumViewController:(BOOL)viewingFeatureForum currentViewController:(UIViewController *)currentViewController {
    
    ForumViewController *viewControllerObject = [currentViewController.storyboard instantiateViewControllerWithIdentifier:@"ForumViewController"];
    
    viewControllerObject.viewingFeatureForum = viewingFeatureForum;
    
    [currentViewController.navigationController pushViewController:viewControllerObject animated:YES];
    
}

-(void)PushToAddForumViewController:(NSMutableDictionary * _Nullable)itemToEditDict viewingFeatureForum:(BOOL)viewingFeatureForum editingSpecificForumPost:(BOOL)editingSpecificForumPost viewingSpecificForumPost:(BOOL)viewingSpecificForumPost currentViewController:(UIViewController *)currentViewController Superficial:(BOOL)Superficial {
    
    if (Superficial) {
        return;
    }
    
    AddForumViewController *viewControllerObject = [currentViewController.storyboard instantiateViewControllerWithIdentifier:@"AddForumViewController"];
    
    viewControllerObject.itemToEditDict = itemToEditDict;
    viewControllerObject.viewingFeatureForum = viewingFeatureForum;
    viewControllerObject.editingSpecificForumPost = editingSpecificForumPost;
    viewControllerObject.viewingSpecificForumPost = viewingSpecificForumPost;
    
    [currentViewController.navigationController pushViewController:viewControllerObject animated:YES];
    
}

#pragma mark - Homes

-(void)PushToHomesViewController:(BOOL)userHasLoggedIn currentViewController:(UIViewController *)currentViewController {
    
    HomeNavigationController *viewControllerObject = [currentViewController.storyboard instantiateViewControllerWithIdentifier:@"HomeNavigationController"];
    
    viewControllerObject.modalInPresentation = true;
    
    if (userHasLoggedIn == YES) {
        [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"UserHasLoggedIn"];
    }
    
    viewControllerObject.modalPresentationStyle = UIModalPresentationFullScreen;

    [currentViewController presentViewController:viewControllerObject animated:YES completion:nil];
    
}


-(void)PushToCreateHomeViewController:(BOOL)comingFromSignUp arrayOfHomeIDsYouAreAPartOf:(NSMutableArray * _Nullable)arrayOfHomeIDsYouAreAPartOf currentViewController:(UIViewController *)currentViewController {
    
    CreateHomeViewController *viewControllerObject = [currentViewController.storyboard instantiateViewControllerWithIdentifier:@"CreateHomeViewController"];
    
    viewControllerObject.comingFromSignUp = comingFromSignUp;
    
    if (comingFromSignUp == YES) {
        [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"UserHasLoggedIn"];
        viewControllerObject.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    
    viewControllerObject.arrayOfHomeIDsYouAreAPartOf = arrayOfHomeIDsYouAreAPartOf;
    
    [currentViewController.navigationController pushViewController:viewControllerObject animated:YES];
    
}

-(void)PushToHomeMembersViewController:(NSString *)homeID homeName:(NSString *)homeName notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict topicDict:(NSMutableDictionary *)topicDict viewingHomeMembersFromHomesViewController:(BOOL)viewingHomeMembersFromHomesViewController currentViewController:(UIViewController *)currentViewController Superficial:(BOOL)Superficial {
    
    if (Superficial) {
        return;
    }
    
    HomeMembersViewController *viewControllerObject = [currentViewController.storyboard instantiateViewControllerWithIdentifier:@"HomeMembersViewController"];
    
    viewControllerObject.viewingHomeMembersFromHomesViewController = viewingHomeMembersFromHomesViewController;
    viewControllerObject.homeID = homeID;
    viewControllerObject.homeName = homeName;
    viewControllerObject.notificationSettingsDict = notificationSettingsDict;
    viewControllerObject.topicDict = topicDict;
    
    [currentViewController.navigationController pushViewController:viewControllerObject animated:YES];
    
}

#pragma mark - Login/Sign Up

-(void)PushToInitialNavigationController:(UIViewController *)currentViewController {
    
    InitialNavigationViewController* viewControllerObject = [currentViewController.storyboard instantiateViewControllerWithIdentifier:@"InitialNavigationViewController"];
    
    viewControllerObject.modalPresentationStyle = UIModalPresentationFullScreen;
    
    [currentViewController presentViewController:viewControllerObject animated:YES completion:nil];
    
}

-(void)PushToLoginViewController:(UIViewController *)currentViewController {
    
    LoginViewController *viewControllerObject = [currentViewController.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    
    viewControllerObject.modalPresentationStyle = UIModalPresentationFullScreen;
    
    [currentViewController.navigationController pushViewController:viewControllerObject animated:YES];
    
}

-(void)PushToSignUpViewController:(BOOL)ThirdPartySignup currentViewController:(UIViewController *)currentViewController {
    
    SignUpViewController *viewControllerObject = [currentViewController.storyboard instantiateViewControllerWithIdentifier:@"SignUpViewController"];
    
    viewControllerObject.ThirdPartySignup = ThirdPartySignup;
    
    viewControllerObject.modalPresentationStyle = UIModalPresentationFullScreen;
    
    [currentViewController.navigationController pushViewController:viewControllerObject animated:YES];
    
}

-(void)PushToEnableNotificationsViewController:(UIViewController *)currentViewController comingFromCreateHome:(BOOL)comingFromCreateHome clickedUnclaimedUser:(BOOL)clickedUnclaimedUser homeIDLinkedToKey:(NSString *)homeIDLinkedToKey homeKey:(NSString *)homeKey {
    
    EnableNotificationsViewController *viewControllerObject = [currentViewController.storyboard instantiateViewControllerWithIdentifier:@"EnableNotificationsViewController"];
    
    viewControllerObject.comingFromCreateHome = comingFromCreateHome;
    viewControllerObject.clickedUnclaimedUser = clickedUnclaimedUser;
    viewControllerObject.homeIDLinkedToKey = homeIDLinkedToKey;
    viewControllerObject.homeKey = homeKey;
    
    [currentViewController.navigationController pushViewController:viewControllerObject animated:YES];
    
}

-(void)PushToHomeFeaturesViewController:(UIViewController *)currentViewController comingFromSettings:(BOOL)comingFromSettings {
    
    HomeFeaturesViewController *viewControllerObject = [currentViewController.storyboard instantiateViewControllerWithIdentifier:@"HomeFeaturesViewController"];
    
    viewControllerObject.comingFromSettings = comingFromSettings;
   
    [currentViewController.navigationController pushViewController:viewControllerObject animated:YES];
    
}

-(void)PushToInviteMembersViewController:(UIViewController *)currentViewController {
    
    InviteMembersViewController* viewControllerObject = [currentViewController.storyboard instantiateViewControllerWithIdentifier:@"InviteMembersViewController"];
    
    viewControllerObject.modalPresentationStyle = UIModalPresentationFullScreen;
    
    [currentViewController.navigationController pushViewController:viewControllerObject animated:YES];
    
}

#pragma mark - Notifications / Reminders
 
-(void)PushToNotificationsViewController:(UIViewController *)currentViewController homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict topicDict:(NSMutableDictionary *)topicDict folderDict:(NSMutableDictionary *)folderDict taskListDict:(NSMutableDictionary *)taskListDict templateDict:(NSMutableDictionary *)templateDict draftDict:(NSMutableDictionary *)draftDict allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays allItemIDsArrays:(NSMutableArray * _Nullable)allItemIDsArrays {
    
    NotificationsViewController *viewControllerObject = [currentViewController.storyboard instantiateViewControllerWithIdentifier:@"NotificationsViewController"];
    
    viewControllerObject.homeMembersArray = homeMembersArray ? homeMembersArray : [NSMutableArray array];
    viewControllerObject.homeMembersDict = homeMembersDict ? homeMembersDict : [NSMutableDictionary dictionary];
    viewControllerObject.notificationSettingsDict = notificationSettingsDict ? notificationSettingsDict : [NSMutableDictionary dictionary];
    viewControllerObject.topicDict = topicDict ? topicDict : [NSMutableDictionary dictionary];
    viewControllerObject.allItemTagsArrays = allItemTagsArrays ? allItemTagsArrays : [NSMutableArray array];
    viewControllerObject.allItemIDsArrays = allItemIDsArrays ? allItemIDsArrays : [NSMutableArray array];
    
    [currentViewController.navigationController pushViewController:viewControllerObject animated:YES];
    
}

#pragma mark - Settings

-(void)PushToSettingsViewController:(BOOL)viewingPremiumSettings allItemAssignedToArrays:(NSMutableArray * _Nullable)allItemAssignedToArrays currentViewController:(UIViewController *)currentViewController {
   
    SettingsViewController *viewControllerObject = [currentViewController.storyboard instantiateViewControllerWithIdentifier:@"SettingsViewController"];
    
    viewControllerObject.viewingPremiumSettings = viewingPremiumSettings;
    viewControllerObject.allItemAssignedToArrays = allItemAssignedToArrays ? allItemAssignedToArrays : [NSMutableArray array];
    
    [currentViewController.navigationController pushViewController:viewControllerObject animated:self];
    
}

-(void)PushToUpdateEmailViewController:(UIViewController *)currentViewController {
    
    UpdateEmailViewController *viewControllerObject = [currentViewController.storyboard instantiateViewControllerWithIdentifier:@"UpdateEmailViewController"];
    
    [currentViewController.navigationController pushViewController:viewControllerObject animated:YES];
    
}

-(void)PushToBillingViewController:(UIViewController *)currentViewController {
    
    BillingViewController *viewControllerObject = [currentViewController.storyboard instantiateViewControllerWithIdentifier:@"BillingViewController"];
    
    [currentViewController.navigationController pushViewController:viewControllerObject animated:YES];
    
}

-(void)PushToNotificationSettingsViewController:(UIViewController *)currentViewController notificationSettings:(NSMutableDictionary *)notificationSettings viewingChores:(BOOL)viewingChores viewingExpenses:(BOOL)viewingExpenses viewingLists:(BOOL)viewingLists viewingGroupChats:(BOOL)viewingGroupChats viewingHomeMembers:(BOOL)viewingHomeMembers viewingForum:(BOOL)viewingForum viewingScheduledSummary:(BOOL)viewingScheduledSummary viewingScheduledSummaryTaskTypes:(BOOL)viewingScheduledSummaryTaskTypes Superficial:(BOOL)Superficial {
    
    if (Superficial) {
        return;
    }
    
    NotificationSettingsNavigationController *viewControllerObject = [currentViewController.storyboard instantiateViewControllerWithIdentifier:@"NotificationSettingsNavigationController"];
    
    viewControllerObject.modalInPresentation = true;
    
    UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"NotificationSettingsNavigationController" source:currentViewController destination:viewControllerObject];
    
    [viewControllerObject prepareForSegue:segue sender:
     
     @{@"notificationSettings" : notificationSettings ? notificationSettings : [NSMutableDictionary dictionary],
       
       @"viewingChores" : viewingChores ? @"Yes" : @"No",
       @"viewingExpenses" : viewingExpenses ? @"Yes" : @"No",
       @"viewingLists" : viewingLists ? @"Yes" : @"No",
       @"viewingGroupChats" : viewingGroupChats ? @"Yes" : @"No",
       @"viewingHomeMembers" : viewingHomeMembers ? @"Yes" : @"No",
       @"viewingForum" : viewingForum ? @"Yes" : @"No",
       @"viewingScheduledSummary" : viewingScheduledSummary ? @"Yes" : @"No",
       @"viewingScheduledSummaryTaskTypes" : viewingScheduledSummaryTaskTypes ? @"Yes" : @"No",
     }];
    
    currentViewController.modalPresentationStyle = UIModalPresentationPopover;
    
    [currentViewController presentViewController:viewControllerObject animated:YES completion:nil];
  
}

-(void)PushToFAQViewController:(UIViewController *)currentViewController {
    
    FAQViewController *viewControllerObject = [currentViewController.storyboard instantiateViewControllerWithIdentifier:@"FAQViewController"];

    [currentViewController.navigationController pushViewController:viewControllerObject animated:self];
    
}


#pragma mark - Tab Bar

-(void)PushToTasksNavigationController:(BOOL)Chores Expenses:(BOOL)Expenses Lists:(BOOL)Lists Animated:(BOOL)Animated currentViewController:(UIViewController *)currentViewController {
    
    TasksNavigationController *viewControllerObject = [currentViewController.storyboard instantiateViewControllerWithIdentifier:@"TasksNavigationController"];
    
    viewControllerObject.modalInPresentation = true;
    
    viewControllerObject.modalPresentationStyle = UIModalPresentationFullScreen;
    
    if (Chores == YES) {
        
        [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"ViewingExpenses"];
        [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"ViewingLists"];
        [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"ViewingChats"];
        
    } else if (Expenses == YES) {
        
        [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"ViewingExpenses"];
        [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"ViewingLists"];
        [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"ViewingChats"];
        
    } else if (Lists == YES) {
        
        [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"ViewingExpenses"];
        [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"ViewingLists"];
        [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"ViewingChats"];
        
    }
    
    [currentViewController presentViewController:viewControllerObject animated:Animated completion:nil];
    
}

#pragma mark - Search

-(void)PushToSearchTasksViewController:(NSMutableDictionary * _Nullable)notificationSettingsDict topicDict:(NSMutableDictionary * _Nullable)topicDict itemDict:(NSMutableDictionary *)itemDict itemDictNo2:(NSMutableDictionary *)itemDictNo2 itemDictNo3:(NSMutableDictionary *)itemDictNo3 homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays currentViewController:(UIViewController *)currentViewController Superficial:(BOOL)Superficial {
    
    if (Superficial) {
        return;
    }
    
    SearchTasksNavigationController *viewControllerObject = [currentViewController.storyboard instantiateViewControllerWithIdentifier:@"SearchTasksNavigationController"];
    
    viewControllerObject.modalInPresentation = true;
    
    UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"SearchTasksNavigationController" source:currentViewController destination:viewControllerObject];
    
    [viewControllerObject prepareForSegue:segue sender:
     
     @{@"homeMembersArray" : homeMembersArray ? homeMembersArray : [NSMutableArray array],
       @"allItemTagsArrays" : allItemTagsArrays ? allItemTagsArrays : [NSMutableArray array],
   
       @"itemDict" : itemDict ? itemDict : [NSMutableDictionary dictionary],
       @"itemDictNo2" : itemDictNo2 ? itemDictNo2 : [NSMutableDictionary dictionary],
       @"itemDictNo3" : itemDictNo3 ? itemDictNo3 : [NSMutableDictionary dictionary],
       
       @"homeMembersDict" : homeMembersDict ? homeMembersDict : [NSMutableDictionary dictionary],
       @"notificationSettingsDict" : notificationSettingsDict ? notificationSettingsDict : [NSMutableDictionary dictionary],
       @"topicDict" : topicDict ? topicDict : [NSMutableDictionary dictionary],
  
     }];
    
    currentViewController.modalPresentationStyle = UIModalPresentationPopover;
    
    [currentViewController presentViewController:viewControllerObject animated:YES completion:nil];
    
}

#pragma mark - Subscriptions

-(void)PushToWeDivvyPremiumViewController:(BOOL)viewingSlideShow comingFromSignUp:(BOOL)comingFromSignUp defaultPlan:(NSString *)defaultPlan displayDiscount:(NSString *)displayDiscount selectedSlide:(NSString *)selectedSlide promoCodeID:(NSString *)promoCodeID premiumPlanProductsArray:(NSMutableArray *)premiumPlanProductsArray premiumPlanPricesDict:(NSMutableDictionary *)premiumPlanPricesDict premiumPlanExpensivePricesDict:(NSMutableDictionary *)premiumPlanExpensivePricesDict premiumPlanPricesDiscountDict:(NSMutableDictionary *)premiumPlanPricesDiscountDict premiumPlanPricesNoFreeTrialDict:(NSMutableDictionary *)premiumPlanPricesNoFreeTrialDict currentViewController:(UIViewController *)currentViewController Superficial:(BOOL)Superficial {

    if (Superficial) {
        return;
    }
    
    WeDivvyPremiumNavigationController *viewControllerObject = [currentViewController.storyboard instantiateViewControllerWithIdentifier:@"WeDivvyPremiumNavigationController"];
    
    viewControllerObject.modalInPresentation = true;
    
    UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"WeDivvyPremiumNavigationController" source:currentViewController destination:viewControllerObject];
    
    [viewControllerObject prepareForSegue:segue sender:
     
     @{@"viewingSlideShow" : viewingSlideShow ? @"Yes" : @"No",
       @"comingFromSignUp" : comingFromSignUp ? @"Yes" : @"No",
       
       @"defaultPlan" : defaultPlan ? defaultPlan : @"",
       @"displayDiscount" : displayDiscount ? displayDiscount : @"",
       @"selectedSlide" : selectedSlide ? selectedSlide : @"",
       @"promoCodeID" : promoCodeID ? promoCodeID : @"",
       
       @"premiumPlanProductsArray" : premiumPlanProductsArray ? premiumPlanProductsArray : [NSMutableArray array],
       @"premiumPlanPricesDict" : premiumPlanPricesDict ? premiumPlanPricesDict : [NSMutableDictionary dictionary],
       @"premiumPlanExpensivePricesDict" : premiumPlanExpensivePricesDict ? premiumPlanExpensivePricesDict : [NSMutableDictionary dictionary],
       @"premiumPlanPricesDiscountDict" : premiumPlanPricesDiscountDict ? premiumPlanPricesDiscountDict : [NSMutableDictionary dictionary],
       @"premiumPlanPricesNoFreeTrialDict" : premiumPlanPricesNoFreeTrialDict ? premiumPlanPricesNoFreeTrialDict : [NSMutableDictionary dictionary],
       
     }];
    
    currentViewController.modalPresentationStyle = UIModalPresentationPopover;
    
    [currentViewController presentViewController:viewControllerObject animated:YES completion:nil];

}

#pragma mark - Users

-(void)PushToProfileViewController:(NSString *)userID currentViewController:(UIViewController *)currentViewController {
    
    ProfileViewController *viewControllerObject = [currentViewController.storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
    
    viewControllerObject.otherUsersUserID = userID;
    
    [currentViewController.navigationController pushViewController:viewControllerObject animated:self];
    
}

-(void)PushToEditProfileViewController:(NSString * _Nullable)homeID name:(NSString * _Nullable)name imageURL:(NSString * _Nullable)imageURL editingHome:(BOOL)editingHome currentViewController:(UIViewController *)currentViewController {
    
    EditProfileViewController *viewControllerObject = [currentViewController.storyboard instantiateViewControllerWithIdentifier:@"EditProfileViewController"];
    
    viewControllerObject.editingHome = editingHome;
    viewControllerObject.homeID = homeID ? homeID : @"";
    viewControllerObject.name = name ? name : @"";
    viewControllerObject.imageURL = imageURL ? imageURL : @"";
    
    [currentViewController.navigationController pushViewController:viewControllerObject animated:YES];
    
}

#pragma mark - Items

-(void)PushToMultiAddTasksViewController:(BOOL)viewingAddedTasks itemDictFromPreviousPage:(NSMutableDictionary *)itemDictFromPreviousPage itemDictKeysFromPreviousPage:(NSMutableDictionary *)itemDictKeysFromPreviousPage itemSelectedDict:(NSMutableDictionary *)itemSelectedDict homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict topicDict:(NSMutableDictionary *)topicDict folderDict:(NSMutableDictionary *)folderDict taskListDict:(NSMutableDictionary *)taskListDict templateDict:(NSMutableDictionary *)templateDict draftDict:(NSMutableDictionary *)draftDict homeMembersArray:(NSMutableArray *)homeMembersArray itemNamesAlreadyUsed:(NSMutableArray *)itemNamesAlreadyUsed allItemAssignedToArrays:(NSMutableArray *)allItemAssignedToArrays allItemTagsArrays:(NSMutableArray *)allItemTagsArrays defaultTaskListName:(NSString * _Nullable)defaultTaskListName currentViewController:(UIViewController *)currentViewController Superficial:(BOOL)Superficial {
    
    if (Superficial) {
        return;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        MultiAddTasksNavigationController *viewControllerObject = [currentViewController.storyboard instantiateViewControllerWithIdentifier:@"MultiAddTasksNavigationController"];
        
        viewControllerObject.modalInPresentation = true;
        
        UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"MultiAddTasksNavigationController" source:currentViewController destination:viewControllerObject];
       
        [viewControllerObject prepareForSegue:segue sender:
         
         @{@"defaultTaskListName" : defaultTaskListName ? defaultTaskListName : @"",
           
           @"itemDictFromPreviousPage" : itemDictFromPreviousPage ? itemDictFromPreviousPage : [NSMutableDictionary dictionary],
           @"itemDictKeysFromPreviousPage" : itemDictKeysFromPreviousPage ? itemDictKeysFromPreviousPage : [NSMutableDictionary dictionary],
           @"itemSelectedDict" : itemSelectedDict ? itemSelectedDict : [NSMutableDictionary dictionary],
           @"homeMembersDict" : homeMembersDict ? homeMembersDict : [NSMutableDictionary dictionary],
           @"notificationSettingsDict" : notificationSettingsDict ? notificationSettingsDict : [NSMutableDictionary dictionary],
           @"topicDict" : topicDict ? topicDict : [NSMutableDictionary dictionary],
           @"folderDict" : folderDict ? folderDict : [NSMutableDictionary dictionary],
           @"taskListDict" : taskListDict ? taskListDict : [NSMutableDictionary dictionary],
           @"templateDict" : templateDict ? templateDict : [NSMutableDictionary dictionary],
           @"draftDict" : draftDict ? draftDict : [NSMutableDictionary dictionary],
           
           @"homeMembersArray" : homeMembersArray ? homeMembersArray : [NSMutableArray array],
           @"itemNamesAlreadyUsed" : itemNamesAlreadyUsed ? itemNamesAlreadyUsed : [NSMutableArray array],
           @"allItemAssignedToArrays" : allItemAssignedToArrays ? allItemAssignedToArrays : [NSMutableArray array],
           @"allItemTagsArrays" : allItemTagsArrays ? allItemTagsArrays : [NSMutableArray array],
           
           @"viewingAddedTasks" : viewingAddedTasks ? @"Yes" : @"No",
         }];
        
        currentViewController.modalPresentationStyle = UIModalPresentationPopover;
        
        [currentViewController presentViewController:viewControllerObject animated:YES completion:nil];
        
    });
    
}

-(void)PushToAddTaskViewController:(NSMutableDictionary * _Nullable)itemToEditDict
                partiallyAddedDict:(NSMutableDictionary * _Nullable)partiallyAddedDict
            suggestedItemToAddDict:(NSMutableDictionary * _Nullable)suggestedItemToAddDict
                templateToEditDict:(NSMutableDictionary * _Nullable)templateToEditDict
                draftToEditDict:(NSMutableDictionary * _Nullable)draftToEditDict
                   moreOptionsDict:(NSMutableDictionary * _Nullable)moreOptionsDict
                      multiAddDict:(NSMutableDictionary * _Nullable)multiAddDict
          notificationSettingsDict:(NSMutableDictionary * _Nullable)notificationSettingsDict
                         topicDict:(NSMutableDictionary * _Nullable)topicDict
                            homeID:(NSString *)homeID
                  homeMembersArray:(NSMutableArray *)homeMembersArray
                   homeMembersDict:(NSMutableDictionary *)homeMembersDict
               itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict
                        folderDict:(NSMutableDictionary *)folderDict
                      taskListDict:(NSMutableDictionary *)taskListDict
                      templateDict:(NSMutableDictionary *)templateDict
                         draftDict:(NSMutableDictionary *)draftDict
           allItemAssignedToArrays:(NSMutableArray * _Nullable)allItemAssignedToArrays
                 allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays
                 allItemIDsArrays:(NSMutableArray * _Nullable)allItemIDsArrays
               defaultTaskListName:(NSString * _Nullable)defaultTaskListName
                partiallyAddedTask:(BOOL)partiallyAddedTask
                        addingTask:(BOOL)addingTask
               addingMultipleTasks:(BOOL)addingMultipleTasks
               addingSuggestedTask:(BOOL)addingSuggestedTask
                       editingTask:(BOOL)editingTask
                       viewingTask:(BOOL)viewingTask
                viewingMoreOptions:(BOOL)viewingMoreOptions
                   duplicatingTask:(BOOL)duplicatingTask
                   editingTemplate:(BOOL)editingTemplate
                   viewingTemplate:(BOOL)viewingTemplate
                   editingDraft:(BOOL)editingDraft
                   viewingDraft:(BOOL)viewingDraft
             currentViewController:(UIViewController *)currentViewController
                       Superficial:(BOOL)Superficial {
    
    if (Superficial) {
        return;
    }
     
    AddTaskNavigationController *viewControllerObject = [currentViewController.storyboard instantiateViewControllerWithIdentifier:@"AddTaskNavigationController"];
    
    viewControllerObject.modalInPresentation = true;
    
    UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"AddTaskNavigationController" source:currentViewController destination:viewControllerObject];
   
    [viewControllerObject prepareForSegue:segue sender:
  
     @{@"homeID" : homeID ? homeID : @"",
       @"defaultTaskListName" : defaultTaskListName ? defaultTaskListName : @"",
       
       @"homeMembersArray" : homeMembersArray ? homeMembersArray : [NSMutableArray array],
       @"allItemAssignedToArrays" : allItemAssignedToArrays ? allItemAssignedToArrays : [NSMutableArray array],
       @"allItemTagsArrays" : allItemTagsArrays ? allItemTagsArrays : [NSMutableArray array],
       @"allItemIDsArrays" : allItemIDsArrays ? allItemIDsArrays : [NSMutableArray array],
       
       @"homeMembersDict" : homeMembersDict ? homeMembersDict : [NSMutableDictionary dictionary],
       @"itemOccurrencesDict" : itemOccurrencesDict ? itemOccurrencesDict : [NSMutableDictionary dictionary],
       @"folderDict" : folderDict ? folderDict : [NSMutableDictionary dictionary],
       @"taskListDict" : taskListDict ? taskListDict : [NSMutableDictionary dictionary],
       @"templateDict" : templateDict ? templateDict : [NSMutableDictionary dictionary],
       @"draftDict" : draftDict ? draftDict : [NSMutableDictionary dictionary],
       @"itemToEditDict" : itemToEditDict ? itemToEditDict : [NSMutableDictionary dictionary],
       @"partiallyAddedDict" : partiallyAddedDict ? partiallyAddedDict : [NSMutableDictionary dictionary],
       @"suggestedItemToAddDict" : suggestedItemToAddDict ? suggestedItemToAddDict : [NSMutableDictionary dictionary],
       @"templateToEditDict" : templateToEditDict ? templateToEditDict : [NSMutableDictionary dictionary],
       @"draftToEditDict" : draftToEditDict ? draftToEditDict : [NSMutableDictionary dictionary],
       @"moreOptionsDict" : moreOptionsDict ? moreOptionsDict : [NSMutableDictionary dictionary],
       @"multiAddDict" : multiAddDict ? multiAddDict : [NSMutableDictionary dictionary],
       @"notificationSettingsDict" : notificationSettingsDict ? notificationSettingsDict : [NSMutableDictionary dictionary],
       @"topicDict" : topicDict ? topicDict : [NSMutableDictionary dictionary],
       
       @"viewingAddExpenseViewController" : [[[[GeneralObject alloc] init] GenerateItemType] isEqualToString:@"Expense"] ? @"Yes" : @"No",
       @"viewingAddListViewController" : [[[[GeneralObject alloc] init] GenerateItemType] isEqualToString:@"List"] ? @"Yes" : @"No",
       
       @"partiallyAddedTask" : partiallyAddedTask ? @"Yes" : @"No",
       @"addingTask" : addingTask ? @"Yes" : @"No",
       @"addingMultipleTasks" : addingMultipleTasks ? @"Yes" : @"No",
       @"addingSuggestedTask" : addingSuggestedTask ? @"Yes" : @"No",
       @"editingTask" : editingTask ? @"Yes" : @"No",
       @"viewingTask" : viewingTask ? @"Yes" : @"No",
       @"viewingMoreOptions" : viewingMoreOptions ? @"Yes" : @"No",
       @"duplicatingTask" : duplicatingTask ? @"Yes" : @"No",
       
       @"editingTemplate" : editingTemplate ? @"Yes" : @"No",
       @"viewingTemplate" : viewingTemplate ? @"Yes" : @"No",
       
       @"editingDraft" : editingDraft ? @"Yes" : @"No",
       @"viewingDraft" : viewingDraft ? @"Yes" : @"No",
       
     }];
    
    viewControllerObject.modalPresentationStyle = UIModalPresentationPopover;

    [currentViewController presentViewController:viewControllerObject animated:YES completion:nil];

}

-(void)PushToViewTaskViewController:(NSString *)itemID
                   itemOccurrenceID:(NSString * _Nullable)itemOccurrenceID
           itemDictFromPreviousPage:(NSMutableDictionary *)itemDictFromPreviousPage
                   homeMembersArray:(NSMutableArray *)homeMembersArray
                    homeMembersDict:(NSMutableDictionary *)homeMembersDict
                itemOccurrencesDict:(NSMutableDictionary *)itemOccurrencesDict
                         folderDict:(NSMutableDictionary *)folderDict
                       taskListDict:(NSMutableDictionary *)taskListDict
                       templateDict:(NSMutableDictionary *)templateDict
                          draftDict:(NSMutableDictionary *)draftDict
           notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict
                          topicDict:(NSMutableDictionary *)topicDict
               itemNamesAlreadyUsed:(NSMutableArray * _Nullable)itemNamesAlreadyUsed
            allItemAssignedToArrays:(NSMutableArray * _Nullable)allItemAssignedToArrays
                  allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays
                    allItemIDsArrays:(NSMutableArray * _Nullable)allItemIDsArrays
              currentViewController:(UIViewController *)currentViewController
                        Superficial:(BOOL)Superficial {
   
    if (Superficial) {
        return;
    }
    
    ViewTaskNavigationController *viewControllerObject = [currentViewController.storyboard instantiateViewControllerWithIdentifier:@"ViewTaskNavigationController"];

    viewControllerObject.modalInPresentation = true;
    
    UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"ViewTaskNavigationController" source:currentViewController destination:viewControllerObject];
   
    [viewControllerObject prepareForSegue:segue sender:
   
     @{@"itemID" : itemID ? itemID : @"",
       @"itemOccurrenceID" : itemOccurrenceID ? itemOccurrenceID : @"",
       
       @"homeMembersArray" : homeMembersArray ? homeMembersArray : [NSMutableArray array],
       @"itemNamesAlreadyUsed" : itemNamesAlreadyUsed ? itemNamesAlreadyUsed : [NSMutableArray array],
       @"allItemAssignedToArrays" : allItemAssignedToArrays ? allItemAssignedToArrays : [NSMutableArray array],
       @"allItemTagsArrays" : allItemTagsArrays ? allItemTagsArrays : [NSMutableArray array],
       @"allItemIDsArrays" : allItemIDsArrays ? allItemIDsArrays : [NSMutableArray array],
       
       @"itemDictFromPreviousPage" : itemDictFromPreviousPage ? itemDictFromPreviousPage : [NSMutableDictionary dictionary],

       @"homeMembersDict" : homeMembersDict ? homeMembersDict : [NSMutableDictionary dictionary],
       @"itemOccurrencesDict" : itemOccurrencesDict ? itemOccurrencesDict : [NSMutableDictionary dictionary],
       @"folderDict" : folderDict ? folderDict : [NSMutableDictionary dictionary],
       @"taskListDict" : taskListDict ? taskListDict : [NSMutableDictionary dictionary],
       @"templateDict" : templateDict ? templateDict : [NSMutableDictionary dictionary],
       @"draftDict" : draftDict ? draftDict : [NSMutableDictionary dictionary],
       @"notificationSettingsDict" : notificationSettingsDict ? notificationSettingsDict : [NSMutableDictionary dictionary],
       @"topicDict" : topicDict ? topicDict : [NSMutableDictionary dictionary],
       
       @"viewingOccurrence" : itemOccurrenceID != nil && itemOccurrenceID != NULL && itemOccurrenceID.length > 0 ? @"Yes" : @"No",
       @"viewingViewExpenseViewController" : [[[[GeneralObject alloc] init] GenerateItemType] isEqualToString:@"Expense"] ? @"Yes" : @"No",
       @"viewingViewListViewController" : [[[[GeneralObject alloc] init] GenerateItemType] isEqualToString:@"List"] ? @"Yes" : @"No",
       
     }];
    
    currentViewController.modalPresentationStyle = UIModalPresentationPopover;
    
    [currentViewController presentViewController:viewControllerObject animated:YES completion:nil];
    
}

#pragma mark - Views

-(void)PushToViewPromoCodeViewController:(UIViewController *)currentViewController {
    
    ViewPromoCodeNavigationController *viewControllerObject = [currentViewController.storyboard instantiateViewControllerWithIdentifier:@"ViewPromoCodeNavigationController"];
    
    viewControllerObject.modalInPresentation = true;
    
    UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"ViewPromoCodeNavigationController" source:currentViewController destination:viewControllerObject];
    
    [viewControllerObject prepareForSegue:segue sender:
     
     @{
     }];
    
    currentViewController.modalPresentationStyle = UIModalPresentationPopover;
    
    [currentViewController presentViewController:viewControllerObject animated:YES completion:nil];
    
}

-(void)PushToViewCalendarViewController:(NSMutableDictionary *)itemsDict
                           itemsDictNo2:(NSMutableDictionary *)itemsDictNo2
                           itemsDictNo3:(NSMutableDictionary *)itemsDictNo3
                   itemsOccurrencesDict:(NSMutableDictionary *)itemsOccurrencesDict
                itemsOccurrencesDictNo2:(NSMutableDictionary *)itemsOccurrencesDictNo2
                itemsOccurrencesDictNo3:(NSMutableDictionary *)itemsOccurrencesDictNo3
                       homeMembersArray:(NSMutableArray *)homeMembersArray
                        homeMembersDict:(NSMutableDictionary *)homeMembersDict
               notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict
                              topicDict:(NSMutableDictionary *)topicDict
                             folderDict:(NSMutableDictionary *)folderDict
                           taskListDict:(NSMutableDictionary *)taskListDict
                           templateDict:(NSMutableDictionary *)templateDict
                              draftDict:(NSMutableDictionary *)draftDict
                   itemNamesAlreadyUsed:(NSMutableArray * _Nullable)itemNamesAlreadyUsed
                allItemAssignedToArrays:(NSMutableArray * _Nullable)allItemAssignedToArrays
                      allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays
                       allItemIDsArrays:(NSMutableArray * _Nullable)allItemIDsArrays
                  currentViewController:(UIViewController *)currentViewController {
    
    ViewCalendarNavigationController *viewControllerObject = [currentViewController.storyboard instantiateViewControllerWithIdentifier:@"ViewCalendarNavigationController"];
    
    viewControllerObject.modalInPresentation = true;
    
    UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"ViewCalendarNavigationController" source:currentViewController destination:viewControllerObject];
    
    [viewControllerObject prepareForSegue:segue sender:
         
         @{@"itemsDict" : itemsDict ? itemsDict : [NSMutableDictionary dictionary],
           @"itemsDictNo2" : itemsDictNo2 ? itemsDictNo2 : [NSMutableDictionary dictionary],
           @"itemsDictNo3" : itemsDictNo3 ? itemsDictNo3 : [NSMutableDictionary dictionary],
           @"itemsOccurrencesDict" : itemsOccurrencesDict ? itemsOccurrencesDict : [NSMutableDictionary dictionary],
           @"itemsOccurrencesDictNo2" : itemsOccurrencesDictNo2 ? itemsOccurrencesDictNo2 : [NSMutableDictionary dictionary],
           @"itemsOccurrencesDictNo3" : itemsOccurrencesDictNo3 ? itemsOccurrencesDictNo3 : [NSMutableDictionary dictionary],
           
           @"homeMembersArray" : homeMembersArray ? homeMembersArray : [NSMutableArray array],
           @"itemNamesAlreadyUsed" : itemNamesAlreadyUsed ? itemNamesAlreadyUsed : [NSMutableArray array],
           @"allItemAssignedToArrays" : allItemAssignedToArrays ? allItemAssignedToArrays : [NSMutableArray array],
           @"allItemTagsArrays" : allItemTagsArrays ? allItemTagsArrays : [NSMutableArray array],
           @"allItemIDsArrays" : allItemIDsArrays ? allItemIDsArrays : [NSMutableArray array],
           
           @"homeMembersDict" : homeMembersDict ? homeMembersDict : [NSMutableDictionary dictionary],
           @"folderDict" : folderDict ? folderDict : [NSMutableDictionary dictionary],
           @"taskListDict" : taskListDict ? taskListDict : [NSMutableDictionary dictionary],
           @"templateDict" : templateDict ? templateDict : [NSMutableDictionary dictionary],
           @"draftDict" : draftDict ? draftDict : [NSMutableDictionary dictionary],
           @"notificationSettingsDict" : notificationSettingsDict ? notificationSettingsDict : [NSMutableDictionary dictionary],
           @"topicDict" : topicDict ? topicDict : [NSMutableDictionary dictionary],
           
         }
     
    ];
    
    currentViewController.modalPresentationStyle = UIModalPresentationPopover;
    
    [currentViewController presentViewController:viewControllerObject animated:YES completion:nil];
    
}

-(void)PushToViewActivityViewController:(BOOL)ViewingHome ViewingItem:(BOOL)ViewingItem 
                                 itemID:(NSString *)itemID
                       homeMembersArray:(NSMutableArray *)homeMembersArray
                        homeMembersDict:(NSMutableDictionary *)homeMembersDict
               notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict
                              topicDict:(NSMutableDictionary *)topicDict
                             folderDict:(NSMutableDictionary *)folderDict
                           taskListDict:(NSMutableDictionary *)taskListDict
                           templateDict:(NSMutableDictionary *)templateDict
                              draftDict:(NSMutableDictionary *)draftDict
                   itemNamesAlreadyUsed:(NSMutableArray * _Nullable)itemNamesAlreadyUsed
                allItemAssignedToArrays:(NSMutableArray * _Nullable)allItemAssignedToArrays
                      allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays
                       allItemIDsArrays:(NSMutableArray * _Nullable)allItemIDsArrays
                  currentViewController:(UIViewController *)currentViewController {

    ViewActivityNavigationController *viewControllerObject = [currentViewController.storyboard instantiateViewControllerWithIdentifier:@"ViewActivityNavigationController"];
    
    viewControllerObject.modalInPresentation = true;
    
    UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"ViewActivityNavigationController" source:currentViewController destination:viewControllerObject];
    
    [viewControllerObject prepareForSegue:segue sender:
     
     @{
        @"ViewingHome" : ViewingHome ? @"Yes" : @"No",
        @"ViewingItem" : ViewingItem ? @"Yes" : @"No",
        
        @"itemID" : itemID ? itemID : @"",
      
        @"homeMembersArray" : homeMembersArray ? homeMembersArray : [NSMutableArray array],
        @"itemNamesAlreadyUsed" : itemNamesAlreadyUsed ? itemNamesAlreadyUsed : [NSMutableArray array],
        @"allItemAssignedToArrays" : allItemAssignedToArrays ? allItemAssignedToArrays : [NSMutableArray array],
        @"allItemTagsArrays" : allItemTagsArrays ? allItemTagsArrays : [NSMutableArray array],
        @"allItemIDsArrays" : allItemIDsArrays ? allItemIDsArrays : [NSMutableArray array],
        
        @"homeMembersDict" : homeMembersDict ? homeMembersDict : [NSMutableDictionary dictionary],
        @"folderDict" : folderDict ? folderDict : [NSMutableDictionary dictionary],
        @"taskListDict" : taskListDict ? taskListDict : [NSMutableDictionary dictionary],
        @"templateDict" : templateDict ? templateDict : [NSMutableDictionary dictionary],
        @"draftDict" : draftDict ? draftDict : [NSMutableDictionary dictionary],
        @"notificationSettingsDict" : notificationSettingsDict ? notificationSettingsDict : [NSMutableDictionary dictionary],
        @"topicDict" : topicDict ? topicDict : [NSMutableDictionary dictionary],
        
    }];
    
    currentViewController.modalPresentationStyle = UIModalPresentationPopover;
    
    [currentViewController presentViewController:viewControllerObject animated:YES completion:nil];
    
}

-(void)PushToViewTaskListsViewController:(NSMutableDictionary *)foldersDict taskListDict:(NSMutableDictionary *)taskListDict itemToEditDict:(NSMutableDictionary * _Nullable)itemToEditDict itemUniqueID:(NSString *)itemUniqueID comingFromTasksViewController:(BOOL)comingFromTasksViewController comingFromViewTaskViewController:(BOOL)comingFromViewTaskViewController currentViewController:(UIViewController *)currentViewController {
    
    ViewTaskListsNavigationController *viewControllerObject = [currentViewController.storyboard instantiateViewControllerWithIdentifier:@"ViewTaskListsNavigationController"];
    
    viewControllerObject.modalInPresentation = true;
    
    UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"ViewTaskListsNavigationController" source:currentViewController destination:viewControllerObject];
    
    [viewControllerObject prepareForSegue:segue sender:
     
     @{@"foldersDict" : foldersDict ? foldersDict : [NSMutableDictionary dictionary],
       @"taskListDict" : taskListDict ? taskListDict : [NSMutableDictionary dictionary],
       @"itemToEditDict" : itemToEditDict ? itemToEditDict : [NSMutableDictionary dictionary],
       @"itemUniqueID" : itemUniqueID ? itemUniqueID : @"",
       @"comingFromTasksViewController" : comingFromViewTaskViewController ? @"Yes" : @"No",
       @"comingFromViewTaskViewController" : comingFromViewTaskViewController ? @"Yes" : @"No",
     }
     
    ];
    
    currentViewController.modalPresentationStyle = UIModalPresentationPopover;
    
    [currentViewController presentViewController:viewControllerObject animated:YES completion:nil];
    
}

-(void)PushToViewAssignedViewController:(NSMutableArray *)selectedArray itemAssignedToNewHomeMembers:(NSString *)itemAssignedToNewHomeMembers itemAssignedToAnybody:(NSString *)itemAssignedToAnybody itemUniqueID:(NSString *)itemUniqueID homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict homeMembersUnclaimedDict:(NSMutableDictionary *)homeMembersUnclaimedDict homeKeysDict:(NSMutableDictionary *)homeKeysDict homeKeysArray:(NSMutableArray *)homeKeysArray notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict topicDict:(NSMutableDictionary *)topicDict viewingItemDetails:(BOOL)viewingItemDetails viewingExpense:(BOOL)viewingExpense viewingChatMembers:(BOOL)viewingChatMembers viewingWeDivvyPremiumAddingAccounts:(BOOL)viewingWeDivvyPremiumAddingAccounts viewingWeDivvyPremiumEditingAccounts:(BOOL)viewingWeDivvyPremiumEditingAccounts currentViewController:(UIViewController *)currentViewController {
    
    ViewAssignedToNavigationController *viewControllerObject = [currentViewController.storyboard instantiateViewControllerWithIdentifier:@"ViewAssignedToNavigationController"];
    
    viewControllerObject.modalInPresentation = true;
    
    UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"ViewAssignedToNavigationController" source:currentViewController destination:viewControllerObject];
   
    [viewControllerObject prepareForSegue:segue sender:
         
         @{@"itemAssignedToAnybody" : itemAssignedToAnybody ? itemAssignedToAnybody : @"",
           @"itemAssignedToNewHomeMembers" : itemAssignedToNewHomeMembers ? itemAssignedToNewHomeMembers : @"",
           @"itemUniqueID" : itemUniqueID ? itemUniqueID : @"",
           
           @"selectedArray" : selectedArray ? selectedArray : [NSMutableArray array],
           @"homeMembersArray" : homeMembersArray ? homeMembersArray : [NSMutableArray array],
           @"homeKeysArray" : homeKeysArray ? homeKeysArray : [NSMutableArray array],
           
           @"homeMembersDict" : homeMembersDict ? homeMembersDict : [NSMutableDictionary dictionary],
           @"homeMembersUnclaimedDict" : homeMembersUnclaimedDict ? homeMembersUnclaimedDict : [NSMutableDictionary dictionary],
           @"homeKeysDict" : homeKeysDict ? homeKeysDict : [NSMutableDictionary dictionary],
           @"topicDict" : topicDict ? topicDict : [NSMutableDictionary dictionary],
 
           @"viewingItemDetails" : viewingItemDetails ? @"Yes" : @"No",
           @"viewingExpense" : viewingExpense ? @"Yes" : @"No",
           @"viewingChatMembers" : viewingChatMembers ? @"Yes" : @"No",
           
           @"viewingWeDivvyPremiumAddingAccounts" : viewingWeDivvyPremiumAddingAccounts ? @"Yes" : @"No",
           @"viewingWeDivvyPremiumEditingAccounts" : viewingWeDivvyPremiumEditingAccounts ? @"Yes" : @"No",
           
         }
     
    ];
    
    currentViewController.modalPresentationStyle = UIModalPresentationPopover;
    
    [currentViewController presentViewController:viewControllerObject animated:YES completion:nil];
    
}

-(void)PushToViewOptionsViewController:(NSMutableArray *)itemsSelectedArray customOptionsArray:(NSMutableArray * _Nullable)customOptionsArray specificDatesArray:(NSMutableArray * _Nullable)specificDatesArray viewingItemDetails:(BOOL)viewingItemDetails optionSelectedString:(NSString *)optionSelectedString itemRepeatsFrequency:(NSString * _Nullable)itemRepeatsFrequency homeMembersDict:(NSMutableDictionary * _Nullable)homeMembersDict currentViewController:(UIViewController *)currentViewController {
    
    ViewOptionsNavigationController *viewControllerObject = [currentViewController.storyboard instantiateViewControllerWithIdentifier:@"ViewOptionsNavigationController"];
    
    viewControllerObject.modalInPresentation = true;
    
    UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"ViewOptionsNavigationController" source:currentViewController destination:viewControllerObject];
    
    [viewControllerObject prepareForSegue:segue sender:
     
     @{@"optionSelectedString" : optionSelectedString ? optionSelectedString : @"",
       @"itemRepeatsFrequency" : itemRepeatsFrequency ? itemRepeatsFrequency : @"",
       @"customOptionsArray" : customOptionsArray ? customOptionsArray : [NSMutableArray array],
       @"itemsSelectedArray" : itemsSelectedArray ? itemsSelectedArray : [NSMutableArray array],
       @"specificDatesArray" : specificDatesArray ? specificDatesArray : [NSMutableArray array],
       
       @"homeMembersDict" : homeMembersDict ? homeMembersDict : [NSMutableDictionary dictionary],
       
       @"viewingItemDetails" : viewingItemDetails ? @"Yes" : @"No",
 
     }];
    
    currentViewController.modalPresentationStyle = UIModalPresentationPopover;
    
    [currentViewController presentViewController:viewControllerObject animated:YES completion:nil];
    
}

-(void)PushToViewMutableOptionsViewController:(NSMutableDictionary * _Nullable)itemsAlreadyChosenDict itemsDict:(NSMutableDictionary *)itemsDict foldersDict:(NSMutableDictionary *)foldersDict viewingSections:(BOOL)viewingSections viewingFolders:(BOOL)viewingFolders homeMembersArray:(NSMutableArray * _Nullable)homeMembersArray homeMembersDict:(NSMutableDictionary * _Nullable)homeMembersDict itemOccurrencesDict:(NSMutableDictionary * _Nullable)itemOccurrencesDict allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays currentViewController:(UIViewController *)currentViewController {
    
    ViewMutableOptionsNavigationController *viewControllerObject = [currentViewController.storyboard instantiateViewControllerWithIdentifier:@"ViewMutableOptionsNavigationController"];
    
    viewControllerObject.modalInPresentation = true;
    
    UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"ViewMutableOptionsNavigationController" source:currentViewController destination:viewControllerObject];
    
    [viewControllerObject prepareForSegue:segue sender:
         
         @{@"itemsAlreadyChosenDict" : itemsAlreadyChosenDict ? itemsAlreadyChosenDict : [NSMutableDictionary dictionary],
           @"itemsDict" : itemsDict ? itemsDict : [NSMutableDictionary dictionary],
           @"foldersDict" : foldersDict ? foldersDict : [NSMutableDictionary dictionary],
           
           @"viewingSections" : viewingSections ? @"Yes" : @"No",
           @"viewingFolders" : viewingFolders ? @"Yes" : @"No",
           
           @"homeMembersArray" : homeMembersArray ? homeMembersArray : [NSMutableArray array],
           @"allItemTagsArrays" : allItemTagsArrays ? allItemTagsArrays : [NSMutableArray array],
           
           @"homeMembersDict" : homeMembersDict ? homeMembersDict : [NSMutableDictionary dictionary],
           @"itemOccurrencesDict" : itemOccurrencesDict ? itemOccurrencesDict : [NSMutableDictionary dictionary],
         }
     
    ];
    
    currentViewController.modalPresentationStyle = UIModalPresentationPopover;
    
    [currentViewController presentViewController:viewControllerObject animated:YES completion:nil];
    
}

-(void)PushToViewAddItemsViewController:(NSMutableArray * _Nullable)itemsAlreadyChosenAlready itemsAlreadyChosenDict:(NSMutableDictionary * _Nullable)itemsAlreadyChosenDict userDict:(NSMutableDictionary * _Nullable)userDict optionSelectedString:(NSString *)optionSelectedString itemRepeats:(NSString *)itemRepeats viewingItemDetails:(BOOL)viewingItemDetails currentViewController:(UIViewController *)currentViewController {
    
    ViewAddItemsNavigationController *viewControllerObject = [currentViewController.storyboard instantiateViewControllerWithIdentifier:@"ViewAddItemsNavigationController"];
    
    viewControllerObject.modalInPresentation = true;
    
    UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"ViewAddItemsNavigationController" source:currentViewController destination:viewControllerObject];
    
    [viewControllerObject prepareForSegue:segue sender:
     
     @{@"itemsAlreadyChosenArray" : itemsAlreadyChosenAlready ? itemsAlreadyChosenAlready : [NSMutableArray array],
       
       @"userDict" : userDict ? userDict : [NSMutableDictionary dictionary],
       @"itemsAlreadyChosenDict" : itemsAlreadyChosenDict ? itemsAlreadyChosenDict : [NSMutableDictionary dictionary],
       
       @"viewingItemDetails" : viewingItemDetails ? @"Yes" : @"No",
       
       @"itemRepeats" : itemRepeats ? itemRepeats : @"",
       @"optionSelectedString" : optionSelectedString ? optionSelectedString : @""
     }];
    
    currentViewController.modalPresentationStyle = UIModalPresentationPopover;
    
    [currentViewController presentViewController:viewControllerObject animated:YES completion:nil];
    
}

-(void)PushToViewViewCostPerPersonViewController:(NSMutableArray *)itemAssignedToArray itemAssignedToUsernameArray:(NSMutableArray *)itemAssignedToUsernameArray itemAssignedToProfileImageArray:(NSMutableArray *)itemAssignedToProfileImageArray itemAmount:(NSString *)itemAmount costPerPersonDict:(NSMutableDictionary *)costPerPersonDict itemItemizedItemsDict:(NSMutableDictionary *)itemItemizedDict viewingItemDetails:(BOOL)viewingItemDetails currentViewController:(UIViewController *)currentViewController {
    
    ViewCostPerPersonNavigationController *viewControllerObject = [currentViewController.storyboard instantiateViewControllerWithIdentifier:@"ViewCostPerPersonNavigationController"];
    
    viewControllerObject.modalInPresentation = true;
    
    UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"ViewCostPerPersonNavigationController" source:currentViewController destination:viewControllerObject];
    
    [viewControllerObject prepareForSegue:segue sender:
         
         @{@"itemAmountFromPreviousPage" : itemAmount ? itemAmount : @"",
           
           @"itemAssignedToArray" : itemAssignedToArray ? itemAssignedToArray : [NSMutableArray array],
           @"itemAssignedToUsernameArray" : itemAssignedToUsernameArray ? itemAssignedToUsernameArray : [NSMutableArray array],
           @"itemAssignedToProfileImageArray" : itemAssignedToProfileImageArray ? itemAssignedToProfileImageArray : [NSMutableArray array],
           
           @"costPerPersonDict" : costPerPersonDict ? costPerPersonDict : [NSMutableDictionary dictionary],
           @"itemItemizedItemsDict" : itemItemizedDict ? itemItemizedDict : [NSMutableDictionary dictionary],
           
           @"viewingItemDetails" : viewingItemDetails ? @"Yes" : @"No"}
     
    ];
    
    currentViewController.modalPresentationStyle = UIModalPresentationPopover;
    
    [currentViewController presentViewController:viewControllerObject animated:YES completion:nil];
    
}

-(void)PushToViewPaymentMethodViewController:(NSMutableDictionary *)itemPaymentMethodDict viewingReward:(BOOL)viewingReward comingFromAddTaskViewController:(BOOL)comingFromAddTaskViewController viewingItemDetails:(BOOL)viewingItemDetails currentViewController:(UIViewController *)currentViewController {
    
    ViewPaymentMethodNavigationController *viewControllerObject = [currentViewController.storyboard instantiateViewControllerWithIdentifier:@"ViewPaymentMethodNavigationController"];

    viewControllerObject.modalInPresentation = true;
    
    UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"ViewPaymentMethodNavigationController" source:currentViewController destination:viewControllerObject];
    
    [viewControllerObject prepareForSegue:segue sender:
         
         @{@"itemPaymentMethodDict" : itemPaymentMethodDict ? itemPaymentMethodDict : [NSMutableDictionary dictionary],
           @"viewingReward" : viewingReward ? @"Yes" : @"No",
           @"comingFromAddTaskViewController" : comingFromAddTaskViewController ? @"Yes" : @"No"}
     
    ];
 
    currentViewController.modalPresentationStyle = UIModalPresentationPopover;
    
    [currentViewController presentViewController:viewControllerObject animated:YES completion:nil];
    
}

-(void)PushToViewPaymentsViewController:(NSMutableDictionary *)homeMembersDict
                               itemDict:(NSMutableDictionary *)itemDict
                        dataDisplayDict:(NSMutableDictionary *)dataDisplayDict
                             folderDict:(NSMutableDictionary *)folderDict
                           taskListDict:(NSMutableDictionary *)taskListDict
                           templateDict:(NSMutableDictionary *)templateDict
                              draftDict:(NSMutableDictionary *)draftDict
                              topicDict:(NSMutableDictionary *)topicDict
               notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict
                       homeMembersArray:(NSMutableArray *)homeMembersArray
                   itemNamesAlreadyUsed:(NSMutableArray * _Nullable)itemNamesAlreadyUsed
                allItemAssignedToArrays:(NSMutableArray * _Nullable)allItemAssignedToArrays
                      allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays
                        allItemIDsArrays:(NSMutableArray * _Nullable)allItemIDsArrays
                            viewingOwed:(BOOL)viewingOwed
                          viewingEarned:(BOOL)viewingEarned
              viewingUserIDWhoOwesMoney:(NSString *)viewingUserIDWhoOwesMoney
            viewingUserIDWhoIsOwedMoney:(NSString *)viewingUserIDWhoIsOwedMoney
                  currentViewController:(UIViewController *)currentViewController {
    
    ViewPaymentsNavigationController *viewControllerObject = [currentViewController.storyboard instantiateViewControllerWithIdentifier:@"ViewPaymentsNavigationController"];
    
    viewControllerObject.modalInPresentation = true;
    
    UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"ViewPaymentsNavigationController" source:currentViewController destination:viewControllerObject];
    
    [viewControllerObject prepareForSegue:segue sender:
         
         @{@"homeMembersDict" : homeMembersDict ? homeMembersDict : [NSMutableDictionary dictionary],
           @"folderDict" : folderDict ? folderDict : [NSMutableDictionary dictionary],
           @"taskListDict" : taskListDict ? taskListDict : [NSMutableDictionary dictionary],
           @"templateDict" : templateDict ? templateDict : [NSMutableDictionary dictionary],
           @"draftDict" : draftDict ? draftDict : [NSMutableDictionary dictionary],
           @"notificationSettingsDict" : notificationSettingsDict ? notificationSettingsDict : [NSMutableDictionary dictionary],
           @"topicDict" : topicDict ? topicDict : [NSMutableDictionary dictionary],
           @"itemDict" : itemDict ? itemDict : [NSMutableDictionary dictionary],
           @"dataDisplayDict" : dataDisplayDict ? dataDisplayDict : [NSMutableDictionary dictionary],
           
           @"homeMembersArray" : homeMembersArray ? homeMembersArray : [NSMutableArray array],
           @"allItemAssignedToArrays" : allItemAssignedToArrays ? allItemAssignedToArrays : [NSMutableArray array],
           @"allItemTagsArrays" : allItemTagsArrays ? allItemTagsArrays : [NSMutableArray array],
           @"allItemIDsArrays" : allItemIDsArrays ? allItemIDsArrays : [NSMutableArray array],
           
           @"viewingOwed" : viewingOwed ? @"Yes" : @"No",
           @"viewingEarned" : viewingEarned ? @"Yes" : @"No",
           @"viewingUserIDWhoOwesMoney" : viewingUserIDWhoOwesMoney,
           @"viewingUserIDWhoIsOwedMoney" : viewingUserIDWhoIsOwedMoney,
           
         }
     
    ];
    
    currentViewController.modalPresentationStyle = UIModalPresentationPopover;
    
    [currentViewController presentViewController:viewControllerObject animated:YES completion:nil];
    
}

-(void)PushToViewTagsViewController:(NSMutableArray * _Nullable)itemsAlreadyChosenAlready allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays viewingItemDetails:(BOOL)viewingItemDetails comingFromAddTaskViewController:(BOOL)comingFromAddTaskViewController comingFromViewTaskViewController:(BOOL)comingFromViewTaskViewController currentViewController:(UIViewController *)currentViewController {
    
    ViewTagsNavigationController *viewControllerObject = [currentViewController.storyboard instantiateViewControllerWithIdentifier:@"ViewTagsNavigationController"];

    viewControllerObject.modalInPresentation = true;
    
    UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"ViewTagsNavigationController" source:currentViewController destination:viewControllerObject];
    
    [viewControllerObject prepareForSegue:segue sender:
     
     @{@"itemsAlreadyChosenArray" : itemsAlreadyChosenAlready ? itemsAlreadyChosenAlready : [NSMutableArray array],
       @"allItemTagsArrays" : allItemTagsArrays ? allItemTagsArrays : [NSMutableArray array],
       
       @"viewingItemDetails" : viewingItemDetails ? @"Yes" : @"No",
       @"comingFromAddTaskViewController" : comingFromAddTaskViewController ? @"Yes" : @"No",
       @"comingFromViewTaskViewController" : comingFromViewTaskViewController ? @"Yes" : @"No"}
    
    ];

    currentViewController.modalPresentationStyle = UIModalPresentationPopover;
    
    [currentViewController presentViewController:viewControllerObject animated:YES completion:nil];

}

-(void)PushToViewRemindersViewController:(NSMutableDictionary *)itemsAlreadyChosenDict itemRepeats:(NSString *)itemRepeats itemTime:(NSString *)itemTime itemAssignedTo:(NSMutableArray *)itemAssignedTo viewingItemDetails:(BOOL)viewingItemDetails currentViewController:(UIViewController *)currentViewController {
    
    ViewRemindersNavigationController *viewControllerObject = [currentViewController.storyboard instantiateViewControllerWithIdentifier:@"ViewRemindersNavigationController"];
    
    viewControllerObject.modalInPresentation = true;
    
    UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"ViewRemindersNavigationController" source:currentViewController destination:viewControllerObject];
    
    [viewControllerObject prepareForSegue:segue sender:
     
     @{
        @"viewingItemDetails" : viewingItemDetails ? @"Yes" : @"No",
        @"itemRepeats" : itemRepeats ? itemRepeats : @"Never",
        @"itemTime" : itemTime ? itemTime : @"11:59 PM",
        @"itemAssignedTo" : itemAssignedTo ? itemAssignedTo : [NSMutableArray array],
        @"itemsAlreadyChosenDict" : itemsAlreadyChosenDict ? itemsAlreadyChosenDict : [NSMutableDictionary dictionary],
    }];
    
    currentViewController.modalPresentationStyle = UIModalPresentationPopover;
    
    [currentViewController presentViewController:viewControllerObject animated:YES completion:nil];
    
}


-(void)PushToViewImageViewController:(UIViewController *)currentViewController itemImage:(UIImage *)itemImage {
    
    ViewImageNavigationController *viewControllerObject = [currentViewController.storyboard instantiateViewControllerWithIdentifier:@"ViewImageNavigationController"];
    
    viewControllerObject.modalInPresentation = true;
    
    UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"ViewImageNavigationController" source:currentViewController destination:viewControllerObject];
    
    [viewControllerObject prepareForSegue:segue sender:
     
     @{
        @"itemImage" : itemImage ? itemImage : nil,
    }];
    
    currentViewController.modalPresentationStyle = UIModalPresentationPopover;
    
    [currentViewController presentViewController:viewControllerObject animated:YES completion:nil];
    
}

-(void)PushToViewVideoViewController:(UIViewController *)currentViewController videoURLString:(NSString *)videoURLString {
    
    ViewVideoNavigationController *viewControllerObject = [currentViewController.storyboard instantiateViewControllerWithIdentifier:@"ViewVideoNavigationController"];
    
    viewControllerObject.modalInPresentation = true;
    
    UIStoryboardSegue *segue = [[UIStoryboardSegue alloc] initWithIdentifier:@"ViewVideoNavigationController" source:currentViewController destination:viewControllerObject];
    
    [viewControllerObject prepareForSegue:segue sender:
     
     @{
        @"videoURLString" : videoURLString ? videoURLString : nil,
    }];
    
    currentViewController.modalPresentationStyle = UIModalPresentationPopover;
    
    [currentViewController presentViewController:viewControllerObject animated:YES completion:nil];
    
}

@end
