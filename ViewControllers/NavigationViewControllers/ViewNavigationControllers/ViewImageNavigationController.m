//
//  ViewImageNavigationController.m
//  WeDivvy
//
//  Created by Philip Nagel on 10/18/23.
//

#import "ViewImageNavigationController.h"
#import "ViewImageViewController.h"

@interface ViewImageNavigationController ()

@end

@implementation ViewImageNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSDictionary *dict = (NSDictionary *)sender;
    
    UINavigationController *navigationController = (UINavigationController*)segue.destinationViewController;
    
    ViewImageViewController *viewControllerObject = (ViewImageViewController *)[[navigationController viewControllers] firstObject];
    
    //
    //
    //UIImage
    viewControllerObject.itemImage = dict[@"itemImage"] ? dict[@"itemImage"] : nil;

}

@end
