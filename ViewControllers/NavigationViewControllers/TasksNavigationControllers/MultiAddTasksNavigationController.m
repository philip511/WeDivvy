//
//  MultiAddTasksNavigationController.m
//  WeDivvy
//
//  Created by Philip Nagel on 9/8/22.
//

#import "MultiAddTasksNavigationController.h"
#import "MultiAddTasksViewController.h"

@interface MultiAddTasksNavigationController ()

@end

@implementation MultiAddTasksNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSDictionary *dict = (NSDictionary *)sender;
    
    UINavigationController *navigationController = (UINavigationController*)segue.destinationViewController;
    
    MultiAddTasksViewController *viewControllerObject = (MultiAddTasksViewController *)[[navigationController viewControllers] firstObject];
    
    viewControllerObject.defaultTaskListName = dict[@"defaultTaskListName"] ? dict[@"defaultTaskListName"] : @"";
  
    viewControllerObject.itemDictFromPreviousPage = dict[@"itemDictFromPreviousPage"] ? dict[@"itemDictFromPreviousPage"] : [NSMutableDictionary dictionary];
    viewControllerObject.itemDictKeysFromPreviousPage = dict[@"itemDictKeysFromPreviousPage"] ? dict[@"itemDictKeysFromPreviousPage"] : [NSMutableDictionary dictionary];
    viewControllerObject.itemSelectedDict = dict[@"itemSelectedDict"] ? dict[@"itemSelectedDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.homeMembersDict = dict[@"homeMembersDict"] ? dict[@"homeMembersDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.notificationSettingsDict = dict[@"notificationSettingsDict"] ? dict[@"notificationSettingsDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.topicDict = dict[@"topicDict"] ? dict[@"topicDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.folderDict = dict[@"folderDict"] ? dict[@"folderDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.taskListDict = dict[@"taskListDict"] ? dict[@"taskListDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.templateDict = dict[@"templateDict"] ? dict[@"templateDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.draftDict = dict[@"draftDict"] ? dict[@"draftDict"] : [NSMutableDictionary dictionary];
    
    viewControllerObject.homeMembersArray = dict[@"homeMembersArray"] ? dict[@"homeMembersArray"] : [NSMutableArray array];
    viewControllerObject.itemNamesAlreadyUsed = dict[@"itemNamesAlreadyUsed"] ? dict[@"itemNamesAlreadyUsed"] : [NSMutableArray array];
    viewControllerObject.allItemAssignedToArrays = dict[@"allItemAssignedToArrays"] ? dict[@"allItemAssignedToArrays"] : [NSMutableArray array];
    viewControllerObject.allItemTagsArrays = dict[@"allItemTagsArrays"] ? dict[@"allItemTagsArrays"] : [NSMutableArray array];
    
    viewControllerObject.viewingAddedTasks = dict[@"viewingAddedTasks"] && [dict[@"viewingAddedTasks"] isEqualToString:@"Yes"] ? YES : NO;
    
}

@end
