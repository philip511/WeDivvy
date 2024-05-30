//
//  AnalyticsViewController.h
//  WeDivvy
//
//  Created by Philip Nagel on 9/5/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnalyticsViewController : UIViewController

-(void)GetLocalNotifications:(BOOL)deletePendingNotifications;

#pragma mark - Get Data

#pragma mark Analytics

-(void)GetDataActiveUsers:(BOOL)CheckingRetentionUsers;

-(void)GetDataLastNumberOfMixPanelIDs:(int)number;

#pragma mark Crashes

-(void)GetDataUserIDOfCrahesOnAppVersion:(NSString *)appVersion completionHandler:(void (^)(BOOL finished, NSString *userID))finishBlock;

#pragma mark Homes

-(void)GetDataHomeIDOfUserID:(NSString *)userID completionHandler:(void (^)(BOOL finished, NSString *itemHomeID))finishBlock;

-(void)GetDataHomeMemberData:(int)numberOfHomes;

#pragma mark Items

-(void)GetDataItemsForSpecificHomeID:(NSString *)itemType homeID:(NSString *)homeID;

-(void)GetDataAverageAndMedianTasksForArrayOfMixPanelIDs;

#pragma mark Users

-(void)GetDataReceiveUpdateEmails:(NSString *)yesOrNo;

-(void)GetDataEmailsWithinSpecificDate:(NSString *)dateToCheck;

-(void)GetDataEmailsFromMixPanelIDEmailArray:(NSArray *)mixPanelIDArray;

#pragma mark Compound

-(void)GetDataRetention;

-(void)GetDataRetentionMonthly;

-(void)GetDataRetentionDaily;

-(void)GetDataWeDivvyPremiumPaths;

-(void)GetDataWeDivvyPremiumPurchasedPaths;

-(void)GetDataSubscriptionsMixPanelIDs;

-(void)GetDataSubscriptionsCancelled;

-(void)GetDataSignUpFunnel;

-(void)GetDataCrashes:(NSString *)dateToCheck;

-(void)GetDataSubscriptionPassedFreeTrial:(NSString *)startingWeek endingWeek:(NSString *)endingWeek;

-(void)GetDataSubscriptionUsersBetweensStartingWeek:(NSString *)startingWeek endingWeek:(NSString *)endingWeek;

-(void)GetDataSubscriptionData;

-(void)GetDataCompletions;

-(void)GetDataSignedUpAccounts;

-(void)GetDataCrashes;

-(void)GetDataHeardAboutUs;

-(void)GetDataSubscriptionChurn;

#pragma mark Others

-(void)GetDataMixPanelIDsThatAreDifferent:(NSArray *)previousArr currentArr:(NSArray *)currentArr Quotations:(BOOL)Quotations;

#pragma mark - Set Data

#pragma mark Chats

-(void)SetDataChatsMissingKeys;

#pragma mark Forum

-(void)SetDataForumMissingKeys;

#pragma mark Homes

-(void)SetDataHomeMissingKeys;

-(void)SetDataCopyHomeWithID:(NSString *)homeID completionHandler:(void (^)(BOOL finished))finishBlock;

-(void)SetDataHomesOfCrashedUsersForAppVersion:(NSString *)appVersion arrayOfHomeIDs:(NSArray *)arrayOfHomeIDs;

#pragma mark Items

-(void)SetDataChoresMissingKeys;

-(void)SetDataChoresOccurrencesMissingKeys;

-(void)SetDataExpensesMissingKeys;

-(void)SetDataExpensesOccurrencesMissingKeys;

-(void)SetDataListsMissingKeys;

-(void)SetDataListsOccurrencesMissingKeys;

#pragma mark Notifications

-(void)SetDataNotificationsMissingKeys;

#pragma mark Users

-(void)SetDataUserMissingKeys;

-(void)SetDataReceiveUpdateEmailsForEmailArray:(NSArray *)emailArray yesOrNo:(NSString *)yesOrNo;

#pragma mark - Delete Data

#pragma mark Homes

-(void)DeleteDataNonExistentHomeMembersFromTasks;

#pragma mark Items

-(void)DeleteDataTasksAndGroupChats;

-(void)DeleteDataDuplicatesFromAssignedTo;

#pragma mark Users

-(void)DeleteDataUserAccount:(NSString *)userID userEmail:(NSString *)userEmail;

-(void)DeleteDataArrayOf10UsersWithUsernameContainingStrings:(NSArray *)stringArr;

#pragma mark - Analytics

-(BOOL)date:(NSDate*)date isBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate;

@end

NS_ASSUME_NONNULL_END
