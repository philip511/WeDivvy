//
//  WeDivvyPremiumNavigationController.m
//  WeDivvy
//
//  Created by Philip Nagel on 12/5/22.
//

#import "WeDivvyPremiumNavigationController.h"
#import "WeDivvyPremiumViewController.h"

@interface WeDivvyPremiumNavigationController ()

@end

@implementation WeDivvyPremiumNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSDictionary *dict = (NSDictionary *)sender;
    
    UINavigationController *navigationController = (UINavigationController*)segue.destinationViewController;
    
    WeDivvyPremiumViewController *viewControllerObject = (WeDivvyPremiumViewController *)[[navigationController viewControllers] firstObject];
    
    //
    //
    //BOOL
    viewControllerObject.viewingSlideShow = dict[@"viewingSlideShow"] && [dict[@"viewingSlideShow"] isEqualToString:@"Yes"] ? YES : NO;
    viewControllerObject.comingFromSignUp = dict[@"comingFromSignUp"] && [dict[@"comingFromSignUp"] isEqualToString:@"Yes"] ? YES : NO;
    
    //
    //
    //NSString
    viewControllerObject.defaultPlan = dict[@"defaultPlan"] ? dict[@"defaultPlan"] : @"";
    viewControllerObject.displayDiscount = dict[@"displayDiscount"] ? dict[@"displayDiscount"] : @"";
    viewControllerObject.selectedSlide = dict[@"selectedSlide"] ? dict[@"selectedSlide"] : @"";
    viewControllerObject.promoCodeID = dict[@"promoCodeID"] ? dict[@"promoCodeID"] : @"";
    
    //
    //
    //NSArray
    viewControllerObject.premiumPlanProductsArray = dict[@"premiumPlanProductsArray"] ? dict[@"premiumPlanProductsArray"] : [NSMutableArray array];
    
    //
    //
    //NSDictionary
    viewControllerObject.premiumPlanPricesDict = dict[@"premiumPlanPricesDict"] ? dict[@"premiumPlanPricesDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.premiumPlanExpensivePricesDict = dict[@"premiumPlanExpensivePricesDict"] ? dict[@"premiumPlanExpensivePricesDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.premiumPlanPricesDiscountDict = dict[@"premiumPlanPricesDiscountDict"] ? dict[@"premiumPlanPricesDiscountDict"] : [NSMutableDictionary dictionary];
    viewControllerObject.premiumPlanPricesNoFreeTrialDict = dict[@"premiumPlanPricesNoFreeTrialDict"] ? dict[@"premiumPlanPricesNoFreeTrialDict"] : [NSMutableDictionary dictionary];
    
}

@end
