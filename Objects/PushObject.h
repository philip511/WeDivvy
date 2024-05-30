//
//  PushObject.h
//  WeDivvy
//
//  Created by Philip Nagel on 9/14/21.
//

#import "AppDelegate.h"
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PushObject : NSObject

#pragma mark - Chats

-(void)PushToChatsViewController:(UIViewController *)currentViewController;

-(void)PushToAddChatViewController:(NSMutableDictionary  * _Nullable)itemToEditDict homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict topicDict:(NSMutableDictionary *)topicDict currentViewController:(UIViewController *)currentViewController Superficial:(BOOL)Superficial;

-(void)PushToMasterLiveChatViewController:(UIViewController *)currentViewController;

-(void)PushToLiveChatViewControllerFromGroupChatsTab:(NSString *)userID homeID:(NSString *)homeID chatID:(NSString *)chatID chatName:(NSString *)chatName chatAssignedTo:(NSMutableArray *)chatAssignedTo homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict topicDict:(NSMutableDictionary *)topicDict currentViewController:(UIViewController *)currentViewController Superficial:(BOOL)Superficial;

-(void)PushToLiveChatViewControllerFromViewTaskPage:(NSString *)homeID itemID:(NSString *)itemID itemName:(NSString *)itemName itemCreatedBy:(NSString *)itemCreatedBy itemAssignedTo:(NSMutableArray *)itemAssignedTo homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict topicDict:(NSMutableDictionary *)topicDict currentViewController:(UIViewController *)currentViewController Superficial:(BOOL)Superficial;

-(void)PushToLiveChatViewControllerFromSettingsPage:(NSString *)userID viewingLiveSupport:(BOOL)viewingLiveSupport currentViewController:(UIViewController *)currentViewController Superficial:(BOOL)Superficial;

-(void)PushToLiveChatViewControllerFromMasterLiveChat:(NSString *)userID currentViewController:(UIViewController *)currentViewController;

#pragma mark - Forum

-(void)PushToForumViewController:(BOOL)viewingFeatureForum currentViewController:(UIViewController *)currentViewController;

-(void)PushToAddForumViewController:(NSMutableDictionary * _Nullable)itemToEditDict viewingFeatureForum:(BOOL)viewingFeatureForum editingSpecificForumPost:(BOOL)editingSpecificForumPost viewingSpecificForumPost:(BOOL)viewingSpecificForumPost currentViewController:(UIViewController *)currentViewController Superficial:(BOOL)Superficial;

#pragma mark - Homes

-(void)PushToHomesViewController:(BOOL)userHasLoggedIn currentViewController:(UIViewController *)currentViewController;

-(void)PushToCreateHomeViewController:(BOOL)comingFromSignUp arrayOfHomeIDsYouAreAPartOf:(NSMutableArray * _Nullable)arrayOfHomeIDsYouAreAPartOf currentViewController:(UIViewController *)currentViewController;

-(void)PushToHomeMembersViewController:(NSString *)homeID homeName:(NSString *)homeName notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict topicDict:(NSMutableDictionary *)topicDict viewingHomeMembersFromHomesViewController:(BOOL)viewingHomeMembersFromHomesViewController currentViewController:(UIViewController *)currentViewController Superficial:(BOOL)Superficial;

#pragma mark - Login/Sign Up

-(void)PushToInitialNavigationController:(UIViewController *)currentViewController;

-(void)PushToLoginViewController:(UIViewController *)currentViewController;

-(void)PushToSignUpViewController:(BOOL)ThirdPartySignup currentViewController:(UIViewController *)currentViewController;

-(void)PushToEnableNotificationsViewController:(UIViewController *)currentViewController comingFromCreateHome:(BOOL)comingFromCreateHome clickedUnclaimedUser:(BOOL)clickedUnclaimedUser homeIDLinkedToKey:(NSString *)homeIDLinkedToKey homeKey:(NSString *)homeKey;

-(void)PushToInviteMembersViewController:(UIViewController *)currentViewController;

-(void)PushToHomeFeaturesViewController:(UIViewController *)currentViewController comingFromSettings:(BOOL)comingFromSettings;

#pragma mark - Notifications

-(void)PushToNotificationsViewController:(UIViewController *)currentViewController homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict topicDict:(NSMutableDictionary *)topicDict folderDict:(NSMutableDictionary *)folderDict taskListDict:(NSMutableDictionary *)taskListDict templateDict:(NSMutableDictionary *)templateDict draftDict:(NSMutableDictionary *)draftDict allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays allItemIDsArrays:(NSMutableArray * _Nullable)allItemIDsArrays;

#pragma mark - Settings

-(void)PushToSettingsViewController:(BOOL)viewingPremiumSettings allItemAssignedToArrays:(NSMutableArray * _Nullable)allItemAssignedToArrays currentViewController:(UIViewController *)currentViewController;

-(void)PushToUpdateEmailViewController:(UIViewController *)currentViewController;

-(void)PushToBillingViewController:(UIViewController *)currentViewController;

