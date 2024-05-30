//
//  ViewCostPerPersonNavigationController.m
//  WeDivvy
//
//  Created by Philip Nagel on 9/8/22.
//

#import "ViewCostPerPersonNavigationController.h"
#import "ViewCostPerPersonViewController.h"

@interface ViewCostPerPersonNavigationController ()

@end

@implementation ViewCostPerPersonNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSDictionary *dict = (NSDictionary *)sender;
    
    UINavigationController *navigationController = (UINavigationController*)segue.destinationViewController;
    
    ViewCostPerPersonViewController *viewControllerObject = (ViewCostPerPersonViewController *)[[navigationController viewControllers] firstObject];
    
    //
    //
    //BOOL
    viewControllerObject.viewingItemDetails = dict[@"viewingItemDetails"] && [dict[@"viewingItemDetails"] isEqualToString:@"Yes"] ? YES : NO;
    
    //
    //
    //NSString
    viewControllerObject.itemAmountFromPreviousPage = dict[@"itemAmountFromPreviousPage"] ? dict[@"itemAmountFromPreviousPage"] : @"";
    
    //
    //
    //NSArray
    viewControllerObject.itemAssignedToArray = dict[@"itemAssignedToArray"] ? dict[@"itemAssignedToArray"] : [NSMutableArray array];
    viewControllerObject.itemAssignedToUsernameArray = dict[@"itemAssignedToUsernameArray"] ? dict[@"itemAssignedToUsernameArray"] : [NSMutableArray array];
    viewControllerObject.itemAssignedToProfileImageArray = dict[@"itemAssignedToProfileImageArray"] ? dict[@"itemAssignedToProfileImageArray"] : [NSMutableArray array];
    
    //
    //
    //NSDictionary
    viewControllerObject.costPerPersonDict = dict[@"costPerPersonDict"] ? dict[@"costPerPersonDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.itemItemizedItemsDict = dict[@"itemItemizedItemsDict"] ? dict[@"itemItemizedItemsDict"] : [NSMutableDictionary dictionary];
    
}

@end
