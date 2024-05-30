//
//  ViewTagsNavigationController.m
//  WeDivvy
//
//  Created by Philip Nagel on 9/8/22.
//

#import "ViewTagsNavigationController.h"
#import "ViewTagsViewController.h"

@interface ViewTagsNavigationController ()

@end

@implementation ViewTagsNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSDictionary *dict = (NSDictionary *)sender;
    
    UINavigationController *navigationController = (UINavigationController*)segue.destinationViewController;
    
    ViewTagsViewController *viewControllerObject = (ViewTagsViewController *)[[navigationController viewControllers] firstObject];
  
    //
    //
    //BOOL
    viewControllerObject.viewingItemDetails = dict[@"viewingItemDetails"] && [dict[@"viewingItemDetails"] isEqualToString:@"Yes"] ? YES : NO;
    viewControllerObject.comingFromAddTaskViewController = dict[@"comingFromAddTaskViewController"] && [dict[@"comingFromAddTaskViewController"] isEqualToString:@"Yes"] ? YES : NO;
    viewControllerObject.comingFromViewTaskViewController = dict[@"comingFromViewTaskViewController"] && [dict[@"comingFromViewTaskViewController"] isEqualToString:@"Yes"] ? YES : NO;
    
    //
    //
    //NSArray
    viewControllerObject.itemsAlreadyChosenArray = dict[@"itemsAlreadyChosenArray"] ? dict[@"itemsAlreadyChosenArray"] : [NSMutableArray array];
    viewControllerObject.allItemTagsArrays = dict[@"allItemTagsArrays"] ? dict[@"allItemTagsArrays"] : [NSMutableArray array];
    
}

@end