-(void)PushToNotificationSettingsViewController:(UIViewController *)currentViewController notificationSettings:(NSMutableDictionary *)notificationSettings viewingChores:(BOOL)viewingChores viewingExpenses:(BOOL)viewingExpenses viewingLists:(BOOL)viewingLists viewingGroupChats:(BOOL)viewingGroupChats viewingHomeMembers:(BOOL)viewingHomeMembers viewingForum:(BOOL)viewingForum viewingScheduledSummary:(BOOL)viewingScheduledSummary viewingScheduledSummaryTaskTypes:(BOOL)viewingScheduledSummaryTaskTypes Superficial:(BOOL)Superficial;

-(void)PushToFAQViewController:(UIViewController *)currentViewController;

#pragma mark - Tab Bar

-(void)PushToTasksNavigationController:(BOOL)Chores Expenses:(BOOL)Expenses Lists:(BOOL)Lists Animated:(BOOL)Animated currentViewController:(UIViewController *)currentViewController;

#pragma mark - Search

-(void)PushToSearchTasksViewController:(NSMutableDictionary * _Nullable)notificationSettingsDict topicDict:(NSMutableDictionary * _Nullable)topicDict itemDict:(NSMutableDictionary *)itemDict itemDictNo2:(NSMutableDictionary *)itemDictNo2 itemDictNo3:(NSMutableDictionary *)itemDictNo3 homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays currentViewController:(UIViewController *)currentViewController Superficial:(BOOL)Superficial;

#pragma mark - Subscriptions

-(void)PushToWeDivvyPremiumViewController:(BOOL)viewingSlideShow comingFromSignUp:(BOOL)comingFromSignUp defaultPlan:(NSString *)defaultPlan displayDiscount:(NSString *)displayDiscount selectedSlide:(NSString *)selectedSlide promoCodeID:(NSString *)promoCodeID premiumPlanProductsArray:(NSMutableArray *)premiumPlanProductsArray premiumPlanPricesDict:(NSMutableDictionary *)premiumPlanPricesDict premiumPlanExpensivePricesDict:(NSMutableDictionary *)premiumPlanExpensivePricesDict premiumPlanPricesDiscountDict:(NSMutableDictionary *)premiumPlanPricesDiscountDict premiumPlanPricesNoFreeTrialDict:(NSMutableDictionary *)premiumPlanPricesNoFreeTrialDict currentViewController:(UIViewController *)currentViewController Superficial:(BOOL)Superficial;

#pragma mark - Users

-(void)PushToProfileViewController:(NSString *)userID currentViewController:(UIViewController *)currentViewController;

-(void)PushToEditProfileViewController:(NSString * _Nullable)homeID name:(NSString * _Nullable)name imageURL:(NSString * _Nullable)imageURL editingHome:(BOOL)editingHome currentViewController:(UIViewController *)currentViewController;

#pragma mark - Items

-(void)PushToMultiAddTasksViewController:(BOOL)viewingAddedTasks itemDictFromPreviousPage:(NSMutableDictionary *)itemDictFromPreviousPage itemDictKeysFromPreviousPage:(NSMutableDictionary *)itemDictKeysFromPreviousPage itemSelectedDict:(NSMutableDictionary *)itemSelectedDict homeMembersDict:(NSMutableDictionary *)homeMembersDict notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict topicDict:(NSMutableDictionary *)topicDict folderDict:(NSMutableDictionary *)folderDict taskListDict:(NSMutableDictionary *)taskListDict templateDict:(NSMutableDictionary *)templateDict draftDict:(NSMutableDictionary *)draftDict homeMembersArray:(NSMutableArray *)homeMembersArray itemNamesAlreadyUsed:(NSMutableArray *)itemNamesAlreadyUsed allItemAssignedToArrays:(NSMutableArray *)allItemAssignedToArrays allItemTagsArrays:(NSMutableArray *)allItemTagsArrays defaultTaskListName:(NSString * _Nullable)defaultTaskListName currentViewController:(UIViewController *)currentViewController Superficial:(BOOL)Superficial;

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
                       Superficial:(BOOL)Superficial;

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
                        Superficial:(BOOL)Superficial;

#pragma mark - Views

-(void)PushToViewPromoCodeViewController:(UIViewController *)currentViewController;

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
                  currentViewController:(UIViewController *)currentViewController;

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
                  currentViewController:(UIViewController *)currentViewController;

-(void)PushToViewTaskListsViewController:(NSMutableDictionary *)foldersDict taskListDict:(NSMutableDictionary *)taskListDict itemToEditDict:(NSMutableDictionary * _Nullable)itemToEditDict itemUniqueID:(NSString *)itemUniqueID comingFromTasksViewController:(BOOL)comingFromTasksViewController comingFromViewTaskViewController:(BOOL)comingFromViewTaskViewController currentViewController:(UIViewController *)currentViewController;

