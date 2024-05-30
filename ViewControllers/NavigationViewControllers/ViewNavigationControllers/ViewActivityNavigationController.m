//
//  ViewActivityNavigationController.m
//  WeDivvy
//
//  Created by Philip Nagel on 12/13/22.
//

#import "ViewActivityNavigationController.h"
#import "ViewActivityViewController.h"

@interface ViewActivityNavigationController ()

@end

@implementation ViewActivityNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSDictionary *dict = (NSDictionary *)sender;
    
    UINavigationController *navigationController = (UINavigationController*)segue.destinationViewController;
    
    ViewActivityViewController *viewControllerObject = (ViewActivityViewController *)[[navigationController viewControllers] firstObject];

    //
    //
    //BOOL
    viewControllerObject.ViewingHome = dict[@"ViewingHome"] && [dict[@"ViewingHome"] isEqualToString:@"Yes"] ? YES : NO;
    viewControllerObject.ViewingItem = dict[@"ViewingItem"] && [dict[@"ViewingItem"] isEqualToString:@"Yes"] ? YES : NO;

    //
    //
    //NSString
    viewControllerObject.itemID = dict[@"itemID"] ? dict[@"itemID"] : @"";
    
    //
    //
    //NSArray
    viewControllerObject.homeMembersArray = dict[@"homeMembersArray"] ? dict[@"homeMembersArray"] : [NSMutableArray array];
    viewControllerObject.itemNamesAlreadyUsed = dict[@"itemNamesAlreadyUsed"] ? dict[@"itemNamesAlreadyUsed"] : [NSMutableArray array];
    viewControllerObject.allItemAssignedToArrays = dict[@"allItemAssignedToArrays"] ? dict[@"allItemAssignedToArrays"] : [NSMutableArray array];
    viewControllerObject.allItemTagsArrays = dict[@"allItemTagsArrays"] ? dict[@"allItemTagsArrays"] : [NSMutableArray array];
    
    //
    //
    //NSDictionary
    viewControllerObject.homeMembersDict = dict[@"homeMembersDict"] ? dict[@"homeMembersDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.folderDict = dict[@"folderDict"] ? dict[@"folderDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.taskListDict = dict[@"taskListDict"] ? dict[@"taskListDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.templateDict = dict[@"templateDict"] ? dict[@"templateDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.draftDict = dict[@"draftDict"] ? dict[@"draftDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.notificationSettingsDict = dict[@"notificationSettingsDict"] ? dict[@"notificationSettingsDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.topicDict = dict[@"topicDict"] ? dict[@"topicDict"] : [NSMutableDictionary dictionary];
    
}

@end
