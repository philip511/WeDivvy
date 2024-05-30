//
//  ViewCalendarNavigationController.m
//  WeDivvy
//
//  Created by Philip Nagel on 9/26/22.
//

#import "ViewCalendarNavigationController.h"
#import "ViewCalendarViewController.h"

@interface ViewCalendarNavigationController ()

@end

@implementation ViewCalendarNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSDictionary *dict = (NSDictionary *)sender;
    
    UINavigationController *navigationController = (UINavigationController*)segue.destinationViewController;
    
    ViewCalendarViewController *viewControllerObject = (ViewCalendarViewController *)[[navigationController viewControllers] firstObject];
    
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
    viewControllerObject.itemsDict = dict[@"itemsDict"] ? dict[@"itemsDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.itemsDictNo2 = dict[@"itemsDictNo2"] ? dict[@"itemsDictNo2"] : [NSMutableDictionary dictionary];
    viewControllerObject.itemsDictNo3 = dict[@"itemsDictNo3"] ? dict[@"itemsDictNo3"] : [NSMutableDictionary dictionary];
    viewControllerObject.itemsOccurrencesDict = dict[@"itemsOccurrencesDict"] ? dict[@"itemsOccurrencesDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.itemsOccurrencesDictNo2 = dict[@"itemsOccurrencesDictNo2"] ? dict[@"itemsOccurrencesDictNo2"] : [NSMutableDictionary dictionary];
    viewControllerObject.itemsOccurrencesDictNo3 = dict[@"itemsOccurrencesDictNo3"] ? dict[@"itemsOccurrencesDictNo3"] : [NSMutableDictionary dictionary];
    viewControllerObject.homeMembersDict = dict[@"homeMembersDict"] ? dict[@"homeMembersDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.folderDict = dict[@"folderDict"] ? dict[@"folderDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.taskListDict = dict[@"taskListDict"] ? dict[@"taskListDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.sectionDict = dict[@"sectionDict"] ? dict[@"sectionDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.templateDict = dict[@"templateDict"] ? dict[@"templateDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.draftDict = dict[@"draftDict"] ? dict[@"draftDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.notificationSettingsDict = dict[@"notificationSettingsDict"] ? dict[@"notificationSettingsDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.topicDict = dict[@"topicDict"] ? dict[@"topicDict"] : [NSMutableDictionary dictionary];
    
}

@end