-(void)PushToViewMutableOptionsViewController:(NSMutableDictionary * _Nullable)itemsAlreadyChosenDict itemsDict:(NSMutableDictionary *)itemsDict foldersDict:(NSMutableDictionary *)foldersDict viewingSections:(BOOL)viewingSections viewingFolders:(BOOL)viewingFolders homeMembersArray:(NSMutableArray * _Nullable)homeMembersArray homeMembersDict:(NSMutableDictionary * _Nullable)homeMembersDict itemOccurrencesDict:(NSMutableDictionary * _Nullable)itemOccurrencesDict allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays currentViewController:(UIViewController *)currentViewController;

-(void)PushToViewAssignedViewController:(NSMutableArray *)selectedArray itemAssignedToNewHomeMembers:(NSString *)itemAssignedToNewHomeMembers itemAssignedToAnybody:(NSString *)itemAssignedToAnybody itemUniqueID:(NSString *)itemUniqueID homeMembersArray:(NSMutableArray *)homeMembersArray homeMembersDict:(NSMutableDictionary *)homeMembersDict homeMembersUnclaimedDict:(NSMutableDictionary *)homeMembersUnclaimedDict homeKeysDict:(NSMutableDictionary *)homeKeysDict homeKeysArray:(NSMutableArray *)homeKeysArray notificationSettingsDict:(NSMutableDictionary *)notificationSettingsDict topicDict:(NSMutableDictionary *)topicDict viewingItemDetails:(BOOL)viewingItemDetails viewingExpense:(BOOL)viewingExpense viewingChatMembers:(BOOL)viewingChatMembers viewingWeDivvyPremiumAddingAccounts:(BOOL)viewingWeDivvyPremiumAddingAccounts viewingWeDivvyPremiumEditingAccounts:(BOOL)viewingWeDivvyPremiumEditingAccounts currentViewController:(UIViewController *)currentViewController;

-(void)PushToViewOptionsViewController:(NSMutableArray *)itemsSelectedArray customOptionsArray:(NSMutableArray * _Nullable)customOptionsArray specificDatesArray:(NSMutableArray * _Nullable)specificDatesArray viewingItemDetails:(BOOL)viewingItemDetails optionSelectedString:(NSString *)optionSelectedString itemRepeatsFrequency:(NSString * _Nullable)itemRepeatsFrequency homeMembersDict:(NSMutableDictionary * _Nullable)homeMembersDict currentViewController:(UIViewController *)currentViewController;

-(void)PushToViewAddItemsViewController:(NSMutableArray * _Nullable)itemsAlreadyChosenAlready itemsAlreadyChosenDict:(NSMutableDictionary * _Nullable)itemsAlreadyChosenDict userDict:(NSMutableDictionary * _Nullable)userDict optionSelectedString:(NSString *)optionSelectedString itemRepeats:(NSString *)itemRepeats viewingItemDetails:(BOOL)viewingItemDetails currentViewController:(UIViewController *)currentViewController;

-(void)PushToViewViewCostPerPersonViewController:(NSMutableArray *)itemAssignedToArray itemAssignedToUsernameArray:(NSMutableArray *)itemAssignedToUsernameArray itemAssignedToProfileImageArray:(NSMutableArray *)itemAssignedToProfileImageArray itemAmount:(NSString *)itemAmount costPerPersonDict:(NSMutableDictionary *)costPerPersonDict itemItemizedItemsDict:(NSMutableDictionary *)itemItemizedDict viewingItemDetails:(BOOL)viewingItemDetails currentViewController:(UIViewController *)currentViewController;

-(void)PushToViewPaymentMethodViewController:(NSMutableDictionary *)itemPaymentMethodDict viewingReward:(BOOL)viewingReward comingFromAddTaskViewController:(BOOL)comingFromAddTaskViewController viewingItemDetails:(BOOL)viewingItemDetails currentViewController:(UIViewController *)currentViewController;

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
                  currentViewController:(UIViewController *)currentViewController;

-(void)PushToViewTagsViewController:(NSMutableArray * _Nullable)itemsAlreadyChosenAlready allItemTagsArrays:(NSMutableArray * _Nullable)allItemTagsArrays viewingItemDetails:(BOOL)viewingItemDetails comingFromAddTaskViewController:(BOOL)comingFromAddTaskViewController comingFromViewTaskViewController:(BOOL)comingFromViewTaskViewController currentViewController:(UIViewController *)currentViewController;

-(void)PushToViewRemindersViewController:(NSMutableDictionary *)itemsAlreadyChosenDict itemRepeats:(NSString *)itemRepeats itemTime:(NSString *)itemTime itemAssignedTo:(NSMutableArray *)itemAssignedTo viewingItemDetails:(BOOL)viewingItemDetails currentViewController:(UIViewController *)currentViewController;

-(void)PushToViewImageViewController:(UIViewController *)currentViewController itemImage:(UIImage *)itemImage;

-(void)PushToViewVideoViewController:(UIViewController *)currentViewController videoURLString:(NSString *)videoURLString;

@end

NS_ASSUME_NONNULL_END
