//
//  NotificationSettingsNavigationController.m
//  WeDivvy
//
//  Created by Philip Nagel on 7/8/23.
//

#import "NotificationSettingsNavigationController.h"
#import "NotificationSettingsViewController.h"

@interface NotificationSettingsNavigationController ()

@end

@implementation NotificationSettingsNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSDictionary *dict = (NSDictionary *)sender;
    
    UINavigationController *navigationController = (UINavigationController*)segue.destinationViewController;
    
    NotificationSettingsViewController *viewControllerObject = (NotificationSettingsViewController *)[[navigationController viewControllers] firstObject];
    
    //
    //
    //BOOL
    viewControllerObject.ViewingChores = dict[@"viewingChores"] && [dict[@"viewingChores"] isEqualToString:@"Yes"] ? YES : NO;
    viewControllerObject.ViewingExpenses = dict[@"viewingExpenses"] && [dict[@"viewingExpenses"] isEqualToString:@"Yes"] ? YES : NO;
    viewControllerObject.ViewingLists = dict[@"viewingLists"] && [dict[@"viewingLists"] isEqualToString:@"Yes"] ? YES : NO;
    viewControllerObject.ViewingGroupChats = dict[@"viewingGroupChats"] && [dict[@"viewingGroupChats"] isEqualToString:@"Yes"] ? YES : NO;
    viewControllerObject.ViewingHomeMembers = dict[@"viewingHomeMembers"] && [dict[@"viewingHomeMembers"] isEqualToString:@"Yes"] ? YES : NO;
    viewControllerObject.ViewingForum = dict[@"viewingForum"] && [dict[@"viewingForum"] isEqualToString:@"Yes"] ? YES : NO;
    viewControllerObject.ViewingScheduledSummary = dict[@"viewingScheduledSummary"] && [dict[@"viewingScheduledSummary"] isEqualToString:@"Yes"] ? YES : NO;
    viewControllerObject.ViewingScheduledSummaryTaskTypes = dict[@"viewingScheduledSummaryTaskTypes"] && [dict[@"viewingScheduledSummaryTaskTypes"] isEqualToString:@"Yes"] ? YES : NO;
    
    //
    //
    //NSDictionary
    viewControllerObject.notificationSettings = dict[@"notificationSettings"] ? dict[@"notificationSettings"] : [NSMutableDictionary dictionary];

}


@end
