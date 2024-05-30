//
//  ViewTaskNavigationController.m
//  WeDivvy
//
//  Created by Philip Nagel on 10/5/22.
//

#import "ViewTaskNavigationController.h"

#import "ViewTaskViewController.h"

@interface ViewTaskNavigationController ()

@end

@implementation ViewTaskNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSDictionary *dict = (NSDictionary *)sender;
    
    UINavigationController *navigationController = (UINavigationController*)segue.destinationViewController;
    
    ViewTaskViewController *viewControllerObject = (ViewTaskViewController *)[[navigationController viewControllers] firstObject];
   
    //
    //
    //BOOL
    viewControllerObject.viewingOccurrence = dict[@"viewingOccurrence"] && [dict[@"viewingOccurrence"] isEqualToString:@"Yes"] ? YES : NO;
    viewControllerObject.viewingViewExpenseViewController = dict[@"viewingViewExpenseViewController"] && [dict[@"viewingViewExpenseViewController"] isEqualToString:@"Yes"] ? YES : NO;
    viewControllerObject.viewingViewListViewController = dict[@"viewingViewListViewController"] && [dict[@"viewingViewListViewController"] isEqualToString:@"Yes"] ? YES : NO;
    
    //
    //
    //NSString
    viewControllerObject.itemID = dict[@"itemID"] ? dict[@"itemID"] : @"";
    viewControllerObject.itemOccurrenceID = dict[@"itemOccurrenceID"] ? dict[@"itemOccurrenceID"] : @"";
    
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
    viewControllerObject.itemDictFromPreviousPage = dict[@"itemDictFromPreviousPage"] ? dict[@"itemDictFromPreviousPage"] : [NSMutableDictionary dictionary];
    viewControllerObject.itemOccurrencesDict = dict[@"itemOccurrencesDict"] ? dict[@"itemOccurrencesDict"] : [NSMutableDictionary dictionary];
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
