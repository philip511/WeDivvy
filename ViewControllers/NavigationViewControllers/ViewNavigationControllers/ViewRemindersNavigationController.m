//
//  ViewRemindersNavigationController.m
//  WeDivvy
//
//  Created by Philip Nagel on 2/25/23.
//

#import "ViewRemindersNavigationController.h"
#import "ViewRemindersViewController.h"

@interface ViewRemindersNavigationController ()

@end

@implementation ViewRemindersNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSDictionary *dict = (NSDictionary *)sender;
    
    UINavigationController *navigationController = (UINavigationController*)segue.destinationViewController;
    
    ViewRemindersViewController *viewControllerObject = (ViewRemindersViewController *)[[navigationController viewControllers] firstObject];
    
    //
    //
    //BOOL
    viewControllerObject.viewingItemDetails = dict[@"viewingItemDetails"] && [dict[@"viewingItemDetails"] isEqualToString:@"Yes"] ? YES : NO;
    
    //
    //
    //NSString
    viewControllerObject.itemRepeats = dict[@"itemRepeats"] ? dict[@"itemRepeats"] : @"";
    viewControllerObject.itemTime = dict[@"itemTime"] ? dict[@"itemTime"] : @"";
    
    //
    //
    //NSArray
    viewControllerObject.itemAssignedTo = dict[@"itemAssignedTo"] ? dict[@"itemAssignedTo"] : [NSMutableArray array];
    
    //
    //
    //NSDictionary
    viewControllerObject.itemsAlreadyChosenDict = dict[@"itemsAlreadyChosenDict"] ? dict[@"itemsAlreadyChosenDict"] : [NSMutableDictionary dictionary];
    
}

@end
