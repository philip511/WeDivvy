//
//  ViewPaymentMethodNavigationController.m
//  WeDivvy
//
//  Created by Philip Nagel on 9/8/22.
//

#import "ViewPaymentMethodNavigationController.h"
#import "ViewPaymentMethodViewController.h"

@interface ViewPaymentMethodNavigationController ()

@end

@implementation ViewPaymentMethodNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSDictionary *dict = (NSDictionary *)sender;
    
    UINavigationController *navigationController = (UINavigationController*)segue.destinationViewController;
    
    ViewPaymentMethodViewController *viewControllerObject = (ViewPaymentMethodViewController *)[[navigationController viewControllers] firstObject];
    
    //
    //
    //BOOL
    viewControllerObject.viewingReward = dict[@"viewingReward"] && [dict[@"viewingReward"] isEqualToString:@"Yes"] ? YES : NO;
    viewControllerObject.comingFromAddTaskViewController = dict[@"comingFromAddTaskViewController"] && [dict[@"comingFromAddTaskViewController"] isEqualToString:@"Yes"] ? YES : NO;
    
    //
    //
    //NSDictionary
    viewControllerObject.itemPaymentMethodDict = dict[@"itemPaymentMethodDict"] ? dict[@"itemPaymentMethodDict"] : [NSMutableDictionary dictionary];
    
    
}

@end
