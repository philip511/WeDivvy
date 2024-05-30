//
//  ViewVideoViewController.m
//  WeDivvy
//
//  Created by Philip Nagel on 10/13/21.
//

#import "ViewVideoViewController.h"

#import "SetDataObject.h"
#import "BoolDataObject.h"
#import "LightDarkModeObject.h"
#import "GeneralObject.h"

@interface ViewVideoViewController ()

@end

@implementation ViewVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self InitMethod];
 
}

-(void)viewWillLayoutSubviews {
    
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
 
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
    
    [self SetUpPlayer];
    
}

#pragma mark - Setup Methods

-(void)SetUpAnalytics {
    
    [[[SetDataObject alloc] init] SetDataFIRStoreAnalyticsNewViewController:@"ViewVideoViewController" completionHandler:^(BOOL finished) {
        
    }];
    
}

-(void)SetUpPlayer {
    
    AVPlayer *player = [AVPlayer playerWithURL:[NSURL URLWithString:_videoURLString]];
    
    self.player = player;
    [player play];
    
}

@end
