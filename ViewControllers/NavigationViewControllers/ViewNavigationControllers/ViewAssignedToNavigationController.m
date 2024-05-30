//
//  ViewAssignedToNavigationController.m
//  WeDivvy
//
//  Created by Philip Nagel on 9/8/22.
//

#import "ViewAssignedToNavigationController.h"
#import "ViewAssignedToViewController.h"

@interface ViewAssignedToNavigationController ()

@end

@implementation ViewAssignedToNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
 
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    NSDictionary *dict = (NSDictionary *)sender;
    
    UINavigationController *navigationController = (UINavigationController*)segue.destinationViewController;
    
    ViewAssignedToViewController *viewControllerObject = (ViewAssignedToViewController *)[[navigationController viewControllers] firstObject];

    //
    //
    //BOOL
    viewControllerObject.viewingItemDetails = dict[@"viewingItemDetails"] && [dict[@"viewingItemDetails"] isEqualToString:@"Yes"] ? YES : NO;
    viewControllerObject.viewingExpense = dict[@"viewingExpense"] && [dict[@"viewingExpense"] isEqualToString:@"Yes"] ? YES : NO;
    viewControllerObject.viewingChatMembers = dict[@"viewingChatMembers"] && [dict[@"viewingChatMembers"] isEqualToString:@"Yes"] ? YES : NO;
    viewControllerObject.viewingWeDivvyPremiumAddingAccounts = dict[@"viewingWeDivvyPremiumAddingAccounts"] && [dict[@"viewingWeDivvyPremiumAddingAccounts"] isEqualToString:@"Yes"] ? YES : NO;
    viewControllerObject.viewingWeDivvyPremiumEditingAccounts = dict[@"viewingWeDivvyPremiumEditingAccounts"] && [dict[@"viewingWeDivvyPremiumEditingAccounts"] isEqualToString:@"Yes"] ? YES : NO;

    //
    //
    //NSString
    viewControllerObject.itemAssignedToAnybody = dict[@"itemAssignedToAnybody"] ? dict[@"itemAssignedToAnybody"] : @"";
    viewControllerObject.itemAssignedToNewHomeMembers = dict[@"itemAssignedToNewHomeMembers"] ? dict[@"itemAssignedToNewHomeMembers"] : @"";
    viewControllerObject.itemUniqueID = dict[@"itemUniqueID"] ? dict[@"itemUniqueID"] : @"";
    
    //
    //
    //NSArray
    viewControllerObject.selectedArray = dict[@"selectedArray"] ? dict[@"selectedArray"] : [NSMutableArray array];
    viewControllerObject.homeMembersArray = dict[@"homeMembersArray"] ? dict[@"homeMembersArray"] : [NSMutableArray array];
    viewControllerObject.homeKeysArray = dict[@"homeKeysArray"] ? dict[@"homeKeysArray"] : [NSMutableArray array];
    
    //
    //
    //NSDictionary
    viewControllerObject.homeMembersDict = dict[@"homeMembersDict"] ? dict[@"homeMembersDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.homeMembersUnclaimedDict = dict[@"homeMembersUnclaimedDict"] ? dict[@"homeMembersUnclaimedDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.homeKeysDict = dict[@"homeKeysDict"] ? dict[@"homeKeysDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.notificationSettingsDict = dict[@"notificationSettingsDict"] ? dict[@"notificationSettingsDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.topicDict = dict[@"topicDict"] ? dict[@"topicDict"] : [NSMutableDictionary dictionary];
    
}

@end
