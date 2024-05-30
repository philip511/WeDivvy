//
//  ViewMutableOptionsNavigationController.m
//  WeDivvy
//
//  Created by Philip Nagel on 9/22/22.
//

#import "ViewMutableOptionsNavigationController.h"
#import "ViewMutableOptionsViewController.h"

@interface ViewMutableOptionsNavigationController ()

@end

@implementation ViewMutableOptionsNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSDictionary *dict = (NSDictionary *)sender;
    
    UINavigationController *navigationController = (UINavigationController*)segue.destinationViewController;
    
    ViewMutableOptionsViewController *viewControllerObject = (ViewMutableOptionsViewController *)[[navigationController viewControllers] firstObject];
    
    //
    //
    //BOOL
    viewControllerObject.viewingSections = dict[@"viewingSections"] && [dict[@"viewingSections"] isEqualToString:@"Yes"] ? YES : NO;
    viewControllerObject.viewingFolders = dict[@"viewingFolders"] && [dict[@"viewingFolders"] isEqualToString:@"Yes"] ? YES : NO;
    
    //
    //
    //NSArray
    viewControllerObject.homeMembersArray = dict[@"homeMembersArray"] ? dict[@"homeMembersArray"] : [NSMutableArray array];
    viewControllerObject.allItemTagsArrays = dict[@"allItemTagsArrays"] ? dict[@"allItemTagsArrays"] : [NSMutableArray array];
    
    //
    //
    //NSDictionary
    viewControllerObject.itemsAlreadyChosenDict = dict[@"itemsAlreadyChosenDict"] ? dict[@"itemsAlreadyChosenDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.itemsDict = dict[@"itemsDict"] ? dict[@"itemsDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.homeMembersDict = dict[@"homeMembersDict"] ? dict[@"homeMembersDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.itemOccurrencesDict = dict[@"itemOccurrencesDict"] ? dict[@"itemOccurrencesDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.foldersDict = dict[@"foldersDict"] ? dict[@"foldersDict"] : [NSMutableDictionary dictionary];
    
}

@end
