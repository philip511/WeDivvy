//
//  AddChatNavigationController.m
//  WeDivvy
//
//  Created by Philip Nagel on 10/6/22.
//

#import "AddChatNavigationController.h"

#import "AddChatViewController.h"

@interface AddChatNavigationController ()

@end

@implementation AddChatNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSDictionary *dict = (NSDictionary *)sender;
    
    UINavigationController *navigationController = (UINavigationController*)segue.destinationViewController;

    AddChatViewController *viewControllerObject = (AddChatViewController *)[[navigationController viewControllers] firstObject];
    
    //
    //
    //NSArray
    viewControllerObject.homeMembersArray = dict[@"homeMembersArray"] ? dict[@"homeMembersArray"] : [NSMutableArray array];
    
    //
    //
    //NSDictionary
    viewControllerObject.itemToEditDict = dict[@"itemToEditDict"] ? dict[@"itemToEditDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.homeMembersDict = dict[@"homeMembersDict"] ? dict[@"homeMembersDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.notificationSettingsDict = dict[@"notificationSettingsDict"] ? dict[@"notificationSettingsDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.topicDict = dict[@"topicDict"] ? dict[@"topicDict"] : [NSMutableDictionary dictionary];
    
}

@end
