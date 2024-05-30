//
//  LiveChatNavigationController.m
//  WeDivvy
//
//  Created by Philip Nagel on 10/23/22.
//

#import "LiveChatNavigationController.h"
#import "LiveChatViewController.h"

@interface LiveChatNavigationController ()

@end

@implementation LiveChatNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSDictionary *dict = (NSDictionary *)sender;
    
    UINavigationController *navigationController = (UINavigationController*)segue.destinationViewController;
    
    LiveChatViewController *viewControllerObject = (LiveChatViewController *)[[navigationController viewControllers] firstObject];
    
    //
    //
    //BOOL
    viewControllerObject.viewingGroupChat = [dict[@"viewingGroupChat"] isEqualToString:@"Yes"] ? YES : NO;
    viewControllerObject.viewingComments = [dict[@"viewingComments"] isEqualToString:@"Yes"] ? YES : NO;
    viewControllerObject.viewingLiveSupport = [dict[@"viewingLiveSupport"] isEqualToString:@"Yes"] ? YES : NO;
    
    //
    //
    //NSString
    viewControllerObject.userID = dict[@"userID"] ? dict[@"userID"] : @"";
    viewControllerObject.homeID = dict[@"homeID"] ? dict[@"homeID"] : @"xxx";
    viewControllerObject.chatID = dict[@"chatID"] ? dict[@"chatID"] : @"";
    viewControllerObject.chatName = dict[@"chatName"] ? dict[@"chatName"] : @"";
    viewControllerObject.itemID = dict[@"itemID"] ? dict[@"itemID"] : @"";
    viewControllerObject.itemName = dict[@"itemName"] ? dict[@"itemName"] : @"";
    
    //
    //
    //NSArray
    viewControllerObject.itemCreatedBy = dict[@"itemCreatedBy"] ? dict[@"itemCreatedBy"] : [NSMutableArray array];
    viewControllerObject.chatAssignedTo = dict[@"chatAssignedTo"] ? dict[@"chatAssignedTo"] : [NSMutableArray array];
    viewControllerObject.itemAssignedTo = dict[@"itemAssignedTo"] ? dict[@"itemAssignedTo"] : [NSMutableArray array];
    
    //
    //
    //NSDictionary
    viewControllerObject.homeMembersDict = dict[@"homeMembersDict"] ? dict[@"homeMembersDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.notificationSettingsDict = dict[@"notificationSettingsDict"] ? dict[@"notificationSettingsDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.topicDict = dict[@"topicDict"] ? dict[@"topicDict"] : [NSMutableDictionary dictionary];
    
}

@end
