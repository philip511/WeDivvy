//
//  AddTaskNavigationController.m
//  WeDivvy
//
//  Created by Philip Nagel on 9/8/22.
//

#import "AddTaskNavigationController.h"
#import "AddTaskViewController.h"

@interface AddTaskNavigationController ()

@end

@implementation AddTaskNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSDictionary *dict = (NSDictionary *)sender;
    
    UINavigationController *navigationController = (UINavigationController*)segue.destinationViewController;
    
    AddTaskViewController *viewControllerObject = (AddTaskViewController *)[[navigationController viewControllers] firstObject];
    
    //
    //
    //BOOL
    viewControllerObject.viewingAddExpenseViewController = dict[@"viewingAddExpenseViewController"] && [dict[@"viewingAddExpenseViewController"] isEqualToString:@"Yes"] ? YES : NO;
    viewControllerObject.viewingAddListViewController = dict[@"viewingAddListViewController"] && [dict[@"viewingAddListViewController"] isEqualToString:@"Yes"] ? YES : NO;
    viewControllerObject.partiallyAddedTask = dict[@"partiallyAddedTask"] && [dict[@"partiallyAddedTask"] isEqualToString:@"Yes"] ? YES : NO;
    viewControllerObject.addingTask = dict[@"addingTask"] && [dict[@"addingTask"] isEqualToString:@"Yes"] ? YES : NO;
    viewControllerObject.addingMultipleTasks = dict[@"addingMultipleTasks"] && [dict[@"addingMultipleTasks"] isEqualToString:@"Yes"] ? YES : NO;
    viewControllerObject.addingSuggestedTask = dict[@"addingSuggestedTask"] && [dict[@"addingSuggestedTask"] isEqualToString:@"Yes"] ? YES : NO;
    viewControllerObject.editingTask = dict[@"editingTask"] && [dict[@"editingTask"] isEqualToString:@"Yes"] ? YES : NO;
    viewControllerObject.viewingTask = dict[@"viewingTask"] && [dict[@"viewingTask"] isEqualToString:@"Yes"] ? YES : NO;
    viewControllerObject.viewingMoreOptions = dict[@"viewingMoreOptions"] && [dict[@"viewingMoreOptions"] isEqualToString:@"Yes"] ? YES : NO;
    viewControllerObject.duplicatingTask = dict[@"duplicatingTask"] && [dict[@"duplicatingTask"] isEqualToString:@"Yes"] ? YES : NO;
    viewControllerObject.editingTemplate = dict[@"editingTemplate"] && [dict[@"editingTemplate"] isEqualToString:@"Yes"] ? YES : NO;
    viewControllerObject.viewingTemplate = dict[@"viewingTemplate"] && [dict[@"viewingTemplate"] isEqualToString:@"Yes"] ? YES : NO;
    viewControllerObject.editingDraft = dict[@"editingDraft"] && [dict[@"editingDraft"] isEqualToString:@"Yes"] ? YES : NO;
    viewControllerObject.viewingDraft = dict[@"viewingDraft"] && [dict[@"viewingDraft"] isEqualToString:@"Yes"] ? YES : NO;
    
    //
    //
    //NSString
    viewControllerObject.homeID = dict[@"homeID"] ? dict[@"homeID"] : @"xxx";
    viewControllerObject.defaultTaskListName = dict[@"defaultTaskListName"] ? dict[@"defaultTaskListName"] : @"";

    //
    //
    //NSArray
    viewControllerObject.homeMembersArray = dict[@"homeMembersArray"] ? dict[@"homeMembersArray"] : [NSMutableArray array];
    viewControllerObject.allItemAssignedToArrays = dict[@"allItemAssignedToArrays"] ? dict[@"allItemAssignedToArrays"] : [NSMutableArray array];
    viewControllerObject.allItemTagsArrays = dict[@"allItemTagsArrays"] ? dict[@"allItemTagsArrays"] : [NSMutableArray array];
    viewControllerObject.allItemIDsArrays = dict[@"allItemIDsArrays"] ? dict[@"allItemIDsArrays"] : [NSMutableArray array];
    
    //
    //
    //NSDictionary
    viewControllerObject.homeMembersDict = dict[@"homeMembersDict"] ? dict[@"homeMembersDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.itemOccurrencesDict = dict[@"itemOccurrencesDict"] ? dict[@"itemOccurrencesDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.folderDict = dict[@"folderDict"] ? dict[@"folderDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.taskListDict = dict[@"taskListDict"] ? dict[@"taskListDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.templateDict = dict[@"templateDict"] ? dict[@"templateDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.draftDict = dict[@"draftDict"] ? dict[@"draftDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.itemToEditDict = dict[@"itemToEditDict"] ? dict[@"itemToEditDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.partiallyAddedDict = dict[@"partiallyAddedDict"] ? dict[@"partiallyAddedDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.suggestedItemToAddDict = dict[@"suggestedItemToAddDict"] ? dict[@"suggestedItemToAddDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.templateToEditDict = dict[@"templateToEditDict"] ? dict[@"templateToEditDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.draftToEditDict = dict[@"draftToEditDict"] ? dict[@"draftToEditDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.moreOptionsDict = dict[@"moreOptionsDict"] ? dict[@"moreOptionsDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.multiAddDict = dict[@"multiAddDict"] ? dict[@"multiAddDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.notificationSettingsDict = dict[@"notificationSettingsDict"] ? dict[@"notificationSettingsDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.topicDict = dict[@"topicDict"] ? dict[@"topicDict"] : [NSMutableDictionary dictionary];
    
}

@end
