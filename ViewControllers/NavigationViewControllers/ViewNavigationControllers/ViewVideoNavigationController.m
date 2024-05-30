//
//  ViewVideoNavigationController.m
//  WeDivvy
//
//  Created by Philip Nagel on 10/18/23.
//

#import "ViewVideoNavigationController.h"
#import "ViewVideoViewController.h"

@interface ViewVideoNavigationController ()

@end

@implementation ViewVideoNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSDictionary *dict = (NSDictionary *)sender;
    
    UINavigationController *navigationController = (UINavigationController*)segue.destinationViewController;
    
    ViewVideoViewController *viewControllerObject = (ViewVideoViewController *)[[navigationController viewControllers] firstObject];
    
    //
    //
    //NSString
    viewControllerObject.videoURLString = dict[@"videoURLString"] ? dict[@"videoURLString"] : @"";
    
}

@end
