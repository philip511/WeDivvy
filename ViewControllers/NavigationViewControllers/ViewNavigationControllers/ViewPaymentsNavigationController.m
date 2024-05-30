//
//  ViewPaymentsNavigationController.m
//  WeDivvy
//
//  Created by Philip Nagel on 2/2/23.
//

#import "ViewPaymentsNavigationController.h"

#import "ViewPaymentsViewController.h"

@interface ViewPaymentsNavigationController ()

@end

@implementation ViewPaymentsNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSDictionary *dict = (NSDictionary *)sender;
    
    UINavigationController *navigationController = (UINavigationController*)segue.destinationViewController;
    
    ViewPaymentsViewController *viewControllerObject = (ViewPaymentsViewController *)[[navigationController viewControllers] firstObject];
    
    //
    //
    //BOOL
    viewControllerObject.viewingOwed = dict[@"viewingOwed"] && [dict[@"viewingOwed"] isEqualToString:@"Yes"] ? YES : NO;
    viewControllerObject.viewingEarned = dict[@"viewingEarned"] && [dict[@"viewingEarned"] isEqualToString:@"Yes"] ? YES : NO;
    
    //
    //
    //NSString
    viewControllerObject.viewingUserIDWhoIsOwedMoney = dict[@"viewingUserIDWhoIsOwedMoney"] ? dict[@"viewingUserIDWhoIsOwedMoney"] : @"";
    viewControllerObject.viewingUserIDWhoOwesMoney = dict[@"viewingUserIDWhoOwesMoney"] ? dict[@"viewingUserIDWhoOwesMoney"] : @"";
    
    //
    //
    //NSArray
    viewControllerObject.homeMembersArray = dict[@"homeMembersArray"] ? dict[@"homeMembersArray"] : [NSMutableArray array];
    viewControllerObject.itemNamesAlreadyUsed = dict[@"itemNamesAlreadyUsed"] ? dict[@"itemNamesAlreadyUsed"] : [NSMutableArray array];
    viewControllerObject.allItemAssignedToArrays = dict[@"allItemAssignedToArrays"] ? dict[@"allItemAssignedToArrays"] : [NSMutableArray array];
    viewControllerObject.allItemTagsArrays = dict[@"allItemTagsArrays"] ? dict[@"allItemTagsArrays"] : [NSMutableArray array];
    viewControllerObject.allItemIDsArrays = dict[@"allItemIDsArrays"] ? dict[@"allItemIDsArrays"] : [NSMutableArray array];
 
    //
    //
    //NSDictionary
    viewControllerObject.itemDict = dict[@"itemDict"] ? dict[@"itemDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.dataDisplayDict = dict[@"dataDisplayDict"] ? dict[@"dataDisplayDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.homeMembersDict = dict[@"homeMembersDict"] ? dict[@"homeMembersDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.folderDict = dict[@"folderDict"] ? dict[@"folderDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.taskListDict = dict[@"taskListDict"] ? dict[@"taskListDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.templateDict = dict[@"templateDict"] ? dict[@"templateDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.draftDict = dict[@"draftDict"] ? dict[@"draftDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.notificationSettingsDict = dict[@"notificationSettingsDict"] ? dict[@"notificationSettingsDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.topicDict = dict[@"topicDict"] ? dict[@"topicDict"] : [NSMutableDictionary dictionary];
    
}

@end
