//
//  ViewTaskListsNavigationController.m
//  WeDivvy
//
//  Created by Philip Nagel on 9/22/22.
//

#import "ViewTaskListsNavigationController.h"
#import "ViewTaskListsViewController.h"

@interface ViewTaskListsNavigationController ()

@end

@implementation ViewTaskListsNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSDictionary *dict = (NSDictionary *)sender;
    
    UINavigationController *navigationController = (UINavigationController*)segue.destinationViewController;
    
    ViewTaskListsViewController *viewControllerObject = (ViewTaskListsViewController *)[[navigationController viewControllers] firstObject];
    
    //
    //
    //BOOL
    viewControllerObject.comingFromTasksViewController = dict[@"comingFromTasksViewController"] && [dict[@"comingFromTasksViewController"] isEqualToString:@"Yes"] ? YES : NO;
    viewControllerObject.comingFromViewTaskViewController = dict[@"comingFromViewTaskViewController"] && [dict[@"comingFromViewTaskViewController"] isEqualToString:@"Yes"] ? YES : NO;
    
    //
    //
    //NSDictionary
    viewControllerObject.foldersDict = dict[@"foldersDict"] ? dict[@"foldersDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.taskListDict = dict[@"taskListDict"] ? dict[@"taskListDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.itemToEditDict = dict[@"itemToEditDict"] ? dict[@"itemToEditDict"] : [NSMutableDictionary dictionary];
    
    //
    //
    //NSString
    viewControllerObject.itemUniqueID = dict[@"itemUniqueID"] ? dict[@"itemUniqueID"] : @"";
    
}

@end
