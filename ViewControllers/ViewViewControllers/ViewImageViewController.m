//
//  ViewImageViewController.m
//  WeDivvy
//
//  Created by Philip Nagel on 6/7/21.
//

#import "ViewImageViewController.h"

#import "GeneralObject.h"
#import "SetDataObject.h"
#import "BoolDataObject.h"
#import "LightDarkModeObject.h"

@interface ViewImageViewController ()

@end

@implementation ViewImageViewController

#pragma mark - System Methods

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self InitMethod];
    
    [self BarButtonItems];
    
}

-(void)viewWillLayoutSubviews {
    
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    CGFloat navigationBarHeight = [[[GeneralObject alloc] init] GetNavigationBarHeight:self];

    self->_customImageView.frame = CGRectMake(0, navigationBarHeight, width, height - navigationBarHeight);
 
    if ([[[BoolDataObject alloc] init] DarkModeIsOn]) {
        
        self.view.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        self.navigationController.navigationBar.backgroundColor = [[[LightDarkModeObject alloc] init] DarkModeSecondary];
        
    } else {
        
        self.view.backgroundColor = [UIColor whiteColor];
        self.navigationController.navigationBar.backgroundColor = [[[LightDarkModeObject alloc] init] LightModePrimary];
        
    }
    
}

#pragma mark - Init Methods

-(void)InitMethod {
    
    [self SetUpAnalytics];
    
    [self SetUpImageView];
    
}

-(void)BarButtonItems {
    
    self.navigationItem.hidesBackButton = YES;
        
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(NavigationBackButtonAction:)];
   
    self.navigationItem.leftBarButtonItem = barButtonItem;
    
}

#pragma mark - Setup Methods

-(void)SetUpAnalytics {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewViewController:@"ViewImageViewController" completionHandler:^(BOOL finished) {
        
    }];
    
}

-(void)SetUpImageView {
   
    _customImageView.image = _itemImage;
    _customImageView.contentMode = UIViewContentModeScaleAspectFit;
    
}

#pragma mark - IBAction Methods

-(IBAction)NavigationBackButtonAction:(UIBarButtonItem *)sender {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewTouchEvent:self touchEvent:[NSString stringWithFormat:@"Navigation Back Button Clicked For %@", [[[GeneralObject alloc] init] GenerateItemType]] completionHandler:^(BOOL finished) {
        
    }];
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}

@end
