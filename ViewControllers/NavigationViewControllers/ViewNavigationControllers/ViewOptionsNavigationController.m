//
//  ViewOptionsNavigationController.m
//  WeDivvy
//
//  Created by Philip Nagel on 9/8/22.
//

#import "ViewOptionsNavigationController.h"
#import "ViewOptionsViewController.h"

@interface ViewOptionsNavigationController ()

@end

@implementation ViewOptionsNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSDictionary *dict = (NSDictionary *)sender;
    
    UINavigationController *navigationController = (UINavigationController*)segue.destinationViewController;
    
    ViewOptionsViewController *viewControllerObject = (ViewOptionsViewController *)[[navigationController viewControllers] firstObject];
    
    //
    //
    //BOOL
    viewControllerObject.viewingItemDetails = dict[@"viewingItemDetails"] && [dict[@"viewingItemDetails"] isEqualToString:@"Yes"] ? YES : NO;
    
    //
    //
    //NSString
    viewControllerObject.optionSelectedString = dict[@"optionSelectedString"] ? dict[@"optionSelectedString"] : @"";
    viewControllerObject.itemRepeatsFrequency = dict[@"itemRepeatsFrequency"] ? dict[@"itemRepeatsFrequency"] : @"";
    
    //
    //
    //NSArray
    viewControllerObject.customOptionsArray = dict[@"customOptionsArray"] ? dict[@"customOptionsArray"] : [NSMutableArray array];
    viewControllerObject.itemsSelectedArray = dict[@"itemsSelectedArray"] ? dict[@"itemsSelectedArray"] : [NSMutableArray array];
    viewControllerObject.specificDatesArray = dict[@"specificDatesArray"] ? dict[@"specificDatesArray"] : [NSMutableArray array];
    
    //
    //
    //NSDictionary
    viewControllerObject.homeMembersDict = dict[@"homeMembersDict"] ? dict[@"homeMembersDict"] : [NSMutableDictionary dictionary];
     
}

@end
