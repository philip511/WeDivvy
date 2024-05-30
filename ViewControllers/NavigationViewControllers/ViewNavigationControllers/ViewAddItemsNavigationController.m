//
//  ViewAddItemsNavigationController.m
//  WeDivvy
//
//  Created by Philip Nagel on 9/8/22.
//

#import "ViewAddItemsNavigationController.h"
#import "ViewAddItemsViewController.h"

@interface ViewAddItemsNavigationController ()

@end

@implementation ViewAddItemsNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSDictionary *dict = (NSDictionary *)sender;
    
    UINavigationController *navigationController = (UINavigationController*)segue.destinationViewController;
    
    ViewAddItemsViewController *viewControllerObject = (ViewAddItemsViewController *)[[navigationController viewControllers] firstObject];
   
    //
    //
    //BOOL
    viewControllerObject.viewingItemDetails = dict[@"viewingItemDetails"] && [dict[@"viewingItemDetails"] isEqualToString:@"Yes"] ? YES : NO;
    
    //
    //
    //NSString
    viewControllerObject.itemRepeats = dict[@"itemRepeats"] ? dict[@"itemRepeats"] : @"";
    viewControllerObject.optionSelectedString = dict[@"optionSelectedString"] ? dict[@"optionSelectedString"] : @"";
    
    //
    //
    //NSArray
    viewControllerObject.itemsAlreadyChosenArray = dict[@"itemsAlreadyChosenArray"] ? dict[@"itemsAlreadyChosenArray"] : [NSMutableArray array];
    
    //
    //
    //NSDictionary
    viewControllerObject.userDict = dict[@"userDict"] ? dict[@"userDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.itemsAlreadyChosenDict = dict[@"itemsAlreadyChosenDict"] ? dict[@"itemsAlreadyChosenDict"] : [NSMutableDictionary dictionary];
    
}

@end
